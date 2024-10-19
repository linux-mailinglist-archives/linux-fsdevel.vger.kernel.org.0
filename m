Return-Path: <linux-fsdevel+bounces-32416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70059A4DE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476A41F26A40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D1C17C9E;
	Sat, 19 Oct 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFInnhz6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="migR0w0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247979CF;
	Sat, 19 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342315; cv=fail; b=i43+V/VXTmAq/Q4Z/ZUdF24/Dul3lHElzcaCngbz9QRTO6tmRe6vsO1ibb9790gmZ2GwiARCTdJJgdlfqVXmEiUOBuqIMLinFbjeuWhAP8XML8SfUYPURBT9FLLOYpX1v799jnvKfT/MlUwpRvqxA4pZnhE1O+S6L57mHnXVluE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342315; c=relaxed/simple;
	bh=X3U10wfn6VZKScjWTDOaiqO+ijk2vv06rH73YhyzAOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phUhx0qOzhjInJ3edi6zoGtGUJLlKwRUmSlDqbxfUgs3TQO5Y76E/vZrjtayq90e8IYKm9AcdiYqCvhUztu/Q0muNfzvzNDYFrMEe6DJHrern3lCCp4H6Zwmu2VUlaxr1q1qzGWR2eSS81j7WkeAZ0TR5UqBqPwbqhsFWEarlFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFInnhz6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=migR0w0I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JBi2gp020082;
	Sat, 19 Oct 2024 12:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=; b=
	DFInnhz6eOSJubTV1A/nlmg0MCnaTlkXTAzTeMVbJBoXSFkfYEdZnbsMFa4kPZb8
	KFOgmaqd4Y/tW+RrUhpYa+IXOqH+b9JmSrGYUCdQAwabfdvWMoaaUvP9CPo+5SGc
	OaqCK3c2XQu4hqqbe1COLc2eKodKwBatgbvTZycwzNJhBZDAbXTRTqZmc4cx/CWu
	BzQCBj1gx0FBUP1xJE+jJERLQahDWI0UuUKIWT4+feAXTapkIif4GO46VmNltMJL
	iYkUXi1mi+3AYwHD+gBaSj2gGiKVw5woYpM77tJmx/ZVgjYJFVaCGjHntnGFfJCw
	+3IUfIS69wmFmC2IULEYCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54589th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JBSCAb026309;
	Sat, 19 Oct 2024 12:51:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c374ssae-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8tDmp8Ji+Zm57jzsdrKnVDecFdGQ77T6ECyXXT4Z3eTOzloBJrE8fpuXgfp2ODui3an2EoYrbXB/le7emXW1JdRVGy51uYcmlYRaqWLEtFOO35vCrQG4G6MLiwQDW1Oz4nN1iLqIWoXir7Uo4PkjrrD3xVpb/JQ5GzHopRVd7JYZrM7Q5juhP4hxEXf76oP9WIMG4gBFLr20tTwTUehXL1YNigCx+4yW/w4lKk6qmMR3wr7qPTKD6JpRyasTQMgarCXWN8UctZXhvoU2WKaXqWRlbtnl543UxGI3RLwE8D0VmB3GcI1EF2bdNqjkm0MPSrT33PceXs377rSambHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=Hz5WkPZmozeeBkin8yvcB07A7XL/X3cV6DUZ+Mn9dOIL7xDnrhCuRa7HmuY49fPAQOizk0RR8YJXEHmU8BYR3G0q1lOQO2PVTJJ/fbIt+W5Q/4ScXuq1hiJhxDQqHkarpXGkz3srdFCPzeXp49mtJUV5Jg1SR+rFoLzP3YVujfdAkyHA/Voc1XqL+892N2o95W5szwVwaCVKDSjH1pyundRd6wP38hOiygis2GG6iOX0miExKlmXZgEO/n+iSt0qXEYO+8VmhDQ3EgCrCWPqKqkZsnT4QYbfWolSXSkIpeQKPDvcruV4xEc1Xrm59twEd4SrehBTIFJWWDRCFTNEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=migR0w0IgVm835fAOG0jRl9ccWx3J6VWY3NSs3KNiRbORk4SZYzuX1L1NHJwv65wT3Vwek4rqPI8HG5hI87p4PUu8VAjbdbjuL3R0vZmIorYd5PXQlazuyoyAsMUeO2Ds8KdNDSXwi9Wci6aLrrZLYUItX89qb0ORsmuO93dwI8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB6435.namprd10.prod.outlook.com (2603:10b6:510:21c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sat, 19 Oct
 2024 12:51:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Sat, 19 Oct 2024 12:51:06 +0000
Message-Id: <20241019125113.369994-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf6ef61-20fb-4c22-4bb9-08dcf03cbcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+5hT5kv/27nJt9OJBeddf2ExUmCMRj8t46lvp4mrke9MefVXht6uiIgGZqo?=
 =?us-ascii?Q?VV6EWTrWj3QF10Gz1EwjbCRS+2YkX+sfWIKneMVyGmZN6pdD4gxhPdEfZTgm?=
 =?us-ascii?Q?a1z7AcAaQDOWG5pKJLsxV/2n90ughmEg3Sw2hOJqPDucvrt1ZODQB65SPFE9?=
 =?us-ascii?Q?5K6PYAMNfNkkmDkaFWnT+Sf5iOLWU/sPdh7eCTcWc+kxAGKp7o6HTfCJzM69?=
 =?us-ascii?Q?SdpUQWcbRfXO+aPhPJO55Unk1OG9Li4+VBRtFah1BW8DWOh/cuFJ9Zp2mlnV?=
 =?us-ascii?Q?hNi4qNy25sFhizMj7SW93ypmxBufE60txp1KhRbqVeqwI627Jg6uVBAebtx2?=
 =?us-ascii?Q?CA90pkxQuHJ0aHxFqKezqLIiEYu2mzQzaw6xZycPCRqkxXLCGoF8+kRgf0Cb?=
 =?us-ascii?Q?wLdeHpDcFeIzlJCf0xcLIe2H0qIk5odY6kyYeTjXO640dxaXBi1oL8wfeXII?=
 =?us-ascii?Q?40qedsIqlp8/3cebSR8M8j/0bQYQAY19geghSDUqW2lROW3Y6bscNfUoSWlJ?=
 =?us-ascii?Q?PhuM68Njw4kUGQqejkBsrmz2vKAJJev2EJQ4ur6QdYlX5fXp8XTsY7zTRQww?=
 =?us-ascii?Q?7r03VeYcTcgRUaz1Y/9B0WpYPIjU89np+kmDkRoGCgHgxi2/li54S3laPBU3?=
 =?us-ascii?Q?muIOdBCiZeoH4F61zLi4BB6uEIkFGjGs2ybUKNCi7zqlyjmhs1/ZNWk9npnD?=
 =?us-ascii?Q?PqCwpXgKpWge2/Q52ia4zyWZGrsXgu4x8OPJ5uzVE1kfsiT9Xs6DO4qmcc4w?=
 =?us-ascii?Q?qlkWHotM29EO1RrEtkxVjd7EVEJV+hURzbYm5r73Wc7LNsxNEuExPE+xO+Xe?=
 =?us-ascii?Q?kk7ZzbuMjACIj+JJydN4Ig+i0gf0MHgKaxtoIc/7Z/+O2YcnggeOLJXKnSSs?=
 =?us-ascii?Q?pW0OiEsHUiPF1t5ETA14kSWo7GRZWAirwbwYbrw82NjwlK51n5rKTFe1DSb1?=
 =?us-ascii?Q?H+IqbRz5XJtW9gqZUyrEGDRV7teug0h+kUyDadE2WrcBofK9ZXS/ATQ+3y0r?=
 =?us-ascii?Q?zaWkzreCri+Psq5VQTLaPkkFpurgnmCvBg5aYpc+BQ1Uc+Hoax31Ih7iRlx3?=
 =?us-ascii?Q?Cv0+/As1cPiwRWtafF/fvd49xS0IdbzkKy8kzjslBRpS9FVMzP27O/6wAaBK?=
 =?us-ascii?Q?/DKc4/5Ga+bKPpymcZdIkbNA0C9jWm4d1sSxtdB7sK7YieH830DcutsxE8aO?=
 =?us-ascii?Q?ZBh+COhxZR7Eh9kOftxk0+ydRaglRkLdSnJlfpKk8qbbVwOesfetTeLqZ7SP?=
 =?us-ascii?Q?dWK/P/JiZuYCHVACz0v3cWYsQ7ElZS/hT9tRbn4hvCVpkmaku60gzOEkWRyI?=
 =?us-ascii?Q?fESe7IqGUufe9Ax+XJ5PGFex?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3d3ToMnowS12G3HAJaySID0RroLzXd80DqiwDLa6m1iaqJdwKU7qDmAhIiD?=
 =?us-ascii?Q?0a7ah9EkCbuw3wg1l7oginhR+2XdYSrSLdkFOCfGjolJdnMGwA19+VtmDs0y?=
 =?us-ascii?Q?toi0vVNvfGIY2uufgPbCss0hp7QeM2nmTPl48yOTBhwLgXoR4y40MamBiwgb?=
 =?us-ascii?Q?H1yTcvl30K4z1qLmtVTLAdFfDOn92Gb1Un5ggVlmhoiErxwKKSDyG3IqQ6kF?=
 =?us-ascii?Q?M01Oo8Sk2MakowpULqxfqEZIO5wMTp+QRTrDuI2dTzDnvphqpnk9W8zbXopL?=
 =?us-ascii?Q?Y6oioV9VSBZBJM35OeJvEKLIida5R+bjPSDRtPolMgbHHTG2Q+AIcRhCaTNO?=
 =?us-ascii?Q?AYHc0RhJQ+cVsVVh0nUuxp4vUdp9e6LatYcow8a1+CBf1u2LUNPQAyDw2wXS?=
 =?us-ascii?Q?MnEZoGFVBowQiHX03KUv8co1DNy+NbuTcA7hoSJ3LeHciH2iu/fdkmG3XPrf?=
 =?us-ascii?Q?5jAIjjV6fnT/87KpVu9X0Vu1ZMtEHCU+UGgImUcClRdetsiZoeSf4Wb60yWX?=
 =?us-ascii?Q?2SND3mS4dH30XLxcNudW1c6tS81ENp+wryqbiixhV4VxA/e8FV7P7ktpUA5B?=
 =?us-ascii?Q?S/7nv4xGfLf4+Bhq7ACwy8b6Hpf9HYB82UFiQ5yVMZw4JbE2rgWmdFw0zd8o?=
 =?us-ascii?Q?jxzthJLLWEsKUR/9km5Ew04n3DA7Bg6mYg7BUEE5i/+s+FaRe4aepsJumd8b?=
 =?us-ascii?Q?F96XOmHMN9HlbXqB0pbFdttgmH1+oVqj+oBWSm1e131Y1IziYlseABkFAi4Q?=
 =?us-ascii?Q?AQKN1eW1U/zv0sFjFljtRyoupWUprxnLH2cNtQabYLHtAUfJHe4E95yDi/Ko?=
 =?us-ascii?Q?Qx8lfO3Y/91ch92LvTtT2U3DGxxpwMRAGZEcIDzFImXNo2cx5Ygg4P9Ua/S4?=
 =?us-ascii?Q?6yueaJC1wo6qCUsQnwf0OwW6vm2GvIxBm+pY0GUJLrqzq5fVGXvR5z6MlIlt?=
 =?us-ascii?Q?v3+0e4Zn1WuvQsFI1dHsvLdaAkhO0wLgumH5jdwfkQqvsXKxiwa6TUYPJzYx?=
 =?us-ascii?Q?v8DXdyrl74jZZMhTi8D3qrLAiWIeck44x4BSLYhR5Oa1s/eACWqlkguRSB8I?=
 =?us-ascii?Q?XnIJluqyGqa2j/z2Wq/bpEzbWIpCRWri9DkePyO6TNXT9nDE97GbJRXT5n2M?=
 =?us-ascii?Q?EZRD74D2AIOQvlqO0owuqfi4EGjm343O62O+MZfu/TTY6FawOPUro3B0T3DS?=
 =?us-ascii?Q?/sxg2xcyjChZp/b6AVUSnRQwbbSWTIGNEKle5ClyIJpNz7MR/gv+skduDgD8?=
 =?us-ascii?Q?VrESPHsxOwhUp3GVaGesVW+Nby3PJ7ZeZgdkWFCc3uInYW0NeGGi2/jqyBgb?=
 =?us-ascii?Q?Cr/vaJA/Gz5cCbrD5lFfwtjo1pfshEw8UDN8HWCb5jPdP/AsBqyCbNtHSru7?=
 =?us-ascii?Q?ivhKA0h9ONwISh4JnZFwxt3hMXVz+TmzqnOiteKMBGFDEH2OXvkgn9ES3zUO?=
 =?us-ascii?Q?CvqYHQP560Y/W7YRoKSgpgkDoLgD4H8nxT3Y/hKhtI71xkMz00zCXHEz7O5v?=
 =?us-ascii?Q?0K+kXK3MAgsWclCueihwEhGuyFQ31aBBFJwmYeMRXyByFYZmEaCJvQLrhZrT?=
 =?us-ascii?Q?pLv9XgOUFfrZ3zi0dadlEayTW1MiV05/mMYRd43NNvBl8CZNxE2SvuVyJz1p?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pm2TvD+HlGGbxc27nM4QajD/GvCiu6TlCZSXCOiwqEpYGS+AqJEwQhaCqo/wML1gVmcxeaJXMGHBjTA51/3gR7fS5koRwT+iOtTaYlJGVcFDt3vaVUVc/h+Jaz3DaCMqS2sbnfDh78rRg8WMxbrnXVm4crL8Mz8a50ro4wgMMPjGIvDX3TCeFiazywXPCm+IMT30v5r0uyO8pDXYAnwfnw+xPhp+ECsXGN7H5L+8hakwYZsdU9ncfRu7oske7wW/E9trbeedPZjRAbKMo4jUspXZB3ncJdyPDwBhXaFx48rt/wLbr3qrSUN4JEU5H1ERWMtFolRmNHWDmlEQo/6F2TMBYykKfvnrPMLhX8WJ1p1ih6s7vqEfyBCdwZZPa0nTUf2BZPXjybR486eTtJueA83Q3s8L9OZgppFeGn6/q4luvQ1ZG0pvT+vVT7y3BS+7M93BmYaIMRHIqmDGVQ7pTnrX+xPLY4Kxt0Ig+li7nlLfdA5Xly+XhO2L+5atqTm59G6KxzzjsteSMcKwWWGjbP1vXLkYUW/FdKHz1cVUboOu1FkKGiLVSm72cDz1is9bGUQDD3ZX2QYLeuwBEl+7T/yDg7JYy7nogx8U2Q8SMsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf6ef61-20fb-4c22-4bb9-08dcf03cbcf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:24.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md+9Fz3MK4kyFKV6LvsWktgDgcAroXaTWuMjb5usnikGK00p/abr/o+hPE/kYvKvLNDPcXOX2uHxt5LhG0tZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-GUID: ITn9qcp29Dr6ZWXyXucXQhGgP0377dL0
X-Proofpoint-ORIG-GUID: ITn9qcp29Dr6ZWXyXucXQhGgP0377dL0

Darrick and Hannes both thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 8 ++++----
 fs/read_write.c    | 4 ++--
 include/linux/fs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e696ae53bf1e..968b47b615c4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -35,13 +35,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 				struct iov_iter *iter, bool is_atomic)
 {
-	if (is_atomic && !generic_atomic_write_valid(iter, pos))
+	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
 		return true;
 
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -374,7 +374,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
diff --git a/fs/read_write.c b/fs/read_write.c
index 64dc24afdb3a..2c3263530828 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,7 +1830,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
@@ -1840,7 +1840,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
 	if (!is_power_of_2(len))
 		return false;
 
-	if (!IS_ALIGNED(pos, len))
+	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..fbfa032d1d90 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


