Return-Path: <linux-fsdevel+bounces-76733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCIgBXEtimkjIAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:54:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951D113E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924403023379
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA443D9024;
	Mon,  9 Feb 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwZZkzhh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BrQpEyO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E1168BD;
	Mon,  9 Feb 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663264; cv=fail; b=dVhJprO7Oe4fwVSD8mj+SeuNstvLCdL9JMuzvUhHSIUj1k1OWDyfd0j5owemrHnlS9+LlD2aeoRFlPw52DLXcU1RwbhQYMWwzN+RZH/3tJ2miclSyav3vzQb7f64qB3IFsX4s35MthcVjrVa4B0aVFMXSz29JANkREpFuXtpvlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663264; c=relaxed/simple;
	bh=pS38X23K2U6Z1d5niUmO3Cl7PJrz97XMole3NIu+dYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stWU80HBIpYEzdketKLFspGnVRlmCCHXt0OVTtIm4j5p96IW/MbhmQCzlCBEOzY732seKjU7YLeTYQx/1KFX9HQrzIgExtemOYEpj5pJTt5ZlNwO/GQXSl7WVHgBp4WC+OSbYrYUAoL6MW0uLYQGuMFoZMAg9haOzG8+YTNzWqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FwZZkzhh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BrQpEyO3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECZ6t1945097;
	Mon, 9 Feb 2026 18:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=naDkvey231Y2Brh2oi
	euJSuGvyggIBXSJVsvcCqdGBc=; b=FwZZkzhhWn+mYbFNcy4SbDTc99SdCCA8D3
	gn1/7UMZldHxFoXnGc/upZQjw1KZVf0AFxvSegVJ5zvCWO+rq8O5fNw4E5bat24S
	56T9WUv6KjR1kAK/3J9xmGvf9AMdJL7KuGm+MPu7TlinW7TbxCZXGvCcIqmMGJ24
	n5tFT3dtVRR3rdcQaF9MfKrAzMUDTK/lbJ8lQqDMp+vhEd3DVV2AFOvCWVs54vyi
	nKMRofEEdPtE9iS4sH//nFWPtU0KrtqHhHeVsKt4SvHSb0roVicBejUNqoC719Ir
	spShgTFJSEcu4YTU24JcDtBSBl10B1tvRbYGEMTPWDELxYJ4aEHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xj4jhdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:53:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619Hqvbh005044;
	Mon, 9 Feb 2026 18:53:42 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7jnq6geh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7vbYQDmHmdz1CJm0DiM2cEbQwliEnU7Z2XOc1F9FTORx2osj8fH4EN51qJJr06tdvTNfUK2b5sYc0vOKhk7YPN9xQxB1btiLF2o6cNXlZVg/yZ82dNGoReBYLJEfvgiSYS91+Bc8C3QQm8bVKfefJbdSVobthAgzYACHFLdrOKPRWW59ePEccIH4E4VqPowDnAQ4xZqKr4YFOBjKkGsOxdp6EaW/dW91e1rPmdd3lXCAZgalW5eo80Pt+aUcBORqfTQ1QE5eDb+MfFZEeztBReezqkmjgdhbFWwIJBWwBsL5QuK8SBBu0Hx50nH2VQ02samq80/wLj2+6ezcNqL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naDkvey231Y2Brh2oieuJSuGvyggIBXSJVsvcCqdGBc=;
 b=Wyk1+f6EyrVcUEWaFSnJUf7iS1Xv5BVzsK8LA5/NwHx0SXGM0SFnCmUK9VoTcFBE4gZ4+HxVR6uOzIkdTDLvL8P0ODtY+n0ImFUHJavfmB1KNmysovzA+ITIChyy7Zp6o3PmXBDqsrUrFkRG6zRkxQHrs0+bTb9QIYUW0D7nk3QLLhDrGEpiNOnfaEbOzwbqXIgd5F9u23BrzBUrPb2nyIuWZxr77p7D0ffT9rtH6kbFbvxceF0QLUKxSPalslUqdSHm+y8AUGp6h/5Iof6EcGTX6ZmEBe3uXJ9ifvre6hwQ2OpmqDeFEU1utbxgcRWtZsDqZUbE7o+5H4UhwG1qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naDkvey231Y2Brh2oieuJSuGvyggIBXSJVsvcCqdGBc=;
 b=BrQpEyO3qjQuPkQIxNbtDZew92GtWgeJY5GqY9aBg9GzsiVdYyrwhySceqmfihkEBnHgXbXJs51x/1lzG1QemKHr6DDpovIi9b2vlqcXOi13EEohEu6HPuMSnfiNgPgG45v49ujxd9vyJgmFpaNJd+jIRO0Knod/D8MK0jOr2vo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 18:53:35 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:53:34 +0000
Date: Mon, 9 Feb 2026 18:53:24 +0000
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
Subject: Re: [PATCH v2 05/13] mm: add basic VMA flag operation helper
 functions
Message-ID: <2om76rcawiyomsbuw2rkx6g7qlokiiykeloz66rmlszrfli7qr@dsxte6nykf3y>
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
 <885d4897d67a6a57c0b07fa182a7055ad752df11.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885d4897d67a6a57c0b07fa182a7055ad752df11.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3464ab4e-2852-42d9-a3f4-08de680c86f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6g8jVXxTdC1QKwreP2LEB0okbVanu1vS1JEIA2Dtvg7bLnon/aVaEVZGztn?=
 =?us-ascii?Q?fCE2yt6c7IdTbh76yv3vVlxSXew1trcVLHb/CL/2GBdNo5pnVcM4b96h1Ijt?=
 =?us-ascii?Q?0jBmwIbMP58ypw/od4DE6UoDsl37QvgEbVtOii+dlGQuNde8vAMv8AXetA6l?=
 =?us-ascii?Q?cbpuyv5XpfTspPgmpFzcayhKD7row7IgZ/OH7kNL+7Nn5wLz/Dg0d+u7IYpa?=
 =?us-ascii?Q?rZtybCbyOgK0nJuruEIZTN7Ix1x4S35t9UcosNt+XGDI2F6tL6hEqd8ocPUs?=
 =?us-ascii?Q?uUmjqoRk8/0TYqhluBCt2qpbPBJ5Jw4wRmLi71XTaxY+Eu+96DK78SZhOE9y?=
 =?us-ascii?Q?NfiFYbZcgW7qKZnvyMc7sktF2mPjzrE4FjTL0BYWtR8DpF7SeCez+UxBGOUa?=
 =?us-ascii?Q?AxB2552QGRN0UHYL+7ZfBRaiDrbzJfI9/A7RAJzKgbe7jJKohU1FIO+i+Df8?=
 =?us-ascii?Q?mm+LM9PxyT3lr6vWshnj8tab4Z+U2i3HMxJJIrqG22cuLlHkXCdzQvKc43K/?=
 =?us-ascii?Q?DjmQ8lnFCAdB4iur+XA7aQOck+Ho2XMMNCSVlkLal77d6WjrTGWDUAVbRc3b?=
 =?us-ascii?Q?XYidIwpntByXjk5Lp3GzNFa/J1kTNAJ4rs0eNXx9jwpo4JOFtBz65UdAYtVk?=
 =?us-ascii?Q?1mGsy+gGN1FTQo32oE/u2gUeWMKYlC4UbkJiVAkyMoar5Aec47OoOXLdF71q?=
 =?us-ascii?Q?fi/kWMa78PNLjOSfHJp6m+FDcNDeNiONRl5MJivwG1zPoZrFBbs+gmcInWZG?=
 =?us-ascii?Q?7dI0iHzfynwbkSp2E8OoR2kCEBLp4eD4B0//DYK/XImJnC/zlXK/Y790yCSB?=
 =?us-ascii?Q?5akQamnZhuxnUnDRFD1h8pvpDJnBGX7bd/ocglnUvQpBw3qkUaLUbb62jTjJ?=
 =?us-ascii?Q?6boxo2ms0kyqshx2ZcgDRvswHr1rc39kNMG3uIYapHP+4o2uEIAdiP/Igash?=
 =?us-ascii?Q?oj8g9j4pyVA2pYDxUY/jbWCyY7cyp/5hlht2XvddtCeGf4NJUHDa1LTEa2mr?=
 =?us-ascii?Q?zwwF3RtdRUC6l5mt8HjYqbGhxCVLhtZTw6jw9vpZmQdQuB6os/FeBmtLvL2b?=
 =?us-ascii?Q?pCGPUE9EhWc1ywuFAC6X3JYCMXOgEPCkDJvH3TZtoOxDWHKuJ+20JzTcqbrc?=
 =?us-ascii?Q?49Fc+uDyCKqGGtdlEuHBHs/RkYufKxmeWJivYP6nOJHgE4pruNZDo52Jb64u?=
 =?us-ascii?Q?Lp5r/TnKxjk4m5CDUd1AxZe67kzRWBw8Z2put+7CGDfBgORTeXg9ryMbBAHz?=
 =?us-ascii?Q?GtEInlAQ826sw0SQ2UzACsIVbQvkqmPvBew/P1Rz7yO8CsewBq2YIGpqriF2?=
 =?us-ascii?Q?QCDM3Fk5p5cBMlnDUuwdN7zrWD3CBH++wlN+dFto59q9zRZpdvbNM+C0CZ+Z?=
 =?us-ascii?Q?p9d58tEoe5eGSeEo58spf8vzIq6CYXepA3mgg1fLgPxC1tBgD31jJ6eHn4eR?=
 =?us-ascii?Q?2Q3yagMFcYpYQazOMTTyn9iYNv8+eSauQ1P4p3zEuKH1s9KjFWup0LddxmxZ?=
 =?us-ascii?Q?zRo7BeMJeoazDaOcCPxHfBl+kRdggd/3D7J4hyo0PTbcwStl3zASnGiU1ERH?=
 =?us-ascii?Q?UrC6JklUCtfTOojaWO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UrHCnG9yIHssYwnSu3lQ49yfhhCkEVgWQS/ShU/QwsJhWGEVUegkN0zZotAJ?=
 =?us-ascii?Q?NTBPctpDukR3tWVRbOGTzyYY9w5ZMUnb79qtDiQLNPCeM1w1DpdOVpbxXDrv?=
 =?us-ascii?Q?mPIqOOtasux7IJnfXshNSPuCEpbZ6mS0qTmcxYjroEg9c3KVOr8DB1CZQRwR?=
 =?us-ascii?Q?P4ej+4/HNk2WAO2tW1ER1WdkizJiLEqffxXenLIBsKQCUj6MLbtzSqnSmwzr?=
 =?us-ascii?Q?u8ZLomLBOuBGMGkqPulF12TYv1U/KvHfyl5SkG8IaHq8LhBje1yZJQ9fFauu?=
 =?us-ascii?Q?dsYN8FkikAe0pOrxMYSbhinAZdO/y4Hx7O4bQiVZG5ReXcnIneRNIJP9QwgJ?=
 =?us-ascii?Q?EbgXPlWKT8vSfusTUNDzb0SdDbpOdezYR294JPQShuX2o1Roh/sk2hMtp6Bm?=
 =?us-ascii?Q?YHMMjFAFBuqjZU5eFXref55s7fXMzeLcxcD3Dk0PpFymTw1YpPfnWMMqLjyO?=
 =?us-ascii?Q?XdHGhC6rX3R4rUcl+lvVMgUG9yHFF2ZHLkL/iJ4ZlF96Z+X3zzqHACfZ++/c?=
 =?us-ascii?Q?W1DgIyFIWG6AhbqKzEOLz0qfmSUd70MIoMKRlIt5APEkXcrJ0axYuUJvYMgO?=
 =?us-ascii?Q?/ciXHiWSi1AqpzGwmle1LSWvjAB//TUkibkSFc7KfGuFxOVFefvFJ7t7sLtD?=
 =?us-ascii?Q?eDj6oTEHDfjtId4WcwvPwjCEUEij3lzGir1HI8aaDBTS6Qr/esp2lW/bwlDG?=
 =?us-ascii?Q?BHmQwbPowpCoz+jAL7bLqep1LlWqGnB5LV+Wo9iaR+/JuUSOFNGLEcKfEsIT?=
 =?us-ascii?Q?y6nmOK1Uh03FVO8/t53vKlh/WRQkLE1X2jVujiIS4fZ3vEmrjSi6wU8OYqRi?=
 =?us-ascii?Q?Nc5/boqkN8wbBwxYktnMPvDw+CLuInSe5WU0roJ0gQF4oNap8GiXEeFaj6pQ?=
 =?us-ascii?Q?i/e2U1GzKVGrwcpoAAg51x98VaaPSua4yl2fY+1MUUCMzHsY50NOg+IP1lBk?=
 =?us-ascii?Q?ma6PNVtsfIjmvhB8wreZSGexoGMc6PoPRH9R1uyq5xGvbD43E+3DqtTydgTU?=
 =?us-ascii?Q?877PIgQxiJchH1h52X1mP+MzA1wUSn74uQeD50JrqltjwhgrDmorQQ8FJrsl?=
 =?us-ascii?Q?7/yR3Hlva9w3/6iM9qVQyFvq2ESm4E1k2izHGrbfxM8lOP+0YdpO5tL6JL7U?=
 =?us-ascii?Q?eeu2uxmL3oTKoltGdN8xAeejTAOyA/Q1bfWBESvxqr64Ua9Ijqwyhedm5xso?=
 =?us-ascii?Q?eAGy1yPVgDbe2p0bnrjN+cIhC7IySQRPCMdf9m7GGLOM/53JjMSC0cbCS8Fg?=
 =?us-ascii?Q?D3YucZjluVIQ1lcbo5dVxySE9/a7sc8n6C4Dl2U8h68ZDmaXLrDEMR3+UMHn?=
 =?us-ascii?Q?O5MOy1bCS61MLJMzl5R19wqBXn2cwDEjCgDj9Nra3jHgebqWBrD5BvfE+2SD?=
 =?us-ascii?Q?dCq6m3jrcKQcr2jYgXAmqkmF/huYLDmdQni9RhbfI7dAv/Fgl2XBmu4M/FLw?=
 =?us-ascii?Q?AzD0fYpOPHZM2WhmbGMrm6oZVbq4QLdEJ3boTQDeBzKgTXx1qbp1xuZUGUXj?=
 =?us-ascii?Q?dmCC2/61vjqc4wn5Yde+q8NkUGaSXMaL2LVKPzKi/2QA17J11fpCtqS+yTst?=
 =?us-ascii?Q?0q1R1B1Ir3U/dC1iZ0QdHwYgKYDhOBkh9PDUU84u+bzDQotS2+vkwEupfgQb?=
 =?us-ascii?Q?S8l41qfvkXbZdntFKOJbUGRK9TaD5O69bJNwMYNQoOHyIl9RbF24pXma4xm9?=
 =?us-ascii?Q?bBXsEinUXYdB8pJfT9/ydhteB1RQIzh6ksyZBrDilDvdTreD0FRz5JyuARr8?=
 =?us-ascii?Q?7Uh8jgt3xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	as70Prw2w3ypMp+lXg47B35J6TGFT2NnBKH9TfaHcGYaYKLA0O5E2Ue9CSpLKb7ACLJqMiRj24/St8saszScL8AR5x4Do+Dqlm1FBExWaBxBudep0otWveC0la+RU9cIq5lfVBizPU14j1eSFAUki2nqaqLKdpLptKQh5JQRHVzgRIsRZGS1Xsqlg6jpoU7jwgaGDFhbjN1mRojSDWTtIl+Hfo/5JbZztaBKT/Ne0PP6nM1AQHD8pA9aGIdcTPguP8PL6RVIkr0yvpLyrQdHpdn/NhsUT/Yt6LRTCctqnhcqFjn59zY1p2xMoDMKjmaR698vlwDxZJlnKro0kpOxJNCyR7045WmcenkqKgPTlC+VsgpzH5QcyugbslUjtjipGvwrweD5h20H0vajoTn6rhRFb1gv4dsdXwfjgiBpr5LMM3Sg3XK1z10a8ozg/0oXEjj9KVLk7W4TgHtQMz0DA3WzgwdhZvUpuAj+VekaTjp17V5iTUEkBvAK5xpMEh2BHZ5MOfRmjZVEEpN6uutzU+iWLSerEh5Ym9eOnEsb4IvDzY1XNZee2zaSLtWB6vwrRHW5X8NLM93aXaA+KN9ezf0snpKmzlgs/BPu4QujaWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3464ab4e-2852-42d9-a3f4-08de680c86f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:53:34.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGTHY1PdiwgjXElbdhm5D8NTdKH1xmj3DzYNhykbFmNOvbvWMZU+FIhDSUlvzgwwa54UDtK8o4f0KFCu4KOj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090159
X-Authority-Analysis: v=2.4 cv=Adi83nXG c=1 sm=1 tr=0 ts=698a2d37 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=wDTHRsybKcQ5a2_TUZMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JNLdQwgJNqSzOZSSz5d_WH0Mm6l5LKed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1OSBTYWx0ZWRfXxsQpC5C6md2T
 Ecd6gfLrk5xjk55zGsY6++kkd0wqjEB+vZ4bRws1o0U6Kd+K8yg4QBVsZBNxI7oRrprS73Kle9v
 DRtncdWX/HxgSiqaPZyS9FhUXCfGM/PKIWPrmYEWqqb3PN2DSbGKXeQgcHtZTj969B07Z3rqjK2
 PoDu7ZZy9dfPM3dJDnKH0++shGo0Tx4nT2N1vUCYHco4iANubXIdlW1GxtmW+mzjW7DsXzaPmKj
 B9cF3xBhj0rcOXFfukv5CDGbSkvjW8WE6ZH0nwtsakITfRe69zhTm6CXiM1k2t9Am1jvqP9WE1Q
 udbpuphBOZpWG8o1pigBf3KByYBWFhCPg6EubyVA6xEw4xsxB/FZw8rbbojkCVizlhlLgfb36KK
 bdt973/mMAakJoxrYjKRdekDCEJduIrDDxI4rlvYGyj/kRNVSoyYppc4w7H2otKaJUL7ILVqFsK
 Ez5QX2s+0QdO7lyGvtg==
X-Proofpoint-GUID: JNLdQwgJNqSzOZSSz5d_WH0Mm6l5LKed
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76733-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8951D113E2C
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> Now we have the mk_vma_flags() macro helper which permits easy
> specification of any number of VMA flags, add helper functions which
> operate with vma_flags_t parameters.
> 
> This patch provides vma_flags_test[_mask](), vma_flags_set[_mask]() and
> vma_flags_clear[_mask]() respectively testing, setting and clearing flags
> with the _mask variants accepting vma_flag_t parameters, and the non-mask
> variants implemented as macros which accept a list of flags.
> 
> This allows us to trivially test/set/clear aggregate VMA flag values as
> necessary, for instance:
> 
> 	if (vma_flags_test(&flags, VMA_READ_BIT, VMA_WRITE_BIT))
> 		goto readwrite;
> 
> 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT);
> 
> 	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT);
> 
> We also add a function for testing that ALL flags are set for convenience,
> e.g.:
> 
> 	if (vma_flags_test_all(&flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) {
> 		/* Both READ and MAYREAD flags set */
> 		...
> 	}
> 
> The compiler generates optimal assembly for each such that they behave as
> if the caller were setting the bitmap flags manually.
> 
> This is important for e.g. drivers which manipulate flag values rather than
> a VMA's specific flag values.
> 
> We also add helpers for testing, setting and clearing flags for VMA's and
> VMA descriptors to reduce boilerplate.
> 
> Also add the EMPTY_VMA_FLAGS define to aid initialisation of empty flags.
> 
> Finally, update the userland VMA tests to add the helpers there so they can
> be utilised as part of userland testing.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h               | 165 +++++++++++++++++++++++++++++++
>  include/linux/mm_types.h         |   4 +-
>  tools/testing/vma/vma_internal.h | 147 +++++++++++++++++++++++----
>  3 files changed, 295 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 32c3b5347dc6..fd93317193e0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1059,6 +1059,171 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
>  #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
>  					 (const vma_flag_t []){__VA_ARGS__})
>  
> +/*  Test each of to_test flags in flags, non-atomically. */
> +static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
> +		vma_flags_t to_test)
> +{
> +	const unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_test = to_test.__vma_flags;
> +
> +	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Test whether any specified VMA flag is set, e.g.:
> + *
> + * if (vma_flags_test(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
> + */
> +#define vma_flags_test(flags, ...) \
> +	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +/* Test that ALL of the to_test flags are set, non-atomically. */
> +static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
> +		vma_flags_t to_test)
> +{
> +	const unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_test = to_test.__vma_flags;
> +
> +	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Test whether ALL specified VMA flags are set, e.g.:
> + *
> + * if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
> + */
> +#define vma_flags_test_all(flags, ...) \
> +	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +/* Set each of the to_set flags in flags, non-atomically. */
> +static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_set = to_set.__vma_flags;
> +
> +	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Set all specified VMA flags, e.g.:
> + *
> + * vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> + */
> +#define vma_flags_set(flags, ...) \
> +	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +/* Clear all of the to-clear flags in flags, non-atomically. */
> +static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
> +
> +	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Clear all specified individual flags, e.g.:
> + *
> + * vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> + */
> +#define vma_flags_clear(flags, ...) \
> +	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +/*
> + * Helper to test that ALL specified flags are set in a VMA.
> + *
> + * Note: appropriate locks must be held, this function does not acquire them for
> + * you.
> + */
> +static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
> +					   vma_flags_t flags)
> +{
> +	return vma_flags_test_all_mask(&vma->flags, flags);
> +}
> +
> +/*
> + * Helper macro for checking that ALL specified flags are set in a VMA, e.g.:
> + *
> + * if (vma_test_all_flags(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
> + */
> +#define vma_test_all_flags(vma, ...) \
> +	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
> +
> +/*
> + * Helper to set all VMA flags in a VMA.
> + *
> + * Note: appropriate locks must be held, this function does not acquire them for
> + * you.
> + */
> +static inline void vma_set_flags_mask(struct vm_area_struct *vma,
> +				      vma_flags_t flags)
> +{
> +	vma_flags_set_mask(&vma->flags, flags);
> +}
> +
> +/*
> + * Helper macro for specifying VMA flags in a VMA, e.g.:
> + *
> + * vma_set_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> + * 		VMA_DONTDUMP_BIT);
> + *
> + * Note: appropriate locks must be held, this function does not acquire them for
> + * you.
> + */
> +#define vma_set_flags(vma, ...) \
> +	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
> +
> +/* Helper to test all VMA flags in a VMA descriptor. */
> +static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
> +					    vma_flags_t flags)
> +{
> +	return vma_flags_test_mask(&desc->vma_flags, flags);
> +}
> +
> +/*
> + * Helper macro for testing VMA flags for an input pointer to a struct
> + * vm_area_desc object describing a proposed VMA, e.g.:
> + *
> + * if (vma_desc_test_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
> + *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
> + */
> +#define vma_desc_test_flags(desc, ...) \
> +	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
> +/* Helper to set all VMA flags in a VMA descriptor. */
> +static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
> +					   vma_flags_t flags)
> +{
> +	vma_flags_set_mask(&desc->vma_flags, flags);
> +}
> +
> +/*
> + * Helper macro for specifying VMA flags for an input pointer to a struct
> + * vm_area_desc object describing a proposed VMA, e.g.:
> + *
> + * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> + * 		VMA_DONTDUMP_BIT);
> + */
> +#define vma_desc_set_flags(desc, ...) \
> +	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
> +/* Helper to clear all VMA flags in a VMA descriptor. */
> +static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
> +					     vma_flags_t flags)
> +{
> +	vma_flags_clear_mask(&desc->vma_flags, flags);
> +}
> +
> +/*
> + * Helper macro for clearing VMA flags for an input pointer to a struct
> + * vm_area_desc object describing a proposed VMA, e.g.:
> + *
> + * vma_desc_clear_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> + * 		VMA_DONTDUMP_BIT);
> + */
> +#define vma_desc_clear_flags(desc, ...) \
> +	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
>  {
>  	vma->vm_ops = NULL;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 592ad065fa75..cdac328b46dc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -844,7 +844,7 @@ struct mmap_action {
>  
>  	/*
>  	 * If specified, this hook is invoked when an error occurred when
> -	 * attempting the selection action.
> +	 * attempting the selected action.
>  	 *
>  	 * The hook can return an error code in order to filter the error, but
>  	 * it is not valid to clear the error here.
> @@ -868,6 +868,8 @@ typedef struct {
>  	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
>  } vma_flags_t;
>  
> +#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
> +
>  /*
>   * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
>   * manipulate mutable fields which will cause those fields to be updated in the
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index ca4eb563b29b..2b01794cbd61 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -21,7 +21,13 @@
>  
>  #include <stdlib.h>
>  
> +#ifdef __CONCAT
> +#undef __CONCAT
> +#endif
> +
> +#include <linux/args.h>
>  #include <linux/atomic.h>
> +#include <linux/bitmap.h>
>  #include <linux/list.h>
>  #include <linux/maple_tree.h>
>  #include <linux/mm.h>
> @@ -38,6 +44,8 @@ extern unsigned long dac_mmap_min_addr;
>  #define dac_mmap_min_addr	0UL
>  #endif
>  
> +#define ACCESS_PRIVATE(p, member) ((p)->member)
> +
>  #define VM_WARN_ON(_expr) (WARN_ON(_expr))
>  #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
>  #define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
> @@ -533,6 +541,8 @@ typedef struct {
>  	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
>  } __private vma_flags_t;
>  
> +#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
> +
>  struct mm_struct {
>  	struct maple_tree mm_mt;
>  	int map_count;			/* number of VMAs */
> @@ -882,6 +892,123 @@ static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  	return __pgprot(vm_flags);
>  }
>  
> +static inline void vma_flags_clear_all(vma_flags_t *flags)
> +{
> +	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
> +}
> +
> +static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +
> +	__set_bit((__force int)bit, bitmap);
> +}
> +
> +static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
> +{
> +	vma_flags_t flags;
> +	int i;
> +
> +	vma_flags_clear_all(&flags);
> +	for (i = 0; i < count; i++)
> +		vma_flag_set(&flags, bits[i]);
> +	return flags;
> +}
> +
> +#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
> +					 (const vma_flag_t []){__VA_ARGS__})
> +
> +static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
> +		vma_flags_t to_test)
> +{
> +	const unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_test = to_test.__vma_flags;
> +
> +	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
> +}
> +
> +#define vma_flags_test(flags, ...) \
> +	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
> +		vma_flags_t to_test)
> +{
> +	const unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_test = to_test.__vma_flags;
> +
> +	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
> +}
> +
> +#define vma_flags_test_all(flags, ...) \
> +	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_set = to_set.__vma_flags;
> +
> +	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
> +}
> +
> +#define vma_flags_set(flags, ...) \
> +	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
> +
> +	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
> +}
> +
> +#define vma_flags_clear(flags, ...) \
> +	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
> +
> +static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
> +					   vma_flags_t flags)
> +{
> +	return vma_flags_test_all_mask(&vma->flags, flags);
> +}
> +
> +#define vma_test_all_flags(vma, ...) \
> +	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
> +
> +static inline void vma_set_flags_mask(struct vm_area_struct *vma,
> +				      vma_flags_t flags)
> +{
> +	vma_flags_set_mask(&vma->flags, flags);
> +}
> +
> +#define vma_set_flags(vma, ...) \
> +	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
> +
> +static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
> +					    vma_flags_t flags)
> +{
> +	return vma_flags_test_mask(&desc->vma_flags, flags);
> +}
> +
> +#define vma_desc_test_flags(desc, ...) \
> +	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
> +static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
> +					   vma_flags_t flags)
> +{
> +	vma_flags_set_mask(&desc->vma_flags, flags);
> +}
> +
> +#define vma_desc_set_flags(desc, ...) \
> +	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
> +static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
> +					     vma_flags_t flags)
> +{
> +	vma_flags_clear_mask(&desc->vma_flags, flags);
> +}
> +
> +#define vma_desc_clear_flags(desc, ...) \
> +	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
>  static inline bool is_shared_maywrite(vm_flags_t vm_flags)
>  {
>  	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
> @@ -1540,31 +1667,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  {
>  }
>  
> -#define ACCESS_PRIVATE(p, member) ((p)->member)
> -
> -#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
> -
> -static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> -{
> -	unsigned int len = bitmap_size(nbits);
> -
> -	if (small_const_nbits(nbits))
> -		*dst = 0;
> -	else
> -		memset(dst, 0, len);
> -}
> -
>  static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
>  {
>  	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
> -/* Clears all bits in the VMA flags bitmap, non-atomically. */
> -static inline void vma_flags_clear_all(vma_flags_t *flags)
> -{
> -	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
> -}
> -
>  /*
>   * Copy value to the first system word of VMA flags, non-atomically.
>   *
> -- 
> 2.52.0
> 

