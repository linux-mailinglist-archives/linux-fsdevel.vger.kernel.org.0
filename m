Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932DD4BBEEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiBRSDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:03:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiBRSDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:03:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AE4ECFB;
        Fri, 18 Feb 2022 10:03:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFx5k4023680;
        Fri, 18 Feb 2022 18:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GjA2NBeiWuaRY1phTqLNGlr+VMKqwLt1MiysRdmGvnI=;
 b=w52e6PEHgnzQuexL5sbMdijGgL+j/pBB2kk5xWi1XlNFjdGKj6p2sVMTYdl95tNHHwGp
 H5CO3ZIOkFlUSvczBlHFjNfv0+eK5lqzGSk7O87fymbNYRuBp3CZ5xwwkFKBEpysE4Kf
 n8jit+VPf/m268w4j4ye9gZhpHdYeUgaFbYU6GPI9L5pSca1fiKteNtI1FN7lVRXUx0e
 urIx8KGWRA5MzbZm1eROxk8nI8sdXwKD0E6FYRvxypIAMNSONLXdciiuXAsjg1kjEU+l
 TpquENjQKX7wktSLn8R3F9SnK8OdNUz3mjb5XVaivSIofVmVTNIJTq+ZRs5/7kGooCRv mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3st9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 18:03:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IHUdOk056405;
        Fri, 18 Feb 2022 18:03:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3030.oracle.com with ESMTP id 3e9bre77k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 18:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLYhYk8Nt0UNVroZwrDr39YJqHN494OkJVYhX/gbT1lNpHOk8/u8epGmR+K6Rtx6lijRMUrsc5pJrHMAHQLw97mEU6Tv5eatTie9218neU2yjd8XlTyY3eptHtg6qq6piy/kt8H+9VfcbVIoTqK+IGPBZdX76QZ+eC2LlsGaAKXX0ESR6xgW5LtwjXPStkZwdNp2mlVZmx7Xb+g4qsLstDABPWZ8teajGsrn3eAa/3NCH0pyEtmuUxKZkTK2P/l4z3KhDOVtPuo+vF9yVRnciJznKo/0fEzsNJ0UjDvovVNCAah93vAcyQ2OqTeXjiqmLphklbbAP7vnwi/Z0G7QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjA2NBeiWuaRY1phTqLNGlr+VMKqwLt1MiysRdmGvnI=;
 b=MKvMj7Se8biFPBg4wNDbkq9o47x2XnhVeDvVjCgIVMqQOu8d+QBYDoh6fMa/tTGJPFnUlY7RMwZfEnSG7CdkwtwkJXhS4X307MaCXUEaMYdmF+z1P/vzOWpzGlVMtT45reQ68SVJ11W0G+KcbCpdJCOFIU0qzAynN9Gd8mTbP6tBRuTlvN9v8Kq7SW8/3Y4v+6wCeTpLXDX5p6/eLmB/xxEnO5heo+5HLdb8KCh6Jd6EGlfWsUysUJh9p3hO7p9TpoxRd58XmEfgRqk5+RRi1c+ahfLiRkW2x5kasrQlCr0+LwIM0dQFEgkWHEyuunvbH8H2RvN+VFgsMU/L118imA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjA2NBeiWuaRY1phTqLNGlr+VMKqwLt1MiysRdmGvnI=;
 b=M3i9Htb/6Lfwui+PZYP821Iibg3TaKShWvWEaUlzyHyK2GBUntM6md4ryMY0jSCX1f0j8SJkmbLAu0PRWwlF0oxR9p9eZcDh4jI3HMiGKQTWvC56IyDNIi75PvICk7nMZUidZweH3YcNJjbnCyZLZJO2ghmAfGjIIt2aMnL95GU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 18:03:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773%5]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 18:03:12 +0000
Message-ID: <4253d364-324c-c993-c15a-e75896f1d38b@oracle.com>
Date:   Fri, 18 Feb 2022 10:03:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
 <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
 <b76a9b30-89d0-c4ab-a1c7-0ca1a1ed6281@oracle.com>
 <6553DE77-F4CA-4552-82C1-46D338FCAE44@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <6553DE77-F4CA-4552-82C1-46D338FCAE44@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74ce2c2-50f2-46a1-241c-08d9f308ede5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4498:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44989F42DDD5AF57784E969087379@CO1PR10MB4498.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYaWjRGMIfVzVv+4+hF1TG/3czSf1hPZh+zPCfl0my/ytoDqVyJeFnzkiLfRXHF4Kb67Fs7EEvNT9j8EapOslLhxAjXUhjKT95WvmzqZxCZELacb1l9CUcHSVGv5sXPAvaTrBoRKIBvpTAZoclV4r8Y0OGmxewmP/T0NIisgBiWdP6TMlY5epvcRYM28hMlxnmTdpyOLGjrsu5GX/obfl60nB11vddDKIu8dIOYN91DtU9qQBmBk+WJIGWobK8NkpMLBaYFZlov34AGdQ5S8wvz3FDMsqLeL6KLtDRm6O5j5Wu0vXfwxdCxN3T2Ym/vZnvT6DpAghq4jB6vwdF91mHMcKyIWmUVhGQXYnzli/8KjADWVukoEqf1me52f6/3SasyUcKhq/obwjzjGnbKfftu1qujzolXwzJLj7uVe2iJZzmOXIMiPc018sYhN7n4ykjpwCPrltmY4y3duSHuVFGCZUaL95GV8NLkcLPApQs1FV7pZ7I2AgVk6WmmaTPi7no/krj8P0ofV8o3NAfZx0wL0FpjSt3uDzJ+Y3tzf83qWCEGw+YfuNvy569uT3BhMICr1oLGcgOwmvuSLQcdBHZq/VcLoEwGwAdai3+PBoSnS6oasSqI+ulthCWzTx8kooBMOzgXfDdisuxA0KPfQXaSgSg7LXcXtdjdsq4wMv586IRaV7Sg4mY4TTl+J5kqB+KZNhpUFGkPgDFT4b935xPBaWdMD+1qFZtSgkdCDx4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(36756003)(83380400001)(186003)(9686003)(316002)(54906003)(6512007)(31686004)(37006003)(30864003)(31696002)(2616005)(6666004)(6506007)(8936002)(66556008)(66476007)(2906002)(8676002)(86362001)(38100700002)(6486002)(4326008)(6862004)(53546011)(66946007)(5660300002)(508600001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUs2dHNqZlVFaGR2R3lvRkdCb0l1VFF6TTlNcmxOL0dtUjUyTGUyWmd0MGZB?=
 =?utf-8?B?d1hJUFJJdGU1RDliWGVsRUFCTkpWL0o2MkJxNEN0bklGZHhqSG9xTnFudGgz?=
 =?utf-8?B?U09wV0J0Wm81UFVEd2ExeVRkUTBtdzVvaU05ZFBxcmVoNmlEWjlsMHp6eGtk?=
 =?utf-8?B?Tzg2WHRaS21xUWM0NUc2STJtSkM5bDNGTjAyWkhhTG1Danc4VVY0K1VNUlg5?=
 =?utf-8?B?bmNLK3lvdjBJWUFtWlhOTlhkOG1rSlJhYUlnanhNZHVSbUFMVG1ZZ1ZaRW9x?=
 =?utf-8?B?cDROb2k2Szg1L2tFSForeXRnUVoxUUpqNjd3cFhpWERpYVpBOVJWZE1SY0JG?=
 =?utf-8?B?MTJEUENkZEpNaEJyZEhodk5hcDRSUXhheEY4VE96ZXgyTkNQM040NDhjSHlE?=
 =?utf-8?B?YjdQc1VFYWMzNGY4SEljbDVVamFEY2hxZkdGSm9ZS3l0TGRURFVSRTA1NWdt?=
 =?utf-8?B?TU5QaXIzZk5XbThDSXRTZ1JwN05OQlBjaHZNK3ovUk9sOGlxMnlzWEY0UzdZ?=
 =?utf-8?B?ZloyWmZjWHdmam1zVmxEaWxhN0JvWUVqNmo4VUVQMzNEeWhzMkYxOVQyK0Vv?=
 =?utf-8?B?QTQ2YXduWnkrdDEvcERTMVBlZW5YUzM3SVV1ckY1UDhWQXhNY1h2MWM5ekZL?=
 =?utf-8?B?cTJzbm5GNFg5Uk9FdFZFTEI5eEQ5aitteitXODFnNURrRFIxUHhvQXl5TDhr?=
 =?utf-8?B?RGVKaTAzUEU5VS9xNEN6YTNKek9YcVpUTUxYdWd5VlhNckJOSnFFSVdaUGlX?=
 =?utf-8?B?M0JiNFUrZEpBdjVvU0RNY3hGZWdTcGxHc3VaL3hoZXRmNlp4cGZHRDhUd2dl?=
 =?utf-8?B?NTgvQzNTTjNyS2JneHlWOVZqVHFzTm1nbWtiYUUwV0JMbXhRZVpWZFhVTS9t?=
 =?utf-8?B?NUlHajFuclJrdnh6bVlxdy9KWlBQM1pKajF6YzFqRzJPaTI3STNFeVV5Vnl0?=
 =?utf-8?B?OWZYV1owNXo2RTltclZuRFE1SmplbzNodDFmMU11V24zVjNwSExzeE9McWl2?=
 =?utf-8?B?Q3VSSGRmZ1NGaHF3UGxrd1FqZ1N2bHR6Y2pVS1VKV2Rham50T04zS2xXSWEx?=
 =?utf-8?B?RHdtUUlrbVgwU2V2U2J1dko4UUFYQkdNTXVzVzJ4YUx3YzFvMkQ0U0F6dElN?=
 =?utf-8?B?Y2k4VVJ5Y0RUT2JCRGg0YTZLSDJTS21DZXVscU9RWG5WLys1TnBPQllwbld4?=
 =?utf-8?B?VklRNFR0VDgzcXlkS3JscEN0amR2dXJXanNaNmxFd0pFWS9UZDdGMWNXZkFO?=
 =?utf-8?B?SkFoajZnWDBHKzhVWjk1L0RibEJpajB4RGNHWnVOUzlOTC9YbnNSZ3ZuSzQ3?=
 =?utf-8?B?M3FocW5GZDlyUElBNkkwcWpEbVZ4cnBSdndkb0ozVlhSNWFGcWp2MmVEd0Q1?=
 =?utf-8?B?NFExRFNnbWtzSEdEZ2hObmE3MTJnSHNGZDlwZDByMG5qOVY3QTdiWWV5ZTMr?=
 =?utf-8?B?UDRpSFIrNm41UGZtdnhjRE9zY3ZFMFprR2hFbTFtZ2FacU15UDMraHg2RURZ?=
 =?utf-8?B?bDBWWjg2a2YybXU1RUUzalJxZ2hReGN3MFBuY1ZSODhibjhwUUhmOXYrQnJz?=
 =?utf-8?B?T1AzZXNvVzNBM0FwQUJYMGJsQ3cyUCtmQzF2MmxVVWtROFFQb3BLN3MyeXh0?=
 =?utf-8?B?SEJSUzU3OXdGdTZVeWwxN2drVXQ1MnVQbnlTa0ppQ0NKQ2ZyTzc4dzFvZGRM?=
 =?utf-8?B?M0NKMWEzOUJuWmRJa1lIMXYwazV0V29yN2FoTW9YNGJyYWh1ODVrdHZFd0hs?=
 =?utf-8?B?dGpCUFI0L0ZSSWJucWV4MWptRS9QbzJZbVI0ZlpnY1F3QmlMVmJJYnlvVHNY?=
 =?utf-8?B?MDZlY0x4NkUrWDZLeGVOeDVyQjZENFpWbjkvOUw0TWN1RHRJR1NKcm5HWEpy?=
 =?utf-8?B?WjBlY2FEY2lsd2gzV2tScHd1a0l5M3REbXZGYWJVcGVxaUVEdndaNjdMbDVM?=
 =?utf-8?B?bHFBelBhenRSeVkrc2dDcHJtQXhaUDJsUlBIOFVPYXA1ZE5OV2JxWWRtMjhs?=
 =?utf-8?B?bURXTXdYTjdwRGZVcXFYcVQxbmF5b2pzT1lIQlNEdm1KSlo0MGU0Z3FjT0NS?=
 =?utf-8?B?WmV0enBEVkROZWF0czVjNUpKNHhpNEw1bnhpUTNFN3M4Qjg2V2xMUmpUQk50?=
 =?utf-8?B?L25kRTlzNXU0eXlTLy9UWWdnR0dHVE9ucVFJeWMrbkhRN1YxTWt2Y0MvcHY5?=
 =?utf-8?Q?KCAxyH4vZ/OzrntEQQ+PDz8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74ce2c2-50f2-46a1-241c-08d9f308ede5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 18:03:12.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDearRUfzKjDJddpcp/n7uIcLWJz0Mcx4JR9wCmldxb/LFBiTIpvFTbpt42BIvQpwUCTjqpkUXAyKK9xc5uLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180111
X-Proofpoint-GUID: J0Tcrggh26zTrlUjrGSSmAA8MteGNdCx
X-Proofpoint-ORIG-GUID: J0Tcrggh26zTrlUjrGSSmAA8MteGNdCx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/16/22 8:15 AM, Chuck Lever III wrote:
>> On Feb 16, 2022, at 4:56 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> On 2/15/22 9:17 AM, Chuck Lever III wrote:
>>>> On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> @@ -3118,6 +3175,14 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
>>>> 	return 0;
>>>> }
>>>>
>>>> +static void
>>>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>>>> +{
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +}
>>>> +
>>>> __be32
>>>> nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>> 		union nfsd4_op_u *u)
>>>> @@ -3195,6 +3260,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>> 	/* Cases below refer to rfc 5661 section 18.35.4: */
>>>> 	spin_lock(&nn->client_lock);
>>>> 	conf = find_confirmed_client_by_name(&exid->clname, nn);
>>>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>>>> +		nfsd4_discard_courtesy_clnt(conf);
>>>> +		conf = NULL;
>>>> +	}
>>>> 	if (conf) {
>>>> 		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
>>>> 		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
>>>> @@ -3462,6 +3531,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>>> 	spin_lock(&nn->client_lock);
>>>> 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
>>>> 	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
>>>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>>>> +		nfsd4_discard_courtesy_clnt(conf);
>>>> +		conf = NULL;
>>>> +	}
>>> I'm seeing this bit of logic over and over again. I'm wondering
>>> why "set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);" cannot
>>> be done in the "find_confirmed_yada" functions? The "find" function
>>> can even return NULL in that case, so changing all these call sites
>>> should be totally unnecessary (except in a couple of cases where I
>>> see there is additional logic at the call site).
>> This is because not all consumers of find_client_confirm wants to
>> discard the courtesy client. The lookup_clientid needs to return the
>> courtesy client to its callers because one of the callers needs to
>> transit the courtesy client to an active client.
> Since find_confirmed_client() is a small function, I would
> create a patch that refactors lookup_client() to pull the
> existing find_confirmed_client() into that. Apply that patch
> first. Then the big patch can change find_confirmed_client()
> to set NFSD4_CLIENT_DESTROY_COURTESY.

fix in v14.

>
> What about the other find_confirmed_* functions?

same fix as above in v14.

refactor nfsd4_setclientid to call find_clp_in_name_tree directly
instead of find_confirmed_client_by_name. Modify find_confirmed_client_by_name
to detect and destroy courtesy client.

>
>
>>>> +		 */
>>>> +		if (!cour) {
>>>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>>> +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
>>>> +					NFSD_COURTESY_CLIENT_TIMEOUT;
>>>> +			list_add(&clp->cl_cs_list, &cslist);
>>> Can cl_lru (or some other existing list_head field)
>>> be used instead of cl_cs_list?
>> The cl_lru is used for clients to be expired, the cl_cs_list
>> is used for courtesy clients and they are treated differently.
> Understood, but cl_lru is not a list. It's a field that is
> used to attach an nfs4_client _to_ a list.

Yes, cl_lru is a list head to hang the entry on a list.

>
> You should be able to use cl_lru here if the nfs4_client is
> going to be added to either reaplist or cslist but not both.
>
We can not use cl_lru because the courtesy client is still
on nn->client_lru.  We do not remove the courtesy client
from the nn->client_lru list.

>>> I don't see anywhere that removes clp from cslist when
>>> this processing is complete. Seems like you will get
>>> list corruption next time the laundromat looks at
>>> its list of nfs4_clients.
>> We re-initialize the list head before every time the laundromat
>> runs so there is no need to remove the entries once we're done.
> Re-initializing cslist does not change the membership
> of the list that was just constructed, it simply orphans
> the list. Next time the code does a list_add(&clp->cl_cs_list)
> that list will still be there and the nfs4_client will still
> be on it.
>
> The nfs4_client has to be explicitly removed from cslist
> before the function completes. Otherwise, cl_cs_list
> will link those nfs4_client objects to garbage, and the
> next time nfs4_get_client_reaplist() is called, that
> list_for_each_entry() will walk off the end of the previous
> (now phantom) list that the cl_cs_list is still linked to.

Chuck, I don't understand this. Once the cslist list head is
initialized, its next and prev pointer point to itself. When
the courtesy client is added to the tail of the cslist, the
next and prev pointer of cl_cs_list of the courtesy client
are not used and are overwritten so there should not be any
problem even if it was on an orphaned list.

>
> Please ensure that there is a "list_del();" somewhere
> before the function exits and cslist vanishes. You could,
> for example, replace the list_for_each_entry() with a
>
>      while(!list_empty(&cslist)) {
> 	list_del(&clp->cl_cs_list /* or cl_lru */ );
> 	...
>      }

I added the list_del as you suggested but I don't think
it's needed, perhaps I'm missing something.

>
>
>>>> +/**
>>>> + * nfsd4_fl_lock_expired - check if lock conflict can be resolved.
>>>> + *
>>>> + * @fl: pointer to file_lock with a potential conflict
>>>> + * Return values:
>>>> + *   %false: real conflict, lock conflict can not be resolved.
>>>> + *   %true: no conflict, lock conflict was resolved.
>>>> + *
>>>> + * Note that this function is called while the flc_lock is held.
>>>> + */
>>>> +static bool
>>>> +nfsd4_fl_lock_expired(struct file_lock *fl)
>>> I'd prefer this guy to be named like the newer lm_ functions,
>>> not the old fl_ functions. So: nfsd4_lm_lock_expired()
>> This is a bit messy:
>>
>> static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>         .lm_notify = nfsd4_lm_notify,
>>         .lm_get_owner = nfsd4_fl_get_owner,
>>         .lm_put_owner = nfsd4_fl_put_owner,
>>         .lm_lock_expired = nfsd4_fl_lock_expired,
>> };
>>
>> Most NFS callbacks are named nfsd4_fl_xx and one as
>> nfsd4_fl_lock_expired.
> The existing lm_notify callback name is correct as it
> stands: nfsd4_lm_notify.
>
>
>> I will change nfsd4_fl_lock_expired to
>> nfsd4_lm_lock_expired as suggested but note this inconsistency
>> is still there.
> The usual practice is to name the function instances
> the same as the method names. aef9583b234a ("NFSD: Get
> reference of lockowner when coping file_lock") missed
> this -- the middle two should both be nfsd4_lm_yada.
>
> I will add a patch to rename these two before you
> rebase for v14.

Thank you!

>
>
>>>> +{
>>>> +	struct nfs4_lockowner *lo;
>>>> +	struct nfs4_client *clp;
>>>> +	bool rc = false;
>>>> +
>>>> +	if (!fl)
>>>> +		return false;
>>>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>>>> +	clp = lo->lo_owner.so_client;
>>>> +
>>>> +	/* need to sync with courtesy client trying to reconnect */
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>>>> +		rc = true;
>>>> +	else {
>>>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>>> +			rc =  true;
>>>> +		} else
>>>> +			rc =  false;
>>> Couldn't you write it this way instead:
>>>
>>> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>>> 		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>> 	rc = !!test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>>
>>> This is more a check to see whether I understand what's
>>> going on rather than a request to change the patch.
>> I think it works the same. Every time I see a '!!' it gives me
>> a headache :-)
> Indeed, it takes some getting used to.
>
>
>>>> +	}
>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +	return rc;
>>>> +}
>>>> +
>>>> static fl_owner_t
>>>> nfsd4_fl_get_owner(fl_owner_t owner)
>>>> {
>>>> @@ -6572,6 +6965,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>>> 	.lm_notify = nfsd4_lm_notify,
>>>> 	.lm_get_owner = nfsd4_fl_get_owner,
>>>> 	.lm_put_owner = nfsd4_fl_put_owner,
>>>> +	.lm_lock_expired = nfsd4_fl_lock_expired,
>>>> };
>>>>
>>>> static inline void
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 3e5008b475ff..920fad00e2e4 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>>
>>>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>>
>>>> /*
>>>>   * The following attributes are currently not supported by the NFSv4 server:
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 95457cfd37fc..80e565593d83 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -345,6 +345,9 @@ struct nfs4_client {
>>>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>>> 					 1 << NFSD4_CLIENT_CB_KILL)
>>>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>>> The comment is a little obtuse. If the client is
>>> actually expired, then it will be ignored and
>>> destroyed. Maybe "client is unreachable" ?
>> I think "client is unreachable" is not precise and kind of
>> confusing so unless you insists I'd like to keep it this way
>> or just removing it.
> I think we have to be careful with the terminology.
>
> An expired client is one the server is going to destroy,
> and courtesy clients are rather going to be spared. The
> whole point of this work is that the server is _not_ going
> to expire the client's lease. Calling it an expired client
> here is contrary to that intention.
>
> Unless you can think of a concise way to state that in the
> comment, let's just remove it.

remove in v14.

>
>
>>>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
>>> Maybe NFSD4_CLIENT_EXPIRE_COURTESY ? Dunno.
>> Unless you, or other reviewers, insist I'd like to keep it this way.
> I think NFSD4_CLIENT_EXPIRED, actually, is going to make
> the test_bit()s in fs/nfsd/nfs4state.c more easy to
> understand. The transition is courtesy -> expired, right?
> And as you say below, the mainline logic has to decide what
> to do with one of these clients -- it might not immediately
> destroy it, but instead might just want to ignore the
> nfs4_client (for example, during lock conflict resolution).
>
> Try NFSD4_CLIENT_EXPIRED
> . If it's awful we can switch back.
> "It's only ones and zeroes."

fix in v14, replace NFSD4_CLIENT_DESTROY_COURTESY with
NFSD4_CLIENT_EXPIRED.

>
>
>>>> +#define NFSD4_CLIENT_COURTESY_CLNT	(8)	/* used for lookup clientid/name */
>>> The name CLIENT_COURTESY_CLNT doesn't make sense to me
>>> when it appears in context. The comment doesn't clarify
>>> it either. May I suggest:
>>>
>>> #define NFSD4_CLIENT_RENEW_COURTESY	(8)	/* courtesy -> active */
>> The NFSD4_CLIENT_COURTESY_CLNT flag does not mean this courtesy
>> client will always transit to active client. The flag is used to
>> indicate this was a courtesy client and it's up to the caller to
>> take appropriate action; destroy it or create client record before
>> using it.
> I get it: The flag names should reflect a state, not a
> requested action.
>
> But I still find CLIENT_COURTESY_CLNT to be unhelpfully
> obscure. How about NFSD4_CLIENT_RECONNECTED ?

fix in v14, replace NFSD4_CLIENT_COURTESY_CLNT with
NFSD4_CLIENT_RECONNECTED.

-Dai

>
>
> --
> Chuck Lever
>
>
>
