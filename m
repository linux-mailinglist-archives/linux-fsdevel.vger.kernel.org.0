Return-Path: <linux-fsdevel+bounces-70674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349DCA4117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D384B3056790
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58C341047;
	Thu,  4 Dec 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="z4rdGj3h";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="WR3kkl6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [153.96.1.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355C344057;
	Thu,  4 Dec 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859161; cv=fail; b=C3T3GWDHj/g+aOsGXM0PYwSN02I9csDftMrEgjQ3fINKfbb9tUZAGruxwxAP3n5A95YWFu3fBzIh+CW7I2ghEMsmDxkMa/GZPIImYwhS+6h1JHqq5DI634no/eNZiJzYiYZ200bnaTHt0N67SBDWIEYtTlbXgSXfp4OT3puYwFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859161; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FK+Gte96sddKmpXJNCKvda33VKPwuFtn+Q9B2M6EugQ1gkQGUniPU+AyN/liwImzo0Hrzv2kdKoXW5aO5qYVjwKeWjmGI+U08K6h5xEjzdcnc5P34wTSJcGcQOHKJDg+f+Ea7Wl37/Wpy6LMPrbgiFBnHwAp7W1ow7JXfQPHL64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=z4rdGj3h; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=WR3kkl6R; arc=fail smtp.client-ip=153.96.1.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859159; x=1796395159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=z4rdGj3hP3qvhUuviMfyMafambiJTVcZEW3AuDwIDIxGLiAFK1grPCvA
   JHD66DdH6rbPlPCRa8q6BmZxosmqrw+o4yKpdQ1WiiaTyLuIAXxMZ4rCj
   GE/aC9wNGtC4Xr7Uidkm0rFuhlMNlSEcUo02jtAEKWuMzzfczUMdYYsjO
   G2+tZGBe1HEPRfnVCK64T0O9JJzsVSth8wjWosHIrPj1q274eaIrOsCHu
   11Xd46i0OiSoGqyrrAmx/M/oGm8csWc77a5uC3E1VE53EAuD/8O4ZQoOx
   HiEHkOcHPr/vgva5HCvdAggQDVbwQ4EZSLDPasTxpjTKYBhtBOt26LKtQ
   A==;
X-CSE-ConnectionGUID: jHZdX8U0SiGxoO4Xo7Xt5A==
X-CSE-MsgGUID: oQy0t0z+TQKRiFshMahwXg==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BABMVK1o/9maZsBaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8kmqHc0gKeBwDWSwBVRMNCgsHBYEgQ?=
 =?us-ascii?q?wM1DAsuFSNLBS0dgSd5hBWEHytPghtygXVBGT+DUx4Gaw8GgRUZSQICAgUCQ?=
 =?us-ascii?q?z6BcQYeBh8SAgMBAgKBEBACbkADCxgNSBEsNxQbRG4Hk3eddgGvazQHgjiBZ?=
 =?us-ascii?q?4FeBgyfZxozg3EBk26TC5kGqRYCBAIEBQIQCIF+ggAzGiSDNlIZD5IhujF3A?=
 =?us-ascii?q?joCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: 9a23:Z2+d7WyuJmbLBjlVhGbXBgUWOvIpQi3glEzRDF+/LjpZT+KlVQK5rfY=
X-Talos-MUID: 9a23:OPaGCgWOdhCNCe7q/DjVlWl+bNUr352NMkEjipUjssmbBSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="24467024"
Received: from mail-mtamuc217.fraunhofer.de ([192.102.154.217])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:38:03 +0100
X-CSE-ConnectionGUID: /5gVuFxZTJmG/2cY0nGXvg==
X-CSE-MsgGUID: zsUptGW7S4urnkpE8VhFvg==
IronPort-SDR: 69319cc8_prhtm5rss+Jauk5fTPkrLDeNf//3nbNXP00eVzF7oCC6E+V
 DWm2iOaJdBgprJXp3eolJeTTlyc5WgK+c2YHBkA==
X-IPAS-Result: =?us-ascii?q?A0CDBQC1mzFp/3+zYZlagS6BK4FuUkABgSYuW4ghAQGFL?=
 =?us-ascii?q?KVrgSuBJQNXDwEDAQEBAQEIAVEEAQGFBwKMZyc2Bw4BAgEBAgEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBNwEPC0YxJ?=
 =?us-ascii?q?QYOBSKCYIIlBBIDNgICAqYfAYFAAoxXgQGCDAEBBgQE2yQYY4FkCQkBgUGDf?=
 =?us-ascii?q?IFygmUBhH1xhHg2gVVEgUqCdT6FEIV3gzSIRZEUSAp4HANZLAFVEw0KCwcFg?=
 =?us-ascii?q?SBDAzUMCyoVI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWYGH?=
 =?us-ascii?q?AYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3FBtEbgeUH?=
 =?us-ascii?q?U+cegGvazQHgjiBZ4FeBgyfZxozg3EBk26TC5kGqRUCBAIEBQIQAQEGgW8LK?=
 =?us-ascii?q?oFZMxokgzZPAxkPkiG8ZUQzAjoCBwsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:nW5f9B1j4qtFt2q9smDO+AUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodOSzg9hDndZ79qS3YqsVE6QTBHd/LHK4uaQ+88
 YFAEDTziBoeNjAb9mrblZkj6cATqkeenUd8wIqKWp66L9tgevzFdogrAi1/YYVOCiwdBLyfZ
 LMxM6kMNvsJpoLfuVQ0qDGbNDn1CunIwT1Epn/u97EE1/gNDy/c9j0hH8xXm33mlPWpLrcvE
 tu70LHE5AueQupqiRPE2anuXRAbgd6vUoJwccnW0UopJ1mViUqsg5a6Lh2n9/QkrmmX9sw7b
 s+GsG57pw4ggjui38Z0l47rqJwr70Dt6gdGnKk1GtLtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZE7zjviQKbeLM6G+Bv+UuaWLzpiwn5oK/qzhBe3pFCp0fa0FtK131BDs
 jdfn5HSu2oM2R3e5onPSvZ08kq7nzfa/w7J4/xCIUc6mLCdLJgkw7UqkYEUv1iFFSjz8Hg=
IronPort-Data: A9a23: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
 mL2g6eBS1hsAPAYvD4T3gGJ6oMfMUTHIehw
IronPort-HdrOrdr: A9a23:65EbJ651bTjXkmOL9APXwDbXdLJyesId70hD6qkRc203TiT7//
 rFoB1/73LJYVkqNE3I9eruBEDjexLhHPdOiOF7AV7IZmnbUQWTQr1K3M/L2D3qE2nS6vVU3q
 JtX6x3CNi1MENzh8T3+ym0euxQpOWvweSBnufUxzNKVgFla6Zp8gd/BEKyC1RyRANPGJo+E/
 Onl696jgvlUW8WZcz+IGIEUejFr8DKk5yjWhIPAhpP0njtsQ+V
X-Talos-CUID: 9a23:DLnhkGHC3U29HnYeqmIgqUEqB+41QEH/yViXeUSJUWBGeKOaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AV61GBQ3fb+EZe6wfWaQFEezAfjUj8b+TEFwirso?=
 =?us-ascii?q?959SeMy9oFmejjBqpTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="32625299"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC217.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:37:59 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:37:59 +0100
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.5) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:37:59 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDCKFzlcX5x8DtNZ4MOF2LP5QLTnrGXDI/RvkUH2Wme9CN+ELJI/GHyEqcNseNdxiWJ0/IECmY50Tr7G/0XPU5RKCkB+OEa0ZmsmN/jJHxElId9itfyLyNO4Me66zh+F+FMYx21s34NA3MXqo9ze5TjzR9MtBdkE7geJWZYun2OEuqBmTAEipsJoUZQqUe82a9tq8nAeZk6T84jLI/+zukM4OMW7OoeURuIimkorPj88hXU66v4LBBcmcHZ8GErWEBvjhRA6rCqzOejoLJQdCQ4FHIz7zjhsnQKgSMxCD0jevlmROcAW7jRK28LZ/XRgVNG2ERvaUsBO2u66oVOqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=xO2uw+ras5LYcqkSiIQ3wVdV4BHfwDknE0lwy4omWJ9OUvsUSn9rHoTk/xFkXqodOq/68dP09rL3q9+LyUGWDZrNNaaKU8e0UYuLMfczxgJOPz3pd1EiTVrq+rkgT6nDOpsJ9Q1U/vvWXg8XUFdQXHwyo6tKh1U24fC14nCKktE+ok+HmTBupZ3ijawzRtXyv4ATOmnpCMXT3ndw+oghyhAYKA6VLFK8wlhR1ca1AjZyAYfTkofmYX50Kv3ftKxfhWom9JRvml5KPwkP97u2qoynQr93aW/sPRVqcAoeLeddk3sBs1kBDd2Srcw1wXNbcZVwJWdOTijGad8Eygl2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=WR3kkl6RwGsIvl7pc3Y//VW+w5h4nWKcPVT+ecu9acJvgRmBMYX1fbOcjdHhpBtVltDvFrBYihv1CaZPH4rxU+SftpdAV5EqT8LQYINGhRHGKgXhhkopknX28owTBr7yFZIxAuidqN3SEASh4dg9Hkeqi0uoJFvVMxAwJW4GhWg=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR6P281MB5042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:176::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:37:58 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:37:58 +0000
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
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>, Andreas Korb
	<andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 04/28] riscv: zicfiss / zicfilp extension csr and bit definitions
Date: Thu,  4 Dec 2025 15:37:48 +0100
Message-ID: <20251204143748.8748-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-4-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-4-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::19) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR6P281MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8d267a-89ed-4385-31ac-08de3342b808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jw2yDzJQt14luTo4tYG4pkLeyWiIJwWZoBgP84sxp8f1eB9GSFSFxzs/tQCA?=
 =?us-ascii?Q?oA85AnTR/DOd2LD9S/sBqTSKFLKNr7CZAE0JJQGEqIj17RUSe8hk6fj7ExbX?=
 =?us-ascii?Q?+H/KcBDPguCMDwEa0EldVBCuU7o4nFN6mX0sHx8pN+DaeB892jr5d7p0QOKy?=
 =?us-ascii?Q?W1mtN7XYpd+l8TG9OgMlYF/vhr9lpKYRhJunrtC+umyWaNVoMJg0/7bU6V/J?=
 =?us-ascii?Q?q32yfglhjE4nev1Tyti4BcVx92SjE9cbN3jSaBFCTJ5FSysx2NQBPnc5uhSe?=
 =?us-ascii?Q?ZsobnsI4y5ypqKZ8fHeGwv+OJwWEcb0cQP2hbjyso1Bpx+CFo5gXhN75wfhF?=
 =?us-ascii?Q?ixbfOw6zq++gy++rF93M4ZaPixv25TBhTvYaGusOgtWuRJnyuLgoKDPUka3r?=
 =?us-ascii?Q?NjRRTsaf3y6H+zL/zDffI1apDhZR0o+CU3l+O04Xtu9SJGLk/NG0e8v3yVV1?=
 =?us-ascii?Q?sI8CDRFU649L4nKsa45FmaZZW5PV6bce8i33+hMszq6d8J1KohTJ3in/y/ao?=
 =?us-ascii?Q?vLhcVx6k/SQvYWbFJ7CxMHWx1rumkqvh3D6lCrdyQ/TY/Ruosz0Bb7DqJFSu?=
 =?us-ascii?Q?fVk1/Mr9/+qfNWH4nMsHSlgc3NXHDcx7mjLohay733Al+GjhKaD15c8nx6uM?=
 =?us-ascii?Q?n3R+HsnP4mki73MxgekzFklnSVYnDTrYW4OuIotgKwgnv1ndxG5XyHBh1SAv?=
 =?us-ascii?Q?wyfHYOC//jaR6/tuKX7z7+qifODVZgYErKs1lSAvshuEBZqYvkJV8pw1xAfp?=
 =?us-ascii?Q?Xov/hH8neQh3UWhva+eL+TgV1o9lZswko0cBxv4tOcBci0muKJDTWXBOUdw1?=
 =?us-ascii?Q?gctbP1HLMw34jtr32vT7+FSOnbL18fUfqKXoVXRAueQd3aQyZlJiwL9MM5ie?=
 =?us-ascii?Q?QEpySapCniRIvIIYz6EVRiNL5D+dH5DVdQ3a15vJhSHLVfbUZVGZUt1BmyWA?=
 =?us-ascii?Q?ycF7eIPXXVIHQEs7NArvoPY9nTaAC2dQUWDBD/j55Vilvl4gkjCGFSCu6bPn?=
 =?us-ascii?Q?QxX/RovWMkkv/0XnLhT9yerme4FLATk4GEcGWPZ9x6J3gpF5mf0t+RXoSxrw?=
 =?us-ascii?Q?BWct/5ju86z/M4sg1Oh/SyUso9kOw2b5SkTs2rewgMLskp51RbzEq0hbFB3E?=
 =?us-ascii?Q?AkSiKcqFG+lsU/uKkjkTcrBV7VmnIgmRoELX893GPs9NVbMirNlPzcEE175h?=
 =?us-ascii?Q?ESVva81p5ImrgxmjbeWOaZ0KhEJC/H6TpqmQH+/nMQaNGDZLL4aRxGvXPby6?=
 =?us-ascii?Q?8F2fAMsdkytY2gHkgz6YFz5UWNrL+LbaD0dYfgPHFDj/YDFmaukzZMB5Sopg?=
 =?us-ascii?Q?ujHIRRwy3/miYmdLFrMlcJC/uQiE6wgmjvyY6Ci2oEvS5mrqdtAKWClTlCJ/?=
 =?us-ascii?Q?vFQKE7psVwCpVe8gmO9eZL9mV24tJYddddkdFn1JcOvOAEieS4MimCEoq8Mx?=
 =?us-ascii?Q?49I0I6KGBWjQMAemg133XPyi2bJqt1fD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdZ0iAn/QZNShqng+ZnoMOXdQaj3RLXk6bx1fD47lpfyNyz7Gs8GD4xrK1tN?=
 =?us-ascii?Q?ZOoJbI7eCZq29dZ2KDv1CeZIWWxSkJFlLr4Bw9jYpI/2WMyv1JMMX6Ijel0y?=
 =?us-ascii?Q?xAFTj94BRFSyLEyS411WfFh+CAvSZNk6viCjf2H5dAI5xluvVYJoy3uhwCFI?=
 =?us-ascii?Q?oNWBb3VBFwireE/apdrZ30/IpbsKKRMkkh7GZKIDQ1KuHdVr2Bzm1/Z7RBeI?=
 =?us-ascii?Q?WrRIs0ptcO5fhPx3sgcujXsbMzoqXtVwm3iOFdl+OavocZzDXYSHP3mbaQIN?=
 =?us-ascii?Q?NMKLYIYgmq781IO8akmnhf2cRjG/pzOdLm+P/kGVJ4kx/o2neWnAyGSflFt+?=
 =?us-ascii?Q?7rw2tgjHUYD6lc94UL84C3WyZLK/jvKKJbrNX4qzO/HZJg2qHTNHim0QOcWV?=
 =?us-ascii?Q?JPi3OFrw2Xra1KORvbK54fGUI7Ok2/d7nmIsQK1pX3uYl5JarKQy9h7gDlpF?=
 =?us-ascii?Q?vrX44n09y0biiACeEH5qs2DPGwD0QopYzdxKymRs02Vu1UMkBX43CbdX9fEV?=
 =?us-ascii?Q?jHXASmqwZ3GKpl11UTEuWawkHKCxZkJw2oBGDjBWfXChTzfBGtd2Z83ldi+e?=
 =?us-ascii?Q?glflomg68B4PXc+oUHS/upVdma+PL76deGTCfgeDOviQEZUhpau2ZgTPKxN9?=
 =?us-ascii?Q?Xxl5F4/u3wSuFJGpz8wvVjaRRGsUWhwrhBPFApCj7Z8HcTKLgAnwSZeUOM4X?=
 =?us-ascii?Q?mkEPm7DPlpqMY9grTRs0Z5z1YqmNZGG+hUJCglQUXtCvOzYyQDfVCEbDOLFX?=
 =?us-ascii?Q?AtClkraMeKM3zv4wYKXOyFd/M0HLKqlkp+8+Avd+7/bNyghpHQAEXrDY54Uq?=
 =?us-ascii?Q?Fugatf9lyjSjptU1btnGR03ovmM6MNE0blt6K8J3MXCxVAnICRqgU4rdBLWp?=
 =?us-ascii?Q?4I3BfgdZStgKd5IspHcUj+/KqdrJvk9zqfi7QO98f5XGXp9epwbS82z2TQyR?=
 =?us-ascii?Q?DnTnLDv6rKwXN7HKyQmbZQbA6NGtFOwkfyqetHgTgCivbb0v/tVzY8ZnvN1V?=
 =?us-ascii?Q?zm0nmPuqYQtN0xzF60So55s9VgFcWKLDklDalAYJsfpRVIBcduTxcrCReMLZ?=
 =?us-ascii?Q?q1vxeLP88OhRsIH3nIlgRG/vJ+jAiR4aAcLOFw95eKAxreAfejqhofbyBpKz?=
 =?us-ascii?Q?AIgdWvAa253fGL37vLgukLGS1LY7Pv7zHfL8rNbsU4YVo8XqK2AiEDViXSc6?=
 =?us-ascii?Q?QiwZ0oS+6ebS0+43rX7HJLlWO7Gqq4Y8c54qT55SkAV79zzuKyB7LLjGnk/C?=
 =?us-ascii?Q?U7GoU6R52ZA6tWmHUEtyH0lJed+otZ4/VIdNsz93nbsCMQYMyo+jGNInvZW2?=
 =?us-ascii?Q?oPSAfpgnAKDM74590bnRZFgldE2vztZ4+EKE6LW/p9ECWnwC58uLBxhZEfgr?=
 =?us-ascii?Q?mX72hHYaQtd0k15IHAVg2UIQTQR0Ez6/kEuo8XTbJQRI7+GZAXN0s5T5vsDS?=
 =?us-ascii?Q?0MgMpq43cRfpob6hgDFYwM0zFB56mc0wq6KIBqZjvktAvJikyq7uEWZxQB1u?=
 =?us-ascii?Q?T3UusOTfkqLWYrg+F9ajga1JJQ8ynm+BMgl5ed+KVZgi9zJ4oDMFQq/yASKa?=
 =?us-ascii?Q?zVLbJcXNkASC36YanfTQXrqcaLytVGVQXuhMfGGZGhkeeqoNRqcPoQAXmuTW?=
 =?us-ascii?Q?ZMrwvl1PVZ0Q7ZTMytQvfck=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8d267a-89ed-4385-31ac-08de3342b808
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:37:58.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgZ2/0z50igoOvwbs1MYGmnZyL8vsCsCf6KEUWdJWGNsXkhCzgQGeXZz21LxnDybiPtawkoezwgwmD2qbZv1ur7Cu+/z2wjkRrKrZS9rQ5nz/UmE2BWqLDVdoiyeU2U7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB5042
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

