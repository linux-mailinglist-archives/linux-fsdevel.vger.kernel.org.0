Return-Path: <linux-fsdevel+bounces-47845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F5AA61E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B27188D995
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69322D788;
	Thu,  1 May 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4zuGChV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ioekpztw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204122B8A2;
	Thu,  1 May 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118734; cv=fail; b=Bg2YLAsYYOv7wS6VY3w8WtmP0d/dcLpYNbj4lNNB/xIQoHkICp+HfJ6uAEYkMH2xmEsTmWtHMj4FJjbKB7g+CA4ieP0bayC5avvAuzxlwL6hoPawb2fb//bH7MkYY5E/eoHx7krG4pUd6uT5R1bSKDxTHiOdNLWDu+KsbFia6AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118734; c=relaxed/simple;
	bh=KNVNk1CCx42+fiaAdF2Ll76XGH471BCcnQSWw3yt3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uL+HyVEltoQFK/+Bts7ak99rmiChm91v2hCsu22EVw89nrf5OSwa2YRPlB5a3sDA/pPUd33trYpGvHMR2pp94As0TfEGzVc3BmJyH1Otn5R2IKBnJFsxRhN4Vr2+SBLPGHiDbMTVwOcuqFjv4jJtCfz+9Q6UBVV7f++dD6iuShg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4zuGChV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ioekpztw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk2i7024245;
	Thu, 1 May 2025 16:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=; b=
	E4zuGChVm4U9BROiFQ7to99YplZKHCeKRt2z76X5bHtCZqzPnV8Oanb8yP7OsbdN
	mKi6JvR1CaRQLjNCpBxbecoEl2dCqa5fW/XLourKydPqTKMdRyhYk7QJZOn0uPFX
	kUexQWXZgfr/JGBRICzaXGxy+/Da8W5Pgl8hg5uZHWsqmIzC084p30EuEAO6l1P7
	I+yKGRDbMkhuka6G7IwurJ4K1WU60t5Dr6ihES+ov0pF+IDeLDt+u/NbSxc6vsq9
	Rhp7S7OzKTNX0pei4tXeeqOlQjkpRP1S2F3hXL3PzxheCvpF4M7SCmUs60uqa0T6
	WHs21WlQGjm4Anfbo9BJSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utbfbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GKbAl013815;
	Thu, 1 May 2025 16:58:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcs6x1-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUKHio9QtxXcSfJdjk5BINBJSsLgUeyag6Xk0ju8pQsIn/nb61/DYmSr8OhnEWDuXcdExW4SJRLUQGDPejOik3An6h8Iz2omqxe+t3mMFaglHUIGCdCLEXYNBbHS6imT5l9L0x+SPxc5k+57C8IJP4ZwoV3SZc3H7ohqgT7ZP+z0OTRtStR7E3nN3WZC7fMgJthmeUE70TDp2k23WunIu1d356egJPAIXR4kJ44+SSCK75xvwV3xoLi+QUIqotj9LE1vCxN1owHV8mAJBOFb7TfL+AlGIp0JuR7em8/ODOu4ERp4qe3GxHwu+HOL+OZhAqIPYycSHxgMaFvP1IYz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=Pr1AGdhTLwXgi2hd+UAUmCXTls+qMxsg76H2dHCunPg+47Rmdz8a+wj4U8eKCtQ70wTWS7IpAh4gEJYdW1P2jH8QQGENXWrfgOndaJRIbWNyqS9Q4M2IE0kZbutbnYpVyz3HnYpf7cgYv1dOyWoBB/n+7EkZMKWYIGIcTDF3TMHIuf/XYB1uhxTMSOuDojfHYMgghdbvJAwWMFTJH7ZFNq/3IVrSSYDa7qZywf+R3Bii+il3rfaGJkbsfy4mxH5W4gqobJq1PKeOzhPPRPcRdZoVzm7zl3EhONQdJtnTiy+63HOJBwvNXEZFwkpvZTGK/E4wsFS5X4kP4XDsGFTTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=Ioekpztw1/oRZzIJ39et3vdUKUpx42CkPNv8AO0vX3P2VcGtrrLmikrZNZXZQC64a5lybldvO5WQbP/YYIK/Oq2qevzCp/7+RqC2VEu48Eo5GJfPZ5G5SRFNqdDiv6tDEkc02wfMxJ5cWzqPsz6dT7VWk+O6dRzPzkVrsIVqHBU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:58:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 09/15] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Thu,  1 May 2025 16:57:27 +0000
Message-Id: <20250501165733.1025207-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:408:fd::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddd7ca3-fbac-427e-b4dd-08dd88d154f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrSp8yc96gIUV45Y7xoOKOBQwOP0cKf1aJTQnW+viOWHCdU0dJZG5Csmq7gm?=
 =?us-ascii?Q?792a5x3wJ0fCRC9w9j0pnnhyGcf5ysRaACXwppgp9Q9mQjLu7LeZHAAU64iF?=
 =?us-ascii?Q?MnasL40Aei4Aq67JB1y95YAF8njZx6dzwOpVgvpPfqiY+cHm6CXtDiYff5/z?=
 =?us-ascii?Q?lQvON0DQ9ku+V3PXfgx7M8tv3O6pCqPkuIDVkqqpMwF0OS5g8h19bbd2IfUO?=
 =?us-ascii?Q?eOBZ9YVigMALE3Ld3RHSIkDGkk/BpflwqLduDG+/dSOOZHpKcMiB/VhDziAx?=
 =?us-ascii?Q?b5BQ53A/MbAi6uVoW4SXjdWuMarIgOR3cfM6p6uKP3WNrRzIgnSIRgYCA6BE?=
 =?us-ascii?Q?6QFavCsXHzagdL4vJn1njG8PjVG7XwSXZOCT/grY1I6qVcKDFmkdCHv3Es+a?=
 =?us-ascii?Q?KRuCf8TjM4xT0qFG7OrdKgag3EIeY9KUvjm1qmiRb6nPKnwdSbFG23ZEqfor?=
 =?us-ascii?Q?3M0NzBS/4iaDD+PG9sG0oVe365KxWs46mIlTvoAmgp9Hs/ygFMgXh8CYA92f?=
 =?us-ascii?Q?OuDfwnC25tTD/v4p8nOgtTaKNoE/4N2MpKXmJpYHTuOIL9mEeeHhnvubgTTV?=
 =?us-ascii?Q?r60auguG126XhQACRSjW8lIjMljpCvhBc8uIRkrcujdZv3xSM3jW0SK0t8WE?=
 =?us-ascii?Q?hpb0O717K4WT98rrGQwrkoaZ1HshorE17/Mzf0nUuJnL9gSV67lzKX7MkaFh?=
 =?us-ascii?Q?NB60sXmzQTPlN0Kk0ocWKymUms3Y7NRC8BSvJRMLXXGoAEQadFOOe0T1mLoe?=
 =?us-ascii?Q?cuDXjdIv4BI59OWHXJpv3MmZEWgD42xz1P7vabuQKmEdAkk/JKT3cIuCrWRT?=
 =?us-ascii?Q?xRpgXgH+fhyhWLBgfnuhhYnzUYSjNGfelfgzq4nJHRpMeArurNjippstRfs3?=
 =?us-ascii?Q?nfCepoth60gvifMaDyehkI2UsFupl3QgtjNz/A3OXRmxd42waYpJC/jlkeBA?=
 =?us-ascii?Q?ixv8H3wSL8WW5RAp5B7LKVpgy81+fQKQxvUus7XvVOEyLYsz8FFH0RndYL48?=
 =?us-ascii?Q?+QWn3OlYYp6k+a/2bqgVAdFsWgMQCQYOM7lEvNH5RJtkCKeE4fXD6Lg8N4LJ?=
 =?us-ascii?Q?0XEQHSVsvUKEs5+o6vT2oAxX5Y2uqckAN1driDMnATeaxKmbWH9ezYjqalWl?=
 =?us-ascii?Q?y8hFDVb9JE1NgasyqTEb5C9YeszKF5+7JEJvJXOEtT/USWo0NDmrk4/ZvoPI?=
 =?us-ascii?Q?F8FdnB876m+HReSUvwOikdqZ3McFs/dBVSDHKjXBeOG4liW18MaD3eqTYNBS?=
 =?us-ascii?Q?jemV0FV3zTT9KrCNNgM4O1mKpVPfybbYkkni1Mssy7U+T7150gVal6DSNDls?=
 =?us-ascii?Q?Fj4aaAFm9gBNdCkWhMGfLgHAY3rIdRw6dkds04lqDs/lS1P3jF9w7W8LfaAB?=
 =?us-ascii?Q?/9lREbtMjOtx0reJKC1n+io8HQ/BjFlSSNIcz0FVlxnK2cNAYlbJXlOKS4AB?=
 =?us-ascii?Q?x7whaCRZ5Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DI0tmQGKsH2jI8WYm42xiIJyDHWfeGxVjub3L0UFu6sY4w0CE+pyxJJqFDTX?=
 =?us-ascii?Q?4VFxsGpybE+V44U96OgjwrxZ6ZnJHhtzgmP+Hsj1GzHUPvYKAlQGn7DjDv1Q?=
 =?us-ascii?Q?/l6DASyDKbf5bAkc3e0HXZf5K5/gWMhY/ch70YNNYH+zWhOhLopaofKqggzg?=
 =?us-ascii?Q?5irIPvzY1Bg/5AYplMGNcpxQWkjcBa+4w8EZdK8UpflfKTvRgzqNbOA/N+31?=
 =?us-ascii?Q?xFDscPHW+0rbxBAwy8G3P7Yk7HM7Kcqj3PSJWfDNFYP2QUwuQ8Dy0gdJyeUA?=
 =?us-ascii?Q?xbAE4SSxBf+/xlfzn5kg5EhKVSc5TA5iWFYiY3axjRP5bW7KnJAR+vu6Fu3x?=
 =?us-ascii?Q?3VsAbhGy7gjKcO4XOge3qcjWEW0gV7+Cw8m0+XeIPLyIH5wlX8YXmnXZJbJo?=
 =?us-ascii?Q?OTXq2rldFYvC7GtS2VSers8vw3JQaO8aAeEtaoYMWUQlYpKo6qD3RFvU9VLj?=
 =?us-ascii?Q?p1pOcCzc+w6SZt9FZlmRQhyUX3CE1cEjmHa8pcYzo9bm+lCektGHoAMutRil?=
 =?us-ascii?Q?Lo0VTwAJ+qevPy3amZ7ObbeZOI+JULFZLQsNZvg/ieZBMAu0fEUSEnuEJv2E?=
 =?us-ascii?Q?UbTTwaZQ5oOldVTMrt2qyuoqHyCPNtgKCEUQOyk/CvIkN/W05mCgJLFiHuEa?=
 =?us-ascii?Q?68uDqvg/HPEXxD9sukGx157AHMJsWejoM5nCFehYAc9Q7S+GIrprWcuw51Dp?=
 =?us-ascii?Q?g0KyNQO8Cbd3ax37hDHCA7VH3C6gsKTPYsEnAAjoK/rm/LKV00t1eFuwuFWR?=
 =?us-ascii?Q?N7K9q8SVJ/LUVxO8nWwAwGnuJrorkk9zblDiooMsQtgVmsZydSkNaw/KpQni?=
 =?us-ascii?Q?0LwlfGS2zLcdW9JKXeS88Hhn5NelEeyZ/04v/UGi8CchUpS1p6MLwPYlz9xM?=
 =?us-ascii?Q?SYRm5LA+jGbAaANwZFFiuIR/wS8ITBEGOucGM4wBbx3xs8kPvMuoFYRTtVvr?=
 =?us-ascii?Q?P6DfL9DziGMI0ggjWl8odi5K59LmhugiLn3yi0s/aTZxDPNuLcZKJPq7mMhu?=
 =?us-ascii?Q?rnsiMCP9VhDBCT88dwn3UCYvfMVnhTTilCA0ZUxU3hdLEVSqHjVc8nIrqy1Z?=
 =?us-ascii?Q?sTaZLo728t1r4yKE8t8P55xxlKNqbq5nWm+6lfSeVWoFYZ/r5Zty0lsIv7Dt?=
 =?us-ascii?Q?oXq6ld9CSHBbFhobAAr6J5UwDEZXH48JrsUIlbxW9xE0Chzhk3hCPDzFpZfD?=
 =?us-ascii?Q?Iqof54lGVl3FrMgMkoejNsRFBvqA3vGJEedAKAQsfh9aFYB/oAQNj188n4l5?=
 =?us-ascii?Q?7g3R4WPMREXbEz2ZzbCxN/lKnC2ea2G3VlFQxPt5bHxJFcd4T4UW+YK4GZ1d?=
 =?us-ascii?Q?Bthdc8/UhnwpJSB2LtQrSxxsP0zdnDX/LaoVQn2oVO53hjZoYZ59Y/v1cRXL?=
 =?us-ascii?Q?794kGWEF7du9296dSaEKBZRxcTiGq/EIa4kstl1mSiZv8QTvAcHYssrJxqvn?=
 =?us-ascii?Q?dVbWwzMkcd7m97JE4SVQuQW5egmEY3hid8YkuTA8nQ6TA/9idno7Bap7Wa0o?=
 =?us-ascii?Q?oczxfKVZEu9+F4j3cmvR576R9jvkFMsBK7yEFCsYq5RLSLKoOVwLYzfMYWCq?=
 =?us-ascii?Q?kM2W5Otxdnxu8sA9cR3hZ7O8wjcPRJK+g54gCbumle6eHFbEy+TQz9kGWghg?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dXS/PhyyS7osSQmJJBRfzTATgSq6Owf1Yeu0SSMWd4sEya1D0yUxBk1gkMwV9vvysIi7pX/I6fxJbL4xDKTlqeZblXwzf7iFIYLkURjScW8EmiaUzz9CRRI8ByZMjilkA+L/Chs93eJ8++cJm00yKmAWfHOLZ37DL2MAZE1axoWpVks1fhDE3s0pzti7P6xatYCDK7Aju8yZKE+VuA5fYd00+RZOGNlkC45OCqK9/8e+sZcSvaz3b50qTuJlrTvdH7Noh/Ry49JiXqhLJ7eYelT9N8Y2v1IancfnetIyNTmO79qRlkHhHWEeTxsXSuIYfQoHwJ4Pl62vZwopk5VyCZNVrzWX12G+ryHf8dOczTv1VBzPava7aALAFnf0gcItOUfrJ7+s1OGRESwqRI0ZKvWi8QLAPfAD4VrcLA6VyJmEIAboeM8kK2XT3JQf5kzald5dOVuJcukA+A29itcoxc8Lx6t/ii4JAB2EPYLfgIMSZ4wWYRKdwOCMHQFojs0j0ZCeFM5aLRXRk1tGFUzii1QxGzdtK3zN0mUvsYAsscr3x55lJwVqy4N67Eyhm8XC7HCjZn5ZNwk5PE4q9dEO36C+hOlvxTs0jUIjTt0JfnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddd7ca3-fbac-427e-b4dd-08dd88d154f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:01.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAJDljBkqooRdVSSjAHY6pW5UCQOhxWJgsYkY9aZTQLA7jRY6uItNGl5NWCwhQ1ViKC4M3tu6n4AwZrjXF6qYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Proofpoint-GUID: vOdqejZk0ggg_oz9n2NRDAu5imGJv5k3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX0elHSrfuXu1s +Yqc1im8ZYsO9CVQnewIKM59djgIEpeFT+uJk1Fo1INLUxVI1wUFikox9ksdJHUXq4jDLLJQJTF v6emG3OMpOJyVMPKtSNFqFTn8bbnvXVtQOor5aOfkL/Su0MvBaR2WIjk2hM/k5gkhAlfNtkXEda
 IglzFaRIlmgapI3uyOCIklHHmZ9gwc6827PDYZ9uOHzzu5H1r2dq1haSMMf6duxUyTFBD158SoC KDxTrJL+HXM0h4EgX0LpyJCLc39G4+7is4ReYrneQP668CJiweM+CLK4jdkWhPHT4ufnPX1w5q+ XAoCoe+Tq9hn9PhD3hq4l+yPXFuUzwblcu5N/kasIIQnzOMN8Hg69pgTUp8qkoXX62U42Qql3uM
 75Cce7oI9372AwH1qph+RuXwxihO6Ev1p0iaswktfPbot0e9sbjM4slpxRq9crmVrGddaeWd
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6813a840 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZG6D_t86WmhNJCCpPcgA:9
X-Proofpoint-ORIG-GUID: vOdqejZk0ggg_oz9n2NRDAu5imGJv5k3

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add a new xfs_can_sw_atomic_write to convey intent better]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   | 128 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_mount.h   |   5 ++
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 6 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..166fba2ff1ef 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,134 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_can_sw_atomic_write(mp)) {
+		ASSERT(xfs_can_sw_atomic_write(mp));
+		return -EINVAL;
+	}
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e5192c12e7ac..e67bc3e91f98 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -464,6 +464,11 @@ static inline bool xfs_has_nonzoned(const struct xfs_mount *mp)
 	return !xfs_has_zoned(mp);
 }
 
+static inline bool xfs_can_sw_atomic_write(struct xfs_mount *mp)
+{
+	return xfs_has_reflink(mp);
+}
+
 /*
  * Some features are always on for v5 file systems, allow the compiler to
  * eliminiate dead code when building without v4 support.
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


