Return-Path: <linux-fsdevel+bounces-74642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DGxMNRdcGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:02:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA051481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74EA568C03E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20A3446C9;
	Tue, 20 Jan 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IpME9Jnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020093.outbound.protection.outlook.com [52.101.196.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3973F23CC;
	Tue, 20 Jan 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915571; cv=fail; b=unHnOIWPZm31RTzlhYF1Gv45cDeHrqDbGmsAV5PaKLBdHFIDRNrQgoiizJ8nP84770m6K0h8lggNH5ye8e0wMTssI9rXXNxjMqZLqSxPlWB5at7XviO+Dc5bksru7IyU/fq7sfdV5v397cqhTeelLjz+UD8h23d/Mj5J55CinWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915571; c=relaxed/simple;
	bh=M8l4Cg9iVZZ5OcacOH+ot3SAhdlnwHhEij9gLhmrVsk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GBDNhFQu7SBxi7an3ol3ewBQQPKZY9yyeMrLmGfF48TgpqOlvdHOEWW4q6PiEcVsrJFAp/jevV7Us0Dabh7VxVfSAag6bXjdqSZIJeTJpl1oUoMw3hhsC9C/pLXOHKXgRN+JQUyR2cPfmzddbyu+5lTiGuimINTDFnGg2YZXJwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IpME9Jnp; arc=fail smtp.client-ip=52.101.196.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1+UtA0oGZbqutPwellowHkUHNxJFE46IzMCOiwPHwXWKyWA4+M/yqEawB+p1T+8eAuS7URi43XgchytwPQR+y2slhTLDE2YkH3rNK91yMKs+e0xfqUuOP23XZyfEHkF1zV1mkRxtjfWvE8EtJErh2LeN9Ezcqyd3/lw4MyqXBoeKBHGi5cIE8lfsws340dr6ErAZZaNIYAkmA6c/CLVsrqf4z08VU3xL9+aNLCtskhh/jg79HHl1RZ+P5s0Yp9E8ae2vEulhFSye3EU4QwwLMupnR/iG11qjCJQUNWmJ+o7KF5FNBkEWV8Z3n86XZrswZifynKxKXyZSm/jLGJ74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyBYOzLiJcFMD727b8aIxupmHcGtENy5h6NX8gvB05A=;
 b=guvxHq2dvoOgeMkQPNnaJo4UE+Yht5ohZ37cE0G34fvbdTioieK56Fr7B4ZIXRjEX3QOX5w1G20wGUO+N/I28SvDmi+OzSwj6OAkq93tpNym2+8MrCGIQzwmBT1utx3KsUEpkB0s8O9CI5qBKddG/9+hVECjK36KLui2vheBhoaWNI2rvPeFdkxVFU03RYJ/IQjl7BqBqTVjmCQuA3K42UnRsUj7xI8WWBk34DKV4trjx/fNVW6BR66TnLVul5ytqD2Fc080mDkyrDYyhCW23w+cL80sJgczy27MEj2NSY8zk6vjEbcAd5F0BzwgMOP4XEtrP0Kd0iJwab57ETnkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyBYOzLiJcFMD727b8aIxupmHcGtENy5h6NX8gvB05A=;
 b=IpME9JnpwfTuORc1ZwN/A/X0DE5xg1MP4nd3OrIzt1cV/C387kyrQqv4I5zgBTS7tfYilea+8cGPWtYlEaNBNwRhEnIzoI4p+OfWjcFSn9D3m4pDB2j2/gUm3y/DnwR4HxrpNzFzOB+oIoCMQfLX37Dey9PZXtUZadPIXo1YaAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:25:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 13:25:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 13:25:58 +0000
Message-Id: <DFTG8D7VQNUR.2VK3OZ0R92MEV@garyguo.net>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Marco Elver" <elver@google.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <kasan-dev@googlegroups.com>
X-Mailer: aerc 0.21.0
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
In-Reply-To: <20260120115207.55318-3-boqun.feng@gmail.com>
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a92e28-a919-459f-a699-08de58277335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZncrK1pMNnZsdWMrWFFTUlplK0FFMnNBMWtKOUIya1F5SVpUQ1RLT2pRRHN4?=
 =?utf-8?B?THlvYlNyNHU2TzZKNzMxaW1UdTlmZHRleS8yTStjN1Rad0poTFlSa0hGcDJw?=
 =?utf-8?B?QWpGd2xhK3laVDZ0Qm9zNnBBaHdIMk5jemVTSnJTK25zamhTWDZjSFpVQ1Vz?=
 =?utf-8?B?UG5JQ3lLTGd6VTJLb0ZUWkNtV2h4THVGWnBtenhlM0pwbVkrUVZDL1drWVdr?=
 =?utf-8?B?ZTA3V3B1a2dUd1V2M1paRXRMWEtpZFVjRGZla2hHNUJ6MlNRRlNoazBhc1lU?=
 =?utf-8?B?clM4K2w0RmJsRVQwZFc2YU82NklHNFZmS3dwWWZET1N4ZkZOclRCMHlLYUl6?=
 =?utf-8?B?cHVFYksza0NodlNGU3Q5Uy9hcC9reDJqNUEzNXNZd2xwSTdSUlB2a0V6bzA5?=
 =?utf-8?B?bzJOWEpjTnlJWTEyWVhUb3YrZEM2eHJSUHRjRDdmdVU1RHdLbGdnTHYzWHJ5?=
 =?utf-8?B?cVJrR2k2UnUrdHpsV2p5cTQxNERxSnJSYnIxSUVRclNrN3Z4QzdjL25yMjEx?=
 =?utf-8?B?QzhIcldQWUVZVjZHUDJkQzEwOHlnQ3hWNi9XN3RraUhaNUJJd01mTzkrYWNV?=
 =?utf-8?B?L3lKR3lqVU5vVTJnK2NGRTlhaVViVEg3OGxJdGRUSzlHYXpTUGw1KzJzL2p3?=
 =?utf-8?B?NUY2MEFjbnFzZ3FXZTJheVB3aTVDTmhXWlJxUUtSeUFLcXRLTDRyZ3ozLy96?=
 =?utf-8?B?OUpVSWM3ZGFRMkVtc1N4cFg3dWYvbVQ0bmo0dFovSDJWVWVxVkZPcmJwL1dD?=
 =?utf-8?B?eUo1MXpuaUZhdGlod1A4R2huU0daRHNhNmxKUzJjdWR2MFVpRit3K1hoZFBE?=
 =?utf-8?B?UVF6bE9lTnVaVFc4TW9KTUJwRXVhWkhHT3ZRQ3htQlROdmlaUEZZMmI2SmQx?=
 =?utf-8?B?MDdQWXBIMDMwditLTzBiWDh6dGt5ZUQ3eVpJSzVDb1JQZ005UUxSYjBUUmc2?=
 =?utf-8?B?K09LaE9EY01zdGw5dDc0ajJlWFl2dmFaazFoRWNoeDZVNU5ZM0tFOGZxd3k0?=
 =?utf-8?B?M0ZqZ0FaaWZRTFlaRnNGUHdiNjVSd1p6aVdwTVUrOHhXSGtEbVJYMkNzeWpo?=
 =?utf-8?B?M1RmRkxBb21McVR6U0tCUGlHRjk2OFloNGZiWjgyZ1B3b2hkcTRDSytvd2ps?=
 =?utf-8?B?L01NQjNJMlNNMURCUGhvR0hpQTNwUE45VHdKNXBSalVOSkdxSms0em52d2hR?=
 =?utf-8?B?eEtPQkJWWnlKZnB1ZnB6K2o5WmxKUEV0b1k5dXd6MTE2NFBnV2p6TmFqMXJX?=
 =?utf-8?B?UTl2bEpuUTZ6Y1pZT3JkZ3BIekxXYnJzMGg4d0xsQVg5d054RWRLSjZwcWc2?=
 =?utf-8?B?REhSdWwrZmVaSGJ5MHVFbnhDelRoOHQvTmdPTEpVT3A3alpmNnpnSngzTVdU?=
 =?utf-8?B?NXd5SnlRVTBtaVZFM1AyQmpzLzVYakJObk9tL213M3Bsd1I3dG8zK25Gdkhq?=
 =?utf-8?B?QVg2Vmg1QnRsM04wT0JZNkJHMjNHUWFnSmhhbFlqZUpjSlF2MkNjTUk3cWl2?=
 =?utf-8?B?N0l0SCtvS0hlMnFQUldEckxrK2hyb1EwbjdRRXM5K3VDVXMza0RERUtwaDZl?=
 =?utf-8?B?c1hYaGJoR1RQbzhKdVpGbi9oY0laM3NjajEzeThQWlRvT044akltbGZhSWtN?=
 =?utf-8?B?eVJwb3JGMEpkVWlqTTUxY2I3Wm1BTGc2eE9lMzFsMDE4c3Q4R3lKV1R5WDRY?=
 =?utf-8?B?QlQ3QmlaUXYyZkdsTk9Jb294TTNiNVdOYWcwc0JWMWo4QXE4M0dUTC9DS3da?=
 =?utf-8?B?MGJIdFBub25oaTZaNzRkV0RuOW96OURQS3BVaUNqc0Y5YjBaTWdQaEU4STBO?=
 =?utf-8?B?ZjNDeWdSTnA5WW5hMjZyOHVBVGxBVEJDY0JqNkwzTFRRSitkWS9QZndET3J2?=
 =?utf-8?B?UlJwbldEQ2g4dUllVVZIMjgzNWNadWtyelNqQ2tKdGwyVDFBT1I0RDlPYUlL?=
 =?utf-8?B?MFE5SGZ4TWFlVHdFaGpwVU5RNm5BeVd6V09ldlVOTGlvaFozY3I2S3dLZHNT?=
 =?utf-8?B?RXpGSnVhMlpkQU8zYnJQYW5XWEZlNkx0SkR4MTJWWW1zbEVoYTBpSUx0WWw3?=
 =?utf-8?B?WU5MU0ovcXp5VmhsanM3cEJXenowSEp6R0NSb3U2Qi9telZ4dHN3bW9JUWxt?=
 =?utf-8?Q?SzDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWkvMHo0dFNteXE1ZHJFZXZDdXZRZ3RaaVJaM1Q4WFRJVXFUbnZISkNQdGti?=
 =?utf-8?B?aVRnb3VoVlpoRGx6SFc3SEx4WG1NY3RDWFlwVVNFY0R3R20xSmhpdEc1eGRK?=
 =?utf-8?B?WVZkL1ltYWJrQ3FtQkFGeG1HV1lhZVc1cDY1ZnArZHVaQ1V1cGttdkVFWm84?=
 =?utf-8?B?cm82L1VncUxCbkFOSVlqSXBlUVVFbC9aRFo1YlY1WUtaaElQdHBOdzY1ek1v?=
 =?utf-8?B?UjVsNjNVZ3RQQkNMREwvTEZmNzRQZU05Sy85Rk5FcStlY2MvUGU3cDRoQTdv?=
 =?utf-8?B?cUc1VEgyTTZJWVQ1dzRBR1JnM2ZKb1JSY3JWazZZaHpMcEFCWWtKM2Mwa2hD?=
 =?utf-8?B?Nko3MWIzU2UrYjh2TmpVaC9hN0RYU21VKzduNlU2OXFxcHkyU0pDa0FGTk1k?=
 =?utf-8?B?cUt1WTNTSGZDMmFaM3Bzd1RpZzRackdmSUh2NlF5d2E4T1VXSThUSW1QTEpB?=
 =?utf-8?B?N1ptWS9CRTRhK1JaRVRBNzM4b2plOGlhOW4vVmM2SmRGWFFFS2JOcy9RcDVw?=
 =?utf-8?B?U0xrNjNPZWtrdnJCY1ZXYjdTNWJ0NUZ6dTlJQmQyeXdJdjJpczg1cnk1bVhs?=
 =?utf-8?B?YlppaytFQkN3ckZScWQrT0xjc0VzV0w2cXMxSVpYTlBzU0thcWQ2ZG1NMS9F?=
 =?utf-8?B?Tm9ReHppa1lFV0lLYm42VFdoOXBua1UzQitsSmVUbFdGWHhQVjhka3BxVjhw?=
 =?utf-8?B?U3RUbStLNGZMakJpK25Jb1hZNytYT2lzNmd3eGxzTU4rOWwzckNzU1BZSkdl?=
 =?utf-8?B?WDdBZTRoemM4UE5jNnZuZi9PeWxMOC9CMGJ2QUFWa2d0bDRHank3bk5aem54?=
 =?utf-8?B?WGpmdjRCbnFSQUZJK1FWOHF2QmJVN2lmTzU3WG5vNWhIWjM1Y3h3N3MwRHpU?=
 =?utf-8?B?R0dpSi8yUzZIYlhxSmlCenFvMmM4b0xBWlRFQWVsWjE3LzJTWWZEdk1SenpH?=
 =?utf-8?B?WXhaVktqeTBVT0o5MVlHU2YxTlRoYWN2bW1HNUlTN0hwUzZCTjNYSXkwY0Ro?=
 =?utf-8?B?d3Z3aFFKSFI0Q0lOTGExWjArVWo2QjN1UWNqbFY0d0VvOXhkR3NqY0tUSXNv?=
 =?utf-8?B?b3Nrc0xSZkVxTzFGY3pBVW1McWU4eVFaYWlQcDhibk5pbXdCTFRheG5FMmdo?=
 =?utf-8?B?TlVRL1dlRkltQnZDR2s1emJxWTZVSGlDMSt2MFBVZUVBb1JvTFROZldCU25K?=
 =?utf-8?B?c0h2T0NnZlpLVktPWWpOUFlUWWdlaG1GTDYydnpFSUlQV25XV0x2MWJRYUtv?=
 =?utf-8?B?YjBBMUZIc3A5WGJsekgxYzM4MkJOOGFIdXhabEJuQmg4eUZTMUJJUksza1B0?=
 =?utf-8?B?dndyeTl1RCt5V1dvc1FRZWZweGdLWTNVVTh1VHFpMjJFZkljRFBXRVlSOGhk?=
 =?utf-8?B?V0Uvc0xWaEJORUQxSUpYK2Rzd2ZybFo1Wkpmd2trOUxCK1J5MEdtT2dUdjdk?=
 =?utf-8?B?QkdqL2QwUkFpMUpXWE1vRUc2bkwvaThpTm5wV01Na3BhTFgyOHQwV1VyOEVv?=
 =?utf-8?B?bUxrZXh6U2lsZndpMmJ6b3M1Y0VNcnlJbmtrNy82MkNDcFdsSWlGKzlxSDEw?=
 =?utf-8?B?SXdmaWlua0JXVVdHUFNOalExZWJSL2JONnpWeHF3RFVqRTZZT2lkaFNKUlF0?=
 =?utf-8?B?Tkd5d2dZSmRZTmVOZmxiU2lRWURwazJJUDBGdWlLNWp5aFR2eDBuamplZEFZ?=
 =?utf-8?B?dlBrMnNSOFFGcjVDck1DRjV3VWVyQzFJdXBvcFZ4dDBPR2xBT3pvcmhDakxt?=
 =?utf-8?B?dHhjUUZKTmx1WWtEb1QwSGMxMFJ2K3hFWXRObkVEa0N2VDl1N0x0NG9hUURU?=
 =?utf-8?B?MzMwK1dNTWhpdW1oMHZjTHNuUFdxeFdEYjU1KzU1RWQyWUU5dzYxLzBLcjY0?=
 =?utf-8?B?TmNwSFhkREFjZUtPM0dudW5mMWx3UjQxK2RselhUbzF4eENuc0ZTdVp4RUtW?=
 =?utf-8?B?WFk3RHdCV3R5d0pabE5BcS9EZEtBQ21NYTNIWkdLSzhIYm5UQmlhOS84cFpZ?=
 =?utf-8?B?M3J6aE9zZ2tQcWlYVEtuYWY2UDJwMG5XRzZGM2w2RFAxd0xwS3duczNvRlRr?=
 =?utf-8?B?a2ViVTFzeURCM0hpeWVKL1J3eEVMZXNiTVdaYnZmeXQxdWJ2eGJJclkxRGZ5?=
 =?utf-8?B?R3BvYzlwbGxBdkhEN1N6aEdRTWhyaWdwSUhlaDFjYzRsTUpOQUFTZXIwUS9D?=
 =?utf-8?B?Z3M3clBLeVZEdG8rcUZXNWxXN1BKT29SZDdKa1RiSGhLN1piSVI4L3FOQnYx?=
 =?utf-8?B?Sk11VjF3YTB6N1BnSUpUZjUvNGZNWnJwVENScWJvWFZ3cXc2clpWbWM5U0xh?=
 =?utf-8?B?cVV6UnFKWkk0NHdWTmVHQlZPNFRCR2RQMGFGRkpyYmtFaW80NS9JZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a92e28-a919-459f-a699-08de58277335
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:25:59.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUn9MRdJ6hjSjQU3Xx5FPEq/4qkz2IEq3sGrqlhq/LnMZ/Q/dCCT4CAfIyhpC7Y/Z7bDN26nbCFh1cmDxmpfYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5086
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74642-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: 60FA051481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 11:52 AM GMT, Boqun Feng wrote:
> In order to synchronize with C or external, atomic operations over raw

The sentence feels incomplete. Maybe "external memory"? Also "atomic operat=
ions
over raw pointers" isn't a full setence.

> pointers, althought previously there is always an `Atomic::from_ptr()`

You mean "already an"?

> to provide a `&Atomic<T>`. However it's more convenient to have helpers
> that directly perform atomic operations on raw pointers. Hence a few are
> added, which are basically a `Atomic::from_ptr().op()` wrapper.
>
> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
> `atomic_set()`, so keep the `atomic_` prefix.

I still have reservation on if this is actually needed. Directly reading fr=
om C
should be rare enough that `Atomic::from_ptr().op()` isn't a big issue. To =
me,
`Atomic::from_ptr` has the meaning of "we know this is a field that needs a=
tomic
access, but bindgen can't directly generate a `Atomic<T>`", and it will
encourage one to check if this is actually true, while `atomic_op` doesn't =
feel
the same.

That said, if it's decided that this is indeed needed, then

Reviewed-by: Gary Guo <gary@garyguo.net>

with the grammar in the commit message fixed.

Best,
Gary

>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
>  2 files changed, 150 insertions(+)

