Return-Path: <linux-fsdevel+bounces-44563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22AA6A5B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B07AA7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D464223327;
	Thu, 20 Mar 2025 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TfoWCJvq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d+Ax+k6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F922222A3;
	Thu, 20 Mar 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472213; cv=fail; b=sUYOdB9S6+s83sQqyXK71GoTGsLmJg5OOa5LI/CM+BcWgdtMrrHxIrzeARBn5ly0DdkvDuu5unmiNP843pzNXOcgdOS1XJjNccLujhta2TTgGWLu8xYPVg8ZTet8pF3vaZQn9ONHFLtBeiv54Y7uZNXyIOsQo0/v3QYJRcQGDG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472213; c=relaxed/simple;
	bh=gll4mXY9xMW+IMOPPjONoh/+hvoWNLDxvqkg1RCzakc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILnaRaY74HU7R6mcfRtzvWFqtJLRhtQBccR5C0mKpG5ulXB4B1yA8lFhbtC3gVdRAXwIpcBHTQN1o+reHNBvCrUnE5plmeBvivotzE/7pwthHAze1IfBcyzSoGoO2t0+Yh45N2V6VzAejPqfD4QG9NMq9Zg+AtDbHiCUgjEcaYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TfoWCJvq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d+Ax+k6A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8BvFq012018;
	Thu, 20 Mar 2025 12:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dmYTyYJlXkzJr46SQ5OrRSjqjWBSvhiumNVdpJuL0tg=; b=
	TfoWCJvq8B4K4GCZKjMq/QxOtU3TeDHCQ4CyDEbbWL+KF3zl+Tu50dR0kU5/RChB
	/cjRlmpayk9NEuwnIpbhDfvHFmBxEAPI3vcHHQvFcUtxwuYAE/thpCrprXl+9hFL
	pi47hMM0E4EdWD0qxXrb97DcqY5L3nTMLbuKRyYmF2Peib+C8x6svtoNvYeVuuoq
	hthejtHVslGHKAv9oecOq/bS954Djwc1bhCteocPotbQmPHp6GlFmE7d8wOkmkKL
	S0WBWLxUPmT3uuED4OJc3PYUMBz9MNxID2zCH2XaYw2t7arHvoiOEOj29m7FO3jD
	GMiIRp5zhvZiuNNpIuASUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8x02p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAeP9a024475;
	Thu, 20 Mar 2025 12:03:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbm9xdq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzSxQX9cVfRuzPp2woXJwAK+GCjlUceee6ZXtQGwwapTbpqZexY9goI2rxEtA9MjvJbVbK9eRbUR1VDcPKfd2DGyTLH8m2KumtsK84cZOvS3P4+TooEnavgZFe7EBJyJGZSc4zPy9Uon4BiKyg4UjdXD0AC0k+CaqC8W2qJ5Y9aKQVQi48ZgDBuHRxYNSX8U7LihUGj+gd7z7SncwoNJjYTFh2Jdeh+YXPeKQX4zRk2qppEsWjKLhjnzwVTqPwRbTVaDeRHKkmhKuSLtAnY2fLWDvF1FblgXgIx/nNzTsIuWzeNa5WFoKy4dTWoF7WwVqAsqWVHfM+IKyGuN2d8NYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmYTyYJlXkzJr46SQ5OrRSjqjWBSvhiumNVdpJuL0tg=;
 b=V2ewTeZBXHkVC6A2vS1Aq8HMjz6ztplGZW71vTCN7wDuviLp+yBI2yY8YN6n3J0sLsGAa2oa/OBisnosFCmpwp/m6DOAI3jxwg/s4OLcjNHaT5TmlzjSTGTbJFdwuChqBhKD0Ke2pcp4sCnzFQ9ci9CquYKA/sAWE7glV4T/3lLQIHN8W1juIYww9Vqt3Vp2TH2HOIlKafxuMwFnDNNRNxqH55TQa9ci7/sYcubrJ3DjoYoQbZnMy1d5gwfyTurQTMl5xbEBsWlm4WQXVfyh5yQeTM2UWhQKex2sfiiTzEbRP6LnfxWs5qLbJ2nV15h7aciZO1NCYCHTrmhQ0egLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmYTyYJlXkzJr46SQ5OrRSjqjWBSvhiumNVdpJuL0tg=;
 b=d+Ax+k6AoyJ5F6F+Jg05v0hk54/BV9yS5NRJz0PEQ4MQ0Bjd7EH4HVY2yHob4PSKGFmzyQsMux5YY8R7SgbWcYDcMpvGupxlPO9YTLkUMz+NWk/KnEOA1vmMNyhannJEBskXh+rPVgsaYNO5/gz4pwtGafaU9MkZeEzTt4HMI+Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6902.namprd10.prod.outlook.com (2603:10b6:610:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:03:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 12:03:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/3] iomap: rework IOMAP atomic flags
Date: Thu, 20 Mar 2025 12:02:50 +0000
Message-Id: <20250320120250.4087011-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250320120250.4087011-1-john.g.garry@oracle.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:408:e4::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 197c688c-0608-4465-a866-08dd67a73008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ZvxB/jDejYRtYxZVeHhU1I2T6OAGPLrtVGDri8LQ9ih+LVWvZZhW6RWdMEW?=
 =?us-ascii?Q?HdAP+6QCoi+IS+J9ncu9nzehDDem/dFsA5FyZp5LRjwsoavcWOZLywR/q9be?=
 =?us-ascii?Q?72A2Au/ZxKtXa17DGeNipZ4ESfeB+3nhtuQ3P3CcwrMzVgAufS+jgm/8KXAl?=
 =?us-ascii?Q?dCXMQoRRSRBO2iQuQQU6KHtpAHMFFj7d/Ki0U5uzJybcMgZsNh+7Lx3R981e?=
 =?us-ascii?Q?oMTIvttbilcuZmJe7fIy8zSYWXVjfSTqQ8dZzmmZPT9IucF9h7bsF2tvnAM5?=
 =?us-ascii?Q?StmuHrew37f/fuRpHXoEb5Z8gXpCr0rGcRRZu3a62KL5CDNU2jsp02VkDJZy?=
 =?us-ascii?Q?Yf2DCf+CYlmLTicr1m8/b+Pm9Z7HuhmnnL0lHYmLeexvKol8gqb4qZnmE2XH?=
 =?us-ascii?Q?rY2l0QeAWnABY/VBUkJFo88wSfd9owJKFRITx6PtOVBCgdXr25GTbELH/Nw4?=
 =?us-ascii?Q?aYTKamDyahssbdlzZuSwAfMUX1YqB+RHzulQjF61GzBv2HbCzVxtmYNx2Z8Z?=
 =?us-ascii?Q?nxKv2cP4FSGTseDxjevLh64aIefTJ7C7s/2nZEHAzm4VdN+dt2rmrRa/OM2q?=
 =?us-ascii?Q?kgCF+xUOUq1Wdh87i+ttBdk4ibOieyeOASSYt0gGsJ7CnmFvm1Bv3+ykESnG?=
 =?us-ascii?Q?Qd4k8zN+zQMgHaMGBpFbT3RLiHMzFGlg+KuLnLTYx3AlEVTsdvN+hpF6UaRy?=
 =?us-ascii?Q?jHHyPKplN384qBRhYc60w88ZzeF1xFAYhW2B0GraJxtByY7UzT/lRQ+q73QJ?=
 =?us-ascii?Q?2duGbM+7px0c7c1iM12+zTBDnmKt1cS7IY7mq6GIUf5HC476wIYjGdly2d7R?=
 =?us-ascii?Q?SY8GkW1vnbMHkC13aVkzebvzXoJXhYBldFAINVcDTFR7J3dsWygjJHOz4xq7?=
 =?us-ascii?Q?HjuUb2cgu7Zqpa9Ni3Oh/k3f5sbvp6A5iCbmUW/CH4Mp+y2PwO2TrwIimUpn?=
 =?us-ascii?Q?vlWr/FLvkRNWyRZqQKep2KlbdWQ3T7CVPTn0Y/J5UpsRk/ZKlLXyAeK820Qd?=
 =?us-ascii?Q?GLGhGepFsTbq5OzlUyueErC+XV2VoLAYsrKG4fHVEzQOozEO8SEYdM3DF3Ou?=
 =?us-ascii?Q?wWxOxg68bfYsILj0B0+zauIctp5aZ2LNODhWQb7bzfPvSdBl/cB7Af5kP7tN?=
 =?us-ascii?Q?DS1kAOg3f0BrBmpKatLnmOOMaVmyp+LLh7l6bu7ZsJxkpg8yPhzmmPnT25ba?=
 =?us-ascii?Q?k7MnjxcKCCG0kz3CsZMiZq1/QQ3yMrVCoAOkiGChkLXWVRUeIY4+Z5Irhp1S?=
 =?us-ascii?Q?itHRXE3R3sNTS1F4X+mm1NPw9cUpceZQAXGEQHgTWuAAWzHxhR/yyDaGJiCt?=
 =?us-ascii?Q?CQRk9v/ryXe2b3CtJvQPzknmQbuINUUFEHC2ATKGsLRJHvoXlInn6uRMiWHh?=
 =?us-ascii?Q?8YxAONltIT7IkvVS1oz1jXAyG02+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bv003BZx1d9R9LiSTD6wi5u3WZPTAJo9WqTTBqod34AKSoarefj5B/1DQe+/?=
 =?us-ascii?Q?NAPNp0FN7CcZ6z4CRxh/WSwJujWKYYuPv4HPWFetMSHcRq6JyGCT+KltUAww?=
 =?us-ascii?Q?8E9bRCB8lgMeSpEVjfRArumJxqKrtyGREt5AZXlvo1Jy7zCsShkHeHUWqFOA?=
 =?us-ascii?Q?rKvz2DaoJOipR4IWMOX6AO0aPWXoHF6qdeNm3JaOuWs6C0h6Ybvo7R3bqxwD?=
 =?us-ascii?Q?zLox5XPMkjRWps1S5wrFrQY8643db50SeelK7aDDaTKJzTXnGIANMrV+ehII?=
 =?us-ascii?Q?OsZ6yoW0EYHQpngcse4HjdugeauS5I7W5t83Qw9hPp5O/OZ3Lx8bm4QwTYib?=
 =?us-ascii?Q?P6ALmhe3dgNWAzrTBhalua0f3KEyDMCtZZ/4+NqCodOZDzJ8NvAJxuFjhIqD?=
 =?us-ascii?Q?J4MIOpaPAyYyoVSu1J1GTTcl0uEw/DwNhYij+q6uf5rDpp5skzW/8Peq1Z7r?=
 =?us-ascii?Q?gLOAjoZ2+I+PVW5NEAAEfNFizxZ6w7Oe3t7XuRyN8/vPrVGHSU3qvxKcVFr2?=
 =?us-ascii?Q?FKYRa9cZ2KJdw9I8T6zmQO8shXREE+d83lvEdiZtGBcCRFwKraxBO7kgaGpI?=
 =?us-ascii?Q?XhNuUFdWt9753tf2NOzTzmXdPLyFKnECuidsrJsDiQYYsL5iiINL4qiRMVA0?=
 =?us-ascii?Q?yguGTUTqzCDmN9LyAKsyMO7/zBNydp0c/v09SWBNPgipLHxVX27SfgEBd6tc?=
 =?us-ascii?Q?caxXXLAn0YusI4s56Y9W0PzjZLSCdhy0OW3JxQ2XX7wBYFC2qC3dJC/6+En6?=
 =?us-ascii?Q?9GedAczEQ6vPB6Q8tOagOQBgEPL8etBmbSqh2DFPN9wJe7mNUd2+hBZgr1jq?=
 =?us-ascii?Q?v/vIm0XyLUk8dYy+qa6rKIO2G+d+Kf/v4Y4jIEXdD8Y9L9y2scbmSEpTFffV?=
 =?us-ascii?Q?lSdCTfNawEbRMCmbkuMj+swnePjzoQz6nGtcpWet7ZqIdXwjNIBUyXfi4cAm?=
 =?us-ascii?Q?fG2FMUnZDg3sYRLc6k9n4wNPYoM0zAdTnhXGMLyJiCuWZuW/Du/ahyBl2ZrG?=
 =?us-ascii?Q?4lTmHrUHKyQVIvM7vr4Ryd59SogjQI5sQ3LrrngyzsBRoh4h9FmGQN0+81cO?=
 =?us-ascii?Q?1IiSnCL1SbSGmOf6Djf8FzoWQtlKSYt2KiBXvoKgaXLSu9D402mWFDdDOZn0?=
 =?us-ascii?Q?+K42Oi9BBm6aVUcWBGDvSiDb+CEs6BW114HGR+VCRX0/qabJJ3HrfHT9h/lE?=
 =?us-ascii?Q?KPn4cnS3gpAKGrRCgLHxMVeXfbxnexJu3rDwTV9+snjEfSMck1xr1EvWbNlz?=
 =?us-ascii?Q?lXGCotL7IEq3RkxvokVFWEm4MjQGisZt7rP7Sw0sX98uajNsHi1FnjjFpUSE?=
 =?us-ascii?Q?I4sD60eJDSIlB0KcfUxr3jDDm5cPp+CM40NhLXB/MmFuIuC5XsutIM53kLLE?=
 =?us-ascii?Q?8fM6aWKiFLp9ScLNp/tZcPanjWb/WLJJeXVPDl7kGFsCqstZo5ZD6hw9sQRx?=
 =?us-ascii?Q?7wrr9kezZdqpSJof7Gh1dqcuP6ZTXBUcVJ0vtY2c6rmwYF2zidDmxcObEazx?=
 =?us-ascii?Q?CcL2cg4r5jIlhO78LH6MFdX1/+gFmlvK4qv8pIxHi78nGntFf7au6H1HxgkX?=
 =?us-ascii?Q?CQ7xm/d7kXnKFLtEyHCPo+QEhBnTf13uYxEfYjerBucjJ4DRnYgPRdDJijOd?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cJ/KgNNSF913pX2AM8f/KEw9YuMvq2dnCTmnwVp8LLZDskYQ5+wf4nTC7LM9tEdd/wJrst1mW7KjDLAzFcvbvaQZYqa3nbGBvSilelFTxAz0avgCdnBCi+x7mdPnnIXMeFuYzV86CwZabsOpnwhaBC631nuTmxYURzAckfaJ8t+xSsyz0xTkvOy+vmX9ijED3lD7E+/ZpIKWLWaOygjDVMRj391UY+SgxYV4pIyezqMtH2MKm4JV7Wyke5qO6nzUCBnta61FcKCOoNam2+ZFe4uZDQPWndcmhjlZQej4U3v+FG2bmv3G8udqyjeflO0anFuZzOMmW/lkuxrGas3QCvwS63D/22L48tw1HSauQDgVIH7mDd+0nI/YD1OkNyGos5LWcGd/rg9Nsl4jdSsN1EtWmFHmIG+0jfbmOEAT394asoTTh3M0Tcvkvqbo6FvMvaHprRyl8TqOZbwKyVQuqtfWlhKIKX8VEt/deX4djVz8kjBVtuk0FJp/4j1mLSfapLArXMXZYIS7cnR4GxOrNhXr+LZpACiL9dBm/Kf2QnzGdEaF8hBCwJZMXnyEvVpAG/4hkP16+/JPDAoVwox/zjkQ4+UZSCph9ckcVd1AB7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197c688c-0608-4465-a866-08dd67a73008
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:03:12.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsRCW+zHxth6hm4xbr2OYDE3NhChhhkPouMcbzBUPnWMns7P5eYyPi5eNKNmCNfBK0gxlfJk5bcAlJWbHPgLPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200073
X-Proofpoint-ORIG-GUID: _PcnM4nyrhaV5VvjrV0A_YsiltaD8M6p
X-Proofpoint-GUID: _PcnM4nyrhaV5VvjrV0A_YsiltaD8M6p

Flag IOMAP_ATOMIC_SW is not really required. The idea of having this flag
is that the FS ->iomap_begin callback could check if this flag is set to
decide whether to do a SW (FS-based) atomic write. But the FS can set
which ->iomap_begin callback it wants when deciding to do a FS-based
atomic write.

Furthermore, it was thought that IOMAP_ATOMIC_HW is not a proper name, as
the block driver can use SW-methods to emulate an atomic write. So change
back to IOMAP_ATOMIC.

The ->iomap_begin callback needs though to indicate to iomap core that
REQ_ATOMIC needs to be set, so add IOMAP_F_ATOMIC_BIO for that.

These changes were suggested by Christoph Hellwig and Dave Chinner.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../filesystems/iomap/operations.rst          | 35 ++++++++++---------
 fs/ext4/inode.c                               |  6 +++-
 fs/iomap/direct-io.c                          |  8 ++---
 fs/iomap/trace.h                              |  2 +-
 fs/xfs/xfs_iomap.c                            |  4 +++
 include/linux/iomap.h                         | 12 +++----
 6 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index b08a79d11d9f..3b628e370d88 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -514,29 +514,32 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
- * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
-   protection based on HW-offload support.
-   Only a single bio can be created for the write, and the write must
-   not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
-   set.
+ * ``IOMAP_ATOMIC``: This write is being issued with torn-write
+   protection.
+   Torn-write protection may be provided based on HW-offload or by a
+   software mechanism provided by the filesystem.
+
+   For HW-offload based support, only a single bio can be created for the
+   write, and the write must not be split into multiple I/O requests, i.e.
+   flag REQ_ATOMIC must be set.
    The file range to write must be aligned to satisfy the requirements
    of both the filesystem and the underlying block device's atomic
    commit capabilities.
    If filesystem metadata updates are required (e.g. unwritten extent
-   conversion or copy on write), all updates for the entire file range
+   conversion or copy-on-write), all updates for the entire file range
    must be committed atomically as well.
-   Only one space mapping is allowed per untorn write.
-   Untorn writes may be longer than a single file block. In all cases,
+   Untorn-writes may be longer than a single file block. In all cases,
    the mapping start disk block must have at least the same alignment as
    the write offset.
-
- * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
-   protection via a software mechanism provided by the filesystem.
-   All the disk block alignment and single bio restrictions which apply
-   to IOMAP_ATOMIC_HW do not apply here.
-   SW-based untorn writes would typically be used as a fallback when
-   HW-based untorn writes may not be issued, e.g. the range of the write
-   covers multiple extents, meaning that it is not possible to issue
+   The filesystems must set IOMAP_F_ATOMIC_BIO to inform iomap core of an
+   untorn-write based on HW-offload.
+
+   For untorn-writes based on a software mechanism provided by the
+   filesystem, all the disk block alignment and single bio restrictions
+   which apply for HW-offload based untorn-writes do not apply.
+   The mechanism would typically be used as a fallback for when
+   HW-offload based untorn-writes may not be issued, e.g. the range of the
+   write covers multiple extents, meaning that it is not possible to issue
    a single bio.
    All filesystem metadata updates for the entire file range must be
    committed atomically as well.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ba2f1e3db7c7..d04d8a7f12e7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3290,6 +3290,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
 
+	/* HW-offload atomics are always used */
+	if (flags & IOMAP_ATOMIC)
+		iomap->flags |= IOMAP_F_ATOMIC_BIO;
+
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 	else
@@ -3467,7 +3471,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC_HW)
+	if (flags & IOMAP_ATOMIC)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b9f59ca43c15..6ac7a1534f7c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -349,7 +349,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
-		if (iter->flags & IOMAP_ATOMIC_HW) {
+		if (iomap->flags & IOMAP_F_ATOMIC_BIO) {
 			/*
 			 * Ensure that the mapping covers the full write
 			 * length, otherwise it won't be submitted as a single
@@ -677,10 +677,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
-			iomi.flags |= IOMAP_ATOMIC_SW;
-		else if (iocb->ki_flags & IOCB_ATOMIC)
-			iomi.flags |= IOMAP_ATOMIC_HW;
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			iomi.flags |= IOMAP_ATOMIC;
 
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 69af89044ebd..9eab2c8ac3c5 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5dd0922fe2d1..ee40dc509413 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -828,6 +828,10 @@ xfs_direct_write_iomap_begin(
 	if (offset + length > i_size_read(inode))
 		iomap_flags |= IOMAP_F_DIRTY;
 
+	/* HW-offload atomics are always used in this path */
+	if (flags & IOMAP_ATOMIC)
+		iomap_flags |= IOMAP_F_ATOMIC_BIO;
+
 	/*
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9cd93530013c..02fe001feebb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -60,6 +60,9 @@ struct vm_fault;
  * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
  * assigned to it yet and the file system will do that in the bio submission
  * handler, splitting the I/O as needed.
+ *
+ * IOMAP_F_ATOMIC_BIO indicates that (write) I/O will be issued as an atomic
+ * bio, i.e. set REQ_ATOMIC.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -73,6 +76,7 @@ struct vm_fault;
 #define IOMAP_F_XATTR		(1U << 5)
 #define IOMAP_F_BOUNDARY	(1U << 6)
 #define IOMAP_F_ANON_WRITE	(1U << 7)
+#define IOMAP_F_ATOMIC_BIO	(1U << 8)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -189,9 +193,8 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
+#define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
-#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -503,11 +506,6 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
-/*
- * Use software-based torn-write protection.
- */
-#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
-
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


