Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE85151B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379641AbiD2RZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379587AbiD2RZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:25:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33296D87D;
        Fri, 29 Apr 2022 10:21:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEDjSR032133;
        Fri, 29 Apr 2022 17:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ITJFWOJ8Des9F2VQx97NxLIZfO98JkNJSO2flwW4C4s=;
 b=Ju3f9JCQoyWu2VBWgn1/XH7btH/i2abmiNT4vaGCgEa7uVuCz01zHgRiDW9cu0u1tcrg
 KngwVfDJJORXWE4eXspGXs6sXhncEKXAr/n0ETYHjvzB0lfdEgKVDfnnYnEzp/H27qG9
 4A0Qfnq5K+4zzZmpbj2j+T8XQr/P1onDbFAbcoNtcl/mTsrguHsnFcTDQJX/XfeMhPHn
 cePG5qR4OmRh8q7kJGL83PmffLbGTuOx7SbEQwPk1pFUh2BS1/4cs0YON7IAWi36ljbr
 4rr5U2TQs7NrCQGJfREj/0cVGqZtB+Flyk58X3ESk7AlRnMgIMnvoSN49VDtGY2m1pWG FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb106pgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:21:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THGEvK014493;
        Fri, 29 Apr 2022 17:21:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w88pry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myoMj48p0UUIr7Pk3aIHDPCgKJpg+qx4lMVxb9SH0pSELNXQB0T+Tx7PU73kpY/bVY+wpNWowzzu2qOo6uBwPU/2mPT9fhwvo7+dm5hFbSLMPf0eVIbaIx0nl0qYRJ6onvyv2U4dq/7BlV1v+J6aLyHaLH2pIfLz83EyaG5L5v1FOrOS7pS5jljambCtZth5gobUPE8wDJ56VP+lB0aLyonjrTVX5HRHTZUqvgLBR2zxiFMbEFywhwHSwF5NQtU24NQV+UCyOeNfHdXPr/ZNYNHQwtfuEdOhhA6HWpTZqea54z6SUVnTDzXY6Xs6oD5KXNp5n8dB7nkxLzlziGoMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITJFWOJ8Des9F2VQx97NxLIZfO98JkNJSO2flwW4C4s=;
 b=F+1+vb3ikEdsBEEiyzZ4JbnBcKOACcdIbw09ZDY35rCg13Hb6K/xJtVWFxr/H58ZrYHU7SowpL4sgWswQyUcPQ5z1MK/o4kcx5ZgbnuohpfwjlQSiJ+KkczIK3tbB23xGQuX/3BQwInx9t0tZEWxmoaArNvo9xux4ZhCYWgjWOKq4EVShh1cWOE6k27PGZFfRi2cYeSQsz7vIr9QAZYsANkF2dp8qYxeNvJfC/AIrLzh1cvbOifPToJI9BuXUZvAEuvB4CkCDU6PliB7JumlklccdK0w4K80KJGSHdN9Oe5nmxWXfTyShIBK70wzPAFYqVeoNBRToZ5Yby4H/SQfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITJFWOJ8Des9F2VQx97NxLIZfO98JkNJSO2flwW4C4s=;
 b=meAeF6VxtwNblCQP+BPHvsVntipErxsR966Vt8CMjaq+sc7MInjIJyAocV6oEteF/a2YdxtqD8eSg02eFYhkUnUzjjzUOYtlCvfFrGjB7M98TTwCoiLr0uZUi4bR98cytB9IRQcueZaYOXxva/l9llnX9V7AIIb/uVTcegJLw2E=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4019.namprd10.prod.outlook.com (2603:10b6:a03:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:21:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 17:21:27 +0000
Message-ID: <6ce5af72-52ba-7cf0-8295-7929b9b0b4a8@oracle.com>
Date:   Fri, 29 Apr 2022 10:21:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v23 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
 <20220429145543.GD7107@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220429145543.GD7107@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d48b5e3-e468-4a18-020e-08da2a04b1c2
X-MS-TrafficTypeDiagnostic: BY5PR10MB4019:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB401979F14D98A12E1B5EFE9F87FC9@BY5PR10MB4019.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EU7wgRBJJTnB24Pi1mV4xwu/S+ugIEaxlSzi3NbK3iAPx6Zj6xoW3B1TZddqT90xCqezliPAKpoD7rfUSQ0A6CGCHnwBRNsmTDBivVNNOm3QGMRKZ2GQZp0KsETTLgOcWv3+pkkQjgHcUUQy/iMAg9gqTXvDCM4NfzSNmFEhALyGdZJXDcNUjDlbjJ84s95eyYNsDJq1fL45q7+WEnVzcv/1gFerOLXraaSzkCqha9VOQs4TSeQpem+bQ5DXUUU2UUBJegidzOWMolp2rbwMXood5AG087k5PMc2kGh2dd0OPQxMFHuSsfZ0QHrrQPAfNJJZwJhFzR27hsGNRV+dZXhT4oI+HID53xxw7hthDqdDOPt/mq9CM+4EThQ+rCu3AR1YxVVPgemthy2atH/eUn2iBv2uMRVtkTp3bT6KYFXLSGRBYQr3SV82sjNY2KhDJhaJTSQ7W4AadmkPIp5UnZy0u88tkHmbNpucSdr/9SM427nl4ABtaknoYjJXhxa5oPWXLFO7v2I+b8l01pNH7DsrVZIw75IjXq0a1hYQhcmsECLXIYKX7tNzgPhoe+LCAug3X2zuVvfaWibiGmgkttiQ2smeVHPeiDouf3LpLJiQOV4JSUbdBpVjy9pj5oQQ072X3lgGdkw8XEp4at1dFh9d+qY90oHBlehNM8xC2fXQ8u1V45CM+rMTWEkX3OjTN6+Ar+BXgZP9+PlQo1tRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(31696002)(66476007)(66556008)(8676002)(4326008)(66946007)(86362001)(316002)(31686004)(26005)(9686003)(6916009)(2906002)(53546011)(6512007)(38100700002)(6506007)(6666004)(5660300002)(2616005)(186003)(83380400001)(36756003)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5GTnBSK1lOTTd2UmdRbmVlWnFkTEtVR0I2QnJjcGc1TGVDd0s4MGFZRXhn?=
 =?utf-8?B?dGJYTVIzb1h0NUkrMFhHdkFhOVUvUnR0Z3hwcjB2eWh0SzU4eHNmYUdzOEZh?=
 =?utf-8?B?bXdraFM0akZ2dkE5VVJ6clJRNjlIS1ljR0dmMGVqbDNzamhDbmJvVURIQnBu?=
 =?utf-8?B?UU0zbWZzZjd2TU5ENWFxMnNCSHpIZ3dJOHdieGFIVXZBeG9YdjVtejJNT0Zo?=
 =?utf-8?B?L0FST2FROWpzckk2OUUzR2F2OURoT0RITDd2OWE5UDRRVkU5L05ZemlGLzhn?=
 =?utf-8?B?RjN5cm9oRWQ1cXJGZ1U4TzFGaUFlcW1HVWNjZ1RDczJTQTNJUExmeHN3dUNZ?=
 =?utf-8?B?ZUFVczFnd1JNZWtoTUhjb1Nhb2hZUEx4cVJnR2UzZS9FTEJDM254ZVpXT1NY?=
 =?utf-8?B?bUxtNHpPbDZIeWkzTFdCOEZvSHpUNDZGYnhabm13QkpGeXlhNHp1b2VvOUNw?=
 =?utf-8?B?YzhxVVdZVjdxN093Vnd5OVVJdkhNcStvbjVtYWo4QnJnMWxkMExxZWZQSzdi?=
 =?utf-8?B?VzFtVXJZeCtuU044aGkwOExJVjdqSnhWWUZwSjEzSU5LZ1M0TVFxU25NenU5?=
 =?utf-8?B?WDJWSHM2N1l6bUwrUnFvWlp0cnFYQ2NJWS9mUzRqVlJQRU5NRGU2YTh1K241?=
 =?utf-8?B?ZTU4cGNDRjBqMXVIdFArRzJGcThWdXgxcjdOOFFVdm95ZUxEWUZiampsYXNN?=
 =?utf-8?B?ZzUzV0dzUDZiRXdhV3FGOUtoRnRLemUrZUF0QjdnQ0tmSGhBYTU2RlpoaFEx?=
 =?utf-8?B?SkNnWnpEMXU4K2ZyWDZCOXZTb3VvR3kvV0NBNk9nTjV3YU5CT3VIcjc5NFhZ?=
 =?utf-8?B?MnorTEdTMHQzTWI2RWtVcUowSFg2dFByNUE3TWNqZnRCWUtNQVBHeldxOWJr?=
 =?utf-8?B?TkNGMk92aHRvVEprRXhpNnIwYlpXbTBPanBDQWQrZVo4RWVoVllWUDdRWFM5?=
 =?utf-8?B?eHFKaXJJQ2l3a3RpL0IvMHRITVgxRUNtNVJJbFA5SlcwTHdSTjlUblg2L3N0?=
 =?utf-8?B?SHcrZUJRQWcybGg4Z1FocFlJSU9TM0NLNVA5NXY2L1ErN0ZtRGpxTGRDWm9l?=
 =?utf-8?B?WVpWSXJOWVlvREd2ZExTZ1lSd043c2tPTXFxdjV1UG9kTjI0b01ubmtkbzlW?=
 =?utf-8?B?bFRVUGIremhFYm5BQm5SYlJFMUpGWWI3byttOURPZERwR3I0ZVJIcnVuS0tN?=
 =?utf-8?B?VHNHNjBjS1BlcFJBYTAzY2tHRmordkJCVWlMVTdodFhieDB1TEhxK2o1NUdJ?=
 =?utf-8?B?Wk1Ld1M0cXlzUThlMXNUK0tncENnaElQY3BzbFdTdHF4U0NhcmQ4WkJFTEFK?=
 =?utf-8?B?djd6KzhyMERvZ3ppYi9udDhlV0EyTEtnVnhLZm1jN2s5Mk1ycVVhNkR4UnlF?=
 =?utf-8?B?Z1RmTG9ISUl5c2R6djQzZXdNeDEvdktuZlFVbWhRNHg0aDQzOXVaeFhtMUta?=
 =?utf-8?B?UlhYajFZejNac0IxeGZVUGdESG9kUFRiTWdEZzRoZVlSNU9uY0pKVjEwQUxh?=
 =?utf-8?B?M1J0d1VJdHNiZ0d5cU9ieEdMQjBIRnlsSU5mRkRvSUNPVTlXYW1sV24xaUta?=
 =?utf-8?B?WHdFSGVuMmRxS3I0SUNzcUJVNkNpRjNQQi9uZVhTT0liQkVoU1l4L1VJTmVP?=
 =?utf-8?B?RWgzd2sxR2tZR1F2dXVKaG42eXVHY3hEQTFtZjVLSk82TEZWR2ZzVVJ1aktD?=
 =?utf-8?B?ckpuRDNHQ2VnbE9uRTM3VDM3U1FwdjNBa2E5VG55UHIxSjZldGF5eDUwMmF2?=
 =?utf-8?B?eW9taGF4SnFWL2lmL3RLaVdVV2FuamtXQ1J1b1JFbkVwTVovMUFXSUVMYXE4?=
 =?utf-8?B?eUk0M2wxcnBvK2FTUkFjaFRsYU9xZGhFVkw2RWUwRklUdkZiTWFNVER6WGFQ?=
 =?utf-8?B?Z0VBekp4dUJpM01BN0RhRm9HQUVwWndoRmk4b1p2NytkUURhbjI2ZVZYbDgx?=
 =?utf-8?B?WVJSbFhUQ2E5VTNycFZyb2ZUc3g5eVRDZ3RCVU1YK3hEYUdFTkV5ZFFUS3NH?=
 =?utf-8?B?Rk5jbFZnS0trVDdJTFF6ajJQdnVLenE3S2FBUDFuSEpHeFBkRGQxOXJaQXhZ?=
 =?utf-8?B?di9BQXZwZlFmRlIzRUNvSzJWMU12WUhodzc5OC9iTXVzNTc4SkxBTHhBdzZu?=
 =?utf-8?B?VXFjV3Y0UGJjdVF2bnBIRlkyOU5hRGs4Smg4WXArSW9oZnp2eVNpL0xkVTdR?=
 =?utf-8?B?U28ydWs0T0s5L3dObHdYMTNraDVuU3dJUnQxOXRqVzNUeVlNblVLdlRHSzdL?=
 =?utf-8?B?SlVpUWVQZE10VXVKRk1vRDd3bzFkUlQzcnhNL2tEbmNSZ09xYzg5bnkrZ0dX?=
 =?utf-8?B?Z1VTOE9qY3NxWGF3NEZ0ZWM4bExTY2pqbkNuaFE3NlA0UkprOGg3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48b5e3-e468-4a18-020e-08da2a04b1c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:21:27.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCApj8uAQVq3e3w6MYyAhmPL9QWCJ2+aW8R/oxWBxdI1fu/8oi0OuuvU6st5zot4VQP3U8s9k2roZHTyD87MPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4019
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290087
X-Proofpoint-ORIG-GUID: u44GQK3CkZZf0w7nVQg7ApqTSAx8Pui8
X-Proofpoint-GUID: u44GQK3CkZZf0w7nVQg7ApqTSAx8Pui8
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 7:55 AM, J. Bruce Fields wrote:
> On Thu, Apr 28, 2022 at 12:06:29AM -0700, Dai Ngo wrote:
>> This patch provides courteous server support for delegation only.
>> Only expired client with delegation but no conflict and no open
>> or lock state is allowed to be in COURTESY state.
>>
>> Delegation conflict with COURTESY/EXPIRABLE client is resolved by
>> setting it to EXPIRABLE, queue work for the laundromat and return
>> delay to the caller. Conflict is resolved when the laudromat runs
>> and expires the EXIRABLE client while the NFS client retries the
>> OPEN request. Local thread request that gets conflict is doing the
>> retry in _break_lease.
>>
>> Client in COURTESY or EXPIRABLE state is allowed to reconnect and
>> continues to have access to its state. Access to the nfs4_client by
>> the reconnecting thread and the laundromat is serialized via the
>> client_lock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---------
>>   fs/nfsd/nfsd.h      |  1 +
>>   fs/nfsd/state.h     | 29 ++++++++++++++++++++
>>   3 files changed, 96 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..b84ba19c856b 100644
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
>>   
>>   static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	idr_init(&clp->cl_stateids);
>>   	atomic_set(&clp->cl_rpc_users, 0);
>>   	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
>> +	clp->cl_state = NFSD4_ACTIVE;
>>   	INIT_LIST_HEAD(&clp->cl_idhash);
>>   	INIT_LIST_HEAD(&clp->cl_openowners);
>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>> @@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	bool ret = false;
>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>> +	struct nfs4_client *clp = dp->dl_stid.sc_client;
>> +	struct nfsd_net *nn;
>>   
>>   	trace_nfsd_cb_recall(&dp->dl_stid);
>>   
>> +	if (try_to_expire_client(clp)) {
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	}
>> +
>>   	/*
>>   	 * We don't want the locks code to timeout the lease for us;
>>   	 * we'll remove it ourself if a delegation isn't returned
>> @@ -5605,6 +5617,58 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +/*
>> + * place holder for now, no check for lock blockers yet
>> + */
>> +static bool
>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>> +{
>> +	/*
>> +	 * don't want to check for delegation conflict here since
>> +	 * we need the state_lock for it. The laundromat willexpire
>> +	 * COURTESY later when checking for delegation recall timeout.
>> +	 */
>> +	return false;
>> +}
>> +
>> +static bool client_has_state_tmp(struct nfs4_client *clp)
> Why the "_tmp"?
>
>> +{
>> +	if (!list_empty(&clp->cl_delegations) &&
>> +			!client_has_openowners(clp) &&
>> +			list_empty(&clp->async_copies))
> I would have expected
>
> 	if (!list_empty(&clp->cl_delegations) ||
> 		client_has_openowners(clp) ||
> 		!list_empty(&clp->async_copies))

In patch 1, we want to allow *only* clients with non-conflict delegation
to be in COURTESY state, not with opens and locks. So for that, we can not
use the existing client_has_state (until patch 6), so I just created
client_has_state_tmp for it.

-Dai

>
> ?--b.
>
>> +		return true;
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state == NFSD4_EXPIRABLE)
>> +			goto exp_client;
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +		clp->cl_state = NFSD4_COURTESY;
>> +		if (!client_has_state_tmp(clp) ||
>> +				ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +			goto exp_client;
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (!mark_client_expired_locked(clp))
>> +				list_add(&clp->cl_lru, reaplist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5627,7 +5691,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		goto out;
>>   	}
>>   	nfsd4_end_grace(nn);
>> -	INIT_LIST_HEAD(&reaplist);
>>   
>>   	spin_lock(&nn->s2s_cp_lock);
>>   	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>> @@ -5637,17 +5700,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   			_free_cpntf_state_locked(nn, cps);
>>   	}
>>   	spin_unlock(&nn->s2s_cp_lock);
>> -
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>>   	list_for_each_safe(pos, next, &reaplist) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -5657,6 +5710,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	spin_lock(&state_lock);
>>   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> +		try_to_expire_client(dp->dl_stid.sc_client);
>>   		if (!state_expired(&lt, dp->dl_time))
>>   			break;
>>   		WARN_ON(!unhash_delegation_locked(dp));
>> @@ -5722,7 +5776,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>   }
>>   
>> -static struct workqueue_struct *laundry_wq;
>>   static void laundromat_main(struct work_struct *);
>>   
>>   static void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 4fc1fd639527..23996c6ca75e 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>   
>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 95457cfd37fc..bd15f2863823 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -283,6 +283,28 @@ struct nfsd4_sessionid {
>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>   
>>   /*
>> + *       State                Meaning                  Where set
>> + * --------------------------------------------------------------------------
>> + * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
>> + * |------------------- ----------------------------------------------------|
>> + * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
>> + * |                   | Lease/lock/share     |                             |
>> + * |                   | reservation conflict |                             |
>> + * |                   | can cause Courtesy   |                             |
>> + * |                   | client to be expired |                             |
>> + * |------------------------------------------------------------------------|
>> + * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
>> + * |                   | expired by Laundromat| try_to_expire_client        |
>> + * |                   | due to conflict      |                             |
>> + * |------------------------------------------------------------------------|
>> + */
>> +enum {
>> +	NFSD4_ACTIVE = 0,
>> +	NFSD4_COURTESY,
>> +	NFSD4_EXPIRABLE,
>> +};
>> +
>> +/*
>>    * struct nfs4_client - one per client.  Clientids live here.
>>    *
>>    * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
>> @@ -385,6 +407,8 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +
>> +	unsigned int		cl_state;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> @@ -702,4 +726,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>   
>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>> +{
>> +	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>> +	return clp->cl_state == NFSD4_EXPIRABLE;
>> +}
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.9.5
