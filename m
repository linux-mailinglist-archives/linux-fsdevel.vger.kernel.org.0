Return-Path: <linux-fsdevel+bounces-50931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945FAD1351
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F603AAE39
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DF1A238C;
	Sun,  8 Jun 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQ34eew8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PdxyawLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E8156F3C;
	Sun,  8 Jun 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749400181; cv=fail; b=oWZ45AvCKUMg+FTKYUgABEKdvBhTaV3rLSiugCs3LAb65KWaR9DN/WLIn78svTEAlLVXUJGv/cSXvCxemEiV30YECYnxvJsiSW4MO9Rn/aVhVoeN7UvPCwNEXBmXkkF1YU5O/aWJws9ksZ9P4RwJuLNkG1M3X0fpIUFypmT+KYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749400181; c=relaxed/simple;
	bh=UqUV5IEBBQsfxAjT48CJtxJNZprVqQadMpHlJSKunP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YN8lupXI9c5ogiSQECeDJBlcGHfMJNuN1qVnDB0pVujMK5G6AMFyGNoOxhWiU0YhJxone6C9I8/En/kCNRjOH+/nVu3Q/pDuN5WoA88M17+BiEWTnFx/3bTcTQcaFhN2fPkHgbDY7nQ5UpqSeV/ZUrnhfu4zcod84RJDnLy1JPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQ34eew8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PdxyawLd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558GA1VM007335;
	Sun, 8 Jun 2025 16:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EuVOSe4lciZOEZX+nCevFDlYZJXieS18oj5t9FllZsU=; b=
	lQ34eew8jPBGRS7ORkKeWJdLPH6rbVdwd/16kRlfiiL+lnuw25dEa9pRmdKhfELh
	zdeEKwYIGVqCbFPjko1dwqRJJcGR3FF5v3TrP2aEyOX5kBOj9n1VJfRifnt3ToE9
	w91mQlr/UHBwPVwrTS393b7AKdHOW0rPvyPvP5W58hlu8196Dnw2BESH6p+GPMsA
	fyXAKLObSzxOEpAXfrgIKMsdffVBpcWdL6HuXgesHiD3rMXb3bpYQa4NIUCd3ZYW
	S5C+gRyX7IxA0f56CYF3hZYQZu3wNlxEzUJipSS9N7OA9KPFFeOsxKnC0l3TzRw/
	DUkWWOw3GXln301Svcke0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v130q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 16:29:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 558G3NXj031931;
	Sun, 8 Jun 2025 16:29:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv6pxxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 16:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCFUsNNFFlROVcGcrs/0+LnreuIjeNOe/LZ+iw/MkQVrq44QnmMqwMlyrp4zCnbwjkY06ufIWk3+Oh1kDlVNgVFN8Pem/jEFHf9XXUT34o5cUMkjQKOwuWuSdWy9XP9ZFukU3lCixG+LG8/4IOysXozq9NsigkDaQmiEuatQ9pWgZvSK+2X5dze+wt4oIJoAuPiWs3JGiraGSuI/j2zc7WqoLPKsmn6mgI2WQ0vp+ufA09Gdv8Z3zhcoFi6LV9MR/2yN4b91pEOkViOAXdaxYb/6fDslOGP3RKoWX5ZkiKT7fqM/0VDdewPPtxV2cszvp52WBWGmqN+9OXCRR1qo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuVOSe4lciZOEZX+nCevFDlYZJXieS18oj5t9FllZsU=;
 b=cr38eaMegvliPBxUsWHvxqKIrq2LcFiPaviT1GIwLKg9uSRvrNG2Y5tksiHLgF4OwnbvHtsgAM23NBTgZysyzylVzk1EqwrV6WPFxogUy/2yyoD4zP7bhKknGxVBh7MN0PQcRza0fibn2X3dRA/PoDUIoPTlj+EQNmYUwES4bb4ShzBhVvFrRoHu9cGl+YdN9+O0hHYuBWCPmts7RsWPKII7Dg+XpHabibeHJ4iC3pEBCJ3PMbOLfmXM22Fu9qdAdHE1RJMiWxjAjlqOEAIcnRurSTl25laIns0jmeQzDdqS/hMzSEMGDxzyaCwb9kjZRVfqKxzCIlGh87LmGCPIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuVOSe4lciZOEZX+nCevFDlYZJXieS18oj5t9FllZsU=;
 b=PdxyawLdnxcKxc+oDigicybG5xbXs67tSXjtkReeNFowBjSMw+3hIC4v/cmv6+ZMR6X6tHxrOmVwQFE9TMnBimF/mNkLI3ZMp9Y8nTxz5kUopaH0RoY4vDtoLC2QrysTcborRoLJcrSnAFV8PYo7xdA0aO9i+nv1rFfASED2+6w=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA1PR10MB6589.namprd10.prod.outlook.com (2603:10b6:806:2bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 16:29:32 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%7]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 16:29:32 +0000
Message-ID: <643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>
Date: Sun, 8 Jun 2025 12:29:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
To: Theodore Ts'o <tytso@mit.edu>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <20250607223951.GB784455@mit.edu>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250607223951.GB784455@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:610:e6::32) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA1PR10MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc62671-eaf6-4a11-68c6-08dda6a9a5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzlsa25qVXQvTDVrQkVNd0pjd21CQ0xZM1NBQjBvMEFMek9TVkpFYk9KQzd1?=
 =?utf-8?B?V2xsaDNOUFlMVmVWZjFLRUJrckRrajV0ZjF2V1g2ODJnRWNUUHEwU3VzNUky?=
 =?utf-8?B?dTlvWTc4QzdEMFJxbzhlNGNjREVFL1diUUlFUGVyMUR6MllRMjR5OE8vdjFI?=
 =?utf-8?B?M2tYR3pSV1gvQVBxZ3lMSzlWWFZjcnNEVzlXNE15NzNMOUIrWFJqektoY010?=
 =?utf-8?B?eVBvMTJXRTVBcDNGdXcxUzhPUUoxYlE0VE9CZ1pZZ2lXRHc4QWd5WlZFZUVx?=
 =?utf-8?B?b0d3SU1GK0FwM3g2b1dnYm0zS2dNa3VIOUkyRFMyd3ZDYnk1LzFyR01QeG5m?=
 =?utf-8?B?RnFXRWQ5OFIzQzFzWlNzb21qaURzdWFONE5NVGFnMC92S1dJNDg4eFJPeThu?=
 =?utf-8?B?VzNPcUcwYWRaY3lOL0dnTWtrNUplL1hWcFNONUFPd2FvOFNUWUNxR2ZMU015?=
 =?utf-8?B?VjVqUEpWY0RXQytiRERHazVsRk95RjBxQUJkTHcxd01BclBjVStlOUR3M1ph?=
 =?utf-8?B?WkcrcjRPc1AxcHdHK0laMEc4bHpKOEVjVmljK1FXRXprVEVxK1Q0Y2JzWitS?=
 =?utf-8?B?dXNyZ3BGUGdwaGt0bi8xdWx4RG8rZDdaRFJyY2djWm5hakVhQ2llR2NFOFhX?=
 =?utf-8?B?MzBNT043S0xLamF2SFp2czYrTDJ3RCtKaTUvZjZzUG9qOUNTWkxTSTRJYVZL?=
 =?utf-8?B?RXI5dnd0NEdEQlZZVjNjNm9HZkthZXVFTXU5QkYzSXdCMERtc09qU3M2dE90?=
 =?utf-8?B?Ky9NZFdhU0ozdFFGdEppbzF1dGlLZmw3b1RMTXM3VWNLSHl2L3BML3BEN1I4?=
 =?utf-8?B?ME91Um1qY0hhQWlzVTVlTWR6ei9UdVpJSHd0dUxJK3F5UG44N3dacWkrM1JV?=
 =?utf-8?B?SkZzOFV4YzZqYnIvSXM2YURBZGptOWVwdWt5SVQxZ0JNWm94akNJaGVieXNn?=
 =?utf-8?B?Z1FqQVgyd1U2WjJuRnN0TExBUVRRZU85NkY5bnpNdEN1M0RFTE0vYzZaTUNm?=
 =?utf-8?B?Q2hLTDRkV0g3ajZFb2NUZy9wQUtHc2RlZDRrcTVrY29BUEhveU9XdDhEMnJP?=
 =?utf-8?B?OXA4YXBYamFUWkovZVBKdVl4Y2FMRUJ5OXdHcm9UNG9NZEdtSFJPWEhzRFpl?=
 =?utf-8?B?SHhXZG5lTlhkNGtHV09QWkZZdnMzN2lvU3RrUlQvclY0UmlVVDRPbWVDMXR5?=
 =?utf-8?B?WkwxWXdLT0JPL0pQaU9ONFB6L2dRaVNKbWR1SGFQL3R6SEtvbWRaVmVzQWhT?=
 =?utf-8?B?UUR3SWxITnNxMjJKTlVBZWFmYXBiM3FNZnVrYVVPL2M2VHkrV2VteTJqc3JG?=
 =?utf-8?B?UHlsUzJrUGpRbWc0cUVpTlBFWUN1L0w3dkNJWU81OHVvY3dsQnpKMmd0R1lS?=
 =?utf-8?B?NE1pYzR0WWNRS1JhR21MQWdqaHlIZzNobW5yblhVWjJ5Q0haWHY0OWpRU1RS?=
 =?utf-8?B?OXJkM0t6eHprMW1ITmt5aHhaUWRVYmphNjdOSnlWN2RRSDB3UGdBdk1JU2RO?=
 =?utf-8?B?RjcxbWYwSzdURmQvTWZ0UXpncDl0S3B4ZXV3bHNrdmhHaDZ5d0JVTGFoWllN?=
 =?utf-8?B?WjB1dTlodGZ0dmpkMldPV2xQM21QVUFmWEhBZ3U2MlpwT3AwV3dkVHlUQmhx?=
 =?utf-8?B?VWM1RWdDMktETmxYSFVuMEpFY2dGZFdkZUt6RkhmdzdlZWl0bDJhajdXS0c4?=
 =?utf-8?B?VW44T2dTOHo1NE10SVpvd0hlMUNYZ1VqNWNyUC84ZFdQSHFqaWxZeUwzeDNP?=
 =?utf-8?B?S2hXdDF5S3VTRmpZSFpmZmlBMmRMdlozNlpnTk5lOWFDTzRacnBnL3dQSGlm?=
 =?utf-8?B?ZHIyYzhJempxVjZXNWtGUENkeEEyOHdyK0J3aFd0RzZLZ3ZWRzdqOVRUVGtG?=
 =?utf-8?B?SWdhUEZXWUg4TERpQ3hsVnNrMzNBRm5OSDRzUzNSUmZ4QzVUZTE2MU5YeEkv?=
 =?utf-8?Q?kRC3GpPoG9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2JZRDBJRHlqRFpMUTFiTUZJQ3BNN0lQRWppemR6ZUpvWDB2eVRvdzAzZEov?=
 =?utf-8?B?WUtySXN6U0EyaHd1dkJQOTdXVmk4R294d0JVMVlWYzc1R2ZjRjZrUzI5Qk9Z?=
 =?utf-8?B?dVM2MFdmRU5JN3FKWWdrZlV4Nzd5dFN0N2hBQ3d6Z1Frb0NGbG9kTVpLaFFa?=
 =?utf-8?B?YlNSVTdPS2tsZTlnb2tXQXFDb1UzQUxmeWRJamtYMTZQR0JqdmRjeWRFc2ls?=
 =?utf-8?B?alpNSTFLazFNSlJNWUVxbldUbFJJdWdlNS81aWk1bS96YytnVFA0bGhDMlhS?=
 =?utf-8?B?czA0UkdjeHdnN252ZzUyc1k1c3dVSGpXRWYwUHBQMk94N2dCcXFsbjJDaUZ1?=
 =?utf-8?B?dXhoTStVMTJzNmRIa1ZKVE1ScG5CaXJXaSt5MVMwWjliQkVibHp3T0djTUV0?=
 =?utf-8?B?a2hRSnhiNTI1d0ZTYlhaUFU2bkhobFdOT254dTY0T2pHcnJUc29hN3JwRTVF?=
 =?utf-8?B?UGFaTGpDM0d5Tnc3RlFla2x2MnN5MnVoaWVpdVovcEpHNnhkUkJNTXF5cFRM?=
 =?utf-8?B?L2xiMURKR21EMGNLR1BQck5ldXZoSzVUYWNXcnhLeW90MVpxVXRuYXBQbFlL?=
 =?utf-8?B?ZDdteVlGV2FWTlVBQ3M2VWtkeUJFTUNXVjlOdVNJVDdMNlRBNGVXOCtDYjcv?=
 =?utf-8?B?cUtjWHByTnFxa1FDUFFiTHRyWjlRV3ZiTGZMOUFyLy9IQ0M2em0rTVJ0L2R5?=
 =?utf-8?B?TGdmUGMzbStWQThZVy9NeW9GK093L0xmWXpjWm43WjlGR2NIeUdYU1Fpb29U?=
 =?utf-8?B?bjh6V1VDZ2FHbmdjODVQK2lnNXowcVYvYzR0cGJWREFWSEFxN211SC90UHJ4?=
 =?utf-8?B?OEJmbHBDb1p2MExXekl1NmFuVDRGblNxekF4cG9QT0NkU1cydURQVzVyc3pP?=
 =?utf-8?B?cHZWUWVwZzdsYkgvN0NhVHJDK0FpclJVa0gvV2RWeFMzVVpQcEZmck9IOGhx?=
 =?utf-8?B?QW1qWFhheXl5RHJwV3Y3aVpJTTRLbmlrdDZ3OEppcnFORCtBZm1ZNzVDWW53?=
 =?utf-8?B?NTI5VXY3NlJXNzdqemdobjlpMzZiQ2NyVmozSWNGOWRLbXpOYjI4a05jNENW?=
 =?utf-8?B?cG9zTXk4bXpNeGRGdUwrTDRueGRkZStLQUQzUytJbTVvajBxRmF5aGd2OVVv?=
 =?utf-8?B?ajAyOTlPZHdNZWc1WEQ5MUwyZWowZmpSQUdNcEdCQnNRckN6TjE0eUZYM2tj?=
 =?utf-8?B?UGRKaWJQNmlwWVhxQlZTVGlYMTVxdis3eGpqYzdHQ28xeTBHZWMyeGdJbmlM?=
 =?utf-8?B?QmJTdXJzbDFzUGs0bXFTT0tPMktWSG0wWnNHUHZFdFpqMmlXOWdidFRoODMy?=
 =?utf-8?B?bDZvSXRQcEZadzhuZ0V1Wk51NkZhZC9yTjNBMUV2UDN5cTZoTU9rRE9SUkdo?=
 =?utf-8?B?TlJUOVZCZ3p4WjRyY01FMVd1a20xdE1yWjJOMWVGQTNkd2gyWmE5NHRCQTJr?=
 =?utf-8?B?QlZsaTR6NHlHNXNRNHprMmttNGpQMng4T1VjV0FvclpKakNDQ2x0RTZad1Bm?=
 =?utf-8?B?REk1eThJbE4vVXBTN0xRRlBXbWRQb0d6czBMNkM2Yk1LTWdMMVZRYUtVdEV4?=
 =?utf-8?B?c05URFdZbG9PYUFQNUIzUk91OHVDb3lPUlNjOEQycEQ1UmxQZ2l3VlM4bEZQ?=
 =?utf-8?B?TC9tU1gxanVMK2tmU1ZDbElrdW1JZCtTdXUrZkpLMEdVZ2dqd0RmWThPdlU5?=
 =?utf-8?B?ZkVNNWxUVlloeUZ1TmVrRytaazhiYmJGR1dTSyt2NlBNeGY1Qmg5bVh6YURt?=
 =?utf-8?B?S1hTNFR2Y1NoMktQamFBTlluM0MxMGw5aVdhVDFYcE85Y3hDVElzYlBHZDFp?=
 =?utf-8?B?Y2VsK3NpeDIyczZPNjg2ZFhaek5yVWcrSjd0NTlJYTNkSktjRklIY1FsVkdo?=
 =?utf-8?B?TjhBYUZQalZ2emM1Y2p1enV6UUp3M1lTZk1Ydmo0c1NGYTJIWFV6NHVWNXBG?=
 =?utf-8?B?Y01jV1hIVmYyaHNHNTNPMHJVYllaVk8rRFZ0ZXdEMlNqSGZEa3E3Kzh3OTlj?=
 =?utf-8?B?VTRjZndVdkRDaGRnVnNkMzJLVGdzUnNpdFRYS29FVk1uK3AvQSswaldJVFgv?=
 =?utf-8?B?TzFIZGE3T3hxdGVsQ3JyK2c4clEwTVRqZ280cFNqeTA3d3JEVUFlMmprWTBh?=
 =?utf-8?Q?Gjxbpah6R6b52IeqJsUpfFcGb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4P89bxLqK75NTmHt+N0vq1uwvFe7UpFZof8exjCnt2qH2jH3/mnAEI1ErYsx1SNpX3050Qhqbyd02VbDkxc65uSLULVY5m6gGdPNH8/EysepzcyFTktz8cgMAI96oGOaAEkRV7xYIE+uvqAfTdP1BW/spEvJ1seN4fF1gaVxW9wwx1N0HTKzbB++Uibng73NN2sTeWDlof7LBXKbgMCd6DWtQHRBg7WdTRx1BX1SdtGhgroYaAyNAOOHqRcnTMoQGw+ewYNv7TDZLeFjZqKO7wpF1b6bN5+6pJCco/yun7FN8YMu/3KNM36mqVLonulBA9DUtUj6eI5Qr64ErF11EYVtzWQMyTLcoDQdJdI+CbYTxX6APbCkcqvfinOvCDcV5L8RcHxG5k/fuiB+sH4thXxZTPeO7YRrTPfmszlEkU12yTU24PiT791vMwZ+IZ3k8aoLmgSeLYXxmBa+1HpY7ag3bIaXg+3WMgrXT22VSincUpUdpXPyCcWbHfpBm+m0AdCl3hJatcG+jbe/uX7/NA/VX1vw3t21GeslFVu4pQFkZr+qYbE16m751E5p0aHlDBdJFKkpgYfmCvKR10rXtm/urhh3Mb8PSyaSMWiKLo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc62671-eaf6-4a11-68c6-08dda6a9a5fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 16:29:32.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0wLiPE1IUP9VN1WHfOFhE97K9qqMj7v7em7qwWDXMQN3SErFJMgBnP4wjAxp0gFLAMuBgBMUAGU9KfaIR8tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506080132
X-Proofpoint-GUID: n4LVtUmIj-N4dpg41JS05wFTEq1T7lhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDEzMiBTYWx0ZWRfX0jxQ8ig2KmOh xLKMCfd7hvUS9W0Q8IZnS8q5HYqRvYoVgqjDDUGmS53LZmRhoAsYYeJx8iuclC0WsrHC3vSsqu3 P7pcgkK+Mdz6cm/zHWtfrcY4WjNKex2BHzflQ+eQLS2SxHAKGrmDNjiXqDhtG+zQppKnrjRMblA
 K8HYQRgif8wVCFMrHxIkqX181aSMkyky+LSv8gL+6+mVAAlvgKEHm8UVC8xTFs/IJD2+bR4PxP7 8Xi027yUYCJko8Mf7hUknMmwAGNXWIKAZ8Cp+jiCYMc9DN8aVvt8VzPagvN5WERcyLwcYytmLFE +y95VRDhMbZoJLDH9IQA0erTgeJaTj8CtaQ30Lttyk2mJ7qI1vQXZp3k6FeDBChHspjhSfIE3Ui
 lixt7NndLcypRrAJizzQmnDFMHb/U9bXXgY0ZNPi0TeuJMV/2RPCkiGoKHR4lTYdcuNdp1B1
X-Proofpoint-ORIG-GUID: n4LVtUmIj-N4dpg41JS05wFTEq1T7lhY
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=6845ba6f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=48vgC7mUAAAA:8 a=B9DZAZANtNu6TmPBcDkA:9 a=QEXdDO2ut3YA:10 a=1ubEK3MtcLIA:10 a=2uINnPWhDggA:10

On 6/7/25 6:39 PM, Theodore Ts'o wrote:
> On Sat, Jun 07, 2025 at 02:30:37PM -0400, Chuck Lever wrote:
>>
>> My impression is that real case-insensitivity has been added to the
>> dentry cache in support of FAT on Android devices (or something like
>> that). That clears the path a bit for NFSD, but it needs to be
>> researched to see if that new support is adequate for NFS to use.
> 
> Case insensitivty was added in Linux in 2019, with the primary coding
> work being done by Gabriel Krisman Bertazi of Collabora, and design
> work being done being done by Gabriel, Michael Halcrow, and myself.
> (Michael Halcrow in particular was responsible for devising how to
> make case-insensitivity work with filename encryption and indexed
> directories.)

For some reason I thought case-insensitivity support was merged more
recently than that. I recall it first appearing as a session at LSF in
Park City, but maybe that one was in 2018.


> There is an interesting write-up about NFS and case-insensitivity in a
> relatively recent Internet-Draft[1], dated 2025-May-16.  In this I-D,
> it points out that one of the primary concerns is that if the client
> caches negative lookups under one case (say, MaDNeSS), and then the
> file is created using a different case (say "madness"), then the
> negative dentry cache indicating that MaDNeSS does not exist needs to
> be removed when "madness" is created.  I'm not sure how Linux's NFS
> client handles negative dentries, since even without
> case-insensitivity, a file name that previously didn't exist could
> have subsequently been created by another client on a different host.
> So does Linux's NFS client simply does not use negative dentries, or
> does it have some kind of cache invalidation scheme when the directory
> has a new mtime, or some such?
> 
> [1] https://www.ietf.org/id/draft-ietf-nfsv4-internationalization-12.html#name-handling-of-string-equivale

nfs(5) describes the lookupcache= mount option. It controls how the
Linux NFS client caches positive and negative lookup results.


-- 
Chuck Lever

