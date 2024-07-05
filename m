Return-Path: <linux-fsdevel+bounces-23215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEA928C35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36D1286B72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE816EBF3;
	Fri,  5 Jul 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVhkQHHb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kleoQGXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6916DC04;
	Fri,  5 Jul 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196728; cv=fail; b=uEkmPK2dZPK0iHeQyzYC1mxM/HwvY56eMCE0occWFUEk6TusYvCBiMrygPxxmbEPisZdhlebN//I1h2zEmsv6spJbWJbNBzJQni01FVwm7SRsBIsgvVNr248frFUIKwefvt0VYlR7d2Uu48qQNaD9lyF70pvvqwNoZipyM3W/X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196728; c=relaxed/simple;
	bh=m9qupusLatiMcRWqxEPW+tUW8YjtqcUUn6ib7LOpjgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CY+MHK3MZgrsASFFww30muSDM36CUQPoorC9YTT3P5ApG4foYIP/Dg6fLWO0komN27VfvEMY9ckJo6dfnA7WJ+KxNcTLXC6p2TubPIFaMs0JKnbrUAA2n2yHui28qNG5NMIkcqlT7FjGTrcc50InRLSfFV2dY+NeFKXwJI8lNys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oVhkQHHb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kleoQGXV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMWNG011060;
	Fri, 5 Jul 2024 16:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mvkmdsTKbmRDYAsUlx0zwcpQYUAjXAurKY4lXK4NIvk=; b=
	oVhkQHHbKTj4tDpQuImUrfPOYnl3MHOw+A9pC5i2yDVKaJIcaoQ6iPAjqSrXfH2U
	yC6DClI6uJndMmZAlrnjN8xSxvpIdYIz6+ZDo6ZOyulWuN1Rj2imbJie/4uxe4GP
	kQtL9lgDQUyPZD8PQwLf/lyuqLkpUPf4BXVB2XABsG+kQA4o7Yz+hiw4gPiaRptw
	dpaKxf+hLdKGjP6YRR3Tm1URqoCCEa/Gp/gKtdjDAfJZbLiAKDwlPInsIsr11aZ4
	/esRZ+6T8cJcNOaR/ez4ytQeJGs9AkyyYTvr/L2mrLPN7BRe5Fib01r5ylaIehB1
	FcTMz/Uu5s9Fx3SgiSxogw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0v9dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465EErot035660;
	Fri, 5 Jul 2024 16:25:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb9g3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIWx8HV3qI0RC1Mkb0VzKiok7+oQMKIDBYqE0Rb16+GW25hcuEb48yVeh4TJYGL45CUvIFaxkpxMuA2Ra2pJRPEELA+MtCfYwX1C63ac1ke0t9tU9rBx1cA9DuA8CyHUtTyMvdhOl8W48/WLJ/l2xSf1Q3iQ4Z9g6Qhr3vKzhtBjWk+eleTuyvkjxcNGm5JPTeBjwHWghRVXvu8g0AyLm7kz1/e73y+IdmBYxYW3sPQYv3MPOL2U4TrQ2cD81MMUiKYMQYPlwHwqtUxwnmFg9V6mZ60pNWYK/1k2S9KDpFrfG0HKUFmRbGrygUo7tiFhkXl22RTyAbG2skTjUGhaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvkmdsTKbmRDYAsUlx0zwcpQYUAjXAurKY4lXK4NIvk=;
 b=EJF4I3MpJPS1dF44dvRuio7Xf8UE0fmOaSXHBGbfIRLzRVsAdQ2uAhndcAd5icXROO+zQK6atKhHfAutmHXSc+tLPYgktQz6Bg0Kwju2e3cnib5piJpguNfMttZovVU2Bk4t9kpswrouzc4N/TXlbwL4oD+5kAWv7JEDAFgaue/gICd+CMkSa5l1oCEgP6kOtFLQBLk9LAcR0TdoZx6JIm19VQ18Ca/28W7HggpADZfKhwjLlQ7KFO0VR8aH4yFx5Z6Tsl3T0T7XXjUSx9ZSkfNQSxuAA8ytsr8/fJ++BJjNw7xklJiFMIFTKkEKPUFGqOsQgXN21YrSZhgVA7yc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvkmdsTKbmRDYAsUlx0zwcpQYUAjXAurKY4lXK4NIvk=;
 b=kleoQGXVEVPI2YbmpkINF+kIUHJvTnR0zHgiAailjnTIH3/BELD8jBFPhBzlvBu7tNh2K2OWwelmXxT3y4zIQtSb3fuUpvO/RjDrzoYHGf8YVI/LwyUqV64FoqRthwXPU8SgI0ub0nxavLYjx82MPHTTZOxopHDeCxjtgL+5wTw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/13] xfs: simplify extent allocation alignment
Date: Fri,  5 Jul 2024 16:24:40 +0000
Message-Id: <20240705162450.3481169-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb4d5fc-86e0-45db-5633-08dc9d0f0b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Fv6K2qfgp/abg2HBcBPcwQDkGDy1pbFJDxBuwCF2mFPkslLh5WPXU8/Cp3Zf?=
 =?us-ascii?Q?CtAigys7P3afdTTRjetXYLve7lrHzN3cS8FyF4nk6GW+IvFPcnZwHUReLHaw?=
 =?us-ascii?Q?oeLAuegXRdB8iGGzNd7xw0mtwYwfOCe/nTyDJzuMmn/hhq8iPq/GGxyAY0pE?=
 =?us-ascii?Q?1TbhAjQXfLv1I/Ctjw3M0wcY/q20IA8EE1azLuLXRnjDSyl86LHawiB0I9yV?=
 =?us-ascii?Q?KV7DMrnFa7szJ2VAw1gCAnGDjIQj7c9bEBFcSVNYz/72kPIWeX8Auxy4rxku?=
 =?us-ascii?Q?4i6H3TVfEIgalyO7zONd9Wj8/JN8qvHtM828f57QofaKanU2lRW4ymlnfRR4?=
 =?us-ascii?Q?PV0QSRJ7dKv0sQ3Wsi3nciCeI1R+MJMV1r+fP6mKt4YZSeUPdLIo8RfGmiQl?=
 =?us-ascii?Q?QH9gRaxFHGKnGtDW9TXbPRaTQHxVvG9Po5y06uAVdjIg7+7+RFODUIIKbqoE?=
 =?us-ascii?Q?0DAkbFBpVX2DpfJY21BpJTrmI4yRGvXOgC15ufG4bAXb8xgENt+ivPPtELPi?=
 =?us-ascii?Q?VGU3/+0XTe9fqsfGhW1r94qGsj6TpAOerHImkXw234mN7RRJIYEMbwMnqAPT?=
 =?us-ascii?Q?De+GF4iRZmVZNeCQITdjk1k287B6XTHAVvoSx6OuQVI+yirb5Tp+b8KliAkv?=
 =?us-ascii?Q?dlPEUWhkbCcHRb44Y/7A2gMhdLiFwJZBqaXYX1cx4SGN8O3uh3msj/9JGKuW?=
 =?us-ascii?Q?xMl/8mNLrTGVtGW+pUBPfEzP5v035wEParQEMu7Gw78yRHbcz5Cf0fzM9xxe?=
 =?us-ascii?Q?s5erkQYVPYGIQBI9f2yb09zpbm/7fAYVipUgRPbBTPFKMLBuqqsfDkZRJYv+?=
 =?us-ascii?Q?62U4p1OqcDB99sgc5PEEOw5MwbOXXAMYDcV1qlYTzwQ1iyFF5ko7VIbCShie?=
 =?us-ascii?Q?azEvJ66N1EqThlnXsgjbT8uza1V20pdieKzZcnjjEUAQbWqinfmZMpIh03Xe?=
 =?us-ascii?Q?y4ePzYu+PAO+PBOP9QCXc5dWxacTkV2cMCzjlxZJAGod1ZYByxtgQI4iH86V?=
 =?us-ascii?Q?0miPPnturri/X6nHImWytUyhh6mVFGDj95usfK89rVojIZlhk6dD470dzjn8?=
 =?us-ascii?Q?VrJY15HPgnyCx6du1N0Q4h7UM7RH9k3ZBjtG9iRmxGIBcLyF3zDKHHXQUVnQ?=
 =?us-ascii?Q?+gYNRmAE1LONHwYg05hN6my2y4FMCNtnNfj2xny4NT522n4p6Rg4WzVN8LIQ?=
 =?us-ascii?Q?xi12ehwDuCNfk/ocppZSjAMg1udnQyUmYTeB8ouhJapW3m9BmkysiFuvfZTn?=
 =?us-ascii?Q?EY55dvQ0sy84EqVD4FROHHWdJInDKJYo9+TdYVk5gOdJQJnvoslN/YKHqIVb?=
 =?us-ascii?Q?ZiapRkCm0K+n6+gKOFFai4cixzG/0QpSd9kHcm+Yo8BmlA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OuwUMat+/y/5TqHxtgxaCG2JmAlOdQx/GR/TGAqoECsPtLcHNrzgxpd5nRha?=
 =?us-ascii?Q?7/rYMW6U71OMb9eirNSSWtpAnrgvTkceKUoM+UoRzRYHgrbvE+S9Eex9Hxmp?=
 =?us-ascii?Q?e2hDYTVnHDHIAW3NXMvdzPWU5zYHtcQoL90oJxE8zKu5mWBQ+utopBadLJ7q?=
 =?us-ascii?Q?zQjzQHb4IESLc1lxVPVyA7cSOUiC50XcDAWunbDwyPNmJSZG0HJamLoeGNcc?=
 =?us-ascii?Q?gwFvdprukhfxUZMN6nTS0tORcPrPiu9v8O0SUXsglzuhHDLap/TmpbEUKQzW?=
 =?us-ascii?Q?7nIzzN3psy/olnBLuK3ApgiPPZGEppGcOSUE45IAFqLCGl6DTYl4SjWN5juR?=
 =?us-ascii?Q?m7xOY4M5S4gCTwtCIoyXt1iOoJTIk4cMdVI5tnmgNQ5iEAU78RSPM1woydz8?=
 =?us-ascii?Q?s15nQVbFcpIqUUKAcmo+yW41WFCjIHY/M4R71PNrzuwodF8ZTjYNEFf4U7yb?=
 =?us-ascii?Q?d/Hc+aQof+LkttOpeyMTmTGB2JpLJaHb+67fzoT2UGx1a3O/Pa+uQt0AzGAS?=
 =?us-ascii?Q?4EuyAxp7/+HU7adzFDOidlRgCrm3VGOTBUzSMtLcpiJZEXFxJP3pqFioI9vQ?=
 =?us-ascii?Q?JgEL98znCV70AiNewwBDNBygKW8V6lJFkcVKs5pMJDN3Vly8NLmzQ/kDuyG8?=
 =?us-ascii?Q?jIf++/ep7gJq5ivew5QTqavUlWGA4ag7pgn5gpVdaK3zhKVXI69WYwpMDmLr?=
 =?us-ascii?Q?OWbpCtI75qxZvGElgu3dILxFQQ4A9qPZi5cKiLkA+p9qfDtolgGbqFQSKGZ0?=
 =?us-ascii?Q?9D2ytkK9PMeTrSKLb49KacckXFZ9LT3p1iaxbn4By7aAJkCfibR+XyVZwdZ0?=
 =?us-ascii?Q?jTTzk8U/wFI7AUXbheMIlz9IgTn9YPVG27mm5oKC6D4CJAguIyjHOEq7ag1l?=
 =?us-ascii?Q?3q663Yk58vgTDhnDHBKSu07IBHQOVtdjAxlXLQxL+2y2RbmUU0rYuHDGWc1z?=
 =?us-ascii?Q?taJ9Rt7B7U6IU9Fb6TDWMQvBffrPYDqOH4LCIasSZVKiGVeml+IZwmK0V8t9?=
 =?us-ascii?Q?FDGkdhbKg6jSjHHsrxlkN5XDxS/y6cUDnVv/m1C2y2B85Y2uw/V6bvysxPgm?=
 =?us-ascii?Q?jqrYjq5ZyYY8v0IHRasxGvIEIlZf10D2H8lmEXop3FQe5rwtxyioGixZFour?=
 =?us-ascii?Q?/yVkF9KW6IOfrlOM9MNsSdzePBkZEVGabyL8ElOy6TiRFd1KW1dFQS+zgajq?=
 =?us-ascii?Q?AnNyGHF6boi0HzEKMbzwsZ8Wrzy+Ir+59AXOl0G1uL6akxoJNIEgdCVptRQ+?=
 =?us-ascii?Q?OU/FKZ9uTd/K1wIW1oUPYSlhmNCcv8RR63Eja0g1i8wGCURs3wjfti2IOQV1?=
 =?us-ascii?Q?EWcqvJJoanmZHKFT2mGMr12ATDX9jt+HnRwg5GWNvdVlhqOFo+GdG0RgqtMc?=
 =?us-ascii?Q?C1VYGogiwAQvA/cCXynzFkEanqKeMQf2S5qJrkNvby2ZUCxxcfaIu2uTelWR?=
 =?us-ascii?Q?vEjmloT6sFE14LCpFveQzv2EkQNkTg70x6CC64YO9qYQIYadlbvwrxC7voHN?=
 =?us-ascii?Q?Zgx6QkLE0dJX0rPZyLPwtei6drtP5ogFunRLLet7iwJUCooFDF3WoHuO64wH?=
 =?us-ascii?Q?NexzqMb7GgD5iosKEuj5XjSVkQj5Ns/1eIrEvvytkrU1/FbavMeI0sX31KVT?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Kv/l5QXtQl5YsvRrI8N3E2epS9+1U0Pf+NMWVAN8h0F/Bku8uuetEAy08wcnydF2gijnCOxhK2s6kmwTIPPA4azbBUWVEz6SnxlSNPL/3VrCRzDZF1USIRt4MDUjcjSDFvLGAsPFGJW2KpmjBNN1v/enALmsxOnWcQEKzD9Vll8g47IjuHdEZ1B76MPnV0avqp8oFUtxrFfdUG4LX7kYdnwRsGGvVBj2iwQwitmsc+pKosvo4FkLvHA3bJq3gWUi7K0hT2wasGYnQFDThqh6fRWUTWhsQkAkCJ5c2cxyYRDbFJ84URFgXUVwAyC3IvJI8kLcK7flRI6gK8zN3vEsBC5G4Leq4t00XccxMdHkv0in22QFcgqh6OeVhwntYWEkR8Y5qwqcHRRpxFU2k42/dhrN+xO5bvKaAoi2VOD2V13i7fyXNJlll3vQHKSDNz5QC2RbfIlyHlwPpnSkFgp09q82JEnEyRkqYqFvjNqLfZFPuLx0xcGiLrOiMUXSJXOxvAOyz90moZk2euxHH1lLoJHRE4dzsmvwdstfBl7izd5LWl0hfSP5ooTHbCzH5xkVG00n+eBucfO5orcsCPKYu8BWEb5KBrhMlIkKDrcob4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb4d5fc-86e0-45db-5633-08dc9d0f0b83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:12.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODbbUEtQCb+lw21DixRFkXOGfyzYDFniTRvhyN0XkUITNEOU1pB3h1wl51UDdYK0yauXdkEgk2NyQvtiO5cBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050119
X-Proofpoint-ORIG-GUID: qvIVJKu0oT40jc6vWQmrxqkzxaS9K3ai
X-Proofpoint-GUID: qvIVJKu0oT40jc6vWQmrxqkzxaS9K3ai

From: Dave Chinner <dchinner@redhat.com>

We currently align extent allocation to stripe unit or stripe width.
That is specified by an external parameter to the allocation code,
which then manipulates the xfs_alloc_args alignment configuration in
interesting ways.

The args->alignment field specifies extent start alignment, but
because we may be attempting non-aligned allocation first there are
also slop variables that allow for those allocation attempts to
account for aligned allocation if they fail.

This gets much more complex as we introduce forced allocation
alignment, where extent size hints are used to generate the extent
start alignment. extent size hints currently only affect extent
lengths (via args->prod and args->mod) and so with this change we
will have two different start alignment conditions.

Avoid this complexity by always using args->alignment to indicate
extent start alignment, and always using args->prod/mod to indicate
extent length adjustment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 95 ++++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 2864520c3902..67b11e4d30ae 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2391,7 +2391,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2420,7 +2420,7 @@ xfs_alloc_space_available(
 	 * allocation as we know that will definitely succeed and match the
 	 * callers alignment constraints.
 	 */
-	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
 	if (longest < alloc_len) {
 		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 3dc8e44fea76..1e9d0bde5640 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -46,7 +46,7 @@ typedef struct xfs_alloc_arg {
 	xfs_extlen_t	minleft;	/* min blocks must be left after us */
 	xfs_extlen_t	total;		/* total blocks needed in xaction */
 	xfs_extlen_t	alignment;	/* align answer to multiple of this */
-	xfs_extlen_t	minalignslop;	/* slop for minlen+alignment calcs */
+	xfs_extlen_t	alignslop;	/* slop for alignment calcs */
 	xfs_agblock_t	min_agbno;	/* set an agbno range for NEAR allocs */
 	xfs_agblock_t	max_agbno;	/* ... */
 	xfs_extlen_t	len;		/* output: actual size of extent */
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 6af6f744fdd6..b5156bafb7be 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3285,6 +3285,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3393,35 +3397,43 @@ xfs_bmap_alloc_account(
 	xfs_trans_mod_dquot_byino(ap->tp, ap->ip, fld, ap->length);
 }
 
-static int
+/*
+ * Calculate the extent start alignment and the extent length adjustments that
+ * constrain this allocation.
+ *
+ * Extent start alignment is currently determined by stripe configuration and is
+ * carried in args->alignment, whilst extent length adjustment is determined by
+ * extent size hints and is carried by args->prod and args->mod.
+ *
+ * Low level allocation code is free to either ignore or override these values
+ * as required.
+ */
+static void
 xfs_bmap_compute_alignments(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
-	int			stripe_align = 0;
 
 	/* stripe alignment for allocation is determined by mount parameters */
 	if (mp->m_swidth && xfs_has_swalloc(mp))
-		stripe_align = mp->m_swidth;
+		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
-		stripe_align = mp->m_dalign;
+		args->alignment = mp->m_dalign;
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
 					&ap->length))
 			ASSERT(0);
 		ASSERT(ap->length);
-	}
 
-	/* apply extent size hints if obtained earlier */
-	if (align) {
 		args->prod = align;
 		div_u64_rem(ap->offset, args->prod, &args->mod);
 		if (args->mod)
@@ -3436,7 +3448,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3508,7 +3519,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3548,7 +3559,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3562,23 +3572,15 @@ xfs_bmap_btalloc_at_eof(
 	 * allocation.
 	 */
 	if (ap->offset) {
-		xfs_extlen_t	nextminlen = 0;
+		xfs_extlen_t	alignment = args->alignment;
 
 		/*
-		 * Compute the minlen+alignment for the next case.  Set slop so
-		 * that the value of minlen+alignment+slop doesn't go up between
-		 * the calls.
+		 * Compute the alignment slop for the fallback path so we ensure
+		 * we account for the potential alignment space required by the
+		 * fallback paths before we modify the AGF and AGFL here.
 		 */
 		args->alignment = 1;
-		if (blen > stripe_align && blen <= args->maxlen)
-			nextminlen = blen - stripe_align;
-		else
-			nextminlen = args->minlen;
-		if (nextminlen + stripe_align > args->minlen + 1)
-			args->minalignslop = nextminlen + stripe_align -
-					args->minlen - 1;
-		else
-			args->minalignslop = 0;
+		args->alignslop = alignment - args->alignment;
 
 		if (!caller_pag)
 			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
@@ -3596,19 +3598,8 @@ xfs_bmap_btalloc_at_eof(
 		 * Exact allocation failed. Reset to try an aligned allocation
 		 * according to the original allocation specification.
 		 */
-		args->alignment = stripe_align;
-		args->minlen = nextminlen;
-		args->minalignslop = 0;
-	} else {
-		/*
-		 * Adjust minlen to try and preserve alignment if we
-		 * can't guarantee an aligned maxlen extent.
-		 */
-		args->alignment = stripe_align;
-		if (blen > args->alignment &&
-		    blen <= args->maxlen + args->alignment)
-			args->minlen = blen - args->alignment;
-		args->minalignslop = 0;
+		args->alignment = alignment;
+		args->alignslop = 0;
 	}
 
 	if (ag_only) {
@@ -3626,9 +3617,8 @@ xfs_bmap_btalloc_at_eof(
 		return 0;
 
 	/*
-	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * Aligned allocation failed, so all fallback paths from here drop the
+	 * start alignment requirement as we know it will not succeed.
 	 */
 	args->alignment = 1;
 	return 0;
@@ -3636,7 +3626,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3653,6 +3645,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3672,13 +3665,11 @@ xfs_bmap_btalloc_low_space(
 static int
 xfs_bmap_btalloc_filestreams(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
-
 	error = xfs_filestream_select_ag(ap, args, &blen);
 	if (error)
 		return error;
@@ -3697,8 +3688,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3722,8 +3712,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3747,8 +3736,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3775,27 +3763,26 @@ xfs_bmap_btalloc(
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
 		.alignment	= 1,
-		.minalignslop	= 0,
+		.alignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
 	xfs_extlen_t		orig_length;
 	int			error;
-	int			stripe_align;
 
 	ASSERT(ap->length);
 	orig_offset = ap->offset;
 	orig_length = ap->length;
 
-	stripe_align = xfs_bmap_compute_alignments(ap, &args);
+	xfs_bmap_compute_alignments(ap, &args);
 
 	/* Trim the allocation back to the maximum an AG can fit. */
 	args.maxlen = min(ap->length, mp->m_ag_max_usable);
 
 	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
 	    xfs_inode_is_filestream(ap->ip))
-		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_filestreams(ap, &args);
 	else
-		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_best_length(ap, &args);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 14c81f227c5b..9f71a9a3a65e 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -758,12 +758,12 @@ xfs_ialloc_ag_alloc(
 		 *
 		 * For an exact allocation, alignment must be 1,
 		 * however we need to take cluster alignment into account when
-		 * fixing up the freelist. Use the minalignslop field to
-		 * indicate that extra blocks might be required for alignment,
-		 * but not to use them in the actual exact allocation.
+		 * fixing up the freelist. Use the alignslop field to indicate
+		 * that extra blocks might be required for alignment, but not
+		 * to use them in the actual exact allocation.
 		 */
 		args.alignment = 1;
-		args.minalignslop = igeo->cluster_align - 1;
+		args.alignslop = igeo->cluster_align - 1;
 
 		/* Allow space for the inode btree to split. */
 		args.minleft = igeo->inobt_maxlevels;
@@ -783,7 +783,7 @@ xfs_ialloc_ag_alloc(
 		 * on, so reset minalignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
-		args.minalignslop = 0;
+		args.alignslop = 0;
 	}
 
 	if (unlikely(args.fsbno == NULLFSBLOCK)) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ba839ce6a9cf..19035aa854f9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1808,7 +1808,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1827,7 +1827,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1836,7 +1836,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1849,7 +1849,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		  __entry->minleft,
 		  __entry->total,
 		  __entry->alignment,
-		  __entry->minalignslop,
+		  __entry->alignslop,
 		  __entry->len,
 		  __entry->wasdel,
 		  __entry->wasfromfl,
-- 
2.31.1


