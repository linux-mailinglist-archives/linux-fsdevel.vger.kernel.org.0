Return-Path: <linux-fsdevel+bounces-70681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81119CA41C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57EAB30F7EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1D26B741;
	Thu,  4 Dec 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="khnPWlZe";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="I3OojC/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeMUC220.fraunhofer.de (mail-edgemuc220.fraunhofer.de [192.102.154.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F9261B9F;
	Thu,  4 Dec 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859723; cv=fail; b=BtwU4kvM2jpBQlD9psxZxS/Amab2VDkUYPe7K+KkQxJq0Bcfyc0D5wm3B+tUkt8FDFHqMErYD03U1ut8D7cT84nOUIJLntiFXmNXbOyvyeSBKfk1gsXrYIE3A5SwVgF/pHF2pDVeZwCDPQDi5SlozNhAJmsKH/gsY0KEcF7doMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859723; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTqfDr3ALr0OtJ2lxeLM3kf3hekR053QUonsOxGLfVvSXJN90qhpVnATycxhBOvz1Pdt3dgXZIPs6TajVH8kazirSKr8VyfMqNPl88RCRa/NcQYClSWGro9tzUAVTcEjxcWYbbKmAJkNp/Wgv7BUPM2pvZVZhAatWH1EIUq5F74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=khnPWlZe; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=I3OojC/E; arc=fail smtp.client-ip=192.102.154.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859720; x=1796395720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=khnPWlZeMKsLsecHRgEyplEKBEbfHun0OZv+4QYfSKvceEaulc1CFR6/
   LgGou3OmJGjXQ2xGp2ADOkNvfMGT/r8lstzYLCLE5rDMnVExE0d65BVk4
   7k2rODvUPEV7Cy3nn6NF5kMXGsZGxB2zwBp55N0VG1mBIqjeV7aItl9MD
   RAY/xC/qyeuOU6AZBolDdjQLNA50TQuO0IOM7OM38kKDE1DoLfARTfIjG
   VVVW+XxWAmagNu5goKbNMQXvH1/JuZkkjH59211WHrgld/r0I4lKLdkQn
   Ov3VENBWJF8DNi1cAOUrWEDhsTDxl0ne6Do9VvV2h0WhJ22TT+Zpxs5Xj
   Q==;
X-CSE-ConnectionGUID: /ye1ssnAQTKThJd5s2+Z/Q==
X-CSE-MsgGUID: sFjRJN3EROin5tU0UWcx8Q==
Authentication-Results: mail-edgeMUC220.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EqBACbnTFp/xwBYJlaHgEBCxIMggULgkBAAYIvszuBK?=
 =?us-ascii?q?4ElA1cPAQEBAQEBAQEBCAFRBAEBAwSFAAKMaCc2Bw4BAQEBAwEBAQEBAgUBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAjVWBjIBDQEBNwEPC0YxJQYOBYMCgiUEEgM2tESBAYIMAQEG2ywYY4FkC?=
 =?us-ascii?q?QkBgUGDfIFygmUBhH1xhHg2gVVEgUqCdT6EWDiFd4M0mVlICngcA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBIEMDNQwLKhUjSwUtHYEjIR0XE2A9F0CDSRgGZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAwsYDUgRLDcUG?=
 =?us-ascii?q?0RuB5QdT5x6Aa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLmQapFQIEAgQFAhAIg?=
 =?us-ascii?q?W8LggQzGiSDNlIZD44hhAC8XncCOgIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 QaJHjAm7HCdHLvUBwiE70l66XnIFviW
X-Talos-CUID: 9a23:pMSLt26kVJVvleBT+Nsss18ZQ9s+dFTk8FTsI220VH0zC4/ScArF
X-Talos-MUID: =?us-ascii?q?9a23=3AvKn8Mgx3x2z/lLKxSEja61zYEpqaqL+ACnovt84?=
 =?us-ascii?q?rge6FM3FsBm+gsz+nErZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="14644261"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeMUC220.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:48:35 +0100
X-CSE-ConnectionGUID: Bfl1BZQ8SmGH1fWoe6l/Eg==
X-CSE-MsgGUID: oG/kdnjsR9aZ9uZ+4exbbg==
IronPort-SDR: 69319f3f_eaME3ukbvM4NahZFvmZ2JwmgXTRaaCFnOdPfhC3SQmxyj6y
 T0C1es4OsF1fFG4vVDIr0p7GwbG5uXiqXJaP+6g==
X-IPAS-Result: =?us-ascii?q?A0CDBQCbnTFp/3+zYZlagS6BK4FuUkABgSYuW4ghAQGFL?=
 =?us-ascii?q?KVrgSuBJQNXDwEDAQEBAQEIAVEEAQGFBwKMZyc2Bw4BAgEBAgEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBNwEPC0YxJ?=
 =?us-ascii?q?QYOBSKCYIIlBBIDNgICAqYkAYFAAoxXgQGCDAEBBgQE2yQYY4FkCQkBgUGDf?=
 =?us-ascii?q?IFygmUBhH1xhHg2gVVEgUqCdT6FEIV3gzSZWUgKeBwDWSwBVRMNCgsHBYEgQ?=
 =?us-ascii?q?wM1DAsqFSNLBS0dgSMhHRcTYD0XQINJGAZnDwaBERlJAgICBQJAOoFmBhwGH?=
 =?us-ascii?q?BICAwECAjpVDIF3AgIEghV9ggoPiAKBCAUueycDCxgNSBEsNxQbRG4HlB1Pn?=
 =?us-ascii?q?HoBr2s0B4I4gWeBXgYMn2caM4NxAZNukwuZBqkVAgQCBAUCEAEBBoFvCyqBW?=
 =?us-ascii?q?TMaJIM2TwMZD5IhvF5EMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:kvIgChbyABcHzmLxxpZ3q73/LTFg0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETAerLrszbRv+Zm3guGEvTHYOsUSwnz8
 b1bcwH2rgxfHCU5zXjWhO52h65E9UHExVR1lq+PR4aXH71TR5HBJN0YdzNnfuJoSC9GHazkS
 aIdJNQTI7ZcnYzyi0IVtEW+PiOvBezR5iJRi3Kq8Klqick9HhqcnwAuBNQojCWJgOvsK/8xa
 9mo1ozQ6hfGb90LxynizrfUfB4Dke/XXqBVV9eJl1k+FVic3k/PoLb4eGy56rgonTid7rsjb
 Nmji2oe9iZrhhOx7NVwlbiYjaI01XnAxRV9xakZGu+UcX4lWIv3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOUKHSslTtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bsuncqkoUb5hdBSsuGJGmXdjVwjpDfPWimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLG7SdS9qBbnmaKdjrNhXotKMDOWw1dAT7sSl7cKvQeQfhEWn9Q1vc
 gPE5SWYOeAdWSSovyKhzVQeOxQouVvnprY4dv2/jNGVgFmApsQiTuRRzzrZ3FedU1jP94UBZ
 Cc7s1Iq36JfmkWVN2yAj0gU/LYr9PGuZr6aVpebiRXnzWmvHeN0vrXAhKY1hARX3dmxqojy3
 HMl0jc6r+4u/+25xfA3yv47ohQmvHm1txfbfb8/vQ9G3HJsEKFdY5hU7qNsHQcp/yu0k8jlJ
 32rxIpL61ImgPsljXem3rQ8jil9Axrx27pyFeej3emi9f+XigGB81Igp8cWgfF6mI71esMnZ
 5j7ia8jd56HBnAlCPy65zjTBdxjHe5pnIkjKo6k2Ffa40Dc7VcxLZvsH+9KK1wUx4S1bpXW9
 WGTfusrMq+SGnqJkwxa1MfiuBFXRwIb2a7qwY5y4KoOgNt7Q5EJnsjtbMid0g7he4Aorl/lp
 f52/dT5cNzp4ktHNRALdZEfMy2BwX2MGvxDF4=
X-Talos-CUID: =?us-ascii?q?9a23=3AoeqwNmpUl3V9aY7WR6n7XCXmUeordiT3/k6AGEq?=
 =?us-ascii?q?XKT9nd7qYF1vX1awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Az21jgQ4EDJS3wfWQVgC+bF7ixoxvzOOtBEYPiq9?=
 =?us-ascii?q?XsvvVKB4zZzqNhj64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="46838181"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:48:30 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:48:28 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.4) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:48:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ8ICuF+cYAdmLUWFQr0tPDmO9NSpRSuJPvDTkDIACNguOJ+AP/vVcB1BwM7p6srMNXHywdoVyNlHVBvZ574/Xn9VaVFAm2d5dBHk1n76LLop7JQKwGmd9eEGxDvhN5vf0vgcsu0nsZb7LT+ul4Zb593KEV0kOGfS6D5LFZi62nF1TSkE/0aRIi5qGio5YJvwhKagZE3dEl+GU66NApAXOTCbpaZ8rmw+VBcvofuawBcKCW8qYyK+NuIbq8JhHrtWKLhNPBABuTc2OMW0IFk3ua3hoAfRTCkZnorfXq9agVBf+Pnw/72xqsH8/33NUBpXcjmnpdLBh4bm3IFQJcgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=t6uaxTsZJwmN2UnjU4tHgT87RVDkaZOP/EVK80V3gJJu3VDKNzjpu4ML8AQ86GSdnpOzmm+B1bfFQ0f+pD6yj5oLssKyVPLvMBP1A4pe573ce+GG5YMg0ynIurutnugwT9HpSh3tj79SZIqyyrTgVsmIZ3nXaA5rRiEPnBPK6/FhYhGZpp62EfMBtQIJFFb2Xu/bw97QgKIJxdNCh8r2Sk7XRWjB+FD+fuchZhxyBs8WkO5R6RE/Iag8Fh78grKeKv3g5lWhwCiL6PyP0Cvcfo7LmnjlUix7PsrK8xeQNSOG/je+sPDua+HtwlklKitP0Q9VpJvSq1Zqk8cIY+DsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=I3OojC/EQZt1fjZ1NHLQwkowG0NAzCVzv8lZmgDqsq6hSBkigVDuqee4El82Etgs2+dfsnNT95DVqw0KRQurMpOJmhF5vvwNWtffJXv3kzMNu06xyj318r7aRu/7DT4MF8ni9+QSdhlQ5OrLCvBz4wY9cHIwAlXXlmGDWZDQX6Q=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BE0P281MB0177.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Thu, 4 Dec 2025 14:48:27 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:48:27 +0000
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
Subject: Re: [PATCH v23 13/28] prctl: arch-agnostic prctl for indirect branch tracking
Date: Thu,  4 Dec 2025 15:48:20 +0100
Message-ID: <20251204144820.11718-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-13-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-13-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BE0P281MB0177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebd5421-68cf-48d5-daf8-08de33442edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eWnJdh4J1NNxnpOHminKlSZvZL8smMVDkc4FGi4d3thofF7JY2RB0iov2xrO?=
 =?us-ascii?Q?fyr82qU7yDbGpqwFasSxeDEd4YEMjPUAycjxzUQccdoeHAORAywaF8ojIdyo?=
 =?us-ascii?Q?shSqw9e1mE7TswIr7oJGVkUU9CWX2hEJwYXHiO9J+gGjhiF0DLIiHLbj0I4W?=
 =?us-ascii?Q?7JNYKNJ9lKFxwA1chjzrx80uAWd6NANq8j/6uJPbQfaf9Qy48ovfcR+gVGhE?=
 =?us-ascii?Q?tckcUr1ghNI1WvSch9qNFWFJm6UkN3t9NEvNtsQ5/HTB7ckGLMLpePZSairm?=
 =?us-ascii?Q?bgk2sIVTZAFq+EhxcXd1FbFD+5MO9NFv3VcNrkVc3ob1hVqirw/ZZ6yDRNVn?=
 =?us-ascii?Q?WbJmwK/581hgtKFDW8sAWI/FoMaek+ccYR4ecYwNl323jodQINqGStWKFGUi?=
 =?us-ascii?Q?2BVpjV015Pe3Ao3xhyKxMmd8H2tsPdyF+OHX0Y4x8jOfD6nmEbSVV1wee9XF?=
 =?us-ascii?Q?y5lHorKWfIAL8kaD4pT1PB8D15Nj6TLXtutM14MkWxGtnsEVCl2DXf3/zvOP?=
 =?us-ascii?Q?e5/zOuSCJmJP4SjLapbggYMQXAKpGozs2vyZTxwIOgu/MVtPEQZnTCBSIsI5?=
 =?us-ascii?Q?YdS/0FOiM37kfSOpVT5DCNiC30VXhe6uosyAo5p0KMfyHKT45Keyohpb4N9T?=
 =?us-ascii?Q?CyLxO+EraEfUaRyFlcSVBFeMddWegph8pm3F92p9lnKwvtXzw6MnKrZzJZKu?=
 =?us-ascii?Q?oN8x9zFbVtqsuMKcIMU92P08Mt3q4hYuDS6ZJh2mUr/00u5/IznJizcwdMUa?=
 =?us-ascii?Q?8xDXxda8QuYskWNEaENBc2lzo52LY3INiiIEVGKgCaTr8lOFo5//Bm/wuv2g?=
 =?us-ascii?Q?qAmOey/S6yKGAqEzcwkYllpU/vCUNFCb8lUQRt0axpt2Yz5nuqeuOz09sffD?=
 =?us-ascii?Q?OVCvO7QX5mDRdqUPb38YHGx4+jiu5HNLK3zYCYm3Mu6qWqf0VZOa1nYEDw4M?=
 =?us-ascii?Q?IgkbsKYqMKeofsEFop8LMuqnl45U5FUy5LajOLB9cbuzB9INImlHxYFZU7+T?=
 =?us-ascii?Q?B5N4CFaQuIUyHZrZA8XiCYBoJD/MS3PdY7cNpf05Uk6y/pL7qgl/StPhPptc?=
 =?us-ascii?Q?86xtf6GyLNQ+zW+5GY3QX9yfPYLTvE82DzkbkHwEVpGBl2FO2FPkYpIAS48a?=
 =?us-ascii?Q?TV2d1WuTPdBF0rUMWckyBuTpyO12LaozcH7SIZLlIkrlM9IsN7Bn7Ns+satb?=
 =?us-ascii?Q?5m8a/5CzxmLQMIL+lEDGBy9ofAXtQvPoa0i9iu3WSOXmxXdWVvHS1JAgHiaD?=
 =?us-ascii?Q?rzGxrfxNk4FRKcUZHM4rxhF2nGOqjqa7fM+U5X64iet43BVJjIFaolmC2fNc?=
 =?us-ascii?Q?+oCst7fkfXzG5wCSBqlbMy0iGSdjM2gVGM0X8IoX5yP+UlErPBki7O95JPuL?=
 =?us-ascii?Q?TnloHfKxs1urxElQ6OngKYN2mLPVYiwkxeds4VcbenAbMmQ4BxXZhM7vKRDf?=
 =?us-ascii?Q?TAPoYwj4mUHJJXTDDPwqK3U1cGhyxZYe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtJvrUXXyMH77MwIZqRUCizZRF2U/6/r+eJq9/hkRlwDPTRHrAaIL6vIt8lJ?=
 =?us-ascii?Q?enKtt6BWMKp64AONTF5TuQ9wZWG56BxKkyd7ti8EoXt/5cIfbXwBLS0EVigj?=
 =?us-ascii?Q?nCbEMxkQhbpyLeHtCmTH6l/om79u6px1q0yOa8WbDoLwp2J+U4Kx/rj9iX0n?=
 =?us-ascii?Q?xA7u30IHw3VJHJxnklCPp+WRFSxmuhBO5py1Y6qIkTQMWm7xj1nRNBv4iaWI?=
 =?us-ascii?Q?N73HkT4Qg1H9M1xam9SP5V1vUOVtVR79LkZrzaWOr4qcayTapMIdxsPxaePd?=
 =?us-ascii?Q?53WCdlD9mId9vXOLpFyrWhhvO1fY9ai1ofBgtenGE6kWTIHs65kNW9DprVH6?=
 =?us-ascii?Q?G7CDMe1hnrNgLUlxafzCwLtYS0ydQC5QjXtWDhRLsocEFjYsWietB46A/g4k?=
 =?us-ascii?Q?S5qDsD0VMCjg+WcpgM31x2E1FY8d/1O2qpmwnF7n5ng/KKJgmAh8MMvbdeaO?=
 =?us-ascii?Q?EYpZt3cZF7xkxbh5dsN2R3OX9lostSngd2LgEH2wFRtvvfrFLAalRH4c+jXn?=
 =?us-ascii?Q?8WYfayg5QZl8WVNQIADkKRe3ezviK6ll9DfOox3DgQVxeUVx/LH9RL5XLlWP?=
 =?us-ascii?Q?N8P/IcC+jBwbO2w3u8IS+wtVoOO9TLCKnioF7yh8vvndoJkt4Qltwb+PBPfa?=
 =?us-ascii?Q?uPhnbH7DaH64hS/VXceFCZssszMmxDFNH6kG8LM4epb7xVkrmL2kNHh/GmYE?=
 =?us-ascii?Q?bO9uj1s8Ge3Z1wh1R0j1/Zzsg2Fzg38IlTQ55peoJtZE1WfAGILhqFxbjsaa?=
 =?us-ascii?Q?6qY1qsogRZUgBPaaRDOZOyZ9szYFCcAd0jcgE23uoSmJsHRxnMk/YoUzoBJD?=
 =?us-ascii?Q?AZSxVxH0D3YJLQEcwcMqTsSfj37cqHW+2SE+D5UXDCqSLwQ2dd9LOgTPuZrq?=
 =?us-ascii?Q?UTnd9ZIO3bzgDqJftrtxnTCgVAJKZYaK53FIE4C47lC+bKLYxfP5+zb2bI1R?=
 =?us-ascii?Q?2LhCH+PKEBBKpeP1q3s6GKqnJrOJ8dtKDFD7LOOGPY8OBtd2Cg1nh6p/gPnC?=
 =?us-ascii?Q?OI7g9Wdu3PBL+1QSx05iE75TrTiuAXVp6gNWR/eZN2FCgwWjpqPWh56aAAIZ?=
 =?us-ascii?Q?yDIepD4vSd/6zJlknmYqLeokKHLs+0YhGRYp6MI+8Fme5txZdp2RBGdAK2C/?=
 =?us-ascii?Q?qJDUuDo5Un8V/mtlN1JLRQp1PJbzQaXZ14nbt7gGEWUVjGgWjT5fq1RP9koX?=
 =?us-ascii?Q?CMXDsBZ3wmVZY0ycRqZvZNo/8KzUbylbYAxGdXqLdm/I5xQDVWd4N7Jvi3eC?=
 =?us-ascii?Q?by96t52B3tBp7GYCviPa+7CsL+i88le1e80Y2t9jo6ZgPNq4LL8+k4PIIH7t?=
 =?us-ascii?Q?/SQtzUBptQEbipOlZI4PlDyR4Ov7//NzD88mcrZQ9NxiUTp9x39v60sTVsrZ?=
 =?us-ascii?Q?HQhtzQR0QEwm3R2jLG8pWXRybH4emCCuCRBg8I44kfaZaJzQGUMHfIWE9vZt?=
 =?us-ascii?Q?I6BK2TB97Va8XTMLWcCEyW5B8EYzmmS9/HbFEafOX6Li+jQ5kkZd+lKiimcr?=
 =?us-ascii?Q?n7m3uHocR9DMnN16B0V6qYXwx1e+P4bujSdjgDO6giavFgwJe8nCVwOAjTX9?=
 =?us-ascii?Q?3tEhqoWY0767JZW+UpdaLCx/cfs048cs2DPL0cTAnydcXjVO0jA59MyD78Z2?=
 =?us-ascii?Q?MMGkiSZEIm3U6bYF5HZS+Og=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebd5421-68cf-48d5-daf8-08de33442edc
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:48:27.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVUvFQwCXaLZMXP+ErYLtAogA7sffZOpqAh28YqIvTY5L+Qeom6LZxlygtjitk7cRwDtAPr+EB9fapmgesAs5dJTalhgGBgV3UaRk9SgZTX2DYQtl8UBpmWP5VW8eODZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0177
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

