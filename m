Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7440354E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbhIHH2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 03:28:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349021AbhIHH2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:28:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1886xUvj010790
        for <linux-fsdevel@vger.kernel.org>; Wed, 8 Sep 2021 07:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=8uprgzeYzOx6dnkDmqGHvy3DGPyp6SaoxSi9MkpMcMM=;
 b=ITZoRor3dvMtl7F6OHwA6qiItpUL+L+cxSrhqY5/+k/vVA4Ge2EthrS3i6Z2hhvhIOLm
 D+U16gK6x1AAvo6YcTNsRIwOc3U8UW168lGTZHx+qmnHaH9zMjeC9SgaI9P85ihsqCsY
 uvTq0ENbBcXkNCLYDZpnBenmwSoyzjKJ92VFNIDeBjfe9FguA+8FspBg92ARSm7CSbXg
 E8gMInQZ2NM71ecAPzNWRQfPeTRIq0PooFWcL34ydj2kFWZg4yJRVLoCC/Hokvgtr936
 D2w6IYLeCRdl1zU93L+S8B2yhd7drCnMHK6VYS6Y8SaiPcstQ0auWZ4mxM2/279WW0XQ SA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=8uprgzeYzOx6dnkDmqGHvy3DGPyp6SaoxSi9MkpMcMM=;
 b=cA5iVN3VTjGXkGphWFIG1zA4X90I9yA3ESclYzNwu6F7bG8kuOsrx/g43jUw/9M+MJRZ
 Bcrlwxri2tkIoREX/JkEZJ4oTjMPijEU8F2+YhU5Szid2zRiCjH5MBwC5miy+lWJXhiz
 KwDOzF14h14ZWoXaKaPQ5lUFpL3g0pN/06LBMWlhpHcEfKYhD6qb6VEwuJ1Osuy8GREr
 NL3NjMxeWwJGDOsc/AxJCeDkQjNKqU/393EAqPU0cfwn/NnRWuZRJ/CO3LJkSUKzats3
 dku2/jutu8JUKCwnTKSHhUBPhhMpvfFrVVy+SFSJdd1mmUqTUFFKKe3BYhfL1NQ3gvKf SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw69nwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 07:27:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1887GFFd104063
        for <linux-fsdevel@vger.kernel.org>; Wed, 8 Sep 2021 07:27:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3axcpq6efp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 07:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn+i5qGwjZUBQiM3droo9R/7KJtf3Vefa75Y85SzcK7NUfSAwXap8ff0QyRdO+/401XvBvw/n66RVQjmGgbAnPxjdPAIBVYrr4/wB07zylmkW+cKnqc4mz6rsgBLytE9z8gdsVZ+9O1cb0MPMmZBjmn6D5F0MhP+o5mIkfojgDaVS777KaIXZhltsURFH/YE0tJn6vgupGBclYxrnFj9u3QPjsnMYVOrUWycErXYGXpDmtc7uWPNq2MfWow2N1oYpzFDlJPRnMd5PnZfApeAEQ2irSYxzM33L7ehrXlnbgPXvJ8ZfjmxMdNjflx6B+Olkm4hmqH9bSFP2T8bxQjQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8uprgzeYzOx6dnkDmqGHvy3DGPyp6SaoxSi9MkpMcMM=;
 b=cb5Gu1Q1mV0lkWjP2KSBLsARa3+5R7Rifzc8yFRerLoIvhKlK9yrmu25gZkd6AwAxMsGxI4RmLagfgUkRD+PIB6AbsyG2cFCrn6ksrUIhO89b+r+i6shSqgodB5tkg1FDG+Spz9c1y6jwVNle5S3h+IRcdqucjqpCxW30cFvi1RwxTbC2oAo72rvfkFwe3y6bD32owqg3Hi25NRejEo/nTax4sg7NMy65vgnQ/EQmwHVttCLvIgGo2GzNCgg1cW5GX9iDm0RaEbH0y1Qe01yFPcxUiV6eNArHkWqKYwlCdRlaG9pGdAlobCbkumQeCQbQYKYnznTkqo0kHjVUeiYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uprgzeYzOx6dnkDmqGHvy3DGPyp6SaoxSi9MkpMcMM=;
 b=oG/KzPQ4LJtBQxgaE8/+hUAGNq+OkN7tYVokAbjq/77P0rG+4xie79jEj+fHfi19VslLEkOWlwTxWquLwD7l1qHU29epC3M3hDURAhHkmQg2o5RpxkRFmTRde2uwVJ4viWDuqFsc98u15CzuZZhN3SbYpMlzV0EtHkdhYLYG4t8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 07:27:24 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b054:cb04:7f27:17fd]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b054:cb04:7f27:17fd%5]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 07:27:24 +0000
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Allison Henderson <allison.henderson@oracle.com>
Subject: [TOPIC LPC] Filesystem Shrink
Message-ID: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
Date:   Wed, 8 Sep 2021 00:27:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
Received: from [192.168.1.167] (67.1.243.157) by BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 07:27:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c643b366-5f57-497e-6ce9-08d9729a1a9c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4447:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB444771027F8D9DE523FA129695D49@SJ0PR10MB4447.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wM3l7/XbSxgKGWNC9JHPTAQwjj77djjJgX9MI4/xTbOAIaLH3Aojg1lnYOCoOH0a8rSzMbwSIKsg1RUUx0kVMllqhCb73yv7gW6JKwINm7f/bVCYoYX987mpDyKQ93TUPOeRN+Jn3WhzJ+H8Mp0MPxqdk6E0HhTb6Zoqjx5NjKBjKGmCGTh5zqDSlNdhV6kwRLGIKGqyhQ7aOnMcp9u1lR2T4bwADdf7wveiYa1Sfliug2J6cOqBryTLGlU9k7WVRoR6RJr0JbUdHqaTf87ZBlFaC6Kia+rzbS45h0G3sM35EMMucyk88Y0El1l3DOF2R5QN5l1Tl5VPPnWomdM1+M+91H4NFcsPiJX6ohhnNfrChWJi1zKY+g4dZG5bil1HzoAKLdJ0Wc+dg/wU92rFbs1/sIOjb7TewWE95XCqxTOIc94GSz5V3pnuzjOnIVuUNQaHL4HiSU2e35bBTwAXULSJ0RVOKlvvn2NCAho99lGuzwo4xTf5hVzi28H8r/7bZbd1rkXllww0d6c879POgC4efxXj4JcIuycm1kjYOGHzkPvAG8d4E0oyRlfynHZCKlVf7mqF3XM5THVIiXFibbEk8xIP7kL80Zwo8MFKP9phwQasK806K8wV0A/B1sg+6cgENSbttix6XYSa38UJY1+TSKl4BMeZY+sfmMS3yvNUJYO9LVGNdCOLwccy9BMmWoWVvO/pX9P+gwfEWvUXOKqG/VYy7h8ZtPIusCNNnLoEhy4+BRawom/ZykcloIGoFAxGo6szX31oskdZ2VUCUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(31686004)(16576012)(26005)(44832011)(316002)(83380400001)(8676002)(6916009)(186003)(6486002)(36756003)(66946007)(31696002)(478600001)(956004)(66476007)(66556008)(2906002)(86362001)(5660300002)(38350700002)(38100700002)(2616005)(52116002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURuY3IyYVpmdWdCQTRBeWRiM2dKOGs4OXZuUXR6V0s4LzRFZTA5eGxZZXpw?=
 =?utf-8?B?VU5XVXRGci9qSFRMeHI1SVpRdjhnY2k3dGV4amYrT29IalhYZDFleHdBcWls?=
 =?utf-8?B?Z2UyenF4aEl1aG9pVVlsVjBNbStZUjF1c29hSHJlbGZwT21DZ3E0Q2hxVWRo?=
 =?utf-8?B?U09vd0NVMkh0M2JZUjVDMElodXQrNlYrTHJWeGFBTUxobkIvcjdPcU5nTEw4?=
 =?utf-8?B?ZXd2VVFQanVncWVoSHBHWGI0N2VXRTNIdGMwNU5WaVBGcHd3dnE3WXYyME9E?=
 =?utf-8?B?VlNTTDdjTG1jNzUwWkRsS0VOSTVQa1RvaDFOVDBWQWwwbzRmWUIxcmRVQXB0?=
 =?utf-8?B?TDQ1UjZFcDlQeVpYKzhiMnJDVkhPRFRvbXNuN3RlL1k2dmRRRTBtUTRVYlJF?=
 =?utf-8?B?Q2RxSzlFeXpLRnVXbGpXOUFuaWl0eE5tRXJ3SmVDb1lQVWJRbFFKNTQ1L3RV?=
 =?utf-8?B?TG5XRU84Q3pQZ2tqWnRWdVRkYThaTEtGek4vd1NGZElxUFF3eWlacGwyNHNv?=
 =?utf-8?B?elZOcFd5VExnRE85ZVhJa0JmZEYrb3NuUHkwcDZDVjB2OVArQXZtQ2ZOeXUw?=
 =?utf-8?B?RytYSnJHUWdobUdtVWIrdzlIaXRVWjMvaEhOWjRnQVVEekRLQUlUVlNkSWRK?=
 =?utf-8?B?RzRPdWRwd2UvTlpEUGNWRGt0NUREVG9FbG96TjlMblpEa1M4TDQ5VkUzQW5u?=
 =?utf-8?B?NG5qZjV1RzdITTh2emFZaVczZ1RxNUpiLzFpWGVTNXE4TnEvbUJsSWRDTlQw?=
 =?utf-8?B?SjVEaTJWdnFmNDNIYUdlKzVlaURyb2RHUWZNL3JQNTZQTDlvdG05ZEFvV2w3?=
 =?utf-8?B?T0QvK2J3RFdLejVwQ21BTGlaK2hLdEVyelhJNmNIZVZRQXViTVIwNVJtclJQ?=
 =?utf-8?B?ZFFzblpTZW1YUzRPK1FXZnFOeXgrVW1KUVNpOCtiTGd1OW1vMEJpQmV1SUNy?=
 =?utf-8?B?UjMvMkRXRE9tMHlzbjJKb2I4RzlPR2FZbDF1MEZaSHNobis3QVdOZTJqSTFI?=
 =?utf-8?B?VWVKYnp5TnZuaElXYjhoeGRwa3gwMEJlaUwyWkxhUDdpS0QxVW95Z1cvMkw3?=
 =?utf-8?B?SkVFTGVoWWRGaTBscFVRWkxGWUpreDVubjJvbTVLVlJ4UDFQRGFwNysyNXB3?=
 =?utf-8?B?YmNaMWdEd0VsWGV0Z2ZtRXdHS2ZqQityMDlyWjBUSHphZkk4N3ZWOTJvSWZG?=
 =?utf-8?B?YnQ0Wkp6SEdQVXIzR21ndnhsM3FLbHVLNUQzVzViUjhLK0hQSW55dnJtektE?=
 =?utf-8?B?akNvSmxvU0s1QjQ0REdRTXlLUFdPNzZRbTcwR1cwbTZKVS9kZzRqV1RDdXA0?=
 =?utf-8?B?NmdHeEgrc3FyTE1GUEpmZ3RJK3p3dXcrKzhqb0xVM254c0N2UU9aZDlQbDcz?=
 =?utf-8?B?bzZFNVhLa1VKekFFSDBsSVVyOTRMM0FiOERYQjFXNEROSXIwOFFIcGNRVHJm?=
 =?utf-8?B?R1VVdGUrblVzN1NqUjRaSXFFTWV1cVIzTDNEWVBrVHVVNDgvby9wYytheThz?=
 =?utf-8?B?NGpIelFKNGNHV3ZqR0FsTTBNQUN1bC9sSHYyaFo4Y3ZVWmU2aExtUXM2WGJ4?=
 =?utf-8?B?UHl0NjdXSEJXUkl5eUh2NDVvZlZUK0hFUHRQOHN2TDZNNnhzWVhjZWJ5d05D?=
 =?utf-8?B?UzJsTktoaEI3Zjk1cDdIaGMrYVcySENPZ2x3TEE5bm9jVldpWTZVL3hJMVNs?=
 =?utf-8?B?U09QVHV2V2EwamJ6OHpBbEtrUG5pbElXKy85OC9vSURMdlV6UVpvWWlzcUFR?=
 =?utf-8?Q?lhS2MqilkmfSZXcWyub5cXAw091EzUZCIgf6ZYu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c643b366-5f57-497e-6ce9-08d9729a1a9c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 07:27:24.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E04VZNsYCrtZH53LGVr1O0yQTazOTi6CeMVwMOzl9pwYsJWE+uJgZGCJNaBivLtzBWLK4VghATVa3mF0pyyIR3RV4gv1Rvy+DPAn/twJ6/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080046
X-Proofpoint-GUID: 4hXvF_3yxQySrbqkG2ZJFcW_x9uMjmtw
X-Proofpoint-ORIG-GUID: 4hXvF_3yxQySrbqkG2ZJFcW_x9uMjmtw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Earlier this month I had sent out a lpc micro conference proposal for
file system shrink.  It sounds like the talk is of interest, but folks
recommended I forward the discussion to fsdevel for more feed back.
Below is the abstract for the talk:


File system shrink allows a file system to be reduced in size by some 
specified size blocks as long as the file system has enough unallocated 
space to do so.  This operation is currently unsupported in xfs.  Though 
a file system can be backed up and recreated in smaller sizes, this is 
not functionally the same as an in place resize.  Implementing this 
feature is costly in terms of developer time and resources, so it is 
important to consider the motivations to implement this feature.  This 
talk would aim to discuss any user stories for this feature.  What are 
the possible cases for a user needing to shrink the file system after 
creation, and by how much?  Can these requirements be satisfied with a 
simpler mkfs option to backup an existing file system into a new but 
smaller filesystem?  In the cases of creating a rootfs, will a protofile 
suffice?  If the shrink feature is needed, we should further discuss the 
APIs that users would need.

Beyond the user stories, it is also worth discussing implementation 
challenges.  Reflink and parent pointers can assist in facilitating 
shrink operations, but is it reasonable to make them requirements for 
shrink?  Gathering feedback and addressing these challenges will help 
guide future development efforts for this feature.


Comments and feedback are appreciated!
Thanks!

Allison
