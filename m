Return-Path: <linux-fsdevel+bounces-54525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5DB007C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67A01C46D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418527E066;
	Thu, 10 Jul 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dr2UFHxT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SjyfsLQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186927A914;
	Thu, 10 Jul 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162721; cv=fail; b=FK91eiRfKTwNZwUG6XKELeQA4oxVBY3NIqTK1mF6npTac222wPmiqq9e0inhePhWc1ij+SlJjuxb918DgxzPV52yDw4nDWwk4lVEatTAQCRiumwV3BKY5GMgjFYFAZFYGyeLxLUqdZBMZtNOiG8bmyU/QuKuz45P+xiW0YyEH7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162721; c=relaxed/simple;
	bh=eX3Bt/Q2HgquhsnAvOucKRuVpaGYip2k2QEYy+Ssdtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtPzN14PAc3C5uZTG+qorZAxWy5x78QabfGxoasmQABCU3oDEKrF83ONjhExVqPYGYOX9MiOux+WEd15aZCAdHo8Kd64KnJVZMJLD4Go/Huw4WWB/JRVb/e2Pv3qm4XrC8W/U/IuqLOOk++LcvhhbTTk59zgEUW3og9lehnq98M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dr2UFHxT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SjyfsLQz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADHFmQ019859;
	Thu, 10 Jul 2025 15:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=; b=
	dr2UFHxT+Q2SxFYYrs+EN0p7k0BASql0bnbqUitzAn2rtIMK8Hao6fkPrZ0uJ1/q
	++iO4GrYkoK/EFyafhuraG2eOCGacUDg8p/LAJziRCajbTca1yn+0Xp32j3R9M5t
	v1rgA3MnvtsBKr3vs+s1EPmLnke2tPAYp8GCNk6PebK8/2BgGICGAqCsRK8bhA08
	30v68S7wjhDRixwG4bn2aYjn9X/S6zEiU0D4cnzwioj/68W19FC0iS+7cIzIxNRB
	RC4TPflWtPIIc8idVYjpJkiojmDFy6TzTkobw+td1WgMA8J8ZZMPvKEqHxMUtqR3
	ZCmUGZZCeMRmYHHz0lxOOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47te8w0drq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AERlYn040590;
	Thu, 10 Jul 2025 15:51:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcpk6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFzAkKBZePK92JHDkLAMrftF+VlWCeXdLUlRAc9CH7AKA96kHO86k5Bvkqr63nHZ7mzW/9soR6pQdB9Pn/rt9LvRb2X6MTNlqbt/tRkCfN/erSB8Uv1/nwZxtBQoUw4W8MuUGzRp2badYe6OtcVipkl6RJp2GyeiHVAs8rQhPw5CHlRSyoJ6QUkqZOrpIvbgVlGrxCwAjB47rzfam1XHJsRvpXegiU/OZmxSJrjkWSLYQpl+KdVepqgIIwJTsunTjcw//qeppsv6hDLR8BodMQ+t3sVn8nfmg/oxgyqbP0UxKFsgAf6zkDdkS32ci1P9wJ0i6Etx8fsjZTJeP6Iotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=;
 b=S2vI3T36irlPWYi1hS/rXEwMEbre7VlKE6WkloRRDKfO1Aw/5SctCtv9w84IA09Ey+L8Nzu6aRBfp9mfEyQDR99ETFgyXUuLDwq3qAknizR7iC7GTxZzxJ4xvHzQq1dZ+vTpHDTnQ8+D7/G+4xliSCIl4hzRFZTjyi7gALoWfiD9yx1vs8ly9UtenMG6YnHQ78xUVT+g/EtVNHNmM0/6rObbTzdSiyn2mMr09OTccULuua8MHw7bQgRX0AzQ8Q9TK40FxTkPq/VpRS0zqnxFADwbztkP0HQiFNBRYL8uBtXBfl56JlKHDq0oo8RCWabiIj3gqfmEu3TDcvyy2aOHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=;
 b=SjyfsLQzBwOQS3HFR+ffg6X9sAOVOq0KYhuL2rCSEBjXc8AiS/jjmG4PP3+RZbgMIuAZiNZOGjvSbL4htep48qc//WWZZoZnH21xx6ECav1WkJa2nJj/xXT81bZFFqg7AJCIZtH+M605TwN/FgpCU+5KM3gDzTw7QwomIrvW1To=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 10 Jul
 2025 15:51:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:51:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 10/10] tools/testing/selftests: extend mremap_test to test multi-VMA mremap
Date: Thu, 10 Jul 2025 16:50:34 +0100
Message-ID: <7acabd9cc083b48b9a9b5fa2a4d66a2d1c01fd69.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b9cb29-fb13-4575-a655-08ddbfc99356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcfVWoc8SwdGIp680n8VsL0r6RY3k7ZDC1APdpto6GbRKdFicQPmWzhkCItt?=
 =?us-ascii?Q?d7Zlu80vJuCf/ZVr/84oTumF3am6yglq5WCGwdcfbMkZIij+V3x4NcDoyUFM?=
 =?us-ascii?Q?cOtmQeedqSxz0c80G4pBBxOR4mkV+NdEVw663RvmVbZKqdR/KcItjb7t7ZEJ?=
 =?us-ascii?Q?z5tBJOJdiAyxxugD0WGCGJka+VTYZef5HOhQ0PFRVsnrkGVVNF+jdkFX6ceS?=
 =?us-ascii?Q?YGrMpkKnaNssS+6ZQf6adtmrI0+LbqZhu57Ze8R/3LYSa9IYrKKUaa2SVJPg?=
 =?us-ascii?Q?XY22MtHYuev8Jc6gKdaP6IXoES5Xe0HabOqp4wC12oJCcPfl+7qoxDp22TP/?=
 =?us-ascii?Q?wAQAt7J4F5Fu1ZxorPeskyu+ADbDEBzAZ+0Y1Zm6iRNJ0UTsYZNL2pBPcv3v?=
 =?us-ascii?Q?x7mWmcalcndqIgWWD0OhkVRp5A1sWzTmq0WhtKxBq0Hi01I+YPA7cnbnmXTa?=
 =?us-ascii?Q?kkSULE1AKjx1gsUJ1mhegVLWrO4IuqHtJYlK7zoTcIbErmYuAPYe4+yWqkNC?=
 =?us-ascii?Q?xk8x0dth8N+3TOFx7rVQ3KCxgTbpyKJlcAx7dUMgVNONvz1SqLTenCA6j7u5?=
 =?us-ascii?Q?EdfIkto82vy6bK1zhbnbSR2nAiYbfBXBWqokOjZ9XU5WT1YrKP52aWWKEHuS?=
 =?us-ascii?Q?kR7DMXR4b1raPn1d98vWEJlfYYkSJDGB/9bIeCHhCl33sSOWrFBDP5Z0mB+X?=
 =?us-ascii?Q?3MdhEcvVGqAewYjATIVKvTecuUXK1gmJdB+a7bi2dMrICFXQ5xNStgGrxDdO?=
 =?us-ascii?Q?jTjcmX9A9VceVgMn9UeX/8UdzKsBYo5aUhgnxWn9aTLUUZca9gB0nfaKi/wM?=
 =?us-ascii?Q?fncw+ZoQLGFqYkUM5VOJq8EfxoqROBW0/jeuD5qGyFqYGQibrB91a6mvk5jW?=
 =?us-ascii?Q?1wY9myDxgu6wEq/AZPj+ZS6jKG65ZS2rC/RCvqokKUdqecw06LsadLAqsXVX?=
 =?us-ascii?Q?TEgK+CfhShSjVXzg4zfXz8n6bpbNYHW63VxKEc7w+JrYBqyK+vb4kt3YZHhc?=
 =?us-ascii?Q?DvUnXo14PZBwG+LTbRP/YSxV2Kv3MKVnesZgm6tHjeSGOpMcXjBFrSWmAKLD?=
 =?us-ascii?Q?oLCa1DA1zb/9q6NnSihMLYGJmCEDU8TbsmKCTjMleEr/olGKdej9TUM/Gfwr?=
 =?us-ascii?Q?A3eXi0HQ4wovsnu0aRoazjirDs86kuDfJN8UPKJztZBPOvwXErDPur6ccSQD?=
 =?us-ascii?Q?tdr8JUb42Z6/CuhWHiVwThfpg7gdXYpy8NkowfC1MRE0JPfOr0f/LmWzE76z?=
 =?us-ascii?Q?OFMh9L9YeBU4OH4+v3prhhq3mr0dX7xO4fT18MwrVl7zXkd87p9pBgf3NshM?=
 =?us-ascii?Q?8XpvUC+NSizVdFn5kklQHZe9CG+T5uOS/NghEoxWHdhCpADDARIqNf2LqVnB?=
 =?us-ascii?Q?uAnaEMqUk/apuk3RP74SHX4syvt5Q9ZKfpUHIEClvNezlYiK8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xCIeqNnYlNw830w4/+fOUYE8AlmprLkH+7PNyauluDFs+ZXuICIpcGuDcTrF?=
 =?us-ascii?Q?q0zXDbt3GjT0SMVHzSO9x7TtTYcDb5EnKaroz2Nvx6t1RFm0PTOslS31g6fq?=
 =?us-ascii?Q?BexXo4XnlVfrfZu4GOuIpcsvZZP/djX+htAccc+prFw0NUAIEWEXqbR0Pdl6?=
 =?us-ascii?Q?O6ZX2lgz26ufBNtyg5CZ0jhD7J/1LUP/HolM9aX1GivSMnUeIBwAjSZskoiE?=
 =?us-ascii?Q?7gVNmfi3rQSOp48KylhnkQfezSB7T0Hq6lXyCx5zVCpHvqja1Ro08Q4inGa4?=
 =?us-ascii?Q?RcHwUCxKii9Qv59egWr1P8qLEGPI1c9JUlZPYrq0RX8YgnTAk2slWTcPRc4K?=
 =?us-ascii?Q?KnO/b6R/JbhXojqSquYG61JZlWgOOfIfV24M7PEJ4xSeEv/avjh7ntLaoeJf?=
 =?us-ascii?Q?rMrOwz40Qdj6XY7WY2JnC/zgG53OsIbt7ECcy+jo7rRaso9NDtz/9/b7aogM?=
 =?us-ascii?Q?lXdo/jd8pGOuD3hlbOeOo0UBi4PcEehP+S5BS0m3QYmJ8pYrpgBdLBUmNoqB?=
 =?us-ascii?Q?FL2JdYIxoGMDWt8LWm/zrzSNFipAYt13G64cPZjKC3sqAAYaleWGH29+naPv?=
 =?us-ascii?Q?iHFiIa1DMF5z/XTVYSwJAx/iiv1B1PwsldXMmc//tlya6PTR2CrC442T30Xr?=
 =?us-ascii?Q?lnT1D63D3uSN2aHO/WIW5fzJCji6YyiON0dHuV2lx0JBCK1WDE7nmcXuSJdJ?=
 =?us-ascii?Q?UvcB3UkkE7uv/CEgIpUgM5MrzbKkWRnCDZiDGYjIvYbU30l3leO2PYQS1QDR?=
 =?us-ascii?Q?Qhtu2C+lKzflgJe5J17nU5DIRgrAgxcCkhbd7b+4SoQiUkPCKXOrFGg1DZlW?=
 =?us-ascii?Q?wjElqRHInn7jtXCv19jN8zkKqVUxcDJaC80T3WK7i3Re2EN8KekXpkuIdhUR?=
 =?us-ascii?Q?1YUWry9mgcIarbtYfo9XMZlOta0xSx1UNinn6UVo9mI7428+jgLkICah75Jl?=
 =?us-ascii?Q?MLcTR/Vs9yJ3PZF8wkIXF7tROT2uHbwniEYzH/pu7NRAmp1LIhNTJVXR36rh?=
 =?us-ascii?Q?9ZgCZrY64WEqwE72Iwvy2toQBx4/lFqVtKFnZ57r9Xe/2lBmD83rQFQIDdkx?=
 =?us-ascii?Q?sH1tGghgLg7t9TrRVKvFM2j/8DxGCmttVcB1ThgpUH1+2l5Dbqwh/QUB4NKx?=
 =?us-ascii?Q?/AOQKfFkGW12bH56Qho9fqaL2a6rDkDoHBhRzWgufozUJKIH95wS/mB9VEnW?=
 =?us-ascii?Q?wzNmsgBF2bhhB2gZsgawz6Q9q80k58Ii0aFZOydO5K/mGMDCkR42EnKfTiJS?=
 =?us-ascii?Q?fbvsQTMzgCIk6LqgnMsm1Y7wMsAzgizcZFwI0cpXpeOHRKPS8coMW6jhHj6J?=
 =?us-ascii?Q?uEfw/Xo/Ft2sYUiVJ5oDdOfoQJFD1WxGykwDlPFPly6hShEi0ayG4lkRVsdQ?=
 =?us-ascii?Q?kKl2qQbMLxroysmiQ32nXFxIaD0FUWTa+wp1z8fyi1qr+p5kI17yM8f6Tbt9?=
 =?us-ascii?Q?fEuOekZYsn3F/ZQpCRiZo/Wca3Lvlbos5pgfu8b8H1YFvniEww4uulLnvDQj?=
 =?us-ascii?Q?kbKK2vVk1Uir+2xxyC6katqfw5XSzxwOffSDfSKV1prox6bgIV0YYHnpU1IH?=
 =?us-ascii?Q?k7gzHEJ6nVDMObmkvwE8uaq/Vcg25qhiHV4D0D3SSN/pLz/Yag+K0ZHCZsXD?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jMaff1csFmefAo6SwGQ6k0JNd+5+BN1j/phXUAo44O4yDCz5oDdC1SkTmXkC1xPU6hUQ1BoBmK6nrht//KmuRz/pmDrUN5XhJbhvLbxzEO6AutyaV8tOXQCGmwaJdvynXlBOwVIkuLNTCxeQ5Ew5SZbehYhJ1wxGZQHH+M51fyyZ0+FmGe1yAHAzarNfnbphyk4Xzs/D1/fGxnrNXwn9fm6kpT0Vo5YgQ0FROa4rZaX0wwC4Df7or+YjBD+VIqi+YfwdNI5kqdxBuE3X0BZlRTe7aE21geQJYsr+2XT1Pr35M/Ma/nRPb3Ty0QeCNEIkOdv52cD7SFRNkq2bZ0F/1Gt2+kiexrnosQZsd8fkmSTJL4fr0zVJLDNhd0tMcyWFFuspmdLaEeMBKxn9YmfDJhtjRl69iY/bs6QF5EMSTKhdrxQLIwN5uaJwIVL02AZbkDmQuSyYVkGD4qsw/O5m/8wze1zPZv9tJ0XBy2ZL5jP9M/JDty8NoMb/6hcvhZL0jEtNWZrTlf/xHnINKMh3Zlt291VFVq/Dpb+QYpzMtSxfMq7GbeSoYmSCyjM7M4GMaRiZaz5pGbKczyCM9ywNf92N+WEWXvmbYnSNZLG7oj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b9cb29-fb13-4575-a655-08ddbfc99356
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:51:03.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BztOTqvIvwBt6JVq4/5npZMaGuqcmgIt5oKkm0iOp2ITbZbqI9mazKouSIQvhNKLHZ8+7d8Q9lGGG+fZZyOrsHUAhPs73Q9SByx5k5T6ADU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfXzD/+TOFDawX3 HuvYBAlR9LnjUhvx+CTJV4H/Mn8//lqwA3By+SPs+XS7khGOZe+YbkT33+1PSC49XvpMsHeWUge jn0VxDnIsjmsEFba5zcNvjswOBRYSkEvshaBRoiNa8rua8YdiGzwK7StPTaFV35WVgb8As7XBHn
 UvsakIDhalCCl1+HMqdPUdfRBDn6rAMcLpRZjw/Adk+F906vvM4ARtheYwIREBXMqBXYMu75hl3 lDzpSdvBiYIPKo7en+QRQ5UB+LVdWxSNFf/MvWAto2wuZp1ZKKKWxOQ1IM4aX5omvkvM3IZS61M ++DI4CK05ipYXH6J2u17mq84AmYLATBdHXVoAddTXq8tcAAjAJgroaU9MehFiPhzsw6zNNjidph
 I24IMnz/cFK1j4iuMoXTrQNvviVyeO8zfUxkRy4Xyujd4baxz+eA7qGiNgDitTIvRLlbEu20
X-Proofpoint-ORIG-GUID: TNr3VArrKhsT8p-0KFqHngAom4KotUw7
X-Proofpoint-GUID: TNr3VArrKhsT8p-0KFqHngAom4KotUw7
X-Authority-Analysis: v=2.4 cv=O5M5vA9W c=1 sm=1 tr=0 ts=686fe16c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GuY5gsdr9MwsYxRlPWUA:9

Now that we have added the ability to move multiple VMAs at once, assert
that this functions correctly, both overwriting VMAs and moving backwards
and forwards with merge and VMA invalidation.

Additionally assert that page tables are correctly propagated by setting
random data and reading it back.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 145 ++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bb84476a177f..36b93a421161 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -380,6 +380,148 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+static bool is_multiple_vma_range_ok(unsigned int pattern_seed,
+				     char *ptr, unsigned long page_size)
+{
+	int i;
+
+	srand(pattern_seed);
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		char *buf = &ptr[i * page_size];
+		size_t size = i == 4 ? 2 * page_size : page_size;
+
+		for (j = 0; j < size; j++) {
+			char chr = rand();
+
+			if (chr != buf[j]) {
+				ksft_print_msg("page %d offset %d corrupted, expected %d got %d\n",
+					       i, j, chr, buf[j]);
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+static void mremap_move_multiple_vmas(unsigned int pattern_seed,
+				      unsigned long page_size)
+{
+	char *test_name = "mremap move multiple vmas";
+	const size_t size = 11 * page_size;
+	bool success = true;
+	char *ptr, *tgt_ptr;
+	int i;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	tgt_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (tgt_ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	/*
+	 * Unmap so we end up with:
+	 *
+	 *  0   2   4 5 6   8   10 offset in buffer
+	 * |*| |*| |*****| |*| |*|
+	 * |*| |*| |*****| |*| |*|
+	 *  0   1   2 3 4   5   6  pattern offset
+	 */
+	for (i = 1; i < 10; i += 2) {
+		if (i == 5)
+			continue;
+
+		if (munmap(&ptr[i * page_size], page_size)) {
+			perror("munmap");
+			success = false;
+			goto out_unmap;
+		}
+	}
+
+	srand(pattern_seed);
+
+	/* Set up random patterns. */
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		size_t size = i == 4 ? 2 * page_size : page_size;
+		char *buf = &ptr[i * page_size];
+
+		for (j = 0; j < size; j++)
+			buf[j] = rand();
+	}
+
+	/* First, just move the whole thing. */
+	if (mremap(ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Check move was ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	goto out_unmap;
+
+	/* Move next to itself. */
+	if (mremap(tgt_ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, &tgt_ptr[size]) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, &tgt_ptr[size], page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Map a range to overwrite. */
+	if (mmap(tgt_ptr, size, PROT_NONE,
+		 MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0) == MAP_FAILED) {
+		perror("mmap tgt");
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Move and overwrite. */
+	if (mremap(&tgt_ptr[size], size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+out_unmap:
+	if (munmap(tgt_ptr, 2 * size))
+		perror("munmap tgt");
+	if (munmap(ptr, size))
+		perror("munmap src");
+
+out:
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
@@ -721,7 +863,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 3;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -848,6 +990,7 @@ int main(int argc, char **argv)
 
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
+	mremap_move_multiple_vmas(pattern_seed, page_size);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.0


