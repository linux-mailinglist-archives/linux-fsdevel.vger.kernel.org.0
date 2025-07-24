Return-Path: <linux-fsdevel+bounces-55928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B5B10301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F91188540B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A1274B2B;
	Thu, 24 Jul 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AVX6Z+S/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L38nonaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222282749C0;
	Thu, 24 Jul 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344776; cv=fail; b=OaWgZ32FB21tVBv+UoO8HVlJ/o3e7b5n2mmL+B3OeNt6G0BJ9eFEGnI24CFYuonvUTJRsdBdNBEWE4CF5thgC4M06L4fBxJw6Dg+bECWm//jV1D3A5wpO3TuzyA1yoWU8us/h99y399xV4KMQRvhRYsOnKVX/nmKTO3ZE0oy4kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344776; c=relaxed/simple;
	bh=E9RQDaxbKiZMps8xDnQx2hZ869Uq49DGdglAL+dV9YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKKBUcmGJSoLxUDvhv3sovKE3q7Lk6xVvRnVVADXzhjfeNmd95omkD4co4KNtgvL4YmUm56JXUAlzJZi+9jPQv26OlUjLoePEEHyadaMwyOFW4/gE6PmXliagJSGKtbf8qJmKU4P8GXUfzTccJsVvG/GHSDH1CNBFujq4xQi4FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AVX6Z+S/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L38nonaa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6v17C003882;
	Thu, 24 Jul 2025 08:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M5eVtfWqwxraPDY/rhe+MmSELT1iwW3OJDiVipfJDKM=; b=
	AVX6Z+S/V/ooV/ejol1PVcbx6uIoV/mNtrRNvTG1v971HcVH1eCGoK9GViIHRqpL
	QSReCpxJU02dtHKB7a4JzswAaW0z+YO2PVNWHFhU3ZNI/zrBM67OYvXQotjDHTDr
	tmp0cdt5uy2xFwriAT7MyOyvaUc45qPElUqF5hxKafAwojZQFn56bT4gqnKAGdVZ
	EaVbzjCLyhYbK93MbFEvfe845Evn3Eicyae0RCamqgLmoY8vpZE+cuh1ET2VmEsO
	+NyHtALsZSp7QprfNiOSGmZ9QmezkQ6NAi8piWmsZwj17SLwIy+g2occNOljll8R
	KIxNwqgDpg828wan7909GQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r17vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O7IQ3k031428;
	Thu, 24 Jul 2025 08:12:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801thw688-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RThpGH3wMzX9+xtIzdhYCiwdnIaxwtfeyIYeg4kRrisZHctljDTdsUsP/QmwpKOF+hTFe89KaauWRQuSIPO2efF+O3Ekc/2gyXvrN1wmKKBSzDW8beFt6BivhwvnAHwFmx1PU6EwTywD7nLRmD1XPHmgPMNE/XO97xhu2FZCpNZjOjTKCp1BSJbeAos9Bd0Dxwr07gZ8eb1F8Qx4oRcoejs/gSxzVpI1MKrd62Ylh79ALvTftVIED0CW6zaeDpFUQV3hUfSGnvntASGIJtsf7vLzLPfRJsEdWk8ceFc+kluLHGaWAOGoMcqxisnKv8B+Gq7fF+QOnZPJWXlYjf0JJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5eVtfWqwxraPDY/rhe+MmSELT1iwW3OJDiVipfJDKM=;
 b=NKOcyELvtT5O86weJa23jpsWePg7Y5diJHCPdxNCYK4ZBjrRyKBtsxRah1VWQUeVMXQC+h9sz/b0T8xrJH/CZmBPrTuXznc4VNp3vBy6BvCTtUqQEBPuySlb2Ls8vhbR7KEurn77wHpsZH+sl/ZAPiaJE9NApw9voHu02ZmLf6pew3bVk78TbE8zao1eOxygHsW03Hanq7jDVy2QruCuP2bQ2rtg3iRXIRH/GrpSOnWhujjC/rHqOVpfru0ZJga/0Gi7gBwn8fa7+shU+C1Vi8+bzf09HAspO1WIbl/lXZjBQ4iY6Y6RBfP1eVhIsTZefVIp0ha6jH1gdGGGxUze+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5eVtfWqwxraPDY/rhe+MmSELT1iwW3OJDiVipfJDKM=;
 b=L38nonaaip9uvV4Ifows0WUp4Zce21Sm5vz11hP1OLB4B/s0pfhXM4IMXaq5CCLG/FHkSr+LuTxnklk2svS3BOkmxJLzCpFUTklKOy5m/6SVNToqfKXkubTl7tvt4jVmw4SgmONMCmhcgzr/wCIkzPN8xWkLhK78NTgInTl3KYE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:12:36 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 08:12:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/3] fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
Date: Thu, 24 Jul 2025 08:12:13 +0000
Message-ID: <20250724081215.3943871-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724081215.3943871-1-john.g.garry@oracle.com>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2b) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: f87b9187-06e8-4c92-9bf2-08ddca89d926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FGNjGKags9QJiyenb+Wi2+NasEVDU1WVzxwotQHzjvTaRux6aG7aYixOEujE?=
 =?us-ascii?Q?Ugu06owuUNiKvIR30RQEU7YnxxVSbH51S3VWi3lpaRfVroRIdd9QRYAYoD4X?=
 =?us-ascii?Q?ck574njkoMM8yPyghnYhh79WE7gMh+c9EyCPHfZY+DD42ICy56YTaS9cVkCZ?=
 =?us-ascii?Q?uEBTOHJe6h9UUCpD7WHRlcnmjSYqjyZZ7Bt7TVNF/D3NeneN3+0/DhtKSK7F?=
 =?us-ascii?Q?IzhEj/UhH4e07vFLeRqrCBiPIOCDGBtonf4JF77u9nPfbk0lyNBaM3Jokqud?=
 =?us-ascii?Q?r+oGN+a6MkmoN7090A6S5f11T73eOVDWr6xDdgYyq0Uhde2cLR31s+iAbjGS?=
 =?us-ascii?Q?5ZzHft6lgPLbukovMwszMhVBgcfBma4UNRLRSLdLKb0Do/371Kk0DUEDB3iI?=
 =?us-ascii?Q?LRHcyB1r0A3N60Bmd9vJqoVqBCQVFiYBvOSFVtdGrN/sVBJ2S/bB+ImZHQdE?=
 =?us-ascii?Q?zPSV4e7+/fR0r89jXKWxjAkBcW4Mk26l93HTEEJQ1rggNMcVifuERUtlFVhP?=
 =?us-ascii?Q?ndyN/88T2eFfzwDHMlQlHxPrvbzoHk8T4seRhA9j+HqBE12v4LDVkQCerB30?=
 =?us-ascii?Q?S2xuMvC637cmzkc4fvDbsfrT//ZJIuwNeR9BLAQbkkEizzml+YKC+w2Lo4Gk?=
 =?us-ascii?Q?qB6Oe1q436Ggho20igM1xwm1B/Q5CPlpNLYfBU5xvbcX/2bz2iSUdqYVs9er?=
 =?us-ascii?Q?KhhH0BcFEyOWBxCB2fHyR+U0m0m76sC/ruZfDNnDBPNZrk8qHtV8DpdTgcYO?=
 =?us-ascii?Q?LXdGluMcFMnrgArhXGYzOO1q2Y5f0sCjYvmr6qhQxfpiaxiug/BpM9JI81xc?=
 =?us-ascii?Q?F+KUUQc/CmaNZETTsH1Q/9AnUZKOZ2RO2N6YUNgRyThSVBEVd/W5d7ft0kWi?=
 =?us-ascii?Q?K6p43lDKPjQN71BAWODhPXlZnAG7YsYeK5ppWTmPFN93dPvm38paF9oNOiW+?=
 =?us-ascii?Q?BHAZ32HW5wlOnmLOzcU9hI4ARMTBkNMKYzRyvGfFp8h39mEi1oAUC73O+EOS?=
 =?us-ascii?Q?fE1zVrfgtShd/DI88GkOaWQ91RzONpQLbkss1TEo6HB19kzWdPssKoyzOCIx?=
 =?us-ascii?Q?/vRc5mnoLAFB4VcpAtH5Jmdn6g1XkiSLipqcFUEiECCx5w2lpqF8keyxnYlO?=
 =?us-ascii?Q?reqvyrl46by9NEJf4JLuCisMtOo4jw1Ru/p5RxiKKI5HcM2/aJTMNluV4Yyb?=
 =?us-ascii?Q?lTpoOBaoqkJtexSF+xO8LxnIOq6e7yxTPAVX6X/F9xMjdyTmuju0RSxQno/V?=
 =?us-ascii?Q?CItQrMh+7hqA2sOGh9QrXUynegXPGPEvove5EuY9iWpMIPGjsVsP05AYX8tl?=
 =?us-ascii?Q?kNsa/qXxkfT7Lk1ZiEXSOCjyqREbrivk1VNcVvFGmTDoCDXmuCeCUfVxFpy2?=
 =?us-ascii?Q?NLYSiEQQVduM5Zbzz6su95ZdTlMH/KiFgzrBPV7G8ts8zU686Guu++bBL8YP?=
 =?us-ascii?Q?G82isXREr4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9UPbuR6Fq2bkoKm+jH8q6trtbKhNa6yE568DMQpGmw787y5YtHcgGAx2O7B?=
 =?us-ascii?Q?i8F/RprCvvsvY7yTPPt0WSVf2zUYreXumqSe7peZvdvPPhryeDZZBm1KQcX9?=
 =?us-ascii?Q?60Sr1yXoEqPuMtET4HVQz65PnqO3mh9Ow3eBA0O2t93LUDuMeUeFuV78OhEm?=
 =?us-ascii?Q?3Pgq7+f/bVP8U9sO/cpR6yNLR5GWMqnY45E5C/kpnptZS6skrCL0uHpOnjas?=
 =?us-ascii?Q?d6YNv3jdZVJusjIfoLEeQVNbROjAIwTaUm5Vk7JY4Gbo7NQxSTv6JM4agtp3?=
 =?us-ascii?Q?u67PJVnXSyVxJolEig6DQk8ZTYY/r4GsyzsALhpt3Kze9HRRxBsaOb7uZihF?=
 =?us-ascii?Q?coXVL/DnZoIKrcgDwbG+AyerMAZb+1gjpEFg28qkefn0ojOECMf69qj8hAHY?=
 =?us-ascii?Q?mqZzrPEGsMvjJRo7KnrhiJPE4BdzzpXdETJc9RqHIRGANqQAqHlnphD29NJ7?=
 =?us-ascii?Q?cvM6WQ7xjcoY6AtaOIsSrUsXrujrV25UiK8S7ho/0arxYyjja98wcGY7P49Z?=
 =?us-ascii?Q?bdESTI90g5oDTAeVKiRV5g0LHvIoHoAXwV6aUpD+MwKmUVKfkvwx5HVzNgzH?=
 =?us-ascii?Q?nGaxX6KnNagFYfas/SToh2JvZbEyPPkB6/GAJzsUHI16SOheeOLcWycsZEX6?=
 =?us-ascii?Q?CZSA1ARSV2GyNp756+c+6iaopOuXS2tfIirSGbXWqAU9cWyZ9cvLcYR55J8b?=
 =?us-ascii?Q?dA/Rjri8XE+79tERsnvBvpZ7HcE+Kr2UDyNRJ7bybduchhHvAls4+HMb9Sbe?=
 =?us-ascii?Q?X+20aNiMGvb74sjQW4Rzai0DwtBCELrL0YexLCo5nQsZ86UKroKBtnHO95xO?=
 =?us-ascii?Q?N5YGH69uic3n+tRDB758lkaqZrIow+tsU8Rwj6IR5bNYUQ8AkFgEZXXMFXll?=
 =?us-ascii?Q?th0ipDpIesFPDLPgi84MY054PHfEjO4cp+X1nG6TAJPx39kBFyMaMoQF62YS?=
 =?us-ascii?Q?Xdy4fZ45IfkgpkXpHZXvcChoyXsu/u5nd5UX/YT2VZiNBq9qCeWD3VnbTL2Z?=
 =?us-ascii?Q?4YegabJIEbEcOI9yac5NeDYDnvXXyT/KtjbvDAIBf/8jNm79wMjtpHgwfoxb?=
 =?us-ascii?Q?wLxvALFnIsNolfjHmS0GBKo3S9/c6HzvbF07kt1D8q9a+sHIwuRloziFSzWu?=
 =?us-ascii?Q?i+is+gi0Pew9QdAR67d0+i0YVEYXRZl3KRJ96CkMBxuAtvTN++vO9Qud7Qo1?=
 =?us-ascii?Q?NgD5TdM8fWHFhXkFguTfugs+58DMve4XbkpCNq9zWgpQ4aCWf6eZ03FWBvvm?=
 =?us-ascii?Q?p7Cd5gZIyzz6f8mzux7VO9sziqdHcw6SILS7E/gDqfHP7/9SXmY+nmg+5YTX?=
 =?us-ascii?Q?btNNyfFvbNCNwHSczgxIUHRYUH9o7xbLTsgmLHdCMQgR19IN3tR0iZn7WrFn?=
 =?us-ascii?Q?2YMC+0vCZ07tm+H9yMRYQ2USAI5jBrqhaeiOotrco4WY04bzFZp65D2fh970?=
 =?us-ascii?Q?Gg6q+ah0dEI5AAMi1R3z/j2e9EzzJyPPT/LT88DWzDipl+VQbglUu82Rr6m/?=
 =?us-ascii?Q?Ewbr400TOXARmuhLns5BImFdu/ML3sXMC4XZLM4RJWLn0tgBzB6emXA+1u0E?=
 =?us-ascii?Q?c8ZG3TXuUo9RlXEBq/UseCc4J9Rj/eR961NlkLD2u2Ad/58Z5peb4loTqcAI?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	blrvkXk+MmS4mBODYeTou0bvNSXYduIkTs3soy1ZmlQT6w/pmxOO42N8x6jtq+ZXGxmxtG7pzdn8Mz9NSK5sIsoh6OC2NmmsRGx6pjFk83bJqneb/ntmbtGf///XLQW3e6tvIoj/dYh5tYbv1ggOqDHa8XpYwfMITs0oeUmVHkVH2DktHiJPfI1AQBAcjxkhcnnCCcRwYTwp/mhKUkBmJKYkk1+4ihVhkclqgC1BPwf86FVXa8VCPGqiBoizau89XNMVohqKT55g3WKEgKU7Z0MEnI7KMnA1D98cKitkBbfqPdq7cBSZTOzrP1zvXmSLuPqPlq020b/dMOZKJ7CcpJLTNVHGVDo2tWRRPLMFnAxfCEkleF+ky1ipIQFk8bQD2wEnDX3yDmlVaK1AChKA90Iu398gDjAmtRC7lMtGWCbant8GgMXa9gFMdXUIaayy530G3c7Ayso5uDu8+WZGqfLk8BvSFzasctpWVhmvcN77VU02A4fKHsVjYw/UDWRKXJqR7PwmsMXqPZ92N9gsq/VusBl6WLb4IgOC9G8gGrOulFIOZV6eNDx9JCcNNlxAnP3q6RdU+bXmSwmSPlLD4hUdqlypi9U/J7qt1yOoNes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b9187-06e8-4c92-9bf2-08ddca89d926
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:12:36.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBu/10BgrXvB7VupsK1l3cTkLVDIK8sTQO+Wqxlwqu5O7mpwl2Q+D4fH8Ns9fhjFbWVAMLWb03mt4eFojcjwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240058
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=6881eaf7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Lbvx5G-rTOA9Ff6O7RQA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: FEU5XnIiE2YqiuRfaflJVGfO33aR_6m5
X-Proofpoint-GUID: FEU5XnIiE2YqiuRfaflJVGfO33aR_6m5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfXybkV0PwBjsyR
 P7TLOAp5lpUCu27tiI7l3oeKMiZZsCAOac/unjUos2FzxV0LH4UelRdd5NlE1Ul2e21KRnGzQM5
 CcZpGRRJvJR2opXdPJa3u9Dj48rz6nw7sO8q+kp1GKGx/ZL578wiW3GSVUrCwoqyHxsjSIZkMWC
 aEhx9ADVnAWfpuGFPB+zMNNZEJiYksor9zWEl7jNJtj92D2oxiZqkn6PvKDEomhYc2UPwMSEj2F
 b3a6Xgtu9yPQXKjrI4e9aZm2u1Rt99BnRBJcxwoY0tj/H6DkFiVeZ0IF3s5LfvPYd/zDhAS3Dd+
 3elUJ92Y3fRgxgCPEkY2RPNoxMiu0zhMY3EuAPX3orFsNhsTDGSHzesD2iIOCWqQMpDbwhpMDki
 s19KV+0/T2LBxptRt/9wkraT3ohOr5fkTOO82x8z8bdMDyfaZeg+9UgvOUiUjDSL+OUuP6n9

The DAX write path does not support IOCB_ATOMIC, so reject it when set.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/dax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index ea0c35794bf9..d9ce810fee9e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1756,6 +1756,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t done = 0;
 	int ret;
 
+	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
+		return -EIO;
+
 	if (!iomi.len)
 		return 0;
 
-- 
2.43.5


