Return-Path: <linux-fsdevel+bounces-40434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19766A2353C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2405E3A5972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4851F1908;
	Thu, 30 Jan 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJqEgd3R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mBsg/z/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B91F150B;
	Thu, 30 Jan 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269663; cv=fail; b=KwMhpwJJqbusGn+kJcBPZesGNKvJh/W84Pu2oOecvhOvOrvaXfLYzPG0WbLpzUUtJPWy+HjYNGup6Owy+5h3EbuxLDIcMGX4BrHjDLIOuyz45K+VM3yAy8PhxnSv9k4Mnd2Yd6327ZRGVSocng9WBvtcd8Fd/McMj6B+eNc8fDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269663; c=relaxed/simple;
	bh=WJAmoO3o0gsDfva8nvoZBh+vKRJ/ROf1mQ/XEzm/L1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okLZfdiygSfXaHFtndIQMHKSSUjlYMFTmyfhVyWuisXnf5+e5w8hcvyKID60iPYGTbrUS3K+z9yz8KVoRhDpueR6q533kbsFFq/SQDErPOMpS9lSeUTRMXwltyTj0FRIU6UMYlkr8p6Zxh30ujbIamBbPc7r3IMpOX/D/S6yOog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJqEgd3R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mBsg/z/k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJic58009892;
	Thu, 30 Jan 2025 20:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/HpKRiwOr6F3jDBa6b34ApkfJ3w1KpWcv/2Hw1+4lug=; b=
	eJqEgd3RME4/a1QtCxJjlq65+JBUGPXDLTgofKlerXH4xV6pdQCFSWgPvf/82T7W
	BYku0yMBei/9wucoVcfL3YtxN27IKiD4oB9YKaMQ40y86wPBEfAlnw8+G8MELGzA
	GswJyS0L6iDlHVzbbH4UOlvBiWfJFLU0DRYf9M1X6juG7AhUgop+I4Yh2bCLplmy
	H51FUCApW5a7k66tIc+6HdeQtfdpts7feV35Kt47kqx3C3FjNKDC8XY68Qkulxg9
	AJcYLZwM57yiVpsRmqNIjYqfhHz5M6HbrxIINjfJ42ClEj1aJTtjQtK2uIvPkly+
	3SvWvlMcwVzVHwyzGZ9X9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gf8206yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKTrLp028353;
	Thu, 30 Jan 2025 20:40:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44g0vbm9dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJL0YJ3bbxqxTnoggcjhkT/j9/Pl4xxFQi6CRnWlI9a1SkgxsglV6SjVXHzTbe6YJ56Ra58iv8aaUjQEy9Nj62jz1ou7lIs1JJBnZ4BpvBveO+yXTGAqO3KtwWHm6tXzB9X9d76U8lEvHzLNSAfl1k2ti2y6mSWxSCjVyYDhREV0lHybvTi8pElaMYiWyxwu2y5Y9hYa1eldDstC+HZ8vfEw4DpTa2/duGLkCzefQSFnXtubn/ssJAp+Iy8Ii9gbAzC19aA+/ScwBPA1XXH7LGAgqKzi/yTBVP5m27MT/wZFUVLZBSlFxjdpaF/xEf3VGOhElEKeBiZ2KQBBhey7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HpKRiwOr6F3jDBa6b34ApkfJ3w1KpWcv/2Hw1+4lug=;
 b=J/WQisQa/uTvptlcLs6aEiQe98T26aN5xNPX4o1V4c/qZzopzjv7951GOo/umVxlzOcUXb6k4sltPtxoyaW+VcPd73jJ/yS6jPmXJPZJN7E/xsTqDMhZ5ZmmGQapMy3/xeWMWXJt0x2u47QyFfMWEaQ6GGwgUHX8fWr75AKlveOL/7AH1ND6GaC+fserQRt/I6gD5+6nCdUtrdrxMghS4DdjL2YkMZbpHzTq/NPy6vJWXTTRqX3BPTK1Hnv8gD5iIBGECqEkb44/nbWOdn++m5x8kmKJNOakXe1eb/unGxABg3XmYbLnaFleNrA0jVjZPHNYdF9OBhvDmzEErCeyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HpKRiwOr6F3jDBa6b34ApkfJ3w1KpWcv/2Hw1+4lug=;
 b=mBsg/z/kzObKa5LWtt8pjMtyaXHauhXx6HTzW1LGRr/hpFaQvdj5q8lltmBtWa7mI3zNaB10tzl7SwXw6XDnLTL7IZhuna+Rqwy6+7OrolsDTvoNAg4oEQi3qijAl6OI0cfYKAa3wZVKw5CSuzBKjmcC3ulUmUtd26FhkdJx8do=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 20:40:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 3/6] tools: testing: separate out wait_for_pid() into helper header
Date: Thu, 30 Jan 2025 20:40:28 +0000
Message-ID: <c611be6f7df6aa85f72c6d4d329b30bbe4a0fbed.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: f951f2e5-9a5d-4eb3-d2d1-08dd416e5d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAQmadZdNLuJGYvUJJulhdYMYy29JYE8JAL6HUvPLw9gDlAfx5yGsnXnXFDr?=
 =?us-ascii?Q?g8aZHDxOitj0UillktgoPt2XZjlf5fU2rfd9jfuFBOZGh+9VvcSONGktuwD/?=
 =?us-ascii?Q?G0Ud6H8aUQlIY3gaiUyvLD7F194dvW5kO0Y4ODB4Ry52fMs3ZptSGeM0cC3c?=
 =?us-ascii?Q?jpt/OWABwlmviRSQBSgBKpi/DbVDf/4UIK8Q9UQOaOcZFHkQyNahz27FTFUg?=
 =?us-ascii?Q?Qnd/7kgSRuVffyVaRYaNoe7WqrolJxTRjY8nAkZGWqNIc+S31RCnZ+833buS?=
 =?us-ascii?Q?D/laMRd+oOOwvV5ev4OkIEicF3mwEDWsLIQrZaEcni6s3ZOaQ5XWAbYYmfQV?=
 =?us-ascii?Q?757GEasKfHf1AEst1m2nx6eKg9zAln7KhNZ1dUS/dBoowz5N6Kyv5oDQWAeK?=
 =?us-ascii?Q?hf6ohXEY1GMahTN9IFmk9AEwE8O/PO34gLzooi0R3WdtUV4oeFaVfVViS1HL?=
 =?us-ascii?Q?OUST44jBo1m0oY3E+UPLpocbAjAG7nseg5cF50WOephL6qGmQq0U9NlvGFVo?=
 =?us-ascii?Q?yfsBEw6gSokaVQE/MTJkQLEE1cBENsqi1HvZ5vZ7B/To24o1TtZOwLUxYqxs?=
 =?us-ascii?Q?gUefkr5NvP5xts3oaukg84AIKi6AZA082GnbjazoSV5KHBTtu+brKUsITGXt?=
 =?us-ascii?Q?nwTPd0hWitT1fOJfpJMJ40GYma60zvtTvIteRvwo7uT19BtMX7Z7ZJGLgBfa?=
 =?us-ascii?Q?/ws/U2RUqbkGyDnjMt3nMVHqFPJBnBHSrZ0vIfxCq6nz3Qs4x44fVt5BKr3O?=
 =?us-ascii?Q?U3VoiP6YPoHTrAjqxicd/FfgFwHbdTK5FrJZjqJBQCMJTdebjG7Rbea2mV2m?=
 =?us-ascii?Q?gMkFr7+IdtCETYBatNcNkAjnSWmPNqBxkA6R7jTdNTRZ5OFMKFONJjimS/M3?=
 =?us-ascii?Q?/0DjcS7Ho7KTLYsNJ9joypZWu4CgyHkeIP7nn42MJPPFJs9ZzTiSOlUylfr+?=
 =?us-ascii?Q?0Fg2WnnXtI3i73STI9yzSp6UKKijMueEtV3SzY673XpPSVJceh3pbbtMqcMe?=
 =?us-ascii?Q?Wh7HEI63CWoAC/F2cw+sygE3iYC278vuFRKIwYZSDyJQPLpbrTdNS+fREQW6?=
 =?us-ascii?Q?EZHN2m7BEagQOkAylnxLkEUXGSayiEIdEVe5mEZjuPR69OhYI8fQKZO0/bhm?=
 =?us-ascii?Q?R4hfvnNmFrKoxv8Ch/fbxT86a+ysROTIqbeFNZbG11J+8p61IJodC3wkX520?=
 =?us-ascii?Q?zcsWPzIWwoX030fy+2+25fpR1dfol1zhsxQlys8eG9ZcuXpmd3JWUcxXX8bm?=
 =?us-ascii?Q?DxGlAI06teEkeU7k4Ql3/TS5uCY/UYvQRW093IUcqB0UwC3RLiABy+DmKeSn?=
 =?us-ascii?Q?MoSLm+u+pFhMZvq8e8UwCwsnEGZm/T0BarRq+l4VIG8w4cr7hJky/m5B+1+D?=
 =?us-ascii?Q?pzq9U7IPwOC5Izbn9R3hcnk4t3X+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OlOROYPqmYAI8dccHHNAFQ+182mSuE9YXtTf1CrRBzk408twzmeRQNV7bzkt?=
 =?us-ascii?Q?7P5DstqV93ORFWg0KBI0pUGz7mgxR1F1hXn1Lzp36rieGAEVx65bE0wUmliL?=
 =?us-ascii?Q?6gHDhtuQ9qOhQ3O8xHMFUy+yRleSceoAGMt9MNl7oMkOHPyjraBbr9/+bOia?=
 =?us-ascii?Q?CAR+9/fswPn1EGNj32OxKLJiYSPSJm/cpLn3IYSJFq3C0q6EefTJPtvzpuBL?=
 =?us-ascii?Q?PcyB8xcieKmUdLVU64xAdzvTl6HjqpWHxszfCNEt7G9rskdeoh2eAI5Qp7Tm?=
 =?us-ascii?Q?fbVGG1vQklQl+Ojh/Z8mrwJN7TqWa13R6AAVCtiw4nRecc7wjDfGDJsjOFby?=
 =?us-ascii?Q?kNWzh/igsT3Hb3KOvZ98Cy3aO4oCIKZ/ww4Bgu378RORRB8cHaI3mlsT5f/5?=
 =?us-ascii?Q?zr+Q2OG86nM9D/KjNXVCzuXnsnaLka5TePfct4fc+MMF7fiYS9GUxxtUF3kx?=
 =?us-ascii?Q?1J9V3QarIaIqM3ZV15p9Vxs/6VQQKWKDlU/qp0gE+XtXMpyWasOxAAruEGVJ?=
 =?us-ascii?Q?wE2WoGYaCvjy78MJht/NySrg11O67+3c+nFOR5nZl0SaeMMaX68sW0Fgbtax?=
 =?us-ascii?Q?bM295qvwKPa7s8BysUZ3sxAE5AwI3kkl+NP4Q+UogxlXBw01aoJQm2bv5qyw?=
 =?us-ascii?Q?pHbPO3sfknazbfNygIOwwDb5Lt/u73BXcyxtaYP6vsH6TzhAIC/BEkyRjlql?=
 =?us-ascii?Q?tm5fPlVuiCgzfiBn8rVaxmuL05DyD+1Oxun6g4DhGhhEf5TfSXtqdy3PzQ5W?=
 =?us-ascii?Q?H1eBvbfYLXjbBKJrInFCjBE0oBlqSmdJ99IwlNdN/OKqSQhwsa8mSaG0keuG?=
 =?us-ascii?Q?f2GotnBwZLFCMkZN7v0VsvYi+1tMrKtNNCc6GeyY6Jct77xcVhdzVa9rbOQI?=
 =?us-ascii?Q?lEX8gHxrlVQpwDj7CVUQt+X2I9jKZU/+tDc6QzkNZfp+2lJWxCcDigMgm+IK?=
 =?us-ascii?Q?3X8i/xJwfeFDFlRZ1hJVS+zAACEAOoTLDKRoaa/jwv5MjDopBEFrzdcVx/1S?=
 =?us-ascii?Q?Lndc4HTqYFw7ZgEmasnJYqBsvGtbIpA1+On+dnrxj4gZykNM3R7C8bFNWQ7/?=
 =?us-ascii?Q?MXx6x71M31lT+QvTsltfL/gA+elvkJ78ubuPRVf/+b7CZO4jidrcjD9NUoCG?=
 =?us-ascii?Q?jFlL9Y6Ajf3LGTTsQCNsnqIWZVJp2SzYGBO0ZTe7xgvPu2BTzneERSjLGGB0?=
 =?us-ascii?Q?V16qMiszLmQsSqHTjdS5ZtALH4dKKpzdsrqKbIE1zasxCup3hWZXRPEDGybk?=
 =?us-ascii?Q?z8IDjyevaYZLHuv6Cus/0R3BuEJgSBUv+dND9R987GN7hSCTgIhln8JqpweU?=
 =?us-ascii?Q?ttByCZY/Yk+Zd314S4iChBLJ1Rdt762B7fe5R7B7P+aH9Ddy1XLdb35N0kTJ?=
 =?us-ascii?Q?bvzRcAuTrbk+3vUg8DUjqGkNNvwI7KBcf2Y8rD+6yIFbmTZqLXrKlVNtGFLc?=
 =?us-ascii?Q?iMr4Yj2QPhOtRdCjJvWhJjfiQso6jhrYeC2n/Ew6KiR17VJFY8AE5bAxJXuu?=
 =?us-ascii?Q?PE/mPTee84434q6jbmwjl+xSeO98AGBzJjUHZZLVi2fk9V8yWIGhmdAQ8HgY?=
 =?us-ascii?Q?BtoODh9gSct3PblSyvIpPaJM5mYXj/mG0+Gfsdhi/Cf7tty5gYaWMdk6qCeL?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S/9lJpqikiRLFBdqW4Xb9ICHJnSUND8AJEOtGLrZhBE2rdfB/mhxaQ0xe+nJDK9+p3imYsA4iKjHH1Shvyrmnj7j7vBF6/KDHusmo1Yf6M0/8euip8fm++9TykCT6WyC0rq62WF/jUY+bH/fbl5bsjotYtiKYQWY5dHknxUyEA0ZYPO3bVKtC89NSOcjDajstQKI8ZhgC7F3E7M+gdJLrYLgyEW4attNDl23mq7/yCQui5IfpzjDVj11BHvp1RejVrYTqSVE6Kmfm3KOHbvfLTdPqvIIeUaunvYO9dfr8CYtzA4AuzQm2+8jM2jcxxYrQE2Vxh/bOiqUhpv6zLNQuVyPFu56y2tLZOXwPh2+17eDQcUKh1Bv3AdG0VBayupBl+R0ls+ad8wEy/XZPmAER1XtiR6NqEA6WYPa8+PNMpcUTrvAzNF/I4TS1+g9yKte8hxUqKeNq8Bxmxm0wEtMf+LMNzWVuO2lPJT8RgtItU4/APNKyoT02AezyeGivduX9WFOltmwXwCqF/vDGDEvcPKLI0Xt6kjeRBecs8zb9egw4cl1lc0HRNTIRcAMn2LT9bfDqMIZhZSZHqZCotvjXpNCInuGTwwTwNUfwYr4ArQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f951f2e5-9a5d-4eb3-d2d1-08dd416e5d9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:43.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omtx1C0/1FaWP7A9wPycrrb0ezXM3WqHYOgBEF+bfuxFC91AWo5aGVuHC2oSBxf18SkKGJFq+ltr7q3ONkEAuqI2aeyScw241D3y0C6CjXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300158
X-Proofpoint-GUID: Zr59zrSyWrMhpZ2KUlUZLcjcDYgs0iLg
X-Proofpoint-ORIG-GUID: Zr59zrSyWrMhpZ2KUlUZLcjcDYgs0iLg

It seems tests other than the pidfd tests use the wait_for_pid() function
declared in pidfd.h.

Since we will shortly be modifying pidfd.h in a way that might clash with
other tests, separate this out and update tests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/cgroup/test_kill.c    |  2 +-
 .../pid_namespace/regression_enomem.c         |  2 +-
 tools/testing/selftests/pidfd/pidfd.h         | 26 +------------
 tools/testing/selftests/pidfd/pidfd_helpers.h | 39 +++++++++++++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index 0e5bb6c7307a..2367f645fe89 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 
 #include "../kselftest.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 #include "cgroup_util.h"
 
 /*
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..f3e6989c8069 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -12,7 +12,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 
 /*
  * Regression test for:
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 0b96ac4b8ce5..d02cfc5ef77b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -17,6 +17,7 @@
 
 #include "../kselftest.h"
 #include "../clone3/clone3_selftests.h"
+#include "pidfd_helpers.h"
 
 #ifndef P_PIDFD
 #define P_PIDFD 3
@@ -73,31 +74,6 @@ static inline int sys_waitid(int which, pid_t pid, siginfo_t *info, int options)
 	return syscall(__NR_waitid, which, pid, info, options, NULL);
 }
 
-static inline int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
-		return -1;
-	}
-
-	if (!WIFEXITED(status)) {
-		ksft_print_msg(
-		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
-		       WIFSIGNALED(status), WTERMSIG(status));
-		return -1;
-	}
-
-	ret = WEXITSTATUS(status);
-	return ret;
-}
-
 static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 {
 	return syscall(__NR_pidfd_open, pid, flags);
diff --git a/tools/testing/selftests/pidfd/pidfd_helpers.h b/tools/testing/selftests/pidfd/pidfd_helpers.h
new file mode 100644
index 000000000000..5637bfe888de
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_helpers.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PIDFD_HELPERS_H
+#define __PIDFD_HELPERS_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+static inline int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
+		return -1;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg(
+		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
+		       WIFSIGNALED(status), WTERMSIG(status));
+		return -1;
+	}
+
+	ret = WEXITSTATUS(status);
+	return ret;
+}
+
+#endif /* __PIDFD_HELPERS_H */
-- 
2.48.1


