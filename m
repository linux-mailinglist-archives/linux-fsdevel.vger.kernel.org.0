Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94550703B44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbjEOSBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbjEOSBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:01:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5D16E9C;
        Mon, 15 May 2023 10:58:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnrrb027049;
        Mon, 15 May 2023 17:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WyLowENDRrzQIzsJPYYXg0eQnc6OWhsHXBrrtpYq1ec=;
 b=xaCs4ig8YIiTV1BSNyHox/TdOr3n8geXzHPIlyEsmw2lNJwMwFCQTL3TWVoV+pd3Udas
 BpvaB+7mWqe2zRXAJ3iCmMsXRejXGcX/BoWAL8B5uDxQfmUSNHWZPvK4ighxJY2AbfAv
 QynSKoSw3sRirgjqxNlTfp2fWoLGmkbw6yuAU/Nn6NvHz7XT9GljC9fbq2S6CPi6gnZ7
 DM2cIpnVzPFZW5FjcHracEIzDTEAMOqoezUd+7/Ka0gJm4aEQd7/OBrzWFOic0+1bCAb
 jnks/hxHZJgpXuE/9RuHORDc5/NZ0wHCw8mu7SdXIx01PrKnTthf0+WyYEBBdj1oh/x5 qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1520qb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:57:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGcXna036960;
        Mon, 15 May 2023 17:57:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1098bpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqXwnbQsfExnyloJbBSaRFKI8t03GxmLrXsh7p39ogyW9l21u6tBvQqf0HPubzwv1lvuipx+yO0rSCMyEAhpXchTIhf5ekzIbvelz4RKBa2FAZPUAqX0QfjmkeCfbtG3X9GRtjLeKFPraLB40eFuHtGOdVHQrxIp1soMzOmR2OsHzmNi3i5ZieKiq+2+XotUpPiND7zxfPUzDxlNsHya1p5z17mVVLfskEc8sq5Pl5yAzZIhzutNtWeQ168WTxrPlg+atsMeBdQjiMIcK/EhIP+HcYZSRuxY6wbqAGh1UxqNASP7k7Ff6Wc4KtRWL7lCGSo5rVaZLMLrZTmGl2QkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyLowENDRrzQIzsJPYYXg0eQnc6OWhsHXBrrtpYq1ec=;
 b=QoBehlsE0MqsyGEsUWVIQRcor3ovAXtzMjtJYbZ4tLDuY+oZY9nXYbLW5F1N7Maoh8BM4s/eMxY7jT8c49Fv5rVGM1uZ91rYVLa/bFRFmWpijot09YN9hlezmg6rz+HZ4fN5I0erXTDJwiz1s2IM6kGy7d8Uc/DOp42AM6OyPpblvFW0UK0ryFJu0M2XwRukAm7LJUl3Kb5aeW+lBSJk0owDlDmVGQhUt8g/QhEF0HZlW/7PtNb0mY8OfnUqVR1xQYXFsi2kBsro7CmHPyjmRXGhEhjuaRgWeoQZHKRXXyUULDSrj4VAbktzaNNS8LGoCNFDAuN4bbrdIgdocfly9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyLowENDRrzQIzsJPYYXg0eQnc6OWhsHXBrrtpYq1ec=;
 b=p3ffkBVQ/26jr67eRrzHfmTqXp1N/61ioMH82G5c6r6Zon5oIPselCkD80H+zKKH6ToZDUE14TjgxC+LWIT6jTMA9GfRW/SKkFqu5FQPFJGMziWwuFmLOGtS/gW+hoiEbiSEbqK/JsANXkrPBYp+Ex8Nb2OebcjYSBLLk2B9uVU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:57:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:57:11 +0000
Message-ID: <f782ebd1-c9d0-be49-0053-a7c657e75aa2@oracle.com>
Date:   Mon, 15 May 2023 10:57:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] NFSD: enable support for write delegation
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-3-git-send-email-dai.ngo@oracle.com>
 <9889f34351d261622909a2ca9d8f5d598d4bd27c.camel@kernel.org>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <9889f34351d261622909a2ca9d8f5d598d4bd27c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8c30c-974c-4529-1496-08db556dcefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGhXKQA2izNi1o4/VcIFhv8eak1S21hE/Mck1FYS3r7uo4Or1oFikPZWi0QsphW1uk36zzGs8OCrrsXIW6NwfVv340SLEvEjiWNByivovVFQQRcPZ7iyoSgmDSQ19zcqop98K+WOYZWQbpxqjKgIQxF0L/rJ90uakjU45C0ijpqAGDUvcVQPeDpCie9P6uH6BlIG0w3qEP/3pXVpXEmXe0svypFx0s7FDLKCGri4OGZfYF2hIjgLHnCaoFROA5J1rlROBIsY+UYFHbCnc6aQQuUQy3sAOEd1+a3uTXRxhHLCHxt2dEtj1y+iDPqF6vCGrKoQImJtz4uJHKiPNJrQ5qR0A893m3NKMR6hY8TIzsLJgv414uGDnR+3IjeeLP6egFNjLV0hGVPktxpAkEcsJ5SxWWqljWqEEe5yAzYl8kArRhF2Dz93O0Af4c5OlDjqr2rjnXNLkT7JcIc6TW9eJ0MOEfgaQuowUIgxiepb/WXNSXm/JJdeX85wYOYKrru02gTVLvy2K4vcf/53tPB262dpgCjmo9sryVZ8xcdkEGTwMmCGMuKI8BfXKWAqG4quwaubTLezbvNYm4k2NHLe0dqk0WaMoY4JOEjGwsi27za+opJWifCZpGyN/RSSZ0Ew
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(36756003)(86362001)(316002)(66946007)(66476007)(4326008)(66556008)(478600001)(6486002)(5660300002)(8676002)(8936002)(2906002)(38100700002)(41300700001)(31696002)(6512007)(2616005)(186003)(53546011)(26005)(6506007)(9686003)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdFUUZ0RklER3NJZk9vQ2p0ajRlamtqbi80MWpaU0ZnekR5SWQ3NEV6UVdk?=
 =?utf-8?B?UzdmSGFSM3Bpdm1tZHRRUy9KL0tLYThWQzMyN0VtYkRURWkyZHFONjhkUWt2?=
 =?utf-8?B?dlZ6RVJkWk9jU0YxaGFwZUJCSlFCb0xnUVdSUGcra1lhZVhoREhEVzBVUUtU?=
 =?utf-8?B?VGh6VzRkZ1dwK1dvS2N1dTU4OStHYVp6TUdleUdmYmgySmtOMnR4d1oyRGxz?=
 =?utf-8?B?YWlWZHNlclVjUGp5TFcrVXVuNHVlZnFuYUdqdzlEWUdTVGtOb3dLU3o3d2sz?=
 =?utf-8?B?U2dMU1Fkc1Z1MmxWbmFRVFlUc2NxeGp2YTN3MURTNnF2SGdweGxKL2tuNVJX?=
 =?utf-8?B?VVF0MnZNdkVUQW43T1Nac3pPdUJJU3VkUUJ3ZkY5OUh1NVIxSTdjTk5FVlI0?=
 =?utf-8?B?c21UQTNISUFiU29kYXNLdHZ5eXdidWpwS3RvQ2RWNE9JVHNnclVNb3p5WUI4?=
 =?utf-8?B?bGNFUDJTSFczaWFiYmE3MWZ2Z3E4MVNnTGdZZ0tEWG1wK0lXcEFnOFlCRXFv?=
 =?utf-8?B?QmFWTnlzMlFkc3dtc2NGb3N5b0U1U0lrS0pPMXdhV0NTODdiUU83UVJiSlFG?=
 =?utf-8?B?Um1ISTJFMVZOdGtkMmlPTXVlanlDbXp5UDVBaW1abitHclU2eVhCak9VYlpk?=
 =?utf-8?B?L2dXQU1KYXNCbEU0dHR5bDBIbmpGM2FuSG9zbVZGSEtSY2pQbGdha0lsSFVW?=
 =?utf-8?B?bk5XOFBtMDhDd3Q3eGVYNTI5YmNVaVJ0RDhqN2o0RzZyQldwVFZTM3N0WWtw?=
 =?utf-8?B?U0FubW5DYXhIYUlIWEU0ZmY0d3ZLU01DNzJYVlRjbExSWXErTEd5R0J3d2Rp?=
 =?utf-8?B?WVpZZEhNYUc2dUdVMVZIcUxyU2hIcWpjL2M0bEw4UWhqdWFaUVE2bmZGeUsx?=
 =?utf-8?B?c0puUStja29YbHVQSFJhTkdjNHJmSXR4VkxjR2Nmb29zNnNaNVRSbzJIZW8x?=
 =?utf-8?B?RTZtR09HSVNiNFlGN2gzc2F0eXp5dHV0bnVEOGQrSzZ0dXBTclRMQUJMR2F1?=
 =?utf-8?B?b0FNVW5wUiszQzI4V0RBdUQ5VTd2TS9lWmVadTFwUFIxekNhczg2OFBlOG90?=
 =?utf-8?B?d21Zd2czeGtyajNUM0toY1pVWnlVa3kyZm9wU2JMcnJydDdiT3ZPQzJiRVhB?=
 =?utf-8?B?S1c1VEhJZnlzZ3JWSFc2Nnc2aVZrZnpNZEFHR0FLTXFXc2ZZRFRXaVU0OWN3?=
 =?utf-8?B?NGwwRkFEeU4yWkJJSkNNTTUyUU9EdWxiSGxKc3dnaGhhV0RlcVpad2FaQnJD?=
 =?utf-8?B?VVltVWRsekZSb3hDNWFQSkxUa3FvclRsVzkvcFEybDhza1FIZ2gvaXdYV3Vk?=
 =?utf-8?B?US94K1huU283dWsvY2tyYXN1cGJFU25yS1paajliTlk4TFVyMEFsMW5CVGxl?=
 =?utf-8?B?TEtXaWx0ZmRtVlpibnVtVTk3NVI2dkFnM28vU2liYlBmZkZzMkM3QzFhUFQ2?=
 =?utf-8?B?UFZrZ3ZkZXVleFB6RmhaUTcxSXJzazZnMWYzdjZxbEZRdFpjbEY3MkdWY1dp?=
 =?utf-8?B?WlZzWlZpL2xjNXF1YkpkZ2V2bnhDY240OGlhcXVtcnVjYXUyT09QekxRSEd1?=
 =?utf-8?B?RHpUeDZzTGpRNFk5N3U4M3N6NXExcjVwVGZlUjlFVEZ3RkkwVmIyRWxja0M1?=
 =?utf-8?B?U05IVytZbHpsTkJtdVRUaDVXWXoxcGwwMnl2c1RWK0EvOC9Kb2JMU2s4K25Z?=
 =?utf-8?B?TlRIaCt5R1Q5S1F5VVlTSFRGSm5xWkMweXpaODZQRVBmN1Z2OWIyV3BOVjBU?=
 =?utf-8?B?clpBeVJ1R1hpa0tRcmFNQzNNNEJJdU5PWlUxWDVHSXEwTjZtK3J5RGE0eThp?=
 =?utf-8?B?dDloMkFYdEJ4RG14a01NZnV2T3hlTFJ0SDd3R3Bxd2lBOGlUNWwrQ3BTelk0?=
 =?utf-8?B?NVRQbks1RWp4RzRWSEw4dGtHRkk4ZTkwZTZYT2E0eFlUKzlyQ2s4SUNPbmhj?=
 =?utf-8?B?QlpmQ1BpcWEyNmRtOTlCckp0WnZyaXdvY0l5UWV4S3p4MjNQNjVDcXJKM2d1?=
 =?utf-8?B?anNyWFo1Ym9TaW5KdHcrcTNCMXlYemtVNVJHUG9QK3BNY0tCRC85c0plZi83?=
 =?utf-8?B?NDZHQUMxZGFNQXY1d2dQUStHWDQveUhwa2JXUGY5eEk0QSt6Uk9VVnVkRzZu?=
 =?utf-8?Q?c8vBuGifhEDnj3D7gCX5lmrXs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ay2104bO2Nt24oe/8NrSF3Mt/+8JET4UgalKKzRZ5/q4YAqnSmfooQmA8lHKXdhLdioaLZc+dnXCLYTYu/gdOsWC4lrZSjqFRMpJyBAu9QwzRmTJXijHEMLM+GeWfnv/GLltBSBMAt0icW/B43UcZIUkTNDGDe/EBgYrOlYSlz0npgtVQM01gioP8CoPRcFkSSfF/rjXo8AL8HSY31cRjnen7TI1nHmrPll68C03dcsmmzbpM843RVx7Feqql49qQk04qFCN4Wzf1P2x7J5cMTYV+KGguVmIc1vbKwOJKYR45ngXYCOJ2hfPqR0RbUvHP7CG2v8E5sRQk9+MYyyYICMsUEE0t6Hatc8quX9CMuRR7l2OcfNMgXpu4Nf+FivbBN4VBcL/p1k/IB33EtuyGmTH+8KBFsqe+dH3i16XiIltP83iK9Vr3LscE1zZUaZ9idohH78E16Xhy1p/Q7tPxnikCPLNwIRgF9LRY7MwV6HITWfbUcYndLUsjdazuc19URC7FixkCf1QrTA13OvfWEEGYQ4TyXcHTgyicjmpp77rTSONbknO7rkBNAWq1eqDCEuIvfV2R/S5QhLkKWTr8Agd4edMkJKRKztRsslgtpXOo6dCmp+myocsh2YvDGZo+3e5zgO30PU9qmOk9yOEdNpaeuO+1VeF/OPjoYptzTp/iQef/6N2yt9opwlgelSOfbWfU93Hox7EEF8SVgCaeS+t7W7mjh3MV5v3HAQdPUSKhwI/9wDnoTmFqJ6qBZCrq2W7xzbXcI0DhqxpV1NNaTlGAnlvmMR9OD9j1rcH2q4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8c30c-974c-4529-1496-08db556dcefc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:57:11.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXIgAdCl+gh+9aZdy4sMo+9JQHsFmztcB38NY11pz3cvNqBrtnjm/SisZytgAELezLy9WPlwXUDmq72l0RomeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150151
X-Proofpoint-GUID: H3BYgJKyaiVvR8B-1L9qC1XQKhdh__DZ
X-Proofpoint-ORIG-GUID: H3BYgJKyaiVvR8B-1L9qC1XQKhdh__DZ
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you Jeff for your review.

On 5/15/23 4:25 AM, Jeff Layton wrote:
> On Sun, 2023-05-14 at 17:20 -0700, Dai Ngo wrote:
>> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>> if there is no conflict with other OPENs.
>>
>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
>> are handled the same as read delegation using notify_change,
>> try_break_deleg.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 6e61fa3acaf1..09a9e16407f9 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>>   
>>   static struct nfs4_delegation *
>>   alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>> -		 struct nfs4_clnt_odstate *odstate)
>> +		struct nfs4_clnt_odstate *odstate, u32 dl_type)
>>   {
>>   	struct nfs4_delegation *dp;
>>   	long n;
>> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>   	INIT_LIST_HEAD(&dp->dl_recall_lru);
>>   	dp->dl_clnt_odstate = odstate;
>>   	get_clnt_odstate(odstate);
>> -	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
>> +	dp->dl_type = dl_type;
>>   	dp->dl_retries = 1;
>>   	dp->dl_recalled = false;
>>   	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	struct nfs4_delegation *dp;
>>   	struct nfsd_file *nf;
>>   	struct file_lock *fl;
>> +	u32 deleg;
> nit: I'd probably call this "dl_type" for consistency

fix in v3.

>
>>   
>>   	/*
>>   	 * The fi_had_conflict and nfs_get_existing_delegation checks
>> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	if (fp->fi_had_conflict)
>>   		return ERR_PTR(-EAGAIN);
>>   
>> -	nf = find_readable_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>> +		deleg = NFS4_OPEN_DELEGATE_WRITE;
>> +	} else {
>> +		nf = find_readable_file(fp);
>> +		deleg = NFS4_OPEN_DELEGATE_READ;
>> +	}
>>   	if (!nf) {
>>   		/*
>>   		 * We probably could attempt another open and get a read
>> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		return ERR_PTR(status);
>>   
>>   	status = -ENOMEM;
>> -	dp = alloc_init_deleg(clp, fp, odstate);
>> +	dp = alloc_init_deleg(clp, fp, odstate, deleg);
>>   	if (!dp)
>>   		goto out_delegees;
>>   
>> -	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
>> +	fl = nfs4_alloc_init_lease(dp, deleg);
>>   	if (!fl)
>>   		goto out_clnt_odstate;
>>   
>> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	struct svc_fh *parent = NULL;
>>   	int cb_up;
>>   	int status = 0;
>> +	u32 wdeleg = false;
> Shouldn't that be a bool? I don't think you actually need this variable
> anyway, you can just open-code the ternary condition in the assignment.

fix in v3.

-Dai

>
>>   
>>   	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>   	open->op_recall = 0;
>> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		case NFS4_OPEN_CLAIM_PREVIOUS:
>>   			if (!cb_up)
>>   				open->op_recall = 1;
>> -			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
>> -				goto out_no_deleg;
>>   			break;
>>   		case NFS4_OPEN_CLAIM_NULL:
>>   			parent = currentfh;
>> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>   
>>   	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>> -	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>> +	wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>> +	open->op_delegate_type = wdeleg ?
>> +			NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>>   	nfs4_put_stid(&dp->dl_stid);
>>   	return;
>>   out_no_deleg:
