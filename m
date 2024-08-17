Return-Path: <linux-fsdevel+bounces-26188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361119556F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D7B21D2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6315099D;
	Sat, 17 Aug 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9ei0Dg3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B0tQo8IM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47414EC4B;
	Sat, 17 Aug 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888125; cv=fail; b=r4EDHuFbaZH6qCd0lazvRP3ST3Vs/jVb9Lodm+B5aQ6yiJT4b++D8xFTOiPmOuLuXS9bYECFZ2iGe9y9BZB4a2NMFs7jPeH1OsHX9+i/Dltmm7JzZw3GNekr3oLFhB6yA55D7B0LwAHxohRxYZNPCFcMAlrJmAMZyMlmj5+q8Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888125; c=relaxed/simple;
	bh=eHi+Sr+xKoY6ew/Iq7+B+dzKCz/w1yaKXTEgpjcVStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGCXCusgEHPxD4OuQI/lKCvfkBIsKKu3hC3rJDjnYKgXsjuhuP0y0/UPdDCDSHuPMTd4qpT+h9PYnq1RcQVn1KLpbZDqcsSkUNTU5jIVbe/9Q/erYu1ZC6bw0bxnfzajZXTetnO53S8MTfEC+P0PfsK9AwT+4f0GN3HgdK47iLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9ei0Dg3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B0tQo8IM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H4jcEI010282;
	Sat, 17 Aug 2024 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LFa4FRTWKLYa9qsjerysXyWyYZxrVlTZrd7Quw8jk7k=; b=
	V9ei0Dg3IZAL0QRHYhHw72NHaNFPQiYZ8LgnSVDOXl9ntr88pDfPlvoEhLcYlMf9
	CdWIT+df6AZkWZIz4tXquZXn5WsYYtnEKjLjtAg+OOQoW1Ab+fcWjJbGevbw8XMI
	lbPsnqt5qStXCwk4j1eIV2yPMRIbKvtFKZ0ThW2T34GHg/oRwYXO2CJQuqm63hLW
	Nu2jnjq6rhKXaULFDYShaA/LqkZpnUDScLTh/BeS/NAT90qfma6xEOXwJGWmNw5+
	9rtPWISZt5gpuBUqjMfb4YStd5oEV3vfgRM3wV1XB6PIiI8JMdiRxW1T5NMZBLUH
	dIt/CokKDI+7YjZSgIVtuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsr7ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H811UJ031437;
	Sat, 17 Aug 2024 09:48:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5y121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+UXyKH9qMNBP/GrpxXrL7+69G/+8L5aEdN4Q+A/JqGaLtHuMSW2mHpxS6rdfhRyvQhhmyrkuMEps2rpFMOcLIH0GIk5fMpRz10A3aK1xj6m5FTrDcc82zwnWdz8IGX6Z06ZrMuihUWLfy2T0EHO7dSXbc6zkFOA9rC6xYc+66ajP/BiCZnR/78BPHhaNyHL0/LjxH8A4FBacBeweLANEi5H5MduWRH464CMrbTr7j4+7n45uYy1dA7CwRmEDi4K0qObfl0PhsZtzcjHkkPE9QovFgHUgkZJ6GG2QEpSgBsOQKs2RIf/Z/5v6b4QEUbnLwh9nnwm+jBKVrq/KCMJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFa4FRTWKLYa9qsjerysXyWyYZxrVlTZrd7Quw8jk7k=;
 b=uNkrBQZFSt3ExA21hQPlOy+lHgmWZKElc62OvsG4P//7Uc3cXVDcC6HQYYYfPd3bnog5ZWwaWwbavmGRYdZZ0PPSqtR2L6H5T/2eON2WQPS6RIF3lrsnAmYtSQQfARyfCdR2/I9/rlQYtIKcHBGUNcltSzPAofTJvqNa+cy14mMi80umlrW+8qWRMoQtccs5ayvpF74oMgsUluQjcqvjdZWNXiCWHDf3L88bubC8WgzXAHhrMlB/4Dn89MoiYRU+6Axk0hHIiR00uwjyIpc6GE21WFGo3bt7qqIC5uSj+3WpfFkMgQ/zObY4KcSjtB6vK/dUD8ilo8vkxnL4DMngOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFa4FRTWKLYa9qsjerysXyWyYZxrVlTZrd7Quw8jk7k=;
 b=B0tQo8IMANVYcO4QPYcGd3XcYrh2ix9opuDEnlPLyukFNuE1NwzH6yNAFzUT60Sl415xrLIIqEgcfzvoMHo+vSXZ00COqcRB6FbV5LyiMfmy8wbMbgbpsPFKxEg5eq/zFIHFZQ61k+GkBX7Ibkxb6xZwHKzGcuMzG2XKK/Ce5WE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 5/7] xfs: Support atomic write for statx
Date: Sat, 17 Aug 2024 09:47:58 +0000
Message-Id: <20240817094800.776408-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 827a42f3-a7b7-4d14-6455-08dcbea1bc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCFuHyjOZDhGrQ6PfiAjdM7v11/CZKcurNttdUul7JQI0yIcJUQIBok0sbSK?=
 =?us-ascii?Q?j12AyfUkz3+OdKUFj4W4lFjEYMInY5j3cy1NdZ+Fjsw+xkW4oDwKVfrv1fBU?=
 =?us-ascii?Q?IOOaDGA0LG0xNLUr0G904ubgoCarjy/OpDi6evroT/H2U1T3Q5cGNdLI7y23?=
 =?us-ascii?Q?8W6vur+kWX3PX7Yze5v+7wyn7AfzOjJrVL1Bthv24pZ4I7DSb04RiWzOW8qY?=
 =?us-ascii?Q?bsQ8CPJa4XtSeUfxVgCo3pDk8lXhCQSPair8tt0Q6UhsGNCW/QTMLE27SdH+?=
 =?us-ascii?Q?9B+zNKGFCybM98JxoXuGlO9jGHvbdIc3zaFL3ygKxQJdgwXqsvBE/Rzvtg7C?=
 =?us-ascii?Q?gzylTNLodkz7LkM3Tk40qefku7skyDWf1bYIZ3HMWDW/QlS53BGYB3AeatCU?=
 =?us-ascii?Q?d0/YjicnvZUruRi6w0gqpD+0cxqE1/xz1hfWB5qgxK+/rNc2QS17tEOVLuTj?=
 =?us-ascii?Q?vZynMVmfdqjzfqstf50GTJaUEEfuUfN625Aj0QCKAgkePH9SmOv52NSz8MTe?=
 =?us-ascii?Q?b2ttx8HHxSaTdmDTskEXXkVjGYH7pbmVUqGWmQeQuI84sUuuZM7QMy8YO0dq?=
 =?us-ascii?Q?CB9RqsvdxLnNQTANj5cpUQ9zM/pwiSV8fbJy9QjOFBSTI2kNGX08DuRD/yEs?=
 =?us-ascii?Q?5Lid+gFSkkj01VKn27egB0YCEl1o8h5TA7/8g/QestP8Flb7bi9jWFhj4HKf?=
 =?us-ascii?Q?UQ2fd//ZN74yLdKDsDzCITpiua0uBea268BowNEugr793yf78ZDTyMNvsG4J?=
 =?us-ascii?Q?bwUEa9x693JmnduRcm+9kRP3BtGL2pAq9rovMlGNsUHJDI0fpIpC+FT6fMii?=
 =?us-ascii?Q?04tB1iI43VwC2HJVSsP4xL8ArBDDDfefsYLiaytnJLFJET/JjGgTv13AyXJM?=
 =?us-ascii?Q?z3Xl0jM+zqpu+JYeNGTLc3KUV2vYyyFnmwARgqr8LgfeBaaFOxPEB8L6Qusv?=
 =?us-ascii?Q?CDuZepzwHHfmibxuFEtcJm70vvgQyaw9ooJqqQhkg7hrbO9nx/5qGtATzRA9?=
 =?us-ascii?Q?kGvOspRRkq0clF9udZ2tgxSegJooMI/dAjuqRXhyUv2veK28tlEcCYs1WD8Z?=
 =?us-ascii?Q?V/sAtzhj3fNZr+hfJqIlZAq2hkBPTQw4OxPAu+Oyh/d4DVr4zVs9c08KaaL1?=
 =?us-ascii?Q?Ygp9B6aNeSlC6yLB+9W+Jkw3IvYhGGua/sXc0OCvYrbhGwEi8rxD/J1xu7C2?=
 =?us-ascii?Q?VCN/kim7HFuMKdudZS8U6vL5rFxRgDJ1vLTedbauTv4p4vS5mWC2U3zOjday?=
 =?us-ascii?Q?IitLxCdc0IW2MaWdrWEV3HjWaJZLvexDPadzZutkAhe6iweJhYaazifZ8pcX?=
 =?us-ascii?Q?RBJgKWGeB0V/RDbHl65y3QDGqlGJaTq6/JDoNsMEDPd+SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZtzNb1yW+ccGSHVON6rxKGC99CZL2Rt6ohzkhWRi4mUPj7mVoIxlQWlyme7?=
 =?us-ascii?Q?FkWuqTrCplLxHtm4agSaB78RUZlil5qu+t1dsR454u6i3bxJzHnoxEPf/4Kv?=
 =?us-ascii?Q?w34lhXFQXa3bneytiIsqAT0jRBb0jBRneJzZjrXN+yF8AMKBMsxagi91Igy4?=
 =?us-ascii?Q?OYeVs3cUS5J1aLe3oBTg2GwiiNHwXANfmeiWs3A0yBWjMPOyX8Hve/pxyxtT?=
 =?us-ascii?Q?yfnbGgK6AbFZbUtJLS/WcIp9eSOXfnJCKBjKC0EIjDdonl7pIEl2U+R7Gn2x?=
 =?us-ascii?Q?3Onkj2etW4HT/bK6KxfUKaxMyqNq2dCBRU0dVoDX2itR2oS8dv70WRNMUd6m?=
 =?us-ascii?Q?/YtuIuGpoFM3/iCoIDxJxhllan/7U/wgyK9KurIRfvzOhn7eTOUesdiGEnyn?=
 =?us-ascii?Q?IWw5/XKtpigZWycwa5IAWaJJ7l/3A2EleQ6565AE4CHsQwaxR+0/5hT1wrsk?=
 =?us-ascii?Q?h+HqkJyQUBWlFxa5GzBRcMxfeUcEygqDFPDkSFJQhnelppg2N6PAC0XE07/8?=
 =?us-ascii?Q?ccWUzNPLmJA9gFrEar29fEo9U7iG8EP4NPBpmGNCeK6mulXyXDxWCe/So0Ev?=
 =?us-ascii?Q?tEcKr4P2MssCXgd1UOXWtXbM136a9Wb4i1Wz3j6Cd/0YOOWjuPHGU4b6T0nc?=
 =?us-ascii?Q?+K34h4pModrEbN8sm4fcUmxDNLRfSk7T/Xi2WNsmy4+Bxyn1/3753Wgq1/m1?=
 =?us-ascii?Q?O4yINbG5lxaFq78UIQ10VPASvq5wjC5dahaBEn3CJhmsX+bt59UPFLbaTamg?=
 =?us-ascii?Q?jpr9RNhhCUFVF0iMFdqhOgPPosttg4ZVRwq1aXZ5dYn19jX/uryTGCKiA2X9?=
 =?us-ascii?Q?hgQ6eq26MKlfQfjURY7SCKLB75AU8Vh4uxlMll9cUUcvtRaIStX4CSY8q0jw?=
 =?us-ascii?Q?4/IlptS2QspN8Znv93q82rqxjf07KftV2pGjvz+fIA73GFhXlsyhTRp4QdhK?=
 =?us-ascii?Q?HrsuNgRmCStAFn89ibdefOEPQXryFCeDL3PWoru9UFywyVVdthMIJhR9sxdD?=
 =?us-ascii?Q?NX2OFkEx2WiHWbM78q5ZVZslQbqGzGR5o3sZF53cqnNntjLmgBK8NoMOA9uy?=
 =?us-ascii?Q?GZJ/HbK6PnuSV15syo7bs5Sj1Kqta18KhZqYdQnpROTJrDo5Va4w3hCAb91B?=
 =?us-ascii?Q?i5FHUCdJ1E95HneviWV8kNxKTBlYp6Rr9eGsLpF2yc41nSyLhx1CZtYH7WO6?=
 =?us-ascii?Q?DnxVN3iz8/znBMVNSo6TxGxjKD6yL4o2j4rKhqdEEfCuBeUF7DYcNQsKJH/c?=
 =?us-ascii?Q?vkvT+gEOHkdM237Kfh92zdMfYVZkvELq0wwNDADu6RGRxrgJQfF+6OkBTI6p?=
 =?us-ascii?Q?rC3Z+JHC3IImo+ubqZEN9O5DgUd+Lb5KpAiwlAp0eZiXRi2JXSdXS5FPhgKp?=
 =?us-ascii?Q?2pXu/SSHaSSZJipqbqQOYC26pZxt0l8DiWvv6Sw+cs5AJCirOakRlqOWCtKZ?=
 =?us-ascii?Q?rtLa1jYW8LxpMIZ4tGKnsl7r9R/sW2+In1tVECpXmO4Bphw6NhiZPgG6o8eW?=
 =?us-ascii?Q?zRuG59gJzEzeP26nWnQkFcu28Id2aRlPkmX+u5k85+t6MxxGUjHOoxClHJVi?=
 =?us-ascii?Q?5ShpEteTnmq6wCj0lf/AcKxJlfpHTX2h2zVaFhi399OFP/I+xFOYNV2ApNvN?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JwH3/IBiASEX9lySH9Dk9X1+93Qez87dqkyIZyjWUM3B9HYJevh1guPtMZJCiVb0882pAZ3mRtZ5vU17AA8m3REkDGfIv4HD0Zpiu2QlNt9NDKQbYQQHlsb8G/605TdnIS6vGGN9jHpVYwE2tnhRlVP/NeEgsX68yZ8Pjl9Y1NXapJeoRsfWjoeEb4H6H7Uj53m6+HJqARDkLS3zj1g9WOeZx2JhuTjg9STs0knWZk0qS/fYXl9FbUluXi2P92C3LRtuRQBemKJIHS6KdIZqt9XpzD/8+qHxP+r2FKSQmUFYOxfPfREWGILA3nffTWik0XkPSe1j9y2LHATJ25EmYYnqyQWuxeBny1UUpauE5KaRwgVLCYbnKJwSjmW9HZtVMvNvrFWy3hcRz4aYQiOQTIK2GWoKbN6csXpOzoXG0oULEsH054sKlKTxnKx4rl1cYfUc05FFsIWBG5Lnzpx7p6gWBNrb/FY5+E7IoVFYDIZO8PXdZlcg0WIuiXYtR1NFvk9vgH5RKTgQMDTE/07/+76zyWngPV6OaqwxI+9UbDfFnf+azGvV5aVMlcSWNbElGOHVSFbPJGzwJazTiynMUnUzwJseuxiMOJn6bc4Djbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827a42f3-a7b7-4d14-6455-08dcbea1bc70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:24.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++e/SfUDIPxKVDnz6hjDSA4MWwqXJzdiCgAbjVjh18yrAreJmYxwR+NYPxxY3oiwywsyRNhDlifIV2vUS5WixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: 64SJE5CeYWdLldsjMedtXExwlKzLmXIB
X-Proofpoint-GUID: 64SJE5CeYWdLldsjMedtXExwlKzLmXIB

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future. This is required by iomap
DIO.

The atomic write unit min and max is limited by the guaranteed extent
alignment for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6e017aa6f61d..c20becd3a7c9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,27 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, ip->i_extsize);
+
+	if (!xfs_inode_has_atomicwrites(ip)) {
+		*unit_min = 0;
+		*unit_max = 0;
+		return;
+	}
+
+	*unit_min = sbp->sb_blocksize;
+	*unit_max = min(target->bt_bdev_awu_max, extsz_bytes);
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +664,13 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


