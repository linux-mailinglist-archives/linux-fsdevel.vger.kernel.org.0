Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203851223C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiD0TRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiD0TRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:17:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689365B3E1;
        Wed, 27 Apr 2022 12:10:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RHh3cm011361;
        Wed, 27 Apr 2022 19:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jvT77X20Fm/t81+K1TQnTOve5ja/cSbJR5Ic+zDrf60=;
 b=rMAuUq48iJ3tG7VbENhkQI0Zebkr09pbwf9alke2mjW6Y9MwOUkem8ugWQ/LQwx9lAzj
 cmR6Be5HPXDo+PfDjYhw8K/MHCBRSH1shfXk5frAR55Qea9Te156/3bYAVZsz8KpeJL2
 9bxI1M0LraQLNHzWNdXoOb/GXjBYpVH9xAo216X56l1WNt04C1udFvZ7ws1qS0dPcijo
 KNjG2ieLnNEoB4mjO1rQsxdjtvik7ytBvdGHfB1ZEPFonV808wHhJd7ytR3/aPojumrr
 r9i3jZjq5r59Q3cNRkPYXPTI1MEkRzKLxbM7vZPQbDLoKkV1IJLT1258Tzd+q1L9Gacy hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4j3nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 19:10:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RJ0fk8025134;
        Wed, 27 Apr 2022 19:10:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymhq3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 19:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5SZpLviMBY9bdlDce0NieXOaRCP/zIi6nQsE8sfb88KZ00VONvLZH+y8sb3zs0lWciUZnEjmf8eywfEXtTR0AW5oy+4xTfhchU4xcPh7o5fLI2sJV9UpPPyH223IQq4UQeCTKXPA0CyCKSu7QLC0Ed9qjbeuB6l3pATajU39BCKv4CVI1PEsH03DHgx8S41FSGGgmJQE3er002E7vGb11iWtEFNbG458hPXZXGqUODvbP3IuoZ+Tt7TE39tNvdaVbN0ASBeXR612qcF64Fxf3b7+rSV5kM+K+eqcxVFqnQJDbVKecEEXeYBZ8KouwWLC1bFQQYHsEgb1MEWS8psPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvT77X20Fm/t81+K1TQnTOve5ja/cSbJR5Ic+zDrf60=;
 b=dnimkevM0sO45r3yki8DjwhZp7hcNhdM+76kdfxWoOjXlEYEK49+Y/ycwKyGFn2zRmOz7XgvoNXFZDSxKLY3Cmdp1wuUo6spEF6vo0rBxmAsASUc2Ck9koswU7eAH6wfwb71odO51q2dPPn9HXuRDswxzr+I7xO6OPruL0ACHAOIgEHw+VbK4OIsxI1iRkjpTGGnflbRJl+gNSQrl9KxAwRcs6nbst55S5utvDr9bZmQkqQRuflznw6LmUM3meuEjpdO5fijYmOls7tdEh0Zz7woaQHuqIGGw2CgiF5kfF40hfX61tN3icgy3Z7SST5ivNSyRhCiNFjWfhSpfmHEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvT77X20Fm/t81+K1TQnTOve5ja/cSbJR5Ic+zDrf60=;
 b=KhbhDPh/lmCch0kmae7XmW5H/IrkP9yqp8x3PLIfKpqFqM54vlbPOiPD8/tgX6kXa8JAFZGJltqU7x/kjlUgE5JKA+XKWbsssulSwDc5gxpNBlxr87C01484K0piGv9z1nC6wlFu3hL50LFuf2gvNfbFIFPqX7mtKf7Knsc9CTI=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MN2PR10MB3359.namprd10.prod.outlook.com (2603:10b6:208:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 19:10:02 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 19:10:01 +0000
Message-ID: <75276a04-53b2-4033-d07e-3b5eb210f9eb@oracle.com>
Date:   Wed, 27 Apr 2022 12:09:58 -0700
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
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453e60b1-ba84-41ff-8876-08da2881879a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3359D078E17CE857A090589787FA9@MN2PR10MB3359.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmhYTnhX5vUw2Y6QDOgOMZ1pFFnVO/Dd5SJxvvus1DCLArVgPuJIeazVHBl0CF/k4QJqUcYCyDqAKrvUNDL47ZibjnGJjPP+MAEosh4a4NIj+JPEyipBlbucNnFlanIbkFDUdLoZE5PJ93Jqov4TfTxnQtafgYMyFDvf2NVYixeoAs3LeuZ2uKLeJQcC2aksp+Myg3mnJWlIMAos2dvSkDNjvdorpsaZx45+r2XXZGYhL41T0P9Knj2Hof1+CvS3RACGFiDW4y62umbWhfJNCdIlllCtJlIoXI1iqkuh9aGwp05NuObZv54bXyxq+ki4YrTyjOrHq8JU0Wgxi4YWgjsLYHaFir9kxtDu+/YjJDBn+gGMVhopqHFIdJDJBAvr7CZtG5SO0JXAhSLQ2DthZUXpNNEnypkuWeXGozfQiZRh//1caF02tXf2Lkz9vlUvMY2OX0RzbgAiqSrIku+v9Y2dhjHoBVxmN2Kiau48L8M11MZEZDqerRSAYSefnnaIKzZWl6FUmbGBcxL0Ygfnc4//ai/Rx/k18IjEG6Cc6zf4YRQMK6Ezm4jQjVRzTF3k3dBERqyw9VdXObtaLdEHGVsqzIIDKEIfuiD+X0x9DyXhbzOjE/YDoBzJJ7cMZSBeXVcRfMWOhNMtGci4GTSbvp4CrhUYq7sQB/6tcy+GEakLWh7oRqXmq4y5PeSVeF0TGl81FPi0M56P3lhMyyWvPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(36756003)(66946007)(5660300002)(53546011)(316002)(6916009)(2906002)(6486002)(508600001)(8676002)(83380400001)(26005)(86362001)(31686004)(6506007)(6512007)(6666004)(9686003)(8936002)(66556008)(4326008)(66476007)(186003)(31696002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0NDdE1uVnlhNTRYTWJOL2lyQi9aVzZIS0RPQjUzam5SK05SM1dzemNVQ0pN?=
 =?utf-8?B?ZS9nY0VFT2RBb0dBQWtHVEtIOEx0VjlrUGF3a1pxVzdrd1Y0NVBEZ3I0TFFq?=
 =?utf-8?B?aWYzWUl4UW4zS2hvWUxDSWljZFI0eGxVbzFaNGFreXV6eGovcmxYNllEb3B1?=
 =?utf-8?B?encwM2NlTzlNb0RUSjZnY3A5dVMzU2t4ZGEvVU8rZHE3Qjgwa0J0NlRDTUR2?=
 =?utf-8?B?TmVpZkNaWmRtZ21aWmpOd2xQWG5mZ2RsMnF3LzliVWF5Y2xGWnNnNnM2Qm4w?=
 =?utf-8?B?OFM1eENkNXUwWXFqdW4wZnFQTEkzMWIvMGNIbVdNSnlJTG82OTA4aUpycEJX?=
 =?utf-8?B?K2FlMnBPbnlLdysyTmtCWC9jSUlNZ09rKzl6RHNJUGgrZ1BrUzZTdEw4Z1Y2?=
 =?utf-8?B?d3FmM1NqMHdDNUcrTEFHNVczUWlFeGU4WGQzUEFCNWJYTWpIT3Q5UGk5M3Zv?=
 =?utf-8?B?K2QvZUR1cG9aREluTzBibDhkd2VMbEVBb2RjSXFQOHd2UW1WQ3NsNHUrRkZu?=
 =?utf-8?B?ZWFxSTZWZzlDbUxHWTFWck9RREFDNUx6Mm5pZFovcnBSQS9pTm1iWE8rTWZh?=
 =?utf-8?B?Tlh2TmVYS0g5eGJBemlSUVdQaDh6VEQ5bE1mVzBFUjk1TVJpL2t1bWhvQ05w?=
 =?utf-8?B?ZXlJZUxLSHlrNE5HZ3Fpdk82OVgvcUlQOVczTFp0Rk1UZituZ2NOczdkOGlv?=
 =?utf-8?B?bFJBVnJMMjF3V3RsMkxWc2h3VFdBajVjNmx2NzYrVXErZVE4Qjg5UXlzUyto?=
 =?utf-8?B?WHdkWlZOUmRMc01TSmZxa1YyZzV6Wi9rNWE2bDJ2SUlWbnRLZlVWWWtMZzN6?=
 =?utf-8?B?eStxM25qSnVMT0VCbVlrK3dpU0dsa3FqRmI3Vm1RSENuRWFwN3Z3K2NUSXM5?=
 =?utf-8?B?cFg5MlpGV1FOdk52bkNodkljWHpYTGJmUEY2QUNHWkJmYmFCY2lSU1piWTIw?=
 =?utf-8?B?WC9VUzRGNGNaSFgyODhETHRIR1RJakZqcFRDRXJDOGJteXlySnhQcG9zMGtn?=
 =?utf-8?B?d1IwcVJkb1NWaWhMU2VodHFUeFRQeldORVhwNzREM2xNV0NtNTUvMGlzaVVo?=
 =?utf-8?B?ckRJZXdUbnBJS3l1TmdUY0Nwa1p6cjluTWd1b0VVTG0rTlBjVXVmY0hZemU5?=
 =?utf-8?B?bzhhamRxZElxVkxBNGswYkE3Zk4xeEhFdnNHQ3V1Slo3UUJGejA1ZHlkTUtB?=
 =?utf-8?B?LzJpd2pSdGFic0RuNDMyY0hLZGVFS09pRDFCVjBIYkFQVzI4Y05UeTZHak54?=
 =?utf-8?B?MzJFTmduWnBzWnMzVnlZWHRQelNHWklFSnRHcnIxMW5nZ0c3VHAwcnZjZytZ?=
 =?utf-8?B?NzF6Nk1PbGRoNUUwTDM4and6cUNkWGJ3Rmh5WWhsZFl5b0pWa29TOUlsOVBp?=
 =?utf-8?B?QzlRc0RJWmtPWnRSNHBTU1NSb1hTY3FKWlVTRHVmRmZlcHBDK29qNy9kOHIr?=
 =?utf-8?B?MW5neXdnYVZjTkJWeGxkZHZPSzFTaDBiS3VnbWc2ajNyNjhFdXpBVUU4WlVF?=
 =?utf-8?B?VzBHNnhpZTBBR2JvNjBROWVKY2tWdjRhR2pKVkx6bVdUV1RQZkJxMkoycmsw?=
 =?utf-8?B?VFNLSmtZMmJBUUNsL1BWRXBpQm1rMkYzRDJmMzFaL21kZUNyKzNSWWZUSXVR?=
 =?utf-8?B?TXF1c0h0V2xHUzlRV0JicS8vUkNKK21rQnhXRHh4SklTSkhkL1U2OUZlKzVq?=
 =?utf-8?B?U1NoNWR4bzkzY1VRY2RkUUhaeXVYcWQzUGhWRlJ2SnB6TUFCaWdmYW9BUzRl?=
 =?utf-8?B?YTRwNExVWWp5UjY0TlQ1bHFRTk5iR2MxTldkbllTeG1zUlF6ZlcyN3N3WVc1?=
 =?utf-8?B?K3RJZzJqblhZY3pFWDlIYThPKzBkbUlsSTByd3k3UWppUUk0MU43TWR6azhO?=
 =?utf-8?B?UE9MR1hBM2F5L0FqSzNBVktoekxkNjRQakRtSzZYMHpOZ0cyZ1FOZzJkWU9l?=
 =?utf-8?B?TGgyY1pKekxGRTFLbnNWWEpqU04xZkdFMFVLZVh6dklWTzlFM3FGSXJMQlFQ?=
 =?utf-8?B?c0ZxVzRtRDB2UVRoMGFXQXlkamxXTnJlUk9HeUdqMlNwaVR4cEgvUk5xWjFS?=
 =?utf-8?B?WkFrVklZYVZ1bTFKZ0ZJL0FHK1pQWHJSQ2lZWlNZWVVlUjNIZ1RjY1VUZkdr?=
 =?utf-8?B?SVFTU2NrWEliUHJMWGl0MXJRY2F2TmpLL1pCeDYzL0NhVyt3a2hHN0kvSklG?=
 =?utf-8?B?V3R5OVZreDNjU21HM3ZtbXAwaGoyVkphT2ZMTTdOTVExcGRwVldJUXU1SWIz?=
 =?utf-8?B?QjYxUUM1a3BiSnZ4ZHplRnVmaXNGelM3WWNKSEs2WExsM3g2bGtXSU55NHJB?=
 =?utf-8?B?czd2WWVvTThhWEhZNWQ2NWJzZUNaQjFyV3daam90UmJnYkZSMmJxUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453e60b1-ba84-41ff-8876-08da2881879a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 19:10:01.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gBkX4qyBprtcq206PJRS4t5QqG/70wRSB1ycO/N6TZfyccOxJH/gWGYZFXPnhbPU1xCW6fe4fhbBbG5BCCp9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3359
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270119
X-Proofpoint-GUID: 5Vh1lrp_2MuLkJeVjk2vPgKiRh81cIV1
X-Proofpoint-ORIG-GUID: 5Vh1lrp_2MuLkJeVjk2vPgKiRh81cIV1
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

I added this for the case when the 4.0 COURTESY/EXPIRABLE client
reconnects. The client needs to be restored back ACTIVE state and
the RENEW is usually comes in first. Without this, the client
continues to be in COURTESY/EXPIRABLE state.

-Dai

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
>
> --b.
