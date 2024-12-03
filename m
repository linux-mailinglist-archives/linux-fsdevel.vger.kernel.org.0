Return-Path: <linux-fsdevel+bounces-36378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D027C9E2A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B407284F50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CF2040BD;
	Tue,  3 Dec 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oXT2jfMn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b3SQ1GvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FB1FECCF;
	Tue,  3 Dec 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249163; cv=fail; b=Q3HRFFytavYpBPsvm87RWC3b+hWAQOZmP/TSM8eC0mkurL7s3v0UHaRvMXMN3wFBqSJC534lGwVp+JIYH0GKmc9Tav2irJUdz+pjo9YFTUO/2Cj3rcHSfP5XNcjf2KfbgbduJTPimQulP39ygaIv6cmzqpn65kztJ7JSjqb5QBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249163; c=relaxed/simple;
	bh=MFjaAUlp7Ligi12p8xZMO8mJ7xswaeuGlUCXDnAvqSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcotIelr8Ad89lpRAjaA1kTtPQGaTRQC2H1vfJvLtytsWNYudUBE0pEq0ydCsxISI1W2xgZT/kyjC83CIv9LzGBMD6gPSuD6eMHpnB+Afk7IneMh287p/ZP4QtJDaFwPPGmnmbfOJCWJYReY3gpV8FjTonkiOoBNQe9Wo9GxI68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oXT2jfMn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b3SQ1GvG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtaHH012461;
	Tue, 3 Dec 2024 18:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+zGfORM8vxcqIf9zAHTcbw5ZwMMMROGOU4OV8XXGU0A=; b=
	oXT2jfMn7oeEfjVs4KwvhPpwee/RtO2sjPAbwq1lLGu3tTTamI7z1nX0j57v5ir3
	dxtKonzJW3HUdp+k0Pu2WwGk+V5NbnGCFPUm6KICvtajUlh/dk/OzCw8HyIAlWSJ
	CQNNjguucI3yiLIkdh4l7ieTa5zIt1vf3+imD6FyJY0iPat/k+dzgu77mxSfcMN2
	k5eVcFcZ2qTDBWCljKi8L7COc9ZwGfTrYdvrCIbnzaLcfuYAvUPzMCQSUSmAv+zZ
	Mckp6lsch5pcgoHwX6I0lhTQqEhFKSgygn3HFkvfFVt1yK/8JwlVxpb9XjS3mNIV
	mY62BM2f7PYxXXZoqP/UBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c6nsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HBlmm031373;
	Tue, 3 Dec 2024 18:05:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836u8gfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZoNH+R/bUAJC56npUCWew4/jiQ1O1AUJ12PO1p0PQFVoSa0ZAbYl+mnhHWqUP9DBb29wlEsRoDPymSJD7LNuDHlxnSOu+ReOSsiT6nHHq2v1K+qgHlYEDIqfU5+UEzknr9EqrAnbpog44C3WQHK9WRuvLzXCcdranLlnhMAfIYL64jb1CIf2msMlLQOZFyJjKWy7Rc668Bu9smDeIoEt02mbRvNpyPipM7FmbNqDGSdfTsRLOSRgQrHvG0EJwdWoAdrmwDLTRliPYGwiTYCGRRH9MEzFtdPfQP+4EU3D+gxchDEpF1aiSLa68OkWu9a2LBBFMUyXB5rsEclfiSYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zGfORM8vxcqIf9zAHTcbw5ZwMMMROGOU4OV8XXGU0A=;
 b=fHnHsZBnvy8GyHnIWaNOY/jv/u9S2WSIhkYr8fR7WoG0jT8+tAA7lEVQy9Q1GfsU1KDKekj75rGwoeHJqifmNnGl+5zDcQHGaqjbQ9aJaGYPaXYRnpBDtB3h2mmZr7jcVGA6tC4wuGmFN47UtMDbqj7eVBF301Bowcc173kGzNu7pOz7IZN0xDzXMqJyI28sy/+QI+PZoDFdLv3PeceDm7EyozLttd6j4r7bsJHZDoESmVJEuvFMcfCR0M1VdX00RP/VqdlVPYkrjKuPRtsZbPJfKNYwMb5zqSlVQNgYmPNaGmJjk7FMOW8rQIt45Fn9+hWR6Ar6d6kt/gTicPP7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGfORM8vxcqIf9zAHTcbw5ZwMMMROGOU4OV8XXGU0A=;
 b=b3SQ1GvGnI6puimNjnDbQaYaWSN398n2/CWwqfDLIvDpc+6EIA2U8Wwb1JGgymnys87Lsf1K7RbQSgpjafxU0v6752Tqsysuy+tb4IFk3qcR3jhm00yHR0i8NqLAgA7pGbtBqNVIUr2SQgp+wYZupJk3Qab0FSmOvy35LmFBVbY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap read lock
Date: Tue,  3 Dec 2024 18:05:10 +0000
Message-ID: <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dacb44b-3662-46aa-fa41-08dd13c51629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o2rRmFT28JhEpUEfFSjsCCpDTA2FkoY94E8UTcm5ly+fMW30+gR22kOMNtTD?=
 =?us-ascii?Q?2s94m19Z2YlgA4feH9l6lvwPoYIVU9xlqJw7C4Gvc5Gg5c52S4MSo77qEaFN?=
 =?us-ascii?Q?k2CT6E+qUc70cjqF0ROai/cLL1ofj0o5SrWgFchOvInMSM6ZR3wRBVKCvE/w?=
 =?us-ascii?Q?IkwjZpfi/VljnuvRZvzZGNRByCuBf2a81Rxk93xAQsY5OILsW89dzcF+HNnZ?=
 =?us-ascii?Q?ETYpRxZPHlyLLAH736IZW6yLGsq/AfqKPOV1O1vLO6LBj7/rMaqeuly7TmnB?=
 =?us-ascii?Q?JdK8aTq+ssTbolHAHSgN248cpBMZtGsvhYCk72HjHT78vtTFjsd5d1L1xvy7?=
 =?us-ascii?Q?PthlvNvVONET5Jx3ALXcFEwGmezbKtrMWvSRrBU+cbh2k38Yl4d4GxbGcPeX?=
 =?us-ascii?Q?zYebGRjQCGAog1Zzz2/YT0fFqOSYSOzAaEF8fgDP3rGXbXSdP+MHJJYi+0Vd?=
 =?us-ascii?Q?zJ09PW1M4nOCE0bjfcy9XiW6sBkVbkbH1eYlc7nfJi3LuwehGBJMRxera1KV?=
 =?us-ascii?Q?chUKYt6ngJwiP1yMdYHIuGbOU2WrVKrJxPlw9mwaO5+o3FXerG81Lojvm1dg?=
 =?us-ascii?Q?WXBPaaviC/sTPKLAL7oX9zHDcJ8IvkrSZn6O6hRuTBPVKe6gG979HzZeGElQ?=
 =?us-ascii?Q?D7f5uOnxYZoiIOouWZpVrWE0tkcBysb7bdPmPV09Gkqf3hhci7TSC73LG5XE?=
 =?us-ascii?Q?uLFKkDTyNWPD7UjtNjhcrKr2ud7D3dhZeIxMUhi005U3Yat0ktrzbwLytWqp?=
 =?us-ascii?Q?7AmLQz1zuZ7JIk3QE7n6BXh9JzQcH9+llspOY1y+R61Xu6u4wbpyMyi+j5yO?=
 =?us-ascii?Q?91/ek6rynPjR6wrxksJvE602UQwru5Sn0A0sLx0NnEPZh9hE6A3kRDcLRgro?=
 =?us-ascii?Q?T7Cd8fi/tS68c4SgOKRWA+T73XYJbcvFG3NLWWkDCPEC8NN5q3grxhQ6jcIH?=
 =?us-ascii?Q?geaOxmjJ/LzxYs+hzf9JQrUvPTBrl/d7aMObdy76W2I0dUQPgjLMyX3W4KF8?=
 =?us-ascii?Q?Eyg1t4v0k4/m+fov4OCYtgutyTLrB2AMyIW0C0eUCX2Pk7JKFHDTO1RkaZR7?=
 =?us-ascii?Q?8NzJDPB1XIlpmMiIpWm3p9+zQD90nNnPG6crf1DsF8CnADVZtnQ1h76SlII5?=
 =?us-ascii?Q?e7QcTh5Bp75n1q2BoB5VVd9GcKSo+0lHHbf7/sUZqiwT17pqfjZBIsyggXXM?=
 =?us-ascii?Q?BKm3jCx3I2HQCjkUqexwOhZ372crufJrz2D4tzb1UTU1+3EBtA5mTsvT8LMN?=
 =?us-ascii?Q?/+nx3RBpr02BOv9otoBxkquuZGG432jGCWfYQRvTl0ZsSg2gpaIaHJhOECcL?=
 =?us-ascii?Q?8fLYcpE5EKeqJH6c27EIg1jJHaVgGnl8yoQ7YCZRn9TUQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?occjZRIeZ6qr7jM3vm9ia/WQIwFbw8tHM7mgAkZweIogf1QBoeZD1xRqD6Aa?=
 =?us-ascii?Q?p17MjsCBdx8ipiySG7vlBRcZBJW0T7C0LfSiO0Zv2FiJoWGaN6eRrid/PTu2?=
 =?us-ascii?Q?x+BrRD4NTBn0f2WguQ3KdACw2iycNHj5qISHknAsqxG4+Csu+BhWPj8oK2oQ?=
 =?us-ascii?Q?jewH5gEBiFnLx4SjU1QIwtnikTKvERHupvOX5mHwNWTVAnEv9jK9cevsifIr?=
 =?us-ascii?Q?9GH74Jk791a3sfw52yJrgP7WxmUH/6JhfEBQKZ28dFtHIq1iFZO+R+heUEJT?=
 =?us-ascii?Q?RDB5NuzoBqaWBg//nwXm9OUVGy6D5wsqpYus4c8/2dzVMtCwC3wudL9b6G5p?=
 =?us-ascii?Q?TQfxrS0bTiSFRgG1pH8IsYGqqsyurmqXljrQBa4zz1S++9O0a2X8apwrhRc4?=
 =?us-ascii?Q?3MxE6qdoj0xUuAceboeO3enA94htMXH+4jcPObU5lhyzFJojjf6c00MqMxej?=
 =?us-ascii?Q?i0EAYMDtjnUcWWgbjcUGR2fKxutOEloGYN08hqklW4QTDqKGgvHEuIv+1dRo?=
 =?us-ascii?Q?cZe+gWhe006HjxHTtDcH7wEvYQHTawBSowb5W3fSOv7bBHuxSwr9n+v9/kft?=
 =?us-ascii?Q?LJ6fUw5WmhaH0tB4VAUl+A6J+MtaueEFaocsb7JWl+u/MR3DtTUpEUB+TOo1?=
 =?us-ascii?Q?W6LxyG1vlx7/vtR933EfrxDbiwQRbRl0zUnutp9mCSvDC2PS7xdXtpOPvDfX?=
 =?us-ascii?Q?A95P9heB+fMS4WMKGfKWrjjOwbD9TXQ20GFX54Vmwz99No59H4EYbGerx6u0?=
 =?us-ascii?Q?LByONxyHOZduSOOHDKEKXJMb3yEzWnTwpygbQJeWqIdT4Xuykh16n2hgsSu9?=
 =?us-ascii?Q?OOfbJqY0G+1VyNGJazjgATSJclmCSfcb/5tffVD6/v2YQOJmBq0l3jxfNUyb?=
 =?us-ascii?Q?QXlBLaWHRvRmV9EDeuFm17AsV9dx5JyC1p5hz2Ca1jpijoID8ZMwBKNsNM+z?=
 =?us-ascii?Q?Bj3gl+cMwlBw3PUm8wUuPCPFuIDVjw6o7/x6ro2vB4D2ko3A++l2XkaXvF6T?=
 =?us-ascii?Q?Ls06N4OBAV01P21k41xhCYzOLz1xDKOMP/UFQiTFaPn1TexWRiNS7koE1aTw?=
 =?us-ascii?Q?D9enlfvdQ6y43EAe5CPTx26ljPli4fllqADfSzxKRAU8TkZbM4asjpQ3v4gN?=
 =?us-ascii?Q?U+uX06GvUqDEVWpjlAu5EUuBhBy4dJUhNJQLSau1JMtSvsiJvnTYbYiQ6MVd?=
 =?us-ascii?Q?mZHFl9qWZ9bJztcG3AEH92GMzSsoxTay7C29er+2zJAz/Ld5ZhoNZyHCkFRc?=
 =?us-ascii?Q?y9soA8fQD4hWHia90MUPk2zCv76c/LtQwKpDwWlagCQImdEdAZjSQWEaydCB?=
 =?us-ascii?Q?JCxN76VZHNTpfGhkU1wqPLO78vQrXpwPTv0/MfmMjUlAJ4s+KM1Boql24xXe?=
 =?us-ascii?Q?3f0kgbgiHi0Kurbbmii9hk5YjvIsa/BmmbTNcoTfOe0EZArrRge5GzTrGb3Z?=
 =?us-ascii?Q?6NF4QMEpU1Goas1tqJ3kWljYDgZTnnfXWChjYPu37XnphCMAxJIybFcutEXI?=
 =?us-ascii?Q?LGKwjpyyt8FWlDetEG3eQf1ZrfOMS+c77ejyop+YASXTQShO4bKx3P/+wKiC?=
 =?us-ascii?Q?5v0K2yt5/tWCMquWK54Pw9DwuWGvyRbNWc50TU7zO6lv+BxvcIktQVVholfd?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u8gk3uHn3Bhow4/Qy8y86XL40uVM0p7Ghd7oJbzANO5rPVLQIbppjY30i46nyihlAy3rjl5bFXe/1G/Fq7DA7BVD3YGawRjp6boy4lHZtVElz98VQWjKtDhS2F9act4JUGRxOROYvicMp8k/bntCrya30c9DDmKPQA2PVc2TK3XqhxAP5mblSGCO3XnDiYXckleafm+lFH/sv9B509w7UC1STRPZZizwCMzp1gI36BMg2z33gP+IJyiNXlkbVtwAoxg+dmGLtB8xEJkfRc1cOPA9tJV2DVW1racW+vhK48l4X/SftjuhUFjx9fXfLITKsR2aabkPayZwHSk4pvtBKjYZitDniHzlEk+bG3QnD/85vKztixl4vO8NLOXWJIsIGDSvrKbHHIn4TO4rRqnNqRDeIKID/LDrVic2f4X8meIoPNKhb5tOP3lEjSAGtjQanL/6vqi11FBJ2HjRm1Iypo2VDJ6+CQQtoTqlDJicakpGVyCDxvu6CVt8+n8icXXA0sFnjG1tzHcDomy0NX9gDNJykgcchsRf2K9HX8J3ig5hd/urlkZU5AL9jNIvgFDBM9vp6kPZbY+uy0KHFOw+93TfxLxnBziFdTU83ptq2ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dacb44b-3662-46aa-fa41-08dd13c51629
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:36.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFzTcUNmv5TME4Sn9e/mw+gMzgI3LBIRdlqeVGn6h/Jfj1AqjWVD455zNayqPLQAjk8lj4EzTsYtkl6PaeyOuJUH7uyoq1bYBd0dvF5vOjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-ORIG-GUID: Lzh8xQqUisEYwiz-1sXK-ou1lh9FJ8o_
X-Proofpoint-GUID: Lzh8xQqUisEYwiz-1sXK-ou1lh9FJ8o_

Right now fs/exec.c invokes expand_downwards(), an otherwise internal
implementation detail of the VMA logic in order to ensure that an arg page
can be obtained by get_user_pages_remote().

In order to be able to move the stack expansion logic into mm/vma.c in
order to make it available to userland testing we need to find an
alternative approach here.

We do so by providing the mmap_read_lock_maybe_expand() function which also
helpfully documents what get_arg_page() is doing here and adds an
additional check against VM_GROWSDOWN to make explicit that the stack
expansion logic is only invoked when the VMA is indeed a downward-growing
stack.

This allows expand_downwards() to become a static function.

Importantly, the VMA referenced by mmap_read_maybe_expand() must NOT be
currently user-visible in any way, that is place within an rmap or VMA
tree. It must be a newly allocated VMA.

This is the case when exec invokes this function.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 14 +++---------
 include/linux/mm.h |  5 ++---
 mm/mmap.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 98cb7ba9983c..1e1f79c514de 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -205,18 +205,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	/*
 	 * Avoid relying on expanding the stack down in GUP (which
 	 * does not work for STACK_GROWSUP anyway), and just do it
-	 * by hand ahead of time.
+	 * ahead of time.
 	 */
-	if (write && pos < vma->vm_start) {
-		mmap_write_lock(mm);
-		ret = expand_downwards(vma, pos);
-		if (unlikely(ret < 0)) {
-			mmap_write_unlock(mm);
-			return NULL;
-		}
-		mmap_write_downgrade(mm);
-	} else
-		mmap_read_lock(mm);
+	if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
+		return NULL;
 
 	/*
 	 * We are doing an exec().  'current' is the process
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4eb8e62d5c67..48312a934454 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3313,6 +3313,8 @@ extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admi
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
+				 unsigned long addr, bool write);
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
@@ -3426,9 +3428,6 @@ extern unsigned long stack_guard_gap;
 int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
 struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
 
-/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
-int expand_downwards(struct vm_area_struct *vma, unsigned long address);
-
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index f053de1d6fae..4df38d3717ff 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1009,7 +1009,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  * mmap_lock held for writing.
  */
-int expand_downwards(struct vm_area_struct *vma, unsigned long address)
+static int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *prev;
@@ -1940,3 +1940,55 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	/* Shrink the vma to just the new range */
 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
+
+#ifdef CONFIG_MMU
+/*
+ * Obtain a read lock on mm->mmap_lock, if the specified address is below the
+ * start of the VMA, the intent is to perform a write, and it is a
+ * downward-growing stack, then attempt to expand the stack to contain it.
+ *
+ * This function is intended only for obtaining an argument page from an ELF
+ * image, and is almost certainly NOT what you want to use for any other
+ * purpose.
+ *
+ * IMPORTANT - VMA fields are accessed without an mmap lock being held, so the
+ * VMA referenced must not be linked in any user-visible tree, i.e. it must be a
+ * new VMA being mapped.
+ *
+ * The function assumes that addr is either contained within the VMA or below
+ * it, and makes no attempt to validate this value beyond that.
+ *
+ * Returns true if the read lock was obtained and a stack was perhaps expanded,
+ * false if the stack expansion failed.
+ *
+ * On stack expansion the function temporarily acquires an mmap write lock
+ * before downgrading it.
+ */
+bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
+				 struct vm_area_struct *new_vma,
+				 unsigned long addr, bool write)
+{
+	if (!write || addr >= new_vma->vm_start) {
+		mmap_read_lock(mm);
+		return true;
+	}
+
+	if (!(new_vma->vm_flags & VM_GROWSDOWN))
+		return false;
+
+	mmap_write_lock(mm);
+	if (expand_downwards(new_vma, addr)) {
+		mmap_write_unlock(mm);
+		return false;
+	}
+
+	mmap_write_downgrade(mm);
+	return true;
+}
+#else
+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
+				 unsigned long addr, bool write)
+{
+	return false;
+}
+#endif
-- 
2.47.1


