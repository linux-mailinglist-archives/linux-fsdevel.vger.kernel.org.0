Return-Path: <linux-fsdevel+bounces-48954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B09AB6755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E54A1B64879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47B22D4E6;
	Wed, 14 May 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CeG+vUy/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDsehtp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563F226D18;
	Wed, 14 May 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214487; cv=fail; b=tRD9LEiPNShew2X8ig+bp/u4+/sox+lAkK/pF6RWYRoGap/NUJwpynMeKmsd646MblJAnYdXstUZ0P4sThuWgm6pHHPvLu9b9aXrW6oBfdM5ryBmJL8HkHlpmUyyAKoeqqxgyF67Q4ZZKApV2C3PovpvUSO3ieccpEVzIB6jwS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214487; c=relaxed/simple;
	bh=+RXlvFn1nFnMR6i+f+Do8ucyFBqGdoeFVeLudOMQldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGq4QXzRE3aPBoqkxR2lyqitCQMcoRMCpv2iCaiwQXntkQwySzCTeDerLu7u9IvwC084Rlk/sb2dgHLJXYduzZ0J4aSCMZ7Zzmrw9tro4C7ekJ439HcEfaBZxCgaEa4JDZqDLx5V/YsNFtWXTYzzTby//QzIxSzVDmlCtZPwSTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CeG+vUy/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDsehtp7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fvG8008008;
	Wed, 14 May 2025 09:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+RXlvFn1nFnMR6i+f+
	Do8ucyFBqGdoeFVeLudOMQldk=; b=CeG+vUy/9bWRnJuRO7kEm5kDHGFx0/Vwu1
	dpaZxCf0G9Y62yJCDbybiiaW4LsUJnrzSahNhlzNAY735H2TosBoNXcKwCID2uLT
	hq4/V+GTZ8EAkBQsbr63tKkWfEkA6L/P4aDvEskTVrt8FST3CrzAJqJnsm28k5KN
	7LSjaevYVuAEuUr2pX35DgGCFOR0QOS3rEFDM5lxbwDOkk0S/kYU+DXyFqFqp5k0
	nHP0UvQYAlGoFCpn/RbFgWoOWWVUqDmwz8wjil98dz9c7A2ipUhOW6dYeaCBvVKL
	8Apxbiq1sjIdZ3YxBGo5Ht+MeZWTzhVzyQAoBiRkDlQBvuvzen7Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcrh4pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:21:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7U2sI016326;
	Wed, 14 May 2025 09:21:07 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc3364uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BheUoKE9SkC9QTkKvigP4wGRhIk+6h5ESMwZNOXDMws9yI2syjmCjnBT4catbDu+FUYR0BEutyCSymxA5/QiBz6ylvANah7RlL6ynHE7H0uclDrIUpPLUrqCHrjb63lxpoiiN67rc+pPZ138hQeHhp9nEOp26CldFkQ0H+pr86qIR0oVTyqyhltM67MEAhpOOQi+dUQEPqH9xaWUXvXwAHVAYfYwG3g8hyhw5X+Bnf876NmLXgsBAQjazr1xgo0aQa2Ei+yN7xNYkR17GQldsXAdAUFoWuHtnUV1QyXfxMA+p/mU5Va3D/TqmRw1cOq5f0SFoiRgkbGPnFmgbrEU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RXlvFn1nFnMR6i+f+Do8ucyFBqGdoeFVeLudOMQldk=;
 b=E/OgSAb6MYHgbyvOyzXQMBAgYmHcXgmOSXNzueXEIhgy1YFsPIfvarOpawY7SpcSojMd6p5NrKe58IeTJE/z31NXtZI2V7iGDVKD5sWP4JSiCt7bfG1fI9nckO0I8SvbhZ2ySVjb5wkg29m31DEGwMbg80VhNzDxOhESbfnlMK4CbHjCPGHKuxPNuRqFVux0BEvzSpEvwXESTojRJmgCPucPMnPvPoJDoEt8BF7EctxMLV5WB30HTEQXuZ4lzL9hl+J5GrCJxJVRVbhKgx+GOmoAXFOMs5OHqUaAJ9Ga1z28GYE767kyNDCAGiHAE7BwIVMNH6YxloDbBYLfY1o3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RXlvFn1nFnMR6i+f+Do8ucyFBqGdoeFVeLudOMQldk=;
 b=DDsehtp7ImX6SNYT3sxMGbvCO4117iZhJ8jGjnHGCp28nTBKXAEtH2fTubr4a6FJtk4Wb3ruH+6ejWix0Sfi2jJlS3P5Kxu1h8PAb8Gq8azh9Ml9BJ3KkNL0fCDCI5xCmtDeyJIsbnu+ZeDswU06TnyC686+QH4dMeSRTO39mPM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 09:21:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 09:21:04 +0000
Date: Wed, 14 May 2025 10:21:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Message-ID: <b346ce3e-3fe8-47cd-bd30-81f9e513a2d7@lucifer.local>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
 <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
 <8e13926d-b685-4802-a207-ade2001cb657@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e13926d-b685-4802-a207-ade2001cb657@suse.cz>
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3437c066-6da7-4dad-95e7-08dd92c8a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/HyJdTok28HXgbFW9E1OyWJ0fXGH6Gp2khaWp6oDoy38zMHKdbQiO1M1kB6?=
 =?us-ascii?Q?kUkbEDnOAc5CviU5lwTXM7Voea/ehbUa70Zq0/w2wrbK/Vohn51yXge08jEj?=
 =?us-ascii?Q?dBZGsMDewUBBVCpaGQKnFSMIpEiOWSvluDSOAEUFxRqCoG3uvNCmjTf4KciM?=
 =?us-ascii?Q?vQvaPQwwVn6VPJZlvEbNWg8/6k82s2RRBs4u/LCd/RqC1fAd1nclQ8rhV1rm?=
 =?us-ascii?Q?tEoJ8KMCEy0uOOrAn3F+0FIu0Ps+aYiTrUumXan2QOhVr0TY80v32kydEtTu?=
 =?us-ascii?Q?UGD+k6QhuuZmqijdg2yE6i7PM+VJ/+4vdmdKHnwqUVotBvGi5NesnNj7mMNs?=
 =?us-ascii?Q?262ooq3M5TQpGAuEv5A5tAr2rRWUkCknJLBkCPkRnGlP1zWL6UYMqBeIXpb9?=
 =?us-ascii?Q?u57Ox4K3XtEi2AMIQWeNbwmTuXuFRyLLz+GZTKqmqAKeMRvfdbEh86lcF3fU?=
 =?us-ascii?Q?wYqy+5JNacH3muoFByGhNZzzvV+YGomlo3U0S8NoQzczwVPPR+/XBCyn0//d?=
 =?us-ascii?Q?AbRf1rB9tG299urL8Jvuyj7k1vKqR2Spo4JgOR/xokHIsFEYV7Zxbeheos9C?=
 =?us-ascii?Q?xdbq8JV7Hd6eTp3okJcDRwUgF7rKtmDQ8BJdEnnWmU3mGfy5uX2qKctlfasy?=
 =?us-ascii?Q?R0D13rZKojDqskjwOBDELKee5z7aV2qk6rFbAN0w5MB9eFYYsg4dvFfdS1CT?=
 =?us-ascii?Q?1WqssHXsYtHLFzIvSXSVmm6TnIOJMxW7k6ewfI4H2kpKBtFH4XHt9cCVhnKY?=
 =?us-ascii?Q?PRcM+iEgJB2zNQK+ewAlKFWbzwMdOhqp3MvI2qtU0VUFjHSZ19By6mtI2RKc?=
 =?us-ascii?Q?AnF59TSE/yyZMefvDi1K2Td5FrXlZdy/ZnHMepaQzWD+pLNcHALa2+goyX7f?=
 =?us-ascii?Q?4JKhwPMjaw42Rad07llbDfC+kD2aGZBn4aNXcOR9V4+1CBpISmVHfAIDON6q?=
 =?us-ascii?Q?HzX0Uc4EhTWyFUQSlF3xBXkC/gK7i5I8MTSVF0N8h4fr4XkCvRCRNwZwkFp2?=
 =?us-ascii?Q?TNMpHN8yR+2E4qi8OxP9crh0ZuEcBZW83F9JUiWQVC2F2flwKqeSW0PCWcob?=
 =?us-ascii?Q?3sh5xYsnbHqll3zWZFxD6ME/KseMMn+bV6Lf6A/PAtl2MJvJeGNkWobxRGw1?=
 =?us-ascii?Q?mNkWPSfMRR/xzu5UpqhcSmeVREk3AO+BPAbY3gDfMXgYNwmg3hvYtHUoYI7E?=
 =?us-ascii?Q?76h9D8Tl5Jb89tB+MuPiHnQt6ii8PUfA0YDN5UYsxUl0TWoOBtVxnmkG/mOp?=
 =?us-ascii?Q?9EAGSKSkYlB+M8nfdrldFo6hd3sAVaWDxxW8HcPam+AGyw1wo7mqkjBf76In?=
 =?us-ascii?Q?GU68QVxkRzTOwsKjcPReXJTFyTUSXqhcZc9lOWQ5tlcHsYpq23DMgqmGC5Wp?=
 =?us-ascii?Q?/JjUUTa7QgWpr4P6oMC8RVneCAUB+FZJY/woX6FHRzLO1XotS6iUMrQYPsQh?=
 =?us-ascii?Q?6CfNRky9wXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2m2QVmpgBl6z1yHTRXmVenBRz+DloJvHsH7FIw+xckR4RYgza2kW6m18bI+?=
 =?us-ascii?Q?cSXiULN6F4yVKBQr1eDx1n7DN3S6MCv0kfi2V8xdbAo6ccalKxk9sdc/NXgZ?=
 =?us-ascii?Q?ZAt91c6hHqWom0BDMJKe77KGgTaAUSAP70S3WLdzm95TUuSEpGjUb6J5Rmnz?=
 =?us-ascii?Q?jdtbUJq3vwlINfRLwOLaYs0UHHrXjlKqHDkm7v+50zk80l6IYQy93ndtERJK?=
 =?us-ascii?Q?3BO872DYL2Pwt3vwRxJPMm06B9yRF9aeHuAOt7HbC2fg5nzLHwQ1iGHZGAa3?=
 =?us-ascii?Q?rQBHcmZ2POA0/N0mtWI59XCHgdqwOMHxQnQRHJGF2qx+m4NywNUbB0nEXlBP?=
 =?us-ascii?Q?jOpwsuJCtFyMM2JKTLOAFAdlBJ1bJCJsmYbsLWKFlTMTYRMfc2SU73BfDo79?=
 =?us-ascii?Q?F+NCwdvSmYBkEWXnUIeT76YwKjibpbdniTwy9XSE9K/3H+fWpEwSixzsUbi1?=
 =?us-ascii?Q?PM+Etdjc6ryqSgo1YUMDNF/uXmqNrKI1/MQBQThhxpKyJGIs4+x/dGbplvrl?=
 =?us-ascii?Q?ESL/EWFSMBrRz5aPRcjtHN0HyQUW0Ql+bDz5ntpJP2XDTssOCTt3AVe1EZ1W?=
 =?us-ascii?Q?D0coWnADrSa1PU1a4EDxOx97lH8TCpbY5IT7lVQu+6rMrY/BEXtYqKnJMdKV?=
 =?us-ascii?Q?WVlI5N9gYIpT+lY4RxNyiik8fTVpSrrbcfJvVYCVANV0BaS2U5YDou9yzgZS?=
 =?us-ascii?Q?G6n4kkPnjVqIIPUfxm7SSgaXsUrKKQIE9M9wHOZ0XZ6sk3ZDnWxq3IZpb95Q?=
 =?us-ascii?Q?wE//ji4f6Bdht4vpzEkFHgH+ueCuj1mNz5NUGcjrzYiuGer1z1oxKb55lYNK?=
 =?us-ascii?Q?aQ0erQmM/NDC3u93gYI0+VCev28kcFS1QHQ01kRYzNsYqXmXFmL5Aq2zC3Z7?=
 =?us-ascii?Q?HA0HDuTYYHMuNibT9Ta9O8jqusNy2k7kX8OdooMFI2SuDwJ6fgkYs8j4nt+Y?=
 =?us-ascii?Q?MBQKCdKUqNyuQVnZB06caI5F74wt8hzZXOdP40dzHyRMuSa8fD3CSp7e78aW?=
 =?us-ascii?Q?RXV06+4Jc5mhDg0Ns4LO2u8DDGaeRXtnIrNA30Te+BJEvVqAVZN0KQcmLQ6/?=
 =?us-ascii?Q?fM4Kq+uMY3S88fBQpBpBOv5w7/63uL8Cs5I/WB4xKlNVtj/843Mcw8+OEe8r?=
 =?us-ascii?Q?XQjEttRWevQv1viku2GakwziOLUZT6ixePn3ngMMnGwEkmfh7dxaChq+HgVu?=
 =?us-ascii?Q?aTApHIP0BZRARR9iy+O2F3ajYOKywyjYb684/b8y6rG347KBnx+c7L1JLI43?=
 =?us-ascii?Q?HEXniU6u/BG5jozgswAyY2zTrYjyakWbG89Jx8NKfvGGvvFKg/1B53u/4o3t?=
 =?us-ascii?Q?T7cpkWIsqrdR8CulUUToIA+m+aLWU3lGnFTFqrF7FHJlVKR4dsjJv25qnWtv?=
 =?us-ascii?Q?f2El/FZrZFD4OEnrIa/rdlTQrL3psvSqbzwRHfRGTorIjtGUasWxzpnGhkLW?=
 =?us-ascii?Q?PbI3QP6kzxIrCQibiNydllaiXs5SUbvKT9FHPRwOHlHFQYwQKzabmqQaVbUv?=
 =?us-ascii?Q?j1WLQQxRIuHI1XquUr9jxgOoKDMDwUuMDmN834li99KSPuHS3B9Q900iNSoA?=
 =?us-ascii?Q?DkYVsP8pKpsZM9seph9GCwmDUM9D/I9OY4pyLvQ1asbZr8ygN6X7tyEZTnO4?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	shy8PG8wWt+U5RHW1TYm5K5HylE2O512IqKdH1kROaeJ5VrsQ8Mlw27NPIckM5N+L4TtoRq4Hgczjd8XIvqyFwedXMF6+z/FcwvcpGQtd5ce/s0/jO87p1zIR97+7JHvNwwO0+IwK97jNycmkHrCsyLkZYsZfQ01XsHN7weKrmHHu/vYatfkxVTHi4q9ORxTT3JzKFd8eBHLuWxjWe4Uzm+40q4cqzPNzCBOfVDM39xInk63Lxem7pKgeHGIaep6RJ+kgQJtJE5p8zykZ5MeZ2pliCJxUEFz5DYbZAG6A8e+FfmkOJBqseULrpumlWeZLNuip8kPKB+AovF8LsEvR8nQO6T/bQkGTB9IQ80Q/xpEMyqoA/j+mNcNw5mj1/jXL3vb3TyhduUZnF+tVomhQtGTltSp9sosubx8Kb4J7Tz36BqGZSA3WbMXV7mzn67VmNis3TVYKRwD/kKGbYVN6s5VHaTVbY/MWMIWhp7848OYYCcMZ9Qx9VQj6Tp/GOHquf3eMxGAquLhwD2C0HJv9FDbKtuatAXB91Mj59uDM6VxKjnzzO3VrLVpxNcV3pUTylNkn/Hlb8O8PQqQtVkxd1Q759s7YgvVCnFrT/lFEb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3437c066-6da7-4dad-95e7-08dd92c8a6d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:21:04.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft0KlrLCRf5XWYgFlBi48uyTNXnJxwzUn04g4pVDZgcqSDPR4W1V5AyaGmjM+17W32imoU0XQOcGdrseQ9ES4i6EF2oF5LkdqTls+Hz4BLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4MSBTYWx0ZWRfXzIjZtudQlAbV 6X4OW/CiuyKTjRbF8MEXVA/YsylfaB5Zwm3qebH81qdNl+lRrdNo7qoNRfp0X2+WKwIa1cLv/cG 1EgXHIet1zsX09ZVWLrugZTpe+W9NAEcpaAVHtBe4rJkXgwxOmD5WpyduZTQOjjXOueJz0IKxQb
 qAfr7VJdKkoG3geXP//8rp80RaoqS1heTMcGOo6nR65O/KPIcD+UcuZvm2RD2SpImAlpQFZBDyg kFlg9rGLejHRq+041NLdukJlQxm7PbQhtX0toFSSzfJ29/6vRVF9k1QxeD6DpdnLQPBSJDhuZDc y/oQDHt36ktGSWhpmTmJSPfJN8eTd9PHBRYFaP4XRaLmO7DxL+sBvszZ3327j8SMoT83xB4jYmE
 JKI+bZC2H3MOHxrqRSJc29ZXNWPruadro/O3h+iDKhwgjljWfMvi3MX2FxnKxhBS8EZ2jxcP
X-Proofpoint-GUID: gXUM_g4cblIl8gAJtWYcu5hAc0Lx5CdD
X-Proofpoint-ORIG-GUID: gXUM_g4cblIl8gAJtWYcu5hAc0Lx5CdD
X-Authority-Analysis: v=2.4 cv=cuWbk04i c=1 sm=1 tr=0 ts=68246084 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=Rj_o4CXKQeo_DGY_KlMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13186

On Wed, May 14, 2025 at 11:13:27AM +0200, Vlastimil Babka wrote:
> On 5/14/25 10:56, Lorenzo Stoakes wrote:
> >> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
>
> Ah yeah I missed there wasn't one.
>
> > Is it worth having a fixes tag for something not upstream? This is why I
> > excluded that. I feel like it's maybe more misleading when the commit hashes are
> > ephemeral in a certain branch?
>
> Yeah it can be useful, in case the fixed commit gets backported somewhere,
> tools can warn that there's a follow up fix. As mm-stable hashes should not
> be ephemeral, then this should remain valid (and if there's a rebase for
> some reason then the fix could be squashed).

Yeah the mm-stable hashes not being ephemeral was the bit of information I
was missing, I would have added this tag otherwise!

One day I'll get the hang of this mm stuff... :P

>
> >>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks!
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
>
>

