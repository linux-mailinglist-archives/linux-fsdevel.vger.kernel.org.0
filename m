Return-Path: <linux-fsdevel+bounces-47839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9AAA61BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996891BC2C32
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26F21ABDA;
	Thu,  1 May 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emaY7OP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cxn06s5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84043213224;
	Thu,  1 May 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118724; cv=fail; b=WhI/knj+fXQ5C3aMIId8KgwqsNdfpVlX7/eryy+8dTmFYLE8qNKgEp6xTkr17hx9i0e6GLOqzS5dApz21Ajbp1evouIloO2TZK9OCoieGjiJuY/8C6ABZmaozRq4lAU6JOI6iiIXWoJanwhbJppVFvWbDy4aUcsz4aXxnd5HuIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118724; c=relaxed/simple;
	bh=AHg5IxE++kavbn+VYPMGqS/K0mfiKeQj9hfS7o32PQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JbJ8kyzjdjlqdeZnyj3METBL9Wsp6VTcXKogq7NrXCFYihiw19+Nprnde+hPA6dcCsn5SCPTAkgOqwbXNtnhIOnoK5V8KOcaM0OkmfkX5jfOVROMOg5O4AxwmOMjOP1V/IYRXUVwOyWgm/qXxU6l1bXjgyUxuEFcDQkuYK4MkeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emaY7OP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cxn06s5l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk18H004333;
	Thu, 1 May 2025 16:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sgHITb29pOEcxBrXaLYLvXoDW+4cPys3kPrPQB6yK1o=; b=
	emaY7OP4nqUwr9BVMLw5ll8p14FvTtP9Sdr98lRLPK1EQeHB/I+hLem5O5sDq0tN
	nLmKlUZU2Z8EHYMiipLIxk8gh2qCtAtYSOAo47qKAaxxrIzKD1PlxisTx55dWb3Y
	l2KihMc6K8rXtIddSLdzEPM1NpkAaUk243XaenN6ZrV2GGbQFyXt8FS5UnFREU33
	k24oHLLDaWXhe088yhOszFTWab3njhJHIN5YOIJL+gLlBxcLWlnFMIhjLHLzD76O
	uF3z5BPtFteVG8WXt1CXLbPnQelh1lQHRWcWh9wp98Sx2q75ajJYiclc5C/0DvcT
	M6moh8yPvEdaS+MWfkKrrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uukggb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541G2vGo011320;
	Thu, 1 May 2025 16:58:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxd9akw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRDGuO5Jcyjd1UpAZ0BQP5yA+e0HJZOXVuWan2Fk7Ydb53mpNJriywvl9lWBLbTOun1O0ZQ8y/siwq6bbcC9+xceudtCk6KmKQZMvcrPavIqAsZclZiFB12TngLxM/+7L8lsWMMvhVPiet/kl9ZMRjxNjPZJygji6r2a4BjoWY1nvuIi3vwQpQ+Ho1IUz4ZS3WzvMz4U5brgjQIMLkptZqOWpiVvFS1i0eRkhPMrvj2KWnsEIH4c3MmC3f2roIIaZl/pFTdUm7NGUXS+S0M/Jr/O2rUJYCatk0T5NlAkkHiuHUC1XoHjKh6Ke7gAhL3VzEn5w9pWvi81lKUemgKgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgHITb29pOEcxBrXaLYLvXoDW+4cPys3kPrPQB6yK1o=;
 b=BOSkjdeFafuDBoKk+29wCKg7cj1eY+4QOSlunzy/mvAbi3i1YvspUkC7SPmkcJwkEkgApdoyTw2BfN8jfQzx5DNntutqszrG8kC6uIdIdS+155MNQCBeJLVe+m5v0VtydwLoy7HCob2flxt+1apRHbDql6PR8VcL0MoIaBL34VU0VrMLd86xxWR3Nzh89WJeTvuk4vUTooBltXTNEDGv0g+76AduFV81h06ActpASFmd2U9qQSCzpVeb7Js7lW0FVG6ZVKSmUSjN/yZ9JvRFxklE1sic3FDfuf9IJBFeyqDrJAjuJZgiTu3Y2GwBkhyJ6AWcY/fU8s8nJJH6S43I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgHITb29pOEcxBrXaLYLvXoDW+4cPys3kPrPQB6yK1o=;
 b=Cxn06s5lDQp60j8ONbEpb1O/Pj/RK1LB0TC5AL/7Qgyh6JQAeVcaykDnOLsaaUCiSU91Wt1UpAAgzGv68brhdRjAEL+eTqXym5i2xCWRf12GnoCcpquOY+8p5oBAOMkf1R7K88iDj24i0+rSpWN8tx+CYFJZGDAyKcRtpTi/b60=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 05/15] xfs: ignore HW which cannot atomic write a single block
Date: Thu,  1 May 2025 16:57:23 +0000
Message-Id: <20250501165733.1025207-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:408:fd::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0746a15d-0f92-4473-f9b2-08dd88d1518a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?201Wj45hLX/oxEVmZuy5oNDm9fLW7L/QrMVR6jXETJB880nROAwZ33BF6qB2?=
 =?us-ascii?Q?eU6LDsezq4X74DBI0zEBPGBAFLHuqBEUZ2IYY4jIce95B3ndVCuGfdBxZPbU?=
 =?us-ascii?Q?yr25x2Fhlth0TdvZrVd9E18JppxSRZYX/SM0gjj12WAe+xEqu7J0m4btW+pw?=
 =?us-ascii?Q?fANrIpW6tvF73IJwS/0mqpDqnBgBOtAPRPLFmZzOpJ/tclOKPUnBTq2SB6LK?=
 =?us-ascii?Q?eVcwNqqwXcpdQdKJVxhfKkWlkdR++78TaiDNLs6bsfY9wodgU9FsghFeinRA?=
 =?us-ascii?Q?Ucott5IpewrZ9MVqqFu03efahix8tsE7Ti/JzkRf0FvOwGqwOnfiq/GsJOFC?=
 =?us-ascii?Q?Yl3tVEN/fJCr3wjasK15xTtg/3VXEPpeRIZGSp9SftIofyye72Tbr4zYwUiF?=
 =?us-ascii?Q?XuizOUVUj2ay/tJ1uXAyp1bzG7orsqxEOV/ihDAtJBLKkSrHssytdjz2Koyb?=
 =?us-ascii?Q?wAoii+Hg0BX/mDsYtIQpdXt8pz8qZW4qg/zzjTQNt4jsvK3yUhUNMOTbuKOu?=
 =?us-ascii?Q?D9xXNhJwOUahqYE3k2d2ebtrzGpPHmeyeWQtr2krCfG4NGv7ocmH4tLUGp+8?=
 =?us-ascii?Q?J2je9JcXqrbc7NS93KCtA/V6heUh+nct2yyYW4K/mxKcKNZ6Jgk5CPq26+Ct?=
 =?us-ascii?Q?1kHGbkbUymDDOx2vuD+iuUOM6opbDmdiIgfX2TxZGuU3LnKAXuUVxYASZqiA?=
 =?us-ascii?Q?IXvmUyma+kP6s0zzis4H8wuD7lkLpiPSeR++JVA+tRZnLXDkac6fkJ2wT7Kb?=
 =?us-ascii?Q?rajBtkzguUlUxBpzhB8fZtNNHFDH7R71TdPKPdTS9v7boRQ1tuL8MiYFIy/W?=
 =?us-ascii?Q?V0KKYJnam53VrEsBAtxeLwktgVe+T3aFoukgaKTC+33gqhEdlttF7cQHvHx6?=
 =?us-ascii?Q?sjI6n2JJtJtcKAdBdCMvb+tlPCtFoTr8dln6JKVYgUhFSVKIFYZUBj+D1hVr?=
 =?us-ascii?Q?tu9B+vZaOg8qRJ/UKEF9FZfqHote1guAdRX7EYDrwrVE6mrPb79d8Z5v6FhZ?=
 =?us-ascii?Q?LMNKsZmLqkZdgg5BYHHQukH1vhJGo1kz7T5Fl7LKrtf9PulYIDu7V9QarOYI?=
 =?us-ascii?Q?eenY1LIM//mdgMGW1ooA95MCbK3ADNGEwfTvbRJof3VB/7eH3oE7jwdVvhCk?=
 =?us-ascii?Q?q85+9ZjY6IuyY9yMm1pzXjM5wxn9lxTre+veZCOoA5H4jyFZX7rBOFUgSqHX?=
 =?us-ascii?Q?QIa/Xt1MLKNSkTr9kuFKy84htvAh4ZF6R5uD3RUKSBs92GsoHCo0Azh7SrkO?=
 =?us-ascii?Q?G4wSQ+QaQ4Os3kfuFDFTPkLn1FGyxsurAnF2GQgvv7nsCRCI9Z+0XeZ98DRv?=
 =?us-ascii?Q?Awpf/B2mqE7nPxYIFWmh0Ja/RbEApQPnlxVxB+rejW7SViH49vllb9AaZ7Fq?=
 =?us-ascii?Q?RXcaMwsjyWP67aOXJCM4AB79ZlTUKcjxnyVHQK5fSZy/9WtYggwp/kwfTQ8w?=
 =?us-ascii?Q?e1SYnE6vFIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOsvbC2HTe+/HdiukzL4FaZ6ysFzxngXlA3cRmJ18fupXY2svM+GUlSJ/fCD?=
 =?us-ascii?Q?G2r85SuOtYpkiaGCERjZ/hrUQTOPKqluUGYGHmpkOooiI0sEf9+hJHOxn2IP?=
 =?us-ascii?Q?fBLHRuf5kXuD/in5MIplaJr6wsiRusLTVd7hTzxDCdQnOgXFskKbVBBmN98W?=
 =?us-ascii?Q?bFuyDJILDlcfX1J2nl3QrCktxgbZMrS+QIWvdV/OrEbt+Ra/vN0MO3cBhi1W?=
 =?us-ascii?Q?0ojbR2xfEtnMFkqV2+iYpBl0xIe4LmD0uKh/0UD1k7Mu+B9AFbSXZ5euJONH?=
 =?us-ascii?Q?yBfRNfNX9HUqM4BiR/effyWZGlxFpqhl50ZpdImqEbm+SfWSV0VGeyff+FBa?=
 =?us-ascii?Q?/eKsNeBEmvsRLRmZKRCH1CGPmdR4TUt/7XZAAoEecb45JsV/8MWgQaqJJ60c?=
 =?us-ascii?Q?iOWuIJxzg5OjmfSoEi0Q1pxjROeV2O6lUku/PMS8bAnqMccnSLkswRC9MoIG?=
 =?us-ascii?Q?eQS7jUxlNA8CaMVtZ+8wzGEZNA6mrqyJqHviIt/cfXcB5OiQG6m37aGyvqcM?=
 =?us-ascii?Q?WBdvecJ4OZK7mblToaGbEhtNSr8jHLu1y8J793ldRxcxcxo0WmnnkmA/rjI+?=
 =?us-ascii?Q?ANVMhCstf3Y5JWeHkgKmO+/rPeF3p2X9s/Ycm1PDg1MENnQKkpKUTMzkhybZ?=
 =?us-ascii?Q?H0obN1Ypanm7dKG40j3ZpsVuyDPyJ2N/Bfb89xK8Scg6E2akPjeCPsQhMZWt?=
 =?us-ascii?Q?1ovU+q6tXmG27kXqrw2bH+RAcYy6vQ/SkIqBTq1UAwu+lsmiPBAaKc6YmN23?=
 =?us-ascii?Q?EgCy8i6uyhbfiRNIzc7GllVrX5oidkLO3SHYjiaf+hW9YcaKOvw8Ct8nXdzG?=
 =?us-ascii?Q?7n9J0YyKiA6IX+a3QJVpjE9YPjQXjMlSIArgaq2oIAoD+LUAshBQLPFg2657?=
 =?us-ascii?Q?f51ILP9mENIkLm7MLAkM6Ef1FQ0pRlJxOlyHGRvwnJ5DpZ2IDd9MEGgEWXx9?=
 =?us-ascii?Q?xvB0aXNa+eNj4ylBt/TMcOlk5u/r2bbxUUvKFEw56z+z0ff3oBzahLiqrk7Y?=
 =?us-ascii?Q?AdoE3gdCVkP4MuhvUfZgWtGMd+chlw3QxOnZOBiZwQbpPy/Rl78OXnVLUg3Z?=
 =?us-ascii?Q?cM8JUMedGrUWrco53H/ThJJyvqFMUC9yK5MY10Bf94rusbsyJ3lOHIJkv+sB?=
 =?us-ascii?Q?/deu6YsinEoqIl29StS4H1bYOUfXuHhLlexjxael+OoykhiB/G+GNJRVAlZ4?=
 =?us-ascii?Q?hm07ewh2xqOSvuy+BWIik332b412YHh5VxpCyvQhI8L7XiHx8WdrqBhWYdk/?=
 =?us-ascii?Q?9EhNJeevJm7A/zjtLBF9c1AF0Br81aZa6MmmPhsb9lFr45Z08kczb8supB1E?=
 =?us-ascii?Q?2pX2q2KtEZjWeMrUUGDJjdjP2UPUJIE350AEqh+SJrqAu0hr4M5Uf7JD/KYY?=
 =?us-ascii?Q?/76i/V6nQt9lUL/DEPks2kBjYu5JVxbiul00jXlrSSYCgl/3712wi3ryzFnr?=
 =?us-ascii?Q?xgcWE2cqNZqYhr5YBFu9zxa1Gc2YU2aXuzhNObxKyCu+c2pHAthU4riVeWOT?=
 =?us-ascii?Q?IN7QANoQsS4ATF1zgBiFY4hxVuyhReAKI1WQkemH6jC0AYjr+CH17NRWuQSf?=
 =?us-ascii?Q?RAn8r+jNnpw2tcT7C9BKi/PMbU2/Kptn2H7+QEKfEXOildWEBkGSFMzJ1SlR?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1R1yhQpfEi6Q3HVirSfmw8FLoqlQJEVITIXVGznOu04XRNGsy7/GGecXgWnAt2w3UWJx+oWAFa0vpPi29R7s7O0wR6sEvuQC3a6OBzbXOvxg4mfR7eoMlGfS8M21o8UIkw7dTvrcpeuWPfmfo3w9dkxQr3hY2p3GnFlNPIGyfJY9f0e6ap78IrljiHCLMD9IKzQtmzz000DHsq96LxLSlteDjSrbOKlIRLPiKpdy0l2vVfmEj20P7uRq/4ryg4QcqwcZxs8u/5AJouihe1WSzatHv7gxQoCT33BEPLrVqYudilmmb1rPdQP1wnz/+dZk5Z4yqhLDfAJHLEnZ9WlXwP3PumHdQTyDvqAH9PAtW3Yagw6EKjvdeVgkrEziXZuoByi35cZfISq7EXv3REOHfYGhzGIf4Qm2kysuwnZx119GUfc2ftHwCJCjnuXKEP3ga3vvWokVlkaFM+ivsbnHjMWJsTNwqFKf4lb0Fdchy7MHpkXXLO68j8k5gOr+3+ZlOvyQ4zlWhsuwxtFQQA3oFOq0pRr+LBMRcjW7dVgbent3yqeWNFM0+3NLJk7SsE+DSc+fK8s3N4SR6ebxKfLnNuxQV81y2pI8rsV5s5AMR1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0746a15d-0f92-4473-f9b2-08dd88d1518a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:55.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jYt947fEU8yhJpbyciHoA3JVsCrJBTAfAc6P0iBBDf2CP5YSPo/zfRHlj7n6lueJqXEhMwu0BaUqHQNclIPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXzpgtOfd8U3pU 6CILLL7oysQyCYnWH0m38VGGC9vEyVb46j2M9saev/X6rQVBjtwf1MaGrrxsC0cS7d9Z0HY9HSY 6kz6cfgVZhDrEOMIQJaggRcFy52V5cKyIDUW9goD4qoH+BWhhOgXSDZkaSPT9q9Ur0I/LaRWxJI
 tAoHjBSoFKzlnvdLDBtU/2+WrIUOabVsGA8Lr5DrWVaoN1s6FryrepZV6ycNw3oJOroh6blrpVy fQqLUxsFs4T3qqEEC1sK9OgumV0UsrsbFNhoEnT2W0pQiEWxY4X8x5+vc2VKvbgbQjbETf+Lwgh Lx9COdf5OwCfqFs5pv7lLCRK6uhRyfLWDJPOeVIFi52p6Em3BwqFNEqQ/POZ9mAkBAH9g4iB3me
 fOsVqSwodTevvCLpgTmodTPNSaviUFBoLAFkCCw9HIFdEEfeWyzVusiS3ukMMtn2vsze10L9
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=6813a836 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Aw58oTtQWaA1gqLR3HAA:9
X-Proofpoint-ORIG-GUID: SZmU6gsX4CQadJ1DdcRtIyTokoHSUFk6
X-Proofpoint-GUID: SZmU6gsX4CQadJ1DdcRtIyTokoHSUFk6

From: "Darrick J. Wong" <djwong@kernel.org>

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the
code.  Indeed, a statx field similar to unit_max_opt should also be
added for this minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird,
so let's just not support it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   | 41 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_buf.h   |  3 ++-
 fs/xfs/xfs_inode.h | 14 ++------------
 fs/xfs/xfs_super.c |  6 +++++-
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5ae77ffdc947..c1bd5654c3af 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1779,6 +1779,40 @@ xfs_init_buftarg(
 	return -ENOMEM;
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+void
+xfs_buftarg_config_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	struct xfs_mount	*mp = btp->bt_mount;
+	unsigned int		min_bytes, max_bytes;
+
+	ASSERT(btp->bt_bdev != NULL);
+
+	if (!bdev_can_atomic_write(btp->bt_bdev))
+		return;
+
+	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
+	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
+
+	/*
+	 * Ignore atomic write geometry that is nonsense or doesn't even cover
+	 * a single fsblock.
+	 */
+	if (min_bytes > max_bytes ||
+	    min_bytes > mp->m_sb.sb_blocksize ||
+	    max_bytes < mp->m_sb.sb_blocksize) {
+		min_bytes = 0;
+		max_bytes = 0;
+	}
+
+	btp->bt_bdev_awu_min = min_bytes;
+	btp->bt_bdev_awu_max = max_bytes;
+}
+
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
@@ -1799,13 +1833,6 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
-	if (bdev_can_atomic_write(btp->bt_bdev)) {
-		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
-						btp->bt_bdev);
-		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
-						btp->bt_bdev);
-	}
-
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0..6f691779887f 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
@@ -375,6 +375,7 @@ extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+void xfs_buftarg_config_atomic_writes(struct xfs_buftarg *btp);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bdbbff0d8d99..d7e2b902ef5c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -356,19 +356,9 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
-static inline bool
-xfs_inode_can_hw_atomic_write(
-	struct xfs_inode	*ip)
+static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_buftarg(ip)->bt_bdev_awu_max > 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5e456a6073ca..6fd89ca1cea8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -521,7 +521,8 @@ xfs_open_devices(
 }
 
 /*
- * Setup xfs_mount buffer target pointers based on superblock
+ * Setup xfs_mount buffer target pointers based on superblock, and configure
+ * the atomic write capabilities now that we've validated the blocksize.
  */
 STATIC int
 xfs_setup_devices(
@@ -532,6 +533,7 @@ xfs_setup_devices(
 	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
+	xfs_buftarg_config_atomic_writes(mp->m_ddev_targp);
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
 		unsigned int	log_sector_size = BBSIZE;
@@ -542,6 +544,7 @@ xfs_setup_devices(
 					    log_sector_size);
 		if (error)
 			return error;
+		xfs_buftarg_config_atomic_writes(mp->m_logdev_targp);
 	}
 
 	if (mp->m_sb.sb_rtstart) {
@@ -556,6 +559,7 @@ xfs_setup_devices(
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;
+		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
 	}
 
 	return 0;
-- 
2.31.1


