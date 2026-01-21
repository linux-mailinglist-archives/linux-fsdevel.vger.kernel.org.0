Return-Path: <linux-fsdevel+bounces-74860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC4oEaLbcGnCaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:58:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A596A580A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8412B88717C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA424E4C4;
	Wed, 21 Jan 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="AZjPvugu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022087.outbound.protection.outlook.com [52.101.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA03BF31F;
	Wed, 21 Jan 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002935; cv=fail; b=PuFygcRxuQxmZAPmIVM74/3/5aBLN2lv0f8oqw4dg14kfaMpx95pW92xlPvYT8NqwFIYTHIDAj+hLIHoGIwPH0dto/oJb/QzkXCxL4vAFurqVE2a15PT4Y+chb/yuFZeVcZwZPRlFONVpZ3kDg2Ec7NmeNSLpkujhBvV6lsjn68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002935; c=relaxed/simple;
	bh=yi7eQWjZHgNyj5YIf9PPYR8JsFOA1Nkw1tSSBgySjQU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WLVr6CxbmWye4y99pG21cml22HAf17XSUS5cgkVzSLUFCzd5I7qvcvvQI/BTmSDPbj79+vqYh26HQCO8Yv/SjgB0A2aFzxEX2e3hYX7nFHONBCCk5OEFYODsOv1zDlugmnW4QbBv67a98T4cc2XjsvQDn4KuytXasbJPL2+6EWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AZjPvugu; arc=fail smtp.client-ip=52.101.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb6GRsimR0pehQZGrxTu+aoCzUE3B+2tY61e7k7b+aDvveXLhLO3PI+/cybtuHI0wcvwkfpb0M4EvBa/kipVZFQ5TwaKuaGSOQYu7hu+a2ZXPo1ePlHkz+LqWYgWZN3TzVYobeyANSDOBaqMzbgoBePlpX4SawZ3BHjMYDeW9mOdAxnrg95OFhd3F/97B6dRuwsjnP0UTStG9aXUaIec0GeIwNXfBRnwyIpmosBaI+ctE9qeyRt3/IKe2W6/tn94xQOp5amaYi0j8WO9FwZZPCR7VkBdFUK5Agil9/HjG2HCSlsb6rGXeFJdEO0c1yEYX3AU4d/E7bfMkKIsjucWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pgu+Uo2bsjg3kTS/e9dc7ORtuYCeVeuuFrYSA1l/x4=;
 b=rNos3Mt6Hai6pW+BwcVrneFkkl0Vgg0ZalRsvTy2JtnFKpm0fwZmosrjlsGco95Yfq8mim1xRCfZnJ9vGXX1+CYn10QsmkEwje6lI0RYOHlphP78phGnhkDr22lrDwrQHV3US/5cSKFI3ay9OH7VeBtdp7Z8nK4D3qKm5l8N3HzmRmHLlyiTUiB4QKVSQwDdCxkaoiq0KmUiXqxrKajbaGld5gJS+hCaTUdety2m+5auU1mk1uMQ3aqnnsJHjWUktkJYeF99UmYLPEbWv4uTF8mAVyp4yvT130FZLL0Fp27vn4kPewULHUNVepoAFEKrjx2gs1dFAw5+V1gSdVKjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pgu+Uo2bsjg3kTS/e9dc7ORtuYCeVeuuFrYSA1l/x4=;
 b=AZjPvuguAc95wGP2WQ+TBrSBOS/8nGRBXnYI9awkQOG2viYycfjpqxitcZnrKtF/6H4sgFj/cYXx9LtRdJYxx5thjv8mMSduOmgfCXqSdepMsipASdxadKQ1r4BJjV+oGjZFoM2xPo8dORAGm58b3/hZmwY0IPb1i4hLRNjgj8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB7390.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 13:42:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:42:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 13:42:06 +0000
Message-Id: <DFUB79KG8MT9.3F6QF7R8I3FGP@garyguo.net>
Cc: "Marco Elver" <elver@google.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <kasan-dev@googlegroups.com>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Elle
 Rhumsaa" <elle@weathered-steel.dev>, "Paul E. McKenney"
 <paulmck@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
 <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net> <aXDEOeqGkDNc-rlT@google.com>
In-Reply-To: <aXDEOeqGkDNc-rlT@google.com>
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 895c1949-0703-4ad2-5010-08de58f2dea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBpalRoeERBOFNZQXcrdXgvaGlRRDRQM2MzcVUweVVlMXZtYXcxV0lJUVNp?=
 =?utf-8?B?OVFaQXVtS3pxbHNGdkxNNU9CS0tDYzZxSFpvQnFBM2xBSE1OUUhsWWp4dHl5?=
 =?utf-8?B?Qm83YzA5Y2NYdzNYN1lDZmF3bkMwQTdPY0FRWDBjOWRyU0hOUlFCcEY4SVdr?=
 =?utf-8?B?aUc2ZVc5S08wMkF1U2lLR0FVejJBYXJDSDVBV000UGtYWFhDTEtwSTlZeUlX?=
 =?utf-8?B?NVY0ZmtnTWNlZjhDcGMySzJ1bHJDVmkydmFYOVBVVCtqcUlRQm5SK2FrWlBJ?=
 =?utf-8?B?U0UvNUtjS2NzZENCMHhlUVJpZGh4YjhJbFltWldXb29yMFRTTlVKbVNHQzFT?=
 =?utf-8?B?ZnVZMlMza21uY3RzNTJ2YW5Ma2JSVk1lNmh3aGMxVXRPRTNNS01rcUdhZk1N?=
 =?utf-8?B?WjNOWUdmSUM3RzRPYzNUOVhJY3Q3L3lwK3JhM29IM3pXVmY4UDFpWUxiakZD?=
 =?utf-8?B?dGdVNEpuOUdUcDRBQkZIQWdiaTFwOGNSVUlGYVJSUXNRYXFOTXFqbERFamRs?=
 =?utf-8?B?UkJIWXd4MW1IL0V6M0dHdzRjeXhUSmFCYTdhSStJUXNnc1ROQVJOcGd4Y3dE?=
 =?utf-8?B?eG9CZ3JYcWhoNHdhY2NDSFhMeDkvM1BmSjlVbk5KbGQ1akVmYWtFWFM0Qk1h?=
 =?utf-8?B?bW4ydTF0RU56K082d24xVnU0SHF6QWxLQ1lteVp5NkZzbmJtQVZzTjlvYzRN?=
 =?utf-8?B?TVdobUpjYVV0YWk0QklLUGlFbWE0clZ4bXpWbm5oUUZJak1DVGJKMzhlbExK?=
 =?utf-8?B?Q25UdkwrWmdCU3hGVG5nRFBaR0UwR0VySVJlTmZoNWprSHhYY1pzWDl4Vi9k?=
 =?utf-8?B?UnRDYU9GNTF6aXlLbEFGcTBMNWNObUkvQlVpTU9ZYnA0YU5FaVg5MDNRTHln?=
 =?utf-8?B?MVphTkdvVHo3MFMrNE5SZG9XeTZqc0tUdnVOWGlXRTJRTHFHWkNNUGduSE5v?=
 =?utf-8?B?dDBaT1dST3VoK1JhV29sZEdTalhvVWp4a0s3ZVZ2cVBvVWlPeEJjbFJHSzFC?=
 =?utf-8?B?dFJFRVVEYjU4bHliYVcyQlVGbjEyTzN5b3N5U1FpR21ySHJTc1RVQ29Rc2xY?=
 =?utf-8?B?dE42YXFXMDVzRWtYdVdHMUxXZW1lRWNnbWVUeEgrSU4rcGxaaXkrTWVaUGFn?=
 =?utf-8?B?MjZFczlINncvZi9TT3pUL3lyVnZEcllHWkFlcGM4QUVwdDhPbnNCTXpxM1RM?=
 =?utf-8?B?QzJJYTc5S1VhQk1IMUVYN3pzMHF5OCtxQzE4MFlsMDRWQThFd2RiN3dYaXhp?=
 =?utf-8?B?bWtXMXJqT25LdmZpa1dmQXljaFkyRzNhMmhoV2FsWDdCeDR3WmZTQngvSVpK?=
 =?utf-8?B?WXBCelF3VkwvLzgwMDNhREJVWkhQY3VTNW1FTXQxRm15endRbGlmbmV2aTBP?=
 =?utf-8?B?ZnFpVHdGK0J6blVnUTV1VWZoeWdJS2h5U2dTaXNYdlM1d0szYnpjUkp2c29o?=
 =?utf-8?B?TjU1ME90NVk2NzdqNmx6dUV0Vjh5bEZuaFFpbENHVzk1WnpVcTFVdjFDanI2?=
 =?utf-8?B?bGw4Ylg3a0ZYMUh2Ykh1MlZ1MkUwdG9RZ1dxTHU5REFUMFFFVzJ0KzhpQU1B?=
 =?utf-8?B?ZkJrSG9mZjdUZXFRc2YrSjRBdDhReDZoL3NsZ3JweTVlSFVCeURXZmZSUDJj?=
 =?utf-8?B?S2U2MEM3U2NXQU9vM0pkYW1XOWdXUG9IbnZzY25BWTZlRDZCVmhza3JQektY?=
 =?utf-8?B?VkJuS0FGWjQ1UHUyUC9Zd1Yxa0N0N3lTeFhLQlZ3ZE5yTmRSdWlpcHk3Y1h2?=
 =?utf-8?B?S1c2Mm8wRldtblZzbCtrSDVKaDlrZkk1RlpTemhieVlHa054UmwzMVJjUkp5?=
 =?utf-8?B?eGZpVTZmWUs1NmUrNlpWS3NuTElSMGJqTjREOEIzQWc1eGZYWXkwTm8ybzBo?=
 =?utf-8?B?NEM4Y0wzdHNSazV4b0NVUlVOeFcvTWpKMWlPNk43Y3ViVVl3S0lQbDRvdnJQ?=
 =?utf-8?B?eUxCT203ai94UFU2ajI2M0l5Y0NWL3F2UnlGdWNnVnNsZkg3ZFRwT2JPbXVZ?=
 =?utf-8?B?b09hcGx5OEhNbVhEZGVualJoVUFza1RDRWo1WnprQmtsclM4ZUNlTmszMGtI?=
 =?utf-8?B?VDNUS0hFU05yVk9LRXpoR0pTUlNNeVN2eXltbG5oMHdWQWFNelJacEVoUEky?=
 =?utf-8?Q?KITE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCsvZTJYNHduUmtteUdRb0dtRGhGUGdqaDhpK2lBZmVhZkljamxXcS8vUnBS?=
 =?utf-8?B?YjlkSUpRVm1sS29TQTM3Q0p5MjdBMWd4dWxZdENiL1dKbDFoZTdMM3pGU0Uy?=
 =?utf-8?B?WmhGZzIzV0JhclJ0cW04SXgxT1YxaHd3dXppTEt4eGpwNzM4RmhYWWE5UTVK?=
 =?utf-8?B?ODJnMU81VkRabkVtRFljT3lpRUFwR1RmNkVJajkwRStxZkxiMkN3RnlvUHBQ?=
 =?utf-8?B?Sk1na25oRFdqT0VpMGJndFEvdTNTTHpDc0xaNmZPRENldnZBTGl6YzVlKzMy?=
 =?utf-8?B?REUzTTFhc2p3SkQxUEt3ZmkwQmI0MEZ0SGY4Q0d2Um9ZdFRaTHFIbVFUZU5N?=
 =?utf-8?B?bnFGRUJpR0drazFuZE5XQUFEL0VlQkZuVUo3b0VEaWhhajhPUXd0Nlk2UzFM?=
 =?utf-8?B?QWhPY1FQWnhjWjlkOG9XUFFMYzBxa0xxQ0l4YitubDM0d0dLMHU2MW5oWFNj?=
 =?utf-8?B?M05ESnRDK0RKWXNFbjlobzFpc3ZpN2VVUXVRS2RnM2NvZ001cmtlMUdZTVhx?=
 =?utf-8?B?NWIxWjZsYTl4R2t0OTdHZTdhWmRGOFU5eFY2U0xYUjlBU3lVRnJFbXNlU1ls?=
 =?utf-8?B?cVpwR1NDNkdFSkhwMDdTZWwxckswcTZRdysyckx6T3RvdnMxcGhNZ3RGemtK?=
 =?utf-8?B?ZzlBUFdTYmR6ZXMyMjZpNHNnM2EvT002T3FMQVlnQk12NVBiK2E1NXBTRElj?=
 =?utf-8?B?cmNoMXg0MHpoeVp0RzJWejlRemxiMStqcmc0aU56M1BZa2F0V3N4cnNnS29j?=
 =?utf-8?B?ZmlCbDAvazFQZTlaVEFFMTFtaGVERGt1NDlYNFhIRnR1enprc2paNENFYUhk?=
 =?utf-8?B?a29zSENoUnA0KzJaMjVNMlJFVThkSUFYVVZiMGIxNWJ2QVFyckUrdFNVcWVo?=
 =?utf-8?B?aVY2T05FNEgwZWFiMXYvclZvd2l6bFBMZkhUUWxtdWJJMXVXUk1TdW01Ullv?=
 =?utf-8?B?cExTMi85ZG9SVFBOV1orZGNqR3dtT1lPb0JPeVY5eDVqc1dYazRUZVhuclNR?=
 =?utf-8?B?WGhOMGhBMjlVTms3bE5oNVY4anVDREx6TGhxOUJGR3hUZUpyd0t0amNGbERR?=
 =?utf-8?B?NVFMVDZrckMwWWYrYmpwakxrcUdjOGpndEhRR3BLdm1IT0d2OG5GcUVyOCt0?=
 =?utf-8?B?cmViRE43RWh5Z29CZWpZdjhVa1lGL1VvU29aY1ZrNnVVT29QRmZWekZZcXhv?=
 =?utf-8?B?ZGw1QkgyVXlUQytpeWRhbXJDV1FuV1hpUU5UdHpBN2ErM0cydDh6UGRYVEkv?=
 =?utf-8?B?ZXFBeFFEQW5ocmdoOXJQbkhYK29vdGJ4bTRIUTdiR3NMaFhZS21VRHkveWJF?=
 =?utf-8?B?WSs1U1gzSWpDZXRTcjIvZXFhYkhMRVRTT1cwSktxMWNCQmh3QVdOZ1p6T2M2?=
 =?utf-8?B?T1BicjhHNzhRd2xpblpyL0dUdko3NFk4Rm5SSjVxbTlkeFA3ZzR4bkxQd3BE?=
 =?utf-8?B?aEdMQWhMdFZkaTB4cS85ZVNiTHhrSmJNL0pKUDVHYmJiWWgzNnFFakMzVFND?=
 =?utf-8?B?NnU5b2lYSWtGL3N3Zk9wY0lFaUlLejFBcm9VQWUxSHFqOEtVZGdiNll6TERQ?=
 =?utf-8?B?NjdVaHByVnVqUHk3eEduU3V6Q1AwYjV4NFdMVWpqMGRrNFZZRnB5VmxXQitW?=
 =?utf-8?B?dlErMVdZWFZHZFR6VytDUXVKV0FVeEIxcGJ6V3RobGNXWVdQWVhjNC85djBZ?=
 =?utf-8?B?Zmp0VzUyMGUvSDUvSXc4WGkvdkNXRTJ0UWZRNlBETFo0R1FoR01FOU9wUUQz?=
 =?utf-8?B?ajhFdGRsZEtaNjREdlFOTkZ0Znc1eE5MOXdHdzJoVGpoQ1dtdmRmQ2U0YVcv?=
 =?utf-8?B?N3N6WG5CM2tqcjFDTTRrenJoalQvSnowR09JaUtmTEJrZTl2Y3dyYXEzV25H?=
 =?utf-8?B?R1BPQy9NMkxaMHY5UU95M0ttVmtQdnFGRXZBMmc3Y3JuNUVXYTdJbzdlOVY4?=
 =?utf-8?B?c2xyZG91MWJzVnNOOUswRFJkQUlPK3pHWnhPSHdjSGZxbXZ6eGt3VVBEQ1JX?=
 =?utf-8?B?aUphZEJFNlRMdjU4U00xSXA0SUhYZHhpOUJQT1ZFU0o0Z05JTWF2TlBrWm95?=
 =?utf-8?B?YjZuNlNrZHV4VUFualFqemJySFFBVDg2cmlYZFpVVCtvUkFzdURzdjNIdm9y?=
 =?utf-8?B?RitUcEtDRjJZTktQSjNvc05JbUZqZkNJTjN1NWhHd0QyVVBBOHRVbjcvaXo2?=
 =?utf-8?B?N2s3YmlNcWROZG1iL1BObm13SlE0QWI5dFhyZXVjMDJjSmYxQlRVWUVKZFNO?=
 =?utf-8?B?bXBXQTd0UzUrN2NFQmFUeGxzNTlBWkc4R29aeUQ4RjU0ci9kU1Buck54UWVS?=
 =?utf-8?B?QzZPcllhaWJPbUtUQit5RzRsMkkvR2E2WEVJRFRka0R4N2dMODlMQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c1949-0703-4ad2-5010-08de58f2dea1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:42:07.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ly3y5/HgnYL3APMIrQB8z6KlT0jHS4IZgbwXtaQJJsqFB75Wnydw59a+HcVvD+ErtJOYc4Q3dG5pd9krNKYfug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7390
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74860-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,umich.edu,weathered-steel.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: A596A580A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Jan 21, 2026 at 12:19 PM GMT, Alice Ryhl wrote:
> On Tue, Jan 20, 2026 at 04:47:00PM +0000, Gary Guo wrote:
>> On Tue Jan 20, 2026 at 4:23 PM GMT, Marco Elver wrote:
>> > On Tue, Jan 20, 2026 at 07:52PM +0800, Boqun Feng wrote:
>> >> In order to synchronize with C or external, atomic operations over ra=
w
>> >> pointers, althought previously there is always an `Atomic::from_ptr()=
`
>> >> to provide a `&Atomic<T>`. However it's more convenient to have helpe=
rs
>> >> that directly perform atomic operations on raw pointers. Hence a few =
are
>> >> added, which are basically a `Atomic::from_ptr().op()` wrapper.
>> >>=20
>> >> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
>> >> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
>> >> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
>> >> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
>> >> `atomic_set()`, so keep the `atomic_` prefix.
>> >>=20
>> >> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> >> ---
>> >>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++=
++
>> >>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
>> >>  2 files changed, 150 insertions(+)
>> >>=20
>> >> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> >> index d49ee45c6eb7..6c46335bdb8c 100644
>> >> --- a/rust/kernel/sync/atomic.rs
>> >> +++ b/rust/kernel/sync/atomic.rs
>> >> @@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
>> >>          }
>> >>      }
>> >>  }
>> >> +
>> >> +/// Atomic load over raw pointers.
>> >> +///
>> >> +/// This function provides a short-cut of `Atomic::from_ptr().load(.=
.)`, and can be used to work
>> >> +/// with C side on synchronizations:
>> >> +///
>> >> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using fo=
r inter-thread communication.
>> >> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
>> >
>> > I'm late to the party and may have missed some discussion, but it migh=
t
>> > want restating in the documentation and/or commit log:
>> >
>> > READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
>> > like memory_order_consume than it is memory_order_relaxed. This has, t=
o
>> > the best of my knowledge, not changed; otherwise lots of kernel code
>> > would be broken.
>>=20
>> On the Rust-side documentation we mentioned that `Relaxed` always preser=
ve
>> dependency ordering, so yes, it is closer to `consume` in the C11 model.
>
> Like in the other thread, I still think this is a mistake. Let's be
> explicit about intent and call things that they are.
> https://lore.kernel.org/all/aXDCTvyneWOeok2L@google.com/
>
>> If the idea is to add an explicit `Consume` ordering on the Rust side to
>> document the intent clearly, then I am actually somewhat in favour.
>>=20
>> This way, we can for example, map it to a `READ_ONCE` in most cases, but=
 we can
>> also provide an option to upgrade such calls to `smp_load_acquire` in ce=
rtain
>> cases when needed, e.g. LTO arm64.
>
> It always maps to READ_ONCE(), no? It's just that on LTO arm64 the
> READ_ONCE() macro is implemented like smp_load_acquire().

If we split out two separate orderings then we can make things that don't n=
eed
dependency ordering not be upgraded to `smp_load_acquire` and still be
implemented using volatile read.

>
>> However this will mean that Rust code will have one more ordering than t=
he C
>> API, so I am keen on knowing how Boqun, Paul, Peter and others think abo=
ut this.
>
> On that point, my suggestion would be to use the standard LKMM naming
> such as rcu_dereference() or READ_ONCE().
>
> I'm told that READ_ONCE() apparently has stronger guarantees than an
> atomic consume load, but I'm not clear on what they are.

The semantic is different for a 64-bit read on 32-bit platforms; our
`Atomic::from_ptr().load()` will be atomic (backed by atomic64 where `READ_=
ONCE`
will tear) -- so if you actually want a atomicity then `READ_ONCE` can be a
pitfall.

On the other hand, if you don't want atomicity (and dependency ordering), e=
.g.
just doing MMIO read / reading DMA allocation where you only need the "once=
"
semantics of `READ_ONCE`, then `READ_ONCE` provides you with too much guara=
ntees
that you don't care about.

We'd better not to mix them together, because confusion lead to bugs. I hav=
e
described such an example in the HrTimer expires patch where the code assum=
es
`READ_ONCE()` to be atomic and it actually could break in 32-bit systems, b=
ut
probably nobody noticed because 32-bit systems using DRM is rare and the ra=
ce
condition is hard to trigger.

My suggestion is just use things with atomic in its name for anything that
requires atomicity or ordering, and UB-free volatile access to
`read_volatile()`.

Best,
Gary

