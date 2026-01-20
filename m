Return-Path: <linux-fsdevel+bounces-74643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNXdN6cucGniWwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:40:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 669124F398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A0B905612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAE436370;
	Tue, 20 Jan 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmdL07S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FC42E01F;
	Tue, 20 Jan 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916187; cv=fail; b=a5l8PoLX+BeUzGGL4dYUPCzNoihkcPRzpycoO4kPRTqb4mJyNV+xbLOhSQkG8gg0JoxMk9ga4YXnlavBUkHc5RJX63moNYYnWQA/hWK0zUci1tHZLFKi4SlLwanKBIkNj3352QgsDa0ZwULTCsLjQjb3oxWhfZslc8T7koYErmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916187; c=relaxed/simple;
	bh=XvwzMZkGe/n0UL1aaJ3ZdJSxXFpiKJtQnlfvndIjmG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fC0sCyq2IAuSNIl3kYASR7uTZpkaHKiVgODl3mnZy5XoiRVuAfsmlbA+tPO0YzyGQbi/hsJQSucmoCEEJyI0UWd/gkEkR1yVkhwueazdKC5wtbpmeVk6foFj1nVWVJigCIOlg305VoP4NZVYOs46i/6vaQI/9hzHOutTfL+/taA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OmdL07S2; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydu/8Oyl4Iy3uOpiod1zyRzc4y65SMkJTH8JfiaaLl7OkWHEhlg5vVZL6Is7THiOS8GGmv0c+R5DEJPK6mrXrvzMlxEefZGPS7QwBNkXs7acInCC47WZGRcuwsbnJOvUT+BsOPzRe1SgT052DGJkIP0cnaf5vLLlpBYevobDF+VgEfpCIMS45hnWSEpqscZE7cnxXoUqld0qJpXhSe4A1ftuK3eRL05Jvc9njkspdvdRkr3JAqZz2Qs16x6Jvt/OBY3NLZ3DJt7PnnHivd5CA4l/qfYLiKFgP7fPjqDvQtN2M9AdGLT00GJBZikDtrPey3Lmp3CkI9nepjNdJt+hAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8bhZ2TY5MB2RIJ6VVn8JzCqH6a45q423RYsFqJFb6o=;
 b=Cxu8eYnESzVuDjVs7FFRlwlkw3KEPEwgETl6yvyWmn0o6Y9VyH09+CW6fXPRS/whorhydjOSpyPO8UnrZ40qY6BcJaZfsoj+JM1FPL920l0M5WNyiM7jPnxY+72C+6x3hIDyoDep1aGcs1TNNp+PjRIzSwp83J1Jih+3ExboNDXMrrbidQu9PiSPYjmfAGFCweks8AJCk48JVAepwX3hQrm4TGqElZ8LlpDO6wAkl6cfBIm1nrWYS/CIrhDkGp0mU3es1GNVgmgQrEQlBCmZqT3Iu8059zFSSHRea7VO5t0qqrzTBu97DAw8ci7INuGmYexJYmKZye+BkkKusG5DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8bhZ2TY5MB2RIJ6VVn8JzCqH6a45q423RYsFqJFb6o=;
 b=OmdL07S2LoYka+3cSRZDRtQEx87Jr+Jui5GuRDKB9IGbQq2coWU9vV61i6kRCqYJ8l2GzeF3c9Wvb2XiD5GDC6pLsGGx2DCCZpQqI2IkV24/cSu0a6lwIiRpM/Gg4wNGPvz3oQGAjotk8htrfEPwq5JdyXYaV45avaGwdnyYrwqFe311VoinxLQnzg934whXEcCkxFhExg3KO9s8MFLeQYiObVFC9KRq8HLRaCFvMh3njuWbWioiT4LaKos1A317voBPRPuM5GxAcrcraOIzLjZLiQYo0ji2vTbC6hJZIb5K88AjclhYyxNRdqipWwgLJ/nSvv3TsW23qjZkwpBBsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 13:36:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 13:36:20 +0000
Date: Tue, 20 Jan 2026 09:36:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
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
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
	linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <20260120133619.GZ1134360@nvidia.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
X-ClientProxiedBy: BLAPR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:208:32f::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d561cbc-87a7-4e6a-629c-08de5828e547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tR00MSgEePWhswZdJ6toMpEhZniVQXHhtdWm78ydLOqeQGwQvonxXp2AcMSV?=
 =?us-ascii?Q?H/t1vewyvMQK9+yJUi605OIneO3DBi3wLz8lFO6EpdRd1TxXari29yvwIbML?=
 =?us-ascii?Q?NFpVRBfrrnK3h1PbNmJZ+bJ2E9Fw9a5Zy6PNswOsDIU4OJq/7OXpj0T6kRo0?=
 =?us-ascii?Q?n+0bQM7lMdqJ7SszZKJ1nbHX+xmrinouykK8OLFSeTog8hY0sZll2ndh2f4/?=
 =?us-ascii?Q?jI3RrO4ASavEHe1dE5w1052wJnBj+d1GvtLFv58njWu8VzldY9DQeCG4v0sE?=
 =?us-ascii?Q?WO33tT5D/5mn6KI/ee2OibhkEpP1wkFWrAS0YHCA75xW9wdkuO+n64AUVsOf?=
 =?us-ascii?Q?t63BOajl5pfbFUJnT/3QfBF6rZpv6DS9e33CFrJDFwtZuWgwF5UCrDZWdaJj?=
 =?us-ascii?Q?bI96MH7aC6AMhm2/C/9KZ0uEWIjW8X3KuZHahg4DiCzpzBtJZw0a2xphMX2W?=
 =?us-ascii?Q?fh5GmROc5e1GYoDof3kltBGHDoFhNy2QsACxahH0u5d9wgkI4vud584nkP5N?=
 =?us-ascii?Q?oldIHo+yNp8FwdsoQhEVTN63Adm66MtjfoK83apPVUR0HlqTd6tQN0ou07dn?=
 =?us-ascii?Q?tReysDRxkFxah/H6RNjgJ6m4eTkEA6hn1NsvW5ZAsKDbpZLTO2+nK3kWMWlR?=
 =?us-ascii?Q?CErsfl887+5i5x9yqOzRNV219ytZ2iEx8t719wkUKYdeh1pp5t5kWMDq6qt4?=
 =?us-ascii?Q?NLsxLR8+H8Nhh1SPWQ4kLYeh6JkWJqgRCExWqbXh0bQzxgGT+jZFbLlNt4Cs?=
 =?us-ascii?Q?RHXsvPq5TtxPnvpaBOGD8/HN4r5rygEQKYBU84G8082L6TCBfbWQCfyI/4uh?=
 =?us-ascii?Q?tOxAYs4QIlVAjjmMDqNnDDbvwZrrO+HbkV0VFumQ0RmRhdCT2pbjaYIPWw7Y?=
 =?us-ascii?Q?aI5nFsKxVVQX7I/kCkXSx4J/fzU6fUicZpuKIod51yXLxwYj0H2SRlPHwWu9?=
 =?us-ascii?Q?e2tLT6gMgQQhSRkv7MpxfIOUxjTATjRLkA+0dY2JrIUb9nZ2UUxYQgEap0q2?=
 =?us-ascii?Q?b31ky2l31z14UZ6TaIG1aN57UXoKamXzjZ1ErlqL4pRRv15ZgneyCnkgywRf?=
 =?us-ascii?Q?nhyH7Q9y9Z94QgqrPCcYfH+G1GoFejwUqlsPs6SBAO6uXjynTSlqaUyQpC9I?=
 =?us-ascii?Q?csu1s75Wog3zM8Mv5cWOjcFGCHS0zuKgoXc3LKBNmDjyKl1x7SQ0dS67YOWa?=
 =?us-ascii?Q?Qs4cqpH1rfe0dlSD+OOES2U7mtWej/9NAHh5XtOzvENq4hJPMSx2UNJEZG7K?=
 =?us-ascii?Q?35KTLNNpxyUio/JJpCT5oFd9pbS0ZLYZ/mrczkDwu5sbJDmLo7GCanNFuHlL?=
 =?us-ascii?Q?FueV+le3TIMmlrkDfXy3A8P5VTvCvd/LRReIWoGx9QnI9uy6GDVcahzviCqF?=
 =?us-ascii?Q?IWJGv+MGt7uCwVVyQ/jEGj5PB72i2f/CpLdQgcc3oQweTep9iZK/B6YJcLaQ?=
 =?us-ascii?Q?4c1+qLZ/s8IiL8HzYsfwi5fvRdLEB6UQcYdIrR0brQ3ppm5HMMh2fy2YBi83?=
 =?us-ascii?Q?nR7hYZ56ajUZSXhUFdjcCYfD5ijfo+C+nS1/WfyLOIoZdQq32L+2RndUGU4U?=
 =?us-ascii?Q?oXhaoorce781IwgHuNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7eARISiupqxZHbfFU25XMkL/EuKaE+t8qCsY+xUmbHqiZKtH4gYOqxPR5NW?=
 =?us-ascii?Q?cO56OFsoX6pICHljPjA4BW/cSoOTs64iD2ibwA5azB96BcGBRgeJS6syAXGu?=
 =?us-ascii?Q?jb18Ym3TtUKqdJNmbfpvaPvyDNEI48nGfjK11dUg53iNnFEpDWPYVF13gs19?=
 =?us-ascii?Q?x59S3WoyT4Jjho3+XGvrT42SUl8luIbFXxgB/3RruxUqj4WHv+qW2gLeLibX?=
 =?us-ascii?Q?tVaRIofhK1CvXCAJX2Pr2t/70vfUkMgr7+jli+Dg/bX3vKJi4RUnN4/P2DNG?=
 =?us-ascii?Q?bz1OgelWsAAMscXKALOXWRjqqheDOtF80MWXiZCIywudJnA8RTWZMbH2o5hi?=
 =?us-ascii?Q?DXRnv+qcNiLvZhcdH1sQ3h+HOivds1fBrDUPoAL569/huAnXie2NbdTjeW16?=
 =?us-ascii?Q?P32JtHNzlUxZzvi1x5RIl76UySAaO4Q7/kV00ghErBol7B2SFigBDRFftLeJ?=
 =?us-ascii?Q?uoJ0tRLXJJ5kQQP3LMokWk6hVym5kznGtycIgxEUs5O4cbrAtEDivyroKm5y?=
 =?us-ascii?Q?PnSV5qAVXPXzvDJSr1BpX2ImgM9nCMVHxisJ0jk5x8tk8FYL0e9NUVE/A1le?=
 =?us-ascii?Q?g9QjWU+XmUgRo1MA1k+2fs6CiWZdD51znnU6n9qURUypVufyVImOANDdk7rD?=
 =?us-ascii?Q?rkQaqH8RmnkQlRAuis/3zcMRBwxKEoQiu+Wy2orOD8Ta2Lwac4sSMjG1naFU?=
 =?us-ascii?Q?6wx9DQ3U/IutJIAmj4XzxUE6iODjErh1Rd52cZHswThcb3BKVsw/5bXRlJKO?=
 =?us-ascii?Q?171MEBhO2ih1WCnNuYueQ46IRdxCb1Oq0vlTW9fyNoLdscQp4R199ocP+ZBx?=
 =?us-ascii?Q?aEJ7nCPc2hy4HUFqk/ai/g75JxZjh9uKW1m+sIFNDvQpv3PR9rUorzlo7JSm?=
 =?us-ascii?Q?my3oued9QzxV5g5CtEVBxS/905F/kbQfbtZyeXAyIggy9mAql72d4O7iGVy/?=
 =?us-ascii?Q?/JPTqXCoE13Rcv4+YACwkEhpxUVqJ+jedzL/B7+jQmrSDyaWtx5Xbe+WNlo0?=
 =?us-ascii?Q?yqul1FB0Nu8XB6W0h4yeWskYqP3BOyH6rUD1xMKC3k4IG5CUe/P6AXPOlfIW?=
 =?us-ascii?Q?YJ2J/9a1yJmkr1UpPfyda9/YS5lvbsEyEMA2LVoRXmfb6o8wxXngFGrh5W+H?=
 =?us-ascii?Q?7awE10ch2CGz3Y5R5oBPAYN3STWtjD7tSD4wSulDILh2iynb8/L9pWHuSclN?=
 =?us-ascii?Q?WUuQpqW5qkhjUryiE5cI8WNpLIHitq7Eclo1YpxZ6UUfDDj+ic+DtX/2zDA1?=
 =?us-ascii?Q?cfGhNnmIRCCTUulKupGckYCcv7o0FzSGBdqt59YwIFFB/yV0G06LZlpgrQqB?=
 =?us-ascii?Q?1Wr6Frgr6ltKXviui7BrKVvuBPBxDZrRWEu4xuAP9rFxaytI/bQBm65XaAhB?=
 =?us-ascii?Q?LQh7QA6PyxN9zzB3ANKsI8jqLhURmWOa/uG9MGpxam5CVrYMeGqyy0Jsc2/X?=
 =?us-ascii?Q?G08Wcdb+e/JDW1IQ6yQ5N2LNadKANgOax3Fq5k2Nf454VVQ2CnAA0JL1pIgb?=
 =?us-ascii?Q?aKd507RgJTe8xIFa7/lRDQocuydhqACQ+pF8phxPJJQE0vlVtRT+LnZ0nSM1?=
 =?us-ascii?Q?VfoJN0nsEohlfr8K800Ns+DUWGSn2w95TEcFNCyjFWPYCQaS6dplEJ7Z4THK?=
 =?us-ascii?Q?kXRlO+lcyLkXsawV4WNQX/jqhcAY8hjS+1GOVkqw+4cfFh3XkxjflqJdfh4p?=
 =?us-ascii?Q?7/RT4EZQRW3MQjqzbkfviZkdbLI72izNJYSymcKq8y8pjQzYQj+qk+n0MPHl?=
 =?us-ascii?Q?fVG3yOsKPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d561cbc-87a7-4e6a-629c-08de5828e547
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:36:20.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZDJVJy7rE5qJjX7RsXV5oPHAhLc3o2RL/L2RSxJLf61h5Anj7OnsP0QpJNPWadl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	TAGGED_FROM(0.00)[bounces-74643-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 669124F398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:46:05AM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 19, 2026 at 07:14:03PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 19, 2026 at 09:19:11PM +0000, Lorenzo Stoakes wrote:
> > > +static inline bool is_shared_maywrite(vma_flags_t flags)
> > > +{
> >
> > I'm not sure it is ideal to pass this array by value? Seems like it
> > might invite some negative optimizations since now the compiler has to
> > optimze away a copy too.
> 
> I really don't think so? This is inlined and thus collapses to a totally
> standard vma_flags_test_all() which passes by value anyway.

> Do you have specific examples or evidence the compiler will optimise poorly here
> on that basis as compared to pass by reference? And pass by reference would
> necessitate:

I've recently seen enough cases of older compilers and other arches
making weird choices to be a little concerened. In the above case
there is no reason not to use a const pointer (and indeed that would
be the expected idomatic kernel style), so why take chances is my
thinking.

Jason

