Return-Path: <linux-fsdevel+bounces-46471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329FA89D7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1027A3BC98D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAD29AAF8;
	Tue, 15 Apr 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dp7CJ+Cv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7LYxO/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AD27B4F5;
	Tue, 15 Apr 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719305; cv=fail; b=QzfRtXVEWVONxmlIxzcwmFHMqlLxuXDO2fh0L2Gru513ABsaAbCnol4yWNiBZWNt4BNZtbDz3BJKc5NFNqdaXU96E7eYNlabh0BujMk4xAKihaUnuMjOAwEY8Yabtir7AOxoMKBTmkYuxXNp/aK298qSwXLhM3cdPpt8CwgtvJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719305; c=relaxed/simple;
	bh=8AkaQr8WYXfEC2U/gfJs1iCWyLKb9tVvnjdo5dvbCYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cK/6YI1WyiINl+KKt6W5hAKZD+EfeA1Ig/2AYXJBmgTUQ8vwMBnmAhJDAU3GuSUbtOzfx8p2ZImQMc4KE/QlmmmGQxbFMZuRCiiW+TamSd9eELufdg1TbgioaditjyILUByRYbXGp52g+pFoCj24SPrs6GcNp6oYaS9TfUfVzQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dp7CJ+Cv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N7LYxO/x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fwFC009864;
	Tue, 15 Apr 2025 12:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=; b=
	dp7CJ+CvbsM5eywjTp562LQI1ErIpCj27cvlDr1Amg2tQRw7RhqcS7imQTq9PqBJ
	s9DYcjrXINR7D3WoSYyMKwk8UBqy7lUdGwWPy2uOGzmP/N0OOJgZxyxi9akXBr4x
	ZqI4wBDVJ+T135UHntHCaM7v+OLoaCdCm0oPQ279wTXV8ACRwStMwPFwXiUNThrS
	r7/0U/mTSCef+U2LnzbFA13c4hzjZnJsppRWjY0sILViqbNGIi6a7TTq9SiXRWfd
	+HrUDBk05DgLlr/VCHo+Wv5Zhp6rkp0P6OA5x99VQ8drE3V9BI8agpWKkydZ1iEq
	iTFIwOp3ABKTOpCwEB81lQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619441bre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBFQab030960;
	Tue, 15 Apr 2025 12:14:49 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbaewv9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVmM2g97SWiCxAq7KgkjKodvwOKWuS6D9O5EnPuxKAaqIKPpk+srFBvHE1vrffP1ZAyF137Mx1aAa0cJG4+8dFy6pGcVV9AuRR7NcwyMaTNXa+u7d+Mg7UXH0JTv7ggwXl69QWhqcuXixHWNCibJxH2BwrnminqASV67oQO3fBccq9tUpDne6MBYNHCrDn5EpmDwy6GV4ZDoSIBlrcbzwcqlOdcJvSajgJuV7I/+lNsd0ugs9jvWauiF3W9hIS9XlHJt4wAtbGH3yTTF2ZMx+o6OBS5++AobDVNAo6qI6Cd5jeOm4Y3IVfY1U9whbCzft77HVVYX6CnOWMZ2KURatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=;
 b=SSxtkW+kKTLHk2akKMqDzD3xfgVVO+8nKaMYXf7OUaT3EmeMXfKkG4SNFsLhwMRwRdgiro5rPWMQHEF+aNZd1efEGJ0p8L7lutRaKrj2pgyi7C1iV4KvuLuNwlf3VYNEh7LpKzBdHKQExmkDfRl0XB5Pn11gcgI/FJA12pNVJTkrgou2gph7gnWOKToN2h8vEm6h/P5VlDMMjq96A/cC88MPWJhKB9XKoIpMg/TLiGihbj2Uqa9vab/9A/nrwcVWSK/w4jYNWOQJiLr21zFUsC6PhpA/r8C8lb7wbXFauPaOoVmuONyFI/7bPE9wHEmtVV2XTMm0lj1D44lBHzaTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=;
 b=N7LYxO/xTDNHp5a47V7cDVq6uTjkepFtmVfGH3TpdH2VGEjd5q+7rxdnqHLvh7ZXqolRG6oyGHPPCUKJ+fLLV6NtvVhLL4CE69Lp0rkLHk1YOLl3Imqjk94DPUmLURMHEWtMsRn9n4a+QL6+bQY0U41ii4a0ZjYzNvYPd6uV2j8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 06/14] xfs: refactor xfs_reflink_end_cow_extent()
Date: Tue, 15 Apr 2025 12:14:17 +0000
Message-Id: <20250415121425.4146847-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0854.namprd03.prod.outlook.com
 (2603:10b6:408:13d::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c746d5-04c5-4a77-a501-08dd7c171d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpggx6htTuRfsG27xgDpbKsIC2Ez6uBZuleLyIlLD4/bvlSHJZg2SRGy2ddU?=
 =?us-ascii?Q?GkpmvEa6xrLnR8sEvc/VKr09WP/30lcid6XrQZCNVJwbiLm6G8NFe3CmH7gS?=
 =?us-ascii?Q?U/kBJLdsp8WuwS+pm8Jqr6OIjtTIbLz02M9Nh/BXdf0Jw9v+hGb35cE7QhMQ?=
 =?us-ascii?Q?KSczci8UILy0YIoCVLUCujDvpOFFS9Dhx1TiRM7SquYxQT2RN3IFllJkwE0k?=
 =?us-ascii?Q?6j89Do2yPQsdKk8P5k63o4fjhYJPfEyakfhYg7B85N6GKDiOFbcVzkfn5Kk3?=
 =?us-ascii?Q?fhCOkSyjQHTwKVi2/oftPpUhaTV+6Y+zA5eybFj+PWFrP+X+tbQLu4JR7peo?=
 =?us-ascii?Q?E713SnNfabP0ZgYWnh7UbVk8LzL6ympZ1XtwmS62zJG3DbUV2hu2w1jRNk3S?=
 =?us-ascii?Q?bWYE4ZJsIBSGCoCzfOgttQgkMigDq3drLWfAdXGIlGwfTdvmHSWUX6t/bYnH?=
 =?us-ascii?Q?wKAyHdaIMydyApHx0X5vDdV8K81fI+EOYn6rhru1jMJ9tye/AuTvg7LLnheu?=
 =?us-ascii?Q?mybyGph6i7zfxV30m59XQAxXX69aj+T7/KJICqygdjsFtDz7Q3xOncy6YsBx?=
 =?us-ascii?Q?mJU9M3X7n24k5/Xk17Uvqi1uvd37tBjrYH2nHla3ClpFrICfNej2spmoNXK5?=
 =?us-ascii?Q?mmTGBsDIaj9JPzh4hnoW2ja18ppDqcmPkGbFO9ntudDr8cVEmWSv0XXRhPCp?=
 =?us-ascii?Q?r4oifhEe1W7tUlsdwv669y+5MP6YdDmf4lBqJKow1tD/vDcqwQAsCPl+4hA3?=
 =?us-ascii?Q?taGiBUVHL+KY4ddwuNoFwYCavehA/Ewq25tBfNKtpCycdNRnKbcNk8D7IrDA?=
 =?us-ascii?Q?H64GF7GN9I5PIwlBzukn/GWeIbcY8YtYdkLsWLy/uO7m8Rmb0usqQwWNhORm?=
 =?us-ascii?Q?4Msec/TpIFKO70Ib1n8MPg3eXFYCP5t6HDwPRXcM+2k85XGGOlny/Qxu95lQ?=
 =?us-ascii?Q?GLmSV6XejzWBgF8KgJtCarTXGUaInebtst87BaxrIrURlrNrmuXXoELaaPxo?=
 =?us-ascii?Q?RB2BNTZgJ5GBwrDoo6BkJ1OmtsL0WzdFnBLK/uzz3S0KXUnGSlIdF8SAyHSl?=
 =?us-ascii?Q?OZikIurOwGnQ719+s7xkvz01gIh9rwbGuD7x3+xUobG2eZsSIm9gMhUKKHjF?=
 =?us-ascii?Q?Y6HSJGpbPltGnkLYBxVQTKHZNCywsh1FYeOqpd2Pen234UQBebecFiF2xG/m?=
 =?us-ascii?Q?p03lWol/FaWf1IvWvWz+Up9Xp0Et7f8UCKvexlXckym4Ub+96247Qh9QYFRi?=
 =?us-ascii?Q?LTAXJVxTZFGtbHkskktkSwoBddH8pRmfPv2QZClCty/0MooQ530ziuFweUHu?=
 =?us-ascii?Q?rU02tQO1hcCpIKXNapVJDL067GA8pNHfcjgxkUwl+pA59PGG+wo6P05pjT9d?=
 =?us-ascii?Q?HspAhIP+GqozTQUw2iI1pIEnM7e3cq9ps+8DNqW6+2NeozNWdbF6tj0WcXfd?=
 =?us-ascii?Q?w/dn2Cpi7Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQyLKp2c0QlZciCfYPAcWyzOYmr5qis7d+wWgTvAUnV3AL4nuo6+V8Qoj1BZ?=
 =?us-ascii?Q?W43845H/Me0+XyA1d8WWY5dkACHMuQ2GogFvgYHeTuwR8Lj2u1w/cbmQ7TWW?=
 =?us-ascii?Q?A8vO5jk2gb6gppVgG+xwj7xwrBSIm/BLJfprQ30/E6hWcj1lXBqdF6J23VNW?=
 =?us-ascii?Q?FMz6CxHaA7scavb9Hf9GH3NWlzs9O8m86OsGg2bzZh3mExVXTCaBA9FVxoib?=
 =?us-ascii?Q?Ma0Jq/bblV8fjdnhlkyUjJYdnTubW4pOOfgonteQb1tBD4S8TU8S8Mtflngg?=
 =?us-ascii?Q?9dpBj6UEVTmYCBVBo8FKzWyrGSQiN91RigW7xtm7ZMYpQm0F1JRVywnMliqC?=
 =?us-ascii?Q?/HfK7y286nC6h1Aj13y33mXPnA3QMTF4RpZbEXbEBdHNJDfaj4tqgCZOYGE3?=
 =?us-ascii?Q?zfPgCvCJ+3Hn/EPzzncQFDsItgPDwg4D0xF9rq5pxDAppQmbTHm8U6iAFvuv?=
 =?us-ascii?Q?xqwdIN96rfjCIlHRTwyCqUlM5fBJ/M4xfFgXR+Fi2iEvoU/Xi62Oo0G9SUO/?=
 =?us-ascii?Q?kZL9PMwkto8e/6ColzDuG2KeygVWFJ+8dBVBAPBI+no6w+1JqyRp4M5Kl9cx?=
 =?us-ascii?Q?RlRtb963zHmhlCJv3/vxe4Plh+WZHcfrQ1qDypNxR+yTjpN1+GkoItLlyqoa?=
 =?us-ascii?Q?/GRm6EKr5SNhUqnl9bfT5euC5iCLg381x8lN27A6cdomSbCGqNgqR/cFr5Ic?=
 =?us-ascii?Q?A7haNoJTY/KIZqvcv/tXOIiB/2AGoFcda9tX6rpsCH+QYA2FrbRXGc9KZlfo?=
 =?us-ascii?Q?l2EK0+nwBxnkd/NTtKHlcIIzFmjsEwaqqR7WI+5w1kBGhzdiVuOj8fh/a7Ew?=
 =?us-ascii?Q?vfAGk7bef8h2VO+yBV4lClic3vHzBTMckJYkXMy9KbalxiQY3+nKF3LCFVAx?=
 =?us-ascii?Q?OUwqNFTXPAm47of2uWAPW5zu/+ZwsGOToBj6WWlQqJ7SncQoGpRnp3ofjKli?=
 =?us-ascii?Q?TIg1RE2nEzQMXsy9ARu7Ec0XfKmHN2XAofv59P6Po5yDL77Y53eRtx8loFnQ?=
 =?us-ascii?Q?Xyh02KSt77SlQuSJ2iou4f7Ybyg+46kqIbAsKWxV/PvlZ1XM8q+G+ZKiMaiI?=
 =?us-ascii?Q?ELhhVB7/+O6W5kX6AjNkr0V5Wc4iKr2mFyg09ZAZ25HLpV0VCaabr59UrTBK?=
 =?us-ascii?Q?k0nrP9VyJpD6/r3YHY9nM4NDZ7rcD65HBheFEjUTQLTlrQXQuvHlHHjae7a1?=
 =?us-ascii?Q?q77YErUBbaJkbo6DJQIfqn/nK1o31H1v34QRo1HTIiVgSySl71SKaDZjszNa?=
 =?us-ascii?Q?3pl/Y8kW33fUGKyUszBLhWGYA5t/nehIEE2DS6KNi8+2QT24VSQvvgk6VH8A?=
 =?us-ascii?Q?0zZIVdKLuwDuFtz6oAJbnHnoua+g42CfmyJkFn8qoSYitxiqhny4a3ZtHS+A?=
 =?us-ascii?Q?t7z/kRdEjGQgU39efnc7hr2mruDREuuec4O+S1BZjCMbqPoXBeTkrKsnQCtE?=
 =?us-ascii?Q?5+HNbE4SveF0Kv3OnDOc5KZkkgUDfOQK+sTcLu6SHOReA5qknPB7O1jl+T/r?=
 =?us-ascii?Q?y7aDNhtoF9nVOqRqzeySoMhcprNFGYChevulMlkB077c1IpuBf4NCGCcsrSw?=
 =?us-ascii?Q?P1bMQK76A/kn1fduA76WHYG0Y6gosfhUqpKs/Jy8OLmMr6m1i0OTkNYmjW1e?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i3paqKJ8l3cBn9ElPHSbCXJs/mIKa+u/Ig00Zg+tPgqSPf1grS0766jQAQ2pFymfb7GbLBYYzz3YufN2uuVdnaqjyQON67p1MvNYZhYiOR2v/QGEBF6veMuTN47HAYLTsi5NlZV71YsP5lKhe4Y1b5NYNLOJiddvQbSM4LGNceET/u/bLmsa4ImKBVBnRr3f8RL+4V30X3aR5IM9uxUh2mqV9mQLKE3grqDj6zp1g53i1oDP5vhR2517l08NvB2s9f8e70obq25ZE13bq+n+p0t0+IoqpgvuFTJvqvbpzCRsEV/SQIT/F4BflIM9PIHarh0kouUbyVW+D+NR6x84iT2WK4zuGzt9V8YTucfMhNby/f9/rH39Oprk7LGOWgQrf4AFJ42cF86x1PrQt+pe69V6MHDyx05PQN6gIg6jTnoIvqO1tCqYDoCBAy9fuBMBSLeGGNpRGWutZsUNu+X7tmQzPuNmuI+VhGVNmvafEJf7oTT4yZNo9TaVsFVxWsZ2r8RZqTufXWbcaP9MqllJ+hvHllru1KHpi3IrkRZZwLQqonlldiCMvv5VZN8f6oqCgwJjQk1CTqHsbv75inb8Zf9xfdVMRNy4wHkBE2xzR+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c746d5-04c5-4a77-a501-08dd7c171d8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:48.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tbg7WWFzd9oq+eygNiEmVc8YLF3QwCPxu1rAvdPYTtG3UdtF6oyQ+X0lsI4Qawrjr/6omZLHozLjCVHzBotAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: dL43aWgR2Gy8aic6ERu7At9_UXWF_z-A
X-Proofpoint-ORIG-GUID: dL43aWgR2Gy8aic6ERu7At9_UXWF_z-A

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


