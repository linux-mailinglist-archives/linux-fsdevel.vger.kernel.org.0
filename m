Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839824DA000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiCOQ2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiCOQ2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:28:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0657056C07;
        Tue, 15 Mar 2022 09:26:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFS2UI000760;
        Tue, 15 Mar 2022 16:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oGAx9RFG+mzBmVoxTe2BWqLl5Io4Nz4ZvWrez6IWBmo=;
 b=DJ2kPpxLO2wgpJVdVX09SyXiAO1qOfOfSf87ETkVNW+YBc1Q/rLaXXLg8neq0SXjkpy7
 UH0WeCYFrDWVu8B3NnvppTpJrQ7M28Ckz1RDwwCvTM/Aey0YX8jneV6RVNh/u3IKff4F
 xPvnhtvoJ6nJX9i1InX1dutO/G1VQy4C5Ky9Mnpz1X4YoV0hcr4w2DiSdN8Wj7JnmAXL
 QGl4jSUvEMPc+hEXdZmCwTl9Q5Rl9+iNwDk/weh3soSv/CAQSpji0D/giN4CrB6f3pgC
 BurUFBrd/03L4B5qfRbPR7nTsu5R1/FpgxoohXIdfy5XxiUQH4/P26kCS9LCKxcqxn88 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu3scc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:26:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FGQ2QI029252;
        Tue, 15 Mar 2022 16:26:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3et64k3epm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhBd3NJN3qitB32bLifiZYHUyaUqnVNHintgPC7yKpj1nN2v0zraZEI95G41OcCzS/znxF8XdupBC4ITmJ/KW1QPJg8WadRLfze04L8eU1Xkp4gYFYd1FTjN+y/RQhjC0hnD8LROzgWWVrI0R8dZ+76pg9+rkjVw1u4nx8Lsm11ZtfLDoi/3ZHdnqZh6y5i+diiZ0lVpt9L4Emb1r3VTjUv92wOGJGLGAt0D5EDDtDbae6DJ3cr33G/L5qC1VFZHX3nfQayldY8mfDsQFBUQMYMcmEmu6j59nSRTogIqpj9xLGP+9phq7NYrwBK6jICecop/IWqp9bAd0ToAgqkg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGAx9RFG+mzBmVoxTe2BWqLl5Io4Nz4ZvWrez6IWBmo=;
 b=AaPDSRoWQkvoR8xEXTdx+J90FGpi+mXHF1vV6nIGM/DJbhiryZqNhanEEU7To0/ET+/kYKlj0aaThukGokzv11D71CZUcOJ14uBwNcPvJQ3iXcpepsXsRWyH6o+sTsqfgTs1inPZSL0wtiUdbN8+Iwlnlpc4oKV9/YY/UUf6G45izyGSFAobhbewpGiDKlYvW9QutWz9mBsTxhbXoGONI4o25ioeJGE4ZekBlGUkoQC8iRQ/M2+tEILwZbfBHxlvtAxMM1rrNB2frIhzm9KMK/bha9y4co86F90s9AXckvF3HzP/C9MLilF2WDfKXEkCfQCpvr3/GxwgtDDyi4q3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGAx9RFG+mzBmVoxTe2BWqLl5Io4Nz4ZvWrez6IWBmo=;
 b=QUzUvzHXDwv9c7XNDXG9IgDCjFIDQ9P0e8yqVP2XQs2oTna2YpwSlJd4ZsBaVnxwcF7WtodBxYxYmk3uPDDY7kiwd3L6+VF82TKAfZRT7DtxSonvT7cMseazBSN6zc9BY61pHvZnI8tNyQ61JBZasDgh9JFOowpcFdzskV4udhI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 16:26:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 16:26:49 +0000
Message-ID: <1e1ff6a1-86cf-99d4-13ad-45352e58fe73@oracle.com>
Date:   Tue, 15 Mar 2022 09:26:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
 <20220315150245.GA19168@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220315150245.GA19168@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:806:127::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec621f4-53c0-4823-762b-08da06a09ae9
X-MS-TrafficTypeDiagnostic: CH2PR10MB4118:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4118582187F828D6EC53122E87109@CH2PR10MB4118.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBC9fjgYiaTulQwVa27rKlkik9eM+wpoZa/ioLyN2Z9d0HEdSqyVQLW760kRokOSHYSRlxx/MUllwoyQr3qEF9RmK34jXEaek0oGVX88NNqFChH4dRYzJ5uP6PtulqBS/Spm0hbWalqobAZase6yh5x19OFQNnsJQGuMh9er0NsDZ3WrQ0StCx3SX/m8x37kLvEPSDq9p205r2yfOUs3GgCtWgFezxVoHFOwZ5AINpp86EkpF49LrViaOvPcwb5/BnM3rdksfxvxnRRGjWRbAU9lStB4ghaFpBCdbQjiSbKcvxDD1U8OV4ckPfsNJibdFRAvRS6pr52Y+L+fnHWGeCVoTdQcU6V9yjfMyjQo4QykJrttx6ec0J9egEXI1zvYzeJaX4hUsodOuoBHdja+4p/M17uX7fYUK6fD0TXiYIrBE8LWOL/RdxWRaoTFpwPtR4rg31ZEBZNd4xnOumO7+2UNWZdgDWzuvN0kgUtfPT2PYbz8XvzfYOcfXOu39hiWFsuNEVxPrbqRfuPVayEWuaUf5nlOnFI0JtZ8zAkHXrvxNskgnDNLFX8zefg/7/ced4XndMFfelg9a706TBqXFpRULeD8F9YvO7AOnEy5n8+Uw3WU30F6q038vBV5ncbOsaPmnADE85EI4AkF6n0NivlNGTqlyxupyWNoVbDrijxrSODw8buWhNJYgZuvoPDiVBczxsFMm7ol+fj14mb8Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2616005)(2906002)(36756003)(8936002)(66476007)(66556008)(4326008)(8676002)(53546011)(26005)(186003)(6512007)(6506007)(508600001)(6666004)(31686004)(66946007)(9686003)(38100700002)(31696002)(316002)(86362001)(6916009)(5660300002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZ3NStqUm43SXpJZHdIU1NzYVJzUWF1Y1d0NHBPcnRidXJlczk2OHQ1TFRO?=
 =?utf-8?B?eXpJNVVOWVg4NDdnL05iVWFtUTJ6Mkt4UkQraUtWVmZKcmw3eXpvRS81bnVk?=
 =?utf-8?B?aG4rTVVjTnVsTlU3UUwwVW96Um0wUElHZllvZ1NhekpYNm4vQmxNa2QwajJC?=
 =?utf-8?B?VGE5TzlQaDBnamw1OFBSVS9QNHB2a3VyaVB1OWlzUUVkMFFnTVFwdTZEd0s5?=
 =?utf-8?B?Q2FBU0UzY2dIOGRnTERRZEdrNE9GRXBmU1dyd1BoZ2lsT1FHYktNSGZURWF0?=
 =?utf-8?B?RHJPSWVsS09hUG91dGNCUEc5OEhKR2wxeGJLc1RsZXlQRmF5TG84RHBvc0dQ?=
 =?utf-8?B?UGtDMGpBRjQ5MS90b0w5THRCQXF0TXJVVEJKRlB4amVpR0xYWU1Femw0Qzl2?=
 =?utf-8?B?eEdjWU5ZYnkwRFZuN3BnYTlOQXBYaGNNbXdOVG1aZG9PZmNsWDRsZ0J2cjhF?=
 =?utf-8?B?YjRFM2pNZTh6dDZTUHM0aitEbGpuam01c1JLSmNXMEZYcHhBQkUxQUhEWm1q?=
 =?utf-8?B?d2ZRSmlSSzFlOEJyQUFacldhNml4YVBWU25LZ1g4ZXVIbHlma0tvbFhVeU4x?=
 =?utf-8?B?allBNW9VbUd0VzZrVmFpNzhUL1RhVTFKZ1A3K1k2b3doVGVweVJiUWd2UEZw?=
 =?utf-8?B?R2kzckZ0YWNwM0JmTEJlaTl0ZEgzankzd2w1SGtjcVdVbXh5N1BNS3hmMjlz?=
 =?utf-8?B?b3pseGRPalg0dGVHVCtqdmtCaFhqUk5PT1AyM01TRjdaV1I4T2dycitDd3BF?=
 =?utf-8?B?eEk5VTFKSWQxR3Q5Tk9xVkF6N1d4YlNiZTdLV1NkUlpGNTg2THRib3hqWE81?=
 =?utf-8?B?c1AzdTJCcTZsdGVQc1NvVUgrRUJaNUxKSjJqZW80aHRsYmdCckJNaTBqZmVi?=
 =?utf-8?B?d1BsQnpxTTVrYmJndXE3SnlQZWIzUVRGYUR4cmZuMFNjQ3JISnJ2UkxSaW9p?=
 =?utf-8?B?MGlGOXBXczh0YU1RTnlhbHd1a3R6MGhDNWdidzIzZ3FpcENPTjh6ZFhmUVQw?=
 =?utf-8?B?eTYycWxhcEdnZEpyOWZHVUV3R1U3RGZJMnZBRE4zbi9BTU82MmExOHJMU09J?=
 =?utf-8?B?VnM3enZ0YUdKSDV5YzFiemFCR2dlam1hWjlISXdoWnowNUNJNmRSVjJabUFI?=
 =?utf-8?B?Mkphb1NackxYM1E1cXM5ekJDbFhDZHZaaUluMFd6V3lETklCQW01NjQ0cTRp?=
 =?utf-8?B?dys4UDVYWjlVbWF5UHRnWlJvcVBRSVJBcVo5bzI5Z0xTYXl1UkE4S2lTRG1n?=
 =?utf-8?B?RHpPM2o4KzJhSWlrZ2ZuZkM1NEFIQjBVU2JMQk1xNzVTK3hzdFFMbjBTSHB4?=
 =?utf-8?B?Q2JJd1VSTHpObVRMSlpVYllKWFlrMDQ4dXNHUFFab2o2NzNENDBiYWRJcnNI?=
 =?utf-8?B?WjFYV0l0SzFzREZsUnEra2Z3N295bEYwbDhqOGw4MnF2a1BWOXFlNXpTb3gx?=
 =?utf-8?B?Tld4UkRUWWpZVHltcGZZR095Mkk1ZmxCVVFLTThNU1BFUmVZMW1iR2M3aCtK?=
 =?utf-8?B?cTY2aitlVDNHU0s2ZkcrQTBRbkxWWXZpL3VSRllKa3Jsc0daL0FRWGR3VGIx?=
 =?utf-8?B?ZWxDMjlWODdyakNMZlB0dkhZV2lPMTFzWVRMall5cTNOYUh3b0VBZ25FeFAz?=
 =?utf-8?B?NGtJOCt0MlZNVEROM1Jva2Uzb3h3MFhkZkpkVitzZCtWQzlLaEMwQmtIaVkw?=
 =?utf-8?B?dEpmb0ZiQ0hiSGxXam9CVjZsWkJORlVwd2tVMEdRM2pQVUQzdEdSZ2JyRDFa?=
 =?utf-8?B?TjZvUlgrUjRFNXdTYVBsN2dsa2pwd1BJd1loMlk0S2dLVVVRWCtBNVovOG1i?=
 =?utf-8?B?dWZTamRtTWhDeVRtd0hxWXFGNkpYc2k1YTIwRk42N0NqS3NORERkV1pkdXZt?=
 =?utf-8?B?WGtiMUpEeWpWTUxXZ2ZXTHphanNBdzZHT050VDBZK0tHRFRtUlk1RnNKZ1g0?=
 =?utf-8?Q?EUr+y9YpZUX9vS7TeG6A91rT7N5FywyT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec621f4-53c0-4823-762b-08da06a09ae9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 16:26:49.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YHJRgd2U8ZPIIvw6krbhg+8YlUfsH3isfDpcXMS0fWOd7s1w0W5PIuiCAtEdMt/7feHvYpbN7YHRIudNmuPPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150103
X-Proofpoint-GUID: KdfjpAO-33oWnL6aTbMn_JN8oFImzSVp
X-Proofpoint-ORIG-GUID: KdfjpAO-33oWnL6aTbMn_JN8oFImzSVp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/15/22 8:02 AM, J. Bruce Fields wrote:
> On Fri, Mar 11, 2022 at 06:13:27PM -0800, Dai Ngo wrote:
>> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
>> If lock request has conflict with courtesy client then expire the
>> courtesy client and return no conflict to caller.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a65d59510681..583ac807e98d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>>   	}
>>   }
>>   
>> +/**
>> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %false: real conflict, lock conflict can not be resolved.
>> + *   %true: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_lm_lock_expired(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = false;
>> +
>> +	if (!fl)
>> +		return false;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>> +		rc = true;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> +			rc =  true;
>> +		}
>> +	}
> I'd prefer:
>
> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> 		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);

we also need to set rc to true here.

> 	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
> 		rc = true;

With v16 we need to check for NFSD4_CLIENT_EXPIRED first then
NFSD4_CLIENT_COURTESY because both flags can be set. In the
next patch version, we will clear NFSD4_CLIENT_COURTESY when
setting NFSD4_CLIENT_EXPIRED so the order of check does not
matter.

>
> Same result, but more compact and straightforward, I think.

Chuck wants to replace the bits used for courtesy client in
cl_flags with a  separate u8 field so it does not have to use
bit operation to set/test.

-Dai

>
> --b.
>
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>>   static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_notify = nfsd4_lm_notify,
>>   	.lm_get_owner = nfsd4_lm_get_owner,
>>   	.lm_put_owner = nfsd4_lm_put_owner,
>> +	.lm_lock_expired = nfsd4_lm_lock_expired,
>>   };
>>   
>>   static inline void
>> -- 
>> 2.9.5
