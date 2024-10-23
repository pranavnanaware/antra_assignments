// ---------------------------------------------------------------------------
// 1. Sum All Salaries
// ---------------------------------------------------------------------------
let salaries = {
  John: 100,
  Ann: 160,
  Pete: 130
};

let sum = Object.values(salaries).reduce((acc, salary) => acc + salary, 0);

// ---------------------------------------------------------------------------
// 2. Multiply Numeric Properties by 2
// ---------------------------------------------------------------------------
function multiplyNumeric(obj) {
  for (let key in obj) {
    if (typeof obj[key] === 'number') {
      obj[key] *= 2;
    }
  }
}

let menu = {
  width: 200,
  height: 300,
  title: "My menu"
};

multiplyNumeric(menu);

// ---------------------------------------------------------------------------
// 3. Check Email ID Validity
// ---------------------------------------------------------------------------
function checkEmailId(str) {
  const regex = /^[^@.]+@[^@.]+\.[^@.]+$/i;
  return regex.test(str);
}

// ---------------------------------------------------------------------------
// 4. Truncate a String with Ellipsis
// ---------------------------------------------------------------------------
function truncate(str, maxlength) {
  const ellipsis = '...';
  if (str.length > maxlength) {
    return str.slice(0, maxlength - ellipsis.length) + ellipsis;
  } else {
    return str;
  }
}

// ---------------------------------------------------------------------------
// 5. Array Operations
// ---------------------------------------------------------------------------
let styles = ["James", "Brennie"];

styles.push("Robert");

if (styles.length % 2 !== 0) {
  let middleIndex = Math.floor(styles.length / 2);
  styles[middleIndex] = "Calvin";
}

let removed = styles.shift();

styles.unshift("Rose", "Regal");
