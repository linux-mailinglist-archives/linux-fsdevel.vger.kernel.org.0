Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388EC50E9AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbiDYTqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 15:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiDYTqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:46:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE05FBA;
        Mon, 25 Apr 2022 12:43:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PIdlRO027770;
        Mon, 25 Apr 2022 19:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NCXBSG/1yaMvmFbTeTzHKzMCbRsa7wfFl+cCQNlVTGU=;
 b=qfxQTlth9n91k4SPjJG0EAi6qiI0/2JF+sBCuzaa/+jqntcsFaKT9I2KoTzdElGgD7Xk
 Fth6UsBGpj1cU5k3MeJ4RNiDPkpP7lYmsXUGtYrCK8fb+020CFOBGVK0OW80QRyXVj1N
 5Av67c1bJcoLtRAwF7RzpAvXTBQ6V03tA7md2M8NdRZk4vv1u0aZeaIkbs8AEfw24oIN
 p+NR0Vdzh6N5LYxHzWMMpbAM8uH2eEloR7aNfbFF4WhDH0afwRvvHKtJNU/oXIaiZiGD
 HAS9t2hH1zSes1cQwmH0VkwpmYNio/fGPsp/D/+/lTP7Jrdg3IacCi5Woni+bkT4VFhX ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9am74a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:43:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PJa5aT010868;
        Mon, 25 Apr 2022 19:43:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2xd7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOYOBccPMRZAaHMoqxcsoiDk7ABLI31JPgxHCl2NBA92JDf9PIVJN2CpzfXezZvHRHRyJfIQx5b+Z9kJ5ewwvghkXr+vAZm3TQEbkD455/mzab96jMnGkroYP15AIhKAfwCHF7jVAy9kGeL9LcoutIxKfBJ5CZPvm5djmXFbLJOVWsOupoCfLJTy4YvbFw4Xc4OzZMlMcn/90bt0NvR/uLPSzWGFnJN3AHbUJHYQ3n07rXLtyO0NfpEBASFuA0Gru5WGJugqlhNScS3kpB7wQqYFAZxuAL1EutRTQPprklMU4BldwgQRQTiWKFjhh31VHl7FI6q5wy5arwwyGDu0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCXBSG/1yaMvmFbTeTzHKzMCbRsa7wfFl+cCQNlVTGU=;
 b=co4zkh8qtJqIVjwR0Yn/8+59+FvpJUPz1rOwZCOM5bZA1gblP/zhEeups2AFo6yeSOzYh4B4fFpETeRvH5kByAAL9UpIAMAgP/xW3ayYi8AmDz5EpscFzbCruY9dpx+ZelUUzszPcGwXjK6BkLClQNZCwiv9+us93zZOWu6cKq0o7+lnvjXIkeqdkLLq+6QdkhB4yQ4QO6f6d7K4UxwSqArPXJVOxiLK0Agvh18hFy4WhQ3uSihTgM93s0L98TpUdOKFaBsnI5Zj9j6SFDNQXZ7IRgFsCO+W3Yal0j1ubDghB7AO9Iyrh9g5Ep6hEHw4uj76zaB9IbNmR4NRlDsO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCXBSG/1yaMvmFbTeTzHKzMCbRsa7wfFl+cCQNlVTGU=;
 b=zssmBQ65TB0549hWQZklyo5VhngNmxS3xGfp+QwUZ11cIQYrcabm5yOYm3XcSQbD8sGHPZGFPfPXa7L5750hN6xtd49MWjjoYP4U+GkMq9rcEUfLp9KjtqDX2jZFXiR5pdMiHxUWLrVHHnGzbpCJc0vsxNUEKFoQnaTzprCru2Q=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4297.namprd10.prod.outlook.com (2603:10b6:5:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:43:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:43:01 +0000
Message-ID: <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
Date:   Mon, 25 Apr 2022 12:42:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
 <20220425185121.GE24825@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220425185121.GE24825@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a27e73-5592-4521-ce8e-08da26f3cedf
X-MS-TrafficTypeDiagnostic: DM6PR10MB4297:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB429747FC1635D98B199DF0DE87F89@DM6PR10MB4297.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF4bX9zuUJMBqvUEVafQ1IdUhSk2ZpcbIw2a1gq/n4Kw8868VGwksu3NcIveFwU1b+SmsDnRYI2PDmoDmGCoAwH+NXRWHfDjqLODAJlC0tbwfM1ARj3hl9qgi2ZOaaliFT9Elv7+YG5e8ioJT4C0HDDnYCO3k/GTxjtMlqd2wI49CYTFXIXzzMeSQ6Ko/XF+1/wt4IZxv2dXLk/zqMYCMe13rUDM4CGjLS6HUE37U8BTenwaklubQVTd3yzikfkPghDAZBP/NEFy9uQ29/xHL0j3GoCUE8Tqn4OQ2trzgKrhm87fPcSfd0lT76EV9a5ILA3jdiU6h7/NOMKaTW2wd0H6jKLcktFn4F3rkm3tnXvvjay25BWXMCLjzAbxiUdzXmQWTG0wdV3Mo1H6DlfUSKR1avpaeiu2JO4ZtjSxMwmcZMTdKk7d9/3BLQtzkkQLVXivgeylxCRC3JZ4dbCfUjd117TyQpfuyRnC4Ul8Z4Ws0RhWFpTkLMF+51V16lrgNmw75OV3QDetMeAVAlZ1ZMrGteIJtp9clXNkrBBsjStINM/kQawUHcYNOmuEKxSYDtQyuL489t3Trskzjy66FEV8+dfgHnqyH5XghaN7I5Api+v5t824O0FoB9m6S4SGCgFrYwABsHFEoAPYLk20tGN7SUC5TZnh0k9+uYWQWsq4YLo8q5QXA4hvLu2OGvsvGyq8IsSed+QSphC3PNLq3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(86362001)(66556008)(8676002)(2616005)(26005)(316002)(6486002)(38100700002)(9686003)(66476007)(6512007)(6916009)(66946007)(6666004)(31696002)(6506007)(4326008)(53546011)(8936002)(5660300002)(36756003)(83380400001)(31686004)(186003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVoRjlFVEdqRTRYK3BzU1RTazBiaGM5VjI3NmJqdEVxbTV2TjVPZW9iRWE0?=
 =?utf-8?B?Y0c0MFJBRGpWMGxOTk5mR2VwZlFnK1FFRzB1WGIvZjlxOGhDY1d3aFJQdlkx?=
 =?utf-8?B?UVYxbXlHa3I1NWx0TDMxaGE1NEtsOENwQWxtZUZ6OVNubjN2TnBKYUZOZi9Z?=
 =?utf-8?B?L2RuZ05zdkV4RkVJNHlpWjIvM24vdEtzRk9SM2ZsNnZnNWsrN1ZqWThEVkVV?=
 =?utf-8?B?UUNWd08wcStob1ZCRW5yUE9PMDRlQkgwOEhwV0pEMi8zRnNBZ1N3UzVmVTkr?=
 =?utf-8?B?Wk9HSTc0eEQ5RWo4RWhoZXFFQTllNFhZcDV2NFNFY2JSd1h0NEF0K3RrTHRM?=
 =?utf-8?B?M0dJWXhTb0s3N0hXTFg1SE1Dd0dUZVpUNWdXbFhlby9YMCtZRmxrNHpSTWRq?=
 =?utf-8?B?YXh3SVVaMnRrMG4vWEFSSSsyb0FVRGcvQm94bnRlSGlrc2ttSTdlbzNNc1Nw?=
 =?utf-8?B?QmJFL01IZWh5RS9IS2FJaDFlMW4xeUZ0Y013VkljQ2R4VmN0cWZFcnN5RVVY?=
 =?utf-8?B?bkZqNEN0aXZsZUV2U0I3MkpHRzM3bGNSRlhDM3ZFbHBLN0xOdGs1d3h5dU9r?=
 =?utf-8?B?QnUwdW82dS9LWDI5SjczSisyb0pSbDhKRWE1N1RySkR4VVBJdjVDdHpMd1A1?=
 =?utf-8?B?YVdZWXM0NWVxQ2p5cEJTM05yRVFHZ0RJejd3TGRmR0tVaW9DS3pNQ1RURW1G?=
 =?utf-8?B?a1c1aWpVTllkK0l4QjJVNkJNWHJCY3YrWWJYYXYxMDdVdFRKbmwvK1dNWkZm?=
 =?utf-8?B?cTVBeDkrUWVnOTRRTUs4RFBldTl2S0Q3OUViektUejdPTkcwOEIzRTBjT3Ux?=
 =?utf-8?B?cGNPZlNMNUFWcWpIQUdROG1QT2prUzZTVXNnbGNZVkFGMVhvbmcxaXlsb0lP?=
 =?utf-8?B?cFduSW5YanBHSGJHSUZKekpveWNGTnFvRk9MMlZTVG56ZmRqdCtxUW94TVdQ?=
 =?utf-8?B?c2N3U1lGWnBQYThtOVhrWDFJeUpjTEprOCtlditEOEtSM3JuRVBhck9yTjF3?=
 =?utf-8?B?cXJEQWlnTGFqRHZ2dTdHMmRPMFhNODRFbVg1MWNSUWh6M0VLUTcvaVBSK080?=
 =?utf-8?B?SkVHTEM4SGpIdjhqZTh5Q3JMSS9qaE1aM1g0Nk1kd2twa0tkTHF0Mm51KzR5?=
 =?utf-8?B?a1NFUHVjMlQrdDREYmFZWXdOVHFUbkF6Z0hMdmdtWm1IRldxeDVNb1FVQWxm?=
 =?utf-8?B?NkgrR0hXNlpBNXFrNUt1Rm5ib0xOYTVRdlg4ZFlvMGJINzAvTHB4SFlnWThL?=
 =?utf-8?B?UFduTGlVQUtLVGc1ZE1EdjBqYnNleGxmM2dBZCtEbkh3dXJnYXVlaWRPWlA3?=
 =?utf-8?B?QUpXK24wQUVxZXJ6OTF0dURLbDlaeFhhcXZLQVJsK0JCSlVSajQvRi9qS0tn?=
 =?utf-8?B?bUNxUTQzNTZGcTVDb1lhQTRobWs3VGhUamw1Uzc3SlRKRmZQQzVDUkhsUGFv?=
 =?utf-8?B?bDZ5TStKQitvLzJldjYvTXllOGFycmFIbS96bGJNbDU5dnRCRWhiLzRqckFt?=
 =?utf-8?B?dkwvUCtGLzNPdC9VVTJUUEt0bysxUmJPdk9OdkFwRzVLZHV2ZmVFZEEwQmxn?=
 =?utf-8?B?OXMvTitvRGQ5dmJyc25nWDhENCtXckxhV3p6OE9RcGNOL1NzdEVpUU5nSjVW?=
 =?utf-8?B?Mm1MQ2x4MUpyOFpRdUFxNytuMklzMnRmVXMrM1ZjM2I1TUpWWkNzbGJqWjlY?=
 =?utf-8?B?M0FzdUkvNHl4WndTSXFFSUZIbW1TZ2Z5anRiTWJ2Q3p2YVFQZGpjdXZMdFFI?=
 =?utf-8?B?NVh0RHI3SFdxOTFXajUva1E3blpiYkVhYkEzUkx5OVYxNnpzRzVieG9wSHly?=
 =?utf-8?B?MTcweUh3cW1qT1JYT1ZMSG95QWthMnhmbldzbGEwcFhmK1hrMFpKMWxlbkQv?=
 =?utf-8?B?MjBMekhHV2hCOGRzQnZRZU5kVktDQUV4dFFaV0xZTGxZOUNPa0JobjFVeGJJ?=
 =?utf-8?B?Y2xBZ2V6c1cyd0dIYTFQVlNTbHZsSW9yZy90ZzF3R2p1ZE9kTTROTW16Qmp5?=
 =?utf-8?B?N3lXOVpQcUU3ek9nY09SV3krTk53M3RNUzBHcXlkL3BLUHFSbVlvSFl2OEkw?=
 =?utf-8?B?MG5uSERPN3RLV2Z0bnZNL1R4alRUdUN5ZnI3U1JxbEhJU0I3SHVXRUErbUhX?=
 =?utf-8?B?QkVRaUNtdHh6VnlVVVNXQzhXdFY1UjhOUkdPaW1OSzNxdUM4UWlMSjdZb25B?=
 =?utf-8?B?TGJkdEY5ejdqWFZYYTgrc0dOOXAxTk9hMENjSnllcXJYMDN2elk2YXpzMjhE?=
 =?utf-8?B?Yy9tYnFybVR4R3RFU1NMV1JaUHdlK2t2cVBCVlUyNXQrbHBQSE9nWEZBT255?=
 =?utf-8?B?UVNOSTYvaTdzOFdvT21YdFlIMExCVWJ3TDJ0WXNiR08wWjd2ZGxMZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a27e73-5592-4521-ce8e-08da26f3cedf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:43:01.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imp//B0R0DAaZXDxPDgd2RJAcvEm4XBfkV5Mt3BhXyHFRl7kIxLudXRVeF9GlZvcMk2Ir5UtpxXT+UOtCchf8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4297
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250087
X-Proofpoint-ORIG-GUID: dgX0244uoiJQS_vEYcm0rhdQYs6oV-3N
X-Proofpoint-GUID: dgX0244uoiJQS_vEYcm0rhdQYs6oV-3N
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 11:51 AM, J. Bruce Fields wrote:
> On Sat, Apr 23, 2022 at 11:44:09AM -0700, Dai Ngo wrote:
>> This patch provides courteous server support for delegation only.
>> Only expired client with delegation but no conflict and no open
>> or lock state is allowed to be in COURTESY state.
>>
>> Delegation conflict with COURTESY client is resolved by setting it
>> to EXPIRABLE, queue work for the laundromat and return delay to
>> caller. Conflict is resolved when the laudromat runs and expires
>> the EXIRABLE client while the NFS client retries the OPEN request.
>> Local thread request that gets conflict is doing the retry in
>> __break_lease.
>>
>> Client in COURTESY state is allowed to reconnect and continues to
>> have access to its state while client in EXPIRABLE state is not.
>> To prevent 2 clients with the same name are on the conf_name_tree,
>> nfsd4_setclientid is modified to expire confirmed client in EXPIRABLE
>> state.
>>
>> The spinlock cl_cs_lock is used to handle race conditions between
>> conflict resolver, nfsd_break_deleg_cb, and the COURTESY client
>> doing reconnect.
>>
>> find_in_sessionid_hashtbl, find_confirmed_client_by_name and
>> find_confirmed_client are modified to activate COURTESY client by
>> setting it to ACTIVE state and skip client in EXPIRABLE state.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-------
>>   fs/nfsd/nfsd.h      |   1 +
>>   fs/nfsd/state.h     |  63 +++++++++++++++++++++++++
>>   3 files changed, 177 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..fea5e24e7d94 100644
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
>> @@ -690,6 +692,14 @@ static unsigned int file_hashval(struct svc_fh *fh)
>>   
>>   static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>>   
>> +static inline void
>> +run_laundromat(struct nfsd_net *nn, bool wait)
>> +{
>> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	if (wait)
>> +		flush_workqueue(laundry_wq);
>> +}
> Let's keep those two things separate.  The "wait" argument isn't
> self-documenting when reading the calling code.

we can use enum to spell out the intention.

>    And the
> mod_delayed_work call isn't always needed before flush_workqueue.

ok. I'll keep them separate.

>
>> +
>>   static void
>>   __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>>   {
>> @@ -1939,6 +1949,11 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>   	session = __find_in_sessionid_hashtbl(sessionid, net);
>>   	if (!session)
>>   		goto out;
>> +	if (!try_to_activate_client(session->se_client)) {
>> +		/* client is EXPIRABLE */
>> +		session = NULL;
>> +		goto out;
> No, we definitely don't want to do this.  As I said before, an
> "expirable client" should be treated in every way exactly like any
> regular active client.  Literally the only difference is that the
> laundromat can try to expire it.

Do you mean leave the state as EXPIRABLE but allow the callers
to use the client as an ACTIVE client:

static inline bool try_to_expire_client(struct nfs4_client *clp)
{
         bool ret;

         spin_lock(&clp->cl_cs_lock);
         if (clp->cl_state == NFSD4_EXPIRABLE) {
                 spin_unlock(&clp->cl_cs_lock);
                 return false;            <<<====== was true
         }
         ret = NFSD4_COURTESY ==
                 cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
         spin_unlock(&clp->cl_cs_lock);
         return ret;
}

-Dai

>
> And then all this code becomes unnecessary:
>
>> @@ -702,4 +727,42 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>   
>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>> +{
>> +	bool ret;
>> +
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (clp->cl_state == NFSD4_EXPIRABLE) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	ret = NFSD4_COURTESY ==
>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return ret;
>> +}
>> +
>> +static inline bool try_to_activate_client(struct nfs4_client *clp)
>> +{
>> +	bool ret;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	/* sync with laundromat */
>> +	lockdep_assert_held(&nn->client_lock);
>> +
>> +	/* sync with try_to_expire_client */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (clp->cl_state == NFSD4_ACTIVE) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (clp->cl_state == NFSD4_EXPIRABLE) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return false;
>> +	}
>> +	ret = NFSD4_COURTESY ==
>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_ACTIVE);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return ret;
>> +}
> --b.
