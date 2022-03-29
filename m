Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49834EB346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiC2SVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiC2SVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:21:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92B181B38;
        Tue, 29 Mar 2022 11:20:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22THsCMY029560;
        Tue, 29 Mar 2022 18:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OtTL1+5Gh/SFsxarMTg3z9TgbapHmqHFNJg8eVdwG5Y=;
 b=WRPmXZI2xPmruuAaYEFz5gfRtfuXY4Ix/2wxocm3/L1JhcdjbH6FFIsPrCPuuPyYYmX3
 JiErZtNQqI3p/7GY3cyIR44kchx78Vdq2AfvJkGcYAFKtJrSqNcD56Xkx3wCJHtO9gnV
 StJ4MhM6GK6DC2JYk0dL7XTKnci2T062KeRrLaV1VomN9U6wQKTNkZkGwM7XjoSdiGWf
 qtxaUIrGwIL2OfEpijfi0wGHQZYPbmCWsLVXTyZs/0+tJaOii4qCtUhYKKbPvkzc8gx3
 KUQ1klsbzXilzWX0sGq9QO+mWIb5hlHb0dTTSzjdcSwDoz/mlOYaXQd8RY+vAqnjpAKj cA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0febn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 18:19:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22THugKk157038;
        Tue, 29 Mar 2022 18:19:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3f1rv8dfgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 18:19:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1fg4cKE9weybNakG92cnCKBubZ6lLbO6zww890gP+kUVmcKGRRGopYijSXYEthBZzOqvkxIgX/Kr7PAmzcVmayGTl5pIbiF9Aa/RfgT6w8J+p5OCkTRdDet+3JsrZUZDuqQZMVhXHEAg6UgORMTx6oiaUS1DM/F6OUliNrf3D4c3cPVtdVK2X1wg5sgC73wWiI4iiRgMWMNQ/wfFgWRqB4y76SkRHP/faMtJQ1pwoXDdZVhF7W4WmQtnf2O939jBharYvpelMbtJ5R1piqrMCi00cAdyNiljcOSA2vYSTaeJ0O5hyG2HKSMQpUASXCj4rkXlYNXuR9/ykefmUm/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtTL1+5Gh/SFsxarMTg3z9TgbapHmqHFNJg8eVdwG5Y=;
 b=W/SZtJVnm3v8C7f304GeNWWXjvu0rs/OThF6psUQ8ilamN7dBzKnXv7ATRyqSnSgQlPlYgSdbJyQIHQYdfQnN8anGujeN/NxtCnxWJTmRSYozmBjbYmYCzUJ/r106BO6s+NV+D1wAckuBDJKLhenpTefpC8bCq0tcH4bzSFD//W7k1TMVYzW3QmUQZ+vIaKOhGvUxL214bC162KBovxQu0qGMCTpG7wHaPWrHCyWAO9qWJ7I221l6tF2mQUxV/gZAxyec4hgMLhvNZDmNI9zDFmLunIFqYrjHojF1AsKbrmhOdWWID5hgeTuKw52Ffadi/QA9Wp/C6+/Rd5QPWqoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtTL1+5Gh/SFsxarMTg3z9TgbapHmqHFNJg8eVdwG5Y=;
 b=wOv08sDlOROS5+olW2uOBFWxCrp5bzmZMuHP7IXMejQi0tBi0LXILFnJq78SvRGt4MDCGodwCQVAJY3Nk6kkcf1hCTTR0s3bCOnOf7wiThZCEvIwSPyWw+1BjVa+XX/AgML0sEIWNK9mop8QX9IQ+ncxYVW0nGMEIndR2xUrVoQ=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by BL0PR10MB3028.namprd10.prod.outlook.com (2603:10b6:208:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 18:19:55 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 18:19:55 +0000
Message-ID: <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
Date:   Tue, 29 Mar 2022 11:19:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220329163011.GG29634@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9312cc78-286b-414b-8f96-08da11b0b975
X-MS-TrafficTypeDiagnostic: BL0PR10MB3028:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB302878AC653D84E424FDEB16871E9@BL0PR10MB3028.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpAl08aGecWg2bKIE50vLsqsdR/ZGCfJnZSUgmUJSuRlpg53eU6PP/wYyb+9PFzk2vAwLiur23lGGMrnMATyYOpi4st/eDFAJB2tZR9GxXDlJ70ABkdVUF06c9ZP38/hVXBXCw6CZ0pbDqLkoObYtSqPAsuQl/HptXj1G1EntVvQ9ug+9XozfvvCTuYNYYUs41iw85ZXDXC0kYeB14TPD4gnys2hMq6uerHupbGuEiAW9gzwmJv7zvTs/fH855CmpKIl4nTnFOKEC4qIAfYsZ/yRJgBR1GcD5K5PBZREE5O7bO1IyVBGtwCS759Sqk/jPB3ocUHdLygy15ztNVnXx1cF8T93luHWr94cdl+QF3UJdYWJSsrwVRYXILh2JUn9CFHBQnFIEj+H7MtXdUfaJ2oDw0CsHMRnR72FqZUZ3aA2bT4ybYb5KVmq0e1+rmvPLDTa7jXR0tyZUyMWiAc0Dh6TlJB57RReoMVP3CqYLU4KAwpLBWaLxMAcTCC5nxBUFSG+0ExcFyIppjx9WPKfXrPKJFt/i4x4tdwPOLcbcVAC+fxjbmwgp/pcbVnxo5dGsK2Hf42YUiJxkcETPjrjEO0bOfGmXbB4gbTuGdcX0CTUFhVzujoTo/jucmg5+VlBRcyNvidWeOFGrSm53bPCdJRk83eMB2l2z9TMR/Qc0iI8rxJUoQRVZy7m6hxjAJTwwTC+MQ8TIHfgta9vv6zDlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(8676002)(2906002)(66556008)(66946007)(66476007)(4326008)(2616005)(31686004)(36756003)(6486002)(508600001)(186003)(6512007)(6506007)(5660300002)(6916009)(9686003)(86362001)(26005)(31696002)(53546011)(316002)(8936002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFEvNXZZUG5XdzQ1R0ZvdkI3MWpMMjRKc3QrWEUyYXFJZGk2aTVXV1RLREZl?=
 =?utf-8?B?ZkNRVmllQ3dnSGkzRlVFQnJTNjdKVm14ZVhQeUh5ZEJhYlBHTE5LNVEvK0ps?=
 =?utf-8?B?MEloSGl3QjZxTFU4cE9pajkrYWNWODhtMDdicVNSNE81YmpkSjVtWHVFYzdI?=
 =?utf-8?B?ODhKZVJsSGVPczlZdS93ZXpqTnZmUS8wZDJlcWVBcmlkaVM3aHlDaUFySHFV?=
 =?utf-8?B?Qm0yQTVpWG41L0JxL1lEV3orb1A0Z0F2VldncjV2OGNiMHVOUFkxSmlpTUU5?=
 =?utf-8?B?TWpCenpheXJwRlcycUdFSG45Y2FzSUhRU1ZEOFJvZWF6d2dXdU1DR205bE5V?=
 =?utf-8?B?M3I5TFNkNWNSeU5zZ1lNcEtQdTM5TWVYTXp0WUJWY25wUTRDb2tXb09Ua28y?=
 =?utf-8?B?ekpzRjhCUTJ1SWs5L0RYTWhzaGo2N3FqWHY3RldLZGhiZjdJQkZKMSsvMmxE?=
 =?utf-8?B?VmsyMDFzdFFyanZqUFcyT2ZGdUpGM2svSlhxemplL2IxYXp4dTdnaVdqU1ZC?=
 =?utf-8?B?WmYrb0FvS2xRbE1reEU4dGIrRHZQYmdDNjZpSGRCYjVFMUhjRTFGVkZMenNO?=
 =?utf-8?B?cmhYcldZR3ZnVTZIY0xML0JiUjFOSjJqSVlrdTFzQkdRSDMvdFBXbndQYmpn?=
 =?utf-8?B?VGYzdHQzc3I4Ri91eWlOS0RHKzVoTkdOanhWalp0elZMZ3RYa0FMQjljRzB6?=
 =?utf-8?B?YlJvMlVaRTFyeWl3M09ZaS9wRFdLY0NwMmZvYVlHWWxZakdRQy8wUzBuazJ1?=
 =?utf-8?B?QnZBekdMZzVyREc1cTFVZ0kzL3NRWmVHVFhGdG5uTis0bEhtd2hLSlg4bTFn?=
 =?utf-8?B?VWlTRWJiMjZ6MTdvUjJyRXpsZkJZdll2b09wVHVDSG5PU0lIV1h5MWp6S0Vo?=
 =?utf-8?B?WFVjcGZjOXdFRUlBcG1WV0pKeC9GVk1ZN1crV2cxRnV4aTFOZ3ByampIV05p?=
 =?utf-8?B?cnNDWTFXOXZLL2ZkQmpqaXA4TmU5ZSt1eWpkY0VHWFpKSVZGSlZubHF6STJP?=
 =?utf-8?B?OEVFL2svZlo3dWg0bk5yb1c3MERsYVBtbnRqYmlkVHpUU2FXN09SVndDYXRT?=
 =?utf-8?B?bUtrNjg3TVlwK0tmWll3eUx1Z0FxMDd6N1poZEs5SkM1MFlvam4wb2dOTVZm?=
 =?utf-8?B?aEc5M3ZkU1hYdHloUkd1YjlxeFowN0R3dUhwSXRTSFFwUXdGQ3FCZFVTSk9u?=
 =?utf-8?B?WERIbmRTZ0lHVDg4Q2lEK1ZoN3pQRTJHOWRXN3gwTExjZk16L3NGOTRJcHZG?=
 =?utf-8?B?NjgrQm1hNUp4bWRhM3hpRmFOaVVyZWpiN1BjVld2dUhmNUVOWEFDSlNobkZJ?=
 =?utf-8?B?VnZHRmVwdSs5SW05elNWby8vakxOenUxSktZNGdqQnE3NFpoRFczeTNKUVgy?=
 =?utf-8?B?Z0tHSk9aY1RHeUNFWDUwTVZFWG9uMmVBdnVMaEkrS3Y5dGV3V0Zzc2Q5M1lo?=
 =?utf-8?B?VTU4QkxzdEIyZlYvRDBhS21hS1UzRHRwVUpXTG5paHBpQmZLSUtiWjc0Y2xj?=
 =?utf-8?B?cHFzcFBaT1l0OUQ5Qi9IVVZkNEVya0ZtSUZsc0FaWGZjYllud1dWTXN6MkFy?=
 =?utf-8?B?RjlTMXc0S2R2dk5UUS9PaGwvN0g0ekJWMHdSZ3FRWXZkc2krN0NJeU5ud2Nn?=
 =?utf-8?B?ZUtYSGlJTWZlVHZkSG1ka2dYUGxaR0xMQUdvNnI2ZW1zaFdCcG94V1pNNkxQ?=
 =?utf-8?B?M2VDOUdLWmlBenEweFNVZEFDbyt0Umhwc2Y1QlRPempzRHJGMkdIem8zSWlF?=
 =?utf-8?B?NUF6UHRXVDFhVXFxdmo1WWI1Yld6RFRFUEZOVmcyNm44bHNkTnJrcWt3RSs5?=
 =?utf-8?B?VHd4K1M1MGU4cytEQy94ZkpvYzZnMHh0bGYxaElIMlpnbjBuUm1laGZQYTBC?=
 =?utf-8?B?UlhFNzFpYVRvaUJvWW9IQnlZMFFsNHVRc0xxRG55K24xRnJwSUk0UTVBSlhR?=
 =?utf-8?B?Mml2c2N5SlhGOGFnM2xoV1JaUnFJVHhVTXdSVXB1WGhXWUI2QVFjdXJnRVp4?=
 =?utf-8?B?NXRpNkh5aVNrME4rWDgyOGQxMmsvcVJFNDhVNlBzQ0MxWUZIN3lwNEJzZVkr?=
 =?utf-8?B?MmE1QlZDVzh3YWFGWExnc1loanpwUCtpZSt5MmQ1L0FEUkFWV3ZsbThXQ1k2?=
 =?utf-8?B?ZEt1WFY5bzB4L2cyb0RDSUlNU0lyb0VXUHNyWUpHMHIvT2ZqUGN6amhoTjFY?=
 =?utf-8?B?cVhhbWtlQ3dOazR5Z0JQOFlpNjlsSnJlc2tHMEdHMzdxQ0hzNjc0VitZTWsw?=
 =?utf-8?B?KzI5NkgwZ2xwcHIzN25YYk1mZDliN2UzaWhXS2tNS1VUalBlVUduMVZVbHJr?=
 =?utf-8?B?ZWhUN2hQcHdjS2NVTXZrT2ZtUEJrU292Y1VMVmFXOG1KaDVBa3NEUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312cc78-286b-414b-8f96-08da11b0b975
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 18:19:55.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IltCOKgKY2eUP0eqmM245d9xz1uIjRoDUDLMfc4GdC5o2Aj42fSuS537bVBZZE94NUnXUm+9NSV4m3MFZmPIXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3028
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290101
X-Proofpoint-ORIG-GUID: V3iLYqyMl8RC7XwHqBv_6FipI_H28KaC
X-Proofpoint-GUID: V3iLYqyMl8RC7XwHqBv_6FipI_H28KaC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/29/22 9:30 AM, J. Bruce Fields wrote:
> On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
>> On 3/29/22 8:47 AM, J. Bruce Fields wrote:
>>> On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
>>>> Update nfs4_client to add:
>>>>   . cl_cs_client_state: courtesy client state
>>>>   . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
>>>>   . cl_cs_list: list used by laundromat to process courtesy clients
>>>>
>>>> Modify alloc_client to initialize these fields.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c |  2 ++
>>>>   fs/nfsd/nfsd.h      |  1 +
>>>>   fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
>>>>   3 files changed, 36 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 234e852fcdfa..a65d59510681 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>>>   	INIT_LIST_HEAD(&clp->cl_lru);
>>>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>>>   #ifdef CONFIG_NFSD_PNFS
>>>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>>>>   #endif
>>>>   	INIT_LIST_HEAD(&clp->async_copies);
>>>>   	spin_lock_init(&clp->async_lock);
>>>>   	spin_lock_init(&clp->cl_lock);
>>>> +	spin_lock_init(&clp->cl_cs_lock);
>>>>   	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>>>   	return clp;
>>>>   err_no_hashtbl:
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
>>>> index 95457cfd37fc..40e390abc842 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -283,6 +283,35 @@ struct nfsd4_sessionid {
>>>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>>>   /*
>>>> + * CLIENT_  CLIENT_ CLIENT_
>>>> + * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
>>>> + * -----------------------------------------------------------------------------
>>>> + * | false | false | false | Confirmed, active    | Default                    |
>>>> + * |---------------------------------------------------------------------------|
>>>> + * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
>>>> + * |       |       |       | Lease/lock/share     |                            |
>>>> + * |       |       |       | reservation conflict |                            |
>>>> + * |       |       |       | can cause Courtesy   |                            |
>>>> + * |       |       |       | client to be expired |                            |
>>>> + * |---------------------------------------------------------------------------|
>>>> + * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
>>>> + * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
>>>> + * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
>>>> + * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
>>>> + * |---------------------------------------------------------------------------|
>>>> + * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
>>>> + * |       |       |       | reconnected,         |                            |
>>>> + * |       |       |       | becoming active      |                            |
>>>> + * -----------------------------------------------------------------------------
> By the way, where is a client returned to the normal (0) state?  That
> has to happen at some point.

For 4.1 courtesy client reconnects is detected in nfsd4_sequence,
nfsd4_bind_conn_to_session. For 4.0 courtesy client reconnects is
detected in set_client.

>
> How is CLIENT_EXPIRED treated differently from cl_time == 0, and why?

cl_time == 0 means the client is being destroyed (almost) immediately
either by the laundromat or force_expire_client.

CLIENT_EXPIRED means the client will be destroyed by the laundromat
and this depends on when the laundromat runs. When we set CLIENT_COURTESY
we don't clear cl_time since the client is not really expired yet.

We could replace CLIENT_EXPIRED with (cl_time == 0). However,
to set cl_time = 0 we need to acquire the nn->client_lock which
causes deadlock when we try to resolve lock conflicts
from nfs4_resolve_deny_conflicts_locked (fp->fi_lock -> nn_clientlock).
We use the cl_cs_lock to set CLIENT_EXPIRED.

>
> Why are RECONNECTED clients discarded in so many cases?  (E.g. whenever
> a bind_conn_to_session fails).

find_in_sessionid_hashtbl: we discard the courtesy client when it
reconnects and there is error from nfsd4_get_session_locked. This
should be a rare condition so rather than reverting the client
state back to courtesy, it is simpler just to discard it.

nfsd4_create_session/find_confirmed_client: I think the only time
the courtesy client sends CREATE_SESSION, before sending the SEQUENCE
to reconnect after missing its leases, is when it wants to do clientid
trunking. This should be a rare condition so instead of dealing
with it we just do not allow it and discard the client for now.

nfsd4_destroy_clientid/find_confirmed_client: instead of destroy
the courtesy client here we just let the laundromat destroy it
as if the client already expired.

nfsd4_setclientid_confirm/find_confirmed_client: there should not
be any courtesy client found from nfsd4_setclientid_confirm, it
should be detected and discarded in nfsd4_setclientid.

-Dai

>>> These are mutually exclusive values, not bits that may set to 0 or 1, so
>>> the three boolean columns are confusing.  I'd just structure the table
>>> like:
>>>
>>> 	client state	meaning			where set
>>> 	0		Confirmed, active	Default
>>> 	CLIENT_COURTESY	Courtesy state....	nfs4_get_client_reaplist
>>> 	CLIENT_EXPIRED	Courtesy client to be..	nfs4_laundromat
>>>
>>> etc.
>> will fix in v19.
>>
>> Thanks,
>> -Dai
>>
>>> --b.
>>>
>>>> + */
>>>> +
>>>> +enum courtesy_client_state {
>>>> +	NFSD4_CLIENT_COURTESY = 1,
>>>> +	NFSD4_CLIENT_EXPIRED,
>>>> +	NFSD4_CLIENT_RECONNECTED,
>>>> +};
>>>> +
>>>> +/*
>>>>    * struct nfs4_client - one per client.  Clientids live here.
>>>>    *
>>>>    * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
>>>> @@ -385,6 +414,10 @@ struct nfs4_client {
>>>>   	struct list_head	async_copies;	/* list of async copies */
>>>>   	spinlock_t		async_lock;	/* lock for async copies */
>>>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>>>> +
>>>> +	enum courtesy_client_state	cl_cs_client_state;
>>>> +	spinlock_t		cl_cs_lock;
>>>> +	struct list_head	cl_cs_list;
>>>>   };
>>>>   /* struct nfs4_client_reset
>>>> -- 
>>>> 2.9.5
