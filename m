Return-Path: <linux-fsdevel+bounces-50192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB1AC8B18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED22E3A5501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E322B8AD;
	Fri, 30 May 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btDkUdUp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCEBbPYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD5223329;
	Fri, 30 May 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597699; cv=fail; b=dxiq7D/NXMuZ47zY9+nabT1zOzc5zl6cCmCsAlJqvSmlIoEs4UYzaszr3IDkA9vepBz06LoAyZiGOVsFVF6NXy3FbGvxE/gEqywmoQEMA16QDk4RBTECMIf5aXDWocUG1SqDDy41w5/UXt2TBOiVg3ig2EllPoPkXfgPxi+BVk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597699; c=relaxed/simple;
	bh=q+VHYhTE9aFecDltfYda6QQGYbdez3jnFxvXanydKDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SlVEWPMWwwkSUHcezkiKot/axGn8fqqUK8LX43iHZ504i/icTN/vIIvgfzZiW/aPdzGMJfPsP+bOokBxPvYuvJI6JdvvWy5Os2iYcz5OhSOQkHUwDTUc8FFkAZ7lLltb4LKmiqt2+fInlSudZHwsc7MWZf9T37N2QWl/DYUEv+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btDkUdUp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCEBbPYu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6u1HR004285;
	Fri, 30 May 2025 09:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q+VHYhTE9aFecDltfY
	da6QQGYbdez3jnFxvXanydKDk=; b=btDkUdUprQ+0w8L7bLFKmdgcqf/ksiNTTs
	Dc+5q4Rj+XnY2zc/xFYHgHDDOKMKsfogSSYMYYFCgKayJRWK4zQ+7zjtb9VSzkWG
	Axu8uju5GjuezsSjQcKnJ36hKSNyzPYgqt7dsTNzU8TSUlh7fJbFwZIEr0fwvb+m
	CADTSRIGKLbGdFyF/aBI4yDXHDDGIeVOvlqozOTQz5RpHtMVL+l8YzXZbCEZyHCD
	ik3ZrD6U4zPL4xaDyhAo19ADpVBNrg4t2yiOiDppgiuxF6LHw/71d833vK2Q5Nm2
	MzIdC5OsUqCvG+fT6YRW4OF4uaK2YKMF9aohIFj2XgQljPN/P5iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym21en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:34:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U8fjsG026679;
	Fri, 30 May 2025 09:34:42 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11010043.outbound.protection.outlook.com [52.101.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd29s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fskhCaPucbnEzy1vnbqYMP5RT9hhJ5PXdYbw21rRhAlqWDe45KXCXkoH0mll5520LcNJBZpT+fz/86kUuB7MKPdYvC4xxr4ni1kJcbKmmplI9jYxnwrGw5D4A9+vq8uBJSer6zqVKY84shKkofDZ35pIioqtp0VOd7jI/RK4LUib35rRBfmIOeC3CvsLZhv9yJUGeERg8mGHx1blZjDdRVz4WuvM4ic1AWEa3CPMmjjn+Y7xyLc31zd5/f1K/0YAuXWqsfwdvEPQTPzblMBGgeomlHs09RoYF5Z5rtXS1GtoGhNXX+aB0UFwaGCm7Bgp7fFVjNFLwsAVmq+8xIzBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+VHYhTE9aFecDltfYda6QQGYbdez3jnFxvXanydKDk=;
 b=s1xicqXkeLfheoZaB2/U+TANiv1vUsJH1S7Mnnp9YrE4ytEzUxiOAtCqZ6V4WJk2hkgmEG8qgesut3VLbO2Y+nLc/EAIrit+AiPYfeRR1Qvdwh5z6MdKZC3dcXisN8j/4csZ1TjOrIBwOmNwG+BXTZlKmFKgQMUBm2mZUfQ6Nll8VQQRbB/BgjWuvHjQeZ7xSS0Zyo/JnrV8/NuVlIqe1Hs7Rz/gmyMSh28wA/VG8Zf3ehJTduLDN2WUuXyxfq8ebSqxr+yu0Py5rw/5ewY9Os8p7ayWILwJ4ObCJ313R8xxWgclMJ6usCv6BKBAb74fM3cbEfgAVWoaSTInwYXgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+VHYhTE9aFecDltfYda6QQGYbdez3jnFxvXanydKDk=;
 b=cCEBbPYu6ukzXZdxXzWSYnYiQjTjlSHlx/BXdMvxn5rJPOpVfFWkDIB9tyHJxriyAx4f3q8iZ2nn9CWC69lnh6CsbskOQGNHhTaD360C0XtG6wfo8dmfbcSe/Cekk1a8baPzMe1JSKWqWN3cPD63tgHV5/anAS36i22GFZMS2K4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8494.namprd10.prod.outlook.com (2603:10b6:208:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 09:34:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 09:34:39 +0000
Date: Fri, 30 May 2025 10:34:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
        hughd@google.com, Liam.Howlett@oracle.com, npache@redhat.com,
        dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Message-ID: <60a81a60-b7da-4439-b177-9d1bca82828d@lucifer.local>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
 <9b1bac6c-fd9f-4dc1-8c94-c4da0cbb9e7f@arm.com>
 <abe284a4-db5c-4a5f-b2fd-e28e1ab93ed1@redhat.com>
 <6caefe0b-c909-4692-a006-7f8b9c0299a6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6caefe0b-c909-4692-a006-7f8b9c0299a6@redhat.com>
X-ClientProxiedBy: LO2P265CA0433.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a0c160-4915-4450-a431-08dd9f5d330e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qa9nM3JPhTfPXWdnRpRGAlF4+LbQtDfY1qCECYuQ6n/feROz10K1KWgJ/EhR?=
 =?us-ascii?Q?pYVHW8tK9scDlp1ck/ym3pavi1wmxVnqbWkuXfyfRPOBVUYPHOitsBnTq30u?=
 =?us-ascii?Q?nwVBVYBF+bhQm4cQwHYibZbK+tsl2RnfaFuwnrVSgNjUvAesHup5mkOmve1O?=
 =?us-ascii?Q?t7RSrWKerqtsbCZU2thwQrxwo5by28FBZ0D33A8oMV8qVSbnRw5SJYGJA3io?=
 =?us-ascii?Q?CzwP4y91rL1td/BrPZdEQJ3I3bzo75sf2IMc5y0TkI4Tc90IPwEYTcJo/z3d?=
 =?us-ascii?Q?cfSv8POypxECyTa6FmkM3eNDCDHqfpxJSVMXs8/4yoPeyLr1ssCmuO/VhzhR?=
 =?us-ascii?Q?td0mFVDe0S5PPae3YV4bO5DQLuTg3XSjmHzgKbbYU6LZbGnKJBPl5ea1QjZV?=
 =?us-ascii?Q?tGZbz+8Lgu05/gzZmFOz+3hjI9M/LzIi7ftI1J1brQaDJM9ToelYfsdqg7d/?=
 =?us-ascii?Q?EWu8GfiC5RS/nFYYUetPhyJo1lvhpFCG8vsblamahCpNTG64Mh1cFOGW9AfO?=
 =?us-ascii?Q?foheUnrWG5hkvmmG0wFRB23QmV9ls+ZdDx2yXvmXsJ5EyI88rlv7qPiMnNA3?=
 =?us-ascii?Q?F9xiIoNVgA/4SW7ChFzgoZweaN83LYMWCglIwgSs70HhtvTYYLiwPs4PRtfV?=
 =?us-ascii?Q?sMmJ3gKeRjfYr5D1FIebR9/vybnBoytjuckKFojEleAcTgqJurF3g7WvKyVk?=
 =?us-ascii?Q?D883Bs3f4/BLk3x18NNfuF+mIAkcUdyjIC7+vh/G2oaIDalH5qzV3qjYMblG?=
 =?us-ascii?Q?vMI9qW+eBEZzCX1Cp5Uw7APKTUi/e7skOl9D0mOJXlxGel8QqNaowGbG019i?=
 =?us-ascii?Q?IcrXE9Vm67pAAsjvKqCFsq5Kb0k4n6/KM35qHaaa5tLcoqzfBwNXidy7MBbD?=
 =?us-ascii?Q?YaGWHRupuLqQded/jbAjMOSPqFIuWXyPAkpCvfXROG2cR5tgOCK9Q3+W+NMR?=
 =?us-ascii?Q?3zmS7blpfC4Ikvr1C5I7DX+Jm/04ne2Pe8vcIp2Id3Ip0l+lMGs8zXKXTPUo?=
 =?us-ascii?Q?hdnVIk36cOWeOHjAvvDIMLZY5DXynIV3IhbGPqhpN90bUGZNgB+fqUj1VwGD?=
 =?us-ascii?Q?yB3EGl5bPAQ61MGC9M3ONsBnUxp2Dqcz+kRIuFg/O7sgWg5QbCqPtVPe+PcE?=
 =?us-ascii?Q?T/dM+fwWNtiiAqRrAARk2TfyRnMLcwlGnm9PiEyPa809k4AFQM3QrnfnBJfl?=
 =?us-ascii?Q?6cKzw+74zs0sKqU4glhgia5AChIMG7H4eVZ6z79FGkr2+Jq0qPIv+CSD46Up?=
 =?us-ascii?Q?O4A1E3Hk4m9VKmDZCgfV5uTh2Kuibtwu7ChTcG9Y+dGtUoWIg2qS9rbPRN81?=
 =?us-ascii?Q?+DWPnLdy27DeMObcbhhy7hyWbSN+aKihrXrb6WAeYI3mUXZd0g0/K+4pKPQP?=
 =?us-ascii?Q?zxG7eX90R5BHo4/8IGuxgqPFOjUH+v4QBs06aB1f7KX/3xQOnRrN3o+10I0i?=
 =?us-ascii?Q?uwL0Hl18za0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kphRsHfP3LjMvJ2NaUoeSnobD18dXFT1He/1dDTZmbLyyRRxoqXYl3y1JcKL?=
 =?us-ascii?Q?8Zt9v2EJRb3dWjBbo1zDpF8K1HU9F1uBfjd4zbFPVharEnRTlyNIX4ztFwR4?=
 =?us-ascii?Q?Jkt86cMxK95jU8iaQFtNdvOJfu7+CeZQ6xseRRsluC+FC6m4tw6BGOEa3eYg?=
 =?us-ascii?Q?XxGcFOCuygWF8v4Tcy/U92AYlL/t5BqKoD+SnTdFr2FKqeO+mpvnedOPpkEe?=
 =?us-ascii?Q?z5bGgSDd30ylU+sd6jX8M48N7DfV3c/Kae13K4YCqtfaLZxGKUfidbH4MA/9?=
 =?us-ascii?Q?irbdKXxGP5sSFGRXF2GMR1GrBO9B4zUecBZOKO2zN0kUv55HiQtECp0bMKe1?=
 =?us-ascii?Q?JQOBZNJg2QfebjjGCv7U4r74Pjel71MQOUZaEsYB2ylNJIVLUkdzfUDwNNIu?=
 =?us-ascii?Q?IcsmHkwpwM1RiivThgbo6NPE6tEjY+Ll1hQIak0GINyAOdc9F8fZtrSVsSam?=
 =?us-ascii?Q?TLCiEz1AD6PVQ0cKtEIEs2C8TZY/7k2eW3wKLIGGFp6kZfDziCp3INttEqfW?=
 =?us-ascii?Q?cnbsHaSArdCijoDVFY060jKZy4D02U4jl3CLbRBW980R8TOwjY6/LrVON6rg?=
 =?us-ascii?Q?J3qtL/0O7yTBwTjyqG/L+V6XniDrB6YlJlKBKoHWAwhvrd9W9fN41+KojnJW?=
 =?us-ascii?Q?sIpQXzGt3TFZQwNyVZjqvpwEszqA58WmPgB/J9dy0tjXf5+OD8pl9ARQx4zn?=
 =?us-ascii?Q?5BOon2JPeER140DVQ3twuVWRn3sg51ntMxF0uetaWXBBrxRnhhqxYPVFdjjT?=
 =?us-ascii?Q?tSpif956Y7DkY8jvk61NGaD1xFWviZNORkw+Zr7doObgqES+HFUn0HnEA2Q4?=
 =?us-ascii?Q?vUMzuQ6/0ixZdr1QPvJKDhnSj3ggadinRjhqc4oOKRcJrQycWHGipUR70FV2?=
 =?us-ascii?Q?kFYxHsAwHUSWcPOXhOGuhOCDF/eP3aszDi3aqkrcXriv6wafp4K4/Cjekark?=
 =?us-ascii?Q?BYSmetOafCgrDtwKDcy4tzxITzi6LpXeKY8wNYXk5FC+jAVl7ehqm2vOSMnO?=
 =?us-ascii?Q?9esCWtL1p+VSZeMcma3FLGED76a6Hq4ztfOvtVuc7ME9ve5Dwka2LODWj/aE?=
 =?us-ascii?Q?jt+yM12rls+Xca666y2cZ/DHrnaCRrwzkLXg3A2HsXi6ALIcf3oIwESswOUt?=
 =?us-ascii?Q?YDp8uzYl/TSsIm7S9zi0WUgz0pfQAm8NwlMfQDmft7kZek9yRDk3lCTXW5KB?=
 =?us-ascii?Q?gZ1WC8OMrzNeBL3stYFMpQyFa4r8nxIteHsakFWZkrvip90nIOegN2GEu0qb?=
 =?us-ascii?Q?Sy82TqQGRdBN8jFlXruBcCehgIyloiSGKUUpI7TEF+jBM7tEkOVWp8uL1dRl?=
 =?us-ascii?Q?tFFoD4qrEsotn/XA50ZjbCgqGidCSYzJSDF43g/dddmZ+N8wwnuu/otx8kXo?=
 =?us-ascii?Q?SR6zaeslOf3dRKFLwPOeVNUdf2onqsbVvEYSqV8cKi/IkO0HFhTZ/JyRAs7G?=
 =?us-ascii?Q?P5CNgTXPUu3jK0/3X5KUf1ZafzwpnrWFq7L4YOlLD+uuTw0hBEXuszTiQhhN?=
 =?us-ascii?Q?0uMgJJkHyJPtzu/m5WVG+s4f7Dux7b3gv+mE4X6xCfLYPwE4HmWhFtpS2O88?=
 =?us-ascii?Q?MFO+vwQOehqko7K89TI/ZRCHLSZDSlNXflsNjIGnufB8kP784rJZ70Y27+iQ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gS77m2/MXI3ZMz7S+htv8nu6MttAvGeYt1UQI27iABb+/ta2tVl5HEUtd3yQsCLuwwDHL43fnI4nR2sKrCLUELBrKQQ5995n18NxU1Vl5l0W2IvaOa0MsBVW6cz1gbcfZNIog0Hb7pWCCjlFM27hNUndErRNe4Kv8805ikxj8c/FdXfDt8FjveRzLFs5v2oIH9FD0htmo8Wibq2Tz8ZITzDduzny+WULUzRPkVmEBq0pv488yPqMlCVQ7BoaLUQ7W5mdwKIE/fupUUwU8YNgKlZA5trfoJ8dczB6TUYuWhnfi72IEWLQKlPo4xL/gHs307pKECoiqfjfcu1EzouCy/avUicyrxSxMDCiKX58ctsmL1DjfbVlNr7HX7JSCW6T9Pc2SmhpsVwODOsmcRUGaS/synOrOhGMlRz+3G81vcvt9bAN5BHqcB/W1xA0pL03jaKTcbRkOUlQR7d607Ec0hokN/S/jWER/FU7F5gCVDmzEQjmVXsWg3LqTYeHn0acy7SwxAmRxuZfaYyq+fdiQUlZZj2Ciro5whD98y7PTeLygxH7TIZhAh5tAK1zAZUR5hjeG5lXKwoVS/cDYnDvzsp3dl7OhrR1w8teL2wQRvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a0c160-4915-4450-a431-08dd9f5d330e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:34:39.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbYbmNTpJ2vP1gWDX2o2uKyAZuwjovQC9yX28E2TVlJMIz3dfRAtaznpTriQw4j588aKfk+f3psA/+XgqMDwUhzglhEpu8GMm6rgMdojzzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300081
X-Proofpoint-GUID: fFoTNhnHmj4SwObrP3acnijz9WOOWkQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA4MSBTYWx0ZWRfX/We3qfA9ftAG cstON/TwYTqlchwo6N8zoxu1rd4ClawR6nGcPqehIq5pMwD+1IEOsDgnsWXS/vIjMAr8j6OknsZ cDisDKGmX5/mqIPj9WKPuYhxFwfZVpL86HiyhG8CFVvzaB5TyyW4C+N5dt7/nnpeie4FPGrF9c5
 Idt2DLOwcyQoeYURfPq8AzbAbgA4NeA5+mQFgxE8Spzwj/oQjH3+c+/GDFEkX3ItzKIKqXBUhUX kc7AlmYgtkgfqjMmfLRiv6UNWZc8nKiVI+D4JFHeALlU6rNf3jQdDeiZ7peJQspcJsCiFVO/cL8 MSS/aUa09AovC7J94DP1JY8EZeFQwCiRrp/JUQV5Ff/0V03eEnclLbFJDFY+dGgrqdqU20YPUGm
 fWZZDcaxhvanlu3+aMWzXz+8NWTqe+8dwh4dUTO3yMckTeBMC5FwU7p3ODz3kyQ2OOgIU0IT
X-Proofpoint-ORIG-GUID: fFoTNhnHmj4SwObrP3acnijz9WOOWkQC
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68397bb2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NFPYR10K5HdowB0G7XMA:9 a=CjuIK1q_8ugA:10

On Fri, May 30, 2025 at 11:16:51AM +0200, David Hildenbrand wrote:
[snip]
> It kind-of contradicts the linked
> Documentation/admin-guide/mm/transhuge.rst, where we have this *beautiful*
> comment
>
> "Transparent Hugepage Support for anonymous memory can be entirely disable
> (mostly for debugging purposes".
>
> I mean, "entirely" is also pretty clear to me.
>
> I would assume that the man page of MADV_COLLAPSE should have talked about
> ignoring *khugepaged* toggles (max_ptes_none ...), at least that's what I
> recall from the discussions back then.

Sorry I don't want to turn this stuff into too much of a mega-thread but
just a small comment here - I think we should go and update the
documentation/man pages to be clearer and consistent.

There is enough confusion around this as it is...

>
> --
> Cheers,
>
> David / dhildenb
>

