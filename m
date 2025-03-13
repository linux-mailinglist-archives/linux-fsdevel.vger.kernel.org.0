Return-Path: <linux-fsdevel+bounces-43932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21747A5FD75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2434420420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93F26B2C5;
	Thu, 13 Mar 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZMtM4nyy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="btZnxuqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2D26AA9D;
	Thu, 13 Mar 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886099; cv=fail; b=WgWfN7tqvBHu/qFRdBLPUGqaNbOhFjzSuXVKz40ONUnOuDo7rRqM0KnmQSTnfgWogyojPPuWdBgZqbtjraCcqX7aInFgdpEE2DdjGuJAmq9wI+EgU5A4rYxHjHc0r0tTRTTXTkuGauT2rHxu49H9SqodkA04S02nAOQ534joZ2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886099; c=relaxed/simple;
	bh=QrKKQ2Yc3pQMzgRBG8qNH+imEEdmzEyaL74a/ucWukE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZPgqz0LdBa8l/twHoO9ezAV4AEKhYYWKp+iCRGJ9muugD72KxdxSe3LfD3MchzJ6Mxmpa0CK9zIcUEFj4ghLEeYlM6UBDqfNivUrVV2qYUnhG5lYPnRtLKmBVAGeUjj7qoN8ZaUtHCmOhczugY9WdVt4cJH7zD67fuLcD034Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZMtM4nyy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=btZnxuqp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtma5013872;
	Thu, 13 Mar 2025 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2hv9IYas+016jV6ruhCb5R6iRiy/VSF9uRRl4i4s8Qg=; b=
	ZMtM4nyyMIXOHyj4G7yliHIFHhsTuH6ZLNcz1SSF5GJnin0Np9p9ZNPospsQQjxu
	IRyCuoPkRbuI3jPu63m8407gxIHCVacDsHX+3kFO+6bkHp66rLJLHDhuNSgiP1PR
	xsp0K6OCFzXDtSwje6HptsYket4CHybAf3WsiQbKEm9xBPN5auoJps4WGixZgaTe
	6N00KsVtp2g1m27CI2z/Z4DhhLKUTIU7ncfyagcGQgNogPtXAPYRTz7HLDCBbqVW
	UCR5/wHHAoKpejn3BzH5Lojdg/IKtrk5a3XbxY0lc3kIbPrrXnq0FoestbfFZNU1
	At4RMEPWRbHMUzi9wmBiow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vmrcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGeUsO019470;
	Thu, 13 Mar 2025 17:13:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mrx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVFAzAY6SXj4RK4EgmIrTQMpbtwhUTgF595NHNOLn9NmQadPucbHJVqHXUMlnDAT6Priaiy3ynojICzCwUUZDmoaQW0swZDUBmTAyUf24CmBOLuKeIbYKWwpGEKmEmPmzqjsfRmBxpo1impz241IVWTQ5aaS5foObbFpSp1HZg4QkBtMdavTsoN32VBK/rWxgEsOLP2K95bPp9w4KLJ9GEA85Wyw+CLeG/P1LH5kpnnW7zlMZo1iO0F3howwY7FzRdyoFE1nZQ4PgQkWU5Pe/sn0x5Rdc1qZ7401BfMog1ZJ0Ig593PvLPd82XVsr8hZgMF1CrqHxPIhy/g5CEC4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hv9IYas+016jV6ruhCb5R6iRiy/VSF9uRRl4i4s8Qg=;
 b=vNPEwaOdmeaznRksY8C6caIkrdozglmZGDge7SPRhNJ9eh5HyCP+UT9Dd55Tm4iXYehFLShj90Cc8fTeZNS8qWG1AtZVyw0FOOgxCq97TOHnXOCNQvOqTJyKX8SBX/RiQFAi1UyFRJPsXvxYSHrZqTLDst02MIVgYr7/IGu8jkiZunsmOZKij4x4KxaBKMqBN4ox7JedAGpLVTURabHhXOzpYDqUDGoLuf5Rd2IcdMc89f22isV5eP2CYhhbCvN6G1UO3groh9cr/++KzR3sYRIphCYHGtNGE0w0Y35iVTgGmbr1rqQ3Sazb2LXBafs9eVsJ8EHdp7UQ2JQvMhSh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hv9IYas+016jV6ruhCb5R6iRiy/VSF9uRRl4i4s8Qg=;
 b=btZnxuqp9qBGvnmA9f5CHnrb8z3KmrfyFJM+CrPJ8iN2+r99kDbKHG4MDA/KDZGy9PPrI1gUVnd7XnJxXtgHC24YfswLj9Y/DG8t903GZouxU4oxg0L4vfB3KAeV8r1bZaVO9xhXM2ntp8Gf6n2j252vIALrBQAM19QS7w/yEjw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
Date: Thu, 13 Mar 2025 17:13:08 +0000
Message-Id: <20250313171310.1886394-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:e7::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 48166f3e-1f0d-47c6-0238-08dd625266c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qgn3is2d0QVukrjYfFMsNV3giuNS4RLJ6QqfUKFyPwoTp5I09e1VofhPx7f/?=
 =?us-ascii?Q?W7fHCNbd8WGpjCL4CWsw50jsIDPiNsdMZiI2RhNukir756DGtGVq4pLaRKJU?=
 =?us-ascii?Q?NgfxosY3/SnnpsTEBt2A9CfdEi99wI7mnVxV3ZXvur2cFsUOqSe1HS+uS1S5?=
 =?us-ascii?Q?TN9Z5j+8wglz0c1iXYsSnASr+7tAi1dh/6pgb7MkzeyB9mWoQuO/BgxRSdr+?=
 =?us-ascii?Q?KUzBpqPmzI/LBzm6l7atvuVRTQx1PvkhKQNWZDkr7W1i9r82Ic2W2fzXN31l?=
 =?us-ascii?Q?Sr2xiwPajuHryppjvHLFMQ4t/u7D3Uvbe4Cn0jNH53u7oe4qj/c4HZoXMjNp?=
 =?us-ascii?Q?rgK6mQn5iGqhw8xuBj8y2iJxBAkhknH9q1Z5tbI7x9dyv6/ymv2BIPj/p9Xp?=
 =?us-ascii?Q?GPwS1cyQskFYh/YZFNVlv89KXPLjz5LJ+Z0EyBgCmpc6hwOPkzpXmLunXyTP?=
 =?us-ascii?Q?u2mu4wJ/RaKcQZ7pTdBhdqScpiNN/tVyTAN0lKnxAmv/2Sg+1kNzaJf11R/H?=
 =?us-ascii?Q?DQylRcSx5cKPtD/Mbb5CgsP80qlFbUqFbYIooy7w5ffaTZfs2NOkZEhuV9fP?=
 =?us-ascii?Q?ThiSV1ovjbEWiRhaDCYd2CBEydgnevRUM3QLuyLMPLfvt+G5mKlw5pDhQlDk?=
 =?us-ascii?Q?Cfw421YW10UxmY4aNSBT+Ui+QSq6R7UbHv8YDuXuMfgpQ4S9Ek21AWNiOXUC?=
 =?us-ascii?Q?GweGpoDQQND04JdbhnSn6dXUs50eK+40ZCB5egCJEvay6zAkhCONiF//Ujkt?=
 =?us-ascii?Q?0tWCFJlB+AEkI9U5puEZuE/IYyhkiZczQPixRfAAt39w+1kmiMoTI34G+yOo?=
 =?us-ascii?Q?9lxR8iT10LQ3Jlt6Ldf6J+q6iIv3kxrdC+KC52nj7hiHtSJoXdu9zFnNmZVJ?=
 =?us-ascii?Q?7uXf1tB6peUMcMbIx5xJHNE3IMu/3v2uVVMPVb5YSyncSRNGJ3+RKxn4gaIz?=
 =?us-ascii?Q?pct/CSRXcTbA+Ti1IFzaS2VYvAOG9kI0u0umnL5aKRtMJ5jt+V3RVFP2JWRN?=
 =?us-ascii?Q?L1FJBVdPKSInzkIPwrcC72UdCCL0e+udbLJPM9KRkReAhCNRve/dtqeMpRK2?=
 =?us-ascii?Q?2NNS2ZlAfSnQnSTJHiFhWlBOwNQl+By8yGAIIeujiPT5v8Y+y2M5YrcgH1Kf?=
 =?us-ascii?Q?lgNEE0l9BnYHBdN5xxOqUkNxo6+IIK6L0ko6LKNy6gaIcWfu10k8dj5LCoKJ?=
 =?us-ascii?Q?54PMxKVspbiZymdyy5l5QX0kW/9oTLcMUQT5gF2rj1zZEDMBxhU4s5aGmezP?=
 =?us-ascii?Q?yiwJV7wOdIlsVyXl1C+fQOdk85rWUOLIqjUPBqWBZlWjq6XyDe6m3+m9AfTK?=
 =?us-ascii?Q?TYjhrD4r7kyi0PBLtptPGGzlCx8RAQkVqApQBDUyTeutn6Mi6Ztn3qbDcgWk?=
 =?us-ascii?Q?72XjtZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqxvSf2006s1npGgAiCNz5X7EMJb+A3eA+ke3KNckv4Dvpfw67CVhEjKMd0f?=
 =?us-ascii?Q?Lq4jaSksieMjZzeraz5xeFFRTTUXEk+iyVJjgI/t4icwu8B+V7vfq6nY4DON?=
 =?us-ascii?Q?Kzp4UXj0pftMP5VDyeCFsiyw3z3MLade8shhUd6NAK4y7jOGHlOvZ/oApMg2?=
 =?us-ascii?Q?9aBjOP+Do25MXC6KqX1UaR5V3xZrc4eewHJDxljD3u2CfT9vF+stgDK1akT5?=
 =?us-ascii?Q?hKIbxso1cISKKV+g9BSmGzv4UNVc+wYv5WJBBStjgjF3JBkcV54s+Eu1mZ/V?=
 =?us-ascii?Q?9Kxj+0jEkZUCulX3sXYGPrVLT6Awhh0H8kN3QUX4lIHKu4Q12/1vlWEs1cQN?=
 =?us-ascii?Q?3rTrVPYC4GI4v5Xsa+Z0QPWCrPFCN8t8EOcEiIIzs3YQV0o+Xd3xoPdAvpDF?=
 =?us-ascii?Q?K88zjK3i9Bhp2OHN/vJm24ThxplVj6kytb9tQB1YEMoFr4leLEljXBaKTleJ?=
 =?us-ascii?Q?fE8CRl9lsHmQM/RSStf3h7Wax9VV4xsW+n82FwT2o9h0HH9pnho12ef3bWow?=
 =?us-ascii?Q?rnN3FAWL1N60mITmkK27BNkEQF3PqMZZ/XDcH3ec/Hw//WevHQ101x5tgybr?=
 =?us-ascii?Q?y5S1u/YbCQHeOlgWXJjigy+EvQ/br3ured5w6bpdxBl6Wt/IZTjaoy2mBhyT?=
 =?us-ascii?Q?WvuR7VBB6aslFiovZz2BNZQdhuWUPo6kl5JvNSXmJJm44OvqKPwiQbx5dUX+?=
 =?us-ascii?Q?mPF9RUgLe1JpApPTNWDDa0kMhDxJy7rXw37m8raXWmQDZ4CeCfAB9zYHmAZm?=
 =?us-ascii?Q?692BlMY4xMJMHkyQBppKiWj/dtVEOqXj5Cndfj3NS3hzeQ9hmwZ1olP2mhxI?=
 =?us-ascii?Q?EJFRVCDfQepa9DwpKUjv9IbcVSm2vT4i1bJ8d/DDYFMwEtpJ+RZseJnpDc7R?=
 =?us-ascii?Q?16Ovkf49O0m773fDDH3Z4PGyq3yx9Iaj9ecJ0XocT88etKBhFd1otlIurR9V?=
 =?us-ascii?Q?Qe+vNwP/VwPlPbUYC36ZoIKBsfGcSPTnyDhBJx17S2f+P1/VeqJJijiGDJp+?=
 =?us-ascii?Q?ZfF1cKut8vXutnd9xPL57LV4PPF6PIWwHdDVjwliA4LJu350AGVkCZIFN77C?=
 =?us-ascii?Q?uuM7x/64ZCS7PsV9LeV2vPCcMSDzsYHW05gqoZ+MJo2oTi1kbmYwEFbvhjNd?=
 =?us-ascii?Q?lS5aqy+bZEZ7hIg/qRb8u+8sm1CFm8GhoetmrGGhKrwz/lKsXIT8HOjfCyYd?=
 =?us-ascii?Q?0BYuY3ZYXlT2QH6qw+MWwucIiubHYG5ZVie3vLzg831jQM+MQmmz+a7wIHlx?=
 =?us-ascii?Q?pi52q5HzUzZx4HCRQ9/MBvMBNJwS+acOs+ExL+ip3LySr5L83SM79zRGvntC?=
 =?us-ascii?Q?UeR275sMomFKiNNFLhrhUXNSS9ummh9u400l0LtQr8V4iwTBb/Xmt5u/zQts?=
 =?us-ascii?Q?n819grj7LBX8AyM0/DRhc8Tys2Ma3qujUrID4Zcy+aQ7YhRB5ertEr9Mm6N9?=
 =?us-ascii?Q?aei3fcr6qkElPMtGviYt/HiDcTL8Msh6F/PNhmDQxvtgIKuFgYlw6kUUm5/x?=
 =?us-ascii?Q?V2RrFATSednasC8avudP2+VUbISpFnd17fQAqzYPjCndQc5X1QHLV11n+4jT?=
 =?us-ascii?Q?hbGQjDIrFq69RajZiskmNXXbByYeYGxhZJcYdPfaiQTLxOAo3GxSGNR4cFeQ?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hUWgJEdxpyevizmrkMS2VrVdN2crC9YeOo78wc15OFXdA5lLqls73o9yN5c0CtvVKQKzO7WrSVWEdfRnn89dOE4YY1M132czAyOGeglMIq6lQgcvannRqwBIj+Cu3DA0i5F9SG/1+zuHYgr3XeKBH8O/4cmDximl9ThmbtEro/Qd/kmDS333CLqfjGTzUbdw0gEgL52gzzSZTNAhOmqCEeurYDhP3yZ7G0xDMZfl+Y7fIEXriAXPt6ZHiul9MunSp6VOdNoVlQTR5ypu6VDIVv+3jRKeMqQKWLCASULCR1GLGT+zEiH1AaxN7iVAI6QpPfAiIllFyYy3R9NaXNnFrsZIXONi04zV9AFZhgJAq5Jvd8dIiQo9gbn9d3hiWaumH2KHhebi0X3CYK4K83tLxTclHdXcrAge741pWXG2xMpTfFpdql1WHEUrUrRxEMqAZx62G9b7Tk1vxt/rVsLGy6xClhy0zxUG36VmvSixKVF3ntJPW8nDmVoIEFU+F3Rk3cMHd7CpjRCd5QKhsRv5nwI1KFsyr8DcdJp3V1oRxKozKVjhLRNHe9gqxfmmfGIxI8KLkOyIQw5ikNyPfPlgjnLfsJ+2Ynv+FTC1/Q/iZpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48166f3e-1f0d-47c6-0238-08dd625266c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:40.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJezY5I2rrE7H5X41nxUL8c8VYLaY5ymdGXv2HrB7oyJkA/aVRglJICXwSlymzNIEII8/46APcYeIqecGmUKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: 59RLHMk4gXjhVWCADECOcx2WgZQ7X8kx
X-Proofpoint-ORIG-GUID: 59RLHMk4gXjhVWCADECOcx2WgZQ7X8kx

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

For CoW-based mode, ensure that we have no outstanding IOs which we
may trample on.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7a56ddb86fd2..029684b54dda 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -725,6 +725,75 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ * REQ_ATOMIC-based is the preferred method, and is attempted first. If this
+ * method fails due to REQ_ATOMIC-related constraints, then we retry with the
+ * COW-based method. The REQ_ATOMIC-based method typically will fail if the
+ * write spans multiple extents or the disk blocks are misaligned.
+ *
+ * Similar to xfs_file_dio_write_unaligned(), the retry mechanism is based on
+ * the ->iomap_begin method returning -EAGAIN, which would be when the
+ * REQ_ATOMIC-based write is not possible. In the case of IOCB_NOWAIT being set,
+ * then we will not retry with the COW-based method, and instead pass that
+ * error code back to the caller immediately.
+ *
+ * REQ_ATOMIC-based atomic writes behave such that a racing read which overlaps
+ * with range being atomically written will see all or none of the old data.
+ * Emulate this behaviour for COW-based atomic writes by using
+ * IOMAP_DIO_FORCE_WAIT and inode_dio_wait() to ensure active reads. This also
+ * locks out racing writes, which could trample on the COW fork extent.
+ */
+
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
+	const struct iomap_ops	*dops = &xfs_direct_write_iomap_ops;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
+	    dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dio_flags = IOMAP_DIO_FORCE_WAIT;
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		iolock = XFS_IOLOCK_EXCL;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -840,6 +909,10 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
+
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


