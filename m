Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC953EFB4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhHRGK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 02:10:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30752 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238236AbhHRGJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:09:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I62dc4003684;
        Wed, 18 Aug 2021 06:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M4i4KZAYhC6Y57TL094lRKWSayBdmaSx45KF0u/F9o8=;
 b=FIZ1/RRhv22UW3qAfDpGoVfvmEKYSCnmCacU8IRC1HNKYiUtMhQG8JoOKc62pdO3BcC+
 k3e7xOp9kTW7cJNOQoEVOBe232F0weCSMBFEtCnghO8wh1ss4cL/IXi85tthwNHQJRMe
 vvgcLo81dt0sDyuFXfHKH1LwXa5kHDHGRTXc2FQsK2pCG5kb0wpdG3oFX5yqAgfckTQr
 wF+dF7pnNXKQ49MIA4R/eFXGsaU7rkWxLI06qeQVFURp/fGeWUr6gORSlYsDAurkrPP5
 egx7Z+iaMDaSKp0Ymt+u3ZcLcC7lke3VPQVbN/gkG6Tqceaa4SzGQMDYkRLdZVHBzR6N Pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=M4i4KZAYhC6Y57TL094lRKWSayBdmaSx45KF0u/F9o8=;
 b=EL52k3dBsjjgyEXjc1F/39jDuZNTBRb8i7vygt86lSAtex+lxkcuAO4RtO8Hp3LkI0//
 eLDEa3WnKo+ybvguB8o2FeaLNgSopYkdo3pcoTzaZoLdBKMP9I/szPEIJwPG8RY63onq
 dsyt5cn9JAkULJAttlFt7V0WXNjdcDJEi2xpa0fC6GVFQcFtKnTaC9yADq68jwrwMW3L
 5wSEGUfBnO0swWxA+Bzr82iwww7v+EYoHXNQL+JbN5rpauOOEoaanmk3czAb/cd9algk
 mSoL/sfQmc25IzdyRvqggSqirtZO4zvP36m3lIy3vDP4vcgiA6Bh3H5WrQEyD336o4MS qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgnnsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:08:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I6150H166766;
        Wed, 18 Aug 2021 06:08:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by userp3020.oracle.com with ESMTP id 3aeqkvkcdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAS0VuxltIZ3x1jUQZgvrMhW0P3uEndHgK36N/Rs40CCsZl+5jYpO7DCmiKD8fgIK38pD+TWwhwA1xPMkml9OTRCoyxoA1iJFQfeQtWyO79E5kFrsqy6nJQcXya7czCMGnu9Tekvs65PIJKJrrEETXfAsSTRD2Pa7UYuNtszLHWdVmrqt65XvthSoskOyLsy//GUaBMoEE8yywANdRmdtr83YSPHjcy2UsD8XpP4D5s7fy7P8Feu1K0cPhBhatgcGzjBt+cgBrxZM/Vg0ij4scaY/XnFg08rvKYZCTH2PGpQj8AMi0IB8bQyjZfjTsRX56Pss+MHbmHP2yDC7AlvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4i4KZAYhC6Y57TL094lRKWSayBdmaSx45KF0u/F9o8=;
 b=aBcIL39On2eU+jVH7uo4+ZC+H8RCB/GczWa51W6QdLl44ohGq52yHbCreL3lDmMEjyNNl4H6F9Yj1PJloBf+B9xq5aas7ThpuarkEnchZoRSyq01IONPV8bu7X9t1R+kBCj/zq121ZKZQKoJoLjEL9rpp+Mw0nHiuKE44bj+IngufltQ/Lb6IGTeCOqt/Z+FJ48xqVP/e9ZN0gJgHXZXUpcKTiECvzuW0IrBjcbw2IXfwFQxP+Og4+maPIfbM4XUPSCycFxr+A/c9ibw617v0vdpXZitgsHt7i6qHrOaTYwYVFrpvPv1Z8QTpZy7baxYfKciLD6jLxtHvqb3xDmbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4i4KZAYhC6Y57TL094lRKWSayBdmaSx45KF0u/F9o8=;
 b=aDla9B/bgoKWsufFsW0HHuf7KTtKE8AL6RdPWHntab5Wo8iXmuOmTZ2wEOqgeC3QjlqzI6ywCv8aK86TY1SrBCMWv4mBdGmf+CH6lFyCb5zcGUQ8BJkmLstWlj1yExil+fSLdiGdu1mdyZ8yJ2npDuFSaTGFoptwiZIClfwT24E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 06:08:44 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 06:08:44 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
From:   Jane Chu <jane.chu@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
Organization: Oracle Corporation
Message-ID: <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
Date:   Tue, 17 Aug 2021 23:08:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.159.249.154] (138.3.200.26) by SA9PR10CA0019.namprd10.prod.outlook.com (2603:10b6:806:a7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Wed, 18 Aug 2021 06:08:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f3c103-1c0a-4671-0720-08d9620ea270
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4656:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4656345C8FD784CF7E57C06BF3FF9@SJ0PR10MB4656.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8wnMyFzjnYSt0obBV+rMMwdvCiBAettySHs8CcyQNYIAh3vz27YVZJkaF8TYkKWsZBZ5yytw/biALMt69VqzClj3eDAJiaU6WHV94BH3sgRR4hPz7V1ZfLtX62/J7hXqfNF7kH7iRdiCx6rjgKVHJ5ez7cM5VPcQEm86mbrH9I9HdwUoW3E3fsZDCwVz7EsRK4RTEA/s07rg287tLyDQSzIq/kBYH4uMt18PSZYwR6c0FF+s2lbhugEvKrzOtW+hS9sq0h76aDRBHrh3y5+fWAjylaVIh9xDae4dZLHmqlktpWVLjKm0dnWPkjVKh4uxnP0w7BGnx8n7wKDHZBeW5Z/L5eT1+mjXlvdGqUPZ3XpFiUZyZkvx7dohpQ9blQ0kyjVPGHSk6h9MvWjBZpk8l+BHZVrkAosRtwmzaVshK9vXzFEhgiKNFbOAbDssN72uiU2G2BhNT912a4LAf0s14hA7ZwAI5Y38cxU1n2omCxJs/8xXPfWeHntlNG3jHkz9E15qjsHDiR8avHkwIAZgBnYy4qIqxVNvxirffIoi8FMhGCo42TBBRmKHJvi4WHkcP5FMoWJ/+gEWkSGiwIodHw6ckVp4+65eIQx84SSX1slvCfOBDVKPLcJSK4eDVhLoAmNthzhmJjYHjI4TPslpXB/1j16iRk7y2C95NrQD51YsB5f3o4a9vyMNkn1oOD5+K/SwnGy94wqsqoBczSljTWnRVlVMC8gLWDTJj2eKC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36916002)(66946007)(7416002)(8676002)(4326008)(44832011)(66476007)(26005)(66556008)(508600001)(8936002)(5660300002)(6486002)(36756003)(2616005)(16576012)(31686004)(2906002)(316002)(53546011)(38100700002)(83380400001)(956004)(31696002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhJTDlxMVFCMVczUWsxVlhwYmpRTlpvNjZSUW44VEpSaE1sSkFMNk81U3d0?=
 =?utf-8?B?N0FMSlZkaUQ2ekh6WEpsUkpNL3BFa0JhS0RuSEFtOWNxOGFSY01IaEFza2Z6?=
 =?utf-8?B?VzlwS2RLTmFydnZGNm9GNEdLYTdPSnVpOE5QLzc3SkVCaVBaZy9ScFVZdm9q?=
 =?utf-8?B?bVFzRDV2d0JtNVdjb095NnhXQVRBRExNNUlSZ0N6T2YrMk1TcXY0eGhUbVBC?=
 =?utf-8?B?YzJNSEk1eXlrT0N3bWJ5TytIR3JQVDBxOG9DVERjcXEyZEtMbk5WdHdZaVEr?=
 =?utf-8?B?WU56eERxd0xrUTZWR2dJbDAxSWthNE9PYWFaS3J3a05qQTZ2MGJ5MU5JK1RF?=
 =?utf-8?B?T0p6ekhoMXlNVkg0ei9FOW5mSzl3bDVkSVRLNVg0WWJIbUJ4cUZ1Y1hEaXhH?=
 =?utf-8?B?NmY3MEM1YXJlS2tLM1ZzS1BiWWZWUFJTc2hIRWJMd3A1ZHRaZWpPWTd4blRU?=
 =?utf-8?B?alR1Y3dlU251V3RjYUJTcVNtZndIWFFBYmVUcXJsN1YvRUU3SVV1cVNMek9F?=
 =?utf-8?B?cTQzSzhRaElybDdpRjJnRUlKM0tWcnJLUVFrVlVXUElhN25jN1lmTzB1cWxW?=
 =?utf-8?B?cXVwbG82V0kzbVNVT05Ic01VQy9MbThUeHM4aW9aODI0dEs2MXUrUHZzK1RF?=
 =?utf-8?B?dTViWGVzL0FFNDYrNlpicVpqNjlnMERGdEQ1cWx0ZlZwSFQ5ZWxFQTBiN1hD?=
 =?utf-8?B?UituOU40N21zdHgrbktLRWJQYnlyQSs1cWE5TnRUN0gybXQ1akJjTTlQeXRz?=
 =?utf-8?B?eDZkMWtDcTRoN0JqWU9PWXViMVpnMFljWkVXcDFpTE5hd3dCdEQxNTZhcEtF?=
 =?utf-8?B?TVMraElEVFNiaDl5NE5xWCtvdDRUSzhIZ3c2UXI0ME9GYitlR1lCQXJuemJD?=
 =?utf-8?B?Zng0T0NZYytCZld3ejVLTklYbndyS2dmbHIybS8zd2JGQUMyZVRmcy9SNFI5?=
 =?utf-8?B?cDgzY1BPWXBhSXk1NCs0akJjM1JEdFNMMnVpZDJNamFCWGVJQXlwR1BvZDdK?=
 =?utf-8?B?Zm1wNG1IUlBNMHA4ci8xdWVhU3Fib3ZhZ1hsamtuQjJWMFJycXR4dTkrb0Jq?=
 =?utf-8?B?UmttZGw5UDFvNjczSVlPcGFrWlVBbjVXZFpLRHEwTEQ4cG9WU3Y3WEpLemlv?=
 =?utf-8?B?ZFNYc2grYjVDWFowS1pzVlVMMkMvVExhZXJrMzF1c1FiTzdaYS9hYWg3OUx6?=
 =?utf-8?B?OVBWeTFkVG5ZOTgxRjFFWmRXY2VPb0d4K3pDVmhWUHVPUWpaNDRoTlhqSUZD?=
 =?utf-8?B?M3dOaU5TdlNwMjZPQ2NJNWthSUJyUG1yV1EwamRNQklYcnJSc2dPcS9TcUxo?=
 =?utf-8?B?eVliWjdjUEphZVB5eUQwQWovRTVWZFJNV1RCWmVUMmlDL0RpTXkrNE5QQUtH?=
 =?utf-8?B?TUZpNlNyVyt6TTljSER4b08vaHFRRE9CalR1WEQ3anlLWUVIdkxtSlBIeUx5?=
 =?utf-8?B?ZW8vZ1BZNEVNeEV1OFUxQjhyU3RYSG5VZGo0aFJscEJ2YVVBeGdTKzJzN21M?=
 =?utf-8?B?WVUrMjJ0Myt3UUlxRWtKVE1kU2NKa1M4YUJQT0FGOGMvTzBlbkRvMnVtR3lN?=
 =?utf-8?B?QU4vNFZncnQxSTQ0Nk96UVRESzlZV05HS2dYZFZRREtJa2tMd003MmdybGhE?=
 =?utf-8?B?SWVIVVJjSGRxWjRjTy81TFc3dFQzWDAvWWp4Z1NKcnRDaEdwcnREdEpmcFZI?=
 =?utf-8?B?cFRnOElmYldyUkdPY3JzNWVySS9xRVdiekwxUmdSQ3dGQ2NBUE5za1ppTkJk?=
 =?utf-8?Q?OjHhLpQAuIGPxGqDqOt6iF45Rwn1sd3EklCYXZ4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f3c103-1c0a-4671-0720-08d9620ea270
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 06:08:44.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J4+0tNW8f+jODfD80tvOTBn4gZvwWlzyBJj8xdzqstDfuAsK9xglAZRaZrAs/HkI3jAvzicxIvdFvsQdhy1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180038
X-Proofpoint-GUID: IIrNvFR3-VYflODdUfnxvCD7PloUGzMs
X-Proofpoint-ORIG-GUID: IIrNvFR3-VYflODdUfnxvCD7PloUGzMs
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/17/2021 10:43 PM, Jane Chu wrote:
> More information -
> 
> On 8/16/2021 10:20 AM, Jane Chu wrote:
>> Hi, ShiYang,
>>
>> So I applied the v6 patch series to my 5.14-rc3 as it's what you 
>> indicated is what v6 was based at, and injected a hardware poison.
>>
>> I'm seeing the same problem that was reported a while ago after the
>> poison was consumed - in the SIGBUS payload, the si_addr is missing:
>>
>> ** SIGBUS(7): canjmp=1, whichstep=0, **
>> ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
>>
>> The si_addr ought to be 0x7f6568000000 - the vaddr of the first page
>> in this case.
> 
> The failure came from here :
> 
> [PATCH RESEND v6 6/9] xfs: Implement ->notify_failure() for XFS
> 
> +static int
> +xfs_dax_notify_failure(
> ...
> +    if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
> +        xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
> +        return -EOPNOTSUPP;
> +    }
> 
> I am not familiar with XFS, but I have a few questions I hope to get 
> answers -
> 
> 1) What does it take and cost to make
>     xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?
> 
> 2) For a running environment that fails the above check, is it
>     okay to leave the poison handle in limbo and why?
> 
> 3) If the above regression is not acceptable, any potential remedy?

How about moving the check to prior to the notifier registration?
And register only if the check is passed?  This seems better
than an alternative which is to fall back to the legacy memory_failure
handling in case the filesystem returns -EOPNOTSUPP.

thanks,
-jane

> 
> thanks!
> -jane
> 
> 
>>
>> Something is not right...
>>
>> thanks,
>> -jane
>>
>>
>> On 8/5/2021 6:17 PM, Jane Chu wrote:
>>> The filesystem part of the pmem failure handling is at minimum built
>>> on PAGE_SIZE granularity - an inheritance from general memory_failure 
>>> handling.  However, with Intel's DCPMEM technology, the error blast
>>> radius is no more than 256bytes, and might get smaller with future
>>> hardware generation, also advanced atomic 64B write to clear the poison.
>>> But I don't see any of that could be incorporated in, given that the
>>> filesystem is notified a corruption with pfn, rather than an exact
>>> address.
>>>
>>> So I guess this question is also for Dan: how to avoid unnecessarily
>>> repairing a PMD range for a 256B corrupt range going forward?
>>>
>>> thanks,
>>> -jane
>>>
>>>
>>> On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
>>>> When memory-failure occurs, we call this function which is implemented
>>>> by each kind of devices.  For the fsdax case, pmem device driver
>>>> implements it.  Pmem device driver will find out the filesystem in 
>>>> which
>>>> the corrupted page located in.  And finally call filesystem handler to
>>>> deal with this error.
>>>>
>>>> The filesystem will try to recover the corrupted data if necessary.
>>>
>>
> 
