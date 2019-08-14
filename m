Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B276A8D603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfHNO36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:29:58 -0400
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:65504
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728164AbfHNO35 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPQ131q2FZscqc0SyU7go7vmb27vM/R26tQ0HD1iq8Zsjvi8KDr4dfSRpg3rg5VggjQvkPvB6B0DpGxgftl8NMsWm+JSnHeiePgrfAidmr5GXgJJ3PB1FtySnm+j87xHkZC1ltgZ4qThEWhJElbedlsdYc/07ccnhpa65LjRyjl7rV9XJ2z6Ebgi3/RrpaHYzTGOntRYY0db2J9CMfJDueZmBuEhpTGhBzoEaAjIObv+kqlf/xFyx/h6KdtlPIdGqhRjUZX11l7azrt9nSG1UrtdCLLOCbYct4bFDWhURdm6H5EixGQSqJnPK8i5t0yKbSh3VAabaZjd/A+7hbY7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCnkQDHHiS4Yw0TA6MHVxEbdsbbXxQYZobaEv6nUFNw=;
 b=JiV1+SDg+mAuT6+dEBSjChChrpOvOC0eOblsG1fk0AXZl8Nn9M+pbNNyeRmv1Rr9EnNBPISJMl7+TbNAvHjheYeD2jLiTR/DstNgRBCJf0EP4RATjay5OZzE1ImL2xklAFMfYFLzuWuyCvAwtXBFTdAQPiBVZlHCLa34IGxmRL6Jltmnw/k20bSI8s8SI71S7vA3vKjauy4KZkZ8el0WRMWwl0HTYidf87R0nyrKL1CnCgvjBVeM6VYRc5Uh0pa7sV2xXzN8//V0xn1vZaTY4/0RxLiQc/dJ3BJX9pR0YoqjmzNboieKY2f8gHF+BHFvZfwc0L7tQNyIM+yukqV+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=raithlin.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCnkQDHHiS4Yw0TA6MHVxEbdsbbXxQYZobaEv6nUFNw=;
 b=ls7sgxf3ui9Umi/fUsFJas4uB4i28RRIDUAraJn/XvfTp88UXocg92WScl8oLvJl5VXXEOEV3Ot3HDdCTMaSQT6ktr8T7imeXN6S//0S/xClt9v4MDhOxY321ODcMSYzb/zd3rXZ3I+gYi0ajoJhjLrZacL6fAZvLH2B7cYs4Q0=
Received: from AM4PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:200:68::11) by HE1PR0502MB3067.eurprd05.prod.outlook.com
 (2603:10a6:3:d5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Wed, 14 Aug
 2019 14:29:53 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM4PR0501CA0043.outlook.office365.com
 (2603:10a6:200:68::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 14 Aug 2019 14:29:53 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.18 via Frontend Transport; Wed, 14 Aug 2019 14:29:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 14 Aug 2019 17:29:51
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 14 Aug 2019 17:29:51 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 14 Aug 2019 17:29:47
 +0300
Subject: Re: [PATCH v7 04/14] nvmet: make nvmet_copy_ns_identifier()
 non-static
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-5-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <43951ad9-873b-5bbe-b627-0ad4610fbb11@mellanox.com>
Date:   Wed, 14 Aug 2019 17:29:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234514.7941-5-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(189003)(31696002)(81156014)(2906002)(8936002)(2486003)(86362001)(54906003)(64126003)(23676004)(110136005)(81166006)(58126008)(4326008)(53936002)(2201001)(65826007)(478600001)(356004)(70586007)(486006)(70206006)(2616005)(126002)(76176011)(50466002)(11346002)(446003)(476003)(336012)(53546011)(229853002)(16526019)(5660300002)(3846002)(26005)(6116002)(31686004)(305945005)(7736002)(186003)(8676002)(7416002)(16576012)(316002)(230700001)(36906005)(106002)(6246003)(36756003)(65806001)(47776003)(65956001)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3067;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5488ff61-bc9b-41b7-3825-08d720c3df01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR0502MB3067;
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3067:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB3067F543ACC454A35A51AF16B6AD0@HE1PR0502MB3067.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aWuCWK7a/IlcvKYYcX1AAlUWZGE7yLD5jewZ3lYGzsDpXdI/fNmAsyzWm0yuRsyrbmVhwMyY/mZbywFyTtawvKsP+VleuFSVJmWUpueA3OjXgL2mW1YI56GwTZsUIgOp9ApOIFlB0giJx58IzRNoQ4CMrpaFrAl+FtggMigYvAboaZOQaIAvi0YTMxIUR4QXL58rovYxAZq7w47Oud8WyrahwNHTpxHHKK1MUsUUz/pjeOrXG/P5DCpUx/NppeRWE++h5Z8K26M6jrLkeLgHjV9tTI29sLCAR86uBECwglkAVoW4JCu0X2tRmmh8v5Aaf/1F2JriYgHRbFkR255yKVCiSH7SP6eyw5HXGYbbkfKArF2E8DWSEe8zofRxIzcZm5Q7DFa8crdq8OBrVwL55fuNp+EpjO6bsypI+V7Rq28=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 14:29:52.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5488ff61-bc9b-41b7-3825-08d720c3df01
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3067
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> This function will be needed by the upcoming passthru code.

Same here. As a standalone commit I can't take a lot from here.

Maybe should be squashed ?


>
> [chaitanya.kulkarni@wdc.com: this was factored out of a patch
>   originally authored by Chaitanya]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 4 ++--
>   drivers/nvme/target/nvmet.h     | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 4dc12ea52f23..eeb24f606d00 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -506,8 +506,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> -				    void *id, off_t *off)
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off)
>   {
>   	struct nvme_ns_id_desc desc = {
>   		.nidt = type,
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 217a787952e8..d1a0a3190a24 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -489,6 +489,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
>   u16 nvmet_file_flush(struct nvmet_req *req);
>   void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
>   
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off);
>   static inline u32 nvmet_rw_len(struct nvmet_req *req)
>   {
>   	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
