Return-Path: <linux-fsdevel+bounces-70673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CFCA40F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37413302A11E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD33451C1;
	Thu,  4 Dec 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="3u+74Ttn";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="EbsuJx9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeMUC218.fraunhofer.de (mail-edgemuc218.fraunhofer.de [192.102.154.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F318C332;
	Thu,  4 Dec 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859094; cv=fail; b=fmOsu3u9ZvhSUhc7OeBNrNOoS5iBffeyYgMjPU5DmY0NBFL8URD1SUPJI87iVT/AXDybSeHQ94oP8r/TOJW/+5Tvi5blYdLPfbF8EgqqEpyzpj8mAaeHexHwzvYQkWSMN3rlnPtl69s7WSHhVYpWLmfFrJnZSHEfCwLhZ31Bwyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859094; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtGZnQI71PklzEqIq67Ee4zjreI+m55K0irvKSQFY+io4Ej1JdaNaLovFAOjwNykFzJAbvrj4N3xofCR6CThmQ6MGIJYtNCQxJ7ArXw4Pl1jZI7FM2Sll/KRN93sEWgJfBI0jDwHfPwDBuqWQ21P2s6CVPsr9xhm3qZvENVnvPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=3u+74Ttn; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=EbsuJx9d; arc=fail smtp.client-ip=192.102.154.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859091; x=1796395091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=3u+74TtnTmwAH5Yu6xj9EZUc1g7+o/S2qVlc7OzhPXU7VexJQq1JL7PS
   Q+WoNKrskbyzwzAgpCIw6rb64N+1DS5CvHk/nK6JH8RR+UubW5cRT0wYD
   gE9DMJV30xSVSdr1wglLLZBrpgcpwJzkjWTV/g3VMi/OBuM9pm3gx864S
   RhB70imgqi1dhqC9mXZtcLLsF8mLX2lQPL3s6qxNk2vq2yCL80jU3egnb
   qgWF2/vlDTisvbdjvrshJ1cXUXzETPPi7FcSPQssHkpLXAHVtYyJdKxqf
   y6Nm/ErcVhjuxh9tGngbw1RVy7ehWamC4e8T4Yh/b655cCMr6CrLGRcUn
   Q==;
X-CSE-ConnectionGUID: zQPq843VR3y6Zz8uBUCTIA==
X-CSE-MsgGUID: xMf41TsMSFaDG5VP4W5i6Q==
Authentication-Results: mail-edgeMUC218.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BABMVK1o/yYF4gpaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?XEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3nXYBr2s0B4I4gWeBX?=
 =?us-ascii?q?gYMn2caM4NxAZNukwuZBqkWAgQCBAUCEAiBfoIAMxokgzZSGQ+SIboxdwI6A?=
 =?us-ascii?q?gcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 AGLeAA=
X-Talos-CUID: 9a23:S81F7mOZEFnPlu5DShBf7R5IQf4fKWyD/mWAPmWFIlpIYejA
X-Talos-MUID: 9a23:pbzYhgTaQNtk00QnRXT8oT8+bftzxp+AAWwizKs+5/bZNHJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="14661710"
Received: from mail-mtamuc121-intra.mx.fraunhofer.de (HELO mail-mtaMUC121.fraunhofer.de) ([10.226.5.38])
  by mail-edgeMUC218.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:36:59 +0100
X-CSE-ConnectionGUID: p6PlwQICRVK4pjrMronwlQ==
X-CSE-MsgGUID: 9IQSLPUvSSCP+F2bMrG4tw==
IronPort-SDR: 69319c88_bxundYRTPY96oT+kVrk4h8gwztIbT3cSgrSs3M0vi5tZGue
 smCTzMgqIClTk1fAbdU7nK0vdEufAPa6odxsEtA==
X-IPAS-Result: =?us-ascii?q?A0BABQDL7aZo/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCUnNwYOAQIBAQIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBD?=
 =?us-ascii?q?wtGMSUGDgUigmCCJQQSAzUCAgKnJQGBQAKMV4EBggwBAQYEBNshGGOBZAkJA?=
 =?us-ascii?q?YE/g3yBcIJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8mlBICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjSwUtHYEnfYQZhCYrT4IidYF3QRk/g1MeBmsPBoEVGR0uA?=
 =?us-ascii?q?gICBQJDPoFcFwYeBh8SAgMBAgKBHBpAAwsYDUgRLDcUG0RuB5NVnXMBr2s0B?=
 =?us-ascii?q?4I4gWeBXgYMn2caM4NxAZNukwuZBqkWAgQCBAUCEAEBBoF+JoFZMxokgzZPA?=
 =?us-ascii?q?xkPjiGEALc6RDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:yGWs4xXxIcBbdFcEldNP4QlUnkrV8KytVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLLlg7gt/dW0SWBO+/qYokFdG+C/
 Zo6VgXYszkZERVh23rXt9VxgoBdqx6+8k8aocbeNayfL+dcbvLRT4shW0wYdccMdHR8PN6WN
 No3IsQIZfx8g5XsnwRW7gWTXiScW8rq8zoWuW3y/60+0cJ/LVvg8wcBQssn7X/VkdOsNvcYY
 c2L9azH8i/gcf1z5Bak56bWcxw9oPvTeL91T9HRxEB1EQXgqFOvlp74NSnM6foJi1TF0M9gb
 PymyC0spxxfgmetnukKg5jsrYU191ucqiNY74AcG4aTEEkhWNSoMc4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBxy/IDbzIZzlijW9jeLWxigz0/UXzguH/V8zhyF9Rt
 WIFidjDsHkRygbeotaKUPpz/0qtmH6P2gnf5/sCIBUcm7DSNpghxbA9jNwUt0HCFTXxg0L4k
 OmdcUBMxw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZMbSPKzRwPAfiUKH+q+aKrPxpOskLtp133Aq2lEZdPULSKOlfp
 GV8MjziyWYtN9IYgBapTiBUJPwJE80hqQFm7X5XI3SFDUO3VHHEGgM1/qa/9SNIVycygc/79
 YqT0EdMqyJMbESt6+Ti2PYc+rIqOP3tZxA7t2uq0uFODsaDZ2ImD0JbTpzfHcGJjVuNN4cLt
 6x98BHrz2vdTA8dcKgHEQIWODFupniiI/mSQRuPW9s1CC+yReTrJLqGRmR2RkTFxlVx605zG
 TDmwvloo2+rvCAzAPG3WO71eUapDKh8KoOOCW/sLlaFtzesHfoWG2nYczDgNkBmpDh1L/tqq
 iOn/5vBbUw15qbRBDJnfKk4Xid7N9p0Q6n9bbQuwqdneXpAD09EMZPnoRfb1/Q7Fchpsh11O
 ZR03uerIc/N2K2oM3R3am8a/hRrDvBnVMy1eoIy3BPW4oXb7Fc6YQZ4UNOCZ8FWCb38pouHu
 ViBNzVoK8+SyLSU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsJg9V55H7e
 LZNbkArsA5cuYGKaZmQOsRS8q+DWLABRrKLWKJOFziULoKPnrcwqSHkondJNvaC6Dg4KFC6K
 gpCmkoy1LaU3ieePGz4A==
X-Talos-CUID: =?us-ascii?q?9a23=3AQ+xWx2gZLxEHUSKejQYrq4bUKjJuaiPlyGjpAmS?=
 =?us-ascii?q?CN0U1UL+PbEWX/rxgqp87?=
X-Talos-MUID: 9a23:FXa5PgV4oxNcIRLq/G7NvQpGDPp22J+FMAMjy58joebYKTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; 
   d="scan'208";a="32647514"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC121.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:36:55 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:36:54 +0100
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.49) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:36:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qajY9d8T7g7czIzW3Ei57rZgfJFBEaxhMTBL9fhyTMFnXm+TePy6V3R1OUUMW4H2peIoQVnP4apXvMrer+0RGg4PpujyPlM7M0IYwtCaWZzmljDf3FuZJYIOaHdDLaztlzOKoa+LtQu4dSUqsL9XGk2OA6MPBiovK6ryieSe8Csuz7iPocWw7jbBrQjw6n82XFKJjJieEv3y9rQrtyyaSzONgSnobqH77Ah+G+pgVOykz8HE9hsC/jm6Nv02WnKgTuvvRsfkioCUpXyEAH5t1ofRdJPlJrvzCF8+VmJPMkl0gOGVobPCe6XS9FbnnHibEv82kld1uLFy3eLUOk7zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=C5d95bze4mw0jUh9l6GpmbzBsZXzqkVqmevYiFpzv5pzPLS5jCOwtdHhW9TcEotjLSriI3fXQWv3hRA206l3fnxin2/EVsLkAV/O5C9ijOTPRv6kocpAJ7/2u29en2UdpKcm0TYFlcK3+ZefWMMO/pNt0QY0Cc9E7KBJGk+/o6xzG6gyRXPDa99XcB2cYts1B9aTw65c1849TttHb6ORRcvXdtXAP49Tdyde5zUzvPwWrGm7fryYEQ7rEcJJR7cOJwymQRgKLdEyIKblo5wR/yNrIRRfg9nHq/CALnSpr1mHFMFW/u2f2vtulvabjYZFHbpeWkABAHQByDFsIyjSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=EbsuJx9dZ0SvN1Ci5K0UV5B39PEFa0rLDtyP70+vE3EX7AmQm6WzlJhljN6T2NGcI5qA5ciUn1j8bXEVQmgWrKvfMUI1gFvidtib7MemVshea2nnMNnWWzubr1WvlPT6WMhQva++cduFH7j0FNayMCoHUc07nIGnAV3C0o2QbdI=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR2P281MB2669.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:36:53 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:36:52 +0000
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
Subject: Re: [PATCH v23 03/28] riscv: zicfiss / zicfilp enumeration
Date: Thu,  4 Dec 2025 15:36:43 +0100
Message-ID: <20251204143643.8456-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-3-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-3-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR2P281MB2669:EE_
X-MS-Office365-Filtering-Correlation-Id: 039242f8-c98b-42e4-394c-08de334290eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eDA2/BsruTVIOKcYT+/AxC8ejqQUookud4A8TnRfJyiofHgfz2x2eOsAXaBZ?=
 =?us-ascii?Q?sldXSznngZXJbyR4h7wX3nUUHzAMMgsRK7Ud9nUB/AsbXJeN1kWdU+n0Orf6?=
 =?us-ascii?Q?G17BY1RzZazPd44ZKVHNrqv8OruyztvNSheuKCGGdxIGlyV4DgUtDflug5vf?=
 =?us-ascii?Q?kssZC8R8LtnHP5zbW22E6PPd1qnYvRbaSuc1W0azRDKpDrzqsFp6JynfkVLt?=
 =?us-ascii?Q?oknOupw2aBmu8gyQBFEJ6q/kxT70j4PUQv/jOesyLs76kfw5Dj0gG5lhc6NC?=
 =?us-ascii?Q?DhlytnLdk+cSaEaP16JOHv9o3hlv0GKmEgI+npAOA2+jTxXtu9MsDktrttVZ?=
 =?us-ascii?Q?g823hdocL0lq0UpoTeCe3RWPwzd8aqR8CWGwz9VbapsoDqCb9RHfTASAmF6m?=
 =?us-ascii?Q?bbQUMq0WcnXvZ9mNCAkI7G0hrVhdrj1SqvgMsJ2AbQnhxwd8iUausHEJ+5Rc?=
 =?us-ascii?Q?CeWkRFA7sjBq85zcXnmvwrlX9luAtv2nsAO1cprWlTwpOt5jSGokcjb9c/uc?=
 =?us-ascii?Q?2SirxpW94odh2LYByUE/1iAqyzEsydZAt43Bdwvxy7QrF2ugfCNal8t99LB1?=
 =?us-ascii?Q?Xk/cv2RF8IpC0AQHiHWlLNsCapmTgVFaQzFpUf7NcsNbODAKlHI6xp2oLErD?=
 =?us-ascii?Q?0LGrv4Xof/UpdDcjt20zjs5S5tEarGwygCTw9aI2k3KLFnynFbsMg6mS3dXg?=
 =?us-ascii?Q?E+x9GwjStRZHp+ZPe1mJ4cOFA5pHI4gTr8vDfQdrZI8+GsD5NhD1s6VTCIl7?=
 =?us-ascii?Q?4jCe0VW04rXlftdjFmY208JpE7boxcqY2NGRJxh5kkjvHA2nv/tQqVKiy6VJ?=
 =?us-ascii?Q?45eKQMnolKa2wHXlkqq0jBdVIT4O4DWufwT161I+2i+ZcP9mOPTA+gJid/K4?=
 =?us-ascii?Q?9gCEnlZBDwL2mldAiTTX82ahsj8mDW8rjgDX++UPBZQwjRZN5F6avGQsAwZT?=
 =?us-ascii?Q?DCIZal3x8wKgBso56xni9lhw1BcC/PlqeilkpQqS5StLaCTNdvcqXe/nPKrY?=
 =?us-ascii?Q?4KCIBg/tU4xZN7f2fqn8d2YBLo0T1hoNfFAKoFqtTQtEUKzwl9ZA1Gs6IZqP?=
 =?us-ascii?Q?Ir2t26XoHLcFuQcR/Xqbky5H5lgkgTuvm9yOpICInGuw+4iytugMOmlkE8g3?=
 =?us-ascii?Q?w9xmsrl2k+IPjuF+YAL7lp9KGXzGgQ4TTcwBU88+OKLI5FZmI9QN6N2Gh4f5?=
 =?us-ascii?Q?VdUmjhAYQ8NiN0Jiy8z/ZKIVvcBliIUn5/nAhTV06HrNt0MCEwMWzOrugbhj?=
 =?us-ascii?Q?f2edt2vgYlFs+ERcGHxYVY/McrzfvXC6t6CA+9JRTJrJbe187FaLukF1vkaY?=
 =?us-ascii?Q?RhQxM6JpD1uakzhzAWJ3IyzYx78pB2Pnh0kue7PUiaXx4p/XGfU4UZtO3RUo?=
 =?us-ascii?Q?fL6gNfILG94M3O6CR6aZ5C0JIKRbHJ6Kttj/V38F1/wsHiCp7aHa2JKkcvg5?=
 =?us-ascii?Q?xY1KaBL8hj+WAF2YR02fVR2oIkZSbQG3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Awh+qM7FFjYfPoy+++AoLsIj02gGY/DuwEe4Z6Pa7wprqEu0ex6H49Jg6IZL?=
 =?us-ascii?Q?FXKL2iNo7UlZfO9yoL/EVYso0tDj0wsYOJK4z+5D3dCz/VqWzLsshjwjNpQQ?=
 =?us-ascii?Q?9D2kPY6TOFTcDunJiC325irwSir9mAIu4HOFQGOJQlZPYogyC8i7M6rBUwX6?=
 =?us-ascii?Q?S1lWhjJzPK4hQPsG6YRIJuohv+HekcTqIOGBsTMwUg+ew1+QRmv6fn9WWWLs?=
 =?us-ascii?Q?wMVG1q84eMvLgkA/vCBDbq6nAhVKoR1ie11m3ARnzAS2p/uTY1D7f6jsnQHl?=
 =?us-ascii?Q?FqhbV/hzNgA7RMZqRW99HU2ggqJpkqKspT2i+IDYhlOXFNKmxs6qzHvABiuD?=
 =?us-ascii?Q?9o9lYws2fGo/K7XRxe5EgW6JArGA6pT9HCY6hS0oLpPbgsxl3bELEGnqmqLt?=
 =?us-ascii?Q?fnItwRF5xcCAd5PmpHognBbUsIpXyevPo9DOzTfKrEiiWlORyOtDB9WqYEgG?=
 =?us-ascii?Q?ajUjsrPzq6yDA+Np/1aVgWP+7JWz9+G93Yb90vQv1wqNHtkfjKaE1wKAoOpi?=
 =?us-ascii?Q?LUxwQa8o4IIomJEiNY8CjThoXW5RHS+ZmGeUcLAcDpGjwrlRShWoeXIJCr3Y?=
 =?us-ascii?Q?yzjCuwbU03pcEgVbt4mcOA77P91p+wpfn3BUoWOn/po3QoVLf+IwpiS7o9c6?=
 =?us-ascii?Q?h5B/5dsUfOXz+GtUbPT8xrucFpOugXMx5AIfGOHE91cnxPZINDHkTSlU7CRz?=
 =?us-ascii?Q?hr1HBtLJOHodnQba4EhXGCPAeD77rM2boreOikxACn9X9cxrq0+Ked/rEuRU?=
 =?us-ascii?Q?c2VuLQ5uWrNsmfE8V1N7QoFPZf5n08aCW5094oNoFX742yMPFmjeFefkfCm2?=
 =?us-ascii?Q?kPms45ulbNfGbBOu4fh/8lWllFwhGCDUvoiPyrDR+93wQ/dOyEhtxhi2QdCc?=
 =?us-ascii?Q?Dw3BLMzYhPq9UHrOj9NK6saIqKWF6dQvPFxSSmRjqhPiEOkzkdcvbjbvF49X?=
 =?us-ascii?Q?YKkVmOyvDKCG/0pvLyr2AXIqzqFKZc2Pd5MOK7bPSWVHg7qE0pBWk+yT/bZA?=
 =?us-ascii?Q?hPMf3f9obuhSN93u+sned57868xIpjJAEp611MoTsO4h9PGIjXpvrpEL0ze6?=
 =?us-ascii?Q?S4j6G5x1sMiEfurO7oh+P2I3NoO1gHYCBIWIaPX73u2vn+UIsHEfln7zJdNS?=
 =?us-ascii?Q?uWBHxVU1CtHsbM7RVWjoHFPCY13RTz6Ebznu1VQsGA6PyXONxPxnKFXjGTZO?=
 =?us-ascii?Q?dhe+C+JcWwzMTLJ3wq6cJt8+K5/GUJQkLSw/+O2WVlYrzyXdEb3ugawB7PCJ?=
 =?us-ascii?Q?WSf2yyeWxvp/Cs5GPGrIhLvck0VLJGhrP0TAZk0masagnbORNDDpi/zFaOIl?=
 =?us-ascii?Q?6GoMS5sowMCyk8nRoWJxR2vHkoX3Qu9PrXXs/QBjx2PNMPw2zVI0dpBZtChz?=
 =?us-ascii?Q?64yshY0Ph3SmZR/Lkwzk66BgPGXz6uRAiOw8QaLr1f7dPrXiGkCOHdxe71AR?=
 =?us-ascii?Q?lRtHe9MLLfxvig8xx6PuD5AjZw6D9uY29xo55O4pQ0Fd52LT3b5bRdYkg9k/?=
 =?us-ascii?Q?4jLJMrqNZwnX/Op8za9qruN/j33vk1VmB1rpnEg9w+6LBv/QjpvZRtSn5QUZ?=
 =?us-ascii?Q?GwVGcNgefH+b8dEDTMCNXBfnoZJ8EF8G+ot614jBZcG2y87guZe2O89hUwid?=
 =?us-ascii?Q?702l75ItstfoP+OS4A3AH1g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 039242f8-c98b-42e4-394c-08de334290eb
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:36:52.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC+gT5+W+wKjFiGeSS45wiMqcr2okK/+i0GtHl0/qm6GFqp2AUVKYhe4HXACfhfcWraeNgtJNew85AYUtFIsH1ij7dS8vDMhz/m/vgE7p/b893onlbrSnj+NsUCWRssb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2669
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

