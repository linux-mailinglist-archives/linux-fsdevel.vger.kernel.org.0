Return-Path: <linux-fsdevel+bounces-50999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DADAD1A77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0312616512F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47D24E4C4;
	Mon,  9 Jun 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qSqDlLge";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xXcxvhIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726D1A9B4A;
	Mon,  9 Jun 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461080; cv=fail; b=t50iAGqmEYhwR78NrVl2FBCg+Fr+UmbwIe8P1ejD9927g1s4ysq0ufhPGOtCIwFT5ceV4a9A0acxXfeZ84yEBHcP5ryLP/FWOe06KhMEcR3m9fUlEHOHQTVaRRoO8D+O+hs6+9acoDFvtwXATFIkPeAAvpUwSLDSexN9Ud4dQNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461080; c=relaxed/simple;
	bh=xO/Q8+8vnhMShv6qTxDMCaZ2ZKYJgfrgUt1+BfPo62Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I0YJAqgto/PTseXQFC9Fpwu6u4O22rCV6YwshhMv/wnrCVqMR3EmSqiUc2bXLIxXsdPdHFX7WdYKe2ozYxShKzB60F71Ofponq7m2dX95XCdL0cnRQ55Nom2xGVgqgp/wLWFogAOQcum0rzbqv5fXOK1hDfUrpJqrpaHa/1zwpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qSqDlLge; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xXcxvhIR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593jmuY013108;
	Mon, 9 Jun 2025 09:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=2Gpslu4cup0sAOer
	PyuR9RIo0QMTc+I8EbpGYoZ7WYw=; b=qSqDlLgefeuZeneYzQ0yOrdAVRAF7Ytq
	kcSlDKTLMOyivtND1mAxv7WcI7KjSdZ2fn/XcWacJ1H9ljyNPKss4w+nq7HllHpJ
	8Hk0XX8/hZjSxpUzyMuomzT0s9rwJ2M6eV/QD/fbnbxIdO2xy2zENzCjAhGBduEA
	jgieAiMUOcgohwU1SSHmAkR5uW52ye7txcmKJfybvC6S9RlZ/MctAkqCy7jU91yK
	RC1MtknMff1mcn01q7Wrfg1Qs/xnjF4pDxyCX+wasaP0/NFK6HH9LgVD0Z7N1jIg
	DMytmVfMhdelfpc2JuquAjdmAv/8Hh8hAObMVv8kANmF6BzNqSBrHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf1tn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 09:24:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5597354e020413;
	Mon, 9 Jun 2025 09:24:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdfwba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 09:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW+jMyqD4U12CclPoKJppWsCUOs0UIAoXlPn8Y3ozAdA2NvY6Gdi6O0Ue/8XPxL8ejuiRKugPWuy0LuKzl85KYn/aegIe4JgtptQeJLAq7rji8zSiaSZ36DUgqBrxXDFH2wouNltK6SNVm0LrvYlr25VKGIzwZN/1UsvG5U7flQLd0/EsST810FqnoIUiiVFHLit/YdtfYnSjaeP+xDH3wG5D6VotwgWw3lySTovfn0UH1mzsA8p+86G7Mutb3dz4eMbYm2GSSrU9fEChtrTQjUq9OefuSj3pk8igZQYIGyzooou98/cqmYh8c5WvIQyDrSgClAEWmIFPTxX7sjkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Gpslu4cup0sAOerPyuR9RIo0QMTc+I8EbpGYoZ7WYw=;
 b=c+fqlmNe6hY4FzXzwcuYAZedvtgHRYox3fGreL2/r6/WXSr182KIo+5zSx0xazS//hqO/TRF6vslVJuKX18fjYm64lPyMiE++TNPUiFZQGnLlCwZ+7V9UX/YYYW9/l/GYeZTwg1kMLpS7lbGmbsZqKdUYmcncLp4EXfVwM+3Pqmi/Y3eYcq/3y7pItVpI89TLUQG3fodiO+FT0wkVETvqZktP2/nM4faKkn792OVtD/HjkfpVNK/depXIIka3FEvhUCKIcecoK4cveSEqd0qSikTU8+xtib8enx14+NxGMjiTDivtel4yMv5shbySBc6OsNVRMurIAC7hkRaVQgbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Gpslu4cup0sAOerPyuR9RIo0QMTc+I8EbpGYoZ7WYw=;
 b=xXcxvhIR+2ELFHf2APWGDNC9zB0lwiHTpuQIOy3eFx2wJVXvaLYMxPifqVR+DZEBUubFMd/Zfdhfb76YAy8dPjM4uaW3gqXpqEo74161GsPa/hwSqpOShToZdmJ8LqiawHtffNrP/F3VH2hyOloDchxVivvwcEGmK/v6qT5WuQo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 09:24:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 09:24:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: add mmap_prepare() compatibility layer for nested file systems
Date: Mon,  9 Jun 2025 10:24:13 +0100
Message-ID: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: e795e178-9193-4702-efe1-08dda7376a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MNzI1Yo85MfniwwN6afDvuhuf1fWYke7Ow/sqvH7/YCnehpGNLJa50bx6N7d?=
 =?us-ascii?Q?Xa10M/6P7c0etxn6hpDFTHd/B+AP1dYpHFXoaSWaiPgg30Ff2ShmNZAHrhyl?=
 =?us-ascii?Q?LtFVFNQTb1JSdOPA8+o4qWed0lwrZbjrshFz5NshMKWTQDNFYEDc5sAFY4Zr?=
 =?us-ascii?Q?CgnCgLb5CaZyoP4URIFuRkaf9uTDLZt7CbglPnjKpW502zxWOWyF+mqhEpXO?=
 =?us-ascii?Q?+m9eteZ9k6UcAhF9dgxbHS7+qS7a3+MhRVivqP+BISTYwQNBTFLFzNu7/w+A?=
 =?us-ascii?Q?QfeultwzDaWnE1zRO9G2iD1KNbVykguGb9V5FZyU5oaCjhrxL7BN8lCEOVBt?=
 =?us-ascii?Q?eCxY7xQClRtkC1N4vnE7Oek1XL3GmlrIay7vSuT8BlzY8OgFDLZ15NmUE7Ja?=
 =?us-ascii?Q?hjMCrwUtC6ViiehVnoxyuNgzlpWHLKSYT6z7U6nJujQhiIEBBYp7hoq+6tCi?=
 =?us-ascii?Q?Kl2akpi4Q9Y+bX0C7jouuNLiTpOevlF19xYstOvn4BRZSgeqjubNe9Ymaj11?=
 =?us-ascii?Q?nhPvZLxTVgaUSki1RsN8Is+t5BFNF325L6Btjg+Tsv519vr3rMqJSZSDyENV?=
 =?us-ascii?Q?WrUulSLcDSzvwcgq2e2/WeEkVFuDTVpkLSD86OAhmijGLL+4193WJDZNKzg4?=
 =?us-ascii?Q?+rc/j80nZ/HTQwchZvIVkpoudHS+3P/muQ6a8QdiPE4pNnMGSboDQOupUFWt?=
 =?us-ascii?Q?jKsMicqFbV/sJxvDy8VqI9QFNmaitvXDt909fVAZufLdR4quSDHPBnmMJYeu?=
 =?us-ascii?Q?odqq7beu7+Txxy6A+m63Z7GC7ILPBY4QdxYwnENN4DObKMDYSIPnQapkjyv4?=
 =?us-ascii?Q?IURFmS0ATURZmiZs0WlEhoxab/5wcwf2heXXeoB7wRzxqbQOu0L6dCAxPY5p?=
 =?us-ascii?Q?KRZ4aVZO88PX7RNtnHnukdDNZUNRr6N7geZQfQNQwGkLZq12PDDtGRbb6pxh?=
 =?us-ascii?Q?LoW+Q4fnsnp7oTEfAMsFwi7jz78sDRHQVfuv0Jb3BcvFYCcoLGkKP5rVkoa2?=
 =?us-ascii?Q?4vyLChYK5KTXPvcWPPjEhBQfEYXEb/FGf1F4nC92DJZB4Z/HCkri/gIheOIX?=
 =?us-ascii?Q?pFVKBYbiDr9dAnx+mvLDAa6sAHZgnGM51siAcd20pe75kYzQHIncXgEDg0w5?=
 =?us-ascii?Q?i7+3B7XmSXkFJ1sYzIOJkqkewRx3c+vvoEjXS1s35FaokrtjArK873s3YjVw?=
 =?us-ascii?Q?kwccPzwTpFwLgMmms86rEA03gKqw7pZ0ssyCQzd8ndQ5GM308HDPdgE2lR9e?=
 =?us-ascii?Q?nfv/QgO6ysF94TU8pluPscV4iJSBX+PtF+pAysNDnTNABgw+I4HMdP5+GdLU?=
 =?us-ascii?Q?jiDbE4z7wFirvjzCv2MoaD6Beb6LTRV7hgFmSrtGaBD5DCstMX2aAm85/2R0?=
 =?us-ascii?Q?Lp6I7gZ9bGclmNXIiUYlrSU+88F9mLZ5zBozLX/zaulET8G+/xjaLwKDAK+B?=
 =?us-ascii?Q?RL/tlR+u6Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Be90qp/ExYqSyIRLEKvVz9fjI/Aww3XKyg5Ksq1MXEL1D4E4KrmCLuOSX1h7?=
 =?us-ascii?Q?Mi+budjokaacprll1SKvh3NZ/FRvUjvooqqug0JPAKgftVy9hhXT1NYOfLEp?=
 =?us-ascii?Q?dGKv/fsFOOni6ngJ3SaxS3W6c6aZQmen0G3980bp87hV93Aa2IUcFG7/HiyD?=
 =?us-ascii?Q?g409UVcSrMy60f1HzkT4id094L+SoP9GNCMS4Ika0AkJ2Xs8b/RpTqwdZX/A?=
 =?us-ascii?Q?AsEFYS74M6JAMAxyuzJOgrLjjBolm53EBtrN5vnLTC8fiUjkb63Yvxr7ejBx?=
 =?us-ascii?Q?Cjwe83UKOYntXPx4Uox5qXYo8eJc/Uu4d2hY/iANGqMLwx//Jq8iiWRaZy04?=
 =?us-ascii?Q?5cK2XZt9AXKVgTKKu1F41HxJVvEus2HSXhZ6vmE8n7fp/eBFszpyCii/KsPO?=
 =?us-ascii?Q?yecKjtfDuSMQaYTetd98FWu0jMalaiBwkmYCnLzJR23FD4k32E8d55X7g6yr?=
 =?us-ascii?Q?Hhq2fdoVd3LUXcX/nUm2AOdmY2S+pdGcUYxrfxhJ/zKx8mpe4Rkn1g5whO4x?=
 =?us-ascii?Q?kZd6LTRRygkgf72sS9thhB1zA6yRjOERKIPtiwLniAiOb4uJGtQLpbNL7xXD?=
 =?us-ascii?Q?450HHzZySDKGdEzdsQeQLuUr7Dvwvn6cOnDMwpzvOUEreqQxKL6y+uuPu7y0?=
 =?us-ascii?Q?fSRi5g525vifzsUpURlQUgDEqxEV09rtVP87noLaqgYHas9uU95t6+GPiW7Z?=
 =?us-ascii?Q?kGv3zeV7Hw3nvZKoq5ujEEDC0mfgdzSxunKWbtfg1G5Fu1anxSV7rS3LIu1l?=
 =?us-ascii?Q?doBRHwe7o/e1A9TpiSjdLxNFmwiE0EcMcbrDZxfSZctw2i1j9xy7pXQbNh34?=
 =?us-ascii?Q?shhs5J76NE2VcZR9hM16EgB57SabKJtBfFsWHVQpv2RlE2ITwBY3iVbUMUkw?=
 =?us-ascii?Q?LuNH4+it2Nq428JWKFWBbEZwxFCax9TbfPziQXZqlDZSXE+4YDnSqlnsziyl?=
 =?us-ascii?Q?NCb8hI1ovJ6//j1pXHoxEVqBUzQQySukRGI1pZ1FP7S1GATMf5s6YV8U2NAT?=
 =?us-ascii?Q?fPF3ARkxrbj+Xk+hcxN/yWj49UGNaquXlBP+4F9xRXmrg1NA3cScRbjkmGUQ?=
 =?us-ascii?Q?nLWiNne6zwobv1ZWqdkyP4iRxH+Wk8WB4gEWf9y5g0tIZMdMpcHBAPiiJyM5?=
 =?us-ascii?Q?ahDQLrJqfFpC4KPztQ4wlRtS64cb/jwbKcrN3eDE8a7XwtO/WS5UOQT6sJvm?=
 =?us-ascii?Q?d1BEU54HKq7ACTs8vhlPJ0iKMPWYi7k7oVXZ+xKlX+oeX1ongTaNrLi0EnDE?=
 =?us-ascii?Q?FL3414kcogwrV38VVDC7VCaN1IgF1isVVg2heHn0K3ygdP9tGdkasGubrLks?=
 =?us-ascii?Q?OIUO8C3qB8hZ/2xtYJmQLyzFNdRzXzXRIPT33yfOMGrHBDKhxX+EKp69Buh7?=
 =?us-ascii?Q?oTpbyWPYpIKR3PEpUlq6hII6R8M82w8qFIfPDIDxoNIUmurPNFA0YBlAR4b1?=
 =?us-ascii?Q?9NA2ps/J16DmumrJJ8jCKkJ2B0yfJQhfWMXHL9czM5sQjP8muZh7n7FFQzZ8?=
 =?us-ascii?Q?3oc5diLsN/53R+YoFA6hXqoL9BL3mfHWCpftkyVbLxstJM+8knNAFsW6qT7A?=
 =?us-ascii?Q?rAe9VZ2x8nlV1a8J6TsRCSsl0mUrm9rnKlWqylxTzsXYT2WVPC8pVsP0U71N?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	37tVhJB/+aVFXRCShZvq/sdmX05eRCbKasXof/OIHegwQtHPD+sKu7iR4H/anf6xFP/IkQ9rRTM5f1rJBaGfs1IQ1M6N8wFNcKz23EPY5mzXyohU1kPovhgRKtpN5y4r9zNfZM8LA9uuQfV79tZ0RT0rNkM4IQVUL19/FMMS1RIE1fbk32KSzBYeLkODjana18Krjm0Yc+a+x4QKRrJZSBCvSDmtAKIsY6ZUMhXSX+TH4n6z7MA2c+zAu1qaszkpFxy3EYivnzW8/Btff2H3qYB/tY0jw9YRbAmiD9TohofmNFC4DdfXsRf4kcbr4h/2NJj9ujwVcR56ys3BsBUpXx6csKmiBaSXoR83T6xGHQiz3VcFRN2NAIr1nGOJR9VyULdK5/rNm+B9OlnowGXORvUIC4nIjdRe/aGvXeyLJ7DwULXsi0xuMGydLdEej5WwbjA953ikkoxp8OTlWrlwAGmO05NOD+E5XqVOagEbDDKeNIWPQsEqTIxScXPj0znbRIpgQweEG0i8oQ2OnpTjR86cAZ7Q8Iq25s6UP+o9/8UfrMi1vN5SLSiTo6VlKlbTOfJ2nRHzVNZrfLfClT3ZjeJrdLB4HLOfWusZ8K/6IWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e795e178-9193-4702-efe1-08dda7376a64
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 09:24:20.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GqUBu2YEsC8zJXw1CnMOoMMlBdXzTA2WZi46B2prWKB6B3vaQex13Cg69mMUxB10YJTC9pdS8c9flFW80gyIK8sP6V1VFhJUwnf1A6b5Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090072
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6846a848 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=HNhzTM14WF-LhxQSznQA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: 0eEQeHVsAPPb3U8nln77-RvHLbmCMT50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA3MiBTYWx0ZWRfXyKlPEsuXY+xZ qUteqLXIc/6X2SuCzLpf9ubjm5uga6OWvjj30AqJTvkQq9UR4w0S/20kOxOwMUxXLYHcKSaZ8lI gNYaMxMAF+hEiIxeEt8QqGX0JB5z73ch1h2lJZ5zHGpac4W5WD25c1gDRJ3L7IfENyc2QFOC9Jc
 S7FOPSvbiEtjc0CHE5ZjRGXUEU7+jYX6MVDQjdO5QQET3QvYKkiKgy8WK2dTWAHwSiGk27+3Xt4 Cx1D/tRSf8mQD/8zDwfXtOTrKUa6yjC1dmH9mJOrkclL+/ipOEcbK0hFiwTZPVHSt49Y00Oaqdy MU9dzvBqMAQQ77H6sw4qypwzLIOOFo6D5ilFkjeNv04Qi2D/lkkvB0oETSa0Mc8eVibV8i95pnl
 D3+fiqPPxkA8tcqF76Cqp+sFcjwRXKdp6Dx/VLH2GBPAv54lW8EJWFowUE0eiBM+525xQ7c9
X-Proofpoint-ORIG-GUID: 0eEQeHVsAPPb3U8nln77-RvHLbmCMT50

Nested file systems, that is those which invoke call_mmap() within their
own f_op->mmap() handlers, may encounter underlying file systems which
provide the f_op->mmap_prepare() hook introduced by commit
c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").

We have a chicken-and-egg scenario here - until all file systems are
converted to using .mmap_prepare(), we cannot convert these nested
handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.

So we have to do it the other way round - invoke the .mmap_prepare() hook
from an .mmap() one.

in order to do so, we need to convert VMA state into a struct vm_area_desc
descriptor, invoking the underlying file system's f_op->mmap_prepare()
callback passing a pointer to this, and then setting VMA state accordingly
and safely.

This patch achieves this via the compat_vma_mmap_prepare() function, which
we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
passed in file pointer.

We place the fundamental logic into mm/vma.c where VMA manipulation
belongs. We also update the VMA userland tests to accommodate the changes.

The compat_vma_mmap_prepare() function and its associated machinery is
temporary, and will be removed once the conversion of file systems is
complete.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
---
 include/linux/fs.h               |  6 +++--
 mm/mmap.c                        | 39 +++++++++++++++++++++++++++
 mm/vma.c                         | 46 +++++++++++++++++++++++++++++++-
 mm/vma.h                         |  4 +++
 tools/testing/vma/vma_internal.h | 16 +++++++++++
 5 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05abdabe9db7..8fe41a2b7527 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
 	return true;
 }
 
+int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
+
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
-		return -EINVAL;
+	if (file->f_op->mmap_prepare)
+		return compat_vma_mmap_prepare(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 09c563c95112..0755cb5d89d1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1891,3 +1891,42 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	vm_unacct_memory(charge);
 	goto loop_out;
 }
+
+/**
+ * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
+ * existing VMA
+ * @file: The file which possesss an f_op->mmap_prepare() hook
+ * @vma; The VMA to apply the .mmap_prepare() hook to.
+ *
+ * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
+ * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
+ *
+ * Until all filesystems are converted to use .mmap_prepare(), we must be
+ * conservative and continue to invoke these 'wrapper' filesystems using the
+ * deprecated .mmap() hook.
+ *
+ * However we have a problem if the underlying file system possesses an
+ * .mmap_prepare() hook, as we are in a different context when we invoke the
+ * .mmap() hook, already having a VMA to deal with.
+ *
+ * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
+ * establishes a struct vm_area_desc descriptor, passes to the underlying
+ * .mmap_prepare() hook and applies any changes performed by it.
+ *
+ * Once the conversion of filesystems is complete this function will no longer
+ * be required and will be removed.
+ *
+ * Returns: 0 on success or error.
+ */
+int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc;
+	int err;
+
+	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	if (err)
+		return err;
+	set_vma_from_desc(vma, &desc);
+
+	return 0;
+}
diff --git a/mm/vma.c b/mm/vma.c
index 01b1d26d87b4..d771750f8f76 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	return ret;
 }
 
-
 /* Insert vm structure into process list sorted by address
  * and into the inode's i_mmap tree.  If vm_file is non-NULL
  * then i_mmap_rwsem is taken here.
@@ -3195,3 +3194,48 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 
 	return 0;
 }
+
+/*
+ * Temporary helper functions for file systems which wrap an invocation of
+ * f_op->mmap() but which might have an underlying file system which implements
+ * f_op->mmap_prepare().
+ */
+
+struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc)
+{
+	desc->mm = vma->vm_mm;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
+
+	desc->pgoff = vma->vm_pgoff;
+	desc->file = vma->vm_file;
+	desc->vm_flags = vma->vm_flags;
+	desc->page_prot = vma->vm_page_prot;
+
+	desc->vm_ops = NULL;
+	desc->private_data = NULL;
+
+	return desc;
+}
+
+void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc)
+{
+	/*
+	 * Since we're invoking .mmap_prepare() despite having a partially
+	 * established VMA, we must take care to handle setting fields
+	 * correctly.
+	 */
+
+	/* Mutable fields. Populated with initial state. */
+	vma->vm_pgoff = desc->pgoff;
+	if (vma->vm_file != desc->file)
+		vma_set_file(vma, desc->file);
+	if (vma->vm_flags != desc->vm_flags)
+		vm_flags_set(vma, desc->vm_flags);
+	vma->vm_page_prot = desc->page_prot;
+
+	/* User-defined fields. */
+	vma->vm_ops = desc->vm_ops;
+	vma->vm_private_data = desc->private_data;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 0db066e7a45d..afd6cc026658 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -570,4 +570,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif
 
+struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc);
+void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
+
 #endif	/* __MM_VMA_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 77b2949d874a..675a55216607 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
 
 #define ASSERT_EXCLUSIVE_WRITER(x)
 
+/**
+ * swap - swap values of @a and @b
+ * @a: first value
+ * @b: second value
+ */
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 	return vm_flags;
 }
 
+static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
+{
+	/* Changing an anonymous vma with this is illegal */
+	get_file(file);
+	swap(vma->vm_file, file);
+	fput(file);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


