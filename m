Return-Path: <linux-fsdevel+bounces-74635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIhSBR4kcGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:55:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F814EBF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A8778ACD36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50946428851;
	Tue, 20 Jan 2026 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DUiedkA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020074.outbound.protection.outlook.com [52.101.195.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038F3F077A;
	Tue, 20 Jan 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914596; cv=fail; b=DwSWQd2P2998gLlMPZ97IgZZoZ5O0aBAwhdy2XdYAYSwlVqjPUX117IPRjdIulrfw42OGIIUZ/c/8yySUoyG5qbYg/9eCAEI+9PIesC5h4PjIg3JxbH8vOWI4p1iF9Jb12aBFoL4DDKqBDE6S3mocNFk93nn2gruZL3BMDEkYE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914596; c=relaxed/simple;
	bh=OdnUvQYJz/WzC6GBgt+XsJmD8sGZ63KTm6syYqHt5KE=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=nY1LJsTbcGlDPSSeGWO7JMEn/wtwTUKOBcys/fIyWbdDm6heDdJCKg/db8K1LLLQa5P5hcL6NIT1ZRRa1stWfvorTfqXlP69EtvGOqxf0lSdZ6h2yOgxP0xL/QUu7rQZlv+M4/+AoJwaAZKPURc/qNKaX8teZsE+lk88C3Yzpjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DUiedkA1; arc=fail smtp.client-ip=52.101.195.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCNFuMI8WnGH6dispw8ODtFBCFwIAI8JbvxsTsjkywaaynMPQm2urA0xBlf+4nNFb0tLT6STNC0qS94yQ3p0OKAYlKOujXFr0hMJywedA1qmvtn3jnAuon4jDHV2OmdrC68Z3519KRW71vhiAov2SSVFrVSvcmkHJZHY/eGvg2zHnuAQO82/9YML2SAboRfXj7YhoxT2dlepCtPtDjXxenuvGTGZklot1hK+7ljVvDSWDEejUXOSIJ4GQv/0sTxao9tGvMnupH6TJlRdSXPAzgBL3w0auYv2WAeKu1bzzyN0A8cRBuaYZZsz3XmyibNEzb4yCBWa6S7N7GGQMDOKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfmBYyNFe9dvqaJp74H80gcftgbIqUnw/98hdDW69ao=;
 b=uWAjIxUQgYoqO4SGG5XH+yo4tvpl4vt1tb4iT+s6d0aMfRuyRISnuCX5mpOoGkh9oqRyWjByLPABkH6I74dbpI/q4mbejtRZOxGm2fBn85VuCY5aW0dbdAXPDV7L44olWTpvZdsQ+ZBycXfgEyjqBI5fR+jcnsYITa0Q08kCe0r4MUOtkLO1wbtno4oHfMK8rkekwawOuYI7pw8CBTevfiMs6z0LQEOdgvzttXDsvK1ml7Lq5NZ6D1C5WyLd4LHBz+ZUncKQZx8ukTj/V6Lwoyf1oD1k8l6ChYfm2huT0n3e/kW8+ucOGLF8KoZPkI+6wZa157yP3hGWViXSA11kQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfmBYyNFe9dvqaJp74H80gcftgbIqUnw/98hdDW69ao=;
 b=DUiedkA135JWRaw5rTDBUrnacn/+aU3uN+yEQKkBQcoy7NtSgZX3HtVbvjXsKBroqDP2UXn6+dGTwEUR1w5Jw/BSXdO0jwM9Xigs85wDY1i7gQF6bdS8GsEFPaLzQMogkCzJVANgwubW5JMLYaYFO9XvW/b3cwJkRc0BMP6cgo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2118.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:09:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 13:09:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 13:09:49 +0000
Message-Id: <DFTFW00MFONT.1WKK4LWVHUJL@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <kasan-dev@googlegroups.com>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Marco Elver" <elver@google.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: atomic: Remove bound `T: Sync` for
 `Atomci::from_ptr()`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-2-boqun.feng@gmail.com>
In-Reply-To: <20260120115207.55318-2-boqun.feng@gmail.com>
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2118:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a1cfea-9ca3-4147-8098-08de58253197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHpxL1FGWTBzbjk3cnFudElWNXluVVFvRjBvTENDVjFxNzFnbDREL3F2Z1cz?=
 =?utf-8?B?dWRsRndGRjJlbnFoQVR1anZVdUtPVEh1TktwbHEwdGREQU1BUkwxTXdSd1RL?=
 =?utf-8?B?andlWW1iUHh5SHJJSVA3QnFodUEyOHJGdCtqUWFLeENDY2FVMlpQaHVaUEVj?=
 =?utf-8?B?OXpDbFNFbS9vWGFZQlJjYWFaVENUK3RFT0tJa01kV3RvUjU4ZkRnNHVuajhR?=
 =?utf-8?B?SE5rY1A1QWk4WnpFVHRXS05XV1NJbHluK09NdlB1S25pUGd2YVNjenhlaVZH?=
 =?utf-8?B?SytjRjlmODZMVVhadCt5aFlCNTdpT3NjRmlEVnFZTFRPM0RXbWNtdElpMDZJ?=
 =?utf-8?B?bnQ2Z1RiWEkyN0R1dFRxYVloZFRLWXZqTmtCSVpVY0pTem1lWnZqYWZoSEgw?=
 =?utf-8?B?UDVBSVd0a1NmQ2tkZVlEek1lVG01eGJMR0sxNUM1Ulc5SkZYN1pwNVJjMUtB?=
 =?utf-8?B?KzFjN1pzY0N5aWJIdTR2WUltWU1uU1JwZ1RadXMxcFN0eHJNdXB6T3lxN3Uz?=
 =?utf-8?B?UUJhdlNYb1VGbTNZL2VIUnpiazZzTWk5Rk9MRlhuOURja3NaSzZkMjh0SCtl?=
 =?utf-8?B?aVg0T3dzeUpHTlloVzh6QTNlZXpkMWNRdHdZZG8vaWo5bGpwb0ZQc3JVY0tl?=
 =?utf-8?B?Vlp5TVhKcFZCN0twWkdFQ1JVY2tPTSsrUDl1L3ExTnplTUFtNEJTdmx0MFNH?=
 =?utf-8?B?M05WYVRzUlEweFNvQWNpNlpRV0g5OFJaRDlPbmVHbjZLUnZpOFE4YW9tVjRl?=
 =?utf-8?B?N2RsNU84RHYzTlptVGNSMlNzdnZweWN0VkZRTDN5eUhBb3FmYUoyU0k4c2tI?=
 =?utf-8?B?Tk5ONTVseXZYbE9ienRZeFdhU1I3ZW44RElSeGxvQWFMa0JRcjg2TUFFSG5z?=
 =?utf-8?B?V2RwbG5pVFQvN1l6SGlhOEw3MzJWQk16NmQ4MzJieUJoTW43SmlBM0puZlBi?=
 =?utf-8?B?SWZPd0E4aG1Fb0Q5dFNsNGZwTlJ4c0R5Q2JxOXg4RmtIdGVLMTdTME91UjZq?=
 =?utf-8?B?cy9FL09YZmxmRFkzY3dRSWdBclhrR2dMUW96WXQ5V3RvamJtRFk4NmNjRDhT?=
 =?utf-8?B?TFZWK05KYW5pRU1YVmJyMDBkWDFnZVorQUJFUzJzNXkxb01VZHdlWFA5WGlI?=
 =?utf-8?B?OU95NVRCTDZhWmloNkdvTlFwUnRldHNkSCs4elVwcUJhRTV6RVdmUmU3cmU2?=
 =?utf-8?B?c3BTNlNJUERXSkVSSG1lMXJrcDVJbTRwbUhtdnBVUG9XQnhoL1RDRm92eEJS?=
 =?utf-8?B?NzhWR2N5L2E2b1ZJZEcwek44a3JCZnBvK2RJTGhpU2hISHhwTkQ2NUg4REpG?=
 =?utf-8?B?T1gybGtTRmU4VUVlZDRlZ28rMW1IcU9BRExVUkowMm16M210VU4yN29BajU5?=
 =?utf-8?B?U3RlbVh3Tng4OSs4OFBoT1RMeDRNakNMVHdQUmNzZnZlV0pkbGF3RC9wVEZn?=
 =?utf-8?B?OC9valprcTMwQW9TenZzeEdkOVp6R1FqdGpxVDM2clJocVo0cUEyVkNSUU14?=
 =?utf-8?B?SXRUOHNzSGZCS2I5VEppQ0htS0Y4WUxWL2RoRnZ3Q1lrNUl5Qnh3VllBYUV4?=
 =?utf-8?B?cmJOZDRCVDBOTUpRcEs2RVZyVUxjRmpXK3BKR2pqWUY2dGpTT3dmSi9sSDZT?=
 =?utf-8?B?VmVOaVFGUDluaDNlRFNyVmRqY1Mzd0RoTHhtMW8yRXJEMFgwWGdBWUxUb0o1?=
 =?utf-8?B?cGhUMHBLQnBDeHdmbzg3K3pjVlBleFRZenoxN0FkMmliTVkyMmkyb0xBMnhQ?=
 =?utf-8?B?cnBnZ3VFRzNkY3JHWWFaUld4N0g0VE5FaDZYM1hsdHU0ZmM3UkludnlLc3VN?=
 =?utf-8?B?cW1IeC9VRzUwZng2blNJU2dvTlBSeVE0ZVdRUzhSU1BEb3BSUFhNL2kzMFB5?=
 =?utf-8?B?ck5jSHB2dDZCcE9VQ2ZpZ3E0cyswQzJndko2OFdMVXZ6Uk9CeEVuTjVSUkVj?=
 =?utf-8?B?OE1GUXZGZHlrckpJS3Z2dWNVTEZodjYwWDNjb1pJWHAvbkhLNmVIbTFRcHNp?=
 =?utf-8?B?dDZSbmlwbC9kYTYwMGZ3b05ZWmpzZDRURThpcHdOQ0twTDlrKy9qcUM0MzhR?=
 =?utf-8?B?V054N3RJN0hMWC9UQ3RMZDJaeEJLVTZOSk1TNkdia1hCclU4RGdQbTVtTTZx?=
 =?utf-8?Q?C/CM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxZWDdBaGd3L254bUVTL01XT1QxaFk2NU1ubi9XWGVseXJaVlpleXZqQWRq?=
 =?utf-8?B?a0gyRFpjUWs4dHcxZE1lV3NQejI3amNjY2JjNEpuTzFmdWpiNHhIY2M1Lyti?=
 =?utf-8?B?QTVtN1lDc3NqSUVya1liM2pDK01zOS9KaVZrejFuVFkxcTRJbDVYckIzb1Ba?=
 =?utf-8?B?UGFUaUl0cFNjUGhyTmJQRUZLa2tZN2dLOFV6SnpJdUN5cjdEbTR0QWVPejVq?=
 =?utf-8?B?dUVLbGkremN4cXhTYXNKTTd0NjRyL3hFUzdEbWhNZ1F5VXBXQ1pvTTNGRDVR?=
 =?utf-8?B?UFlMK3RjNGFmYjAxT3cxRXRGeDdIU05uOE95SVVDREVId2hieHlxWGwzdzNY?=
 =?utf-8?B?YVYyTVBxeXNLc0VZQ2I2dFhONWpEckRER2NrYWZTQXZRS2MyVS82ZHEydWx4?=
 =?utf-8?B?TkFyN2RQSlo2YitTUXZxSTh2WUVlaEUxL2t5L0pCMlFBbXlROURTYkJ0Lysx?=
 =?utf-8?B?TEVoOXRYZ2RydnJnV1F1cTZicXRNd2d3bzJNTUZtNFMwZ0hHREZsdXVzVmx1?=
 =?utf-8?B?TnVtdU0yczFPWmxyU2oxOGR3RkFqWU1Uc29DdFVVbjIyMldDRUlZZnBuOHdD?=
 =?utf-8?B?SDZZUmlsVlJRL2M5ZWMrRjN5LzBYN2I3ZGk3cTluajB1QWt3eHhKVjlvNkcx?=
 =?utf-8?B?bzQvSEFJQkNVYTgwblBQV081aUIyM0UzS0E2NmRXMGFGb1d0MjZGU0RLbTV0?=
 =?utf-8?B?c29ZL2VtblE2M3lEQ1Q1d3NlYmQ2VU1pNDBzaS9Xb3VXa1I4cEI1djJLa2R2?=
 =?utf-8?B?d2d3S0oyZGo2bkZ6bjZaQmlKNjJrTzNDSWV5WU5RaUNMUi92N1N6cnBXSlFI?=
 =?utf-8?B?QjRvSm93Zkl3dG1oUWRjWm9XYmsrTlRrbXZ0QTZYbjJwK3QzdjZ1dTMzOTg1?=
 =?utf-8?B?Z2RDVlAxakVKZm10MFpoUTFaUXkxTzF6MHduODhHdnk1MlA4ZzlKeGtIbHZt?=
 =?utf-8?B?UXh5amIwSkpQOUQvT3lUWXlOUTNocDVjQXF3RlB0SlpRaWUzcEh1YlpLMHJ0?=
 =?utf-8?B?MjA5VVBjWkZud0E5QUh1UzdhM2ZqTFhYWTYweDZMemZqa0tqWXNvS1lnaE5W?=
 =?utf-8?B?bEtENHIxMjlxUlQ2WTRuUXV3cnNJTkR3SVlGRVRrUVFNRDRON2o3R2tVcktI?=
 =?utf-8?B?cVl0dXpJZnR6NE0zTnZNS1ZMdGVML3hUdGZUcTYyeEVLSnVDNXZFOHpTaVFh?=
 =?utf-8?B?amNjaHRvdElFcVlUNlQrbU8ySTBEMENOU0pja1lSdk1rbWNlOGdpeWh3Nkt3?=
 =?utf-8?B?S3lRcHVuRHpEZ1RNc1NYU3pzOERWdkJ2aGs3NnNDcklabGZBVHI1V3ZmcHJC?=
 =?utf-8?B?enNWRW8yQ2dteWFqWmo4RWdWcC9xVGRPOTByRE9lMk1oUXRGM1Y3TFF5SUJ2?=
 =?utf-8?B?b3gyazVPVUpjYzAyekhVSEZYU3VseGtSNFBOUVZpdnl6WXlqbWdQN2srNHVj?=
 =?utf-8?B?ZHNlY2FGNjVQWC9YRTNJa3JoUVRsZ09udldnUTMwYXRwU1JzNHoyTmJoZG56?=
 =?utf-8?B?OXhqQzlBR2djMVg1N2U4OWVkcHJSMWg4bTFBL21LZFFVNlhyeFQzbGoxVWpY?=
 =?utf-8?B?U1dUVTYrWWlFRXAxYnlicWNKb3IzMmUvSnRIbGVyTWtOc0RINkJtNmUxcC9x?=
 =?utf-8?B?OXBESHl1bnRDOExxY1hCaE9peEVQdkZ4dU5Kdm1yMTZicjJmL05DMnV1Q0x2?=
 =?utf-8?B?am91N2E3amxCUXZqUE5oUUdvMkRHeVFHTHlkTzJFbnZ4aGJJTFNXZUhLMVli?=
 =?utf-8?B?TUZaRURVMjlja0tLNVkraXo3Zlo5enRKUWtJaStRem9NTGEzOTRRSTVpV3RU?=
 =?utf-8?B?a09NOTh1WnA3NURJQWFTWE5xc1VVOEFnZjRrYS8vaDNSa3lMT1dVOFVWL3RV?=
 =?utf-8?B?bTRXSGlyOXZ5MzNPY3g5dWMwTFgyRlBrT3JpSllBYitXQkE0QmZTaERDTk5I?=
 =?utf-8?B?eW1TLzJDQ3d4d3JwZU9yV1R1QUVlNGFhNDFJTURBckhRR3crT1R0VEtXVk8y?=
 =?utf-8?B?by9Vcmx4RlR4bGx3SXFSWnBERVMzUE5nclNMcTk3RjdOa1c4NHRacmdwcFhO?=
 =?utf-8?B?ODJocS83MHNyMWsyRGdHY1U3QzZjL2ZpMmptQWY4ZUVLbHlzdlZRL3BYd1JH?=
 =?utf-8?B?Qy9MUzJXUkg3SFhaN0JuUGlPVjdNenppUGkwWWVaaDhpWTd1aDM0d3RiTlcz?=
 =?utf-8?B?QU9lOFBnRmFNTnpRMVRvRWtTUEpXRzNWeEIzSVFQcG1mdEx3QjBldHpNRS9l?=
 =?utf-8?B?Q01RNFkyUlV1SE80cm1kY01ZNUJjU2QxRWo4alhPK2ZacXUyODJOQzFTZndG?=
 =?utf-8?B?dFc0UmJTaExEQm5RdzNwTGVNcjhkSUYySlhneUZNWERoSHBoL1M0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a1cfea-9ca3-4147-8098-08de58253197
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:09:50.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccW16GdYxGVarXTi5sgxsvH2Ty/OqPZq1psj0Ppw9ArzyyGfou1bk5XOATU/PJiYshMAelkomSlvvpq2oVOxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2118
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74635-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: 31F814EBF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 11:52 AM GMT, Boqun Feng wrote:
> Originally, `Atomic::from_ptr()` requires `T` being a `Sync` because I
> thought having the ability to do `from_ptr()` meant multiplle
> `&Atomic<T>`s shared by different threads, which was identical (or
> similar) to multiple `&T`s shared by different threads. Hence `T` was
> required to be `Sync`. However this is not true, since `&Atomic<T>` is
> not the same at `&T`. Moreover, having this bound makes `Atomic::<*mut
> T>::from_ptr()` impossible, which is definitely not intended. Therefore
> remove the `T: Sync` bound.
>=20
> Fixes: 29c32c405e53 ("rust: sync: atomic: Add generic atomics")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Title has "Atomci" instead of "Atomic"

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/atomic.rs | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)


