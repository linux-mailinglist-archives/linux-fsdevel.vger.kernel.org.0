Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045298EA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfHOLrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 07:47:49 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:59697
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729668AbfHOLrt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWzoRkeOPTPPoj1Jpe+0TfEotvhrmdwegQcTz1z/Xmso0GderY4D0/cD1KdfLxhWzeoci69vr01LlNA6pMd+BhMTEOhIAMXmOT5f0LcgTKewYrLd95Q0IF9SU6eMP3eoy2v6gULfMOorOLpe6iTb7mRDVUC7kWVpRGe4WMaifTjQMuIdUYbJZ5u3QaSShEv0fUjU3UvTW1ONwQDx+CdMuWPkFRiwFusmgmtFkYKvK6eDYhxBWL1oQqwXOmbFL119o6OSrsUhcQAYEJWkHXFxEHP28cVtbdnNz1BPVRoqQJEFyOTt+Umk2dTxYOnGaN9daFw8ruJfMx31uc+h9X5DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzCE5+ATxzJhJn0bLoO9LxlkKcyO9Ad09HaMh34OEx8=;
 b=dhEvs3fwJPJ29IEImZdQpUbiwH67SSM4BC6ESeguWVZr0on37AhG6Zmo8tNfElkKC5MeOMKrt7URJw2MO/UN6CtvG33hsR28lHSaRBKKTox+DxHMtqvlAi4zxRf7sapnLDXoARPA4FmFKRvCPykyOWg2aMcOtTsnNiNexjEhvdtxqen1cWAjwK5YkD+N3XKszb9vlXAOLgr4Lmr1o/Z/Hg9+cbOic4/qHjlytF+OjPuTN0m5h5kfwlt+LNq0jtPzyWFfZCdP0zZ/zQhRIE3O4s0FAzSHzF32W02mKwmS+wXaJ0Aaz7iSMrGYHgkeQV66BuPJVujuq5mUFzxAiXLUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=raithlin.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzCE5+ATxzJhJn0bLoO9LxlkKcyO9Ad09HaMh34OEx8=;
 b=OSUzhVsIDrwVkYl7sEDtUZk1cR0QtOkF/oD1LsvHFslU90dS6z1iWCydkjgsvLNk/jJlLZ5ueXmGTDjYvTv9b/rfo8Ig+OjLqjDVy59nS46Tvie3p5MWvktdeeu0ieJaauwqvxslw4dN1tbTe4m/QOoYv66iQJ3CkhLnY/6ea/w=
Received: from HE1PR05CA0228.eurprd05.prod.outlook.com (2603:10a6:3:fa::28) by
 VI1PR05MB3485.eurprd05.prod.outlook.com (2603:10a6:802:1e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 15 Aug 2019 11:47:44 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by HE1PR05CA0228.outlook.office365.com
 (2603:10a6:3:fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Thu, 15 Aug 2019 11:47:43 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Thu, 15 Aug 2019 11:47:43 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 15 Aug 2019 14:47:42
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 15 Aug 2019 14:47:42 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 15 Aug 2019 14:46:48
 +0300
Subject: Re: [PATCH v7 01/14] nvme-core: introduce nvme_ctrl_get_by_path()
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-2-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <563baec2-61f6-5705-d751-1eee75370e66@mellanox.com>
Date:   Thu, 15 Aug 2019 14:46:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234514.7941-2-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(81156014)(4326008)(81166006)(8936002)(5660300002)(14444005)(110136005)(478600001)(6246003)(65806001)(11346002)(65956001)(2616005)(446003)(8676002)(316002)(2906002)(106002)(16576012)(64126003)(58126008)(54906003)(47776003)(36906005)(486006)(31686004)(229853002)(70206006)(70586007)(126002)(336012)(476003)(53546011)(3846002)(65826007)(23676004)(53936002)(356004)(31696002)(86362001)(6116002)(7416002)(50466002)(186003)(2201001)(305945005)(36756003)(230700001)(26005)(16526019)(6666004)(76176011)(7736002)(2486003)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3485;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a2231c-f9d8-44a6-a3c5-08d72176624c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB3485;
X-MS-TrafficTypeDiagnostic: VI1PR05MB3485:
X-Microsoft-Antispam-PRVS: <VI1PR05MB34852896BA7C8E55A9DD2BC3B6AC0@VI1PR05MB3485.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01304918F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: e/uGci/yDfAFF++TLoTVlrbT7HXHhRUJu2Xkio8Fhe1cEe08Zx00uv5/jTOzUjwdwAHmh8PNxvPlD/OERn0ogBYmZVZgbEqmUexq1uueonl7mJU2Vne9xd0OTymlQ9Uu9UTkbWxYyDvTHdFKOFViZJKtTQ5eoLmsmPXkRp4s5icSugFhHXA2aymWZAs4xtzxcwNV+MXsMod/qvGHQpAhCv/L5EgJkxXJS1OsmODwxYwzs27YA8ijJcyBBTaScNqgpbugl8ASTAxPSjCp7Z5+ujSlp+LpSs/kCk6mi1KdpwFKvoZNnfor8B7YfQqNZuui9wH4LWTSNwGRaGobnmDbFFxlw+aY6pRZcCtrazO83W3uB7Fgz1lzBgfFIj/a5fsjojSbvEi8HN8R9/M1ZP0RrEQo4t2kGsMLV7gBDNyHsAM=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2019 11:47:43.0738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a2231c-f9d8-44a6-a3c5-08d72176624c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3485
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> It makes use of filp_open() to open the file and uses the private
> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
> file do not match, -EINVAL is returned.
>
> The purpose of this function is to support NVMe-OF target passthru.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  2 ++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e6ee6f2a3da6..f72334f34a30 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2817,6 +2817,30 @@ static const struct file_operations nvme_dev_fops = {
>   	.compat_ioctl	= nvme_dev_ioctl,
>   };
>   
> +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
> +{
> +	struct nvme_ctrl *ctrl;
> +	struct file *f;
> +
> +	f = filp_open(path, O_RDWR, 0);
> +	if (IS_ERR(f))
> +		return ERR_CAST(f);
> +
> +	if (f->f_op != &nvme_dev_fops) {
> +		ctrl = ERR_PTR(-EINVAL);
> +		goto out_close;
> +	}

Logan,

this means that the PT is for nvme-pci and also nvme-fabrics as well.

Is this the intention ? or we want to restrict it to pci only.



> +
> +	ctrl = f->private_data;
> +	nvme_get_ctrl(ctrl);
> +
> +out_close:
> +	filp_close(f, NULL);
> +
> +	return ctrl;
> +}
> +EXPORT_SYMBOL_GPL(nvme_ctrl_get_by_path);
> +
>   static ssize_t nvme_sysfs_reset(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t count)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ecbd90c31d0d..7e827c9e892c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -484,6 +484,8 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
>   extern const struct attribute_group *nvme_ns_id_attr_groups[];
>   extern const struct block_device_operations nvme_ns_head_ops;
>   
> +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
> +
>   #ifdef CONFIG_NVME_MULTIPATH
>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>   {
