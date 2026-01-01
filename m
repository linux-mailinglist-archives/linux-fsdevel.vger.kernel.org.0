Return-Path: <linux-fsdevel+bounces-72300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09483CECBB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 02:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B18D3007205
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9672749EA;
	Thu,  1 Jan 2026 01:19:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022077.outbound.protection.outlook.com [52.101.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23F26C3BD;
	Thu,  1 Jan 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767230377; cv=fail; b=fI4LFs+84OqIN1wLnvfXoLgIJBMfsU8U2+ZNxRgmCDtliE8u15lXtbB6sQlwT7IBv532KEt91lQMyRJjP4sfyoZ2WoiQCcjxXb96PiuTzctz2+z7LiTq7HNjB446m3lCzJ8iV1Ng5eZtREPNMwakQ4E1+U0L/EfeEr5BsrAK49w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767230377; c=relaxed/simple;
	bh=/RHOeL7f2QA8c7miEY9mmd5eLave9mmdirsntmiiXcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QeTAMZdXFXZnG5qFrRZEL6SuPzUY1GEqh63rfnFgE3J5CyjmuZQXEWRI1xumU0lsuYMO0AMYXdHvDlmZzuqzptZzk/8kKXHVuY4uVr8JI6E0p2JxJi5p0eqgP+UL8xw84UKdIlCmT7cq72Y6jWyNAZ9vH4L/eJ2rm9/dNxeaZNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQX/gjeZjV1epILsxTlJzi5xEaeFEO51IYOjdJvWa852i+tRhxmEuMh8iXsODyYib+yH3ScYDqFfICXaQFz9XPbdnqpKTccS6+UQ/GfKTk4jdd86bY0Vt02P/qUwOnRA6UFmfFyzdwkI7wtAp4Kqpsgt4L3AeYBwDCUJgOtAddPqXu4cwwqH9d2hJvksSy9Rz6vIpD5oO2NYyAmBF+lZfxrhaSX/YIS9OcaMRX8QU5CdIR03U7cPHbkJd3ywN99ateGEwG3pqpOzVRHzWyTn34fPvFmCE6tn7nmP5NTyx8r+woDvRImAvoc310d7nL9nARVQrwwIDnh6Ak4IKSrjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RHOeL7f2QA8c7miEY9mmd5eLave9mmdirsntmiiXcI=;
 b=JUjAY33dW9CDGCq9uKnwkAtDk5qIY33KjtvOId8IraQVS3TLCIMMeYF3W3I3G7It8rl8TJNv/tDvFGXzo5Jo9NgcMQzzmIU9MhZSBkH6BN0QZfMHStyLKfdJvTe5+mR24d0GB8r8GDiEqSM0mw9M7xCi0wT/oUzT9VZB9YOaK9I4fRoqn0+0rK0vDuHgjtRJwyVtgq5NWqqxoqSjyv4AyqPCBMCkdvFlqjppbFbES+VV7tUna455GLNXdYsIXVXWIacBMGk1MP/o1BcPLIUNpQsSo2Xcx+4OFAXsfbukyV+V5Xl9EQwk8ulCLh8DbjLzbGs/t72xoiohyExPAYSJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3160.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 01:19:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 01:19:30 +0000
Date: Wed, 31 Dec 2025 20:19:26 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: oleg@redhat.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	brauner@kernel.org, mingo@kernel.org, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <suoe7pyfr2qcbxyov456lglf4hcxkrzhoyqbiaba4kw32u5m2h@hg2crnjgdfoy>
References: <20251226211407.2252573-1-atomlin@atomlin.com>
 <20251226211407.2252573-2-atomlin@atomlin.com>
 <ac50181c-8a9d-43b8-9597-4d6d01f31f81@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d547sj7ydjrl6zsx"
Content-Disposition: inline
In-Reply-To: <ac50181c-8a9d-43b8-9597-4d6d01f31f81@kernel.org>
X-ClientProxiedBy: BN9PR03CA0521.namprd03.prod.outlook.com
 (2603:10b6:408:131::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3160:EE_
X-MS-Office365-Filtering-Correlation-Id: 876093e3-564c-49c7-99ad-08de48d3d020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTBZZGlXMng2S0V1ZFFwRXNvQkdQN003ZlQ4bklaL1hNZFpBb1BNUkZpVnhG?=
 =?utf-8?B?eUVnSHJWZmZMWFR2RSt4UkhXTmFnNzRwWHJZRmtIb3BWU0R4VzB4ak5PYkJC?=
 =?utf-8?B?VmlYdkFQWm9ZSzhIRlNjWDhVaCtURnZEVHkyZ2FPWFd0SDVmNEsxTGVxRWNj?=
 =?utf-8?B?U2dqZE5tWEcrSDZ4bjhnQktHUnpmTFFITENOd2VXU2VVOWc1dnZCS3kwMjZv?=
 =?utf-8?B?MGdWWEsrQUxGUWpjdkNjelU4VnY0QmgvV2NIVnBOV0w2bW5mRWdNSncwUTAy?=
 =?utf-8?B?c1dGdkpJT1U1cDd6TkxNSjErYUFhV3VBK3lHOVYrTTg1NEVNc2R1ampDUml5?=
 =?utf-8?B?ZkhTeit5dzU2UEJrMjJRdUdHQmJTTWpkU211ZUkreEZjZEpjb0pEUmFPWmFE?=
 =?utf-8?B?d3AxK1dMb1ZHUkkyNTVSSGZuN24rNmRIWXNXc1RodFZFZ0kyMUk2VUlkRlRW?=
 =?utf-8?B?dHZWQkpteGZub1laVCtaL2VxVGpSU1BwblJVdGRpN3FpNGRDOGM4TkxIazZ2?=
 =?utf-8?B?MVh4K0duUTZ5dnAva2RzbVVLZGpwUGdXd3ozZmt0OGpvaU9RVUhEWjJaamk5?=
 =?utf-8?B?bXhxR1NDb09jc1pYRGNISnhHUGNTdzcrbW5uY3BnYU1IOE1TVHNmMkpoNnhm?=
 =?utf-8?B?Lzd4K21Cai90cnFxd0NUVUFPbEMzeFdUL3lHa2RQYkpLS1cxdHBPb1ZJZ3pt?=
 =?utf-8?B?UUM5NG4zK3lIWVoyK0ZnSGthY0lWV2FUSDB1dGE1RE91QXIxVVhkd05UNEtU?=
 =?utf-8?B?Rm5YRFhhWFhJSEtMbXN4TnhvSVh2Kzk1VUdNZitFZGVNbkd0SDNycjZsamdY?=
 =?utf-8?B?ZEI5cTNKY2crNktkMVJWRWxacCtDbVA1VSsveUlVN3NYVGJkRWxPM1VVYUVv?=
 =?utf-8?B?REFxODFEdEFXdlZmdmtEeTU4Z290T05aa0R2MHFNUnZtRHQzNGdSNHNDUmhw?=
 =?utf-8?B?cUFmS1RRYlJPTmhoOEJYNFc3ZWg4WXRLNit0V0VOZ21EZHpKaVQ3a0swZHRM?=
 =?utf-8?B?Kzd1U1ZQNG1VdWJacEtVSGJ2N05SRWxXQWRBNkk5YzdaT3Q0N290UFpuVzZT?=
 =?utf-8?B?ZVNaalVNYjVneW1wU3pFNm9CTTFrNEh5enhIeHAxbUNUYndGaVN4bEpjb2xP?=
 =?utf-8?B?eHYrbkpOMmxyQlF3dmdpNktsOWIwZXdPK2psZ1p2cWQ1VjV0RjNFZEJTV3Nx?=
 =?utf-8?B?aUF0bTUwdW45bm9MMitwNXhRYko3MFA1T01abXZmYktIVll0RDMwRjBoOGNj?=
 =?utf-8?B?bmNYcCsvL0Urd1gwbDE3MlJMdStQWUdyQk13M2VrY0hFOXlUdG9ibW1IbmNN?=
 =?utf-8?B?b3c4YTdMQlhNQlVoU3JXNUFEUnBWY3Z0WE9MM1ViNHJtVWtvZDZWODA5UVBQ?=
 =?utf-8?B?cXIxZmNQUVV1UFhDSldpd2ZHbk9LRlAzSlNoeVAxNUluUStsNjFoKzk4MnJo?=
 =?utf-8?B?MmpGUVNKM2lHOEtVQjNPTjBXZlFVbi9lMGQ4UURTUSsxUFl1MVdGQ01CWlJH?=
 =?utf-8?B?ZnlsYlJiRU5ka3RGMTJJd1ViZ0R1a1pNcVlrSVp2RjUxZmlEaVV3Ym1jdnZ4?=
 =?utf-8?B?UG11ZW5wcEF1WndmUlFoZXdZNi8wdm03ZkVVVWp6NXRXU2pwdnpqQXk1RFdI?=
 =?utf-8?B?UVJDdEplTWhiYmR1KzQrQ0o1eHdDOHJ0UmE4UXlJRnZPRVYzVk42WURSRGFK?=
 =?utf-8?B?VWo5T2JQOXBwVmxZcHRiR3NDMjgzVERndS9GRERvdFdlZVloOUZ6ayszLzRQ?=
 =?utf-8?B?M3pYckd4ZmpoUTd5bWVIKzdZWGRKSmNMUEVmNWhDNVAyS0FXQ245SnR2TDM0?=
 =?utf-8?B?ZGppRzZzZjBPcTErMGNmKzkyMFhuTnkzcG4vMk5lL1J6UTl3RHNNVDQwSEdV?=
 =?utf-8?B?dTJVV2YzeHVSV21yRDZTNU9zdENIMFl1UGlsZFlFVDYvWW5DNFYrMUxibnEr?=
 =?utf-8?Q?eeU6RzYNTQqUWzghvi0EO/LkLnHwvOMJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVseTJFcno5akdEOGNNYWk1ZHdwTDVEeDJLcW1aY3lPUVBTOXlzZnB6aUpi?=
 =?utf-8?B?cHh1TVlqWnZURWxVRHl5RlFRNHd3ZGJUdHg2UHROTkNpVnJyalZqUmNheWRw?=
 =?utf-8?B?Qm5nQVYzN2pEK0lodWtXUzA2cHE1RHdWWURPQ1lRZnVSMm0zYnlzSzR2c3VM?=
 =?utf-8?B?MDF1YnY2RDdBTXg2WWZYUnpIYlY2NGRnQ2o3WkdvQnNDNERoRXgyVXR5aDlH?=
 =?utf-8?B?WGJQWE50OEJhajBZUHJlZWR1TUtoYlBkdDJicC93NThYQlBpeVNmRldTNTBX?=
 =?utf-8?B?amFaMkQwWEdGSDFTVlNqKytGWTA1NklFYno3OUtaRFVNQzF0S3R0MklvdG91?=
 =?utf-8?B?NERURXJMM3F4ZUxlakJZVHFsbGE2bUViK1p6ZTkvazQxM1pLbTFHUk1aUTNQ?=
 =?utf-8?B?K25GdU14SDlQVzFaUUNQNTJZTTVPMkdGd3hya2VDU1EyOGZZTFhQSkJ0c2h1?=
 =?utf-8?B?K0pzTE9tMTJpem8yRmpHYTBmRU9QS21WTWZhSGEvNVdJdHhtTUQ2eWJFZy9P?=
 =?utf-8?B?WEViRStKWUthR3dheGRLbmlUbnVidDF2UWVsVHgrUnAvS0FhVEN6Mkc0MlVq?=
 =?utf-8?B?RmtxTG1YNXVPallWWXJLUzZ3b0l6VE1vTkdnZjNuYzcvQldPTlZsalFWYlZ1?=
 =?utf-8?B?OTRiR0NkYUxvT204TVgwbXJwR1BuMjBOQldqaEtzMXVzSTg0ZG02NXJlTnA4?=
 =?utf-8?B?ZjhKM2V2Rlh4SjJQbmRLejExeEUvYjNQMEIxK08wMS9iWTRTWERzYVdONUFa?=
 =?utf-8?B?MENmNUZiWkxoa0NzYVRKZm1mVHF2alhzVVlOR2dPeURxYllxMG1VWERZY1BC?=
 =?utf-8?B?dnhIU28rVDBUTjkzeVdqL3RsUUdTQkpMVjVNd0VTb1VuWVF6KzQ3c2loQmU4?=
 =?utf-8?B?d1NSa3NDa0NTVmQvSnZsS3cweHVWMXFXRzZFMFpvTzZlaDNSbHRERFdGNUo4?=
 =?utf-8?B?a2I4YitzRGVqSU5yOVNrM0J3Y2tyTFF3NDd2RXd6SmRKOURsdW9VLzdES09i?=
 =?utf-8?B?OExMS2dzMStQVzhiTkNRb1BqVUg1cEJwQjJNWjBZUGdRTXdReHVSS1BjZldF?=
 =?utf-8?B?aWsrOVZDRjdtWGxBdXBseEI2VEdIbTFoRlFQN0xPZDJLMFlmUEk0TXVnQXBo?=
 =?utf-8?B?ajUyUHBEM1RoeWFWSGhnVVJWTThhU0pqSjJZNVA2UjlNRFk4V0tBbVVDRi9P?=
 =?utf-8?B?ckNjQnlwWFlnczhCS1JuMzhQWE04VU04UitNQjd0NUdrK0lqeTlBOTJpUXJm?=
 =?utf-8?B?cUxNSFlRdkNaMitwdXdocytJTXJtMTV5NlZ6RElXeE1JWUdDQjBqSXRRZVlK?=
 =?utf-8?B?R01tVGNyN0pTMGxoajJUOWsrT3I4UDhzNzdpY3ZnT25rbDRZL05nQzhRSXJo?=
 =?utf-8?B?L2VMM0ZaYlptL3hORytucm42QzMva2pmMXg3d0M4YmtsQ0l3a1RLSStUZzdN?=
 =?utf-8?B?Q3FJZzB1aWpIcjM5WTdDTm4xb090WHZuOFQreHVDT2tYaVBZN1RJZE1icDF4?=
 =?utf-8?B?N2NzeEp2WXlZRVpNUE1jaC9ZaTEwQ25UWm82USsrTXRPYVF2VzF2b0xQVUta?=
 =?utf-8?B?M0s5Q2ZpRzh3NlhLMlpxK3J2OGVMUWs4OWpuaHBZeU9YeVU1OUhBaU5BRity?=
 =?utf-8?B?Y3dCWmJJL1IwbDhTSWRLVnZsZkx5TzhPOEJSYTJkd0Y5NU5Mb3hWQktHN2dG?=
 =?utf-8?B?OFNPUi9xYkFjK2ZiSzhkeWU2UjV4QTlvV2lUbVlYeFlwTlJMeXlxM01aN1RI?=
 =?utf-8?B?SDltRVJMMWExS2dsM1ZseGo0d2hPeWU5UzNmVEVORjhBRjBVVnZnc1pMa1Jj?=
 =?utf-8?B?UVNUMnRCMDZ5M2FlTGFWYkZDRm05R3k5ckdjRjlFakpuUnAvS0dBdGliWTZY?=
 =?utf-8?B?OW1uSHJXSEQxWWQzQ2ZuY09ENitSVVVLSTRXSGpwTjNtcmc4anoxVklwNXFN?=
 =?utf-8?B?YVdpU1V2QndIc3Y3R2p6eXpyVUl6WUUrNmRPd2ROa0hKcmF6UGxXSC9MUkJx?=
 =?utf-8?B?dFdIait5ZUlyOFZFVXFkUGFKVHVzSU5BdGNwYms0VzdkNytGRTFwdVNJNnJY?=
 =?utf-8?B?ZEx4MWkwSVNLNFJqOWxaZFJEMzlDa2RORjRzbXVzWTJUL0tVQWF3am9yazRU?=
 =?utf-8?B?ZEVrR0ZhNnBxWkVNUXFDY0VMNk4xMUFQUHhVWkNPTFlMNDRVQ1VjZm45MzA3?=
 =?utf-8?B?SjFYQWxRQ2M1ckxBQmk4MmRuaElhRTE3YkFCSDVhTTcvTllNZFIyY284cHdQ?=
 =?utf-8?B?eURPQzBGb3NFZmdJOFBYdjNaQnNBM2ZESEFDa3o5RU9tK25PeFdRWjByQVlI?=
 =?utf-8?B?Q3c2ODdDM2FsQmMzYTZsTDdPN3ROc3lFZCtPU1FjZnh4VzB4UEpFQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876093e3-564c-49c7-99ad-08de48d3d020
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 01:19:30.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMNDLdu0Qh+yYGIfWuHg79juyGbrv5mjAt9D/GGEWvlWGyx+VGlFCzV2XOMB42WjK5mheSTscKkX37CMXvg7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3160

--d547sj7ydjrl6zsx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Tue, Dec 30, 2025 at 10:16:30PM +0100, David Hildenbrand (Red Hat) wrote:
> Just a note: I have the faint recollection that there are some arch-speci=
fic
> oddities around mm_cpumask().
>=20
> In particular, that some architectures never clear CPUs from the mask, wh=
ile
> others (e.g., x86) clear them one the TLB for them is clean.
>=20
> I'd assume that all architectures at least set the CPUs once they ever ran
> an MM. But are we sure about that?
>=20
> $ git grep mm_cpumask | grep m68k
>=20
> gives me no results and I don't see common code to ever set a cpu in
> the mm_cpumask.
>=20
> --=20
> Cheers
>=20
Hi David,

You are correct; mm_cpumask semantics vary across architectures (e.g., arc)
and are even unused on some (e.g., m68k).

Rather than attempting to standardise this across all architectures, I
propose we restrict this information to those that follow the "Lazy" TLB
model-specifically x86. In this model, the mask represents CPUs that might
hold stale TLB entries for a given MM and thus require IPI-based TLB
shootdowns to maintain coherency. Since this is the primary context where
mm_cpumask provides actionable debug data for performance bottlenecks,
showing it only for x86 (where it is reliably maintained) seems the most
pragmatic path.

I can document this arch-specific limitation in
Documentation/filesystems/proc.rst and wrapped the implementation in
CONFIG_X86 to avoid exposing "Best Effort" or zeroed-out data on
architectures where the mask is not meaningful.

Please let me know your thoughts.


Kind regards,
--=20
Aaron Tomlin

--d547sj7ydjrl6zsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlVy5kACgkQ4t6WWBnM
d9Z6qg//U7q8T2jic0eD44uhX1qzNzl2E+mGn3v0ZYZ6ZXDHtmfjUjXJGqWPaTXE
jUOnt4EeMlPurfc0TNTlgEtN+l8lbzWR6oD0M5yWAFpKD4RTxI29psVFpjgBc9vm
YHqBTzvmCduchyoMoMJ6SJNpACdFEpt0iUxqM5b0KTzz/G6oMTQ/pcP9bsp6A31h
Axe2UfUzH8BeERmuhF/kPPb6sTs93GNb0Nxl8XDocAdWDxv+r8L0r6eDCJGhmJLd
rP6YjszuuXRKKVLiuJ6Od7ieF+DvMx7Kb2HZ1PX7plkvoPwsrFAdFXMzEvo8iNp2
Pp3kqoGB5JgmAos+fbt7Zvk4p9krrtr5g0U9ubh7Ffy/bwETETTot+7UPYxtS8Xv
v/ie18+qq7eIuVnYBkdWDBumzn4jvc/ww8IHwxmbK7Xg5onpwUdhzEcAiszx4l67
m1CXCr5zsmYEE7KTru8aw9UiXBzdP9iteWqfWCuK/eUdxiSOKDloNyctu9v5HJNV
VYqG1xf27sC0SxeP632DO0l61LwSnQ8biowpLR/32EXyeCYY1/NmTlvCxIrxDDwF
sJ397dhob/BAqr2be4x6no7vYN152Bq4eyUmBKgBTCyQ7bc/TgI+2Nm/Db7r9DLR
e9atzHESLeLkOADQzq2hGxuc/awKdf0Nqgi2zm0EmYU2mEg99vo=
=CtVG
-----END PGP SIGNATURE-----

--d547sj7ydjrl6zsx--

