Return-Path: <linux-fsdevel+bounces-42981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438FA4C994
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494A0188C7C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A445257451;
	Mon,  3 Mar 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5nrt/uJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gaMbheac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF22561B0;
	Mon,  3 Mar 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021932; cv=fail; b=qqwMZoF2UeG6jtzGT+15e5phc+tS44hKDLRaeBAJ0Kod7m9hgZLcF/wfeF/60F1pr+lQDyv7AhLtkXRKzA+wKqfaQ5FiwjdqAviEm/QdLL3PURYROr0W6G0VR0YELlvoTmfxHns8JWJONE+TNN6FXKZJiFtqXQnBoCN80yOEUfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021932; c=relaxed/simple;
	bh=gYUHnBkeV53+rKEZ/sqaPW/9n93YtFfR2EHULEvw3Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Otd0IzIZDndonGcsrhD6cJvMT5fd3ww7v/+NuNhUhOpo60JuaRKo91aLZGruJTJGsIYksertqZWCuV2K99f04rRtY9HSbrDaApNYwYbBh8uAcGJo8mR08dCwHKFJV13VaD39xNfJjCYIzdVNDoOrCtTWFpx6W0p9iMwb1ZNlQJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l5nrt/uJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gaMbheac; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G9Kgf008103;
	Mon, 3 Mar 2025 17:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=enjljjCb8VgeDtzrx5/uC1rTrO3LUeLxvXR/ZbNca5Y=; b=
	l5nrt/uJlL4WaiZv9WJefQXepPnXEAsvVsdPljagz3BaE9D4Hx81C4t57REuk16h
	sBhmuLx0SNNHLrCTxI/bJuhbgcMB2Ll6EFMd5JWbuimk5ErUIOSlOXJK5A5aR19X
	uNbuHXhYLVbmDn8xpLo6ddnAgHrPPBQzpKrRrbspIX5DAjjf3r3V8OkCJeWs2u4l
	u2hNEj+16mlydnpS9OaDCCEaZiw1yH4LsoqTX6rdBtAYLOcJhaGtPyb5vwwNnl6n
	iI+gOmaW0xjapFhyxEsABFehLrvWc6X2n9cO4IcgouxoEpIuAhdQ70uVI9l4FIXs
	V7CSSYaHhTrtaJjwRWMoSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub735x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GlvU2040462;
	Mon, 3 Mar 2025 17:11:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe1f5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SONMexHIL/JzpEib0/YthmGAAU+mn1ti4UaIN1WPMKxke7uU2DAhdRWBj/aIw/COdZ8Frf5Cppc4hgxCeMOG95D024sPE4kVa69d+uhbUDh9x6vVUDGntrFqpA8JtgVSYPeoB+Kx8qWVsl1fry6Wl3fEDxd5g+xw2bI1iA2Blm8bY1bwBG9S2cO3ceid9LYlT5EcOepseHlJ6X3WEUlsMsR/bJeAwJoK+n87y473W6W5fCljEhXIcYAYdgi8nRih8aGg9SmlTK/gZ+uz19rYEXC5mtHGaNG0EZ7229aqTzEZsM46IuEbjzvIOCadbh1d6b7UmkTy1bKDbJI0bNizEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enjljjCb8VgeDtzrx5/uC1rTrO3LUeLxvXR/ZbNca5Y=;
 b=cz2ZgijO8mUc/0WQ6+c2d04nkuvEYxRJe0VsuBSlbIJYKGCVVCDT4Tcm7cYh7dA58IpBbAG6O5+kkW+xHZIxNWQXAOUjiq3CCYJ1R6tmw6u0WgiQjqKZx0eeXKPBIcHnHUrkLXoJRQL7Q1wtKDjxYYYzktXie1hL6OvkNm2iG6iGjr2zmBJHOMH1bT+ipxi8arm/FVbhlS1CQeI8DEQtJKet4J8Bax5vrTmICpguN12jfnjKpgjB50dBFENv44f5mGk8VqSUV45nsfQR8gZbASKfOm9zZywCPr/dq0PSA2ruUWF3l0qI2RsnwtFgMK/OICxNWX9wkjLoq6clSKzZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enjljjCb8VgeDtzrx5/uC1rTrO3LUeLxvXR/ZbNca5Y=;
 b=gaMbheacb1hPS6JzFVzJyWwYxxFlkToAjPEnVjoyiqirBNhLk9qGsUJxL8H2E5aMk6+aM6gUzw7HAwSF/zon0pwYl8Xgc5yYUCn7l2ZFYTlJZ8C2JQiGgIGQEq8I+s9dJ6rZB21BavsWuiLryUQDn3o3qxoJeMWYagq/Tv/kw1M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 05/12] iomap: Support SW-based atomic writes
Date: Mon,  3 Mar 2025 17:11:13 +0000
Message-Id: <20250303171120.2837067-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ea9204-ef0c-476f-8aa8-08dd5a767adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Dg2yeCY9CP7xxWwl7JgFFNRS9CwbTtiIiZHexF3htGvqQaqw1u/S3H3whke?=
 =?us-ascii?Q?z7N1cBGw5xIPHtJdlNrlCJ7tz2HEWqyPkrZulMZnHepEx361qh32lMaELNjB?=
 =?us-ascii?Q?DSJSINfrMf5oJ/R8yIVQtg4TWLvmBhnoU384IqCdz0j+0HVA16ZTj9/dVjJ/?=
 =?us-ascii?Q?Nx1bwwj7Ssatc0CDCk2Ot0A+hlBQKZ+4bf/giR+ikoH+KpZx8Yqp1LT48KHu?=
 =?us-ascii?Q?phM399OzIEU3udilhq8p9IjUKbjifk5Z61WSEubR0XvPaHj6iBTtV0YCnUfB?=
 =?us-ascii?Q?EUYVHlrpKLxLvYOrXOlZxxERAFr+7xyBi9YZZkURnRRdCBgJ3RACxKcLUOGt?=
 =?us-ascii?Q?rQhgsf03AG0OZheMM13XWpShKu6Q8FI3uYRiQdFCaJc4y/QoIkUur315rUHG?=
 =?us-ascii?Q?VXLVoofVZj7oefvYlXcNu0JvusvIaKl0vyszMfivr34tVrBVGDo1h8yhk6Y1?=
 =?us-ascii?Q?Iv3SdJATv/qUXYbDmg4keJTUjeNnM8rX8sF80bkARReYoQfAuSFFWpWfGysz?=
 =?us-ascii?Q?gRY6v8qVkbQWPQ8l2YC9QiD6Lo35YeFsTmsSKWsSl9cv/3Ao5YOLgRofAIN1?=
 =?us-ascii?Q?rjE21OUQFVGtxNy5YdEoamUKv1qRQM+IY4vywGEDtj/ZQPEIxgqX8FK/z2iK?=
 =?us-ascii?Q?hGYgtqE7Su3PwwBoQdhLzcYnnC4dguFKS8mRP+s8zI3vw9tVNKw+bI1oqEG/?=
 =?us-ascii?Q?Yb9Wu4O8Ix+MFXS4gMlC+XUHljptsH9DGP/FNbKnf7qQ/xVDCuKfYoKH2SZ9?=
 =?us-ascii?Q?djhyilWVTiFQS37WP/lmWpHu7J6cj7EWtlJAhLAJ7lqF2xZHo5JHHu4PhWb2?=
 =?us-ascii?Q?X2Mrq+7YQq/wu/2wMs7mtBJJq40A+/VvA+4BnHVMYjIakYtgetcyWwNqrCu7?=
 =?us-ascii?Q?OhNEvaE2pI62vpotCYHJR2gGh13zz9tnaX39qGKGeHNsKZWa7wzOMs7c2RTX?=
 =?us-ascii?Q?5bRJjQwtgGn9KnrXSRtZoqbhqrF86Ox+QKewWXUDPcKKvxaa5nMCGrhqKQpx?=
 =?us-ascii?Q?0ST7aqG7U+CudVJoLTwx215jaEAtc4Phv6O1N0/NkNblw3+WciOAM4/tzd4J?=
 =?us-ascii?Q?dlQ81ScQkfdrfWNwgO09MhhkTAYOFDAfCldIkgTFxGpji3csZM2WvB2DHHKo?=
 =?us-ascii?Q?jOrgIZC4TPBBPb4j12sHARKpVlSZ2NjRVQVoELR+eSFc4CUDCjxyyQI6bL/z?=
 =?us-ascii?Q?R/YA6IO1gkRcpa0ooACm5xG8kWSgNjYf3YAv2ybg9VP7ZsSBoVUL/p0QTgTB?=
 =?us-ascii?Q?WyFse/JqwwlxUumWubZQB95sZLOZT5tejgTUpW2Lt3tnscNQ8WwB2NI72QLA?=
 =?us-ascii?Q?h1p2KTXOk6mRwFPbCSb8iasSaO3q4qx8Zu01vcsHpBdMdpeQdMtnX9oofunV?=
 =?us-ascii?Q?VTATaO81enqpTZsrgjwRLuMoIAFJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/inGSi+l8miKdtBfCV2tO0lu7tNkc09pnYsOXASHwcZKYBZez78BRTX9Vs+D?=
 =?us-ascii?Q?u1RAyW+kZyadVraY9E1kmplsGgXKi2wZSMjid6ZGC3fIaRG8qq5Uj2lPl19r?=
 =?us-ascii?Q?I0wrwvBr2G7sL7K0pqS9ltwBsIAGsSPgyxw7skmcn81k9BoBOqpoGmQY7Yf2?=
 =?us-ascii?Q?Pn55RfSIyZYMywUk7QSmSe16JzzPRsdVikdIv9NXluXBiCWnGfVD3LmIxDBJ?=
 =?us-ascii?Q?G/gBTSVxQmR7NS5w7XJCuukVLSKwkaN8gzvHHqOfPArqcodvqqwtjlhL7z6D?=
 =?us-ascii?Q?A+uK6dOPzOMlifShsxALiMcf8rGJUZ+Kw73oSc9ZpSTitwUlRyBaNsKiyLiK?=
 =?us-ascii?Q?BqfEq3qf2FYHkpr4I9RsY6CF9BoGM9Mpx7d7w4IPH4JYZZiTRMNOvtd4OsrG?=
 =?us-ascii?Q?4RczipHHYhml5wNllgpsUZTuAoSEkoSM1e8QMvXI3R4+xIh+FdOHboffiPLa?=
 =?us-ascii?Q?v8QbylF3fEz2VhfLCBirrRvJBYqgCFvTCsfbHF7yg8M9ZfTeeos+Ohye8c42?=
 =?us-ascii?Q?YWGkCe7P5KOHXg2QEvYqdcRtG0S6ISS1sfmO58WFY1OqlzSvjL81VqLLZk1t?=
 =?us-ascii?Q?iCHbgDBisNyGpNP7AY6gGW99oEtVBZprNwT8yYi5cFBopSStdZZJZB4ppA+d?=
 =?us-ascii?Q?8ATONyfbOKRU4//3nXEx4UERF8ml0ZnEmUp1zhPAc6cvIdTsGZeKms0NQ8Sf?=
 =?us-ascii?Q?BG6YvTn2lPGZ/xqOa8lzPfMuZ67WBjRWgWHnOZDqKrgviWiGJ2HsqP0Ww0GP?=
 =?us-ascii?Q?6cXZ3mGqlkE8VN8VD8ItVE8RSgZ5D99zRky8kSdLvwcFi+Ky+9V0xgKDL6RL?=
 =?us-ascii?Q?sXjX1q2UhY2/X2pOQ28NxqZW2/slFpJST2BGjOpVDRjdhj8CAE92p6HuqZwH?=
 =?us-ascii?Q?T5Ol5Y4tNDJGK3mcM7FS6qAhfaOxQ7ZeSrk905QOvzHhLHU/xrt+NNKGNgR+?=
 =?us-ascii?Q?pzhRtNbtI49xUa4B0yxaqS40Wdrhy/x40n4rj9iUO6WxgYaLItJAuLUqx/d+?=
 =?us-ascii?Q?48FXoIl27w1u9iQhN68++BfpIntze+f+KQheG1+kej5kETI8aZpyLC5c/UTq?=
 =?us-ascii?Q?E4QyPPXQ65RjsQ3iELU8OGijNie5xnUZCiWP5LHLWGzqHAdnoNBwapBlcNxS?=
 =?us-ascii?Q?Do70seFQ8UEkY8+LE8eKOF6zjLyiqq682DivPDoZvs7mOxLl4HDblEu5RT0X?=
 =?us-ascii?Q?0gwChdcd4v5c9RLusQ1afN3uQJnNqwvN49jxhZNxQSNcFtH+bw42nkJBY1op?=
 =?us-ascii?Q?BKnX6ii8D+JoujevKIlkNAy6ONLi1jmziFj7tKjXSG4B/vSjEH9MevSk/viA?=
 =?us-ascii?Q?rCj49pQ0SjY7w73bth487tKtYVJ20fJzsVF1JVNdRNUwpxWQ8hJRVysb9Z4i?=
 =?us-ascii?Q?6tl8xY0oio3icy38IX8BW7PTPuQ56QcOlf6OGWpReUwyLmfafhOIv8qN63pp?=
 =?us-ascii?Q?qQ7b92EhhAbNHLlQBqYHT/qkPc3hQM/AizyT+IUvH8C43HaibAKMpVPjoWVz?=
 =?us-ascii?Q?P7ZA6fFVFwD2yBliNRqEKFL7CSq4Yeb90ts3Rwh8BUzS/ZpxsRYyRYMgIERP?=
 =?us-ascii?Q?HFtYe2IxdNHFEh2rPFVloTnvXEr5ZAJcrQHErcgPRaeDrkbMRDomwUvzODn4?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ahTDf1hkGlUW75ct8kFOy0wC9L7gaLXC7xNCt+QztykspmIk6hcPsBWWTv+RNaf3V/PzvM5PHV2b7nb6lGokE/57w37RdjA4UnQ5vodPm2PHJgc791FEiA7IyTYsP+muN+vGenHSlW1iHMNkzAZ48LNgY4/kVxV9oymoaDUn2sltG6m5tYQ+19FWHB3iffR1W+/3CZJZ4ZDWX6Dy46xmsc2gpyJIt3CVw6AcOhVC1BnAS41HoCmmH/RFEAjJToh8ga5HQWfdm/YRjD2GvQv+zayW7ElDMFxKsw4fqnwoOAUWHPSBeeJcBoTXKR5c0RfdF8BxgI1GsQGjVlP5YXdDCRJJi9Y21uKi1bzze5Ia13q/sAaS5P9iNvofaKxWhgQfvw3Uy4Q55hW7K5uacXY8uKZ3SyvcAzsYY48SZxVQct4ndJ1+N9v2oZZCmBzBNPG8IJN9SLWUUxyZrQzkh4oFsXZo+FiGTl4xmGvCqngdct9ytOLIeImHLxJLRcP/6lPJ6zJqgcUMj0i3nxi1WSQcFDSxP03HxMTUqtzKudgx96RE7nsm4dh4hbBSWxaQKb/RxlI+CgQqg6xy1YtJKwi/6vK902zzbk2YMGNdGGdTvM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea9204-ef0c-476f-8aa8-08dd5a767adc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:47.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNS16IkHSg6mu6io97HE82l6ki1X9ufIlI5VJw+wuw57n4V/jbvANBRqCY4jIh9+4LYcrv+r60tI2PFJnpexSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-GUID: K-32TPjcyQpikGMhENcZeQ-EHhWaK8Nd
X-Proofpoint-ORIG-GUID: K-32TPjcyQpikGMhENcZeQ-EHhWaK8Nd

Currently atomic write support requires dedicated HW support. This imposes
a restriction on the filesystem that disk blocks need to be aligned and
contiguously mapped to FS blocks to issue atomic writes.

XFS has no method to guarantee FS block alignment for regular,
non-RT files. As such, atomic writes are currently limited to 1x FS block
there.

To deal with the scenario that we are issuing an atomic write over
misaligned or discontiguous data blocks - and raise the atomic write size
limit - support a SW-based software emulated atomic write mode. For XFS,
this SW-based atomic writes would use CoW support to issue emulated untorn
writes.

It is the responsibility of the FS to detect discontiguous atomic writes
and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
SW-based atomic writes could be used always when the mounted bdev does
not support HW offload, but this strategy is not initially expected to be
used.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst | 16 ++++++++++++++--
 fs/iomap/direct-io.c                           |  4 +++-
 include/linux/iomap.h                          |  8 +++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 0b9d7be23bce..b08a79d11d9f 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -526,8 +526,20 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    conversion or copy on write), all updates for the entire file range
    must be committed atomically as well.
    Only one space mapping is allowed per untorn write.
-   Untorn writes must be aligned to, and must not be longer than, a
-   single file block.
+   Untorn writes may be longer than a single file block. In all cases,
+   the mapping start disk block must have at least the same alignment as
+   the write offset.
+
+ * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
+   protection via a software mechanism provided by the filesystem.
+   All the disk block alignment and single bio restrictions which apply
+   to IOMAP_ATOMIC_HW do not apply here.
+   SW-based untorn writes would typically be used as a fallback when
+   HW-based untorn writes may not be issued, e.g. the range of the write
+   covers multiple extents, meaning that it is not possible to issue
+   a single bio.
+   All filesystem metadata updates for the entire file range must be
+   committed atomically as well.
 
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c696ce980796..c594f2cf3ab4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -686,7 +686,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (iocb->ki_flags & IOCB_ATOMIC)
+		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
+			iomi.flags |= IOMAP_ATOMIC_SW;
+		else if (iocb->ki_flags & IOCB_ATOMIC)
 			iomi.flags |= IOMAP_ATOMIC_HW;
 
 		/* for data sync or sync, we need sync completion processing */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 87cd7079aaf3..9cd93530013c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -189,8 +189,9 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC_HW		(1 << 9)
+#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
+#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -502,6 +503,11 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Use software-based torn-write protection.
+ */
+#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


