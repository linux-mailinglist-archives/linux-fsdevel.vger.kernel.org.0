Return-Path: <linux-fsdevel+bounces-48000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD9AA8544
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7313BDF4F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753601A23B0;
	Sun,  4 May 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXSSGwox";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h7FL5KkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16864189B91;
	Sun,  4 May 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349286; cv=fail; b=FM/ZzqKaUSiqHru8LaNiKzRxOFV06Pp7CKj2bRFhFibBlEW5z8w8oW+KciH95bM3fYPx2csUqvA2NakUr/5623IPHXy61G6z4QIbHJX3ndMAi5aBeGJOOmmlpZZm697V53et77VR8PDiGP7i6/hgM1829xgBTWZb/2YCEaALK58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349286; c=relaxed/simple;
	bh=9eT+lXdOnGGoGzrugdHnlM6/gxGf6vdsPRVIvBGiSt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFUHkCrTYbx1cGR/2OMRLZcW+mhTa7atMIMaNQ18VAus1cPK5ysRH1QjBx+HnBTOIDWvGwLHVXgsLnGP66lEQGlk4c4rDXJinTSN11cxd9xanoDyUViGkJ6leICY0kJPwVZlVTfDIeC4ImjTXkVkdh4UOExIHaqviWsilwO2vzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXSSGwox; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h7FL5KkS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54477nHl016036;
	Sun, 4 May 2025 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=; b=
	MXSSGwox0+PRmCsliYlUuZ+bFG6uszSRRWHDLMAF+I9Enk7gi7wOKkCyxhRuXhch
	SYfvHAS57KqXnWxn9lcvPpYhqNF7LW0KRLu97v0tUdyByQXo4AcYyOZsy3hkQo/z
	mDeenljiHUOK/pauUpSNFzXcToleYqIKbo4ICF8s+F5z09czt34SiBrNc8W9F2ZS
	4izEVHM31SQebdpeqFJVwMTy8EMICgNIKt+nWbdZxElafgjFJ+9c1q6ueDqkAMMO
	TfTwqg9jg15mi1zrLgWbNIQ/JWP0ndi2iDQscOXuMO1tD01GbhnXZWUFJ+2ZDgi0
	eBD1sa+or7B7vVUmWlribw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3jk03yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54465cW2035553;
	Sun, 4 May 2025 09:00:09 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd0776-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7Nh3BBaXXyojAeyrJHwDVun5vDdrojQlmExco0X8NpJTmenIj5+jP7EKdDQD0RtnfLbxr0HXxz6XTj1mU9ud65qUqNyVwOKbUWFNLKKFYYOItLzTyYLe51uwJygtADIaDqWWulsi0js4ZrtiHi4DkpCmTJARFLIrbJ+LZuWcZ0+992fWu8SqIz/PDK+0xV/jg6zuZG+7LKFJTPlp5WyqJyLPTG4LfGOSwIArQtxcXa8iOs0sNMArLal7GSL7YiW75O0RQiVZ4p7ybP0G4aEyF67IsAAQ8vU+j5Ii9PZeq8gjjkcZPOrSGvSYkesKNQxHTM3+MG6UYzEQg5+61rcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=e1CeScIHkcOl6ouuvvnymudmC5AGOU4Owyq/1ZxD4UZ4rGjwyeQhUWFd/P3ugjJQf6DXVxgvq/lAqE4R65gF0RFA6ryKkXl6nl+X0PkDSS6kqnrvld3C5mrGIJqGzQU/MYG+2SHk8zVenz2naevv6E4RQeMfAPjaOjiSlpsO2yL7aLdcho9CCBHCQUXiTEYvX9/BGPVM5ILZK2XFxKcnuRQw9lvgtUxT/Razp0FrSeEYdte3HyJ7+4CH3WTuCic1xL8HTlpsi+9OBvS8yyk4HtE3zTdn/k7N+fRpomIi06rrUp0MLeg/2jTRk3MhnEn+XR0NiGlE6tXyGKXAsm6RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=h7FL5KkSAO6YXud5+V6bu7yoQ0vkXDx4IFab9f5BJdZJ8+HeAkmNkG52HTVtjHEJEGgUWeaX/MZ3a26Q6u/TZqPPf83zq4zFu3+auc5t67vLi3pu3yjUiyyGW4V3jji/Pc9UDc3Pz6M8VDBtJ6lQ6wTq+iJgxJ2ISx4KIxTgPRg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 09/16] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Sun,  4 May 2025 08:59:16 +0000
Message-Id: <20250504085923.1895402-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a200b7-5a45-47ef-6ee0-08dd8aea1137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBVsDlxU9jQhHVUDNLAdDjXkJBDX2NNC+eirv6McH780xnA6DSeckXQJ3VNa?=
 =?us-ascii?Q?+sBolX0OmKXEC7H18o+JajPQ+/dEiP9+04kr1gFKDS6a0V51wXvaHwNHoJRL?=
 =?us-ascii?Q?UfYZY89U4qKaOQolPssB4JJ9SrXbgKDEBLopXm1kHTPvIoYJfLPooMva07iT?=
 =?us-ascii?Q?ocvIVicxkKqKSvcceUAF0OAAjl7jXVXXUT+I9Auof4lni8V3ghqBq/x/8LuG?=
 =?us-ascii?Q?15AnYhnfnUimDVL1nRFwvJdRqOJSRpdYuneDxHkoXAtcVRsQt6WkH2DxwBW+?=
 =?us-ascii?Q?j6cwR8Q/Ca+KBPB3Ek+N8KkSu+B2uwuS/NUg60VE3kKElc7K182Ds35DHOAE?=
 =?us-ascii?Q?vy45wuVcMay5Y7uhcPIfU3qBnKNd0RGERJ4mrsylv/3M812F1808KeOXUlmC?=
 =?us-ascii?Q?HTl2PSJQE1zcjt0bOYExKOmhy+SfuoMtTzo2jkR4G+GN0zMSmDQnJk4PQGsg?=
 =?us-ascii?Q?PSf/b87Lve4/9N7xPY6tgeofBwMOTvznKls5dxKNeCvmkUvnZgZ/IPmz+EzE?=
 =?us-ascii?Q?iHjF+fHqKs9J6l6Bcx9eLwc8WfZDjY0MR6OyVTau/1PsVuRLTo4k/s/d9NQ3?=
 =?us-ascii?Q?U6/AHEF4EnENC0dXWY/5Swe2QrQp0gAH6+mVnk5UNDFBYBqWaXghz2UxLJdI?=
 =?us-ascii?Q?oM+AzGRZWrnkCmQytY7IBwaEVV/VFA4AN7NKpuANwlR8n3NEu7pegxFHGwUw?=
 =?us-ascii?Q?6sJvNohprBBvIi2WQ9MpTM8W0TxPBvFfzdV/G+dl3FzxVHVAjXtCW03l31su?=
 =?us-ascii?Q?ZjNiY8/knxjc1YnjVggHgIyiKrsSlKheD2YT4rGQdYG+Uq0Jci+Jm8bA3dJa?=
 =?us-ascii?Q?agBf2TW2uK/INP//IxPU/T32DvWPE3283CCnRnnj4ois7aQ20UVMAvfqG8HH?=
 =?us-ascii?Q?l2Tx+BI/WcZyeuZpZesg2lobxzE4jPnQQql+OeAhoz/LEb59n26tKVA1JkRY?=
 =?us-ascii?Q?kLNDtDtLZ2UgK+wxsHgyZ8o2YtphjIRXXCD/APjseaiCAZRrCBooAztAQT03?=
 =?us-ascii?Q?CkAl5i/zM0VXVBsSR0tWUYoWFI/LqVLybvD/PNk8iNs6b+pPJyd2+mRUEtAR?=
 =?us-ascii?Q?VPQ39zWLWMUiKCW4xOE1tZOt9c/kIWmJZHHRTThohjJwsvi0XBq7viMV8nNA?=
 =?us-ascii?Q?ncoEWsRrq3MOeK9s00F5X6jR14k3TMV6MvIC3eGpeGzlg+ZXL1TinvfsjABB?=
 =?us-ascii?Q?pjZYOoh+bTV4G9v++phrErEHEOtZmkjgjkhSFrysYOb8iKTXhQS28t63e9F8?=
 =?us-ascii?Q?tpFwC3CENIpuxvKtF8ki3frNwnGV5kjZSt+7Y3e/v53omjAod4Rlen+FR5Bd?=
 =?us-ascii?Q?926TlBBWEBZ2eLpKWnfvrhELKn6psz7zs7RG4j0UENPwUkyfX2QPlRXByKlF?=
 =?us-ascii?Q?l3iwoFdiTpkrghd5YqndbyN/JWxxiqB1yQK3SWnYHseliSXAC5LILg84WhGV?=
 =?us-ascii?Q?auUBmtGzmsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3hpXzPga7WZJTaQ5jNTawV65pHusRiLT5cSsr5pKjXHzN5tEZd9cUlaWFdh?=
 =?us-ascii?Q?whV7eYK3KkysMyHXggROyrpksxfnEVkxali5xzxs70DKBXh07jxWoT0EsR1y?=
 =?us-ascii?Q?zEK7CqGEpvyIlP2hi4cWHr5wld+2lzNPsRN+RvcqMGhPvyk6cLZGYdaVVvJM?=
 =?us-ascii?Q?68Jj1nnB2RZhOBCaSepdvVmtt9QKzXBKu47Rb1z9viE5VVVcWa/NKWD2fZAM?=
 =?us-ascii?Q?6c0IsAKHGmjyhj71/pYRBNv1zabWljM8UIK2gWQumHQKRmDytKCHYTtV/Loa?=
 =?us-ascii?Q?SgKR/wEm4DQVr+gt3clCppH9fFdQ1OaFX1DqVZatW2L4ofgEhD0Pm/VhavMB?=
 =?us-ascii?Q?KI8woCOtzL34myIg/5I+nqZscW65qN2RUCkjL81CePttiFStgJNwiWW/2V9C?=
 =?us-ascii?Q?/YgeEZa6O1b5m/rt6Gc4TPXjtO7f0j1/qjUdpjinFx/AxmDVdX3HoXFtn3ie?=
 =?us-ascii?Q?7IRUpIy7vIkc/7N0VQATqYdMQwMc8G8jL6leGEJnRocacCGR0ekXlHN4kTIt?=
 =?us-ascii?Q?cNIzEMm2qGTewSFvMxq+L+1eTyo0qv6wDTbPowVFyHxqIN32vnf9nLnF2uJ1?=
 =?us-ascii?Q?09WHxcOaf291Y0mHsKCsdAZFSLZywsypkSbQk6Gh8H7EG2RkPk2SrNJdtWe8?=
 =?us-ascii?Q?QQUWoi8a7v2BXTsBixsSlHBCvlmcdQXDpGLqIPh8lqVOE24n3AsFIvs+Kmqr?=
 =?us-ascii?Q?qqrQ+YOoeI9zLvGRHN/lwpmtVoIUlesHxGNrIa2nXxACy8LO2zrA+kCrkbm2?=
 =?us-ascii?Q?+MmeAIb8O4GKbuwAeke6Knh7M43CshwsccTlBko0MVCdFO7H/n+qP5Ga3vVr?=
 =?us-ascii?Q?2d0WIzSIHkwTqc20fn8/DEKtu6J+AAVCtKX0lkH/HnmCUSWAV9aldmmu9Bvv?=
 =?us-ascii?Q?qVv3ybQVZ7+mLRcIVfYFQdN6g1sQdxJHPfiGkIeab92nXYtJ95SgHLQ7aIis?=
 =?us-ascii?Q?uMTXC8kck6AhVwE/8bPKek2UXnanYeME1SWV3Lo0+IrjRPaU4sBtnozl76cB?=
 =?us-ascii?Q?0cBJb3t31+7qNNxYHa/ot125h2vONKhXetRo7CYUiWk9k3g/fztheDx9Vvln?=
 =?us-ascii?Q?Q5d6hRzigvblsznKSRaf9Mr7lH+zbl8rNvGqIHLacBZ2xVuG3TJAynXzM9w1?=
 =?us-ascii?Q?e+jJJByAyKVi6tfJV+hUDYDoHfwLbe/Pi8Db77vDUpnpdZpT9UFyp3UiKLlr?=
 =?us-ascii?Q?3nnngt2k9vXVKA2QWA9Wu8M6U0PqfzYl3rkopIhSym052mRpwZmJvVMu7HYf?=
 =?us-ascii?Q?zvCBTmvDrjIYAccMG0rJeENj4Hi4qHs5E2rEFoSfM2Kr/n5lWsQMvxHqy4Tg?=
 =?us-ascii?Q?q08laTRxAmORkwYT7WNXe8ontokCSYpA3MXUooLx1ocmUhMLM/VCDWyWHp0S?=
 =?us-ascii?Q?IS97fmETCPef6eF0L+jDCGtbV/2GfdfLIlflVzk+6m7lYpA6h5XYIC6QtL3b?=
 =?us-ascii?Q?ywiZMq/sP//LFxU36EJBKtdAXMwVUs8pI9J8sGXUyQRyJsyTuBhLdUGKyUNn?=
 =?us-ascii?Q?K0QvnjyZUo991ErT0dW+DfavOCTkbiy1HA2ZYWsOTLmBXIqjRZfkqa5E/Hf6?=
 =?us-ascii?Q?LdVrC2kJQ6j8XmhNW8aP3HnxLGe3EW2sdA7tNKQTzuTN0M2S/MShixgi5mCp?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w3iVmP5VkfC/FlYMawAhW3rfhkilcGISSyLJwiryljULRFpwV0QVN7HXsYUiKe1hXyc05tDXJcUoczDm5+zOhlpgepuTAhAV8gI/FPB/AaamLG84UZg+DTQa17pu3TwzVZFOhNo6Pa5GI99v4iNUHLxw0f30KYu7PE3T0Vi8EYRFu6mEx4PIYWGomL3/00yNJQPL2bPLBl1+rfA6/FVIZx/hze/MMsj6/Br+TBxnAjSCte/BaZS/PzOcwumF/SUCK+jG4sDErALM6lVWlRsTC1I/TYeOnRlq+qxuKE+KP1DDxrHf3Fo/thexNYH+Ve+g5c+KVEEhOWISeO3GfTmP35XdqOd8mzLv2Yh8adqWKaBWkCk/IOxz5VODDlpDMX5RznzfYl1VlyAtcteTDTS5oow/GUgm1F3pR0q4Sdl6sIek0Lh7zDleSUIJWswOH/3r9/WJXdZVcRhyixo2cjzVRc2UVBdNehu0izDFrj6T99kj7FgTtVpK3jNrjWNl15FhVRCFjOOtxo9O09muq1WZQIsHdwJnt/5t6SnY/q30jsi3PD9LZV+QcrfvCpf4iapB6+dNBDDDlUlu0a1yvzKe4nCo2iJooteP2Ja1fj49Cb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a200b7-5a45-47ef-6ee0-08dd8aea1137
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:07.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRwNHeweSX2QciRCBc7c6tV+t1pfaATVnrpWArYylNWMEVby6xfezyLOQij0AYyxJrjeFwAe05NlA0t0uI6bDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: fwRDk-LmBDr4WyoSIm9_T5kdXppDIa0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2AP/vbiFJtMQ IQtI9mW97kTLYI5dK8CRkPaGWAwAYL2daLnrxPF0Q7fGBkUUmLtZCTouXKDzpgogN5jrt2HdtC3 hJrO22L0jxrn/POmoU5u69E54hwSlApBImnGCkfyI9qbUVxjkdbmK/GpM2bUqUsc5KWTFn3wXk+
 9h6so5rs3HEWAhCrWVaE2kROSGGNItUQ7WbBIBWWfNye1568UqIBIcD+ohgxhb13rrazsQzvrHi epDplBl1QCyt5sCxwhrFKuJri5I9YXDQ0r+vGDN71eCS2a3uKDCRbwt+67jgVLHrmxRTHq3T+po eIGrFzCoMz8h35nFONwIXDVpcRmwRfwScF3kwRxmgNtdeLVC6Ar+JjTqXcbbWcywjCMIRkDyJuH
 iu7D3s+hJRk6oLdzQXXZYZLfUQZVPaT9QnxdrRk4lEXa/Chpz/5w5IhpxVJhLHuXVv+cAlfn
X-Proofpoint-ORIG-GUID: fwRDk-LmBDr4WyoSIm9_T5kdXppDIa0S
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=68172c9a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hT51KhAs6gTkkLCEbPYA:9 cc=ntf awl=host:13130

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 55bdae44e42a..e8acd6ca8f27 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 22432c300fd7..77a0606e9dc9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomic_write(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


