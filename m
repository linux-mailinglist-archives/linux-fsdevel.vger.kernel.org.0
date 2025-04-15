Return-Path: <linux-fsdevel+bounces-46466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81788A89D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA831900361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB8296D1F;
	Tue, 15 Apr 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WB3/3UlD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sw6z7YTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F582957CA;
	Tue, 15 Apr 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719298; cv=fail; b=XUfLdXbT3hbAKrq/NTEnfeAzY3W8GehtYDMDXKxdUffDYxLxw1MzhQ9tgJ+whdiVwsz+lzxaOFUC0nz+OgjYVsyi/XQ6JNcZl7G96Eo//NUKHZswOO+iIzqu9T3SrZv2s1/0B+P9Nm/awz6HhsonG2M8ddL5JcrHifGLmHr840g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719298; c=relaxed/simple;
	bh=9Xgx1Hv1lai0fikKen51k4XhUSxwVm4BtAuZX3LbPv8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nO+doqK3Y3xGp8KILkKv5Od2OsDM3yX4Zz3OkXHrsNJE0nFgrr72lnCm5hO6Rz1qHMWPL+JtZEIEkoc9Gc5biJP0i9rzQjii+473Eat03dcaQmfvCtV0T5sVzHjvkG+qLDjk0ZnBx6bvqlAJHKCzDnlXhdPlHtTI+ILABOJxcHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WB3/3UlD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sw6z7YTz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6gHri006834;
	Tue, 15 Apr 2025 12:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=rdQ9Tw/VdBcOZ5KO
	oroXUOlo7aL/5LKYUB0uoepNbkk=; b=WB3/3UlDQ4ZCvRpmGV2IiM1mmv7NUZ26
	u4Cr/W6QUd1hxRrS0a/GyNxRto6q8FhuX1xv/0bQHt8NQjkGryTgyVP8r1J0VEJY
	lYzh00ROGoDzUit5tzER6zFZZVepjKdJX+JsWGG5v+In6J+20UD22tJm0Dc0m+Zj
	e9/yNawXuud9HUFmZmNAPOxT/i9tH6O8/s8NX8SJDNF+W9vjMvNWVdm9bzL/yR4S
	r0xYnrLcOYtiXFpe1skxWm32aPs9y8jMkxS06+7Zdj2g2/IhSbcLUL/Ju9lQxooF
	+56gZz7t3lRiC5hyYzzcQYmqQNwGQAwK5fEJ3Frq31UX6KHoGPpUMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xsfb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FB4m7J038808;
	Tue, 15 Apr 2025 12:14:42 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJngDZ+HifEB0SmGUVNfUqAmAqccwpNTQL7m2uugy6f4k3PCkPgPxGa3b4PmUmrpGblzE60w/X+ZxiRpNtcj1wsrLjBI5wPRUP8Nz5FbbQOnEIAU4l/cdBTtdzoODDiTpcROMzvOR+r4aYRAw1a+CDFhzLGm5+pep0A3UBtM2nuc+YsWfwSu4GqAgz3Glv5tIXWgv3a7N3+Cw4Vz1niKr/eK5Hnr95SS63UL3cZZGbDVBUprLUxirT9dt6Sk1o+5dF5ljyZF7bynf6Y+CcmLmWZbdTnZQgVZsmRKytWjUt3Sxe/nh4sYc1klhGu/7b1bFUE+8iMrufUBGtdgdxnmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdQ9Tw/VdBcOZ5KOoroXUOlo7aL/5LKYUB0uoepNbkk=;
 b=GkSHFlkmyOIJqOATgPOqwQjQ+94PVOkDSUhhbBXXhZMudYMHxrI3XcmRoHiSRk7BdMROD7eJxeDs8WG8BD83bS+GYVNV/3l3PkTOgb6OdsIv+/ToFVdpgHLH+0opsHG7wR4Ag6lAhr0iP1GdunUhyJ+q2Q+SNtNxwcOEjX5d0me+WFpDm3bXiBjXpliO/1myIt5AZGflFdjdWp/KKhEhUJOuGMrJfO++g/L8vE8yyIHL3oonPRdQzF0Nk1wxteJBjBqW7FGe6VFBVq995ub2KzyVaIDfj1pfelT8+j2mg09mn1G1FRWiJy4IXqV/LVaEtCTni8/ugAh0BPXOoSG4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdQ9Tw/VdBcOZ5KOoroXUOlo7aL/5LKYUB0uoepNbkk=;
 b=sw6z7YTzw45sxutfxSFkjbac3xd0vpmoP6YEwWc0GoGtMuThjtkM/zD63GI0o3rlmvrJvzceFxeTSyXPaIfMVC5h/JP0uU940cnC5FjnhYV9QUtSlM0q2tLmB7OVWRoWeYecXbMdIySed+8mW9l8tFDmPy2CBJ5RWXG8anGKq5w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 00/14] large atomic writes for xfs
Date: Tue, 15 Apr 2025 12:14:11 +0000
Message-Id: <20250415121425.4146847-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: cd30a80b-5556-4b94-49fc-08dd7c1718a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r1jIJOYBXvPAIpr0KcnlyvF+l9BVQOcbo72iB/MnejtTjPtxGnLCjWwZBNno?=
 =?us-ascii?Q?U4t0zPrTlfUw6L2yjF7nxVWNECY9uZCm9WO4AzPg6sjFe6pMRK7c0/5qKae7?=
 =?us-ascii?Q?UDO5KIShhgKsJbCaHAemuVACokqxEjR8MQSGLkwBOVXX50//25U4G/WwMFxG?=
 =?us-ascii?Q?q3DlDR9WlXPITCttaxFefuU2Am0l1kR7WXAnlSnzIY1t9Z5Bky9LOve+O/94?=
 =?us-ascii?Q?wUOQgIr9Ke94Trbo4uMgNdKxCjtNfl9yRmrGN5k/kVvMXh7hkByFNSPceoQJ?=
 =?us-ascii?Q?nakSeJa3rzGvWTLRYwHGWXE0VyhHWacQWSb+E5Dm1zZk/+bqVZYYNAQkFdVH?=
 =?us-ascii?Q?cQaQI/Mi61CXlrivL0EjK45fp7HF9tOEV+fmcm8/WsTtePY3rYJv2jLU2k9m?=
 =?us-ascii?Q?WXgdP/ml0fwP9oMbE4/wEIPCo6uzrxC9W57BPU85O0zB9LM2xj9ljepqKt2J?=
 =?us-ascii?Q?Kw6HXDiumdcQLDwPHbkF4GGxKR4iDql6OyP/WmyRF2o7rBHX9W4DwIwZjMDZ?=
 =?us-ascii?Q?FLS0+sxtsnddFlxBD/qvjl3R0zLCv85D6+/hcLRyJUnIcTPtTXYkQN82yt5U?=
 =?us-ascii?Q?26trqmRtghj4x3dzwogcM0i3gCFhPp/eIx1YL8mxZNbbfBNadSmztaVlm6JO?=
 =?us-ascii?Q?pgPAiIma2g2dtQkott0ueiCqSyIzwI2D4hinyn7fJt2wDsxqVhM1OiOZjR2b?=
 =?us-ascii?Q?uMVwFqHhBxdQkZ18MUAHJjSpNKZ61BB9HWgTPo8e3R+pFgsB//W8IdE65Y11?=
 =?us-ascii?Q?x/0RckuTlYD2Ndx/TzM4vAyCwePPe4u1dyCq7DbHIFHaC9ZCB+sgkWQ1io88?=
 =?us-ascii?Q?oiiPODk731UCAyW2BZJe+HP+UpQTIwOOO+2+p/QEGSFk5uZ54co1eEYZ0qjv?=
 =?us-ascii?Q?/qD/YXevyhO5xpI4g2bmplGYR2YGvAe7bQ8EOtLNCPUnbSi3AwMgXHKyo+H/?=
 =?us-ascii?Q?LqfHuop0kJHZ3T1qQZW4j4MZO1qyduLLwgHUdsVRfVCeD+kp0sOFhSt0PUq4?=
 =?us-ascii?Q?mufeLOm+7q+girdQ9tXzwNB5nCX2bbQS48pDuh6QlkvQbcecS2/3YC6WDYxq?=
 =?us-ascii?Q?pDFuqfNynXNnneJK2PgyC0R2PfLRpFDmdTElibZhdmaXcfDSVeBJ5ovM4wgo?=
 =?us-ascii?Q?onluh9jThOlYgTefKeEjQ3Uekzdi9POYzvO4ICJ6w3Iy02Mjhhvgy8z6JMZx?=
 =?us-ascii?Q?rxZkqU9L4mVAwM7cdzNvHNis5R2DbZP1uQJ8lrDocIl8aFqpIKNu3gjbWZpk?=
 =?us-ascii?Q?uur6ZOYwNng91KKCGFEjmiepVARR2omVU0yvWG/USBSlQRVd7XAqZfYCX7Sj?=
 =?us-ascii?Q?OIwRAmXxHauHV7l0g82DmfkU9/eQUCuX8OPu2eoytTxhYPbogBONLzLtMA4T?=
 =?us-ascii?Q?kH75LOauu2obeFiUNFIxOWUG6XfCQUa5yxRz5hiQC1KOhxVNtQyfz0UG7JC+?=
 =?us-ascii?Q?VNkMgp7N2hA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvISUfOVczRpUDai9NiIz1c4FQf0UPNczUwJh2r7hTTYsvcqvUhdvqVgUgrE?=
 =?us-ascii?Q?Db3ojqmQJ42HaOYd+N0jM+bnA0R+bwCQBhnhazsGBc93kj2OnN2FQUdBRaEB?=
 =?us-ascii?Q?5QQ28ewdmJeQP+c4gugj+BQjjbdw4d1aXqLvzzI0FA/w/7an6e+3/vlHRqIB?=
 =?us-ascii?Q?z1MJjZACD4aWjttjaFKt766/KWcExltHJt4m1N6xwUL95l/Moy4BmZvpHT3Z?=
 =?us-ascii?Q?rg95LvCHGhUeb/u6nQwEwEEvoSg3mG+gAitFuJ6gfmvP3dQiquMv/5yLJywN?=
 =?us-ascii?Q?k7mUd0IkIGngtWP9vZDFgZtVy9MnqajSWp3whMCQa/h6kg3x8+ZxqbXUBXYI?=
 =?us-ascii?Q?pDIOGGijiYV0vAL/e5GJ2LTMXQ7I2XM7du/BzJ8x5YeCHf9syqSmLBdwY2Kl?=
 =?us-ascii?Q?v2iYJVn5/3T9jK/fzpY2FE5sA2NZxGm3VYPzjX5I8gMsmZfG27YTjhmW0JJL?=
 =?us-ascii?Q?fH2nbYZmL07J1gt/ZEetaRJy+gQgM5qojaVpChQY4ombHETcOOn0w6DHQZFw?=
 =?us-ascii?Q?R+OIbK35+deNOTT5/f+mRnAr7P1ABvN5KK5lPJsnliRBWxAbKpZZ2IOh2+LW?=
 =?us-ascii?Q?cl4oeAcZ2gXivOEtRWYb0jq6MwDUC007rATXOlnBYQ6DlwKPwBbH5fkgjDOm?=
 =?us-ascii?Q?wbvC5r2g7ogX/Rk0oM4hQIkN06fl/BSyC0YnDyX0F1gaVUHvhbflQetXN/QZ?=
 =?us-ascii?Q?dklfWTl+Loghd+W6DiktQImWnt8DFsyfHLu7NxCLYU1fG0RfalHI4rIM9+J2?=
 =?us-ascii?Q?g2XKSj3MRJbC/RQ+y+vMhsi5veqjscrxJUNM+P1dZUKGNHghdaAYxXXrO6V3?=
 =?us-ascii?Q?kbo/vqYlDHxnmGKXbSw+lsPEtBCbqU3B6KBM2E1Pkf5/81Gl6Dj3AdSixBia?=
 =?us-ascii?Q?WWCQRS4LYkpvRk117yWwyyCsWGhNK14zCzCnEMRDxJAkqdm4ksc/x4+mCESV?=
 =?us-ascii?Q?W4p3F9KpfohFZMTbb8fZaANKOcMPPLAaAIghu/9oOps/vFean3z790kNb4J2?=
 =?us-ascii?Q?d7PuUUehRzMAXnfznussBVnqcmqJm90/ek1xiN5vflVCJ2gc/uM0+1FwzQyZ?=
 =?us-ascii?Q?AKAosyzWG5qfp5XB/3lW2VBvmBOXKu+QaCYGfqVSROgpI7Nyyu/w9M6tKvZ4?=
 =?us-ascii?Q?lLX9LubM/XIUD2mLRlQIgXM5soLAOnNYGjbRdSKzANNLT5CA+4Zs2B5aG9d1?=
 =?us-ascii?Q?CdpEyFwMT75N/My7M2PnSjtOJfiVrCZHbna6oTj0ATL/IQMI+JwbbYmPjchG?=
 =?us-ascii?Q?Qf7aJYMlb16dfRhuuPyA+g0i2NM+I0EpJ8taYxef/PFjLCYk67fy98bkiiQK?=
 =?us-ascii?Q?oW+TPMwlkLV8TFsVQLgn3FybP2D9n7r5FhtLQXDSBlPp3mTma7ZBaAyPXWug?=
 =?us-ascii?Q?IVWcof7z1ElAY6o63nrQBX0+0S8kgG3fzvSL4HiHLU+OCgVsaLYczHaMB2As?=
 =?us-ascii?Q?Nn5ocKoTA/ZKuB0adVLoV/LCsFDCpa0mRu4zPZwHk/2s/qsnndja9LKqRfbE?=
 =?us-ascii?Q?Ji1x/MlhQQF6rIrcvs/4T2Po/en4JLUTZ4ZFDCjl+fzKoBgIlq0rkI78SrdO?=
 =?us-ascii?Q?n/jIAnKWYgyN96FqnEgk5RisPgjye+7jakAI/fkbpTJFXGVGn7Eb3f5FRh/a?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3GOV70xDQ8Jz5qI8q1LlvhuEQ5xlO6PXWrdgv0RmZHPF3S9zo99QVdjyKBETj8Cdr4RCIJRloFJKpOMswXyM1JfyeTDb7344j5KWJsJhTmncEgUX6QtWiQOYVeU3u3Qs8jWq5LqCiQ1UE/VdqEAumwgEmT0MIuI1TPE1hp0QlOqvzRwzOMz/T1+t10P92QyRKxrbI7rG2qzuaRqsBuKGCAG6fVPyc/0udWIps+nMjhXLzA8ocKMTA/LLFZBWl4iL8LEHHXbsmsawI0uLT10Cpzaqo+UWCDQX2tNhfci7DwYJvyEC+9PiG4nQXgTA5qxEh0fNCNeDQwyXPzJ73RdxUi9GqTgkxXzdvlr780DJl8eyOJctS6zd80jv8tZe/n2fZxV3hhnQGGsmERcDNWzfeKbpKK813OEjvqVC9v10rxIKi4xqa/71k65mY8dqUv8LrKlew3VplpdGhu3jLupYjKkj057rU4FahpQBGiWIo8MacAUEYmhqxdyEDracQovWQfmlBkiWs8Y+XQ4LXFWY/KLji3+oADKEVkq8jdC1T/0Xqmkd7J0bfYIxFA+E4NfNzeHlsfT1tHAVJgCo3zz25vMjNxWCxGopgKv+vs0NbYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd30a80b-5556-4b94-49fc-08dd7c1718a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:39.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ef9VTAZGWy3/clGgFuuDyok7iwJnX8M4hCRdQse/3uFjclSef95ZDR40IfT/VzGUqeTI5CRFGoBaD577VPzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: bHLQUczZgAcJGNIkTF48TcgztW2_v_zC
X-Proofpoint-ORIG-GUID: bHLQUczZgAcJGNIkTF48TcgztW2_v_zC

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

Based on 8ffd015db85f (tag: v6.15-rc2, xfs/xfs-6.16-merge,
xfs/xfs-6.15-fixes, xfs/for-next) Linux 6.15-rc2

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v6:
- log item sizes updates (Darrick)
- rtvol support (Darrick)
- mount option for atomic writes (Darrick)
- Add RB tags from Darrick and Christoph (Thanks!)

Differences to v5:
- Add statx unit_max_opt (Christoph, me)
- Add xfs_atomic_write_cow_iomap_begin() (Christoph)
- drop old mechanical changes
- limit atomic write max according to CoW-based atomic write max (Christoph)
- Add xfs_compute_atomic_write_unit_max()
- this contains changes for limiting awu max according to max
  transaction log items (Darrick)
- use -ENOPROTOOPT for fallback (Christoph)
- rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
- rework varoious code comments (Christoph)
- limit CoW-based atomic write to log size and add helpers (Darrick)
- drop IOMAP_DIO_FORCE_WAIT usage in xfs_file_dio_write_atomic()
- Add RB tags from Christoph (thanks!)

Darrick J. Wong (3):
  xfs: add helpers to compute log item overhead
  xfs: add helpers to compute transaction reservation for finishing
    intent items
  xfs: allow sysadmins to specify a maximum atomic write limit at mount
    time

John Garry (11):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomicwrite()
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_compute_atomic_write_unit_max()
  xfs: update atomic write limits

 Documentation/admin-guide/xfs.rst |   8 +
 block/bdev.c                      |   3 +-
 fs/ext4/inode.c                   |   2 +-
 fs/stat.c                         |   6 +-
 fs/xfs/libxfs/xfs_bmap.c          |   5 +
 fs/xfs/libxfs/xfs_bmap.h          |   6 +-
 fs/xfs/libxfs/xfs_trans_resv.c    | 315 +++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_trans_resv.h    |  22 +++
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_item.h            |   3 +
 fs/xfs/xfs_buf_item.c             |  19 ++
 fs/xfs/xfs_buf_item.h             |   3 +
 fs/xfs/xfs_extfree_item.c         |  10 +
 fs/xfs/xfs_extfree_item.h         |   3 +
 fs/xfs/xfs_file.c                 |  87 ++++++++-
 fs/xfs/xfs_inode.h                |   2 +-
 fs/xfs/xfs_iomap.c                | 191 +++++++++++++++++-
 fs/xfs/xfs_iomap.h                |   1 +
 fs/xfs/xfs_iops.c                 |  77 +++++++-
 fs/xfs/xfs_iops.h                 |   3 +
 fs/xfs/xfs_log_cil.c              |   4 +-
 fs/xfs/xfs_log_priv.h             |  13 ++
 fs/xfs/xfs_mount.c                |  86 ++++++++
 fs/xfs/xfs_mount.h                |  11 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 143 +++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  28 ++-
 fs/xfs/xfs_trace.h                | 115 +++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 35 files changed, 1130 insertions(+), 90 deletions(-)

-- 
2.31.1


