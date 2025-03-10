Return-Path: <linux-fsdevel+bounces-43662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3DA5A340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C8D3AB58C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39209238D22;
	Mon, 10 Mar 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LskG9Cwt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MhLAVyjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FF23875A;
	Mon, 10 Mar 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632021; cv=fail; b=SS7PDl8wOv04XiPHgRBOwIH9ty6Iikg3ZD1lva9W3ZH0AF/G1zG3q+sJBFFk6KFniN3ELuIzAfjCxheuJRkTNo9wGmLxjF2Oeyf56qZ2KDyREYZDwbBEYl91P9Cdyg7fkCt16kHkAtntspLk5gXHgR/L+sE1psHsLih8L37nAo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632021; c=relaxed/simple;
	bh=Vk3kEJwvRRts5CDe3KE4h+E5fMII4O7Hyql2/X61jZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPtga8ECbEuuFBPHCjP1H38/ATYezBO0jjJYAVgxuOvUaZKIzElf30LEh4dMV2huBgWjFZFCIprHsw9O24VVST6iNkEJ45vsR9RWOJ2vGbYLAm/B8U3WvE/XP33pcVWdwT2HUZLPuXCL5SUleD70V4X1Ffsru4khmnZp09M9uDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LskG9Cwt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MhLAVyjy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfiok011056;
	Mon, 10 Mar 2025 18:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cHqzE8vkr9dOlODE3rzDONEwK+qfjVHxRVzHfdRtZVI=; b=
	LskG9CwtlBYxfOoxCgqxwo9SKYemBPqaaQ3LutmghybDwb0450GGRLjPZ+d6JsqR
	IU08KR3iFYrky8Is+YfGragylGYNGGML28Gr7SrO0WRx1C+uZVOyZOx2rPFBeLUN
	ixe/wq0w2MDb07Di0MHgXsJJtVhVh2AISnLB02GjzfzF+UqrVm/f/pBYGLpMKJ6R
	VJBwxM221BjpoZdW6SIxAXOVWVSn6WE4i6Bs/OPHbTzI6whr04yL4UuHSpeampZN
	TDFkLtKFtnIox2k2HIvDQiuHe2x3byvJX0xs/+LS7OSbYwrGbi6tbk+mjxmKb36U
	fKCst2CQmSQXN4nJIWNqLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu39ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AHIfYc030585;
	Mon, 10 Mar 2025 18:40:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmc1bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0tpU6PZMZp2jknEvjwmDixHVdkysACS2HXF0PgWBeJaS3rpTnRaz+h0ufP3eEJ+QQui+1ms3eq0LQuOfntyYFHy97bzE14HAhWHaTpi4qbxq0th0gtr0VCm2RD7iBH6voXjg5Dlch39sbcu1XeS7dJSh5GgY/p7t/9JfqfIairAc6CWPvuoAvhV1VqBW/qkuQDjuE1pcM3J1ACgnhuuOuHpw8voGG11bG9AX265zkEl6Y3il37yX+906ux0iaVLxaQ0V+dROUxGWgrGeRL4WEWo5auesENaeX7oB5+FANvgdObPhb83QU1xPdKOBcpX3Uxb977qSVXYXrTQSNpNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHqzE8vkr9dOlODE3rzDONEwK+qfjVHxRVzHfdRtZVI=;
 b=wHEtMUdusxPBiuotDW9/z973t9HO9u8oRdjgXzyemrQKCbIfHunZaE4xZS6gEPFr1SsCPWLDlDwwtu1GN3Afrp4ldpA9e5FzxlESiZpkcOU6m5A4ZqQqrpVuDcYoYk4k1kD53bu6safqrV/mI+5yloXv2joYWqyGmE3DVTBKdNB/YBsxc0r58+bW94l+D0rssLYurXw5go1IH4vtQSN+SMfm69Wu8X6jMbnqeabdmdpc6hqQ0X4XtdtJ4WM3nYDZNlPE3RkEorkK+smlQLxVvpMEIWvgj4MMc5ZFsSo7fVgUiYQiFMSm13mVmfKfG4j81f4FKAct/IwiY3foCtU6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHqzE8vkr9dOlODE3rzDONEwK+qfjVHxRVzHfdRtZVI=;
 b=MhLAVyjyrKn/iK392K+NReMeU6AA+Cr1BiBySYnDGjEbWonFF0cLqJZZo39v0YJBK9pZLAFVjlEgZafQd9wKRhu86TuBSOGhGtouCa3GD/GfXYqAubZLwBEyCFeL/RC0xi9BLYM58jwYvM7FJ25VQByFom9HNBHfPgUlVlwo7gw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
Date: Mon, 10 Mar 2025 18:39:41 +0000
Message-Id: <20250310183946.932054-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c7a028-2bc5-47c9-83b9-08dd6002fd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8ccLJUSLXFY6VGgHQ44smMX6p/g3+o1DTWZtlbLyFx33XsBalwTXX2vVVy4?=
 =?us-ascii?Q?zr+JMCfhocfgpr5gH1OK4LLVhmKW4OyM964KIYIYshttCQDi9SUyNzNHVSfA?=
 =?us-ascii?Q?LWPFL+IpHH70vQPTdGK/Q6/1riOj9mSe1a1MseqWI+erIvLw6MdAiUW6kE7h?=
 =?us-ascii?Q?KC9xxH//FdnQlhCoXD/i4RZQSpUSA7YbBTg8D+3Ohu6wMPM/5MF9CFEv74Vx?=
 =?us-ascii?Q?5IwQJW/HHd4322U9URm5ePBr5abYQIH27uTnPxs6N5+tCMKwpiLtl334k4Jn?=
 =?us-ascii?Q?OGXkD2OwdSscO8d9KEKmpTKKFZZj8Ii4lO/Fv5O0h77Y47x33A8KUcGyb7s4?=
 =?us-ascii?Q?5+XVlMSMwy+XsTwbrF85RTiNYJl1gbRUmr9xKRys2qKpRttgnrGf3LpFB9e/?=
 =?us-ascii?Q?Rw12KIHGnTxp2pEEqbBMJ5UAVVFhzB5w3C1rHibwVvrXLHJbgUqHONIzPAB8?=
 =?us-ascii?Q?2foT7gIl33BzJtsKIaA0LIYwLiahJ4Guj1hpZ8mlaZhIXwYqleoJQ1ydVcra?=
 =?us-ascii?Q?o2g57fnYRBK72XLwymelBM8huGdaI88hY4Vqeda3Mc4+RHfQUD1ScDUcXVd0?=
 =?us-ascii?Q?scYC0GoWGXCZnO9gzRBDBp69VqzsDMtu+ER272Rvhdy55K3z1eN0hs7MWFEt?=
 =?us-ascii?Q?fC5Orq4DEg+T3zGaEoQMBYlEfqk/EpcyhvrFs9MdfZ4gJKm1X5qlARtXRN+b?=
 =?us-ascii?Q?Pg78I/vu/Ea+P2uaJDRGPF186K2bJL+wu9qLoLMcuPvNjhlONqu2cqwO0GX+?=
 =?us-ascii?Q?yBjfmDnmXAvELJDGJinCUWh4ePHj4Ei6LoPj7AiLkLF2ImWkgvuogvN3COwA?=
 =?us-ascii?Q?9WN9ZYJBV1H95LXiIsyxLqK01bSPbI/Ck5Zt1m/h7qe20k6Jh7RK5Mg8pLYH?=
 =?us-ascii?Q?COUVdmIbYOPr0MsBzBhlhQSXBNdMMU5MYqcKsKIClpRjaMOO9tTF5CVCrPMo?=
 =?us-ascii?Q?FNEm931PuTX2rgoWl+t8OX0dbPd08D2sEqRUam7VvIac6RAF0+ug7Q3+VHbb?=
 =?us-ascii?Q?lfpdGoroBLwp9ip3PgWfMpqy4g/wPK9tgVBTKiFr/rqfY4AAs4Yu7Avg8bIB?=
 =?us-ascii?Q?Y4BtdYyxAZIWcsKEuWtm7t2YLhfHgb+fNu3KxqVD5de6HlUZDSiKuUTZbb6R?=
 =?us-ascii?Q?aeoXLiXddiCJicTIAUCmbG45C+5YAH7m4Z4NnNuS9v0dru/t4WVqclnAG7yO?=
 =?us-ascii?Q?N5WwVWwUD85ASN0Yo+kKRpEVm6+oxQCMKzM2dgheyNL0283cJNYCxm7Jzvu6?=
 =?us-ascii?Q?mUhyT6hwXGL04AxeqF0Q8rXN0REMVJB0MOel3x3qDcDEykzNOqzYmHXOO4zm?=
 =?us-ascii?Q?dtv57VbSiV3SZJjoav4b4Iud4217BbK63xTuG2LDPmX8Lba4ajhLjH4EaDSc?=
 =?us-ascii?Q?oTFjqUwyqyjmrs7ZlLuhD0h0DykG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KE9+35mxJEqMk9IKSGC7LpzGUifPaJI5CNYP3nCoC5/eW2gcmWOk1W0/TSS7?=
 =?us-ascii?Q?o/ujbW2JUe4Gk33wlyDwN8Z9+dYctetTGe7PwgYFi5tlZtQmjavdqj8CVUAn?=
 =?us-ascii?Q?V5K+ybwdvEobIzK8NLRVwofR/shmH4sVnJKEVwemUB4604akZUER1iPsPXRc?=
 =?us-ascii?Q?wSw66JRcMmlQHilOkMDDCGT4p1moV0Xmr8NCQN6i3/lb4ls9EZnoTXOf1R/G?=
 =?us-ascii?Q?VrV3E9DtlPa8/JBeGEjx7orpSPxKCPswQkvUs2xGo49KyPBOQwITgtrRuQqI?=
 =?us-ascii?Q?/AFejcgslOe8+K8joV8UxFwJOdpQyP2u3ZnghvEsISRwyfiplwg23AZmqMqD?=
 =?us-ascii?Q?8sCtWRig2Ej0HZN1y5rEdRnAWWk96PCNwxMBth09d34EFyNJT8idK2S+loNS?=
 =?us-ascii?Q?twsM2MOhoE0qSWFHSMG7YUXShfAydONOG2we0W3dfGa7sk/D5JGmKSdm5cHb?=
 =?us-ascii?Q?zlXpm5/eNiTsw0MUf84UEP7jme6ymCfTEO2splFf4d/qDmHtgnYpNbL4isAK?=
 =?us-ascii?Q?VEK4pF9zvI+58s1RLHLnahps7GcNHxSZaMh0NfJ6oTewaebvC0ezlMbxgTgi?=
 =?us-ascii?Q?aHekx58dCCM1NzxQAG5PUfP+F09f8pa4btcJokoIPdgbOzL7h2JDnvVW6teX?=
 =?us-ascii?Q?HHr7dMJVPpfi3OSWD/0N9PxGLeJVUBdxg0tSijGqkYoMW2PjB8BJnuwCQwHJ?=
 =?us-ascii?Q?Nc1BHuMCzvGTibiFKqY7CeehdCf35tRadIdpAsOiDz27f6ApPT8B9VafMvD3?=
 =?us-ascii?Q?5FAXW4TMEeZTf4WJW6ujv/OvH3dqSk7L3ijqHdkXHIrpdifcrMvoFQghYqla?=
 =?us-ascii?Q?aouy0eWrAfWx9U0VO3xUhcghDf6rsm+kvq5NmAXNY54KeZMmXNSBGSfNsqeO?=
 =?us-ascii?Q?BpR0QcBaAGaPLYEY/cLrba0phVVvNm1xnAUG0WpNKpdYrPc9j6CnPcSY9wCu?=
 =?us-ascii?Q?GYHY3TShQprErq0Mf+wisuPMhnQhp1QJN63r1NmkGJq14Tol/Mg6b1gP2+93?=
 =?us-ascii?Q?EjQVxMk2ZW7psf0ubDbXlYNz4eEoQiKUWk5CXllu2XrHsXswbQti18ZL4lgO?=
 =?us-ascii?Q?5JNGkjZLwP742K5S7cmwT0i3wwKro4/y9yxRSoceB59hIv33ZdDCin6PU0gF?=
 =?us-ascii?Q?eR7P/DRd66GcSWN548Q+BiW+bJgTZi/z1MEkBHPo5UQy3Uk82Syrl6Mfffvq?=
 =?us-ascii?Q?ZB3F6/ExxkZoBE+n5L60YVjY4s9GFoRfP/VS3tdiXyXnZrh+ukRvaA7OigNs?=
 =?us-ascii?Q?GsqfbP9dCwIMnh1hp/1Kju3NDIF5iOtTu+QXsXFgkEwMmZ3kQc8WxTSNGag1?=
 =?us-ascii?Q?aTWSzZGI38acegQvntP+LwMbK3O7C4m1Gr0+0E3Mwy7tQ71i1+N4uFQw2FYW?=
 =?us-ascii?Q?wZZhCnxEMixqYW9tWgpW6Vtx5juVU8WPWYBglDY7vegWn3RbwZCqSj+2m2cl?=
 =?us-ascii?Q?zCP/tEpzy/sZcjlNBG/RU5yBPYhrW5oO5uZNxgtYRE+8OiXCyvU35p++vlOI?=
 =?us-ascii?Q?ZcL9fd9FoRZ2NNnhGuYWRS78F6cwSOA/cTqy5LAJ/6f199VPqDG6RtO5o5et?=
 =?us-ascii?Q?GM2Gu9sa4G+nHIAP2y5gbwc49+053rY5BR8XOdNA9xSNDdUXprNK+muBLbWT?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Or8/TbwyZ/aY3qKcctCNnCMmhXagYtQsjnOxTJpcN25iWM3O2MSxguNnvfA4Qztw5apcKJiYosa2BrUiXs4l6MU8E/4HETLI4UsqzlXnvWWF3Pi2YrJk3wpj80FUyYfZp14EtT0ogj0mOaGzhd6o7Hs6kRpkVSFwjdWU5N8saB4PIRHRfczjhywtc0fUYgVUKd0F5IIwedtJ28tNEMKmHZK5jiUIimFMBTALGlWesjBLPtCezlYOh5vDxePZYlt7VbEDwxJYW3c2pZdnXRj1Srv0PybrmCKQ/SAffQ6i6M3uNqGZiHKsVhXsKuB60NNpJZKvTtKWiExKicMxSEvcOViBQH0L2E/qRCsl9Oa1Sx7NAC85vn8k9tGbSK1AoYZN7u5Y4Z9cqRjvK0FkIBZomiMwpvOn1mrotsQJga2nhK+Yv0fvFDN0d34pM/jacCJBV/K45KGf+wEp9MGf5oAQSYzhuF2FpU6I9jxA38LNBqwKRzMgQ9JSCCZBjFcIerb1yI3g0bBY3688HKNk0VxCerkcRzMxpMVDslRoO+127IA54jTZkNcD9N9zuMsN7KskKOmTqhTLweZM/x1EP0/8uWpMUdpGLoYnhEKaIoRVjoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c7a028-2bc5-47c9-83b9-08dd6002fd0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:10.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3IF+wxncA0qVlWlXrkxRSeWKwsQ7IRFLKvpAp1Tsdd7HqKmH9h+MXLW9mT+CrJ0SYEIPdAJcpcU4Altd6iFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: 9U2-mFLLfEE1RkBXUWIrigx1RCkPmf5j
X-Proofpoint-GUID: 9U2-mFLLfEE1RkBXUWIrigx1RCkPmf5j

In cases of an atomic write occurs for misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regular DIO writes are handled.

For normal HW-based mode, when the range which we are atomic writing to
covers a shared data extent, try to allocate a new CoW fork. However, if
we find that what we allocated does not meet atomic write requirements
in terms of length and alignment, then fallback on the CoW-based mode
for the atomic write.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 137 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |   1 +
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f3a6ec2d3a40..6c963786530d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,23 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_valid_for_atomic_write(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	/* Misaligned start block wrt size */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/* Discontiguous or mixed extents */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,10 +829,13 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
+	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
 	int			nimaps = 1, error = 0;
 	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -874,13 +894,37 @@ xfs_direct_write_iomap_begin(
 				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if (atomic_hw &&
+			    !xfs_bmap_valid_for_atomic_write(&cmap,
+					offset_fsb, end_fsb)) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (atomic_hw) {
+		error = -EAGAIN;
+		/*
+		 * Use CoW method for when we need to alloc > 1 block,
+		 * otherwise we might allocate less than what we need here and
+		 * have multiple mappings.
+		*/
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
@@ -1021,6 +1065,95 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_sw_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_bmbt_irec	imap, cmap;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	int			nimaps = 1, error;
+	bool			shared = false;
+	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u64			seq;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_has_reflink(mp))
+		return -EINVAL;
+
+	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	if (error)
+		return error;
+
+	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
+			&nimaps, 0);
+	if (error)
+		goto out_unlock;
+
+	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+			&lockmode, XFS_REFLINK_CONVERT |
+			XFS_REFLINK_ATOMIC_SW);
+	/*
+	 * Don't check @shared. For atomic writes, we should error when
+	 * we don't get a COW mapping
+	 */
+	if (error)
+		goto out_unlock;
+
+	end_fsb = imap.br_startoff + imap.br_blockcount;
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	if (imap.br_startblock != HOLESTARTBLOCK) {
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		if (error)
+			goto out_unlock;
+	}
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, lockmode);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	if (lockmode)
+		xfs_iunlock(ip, lockmode);
+	return error;
+}
+
+static int
+xfs_atomic_write_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (flags & IOMAP_ATOMIC_SW)
+		return xfs_atomic_write_sw_iomap_begin(inode, offset, length,
+				flags, iomap, srcmap);
+
+	ASSERT(flags & IOMAP_ATOMIC_HW);
+	return xfs_direct_write_iomap_begin(inode, offset, length, flags,
+			iomap, srcmap);
+}
+
+const struct iomap_ops xfs_atomic_write_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..5272cf9ec9d3 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.31.1


