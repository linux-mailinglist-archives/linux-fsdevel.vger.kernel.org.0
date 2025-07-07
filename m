Return-Path: <linux-fsdevel+bounces-54057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA5AFAB06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B653A0FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21A277CBB;
	Mon,  7 Jul 2025 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N5O0zo45";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUjSKL9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67011273810;
	Mon,  7 Jul 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866216; cv=fail; b=q1O9uLjmu2GhODs56CWSs7n/H2srGaPBtdeEmWMTjjDaG/E/rat9b9ZVUNVGFlHkubTaKq7khwHweGEjI1RuVGQ/w7kDBqc/wwmBMkSNfQ7V7YYOgRFe1M74Y5OpLPyrGen4UTr7VzYmIvKiWdNJVRYJ+/1H6zrTxj+/q1pDV7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866216; c=relaxed/simple;
	bh=RHvUMBOpfkAiTEo9rJC5+Hyw84tnjgYsZ0MbkymKtY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spQ7THbUzlLJD6hq6zlCSwOefyRg8aCWu8gR6VMYz6hWuQQOKQef9+LxHE2u5b78S3F4ToSuG4uHoP8lf7FZGk3Ac+EVO8DnJvRQTHX87+HMDo1AEYvn0+nbt9W2ee59Wiff7paYH7uJA1BuK4uRR+qe2EsoU0By2WZfmPxjLTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N5O0zo45; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUjSKL9n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566MBqHD009176;
	Mon, 7 Jul 2025 05:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/2zyDLu0luwfv9e9dfoN8OmmHjvwoPSKdMB2anes4mo=; b=
	N5O0zo45Lu4NTitZMm1D+71c2rZuXZmtBwD8wN0xSZ8Vc4MonV9mtTI/ORCsChY3
	wdVxYaN1cHtEbWlB5L8KZ5v04ccqoFzDHAIrUyeTXjcIV1NefH3Mp196NvRPLsyk
	I0Fl0OgsbvDLeHKeXrYyHTwBxk4Vr8sZRyeHI5rENucai3rKkrcEh5wA0shO/aQY
	uiLP5cX5l9b04L9Rj5NB3L3dmcIEPTLZcy6LZUPw6HAsjx+U/YUN/6O2M/pyWBli
	toOmsO4fWrYzkVNzk6+JiYvjfxCE14xlcKHjiC5YoLkAlFkmQcbm6yZPMtOfCk7E
	jJ655ohfJdxHq3LjMTUceg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47puxjhy9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBo024285;
	Mon, 7 Jul 2025 05:28:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY/lMZJekE20ttU0OWCpnAUVOSKQLXNej9B9OAy9ANDVeMJAw6WeGgfcY7rV+DSg3kPT2heqJmCz1SASBM3uJsOz2/9ZB4Q2QPJw7Q6X+lmHU67zGUTI/Aie58xIGkx2qV0+ZiMHB5gjpNBJ8998qZC9g5DKC3aVYSUuvVS8y0p1G/+GskEPNAmtT0Wm3Jx5I8mLCvt/g1K5kBTldf10Rvjh4PyjrN+2XqW3CD+C0Ldczsj3nmaZGDeBWky4eAiJHmBD7hnOUtEF1O+tdoqwM4tyrYX67Od5oTA0TajHHQMbopRKnhqg1owG2PumA+L1PYdHEdKuhwoqLvVe43i4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2zyDLu0luwfv9e9dfoN8OmmHjvwoPSKdMB2anes4mo=;
 b=IVcyWwZF2yM9Iy577ATK7XO2tsU73k+Q+bfDFI4NavEr9T7I9fmTK4rvJiWpPHP3Yvu9WKlqiInT3A2prlCVjjo67GX9naoD32FJpRrCUrWDeYDYOwia7Uy+TiW/K0YmDiKocSJYN8+7oaWU4nN21aHz09l2al40YxHoHRoLJP6/pBv/wOaudklE/irW0icC/5/Mxeh8ex0gZDPkBIwKhd3ZQ2BAMUc5oVSmP7RObH2lf5a+YdZnxrKHuX3K7bnl0rZTTivASxLw+r/ThOt+thhmN1xf5Cd+7z1jwZz9zxYEJxItoFfYXGq43sRz9QvqlTdhPCXZUWiKBMrMwHGCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2zyDLu0luwfv9e9dfoN8OmmHjvwoPSKdMB2anes4mo=;
 b=yUjSKL9nD+IL+Bdy+pf2Crz5hK1ETqR8o6gHgLNoroLuGqrGj5k5m+D7Rqfc/QRqqEL9Ox2LjznXqYMduLcrN+u/88fgxBue0ztKdftixO6LmIaieISgQ5ktSU5iMSpqLG62Buv2iCqb4Vb1sVGZcJKDHUvXBnsV2BpqGmBoVXE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for mremap
Date: Mon,  7 Jul 2025 06:27:48 +0100
Message-ID: <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0496.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e10ec18-5bd1-4694-d6da-08ddbd1723c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dKq3Ity2HyjVN50mngk1UF8fsgcjMBXzpnxf92qFV6sErVQg134+oXAjzWWK?=
 =?us-ascii?Q?aEGt/ep8gXAgA8Y7NjdR0UNPtHspcRFrUKkhbOeFgvHC8xrqLZywley78LH5?=
 =?us-ascii?Q?cWVUbUI0hQ7QrzWxmsJaeqSbCs/DryVuIeM8iQAdJenOyp5FoPzvvY8hWk3N?=
 =?us-ascii?Q?YCaarrXy4f8KVBut+44VXfe9pI4sS1uu7m7GK7J7fVNYfwnS5qEBpqU7XfTc?=
 =?us-ascii?Q?pZbRyZRk0AXzoM5B2LLwlS47IhxXEJR62JTz/b6EQt2bAmp5763OKA+DHQkK?=
 =?us-ascii?Q?wg1xNYm070L3oCM6aIsEh1f8CoxAeFHSsjVCac4tvsnB7qrUXIFZ1Fa4ZrAE?=
 =?us-ascii?Q?wOMuqlCxrhWrOpXHJowrdfoQ9GauxPJ8XAlhfv7VdznDVgJ0WN0PAufiUTRq?=
 =?us-ascii?Q?M62rS4QDObu6oRSiSyIS1yLPbIrhOWYbbTK+sLp4n4omPSuOD7nrBatxJiNt?=
 =?us-ascii?Q?CyjECCpP0/BcrEHkIHp3NXNYP47yxJp1GNVxf+wBlAcNDW9vIg2W+vRgpSzt?=
 =?us-ascii?Q?6sjUDhz0tRr+6uiDaAd/upVm9QCEJHHaP4HHNyOydpL8gkX/T8lxmk2DMaLh?=
 =?us-ascii?Q?tAIEyWqcQwR27nF+0idaYhet+IrYUDVgJ06BAOUzcxWVbDe8+jgH/t2/FPOF?=
 =?us-ascii?Q?hMrOTUvNHuHZCaFIv6BuLIe1Oof08bMokdY+2CFK0M+pQHFdPudjySjrVLRm?=
 =?us-ascii?Q?SdAvLDifDfUCixAapoZDlW39X5hb8D2FBggeD0XsOuATizuy+pE424kDJ0kO?=
 =?us-ascii?Q?pn5au4aN5ExfFNdJtrhV6+Nh1pMkqKueAU5DffuSNlzFvhv9MjdKbSdEntOD?=
 =?us-ascii?Q?oRsxe5PTSEqybzKv/s4Sq0bWIZ5o5sU2A8IxROkEYvLQ8nGQi+AKPRah0w7Z?=
 =?us-ascii?Q?k7Vrs8ylsv9r+H5B5z5RLubqDHsjqBtKof1f4kqB/X4e1NFwKWRyZzP7mXG0?=
 =?us-ascii?Q?F0H0UrCErFIPFyTeAUWW70Yy5c3Mpqgrt2enipM9G9RD4ILLXoWg+chlENEJ?=
 =?us-ascii?Q?239zx2X9xrAifKWrnNrhLcVdqaHYIo3QHs1/i4DAV97DqdoTACxiPNg/lsKo?=
 =?us-ascii?Q?3zg64j2TMyvaBZnqgeREGuV78LfFgKvWsNeIBtE3wZMCD5ZmQvadSSVj2RDL?=
 =?us-ascii?Q?espG+9gED758+TF3ZRuwZSD52WUHXmsCnlTuMFI0HPqV7t87Xuljhr/uEbMr?=
 =?us-ascii?Q?XCTgb7rh/nFTAOO5UpN3otkjQxZRRZX1iHZVmPXlpEEM0JwyBIMznVHsa2eu?=
 =?us-ascii?Q?nvieaFVbx58QDAEwMJR+IpxJ8T0bifQFQtd0mlLRYrmUoFKwFnoiOD4jGmBt?=
 =?us-ascii?Q?uRE9ovUHqoyk8fkMgFklAbtzhAkzVh+9RbiezcyFKdPd6Qw8feR0QFAIgehI?=
 =?us-ascii?Q?o/bjY5QnMRSm9MeYIxzp9RkblsgXsWp50kcezdwwQwggIUxtA2mL/grDCMP6?=
 =?us-ascii?Q?l3EyqQDlbNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qvUW+wZCLv6sqjm6o7Mr6K3qR0jPQSyVCT0PExYq8iyN93680h+0IIMzRmU?=
 =?us-ascii?Q?vrVUdKrWm+42XS9CnHW50gt6cv9KvgUSz0tkmot4retwtDvFf3LgHYdCAB+l?=
 =?us-ascii?Q?BfCGyu8UaRhr+Kv7Zc8cPqnhw3XUt4njGMKKMe2vIymQSxwYQh1bO84hKthP?=
 =?us-ascii?Q?CR5WsyDHmHkf4yv96/HAAEmemOepgdWuhWCNS8Wpy1L1EiB2ZAj4kNnmCkwk?=
 =?us-ascii?Q?BhRVYd+oDYZYwArrrQkhrZcUMzBAhd///rbTtooN/iABymgSh8HpVPsvooVE?=
 =?us-ascii?Q?ycL1GCawlX5qT8nxiWN+s0IkBxSLwibbpe9OsL1lpEVXOLcgoUwAzSqy+GKN?=
 =?us-ascii?Q?6BTb1IqSqnQ5uXHFigq7FhSuk66hrwhHzBS/amYkmkMp7t8xx3HAq+xsy8vK?=
 =?us-ascii?Q?YatErHjOKDICeOJcNGCEy9YXbHM7T8O4jd8EMXptkOlPCM3/O0UJ1aO4MsSE?=
 =?us-ascii?Q?xrolSgszta5PX1oHljkJX3uWFnd4lQydMgsokPPtey1SlIbkYy2jBH6nozjM?=
 =?us-ascii?Q?BTLTU9ItUdKcshTB9B7+9Z202ZccdCpUnkosys4MeionBsXW8Sbbvcu9MSgV?=
 =?us-ascii?Q?GEAtpstzxj9OWWvim8UmI30bXe2vLeXGEDF4NuhtrNpVTGfCS9uCWN/2jcbL?=
 =?us-ascii?Q?9FINWduse+oqrrE8DuvvrnEuvLf7MUAGjbjJJEbp94xEhaeydpGIHPIYhrLc?=
 =?us-ascii?Q?PsMjBkpWEi4Zi+o3XwwHgr1BKNxqGc9t34qjB07XWzoLfi9WGviUNhEZHLqM?=
 =?us-ascii?Q?bv2Gayaom4BSYNw41NOW7JMN9agZd5LslrlpxawLRiXE4EawQbJIVSxyVa4g?=
 =?us-ascii?Q?atvppK2hV3G/eRfDTpP2TBAnTKvPVzb2LobiY6rSHD9htk41U6S6kKDmSyih?=
 =?us-ascii?Q?sdU9GyNSAhbj2L8Px1MgUJjjbd5qF+jh9Z5Y3SiQSur7A95NmcHYbnRr/384?=
 =?us-ascii?Q?K2wNfWh1RFPZ+emF6cO28IFjwtxTvniVYyV0Vn4xSfywraxINurgZf+T3PO7?=
 =?us-ascii?Q?xtmq1MoNHhI6pb8vSVN0eF2XHNtHod+mooaN4Y1I9V2E/uRbGy45olNLPiwj?=
 =?us-ascii?Q?W0FqdAClaaqOhEcu3iTwE8cR95HTCFZCNxRVPRCMw2H3sbkLAjvkGn4MkHVd?=
 =?us-ascii?Q?Z/WdAK0+ARKRNsMONwJ/QCJWRYGpb5ikwCbMMA1sByEYmq3TfdwrRGzpJtUM?=
 =?us-ascii?Q?mItDykTZh444cKJjMoKzs4xusEYd0MQ9w1HgZB118trk0SsM4kWXj/2FYrte?=
 =?us-ascii?Q?EMVUDFzjXTJkVIfAa4wlVzN0/+SRZJOqJxo8oUxpLDUtVVuV1L++LNo81Xxt?=
 =?us-ascii?Q?+5M/KpZI7A3Z44h/ESQ1wthKggjNStBfEp4cNU9BzNcr2ToRxmvQCVWl3WBY?=
 =?us-ascii?Q?PkxUE57kheBUoI6xXa9NLG5P1c9+T4H+fSQUaLP6Y9dBfeUoexxZ/zFhTRGC?=
 =?us-ascii?Q?nY3JMFWd6CYOzi4lldZuQul+INcUjmiLj5hqItSkgpFb88EDzAq/v+XwxrY1?=
 =?us-ascii?Q?hn1FLpkc2Y7coswVldShB/bGzt+NpusyHoU/9IWv7ag52mnoNSqAd/wmmJEU?=
 =?us-ascii?Q?kLuzzBLU5D7JQtLgDDlRDfsQNlYTPWNvrphmkl7JmhtaXXj7A8dp4ORBMejt?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OrjbLdOpSdPVFBJxsn1ssqzrq4WnrRVN7LtgeGF14KAffmHi4BmpBu85Offtgt4PBj5GtdR97Vf7q8OD/bbFJXV1UyyAehwOdvXP9mIavSTrl/owU2BCW9vKz2oZ0JXcKN4zRjecr4fMgjs7RKM2UGF2ZP9FD3XKlIHwSw2UQqMfrbaKvL13ldteUkZdu9b+i74wwCPt5R2TeoXkgZHnLXwAJPXFrmSnZtebm7TTX6AKzQA4+bHN3UAWUQ7aGOf8tbxG53r/JduO0IhgLhBgUAMqTXdG5Zv19aqotePi43bPRSN2+/u1BEDgBdQ7Ztwto+/w8HnQ6DlzRTWxv2eEgvJw6UMvNOcFTaVI8epqWVe2OoIhivtxC8cp0qrIf020vLSOselAxfJAPy6xAUj+pDbKVyN7+NXwroE8106VV7JXq+RrujoiwDl1oEqwx32R9KuLkrH1cLfjmqyMqedrYBcI5siJzJ4TG2chfaxYYdPqUGZkOVpUtEv0uTcszqiA05oxCGsEYX3OQyEbtukS5eCvibRfDtpxMh8f2bQQcpKj1HeFMNTel3usOZ5sA4JzcJyRAkr3ehtJIvIyWg0OmPPRc9ssMrnSpCxxijm2ovY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e10ec18-5bd1-4694-d6da-08ddbd1723c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:43.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgN/T1k3fhVhbrImGUwjgKXRyuU2iMVEG023kInGxyO0TPWjW8hxFIZOcCBhJ2k3oun4rnUCNHpgqaEAOAf2sszQzruuPv2pHmSQDaRGrLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=Y7r4sgeN c=1 sm=1 tr=0 ts=686b5b1b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VISmejGXrN9RXs9aPs4A:9
X-Proofpoint-ORIG-GUID: 1y0HXIK5zK9wL2_m-r8pk7k_4R-vGwMR
X-Proofpoint-GUID: 1y0HXIK5zK9wL2_m-r8pk7k_4R-vGwMR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX36lAkLvbBjWS PusY+wyN993qMPinoofzcnm/RU1/YWZq+rB1N5nsBOcke+bsv0zKUB1yi3ta9jzjJWCDIYAwIBt uVkNpFyORQZGFT7JfPYq3jlk79JvhaQon8Sy3pmZzte+hRddmxuDEUFeCTBnPTGMsXEs3uGXOAk
 OZzePVLNN85yHY9W+ICUMuFg/u4JvzsG5pY/SEyg6F6y/ZBgjTZni309cOqXZfAenE5DEFD6Kwg MPDdeNKIlxO/cV9HORWEbGFLJEmwYett814UKJSe6MjDdDfTsLe0mbUtPmrEMhvpEe/xddcaOHc yM2Qnoli3lvD5WNZuNvbZyBhLEYVPxtN6T1X3vZaNZ4kOudu9SLZYJbgGtCSF3goZJtlWmo3vry
 I/BaEXoymQjjPwm6+4ns3+1yJGVazRasPcgMZUdJbBjQnPe9sehjgl9SOSD+Mofr6HBNVGS/

Right now it appears that the code is relying upon the returned destination
address having bits outside PAGE_MASK to indicate whether an error value is
specified, and decrementing the increased refcount on the uffd ctx if so.

This is not a safe means of determining an error value, so instead, be
specific. It makes far more sense to do so in a dedicated error path, so
add mremap_userfaultfd_fail() for this purpose and use this when an error
arises.

A vm_userfaultfd_ctx is not established until we are at the point where
mremap_userfaultfd_prep() is invoked in copy_vma_and_data(), so this is a
no-op until this happens.

That is - uffd remap notification only occurs if the VMA is actually moved
- at which point a UFFD_EVENT_REMAP event is raised.

No errors can occur after this point currently, though it's certainly not
guaranteed this will always remain the case, and we mustn't rely on this.

However, the reason for needing to handle this case is that, when an error
arises on a VMA move at the point of adjusting page tables, we revert this
operation, and propagate the error.

At this point, it is not correct to raise a uffd remap event, and we must
handle it.

This refactoring makes it abundantly clear what we are doing.

We assume vrm->new_addr is always valid, which a prior change made the case
even for mremap() invocations which don't move the VMA, however given no
uffd context would be set up in this case it's immaterial to this change
anyway.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 15 ++++++++++-----
 include/linux/userfaultfd_k.h |  1 +
 mm/mremap.c                   | 16 ++++++++++++----
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2a644aa1a510..54c6cc7fe9c6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -750,11 +750,6 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	if (!ctx)
 		return;
 
-	if (to & ~PAGE_MASK) {
-		userfaultfd_ctx_put(ctx);
-		return;
-	}
-
 	msg_init(&ewq.msg);
 
 	ewq.msg.event = UFFD_EVENT_REMAP;
@@ -765,6 +760,16 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	userfaultfd_event_wait_completion(ctx, &ewq);
 }
 
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
+{
+	struct userfaultfd_ctx *ctx = vm_ctx->ctx;
+
+	if (!ctx)
+		return;
+
+	userfaultfd_ctx_put(ctx);
+}
+
 bool userfaultfd_remove(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index df85330bcfa6..6680a4de40b3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -259,6 +259,7 @@ extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 extern void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *,
 					unsigned long from, unsigned long to,
 					unsigned long len);
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *);
 
 extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
diff --git a/mm/mremap.c b/mm/mremap.c
index 660bdb75e2f9..db7e773d0884 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1729,12 +1729,17 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, unsigned long ret)
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
 
+	/* Regardless of success/failure, we always notify of any unmaps. */
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
@@ -1742,6 +1747,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long res;
+	bool failed;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1763,13 +1769,15 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
+	failed = IS_ERR_VALUE(res);
+
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
-	notify_uffd(vrm, res);
+	notify_uffd(vrm, failed);
 	return res;
 }
 
-- 
2.50.0


