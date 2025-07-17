Return-Path: <linux-fsdevel+bounces-55269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA6B0924D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B4F5A18CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF62FCFFC;
	Thu, 17 Jul 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oU0pgkn7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emqPycZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E12E36EF;
	Thu, 17 Jul 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771409; cv=fail; b=pSCTjdawZD82pq2diVaVr/Q9laRvsjfa8SYYc5GUIIYUGbzP7xEq3NzhlazwZCcP25cF9TnyCx0idSFTiDjiWog5HeaIDaMS0yWxXnNZGlcEpjNn89myeO1AXey2ROdTn+ga78n1I5yQlz48gijqsdHayz1qVFVzlMRbgWtiA94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771409; c=relaxed/simple;
	bh=9KzKlkVEc5TJ4Lp9AUbnw5JpdtFY1FkpGyF01JvBBB4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yoo7AGtPaXmzMegFs0mEgX2TLs9PWrYM93uatKQSsFRIMrBkooAwhGesye1aRfnpMU2X/dULtrmFuyzcbSq8mgF0hvU43tjtWWhtpure98OurZADPrqPo5Q5LJcirtYsa99PnZjC19ef7T6yWMviyN9N8mZA6efuIaDxhVJR6QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oU0pgkn7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emqPycZp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGCBeM029681;
	Thu, 17 Jul 2025 16:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=BbHi65IYfjh1i+yR
	d9/5yHrhB2ei4BhPdVFvb9tWd+c=; b=oU0pgkn7AiSn9FfYgrtFCLxMsB0wQZSy
	m8C4rjxoJk/FtigDLMt+XERiyEkZEVl53EbsNHA2tl+oNcxpUeLeRc0kDVmmK+yR
	pqo8uY9KsF7kdqEjeFSUet1SPcwSuzNxnFfewd1Jm7DfB8nIaDGjICEJ+iRFDlQ3
	FzuuZYF9R/t9dFl1+6HIAKX12wg31TIvLnl+Th0PHLkyh/mDmNReWFICVhN2ZdNn
	uNEXr+OAhYbOXZ6fdQhq6MVKiIoaUTHEbLOmhlPnbaIwXWe1lTQTo/ZbzXU68IKM
	ZR5js1WTw1dbdwXY5wbbSxclpby1Wjmcr42igfeFT+Sv2M+bIL+fVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk67396k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFFEFN011819;
	Thu, 17 Jul 2025 16:56:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d13w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvPfeBy7NpLzYdyoRzLpf6q1j3tOXvg4ynsRa/M3fD+wOc1ILoIZqwaRfS3bdv6JlpokhBDJIpMKslQwhZL8doGaAmQ9Q1hmSfwqmcweXWvndsMj6lQZQBWv/W4nREa2+2vJj/l1bOEWep0hb1o8CD1hIikyEeUJQZiSYQq3+8lZGEwduWbiOstZJAC9ZES54Eb1pQFqzHF/mnMroXbNiLt+PQn5wHaRgdhlim3yEKnzhS8dH92+u/ovtSJajgNRPhe+kDklirnTflOVjkFYh1oR2RZEP7N+b1zDeH6e67OjmK+p1m+AMW2O/nDMM2tzMTvy9Q2vtlgZQ4m8EY9mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbHi65IYfjh1i+yRd9/5yHrhB2ei4BhPdVFvb9tWd+c=;
 b=IirebiGDt9eCB5esddcA59qBehKgUoAWq0SArwpBUohh/WyAXgauVo/4TdAhCXNgrpzZQZM98ta95BnVtHJHKiQP/NiYpjY9b9RJIsJAFEe2wtAsu3iYL98CntMoIZCaW1tGiwRb6Icg9g/Ua3q47/t6/MxXQYQs67Nr5a/6m4tOLGojurhKU9Qb8U2u+FmLvWaXpamgi+aWez9kbAuy4WMZfbD6m1cS+IO/hTmU6Uw2hLGnYU/XuASP7hTPes5QwNFogcTk/xnN9uIJXwU6+ee6fQCpzXgz9KimNS2zMNJao1J+dhVLPvMab0fk9NpSKSLCtT3N/SNkBAIUzmNWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbHi65IYfjh1i+yRd9/5yHrhB2ei4BhPdVFvb9tWd+c=;
 b=emqPycZpYHbMeb/FU95f3jaA0EnV9sjA2FhHMoDUOqZ/9k1TuTe+rFtmBxFKrp4GiUMVhZvbWF3GPZ+V47hJPr3xgsWa2d+I9x4zTCtn2xdvq2fIr2lqUDv5zllq2SPy6NlQatZWvxpdmPu8X/iFDHefkuJoAZQduxidPHxrteg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 17 Jul
 2025 16:56:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 00/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Thu, 17 Jul 2025 17:55:50 +0100
Message-ID: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c718bf5-6fda-4dea-89f0-08ddc552d223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvu+rGGxTmeq7mdgGM1qnoOShoZYBHLI+GjTaW6IEqBHlOvhiimg++mAy9Yv?=
 =?us-ascii?Q?qMIQngFslJZj83AfycsUNLs6M0mH5WYWVMkwTg3fVlIxNVfRZ4M+J12gLGTa?=
 =?us-ascii?Q?HGWhCGax100w7a6xzaUBUILq6Fjh1fE56SkweW25dQvN6AW+QXErF5UZftWP?=
 =?us-ascii?Q?HsGVdx5JXIAHwH2nhimWewsH0tpo39LXQQQ0X51vmRaqsHQIe1gMNF6XtObv?=
 =?us-ascii?Q?ULtF9J4IgF7E9XPiULFbMC7NIEChK+yvUfvp6/IitjicnrGW+oHUIEeSkoZh?=
 =?us-ascii?Q?7v9FWVFHeapT8sMre7svO/fJ6/hi64eazwAzHzaeGjSaCQKuorFb8UOqZOi0?=
 =?us-ascii?Q?D4SYZtLvfap2biYyHX6jt0sD4pvVhWElcW5Z9VvWJRCH/3dU1n808nKWWWMj?=
 =?us-ascii?Q?qPw4PIaZJQVcFQ7DmBahs0oS+OaRM1iTI1uuih9WWw7Lehh8KIr/Kfmhz+CV?=
 =?us-ascii?Q?OiYl2OzT5sjOlwYuYhcq18NPN+OYrZoWld0M/3QMnuB0HHrVsRUhW30EtS6f?=
 =?us-ascii?Q?MqkCTKSBw88pqaBo9EzVsBYV/oRKjS56+yFhpJCQqeOBSxTkuTq+THFHUdvk?=
 =?us-ascii?Q?hY0koh6JWBbIQOsCwwjRMYtzHHbqfSlgjmAL/JTMWyX8svqbRjlHgbCtnYyc?=
 =?us-ascii?Q?Cxt8W6pGSUq9gd8YAmjbGJABO5MjTsEQns2vCwHPXYt84oDyTpOSKTT0Dq/7?=
 =?us-ascii?Q?vntvLKDTE6vErrNj6TgICWcu6Tnn6Qx2HRYto0/jAgLMSU3tz2NRZyxWP65l?=
 =?us-ascii?Q?g0IPOx9YfwbuLotE2BV0e2Pi180eL8uzfj/snqjzLnsEMBplzQpqpEmEWG+x?=
 =?us-ascii?Q?efm4FlIdR8/JB3g8iX+JooT0XWVNEfxBlhQ6gDJOD+vuw7kiO5wDHQj/yygJ?=
 =?us-ascii?Q?xmxDX9fu6zM3t2pEW5k8OZz7B6zGC0l0SZxx+g04jH0wcCe3okts2lT8A1PC?=
 =?us-ascii?Q?3TpkFWcoKU7L4mwaEHTKKHMlMZpJPFBPz1by+awmzptMg5y57ZK36CNmntmT?=
 =?us-ascii?Q?p9OAP2i/N2IycnN766SE5xnPebsMEG0CW3PigAwpUbD0q0pdux31A0BXBNEQ?=
 =?us-ascii?Q?61Zy4xbFsyZAGC0fimBqnmFhoqakV/pS9A1oFSaVGP+NrwXgzvxvBZgY2olr?=
 =?us-ascii?Q?XA5d+8mju74sHgJcfIwCWsvSsLyg4f+KiyjkzBfe4VBo6fRYXMXXuhtNg/RD?=
 =?us-ascii?Q?O+oTtFp7HPWZj0k8Z2JThdnRjLU6z34CQb1PjzRoUL7krGO3Qni+nU0lUxDL?=
 =?us-ascii?Q?SJQci0V4snNybopLTObcGB4P2O56pSY07T0uEdhg9MkS9J60KR7/6/PB8Miz?=
 =?us-ascii?Q?Wy1pMrT6e/sbgSgTfkVMbFNgM/UgNzD261rSlAJ2WAVQ64WO21Y3vu1UisUd?=
 =?us-ascii?Q?fMF+NEybyu4zWy3dxitsXPuFZ8tcCXpocEE6Cu6Mh7UVBDUjFn87gXvxut7n?=
 =?us-ascii?Q?w7IzvpB5GfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JBhdPwXxxBdbw+Uui0/kFVp/aN2ftMMX+ycOFjHjIi/9s6NUtyvoTvdZZam?=
 =?us-ascii?Q?6JzL2/u+sSdCmwK7EUk6vNtFv1zk84384/0Tu9mv4nNrYpFeiXa8JuY9W88j?=
 =?us-ascii?Q?hVDX79W4NxWlgYBEEEpzwxTeZQNWtrN7j0MMCRrUZ5/Pkp5Qj4gP+1HEL1wr?=
 =?us-ascii?Q?fNVMLpD7xbFuoABZkviQrS1zXXk/I7aDTGCoNZtDQwLQmfOCaUanDeVUZOuQ?=
 =?us-ascii?Q?tJq+paWOugLGCG9U6Z7DdgUxmwwX1fU+fXyLbdhrtyIRKK7PznQl0VPz/Azb?=
 =?us-ascii?Q?ZrwuaCYT5YddHbdwd4uT/UQ6sIZERt0NdAXRasMwf7p/2xd82CDB92vgkaQC?=
 =?us-ascii?Q?OczSYQ90/3/KKddjzKblgb0PloYOc7VfRjVDfbWvMc329H4xHNOOrjFoAuQ9?=
 =?us-ascii?Q?OKJETea7QojWAHg8rduxZrsxk47IRQNzpxt5Hd/zD0Hfxs0iftbyPFCSzWUh?=
 =?us-ascii?Q?e7OJkNmEWKF+bI20x1UowznQ1QSBnchCVsh2U63jjGfKtYWAoP+E2XxdK++0?=
 =?us-ascii?Q?Si4k+v008H3LFjlKVKcASQpSNq4Aoid/twbhey8yUTQd55h3/aWcSIqhZ41B?=
 =?us-ascii?Q?KPTSIyP74kjDHh2mn01GmTaXia3IGV+g0CVcjM7VCuW4ssoTpzvRi9FuxE9C?=
 =?us-ascii?Q?iUnl86oO8ObWK+HpLPAo+BCqTBdRo9xiLpnzdYeGGJTIeaH8UFqtJ7LU2CFS?=
 =?us-ascii?Q?lEqneJipSZpPtzIEio50NSZi5jzcuu8OazlQl7e92Ikd1gXrbHYk4BFnfqrJ?=
 =?us-ascii?Q?l7VI2i5Uhy9bytmlJI5SldlJnpkoT8uGxj5aKi6Eop6mwVAskzizkFKjSBv9?=
 =?us-ascii?Q?aML3WK3BtGXmbE+mGbRQda96+JAIG41qS/cWP78C7CcpmQ3gQahjPqEkjZ0h?=
 =?us-ascii?Q?0iPT4ISqWOPbnaYa7k07VbXgT7kzTLnkPzk3LvTy8Q5mOMZYM5mpPw6IDezJ?=
 =?us-ascii?Q?QjcshaRJtv+gYeBdnZQ44w7YaBrz1kieoYvXVHlSawIQsUXvaqUeRXPcWm7w?=
 =?us-ascii?Q?nqs23cRFcgtoxor34z5iuqJ2D7q2k/IlfKr7lm7F9Z9TB6X5olO2tshtKNP/?=
 =?us-ascii?Q?kKeoKQaQwJm8QJLXurOcKZJAV8k4OcuW/1wrl3dgwXFRsLkGtjm6Efck0Nvd?=
 =?us-ascii?Q?eAsfUs5SqFc7fmOdPTEKWGDFf30+umaACKKKJpLZRGy8aD6+7fYKCgyAVM4r?=
 =?us-ascii?Q?CbWhEN0z5XjY63McGxXAWiK0X/6OfXwptzJPXtCKIuZQjjrMwOpIJWBt5quN?=
 =?us-ascii?Q?Hva88AWmVrRsuZslosrMohEofbXGdVNaVb+yfhPkgtuZYfVkZRrabK9Uof78?=
 =?us-ascii?Q?6zFw5FGIekVKvpAA6R9h+Dre9Deez2S0HGoFE9ypxLnZ/F7CwqI/au3taBsL?=
 =?us-ascii?Q?h9ANkoG82ZbrhAb85h+4E3a+AXWO5AdvPaLmjQhVed6VoYf2mcSiAz4xW1yj?=
 =?us-ascii?Q?edOwicpGBQGJHYmcPBPmVUuenSyzLe9kZE2PhV4d/Bx4NaDONWIV7pHj4cR/?=
 =?us-ascii?Q?kL2JpyUB0YAw0X8xMYnnFqepRTTE3OkfrNHJ6ssUaoRQw9+Qqx9x5GrddBRE?=
 =?us-ascii?Q?IkKod6fuLodMbs2r3nN5XWuFf+8TXf2Kkgzt2EnuT+5g68p8vM7ViuKuMB0H?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eWiLL/XMirqbw+fb7nXSSQYfFSIt7IEu/We9MbiDZ1aishrjUXFdHVbcb5GoiOVXQ6PK4EEqa/rQVmCs+Zj8evDFX5foEFgzI7T68O2XUbTtS+aS6izVtcSRClVQwLAsTHKn6Sthe3ZHPerECPnuA47OZ/ORTCe0aDNPvxYd9JSxiqtXPLts0Kvo58dfoHaaMNmVvj6eqEcH0TEdcW3iwCxi7LXUipsq2L4VG/YMntla+FdcWgXUrBERMdhujN+4VC5ZyPfSOJyNFsK8UOEnjxxaO0pSLw4r4oAURzmdyhHwYbzo0UDnGDWln1rqix0JamWTCZD9x2MPjy9dr97JHHT18Yh3F0LDIPSVbGNEodecDjP4G5+mQquXV9lEEyus2rjY585Rssp+YJTTLosnSD7bdevtkS21zvr97WOJPwjrXCZosM1wXRHVsvbmZvn7geUM/xhlEAN3ez8PPZI7ywTIglFhSx/+F5Mn1LJc+Xdr7YBwQzFvUgv0P3SRS0RigpVfalaoUNRectYhpDFA7RLCCZq3IQIxV1tbMi4ct0OB5kb7mC2ow2bQfCT9F6fcZGS+D5/zmr9KJnDpQ9yeCkAEj6eujWauyE+2fJeXvjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c718bf5-6fda-4dea-89f0-08ddc552d223
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:06.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBuUDJ4xYLo02lwfLuLeJVpz2DAv3qXIExEejPSp8k6AFPc1zHlSafZlhYMVX8ZQYysdu+l2i0UtRDYY9cIVSSWQ7E3tlSL6A3KmWzcyhTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-ORIG-GUID: L0XX1jxdRaEWiYsHXXexUik7_vT2COUV
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68792b2a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=cHio3vxFbJXGOxi3Ld4A:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE0OSBTYWx0ZWRfX43we0nfEhPG0 IQVfmYjlNGEVVtt/WUoFWIUff1gIfNam1N92JECNFP8bZS3BsRU6cNNihWPjocKP3R+6ANRi1RR KO2vveFC7Z9OZgodKTO3xmjRYjcIIQqs/AsCG4Bthciya+8pD1GS8R5hJ95b5MLwKroI2rpeZtt
 FbHe0YaAISVRfdIqjlv+Zwmbd3zRjKqMfyFDoTCWGG4lATcedGyOU4pxyce1sMKLf0GfKoxM4Tm lJSJ2s14AvXGoBaCYLQqnxTwTg0BZ1veANE48+mosxL/qo7rC/nXUrDURalFoEMI5qjZUytfm3b cMfNDf0vSVJP6y5ZU0U9qLxa1Y8LNHN6eDFnCCjNS2OJI+OzCQmDepzWATFB5XQ5eqfK64/67Fm
 vlfbYz5oe977pvIexwI2b83EBdL2ik62+LedvF78HrMNNAUUALBmo2Cn+4wEIPaPuIvT7BH6
X-Proofpoint-GUID: L0XX1jxdRaEWiYsHXXexUik7_vT2COUV

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

In order to do this, this series performs a large amount of refactoring,
most pertinently - grouping sanity checks together, separately those that
check input parameters and those relating to VMAs.

we also simplify the post-mmap lock drop processing for uffd and mlock()'d
VMAs.

With this done, we can then fairly straightforwardly implement this
functionality.

This works exclusively for mremap() invocations which specify
MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
notification of the userland fault handler would require us to drop the
mmap lock.

It is also not compatible with file-backed mappings with customised
get_unmapped_area() handlers as these may not honour MREMAP_FIXED.

The input and output addresses ranges must not overlap. We carefully
account for moves which would result in VMA iterator invalidation.

While there can be gaps between VMAs in the input range, there can be no
gap before the first VMA in the range.


v4:
* Folded Some nitty review comments into series.
* Re-establish VMA iterator reset on unmap pertinent to move as it turns
  out the maple tree nodes of a nearby unmapped VMA can indeed cause us to
  walk into nodes that have been removed.
* Replaced VMA iterator reset with invalidation, as reset will rewalk to
  the iterator index, and what we require is a pau... invalidation :)

v3:
* Disallowed move operation except for MREMAP_FIXED.
* Disallow gap at start of aggregate range to avoid confusion.
* Disallow any file-baked VMAs with custom get_unmapped_area.
* Renamed multi_vma to seen_vma to be clearer. Stop reusing new_addr, use
  separate target_addr var to track next target address.
* Check if first VMA fails multi VMA check, if so we'll allow one VMA but
  not multiple.
* Updated the commit message for patch 9 to be clearer about gap behaviour.
* Removed accidentally included debug goto statement in test (doh!). Test
  was and is passing regardless.
* Unmap target range in test, previously we ended up moving additional VMAs
  unintentionally. This still all passed :) but was not what was intended.
* Removed self-merge check - there is absolutely no way this can happen
  across multiple VMAs, as there is no means of moving VMAs such that a VMA
  merges with itself.
https://lore.kernel.org/all/cover.1752232673.git.lorenzo.stoakes@oracle.com/

v2:
* Squashed uffd stub fix into series.
* Propagated tags, thanks!
* Fixed param naming in patch 4 as per Vlastimil.
* Renamed vma_reset to vmi_needs_reset + dropped reset on unmap as per
  Liam.
* Correctly return -EFAULT if no VMAs in input range.
* Account for get_unmapped_area() disregarding MAP_FIXED and returning an
  altered address.
* Added additional explanatatory comment to the remap_move() function.
https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (10):
  mm/mremap: perform some simple cleanups
  mm/mremap: refactor initial parameter sanity checks
  mm/mremap: put VMA check and prep logic into helper function
  mm/mremap: cleanup post-processing stage of mremap
  mm/mremap: use an explicit uffd failure path for mremap
  mm/mremap: check remap conditions earlier
  mm/mremap: move remap_is_valid() into check_prep_vma()
  mm/mremap: clean up mlock populate behaviour
  mm/mremap: permit mremap() move of multiple VMAs
  tools/testing/selftests: extend mremap_test to test multi-VMA mremap

 fs/userfaultfd.c                         |  15 +-
 include/linux/userfaultfd_k.h            |   5 +
 mm/mremap.c                              | 555 +++++++++++++++--------
 tools/testing/selftests/mm/mremap_test.c | 146 +++++-
 4 files changed, 520 insertions(+), 201 deletions(-)

--
2.50.1

