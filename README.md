# dbt-ml-eval

This dbt package provides a suite of evaluation macros for machine learning model metrics — classification and regression — designed to be used inline inside SELECT statements in your dbt models.

## Installation

Add this package to your `packages.yml` or `dependencies.yml` in your dbt project:

```yaml
packages:
  - package: "Matts52/dbt_ml_eval"
    version: [">=0.1.0"]
```

Then run:

```bash
dbt deps
```

## Current supported tested databases

---

## Quick Usage

Produce a summary of classification metrics:

```sql
select
  {{ dbt_ml_eval.classification_metrics('actual', 'predicted', positive_label=1) }}
from {{ ref('my_predictions') }}
```

Produce a summary of regression metrics:

```sql
select
  {{ dbt_ml_eval.regression_metrics('actual', 'predicted') }}
from {{ ref('my_regression_predictions') }}
```

Call specific measures:

```sql
select
  {{ dbt_ml_eval.accuracy('actual', 'predicted') }} as accuracy,
  {{ dbt_ml_eval.precision('actual', 'predicted') }} as precision,
  {{ dbt_ml_eval.recall('actual', 'predicted') }} as recall
from {{ ref('my_predictions') }}
```

---

**Current supported tested databases include:**
- Postgres
- DuckDB

| **Method**                       | **Postgres** | **DuckDB** |
|----------------------------------|--------------|------------|
| `true_positives`                 | ✅           | ✅         |
| `false_positives`                | ✅           | ✅         |
| `true_negatives`                 | ✅           | ✅         |
| `false_negatives`                | ✅           | ✅         |
| `accuracy`                       | ✅           | ✅         |
| `precision`                      | ✅           | ✅         |
| `recall`                         | ✅           | ✅         |
| `f1_score`                       | ✅           | ✅         |
| `jaccard_index`                  | ✅           | ✅         |
| `matthews_correlation`           | ✅           | ✅         |
| `positive_likelihood_ratio`      | ✅           | ✅         |
| `negative_likelihood_ratio`      | ✅           | ✅         |
| `diagnostic_odds_ratio`          | ✅           | ✅         |
| `informedness`                   | ✅           | ✅         |
| `markedness`                     | ✅           | ✅         |
| `prevalence`                     | ✅           | ✅         |
| `mean_absolute_error`            | ✅           | ✅         |
| `mean_squared_error`             | ✅           | ✅         |
| `root_mean_squared_error`        | ✅           | ✅         |
| `mean_absolute_percentage_error` | ✅           | ✅         |
| `r2_score`                       | ✅           | ✅         |
| `explained_variance`             | ✅           | ✅         |
| `median_absolute_error`          | ✅           | ✅         |
| `mean_bias_error`                | ✅           | ✅         |

---

## Quick usage

All macros in this package are intended to be used inline in a SELECT. Example:

```sql
select
  {{ dbt_ml_eval.accuracy('actual', 'predicted') }} as accuracy,
  {{ dbt_ml_eval.precision('actual', 'predicted') }} as precision,
  {{ dbt_ml_eval.recall('actual', 'predicted') }} as recall
from {{ ref('your_training_data') }}
```

Note: macro names above match the names in the `macros/.../schema.yml` files. Many macros accept an optional `positive_label` argument (default = 1) when they operate on binary classification labels.

---

## Contents

- Classification metrics (counts + rates + derived scores)
- Regression metrics
- Convenience / consolidated macros

---

## Macro index

A compact index of all macros in this package and their signatures. Use this for quick lookup.

### Classification
- `true_positives(actual, predicted, positive_label=1)`
- `false_positives(actual, predicted, positive_label=1)`
- `true_negatives(actual, predicted, positive_label=1)`
- `false_negatives(actual, predicted, positive_label=1)`
- `accuracy(actual, predicted)`
- `precision(actual, predicted, positive_label=1)`
- `recall(actual, predicted, positive_label=1)`
- `true_positive_rate(actual, predicted, positive_label=1)`
- `true_negative_rate(actual, predicted, positive_label=1)`
- `false_positive_rate(actual, predicted, positive_label=1)`
- `false_negative_rate(actual, predicted, positive_label=1)`
- `positive_predictive_value(actual, predicted, positive_label=1)`
- `negative_predictive_value(actual, predicted, positive_label=1)`
- `false_discovery_rate(actual, predicted, positive_label=1)`
- `false_omission_rate(actual, predicted, positive_label=1)`
- `f1_score(actual, predicted, positive_label=1)`
- `jaccard_index(actual, predicted, positive_label=1)`
- `fowlkes_mallows_index(actual, predicted, positive_label=1)`
- `matthews_correlation(actual, predicted, positive_label=1)`
- `positive_likelihood_ratio(actual, predicted, positive_label=1)`
- `negative_likelihood_ratio(actual, predicted, positive_label=1)`
- `diagnostic_odds_ratio(actual, predicted, positive_label=1)`
- `informedness(actual, predicted, positive_label=1)`
- `markedness(actual, predicted, positive_label=1)`
- `prevalence(actual, positive_label=1)`
- `prevalence_threshold(actual, predicted, positive_label=1)`

### Regression
- `mean_absolute_error(actual, predicted)`
- `mean_squared_error(actual, predicted)`
- `root_mean_squared_error(actual, predicted)`
- `mean_absolute_percentage_error(actual, predicted)`
- `r2_score(actual, predicted)`
- `explained_variance(actual, predicted)`
- `median_absolute_error(actual, predicted)`
- `mean_bias_error(actual, predicted)`

### Consolidated
- `classification_metrics(actual, predicted, positive_label=1)`
- `regression_metrics(actual, predicted)`

---

## Notation used in formulas

We use the standard binary classification contingency-table counts:

- $TP$ = true positives (predicted positive and actual positive)
- $FP$ = false positives (predicted positive and actual negative)
- $TN$ = true negatives (predicted negative and actual negative)
- $FN$ = false negatives (predicted negative and actual positive)
- $N$ = total observations = $TP + TN + FP + FN$

When macros accept `actual` and `predicted` arguments, they compute these counts across the input rows. Where `positive_label` is present, the macros treat that value as the positive class.

---

## Classification macros

Below are the classification macros declared in `macros/classification/schema.yml`. Each entry lists the macro name, a short description, arguments, and (where applicable) the mathematical formula.

### Counts

- `true_positives(actual, predicted, positive_label=1)`
  - Count of rows where both `predicted == positive_label` and `actual == positive_label`.
  - Formula: $TP$

- `false_positives(actual, predicted, positive_label=1)`
  - Count of rows where `predicted == positive_label` and `actual != positive_label`.
  - Formula: $FP$

- `true_negatives(actual, predicted, positive_label=1)`
  - Count of rows where `predicted != positive_label` and `actual != positive_label`.
  - Formula: $TN$

- `false_negatives(actual, predicted, positive_label=1)`
  - Count of rows where `predicted != positive_label` and `actual == positive_label`.
  - Formula: $FN$


### Core rates and simple metrics

- `accuracy(actual, predicted)`
  - Proportion of correct predictions.
  - Formula:

  $$\text{Accuracy} = \frac{TP + TN}{N}$$

- `precision(actual, predicted, positive_label=1)`
  - Positive predictive value: proportion of predicted positives that are correct.
  - Formula:

  $$\text{Precision} = \text{PPV} = \frac{TP}{TP + FP}$$

- `recall(actual, predicted, positive_label=1)`
  - True positive rate / sensitivity: proportion of actual positives correctly identified.
  - Formula:

  $$\text{Recall} = \text{TPR} = \frac{TP}{TP + FN}$$

- `true_positive_rate(actual, predicted, positive_label=1)`
  - Alias for recall; formula is the same as above.

- `true_negative_rate(actual, predicted, positive_label=1)`
  - Specificity: proportion of actual negatives correctly identified.
  - Formula:

  $$\text{TNR} = \text{Specificity} = \frac{TN}{TN + FP}$$

- `false_positive_rate(actual, predicted, positive_label=1)`
  - Formula:

  $$\text{FPR} = \frac{FP}{FP + TN} = 1 - \text{Specificity}$$

- `false_negative_rate(actual, predicted, positive_label=1)`
  - Formula:

  $$\text{FNR} = \frac{FN}{FN + TP} = 1 - \text{Recall}$$


### Predictive values and error rates

- `positive_predictive_value(actual, predicted, positive_label=1)`
  - Alias for precision (PPV).
  - Formula: $\text{PPV} = TP / (TP + FP)$

- `negative_predictive_value(actual, predicted, positive_label=1)`
  - NPV: proportion of negative predictions that are correct.
  - Formula:

  $$\text{NPV} = \frac{TN}{TN + FN}$$

- `false_discovery_rate(actual, predicted, positive_label=1)`
  - FDR: proportion of positive predictions that are incorrect.
  - Formula:

  $$\text{FDR} = \frac{FP}{TP + FP} = 1 - \text{Precision}$$

- `false_omission_rate(actual, predicted, positive_label=1)`
  - FOR: proportion of negative predictions that are actually positive.
  - Formula:

  $$\text{FOR} = \frac{FN}{TN + FN} = 1 - \text{NPV}$$


### Composite and derived metrics

- `f1_score(actual, predicted, positive_label=1)`
  - Harmonic mean of precision and recall.
  - Formula:

  $$F_1 = 2 \cdot \frac{\text{Precision} \cdot \text{Recall}}{\text{Precision} + \text{Recall}} = \frac{2TP}{2TP + FP + FN}$$

- `jaccard_index(actual, predicted, positive_label=1)`
  - Jaccard (Intersection over Union) for the positive class.
  - Formula:

  $$J = \frac{TP}{TP + FP + FN}$$

- `fowlkes_mallows_index(actual, predicted, positive_label=1)`
  - Geometric mean of precision and recall; also expressible directly via counts.
  - Formula:

  $$FMI = \sqrt{\text{Precision}\cdot\text{Recall}} = \frac{TP}{\sqrt{(TP + FP)(TP + FN)}}$$

- `matthews_correlation(actual, predicted, positive_label=1)`
  - Matthews correlation coefficient (MCC): a balanced measure that accounts for all four contingency counts.
  - Formula:

  $$\text{MCC} = \frac{TP\cdot TN - FP\cdot FN}{\sqrt{(TP + FP)(TP + FN)(TN + FP)(TN + FN)}}$$


### Likelihood ratios & odds

- `positive_likelihood_ratio(actual, predicted, positive_label=1)`
  - LR+ = sensitivity / FPR.
  - Formula:

  $$\text{LR+} = \frac{\text{TPR}}{\text{FPR}} = \frac{TP/(TP + FN)}{FP/(FP + TN)}$$

- `negative_likelihood_ratio(actual, predicted, positive_label=1)`
  - LR- = FNR / TNR.
  - Formula:

  $$\text{LR-} = \frac{\text{FNR}}{\text{TNR}} = \frac{FN/(TP + FN)}{TN/(TN + FP)}$$

- `diagnostic_odds_ratio(actual, predicted, positive_label=1)`
  - DOR = LR+ / LR-, simplifies to a ratio of cross-products of counts.
  - Formula:

  $$\text{DOR} = \frac{\text{LR+}}{\text{LR-}} = \frac{TP\cdot TN}{FP\cdot FN}$$


### Information measures

- `informedness(actual, predicted, positive_label=1)`
  - Also called Bookmaker Informedness: $\text{TPR} + \text{TNR} - 1$.
  - Formula:

  $$\text{Informedness} = \text{TPR} + \text{TNR} - 1$$

- `markedness(actual, predicted, positive_label=1)`
  - Markedness: $\text{PPV} + \text{NPV} - 1$.
  - Formula:

  $$\text{Markedness} = \text{PPV} + \text{NPV} - 1$$


### Prevalence and threshold

- `prevalence(actual, positive_label=1)`
  - Proportion of rows that belong to the positive class (in the ground-truth `actual` column).
  - Formula:

  $$\text{Prevalence} = \frac{TP + FN}{N}$$

- `prevalence_threshold(actual, predicted, positive_label=1)`
  - Convenience metric that computes a prevalence-derived threshold used for some diagnostics; its exact derivation varies by implementation. Refer to the macro's docstring for details or open an issue if you need a specific closed-form expression.


---

## Regression macros

Below are the regression macros declared in `macros/regression/schema.yml`. Each macro accepts `actual` and `predicted` column names (strings). Formulas are given for the most common ones.

Let $\{y_i\}_{i=1}^n$ be the true values and $\{\hat{y}_i\}_{i=1}^n$ be the predicted values.

Let

$$
\bar{y} = \frac{1}{n} \sum_{i=1}^n y_i.
$$


- `mean_absolute_error(actual, predicted)`
  - MAE: mean absolute error.
  - Formula:

  $$\text{MAE} = \frac{1}{n} \sum_{i=1}^n |y_i - \hat{y}_i|$$

- `mean_squared_error(actual, predicted)`
  - MSE: mean squared error.
  - Formula:

  $$\text{MSE} = \frac{1}{n} \sum_{i=1}^n (y_i - \hat{y}_i)^2$$

- `root_mean_squared_error(actual, predicted)`
  - RMSE: square root of MSE.
  - Formula:

  $$\text{RMSE} = \sqrt{\text{MSE}}$$

- `mean_absolute_percentage_error(actual, predicted)`
  - MAPE: mean absolute percentage error. Note: watch out for zero-valued actuals.
  - Formula:

  $$\text{MAPE} = \frac{1}{n} \sum_{i=1}^n \left|\frac{y_i - \hat{y}_i}{y_i}\right|$$

- `r2_score(actual, predicted)`
  - Coefficient of determination. Expressed as:

  $$R^2 = 1 - \frac{\sum_{i=1}^n (y_i - \hat{y}_i)^2}{\sum_{i=1}^n (y_i - \bar{y})^2}$$

- `explained_variance(actual, predicted)`
  - Explained variance: proportion of variance of $y$ explained by the predictions (related to but not identical to $R^2$ in some edge cases):

  $$\text{Explained Variance} = 1 - \frac{\mathrm{Var}(y - \hat{y})}{\mathrm{Var}(y)}$$

- `median_absolute_error(actual, predicted)`
  - Median of the absolute errors.
  - Formula:

  $$\text{Median AE} = \mathrm{median}\left( |y_i - \hat{y}_i| \right)$$

- `mean_bias_error(actual, predicted)`
  - Mean bias error (MBE): average prediction error (prediction minus actual). Positive values indicate systematic over-prediction.
  - Formula:

  $$\text{MBE} = \frac{1}{n} \sum_{i=1}^n (\hat{y}_i - y_i)$$


---

## Consolidated convenience macros

- `classification_metrics(actual, predicted, positive_label=1)`
  - Emits a wide set of classification counts and metrics (e.g. TP, FP, TN, FN, precision, recall, f1, jaccard, mcc, etc.) as a set of columns. Useful for producing a single-row summary for a dataset.

- `regression_metrics(actual, predicted)`
  - Emits a collection of regression metrics (MAE, MSE, RMSE, R^2, explained variance, median AE, MBE) as columns.

Both consolidated macros delegate to the individual metric macros in this package.

---

## Notes & troubleshooting

- Many macros use safe division to avoid divide-by-zero errors; behavior for zero denominators is implementation-defined in the macro body (commonly returns `NULL` or 0 depending on the metric). Check the macro SQL if you need deterministic fallback behavior.
- When calling macros inside larger SQL expressions, pass the column names as string literals: e.g., `'actual'`, `'predicted'`.
- Several classification macros rely on the four canonical counts ($TP$, $FP$, $TN$, $FN$). If you override the counting behavior for an adapter, ensure your adapter-specific implementation returns consistent counts.

---

## Contributing

Contributions welcome. Open issues or PRs for:
- Missing metrics or alternative definitions
- Adapter-specific SQL optimizations
- Additional unit/integration tests and tuning

When adding a metric, please add:
- A macro in `macros/<classification|regression>/`
- An entry in the corresponding `macros/.../schema.yml` with argument descriptions
- Integration tests in `integration_tests/models/` and `integration_tests/data/` as appropriate
