Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2D444F37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKDGvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:51:16 -0400
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:47009
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbhKDGuG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNw03sv6yOAxqC0Qeke/lMAPMMxU37uhkYcNFThKx1KyV0mSxN+NxnbVkKhVI6nPDo+AV7EgwAvFFiKtUKJObE/xCM2W/pI3gp4D8slSrMKa0rbyjW8y06Fsih5bwR0HHEpjbu3zOPSHcDjPlTA7GRcK6WlMCQoDUVQeUtCSmn9gYQS7UibZ6Xjw1f/Kx12coP9QcPabUXXpFs4n36gT1NeDfRQ/rOsMdJIuHGu55uS/2QjY4HvljNpJagqw/sVmP9CGg2KpZ6OLo/ii4geAa1bciZARrukLtLjvByQmwvXxIZ+1kJQ88vKzssrq2XYa90on85zKEhOJ3HeCX+yIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzkvyrZQGecBWWu5cQbYLpZWloO/z8LKS+RChfb1jZ4=;
 b=ACsLo+PP39+oM2uTCJGQQXaWV5uh4KIXOkhyWjDRDdajvjrF3XB1+UdikdrlOYk9PbLvhE/AfU6a3WYcoW4A9/2Bzpj9R7yV935HiSsPVn+HVEMGJEU0TOfEGU5g/jEmCVlWTLPJe5/s/bWU3fnrwvotKyr1dqeGbCIopIBEm5Z95Uv0UT9GVB8sDd4CVEs7XulIdQj3s/vR5ZJS0SQdWKvGsfe4vQ6Kr9z+MjDnB7H/oSz72zAYphLD2cZ8nitK580Ek1VrKG1PnZB8HBqxWKiLrEQ9mpimcjBwpA2aXsptMfE/N15v4IMvrwaShI6MWBpobqq58RYVINU+xYimfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzkvyrZQGecBWWu5cQbYLpZWloO/z8LKS+RChfb1jZ4=;
 b=rvZbHlxPDiwiWjWqvk0h+ayggdTxNNs9gNRCIVsY3T6lUq7Rw0dyEFfgup+TVlnZGGsycxVB+CI4l9Sh2UJ5gKQjV0LRVQGJfrQlG1n3WN54xuDSFICLO2DlXhnFQTZqOHWmjdsd2a6r5PL/uC3ZYpGUxIw0LiXp0ZJwVMYRnYzQbY9hMgebI2OAb9Cft6TTYeZDBypwIm5MS+j9hUuuBsy5XGo3QFTtGmJMQE5Uj3d8kci+9HcmVk59H+5Y9WFDczlfupjLJmEf3ZDSqGFxYrUf7Bl15x9SOkdv8ZboAqrd0GSGbwj9vbfgLtse18yS/UVkjfe3g8H+SWkZ3VLjjg==
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 06:47:26 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2b) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 06:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:47:24 +0000
Received: from dev.nvidia.com (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:47:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@redhat.com>,
        <song@kernel.org>, <djwong@kernel.org>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <osandov@fb.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 2/8] scsi: add REQ_OP_VERIFY support
Date:   Wed, 3 Nov 2021 23:46:28 -0700
Message-ID: <20211104064634.4481-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ac02d0-1700-42ae-15c3-08d99f5ef585
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5341ABF93E80986C0583AC37A38D9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+53OUy59cS/uSmDZSCGJU2KvFqthHmmZMneEYFyfYl7c38hrX35h6sTKLip6j9weUmd8D2Nol9W8LIfrh2LcxFvam4OApQi2z93Od9yYy83UIjTz/oAW3AvHHUIGUYd+RLqy1+SVKSesfvSZSsG3Fw18AymIAm7gIV+sMQYwNlKp3fkqW68+R7gR9/FLebse/u73XSc0pbu3cdseLaH3c67Wj53S5zZDtLCzbrZa1DPArGMaHGL88J5UqEqmD5G+c4dhyzSset20lFtQ51B7KLEfYHy0xFQoaHgxd3QFJZD2f8y9wBayrufiVvaMdnqJiMDEItRn44F8BIQC/N0CYPLRVmYRIO1uPzU0f8/+aEK7N+NPCojipbmdb1b8COe6zfQ3qMudVHlms7yB2oD52+eumgFSbNcbzsZB5Q2zOBPdvUgZoCxCBMqomS78j//T9b53L1Rs39EDClTYojzLfDhW88jA57xJ8tKurIZI1+m4k0j+oRvBZWto6ovigc2OwHRSz5Vinat0V/Dxa1jFx9scBPMoneOJoElnckO9Xeyd02FW1mGr4x2hXTS87ijzjcwKEsuZ/uVO2hxiN1C1QvC0jTCDnpPLLRSulxz1aTtz2h78MozaVySnRpAqifyiWax7WQV2dJHou+YctEwNMr0l0BxPIuQ9cWyaXCs7wyjJPNImkzldJ3XN5Z9w0Dj9hlHyJleKV2q1gjrLa0mDT5H4bBjcH6qQXeSk2WiRhcbuvPAwHEPi1r7SMBidFsO
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(8936002)(16526019)(86362001)(508600001)(54906003)(47076005)(2616005)(83380400001)(1076003)(4326008)(336012)(426003)(186003)(7696005)(82310400003)(7416002)(36860700001)(356005)(5660300002)(2906002)(107886003)(36756003)(316002)(70586007)(26005)(36906005)(70206006)(7406005)(8676002)(7636003)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:47:24.3298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ac02d0-1700-42ae-15c3-08d99f5ef585
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/scsi/sd.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3d2d4bc4a3d..7f2c4eb98cf8 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -106,6 +106,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
 
 static void sd_config_discard(struct scsi_disk *, unsigned int);
 static void sd_config_write_same(struct scsi_disk *);
+static void sd_config_verify(struct scsi_disk *sdkp);
 static int  sd_revalidate_disk(struct gendisk *);
 static void sd_unlock_native_capacity(struct gendisk *disk);
 static int  sd_probe(struct device *);
@@ -995,6 +996,41 @@ static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 	return sd_setup_write_same10_cmnd(cmd, false);
 }
 
+static void sd_config_verify(struct scsi_disk *sdkp)
+{
+	struct request_queue *q = sdkp->disk->queue;
+
+	/* XXX: use same pattern as sd_config_write_same(). */
+	blk_queue_max_verify_sectors(q, UINT_MAX >> 9);
+}
+
+static blk_status_t sd_setup_verify_cmnd(struct scsi_cmnd *cmd)
+{
+       struct request *rq = cmd->request;
+       struct scsi_device *sdp = cmd->device;
+       struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+       u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
+       u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
+
+       if (!sdkp->verify_16)
+	       return BLK_STS_NOTSUPP;
+
+       cmd->cmd_len = 16;
+       cmd->cmnd[0] = VERIFY_16;
+       /* skip veprotect / dpo / bytchk */
+       cmd->cmnd[1] = 0;
+       put_unaligned_be64(lba, &cmd->cmnd[2]);
+       put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
+       cmd->cmnd[14] = 0;
+       cmd->cmnd[15] = 0;
+
+       cmd->allowed = SD_MAX_RETRIES;
+       cmd->sc_data_direction = DMA_NONE;
+       cmd->transfersize = 0;
+
+       return BLK_STS_OK;
+}
+
 static void sd_config_write_same(struct scsi_disk *sdkp)
 {
 	struct request_queue *q = sdkp->disk->queue;
@@ -1345,6 +1381,8 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 		}
 	case REQ_OP_WRITE_ZEROES:
 		return sd_setup_write_zeroes_cmnd(cmd);
+	case REQ_OP_VERIFY:
+		return sd_setup_verify_cmnd(cmd);
 	case REQ_OP_WRITE_SAME:
 		return sd_setup_write_same_cmnd(cmd);
 	case REQ_OP_FLUSH:
@@ -2029,6 +2067,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
@@ -3096,6 +3135,17 @@ static void sd_read_write_same(struct scsi_disk *sdkp, unsigned char *buffer)
 		sdkp->ws10 = 1;
 }
 
+static void sd_read_verify(struct scsi_disk *sdkp, unsigned char *buffer)
+{
+       struct scsi_device *sdev = sdkp->device;
+
+       sd_printk(KERN_INFO, sdkp, "VERIFY16 check.\n");
+       if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, VERIFY_16) == 1) {
+	       sd_printk(KERN_INFO, sdkp, " VERIFY16 in ON .\n");
+               sdkp->verify_16 = 1;
+       }
+}
+
 static void sd_read_security(struct scsi_disk *sdkp, unsigned char *buffer)
 {
 	struct scsi_device *sdev = sdkp->device;
@@ -3224,6 +3274,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_cache_type(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
+		sd_read_verify(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
 	}
 
@@ -3265,6 +3316,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
+	sd_config_verify(sdkp);
 	kfree(buffer);
 
 	/*
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index b59136c4125b..94a86bf6dac4 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -120,6 +120,7 @@ struct scsi_disk {
 	unsigned	lbpvpd : 1;
 	unsigned	ws10 : 1;
 	unsigned	ws16 : 1;
+	unsigned        verify_16 : 1;
 	unsigned	rc_basis: 2;
 	unsigned	zoned: 2;
 	unsigned	urswrz : 1;
-- 
2.22.1

