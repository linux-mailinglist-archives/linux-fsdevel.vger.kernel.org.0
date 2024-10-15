Return-Path: <linux-fsdevel+bounces-32019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC199F489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D865D1C230A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4AE8614E;
	Tue, 15 Oct 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nGzCcGJP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0fGQyNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FC1FAF0C;
	Tue, 15 Oct 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014992; cv=fail; b=XNlFs7fFRbyj5v7zO7VGrjcoKAmkGZ8MRSVqDAklgBJ5GIeAOf/HPefdOWMXUA5TeikqA7aASdXzTwgjCVp7GG4Y/FKxHxVulkHcZ5qRJvMIGxlbYfxuuhaWxdEvA8h2UFt/0EwYDokMJZQIoZXQAlqiuBNAadtMId3UiF/vhUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014992; c=relaxed/simple;
	bh=7agAp429HTlNa2memEb4RZzaX7A692jTSZVmQjiFEhI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FkJAjmg4mnQ+oBOkdNjisca84zZmQIz8L7fsm0yV9sHrdhk5HaaQvGj7C3ljMT+eh16n4mU+//JSpfySQjsX/qTWd/jtwQednhavZPds5X8qaFaPBqXyANHbBeWNXqwlijo6Sdzw1mjG1hpy1DJ9Ez+IgzBaAEmzIf5pHieICls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nGzCcGJP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0fGQyNR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHthpc018437;
	Tue, 15 Oct 2024 17:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=eh1SwKrCEpphFxEQ
	1WioF6/rTLmoNgNxx/xWdW1wVc8=; b=nGzCcGJPNheXgbuIDhinE8OgIu72YSCS
	1VaUqwaaiwsUpA7mX8pjReng6qcKF/89lxy6IwEXomamVimMuwuBMCVVimG4u4KT
	1GPBz3okU1BRlGllIuhnCIkridGZCNGnSJGTALEtwb2I5OL6BkB2TLVuf6+y6X5d
	OVFc8FhX8ywqUI7ANC6iybhuqYdUoJ0GxVZsiLRSSXIMN1raC3AVjmuWR6cW3cMB
	1q7e2Q9eUpxxM8qlOdpNjl1W/qGHTOW/jUTJRDW/+9HfljQw8mp3gmDtIcBGzred
	3/ayrXBhJDZwr/fc0pntmIrke2NP+C5QdpEDUToqF6+A8VIMrZn9uw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhchcsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHmHZw036099;
	Tue, 15 Oct 2024 17:56:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje4qgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLmx4v6iDnvNwrkA1hggoqWvkuqcF8IPJl+4FsgaaxFrGv88PCmSdDLGlk0QE4dw5ByduJHxB59Xf3VtKpHsGLzkiM1BpwHHl0YUSMKt5jcZOr/7RSJHGG+J+PutjSQqi8asHXDr/wMmGoHZ4gV3u1/SawahKDkhScj75oZ5y1+2m+JhO3oE5ewFR4nwRW/EIEvEid18C0GKPTYZRmXpNHZ1IurnH/CBODY5nYLxk50Cjq+p5KVv2w5+gGLAFBrQdOdnMWoVDBJO2NNJGZ8+aryNY7qkg+FWrHGkIGlIWGzKfhJbGw/ZW/oq3SuDOCpyCZNUB9ARpVEDsWde4Q4Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh1SwKrCEpphFxEQ1WioF6/rTLmoNgNxx/xWdW1wVc8=;
 b=SvOlyCh8Bml6xpbSnSSA7YzIyhU9IWtRrDRgIufmWNZ6ZURSCN9U5yR7cetrwxpNbMq0qOrQKs92Qi75UJ7XeTVRgtis6rx2iJ7yyXxu3yA4WNHPTdXoIGYUhSFdVEUNG4gazqnUyhR51FqyZft2nT3PcDTmHiUgbM8rNGittxi6DwQVgpM9tCNpdNhFBs5NIy10MkrWduC+N1hx+biWv0xXYEqJ9IZfjbi2wDLoQXIaSC1DBnpbkrNxiCFCMBVUO982DHj6qFX0HKtkjllTkn34KNVbydF9hgWPyXzcDiyYpZU/p1P4ybunU54mnNAzEKyyV9NNrhN4M9yi2cYwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh1SwKrCEpphFxEQ1WioF6/rTLmoNgNxx/xWdW1wVc8=;
 b=j0fGQyNR6FymtPlYfU5+XsEB7KduMxY2YCu06yh0bOqM2UOZIMZpn9g0KYiqYCzdXoi1kjdfvXnvUrxGqZNKRTCTc48PsGUGtppv/7EnpUI8UCSaoD20gijEilCXYLItA31HRcI395wbWJbuQjA3WERMsmDGOb3IKzwYcHux6EM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 17:56:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:56:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH hotfix 6.12 0/2] fork: do not expose incomplete mm on fork
Date: Tue, 15 Oct 2024 18:56:04 +0100
Message-ID: <cover.1729014377.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe89653-b21f-4681-6226-08dced42aab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2doiZ3ItihxNTXIrGwWM0Fqhwi6S4+kFL/MqspXnZle7RYyo6JTCOk/ASGN?=
 =?us-ascii?Q?BCe4OfypxSBubBVKPKzoFchH7v95m39IPqwGDDB0FTMFNcuciBW0wwLo/wDE?=
 =?us-ascii?Q?vKh3D5YiMTIzHj4HAjlSAGuhMMSjHm0OjPwgdovSVYBU6DqErqGYHp0dP2FS?=
 =?us-ascii?Q?FGwN8oY8BvUht/tr18klBvykCNovKdVCQIAjGqnp0BxRDCn8cVHOEuKr3mV/?=
 =?us-ascii?Q?gtqQ/tOPE++7zNoiGutkTyAUhcc40e0UkoE6DBq4HVoS2bDPZeh94nQSUxnB?=
 =?us-ascii?Q?fnGQuEbrHmlXSsvuFgXnx2eo6ziw+0EqAAcSbAR8KWjCf4j++OgGGhrJgcXm?=
 =?us-ascii?Q?3fl/us3S7JvwzbnIT8b7tIJ1sKa5WkYVzXBbXSP/GfQ8shoAKThggHI5ICZ4?=
 =?us-ascii?Q?XKwGglEeJjnXULBZNoo+bd8FqI9G5lnVV3/25/4uVVuT0qzNn541dy2M9liU?=
 =?us-ascii?Q?B9Z1q0p9gQV08V9gvrKYv/vHQoLGl+3g+TUZJfOUQJIkjN7BJ5nh/Q1A0p87?=
 =?us-ascii?Q?LNLDStTG1kcgI3l23/hlNz99qf6TQs/U8SE2Evd+4AGo4LvjBvvX6WqDYAMN?=
 =?us-ascii?Q?NnR7eZK5LLTcoNMQFWuNesZue4cuyfl69SAQF9hWXQFklCGSVoL1KKzLkuAd?=
 =?us-ascii?Q?I2OqEo++cDTDrHDc2TO8L8Xm0xPRIA9pt1dx93ejIB/RNruEeEXicelYd4eS?=
 =?us-ascii?Q?S2rIYbVV7KOo/O6yhkZC2pR5FaKTC0IISfga1yKCQ3GqeJX9t8FvRAkiQBq4?=
 =?us-ascii?Q?Bkql/OWZxi0dlofc8pntcePq8LZRmoso31RBiyb2pHla4gmmXO0UbRhsS1Kc?=
 =?us-ascii?Q?uNhvsx65wYlneNOoTCLxTML3K50lEsbGXNxNkNl2kQbQ+cyt5TKwKeGUBccd?=
 =?us-ascii?Q?/7LX3NKtaR+nT4PfsjKqm6xBFxvjtaxO2bFfS+se2a4yILsPuFDkhEEnZQa4?=
 =?us-ascii?Q?MIkfJb+crmOHy2qaByQfHPBOWh9GftFWdAtQu9mdWjXaeN0JgnSzVU4hdqAG?=
 =?us-ascii?Q?QqRS5uwQylx/gxIBnr1nMmd4OwrC3gk+gl8tod9Fa23BOI3jSV0aZYipsfoX?=
 =?us-ascii?Q?5UISNmeXNvk+MyAW/S7lQsPl9ZYIdOZFGYjV2GPtPA6Usp5h1NX2Ye0IxR7x?=
 =?us-ascii?Q?J96Rh07hQu0IhDmrQ4Xmbf/UqjspXcM3r9jSb45HUXamYBycvZF0ZwtxrGSw?=
 =?us-ascii?Q?7KJx1kxba/snpILNgHUt5fMlPPQpEPpXObA5I4xC6GNIcgK+a/Z7BMtMj8D1?=
 =?us-ascii?Q?KKfPb0uAU3Nbma0MbRRG80x6QeMv5pl6fp/LNBKaDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSAQnlgI/VND8OAn+UFoeHE3yiQmkzdxSlion2kVMW+DXhzCvqz9LVZu9h7J?=
 =?us-ascii?Q?oaek90nZFXpTeQPmq2Fi8PKjYEtQk5ZHb6XoY0I66QLnEOpjc4nS4Bn+cKX8?=
 =?us-ascii?Q?EpTaCYmDAhcG3MVKW4ayCV3oskh1YeH+y/iuNtvi1IyiN8n8EjHwdkQ/h6WN?=
 =?us-ascii?Q?OoAOuvwz+3pC9Rk6R5an/DyIoKHAAqrkG32QgMac2TBVC1s3xh5yzqXltaCG?=
 =?us-ascii?Q?ixJD89lMe1+1aBV0lZaYaIgfoDA+f7R9NRQvccFwA1srMV5HmgAF7drsouo8?=
 =?us-ascii?Q?Utfbs4Zv2n++gLN54pL6PEaZx2UnQ3t9PAWl/IWrjDsUlEo+iAgq1UoGdnIX?=
 =?us-ascii?Q?r++cOHfGtj6nNddctArJf1elIlSXH/Ds9XemhWyKO6GXJOpL6l8B46xJ8dqi?=
 =?us-ascii?Q?q0uRMov0aoufXTH8I2ti7JeZz3xyWcUv1J6IRFnpwUPpM/UZ5jvQ5T449ZK4?=
 =?us-ascii?Q?SxV7d932oXBsQ7/9mVyAB01KGiq5OIQx3ws24YAVzq1RSnhDpI5epRCHcdgo?=
 =?us-ascii?Q?7SCqmyCZQGan6tYzrWAKQwfG2VXbB/ObYinj2UjJJ8MA0PFW8xLFfr8hj4uu?=
 =?us-ascii?Q?aBnDZkW7WMetwZWo1n9MTDjtVZUJG7RmzdxAojnFWkSHkubGeYzdqNpAPeKc?=
 =?us-ascii?Q?r2EooJRyYUC3QlsssMLh0DOGYPca4QLgBOD7FFR4jVSoouBe8ebz9jiTRSLn?=
 =?us-ascii?Q?q1fZN2GLcb/ElUhb5Bi9XZ6IYsRF0iD8qJm//y7gk/pKVP5MttStLqGTdmW4?=
 =?us-ascii?Q?WMtCCmFB7DvHW52D+yUygZ5QEmRDzNDjQ5JIf0RS2NuSMkgUhgAdIK54sKzb?=
 =?us-ascii?Q?h7intBXHygVMl/70lW/Hq6qPJgPRhD9xXUFKL6OMGYiBpVWAxNxdnjUEBJxM?=
 =?us-ascii?Q?Y3K7p2Bm6tAOucTketWS5drDKFBy4ZY9SJJmzI4Y2yIlA1mTRofds3gbKkgi?=
 =?us-ascii?Q?v/gAyKSTKT6+MENM0R70kt94zLPCfGPj/apBdI/yr8rWBxl25FeWSVXixpk6?=
 =?us-ascii?Q?ge+H6PAT2SRh93LV9Hjo3SEON4fDFqNXYj+giD7qVzHY/giJDkZi74JgD/gd?=
 =?us-ascii?Q?KGyvYOuSuZ74i6SPyadXdN51uxa0VxDtdvypIbNThgOocLhqFARdIH5zE69H?=
 =?us-ascii?Q?huPAhTYKZkbSOLeHNiifanqgnNQ7wnTL85+L4E7+ZiKXv+H0Rbqhw07YWEQu?=
 =?us-ascii?Q?kBnS3gEau3jXtLy6YU4rw3Hd2fPEPxVaWs8XRRVSkkXMKDuJiSrcbT1aPryG?=
 =?us-ascii?Q?owWFrWzTH1HCpF6uKrRnN4pxdyeS41S7lZnTCa7+Qp5ozKig2KoaBA/cSeRA?=
 =?us-ascii?Q?daHgNyxfHLcquHqpZIip5Oh01An3jyJzjZgblBHseN92fmKzOrVJ26DDnFaq?=
 =?us-ascii?Q?rlfLtCQIig6XpYsf9fqtOIHQw5QfJGcq/XUe7D18LBG1VX5sJBl9GheduNiN?=
 =?us-ascii?Q?NqA93D10PgwIy7VqJYMK3bD7mOShhhsfKRVqCF9Lr951XWFlTKzoJuDzBEGg?=
 =?us-ascii?Q?F10XySAvczh0A33RKyELnRSEWbEFxBZEFCoj4DV5aXDAjWToOyA+bc54SSfv?=
 =?us-ascii?Q?CxYmA27Y8/HpSXtjqKxTD7IPekzqk9M80WbKuIhnDqh581blJPvPyj1mloOF?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75OgJhx/WJXPEoMIJkbdMY/UCdbuzo1Hj+nue8Hb1R7rnk8HBOaxqjOWJfvzBJIk4pN9ygdd2CeEEPZwwUNhHF9KrmLRzacTr63NISsTYP5pWClbYFaQMt3U1oHYeAhO6Z2QDrmjHgYerfrC4ucxWN1mqEO4oViqlA51Yq6jMiMS65CwMwSn2W7YcpCN70ygC+cOBe0qzRRGlEaJxr0biXhxMfJry2ma2298coAabs1cxU9cBytwxPThEl3SCiOVWVfBnCIo09ouBxgJAIRmROn++vGf2IqXfDe8AnrbKUqvp7z6eq2P50ak+FWlzunDVmKE9bD6sTH2avk0MalHQCtEtIKbuXtb8cgtiY/6wEeKrrkC06hY/dBeMA0IXzNxuVr9fjiDRO4YIIIxqUf5ar+JlG3CFPSbgI55s2dX6XodrDVrzL8BgzsbE6aOVqJsq7pnF/C1QeN0qft5wnub1E+Hys2U2lyS+8zxPAIGkNXfi7LOQxRiquFJBzcB10M81Npx4mQDZvn0ZICBWYOHD1xOAOyijl+6uDAihQyaaM1ZdrZD36mT1plqtT0BnTttb9+tCUAfhrsQK65Ge5NnlOFXxc9O2eoeh7ydeyHbtTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe89653-b21f-4681-6226-08dced42aab7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:56:16.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssq0GmCWU3Ezc9sPGVJPMGpaG0t3mmoxzrGCvKLO5A+FQKuQ5mxnWO2X5zPQfWCjTPvaVbd1AObz4GnDmxPhC11VONGxS/d+MD3JBTZci10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_13,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=987 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150122
X-Proofpoint-GUID: JWBUJrH3Eg70BU4KmqtXfho0h3per1Iv
X-Proofpoint-ORIG-GUID: JWBUJrH3Eg70BU4KmqtXfho0h3per1Iv

During fork we may place the virtual memory address space into an
inconsistent state before the fork operation is complete.

In addition, we may encounter an error during the fork operation that
indicates that the virtual memory address space is invalidated.

As a result, we should not be exposing it in any way to external machinery
that might interact with the mm or VMAs, machinery that is not designed to
deal with incomplete state.

We specifically update the fork logic to defer khugepaged and ksm to the
end of the operation and only to be invoked if no error arose, and disallow
uffd from observing fork events should an error have occurred.

Lorenzo Stoakes (2):
  fork: do not invoke uffd on fork if error occurs
  fork: only invoke khugepaged, ksm hooks if no error

 fs/userfaultfd.c              | 28 ++++++++++++++++++++++++++++
 include/linux/ksm.h           | 10 ++++------
 include/linux/userfaultfd_k.h |  5 +++++
 kernel/fork.c                 | 12 ++++++------
 4 files changed, 43 insertions(+), 12 deletions(-)

--
2.46.2

