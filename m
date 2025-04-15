Return-Path: <linux-fsdevel+bounces-46479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A644BA89DB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F492189A5B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868342BCF44;
	Tue, 15 Apr 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dW4mdzCP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SuHJqpx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEF29AAF8;
	Tue, 15 Apr 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719434; cv=fail; b=Og5UzI2lFjp/W+M+gc5LjbkPikKcq9hSvudGAkrzmV8mBc9pCtOEexTxnG6Bq7MzqEuV5cXb/gqDr68pWziK1y38CYZb9Zabavk5mu57gy2pKZof18wR4f4Kff2WN+FDYXot3vyAMB4yO+Qy2fViaM24KnNYzWDHrIC9N7jHnSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719434; c=relaxed/simple;
	bh=Jh5iUFRKCIcKOebhhgoU7BkLO34fDP9Yw37pHR5hsIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4BvXIX5pm3q41xlS7WqEr7YSjP+75tG9ms0gsgc/CANULsN/zMdU0FtYfK2Co/I/ZxUr8uoyqSo5vO5xsDWA8bvXfB8Yi0kjI4pBNA2qmB9v/R7QEa68NW6vZ9FQuMtXmIYmt3TfeSCSLyyuy6uVApMpuXtn8hrS3tf+F1o0n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dW4mdzCP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SuHJqpx3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6foEU032430;
	Tue, 15 Apr 2025 12:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h1ZK5BElfP9K84jnUICToc5UgKtsks/rbfaeV4TLfbo=; b=
	dW4mdzCPdppCYE5XnLXznifNgmfdWWe7FcXWOkF28gJILZsMedYh3X0VUitrek81
	cvhtRFvuQRnbnpEoMAaN9jghqnICDjHU6EcDWVQo3gAjJV9hfgngwUnLbAjaPg+w
	ZEpHXVaDte63jEaL9+muCggUaTSZLrh/Ebeel+xKy0XowB9mI1nKnz3P1vTA2PCC
	BUAkqXwH/CArzuv4bh8y8jktM5dDHtJkPpAsr9bK9O6mQfiPvRYzlcyq/W2ygxul
	WlCvvbWTm/CWUJ8zajnHbc15eCvBvYfmAiJNWc2AUzWEHj+qNrJqHeWEyjFgeael
	k0PUGBunieFHGci2LRxNUg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju9k3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FC0hr3005663;
	Tue, 15 Apr 2025 12:15:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5v5p17-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4OKECPwAKL36xglclfWKYWFxz+MdgMRCoOu6Zi2UVlmdg3YLtf5GSZTRjiHC97KWaM4oOzM3oBOs6lmnALDAANHcTwCsKiNAZZrI1HG5T3ULxgGn5kSFgv0gtBtGAp9ecYxQyZ4z5Ix2F2mTVrG77bKfBLrh3ssz8NNtkz7O8+KY8M8hnadQdWI09kuT3YR8xx49ebNKS/RxtCRgGmvyh468LVve1ZUM1eudRwpjgOUmpbqtM6hl0+nXFrySs0myFuviF1VtOm0/I/oT3v2/WJbtcTKRYj/3sh4yGa6Gt0I/yq165q+jx21QOLU7kalz82lGWqmSG3Nm8d/EMgVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1ZK5BElfP9K84jnUICToc5UgKtsks/rbfaeV4TLfbo=;
 b=GRCYLp5M24JOix4PP+dH6yISx0NyzF4zBUyd9RSIeWdkC1piD0fSCZb1UizqZSYPWQU1vvAr4jeU7CToJB4PMjSCE6ewH4lU06UEa3QHWPCbZVTjAZCVxS/BIBjYIYMQR8Su2Rn7VE0fwOJb3lypVWTt2PLth1aePiZp8J9jZoKGYBVljqc62ZrN0f+jUaPsdD8Gdix1B7YGr1sWsHWZ2EHVDEIexMmPZAwNGtH2IJPX4C70FGoBzPTDaRJ+FH7TCY/IQORWgMV9YJaJUz0A22S6ANLzeKDpwllFJPDssRNTzs7kyxLnbqK4mxy1cZWYJTrmC7XmSk0Ne4zRdMwMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1ZK5BElfP9K84jnUICToc5UgKtsks/rbfaeV4TLfbo=;
 b=SuHJqpx3XmaBkmy+ewnq1MdBTiugMQnXUmlLWL4zbIqbZtMg6GyC5NgpQOWw+4ykc1YAVFB26inwB6QJBOMUikoaIPxkmhmBxOny7j6xaQMgKOwnZfupYsFlFYszEXUUcpHt9jRSb4u382tQqRoq9Qc3zTQb7PaUOBEoImg35hg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:14:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 14/14] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Tue, 15 Apr 2025 12:14:25 +0000
Message-Id: <20250415121425.4146847-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: bb628e45-34e5-4d8a-31e8-08dd7c1723ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3OyuSMZkIi0tv6I+U2O50KpRvBAWSZEUSbowf/Ldi+W7foDL/B/atb+k8yF?=
 =?us-ascii?Q?9f8OLmMKUvhZ9mB8nvdZl9CSnGT/mqjPby0enFQjvgbSW/IuXpciGgpWNU17?=
 =?us-ascii?Q?lDUHm30FKyVV0RTt7gN1E/jTEoCZlpw1QtAplwFb6bOwW1oJ/eGCyXkjrOe8?=
 =?us-ascii?Q?M+oxTnKHLeFTgAXfiFa9hsveM5r6C+eIC4eBgNwlQpgpQCCthJ1FMLn69faK?=
 =?us-ascii?Q?kNj962jM/4BlJTx0zmVcPPU4GLIz9WBIcQ98b4AKPIsl9xdG+zhcJf0sL/Wf?=
 =?us-ascii?Q?j59/202lXZRVzFpvR48zTGbeLIFJuOlWnR5//bMK+Ph66zXX2iakExC+41m7?=
 =?us-ascii?Q?crE1lwpdXP86kOB8Pf4NEgdN4PLDVYZ3nRWKXtq7CWaMYKcWBr5Ge3mGF41b?=
 =?us-ascii?Q?/EFiqXSw4/h8THy2d6omW2jeDphRy8+Bccag5CiHJmk2e0KPvARKBeUpE14L?=
 =?us-ascii?Q?VhwZCMRaLdChLnPTMgiNPaSHT3aYul2gmJNeTKl1hkRp6vuI081p+3YW+xPm?=
 =?us-ascii?Q?dqWNqu2GvKzWuahabaLN1f9Oohrm38A+bt0D827CGwNKzKjvJ3dkLApnfBxD?=
 =?us-ascii?Q?DQwxKlwnM5vuKmpnK4y11MDl3BlswvdbuTJ7D/ydQ5k6t0gu5S1QSOZhF2nk?=
 =?us-ascii?Q?v6SSPktqFeilfUGW0w3eXm6dM6TMYDsE2bG5LMK6WIY7tHlT+RZJbk/qGNzn?=
 =?us-ascii?Q?68TtJwXddLT8QHQgJBYxEIngmLwWj8niroyizOrbMemUyJJSm/IcHR3esMdp?=
 =?us-ascii?Q?E44EIyWnrchF96ufGU4NlGo0dv7yiZEUUhkJ7WKdo24YXfwXVTncT57yg6Pd?=
 =?us-ascii?Q?nIl8BNuU5iI+uTt+JhXZrFRzPpTe5ES40/CDcRRz9GuaQc1Gm262OH3JHJNF?=
 =?us-ascii?Q?AWP9j0Pa8Za+jMToPX4ETdeAbc4tOaAMIvwZLYlpC1WgbkRwQnZD7jKv6Iwz?=
 =?us-ascii?Q?+vHC3/Y9iz+pFNLYhx0m6fRqgEJ0vF5u6sCh+J/UHLiyf7rdcyVcvLSgzH1R?=
 =?us-ascii?Q?RtTRxuh6ll0MW0HDSreq3tcIoayMTQ5YMwKOUGnEvQnjesJHDm+y5/FfYwrV?=
 =?us-ascii?Q?3rUdno+7zVG4Hh6ye1Wd39I2ZRN1497cBm0VMMdYxsdy4WvmMptH80c44NSN?=
 =?us-ascii?Q?6Ebcps+5kMBiu+2kDUkkuK0oklA4eHidQOLlupdSLGbSU5S3SKn6806H23nZ?=
 =?us-ascii?Q?OwMij30FzWoA0DYdUKG5DIBgQBvKdyuJyie3+nJQbYpGCPPWfoqQz1lwRAHO?=
 =?us-ascii?Q?ll/tAWr5AelDoa58J6/9aar3LecGEZ0/qUaCPcq3cUQeX1L9PJ4d102lPrv/?=
 =?us-ascii?Q?hwQ/zwZKa8jXk9SF9eSgUTnLTMPI9GntOHmF6op6KEefYiO1r4OvyErcV4Y3?=
 =?us-ascii?Q?bBxMuWsCQ2TSy+vCkakKZYhe7VetaIpLZ8LLcnG1pxdkx9UEpABln/y0RJ+8?=
 =?us-ascii?Q?yKVY+7mp3XY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ba2635Z2jQahk97ASggwFNCNdLCCRWz2n2lf8ONs1l365BQUwc/9jUHFKx6?=
 =?us-ascii?Q?MkdtCHEd1o0cX99hHpHjqX9M3H4scXqsJpX32qDDokUPVSTxUNKhxIaJkkwE?=
 =?us-ascii?Q?pUnvRvOghko3HIO9O227i2PSVzqxyJOVa6xWRsiEJ/0emHZ+VkV86SA8ehhF?=
 =?us-ascii?Q?Kb22mquE7EETYSGkeNTOfeSmCtyQuPalHwbP3MHo/3P++O6eb7J0Lvii8Eat?=
 =?us-ascii?Q?ORSmb/DJlDVolVtmHAa/aGqNAe4VcJcN+BBFfqB2ST1j1hyp8mqudS5O9P9k?=
 =?us-ascii?Q?TjrOISlDkpJNJN9IBWeLiHb9b9JrgIe/yIn21fvpXFNgFunFLTIYV249Yfd9?=
 =?us-ascii?Q?UF4YITBrt/2BmRKIzkSDoGvKKtjbhZTN8cJaKlPJc4DOWooecOer2gXlmfH7?=
 =?us-ascii?Q?a0z4ehUUB+x4BhSuLCLw6NEsMturW7yBD4b+vknUuENtib7ANU0GUOTgOyWP?=
 =?us-ascii?Q?jlQFblmKKgxH8YGcTYXaiESGV4on2d8elL5VpSS4OxuqjeXiB1PXzMDJ9KTc?=
 =?us-ascii?Q?XIWjQYTwNEKP+reW6Vzm7YlHe7c/1qSpKHYQ2A2UUVGvaPlhImgJpGlDoBqk?=
 =?us-ascii?Q?AyxIZNyFOi62j1bGuYqmNkdTwJ5W+jAq73BEP6OKFqgIOb6VeTbmIgjo8Gki?=
 =?us-ascii?Q?A26+G30ft/hlYgRQir9WK9BspXWalOcNoJ45bu3/VvkbrrFxb6IU8U7wl2Dz?=
 =?us-ascii?Q?6+1CeMhoI2VW62qYImpNfF0G8X8zfxvZo2oiCM9hUXBYtCIqnNcf9qHwS0BV?=
 =?us-ascii?Q?WjApjWodIe7sXHXMAhXpOueD44aIYZgzbrCvFj0+7czNWbiD/XP4a58EeHt5?=
 =?us-ascii?Q?ipI0VEJIQcpJ5Khqqmi8GRvrDEPR6yPR5fdXJ5XvbMMjLbPnt8fC4cbLCRye?=
 =?us-ascii?Q?yPoHVsJbFKOEmjih58A4OJ6Lf/LVpKHRCLncf0QXmNwOKTl/VkgK8gamnc9Y?=
 =?us-ascii?Q?shXaLwBUQy+Mn1yh1WZHRoMVGSu3iPJa7+vJIuFEQo1tc7mEMCEol5FZCnx2?=
 =?us-ascii?Q?vL/WRrvtvFfoUzPtfxM3cM13+Jd5r9TNOF+LayBNgJ4LKd1LTy5uBnq+YfaY?=
 =?us-ascii?Q?YH33K6vhHNDE8VMCZrtjRdlyDrjfbOKpCwydTrTWSW1eoeZYUUfuokKrVP57?=
 =?us-ascii?Q?+olZZoTLI8G7xYlDTV5dkC/fsUBZeJG2HoqyKjFZLLAf+ZzVft9FA2bFq5QL?=
 =?us-ascii?Q?DlBcCigFRuXQpOIuhRfrhsOSwC2/F3MOgVg562a1fyEYTuOpDrib463xgRW+?=
 =?us-ascii?Q?U6OdYo0bSLkEz5NTFQuYtFurMxY0c2zWevjWL0GpnU3OMyDdaMRK8HVm2Gq/?=
 =?us-ascii?Q?5g2YY6v2Rjd8st3IK2IkmkjDdtx5skQxInQcHxN86EhsWuu54Vco7JPpB6en?=
 =?us-ascii?Q?PxXBEkfhZjEAP0AiMQuY8H/DlP5bZOKiWlGi4+4dgynaRnH/HTENTih/M/vU?=
 =?us-ascii?Q?ZPF025uOYdOhlLfh2UmIZzaNqZQ8QOjoq1BNDaPmFmendKdKg+pxaO+9/oBS?=
 =?us-ascii?Q?VIvwzJtF2BQVgj4yTAmDVSkramvkP5usPignMzQe41oDFDMO3M3fLGTBCqEd?=
 =?us-ascii?Q?vUbR4No2HVV0nbxYWq8IEuOTnseQ+UlcPtzuwRdUx5q8ZcTdLwsnZGOa6iX+?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rAIV3VA3PInnujbfIHtiAB0uN7GrvTSw2eV2ZxMOltbIG4G8aEZTIn90IOWu0zgLD3l/wci2KSxFiWhWZAFqA1B7vV58AQUxGqRCjrinWzHQCl8kJbutiBScGK25Ir6yQfxhSgroYbzkN1tc+8pYOrsVFd/5YxjWOUfcfhWNe0TkCZVzxkAIlmYYHiARkEcdXrObLJ2yr2tGJHhAbx5PQa/2k4K7OZajCUcJAclH6NrLe7AMYh5DggQMimKE66jq1mapbHRw9OZS9kKzDdYTnndQxAhVHG0NSlBKPuJYiZc3mC+ZR4krsm0FYbUbn4wgAyzloV01sohGxlJx4Q7ISe5x8JDIVLrcJ2ZXeWHeDWf2LY9HDb8wnEnkOf6uQQCC0eykACHOE9NuX2g/WWgQKikEsWjp2hR4rUqQDOveeVlYJ3Ovr3Eb/VLpP9H1LkGiPc2oz/GIQulbAuWTaG3Rm/dBvxnVp/JQflASh+16yFLFf60JiK/AY9NQ0P0NySpk8KELxhHIMbwBJbv3KhpI7ACxRsVcp+KOWxD6BV/t6IjxeC4rImlKQedf5rZT0ka1UixaEXhWdUB+C6Koxt4mPK8VyQtYVUCRH0yF1mi/yQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb628e45-34e5-4d8a-31e8-08dd7c1723ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:58.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBNzRzc97D5G91H60RHaXEsACorFo1976b9mXaNrbiSkrVZbJxebD7XciF9BBk4P1cF2+wbqXyD5Y8JqdZDdRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150086
X-Proofpoint-GUID: Q7eosLX6uEvVjgSDmu47mCGeF0pwAss4
X-Proofpoint-ORIG-GUID: Q7eosLX6uEvVjgSDmu47mCGeF0pwAss4

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  When this happens, we dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
and then check that we don't violate any of the minimum log size
constraints.

The actual software atomic write max is still computed based off of
tr_atomic the same way it has for the past few commits.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst |  8 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 54 +++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  1 +
 fs/xfs/xfs_mount.c                |  8 ++++-
 fs/xfs/xfs_mount.h                |  5 +++
 fs/xfs/xfs_super.c                | 28 +++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++++++++
 7 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index b67772cf36d6..715019ec4f24 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -143,6 +143,14 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.
+
+	The default value is to set the maximum io completion size
+	to allow each CPU to handle one at a time.
+
   noalign
 	Data allocations will not be aligned at stripe unit
 	boundaries. This is only relevant to filesystems created
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index f530aa5d72f5..36e47ec3c3c2 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1475,3 +1475,57 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log reservation needed to complete an atomic write of a given
+ * number of blocks.  Worst case, each block requires separate handling.
+ * Returns true if the blockcount is supported, false otherwise.
+ */
+bool
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	int			bytes)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	xfs_extlen_t		blockcount = XFS_B_TO_FSBT(mp, bytes);
+	uint			old_logres =
+		M_RES(mp)->tr_atomic_ioend.tr_logres;
+	int			min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * we'll use conservatively use tr_itruncate as the basis for computing
+	 * a reasonable maximum.
+	 */
+	if (blockcount == 0) {
+		curr_res->tr_logres = M_RES(mp)->tr_itruncate.tr_logres;
+		return true;
+	}
+
+	/* Untorn write completions require out of place write remapping */
+	if (!xfs_has_reflink(mp))
+		return false;
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	if (check_mul_overflow(blockcount, per_intent, &logres))
+		return false;
+	if (check_add_overflow(logres, step_size, &logres))
+		return false;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+
+	trace_xfs_calc_max_atomic_write_reservation(mp, per_intent, step_size,
+			blockcount, min_logblocks, curr_res->tr_logres);
+
+	if (min_logblocks > mp->m_sb.sb_logblocks) {
+		/* Log too small, revert changes. */
+		curr_res->tr_logres = old_logres;
+		return false;
+	}
+
+	return true;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..af974f920556 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,6 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+bool xfs_calc_atomic_write_reservation(struct xfs_mount *mp, int bytes);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 860fc3c91fd5..b8dd9e956c2a 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -671,7 +671,7 @@ static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
 	return 1 << (ffs(nr) - 1);
 }
 
-static inline void
+void
 xfs_compute_atomic_write_unit_max(
 	struct xfs_mount	*mp)
 {
@@ -1160,6 +1160,12 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
+	if (!xfs_calc_atomic_write_reservation(mp, mp->m_awu_max_bytes)) {
+		xfs_warn(mp, "cannot support atomic writes of %u bytes",
+				mp->m_awu_max_bytes);
+		error = -EINVAL;
+		goto out_agresv;
+	}
 	xfs_compute_atomic_write_unit_max(mp);
 
 	return 0;
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index c0eff3adfa31..a5037db4ecff 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -236,6 +236,9 @@ typedef struct xfs_mount {
 	bool			m_update_sb;	/* sb needs update in mount */
 	unsigned int		m_max_open_zones;
 
+	/* max_atomic_write mount option value */
+	unsigned int		m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -798,4 +801,6 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+void xfs_compute_atomic_write_unit_max(struct xfs_mount *mp);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..f7849052e5ff 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%uk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1518,6 +1522,13 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoint(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes))
+			return -EINVAL;
+		if (parsing_mp->m_awu_max_bytes < 0)
+			return -EINVAL;
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2114,6 +2125,16 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		if (!xfs_calc_atomic_write_reservation(mp,
+					new_mp->m_awu_max_bytes)) {
+			xfs_warn(mp, "cannot support atomic writes of %u bytes",
+					new_mp->m_awu_max_bytes);
+			return -EINVAL;
+		}
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
@@ -2140,6 +2161,11 @@ xfs_fs_reconfigure(
 			return error;
 	}
 
+	/* set new atomic write max here */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		xfs_compute_atomic_write_unit_max(mp);
+		mp->m_awu_max_bytes = new_mp->m_awu_max_bytes;
+	}
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 24d73e9bbe83..d41885f1efe2 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_reservation,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


