Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8710F512A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 05:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiD1Drw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 23:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiD1Drs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:47:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090DE99685;
        Wed, 27 Apr 2022 20:44:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S3Wvmj018608;
        Thu, 28 Apr 2022 03:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oEETWacLqO3aG4ms0EFVUqPfZM7tzjlq2xvn/lUfaRo=;
 b=cPqn+IjLHksx2KT6vnpjlgJ4Pc84CgjnqldZT1SJRwk9aq9ZUnfwkl7pfLjjRdUPpTc7
 vSQ2fxMcwEs6KX4iKrmTLYPwu1hcV+0At31a81XdKBBeGd0fV3IHrf3dZSUsXrnuRvqd
 JoBBgxJrHwix6ziKF5OiwP1x+tk2URsE7jxlpd2izurWsu/c3Lp0qjKlFpC8RmEFaMAK
 xqEOlMO5CWVodpEuiIv5yvxKvbH/0E12HwKDTDBflOfurgxgmWLVPQl1ETetytnIKIpy
 poqc8/nu5n8nUOkYMxoANXY90jyiNZhqxa+FmrxawmeBT2t+O1alXFDYsotK1hjOTbqT mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k2tjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 03:44:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S3ebkh027229;
        Thu, 28 Apr 2022 03:44:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn1dnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 03:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/+bJxfKjfPUEbnXjxAJcTjIoBa5v3WXgxxwoquogQ/1CNZCCqqPJidYQmBtLDIufE2PlIAdbSQG7kuMfcxWXCgHVb+PK+YV0Gk+pDjrmqdNNxs7xJXKDBPfPbs1QLhD+SAtibQEvjJjLPHa2BD7MQ7noh6ZNQ8/Ltbje3iDm1no+2r8IlRglpEosIZxai74cOUnzG+i2qgIjdbLhJPA1zhfXiTEoPnmapRQNfIqLqdsie4wpkush9fCTEio/69i26c0kfdyZMdLcWH8QXHokaeJhtkHZgjpKK4MmuRnNBABeCbyMeUKuWXM2tFjz2R6Hdk+t79+7VYgHn4s+mUwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEETWacLqO3aG4ms0EFVUqPfZM7tzjlq2xvn/lUfaRo=;
 b=nzExuoIu0hKIbgO/UjmclAStakeydgLyHnAAurvvXU+YaU9CyhfottBCui5EZ3ohlaI/ue/iHYRy4d+haZYcyg1SGJSgcZ5nsNLoSnShjXRTEu5MjLNjElAXS28n3vK/FQy5oDhWVYseEQ5jLItFUxUYi/LVeqwWHiTK3s5izpY21A4EmTrrP4Rr/Z+Fb2DAtao69yNOGWvKAEFk82PjazTcMhvxrkxj44yoeKQHPPTT3Q/uO4rBrO7Xq+jlu+b8YDVgv2o3HfD2729qpYL2PQnR247Al/7R5gqjiCnHsxwLbL0F5gz2B2r4dbBDQD3d2wyVPsG7JFb+bglxU6Ovnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEETWacLqO3aG4ms0EFVUqPfZM7tzjlq2xvn/lUfaRo=;
 b=gZ9riqDyiM3Hapr0fQd7mXq0bfHp+G5YhMo2X9VwoolunO1jH+cJU7jrbahbKq3+0ostBzgOpX93Imr7C6Qg2+RW0rMS9H67jLXtycJcoPvOgm8O5qcaH6/KzGfkRMJZ/zgkjcZ3gQ9JyFP7xHonuOcrs9VGhERGbgneznXKriM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 03:44:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 03:44:27 +0000
Message-ID: <3755605a-40ce-546f-b287-aa1cee10cd86@oracle.com>
Date:   Wed, 27 Apr 2022 20:44:25 -0700
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
 <20220427215614.GH13471@fieldses.org>
 <24607d8d-9a69-b139-ce1a-c0f70814de05@oracle.com>
 <20220428015234.GJ13471@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220428015234.GJ13471@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713c45d1-750d-433d-1f6c-08da28c964b6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4256:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4256A3B6CA1C28B481E3F15E87FD9@MN2PR10MB4256.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afYwcS8wEH297KT3SWmLs6Qo2eeysth/XK9azCP13TFZZwStbNMFNalJY/aKjKAfaDcosVUBaEa5HPIx4CiOVKOQ4FLQPgR/cJSxEw8K40RgBPHXrmOSTrlKgdF4c47jjWMCRJ3GX8VfQBq5q17gIM0s1FSgbHwuKMRtwfrb8pz6pr/UcfdH7fzNkTyBpuk7toi+ffO28CBpNIWQoWqks5HvRnBc0P4yDWtpt4MY4qsIywZxi45+dkokyDJ1ttTHvtw5YbA0y7IkljkOQ1RqTPUxqkRYTMzUSmG5k8TdORyIQvhV9OTavCfhPvgdfgc18bWHlVrCQI9EOnZLzbhN794EgAqLaeqBUicKMPgtzo8r64dnDKkILmQx7cW8PSvJM2QUIv4vxTIZKaV3G7NbqZoml2Of4YCQuGO3T77jYszib8xJyxwTey7TRVA+atKsxF/ML1oMvjA4jXoIYTTklDB/Kqlrcc0614ArICCckhlsRyB8N3KEkCD/h9zpgRPtDi5QRevDoA1wFrpFqK5Dh9H0XeOU6Nd9qaT09/tskr9Zo+Dn+2xjVgVyiVu/7fDk8Nze+56LOKr50StUQFo6cE2oNj2+7KpYk3tYf6Pht413sKfP964fmDOvJFOgRXB3iQa/Aod10UxdruT9PvIFpUY7D0O+31tBLLxC6hjLRum7nNUvzJqgz/QxHh2wFdJdtHsSdikLuMJx+N3uN5Jguw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(186003)(36756003)(4326008)(8936002)(8676002)(5660300002)(30864003)(2906002)(31686004)(6486002)(9686003)(6512007)(6506007)(66476007)(2616005)(66946007)(66556008)(53546011)(26005)(6916009)(86362001)(316002)(31696002)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hSa0tPQjRsVlA1RmJKOVB5Yy92a1BQOVlacWY5YzEzQndYQnpVRWMxcTVo?=
 =?utf-8?B?WE5SZE5mWDBNSGZyZXV2RXMwOE9sVWFTelhXOEwvb2xGODI1dWFaN1BObktt?=
 =?utf-8?B?UEY1NHVBdDhiRVdJd21yZWVnSnhSbUhYWjJUQndsNUV4ZEliaGg5VzMzbkt5?=
 =?utf-8?B?dndPRTB0RlF1THVyd2VHQnhRU1lLZnI5THZ4YjBkQUoveVYyTU9pU0YyR2lS?=
 =?utf-8?B?cWNKdXFJYTJkdW5Ucjlwd1R6K1Q4K1ZndUYwbVIya0lsNXNsa3FzaEJCUFNv?=
 =?utf-8?B?TDEzemtEL25KbFJpOE1CNy9SZnZHYUU5OEx1QjNvU25DOWdNUFdLVGJGQ1A0?=
 =?utf-8?B?OStnZmt6d0dUVHRBZ3BMMjh6YjdFZTg0aFl0UzNqbE8rOWRIK3U4czhPSjF2?=
 =?utf-8?B?SmlMVHlhbW4ycUlRWlUzanJ0RWNUVWJwNlJOL1hQb0M1dENmQ25qMThOck9o?=
 =?utf-8?B?b29YRXlMcXYrMXhveDl3em81U01TWE9FM3F5QWNMUS9aWm1BaDdUbnltVi9v?=
 =?utf-8?B?bW5ERzNFTzBLOWlqeE5scGdKd0FKekYwdWZLSUIwZVFTL0Z5djRjd2trblBX?=
 =?utf-8?B?Y0dnajhCRGJDMkNXcU1oaHFMMkl2Z0x2ZFlaam01STgvanl6WDF4THY0amF4?=
 =?utf-8?B?eVVwMnFDNk9iZ3FlZEd5cEk1MHVyOTNwb25haFJzOHprbms5VHNUaDk1Y0Ew?=
 =?utf-8?B?dHhDY0pxQlNydEJwdkxsYXducU9iSVN3L2lwT3lDQ0U1RE52eEFCN1JHYXJH?=
 =?utf-8?B?b3pvMncvZFZJTjZBQUpldlJvN0ZiZHFkcmh3SjVJb29sckNvTGRwWTdnK09X?=
 =?utf-8?B?MS84UEx2ZmtmZ2xNKytyVUlzUDBIanljNlNELysxNEU2WmVLSnJBWHRYUmFs?=
 =?utf-8?B?MUkwaEFXYk11bGNxYi9kWGJjL3BrV29lQWF3U1BaT2ZWN0h4Vm52SWo0YXZa?=
 =?utf-8?B?K0ZxZ25pTVUvZVJtckxnenE1ZGpiN2c1bi9JTnAyOHl6UHQ2ZHFiZ3p6SDlF?=
 =?utf-8?B?TEJsZjNsdmVzdjVTUzdkT3ZGUlE0UUpRTlUxYW4vS0RhSXZIczhXREpyaDkw?=
 =?utf-8?B?LzdJT0lzSmgxR1VUR3Rqc2ZSY24zM0hPM0hWdytZR0l0bUl4T3RjSDRQYlI1?=
 =?utf-8?B?SG9rMTY5Rld0YzFtQUdBQlZ3aGZPYU1rd2hHZjlQWDhhS2p6eVVNMTZSYkFX?=
 =?utf-8?B?SGlZVDNCd283RGZOS2V4STRzM2w4UVR1MmdGcG9ZNTgyMGMrMWRGYzNhMFhv?=
 =?utf-8?B?Qy8zeDhLSkduelpYVkhEbGY0YXNJZzBlOFBRR2hJc09VYUx6K1J6ZlplMDlS?=
 =?utf-8?B?QXBuL1ZIM3drQlNvS1hYYmg0bW95V2JvV1V4Si9yYlpuUVBmOUxFNEpuTUNJ?=
 =?utf-8?B?SlBSa3NiTDd2ZERDTHFGeDhyT0FLbVJtTGxCU0JaRVQrSE80NzlsUW04VTJm?=
 =?utf-8?B?dDB6eXN3Mll5WUgxQUZTR0ZvaEQ3bjBSbDNHVXNsQjFIUXMrREVicEFJVnIz?=
 =?utf-8?B?cDdyT01oelFGSmo1d0VncHVMWjI3MGlaK01DQ0svVU5wYTJXTzNjbzJyQlB3?=
 =?utf-8?B?QmdXcHBtOWttTklTaUJkbjdwQ1p3b1ZLUW5Yc2prOGtKWDlXR1RIZDBMNVc3?=
 =?utf-8?B?U096Y2dhVk5XUlplNm55d1o3NXV4ZitMc25JT0xHNnI5S25FcktMaDJ3Sm1z?=
 =?utf-8?B?TGRIRkkzdGxGV2cydXZuRU9ERVZ5T2doWWxQaUJEejNUbGlDUVdoeFBJTXlX?=
 =?utf-8?B?YmVpN25oeU1jazMyV0x6RVdxcTlFMno2NjlaUmtYOTRhZStVWTlLWmxFanVo?=
 =?utf-8?B?OURITFMyaUg2MlJmNnhRSTFNaCtuZ1VqYzZpOS95S1JTSXVLT2dqV2p4K1BW?=
 =?utf-8?B?UjBPZzQ2VHpiQm9zKzRRU2g1aU10UnZsMFFMWG40cjVCcWFESk9hN1AvcXdK?=
 =?utf-8?B?OEwyLytWVnN4SUZobTd5OW9tTDl0b0ptRGlGamxqMTVBQkhhNHBGOE1DWlpN?=
 =?utf-8?B?NW4zQTlIRjVSSTdIWEsvWWI3MFh5OXo1Z05HeUZMUVdHMnc2WnJuSVpLbjRU?=
 =?utf-8?B?VXNOZGFBa0lPTjNTcjR3ejdyRi9hbUQwQ0E2d1NxdWhpN2FFZFFndG4rV0V0?=
 =?utf-8?B?dUVjNWl5d1JZcVlVRFV6SDdadnYrK2RHYmtTbksweXZ2WW52T2I1SnkwVmNk?=
 =?utf-8?B?d3NlM2gwdG92Tm5wcGtQdVhId0xRYzZJSnlOWjF4c3hVY2R6ZkZGakZrQXBQ?=
 =?utf-8?B?WGJMeGkycC9JSlhqdDQ1eVRDVkNPQXpvekhhK2JMSmxramhpK3MvQ3ozbzZN?=
 =?utf-8?B?RjdoMDFpczhxSmo0QmlNUmpleFZSM01jb3ArclhDakhyUmNwRXJiZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713c45d1-750d-433d-1f6c-08da28c964b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 03:44:27.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hS+1d6QWBzwW5kH3YaMeZ8XBf6/LCxa3niWoNHl3Yl9FfZl1MtpxztHauxKvzM7FBHlELflZyGl3DzXOtVkoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280020
X-Proofpoint-GUID: tCvUwmSEfnEpDfHxnKLFajo-5_xYJPd_
X-Proofpoint-ORIG-GUID: tCvUwmSEfnEpDfHxnKLFajo-5_xYJPd_
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 6:52 PM, J. Bruce Fields wrote:
> On Wed, Apr 27, 2022 at 03:52:37PM -0700, dai.ngo@oracle.com wrote:
>> On 4/27/22 2:56 PM, J. Bruce Fields wrote:
>>> On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
>>>> This patch provides courteous server support for delegation only.
>>>> Only expired client with delegation but no conflict and no open
>>>> or lock state is allowed to be in COURTESY state.
>>>>
>>>> Delegation conflict with COURTESY/EXPIRABLE client is resolved by
>>>> setting it to EXPIRABLE, queue work for the laundromat and return
>>>> delay to the caller. Conflict is resolved when the laudromat runs
>>>> and expires the EXIRABLE client while the NFS client retries the
>>>> OPEN request. Local thread request that gets conflict is doing the
>>>> retry in _break_lease.
>>>>
>>>> Client in COURTESY or EXPIRABLE state is allowed to reconnect and
>>>> continues to have access to its state. Access to the nfs4_client by
>>>> the reconnecting thread and the laundromat is serialized via the
>>>> client_lock.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--------
>>>>   fs/nfsd/nfsd.h      |  1 +
>>>>   fs/nfsd/state.h     | 32 ++++++++++++++++++++
>>>>   3 files changed, 106 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 234e852fcdfa..216bd77a8764 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>>>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>> +static struct workqueue_struct *laundry_wq;
>>>> +
>>>>   static bool is_session_dead(struct nfsd4_session *ses)
>>>>   {
>>>>   	return ses->se_flags & NFS4_SESSION_DEAD;
>>>> @@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>>>>   	if (is_client_expired(clp))
>>>>   		return nfserr_expired;
>>>>   	atomic_inc(&clp->cl_rpc_users);
>>>> +	clp->cl_state = NFSD4_ACTIVE;
>>>>   	return nfs_ok;
>>>>   }
>>>> @@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
>>>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>>>   	clp->cl_time = ktime_get_boottime_seconds();
>>>> +	clp->cl_state = NFSD4_ACTIVE;
>>>>   }
>>>>   static void put_client_renew_locked(struct nfs4_client *clp)
>>>> @@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>>>   	idr_init(&clp->cl_stateids);
>>>>   	atomic_set(&clp->cl_rpc_users, 0);
>>>>   	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
>>>> +	clp->cl_state = NFSD4_ACTIVE;
>>>>   	INIT_LIST_HEAD(&clp->cl_idhash);
>>>>   	INIT_LIST_HEAD(&clp->cl_openowners);
>>>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>>> @@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>>>   	bool ret = false;
>>>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>>> +	struct nfs4_client *clp = dp->dl_stid.sc_client;
>>>> +	struct nfsd_net *nn;
>>>>   	trace_nfsd_cb_recall(&dp->dl_stid);
>>>> +	if (!try_to_expire_client(clp)) {
>>>> +		nn = net_generic(clp->net, nfsd_net_id);
>>>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>>> +	}
>>>> +
>>>>   	/*
>>>>   	 * We don't want the locks code to timeout the lease for us;
>>>>   	 * we'll remove it ourself if a delegation isn't returned
>>>> @@ -5605,6 +5617,65 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>>>   }
>>>>   #endif
>>>> +/*
>>>> + * place holder for now, no check for lock blockers yet
>>>> + */
>>>> +static bool
>>>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>>>> +{
>>>> +	/*
>>>> +	 * don't want to check for delegation conflict here since
>>>> +	 * we need the state_lock for it. The laundromat willexpire
>>>> +	 * COURTESY later when checking for delegation recall timeout.
>>>> +	 */
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static bool client_has_state_tmp(struct nfs4_client *clp)
>>>> +{
>>>> +	if (!list_empty(&clp->cl_delegations) &&
>>>> +			!client_has_openowners(clp) &&
>>>> +			list_empty(&clp->async_copies))
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static void
>>>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>>> +				struct laundry_time *lt)
>>>> +{
>>>> +	struct list_head *pos, *next;
>>>> +	struct nfs4_client *clp;
>>>> +	bool cour;
>>>> +
>>>> +	INIT_LIST_HEAD(reaplist);
>>>> +	spin_lock(&nn->client_lock);
>>>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>>>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>> +		if (clp->cl_state == NFSD4_EXPIRABLE)
>>>> +			goto exp_client;
>>>> +		if (!state_expired(lt, clp->cl_time))
>>>> +			break;
>>>> +		if (!client_has_state_tmp(clp))
>>>> +			goto exp_client;
>>>> +		cour = (clp->cl_state == NFSD4_COURTESY);
>>>> +		if (cour && ktime_get_boottime_seconds() >=
>>>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
>>>> +			goto exp_client;
>>>> +		}
>>>> +		if (nfs4_anylock_blockers(clp)) {
>>>> +exp_client:
>>>> +			if (mark_client_expired_locked(clp))
>>>> +				continue;
>>>> +			list_add(&clp->cl_lru, reaplist);
>>>> +			continue;
>>>> +		}
>>>> +		if (!cour)
>>>> +			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
>>> I just noticed there's a small race here: a lock conflict (for example)
>>> could intervene between checking nfs4_anylock_blockers and setting
>>> COURTESY.
>> If there is lock conflict intervenes before setting COURTESY then that
>> lock request is denied since the client is ACTIVE. Does NFSv4, NLM
>> client retry the lock request? if it does then on next retry the
>> COURTESY client will be expired.
> I'm thinking of a local request for a blocking lock.  Yes, the request
> will be denied, but then the process will block on the lock forever
> (well, for 24 hours anyway).

got it.

>
>>> I think what you want to do is set COURTESY first--right after you check
>>> state_expired()--instead of doing it at the end.
>> Yes, I can make this change. I think this still has a tiny window
>> where a lock conflict comes in after state_expired and before
>> COURTESY is set?
> No, I think it's OK.  A lock that comes before COURTESY is set will be
> caught by nfs4_anylock_blockers().

That's right.

-Dai

>
> --b.
>
>> -Dai
>>
>>> --b.
>>>
>>>> +	}
>>>> +	spin_unlock(&nn->client_lock);
>>>> +}
>>>> +
>>>>   static time64_t
>>>>   nfs4_laundromat(struct nfsd_net *nn)
>>>>   {
>>>> @@ -5627,7 +5698,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>   		goto out;
>>>>   	}
>>>>   	nfsd4_end_grace(nn);
>>>> -	INIT_LIST_HEAD(&reaplist);
>>>>   	spin_lock(&nn->s2s_cp_lock);
>>>>   	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>>>> @@ -5637,17 +5707,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>   			_free_cpntf_state_locked(nn, cps);
>>>>   	}
>>>>   	spin_unlock(&nn->s2s_cp_lock);
>>>> -
>>>> -	spin_lock(&nn->client_lock);
>>>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>>>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>> -		if (!state_expired(&lt, clp->cl_time))
>>>> -			break;
>>>> -		if (mark_client_expired_locked(clp))
>>>> -			continue;
>>>> -		list_add(&clp->cl_lru, &reaplist);
>>>> -	}
>>>> -	spin_unlock(&nn->client_lock);
>>>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>>>>   	list_for_each_safe(pos, next, &reaplist) {
>>>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>   		trace_nfsd_clid_purged(&clp->cl_clientid);
>>>> @@ -5657,6 +5717,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>   	spin_lock(&state_lock);
>>>>   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>>>> +		try_to_expire_client(dp->dl_stid.sc_client);
>>>>   		if (!state_expired(&lt, dp->dl_time))
>>>>   			break;
>>>>   		WARN_ON(!unhash_delegation_locked(dp));
>>>> @@ -5722,7 +5783,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>>>   }
>>>> -static struct workqueue_struct *laundry_wq;
>>>>   static void laundromat_main(struct work_struct *);
>>>>   static void
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 4fc1fd639527..23996c6ca75e 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>>   /*
>>>>    * The following attributes are currently not supported by the NFSv4 server:
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 95457cfd37fc..6130376c438b 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -283,6 +283,28 @@ struct nfsd4_sessionid {
>>>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>>>   /*
>>>> + *       State                Meaning                  Where set
>>>> + * --------------------------------------------------------------------------
>>>> + * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
>>>> + * |------------------- ----------------------------------------------------|
>>>> + * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
>>>> + * |                   | Lease/lock/share     |                             |
>>>> + * |                   | reservation conflict |                             |
>>>> + * |                   | can cause Courtesy   |                             |
>>>> + * |                   | client to be expired |                             |
>>>> + * |------------------------------------------------------------------------|
>>>> + * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
>>>> + * |                   | expired by Laundromat| try_to_expire_client        |
>>>> + * |                   | due to conflict      |                             |
>>>> + * |------------------------------------------------------------------------|
>>>> + */
>>>> +enum {
>>>> +	NFSD4_ACTIVE = 0,
>>>> +	NFSD4_COURTESY,
>>>> +	NFSD4_EXPIRABLE,
>>>> +};
>>>> +
>>>> +/*
>>>>    * struct nfs4_client - one per client.  Clientids live here.
>>>>    *
>>>>    * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
>>>> @@ -385,6 +407,8 @@ struct nfs4_client {
>>>>   	struct list_head	async_copies;	/* list of async copies */
>>>>   	spinlock_t		async_lock;	/* lock for async copies */
>>>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>>>> +
>>>> +	unsigned int		cl_state;
>>>>   };
>>>>   /* struct nfs4_client_reset
>>>> @@ -702,4 +726,12 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>> +{
>>>> +	bool ret;
>>>> +
>>>> +	ret = NFSD4_ACTIVE ==
>>>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>> +	return ret;
>>>> +}
>>>>   #endif   /* NFSD4_STATE_H */
>>>> -- 
>>>> 2.9.5
