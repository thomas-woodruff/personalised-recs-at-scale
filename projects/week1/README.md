# Week 1 project
# Candidate generation

## Submission notebook

- `projects/week1/Submission.ipynb` includes the code discussed here
- You can find the `requirements.txt` for this notebook in the top level of the git repo

## Data

- The dataset is not included in the repo as it is too large
- Download the dataset hmdata.zip from [here](https://drive.google.com/drive/folders/10LGZMgXRuz2qPr_QDbYdVVlKEcnQ25YL?usp=sharing)
- Place data in `projects/week1/hmdata`
<br/><br/>
- Unlike the project walkthrough, I only used 6 weeks of data for training (2020-08-05 to 2020-09-15) and 1 week of data for evaluation (2020-09-16 to 2020-09-23)
- This was partly to ensure the notebook ran quickly on my local machine and partly inspired by the H&M Personalized Fashion Recommendations Kaggle [competition winner](https://www.kaggle.com/competitions/h-and-m-personalized-fashion-recommendations/discussion/324070)


## Candidate generators

- Alongside the two heuristic candidate generators provided in the walkthrough, random and most popular, I implemented two further ones as suggested:
  - Most popular articles from categories the user has previously interacted with
  - Most popular articles near the user's mean purchased article price
- Both of these are very simple and could obviously be improved upon with some trial and error
- For example, preferred price range probably has a strong category interaction - leveraging these relationships would likely improve the results
<br/><br/>
- I experimented with some of the hyperparameters for the two tower model, such as learning rate and batch size
- I also removed the non-linear fully-connected layers after the embedding layers
- This was motivated by observations of how the validation loss changed during training for various settings
- Clearly to get the most out of this model would require a more principled hyperparameter search as well as experimenting with the lookback of the training data
<br/><br/>
- Beyond this, it would have been interesting to add some simple features to the model that capture information about the customers and articles
- Potential customer features could include age, previous spends on related categories etc.
- Potential article features could include content information such as garment type etc.
- The [TensorFlow Recommender tutorials](https://www.tensorflow.org/recommenders/examples/featurization) have some good examples of how to add features to these models
- Unfortunately these experiments were beyond the time restrictions I had this week

## Evaluation

- The results for recall@100 and recall@1000 for the various strategies discussed are shown below
- These results were generated using 1,000 customers common to the train and test data

### Recall@100

| Strategy | Recall |
| -------- | ------ |
| Random | 0.002 |
| Most popular | 0.081 |
| Most popular customer category | 0.080 |
| Most popular customer price range | 0.061 |
| Two tower | 0.000 |


### Recall@1000

| Strategy | Recall |
| -------- | ------ |
| Random | 0.028 |
| Most popular | 0.325 |
| Most popular customer category | 0.269 |
| Most popular customer price range | 0.202 |
| Two tower | 0.002 |

### Remarks

- Most popular is the most successful strategy for recall@100 and recall@1000
  - This was not the case in the project walkthrough, where the two tower approach won
  - This could be due to the shorter period used for the training data (6 weeks) leading to more relevant candidates surfaced by the most popular strategy
- The two new heuristic approaches based on customer category and price preferences do not outperform most popular
  - As previously discussed, these strategies are likely too simplistic to beat most popular
- The two tower approach does very poorly
  - This isn't surprising given the static validation loss during training
  - Perhaps by using less training data (6 weeks versus 9 months) we have restricted the model's ability to learn good customer representations