Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39C4A2B0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 02:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352062AbiA2Brz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 20:47:55 -0500
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:41345
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344830AbiA2Brw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaQvDY41ZkJOErtocNz5WvWSF1CRu+QB6AmYr3CGAGG+igd7eY9bNkIWQIVmRAda7yyHnBRG7/kV54u2azjFgDcL4asAFl+Jq6XxDZJaP/XPoaMBizgpbeY1qcPYjSwZm5HllyDFpxZP7pjrxLBpvB1HegVLVm6EJ+Q3P2B9zZT7HDEshHGXdmmQtUH0eSmdp2WkQnrZFObeN+yRYbHlBntNBfHKfktPArn7+ECvpasaU21CZjfx3ZwziTp0cV/+8A/7Hsy8SaYVFYYORLkOcf5+LCruGNutwEjbgX4FEXFReee5yRP66xNRP7+wbSocQYbj0Iavn5xHcLsN4b65dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbqSoTeYxV7jPqlFn6ijrE9aPAUzRh9uKQKHfXBPpWg=;
 b=O6CRnPPRl+4zfhv9ALHfD8A8KjZx3TRMy6XQgon9NTmQlIIvDpFw6Gzlevk+4yV+38le/HvtVIOc4HTfHSdiHBRBv0PbfgFcekiz2ZTEOegMOJFbMlsyCLAB2oSR5oPPmeW7WVAIgmXXTT1OBRXvj3EjJlZD2xVmO2NfvoFP7PSRwzo5kzLODwbEVuHj/DSg92l7XHarEIw1zuBF+k5zGEmXQ8b7RUqQxX9fefigkFqxePAvJHYBrwjrIgWRyO6mlPY+iYv82HRbC/LYYkdQm/xtwSayXeRBxuDZ+ZqBK5Irm1iDY61ShyXcqG6RzCdUwH/+fghiaZCRfMx9hj3X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbqSoTeYxV7jPqlFn6ijrE9aPAUzRh9uKQKHfXBPpWg=;
 b=Bj7/SxBvONbUBmORZxBHVDreTLyxut6UoyPLjgBvP6K8X6kr0zJkPH3tfE7GsYvMYvONX4F/z/CGGwH+WC9mpdkmywmVgG8SrRJ6nftUhHlMniN9I77i3RTWtLbPbcmbkvPKDVqTup+sAVqrLbTvHaMW5lFGs77wMcKRD80wEMzhTzbB0/m0L57z6ekBXbQ2lAiUOvfhbsf+mrv3m+AGz5i2eJZVnhAfWa1aPB/wepcZrICUWCpUSNzAiVeXm0HNiD7XH5h1Ev/BXgddfYue1esQld4b28G6uLH4p4rLTg2CpnFjlKZSgKAlXJMkLqTwZBrK+1ELih024AEmGz6j8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 01:47:50 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25%6]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 01:47:50 +0000
Message-ID: <c6e152ad-2b31-48cd-3d5e-c109d24a0e79@nvidia.com>
Date:   Fri, 28 Jan 2022 17:47:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gary Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Subject: [LSF/MM/BPF TOPIC] FOLL_PIN + file systems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e59b7e1b-62bd-4b38-860f-08d9e2c95ba6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3488542EED410FFACE516891A8239@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0BnBFBmB604Do3reug4VWSQPtmp+hf0b+IaQpeXXJLkvGnYTmd4EYo/5nnkDAKUqvPCGednXasiS9VzeG+ofaos9WDZAQSZjHS3tf0Ui9Nd6Z85HFrHpIqri6IhZxhLfJtOXxnm6Tw328zdG0Llk7q40pybGOFDQFLL/xeXzjLZhh1pFCexCFLoFez8MJ723WBf/k7Zk1PTPBU3R3bVNvFOEINpuTT0ug+2wj/kwkCiX0VipNNTsgqolnQwZCvH9mXPDFwlMN110B97h4Eblo39syPl1NOGBaayn/ZYbaWLxDZSg69EjD2XAnPMCTU9XAlIQ2WyP6qh/tUbGTZp9504z3rxeeYOM0aej2TAlW17WPdxww177JP9Obf13mfEwkyUqCS4Qur7sQRvo3nbX0D9RZlS+ukyC9c3eO8v4xvI193VcsMI/5ake0Q7dlugzkZRe1/SQlLTL8Q02qgC7pbceauJS9H2f6DedznzbiE2gqcDZ93F2xANQgxHm6ApQ8GQPhiHUmMdq2FG1aO7MOXnkcC49F41o/6mOan6r3mSD+ENooVNrkKUZ7EMShqsjTGN4TGLxm60a8b6oxtpAPIYFwzu/hmaSh+vWqpucnTgmRLJyoA6reKXGJCbkdGrPw/4zkcDCBOKuckyUfy+VIFCY9IjJvWYUnP0suKweQ8mUER2KxDtrKgVsfftOiGjueZEGOpYTqAm8g+cVu2qSO/zfsSktcPjMUNR+NDG40egpfc1H6+4VjaESZ5x9baB9GC5DDznw3ikG1t8SzEOv0++eHczSQr981Anq+dwvW1MaNIlxrkqLmHHZjF3C/4xYjmN9dfGumattFaAT4CX/eGDjp7UU1TtfitBtcyhBbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(38100700002)(66476007)(66556008)(31686004)(2906002)(66946007)(26005)(186003)(2616005)(83380400001)(110136005)(6486002)(966005)(5660300002)(54906003)(316002)(6666004)(6506007)(31696002)(4326008)(86362001)(508600001)(8936002)(8676002)(6512007)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3loK24wb29kZlVROFViRkVwR2pja2laZ0VjNi9ad3l5L1V3MlR2WnpMNjhx?=
 =?utf-8?B?cndMT2V6NG8rZzFTa2RTNGN4WWhyMW9LbmxTeGd2aDRadnhQeDZ3K01NZU1G?=
 =?utf-8?B?SzlxbVJwKzkxblZJaEJKM2dNZExsWS9TTUNnazZKK0c1UU1WR0VpQzRDU0xl?=
 =?utf-8?B?S0krOEFyTnVvVDRReHQ3RGNxVG9vc2RLYmVIN01oMFpFMno5N014ZEVGQXMv?=
 =?utf-8?B?ZXFxZUNwclB5R2ZRRUExMUxzQ1hScXRMU2gxR0tCL21FMmZacTVhWGZBRExK?=
 =?utf-8?B?MXRNU0NiM3lWMDBXbnAxT25NN2FMNXVZeENoRGJFTmFlYzBkNk90OHh5WitC?=
 =?utf-8?B?cGNKdVBab1ByREpxZ0o0dnFObC9FYXR0b0tpaGxRdXp0SDR2ZUprSUx0bm5T?=
 =?utf-8?B?cHNldGRlenFTNWlCa25NRHNXTWQrQVd2MERKazhjZWlKdTZNZS9nTDZvckxB?=
 =?utf-8?B?VDdYLzhjSDBSNkc0Qk9JeGh0VkJiOHV3aTFsWUFmc2ZFZXpkVTd2am9HVWJP?=
 =?utf-8?B?VC9YNlBTTzIwUXhPa0g2UXBBZzNic2dOSUR3OWpNWUxvOXJwaktXZmgxWmxN?=
 =?utf-8?B?MUNGMWs5K2U1ZW9yTlFtcSszQ0o3QVRSQlJBYlZEWGluUFNwSGV3d1FsK2Y1?=
 =?utf-8?B?MG9QM2Z2RlhWSHY1bmJURytzZUJHbit6SHZuZ1pJa0Mrdko2WkNpT253QjR0?=
 =?utf-8?B?V3dsOFY0T0FYQTc0c3dPSTIyeHEyOXZQVUY0R2xUTnFXYVBDTzN2RFMrUHBr?=
 =?utf-8?B?RXplR0VlY1Z0UkpITXdkb0xTdzZkR25oRWNWQ0tEYTFERjY5d2NFMWpPUVY0?=
 =?utf-8?B?YWhyM2I0Y1JGdTIrbUUwRTArbjNsS3ZubVIyRytQbEViOE1NcGZLNGRORGRs?=
 =?utf-8?B?R1lXNzAvbFVmZHJqN2tac0puT3ZUY3dJb2FXMEdqc3ZzMnVheFd1b0RQREpx?=
 =?utf-8?B?SlFpdXhoMWVFUEVldDZXK2N5Z0lVKzBXOC82VS9FbGFUbUdCVlI1clNTMmF4?=
 =?utf-8?B?RjdPellGWklMTXl1dzJGd3hyUHVQMlZjQTlpNXoxQXc2RkpmSitacHc4eTRm?=
 =?utf-8?B?ZXdDV0M4dnc3N0dyZXBraDdrbzJYcGlwN25lTy9UY2drSzJjc3pmU3NqU2Jq?=
 =?utf-8?B?NTRxN2hERWlPMEhyRWZqaDdhYTR1Y2xsekZEcGNkdkhIVVhrSDlMbEJXbi9L?=
 =?utf-8?B?RDVmZFkwNWhMS1Z5RWoyUGdXVWs0MCt0L3JLZC9xckJjQ3NGbG9aNGlxc0NW?=
 =?utf-8?B?cG1wa0ZRY2p4TEhRbWFsa1FXbDk0M3U4N2dOVzRkZUF2N0ppY2NTQ1VFYjRT?=
 =?utf-8?B?R2VPMTY4TzdmWmZ1RElzWmNyMmVFM3lKNzZORC9Jd3J6U2d3UXlPdjZvYitl?=
 =?utf-8?B?bWc3ZUc3S2FVdkNWY21wWndwNEEvS1lMY2ZYZ0NjL1c0SG9rSWZTL1ZMdTcw?=
 =?utf-8?B?VGExOEdhLzMrNTQramx5U1E4c0tTb0Q1OG5qWEoxODh5cjdWNHVlWTlKb0hV?=
 =?utf-8?B?RCtZSXBjQVg1WUtTcXRIVVJ4bkJZSkRESGpBS3ZEc3JoSDF2MUNMNlcyQkJl?=
 =?utf-8?B?VkhZUzFIOStkd1VoVlczQWRMczFsbS8rRm1HRTlVWnNpT0pxdHpXa2RVZGt1?=
 =?utf-8?B?Zld0T1RUYUE4bGFZbFEwYXc5SmMrKzBPRElDT3cyOVVmY1E0d2VrekxVS1ow?=
 =?utf-8?B?Z2tRN1p3WFNEaENqdVljZTJKTnV6eWVLV0Q5L1hUZWJTTG1lWEpFcnBUakRZ?=
 =?utf-8?B?TjlnWU0zMXlVVTg3T1pKdEp1NHczYnh6N0JmVjFQZUVCNjZ1NVN2Y1RGQ0tv?=
 =?utf-8?B?N2NodFBlVmFtUittcktPNXlpVC9WTXpZSlBzbGFQQzU0ekZqR2wyL0FNcG9B?=
 =?utf-8?B?b0E3QUZyV2N2SEZNMnhJd0VGNnhaZUlRUnAzamVqLzZreitLeG9Pc2xQbld0?=
 =?utf-8?B?MlI3THphNmJXTDJodzRNMzcvR2xuSDQ5TmxnR1FaYUEvVHFPU08vZ2dLMFhV?=
 =?utf-8?B?b3k2ZE5POEQ1UTBaM1p3RFd3LzJmZGZ1TzVXZE0xU0dxYnd2cUwvcThyR050?=
 =?utf-8?B?aUI4N1ZLOVY0TUxoa0NVcjF2UytMRDgxSEVwcDlqWnZ2d2tyQ3ZCTUxKZjNa?=
 =?utf-8?B?OVNrYVdmcngwZnZQU001bnphZzl3c0FSeWZBU2h6a0I5dmlKTXFpakZUZ3Mz?=
 =?utf-8?Q?IqFgZYZ56yBTwo9+KT17Mok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59b7e1b-62bd-4b38-860f-08d9e2c95ba6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 01:47:50.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I/3AP9gTKZ9V9UMOCQByfRh/xbneuxMgUiqc/UdEmT0eCE3qfq8Bbq05F2ag/n7ok2prRh5+9jsec6jdHFdBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

By the time we meet for LSF/MM/BPF in May, the Direct IO layer will
likely be converted to use FOLL_PIN page pinning (that is, changed from
using get_user_pages_fast(), to pin_user_pages_fast()).

Direct IO conversion to FOLL_PIN was the last missing piece, and so the
time is right to discuss how to use the output of all of this work
(which is: the ability to call page_maybe_dma_pinned()), in order to fix
one of the original problems that prompted FOLL_PIN's creation.

That problem is: file systems do not currently tolerate having their
pages pinned and DMA'd to/from. See [1] for an extensive background of
some 11 LWN articles since 2018.

In order to fix that problem, now that FOLL_PIN is available and wired
up, we should revisit some of the leading proposals. For example, using
file leases to mark out areas that are safe for FOLL_PIN page pins, is
probably about right--with enough caveats to avoid breaking things for
existing users...this is worth discussing at the conference. This topic
has been contentious in past sessions, but with the recent progress, it
should be a little easier to make progress, because there are fewer
"variables".

I'll volunteer to present a few slides to provide the background and get
the discussion started. It's critical to have filesystem people in
attendance for this, such as Jan Kara, Dave Chinner, Christoph Hellwig,
and many more that I won't try to list explicitly here. RDMA
representation (Jason Gunthorpe, Leon Romanovsky, Chaitanya Kulkarni,
and others) will help keep the file system folks from creating rules
that break them "too much". And of course -mm folks. There are many
people who have contributed to this project, so again, apologies for not
listing everyone explicitly.

Worth mentioning: in addition to the Direct IO work, FOLL_PIN has been
used to help improve the accuracy of copy-on-write (COW) behavior [2].
And that eventually led to some speculation on Linus' part [3], that
"legacy gup" (wow, someone already said those words!) might eventually
be rare, and that most callers of the mm/gup.c functions would actually
want access to the pages' contents for DMA or Direct IO. Those cases
require calling the FOLL_PIN (pin_user_pages*) variants.


[1] https://lwn.net/Kernel/Index/#Memory_management-get_user_pages

[2] https://lwn.net/Articles/849876/ Patching until the COWs come home
     (part 2)

[3] https://lore.kernel.org/r/CAHk-=whUEZC2skXPUWy93DpNmC0VF=t2EwmEgWGx8aPstTmWYA@mail.gmail.com


thanks,
-- 
John Hubbard
NVIDIA
