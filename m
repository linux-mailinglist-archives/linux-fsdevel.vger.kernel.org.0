Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029D35B28D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhDKJLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 05:11:01 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:37056
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhDKJLA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzr8W6LwC0F+8fImef/z9WNpQDS8fg0c0jIUakq/EXOeMixv2VOYa92OZwvLN7lY05IIuAb1n749DIDsP+Me1dbPPaUlAel3KURzYbe0ZhfPC+G7g81LMnUx3ezZOPlwC64hHe8WDeBbTIyewvvDkS7/q+685ka6d3si0l3vw+9xVshsRLwbZkTxUdOvNchY1hdpzJgZ8j1xgaT2oymH6DvbJ8yCDy/bH7BzlqidFtopGXNICu4wV3GsSFfpqGJBl6nZnhvAHYbxeLVFWn3dt0QrMIcC6aTdczcQAn9oe6yjMGegWJRTG1ZtDsHm0F3/Pwhn6YHWNgiZuZ8JJCguFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=592+fWKJuw6iklV343DHg8CwYAHcBrUL2ttX4MjCEjw=;
 b=k4Ey/4q+pZiiL5JDpwroOeGtTH2cD+EA2Gk5qXCsVjFCdkBlFQC13jYDiQ5CfPX1z9RCbS9r75PGSVwVhLVglS7lvuB+Fa1UZgnUobEocADQVdM82qd8xPBuotqv1BNSzZKqejlbLFPOv+fsYVAZfHSz1ssVEbpDtZ8SYtv32x99tn4sor1xcsoQkUn16QaWM2U8VI/clz09mrgYuLL3mi2jwmcQyF2Swhh/KjJcZiOLIPr6JP7eP0/RF1xwIxJqlEriObnRbwTmY0LiKIlpy0Puy+Y6Xddb/p/T9qCkdPHOsiBBw7M7HddM9geNAwQQM9drqYZPdM0aeI9d1c640A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=592+fWKJuw6iklV343DHg8CwYAHcBrUL2ttX4MjCEjw=;
 b=VpVsuSIRrMvsR0g2kiUnOsZ53QUMlO3zSYbjQLCOJC6yx1yIF23ogs794f5IShfPlrdMuPkGbmUBJtfq5SDZULR4S1SIoFgotoaQoPMy4JGnUIiHMfg/Rw5iyridm8dVC5ecysRew0kofAM6q1fWuHP7w6imA4hUmRrP15+fUSJrawJQDNOu0ySMEBHJr8OgAiaUv3GdUwciQ1nrcxGUqNLUcUbwX5bfTMAJEaffLNRyayKA1YaePLTQgoItgbJaHyFt/Arb6+9w02AIE7FuEd10aDRXd3vVM6FjsY48MnKYhTE0pRYcJK1YOPegrffxR84ZsEvYMZ+byo0xz7CKRA==
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Sun, 11 Apr
 2021 09:10:42 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f8) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sun, 11 Apr 2021 09:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 09:10:41 +0000
Received: from [172.27.15.30] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Apr
 2021 09:10:36 +0000
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     SelvaKumar S <selvakuma.s1@samsung.com>,
        <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>, <kch@kernel.org>,
        <sagi@grimberg.me>, <snitzer@redhat.com>, <selvajove@gmail.com>,
        <linux-kernel@vger.kernel.org>, <nj.shetty@samsung.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <dm-devel@redhat.com>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <kbusch@kernel.org>,
        <joshiiitr@gmail.com>, <hch@lst.de>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
Date:   Sun, 11 Apr 2021 12:10:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d11acd94-9406-4c6e-f4d1-08d8fcc9ae9d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48888AE5FF67F6C8E7AE23F4DE719@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36gL4SQ4m6Nq986/CH+vAX6rAaJJDkmwec0q1giSVruF153cYFpySXH/sei7rwFRoVzaBFkdoxATl5ivlt4DChHyeNVdt1sPJNn34yWql1drw2Ro3HFOxozqCPtEVWup3uK3knl6hmRIixtjl/yOrZ3vMzCG0QUadgTW/tJ9mDh2paMbQ404XVWno8T3Y/S1Tx/qGb99ogftVToRv5Sh99JiBy0LPn0OoWvnC/yXwhEx4W6e1yw8nqjRKXk5Qka4e1usTcsR1DuuEXBAui2ApUr2/fyFo83AlCo0ybUcHcSQ9ASMcdfm1ZAag2Lge3a1j3yEB1wBFG8flCf0oE+H+n3y3/sJGGazViV7u5+bofI2HVGPxsBFm1+BCh6wN1IDBS6p9+TctoHSebwX+eEARfRob4ziYk8CTZmnZIHI2Hkz9ZWPzR5mqOJ+HHwxcWje77N6Qkc2YkiM1iYKWuaDGe+vtTvdugfc6U9mf76ExXuB+gX6rRYrQ4BaBNlvO0D+UawrdhehA5wgCoj4hoZBYhn+hmwuuhakvjupuW9oTIDSHRe4Gy7dXc1d+kOc6BdyCh/MNGWDrmLfkBpdwfJR5KzYGdHNSJfZFGKHMrOHASct/a9tZ2Z4BMRNk3lI1dCfpLy+gBjfbK2/zAUsMTriV4c6SP0H+vWaoMG+Lar2qy4n/EjKPQ2ElKPqs1+NaScVtG+FLdSbvrg3sGSuVkTr+kX6POECT4t1ZZw/7pc8ipp5jjSnR+mQSodD1B8eWBCQkP268VJxH04c9AajNAIRhdinJDO5RwnrR+aklkaHN4jIXACtnheSo9SNHwad0a91UYTEX/8Q8DYa9NBg88DFow==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(82310400003)(7636003)(36756003)(316002)(478600001)(356005)(6666004)(47076005)(426003)(54906003)(26005)(8936002)(82740400003)(336012)(16526019)(186003)(4326008)(5660300002)(83380400001)(86362001)(70586007)(36860700001)(53546011)(7416002)(66574015)(70206006)(2616005)(966005)(31696002)(16576012)(110136005)(8676002)(36906005)(2906002)(31686004)(43620500001)(15398625002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 09:10:41.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11acd94-9406-4c6e-f4d1-08d8fcc9ae9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/10/2021 9:32 AM, Javier González wrote:
>> On 10 Apr 2021, at 02.30, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
>>
>> ﻿On 4/9/21 17:22, Max Gurtovoy wrote:
>>>> On 2/19/2021 2:45 PM, SelvaKumar S wrote:
>>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>> v2020.05.04 ("Ratified")
>>>>
>>>> The Specification can be found in following link.
>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>
>>>> Simple copy command is a copy offloading operation and is  used to copy
>>>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>> LBA within the device reducing traffic between host and device.
>>>>
>>>> This implementation doesn't add native copy offload support for stacked
>>>> devices rather copy offload is done through emulation. Possible use
>>>> cases are F2FS gc and BTRFS relocation/balance.
>>>>
>>>> *blkdev_issue_copy* takes source bdev, no of sources, array of source
>>>> ranges (in sectors), destination bdev and destination offset(in sectors).
>>>> If both source and destination block devices are same and copy_offload = 1,
>>>> then copy is done through native copy offloading. Copy emulation is used
>>>> in other cases.
>>>>
>>>> As SCSI XCOPY can take two different block devices and no of source range is
>>>> equal to 1, this interface can be extended in future to support SCSI XCOPY.
>>> Any idea why this TP wasn't designed for copy offload between 2
>>> different namespaces in the same controller ?
>> Yes, it was the first attempt so to keep it simple.
>>
>> Further work is needed to add incremental TP so that we can also do a copy
>> between the name-spaces of same controller (if we can't already) and to the
>> namespaces that belongs to the different controller.
>>
>>> And a simple copy will be the case where the src_nsid == dst_nsid ?
>>>
>>> Also why there are multiple source ranges and only one dst range ? We
>>> could add a bit to indicate if this range is src or dst..
> One of the target use cases was ZNS in order to avoid fabric transfers during host GC. You can see how this plays well with several zone ranges and a single zone destination.
>
> If we start getting support in Linux through the different past copy offload efforts, I’m sure we can extend this TP in the future.

But the "copy" command IMO is more general than the ZNS GC case, that 
can be a private case of copy, isn't it ?

We can get a big benefit of offloading the data copy from one ns to 
another in the same controller and even in different controllers in the 
same subsystem.

Do you think the extension should be to "copy" command or to create a 
new command "x_copy" for copying to different destination ns ?


>   
