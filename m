Return-Path: <linux-fsdevel+bounces-48203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF8AABE9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B632350149F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFE272E7B;
	Tue,  6 May 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcMUXNHa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HVeN16Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403B21B9F4;
	Tue,  6 May 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522474; cv=fail; b=ggbXtpMCKgemF+JYyFKtLalK7ckp9MjbhTsWxcNcvqJTrBeFb/aq53o3QPplzp6J6ArU2IqyGjgBLSHa9OoheHHFaWYVdevoA8NsXwdtOuPju8BO1IL3gXWJZH3M4gAGTjDan0+XXlQ8htYPLLulPTWLf/QdI5w5OP3DG2uE+qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522474; c=relaxed/simple;
	bh=2Q7noP//YqNcUpTS31GwE9W0dikaVTWBwJK1Z5If7AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ve/uxIufEMNdVEPeCWljEO2o8l7Xb4TvWy2yro5+6AR44KtENL1PGfJsmhKl36rm7be19QXsEQo4oDY+Y+4XxEIGqKq1ZDo0DA6hsfDQHGT9nTp8omDUMAojV4U8qmlw9r7GeDKZmJW7sZVRAa5m5Z4YzHkcTs7K62dlUW6gUaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcMUXNHa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HVeN16Yw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468d56B000717;
	Tue, 6 May 2025 09:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RkSB+lRZbvx5TIbvV4+syyznoMoVSzHrFg59QEqbdds=; b=
	PcMUXNHaVx5xXAvoOm7pyZbA3V10vJMjEQeJqxonmAWVPg4lpAhPqEz6cY5T97gT
	iz5UXigppcMiH9ntOm5Ay1Q2dEQcedbdfa+UujZ2J/d4D3O3z+WJ1l0CVSKruXY3
	cgL2EfZzMsh64y2ucAjOHIGqYgUg9hShiBLhoqZG8Pu6aWOXabHXDVDP0aIwTyxF
	l8x+i3cBcczPGUyVg0HKI2YWZAwArhrID2s53lRvNZrJDENPVp99VihgKVhTX6FF
	nPbBJfF65I9zAD9QRAmwr9B32CW1f5hBDDsUDJh4k43dn5YI8/zt6O+I/Jd5aPYE
	5tAuUC1sZ1JlsYMxACq/BQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff3mg21h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54680ZwS035632;
	Tue, 6 May 2025 09:05:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf06ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ8s9d90wOuCVBMVxRENllwjzgvqDXxOhbJnyTCNwXn+OQtq2TKnS5O5njqBCZLQANbrefZz1qkCgRbNRBkiIn4G12EJbACveaUVY/MTMgpzuY8Heu+Cajm0fUsVH+VJ5p+GHY28TqkXPkridF58FZ0XfcqLgpYJfqRMAs43pfI6Vp4Qmp16BlEfHWrNgOC+NIS4yXd3RZ1ViqesTrw1TnYwdKZYX5jEq07Jwj3ZLvunWvs/sH8d5/DFSHDcHYDvVKGQ0lSY7BMlFQdyYAcOS6Kk1MBUUqyZ8Y3l4kHcggTGEeMMCbdw5pbMDw2UfH+YFhhg5XznmORzdBiyzzmfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkSB+lRZbvx5TIbvV4+syyznoMoVSzHrFg59QEqbdds=;
 b=b1WBMV6KiCeveoex/TgkO2/cy4tLSh2KaBXCES7xuvHMkUFYzIsDu7JzMjUJzzv6V/PmSAKnKhn6lYX8AYwy1cLzCIfHq646bddgXm8rqwvID+44uYbRoXxEi1GFLvIshLaeLFKXDY9maY7R72QpDRgrR1WYn6UGmLY2zLG9uTXAjNQEZQeQEpOTWdhiGXuKgqzJ/7tZlRCxQ2aR59K+Q6ckQnsUaxY73nRab6AwNFGWXCCeAUS4q+BaUIW+kVm7sIQpmtMJUe3qKYnTezD/Mlqd8deifM9mkb11MsxaRzOapxY9a4sctEq/29E8CDNH7HYFhlRglWpeQPVgV590sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkSB+lRZbvx5TIbvV4+syyznoMoVSzHrFg59QEqbdds=;
 b=HVeN16YwLiCV7SVmRPTpIfYyDO22XXDRSWi3BkCJLbCPrNb0Th6J7+THpFSSkymlRqmTQzJPWrEAo7FiG4XuV0PiKXS7+0O6QZFpiMM8eY4bonA8m+IhA7EnYssJzFhqvzjC7B/O4MlxuUQfhBprdgUwuqYbIWt3mRJdgIFjjRo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 15/17] xfs: add xfs_calc_atomic_write_unit_max()
Date: Tue,  6 May 2025 09:04:25 +0000
Message-Id: <20250506090427.2549456-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:a03:100::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: cf24129c-db17-4765-baae-08dd8c7d283a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0gWbe4WEJeQ7C61rhz+b79xA2RhTxuHR7gp7NoNVYmJNl2ioFZkl5aACJgK?=
 =?us-ascii?Q?tRJ492+qNw2wpakDkCMS8crzuUkxhxyWnSpRffVBVpCklyv5teN821cdF8rW?=
 =?us-ascii?Q?YToqbgk5WxH1dC1d+nOElVnqGO4MGuU8gXBLn3Mgt6aQnGXZPT28AFJvNsDf?=
 =?us-ascii?Q?enupjs8i5DGY83QuUEomfThkx0gcWUMf+Adt4OFXFP1LrzhQPfY65avBtmsA?=
 =?us-ascii?Q?09f4JEgu8E9l4eSB7UrstqhakrnngXzowv9QsgH5K0wBKPQAzv9X+g+moChm?=
 =?us-ascii?Q?lIJxmpP6hDOC1sGSoqA0ueWaNvIlVMHxO3pfoiLFbh42QGfBfrAN3KDIXpmh?=
 =?us-ascii?Q?0AAePjUSMr2JDqw7Msc3WW6M3cTAYXi3Hr8SrdGiPs1hKdheS7lORHxEUzR2?=
 =?us-ascii?Q?4IfDLG53n6v3bl9fmQOuFcTGSnid+dyIdrQ4yOOgxat1uxhS6XF9A48PUOVg?=
 =?us-ascii?Q?3Hs5htu5dNYbbBpuGmna2P75wcxT0Z6u0MU7zq0lVvZvEcF5Z2HEQV8EiVmy?=
 =?us-ascii?Q?jvUffeUhjnbJ8orLPNlXyyOI9MAeTUsQcrNU6oKLxYyM+6Sc9txsZdT8485S?=
 =?us-ascii?Q?lGPaoMzvf7ixfAMXPI1wyDYa7Fe6o+/9sW36a3UzZypG6Js8qI7MJJbMoWno?=
 =?us-ascii?Q?Othm4LvAy1L2tb151436Jk4PfEj5N3HQ9ObVY1IihlEPhci0RPm7fklVgnuP?=
 =?us-ascii?Q?lcXB3dsnrcZCaiqDFNYTzRS7k333vr8CVoLlfW/eXBAL/k5pgtfAff3v9XBO?=
 =?us-ascii?Q?zQgq5OlGtRFAl6SCdaCjTECYtPyFftI8evqKSTsa1GBKCFTA+jJGkhlp27SU?=
 =?us-ascii?Q?/ZaaKtmGz8zxwJhuzkbcDBYpRbVQk/QFIHuTwQ6ogzdGKOX1tb8rkzWIEHUA?=
 =?us-ascii?Q?Njuek/kEWnz2UXz+xZi5md3+n/Cmszwud2X9u6DbvAITqdUQqBtrObytDurl?=
 =?us-ascii?Q?y8lfHzMN8KKTmfymJOMUhpXq4c8d44PVT4CrmuuNb7uGn42TGbC0LZZul9rw?=
 =?us-ascii?Q?54ynE1dpZrSFbHeswpPNtulYYK2Sg9DxdEVffTsk6PseEP7SOKU6LFHS6vrj?=
 =?us-ascii?Q?/rnR0RvHBxmjtaIHX3g8a7T+1L+L3NzveqvXkviF1AHbUGbHOsS55/sxC48h?=
 =?us-ascii?Q?s9qXw4Krh8LYJgJt7hBigS9qSICkcSdWtFXb4bXwPdxdg4LzjUuxyWwNpKZf?=
 =?us-ascii?Q?kZ+2hjWh5zFDTWfC5+ghQs5C0x2zIk1iCyXzCDZtZ2LnX7pCt6a+XHbZq2ey?=
 =?us-ascii?Q?/kIMROLrwhzBYMITWZAiYBz51Q1aq7E5jIc4PIWKohX5j3Dv51KOuN+GH0Nu?=
 =?us-ascii?Q?7bmKdnwmSb3lcLOC/J5NL/8v3gKbtwGGV+0YDayq0tWXoM8PyPC0hBWn/Ds9?=
 =?us-ascii?Q?JmwTuNkbajVvbiztjlA1oqbhvkru28J/xOlh3yaY2S54QruSLv3hHElEzeU6?=
 =?us-ascii?Q?jXJQINTxdfA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPzUoz8jvNZNL22MC5RKfJ1I4OpulGiOv4KOXnPjPxtzNysAJL8a0tbqTArf?=
 =?us-ascii?Q?y9g7nhrxKxKDBUFPMMPN5qGw98B+9EXkKIObSMYlit+fhQP7TzlfLEDjMUGf?=
 =?us-ascii?Q?emSEVdSqlZckXPqdS9wSK76rnA0bATDTigM2q8LG+ZrUPwDYX5TI9sz6g/bV?=
 =?us-ascii?Q?XoPHhGTMS0UTTdkeTFFhGO9D2L2qPi36bD5+9l0KwVkuSWPAyBYdvPvjcRhz?=
 =?us-ascii?Q?iKwd9x0mF2HJvYqgQoS2YLmrrM0dOICIohP8ePd2rb6T4VZukEI+X6RTWtke?=
 =?us-ascii?Q?WPnjjhYrZCecLtti52bJVdji7/0QNRY+DKiYpnIxo6OtYz8Yz8JvLdI4CGi2?=
 =?us-ascii?Q?gdQOGRB1S42dIigdbkA0TWEghnP9tvGzyO8GIJgqs5vwUkbnn1079u7ZFTdc?=
 =?us-ascii?Q?ggWQynzi0aQqlHKTXTwadESn8f6813+NYYQMjzJhNJy2TXQC/46XxQO5rSTx?=
 =?us-ascii?Q?nKVpNyq7aqLZMRzfxXma3FdN8Slh2dmufwSQCWGxsQO8kgHOftc16GceXfAs?=
 =?us-ascii?Q?xUZUYD2ZoQXC1iiXNaWhhzpW6ibUXgzvpTWCf8Z8OajWZXRgywZaWnvaaa7E?=
 =?us-ascii?Q?b2aZ8A8BapKQfqSEdMeadLC3b2hsj2BkWol2dhOnHaJLBsYTBLxy+vDYARIf?=
 =?us-ascii?Q?54MBQow5yO4VVvGM8Y4TveIUJYbGBDK4BqSv45/RiVN4F/TUyBHdJAm+470d?=
 =?us-ascii?Q?JxnO5CuHwuxE8bLyBhVHl6RwHvyHWITDfRZu/dakR3A3IUJGD+MqiTB0rZ6H?=
 =?us-ascii?Q?PIYUDkJgKEGqh4htqzyBhakioGQrnN8yizeOypDWl31LGVvNWn5u1xuSGRqa?=
 =?us-ascii?Q?86N2K6pVWwLA5yrep4bC1LrUqju2LGeQzhMA95YcXP9WnQnwqOhXl019NGBp?=
 =?us-ascii?Q?oarieLudUs4vqzqgpI0GEQ7oXCnadyL9cXmYx3alBawRQUwUGt57m4SMQ7yh?=
 =?us-ascii?Q?bfyUMYc4YnRgl6mjuAiNfoCYtQoxZowE9T7N7FSM3ZB6QUbrLnM6x8G3vf8M?=
 =?us-ascii?Q?TuuKk0tdueLXJ60jwwHxF5xwY8gA3/hxEmMdQinKLRtoqXvL86s2Y3C91FI+?=
 =?us-ascii?Q?7WPkF5pSz6b5hU3KxsphaoKRha6pnGHVQOxlcPxmtKMw0EnVz/EIxPZCuGZs?=
 =?us-ascii?Q?CUqynoakURPPI+PRJrTXoK/Lkq+eEXET3d40dqEebwtEq6gAhg944uVB/bqI?=
 =?us-ascii?Q?yfUt8ga3GbGOpZ4SG9nRcnXjYX2T1HZtt3Jg2g4V8ewHK4grkEf+7LwTtHvY?=
 =?us-ascii?Q?tcpYnCyqe7RM/CCamM6jfyuGDv7PiBf0Dfx7CtKFIpJAprGWst3ZcjubI0Wm?=
 =?us-ascii?Q?gsixywmMrslwyqemGxYSd1Ez6UHmtZxbzlb06wsFUNVmxc+322jOysNqS7Ou?=
 =?us-ascii?Q?4gDO0442HlW+AQ6D15B8nNIFvBC+9d/jazT+sRc4AENeWFiMHWiVAEAXJjY7?=
 =?us-ascii?Q?HSBt5DsfYTIVniD2Jh0Oap3U+0WGtrpCcD1KYtXa1zSWmfq0kDw4yLsdVIaE?=
 =?us-ascii?Q?lwvdZatHW8xvnScadY/Sy7oY8H6pu2bkoaxhoq5tzVB8EzfpKwrEvsZHHkA5?=
 =?us-ascii?Q?cgsKaAvU/uYI1gZNkv5zNv6PbRX6c9W1x2dReNfru4LWzaAQWAePHrb7MjFQ?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u9pNI3WjkdqpGo6WDIUV+I3Wu2LlGNBIjwBKwmsKChHb/eh06EKeNFROTC/NI/A4+qFDb1rW6FOGNcIjVoQ9wtt6HPDhDuxletBZF6P/z/BHOvhmppoQNttelQFls/fwdgEmt6J976J7FR6pOHPWhMdE84rz1W78GcmVUSuAWWRQILX3YKqStstNfb4qAhPtMCDzjxaRInd+dERdr8OvwoaADYOJBbxKJOAjxrozdcC+CmgyvqfRH2EuS4n7AUy+0eaDsz3RHrA+LCa0OEyzluqG5snEkiLsfU44pazvpJIt8rkF9QWebbercggAoyReuFVKQIeVwGTNO+aFDufe0yj/OLfpK694lrXIZPKyr3zlLAGC/uzOHI9Ean+4Ji4/vbMVsnutqb5HnWOet0A4hkNnR6JJT+dFw5INbW/oM8unRxHFINelqn27rvT6GeKi+dM3o02ZyOxKT9AMSGRIf453XolzCQhMX7mLd0Sbka9Kx+83htFmFJBtPSWba9zWb3nL6OxLt1xpQfhxsPyobBpywcdQ28PZMUSAcvcFDn0Wla1GSL4AnKfqcT6Ec1Aya/fO2E0AeLSmBW/pPiwzwTbpFRDIrV0ruyiuVONUT8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf24129c-db17-4765-baae-08dd8c7d283a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:33.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxJK+TF2DwWV/amW0hbNr4ZIebGWqW8t+3HX0aYd55F7GmqAaC0yNRls5Rv+MqduDkvMxG3rt+0/6x8Z08M/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Authority-Analysis: v=2.4 cv=e84GSbp/ c=1 sm=1 tr=0 ts=6819d0e5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PHD7Guh85veGlZlmIGYA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: HWxDtnlqWSORoLV4HbUe4-5M8hPcd8ME
X-Proofpoint-GUID: HWxDtnlqWSORoLV4HbUe4-5M8hPcd8ME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX120xb1lyV2gB b1HWnmwOrXr5OZnHdwDuONWrhW+lHsqALa5E3g0e+3CEioVkyF7JF/2WJhpCJ42qRUICv2ELs9M XII9LYeabZbrJQUaSM23NVTaQsTXVwTv/0Y5+otGmpcp1rV+n+Tg46HKKEgok5fzFS9q/j2fyoj
 7AsMgTnmzOEjFQEtuJafAgbLSBvByiCHbK1ZNb86AUD4250ZSJxrA8K3OcxGsZORevhXZvZstwl ZtSnhhE8DUM+7cWKGlMRrd8M8br6Bjq13ZJek2sWAQhGvEEBpcrLyPwVqUz+cPuXB9GyxxaxN04 ntRqiLCwj3ogb3VNW9ARs+qmWDtR4NDjNi4IMGUbWCvrQFWlAVp0BgbJHHQh82de+cPpxyM1gWc
 octureu6hQaACNNDEqyYLVW1jv6RRnDxEv+Zs8V58o13kqmheSVmqfIAQfSdqAU+AewRpiNR

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Amend the max atomic write computation to create a new transaction
reservation type, and compute the maximum size of an atomic write
completion (in fsblocks) based on this new transaction reservation.
Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
reasonable level of parallelism.  In the next patch, we'll add a mount
option so that sysadmins can configure their own limits.

[djwong: use a new reservation type for atomic write ioends, refactor
group limit calculations]

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
[jpg: rounddown power-of-2 always]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 94 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  2 +
 fs/xfs/xfs_mount.c             | 83 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  6 +++
 fs/xfs/xfs_reflink.c           | 16 ++++++
 fs/xfs/xfs_reflink.h           |  2 +
 fs/xfs/xfs_trace.h             | 60 ++++++++++++++++++++++
 7 files changed, 263 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index a841432abf83..e73c09fbd24c 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,6 +22,12 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
+#include "xfs_defer.h"
+#include "xfs_bmap_item.h"
+#include "xfs_extfree_item.h"
+#include "xfs_rmap_item.h"
+#include "xfs_refcount_item.h"
+#include "xfs_trace.h"
 
 #define _ALLOC	true
 #define _FREE	false
@@ -1394,3 +1400,91 @@ xfs_trans_resv_calc(
 	 */
 	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
+
+/*
+ * Return the per-extent and fixed transaction reservation sizes needed to
+ * complete an atomic write.
+ */
+STATIC unsigned int
+xfs_calc_atomic_write_ioend_geometry(
+	struct xfs_mount	*mp,
+	unsigned int		*step_size)
+{
+	const unsigned int	efi = xfs_efi_log_space(1);
+	const unsigned int	efd = xfs_efd_log_space(1);
+	const unsigned int	rui = xfs_rui_log_space(1);
+	const unsigned int	rud = xfs_rud_log_space();
+	const unsigned int	cui = xfs_cui_log_space(1);
+	const unsigned int	cud = xfs_cud_log_space();
+	const unsigned int	bui = xfs_bui_log_space(1);
+	const unsigned int	bud = xfs_bud_log_space();
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent + map extent into
+	 * data fork.
+	 *
+	 * tx0: Creates a BUI and a CUI and that's all it needs.
+	 *
+	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
+	 * enough space to relog the CUI (== CUI + CUD).
+	 *
+	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
+	 * to relog the CUI.
+	 *
+	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
+	 *
+	 * tx4: Roll again, need space for an EFD.
+	 *
+	 * If the extent referenced by the pair of BUI/CUI items is not the one
+	 * being currently processed, then we need to reserve space to relog
+	 * both items.
+	 */
+	const unsigned int	tx0 = bui + cui;
+	const unsigned int	tx1 = bud + rui + cui + cud;
+	const unsigned int	tx2 = rud + cui + cud;
+	const unsigned int	tx3 = cud + efi;
+	const unsigned int	tx4 = efd;
+	const unsigned int	relog = bui + bud + cui + cud;
+
+	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
+						 max3(tx3, tx4, relog));
+
+	/* Overhead to finish one step of each intent item type */
+	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
+	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
+	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
+	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
+
+	/* We only finish one item per transaction in a chain */
+	*step_size = max(f4, max3(f1, f2, f3));
+
+	return per_intent;
+}
+
+/*
+ * Compute the maximum size (in fsblocks) of atomic writes that we can complete
+ * given the existing log reservations.
+ */
+xfs_extlen_t
+xfs_calc_max_atomic_write_fsblocks(
+	struct xfs_mount		*mp)
+{
+	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int			per_intent = 0;
+	unsigned int			step_size = 0;
+	unsigned int			ret = 0;
+
+	if (resv->tr_logres > 0) {
+		per_intent = xfs_calc_atomic_write_ioend_geometry(mp,
+				&step_size);
+
+		if (resv->tr_logres >= step_size)
+			ret = (resv->tr_logres - step_size) / per_intent;
+	}
+
+	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
+			resv->tr_logres, ret);
+
+	return ret;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 670045d417a6..a6d303b83688 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
+xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..86089e27b8e7 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,82 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+/* Maximum atomic write IO size that the kernel allows. */
+static inline xfs_extlen_t xfs_calc_atomic_write_max(struct xfs_mount *mp)
+{
+	return rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+}
+
+static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
+{
+	return 1 << (ffs(nr) - 1);
+}
+
+/*
+ * If the data device advertises atomic write support, limit the size of data
+ * device atomic writes to the greatest power-of-two factor of the AG size so
+ * that every atomic write unit aligns with the start of every AG.  This is
+ * required so that the per-AG allocations for an atomic write will always be
+ * aligned compatibly with the alignment requirements of the storage.
+ *
+ * If the data device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any AG.
+ */
+static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
+{
+	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
+	return rounddown_pow_of_two(mp->m_ag_max_usable);
+}
+
+/*
+ * Reflink on the realtime device requires rtgroups, and atomic writes require
+ * reflink.
+ *
+ * If the realtime device advertises atomic write support, limit the size of
+ * data device atomic writes to the greatest power-of-two factor of the rtgroup
+ * size so that every atomic write unit aligns with the start of every rtgroup.
+ * This is required so that the per-rtgroup allocations for an atomic write
+ * will always be aligned compatibly with the alignment requirements of the
+ * storage.
+ *
+ * If the rt device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any
+ * rtgroup.
+ */
+static inline xfs_extlen_t xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
+{
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	if (rgs->blocks == 0)
+		return 0;
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(rgs->blocks);
+	return rounddown_pow_of_two(rgs->blocks);
+}
+
+/* Compute the maximum atomic write unit size for each section. */
+static inline void
+xfs_calc_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_ioend = xfs_reflink_max_atomic_cow(mp);
+	const xfs_extlen_t	max_agsize = xfs_calc_perag_awu_max(mp);
+	const xfs_extlen_t	max_rgsize = xfs_calc_rtgroup_awu_max(mp);
+
+	ags->awu_max = min3(max_write, max_ioend, max_agsize);
+	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
+
+	trace_xfs_calc_atomic_write_unit_max(mp, max_write, max_ioend,
+			max_agsize, max_rgsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1082,6 +1158,13 @@ xfs_mountfs(
 		xfs_zone_gc_start(mp);
 	}
 
+	/*
+	 * Pre-calculate atomic write unit max.  This involves computations
+	 * derived from transaction reservations, so we must do this after the
+	 * log is fully initialized.
+	 */
+	xfs_calc_atomic_write_unit_max(mp);
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e67bc3e91f98..e2abf31438e0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -119,6 +119,12 @@ struct xfs_groups {
 	 * SMR hard drives.
 	 */
 	xfs_fsblock_t		start_fsb;
+
+	/*
+	 * Maximum length of an atomic write for files stored in this
+	 * collection of allocation groups, in fsblocks.
+	 */
+	xfs_extlen_t		awu_max;
 };
 
 struct xfs_freecounter {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 218dee76768b..ad3bcb76d805 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1040,6 +1040,22 @@ xfs_reflink_end_atomic_cow(
 	return error;
 }
 
+/* Compute the largest atomic write that we can complete through software. */
+xfs_extlen_t
+xfs_reflink_max_atomic_cow(
+	struct xfs_mount	*mp)
+{
+	/* We cannot do any atomic writes without out of place writes. */
+	if (!xfs_can_sw_atomic_write(mp))
+		return 0;
+
+	/*
+	 * Atomic write limits must always be a power-of-2, according to
+	 * generic_atomic_write_valid.
+	 */
+	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 412e9b6f2082..36cda724da89 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 
 bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
 
+xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
+
 #endif /* __XFS_REFLINK_H */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9554578c6da4..d5ae00f8e04c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
 
+TRACE_EVENT(xfs_calc_atomic_write_unit_max,
+	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
+		 unsigned int max_ioend, unsigned int max_agsize,
+		 unsigned int max_rgsize),
+	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, max_write)
+		__field(unsigned int, max_ioend)
+		__field(unsigned int, max_agsize)
+		__field(unsigned int, max_rgsize)
+		__field(unsigned int, data_awu_max)
+		__field(unsigned int, rt_awu_max)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->max_write = max_write;
+		__entry->max_ioend = max_ioend;
+		__entry->max_agsize = max_agsize;
+		__entry->max_rgsize = max_rgsize;
+		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
+		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
+	),
+	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->max_write,
+		  __entry->max_ioend,
+		  __entry->max_agsize,
+		  __entry->max_rgsize,
+		  __entry->data_awu_max,
+		  __entry->rt_awu_max)
+);
+
+TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int logres,
+		 unsigned int blockcount),
+	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, logres)
+		__field(unsigned int, blockcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->logres = logres;
+		__entry->blockcount = blockcount;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->logres,
+		  __entry->blockcount)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


