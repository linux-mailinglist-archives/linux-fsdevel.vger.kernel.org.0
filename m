Return-Path: <linux-fsdevel+bounces-73656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E4D1E084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51BA43018F74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9B389E1A;
	Wed, 14 Jan 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZRN8RTg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iWl7IIW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B33793DD;
	Wed, 14 Jan 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386480; cv=fail; b=HTaf0SDsUllxogW8D4FR+/EQkOJ1+zd3Zo0vqb2ijcyolWrhaaGXhi6lBXkn3joHlSuTsdnHiMLvUTHJmdPGsl3KOSBky/9StjJD02nQDviSkLhJhYrGRGrLZRC734v+j2NmJ+kqXz16ibXLJ2zjo89juVNsr38IYTE2L5yiA9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386480; c=relaxed/simple;
	bh=oLNxMQVCts7XmM3/JZKi5urmUQlmddSWTbTnkPj28Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Exz1TQxlQ7UHOoNT/vJvaOKq6oK9Qb/doeB9O9nn0wOazx48E925vAMGMEB0AmtcSVaXlbjcV+ctlTYpKUSXRrmjNiLVAbz26dGPvuGLciHzBOch/p4NavEpKblN+/kYhkXp0Vg+hLs9Ie2y4EIYMUK9raYKAIf0KthKVwe7CdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eZRN8RTg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iWl7IIW/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E6Ck4K1940271;
	Wed, 14 Jan 2026 10:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tcKstQWHbnRs9UnfFU
	kvOJ3DG0VTT8YHoRt6/tOmjvg=; b=eZRN8RTg0OW4aDCCKWsmsz/lz8skFldwXR
	98XuZj0/GFslaB+2nv91TvBnMJhTDZ9smgrV7+2357ZU7AifYH9ggtT/V69iyKrR
	97LaDMH8LvpLLdB8XQtXM8w2xEUxbZx+AaCkMngPGC/Lh097mBxMV6zH0EC6ptVO
	Yela1O+aqBPOD8lJA4kdm1RS16dC2xrwW59Alzb3irSHIFVXgbO5OwEWiN5RoKPX
	PEomwv730DAn2H6Jl/GmP2hwBm0hA0/fg5Y+AK+yKbZmbJ2yW1TAB/nbUND7ggJH
	QYCqK7OxGRmcqMlp+z8jjEcUrjHDW+fB3JC3ByqJdh9PeOLbgcXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p388kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 10:27:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60E8VkF2000454;
	Wed, 14 Jan 2026 10:27:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7dn0mn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 10:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa6F7TEqbDh2vdX0jWOU/I8BclNSWm9IXiU7nQrXm9ZX4v0IFMeCXmyrwBUbg5AW6VKOeoryRUAUPfFyLuE7C7Z2GAQHYh+GUKi0gIJBdRuTM3wM5RB7/JMen8ug7ILF+TF8pVj3zShzCJe0YaJrlbxcwaBtPJppkkN8ha/lZSzwi4stZC7Q8A7cLqqbCHlVKei8r/eYAKEBm3tFLZTIHka6uHklZIa+QFOutH4LnLyVivm4WEed8tAemhPfBraygAZKVvt41JSI+YUNZYPoAofE+xBvMPE6IkkHSh1VUCkU4hrAB+CE0Aep54bYDEaiwT6Xup7HsMaxxmavBA/9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcKstQWHbnRs9UnfFUkvOJ3DG0VTT8YHoRt6/tOmjvg=;
 b=kapYnv++NgC18CPbdOYPLhUURYYftOQcua3/Hiip++oY9J3TE2Rcl5V3AWGszRcUGHRKrmLmprCtcZm/rlzkj5YSGreLdp0bAWomXTvyrcqc9XPymEINlDAnBmsqsrM5s/3ZDUr8N+hC87kHGWSo2UFAnrTjMQ3L2NqAcetwtdzY4CXT76ZMhqyL8z8TRDHY5PG+yhzrmD8P35h2/rRfQs8i0hx1Qbe5VqnOBFZV3tqfQDNidNyMzhFUyxTuRssEIjIe/mdt5rjX98onBGZDWNXOMhGFSSU8TAeXdJl3SPOMDzrW1s/lo9iZzDYr5YOFZ14BxjAe9AnO72PndlDwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcKstQWHbnRs9UnfFUkvOJ3DG0VTT8YHoRt6/tOmjvg=;
 b=iWl7IIW/wHYv1qWxadsTL/lmPn2T+9mXzpAICAJ6UIKDqUI5NkyD4+kZZUPW5TMo6VH2kFqQsI0x7pq/dJ2XvxuGilo8Gtpej2urQxiavxDJfuJ26651Xt9iSGuD3qAqj8wp4lvXAGo58vLj9pmY9FJTir3psOedugF9CW2xWJA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF5F5663669.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 10:27:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 10:27:20 +0000
Date: Wed, 14 Jan 2026 10:27:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v4 5/9] mm: introduce copy-on-fork VMAs and make
 VM_MAYBE_GUARD one
Message-ID: <955cd0d6-8977-4bd1-8f16-a21063a5a95f@lucifer.local>
References: <5d41b24e7bc622cda0af92b6d558d7f4c0d1bc8c.1763460113.git.lorenzo.stoakes@oracle.com>
 <20260113231257.3002271-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113231257.3002271-1-clm@meta.com>
X-ClientProxiedBy: LO3P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF5F5663669:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bf9bb6-c695-44fa-9d34-08de53577f5f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?BE0fz/fpzRvZUoLe6suEXw2AKrXJ9ByfVYtoU97qV4rY4Uyty+WVS/nOCRTD?=
 =?us-ascii?Q?YllNwTRE1MSkhYI1q67fN7HoMa4AARawcmYogZfGPc87i7coDodjm7QBBjEa?=
 =?us-ascii?Q?FUvC6XERKGE3F98PhxRD/PwNb3SFDsnrmW/87HBlbsoHsznS3DXpRVhbuX+M?=
 =?us-ascii?Q?9Ub0lWikFMOLbVtWPPZS3MzBliDgXu40XE1mw4vGYeMsiNVNNbJBJr98lTgk?=
 =?us-ascii?Q?Qgy4ldV6JnyQYkPdfBCQOpaJoKCcqvFAje5xKI2hxGY4VZnjnNuBMlc+LDZL?=
 =?us-ascii?Q?U1K6IGV5s497g8i39DjBwXhRfGtsMd2/pjV6yXFHrIh7J9Rn3WslA6TjC+b3?=
 =?us-ascii?Q?B484bM5t1M04dQSFM7DND4f6tuE0PGZ9/Zf/xmzJAGT4h2tlINeMwM1GmCr4?=
 =?us-ascii?Q?nUhAo7mLyoWYH2GRnBElpbPotSG96A4ZXPYxR+GC/qcszVd1MzHg972oBGts?=
 =?us-ascii?Q?3jUzI2Arh4MEVVMguthZJsseCWoZrz5W//flqBa/VsphDQM36kp3E6+W4u2V?=
 =?us-ascii?Q?eWUZhP79Byf5RtCJFFA6Xdgkhsb84S/v7oAlcEj/NBreCrU7Oawwn8V7UmRg?=
 =?us-ascii?Q?5hEGhjJ/e3Pae0gGpqHWW6emvzHSkSQSmyAaAqgcsrXYmeVEU5zFckXuCq09?=
 =?us-ascii?Q?DbNkHa1pQWy5RtKtiQlRJ4AKbCW6Y8XkzBAnbzcfLPZta+QkY6h/6XH091K+?=
 =?us-ascii?Q?8GtqjzqO/dmDLYOocwvWT6hCcdQnWgSqKfbrqvEz3c/AdMPH5NOF2gt9QvkN?=
 =?us-ascii?Q?77UDdJdxKvOH3qFCEXQ4B2K0EmA2vrSboEIWrvMfk9I0AQMxK6SbPaAicome?=
 =?us-ascii?Q?M7lihW7BMyYAQsbVcwGFI5YfsSQiTVC5X732Jq1kRrDUGT2N7VL4KLRluoF+?=
 =?us-ascii?Q?ZOtS+8HFERbCuD0f1btx0FlLeH6xwV/i6PxqWzq+ojh3UAFgYuHTK172cWLS?=
 =?us-ascii?Q?pchjlLpOnf9hnS/yn9WhmbDKBA5vVYSvObp4uH6Ua6On8IkpxOT6xVADV+s0?=
 =?us-ascii?Q?hn2rTg4O25Jpd797Xcxkskv8gkYOC49KLyWNcpQhCstPRu+eLPKgCdPKT2ck?=
 =?us-ascii?Q?CxDy7w6fWcP/J1dIyy3rpnvz+9z8KVlHBwTw3fT2LQo4x5172s5BPOFxWHgM?=
 =?us-ascii?Q?vXzO7ZFUproW0Z6mcDHpjzludpoxuO17PGzqmIuONBiET0Sy7m+MY/rRKtFk?=
 =?us-ascii?Q?IAq7lK0ypCxQK92c1mm30rQ1utKHiHbieWqLKI9fk9YcSVVTVIOlE78Zs9i5?=
 =?us-ascii?Q?5iYg3AZRuRO+GFL3XTknkv7z29QejQdu9I8q6OYm5JnPItpxffqAxlWM5BMu?=
 =?us-ascii?Q?wXbBZInI3ei9OH76F34QJBAY3NrTgfzyvl5woEGstjo+XKt2CtrGoVbgKsxV?=
 =?us-ascii?Q?zWgyD7cwZu+rlFLjZZ7RMEwJS21jFDjB+RA3/sTDwLSkJVUTtChvni0ZwQHc?=
 =?us-ascii?Q?yYHHC4Cw4u0xWW39E7hMY0qEB/v9Tni3?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?nM/EDM0Cv3qLZLp454WGSPoaZC0MhLOxmWcY/iv5yXP/Z9h4KdM2MuhWcBuU?=
 =?us-ascii?Q?/v3l/iPqtB6EpCkv0JIKf2uMSbG99mZM+xxCu0vMpakbXj3eCyPjxMuvjjzf?=
 =?us-ascii?Q?opTUz/uG2ngkeJ6F+wqQ5BKKxNH1p9RP0mJzHzF8mTQrj3Pd20ber9EdDPDb?=
 =?us-ascii?Q?gnSrLhykES7X4NpDaGBh70WpLwOaC4y8/wWB4aXljuY3a5GAmYWk+SaPediD?=
 =?us-ascii?Q?kLAYNX5PtsqIkocqU85/1mtkBHwktgV+3ZWaA1jObPHaVbGqZSFgIP3m6Tc7?=
 =?us-ascii?Q?+nAhpwZyeDzfeAZ5ZCsqRCFHvH1HMdRCmfj9KXrU0WMF1Mfnrw22ynHfMhPW?=
 =?us-ascii?Q?EC2G+cyu7s0XNTW9lNMMdPGa/CKHx+ANZhKCkHKNqOf5TJDZG32KDMnKEtdU?=
 =?us-ascii?Q?9SOOrLLtSOz/W34VcFoZI7Fov4DFK4uBwJV0C00GURiv7t6nNZJqIDWXcxIx?=
 =?us-ascii?Q?Iq/K9EqUOyiN8LJzTu7Ns7jBKDtKzu0FSqPprLePl1FdZoezRFev9K03VsHZ?=
 =?us-ascii?Q?h79Y0q7cN4rMbqNveWtdJvBGQomqDz8TJx9vau5cSTdysn++fNSCiqqv1NZ0?=
 =?us-ascii?Q?3px+W+JHGaT/+ObeIgANfQ7MJu2sKFhfcf6UtMzoSsr8Jseb2v5vZpErixB9?=
 =?us-ascii?Q?IFsvSTVClli92zTmQFgu197dPaNYeDSBG51M/9GGOi9m4s8gcApT46xoC4U2?=
 =?us-ascii?Q?Obc7kyTUxU3YoFfDCia2VCZESD81R9fG4sKkcNdvGnb2moyvBejmOM3Q9NOJ?=
 =?us-ascii?Q?ub4yt5JUlWDSQFEn+Hig7S3HbBNQoE1l5gH9eOZiHKsa17WCLluUD9hyAqMS?=
 =?us-ascii?Q?CUj2vNiT5BPhAXdRn6zkFhepyy6OJ2zPyds4Hsq3YvbHOI1UUTr2G9+1Cqjo?=
 =?us-ascii?Q?jgdCvdntakFDy8So4E3xtQenHtjKYxHHuaHU1bc7OK6zYXh7Za35oA/Gd5o1?=
 =?us-ascii?Q?2eznk3o6l6rZdBj+muIB/Z+7DQ66W2/lFsB7N0bE2Vh+r6m8cGsHhD4il7TH?=
 =?us-ascii?Q?sqB8bejnqjiy3c5+ADPjtndlIgZBf/8k05zfXuRvhywQDjIrDR71ybvmoaLu?=
 =?us-ascii?Q?z4JZs4zV0rCgD4wNYba4RjtzwjvNtyUfrnq/b94ZUtu6qOuiyVMJJHpVkoJw?=
 =?us-ascii?Q?2Yq9xhJ4STA0kGOBF8ZzTG6au2sBYOniFlfpQHycfVGAa9iZviDiWiOOiDHK?=
 =?us-ascii?Q?6iL/tYUGPtPQ7KAw4Gu6Q4Vg/lH1oBy/HGagKBgQQ3oSrLderbfZ55pJYKoC?=
 =?us-ascii?Q?5MnACWq4FRzjWKMWHHeYxTMA/1uef8ougL1KU7Pg6UDkpAjmXz0A2T/LjaQX?=
 =?us-ascii?Q?ket1KJmQ9FQWBZPvWgkrQDwig+zRIC8gcX2Qtt9B3vSsgmn++uKsZTnkZRE2?=
 =?us-ascii?Q?LuQLcGvVGUAkmE84XPkFBOE2lTIKhQOdWqQhcd+DP+KDTHKSlH+WpQrBMdk6?=
 =?us-ascii?Q?9FICrf859zXBbU+YzqyPiHvU9Wyy2o2NR+5XixWa6UAcTfN1SFvuOyditmfh?=
 =?us-ascii?Q?BVsYte0tz7ttW5QGL2Viy6cZb3PLRyKztKWHcNbBN7h9y96Jet5RfBoIyWC6?=
 =?us-ascii?Q?qhPi0eX0JqBixXaickMJ2N4rZBOvG6s8e/BtySPyQwKUwgPCO/bMfdlCpYlG?=
 =?us-ascii?Q?sBcvF7jQfLM2kDZomC/f8FF6f3GI9Q2OsZSiKU3D6/JaavmEESxh8DS6fOdD?=
 =?us-ascii?Q?RHX8geahnHIdodRsQRPXHc09v6akbJ7PaSY6+MEC0bOQf8VZ9tDbBSFIA11X?=
 =?us-ascii?Q?xNTymHvUSINd/2phPpWZ0QbpH7EOhmw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xq8oaF0cPjj9+bvvrXmfuzpe2Ye/1GlfQY/NoBSg83/BrxZlReqPhGm5XxHTkfskIW7pQSJrOU4bUCglBXLpW2QKxxgMczIksS3CplMeW6nLwnqtUoJSKND65BU13fEzr+eVdM3+PHQXJBEFTZvzAiDbfm26nDmYRZwgoTpsNpql6C7/4LUzm7QMCGt7wh4857L4FRm8U1AqO7lCGdxM3OXEEqh3tVcCMb9VPcYAz2oxtm7SmGSDo5FE8VQ+Qswo4qyqtiEU4JQteFvoECAw2ph7cDkGK/Jjga1RlbG5vrnl7RmmL5QgwUTNWzx428xI4w5Uc/FldfDnXNNxXrT6eHsc8RDXQZsbpGvfK575ODIIm0OLOtBoEG0M+5kEkpMxVRMQ/X3u2wmVGAMDhDfIvh4FEXahZ8JBk018CCdSowShu1X5MZy7wF84sT/o5b5pZ4VLe20Kr9ONur1TsllZojU7zrnmMmIgK8jpeXYm5jXh0NdQjHGLOL4HkRN1GRYddgqmTaDqLss3Y7bptuc7cX/Oe/oHbK7uHeSqmUqp1SDpkgFAp4k15sn/bpHJYuJk4vOgV3UYSUvL0c+DLmQCmyvqTMIKweZ5eEZoY6ZKjxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bf9bb6-c695-44fa-9d34-08de53577f5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:27:19.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxi7BAsZ+dpyMXKnXcDWkNUCDO9G0yU78+3YFKKUoDvyQtbYh7TMOHFolyKpjQGuBqQRLjS9+WEaLu0kiCU06ZYau/EL3+KtJYF738/zlnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F5663669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140085
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69676f8d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=bGSp4_k547jyi-s72bsA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13654
X-Proofpoint-ORIG-GUID: eL6Yw9enM-mZssJOf0yGvV-fXzLSUEIj
X-Proofpoint-GUID: eL6Yw9enM-mZssJOf0yGvV-fXzLSUEIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA4NSBTYWx0ZWRfX00TpvHTnDS+L
 C2EQA6vNhTvfP0SYDU4m/DFgDiFABvRat2Miqb7FEAwbbhw7W7zsDRCMimDprvaQMMVgB7O+9dc
 ZHVNSn4tZ2fxhY7dmwF8dKYaEppZZTRqhaGhujYe8a5SseIzIVbidrB1lALtD7vLCZzzV0qiciA
 lIZwGqiDKRMj+c3FZs3rddx0Y2qdHlTRLhaaXcICz6u8jzUn7gKbMUFOgkovIj/Cln25W3R131o
 E68OsMf5x84tWbgglwv/5cBXUhZXA408tfbvSlacd9Puc95ZAwHia/O+jycHW5clevPva3KGHkH
 bHzN+0ChNzYPKYWAyYPYBMmZyYwJi4Igwf82iwLduKgGsVAnwuVz/rtYDtWk5D76kVa9GBLeBEy
 cylEtXKYuM9HOLOooLNb2/jXTyDogcd2biC8XzVhxlo+ilikZ1omaWI0B0ad/l7DJLM3/FWMtmw
 VlizcTEctp4aM8qDBQ7kRK5OrZTU8Wo6oEfXyLtU=

On Tue, Jan 13, 2026 at 03:12:55PM -0800, Chris Mason wrote:
> On Tue, 18 Nov 2025 10:17:47 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Gather all the VMA flags whose presence implies that page tables must be
> > copied on fork into a single bitmap - VM_COPY_ON_FORK - and use this
> > rather than specifying individual flags in vma_needs_copy().
> >
> > We also add VM_MAYBE_GUARD to this list, as it being set on a VMA implies
> > that there may be metadata contained in the page tables (that is - guard
> > markers) which would will not and cannot be propagated upon fork.
> >
> > This was already being done manually previously in vma_needs_copy(), but
> > this makes it very explicit, alongside VM_PFNMAP, VM_MIXEDMAP and
> > VM_UFFD_WP all of which imply the same.
> >
> > Note that VM_STICKY flags ought generally to be marked VM_COPY_ON_FORK too
> > - because equally a flag being VM_STICKY indicates that the VMA contains
> > metadat that is not propagated by being faulted in - i.e.  that the VMA
> > metadata does not fully describe the VMA alone, and thus we must propagate
> > whatever metadata there is on a fork.
> >
> > However, for maximum flexibility, we do not make this necessarily the case
> > here.
> >
>
> Hi Lorenzo, one more from the review automation:
>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fea113d1d723c..af2904aeb1631 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -555,6 +555,32 @@ extern unsigned int kobjsize(const void *objp);
> >  */
> > #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> >
> > +/*
> > + * Flags which should result in page tables being copied on fork. These are
> > + * flags which indicate that the VMA maps page tables which cannot be
> > + * reconsistuted upon page fault, so necessitate page table copying upon
> > + *
> > + * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
> > + *                           reasonably reconstructed on page fault.
> > + *
> > + *              VM_UFFD_WP - Encodes metadata about an installed uffd
> > + *                           write protect handler, which cannot be
> > + *                           reconstructed on page fault.
> > + *
> > + *                           We always copy pgtables when dst_vma has uffd-wp
>                                                            ^^^^^^^
> The comment says "dst_vma" but the new code in vma_needs_copy() checks
> src_vma->vm_flags. Is this intentional?

Hmm, looking deeper into it, because I assumed some basic level of sanity
here, but UFFD is terrible so that's never valid thinking I guess:

We invoke vma_needs_copy() from one place - copy_page_range().

And copy_page_range() from dup_mmap(), i.e. on fork.

There:

	for_each_vma(vmi, mpnt) {
		...
		tmp = vm_area_dup(mpnt);

So in the dubious nomenclature of the fork code, 'tmp' is dst_vma and 'mpnt' is
src_vma.

vm_area_dup() calls vm_area_init_from() (delightfully flipping param order)
which calls vm_flags_init(), which copies src_vma's VMA flags to dst_vma.

Now dup_userfaultfd() is also invoked, which, if !UFFD_FEATURE_EVENT_FORK
in the original uffd context's features list, does userfaultfd_reset_ctx().

This invokes userfaultfd_set_ctx() with vma (equal to tmp, i.e. dst_vma
eventually) and vm_flags == 0, which then invokes userfaultfd_set_vm_flags
to vma->vm_flags & ~__VM_UFFD_FLAGS | vm_flags, where vm_flags is 0 so:

	vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)

That is, clearing VM_UFFD_WP on the the destination VMA, but not the
source.

(I really hate that any of this got merged, it's total insanity.)

>
> The old code checked userfaultfd_wp(dst_vma), which tests whether the
> child VMA has VM_UFFD_WP set. After dup_userfaultfd() clears VM_UFFD_WP
> from the child when !UFFD_FEATURE_EVENT_FORK, the old code would skip
> page table copying since the child no longer needs uffd-wp protection.
>
> The new code checks src_vma->vm_flags & VM_COPY_ON_FORK, which includes
> VM_UFFD_WP. Since the parent VMA still has VM_UFFD_WP set, this will now
> force page table copying even when the child has had VM_UFFD_WP cleared.
>
> For file-backed VMAs (e.g., shmem) with uffd-wp but !UFFD_FEATURE_EVENT_FORK,
> this appears to cause unnecessary page table copying where the old code
> would have allowed the child to fault pages in fresh.
>
> The call chain is:
>
>     dup_mmap()
>       -> vm_area_dup(mpnt)                  // child gets same flags
>       -> dup_userfaultfd(tmp, &uf)          // may clear VM_UFFD_WP from child

Yup as above, this abomination is in the source code.

>       -> copy_page_range(tmp, mpnt)
>            -> vma_needs_copy(dst_vma=tmp, src_vma=mpnt)
>
> > + *                           enabled even if it's file-backed
> > + *                           (e.g. shmem). Because when uffd-wp is enabled,
> > + *                           pgtable contains uffd-wp protection information,
> > + *                           that's something we can't retrieve from page cache,
> > + *                           and skip copying will lose those info.
> > + *
> > + *          VM_MAYBE_GUARD - Could contain page guard region markers which
> > + *                           by design are a property of the page tables
> > + *                           only and thus cannot be reconstructed on page
> > + *                           fault.
> > + */
> > +#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
>
> [ ... ]
>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d1728d0538d64..27bc457b32c2e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1463,25 +1463,15 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> > static bool
> > vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > {
> > +	if (src_vma->vm_flags & VM_COPY_ON_FORK)
>         ^^^^^^^^
> Was the change from checking dst_vma to src_vma for VM_UFFD_WP intentional?
>
> The old code was:
>
>     if (userfaultfd_wp(dst_vma))
>         return true;
>
> which expanded to:
>
>     if (dst_vma->vm_flags & VM_UFFD_WP)
>         return true;
>

I'll send a fix.

