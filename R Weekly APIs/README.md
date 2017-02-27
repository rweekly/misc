## Submit

### Call

visit this URL:

https://api.rweekly.org/submit?**url**=**alink**&**desc**=**sometexts**&**email**=**email**


### Respond

success:

```json
{
    "url": "your url",
    "num_today": 3 // about how many links this IP submitted, at most 10 links per IP per day 
}
```

fail:

```json
{
    error: "error message"
}
```

over rate limit:

```json
{
    error: "rate limited"
}
```
