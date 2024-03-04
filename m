Return-Path: <linux-fsdevel+bounces-13462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3FC870225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D141C224FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E24597F;
	Mon,  4 Mar 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0/zdSqi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H85MLe6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32340BE5;
	Mon,  4 Mar 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557533; cv=fail; b=AqhAkXS+IvKsZTu49K4Jnww0GDesv7E+6z1wybezbrUN23vRH3kcH/MHoLyee03CcgvLs8ifxNb6TjoS/bBIQrZWaWwDi/eCwnBlJTU2+DtEA7SlA8rixX2m2G9TaFCksGVkMJtXj6iEmZq1wqjocVFnTCpzgxVIGbaCAa4G9O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557533; c=relaxed/simple;
	bh=/z4sEM9vsl+vl1q8/4TbI5aNcm10Pk2ueEnPwk/tJuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=moVLBKud5/VA8sr/hfKB4oqCjcsI76gRholq4A2yx8S9tjvuflNEMsn8vAZBhAHdYxzwcINjByLSj62EncEe5+8Ap+ONPbWGyfyYxmQ0FTo3enogPjitnfljV1Xp3f4qdq7WL5x2R76tUJO+UJhl6WK+Z4cuUQahUxVUxgGWyxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0/zdSqi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H85MLe6O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTlDo006034;
	Mon, 4 Mar 2024 13:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=uL/AYD+j8Wm56sVAVNdKqVFkqBHuZvDY74wwcEjR92c=;
 b=k0/zdSqiwXaD/REFbOvseE0nop7yGlRIIQGJYSnyUFmgjiJI22Di9g0UZC51qeDkCbp7
 1+8a+O7vst6X3acmL1seT3g0lDP/mXuqcy8gQX4F1/y3p0FQdNhMuxjrd0JcRbgtlcwX
 Ns805NecDUOWlRl7mtcUyhID5Od1zQSdewwBlITC93PL0PoTBoDseCyfXjzDWJqKL9gO
 5Qfsrvee/VOTjEflJLSJaUnnui5Mnuyb3ncTtgVQXo8sxv670K2WmCN5BKBCbj9HDviR
 2tijDuT7RfpBGF43QK+JewTWBjoTJSnM96IQRkPFIRBZsPdhI1VTynxMt1fdAlV82RIO 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cbh7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424BBOAI018965;
	Mon, 4 Mar 2024 13:05:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qgxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9BH1q8/+MxmT9DC5yx3SR3ZLukCFeU28k6TKo6xIhUO9EHR+bsi9Eq+ommPl2ed7gWmeKsgshyVWKUgY2kMBxItyERJnkXVcY9Kh7BeRsJhzQKnh5oh2pXSf9b61LOulMXqt61UKKdkuxVAyH/Ehl1YD/SzWI7m46UIjlKr0lh4NN4AquNuzpWfidCPN/wKynFcaPqlv4fWCy1sI8rPOzpn9QfNtlZrlqWNk3kvDPoVlEPAyQv5bsC0IGMeKS4EaCBZmvQWniodcdKZScVgTFcmPpdb70vhh6uMcepvGvK0MNfyp6Il0G5dy+WnHD7Jz0iNX5Glpyr62poDXiS8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL/AYD+j8Wm56sVAVNdKqVFkqBHuZvDY74wwcEjR92c=;
 b=dKifVh6VrrJdR6a2ucm2ucd3JRQzR4h2FXrgPF19tv0aAOhWBWBsOTG7kjYmHXHzMb1lbf4IixYvykU5FjVAOXEVYo2sQ0KfbonMs3bXw7XrKJCiS2EUG9BwnSqI26DBLPA6E+9jtTnMplw+GpptE6nanOZlJ4S6pvLnqFFh+JDt/DQFuynpk1viX3UslXzmcFporhaR54SFL2HxhQZKBr+REsE8m+a5owKRT8FTNQ4XUfa5tlVae0JLSAq1OWerfHCaVOmXYiGBIr6Bc9UctN9+XWt5Ey6zx8VyGPqzqN7JHrIF2Eq49xjJEwybwoUkctdOtXWCr1Ao0BKIhDuwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL/AYD+j8Wm56sVAVNdKqVFkqBHuZvDY74wwcEjR92c=;
 b=H85MLe6OxIwPwMuRRnrpRiq3aLpeBI/JWIaTFdqF4GbGBIU3vO4i60bs6BM3Hr2MexzIvR7kb/RfQOmoTAA2opuzmbrInGwntJRT0ILFMUZYuvIY+sSCz4gUaioH/KYwKrga+N8Ml5eCedPcl0YX2fV3hhR9pbkUNOz7h/MNlrY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/14] fs: xfs: iomap: Sub-extent zeroing
Date: Mon,  4 Mar 2024 13:04:22 +0000
Message-Id: <20240304130428.13026-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bf7950-e820-4e23-84dc-08dc3c4bbb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LMhQFY0DcaAChZnqlaYzmpewnwVyrQKUrw5pooS6cuqr/3wCtRgzFZe5rIYFWQlobTidlTUf9+Cqakq72NeHz+ZD9AMzCyuTQ6ZXWk8U9FMDwNQjBhKx1wHBirit9ajlXjJhZynlYugnfYj4yYd2HSOEcL0YguCStNGb/53iFCwGvN2F0Yek5baeCGziAT+MZ67ufymG6wSfm+AjY7JiEs3Q1OL2ullH/zNyrkq4QotlzhfhBs4TSA5tR0Iic6JdSKoaqltYydv+1751QlvMtLraqI1vlkpR22QUCI4SO+gUdCYRCk95eGgEbVgYDSVsknpr1z22rJairTn5KN2aoj5yzubUZB4YHEWORCvKcr0aTEqhBt+YN8hX5ETpWPBza2n1GWslpmJ3YzFt4J8sjKvcherKymXEhEj4Eyy1tRTxHMiU4sC3EB4CyQpH1TEQJeC/GWpJJV1Tvb4kyhhqea4td6vRsj9ob9Xi7fjhUx9fB3hcv3tY7MMJ7tBfM6YLHoMuKGKNMZU7/+rVew7vrbQyROkVO9b9C7rMX6ZjgleFjpnKIhZJxOD9DPWMnKuLYx1axPOF0/D7ZxbneLa85HKxes81BFEFRNfnSedohEe5AvY1IbSsoRbzweqlaeZ0OgnttVrJ/3BByrjYAD5tHoYdzqhpxDPfgHIGYMu2dDc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OPGEKnwU5GVI87FnhPP9f6FnxVFNMKbjLuSNDcGcu6L09gCypcBNtcJM/ulT?=
 =?us-ascii?Q?dhmmd/oVircte1/C6tOQsYNKZTYfRhDiv+nZF2B62sF5wV5wfqlYSWjWA/lx?=
 =?us-ascii?Q?qXjYV3sGselAfNn2iLyrcmjEdWtgjfvYMfN4w89zWCIgojH7AqC4Yt0PxE9m?=
 =?us-ascii?Q?QGpOQvRguKFtLLdkt+8Jw4NbSIaH1bm5qw1gD1f6M9bh8Ota0CGW1AK9vsdS?=
 =?us-ascii?Q?50YpgeA2DUvboZ75Pe0RdQMcovEBXQD1TvU65rlD7rYaYO3dSCUEIH7EEZNh?=
 =?us-ascii?Q?aHTi6nANIalmpfVy+5+RlHKFseHr4sYu3d8jS0t6JdKg8iUctdp2EX3BNWeJ?=
 =?us-ascii?Q?NFYNg1oFgarSZ4uMnLdYb04vVTHYzL9m2KfSbf0FiKJ0AT+/VqbKnhPwJlou?=
 =?us-ascii?Q?EebO63HVIPevX0+XCOuE2Xvar7dT/k+rlbG+Dv3MHnUN2pYV+K1g7yhaL2NF?=
 =?us-ascii?Q?pRmpVgQ44Rsk1Q10f7vC3KxCqtv5SQuXwUoVGEhx1vFt7TN6mf3aXxbLzuId?=
 =?us-ascii?Q?R7dEgCBj8RecaDYPIYyNk+q5clRTcmuqEU7ss95G5S46uM1HJUPM8cMXM/Zd?=
 =?us-ascii?Q?W05/jrvf3rg4pg3OZvKx5GCwqw55XdAMo+gvAYVk36TnTD2s6nEdUWzkcPQ7?=
 =?us-ascii?Q?F5ZjjSQyl8b0tC78AsGI2QlbjwgJBSn+6nMkMaYo7MUm9skcsotEAAiCRQDc?=
 =?us-ascii?Q?vb7wIfREqOSt0A1PDiNd0wJB+fyssbZsFUN9rOCAizztCwbu2UjHahxPC00I?=
 =?us-ascii?Q?wp+S4Xh8zfu/nOq0hWXWO7XL2FGveTsALISJE0SagCX8oDtb0R95VhNzWFlF?=
 =?us-ascii?Q?YsNr9xW14R1nKwbs3Q/JNsROoINCAp/Qak3tvE8ci/dkTVCRfgw5ec/dxvlo?=
 =?us-ascii?Q?NrP28IpV09d89sws0z56coMJp+SyyuOYSBKJUx4XeZz0P6LW0IUMPUzTd884?=
 =?us-ascii?Q?oiPy8zAv76MWGsMvUqwQRLaK36UT0G7YL60RK4j5i0I7eSUNUf+keMHr+tat?=
 =?us-ascii?Q?HMmkR5889tu5jcSX0/unT6NfaFQ2rmd3sFtnOvN6gTFXXxWQR6YJKf9Gnz4v?=
 =?us-ascii?Q?Ieimp0YmzcSwsRA/Glpp+RfwN7aKXQ8OUyGL1D6quHcVxueVTtmUuw3Ou2NX?=
 =?us-ascii?Q?iBWUFbhvXqje33+6/CcG00J/H2qfCpx9s2xOK+opfzkxttQOTxCcyvrOp3Aj?=
 =?us-ascii?Q?zob24pdK6gH442hb14MczJM4i/FKiAHZvR5bZ+STqGwHJ0jOsENbi9yiZXq7?=
 =?us-ascii?Q?rL0XA2BhlvC1viv8C3TLJekeolRuKKgJ8z5kvdWE8iJ/mm+FJkQIasvAGRDx?=
 =?us-ascii?Q?q1Nrq2sjmECT2QUXpj+i7bi+dChSUxlq5jHBALaWHxEQCyxNam86/jc4UoSe?=
 =?us-ascii?Q?NwA5pGdDiV8w+LR1xNU7N4dE/n4KKikYrIs5Ng6BgMtMFzu3NEAIVprNBXCo?=
 =?us-ascii?Q?8Juh7voO+3FqLRDNXTzA05beR/9Rq4c6cYghXOkQDG4bygDPMfydejmWRkIo?=
 =?us-ascii?Q?S9rdE2sHs/fEXkLsf2DZLWj7RUX4UqWwn2qmbHp+WF2Qy9lhcx4l2kWi8a/C?=
 =?us-ascii?Q?CgDkirNgsQf7djl3/iR7n3qR/2eUL5MxtN/rA/kwWVRgoseTSIQ39Cn5NCJK?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7iVSIzggI0FKDcDoDbj8+ddm3s3bbY/GGiFvHGkHK6z7Yj8c+fN/YWbePKqEkRSUV3dGKGqCYIF8beRB8YnHoi/Qx+ha72jj7tFqJajXJGDKeHpzx40vFPR1tvvjamPYViePvk+p/UkqRT+UwydO1CyQAQ/ztp7Y7eIvkF1ONo07gC7nfcooLdGsZg1a3Ik7lM5lhDijcYd8PF2R8Ck1GRDigKdjBVyKw8veyZIYt/2Qji9ZCotpHjKbiNUWTjKoa6aAdUB33HEjgdEG02TPmAw3XH/cr68p4iV/CippIFIs/HFLX6sFD7yoP7LXU9uR2v8YtNS/iHvr3hhM07jJPWtuQomtqV5D6T5f6dggbWl3DLsTm/701JUZDx0A9nOnbM6L/9+DFErSO+jKvpv+aBhiGdHHO2pztcy9Ye8NFbZ0RNE49mzwEW61X2U3o/AU3jG7VVTUCFSgDGr6SuXouCOqjjbnE1nfgswXmy+UjkQeCQj5ED4ozYQRmBPOnThEypXed+zAxsAT51sF0FV2ruekoyEnKm25rEs9iSNixfdMQ+Jk1LF7f4GtvvWhvb6CT82iu2InuEtYWM6bIxg/JjNSK/QFZXpIHeLtNeidlhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bf7950-e820-4e23-84dc-08dc3c4bbb9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:14.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqNGMyOf/Ah9kXQ3rXeKgi8SGnW0lTztFlFSAgyc/6Q7apEn1iOJWcWkPqbNOW/vgjUJyuhTYfjjOTGcZxmnDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: e8lg22jpYYc021IiyK1Mvmy4VjYVbQzX
X-Proofpoint-GUID: e8lg22jpYYc021IiyK1Mvmy4VjYVbQzX

Set iomap->extent_shift when sub-extent zeroing is required.

We treat a sub-extent write same as an unaligned write, so we can leverage
the existing sub-FSblock unaligned write support, i.e. try a shared lock
with IOMAP_DIO_OVERWRITE_ONLY flag, if this fails then try the exclusive
lock.

In xfs_iomap_write_unwritten(), FSB calcs are now based on the extsize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 28 +++++++++++++++-------------
 fs/xfs/xfs_iomap.c | 15 +++++++++++++--
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e33e5e13b95f..d0bd9d5f596c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -617,18 +617,19 @@ xfs_file_dio_write_aligned(
  * Handle block unaligned direct I/O writes
  *
  * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
- * them to be done in parallel with reads and other direct I/O writes.  However,
- * if the I/O is not aligned to filesystem blocks, the direct I/O layer may need
- * to do sub-block zeroing and that requires serialisation against other direct
- * I/O to the same block.  In this case we need to serialise the submission of
- * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
- * In the case where sub-block zeroing is not required, we can do concurrent
- * sub-block dios to the same block successfully.
+ * them to be done in parallel with reads and other direct I/O writes.
+ * However if the I/O is not aligned to filesystem blocks/extent, the direct
+ * I/O layer may need to do sub-block/extent zeroing and that requires
+ * serialisation against other direct I/O to the same block/extent.  In this
+ * case we need to serialise the submission of the unaligned I/O so that we
+ * don't get racing block/extent zeroing in the dio layer.
+ * In the case where sub-block/extent zeroing is not required, we can do
+ * concurrent sub-block/extent dios to the same block/extent successfully.
  *
  * Optimistically submit the I/O using the shared lock first, but use the
  * IOMAP_DIO_OVERWRITE_ONLY flag to tell the lower layers to return -EAGAIN
- * if block allocation or partial block zeroing would be required.  In that case
- * we try again with the exclusive lock.
+ * if block/extent allocation or partial block/extent zeroing would be
+ * required.  In that case we try again with the exclusive lock.
  */
 static noinline ssize_t
 xfs_file_dio_write_unaligned(
@@ -643,9 +644,9 @@ xfs_file_dio_write_unaligned(
 	ssize_t			ret;
 
 	/*
-	 * Extending writes need exclusivity because of the sub-block zeroing
-	 * that the DIO code always does for partial tail blocks beyond EOF, so
-	 * don't even bother trying the fast path in this case.
+	 * Extending writes need exclusivity because of the sub-block/extent
+	 * zeroing that the DIO code always does for partial tail blocks
+	 * beyond EOF, so don't even bother trying the fast path in this case.
 	 */
 	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -709,13 +710,14 @@ xfs_file_dio_write(
 	struct iov_iter		*from)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
 
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
+	if ((iocb->ki_pos | count) & (XFS_FSB_TO_B(mp, xfs_get_extsz(ip)) - 1))
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 70fe873951f3..88cc20bb19c9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -98,6 +98,7 @@ xfs_bmbt_to_iomap(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	xfs_extlen_t		extsz = xfs_get_extsz(ip);
 
 	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock)))
 		return xfs_alert_fsblock_zero(ip, imap);
@@ -134,6 +135,8 @@ xfs_bmbt_to_iomap(
 
 	iomap->validity_cookie = sequence_cookie;
 	iomap->folio_ops = &xfs_iomap_folio_ops;
+	if (extsz > 1)
+		iomap->extent_shift = ffs(extsz) - 1;
 	return 0;
 }
 
@@ -563,11 +566,19 @@ xfs_iomap_write_unwritten(
 	xfs_fsize_t	i_size;
 	uint		resblks;
 	int		error;
+	xfs_extlen_t	extsz = xfs_get_extsz(ip);
 
 	trace_xfs_unwritten_convert(ip, offset, count);
 
-	offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
+	if (extsz > 1) {
+		xfs_extlen_t extsize_bytes = XFS_FSB_TO_B(mp, extsz);
+
+		offset_fsb = XFS_B_TO_FSBT(mp, round_down(offset, extsize_bytes));
+		count_fsb = XFS_B_TO_FSB(mp, round_up(offset + count, extsize_bytes));
+	} else {
+		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+		count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
+	}
 	count_fsb = (xfs_filblks_t)(count_fsb - offset_fsb);
 
 	/*
-- 
2.31.1


