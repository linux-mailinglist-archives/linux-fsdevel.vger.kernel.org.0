Return-Path: <linux-fsdevel+bounces-24806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C9B94509C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F31B2468B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F11B3740;
	Thu,  1 Aug 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDvXXiPA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bp/XPER3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9742A8B;
	Thu,  1 Aug 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529917; cv=fail; b=SpZ5/hKI10eE4WBd4+kauyc/gswkSvsOtftRmWHxvm8wwys8TCe/C5To2BdF3Kj0ZBxkKoh/reXBA1TFywqtA6ZoBBfD+fmFnpQFXi/J5vUdGo1DDyjUNqOd52qE7ZDfy+0lZ3jgDs5tpSccEQ4eaFvlkrIHL5vbswPbV9bebZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529917; c=relaxed/simple;
	bh=yKEQm1TO2chJY1l2/PQu8F3KBsrE02Hwu9YyZC5uRAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eE8nM7aZomKyOpWPm/ewPBEmkOVoR+sKv5I9BrJHc8sHCIv9ysb5oLQB8SBp1NLzMxHPm4453sVcmzD8bbArCNPuE+f0oqVvgx3isaufwkCOIO1DT8sjiO+uUQ4AK52SiiebwlsZFbj0xKqQhv+cTjvcMB0moK1PiOnoOMz+jME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDvXXiPA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bp/XPER3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtlaY024181;
	Thu, 1 Aug 2024 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=pJDiGgI+yKZ5z9
	Y78a6IDtsLetOkGVxhTAgamiZ7xVo=; b=aDvXXiPAe8AZTk8ktHPFb0ek2zKcFe
	cyzlPV2UKfO5Aq/XgMYnDaqLJaAmLxP8FFvA7HO2mZKlQgANMC05PtTnaxztDduZ
	hxFqkEKw/1+PDj6N+EhuHWalluJ08DXOs9Gs6MaZncmLN7WTaBhrO0QY1LKKQzh0
	SA5881Y2btCQjD2xlFU4Dlux4RuUUtaESUgQ87kAJ8AT27rBduD0karcIr24ul5Z
	cta+AgSTqtz4GNG4HwovqKbHHSkBVj8UjyN63l+3CspTU1r6oxsOCs5p/yOsSKbW
	Odw5i+AlxhekYujb/6Q0Wy6gC6kacuVG6DsOOJplY+1wI5suOM+Mx3ag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgsa65u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471G4CBo029016;
	Thu, 1 Aug 2024 16:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpt8g7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpqINnmqZZfP/E/5iZ4VdJVtAJkLZdXhMclW2Q+98r5baQCwSpwZx9tK/S/TeK4ZFbgVEyEKuo6Sz3xMB9ninvHXYmQURTTpAo0ZTLGdVhziDvMKo28WEY5MC62tbn4LD6Psx4h2s658xmKyg5UQyoL78BiWHdooWPHB4GnOALIw8AHbKNPB6I6bNz7QbULaeBtyXWOrBN7CHmy1zpw2jLmER/gBJrqR5UHGDmEnXh7EtduMvHNgwj15heUkDOvL9dLFlSpiSnRpu9rP0AiwnSRHxJbJoUc0tRfdKM90EnXsYOXingbYz8RvMMMriLavHXvxrcNhZdjcLUGOWDXw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJDiGgI+yKZ5z9Y78a6IDtsLetOkGVxhTAgamiZ7xVo=;
 b=Nga3i/6Xo5bluAHBQrTlDR4mzFwIRpqD2ilJJ9vApfBxres1spIoER9bYlLsVx66wW+WygrzOp2JprUvucJww7v1wYnOWGali3B8Q9Cb1m4NeBeUCfg0lSQ+VHE5lm+GS39b4YVspDKpqT7YWN4SfEv1h6XVBdeh+M6bqB/JDrtgGsCHYJ9lzesqEPn6ug4lRvKGfLLOEKr4VPEq4k90i5kxmExqAbJ7D0iDYIflDfhCH7aBYLGfFTr/X6MwOaG2Kb69Wo2iJ5RhMnmxzhT4s+RBYs3qqF+wIL7yqNkN4VZtCpwEUeI+UtY+bMm8PoZ8Drm64IIaPv7Zr75q2tMOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJDiGgI+yKZ5z9Y78a6IDtsLetOkGVxhTAgamiZ7xVo=;
 b=Bp/XPER3O5/GgoaGgGxv+lhQnP3MWF/jj1uc8dxY35HnVWdWzygQ38FTymbblv587gUy3/hUXnJkwn56msZU8+lE+VQzop15R9/LPmigpw4sXWA8dh3epX6kHYZZHNhvD4/JJ6iXPiV73JVhiKkpBzfOCwOuJPjmy4yKRieDlDw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/14] forcealign for xfs
Date: Thu,  1 Aug 2024 16:30:43 +0000
Message-Id: <20240801163057.3981192-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:208:32f::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d75fe35d-05e3-4798-ec4b-08dcb24768ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciB+zP4045cl/VsNDuCIrR0c6NcP5TXXgg6Pa1VI2WGlg+9WG9xyFvvbaddt?=
 =?us-ascii?Q?1GXixgmvlmILDXXwa8v0SNqMLBrasBcheAiU7NZhgWhsqDHeyqgVP86mBMB2?=
 =?us-ascii?Q?q2NtBkaCN4BGldlBnpGPj9WMIO3DwT4TB+OckuG+jKTP5wD96aUwnppvYFb5?=
 =?us-ascii?Q?7rB/uPoHN0RgeeUaYutI2AYWY1Q+ootSpxY/Yztr3QCn4+Fq1f3nyYSUMrKG?=
 =?us-ascii?Q?P+xuye2QDAvgBYRvahXjzqRdLeuYQWZjAoXlNHByYqbKSH8T75TV1khX34v2?=
 =?us-ascii?Q?EoaeBk91CQkUGN6SNPAZ5E1c8ejTgiS0wZ7XoCq/RorC/LD4hA34C7pu5J4V?=
 =?us-ascii?Q?Bh/ETTe4+qyP1fmYlOoCWcwiTbfJR+D596s/Z02u02VpUrIK1mIY7LZdNoI0?=
 =?us-ascii?Q?hbF8V1iMTSbAjf7aW+Yo1aMisJgmLjXqMyYJZ/c0X8WpHTtvu1PTsmLGECl+?=
 =?us-ascii?Q?CpgL8CcF4AuPUvtOVdA+nKy9buVqDQ5kMFUMwwAShcPEVG7FlcSQD05igQuY?=
 =?us-ascii?Q?ZkwWwqC8zPW1wRB+yOZqxPA84fdPA0G8kr7Fr8qEeVNz5Mlk3zuHlX0h8Bvo?=
 =?us-ascii?Q?O1KsP7Ainu5/0/IXJSbwqbtRlibuWPre9PAQeAk71HJyFtJJWibj+utb5WqB?=
 =?us-ascii?Q?EmwkppRglhHDpTkwVD0IANooHZBqk4r5wzOOjBdlO645AFNgkmQgGh4w65TS?=
 =?us-ascii?Q?J2oV8RjHTXNnSWOp+MsH2vI0zlE9datqz5LMl+rP1x4oguida6VZOxskqkeF?=
 =?us-ascii?Q?OonXF+THMJycqTlnviYnDiFf5OIwuxzs8FeJJAGmqL9DaoWZJjxO2J7aOzVF?=
 =?us-ascii?Q?7Cdcm4wqPIpOnr024wVeditgXDDC4wQTCYDqZZyHlz7a7uKIspho9N8MN2FH?=
 =?us-ascii?Q?NE9gTePOvfpBovFVGeEd1awEYvQhFoN3NdyzXMQq0Cl5jnod1w7tPKb65Nha?=
 =?us-ascii?Q?lW1+I6yd3GMTT3yYGBS+ZVqLQnGIXbjTaxJMYEeDsPdKJ3Mb4SveVXCm+Mjz?=
 =?us-ascii?Q?f+pHiumyV1hHEPdNIO4l8hV2MXf0oWXjyWIWcSp4omKjShPojQzQXr41w2oS?=
 =?us-ascii?Q?hIV8b14CYVblkzDGlRN6mXwCGOVy7DRqs2Hu7LwEpjD0yibM5EuE0xrBIp1d?=
 =?us-ascii?Q?1uHVz9jbUQ8dlYJ2W3RqeV6kLTU/R/QJVCmDsNGphDRTSmEylokuUuyPWXFr?=
 =?us-ascii?Q?8njkuVhBBL9AltGhWtToaNTjFbKbina+7NJqAV2SHeG9B4Z9gyEPWSAXgRj2?=
 =?us-ascii?Q?jiC05lPKdMqMspIbJcrCMoxSBGZBukDPak8b3MIe5l5vBH8F4HIj3bvNpf6S?=
 =?us-ascii?Q?aIiTNjEQo4vn9HIZW4hDbMs9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJKGmHUqw9y4WSMW37Wc44JSbj/kRlU8lkJC+d67VdoqpZ09fCAlADOuvPsf?=
 =?us-ascii?Q?LNUAuTfxpPmUcdD65HePXPJrA02A9IzExEeZ45K3IQo3+3ATkcY/3IlqkTNN?=
 =?us-ascii?Q?Uf351zKGoqzKz2WOO2Zva2BlLWojPTTk8jODIaTEgG6cNTw2dslPw9qcZznp?=
 =?us-ascii?Q?J+muAbaIJCAcSGKnEfSzI620nFPQlXkySV91cs8+NraaRQYaiYRSCUZLF7vb?=
 =?us-ascii?Q?k5zCHGo6f4julncdpu6Y1ou98Uzcg7IIYgTTnzXDOhTYNeuSrXriIN9dYGdf?=
 =?us-ascii?Q?ZbGL0ZVx4tcnKxd2tMKcpXD1PkLWpIVigmIJ5+assLny//mFkcp1aiMdzlHf?=
 =?us-ascii?Q?Bi+cNXRLIK51HSErEOVzmL5tS9q9+0CGbqc34H/PwsLV2YkI75N9+lR9PM1C?=
 =?us-ascii?Q?JGLV7oIgaTyE2srPTBfXDet6SFnIVObSrT23ZjhUFhYq4A3NmWXazMIYs0Fg?=
 =?us-ascii?Q?BbKhZLKHQUmXaGBNmj6pOnxDAx3joBQzPtZRaxuBb9mnfX1hj3Ej4naUDrT3?=
 =?us-ascii?Q?xgFj8GZ9IToKZfMvPBJJS7kDRBUGdWCEGDNkm5PDrWNlnDqzuKDtsUhlAyW5?=
 =?us-ascii?Q?H5u1LCWQBnKnRlYM627Go+xJkbg3pWAvRNp+pHQauUncXvH/sGRTrOPQaQxk?=
 =?us-ascii?Q?bIxQwhoE8tMdOcz9s6X8aMaCjYxShEfJlQPN5IW/UlbFOykVFlos2GZblV1Y?=
 =?us-ascii?Q?G4b8BSX8IKwLqGkd2Gr1/Uix94cTfBVPFRuv3bG9A7S1qRZbnwGGJyiIo6qd?=
 =?us-ascii?Q?t4EcoGgNq9YNtVuIFyZeD8koEJgcIvFMnVWN7ou9Ubb35ENKQ0QEXWuX5IKK?=
 =?us-ascii?Q?/Z4/jmnKi4gmxp9Psx2wfdDUKOuYwUFiX3aIkR0XgFeeJDJTygUP4Jcr3lZv?=
 =?us-ascii?Q?o/PKy2i8J1tQ+yBEZqrGQjFp6qvUfA6660lqkFsQuhOC85LAp0NGX+n6CwGu?=
 =?us-ascii?Q?ExZpQvrXN7OukdFi53sAL1deMFWGVzPCBK//XzGn4lwudIOBHA12UC9g/Q2m?=
 =?us-ascii?Q?ht1G28jfwADfD/8bWc0QIZhnEKXRWKkxQOOfPfbGUCa+8FzjaZ8u8LYZIc9O?=
 =?us-ascii?Q?bg4vMLiSTwgHAADjsqJ/OUN2nr75c+guvuat0ldVB7bbf28R15eIPQlNAzZa?=
 =?us-ascii?Q?2Qnc/oY2jPZkdJDKlYmpviK3rDST7l72C5Xf7LxJkn8evjXX+LZ3yv13JP70?=
 =?us-ascii?Q?jWaG5ABiXhCjztaNjkrwgX6BfpxIrYbfoueWON0CpcxRkiv94USfl4IunV0u?=
 =?us-ascii?Q?AnCKynGm5qfe9HRsLt+IO2+gfKkbcYGzKWtDK4/UBVZKtRQwc3OL8ERM/ZNt?=
 =?us-ascii?Q?fMo7LoizUiRwifMfN2ZRmacvy7WJxi6yWmfxMLBlKnTiDEQgNvpr+39fIuMx?=
 =?us-ascii?Q?B6CBsX0ur0mZ0HJ1zwxkPWMPTcSTtvqq7UflAXjss6144OmvnWEIuyRMAlgH?=
 =?us-ascii?Q?gtXdv7CCwfx+r5Rw/Xw8U7sxJ/X//aZm01yZFg//nGuCbVqp9uE/24eJ8WVw?=
 =?us-ascii?Q?D0+1ZSj561Gf6yIqx/E3hgZVsCJqyoFH4HA8vOtqZFY19YI1X50BdXDMZhJw?=
 =?us-ascii?Q?JSAzWDI/KPx8aoo3iGwt2HyQTNEXpHF4ypIJjxAYWHDCzuTKpwkx42ufRDp7?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2GIjqDURniVtk1UY6tVWxuU9VrqPCiShcBUVyhGE/tvh0I6RS/1hHCBozheoYiOZVSMmWW5LayXXkGiJMhCEBQwfW34hfwgI+B3Itd/F6XmWHdf1xwp9OWlk6UJuv8/x2ri+rp5Td4z7Euf3rvdCPwQNGd7hSGnD1jJg7I35OHcwn4epCsGkktVrtY/OYbgaOCwGXutwdeu1YJzeLkePRxQvFSWkMhGX9jYrYNtBTr4+tAiHYpZL4GEvtOWtgtb3z5rhauuqKtCthk4LVX293Fo+WXzX36myzH6EUlUfz927ZAB3ORSTbah1PQB0L/ok3AcgucQo9g+jMxsf0CuEvnVb0fsH+c/jpI3X6sjjXsCsNM5tW4tStA0Tj3Atcvs0Dijiv4TIU90Tae+fgeyrC5b3Omz4SYmb9eH3nlUfZ0Yl3irKYVSIMIBcxsWDS37OI9kbJXXRMnSRWyA9OF/muN2VHTu/tkd+sqKXptslrGKijxZ9Fn1NBmpo7ru4QnfzvPBgkmVXdN2Q051krfIuFMj3h38x/MVyHYtHcHZJObxTZ7Yt8zeE9NmxmbkYm3Vqcl15WbD7sl+eg08EFBA96JuCsFZQCZwM5LNcu9Qdbv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75fe35d-05e3-4798-ec4b-08dcb24768ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:35.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1NvNNA7R//DQV7wHweRG20zdmvHOIMX26XR8IjERYGl4yRAjg627mJyS2gZknmk9An4PApPtGilsFd2+p8I5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-GUID: PilNY6umF_3KeD20OwIWinq4qji0qCBy
X-Proofpoint-ORIG-GUID: PilNY6umF_3KeD20OwIWinq4qji0qCBy

This series is being spun off the block atomic writes for xfs series at
[0].

That series got too big.

The actual forcealign patches are roughly the same in this series.

Why forcealign?
In some scenarios to may be required to guarantee extent alignment and
granularity.

For example, for atomic writes, the maximum atomic write unit size would
be limited at the extent alignment and granularity, guaranteeing that an
atomic write would not span data present in multiple extents.

forcealign may be useful as a performance tuning optimization in other
scenarios.

I decided not to support forcealign for RT devices here. Initially I
thought that it would be quite simple of implement. However, I recently
discovered through much testing and subsequent debug that this was not
true, so I decided to defer support to later.

Early development xfsprogs support is at:
https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/

Differences to v2:
- Add rounding to alloc unit helpers
- Update xfs_setattr_size()
- Disallow mount for forcealign and reflink
- Remove forcealign and RT/reflink inode checks
- Relocate setting of XFS_ALLOC_FORCEALIGN

Differences to v1:
- Add Darricks RB tags (thanks)
- Disallow mount for forcealign and RT
- Disallow cp --reflink from forcealign inode
- Comments improvements (Darrick)
- Coding style improvements (Darrick)
- Fix xfs_inode_alloc_unitsize() (Darrick)

Baseline:
v6.11-rc1

[0] https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/
[1] https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry@oracle.com/

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  xfs: align args->minlen for forced allocation alignment

John Garry (6):
  xfs: Update xfs_inode_alloc_unitsize() for forcealign
  xfs: Update xfs_setattr_size() for forcealign
  xfs: Do not free EOF blocks for forcealign
  xfs: Only free full extents for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Don't revert allocated offset for forcealign

 fs/xfs/libxfs/xfs_alloc.c      |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h      |   3 +-
 fs/xfs/libxfs/xfs_bmap.c       | 322 ++++++++++++++++++---------------
 fs/xfs/libxfs/xfs_format.h     |   9 +-
 fs/xfs/libxfs/xfs_ialloc.c     |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c  |  46 +++++
 fs/xfs/libxfs/xfs_inode_buf.h  |   3 +
 fs/xfs/libxfs/xfs_inode_util.c |  14 ++
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/xfs_bmap_util.c         |  14 +-
 fs/xfs/xfs_inode.c             |  61 ++++++-
 fs/xfs/xfs_inode.h             |  18 ++
 fs/xfs/xfs_ioctl.c             |  46 ++++-
 fs/xfs/xfs_iops.c              |   4 +-
 fs/xfs/xfs_mount.h             |   2 +
 fs/xfs/xfs_reflink.c           |   5 +-
 fs/xfs/xfs_super.c             |  18 ++
 fs/xfs/xfs_trace.h             |   8 +-
 include/uapi/linux/fs.h        |   2 +
 19 files changed, 431 insertions(+), 191 deletions(-)

-- 
2.31.1


