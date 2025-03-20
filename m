Return-Path: <linux-fsdevel+bounces-44549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498CA6A457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A991892D3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB308224B07;
	Thu, 20 Mar 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kn5O2lGn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hM7kw6V7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2C224AEB;
	Thu, 20 Mar 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468300; cv=fail; b=u1ndob17wYt9t291fHbByh8y09/OLaN6tQtyB+eEyFQS2lgvdTIHOKyzvkEx4waU2Kl6jiahLxQ7j8UKtWV03z9GPUqaYsBkWg3WsKNVOgpsVwphp7582/Tw/3/Q6P9hzVxhEETrjR5LJyGIMXJKeDOMKRFR5EOT766ZBGF0pHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468300; c=relaxed/simple;
	bh=CZFc84dBRZ4hYOJmr7/1/8MEg4lv1S9MRc6jCY1k8iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxL/j1pTP62X9uYK+RQIkN498tbk1fC65rGgC2k55lU3OxBAX49HSrUBtZy4revr14xeKag5M6vv3B0GTy1QWF5cM0Y8mojvfN/1rHuv4kBe3Y6tQmrZIWCHtllmnc2RM37EKsgpYjDo082TAnohQUobVja4ML9kIKMjhOyitdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kn5O2lGn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hM7kw6V7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8BuZl017499;
	Thu, 20 Mar 2025 10:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wlm2R0aA0PCD2pFVhW
	Q7vLVgQTnVr+YBm9OQp85Wxz4=; b=Kn5O2lGnHsbj+pMNt/IHK6fBB1qx+fbUrC
	9Q8gIOc1gsXTs4M/cVO2sOwjLxeDKrv75GYdAzy52Z6g354ZmggF6pxdUA+WgAxM
	p2/j8FsE8xSx0NdYkqrOIM8fhAus+Z0up8Bp/dji9Jsz1WeH6VGgvmxc0/xLts9d
	j1maYR+k4Tmj/3AJwSMorBjj4VGm0gFrs+/lr2bT9u5swtqftgAe88T+IodybJfz
	o+2qgRXYlcUuxzzZ6WM3RuH10Lj+1KS/WuOOSh2VtlqW+k/pBo1kVBwhzZYY95gX
	WlswKZG+MKB1D3LJzKsOAqlQYHoQaBo7KFUINjguKdAPCJb5v8Jw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8ndeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:57:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAsD5P018534;
	Thu, 20 Mar 2025 10:57:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdnw2y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5Y0oAISJ/GU2b0YeXfLdv+KrX7z6Xa8/oAQ/FOeN8KWjd3DWYv//I4wUP1rWzogiCq4Jpp3EvHWz9qPomtRxOvBWhWtMEFIbpidWV7lIkvaUB4OIcQ5EjPbJQK/+2px3e1oMIkWMiWfKmoenpZpgW6bJYNoFG7dyvySlmvGdhRKV0LdBdd51/x9wBKJWhUQxxHz6MMPenf7fB3RtuoUhLE1G4YdCF+sk13R5MtPlDRMhuPBhm8aTMVzZFJM2DFihRyfjpEBfAcMEN3UZ97Dqqdrczi/EFyZEi50VGuLGde0aIy+2v68ZpJP9C4DRwYKZ4GyowsbuI3bSJT4K1oPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlm2R0aA0PCD2pFVhWQ7vLVgQTnVr+YBm9OQp85Wxz4=;
 b=Iw1/1uSvyGYXHI7C18sq2rvvm37pzs+STsCiLNh5T1UG4bw74pcvs8fFUFE1cIN5qUM+qOhcNy2jlwsWSMn+hqEMsPTo/9TxIoAXQRTg8VcUqRaPLTRHWYK7Lw6OZhBwDDq4xWzeQgiu2aQ5wNZsITyg7LhiInePj6ItwnTMLkJ5f1JaFDUwZB+mBSYFHLJOhAyRBPzjFa+2Eep7k9i4FylORZGL3lVvCD/aTl7RhASWEm+uETuG0T3KfEiy2w7SD1+yv3+/ktO7SIWQorN0nXK/gvwJFOpR63AzFDxDuyXLSt9j5OLoePyrywNwSqO4KihABLF4UrZgzGuO5sj0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlm2R0aA0PCD2pFVhWQ7vLVgQTnVr+YBm9OQp85Wxz4=;
 b=hM7kw6V7w3tvxobAhxX91QArdmteX8wnJ2PfNGEyGnd78934kIB34TmDNZ3mlElD0S3P08kdLpI1hJlxWc9c7uAvz/lZbhNZr3GUkUdg2AdQ8gdrQtXUOvQOMSni0s/mdnbLvtVt89RVGnpu1wVsZroz2mg3qMby/GyICdIQn4Y=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 10:57:48 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:57:48 +0000
Date: Thu, 20 Mar 2025 10:57:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
Message-ID: <24d6f7a9-82db-4240-a8d6-2c8b58861521@lucifer.local>
References: <20250320063903.2685882-1-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063903.2685882-1-avagin@google.com>
X-ClientProxiedBy: LO2P265CA0473.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::29) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SN7PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 299ee84a-698d-4fe3-2d72-08dd679e0d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3S4AUo7xFovMG+Q8xdos2tzS1XjonhyuPLd91lHwettQyHIopjzVsnN69wL?=
 =?us-ascii?Q?DVoTs2puwvGyXumLtxo4FSMFTC3zqBtSu+wDDEg8TVEO61Yw0PL5HvvHEJfQ?=
 =?us-ascii?Q?rkXZ6VfOxdPlss0Sry6lNKxO8KpRpTfebBHnkkiNQNlxuDcTfPBAnI6qC8Lm?=
 =?us-ascii?Q?g54FC+3x8zaO4QfiYjrUUGJKtbEYN/uTugTe22k4ZNRVO/48x2TIVQ99GBAR?=
 =?us-ascii?Q?ObTRP3IfVBMDevi2PR+ZkQZYiMrNw8EjYyl0wvweEe7oB4VJYi8fKX0aVpi4?=
 =?us-ascii?Q?+DTevRtyw8s4PPnDHjMeiGdpsoIrooCo8Tzdkb6yhhVIErHs7dxbwpvtAPkA?=
 =?us-ascii?Q?50bP0DyN2/gxbThb0XzXWe7P8H0rzCv2e+0uQPDidKAQXzc+Ah6lQANUpuMg?=
 =?us-ascii?Q?Ydx2CN6NavJiY6j+kcKjY9USoaE1EmAYtUo/UvoTj+e7yFOo6ks7X0Lzcj31?=
 =?us-ascii?Q?2ofFmjThN545JxPMDlznVeuZWY6WckHRuK1IxvdQgek8b7z/jjZ/huiywANw?=
 =?us-ascii?Q?jxskLT+tKaFcNFz0SL4W5P7QkZcEnSMIXUf5DaAMqsHgr5DKO6k6pStLYf45?=
 =?us-ascii?Q?luISvWE03MuM1R/l5iZedW9oh5X7wODD7hnaaHXCIXAwyT9vUONIx83xUaUV?=
 =?us-ascii?Q?UmYnrxYs82j3n5z1qA5Z294M1OIbVvGSW6sdjZNLQk/YsRsgEKWuMLMqW8Ej?=
 =?us-ascii?Q?WTCBcxzO5gdsMR7QB6focvoo636Wu/ySwqgasHvRATNLG8/NICErz+IGgn9E?=
 =?us-ascii?Q?k4eOl+FNXHf5n+74ciWLKjad2QN0mj180js10EdtZj/+wtNEJ8jOwG7qIudc?=
 =?us-ascii?Q?87Nhwmm5BUpwBD8BQvw8/G/sDUdxajz4pYLgym/Kd904EAGRGKJKCTa6BdpU?=
 =?us-ascii?Q?YDFLtb3txYu9mu3ADLzmsaZP6iC6gnmPfH9VFNj5SU4lS/65G3aWgYpflDgk?=
 =?us-ascii?Q?+6FC/bY/uOSkpfLBlxV3C8jAQwNM7dceopioRCFwbhO4Uatlz/aZRCfMSwf+?=
 =?us-ascii?Q?yJJbSMWCUKCpj9PXtKxZA49XflnD227Ka+Lb3nGgVucK4znT3s2rouy98iRv?=
 =?us-ascii?Q?I39F2srHJiNo5x6s5u+KK9qftqDMNuGXvTpxPBsFp1ncXJUALgV2AZVgW/XW?=
 =?us-ascii?Q?1T78sv3YwAswWnP1oRGkM6QD2peW6oh55Cq0ydHup4xY7I0IstR8BPOUsPfC?=
 =?us-ascii?Q?ZLGZI2ovZU+6n3ccRDBcallNm69uZLOxq3wemzylmAQBotCGLGCs+R775lS+?=
 =?us-ascii?Q?WiZRRK6JSU/p+VbO+nk3aESmijWAu5F9u2dTgDtB8t0r4Q9qSqS3zPuZO01a?=
 =?us-ascii?Q?hGb3ZPjtBw/xmSevmRP+apzWJY+dpq9/gwOawKMgXa5kNRdYhQDLybXrhJrO?=
 =?us-ascii?Q?juygF+q82bp74PvrudLShD/LFnsV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zesyh6kF1zYb3DMP1QHU2k2HRGrT5BsOp2r/laRppwaDrZMV1NZjjA2fJmTT?=
 =?us-ascii?Q?01FT3h2Tpbgj07Q2ZNs9W8b4iS9D32++zvq5z20VbrNSGMNbu2VA9lmDTZgu?=
 =?us-ascii?Q?FRVzz8RsgVJ9mq9qcnf+xmLiqem93VeVXrASCmNRIt8TdwruCct1fGavUn3T?=
 =?us-ascii?Q?Zbhz/TQyFluFjyLNVFJs48OhQi199nC/++KKW51rC8+qkSlMiPJEOXzm9S8F?=
 =?us-ascii?Q?BlgKeWvRACf2VBk6/0Tmeu4+OuwFN7lG6TbYodQBz4kRIPn46Xwra/cBW8Yo?=
 =?us-ascii?Q?KDr0RrrUki9D9EcFZ8RnmTr+QYHTpn3q02V1nhtIqlFt/t1FAUl6zQnvX49Q?=
 =?us-ascii?Q?O9WicUbmwSFHWWytmaoH98AxrYmXEGZQRDkBNN3PZJaeoXkrHs3BeAzZgeCc?=
 =?us-ascii?Q?AyfJkEWnQhYCBPoL3APoCvIoRmRSwRc91TCmndsukbkY+jvSQEw1jFfahaop?=
 =?us-ascii?Q?KBwHofRLhy13AE6sev35ubHKVJRFXceobuEIRAjSReWPaPjPCsD93mlPDNnh?=
 =?us-ascii?Q?Em88g/qSiFFyJKRNVIEnsl+wPtfGkKdnjK+37Mu8QLWyUF0j3S3RU4ZbmK/r?=
 =?us-ascii?Q?8aeFprZmIpqQ1SiniF/XuV0tXB5VM9vHYX7U7l5tNRhOtxQptHtVTreDYiL7?=
 =?us-ascii?Q?Xxlz0FvGrLjMWtk8LCONJVGxmKo+ec6RQu0S3tJVqP7lAdgUw6M75DNF3/wF?=
 =?us-ascii?Q?NYCv8tR45W+JlZTkpwN8cZ6oV/vrFP461FZAE8GJFAF3ezp6XV0F5phpQDEP?=
 =?us-ascii?Q?h2BqkSiS4Bik9mtx+uBZlFXLf+vdaojzank9RtFlfC0Q/NlbjQ5YdK1vbi1x?=
 =?us-ascii?Q?ukUB0Gdu4LNFognnS7ebcRN9h6T7C9XRsQmDkBrIalYhfqME73RiGSOTv0tS?=
 =?us-ascii?Q?K4Phv3TJ+1IDfnGTJl9zSdcoW5q3BaoLRtsz0Tdxc9khBMlNRjimrkL8MGdP?=
 =?us-ascii?Q?h6770PWPAt5vBUIhdEiZv6yfUu2IluQA7WsZ+je6woS3hAKehNq2kzsjOR3Y?=
 =?us-ascii?Q?wvsqipxRAwmEEQ74o8E5UlUXoXOwVMz8KfB99xyp55qTvfyFRkZkWCZ4CFe5?=
 =?us-ascii?Q?TjZA4U8jQ8Orao0zP8CTFc8jOVEdo0L+Wbaqek5SRWHiNB7AHP9y+MkusL9E?=
 =?us-ascii?Q?PHzyM/Pf1dd6p9TD3pHIgoIacJnAtzN3ssEMCyFTlAlpMeFNNvoITzF8f3Dh?=
 =?us-ascii?Q?WRYOuX916+GH+jQbspQqeptReYs8nG4R0DGA7c9ZM597yj6Iktmc0hbWBAZf?=
 =?us-ascii?Q?aelY/MzRECpnUB9imUMXSbJkS1tXnm789F6Gr8CXaGJI531pu5VXsOSbd/+Y?=
 =?us-ascii?Q?JH5weNUYT+VyzL98qPR6GLyk3C7juEfbwSZstQ5VZfzoiRIFCxGpJTAXsWZ0?=
 =?us-ascii?Q?RNr6Q4K721FtZyN9c+pzdd+L4kTcqMAgGBdQERP6mBByIuXkXr5ZcWaNbnDG?=
 =?us-ascii?Q?URAKkq670XxUy1qxkIt/KX+dKbM1jjcwYvzRRdeqOwBQopB2077nFES20WNK?=
 =?us-ascii?Q?e16V2AdOVaCR2NNwIdJFiqk+97KKVW1Nn4GKAeyP/TaMdq/MK9Lc2FT9T/O1?=
 =?us-ascii?Q?51zkifNvIUaJKBEvew6FPv8RGv/UpwEq/VFMWkFknCGp20EpzA1nR4jLQ43o?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AB5skRwuv1mqnMlLX6VvPSyJ5rPJWswJ4CiEX3KIo+SxewSPdtngW+Fzd59yIX+b9+Ye1lze7VXOaxcJlZS3gd3aOTaGv0XUsJyMvjVOwrHG7JIXcoR9HcZBsoyvduKjnjpsGwIPXdhc/2DkaWrHiJowrDcD+cQ6+pRrUR0RQ7pZhBLB4/b3paez2UhZxPzYKfT/XxoYqXC2ikpFBOUzWmNl7FTaP6gTa+Ja1pOdkHw0N9l33rKtCdB5YhdmEk3CSsZK1rkqqUGqJ7fydFA+anKggkto/pnOZtk3LUzpFcYFDgSkHseT2TTIbUjtNM6d9Y3RToCO0tRC3cqQPeEijR2vmqbfDtZVQ0//o3ktemlefktUbCrVPi2D22eUdQoASyxJ5md5+5lI5wDb0ZWRp7vxAoSC9mtZjc8okF4OyBsiKWHXWc3E3E0qjEJ51lcJNlmdD/MoMzbMevfQ3+8iP+zAhXMWqMVuJTgnPixzS2fffdPimszwsTcJ/7OlikASsx3IrZFH39fY+g4o9YBKriflFUxVV42nJC6TEaT9O4Z7xidomFu4EQ+vYkUaG3sFHftr+poVFmTZ1rxpXW0X2siPrfzA+JaxvsAe9FOq4oI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299ee84a-698d-4fe3-2d72-08dd679e0d92
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:57:48.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8m/WtI2h7xv7e1RcDH2lIvPimBiUzvaukShBLEShxWKXD5Tqf91eoqr8ODuLZQOSulveZ9mC3+CENrZusZR6O6MzVxMX/PfYE07gQyXFaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=737 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200067
X-Proofpoint-ORIG-GUID: _I5maWGdKSKupHTZ9NmtTcx8RWGXdB78
X-Proofpoint-GUID: _I5maWGdKSKupHTZ9NmtTcx8RWGXdB78

Well I guess it couldn't wait ;) we're (very!) late in the cycle and
immediately pre-LSF (will you be there btw?) so this is 6.16 for sure.

Kinda wish you'd mentioned you wanted to do it as I'd rearranged my
schedule to tackle this as a priority post-LSF, but you've done a good job
so we're all good! Just a little heads up would have been nice ;)

Some nits and you need to fix the test header thing but otherwise good.

On Thu, Mar 20, 2025 at 06:39:01AM +0000, Andrei Vagin wrote:
> Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
> information about guard regions. This allows userspace tools, such as
> CRIU, to detect and handle guard regions.

Might be worth underlining why it is so crucial for CRIU, and what
advantages PAGEMAP_SCAN confers.

>
> This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
> add guard region bit to pagemap":
> https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/

No need for this, this applies fine against mm-unstable, though we're
looking at 6.16 for this now obviously.

>
> The series includes updates to the documentation and selftests to
> reflect the new functionality.

I love to see it! :>)

Please also, once this moves along, send an update to the manpage please.

>
> Andrei Vagin (2):
>   fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
>   selftests/mm: add PAGEMAP_SCAN guard region test
>
>  Documentation/admin-guide/mm/pagemap.rst   |  1 +
>  fs/proc/task_mmu.c                         |  8 +++-
>  include/uapi/linux/fs.h                    |  1 +
>  tools/testing/selftests/mm/guard-regions.c | 53 ++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 2 deletions(-)
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

Cheers, Lorenzo

