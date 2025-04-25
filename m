Return-Path: <linux-fsdevel+bounces-47366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F3A9CAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B63E9A7A97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95224A079;
	Fri, 25 Apr 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+of6EBm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iS6Tm9WK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF48288A5;
	Fri, 25 Apr 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589341; cv=fail; b=HN2YYF1sUagrr/8d9awvVFHkwrvZhMaj5ZnamVW5GIEGC+x/gn8GVVGbX8RAs+hia1qtdqJGZHlxvSq43LFZCjTgp8exaZo1nfC/7GzEZyJOwk/2+sQvCG+TOLt1OWYPjm7IEwjFOnc9HDqYbD1vLhlisjwFwGHwpjv2v3sM3r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589341; c=relaxed/simple;
	bh=yQitoAHmzIdtnD9TYtxxEcuTZKMnU3ST5FMadWxVHbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJnAY1ncnNuZA7Ljd4DYv0ojZ8PDIeeF/IDEYRfHWAS7KOzcVX/NYnahGF4RovkDLI3XXCQCtv4CSz6xuD2xs3U1e4TSrjoHezW/q17EVgo6uCnzL/fcgzZ8jXdL/nklPk1FkVf+T/YwgD4EDPWSmrYUMFE6zM3oIQW0C4LhZ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a+of6EBm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iS6Tm9WK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDYjkF013005;
	Fri, 25 Apr 2025 13:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3nB2p1G2HpbWSHJsI5
	r53TDVJXkbZjys7aMW7JJkDP8=; b=a+of6EBmPoT9sp8WBAS5eQMsxqbeB+DFPo
	Kl1XW88NLmMgZLRt8ZGMPAAE8U25kUJh3JsoIoY++Vz5K4u2rKV/Yec6vIMh5N0U
	r4nNFHiXByZ0VgbdlFPkR2LWyUZygEwhlMjczLGlg9ZQ4tF0HogWfH6VPCANZ+Ch
	duYbOCelI9bta7CIow/x8wo8VVk91rf7aA8O4RTT83+gs0zwWo+5Hfd3D7A84W8L
	9rm9fhrRDYOWDA81417S80dD3ssRqsKRDsYJJkXf9WPXf5Om5gT7Zjj4iRBh/RAJ
	y9xO2pymUslK1s1dqwToMCuotel8PXXe7bUuhUcFwET0gPjxm2dA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468bdc83ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:55:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCVqIu017398;
	Fri, 25 Apr 2025 13:55:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvhwy8y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJvgQqICFdRtLOskFEgKOLfZVMrlhZRDEVcEH5Iz/fZn1awc9iPHxO1Gwlak5VmKIaIyN/1Fb6UHgsi2MuUEJ7B2mq4rg3NnzJLv92AJbNjytk4Z2yjkO2ck2i8EafGqlVM9P8BagvlWvFeUqtx/+bM4znZPjXxZKZ6TLHg7eaM30bx/ZwFFqvTMZceBZmPWW65Pm/xuJyp1mNp/VqRpJjQlKUymUdd67CmDQ52NV8D5EFceDeOB1+VbwqlHPGnDEHFnIeRyR96qHKr77iCegrQA7HsAk0PYG0HOBY8blPMFLoypLdD87Vy8/t16y2L5EkE2iQ9nUhNaa6ChzUnVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nB2p1G2HpbWSHJsI5r53TDVJXkbZjys7aMW7JJkDP8=;
 b=jZYKjFIgZ6BxkeES+WSliSBm2k8R298Cevz4GCV1MI9MUroI0yJtx3u3/ftnOLePy4Q96qRIclkls6B6dhk85YqS0v8Oo0uDAI+XqehD9HZhhgARzOMDOUyOgbIS6367PFsc0v7Uac6pq7fhcayhgfB0pzvMrEBw14eHz5NshSLvxuYk1m7YmKIzOsuu+po5vFP0DM2wc0bTEP4dX+KOhBvaGNaKRA83REuZvOzo7NJ2v2keG0a6FVZ2oDObbOqL+x5xu7mBXr0x0g1b2Ck5t7lI+ykHbuM9jycCSxcSlDHqZSekt0hzVz+htiIvUMfEBTZNBgoGJD4n3opB578G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nB2p1G2HpbWSHJsI5r53TDVJXkbZjys7aMW7JJkDP8=;
 b=iS6Tm9WKP/hwV+qPk2NQJhy+km/XrZGUgdGfayR2fuirEZaD3gDaih2dL82vA7/bhnBxJG9VOvyXBuzWGZ6gkleZecBGqEEkfgg3lww+ta7jBnMpKrJ6GKnDAyfYZkItD0L0x4k6lNBZpMZqUon9x03UK0dja0uXlLyTcg+YEGY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 13:55:12 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:55:12 +0000
Date: Fri, 25 Apr 2025 09:54:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <n6lrbjs4o6luzl3fydpo4frj35q6kvoz74mhlyae5gp7t5loyy@ubmfmzwfhnwq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
 <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQ1P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA1PR10MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 69094c1d-299f-4c6d-2f42-08dd8400cc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPUGjGw4SNKv2jjjTiKJwj2E2K4ztW6s8wPKBTkfLF1HI1OdYKaP1/eGnvYO?=
 =?us-ascii?Q?tJpU24ulBchMEZs+OickzRr8C9Fv02D96AJvk0X7muM8JhSgAsp9iW27hbWm?=
 =?us-ascii?Q?xabz8aHQA07vez+ywTxvhC83C7mmxzltP5U+FWAaGF9WM6crh30ANnEOpJXF?=
 =?us-ascii?Q?kdOSlD3Q+4rdMO2Sd2CY3aA0gXrCyI06ZBIxt5vD052IFktm0HfhZGakuXlK?=
 =?us-ascii?Q?lT9xkM73FR+/1SB1JY0nPE517Q9ETsc5SXKCLjzboR3FUcaaYihqo/iYPyfp?=
 =?us-ascii?Q?UvAvzcCdPHZSa5WDY0YLc7e2hFjrmPAeBMQuPX7DP9YNSQkCSo6ubeZctT3V?=
 =?us-ascii?Q?UEe7rurRFC5YHH3YMe9+1/xwfqjQjLBCI5MHwlri41x8Fi3FXZNv7CwN6UM3?=
 =?us-ascii?Q?SFsbIexysYzxBe7KsJ0prgY8tA3/j44NS0j/1dcid/jIIlgXER0gCp3VH76u?=
 =?us-ascii?Q?xRHdVScjvnVd7HoM0OxhyiwVUSea3Z5xX52drcA8LsHBQXGzolZp2m3mdwr1?=
 =?us-ascii?Q?JAuMBGdeebOjX7UxoQ3XfcbRWMawXywr2Ab1onIT6AWW9ljGZXnKm70aknZt?=
 =?us-ascii?Q?HPqMViNYZKrGNEzyDi7sDyxEA5vERElS05knjWRA80x6UvDCcTvdRxGNPUK/?=
 =?us-ascii?Q?8hdDy1NrfkOp/pBpZ5hAV+1ak5jg0Pju/dycMOGgEoCr9n8oxxZ2VQ7aLgD5?=
 =?us-ascii?Q?SGz4ePm1YW2JuHSG0sWCIQ8IRR7LId1zxgNkEYm3Wz4E0zTLCkpGSIzl5Tb4?=
 =?us-ascii?Q?En69hQdSUNT2FPOcBLgzxvwdQsBJuYeDdidv9YPCjD4T/PEjMwmI4YpUp2qG?=
 =?us-ascii?Q?wvdYJCVqY0KGkAymwtaQ+OfLe/ZoR7NLVixBdi0ji7NjSs0zQG0/YVDbFdCj?=
 =?us-ascii?Q?wu+H5Gre3z4T1MJVdkKinrk/Qy4o108puo20svpIG34CypZoFjA/kE7XOZZe?=
 =?us-ascii?Q?7jz+IslhrewHPdgnNZqP4MBYvBlEMdFY3jv4kEjIo+zgWCNoLPSuV4cIl6Be?=
 =?us-ascii?Q?krqKZ20mqr1ZGhmVK8UN6R5/XEZiSkoYNm59mq8HVyyPI9D68l8uanjLiPnV?=
 =?us-ascii?Q?T/7Yfovh7/29jlB6H4PPF+lGiu7ah25HcXWLkzYAjYZ2ntas/qlcmZp6b3ea?=
 =?us-ascii?Q?t3D/tpl96fu3SMN8iAO6UXPKwrPXNgPpxTJ8r+HSFCAqzEbLWdnN1izUuyq2?=
 =?us-ascii?Q?lAe2uQF/npJjwDcv/xNoIc+0AT3BH1VMnXGIVlIKIpO4U8um0n+zwL6Hf/ob?=
 =?us-ascii?Q?PXikhpylHAZWAfTbkl3HV8CP12CD9XBIRZY0OgNLNSZ4Xdy/9xc/m2dnjiwa?=
 =?us-ascii?Q?VcM6Czf7dwcU3mc9rXiFga3jOHUIHeOpmuL85xCyKJyv6+zlMQiM/EV1p3TL?=
 =?us-ascii?Q?xwGT6cirNuz7x80WlVhvELOnCCtpegoO1cLW1Qe2l/zNuSbH6CsNTy6S5O42?=
 =?us-ascii?Q?VBv06VTTaVJPsyItm/T4UwUkB12sXv2gkx52Hpmc1URt9/PyoOaOhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJgDeAYFTLFrQxNO5FIvVUnGw1OCjlU5uKyPGot21/dbuOpYv6pybG74P7IL?=
 =?us-ascii?Q?02TgChOn+7aAhJQg/nShbPpXu7hqAM8skEwHjB9yvhs3D2Sf+vadrIOn3L9w?=
 =?us-ascii?Q?JkZSJwQ3VVbMQaHJkUYWQfA/pkqo3JZKW1A9MPxiKlfRJcL/yzPi0xREVWCE?=
 =?us-ascii?Q?Z5v+KCGv0t1o+sN0/srqNdKsb8DxU1czxwFwkz38VzMdEgl4nxThkz+QkkV1?=
 =?us-ascii?Q?D0arngZXNGqMDX9EGXnOQWPS4mOawm6AfRz8CYD1oUmY0FZuU2ijDySmtwJ2?=
 =?us-ascii?Q?LQ9XqXnzplIO93p8RMXOhy56JW3mv5Fmw4si4daQnbJBJ/e/lvVwosFHtwp6?=
 =?us-ascii?Q?ThG9/pRAVvnwgHLUMc2eUpQOZ7aEhUoppNM4klfxkD3tYRxCyZY3UnEkvgwc?=
 =?us-ascii?Q?+EHwjIT6KjnlDIV1loBCTXrq6Lri3ONWKQK/DeaKOJ3M0xExL4aOsGyViEQj?=
 =?us-ascii?Q?XpStlghZyzdjlXZD2LSiiP4o7WGWE2kbUhTxo+c1T+hUQAUtnGqULoUv9tUA?=
 =?us-ascii?Q?yIKnoyzlIZ78LcH9MOAr1vK63eqHl9leq6JXXn5e1ECCBH5EhoOERTqAm0/1?=
 =?us-ascii?Q?esYq7et9da2/i7pCYCIDtkaC2jGJGiBF5urXXLBBA2ALlxOTH2dF3vDP37IN?=
 =?us-ascii?Q?v7d0ktxmtxm8OXM7+JR+gBezBxxC1Xk4rrZJRr5YQd8D2NGtAVaxv5oxxfrY?=
 =?us-ascii?Q?+0BEMftT+AYS7Bq7FgRceC702H/bfmCu0Z0/v2doBY26YwR4CSiMCABMM/EN?=
 =?us-ascii?Q?RhOZdODpon0l9a8oQJmnzhb5nGVzFnTIajmjURhIGEGkp6DHDBFinSLkemOv?=
 =?us-ascii?Q?7/qsXePFAdFIrFnQOz+yxt4tHHyr4aQStwR0jG9/yK7ni+6j/5OiWhk0uloF?=
 =?us-ascii?Q?iAv1OVsJHaslzHKCZ4wHNSaDAfZLwkvhXmcxVa+2ReDnvm4CKzIwKqCI4r1d?=
 =?us-ascii?Q?cByGqDEgLUkayTbRfTLekk20hvftjGn+yTRM1jE9RY3YvoA8lWdnlgFNLAxK?=
 =?us-ascii?Q?b6OZjPXFhX8fmDCloS9YUiVhzDsCaNELhmLz1KtnwTjpby8Q0Q64f4+adVgA?=
 =?us-ascii?Q?z8wpORpx7t022EiY0iAye2w59NNwg8hYp11NZfXuAico1l4aa/hDRtC/z6iV?=
 =?us-ascii?Q?m60LPS8pEjRmjWLl3UezpxkHeSKxbLmrXyrFwTAoF4HrJisT1XCWcvNo3wpL?=
 =?us-ascii?Q?VW2eTbUpkbLXQo5Ke0360RGSvSm4RXK5qzVp4noTYJ28T0H8eI+iTcIS5Yux?=
 =?us-ascii?Q?bO2BKlIEgPoPrkT2U0obRdc/hr/ZnvDRRjIaUNGvwgG2f99+mK/+Il3xiDJ5?=
 =?us-ascii?Q?ZaGPbXFgOOgwisk0m5/2b4941EmoHRFTN5epElMPwalHhoBQkJ3a0MJrQ4N7?=
 =?us-ascii?Q?nVgUO7jaGnSWg+u0oiqVVCgPd4F7+GMT5FL/CllVgc+uPW9mPsV/WVjIxOkZ?=
 =?us-ascii?Q?yLnvVujqB36KGQRiAHvc0XpF8RaVn+SEXTSEhfvawd8EuXyRmCLpohxwCGc+?=
 =?us-ascii?Q?p4uTjKmwp8j6ioMtHcg21gKq4pX4o/3S86w/iVd/AddmKVxqsBlwhsV5okIT?=
 =?us-ascii?Q?LwFx041HaZiMBpJnwl2rXjIWgHiMEG6zlbMhjRyb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fgUqINKtI952s5dnAwKK9vUDB9VAVA4Hac0rGPZFWyF5TOJ8DU2hRfHvpeCN0dLzD234qo5hrfpbW42u5feh1szHIsRVAzMrXwqBzzi5Smq3nOIVwVWXUL48vUkG5qWMXdWU5u7L3pnjibc3Hqg4wiaJJqYju31uDmwVOfxAUakAJyYApxYZaxYOvro7IRjlJBSEf0yzy8K8tbiwIyWv1zTBXqloVSc06dBV6v/ABQYWtuzhO2neEsEjIyg/D5pWXZFGvrPlghwm2So+T6RSSqb6ZmgLLxRWh9Z2gtYFuiDlyZw+zSkt15fxmZCXhwQwfzQI8P6XVrI706TeydKUULMthnIvoWyAFQ4Bqv2CfB4GGof5iZ0Qim5Q0J58iE5pYT5EIf0k6oGOcJ9RiI+EcFBmdR0O29UxX+x/Ah6WJHopi6EugAhOlWE/3pTRHOBmZDGYwxKZu1WwzIEx44arpwYukXiq/3uXAeA3bsHMhxjjUif3igSW+OeVwjlJGd0gMkvop7/KopESZv1277Om70V77Pm43cUu+cIHgJ9NvZMs6IK6zeyBGZpuOG5liozjwUw5wgUZ0Wt4El94iO/zvlirLgrMgSj8/cq9KcL7foc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69094c1d-299f-4c6d-2f42-08dd8400cc96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 13:55:12.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXNxgjLSfMJGNLuzHND5O1jFKHPUhxYqu7++kC9RqDJm/T1Wp22QPmFZJWjDJRVrWsVyCSazDXP635OMHpqjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5OSBTYWx0ZWRfX5rdEwRf3R4ZK /4ITGXi1fOdIfgxI7HJ7gBxq46C6F9MIWFIiGi66fiTbcS1SuFUF0qJqWgMFVlw9XZFYje4bBCJ f14ByqSMDaGD9umqPX0M20Eu9Rq3Xa0DwNuPt6fFyp64T2LDj08OUJ3ezVD/amYhHjQl0cV5c0p
 ymca93sb1pU2siNfDTz83EGgFkoevE1xct/a7h4CxCkOEq0Gc1T+ZSvL0Hq6AVWLMjkUWnoSkZF usnz3u2SrCEit17AMkDcfuDDasKwf9iku9OQrM/PkDNLItMmOoO855DsKCEIvZ2YLwrgc8UFi4L 3M2btTpFhYqJ0J0EHVHTOvMrrk9wmq/5T0SR2ua+c7OyQmqeXBYvrE0uHOCkpMeNYdZarGTnDDg Yx27SQvf
X-Proofpoint-GUID: ZA9--ZaOKsaQCUq-alr6NAYyrtgAH5xT
X-Proofpoint-ORIG-GUID: ZA9--ZaOKsaQCUq-alr6NAYyrtgAH5xT

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:40]:
> On Thu, Apr 24, 2025 at 08:15:26PM -0700, Kees Cook wrote:
> >
> >
> > On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >+static void vm_area_init_from(const struct vm_area_struct *src,
> > >+			      struct vm_area_struct *dest)
> > >+{
> > >+	dest->vm_mm = src->vm_mm;
> > >+	dest->vm_ops = src->vm_ops;
> > >+	dest->vm_start = src->vm_start;
> > >+	dest->vm_end = src->vm_end;
> > >+	dest->anon_vma = src->anon_vma;
> > >+	dest->vm_pgoff = src->vm_pgoff;
> > >+	dest->vm_file = src->vm_file;
> > >+	dest->vm_private_data = src->vm_private_data;
> > >+	vm_flags_init(dest, src->vm_flags);
> > >+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > >+	       sizeof(dest->vm_page_prot));
> > >+	/*
> > >+	 * src->shared.rb may be modified concurrently when called from
> > >+	 * dup_mmap(), but the clone will reinitialize it.
> > >+	 */
> > >+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> > >+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > >+	       sizeof(dest->vm_userfaultfd_ctx));
> > >+#ifdef CONFIG_ANON_VMA_NAME
> > >+	dest->anon_name = src->anon_name;
> > >+#endif
> > >+#ifdef CONFIG_SWAP
> > >+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > >+	       sizeof(dest->swap_readahead_info));
> > >+#endif
> > >+#ifdef CONFIG_NUMA
> > >+	dest->vm_policy = src->vm_policy;
> > >+#endif
> > >+}
> >
> > I know you're doing a big cut/paste here, but why in the world is this function written this way? Why not just:
> >
> > *dest = *src;
> >
> > And then do any one-off cleanups?
> 
> Yup I find it odd, and error prone to be honest. We'll end up with uninitialised
> state for some fields if we miss them here, seems unwise...
> 
> Presumably for performance?
> 
> This is, as you say, me simply propagating what exists, but I do wonder.

Two things come to mind:

1. How ctors are done.  (v3 of Suren's RCU safe patch series, willy made
a comment.. I think)

2. Some race that Vlastimil came up with the copy and the RCU safeness.
IIRC it had to do with the ordering of the setting of things?

Also, looking at it again...

How is it safe to do dest->anon_name = src->anon_name?  Isn't that ref
counted?

Pretty sure it's okay, but Suren would know for sure on all of this.

Suren, maybe you could send a patch with comments on this stuff?

Thanks,
Liam

