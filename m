Return-Path: <linux-fsdevel+bounces-70680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBCCA416E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D047B301AB1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AFA265CB2;
	Thu,  4 Dec 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="HPGQCqvj";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ipSVVWJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeMUC218.fraunhofer.de (mail-edgemuc218.fraunhofer.de [192.102.154.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CE261B8F;
	Thu,  4 Dec 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859686; cv=fail; b=UafhFSxOnb93+VDmnMGb7fv51A70jPC0kn/Qea1j/QAFqwXyhH1jcTg3413H4HmG4kXvwBKddyvyb/cbVc1YL4G4NJMVOEIM4pRaE0En35H6VpIocTlltJYQ5ojoRufJxIvMsIVxhvHwIERVgmtrv91Ki2d/xncT2/QBm4BQR+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859686; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeV18Hwednf6jwVtc3ilrhvUMIATQ9dvMttkaahOPFO/mclIXFNVEqhB5fY7hB4LfMwTePGC824RQd+CAG/ckPL7zWzfZOo3l6gLe/t+ovxlyJgwD6I461gRUcYFbXuZ02knW5mGlP2QtINeb29i3nagqEDkqm43jtQ5wG27tuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=HPGQCqvj; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=ipSVVWJp; arc=fail smtp.client-ip=192.102.154.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859683; x=1796395683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=HPGQCqvjxuiJFUZi6+ICrepiC08zw7Kjn6bbbAFquEHV1aSU/g5kdiuI
   mJfunMxuusspYgXehbZ5NPK98/xj+QQRB0Q/pyOCz4aBDFuWIOmGWOv4X
   E8cLWx5lF2rG+cpUv6vbkdBLORmtHwFV8PbnvL6kaBCspL4o8N98kWdui
   d9vkZv3i900MqOqp2l9fRNXhjFrocv4Vpp9JQyTFHJOKF8dxkA/dwOKgf
   1PrSKa74/iTamko0flKg6q31IJcA8kbYHBTibtbXgoGDpkzKkbDk7/vEs
   Uj4s9w9MsXPn6DMKfi+Ef7XBby26YUujcXjTkUpLUSy94yictlY3c6Dmi
   w==;
X-CSE-ConnectionGUID: JpAjUJDzS4evLHuEynOlcQ==
X-CSE-MsgGUID: zlZub/+RRu26xS+KJVGXMg==
Authentication-Results: mail-edgeMUC218.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H9BABMVK1o/xoBYJlahRxAAYIlsziCUANXDwEBAQEBA?=
 =?us-ascii?q?QEBAQgBUQQBAQMEhQACjCcnOBMBAQEBAwEBAQEBAgUBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBDQEBN?=
 =?us-ascii?q?wEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwgmQBh?=
 =?us-ascii?q?HxwhHc2gVVEgUqCRDE+hFg4hXeDPJpdSAp4HANZLAFVEw0KCwcFgSBDAzUMC?=
 =?us-ascii?q?y4VI0sFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJAgICBQJDPoFxB?=
 =?us-ascii?q?h4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd512Aa9rNAeCOIFngV4GD?=
 =?us-ascii?q?J9nGjODcQGTbpMLmQapFgIEAgQFAhAIgX+BfzMaJIM2UhkPkiG6MXcCOgIHC?=
 =?us-ascii?q?wEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3A8lG7OWuA6c/ntHUoF6T9Wt4Z6IsHalTf8VX8MXT?=
 =?us-ascii?q?kBHhNaKC4WFm3/Khdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AdsZDFA/XPsB1uqS1jU8S4UGQf9Vs0bmkTwM3q4h?=
 =?us-ascii?q?c5dm/dg9SBRitqTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="14662571"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeMUC218.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:47:57 +0100
X-CSE-ConnectionGUID: vdMqO9DqRhm2ejeq45VvVA==
X-CSE-MsgGUID: 3BuuErO3RoeH0xgPbs0+bg==
IronPort-SDR: 69319f1c_uM9V5YonhPoXhZG0u1jeQ5ANTLumvSSQXA4sK12Xp2tfmWM
 YZy07eskJ6Xg2PVptJqS8Bttk7egtaNzywFWjrw==
X-IPAS-Result: =?us-ascii?q?A0DuBQAWnjFp/3+zYZlagS6BK4FuUkABgSYuW4ghAQGFL?=
 =?us-ascii?q?KVrglADVw8BAwEBAQEBCAFRBAEBhQcCjGcnNwYOAQIBAQIBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBDwtGMSUGD?=
 =?us-ascii?q?gUigmCCJQQSAzYCAgKmJwGBQAKMV4EBggwBAQYEBNskGGOBZAkJAYFBg3yBc?=
 =?us-ascii?q?oJlAYR9cYR4NoFVRIFKgkQxPoUQhXeDNJlZSAp4HANZLAFVEw0KCwcFgSBDA?=
 =?us-ascii?q?zUMCyoVI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWYGHAYcE?=
 =?us-ascii?q?gIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3FBtEbgeUHU+ce?=
 =?us-ascii?q?gGvazQHgjiBZ4FeBgyfZxozg3EBk26TC5kGqRUCBAIEBQIQAQEGgX4mgVkzG?=
 =?us-ascii?q?iSDNk8DGQ+SIbxeRDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:Bb8RpRGe0yOsgbcW+XorIZ1Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuSvee43wrwDzuvF7+jW1BPzbFpAmZGW89
 ZdQVgHOo38sLD4E6WDZqMp7gL0O83fD7xYqwpbvXr+qFuJ+Z6rNVI8YRlhLUsYSXnIaP5usa
 bU3PcVZY/YIqKW++wU/6jGmHhivGtHh+xZ2vUTKx6wI3/w5ASPI9w8GA/kyiG+F9OnrK/8cX
 tKR/PGUkhiYZvoO0wrZ+dfsQh4F/duhGpxKcfTXklNxKzuctw2T9qa8FCGVz+IwkWSR9c0+T
 diFqTZ8q19TrjeM5sV3iqDHvYA08Xzc9wVCzLcZZvOZZ3ZGNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WkWtLWpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yW2cka36aZwKwyrm0j5TDQqjBMIkLtp133Aq2lEZdPU7SKClfq
 yV9sjzvCWc4F0ssRob9uxoVpPsfU/h
X-Talos-CUID: 9a23:6KrPV2Oo8CbLB+5DRiVC7WlFNtkfcniHwXXdOhPlN3hXYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AeU+IeA8wGQUMSL22LFH0XwyQf5xC/rmDEmdWq5I?=
 =?us-ascii?q?Lm5GUOhR6IG/ehjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="34567495"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:47:54 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:47:54 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.5) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:47:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynK7NVmqET92Hg5tpf9YaJ4ntKJPvHtL/yOgtJeOXy5+K9hnYMQeeI4pn5FCLUdEEUhh7D63dkpFjYCcLZ2GuvX+CevpzfhsohLS2rkV1yMTt8y2I8tlfI9+qfAHKOHzdT03Pr0o1nW7jeek0/1la6vzutrnJPrLLyvmGNqBtT1xJR+oT/rQbXLQdu2d57aEzLNy6ZIq3gEF7KS2TTWXS+/eLoC92JhtdUrNNEkri/iRoo0wvDOS1NK464AHbB+EsAym5LHk24cnYJwb8mh53VNWaBCW63qh/gduQekex2CtZu0mpz3lfXGjbEpinicfOCyJ8muWIxU91BRNTZ9JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ZE9F1innOeY8QgGX8UBtk5j+BUeK3kcd+TicdDJiOl2R8D1a8vQyM/mWAFXZBVrux0utI7EX3LRgHuyfzZZduKRIJrO0V0Q01yYJgxh87/Z/SIJ6QmadMfATJf/vQC620Y+NWqmB6YPHDBOfacUoxctm3Qk5HWXQO0qX3LDM85kR+zfTeFB45jbFsRnj/ch4lLLNOuCSue7RQrVJ3xJIb0ReC1FA5c4igD3MxuVj6qjNg9QylCXIRgWFdqoAvku0OhqJ8bdzwfF56XEvxlUs6hXGTJp/aatnPgy7lb1DH31kAtBTB/YqYW72zUBbcpSTM50SVspSmZTOn06ETcqj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ipSVVWJphqaxA4jkZbdh+a63UpxnVPZG06x8oD+46Y/BpsykvZfYAVSSTriZdppxJfCkNtCTPs90Tvw0fgZLX047E3aa0bULy7LXfL4BE/FRhVn3r6TP1Q0k7B1CzhqnUJdbrO6pRBJ03h6JdgKHj3hAfSjISDpjHSdYD+FIGPU=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BE0P281MB0177.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Thu, 4 Dec 2025 14:47:53 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:47:53 +0000
From: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
To: <devnull+debug.rivosinc.com@kernel.org>
CC: <Liam.Howlett@oracle.com>, <a.hindborg@kernel.org>,
	<akpm@linux-foundation.org>, <alex.gaynor@gmail.com>,
	<alexghiti@rivosinc.com>, <aliceryhl@google.com>, <alistair.francis@wdc.com>,
	<andybnac@gmail.com>, <aou@eecs.berkeley.edu>, <arnd@arndb.de>,
	<atishp@rivosinc.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<bp@alien8.de>, <brauner@kernel.org>, <broonie@kernel.org>,
	<charlie@rivosinc.com>, <cleger@rivosinc.com>, <conor+dt@kernel.org>,
	<conor@kernel.org>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<debug@rivosinc.com>, <devicetree@vger.kernel.org>, <ebiederm@xmission.com>,
	<evan@rivosinc.com>, <gary@garyguo.net>, <hpa@zytor.com>, <jannh@google.com>,
	<jim.shu@sifive.com>, <kees@kernel.org>, <kito.cheng@sifive.com>,
	<krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<lorenzo.stoakes@oracle.com>, <lossin@kernel.org>, <mingo@redhat.com>,
	<ojeda@kernel.org>, <oleg@redhat.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <peterz@infradead.org>,
	<richard.henderson@linaro.org>, <rick.p.edgecombe@intel.com>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>,
	<zong.li@sifive.com>, Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 12/28] riscv: Implements arch agnostic shadow stack prctls
Date: Thu,  4 Dec 2025 15:47:46 +0100
Message-ID: <20251204144746.11545-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-12-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-12-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BE0P281MB0177:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc735ac-7bc7-4b1d-c5d7-08de33441acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iV7K3XZS/4EjEmGRcPbMsRbXm383JBmE5ERkIKiwHbVXKIZRj2jycndqtSpI?=
 =?us-ascii?Q?3Urtm+uEITqK3lUfkSPb+TOHmUfgRjz7NZMGcrxjYir2OKbyht30SHJjaRda?=
 =?us-ascii?Q?q374EnvsP+2T7lwHTR0N4nnqkiaIe/AeTcFOpfJSyR1yZ1kffPgcrSQRdaqG?=
 =?us-ascii?Q?Z3JRissfiKw6Z9/+pwtXPpb2FTdU8AMvu69E0/qTd4wifeQAJzcJGzbWK8pn?=
 =?us-ascii?Q?yP/lbt7dQvhzQSGuqMlOpT94j2INMyeKJaLBo40YmyABf7qHEK0fLkNrp4gc?=
 =?us-ascii?Q?7ajaA6Aj2y3fwwoOAjCXnqDU5bp2jEKG88/fR2LLbvThYchqsTV+m9T0qjrm?=
 =?us-ascii?Q?wbZpsFjQldz2Jh7e3YvJlvypMUibChF4x7kvllqjiZTrZyXV5z3j8X3H50n/?=
 =?us-ascii?Q?xl40AJ7akS0GN9VRbenAuVFvG3kfmyBAkXbasLj56a11+tYhzg5KChQnDVd1?=
 =?us-ascii?Q?P4tGBKhp95VWGK1g1D47DRxhYDNy6oIxJubwtt+SexLJICaxGf+tbR9kjzFw?=
 =?us-ascii?Q?MIYzoyF+KF7CAtOA/R/G4e8vLVH6aAs0urZ9x6EtnwUU7u56fekNtFEl31CU?=
 =?us-ascii?Q?XM06fSovwMdNtiGQLXniWmglEtI3XchA3r7N05xTDVUpIOFytfashdhGda3N?=
 =?us-ascii?Q?3x3+rbOHdNIyamkRAX4iaqK1av49Af9bQU8kgG0+gl4GbACYliMZdHyX29/s?=
 =?us-ascii?Q?mzl/55Rlbw8mH9+VL6IQjOkKF0nbwd5ep+ohEAE4RnjPS3mBj6+wHaHmIxaD?=
 =?us-ascii?Q?10rW5QaY+enXnbFRyqVSERrLskwjHrcfioFUtODLbfsRiEK4F4iHPhNkTypa?=
 =?us-ascii?Q?4U9QWWYGHraj5Yzu9FGnHYongreGpuvzKpcG7+cHhAP4KMKOfCKXolAXwSAU?=
 =?us-ascii?Q?GLAg3kcqjh/NS8/sPEkqVlHi16nuGfgQYokDYZZ1GVB02wmOOMLwXNd8d5Jo?=
 =?us-ascii?Q?P6GHCqw05Q7PL2SXcrFsRpylbKqGsPyiTEnGUTMTjZA3d0vx8hSIWdQYQ2EL?=
 =?us-ascii?Q?jJiw1wmE+GXtAEZrilpEfHL0ghYp/Tyw6dkW7HPHJlPRrtizMYNnfY3uFaV/?=
 =?us-ascii?Q?B0/lEIs5f2oW9PcL6fQ4QP3fPrypHjzVkcPPK4I5ih1YtVZBpJcoErYoTxd/?=
 =?us-ascii?Q?HE3z/B/ZakaE1mopfT8fdZzH6Cqf7/47c0cvUzw9EVy/rxl4e7q3Xz8sO6UH?=
 =?us-ascii?Q?Im14DplIi40xpFccAhNjFtdd2FjgQ7OI11aIfeicCXvtHiAlj4zQ3fP72f78?=
 =?us-ascii?Q?T3IhyyLz+d8SebDHe+YhQ+XQkwb7ZwGg8rpCdJdPQzVDVSV3+X8XthmkJk1l?=
 =?us-ascii?Q?Zri5p+nFTQpWxx4d8mTJKAZ0cXcN1ti+q/uFeU6KbmVHdvLzCCe/BeBYnDjc?=
 =?us-ascii?Q?yKxJ463mdxAVECZtLd4p59cOpos9QM5tj2Ylwky1DPVt8/lLjlJ8p725onVJ?=
 =?us-ascii?Q?miPNps2SE3o0bYvGkHY7IAr2ha4UyrUN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udOS13GTWICd+L/62HgLl46/GrChPgF/cDDB2A9Cvu9O/ZMldfZsfsZmL3fm?=
 =?us-ascii?Q?7S3EYBBqTATHU6hG1+aWqrVEUZWCNdXYTOxkZ+0oQWcP5Hi7AvEi1QIwSVap?=
 =?us-ascii?Q?wbdmX6LKJOF1Cv9UI3y3fbsvc/QKqhTUTKXZS3el3bcHig/e4a+UHVn5o/XF?=
 =?us-ascii?Q?rkmigM2BpDlJqSf6QIzxMHKEhPJZE8BkZ7t8QRn3+EQZXSlQTzQUPKJqaiMj?=
 =?us-ascii?Q?UyOzeu6WctSQz1zf/bFmeVyx4ceNa4d87iotfunCQ/7eme71q+mpu7Ql0HRq?=
 =?us-ascii?Q?QyNRXNHNBy67Krz2IDn4NV+wQN75170HF4wxVt2s8PAu3lF1om1qpd8EgUsH?=
 =?us-ascii?Q?XUxy+WL2CpHLwkd9SpONddluh7inU8tB+qJbeNiwxENznejZ7wvAZiSP1d56?=
 =?us-ascii?Q?cTDVlvPnw213fRtd9nxQ5FXdNPabPoxSTUUnD394Fj0yea+X/LpJaquEVm4x?=
 =?us-ascii?Q?9OHUkcdBqDzS1VZSvrTx+ADITn+IAkLD5TdlWYYr5CXR5IynPhfLwq0vIPI+?=
 =?us-ascii?Q?dEZUZMHpHXUb6SgVx2aAoMS6/Pi32rHWPAB2i8Q3y06w+Z1UclOUA1StcnHZ?=
 =?us-ascii?Q?LdUr3YO8/FCAcP+N8hR5Yhau5C5EQgjvBpz/BJE88IpVGOzOQhBLc8R46fBr?=
 =?us-ascii?Q?upeKOUAsQSdpdSLD6uD2XlvYGGZFAs77YC925Ps2OCswNoDsmWDTSkE64ljw?=
 =?us-ascii?Q?AKbK+NhwCn8rsDQi6c8kEw1gMin1ZGbNLowURUzQxRCKgaz2SkIETnzZ6tnX?=
 =?us-ascii?Q?gIC1r4PzKozig9cZ2/7qSo1POIbloo5WGt0tllbn+RLMXb44ZClk6T25tn2Y?=
 =?us-ascii?Q?s+TDQCCxZusz/22pSZKSAxbONUFuRWVro+gioL00ERQjpEFueEIY1kXdeOv4?=
 =?us-ascii?Q?hxT3tRpHZRFl+prrjXUIdFQ3bN1/AxJ1dFoBJ0xu3AnN9uctGStB3ry+5hLU?=
 =?us-ascii?Q?UDuYqeHWKeVBC2JHpnW3YfddcvmMthn/72TOKzhLpYCYds75cDQUxtNTGw7S?=
 =?us-ascii?Q?BXaHzmfh+DSTHexZdTe6gjiIEQQ+aoWeOQQBHeJiSB6y5YUBFco4Ecd5ws3T?=
 =?us-ascii?Q?tvQ1tliYx3fEI8JXnwct2+bPxWdAhRWT9ozvzHlbKXvqS23DfqFTO1qAu1GW?=
 =?us-ascii?Q?o+BiSt5QL6tQa+dp6XjdUej1UUdqaVbF6fDZi+IZi28U5mfcWYBhqYjhlBQ/?=
 =?us-ascii?Q?pApH/xntXtGweCVo3NCc4tETreTuR0qfMfR/GzqggJpaJykRs/6k1/zYvW/L?=
 =?us-ascii?Q?py+E/FZSwEoY3FdPGOatgtK5H7dOnON3mbW997o02ckzzbOVsvhwL6R6WDxM?=
 =?us-ascii?Q?sZVBMnvPPRPjIYT2YkudwqHYqsAoDgE6Im75KBPLfBAvlfehXsqW0w07s0BK?=
 =?us-ascii?Q?HzqayWn9UyZIyWawVoI2w5GoZ+YQQyqO+bC9pwmLykCjKt3Ai79D1hZPdxLX?=
 =?us-ascii?Q?lRHENIU8lw4kkJgCFHC5TYstYpl4qn6gjxkc/y1NRo1vB+Dc6s0t2gu93qPU?=
 =?us-ascii?Q?4pFIUiNKWQomusRfcJfJ8oV3LZ2GHGUKpdEOs1LMdLAneej6QvWj+JvIq6mI?=
 =?us-ascii?Q?fjz19v7YNJB4217LNlaYxo0EcFXTVS0l7UNjJo0JEkrsmOPYc9VtG1ACy5Bs?=
 =?us-ascii?Q?MRFplx8jzR3JyxL0W04gNC4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc735ac-7bc7-4b1d-c5d7-08de33441acb
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:47:53.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHn/xB/snc0YQRSS62c6TM+pE6E5v1R0ACV4F2TPxsX4/bcib+M7RajFaKoFNRTJ2NC6OmU39tjXBGs4mETc0PnD57aMb8I4SCUcx/SSWZ6NXhR4ABZPeDqGojE+c5tm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0177
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

