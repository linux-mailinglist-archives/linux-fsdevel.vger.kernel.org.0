Return-Path: <linux-fsdevel+bounces-76729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPZeI0Eqimm6HwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:41:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F422B113ABF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940DD300B461
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D80F3A1D12;
	Mon,  9 Feb 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O1xNgLW7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B9zwpgfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D082DCC13;
	Mon,  9 Feb 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662457; cv=fail; b=thPUo/etJVPtdsFNqM3Bvem+QmjOrBLkXOjI+B6kpSb6S0hVYRr9ylaSE928fOuGGmadJBNowPITW15aQVtu/KOcuhM9U/KXSvdgRi1yR1ILSDylq9+3E2RCI4CXQRQRluC16/ReIQLQoxXBYusNp32xalfvy401w0leyI4Fr/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662457; c=relaxed/simple;
	bh=aKQP2p0ma138f2GyTFS4e0NRp/kXehbRkBzLksHmo5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dARCWWJZgQDLJ3wXQbcXQfBjhRqVRZmJt+/4O3Q1XWZmIScoMVmOi05oRt9QNRSanip4heYqrBecJPXwUAE9rp2vzr7TCaiPSEJErGaVjEmiP+e3/qN7eZSyGpsKR+HWdoFyBOgx38OFaKdEr3+llbyRQiyPMEaEFFjy6o2J4+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O1xNgLW7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B9zwpgfx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECXXA1228995;
	Mon, 9 Feb 2026 18:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dMU9RqbZcfr1QDgAzt
	ExV4qJoDdD3WOa/bLUWIOlO5U=; b=O1xNgLW7QZe/csyXCpSMG4PtbgW2timDma
	UnZGE08yZt0ZYRxOpdHcwOymdUIMZsYo0G0O/eu3px5miauCSxsVwlP3jpWZgr+Q
	GxZLSuX83DEfR6uA/S/A1IxNM8V5my1tcNv7IHu87bzFCox2gIn9mROVV2TiGcYC
	PAAbD26EJU/ysnSaSGYShMkSmT8qi3lvo+SRLjcxC49Y5co4hr0H4jEFbbIFoPcP
	J1HL+GpaH5BY/5qputpgucnfNXGZn4eb1RQxTCF0ebH6NKZMBxcdL3xd4F8a1/Eb
	XGc0mf+N/zEKTux04YYa2oqZN7+QsOTPDoDoYB1PRr1SeM4Ow0Fw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xes2hgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:38:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619H0cl0040498;
	Mon, 9 Feb 2026 18:38:40 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uukc6vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKGAZxP9fbz3GEZzy+6ZO0EEUNr8rztnz0MiCYbkDROj5pkbalPcif2bK7dgcxArqW7Ad5c4VYQuyoWsMqGESM8FWoh0E6yu7Aw/7aI5k4505rqaD12wnvUCIpgB0NXHeCfNYxuK4BJG076kc9SZknKqe/EvaA4WhcSytUBg7ENcdyRzQ3UlS7yAFi1U4Gp08YDueaJjp2vQuIo81XCKs+vu122Ncb3gTRZ6b7kGNGuFVbMx7toVXmlj2uMQYYBSwcQI2ftFsCl/Ui4plzzL+/nhpvHkA522XY4vqWgpoOs88QQZY0VUsOnILa6uXKthX9xxz09HyFQwjzw6vBarYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMU9RqbZcfr1QDgAztExV4qJoDdD3WOa/bLUWIOlO5U=;
 b=oZlCMi0gP/ojvFZlSMhOFb1yIp3f+A/lKpvJHJmBlsE/CXjpFD81Ifi+Ar1pFt1u4crpFctNXBCzwjk6lMFnwwJxCQvpCGdL4JotadHhOrfBmqM4I5XIEF1RJFtwBRVmyeHcJTX9oQOwrxu1vjKmISPxZaMm1DYpKLVp9VYN2xg8rGcpdUXaCytST8nbKGbtoORJ4rsrvTvn1JuP+z1jp6rkzss8exJfHZcJjJjTa9KqumpNMzGnt4OMh0Rqs+cfxzl0uoxQhoq/B1ukXwChHbreVGdB2PTnLdge18L/2o8DLUcb4GrZZHbP+0tRHqKQqPeC3GRn+2RoP6QGDUaKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMU9RqbZcfr1QDgAztExV4qJoDdD3WOa/bLUWIOlO5U=;
 b=B9zwpgfxMYFe+PxFUjbZBDIYqk5oEmEVMyZiBYsPBdl3m7QQNgGxXpTnM45UZfFl2iLX8JFhaS9G9wXDQKLWuqZLjajpO7gUwePvdS+VwlKeOpy+yImVyLrkJEcdSN9yw5i02wi4tNdKWqkNkVmskZDS+qRZJleNBf+1pNY9LdM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7532.namprd10.prod.outlook.com (2603:10b6:610:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 18:38:16 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:38:16 +0000
Date: Mon, 9 Feb 2026 18:38:05 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v2 01/13] mm/vma: remove __private sparse decoration from
 vma_flags_t
Message-ID: <7oqecfml77ievg2p6zks6ka6mv75ttfjvc6i2hr3a3hhrqqinz@akufz44ogdfh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	devel@lists.orangefs.org, linux-xfs@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <64fa89f416f22a60ae74cfff8fd565e7677be192.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64fa89f416f22a60ae74cfff8fd565e7677be192.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac3c1d3-cf58-40f7-a84e-08de680a6392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ME9BxVEbQRWtiVZlA+9gngr+cXmzCXOAfTyZDN76q83JvICxDiR6aupWRDmH?=
 =?us-ascii?Q?e2ZFOBrGd1fwn1XLa/wFzwbyX8fIQlMhtXY1jCPnV1DU7lFYxzTXsSALMnMK?=
 =?us-ascii?Q?ZD1fsrVSzKA8cSNt377TDogUcrQh1a/gbTY6O097Iwz5Hj3+cqv4YqbO3jtR?=
 =?us-ascii?Q?WjHnwCtWVxvM1xWosgxAjE0kMAqJLRm8e8fu0Awv9tgg+Mq5kHFIZCrNyZq8?=
 =?us-ascii?Q?TXpeNEz1XOI4oAFhJ/Gzp4VYJuidA7FT4i5aNkZhsQm9/h64ASFlQv/Zzn6p?=
 =?us-ascii?Q?Px8K6dA/ZJk/gSWdN9K6kFhnrIZ49ja5O44jbGiHYnkQAbkk5Tpg8zkd62vu?=
 =?us-ascii?Q?3MDdI+0llduhYIiu20p4hiuVYTAEa3E9vjsDZis1HckERh9Mhx3wRTZ22Aoq?=
 =?us-ascii?Q?ukcuyy4rbc+wHGjVYvOMd4vqv1UbP950gOIDdkhp1wjXV6m4m4GVBaWo+kz+?=
 =?us-ascii?Q?RwB82+Z0/fV/wuuNMdn4zYRDtN10gZC9uHNpFux0lHTz4xNWySxlFLNnMcZO?=
 =?us-ascii?Q?KDHgkHHpoXA0hu2xQfi8WieOGc/lvOdZMTcNaNWeNAa1r1zEr0kBWuxyOUgk?=
 =?us-ascii?Q?4bP+BGJHjOPCIcSNLslk9saq4w08oeEAlgyWk1eADTLA6Vad5pbA4Zr1KB5W?=
 =?us-ascii?Q?oLsXfLfcYbSnwxWIzUu8/D8hagYcIn8wOZeDS7dZUWMamAOg50gbu+tSi5tk?=
 =?us-ascii?Q?sxs8/+hPy0W+fhxHbBLm2CuEPEu5k7V9dXuqzWpT+t9LgdE0Kd2zedWCRn6D?=
 =?us-ascii?Q?cJZkeMAjaE48531nRbE/GA1MkPh+46YnthW60qsqL40GnugSocFXm4QSM5tD?=
 =?us-ascii?Q?OdhlxprfVVx/lvVaOJAGFhVbL+wk6VrnlDIFtVXS9xyUKhn/IewVL5h5rNpU?=
 =?us-ascii?Q?2gBOWxWHO1/cy19i+c+eCwxXAicLwt+d+Lo3SQokRKU+IbKk/sORUmD4kWyq?=
 =?us-ascii?Q?dopFLzUGTwcCJNYH83B0KKAdGnLjBg9l8LkciSGxOOUCPV2WycW1AYnr4znM?=
 =?us-ascii?Q?y351FCvkqoBLnBJ6NAZUuGp0vwwIbiOT1aPeD0LbjeJMk4lVgj31oIxlJe/h?=
 =?us-ascii?Q?AfZNhrKfBCKnszjqOFC2ZDQhs3yQIhfkspWQXkxvYc43NeoungMHOdeMMZv+?=
 =?us-ascii?Q?m2neHAAOZZZGOQ5D3WhW/6QeHsbYn5s8nKiPsH0zT6w0uftFVC+7BolWReqn?=
 =?us-ascii?Q?m2wg/9hBklIyoVc1d/wPfv9F5y5+bEInG6RI/tN7SfxHbHD2VgPlBE5jKlhi?=
 =?us-ascii?Q?39oo9KX1ADN5yMBkaXM/wGAfB4pd3fMQl3jFSCUP8DmtzJ6HFq/XvUJOJDum?=
 =?us-ascii?Q?YK4pdIpHKeCpp2fXbtXdhiSEwulyiL+ZTb2h9UeQHnOJtwYTHIbzfGzxrKn6?=
 =?us-ascii?Q?vvGwejDbseRoqsv53UX3tQC65VYGyVGhUklh2P5mfiRn3irCH2EbWfTsZ01Y?=
 =?us-ascii?Q?43l2BuEBqciLxbjdt+UxuWTYJnQKRgQ2i3H4cDgpECRj3WS/v76ugaiECTqx?=
 =?us-ascii?Q?j99wSz0byIytwFJwFh4MNf069vY2MjvmJPxJJsSj3zpDl+85J7m+H842V2E5?=
 =?us-ascii?Q?pCZph+KJ3LB0rbCNcOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?peCZI8IHNhCsJWxpHxCZmC8LHzZbo//aY7RFGJE8GaGE9r6QBpmxkoZTTVnz?=
 =?us-ascii?Q?YiLCNcfNo0zahxfmZj5uvWdPnfOmGbX+Ut8IdYIiTD4Aei+fKoqH1pMKmsez?=
 =?us-ascii?Q?pOuSM/3R4NSXCQM1qs5pz7v1WrITwHyokQLysomoeE2eODF06ILhXKsXE1wy?=
 =?us-ascii?Q?Y94TLMueK/qjKbuKUwcCtQCKyTgbII5fKPwMuoNLcVuPx8Uq6JNLG/gRpTzN?=
 =?us-ascii?Q?bo0U6To03kJDo5KrH0ijLoXufjJZJKV0u5dSWV4zG5AbTcZquDbEM0j/9/TV?=
 =?us-ascii?Q?Ns4tscE76fWtvybpBPPm5EyvvVkV2aQixR4vwD3Z8x/FKchuof+odZ8F+Sf/?=
 =?us-ascii?Q?tjwwdtxBFYiwFjQBKs7J8nAeFW+yhRx6F4OjEKrlI+PjI11vw81W7mHVNn8y?=
 =?us-ascii?Q?upHiY/08F2+W9hQ4Vjs2HBQAzloyl393MySLHuxPn3uZ7aY7ecJQxRYCaCT2?=
 =?us-ascii?Q?Oss4WYcNzKqNqZI7tJcZsz5DnQHuGFzNgRoDDy7fzfIfFwyYBn2PtXDsAYDY?=
 =?us-ascii?Q?h1lHTlOdVGcnrd8TSWxlLS/aafvpyeex3WO3P0Usac7/G941pHNIcRkRIPN7?=
 =?us-ascii?Q?Ybe1nAtaDjeZqU9WcWl8gJbbwKdm0Qzc8zRfThmvV01IClnE0lAiZe1upmlA?=
 =?us-ascii?Q?gqANpWILrUfgCGQZS3GC3kU2jSYA9hLhOmu2ZTcW4WI/KMo46BC5PtrnxGWK?=
 =?us-ascii?Q?fhwgkyfdTpwuvuV2tmZ341S+Y6Nrty3848JCAEY1AKZFWrAbru3nAoibf0BE?=
 =?us-ascii?Q?05DuhoeYeQ3xITqCGbawxbHHaG6mJV8ZotRyNkOhl+awCHTLkLiv73utFE82?=
 =?us-ascii?Q?mVOJ9lXI8pJ2S8zeIQq9tGNjnwr+apl8m/t9eHdb7rOlN1D+TaPm0nhOGcMU?=
 =?us-ascii?Q?0bw8/s3ZSoTLUi+S039qDkXCbzcYb/G7DgAGtT+y52pMUPiTnRZyYdKENITP?=
 =?us-ascii?Q?yyswF77CtqiM90k8/6yZ07tqcn2qVkJT7GPWNhxYZjQbkqsnmma78aN0A6Lr?=
 =?us-ascii?Q?Zf+g3x4U/WWXwssnwky9q67NuHBILGWvyl28AKEsrbZoZ/wuuT5He6fLKAY+?=
 =?us-ascii?Q?6EhVyJYzelVe2oiD3vezNWxieJkV66kSgrvf/8O08h4TNt0sSZf2pAV1JO+y?=
 =?us-ascii?Q?IYuJbqbta4tKSN7mOmCWVs8AlA0yWxt1bAgk6IpbHahOr2btHjPubJsKFAmD?=
 =?us-ascii?Q?eSZFKGRK+BWnrnGpLWeLrGjYKoggVENVoHXeAdLYCQjEYnqpVzgmoXU9sfeo?=
 =?us-ascii?Q?N6zmPY3tK4Rw1cxRVVzIkCv2j5fnkBL632jrPo1zzq5JHXtQmAip3OnKOLMy?=
 =?us-ascii?Q?JlnPMWhLqZMSVNsX/FZlEtGXZWN5HQktHW2TfakkyQMYPrkHcMFtmruCrC1w?=
 =?us-ascii?Q?Dc2Pbxai7PRa32+Pnu3AOpaqmqCH7lN03WwpPX/QZevNucF0I2fqEN0zSe3F?=
 =?us-ascii?Q?E9LUGYPbfM0aInFNaPaj0pGoCNyFENprvVgHjvcGEWmyCXIaRIMFxqtkoLif?=
 =?us-ascii?Q?wsz5IGPrFpT5y49786XPNrjB4R0Vs2EuQ/qPL9AsyzD9GSPasoOAWbxce8+N?=
 =?us-ascii?Q?ZntYNmCTO27PuC9yulmvSgMTFGnzrkEMLdsgSvPkUlS5R3vB3+lpaCwYXZMw?=
 =?us-ascii?Q?qthSHh2KZ3aFLH17BIQB06vyjCIKRijbWHrYZPoVJbj2Gv4KStCxpq0VxBl5?=
 =?us-ascii?Q?veiUkv/ybdoqlwsN9J5SgrNOLK0c5n8CGODzMzhG5U8UIH2rdrKuhfPPEEr5?=
 =?us-ascii?Q?+vQFHUTxFg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WUnXC4XlG7WdZ3CpGpppQyhH1WyrmrVJCzmNv/nJSCIHocT0WTSs2bDEWBmQ3DbeGic2upFRkbg7SOdcrsUtRmKmS6PIpRqrU0O9t/59nE68iZh7IueS37crzY0wJlFrKBHSzqFROHQocEVt9gkArftCGXFy0HRN0P3nkztKYhPRWXWNtAYBsngK+9ggCAbjbOToKj8bxsg3iKwxUuvJXDTrlPEoYMcWogvUGiFlmLUpcbLrQtgKtkbUlbRgA7X78fiDVfq7Aq2/TpqTNJUC6/l22T4LAedbT8ol3gDaEpq5tynFjrRUD1TvZT6xzb2c15Ve9eONGK/HscfS33VJdqoc0pKsFtjBP1IEaloD/4CCTpj1AVp76WBiMoGIHDkX8evyDjY5PMX1YVCTRHCMMdPKvXUzzVr5BNKxPcqA/nZ0LX9vcSLHT/N1q9w3RG4wW6ldChF858jNHF07EYqvp2FjgPQlBL5FuNDggst+4mm1xyjzwo8sexsSWmou11gtVyWljwToyKAMu/Fu/kCwM2aYIcJvKS6VR/8hrPw79eVUhiCEMVjoiqU76ozSR+GPQ3ffSYbig9wjnvUIRZDa4tJFtj25rzWWH2+QlIuVY/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac3c1d3-cf58-40f7-a84e-08de680a6392
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:38:16.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFdGCtGXckybwO2CYIvy+K/DssiDF7S3Aa7TyxP9nJ5hOiZX/kWjMTbM2CZVc7MC7QDRgBjQKU6axCe7d/DbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090157
X-Authority-Analysis: v=2.4 cv=KaTfcAYD c=1 sm=1 tr=0 ts=698a29b1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=ZamLUoGB7i-ZlhVicE0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12149
X-Proofpoint-GUID: vnrGBhHeg_f3zlDY-3rAvtQYdT1Ucppu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1NyBTYWx0ZWRfX04Nu+Wz7BTOi
 6UQCF1s0Ljp9dj8O/TrrD2G57cZXw4/ZsHCZ0z06i3MmP030WbfrP3thOOPJNitlWhhCnVyg5e/
 WJdk/OUoTn6Mibbux3iMkquLjmnbXnJEA5tpWc6Lf0I9IwDLwIToNwx/Lf+WH7cJODR0PbaucBy
 nqANVOa2fEs2O4vLDkkoCQazTU1e7Z6u1DnDxW2T/lG77LM2AEIPA+x6Da2vWBd20BPAvyB8xqc
 44xuN/uLW0A7/n5ce1V/294RDi/OgDbtB2KSm8jzhmoR/s5UmrElGqgeLP/tZ6ADhfoeBcW+Owm
 J+vgcQFr2v1UWGUKWVCxvJN/WALrq+DhkKqpG5DRKutbYY0XO+aodVClvG+Vd0nRTSGVguFYAWd
 +pCHqQs5LS2fx8ZOzpOZAOF2OQRNkOxd8hkDVFEArCLA5O6JtjlGiyCtHaPD8cOA1YAYPkDv8nc
 QHs5e+ZGKt4rCJ2Nnypd1BIWn9kgV6ZnzhsPKzDg=
X-Proofpoint-ORIG-GUID: vnrGBhHeg_f3zlDY-3rAvtQYdT1Ucppu
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76729-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F422B113ABF
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> We need to pass around these values and access them in a way that sparse
> does not allow, as __private implies noderef, i.e. disallowing dereference
> of the value, which manifests as sparse warnings even when passed around
> benignly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h       |  4 ++--
>  include/linux/mm_types.h | 14 ++++++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d7ca837dd8a5..776a7e03f88b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -943,7 +943,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>  	 * system word.
>  	 */
>  	if (NUM_VMA_FLAG_BITS > BITS_PER_LONG) {
> -		unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
> +		unsigned long *bitmap = vma->flags.__vma_flags;
>  
>  		bitmap_zero(&bitmap[1], NUM_VMA_FLAG_BITS - BITS_PER_LONG);
>  	}
> @@ -1006,7 +1006,7 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
>  static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
>  				       vma_flag_t bit)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
> +	unsigned long *bitmap = vma->flags.__vma_flags;
>  
>  	vma_assert_stabilised(vma);
>  	if (__vma_flag_atomic_valid(vma, bit))
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e5ee66f84d9a..592ad065fa75 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -866,7 +866,7 @@ struct mmap_action {
>  #define NUM_VMA_FLAG_BITS BITS_PER_LONG
>  typedef struct {
>  	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
> -} __private vma_flags_t;
> +} vma_flags_t;
>  
>  /*
>   * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
> @@ -1056,7 +1056,7 @@ struct vm_area_struct {
>  /* Clears all bits in the VMA flags bitmap, non-atomically. */
>  static inline void vma_flags_clear_all(vma_flags_t *flags)
>  {
> -	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
> +	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
>  }
>  
>  /*
> @@ -1067,7 +1067,9 @@ static inline void vma_flags_clear_all(vma_flags_t *flags)
>   */
>  static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
>  {
> -	*ACCESS_PRIVATE(flags, __vma_flags) = value;
> +	unsigned long *bitmap = flags->__vma_flags;
> +
> +	bitmap[0] = value;
>  }
>  
>  /*
> @@ -1078,7 +1080,7 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
>   */
>  static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +	unsigned long *bitmap = flags->__vma_flags;
>  
>  	WRITE_ONCE(*bitmap, value);
>  }
> @@ -1086,7 +1088,7 @@ static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned lo
>  /* Update the first system word of VMA flags setting bits, non-atomically. */
>  static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +	unsigned long *bitmap = flags->__vma_flags;
>  
>  	*bitmap |= value;
>  }
> @@ -1094,7 +1096,7 @@ static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
>  /* Update the first system word of VMA flags clearing bits, non-atomically. */
>  static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +	unsigned long *bitmap = flags->__vma_flags;
>  
>  	*bitmap &= ~value;
>  }
> -- 
> 2.52.0
> 

