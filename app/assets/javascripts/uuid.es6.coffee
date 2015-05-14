UUID =
  generate: (prefix = '') ->
    id = Math.random() * 0x100000000000
    if prefix
      "#{prefix}_#{id}"
    else
      "#{id}"

`export default UUID`
