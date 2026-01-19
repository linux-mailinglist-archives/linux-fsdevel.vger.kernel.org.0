Return-Path: <linux-fsdevel+bounces-74454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A842D3AE79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07CC2303B12F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212F39524A;
	Mon, 19 Jan 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wkbkf9Gx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P/32Zrty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F8393405;
	Mon, 19 Jan 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834439; cv=fail; b=o7GiZ4WLA60VwDDqyDZpDnd5K/px2QelsnS5ykiKaqE9eLe/VWSK9zPp0TAbqw4jS7Ov8ii+SZtVimRnmAXUBR8ald0A4plsw2nlmLOvevTE8xXdEdDdBFZrVGWxmFzsoLExZK+3PL3rlaopLtfqHBBC4PVZVVP2fbNpmLffmys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834439; c=relaxed/simple;
	bh=iK2LxPqlvtGXLN4EPgXwyyn8sxMD9kWjpw624y+rGGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHXuuC3ZrUgvvrc19kMfxs8mPE30yQP6u2v4xdVxtl6/R2umRnSMpblbQyZXJ6YtuSggpru+iHg7BPhQxqPc370Qb7sA97UdEOYzygjtwIPovkF36y8xRYT+8Tmgg6Vx+Bqjr5y4PqNHh9nYczwQDLJxLbmnpGS5Hl1opsRHkOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wkbkf9Gx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P/32Zrty; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDNIJ1034530;
	Mon, 19 Jan 2026 14:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uZlJ2vOZ4Kca+80xJLjSPYGW9rGYCuiQxXgKD5mUcss=; b=
	Wkbkf9GxpKeDdQ8NdZ6UmsmOCSoF2IbyOORaY1hzyoe3IzXb2dZXaokZDT+Fcr/2
	jNz304/IaZ4sQJUIL8ukxi/Wb+IsdG9wCAR5/ymJbm3V+WM8kmP1jBUdDZX0nfYm
	yUZ/je2JCwX1vqsMh/TYdO0ypNSwunNDitW1ge+w7I5x79Ix5QdrYT+gkRNxXfjS
	39AoFOCieGhoNXC1tXsOIsRG9XlVEQN4yPO0+WNrh7vWmtaZiuPNJk2VR4MNtRLh
	YelivOOb44YXoR+uUowUjJrs5laqMWMHUhRsR2JyZr+GRkGPaazzFC/lugR+I3h6
	0Pv8alQ1aiOgWoBT9FFF3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vtcr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:52:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEmkLQ000633;
	Mon, 19 Jan 2026 14:52:02 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc8584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s93TRjHf8/hzPUHgWZX4e2Vf9S+vryDULIqHIANS54PPmKuzwbOEDvblNIPfsGCS3mlkafpduFvEdQ4XPKD9Fw7UnKfii1wLvlIFdnnGt83Z6tu6p8f5s+zMDS6TxOcwPRedaK9C13sAnOcvp9BjC/5M5reY08lg/Aham3fg50BUM9F6FsqDTmce2OftDsOrERDdXd172/2dmC5sR5vneQP3BJJD5RrJKgdk/cA6mi2XUQr+RwZxmLXD9iyPlT2UObwuCsUlUWhmqL0V8rsPxpCAd3O+vQmWi3ULgGp3q/kxvpFeuTokwIx5wtvv2O0XVrpqRP5o3K/fyimKE2wOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZlJ2vOZ4Kca+80xJLjSPYGW9rGYCuiQxXgKD5mUcss=;
 b=LbUzwXqoqRL5YVJofqiSSSB6aC43YCk4UzPcvJOmx+rdcgbE3i5jVPODYpC6iixtu0DGWpoRYGP+eFZ1joKcxbcmu3rfqft92iRXjiE6DEoMY1rCDPIVFPsVInQ5Xy7Qu0ucrIb1ilO4MdNZdVR9MRndxlgjMH5hw1pOzMscAeTCgB6OEbpJ5er1LRgSBa3sED80FmMchPZNHHbhBiO4SfT6OdCt/uLntbh8SUfLGAIOrz9z+/YRk+aF1AKBog4TGLAQ7SYdEBCWCRX08CWA5ts8SyNigzb8kSCv3fiFBj2WdVJ463LSsWagTGVfJxxjnDtr5+NK/zRu4+DlvE15Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZlJ2vOZ4Kca+80xJLjSPYGW9rGYCuiQxXgKD5mUcss=;
 b=P/32Zrtywo3TPS6C/nnpriU7Gh41N6riNZmfJnOXOZ1wwaAyWDlFTKmagbOirqiwrm/bHZ9qQyJNbD4ErzZKr4u+lvaCIa9QuKOB0k7DUJVOoHZlh5+Lrt7XEFs5tX5Wf2P5U5lpuU0KjxoABWhH3SyCu1rtxlqmlfkmOIiEsLI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:51:56 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:56 +0000
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
Subject: [PATCH 10/12] tools/testing/vma: separate VMA userland tests into separate files
Date: Mon, 19 Jan 2026 14:49:01 +0000
Message-ID: <9da12ccede29034c28a0004ab812f484b62428d7.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0574.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: a33c35d3-63b4-41b3-fb73-08de576a4a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hBJ1ucYM84gUCQ2JLCgF41H7frmjE2FVtC2HVsD9sVkhxTD0AKd/0MTDyAFO?=
 =?us-ascii?Q?NJpqahX2r7326q07jGO6gP1k5ZXJzxtbClciIzmN6ZIp5IRuqC0+afpoVEc7?=
 =?us-ascii?Q?L9sey+hP8/Ui6YD3v9j39I+jlFJB3q6/3wCIlT34rTnP/PN3wmBa5Gb441cQ?=
 =?us-ascii?Q?jPiq0gSDcvM1S4ugQHkfpo2mh4mkDiY3XkJ5aNIYr3493u40rs0muinXEWs5?=
 =?us-ascii?Q?dsqUcIP0mg0zoVqRitcCL6IdGJjxWEyDp9KeoOVAPJWpTuetFv9jGwJp/gLZ?=
 =?us-ascii?Q?CHlhcxq1/DziMbEzhS4SgWPqjokiq9fnPyqC9xNurvWBLFZXCe4zyW6HTSEb?=
 =?us-ascii?Q?i4sOqLkPoNZzdc14sUTyb9PwVfAnMYdeaxbsfxN/pVUTQ49cOWZF86FEOS+/?=
 =?us-ascii?Q?JnjZGIhQG/8nrjfM2gWs10862fKLEHJ6YoZsPev2XB012DSXJK060XanylGM?=
 =?us-ascii?Q?AzZBr82uS13ZXWHT32wiAo2dNTb/xHJl3mjXN/Dk6UxAEIcPhRuun7MlnP2I?=
 =?us-ascii?Q?bgwHJh0W2grhsl4ZjDTnBFxCHokpqwL9JwZfjwhNTv6hKNdmBE94ZeVp1TK4?=
 =?us-ascii?Q?vvQCD/i20/uU6A09qbxfpUr+2+E6PKP3K04FRo6JaFNt1fhCrgc7xEjW2nhQ?=
 =?us-ascii?Q?yFs8ohtqD4b28qkYarqXpEyphAfr4UA/LP7Py825NFo+S3YjWBWCs2csWKBl?=
 =?us-ascii?Q?SRw3scLQvGqXINjc1OGjIcBPDLWsD60MndRzFD1kOZmMylfxlpqNreDGWf6W?=
 =?us-ascii?Q?1I242wL/K+U5Q6do858bvKfjc1Jq5Kwo1zFXXXlGnlzLrwRucG2kBx75wvKh?=
 =?us-ascii?Q?yh2nD03k3TR6FmAqSUKE1ZOsNr2VqtkqvWWdNhD0u09i/RFn7X3J8kaOvjZC?=
 =?us-ascii?Q?NFWp6vA0hp/118WJ1wErn3C7bUS5NbaARymRUZdyG2vjpN1w+8FlyFsmKexT?=
 =?us-ascii?Q?T2RmMubfodNVZdZCEv5EmSZ+oVi1MfAoErjjrB4Tgj8NLZmGTzAhHIo4Sbme?=
 =?us-ascii?Q?1Wy2icqor/Jd5KwfRL9jGFLHio5CZPxhEtMTfxy3/Q6GyBppl+F0PP0nlxq7?=
 =?us-ascii?Q?9WD5/Ee3rjx76hwdnwwISmkTEje/P4LuyZDpYmmoMY4rNvwuJ7kWauvrP2Y8?=
 =?us-ascii?Q?/IPf0jlcf1udsIDfSuj7WP1d6494ENNOQyLzTAlpBKvMwdFp+ZD3okVqpacv?=
 =?us-ascii?Q?B10bpFkyzxYgd9n/Y/aP9jbrSWI6yojWJQ8LZ8Ud0FDefwbUiUuLjYoxLEW+?=
 =?us-ascii?Q?zTUO2cDc77ir29F+Nt1dO9aN5ZBmbIgRzNkcCMMC190od4q6sWnRhuMiikau?=
 =?us-ascii?Q?3/J+dDpIAythZSUfW/0jVcq1Q8Mcq4fLAHGUnLYkrIgJ40Vs3tI0O/tL8uhY?=
 =?us-ascii?Q?CW5Xfo1C4pqj0e7kz2oqW1FkCbi08txeKIZueQsF5BLpRm5t3TWfHYlp5+29?=
 =?us-ascii?Q?148VT4+EechAK004xJovo3I5ORCL0+2gocnY5fpyeLm5DmE6eIWJOVRBBLxz?=
 =?us-ascii?Q?4RNRuh7vr03pdLYlFlOSgSPYRUJoYGXPfsIZ1LHEsxnWaMDNHzEkFLAGuFrQ?=
 =?us-ascii?Q?MnnaVMiBfxCAVfz7nOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jaraw3q0jw6tSfyVvTIlhGbWI4xAZR0VgW9gUI6DgbcMdlej2s17HZzc8urt?=
 =?us-ascii?Q?9sHJkQXwdImsyMfxbNS0VeBmU/wMwIeWBu5jJWNq0UACprsbiPR7JBQOmC/f?=
 =?us-ascii?Q?OC3G4UnlIXJSzn8wF7BvdUUu1ZwtpcKCE3DMxCzfMo8kiDLQIxrk2Gdipa1z?=
 =?us-ascii?Q?FgFJTfk13HSw9QSAUUSyR3oXY6HrTwtCd/lHFL11hMf5CdQ5Lp8aG7FvND9f?=
 =?us-ascii?Q?5PCsLTq6JN4fZ7E17XcxNbuYRjEz/R16sDcF+zFtD5BVnMEDVp/N9pwtt6t/?=
 =?us-ascii?Q?M71Urz8apE1vuB653Ge0XSNrhPw/qiP+li2DQBihJvMl0XTlE3N7Dt/9C3ZV?=
 =?us-ascii?Q?qnWkWe0P8uEJwLlSA6Ptc7N+BYl5RokmMud3NzxUsyXH9Hv1lYacOCq5j9jD?=
 =?us-ascii?Q?5QfjfR00Y1KpF4gqsYC40EoKY4HLLe8aCnc6lYZeafiKz8jcFJt7kA8I1YYZ?=
 =?us-ascii?Q?M//rf9uOmw719GW6S35TP3OyWGLvNR/gjiCQGe1F/wcjJwVXJEtbkYuVXz/2?=
 =?us-ascii?Q?xjTuoSsDFUFkquvQoxnvF3czm9iCS4FDqsMYLjlv+dHn/FCg7fK8E2j8n5wQ?=
 =?us-ascii?Q?C/7ChG2JwVsThYefYET82rLG9z4ulgmhsXtes0aZxSgVJt/aup1peHfHFEAU?=
 =?us-ascii?Q?GhLWAyHrjXfYb9hwbIkdkI1gGGTyGc8AwFD0CEbgQ2gwEM1P+ku9QA23DEIR?=
 =?us-ascii?Q?+7byBzszNsGIhqk0QUUSuPfgBrNLXTmKejG4n2Biq9X9Nt32yDEqWRRVAqTO?=
 =?us-ascii?Q?u5oW7z2WkBJkGbBpKMbQHjGVmGa3aUHrO+Dpi/1aS2ge1FvZOJ3WTT0sDnMb?=
 =?us-ascii?Q?58HuvveBcno4qsrd2gpTpJaFxQigdhd3QpRvAMrQk5p4LwNkpCnAbJ+MdYh1?=
 =?us-ascii?Q?QsqLp0rVLePZ6qbuRto6eaGvakhJvIe/D0QUV9uqcaf13iR03NlSFRp79DxQ?=
 =?us-ascii?Q?rQrC6ma12I4zS23+cG7hnB3o5hSd4UQOQpri8niDQx+t9FISJ+mkW9rR890C?=
 =?us-ascii?Q?/PTsDhrIQAPmgEEilCSuzZpJIK9B36NAuSfveFakmE5/FuBypiTGpwLGYxdA?=
 =?us-ascii?Q?L1d91YlPffkyKdtE1rw6J7moydIUd6zH6Y7wKwmKIv37La4BPltj8Q4x6c2D?=
 =?us-ascii?Q?T6rjkgVVqLT7e7UzEOgYf6G/3SCY3rvPPkw+EyQGlV5aKFL4MiXDJ3fT3LgG?=
 =?us-ascii?Q?5FExVAhjOaJ4oKlgS/SlTikFoE8vC49X0vH91DG2DpIVGMemVTlpBH8BwczR?=
 =?us-ascii?Q?C333D0g1sTUN9+r5a/dvr3pO75nax1TEH8L5mGIk0RB65ytH8uZn9qG3VheT?=
 =?us-ascii?Q?sfByfiU+0WWlI940sOYJw/M2oppJ1qRe0uEWRo7A5yrJP2p/vItW/A/Mpqm1?=
 =?us-ascii?Q?ISGpzxuqsZ8FOHnwHiNX+OtIpH211g9endozY2zSkxVMHjQMo/aLPGC2924g?=
 =?us-ascii?Q?FlJepPpA/aHu1ucSVlfhVbr5U+tPBKk9/0NTP2fXX1EMy0kwpFPXFX8npoQV?=
 =?us-ascii?Q?sHrqu0LUmvimdlSSzpvQ/0jGTuHMJX7TJyKgwuLa8rsHabzTNsfEd45ylWLz?=
 =?us-ascii?Q?dvYKe3iewbjzXJLhhjwT54dA1D/aaq7KPpUHRBnv5h+63t0hPbWZSDXFzTLv?=
 =?us-ascii?Q?ikNb65yK+ZmAVdeAWq1S4lRfmTxKEK61FOMcl4UbEfHx0hkyavOqMJGoGUIt?=
 =?us-ascii?Q?CuhEccDUo5os5iCK7y9y2GwpKlnhtYJrn7x7qQHnWrWJaoHvqcgsTBbf9qxr?=
 =?us-ascii?Q?VMGUyB9+LwshNzYEVORuz4A4s52SrKo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o3pgL5ceobjdwT0vjOi8V2BY7uo1rmRWMfe5xo7Bb3YTWEfvki8ldE86AGuzf9Ru7mz5otw9ZF5kpZbaU+K7v8Xp+X4lWLE02lTPOv6smo2vHwVs+/7X54ATVAPzaPEOX7eyQ8/sbP94B9xgUona4N0dRPWC9y+qSmaleW+QFKRsgGZ8lDZubCoUfNgz/OIw166OSxAM5WOnHACxeIwn2cGLITAIBqDacjUre2W5rrOpv/mRj5JnGwF8xGCKrwcbwz6sQtlTOcgbOIv1LUyKfqFjstmusAMXmOXIoIGhqD9I1hQE8FI/9VhT9Atax96ux6vqzTevGMW4TvobW6x2ARgYF1+FuRPMg14MLBpjRi8Yfk/aTZlXf66AL9nR4CCjba8gxy0YineMp06SIsPvNIFh2R1C9P+I3uk/vmtNVWGuJH4W6JKPYABHaA5aCgYPvcuSQViZBnt9X/QHTyqqEomd4ENUrM1QmqylRstMEZJ3mqodbLkqXA/PgHCS8EdaMoc4kTY/rawZZq8MBwcJfxAT8hRlQ3OC9oLFl4pA3Th9xfuk6sTzu72Ex6hXb67jFNo1MhTXlXxrpPDunlqXE/yQaS7PABesv7jCSADkadg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c35d3-63b4-41b3-fb73-08de576a4a0e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:55.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+noQ2gFTs5w6+kn/v4GAcPGAF0BRgmCjVnR+jbkPPZ3PO4VT/dlP6vo78CBFGxeCH3nc78bIQXHeZ9SxuZRs4t1I2PXvJhDl9PYwDaBeNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696e4513 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5uttRRLgS_GaOMRt2q4A:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: lUlToLHitfXB0rwaSMRBNy4jpfUxKMn6
X-Proofpoint-ORIG-GUID: lUlToLHitfXB0rwaSMRBNy4jpfUxKMn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX13T4SbImqPa0
 Dei5DtO8SIusSnH3HvfH+V0xY99Nv+rwmlDF9pxgPKcAKB5WN+IBoPFk+HksOdn4NEXQEckbSkW
 OE1eAK4jXi2tmF+bk/rJDpPqP5LEU73eNIZwBP7prGrQifJQt+nSLavpZ2pkHRpgj3eaBzDWYl7
 Nxi/go5XicNAi+MkmrTIsXn1RK6gReqpWzmIURmptyHTEm3vGDBTk6+pyEgYSZmcD/ZTqmX9tFe
 fjGiran4WpB5d8yuU2whXwv1KvyOKwS5JLL1UjfCWaerYBsm2N/8qK8BV2yJpLU38PZC30Euw7N
 xBP2oXuhAcmsDU2a2jqeik5NOIl6jzYO0077ILv4/nHGjS60kW82s6ceOlH1nWPm6Kwsq+M/N6T
 YVYP23BiVDEW/9V0dgpLXhXJZFPA9qo2MqmjyD8qKVdZcSFZ7yIrWIXhx/8mqimNX6rIf1a5c8m
 c2vdn0GxwtwyO5mlzEV8qwkpeR/cWj1NyQjP6+h8=

So far the userland VMA tests have been established as a rough expression
of what's been possible.

qAdapt it into a more usable form by separating out tests and shared helper
functions.

Since we test functions that are declared statically in mm/vma.c, we make
use of the trick of #include'ing kernel C files directly.

In order for the tests to continue to function, we must therefore also
this way into the tests/ directory.

We try to keep as much shared logic actually modularised into a separate
compilation unit in shared.c, however the merge_existing() and attach_vma()
helpers rely on statically declared mm/vma.c functions so these must be
declared in main.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile                 |   4 +-
 tools/testing/vma/main.c                   |  55 ++++
 tools/testing/vma/shared.c                 | 131 ++++++++
 tools/testing/vma/shared.h                 | 114 +++++++
 tools/testing/vma/{vma.c => tests/merge.c} | 332 +--------------------
 tools/testing/vma/tests/mmap.c             |  57 ++++
 tools/testing/vma/tests/vma.c              |  39 +++
 tools/testing/vma/vma_internal.h           |   9 -
 8 files changed, 406 insertions(+), 335 deletions(-)
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 66f3831a668f..94133d9d3955 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -6,10 +6,10 @@ default: vma
 
 include ../shared/shared.mk
 
-OFILES = $(SHARED_OFILES) vma.o maple-shim.o
+OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma
 
-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
+main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
new file mode 100644
index 000000000000..49b09e97a51f
--- /dev/null
+++ b/tools/testing/vma/main.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma_init.c"
+#include "../../../mm/vma_exec.c"
+#include "../../../mm/vma.c"
+
+/* Tests are included directly so they can test static functions in mm/vma.c. */
+#include "tests/merge.c"
+#include "tests/mmap.c"
+#include "tests/vma.c"
+
+/* Helper functions which utilise static kernel functions. */
+
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma;
+
+	vma = vma_merge_existing_range(vmg);
+	if (vma)
+		vma_assert_attached(vma);
+	return vma;
+}
+
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	int res;
+
+	res = vma_link(mm, vma);
+	if (!res)
+		vma_assert_attached(vma);
+	return res;
+}
+
+/* Main test running which invokes tests/ *.c runners. */
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+	vma_state_init();
+
+	run_merge_tests(&num_tests, &num_fail);
+	run_mmap_tests(&num_tests, &num_fail);
+	run_vma_tests(&num_tests, &num_fail);
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
new file mode 100644
index 000000000000..bda578cc3304
--- /dev/null
+++ b/tools/testing/vma/shared.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+
+
+bool fail_prealloc;
+unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+struct anon_vma dummy_anon_vma;
+struct task_struct __current;
+
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (vma == NULL)
+		return NULL;
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vm_flags_reset(vma, vm_flags);
+	vma_assert_detached(vma);
+
+	return vma;
+}
+
+void detach_free_vma(struct vm_area_struct *vma)
+{
+	vma_mark_detached(vma);
+	vm_area_free(vma);
+}
+
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
+
+	if (vma == NULL)
+		return NULL;
+
+	if (attach_vma(mm, vma)) {
+		detach_free_vma(vma);
+		return NULL;
+	}
+
+	/*
+	 * Reset this counter which we use to track whether writes have
+	 * begun. Linking to the tree will have caused this to be incremented,
+	 * which means we will get a false positive otherwise.
+	 */
+	vma->vm_lock_seq = UINT_MAX;
+
+	return vma;
+}
+
+void reset_dummy_anon_vma(void)
+{
+	dummy_anon_vma.was_cloned = false;
+	dummy_anon_vma.was_unlinked = false;
+}
+
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
+{
+	struct vm_area_struct *vma;
+	int count = 0;
+
+	fail_prealloc = false;
+	reset_dummy_anon_vma();
+
+	vma_iter_set(vmi, 0);
+	for_each_vma(*vmi, vma) {
+		detach_free_vma(vma);
+		count++;
+	}
+
+	mtree_destroy(&mm->mm_mt);
+	mm->map_count = 0;
+	return count;
+}
+
+bool vma_write_started(struct vm_area_struct *vma)
+{
+	int seq = vma->vm_lock_seq;
+
+	/* We reset after each check. */
+	vma->vm_lock_seq = UINT_MAX;
+
+	/* The vma_start_write() stub simply increments this value. */
+	return seq > -1;
+}
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma)
+{
+	vma->anon_vma = anon_vma;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	list_add(&avc->same_vma, &vma->anon_vma_chain);
+	avc->anon_vma = vma->anon_vma;
+}
+
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc)
+{
+	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
+}
+
+struct task_struct *get_current(void)
+{
+	return &__current;
+}
+
+unsigned long rlimit(unsigned int limit)
+{
+	return (unsigned long)-1;
+}
+
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
new file mode 100644
index 000000000000..6c64211cfa22
--- /dev/null
+++ b/tools/testing/vma/shared.h
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#pragma once
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "generated/bit-length.h"
+#include "maple-shared.h"
+#include "vma_internal.h"
+#include "../../../mm/vma.h"
+
+/* Simple test runner. Assumes local num_[fail, tests] counters. */
+#define TEST(name)							\
+	do {								\
+		(*num_tests)++;						\
+		if (!test_##name()) {					\
+			(*num_fail)++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
+extern bool fail_prealloc;
+
+/* Override vma_iter_prealloc() so we can choose to fail it. */
+#define vma_iter_prealloc(vmi, vma)					\
+	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
+
+#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
+
+extern unsigned long mmap_min_addr;
+extern unsigned long dac_mmap_min_addr;
+extern unsigned long stack_guard_gap;
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern struct anon_vma dummy_anon_vma;
+extern struct task_struct __current;
+
+/*
+ * Helper function which provides a wrapper around a merge existing VMA
+ * operation.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg);
+
+/*
+ * Helper function to allocate a VMA and link it to the tree.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+
+/* Helper function providing a dummy vm_ops->close() method.*/
+static inline void dummy_close(struct vm_area_struct *)
+{
+}
+
+/* Helper function to simply allocate a VMA. */
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/* Helper function to detach and free a VMA. */
+void detach_free_vma(struct vm_area_struct *vma);
+
+/* Helper function to allocate a VMA and link it to the tree. */
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/*
+ * Helper function to reset the dummy anon_vma to indicate it has not been
+ * duplicated.
+ */
+void reset_dummy_anon_vma(void);
+
+/*
+ * Helper function to remove all VMAs and destroy the maple tree associated with
+ * a virtual address space. Returns a count of VMAs in the tree.
+ */
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi);
+
+/* Helper function to determine if VMA has had vma_start_write() performed. */
+bool vma_write_started(struct vm_area_struct *vma);
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma);
+
+/* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+			    struct anon_vma_chain *avc);
+
+/* Helper function to specify a VMA's range. */
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff);
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/tests/merge.c
similarity index 82%
rename from tools/testing/vma/vma.c
rename to tools/testing/vma/tests/merge.c
index 93d21bc7e112..3708dc6945b0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1,132 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "generated/bit-length.h"
-
-#include "maple-shared.h"
-#include "vma_internal.h"
-
-/* Include so header guard set. */
-#include "../../../mm/vma.h"
-
-static bool fail_prealloc;
-
-/* Then override vma_iter_prealloc() so we can choose to fail it. */
-#define vma_iter_prealloc(vmi, vma)					\
-	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
-
-#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
-
-unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
-
-/*
- * Directly import the VMA implementation here. Our vma_internal.h wrapper
- * provides userland-equivalent functionality for everything vma.c uses.
- */
-#include "../../../mm/vma_init.c"
-#include "../../../mm/vma_exec.c"
-#include "../../../mm/vma.c"
-
-const struct vm_operations_struct vma_dummy_vm_ops;
-static struct anon_vma dummy_anon_vma;
-
-#define ASSERT_TRUE(_expr)						\
-	do {								\
-		if (!(_expr)) {						\
-			fprintf(stderr,					\
-				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
-				__FILE__, __LINE__, __FUNCTION__, #_expr); \
-			return false;					\
-		}							\
-	} while (0)
-#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
-#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
-#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
-
-#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
-
-static struct task_struct __current;
-
-struct task_struct *get_current(void)
-{
-	return &__current;
-}
-
-unsigned long rlimit(unsigned int limit)
-{
-	return (unsigned long)-1;
-}
-
-/* Helper function to simply allocate a VMA. */
-static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long end,
-					pgoff_t pgoff,
-					vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = vm_area_alloc(mm);
-
-	if (vma == NULL)
-		return NULL;
-
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-	vm_flags_reset(vma, vm_flags);
-	vma_assert_detached(vma);
-
-	return vma;
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	int res;
-
-	res = vma_link(mm, vma);
-	if (!res)
-		vma_assert_attached(vma);
-	return res;
-}
-
-static void detach_free_vma(struct vm_area_struct *vma)
-{
-	vma_mark_detached(vma);
-	vm_area_free(vma);
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
-						 unsigned long start,
-						 unsigned long end,
-						 pgoff_t pgoff,
-						 vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
-
-	if (vma == NULL)
-		return NULL;
-
-	if (attach_vma(mm, vma)) {
-		detach_free_vma(vma);
-		return NULL;
-	}
-
-	/*
-	 * Reset this counter which we use to track whether writes have
-	 * begun. Linking to the tree will have caused this to be incremented,
-	 * which means we will get a false positive otherwise.
-	 */
-	vma->vm_lock_seq = UINT_MAX;
-
-	return vma;
-}
-
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
@@ -146,20 +19,6 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	return vma;
 }
 
-/*
- * Helper function which provides a wrapper around a merge existing VMA
- * operation.
- */
-static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
-{
-	struct vm_area_struct *vma;
-
-	vma = vma_merge_existing_range(vmg);
-	if (vma)
-		vma_assert_attached(vma);
-	return vma;
-}
-
 /*
  * Helper function which provides a wrapper around the expansion of an existing
  * VMA.
@@ -173,8 +32,8 @@ static int expand_existing(struct vma_merge_struct *vmg)
  * Helper function to reset merge state the associated VMA iterator to a
  * specified new range.
  */
-static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
-			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
+void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
+		   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
 {
 	vma_iter_set(vmg->vmi, start);
 
@@ -197,8 +56,8 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 
 /* Helper function to set both the VMG range and its anon_vma. */
 static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
-				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
-				   struct anon_vma *anon_vma)
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		struct anon_vma *anon_vma)
 {
 	vmg_set_range(vmg, start, end, pgoff, vm_flags);
 	vmg->anon_vma = anon_vma;
@@ -211,10 +70,9 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
  * VMA, link it to the maple tree and return it.
  */
 static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
-						struct vma_merge_struct *vmg,
-						unsigned long start, unsigned long end,
-						pgoff_t pgoff, vm_flags_t vm_flags,
-						bool *was_merged)
+		struct vma_merge_struct *vmg, unsigned long start,
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		bool *was_merged)
 {
 	struct vm_area_struct *merged;
 
@@ -234,72 +92,6 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
 }
 
-/*
- * Helper function to reset the dummy anon_vma to indicate it has not been
- * duplicated.
- */
-static void reset_dummy_anon_vma(void)
-{
-	dummy_anon_vma.was_cloned = false;
-	dummy_anon_vma.was_unlinked = false;
-}
-
-/*
- * Helper function to remove all VMAs and destroy the maple tree associated with
- * a virtual address space. Returns a count of VMAs in the tree.
- */
-static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
-{
-	struct vm_area_struct *vma;
-	int count = 0;
-
-	fail_prealloc = false;
-	reset_dummy_anon_vma();
-
-	vma_iter_set(vmi, 0);
-	for_each_vma(*vmi, vma) {
-		detach_free_vma(vma);
-		count++;
-	}
-
-	mtree_destroy(&mm->mm_mt);
-	mm->map_count = 0;
-	return count;
-}
-
-/* Helper function to determine if VMA has had vma_start_write() performed. */
-static bool vma_write_started(struct vm_area_struct *vma)
-{
-	int seq = vma->vm_lock_seq;
-
-	/* We reset after each check. */
-	vma->vm_lock_seq = UINT_MAX;
-
-	/* The vma_start_write() stub simply increments this value. */
-	return seq > -1;
-}
-
-/* Helper function providing a dummy vm_ops->close() method.*/
-static void dummy_close(struct vm_area_struct *)
-{
-}
-
-static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				     struct anon_vma_chain *avc,
-				     struct anon_vma *anon_vma)
-{
-	vma->anon_vma = anon_vma;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	list_add(&avc->same_vma, &vma->anon_vma_chain);
-	avc->anon_vma = vma->anon_vma;
-}
-
-static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				   struct anon_vma_chain *avc)
-{
-	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
-}
-
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
@@ -1616,39 +1408,6 @@ static bool test_merge_extend(void)
 	return true;
 }
 
-static bool test_copy_vma(void)
-{
-	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-	struct mm_struct mm = {};
-	bool need_locks = false;
-	VMA_ITERATOR(vmi, &mm, 0);
-	struct vm_area_struct *vma, *vma_new, *vma_next;
-
-	/* Move backwards and do not merge. */
-
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
-	ASSERT_NE(vma_new, vma);
-	ASSERT_EQ(vma_new->vm_start, 0);
-	ASSERT_EQ(vma_new->vm_end, 0x2000);
-	ASSERT_EQ(vma_new->vm_pgoff, 0);
-	vma_assert_attached(vma_new);
-
-	cleanup_mm(&mm, &vmi);
-
-	/* Move a VMA into position next to another and merge the two. */
-
-	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
-	vma_assert_attached(vma_new);
-
-	ASSERT_EQ(vma_new, vma_next);
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
 static bool test_expand_only_mode(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -1689,73 +1448,8 @@ static bool test_expand_only_mode(void)
 	return true;
 }
 
-static bool test_mmap_region_basic(void)
-{
-	struct mm_struct mm = {};
-	unsigned long addr;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, &mm, 0);
-
-	current->mm = &mm;
-
-	/* Map at 0x300000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x300000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x300, NULL);
-	ASSERT_EQ(addr, 0x300000);
-
-	/* Map at 0x250000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x250000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x250, NULL);
-	ASSERT_EQ(addr, 0x250000);
-
-	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x303000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x303, NULL);
-	ASSERT_EQ(addr, 0x303000);
-
-	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x24d000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x24d, NULL);
-	ASSERT_EQ(addr, 0x24d000);
-
-	ASSERT_EQ(mm.map_count, 2);
-
-	for_each_vma(vmi, vma) {
-		if (vma->vm_start == 0x300000) {
-			ASSERT_EQ(vma->vm_end, 0x306000);
-			ASSERT_EQ(vma->vm_pgoff, 0x300);
-		} else if (vma->vm_start == 0x24d000) {
-			ASSERT_EQ(vma->vm_end, 0x253000);
-			ASSERT_EQ(vma->vm_pgoff, 0x24d);
-		} else {
-			ASSERT_FALSE(true);
-		}
-	}
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
-int main(void)
+static void run_merge_tests(int *num_tests, int *num_fail)
 {
-	int num_tests = 0, num_fail = 0;
-
-	maple_tree_init();
-	vma_state_init();
-
-#define TEST(name)							\
-	do {								\
-		num_tests++;						\
-		if (!test_##name()) {					\
-			num_fail++;					\
-			fprintf(stderr, "Test " #name " FAILED\n");	\
-		}							\
-	} while (0)
-
 	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
@@ -1771,15 +1465,5 @@ int main(void)
 	TEST(dup_anon_vma);
 	TEST(vmi_prealloc_fail);
 	TEST(merge_extend);
-	TEST(copy_vma);
 	TEST(expand_only_mode);
-
-	TEST(mmap_region_basic);
-
-#undef TEST
-
-	printf("%d tests run, %d passed, %d failed.\n",
-	       num_tests, num_tests - num_fail, num_fail);
-
-	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
new file mode 100644
index 000000000000..bded4ecbe5db
--- /dev/null
+++ b/tools/testing/vma/tests/mmap.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_mmap_region_basic(void)
+{
+	struct mm_struct mm = {};
+	unsigned long addr;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/* Map at 0x300000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x300000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x300, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Map at 0x250000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x250000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x250, NULL);
+	ASSERT_EQ(addr, 0x250000);
+
+	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x303000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x303, NULL);
+	ASSERT_EQ(addr, 0x303000);
+
+	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x24d000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x24d, NULL);
+	ASSERT_EQ(addr, 0x24d000);
+
+	ASSERT_EQ(mm.map_count, 2);
+
+	for_each_vma(vmi, vma) {
+		if (vma->vm_start == 0x300000) {
+			ASSERT_EQ(vma->vm_end, 0x306000);
+			ASSERT_EQ(vma->vm_pgoff, 0x300);
+		} else if (vma->vm_start == 0x24d000) {
+			ASSERT_EQ(vma->vm_end, 0x253000);
+			ASSERT_EQ(vma->vm_pgoff, 0x24d);
+		} else {
+			ASSERT_FALSE(true);
+		}
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_mmap_tests(int *num_tests, int *num_fail)
+{
+	TEST(mmap_region_basic);
+}
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
new file mode 100644
index 000000000000..6d9775aee243
--- /dev/null
+++ b/tools/testing/vma/tests/vma.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_copy_vma(void)
+{
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	bool need_locks = false;
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_new, *vma_next;
+
+	/* Move backwards and do not merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	ASSERT_NE(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0);
+	ASSERT_EQ(vma_new->vm_end, 0x2000);
+	ASSERT_EQ(vma_new->vm_pgoff, 0);
+	vma_assert_attached(vma_new);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move a VMA into position next to another and merge the two. */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_assert_attached(vma_new);
+
+	ASSERT_EQ(vma_new, vma_next);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_vma_tests(int *num_tests, int *num_fail)
+{
+	TEST(copy_vma);
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index b217cd152e07..bdb941722998 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1127,15 +1127,6 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 	atomic_inc(&mapping->i_mmap_writable);
 }
 
-static inline void vma_set_range(struct vm_area_struct *vma,
-				 unsigned long start, unsigned long end,
-				 pgoff_t pgoff)
-{
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-}
-
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
-- 
2.52.0


