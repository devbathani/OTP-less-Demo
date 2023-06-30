<template>
  <img alt="Vue logo" src="./assets/otpless_icon.png" />
</template>

<script>
export default {
  /************************************* */
  // This is the main function that will be called when the user clicks on the button
  /************************************* */
  mounted() {
    window.otpless = (otplessUser) => {
      alert(JSON.stringify(otplessUser));
    };
  },
  name: "App",
};
</script>

<style>
#app {
  align-items: center;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 350px;
}
</style>
