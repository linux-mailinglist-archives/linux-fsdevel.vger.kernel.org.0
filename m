Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA956929C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiGFT15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGFT1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:27:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010F28E20;
        Wed,  6 Jul 2022 12:27:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IWe5b009665;
        Wed, 6 Jul 2022 19:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PhcciHriJEbtzqzXMlj+TeNew8DWgVGDWi9YP9j1LkA=;
 b=gthIH+fDjpVtSB2+xmgJewl7Okb3+yqUrcXX0qYOeQnfhBBTH87tQiLtR6mSyXaZyBDi
 0wvPzdMv6KJhWDrlMn5anbUmrgce3HbdpEGHdHMej+r4ioHDQ0X0B93rLDty8lWTAHJ6
 c0mwAPqasqfX5NcfkM7pKpCW72s5N6JyWk+e2St6b38N5mJ/A883ZLY0QHRre9OwH34H
 /r2vxo0eJ1fkSfAV8NkRjq/0U7LuINEaNWQ/qB+SIufR0I+YCR2Slb6yZd46Gncyc9/s
 3R7NNPR5yfaSulrBbzcKYdUsyLSUsNCQZLIzjr6cNXiR1lO1IsUrvHH3kvAL8q4LzHsp qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyb5g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 19:27:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266JPIiZ018350;
        Wed, 6 Jul 2022 19:27:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6bs5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 19:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxJZkOky2aXGFAsmNvOup22mYR+IOIG8cV1AF2scw0I8jtBnvGcHd9UAYrknnpdt4N9g9n9fo8na+vujTwXt2Sv85V3xa5EiOfUhRWSbbMV2mLGwQ7mTYf0n4S+Jx6UEQAwe5axjwqezU64aXX4zoAcEL1HVL53q09A6+g2+v7mx9bI3oR/FVYW3vfugRA3aLqnG2+6RdbILFBbup1YfFPMc6FDi3nKa8TJrpbeltsiCqJjVb2Dw+xqnz0WFp3Oup+L+4zulHVSr9DXsOIJJ9+0ORp+ulw9KX23rT9rk9lJsie5t7VtEzxu+5HseCQvFMTDgwIhf4C2ZsK+clZ1X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhcciHriJEbtzqzXMlj+TeNew8DWgVGDWi9YP9j1LkA=;
 b=a36cD3/NjnfW2aeF8N2W9CtuTw0i4UPpX8NnxMtzkjaLOi4feMyvjI12bsQJnxj55e5rhlRKmQPR8IQ1XvtaDQSp5GFsSsaj7YpycH371cZ2q+LQkpgWRyfLDia7Ath2+Gk2OHwjPm2o8dSuOc768AFcL5vp0CPZECZ0/82JLNMtYhUyG2H7Zn2RT1q+tnUuaNy4yq8eLTIIhE2skCLHeZAFi788zSKFULoV8g79m685Hg6gsWotUQQynJL93D9AUobmDkzwObQ0f4XKsvrYawYFtEL/eK10TqWPpPSLd/K4SjM974YQj2d7WCXKnjiLC6zMmK7ilI10RrkwaJmjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhcciHriJEbtzqzXMlj+TeNew8DWgVGDWi9YP9j1LkA=;
 b=LXcBLIE2oxl7LDSNjEyN8Foc3jlJV1wJ4Mx70tNE/N7DbBR/YmDDS6AYpGpakMHXY30AeI3t6vR/P8YOYAQyOOlkFW+J4Sl0QLjrCBUOFnt1QSpId7ZZc54tD5C75IRWYj4Ej6Nzxi38AMuFcf1AHdNNwyv1dtnG1fkE9nd5ekI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 19:27:06 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 19:27:06 +0000
Message-ID: <9f8bb458-439d-a10d-dde4-077bb28c702b@oracle.com>
Date:   Wed, 6 Jul 2022 13:26:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        david@redhat.com, ebiederm@xmission.com, hagen@jauu.net,
        jack@suse.cz, keescook@chromium.org, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c9434c1-4247-4c7e-25cf-08da5f8582d5
X-MS-TrafficTypeDiagnostic: SA2PR10MB4634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4Fnbao0czRz2ByVDaz0BgstFLW7snLV7oykQwFtHNGju6dDBpdoOG00ap1g9UYYgtg5sq85/Zb+0iobnfcoGBAd5MRjeMsofaZZ7A49NyTToE7TxzSeTSFRz1uuwMyQWCnLjHpnxuWBjjZT/ur7DL5R1pgz3JFrnIvxNAZoFUv9NgCRfdvnVvln+nUkwobZ3NU/BOyYDjuccMIUbKwZWIF+CxD0TLsGotOelPt5jHfu1zOOF91bFacW5Qu0NVod0piVoW/U9bf5mgjnI+kXe9WPbI6fbRxNmBiwquMDegO/dws7jtSFMBUMJUfXc8HLomjVKm81V9XDKXQzkgOjJl6l8xJkYw/o0K6s82+UnTDImiNp+R+1JY4b9CVzYtLG53hudb2EvQ2fT03fv37MYOMTJQuLdxw/12OpWHtPWIZL/wErFCFfiLcd6zTtLJil8NaekN+uNB0VhrtPkMrDoUnP4CGc8/4g3JDPvX8pSYJ5wyV9D5kAK1vBSyJI6tqwOESLYsWo0QCNi7OnPdgTGfThIEmC3JUuvAR0L6yn6oAPOeAReuMcMkNCfI+BmWi0awu/4WiBfSveXDGDAtWsV0bTRvVR4FydqCqBEOlozcRyEhcl3bPb+SvGoCNI2S0Q8R/duHWd0cI/DKdxvcOPFPM22Ky7pZ9OkcsBjDSYh9QpkIhE2/RkunuWhETHtumokVJKTgBMjSnVjxJu17+3K+fqohgiIzQ2lW6Z/K+nQMAUv+AsyQUdZP2vYXNaj0DVuNm2O4hR/FuwOzdVXn/HTv0BNeeyxGRuSwgoCIQjiAURqugCkijl88SDFHMblxV8QGv92+K9nZmyUP8i49gMGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(396003)(346002)(136003)(38100700002)(66946007)(8676002)(4326008)(31696002)(6506007)(5660300002)(66556008)(66476007)(44832011)(2906002)(86362001)(4744005)(7416002)(53546011)(8936002)(2616005)(6666004)(478600001)(41300700001)(6486002)(6916009)(316002)(186003)(6512007)(26005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVxLzVidEt0eGVMb1MyaGZNSEJ5dFRVa0lkM2NGcDhvekluQW9IeFJzVkpp?=
 =?utf-8?B?Zm91bEtOU01PTEVJRFN0SGlESlNZcERyZTRtZ2J3WTIyUEJ1WVhSUkhOYndE?=
 =?utf-8?B?UDc5K2pzZE05MjJLMlk5OXd5NHJqL3NHUUtyVzR5eHZzcktlWW1QZHdPR1JT?=
 =?utf-8?B?SlZ2NXpWazBhelR6ZzAvN0tDM0FyWkNFYkJxUm55Qk9IVGtPY2twcG5sUitu?=
 =?utf-8?B?NEZjN3B4SVltRWtiSmMxTkZoUC82N3Q5WTNUcDJESDdSRGlNOUJPeS9wMk5W?=
 =?utf-8?B?bG51ODh6NnZrTWthdzBFc3Q2bGQzTTVGSlBnbWZDVm02TmxFV1pUaTRtWDFU?=
 =?utf-8?B?UXlyY1IvT3lRMHdWSXlNNTRjNkdLc2ZMT3grL1FXZDFDbUd3NVVIYUdibFp4?=
 =?utf-8?B?NjJNeWxERXFNbm1TOHpPTXVjMUlFaEJFL0dLaTZKTSs2YStXRS8xcHpVSy9q?=
 =?utf-8?B?bERtckI0akl6VjZzeXVoWlZERDUwelB3VDhHWDZnUTloWTVvN2NzUWJiRXVL?=
 =?utf-8?B?MzhEck01bGVxblA5eTJDaGs0WitNMmJKcllvY0E4R1FmdXF1M3Z0YUV2R0Ra?=
 =?utf-8?B?ekMxNVV4UmpTRE1jeERVSWJmcjdCVWtKUHBzVkYwSjhFUkNKNFM0NWdLTDJh?=
 =?utf-8?B?aHZSblRrN00zMU1GMWVHQnFDaUhNN2k3QjF0bTE0bGxuVWZXSGROeGlLV3V5?=
 =?utf-8?B?WGozcUdjY3dzQ2xyT3ZkdU1FSGhjV3ZBcWFlVUlaanBrdXNOSkRyWGgzVjNN?=
 =?utf-8?B?R08xTFNKNzJyZ1FCTVVxV282Q1ZTQ3VNYjV2TzFzaXlzbmphT3BEU0gyRnNk?=
 =?utf-8?B?QWkvUTh3RTJKQk5mWEc1OHQ5RlhpdDlPREFoTTA2V0NVYjdwUTJRaUVzTEpB?=
 =?utf-8?B?RlpxS1dHS21qWlZTdnBLVEQ3azkxQjM2OTdTc1MyRE5OcVNuRGhJYXh6b2Nz?=
 =?utf-8?B?bG5XbGI5SWk0Nkd4UWhpcGFxWS9yVnI5MjV3SkhLNXlueWlwZ2E1S1lBRE0y?=
 =?utf-8?B?dXhpQTJ4S3BMdFlBQlBHc1VreUNkR3owWmFGSGRzRHdMSCtJV3hkb3hRMkEx?=
 =?utf-8?B?bWdKNXpmWEVsUHJrcWttNnczOXdNZlduc0JvV0owWTRXN0EwQnhFNzA2YTNa?=
 =?utf-8?B?RGY1azJ1YzMrMnF1dTczWThoTzZGQXhwdzhvcGt3UTVKNGNUTk1jQXVHb3pC?=
 =?utf-8?B?QURLUVZLeG5iaUh5cndJMk1TS05FQjZmWnlRYlNPRVJId1daOVlwbHJzS0JB?=
 =?utf-8?B?K2hsTEgwNkpuZU5pd01DWmcxZmxKRG5PdlluaDNTMDRGNEE1TnRGbzlTK0VB?=
 =?utf-8?B?NTZOZFVkbUw5Qisrb1dEbmUvaFpsay94NHJUSFphMzFNVDBuSTI5ZXd3Y003?=
 =?utf-8?B?b0tZam9EZzA0blhKbXBSUDFZV0NTUTRVRUR1QU1ZeHdKaW1zS0ptSElrdnpG?=
 =?utf-8?B?MVhuNXNvMVE2aEh5ZkZQQzh4WTZ6VmV4NHFZSzNCbjJRYzFJc2JlU3VFNmdj?=
 =?utf-8?B?NE5UVURMTWlEMmRYUDF0QTVkR1ZqQWM5ZHhlZGUzTExOeDh2V0dhY3ZrVE5t?=
 =?utf-8?B?czJMdmFvY3pDQXpaZ3dXVEtxVzZ4R0xPS2pCY3gvZEI0eHhXdUNFZVN4akgv?=
 =?utf-8?B?UjJWbDgvYnM1WU4yQ2NoT2Eydi8ycDdRVlRTbys0VnBUVG00eTdnc2U3bE1S?=
 =?utf-8?B?WGszbkhMQTN2VVI4eE9wWW8wc1k2VldDZkZSS3o4aUVmNzBmdU1mWUlDZENm?=
 =?utf-8?B?clVMeENhcTFJM3dBT1NXWStFUWx5Zzc1aVR0RzVyaU9ZeHk5ZGtqR2pRb3RQ?=
 =?utf-8?B?TVl0SjBubDJnaVZ0UUhYR0htbGRkMjU2bWVYSVM4T296WDJVM0hwRTRlRU5K?=
 =?utf-8?B?VkVWRzJtVmw4TSthYlB1Wlk4ZWxKWU5zWGNGMFY5Nml1K0k1aTIwU01ZeDJG?=
 =?utf-8?B?R1JYL1BhRGdIdmRHcXFkUmZUVUMxY1ZRVFl3b2JxZ1UxSTlLdlY3eHpINnF2?=
 =?utf-8?B?R2VZclhuZTJCSEpXR0lEbkRkOTI4WGRURUU4elZtTG9WRW5iVjZHcmkyMTF6?=
 =?utf-8?B?Y0lIUmRWRTNnRTFid0tuKzlJNnVnVVpJWnF1T2RURW9uYzRmdERlUkc4UTQv?=
 =?utf-8?Q?BtJ2OuLFzJJKktpalAl4fffwH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9434c1-4247-4c7e-25cf-08da5f8582d5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 19:27:05.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxUrCXT2I67MmjBOB48alKNlBXTdvXlDTEBkQtEj9B5Jru8pQa/iVvKPv/7WM5z6Jk0B4wKM/Ac8nQXY+G4XLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_11:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=898
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060075
X-Proofpoint-ORIG-GUID: 3EMInjdqasQ4SJr1GBwJOm9MrmhRQPsV
X-Proofpoint-GUID: 3EMInjdqasQ4SJr1GBwJOm9MrmhRQPsV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/22 22:24, Andrew Morton wrote:
> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>> This patch series implements a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. It adds a new
>> in-memory filesystem - msharefs.
> 
> Dumb question: why do we need a new filesystem for this?  Is it not
> feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?

Hi Andrew,

The new filesystem is meant to provide only the control files for sharing PTE. It contains a file that provides 
alignment/size requirement. Other files are created as named objects to represent shared regions and these files provide 
information about the size and virtual address for each shared regions when the file is read. Actual shared data is not 
hosted on msharefs. Actual data is mmap'ed using anonymous pages, ext4/xfs/btfrfs/etc files.

Thanks,
Khalid
