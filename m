Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049958EBD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfHOMrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:47:22 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:3262
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfHOMrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjtnFhlaf1LguE37MKXL4S9X0b7ouQAuDuB6KLrLudC6ygUdmKsbYn5JW9XT3o9eyY5qqcNB5o8/uqXNyTfMCVAuq5Go3NZ0DKq290wQzkCXDoPzxTAi8NErBYMTlG/IwyBdAHJjPBFVS3HDwLjA8ylY/Gqy7TPCBhfUk5SAsPA2QBQkn8VcfdlZ2pWYqAJvNlIlAMotG3jTgVwikJrYE+B5DeaTrlxsfBxVusiSAPh1wjY/Hm7nMgEJoDLX86dS1kiU4ffWJmzrOw90Yb7CJr78kpraOt5vmLUqXGLGgmFyhzITmC8188B2vZz+qC7JUKcK7wXnqTP18je0EqBPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQieUppWTPN5s0q+2YP8EPrBtQkxpuVTjMWl7KBSNH4=;
 b=YIlRIRHkOc/Fpav6qES9INOaQgM6LXNuGwvjjxEbzF74Kd0vX184tItrX8XjwCIV7t/4+W6o0f8gpjqX7k1UqNX3dUNGNCuxivNFY/W5wMVsT6ssUAl0dccqc5IY9YvKvvFknZhZ/Umc6Rol/WjO7CfkZpQmnjup+wWYSS579Tbe9r7uXn7cria2dYyX7G5g9VL6xyK8m/8WWX5xxNbOgSo0jwRp6w2mku60QM2cA5M+qrfE8GWxWTYlGC/jQ77p5D+SknXIZA1RXH3F/QtvohHfMVBDoYetVF0Nt/fyG4jfD5GSWVJT3SQkhazmALEJm0gBuwQ5hMFNLja9GFjgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=raithlin.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQieUppWTPN5s0q+2YP8EPrBtQkxpuVTjMWl7KBSNH4=;
 b=acN6uK7aO5ejSvaaZDcBgP/HcukYY2DRa4UJ1kLBNV5+oNaNXqN5Vh54ej4IzzrivKBwAwed0+0WJluY90ktIgbYX37hf0UM+wV+qDqTDgLWG+Wdxsd+j38SpMJ1FT5tvpuo68T//ASGShkAwq9wDCCu3aipvT3quXtwhQbqPA0=
Received: from DB6PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:6:14::43) by
 AM5PR0502MB3060.eurprd05.prod.outlook.com (2603:10a6:203:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Thu, 15 Aug
 2019 12:47:15 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by DB6PR05CA0030.outlook.office365.com
 (2603:10a6:6:14::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Thu, 15 Aug 2019 12:47:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Thu, 15 Aug 2019 12:47:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 15 Aug 2019 15:47:13
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 15 Aug 2019 15:47:13 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 15 Aug 2019 15:46:16
 +0300
Subject: Re: [PATCH v7 11/14] nvmet-configfs: introduce passthru configfs
 interface
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-12-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <28a807ae-fbba-5016-3b71-04baa121e522@mellanox.com>
Date:   Thu, 15 Aug 2019 15:46:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234514.7941-12-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(31686004)(53546011)(81156014)(16526019)(8676002)(65826007)(186003)(81166006)(70206006)(70586007)(478600001)(4326008)(305945005)(2486003)(126002)(7416002)(486006)(106002)(64126003)(76176011)(23676004)(6116002)(336012)(356004)(16576012)(110136005)(229853002)(446003)(2616005)(316002)(5660300002)(14444005)(2201001)(58126008)(50466002)(11346002)(476003)(47776003)(86362001)(230700001)(26005)(54906003)(6246003)(65806001)(65956001)(2906002)(31696002)(3846002)(36756003)(53936002)(7736002)(8936002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB3060;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a612fff5-8cea-4e9d-76fd-08d7217eb2c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM5PR0502MB3060;
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3060:
X-Microsoft-Antispam-PRVS: <AM5PR0502MB30607A8B61A7E0D7A8E3A447B6AC0@AM5PR0502MB3060.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 01304918F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: n6yJUHEmdFuQfHM9LWDRjHEZLbksBC6aPsfsv6Dv6o0AG+ht3nomV+bdjUcxDwfQOtIfMjCgPQtTn9iUSXx/WB4N7Ar1IMyK3UAVRM6PsS5uFFueb9nqUVjGalzdyGmXF89xICpEBjElhV94OSOOw7kHVNup68wTMcCpTAYG8VcMJ3Vk62bLCuTqzumvBMxOHytHbDWTwMhRquRO5TERHq4lL/fcgLPQsNViRtDx0hakrWwLbp4lTteIENvkXeK1sQVPgt72278VSipFSiJG/Aig6tG/wVJLHCRHUWnywPd+cljArD9cwMlHJvJYa9pP/zLhJx489b0OcwfXzcaD5B892DwxvaY8cMog8SXRtv6CV21mEzdMgDEISeW2F1LN8n0r6e965q6FzQCTeDHwZUr62Db0BNRJQ+fTYfKvXIQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2019 12:47:14.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a612fff5-8cea-4e9d-76fd-08d7217eb2c9
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3060
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> When CONFIG_NVME_TARGET_PASSTHRU as 'passthru' directory will
> be added to each subsystem. The directory is similar to a namespace
> and has two attributes: device_path and enable. The user must set the
> path to the nvme controller's char device and write '1' to enable the
> subsystem to use passthru.
>
> Any given subsystem is prevented from enabling both a regular namespace
> and the passthru device. If one is enabled, enabling the other will
> produce an error.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/configfs.c | 99 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h    |  1 +
>   2 files changed, 100 insertions(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..b15d64c19f58 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -615,6 +615,103 @@ static const struct config_item_type nvmet_namespaces_type = {
>   	.ct_owner		= THIS_MODULE,
>   };
>   
> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
> +
> +static ssize_t nvmet_passthru_device_path_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
> +
> +	return snprintf(page, PAGE_SIZE, "%s\n", subsys->passthru_ctrl_path);
> +}
> +
> +static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
> +	int ret = -ENOMEM;

seems like a redundant initialization.

> +	size_t len;
> +
> +	mutex_lock(&subsys->lock);
> +
> +	ret = -EBUSY;
> +	if (subsys->passthru_ctrl)
> +		goto out_unlock;
> +
> +	ret = -EINVAL;
> +	len = strcspn(page, "\n");
> +	if (!len)
> +		goto out_unlock;
> +
> +	kfree(subsys->passthru_ctrl_path);
> +	ret = -ENOMEM;
> +	subsys->passthru_ctrl_path = kstrndup(page, len, GFP_KERNEL);
> +	if (!subsys->passthru_ctrl_path)
> +		goto out_unlock;
> +
> +	mutex_unlock(&subsys->lock);
> +
> +	return count;
> +out_unlock:
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +CONFIGFS_ATTR(nvmet_passthru_, device_path);
> +
> +static ssize_t nvmet_passthru_enable_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
> +
> +	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
> +}
> +
> +static ssize_t nvmet_passthru_enable_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
> +	bool enable;
> +	int ret = 0;
> +
> +	if (strtobool(page, &enable))
> +		return -EINVAL;
> +
> +	if (enable)
> +		ret = nvmet_passthru_ctrl_enable(subsys);
> +	else
> +		nvmet_passthru_ctrl_disable(subsys);
> +
> +	return ret ? ret : count;
> +}
> +CONFIGFS_ATTR(nvmet_passthru_, enable);
> +
> +static struct configfs_attribute *nvmet_passthru_attrs[] = {
> +	&nvmet_passthru_attr_device_path,
> +	&nvmet_passthru_attr_enable,
> +	NULL,
> +};
> +
> +static const struct config_item_type nvmet_passthru_type = {
> +	.ct_attrs		= nvmet_passthru_attrs,
> +	.ct_owner		= THIS_MODULE,
> +};
> +
> +static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
> +{
> +	config_group_init_type_name(&subsys->passthru_group,
> +				    "passthru", &nvmet_passthru_type);
> +	configfs_add_default_group(&subsys->passthru_group,
> +				   &subsys->group);
> +}
> +
> +#else /* CONFIG_NVME_TARGET_PASSTHRU */
> +
> +static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
> +{
> +}
> +
> +#endif /* CONFIG_NVME_TARGET_PASSTHRU */
> +
>   static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   		struct config_item *target)
>   {
> @@ -915,6 +1012,8 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>   	configfs_add_default_group(&subsys->allowed_hosts_group,
>   			&subsys->group);
>   
> +	nvmet_add_passthru_group(subsys);
> +
>   	return &subsys->group;
>   }
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 6436cb990905..f9c593f1305d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -231,6 +231,7 @@ struct nvmet_subsys {
>   #ifdef CONFIG_NVME_TARGET_PASSTHRU
>   	struct nvme_ctrl	*passthru_ctrl;
>   	char			*passthru_ctrl_path;
> +	struct config_group	passthru_group;
>   #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>   };
>   
