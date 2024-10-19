Return-Path: <linux-fsdevel+bounces-32419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43A9A4DF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E31C2316E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0A38DC8;
	Sat, 19 Oct 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5IVSo0d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O4IbyvLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E67462;
	Sat, 19 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342316; cv=fail; b=KzDFofaRpb9+O9TgcVuGPyYRHyrxORLn2UodQ2xB48jl0Zn9jJI6p7qiyeF4Hw2Wz+KdxtIon+TzDa72ovMA4npmAbVHWoUhUSljk+virlG+jZVKrLAqFSOy+mstolP0NqEaiiIDcofwUFfTXgDbVu7M4qMr/OVhACpKGHgT/58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342316; c=relaxed/simple;
	bh=gu8td7d6bH4d1Et/fr0PqDDy3xNjUFQnM6ZhgSGykNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyuUA2EetWvvrj4UzI1AxOftl7f4rb63/I/D9j0950uJyd8o9g/VGsBHMkmpiyQBcX9ZRAGo4YePog3DzTYiURMdSYxIxSvcfBCF5oMg7MQb/3OlmNRUFIQewLdElKP89ii62s/aqHpR6mw7ydU6oFRl/VjGSB6vIWKl/DJpgo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5IVSo0d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O4IbyvLE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J45fOr008760;
	Sat, 19 Oct 2024 12:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OcIJ8jrrzApf5SR3217+LG2qhbrklln3NjgWYaKsowc=; b=
	Y5IVSo0dC7gGMS5kj7jx+gaeQ3nGAxZCv6AMdMhm/y/qszHj6KP+YG5a2hvbJQPS
	mFbOFoNo89C5Rn/rFuj2IQYCoycXT+O6nAQtVvmNKaR8qDE7R69w4aKHOPoQ981W
	Pme8B6MVJY93G54oYXpdXEiGrRH4a5PBGEHJ4uj22ZUPY/XuneMH1Gk2yLyeLb/h
	mvWGfhxAOH0aMS8i5/pw3Y6jszv7gUdsucLtpFzb8r2WTlAGXjyX/B01xplQGwOd
	qfiomINrSX4JWpVRZeSNLZCtfxOBUZyhT6iRbu/daU7tiL8o/NYS1byoiRivOcxh
	7Ts/9DJ5BVhbR33POE/nCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57q89j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JB8OLw026230;
	Sat, 19 Oct 2024 12:51:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c374ssbd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhQ4FDQxQQ9ukdHHstjXWMiz+TG7j0gcNYFQkzKIofb908iR8RFi1/fbBsAysHFTibOIgx5VfVi34ALN73ruTJw2XpFX8/5i6ml7YR6imFFRNmSZ8jITZzq72/0qp5V0g4syDO2aCK8tm0y4tpFhvcGyQhSYdx6izUDf7j22EA6E1woy8jWOWg2QLphSPIQlCbHoZmrtC7NvC5q/7yQRZ9yxVIVbTEWdmBc02QhzkV9X6TwVITekhRcxgUPxOPK10mamG2pDor56/KhAVW5uLlA2hMgNuFCM0ZLgPnXhu77zxFhvKLCFsH2hReNF6ZmnPUuPusDF5JyltWQtPhTQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcIJ8jrrzApf5SR3217+LG2qhbrklln3NjgWYaKsowc=;
 b=cuAbN/F2eeyyln/pic9yJoxQa/pD1tdL2SiJUUTv+exGT6k9UlXSXsORSLicev2RoM3ohZc9IzKYCvMwHnYnqH09EiLhv8AVP7BO0iNSLqwvd7Ct2LgkfoEunRnxxGwhWlph5mw7+hjzZP5gRp+srDZY9thiShFqUCGgNpIJqXihPlzAUCVnW94x3xnxQVdVQG4PrL0zioeZrHs6pn6SdaXSbk59VJwkclXv5wlzn0skcJKm99gbCVW6Ntk4blmJvEgs0GgSKevXYtDgJ+BmHxaFUKJnz4xQ86dN+dfuNsSMmcU0BRS5Wrl+2cJhIPH6B12uzNhCbRo+Ieww11LrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcIJ8jrrzApf5SR3217+LG2qhbrklln3NjgWYaKsowc=;
 b=O4IbyvLE1VsZIpv6Toh5Vz4be2KbMmGHsW1ddj759mha0ImFm0ejWOM2quYPs+XYdZHG/KZCu05I1XQtlsMQ9aPfQ+5eRPh4rRHAxtGhbPcbFSxxgYokQ9+Qp9Bo7NW+iAAfyEz5LJ9XKnJazOCLNxVD8yL7z7Dt2f6G8BAoH2E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 5/8] fs: iomap: Atomic write support
Date: Sat, 19 Oct 2024 12:51:10 +0000
Message-Id: <20241019125113.369994-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7585ee1f-7c70-4081-d14d-08dcf03cc050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKO6GRgh2Wy8lrj6bI1aeHWZuw2odPF5esbpBPz9JPjaosGIP0iTVjG2Krtl?=
 =?us-ascii?Q?bkB8vSIvH9vENPU6u7/D9rBuTYESRjM6YEFvBw5BCf0MhC044U20rd+3KZg/?=
 =?us-ascii?Q?e+ai2H1Z+njIpH2MAv78sjxGbYIUusFDjR91AdiDcNgUX9Ao0R97zQjhTgmm?=
 =?us-ascii?Q?4oaMeKcVHZbSCUbErpbJoBeEgqU4dl9zx1bLqoowYSgKHVLSehLnB97pyoHh?=
 =?us-ascii?Q?U3uk4FAOMClvUvE9mdhX9+WNGKluTtPkm3VpOVtewJT880132G3Hq8qyi51E?=
 =?us-ascii?Q?CsQe2oFtE5FHzywfk6pNG2nwuwxqkVYIlyKE6psYGkxunJCtJ5elHZ02btDz?=
 =?us-ascii?Q?Ltgf2zZxS3sNsrwRQBCmwbY6ai9RAyL0ZyMIku6ONKKHkDLLzhJzl1qjrGXH?=
 =?us-ascii?Q?uRn5yfgjyMnVwCeuprECqJ6qo0reQjCDzQJjpg5Ifnlte+q8GKpKEAoHtcxM?=
 =?us-ascii?Q?3EPbDUHC8pN/IUw4NMlFoYLv/W05eLd8c8LOxyyh0eO1RMRXti7B5GC2o5l+?=
 =?us-ascii?Q?kUXQ9xlZH53Gd1/6GNalv0GzSzm5zrgdBDLOIP9Gul7SCpfc0xFV/mk81DfL?=
 =?us-ascii?Q?OebIDiVv/CdD0Pe21uohxq+VaKVDIW7LaPwicisvn9n2hAjrZEdAHMrUhM5F?=
 =?us-ascii?Q?WyrUAz2YTWl9MGB2hDX/zzj6I1kt1WGfVC6zvr93pQ2txOozbzXQwJFBHo8G?=
 =?us-ascii?Q?NgH7q93daixXA9l4oak1TSfRKUxhLboMysYEjA/KefB0kpSjVIu7nBI/A8DW?=
 =?us-ascii?Q?OK4CC+2OBNUmqRn5/WnGT5OoJY7cWDjO8+JESD7ZOUrciOeZJU/4Vi70Bz+n?=
 =?us-ascii?Q?pnFoP0DSeXwtdHo4dxzK10067oQ7PTG6vbZsfxcptx9uBG8fe7HgKaosy2hP?=
 =?us-ascii?Q?tL/ms3ag9CosTIZXlmYlAZx2uUuosSoO1hS4bNeFMTpssknwPeZO4UuZMZEg?=
 =?us-ascii?Q?dlwQxK+ZkXxNQ2DtkGlOoiaibJondGvh9W6I+7egUB3g7BkhVaHAfnpgvxdO?=
 =?us-ascii?Q?Nf3AIH6GSZjIdcQAhtOizX0T+wrernKDqmRHEt62u3zGydwUWJUEL4xi2GTH?=
 =?us-ascii?Q?ku2z69Op7n6/Hqt8pqmVex5zVe/kfm9H7bxvAv8nVB0MGS8VlrLAwKsuR7+c?=
 =?us-ascii?Q?ulR00ZB/7XotkV2vrsCkqG06X2G0PyBW09lQ3m1UhUuES8LcqQUGFwK1TnFp?=
 =?us-ascii?Q?1HfEJdve0h5ahkYOJ6Nr7yGxzyHydGHecnaa/qazdNCludrb2jAIjatXeKUJ?=
 =?us-ascii?Q?5V4bv2KbcyqWikiKNbK/8yqdQ6nTkD1IcTBENENF5o8cB9bCGFSfMIZUcI2X?=
 =?us-ascii?Q?fyN74Qvly8VLMrXLJEsDLC/F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rno6ZXwRKBEkyaYMmCX4/tl6xpepT2g/3vjUrvm9vN0rCa3aPbAasD5VvyNp?=
 =?us-ascii?Q?rVT+5pbXFUCN2oHe/K/4y0dTfnI2IxEPGOkyigG0u/bLTm/q7KWRdk/V+LMU?=
 =?us-ascii?Q?ZrSUviwC/cjLgrQUn8MH/OeXZ7aVg/e4YBaBUTFAGVL+w2d4cuwWxZltcKyv?=
 =?us-ascii?Q?GUYtxrQlrLF5YY4tWfGdDQ4sL5+R766wRIVnTp3WI2n8yXTqtuqY6okn7h/F?=
 =?us-ascii?Q?V/B3ws8WMJhed8sZynID6tMB9UEDpLTpI0fWcux6Nfl9CdCKj509QpOxbWVr?=
 =?us-ascii?Q?CgAKmAFhdgcrCAPX5Pa2e6xufDBm68Mhg4WawyBZv2nep7HbSLEKfLs9sFed?=
 =?us-ascii?Q?HJFxkc5Lf3tGewuMp2wwPopwwCA/YkoT1gQpffxqZZmAryg+MbDtxmm2SHLX?=
 =?us-ascii?Q?/2Z7gFACyT8HqfARCHoY4PZ+RoSNiuT9MO8br+eb43KRj65EklmU9dFGB760?=
 =?us-ascii?Q?QYH1D8aTwSGWKPGTLNJqOAXmlArnscnX8+WBGVDcrlYa8BkMbk9qJ3Pcmtyd?=
 =?us-ascii?Q?hJtTStauA7aqOaIPbxCq6+nX1ZZ5oU/vRT6NH5H0t9RZA8vdkHHFqQXYhqrg?=
 =?us-ascii?Q?UbYBQ7ODmGiCa2p+SLDNSyqF+uPaV+p9LM6DMxTNeV7LxJQsgn7bH+LYl+fn?=
 =?us-ascii?Q?DVNh9HHLsTiJLZ0BwPRXr39mFNIB9rsNy2qU1QydzzBCmniZvGpBzMBTCh2b?=
 =?us-ascii?Q?e0RQNAdaBk/5RiZtTT1ANn2k5/uYua3V+qI12kjg6KoxAfoQDHvXeg9YYCXT?=
 =?us-ascii?Q?/2vfF3YcZwqE+8O2YzQq6CAVIon8z4zxYWJABqSQJ9DfjmvrE3Hf7bchLA9O?=
 =?us-ascii?Q?Tiq4VWjBzNC0EXYgNwVV2h/CWiQo2XKEw5fl4QKz2ERjBGGKlGqjvsgoL0Mw?=
 =?us-ascii?Q?SX8L9MyZy2K4gaOSWmPPay1r3Y9E4wI3ucRaz9ecflpTQvKeDhy8EW8VriT/?=
 =?us-ascii?Q?y3hRr+dUmFKyfBi35l5q3g8DW57TLsMuPWvfdeWIKCJuzMPv9fovQ/Ox6S8S?=
 =?us-ascii?Q?7NKUXW1Vmn7cyZ71jlNXmmad+f01vJtBIso8fuEhRdrTuNkR0SIcAWHClVoY?=
 =?us-ascii?Q?Ey7/fbus+8sojLyvxinTJfCc+vdFqzItmqLrPb9MsH+RMU9Y/ZNBj7ermO7B?=
 =?us-ascii?Q?QKTM5nf4YL2j9RVrjht739Cd9W93DrHVTeXHWfRu5zWCwpYOjZn0BDhhZNxE?=
 =?us-ascii?Q?WOJmXCvFtJlHxOh+/h82YdfeQ4tDVyWb7FluKNKgP8+Rat739/xG6LUnSiB6?=
 =?us-ascii?Q?psQdgBiiSMaq3/fn/4aaRMjW2sZYJuez3QF91mSmJCI04PefmHc/tXWWQUpG?=
 =?us-ascii?Q?hAzcQeedXgcBS3ScmEyAQexfoLZuAp/VSlqBdxDC/ZZNF3plufZrsOs0hP7u?=
 =?us-ascii?Q?uQcOOFrTaP4vfOLNbHdqCbozkL23gioX6ovv8g1NOF7SQU6ymBil47nMNorF?=
 =?us-ascii?Q?PQ8+z/TwoXKJ/pcoG3apiJLfFQBPg9cL44QnOf7wB8umGnKThfColDt+qzxS?=
 =?us-ascii?Q?93TO5G8vSzVmK40Eu/gdjRRGg9BwfbMwSYg+H55o3KTwA6wxYpskm7MbmPoU?=
 =?us-ascii?Q?/+NtKimfhehjPV8PyTwJALXZk8fpN0NhFKVcC4cXogSf8vcyK3e/8dNpf++a?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YxfFiqlq4oYXCYFpRH3IyW9exgVWkzvZazYIEJgI+apdbFkXGo4udX9NAh0Xn9bOFzs2erHlonQUqKjqWJcL7D50LW8uRq2yhAU1vFQWCBLFzWKogRYB5eJUuzOcpn5rBA7wVqpLI82WsLn0UmTzAoPuAX/SJ7JroJCfob6jqczp6HWl6VZNp1Sig90j1y6syIYtVByZbES4NGqQCCq/CWpC1KjhYG5ggwNa9hN2DFIQvF+SMzD096kbKc9dlrhh5fCw1CYyZG5bIsm5eO9MWCIAkAlOnBaihK7ChEpAdbRoIumUFV8Jkuot6fZJ+BP+w86yRHnZ6N6tArodkOVNmNTEXKoElv6ey6jSBhXzU7ho31gsJjR9htLIFe+mRihaU+EboV9PVywDkeAlIZrHIxmnmc3ZH+z8Pttm5EnAXcfxpUfsK2MdeSfsCixg4mJXkUsnFezfNk9YZoTwNKjncumbzwtuqZJmLD0Gbg6DRMR0fyDin7Rc0scNmnY4MOomJGznVerfD5Xi7PZUrm5c+efeBbBvfFG08f6+NoGUv4QoLTsifMMIMW+ayf52kwKC3d4N9dizK35lJoTfYceJIfl8H+WH45SUj3Qi6VbjgSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7585ee1f-7c70-4081-d14d-08dcf03cc050
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:29.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlYD9ruTzSZQV+teiIU7o8/cE2qc7lWzvhDEbmM+1Dtmyi6dJ5UrRU2pp71hgkCYaNgEaXHGeYTWifvLJ3Rnrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-ORIG-GUID: 8jCUnRM7xHyVDaq_jLByIgmGzGiQkVlS
X-Proofpoint-GUID: 8jCUnRM7xHyVDaq_jLByIgmGzGiQkVlS

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

Initially FSes (XFS) should only support writing a single FS block
atomically.

As with any atomic write, we should produce a single bio which covers the
complete write length.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../filesystems/iomap/operations.rst          | 12 ++++++
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 include/linux/iomap.h                         |  1 +
 4 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index b93115ab8748..529f81dd3d2c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,18 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
+ * ``IOMAP_ATOMIC``: This write is being issued with torn-write
+   protection.
+   Only a single bio can be created for the write, and the write must
+   not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
+   set.
+   The file range to write must be aligned to satisfy the requirements
+   of both the filesystem and the underlying block device's atomic
+   commit capabilities.
+   If filesystem metadata updates are required (e.g. unwritten extent
+   conversion or copy on write), all updates for the entire file range
+   must be committed atomically as well.
+
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f637aa0706a3..ed4764e3b8f0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
+	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (atomic && length != fs_block_size)
+		return -EINVAL;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (WARN_ON_ONCE(atomic && n != length)) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail (complete FS block), similar to when
+			 * bio_iov_iter_get_pages() returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iomi.flags |= IOMAP_ATOMIC;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -659,7 +679,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				if (iocb->ki_flags & IOCB_ATOMIC) {
+					/*
+					 * folio invalidation failed, maybe
+					 * this is transient, unlock and see if
+					 * the caller tries again.
+					 */
+					ret = -EAGAIN;
+				} else {
+					/* fall back to buffered write */
+					ret = -ENOTBLK;
+				}
 			}
 			goto out_free_dio;
 		}
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d0420e962ffd..84282db3e4c1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


