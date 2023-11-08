Tested with Zig 0.11.0

## Library Behavior

- each `mco_desc` can have separate malloc/free functions
- the library itself doesn't allocate

# Supported Feature flags
- MCO_ZERO_MEMORY
- MCO_DEBUG unless NDEBUG or MCO_NO_DEBUG
- MCO_MIN_STACK_SIZE
- MCO_DEFAULT_STORAGE_SIZE (push/pop)
- MCO_DEFAULT_STACK_SIZE
