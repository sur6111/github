'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

/**
 * Workload module for creating medicine records in the supply chain tracking system.
 */
class CreateMedicineWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.txIndex = 0;
    }

    /**
     * Assemble transactions for the workload round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {
        this.txIndex++;
        const drugName = 'Medicine' + this.txIndex.toString();
        const serialNo = 'SERIAL' + this.txIndex.toString();
        const mfgDate = '2023-07-21'; // Set a random manufacturing date as needed.
        const expDate = '2024-12-31'; // Set a random expiry date as needed.
        const companyCRN = 'MAN001'; 

        let args = {
            contractId: 'medtracnet',
            contractVersion: '1.1', // Replace with your actual contract version.
            contractFunction: 'addDrug',
            contractArguments: [drugName, serialNo, mfgDate, expDate, companyCRN],
            timeout: 30 // Set the timeout value as needed.
        };

        await this.sutAdapter.sendRequests(args);
    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
    return new CreateMedicineWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;
