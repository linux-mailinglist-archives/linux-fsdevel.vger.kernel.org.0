Return-Path: <linux-fsdevel+bounces-55275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31AB09272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0EFA61BCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C452FEE23;
	Thu, 17 Jul 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IleKjGEc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMSgq+jK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117082FE36F;
	Thu, 17 Jul 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771462; cv=fail; b=Irm9TrrlA3F4iV33b1eRE/vjSZDGG4RnjQ2y2tWQHdBex0herTYfLkms83ktN3qUdWlPCzPR2P3pu0FmAp0s2xiFdXv97wfV8LcE2FVMislpRPhcwynvKEvg2YW0VZsTTPYi+Dovj2jzDlcv4D/aiilJ3sPOpThw0HEwShzmnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771462; c=relaxed/simple;
	bh=BoyJ+DXK9LjmRVHNZWwH3GQc+EfvW8el2O7Eo1ADHBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfcPiReUv9agha2jn9U2i3FC1+obrLbuR/ct2bPbYC3zlhuPbyhgOMJU7FgxXHphMAF8QK9Ac2kNm52cgG8RaQzZxTe3xFVf8QCI5H0PCUgm7knrlU81cmEiJ1ul2nBHeI0hi3tsmjZR4kyfPXZANg56R33WC+dLw+aFcx4wHfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IleKjGEc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMSgq+jK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGC0rC001372;
	Thu, 17 Jul 2025 16:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QrzIzPV/zLBRxLKtjJrthVXmG/wJOSAE1k7AG/LPkk0=; b=
	IleKjGEcwxL0k05nqGZV7P6Gxe7bhGz2kiCOYnjJn5DM7xzpgZKqyMW6R/74Dew5
	NjBcRp5lm5g+zdKHlC/z3czwPTZcFdCUwgSV0Zebe0JyH7sJw1dOZNNmAJtTxZ1O
	V5j9lLvA0egQ6vW3eG/FODjEL5PLs2hOnNBHyHiFdXa2hWqJJ9ePwuXz/lYUv3AR
	BcqlWHlS3/elB/eZ7lGEGoAjre12iybYsit/9sPkTWdzzZRv2uWuyD7acJEmY+RE
	HtAYXpWEtjZY5So50oOQnWJyxu+QIZqclLM8oYpy1+s7C458AvsVtHQHGWKTdhAa
	/rqJIgpVEcI1mirQvS/8dA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfc4fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGsPcd040542;
	Thu, 17 Jul 2025 16:56:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d1sks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKJGPiydCHSvM4M1RdEgD/NX4xfjAC+vg9FITNm7iFwP9vmbBcigFNg9rcpFrM3ybGBd4JljYOnHkna6ebp2CyhbK6gJwmkEBnypHjM+K0oyOx8S5j2qFpEuGt4WE/kVyAKGKjw1DkzWJiQWKHsSbzEpzbn7oht46dIsohWX8+PF7O/jIvIwe/wKBz5DRpbozKlQCMdcMa+1ytIHAf8kSVxJZ9nSYuIAmpqF/qkStumWH83ThnmrNM7b2LmcJOlhcuN3X9WXXNtGFkahHtQSV68nqRu3PL0OKYzGJhuczQShlNVwnspM1HMtWmwTV6BJ3CK0ebIK1r67TwIqJ8a1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrzIzPV/zLBRxLKtjJrthVXmG/wJOSAE1k7AG/LPkk0=;
 b=E1xYvlJTqVTswddmAuYWN7zDTvKywyMEMmyheretcl+NSIzmbN/LCqmXin4krhLEN6gVSldrXoRm4JR/s4wcsz3LLatRy8zYtM/h3Bc502dww9qRQ8lgtQ+G+zWjBhKwUMp/bPaKKQLrFGvcYvPKE1aoZYVdkuIk8hSKLwNqNOb0pHlHwKYuBUWw44zUO3PmUSy1rlRmkYoisFr52MsbZ6pHUCwgKfq21Miz0YxGI61qktld6PE4DtDTz0zWRQF84TAPsuwy1zsy4k68zsmHdYW+QZGqmtxBZEoDrAKMaDqfMr57aJyTqKI89TglOqeRE/VxCUSX3yi/RZPY3bbJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrzIzPV/zLBRxLKtjJrthVXmG/wJOSAE1k7AG/LPkk0=;
 b=OMSgq+jKbuaBmwhHZfpHY6aK/pbN3uNRdBInEoNJpfWyrtmzvl3+peg+0SAvHVQ2qUBlu30Xv/Xp7YK3W49AKsUzu+fK5QZQpwo1uRn0BGXY/HXUMdYAQy4Qg56NwBYtKUFa2H/JiTiuhdvPfIXQz+yJIgZih90y85QEGGW95Tg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 17 Jul
 2025 16:56:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 08/10] mm/mremap: clean up mlock populate behaviour
Date: Thu, 17 Jul 2025 17:55:58 +0100
Message-ID: <2358b0006baa9cab83db4259817794f16fe1992e.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0318.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 740a38fd-439a-43ef-60f1-08ddc552ddb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MW/DpxZfeJYx/V+9McXfd8JbvaJmw36/jyffWiw1bneEunaZNdkxlw+c8bjK?=
 =?us-ascii?Q?9gX8hDr18tlWLJy0orOq1X0+wUj4S2sovxPqNC60p0xntXqGyznsGgb7sXgv?=
 =?us-ascii?Q?x8LIJrSbmXo02ClBkdAxyf1IDMLOkoeDJAyfFiMoXZkEweptsrx0k0Bcgy4w?=
 =?us-ascii?Q?59ffaJor+SFQVZlxWvFvGcQ56suRfXw3IGWlWn/D6DQShPuWEdHQA5wh1D1Q?=
 =?us-ascii?Q?d0Z8WVlqg4JTj/qm0ETiuoLtmm3pkIGUMfubQoqElEzejdfOPNfSfKEfGQ5n?=
 =?us-ascii?Q?RW+Pf213yjIRABblwHeYVCAGgcTo6BQIpx2GyUIZXii8LBwTp+x0r0tYML8Q?=
 =?us-ascii?Q?C/aMtuFwjj0GInNTchTpMZ9brlg0poDaq+y9UI10tcAHm8ebuNhScpr440SY?=
 =?us-ascii?Q?TZAI2wrUx0jwxwEW5fI3fhUj8/KWmF0pVxWhHQIcIEOsDB6RbSSglH77kdpE?=
 =?us-ascii?Q?UV6Vr00lh8uPq5RfFtXVECRzMBUPbXP+cSmYb2QTdCrYyQnUdcKkoETe7apm?=
 =?us-ascii?Q?xgYL9HrCGyHhieo/jIuSZI557zECJ87kf6kQh8qUTtZbjw0eVprGct1gmFjH?=
 =?us-ascii?Q?knFGj2vZ0kGo8EEVm/CbM+V2l6FkMxAbQ3q/Is7UO/JWYxoyF2jOkdJkKLEF?=
 =?us-ascii?Q?kW08esX36kCtg14tOr9jEqppD3ug645q68QT2bPP0gfGuaK3+i5OWxVFKG5k?=
 =?us-ascii?Q?Sk+jvCqI10FofpA2JikaHtRRogDe8prjdDukVM75T1yPiiQHXGEiGQ6z0OfP?=
 =?us-ascii?Q?aAWD4CDO5m7SYwE1c88BgQnPMZvA+pOV4Afi1+lBgNWPHydx5kStWNOA1x7d?=
 =?us-ascii?Q?7BML6UrqHSUy92BlfwRtMgZUpKVe1GvB/lyNbswWM8fKvIsre0A2rwwXOIv/?=
 =?us-ascii?Q?ue6Na6GmRbozDNVMuu85saQw/y9q8Jygu4oVEA2Rcijb65Oibe2H22Y/DSXs?=
 =?us-ascii?Q?qw/wma/nJvS9sxp0l2zHsNmULm1X3Vqe+ku5T3LvM+7RNqepMvx7AszT7dB3?=
 =?us-ascii?Q?5Zh9kyjEc2tDZj5LQwiABlB21KGyMS1zCmv344KpV8S04f1yb4NM2hyhxANU?=
 =?us-ascii?Q?UivA6jwcEsjcOZzxrIzc6OWINjH2gz72yphHqvv/P2VhU1fG1K3aOrwo/xOl?=
 =?us-ascii?Q?LsdPo/WHCxBt0ACmLYE2k+4iJQhtbKrAMdachVf5ING8p0ARMztxwcJIbyxu?=
 =?us-ascii?Q?+jaZrVkpa2LY45hWYuU4S1rq7LhqthuXDJSOTVIdtrj3mJDNdeWkR/3kI2RA?=
 =?us-ascii?Q?s52ArsepdhSD/F2uLbx6srh1TQ5ODGVNsP6AhfYT9uRgaPhfypEZCyFiiL2U?=
 =?us-ascii?Q?n5zfYfl7y2mwjzbBoUuD8Oqo2pGy5Mc00fCaH5I6fBrSRFobLFMPULOW0XWk?=
 =?us-ascii?Q?a60i9qEkDsByJJyupYlT/J84lRUYcw5K4FPmm6EHkCXZ/o1aB4pV37QcEbvM?=
 =?us-ascii?Q?+tEbYO4TsEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIE+NGkGRtInX3Ln5TRaCTQ32zPRr8B2b16LVAYoadxBF1Hr/6yTg2oBL8uQ?=
 =?us-ascii?Q?7wLjnJA1qu5/EW3kSlGZCnSEjn5dKaImnaLzg5EBIU/4eXPqDXkphF96uPTK?=
 =?us-ascii?Q?qGEYoZ4mXN3VAKBMSatV8PFo04ocmLMn4cYjkPAc60ERk6TGMwB2r1o5rhOS?=
 =?us-ascii?Q?dsLpUCsbpbi4nVUo7TtFLHHOA82+GeQQCgdNp+f5N98MWp8wqGGCnjp+qF2y?=
 =?us-ascii?Q?QiAjESvegE8+9T/9vtbAS1kC/B1W6oHrnQ8nnUDkdN6fTKuP5sVGJ+4N/1OP?=
 =?us-ascii?Q?ZiQ84AfRVIiE4pnopBWhOMcFodG70c3eDFIyKOzT1USkjy/zOruvZtysNOY9?=
 =?us-ascii?Q?PKgZOiWshCVPU8LQjdiIbVgXj+oYZoFWBIArTLsdA6WoAjm8GtoRLw6YBuZS?=
 =?us-ascii?Q?sI8AE04TaasrDhGjOie2iag3EI6GrDVuPDnhvCPAekDV4xCfpLtdHwcC5znI?=
 =?us-ascii?Q?tdpNm0WxGZFrnFwXqAH+ElEF4r854rC1+ltjglgGDpmAsP+geKDn0XRqZUnW?=
 =?us-ascii?Q?pLh9VnH4WZpVPFOG55NWpl9pxN45764nUzsFY9hP+ZfvigPUA5gFKHsmgJy+?=
 =?us-ascii?Q?139de46qwE5w7rsJduRmgeCTQcO59LEdNxbdb5q0s65E/ggjIA7kt42L1FQV?=
 =?us-ascii?Q?y2Iei7WQGWjMPP5vFB8jEffCa7iMcRw2N2YGXlsoMdMllsfM2uMLdPnusw3V?=
 =?us-ascii?Q?y0zrXlsGJmaJtopMgVzhRTOrT0IRUen0IXY2vbR7hTnn5/wiKqZIrB9L/cY8?=
 =?us-ascii?Q?5al3AaV7JYXiWNDFhxWqqtCcp10whZIlNmOO7EPzLR9aacSSWEpOLp+U6n2g?=
 =?us-ascii?Q?ndK0rELH+OgtZSCVzafLu7+KXygYXVRQDNf9wRJ3jAPwheg8KRlP06ujnPkO?=
 =?us-ascii?Q?Q2hVIaCJczXiJJrAYAXIXZPqGCu6d7MKT4ZTmjO4+K7kLMooaeADxH3UXhJF?=
 =?us-ascii?Q?A5hDe8KeydQPDRP931knqV8W/1twWys4uG2EOadXhG252EwRrqxbOTbvwRFG?=
 =?us-ascii?Q?iiV8GBA6D0BON4+3SRuo0IIIiy4xkiL2qwgwu6n5bGnc/vsMPgV3dBWQ0YBR?=
 =?us-ascii?Q?AA3ovN5QI4zI+2I0rNo8L15p0CG6RpjKjUxIE8Z23IcZLbBQsykMNz1MtAtT?=
 =?us-ascii?Q?6h6W7ammbxMEu1Cgc6crR2HThy5RCxMi76zPT9P1+8mQzipsN9NyZy3QSXN2?=
 =?us-ascii?Q?fqQLU92MYqbTt7y8Qu1bBV3SqqKvEf51UrdTbJyiTAQwPWkSU1f+hQUsw4UP?=
 =?us-ascii?Q?g0+AkOMSshLd4XvDdvYIkEKq1nkPv2XPO8ZRvj1f8XoLGp6/kSXacljJMrow?=
 =?us-ascii?Q?AygD5GmmONKGVU00F6ISjeUamRD1+17pLSviN0Bz4nXKyg7V+X5UoNKK2PCJ?=
 =?us-ascii?Q?7FkRNd25Z065Uf34eS8/uboLnu4JBbjodLZtLZisYD87T6UTK4VAWJzJVnwd?=
 =?us-ascii?Q?swwcB2IZi+5chz6yYWE2g/NMBh9OvpuIwMmVKCbv/9lYsQuP8/bq6LRuIxCB?=
 =?us-ascii?Q?1cMErCWanRvtTAdBbw35b8b80CfuTdR/maYo4UN6Ezt6mMi1VChXpSWBopWK?=
 =?us-ascii?Q?GzPLdOuEjmBQWJUDQT9zDaocftclS+FIg/D1S+dy6FjJyyq70WfShFlx+seb?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KDxLQ2/WEqt8XyQ2s8j3MeS6AYzt0pbiYYZFhh6zZfMxBZV41vkE4rE30CV835sMdSmoUMqiPwr8aJiir4OcuZTfWlrC8MI1YBMOR90bDvLNxioi+tseMkyRbwM7fRA6avy/QoWJQPvhd3HCmWhMdjPrWE3952tI/c68us025WOiTKGkhLFOnT/y69jz7PsK9ByV9/kQAU62CyvnFIpu6DBnQUpbrsA5xsAsbEfA7a5Y9ZHOeb8G4EU9Wsc+6xxD2OSC0a14H7Qn5+ptACmfqWQAYOPVx298QW96ZMtKIcbDQH5HvQnfpHSeTuje1CV23WVS7WnHy2JU01ZOS/yI2FGfMkA/9l2a/QLzBA4zK62YbFRFybZ4OipjZ8ULUMkRGCVlcRwNcvRHJmb2jSLD7igQ5d7JGr7hZaPsdqTLBy/B8BgmLoW2IhoTWTXScB2NFwZ1DdJNR77elh84GMo8mDz+ZxRGZPLT0MQi9vZo8tgmzbC2ZNadbuLZprFer+BR/4Df9jSD8vFC4/ACf9z0zm0QILuoZoKvgE94GCKMz64LeB3ZrE9uTQNis2PyicjrqnMrAllPV1B5r7poBS3vD54ZpmVKgDHRyO3OFKqzFIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a38fd-439a-43ef-60f1-08ddc552ddb3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:25.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvDL9oRSGGCnB53bWLhjsTeHXKpLbukP8eFeriPeGanJcTc/oxTGvd74OBTr/Vva28CuDz8+PrZ7e0OtcsMDJ9jK34PI0QZF3HtF9Gqf588=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-GUID: 6JeQyfXQMwPsNVG7jbTqPWWuPdRJzbaA
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68792b3c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vjQNCPEVpfjC6StvhboA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 6JeQyfXQMwPsNVG7jbTqPWWuPdRJzbaA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX6fdzb8nPdoLM L/UtumJcJahBbguVsQCVahsz4AfmiKwmh73ndHYMux/9CXEMQGmkEmkVdyCPtplfoU6w+RlYRIP YhYbu+oxXdoj46dFOFXSpuHidwuhvtCW6JJH7Rx0LNW+6Ti3jlUFbhrTvYfnjjM6kFE04rTlb8P
 WON0Ky+0C6XyuDWiAtvUVwzujvoP0JGsZOJ5Bg1bJo+6YvRq6pbxbamG1gj03tHF0WrC0AQdg9b yLO42Q8/0faLJ2HJov3K/gaH9Z2ROxg9zKAsZhXcrb5xbqPSb4ef9RNLCJNauwzfwc1f9sADbRB FwGuOm4n7re4DlnTxba83+L7eAawoubGISbgegf+REV0uKi0isFZCi8d4MM4Owb1EnvlbAMwhaX
 XUOEPf+w4ve6LaLwbrpY2wb9aHRc/R8hsSM2cShNxD5mxalYq7r4EZFAElTSJceNnbJOF0kx

When an mlock()'d VMA is expanded, we need to populate the expanded region
to maintain the contract that all mlock()'d memory is present (albeit -
with some period after mmap unlock where the expanded part of the mapping
remains unfaulted).

The current implementation is very unclear, so make it absolutely explicit
under what circumstances we do this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3678f21c2c36..28e776cddc08 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -65,7 +65,7 @@ struct vma_remap_struct {
 
 	/* Internal state, determined in do_mremap(). */
 	unsigned long delta;		/* Absolute delta of old_len,new_len. */
-	bool mlocked;			/* Was the VMA mlock()'d? */
+	bool populate_expand;		/* mlock()'d expanded, must populate. */
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
@@ -1010,10 +1010,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 	struct vm_area_struct *vma = vrm->vma;
 
 	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
 }
 
 /*
@@ -1653,6 +1651,10 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (new_len <= old_len)
 		return 0;
 
+	/* We are expanding and the VMA is mlock()'d so we need to populate. */
+	if (vma->vm_flags & VM_LOCKED)
+		vrm->populate_expand = true;
+
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
@@ -1773,7 +1775,8 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
+	/* VMA mlock'd + was expanded, so populated expanded region. */
+	if (!failed && vrm->populate_expand)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
 	notify_uffd(vrm, failed);
-- 
2.50.1


