Return-Path: <linux-fsdevel+bounces-75096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMK0KUZYcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:03:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077286AA4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC6D306E9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B53994CD;
	Thu, 22 Jan 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pCMplYrl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pK4qUMIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C8388864;
	Thu, 22 Jan 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098103; cv=fail; b=RrmtF79QeeWkmdILEngwoU6oQ9sMG950/LEugabWx+6HHM2N0o7PEB8yCS59Lp6dMHWJJ7+4eK7tco2dMbeqWeHzmKVq7+o0sCTP/lyoeDKSykdyekiJJyxu4fTSgK4oN5Rmvq7LRizPGHCUvCTnvm2KpTdEC8R0oMgreu9sYPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098103; c=relaxed/simple;
	bh=Ase7FD2pAYn1eqytPZmYuZ2B1AJkQsA2RuFJV0QGU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQ/ZnpWPBtqESj54KJsZhi3SlQ/pyLE9aMDchj8esez/McX748cp1SsRgAdKINYE16NYDsrHp4bd0Lk/Q3ah7i8nzNcEA8yRq5GlVfkxwKhvKGbF+8fN2tl8YtCDp6jC87jBV036xC8skpDIc0e7YRXKS6rpFTA7KNM+ld5Z9vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pCMplYrl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pK4qUMIZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgK2V460462;
	Thu, 22 Jan 2026 16:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lTIYwG7puHxWt6xS68y63LcxuJ/IkQR1N2HKXnahsec=; b=
	pCMplYrlb71h9GoAmNJtWGO2WrQaF/0eg0hCYAmyGF5beGPtPb4lyC9zbpv7u2ND
	AtPATuuZRZXIOODRmwI7v0dpG9w1nj8b7+eLXmZ50wgix8+tWLjsvfESpiLOsmGO
	0JxRDs6P3ldf/VXdgkpOExD2rX2O5osWuvAwsphhM9uMDTEu568KD8YSqnbGr6SC
	u7y77dqcOcHNQWQ4LRivNon/tQONNutuVBvzUlpBl4IO1WgzqC4xrtrrShLp7FwB
	NQWVbFpbGy0s1xujSCl00/Hi+9bDcqmZToEfp0IrOVLGGvx9BPS35CbyN6UaHyqC
	Igs+o5Gu0OaNQvFkpAgDng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8g0cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:07:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MG6xCX032257;
	Thu, 22 Jan 2026 16:07:02 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlF/cOR62RJ+C+t4OfbfCot4BYxN5ZiQ0qtIkJDDwgwtHGxboAVwDde37S+/Kazp/GeZjN73TdYbCPotmpx6Ld50fHmaDUvqjdYtdMufCHhp12Ul2RDzl0a7WcCN9ubVnQdDXPTIi98xD8b/FmNvvpTaN7V6ZuTPLIXcI7t4x6M8RPtRfmOHcj2mG0D/D4YhIMT6wFdSvSlqnF8Zb4yGUMGdh1ZFfRemPD72v6Gx+1wWYsc267jL36BU0TuJEnpdfeXbYv58e7HjThZncvFCRx9o4sJVaPq1qv40wyv7b6JKnRRbK6RdHauO2ZxXn7iTPXzjoNBHI34sd/AnrtHCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTIYwG7puHxWt6xS68y63LcxuJ/IkQR1N2HKXnahsec=;
 b=IkC4O5O4DeCmx0KJC89gUGztyoVECfx/90p7yjHbxJSNl++gGWQ+XT3EKMMuoPj0ImLkcpblGF9oY4eS3Aq7PTkMRFKfm1YQTrbQcf/raeEHyMjjgiKMAVBT/PU+VSWT/wbG8Uxf+ONOoDCz/KFarNrSlxUDDeMjGwPWOykf7VKr8mPMdppLms4bCZnADy4SDV8L/eypQ1EX5NBK9fhiJu1LC9sOJib/aEcbi7spJ+27ISN07d+zcPeQC5R4NknTK5105Lbf8AYx9kvTTQMvhwltPz8EoMAD9vwXopgbkYsonltpCpQTJcPveUblRthMI5FKKBwWv5/PGhUZc959mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTIYwG7puHxWt6xS68y63LcxuJ/IkQR1N2HKXnahsec=;
 b=pK4qUMIZWr0GPFD1V7w7/QXa9P4naLXT2quwnRc+wRxHqDLiYj71UR/Ka2NSQUf5YIhNtl3+6DV4KAscXQcorasBs9mBEPll95reK8UVDAyNxgb4aRoCznISQhNCbAZDN4IIo5C8pcle2rz6ET0/jz02OWOg5XXjgfco7QyXtYo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:51 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 13/13] tools/testing/vma: add VMA userland tests for VMA flag functions
Date: Thu, 22 Jan 2026 16:06:22 +0000
Message-ID: <7fe6afe9c8c61e4d3cfc9a2d50a5d24da8528e68.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 5989ffe6-e27a-4526-7d36-08de59d04118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrmzWE6zXJaFt23Eng5O9S3FZFtBDiFCWauEZPuuF0ENmCl6v2cFi4vQINh1?=
 =?us-ascii?Q?cebmubkXAOQvNVn1gPmmZYLBXDRm/VSmK5r5FdfEBLhE/yzq/lg8n3Nl+xqB?=
 =?us-ascii?Q?rlybwr7JimQIuHHw0dtcYERgVcShXzuMe0e95CBhpSrj7adN5lW8TsC1a9fM?=
 =?us-ascii?Q?ELFbXjt1TweLB68a5wzuZH7oTfQs+1B2P0eE1c5GvJOjEc8RtnxOjv+B8NEA?=
 =?us-ascii?Q?y0Zf0bR4lPLN5TyCfmQFTfBZXFlwlhBldMgMOrnKJrIzu9QnadRz0UGjcq9g?=
 =?us-ascii?Q?YEMkRPruJwuT8fwKpYfVfjkwcQMD5DMB/cy+S9y4I+Wmm+Cmxhr4IZbrw2H9?=
 =?us-ascii?Q?RdB+rDCbBtEZ2jX/ml68Zc+fU83FdJXx4bxr3uslWGrr+6hHz2XeMMW0VaDE?=
 =?us-ascii?Q?hzGxrHyH8stilBPHg6qFIDnvq4+Y7MBYhbrBMLqCLdbSu3U4rW5iplqwHLf7?=
 =?us-ascii?Q?I1IoNi6RqyvhfjAO5vvyukavKPZisGFzsg8m6xI/P9tR7InPVNgYBmLWsG2F?=
 =?us-ascii?Q?eJoY2YWnQ1izxs3zGDwlD3i/dzJjQaRVHqkH4ss6g/hXfUFZvwkFREUoQbsc?=
 =?us-ascii?Q?xnZHh4RmlXJvYSQ8Ou0v/5f4IK/QUmSh/eL60ATdI6xp26Z/hxn7COiARxD1?=
 =?us-ascii?Q?Z9EA8B7Rey1x2bOZnZEfjrUKd7GTXyzA+IXhs2PV/9ijctafGcskcDiixtvD?=
 =?us-ascii?Q?CZAgsHOd1sKGsexNve0Yroz4D/6tGUicNx5Knx9lAIiyU5z5XmNrLof3VpRy?=
 =?us-ascii?Q?9Edb2NoyQ7n6Vzxi2ftBaQbT+K74ND3gmnhAoCMMVnL4qywdRVIsWH5chsyg?=
 =?us-ascii?Q?cvAWD2p9aceBinBu7JszGw1wphcDk42LTzisuJtpaGlCdQRJ35Xq37pisiLi?=
 =?us-ascii?Q?Te7bnNQURg/w9baK7RWdVJC0mick3edF4jKFg5PBpMmu2XvFXsQIXpqtKq95?=
 =?us-ascii?Q?ruh7tTCPMBDbjHTVfNjA6vec7OWeA7TuPLAoXhmLTwBd4lCk07sMzI3qryb9?=
 =?us-ascii?Q?iMCH1UWDaNCrZyLPjXp3DYn1H9RLlyrS09ZArKTuU6D41y1iE5AuQb/hOzIt?=
 =?us-ascii?Q?Sau2g6oQEhxv1kwZEQqB8x7f9bv4RpH0oTUO9g3Ou790gIWm3t2PDzKNODko?=
 =?us-ascii?Q?Kq7XNK91C0ueogzo5u002glKfx6B22gb2g8TQ4iovWe37mudZSZnZr2dADLh?=
 =?us-ascii?Q?nO3A30/l4QVLOcy2QNknJ3YFCm9VdSOVO/OwMy4YtYSdZeDYCexgeTefGAbF?=
 =?us-ascii?Q?x7bQzgqx43NNDvDxPqq1vZXIzDMj5NOxl6KLmQCixvBvNWww/EeSHXNjZY++?=
 =?us-ascii?Q?KHD5S2O6/6WkZXckwgmf27bE+sUBYGs3SauYaSLhtoh0vEciBDN8THgQ654t?=
 =?us-ascii?Q?FQ0BueHBKNEEDSIcoFa6Ajwlhf4CdofaDH196erK0oQLQIgZWDeGRomFcL6S?=
 =?us-ascii?Q?d7MTmZbwmiIGaDPJneZGNd1hFCjkd3cZLpVb2Pd2Y+3F2sMwt/xnZPu7CaLM?=
 =?us-ascii?Q?qMMxDJ7nXfKEoDUJD2TF6Rac3mYm7uhQSnxsQdDjmKrxyl5Ewlu2is80s4ZS?=
 =?us-ascii?Q?OE/gs1hmiB6udx6c2YE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1p+2rx+6mxT5lALOw5A7KZY16l/aiuSHN+doMAoz+SrJUfpc3S/PtnbYqc+G?=
 =?us-ascii?Q?7RGvLt4/lxjESVE1YXjoTYB7lr/Izq//13woLoYUEYil4p9iBkro5kzOirff?=
 =?us-ascii?Q?0DqsrE6x4DArYID4iPQ1XqcWTuGzSnwAccUq1aCYyBVI7Are6crz3LW5OnnL?=
 =?us-ascii?Q?r36e2WTIUdVJsFrAVNb+rZiwqEmzdqTBLYysGasrjVdzvynccviCRWfmOfcw?=
 =?us-ascii?Q?Lc9WxwgLroPzRXwDAcJG19cMJN1zVcbTf0E0s7wMD23P6xg+OxbBBHxACkqf?=
 =?us-ascii?Q?ohW+QizvMNGh8pu4x00bLD3laQxKaEuXed8XA23uV7up5Osdvi5/ldMwOx+Q?=
 =?us-ascii?Q?V2Tuyx7/Od8leMLvc+xpPmDM4yy2codzq28+/4RVeFteFFpsCOroLmMH4OTW?=
 =?us-ascii?Q?lV39/GaYBbvVygVTrH+Npgsq5xhfDVMI/hP8xuc+AH9FYHBR3GHSuGDWf2oL?=
 =?us-ascii?Q?o6ygSd3CGhPqU08t+J6aBeTkkt0fVXUkLV1kBIUd6tsWDbV7FYh4/n5makqH?=
 =?us-ascii?Q?WZ5yq256SmiPosbzc5shKCZ9lJaJyjfo4p7WY3dr550KxSSpBizl5a8RJMMh?=
 =?us-ascii?Q?+siwxwwqQBtWgZvOswHO8jnFOzNWynLWMM+k8osTK2+N0sDXq+wCczmjRtta?=
 =?us-ascii?Q?T+b2mAigW25XAM7P20TGKNdS6Tw7jatox21A2WigDT2/DZKa8WOzCGqGLCXE?=
 =?us-ascii?Q?WLkymMYaFuFiMhhxKBF6vT219AlumGil5AQKXS55uCK5QHo7FgxqWifSZjqX?=
 =?us-ascii?Q?gfOu/fnWJVm5mIGKRRxhtVzjtxeua7sgIMr0XVn+/Cc3B04NagW/uoadriWD?=
 =?us-ascii?Q?JgXgug2TdczlJ/+Kt5Vb3GcPCsuMbK5OIkMgGEafK5NNCIFcXzdrj+w1KgdW?=
 =?us-ascii?Q?vtvRjguN/x+crMJoJnyYJCciookmtrFKnOMMzeYVu4kb215cFjMfcQLvt9Ri?=
 =?us-ascii?Q?m3uJoOC0sw3GH6xGUDOJ38TQZHDjjcEHDqOhdEUaIbBndYkbHg7vVVbFA4f4?=
 =?us-ascii?Q?5bMQNlaI3eENKFIwmteP6x2qI0JvH/mn9YbIs4HPzRbVdlBAIStfMyT7xDZn?=
 =?us-ascii?Q?hqSaTPnzmI5Uf46M0PTaMFVwMy+Qs4AsUrsyAwomuLNEp23i89S/xoXtWOpG?=
 =?us-ascii?Q?Ja08uyAIHbrTllS+BiwOunMBdiuGGKhmVHw08w7RD56KuoHxhoDzAi+xFAZn?=
 =?us-ascii?Q?2u1NaTR/7dBOkkfTZBErHIcTclCzRCxYvu/b927IdMXCuG5jcoLIG1WHcqGL?=
 =?us-ascii?Q?VoIvLQHnljEwcD7PE7QsuqQOQaL+zFZZFEYCTAfvVORuDj2W9KZsKGEtoeOO?=
 =?us-ascii?Q?18wH8V0QdzD7Sat5LN1erbDKMEWwq2x+DWAR8u8O/b/F7NhhokTeww2kRblz?=
 =?us-ascii?Q?cgpFlodW0m3TPVmv9B+SiqVnD6QQW0npW1poT52/20nmdpRUn+HqkFLQ/rxP?=
 =?us-ascii?Q?N2Prcwa2gQTSeTL1qP7Qo4NAf5tL3mO6dZ38W9eV/yBR6AQafr2CTpE1jK/1?=
 =?us-ascii?Q?NGSXZ6CyN3Xj034UEZhVP5Q4X7UgwwXqFH3yjQ4H8mvXCwm00iEwRNKd8mRT?=
 =?us-ascii?Q?3/g05qRZTKExAtp2/EERrN5KIi2nkFWDUaSjtyoBDvKjBTUnvh8eSZfqrOw2?=
 =?us-ascii?Q?joK6CmX8F2S6KIRUMlEP3rvE1HMXCEa3NivEUVM4ESf7OuJqLN3fkXJ/5S7S?=
 =?us-ascii?Q?cPQ/ur8Fozmh9uq55KFNl3VCGNYk9JpdyfXouXsXYJdqejIKg2MUFLzltRm/?=
 =?us-ascii?Q?F30qdCxm8Ie7xhRovWn3OJQQgjvi4ec=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HPI3IzMYI7OKSpH3wNt4UZtUiQg8dmI25GsU8Ix9mShIme4saup/pmJeLzmDv+Cn+txBzAyim597b1zvwAsQaxotSSe7jrOW529im4oRWwdrFx5DqzT2oX2YOUboGTAkd3JlWALRjY5hYiFh6qxel1r7CDPez/RmgqyTPA9PPYxNpTfIHXgudYdeRtunN5SA/mZd/CtKqsdp5CFOdAIuh5u7dVkP0GDZsPZRjL80Km4ntYq6sJnFsuu6hU/LywJJBIL4rXB/K7LH5fBUFL+GGk7uPAtczPEkkyoUpUn/VibmsFtVfcg3XNZECFBpK1DW83uRIEnMBUkK2+jvnZBB25V+P2gJTNJRHm2DWlh+x9BNdtrS3lDUCGOhNIw7Meybiuft1AqOTCiULH/7EG5veLyK/sKEcetBa1e8Z2b7ryPTMpRUP8eh3dJP3sZG90DOuF6USZ/t336pcLAdJhi2T86iu/B8Bw2b6FfH4hT0c0zDfBGYNswSSSNGhhg81ukyf1rcL+w/FA1i40IoCOBwff/xj31z9Sawpc0fpcwLPMX86wdaqdZtmL6lOoxUOd4uIoxsZ5jz+n8EcOXnO5rfUJoYGLNCT0o60RYU5IOyxa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989ffe6-e27a-4526-7d36-08de59d04118
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:51.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkCtpKPdnTd5ctAxVGo5ov+uKrxysMbGOmcVTc0zD9v5LX4312nGtOCBt2hbEs8cIsS2Ip2fS02B2XyZkdrUOiuzYOgTjLbzavPvC0XN70c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69724b27 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wdtOZTiSbmFhyPzmQ0gA:9 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX1FCwFjyaQFiN
 iqDIbQo+EH2RlUy+fPqJY9W4i1M9zqosnywcF8cBeWYoLd4wgVw+jSGMee1l7lRkmCofaTa6vle
 5pWA0s/bG507z1sQBGTPtv3I7/VvPV3rsyIU+icdV4AcdvPLroZ0H/ckW/nC02t+frv/AKzp48x
 Xsokk1gzAg+z2W2nG9Xb3ubGP/ruGu/CoR4xC+t0idGI16Ij3OcdyASBWGpcMp/QTBpHJRfGZC1
 8koqfqOuL5JfEGaBAxMRDyYx7G93HS+JACRYpTfjQ/T+3P+TP0st09UCBfcp8dXXKJ30Mx+boK5
 mArG6pQ5lr+QOLvI5OQcOK77VVIiorK5lpGpy+E93FKlQscUQA2u5mao99SN7bEV7IPgdGcrlm9
 /w4UcAjTqN4WPO1fze7tmWMVdVLZTLCaHAz1n37uQ2Rb7/XufqzTApNKOzfKmQnWwXPhDoYUC1u
 zpmBwSdWfbSjzuSSrLbK3fJwtQ5nl9J7CBbvxpzM=
X-Proofpoint-ORIG-GUID: 61MEA10ahHpZc1ODPq3MGk77_yT654Mf
X-Proofpoint-GUID: 61MEA10ahHpZc1ODPq3MGk77_yT654Mf
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75096-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 077286AA4A
X-Rspamd-Action: no action

Now we have the capability to test the new helpers for the bitmap VMA flags
in userland, do so.

We also update the Makefile such that both VMA (and while we're here)
mm_struct flag sizes can be customised on build. We default to 128-bit to
enable testing of flags above word size even on 64-bit systems.

We add userland tests to ensure that we do not regress VMA flag behaviour
with the introduction when using bitmap VMA flags, nor accidentally
introduce unexpected results due to for instance higher bit values not
being correctly cleared/set.

As part of this change, make __mk_vma_flags() a custom function so we can
handle specifying invalid VMA bits. This is purposeful so we can have the
VMA tests work at lower and higher number of VMA flags without having to
duplicate code too much.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile         |   3 +
 tools/testing/vma/include/custom.h |  16 ++
 tools/testing/vma/include/dup.h    |  11 +-
 tools/testing/vma/tests/vma.c      | 300 +++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h   |   4 +-
 5 files changed, 322 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 50aa4301b3a6..e72b45dedda5 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,6 +9,9 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma
 
+# These can be varied to test different sizes.
+CFLAGS += -DNUM_VMA_FLAG_BITS=128 -DNUM_MM_FLAG_BITS=128
+
 main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h
 
 vma:	$(OFILES)
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index f567127efba9..802a76317245 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -101,3 +101,19 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 	if (reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	/*
+	 * For testing purposes: allow invalid bit specification so we can
+	 * easily test.
+	 */
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		if (bits[i] < NUM_VMA_FLAG_BITS)
+			vma_flag_set(&flags, bits[i]);
+	return flags;
+}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index ed8708afb7af..31ee02f709b2 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -838,16 +838,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma_flags_clear_word(&vma->flags, flags);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
-{
-	vma_flags_t flags;
-	int i;
-
-	vma_flags_clear_all(&flags);
-	for (i = 0; i < count; i++)
-		vma_flag_set(&flags, bits[i]);
-	return flags;
-}
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);
 
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 6d9775aee243..c54ffc954f11 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -1,5 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
+{
+	const unsigned long legacy_val = legacy_flags;
+	/* The lower word should contain the precise same value. */
+	const unsigned long flags_lower = flags.__vma_flags[0];
+#if NUM_VMA_FLAGS > BITS_PER_LONG
+	int i;
+
+	/* All bits in higher flag values should be zero. */
+	for (i = 1; i < NUM_VMA_FLAGS / BITS_PER_LONG; i++) {
+		if (flags.__vma_flags[i] != 0)
+			return false;
+	}
+#endif
+
+	static_assert(sizeof(legacy_flags) == sizeof(unsigned long));
+
+	return legacy_val == flags_lower;
+}
+
 static bool test_copy_vma(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -33,7 +53,287 @@ static bool test_copy_vma(void)
 	return true;
 }
 
+static bool test_vma_flags_unchanged(void)
+{
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
+	vm_flags_t legacy_flags = 0;
+	int bit;
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+
+	vma.flags = EMPTY_VMA_FLAGS;
+	desc.vma_flags = EMPTY_VMA_FLAGS;
+
+	for (bit = 0; bit < BITS_PER_LONG; bit++) {
+		vma_flags_t mask = mk_vma_flags(bit);
+
+		legacy_flags |= (1UL << bit);
+
+		/* Individual flags. */
+		vma_flags_set(&flags, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
+
+		/* Via mask. */
+		vma_flags_set_mask(&flags, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
+
+		/* Same for VMA. */
+		vma_set_flags(&vma, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
+		vma_set_flags_mask(&vma, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
+
+		/* Same for VMA descriptor. */
+		vma_desc_set_flags(&desc, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
+		vma_desc_set_flags_mask(&desc, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
+	}
+
+	return true;
+}
+
+static bool test_vma_flags_cleared(void)
+{
+	const vma_flags_t empty = EMPTY_VMA_FLAGS;
+	vma_flags_t flags;
+	int i;
+
+	/* Set all bits high. */
+	memset(&flags, 1, sizeof(flags));
+	/* Try to clear. */
+	vma_flags_clear_all(&flags);
+	/* Equal to EMPTY_VMA_FLAGS? */
+	ASSERT_EQ(memcmp(&empty, &flags, sizeof(flags)), 0);
+	/* Make sure every unsigned long entry in bitmap array zero. */
+	for (i = 0; i < sizeof(flags) / BITS_PER_LONG; i++) {
+		const unsigned long val = flags.__vma_flags[i];
+
+		ASSERT_EQ(val, 0);
+	}
+
+	return true;
+}
+
+/*
+ * Assert that VMA flag functions that operate at the system word level function
+ * correctly.
+ */
+static bool test_vma_flags_word(void)
+{
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
+	const vma_flags_t comparison =
+		mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, 64, 65);
+
+	/* Set some custom high flags. */
+	vma_flags_set(&flags, 64, 65);
+	/* Now overwrite the first word. */
+	vma_flags_overwrite_word(&flags, VM_READ | VM_WRITE);
+	/* Ensure they are equal. */
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Do the same with the _once() equivalent. */
+	vma_flags_overwrite_word_once(&flags, VM_READ | VM_WRITE);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Make sure we can set a word without disturbing other bits. */
+	vma_flags_set(&flags, VMA_WRITE_BIT);
+	vma_flags_set_word(&flags, VM_READ);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Make sure we can clear a word without disturbing other bits. */
+	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+	vma_flags_clear_word(&flags, VM_EXEC);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	return true;
+}
+
+/* Ensure that vma_flags_test() and friends works correctly. */
+static bool test_vma_flags_test(void)
+{
+	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					       VMA_EXEC_BIT, 64, 65);
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+	vma.flags = flags;
+	desc.vma_flags = flags;
+
+#define do_test(...)						\
+	ASSERT_TRUE(vma_flags_test(&flags, __VA_ARGS__));	\
+	ASSERT_TRUE(vma_desc_test_flags(&desc, __VA_ARGS__))
+
+#define do_test_all_true(...)					\
+	ASSERT_TRUE(vma_flags_test_all(&flags, __VA_ARGS__));	\
+	ASSERT_TRUE(vma_test_all_flags(&vma, __VA_ARGS__))
+
+#define do_test_all_false(...)					\
+	ASSERT_FALSE(vma_flags_test_all(&flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_test_all_flags(&vma, __VA_ARGS__))
+
+	/*
+	 * Testing for some flags that are present, some that are not - should
+	 * pass. ANY flags matching should work.
+	 */
+	do_test(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
+	/* However, the ...test_all() variant should NOT pass. */
+	do_test_all_false(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
+	/* But should pass for flags present. */
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
+	/* Also subsets... */
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test_all_true(VMA_READ_BIT);
+	/*
+	 * Check _mask variant. We don't need to test extensively as macro
+	 * helper is the equivalent.
+	 */
+	ASSERT_TRUE(vma_flags_test_mask(&flags, flags));
+	ASSERT_TRUE(vma_flags_test_all_mask(&flags, flags));
+
+	/* Single bits. */
+	do_test(VMA_READ_BIT);
+	do_test(VMA_WRITE_BIT);
+	do_test(VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test(64);
+	do_test(65);
+#endif
+
+	/* Two bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test(VMA_READ_BIT, VMA_EXEC_BIT);
+	do_test(VMA_WRITE_BIT, VMA_EXEC_BIT);
+	/* Ordering shouldn't matter. */
+	do_test(VMA_WRITE_BIT, VMA_READ_BIT);
+	do_test(VMA_EXEC_BIT, VMA_READ_BIT);
+	do_test(VMA_EXEC_BIT, VMA_WRITE_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test(VMA_READ_BIT, 64);
+	do_test(VMA_WRITE_BIT, 64);
+	do_test(64, VMA_READ_BIT);
+	do_test(64, VMA_WRITE_BIT);
+	do_test(VMA_READ_BIT, 65);
+	do_test(VMA_WRITE_BIT, 65);
+	do_test(65, VMA_READ_BIT);
+	do_test(65, VMA_WRITE_BIT);
+#endif
+	/* Three bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	/* No need to consider every single permutation. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 64);
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 65);
+
+	/* Four bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 65);
+
+	/* Five bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
+#endif
+
+#undef do_test
+#undef do_test_all_true
+#undef do_test_all_false
+
+	return true;
+}
+
+/* Ensure that vma_flags_clear() and friends works correctly. */
+static bool test_vma_flags_clear(void)
+{
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					 VMA_EXEC_BIT, 64, 65);
+	vma_flags_t mask = mk_vma_flags(VMA_EXEC_BIT, 64);
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+	vma.flags = flags;
+	desc.vma_flags = flags;
+
+	/* Cursory check of _mask() variant, as the helper macros imply. */
+	vma_flags_clear_mask(&flags, mask);
+	vma_flags_clear_mask(&vma.flags, mask);
+	vma_desc_clear_flags_mask(&desc, mask);
+	ASSERT_FALSE(vma_flags_test(&flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_flags_test(&vma.flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_desc_test_flags(&desc, VMA_EXEC_BIT, 64));
+	/* Reset. */
+	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
+	vma_set_flags(&vma, VMA_EXEC_BIT, 64);
+	vma_desc_set_flags(&desc, VMA_EXEC_BIT, 64);
+
+	/*
+	 * Clear the flags and assert clear worked, then reset flags back to
+	 * include specified flags.
+	 */
+#define do_test_and_reset(...)					\
+	vma_flags_clear(&flags, __VA_ARGS__);			\
+	vma_flags_clear(&vma.flags, __VA_ARGS__);		\
+	vma_desc_clear_flags(&desc, __VA_ARGS__);		\
+	ASSERT_FALSE(vma_flags_test(&flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_flags_test(&vma.flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_desc_test_flags(&desc, __VA_ARGS__));	\
+	vma_flags_set(&flags, __VA_ARGS__);			\
+	vma_set_flags(&vma, __VA_ARGS__);			\
+	vma_desc_set_flags(&desc, __VA_ARGS__)
+
+	/* Single flags. */
+	do_test_and_reset(VMA_READ_BIT);
+	do_test_and_reset(VMA_WRITE_BIT);
+	do_test_and_reset(VMA_EXEC_BIT);
+	do_test_and_reset(64);
+	do_test_and_reset(65);
+
+	/* Two flags, in different orders. */
+	do_test_and_reset(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test_and_reset(VMA_READ_BIT, VMA_EXEC_BIT);
+	do_test_and_reset(VMA_READ_BIT, 64);
+	do_test_and_reset(VMA_READ_BIT, 65);
+	do_test_and_reset(VMA_WRITE_BIT, VMA_READ_BIT);
+	do_test_and_reset(VMA_WRITE_BIT, VMA_EXEC_BIT);
+	do_test_and_reset(VMA_WRITE_BIT, 64);
+	do_test_and_reset(VMA_WRITE_BIT, 65);
+	do_test_and_reset(VMA_EXEC_BIT, VMA_READ_BIT);
+	do_test_and_reset(VMA_EXEC_BIT, VMA_WRITE_BIT);
+	do_test_and_reset(VMA_EXEC_BIT, 64);
+	do_test_and_reset(VMA_EXEC_BIT, 65);
+	do_test_and_reset(64, VMA_READ_BIT);
+	do_test_and_reset(64, VMA_WRITE_BIT);
+	do_test_and_reset(64, VMA_EXEC_BIT);
+	do_test_and_reset(64, 65);
+	do_test_and_reset(65, VMA_READ_BIT);
+	do_test_and_reset(65, VMA_WRITE_BIT);
+	do_test_and_reset(65, VMA_EXEC_BIT);
+	do_test_and_reset(65, 64);
+
+	/* Three flags. */
+
+#undef do_test_some_missing
+#undef do_test_and_reset
+
+	return true;
+}
+
 static void run_vma_tests(int *num_tests, int *num_fail)
 {
 	TEST(copy_vma);
+	TEST(vma_flags_unchanged);
+	TEST(vma_flags_cleared);
+	TEST(vma_flags_word);
+	TEST(vma_flags_test);
+	TEST(vma_flags_clear);
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index e3ed05b57819..0e1121e2ef23 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -36,11 +36,11 @@
  * ahead of all other headers.
  */
 #define __private
-#define NUM_MM_FLAG_BITS (64)
+/* NUM_MM_FLAG_BITS defined by test code. */
 typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
-#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+/* NUM_VMA_FLAG_BITS defined by test code. */
 typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
-- 
2.52.0


