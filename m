Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7E512212
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiD0THI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiD0THA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:07:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA122205DA;
        Wed, 27 Apr 2022 11:53:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RIUrbG032133;
        Wed, 27 Apr 2022 18:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zq2oCaZSC12CATp0IOvN+ArOF3vcdJmfu8YcVbjH0G4=;
 b=r2o3ejP0LjXVSqqr/Cel+A1dXoHkCwcLOvHqmlfEYfAJIfRXKja0Z5aRioz/BXLHm1aJ
 PGQUkL0n73pnGi3k6SDQWY949+pTIB/IVXcSGD6LTmSaMl1YUyyceq6sL8fDlCHi1w++
 vcgXanHmtiRAHpH1tGMaU/WlYYzQYNj9AHsKxMA3PsaEDVIXVwxq0/5i29S8v5VwPYyh
 TEBL9TPp6HYAlyAyC7pjFSuAZl6gE7XpvVGLbavS32w/HG5sAZMEz+emG0g6rKadExNq
 ZXQETykK9KM0zRQiSO7uFWlsnxKvH+uypF7lqkXo5hbN7SdYhmRNaFVCB5U0aPycgMPl 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb101ksj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:53:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RIoZN0033823;
        Wed, 27 Apr 2022 18:53:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymgptr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K72O7UUu+ai3FbHxVNA1ZXUNPF4b5USYU/Un98ap72Z68m3j6FFhjy4uK6bcOZhj1uf/lvfRoLlLc4yUvJ2i/KjXIcawm7PaJiLDoqqkM3tmZM07UsynHP6ceAV9xjL22t2aFxjJfSc7J/rU/srfO9K6SesWeaGNRKMPV+0KyKFR4CKo2yBhbK+OYL2KN/KzH4zI1SLz8AwUwLktk4ujKn/WiiWiHa9YcqKRnobfYQye3riGJepaoZgqMl2FMXWZ6tmgEpRjo/sVCtWa4ozGTWKYWWxsX5erinY+KbBxv9wrdm1jUZC+Ws8/l1GcwH7NFcfP/9R2O1PXhy5vm0FjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq2oCaZSC12CATp0IOvN+ArOF3vcdJmfu8YcVbjH0G4=;
 b=RctcLkM0VkHvpZlbtECHmv3hEyvn8pX5bXJIjVok1mvnlyn2izXc0zLwANj/e6dM9ZZgB5EuR94NrATz6QE1gUIOusM6EZraJ5i8qRMntin83yQbggJVlSmLrS+aMDbq2cV1ABARdAC4znEWjcw9aKB1Rrw/T9skMREPM4gVfQVKJRgacpMrOnB2uUYy4nI6wvS8xod0zqL0/tmAHuLJrGOGYqLVfsJJJlFpxyemqx7K7tu6kvJAuRTCaLE9Gxc4e6lL2qNsT7eY3IbLVgAkViOyz2/Q85b9jc1YhQ4o6TLwo3HJ33/ayL+AwL6EpkjiiJsBIl/ONRFJcoIh6iXzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq2oCaZSC12CATp0IOvN+ArOF3vcdJmfu8YcVbjH0G4=;
 b=uO6pfx9PekuKWBHtCKWCZX07Ij+uVz12MM1CQU8zk+aZHCvwJhVTrpLIysUzMzEjW4hlb8LGAq/LvN+rrz/HziKvX53hxYw/dMEgvKk4imXrW4ybbKDUB0KsfMVglI6iuMS47iP/S5SDsepcuzvfIZFZo8RqxUtKbSmf0SMsXdk=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 18:53:45 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 18:53:45 +0000
Message-ID: <f4f97c3d-ea83-cade-e12f-aa8e043ea551@oracle.com>
Date:   Wed, 27 Apr 2022 11:53:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
 <20220427184653.GE13471@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220427184653.GE13471@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d35825-4ef5-461f-d5ba-08da287f41d3
X-MS-TrafficTypeDiagnostic: SN4PR10MB5623:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB56230B4ACB0D98173D449B6087FA9@SN4PR10MB5623.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7zB4xaDpeNvJ/joFlwFICXCbG21aPuZ1drqx8IC0Ip494Vnflbz5pFCBn9CjyAc1dKR1KlZkeynRViHMLZIXTyq75lVHcn5tpTLqsasp2zkgDTpw8L1tI3m5mnRILg/rgxLrfgFZyoDjM/elYawtiK4h1w/jIrcdFiANQOwBC8aRGYpFTmOt1Llg3abYW4zIA4ArvGTT151Xt5rxqdoVShYUXbSj3KqI1fI/O5g8G7TUGemRJXfM1NtauTkucKH8N9BlxZG1hRrmwz2EsaZHOBRfZ5pYSegXusMHSCV+T5t8OPhV6PK2eC/0eSE5rS6NMhiPqiarU6rNUNqbHVkIGVlBB9OilZEYZVlgRcI2r3oP8IcMPAm5u64CtPrQotZy5ttMQmbGYvYWVElUuBv76/rxIpY4gFCvAK9GwmbNgThZWiTyH6gjmaDqQvQwbcLlKMP67UQJKewuqaB2tGI+KiFvlVeLEjKCD/zGYwLBruZwDRRjQPK2xJ15uqV/vXAKLQVyPkge7WbV133jcf5CECQedAs7w4a2zNuDweIIkqNVz6+8ZkKE5NfHt8R4j6nJNWfEOoWTad7Vh3aEe5rmoXM3jxA+SWiarYxPYS7tpOQF2ptouDkmG4kCG3ssJDn7unn2Wx5Kh5HtrPCGdRt/kHF9VQFBbRe/LwLlb5DjAovJVqHzwFPex+KoB7DHFWu89lzZZ7wk/V9MORFNrxERg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(83380400001)(66476007)(36756003)(6666004)(6506007)(6512007)(53546011)(186003)(26005)(6486002)(31696002)(9686003)(5660300002)(2906002)(8936002)(8676002)(2616005)(86362001)(38100700002)(6916009)(316002)(31686004)(66946007)(508600001)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThEaHNmendNNnNaMEhqeTdOQ2x6dmNtcjdubGdERnVCYnB5VHBaWUJkOElC?=
 =?utf-8?B?dW8zOTNiTnM2Q3J5N0dDcFlBckwvcXQ5YVZLU0podzZ2Z242Y3JNQ3d0bEVv?=
 =?utf-8?B?NjE2cHVuTTc0cVJGV29BTXdGZjlObXlibTFPdk5SNFFpWWdtUGxrZlJYTXM2?=
 =?utf-8?B?dzR4Mndkd3dTeXdYRlJhZjBrdlFuTGRBaHJlSlhzUHdaTVo5S2k1TkRmelEw?=
 =?utf-8?B?NGc1NURlbGVidFcrOEMzdXcvOXJLSlhDUnVXQmNBUXFDYjR3Q25EVHhtUjAy?=
 =?utf-8?B?b0JEYVZzSzlYdjBMWkNtekNBcGU0SFRKMGptUFI5UkVWWDVGWEZNNFFsRzdU?=
 =?utf-8?B?d1pic0h0bkhvSEZhczVUdlh1dm9KL1NScnBZNmZMQTM3TXd3WFg2TUFHRVpQ?=
 =?utf-8?B?Q09jS3NIMUFaYTBpdXBNM3lqUFgxYmhUZEhDLzgrN3BpbzYzbC93SkxjNGF3?=
 =?utf-8?B?NG1vSzFYdjFqektvNStqUXQ1cDcveXRTdDZrZlhuU2NiVk5ERGlZM0tzeW9Z?=
 =?utf-8?B?QXJkS0NFVHVURzcweFJUUVhURGN4RFBDMTZFUytMZjJzMFNSSlZNRE5EdEUw?=
 =?utf-8?B?b08xeDBxWkZLeVJRTlBSVkhyY0lFUDl6ZjRFMTQ4N21XQVV5Q0VvWkpOa0Y1?=
 =?utf-8?B?SDF1YlFxR2t2QXFtbEsxelRoOS90VXpicnJUZFVwVEhaRWt4MmNtcndJd203?=
 =?utf-8?B?aVhhZVc2dmZTcUhrWmFCanB1UFYwVnptNGVDS3VQVEk0NERvQjAvR24xQUs1?=
 =?utf-8?B?dzlWSVB3d2EvUllEb2swOGJZQ3NLSFdTaVIrcDFTV2RSdkZEakR0MXN2dk9o?=
 =?utf-8?B?OGRoQS9ldlFhUlRVaFFnQ2YzZnVVUXBnWEg4TkU3dnZaZkhRZXRYbVk2Uitt?=
 =?utf-8?B?Rm80VGdpeUZzZ0Y0K256SklhWGVPY3Yxb0pYZ21uTERYNkgyckt4dVFIMkxx?=
 =?utf-8?B?UStMSVVQeHd2amlaWk1VYjVvdk1SN0o2a0h3RlhoSEtDb0VDVEN4VElrdGt4?=
 =?utf-8?B?NW9ETXJlZnNIcXRZM0hjTnk3RzlqZ3lMNG5RWHZxMEErRyszTURxRmluWlcw?=
 =?utf-8?B?dlJZWURYci9yU215WEoySHJSOTBkWHVEYXZUSXpnZWJGN0FYbXRzUnJvS0lZ?=
 =?utf-8?B?bHJEUFNOc3JJYVh6U2x3N0xIa2EzdW96V005YVMzd09kUzVEOEN6TWcxZ2NM?=
 =?utf-8?B?SXljR0hPNWN2Y0t3anIrWGJ1UmF5ZFkyQkdlbXFYMFVkWElMMEVaTEZBL0Nn?=
 =?utf-8?B?aEFqLzR4TVAzTlZBaVY1dFFQbFhFQWxkZUFSdVVyUGg0a0Q4NGJtSlNTK3hH?=
 =?utf-8?B?dndMOCtRbnFSVWEvanFRc0ZFTnJUWStDeTArMFRVT3pnR29IZmRWQXd1ek16?=
 =?utf-8?B?ZHVPd2VDZUhSUXpNNnRWeVNaUE01bXZXTGM4RTlFeFB0UzRJa0dNeDNnRkRk?=
 =?utf-8?B?cDZDRWE0WDdqYjZuRjJIWlF6THllME5QdzU0eGgwRWpOenRpL2pub1hEQW10?=
 =?utf-8?B?OTR1TXVWZXFrWGtJK0ZMcUdxYmZZY2ZVb2lKZW5UUHhOOXRLaE1lKzF0a0NW?=
 =?utf-8?B?QWFPOUN5TjUvREhMU054UEwrQUZIdDVVaTMzWGRhSnVNZUtRVEZaZlAzSkpa?=
 =?utf-8?B?SDB3OTcwdTAwMTlGc1B2dUVqL2RKUTN0RFZRUXZIZkx4M0o2TnBmOGpzbUhq?=
 =?utf-8?B?LzlhRWdHcFVnUzZURVY5VERmSE42L3Zib1dGdVJ0RndpcEJuWk14OFRoRSs1?=
 =?utf-8?B?cVpSSkEvZm9jRjhOdFJobVdYcFUxKytZTmpZdnBzWVE2REViaGxVWExTb2Zj?=
 =?utf-8?B?MVV3dVVTaEswaHZ4YURHZWtYTjRsQzVyYnZmaFBYVXU3alpCeW9ES05mVDJB?=
 =?utf-8?B?bjhLL2pqMFd5REx2cUgxWWFadjNqVDVSbGF4VEhLbDZMQXcwSUxCM0tJZ2d2?=
 =?utf-8?B?SW1wR0ZkcUQvZnBOL2h2bmZMdUprQXZsZHEyRnJVczBjeVJnTTlNWGcwY1B6?=
 =?utf-8?B?QlN6eHNxcFdPWllhUkVCV0xXaHRYdDlSclNzeDhGdTAxaDE2U284cGVZbTdZ?=
 =?utf-8?B?NURiYTRTaWFHVjRmdVA0VDBhOUZjczExWWtXamhwZ3BvNk00UDdCZUtZMDNt?=
 =?utf-8?B?UFhTbGFmaDF6VnF6NFM5SUE4MTgxb1VvbkJvbkVmYVFkd3FvTUpJeVhTVjZF?=
 =?utf-8?B?VE1WWXlYQ0E4ckR3QndPeWI0V2VXTDZQT2NnS3Y0TmdMYVBScG1XTXlaTEdp?=
 =?utf-8?B?VEtSTlB1STJ0RVovM2l2cG02TnJEM3M1NHRhSTMxcVFMNHY0Nmp4c1ZhQWJu?=
 =?utf-8?B?QVUrU2ZFZGR5UmRCd1E3bEdaZUFQWGMrYnlLYy8weC9vM1QxbHZYQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d35825-4ef5-461f-d5ba-08da287f41d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 18:53:45.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd8sP8Lb+TLS3r0pycUzQwRswfsuRQ7dK5VLH1YoRzFWrl3kIhIkgbe/ouuFIBTqBTt9+hl8AL53Faw9LvHxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270118
X-Proofpoint-ORIG-GUID: rrhnD62UeXteodIn0Ge2rZb1qUkZGhSe
X-Proofpoint-GUID: rrhnD62UeXteodIn0Ge2rZb1qUkZGhSe
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 11:46 AM, J. Bruce Fields wrote:
> On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..216bd77a8764 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>   
>> +static struct workqueue_struct *laundry_wq;
>> +
>>   static bool is_session_dead(struct nfsd4_session *ses)
>>   {
>>   	return ses->se_flags & NFS4_SESSION_DEAD;
>> @@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>>   	if (is_client_expired(clp))
>>   		return nfserr_expired;
>>   	atomic_inc(&clp->cl_rpc_users);
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   	return nfs_ok;
>>   }
>>   
>> @@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
>>   
>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>   	clp->cl_time = ktime_get_boottime_seconds();
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   }
> We shouldn't need that assignment in both places.
>
> The laundromat really shouldn't let a client go to COURTESY while there
> are rpc's in process for that client.  So, let's just add that check to
> the laundromat (see below), and then the assignment in
> renew_client_locked becomes unnecessary.
>
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state == NFSD4_EXPIRABLE)
>> +			goto exp_client;
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +		if (!client_has_state_tmp(clp))
>> +			goto exp_client;
>> +		cour = (clp->cl_state == NFSD4_COURTESY);
>> +		if (cour && ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
>> +			goto exp_client;
>> +		}
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		if (!cour)
>> +			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
> So, as in mark_client_expired_locked, we should only be doing this if
> clp_cl_rpc_users is 0.
>
> Also, it should just be a simple assignment, the cmpxchg isn't necessary
> here.

Got it.

-Dai

>
> --b.
