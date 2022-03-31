Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCACA4EDED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiCaQbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiCaQbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:31:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDD17179A;
        Thu, 31 Mar 2022 09:29:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VF3Mlo030420;
        Thu, 31 Mar 2022 16:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zk9iyre29f59gRKDs0S7DWe5BHeGhd3XWuMGU2df15k=;
 b=FkKr7b0okhQh2NoBTtANgbObM4HVBBlHPGyu1d/4WSZwCmhaeqcoUafx1bRwMIQFh/Tx
 SCjxO1Xxz3ZfRLFr47UBuFXcNgR6uExObjvJdOqn+0OevnlBpD7m3Ivgf2/poKGHYpgq
 lzO9VzJ0dgLUrLcUAMl3qqK5f9aGi0qTG3+Q8Ber6KKVxQefk9YYt3BOxYvYfWSwwEaD
 xehofFj8QvJiQEFzY8TEBuJ9EBGiexRdOq7vS9c4FRCCvv/Tbjx5Pw+GRInSBiUkwCOk
 2tBSfmYLI7XV2L/X32HHG4sAJNxc0c77gxU/YZehG+jLRd2hGPgmmjIGJMX5YbPZrWvs ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0mvw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:29:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VGHKjX010030;
        Thu, 31 Mar 2022 16:29:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s951vd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExC/bEnzeCSCCKDNdjTG2my+K+A1rd2wZsg6qdNYykEywmCGU3cVJkm6MegCrO+RI04SD/FQ3m+7shRCW1NCq+e3INrO80ujbbVtHegyXBAqEP8NiB3JUQDN3CHm6vRwMOWrAqI9Jp51Xmtr6Dv2T+KVY+fxmGKhoSmo+8o/I/B6NiDmDNAHzC43p+TwEUqvJ0mwAKSg/Ac3SkFv4mZqq2GH4fCj4DT0khCmsUS4/sNy0pXvuNBAnYEwc5ce7AFOSDTPkwiUXF753Jczjoz0q5Z+Fi42KXFOTM/KIifNBOLTUy5PfXFxHStpJ1uoktOYadM2rpj1+1XSnHQBStRlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk9iyre29f59gRKDs0S7DWe5BHeGhd3XWuMGU2df15k=;
 b=gPOD40YmzBrK3YZY/SYdYE5NNKU/fvOgX8XcSaZhXHxiwOT1mu1ObHYOZYig4Pd9ees/mvGJuM1fNrMcZEpMsfK+6+Q3gat6oMTG1DamDMG51cH2Q2ZQ33EbjzsHPrw1txu6NzW/6tGM4hp9s+Lh2SNb3jcTmcGqaNAgjzhblp7jNdQ8R7npktYgaY+Ku2lgafTu3SAVpifXhliWbvSzSqRJse8gerSACeUcyrNc60pLHB06a84MAdErQwexIexQT6X7ZQTKUt96QIR/s5HeLD9p6t/b4FEF5SQgYDRoyuL12UxwyA52pKeBvTX5lrLwVN4TGZsGeBgqKB9IUo3/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk9iyre29f59gRKDs0S7DWe5BHeGhd3XWuMGU2df15k=;
 b=R2oqHZFKiCa7DZENN26nP5ZLweYD6T4N6oqYkQiniyfIzH8nZdVVneN28o6FOvQZ8YyvN2X8t0IiJSoqZeWEdm9wovxx2AQWU70mDWtidILW4LvFrBex3RoJKJp74kMtj8qMB8bvQAB7uUYtN9CwLtgaBOnDfXd94LPSylykLyU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3381.namprd10.prod.outlook.com (2603:10b6:a03:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 16:29:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74%6]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 16:29:20 +0000
Message-ID: <e5138367-8a65-6f14-643f-7f8966076b46@oracle.com>
Date:   Thu, 31 Mar 2022 09:29:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v19 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-2-git-send-email-dai.ngo@oracle.com>
 <176D175B-7218-4B7F-85D5-1BBB4A47FC98@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <176D175B-7218-4B7F-85D5-1BBB4A47FC98@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6faf1aa-1c96-45ba-5bb2-08da13339b9b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3381:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33819F4A941577ACA9FDE85487E19@BYAPR10MB3381.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHSH9dnIhGkzkPEPEF2uILewsJegs972Dg1WLMLtv69ShJB0NNjnLKfDEtq44SE9IWRwULlF8GoIZcbjnEa4qb07lfOl4kjbME6m48s+wJa+JjKasl14UBk/Ol19MDALFj8q/fjDx3Q0vhbppOZ9flcMeocG9UYuhcc/8GFwEVDI7j/R5m4ZPfzdclII87KtmW9fG8TnuuoCFUAI8GkeIU1oNvPuXsX7ftf3J2fiSQRDcF4vwoMBxZCQz7N2pUHhQ+wC3EfZiSDlKrJu0NfdRuejItyo88nU+eRktJWHZ82mObmWXF8WbWpIec7e91Ee6vllY3U2P8Q1fSNt00+l8pyyUZEVoBcMELV/Oo/URSI0QwJa93o4JLgMOjc1xz3+WIt+9YKB67opImzk92NCqRZ3jeJjp5hp6omVgIx/ODkb2mkJKnqDD/W/E3QY7hAbwL3BsiWjXNO6XCqeMurFT9J7BQnSCMMvVq69Vm866B/r5VYR6P+jH06sTGZep0QyJHIPvn1yux5kNf5TKZEWumBrbWBvmOz+M4+rIIMqqvrms6XIT09jkaNpcch5pu62/TXYIuOF0LBCTHdFLIOZ9pBppr5G8vjWy5xkcwhXq+eqhU+XWTasWiLdSo14Vr0+QfW5HnARqqVHlNUmrQA3zg69918zz6eJ1KPvvv2XZZ4AcCJquPkoMD3L9nR6q3GeX13G1+X31+Vdk3u6vSrsFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6862004)(4326008)(8676002)(2616005)(2906002)(26005)(6486002)(186003)(36756003)(31686004)(508600001)(38100700002)(86362001)(83380400001)(37006003)(66946007)(66556008)(66476007)(9686003)(6512007)(316002)(54906003)(5660300002)(53546011)(6506007)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQ4dk5sYzBxSGRRbFFiL3ppdWVQNG5jYk1DTTJNZXVtZWE5akRpQ3JNdGdC?=
 =?utf-8?B?dmpYTHdJQm9zbUdzdjhzbEVsbUsyRGgwTTZZaDdkc1pCTVFKK2VQK0phNkdx?=
 =?utf-8?B?M3IrYW9EYzF3K1BvOTJyT3B2M0FQSnovbXkrbkYzOHd4b3BERWdOZVNDc0Va?=
 =?utf-8?B?eWdPY1pmSTFnT0g2eGFvbHAwUjhDT2lLTlc2aVdubnhFVlpBZXRtN2ZCczYz?=
 =?utf-8?B?NnZDVWhueU5XTHVHRkRvdHN6aktoZFJvV2FkWThPZFdOUG50cHZXaTYzb2RW?=
 =?utf-8?B?SVMzbTJUa2lxb1d5akt5cUhWMHpERHJoM0swRDJTOWo1SnMwOHNvWEp0TGYx?=
 =?utf-8?B?NkZjUzhBWEVWa1Z4aEYvUm9WY3pucks2WnB0WUVJVHVPaWVjRDFVNGtVUzA0?=
 =?utf-8?B?UnN6eE10M0JNNm1KR0xjZ1E4OG4yMWlXUmtvNFlMMzhaVUlJMWs0MXVMbzA0?=
 =?utf-8?B?OGhZU2lBdVpYS2N2NHJHM0NoeHNrRzQ4VWNXRnAvcXVrOGR0M2ppeGJWdWwy?=
 =?utf-8?B?NHRtN2hWM2NsajEzdS9pajRsWGVNZUFHUXNSNTlTRWlDZ3dCK3hXWmsyQnQ2?=
 =?utf-8?B?ODZZQkljcVpZQWJSZGF2RVR5eXZpVFJWdlh5ZVJKNWpaSFpqclNLQW1OTkJ3?=
 =?utf-8?B?UjlWMGFxbU1DOHpSdE5iT3k1bGZUTDJ4U0ZwaHhHOElJQjJyZFN6d3ZsUzgz?=
 =?utf-8?B?OWZBMXVCVXRVazltVWRWNTJsVHlvVXQ3YTVEZXFGT3FqTjFGYkhhTGxydWpr?=
 =?utf-8?B?SjE5bVVRMVRBWWtQOGFZSUNNOUIxZnJGemxzdFBuSENGdmRUbno5VHp6YXpk?=
 =?utf-8?B?SWE2SUNYb2pQNFVlY0cySHFDa1BvUmpjVFpGd2VlRnpmUFBHTXEwVXV2bFBu?=
 =?utf-8?B?L1JHWG1JY2l0Rzc1dy9iRi82ckFKQ3Y3TUp2L0ZoYlk3ZGVkMWZ1RTdKamJD?=
 =?utf-8?B?aEp2S2F6b0VTRzF4eWcyTE5XR0o2YUFpditjQXBnRnpyRFpBWThPVVNqdE5D?=
 =?utf-8?B?Sm0rK0g5TXJySE1Fc3ZTMlJXencxVUpwYWxUbnVNeDZCL1Y4bHZINWFqWits?=
 =?utf-8?B?NXovbkJteHZNVWtCNnhDVkJhUWxTOVFqZmIwK3VlaVpHNkt1dHlJUDR6dU1O?=
 =?utf-8?B?NjhuYzRjc0Uvck5zMlZkWXJJQXV1cU5KZEVJZTNNMDd6NGM1UDlZYThWSVY5?=
 =?utf-8?B?ZlVRbU1pdjR3MVAwbGpDMW03aFY4Ymd4Y0taalBVMVNZUFN5TEUrYktwblVM?=
 =?utf-8?B?N1RiSmVoUThTOVl2Rms4cUNEUUw4V0ZVd3FRSktvTDBpbERaaithNTdHclc2?=
 =?utf-8?B?Ni80S0NYdXdZNDMybzMyQkJ3YWJxamtXWkMxVEp3Q1ZwcVBvdmlDbEh1blZu?=
 =?utf-8?B?VUFiR0ZhR0ZLd3lTN3hUVEV5Y0xpYTZpdWtnbGdXWVE1SmdXaitLTGRWcVJi?=
 =?utf-8?B?ZGxUL3pVSVdFUlJlOXg3c3ViNTNvSkx6TENuckF3bXV4aStwNWtNZnlFMUYw?=
 =?utf-8?B?SEN4clI2ZEd0VXAxNEdBVXh2b0pzQlpxVjNESjNhUThCWFVpdkt1c2tWcFd4?=
 =?utf-8?B?RjJpZ3JSUkxpWkt4Kzhud01pUlZlZU9LVWdjOE4zRnJTb1E0NkErOHQxbm55?=
 =?utf-8?B?U0poMXdVMXlwY3JVa3BibGJXOVhBM3JUTmJ6MHpUN1p6U1pqeDhLYllQZUFh?=
 =?utf-8?B?TDdTS29kVmFObE9pcU5ib0RhbGxja0FTL2VTZEV5TXZ1aUVpTnVsV3MvSlA3?=
 =?utf-8?B?Q2RqdVMyci9wMUtwVzVJWTFvVHQ2VGdyRjlJdTlPOXpjMUg2MEdkR0E4dlZ3?=
 =?utf-8?B?Rk5YQkxlbW5iTFM1OXlpc0JXZHJzQTRNWVJUS3RIZFN4Z3VmWTRCTU81Tlpq?=
 =?utf-8?B?VmhBb2ljTDZiVlhpaW5aR0dTTjRYMzhVeFJaMys4ZnJQZjA3SlBSYUI5MlRB?=
 =?utf-8?B?RFI2Y0luMk1Wd0VQQmZjTjNNTGpaNUJ1WGhJdW03NVl0U0VaY0d1SHhkdVVz?=
 =?utf-8?B?RTNUSE9PWXNPVjBCcGpGUHUxTXRoSDFHUC96NDRNbW9tUGlCeXdZNWdEejla?=
 =?utf-8?B?UHpvRWlINmZma2w5L3ZvS1UrZHN5M29PV3FsNFhRc0Z1VTBuMHllbWx5WmRK?=
 =?utf-8?B?UWpWa2hPQ0h5b203NUx2TzlMaEkvajhxZ2VLaWhjZjRSRzVPZWx5N25tR2pM?=
 =?utf-8?B?L0Yybkx6QytMMksxTzhxNXBhcVJhWWxaQ1NuSXphejZEU2I5b0t2WW1TNnd3?=
 =?utf-8?B?Y21WNVpnTnJMTW5lMW9JK0NSb2F0R1h1dUFHZCtoc3p5T01JbXZ0ZmptVVRM?=
 =?utf-8?B?VldiZFhJMEtBVnJHaENpT0FiU1ZOSUNFeUxmY0RoRkRFVmVOR1VQUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6faf1aa-1c96-45ba-5bb2-08da13339b9b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:29:20.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URJSHJUi2IzNfbmtM2sAygiKRLHtZIW+rhbOxib0QZu9CFeoWH34bl7KveVFV3MdZHN8L53CgSAtKXPQjkPu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310090
X-Proofpoint-ORIG-GUID: C0_DFLiTX-w7QiREq5Eh9_zP-s4dLH9X
X-Proofpoint-GUID: C0_DFLiTX-w7QiREq5Eh9_zP-s4dLH9X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/31/22 9:17 AM, Chuck Lever III wrote:
>
>> On Mar 31, 2022, at 12:01 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add helper locks_owner_has_blockers to check if there is any blockers
>> for a given lockowner.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Since 01/11 is no longer changing and I want to keep the
> Reviewed-by, I've already applied this one to for-next.
>
> You don't need to send it again. If there is a v20,
> please be sure it is rebased on my current for-next
> topic branch.

Got it.

Thanks,
-Dai

>
>
>> ---
>> fs/locks.c         | 28 ++++++++++++++++++++++++++++
>> include/linux/fs.h |  7 +++++++
>> 2 files changed, 35 insertions(+)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 050acf8b5110..53864eb99dc5 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
>> }
>> EXPORT_SYMBOL_GPL(locks_release_private);
>>
>> +/**
>> + * locks_owner_has_blockers - Check for blocking lock requests
>> + * @flctx: file lock context
>> + * @owner: lock owner
>> + *
>> + * Return values:
>> + *   %true: @owner has at least one blocker
>> + *   %false: @owner has no blockers
>> + */
>> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +		fl_owner_t owner)
>> +{
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&flctx->flc_lock);
>> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
>> +		if (fl->fl_owner != owner)
>> +			continue;
>> +		if (!list_empty(&fl->fl_blocked_requests)) {
>> +			spin_unlock(&flctx->flc_lock);
>> +			return true;
>> +		}
>> +	}
>> +	spin_unlock(&flctx->flc_lock);
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
>> +
>> /* Free a lock which is not in use. */
>> void locks_free_lock(struct file_lock *fl)
>> {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 831b20430d6e..2057a9df790f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
>> struct files_struct;
>> extern void show_fd_locks(struct seq_file *f,
>> 			 struct file *filp, struct files_struct *files);
>> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +			fl_owner_t owner);
>> #else /* !CONFIG_FILE_LOCKING */
>> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>> 			      struct flock __user *user)
>> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
>> struct files_struct;
>> static inline void show_fd_locks(struct seq_file *f,
>> 			struct file *filp, struct files_struct *files) {}
>> +static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +			fl_owner_t owner)
>> +{
>> +	return false;
>> +}
>> #endif /* !CONFIG_FILE_LOCKING */
>>
>> static inline struct inode *file_inode(const struct file *f)
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
