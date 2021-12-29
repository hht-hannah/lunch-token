# Lunch Token Sharing

## Quick start on server

The first things you need to do are cloning this repository and installing its
dependencies:

```sh
git clone https://github.com/nomiclabs/hardhat-hackathon-boilerplate.git
cd hardhat-hackathon-boilerplate
npm install
```

Once installed, let's run Hardhat's testing network:

```sh
npx hardhat node
```

Then, on a new terminal, go to the repository's root folder and run this to
deploy your contract:

```sh
npx hardhat run scripts/deploy.js --network localhost
```

Finally, we can run the frontend with:

```sh
cd frontend
npm install
npm start
```

> Note: There's [an issue in `ganache-core`](https://github.com/trufflesuite/ganache-core/issues/650) that can make the `npm install` step fail. 
>
> If you see `npm ERR! code ENOLOCAL`, try running `npm ci` instead of `npm install`.

Open [http://localhost:3000/](http://localhost:3000/) to see your Dapp. You will
need to have [Metamask](https://metamask.io) installed and listening to
`localhost 8545`.

## User Guide

Before lunch
```sh
  initiaze project
  initiaze account for each participants [Use Transfer]
    participants need to exchange HKD with LunchToken with exchange rate of 1:1
```
Social Network
```sh
  Participants can add each other as friends [Add Friends] 
  Participants can delete each friends from his/her social network [Delete Friends]
```
After lunch - Before Create Lunch Event
```sh
  Any participant can launch the [CreateLunch Event] with two options:
    1:Split bills with participants' wallet address
    2:Split bills with friends [By clicking which friend you want to split with]
```

After lunch - After Create Lunch Event
```sh
    The launcher of the Lunch Event can track whether particiants have pay the bills or not
    [Pendings To Receive]: The bills others owe you
    [Pendings To Send]: The bills you owe others
```

Further Improvements:
```sh
    1:Reminding Letter:Once bills haven't received/send for a certain period of time, then send the reminding letter to user's corresponding email address.
    2:
```