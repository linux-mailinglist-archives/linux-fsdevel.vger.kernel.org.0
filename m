Return-Path: <linux-fsdevel+bounces-28846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D896F6DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E391F236A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCD1D4156;
	Fri,  6 Sep 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFLSeEwH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a8hRQ1Nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7841D1F56;
	Fri,  6 Sep 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633125; cv=fail; b=eAL0isFQy9fa3fKWy+BDBXmA8a5pV/RhyaxD2u3Y1yY95c0qCtXQO3OrSabm1AmoDM3nMYXZC2t9YbG1pcS/ls3t7/p25cd2gACnrd1xE401FKB3pUcnEA90ixMSk7GsPA71IKvk5o6Idn+ZsDV/oBw5Gy8G5O2b5vJNX2X4E84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633125; c=relaxed/simple;
	bh=gXVvCr0eUozVWAMl5I6wDwg8WVdR77JWzDuwdEtzH8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EDabp0hRIUd1MtgU7Zfoy3OOJnQeJYCfriDE3jhyOIg+M+9ZR22XRKtojAHdAyVFjAd+ML++j4BYj2s47ePWnSayNTcVoSRVMLpcSyoHaSWuHhW07CXJMLT7udtPoI3kc4wAWbIYgBTGkVJLp77/3zl5WwSWKKnAuo8LNe2S61o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFLSeEwH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a8hRQ1Nu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486DaR3B005599;
	Fri, 6 Sep 2024 14:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dWzkvkKaDzBpdv5xnTGgwa4nzCqjJhFi6tDUXyG325Y=; b=
	hFLSeEwHvWZG/ynX3o83fDTxsM60OV5a2SI1xcb4ya5Qq3Mq+sSB35ECeG32VcQ1
	7L275MtW9J8unSm9Bdc6AkZWQztZ67tgSFS06K21vPB/PoGzqSEtcjs3igm+O6XN
	l4aeXK13AkxFKT45p52W+gjdSe101BRhybnEDH2Qmszaq9G9/2JfZqOWnqp75Eju
	9zXNaDA4ZNZ81U40YkMX52N9jj90TRhqS2/bx9VUtVD9Vjw544czvC+ELEvnsps7
	4UfZA+sKCVi2l57J2aMy4vVj1DhZQheK83sDCq7XwWdC1DE6HbecVmDmuYpabx9C
	/+ylL65D95iKyTGLxtPGOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjhsjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 14:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486EKGmL037084;
	Fri, 6 Sep 2024 14:31:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyg0t90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 14:31:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMooQbxMxW8PYqV5/ivBwUCvacaakO2TilhcweabAB5AchHKulvyLMpd6LVPpHoIHBMurywJsSSuE9kT0Z5ZAaKFg33u9AZ8PoJj829FoG0SG8I4DYp1ZpzBYKi4zeprll2wyQcYptzsYpum7qcc+85CX8YgIS70IUG0TiKXdFRBcL+UCxPeTDiIJT6aY6WOq0fd6ZaAnDELJBwuoMGg4qRwo2PpOmb0R5EFlDGyqyNn1IlNgn2g4Ve6FkXXINjnEbbgEI0KY36VFBsJ2ik8eCTdNFmQQa+xKCf64YcvtPKzVQ1pS5Lc9TpOOgmrqGs68XNL1eSUwqLuZnASnMeJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWzkvkKaDzBpdv5xnTGgwa4nzCqjJhFi6tDUXyG325Y=;
 b=DSzuhekDY5X2xsGqHsuX28Pl1ebtbS7ATKU7BD8RSk9H0ISAqIO1eVRFndsFpwyMbu9y6Z58XhbQOGY4SDmni0D2KoOCRdVjO0UU+tSknTn5TBDGU0bdg8FJ4ohj+FDmUqsH5ELP+m+GT2kSJSZjz6ML6rJRTV3z16UDvZ8arQkk7Jt/LkOWzwlF0RApvzCXRsuD/VjWsyoCpF911dfSAIwMbjOy+Mm8J3AKxOlWCKnQ641wjl/DoKXVvFHHABgB84FumAmdtSFmzn2r/yIrN8Jx5s7ljNu4QO83WQab/r5/gHcSywroe4s2inYG7d2vroZ8IUZ8GxBmcvpOWPUClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWzkvkKaDzBpdv5xnTGgwa4nzCqjJhFi6tDUXyG325Y=;
 b=a8hRQ1NuZK7hOnrJRuVPiaXZVC2WJo1D0Fd8wKtenmlXyn21Dg2Pkjk2TsBibh5A+XPZP2x8Fny8VWyormtZAvGdSt9Qul0lhvdiDqcjbozgrXK4bcLlSm9m6gEpDSAhZNFM9q0P7OXMztN70KSnvgOV/gvB4t2QZM26kU/L7DM=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH7PR10MB7837.namprd10.prod.outlook.com (2603:10b6:510:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 14:31:46 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.7918.012; Fri, 6 Sep 2024
 14:31:46 +0000
Message-ID: <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
Date: Fri, 6 Sep 2024 15:31:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Ztom6uI0L4uEmDjT@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0182.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::12) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH7PR10MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 81227381-1dbc-4c76-4e9a-08dcce80a2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE11ZVUrcGtuOXVHRFh6eUdCSUpGU1ppR1ZaNEFxaWdNYXJpd0ErbTdhTldD?=
 =?utf-8?B?U2MyVUNkYWdPK01TSEJ4dXlGNmZRREg0bWZxN3JIbFozR09hSmRYNVZkeTZ1?=
 =?utf-8?B?a25HdVdkVWxYQlh3YnFRdDFFZ3poRTg1N0t5NS9YWVFMRW1FWWdZc1JSODNI?=
 =?utf-8?B?NTZvTUJKY0xlNVExSW1IR29FVVhFUE43ZE9aWHNGOFBGeml3eG13OFBMdElJ?=
 =?utf-8?B?OFFTU2FWeTZvZzkrNHNmYmx3akNJdnVNSU5wcDh0S3pPL3pEOElEdWQ5bktQ?=
 =?utf-8?B?bGQvQW9EamhNREZjUTU2dkI3SHZmNVp1a3hHdzdRdmdJVDBSczMralZQUTZw?=
 =?utf-8?B?Z3ZCWGZJOERLMCt2Z1d5UC9UcDFRSzBqWjZVTFR4M21iRm0rMGRENjJ6QUtw?=
 =?utf-8?B?clM0YU10RWhjSHM4WHhVM1Vsdmd4L25xY1ZxRFFNbmNFeHFxMlRRemdWS3pD?=
 =?utf-8?B?U0toeS9hZUowR3NaNEkzS2xhQ3h3bkpPUGFoZzlVUzE2SjFnNHE2NkJKdDA0?=
 =?utf-8?B?bVpQQlp1WG9ZbEk5TUhueGsvR2svNjhrZGtsQ01taFpIOXRSTE5nMzJ4UEp4?=
 =?utf-8?B?RHpNYTNNOVk0ekhJbjJibmVPYUlscXBCOFJISlVRRFdGbW4vZWt3WUx2dVBt?=
 =?utf-8?B?a0ZGc0FITzk0S2ltNzZLYjMwcW9HcCtJSGZWL2RTQXhtVEJWRG9wT29wVkZB?=
 =?utf-8?B?WXRBbnFCZi9VSU95YXJ6dkg0NVRadVAyRlhtczFHcitPSllBOWxuL2tqM3Fj?=
 =?utf-8?B?SHJjUGlDMU12MTI3NU5jblVVRzRlMVpIVUVWM05id2tBZDQvekx5UWY5VUJx?=
 =?utf-8?B?RWlWY0dIbnQwcjU4MlhLN1FPT3NsREp6cjVYSGhqSndObE40STN4LytWVGFm?=
 =?utf-8?B?aWxyZWo4eG5KNW9xMVAwZjhuaXBRNW1hNEZIS1RwQk1rcHcrMTllVzVNZjI2?=
 =?utf-8?B?WWpCQzdjM3dxdk1TdlhtVE5aT2N2RlNqL0xWVnc0OVF5UVdXdWQvbDc5Z1RL?=
 =?utf-8?B?YXFtQjJ0WXNKcUU3MWtLSGVnNGwxYnV1VnpMbXQ4VWZwK2R2UjRCR0lqeXlQ?=
 =?utf-8?B?Qkk3QmNUYkhpQlF1N0t6TTg0RzJmZDV0TmsvQ1QyRDZQQkVoaWF0TklGMTNC?=
 =?utf-8?B?Z2ErR002YkRKalh4WTM3VEUrcHFNYTlkUmt0T0RLQk15TThZaHRKVjZVSlc0?=
 =?utf-8?B?bTY4dUs5dU93Nmh6ZWVZOUNPVmVMby9DZUZGMmVKTnprNlVDWk9Jb2VhYjFT?=
 =?utf-8?B?eEo2czdmTlRCMG02NXpOeTd5QVQvM2FlZ3gwclZQU0dmei8zU09rZHladXVQ?=
 =?utf-8?B?T2JKRThrUTVRNUNFYWJ2TmoyN09ZdEJIV2JpQnFVWVVWZU14YktySmx4TUtC?=
 =?utf-8?B?TjdqZlczWDZOVXNBUENTa0MxL2I0c3U5VzE0YmpseS81ZDZYdFJuZlJQUGNk?=
 =?utf-8?B?N2daaGo1cE9Ob0RmS3VpRnkva2JaRFRGejFRZmZBVUJXdTBtZ1RhRVljbThV?=
 =?utf-8?B?Qks4T2w4bWFrcGRSQVc5M1gzUXZabFN2bWtWNm4rVXZUaFhuRzlGNGlicmNy?=
 =?utf-8?B?L3hva2ViRTFkVjZFU3dZNm90UW5KRTJrdUhYU3M2VEw2bjloRThmenF4cmY0?=
 =?utf-8?B?bjl1a3ZCVytOZTVYdVlDajVYdzF3TmU1S3QvQnV0bWx5blBhWVY2eGM2U1Mr?=
 =?utf-8?B?SG5RbWxLUDh0dDVubnZWNlZpc1JsR2krQlRIZkFVWmM0OVlOcWlzUDFrWkVJ?=
 =?utf-8?B?NW5ZUXJRS29mRElabGkwVHVHd29VKy9BS1p1ZlVWOUg1bHY4bUp2TE9OWkJE?=
 =?utf-8?B?WldzTUhnOVR3QW9VbUxyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRraGFRYllFOEFjWVNJcVF4Q0U1WGRMWFdhWTRIZEtXeHo1RmRkYmQ0c0FH?=
 =?utf-8?B?Yy90ZXlkRm1IRm1KdHdxdm9OU0ZoMHFTWXlRSUJ4L2hCaTFUM2xtL1dHN2x0?=
 =?utf-8?B?NTY2NWwrRS80bmE4aEEzN1FFT0lQNHhybC9ZUGdZdy9OeFVTNWJSQzA1bVI4?=
 =?utf-8?B?MzRCM2FwdzhiZVBZbktsdDI3eEdBcUxzUWNTb3Y2RWlsdzdKVWtJOG9mdDFj?=
 =?utf-8?B?U1ZrQ3RCSi94d1p5MmZJVUxUdW1aYVZjNElHbTQwdHFIT0RaUkNEWVA0SENP?=
 =?utf-8?B?dDZoSm5mcHFoKzdvVU0vbnQxeTd3NWl2bTUrRTJjS212bzdHUlVPOEVOYXRQ?=
 =?utf-8?B?ZmNsVy8rd294MkZRVHhYb1J1azV0emdYL1pBMW55OERYZElDZmg0M3c2bmxI?=
 =?utf-8?B?YmF5VTUvMCtJSy83US9QRGkweUNLcjYwQUM2ZXdJUWcrU1hjNmFqb0NIZ0ls?=
 =?utf-8?B?S0praDNhcVVnY3RmOStzK0hWb1ViQ1NtUzloTVZrSjZvR3dYV1VjMWEvZGJF?=
 =?utf-8?B?NkpaaWovR0FuZTZYakRic1BQZnpwSEVIOXpTbGNDNStPclMwVC9zWXJwdVJz?=
 =?utf-8?B?bTNXZkJHNkU4aDRLY2lCOVNuOU5TS0hING5oTklXckdKVENnYlR3UUxWUk5j?=
 =?utf-8?B?NXQ3NCtvcm5zZXYxMFVuQ3I2alM3cUIxcU4wSjlHRFVxc3d4UU82OGFyNEJE?=
 =?utf-8?B?bHRmbklCbEJZWnlydTZnMDRWcWhUWHdHd3Bvb09BNm95bjM2NHk0bk52a0pp?=
 =?utf-8?B?UjVYZS9RYVdiZWRBaEY4VHVtZThZTmU5MWFubk4xR1Z4aUdoWjEwT1lkNHVR?=
 =?utf-8?B?c3h4V1M1WGtTcXBsdmZQSitYQmE4b2lra3puRE9oY09LcFZTUS82NGZLT0Vr?=
 =?utf-8?B?Qmg0R2IremVwYW0zSjhWYm9VWkJXQnFINnB2ZDN5VHQ2S3plclN0U1ZrUk9T?=
 =?utf-8?B?ZEpZTklIRy9FYnlzK2JtQXNxcjJ5Y0hUSkg1d0xxMUhoZGJvQ2FleWtLKzZK?=
 =?utf-8?B?OGpMcThGVzBMN2Vkc3hSQTFnd0xZTFFoTTBFSlFIVFJVVGMwdWRBNWRFSFpP?=
 =?utf-8?B?L3JHUlBIVUJBMkxwdTJ1U3JBc1IwNVVEOW5KNjF4aVZTanVhNkNQZlA5djBu?=
 =?utf-8?B?YXAvSDBzUHBaMElzSGs0MmFPdUlDZExJTzN0b2JTRC9SNmVBaDBJSkNNYmwz?=
 =?utf-8?B?UmxXTnRiZGQ3TnRZT1JYNGx4b1BzQVBKU2hJR2d0S2RDcnJZWnBCc1d3NlFZ?=
 =?utf-8?B?M1dNMVllUlN6VlRpL3UrS2cyM3hvZ2duTnNpUUZmZnVQT3JWUUU4WEQvZ0Ew?=
 =?utf-8?B?UWlPYW9XWFh5R20vZEI5RjY3c2hsNkluV05TYWZzU2dXVERVMHFOUk9XTUJT?=
 =?utf-8?B?VG1sSFZSVWRlUzhnZWJlRW1mTUJ6MkE2c0NUampaRWRScmNWNTdhaHBkZVVy?=
 =?utf-8?B?Vkdwbm5XakdDYkI1LzNTK1A4TFpWR09UZDhhOHozMlo2Y2lHUXhIb1J3ay9n?=
 =?utf-8?B?MmhWYXM3cis2YUIvQWt1UUFlRHM0ZEVqTVhrMExHV0ZkelVyV3dxV2J4T1RB?=
 =?utf-8?B?TnhaTlhPckl1UHFwQW8zUUowdjFUTHAvVDZnUjZvZVlWSTJTNTJFWTc2UDhl?=
 =?utf-8?B?bXdkVmZhZzcxUTZ4QXJQRTA0cElBVUZLUFkzc2tXZ1cxY3pjUjZNQ1hoa1E4?=
 =?utf-8?B?bVhkVlJDdlBPWmZ5UXpCaGU5MHpPR1pubXJ1aDJ0UjVJSG4xaDRaRjVpM1ll?=
 =?utf-8?B?bFNYZzV0MmNneG03OUp1RHpOZGQvN2E5MW1NN1NDUG9oYWx2Qk1hWUpFaitI?=
 =?utf-8?B?SVF2UExZc210bmM4L3RIS1JGcUNaZVR1aXNSRkhjbUw3N25HKy9CMkxXM05D?=
 =?utf-8?B?a1ZleEZUVWtRYjNTdE5EN0dzVG0wZHdhZklvQ29sYWFhZy8vMm1GeE1oblZ1?=
 =?utf-8?B?MkFBdUU5YnRXbjZCNzRjWlZBdTVkR1ZTNkI2Y1VzMkxYczlxazVRbnZDRG8z?=
 =?utf-8?B?M1VKOFZ3QzdjS01uazhSOHI1S3F6ZEd2MjNLTnMrb1FhTHIzWlNsNHlHTm9p?=
 =?utf-8?B?WHJ1WHBhdzhSckFiMWdjQVVRVEJNeHFyWmlGejg4QkwzSVlJcVRnbkp3QXhT?=
 =?utf-8?Q?RiaYR7zlDd/ywc4MlQFE7/8gp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	clrNr8O2lOyviMAzCiUKMydlTK0sZJjaP2246F/eQltebuREHqRtyL/phA5HmC3loGziElwK26TlDxJx2A2NCY748/fP1MZravdGxlYoEUgD/VvCC7qH1f+r/jaHUEjb4VE34pevhlMNUu9/80fo2qeEjnxHZmGEV1ezgDyQVxEILk3yVzrUZhFlbaPnoZDdJ94sLBlnAqir0QUoxPAi+pu3gznPYlFBYxuM18D8DzhKP7YrVlehfEgKwxO3bZrej7tavDg8qjed59ClcL6xOOETJWFFo9GeEA06tZIvh0JrbIcX/dK1OWRX6mMknqplzj2IzFlii6zNCE/BbLVZYV7B444KFIfqKnFlmFF8KXekABeOzKYlFD2nA50p6v4nHJ6RtWZ6QqGsgeLocsAXDZTZRpaRl/Cr9jX760ZNLYR7yBn3EET3K07Shr9S4kebGadnWLcgmH4PuAFLmtDSAd9UYiVA6kKJurebFvrv3ygyDfow3UunP7UMPtVEiVH+CSNuPOSfn8lWpyRvS8LmxHLTkaU9HipYecWX8PFxfaD+e2zkHSdZrzBz5+zbjitCkjIpEMq3c1HBpyh699WSOBp44Ji/JTfQUyv6+uZ1l8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81227381-1dbc-4c76-4e9a-08dcce80a2f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:31:46.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPuD95ZgpLRMVUENr7jCQFOMRoIFwM3eD0SUqnqH33vLiWfXvAozl6s5oAASbJWbCvAIfZLyPF53uYImnUU0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060106
X-Proofpoint-ORIG-GUID: aR6VhXnAmwA8PE7shlwWtkePg7JqPsD8
X-Proofpoint-GUID: aR6VhXnAmwA8PE7shlwWtkePg7JqPsD8

On 05/09/2024 22:47, Dave Chinner wrote:
>>>>   If the start or end of the extent which needs unmapping is
>>>>        unaligned then we convert that extent to unwritten and skip,
>>>>        is it? (__xfs_bunmapi())
>>> The high level code should be aligning the start and end of the
>>> file range to be removed via xfs_inode_alloc_unitsize().
>> Is that the case for something like truncate? There we just say what is the
>> end block which we want to truncate to in
>> xfs_itruncate_extents_flags(new_size)  ->
>> xfs_bunmapi_range(XFS_B_TO_FSB(new_size)), and that may not be alloc unit
>> aligned.
> Ah, I thought we had that alignment in xfs_itruncate_extents_flags()
> already, but if we don't then that's a bug that needs to be fixed.

AFAICS, forcealign behaviour is same as RT, so then this would be a 
mainline bug, right?

 > > We change the space reservation in xfs-setattr_size() for this case
> (patch 9) but then don't do any alignment there - it relies on
> xfs_itruncate_extents_flags() to do the right thing w.r.t. extent
> removal alignment w.r.t. the new EOF.
> 
> i.e. The xfs_setattr_size() code takes care of EOF block zeroing and
> page cache removal so the user doesn't see old data beyond EOF,
> whilst xfs_itruncate_extents_flags() is supposed to take care of the
> extent removal and the details of that operation (e.g. alignment).

So we should roundup the unmap block to the alloc unit, correct? I have 
my doubts about that, and thought that xfs_bunmapi_range() takes care of 
any alignment handling.

> 
> Patch 10 also modifies xfs_can_free_eofblocks() to take alignment
> into account for the post-eof block removal, but doesn't change
> xfs_free_eofblocks() at all. i.e  it also relies on
> xfs_itruncate_extents_flags() to do the right thing for force
> aligned inodes.

What state should the blocks post-EOF blocks be? A simple example of 
partially truncating an alloc unit is:

$xfs_io -c "extsize" mnt/file
[16384] mnt/file


$xfs_bmap -vvp mnt/file
mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..20479]:      192..20671        0 (192..20671)     20480 000000


$truncate -s 10461184 mnt/file # 10M - 6FSB

$xfs_bmap -vvp mnt/file
mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..20431]:      192..20623        0 (192..20623)     20432 000000
    1: [20432..20447]:  20624..20639      0 (20624..20639)      16 010000
  FLAG Values:
     0010000 Unwritten preallocated extent

Is that incorrect state?

> 
> In this case, we are removing post-eof speculative preallocation
> that that has been allocated by delalloc conversion during
> writeback.  These post-eof extents will already be unwritten extents
> because delalloc conversion uses unwritten extents to avoid
> stale data exposure if we crash between allocation and the data
> being written to the extents. Hence there should be no extents to
> convert to unwritten in the majority of cases here.
> 
> The only case where we might get written extents beyond EOF is if
> the file has been truncated down, but in that case we don't really
> care because truncate should have already taken care of post-eof
> extent alignment for us. xfs_can_free_eofblocks() will see this
> extent alignment and so we'll skip xfs_free_eofblocks() in this case
> altogether....
> 
> Hence xfs_free_eofblocks() should never need to convert a partial
> unaligned extent range to unwritten when force-align is enabled
> because the post-eof extents should already be unwritten. We also
> want to leave the inode in the most optimal state for future
> extension, which means we want the post-eof extent to be correctly
> aligned.
> 
> Hence there are multiple reasons that xfs_itruncate_extents_flags()
> should be aligning the post-EOF block it is starting the unmapping
> at for force aligned allocation contexts. And in doing so, we remove
> the weird corner case where we can have an unaligned extent state
> boundary at EOF for atomic writes....

Yeah, I don't think that sub-alloc unit extent zeroing would help us 
there, as we not be dealing with a new extent (for zeroing to occur).

Thanks,
John


