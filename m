Return-Path: <linux-fsdevel+bounces-47999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D38AA8541
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC32A3BD5F1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAB19E7F9;
	Sun,  4 May 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZw8/M6o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N1bB9dws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B41862;
	Sun,  4 May 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349285; cv=fail; b=jIaflY8TrjO5bAe5sQ+fZsFmXJugVXRCG/kYg64lrroc1S+qlST6hHmpH3A/Y+0gPA9jiMiB0CuH14xjrMVODxPPMKrH6omU+Y9xTX3Pk6q9/CbkBEwUGQTGTtBRbjEKxWpHhPnLxYr6YTn6SM1Rw2zl9ZCgy+WNoD2fFnx2YO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349285; c=relaxed/simple;
	bh=KNVNk1CCx42+fiaAdF2Ll76XGH471BCcnQSWw3yt3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIhmxgiMPLHU6x1q0zcPyyLVKx3wHOHD9x+0dHj6rEK/UlOu9vgGepIBIODIIuNdWsz4f9Hbz+3MFbwDCtkyS7wM6KJzqdnoCZeodhRYeUe8lkduvgNIK4ddKpb2AX/4/cBYn6Z8qiSXFq2ifdGcCv2ZXtt1mWzQctx9Xmo7fvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZw8/M6o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N1bB9dws; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54478QmT017422;
	Sun, 4 May 2025 09:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=; b=
	ZZw8/M6oSOXl1BOHhggTxplVc/UbpqlJq9c2ofXpVVoJ+h147BRCPE6tuGcXWad8
	4GeUnggpYwAQgB6X4GFuVlgbhJ/3eFfrhygZvGdTdB9/y3LdVIO5gQfqcnL2ICrg
	p1dbOQ9ilm8XMHcXrj/Gsm0F+YFQ3Qcc9P7SDxxfa/3ce6QoFIiGXUeP6xmXFCT2
	kKknO5scmvv4iejVTnnz2gR8s/1CH+j0KHbX4kUsCsO0KoatbVem3jN08Wn4q3cH
	SCodPGuKKh6Xid3hagNgynjW3SRGDQ4BYCJg3EWBz6Dm4ifhNvLuftQh3FbWER52
	S7qmMxzKorlC+DuyvXJcHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3jk03yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445PLOp038260;
	Sun, 4 May 2025 09:00:11 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k6gfhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI5qLsK6pPC1aqQggeQq0yHoPxBQ9vSuiZc0W6hdybQFErA/o8k72Nu9lQjsXbFQPpr5aB7LLDE7IqD5aIDtPoEaJM6sQCT/8TJ44m451vxa/qcNXqbVLVQV2eqRnpNH0TlzlfVxkNdVkCgPlYEbcvpryg52nVcT7tGyod6/cxAVIQgKZdhVO8sU5UCSnY59FKUwj1MjDf204K49AwHDXJnMubcL9n9OxOh6lxEUjswhPzk1rIQIyBfwsc+nAzDQImw6G2Frx2lPbLx6Z/7lAZqJpNqNwthpDw6pA0LWbRE+ayC3Attb5NS71Bb17VXRPj8JCZBreamG9oPIyQQt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=Mjl32EgY5lWjjnFx4Ev5XAieL1jrhFgB5g5l44Lc/z0+osY9xkKsZMiOCqOXhundycxc8MFGth+Ys2bnFD2kukFCk7esOfrRIXszwr+H4eyZoJhVeTilFOxuSMQhNYYMqAd4BSU9+/tG0DpKomLY0KtK+9A3n+yPGB2QgyHJaBrcdcRwzHQq/bgFDTSgOu82o4y+A/NzCSXyvH45et/XkgGR/wZeAu/ZuxGl2jtEL3mr91jPib4hZXQQwbCVfrtgkS39gF+xpRFF/4dTsgdGIOe+58nxZSXNex196Pc5amba6meuZBkIoK5mGHF0BHtAmEasZgkdJu3jiRcIWVUv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8XlzjetqY8WqWXCTcttc3zdjyPUAZ+82wHngghAoCM=;
 b=N1bB9dws2Ou8fwmhY1x3lZSBxMZQJ1sNSLKzIT9CV9nDxvPAh+WYCLFzyeTzavPnUA11TBXnnojqgnrUl/p66NdNbz7VrHdflxhrvZbsuuUyRdI9phY73Y2Bze02+6tfKFPJo3vjZQPwkupzZaXX+Lt96IrpVY1+KrpVuniJCAo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 10/16] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Sun,  4 May 2025 08:59:17 +0000
Message-Id: <20250504085923.1895402-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ca6d05-c4dd-46f5-f04b-08dd8aea11e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTAzljYe6ubSRxgCG+OfKspKtXIcv+xjsH58dVR8MiNlxa1R8EKFVcvYM4mv?=
 =?us-ascii?Q?KPtWvnwlH+alel2ZNhfzLyrYbbwOBvSulBvRJI8YQsNN67hbY/dZch99vsRZ?=
 =?us-ascii?Q?49KLza46fGLP44SWBkpqfHJxsQcv6Sj7Q2qdFSCYiNFba92ODd36dDZg9zW8?=
 =?us-ascii?Q?PemXWc4lk7E2MvI/Ak2xgGEbKrCTbL7blg5u+3MqOc9LVVPvCakfnaOgV5sf?=
 =?us-ascii?Q?cRINyXClb3ybf8BvUIykgD1NGnGMUkMlKVde/a8sZzt72nB/aHc4nKu7af6q?=
 =?us-ascii?Q?cgssHcZgjAm/MZBagzGyNH87sUevCxuTzCl/Sq3EAIK72Dz82H5JB3TqdWR9?=
 =?us-ascii?Q?YhqhJAFk9R1Qt16M1sYmZzTQ/AjknDz8nKdR4fRpB4vhZZ5Ru3vcoo+toi+7?=
 =?us-ascii?Q?04G/b5MY3ysXF0Z3pRzMF7zznnQS1BID925s6WXmILOh+WJgcswAIqaEtCQF?=
 =?us-ascii?Q?8gNx+Te0gFxXJ1YCgOaFX7MCjL078guGXKnyz8xtboiGinUedrOYQcHTB4ZL?=
 =?us-ascii?Q?YnnftaW4ILh7jj7VTcxCbZoa3n8CceuMziFtzCzBYXkBQU+nHh6vnTuSLbxp?=
 =?us-ascii?Q?Vqz7hC3+/HUuNmSqeF8p5GLR/Ljz99boDWnPaw12Yk+zU2q9iw00CkPI0wRs?=
 =?us-ascii?Q?Im8HfMsIWfAYjkfaviNM0kxo5UYzFvHj8rnV9oFtCCLrMM5xx9fB0JKhjYN/?=
 =?us-ascii?Q?9YeWfppbHDKtpbb7xdAuwnrnp/RNY6PC5K/I7u9qiM7Xns4HclNrFYO+ad5D?=
 =?us-ascii?Q?CCkoWeRGM0vstuKI0knh6rJRp3KsdAg66tmdWRv4dJCt4V8VWHteB/mt9L8d?=
 =?us-ascii?Q?R3GoqRdLBAEjDsMR3qhkp0AO3UqE6rtUBpUtyhMZsljd3wgafo/geGONbmZu?=
 =?us-ascii?Q?e9Lj/c2DX+tY+aphGU23AY/MZlVQDVRZeWsrco5r5ycnPgP3Gr0cY3AjgWNd?=
 =?us-ascii?Q?RjtsbxSZG6TPcL/Smf6uI7ZDCKfnJrRdW1iHzIKq8KL71nqs9zBj07Lx2E3O?=
 =?us-ascii?Q?hvpesU0uA7t6LPwVI/53xzloVR0KFYHho1IYWeFuJRMmu/SvhuL2RVMBrOiy?=
 =?us-ascii?Q?BVh/iZI4LVtwo94yNKiHySwtAPpVAqdcMXGTOiPiP+6G1ytRoyfAVzSDL6FA?=
 =?us-ascii?Q?82g+428DgYH3KTpYLKem6HqboJ18WTbYVPRztyCztOgEJZkBnJC7CNpAy2dL?=
 =?us-ascii?Q?J3s55JCbqkPBVgCd0mP+BRN9/0op1w2zfD3vlW0IoU7jpz7rPSEYEBtlJcqa?=
 =?us-ascii?Q?c+VFclk2a1IfRUB7eJSMtMd0aUwIoCjYPYH53zvycsfetCLnz1TPrURil89n?=
 =?us-ascii?Q?RBDOUB0qqwt8Pj7TzKR4Mm8nTmefeOXpH+RzddZYNZFXtnxst+uAh877X5Fr?=
 =?us-ascii?Q?RkltZSoj9ebu2BVbmhjMCwayYZMF/XkojPGDYl3Pcf4txnzG7k57TteLN4uQ?=
 =?us-ascii?Q?mY6mGc5vOx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pzx+AdoqLOaVsvjdZAFBDJNp46QcMdgw9TBxe73nvvVYvyn9WlrXpJ8jZfbL?=
 =?us-ascii?Q?LOT97NNA/A1aUGvKlWWSfRp08bnbQmkt1V5DA7KbkrA1hpRCiamQwVA5xxpM?=
 =?us-ascii?Q?2mnOsCOs+OpSnVF40sN2XQZEmpylz5TAQ4wq0MhovvUAXwF6VW2uhbA7w3/K?=
 =?us-ascii?Q?cshHRmVTSL3Rv+SPlQnXDiqJ3n51qRBWJ804LprHbOhYiD6gBkP9ofwdXHZQ?=
 =?us-ascii?Q?FEVqTCFtuzZJ83/8ra3Oj2MUKZkzvXPR8GRYd68ySIlLIXuKEv/QUeInYKkf?=
 =?us-ascii?Q?Vz5+2eI+uub0t8NwY1WBf8N+b3oTQs6ll+p20uV/kk4cLa8LoFHdYn2eHpd8?=
 =?us-ascii?Q?l8If/6TiPEB9HVMDUUpzt1f4rPcoBqesq56T+yp1wnGBh2vldkUs/p6iRL2g?=
 =?us-ascii?Q?6YXw7Xm6GMN52MAYA+sRINco9hrtW5vjbaUrCEqiaF7E6AKN1zOSCtNxQ3pa?=
 =?us-ascii?Q?KmLIEIgLMvXmIDkGuy7cNaAYyk1neu/JaZKZjO0Dp1PLSrrBzTC4jDgFqtHl?=
 =?us-ascii?Q?oOEJH0rPCGGOxeveoO42egzcnw+aHWxwslJ3/l/GP1JQatniFSiPGQaZDNgq?=
 =?us-ascii?Q?yB7GOrPxCQCpJrVROSZlvlgixoddNHHoayEVqwJp5SBtvhfFNKULq8HbGolj?=
 =?us-ascii?Q?ffn45NfMTCZniPVKNHNum8RXJwOkX9EyghAj4oHYF6ncgoPkaP04Sfid6hl6?=
 =?us-ascii?Q?7Xdpib3FHhXcFLQ+K2unfEIIvjFWnj8vM8EHMXP6sLIGHyaa+VrufqhmN3x4?=
 =?us-ascii?Q?jlTGq43XYyhYMorBobnlKyZnTsDyELTNiivOMgP7l7+aerSeemmcFxuJt86K?=
 =?us-ascii?Q?vuDxzuwNdB+eZgGjuKwREz4AMqQUq2R7xmxla6y+higVmKrwnsMiWBYbXPVG?=
 =?us-ascii?Q?CpAv/l/1F0w6B8RKeitlY16R1gBrf4q2LRVEdfa40dnzcKobsuex6VrIY6BO?=
 =?us-ascii?Q?xmuYFZeSXDk5bY4i7sGf6pQfs/EGO2PbR3aH0clAdGLhWfLav9kQ9V27ylJ4?=
 =?us-ascii?Q?jqWHFDs/71y1WapMCAuOeYEcaAT+1Z3fTRykNthAzkuXIbcVli33/KK8mou8?=
 =?us-ascii?Q?UXPOhICqoW4sWoBrqVz5P2H2dIBfDiSlBzmyDlr0UAu24lsANFiaBXXMJOYD?=
 =?us-ascii?Q?SDWux7ERgwRbr2R3Y3VhEjQGR7icCYIe3umFltgigHE9M0mjQzBkrorRxrwJ?=
 =?us-ascii?Q?n/fqP+8uzHQ5CM8Q+/B8JL3xLlHUDVqc4JcpY5r7YawsDxgtnDoK5tHOhAK9?=
 =?us-ascii?Q?1DTmv7O5B0uO6Ise6WIH4/3eoIodhO9u6C8HK/F+NpSd2mzlTwgW5Cdy59ZV?=
 =?us-ascii?Q?CJ80/ZOHO5c4i/wWpNjLYK+CW2fzhVmhNYxwetS29yWeGA9EeZUGDHLjYZyQ?=
 =?us-ascii?Q?EvUJWGrEIMkLszmXjxEMN8MddgleHC0SwHFKm260vilrWuwvL5bLrUDIqN2g?=
 =?us-ascii?Q?bpTjrZftMvopAqU7sOYmvnz+A7kDmW6sLA9CZbZ9ZUkk+2MEWbHUBRMHK/YS?=
 =?us-ascii?Q?DbzN+ORFh1pnd5NK+BFfNXOZZXEkXSHSIGjuqp+/xwY6xDo4gmBccUcgjQBl?=
 =?us-ascii?Q?dynH8HpjJPQYyqSyBolIAZPGV0FZiUbnz4t18T7ZygYX3WUrBuL8KHAVCu8E?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	224S14m/txXa/niRE8/3PTEZmTxxJnA69RTy87OR/EnedX193twkDeeyDWZKcIwob03OK6CGZ7WmYNK8VljnUSZaAyVO1ZtHl3/WcuFwyouKFC6FjyCgkX50KP9OeKnr6hMXC8hGQRuz/8qDsCBJwCRfy/n2NsIuPj4LhThhxKZopONWdz9eaY2m9MIX7+LzHmfgZ88b33DgZIIEMVVpl5vpMXWPR0qA1Iirny72MyXtNs/UcAu8jVwVh+KhIZ+RIcaYs3umFW13CrUbDYsbbXEJPtBoF201dB73QlQh2BoYBwV3igqtOnyFOSYF/++D42WCuuOL4FpJwDHQEv+SYgB/OJepu2CEMAVOoeJrjlIAAs9y0mz8zpu0qjPA4xlWFLaMl6dTWRb5uLLtUVc2bDbxV5/VtDnuJjf4qmc+i/QqrXjhdNR6Jg4OdHEuQ0k0QEhMccxJ/HFWlr8CMf2NGwRdwjoRueQQiFA/6Zf+Ns2L5Xqp0M1QGiZrgLE8pGXkzr881Y7vPARxNpDcTR+ctWvlRwX0R3hNkKbEQoccRscxQSDaR/Yel+4LgA2GNRfSClKSiveYpWY6+dYa3T4cWt5UhfD4yyaFC4zEmOL3kCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ca6d05-c4dd-46f5-f04b-08dd8aea11e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:08.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0slrq7+t2fRR68DEfz4nHa/kpnzZZ8qaQuVAmuWSxzBoXKFP/2SEQvxelbexBnnp0BhH3npgAWQlJJYsINy1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: WPi_EJTXWNvH2lLG1ZnVq-kiznb9z2-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfXxKoDSrXbin8s 0rK98pgjPiVbbuIuTrs/+Mph26bE1gmWz9G3r+aASVC8lF2Zu0FGNWg5d31IZsn2V39Ryo2zt8O LaTUso/0ATS41On9IPa6w7rwvPv6aZnnJbW8qx7CM/AoWB0Uo3hARidgb0IaZEdQuLXIzX1lewq
 c0rJ1wLyNsr5StVGN9CI5pWKJQyyIkHt/ipjb1EitA8jyO39/jqbzZ7oqttLFichuuDSMwrkM9E 4vQMBAl3twosAKwQWnATdIFr8mky66A5KWu9fchfU3gn08gFcdMvGfH4iG/iOJko+s4PRaOWDs6 /sWcyGeHJX0kXQzR8bnKkzDiCrP7tYUJfJkAPRQhgBuYOBjqdnRfzkYM2+XUn5OIpiid17+cDU0
 H2W1Wo15oBHSr302RSrLjSQWq6vEKlIwZHEXle7XQtMMR+YP23q1Lhz5novVbETm7+x9jpSW
X-Proofpoint-ORIG-GUID: WPi_EJTXWNvH2lLG1ZnVq-kiznb9z2-o
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=68172c9c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZG6D_t86WmhNJCCpPcgA:9

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add a new xfs_can_sw_atomic_write to convey intent better]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   | 128 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_mount.h   |   5 ++
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 6 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..166fba2ff1ef 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,134 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_can_sw_atomic_write(mp)) {
+		ASSERT(xfs_can_sw_atomic_write(mp));
+		return -EINVAL;
+	}
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e5192c12e7ac..e67bc3e91f98 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -464,6 +464,11 @@ static inline bool xfs_has_nonzoned(const struct xfs_mount *mp)
 	return !xfs_has_zoned(mp);
 }
 
+static inline bool xfs_can_sw_atomic_write(struct xfs_mount *mp)
+{
+	return xfs_has_reflink(mp);
+}
+
 /*
  * Some features are always on for v5 file systems, allow the compiler to
  * eliminiate dead code when building without v4 support.
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


