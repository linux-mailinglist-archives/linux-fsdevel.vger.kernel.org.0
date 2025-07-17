Return-Path: <linux-fsdevel+bounces-55266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6159B090DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF983A419BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D62F9484;
	Thu, 17 Jul 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hlew9X8+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ezAskAmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41735963;
	Thu, 17 Jul 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767320; cv=fail; b=JCZ6iu0wRWXFpSDuR7n+e9QomwlizBjhqYtxhFfFjIel+phA79NjRdygbJjX05EdTTXrVkwK2dXnm+f8abr5IaF3nud3HcYY/EMWZjeAWqDC7hlRLV7hkqakQU/b6XnfPKmBSd4+MZWdzxJ20V0wVoW6Vr+eehSZwWXJj0xSh84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767320; c=relaxed/simple;
	bh=5OFupNVt+viXO1YlB9pmGpsJSFARHp4TNcuVE/XM6KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ieonhjIaFVdntwAx56b/vYwq822xfJ0sJdj2VTji4zr1nFHScCwJZtXxn8Sn8Au7SwVbXWoax0S0LIXsYY4g2Tv3PlUfvSEwXsF5qB5lqA5RpMGRPKRja1f5Lq6VprAYXEEMOUn1SwE4DHZJzhQtuwfnQWXwv90hr9FOW9o4U8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hlew9X8+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ezAskAmj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFfv7k024004;
	Thu, 17 Jul 2025 15:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VUK6RMNiEGcht6MZId
	AyltFKHQhtIo79O24zgJULf3E=; b=Hlew9X8+96xPjwZrCZuk78GD2y5pCc6CKw
	IbptpwK/dHQYzrmGPtp3020WSsSBJdpE1s5/fRv0ASSN4q7MG9nzFvRiYyhHC4X2
	MciLzMaFJebKV4jx15IgNInLcXl+3/9ZvnYcO0Ibgh1XsufVTILVELfd3bxIE9o8
	759emRzXIUMtAHHOomPvKrLrzAzaG/9M/N9HVrDkPk/COGX0q5TtgWh8IJkD2/4m
	444qEB4AwbPw44grzHkdhgm0XvfynmFlndZJlpVmhQfkbeiYw5MQCgITfowtwUnL
	3xTJvLJ5XhoXkKA6pAhi1yIhCdpsEE9CVZ2LVU93eTjwJR2UD6Mw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3g88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:47:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFNljN039577;
	Thu, 17 Jul 2025 15:47:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cxtkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcU95HziCPjjg025XwyE82a8XWNlH5DJ1phT2+M6isCAVnwOXMsoHNcVjEMaKjGku9DpRFytgxukweRE8EBEe1Gforn6UhBhlDdXuqk0lUO1TooFozasniYCGe9O5b/lyamFReZUqqG2QfkAAkKBnwHo3/netdzcDjPLhJDphJsfgOKpKMXcJzHh+EgiSYI1ZqwnNs1023Iheqq8+BMSLwVkLkw1JMtoJWMOKtLDTsPF3zzwGeENcdqnL+mY9IUOLZzIj9XckRyVu6pdAr0hmDjlR2VnijrqpXVeG3DR70Zs2w1QS/NwCv/WMhSp4/ZUtEk4WKZ0hmrgNd7I3DxVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUK6RMNiEGcht6MZIdAyltFKHQhtIo79O24zgJULf3E=;
 b=WNWvblx68PWvM6kHHzrP0YjKVp08t8YbWn4uQieYsm/AnkueEzTextbYRmO541/LYX1kAd2dh5kWzsK+1UErWC+KM5s6tDEblJ0rtwRxPOVxZWzME9RZAZtjaK3cqNwy3nqDJ6oEBbE8UF8x8TMMTaGsv/yotXD5hh35Gcn1jYJ9YXMWsodE28h9312gs/IW1KZkwS5efZQStZJnTVSreAclvQU/Rc0Ql67o37+ol33GwLzTmJI+j7cWSmQzgcKeODXzKay7VQ4Te0seCkgJLeV80/IgQTw/2CPBU7izrqrvVxTYZC42tnoK0c8Ab9BXs2yDLru6yZg15GbCRH4Mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUK6RMNiEGcht6MZIdAyltFKHQhtIo79O24zgJULf3E=;
 b=ezAskAmjrGjtoVpsyJ6la7DqrA7lnA75CJy/pWJsy8wU+7ZCtknUqMq1O+TV0A1+eCOunAXrFWU82euZ0pkLV1nMJf4/dS+EpqCRnBsZGAVL0sDOR6n17xabu+QkwzltO+gVSvqUL62SBPoLP1y2MObV6cFaywnNq/17WY0dPOk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 15:47:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:47:52 +0000
Date: Thu, 17 Jul 2025 16:47:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 3/9] mm/huge_memory: support huge zero folio in
 vmf_insert_folio_pmd()
Message-ID: <8d832915-152d-4776-9b8e-b5846e6ec47e@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-4-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-4-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f6bb67-1ea3-4cab-53e4-08ddc5494a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+BaWDGHls5XvAXywsklJlaEx9kRukMPaNVp0M1B252pm+G0Kh4rzUS0u7rX?=
 =?us-ascii?Q?JZsveCn46hXwsrF5vUMutkVgdCJjPZCxFdAkOLoxH9j0ZK8SnfFz/baES2k8?=
 =?us-ascii?Q?QIyevAOHsKeLi7OHN1E2FL86F3BW1mwjI48/b8BNetut2ZWgEVKc1sz3TIgk?=
 =?us-ascii?Q?UpaE9Cw4w3svT8SPt0aHczXJOtubS4SnIOEST5AkNR/12ZfWihdddD1Es8k5?=
 =?us-ascii?Q?f4iE7yEmYFjL54a6Lk5Wk5o0xk2UYq1cgRlJ3oJkZxusuy5L5b12CoTvzGP/?=
 =?us-ascii?Q?NeExL6CuSfWOcw9ssjqBO7pmbyl7NIgWlK6BBQiCPrYBrzrQK919swquDxh3?=
 =?us-ascii?Q?ce+KqB+tzgsmqskk3B0G3wx63mZ4UI65d1omuK5LZekKEZ1ClYWlvta2ZHgJ?=
 =?us-ascii?Q?1Q9ETqT8HdBxolEQStaZbAIfDe8T9OGgkXOSSxAD0S1vEFUKpsOK2FEsFXP3?=
 =?us-ascii?Q?Pj74Xm1r474RasBO+l9A7Uv3kOZF5Vc6bVEPTLcDWufGR2oKLkHREjc9h5tf?=
 =?us-ascii?Q?NWZIfYWTOmkD/+1EgPb/jDZ9cz5pVVBEW8aS45Fw7xCIqXU4lYw9l8kwJjg+?=
 =?us-ascii?Q?DEiWECCJXhu8EJtWqyxPygdxpWOZdWC+hXsmy92s9Fw8WQKOurgwApfUnqLb?=
 =?us-ascii?Q?bYQ1GLNnkeMQxzs/SasWCheeBOHPRQk35n4Lm2ZbLnrU3F9Zm7RGU1UMQU/g?=
 =?us-ascii?Q?tzRD5HGm04MXAEcL+883eF8sgKQ4xh/pyjUcV9BcazbLBg/Km5uu+jQw8PhL?=
 =?us-ascii?Q?gPyba291eh80TTSbEpW23mXYSAwmPUhCAWJXNvqaCmE+aBJGAmj+OYST+Ial?=
 =?us-ascii?Q?I49Vm1WX8JukSb82fzFuvNxPsiGvEeAtjuur/XVlhrIBimwHnDx/0dbk3cpn?=
 =?us-ascii?Q?avs82UmpsE1aHzlRZ1iPDY5kth8NkqXhCxRVC5nAvlyM1xhUKQWmKjWg4lwR?=
 =?us-ascii?Q?eE/s6bPSjAG6zxmJLUd87RCBWt9p6ezP5ie3DYEvz1seknYX6fBfuM0suPP1?=
 =?us-ascii?Q?+4GOKQdrgRNGGkqfMAfhoZLXrHSCTrJNPH+B7a2aJMBqw46NY9DUI3F4sX04?=
 =?us-ascii?Q?TXX2MA5OPhEuLV+czoe59nGCCNjiashRgn9fhgNf/jsqwUPrR9D98iLrFx6R?=
 =?us-ascii?Q?WQs76YCVQj1JYnQuWV/mQP5zcJc/USNTLCqEFp7z5Aj1r/kyD9dA//9lhiKQ?=
 =?us-ascii?Q?gSwkv+IqsMgYjECIDbdsUyGFYXlXX0uOMpBZsVj3ouixp/OWajIjk8+7CjYi?=
 =?us-ascii?Q?y81imhG56DVD+uxFPEvD5Pl1SDMAIgsbOmyR7h+2RDaiZZ0FEAanhgmGCOQl?=
 =?us-ascii?Q?erUEy+Yt5XKcIxOlEk9l/teFfuxgb6EA2KYW3h59HAHoiv2Yhfm7WmNW5PV0?=
 =?us-ascii?Q?cYxErlhjAjQqeI55wGhNJ8qUQ/0tAzM9cHblmKNFqqPJNs/qRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8BQkBlukoqCH/e+S3T36mknh0O0VXaaAFzW1totJpFGZYzcCrZ5nAReNVOH?=
 =?us-ascii?Q?GXEn7iDuE8+q2OAjYhHd7ChLw1wAOdVFzWGaGie7gyKanI0BC4ovqWljpDMW?=
 =?us-ascii?Q?vq/WePEyNQW/KgT9IRadQ9DDRCL9fVXAN2QtynhRXMtAUnGmB1HbALKb85gV?=
 =?us-ascii?Q?pZUn/Py8jQi+32QvwNEFIBFLub6qtmNQeOvsMMjOMINYM1pY9mRVqd7YcI7X?=
 =?us-ascii?Q?sGPPEtQZV4yVY4fB3gjZBJYWhgnHbLI0wzDQZdbwp5Ud9s1c2wS+3UvUPH+7?=
 =?us-ascii?Q?fD5dHgOjV+tjkqF582lIdNEVIoFJ88wNB7AjhM0kCnfzXr89WFcGkSol/4Q6?=
 =?us-ascii?Q?Z5+O1OSXoErHJO6hkgLtD9B7LUGUVBu4MVu3Xu1ptpoIo8DojOgfeFki+LfT?=
 =?us-ascii?Q?o322KbgzNLV6fUVjhQLg4CDt8Y9j63kfMD1zRLiRUSmC1/RARgbKP6rzlXm/?=
 =?us-ascii?Q?r3QbWo1nKzE8gm8ke/ItNiZzJahlsXMskNNyblTis3/l5vK5v5C1fJlD0LAH?=
 =?us-ascii?Q?qoLGs8mPZvAUz6SOtLQk4Zs0qD21ka8XrriIUDiDzKBJomH5ZIqc7ojyiDAq?=
 =?us-ascii?Q?QzywS6GkN8vL9Tb7GN/epGDMfk540r5g6XxHNtQalwV2gHsw2/3J2Eh2WZbb?=
 =?us-ascii?Q?ege3E6Q8WZ1t74umlrEktts3M+2CHCnJW14tNSrqJ2sh3FQGRscbsiDtpzhB?=
 =?us-ascii?Q?MgUEyVNeoAyqf/SmGEnaBVkiJ/idHuZ+PtsOx2smyNwk3QpMvZLfIuocHhmq?=
 =?us-ascii?Q?V4qQH2Y+kzOY/tagm0jMhwfniQu37IB4jUDyhHtIerLF9jPeRDIyM8+K3lyg?=
 =?us-ascii?Q?qwQRFCz6emv7ElSIJd65r9UGdr4Zi2sdSbC8dCTS71GuQnTiFKGHdS61Uzi/?=
 =?us-ascii?Q?MuIFZWNGcm0WcAmr9NdYziY552BvVauCY6M4mgfJL1gE0KZ5237wvDEG8XVa?=
 =?us-ascii?Q?4ayjoc8vtL+edmHKy6unlYAYYyuIcv1oPim9kIETEqEWAbw06eUk4z/fPR+G?=
 =?us-ascii?Q?s+ugeor132V0Z6cCOZE8szBJpw8BnFveuqv21Z+uGXNf93FpmWXuuUNAQqwi?=
 =?us-ascii?Q?C24in6UTYiJB+xy6VEL/BTZZHnsJ9pX/8gMmt3jH0DqdmfB553fhfegLhJst?=
 =?us-ascii?Q?4ad4i7MKmbwxh11ZFnSMm5hSWvdF4T6tFjiSCtbQ7BjqtOGKPhVAGgpZmGZ9?=
 =?us-ascii?Q?kKgW553UXSKZMenzrLJpjLCBME5499G7fr+nfDtEBL1GruOwkPNiNYHQWEud?=
 =?us-ascii?Q?kDp89eAhEQn3zSzmhQcEaKk0olY47KnThlXLQEbDadNBTgrrHiNSAY6kHv4v?=
 =?us-ascii?Q?PLHb3LZjJc1c+ZLanSWR98IU7RhGaAFm47HAi9mxyREpB9TVZMLomHgIZzoE?=
 =?us-ascii?Q?s5Lhx/nfbNKv5PcQBiSGkSB4zoTqpL6tI7lfkU+I3xAL+bXh3LGkKi4Q/OVE?=
 =?us-ascii?Q?lsAPy3ySWQcqd+Y+lunfIKeENg4sA5c7cKCbeSzP9jv7f4RsmnJBvsMHUBD+?=
 =?us-ascii?Q?4/ovyiCozLhnmzcsGnzlf339ixYF5L76i2eAa/pkwItgbUdJwFhRMJOzLxkN?=
 =?us-ascii?Q?CDkRjcZsFGdnazKl2bl1+K8sJ82UijtyYFkRzVNYx6JORqQnLJdiFx6GrssM?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eUIVYLCkBrLjO79PyYX4SSUtI7bR4cLwEcRLrQEhdeRuHBgBvjCFkO2uMu/xcfoMRkPk5wDBWa2CnQLKnFsDlX8kV5ImY90oX0OOo40QWCggUygdBbQWKO7JX4KoD/Ck2b9sN74k86kjsOqG/GuICUAUso5UCrXVWJF8pTHOlT+I0VXVHCcpkFtJIhBzJkxGWDfreS3FdU7GGJmYIKAWX25KS7qFv+hj1e6is756SGJ+JDXjK0qcFXx6Fc/r/Hhw3YFSE0SuvCMG4pfgniFSNphFbHfLn2ZfAr1mmFmAtVJq1Xk82Z3tohFUz4eR0yYVFK65iBsEj8fF4w2dPl52svewFinrUTz10Dp1Uum4i2FksOqWSDZEVzttECm1TXqiI/Y+F8IHedmj1RZYhUjS+sG6rUDRBNHQhcuH20apx5oqm2EHS+tgwXirulxIZOVdPEzu5f4PPCkLwPBAPNx/u8gtI7efw09lJkvaQQ9xx2b6kvepFIuWP6aaqHB0jlBZcANfb0RivFCimYzkgamJ652QCaZjNdmaxsp0VgzUScILjmV8J/yQPh7xyGGUJcwYr2affoEQeN89IsoH6k91kbMbm4t5YTnxsEUJrqHhmXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f6bb67-1ea3-4cab-53e4-08ddc5494a5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:47:52.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxuJoH6s0DP50F+GQft0AU1I1ALP6r7V6aNYZDXIrjWblEV0VSt2CV5X3T1+7d1kR+Sz7XRryOLjGo67sIpjfryNOWaVzf0FiWxvEAp2MDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170138
X-Proofpoint-ORIG-GUID: t4f_6z4iuSlPr3tOofjAcfFm4EIB36jd
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68791b2f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_wMdCcLpPzeP5_yWaxYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: t4f_6z4iuSlPr3tOofjAcfFm4EIB36jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOSBTYWx0ZWRfXyEmeFZ1AKt7X G2myb+N7yU/V9EnrArddMH0MYr/7psLYGLEyY+tRpdyW9ebqzGgdrBBgTyTCrgsSkoFsI1tpgAP 1bj93Ps9AoAXCQqL0C90PYNrwWK2lceS8IjbQzXPNVQzJRcytKsDzLhiNOIWe2BwJCBA9arOSdf
 wayIk4oFLmShC/LA3QS0nsM2imzaQ+lUv8daXWfKjKP7p5jyXr1XDp1ErCpVk4+tXfyzRRDh+OY UTSu4ZpvqtnRpNuVbEkrppKTbMzHHfQy8a7+iMGMGWdKPOYpjKgK10cF0VdUQPpd+wnJUJONK37 9uKI/1igdUZZ0dXyxa0iBxoq9attT9iq3TZ41TlFq607TC08n+3qfh3kE9KzXvwnKPxI5DIPAXr
 n+V4N5yNSg2Ysd1iqnnkZKv0oM838znPkYtgPJYNL+iAG20eN8/63PbCWhVQySWf2x6sY2I8

On Thu, Jul 17, 2025 at 01:52:06PM +0200, David Hildenbrand wrote:
> Just like we do for vmf_insert_page_mkwrite() -> ... ->
> insert_page_into_pte_locked() with the shared zeropage, support the
> huge zero folio in vmf_insert_folio_pmd().
>
> When (un)mapping the huge zero folio in page tables, we neither
> adjust the refcount nor the mapcount, just like for the shared zeropage.
>
> For now, the huge zero folio is not marked as special yet, although
> vm_normal_page_pmd() really wants to treat it as special. We'll change
> that next.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 849feacaf8064..db08c37b87077 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1429,9 +1429,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (fop.is_folio) {
>  		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
>
> -		folio_get(fop.folio);
> -		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
> -		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> +		if (!is_huge_zero_folio(fop.folio)) {
> +			folio_get(fop.folio);
> +			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
> +			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> +		}
>  	} else {
>  		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
>  		entry = pmd_mkspecial(entry);
> --
> 2.50.1
>

