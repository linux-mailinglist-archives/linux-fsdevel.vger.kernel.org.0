Return-Path: <linux-fsdevel+bounces-5909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569AA8115D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A09282773
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2A30CEC;
	Wed, 13 Dec 2023 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QulKjfwk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rnj95ZPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D17B0;
	Wed, 13 Dec 2023 07:10:05 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDERBp9006290;
	Wed, 13 Dec 2023 15:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f62rBtoB0l4C/RfzWe2QQjrskkz8oZsnk2LUnqf75Q0=;
 b=QulKjfwkh6ghx3htaVD5H+iaE9d65yBOC4T4ZbShAOm+8/KO7YdrSWHn5iEz/F91SW70
 ABqpdiYVJW7Bm2G7hCmD/2pFcUpkyfVrwImGZGRK1ZRe7mHBEZjYJzDQDh0fUiJmDoXs
 msgDro8KTYWAs/vGIzttPchSqYrZz6cNLyejyvfoz2OpkpNJRe1fLZyfrm2dRCz2Nq7R
 ekUq1+Uv55S/+wHmUciTz0W9Q3hGyR1rdu5ECoO+/ePM9TUugKqDJIgMKm5vj9Ty8ycT
 Thnx93ackS0NV6fmdiqParV0+8zKoauhHRfWenf3M8780RJLWX/HAh4toCMx0k7BdqYI cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d8h3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 15:09:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDEhQw6012799;
	Wed, 13 Dec 2023 15:09:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8dx9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 15:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYza6yKXClZqZ3qJoJEceBhqMfwXVJld93mtXP2ES5Dq95FbdEsX8Yz63Pl8npVmwz6wldKKuoyb6EU2R5O3MwMe8EtCm/nnPTGcKO/FsXzxjoMvkA7b3ChbYgr0Ktz59Kzc0gbJYNO/t7K38rrgEMqPF+Ed5dNxZaeYeijudgKC/53HF15PGap20AWkvuJR/INz5QXn5cvlOnJjO9dRbekm06Ma2z5mfjXOQqcZFxgBzpROj1uiLrEGs/IB7bNSL9IzNr+E+/sNU92Ha8xrMORj6OsiYx8kajqW21tYe/5XnD+7NaxepkHmOL9AbU9e2YXkjF4RiQAvyexcDu9cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f62rBtoB0l4C/RfzWe2QQjrskkz8oZsnk2LUnqf75Q0=;
 b=FtzjA7Rq5aEZbqJ/1C/6d4Z8ElAmLagNRaHZxEdzsX4/VwWGeFnEL75Lg6EnRRZfIAXgchJmmWREY0tYPHcRsMAFK5obug+/WVvxMwpGBN6iRFqYFonyVH7vH9/vG7/wbLQzau4S9xTNbyVtDDxvkfEMH0TmoGY/1UF5ly15wGvxhO3bue0LMYSp07JgScW+pE188WOkJrObPwOqwY2yi7EPN81M5Gu7MQEQSdkY9i9Ucb5oqSCkSK2O4uLv6yEKU6soPTe0Wxg8zhrBxKdZ+HO+GcTkTpOuAe5xIIjV30ISgmXW+JK7YTLI9SKhMxwu0cLh3TO2xRCL+B9zldoQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f62rBtoB0l4C/RfzWe2QQjrskkz8oZsnk2LUnqf75Q0=;
 b=rnj95ZPAkIHuXcuOYzusFqMbOfaFcue/6vllDg0w0foVG9UzMIn2g4VOq2o9d8DXmVH+BjMHHk90NbLBtkO01DKI55OxX98TUTNp3blDP5Ri87UKOL1DJXVK4krrNnQYVHciGIBdwRAK+dEpioDsUgJUbJmA3l64SKfK7kYYAsM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:09:39 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:09:39 +0000
Message-ID: <e07c1f0f-19e3-4af8-9d57-fa66d50edec2@oracle.com>
Date: Wed, 13 Dec 2023 16:09:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dcache: remove unnecessary NULL check in dget_dlock()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Waiman Long <longman@redhat.com>
References: <20231106134417.98833-1-vegard.nossum@oracle.com>
 <fb2cf7c5-cced-4ea3-bf5a-a442a0e64bda@oracle.com>
 <20231213150515.GM1674809@ZenIV>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231213150515.GM1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0067.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::12) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BY5PR10MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aeba598-1ede-4f28-152b-08dbfbed86cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QbkzUEEjSPhuLOj55mF2hrOURjeTrBLAeIlTzWuC+BaKMpUnJ6gKTSn2ktjn/5NZEgA6ntRytS6Ryn08EMQ9VBD6hHYmkOBhnCgNJc1u5wffZVvz6KpM+JQwgUnn0kz96YFGwCuz1Uv/DKlh+mkinrvMo/HetrokDvn3DP1L/FtUWCoNEmP5Zi5ryXWR6AyVCbj6+t8Xggh4HG/MHjv6SSXMhysToepJ3vlyVSACWg+iSFEnyk0esJYw6VaDFFEz/ZwGZ9joWoLDO1bdoyC1vflpdsoUIy6kYIDgl1StkTqby+/8h6zGeR6hTWFpIVfehwE7IDNVWRqSPHHTBCIx3rkd2OFD2u0RAjNf2oXBqXyHOlQjA87KnE9ERVygfx/9Pr2/xtOYSqAVDNqZ+58qzxt9PFsz6Ct6HdXIk7rwJag/kY5J0lAMFRWJmrveyoJU9k7JQHZwxOXBIlgX3r8Didq2i2M9Gzmo9Scmrtn2p3niHARsoZrhhX3HfjaALeOv0KsaGZivfmNHMeuEVazDM0QIJQN9A44uqxT+Xg+TgH17Sbs9u6jO8AOKfwk/iM2zK49K3fE0XTBWHdyFVv5i1dnmgsh2Sf2E5fIq01NTWzo6dAiQLL+bH9bl2+VrQwZ+o4QUpjYbbIYn0pjfRGUigw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(2616005)(26005)(6666004)(6512007)(6506007)(86362001)(31696002)(36756003)(38100700002)(5660300002)(8936002)(8676002)(44832011)(4326008)(53546011)(83380400001)(66476007)(54906003)(66556008)(66946007)(6916009)(41300700001)(4744005)(2906002)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVJKa0ppanBEc0dHUDlGTEVwdVM4K1NTVDk1cmE5QXhGSFdSUlNETGkvQXpC?=
 =?utf-8?B?U05mOGh3a0RPbE9BWDJrbDRDVnFqenpQQTgySk5Hby9aK2kxQkVhNlRRTms2?=
 =?utf-8?B?Vnh0RWNEUjVwcDg1d3U3bkNDdS9sYldtZzJrcnlqc0VkMmR0dDVJbm00Q0ZC?=
 =?utf-8?B?YzBueHNNZXN1Q24vdS85a0Y3cHNaeTJGNEs3UHAyWGVMTE9HL0FJZk9SdmNR?=
 =?utf-8?B?K25URU5CMnduNlRuVndwTUduSVpwUUFVK2lDQVBoeWRGOFpPaWFXc1pBNzYz?=
 =?utf-8?B?b2ovbGFIeWFPWWRYMXRqczNuYlo3b0lFWlhhdllXb2NZTlZocE5sN3pjQ0di?=
 =?utf-8?B?bFVwTXFQVnpYaUVVcGJKY1o0bGJBU0tPeFVEUHNWaUpJWm1KVFFEa1BOZ1FM?=
 =?utf-8?B?ODdhbmVOZnJ0c0hqSXY1dEhGM1FPRmV4bFphQU9oTU1xUzNHR1F5ZXFvdUJZ?=
 =?utf-8?B?c2J5UkdKanFROG1Tc3NkQWRMWHp6d3FlTFE2TzBGZkpicVJlem1MbUVIR2VW?=
 =?utf-8?B?eGtMN0hyZFEycTFRdUxyWEdMZXJyR3Z0Z1dYbEF1bDU0bGtrQWRIc1hzL3Nh?=
 =?utf-8?B?OHQ3VmdHQ1dYNlFBRVcrSzF5TXZzanBvdmhTSVBUZjVvUE5LVlpxTEsxdm83?=
 =?utf-8?B?YXQzZk9WbVBBQWF3Ry9wLzBPTDF3ZDJad1RNcEdyeWdvd1hTVjN6UzZvSTc5?=
 =?utf-8?B?d2dUV0tSQTdUUzJOUHNCTGtCcFlHaGVLMnFQeTRlakwwNjhsV0duSkIwbyt6?=
 =?utf-8?B?M1BoZm5ReW5jUDBsdi9mUytBNFBoUS9INGs3Q1BVK0NwY0NMNGVQUWpqUlN2?=
 =?utf-8?B?OXZsQllsNTU0bERGVGNDZFozdTIyTUx3RU9MUDVXZ3FRMzJkM2ZzcTdyWkgz?=
 =?utf-8?B?L2ROZUNmVW5zUHpsMDJCQWl2OENOMVZwVmZEdWx5ZHVWS1FEbG1YcWluMUVh?=
 =?utf-8?B?NXlaTWptT1IxTGNCVmE2WTd5QUxrcXlXV245ckhuZXlTS005K05DRVAwSFlr?=
 =?utf-8?B?Sm9ubUVvK3plRjJxWVpEdFhaeUo0OVMyaXpIbmtmRGhDdVpXeUVDVGc3aUxh?=
 =?utf-8?B?bHZCbWxhTHMvR0hBbXdRUUxEc00rVGMraDVVVDVVYitQbmRVWDVkb3piZXFG?=
 =?utf-8?B?anpkemNoQ2MwcVAxTTQzNFI0em1aZWQyenNoYmZZeXdtcXo1cEZnYWJtMkhQ?=
 =?utf-8?B?aFdaY1RZNExMeEExR2s5bnpGcjBMczZOV2xiaXN2eXpxZFhlYUxlTDNVd3lO?=
 =?utf-8?B?ZklCTU9yNk1Lcm5ES2pqWk1nSml4WlRyWWxUSnlFVEg0NXhXcmV0cklJMzdD?=
 =?utf-8?B?RUd5MFJtWXVJN2FSUTNNcHZxWHEweDY2dDQrc1BGRTNJSWk5V2RxVG12a3hY?=
 =?utf-8?B?cmFpTDQzMGtFa3hWdzFqVmovakg0amhjRExRNC9TT280TTZaeU9oWkZ4M21v?=
 =?utf-8?B?UnR0bmd1azdUcnpxemREYmtYK2o1cFZtMUhMK3lkbXVDclJwa3BEb0hNOGt3?=
 =?utf-8?B?N05FMGJ2Um9TWEtYQzh3WkorTEEwTkZUbDRnRUcySVcvZW9mVXFpK05pREgw?=
 =?utf-8?B?ZHhQUGtQNWZoeVMxNCttSnQxcEthQmQwZDFwdEtJU2hoVlpoZXowZUl0WkxP?=
 =?utf-8?B?RGlVOGdpclN2U0VwYVhUM21ZV01tOFpVWGNhWktiT2lGc3FEZldVcHdRT1d2?=
 =?utf-8?B?TUNvZGZ3MnhOQ0E4a2daUTU4M2ZMUTRacVNjWGk5QzBMQWdDdTYvYXV0OEdD?=
 =?utf-8?B?RlhBS0NkaDJHY1REQ0p5YTNzZitoT3ZhdHAxdjdHQWQvQVJ3NzZrQytPc21Q?=
 =?utf-8?B?SnAxRmY4QUxOcisyci8xR052bWtEUHJmUklhSTlqcGtVVHp3NnY3eXNKdnp6?=
 =?utf-8?B?UnVZUUZsY2tWckRCdHNzZTJzaUxnak1PcmZMZUJqUWY0bDliR0hhcmI3L2hE?=
 =?utf-8?B?YU4zbU11N1htUEozLzg5QmNXTjdDbWQ0aXdFeHlsbCtpakY5TDBJQk9vNEVX?=
 =?utf-8?B?RC9IcmlZMlllV3llc0JrU1RLSlpjbTUvWWxwODBrcklGdDA2UitxWWdKZXlK?=
 =?utf-8?B?eExXL2Z5YTdKVHA0aVQ2Mk5RVkxoL1BKb2xUN2phTXhKbzljbGlpRWV6dmdT?=
 =?utf-8?B?SW45R0hqR2pPVXR0WjYwVW9jbDNXRHdBY3ArWjhsOUMwYmx0Y2hJL3FFWFVO?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OIYYa98gxUZcWBTrHvqQs+E9M6/A0jguMOv7OGsauK716Jsu6BUlHcf3kYKYFI3k0La9AKIIyF52RD27oHAi/c1h9D2JHsKkyMW8RpuRTEPOprK1Kw5Npnjz05f9HWPcGGgWINnbuGJZ8yJOxrXuDdGCXVWYlj/gJeW2s8HaOoYOqS2UCMdq5ql0GLYOQ6EI4EKwTJLjp5eBgyaY//hnC+VxMZilu0WRzQ772s4KwVdj7aRQWbGQi7JfBkP+rZ++Mpfm9ajNjY43eAlNDDp5jVP40ZXDIBoi/hwa6DspNdbOOqsc+6/PZzvZkYeJ//5jKo6KRUIvpDiLsa+zYT0+UeyUj1Vq9RQUtyRXyI4k2CFK6uEFc3Ut57IZZYZMGspT0aieJWlEIhoLoXZ0QZN7UoytGFVlIliG+tO6IEadSiiKkf0eNtdP9Mz/q4qCHvjA+/w7rpxfSMTQ6NFyycpF4Rqde0OnnzLv0jJInaKfUocnojCm3b21DcHQeY28Rx4oE39rsVlbOQYkVhUuUyjPb+ts+F25e6clmNwXJwmRBObWhLF2xfrnJIMIZyPXirOJOLciOORxUfP1Ek1YiYKRzAVPqTMwgpdFYpRnMrQKnrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeba598-1ede-4f28-152b-08dbfbed86cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:09:39.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXddW0efT195ZdC8qn3raWBSpxwB1XB6giHZdLRt8mABULuHbTcUDuC54nudd/LvsXqZ+HK+KJY7HEbtNy5Im/Rqn2WSq8pYn1SEEhNcxkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_08,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130107
X-Proofpoint-GUID: TlbXwvn16BZpFYVmxwm-UXylbgsJTYRI
X-Proofpoint-ORIG-GUID: TlbXwvn16BZpFYVmxwm-UXylbgsJTYRI


On 13/12/2023 16:05, Al Viro wrote:
> On Wed, Dec 13, 2023 at 03:40:33PM +0100, Vegard Nossum wrote:
>> [Fixed up a couple of bad addresses in Cc]
>>
>> Hi,
>>
>> I didn't get a response to this v2 of the patch below and I don't see it
>> in vfs.git.
>>
>> Was there something wrong or is it just awaiting review? Is there
>> anything I can do or help with? I would be happy to try to review other
>> patches if there is anything outstanding.
> 
> commit 1b6ae9f6e6c3e3c35aad0f11b116a81780b8aa03 (work.dcache)
> Author: Vegard Nossum <vegard.nossum@oracle.com>
> Date:   Mon Nov 6 14:44:17 2023 +0100
> 
>      dcache: remove unnecessary NULL check in dget_dlock()
> 

Ahh, there are two vfs.git -- my bad. Thanks!


Vegard

