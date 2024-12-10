Return-Path: <linux-fsdevel+bounces-36931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703039EB162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCAD285CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215631A9B32;
	Tue, 10 Dec 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H0vo9Exf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aR0ipz0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20278F44;
	Tue, 10 Dec 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835509; cv=fail; b=T3FNNb8xWpTABlDEC4XmWstFueUuDND7+cENyhb3nsupVTIQPPHLy3Ejq0YVbbXWDc7e8li1DuV/Q3j/dZ6jDgxm7hKfOORNq1/3Uy/8pv4JRQlhvh0hXLTLQHcUBiZCq7O8W9Q2EH/+KbZpaZZzg8pwS4kuGtFg5wELHj3iX3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835509; c=relaxed/simple;
	bh=L+4Knl7nCtqXr5ksJZkH07sbQASo6PXxqrkkVpfcwCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtXzViI0p0XYRoQbEjeVrihQXOskXqkeYQEww4kH1xfy0+GF0QazUqV/Gn4hVQxhyMcYzZVH3X2pZjxaG3r7DUM5zogvz/QfseszMjNazRgOu/HF0e1EXm5B7VKzf3Kn3YBM5DAxnG0NmPdEQtYNgvrVxwEz0dXn+k+ddOE+re8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H0vo9Exf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aR0ipz0e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAALWRg005515;
	Tue, 10 Dec 2024 12:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=; b=
	H0vo9ExffQU5P5dWSIDHWjpC3EWRmcQ1EVrQdqfOFv4uw45zKamjxagVjulQQxv1
	D8Uz4Q0fXOrBbjBmqwRTp0eRCdKd/e+GY5Zxci7nE5H7exF7I+Eh4dlhgphXLubb
	KMArcFiS2FUeNzQfeHLqGfruQxFIiEMqNSCEp9iBMTgM54FCA14fOIzUIsgxfhwd
	531vf8/0L+HMMaf0Wdpf0lVIxlGBhUgWeFlsOjYEtqX5A4AmSUu26r9LHCgUmC2U
	VaTRtcz4BjbnT1v3ju7yRYGgT2M8DD2pJY7JLBickYoStsJzYjY9dfdPeyAsHV3l
	Mi9bHmzRk1S3N7lh/5Xk5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9anrqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACXpPI037949;
	Tue, 10 Dec 2024 12:58:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccteumy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpVuoODtdTMUvhOpdRF/QYQXeLU2fZG8zbc+XBG8y3TRyZvRwCRZoDC8ZMuDYi7/RvIMQLjCI606fgwyzSva/19BPluVuD0fUhJ4k1mbtKHvUsLumoQYlvt3GMt3XhKdILzfzIrHf20IOuJ0OQxoKyKWdDtBb5gIWb5OZyTMKQuI8uyyr/wGPRcvuLriQ5VorldIrULNnH58ItBYSTjMRXBsFvlcJ0ZLRlpsw61iSJiv4+CpFhr2KRV1cqqX3RSdSVcKmqbkUOPvPCWTN84cCY9k/ywzSJXMu+OLfMuf3pmFiyjV/el7lyKJoyNMjWXl/NU8AthuF8efdNBTHgBjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=;
 b=CV0Rieqai3kx5U/L+wLyk/QKPkJhgBJwKAPL8WLgWXs9/PKFw3Xaxp3J53zbQyq8zM+0EBEY+ihUu9u9LRzdqSW8aL6B2xxlLuuraHTzVSB4f1d3O5joI+m7EgXvStUCxbOpaSMzm+l4JTqrYa01guDCcibLPsyOG3jOyi6M7j42mE7Yewbxi061XB6LJU6NepHQbqV234C95HfjL7gJuCahUfkl5aJIGJwUZE6IAzjzcDwDuCSctPYtlatwXG9QKF751ZqHieIaQvS9syqMXpv0qcRihArR6Wx7oL232InCGfsFNuS0yGjyF1dBVa0TcgaqBeB7BsfrhO4f3bKcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=;
 b=aR0ipz0e2YQbAncaeGGoQF9h+gfbCcXQ/q82H2QodB++5hjb4wbNPtkGvjiUs3YHelZNwAylITHPEhT4UoJnnwp9/xe324Ep07DfSSCbcKQyaazIafgzidv6oZblEv/Nt3jmHwntfeFACkPbDBqtscBm7S12q3UrEA98P6KQVUg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:57:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:57:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/7] iomap: Increase iomap_dio_zero() size limit
Date: Tue, 10 Dec 2024 12:57:31 +0000
Message-Id: <20241210125737.786928-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea554e-3fec-4d1a-db01-08dd191a4252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAUuRdeZHSQugoDAMznaJ1rEO4ma9CubzCUmSdOOW1Vbsa75u/8RMB04fpfQ?=
 =?us-ascii?Q?Dd/wIpfm7fxxxl1xga80tYNvrm78PTF+ZO4Atesua6OyMOCr27grmQe9Gmv/?=
 =?us-ascii?Q?wFg+056r3lfGOTSr7qxUFHa/M42f1h+Z2sbFBYVbyRapRyILFPA350sAfgmV?=
 =?us-ascii?Q?JGdeVz9ZmzsUj/txYLFLQNx02yShesPn1TxilwM7GvojA6n2sl2T2raLYuCX?=
 =?us-ascii?Q?Hhb6EI5XIJy5+rHgjENTcnSVJwRD6vfPphWxaU/1WNmNXqTy9SLqh1EkiTJk?=
 =?us-ascii?Q?Kdja+OiuFZkq9rRy3IcsTkyEGLuj7vVRTXgZ/MNGM0e+3mYiiGYKHGSSpqCk?=
 =?us-ascii?Q?UV7IiwyiONg51EZavAlkuiE6Vs3Npwgayn4jWTd7tseGEpAtBJpNrHI9UarG?=
 =?us-ascii?Q?JB2p0cxOZD1X0AlUYKZCvESluwAZCyHmUHU0M/3tMLwc4GWsMVVQ5xoXCUGk?=
 =?us-ascii?Q?PhfybhjfyFJK2JXs+W/pVNQJ6UQknW9bsfJI1HU8eCxNbx0XT69pZU2av7qH?=
 =?us-ascii?Q?U4ku0mC0ke6/vfWvZpO8BA3fewxwMm0029OJhd0HG77TOEnUQtRivFiqlpUW?=
 =?us-ascii?Q?g5AbWQQKaDjH/paIsN51K6chViAMY+CJNEsPslDNwJVcFyq7Z57rAbpaqNf9?=
 =?us-ascii?Q?fPH0saEVOKVTkatZ07+rWH6QNOZGrZjVTLWJxahGhgFsTBa6dJVeoOfXT4Pe?=
 =?us-ascii?Q?oofqhHROC1UEEfohBBTZqr1HQYJxF3FpqiIzuJrIF7b/lqAihXqndATn5mUd?=
 =?us-ascii?Q?s7Z4Rtf9yI3HwWPDrsZX0BSOsEOwXU3yLO76WOQbQHO2157QOsgUr3wluMPE?=
 =?us-ascii?Q?spacwA4jupzQaTRdIuKwEfAykjhMMuqlgHwSSV87ErMfhhWnF5UroGYPuKcr?=
 =?us-ascii?Q?+oCnTWpFLyQ4BoZkwhpogK7KgX03oDeSzAeG57t/3ibGLU4sSz2JwHsbrYo6?=
 =?us-ascii?Q?TqqutIs54P3cAYnc+be7exliuHNE1g21F6f4ySPMs0GhaCxuMvAVAMxL3Eyr?=
 =?us-ascii?Q?5NFxPearIwWzae64vrTpW/L1SwxnNHP+y8LHgLeHK8k1HD4c+xIBAdKgkz7j?=
 =?us-ascii?Q?BpRdkht3UcFwKcZ25m0PUBFijLHAZqXYp36Y6TjxtGyKIuTRu4Eb17KR4iPr?=
 =?us-ascii?Q?Iy6J29QA3f5W/YpCML8GByRsCALiNyp4s3XRzIM2ncJzTLkUqiw+Z7CVLGiX?=
 =?us-ascii?Q?PfC5qcF6gSVsbZckhifRtDu9OVCa1lqOXu8HHgDUZNhKgT/7Sdmu2FYXPL52?=
 =?us-ascii?Q?u6m4h3IHPxl7JoyDAmVqGadwi3Lpf1etm/bY9VIr2Q9xWKAl3rZPC1DQKm+4?=
 =?us-ascii?Q?5/MVJMzXG5kIAZ+9XZaB8wOjA0MAb2mFdNn7d34ngis3Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgOPibhsUmhND6B1XvDwo8s0yh0vdUlSx8Hv46oB1c7JCaYFAkLp8rOK/tXi?=
 =?us-ascii?Q?Dy/nhvfog00E7XyjcVt0MCx/ZmaPxRRKmjWGsN5DveRZrirxz43irLEEcaeY?=
 =?us-ascii?Q?VmYiJiKNfWqpJG5DfB15LSjloUUrC3htRywvv/h9GnKmZS6ogAugIjydxgQy?=
 =?us-ascii?Q?9E+n1ogGWNT5KqUVo8APE1OZDujTIeBTOd8A1liR16GLIhNpcShn5bgpGvJ/?=
 =?us-ascii?Q?U//0sJzn2tJUCWebv6H5heuA5P6X80Ih+JiaE6bsQp61gYAZSpfYM4F0s9/S?=
 =?us-ascii?Q?8xYuXJJblNinDIYfDer/vyzjkPc8g5aOGgww12WyCUOVzxwXPW7wQSkcrQa4?=
 =?us-ascii?Q?eV2LGnxMoeRf16NgT1V+6h+2y7YKRV8cwM0sYMfW32L+69kajN5m5pA7JS97?=
 =?us-ascii?Q?Q9TK1s61UHniTIIUQ/PDqDx3inDaC5TUhfXzecdCgmJfU2ctwZz8HFi+/csb?=
 =?us-ascii?Q?j9hGB4mh3M18ladUXJ5NSoKrN6HtVqoLHHDEtnVFj6l3OOqKPzIxsg3cLlfq?=
 =?us-ascii?Q?hgf6EGZjPIBv5ZIgHSEr2L5gjfIe5DRXUCXyJlacE+0qWdBSaC6a5qtgFsNv?=
 =?us-ascii?Q?WeXyCojdBr0Y3uzKqeXvKpfykExyQXo1DgcDvXCcaqFDzOn/IQ/7/s3gNeYE?=
 =?us-ascii?Q?AgGZlp6DxjK5H6qzx+CDlrf6DerBIn7eAM/VFk6gb3+pskagUv6HX/bnCgeA?=
 =?us-ascii?Q?OqoeVKgryUKCvswVomU8Epq0o1XotSItUodFVSv4U3i91tVcOoJX/keiQ/E8?=
 =?us-ascii?Q?w7RzCeoXQ5HViZLBgdsNyngkjg7CrU/kSngLDPWXHpX+VC7a/2QzqCh33x3c?=
 =?us-ascii?Q?4Hqgh/vftA2bnwPs11to1zo6KAsVdzr247MrcMe8NDgPKz9MMb9mcgga8pVQ?=
 =?us-ascii?Q?CKH4I5W+BITGoFBNwPfRdqEHNEiSLlLHVZ2hv5nC25jOCgTrgonNG4vnyIoF?=
 =?us-ascii?Q?L+ZaiQ+ZcbMDwwN0aQ2gW1MI7u0OErJPZe3skQbLTxfqRC0ZvOfmZEVuejm4?=
 =?us-ascii?Q?V4kwbPdrCDzJ88zKT58S+07npChFc3hTWWO0fJr1Y73arTi8V4RrF0Rkp5Po?=
 =?us-ascii?Q?CReZel+y9bhXEPnxQtJJbwnEcNdl/6FM5JfQbvDvRZS8cnVLzD6Lb7jyrYS+?=
 =?us-ascii?Q?hq3vF/Yr4nxJIFSZa+x9rxpJ6Kf4OTXEzoNILxnmn769sIFTtxE7wyACbM9a?=
 =?us-ascii?Q?ywnmjikbE5ngCF3LGw5dhcrT8sTm5OfadB8q+QA6BJP2RAheyxL80ASqnLBz?=
 =?us-ascii?Q?p9WWGxoEG0M7NRP1/7NWnxsyBVAihHuSEZVgPNw2iuZQ4hBagrQJhU/CBBdJ?=
 =?us-ascii?Q?R1syKT/MS+EAVqNcA3ZS5xMPGFvLJgitLqssatKGu0x/j3Oeb5qvfkPEyup9?=
 =?us-ascii?Q?nkHAIPPz8skiSHNClfmyVwrT3Y21QloWlZuYOJRwlzt9FEm/S0Z5Bo1TNXk3?=
 =?us-ascii?Q?yBhroZcWjM/AGMoDOnuyke8l6DTju4cu+rpn19kqvK+/7OdZhCWZ2U/xh+QI?=
 =?us-ascii?Q?7YfLXBGQXAy/DYFgfhroPzEhcchixE1ERLl6yb3+VJoz/mNowthAbjdZuegq?=
 =?us-ascii?Q?9LMKh7ZVUT13ncneU/lf3mnn4UDW7v1cMF3MuKX9QDVOGFWKzyiPHxKlPvkX?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f6apC1e8zTaO5dg+deufe+/kkn/hBvg/lMTKZlhhBKn6mG0EiB/q2wJhVbmUZCNGTePIbxJvZvP6EJhomlKFK2zvkSHwCBMEZuEUhu8//C1KtGSQWRydriCllGy4zQBQ1bp9LB9r5YmVvO23bsmW5KM6GGfuJsZa9kbQwfayNxhcyYPY3PfWlum3/lGbL5OzChuLXuC6/s/+JjlxUmUVEV3QcZbXhQNKMJxU4I+pk0xU5VoTcV4oTShKUk/qUiwuHju99+6LAo9IzvG09Rx5yfUsx9dLp283YB2NIBnt6K3k30PQj3WZ3QXh7XmNPrsKLrsLXAcHzpBCrv3cCEf12hcdpKwNKgIQCo826CwtmGXE9TerJSlzGkOYMi8kj5hOfLFIIh62iGFQ9pNnXQU97WQ8ySmOmBeRd+Z8mes2gQX53uN6eDvpKFqhUBH1AmHr1cdZKuEvWno8iQu1rjl/q+0rIttaAyVGp9IaPj5kEr8tNEc638iTNYAbAiPD/vUplZPXoNhPOifIJLYQHfDUmKMyZSE69l+fnyIzFM9W2NPzum0W5DAMRMTfYkbnqBgzrrKjy6lpnqRqxhnU5H+144gYbP99Lfvj45pwLlB3bI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea554e-3fec-4d1a-db01-08dd191a4252
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:57:53.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+TVbE6jCpjV4VYzbJmdC2Meg5msVYLKGdTEMRyO54c/iD5eJtWr/WEhz31acTKnn6GOrx2kDKy9Ftry0ub1fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-GUID: YYDVreSHc6XCgJwqzhp389DqUu_eq7pw
X-Proofpoint-ORIG-GUID: YYDVreSHc6XCgJwqzhp389DqUu_eq7pw

Currently iomap_dio_zero() is limited to using a single bio to write up to
64K.

To support atomic writes larger than the FS block size, it may be required
to pre-zero some extents larger than 64K.

To increase the limit, fill each bio up in a loop.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..23fdad16e6a8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,27 +240,35 @@ void iomap_dio_bio_end_io(struct bio *bio)
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
-		loff_t pos, unsigned len)
+		const loff_t pos, const unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
+	unsigned int remaining = len;
+	unsigned int nr_vecs;
 	struct bio *bio;
+	int i;
 
 	if (!len)
 		return 0;
-	/*
-	 * Max block size supported is 64k
-	 */
-	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+
+	nr_vecs = DIV_ROUND_UP(len, IOMAP_ZERO_PAGE_SIZE);
+	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
 		return -EINVAL;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
+			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, zero_page, len, 0);
+	for (i = 0; i < nr_vecs; i++) {
+		__bio_add_page(bio, zero_page,
+			min(remaining, IOMAP_ZERO_PAGE_SIZE), 0);
+		remaining -= IOMAP_ZERO_PAGE_SIZE;
+	}
+
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return 0;
 }
-- 
2.31.1


