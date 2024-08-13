Return-Path: <linux-fsdevel+bounces-25802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAD950A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17CA1C21E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912631A704E;
	Tue, 13 Aug 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jPh26O6V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M+I3Iygo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA11A256C;
	Tue, 13 Aug 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567040; cv=fail; b=SgtAbc9pmCUhChbu2OzmCb6dQxqgL2QXjAWH4kgw50YZlZGXNy+dh6C62qd0D0NQ3kaoInu/Z3ER0HRvm/QMG/6RvQVkdzPmDrQolO3aVwsTrBZScCC9NEVC8WHsr0iLLsNqc8KEiw7DDNWcPuT+70W8ASqpyYcTQxrPqX6pLUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567040; c=relaxed/simple;
	bh=9rAvIZkBqEMJF/OGzmC8x+TbIitZExhngqTTkGjs7wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxDEqvAoVeBXeK1iPRjBehYb8uz2hKD2tudrSjYLLnOUVy+qInw4bnieE4gs0Yt/FVusS9ybVKE0LxQA//NTQsV41uwt7/Su/+1nexN6kgwfQR4QpLWdgmBCUb7ih13oMEutAhojZiE3FL441EgKQMaXnQ1pnG1L3fvNmjP/pPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jPh26O6V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M+I3Iygo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBUmB002871;
	Tue, 13 Aug 2024 16:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=; b=
	jPh26O6V4hMAa7F5jTvsD62QX26hOsuG0iiFNBzImcZSL+DuRdyoPqAxtgiVt6nS
	mEFyPsQ1Dhv6RO+azTVzZV/EerIVd7YQPFRmSLJkaeuX7CK9qbHP/vjto4OdM1fP
	XOc7bOQBiV1u7SK5vBAbKOmlCiDttYS2BjuYT1gFxu0uqTwDwdtRMEOUVfWkrQUb
	LqeOLIBe8PAaVfGH8KdDhYKgyHyWq3+PsNncMm7z5Hj5lGQidCpzysYlsX6TZbfq
	hPn6vN8PUWIirMzdigQMVGtXiUDoda13+Wy+RTi760shDnzUhDDTZtX0NWQmMl/3
	oPJFH6qVBwDhLycjhi/Ccg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtpf84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGBTrb010640;
	Tue, 13 Aug 2024 16:37:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8s053-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIexUcPPIjER2DEYrdl/69gF8FhdPczjN3UyxkIoUyNbpByU2dNMcSbGdZYp8l+i9D/l8FqugfoJfSHgXqp+ZHaZbG3qv5ydT84z/Iysb/Sq3EJS8jaKx3c6P4gR2XfKkIe+OT2t0i1TiEWV7qMPe5MZMT+D3uaW4nrG9qQb7HTBsP6tq8/Xn454/6JTrYDX34VvwVMMgP3OYRV4jHwDPrV/SvDDzKRBEP3PzlR2KK7ZPbF2ay9nVxxFNrIytUyV9WiEhNs1mWNJWY5PIQ7SHvrn3CXqWsqBETncfEENRZhBe2HmESTnPB2GmYar7f8eGtklX3nS0IW3qsaWq/bCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=;
 b=ZrCv6msycZq0UPYofy4/cxFKDx9cEnYJUkfbqXtCaburuOcr8Oujc/qEbFHt4Pm4MqkZhyPIGaYytx1qefLE63iGDM0enB+Rc4PeXeoCMKx22Er+bpLTtw/89Qq9htvuaTlSdnz2TfVAS6VzdrR8aanYxEpVcEPnB0Sp0gW/F/q1jUabMZSStwrH2fqY9g/Y3EUdvFVDSVxLZNWBRBtn/9SzZBDQy1RrkeTvhFd+eO8rq7ILJZ88bmqisVvx2AJylSnM7LzuI9Vy3wpMqvmmXM8C6hSOrC/MoPO/tUdr9fez9YxchkexoJaflTr3Pd/3qTtNa/xB+udyIdHMt/uwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=;
 b=M+I3IygotY8Z/C5Khu/fTZ3MDHDgJEbs8y30AHzueqyqItUfNyoeAqZboJalcgSRIdOUSDC8YYUE67WogKdvb16J0gchm3vi7x9yJlsdOeJ8rjM/XB627Hx8C2lBvKGqw/QayyIu88LdebamT8ltSPD/Q3MS+k9WsdGFaMZpuGw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 06/14] xfs: align args->minlen for forced allocation alignment
Date: Tue, 13 Aug 2024 16:36:30 +0000
Message-Id: <20240813163638.3751939-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed46cb-148e-4051-c9b4-08dcbbb62711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMObGf5gL9oEtioyRH+yuB8zpQorVYQv6NIvI49steUxGeFIw3GNyJbiLj8F?=
 =?us-ascii?Q?IPSq+HVSC8lVQlJk+rtl/v+h7ZivjV2BRt7xSp61VXadJSOQtPPaYQWsa/2O?=
 =?us-ascii?Q?0VXsTPTas0EpoqgFHAeXzgjEjnKz0JN4+t8xmkmCBie4erfuNl4U0joNg92n?=
 =?us-ascii?Q?xx7lnreXj4r7/+sCszM0jbdfkC5As0gSkY7S7b30hj2XEMbJKKI7AtEtmZR1?=
 =?us-ascii?Q?zmdRjAIAnI0cuncLCy2S61DnzWB+G9J51xzMPrpkeq2KhFufG6AoGoRWrcC6?=
 =?us-ascii?Q?EoYaFkJdRrvPVOQ1x1oWc7zgUm5KlODVYTGU8oPQ8xlNDAnEv/qxtAorIN7T?=
 =?us-ascii?Q?b0u+GiEh9Qs3cTPiRMQiq6A0JCrw9QD33E1Xru7CimpQate73csUqS1ZO0W5?=
 =?us-ascii?Q?Yy5YSc0J1gji0Y7i0wyd9YVG9mopRdTAfR1ez7Ezfx2E0UMbIAKxZNBl9gec?=
 =?us-ascii?Q?CCfDqe83iO12PjNeWruemZ8mKL9hBw46adFX7WKmKuGQfl1LcZA4YA6JtHNK?=
 =?us-ascii?Q?en3nEW6cHCXMedaeAVPPqxzmSpjw2+phqUf8/KYYMUZG0/U6qEFYCB6O0YRN?=
 =?us-ascii?Q?bNVTz5saBnCBUfTGTgg7BdMgQMGMl3pllgY2hOUXpQnkJNriIF7NFbQU1GqW?=
 =?us-ascii?Q?1c2Z630rNMINlXEp3eREA5TGCgWfDKHtTq1ycMTZm7shE7yc1/bNgx5kktD5?=
 =?us-ascii?Q?wAq/F+b4DkQWLSCXDlXWJsoZiRcQdmYV7WOHBAzMOxwjIeRjL1j3UbeNic6K?=
 =?us-ascii?Q?36omDwB4Aa0ZlSsmMkYnOhYvZs1bkthtcfJ7e42/+zgtoCsMqDAeLc/Sp01n?=
 =?us-ascii?Q?NhTQuGZ5xgatOEhFJPSM7BPtd/Cx194EF/4AUk63iLqcLyMa2ThjAmXn6efx?=
 =?us-ascii?Q?EGAisiH8p1zwrEk1yhW3nMHsLvnbaLPI0OPTLkdQqJL9rpwK2nL2VHHv9QlF?=
 =?us-ascii?Q?werbBYfBeyOeLQfCGQkjWB23C1fW3HvFdGwH3/+Pf8DRpaiq2uvi8Bpro9Wa?=
 =?us-ascii?Q?ElbpgI9K3KoGplVe/kuDjcf9ujk4JEyNPVzMpF9oEUXnn+1hQBMNY1QyeawB?=
 =?us-ascii?Q?TcPUXEG/WcX8f1Aa7ZHkvMou6y9JkBOyYoP6oCijl4iD2M97NIgrav/CSOMD?=
 =?us-ascii?Q?tMsD3drMSlhpv3njI7Fn/+sHKE5s3SF31HfMaMJLW+hbKOhnCxeI5Y2YVPcQ?=
 =?us-ascii?Q?ZibH3WNJZLN5ZIqOkrN5KzUIhRJrktJWAPzpAFcAhB0KpPkBgS3gCCMcBOM3?=
 =?us-ascii?Q?pNqSSVa880yXTmg0HeA88kHIQWZkyFD9BCwQIOthN16zig3B6LJR1KCeOUz/?=
 =?us-ascii?Q?YM1ae6uJSWDHyILMLj53EC0Qtjds8eX0HdYhT6slz/fKEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlYPlMr53weKcJF54Lq+P1Pq96+rsin3NyWCINq53R8JxO0svtJmwVJVWwYh?=
 =?us-ascii?Q?H+4x+IaXenJ5ip+xQvmcfphCe58/blzjBfxdOFRYzLY9kui0Sl6m+ETcdQ+S?=
 =?us-ascii?Q?RDBWF+8dPW8BEtLt95fPfHSXZ+F5cPGLk5BA+Pt4REAGVckQ+QY1wIUh9dNJ?=
 =?us-ascii?Q?3/Fp6/fqlSJbHzf/pFV/MnELn+lL/iIdPNH2FopLGO/kB8Wj2O1v1QgVbMa+?=
 =?us-ascii?Q?WLFYK3OpnOJa4ji3sHNC+Idbq9CM2hdft0B6MqJlXB5SxZ7W4Wk6wF1qTyvv?=
 =?us-ascii?Q?vlMeJoA7xP1RvyzigVFUhb8SJxVUEwidy5EgwXfR+cQ5FMXTKA8SB3N+pUnJ?=
 =?us-ascii?Q?3+192HNyfgBDG4UOEPyQqF7xrV6bGZkO5aaNjE6WqzKhg2iEH1Bv9b8ZxrMj?=
 =?us-ascii?Q?6N3uWdQ1aND1NSn5uGVPO7FmSMJNJS8MCPf/GxGdVbG/YltaI5J7rFM76Qsc?=
 =?us-ascii?Q?vM4wRJ30QtRIKCEsyRID3QhkP3bcBCwJSYKNrV7nG8mfSi5oxzyjsXkANq1N?=
 =?us-ascii?Q?tUFSEdTR4EgWUVhg7RdKu46Eg5CoatxqGX+VB/w9YTdXSc3swHqdsb2cPTRX?=
 =?us-ascii?Q?UjKE9Q8JfWM6lidWdbdRtR1oaO9mCzgj2TprkA092FX6QHCWr9h9NGK6Ftyv?=
 =?us-ascii?Q?oy6PiQXxJWpDGAL9+lDgQCu8CB0P/1AS3nxVC8Q8dGDiKhLcSCUu142PsCFg?=
 =?us-ascii?Q?QSbgKk51VXrRnOkMpYCE6CCrAHTopNlKZCCnZZokYTfcXV2tcqh+kv+v3yp7?=
 =?us-ascii?Q?SyV57+fPn+woeJFqeSnATfN5TiHCuIBzw22oQEOwnCt90aMDlCzyG2al3M87?=
 =?us-ascii?Q?vaauhNp8Pi9lIONJPN1+0lnJhSRF4Ylkf8UE/1nH9iiTme9vGNEstX70dfgh?=
 =?us-ascii?Q?ani0UCd8z9JrzS37bEKYSYp6jIEQ9Mrf14daa/ojyp0pM4HZjmHBp6b9AN6c?=
 =?us-ascii?Q?pIDHWAQzMZcTSkP4eb0TSJzKq0usicMbhHmydeCVI8BfhnleE7FBIxyeL9BF?=
 =?us-ascii?Q?f25yDMxQMBrPaizYQLGSVDesU7stderOM6xlxGzW2SP1LeDynXBlecT1edrR?=
 =?us-ascii?Q?GBVVUV6DUtKpqj0/NUEEN2fX9R6QS27oRnWv35da2tazISRiLwN0id81q+kf?=
 =?us-ascii?Q?/ONoZlhvqL/d1Yu3o4bh6LSgZ/47aaeE1zRqTq/PEkKcFkNMtFPS+X2ftnAo?=
 =?us-ascii?Q?eyqfigdyBoh9nzb0vJ+I0SdHkXJ6Bkgw3+EUZf+cdtYIDtOhDXJtwuDjoTX/?=
 =?us-ascii?Q?oLoJ+kxM/f0kKyyD9/fn25ipLsZwTmBKlIXSlXYEGE8ZJ3dHx/BKLFPcYeX+?=
 =?us-ascii?Q?F8nx5I/zIv37aofhDinzqmv0Wi2yNv1orYJHgKp4jCWCuHtdtijrbr3cPlnM?=
 =?us-ascii?Q?4yKO1vlaslcfzsn2//z/d8ISYDanLNjODNmPRXvxZOpaER1mPM4tZpOxmpuU?=
 =?us-ascii?Q?z39oAzUSxJsnTgY5E8IJC6Z0XGvh0x9zHX+KISmC/9fl/BksWUi/EVj9WpTz?=
 =?us-ascii?Q?pvQxGuRG2T2lJbRpCI4U8T/5yyqeJUFk/1OpwsmW0ZicT+Ls7WWH6rh84tEo?=
 =?us-ascii?Q?u73i7BGyXT+XXIuFAO8s8sxE8QRFAj2rcqKqGCDSUqN9MU/YWh2LAW/rnE4b?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkR7kqBoHuJUoqyua3NPhMHcPcZT1o708VttpYjt2WTseJEkcFGEskbhRby8e5azji0+OTqfoj77nO/nh2kVYbqzG/n5z3albDroKHTZLSK7hop8MZKSSuM3CHxMW+pHGJXyw3eDvYYZbveARzyGWgXn4CkKhf+3jHmFBsKe9dcyO19EMpAK8SnDK9wbeDBt3kwQakL305G4h8dOgQ6PeAsNwDewYkOlgDARXvhlBFiolKgiQ99RWkic+DgV3TmsY+AWicsPrRyPi/XEncoBLKelI8+o2lwWiaz8W5GyCqszg3r/IJ9pvC6eXtduLj1lps8EK+uwN4Q4AIlT9Y/u0X3w9z2HenlZF6fe6xSTHSl52xYe5DrV60Ma3AXIRvPKSOFMbkf2QhfuTbTaxdMSqIIGOLVhAiskfQew6s0NvsCQu49CXWITdFuxeSVCGXJU8Mnir/2sxbGkyMznfQuuDSeKRVbo/6cL8c4ND2CoFu5zzitmd99rS6og+mJXjhi6gA+1mcpymxULSIAd0rb+ziHu22HgxJcD6vox3UEh+wG/HhIhffKgvfgrb3VJSfrKovYIwqvbNVzgG+ivm0hsjIDZGBxUMTDHVTS0qXvXd1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed46cb-148e-4051-c9b4-08dcbbb62711
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:59.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLiOj2Rpu6xcnT8Iu8DaINwyVjTfWbgXFtqjojrcORbLBVN8eSVWoTCtyIqkkqum4wtC6akWM2K6A9gr/QCgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: mwWc8HRP1xDGx78KAqTwtV6UfzJ8BfQn
X-Proofpoint-GUID: mwWc8HRP1xDGx78KAqTwtV6UfzJ8BfQn

From: Dave Chinner <dchinner@redhat.com>

If args->minlen is not aligned to the constraints of forced
alignment, we may do minlen allocations that are not aligned when we
approach ENOSPC. Avoid this by always aligning args->minlen
appropriately. If alignment of minlen results in a value smaller
than the alignment constraint, fail the allocation immediately.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 44 ++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 602a5a50bcca..0c3df8c71c6d 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3279,32 +3279,48 @@ xfs_bmap_longest_free_extent(
 	return 0;
 }
 
-static xfs_extlen_t
+static int
 xfs_bmap_select_minlen(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen)
 {
-
 	/* Adjust best length for extent start alignment. */
 	if (blen > args->alignment)
 		blen -= args->alignment;
 
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
-	 * possible that there is enough contiguous free space for this request.
+	 * possible that there is enough contiguous free space for this request
+	 * even if best length is less that the minimum length we need.
+	 *
+	 * If the best length won't satisfy the maximum length we requested,
+	 * then use it as the minimum length so we get as large an allocation
+	 * as possible.
 	 */
 	if (blen < ap->minlen)
-		return ap->minlen;
+		blen = ap->minlen;
+	else if (blen > args->maxlen)
+		blen = args->maxlen;
 
 	/*
-	 * If the best seen length is less than the request length,
-	 * use the best as the minimum, otherwise we've got the maxlen we
-	 * were asked for.
+	 * If we have alignment constraints, round the minlen down to match the
+	 * constraint so that alignment will be attempted. This may reduce the
+	 * allocation to smaller than was requested, so clamp the minimum to
+	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
+	 * to align the allocation, return ENOSPC at this point because we don't
+	 * have enough contiguous free space to guarantee aligned allocation.
 	 */
-	if (blen < args->maxlen)
-		return blen;
-	return args->maxlen;
+	if (args->alignment > 1) {
+		blen = rounddown(blen, args->alignment);
+		if (blen < ap->minlen) {
+			if (args->datatype & XFS_ALLOC_FORCEALIGN)
+				return -ENOSPC;
+			blen = ap->minlen;
+		}
+	}
+	args->minlen = blen;
+	return 0;
 }
 
 static int
@@ -3340,8 +3356,7 @@ xfs_bmap_btalloc_select_lengths(
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	return error;
+	return xfs_bmap_select_minlen(ap, args, blen);
 }
 
 /* Update all inode and quota accounting for the allocation we just did. */
@@ -3659,7 +3674,10 @@ xfs_bmap_btalloc_filestreams(
 		goto out_low_space;
 	}
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
+	error = xfs_bmap_select_minlen(ap, args, blen);
+	if (error)
+		goto out_low_space;
+
 	if (ap->aeof && ap->offset)
 		error = xfs_bmap_btalloc_at_eof(ap, args);
 
-- 
2.31.1


