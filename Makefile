-include .env

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(SEPOLIA_PRIVATE_KEY) \
		--broadcast \
		-vvvv

deploy-polygon:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(PLOYGON_AMOY_RPC_URL) --private-key $(POLYGON_PRIVATE_KEY) --broadcast

