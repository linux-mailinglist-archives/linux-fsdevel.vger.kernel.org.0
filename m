Return-Path: <linux-fsdevel+bounces-1151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CE7D6757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB44B21431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FCB273EA;
	Wed, 25 Oct 2023 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="i5xXELR/";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="Yp8EZet+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDA273DD;
	Wed, 25 Oct 2023 09:44:23 +0000 (UTC)
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B574193;
	Wed, 25 Oct 2023 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227060; x=1729763060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zc6r04OKntnGPN69WQoGkeaQsx/13umKCd1ZT4QXIiI=;
  b=i5xXELR/bcFcu/siOxROTO9mw47uDR4k5ge6en+opDR3Pk3K9TiA+YFY
   z7VnDCwyfLbXW8kBURAKnNXn62VzyUbzFbwzfgPuYDmWzwEecrU60ysSB
   jKCOeGD3KAHX+nLv1wX8rIzIM5bMV1Cqe3yFIveMXXju9Ov2plzgfWD7h
   TmWzX5RsiXq6Kq4Ga3wEW32Xk7/I8SKYhO7x+bUaoKuKa7eNfjDn6cV3d
   hhBePM55eb2TVBQpti8zBn9JlmMmZT3AZ4Sh1C8P9qSJV+r8E9o1A/tE3
   Tu+5bTJP09GJbt+vGbLtJUMcD8/lfcCZL9y+cWvOBfDgYdV8fY8eAhGFW
   g==;
X-CSE-ConnectionGUID: HgCSW4cHRT2lw+NhGAh6tg==
X-CSE-MsgGUID: 8wZWZV3fSdCjnpLJoco2Qw==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2GuAABB4jhl/xmnZsBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIQKIJXhFORXpgmhAQqglEDVg8BAQEBAQEBAQEHAQFEBAEBAwSEf?=
 =?us-ascii?q?wKHGic3Bg4BAgEDAQEBAQMCAwEBAQEBAQECAQEGAQEBAQEBBgYCgRmFLzkNh?=
 =?us-ascii?q?ACBHgEBAQEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBDQWCJ?=
 =?us-ascii?q?liCKwMxshh/M4EBggkBAQawHxiBIIEeCQkBgRAuAYNbhC4BhDSBHYQ1gk+BS?=
 =?us-ascii?q?oEGgTd2hFiDRoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWL?=
 =?us-ascii?q?SUGUQQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEF?=
 =?us-ascii?q?BeBEW4FGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDB?=
 =?us-ascii?q?IE2BQ0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxocCTwPDB8CGx4NM?=
 =?us-ascii?q?gMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CbQE2RAkKAYEwVVIclhIBrnkHg?=
 =?us-ascii?q?jGBXqEJGgQvlyuSTy6HRpBIIKI+QoUIAgQCBAUCDgiBeYIAMz5PgmdSGQ+OI?=
 =?us-ascii?q?AwWg1aPe3QCOQIHAQoBAQMJgjmJEgEB?=
IronPort-PHdr: A9a23:5HLOhRIdfDTsVc70ZdmcuDdnWUAX0o4cQyYLv8N0w7sbaL+quo/iN
 RaCu6YlhwrTUIHS+/9IzPDbt6nwVGBThPTJvCUMapVRUR8Ch8gM2QsmBc+OE0rgK/D2KSc9G
 ZcKTwp+8nW2OlRSApy7aUfbv3uy6jAfAFD4Mw90Lf7yAYnck4G80OXhnv+bY1Bmnj24M597M
 BjklhjbtMQdndlHJ70qwxTE51pkKc9Rw39lI07Wowfk65WV3btOthpdoekg8MgSYeDfROEVX
 bdYBTIpPiUO6cvnuAPqYSCP63AfAQB02hBIVkva3TiiD7rj9RTbi+cm9BehfsexT+1sUw2t4
 Jt2agK4kj4VOxQ03VCQ18Ml38c56Bj0lgQv7rzZfMK2NthmfKfRc/UFHDRIZMoNbyhuXoOgQ
 bQDC7AQOudSvbajjFUUoDiTPwqiG83UwDJzoXXd4LQ66uInVifZ/Qp+P/Ict3v5j4zzH7cRD
 d64yIPi4DbgV+193R2stKn4Sw4ThNOUdqhUf9iJzRZyEDHAtASIsKzAFje5/d82sGOEt/Rva
 LqV1XcssyNU+Gadm54Uh67j15w0zH2Y5HhC7J8fZoKRHR0zcZulCpxWryaAK85sT9g/R309o
 C8h0e5uUf+TeSELzNEqyxHSaPXdL86G+Bv+UuaWLzpiwn5oK/qzhBe3pFCp0fa0FtK131BDs
 jdfn5HSu2oM2R3e5onPSvZ08kq7nzfa/w7J4/xCIUc6mLCdLJgkw7UqkYEUv1iFFSjz8Hg=
X-Talos-CUID: 9a23:+aI0MmxVISnN7Tpc/YDGBgU0FeseTSHW7E3seUunSkBpZ5SVF0OfrfY=
X-Talos-MUID: 9a23:6rJ+UwZu/MDiK+BT5yDeuwNcb8lT74+sDlgps5INvJO9Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802519"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:08 +0200
IronPort-SDR: 6538e32b_U3zacnnPsKZ3xGk6c341IlpSq4jaFx0096SuLkK3RE68Uhn
 ysGwwLRSC6fEcG6NC/egrYu1QmrmcISluIu582Q==
X-IPAS-Result: =?us-ascii?q?A0AcAQC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBGQQBAQsBgWYqKAeBS4EFhFKDTQEBhS2GQYIhOwGXaoQuglEDVg8BAwEBA?=
 =?us-ascii?q?QEBBwEBRAQBAYUGAocXAic3Bg4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBBgSBChOFaA2GTQIBAxIRBAsBDQEBFCMBDyUCJgICMgceBgENBSKCBFiCK?=
 =?us-ascii?q?wMxAgEBpTABgUACiyJ/M4EBggkBAQYEBLAXGIEggR4JCQGBEC4Bg1uELgGEN?=
 =?us-ascii?q?IEdhDWCT4FKgQaBN3aIHoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHB?=
 =?us-ascii?q?C0iBgkWLSUGUQQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1B?=
 =?us-ascii?q?El2ECoEFBeBEW4FGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLA?=
 =?us-ascii?q?wIaBQMDBIE2BQ0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxYEHAk8D?=
 =?us-ascii?q?wwfAhseDTIDCQMHBSwdQAMLGA1IESw1Bg4bRAFzB51Ngm0BNkQJCgGBMFVSH?=
 =?us-ascii?q?JYSAa55B4IxgV6hCRoEL5crkk8uh0aQSCCiPkKFCAIEAgQFAg4BAQaBeSaBW?=
 =?us-ascii?q?TM+T4JnTwMZD44gDBaDVo97QTMCOQIHAQoBAQMJgjmJEQEB?=
IronPort-PHdr: A9a23:lm+lThVn8LMB/Akmi+IVZ2jSJojV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsKyrRrT7rtQym6lHPD7FpwKYneoq
 KU2EBXRhyg7KhwkoHvOmMBagY9q50+u8k8aocbeNbCNZNdMc7+eXtE4XWhFUsh3SHUfC7mwM
 7MLILYBIchno42ntlwPpwmBWyKiHu7M5wVLiGDY5qc36MMrOjzf3DUmGZUor1XS8vXVJqAdf
 MPsyoLYzmn9Yvd88xr+y7DWWRQL8K2tbYtuQ+/z0WI1Mw3X1lHP9IvXOgnEzv0tlkGfw8Fbb
 uGklDY5pDwpmGa2zd8Or9OXtN9M8l3j33Rn4YAYeczlc2JiS537Oc4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBzj65CaCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 Wi9Ul7lD7p6AZDPkfBBVwoVvJJJ
IronPort-HdrOrdr: A9a23:udbVVazkvSrN4imnzHDpKrPwKL1zdoMgy1knxilNoHtuA6qlfq
 GV7ZMmPHrP4gr5N0tPpTntAsa9qBDnhPxICOsqTNOftWDd0QPFEGgF1/qA/9SJIUbDH4VmtJ
 uIHZIfNDShNzVHZYST2njcL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AgFI0fmkzMFTiXhUi93bioQjiUS7XOXuawCzfCEv?=
 =?us-ascii?q?jM1YzUYHWdliA5Y4nsPM7zg=3D=3D?=
X-Talos-MUID: 9a23:GpZjHghM8gIT20o7nhiXPsMpafYz/byNLV00r6oPhsKbDANbAnSAk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="188491600"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:07 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:07 +0200
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckPCgIhynrw4ahf7Fgk+mzT9cbA4C/zoX3Bh62y7GMBrdugDnTM3tzRFa+cmp2cHHyVIEAU8ib5IJynpL7fWjx/NWFmYJ5TNiaCTGGADe5zxLPrhlf31yeHeO+4YRLf3nWdq/a9MhWVbyfUcyPNQFYhAN5aK0iGaJWaHbJ78Z4IKdQ3ls9YH7uiKNqz6XcR0ECNqrj9Cym000DDcxPXqdyhSPSSann/smRHEzTuqGCkMqkmTtTFtpbbb297iYDtOrPhM9HagEo0QwIk68j+Uo9L4A9y6hel0Aiv3gqUbN1/IccHJIfKq2NKuXGpsIx6Fb2aLsQjnsTYqsAQjktHS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wYA09Ez/WIUe3DVS+b/j50bQggTuJu8rqzdBeEY/5g=;
 b=DAvYpHdt5DIx6i5WA0RWUEDAYGVkqvRuVSrQxl5jXFfZwiIGIDWi32cqIF8KB+ry/f/PDvxwxUA7ODwjnBl9m1gvoEL72soJM/IalH4UqXVaf6yrvsmiMTKJJExL1/+v9OZt6saKRo4JYyCZuy5Kn0dDaDQpgl8BUfTT+rNWNbkILK6WXP/MYUNi09TWFrEnLd/+NN48dJ9Ua9c5RQdCibq9740Hnwwif0IZycmLqi22/qhusSWop5D1POrzKGqOTvKV0N7xqC0LLRyvMYZYNaTdRVvSsmWfUiP0pNYQ0TYdB81Io5KkbY2MZvAbpN1cfRBFWbiRMsDhYXNOO1B49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wYA09Ez/WIUe3DVS+b/j50bQggTuJu8rqzdBeEY/5g=;
 b=Yp8EZet+KjJpjldfNw16aRd4PlG4htFWdl2yoibzW6CfreKERkfwFSbeSObCUqhQnn/NwIn6HHzogEK1nCxk4VelBBEkKPvClB94IXQvZMJpCrLfz0l75oZmR9pqHMAlDCSSkcw0vgU0R6qcpJM26Z51PeOB9vInE4y5SDqB+7A=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:02 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:02 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
	<paul@paul-moore.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RESEND RFC PATCH v2 09/14] lsm: Add security_inode_mknod_nscap() hook
Date: Wed, 25 Oct 2023 11:42:19 +0200
Message-Id: <20231025094224.72858-10-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE0P281MB0116:EE_
X-MS-Office365-Filtering-Correlation-Id: fd20babc-28cd-4fe9-8807-08dbd53ec7a8
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L0OwalW8Pcf3pnS90WB3/jKX9qQRFLjrV/v9SDEX4QESAkYO2NdKHisbPB1T9PfSUUU1q3VmN3dm3QEYLHD+Sqnutycnn7jOuyryc0udT1+UhG0jYotDNZplfBkm0etv2X6Kolq7cOXJ86JgR6kPu/ZFxHVeNJcinYv7fRyi6P/WCVWamjYnblEqh4NxkB3QjW15cVbthlxXUc8gFq0KdwYxRyHuFlUhDB1jScwhjWiJQVvskgj4VJNHDghtdFAsIwj7bqsUjy3Pj/fOFcbYtDwGe2MN3TEXXN3tAlky9ohV1/GuOyGiKSDHEanfLBQkKrKTZX+GzXROJdsX+7jHAn5bK2dcmA4CpWd6tTueoIoBORMKPE/IBFMELSO8KvsI7DS/PrGSlrhdyg6azuRb2SLdwnySqTUmZ232ukRx4ecffWyW3MMjIzg2TeHlxfAe9icS/0OB+f9kkyjb8wHS5R73V4LRCRyQElJGugWz5ldalHdhvas1KHw/SIpHpUEWsyJmddny3Um/aH/cly6YwQIwT0hxOm2OZo6OCznMvN1kUk+NbGnuHHA+88rmgtQ3XBTY4ha3u8Fi3LC4CoKnEiegUEUNL55Jtpi+fo5FLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3V1VFpiZjRaSFJqTlYzYzJML3RMZHNHQ2k1dUxTYnk3WXlEdmg2ODJHT3Uz?=
 =?utf-8?B?ZWQvQWNSNnhsdHV0UDdPYVU5cnZOSzJXd2l0Y0VBOTdHK3VLdWpDaDMvUDR1?=
 =?utf-8?B?ZndZTlh6Y0U0bm9Rc0N2azE0ZCtUQTJoNmxRNWltUEZoNEpkcm11TDlsT0hk?=
 =?utf-8?B?ZHpLLzRISGtURzVZUXh0OHMyZFIwaDlOWFJBVDBuUGN6Q2VNSCtXSHdDdWNL?=
 =?utf-8?B?d0tIV2hXbjdLMVROZWpobHdFdzUyWGpyanliRjd3b1htZFhVNmdOOTg2NVZM?=
 =?utf-8?B?bVFUZjBPNDYxbzNNZkp3eFBqVWRWcTg4Y3hpcFlqUnlySGpsdmZ6NTN0eVNG?=
 =?utf-8?B?Z1owWG1La01ydkQzaXAwV3o0Ly90OFhnMU9NODJyeGxUZUtoTEl2YWpEdlhM?=
 =?utf-8?B?clhaVXBKY0U3NEhmSS90RitsOG80cnAweWFuNmdVVW9Xd1JPNkFJS3BVQ0l2?=
 =?utf-8?B?QUtNSms1enlrb054cTdyUVdYbzRleG9lTkRxbDB3SnZUSXJsR3NCRWM1Q2Nw?=
 =?utf-8?B?SGIvRUFLaFdQN0l0Slh5ZW55eHVZdVYwb2RRR2ZYOVZuT1VvSWZWeFF0WkVq?=
 =?utf-8?B?T0lmb1B2enpIbWR6STNmM1NjdDEydFBwMkJXUnFDYmo0am9qbXc4UEZGZzFV?=
 =?utf-8?B?NFVUZmU1NjJBQmc5SWVMZHhZMTk2ZkxHVTVJUVRpOW1Yb1lGOHJnbjBPQVV3?=
 =?utf-8?B?L2wxRXgxNk1rMi9pK2JtSkFqdS91aDVGd1JzaFBlaWdmVEFxRWZXQXRUQUtt?=
 =?utf-8?B?M2MyRFRmNUk5cHpnNDRMVDVFUHZoejZxN0Q4cG9iYk1BV3ZYOWNNb2VNTHEw?=
 =?utf-8?B?S2FvUTZBS2NmTzBQK013N3VUWDJ5SXVuZGYzSEZUalA0M2d3elc3K0owazdm?=
 =?utf-8?B?NEVTaXhTa1VxL0FsdnFVTGhHbDJlS1ZGV1hMeXFLdnVtSlIrZlBpM1U0cnU5?=
 =?utf-8?B?aXFvWVdaY0svWVhoVDdzaXVhKzBCTEs0OGo3UnppdGQ1cmx3eWt5ekdIanp2?=
 =?utf-8?B?bkx1TEY1UzhCVlN6MFd1emxvck41MWc2MHF2SVZKSmFZczE2SXJUUnE2c2JF?=
 =?utf-8?B?QjRaUlViNE51dVY3WFVJK29IUkdpRWhLR3o5TWJRam03R3dkSVRPMVM2OTRM?=
 =?utf-8?B?UmtCdkdiREdvbDlvSzBodkVZMjFLNjNjd0FRS0RER1ZGdFV4SzJSV1lNbnR3?=
 =?utf-8?B?ZHUrUzJZTFM1U0lWTDh5NHNBMTl0d2FkZ3l0L3RzT05RVG5JSUwrS0VTdDNF?=
 =?utf-8?B?dllUSHJFVW9ZUnd2VEovc0paUCtmRFhOb1BpU3N1ZzZLTWdITUFqMUEyOTFi?=
 =?utf-8?B?RUgwK1RYMlhlRXRYeGtQenhFNW8ycmorSFBzMjNTajZCRE1zR3pWdUkvcGMv?=
 =?utf-8?B?bVVJWUpteUlrSEtheWZaU1ozSmFMTTFZTVlJWHpDRERvNUYxTU5wOE9Bd1hI?=
 =?utf-8?B?YWJQK0NwOUdzTTBqUXZaVTdCZW5MOW5wMGIrSDFHVWoyMDdUWW5ZN3d5WFI5?=
 =?utf-8?B?UHdma1RmZjI4VFVOM1JNckQ5TXJVcEx2cm84SWxJWllLMGVaekFqOEYxSGJz?=
 =?utf-8?B?SzBYdnVybVJwY3JSUTU0ZVZYUUl2U0VycW5IM0lzNDl0S2M1eThKZkF6UEpM?=
 =?utf-8?B?N3ZKclVTbmlka1FGaGs3TE5TK0RtbGowRlcvc2V2SGQ3MElHcVcreWpLdlpq?=
 =?utf-8?B?dDdzSE8rcDZKb244cWpJbnRDNmlzZmxMajdqS1kzS3djSjh1c0VxQUtRRTNo?=
 =?utf-8?B?UmhMQTJ2TUY0VFFId0duOWViV21NcWRSVEowZW1SakpaWXF1SDV0ck1yRE02?=
 =?utf-8?B?aWVnRmZIeGtiK0JEUVpvdHo4Vm5OUDZiY0hPSkM2Zjl6YXNVR1JpNGhrNjdZ?=
 =?utf-8?B?WksyU3dhU2lZc1N1YWhLRmJ6YnNna1UyUWd1VmNCOFA3UTdjTVl1Q1lOQ3pR?=
 =?utf-8?B?QmJIMCtjN242NDNFOEdNVjhaZlVhUTN0TFZiM0tySHdPYzJrR2xSZHM0NXdi?=
 =?utf-8?B?WlZSZHMyQlhZN1ZhQlNTamowMEhyRnZOMkdILzJtbzA3aHdDdTJadXQ1djFz?=
 =?utf-8?B?R1RJQVp6WTQzNXRuTWFwcDF6SDFmWUFmT0kwRkpvMWNuRlpwaG53eTVub1BY?=
 =?utf-8?B?YlhUMHFXU05HZjBTNjN3RktsMkVUZ0NvVTFaMzlqeUpQYkZvZ3RrRkpHdXNu?=
 =?utf-8?B?OUNnZlMxK09zN2x1Z0hoaU5zaTJBY1FuSUc3eVpYQ0JvM3ZLZkY5VGc2MXlY?=
 =?utf-8?Q?UcVBKl6QPIWrX+Q2m5BXtBGt00CNHFfqEKAf7UzxhE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd20babc-28cd-4fe9-8807-08dbd53ec7a8
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:01.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i17tVnSt+K4uX1eDD0MLlzzeLFTb3HVld8pidfmBqZ3Zv8IBBg7K/qOE/+PGE44wqbS8uBu74a0sSfiCFRjlXwy5O+TeZZOIRxP5HA29c+TK5MFchOdoPqFk/inlWUO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Provide a new lsm hook which may be used to allow mknod in
non-initial userns. If access to the device is guarded by this
hook, access to mknod may be granted by checking cap mknod for
unprivileged user namespaces.

By default this will return -EPERM if no lsm implements the
hook. A first lsm to use this will be the lately converted
cgroup_device module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index a868982725a9..f4fa01182910 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -276,6 +276,8 @@ LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
+LSM_HOOK(int, -EPERM, inode_mknod_nscap, struct inode *dir, struct dentry *dentry,
+	 umode_t mode, dev_t dev)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 8bc6ac8816c6..bad6992877f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -485,6 +485,8 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
 int security_dev_permission(umode_t mode, dev_t dev, int mask);
+int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+			       umode_t mode, dev_t dev);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1400,6 +1402,12 @@ static inline int security_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	return 0;
 }
+static inline int security_inode_mknod_nscap(struct inode *dir,
+					     struct dentry *dentry,
+					     umode_t mode, dev_t dev);
+{
+	return -EPERM;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 40f6787df3b1..7708374b6d7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4034,6 +4034,37 @@ int security_dev_permission(umode_t mode, dev_t dev, int mask)
 }
 EXPORT_SYMBOL(security_dev_permission);
 
+/**
+ * security_inode_mknod_nscap() - Check if device is guarded
+ * @dir: parent directory
+ * @dentry: new file
+ * @mode: new file mode
+ * @dev: device number
+ *
+ * If access to the device is guarded by this hook, access to mknod may be granted by
+ * checking cap mknod for unprivileged user namespaces.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+			       umode_t mode, dev_t dev)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(inode_mknod_nscap);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_mknod_nscap, list) {
+		thisrc = hp->hook.inode_mknod_nscap(dir, dentry, mode, dev);
+		if (thisrc != LSM_RET_DEFAULT(inode_mknod_nscap)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL(security_inode_mknod_nscap);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


