Return-Path: <linux-fsdevel+bounces-46470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3FA89D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9137818834A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E12980AE;
	Tue, 15 Apr 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OhhFfnXW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3npITCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFC292915;
	Tue, 15 Apr 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719304; cv=fail; b=tV6eAlMBv0VULH66VSiFE4IG7wPV8veRYl+Yx4FoKpPc4SRr0HgVndSNBsRBkJGeoLxWjG86aq8c0CEqy5c9vKgDDkp0siFSsVzkNMdUmr8MuPI8clg6Zf5s1Dra4V2gnflDml2UNHTe7D4gAEhbWt15QjjdwRGnB9ImHFh0Sg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719304; c=relaxed/simple;
	bh=pra161ou/h8chlA9yXUQcjoXcHRvfZfy4MOaTpjse98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGcsiPgyNCd4NduEzvIu0AwZ39mH4MRQA1ixw17529JS1TVSxW5sA1AIdJpKv9PT6/c2lpGhAUJFxsFQGILnUQA5Rd+4qKwh1LzIhQGKiSZCieeBdH6jZ0BAK6s0tmZLCJbiJxY15NfRYNdlpL4xePsrXaE1/sQMtSnicn1Eqqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OhhFfnXW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3npITCz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6gCgc010289;
	Tue, 15 Apr 2025 12:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=; b=
	OhhFfnXWB2SdfPuNqYz4MEChdp/dfx586GM1ODLYSR7rhFf1K6pbsB/9j7iNoaIN
	/ulRTpB6O/oGKY/1Se4weeW/5yP8tuYdusi/4GEEwEAJJqGjkUMlALlPHDKxZ3Qw
	GKydD+4St4WCx5FkuMpETGQ5YiZta8eYfmH7K7ecFZVmOu8kjVLdfBGwsXGy2v0b
	FxAY0iF237skV9jmRrHiGcCNdXaMsLWOgxZABh/srWWU3kw4Hh7OZeHgvN/NqPp8
	1h0OFjBxRGHOtQa/oaLiLT9LN+e6thpPj8moVtKtb7396DzNglNb15pPX+RjM4pM
	EFzBi2gbXVFiy/5Y76HpAw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619441brd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBFQaa030960;
	Tue, 15 Apr 2025 12:14:49 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbaewv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwk4isMa7kiDhFb3Z0wVOds63M0A/ctGuKfsfiIW+9Z7GzQ0/GMUX5haxiEm+Xycv8zdLXhFkjQHrJ5/+RIJuOwGlhyUi2JvMSpsouf7OKqT5V5dc7/zMuLezJz3rKUycYtoqfHkQQOQLMI4uqz2ewV3dAOcIVffbVjSuYQuWqHWUG9nNL2ur1FQ5w4Awis4+SppX95nuUtYmiIu+IHLgxM+dcddlZfxukDHiIpuiWuS20STbv2FLXdJ2QkGWly6szswZRJh1quPWKFUBlUbkQg0oAZNsix3NQ4k8oRAOLwT/s6qdZkZjDEq5z7yXoR1JIs59sCB5HxR58eoQRpmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=;
 b=x70xAbnBHe7wK0UOQX/teIz5cBsKhxFLGcFrzsybQl00CVNxUhfu/3D2bd9Axc5P1MM3aTWZuqz53nqb9zX/JY5m0WHlkXnh54rmOjgP3YFQJPLrJg2QQZHDGj7xDso6ah4Px4MAQpxVq16/RvC9NcLdkf38p4iBOk+fJ+KlDCRibQlCFL7y7YbBeQertrkUaLoSigyqiQ+Z5o9m0wGZA0u/UmgJZz6WKCn4vnsYZ+1IM6BUoOorHYGB628wsAjVCZbAehlbA0MbzxODbhHJvdbMCzY8y/xTgguADw5zddg23HUjY1cQW61RmKZSgCmnfe1ggE4qHBU2AVZVddyW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=;
 b=v3npITCzfMsj/fFH7OQfN8ivwmiROm2wArajGg1mjfN8ve2H4pcK9KnyIJYAE4SPPoHWCutHuw7bLctgUw6OZjkuVkooineDtgKIkeED7Ml8zZQG/Kdo+2RHcHk0X5/1N9xJkNz8uwRrpdYnf6wkk1rSCS925+0v/Y3CXXUb8NU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 05/14] xfs: allow block allocator to take an alignment hint
Date: Tue, 15 Apr 2025 12:14:16 +0000
Message-Id: <20250415121425.4146847-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fe9d43-6b95-4287-d4ec-08dd7c171ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxEqlfUDjH1QZs04M2d3h/KdSL0tgkAXqz4FJ9haGNoJeVL9X2jwHzJO28Bz?=
 =?us-ascii?Q?9hj51Cu8Pck1D/d7sEKczYW+r9oqH3yGAtga0/adTwY8zdzlXxkAxHRhLH4q?=
 =?us-ascii?Q?Gy3QhdL+PReP42pysOWvie1TqBl7qATTCEUp22iyAiC7rXZh9EkoSNlCSQ5p?=
 =?us-ascii?Q?sJM5v84fWRArPF2LKQI0tuYi/ZzuOnyBIQtU0KvpBWcPlBwngqPXUgqtac2S?=
 =?us-ascii?Q?QFgwwlihCFs/74X9a5P53D9vanv1TV1/ENm0yWB1/TlNpWGMecRUT7PG6t8g?=
 =?us-ascii?Q?XekZ2YJlRoBX3CU/Q2cr0Qz7Jf8Ay5ffxA9h7aHPFjn0Mvx2RYDmwnO8JBJR?=
 =?us-ascii?Q?ycRvsi6+bftrAcJAyQg4r8m+SLYmT0pnV2qkMzxlJdiRys3rhqZ1nwxbgWAg?=
 =?us-ascii?Q?EZzGSmfCi53qV4FZa0tgm/vGlX398JttYZZY9srY3w6cInBSNg5z0E7BxCO7?=
 =?us-ascii?Q?xgXBQ21fGDflhpqjMrFY8udAnPLti3T2gJ9QwLNGIUV4/ryrcmiSQRVWvziU?=
 =?us-ascii?Q?APvC1xWeb1Mmjp4VpIJYEyHn5U6UfkPywBAc1P2Pqwt1nP9shUKHmCSPx70S?=
 =?us-ascii?Q?1q1smt8CYLHXjKXsVQP6UuiqTjW923DnJN2BELcRD5fpHYXsD5gKYyVi726A?=
 =?us-ascii?Q?/JCy0y2ZPPT6aWI0qftg1SOE1KdkhFlB/O+xm/IQE7+dlf51xa5L8/W2ZViD?=
 =?us-ascii?Q?n6BRcj34RvVHiDJ9i9DucdQduyS92CgTS561YEAjZHYVMCstuXWxWoi5fgHX?=
 =?us-ascii?Q?EkL+U1mgGDU5Sb8/cVmyw2cC8x+E8v2k5/q7fAmgHQLNKU9yG/4/Z9NwDXVa?=
 =?us-ascii?Q?EBZ3QRY3E5L7RbkegfgVupjch5Ab8FvIMKik8vFuxqm5JA16Dmg1MylFfqe6?=
 =?us-ascii?Q?vTkoeaZmrGwhgIE6AG0Ej5c0vvpcvacKmDIbApNvf9OT2uFRva1L6BIscjjr?=
 =?us-ascii?Q?Q5hnvfVLBXLOkjmHHMzCMmCTkkeKDewNK5L1OO1lwT+qfi6arCw9wd5sTjNL?=
 =?us-ascii?Q?dxsIC20nQMudwJWOS/PoORx46Go9QNrzNzdsX8cAZEYYboxf02A5LvAsBYFZ?=
 =?us-ascii?Q?+uJl6G1GN8+C+DuHwnSWiMgzky4f7y8LTWN3WKp2pXKRPrjQceEnWve0PtLz?=
 =?us-ascii?Q?7bqMYS4Z3FQJqGhGBENhJ8Cof129jvhAGI4M4qYf6rPVCJMSdSPZ6UozyMw4?=
 =?us-ascii?Q?U4H+czY3Dik/Hye2iYT+kOHdM8DZNXwSbEog1QidHTAH4qvPHrvnwqWY2e94?=
 =?us-ascii?Q?bqUSyIvyZX8Sy7PFVwWQXZOTkKwl0LEhJ8EXb6LgqE/7SOE6xqa1YA9pvYFG?=
 =?us-ascii?Q?kpy6z1nlTwywYEK9VrXGrU2hjWl72AF0bgh4Yhpd9M4W62I3aLmrzHW2FhzA?=
 =?us-ascii?Q?nCGrE6xymXnvPH9k6n9gEDUZAZo5hJHxOtlVSiZFHQ7ty/CqhlQkGcU7kH1C?=
 =?us-ascii?Q?oxJlRRMzdGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8igpuZ679oVpU82IzsHGoEHP2eJjL4e6flCgOPouX54+oebIBUGldWoMuEvM?=
 =?us-ascii?Q?WGbTXk3WK7QO9BgXxAD2LWOGpQ4MK7HeSZ6kR6HJpD7XtdieMfUdmo3GKnWa?=
 =?us-ascii?Q?SnFtk6Nd4lYd92RY49SC9+Pd+QGaa1oZIm7rVp2UZqphdMhEVFAO4KknHMFq?=
 =?us-ascii?Q?bpXo87zCknbo5aN4DCbKjQyeyP6sX9UvB+RlcuajySNcD+0GeNFIdBwt4GeJ?=
 =?us-ascii?Q?5JsMMmZa4unxbuRl4Pgg0QCBBI/+ZshJquBLmLsNukLg8xj124AUCUWSC9GF?=
 =?us-ascii?Q?v0hKHRo4k5T4LvMfqhOOA0tCcOQZNGMPWtwK2N4is9AHMJ5q7caNp5weywsq?=
 =?us-ascii?Q?rV112YNEh941RrR5NcmnxF7Ma3E5qKr1h13+oUEIjXA4pKGoYF8GRrtCLbQd?=
 =?us-ascii?Q?NK/IgVVx3ys0PdK/cWSQpCiYgtSk5GWM3GE0a54xguSKSO/cfg//4Qk2+5Ve?=
 =?us-ascii?Q?+GPFIkVuaIf9aX/YOgrVmm/HfXlpiKN2KwMHjjRG19ORLM4SmKaw6l0v2iwY?=
 =?us-ascii?Q?PDNlz5zgSKrZeOQ03ZIqzbXsecRX0ywv+KFCfvAkYRYJ0C2sZplOZgfOGuKU?=
 =?us-ascii?Q?yVbr41GWiVKmP55NuYpaoGgsv2lBJVHxBadPwyr8+FEBN/uKN4roLjYkj3lC?=
 =?us-ascii?Q?2RN2c8AYyMGw1xXw5VrCvXSHDZ7rqK1SM0efDHODU2etPRHkxpmMkKvN8wP1?=
 =?us-ascii?Q?vPl1x/Hit2aIVlXR0DBczP9HKfr9wwDMTa1kagA1amJ2Dt2SGF72v7SlwbTP?=
 =?us-ascii?Q?nFIjOBWmL7W2ctwlHdOA4B1d+iQDVlood6zySp7BOD0t/nsoaodHm12GvGKV?=
 =?us-ascii?Q?ik6yOQZty5CytrVAO2VHa0Lv+vbVIluturUjnJm+M3vilnYPHYTzPwJi8O7k?=
 =?us-ascii?Q?IO8C2W8Byn3tYRWswIuDjMXPG/EWIC7tq3M3GkW73rOAcBdHl259ulPfVWHb?=
 =?us-ascii?Q?2bPyPNPVnY3PgSh/b0YcnR2BhbGKFLLRWL8Rn0zJTT9Ch+bZkCZtOJgZubNN?=
 =?us-ascii?Q?IOX+t7JQ0Z76RYP6D3KEwVIh7E4SQ29WqMNaDqfKNimBYGYb9pqoyT+elLIq?=
 =?us-ascii?Q?CTCCOZf9tTOHBDmqFXeYtJL36N+5fSZf5mogx/Tl2nJkO81Fj1ckpoIeRplR?=
 =?us-ascii?Q?8io237ToSeljr7oCy6sbNhrGVn1iBA1SnPgiAUfHcRhg6bEndeurxfwIXYK5?=
 =?us-ascii?Q?VPDvEEr5ZLorg2WcTGkMEJhPL4yVsUvkygCL458G67WvxwwJSCJfJ+RHQRX4?=
 =?us-ascii?Q?6kBewxHBqJY7KEftAk01+vhTX3rIdRJk3f58urBYxxXYdAkQ5iuSfSXviwzj?=
 =?us-ascii?Q?g0rRImFiBUpjw19HvbcssOBvPEt13psm8M6u9VJEix42Z2N9T/w3h0YHk0rd?=
 =?us-ascii?Q?9A4WzkCQqLh4fxNpQQjOHmfC/DPXM3nYCUeMPQ26cAzZyKH6O0RSMJB6u33a?=
 =?us-ascii?Q?sOkXHfiG6sec97dhvbCyKKk9uvU8h1Uv/g2tCoqkMIFPOKafSAhq1snPbYPT?=
 =?us-ascii?Q?nhSqzCqVBHM/RyR1rO+pZYizZRsPR3QFMfYWcmzQStHn77vSVuu67HtRzBcx?=
 =?us-ascii?Q?OjscTKTGl5vksgn9H5BySXZYqfd7MTUMbp7LcP2vrWiUIEZq7h7mjar5gJaq?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tP0xuVmyKEBIS7VmzJ978DIiyrVlU1Xga8E4wG9Ghk0KLT7YKOFwrWSGliFSmxy1K/B7Wup9zZmzJOCQCzQ1+SJSzATU/NKpzVnf1SHRTRmneLT9/+0y+jziFjs92T618qZH/onDgrYH1cUdQGcQizsKUBtPv6+GkqyXvmxdXIMpXiLeNqqxxZFuhPPoLI1uwtJryvw2PbxHeeN//D2q9uqynvSRFm7mkcDY9LraHV4sJCNURgSaLEMkY19my8zKK96HiawHa2ngaz43SdsmQuenp6n7wjscm3eY8GPYVJeF87g/oOfzDdJYNv+ZOaH5017nVJpAf4h/Buv/dGVRPdHHlVi7POzuo/MvcncxHobLdcXKbb9xPyi8/UygFZU8M5AUfKnXz8AMRJP/X5PNblxPTZWbgZEbCP8MxBCtRicH19AU5PtrU9XQsRQSeCLKl7aLON0wLzaWwfq1kfBAGnVeMKrB2lVOSrCOcwhGFBJ+f9QzNtBsxdrGHy4hnupt+enfiwkOQhLwq8ujIxxWWWD2DtwMRNSEf3mT4vyoSB2r7unLK847gJED4y986OWO8zC3VDq08vFYaOZj14bR7R3fVniMBDdGlHuNuXhBG60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe9d43-6b95-4287-d4ec-08dd7c171ccd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:46.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa5j3S27bCCr5zKQNgyfBELD+/eUx/2JjSA5yKjo8cfxK7o8vL6eejW3EKQQvRS1Tk3odDswS+spAZJdUz7kbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: 0GewARQvDMleKejCH0qVLZx3FOJHecXq
X-Proofpoint-ORIG-GUID: 0GewARQvDMleKejCH0qVLZx3FOJHecXq

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


