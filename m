Return-Path: <linux-fsdevel+bounces-70675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C8CA4135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DABF30819D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7533451DF;
	Thu,  4 Dec 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="cMiO0EQy";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="FJaiQhJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeMUC221.fraunhofer.de (mail-edgemuc221.fraunhofer.de [192.102.154.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C72E7F00;
	Thu,  4 Dec 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859351; cv=fail; b=abi2xEDMIjNgzZaDYZqrnQzWqk3IQp91My8GfvpmHT2ynssNvGo6DjQuYx1rJHEgwZTWjqz3gsPlabt/s0k2FFoPEojKIwo0Lf22DdIF0HBqFNHBLr0u8PP6IxU0GvtLc/AYtUgkxrhKvoikyb0wg5yTp8iUFfwaUCrUklqFugU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859351; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qABDs6rKL9iJPlHhR4P3IlE23KTz181b2LvzMn46CYDHJe9fpoGr6eHL40qtCzTSPMe+Gi/pG0nxiz/yILfRY7MC6Y9GMg4oVWn71XQ/hjM5JPtLlOpZpaUi3qrjaY+fDp3ex4VcgWFkht/51VV50wKESiqBhUyc62Sh6xs5t5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=cMiO0EQy; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=FJaiQhJD; arc=fail smtp.client-ip=192.102.154.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859348; x=1796395348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=cMiO0EQyYizm9GQmgdsDGv6NwTBHP5ZeiTUGNp2OBhOcHNQ2egcaAZ60
   YZhAnlgMCAwwDaEFrkqV7M9uyHIQZEScocwoRqxCIC0kikgoTo2R+M5DE
   tyojqMX7kw7bw+F/Kco2s7+cv75IjsVOpoywWlda6kHr+2T4CDRryVm6b
   QAggyNTtXAuTCEAB1Kx6fixtApnqbXet0IhUjXeB1whkPAfP13XOhgy0a
   J/lLuUexX1P1i6CH4uRNbm+IocQ3lXeFCNJ9rdnFsQ6NIKBJdR2QxoSpq
   UhIjeNEvmSMxQ2+oPDlBe/UQwoykiAusrTouAnnTXQ2ceebFp8JCAWNDs
   w==;
X-CSE-ConnectionGUID: rhBx4bCTS0CsWWvyBy+0ww==
X-CSE-MsgGUID: kmb5G2BFSwqTPOpqxpo+xQ==
Authentication-Results: mail-edgeMUC221.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2E8EACWRZ5o/3KjZsBaHAEBATwBAQQEAQECAQEHAQGBa?=
 =?us-ascii?q?AKCPkABgiSzOIJQA1cPAQEBAQEBAQEBCAEUEyoEAQEDBIUAAowlJzcGDgEBA?=
 =?us-ascii?q?QEDAQEBAQECBQEBAQEBAQEBAQEBCwEBBgECAQEBBAgBAoEdhglGDYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CNVYGMgENAQE3AQ8LRjElBg4FgwKCJAQSAzKzJYEBg?=
 =?us-ascii?q?gwBAQbbKRhjgWQJCQGBPwGDfIFwgmQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8m?=
 =?us-ascii?q?jtICngcA1ksAVUTDQoLBwWBIEMDNQwLLhUjSwUtHYEnfYQbhCgrT4IidYF3Q?=
 =?us-ascii?q?Rk/g1MeBmsPBoEVGR4tAgICBQJDPoFdFwYeBiASAgICAgKBA0ADCxgNSBEsN?=
 =?us-ascii?q?xQbRG4HkzaEHplUAa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLLpFShwapFgIEA?=
 =?us-ascii?q?gQFAhAIgX5mgRozGiSCS2tSGQ+SIbMhdwI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 B2JHiF6oXCecYc=
X-Talos-CUID: 9a23:vCuiOGFwlnPAbDicqmJ99GQERsoOTkaF52zvHFGpI3cqEKKKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AZPIg6A8KPi9CEvZ7XFqw2RiQf8Rt6fmBUmojqoo?=
 =?us-ascii?q?fh/GjLTVgIzDenA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="14696750"
Received: from mail-mtabi114.fraunhofer.de ([192.102.163.114])
  by mail-edgeMUC221.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:41:11 +0100
X-CSE-ConnectionGUID: BxfhdMtyT9uHrwlPrBp81A==
X-CSE-MsgGUID: z/Upmx2/T8Cd0RCP38knMQ==
IronPort-SDR: 69319d86_ylNMWcl3QOmVyb/O6GJpXJCqzZo4X6JmYE+hNik3XZUIybu
 5nZTv5JC2z3gvbTRRsvIbawm1lIzvJz4NvGjBcA==
X-IPAS-Result: =?us-ascii?q?A0BBBQBMVK1o/3+zYZlagS6BLoFuUkABgRyBCYghAQGFL?=
 =?us-ascii?q?KVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCYnNwYOAQIBAQIBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBDwtGMSUGD?=
 =?us-ascii?q?gUigmCCJQQSAzUCAgKtNgGBQAKMV4EBggwBAQYEBNshGGOBZAkJAYE/g3yBc?=
 =?us-ascii?q?IJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?XEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3hCKZVAGvazQHgjiBZ?=
 =?us-ascii?q?4FeBgyfZxozg3EBk26TCy6RUocGqRYCBAIEBQIQAQEGgX4mP4EaMxokgktrT?=
 =?us-ascii?q?wMZD5IhujFEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:3KWIXhzBG3mGIGvXCzKPy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9yJy3f7QzRV5vqtAnmmdNM9XK6L/CnU6oEYiq8y
 YwzYwTotT4GORw/+23I358V7upR9TyDrh1Gw6z4TL+ZP9FTd67kJPw5dXsZDvgJfQVbDbuRN
 4IyJeM+Av8Hpajeg31fpkbkHwCWAer+1RULvjzQ2vI09dscKjzi7g87To8Kk0v1/dDkPbgIC
 rG656uZlCjnSf1S+xLt97nLVEgDivimW4hMV5DawmsPCAfn31Wwr4f3Hj+k8e4pkjOhweZFT
 rquonYL+z9jqzH23/Z3042Kq6lN+3aVyz9V49wlBIjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu7T+GMqDBfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
 OohsEN5YcklYQl5TA==
IronPort-HdrOrdr: A9a23:86HGwqsPjKNUoApXFF72tN9d7skDiNV00zEX/kB9WHVpm62j5q
 OTdJZy73XJYVMqNU3I9urtBEDtexzhHPxOgLX5VI3KNGLbUQCTTL2Kg7GN/xTQXwXk9uVUkY
 p9aKB0DdHdCVB7iILG+wGzEdo64NTvytHNuc7ui193TQpjL4d67wl4DQ6HEkp5ACFeHJ84Hp
 KA5sxBzgDQHEg/X4CSHXkPV6zkvN3ElJXvfB4ACVod5AGKiVqTmdzHLyQ=
X-Talos-CUID: 9a23:+Que/2A3o/rx3BD6EzNeznwtO5g1TnzU9WrBenTmBnhQEKLAHA==
X-Talos-MUID: 9a23:nJJTPAtdy74t/V5lAM2nlm9oFOVOxfqSUx4hkcUttdeiEX1CAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="29867851"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI114.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:41:10 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:41:10 +0100
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.3) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:41:10 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geQgxduEiMJy3W6WZVaTDtfpCSPHl206gaGZVCnRsKgv2OVSipu/E8YUBHV5m9aHwpBJUnVBRJWquk4uR7yb7qKEFsntz3zMsdr6DNuR7Y6Ls7Llf+H8eyiURBuxxScLxLY5D/sxcENJeqTHuD0UjU5Xr8DHbrpzx9u7LklqJ1aEshid9JMDKrZQlRlT+mwkuLTxuAum/07oKji24Q+HI8s41+k1LbPB3m21EJ68TqGeYC/NlQm+cJxF/gDekcAPIU5eksCAflRoC+uVCSkwcmlFfKgB52NDJXpLlTVGN9Dy7WIMt5cem+4LGkZjQM8Souyul7anmHCWEmUVP0kfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=FQy4KWai6IYUr+to8qAr9zNugvBZ/CbZ/ej5vkzl31kNxs9Pwgj9wBMIslJNNWk4a2wxTjR7Bx7KunPz4ScK5ZDNuB8nXy8V5EcqZFIkx0HbNsdeaABu0TTOpRD5yGQ1y7IyEdFftP+F6ESsmIiP/JoHu6FJC5LOxfo0y1dK/T6ASaE4M8dL2AhtrKZjfr4e4SmGfnfTqG7VSiC1xLJy78scwY4sPEYBM4rfTd5JLtSMrSPTcVXtxohPx+fjVgrlEvnFm9UpBaLrhU5ubVgjsVsfZduv2hyZBySmhPOnaUwlnPTR1HKo76a7w+DoY3JCDQTfdV0H0c04KlkCm+Hfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=FJaiQhJDDVdcCEaeQ1GKXy08V0BArgPE0aUBaWWq7bIKLN9c52raRmaywB+P+No7fNWUSULZks95lKWI9myawr39gCj91uLNflJMxwYkN0JCaBnRTN2ccJHwlJ9hHnczIdYObLI3RFdMs0iApD8Vzaa1qY31l+EC0YN9VrDK2xI=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR0P281MB2367.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 14:41:09 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:41:09 +0000
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
Subject: Re: [PATCH v23 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
Date: Thu,  4 Dec 2025 15:41:00 +0100
Message-ID: <20251204144100.9779-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR0P281MB2367:EE_
X-MS-Office365-Filtering-Correlation-Id: a3806dc3-7a34-428f-f780-08de334329ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7ZnkeH7xu4FVNonA2m6IVPZWAxU54GLZ1Tb19Ghg5lFrSEP2RDKCsiIrGLm?=
 =?us-ascii?Q?0MTyzkjEoN5MMwfs0DcC32S/24qr04+kl+aAoqIgq1Vx4rBUjkwPlBe4dTyi?=
 =?us-ascii?Q?Ka8zKBrJzZRjZfP2NuwzIc9smIEEK4pO9xcCjWsa2bCg69O1189HJBcCHO+V?=
 =?us-ascii?Q?s5A7xUYKRmt6ojaPQrn+38M/DG4rZSvZFsHPKrrLJvnhXMDBmYpA/IOl6SvA?=
 =?us-ascii?Q?/4vJlGoVoKGV9SYTOkQZkStqabDqPOHigUv0kmZQExnFv+pqcZkb09HJH34h?=
 =?us-ascii?Q?RE6inql1jqwFw55l/gPiVYwF8pPUfkGQVM3NliFpML7aI3ck8IQbO4RyK0Wv?=
 =?us-ascii?Q?IDSdlkrtV4okK6mBRf6vK4cnAKUAK9zrepea/UwtIPdSTfpQKit6ZLBSJdSg?=
 =?us-ascii?Q?gn1Sqr/MHZXTefxcpUiengzcMgUF4XeHgouluxJxMaxhwtmYVgHZjcnVNXJp?=
 =?us-ascii?Q?ol+8zz/WZC9S4O3SO7K8tgHRiO8lIjSYj3FwE0ykrMarN0OLAK95ymWC4N0V?=
 =?us-ascii?Q?UyimwV4pphx0XO2B4wrocpQ/Wy/CU3dBtC4BPgZLCqjxJPqDJV8dgjDU80wN?=
 =?us-ascii?Q?703q/K2oX5umxcR50TvQ5vZfTP2ULMXFH3II6Q21j+xgm4SRYyjZK57YLeCT?=
 =?us-ascii?Q?ql4yipC/X7s0rWnYhSlm5OtXtCFLTlTDev/dPwckffslOUk7d0BYigNNoNu3?=
 =?us-ascii?Q?ookbVihV9pPypTs1Yi5ZkSdzHU09c28l7oaBcBnFy6L03asHWkBtKkjGnzxl?=
 =?us-ascii?Q?QGyeBX/VfFmKA9s/wCm2D4UlZawtOJ+4P38O/V08zazsjOvqnGqzm4lN4V2V?=
 =?us-ascii?Q?WcwlI/d6ynRv3xK09Rx0QWKeG19MYR12cd1TznDbH2BiQr9zlrO3S1bdTTUi?=
 =?us-ascii?Q?L2Ls3jjKtCj8yt6U+iWR+A/daMf9y+8f/cBsQbQPJ7DJbbvXylxzI+qFiY5v?=
 =?us-ascii?Q?Iw0cglMJOP2+KtiTek1dSPJkBRhXTmYxZLoJydlTLMjDTqD8N3hMa0NZCRbT?=
 =?us-ascii?Q?/5puEQq2QJZ/ThOf2Kcy/qD3+O1ENLzY2XFO5FFPPXmlgkc5dbS/Y7tXvmAX?=
 =?us-ascii?Q?n1NEBlRbPdQMk7p8dXRSMe9swsU3wg5/UxWo5vQkKUtgdM6QGQE7A+7I2Mom?=
 =?us-ascii?Q?F0ZhdZ66RBEuHSE1NAxZi9SlEEzPbAFR16XBolK5ZThBgwewYDKtMu3wx9YG?=
 =?us-ascii?Q?klNGbXhiVgitvCii/mkTbjg1bde3oYbWVTw57irRv0rx042xsNYErefrKTBN?=
 =?us-ascii?Q?ebbQh/3VIvz/3AcHWRB2ytV+j8YxABpAXNuJYYGHYvjK1WnwQI1nUNQgVm2o?=
 =?us-ascii?Q?oiIOuI2A76+p04rYpiSIKD/g7YHu63/uy5+HvzKvEUPKTlTtLVvmSXfQux6J?=
 =?us-ascii?Q?h+sv3YGJY+VI3G51RI9oIvMvaaNJqNXfqqk+yDC8RZfRwAOKV7RzchCwEnmV?=
 =?us-ascii?Q?eBwtvV8Q3zzxXV7lMEksbsO9umRoQeVv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vby15zmuOqf5gAy+Ch77ZKrjjLeLSKJ+zFLjUo7qdw0z5+qQ1OS1OnTUAqlB?=
 =?us-ascii?Q?if2ERpKxLmcrAvojadn+OLZH5J/GXhBRBYdi90zJ0zRWM4hw0RGin2TURaSN?=
 =?us-ascii?Q?Emuh7SnYmxvlXxkdiMT5yZ4PWPzROzYlhXsKJZaTDxxLuRbgYTex/2zbMfiX?=
 =?us-ascii?Q?2FKTuthV36P3veMvGPtZK3yaciCVp8q8bdA6FWCCeNW8Y6t2jpSODkKQ4gKR?=
 =?us-ascii?Q?u/lhvnNiLT1IEyjmPPL+84acrBMyl4qUS2bLvJCtOZkapgNwnWh46gEowB3s?=
 =?us-ascii?Q?xjbPpEEtxDpFnqhaz5rxONGsOyq0k78gQYIXqejltk9R1mS1LYgU+tvNUOC0?=
 =?us-ascii?Q?3OD3Vf1oXejNwORM03LzltxKGlbjwSEGfYMA61RwVpcNerbEmPLFHFeQxa+i?=
 =?us-ascii?Q?E0p6VFN6TCfLG5bhdN7/7WR54+ANA+hFJ74PJAJWJjGvOtE7KEUaFz9KjdM2?=
 =?us-ascii?Q?og/pCyr9ypSkbX22n01VHWS9ShAxbGlhBhzcdY8V5rd6ZqFOP6Ktn9LOoMms?=
 =?us-ascii?Q?x3duF+SxQiF49gOMHkki1PrqO+MS6nNGcIJIB5sRhJpYJVaDRqFNl5Mk+J9c?=
 =?us-ascii?Q?ysXkA0oZjbDxw4KQD85FHOFtaDlz1yEOKC69GcBzvypFHrKDsjvHBg6WN8UL?=
 =?us-ascii?Q?6ndHvJYD6gg6rM5EcerqZqBWvoT19CgYF88Ld31AMc3V9uN5JJA17i55res8?=
 =?us-ascii?Q?aoyuw9nb+vSqLP07jQ28hSpecWugxvdhrb7W4gzgRLQz+EjTkIdGngtjO0+y?=
 =?us-ascii?Q?K55X8URFi5ybKhd196ZNdroAUruityl8a6KlPpxOf59M1qass08EdGHXxt+f?=
 =?us-ascii?Q?xh/gcolSXZa3M5/23LyhJMkjRHRSmCqm2xCsL0IybEwuCUM40EMjzEPEPkLu?=
 =?us-ascii?Q?/MFj+hprwHitL6qGIs269gPyXi8ytURhE4SHmv9E8AZ8/LSTlJVdivReeixN?=
 =?us-ascii?Q?T9AjJIL7dQzTD/YhQPGcUU8MV7PZjjteo/kQRF+Ne/kekxrca5SP/wRG8BRL?=
 =?us-ascii?Q?wPS7lFf4HAO6Pk8eNEJCtmGKbFGiv+mtUG7hWaZgPiCYDZ7K1lQhQh0KaBP4?=
 =?us-ascii?Q?uyKxRgUn7YG7FvI2vmLTyIPDe8+P+Z0kxWILWNPzpPHhM1tubT8WeKyWOJQJ?=
 =?us-ascii?Q?iBgW1fraO821H6Ce/nGifosJ+MARYBhTJ6l0QAx8km6Ne9O29L/BBakteWsQ?=
 =?us-ascii?Q?QOZS6emOrJ1dPV6Hx/cu5ILjjv9WMAUlHrkjTdDrmLfnKJ80fWGFVcxwW7T+?=
 =?us-ascii?Q?OzRtJd2rqM6GGdkJdpVv25XiZePo30XQ0lupnIV5Z6htgjlyP9WCbMc9qhEl?=
 =?us-ascii?Q?gGZeBe7w3bYxa0exNMx/+xZX5hrbCR9nT2hzmfZFGPWF50JeI42kII+lDhwN?=
 =?us-ascii?Q?PVk7sPyo/IbHODhj6SbCfuNUMNiyaql5om/CNhY55nXUVJGzfj28OBMsNJKd?=
 =?us-ascii?Q?rELXIqDxKsorrAkolp+4SrfRvKpeQpaj49G9kgosf9/MeoN9ymOMBawtX2hh?=
 =?us-ascii?Q?C/IB0n4yswOEfCejHy3gXYmvrhof/CpQrVb84mWT9LFnkTreFh34fY2/c/Jk?=
 =?us-ascii?Q?BLC1Zq2w6M09il9CyIfWUsNtOUUvVP6oCHuDw9oLyif6u6h/qPsuUt6IQupn?=
 =?us-ascii?Q?no6ANcEslPY9JP34AYWu3S8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3806dc3-7a34-428f-f780-08de334329ce
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:41:09.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLt8czyuY+lmO++i7ewCVaU4pYX+wO6s1oEFan7GF0x/4Wm0/z0JbkzYqdAOrJ7Fu9TFYDNoZtKTm0uS9ooRsD84XOoLjYT+ntFcOpIfe0r4A6MbxqZJsz+oQutXJKj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2367
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

