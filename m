Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2270868C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjERRP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjERRP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:15:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC79F;
        Thu, 18 May 2023 10:15:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IF0CJO018344;
        Thu, 18 May 2023 17:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x6urcYdTCqRURIG5rkL61QgU1UXrNM8gI4omtykib5A=;
 b=1vGemm2fX3/wivphgaeuA9jzc51mwct7WpoOs/AZuUJ9KITTwGiotIEozWI6vIep01U1
 FZcao4Sp/6sPRKKwxlSA55i+4zw1aJmqU4UTxrMX3UP6nalhKWhfmASx/Tn/n3mkWQH3
 7Yv34r4R3Y+QkeBz0M1GoaO9douan5rtXCDw5OHRcOW4KDcMkoJcdcA8NHu+mds1cDuF
 MIUq+szbLBKTMmuGBk+oZjOZ0jUGikUzMj5Q2pZIdF4dIeTZhQmgoRgrTM1rBm6NJ0Vi
 sX9zu72zmzSPgIfgbrWknHiRVgNArptzQYT5wpj/NNCgOC98K9lvrUD6c+dr88fvwTOL UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j386w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:15:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFcfeL039969;
        Thu, 18 May 2023 17:15:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106t2qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CarZ9jBKwBFHEuJdCt9QsDidFy93nVUFraQhTSsxi0yGO17748wz5kS8DR6nBMZgqr1IZU6QjM5C+caEWhSvZ0k54Rmw6BzMbTw2+UNdYaj43VJZbDCEj0ej0Kj5wB1e5QF2SIa9e38f4wOKlQg8xDe4dNI+08JTCKakBEz3e5eG34Qh0gGOjgyO9EUWeFxzEAqgAT+kv6H/2gYRJem8hcE++UhM7rCLjejwRQ7Yo3ALRUf1PdC8PCs8wv3c1BzP8MxXEkEab1CT9uJ1VwDEC3vUki9MYI6xX/k+6Cz8cgbUSEdMQRAqJB1X2sxVzYGqYsGgBeeUFmjhcNXhFPaNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6urcYdTCqRURIG5rkL61QgU1UXrNM8gI4omtykib5A=;
 b=TsigdkcuoHOVYkG/k6l+ynMWOc415qZ/uimdGKuxBX6LRB+uF1oIhIdnxBXN+QbFW5yS+zcKee3ffMd4mqqqhujm+/XPbkQzPv1nRjCJnIS+8KE4H8r2GLCEY7eq859crumhqXPG6cToJG5HXIHv4WqhN8iDl0/24xIx20OiLIf34civ28ceTxP/cKYgTmwIrnc9dFTnitEu1cCzENpzvIIAtiSVQYCs25pm1Dn2+ApiwQgy94AXQeVfoRqGkgh1MWE2MDqh4PBMCHd+vXnPWLLafsCr4mVpwVm1pLHhRHcQVLsO0a1IHWI+KSkHKiJEgRz5gkyHNjjvyRBO/KhaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6urcYdTCqRURIG5rkL61QgU1UXrNM8gI4omtykib5A=;
 b=Q1beAhyPn1zR/zsRd/GdMH7EMijjooe1KG5CkssU7gG39GMWLADAmhku7cIgwcZXshugqogL5gq9Wbdxx0aPW2x+calFdXKUNVLIhlMCri7eCAEfeihHwWA/aVQSWConYXTdiJeYcDKxtqX44dQC9dTaCWfN3l7UgVxD1Bhf0VE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM4PR10MB6789.namprd10.prod.outlook.com (2603:10b6:8:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Thu, 18 May
 2023 17:15:21 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 17:15:21 +0000
Message-ID: <2eaf06cb-ce85-c9a6-960b-c7c672a46fea@oracle.com>
Date:   Thu, 18 May 2023 10:15:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/2] NFSD: add support for NFSv4 write delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <d09ff65f6a937ddfaa5ecdc3a97c621df9809292.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <d09ff65f6a937ddfaa5ecdc3a97c621df9809292.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:806:6f::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM4PR10MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d968a81-0b0a-4510-3668-08db57c37606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9bMfWVhilPZYNR6KtEYLYAgWut3It0izQrzSEcisqABafs1nfh4iCqeNh0CwvUNro4A5l10eQ22t1UbpRuvHhmM671pwNxW+CvIR0vxzg8ZWbgfsh0Paj4hIjw9Nbx1bijxkkvvmUBfHTsNDliNNrzjDn65qeLHWNDrsqtcA8euO+Is3nxjGfcNumr9ie/6H9VduoBPqyBchRIyO3+AX5ASGfusB/s1MkHA8YGxNhBtVyOpBed/zmcFYHOmMyglNGVTMJYUkJzWUm/TPQNBXOjrWS1sRhHjPuUjjo3Cu+uMzMicMI+H62Cae5bQQe6+/I7KxXJMS/+ClKrF+sJ9B1uBpNXAZ/9RGmZ0LUjHUZPDd3i0A6j3VFV8CYHZrHBue4oLKWmueAqeqJAnHbgNPxXSdbuTNR1tkOjtUKi2pedplGo0Of5kTrOWiQK92slcf9q/+MutqRX+MWNoGsqk4kZ/JmBROAwsF7GLk3G6zGNeZtiPGKu3BOU9ysu8AjjbgG3TOC7t01I9lFbKSOekPuanvDcNGFL6jPbgO28YVhEo/YC4ExxYnkgIv9uiLTl59JsRJc3FADUiAoM5chSShWwVNruWtIyQ6I/anj1pPPEZU2lvzQxkvm8M4go7tM2Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(31686004)(9686003)(6486002)(53546011)(6512007)(6666004)(6506007)(478600001)(31696002)(86362001)(2616005)(36756003)(83380400001)(316002)(186003)(4326008)(26005)(2906002)(38100700002)(66556008)(66946007)(8676002)(5660300002)(41300700001)(66476007)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3o1N3VjcFJjNlhtZDBOdEN1amRQbjdpYlhlSXAyZHg2djY3cmFCMUxoczYv?=
 =?utf-8?B?ejZ4eXV6cGZwKzNSQjh1S3YwYnZEeWJqeGVCZDVuSWRoNVhPcjRWSVBoOUxo?=
 =?utf-8?B?UXdaRTArbkV0elZ5S3ljVlpYYXlZem9NdzdjQjNram5VSW9qdFhKZ1BJK1FQ?=
 =?utf-8?B?UzRiZzJBbzNwVjZnR2ozM2NtMDJmcWZvam1oSFNaSG1UYk9TSlZnYTFZMy9X?=
 =?utf-8?B?enpsSXY0Z1lsakJHQ05HKzRpQ2lYcit6TlRyZklaa240ZXN3Y1NMYitMV2Z4?=
 =?utf-8?B?WllzMVV6cE1LdTFnZUpsdzl6SUZvanV2OHpjdDNCdUM0QWxIbE4veU5rMlhI?=
 =?utf-8?B?VG5jMUhCM0x0WTRnU3d0VFdmRk5QOXZ2cnd2cjFvNmJpRDNwRU1BbTN3SUZy?=
 =?utf-8?B?K2xyQW9zUWNtMTZaMk5yQnc3ZW9hUkJRSDVselo0aytrRUdiMU84QnVDRCtw?=
 =?utf-8?B?RDF4UEN1S1c0YVNtckhWMGtpRiszbjI3Ykd2bXMxeithNlZpMzF5T0FMSTZs?=
 =?utf-8?B?emV6bkorWHY3a0VtSk1BRDJ5QUszcjJSaUh6NWJUOVhkUVUzUWVkMFlqcnhq?=
 =?utf-8?B?eitwZnRjSHo5TTdPakZqaHNpbkNaUzViSEE5Y2NIYlc2UFZNTlgvMmZqVmRr?=
 =?utf-8?B?Z25nYVUxQW42cTZaR1ZPeUZZZGVDOGhJVjVDcjU2Q2lHQU5JUUptdjdGQ0t0?=
 =?utf-8?B?R2hlQU5KWndjdkpuOURhd0Y3OGJGaVhjK2tFVDlRR2UxcXF0MGZJWkJPN3lD?=
 =?utf-8?B?aytOYnRhU0xrNlA0VVp0djY2UXVvR3l5TWxHU3ZlMVdjYTNrandSK2dDUGg3?=
 =?utf-8?B?WjJKWnV3Wm9YMkViMnREQU55bmRBVHNQUTVxc0Y4RE9lR2VrUDNqODgwQ0Fv?=
 =?utf-8?B?QUJIY1M1RmJsQ2MrUUl1R0I2NDFmdyttRWhPTGptZHMwTGN6Ry9pTlljaC90?=
 =?utf-8?B?bis3WE9JaWVoTWtlbkVheUN2YVhXTTVPU3ZsWDdFTlJULzZSNzBWZThFQVlk?=
 =?utf-8?B?d2hxUnByK2Y5aWNzMmNMSnN3NjQzOEdwOWJ5YU5xbVpHaEM5ZTdYREtrQjVn?=
 =?utf-8?B?VUZhRnlUWHRCWXhwcXhFQmp0ZE1xVlNWSFdOY0MwbVgrMkg0MUZ5Z1B1SmtT?=
 =?utf-8?B?SktvVUQwNEZhSXFhR1NCVW13WllCNk8wdTdudnZyT1Y5Ky9ZV2xKb1RkZk8w?=
 =?utf-8?B?bUkxaDFzM3IrQ2UyRVpZMkhPY0ZDc2lydHFZTlBZWUxzTHZXYVg2eStsdFZC?=
 =?utf-8?B?NXROb0xCOFIzUlJhYnNSN21CSnRMTjZhTkl3djBUOXRhVnlsSzN6T3UrL3Zt?=
 =?utf-8?B?cEJHMEp3VXhYcEY4TTdsaGVINzNMMXlNSC9VYWdXbkhpSXF0OG53MDVSWUFS?=
 =?utf-8?B?eU5heStlU0VIQ0MzMWg1WHdPaGIwNU9pUlRaVjB1eGdReGxaeHNNTkw2VU9R?=
 =?utf-8?B?WDZqcXlxWC9ZVFBDRm5vZFlpbzFLMU80V3VCa0dmWU9DU042MVlXYnpVYmwx?=
 =?utf-8?B?T1hVcXBKa3V6K2wxeGJpRGRyT3JETTFhYjJlRTlCL1NCSnBJRVRBQkpCZ1NI?=
 =?utf-8?B?dHdBRVNIYmIzRVhtUlhJdTVqRS9GVmM4SERUOE5rRUlHWEFCZi9OT1pwRG9L?=
 =?utf-8?B?MVo4M2xBMTVuVmRSTU1xTzVhZlV2VnJjV2FXa1FtYXR5a0pvY2N3ZEZUNWE1?=
 =?utf-8?B?Wm9FYWtTUSsreFBUTmZ1ZzdtUVMyOXA3d0doNW4rUDdtSzRsbGpXazA0cEtD?=
 =?utf-8?B?TU5IK1JCWXJHQkZ1L0lRZTlOOXplSHZrVW9LMEVMbHNvWU5TWVQ1Mk4xUUI4?=
 =?utf-8?B?NXBBQnlxdElQN1JrZllGQU5rVmpZVVBIa0RoN0YzVTlURFpURDM5NDBrUG5k?=
 =?utf-8?B?Q3VqNmVLYkJTQ21pNEg4MDhBN1pzWE42ZldlakZoeHV4clVpdmp0bVZ5cnFI?=
 =?utf-8?B?UWtnd0JINWUrM0xnczJjSXFBWUFlRUFSTExjbzNTVlRHUVMyVHNWOVlicmF6?=
 =?utf-8?B?Z0hwM0padXlnVlR5ZUM4aE94UGlEWEozOExnUm01MFN4OHRxWW5tVVE3enlV?=
 =?utf-8?B?dkxoYVFRNWVWaXhmVG9YOSsvRUFOa0Frc0h3Q01DVGNHWkh4RjIzb0NkNlA4?=
 =?utf-8?Q?kfkRzuktKyCaYBV00RhmQsoP2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9SloDmX4WoehhLEWE3XjYXCgq9aIULNmj3lRcKjpozXfHq1/1B+DPo0f4jWNnCQEKUyXWbE9vs9h1MRF5gwu8+o6Ao3TdK45zKcjGHswcIq8G237guE4Na0UHjkUW8YHx893K/jvfxSB6BbTlw/99KzKv7dEeALR12i0cfc9JALjXM6ehilInC4GM4KlGefY7m5VLt34LmU2MYPOE+FQk5e8xwyraPaI3ZyOv6jqt7VtJAbjCVUAfxiyahBKGRThDWTmkvHePseEXoMfNkaoLPQIvHW5QC8DhCtyIM3bTlU9YOgVxq+NU1juHiaTBJq5B71b+N4fBLL0AFsrZR2jhzJHYBJ6ua3yahH3fRBifGPmYZWxAbY32pfUYANDYBvTgIfZMqFxLjrIVa4w8PUM7b+bTKsGriI5B448lL1rFNLaI43kah7FespABP70NIUyJIL1GIsjzZZ1ikSFFU/ohBmLmFhBi/IV7tw6rKqBfaqLBB5Vbb5rcFcDQWOMXGNZXrbTPlOd0BCDDVFfMn6TMPaT0cvOaV7r/WVjwkjj65HvrsQ8JDB6FgsaBDZHlFE8oVN+UgWt0MMtXo7oNeMWA7W6ZMaxU4aMdoC70f1sFCKTip94LQKIAGF4W65rDbP6go0ThvuUs+Wckdelywe5h8mfJgroVuq4144MNwVR97YAdSLSnr4h9cOl3fDRqr0FD/oocY+RFbTYwGRmY4WCdlx9ai2y0GKI4ZRsFsh2sUX/uxkm2je8W/ZPY+EjPqlQMIFfHHMZDFqPg6pGZTYXDxOenwLVOS6Ime/Lvs4617Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d968a81-0b0a-4510-3668-08db57c37606
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:15:21.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSUuIgd/AAzwHLHLrgUy9CTYiSnkNyjkg0z0vfmjnG00wzlBy6hEc572blaaQG2b63pK29ncXpNd/VOTPJdWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=420
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180139
X-Proofpoint-GUID: JEk3LjHu1tAwLQbSS-0hZyYda2oLxMzt
X-Proofpoint-ORIG-GUID: JEk3LjHu1tAwLQbSS-0hZyYda2oLxMzt
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/18/23 6:51 AM, Jeff Layton wrote:
> On Wed, 2023-05-17 at 16:38 -0700, Dai Ngo wrote:
>> NFSD: add support for NFSv4 write delegation
>>
>> The NFSv4 server currently supports read delegation using VFS lease
>> which is implemented using file_lock.
>>
>> This patch series add write delegation support for NFSv4 server by:
>>
>>      . remove the check for F_WRLCK in generic_add_lease to allow
>>        file_lock to be used for write delegation.
>>
>>      . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>>        if there is no conflict with other OPENs.
>>
>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
>> are handled the same as read delegation using notify_change, try_break_deleg.
>>
>> Changes since v1:
>>
>> [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
>> - remove WARN_ON_ONCE from encode_bitmap4
>> - replace decode_bitmap4 with xdr_stream_decode_uint32_array
>> - replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
>>     with xdr_stream_decode_u64. Also remove the un-needed likely().
>> - modify signature of encode_cb_getattr4args to take pointer to
>>     nfs4_cb_fattr
>> - replace decode_attr_length with xdr_stream_decode_u32
>> - rename decode_cb_getattr to decode_cb_fattr4
>> - fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
>> - rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>>    in fs/nfsd/nfs4xdr.c
>> - correct NFS4_dec_cb_getattr_sz and update size description
>>
>> [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
>> - change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
>> - change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>>    in fs/nfsd/nfs4xdr.c
>>
>> Changes since v2:
>>
>> [PATCH 2/4] NFSD: enable support for write delegation
>> - rename 'deleg' to 'dl_type' in nfs4_set_delegation
>> - remove 'wdeleg' in nfs4_open_delegation
>>
>> - drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
>>    and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
>>    for futher clarification of the benefits of using CB_GETATTR
>>    for handling GETATTR from the 2nd client
>>
> Pretty straightforward. Not as useful (IMO) without CB_GETATTR, since
> even a stray 'ls -l' in the parent directory will cause the delegation
> to be recalled, but it's a reasonable first step.

Oh I forgot to leave to code to recall the write delegation in when
there is GETATTR. Will fix in v4.

Yes, let just run with this simple code for awhile to make sure nothing
break then we can add the CB_GETATTR later it it's needed.

-Dai

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
