Return-Path: <linux-fsdevel+bounces-70688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA811CA42D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716A03175E28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF32D73A7;
	Thu,  4 Dec 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="hHIw1ha1";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ETl+zjso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka30.fraunhofer.de (mail-edgeka30.fraunhofer.de [153.96.1.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDA2D5C74;
	Thu,  4 Dec 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860694; cv=fail; b=lGbcuyZCC/DGQF3JW8kM4dRegbYBfRkVCLR7KJBcJYa1Vz5G+SAmxIAoIfdV5b/FCDxffdOvpaBjOP+YD4RkHkx5zlGSd3uW+9jLgw26B/RYHlQeUxkPbLxdmjgh340B/kCGBWsW+8cR5ed/FpzG/MragsR7GRAsu5t9S2DUXK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860694; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOm9/yhtOCKVgo2qSnuKqlyHXRP2oyvnWVe7z08V0yL5NJgwumfwpdH0CYnTuH2Jz3pc2JY2Fo/XYLH/FBRuy+Gas6qYdpvjgcRfGKWHwHhLRQ6jQZ66HxqgzDkomDxq/fxFmBd4t8LQLBc7qoL4fTjfBubafL0FRi7KMAyHruY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=hHIw1ha1; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=ETl+zjso; arc=fail smtp.client-ip=153.96.1.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860692; x=1796396692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=hHIw1ha1ur54IaAt4c/vsx9QirigqQNOp1mgHS4ftdDjFowQ/YPpl548
   uzRi0EuPxi8m2NXtQjpuPcAzmdzlZwGTsBzFRESeU+IbVQcsO+llpw7J2
   dajN7TGH1mZoEpy8unfxaDEL24cT9TrZVOb9+H283FJCnBxyiJUeYC9Pu
   nzjIidVnEW/IL3JhlqLFx9gbLBH1G0XNnAZ3cutDyCPLZPQtacZxFMzpG
   RxVTKB45GWjz5w3fKfeNJ/yHKpzSR/ooLH85CRdzVCjMVmUc/GLsU/bPZ
   k5TVpeSAf/MwnAANko9ryvP2unMu6uywOLYc51lqwrGinlLsc9KO3iXPh
   w==;
X-CSE-ConnectionGUID: TYI/cfNcTVGpW+Oi+YANvg==
X-CSE-MsgGUID: WySyTbM4TByfKu3a4sXtmw==
Authentication-Results: mail-edgeka30.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BAA4Va1o/22jZsBaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjDzwFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJAgICBQJDP?=
 =?us-ascii?q?oFxBh4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd4clllEBr2s0B4I4g?=
 =?us-ascii?q?WeBXgYMn2caM4NxAZNukwuZBqkWAgQCBAUCEAiBfoIAMxokgzZSGQ+OX4NCu?=
 =?us-ascii?q?iV3AjoCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 AGADHs3rXLzJA==
X-Talos-CUID: =?us-ascii?q?9a23=3ASpZVe2lCG7vxx/RIdqftCiAYD+bXOUHs7TDbLWm?=
 =?us-ascii?q?zNVhGUILWbl7TyYpCjcU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A/8FRAw7Cc1wsJQhujUThhiVaxoxX8p+/NEoozak?=
 =?us-ascii?q?sqsenKHd5ZyytkDGoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="26280288"
Received: from mail-mtabi109.fraunhofer.de ([192.102.163.109])
  by mail-edgeka30.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 16:04:47 +0100
X-CSE-ConnectionGUID: NxLlOUnTRneRwtlMzsw0Ng==
X-CSE-MsgGUID: a36f4+AjQAW3aPxWfZcRUA==
IronPort-SDR: 6931a30e_BbNxoBTmQggUx+pbfQqn0zA8tDodRaI4QliF3WdhaZZAilR
 7ekWJZPrr+Zp1FgYWd10UmijOPdYS4qCS2Ru+jg==
X-IPAS-Result: =?us-ascii?q?A0BABQBMVK1o/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCYnNwYOAQIBAQIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBD?=
 =?us-ascii?q?wtGMSUGDgUigmCCJQQSAzUCAgKtNgGBQAKMV4EBggwBAQYEBNshGGOBZAkJA?=
 =?us-ascii?q?YE/g3yBcIJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8ml1ICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjDzwFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJA?=
 =?us-ascii?q?gICBQJDPoFxBh4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd4clllEBr?=
 =?us-ascii?q?2s0B4I4gWeBXgYMn2caM4NxAZNukwuZBqkWAgQCBAUCEAEBBoF+JoFZMxokg?=
 =?us-ascii?q?zZPAxkPjiE+g0K6MUQzAjoCBwsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:lm1e7xYPDYSjM6KuUoDZBXX/LTF/0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETAerLrszbRv+Zm3guGEvTHYOsUSwnz8
 b1bcwH2rgxfHCU5zXjWhO52h65E9UHExVR1lqPoZMKHNuF5ObGAWN8qWTV/QsNaXA5MPqzjd
 ogMVfVCJO0JtM7EuEUI7lixCAmHJuCx6mcUnHH40LAq3vkzER3J5TAcBNBRkXXtrdvxP4RLa
 uXpkZvLlGTDYP9RgTTZw9DLeSIaheyeYrVQVuzy7QoAMRiVkluik4y/IRW+2rUc7mGYsedYU
 /2gyEgfkhFIvCCjmOQjsqnSh59WzVSb+Hlj2YoXI9idaVNlYov3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOWanRukOlWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6I6AIKCvs9Fhu+PlHehWsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPH7P+UsssRQb9exoV5PwIk80maQFmrX5Xo3SJjUOxlHYSb2KhLGKq1KPexEWntQtrZ
 uIXJIOb+EYZmIK7/oSjjPId+oI8Z2s66Ck7N2uqUuFADsaHp1I3kNcMEK2A0d2TA5JCd4QE4
 ed3NNOo36FdW4MZsq2K3EZV6ybzue7467OUFojPVoK+QOOhTSn5PrTFAWZ5A4XV3dqza05+W
 bIvgTl7uGIsu29yDXby2jPhq4m7OfJ+59mPoihm8IVIjLjhkKBY5lgYaSLuHQPrOSm+D8R4a
 nxS0NLBaVOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCuJa7LgpPyfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0m3w/iuQe5kYvHbf2UIUh4rD3wXklW6voXRiKoLzPKd
 MeRf00McwmO29zbBjizxhSKZKXLzoO9yy9MzY/U/yuokdrdU9CvjclLewk7wQ9HcEGOut5Dq
 L/Q9JVvYALc8gXYMtGdZ48ffc=
X-Talos-CUID: 9a23:ChWKHm6Ty5ngTVnYLdss0l4wHucYdEHnynrqPFO8LHRyV+WzRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Aq+pcYw5RYNpc8t+3Ph+W8V2qxoxhuPqgVAMkk6w?=
 =?us-ascii?q?vhJKNDTxPNQWWtgmeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="41528298"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI109.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 16:04:46 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 16:04:46 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.2) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 16:04:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4XCWSg7yeM5Hy+taQTZ8UK7GonH0PgCa33BNNfX+mcCoPF5wcfaEyxIGuYdyTTeoGJon7I2lPg1dDqL5VT6nuT0NhFEi/8mS3g8l5GKA/SyNFYXI0boEVmR6vaKqiqblQqoo9r2xJio2tRAP+IqqbvOyP9XFAbpdnVwcMcaxyInd5EVPY8ta25GvJ5HYHRCADOnbiWupsttVvwA120z0ZreWcxsNd2doXKZg4GhwNPT4wQO90DojO7EKr45w65hxSYgWbVN9umFgQdR2tLa+0b7kFp7JfvQzdNoUkO0fPyy6549w7VNCCwdS0uTQje9rrfMkJ21lrQfpQvRDRo+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=abgWzd17IEK6/wHJLhFhx/h61fwOFyLTrQB0fLNk40J93XAkCppzPTdBx+4hdldFhhKiF49z36mlY1abLps8O6bxnMRTux3/yggojbRvfto6akolZWD3mRixidV3PDySe59u2/HBkz7YpKOoea5HdA3a5YTE383sGpuQ8O1kNqOfdAKEwH1Xd3fEPaJy4XCda7UauGNhLfoey212Bm7jAQt1wHhXTXki1ojunsS3Sj5vXnQs1ChVwuKDcWshzuYGBLENybiFd5qTnCVhueXfSZaTxfaCXn9r81MEqVCcaQJ7IXd3dAEZ3tlkFRH4qWOjtdv5tW8Iwm4Tn6LwDDLL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ETl+zjso/z5MdXt7VtmccJeTG7qkk2w+qc9s/Qwvn++gehCJk6H04rffeuxeuzhtgQTTsj7IiQiflcK1Sm45Zk19hgdo0kLC0kcZSLuzWoHONKL+GNs8tfZRh2vNCd9y5ak6ePnwg+NPQxQvpd6KgPHsiu+ol7e4rqdJnmMIuvk=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BE3P281MB5007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 15:04:45 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:04:45 +0000
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
Subject: Re: [PATCH v23 25/28] riscv: create a config for shadow stack and landing pad instr support
Date: Thu,  4 Dec 2025 16:04:36 +0100
Message-ID: <20251204150436.15230-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-25-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-25-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BE3P281MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be69b55-022e-404e-0b48-08de3346753c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eO5+3d7AQGUKmuof4ROn+zjA5B9Mu6G5Gfj4ZGBRrDdU7XP6DfZ1gNQyJOdM?=
 =?us-ascii?Q?rFNk1jtneA+zsYjtcRL2L8uDkk56XiHH/YhX9kwkkTgdfmlFP2B9IN8Sw22g?=
 =?us-ascii?Q?hyzgYXR9pyvYGyTz/CtkYY7V4uuACd/2nGwjugxG71Uwh3huKXP3RgNQDKrr?=
 =?us-ascii?Q?Q8n25CY7l1VXh0KZz+HPNvrPGa0zXDsCBvu4C+97yoovFQO9PjqwPWwLaxbD?=
 =?us-ascii?Q?UucHKBmxIrAGu7RiDTFiwqdb2SltFFDJRqfqalxsQ6rJLS3ha+ylaehhH7bx?=
 =?us-ascii?Q?zGzzDI553KTLqTL+XYnv3/ctpPiEhV/lKloZrVFjyvWTuzhUy37cb0aZhjYz?=
 =?us-ascii?Q?eofkW6JWEg/hnPCRfbsyUr0QgPROxfs2nnsDSnUi+Gh/+X/2wjWMawhGBrT+?=
 =?us-ascii?Q?HBrvxCBwm8MnUQ7TWilUkbYKzb4s4sJVWhWOGYfo76s2SAp9F8oWtXDr/vny?=
 =?us-ascii?Q?DTb+ILGP0Ev6XiLsHx8nKnzJmzFOIMe/XM6vmN8eWbTI8GGaxfT9fGD/kcYR?=
 =?us-ascii?Q?rJ254sG7kx2auA0tip+2CXOAeKs6nd9hoflD8XPo5PqMddCnjnY6DhLLskTU?=
 =?us-ascii?Q?BnHQLgiwSHcF7bu3aTL8L58M9AHnjK3+z8JMFWk/0Nb+X3TPDnyP/evsg3FD?=
 =?us-ascii?Q?aRNJ9IyFSNexcPGj/YslS0O3d+eHW4Z1hDzj/aGRXBe7aH3YkpTrotPjsFRk?=
 =?us-ascii?Q?WUKGtgfIyOTfVUA9FmGsYuEsDX7i6UQvirWlRnzSciBlGaQwrGxFDg4skMIh?=
 =?us-ascii?Q?uB7ICw7aUc3pkXleG8DPP5MxdGCp8NOUUgOQfX17XAMxSoxoRM5lZADvB1AR?=
 =?us-ascii?Q?54XEhf8SrpNiSrp0fRbRCFN0/eaXEM2zobMyUi4+TA5hJXhO1jle/5fVr0eH?=
 =?us-ascii?Q?FbVBHWX5THiApQ8W7xAyqVH03H2cVJg9p9uykTjN+wVtNKd2yAI/kyecL2wy?=
 =?us-ascii?Q?UpR4tjqj24v6ncAtx+Wv1OQxtlJWaQjIOmrgiRAyPg1TPNTDF/fTT02x44e1?=
 =?us-ascii?Q?FD+BeNTPyymKljUR5XXOi2iQu9ZBp1edWwJlqV2r1esX0z1CbOH+ogm+uudP?=
 =?us-ascii?Q?V/F1HXds4s2gbcO1ARKAvGFuOqd53wWfpCZFw/Axd5kfkUVfFwQoeaDZsEdt?=
 =?us-ascii?Q?AGcuOPZJMBs0/2W1zztxwyY7ipQRdxCrEbdEdMr+A74HqD03I+AW9aQMzYL7?=
 =?us-ascii?Q?iEnAIkE/d1Uj+9QKnXzvqOgaNJNtxngGD1oreFGEhBhEKxrtcjlsgbHEnXBu?=
 =?us-ascii?Q?Na5L9BhGOmAw8ee3U5yDAXBgg3mRYZtagx7Co1kn2LkmN3hwmQmbNEbtPYZ6?=
 =?us-ascii?Q?DUCGfCnLV73BsyeWdJ7SPEuRYg2+OLI2BP5s8zIr197JDUXm7hsMxh/tcnm9?=
 =?us-ascii?Q?GEJPpWP/5DmLHLBzVXdcn8608ltq6hL5i7fz+TP2w6DZoUAwpw9wA6U1L7sp?=
 =?us-ascii?Q?H+fcYpBIOflZuwwfLOxjWjOOdFk51ev/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hz7fuc/u4mxsQw/rJ0O5a0vAA6lYWb7Xm6T5UVp30uKWV5t2pKztik9PQikP?=
 =?us-ascii?Q?jOB9aKhUlqhqhwPHiNW0juXMQ/C0AjwDEWLgxRoWWCRmOK5Ar6GMAzxjUwfZ?=
 =?us-ascii?Q?hEyR0+TyBbhJVBBrnb+CSNc3qaoB9zme95/JXDEmJgU92D+8HMRVn16i/Teu?=
 =?us-ascii?Q?ALJS5+IljbCQFBEnqUlwV+i+lfb9XPRii9uM0IM20bMs5ImfwkwXU74bIYKG?=
 =?us-ascii?Q?hA+NYfD9M3jw4maboPNTEmEpuDCLzDnlULI2Pf1Rc4Ot1nQhVvNDLmuJZ9e1?=
 =?us-ascii?Q?sbrdSpSkxjw48uQBuOJ8zij8dnUapm34P1SdH0z7+u8RaEPJHDW4J3FR0fV0?=
 =?us-ascii?Q?YQmuGlmTXkUhPjQFVAWZ/8iPL0h2OdB+Ro0My+iDpX+XNdLxMLzrpCOwSgzz?=
 =?us-ascii?Q?1h/wVey3pBgY78fT04rxZIw/dDG8+aH03l0SfSgvaf7uVvFaC5TaIX2vYNJ+?=
 =?us-ascii?Q?rqTmhFOIVM+1TqxuMvG/4eg/sRZDSvfWKvN0yP/yk8nanz/1Hijrj2QDSg+K?=
 =?us-ascii?Q?y3r2JYeP76rRsIjs/xYLnwAQyMoUng+TRxtu0NxKFz05J7HDBot6b3Vqcg8E?=
 =?us-ascii?Q?1fuIqCem+sOQjYckvxXGxiMQyOaX9mkkpci3T8/L1eSnMrvBQBPmXNbkWTkH?=
 =?us-ascii?Q?rdITHLqxuvXJYCUJ+DrR/f0tORc135+ijYCNVJBbxYplGegyB1/Zw2b+f7E0?=
 =?us-ascii?Q?LWnR+Vk+ydzCoVAql2QCJpN9l44doXm+cpS/c+TLIlbSQmQ2z1Qgqe+ZDtsl?=
 =?us-ascii?Q?XYTFaFHK6NNQ62vk8cBxlcHO65lXHakkx/wl7Iw0V880DSJYqpMxe/v6y9oq?=
 =?us-ascii?Q?9lA0RonyCaoaZMC3xb/585mH7H8iThhlV5J2BhGYy5p9xTFnEFPArtdb0PI3?=
 =?us-ascii?Q?G1yST6esBBSvYt8OiltlDLSACNJKwVQuFIO4GA2x3Ld2NwZ5rDxlRascUj1I?=
 =?us-ascii?Q?tW6i+YBJAXtAZtYf3PW28qvlfwqdhNr9ATZu9177pekz07C62b9Duoz0myOE?=
 =?us-ascii?Q?DGS47UHXk0slXXKeSKNkO2/IYNJtB1ENroSq9VkrtIw+zVpt+e5GM/LvcUkp?=
 =?us-ascii?Q?L/3sX4je77zAALACgLFROXuCobY8SmE0Vl1hsz5jZ4AY5HXOX1mIBQYtzfLj?=
 =?us-ascii?Q?w59THgIj22S8CQxZPdpI7wCtOiVpgJBqunSvTLCUrpHVWbw/Ww+2CbKvTwUT?=
 =?us-ascii?Q?ynVR4P+RVxpqJN4w+VPFvlEel67a2xh600DD4b78aZq7ehSUxzT8Xx0Q6PVV?=
 =?us-ascii?Q?65MObcrZwW9mpfAkCbBuCpHFGsSy8gUT7MOEZR1pZqndw0aglCGR6DNjZV/6?=
 =?us-ascii?Q?TID2rUzLFrRvXWJW/PB/ryPY/zA/LzBvQC9m1qhbw9MCPA8OpT2qqd/nh3KL?=
 =?us-ascii?Q?UmxqJdXg/2TB2bXmiLW5+/hgEljN6fZ5X0c89Drwmvo3TG8Jag/LZKOfzJsF?=
 =?us-ascii?Q?soN/8U3ileEps3/SSv6h51c9G9U0TmHKyEDiDh3xqb8oyp4xQBa0/MQ1hx1w?=
 =?us-ascii?Q?++N4FGphstu4X7PFnz/O886aps/C8uu2T/XhQjEHS26fR9YB81uYVDvud+qR?=
 =?us-ascii?Q?uVMQuzoyUFXNWY+wj/d/HcL/JKK0OUXLl0FylAInut62d+baG/1iLzT6rrns?=
 =?us-ascii?Q?UkKk8zykkVI4Y1g4ZbrorSU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be69b55-022e-404e-0b48-08de3346753c
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:04:44.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIU8siOArgGSLbuIxceYEMokY/QMlfODoqBn6oNbGUhGzP+NFAhP3VYl/97WQOLGofhAD9QHEE53KcAAFMoEto2B3QMa0dh7q3Sqpq/V/Xa8Fx1/zPkFLNkO+ZSv16T4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5007
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

