Return-Path: <linux-fsdevel+bounces-47386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9DA9CEA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C27189CF5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F531F1905;
	Fri, 25 Apr 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNJuS8dk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X59pgaTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF21E8327;
	Fri, 25 Apr 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599583; cv=fail; b=LPRVrA6nqx3rG9Jw64VYi1rDvGRsYFDsDX0Np8OgivVPDRFHMmSYaK5/kGqnZIm6TOHhkpRi4W40jdlYuqe4Y5o6T481WgNy7NzodJNOrLlQlWmp5yMsKxnjrSb8WW9Cienyb3oNYNf4pDjlTszR5MP6J2a+jVtxvGIpcGfuoX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599583; c=relaxed/simple;
	bh=6eeb0aCCmZCNlSkXk7xSBWUa+nF3BVJOdYoANBrSI6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GymmdY3Z6wmqy5V4MsDppdBtdnYac1L5hrSXS0ERNXrd2ZnpYviQNjhK9cwu/7I1ur4Mu0IpTHxW2/oVjE86C299p58N1RDRL5CaHs0B4b/RxaiT4R8G/+ztEhZiuNEKL2iJbK/R4Z7rXInC9TloYIvS/gM7r5bOPn5Rwq5W3ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MNJuS8dk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X59pgaTO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWH2b005082;
	Fri, 25 Apr 2025 16:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ixj3r3R5RjDicFbjz4msTltuHjafzrpLc4IONzDi/S4=; b=
	MNJuS8dk8F3C69EkHORtso0Iv9mNfVTGShrHzJpfooj1NPnOLpitADnWjOIb53Rj
	tbILkVJMoYdUuQAkaH2KQkQvu1qmiVtxw9A0FUzYMFhSw2GY1JGbGrTIsY7j/QvR
	uIcakmSCKodFNfNwvXPS4JNZwb80mCHHg3wiUCtEqKbHf7TzZ5mMkWXCE7VxcpKV
	A78ux+XXgu1t7S8hk4k3cBQia9RhR9NNh6iZce7wv6o/JZa+6ZMMVKDSHHH1NIGv
	oTBfnsxMkbeYWVhHQO1zc1/dYW+HNQ9ClYx5C9ULdmX66xHPrX/2po6DAxtklGb5
	Xyqt0uRMrR6CN3dm3JzxVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:46:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFabxD017293;
	Fri, 25 Apr 2025 16:46:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvj4eb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOKXTUv/YWUZs+V9jZoYi5K0m65RTCG6V3r8//VwgufP3CIjxnM6uvcQHRcq4MY2FewiJMeHV5zgcHgug1R3r/t88e16idByOv686j9Isejy7t+PZzJ04X4nDPZfTGekROZ7KH8TlHxTtlv5paKTjiyT8zffH+thcHkuVb9qMj28vLeOlkrtMCBcAxPvkzxX1f24a8XVkz+r5vLvCaIMTPlMlECcD4fcouyM71Afh9Zo6ZY1tNt+y3gpIuUFNpy6khbzXk+TKduo9DuYqbtEalLKF2B/jv/aIB5Atr10+8igHL++HYPneB5WhIYF5obb4BSKXCX3zUM0bAX3fuEZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixj3r3R5RjDicFbjz4msTltuHjafzrpLc4IONzDi/S4=;
 b=l0iQIhnIuU4OSdscETWkRFE+S6wxftRD+lvEj3qrlGBCCndSoHkLZ83pXYRJjxeW5d/3fCrVc4AfnWESOQ5oWc0qRDBx5K7Wuo5h6As8TpYBmRzVYg6/tIszGcaqsu2EG1XMXd1sKI/PuNw4uvwD+KS+GPI2bmo3WHgxCYXgSmcHBrTffyoCsyb5tMSGviO1BKm+IkiEydDP2pA2hKCYvHrDjtsItG1mIyAMzH4wb6f+4gIq856Ztz6EZXYjTc9dVsOc8l6gDrTgiSytzuVra71b+FxLP9XOYlj7jLyKfQq1vHUszqlftilX6EVoiOEem2O/LPf8QKoHcI4mg0H8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixj3r3R5RjDicFbjz4msTltuHjafzrpLc4IONzDi/S4=;
 b=X59pgaTODLZHkQZY4RofYdmX4akycEBWGacb2etgZ+nmUPCuAzWkVJD+7HVzAA26iBuxqndwc5OgZpuHVEpFLTN3uwCu/FKjcXSU7a+Y1ngEEM9uQTR/sBrDZcobUytL0d408xLGnMMzSSHtIH9/f93tqn25M3L/IBXYYYzwack=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Fri, 25 Apr
 2025 16:45:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 14/15] xfs: update atomic write limits
Date: Fri, 25 Apr 2025 16:45:03 +0000
Message-Id: <20250425164504.3263637-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: e5757ba0-82ae-4a9d-26c7-08dd8418a7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lO44+dfxRPQOP2SqK2fMM5+kTX8p4aIPpHBm6gEFCJyqheX7XOYjq1eqR9oB?=
 =?us-ascii?Q?HFLk1ex2j/ek3HbWkqbiEcmhPdcaDl1VeLKw/Egr/I//nuLMZ0farg7qsQgn?=
 =?us-ascii?Q?cRBTDXbI4tKO+NS29SKBkNuji5575qAUOSqH/fxt13IXdzHiurXkYbJ+uZmH?=
 =?us-ascii?Q?BX8chqs9x2ttbiuPvPA+/5XP8Gkn7kLEmW8tStGM3pCvBg7UEhHxpJKHTD0e?=
 =?us-ascii?Q?BY+TEiZ/cGzoh0HWYgEiYHPCl0MSIWhHAN2I0dfP0X0DJjDgN9IPVoTVIiut?=
 =?us-ascii?Q?bdoSTlzm7p5b7eZQ2VmLxjKv+FtiT2k7Q4gZt9QsJa7x4WET/aOLHG0n45MJ?=
 =?us-ascii?Q?fIK7rgiQTA9TsY8xibgiY1yk2lXw8mYH0Y0W2lziKit0xwSaF4J0yvzu3QDD?=
 =?us-ascii?Q?zauht+QzCAO5S9s7Zceh5HOvXFB/uRaBuQ0PsQL9Sv2la5EW/utMqfFlFx0D?=
 =?us-ascii?Q?hfPDGmLs1UAaPM9n72hW43FC36s05ShqEF2BwtEGDHCQDzhKm52q4rvlJYQ3?=
 =?us-ascii?Q?6YMCeU81dsaM9Y2g8CkBkZyw6SoK3ORNXCagYYibDGit3bCnWQyF7Bu8Ujq9?=
 =?us-ascii?Q?UspbbUuSDnzsPp4u6Th6/z9REMQ/pnbuhhJur9jS9dgQco+Bq8VLiHyo246T?=
 =?us-ascii?Q?BFaBAoLbUt96nbyztdH+WjfvpnmqYWiyE7crCc+zpSMrc+aOw/ZlN//6MCmF?=
 =?us-ascii?Q?GeaEhOUfoEaoJWHFKoJ/3zAzxvjFsL7FDfDdyxCqpH6J/qYTeKfGYg4g9HlJ?=
 =?us-ascii?Q?LQtFH/rgOaCYaDph1KPL5tH5Jj7EvMWepoYDJsM1DxkHHWb8JCRyqVuIF6BI?=
 =?us-ascii?Q?NkCFV4Qe5iuvW+gTt5+dVCWNaisTxosO9wl8jRHORtZeFcsL0xMm/OkYWS8P?=
 =?us-ascii?Q?LSezKWLvAF6JMpBN5+8fzvQha3uxxbBeuGVx7CTPeX7YwFPX8PlkAmq0pGeK?=
 =?us-ascii?Q?XIL9Ft4a1pb6xigTjw6pfn1GyH/CHPuW9f6ogw+ei3XK6tp68EeCZheqmggB?=
 =?us-ascii?Q?y3268bAdnnVRJIj9QAMp5aDjoP7wZryeR5I+gXaVF5vIs8ssdAI01OpI3Ug/?=
 =?us-ascii?Q?3q7ytkTch+VSkrvKCwWnA9kQGuwcWQmyIsRFs7v2bSYHI+iAkZ4oAVIDD+7Q?=
 =?us-ascii?Q?qstL9MfFgJ2HxqQz/iGKX1u3iq/EkWIK5wUxlE0yvBb3bY10fC1MA7SSQ5ie?=
 =?us-ascii?Q?tUFkk5ZlC/UKa8JGkMe512sPbn19Wu1DqnE4bnjqBGpkLW90veafANUQNY/4?=
 =?us-ascii?Q?QvsK6IGlmEasxrSUoegDrDhLR1j5nfwQx8YHDMYzs1iP/gCpFuJcOU17V6MN?=
 =?us-ascii?Q?0AcuCsBylMvIpT7Z8fktBuhVlN6k46Ve52U20tIOAtKNZaYnn3t25prLARws?=
 =?us-ascii?Q?zsZtCKnGpGJZ4kgw4nazIc9cJ0pSdkaJ260Ucem4T46LiC5o0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hEsLQ+CnmSCYd00/2ldWC7Kv2Qkout86mKIkEuPJcMbXa2fxu3CPxt/f/gx7?=
 =?us-ascii?Q?6HDA/ZKRkg+sAGOtuKPo3RsKVlkYOt7f9SSD4T6xhFjUL2dw0MBLgR3Y0Rs8?=
 =?us-ascii?Q?n+CPWxwgReNR/W9bNkGeb0bFYgHUqpn/DT0NYmkr4poYb9OV/CG3bE9m7pE0?=
 =?us-ascii?Q?iPyg+07qMSWSQv45hObTAmwOOD6gBcnEtpg0APDV+jen08GNZ4uYCCKCTkY8?=
 =?us-ascii?Q?/Bi7Bs9GvJqE+2jC8WYgcFlnFNGxnwNmSbRqGcrEtIRqAE7uQm3h6aGSDueU?=
 =?us-ascii?Q?EVllFoKwfWH5tbQcvMJPjA1CJ7v5wBvpqSRHAFgmkcqCWi5YVzvtyu6zj9UR?=
 =?us-ascii?Q?m6fwkPGJ1+mFvSzhSkdAEAMKp4xp6SdVtIX6PlRo+izOFufOeF3XmX1bB5i1?=
 =?us-ascii?Q?rkbcEUWiGZEMRRVV3aoGa3yv1zCJV4ahNBGiJpy/ljUXEtfLfj9Vnanqy3mE?=
 =?us-ascii?Q?Kyr5JsfaAItkr5FHMCXsWQw4vIN6vsIepmLs87Kv6iaIkzIonK7XpJhpIYSf?=
 =?us-ascii?Q?VvezAA3EK1wR6rhcEWcTLz2Qin3szljgunEInt4+nQOyEryIja5qWx8DvmB6?=
 =?us-ascii?Q?QxvdixA4Fz6fG6NyEkseyH5pSWJJFSp/oh++ik74JuMbGVacjSgg0ab7574k?=
 =?us-ascii?Q?byJ60wexmAHaX//QKVPUxFPUBlW4IyYM8bpSKfZYPw0FsYjr2aAouiaMgrPo?=
 =?us-ascii?Q?9Wu9XUjLqao9dzqd1Oo9Vc6pplLu/woqQLLIF2fnyz/MwS9NXqHNPsfSsqGm?=
 =?us-ascii?Q?M/fvYhKfd89AcFEJwdSRGA/Nl4rFW7CukhYloE6Qd3dK9UHxRxAP5JAqntLA?=
 =?us-ascii?Q?sdn34fRyiCm1wqgPc+RDnG9YLBVd4CUpNNFE8toqIr+nrbgDbDS+XYfqGQJ1?=
 =?us-ascii?Q?sI2ZDIT/gWnJLdlZVCK7YCP9FOmpRaHgJl0E1XJlg+fbjtpCTxujxckrZpQj?=
 =?us-ascii?Q?GFFvRbh5yRvWzn3zpYAigtgkrlNEkKTYxOAyt3M4LOlRxYMpN9U0poAh534N?=
 =?us-ascii?Q?Ueak2W6o6C8jNZ+tcNV37RiOiAgIdYWhkbFOj2np8BgCkMF4FaUhhSMD749+?=
 =?us-ascii?Q?ww6fymQdlj4SzEl7XB0lpvNsfn/89O91TLhTTSwVj/PMMsKAAvuUCo7mnJR5?=
 =?us-ascii?Q?NxxBhbe2Jl2oRh1fqllc5UYwFPXqUOTY8tW0wHLT/dvP0vDOxqinjI/5fIy/?=
 =?us-ascii?Q?kKz8TGMv4ehjI52PcUc/vMvIIdnHUMXubguy1tkM+07roh1blsqWwBNTCxuw?=
 =?us-ascii?Q?3NVbejK33e0kSFzJ21OqyklJo+LVTijXR7yv7qkpZdqGeG///WbHXtp1ul0B?=
 =?us-ascii?Q?WaD/HWrD+6VA6sgcxFuzJQmKT/Lbj+NOYRGhZ/jqd/URHAxiFtMa6Ggb1Oan?=
 =?us-ascii?Q?Xe25H9T+vResfOYawHARm1YusDYjXmlTID6fjEtHb8bLnPB1V2RS8MtPzL2c?=
 =?us-ascii?Q?wRuxD5FccEaNG9697HgkC6qR4f8elAhfyG7K2w3X7E5IFGhx0pkxWq+t2rJA?=
 =?us-ascii?Q?laRFAmA/v9RfYMZo6WO+uMVSaXsIel3zZqp8KX9XzRMj4UmVzO/HZ7hDglBR?=
 =?us-ascii?Q?1uKrPNil5hNLcsGoPhCg7QndNX88/nUZvgqxJy6sLeK840a357Rwr7TeIp1Q?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3KBHiGOk6E0YUqyzjBBL0xoLdx7BbxW3ZMhiyD7430SXM9Si6xm9+nzSayhnffo8nfKVZeclxATRfUWqZi4lTotfI2fGhFCxyGhf8nufNgwEaIugeu6JftTWGkDRNbPVCR2uj4rGqhH1ibqblM43p1L4c45gx45LOuPkR8djJYcWQzxhUJgWrrslD0iP365mafIwJjrKFz7x42onsHp8KqTh0o73EIt98ugHLtmfT+qFLZhiODpoKMu90vUJRygPuTNcp70SY774D8J+AkgrcHg+KjmZoInpTKeQf4UMXCXDVCL4SY5YAXJ6oMTzLgJIF4TbcedYsfKmvfzn+yLs5gns3fWsEKJbRdjNq9o9t6tzQY4CGsS1AkUszGWuMvw3aDvpuNsxyiJ4sA8wRWluXIVP07DUtFsq2AAd+1MMS50Ao+kYcGR6hEar51Ytvq6aTzNA94lmgiE4fNJSWMga87Wpd6v5P3pK826OjLJNI0xXClKBNlCmGTgriooFdFZPR9DTKudykZm7BeSny1pAo7aljdRYh9NtUWidps5JxPsW8tlOVY0VI5Ctl3kyloZEdTw2cebJHSZtkEgRAblHs1stof1G2N+4bFUxerkZ2+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5757ba0-82ae-4a9d-26c7-08dd8418a7e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:58.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR5B6Gv7QSfJeifJVojW4fFyRyVobUjR/3pK3ucOcUeKKupgsJ/MaSJR/xSSsvJfpZBiLZDXRa02+WyEeOZ6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: 779yynIuKvTKdDS5qWOeXEQgmw_SLqa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX+mLg1HX6Al7y QIpj2QItIJEnqRofxOXYRS5vXE5fNX9M8+Jbw3RxR3+WB+JNObxgs4QePSFU2HzGrrP8Z9Q2Y9w f9vhSeZsdVOHSWbdo6RN48uidZfw6dAk90lfAaBLSkeFZFMYj8PfezcNIgGKR37Ghw5x7k5pNmy
 C6kfdUMVN5bZbGbQLPKjc9LXIFEOxqQFQtvO4+F2ERX6IMGBT5rcQJTwsxb9VfYO/kFpdSuUdJK bjpCQj+vu1QUc6y/A8M6GpIV4f+u1llDqCkTrW7gUBuZ8cYGCZCek+QDQFxPAQp8Uhq2iX7ZPyq TROFb8EPO3n50fXZ8igjijrw4VaH+TGNWJTqQ8YemZrTKP8tEEzS6XA3HqJHUHFNbnz27jpewah aGijIFtk
X-Proofpoint-GUID: 779yynIuKvTKdDS5qWOeXEQgmw_SLqa9

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f4a66ff85748..48254a72071b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 77a0606e9dc9..8cddbb7c149b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,67 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_can_sw_atomic_write(mp)) {
+		if (xfs_inode_can_hw_atomic_write(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, xfs_inode_buftarg(ip)->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1


