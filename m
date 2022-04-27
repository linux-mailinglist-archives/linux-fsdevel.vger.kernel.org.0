Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E374511E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbiD0Qoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbiD0Qoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:44:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F9767D32;
        Wed, 27 Apr 2022 09:41:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RG4gMP003693;
        Wed, 27 Apr 2022 16:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+oHsOjBVNMpFmOfUe19VsacZd/7Sa6PhZkWE5qGwKJ4=;
 b=yk9hCVoXuWduvGgwWVhETUvgBEU6gjWQdj8BtgU6L1YeFnMYEt2s0Spj12A01eeZSwYM
 D2zssaB2UlVFh36K8CaXgfi+EQykBQn+CwBu4q7uyZ1C1N3Lz2fcFHAKPKh2NM2J6C6E
 kdSD8u3U3JW9LTKsk+au8iWHMttasp17SqzADmxN0DyHLwLUMIPEZpr386iT0G490M9j
 kPBUqc/sZtvXgvQxWaMbTX9DVJuRMjdMQqgRuMuxNE34FXicRTo4wi+SwspLR03+eVX2
 T9VgT39uEL4K/3DEba5lgPBotIam97zFSEoBQnEdQqraZ7RUracc3Pvn3mpxoIM5DQuL mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4s9pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:41:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RGf9al024802;
        Wed, 27 Apr 2022 16:41:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w53sq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXlxnyTTz+pE7Z6H6Os+64jBm7a+yuptuk1rFU+H2o1fxyTGpNy54wOv4JIPpKBVhwRbS8mV/+APeEEIWSQlFU6UkSf51phBRnxWTrPO20Cji03tQH3f5Mwhev68+bMJPWHgyRsP3JGuofgliHU+6aaKqJHmrDw8NYiw8eiTtiH14isikbEhGT2E//ql2gimwfR89YTYmnjsJhSSqZ/QFJoIR6bfDrLwVkf6i83xMFlZukzIsh6xNNOQQgLzzuPZuLpeCJ3bh7/bZ9VWSbvzyGILRi/0OBBGPShIreKx/ITu5ViLcv3psLLmfJiclxZNJ/Bzoao/4/Xgwwqicpl8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oHsOjBVNMpFmOfUe19VsacZd/7Sa6PhZkWE5qGwKJ4=;
 b=GlenxuiX9KXzlacEhtr3C+5BCYrEtSi4VWXzcOURt8cPfXc142qoBi7WlEUXGGlWhpH6ULVGNjavPCZliXrizhMdmIaHqh3sa3jVDNFAwrHFoySlTmhzVlfRSD4dKK5ufkw5lrUe7yeyIb93FRHUwxh/0ZzJQZCFbrLFQCpaCLfUhXGxqr3/JxA3id5FLl+vR0U4QhgQy427OFwkUo4g+nM8bFkyNWH3B7frx1IWWEU9qTWjO9HCbDXaobD2vgvrSSVFe2EoTHYvyHMpT4uPrgLZ+RZLN4dlGdbMupZ57nb2H3DNbVWBlYYX4AzixirRBnvxb05p7/Yp4ZXWzWQBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oHsOjBVNMpFmOfUe19VsacZd/7Sa6PhZkWE5qGwKJ4=;
 b=J+8p7EO0LUE/RBTA2L56SAK+ru8nHchYzzOBdmfBsbCtv5vHT8AubT9h3zZBVgomqeavB2O+9pgdtM2tqlvZ9E4gPxM3EsnyXgvoHjjRtSaN4SnnLpZa+8lHXeRdvZMsTyWnNVj3b3MhfsxoYNX2gywhoyOziNfBcyiw2lTeV34=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 16:41:20 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:41:20 +0000
Message-ID: <a06066fe-4fbf-0fcc-3ae8-107fd1c45183@oracle.com>
Date:   Wed, 27 Apr 2022 09:41:16 -0700
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
 <20220427161221.GD13471@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220427161221.GD13471@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74faf6ff-13af-4cf8-675e-08da286cc197
X-MS-TrafficTypeDiagnostic: CO1PR10MB4673:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4673BA9EBD8B150B3BB64BBD87FA9@CO1PR10MB4673.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/vfFLXPmcy3/Uau5pgArF+j+IsrtalNYU2Hf8V6jwu7CtDvDsQ5/lqydiOstzULqoXlmzsO45d6rHk1CcgxzcBEYpZXpuXzxA/TyFyk5wgkDU/ZZPGFl0lr/l/DtzwvUq0zHThBodgbJsw5M9yCjani/5LUnzBsKw2zNKLwmUdZNEJCdVUIwvdC5ehlHcyD1k5cGQM18gs4y/Y4sCG/mAsv/QVpete+vCvu9BZszxrhMg1Nm13zcnXWkp9CoG+cb7V+kXeK/gb6nPwUAZwOdaCGJkyANJxO4+weOz5f1fDZRyj6FoKLY24xupbNreTRIikm54wwn7LmWR0Jj6l6FLEjH3jA7k8WpvMRdvjDZThr9Xy6ksFn0FV0q7FogZTlD8GRksDCXUBUZ4sJ+wOEof2m4ApUwEjMGzk87JWB8S1Sv22/fjpa8xBlWF3QPW+kWN87GuCKAaWDpSZ/ICsCUPNTdYbxvkESFT0Zfe+wIRmV1slyQ2RY2im1IVkOSzMmao3derOviigB51Rxb54BM5UUoU3ge0J4A0I1IKBts1UGoKVP/P5TBGcJcSMJOpFthOD7g71UtGnHX2ADP+rdzNWMRdWXJgw4Wtn3yTjch/BUcuYuG0JjIjFy74ByW+BxwHT8raHplumOanaSLsQQRjiE9GQEOe301TLN7/o7/BFHSitKLpzwEz+M9mJzxiIBqoNdfkiGghJ+uQAxhdG+Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(4326008)(508600001)(6486002)(66476007)(66946007)(66556008)(8676002)(38100700002)(31686004)(6916009)(83380400001)(36756003)(316002)(86362001)(186003)(2906002)(2616005)(5660300002)(6512007)(31696002)(53546011)(6506007)(9686003)(6666004)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtHV0o0ZXgxZGJoa0lIcFE5Rm12UW9ObGJVQ09uU05wUEJOT3p4RXdOMWtk?=
 =?utf-8?B?TzArRnNMdjl5MW5ITzFLdE00RHZselI0TnRvaHhDZU5HL2hrWTZ1aEJBVHA5?=
 =?utf-8?B?OVIxYWR3b1ZNRlhBOUgvblRQYk5mK2k1dWFKR3lmNmtCZXhzWGpOME5RRnVJ?=
 =?utf-8?B?WGtvenRFV2lvRUh5dFdrRVZVV2FBSzlncVU2QXFhbmR6YUdHWUVXNUx4ZEU3?=
 =?utf-8?B?K0g0QitSOUdtRkVObjk0OUhDWW1ZS1lKZlZJSzdqRkkyd0VueDFGVVBSaU9r?=
 =?utf-8?B?SlJYUmZ5ZG1MdTZNWkpKT3p5bnFOSzRqYWk4YVZLWVdDc2ZJS01oQThQTVhM?=
 =?utf-8?B?Q3c1cENYMGdVSW5aM203MkJRV1lrYmxMeUZpUXp6dTdzNldScmM5UGxHbXNM?=
 =?utf-8?B?WEpLSmQyMkxpZ3UwdjJ6TXdkUWhpaGxGZi82Ykx0NlFmMUlWc3lDWXA3cTZS?=
 =?utf-8?B?ODgyR1Z6WityMmU3ck1FNno3MnBBTCt0eE5RZTNuRXBVR1NScWQ5RWJ2MWR5?=
 =?utf-8?B?c0pDcUFTV09KVXArSCtlTnBzQnhTcExTYXYrSGRUQ0VydElKZ1JLSDlFTkZ6?=
 =?utf-8?B?VFVDVUJyTzQ5bXlBK21vMkRTWEE1Z2RCM2RXa1RyV0x5ZHE4OHh6YTBMaFlJ?=
 =?utf-8?B?aDJHSEpldGtDc3dJbUpYYTQyMjFUQ3Q0bU4xTHJQUUNpTDk4djV6SDBDTXE4?=
 =?utf-8?B?WGY2Uy9QcTBkak8wS1NMa2hlWThhUTBkNG4rTVk2b0pXbXBSQTlCVVBVWk1k?=
 =?utf-8?B?amdJMXk1SGt3bFB5R2RwN3RpU3B2Ky9ZbjlCQ24yeUZUaGVIRXE4dzNpaG5i?=
 =?utf-8?B?dlVWZGNrcG4zSzFZNEF2MndrTTR6YjJtQzhQNm5vaWFjaTI1S2hwR1VsQ1ds?=
 =?utf-8?B?ZU1QM0F2U3RneldhYmQvdlFQelI3c3dsd0RnazZDa1UvczhPcjRGamE1N0xZ?=
 =?utf-8?B?cXZmZjdTRlltSWNCK2RaUFVmSmlLeEdSUDNTemk1dys5R2hvUkJ6RjdGNTdl?=
 =?utf-8?B?YjVma0dQZEhDU2JTUXZLeUhCb2ZnQXVqaStJbWtOZUk1aUhyWFZRM1I0dklC?=
 =?utf-8?B?VDJMdzYvWEU3b09kdWJESHRzM3Z1NEt4MVM2bXRIY1p6YXNRRHk2b2tqck40?=
 =?utf-8?B?RElvOU44RXVXcHZmb0JDNVRDTnNMRFB0QWFUWnFBeE1OaWxScVdseFJiQ0lz?=
 =?utf-8?B?clhydERCb09RUzB2MTBxMHpURCs1UVl3RnMyRWRpZGIrWm1vVUlxT3U2V3NG?=
 =?utf-8?B?OFFJTnJZU1MzTG5JLzMvVkhweXBWeVIrZnhsSlh2MTMvVkhMMWsxdjZ5RTAx?=
 =?utf-8?B?ZzFXR3ZwOEFmUGdVcEFBNFFveDNwUzNSc29hWjJnbkhCQldnTVBmY0J2NUU1?=
 =?utf-8?B?MWZhQ3FhT3lGcVZrRzAxUnhvaXJQemFyTm0vNDZnL0pHQlZyQ1Y1enVCQVRo?=
 =?utf-8?B?NENuV091L1pnMURXOHF6TXowVFR1RE1leGlYMThrdUk1OTZKc0JncmZhZTF5?=
 =?utf-8?B?aHRUb1JVekhVV2pYSDF3NHR5QkY5RnMzLzdiVndzekZRRVBiRXh2cDdwRHJY?=
 =?utf-8?B?TUlkUWxTRStnTCtad1BXWnJIR0J3Wkg0MHIvbjk2dFFxM05GK2ZucmcxZkJ5?=
 =?utf-8?B?U0NEQ0Q5Q1UxUThmWHptVUozVDZ5OE8xK0FiTjhOOUxzeTJLM1hFaGNrZWlI?=
 =?utf-8?B?RE1COVVOZURRSUpCbVhPaEt3U3I4QnhHU3A2ZFBjWDZmVWZrZCtFVjkyZUFy?=
 =?utf-8?B?Ny9kaG5wNHV4Mi9UQzVtNUpYY0tLdmU0UTdKZEZ2Mm4vT1l2Mm1aak45YVJl?=
 =?utf-8?B?aVllNGNmRVhTT3h3MkppNHlCeUROQ25pSDJCWWRGbGpzZ1NlN2xSM1VnMjd2?=
 =?utf-8?B?UkpmMjhlbkZtY2JRRXJZRXZOUnA4NDlRS1lVeXpKcGJGR3d2RFRSdmZ5ZXlY?=
 =?utf-8?B?cUlxVDdoY0tWbTZnWVQrZFRScXQyYmR3TkpOZVF2MU50VHErcWlDaW8vcjZk?=
 =?utf-8?B?eUxRaG9Ic1Q0cFRWWTc0SnIyVHlORUtSZ2hscURMY2hPV29zWlRVa011MW5Q?=
 =?utf-8?B?Snc3Ull6R0l1UThQQUhLYkJhMUtzUmpDc3o4Y0JHcy85ZnpvSkFYV2YyQXZo?=
 =?utf-8?B?UEFCRXgyRDdIZHhhc0ZuSWlXdVVsK2lnd2pWZHI1U1NTS282Y3FLSWsvV0RP?=
 =?utf-8?B?Y0h0MmVvUHNmeWs4UXZGTGNFSmg1cjhUbU1SREhQeEh6Ukh1dGd3Wk5JSVc1?=
 =?utf-8?B?QzZrSU9LUTF3ZE0yUEY0SktCTFoyRWhHZk9WTUVUZExGdHZRUGY0eGpyaDRV?=
 =?utf-8?B?OUVWaHNZd2dOT1YwbDB6U0o3THl1R0FsY0pGWWlZY2NNU3FpS2Vkdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74faf6ff-13af-4cf8-675e-08da286cc197
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 16:41:20.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rTAqoi4Awq34osKqOvcktoQgAuZ2KUaIaz0KwoFbIrIDqOU8KUysduSDSVhVDzvCAQwxiayTYX2Htz4U0p3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4673
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270104
X-Proofpoint-ORIG-GUID: BrAYWgKRfkk_m164NbmwwQQxgOuH2J70
X-Proofpoint-GUID: BrAYWgKRfkk_m164NbmwwQQxgOuH2J70
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 9:12 AM, J. Bruce Fields wrote:
> On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
>> +	if (!try_to_expire_client(clp)) {
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	}
> ...
>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>> +{
>> +	bool ret;
>> +
>> +	ret = NFSD4_ACTIVE ==
>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>> +	return ret;
>> +}
> Hm, this feels a little backwards to me.

yes, I should have renamed the function to something like 'is_client_active()'.

>    I'd expect
> "try_to_expire_client" to return true on success.  Maybe call it
> "client_is_expirable()" to make that clear?  Or stick with
> "try_to_expire_client and make it return 0/-EAGAIN.
>
> If "NFSD4_ACTIVE != cmpxchg(...)" is too confusing, I don't think we
> really even need the atomic return of the previous value, I think it
> would be OK just to do:
>
> 	cmpschg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> 	return clp->cl_state == NFSD4_EXPIRABLE;

I'll change to this:

static inline bool try_to_expire_client(struct nfs4_client *clp)
{
         bool ret;
	
	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
	return clp->cl_state == NFSD4_EXPIRABLE;

}

and its caller:

	if (try_to_expire_client(clp)) {
		nn = net_generic(clp->net, nfsd_net_id);
		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
	}

-Dai

>
> --b.
