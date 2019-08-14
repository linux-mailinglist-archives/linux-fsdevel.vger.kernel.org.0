Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8E8D630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfHNOch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:32:37 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:49813
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfHNOcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad7qBpeMg7gha4QnXU2Es3fT0jv9oGgM44lTe7SYbl7HdtNu8Qtr6QQrBDTWESaKidyK2zEEOL5h0/wOUVm+Iqz3YKuXlY2fDWTDHrWPJKtyN9ZaZdZZnRZX0KX1LYVsnH6FZfay0icU9LqONU88emexE6mAbsFB9QhtEcM2JEuoZG/fH86GXanklctEgZANreNdpnMRL2RDCDH9ijsCXbKyqp7MKGPghGSkIsTMYCNJE332kl7gxdIAEvOgEMsQ4Q4SVxMgPlKN1X7d03CBNC3nhAnjlICK6RXhftkhyCsn/KgMX+XpEeZLOA2znxzMXAKYJEFKNQnvKdQN1eYsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FgTCsVUoW2DvaClEoPrCkBK4AtqZbkvGA9QVk4wv7Y=;
 b=VT40dRgf5W743jJk5YE+h7OTywrPXnmBvnKjruR9TWIl79ExQCzY/8vn0PzIXKwiAnvW1AaJX4GyWN+v02xg/Vxr9K+mt9AUXTc4Q7eUULqM5KuGwSDXsBwkkYikvOfQmeZB821IdJMdObtnQtEr4wfK+95ULGYbomulZ9sLyXxLOPfINQKxVwB+oY7a13RbFocrxIr5Axhl1wlWBqBDCBgTJ01Ty2JFYntSFpyt82U8IXjYaKm9dwD+x1fkoujGVpaKDeAxQQ56gkw8IxnPpwdtjVb1kk3+A55MYSwYW8xoVIJxmmS0Y9zY3Cu02MFo773Yb42cnH/b3l+YD95msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=raithlin.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FgTCsVUoW2DvaClEoPrCkBK4AtqZbkvGA9QVk4wv7Y=;
 b=EfUKxgMU2jcVB3RWlhZYncWv6OJ6XW7rEcq0nLBYj/QrNXs4xY+pTSbMxtpICTHPuKOz7p3DN+Rk36nFN3HsBLa4MFXbCZHbnhh65V2GGxQZ4mmKH9owk8l7m2p4W3DabRdk4Zc7QObNvTEy6wjju9Fjb5NfIhGojSbmrkFsgMo=
Received: from DB6PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:6:14::23) by
 AM5PR0502MB3057.eurprd05.prod.outlook.com (2603:10a6:203:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Wed, 14 Aug
 2019 14:32:31 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by DB6PR05CA0010.outlook.office365.com
 (2603:10a6:6:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 14 Aug 2019 14:31:49 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.18 via Frontend Transport; Wed, 14 Aug 2019 14:31:48 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 14 Aug 2019 17:31:48
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 14 Aug 2019 17:31:48 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 14 Aug 2019 17:31:46
 +0300
Subject: Re: [PATCH v7 05/14] nvmet-passthru: update KConfig with config
 passthru option
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-6-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <68173412-f3e3-df6f-78f0-296b03eaaf13@mellanox.com>
Date:   Wed, 14 Aug 2019 17:31:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234514.7941-6-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(53546011)(16576012)(229853002)(2616005)(31686004)(966005)(36906005)(186003)(316002)(23676004)(2420400007)(305945005)(76176011)(65806001)(478600001)(336012)(7736002)(36756003)(2486003)(15650500001)(26005)(476003)(11346002)(64126003)(446003)(50466002)(65956001)(486006)(126002)(47776003)(65826007)(8936002)(81156014)(8676002)(106002)(14444005)(31696002)(7416002)(6116002)(3846002)(6306002)(2201001)(58126008)(230700001)(356004)(6246003)(110136005)(54906003)(81166006)(70206006)(16526019)(86362001)(70586007)(5660300002)(2906002)(53936002)(4326008)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB3057;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a77063-c4ba-45ba-8708-08d720c42460
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0502MB3057;
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3057:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <AM5PR0502MB3057C3FA03691D6ADE8A98B6B6AD0@AM5PR0502MB3057.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tGYpTaB4/RKGgnNxm8yCZV/zeFoE3eHFYrQGcKPzwzrbjtjt0HIjh98fq9/mEFrsguhlWsPumiWORp58k8Hm9LmemrNWIOI5I3kNTWo7NsE3Im0E7bnoJ0GRZ9n95zh4xcIqWryKKWtH6QUKekNnzkwuw++k8V0vIc5eFN/Q0DCIuW0cGHPb/hPmiSOqmlH6a2YovpGtyjgQtKGKavVpaS9yVmbZYpfoZ33LS0/yuAUXwbAWGEfrgaGd84h68ZqBkw3NlaOAdrJ5KtXFlEjCSUrNI84jUN0bUGaIEkyWz6g1BtsOVIczfEgKMXYR9tcxicJx65UnyL/Kl1oVqT9QrEznvN6SUpegR03vv4Lc2hV5sIqSPOOibGPPgQxfTMhNzxNTPl+dK1qI60r5xn0XH/2mSFmlW0LCzh4ie/Cm5iE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 14:31:48.8295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a77063-c4ba-45ba-8708-08d720c42460
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3057
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
> This patch updates KConfig file for the NVMeOF target where we add new
> option so that user can selectively enable/disable passthru code.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [logang@deltatee.com: fixed some of the wording in the help message]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/Kconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index d7f48c0fb311..2478cb5a932d 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -15,6 +15,16 @@ config NVME_TARGET
>   	  To configure the NVMe target you probably want to use the nvmetcli
>   	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
>   
> +config NVME_TARGET_PASSTHRU
> +	bool "NVMe Target Passthrough support"
> +	depends on NVME_CORE
> +	depends on NVME_TARGET
> +	help
> +	  This enables target side NVMe passthru controller support for the
> +	  NVMe Over Fabrics protocol. It allows for hosts to manage and
> +	  directly access an actual NVMe controller residing on the target
> +	  side, incuding executing Vendor Unique Commands.
> +
>   config NVME_TARGET_LOOP
>   	tristate "NVMe loopback device support"
>   	depends on NVME_TARGET


Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


