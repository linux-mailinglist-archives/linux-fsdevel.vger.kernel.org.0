Return-Path: <linux-fsdevel+bounces-48956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C50AB687F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0A91BA06AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D326FDB3;
	Wed, 14 May 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfRK/7sW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q18SuvRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A2270560;
	Wed, 14 May 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217715; cv=fail; b=CWdIF2GCNGsAeBJ3CpTDVmb7zSWP/LSuQPTST/L4wWVwh5danpJ8kOXmSyxRyi8xiiTwIriipbbuY2GhImPNIuMl/MCNZMG8uJULcpwRxmx+CPrfdIUFtTfqkC1Li1fM8nlTsxtkP+wZFilN+IbTVq4mGyoU2n51/e3bI4VG0qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217715; c=relaxed/simple;
	bh=yXXn7dPUVdUyzcRqwE93OyJgl41IpUtLLqT3aIGc5BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bM/IT6RFYJJ8MhlxC6AqIDwy7lDJic6f3C3U+uMjmyQJ7pfHrDQckBljCZ++3snSbX3z7KwMRMP9+DgkYrPVQeYSXVTpjKt/3ChrU/wz8yJTwQtKKcyf7h6rtCYBDcHxVyJUO7naeFutDdgRFAT4tIaSzMONoCwNPm9M4fb1G5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfRK/7sW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q18SuvRg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0ftSP025323;
	Wed, 14 May 2025 10:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6E0lSO3VeYxyGHltDT
	Q1l0SsoxQXfVx9QPxv9YVBqfw=; b=DfRK/7sWQXQ6omd20DVy/r5eMSz6/U4Dl0
	NgW8Ap36G7xXE2GkC8R+ZMlxbSs/5e7YSbl5VzCSiYbDAs3HjsOLfisR698LjF6o
	hPLZPeXJNHaULa0+aAxYuSM8Fz7sbn5l+Ofi99+NzeGcKrgoT24bZ5gm0FUDy3Se
	T0npB5Tgd6RhGzoU192NmP663piuu4Fke1+ylVqU6mGVYz1qdA8iNugCSVJr4Khx
	zRm7mTwLRZ5OugtwbDp3ayjItsN0R5f7oazK0IzuN6EFIjLdHmlE8hTJDt9RmWkA
	thiKeTv1OBJeL8IH4Pkk0FGSBil0Wc6vQk00ZlBrVpD2++QvS79g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchs6cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:14:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9T5rQ026847;
	Wed, 14 May 2025 10:14:50 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt7rhsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlY0yrd8RU+HTZii93VRQ/VVQ4nwIp5d4CwSaP5LqlQ/Tdd3Yr6j3MWLhnCfLXghcCF+7+y8xBAw6erK7syVczSiNnMACJa/DXRAoaBOPvBsElKXxL8zwxAdBX3R6ycXGMd8ivH8K+X1I1z/MMXc2QpzZ/G5D0yYLzc/qg3euMmF1OO6RAEda6SbGpYWs2t/UnrgnQs+MzmxUQGe5qvvJwTVgL4r/GBeRx7WXTv076eMAOJ4DWxDFChtoWfduGI7C15p8qkmMZJWW8lfL0yn4pJ4pHLmHizqI6dHcsiyxV0kYGcOePfnfJCDm2oe8fS4ybOI/+tUaqD2uGiP1GIeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E0lSO3VeYxyGHltDTQ1l0SsoxQXfVx9QPxv9YVBqfw=;
 b=FWdOCv1qblETRGu0M1g+NurPsUY0/WPjyqDV/GqsiK7rvqEV073PdtJPAYupeCVEC0whWt+rScq4D2bXyVDqVCzg5DWrcx1djrr4VyGF3qfeFvI+nBTRfJdFB/+l3J5bepD/JuT3ygzCXmsjBTloWC/ObOc5yheDuR19NyB1XyeO8HufIqmlOAf+j7Yo1EUGXRgGj83fx8i1Y3H+XSRv1w6gWE2e5mP7sC9RRbAyZ1guc2khnOQIpM7J1OFzR9feORBOakZY7PIT/NQpP4CqNtMDZDiMMRZ1kRJSYqGlhREzZfp/qHy78UUx4ptwcpY/BOOTo2lu5XAwCA+AwRfr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E0lSO3VeYxyGHltDTQ1l0SsoxQXfVx9QPxv9YVBqfw=;
 b=Q18SuvRgBBau1rmiaaMtRUnPbN0E8WIdvHgx/srCqEIZGM84JrMWLd9FZjTUvtEeH9w9kLVe8hm9LBhSXj+Wpn4f95Jm+bBFL3NSakYF5/Y1QV9FXHnq8YeFjuGp73n0Ph90wuYOrejalVZMgN5nDLF5Iz+NXUimbW9czq12Dlc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5146.namprd10.prod.outlook.com (2603:10b6:610:c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:14:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 10:14:48 +0000
Date: Wed, 14 May 2025 11:14:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <cdfa1a38-2740-4d87-a16e-c1e73e276453@lucifer.local>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <dqir4mv7twugxj6nstqziympxc6z3k5act4cwhgpg2naeqy3sx@wkn4wvnwbpih>
 <e18fea49-388d-40d2-9b55-b9f91ac3ce11@lucifer.local>
 <e3olqweuiyxlkewat26n4vyltpn5ordg6ckfndejwjleoemrtw@e2mo6nocaepy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3olqweuiyxlkewat26n4vyltpn5ordg6ckfndejwjleoemrtw@e2mo6nocaepy>
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2122c295-f622-48be-9300-08dd92d02835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQys9Bk11MvbJxKwgXQ7dPx4n/zBxGRzf4/cSme0buICZuJtjXFEUVlMKdT0?=
 =?us-ascii?Q?+IeHBT3AQz2ZO001wNiCwPog0WzkgPobx6dBvtkAxdhWFPV8n8BPVIVGOEmP?=
 =?us-ascii?Q?XIjDRtVgE7ZlxpPramHVYBOmhOvyKjwLVaz8udT5UbevdfYXT7FQQw4iEbPM?=
 =?us-ascii?Q?eslWht4ywfZKgM4RgFOlXhHVXViyDpmmAZZlrd90svIVfL/mzZrLOCm5SPCR?=
 =?us-ascii?Q?Mtq+8fT706RtPGLpmk9as6eLY8V0xc6HJiORfE4Jnn3S7SQ9HZIB1ioH5Hk3?=
 =?us-ascii?Q?3hhTLcgaqEr8oH3G/+9nINklqwVe2SRFHVh5bJA4MmBuH2MBDeCEMVBiEmue?=
 =?us-ascii?Q?u8B4ElenEn0y3FTTv0QhvlqZ/TMjWZJ68+qbb86dQWXWlUFJm1UJkVAoDZmu?=
 =?us-ascii?Q?N9aDJBPinpTjzz5XApZOD/d498c/kc+N5EpGqf+Tm0JEiMpBxAOqK1IOYdBb?=
 =?us-ascii?Q?UIpGhM2jT09Gm99gDYbvPcYksmit8FiBSyCKkMAAMDH8cQ2sYhAYg1QeMKQ1?=
 =?us-ascii?Q?zsDQhelWMN6K3pB9qTA73PHLpYFNB5zXVYWQNKt/kR+KuvoGAvyF28w0w24q?=
 =?us-ascii?Q?Ho+sDvTUiDCj8774cKJ/SVbqxlWW2iG+uySOzr/zqf8O0yNzI2IviycGrGud?=
 =?us-ascii?Q?bba+ELoLVL3xLvycnqF3TUoscvdkkh9oJl7Z4+ikFTE4lzDy+HuIewCakQF9?=
 =?us-ascii?Q?1QzTMQy+w+rozhIWCJ6FtsKrUVRq+UB/ZMcFgxhHZyqbO32kUC9cSRrKwTKc?=
 =?us-ascii?Q?m2zoCdafylJEK98GYa9HVN7fHUhRg8vv6hE+uGayuHYLBKmIlE1ij0r7AoI3?=
 =?us-ascii?Q?9gKlSHfM5BaKDtP/THHBz5ZGxXoNC3ophum/VnNbPKPNOEwTuBGZeVHCTGtL?=
 =?us-ascii?Q?k+vu+71s+OTDFwpbSSZhw7CUy6T2/ReRmrztYIPL7IvqyE4NzLg08h2QnmsQ?=
 =?us-ascii?Q?FRWO0OJxqJccDlXpuQXHqO13DLwbPV/0FzusaxRAQFD3gJE0HKGexchSjLyW?=
 =?us-ascii?Q?QVJBLaZ2L6PFWm/y51YYEnZpyyhHUcGOyRMZskd6DmGFopk55oT6xHWwNguR?=
 =?us-ascii?Q?qcpVDNct+x+YUruaLhvoSz+OSm+6RIWfSf3oK5qlzbPCtlAq7wIFb8OnNvQ3?=
 =?us-ascii?Q?MES24W4SXTfeP5Ze/FwU2hr4zDMsO+XjaaXXF5/yY1qN4lV2Zpq4N+5j169p?=
 =?us-ascii?Q?D/F2TVQO4XyPzva2sUpuLYThu1PVbrosH7QR/uyCoDUCZsi4Yfo1nGpVbZcJ?=
 =?us-ascii?Q?/Nmjac9Dcrj/qidzcm57BJvX+o6SdSXwtNMKs3VVXGtQt1LrRMiwUB7aOq/h?=
 =?us-ascii?Q?W998SLoJ2V9zufF3WOZ+3HmhOPtZ8t+7MUIdC5X0vrvm2wjaK4TS0GapFNVr?=
 =?us-ascii?Q?Ggg2WSwEvyTyjLgp1GLnmyIESmghapmKzjTgln2LY7SGWTXcnOCzfQPEYOrq?=
 =?us-ascii?Q?Nw3Q+3PE/uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jePbbvGreilCmyyCqMf13BIu8/x2u9R/R0uCHjUpIhVlSmujMju4JtYuDaea?=
 =?us-ascii?Q?D4qRJtc7YgzSsIU7yLziWgvIeiSK3WkhElAo3YJ3yXnDxoOHWt7qS/mXacfX?=
 =?us-ascii?Q?3VAfu2W62b0P1W9HoAECsEYe3ZQ4eiggtl7EAQYnOubZKuUHxwSRHt9rml18?=
 =?us-ascii?Q?mOXTYs2BE/06Nj6JyYrCcFqefJyjjkKNvgogm74c+KdZN+c0jJqAcL7Sy6Vm?=
 =?us-ascii?Q?viDKhjupfLnG7pv6H1QHBe6ivXSHzOcwVm82qJWKyHwtAZtJtWqR9ducaHr5?=
 =?us-ascii?Q?Ag8840FqsUEL1SJ1L2AyeUyhi6z5P9ZB9PoH7Bb2W1GshE+LPPAUd/+Sz3Gp?=
 =?us-ascii?Q?OydmExPQ0y1N+fcaKYwBm2WYOcRwJVa0/wAVvImp4yQGkpZpyYDLvBcJCBmq?=
 =?us-ascii?Q?ZyJwsFphRo2UNhio8ODwn3u0hx6zgIWNAnsL+ngBGjLmtFz6lLLlcpVQRzoJ?=
 =?us-ascii?Q?/+qDgGfX0wbqSHy8cxD3SlNVYWpscaPVChUepZJgjy3sb9ezjYJmIWI91Rqf?=
 =?us-ascii?Q?b/Yr2/Z+YdOqLM3LlFL8GBVt4z3fXxoEzBNCZns0RKmurq+bCQIwke7DY+dV?=
 =?us-ascii?Q?oNWuPhjFFqzFLAkro/xpZLVmsUvkYx0NmvBNqCO3X8d2hUQ3Ie0nNElmxHm4?=
 =?us-ascii?Q?AueKY571db/A2SLZ7lHbh9hHOxRyxeuwozyu35IKNeDssql6VEoSj5ll2UYb?=
 =?us-ascii?Q?VnjZW+SAMC44F28SMW+CueJ4mq2LIlKRamIu77pg48x7pErDkLFriAb9XcMI?=
 =?us-ascii?Q?7qaovJlUONFcP9ltjxZkrC3+VZW0+xk/H+/h4DFSHr7Zr1g0zpSjZodGM/N6?=
 =?us-ascii?Q?ant5dKvGqD4o8xA5CoQdJKQmGVpFPnsyhAdT4ue+qlhL/PyuO6uMmMjymWoB?=
 =?us-ascii?Q?NNeOaJ0feevGL3RFYG0xtw576ubAOY84LGrhvZ+xpARLRj13v90dh7mX/lrJ?=
 =?us-ascii?Q?8JE/XlrudJU0ao3ArPVLcvXbLNMHgE2jOAQJe/4AnLB5D3ytIOMSeWSyk4Sp?=
 =?us-ascii?Q?B0NH0b3sfvMdMCpF3JJH5lDcOQeqZ3GT6G2irtrMymIPSruWMz2gvNB/sHss?=
 =?us-ascii?Q?Go2GV6NDJMv9UQ99brxq2Cl6fAMAUXyRBs9Y6wFWmw+g4TNFMXCMsOCUlHdg?=
 =?us-ascii?Q?1U20HMDLKaslu4uprzOjKyKcLc+99MJOfKwE9M0LdPMQtrOUIVNg8oSQ+D7i?=
 =?us-ascii?Q?WhVEMSFA7NXRiJ+yeTPaBAyefr3Dbp+ij4gV50BXN98h24bjadf2FyU7elYN?=
 =?us-ascii?Q?7Fzs7cNWVcHpEN7QpVCuCQmr4NDW/GJ/vOV+JjbFSs9k49/T5yXNVgjVBI9W?=
 =?us-ascii?Q?FzbJYP1gvxJz5DO50C6JBW4XC1X//IBEqT1g4fpVqtZeSPg29ieEJMIaURbS?=
 =?us-ascii?Q?JSqSTWPtWayNlCeyn44j5UCHFgWBxA3uk3glu0YLoSrJIMcUnUxTen2alS5F?=
 =?us-ascii?Q?0yhnrmbwTB2HxqU8LkNUoWhRY2qgw5SI6gVlGtYhifM4a5Gs+AO3qR0l7D0+?=
 =?us-ascii?Q?PaeuKylp0txskLWC5eP+H5M0vneuHuHc3sNCCPHz6UTdlkmJYLna71pXpdsD?=
 =?us-ascii?Q?2P8aTJr2MtcQGg8bCs8j6gCak0pWXu2SYIDLh8BkE0+WE1L9Rc7MbyWcA7jg?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9itIfQrFeM8Sm3lEcJ+a2x24eN/+5+eHkKIL57jK3GEZiwt5WuFtPICkWWdlJOpoU/iBWrJKhDITslMyWWg73ZAEKziQO1YTqxnZT2UGFjAkUcS4Smv/h0eDeYWW8OdX7mcZdIk2EB2Q121qLM+wLJ6hvxBjI/f9fiM2bn0XBfsVqdDEA7Cm8S1BwX6vrXBmXXwI221xDSvk/vg7G+yGat7AHmPM6p5S4ugcKjMbpB409vHTvG65Bso1KKuUbGkEHPYJmlBikOVYAx1hQPcav7hxnTYn8Z24fbJ6WWPYZBtTt1/N5OaKYCzQoLLR5wRGs5IsjVygF/dvED0hsxNKQkcesca+1UF3sVsJirvlr6w9In3Inoex8QczgFVzzETB5MvkMsIZtnYVUXr+iBWxtno7gEMjJEMi4C06pJJZQbi+o97AoxdbkgKLtvELXKXB2aNT9Fccy8cr03PPYTDDWfoCMm+VvzbqaVfLgVSQ7ZAiCuWnW26S8Avi/U+Q/Va+HOEsUgyC/g0mKkGuXpnIVZcU/WQLxTXV0GC6/RA/JF1ojk6BGtoyin0AIwELoxZ1kbxWNQpRVHegnm3+kpP2R0SCsBv2A7FMa3vBsSQgxug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2122c295-f622-48be-9300-08dd92d02835
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:14:48.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XP+WHKWu4AA+hHmsDmRjmv1PeaU75+04w/v3GLvZaq1TvGenliNLZFav8Ib2SEqocTt3Jjh/zouwFkzj1kIELJH0zF1JRCP1s/5aQ46a+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4OSBTYWx0ZWRfX6aBNUjJRdJei iyX1fn4iU7g3TTYkBrWsyBtjFnLkagsDKOodIIwJ10F2PF+Lcpx5PWnvvz6dDG4Jd7e0dviv/tI Hd+pVZ9ffppFn/xaxDrjX9VcJieFG0S9x7dLitN4SAO3+5JKdUEN7pdnZSC6h0EOGjouTXHdPwz
 Tzh/0DftDl/Ngg3c+RcbJByniSYz+a2Kkbe2u4hop7NzpXA9PXSkPf4aZVL3y2LlHQrcCoDq8/Y H1WuMu+fW24QSg4udzOygO7c2AVYGHfEAd1mnTHfHNbyqmwx4iBajS3efaPmlMFwb65PoTlkbhy nG7L/FGJVzwkLpcKlyjuic3xlQ9rjLGPbI9XpotwG8TXZaIGmsKsrDAGZT6Cyr5k9LyovpQ+Q+q
 23cgBV0DRXW5S8hQ4aHEBAGwXWelodFx6hnaTyXl8SMsnh5kh+lslC978YseN/9fG1HGvrfJ
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=68246d1b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=B9vYNx1cYTGl5pT3GsIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: GChuqFcsVR8N4HBH7geDfQredmtwQhZG
X-Proofpoint-GUID: GChuqFcsVR8N4HBH7geDfQredmtwQhZG

On Wed, May 14, 2025 at 11:01:49AM +0100, Pedro Falcato wrote:
> On Wed, May 14, 2025 at 10:12:49AM +0100, Lorenzo Stoakes wrote:
> > On Wed, May 14, 2025 at 10:04:06AM +0100, Pedro Falcato wrote:
> > > On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> > > > Provide a means by which drivers can specify which fields of those
> > > > permitted to be changed should be altered to prior to mmap()'ing a
> > > > range (which may either result from a merge or from mapping an entirely new
> > > > VMA).
> > > >
> > > > Doing so is substantially safer than the existing .mmap() calback which
> > > > provides unrestricted access to the part-constructed VMA and permits
> > > > drivers and file systems to do 'creative' things which makes it hard to
> > > > reason about the state of the VMA after the function returns.
> > > >
> > > > The existing .mmap() callback's freedom has caused a great deal of issues,
> > > > especially in error handling, as unwinding the mmap() state has proven to
> > > > be non-trivial and caused significant issues in the past, for instance
> > > > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > > error path behaviour").
> > > >
> > > > It also necessitates a second attempt at merge once the .mmap() callback
> > > > has completed, which has caused issues in the past, is awkward, adds
> > > > overhead and is difficult to reason about.
> > > >
> > > > The .mmap_prepare() callback eliminates this requirement, as we can update
> > > > fields prior to even attempting the first merge. It is safer, as we heavily
> > > > restrict what can actually be modified, and being invoked very early in the
> > > > mmap() process, error handling can be performed safely with very little
> > > > unwinding of state required.
> > > >
> > > > The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> > > > exclusive, so we permit only one to be invoked at a time.
> > > >
> > > > Update vma userland test stubs to account for changes.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > Neat idea, thanks. This should also help out with the insane proliferation of
> > > vm_flags_set in ->mmap() callbacks all over. Hopefully.
> [snip]
> > >
> > > 2) Possibly add a ->mmap_finish()? With a fully constructed vma at that point.
> > >    So things like remap_pfn_range can still be used by drivers' mmap()
> > >    implementation.
> >
> > Thanks for raising the remap_pfn_range() case! Yes this is definitely a
> > thing.
> >
> > However this proposed callback would totally undermine the purpose of the
> > change - the idea is to never give a vma because if we do so we lose all of
> > the advantages here and may as well just leave the mmap in place for
> > this...
> >
>
> Yes, good point.
>
> > However I do think we'll need a new callback at some point (previously
> > discussed in thread).
> >
> > We could perhaps provide the option to _explicitly_ remap for instance. I
> > would want it to be heavily locked down as to what can happen and to happen
> > as early as possible.
> >
>
> I think we can simply combine various ideas here. Like:
>
> struct vm_area_desc_private {
> 	struct vm_area_desc desc;
> 	struct vm_area_struct *vma;
> };
>
> Then, for this "mmap_finish" callback and associated infra:
>
> 	int (*mmap_finish)(struct vm_area_desc *desc);
>
> int mmap_remap_pfn_range(struct vm_area_desc *desc, /*...*/)
> {
> 	struct vm_area_desc_private *private = container_of(desc, struct vm_area_desc_private, desc);
> 	return remap_pfn_range(private->vma, /*...*/);
> }
>
> int random_driver_mmap_finish(struct vm_area_desc *desc)
> {
> 	return mmap_remap_pfn_range(desc, desc->start, some_pfn, some_size,
> 				    desc->page_prot);
> }
>
>

Yeah that's really nice actually! I like that. Will note down for when we
come to this.

Obviously we need to know whent the finish implies a remap, but we can have
a field for this potentially set in the vm_area_desc to indicate this.

> I think something of the sort would be quite less prone to abuse, and we could
> take the time to then even polish up the interface (e.g maybe it would be nicer
> if mmap_remap_pfn_range took a vma offset, and not a start address).

Right yeah, David definitely wanted some improvements in this area so this
aligns with other intentions/work.

>
> Anyway, just brainstorming. This idea came to mind, I think it's quite interesting.

Nice ideas :) yeah, good chance to undo some sins here.

>
> > This is something we can iterate on, as trying to find the ideal scheme
> > immediately will just lead to inaction, the big advantage with the approach
> > here is we can be iterative.
> >
> > We provide this, use it in a scenario which allows us to eliminate merge
> > retry, and can take it from there :)
>
> Yep, totally.
>
> >
> > So indeed, watch this space basically... I will be highly proactive on this
> > stuff moving forward.
> >
> > >
> > > 1) is particularly important so our VFS and driver friends know this is supposed
> > > to be The Way Forward.
> >
> > I think probably the answer is for me to fully update the document to be
> > bang up to date, right? But that would obviously work best as a follow up
> > patch :)
> >
>
> You love your big projects :p I had the impression the docs were more or less up to date?
> The VFS people do update it somewhat diligently. And for mm we only have ->mmap, ->get_unmapped_area,
> and now ->mmap_prepare. And the descriptions are ATM quite useless, just
> "called by the mmap(2) system call".

Much like leg day, sometimes painful things are worthwhile things :)

As for docs I saw there were some missing uring entries, and it explicitly
says 'as of kernel 4.18'.

So I feel that it really needs to be properly updated and it ends up being
a little out of scope to the series.

Since this series only uses this callback in one, mm-specific, place, I
think it makes sense to attack this on a follow up, alongside updating file
system callbacks etc.

But it's definitely on the todo! :)

Cheers, Lorenzo

>
> --
> Pedro

