Return-Path: <linux-fsdevel+bounces-76734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA/LK9ovimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:04:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31295113ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48793028B07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157B41B347;
	Mon,  9 Feb 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9dCeIlQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E7622hDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE22E764D;
	Mon,  9 Feb 2026 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663878; cv=fail; b=pDmfTpN4eIzvzc9uXfdW2uDyuJeAZax7kiMAV6XBwuX6WNAGE0pxNZDiAfjUVih8lwQNcI3HPg6SLMSdzILIx0zvQeIMd4W5erSDIWmx0lbooH8At+7LheBn4Rs9oS8hQwYXgT2gmdFnSvU8Y5KvCZjFy4R4LLzhwlbGI1mgT+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663878; c=relaxed/simple;
	bh=ZCBxKrOxWqYhG00fBa5rUS7KWO7dcVarwIfQ2hE1ZpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ah0QDazud7NGko9WixJV5uF66qBZPzbknMvfhuPnv2hggj16n2zTd7HGn/pn7v9F5XzaGkbmsxSZfoYqFW7KrSeb+HoZ7F52OszIUCxJvFLE51ABgIDAOXhkTtlXYJcbpp+rAR9j9vMoxJIlNwcgAIYsXXi+tiDJMY1MoZYH3/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9dCeIlQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E7622hDZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECe4m2021317;
	Mon, 9 Feb 2026 19:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=47za6/PseRwTs0BG5d
	iKjUxwnd1BNhG1DQa5AU2bBl8=; b=r9dCeIlQeNgv/EBUhZ860WZDwlq/h0xQBZ
	be3uQOuQ2kZow8waEi9BTZ03vig1A6Qlct5i9S2yykcjwEQwFH0b0fDKwcq+wNp2
	eN488/GGWcZtdqPqaVZMdex6pyaO0Ifsvnmi+1n1d7KRbPY0qE906GXU66LpEGxQ
	niouWx3sVr9OSNgcFw3p+etbg6kstTnW/TMzOKSqfHJomxIbeYdQ4NncWd1+ZuxD
	mbYUK6EYn+qWmXJy/bcUNezVHV3G813WX3DwT3IexbpS8+2vCzxmf3T9aYJtOZmY
	aaLxpq9Djs1xaP2Scx6waW/llU7EksyXHWgb5WTAoG7w+1k6lbOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp2jmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:03:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619Iuocw040506;
	Mon, 9 Feb 2026 19:03:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uukd5m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT8R7e86yo/JfSoJP2/vrcbrJxRiy5m2Oow93SNM3+8RWkWeR0RKF8PxziOs+nevlU0vw0S3fUYNCj+r6ENxwCHwWd3ABmJUGNENuLqmqekSkorXfBaBi7zaiv7NMolL2xFgtzXFFYpWB+/hh1wnRsc3LbFFZROGo4MS1Hsqp1l544W3AAg1H36jMWn7XhOE/RAf0K0Q6DPxPqeI4osln5NqNiqJ555Sy8NaMQWeTQy56D0MuAp4o7/LHo+79v2t10yF1hgYwklMDdONNCpZP7UU5yWuipY9uE0WO38Nkyhn1Z+ri09DHvL0mpt80X4THkcAaKMn2sR8b1tSYMeMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47za6/PseRwTs0BG5diKjUxwnd1BNhG1DQa5AU2bBl8=;
 b=IhiCp+e6jesN3KfZyM4bLHb9ZfIr/UwvztOUapU5vggsm2l1EagqPtR8OiuwBzOu6FYi2F9Cc1vxEdPaIQWbofLIJW09bcJGI128fkh+G/CMFiQMXmPlTF3WXptIykFn3XTsZ46I0cJnSrHJy7sfVUfpKmfxK8SNCS3kHmkaf9rc1HBOoW0FY6TuiEpj//ftbVKEFz+f/z6zdRzkBPU6ct3IGZPT02k4NaN74Fnzu1VUC3vqNoIaiW2Gp5w+w5fnCXUSv7Fns0Mvfhg2pDHbLTM4pJdlcCdxYwZUET/M7saHL5WxBS9gEB1IoPMA2fYSVaOh2eKD56GKO4BsFzrS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47za6/PseRwTs0BG5diKjUxwnd1BNhG1DQa5AU2bBl8=;
 b=E7622hDZ0llvoekzniuyxKpg3CPd3n69USZR796cl4B+yIKYRaLZfxPOYNRU0iEOiO6Pe3rdSg1X5M4xABTo56hp6kvvG4j9BaadcA/+mm5aIzJ+Ke8kIaV1V92u8pwhQZXvgCJWAapr2NkM6Gl2QHQ899qMfSj7FXqoars1zb4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6705.namprd10.prod.outlook.com (2603:10b6:930:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:03:32 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:03:32 +0000
Date: Mon, 9 Feb 2026 19:03:22 +0000
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
Subject: Re: [PATCH v2 06/13] mm: update hugetlbfs to use VMA flags on
 mmap_prepare
Message-ID: <acygwc7cwbwpl6imyzeupkqdfba7gu6grs25ekrscvmncmbi54@dnlwlmwlz7lb>
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
 <9226bec80c9aa3447cc2b83354f733841dba8a50.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9226bec80c9aa3447cc2b83354f733841dba8a50.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fe7459-fa2e-45d7-0a39-08de680deb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwXVd9jmvDYInPd5fq+sTxoT5OLplvI/GXmC65qG/HzksogHZ5fFQrTofRVe?=
 =?us-ascii?Q?dGJdXhqYJkXjfVkjxO7i7omxb11jBjkq7CBYhpatxP5f7Mnam4xPaN9oyvKQ?=
 =?us-ascii?Q?17tQWT4So+cI3FP5XPlpiSPBrXyTC36qTjbJY5Zbz6dU3tycxIaqJ7CLiU3S?=
 =?us-ascii?Q?eEiU2Zpg2naf6xuMDZ069/QXCxUJK/UeHBAdTuoJnoyjCiF+lHVTnqSvhrUu?=
 =?us-ascii?Q?ieQlpTH4mHvv8XqagljZ/0bXEFlYdxuWDuRzY/peS0HxDlUVLNIpp8s0/3Vm?=
 =?us-ascii?Q?+TaOyAVAramzgaggCYUPkUj3VQ8FYzxyV8MyJJlQXWrfBltuVDbTKn4R8w5I?=
 =?us-ascii?Q?pnYL0qWhrkowZTM9sQmVss3MzgxEY7m4z6k0Eu/rH2YZzKq+Cp9IlkE+VygB?=
 =?us-ascii?Q?BPZf0up7va6P6y554eyMd6XRnKsGqR8cIG1l1XQAGAh9MJvPhENdipdkdRXi?=
 =?us-ascii?Q?OYlAZ35y1o56o96tzAJy1HokqRfVARSKopndeRgoR6IrmQAk5QJXR1fSv9ys?=
 =?us-ascii?Q?CnwrQ0A95m5AYzPs3bO74/g/kGoblZPOR70bI/K8SThWPAwaiZMu9j5ngT/u?=
 =?us-ascii?Q?Tg24266cYH5xGVqRKsNdV+JPVNlB3PrDC3v19sFAyVSNLf7ldGm6Blk0X3Am?=
 =?us-ascii?Q?aox/+pp/llJV6jWEmRToMDMMYj8u2h/5uCgJ303EDY4YHDodK9G4koozuJxB?=
 =?us-ascii?Q?IoEAlruqs3PlYJb3bpqU6BGm/6qPzJZJ7BIBIlRdrpTbel1iLhIPU+DMD+uB?=
 =?us-ascii?Q?GnjvL9ECdPTeQMnMzkeS+9ecNUwkR13DT5ed0WPqzE4Y2sv+kz3Tjp0Z/9oQ?=
 =?us-ascii?Q?P01ezKJhoFAbPdiHsD5rHsfC5kbcvd3o5mdl05rUXi/V0NLhtCt11JbmqCU+?=
 =?us-ascii?Q?Ocb38eSuq6rxhH12+xTagqv9bkA+da5QQehKmJViu5FJxllmua/iWFr3Ktkm?=
 =?us-ascii?Q?tNaowJB6RolHBKIDQlIW8uKBJkm4KfFON2q3hDuk5iMUZwX0EQbCnosjbckr?=
 =?us-ascii?Q?uYAaj7Loy5WEPNOCZaV+1w0vDUd4/JW6Cdf8oF5/3jIWXq6cykVfECRO7f8O?=
 =?us-ascii?Q?VF3kSpyXPXLcH8y7EqMNdFZtVipzx29pAqKPRSbUv4p4SpF9PfUBla/MzRCz?=
 =?us-ascii?Q?DmoLd0Q5NA3gso1C0eLX6YFrrWNSnM+duPsLWjoLMJod0M9qUhYt9DpCD9ab?=
 =?us-ascii?Q?UezofRrJ94hL0HH6vRwag+FgUak7qfkaqEENYc9TkSI9z8gxyMipWWnstVwK?=
 =?us-ascii?Q?EL4HvldQeNTlNRPaCkc8D3c5UK26T+dt5O4w4NJfqXCcktN5sRXPwDC559p1?=
 =?us-ascii?Q?pRSKZBwIHmYeKXS1gGTxsF7plsYY7uAauD84GSnpE+JKFdj0TW8W6cCz4GCA?=
 =?us-ascii?Q?mcsxnMWv27QNoKaz/FvFspFEHfC1YWA7ekvpykiME9FOjsmgH3LwlkwLjN6h?=
 =?us-ascii?Q?5SHBBIkzlqvzGhW5d9nyRuZ5o4ZARRpUAUQ1clfclOSTrjk3CsHJ71kPtY9N?=
 =?us-ascii?Q?j1RVG/RfnV8jlfXc2nvVNEGnCdf0Cv3xGGv7o1ZDU0HLTl46BkQ2Ea2JiNrr?=
 =?us-ascii?Q?I2fZUCciGnO6SW633iA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGER562oCtrJIm4JeVZmNEinYgP2v9tvIjEtqSTTBdtHqZtL2OG2ywJi+HHb?=
 =?us-ascii?Q?G71Xuots6K8wQASWQfKGztRH2PdcCV0hTZziFEmuB3zXf7VV9S96kqhJZL+v?=
 =?us-ascii?Q?YOtZICsqNluzw4+sWuD78/WXW3dH02chcUQXxKKXLbEK8iHirmoD4f0YTHtv?=
 =?us-ascii?Q?K4OzKNd8RQI6z5wT0xWu6OxSFIpGdDhjQ5vP+igGl47h3ruKzDp5P7iRjFoW?=
 =?us-ascii?Q?XqHEkiBx1OOcXa6EI1nPrZC0yWsXTtJQr/4dg/wmPI5op4R55EqU9dJyUGXO?=
 =?us-ascii?Q?ozwuE5+kyugxbLcrBAzl7XBgmxPw32TGiMqu/n6fgyAF0JvCdwWO6+Ppfzel?=
 =?us-ascii?Q?4SCcFZBKPgreSqk8N5KIx7tN6JtiJcmASmPaGypGYEg+UbgJ5A0x6ZwJzk2w?=
 =?us-ascii?Q?ZZIORPrYUHdsEewmdBiE+oqB8PpR6Wf8PJJiLo2jYqvjfZttr0Ym8/Gh/f+S?=
 =?us-ascii?Q?bgCc2DftuuNozK8yre6aGj1pEtLknFXxbee+NJV2kEtep5c+T8RN3BJIXhYm?=
 =?us-ascii?Q?Ud3xNPmgAVa/Qn4VHveC2B/gRXrsEWLyrOz8167JjyxocPVw18X9RovMhZGO?=
 =?us-ascii?Q?6GOErHD5lN8mk7wvefAxrM1PTpQbZWLz8MisEESqbFjCknjgGAlTu0XOqz7F?=
 =?us-ascii?Q?+Aezykh1luyRJS4Skmsz4ylZ5KjJZWfLlQZ7hzM/AAQrcZAvOVtwf0CyzN/3?=
 =?us-ascii?Q?myFjuKjtpe5JGAdypbKwDn6NMILjppm1OA2vkOWq4ve6wHrsw5cMsfaUpBz5?=
 =?us-ascii?Q?qjMAQSX9X9WjiA0pbX1+UedqRczFwK7LrWxC01wSDfGKMRUczumCfv5zEsjv?=
 =?us-ascii?Q?31A0nNqbYMAze3z0CjIRgAgjhVbd8wxyHsjAnh4lExiMR50I4fkj/igPfSkn?=
 =?us-ascii?Q?6Y+ioP8I5HqziUpSx3iXiT91nkthR6enPrHqRKEaKSbycSqLl0KzPzPofmk/?=
 =?us-ascii?Q?xBzeNCerbsFL0GRNE2SoxX8OJ7DMcvLbVUlU0kQ7UjN1f4JkQTM/KetyFYZz?=
 =?us-ascii?Q?ZIyijGKFlRK45wdB6ex0bA8UIGUf6gt9qoQRZrShkzr2GXySPYlX2OwwSaul?=
 =?us-ascii?Q?ZwXFya4YcuOX6xdIGhzrTjCqzracgw4v91NFGFOLKQh2yJMWenuobX9P93n3?=
 =?us-ascii?Q?GFMqUPGH/whlzsre059HLpnmcHzwkZSQdZduFuq/v2xPSdxKAagdzHmgaof9?=
 =?us-ascii?Q?23JBlaLrzqJoJz7PnnjcqnRt1NX2DghSk6M5uI4n4/YNSXOLLb9id2Uj+DiI?=
 =?us-ascii?Q?4YNSDaKJ85nXvdlSgEKry4PnYJg4LpnoeMHnqRpkDtboyVZ3orStDSo7MUrI?=
 =?us-ascii?Q?5BPQPdKVVzzrlhaOnrv0P9dh8FpLahdzqZpUKQjHLTc3sHKBlJNr1AhJ24AQ?=
 =?us-ascii?Q?kLuLmX+MrZ3H3b0BFYuSNNO3esLoST3D/M1wmX+rhfkMT8LFTFQov357g8Dc?=
 =?us-ascii?Q?fBQcqxOpt+mpmHidcZ9Naa46yk75y7iXWIqsBr9TAjFTRlu23MVXBFZJkIi/?=
 =?us-ascii?Q?qzjWzvCda7updnW5vhfj3ev2r4ajF2LTH/we54NxFnbqwQQ+WqDGtoYibfWi?=
 =?us-ascii?Q?HkLyC3av6RYsHKIBpKPvGDHjoQhAvgkNlxEd4ZzOimxjab/Gjuitqq9Yj7IB?=
 =?us-ascii?Q?CuyMGxArJ0ivcucP8mmuNV1k0f+/OhyHqvqBP09B1g8R5gEu7Uu7t9zMdL/o?=
 =?us-ascii?Q?kxt6F2LeQ9XXss9RrPvNJujv760K48cY1IdOmcB1uzKcA0U0h8uH2TxCtYFf?=
 =?us-ascii?Q?Kl/D3iomOQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0gyBgQetU8nIBBGH+sg/i29zGQPQXSgFOlDFsQAVGlKobQZi55eJ8N/xx3hlQLaiQYlhzZd4HOCbDfr8yjHgmtU1mQg/pbbY/RukLMnkfYMVHII7lc2oaZmpzDJFZkaC/3y5oYmJ0ktgaHlwd3CiII8/wANUVMpamXgzg1ksrhBaUBsuwNVglrbXJLxGZQSR84wbVnP+dBhmfJ8rbmKORE85hLYwVZG9SEwlPji3Zy1WaIXG3b7eOysi6jrvvqKpJzg2rKQTUVBCh550REmhNAyGnCbHBH89Jx5YokG6jfRw2Ven4vzi9rBEk4aZCRCeA7w6Z+2xkLDgVqzVNHcypQEcJyAN+mTRh/hRSfYZW6LJ/qUYehnfKkJQPxZEuyOzoTK0fpb4Leat4z7DWt9ikmfGGLHNLVCyJIgzvGXVIfYVYkleLMC4qRtwZTTpijaru7buGzzHkHzCD+7Z7GbGN9ztoWPy5lRyc+EaxkRFTHeT4rKIhLABmKahudtucWL/oyILSkkg6MVFiMcNQ5xHl+RZu8VfFIttqGdtaSyJgRkrbGfSxNuoYTqLWx7XLBHT5hzv5m4lW3IcnFmCA13SfpZffssjLA1527NTY/OQqxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fe7459-fa2e-45d7-0a39-08de680deb1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:03:32.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfXzqCGjMnODEbc3KMhbKF19PWnUSjJ80icctmrvPSTnqopzkAwzSJynv5Q4ZwO5O8d41MRP+UWUqUmr/PlacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2MCBTYWx0ZWRfX8DL1ltu//BSU
 2Gu6NY1BFDGoa8TbZT3kKt0aRWvn3tKbQyALwIXzc1NZ5zaYz2UHkMYnyrugwspEdJa0bm2nJ2h
 KdhxJdiSK/XenFNrUdAGsKUvk4e5yylOuQrZq5wbCuPmJ7fa/T/2OshB+zZh/EScrbF/+EV4c9O
 AC5bxP3iGfkLAc3/oTek8a8CA0YgRRtdFnRm55J+LyYRVNtgu8meQ7Ls87fex6qqn5YRBO0ckis
 IyOBrUjnm8+xbRMiDZOQtgWFHZ3Ljhwi562UX4jkEJA/WmTnrELr+fmykgCDYxp/YvjJ1QQb6P2
 56mg1sTmDr4LvNxmmMmYSButjcl09bNKUyRX5pr5ch/A41VBvI1pbbNwvtbl9OCZ/3Hx/j2xISk
 PzAyg1brCC/7OACOGqfoBAmP8EaEWN+FBdFLLAnFfCRCNYVycrGSji1Qyn4lHRe2xpUF9O76Mkd
 3rOFM/ggoZCNZuz7GjunDaCSMj0B3tsHnS0ZqtOs=
X-Proofpoint-GUID: fv7M6aYAwuda2yW3LWodq7XgywuZrOdx
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=698a2f90 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=fO-ab8wNpyfSRgwpqn4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12149
X-Proofpoint-ORIG-GUID: fv7M6aYAwuda2yW3LWodq7XgywuZrOdx
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
	TAGGED_FROM(0.00)[bounces-76734-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: 31295113ECE
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> In order to update all mmap_prepare users to utilising the new VMA flags
> type vma_flags_t and associated helper functions, we start by updating
> hugetlbfs which has a lot of additional logic that requires updating to
> make this change.
> 
> This is laying the groundwork for eliminating the vm_flags_t from struct
> vm_area_desc and using vma_flags_t only, which further lays the ground for
> removing the deprecated vm_flags_t type altogether.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/hugetlbfs/inode.c           | 14 +++++++-------
>  include/linux/hugetlb.h        |  6 +++---
>  include/linux/hugetlb_inline.h | 10 ++++++++++
>  ipc/shm.c                      | 12 +++++++-----
>  mm/hugetlb.c                   | 22 +++++++++++-----------
>  mm/memfd.c                     |  4 ++--
>  mm/mmap.c                      |  2 +-
>  7 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3b4c152c5c73..95a5b23b4808 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -109,7 +109,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
>  	loff_t len, vma_len;
>  	int ret;
>  	struct hstate *h = hstate_file(file);
> -	vm_flags_t vm_flags;
> +	vma_flags_t vma_flags;
>  
>  	/*
>  	 * vma address alignment (but not the pgoff alignment) has
> @@ -119,7 +119,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
>  	 * way when do_mmap unwinds (may be important on powerpc
>  	 * and ia64).
>  	 */
> -	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
> +	vma_desc_set_flags(desc, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
>  	desc->vm_ops = &hugetlb_vm_ops;
>  
>  	/*
> @@ -148,23 +148,23 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
>  
>  	ret = -ENOMEM;
>  
> -	vm_flags = desc->vm_flags;
> +	vma_flags = desc->vma_flags;
>  	/*
>  	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
>  	 * reserving here. Note: only for SHM hugetlbfs file, the inode
>  	 * flag S_PRIVATE is set.
>  	 */
>  	if (inode->i_flags & S_PRIVATE)
> -		vm_flags |= VM_NORESERVE;
> +		vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);
>  
>  	if (hugetlb_reserve_pages(inode,
>  			desc->pgoff >> huge_page_order(h),
>  			len >> huge_page_shift(h), desc,
> -			vm_flags) < 0)
> +			vma_flags) < 0)
>  		goto out;
>  
>  	ret = 0;
> -	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
> +	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
>  		i_size_write(inode, len);
>  out:
>  	inode_unlock(inode);
> @@ -1527,7 +1527,7 @@ static int get_hstate_idx(int page_size_log)
>   * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
>   */
>  struct file *hugetlb_file_setup(const char *name, size_t size,
> -				vm_flags_t acctflag, int creat_flags,
> +				vma_flags_t acctflag, int creat_flags,
>  				int page_size_log)
>  {
>  	struct inode *inode;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 94a03591990c..4e72bf66077e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -150,7 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  			     struct folio **foliop);
>  #endif /* CONFIG_USERFAULTFD */
>  long hugetlb_reserve_pages(struct inode *inode, long from, long to,
> -			   struct vm_area_desc *desc, vm_flags_t vm_flags);
> +			   struct vm_area_desc *desc, vma_flags_t vma_flags);
>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
>  bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
> @@ -529,7 +529,7 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
>  }
>  
>  extern const struct vm_operations_struct hugetlb_vm_ops;
> -struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
> +struct file *hugetlb_file_setup(const char *name, size_t size, vma_flags_t acct,
>  				int creat_flags, int page_size_log);
>  
>  static inline bool is_file_hugepages(const struct file *file)
> @@ -545,7 +545,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
>  
>  #define is_file_hugepages(file)			false
>  static inline struct file *
> -hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
> +hugetlb_file_setup(const char *name, size_t size, vma_flags_t acctflag,
>  		int creat_flags, int page_size_log)
>  {
>  	return ERR_PTR(-ENOSYS);
> diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
> index a27aa0162918..593f5d4e108b 100644
> --- a/include/linux/hugetlb_inline.h
> +++ b/include/linux/hugetlb_inline.h
> @@ -11,6 +11,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
>  	return !!(vm_flags & VM_HUGETLB);
>  }
>  
> +static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
> +{
> +	return vma_flags_test(flags, VMA_HUGETLB_BIT);
> +}
> +
>  #else
>  
>  static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
> @@ -18,6 +23,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
>  	return false;
>  }
>  
> +static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
> +{
> +	return false;
> +}
> +
>  #endif
>  
>  static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 3db36773dd10..2c7379c4c647 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -707,9 +707,9 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  	int error;
>  	struct shmid_kernel *shp;
>  	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	const bool has_no_reserve = shmflg & SHM_NORESERVE;
>  	struct file *file;
>  	char name[13];
> -	vm_flags_t acctflag = 0;
>  
>  	if (size < SHMMIN || size > ns->shm_ctlmax)
>  		return -EINVAL;
> @@ -738,6 +738,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  
>  	sprintf(name, "SYSV%08x", key);
>  	if (shmflg & SHM_HUGETLB) {
> +		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
>  		struct hstate *hs;
>  		size_t hugesize;
>  
> @@ -749,17 +750,18 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  		hugesize = ALIGN(size, huge_page_size(hs));
>  
>  		/* hugetlb_file_setup applies strict accounting */
> -		if (shmflg & SHM_NORESERVE)
> -			acctflag = VM_NORESERVE;
> +		if (has_no_reserve)
> +			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
>  		file = hugetlb_file_setup(name, hugesize, acctflag,
>  				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
>  	} else {
> +		vm_flags_t acctflag = 0;
> +
>  		/*
>  		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
>  		 * if it's asked for.
>  		 */
> -		if  ((shmflg & SHM_NORESERVE) &&
> -				sysctl_overcommit_memory != OVERCOMMIT_NEVER)
> +		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
>  			acctflag = VM_NORESERVE;
>  		file = shmem_kernel_file_setup(name, size, acctflag);
>  	}
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4f4494251f5c..e6955061d751 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1193,16 +1193,16 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
>  
>  static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
>  {
> -	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
> -	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
> +	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
> +	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
>  
>  	desc->private_data = map;
>  }
>  
>  static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
>  {
> -	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
> -	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
> +	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
> +	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
>  
>  	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
>  }
> @@ -1216,7 +1216,7 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
>  
>  static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
>  {
> -	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
> +	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
>  
>  	return ((unsigned long)desc->private_data) & flag;
>  }
> @@ -6564,7 +6564,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  long hugetlb_reserve_pages(struct inode *inode,
>  		long from, long to,
>  		struct vm_area_desc *desc,
> -		vm_flags_t vm_flags)
> +		vma_flags_t vma_flags)
>  {
>  	long chg = -1, add = -1, spool_resv, gbl_resv;
>  	struct hstate *h = hstate_inode(inode);
> @@ -6585,7 +6585,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * attempt will be made for VM_NORESERVE to allocate a page
>  	 * without using reserves
>  	 */
> -	if (vm_flags & VM_NORESERVE)
> +	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
>  		return 0;
>  
>  	/*
> @@ -6594,7 +6594,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * to reserve the full area even if read-only as mprotect() may be
>  	 * called to make the mapping read-write. Assume !desc is a shm mapping
>  	 */
> -	if (!desc || desc->vm_flags & VM_MAYSHARE) {
> +	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
>  		/*
>  		 * resv_map can not be NULL as hugetlb_reserve_pages is only
>  		 * called for inodes for which resv_maps were created (see
> @@ -6628,7 +6628,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	if (err < 0)
>  		goto out_err;
>  
> -	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
> +	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
>  		/* For private mappings, the hugetlb_cgroup uncharge info hangs
>  		 * of the resv_map.
>  		 */
> @@ -6665,7 +6665,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * consumed reservations are stored in the map. Hence, nothing
>  	 * else has to be done for private mappings here
>  	 */
> -	if (!desc || desc->vm_flags & VM_MAYSHARE) {
> +	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
>  		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
>  
>  		if (unlikely(add < 0)) {
> @@ -6729,7 +6729,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>  					    chg * pages_per_huge_page(h), h_cg);
>  out_err:
> -	if (!desc || desc->vm_flags & VM_MAYSHARE)
> +	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
>  		/* Only call region_abort if the region_chg succeeded but the
>  		 * region_add failed or didn't run.
>  		 */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index ab5312aff14b..5f95f639550c 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -87,7 +87,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
>  		idx >>= huge_page_order(h);
>  
> -		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
> +		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
>  		if (nr_resv < 0)
>  			return ERR_PTR(nr_resv);
>  
> @@ -464,7 +464,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>  	int err = 0;
>  
>  	if (flags & MFD_HUGETLB) {
> -		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
> +		file = hugetlb_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT),
>  					HUGETLB_ANONHUGE_INODE,
>  					(flags >> MFD_HUGE_SHIFT) &
>  					MFD_HUGE_MASK);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8771b276d63d..038ff5f09df0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -594,7 +594,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>  		 * taken when vm_ops->mmap() is called
>  		 */
>  		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
> -				VM_NORESERVE,
> +				mk_vma_flags(VMA_NORESERVE_BIT),
>  				HUGETLB_ANONHUGE_INODE,
>  				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
>  		if (IS_ERR(file))
> -- 
> 2.52.0
> 

