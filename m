Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5094135E306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhDMPip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 11:38:45 -0400
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:39905
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231652AbhDMPim (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMMxT1BmkpMI3B0m7jNwDj2KUhboh7yyPFsP7HDpcI0eudLzKfUKIEYeJH3+42rDFj+YKNNsW5VMGjjdc8UBH4RSUalOxZsAgn4/Enjf+q2MC4THKxt4vEQPmiQ5fxaTy+dUjXr+XmYxEtb9Lh7LUIm74Sk0pGTcYl5baiLKLnYJIHo7U8PNdUelr51YOJy/dLoExHrRfQOqn9ExECKOwK5F9/jdL5o6ivSVHIl0HTH8UihIQ2yND4+5H83fNHgdNzXyZw0NVqQ7IyxCZHqpjZXc9j2wx+iS+ewfD4FdmQefc9cRrXukDqwdfqy4g3uJeH2rMccYzcJRLLL4nnEIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoUQN1Q1Fzt3H7DtMpUk7mBdT0XGqNWDw9fgRlU1bH4=;
 b=V3jWO48CZDGHgqWuO1ZRC+BqzdwOXl6/FRAi82YrD3w23mIrOcJeL/dzq8OAsvaj6uLp0mVnWJJ+OZKtG7B5RnY7+Eu341xCYJQdlK3+Wzwf8OsYmTnZzAI7mTwN2vmijQs2uFfMN2LmED/WgsMLoKiB8bMhbMkFctIpIOey+RdO5U3ZY+NZwRKDvp7mOlCCNNmNYe2cJ2WkZuz7t2Nh2m3xGyLcERyxP65rRXQZ6zeKgmFu4sWpFbCa9skzBCJLdtw1l+/ws5H5Y6UJFWKGz9iQ6lOPY0RUsh9DiuZ8KNgj+9DZZLi+n7fdmiD0mVH0kCKo0KvwYpplPdw6lziOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoUQN1Q1Fzt3H7DtMpUk7mBdT0XGqNWDw9fgRlU1bH4=;
 b=EEf3H1UQfiJopIN2TEWXt2Zr7O/27Sr3EdK3kWYZKNzupz874PUu86T5TW7ghfmsegYOz5FVFoBqlv6OeNKL3TZ1tmwgLOv6bIBRIFjaaxDfdxSF4M6dzLAwNs9cva7uBMP2E7N7bRdWelNxpMlW0NFsM/P2Ez6B9Y2EuwNGhkFXJMwzqUuOqKxklS4wYOG6ySZYPSam0KPAV6bqt0oVHGS1gTX45tTCjvgvRIulexV/pRO3QmMhdfMRp/Kj18h0dASCw0F5M1OTKs43hJa5xDFq/+y99HOiYIlNlqw7gCA9QrYobZ4GmX7KZZ0AtzVixc1PadBHEx4a8MxDmQf63Q==
Received: from DM6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:5:14c::40)
 by MN2PR12MB3822.namprd12.prod.outlook.com (2603:10b6:208:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 15:38:19 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::9b) by DM6PR11CA0063.outlook.office365.com
 (2603:10b6:5:14c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 15:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 15:38:18 +0000
Received: from [10.223.2.15] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 15:38:14 +0000
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>, <kch@kernel.org>,
        <sagi@grimberg.me>, <snitzer@redhat.com>, <selvajove@gmail.com>,
        <linux-kernel@vger.kernel.org>, <nj.shetty@samsung.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <dm-devel@redhat.com>, <joshi.k@samsung.com>, <kbusch@kernel.org>,
        <joshiiitr@gmail.com>, <hch@lst.de>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
Date:   Tue, 13 Apr 2021 18:38:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a914c676-6f7c-46cb-9daf-08d8fe922991
X-MS-TrafficTypeDiagnostic: MN2PR12MB3822:
X-Microsoft-Antispam-PRVS: <MN2PR12MB382272F99D14AC96BD0161B3DE4F9@MN2PR12MB3822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRwsa/ZIFUJT9oDNfeid8YfEt7/YoQE8QtMVv+aVyWOonUITrXuZO4sZf4Kayz7Q0UcscVaLKip2lSTCVL8v1McYO7qsvfF3QB6HqwCabnf35AQwfCtDTCeZC70bK1T5FkJCUD5J7vowlTC5lJE7Y5YSspQ2/s8wiCk1D9ugm7DnQ4OVU9vXGYiE7dMq/M9nu54ZZLOZe7jHI0DypMUSx8AL4dDZU5Ce+CCAuz2M56KpH8x1Fbpo1HLlQOD2DgkizEYzy5oQGdfxcBI/LmQB1Y+MW4pc1tVYkSPJIfHVeCLpkyh7U6ARhT48n6UQXHqCMb4XSYG79WfXYbItWBz2Nfgy4vl9wOJ2j2wKWP25umGfDRe4lTwEBYhAmGYgxLgAeHPEyDCslovLcCL3CRjbP2GglGNaTpH08GUjzmcINMTeBNKZoAH2dm37oplaU031pDV15tUBkh2Zr909N8RMFU/jTodKdKXbTjDMmbKn7ERJBc8mjdw7h5qI0tZXITaVIgcG4wycy57TvDVNxWYvNR8I7AfaXC69yelXflS2qOWyUMuDL3NWEo+IJegXUMMP6LQhpk5uFZ27P7ILMwzlJSYxzhgZrGv9wJXC/h9wmhBF+QOdcYqafa2p0J0YZEFDwS5LBT6e8j3VwifaKVHBomZkuKEuxCgbfX5HsjK+JEcC/tAsppQTXVtPYSyOwfvaTvYsrCF36cFhYxS7TE5IUsl2pQp77QFC4KATDqXXlwbpE3XEVNM56TSUEVyX5ta7eLBtHqY6NCetEkX6WPvASjEnKuCunuMyHNMqR8HrUXEZyzEsD8IxbpaG1u6SiSUa1r7emgaL8J4QUa7fC9f+/A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(66574015)(2616005)(426003)(6666004)(36906005)(6916009)(36756003)(16576012)(86362001)(26005)(31696002)(5660300002)(83380400001)(16526019)(356005)(54906003)(70206006)(8676002)(336012)(70586007)(2906002)(31686004)(7636003)(4326008)(186003)(82310400003)(53546011)(498600001)(7416002)(966005)(36860700001)(47076005)(8936002)(43620500001)(43740500002)(15398625002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 15:38:18.7965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a914c676-6f7c-46cb-9daf-08d8fe922991
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/11/2021 10:26 PM, Javier González wrote:
> On 11.04.2021 12:10, Max Gurtovoy wrote:
>>
>> On 4/10/2021 9:32 AM, Javier González wrote:
>>>> On 10 Apr 2021, at 02.30, Chaitanya Kulkarni 
>>>> <Chaitanya.Kulkarni@wdc.com> wrote:
>>>>
>>>> ﻿On 4/9/21 17:22, Max Gurtovoy wrote:
>>>>>> On 2/19/2021 2:45 PM, SelvaKumar S wrote:
>>>>>> This patchset tries to add support for TP4065a ("Simple Copy 
>>>>>> Command"),
>>>>>> v2020.05.04 ("Ratified")
>>>>>>
>>>>>> The Specification can be found in following link.
>>>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip 
>>>>>>
>>>>>>
>>>>>> Simple copy command is a copy offloading operation and is  used 
>>>>>> to copy
>>>>>> multiple contiguous ranges (source_ranges) of LBA's to a single 
>>>>>> destination
>>>>>> LBA within the device reducing traffic between host and device.
>>>>>>
>>>>>> This implementation doesn't add native copy offload support for 
>>>>>> stacked
>>>>>> devices rather copy offload is done through emulation. Possible use
>>>>>> cases are F2FS gc and BTRFS relocation/balance.
>>>>>>
>>>>>> *blkdev_issue_copy* takes source bdev, no of sources, array of 
>>>>>> source
>>>>>> ranges (in sectors), destination bdev and destination offset(in 
>>>>>> sectors).
>>>>>> If both source and destination block devices are same and 
>>>>>> copy_offload = 1,
>>>>>> then copy is done through native copy offloading. Copy emulation 
>>>>>> is used
>>>>>> in other cases.
>>>>>>
>>>>>> As SCSI XCOPY can take two different block devices and no of 
>>>>>> source range is
>>>>>> equal to 1, this interface can be extended in future to support 
>>>>>> SCSI XCOPY.
>>>>> Any idea why this TP wasn't designed for copy offload between 2
>>>>> different namespaces in the same controller ?
>>>> Yes, it was the first attempt so to keep it simple.
>>>>
>>>> Further work is needed to add incremental TP so that we can also do 
>>>> a copy
>>>> between the name-spaces of same controller (if we can't already) 
>>>> and to the
>>>> namespaces that belongs to the different controller.
>>>>
>>>>> And a simple copy will be the case where the src_nsid == dst_nsid ?
>>>>>
>>>>> Also why there are multiple source ranges and only one dst range ? We
>>>>> could add a bit to indicate if this range is src or dst..
>>> One of the target use cases was ZNS in order to avoid fabric 
>>> transfers during host GC. You can see how this plays well with 
>>> several zone ranges and a single zone destination.
>>>
>>> If we start getting support in Linux through the different past copy 
>>> offload efforts, I’m sure we can extend this TP in the future.
>>
>> But the "copy" command IMO is more general than the ZNS GC case, that 
>> can be a private case of copy, isn't it ?
>
> It applies to any namespace type, so yes. I just wanted to give you the
> background for the current "simple" scope through one of the use cases
> that was in mind.
>
>> We can get a big benefit of offloading the data copy from one ns to 
>> another in the same controller and even in different controllers in 
>> the same subsystem.
>
> Definitely.
>
>>
>> Do you think the extension should be to "copy" command or to create a 
>> new command "x_copy" for copying to different destination ns ?
>
> I believe there is space for extensions to simple copy. But given the
> experience with XCOPY, I can imagine that changes will be incremental,
> based on very specific use cases.
>
> I think getting support upstream and bringing deployed cases is a very
> good start.

Copying data (files) within the controller/subsystem from ns_A to ns_B 
using NVMf will reduce network BW and memory BW in the host server.

This feature is well known and the use case is well known.

The question whether we implement it in vendor specific manner of we add 
it to the specification.

I prefer adding it to the spec :)


