Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A04F3398
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiDEIkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiDEIa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79A4475C
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 01:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBG1vBq4X73l98YBT6DDvvgziTyqT2zqfop9r2GW5xstV2rwRyUafU4sNR951o+Y/oNjFhlhgSd8erXOOjqyBGuP6crBbvTBjkajdjqh3zZfffvp2GuIBkE/8/iX48/uHm9erbsaNqG61gG7sUhMYeWrZlV4fK7YFiu4VbfPH5AzCPxNgFGOygw/zfINua5BOVlqwC8ACJ3mnsEv23diAcLpcKtjndRRaHlfMtNTI53vOUB7kXBLmpHP0WGxR94RwL2yPPQZn5ylkkSCmmftvVhMCy4eAt4oxzKggng2L7y8fjKaqcj5gobbLMc6FAZMr5zyoSWLJb+ShVkmCp0o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfLU4x6R5Y+1GGN8Fy/f0XB2PgQGScvdOmGgsQODchA=;
 b=bpB4h04svzBBx04tMGrkmXYvJMtaRFE9W4/g0Lr1hHG7+q21altLpWjAm1F4/BjzB7QmkyjrZm/hhMFDbbfM6MSn3+3v0K0vgkIK5IHziyUceXbNK2ApnNwI8GWhB7pqhrzhoWoLhJhDu8C0ch8qgSHxxoCZCN02Z8QAeed1WG31Ss9pDAFuYFPnqVaGb1snzxdTL7qnq+loG2PlI3/Wnq/76Ccd6Htbbvi9gE/jharL/OnSc5Glo8646KuAqQpNUbsF73VqBKQ+FToHyanwYKJIVAC+haqr5T6DJAm6fQYzfeDn1DAVWpe0IAuqEWSwshSBt8yZDBt1aL5y445kUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfLU4x6R5Y+1GGN8Fy/f0XB2PgQGScvdOmGgsQODchA=;
 b=A9kcm3Zw9yhvWCDx3OiGOWsYEglf/v6eunOfpV+nwoMIJpGaFi67yBzUXOpmQSsK7g6jmnYTDR+4GhcbAk4qAYNwG9Bd78mk4NS7D3yIUIpAlyvaDgJ1oSlfytWcrFYpGthbAq1/WLnNcOIImww7Lo1uQoritLlvL4gVqt55b2CNxNHqLPeRdaMjmh2Me7zhwBxMlF3hDk8KEJaf7CbFoaYCEovEMPWjumpup0ZB2dFolLPzm9ebch3zxRhuYsrpx42uyzijkhDdb3ZAswfD4J4Ngq+lyNXgwjhM5F7bgGM+9BjDYNAeucm9DrbwpcpCZ0IBRhqjdZ71/uoljGLqAg==
Received: from BN6PR19CA0090.namprd19.prod.outlook.com (2603:10b6:404:133::28)
 by BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 08:22:55 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::f1) by BN6PR19CA0090.outlook.office365.com
 (2603:10b6:404:133::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 08:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 08:22:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 08:22:53 +0000
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 01:22:51 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <willy@infradead.org>, <petrm@nvidia.com>, <idosch@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH] idr: fix incorrect documentation of idr_is_empty()
Date:   Tue, 5 Apr 2022 11:22:38 +0300
Message-ID: <20220405082238.1670867-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61d8dc1-e46b-4b10-3603-08da16dd7bc6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1572F8CF83C19E70E3830170CBE49@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOS4ioSdy0bazie1IWLfJQhTEFYofuNOqGTma3d6QG4naU6FgDFWgHB9HApBk1DNmhcCeWy7ytE7ZPitSIlIArEWG1bLwJ19N+FSqDIKgJ+O6PYOGfvDQwnpszFtJZijf2Xtx1EmZC69H5ujhypa+vMP+8ydqonaEKsEN+cq5M0qyxF7NS1FV75J4cpCKoFBvAAoyBPgZJdFBDdldmjwVjyKLAhR7UocsUMoA4b8Ccit76Dji+QWHljzyZA3T2U5DHbSyubd09YMEP7h3P8vnVK/4YpnPTHKILOsUzgLhGCKpcIxZF06+h9nvW1n/qrjLY/rAYkQl1/tEFQquIfclJItER8mh4ppZd36AKI/GZYd60bkDeL8PM0QcvcNNSbwop6y81t5SBsgNg/MDMpC46oLaE3RR1p5OZrIiiJfZwpAgHEhRVCt8vU5td+TdnXhBKJ6/9rDah+nj3aJB/mo1BoA++VYN0N42wAlLxHJqfdgPwtZLmR/LvU93cR1TVOWM3DGjDE9OTI6zuts5b6S2L98BcCTgvFIwroDoO6RKXrmiiI5G+CMU3M0zJ+HiWS0AiSzn9CRG7ifZ9Ur57hgNwVP1C5wvnrv7gZP1Pk7uYM9QuaZWyb2rPwa/R0MIrunD0Nf6mL4VboajngtMMyTHqrSKsUXEU7m5ZM6k1C4yoprv8NNW0MtjLxWdftz4a2saI1zrvaChrIYjNh3+GY2BQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(508600001)(47076005)(86362001)(426003)(82310400005)(8936002)(107886003)(5660300002)(2616005)(26005)(1076003)(16526019)(186003)(6666004)(4744005)(83380400001)(40460700003)(316002)(36756003)(70206006)(70586007)(2906002)(8676002)(4326008)(81166007)(356005)(36860700001)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 08:22:54.4955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61d8dc1-e46b-4b10-3603-08da16dd7bc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function idr_is_empty() returns true in case that the IDR is empty,
which means that there is no ID which is allocated from this IDR.
Currently, the documentation is incorrect and describes the opposite
situation. Fix it.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 include/linux/idr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..7834af491d46 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -155,7 +155,7 @@ static inline void idr_init(struct idr *idr)
  * idr_is_empty() - Are there any IDs allocated?
  * @idr: IDR handle.
  *
- * Return: %true if any IDs have been allocated from this IDR.
+ * Return: %true if there is no ID which is allocated from this IDR.
  */
 static inline bool idr_is_empty(const struct idr *idr)
 {
-- 
2.31.1

