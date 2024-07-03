Return-Path: <linux-fsdevel+bounces-23014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7A92585A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674EA1F2413A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5D158DB8;
	Wed,  3 Jul 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpiQrkJ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0DnazZAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF913C9AE;
	Wed,  3 Jul 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002166; cv=fail; b=Ic1iUklPLH0wMvhQ//UYBKV8s0zb5CsaXVd5BF7m+eRmGJXavfhbHUIlAumsZzn2AD+MbuczUbWCaw0Lt1O15vrabrYo6nLbi0VA/TOYi6s0C+eivr5KdnTtHcHg0+cIn4lSe8nv2fznVm5yhlIn1HV1ZRFkp+ZV56Qv0REUO3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002166; c=relaxed/simple;
	bh=/DFBAmCmi2ItOl5undpeKK9uluJjAj9kma7YlE00rfA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxFAtj/+mXJ6rFxXUQH9FegIcqseaHewpieRxv106Wgc99XAJJkhHRHzJytbQ0q3sLLr/e987xWCQj+2Y4yv+KZ371HBRbG2jjaqRG3Vm8nIudE1JqQzUgIIfTh6kPQ3HYm5yUzbCAZOmPr516nL8Z4FIhfLgtrtDzOA/wcOvL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpiQrkJ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0DnazZAI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OWip030316;
	Wed, 3 Jul 2024 10:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=MTTYmYVZHuKm+X0
	i1FRbHLBPYAU6CrUsS6DJZ81saYo=; b=HpiQrkJ7CIRtYvIKlKskXInkJ8f+viJ
	uh8xX7bN3gNTv727KXvcYTxmtPuQxlRJ5LHyvbRO6nKdHXNJuxZQlzJrVd3xtcnJ
	5Gwe1EWIy7M0wyRpxPiD99zPpZSXH8pBSNuuSmUzg5gQ5BCcSLMyfBfVoyBMMpmo
	vFoHU+TAD4mEWp/pw0NSzEYEvru1VpJ+qiTpBbfxdzlkjO1MmkEplCPSZZxqurT4
	9ePtiEGGkRbFxsBzLKlRVvtJeFk8QI3d8yxZ8etiCaZNkmxbpD4GLAIUo/e1x4hv
	fFHt4bNdR6qCcqus4tHk50UgwS4hNBAoOJyN08/Fm2vOK/BHFIS/bzw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296ayvn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:22:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4638eB4Q023488;
	Wed, 3 Jul 2024 10:22:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0yxrxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hljG0bJ6hsPrJ3bwjLOSo3f0onC465Wt/XCHFJzS5unkpSSkL4DAF9kk/a8YwXGXPegRduW82OuX8hwpIyEbV4P8DFzJ0tO/sqAScfDm8PqwOwheOWuvEX7D4M4LfbxML3VQ6xBEPFB1EJaN9LYcs0+BworOjdbtilb8tbru+RoFSAeRIZM+iADLZP7SSrTrJS5nhxCgwf9lFsJTPlHyKHhyKWkapmj0J5dGsVBkKD6D607dTcspjkIlTOxMd2IMTr3QaC5/S6MhF7oImJDU4gLREb8pUPuj8+uxprobaIgKA8pb7H+cE0nKawD4vBAEfO8vVxFA8vMk6mRCnyidSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTTYmYVZHuKm+X0i1FRbHLBPYAU6CrUsS6DJZ81saYo=;
 b=UcqHz+l0Xda5SI5DIHYJIMNdLUUjr2VAsLqg/1lK01p4Xi9Rm8BVrmC1+unT7YrR1sKDiNUjIcN472RDSBOzunjKiqQaKVDPgA0YDPyE0bo6ozv3FWDtAso0PLysrq9Mk2cjN5uT89tpRlBZa+GiyoJjYtw/H9D2jX5UYg33lJEr3EDUoFbnji4COLSzaucIkfz3g559hp9OWEFFh4huZq8d8GAoPSpbiKaQak+BYXxFcuM0hX7LDyU6a5OCm/rhqV4oruW6oyETHSMeGLZYGTrXCF6FzwzIZpzZIp9yZg/g+kb9CRcQqgO5Im5GanXBRD1xC+POlQpTxsBaeA619g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTTYmYVZHuKm+X0i1FRbHLBPYAU6CrUsS6DJZ81saYo=;
 b=0DnazZAIMETsU/KpAMABd+eYIqVNUJSmWeXubI43hCfeWw0AXYKKIVtayYUaMihcfDlYACrzqiFgD7iDreFq0PCwYae0Bz70+WR8g8dPhw+6W3NvuwU9JF7wMJPGILsgdWF+xaB+t0z0NayG4uBhqffPHJjYNJrH769EEKJ15E4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 10:22:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 10:22:25 +0000
Date: Wed, 3 Jul 2024 11:22:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 4/7] mm: move internal core VMA manipulation
 functions to own file
Message-ID: <86fa5aa6-151c-45e3-ab8d-a268f7c090f8@lucifer.local>
References: <cover.1719584707.git.lstoakes@gmail.com>
 <4fd37092b65caf30187c29399c2cc320a8126a66.1719584707.git.lstoakes@gmail.com>
 <o3c66lbg2c43wtut6hyoruggdp65jdb22gtyn6scnycluevqs3@f2rzgmqlri2w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o3c66lbg2c43wtut6hyoruggdp65jdb22gtyn6scnycluevqs3@f2rzgmqlri2w>
X-ClientProxiedBy: LO4P123CA0399.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2771b4ae-e769-4ef1-d290-08dc9b4a0894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+K9dn8y9vF4LZTHIN4R1GIGhWH4vjA38epvMGjXpur2cBymtV6VcM+c6TqBP?=
 =?us-ascii?Q?fvYg17/PO1CdGTPENWI5Jz5p6hLcY4CJYHRsP7Tm5eJtyw/YOJZjLJayXoAi?=
 =?us-ascii?Q?p6yxYW1MnrJL3Kmeu50chEbNZcUoE95ZZIAm9+4clwU+FTeXzROEK32Jc8CO?=
 =?us-ascii?Q?dhKFXTGYGepyLpuikHY7Ksu4nhCprC+3pLOTnjnsfR32S38pNBn0pcVToDdD?=
 =?us-ascii?Q?Tu0SWZ2lZ50bviqo4zd/0yhq1bEEJK8ljxFyJL62k5uiQyLENTh1em4l+r+Q?=
 =?us-ascii?Q?NYapJeH/pf+Mf4Az72k3ZYgFKwTkRZRo+ShzGeEQGPpYyM8kjCU4tu+r7B9B?=
 =?us-ascii?Q?R8/TzSdzgTKAfQq2AiX8BuJOxwJX4tB5TejBUQSW/TKC3VGMuoXAlgYHl5oe?=
 =?us-ascii?Q?Z3Mu2dk3kUdNRh5iqWcsdchMvOR+cltY6c3eyvJ6AjkA4CI9KjaOrxSr1HUn?=
 =?us-ascii?Q?0LVwwBUlqY1rgpUxrpq+fSty1b6TnwwGhC6g+0c9zkuDAe3FTkiXqdGcSbDN?=
 =?us-ascii?Q?G8YdJ87TnQi5RDeorzxpuB8EDDT0JvglYDS6U2Bm/xphN1WriieyTi3hactS?=
 =?us-ascii?Q?z39LO3X6K9zmu7y/FYiAboUpSNYY1BCye+4jMFA8WZRgfPBw+UhWdU7dRvrU?=
 =?us-ascii?Q?bySajPWQBQC811ONYRfZHcSuSE67vGEy/Bzv6afvXeK++Sy/lnxlXwl3KXRD?=
 =?us-ascii?Q?8C/6Qy7BxVWmT43K9nLyOkHKDMt5QpD2XWFqpxfzvD7QnE8RmokIyleRhcWq?=
 =?us-ascii?Q?Kavrhn5OTzjmxQn1edlLe3VUbcnlJPOgiJ9R/eizGJzTISzBaP5ltxxigHzo?=
 =?us-ascii?Q?PmveUHwEAfav7AJt408MXNBTS+z5ga2k/wMnI+uELQmuhiuvdeS5ktcdW3UB?=
 =?us-ascii?Q?/enWjyDA7fl/Hf3fNLx0a4eMZlrfFIGwdHYsbyJAG1ewOBskfOFRrwiE+9Qj?=
 =?us-ascii?Q?zx0kEHw+Ty6QINJ9LgTzIseAzEmpXf54uPgUcYb1YrRFV34a6zPkgmZPmxvk?=
 =?us-ascii?Q?Hm8vC30itIKKtvehx33MwByhqSRymh+mwFhkMOOb6DTFo+ew8fBXHzB908Yt?=
 =?us-ascii?Q?qvfY2UKY35q82GhehBfn04FdhZt+Claib42PKQRK9VBQleJCMPo8jF09Trd2?=
 =?us-ascii?Q?zr8XD1VKzl8a4h+AFkfkulOcs83+jhv1wGRFWeAa0i4i4Z/M5DjjBazC6dOH?=
 =?us-ascii?Q?F01NoYuaznS7/TyB076fdMeyjea3ANhO5XoNvFGW0AxqUkuZcq1PpUjhD9h3?=
 =?us-ascii?Q?SEZhPmG6oZQClvMdip7pcFM+Z2xSp2DXOsYmsE5t3A/gH07cmzWGtImfhWyn?=
 =?us-ascii?Q?o52v44la718sZv703EO/8vQFvhWv1SBYAPY0esk8meWJjV0SfUvYDhEoVFfB?=
 =?us-ascii?Q?TauL91wAR3f2HCij3lATCO84JkR3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DtfdPVv8O4wc9l3QrAWpoA5GXB9IfcNtYXB74Y+B0yDEM5UcCUckHTdOSO82?=
 =?us-ascii?Q?QxOkad5XdOndVUMqHtgawhHHq/Z5GuLmWeAS7jv2U9UbWNn8S1lIvvh3KeIA?=
 =?us-ascii?Q?tTKAj2n1eOu2jer7/y/YEFR4hV9dnEYCQmfgB9GTKC+HXcQ3SlQ8XAM99QXX?=
 =?us-ascii?Q?11uiFAKIXDIpdleDM05UuMeDJFCJBNyFoazeEcxUDZ7S16xq0QKArN0scvIH?=
 =?us-ascii?Q?RaotMi9kwJE2x12KgLSJxm5TR8q3vLxzUgpTgyAJV3Aino6bq3x6qvgNupJ9?=
 =?us-ascii?Q?vtZqKvPn6eVHguRSP/+oSmzogva1bLv8OqklbqybEaS9Frj7uT0lK106O7Wv?=
 =?us-ascii?Q?/qHEYsrD17rnaFRi2oghe1Byfy2CcMeYJVlKfqhDuab+OymUYytvrO9YwURg?=
 =?us-ascii?Q?m7EyTXbxOgU/1JBf4lNvUzy/uhgeehlXbpQMWva1JlfZ98PFSoXpQZlohDzO?=
 =?us-ascii?Q?TJhZNBTXze2sDs2MDxUMPx1FAtm6pWFgEaDRh4P1ISdcqgTs4rBtekSMdx4S?=
 =?us-ascii?Q?hbpxl0e72kcqdNG44MqLY1kiYUgF2BRkmGLSaMnebZFMviyNubVCGWPMApH8?=
 =?us-ascii?Q?z9wGo5eMLFR/t0YfsWw5SefwbGyPM6SEQHtPr4ZUmT3WtsMKkqo1KJvMgY87?=
 =?us-ascii?Q?MyFWKNsF5znTWeX0HQ8fXwuU/gZ48av7Ps0aQ272JB7kiQ/3qneXKKJWZHFI?=
 =?us-ascii?Q?NP+zU9tZ6qRAS5wZaN7Ap3Hv1+O6G4tWZDF7+fVRzChmJfMyv1adInSWzcoK?=
 =?us-ascii?Q?7zkINQubr051Pm1TELUnF7Uq2iY6PV00/R+GKwE6Ee2VniKg7+0hBjkefUia?=
 =?us-ascii?Q?YnQ5eA2rodX9dQBGXkUpvFo5VhFPc+merUO4QIGpwzuXxSu2iT5KaRBnD2xZ?=
 =?us-ascii?Q?orhw0MCID8odhn3fnB7gOdpAwDMmYAZAqUm+S5tdVDCW6uaBC3tJugKGifox?=
 =?us-ascii?Q?h5tkdjLcAB7GkqfsEEFQ+skqfJwy554OYoUeqS6H5AWMU3JB9/188+jy4kdt?=
 =?us-ascii?Q?Snel7g3OQtvzx6UIIY8adktW1gYqomn/yvIQl3oGe9KPDQM2KT2K+19tivEW?=
 =?us-ascii?Q?B6J0q4QFUTnd+8HMz3vJtGiCGL9NwFgG/fHo5xRwhjvmeTggGWtrP5WjAjfL?=
 =?us-ascii?Q?evjSmW3FyEUpbqeXSKTElW6Kv1LrrbjLT+TPvInKep/8ax32g2Mli72JlrHF?=
 =?us-ascii?Q?Wwdh1Z4zT0gsSp0C9diWeKY2nBatXkNTDXW9klP7/45Rb3qpxW8mhhyoCvz2?=
 =?us-ascii?Q?e6RJ007s8a8+gB4vcILFduXV5pPg2V56pBL/vzcKAsLnTaQVqUH9VwbgW1Mq?=
 =?us-ascii?Q?C948O9/9Q5Tpgt1jzguMAQ2niiPVQpcaB1VfI01bCF/PFZXTGzSJKcyKl1+I?=
 =?us-ascii?Q?IWpML72i1O0wORVQ4gPz2knmg+FIGg4x5LkseAyexig0S93wPVP56Rd1qGkS?=
 =?us-ascii?Q?mAlRpFSt87jBDejJfIoF+dndDO/PQX7HlboLTvk8qGiuvWUtLd5zVL93QU+8?=
 =?us-ascii?Q?jTeKT4hAM3ZQdJ762gaSjf2Nd+cNsWOg1eTLDarr/5y0srSCs3Wner1EG9U1?=
 =?us-ascii?Q?FLASgtv4R32uFcRgcrUWQUye9KSnruE48GbcatAumRfC6Hh2CSatzZZuyv76?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yoLVPp8X811Xy/+or4hcUwiCWbBEmZjYgCEOjieXiroAaKVtr27sHW0ALosslCb24v6lE0nRaSkByZI7XY4ja0y5IibpJJ+2DYnzoirGE08ptB10vScP8W08nKbmZqiimeGOZ3SArnzVY5DyUTTNqaxgjqR5KYLS14qTYRwRCLydIUMIW2C1H3wcYsoDbjYwUWQTEFPK9zPA3KOx2JjJqCC+F7YBwhA0nZWhqQzTIkQnoQ6wIHIRtCeD9v2zxk1ETmoEyyRP1lZkBgSf1/Ly460kSjOlG2InPXkLmD4g9gMwv4qzfN5KRTX4QY2I2Mp+ahxfimzcbRitQdVeA86Q4cuo70TRAk1QpWMRUAstVlVAqg6PKoWXaZnFhvjkYpoUXnDkPZEBQO1P0R4VP+WNoQ5u+KnjpgyIJTfKIO9x7EZqOhCE6MJpdvyvfu59F1UwJs3Jj/Jl6OCI1soigOnmORHGBOq4Syjz9aw7mDeQd0oQnqZPH/TgFmc8VlPyfAmPbcIHJth1c1bOZDRX/eiBQ4XG3hYP08YofpxB+QMJmX18TBZEcY34GF+dHhmT+DIaYwapf0XLpFkiumd5rQ22JRKRRWtmgBjMbMw7XgtySwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2771b4ae-e769-4ef1-d290-08dc9b4a0894
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:22:25.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYgr9HKjJbK8zPFwQIYnBu0Lwuhsq5hTZl16oXX5x43mTl6hfd/kNflLCN9gdnFsLbn49u3VNA/iFWc0ma+qZ+nLArtnbXja4OLfjvzGeRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030076
X-Proofpoint-GUID: wMcf3o4YSVdScTaRffBAFpMkGA2dx9FB
X-Proofpoint-ORIG-GUID: wMcf3o4YSVdScTaRffBAFpMkGA2dx9FB

On Tue, Jul 02, 2024 at 01:38:58PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240628 10:35]:
> > This patch introduces vma.c and moves internal core VMA manipulation
> > functions to this file from mmap.c.
> >
> > This allows us to isolate VMA functionality in a single place such that we
> > can create userspace testing code that invokes this functionality in an
> > environment where we can implement simple unit tests of core functionality.
> >
> > This patch ensures that core VMA functionality is explicitly marked as such
> > by its presence in mm/vma.h.
> >
> > It also places the header includes required by vma.c in vma_internal.h,
> > which is simply imported by vma.c. This makes the VMA functionality
> > testable, as userland testing code can simply stub out functionality
> > as required.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  include/linux/mm.h |   35 -
> >  mm/Makefile        |    2 +-
> >  mm/internal.h      |  236 +-----
> >  mm/mmap.c          | 1981 +++-----------------------------------------
> >  mm/mmu_notifier.c  |    2 +
> >  mm/vma.c           | 1766 +++++++++++++++++++++++++++++++++++++++
> >  mm/vma.h           |  362 ++++++++
> >  mm/vma_internal.h  |   52 ++
> >  8 files changed, 2293 insertions(+), 2143 deletions(-)
> >  create mode 100644 mm/vma.c
> >  create mode 100644 mm/vma.h
> >  create mode 100644 mm/vma_internal.h
> >
>
> ...
>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d2eebbed87b9..721870f380bf 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -57,6 +57,7 @@
> >  #include <trace/events/mmap.h>
> >
> >  #include "internal.h"
> > +#include "vma.h"
>
> This isn't needed as internal.h includes vma.h in this revision.

Ugh yeah thought I caught all of them but clearly not. Will fix!

>
> >
> >  #ifndef arch_mmap_check
> >  #define arch_mmap_check(addr, len, flags)	(0)
>
> ...
>
> Thanks,
> Liam

