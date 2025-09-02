Return-Path: <linux-fsdevel+bounces-59979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE502B3FEE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F2163233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6F2FD1CE;
	Tue,  2 Sep 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qbezXFAe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RgoWYoB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37532FD1AD;
	Tue,  2 Sep 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814037; cv=fail; b=TgMNOZ5neG06sVSMieWwQzsbgNm9WgAYXMUzGlEnnBjq8a/Yz9dWZQ1uxmbB7vGhPcFkLgXXPrGlb1IzzYvWBtyKdpasBrBbFc97FBaaGYGCxRxZk9VCu8ssvBP90R6Xr86qve+2yBGF4+7vMkj3ml0sDbBxs3LUMQ0S6EQE6MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814037; c=relaxed/simple;
	bh=qZoJWB6f5W2Y7QJVeX+JGngH98EkP0++DMEIJBHGSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F3uRMjxQ/+JJscjVzV9g002BpIK4ghf567zKmwiIVwaPYTwFhg4/qPcg5fKorMuqxpQGqZyq5V+pe5LDM4LJP20TdaukrB2/nf3uwBtBsgAoI3ZXatZE8MTU3eUgoWvyqu/FtaI8FUCqfI/oqLL/jRVGQa3EpDCG0eHo6fVdLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qbezXFAe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RgoWYoB7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANhDf005309;
	Tue, 2 Sep 2025 11:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=RiLtJrx+xDz0gFzW
	y2zGTF8v4OVbuqBvHd5p4Z7b17s=; b=qbezXFAe/vJmr2IdcnjK/aMElUHGk/IL
	nmNgdj2CYL1nUW3SbsoSd0PYX6Mgx22QdbkKR3mZ9zYNICG8G5pxHnEvym4dNU1A
	kmY52pVff9kDijGz4xJcbOfmLvBLikV5dGYGGv078XYBsNMALoNAyw2JWMGnC4pu
	cRZOE47pRLL2Xf2Rk1kKiLi1JDgeY6ztl77PToqXHpTpmYwpAnQFStlD4pPqFFb/
	Eo5qY8XGIKHz8luysaIHaIu5J4P0zsU7ns3ZECN60x/AWXv1tcZ8YmF2rxI9coZP
	R8rHKmhx0Mlw6wfN+0BZI/PAqd/5bZlLqd/W/UpH+tP8VSv3QO0PNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushguv0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 11:53:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582BqDFh030968;
	Tue, 2 Sep 2025 11:53:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr92dyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 11:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhDA7N+oNjP93Ekf9VulYPvkwgeVtY8jpsMZDDJoF2dt8jsByMrpkaU2eKT5beaTAq9Zvk/wltVOpAeGqQhE9bKzSRNoEARihEUKQT8TXwV2bIAZmzPspyHEerMwfqyVGk9C1T/Lutx1vylkI9Sxw2mYc28sCNgNjdZ8NgvRvShrTnB8UPeYYWSr9Sz38kEyOPlH0W6xn9HegFyRU/+9GINL/0Id6Xbs8bAlAKQBq05Ohtct5KHfZGhg+iksJ4Oj15QtuAsUzFF61kMv2h+92XvOdp+jj1FPVdz+lD4SdHOhbysjTy/QTa1Jji9IxTSHqkA2q/S1Ttg4PWmOIm7lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiLtJrx+xDz0gFzWy2zGTF8v4OVbuqBvHd5p4Z7b17s=;
 b=CpMWyllQ2ju8YbLR4jPQhEOsyahBBBMYhQ0CiNXdUSUf30226TOvX0vxh4LsZEvo9lgQIoYKC1MwmD0TFzZbXANVdRbP+RNxw4YB+aO7sMyWCB/sxGYaKUkCmXTHXsqXGNNqSTVZxKgJ0XUGNJa8oIaIaRqxW3UV23wUptRMTr3eCeEtZdWtAk11FC/id0wM/JAP8lV5REpJxZBrfbywq4CPS0glKYpH0ZP97hqB26gMiOv3LA0cAUq4PGGML55o2y+MhgDjZh5N3IwB/tCQiaS+QFgwboeFJlbgtq8uJjIKPmWYhZXwITD/UODKkDhJ96IjeZzOw6Vuj7jl15U4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiLtJrx+xDz0gFzWy2zGTF8v4OVbuqBvHd5p4Z7b17s=;
 b=RgoWYoB75zOPcX0C/NgaP8dssUwGtfE1QN0p8v5A68CPDWcqOG6Ao7RRrKN/3VFJDmxd9ny96SFNlwrP+pW5EWzGwg3+7dVG/h5rqQVRrBlQQECuYJPdOrhmzRFSgqk+QPzXkW/zBppJl55UTnrIgIvPn6JKdPF54C2mvzaDaZA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Tue, 2 Sep
 2025 11:53:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:53:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2, udf: update to use mmap_prepare
Date: Tue,  2 Sep 2025 12:53:41 +0100
Message-ID: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 113e4cff-2250-4093-1312-08ddea175ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfOCuKPjmbWuK1IAuncrjDE2V0V1DRzYUxwwN5ehPlP4+tzzixvcM2YcfjhP?=
 =?us-ascii?Q?lNY5valL4ZTciDUkd779Fo7rRvoFPyv2YPhU7wRpwGL1YGk2u7C/b+Q5N8a9?=
 =?us-ascii?Q?vQJ6HysEN+8rw4Ze51QTYTA7loxYm/Zaq213/qmKb01CEIlPepVkSpcRKXDq?=
 =?us-ascii?Q?SHZZCKrKlNhQdy1Re+FQCId/CF1NwgB8/5VOycpFDTwWc/YlBFpa1eOJFOdG?=
 =?us-ascii?Q?BEn/jBVoMxWYJV/k8PJ4dZi65xqZcyrVKrPkmQcbMBy/O8jeQFkIKI8epfWD?=
 =?us-ascii?Q?+y68OuwUs5/3QbTiIRirti1nkquukFMXB9pBaT7BrhgVMRPWICPYgbk7qlHB?=
 =?us-ascii?Q?zJ8lZ8FPT5U/vB69Xt0bqELoUZXLCCoGc52GRqhIt3jK9U2ajSlxGibUlVwC?=
 =?us-ascii?Q?EJhTSdDNibpJ+FthOJytMtVvacXrGvKXNZxTz7JhTVeSNSzjnDnHnHD1yNfd?=
 =?us-ascii?Q?6VNp/YeyTRktnkZiK/Pth5VLaivGR5b+GwEOzFzvDozu/VQMHJ3Mgfahq5vG?=
 =?us-ascii?Q?WSRRwcGq4npIOJfiedUJ3E0p5WYMOrL8ueA4CFBwA6QJJlg7ZQ9Y3IEWxSCE?=
 =?us-ascii?Q?GgqZ7Mo8bqms0W2wxcNVpLzOHwhTvKFY86ImrMWQY/08uPZKleZ2PDHGoQjI?=
 =?us-ascii?Q?sDdb4BqbDmkGq13iu0/WQ7qQKEt67qdzywbmpscO/qMN7JwJwptrqRXnmgbf?=
 =?us-ascii?Q?oEMncPTImnxPmuPa0TXk0aDQ/fLzWgcJjqyEurrwU+vkcuY+55k4zbDBIU3I?=
 =?us-ascii?Q?Wr9V2gNJMTMQm4RsB4QNFe8H8LXF6ZzCQ356rziJnLwd8EyHQOOTmoq6dZOx?=
 =?us-ascii?Q?8iXmfQyxho/W4SQ5CmADOg/9AI0xbtEISbfn+pcMjahyMImjsYQI1pngmtdk?=
 =?us-ascii?Q?uhR/P6sBONA/kMRduNRPQDxl0bZWF53918pHTeAByRHwBItPfx9S30fwZbZB?=
 =?us-ascii?Q?8snrQjsc8WoxG72K5e/JSQ0JGH7DJrH+aX8RsOUz8ZXFFEmOTGJOiGSYF1S3?=
 =?us-ascii?Q?Acf4o3UL3DBzkMGZL/dz55oiYx8rR6Lgqc40yRCxbIDkcHd4PSDEqCyViBgo?=
 =?us-ascii?Q?nHGyh7rTBtLgtvDW40e8U8gIS8DrixY2UU3LaFA9wv98z8zTY4kOCfxIuyU0?=
 =?us-ascii?Q?Y/gEqQ57PIY8LPpMZlj9SBqI4JnTNdSbJMOKmqZy+GnkrupbNsliJ98B9QoY?=
 =?us-ascii?Q?4xsKY/vI22iqIWP9ifyiSb3eN0xTye72RYMRkL1PUFbxZqOY4MZrLAskBVxL?=
 =?us-ascii?Q?kBkoteAKDDmWNafFDMH0YzQnIkEtb4W4kupqv4rI7G+HBr3iFwHmb5Cx+IsH?=
 =?us-ascii?Q?GUOriavFNyaj95X8KNBdT3x5PbX5T0WCvwoSyd7+btRzCiB3Uud23q1hPj66?=
 =?us-ascii?Q?01NljNO8zfCxt65d6aUIUvrA4ztvWjVqWenjUYdEfy0TtpuyGM8GZVKCi10g?=
 =?us-ascii?Q?9GEorzwVJ3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXwBXUjXCM/4gPmgMD1ShKtnpOW7Ss5bVf8nzpLbFOautYxXI6OMfUgCCfNB?=
 =?us-ascii?Q?LlB0n7SiJPoFyUjzmW1XASpn+JR9WmA5XEVtE+eRqVxju/heNg8XXmLIbVXe?=
 =?us-ascii?Q?q4s7Vc67vKVAF+wzmYyBUlSFyKU6mNlQJka0cibGeMG12/VhPE3qUIac2bIR?=
 =?us-ascii?Q?XiW/zMxoLbWYgHzllSWAAOcZj2OoMqhqAxIFyT/1f2/k7OkPlxZgl02jvxZx?=
 =?us-ascii?Q?AP0Wj6ZSziRaTIryl4PUZGpMp7V4YXr8ogL7EqQwCmNVJ3keq/HbSbfXiEjk?=
 =?us-ascii?Q?8mwGrV32bErxcXugVU/rBNwYbNL7AACWDlNb82vwHNp4gD3K713sSQ/cNTm8?=
 =?us-ascii?Q?WITaEAoW35uGzjNriSSQghTYlfJKjg45lF1Zgd3c564ohBSjFd2otnzneBpp?=
 =?us-ascii?Q?b8+SqgS/LM9gZ3i1mDaIbhT/rb1s95wVUcsJ/AFmSKiQkhIQglvOI1ibgU4t?=
 =?us-ascii?Q?030MyCbHwA6mfadGKMXHOzYAkPdNhv1Dx+1kqYrSgZY1Rd/mqW8lsMnDJVl0?=
 =?us-ascii?Q?35AD1TBXsl6XzaX+lE5V4GO9DQBPkvZggu0g4lnE8VboLFwuHFKBN87FvkC1?=
 =?us-ascii?Q?PDnajM1peaXg4RLqfiJu8MrGc5ikejbFuHkjbMkPTbypIEhJ2//y1/siVkW3?=
 =?us-ascii?Q?FdBEBnTsD1ViZhxwxOxfm5PsDT6OqJjfEiZy1SbQYSb0FKHNfsOfDG5kOgUj?=
 =?us-ascii?Q?Uz7oZNIZc6ZOnLfaOqmv9DFEf1LYvAUxs4af5zWqv/NsGWMgDagdEfdGBHA9?=
 =?us-ascii?Q?nEjI8SL2IWG+Fyd8JwwfhaPjmovuwZziLv4t5hbRlGQHRuA2XbJ2J2ZQ20Qa?=
 =?us-ascii?Q?I5n88RzjabmsdDpTX1yDNGgGsncwm4qy2KGpu48wlM2DgEXDXyB9bAmotTyC?=
 =?us-ascii?Q?lZeUC0AZKhPesgnSYNmZyDQeG7FfQrOj1T7WedffXPjP90s35g76MrFSh/v7?=
 =?us-ascii?Q?ZfdXjS70ZsfAeEj3qbwWW6i/qo49xO8ESjqS/flqyGZfeoGrH5waP60gD6OK?=
 =?us-ascii?Q?UA5F8ladrCP1CbufV3hYtDqgTamm8QBGbslT6yty3x6v3USYL3jRXIB6J+26?=
 =?us-ascii?Q?Qhn4l35VGF9GBxeO0zjRSHyR1szJLGSyom/QgPuBijXDb7n1DDJQQxj8bAbA?=
 =?us-ascii?Q?UU7HZb/bK8iOwTAWozw+VbhBLF0AmJHEbm+JJArf7+0L0R01ehKEXTE6lGsl?=
 =?us-ascii?Q?6ileb8G1/uRC4zUCTQb9npXghtMhZ/vak9CWxtH+w305uRGyFOxecvDkvkb7?=
 =?us-ascii?Q?MVLOJ9+Q0IAQD4IOCE85oE6ZH5CyEryYuTlAhm6xP443UKFf29PcPZ2IKPRH?=
 =?us-ascii?Q?zxmOJ0Qo6Vd4WEtcAwwR2/iCHqPwKJsUhrESMMMDW1dMcwHEdmfZBgDby7ZH?=
 =?us-ascii?Q?pEdZRB8nv4KmgSUE+VsFDwZet+ZGS0jDlYPRfQNh1GLBZz7thK+Bqs/b4zZz?=
 =?us-ascii?Q?IOog1Qz3jFmrEacmhnPIw9hjMJ4EGTEcK3QRVQx/6TAM1LwrpWUsEGtALk9a?=
 =?us-ascii?Q?5TN9fSYerS1IZcZhURscEOsqFB5d1gNLpqFq6l0eElE6lHBhbY5/lyoLV5HO?=
 =?us-ascii?Q?a9Oj8NMAsqSaeDfB490ixB8m1KuGTUTScrSrhuY/nxwAPR48pHRkpwsoNKVO?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ywLcbuJQTP6EXIK3NLvcn8G9nPXHs+ezDyJXM4R1hlYG/OsCzYaef+05yrc5rG0v+pOEjivmLpgYkOE6OlCv+dOBZW2+J8mTa+YmgSj3dUz5qCUn/j6DhVV37/tpC8qIbrRTFGuKinswkrw4GTmXnB105df1gt4oQg96KCS3yBMuHBTAyHulEe9SuOtBlhszaJin1IDRk+A6Sy3MZVZDyxfCTnHfVreYwgK/8pcd0Lm0RDZ6jIfBSGAla/lh71y7pgxKRe3H4O25purf1nXV6ShjcZxKSgq4XQO1YWjpdNlrOkH2JSMjqEAPxQ2/MZdrTIONNEEPv8ogC8eE5MiZJLWYAVZmTbbiVJg9TT1un1ASouTcCRdv8SjHZwG/Nvg69AatI16RpOwztLY/UE7LqGM0i/xxd4oTTggFewFvJUJOs0PgCbwtD19wZStHHl1KDZM8gURnVmF6cxGGLQxIbon3isV6GsG+dYibKnf6kkhgOlc/IApFricNbQRXZxUAox437pHOD/TssGf9T0OT2bwFVSDKNIGOuutC4cXN/hUpGVlwtgn42JQGd0pCA1n+DiasSsvWCY1pBgHBX8oxjyWyUIERjzO97bwgiNisTtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113e4cff-2250-4093-1312-08ddea175ee3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:53:45.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0zt0wXl3HDmPAcpIo99+EfeMx7iCSoQXsaxNExfPZ8uj2Izu/IcxC1kiYDn+hSIB3YJkmz6b9N7PYfj+98fx/kAkykd4ew/B619/PknBGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020117
X-Proofpoint-ORIG-GUID: y4YEq9Se4uYgfVUUt4G128ELjTs3gT4E
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b6dacc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-4aon9W6glDlnRVGX_UA:9 cc=ntf
 awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXw5x+x0E6YhvR
 rP+X+HHjVeBfYZ8EzlG67UlCb5wFcqL/CwKxlcjAi3Zpba6JAWgOzcq/mDcLtYdyaqy0Gaw9Z1b
 7VPNsjKFeSh4WRaa3D7YugeVQG1kezb6+8yKKu7LpAl6UlFOZTJQLONFeJGgqbvbbQCko8lzkbO
 ZCG5ulgf7rW6j5tDz9sveWpqTKL7PsELkDlToe8H7YRI6+ELDU5XP+0tD04AS/tAHaBI5U4ujyb
 vsZtda+Js9azHlMRDNtmhxBBX41xA2IoLYXO7zbSMCOYv9zkTL5lYHVDH4zn04abS1TQOnydazf
 xtAcr0yA6tjat6CY/pJtFxjTf574IG07XAA4wqPGsrlTosnpQ3T19AWhj6f6u1FRnvuY0TfyLxC
 17a0vgKtfSw2F6Dp4mQFDUFnN6+org==
X-Proofpoint-GUID: y4YEq9Se4uYgfVUUt4G128ELjTs3gT4E

The f_op->mmap() callback is deprecated, and we are in the process of
slowly converting users to f_op->mmap_prepare().

While some filesystems require additional work to be done before they can
be converted, the gfs2 and udf filesystems (like most) are simple and can
simply be replaced right away.

This patch adapts them to do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/gfs2/file.c | 12 ++++++------
 fs/udf/file.c  |  8 +++++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index bc67fa058c84..c28ff8786238 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -577,7 +577,7 @@ static const struct vm_operations_struct gfs2_vm_ops = {
 };
 
 /**
- * gfs2_mmap
+ * gfs2_mmap_prepare
  * @file: The file to map
  * @vma: The VMA which described the mapping
  *
@@ -588,8 +588,9 @@ static const struct vm_operations_struct gfs2_vm_ops = {
  * Returns: 0
  */
 
-static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
+static int gfs2_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 
 	if (!(file->f_flags & O_NOATIME) &&
@@ -605,7 +606,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
 		gfs2_glock_dq_uninit(&i_gh);
 		file_accessed(file);
 	}
-	vma->vm_ops = &gfs2_vm_ops;
+	desc->vm_ops = &gfs2_vm_ops;
 
 	return 0;
 }
@@ -1585,7 +1586,7 @@ const struct file_operations gfs2_file_fops = {
 	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
-	.mmap		= gfs2_mmap,
+	.mmap_prepare	= gfs2_mmap,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
@@ -1620,7 +1621,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
-	.mmap		= gfs2_mmap,
+	.mmap_prepare	= gfs2_mmap_prepare,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
@@ -1639,4 +1640,3 @@ const struct file_operations gfs2_dir_fops_nolock = {
 	.fsync		= gfs2_fsync,
 	.llseek		= default_llseek,
 };
-
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0d76c4f37b3e..fbb2d6ba8ca2 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -189,10 +189,12 @@ static int udf_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int udf_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
+
 	file_accessed(file);
-	vma->vm_ops = &udf_file_vm_ops;
+	desc->vm_ops = &udf_file_vm_ops;
 
 	return 0;
 }
@@ -201,7 +203,7 @@ const struct file_operations udf_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.unlocked_ioctl		= udf_ioctl,
 	.open			= generic_file_open,
-	.mmap			= udf_file_mmap,
+	.mmap_prepare		= udf_file_mmap_prepare,
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= generic_file_fsync,
-- 
2.50.1


