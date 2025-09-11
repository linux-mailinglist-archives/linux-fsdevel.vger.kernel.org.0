Return-Path: <linux-fsdevel+bounces-60895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52EB52A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF13B88EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80F272814;
	Thu, 11 Sep 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SlxqmsFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C1329F17
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576236; cv=fail; b=EUMYT1rzV5v+dtEvkzSwoI4ndDzbVGBx7nx5cpSeN8bHK9pCqSMEKmFXOvhs5eaUCl3Unj7TOgjHReatd62Hrs07lK2m8qtlm3Ptj41/HOuT3Lc29T/f0uaBDJCN1h3lfgsiQSLZdnAY3pOAvG9e/TOWSj6OhUAHuxPea/uEAJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576236; c=relaxed/simple;
	bh=4oNglLn901TEdqanxtCVF0Rz6myZ/W3sf+QxZ7cuw9g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VZb8+Xoek5Ev3HQn1va3DqpZzUwezuubOPXTGR3Rh/c2AB+kL1YHphBY+niU1yfggI8wBt9id4xJOyfYMg2Zu9+sj3bz9zTxbW2uTX3WqgtfbEKaq20YSOjlLT4GkL42NraQXh1ZTG3X5hXqrg2OTk6GUy5gpsZV/KPe+zVB7sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SlxqmsFn; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136]) by mx-outbound11-233.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Sep 2025 07:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzx3/NMR1cEgnSJwQ+hNFf3BRVE/AtC5t2Mgww0kcysRlU82S+lRHV1qym6wAm7rSMewMsmIpRkRFPg8thFSpi1+oFRqvQbqGMOcI7jEYIavy8LGtRYD4V/bSx4UZrBeKGxWpUQTekZT4EAnIRFw+xV3b2I8FzGUDV5kQgQalW8Y+JcFtPNlZlIhlyYvKk5nfYS6IXifbOl8LsJocXPldoLfdGx0j8rv/9zXklcBapbx/5KobKMkRYyElFNR+fSACfGY+dist9rxG38kh/4yuNbYPxPiHievbYkddIj966DwtcfytQtXnLWgttC5TUj7QHPN28NRAkhkUVYT0STyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOeAwtTmGj6eb9Cg+fFSxWyZfxY2dd7Ls6UYWeMiizM=;
 b=dXHzhmfMucFhIjrCbkmcxmVzrn2AxPf8Hxd+QRPjbiAWWE2KyBjg6RzbJbiBEpN9BxNKty1XEYsltYEEO0jHdFWCfke792aCLgwR+iSFbHylb4JxVxIkdxkTn+0QSRsp2+jOpUv0Dz/niQJXw89N1YvZZDcxiNWT0RSqMPtWF7daM3wIlIp3UIRhffSKiugHXshYxab7JXxyqUFLhMDMjkYtyvQg0FWu7/XOXszVqv3QEschK5J9zf+E7xUgCfoVMGBJAozug3H6G6L1ksvS2hg7mJUxkBg4DyQVfB586bFu7iLKJ49vjRvREjtYe+YL/ov4MXfSyUCulYfb+nymYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOeAwtTmGj6eb9Cg+fFSxWyZfxY2dd7Ls6UYWeMiizM=;
 b=SlxqmsFnwo89LXHD9qcS3soyApI2DkBtrNy8g6XzBtj6jPOBEhdljzQqoe6g8v5uXThFNhn3wBP+A7zzDBJrOt4UIjafeuwryicezG7CiyhvacWjHJnzjZRgi2rDdIYGxvclmx/ynSFe/K9bmguE7dHDdpAbEokTVIfc/7ssPBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SN7PR19MB7019.namprd19.prod.outlook.com (2603:10b6:806:2aa::13)
 by DS4PPFA168D4958.namprd19.prod.outlook.com (2603:10b6:f:fc00::a3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:37:10 +0000
Received: from SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd]) by SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 07:37:09 +0000
Message-ID: <1029a4e2-bf0d-4394-9b37-ae66126d610b@ddn.com>
Date: Thu, 11 Sep 2025 15:37:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from
 fuse_uring_cancel
From: Jian Huang Li <ali@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu, bschubert@ddn.com
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
Content-Language: en-US
In-Reply-To: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::6) To SN7PR19MB7019.namprd19.prod.outlook.com
 (2603:10b6:806:2aa::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB7019:EE_|DS4PPFA168D4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c85e2-1661-4816-5113-08ddf10603a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFhzdFI4VXlSNXhKY2lrUHhzUGdEWThXeXJwcHI4bGM2dzdES0Y2N2ZDTy96?=
 =?utf-8?B?NlFITFQ4LzljMVhRMllheUpDSnZaWlRxYXpUTDNZbk1NaHZESllSWUZVVzEy?=
 =?utf-8?B?NGg5eXo2S0VteHk4TGd6aXBxSHQ3T2RzWG9taHl1czk5clQ1Qks4MGRVcWdJ?=
 =?utf-8?B?M3NwS25vWVN1Qm5oT2k5THMxWGcySkJxV29qSlJsQzR0S3hQMHgwY2JSUWhh?=
 =?utf-8?B?d3FweUFJUWRpay9YeWI2NFluRldLUTIyeDhBeDRCY1FDQ2EwYU1YKzZSMHNM?=
 =?utf-8?B?WE9kVUFvRFFEZHZXV1U0eVUvNEl6cEkzdkFFd2ZGd3VFdHh0RXE4cDNJMnpq?=
 =?utf-8?B?YWxNdW51cVdsMEdRQ2o3dytweG53UHlGZmd6R2pyUHdUMWZ5U1loN3hQbkhR?=
 =?utf-8?B?ZnRMWTdFK0U2N1ZUUmhOeXh1aFh0RWs1MVZ0N3J6VTZBK0o5Q2pjUERwYk5k?=
 =?utf-8?B?NUplSFhSc2lBbC9UaXlpNzRjVHdsN2ZKcHdtcjY4dlEyL3owQVJyZEYzZ2Z2?=
 =?utf-8?B?eUtiNG9lekdZZ0QzSCszZHo0Y0RZTG5pc1VoTGNrZVhUdkp5ZzRlbWNwcEFM?=
 =?utf-8?B?cXhNbm84UWd6bU9Wa0R3eGtXMlhvUjlLWFI5a2xQYi9DUHhyUzdlYmgxajA5?=
 =?utf-8?B?T0lidkJwRi9ka0hUcVc3M09YeGxjK1NEODVnb2dPT3U0azZTN2F4YkZJYXoz?=
 =?utf-8?B?eVlRLzd1WDhTVjRpMnBiTW1ZUWJsc2RuU2kzQ0h0RHNUc3BKRVMxbFlHalJ6?=
 =?utf-8?B?UHA5K3ZzMklNMGozd3orcFhWTlNkYWE0bHpiZjhsQkhFSTJOZUlUdi9uUEhW?=
 =?utf-8?B?SWtHZllsQ1FnRjRBVXBWRVdVNUJZY21ReW5xL1FOQ2ZkYVRBbHd0aVJjdHA3?=
 =?utf-8?B?MFBiaDFUTTg4ZDJEWVRxK2tuem4ydXhWQTR1NU9xOFd2aGQ2RTR3OVI5Vk5X?=
 =?utf-8?B?TkVKbGt2OWFlQ1hUN2Zwa1RLQkhNN3plZncxaWpKaXlBTU5Gc0NmODUxazBH?=
 =?utf-8?B?Y0JMZGFEL2hCK2c5dldtemZPODlXTCtmQkZKUXRJR0poOXFmd090SXdCK0Nh?=
 =?utf-8?B?SWljaGZURU5IMmlPdWxOckpTSytQYzRmaWFKVFV2bFF1ZGpkV2JJNnBDS09k?=
 =?utf-8?B?VjdFTVRrQ2oyRzRmaFFrVmorNUEyMU45QWJVZ25pQk5rV1ZmR3VZUkpmSjM0?=
 =?utf-8?B?bDlTMENEQUpFU01QRkVncHovUUJnbjZVdWQxSnlMcXplTG5GOExEeUdtRW5r?=
 =?utf-8?B?MkJwMi81aWVuRzkxNlNyYi9LUW1jbGhxT1ZQcEFLZ3dhbWhLendtSlhnS1ZB?=
 =?utf-8?B?OXRWTHhrZmNEWFhQWnlVSEQ0RzZFY2c5TmxsczNHNWJNQ0doOVZPTTVVamZp?=
 =?utf-8?B?Q3F2THM1UEJPazFBMi93YmhXZERxblJPKzE5UHBwWVpFRzdTWXJRdE1ETXFQ?=
 =?utf-8?B?SWU1RWlNcmd6cS9nQkZFU0RTdXVvMVJkSXorMkdERlk4dGFkaWN0SS9scG5U?=
 =?utf-8?B?SXZ3alptU0R3Z3JSQWQrQlZ0ZTZ2MExmU0VCdWpBN0UzaWxMc2tyaWx6Mlpj?=
 =?utf-8?B?WnpSMUdaOGNNTkZXL1l1WE1TMkJ3bVJHNVZYc2tTNUZ3djVGUXZmNVlOb21m?=
 =?utf-8?B?Vkc3RWN3UmlSd0Myd2NqaU5yWVd2cFQ5V1FLa3dHVTQrdGQ2UEhFUnhiejRI?=
 =?utf-8?B?T2Z6RnMrWldBMFJkZUN1d2xHc0JnYXZlVnpWWUg1bUJOcGRKYzVuTksxamM4?=
 =?utf-8?B?Z0FiMW81WTJkUnpKWDAxMWw1MkYyVWk4aEFGUjBhalNhMmJiOUxuRGZ1Z2I1?=
 =?utf-8?B?MHpLbEc4WGhqbUs2dTZLaDJSY1o1OFJvS0lGL1Eya1lkQndkRmhDc1U1L3RG?=
 =?utf-8?B?NjJGamJWMWZ0YVNhUWQ2bHVRc28vSXZ3eE55eFZIbkw4VzUvMHo1cnlYN2dO?=
 =?utf-8?Q?iZNg4gXitqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR19MB7019.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anlUOVhpR05sUGVIOHgyOXhZeW45dkFlT1VYazhWTzdVQzZ4cUF1T1lwcnVz?=
 =?utf-8?B?MXo3ejVoSWxVd3l5VFlSVlhVV0duRHpEV0VHcUthRzBVeVVsRDVZdkFDdThS?=
 =?utf-8?B?WEUrendneUVPdDk1Q1poLytKVUNxWEs2c09nR1RubUw2VzF0YXArSktNeHRT?=
 =?utf-8?B?ZmNFbTUzWkFYTUkxa3hTcndJdjZlQ1FpMzMxNHc3bkNEUSt5L1k2V3VyNHNw?=
 =?utf-8?B?d0tZd1pwakFpb3dXVXFGbjkzV1M4OXR5MFcrOWMxQ2ZtVzhxN0owUW41Tzda?=
 =?utf-8?B?eW1MSTNhZUNsU09pa2ZrbEJ0ZTJJY2hSZ0FjbVMyY05PdnMzY0hrMFBiS2o1?=
 =?utf-8?B?NmNicHpCb3U1OGpQNklWYzdSSjNXck04Rm1BczlFdFV2QjQ3czJoMStZU1Ay?=
 =?utf-8?B?Z0ljMVRublZFNHJwMWkxMFFFM3JtNkI5Ukd0Q2hUdXRvR2lqek9XVkU1eVd0?=
 =?utf-8?B?d2JiT3BwOHJtelFVWVVtQVJiWjZ4MFhBN041eVJ6YzlORTM2VEg3WDdTM25W?=
 =?utf-8?B?MWlLZlMrUEZVaXNBemVneWdCaGNpQVY5NTFMdU1JODVxN2hWblhhc1cxZ1gr?=
 =?utf-8?B?eTIrWWJyMUluZDRLSG5CYnJWNTlNdGk0YkhLWGo4N0RGRU1jOXhCZytWQUJ3?=
 =?utf-8?B?d0RVcFVWbEhXWmlBSXNqM2JSM1JuUWxPNU8xZUdpVHFsRmV4WnVFSmlTYkY1?=
 =?utf-8?B?RFBSQXNjeVB2RVZ1aHRncERSSWc2bXRORHJxNXVwWlRDd0RDcHVTUGo0VTRx?=
 =?utf-8?B?dDFxV1lZZ0t0NTJ3NzBoVWRwMHdSNDU5eiszUEx6b3M1R2RiZzZEa01YV0FE?=
 =?utf-8?B?YllrWWZaV2d2VVVUbHl2MHRHQk1zbVh4YXFoUU5WZkFWbFpOYkFFQzk5STh6?=
 =?utf-8?B?NWdOSklmLzlqT0lYOFEwWTN5SmxlTTJ1bFZVdm92Y3ltR3pZOHdxZWhnSnc0?=
 =?utf-8?B?SEZndndhaUxUMC8wUGV5cmVoZDhBa20xcDRTek9JS0FsMnJCUU5IYkZObXE4?=
 =?utf-8?B?OGVnejVrajdOb2ExU1FWcjZUTmt5NzJVNXBROHBIdmNJMTZKNHNpcGxORUdX?=
 =?utf-8?B?NlhIYVlpL0dZMFlVMzV1YWdTRWNxdENyL2Y3bHVzODVIeHV1a3JVNzM5cERJ?=
 =?utf-8?B?Tnk0UkZldU1BNkluTUNzeWxiUnF2dWlrSnNMZS92YkxkdGV3WFB5MytDeXlC?=
 =?utf-8?B?Zkh0bWRYN1BHSDV3Q0QrK05lbCt2ZDRlRlpDWUZDRy9weVZPTGlsNFpyajNG?=
 =?utf-8?B?ZnFFcE4yNzRuYjN1ZTdLdmFxT2U0T2cvKzJ2Q2wyQ204YTdWek5NVzE4Z2tn?=
 =?utf-8?B?aTJLMm1FaFRYZDNjQ016RmFSNFVFU295ODVZNTNKOHBPNmd4UW1oM0U1eXlG?=
 =?utf-8?B?NGdwZTNSMTlzOU1nYzJiNjF3UnkyQm5Oc3VRSHhCSW5wSGJkTk5Oam9LVmc3?=
 =?utf-8?B?Z0l0Q3dwVUowNjgyRXFmYmFDeGJraEd5eUloQjVkamZLWGtrY2hwZ2VQWTIr?=
 =?utf-8?B?bm1VMXdPTDhpSzB2NkhCL3FHd3RlN3RaWklwQnpRQ1V3ZG5yWDdGdFQzNERv?=
 =?utf-8?B?NlZLYjRuSCtuU1VzTUFyd1JxYyt3UXpzZlM4YVA4VkR3Nkk2WTFqbFBGMXJt?=
 =?utf-8?B?a1h3NmVUTDk4bWZRa2cralBGaVJUNWJnUnA2UmZOazl4TVI5WkFMRG5DM1hX?=
 =?utf-8?B?b0N1YTlXSzJSdWc4Sm1sMmpTYWNlSi9BTEpZYmErUEVoNEJXdytTbTk5MzhO?=
 =?utf-8?B?bGI5SFhvWmMvUElOR3hNUm1uNXFRN3JqYTByeEc3azlnMHh5eTl5VXBiRjlm?=
 =?utf-8?B?YnZQWjZvc2hJKzd2b2JSRnkvNmdNQ0FOaEdMQUF4OEVhMFppRnJzdzNyZkpM?=
 =?utf-8?B?blhNVTFlbFZldCtXRGJPdFhCak9vdEMvMWdjTGI4dGU4TEFCRStWVEZURTVJ?=
 =?utf-8?B?WStRWDlkd3NTT28xWVZDZlBlSHV3TlkyQTM3TlUxZ1p0MTUrUUduM01qakht?=
 =?utf-8?B?VURieUtqdXRpSjNiZDRzVmpPSlJFZVR4eHlrRllUd2tjSVdFdmlXbDhaRXQr?=
 =?utf-8?B?d0lQY1BTQ1h4N0tzSnl2ZnNZTTZzQUwvRldMbWFBQlV3dzk4MU1iSmVPcG1P?=
 =?utf-8?Q?iW9I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m9NfDUeMnFlbf8YBGpD4d2XuN4ZaMVVk9usb+9b+OKcRMaqVAmEEacOtm83m4WXr0Nufkgj44K2eAxwGoGAkE86VqGua1xEvEkejbiWxsTbCM1YkLu0pb7Pov88uCeYwx2PMN8T2SiZsNv0LM0LbS8GsvMgyHyvdy7J10ubp+qz5YnZpr2+X0W1okSz2tw1IRGKbsUZOfL2UH3du7WyGCykAfIUWE1OLKpVADPIonbLOLQSTCof9S40F+/3PUdmicozUll46oo4JViV9WFnCu003vZh28nNvKHcnTSY68SDOTI5b08nj/N4WO0TASuHP2dGhA8wzN9maMNhbhJJ87+hPpNWWZbsFATEShJfqatceED1e0OzVDRsGR+8demFq/Ylb8HtSWBE5Z/fwoioWytsDFfFprsAxQNamnlfZaA1DZU8WX4Tv1QnDEaFNuk4p+/pRwCA85FFmo7rPI6za9GGy/4iBIG9T6qxQVBj8jYSmKlTYkLxoK1v7l8njhBleVY1YcPgsKnljRhnij4jcfaEDuYHhUqNj4pqPLlbNovIGOKR+U+qA9k7ILQSgsxKAkmYid4xWXnkyVb4E63jN9FkCJyMiGKgiqF1nKt4V8oDRCOX5s2C3akrKcTEm6sNLTw4sFgt//qwMEGZHjq7+og==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c85e2-1661-4816-5113-08ddf10603a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB7019.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:37:09.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9iHkOYhd6UtwYlHldGwQCUPhZfaAzWu6AKuvcyUf5pquicjrxYpsPATJoisUBol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA168D4958
X-BESS-ID: 1757576232-103049-24369-14769-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.94.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYG5kBGBlDMyMDQIjExMTXJOC
	U51djQ0CTNLNHUzMLQ0iLVxCQxKVmpNhYA3sbjmkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267400 [from 
	cloudscan20-154.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Changelog
---------
v1: 
https://lore.kernel.org/all/4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com/
v1 -> v2:
* Instead of introducing a new list, keep to use ent_in_userspace to
   handle not-in-using entities when SQEs get canceled, and
   iterate/free on the ent_in_userspace list in fuse_uring_destruct.

