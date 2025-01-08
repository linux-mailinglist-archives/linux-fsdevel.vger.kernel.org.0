Return-Path: <linux-fsdevel+bounces-38682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DB6A06834
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 23:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B03B160D70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592992010E5;
	Wed,  8 Jan 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OamOekWy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qFecOeoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECB185B6D
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375017; cv=fail; b=Y3XyC2/vnO4YpCZI6nPcQn7ck8ji5x3m0YFWYuKtun7HqRbgISvmsKAhy+S4r9faWU4+09FOCOWlSYs0+O9AulUQgRwvV3vxORfWuf+Fx7QE/7c/JywHsv65RHUtbwAr3IeoSNeXDn630Cct7ubi0C0TelUx5x4ROV/Qr0BEbJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375017; c=relaxed/simple;
	bh=nv6QcQAygthJPHmT788Jl9H9UoFhRufwGhS4FtIcR7k=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sIPDkFGt4obPjxM8UFfi+qrRpTbpW+qLB8oSXkVbpupX67GShWQcTXFT5dscfAM8ieQagrVPPARFATfqEnojB1NjPDLFvb4L6x7i+CUAMGbeHNTqRrtQef/+rwkvaDdp6xkfFrbOLj1Dy+rnXxDCHoBZ3P//sGG3Xbdk5otu4kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OamOekWy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qFecOeoj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508M9Wtw004398;
	Wed, 8 Jan 2025 22:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=nv6QcQAygthJPHmT788Jl9H9UoFhRufwGhS4FtIcR7k=; b=
	OamOekWyA6uFNY8BXi4XNBpkvfJS1NKQE7cekYJY4k3hmgot+Of4b2xB9ZZEuKpI
	q8rLv9CdzXyj77LaVyILdGyoLKWgv0DmLDfhzMHldXns3EwpDOF4B7N7R5ckXEJB
	nX64uP9MLk5+b9xYrpeQth/xOudf0tLSQDmO+2cshog2vszF5/Rd8wmyn32MPs6d
	s6Ee/rlyuSi9GIMBlA7Z47y5r3HaWX+slEzFZPpkoFS70Ct8rC5apU+LLqzGFg//
	HWpX9vxI39+OJtLMBTCHl39md8h1U7cjYbExfr/N3rCXbPGXDc4dSv0RF65MMqZX
	1ETzbcMkAsYnAt1BMzHHqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk084th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 22:23:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508MF4wX010893;
	Wed, 8 Jan 2025 22:23:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea62fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 22:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9p9yceRJqUAseF1VjGcyZMuvwR1MkEQ+IevTFFiw9KftogV0UIz8AojKmJpkuXabWYkQWqe7dnaj/buzYqSud0Zh+6K6ePNltu+W8mLmhYKvgmkCqul5B6BU1xoe4w893fMFAcvj+3YmeaLOcyVJjhtLszG6+NyC1+kNCDQRvXNxLUdMSG4I0uo6/FTH4oFCsJsXmSDtje/mGjSfinDgTUlok0IEUakHkzGtC7uoAELS55+Fa+p6uDftpUwnbB/C7wYkJzUW+2viALH+whrX78uH0zDCqSu/zBh3ei/OvIIzW3wIDqccdlAwdUz4h65CthizxMlk/hoDKvNAGoJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv6QcQAygthJPHmT788Jl9H9UoFhRufwGhS4FtIcR7k=;
 b=DpP05YctUZ028cjgs2U0kzklkUYt6hKUFkmf2EcxDJOrZ3PBFZt6Oc00psHdTNyEvmA6c7u1psqywO7T81vB0RLmjfFUeNywyRp2bA7pCueV6lokJTAF0TX1M2ixnUyjICHww3ycrUoQmrC5/Pwf0bJR85gUBse9COR7dthYutzSqlnSDT9+d6Oyz73N76mpw5rzKl84OC/fSkaQZ/fL8W8jxHW+j/UZQHRSkpAIb2sr0MJ0ml2+Yrc1Ai3yHU9j4dLzusx34p7OSJsoWvCbLHxlNbuAd56Fi75dzAvNpD80v4HQx4NUYK5veSWipWw7i9Mva6Ch6hEpymOIKatDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv6QcQAygthJPHmT788Jl9H9UoFhRufwGhS4FtIcR7k=;
 b=qFecOeojD3/yDvVNkg/7VoBOMf087H7KMUEn6lTNwaRm6vMeqWhBC0VRQByg48e5Wp+nqbhCwoflCyx2velPdnhwfcqQJdhy5aE6rG4eQZclot8beil7qHWQQyyUk5woaBiDGu67Qxvx5Fm3hXslc0ASt8o3iffBK/PBlxI5Do0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB5946.namprd10.prod.outlook.com (2603:10b6:208:3d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 22:23:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 22:23:20 +0000
Date: Wed, 8 Jan 2025 22:23:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: bb25c87c-d211-4134-1dcb-08dd30330ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CasEI4FKmWzQZ5oDujr9SOtN4P/AMWcBjTeqYz7czLP+EAIdvCLdrKa1AJJ9?=
 =?us-ascii?Q?ZCzIjW39mnnLeehyVrXPykZInaROocMWw1MFdDp2UEMpTTFHq4uKIAH37nhG?=
 =?us-ascii?Q?4iov1EeFQ5kb2jObakllG8neQcehpVH9HGfqHdyEymcZZnrRxlJ5y3Wd9++j?=
 =?us-ascii?Q?nkL9x9qdhEkXkUQZbQNm/ypallc7aaJm/gb3EN1D9rjYQl2kdIUwlCRu5cgD?=
 =?us-ascii?Q?fzUCQK73uzhSCy0srX7h5qUUFotgmbc7EZMt92jMFrkGmewkzImwDyC7yTTS?=
 =?us-ascii?Q?zeL0DOCbvPA/9CbonIC0rsr6wqgjtRc58qMUCAnFM/2gzk14Nz7N26XlipdV?=
 =?us-ascii?Q?/wpcGjYdhIK31z4n0xkM66cpmPv7aG4KMBM/gu+DcvNKQGZ0vFS3lRWQEcDX?=
 =?us-ascii?Q?mxWh/Zh60qMVaxcz9zzKjTrND7+G+ZSckgwJoTK4cKlg1K1PGl7vmvTtNO7o?=
 =?us-ascii?Q?xdVGhr+Gkq4x/iedv/jUEQlDyXxZ+4Ywgdmmcd9/D9Xz00AFbLt5xSQDQd+B?=
 =?us-ascii?Q?xx6x8knRh9p1Su2gidtQ1IGawOkYZEue5SS+NaavowHLvxMCEu1JbLAi4myg?=
 =?us-ascii?Q?/NeqFvACVZIEUgPWC3Lzi8V2zsTn0y8a4z8Nt8WQtzd87KJOxFNPmb1I1yHh?=
 =?us-ascii?Q?yFfdE32QjUUMzgukMes03M26+ly6EWEuDqWgiPQF26mBwi+IVAM2Pl1Lb8/c?=
 =?us-ascii?Q?CKMXiIk1TP1td2VvVry1GOyZq1cVgGiJxiYMfEyu3owXd1+vqg+WXzQk+GsC?=
 =?us-ascii?Q?5Ep492TNb4SYZFZ/SS7SbaterrUHvIC7y3u1CnhjgKFG33wRnQJBkmobUK+Q?=
 =?us-ascii?Q?/bPg9BGxdOu1BM8PlSXbgujIJgSRq8W86IUE3OClbAfern5Pu8tAah20ECCv?=
 =?us-ascii?Q?AYorW99gu1Gre+lMjYR0lv8MfQ9Ium5z3PorWOhScz0rJ/0tEzV9T8vEzsem?=
 =?us-ascii?Q?qinAtFi9sbAk561UO/23VQeHwUAhu9xgUYVxzI4GE1bysY/wmvRbRNaSVOCx?=
 =?us-ascii?Q?7RFzAaCDohDJPpXUwbeumpuNGz2yOOUl2HqjaxNTDY4CnE2is3+xXx9w+rjL?=
 =?us-ascii?Q?4GLwRK+ZeRRTFD1SUwd72ctDI0D+m4jgqB9xYRy2/+B+BMDWRXmVcANhm4eg?=
 =?us-ascii?Q?2t2sVzqBCEGMQPpHO/nezcjxryp9ArBrMZjuhG2jsUTzXTQbilU6+FIeF19h?=
 =?us-ascii?Q?5ZupWfgHIKFxfZmSvNE4uL/bV9GTWhxK7IK5JPcmhOM7TEzkG/u3TDn3NPaQ?=
 =?us-ascii?Q?j2oC8vqDrwqwj9AweY+QwokR7Vd6fmP6Mvw6pY415XgCO3MJ0brHhyn9JcoW?=
 =?us-ascii?Q?YBKY/Nrj2tiQh0Krf2Pooz52Yo99k4CZnDj+/6EA94BC0QdKK9rw2GK/DieK?=
 =?us-ascii?Q?1UFA+dpmKglt1OTLDd9wjIkQXI1i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmXptBsXHMgJdQ+bzW0u/tieR83H2iTFOaVzHVrDgrocxEhxtdYTsY2Am/XW?=
 =?us-ascii?Q?CeNKIy4+Vxzo+tJRBurCIw8cXexJ2YbEeftap0Y58BdjDQ8/5Z+uuBBPRD8r?=
 =?us-ascii?Q?9ENseBgTASi7oUHVxQh2VGaMdgZDSVePB790ARU3nT1TtESygC5sZajvD+vu?=
 =?us-ascii?Q?r5/J9IJdUZk1B9BzEjQOyzA3KhNl2LZRDszhmz+WVkJeTp7mMqUlgiLAVwZr?=
 =?us-ascii?Q?MX/hJEZAn3UmS99S6JNJ8p6873FAPOqRu3+6slH81Cn8LjP3gp5VHYCgHsJo?=
 =?us-ascii?Q?TPs6IWqXbrcJshKny+dIxVjOFt7Ka07ZEc8ETHSVooaPgYGT5FriKdMaTTdz?=
 =?us-ascii?Q?8RtucAaxHbHFH3C2KVBw6g3+1myRI9F3XHEtbIZD0vEunOp+Yd3lRXdId42Q?=
 =?us-ascii?Q?xgDJQARpx6VBkZqQi2pMeuIKNVk2I2ImSOTBdPhahtsVymBlFDODbFZrKooA?=
 =?us-ascii?Q?UF+rRO1BqonsuoIXFIw0iIGQv0jYgEEVlT3N50Z4OlwmoMVtZTZjAF5q7Znr?=
 =?us-ascii?Q?wU8l8nW20QIgVclltJqLmnOQeXvhi5QNztqH3kJbGCxssL0JsHL5Tm/LFZhM?=
 =?us-ascii?Q?+Hwcvde6H05aIffNaeDMrKzaP5zKYFQ17HyZBKdXG+ImUPup2KPN9g4w/vyi?=
 =?us-ascii?Q?Q0j6mQZatbWV3jV+soaNf51sfFW5IplwlaGlP9KLMpRXlIm/l1nqIKcpZryX?=
 =?us-ascii?Q?Rk6yAultbvW1RGviWkL7O0aKYUXJ0yR2ZzHeaiVFhWIR2UmPcZ8dBWtAo+i9?=
 =?us-ascii?Q?ZCRhEpLx+VmF8nAoa2zuNl86OVLUXIAgNL/OWfs/8hBJifDejdrxWL4aXucX?=
 =?us-ascii?Q?2Wu3nqiRNUkbpM5kc3kDiGhJBGbSwPBRXtch3kgMCpM4tin4JpvgJfTddfqj?=
 =?us-ascii?Q?GEO+x1YrPgfDAQzIhJqROgyDGm1pxgbFeuMUhkGHATWkcenhE8oAjpzUlUFx?=
 =?us-ascii?Q?olrIFxKsmHK/Ilz/HC7im265EaIdGjlguA58Ct+pDF+CmwasaQPOtQpEIsVS?=
 =?us-ascii?Q?SGAgdKMTpCu/xBwUECJeNK5sJ2xF4331CCPF21uDeBMZBcLic7JcPDsPa600?=
 =?us-ascii?Q?o6PLBLHpki9lomurvCRkBM0Pr54dNY85y29Jy8p56LxdbDEaziNbu7IcAM1L?=
 =?us-ascii?Q?J4rvn0iim8c7uPGg7SXItgGI6vXVP86zejzFdAETLbG7nsNDPzx/L2cZSOHq?=
 =?us-ascii?Q?r/Mnl3OMp9crDpkj7S4pCbUrtQOkbgUp2Tvs04mr60wkbXhKHrnTOk8UYGoP?=
 =?us-ascii?Q?NzrLw4nCVrptGp3GScDXf437wiQrzrk07EgdUT1LXHO2BaIgTWzawCdGA5+x?=
 =?us-ascii?Q?g9W0pBGmMYcB7557KWpHZUKWQOFcQXOGF7+BPrOsgY4+K355l6VmHLQ/VR5/?=
 =?us-ascii?Q?G8EK+V7/IUCyrti+zK8vfExc3TLuFQWAib05IbnTmseOOSjMA0OdmADOPg+l?=
 =?us-ascii?Q?tUY62VAMaekFaPs5SMuneNv1opkTbPzhxstVIJDH/kMIu+vwlqzzMw15AdC5?=
 =?us-ascii?Q?DD+n884qR9qTiGr/qBDcwTZf6F6mIA6YhbK+Wt6Rekyc1FwF+slMDWlTAXoT?=
 =?us-ascii?Q?eLakQ/GcKkyXlwcrQNRG11cXCgbzn3PEgP3yAQMMq3D3sK1coCtA7VuBd/Iq?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	giVJz2xzNve+UWsmZRsHA66j78xFHkjMzIA5DKkOsESviUyw+p6ECJTogtgkg9pNs/aAHfKC0RnV/76/8yMsnQFoHDXRtdIG3cw8i8JCuUdVB7U+MYSJpgXO80MecTZfopI0e+CA1jzcCsxCU7xNZDXsBXtFv4mMyhf+jIQZfIncKASUWWICEgJpjn6uL4U8Ur01Pm6Jk9CY1WLPpSX/HIernY2MkYlzcxeHWMS0yNJ8ghPGFb2pTdI/fcSkP/J2kFWZ5PktrfMzqhEA/DdJZqBZa9O4Hh1MHzGh6Ct82gcGf3Co3hCig/1KNWCnYV4h9h2J4AFktXTaA5uC20uUEhcRdY1tqWZQgcNh4ZwyNMRXraKt6/uLwgFNBTHgbHXGgC1fX5UsbgXmzWqk3rgvcFuueEhTsboO+GTuRLLxUbKEctFLZM/Q8OHooSACCGiy2mQnwCKw51SPOS4+5PxLufc4aXKlhmyUh+ecD17FmkUMpVEyK83CQ/VEP9mPRkSXf+UNcBS0W5rT0aISznFXwg0p8Ysrq/FgcfpnuZpG8PwATjh4Kqnq8wXr/BW9RhPTlf8D2sZ3qNrX+VsxfScGzjy8tcqhm+/xIhNsZdPtrCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25c87c-d211-4134-1dcb-08dd30330ed2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:23:20.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpWrTleR7vUg0kszXyZTyzBg1dLg9Ejdw1KjcQX5LtoEx+Aok/vdrz3EDf+lmZA7fHxvpB6hxZ+KAPe4sKM3IypYhuGmf+a9E6XOHDywASw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=978 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501080183
X-Proofpoint-ORIG-GUID: 5C1infki90WSdjeFaj9-_hTPrbNN58Pi
X-Proofpoint-GUID: 5C1infki90WSdjeFaj9-_hTPrbNN58Pi

Hi all,

Since time immemorial the kernel has maintained two separate realms within
mm - that of file-backed mappings and that of anonymous mappings.

Each of these require a reverse mapping from folio to VMA, utilising
interval trees from an intermediate object referenced by folio->mapping
back to the VMAs which map it.

In the case of a file-backed mapping, this 'intermediate object' is the
shared page cache entry, of type struct address_space. It is non-CoW which
keep things simple(-ish) and the concept is straight-forward - both the
folio and the VMAs which map the page cache object reference it.

In the case of anonymous memory, things are not quite as simple, as a
result of CoW. This is further complicated by forking and the very many
different combinations of CoW'd and non-CoW'd folios that can exist within
a mapping.

This kind of mapping utilises struct anon_vma objects which as a result of
this complexity are pretty well entirely concerned with maintaining the
notion of an anon_vma object rather than describing the underlying memory
in any way.

Of course we can enter further realms of insan^W^W^W^W^Wcomplexity by
maintaining a MAP_PRIVATE file-backed mapping where we can experience both
at once!

The fact that we can have both CoW'd and non-CoW'd folios referencing a VMA
means that we require -yet another- type, a struct anon_vma_chain,
maintained on a linked list, to abstract the link between anon_vma objects
and VMAs, and to provide a means by which one can manage and traverse
anon_vma objects from the VMA as well as looking them up from the reverse
mapping.

Maintaining all of this correctly is very fragile, error-prone and
confusing, not to mention the concerns around maintaining correct locking
semantics, correctly propagating anonymous VMA state on fork, and trying to
reuse state to avoid allocating unnecessary memory to maintain all of this
infrastructure.

An additional consequence of maintaining these two realms is that that
which straddles them - shmem - becomes something of an enigma -
file-backed, but existing on the anonymous LRU list and requiring a lot of
very specific handling.

It is obvious that there is some isomorphism between the representation of
file systems and anonymous memory, less the CoW handling. However there is
a concept which exists within file systems which can somewhat bridge the gap
 - reflinks.

A future where we unify anonymous and file-backed memory mappings would be
one in which a reflinks were implemented at a general level rather than, as
they are now, implemented individually within file systems.

I'd like to discuss how feasible doing so might be, whether this is a sane
line of thought at all, and how a roadmap for working towards the
elimination of anon_vma as it stands might look.

As with my other proposal, I will gather more concrete information before
LSF to ensure the discussion is specific, and of course I would be
interested to discuss the topic in this thread also!

Thanks!

