Return-Path: <linux-fsdevel+bounces-42771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CDA4875D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104B63B9E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52126AA86;
	Thu, 27 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nZobl8tv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VAGAUxcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F123AE7B;
	Thu, 27 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679729; cv=fail; b=E3VOBLY91o5zBHK+5wc5bfMF0rld+DXAX/vR+ojGt7tdGi8ELlTB5AflgXlS05g2IRIV5GGJ5DFqekKjOEDcgsERkJQnlCnoa+J2rethVHKRTf3RiXryzLtDAZO+s1U1ugyzRCAI8LLqzFEbCXow1RKRC3ZFZIkRQd+1iGCRHLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679729; c=relaxed/simple;
	bh=yaTaHRSgLv1shpVmDsFeSP7iJPtsT60AxcXhBj0FnHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfs6i0JT9gQdNbRcqnPF/qiRvEYeD5z6nD/9w6yVaQfJiQ3bN7WSwg1858z4FpGNwRxpGNAoOBGa1JQTZLEt7uHcCXY5gdRCRAS0brMdZVbrIJNtfwEG+E7Ai3SUmiGVFddlNQiL9EBUCAKWUIox7jWiUtKENkJQ+w/c+2ao6Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nZobl8tv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VAGAUxcN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfhRa018365;
	Thu, 27 Feb 2025 18:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AxXUCgQPyn8ioomHuv5B4wgWNMqj/UJg8B5mx82ssm4=; b=
	nZobl8tvNnDZP/YoTy5hykrU3MlDkfDZWlXCkD6yLCKcSUwuc42Jb5AEB84Ol8w3
	5RBCdHU568P4tCxCYz0oMpkN56J+cSTEazpVl/7+Im5jbJESnm56nBVDaZ3oY+ix
	9KsLJAuuYy2QQJa/6+LtZOzRtdHTSkH3wpqh5OsSdsr7JH3Siro4QJ4ca1Z5QCc7
	bvwLcVBCGp8IB2X4Vp4MXwpWjXTBSh/ElyDG94G/WAxhILjUnIh+moj5R4Qmrvlj
	0LSf8XpduHoucWgl01ZtYdDYQTp5KEsUyeq6cr+RnGPf19HsXf65MPUEq8RcJqa4
	KbGoSSOq8lNe6MtrR1rRCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse40kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RH1aEX012660;
	Thu, 27 Feb 2025 18:08:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dqkar-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5CRp0UgUhTMMMc8N88ekK7vqi/4ChRu0aiYCKt30Onog8LqNIkQYJE3DH5aw85kp3BNPqmMmSWeefoFErah5vSyL6Nm1acXRuvGl6SwB0tXwMGdyqAugZ00NQX7xd2cIS4sRm9pF0oYSjvcC7s1+VwYq8VBYnQvHkALhoS13ChG2UrXUbLVsdpgV/+gb+o3Ul1tRpEWTni9k8WOLB7vW3Uz167c7d9Crzl6p97dioAcwWKMlltRlGbaS/scLzWcHxDXeFHRy2SXWOSkJQOsBgbOGPtL7F2gh3nRRID7FAxwBoQjO5216pTSz2Ag9wdBbf8ZUCsDs7A/pPTbVE9ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxXUCgQPyn8ioomHuv5B4wgWNMqj/UJg8B5mx82ssm4=;
 b=RoQGRv1rOgEblJza21DdLuPytgvO5UPXoYK92Kk/Z0eHpkKpCNWkoUIKAfpoYhArllFAGvLagejE8fe8/qf8PslkXl+N0Nh8N2u+MPeSg9JkAWebiVmxWmG4H3NFkXNIz5dt4cPxcTXhmx+dGk30RYBdGfwZEFRgT9xMK/zi0oxyENrFSnLpRn3JYtQaWd0kXSK0PUE/gRwUh0CUVE44Ky72T/7ewBvomZDNCjHik8HstJr/LGaVshbbRHxLOTEVkwwy8bZotJrjxL4gNyM+42GHE5GTtVDPAaeKBVvLBCeu9YGz+nCR6hHoghwXIqs44jQ4f+aMwqj6E88i2EqLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxXUCgQPyn8ioomHuv5B4wgWNMqj/UJg8B5mx82ssm4=;
 b=VAGAUxcNse4elycVgg3RSl5+ilq9B2QxhieMw13F6PMlAMmfW6fjnCabQhcG563bHnUBfpc38SLVy0lydBo9zleEPCWlOuh9X/TWSY9cHIm1q9Hfmhx3NNBNew+Ew+e+qq1waiLD8P5C8vj/wIRkEIVgUbfIOZupWK/lyYPX2Aw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:30 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 01/12] xfs: Pass flags to xfs_reflink_allocate_cow()
Date: Thu, 27 Feb 2025 18:08:02 +0000
Message-Id: <20250227180813.1553404-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0123.namprd02.prod.outlook.com
 (2603:10b6:208:35::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 412ffee3-e8c1-4c32-f89b-08dd5759bdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwNfNCTjpsLpmfnmce5hIhtEkJuf11A2L6AbNSnT86r9ZKjGAasoG0A8zksM?=
 =?us-ascii?Q?xQcAJsWILZYOSGqJ241ubjggK9vccpDDJD/CWor+OvL7suHWNbLKgURlIAiJ?=
 =?us-ascii?Q?idVdgXuaHBkMoc8FZ8UyOB5Tw3L50wMBfxynsNGz2StiovljscqVQvRVhTMz?=
 =?us-ascii?Q?HrDGVSWOHMZfE7A1W+jPm56iIs1BeRNZ7m1ARrLFya6FEWE32Mp1Q4wJgnNG?=
 =?us-ascii?Q?fvVVAobywht5T5EqysAyNWB2gwgtCS4SpaU28nJOQsYiRxoet0hZrJFH4WsL?=
 =?us-ascii?Q?OFX1z+Rkg3jRKlVi3O2c2+XwT4FphPBWxDBG+91l8yUeRZRPhvHzCNHlTaHH?=
 =?us-ascii?Q?v353eOC6Ci7kirYb9i8mS/8+HiwigxKKOosr4iUQBJzV+J7GrG8zD1366Jt1?=
 =?us-ascii?Q?sxu7oR0XyXNJuMEo11NzrTnPdw/JUiRKAfvthPZCw9wBNS9Uv4L++vceqOxD?=
 =?us-ascii?Q?nwa+9P5i67kroFlP9od2SHmBOOrdNe5IIT4Hgx28Ljhd5oMHElcVsNnNt1+G?=
 =?us-ascii?Q?GJtRqI+065S8s9JY4cRHOe1RJ0R6M6bQQlrJxYYUecDXmJOJdDpBrgDAdmDq?=
 =?us-ascii?Q?+IMua6Defsf1jsHphwvL4NvenThLBS7vINhBijOzNk1wbHXmqSRfKreXuczG?=
 =?us-ascii?Q?OdVhBexTzfHVSYIx2if8IqLkDuTDbUwdhQ0tyVpyAOHO+WzpwpYXVAEIEL/K?=
 =?us-ascii?Q?LbDQTQsq+kkY+EONNMn2Cjuk+n/SAZ4p6hky8bzV7FgoPPHMrfBll+kRACp+?=
 =?us-ascii?Q?ewyt+h+WGumAjyW0kHj7QGYgJQz0JZi9lKRWZcIK0L4r4CdEDl7dQ3ddMPjh?=
 =?us-ascii?Q?Jf50yi8kpXKCs2ZkkHFdpg4S+SP2bHqAUlJrWtcCJbTi2gJMJL96V9iQw6bL?=
 =?us-ascii?Q?uc+8qlhqncUQz5/vkKBBQmuanw2EIrCUim52UvrumZ52msUyOVg5MNmTj5rv?=
 =?us-ascii?Q?GmdKAf4aFgdeJzuFnSWaLAUGVYx53pdnQeOjTp5pdBzELoFQm8+JDH+vkwnc?=
 =?us-ascii?Q?63ITUVZEMk6BydMrVEauQyvHSGIHcn3FTYfx58QdB2/FB0J2p4vjGq1wLkRA?=
 =?us-ascii?Q?a7zc/IppIm7nG1gH+Hc/7Z3Ans+wrjrbGHzLKZIz9ySR0yG5TmwY+pvpqQ+Y?=
 =?us-ascii?Q?KU9ebmhxZ91dlxS2X9g+j6U+z3oqDs5ymLE2Fctxx5Djno4qtLRjLLD68Vcu?=
 =?us-ascii?Q?SXdbZRDSqP7BfwQlTPmTHDjDHLQybBMo7fMO9T/X4XhmFRk3Y1LKx3QvzWl6?=
 =?us-ascii?Q?onTFP2R7+3kNp9braI4RUEuZtfMD96VUJLoUvOoarvVybzG9thVipgx8779F?=
 =?us-ascii?Q?wLWfdteE4hPuIYRUOGFbAarLXZ7BoGrjVvKItEig2upXTBUoV87UdBJIEojw?=
 =?us-ascii?Q?8fW5VXNMDZarYsxGcrzOfNZVDIie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0JGaAfecgDGAikMMmLVeAIJtw1ygvKIxZVNNS02phyoEEWOrOtCrfMFVr6p?=
 =?us-ascii?Q?gzf7RqfbWTjs+0zy916TaDzyg9/CdSye5QdNfHd4lNPCXvfG65tMr/DnfP/x?=
 =?us-ascii?Q?jmoLpkdLUro2hphP3qvlr+GGfystdWyJyUC1ufXDNtF0juheAicNt2s1J81f?=
 =?us-ascii?Q?Ps1cHYjKpe/eLg8bysUzucDXnURB1Fz/JYSJSru40Nks12dspLlXeB6c8oQ2?=
 =?us-ascii?Q?DKkCTQbSFgN0puFDFFKerB8aOmGQRSgs8qReD72errPEhnPGWPQBnUebHKQA?=
 =?us-ascii?Q?cNWp7Gn9NJGivWHI7OgjLvtvlflaDo1qm4rTj0IR6+q2otGDm43nu7sEah8k?=
 =?us-ascii?Q?h9Ri5j+MYu/Hi/wz7h8Egqy9x0VlSjy7ME4IAWeAxRi1RDkjZQwoaYDVLSsZ?=
 =?us-ascii?Q?dqpkadPpZglWFf6DL11p91Uaf0AmRir8eYnMvWsvYlrWT4T9EK1fpYDvQKIe?=
 =?us-ascii?Q?0ihP8TgyWExH90IdqMM8vnSGJ4MoEzypIb46pCStznGlxtG/ropbCO0cw16k?=
 =?us-ascii?Q?Xa1h8so64sC3zAgeDX/rq+fkO+OoCaIbDm4EmzTZNMY+vry+C7h4LbezYkJA?=
 =?us-ascii?Q?97CmjZHAlE0hf8iBr61yk7sfZZ1cGo6d+l1MRA+bWVltLnCfePoq1I3uo7YW?=
 =?us-ascii?Q?jae9wMKmu74QVbpmbApYo0A+RfzYmkoVJl2nwShXn8SdULUjD7vkG8SMnl6a?=
 =?us-ascii?Q?Hcn4kYoy8opwe7/Yi3AavKoSMIXWeH73ccU9lmdiFyyECC38eEvuBGAo0LUn?=
 =?us-ascii?Q?2E/UYU4FhNDeBGbsT5xMDEBTr0KYM9punS4Ko4bjoy06hdY6jBHEHXH5T6wX?=
 =?us-ascii?Q?r581OB+BkUNUds0MwRiMpKs08JGVkBEn7ipjAYnrNE6NOZ5sR803D2js/S/n?=
 =?us-ascii?Q?UpGoQkBj2E2l6ywYvQxpnwe3DDUvisfKwcBFsUNRrskKz84sG8j1fhOlMzLK?=
 =?us-ascii?Q?rJLv8k/MlDatpRxwRJ7940AYLO6yCVH9S0lhyke1xAcTMmkMDY+c5iE/yHvP?=
 =?us-ascii?Q?EKbYRQ/05XnOzKanOvj7v+SjTrxu8NDCdsC1YohwJYUavXpp59lBI37FKdMN?=
 =?us-ascii?Q?G7Pffi/5o/GGFem5Sdpey84MqN+JNPREtoiI6dHgEWNq3dFwXHGTcnoa4bDg?=
 =?us-ascii?Q?mMruqZshPTPoMyoDk/eFYOsEbCSNz6E7stHZyuzU9GxbBYalyOTE89oHXuWL?=
 =?us-ascii?Q?HVdH/QAulF5J2JeoQ7hwqG0ooDHDvJ+VttXqXc/lqtlanGfWe5beieSFOY3A?=
 =?us-ascii?Q?2EH+1On12wl5Rl060RIzl2i3JD+yLVpTY3LKIiZC6CjBerdgSSboW0po5vA3?=
 =?us-ascii?Q?t7FiGyvs0Ic3QImnNn8ZyzQrMCjlxYZ8Ps/iXpJkj8XywGaP+jxqhkywqz10?=
 =?us-ascii?Q?s/j7VPtEFMgXiS8KqSnq/zYqeZKjV+pF7O0Q6vBpIdFsimOTSWFbOO8eeMDa?=
 =?us-ascii?Q?NpSc7iH9SnJh0G6D5etxcHZt1ftQTTM8MPOuBS50XxySlcBr1GgJkSjsVMsu?=
 =?us-ascii?Q?WSSTMVWsjJUL54ILvCpkoqquOs4DycLginvqiSBTRaWMgYtcpP0Hc6++f1KD?=
 =?us-ascii?Q?ssWmIbuHCROijTayF2NXknT5buz2qQHWMXGU62eOr7a9/19zkX5DHthiDJUV?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NiTNk5P000pFirqdXdqV0zrndgusAf2YGxi7ywM1aH5+n1hJiVYiFD0qKcQt8z9o7MZIKs2eg+buyWqQIqAWHm2OMp5UwOMdDabjTQMtmbjsjhvtjWHaqXQucjELz98bJuT7rdbxHWCnsr7tcQH8kQPo55PgWkEcyAtk+OGaE5UxOglusfh/KCMo7XNrhzljDrbSrO40UEo4Cdh6GA6vO2G+xs5SlL4I2aoV9gxgCxZt60Z4eWWjmKbnEQ7ZlHIJk+XRXJ43kwxn3vFawIhcaD8VS3Hut8d4TVzKm0UkKIshXkDmgdT3l7ylcFWUin/oaHVE456q6jl1oq73oPt03diayy6dn74YzyLOB+8BRiHADhop35PwACN4erg4DytqqpWoIX+6/5SwmZC8s2osmQR4NVeRLneqqXAybJwpA0gOr6uUVsglwF+xT+c0m0Fi7ztLlXkz/3YA7GiTItiecuDOCjsHmilAxa1EA1nzDS7sbJgjDL6juR2SocfFt0UrsARIqTmDYI/f5E7zOzPkLTXJFvhPrjHLB4kfjJU9uM6lraAPJVCSCqhMrhTV836TVjiFZOVUZJm5zJU98CTt+ZbIP4Kjrcbi3ZqAOz4NemU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ffee3-e8c1-4c32-f89b-08dd5759bdc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:30.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3vRS1g6FS26MVgknDzCp+VFDTkCVoRVpuF1cN7V4Mx5vhMH0tIhHFNSUl/vUQSt36stAXq17eedkUYeZGUtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: PMr0Uo8-VW18iaxoRXSd8ygC90r5n9Wx
X-Proofpoint-GUID: PMr0Uo8-VW18iaxoRXSd8ygC90r5n9Wx

In future we will want more boolean options for xfs_reflink_allocate_cow(),
so just prepare for this by passing a flags arg for @convert_now.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  7 +++++--
 fs/xfs/xfs_reflink.c | 10 ++++++----
 fs/xfs/xfs_reflink.h |  7 ++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d61460309a78..edfc038bf728 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -810,6 +810,7 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
+	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode;
@@ -820,6 +821,9 @@ xfs_direct_write_iomap_begin(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (flags & IOMAP_DIRECT || IS_DAX(inode))
+		reflink_flags |= XFS_REFLINK_CONVERT;
+
 	/*
 	 * Writes that span EOF might trigger an IO size update on completion,
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
@@ -864,8 +868,7 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 59f7fc16eb80..0eb2670fc6fb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,7 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -488,7 +488,8 @@ xfs_reflink_fill_cow_hole(
 		return error;
 
 convert:
-	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+	return xfs_reflink_convert_unwritten(ip, imap, cmap,
+			flags & XFS_REFLINK_CONVERT);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
@@ -566,10 +567,11 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	int			error;
 	bool			found;
+	bool			convert_now = flags & XFS_REFLINK_CONVERT;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (!ip->i_cowfp) {
@@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, flags);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..cdbd73d58822 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,6 +6,11 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
+/*
+ * Flags for xfs_reflink_allocate_cow()
+ */
+#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
  * to do so when an inode has dirty cache or I/O in-flight, even if no shared
@@ -32,7 +37,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		unsigned int flags);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 
-- 
2.31.1


