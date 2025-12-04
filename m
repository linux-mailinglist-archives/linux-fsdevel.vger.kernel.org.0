Return-Path: <linux-fsdevel+bounces-70670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD59CA3FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 740A3302DF33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F5134A3BC;
	Thu,  4 Dec 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="WX0vUoK8";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ZsCe5Xpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka30.fraunhofer.de (mail-edgeka30.fraunhofer.de [153.96.1.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07D34321D;
	Thu,  4 Dec 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857791; cv=fail; b=UFghvoe/upodv3a982K7TRTwqp5/N2Dny8weU+dNOff7FVtQFC5zQR2DO0W0/R8L2PWOLRE7LwvVHoS42H9WQFTD0XfSDfy+TiXjbLElj6LC5oIK25/ept1BVcePzPcxXgghWmoBSEy5BbLRaIHvoYCXF0bKQYPJPEH4RzURZVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857791; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8EXnCEjW1maqD9uuUh4lax2hPQtQCMZbuC876BMcJ5UNRbpAKpvPT+XA8eZZpO3yEtEj6vHKlXb3xRim6hcRK3O0KMM2DBABQJxER7XKUGroiOf/H48M2kRGNo/8KJMzDwMrlB6MsLI7Iso7JD+XkIvWsspxP25q2AhYWWiJfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=WX0vUoK8; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=ZsCe5Xpk; arc=fail smtp.client-ip=153.96.1.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764857788; x=1796393788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=WX0vUoK8HFGBRfHoXzvnJTn3lAb7Npl91427Z9tnyMTmh2v6WGxlkhXY
   fiSyf1FEt52CXWrgQUylokqd5OXHcXFgHmbo346U+mFS0O8XPzgCW7Jod
   rlgbAq57qj+dvcDewzzi918tPkO8FeZrlbdwWKq5KFFbdn55V+JbSMxuC
   gJ46mnwyp/IqMjx5jY70UxhE74gUs7GNWBoGwR4nFq8+PJijOlp2Ni5n8
   4cNJLpL/sqqVJ7Ptoxo4yEEKWOkXXten4K3Nzs4etMNOlxpVIhZ7SW4OT
   y0ouwR0594c1LoHHXSkAx9y3LvF+6LX5noJc4q7w2I0qvtX7a7YFGOsu5
   Q==;
X-CSE-ConnectionGUID: nVPtR+FgRk25L5HAMruvVw==
X-CSE-MsgGUID: EFhERNdvTOCACoEpLXk9IA==
Authentication-Results: mail-edgeka30.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BAA4Va1o/x0BYJlaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?XEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3nXYBr2s0B4I4gWeBX?=
 =?us-ascii?q?gYMn2caM4NxAZNukwsuh2WQc6kWAgQCBAUCEAiBfoIAMxokgzZSGQ+SIbold?=
 =?us-ascii?q?wI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3A8oOng2okaEvdVSmTc8Cr9p3mUcYbSmHnj1nfGUz?=
 =?us-ascii?q?iVEI0aJSwU0KOxrwxxg=3D=3D?=
X-Talos-MUID: 9a23:aJG9TAthdmC4On26C82nqR9iGf1O77qSL2skupIro+20Nn1REmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="26277307"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeka30.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:15:09 +0100
X-CSE-ConnectionGUID: vJ5egvlqTgyMwVRYeXYSVA==
X-CSE-MsgGUID: we11IKIvS62OBviAaZ0zLw==
IronPort-SDR: 6931976a_pBdQNj1Xwy8TRpAMjCx9gnjYcQXpKXYsrNN7jQ4RZ/J/mQg
 /aF4v583Qv6nCJ9RbjfDrZzEt9s/Bl7tmTaWaJw==
X-IPAS-Result: =?us-ascii?q?A0BBBQChRJ5o/3+zYZlagS6BLoFuUkABgRuBCYghAQGFL?=
 =?us-ascii?q?KVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCQnNwYOAQIBAQIBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBDwtGMSUGD?=
 =?us-ascii?q?gUigmCCJAQSAzICAgKlBAGBQAKMV4EBggwBAQYEBNshGGOBZAkJAYE/g32Bc?=
 =?us-ascii?q?IJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8mjtICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjSwUtHYEnfYQbhCgrT4IidYF3QRk/g1MeBmsPBoEVGR4tAgICBQJDP?=
 =?us-ascii?q?oFdFwYeBiASAgICAgKBA0ADCxgNSBEsNxQbRG4HkzadcgGvazQHgjiBZ4FeB?=
 =?us-ascii?q?gyfZxozg3EBk26TCy6HZZBzqRYCBAIEBQIQAQEGgX4mgVkzGiSDNk8DGQ+SI?=
 =?us-ascii?q?bMgRDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:s0UKBxHVLshCX8vRQF2Zlp1Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuSvee43wrwDzuvF7+jW1BPzbFpAmZGW89
 ZdQVgHOo38sLD4E6WDZqMp7gL0O83fD7xYq8ZX/bdylLPl6RvLvY/wzXHR7W+l2TDZ6PaGjN
 ZIBMrYiFN5/srS6oWMi/DuaWwz0GKD292BMj0P63qNkyrVmNSfX8QMvMvMAkC/3puXIb79MA
 ODu1Kjz5w7ca7RtghLiuLWZaDN+keGMTJ5iLZHN5kghR1KClXeqkp21HROF8ro9lEyA3+tGb
 r2C1UobjiItvmX0z/8tyYv3gN0nk1LN9ztcm6cbesTlFmonNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WkWtLZpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
 Vzng/CQYivKzymrvDjXXoW5GuRK4KE=
IronPort-HdrOrdr: A9a23:CcCrDK+10m7Njf0tQPRuk+AmI+orL9Y04lQ7vn2ZKCYlEfBx9a
 iV9sjzsCWYtN9/Yh0dcLy7V5VoI0m8yXcd2+B4VotKNzOHhILHFu9fxLqn6ybhECW72/JH3a
 xkf4R7AN30SWVghcz57BKZHr8bsb262ZHtrfzfxH8oaxprZaFm5xp4DQjeOlRuQQlNDYc4Ep
 303LsjmxOQPVwNbs+yQl8fX+bCoNXXlJXpJSULDxsigTP+7w+V1A==
X-Talos-CUID: 9a23:5Jcpo23hB+WWE8GLxatUubxfBOJ4f3LDyG7sLF6dFlhTebCleGSu0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3ARv4WOAxEJu2GGnR57140cCevkkOaqLujURkssrQ?=
 =?us-ascii?q?YgJfeEgZuOh6UvmylZpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="46757529"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:15:04 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:14:39 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.7) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:14:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a21J/gAJ9K4SzSh8K9ZSsXRxgQMTbE1xW8W9bs8VO3OJdSDk/rhzqqjkbnexO5yfkb7s6y+uoDH7tqcSD5hDVozoxXssPEgTVnZQXq8FmIH4GXyLvhjGgXDRCq50SEOXNFdIuygSYqIByDZ2+PVex+AkA9sSbclY+9g+zDJYTYtqDyYYr1QskUSnuBYKcfLSDKYITB7SoQM4nFpyejKVmQA5BbLgmHEYxsrYXgORO7ifekBcuA56mHRwoBBOotQ/Dgry25oO535ZC/OdAFwJcBdPqkgeBYvRuhDhizQ4TzJViDdtsxGKRPghroLdl/O/v9ECAaZF8q/oCMYi0inCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=tfKG2U1HJl+CfwEdSgzrkGeTx+6+ISr7PWnPltne5xL6EcsH4rCkJxBqCdLvQQuEBbwVMpmqMx2efJ/ICcpzOOF62r+uAMULB0u1PVeU11nZjM4mDqfC8r5/CiAk3yu3kCVumrrfBz4658aWANJpopw1vytV3zAGNaYSQVUI8ai4sUXHWaSmX5Fz6rl0dUoN03uEU+qtnWxfdzZtl+BHSnasIDxrDHBkyHpBgI+WQ+dYAWp3mp3lZY2awXiEFp45ebs+qZOk7gNa+3tGAkDhy2W4ecjnea2BvhhkE36TFUHZPpMz3iALlc/zwfPh5Tb0YB6WbtabraBN3wsoytKgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ZsCe5XpklP9ZvGAqvRmGOsrSWJw2qfU4KAPOuU/nPD9HL6m0t+qU7laTdkf6q9/LNyEggEIfH3KbXU3p69h3piSBSwl/S3Mw8U9rK7XxhyDz43tGif89/sJRSy8JHxL6XOLsXiNS7E6LTMK4t53aPi+jVn7Z1jajvM3IF7q56L4=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BE1PPFAF969BE78.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::68f) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 14:14:37 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:14:37 +0000
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
	<david@redhat.com>, <debug@rivosinc.com>, <devicetree@vger.kernel.org>,
	<ebiederm@xmission.com>, <evan@rivosinc.com>, <gary@garyguo.net>,
	<hpa@zytor.com>, <jannh@google.com>, <jim.shu@sifive.com>, <kees@kernel.org>,
	<kito.cheng@sifive.com>, <krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH v23 01/28] mm: VM_SHADOW_STACK definition for riscv
Date: Thu,  4 Dec 2025 15:14:12 +0100
Message-ID: <20251204141412.5895-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-1-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-1-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BE1PPFAF969BE78:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf358d9-8cd9-4ca9-b8e3-08de333f74d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wBqHGbAxiXdTinu1IvkzQgHEABqVNY4e5VhLYxPM7zFc3yvyrxvUY26ey+hl?=
 =?us-ascii?Q?IYXQTpcTqsUmPSo0xE5MriXj0sjYRxc2abzOdhUvOgOov46OErpZPjadTGzV?=
 =?us-ascii?Q?5CuitSeYgdsrTEgXQhx0T1m1QveeIE7jzL1LKOvPBy01R+T00yQmvkikMlKs?=
 =?us-ascii?Q?keZ+6uIXN/Tsv0kejbi5QB6cStcxca3obH8WsOZgxG1dP+JYGialrocHtbvG?=
 =?us-ascii?Q?5roQIK+1wJPXaorv962ivmli1MGIpUDljP8R1nEUD5gWJ2hkn3IcS3W6VogG?=
 =?us-ascii?Q?sixdgFKyN9Uu/assdHcyedZhxwBidGlGqfjT0GSmtd26Ryk4eJUmdZ7IpyKb?=
 =?us-ascii?Q?C4dR77Tf33/FXjZpv7Eyts5YyHGKW/XUtt4I/vma8mlSolQUYLKnL4CiDBWB?=
 =?us-ascii?Q?Xxucvx91wNSOUOmu4O8Pg1qHaiLmrdipx38Q3MihNNKAiKI/H+R4q2EfArp8?=
 =?us-ascii?Q?vnRpIyAStrH0lfPF24tMMc8IyL/hoFmyJ+Rlgb+XbKbsZLDGJjXaXFeeVyWl?=
 =?us-ascii?Q?hGfdJmPAfhtjF4GuTiCVxZdJxiBxb6sIvic8RWMkhD3+dN/B4HEvvrccsRkG?=
 =?us-ascii?Q?dAYKMCNWKdCgMvr6CPfOSVbtCOjiEkohfA5sykPxbZWmDOeMPjlIHJK0jcnp?=
 =?us-ascii?Q?zmixDjiKdzpma0fll3t+l4+BGVaxepJKK9Nl+bfBWAU+HmbacMJegRK1zYqI?=
 =?us-ascii?Q?sjoF+yanZUbc67DbeU/YFkod8xYDhy5EvlO8DVu3vZoYTNJucftaeXO4kXuJ?=
 =?us-ascii?Q?tTQrKZx1EX8ZBqT9dDQPWQ/U/wJy6u625TjwmEseQg7+dTMSid5gIg5SIdo4?=
 =?us-ascii?Q?qmlkOzIjGt9ObxYImVJhatlh3NEbYLevscmNKt0spP2X7zjO7r8z9iGslvOv?=
 =?us-ascii?Q?ahpELjvpNoAaLem2d5hXQuAipf65E/6el3+9QFgejigPnMLyfRFn9PJoj+Mu?=
 =?us-ascii?Q?E1vemq7L6H2jx3Wtxtmwp/aIDF7rVPTIEKHOmOhf3wXolpOZNgHoxQOk9Zlz?=
 =?us-ascii?Q?r1SiiX9k1F/D9mTlJ7H6Ta9cg+lD4BkdfHBTmtgH+KGkPji50d/g53Ry5M0z?=
 =?us-ascii?Q?xfoyjDVg+nD5fdNfCvZy+u1Ny7iD47iwyhcUACbRm8Tf9nYlbZhcUdIWhckC?=
 =?us-ascii?Q?bv2Lvve6h5xEezooHk+/zs9YnZugIX4atVFX61ssC/qqXDPmgmNfVfjIZ8+R?=
 =?us-ascii?Q?P1L7ak9QBGvn+xIoyRdp5Vz7maRP4r31vtu8CsvSQ5C+k7iYiIkR9448d9Za?=
 =?us-ascii?Q?j8Lw/B/5XcFc5t9aBa9Y8DKTPWW+fTR56pC1s0PFxmglS3VPhvqI6ikqIRTO?=
 =?us-ascii?Q?mCRy0S/EWxOQMEb+i1A9nbI7cX8spZyjyzHdj2X8xFfai7Ho7LuCtKmhFG7s?=
 =?us-ascii?Q?Cqh41qZJgGo94nYZIxn5nRaKnTaXsOPRfs+LqcDbE47MB372xKuA7Z3LiUdk?=
 =?us-ascii?Q?/AbyfeDpTQfoMmnBe2hIeqn7kfRpk0is?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYCFmRLzy7QGz5PPKZYzAqnCBT+sPBbjZ1WRUNsMOoDs1eBuC9AnTFGVUVyJ?=
 =?us-ascii?Q?xINzDAWzrzIdwgQ371OisruIiMmtFwatTVO47nIU6/wSyIpe/ja/i0cZtjgU?=
 =?us-ascii?Q?KYr4cShYhaWPym8l9qCvpc3s3lrlz3fJXX2XgoDCHKB1PcacZuUZnO/+jyF1?=
 =?us-ascii?Q?ZaSHGFVBasrhqEjtUB3MR4kAc7YcD+pggjZUIhEKDutXps3qTgB0jXEUELi8?=
 =?us-ascii?Q?OKMuAMJ7EEJsn6qCoWaoLHykTiS92luksJSszxTVcs63uR5RhE3hxQvQ4cOa?=
 =?us-ascii?Q?rN9VEt+hDNoOtLRsLg66baeE9xrXYaEG/qw6ig4mHhELMQBbdhV7SAEjTui8?=
 =?us-ascii?Q?xm/c77A+qShbalZcf8S4iBldoFdWhL4SVK55b8BDz7LeTnWQBPwqFWADUul6?=
 =?us-ascii?Q?b/NYCfXALGC62edXgt0pnlIw0ha1YM3o+UA8d7rTrcQaJQRZmUFFTtVhBCDc?=
 =?us-ascii?Q?81xPH7t2f/Byg/eZwNcM7mKy2W6q9/Uzq/GPI60lxr1Q2LaVvhF+c7PpSpIW?=
 =?us-ascii?Q?OACg9NpkbUxvXj9gIKa4zW2ZGjfORPFBTIjZEH7ffeRM/4aBqeDXGechvcCw?=
 =?us-ascii?Q?Z8d7Gul8ApYxy/Z4xa8x6bbFkN6OQtkNBE+TqgaRAkeI0van1SilYJT9AL1V?=
 =?us-ascii?Q?M1eu32Yer0Wv7I6CJMb2gHJ1GT+GssK5cqo78RkKVbd85HDvpUstJz/jOeg1?=
 =?us-ascii?Q?BzTBk+QAniV5XI6+JDG5olo5zACLsOtzZQJP4dAxc3PnBoM8RlYxDbTh5lds?=
 =?us-ascii?Q?Zf6q26i82AKouunWM/OUq0T6BoRhmEYCDnrC2p0SM2H/bc9xBPSibkHvhVjj?=
 =?us-ascii?Q?SP52vl7wNy3RyrAQCMPWXjr4v4H19HNZbk6/bTkHTLA4oFWB0ah8967yl7oz?=
 =?us-ascii?Q?U2B1Ve/NZMGUhehkbAF6eJIVxlFZvMEx5zeWnq4zTw0Yihwj/h4E0gUjZ/+/?=
 =?us-ascii?Q?quC7y6nePiOdX73Id8jANvpFPojn6u/zxjMa5wpJ8Qs+i5GHPBSrpUVhr6fc?=
 =?us-ascii?Q?nceiN/uXFhsITwhx+36vVw7GrOAOeq1tmQuoIk/E8IjSynrXDTfFCX5XFojk?=
 =?us-ascii?Q?HnYgAoh7f3rrz1jgz6CET8fZcaQvSXEvcvFGhLrp3/WN9ElIVrk2ieqcdVlQ?=
 =?us-ascii?Q?9rqNBa7nAFMUz4dMbSrqABouNJD3jl7C49DNgPMDV/pSUFPkKZJNU7UX23Tk?=
 =?us-ascii?Q?wZpTU6afG0DmhqUdp2rFkYmioMlotT8qifPSOEbyf8PReGB5qmK09UVJbqSw?=
 =?us-ascii?Q?fbrw+oTVW4xFCMPW67hP0aP4PKNQULsRAXag3VPmOqsqhcCiT+7YMCcoZ4mh?=
 =?us-ascii?Q?AfftTCZgE90XQWmeX3s0QJNYOUJK/vK9PDk/xuditI6KPfBVq7WBI5SIRvwG?=
 =?us-ascii?Q?ceHI/c9HtEKn+6I3/1aO3K7Z+BC7LxfLJ7Y58CRdUxhiPtorTLI7l+opfhg6?=
 =?us-ascii?Q?AolRd9V/xVohAQOssZhH7g8XzfNxHa+symkfnEFA0aBMzsqoeeFmyo4yDstE?=
 =?us-ascii?Q?OXrgwwKTOv3tMTKmt4fa6u5GFnw0jrp88cU9JAvLKY9oFgWMJKRaRVXd6GFa?=
 =?us-ascii?Q?XiNNj+OQUukuoZNkMurHvONvPn4KxNPAQIE2ZrnOETT+MFD5xBTVjL1JL2l3?=
 =?us-ascii?Q?PgTIBY/gD11OVET6BnYoZbA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf358d9-8cd9-4ca9-b8e3-08de333f74d4
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:14:37.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy5q9gXQwP8FW3GRJuCXGW53vYwx1DPnMRaFwuUuX911FsLMbuNrnrrxsk7409/1aT0R6bJz+kACHL4mwOPpkZAwr+EZ+2cJzCCRkU2vVVqT/uC41/Z6E/uvcZyhm7lL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPFAF969BE78
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

