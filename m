Return-Path: <linux-fsdevel+bounces-75598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJluFjTHeGmltAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:09:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEB955FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE853075186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497553358B9;
	Tue, 27 Jan 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="csr35rlc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ymJVVvM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6E286D64;
	Tue, 27 Jan 2026 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522858; cv=fail; b=Lfskp/Hg50TaXBn10BZ0OMt/ItC6xBH0O28abOphbCP3dlSVBbwaIoFwXDWvegm6tBtxnPsvDzqGFy6O3H/6Od0ScevRm9dM1ym+QOtN6rjspKQf+BZoFxrYoihYCZw/4jc6GlGV9qLYnXR9F3PAU5irUUY/uQIHNfuZaSocD/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522858; c=relaxed/simple;
	bh=P938v2KeaDW59VXLhLmqp+Pgz7qBVFvlF6MRVay+XyE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=g85CBwFArsCZcfFyrfGWs9VRrXgUul/ifTvIkaqYoliinmyQaeYk9h0uEwk7C++M7aer/jiQRE/Ml70QbwbM/62J4f631e7eXiW/1B90krduPsgABG90mmqJc6XNSxu8O0KfKCSw9EtQyz9Xt2woD3NCFNcRcd0YoKylV4Bh9Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=csr35rlc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ymJVVvM3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEQU24055942;
	Tue, 27 Jan 2026 14:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=T6AFte4jxMQh5400s6
	AgqDrzLgmjwAegaCCk57yFRoA=; b=csr35rlcKP1f8n9NTSc0FMaKEjNnAEcTth
	9kPi1GkTNWRbhu7k+IWcn2G1TTDKpONYEu5OQlNmhf+qYoCYNLSOF1cmi5IjSEt1
	CR6fg4ajKXEcTN56Saq4IvWdxsLjufEntS8uNWbUxRMqe3YecvNEhWa9Myd5Uwdf
	6BpA+9t4xSTjhvUL/zjVdiyy7QrIvRXEbik9vlvIc3uPo1mi3LZ9h0zTpXQlSO36
	SM8mpiJl1fzJS2s8iQvbuJhgGdZh0b1jGvXVgxE1pQaA9kPkDSBgVdELYREtQF2d
	mzvdpq7pGzi2G50hP848BaOv2yNh6yrpWo71D18rsU1k6/GcV9jg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsc1hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:07:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCKWaj001885;
	Tue, 27 Jan 2026 14:07:24 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhe01em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQP4TZva5ti9wi28Y4z0KpAqfFvzdGoozEB1SUbocMlSAmKGS5ncvaOgo6VN3at8zaHb46Uu6jxvqW52PQNefD84uYhgltFOMLgx3kSKdbkJOPZ3cWWxhDyBJS8lrpbvar1hAWrVKzZF5tu3598xyaa0fJpjXuyu8Xe6jdrL76NrBcWkK4KURKCTk8Q5xuTDhje9C21MCg+v+7oAJl49MyUhWYUb6tWpyDqqYUY9iWpHkdfKzHtZ3fn1zCQisBFnskIsv/DCfcvUOjN9iw0FfDs7S1r8IXV06cDNNW81Ex4aNGIHmhtd8j9Msd786/MvYwhCzumDVghNA7C2lFJgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6AFte4jxMQh5400s6AgqDrzLgmjwAegaCCk57yFRoA=;
 b=bGU8fjJXv1MLFvAl/8Zc2K0noCU1cSFODgyx/GT1rAOMEgBp6MMgnwjr6bPZKvWZY33tNPiVC6JPLXP5W33/iVxrXkdGTm1n9XdWyE78HuXOTBr9IDJdPvMcJwmB40pafAY2RuMoQHOXukIWyXdE+MAmNmTQWY4VoiuveUwxam5o6C8FL/zkgghFJuVcrjePADjW+E6ANLcd8DIG9Wwuf/ns7Hxws+YY5HxvkC3kSkUBo75+4tasQyDQIUD9X8jv1c7yg8kkFC80945OjkyYuMd3wdhVDe56zFeS7pVAZh8xFEhal0xb6N1G2c96XXE8n26bkvzFLNs0b6nDmpmkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6AFte4jxMQh5400s6AgqDrzLgmjwAegaCCk57yFRoA=;
 b=ymJVVvM39moLI3d5bsVP6gnGK47HnbhV6Sf47lNXnN7HvTvJkZWkxeFazQh+6MFDabdV+RxoMGo4zhNdVrm8YaI3n1F0fdTMBg4U6V5MrPBIpWwACErYrbc59kQxbEhkwyTUUOato0Lopi3kf1Z3Axn8975asvbbjslla9cW+7Q=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 14:07:21 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:07:21 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-2-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:09 +0100")
Organization: Oracle Corporation
Message-ID: <yq1y0ljw3nt.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-2-hch@lst.de>
Date: Tue, 27 Jan 2026 09:07:19 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3a8f01-b71d-468c-47ea-08de5dad6378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BndE2SikwMG/wOLwGh7apcMs6vjRmzZoIpfmwF1wLbdjmWdMU1cetsW9VAq?=
 =?us-ascii?Q?jnmRKLgVAfBVXxwURVzICWKTg9VbCl5ZJN8mnETPb3JhMCjORjNcHYlhgZvT?=
 =?us-ascii?Q?8iHFv6EgJuvDWaS0n0WxyHM0kqpCI/AABxVpTo0sYmlz4q00YfKUpkRiJlXo?=
 =?us-ascii?Q?gey5cwyLcgz+i/YaHqZqyUmppzpCNvym1bo87rFLKR/tQad3xdM2gvgfjvLk?=
 =?us-ascii?Q?GzXwzkGQ7H0ihcSPFUMQT1l+gvXiwwEbvd+r6FRgK5bIfmyQXP50b0qFkGVN?=
 =?us-ascii?Q?gledVyPUuXQwpZ8jTHXH67afFUP0NvAWCw/aKRsa3faYm/Xc61R2S3e3X69S?=
 =?us-ascii?Q?vDEj4hx5gYDwk18HaiPN4cEMVcCsKkjm3CwS7o0R0OSNc5NIpkR026HAH/I2?=
 =?us-ascii?Q?oHu4SDizh3YwxaTaU48ivFETl/xIw4RfskfXc3VWPJ+TR4sQT70nby7munde?=
 =?us-ascii?Q?FBRhVIuysTXY1PUZ8WMpYoC53dq4Ui7K2Gh9MXjEywAHsmQQwZislCjVNab9?=
 =?us-ascii?Q?se/+BEupWPplU3p1+U3UdKBHUjynRYA54imRcdJAkn2ueSJK2WCJLkcEb8qj?=
 =?us-ascii?Q?m5Re8Q2NrGXGX3A8SRHTdqqNdx5yxoP5J9SaHmLavr35VhXKTFh/zK7CG15D?=
 =?us-ascii?Q?E5Xv50idQgvcCV0HE5pzcZpjFRittOYXbzNDN7NuWbYKErCZk4DRgEUtY97u?=
 =?us-ascii?Q?QEJVbrb/ZoAlnuImguMyy0BF9KtLCk6mN4l43yzCxrHlufknpyuTVWxax/dL?=
 =?us-ascii?Q?BfrPDDgS3hBi14Fb9DFlm+QiBAAkxFOB49mf1ORRgGrQ/z16BkHJU0LEKZGN?=
 =?us-ascii?Q?u8DEtGuk1+8G1Ra2dFmq1cYwYWe7TU4xJKNGqFQzGQxEW0owaR/8fw9k9tHi?=
 =?us-ascii?Q?M/B7kz/drIE39ITeF5bDtUlz7lbfx571IUacAh+uPI9ai/2J8bFpkbRkzZPv?=
 =?us-ascii?Q?DO0qni1yO1lOvsSRaYb3r4rztntURouOn9tZZxXzFMFMBLSSEMgbrSMb5e1Z?=
 =?us-ascii?Q?25oUXQCny/nKi8kLgaoIQWXCz+upAtpf17/OF3Ud3D934x/46N1kv0+etOpB?=
 =?us-ascii?Q?bPrlPROp2TcjZe++rPbkhxCnY+Bn2PVHUif5QfUz7AbLjdqSHAyyVNSK0wIu?=
 =?us-ascii?Q?jvYt5iyvtO9jwYGZe7TH/JAyhJ7PpC1k/HMT9Kv+wQ4N8BEIGrH6MODv6JEH?=
 =?us-ascii?Q?AlTIfBPtP/W6ylzxIjlERO6cmU1uYjy+a/BMqgZe+UciQYHtW+fefttG2R6W?=
 =?us-ascii?Q?f38onQjPsDQ+T35cJWpmiDxkdXpSc6uSHCDwwkOAb3tg1UjrESs0rM7wt0DG?=
 =?us-ascii?Q?RcNL8GTsbFDn/BTzJ4/7kllWrpqfPB9ENqR3C4IymSqYUyTUAf2MjB7kEAVi?=
 =?us-ascii?Q?vyY+eQA5wZO+HMNcYSXm1JouHzv9mN9Nxe9D894qE1BBmcX2XyrgxfrvTlHB?=
 =?us-ascii?Q?eBwTAMm57uJbUWwE37tVT90AGSLuflX4Zq9hes3HsnR4qvRD8zuqYiZUr2Vs?=
 =?us-ascii?Q?9gTmxc7LSZlw/ptgN4Pf6tRiIfx9/xajElU1onlmcNWchdR7K+SRl6cw1axC?=
 =?us-ascii?Q?KPdrTwFvfdSPxba8WVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aavWD7QjINVxivYbKNyIRk91DkPIz4q8HXg892A5DmZaZXsEbFhetf+eg2lo?=
 =?us-ascii?Q?y8qAVtvbl//LTLYproVQT8v80x8qaNOtmbe3CYnjC477hS8a5L89SsuaZBlz?=
 =?us-ascii?Q?rUMxG2igYdwl5d51yX4LB6UhJhY65nM4SMpmX1J50jS1ndQH1+LZ24gtBXTB?=
 =?us-ascii?Q?ldKE/wCubqViy9trYvqnbZMFpAwWRZx3qxsckuQDAS5c7erBB8Dur19V55bl?=
 =?us-ascii?Q?Pp1VqsmU10VxNkLmdmMhikXY0K/tz66LC7RDOAxSffMwuD/8frZgBjBGW0sv?=
 =?us-ascii?Q?1NfjgsVwzcrWEsRlVpxBjJmPjO0tZCsLUGi2YYNTlRL2yWFcBVFk3i6pbZEN?=
 =?us-ascii?Q?GAQS+OP9lXt+bVBP5zVGzQHxpoYDC3IRkqmhWjyapCBQwZaXAc6Q81svIoPp?=
 =?us-ascii?Q?T3bNK5qduhuXJ2fzUCyFokvsh83Wlbv1HZd7ylxrT+uYTAdnKH/YVoPpgDN7?=
 =?us-ascii?Q?RhFJkYMkXmC0LZrN9/vheoLDaT9X7YivQWcI3XrddvBDzwFFPPOQZ263iZr7?=
 =?us-ascii?Q?rC9lxZgLBiLDEmo++pNiUQceKkWrdlB6zr0zQCbHulGKVYhwGVNynuEr7MUs?=
 =?us-ascii?Q?m7F2RP2wLbjkw8VL3KoB57GAOzDG8sipOQCWs90k8xw3CzCuxnbrxe3wSaOT?=
 =?us-ascii?Q?M1qbWzQH9Spx52n7vU4Q6S2aprz+eBTsiCGOU5akDAAya8Am5hjehpM+jZgl?=
 =?us-ascii?Q?rBHOlZYGlyQxKxuz9x7pOn0praffKf2MRhI2/YyhSuVxkFc9VnNs4at4hxkJ?=
 =?us-ascii?Q?k8jwEQfLM0M7WguU8iEzfy788pFw7ZhZkBI+oefShSGLomGNbRqTjhxaFsX2?=
 =?us-ascii?Q?qQOwaAoOZ53JPbq0cyQeuRJeRvAIFMgRVzHQD0eTLM8OXoup5bWcnDCrx2Gq?=
 =?us-ascii?Q?3uJGuBiS8S/x3XIkjASjsl4pG4KQM7wVDiXsGaqk5U2yMMAw+Z0X7nBg3cY1?=
 =?us-ascii?Q?Fg6HkedIhRF0Ge9kBhCtUSkAmQhIzzk8l09/51AKTYDQEGPjihC5FqczgxS9?=
 =?us-ascii?Q?oUHxWk8s04kcrpiEuBanINnWVKLRVQP1OVK9AXctAb8zKiyI6Q1m/mve0qSN?=
 =?us-ascii?Q?tk/boWMdpJj3TeGpd9ExN6ZiqnhWkhrb0Rv1jf2G/6TwXi+XVlsV8/rd0S0c?=
 =?us-ascii?Q?Cm0aDrzpu1/K+gDhqrmUpomfSdsN/x/TcAJ+K0m1/d85RuIShTvNf71cg5Kt?=
 =?us-ascii?Q?5XYNm0+KsFzzRtW5iz4C3UkcAIT4YDCc/MyRmPl+S4rRKS2fsrxSNzA0Afsc?=
 =?us-ascii?Q?zgccA9C28pYVDdYC44bYNMn2Ut/5yTFJwuOuhOQjvlmKeOZVONmAyc+/iVh1?=
 =?us-ascii?Q?XgWaGmLo+YL2L+fwFU3I9HJKVtgFBHQup9ttZg3PhkUIQQdhL24wUjfceIS4?=
 =?us-ascii?Q?mDFXta3sedWDCiIbu9L8HLlk9WUMCxoRRZSiBaD7C6QpPfB1FqV4mPt2sg6O?=
 =?us-ascii?Q?Wbui3KQ0MJqAB1eST8vOP7D0vg4PZyBnrdgY6FkMx2uQSHxlc8ISK9DS4nj1?=
 =?us-ascii?Q?+AAEnxxSxHRjT8wXUrVUGVBMCdm5evn9Z3PErLrZfFBzYqg5/WU6llvnRoXj?=
 =?us-ascii?Q?eX05sG6iKL2YFcx2yQY2jVL0CpsbUEZtjgc8PFGYRufhxmzPqwxjP6YCJPZf?=
 =?us-ascii?Q?EfljMMoXbxQtY60qzyOKs0qC+YfdGzRiR7+C1DtgrvbC4WiGDVruIfHWYN15?=
 =?us-ascii?Q?9rCFH4u5Mq9wEVKDq97/R3deK5mAVq2lkPy0mgmrePmS2UXeQ9pPz4hlOpCM?=
 =?us-ascii?Q?Gg/5jbKOUT4XUW34CJjDJMNGEiRbpsA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GfbvvyHLEporxR2Umj4ifq41sC4ESGRBCOw2i4nTN7HxYYJXgdKZ6mW7DpaBLBYrHFByKCCl4dYkNr841o9hCPQf5E8mFKdZnw5QxoUZb5DZrNlAmjIlceshq8O1Yv7LXjivLIj9XLwC3KYoYAIni5hd7fQEOXniTMG2+wiLxcKPqmt+yEsXG9jylzaX04XV422AeNAxK381TOpgAlupI43dZ6gQVoq9sfZI9xO8Vj3GbrEuUxYd+IFVLHUc+XtJJ18PvkV5WwsT2dGmkaB0Bs8d/Cd0CcoeQJl349h4mmG+Me80FMFkJmnxFpJl1NECthRv0WgritJhSITGg/N9fsioi/R6LTFtt5OqA+0togV/hBQtSvzOl9Hh8YqCmN4/efOi0N2VfqerHdtPG4aB22GTccM41IwR2GfQQ+NHyf3FQF+zcmp5jsW6fr1BcpotQi2ck4J5LE4sGyRHY8qgvaym15bBmw8DOXiNkPag9kAA3SOtzOWGspL+XNerdyR4qioKBHbNx+tY7QVEVx+lBJ3WR/zoz6efjVj/vZP3l+4vi8RcB63MB+RFlV3T8HPVRN+k0dJN8mg5cKTRNhKXUhS+deCl8oGly68K1YPgZNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3a8f01-b71d-468c-47ea-08de5dad6378
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:07:21.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICjiPYSrJLOMP4e0Qkm5gWJRzn0FFs0AWS/SBNw6SK+WADID9PXPkMw5xgRpu31zqMpK/Ya63PmUS1YVNeDcUeLhfkC426fz0t8wIY2EKzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270115
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978c69d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=h4pjkggKmjj11r038LcA:9 a=ZXulRonScM0A:10 cc=ntf awl=host:13644
X-Proofpoint-GUID: rA5Y_eWYT9kdpMdXr4s2utLhuHXw_cUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNSBTYWx0ZWRfXxBbjAxXeyCtq
 zBke9XshyDOgQT994dMazMEuKA8gwNFjA58Cp7k3TE/h46espeP3luLDsfZZBN77BYrYgM4vr/j
 FXZpgBMbT/X//4Ez7VobF+LZqZegQYO2niX05FTNphkX1lmeYLx1Px/T/415LjkdG3SuOI2Q+oc
 +DwJX8Y+YAqUTkzDgzOH6r5EIgmkDXJNsP35BO3sn/2GCp30HBHoS8BTAsmt5ShQEJUdQmd/Ivi
 drLr+sggojgxJ/ac6+ZWjjnUXcPRd+3+MkMJbMTPzlVbhMuywNAb4tkwtzNHGyWtCHoQPWmar/p
 UtW/oMPmLMLjKJVpm8yTUvzp2BCABg9SUJwwaZ+4CeJ74nPzzu7gjDD+n4xGB/lqY9/TmWdO/wB
 sN/GF2A70fRJ/TGigtmDe1hpzJFJA18GNpw7zhY6WF2rQdebZnBKfZxmZNdiiHMc/z+7g5BVsR9
 tid5oIRQwnumdW+DnlEL3DMtdYsQBsBlaZBdLR48=
X-Proofpoint-ORIG-GUID: rA5Y_eWYT9kdpMdXr4s2utLhuHXw_cUf
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75598-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid,oracle.com:email,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ACDEB955FC
X-Rspamd-Action: no action


Christoph,

> Split the logic to see if a bio needs integrity metadata from
> bio_integrity_prep into a reusable helper than can be called from
> file system code.

Looks fine with Darrick's requested clarifications.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

