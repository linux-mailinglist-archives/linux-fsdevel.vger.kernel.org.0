Return-Path: <linux-fsdevel+bounces-40432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E599CA23536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C0F3A656B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605461F130E;
	Thu, 30 Jan 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSUjufBz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CNZOPnrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43531865FA;
	Thu, 30 Jan 2025 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269660; cv=fail; b=L3gPgpx2872de24uIYhnpc7FBItZ5ExU/6+h7vholDk+cqClmAI+lfdg4ogrKnUvuDvTdTSfcP5WayphUEvOBorznjoKtgJbRLYhF20Isry9i+6bTHM/ku8luPgyZn4JM113T3LYxp4Yirq08Pe29IbyPNTnJ13O83AYe7++Pd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269660; c=relaxed/simple;
	bh=m5wKuZc/o5q82xoXlZ54wBtQ0wf6sI7qR0FEW5ZPekQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUs8GCgCG0HzKtbrP2PZbxJn+94ISf8iXpUcSDXUrY4IbqPh8EELl2IoA01RadoUOKgAVz4G35NG4+hpCjhI/CB90QGlM0rLDE9V2Z2AiSXuksy8VN/06NTN05FXBp3LZReHDWks1WVA00IChu2hMtknHH6/y6GeEs4ZDdVuQG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSUjufBz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CNZOPnrS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKRLGI017901;
	Thu, 30 Jan 2025 20:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Yu0MZDnQfvbXkRCLn1QIAGNaeqNkSXsLqXii1oY4jYw=; b=
	cSUjufBzr/z7im1vcdy51O02ivljRPYGaBZkzjS02BonSF9uQyX3SxWkSgXYflBT
	OmdIKr38lRrGEsDVQJgMwyZ+3f6epstHszeCZU+uoIZ/ifNK1Zl1NC2ub7liVHVx
	7kwtAONSLLolkHkH56eMJkpSzFyIAR8WehK6ajZQ46a9j8ZP43d9ntS64x3lY5Pe
	OBSAF0hJkdziQn7iPAYucqJmdkzZSAPhkH68vorfcPp7XslTykqEHg41/9AO4TLT
	lA+LcLwYy5wZguKglHSyxJcGDvvdEGHlMVXqqDsKXh/NOnh1BbHm0KqM05TbCTtL
	sYF3fn9Jr5U7MyhQ1XUFrg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggfe80sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJv1wN009118;
	Thu, 30 Jan 2025 20:40:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44gg1fhtae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1O9vNEb//zxZy8ejEYQK3uj+pT4q3pFJGnFAfk+THzSNh6vknWYNd6uWQeySE421/rEWk50+41vD/hUKyKB2jtG0tgAMA/fvHwpLehjFqIRVY/9L2ep+Fiux+tCzqC35GCADAIZsrhrEb19Vfscj5HVPOlyIrSwDhlgduQP1yRS86M2ZP2pxvdgxGNhV7q3kKIuBgchw6Mjy5BHQ8PyTshPvp8zONKlGZ7g7QjS+C6IACjXqKI6QvGmNT+WQnpU+TG7QtlaL1mR6wleuAsPh0p2zDQ/+TQ8sB+DtIitTtXPaAlTvv7YTJLv+InMSsl+UL8p9mU6NzOb2npmNH0kQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu0MZDnQfvbXkRCLn1QIAGNaeqNkSXsLqXii1oY4jYw=;
 b=FD3/IjW3Dy86KqgDBRXBKYztoBiahizHCZ8fCP/SSPnOJcsRYL/TJEhdis2A0OhkbkxB/swPasdaBW2aLqL2qfTa2ZE+WKDzpSYTv7rEdDqU+4jWwslY1qxfhpt6N2f8GD8jwsBPjDqq/GkhVSnCbdh9/dXQoQ+VksrazEzyznSGyxJInJQSB7rlfgL1RfShC3ItKMu0SKie5E52x1manwRvd5ODR4DFKAvZ2QkNkLHOmPWJUPuV7xD1TJKQcknrcA4mk+GnumHJlfAcUuBH1AeGHfgGsmrYlkZ6BTNxr04f04LMy1DVWymoNIHCd96DdyN1FrWPSMgSFIUFpAMivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu0MZDnQfvbXkRCLn1QIAGNaeqNkSXsLqXii1oY4jYw=;
 b=CNZOPnrStNcTqbBDs92H01xB6MOzUTus7ZT2ossy38MNCd3i4mPkSswHpuKAcX1hnGInxwYLumPG2P33NLdbr11EIoHFZAEIEtz60OzVjpYj+Zb5TXg571cz0xdME8rN1AKrjf0YCcjRacOAP5sfR0XJIEGzxdBuUHvq9LBAiZI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 20:40:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:37 +0000
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
Subject: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
Date: Thu, 30 Jan 2025 20:40:26 +0000
Message-ID: <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dc80c1-6978-4c52-7187-08dd416e5a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IuwPZHRCdPvHuearGp9PiYB6obM1LIniOATK6E31y3nkaW7sctZNQScwPxmX?=
 =?us-ascii?Q?2bRXoq+YaOkIzbDCIePJCcLrxLBsF7z3c7ngPik6/HG7fAY8mHot36ZANT8N?=
 =?us-ascii?Q?lenSmgkz/3kM3LTJz1mwjXCrwd7Ci3BPT67GRNhCWK4R1+MBbMtwsVWKGOIY?=
 =?us-ascii?Q?p5yNccVeRGPPdJ+FiF9VhXWD9ZWKmX9/8DKc15QDxi1xoi7HThhH7XCq9RZR?=
 =?us-ascii?Q?N8B0HOLfFUk2rROq+M3MCE8qNXvvedGUlaJU82n3O+76KBr480vzglMtk0yS?=
 =?us-ascii?Q?scrWMxt/jwijYbnJBvdi421lruce108mLY138q8fFCReAA57+6bivKe9/+Wo?=
 =?us-ascii?Q?VU6HwKKU81YARnAj5Z2n+pswPrkJ44chO4DoWeKUX+zfTSjfVVxjRu9GdWNF?=
 =?us-ascii?Q?E7kSVA5RRr7dqAA5Jp0hHiKaOUzQkoTB/zfTgH/vF201niOAv7GZ3EvCxV93?=
 =?us-ascii?Q?BUmkZJktl1pvxXxTrE+oMfXOVxsSGRWVmIIym9jtXKINe1JSIis7b1G12bcg?=
 =?us-ascii?Q?BtNEJvkXgj5LvdU37Rd02Wj1F2WC6aQL3HyMSaDM99OAbHLfExUAcjRy3bKj?=
 =?us-ascii?Q?rLLPsr/aIb0VHEvsgUAwcPNiwgDjPPqKEb76llLMdOPy5h+pSrlFqBwUaby/?=
 =?us-ascii?Q?0I26rJqiBDFF8PH7p6X81zJfAAZ0TZ6XwIgOhX90TtTayNBLUjrey4gQLwf7?=
 =?us-ascii?Q?4yQRtwOeJBNambpc2wdFLKxg6sqjey1aTSV9jQhSAzWbKMkRY7UuIYLWAvEx?=
 =?us-ascii?Q?dtw+kEeGHah3ohYPssVpJZ2DuAzG0Fr2X8NO/Eh/TSkehUkmNJEcHZoAIwpV?=
 =?us-ascii?Q?WtTPzYKENInh1sjFfvNam2UilQADsNQ5/F37k4aOBlY9xxyRB/TtBRzmC2MY?=
 =?us-ascii?Q?zxY1nn5LWXY5sT1yv3QCKNG/Jk7O/QyqAio5yls6ptyQl3TXlNwD1SSpA1Ru?=
 =?us-ascii?Q?3kI8o00Gu/F9UHTeB0s7FFYFISUxWqNeeM09qgwacEH0dsP+MWoZVLjVDTBh?=
 =?us-ascii?Q?e7Vm0LEeYikE1Fj5OIdNW5dN4rwKmfQGVyUA8IkAhUPdriQBk3Oi0jiwdDYx?=
 =?us-ascii?Q?FB4hCO28nAK8eAbtUlILDM6Xw0CYHWLzvN6p/f4nDZo6iVNPQHos6Gosk6Oh?=
 =?us-ascii?Q?A/jxMJkvFhlmUHpHv1dKF0pt4i/1HGO//bP57/DKkNljTkparB3L7jmLYE9K?=
 =?us-ascii?Q?OaYGxyhJD2vD5gm+/ODBvsYax0W89KvSdEK3Qit1wYeSBnAU1nIBupSLMpMk?=
 =?us-ascii?Q?ITOI9uzVQ86Nx/1AfCybcL/+4804wsZScLjyeDYLvYnG8iQt1M0LyP0vMhh5?=
 =?us-ascii?Q?a7CsvykPjjBnsmGC60NKmpMGPOFpVjbjHkHHFhif81/Vbgi3mgWZcs0F2f5K?=
 =?us-ascii?Q?0MjuNalQJMaNfkDCTI0U98C4CwWY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5crm2XRRqOCFWssgrmTVurfHQm37jSG/jIdvejtC5UzUQ0LXNMovijdxerC?=
 =?us-ascii?Q?pwnX7D65JLKufHbr7Q50Fi7eAeF6WHYxTw1aMNeeV/SgHQz0tepicDG+O/UX?=
 =?us-ascii?Q?6HRsrGOC90J4nZlI9a0bIGLQ0FBi3eogmJjPeIJfAe6oIHgR/yk//XIgiLv5?=
 =?us-ascii?Q?zrGv5HETCyYVKfXawVEF20r3oMmIZaQm5OUhIQCN7HbUxlYm549J9AitFGIE?=
 =?us-ascii?Q?IjJSkqKL6vjphGkDlLc3D3ARDnwAYZfF8I3GIFOTpyfc5YrrXu9yK/0aYiLF?=
 =?us-ascii?Q?oM4lJ482aRN08GBkhaP3+QvIitZT2l43cCWLY3Leqn8IkW21CIfJTGY/TFcY?=
 =?us-ascii?Q?ahPvOKVN9uLP2i92fT3NiMaRV2f/J01Qh3Ynjo+wTkAMbym9KSJtu8clGLkD?=
 =?us-ascii?Q?oGO0exmejfoa8g0PZQyC5RJyj4ddHa7rdrhvZuG80zA9tF2FHTCFitbF6zm8?=
 =?us-ascii?Q?pIk3gZSdtDeF6OIuQ8XF0g5dsXYezMPWZIXQ7h33PcVal7IlF8t89E86BGn0?=
 =?us-ascii?Q?ZkBocgQ0c5yWhN/uzxW7xYHQZysqxwfve94w++o1Opc6EqPSJBrRspmoGozb?=
 =?us-ascii?Q?XvgSjHIq+bCZCPLETsRy97hNYD2b/tA7BC+uaaMbNzZGBQ8IOaWRPFGj+sIT?=
 =?us-ascii?Q?p7DvxEKnVm0OyF8g32hzn325sHyx85eu6plqvrDmuPnmBPe+dfMfX7WXjIDG?=
 =?us-ascii?Q?vQbikdSBecAtuBPEyMQXPm6MphCc8UMJy+v19Lj2Ff8q9ThdjvTah9FQ3gHZ?=
 =?us-ascii?Q?KmyoV+7VF4kmiNjEfOAB1rFdZntclzE2znMmVLCHwtSRtzzeungIuJ+uJqiT?=
 =?us-ascii?Q?fR2UNFoy2Mtsfuc61LCEwwVRFv6726Pj6YN/+3PbVJggszzFPsK3I08rIsDd?=
 =?us-ascii?Q?s3QL+aN6YlYxc/I3PVxT9j8X7StcCz+s5/0Lbk1CTgF/4R7GxvZUXF7S3OAX?=
 =?us-ascii?Q?46Xk+tIG0cLbkHYUHTXVqeSmTq2m6I03Yv+B5PFRXcXXPoBHasb/uwus375S?=
 =?us-ascii?Q?XfqfYx/pToYXq7dKTLp3GGpBnEJB8SnGPubLcCYssKvE+8YOEppEhja8OZoo?=
 =?us-ascii?Q?c2AeG8Z23qFBZLsySua+X9Zq937iTqNYxN9gFptY9RR45yOB2uuWbCqo5TsH?=
 =?us-ascii?Q?cRsbV3SNh+1CKg9978CMYCI5/jzfthItKJyHcKY/pCiKfAkPuyjzH+5/tvjT?=
 =?us-ascii?Q?3vzw4EZDhfSXADtxFZL4vBOafrKqNvvl5It7vzdN7RC/uz9Lp2GNMbMpzFRb?=
 =?us-ascii?Q?TZsRc4IPQuxX6jv5FUtEzM6uAitq3FyPw9J7jlVB+VwPmeB0FAh0ddX28M6Q?=
 =?us-ascii?Q?QI7HQjM0Cc6WY19i358o7eqbvxlakxeWIjClvQkm+r6ATFieiCfevnpScIbv?=
 =?us-ascii?Q?uqODsL6ZUttHjYPJ2TcoTwA8RRbDBZVmr+Hcn22tleTAH0IhVoZr/0yqLfHA?=
 =?us-ascii?Q?rMNI84kc/ngZP/cMb32yP9GQd94+51ErOJfSXWZwD8Cew8cYzNYgqFz35yhU?=
 =?us-ascii?Q?8l62xw4YWEAJoyFnetGBOXQWwY3988WvSLxcupvRxLk22MwFVs83M0G0pcGg?=
 =?us-ascii?Q?e+5dufPhryBqWKse8+KG+ThzBLGlGxONlWIhC30SCeE5z0XifGrzUR8ehjI/?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	31Bd1alZ2d8S7nZjwWbeHACxmq/bNhrZRMQM///f0wZ6EjyX0+raMAis6Z16ZUt7ma8q1xAJtL5cf2iRPQHvfNtm5AVQK5I/Vf/Awhxortd4oADk8T58DfTZWAtlVtEUsB3lVL9Y7pqB+v/OGr8C2YKooLfdSVqyYyd60gGvbDyqiGIbyKgGxu1AM0Qwa6oQ+Qi/37IpsTU/yJZWglf8Hq1/6XI+99vHGDgjjeabN8VsdolqpdJwwyswCi3d6iF5YLnPIwsbrYde5BS2JACbMro795JkaHyXTexaFuuPyJxoQ8In9w7tzu7BTHpindsIZatcqm0FpAyfVIuce/eCpynLBLvHCI37g7tPvLdTZfkyOEQm1VS6l5yLR1V3UEGEn+y09F+JIS8ey2f3CyWkcgSByOhBXUvTF2QEXSxCJ38w3kdxGN5CTHJa0D3bssHru1Jn9hDoaUCBmHRdf+chO7Xd2hn2axMAekz/91vs1qMi8ot+LKaD2Hz2AGfKzYTF2toO4nmOKeo05kItzMgtnQ5dbh0yhXaMv9HY9+Zq2MRQfIwTveB8R7BBwqZI7YGLBgHf+O3zjt2z3viBh21DD9AQ4nk9Bwj3FKizSCQTVB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc80c1-6978-4c52-7187-08dd416e5a7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:37.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVG89ec46YLgPsK69Xg1uyQnJUH1BDsBRjl72h8Zp+tpz0BiuLYW3VmPdvMjCCAT48O1k4wNGYfhVZ2Y9w3PoH0v84N0yEIpMSrZySvi7dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300158
X-Proofpoint-GUID: DD5Vine1Yoy130ljATcxiIRFhX_RybCV
X-Proofpoint-ORIG-GUID: DD5Vine1Yoy130ljATcxiIRFhX_RybCV

It is useful to be able to utilise the pidfd mechanism to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

We adjust pidfd_get_task() and the pidfd_send_signal() system call with
specific handling for this, implementing this functionality for
process_madvise(), process_mrelease() (albeit, using it here wouldn't
really make sense) and pidfd_send_signal().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/linux/pidfd.h |  24 +++++++++
 kernel/pid.c               |  24 +++++++--
 kernel/signal.c            | 106 ++++++++++++++++++++++---------------
 3 files changed, 107 insertions(+), 47 deletions(-)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 4540f6301b8c..e0abd0b18841 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -23,6 +23,30 @@

 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */

+/*
+ * The concept of process and threads in userland and the kernel is a confusing
+ * one - within the kernel every thread is a 'task' with its own individual PID,
+ * however from userland's point of view threads are grouped by a single PID,
+ * which is that of the 'thread group leader', typically the first thread
+ * spawned.
+ *
+ * To cut the Gideon knot, for internal kernel usage, we refer to
+ * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
+ * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
+ * group leader...
+ */
+#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
+
+/*
+ * ...and for userland we make life simpler - PIDFD_SELF refers to the current
+ * thread, PIDFD_SELF_PROCESS refers to the process thread group leader.
+ *
+ * For nearly all practical uses, a user will want to use PIDFD_SELF.
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
 struct pidfd_info {
 	/*
 	 * This mask is similar to the request_mask in statx(2).
diff --git a/kernel/pid.c b/kernel/pid.c
index 3a10a7b6fcf8..1d2fc59d64fc 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -564,15 +564,29 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  */
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
 {
-	unsigned int f_flags;
+	unsigned int f_flags = 0;
 	struct pid *pid;
 	struct task_struct *task;
+	enum pid_type type;

-	pid = pidfd_get_pid(pidfd, &f_flags);
-	if (IS_ERR(pid))
-		return ERR_CAST(pid);
+	switch (pidfd) {
+	case  PIDFD_SELF_THREAD:
+		type = PIDTYPE_PID;
+		pid = get_task_pid(current, type);
+		break;
+	case  PIDFD_SELF_THREAD_GROUP:
+		type = PIDTYPE_TGID;
+		pid = get_task_pid(current, type);
+		break;
+	default:
+		pid = pidfd_get_pid(pidfd, &f_flags);
+		if (IS_ERR(pid))
+			return ERR_CAST(pid);
+		type = PIDTYPE_TGID;
+		break;
+	}

-	task = get_pid_task(pid, PIDTYPE_TGID);
+	task = get_pid_task(pid, type);
 	put_pid(pid);
 	if (!task)
 		return ERR_PTR(-ESRCH);
diff --git a/kernel/signal.c b/kernel/signal.c
index a2afd54303f0..1e8f792f88de 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4009,6 +4009,46 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)

+static int do_pidfd_send_signal(struct pid *pid, int sig, enum pid_type type,
+				siginfo_t __user *info, unsigned int flags)
+{
+	kernel_siginfo_t kinfo;
+
+	switch (flags) {
+	case PIDFD_SIGNAL_THREAD:
+		type = PIDTYPE_PID;
+		break;
+	case PIDFD_SIGNAL_THREAD_GROUP:
+		type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_PROCESS_GROUP:
+		type = PIDTYPE_PGID;
+		break;
+	}
+
+	if (info) {
+		int ret = copy_siginfo_from_user_any(&kinfo, info);
+
+		if (unlikely(ret))
+			return ret;
+
+		if (unlikely(sig != kinfo.si_signo))
+			return -EINVAL;
+
+		/* Only allow sending arbitrary signals to yourself. */
+		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
+		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
+			return -EPERM;
+	} else {
+		prepare_kill_siginfo(sig, &kinfo, type);
+	}
+
+	if (type == PIDTYPE_PGID)
+		return kill_pgrp_info(sig, &kinfo, pid);
+
+	return kill_pid_info_type(sig, &kinfo, pid, type);
+}
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -4028,7 +4068,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 {
 	int ret;
 	struct pid *pid;
-	kernel_siginfo_t kinfo;
 	enum pid_type type;

 	/* Enforce flags be set to 0 until we add an extension. */
@@ -4040,54 +4079,37 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		return -EINVAL;

 	CLASS(fd, f)(pidfd);
-	if (fd_empty(f))
-		return -EBADF;

-	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid))
-		return PTR_ERR(pid);
+	switch (pidfd) {
+	case PIDFD_SELF_THREAD:
+		pid = get_task_pid(current, PIDTYPE_PID);
+		type = PIDTYPE_PID;
+		break;
+	case PIDFD_SELF_THREAD_GROUP:
+		pid = get_task_pid(current, PIDTYPE_TGID);
+		type = PIDTYPE_TGID;
+		break;
+	default:
+		if (fd_empty(f))
+			return -EBADF;

-	if (!access_pidfd_pidns(pid))
-		return -EINVAL;
+		/* Is this a pidfd? */
+		pid = pidfd_to_pid(fd_file(f));
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);

-	switch (flags) {
-	case 0:
+		if (!access_pidfd_pidns(pid))
+			return -EINVAL;
 		/* Infer scope from the type of pidfd. */
 		if (fd_file(f)->f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
 		break;
-	case PIDFD_SIGNAL_THREAD:
-		type = PIDTYPE_PID;
-		break;
-	case PIDFD_SIGNAL_THREAD_GROUP:
-		type = PIDTYPE_TGID;
-		break;
-	case PIDFD_SIGNAL_PROCESS_GROUP:
-		type = PIDTYPE_PGID;
-		break;
-	}
-
-	if (info) {
-		ret = copy_siginfo_from_user_any(&kinfo, info);
-		if (unlikely(ret))
-			return ret;
-
-		if (unlikely(sig != kinfo.si_signo))
-			return -EINVAL;
-
-		/* Only allow sending arbitrary signals to yourself. */
-		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
-		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
-			return -EPERM;
-	} else {
-		prepare_kill_siginfo(sig, &kinfo, type);
 	}

-	if (type == PIDTYPE_PGID)
-		return kill_pgrp_info(sig, &kinfo, pid);
-	else
-		return kill_pid_info_type(sig, &kinfo, pid, type);
+	ret = do_pidfd_send_signal(pid, sig, type, info, flags);
+	if (fd_empty(f))
+		put_pid(pid);
+	return ret;
 }
--
2.48.1

