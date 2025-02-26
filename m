Return-Path: <linux-fsdevel+bounces-42704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3AA46646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16CA19E3432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B3223704;
	Wed, 26 Feb 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKgzlSyt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DZmU9kg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978B223328;
	Wed, 26 Feb 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585491; cv=fail; b=c/UKomcG+CaW1WcvEh56LRjYOZYAUu2OseC3yHHtuK/pExC+jgVVZCyS60ks5X1JZ3NgTGVCW/620jZQx92BRbth3wFbaDRVXhWAdUzfKqBp1n1lgzXctEnEXbPNyepZQS4lxk6QUPyAIGuHdTTVr489Seyv+czGEkkMHer2gqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585491; c=relaxed/simple;
	bh=cSbcfH9T/GL2/fh6qblHPf/Ml38ObywfpTD2+Elg3Ks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m6zhhNcMLXiMUBhsPWr36hg4Rv5aGmTNuysLko4hz0eBew9iTg/cg/nOMgxWwJnWmiin9nCVHi6SzHUt3SKhSzIFGvUBouyVV8KagBeYNBfxmeU4BltLNyAvtOWiTDy0FufxQiiGSjQMa/YSp1T6+DZK3/0cLy6kpVNh4jSrQWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NKgzlSyt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DZmU9kg5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtbaN002664;
	Wed, 26 Feb 2025 15:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xGh1ewtQ9CMudCShyS6EGcD8Rk5m/+t7hrew5ZRjdmw=; b=
	NKgzlSytU8+c77mlW10W5/tF/5MrCdHyPSyf6UzYS8yAmPaJD0UZXBRekIRdiGmB
	98lWILZnWmYdZyeh9yvruhVhbwhyRRO+MKtSC+usBsD0ToMq3PCLs7wi3fXuzMAf
	7OiK4yUMBR1bNd0oyMfwhnMOQEqlxDDekQyM3L66unYADuaAtjhUeTF5IUhBNNfo
	zLWJIp0PqU1LOnbCeO12kAydIr9gpEuuTwCPBkLUUFRW62TVFKzVga+IzzztgQ9o
	h4oYZfVyKHbMhTZi5GWQ+eEjENH8FhCWcBB2MRzoN7+uRryBJCLHIF/CAXa5NbOr
	0sHdCHUXJ5LIhJmeR4RxKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfsdnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:57:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEjrGJ010010;
	Wed, 26 Feb 2025 15:57:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ak6dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVKuM8enH/t9I1PWrjnWB/TVOivLFIXtkO2FpwHBZvJvXFSfdXKDfYwUIQlt5qgmbZYlCGfhJYtiKR2URKg+cctrDcA7oqr9jGWio48OtGxMA5d7dGXP4jTUJyMns5OsQMBRsOiqMLJGNslUbNiumYpHopnuOzgwtA0NlUbiCXubXeVSO0PaHaVdNsRI1Hxrf4OhsO+YVebxz9t/aNJ82STDgts4XmZd8Ewmwj0LWBXA3nFUtR6gw/ghb+TTjUBJrPxQ2P5RqbSBEXy5VIr1UjyPr0qUTUhdAJ6FNedD/ITrlLNgXcSrUuvu2HpNfk7z3BIl9XmOHuJWzv9XCYpt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGh1ewtQ9CMudCShyS6EGcD8Rk5m/+t7hrew5ZRjdmw=;
 b=x9bihNe7R7qNSMznQKCCaTy1aSvvzYiBM3q+P2jQTSXv9jCps4XP5bxFDRXWvvwmz5XXTmDfz5egcuZ02wIeECGo8ygJ/eysUyb+EAfY24geaU99pr/kIThFBtoLrnh76hLKjIuuDt8XVcvzMo9Z4mkBkP4MPkgVdsNx2+8JNnYT30Q8hZM5V3BIwCK2oMPGLZHNkxi8ttLiZQ1Q31NiPlunrzXQLqrgl30TD/qpCzdO3W1A7FZn0t+cMPGzvCtXo8m3ncN9oZsOoo3qTHr48mlMH3j+tZxdEmHmkF/Ri+s1SfuXICY7S6dVAyAuDwoQ9eslvdUlAQGs6HaB8dzE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGh1ewtQ9CMudCShyS6EGcD8Rk5m/+t7hrew5ZRjdmw=;
 b=DZmU9kg57E8I79rMbY/YgifffqsNM73m2Wfpb+p8unclvG+uEXP4DOGhbAXTlL9GGxceeT7JzH3OsigpoMP+oov3kwLmEfmQ0zBpdCErlAcm7etDYYTL8It/9OBvAD/+URdFjHLeQLI8RQXjaQ1B3Qf1FP3gwJ54kAD9r9QCoYs=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 15:57:51 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 15:57:50 +0000
Message-ID: <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
Date: Wed, 26 Feb 2025 10:57:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <2025022644-blinked-broadness-c810@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025022644-blinked-broadness-c810@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::11) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e9c966-5863-41da-a7db-08dd567e5225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZEeTh4U0ptM0hodHFvUnQzWVhLbVNnT2pQdlVCRlRDYTFsN2tUSDY3TFNV?=
 =?utf-8?B?eTNhVjBjVnlQb3NkYUZmcVZ6NWo0NjBVR3lYb2QxNFc5M1Y1RDJhYmdQZUls?=
 =?utf-8?B?b2hsUVRDdXlYbFBRSzdBNWplcUpXWlN0b0Z3alR2cXFTU0JYTDIvNjMrNzlJ?=
 =?utf-8?B?bVRQSnk5cmY1RDIxalB1V2hJeUh5NmZzRU8zSGYxMnJydFVrall6dG9YbkU0?=
 =?utf-8?B?ZTBCVkFqaDVjN0VSNUZEaUFlQ1drelpWM1IweDJqdnlHakM1MVhzdnpVQy95?=
 =?utf-8?B?MzE5d01kREFJNUIyNzFScFhkYWVFZHQxOGVBWUZBNldza2hadWdYVm92ZEdj?=
 =?utf-8?B?cTZBSXpzME1QV3VFbFF1MHVpbDRXVk0raXp4ZGFnYitqbnlvenhKb1pYUWpU?=
 =?utf-8?B?R2VwTWs3UW5kb010T2xtZ3QvQ3RHR04yOHRBM2trOU96bWNUVXFUTU14em1y?=
 =?utf-8?B?RnIrSEpXaWtrUGNYTDNkMDB6bVhVZW5xSGRPTXVRUDFFdXMydlBPb1cwWWFJ?=
 =?utf-8?B?TnlJL2c5NmJTRkRCUVNiaFhHRWRsMUFHMEJXQkpwT1FqQVkxL2FrVHJBTlJ1?=
 =?utf-8?B?MWtsTXJXaGVUQUtIaUVQTVUrYXl4WTlIR1lic2RYdUdicHdPd2hHMnBBOUlt?=
 =?utf-8?B?U01oY1hJSE5oa2MzZmV4UmJJeVhmK0Q3UW4vdmVhT0JjT29nNHhJMllsdkhU?=
 =?utf-8?B?cG9ySnA1bjc3bFhnUlc0YmZDblA3bEhZekdtaUh1bWFFWDJuT2c5OGg3OUdI?=
 =?utf-8?B?cDRMSlJvM2ZqWlF1cEhIQ3BkaHh0YlJpMEF1VzJ0cGxNQW9JQXYrR2wyZkdY?=
 =?utf-8?B?OUN6UVp6UzE0SlUyZW10TlV0ZjEwL2h5bGFTVzNNMVF1RWNoY293VFdRTXhL?=
 =?utf-8?B?SWp3QlZrcndWTm9kdEptTmk5dFJRMmx2eUFhVTNGU3Q1ZnRJMkRKYkdzay9w?=
 =?utf-8?B?Z2o3M2tqeDZ3VmlZNVJZL00rQVR2eFRGdU5qcC8wQ2o5K0ZhR0NweG5VWW9N?=
 =?utf-8?B?bTdxZVR4TlJTMDBJUDRjb2lNTi9McUZiRGhMVE95ZWxLR1lpN1M0UElCMUVZ?=
 =?utf-8?B?UGJPWXU4OGo0WmNDZTV2bmMzK1pxVlVHSFliTU94cC9IRHZRK3pKSjlWMG1u?=
 =?utf-8?B?R2tMVzdhVHg2bU1vc3M2aDlSYmw5VjVWR005UW00SGFpeWxkVGpmQ2h3bTc2?=
 =?utf-8?B?ZVZaSUJHSS9XTGxYNXFrSTB6cjVkNWV3M0VTOGhGbmQxV1hPb014TTFxaW1y?=
 =?utf-8?B?VUVkK1M0TC9jVkNhcWVvMjFuWUpMY3QxMUhrdDc0OWZLWUR3MTAzTnlWQmNR?=
 =?utf-8?B?V0c4L09kRGZ1SkV6c0RmUjBueENzWU1CdkxzbXpySUwwRnU5cXFEK1NWMU1s?=
 =?utf-8?B?eE5ZMkp4SUJnc0lIdEswM0REVU0zTHRMYVU2ZlVVRFNzcitFUGphVkF0UU80?=
 =?utf-8?B?TDNTOU1JaGJHYjB0YkxWWWdOSVJkLzJSWUE0dHlFbjd2dUxDOUp0SlkrWUxL?=
 =?utf-8?B?YlAvN0VMMDVndUxaTlM3Z0RVZmN3Rjk4THNGWEswdERpd1ZaSWNrbjl2a2o5?=
 =?utf-8?B?ZXIxTDFPTDdSWFAxODBCTWtLejUveXdVYkd3OVBhYy95S0RyanRUYUdiYndx?=
 =?utf-8?B?TjB2Y2I1cUdLYkd6bmVjdEFVKytJdUd3Z3BWOHVGWmpJTFJnS1pwTExJNTdq?=
 =?utf-8?B?Q1RjczhKRVh6VnJ4Z0N2b001R2FWbGpDZC8vajRKRXA0ZDhWVDhNcnRPZTNB?=
 =?utf-8?B?SkhsR01KLytZcHpmOGdkdWVYREZXUVAwMFFqSkJNY1RyTzdLM2ZSSGFNMnU2?=
 =?utf-8?B?OHQwbHV4STBFa1Zzb1BIZDc4V3RIUytOSFQ4ZVhXbVhUZnRkSDhsSklvMDZD?=
 =?utf-8?Q?nIolpDuB/G0f5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmV4UVowOW9MTERtMWV1a1ZabkhvcXJNTTFQaXcrNGViREpPVjB2Y1lQU1RH?=
 =?utf-8?B?WHlXUzJ5SHNpMStvb1JqdnNDSHFNSHVyMGxrcW1HK1lackRGaHZiWHlzWElu?=
 =?utf-8?B?ajM1c0N1Zm9lS3dTOURnYmlMLzF3a0FzWkdIZnd3RzByb25MQS8zUm9EVHRo?=
 =?utf-8?B?WE1JOEpNU2tqMm9CZm9OTnU2aUNOVjdSaGdoZEZkU0lpcUVBanZaUFB4T1Ew?=
 =?utf-8?B?V3N5K0FFais3SVhrYnhhRnkwcWNoeE9MR2ZoY0lWRFQwaDR4aTd6NXZ6NUtz?=
 =?utf-8?B?Q2JLVUM3UnF6R0doLzEwSG41MnhHa1E2cWtCYXNBSDByakFrK3U3d2pJenp3?=
 =?utf-8?B?WDdjM0wraDkvL2NCNFkvYkZSMWtVVnNsSnlGUlU4bEhhQ24zdDRyY0gxYkpx?=
 =?utf-8?B?TUJJb3EvaUMvME9YdTc2dUVCZjVYbFFBVmFxTVU1Y3NINk1yUllpSjR2dy9o?=
 =?utf-8?B?b3A4dU9mWWJRc1dJeFg3QWp3RnNBU1BjZlBoZ0NTUm5QL3FRV21NT2RMMmZH?=
 =?utf-8?B?dWJjK0VaRkEzTmtRNlJwU1hRNERxUHl4aldsNVBaaENoVFhBWW1tcHdiaGIr?=
 =?utf-8?B?c090Zzl5Q1p3SUo5YmFkamtSYng4aEd6cHkvQW9rbXFGWFJnYmJubFlMaFhD?=
 =?utf-8?B?TjFFVDI5Y2lUbjF5a2Fpd1Awc3ZVS1Jyd1FJUjJCdUdJYS9IZTlaR0w5WUx4?=
 =?utf-8?B?ZkNCVEZ2OWdoZUhoMk9NTk9BYXlSUDRQZDF6RjJ5S3pBL3pkQmsxM1JsemxH?=
 =?utf-8?B?VTdLK0p3MjZXZkROalZZKy9pMWt3WXJmSk1pM1hHMWZvOE5GaVN2QjNTWVBV?=
 =?utf-8?B?dEdnc0o5QXdCbkgyS1BjWDN6UUpxWFR4d1ZGVXlrc3QzdjhVL3VLck9aUE9C?=
 =?utf-8?B?d0JqU3VyLytoTE40OHV1YXhVaWdBVGgvemxhTmJscGRPVWo3RWZyZk15TmVl?=
 =?utf-8?B?TEdoU0d2aGI5NGFFeWdicTZhdExWcFBDK0ZieVRiM1huY01qSno5SFg0RnVG?=
 =?utf-8?B?WEdsSGlTcU9USjdpUi9zMkJQQzZMOENKaVp3eDhhMC9yajlQS0g0alh6V2VL?=
 =?utf-8?B?clJPZ0ptcEhzbzhhMUVUYkRJa3ZjYlJZYWNSNy9WOGdKWjY1bnQ1K05YOHVW?=
 =?utf-8?B?YXdhTU81UnZYVjlvOWllSHBvNm5vZ051bzlQNVl0bjlFN01TcXFndTV6TXFh?=
 =?utf-8?B?ZDNOZExQNTlrZk1xaWtTTnVCNFYxeURtS2RUbzl3N3BzcmlXcDJtUkEwakI0?=
 =?utf-8?B?V04yZXhncEZ4UytqVFpONnY3R1FOTFhyZzhFQUk3ejdrMm1MelcyMGRqb1dl?=
 =?utf-8?B?TmlEM3VUTWt4VDhYZXRNN2hhaFZReHlOT25CNExsVnBXdjFnQ2xpcXYxSzhp?=
 =?utf-8?B?MmdvTWxXYW4xNFVGU3lTU1pSYkFaQXFHZlE4T080OXM3bEdyOHFhWmJveUZ0?=
 =?utf-8?B?WWZRSFptQ3ZWSVFkcThQWkd0RFZEQmwxWGhsZE9adnFIckNmcFc4TUEyWGU4?=
 =?utf-8?B?aEowV2laSGRUYXFuenZIT2s1c3NlRjFuY3ZuSlF3MzBEMEU3NkoxVTdKdlRK?=
 =?utf-8?B?RDc5a3k2d2lSN0tEdThJVis0Y25ZVGJGMkVGYWdMRlY1bDNzNGNmL1VrdlNU?=
 =?utf-8?B?QWhBWEk4aHZKNHhTMFdHUlVwT0hoOUVqSnVwTzdCSzlYTElSUFM1ejF1SUxk?=
 =?utf-8?B?N2JZcHVNbUR1bnMyUTF2eGRsOS9VYUFIaXR5WG9tUUt4QzIzblMxdHFvRjdZ?=
 =?utf-8?B?dmprNE9UYnc1MXlvTldJRERDVlMwRkV4aEtaWVN3Z2xoMUdDOWpCUEVVcWtp?=
 =?utf-8?B?MUlxVlJ2Uk5Vamt6ZlQzTXVzb05JTVI1N1BCc1BKY2drTW0xMTUrOUx2aVVJ?=
 =?utf-8?B?ZmdnRlo3VGNnclowRlgxOXF6MWtkOXhRdk14Si9wYlUvRFdINEdHdVJ4QXhD?=
 =?utf-8?B?WFM4c0RzaHdmQmFrQjFYb1hxUXpESEFoSXRIeWFKUE1zK3NqL0JYNDI4dmxG?=
 =?utf-8?B?WENaTm1yY1MvcXh5bUtVTlZEMVVmcEpYV1FTaUNuS3BpaHdMVjVIbUh5T1Fz?=
 =?utf-8?B?S09oNFFuNnB6YmtGSmRYeG9pMXRUSW0ySW5qM2tnZU9FcG1nTDZIK1lNU3Uv?=
 =?utf-8?B?cTIwQW9GOUhvajk1WmZiREw2Y0xQR0Y2aENnOGNCY3NTZE1lWk9LRG54c0Ra?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m804xTDqhx64pk2mzwkpD9TtkHUPwozCzZGj20SpfcyI87kEh1k3Ry6KESvZAM5bCZ4r6IIFyKErBcYotqAU2s4rNRFhB4a71yAvCN3ocaOPLwu5Tf9Wk7iEBxxrL5h3WyabH8tMw+0NHPOhAqmtk1iqJ/bDJ6+5ibLSJU9ldESowt7sB5mUVu/JS5VkzbpA154WgFBa6KFbmAB2RZ3Ri6X3p/25i5PzCYyfFU6ayHPB1J4xnatnQAdglc0j2e5HR/XYhXIUoS8mqWkUoqG0NDn03uqfvehUN3JIvr5mE7zxjsq/4MGlhHl0pycRh09tOD3lbTI+HTs7H+Vp0UTH1mq2PsSPmIpoUy1SwiH0JMy52X5zW5mV4Y2ThZhJJe5qPqrkDcHbdg0dcfnt0Bp/B6fHGM35irlbcp/hCsRJ2Vn6EBKJ63l4nKSTE0DXx5NPugAVNbZMTG5YvlG6piN9I6AUoushCiindKkAGL1mMwy0eHmJVIZYgdo4IKANzpVL3PDUTXA0Nj1TEWDuMT0IJQcYWwixzUJE8Q7ypzgPQa+hsHMeEc4fejrWmjS6an4za8LDOIvRWSIvb14tbvpiYxanqCRwqDq4QRnvjbLvkS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e9c966-5863-41da-a7db-08dd567e5225
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:57:50.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D9RYt+mQle1MPUBbFnSLkCFn3HXLnE5zUHri/k6hVKNoN934M/wDfMsJ3iP8QcT8AKR0aoDOfz82zH3iJOz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260126
X-Proofpoint-ORIG-GUID: TE1_Xq5ACpeMUSR4t0_7jnbOYTpDruyN
X-Proofpoint-GUID: TE1_Xq5ACpeMUSR4t0_7jnbOYTpDruyN

On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
> 
> There are reports of this commit breaking Chrome's rendering mode.  As
> no one seems to want to do a root-cause, let's just revert it for now as
> it is affecting people using the latest release as well as the stable
> kernels that it has been backported to.

NACK. This re-introduces a CVE.

The problem is we don't have a reproducer yet.


> Link: https://lore.kernel.org/r/874j0lvy89.wl-tiwai@suse.de
> Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
> Cc: stable <stable@kernel.org>
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/libfs.c | 90 ++++++++++++++++++------------------------------------
>  1 file changed, 29 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..96f491f82f99 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -247,13 +247,12 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>  
>  /* simple_offset_add() never assigns these to a dentry */
>  enum {
> -	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
>  	DIR_OFFSET_EOD		= S32_MAX,
>  };
>  
>  /* simple_offset_add() allocation range */
>  enum {
> -	DIR_OFFSET_MIN		= DIR_OFFSET_FIRST + 1,
> +	DIR_OFFSET_MIN		= 2,
>  	DIR_OFFSET_MAX		= DIR_OFFSET_EOD - 1,
>  };
>  
> @@ -458,82 +457,51 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  	return vfs_setpos(file, offset, LONG_MAX);
>  }
>  
> -static struct dentry *find_positive_dentry(struct dentry *parent,
> -					   struct dentry *dentry,
> -					   bool next)
> +static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>  {
> -	struct dentry *found = NULL;
> -
> -	spin_lock(&parent->d_lock);
> -	if (next)
> -		dentry = d_next_sibling(dentry);
> -	else if (!dentry)
> -		dentry = d_first_child(parent);
> -	hlist_for_each_entry_from(dentry, d_sib) {
> -		if (!simple_positive(dentry))
> -			continue;
> -		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> -		if (simple_positive(dentry))
> -			found = dget_dlock(dentry);
> -		spin_unlock(&dentry->d_lock);
> -		if (likely(found))
> -			break;
> -	}
> -	spin_unlock(&parent->d_lock);
> -	return found;
> -}
> -
> -static noinline_for_stack struct dentry *
> -offset_dir_lookup(struct dentry *parent, loff_t offset)
> -{
> -	struct inode *inode = d_inode(parent);
> -	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> +	MA_STATE(mas, &octx->mt, offset, offset);
>  	struct dentry *child, *found = NULL;
>  
> -	MA_STATE(mas, &octx->mt, offset, offset);
> -
> -	if (offset == DIR_OFFSET_FIRST)
> -		found = find_positive_dentry(parent, NULL, false);
> -	else {
> -		rcu_read_lock();
> -		child = mas_find(&mas, DIR_OFFSET_MAX);
> -		found = find_positive_dentry(parent, child, false);
> -		rcu_read_unlock();
> -	}
> +	rcu_read_lock();
> +	child = mas_find(&mas, DIR_OFFSET_MAX);
> +	if (!child)
> +		goto out;
> +	spin_lock(&child->d_lock);
> +	if (simple_positive(child))
> +		found = dget_dlock(child);
> +	spin_unlock(&child->d_lock);
> +out:
> +	rcu_read_unlock();
>  	return found;
>  }
>  
>  static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	long offset = dentry2offset(dentry);
>  
> -	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
> -			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> +	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
> +			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
> -	struct dentry *dir = file->f_path.dentry;
> +	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
>  
> -	dentry = offset_dir_lookup(dir, ctx->pos);
> -	if (!dentry)
> -		goto out_eod;
>  	while (true) {
> -		struct dentry *next;
> -
> -		ctx->pos = dentry2offset(dentry);
> -		if (!offset_dir_emit(ctx, dentry))
> -			break;
> -
> -		next = find_positive_dentry(dir, dentry, true);
> -		dput(dentry);
> -
> -		if (!next)
> +		dentry = offset_find_next(octx, ctx->pos);
> +		if (!dentry)
>  			goto out_eod;
> -		dentry = next;
> +
> +		if (!offset_dir_emit(ctx, dentry)) {
> +			dput(dentry);
> +			break;
> +		}
> +
> +		ctx->pos = dentry2offset(dentry) + 1;
> +		dput(dentry);
>  	}
> -	dput(dentry);
>  	return;
>  
>  out_eod:
> @@ -572,7 +540,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  	if (ctx->pos != DIR_OFFSET_EOD)
> -		offset_iterate_dir(file, ctx);
> +		offset_iterate_dir(d_inode(dir), ctx);
>  	return 0;
>  }
>  


-- 
Chuck Lever

