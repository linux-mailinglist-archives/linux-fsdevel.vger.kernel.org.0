Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD798EB6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfHOMWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:22:24 -0400
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:46208
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfHOMWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2zVOXIO5kS4HQvvh+vGwJqcjda5zcGpuc4P6R0hazcxWQSz3wgTZ7KgqJooHbDqOiQdWwy1IoG40jhsynrsrQSNJ/YtWdXlxNwo5tOuQBxelqUUAwaGcCXxRg7EIjnE2v3AtccKUipK5fdYPbmGuNMFP2/WUBMSrhgPPhClAja/X64AofmMadVdRP5VzpTqUI73WyH5TNpgAnwl2dgqplOj/0Z3mJoL1V77/OueEjaog2MrL9vssAxSEWf1RdmFu06ashzyGoRW4mBY5ixhLtq2bl8nF+twE+JsDLm3CJiKNNTaDF5/5Nz4wuPORH9LSySYtJFngHD7anXlaKuqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufOBix5IY4nj0Nx/CTgkI8W0IxnmcH2w9HLt1RR1W/s=;
 b=XinzqF9DDOQNchqWiqcgxUsTKudf+2wVEfnK4HcVHRoOmLOf5N5WpYeiTg8/T8ku7ZcXXav60MXkjk6/PlRIRLYCq3Ci7blgx8VBsfkkCj2cw01+ZAkDNMwmOisWaYA+YUmzUm4YNyAfA24D2K+z0x9nr0qwEn3mIk5fxZkeWUgAxmvKn1NfrWup9PBRAzSvVe5tF2W6RjkdTHyiaAQMlE3oeMCf+dzcZL2kf5iLBm0NecUPk4MXk+7wXfvGbWqTM+wrDBdUqYT/8lHsd7A2or6vtSzAKJgCDizk82wYy8Iz2s/n1GgB0zGLmU0BWmd6pE/qNmwfTlXLHjIzuEsutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=raithlin.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufOBix5IY4nj0Nx/CTgkI8W0IxnmcH2w9HLt1RR1W/s=;
 b=bzAdPJvDmgOM4UxCKrT7NwyyUpFO0TTZKXs127Q1vDDQQrTHT/SATMBYBALuMf5JqIuHOD3AjluVm0DkJxACxxjLlbQn590Tikx+ErN9Jl/LtM2xmRk49pYGx5jvtO4K5sx9CAN5/SEF4uVt2ZgkMPxqgERYHtT7nd3pjtwnmhE=
Received: from HE1PR05CA0238.eurprd05.prod.outlook.com (2603:10a6:3:fb::14) by
 HE1PR05MB3385.eurprd05.prod.outlook.com (2603:10a6:7:33::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Thu, 15 Aug 2019 12:20:39 +0000
Received: from VE1EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by HE1PR05CA0238.outlook.office365.com
 (2603:10a6:3:fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.18 via Frontend
 Transport; Thu, 15 Aug 2019 12:20:39 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT006.mail.protection.outlook.com (10.152.18.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Thu, 15 Aug 2019 12:20:38 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 15 Aug 2019 15:20:37
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 15 Aug 2019 15:20:37 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 15 Aug 2019 15:20:35
 +0300
Subject: Re: [PATCH v7 07/14] nvmet-passthru: add enable/disable helpers
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-8-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e0323600-c4e8-00e7-d8cc-ff8d31b4ed10@mellanox.com>
Date:   Thu, 15 Aug 2019 15:20:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234514.7941-8-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(65806001)(6246003)(486006)(65956001)(53936002)(6116002)(70206006)(64126003)(31696002)(5660300002)(65826007)(3846002)(70586007)(4326008)(36906005)(86362001)(76176011)(2201001)(53546011)(8936002)(11346002)(446003)(126002)(36756003)(14444005)(230700001)(476003)(7416002)(2616005)(47776003)(7736002)(336012)(16526019)(23676004)(2486003)(26005)(305945005)(31686004)(81166006)(316002)(81156014)(58126008)(106002)(16576012)(50466002)(54906003)(186003)(356004)(110136005)(8676002)(2906002)(478600001)(229853002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3385;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11fb4de1-fd0c-4f7f-1f6f-08d7217afbc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR05MB3385;
X-MS-TrafficTypeDiagnostic: HE1PR05MB3385:
X-Microsoft-Antispam-PRVS: <HE1PR05MB338596D6F8A8AF0A1CC549EDB6AC0@HE1PR05MB3385.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 01304918F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9NQ4bTKsOhu230m9i62mEMXukNxqgOZr6KhHuyNDY5v2/Jon1fBKjSO7p/7G3yfnTHr9vtaU00aYOPf6gvpcw2XNSj2QH/eMh/ire7tD+3Ow0qQiiASi9yeJkEqytBO/Q2Ny6LYSPFYMfl0bUM+nZvZEPkmmWz2m4xS4MoW9QkHg+hNhxpT5VlW598hQL1goyDmn6Vk1G8KOSoRJbZ25V/0z9+IigEtw1xQwezbVyepkpfFzcXGmb04Gdb1jq0Nm4wHlSKvexZc/c9U65RiGcGEnYJeSs98akxnOVs0r7ZBCLPpbf+WWMi3kMr0InNFS+aWI1bFblNFtXKMVsEQ79f+UooILTDssH9swZ3WmWE6j0h85GxJ0rpYFufWf2R88W0TX1J/HXwWC6CUObW9qlPi3QISHyBhsKW4EroK02b4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2019 12:20:38.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fb4de1-fd0c-4f7f-1f6f-08d7217afbc3
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3385
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> This patch adds helper functions which are used in the NVMeOF configfs
> when the user is configuring the passthru subsystem. Here we ensure
> that only one subsys is assigned to each nvme_ctrl by using an xarray
> on the cntlid.
>
> [chaitanya.kulkarni@wdc.com: this patch is very roughly based
>   on a similar one by Chaitanya]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/core.c            |  8 +++
>   drivers/nvme/target/io-cmd-passthru.c | 77 +++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h           | 10 ++++
>   3 files changed, 95 insertions(+)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 50c01b2da568..2e75968af7f4 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -519,6 +519,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   
>   	mutex_lock(&subsys->lock);
>   	ret = 0;
> +
> +	if (nvmet_passthru_ctrl(subsys)) {
> +		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
> +		goto out_unlock;
> +	}
> +
>   	if (ns->enabled)
>   		goto out_unlock;
>   
> @@ -1439,6 +1445,8 @@ static void nvmet_subsys_free(struct kref *ref)
>   
>   	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
>   
> +	nvmet_passthru_subsys_free(subsys);
> +
>   	kfree(subsys->subsysnqn);
>   	kfree(subsys);
>   }
> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
> index 46c58fec5608..b199785500ad 100644
> --- a/drivers/nvme/target/io-cmd-passthru.c
> +++ b/drivers/nvme/target/io-cmd-passthru.c
> @@ -11,6 +11,11 @@
>   #include "../host/nvme.h"
>   #include "nvmet.h"
>   
> +/*
> + * xarray to maintain one passthru subsystem per nvme controller.
> + */
> +static DEFINE_XARRAY(passthru_subsystems);
> +
>   static struct workqueue_struct *passthru_wq;
>   
>   int nvmet_passthru_init(void)
> @@ -27,6 +32,78 @@ void nvmet_passthru_destroy(void)
>   	destroy_workqueue(passthru_wq);
>   }
>   
> +int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int ret = -EINVAL;
> +	void *old;
> +
> +	mutex_lock(&subsys->lock);
> +	if (!subsys->passthru_ctrl_path)
> +		goto out_unlock;
> +	if (subsys->passthru_ctrl)
> +		goto out_unlock;
> +
> +	if (subsys->nr_namespaces) {
> +		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
> +		goto out_unlock;
> +	}
> +
> +	ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
> +	if (IS_ERR(ctrl)) {
> +		ret = PTR_ERR(ctrl);
> +		pr_err("failed to open nvme controller %s\n",
> +		       subsys->passthru_ctrl_path);
> +
> +		goto out_unlock;
> +	}
> +
> +	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
> +			 subsys, GFP_KERNEL);
> +	if (xa_is_err(old)) {
> +		ret = xa_err(old);
> +		goto out_put_ctrl;
> +	}
> +
> +	if (old)
> +		goto out_put_ctrl;
> +
> +	subsys->passthru_ctrl = ctrl;
> +	ret = 0;
> +
> +	goto out_unlock;

can we re-arrange the code here ?

it's not so common to see goto in a good flow.

maybe have 1 good flow the goto's will go bellow it as we usually do in 
this subsystem.


> +
> +out_put_ctrl:
> +	nvme_put_ctrl(ctrl);
> +out_unlock:
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +
> +static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	if (subsys->passthru_ctrl) {
> +		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
> +		nvme_put_ctrl(subsys->passthru_ctrl);
> +	}
> +	subsys->passthru_ctrl = NULL;
> +}
> +
> +void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	mutex_unlock(&subsys->lock);
> +}
> +
> +void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	kfree(subsys->passthru_ctrl_path);
> +	mutex_unlock(&subsys->lock);
> +}
> +
>   static void nvmet_passthru_req_complete(struct nvmet_req *req,
>   		struct request *rq, u16 status)
>   {
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index bd11114ebbb9..aff4db03269d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -230,6 +230,7 @@ struct nvmet_subsys {
>   
>   #ifdef CONFIG_NVME_TARGET_PASSTHRU
>   	struct nvme_ctrl	*passthru_ctrl;
> +	char			*passthru_ctrl_path;
>   #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>   };
>   
> @@ -509,6 +510,9 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
>   
>   int nvmet_passthru_init(void);
>   void nvmet_passthru_destroy(void);
> +void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
> +int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
> +void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
>   u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
>   
>   static inline
> @@ -526,6 +530,12 @@ static inline int nvmet_passthru_init(void)
>   static inline void nvmet_passthru_destroy(void)
>   {
>   }
> +static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
> +{
> +}
> +static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +}
>   static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
>   {
>   	return 0;
