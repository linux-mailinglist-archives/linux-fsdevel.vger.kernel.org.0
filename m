Return-Path: <linux-fsdevel+bounces-74702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEUwNeDZb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:39:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E41C4A9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8B4F782296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAD313291;
	Tue, 20 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uJW9RQNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020100.outbound.protection.outlook.com [52.101.195.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8A350A1C;
	Tue, 20 Jan 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929161; cv=fail; b=fhRrfY/Q8ONIdzG1cPavL8zo69lu/JZd4R1LMzQwMfdeaI1ey3qztjX3A4bR43tW81cwx6bu23wIlPhE1KgUwDcFMKel0NkXvhpL578LY29Tf1Jc3IPukmSdGgkh38HxuowyzXuSUc/KKHbVUDzyv+diRThSTP8NRiNZi+EhGiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929161; c=relaxed/simple;
	bh=0puPIKtM1sycLbJ9ftG1Z5wJCCFwun23vxQyH924ZDY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YO/6SSmKMOtWKBet38bNvgp74W0MXKVo50XEi4Pk5JqhqRb+KvIQUbKrwVmKdX+b2m0tBZAgVqK950RjJ9M3Nm9ki7NPeqJs/zzajdRkkcGVH9vZx0qF0vN1QKXIb4wTmGi3FlMr6GF9/2S7OGqhwutkCnUYlIPwvU/n6d8ZhVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uJW9RQNu; arc=fail smtp.client-ip=52.101.195.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvNe/XqfxKhgEoOe5BOr6sBcP1Xy5PMdl4LFOBWLVCFirfoILCNwTPDC/ZUV5dWBzOurSpssiZxGSn+GnFPYvOZ7xRlS3W9JSdw9NC1cjPQR5zoENFwbh+kJBdP2yQ4GDcxV1f1HKGF211ghLG5g2TdHnAaApQBa3Y4io3ePa+4ufGNopnzH3PmM8sT24t1DGLvPjO7tMUmBD6dtEpExIwKdnEf4aHprJTrlTFTZ3PiEIiLx8kHZ38uFVbMK1jVM3P7sX7nOQZQcPWgN7nl/nWbpKFhPt4mCIJYsB2V+L2srriwIlthkJS/RtJAOIw15lCOrFGk36nh1MBDnEdNqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NNRqb23Utmc/V0dkcVb0HjsJhxSUJb5OXrhCNNH1AE=;
 b=jWZNnQvZk2+Ez4N4pxVmOjBOj1IuepcJd2LcOtBjCTLj5TydBJQkfsGbwr07hKA3VEk7nw48cUe9ef/mgbD5RqJIV3B4AmSsEfIfxEH4xXhxqDYRNnT4wPh/UwmGIUTWR4PoetHGCcaeAaWWvxNMyu+2JFurzAQAA5QNhyPEQhqqnjRP2CN4M5dQcdXXsLN1E6tnniGk+dl8TX0juWCBLfPQI4Qc1TJLnCpaHVDrzP6GrHCD+v+PWfAgnjBfVIiGnAf8fhhqSHvStbjz+JDoLSXd282f+RrRyVsS4BXHjmyiQhO+iGeBH+YC+K1gUt3C3303goQ2ixOwSTWjc8fKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NNRqb23Utmc/V0dkcVb0HjsJhxSUJb5OXrhCNNH1AE=;
 b=uJW9RQNu63TGTVmLpmVER4JenMyBYPY8cdIR04tn6EsV6knigocecSbQGBCoajIXRosQQgWnc63Iau4G5369SLq3PEdrrUBnRL8rqxdMVBLgw7DvxMMPbrm8rVrkgHErr4DKbnm1O8dt2wEzEOQMyNvawQv5iGx/M4dyjfJJHbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3274.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:12:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 17:12:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 17:12:35 +0000
Message-Id: <DFTL1VEGDRZH.3SRFEE9L1XGEE@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <kasan-dev@googlegroups.com>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Gary Guo" <gary@garyguo.net>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>, "Paul E. McKenney"
 <paulmck@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
From: "Gary Guo" <gary@garyguo.net>
To: "Marco Elver" <elver@google.com>, "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
In-Reply-To: <aW-sGiEQg1mP6hHF@elver.google.com>
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: e515a239-a584-42dc-c9eb-08de58471b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDBSWHNqVlRvTnpmb0lxNlZRdXRZUi94UDZpUGhwRzNKZXU2ckdCSUgwdE45?=
 =?utf-8?B?a0lYYXJJQnFVVWVhT3IwODg0cGtLNTJnWE1RSk1JUVl3aVY4NHkyYm9ySmJL?=
 =?utf-8?B?Q3UvZEdaeUV2L0VXak5KV3pobyt0SEZoZStYUDIvdjBWWnVkaVgyMnFDYmxF?=
 =?utf-8?B?dWlKZ1lIOUp6MXZGT2hHTVFJWEZvdndheHRIS2lZRmdaTGtHb3VEdjF4UXA3?=
 =?utf-8?B?MUJ6bFlBMjM0d0hlSlBCRVhQZFhyaXdoY2JIa2R2TlFOODlGeTBra0hoa1E3?=
 =?utf-8?B?aStDNDM2cGJLenBad1c5WE00dWVrZDc2bmFFS3FTNENkUTlqeHB4UjR0cVBy?=
 =?utf-8?B?RjNiWDJWa0Rzemx0ZlZpV0JxbU9SOUdBYi9HRVpFVm1CZ29JQ3diYm5wVnJn?=
 =?utf-8?B?TG1YNytpYUM5Tkk2OHlMeDVKejMwZEkvRFhTK3UzeU4wZk9xTUp2b005MDFM?=
 =?utf-8?B?YnRRU1pmTi94MDZhUWpodlpkaWNJN0UwQkVxWWdrOUhWYWExbmJTd0VGV1kz?=
 =?utf-8?B?WFlYT3RsZU44OHk2aHNxbWZtcjNrYWF0eGN4ZU00ZDhOTXdxbHh2TWVzRVZR?=
 =?utf-8?B?elVZakwzS0p6dmJaWmhTbzZEYUR0azZnSXpkaXJJci9MUEVGQ2pSb3NhNWgw?=
 =?utf-8?B?UVdOTEYvUVo3TzNXeXN5L3hmS3h6U0tXZUl0aE8wSXVsdUU3ZWZsUDNPQ3U2?=
 =?utf-8?B?U2g1bkhLaHVqODFndmtDdzdBajRoREdhNFJsc2lqK0xlZEdLME85UjhlV1V1?=
 =?utf-8?B?MHNBVGY3TkpxbmQ1SHdoOXBQUlRZL0RGc3B2LzRJNzRCTnF5N0NIWG5CekQy?=
 =?utf-8?B?T2xER3k0RFErS3dqYkV6ZkFXbDg3bkZ6SkZPZEQxN1dGcU5GWkNmSTk4bGxl?=
 =?utf-8?B?MUFQSnZMNVJUNXlQL3JmbWI3ZkhvcTFjNmwxTWl6S1c1MldJLy9Ba2JQbU0y?=
 =?utf-8?B?UFliblpoT3pOeitpUmxXdWl3RDZKSDlmdTZZdlVOSUJCRXhOWEVrZjgrOXZu?=
 =?utf-8?B?Rks1THErd2I4QzNOYXVISWwxNHFOVk0vdnZjOHlyK2c3NDZJUXR6YXdTN3VC?=
 =?utf-8?B?RWFHbm41ODBBUExCNVY5aWV6TDZ2eEtDVzJ1YnBtYXROSW1ZcjJ1WEFpczUr?=
 =?utf-8?B?aG84eVR1SGZCN21xV3k3R1pTQmlSRktURGNhd2dsZUlHUndVek5ERERJaCs3?=
 =?utf-8?B?bG9UVEw1d2pLMVErWWN3Zk9lZEY5dzlRKzIxMXp3UDFtYkhVTmo5dGZJN0J0?=
 =?utf-8?B?bDZQTk9ZclVzaDNZSUloTXZUSFUwbnJabEc5MTEvNGo3UEVmcktyNjk3Smc3?=
 =?utf-8?B?QXorYzRCM3hsYy93VTYwNFU0UlJXNnpYMHRLbzdMTXFHd3NIYzZPdUZ1MFhG?=
 =?utf-8?B?b1RLR05xZ3ZhTU9XSGZQTkhDNjJsR1Fwa1NnUCtBK3pBVHRWRklRMmk3UDdK?=
 =?utf-8?B?SjdKelloTkhxMnIwWTJ0ZVJmcm9PclZKN09Qd0hrRllIU3gvT0ZXYi9jN1Iw?=
 =?utf-8?B?b0hNcU9NTkI3SEpGTm1QWFNRaUtrbVRybkV6b2lTTy9pK0p0bW1UQk5yZExz?=
 =?utf-8?B?Q1cwTVBJZUhuTzFsMnc3M3lENFpsK2ZHRzFHVVp2dVlhQjFraFZvV1hJRll3?=
 =?utf-8?B?YXEwSnY4TmZsMkpkOVVzTDZIWWpLNVZWN0gyM2s4SlJ0ZTRhSGdKSEF3dkxK?=
 =?utf-8?B?SU1sR09IWE0rdURsT1ZSQUx0S05BcmIwTDk3bzlCZjZiVmJsc2dtU3ozc3pM?=
 =?utf-8?B?SWJValNNaDVCNGlkSTJTeFVxUzR4UzQveFZmVUUwMDExakRjaVBNb1FxK1U3?=
 =?utf-8?B?QUNFVmpjcU9SUlcrbGNwMmJvNG5qYXJjd3NwS0JzMnM3MDNZL1VxcFFCTW9K?=
 =?utf-8?B?anJnUHlDVXVkMkpsVEM4NUJIOXVpcytFQ1J5MitKdUhwSWZqQnp0aXcrOWV6?=
 =?utf-8?B?NUFXYkJzcDFJdVJPVHY5eURSNThzdE5rS1kvZGdwYXlEQkF3amZ4RFhveFlr?=
 =?utf-8?B?MmZ4VUxOQUU1S0ZrRTF2VmYwakp1RUxUV0o5aFdDZWRLUVRrVGJTWlFWdG9P?=
 =?utf-8?Q?X3HzH8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anhIbXp1ZDVudGdGWEQraUd5eXo1QUluSTA2dEFTNnlLNUw5eHo0cVBrcUEx?=
 =?utf-8?B?dnd3c3cyMExwMDNjdHRVckpKM2pRYkRBU2QrTlJkdVFPU2grVHprd251eTBI?=
 =?utf-8?B?SSs1Yy9JSEZuU3FHRk83dUVtbUs5Mkl6VTRqZm5qNERrY205RmNVeVVrc21h?=
 =?utf-8?B?T0lRK2crTW5Nem9icktROE9pMGppVFdoS2U3K1QvcGQweGZaNUtrRUNyeDFY?=
 =?utf-8?B?blBVTmdqOFpTeVhMV0pLNFNJTDE1N01iUk84WkplOHN4WnNIbzh3ejJmamxa?=
 =?utf-8?B?YWpmNzFKYS9ybHNBSHRkcWc2b0p1ZGZnNDhoRkYvNGJKdWlYQ0s2Q29BUGhB?=
 =?utf-8?B?Q0VlY1lUdWNLRlBJRG9Fd0hZREpkaWllSUFKVFZGUkYzK0I5QnNpT28rNGpv?=
 =?utf-8?B?MzF2ZGRCNEc1NWhLazF4L0pOWVh3VEJRanMzbnV1RmpaS1lsU2M4TjZiOHNQ?=
 =?utf-8?B?M1YzQnVEbkx4VVRZT013SkJDaWRxMVk4N0ZVT0ZIb2gzNnU0S3o3SXNsUVho?=
 =?utf-8?B?Y1JwUmM3NUxRZjVBRFVjMXFoeGUybENDVk1ucFVNQVVTWjJQVXpZMDVEV0hV?=
 =?utf-8?B?blZ2cFpEWk5pUDF4Z2NLK1VsOHc5ZFQ0R3dHS21OQzAvRzdWVm5HaGZRWjJj?=
 =?utf-8?B?bEZidGdrYzdkTWRZZ0d4VjlwcXJYb01RTE9uUmhKUVd6cGNDTDZvKy9zRHZU?=
 =?utf-8?B?NUJZNkhQQnUrQ2RBanBXalFkOGpudXhIejBieEowUU1RZzh6eWsrR2VmbkRV?=
 =?utf-8?B?M005bEtYQU1KN0xDb21QMjBWS1d0YlpleHFEejN2VmJvdFZaTEEwaytheGV2?=
 =?utf-8?B?Z0M3MnZ1dmwzTWpwK0ZMNHE3ZkNtOXp2Y0FqaCtDMHB4QisxTkJnQTAxQkg2?=
 =?utf-8?B?TDVGU3VVdU1QOHVkVkxRMWgyQ0N5WkZqU1M0QndLS1Bvd3YrLzhUMloyaXdP?=
 =?utf-8?B?a3JnWmZZcjZORFlCU0VDNm9vdEtDb3RSMWkyY0FCUnVyNHRDZkhBTHBBbklO?=
 =?utf-8?B?dUFqWXBWSDNVMkpGdm52UkszTURnc3pDbGFsQktyK3dtYTBUVkVaUHZ6c3c3?=
 =?utf-8?B?WEJId2F0dzJ0ZHhYTzY1eHZSbFJxWUVRNW9lT0NpU01xc1ZQTVRsYUlBTmdM?=
 =?utf-8?B?VXZneFlNeVZWWmI1L3pDQ2VEbDlQdjg0djRDa09UWXVhdjdZbDEyMm0yNVky?=
 =?utf-8?B?eWFWaG82NlJRY01zSThjc2ZoNCtBdnJZMUJzYndvVnBpWEZqQW5kV1JtZFVM?=
 =?utf-8?B?NUpCNWp4WkZLYjZyUjhwdHRidWdYd3ViT05nMk1DWUdzSjBGd00yYTIwV1ov?=
 =?utf-8?B?c2ZkRHFyMGR6aXF5K1Z0eC9pSjgrQWdpdlcwMVZMcGRxdDhzeGlFRFhhRTg1?=
 =?utf-8?B?RGZFbmJPL2xaUkpZNVdrQTRYcTlRcmVtZXJUTFR1YzFEYVJJdnhJdGtjUC9h?=
 =?utf-8?B?NWtyMnZVK0c4d0FDTlhKRE8xU1RSQ1M0T3BCRGVtQ0JTMEVBWUtib0wzWDVo?=
 =?utf-8?B?Nll6SzExemlxTk9DN0djUkw0alVLaGMvTSt2b0VNQmVDMmpQTkZIaVZlbWtP?=
 =?utf-8?B?Z0dIc1pDS2xTMHVoMGJzcWl1Q3BjTzVaM0o4TzRNbTJpUVdTM2Y1bmsvcHg2?=
 =?utf-8?B?bnVvSDdSWFhqYVVTWVcyd0ZWaVpzeDFHQUNuaHJuV2xWclhyOXNFWDZxa0p1?=
 =?utf-8?B?UVg0V2sxemRuYkJleEt0QjIya2lnZ292QVJjU01hTnlCZDF5d1NpR29oUnNF?=
 =?utf-8?B?QU41QmRZK3VFQVU2K0sxU2tRM0ZLWVJ1MEhnTUZUeXFlelZJMFpLSmMySnhJ?=
 =?utf-8?B?WGlQWEdHdDVRbk9USjUrNVBGN2p3QjEwaEtGQ1BGTkFoUTR1UkJDeVpQcCs1?=
 =?utf-8?B?OWRhZFQ2UVdUaUU0bEx4TXhYUmFxM0lLRlRibzBra291cE9oZ3pyNGlJb0VE?=
 =?utf-8?B?aGg2aDh0NExpYWlaZUI5bzdMUUlSdlYrQktTWURYU1RCMHA0TzN1dEpZMnRv?=
 =?utf-8?B?VHNrT3c3QnB3Y1pxWHdlOHJLOGVGNTF3bEpsdG5RU3JqOHRzYnUrQk5wclY4?=
 =?utf-8?B?V3VSV25Edm8xczFLUkRNS09zKzM5dVJXWDdrTndMR2ZMZXRFSWNESVQ3WVQ3?=
 =?utf-8?B?SWxJQXora2o0MCtkLzFTeEVHYWtxTE9saXdOUGdmbkxZUEZXL0lza29PWUdM?=
 =?utf-8?B?UmxrcXdUb0NXUVkxUVk3VnlPV3RHanpnTStKcVRxQVlUZzR5eVZvR2pFTHoy?=
 =?utf-8?B?Sm03djg2aXpIb2NRVFR6QmtHTG1uWjFwRGdkTkpMeEU4SGxlS3JiSkxieEVZ?=
 =?utf-8?B?TURDaDB0dkdJS2h3eFJmb2xKUGpFOHlSbG5ZaWdLNDFOWS9HNzhZZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e515a239-a584-42dc-c9eb-08de58471b5f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:12:35.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyPtZNe/Nj3QSUgQPSu3YMyJEPreH8IG0MuqXRh9LevQ0aTeYH+bwSZjsIsAKFOehwaqVXBllVwHXwuh+KXBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3274
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74702-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,garyguo.net:mid,garyguo.net:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7E41C4A9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 4:23 PM GMT, Marco Elver wrote:
> On Tue, Jan 20, 2026 at 07:52PM +0800, Boqun Feng wrote:
>> In order to synchronize with C or external, atomic operations over raw
>> pointers, althought previously there is always an `Atomic::from_ptr()`
>> to provide a `&Atomic<T>`. However it's more convenient to have helpers
>> that directly perform atomic operations on raw pointers. Hence a few are
>> added, which are basically a `Atomic::from_ptr().op()` wrapper.
>>=20
>> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
>> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
>> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
>> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
>> `atomic_set()`, so keep the `atomic_` prefix.
>>=20
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> ---
>>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
>>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
>>  2 files changed, 150 insertions(+)
>>=20
>> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> index d49ee45c6eb7..6c46335bdb8c 100644
>> --- a/rust/kernel/sync/atomic.rs
>> +++ b/rust/kernel/sync/atomic.rs
>> @@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
>>          }
>>      }
>>  }
>> +
>> +/// Atomic load over raw pointers.
>> +///
>> +/// This function provides a short-cut of `Atomic::from_ptr().load(..)`=
, and can be used to work
>> +/// with C side on synchronizations:
>> +///
>> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for i=
nter-thread communication.
>> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
>
> I'm late to the party and may have missed some discussion, but it might
> want restating in the documentation and/or commit log:
>
> READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> like memory_order_consume than it is memory_order_relaxed. This has, to
> the best of my knowledge, not changed; otherwise lots of kernel code
> would be broken. It is known to be brittle [1]. So the recommendation
> above is unsound; well, it's as unsound as implementing READ_ONCE with a
> volatile load.
>
> While Alice's series tried to expose READ_ONCE as-is to the Rust side
> (via volatile), so that Rust inherits the exact same semantics (including
> its implementation flaw), the recommendation above is doubling down on
> the unsoundness by proposing Relaxed to map to READ_ONCE.
>
> [1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/=
Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20=
Kernel.pdf
>
> Furthermore, LTO arm64 promotes READ_ONCE to an acquire (see
> arch/arm64/include/asm/rwonce.h):
>
>         /*
>          * When building with LTO, there is an increased risk of the comp=
iler
>          * converting an address dependency headed by a READ_ONCE() invoc=
ation
>          * into a control dependency and consequently allowing for harmfu=
l
>          * reordering by the CPU.
>          *
>          * Ensure that such transformations are harmless by overriding th=
e generic
>          * READ_ONCE() definition with one that provides RCpc acquire sem=
antics
>          * when building with LTO.
>          */

Just to add on this part:

If the idea is to add an explicit `Consume` ordering on the Rust side to
document the intent clearly, then I am actually somewhat in favour.

This way, we can for example, map it to a `READ_ONCE` in most cases, but we=
 can
also provide an option to upgrade such calls to `smp_load_acquire` in certa=
in
cases when needed, e.g. LTO arm64.

However this will mean that Rust code will have one more ordering than the =
C
API, so I am keen on knowing how Boqun, Paul, Peter and others think about =
this.

> So for all intents and purposes, the only sound mapping when pairing
> READ_ONCE() with an atomic load on the Rust side is to use Acquire
> ordering.

Forget to reply to this part in my other email, but this is definitely not =
true.
There're use cases for a fully relaxed load on pointer too (in hazard point=
er
impl, a few READ_ONCE need depedendency ordering, a few doesn't), not to me=
ntion
that this API that Boqun is introducing works for just integers, too.

Best,
Gary




