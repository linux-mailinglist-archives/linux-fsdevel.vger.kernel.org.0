Return-Path: <linux-fsdevel+bounces-32266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827429A2F3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1375284CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DCF2296EC;
	Thu, 17 Oct 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e6TPyDPw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DbAlvB+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831322911C;
	Thu, 17 Oct 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199197; cv=fail; b=az2qQ8g6Ey2pebMCKCLZEe5XBXS9R5BT0HDQ4dsRPB9VrrI93qIxxiaulj9YkkeACwLazhYWvPGBIMezDsRfaQKAggVgWT4gaTHSudqN3TC0LV6L3fBeu7iNPIUx12PkCrtq0QHHWiwe5SRU+ZtZaejgNtaoZWFLFh9jKAZBf+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199197; c=relaxed/simple;
	bh=gBAQCrSuIZu8NAbsESlFkT4iCFD66XLooifvK4iE7RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyiNulCt1ZPoNTMTf3WlDLDUaqaH1HpqDFpQyKiXFyP5vHX8Pqki+WGYl/J7fWr3Q7Ad8S1WGkoZMl+b/+E1A8LzvpZ0EsxwUckdkeZ4UH0M1x6VwTIL8nLn8hdfHAr0dvquxg81Vgiqk9Wcrg3POFXCMLuUEwPwsUBMtIbxESo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e6TPyDPw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DbAlvB+O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtkgS010328;
	Thu, 17 Oct 2024 21:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lnHUS4UIhYyR8R1+WVfMLZVb1cNLjoWfDTQTYj+KaEI=; b=
	e6TPyDPwjCgI7hdpv9nuZ2S2mBnLulhSRqLxXYOHY+bNd5vHM18q1bEilIrwTRgU
	ZT+Uw7H9k9kGFMp6bmwEm/WT18aB1IGy18YpvDnWTvJFSezVT11mxeuvhQCwn+eG
	MmOjjtrDfCTUfFTySRFqShtJDME31FLvC6Ev1ajtknA/kaiECETY5ME4DvkGah2z
	QQWS2Tq0kI5c7a/PWU2Fl27KrVXuo6OzpPED+c86LpMoI0xB+KUHf313pZ3fr/qj
	hfP7h4GxuQrtGM8QlxjXzphSdSYrhLHHkKyOdNLPuvuHLWepcgF3R5su5v8Lcybu
	hOukwL0aLV3qiKSvdlpaEQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09purd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HL0Jbf026190;
	Thu, 17 Oct 2024 21:06:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjasv2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMq7mOCu9gKE774KrwkpxKsvMVnQ6Df760IrBxSLWN7PO7QW2m+eYreVNOeB4kVrG6pKOjz/GaPEKtaoOL1SP2sWcVrUWaMQTwL0hPAQTm2FH9BGVNKmOtTFqBqYA7WpRyY33o99BWdASHEl+4qnv6jPDP3PLO0m9Jxj3vY4MJAWmoz8Y0wwnCExZNYYlbTQCwP5acu6MK3IMFTvAfRBH3s0zOUv30iwPjKecULrltXyq81GWCsX8QyLDC5x1+MgqnTxg0+wfmV7OzRpiqVzp1BTsfHSwY4CVTm4z+s8rK8/zyDcJilXksD8tgCqCzTMtTBDJ3kZw4W9xcgTQje2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnHUS4UIhYyR8R1+WVfMLZVb1cNLjoWfDTQTYj+KaEI=;
 b=IiqYNLv/ssmqDizv84IV07RQA/tnAKWOGDCSv8qikuuOEWXAxEzWkiOFQ4p9yZcaZsc61DUtwQvtpRdsA1P936ZzLbkyaMhttpTw0iYO6l28xIWmZ4LMNSC1dS+S+PPODhd6X+eCN5XiFy0apNL1S6W0WF2uJ4BVFncxTL6DX2wQcWJbKM5v+PtsaMxlhgtvA5GnBGUfk+DJA7QysYpv6xr/KdTKKNhoxWoULl9hNxOsrDkUT8VP6vaCe8edSQ4uGirnxQMctl2ZOHC1auVwR6xL0JOofdHIEFiCKmmE4nXBcuHNNjdVxxm3rqXud7LgpMqC6vX74kbGtytnO0CRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnHUS4UIhYyR8R1+WVfMLZVb1cNLjoWfDTQTYj+KaEI=;
 b=DbAlvB+OpBs1L51Ix6htdjDPE9+/rqq8X0Do4DsBCh7G+cq6Ynwri+A9tYfixbBu8VYkOLKsW+dXyBm7IQ84DbpwhRc3lm7AflZrQxA+R9FfBmIFV3Y8X3iKdo87QNorrVn3hy7bxHwgKIwp5O0Ot54kb8iRgNJ2zPinoBYd/XA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 21:06:14 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 1/4] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Thu, 17 Oct 2024 22:05:49 +0100
Message-ID: <94a3210afe96c9d1d6f9460d7d37a43e5bc5f550.1729198898.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: ad521fb5-85cd-4c1d-a1f9-08dceeef88e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dexafrH2TmATgSjllgaG6rOliHvpff+AezMXr8dejFupOMQFuU9Zu8DwWvH?=
 =?us-ascii?Q?rBiU6RPERtWLi7MuUySFCUibxZFV/c+aJhu3xC3hNzUCtMtSDskamhZKiWoh?=
 =?us-ascii?Q?/KhhZNQnzNi0vkDi0Zywb2gbQgYWeVdPoMC5zEtYsWHH9Q9HxMjDFDFmE939?=
 =?us-ascii?Q?SW2e0sYpVq0hVYbbvPOg1ohpwwGMLszoC9itY6aeB6l4QeuEwGFVNWg9nd30?=
 =?us-ascii?Q?SupxmsWpKyKFYgJe0yJbUmXyvxO9ayefSK2jkVFbg/xU37oFkT09u4K+bwV6?=
 =?us-ascii?Q?xvD4vtyUFunK+zmlWMeZKXTjRNiQi/v5YHI1hLkKGcaseLd3bB2HQxSYTqes?=
 =?us-ascii?Q?BuF/kg+DcGIpMwgJt/OEbqy2fl2NRepS9cJZMJH38AQF7/eTPf/DJ/W6k7g4?=
 =?us-ascii?Q?gqj3JpFEGkh2uTunpQCb9/RIX2ImIj2T6OZecc9xFV69OaE01AeAqQaYftd+?=
 =?us-ascii?Q?IVmEVxkJiqzmq5z0kQUIRuCO1q7+vpld6agv54NVzfvuLgy1R8B2sLhXi7cB?=
 =?us-ascii?Q?3Z/UyUMw2uFDwrlJI8Jaf0AxP41TW7SyfC8bR7k/xCy63ncpc9ZQUi8zjTa5?=
 =?us-ascii?Q?cLOMEI2CRRv3CdjWA3rRQer+iAgGpDgA7UaHUUi/K9SDChfNjaak2RVISoSq?=
 =?us-ascii?Q?FPrWahwcVQrVkLzTmG3esyWTVgsCMGWZfHZyinrKbfRRT8FShsqs97RDjlli?=
 =?us-ascii?Q?Xc6jfEwBHVI/ibsxjxeH/OCTgFSmic7rPU+1sJc1sjazYnMsAKxfI85dLqJt?=
 =?us-ascii?Q?esdT4W1HUp5ILMnAPqnaMi4cTO/fSZB4A/a9i0CBuiJnIjVRPzWgI9LU+X6J?=
 =?us-ascii?Q?mtlaIKQTAzzLsX/vu6Rus9w0K8Fe8FZE69lnaZNBQLcQESAHtD8r8Jsqbx3s?=
 =?us-ascii?Q?F0NOai1SG0T2TzYtr/MFyQqUXCb/Z31lgIBewanoMEnVX0kUNIFyt0fxMmQV?=
 =?us-ascii?Q?Pva6G4D0bsZ5JJw95b4YJFbVkEnmI+anwjCwd3SWQJkDENLJu0C0vEyQ+qo1?=
 =?us-ascii?Q?wLCIuh0mYQ1/9gdLbGGOa3Bgr+Tfp8+kL96V72CG8JUU2jy/PAqgVzF5O3Xt?=
 =?us-ascii?Q?Vbm/3bAOABPOF9uUnAgXkC6mnsVdkpM6wa6NwUxQM5OD3tiIAnEX327gNUl+?=
 =?us-ascii?Q?Pw2QRQRgGyK6XOIIB4JwUX0lYzWVTqUhKMNLuuSvJK9VU57twvNLycXYPf2M?=
 =?us-ascii?Q?n4Nv5Yw/NwJSMC7LDd9vGBi7WAmC8mULLWiyfYF7q8qoA4pmFum38PfbTPdd?=
 =?us-ascii?Q?T3MNGuAa1rzv2Ja/haR8v+kXt7XMY+4nfjF5vFJIIj+A4bTLAOxFot7Y+Egq?=
 =?us-ascii?Q?SgbRu7tfa44VwoIZSaxgQDN0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sVsPPMk9ZfaI5ExrhAxmeoN4T6RPs9ikZ3y4JGooGHoNq7X2FsE9acC4fnQ2?=
 =?us-ascii?Q?sSDCnkAc5zUaL/ij2gJAZOTTYBmumFRuC9u0oR/shWKWB6MrawbOlzhRoHnK?=
 =?us-ascii?Q?xgDNs48DIwO2WVIlQwC6f2KhnvCFhARBRa+ks7bb0Lg4g/fWjpLD+A00DMmk?=
 =?us-ascii?Q?MO8FE3GhEPD63pgwRaSwCt+cBiHMYwv2Aiys59Kk4Lqrel58YLv6NELhOOhu?=
 =?us-ascii?Q?xSKEnxeb+oOmH4KKij2vPV3VbfPyXFiX4Xf2vCVhfzn2iOAE/K/iTWt4/iVB?=
 =?us-ascii?Q?nP+51vlIl5E78oR6sk7ZmKSjyz8aXIXq7IjVB0yX7rhbRsNzxZ6uAHiKDsbH?=
 =?us-ascii?Q?m+sxrcUryN9rFt51dfMqGpGeQgoXUglYobBaLI0GdAQ3qS0vtef9ZDsPYCkJ?=
 =?us-ascii?Q?PJ9wyEZ68fjO9gvldm/XvfQnItgV09cCe2CEUvGfhAkwkKvHClQpzOqwFIsD?=
 =?us-ascii?Q?CnNunZTLU/NPrKnvQKLqBNOLz1lw5qmDbwTSXHhmtUNfvE1ZcV5/4ZKFBK3Z?=
 =?us-ascii?Q?BQrJOCmf/wlbNNCTw1CZK0HSLjwwbPNjQnoRHuEfd0B7aunGeygF2Q1t0A0p?=
 =?us-ascii?Q?A+bds9f02OMXcnrgFJFBu3PJxMosmxHmsmv8pWIxEyqa7IXs9HYGScqwUarY?=
 =?us-ascii?Q?09bFQwCV1ime7hDa7c05jo09lEzB0JTGOKLKp1MJIINVz9LCigceoFTv3+TE?=
 =?us-ascii?Q?M1T8Afl3eibJx/CRLLisjduxAMlu21qBlk60kDWA7p78m4KXowf8u9xHzQq3?=
 =?us-ascii?Q?4hVagOtgE1QSok8Kblb5c0cQjIFVgg5hKkZlzY/AmZ3iJOes5DmdxDltihKJ?=
 =?us-ascii?Q?Spq2BHKgiVKQQm/fNFVfjwYF6I6ouNdvu6kcFMojPRhdz1VJxivxML4V4uku?=
 =?us-ascii?Q?bLIcVlkx5FEI7axeDhJnAzeg9mBdtf+7bK9FGq89yWjxDPjaIoUeN3u+5e4x?=
 =?us-ascii?Q?8g+/Iz0yUBH6TyhH8IV/l0M7mBYZ2Nsx0ikvw8eo9s/hMREu+14GFyxdtdF0?=
 =?us-ascii?Q?I5umlVWct9fP0RCum5DuOeHOoMbvKlNXPxftLflYv9ULI1S1sYn5JZx0cYJF?=
 =?us-ascii?Q?mgJyk8a6V+mRdCu6q/8FC7fVTdGW8XxB0BCZtGaoljupYOXo+TUItrg/7wPq?=
 =?us-ascii?Q?jpTfX4ypwRNElHxrZe3rrH0l7xneP0I4qM68coW6x7ZvRNSx7oWMUSwjpkj5?=
 =?us-ascii?Q?qYx4eOnkBMStwW3VXWfx/h9EcmUxbMYWmBLYa2UG0Ad604qAX5fFthaej460?=
 =?us-ascii?Q?5SMel7UlRNXTRsC47626uU1yEgFfP3U2CpFNtgdXtBhq878soS2Wq/Vr5D3v?=
 =?us-ascii?Q?BIyUNmhwdB7U+Hayy33O1gQS+LgZK3L+dbU0KshtmABkLDNdrHpcBW6HYs52?=
 =?us-ascii?Q?m6tOpI02jXOHPDbba5GLzsj+HWTW9I/hKvH6wQ8xV3XEPN1lwygWjxQLBiCf?=
 =?us-ascii?Q?xmXZjnCuQvsVzcoZnCigk6dhr4kU+0i/N9eSXeG8vG8a173J5194Dv6/6fd8?=
 =?us-ascii?Q?ux/Egfc0q3yUW6VEPBuvGEwC5DGtHoT67OW1Vopa9XwIu86EtwDHgmJCHfjY?=
 =?us-ascii?Q?mOsLB+v6s6udvj3TlsxOVv6iQrF/M74v69SSL8gg7JXF0kLlanh8EoOKK4PK?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Udt6YFq67GMgkbxBTjAI5IdMr8aVVVh1p3mHaJhUqnHjlo5BA/kEmpM3WysuQP1I8G8yCsXLu7snK7WrRwm+ykwROl2F/tkU3NaA+EXca2uOYQ+3eFXe2HcG/Y4NnEJ7J9F51yx7ZzhELSSviG4DhdXtbwD1BycEYp3DYXdpQlY7DoyI+RcBcQLxCCqhTYW+idtUFNEKAwkl5Uhol/GzfCci8Ox6GNY674LYoZaRJ085L46wEyC0cBS3OjNNbE8Ge6QfA51RXWFM5jAovd/pX3EY6lw1dmLAzp42c/3KUVDIddTxWddHAOqYLpzaM0fTyv+vWm0Qodp1DleNB5esWqGROyugTXlgxRaUGmwFOsQtE3l75tfN2CunxCepghWE90vj6fhlEyQKFXXddrhVQenOI4IKicwMlvX3UDjt4gDqPioh9wuupp/WVewXET95sF02CQPL6nz5iagycSAd+CGNhvWu/VXDUk5Nw0kIpcAECkRxC9tQ877x8DoVnyx/36x357AHKdNjXdzScOtnCh8w4A/tv0enhCvktJfmUuLy2sQRWjBBL8LgsegwwMaTobTl+Aut1nK88PZum0WQZVhBTkZmgBvjWVfpkc8DuP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad521fb5-85cd-4c1d-a1f9-08dceeef88e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:06:14.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdijfGn2cMsc9tezCRVFdptYYAieBtsWdJMBzOYsuA8b8dGSbjCMAmdJxKxfnLnxFpHOECgXCHJJQDtmYoM+O1TwbQml9Wp2ErOWLsqIkgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170142
X-Proofpoint-GUID: lmNZHbo8Z2WfyRHnObzRSjPJRcNJaBA5
X-Proofpoint-ORIG-GUID: lmNZHbo8Z2WfyRHnObzRSjPJRcNJaBA5

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which narrows this to one approach of pinning
the pid, with an optional output parameters for file->f_flags to avoid the
need to hold onto a file to retrieve this.

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 30 +++++++++++++++++++++++++++++-
 kernel/pid.c        | 42 ++++++++++++++++++++++++------------------
 kernel/signal.c     | 29 ++++++-----------------------
 3 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..d466890e1b35 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,35 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ false, flags);
+}
+
+static inline struct pid *pidfd_get_pid_proc(unsigned int pidfd,
+					     unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ true, flags);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..94c97559e5c5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,32 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags)
 {
-	struct fd f;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
+	struct file *file = fd_file(f);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
+	/* Pin pid before we release fd. */
+	get_pid(pid);
+	if (flags)
+		*flags = file->f_flags;
 	fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +758,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..9a35b1cf40ad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,10 +3897,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,16 +3910,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	pid = pidfd_get_pid_proc(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
@@ -3939,7 +3922,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
@@ -3978,7 +3961,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	else
 		ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
-	fdput(f);
+	put_pid(pid);
 	return ret;
 }
 
-- 
2.46.2


