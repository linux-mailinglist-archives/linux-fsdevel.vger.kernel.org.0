Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399E7367C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhDVIRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 04:17:31 -0400
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:37536
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235526AbhDVIR3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:17:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbupAbkt1Y9WuGT9qOJS7lZlDGvSwcHclZd6M3Qsahz7bUbAVBnLNMKzyIucGnZYQ5jXz3VLB3ZaCwf+C0vbCCppTgPmePr4yfqlJQ9nNLi9SjfrQG4w6rOuuEzC/fuCpZwK/VIC+gpk0TABd07VSuDvz1Ga7OCNj/K9cUIOPmHt96i23hwxoAmOQljZ+/MG/yvdfqEbR2g903z9ePcUq3dWtNXOaEe+tbR+L1G7t4zkKHM5maTumj09xmXldxHd1JLJ4WEBYU3u7nTbmwd9xcbLgK8jOm0chq/6akis88YmNxZbe4kx2tcuH6kcPGYm/OriwndVmdkwr1PJGJIdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq+qBPcPbTa5KykEfFLD4bbBZ35fuqzptm5NfiJmyi0=;
 b=WJtHEV2gau9O6MMfO6vZe3xIPTv9EFvOgZD5UOIFU1ijBy4fNpWLo1fpTWrNcBF39jEsogAeH1OyjWAZjNJxGMrvoIrzRACiV0Rw7Ih/uQagG0aDdcCcfm2J3jklqopMnu6cmTThY140FEDW9pOf/BISYP8GhxbXkz1JyU3i/yVCUQHgrMYUE14rvPbnIdmHFDM23mcpu55f/SbmaWWpacm+bcBK/MNvkKXXCm9ZMW1RNGOLlFuJm0ibsy6bEuDJ02KZbvN1q+2JpFTsJ84DF0Q9/S5d4ajQlKeG9V5zKXFDm9oqgWBWE9OFnRROpRhLGJ2bkutigzXVP+Rw0EUOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq+qBPcPbTa5KykEfFLD4bbBZ35fuqzptm5NfiJmyi0=;
 b=eUWZMqLeoIhhDyK4dOR7WhIr8kdWQxt4yEBQFIwyc+v8M8x0TdTOgQvFKKx9qhB6xzfUahZEEdYjR5+jvleJv5l6pCZF/I44heVtj2HFdtGwrBY46NnuTLxfbieItr4rjoU4Jpt3qWISBbWLWBDoBj5GTY6FAjlUPAOxtC/ENV8tSo39Jzm6IY64kCeL6dIPGmiCmn52IR/NdM7yOFTTAI7LGX7Q9NQvBmSLvoilooUPSTkeNqzATwQUvs1KEZy1HVLrThj/e0yFZz/CL3XrWsV9q9LnQ4vCYWtWSMBAoE2qo57Jb0/4JzbOm6MfjBb9V2Yyd7q8N1RUL50N1RB8Xw==
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by MN2PR12MB3758.namprd12.prod.outlook.com (2603:10b6:208:169::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 08:16:53 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::5b) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 08:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:16:52 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:16:45 +0000
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
To:     Marco Elver <elver@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
References: <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
 <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
 <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
 <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com>
 <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
 <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com>
 <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
 <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
 <YIBSg7Vi+U383dT7@elver.google.com>
 <CGME20210421182355eucas1p23b419002936ab5f1ffc25652135cc152@eucas1p2.samsung.com>
 <YIBtr2w/8KhOoiUA@elver.google.com>
 <dd99b921-3d79-a21f-8942-40fa5bf53190@samsung.com>
 <CANpmjNPbMOUd_Wh5aHGdH8WLrYpyBFUpwx6g3Kj2D6eevvaU8w@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e590c4f6-ad6a-26a4-4f5f-9e6e63bfb15a@nvidia.com>
Date:   Thu, 22 Apr 2021 09:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNPbMOUd_Wh5aHGdH8WLrYpyBFUpwx6g3Kj2D6eevvaU8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b2d5bf-fba0-49a2-bcdb-08d90566fc25
X-MS-TrafficTypeDiagnostic: MN2PR12MB3758:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3758BFD9334AFFC08B699A0CD9469@MN2PR12MB3758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nm5s+WgV7SQ8bBFfG1OlcKc4uJ8eghCmgsLVl90qOnH7vUoHUilS0KzakTQwzcepwt5ugpt55utCYrfBj/1Y8caAsOpqtF69hgQuFqbtkvXXOoya/gjp0VR9Fo72P5iNhXMqxGRTxi1vMLXtzxHYHkEe1oYToKMVExl8kCZAS/efyxYO4RqumzkN63dp6N6q/3Nnc2eE2VpdOylZJBnrDiJLIfNi6R30GodaE/UWY+yj5X9BT3Cv2slDjMSwsmlHZzcbR5nQ7ho6/Kn80NllfSBWVDBHRoCzj288AvgQ4gYaguKF+ZLmNnCHH9a++5d8vW892rLv6M3lLCcgQW/Vyas7DEUncHc6sn80YYBmOptNvwE3cGVDiz1aOxlW4LIif6T7WAs0gVO0cdawLjcuoHoyRXYyKQi+/BZ8CnCbwnO0P9VTHIP5ho9Wse+2lZWZRHEo38NOS+ImQI2Lzvk8fucnoYyypZbvGDXXEGtyIxkIIxTfqhC6TUveqoAs56j3HJ6m6sX+p1i3i1Rq9eCNKoLnanjUOiI3kZYQnU+sJnaiV790TwJy9J32EWuEi1reqf6a75CIfZjGHyTLx6qG8OeTCPCwpP0c/DCbqckI8BiIg6eueATDXyqg9ZNiL0B9k5qFe4SIhmZVFM27OV2a+JRGqiCqxNZHKYRIldNIXqgwf/kwdmwB7o5iHPYbp82L/VcQRak5K6V9BjLh/WrokNpemkKLx6wZgu/V0DHHTNbRd4UNxygJytVEFq98zeiFd9J+ns7urgpbOaX7dOyhEg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(5660300002)(86362001)(31686004)(7406005)(36906005)(7416002)(316002)(82310400003)(7636003)(82740400003)(83380400001)(31696002)(70586007)(70206006)(356005)(186003)(426003)(36756003)(8676002)(4326008)(47076005)(16526019)(966005)(36860700001)(53546011)(110136005)(478600001)(2906002)(54906003)(16576012)(2616005)(8936002)(26005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:16:52.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b2d5bf-fba0-49a2-bcdb-08d90566fc25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3758
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 22/04/2021 07:47, Marco Elver wrote:
> On Thu, 22 Apr 2021 at 08:12, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> [...]
>>> So I think we just have to settle on 'unsigned long' here. On many
>>> architectures, like 32-bit Arm, the alignment of a structure is that of
>>> its largest member. This means that there is no portable way to add
>>> 64-bit integers to siginfo_t on 32-bit architectures.
>>>
>>> In the case of the si_perf field, word size is sufficient since the data
>>> it contains is user-defined. On 32-bit architectures, any excess bits of
>>> perf_event_attr::sig_data will therefore be truncated when copying into
>>> si_perf.
>>>
>>> Feel free to test the below if you have time, but the below lets me boot
>>> 32-bit arm which previously timed out. It also passes all the
>>> static_asserts() I added (will send those as separate patches).
>>>
>>> Once I'm convinced this passes all others tests too, I'll send a patch.
>>
>> This fixes the issue I've observed on my test systems. Feel free to add:
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thank you for testing! It's been sent:
> https://lkml.kernel.org/r/20210422064437.3577327-1-elver@google.com


Thanks! This fixes the problem for Tegra as well. I have responded to
the above patch with my tested-by.

Cheers
Jon

-- 
nvpublic
