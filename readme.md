## Observed Facts

- each `mco_desc` can have separate malloc/free functions
- the library itself doesn't allocate

Feature flags
- MCO_ZERO_MEMORY
- MCO_DEBUG unless NDEBUG or MCO_NO_DEBUG
- MCO_MIN_STACK_SIZE
- MCO_DEFAULT_STORAGE_SIZE (push/pop)
- MCO_DEFAULT_STACK_SIZE
