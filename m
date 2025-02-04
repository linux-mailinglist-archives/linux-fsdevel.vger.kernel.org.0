Return-Path: <linux-fsdevel+bounces-40742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D931AA270E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6068E16461F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E0211493;
	Tue,  4 Feb 2025 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mW+mONTQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hCSCpwzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1D211298;
	Tue,  4 Feb 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670659; cv=fail; b=dYrsaQvZfp9SyIyryADco3U20tvyRQVPifGM7E00UY7fhQQT2iruNWsAB/RlD3oSl4SdHa7C6fH97Bw01mFqpcb7nWKp6ByJ21ICtLvzaRXMknLGupbVT5BfvGNyWwU+jpUw8aOI7kKv1DlkPZcAuoU7Yi9vKcj9Z9XRiiEmH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670659; c=relaxed/simple;
	bh=Rs6Y2RijMk6vqCiypE7qbIo+0N7BxFERPAr6f7++yec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4/9d9yTvQ/PT7Eb3CeR1U84DcXExpZa+0NtlOYYojjzCqfQNPsMF+ClbQxDKtoYhyuzd+oVGAoW56/1t18NOq2uuGtbRPeyGCuiOhLb++ZclqLLFwcw+vYXmUMBXY3bCes2rpdfpr1E6VUxRygefpf04b3fEnU+zzbass9aiZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mW+mONTQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hCSCpwzY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfVLY013676;
	Tue, 4 Feb 2025 12:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eeNkSfVsqaDK/HRonFeexF7KCPcNWrhOLHzLpGqNKII=; b=
	mW+mONTQJ4McBDnD3BTbzO7tN69bfKs1i7+S1rZ2QpZ0jHwfyHguCT/gyqqT55Z2
	vLnjhxcjbqQBiY+7x52HC+fUltt2M9fH++iUzhTN9Q+Fa32p+jZP5eAV9Xt3C91Z
	3ko5UjBosVmHvS8GDy+aOmzIiXQD/EAWlb+uqiMLqZSkrrvgfIFHCQOu9vBH3H7y
	yX2Bx188WnZ6qVl8RJCrnoiJOb8SDh324DQSYzneZ3bvHmluwN0meKKRHfSRctoH
	3vVBhfvhTv7rl9yxTZhZ71YniaAS88Kaka7rCJzw26XUWxjtOPNpmQfgK5AYYQ0T
	tpHqonhmds0T+Fbi/HTJvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv4ps3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514B5OLs029398;
	Tue, 4 Feb 2025 12:01:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dm5drp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb176etjABcAeELH0fYDnotZQpY/Uin0DUThvpmy2u7Ou8nUnf5uiiMKTOC31GAF3r5yYkFeTwG+SZXXQjgQTd2Ym51ct7/+tfvlvl2T5yOkKeph1oI2wCOUetNKrn1sjvIKwnX/gS2X7FgNusSCFN6BHTkuxY4MlLz5Kxlx7HFER0p/jPUEDYDiCOn0HFkZK+xQUPeRzIlXdHFaYEmlF4FFuHT+7JvA9I6pFO90KUDI/VUyMt3rhKtSeNDsW+67YZL9v41/DSMVc9TDrSvnCUzMOfSeLTsjwq4YDuSxfnpCv32v2pDWPs7YimDCPor2KTRCbCJ+yO/P6YLn3aRYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeNkSfVsqaDK/HRonFeexF7KCPcNWrhOLHzLpGqNKII=;
 b=fUTrdYxCW7DLtbw+Vjr7rQH9EbOFFXNBd29Fob80DT/IadB5Z5EGt1nqhS7kc8QPdhyNNyvqDIERGLVdJuGlZ09iNLU79FgkIKPIUR5Kf0gakGTZSMEbT0w7E9CuMQJugLxcqiEkVVh435W9QRo/J8fELF8bQgvyGGEHO3d1BkHev1liiWytcclhnlf0hCSXs3BQoHITPFzM/CkAbuJySgqEevtDG4CRpHWHIB0/Kqb0b6uTqYxUDgLTsNgM6KBJR5kNNCtR1Muqgtd5riBgRW4sYOS9YTKL88whsBa/kH85VvQhZznSTo2aKM2/VlN2vdmj0sWO3yCiZCvvCE9JGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeNkSfVsqaDK/HRonFeexF7KCPcNWrhOLHzLpGqNKII=;
 b=hCSCpwzYW7bm07vUapPfx6AE3s0BHVavuqM49K1PZ8zmOSRythwdRBHZAbnoRNVv+/FHlg0rBOGs431Y4b8Hht4pisRX3yJGx6qCvWgY4O3gi4WZZk4uJ9mis5IANHMjtA4P/ALG0D0N3cUPw/vWuKU8mRG7cfZgvG+KhU1hT4Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 01/10] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Tue,  4 Feb 2025 12:01:18 +0000
Message-Id: <20250204120127.2396727-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8890af-8b07-4b07-1482-08dd4513b13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUK3wc+IShG0jPYC/1LKBNAPG8BtxIbov6Sr2KuqknAslzdCUNnc0hD9PeCt?=
 =?us-ascii?Q?fl6rgYes1W+h1DUgMWypHJW8uBQrbuC4yAxfzah36Bx/sO/CMjnynPRAZ1Ei?=
 =?us-ascii?Q?ubKECcL36bSA9iHJ1oES2nydZ+0l/ifYSMSTgkjhaDtv9f3iE6TWkOv8tdfe?=
 =?us-ascii?Q?wQE/BMykkmyhSV/rgYSy1yMQXKswPYXkOEi57WLI4VOLABHB/gVyJajY52mr?=
 =?us-ascii?Q?B0M2WtP/lDUrUfZ6Ycjm5NHNS2lnRsstDxSy2FVBdgLYoMjXxl4NKrR2uQVc?=
 =?us-ascii?Q?ow9xMaY+w1+pjpNmDhSQcozrihRxIqr7RfTBCyI6t5OTXvtzuR2dtLnPa/fD?=
 =?us-ascii?Q?5gpBWfGYMzowbqIwxN2qJcWSwp07OyZsRz079XMwDrKslGv55RjC3QwfHOyR?=
 =?us-ascii?Q?j0YgiA7L8te7Se7v6mb5uwF9LLxPa8MAUOXOo62MaJ2ppT9Kr+VgbcI7/H9N?=
 =?us-ascii?Q?s0kHh93RW5IGgEe1luWVjRsojDLW8XdqqRCQBxKos18n5x2NYR/BQfZz+mt1?=
 =?us-ascii?Q?/IZ3mdqSRFVMvPV0JzVZPNzjsWxMAW8yMiDr8RgzecWQkAiLNAIkGSmxwSY3?=
 =?us-ascii?Q?Lg2YEzVrRqV5k9oorGwhK95ULlw/QzcRUb/zkTUQqaN49UWWoTslS1Sq4EEg?=
 =?us-ascii?Q?CMHw9NCyeI3ib4SPN4D3f98xw5uu1oa5X37mdhyU8BDyEcpMHeYiWMQIRypS?=
 =?us-ascii?Q?yXAuiRg+pWhUtuWcTT+RqYYPHlHbySyQVS4893BNbCYxvVF0xng4KGo3fSrQ?=
 =?us-ascii?Q?u1nva/M7X5/g2iRiYhXz6mLiY2NmeY/8wzuXp2BeyfEWQZMtRkrGOo4fCwJc?=
 =?us-ascii?Q?RlKywHF1L7jXImBdrPihac32jsAg4Nmon3vfflB4/c2V4QPlOr+4k/Zpqjp6?=
 =?us-ascii?Q?VJQlR9UlLlDWE6scQ+5Z5Q94AdpkUt+HPjWb2/aZyUb0c2sDARORZV7l3DMZ?=
 =?us-ascii?Q?TlY8PzLQVZ7t9Wxw4mSWJXtQArkMIU9reBRZi6fYlp5xYHboFrvFzLKtpxxD?=
 =?us-ascii?Q?RWbOsrOPp6jpuP7R5Tnb8dOFufbxH2Pk4k85uXjvgqmPRfcEqD3UulRWrRnh?=
 =?us-ascii?Q?ixy8h04Qzs9ejQSgl1I/lmdW/zR+t52PJtajw02RHwKx6qm064ETFd9ZQPc1?=
 =?us-ascii?Q?pkUf7v6KEan9achb65C08xCE5FlIyn1T1Lt2DfJXA1Jm3X3xyOohxnMdO7EK?=
 =?us-ascii?Q?VI4JTcXfT2Z9o7MAboWbUcMhkR9vpV/zv8Yrqge1eNPH0g4R2bPEfHChEz6O?=
 =?us-ascii?Q?4Qfnzo2RsVuFhPOrfojcajN7SEcJsEiA9y2jrSdDjEvA77k6eslA1HmhxTLs?=
 =?us-ascii?Q?v3CLTlLb33zrJJ6FGhdUY0E2Anyo3i9nBa7eZwLJefqYbTv51pe50od7I4fp?=
 =?us-ascii?Q?0+P+pyu89iBUDAaPKFjlmr2d+4dm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDAMIcm4h0CcNJ08Yy2FrPiuEv1Zk+PGff5h1QWrV8OH1XefDIZkREsZPXMm?=
 =?us-ascii?Q?yUpvuv+F7pIeZ/ni8NFcB8o46eBxHzefMRMytCmSmiqwAMeLzgY49xOJhADC?=
 =?us-ascii?Q?nNTzx0HA2RSPylkI8am9n80cQLssDZhbozl+gY8jVrldnA29/lkdOq1glWbC?=
 =?us-ascii?Q?eAL12nkDMmn0xVnybkMFZeQR6DDF+Z6Rny4+1L4yjSbHMMna00w4jy8MaOmm?=
 =?us-ascii?Q?3wejz+O4g2w2CDmHznQrmYp63BYlVAHUIDtzAgc5t9P/+iFq1dlCZcDdVcEV?=
 =?us-ascii?Q?UWxxYhDfONby+sVVkzl1etD2uXw/K8y5xRD7xRIB2jJ6A+KAH0u2/+tQ/Ymu?=
 =?us-ascii?Q?jr+/JPpUfwZ9ZtEVPJYVn4nGT6kSpglxSrNebXPa96nIvwwztrugZS4QgoEZ?=
 =?us-ascii?Q?w9euwpqTopQbbaUI4Cflq6qDUOdFuQjdScMMrkeHeDdWNI16hF4ob6lH+oXn?=
 =?us-ascii?Q?gefLWPEH/0ZwEShtfmzTjWr4KZXOtBgTELAvRAds7U9D/YTX0luGgZGqTjEA?=
 =?us-ascii?Q?MvwhL+UUy8zpl8oyqc4TidjYjGItOMZPjcDGRhqCMvno6yNAahdXcaQMvRnY?=
 =?us-ascii?Q?bZ2i8U8LUiVm3kWMssU1TqROnbdF6BX3UotxenKaGIeP5C0cybF2pBUWfXdN?=
 =?us-ascii?Q?BJuZBwYmteH4rCnnGZEKMjc22s3riK6Vx73tc+iqbtk5NJJ6QkCOrBVGCSSA?=
 =?us-ascii?Q?Q5xke1505phQW3Kkn5OBE0iqxyrE8n/2cHiYj+C7GhjZxO0waGahYsjNdZfy?=
 =?us-ascii?Q?1mz1GqdcjpnW/aaBPQxDfQzQLVsZD+iRUJSJjsHUTBxAZoIIRGF/H4JX0gKH?=
 =?us-ascii?Q?B2CGoM429DI9Zz2U2vUWgNN5YSh0R2xleiesStP3/xiSDSFF656xvFm+V+oP?=
 =?us-ascii?Q?thzC+qscJrO8vofEA6sSI84uvP38RjDFv6plwYFhSIoP30NygZuHMw9I0ICR?=
 =?us-ascii?Q?dB1iWzKPGVFuApfkW3QF+0dWHysgwWvZ5HAwWWRSquEw/MWSqT9OYcSUiWHj?=
 =?us-ascii?Q?snkVrrA0IKNe6MbM+gkqiwDrBXHBfOfaYkdszj88AZoSao/vjUwPUKQ3+m2i?=
 =?us-ascii?Q?aPEI6DEmm++6GzVuee2x2OmwEetk/IhdqL1Fwf6iUPERYuZt4w1KRI6ghevi?=
 =?us-ascii?Q?9x/jTeZ3bill2VZGK0f7v369R4rSZ0W2hBY+DXLMuawfaILqMuQp5J73eHfP?=
 =?us-ascii?Q?v52pEXqSGvPy1jMRxQ799x73JEZLWAOkJsF68NLi/wxokXCloDmgQkRx1E28?=
 =?us-ascii?Q?yp6+fppj3oNGpLshrvmYZEZ8jn1MeA4XMTbjE5o+sUZfrcyR+m54e7R9uiJT?=
 =?us-ascii?Q?8rfhNruUuaAQ5IsPmcC3eav66WAYUlm3zfJol2iCJCdkL/rsvnoIWPtXgamG?=
 =?us-ascii?Q?9zmu2obOkfel5IYURzfZ0yueVyuAv/qvzSoh2Y31I+hoXIMrFE0HtEub1w54?=
 =?us-ascii?Q?24uuVHiI4bJTFZxzAdRzkeOfDr5u7/qakX2mlcRveaM1XFiUnFvQXRYFZbUl?=
 =?us-ascii?Q?mIKR9sT990hPPXCgWeiOa6Cj2IgHkZ2mY6eOJ7VHrDnWIEWWyIB6WtdCtEFk?=
 =?us-ascii?Q?9723DZFfhVWiNqJVnxH7TXQadXgaWQue5NXxHzAp4+nSe3GdPvgJfW/TOmKE?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppv0LpU444rg1i218rsuLkZfz/CmZQ2o9fV9A4FUpAlaxLa/JXaxycMvUOKWNZ4O6OJHDQkOltYhJebxFYXTPg6Dbxy2nt6S4opIKyRRhW4J2wp41jc/bwv0WGRZ88ncFldAejgAcogMLgYbADizASC/pPr7tqnIaBh5LkBe19gkfp3DnKywxUMICZUdnUwKImo6YMrso+xtohSxM2zT7eG6TUIyQOZEghiwSFR5IdlxokEqJ6VlbfF81Wx9s7pA0UgraKeCkihDh1DCFORfcDyAZCrMVgI2MHpVtWQCRQ2YHTwLqT/5g89q+i/9NxEOulbzmaLCOjuYgatvCugvpbaYUmOsO79tNK+9c7RqMbQM0rlimhPqPN5yYs2zNLyzb2xBqKSHtwajNPNG4IxCv2k+rf1Gh3Mu95Az2UyzJSADioXWmmDfvro/AEHxit3FnJOLV5/LJbT6mCeZ0A1OQmTx5MOkld86vmCn6pp91EbASQd+VkfGS5hOIPlFwakVlrzHr2I+mJOgq1JwSTPSzFCjRv/j/JhDZFXZo1cpFfWI97R2wv5Yg7EfqHBbnlv57J0pjMyO7NZWkFkODJfSgvGU7keQYlkpzEECgUt3MWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8890af-8b07-4b07-1482-08dd4513b13f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:43.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WerXK+88GbVKXwh9ZhJL7JTEZa7g0DOQVCFIqj0yky5gVqvOCI60k7PFHT3L4BvCBgvQuCOOp2WlP8+MtSTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: GFWxnvH4CSkyWSFN4mXs0IArIk3gkGbj
X-Proofpoint-ORIG-GUID: GFWxnvH4CSkyWSFN4mXs0IArIk3gkGbj

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, refactor xfs_get_atomic_write_attr()
to into a helper - xfs_report_atomic_write() - and use that helper to
find the per-inode atomic write limits and check according to that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7a7d89c345e..fd05b66aea3f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -853,14 +853,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 40289fe6f5b2..ea79fb246e33 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -600,15 +600,29 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
+	unsigned int		unit_min, unit_max;
+
+	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..ce7bdeb9a79c 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min, unsigned int *unit_max);
+
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


