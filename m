Return-Path: <linux-fsdevel+bounces-76864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM6fKRJvi2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:46:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1711E150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA55300DEC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226038A717;
	Tue, 10 Feb 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGJR5mAh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z+ejXvwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24055632;
	Tue, 10 Feb 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745607; cv=fail; b=mX7vBIZYhUuIF76kzXGXxNLmyJbVroWPpDzdeKSyewbOo8gkXOW8ubeyHJVoi5xJEWqkrcBEVZKgSsRLDd9dhty63rDPze5CwqTy1UI8kkUDVen6ga8Wy4y9/TfgnLDx5dQ+QX8GQ5QW92wXOVBtQxUIzeXlR4GQdqxjQZjJTmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745607; c=relaxed/simple;
	bh=bjfuPGc+f7qfvzadqIEo0jJ+OYscrxN6PqTn91H22U0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQzanJHbSEQEQqwY8pz5Dr1fi+1BaECO6fpPG1Qp1U4inBsswj4c35IUp20VoTRRuMlTbB25si9Wtl565QsEc/cEr/8bIDBkS1WHqsqjoAodVoOBf6Gv5a/wUhfTEkfsKI/tQ2ykA3DN1++ICbnrghNYMtWA5k7d7EOXc9M7wUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGJR5mAh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z+ejXvwi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AGvYGt065128;
	Tue, 10 Feb 2026 17:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xkFpBYqaCBKoS21e2h
	6MCANlvAIXfTUyp9NLHSLwZag=; b=YGJR5mAhYKdY7lJG/X50XwL6q81QbHeoPw
	X/kbSH1aMplyyyigwG+5lNFNqcGbk6govymunf2qoPHPcwXvZ4JEHCH4DlpqPlhA
	SEv4yEE75GyvCrj8DNPa0XehkZlH3mVnPydnwfA0Up+217jGUs9QH9Kpg4T6GbnV
	/9aCW7HgaYB6fWVGXy5PPkCtLfVDmfjUBS8dtUsxziC/Kz1hk7RG5BI/X0DVKIvy
	W3hh4tUeyWWynuuVQDPGdFKhUSMEHTOtfVDHvmpy+iW7MjnJEVRoPMuGsWOrABIe
	A4jVUOI81RK6SOV5t0V5B3fNhI6rJ9i7n60jRyN9Qi1F2QK3VTuA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88n7g3bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 17:45:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61AGQQbj033798;
	Tue, 10 Feb 2026 17:45:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c824538e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 17:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8q43vCgjKUFnGaaiN2MVAMRApfTOxN/QBKbf4UTSTEqs7fHpU4vnEDTBDJ0svC5W4nuXgMfMJ/WBEAoZxopd7/DqSfDPiFWChgXlRrs9BPiaGKpLNutsa37pt3trjLKdjx+cbQ9C8bHSPv8qhctKZ3Vd7h3vtgrIk7mDRb5mjcsgmPdWlZ1etXBQ7k2kBsHqyw5mNkfTlBb5sT7gdB6GOSefLe9i93fERXgf753eCc1P1O2YQ7c3/ZGZe30gF6eXd8+hbY8qofer0tbT+dMyD+bgBUJldRl3EU2JVDJyx2bkJMHFZCpirzVZKAVD4oz0o2Nm/TwOPOb5JvODVWRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkFpBYqaCBKoS21e2h6MCANlvAIXfTUyp9NLHSLwZag=;
 b=KHyspZ989hP3h8eWHdUvecBPJ0VpnOcNhYBXrdUjh8KYhEtpFHA989KnCz4m+m1fdbYf3neNKkPT7P1xKciT5T5OBJ6uGGREN5XAjjZp5wFfpugfM9d+E1rrgnwd9cLZbquPBeKxezgpt/EPhGDeWcY8g7iZUh2KQCPfGa6meHr/2FM2eBkhztwGP8Q5b1dLZSa40LmKhe45KqrUk/7vrX8bIPurN97fC66qFL58cDxSuaqYF7O3uoy9UbvjsZixvgcOgcsgTKHk0WG5V5XxCt3DXjmeS+RlirOY4cLE/s1Z6cFv4ME9KfFN3gbYC/X3P1f1YakH8tFGRaSHDOAvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkFpBYqaCBKoS21e2h6MCANlvAIXfTUyp9NLHSLwZag=;
 b=z+ejXvwifwDPtUdnTjzT1i/m6g2fKqaLJ9YVRRZ4ksJ3+aLt22Wf/ghdlIsdxI5801FVAZYimXpBD/SaFFogDOvFWNwYKq8qFna5LgeszdOv+kWl73ApQ85+d3GVSzhZonXcrGkC9l6fB/rlWMrIvK1iXo3lj71vjwM1Sjctstw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 17:44:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:44:55 +0000
Date: Tue, 10 Feb 2026 17:44:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 11/13] tools/testing/vma: separate VMA userland tests
 into separate files
Message-ID: <52dbc7c8-5a86-48e1-a018-7a5b8afdaaea@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <a0455ccfe4fdcd1c962c64f76304f612e5662a4e.1769097829.git.lorenzo.stoakes@oracle.com>
 <opopo4rlyxz7upi2bzrx7e6cyji2nmaynvlhvr2nzvtvb5pfxu@4fekgb5faybz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opopo4rlyxz7upi2bzrx7e6cyji2nmaynvlhvr2nzvtvb5pfxu@4fekgb5faybz>
X-ClientProxiedBy: LO4P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfb74cc-988d-4b2f-4dc5-08de68cc19d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpcgQmAo3Dn3M+1ekRw6gwg70TWgSeX1Hbu4nh/+QZ9tpWaOo8F7IppyKHKN?=
 =?us-ascii?Q?ZpxGs+bxm3Mjsx8v7ahkAzhMuthK9WrGeV8CVgqYLqRUtWMHaD/icim7G6T/?=
 =?us-ascii?Q?IC9FsWLufStcgD/4v7Mp6r4wE9wR+VUz1hTjMf1XAZfM5yFJkGWM6nGhIF5Y?=
 =?us-ascii?Q?qN733WAb9F67ijki0d0pp2SolbR8wRlZmrj+l/gGbMtxb5tqKTTdQa2hRRdy?=
 =?us-ascii?Q?/wmj/VjkxP8uQWHizv/DErrULy88Un2GFlTBZaZBcQZF70ka80PFYiymhj/z?=
 =?us-ascii?Q?ahsdfDoHJ353KG/uMZ/8uPspxth2nebZxjDvF4IzhBsSctE+FhdJD6mvF+ps?=
 =?us-ascii?Q?kZ6a1iD7OFETbrEn6YiW1HFMa0vTEJ3/wEOqv19Meh6l0AlbMU1AhQ280vqi?=
 =?us-ascii?Q?xXkhM5zKVZ7ouFXuAxevDbRtNOBKPcVP2SudznWJxUQHvBwPPyAqUWlciac7?=
 =?us-ascii?Q?OK+k3IPF/bNbUqWZpdKkC95Bfskdg5d1D0EJRuKZhLyLcUdDmwGepke5/Y68?=
 =?us-ascii?Q?Pp9G08FdkdVy/FiFhyft5M6dG7zyKx2xsG/S+GHEFfl7HiVa/JBI1BooBJhS?=
 =?us-ascii?Q?9IeS0WG+m9vZX0wEYhRRpOugARri/E4aIGi3qMbOZV2yn4MSqioOamnZCYQS?=
 =?us-ascii?Q?HRxNxyhHCVzEsLvSqtMom7/NRB5Kz6BLEvV6KqmglKMJzfJcvJ5xNNphkuZ6?=
 =?us-ascii?Q?CEELJETO5w7Paiu5mTsEGIZqg3FGAzCDRFVoQwh2EeQeLtrPAjbPOAPYYsie?=
 =?us-ascii?Q?qNPGMLueSjtXihkV0MC9eLY+BGkhgm3QEAcAN9hwm7lsYTcN8oU89ywBWKXt?=
 =?us-ascii?Q?yV05vRs+Bb4+UWw8gvrY99UIS76vuvEitQgOHl3k/OAtp3Ngp1Jg6spusAIb?=
 =?us-ascii?Q?zgwkI36oqKJbChjZYcGu1nDEUutot/yHdIatougEm4woWewwe55qad6YfJnh?=
 =?us-ascii?Q?XB/YIZMvM2PSsxaYRVtWwN4wRfsK1MAsqLiW+twvlumfa49MsE/GM65lRyLF?=
 =?us-ascii?Q?zz6YyBf93ah6oMHvbLxu3YEvzt/2OgkVrdL7PtxV2GxqktE4fHIx2g1WtrYF?=
 =?us-ascii?Q?Otw3TK9ISpu0KGJRCtiqT86vAKpM5Jh4/ffB0o3ZbleKfhejua7duVSzj0uQ?=
 =?us-ascii?Q?WDexDq0YXo8Yrvtvz6vvETK+Jl6kD27D6dOZ3zoD6yP0ks3tZcE7okggM12f?=
 =?us-ascii?Q?nPtexyvOen1s6dL9xvLHidgGz/lswYfOI2oG3Iu40wy8KECaMr7f/EasJn43?=
 =?us-ascii?Q?pcinUxAc8Mg2TuZ5iajhvz+TfFUbHjt2b0Y+iVfyuV3v2ECSR0h1PzlDber4?=
 =?us-ascii?Q?O++f5HhbIThO0Y8EqtB5BIEwYtL9ndBtIbOBYHoJmouRS6uQ6s/7sGaG78NU?=
 =?us-ascii?Q?Gnw28D2EgFgtno7TfNytUIjGzzE6bQyAuD6WAlFqOOYFo5XvnVlcfhV/CheH?=
 =?us-ascii?Q?IwVCYM6hv2OfmatQlM24lG8fU3FerNE1eqtNNN7LtCl+niAL1Ssy6EVlUdui?=
 =?us-ascii?Q?wGzZcn9+owHbfSvNVmzEJsWzkzjd6ujvqNbA3T5ghIO397gW0lHBZAmIeVa3?=
 =?us-ascii?Q?IMM2RbbJOiUYGZMhhhRbNk+bqCulmaGeKl55CtCW3Cvn8G4F6m+p4tEjxpa0?=
 =?us-ascii?Q?tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5XxZr4pBDNPyBN7TCQ8VK4h1RLyA1MgJn3nqRsFvczswg47e4KgHd0Gneaw?=
 =?us-ascii?Q?qHdyBDeyZ6JuFXI7C/O8bxEOUvyt9u2jTHaUF+YhjVwa7JMDhCPDpd4imDH1?=
 =?us-ascii?Q?jVWYZ4tSTCeMfD/0b77D5af1mTRtNjhzFHZv0OYQBJm2nBLiZUzKjzs/R2+0?=
 =?us-ascii?Q?lWYHX8Fctlfv5bid3DWnF216FmSnIVTE0qogXLMuzTKgB8/0sW6RMcwEaN89?=
 =?us-ascii?Q?xjEDDa9UaBlmUEFlymnmCG2l/a6EKBfGrv9FlPXu/ugU/Amvruq3GKIFL/Zc?=
 =?us-ascii?Q?NDJYd2YujYQFz6zr5CVoqrVcuXYzb/osndFg3W0vG8sTI91komvsVm9DYfrF?=
 =?us-ascii?Q?AIxBmKHSfhQOlTHUiL0Sv8zlQEE9aQhXIJcKZlOK/6ZpStEtgrqObXgacogS?=
 =?us-ascii?Q?fh1Z0JoAN7XX3b2pCcHSqA6+3hpLzaocWohqy5di0mMWf0cgDjpsqyYb6c8C?=
 =?us-ascii?Q?kQiX5skwF26gTC2E6sHs5eMX9GcEuHSHHqg5pMbfG4VozA8z/KnTy3ojzO8X?=
 =?us-ascii?Q?nkI80AEnxU3y8TWZQzE7pKH/TjRoAti1I6FnKTI65wxtZXDx2yBfxOJChqrB?=
 =?us-ascii?Q?luW4alxFAccsLB0VEqS7JEAJh3HFSVjIPLepqgZyGk//wvCVZQdWVjzUFsH9?=
 =?us-ascii?Q?I8lWp7vYEe0oT8utTdQzNuvbdNV9AySNCFF6iMq2BQUyi6t3HmAFk4gJzrFm?=
 =?us-ascii?Q?FgYpaQIngOwNY+OfFYTAy2qKizrdHASoGXna53T+5yRFHGiDJW4+HOz1/alK?=
 =?us-ascii?Q?82au03pOZwkPg3e9Lip6q/vbwUOOqxdZibcFtg+5t6P8vq4fB+IUjJBZaRCY?=
 =?us-ascii?Q?zyUD2XOExxb82xJg0lhUkKpkP9eGW4VaIw4FuKTMZ1A6j943K8hQnu6WAHQL?=
 =?us-ascii?Q?lqHs1nJRM/pBlqOZ3Uo3nXuMwpxShILCFHKazJIJpxZzNRe4SaoX44JsdEGr?=
 =?us-ascii?Q?aZiyn56KxlcVCZSylOF/+w+Oj5wRd7yqdFV/s67wWW9VwQeJuGMm1+xhfMLY?=
 =?us-ascii?Q?DXHIu0FOiNM5jvipuinD3N4Vz0hejZZ6QLPIbLHKaAAzql/kdC36RtTaRaoJ?=
 =?us-ascii?Q?cvE2JUAordtlMH7o1VomIo6Qu9RZNx12hoVDFxtqHoZw+VBYZh2o0I37uQ/I?=
 =?us-ascii?Q?udFjyxTfA6XO4KprYHpC3Ug89Mo+Vf2JWcYHQf27umCZ40dfCqiILP5OrZQr?=
 =?us-ascii?Q?se/Q6J5FLDPLURC2LDW6RGOp7EIAQF8NAAsZF+AljE0oWZ9+7RsiR1c+0Lxq?=
 =?us-ascii?Q?/SS/bxCS0Gk6WyEkGy49MjC/Epb7g0f9nSNu/WjGIJLGOYFtOZhxdz96uA1j?=
 =?us-ascii?Q?9dDZl3vg7Rzktb6u7fIMA/1AXu3UyXgZ92ooiQiZ1243WiukDFG+NRT24NBk?=
 =?us-ascii?Q?nwvP8o1DhVsC4pl1GtJomkpN1omru1iZ0l+1swfuLdKxpisJlJzhsIZ2cEZG?=
 =?us-ascii?Q?R5tXbmcqrBOlOi7B2ytaWvnUjIbpkj+aDRvEGZUiqSnJlejzxouCkC1D6jRR?=
 =?us-ascii?Q?fcWxDif9bBxkySjJ/YSpPyR8RYmt8SUUDFQ+e24KICJc3aYh9V2Ryq/sTI+a?=
 =?us-ascii?Q?bCxU6qUg3QKUcIwQKZMZ8PKxb68TK9wL3Nqu9hDVH7uaHOzVqa6ReuwbuhxX?=
 =?us-ascii?Q?WzSmc1qv7yN7qtadz4SHPkR4noIBRYnkGNVjH/WPkXGlMJvTiNCOg5RUPJvJ?=
 =?us-ascii?Q?aohc2kM8A7GzRuPtCqFSC1+eZFYQKairy8KUv1C/sUr2bGL147EG9lETqCCs?=
 =?us-ascii?Q?O2Vu4at9XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJGVOnKHQk8DEjLLFT/osJ7WEGF5AoHsikUJhaOO2UjOFwJ3D5ZmJHFJNs+IRmyWVUaVGQx6U4AFPr58LLrIfHfHymyksVtTsd9R1aNG6gqam/Fv71bcw1JfHUVLVmR++RHTjyznaI58c6s1IKVbkwl/NIsE0JypRK+3tRjql7glrLxO6E89sZhPFdoiijMGANKfxzeb0BgcwvJByv/N/wubde4aWZIdjNciuVHdb5SOjZI7u23aXLg7gVvJEylD6kt1QVHpja+dVudgFt7JjrAUy+0cuAv2zusFanJU5+K/kacFX+h7+kLpey7o3/KTchj/Igo9LfLNPruO2IaUosCYxBkJiXunxK5O3rtUBf9Su+McoBH0Zwaefa+IkB0fbxWPh53EFvBGoyGIGvtWEV5fP5CGlb5gtCn9/JatMWAn+k6CgvztU2NSY9whJGcLXaOt84DLsWoePAgoD9Bjp8PFAJmKq3vMclw1tD4/o5HippRTG6wNOBZ11JaJZlxMdTMT9mnpUI+NNOxmlUCoXeN5ZZvveMvnt7QT6JRSiNXEH2qni7DeSq5WLSiXc3h3LlzHnWhIX2AfWi/zQZv62wSTpDg6TxI99gJSXXFH7OI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfb74cc-988d-4b2f-4dc5-08de68cc19d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:44:55.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQhk5C3Bc9IywdxGRyMTQSYr7wYuH8QhmlWrzHD4L5SNgn7TLSUf5I5tbwfAI0oC8nbJgWTOJN7I33KGnX4rNhLLBcTU6fHIJfNvOicxlfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602100148
X-Proofpoint-ORIG-GUID: 5_rwLb71AxQC6gIlBkoP95zzhGekoNVG
X-Proofpoint-GUID: 5_rwLb71AxQC6gIlBkoP95zzhGekoNVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0OCBTYWx0ZWRfX8kldw9YtRVUG
 vrYE9uqV02XUQqvNfXss673xKjACLx8ghb1wji5/hg8QXBS206qft0CtcALazehtT6gUZVHIqwo
 UrHq2tU//ahJivhgSbc8Mwfo6HFC9r8jfu/+WPloorZ85TrUPcLLdZg1ObZo/CxZN54CWs6oyS7
 pvyyksoUmMNvVATRlI9XOP4uNjv8yvzEvaG/zwtp5knOBMd6zHizZ3aT/YcuN1SOy8CDzxfjvH4
 Gm/iZnbU+IckbyMp/ahVjNBdgfejBvsZy+0LyZ8GY2ONcg82CQSf7lL/d8wVtPCG3iWVDeXC8N8
 NBuwStEtY6W8kGelqakPYf/0FnDZNBFZVVTv28V6Q5/JIoSaTCElpWnIiPXrOeUAihqtS+Ccpsq
 ulGw7+5nSP03/uSnwB3YnqGhAOUZst68Ge5Y5mvjZm/L1qSkQwtfrTFXLhocBLe5na6Gjro4myA
 o/1SaIoYacil+bLBKQA==
X-Authority-Analysis: v=2.4 cv=O5c0fR9W c=1 sm=1 tr=0 ts=698b6ea1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=78y8g8jf3ynzcmoX5bsA:9 a=CjuIK1q_8ugA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	TAGGED_FROM(0.00)[bounces-76864-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7EA1711E150
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:58:22PM +0000, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> > So far the userland VMA tests have been established as a rough expression
> > of what's been possible.
> >
> > qAdapt it into a more usable form by separating out tests and shared helper
> ^^^^ Typo

Oops, Andrew - can you fix that up? Thanks! :)

>
>
> > functions.
> >
> > Since we test functions that are declared statically in mm/vma.c, we make
> > use of the trick of #include'ing kernel C files directly.
> >
> > In order for the tests to continue to function, we must therefore also
> > this way into the tests/ directory.
> >
> > We try to keep as much shared logic actually modularised into a separate
> > compilation unit in shared.c, however the merge_existing() and attach_vma()
> > helpers rely on statically declared mm/vma.c functions so these must be
> > declared in main.c.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Besides that typo, it looks good.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks :)

Cheers, Lorenzo

>
> > ---
> >  tools/testing/vma/Makefile                 |   4 +-
> >  tools/testing/vma/main.c                   |  55 ++++
> >  tools/testing/vma/shared.c                 | 131 ++++++++
> >  tools/testing/vma/shared.h                 | 114 +++++++
> >  tools/testing/vma/{vma.c => tests/merge.c} | 332 +--------------------
> >  tools/testing/vma/tests/mmap.c             |  57 ++++
> >  tools/testing/vma/tests/vma.c              |  39 +++
> >  tools/testing/vma/vma_internal.h           |   9 -
> >  8 files changed, 406 insertions(+), 335 deletions(-)
> >  create mode 100644 tools/testing/vma/main.c
> >  create mode 100644 tools/testing/vma/shared.c
> >  create mode 100644 tools/testing/vma/shared.h
> >  rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
> >  create mode 100644 tools/testing/vma/tests/mmap.c
> >  create mode 100644 tools/testing/vma/tests/vma.c
> >
> > diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> > index 66f3831a668f..94133d9d3955 100644
> > --- a/tools/testing/vma/Makefile
> > +++ b/tools/testing/vma/Makefile
> > @@ -6,10 +6,10 @@ default: vma
> >
> >  include ../shared/shared.mk
> >
> > -OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> > +OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
> >  TARGETS = vma
> >
> > -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
> > +main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
> >
> >  vma:	$(OFILES)
> >  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> > diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
> > new file mode 100644
> > index 000000000000..49b09e97a51f
> > --- /dev/null
> > +++ b/tools/testing/vma/main.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include "shared.h"
> > +/*
> > + * Directly import the VMA implementation here. Our vma_internal.h wrapper
> > + * provides userland-equivalent functionality for everything vma.c uses.
> > + */
> > +#include "../../../mm/vma_init.c"
> > +#include "../../../mm/vma_exec.c"
> > +#include "../../../mm/vma.c"
> > +
> > +/* Tests are included directly so they can test static functions in mm/vma.c. */
> > +#include "tests/merge.c"
> > +#include "tests/mmap.c"
> > +#include "tests/vma.c"
> > +
> > +/* Helper functions which utilise static kernel functions. */
> > +
> > +struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> > +{
> > +	struct vm_area_struct *vma;
> > +
> > +	vma = vma_merge_existing_range(vmg);
> > +	if (vma)
> > +		vma_assert_attached(vma);
> > +	return vma;
> > +}
> > +
> > +int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> > +{
> > +	int res;
> > +
> > +	res = vma_link(mm, vma);
> > +	if (!res)
> > +		vma_assert_attached(vma);
> > +	return res;
> > +}
> > +
> > +/* Main test running which invokes tests/ *.c runners. */
> > +int main(void)
> > +{
> > +	int num_tests = 0, num_fail = 0;
> > +
> > +	maple_tree_init();
> > +	vma_state_init();
> > +
> > +	run_merge_tests(&num_tests, &num_fail);
> > +	run_mmap_tests(&num_tests, &num_fail);
> > +	run_vma_tests(&num_tests, &num_fail);
> > +
> > +	printf("%d tests run, %d passed, %d failed.\n",
> > +	       num_tests, num_tests - num_fail, num_fail);
> > +
> > +	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
> > +}
> > diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
> > new file mode 100644
> > index 000000000000..bda578cc3304
> > --- /dev/null
> > +++ b/tools/testing/vma/shared.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include "shared.h"
> > +
> > +
> > +bool fail_prealloc;
> > +unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> > +unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> > +unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> > +
> > +const struct vm_operations_struct vma_dummy_vm_ops;
> > +struct anon_vma dummy_anon_vma;
> > +struct task_struct __current;
> > +
> > +struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end,
> > +		pgoff_t pgoff, vm_flags_t vm_flags)
> > +{
> > +	struct vm_area_struct *vma = vm_area_alloc(mm);
> > +
> > +	if (vma == NULL)
> > +		return NULL;
> > +
> > +	vma->vm_start = start;
> > +	vma->vm_end = end;
> > +	vma->vm_pgoff = pgoff;
> > +	vm_flags_reset(vma, vm_flags);
> > +	vma_assert_detached(vma);
> > +
> > +	return vma;
> > +}
> > +
> > +void detach_free_vma(struct vm_area_struct *vma)
> > +{
> > +	vma_mark_detached(vma);
> > +	vm_area_free(vma);
> > +}
> > +
> > +struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end,
> > +		pgoff_t pgoff, vm_flags_t vm_flags)
> > +{
> > +	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
> > +
> > +	if (vma == NULL)
> > +		return NULL;
> > +
> > +	if (attach_vma(mm, vma)) {
> > +		detach_free_vma(vma);
> > +		return NULL;
> > +	}
> > +
> > +	/*
> > +	 * Reset this counter which we use to track whether writes have
> > +	 * begun. Linking to the tree will have caused this to be incremented,
> > +	 * which means we will get a false positive otherwise.
> > +	 */
> > +	vma->vm_lock_seq = UINT_MAX;
> > +
> > +	return vma;
> > +}
> > +
> > +void reset_dummy_anon_vma(void)
> > +{
> > +	dummy_anon_vma.was_cloned = false;
> > +	dummy_anon_vma.was_unlinked = false;
> > +}
> > +
> > +int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> > +{
> > +	struct vm_area_struct *vma;
> > +	int count = 0;
> > +
> > +	fail_prealloc = false;
> > +	reset_dummy_anon_vma();
> > +
> > +	vma_iter_set(vmi, 0);
> > +	for_each_vma(*vmi, vma) {
> > +		detach_free_vma(vma);
> > +		count++;
> > +	}
> > +
> > +	mtree_destroy(&mm->mm_mt);
> > +	mm->map_count = 0;
> > +	return count;
> > +}
> > +
> > +bool vma_write_started(struct vm_area_struct *vma)
> > +{
> > +	int seq = vma->vm_lock_seq;
> > +
> > +	/* We reset after each check. */
> > +	vma->vm_lock_seq = UINT_MAX;
> > +
> > +	/* The vma_start_write() stub simply increments this value. */
> > +	return seq > -1;
> > +}
> > +
> > +void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > +		struct anon_vma_chain *avc, struct anon_vma *anon_vma)
> > +{
> > +	vma->anon_vma = anon_vma;
> > +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> > +	list_add(&avc->same_vma, &vma->anon_vma_chain);
> > +	avc->anon_vma = vma->anon_vma;
> > +}
> > +
> > +void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > +		struct anon_vma_chain *avc)
> > +{
> > +	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
> > +}
> > +
> > +struct task_struct *get_current(void)
> > +{
> > +	return &__current;
> > +}
> > +
> > +unsigned long rlimit(unsigned int limit)
> > +{
> > +	return (unsigned long)-1;
> > +}
> > +
> > +void vma_set_range(struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   pgoff_t pgoff)
> > +{
> > +	vma->vm_start = start;
> > +	vma->vm_end = end;
> > +	vma->vm_pgoff = pgoff;
> > +}
> > diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
> > new file mode 100644
> > index 000000000000..6c64211cfa22
> > --- /dev/null
> > +++ b/tools/testing/vma/shared.h
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#pragma once
> > +
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include "generated/bit-length.h"
> > +#include "maple-shared.h"
> > +#include "vma_internal.h"
> > +#include "../../../mm/vma.h"
> > +
> > +/* Simple test runner. Assumes local num_[fail, tests] counters. */
> > +#define TEST(name)							\
> > +	do {								\
> > +		(*num_tests)++;						\
> > +		if (!test_##name()) {					\
> > +			(*num_fail)++;					\
> > +			fprintf(stderr, "Test " #name " FAILED\n");	\
> > +		}							\
> > +	} while (0)
> > +
> > +#define ASSERT_TRUE(_expr)						\
> > +	do {								\
> > +		if (!(_expr)) {						\
> > +			fprintf(stderr,					\
> > +				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> > +				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> > +			return false;					\
> > +		}							\
> > +	} while (0)
> > +
> > +#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> > +#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> > +#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> > +
> > +#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
> > +
> > +extern bool fail_prealloc;
> > +
> > +/* Override vma_iter_prealloc() so we can choose to fail it. */
> > +#define vma_iter_prealloc(vmi, vma)					\
> > +	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
> > +
> > +#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
> > +
> > +extern unsigned long mmap_min_addr;
> > +extern unsigned long dac_mmap_min_addr;
> > +extern unsigned long stack_guard_gap;
> > +
> > +extern const struct vm_operations_struct vma_dummy_vm_ops;
> > +extern struct anon_vma dummy_anon_vma;
> > +extern struct task_struct __current;
> > +
> > +/*
> > + * Helper function which provides a wrapper around a merge existing VMA
> > + * operation.
> > + *
> > + * Declared in main.c as uses static VMA function.
> > + */
> > +struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg);
> > +
> > +/*
> > + * Helper function to allocate a VMA and link it to the tree.
> > + *
> > + * Declared in main.c as uses static VMA function.
> > + */
> > +int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma);
> > +
> > +/* Helper function providing a dummy vm_ops->close() method.*/
> > +static inline void dummy_close(struct vm_area_struct *)
> > +{
> > +}
> > +
> > +/* Helper function to simply allocate a VMA. */
> > +struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end,
> > +		pgoff_t pgoff, vm_flags_t vm_flags);
> > +
> > +/* Helper function to detach and free a VMA. */
> > +void detach_free_vma(struct vm_area_struct *vma);
> > +
> > +/* Helper function to allocate a VMA and link it to the tree. */
> > +struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end,
> > +		pgoff_t pgoff, vm_flags_t vm_flags);
> > +
> > +/*
> > + * Helper function to reset the dummy anon_vma to indicate it has not been
> > + * duplicated.
> > + */
> > +void reset_dummy_anon_vma(void);
> > +
> > +/*
> > + * Helper function to remove all VMAs and destroy the maple tree associated with
> > + * a virtual address space. Returns a count of VMAs in the tree.
> > + */
> > +int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi);
> > +
> > +/* Helper function to determine if VMA has had vma_start_write() performed. */
> > +bool vma_write_started(struct vm_area_struct *vma);
> > +
> > +void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > +		struct anon_vma_chain *avc, struct anon_vma *anon_vma);
> > +
> > +/* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
> > +void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > +			    struct anon_vma_chain *avc);
> > +
> > +/* Helper function to specify a VMA's range. */
> > +void vma_set_range(struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   pgoff_t pgoff);
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/tests/merge.c
> > similarity index 82%
> > rename from tools/testing/vma/vma.c
> > rename to tools/testing/vma/tests/merge.c
> > index 93d21bc7e112..3708dc6945b0 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/tests/merge.c
> > @@ -1,132 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >
> > -#include <stdbool.h>
> > -#include <stdio.h>
> > -#include <stdlib.h>
> > -
> > -#include "generated/bit-length.h"
> > -
> > -#include "maple-shared.h"
> > -#include "vma_internal.h"
> > -
> > -/* Include so header guard set. */
> > -#include "../../../mm/vma.h"
> > -
> > -static bool fail_prealloc;
> > -
> > -/* Then override vma_iter_prealloc() so we can choose to fail it. */
> > -#define vma_iter_prealloc(vmi, vma)					\
> > -	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
> > -
> > -#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
> > -
> > -unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> > -unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> > -unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> > -
> > -/*
> > - * Directly import the VMA implementation here. Our vma_internal.h wrapper
> > - * provides userland-equivalent functionality for everything vma.c uses.
> > - */
> > -#include "../../../mm/vma_init.c"
> > -#include "../../../mm/vma_exec.c"
> > -#include "../../../mm/vma.c"
> > -
> > -const struct vm_operations_struct vma_dummy_vm_ops;
> > -static struct anon_vma dummy_anon_vma;
> > -
> > -#define ASSERT_TRUE(_expr)						\
> > -	do {								\
> > -		if (!(_expr)) {						\
> > -			fprintf(stderr,					\
> > -				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> > -				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> > -			return false;					\
> > -		}							\
> > -	} while (0)
> > -#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> > -#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> > -#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> > -
> > -#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
> > -
> > -static struct task_struct __current;
> > -
> > -struct task_struct *get_current(void)
> > -{
> > -	return &__current;
> > -}
> > -
> > -unsigned long rlimit(unsigned int limit)
> > -{
> > -	return (unsigned long)-1;
> > -}
> > -
> > -/* Helper function to simply allocate a VMA. */
> > -static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> > -					unsigned long start,
> > -					unsigned long end,
> > -					pgoff_t pgoff,
> > -					vm_flags_t vm_flags)
> > -{
> > -	struct vm_area_struct *vma = vm_area_alloc(mm);
> > -
> > -	if (vma == NULL)
> > -		return NULL;
> > -
> > -	vma->vm_start = start;
> > -	vma->vm_end = end;
> > -	vma->vm_pgoff = pgoff;
> > -	vm_flags_reset(vma, vm_flags);
> > -	vma_assert_detached(vma);
> > -
> > -	return vma;
> > -}
> > -
> > -/* Helper function to allocate a VMA and link it to the tree. */
> > -static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> > -{
> > -	int res;
> > -
> > -	res = vma_link(mm, vma);
> > -	if (!res)
> > -		vma_assert_attached(vma);
> > -	return res;
> > -}
> > -
> > -static void detach_free_vma(struct vm_area_struct *vma)
> > -{
> > -	vma_mark_detached(vma);
> > -	vm_area_free(vma);
> > -}
> > -
> > -/* Helper function to allocate a VMA and link it to the tree. */
> > -static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> > -						 unsigned long start,
> > -						 unsigned long end,
> > -						 pgoff_t pgoff,
> > -						 vm_flags_t vm_flags)
> > -{
> > -	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
> > -
> > -	if (vma == NULL)
> > -		return NULL;
> > -
> > -	if (attach_vma(mm, vma)) {
> > -		detach_free_vma(vma);
> > -		return NULL;
> > -	}
> > -
> > -	/*
> > -	 * Reset this counter which we use to track whether writes have
> > -	 * begun. Linking to the tree will have caused this to be incremented,
> > -	 * which means we will get a false positive otherwise.
> > -	 */
> > -	vma->vm_lock_seq = UINT_MAX;
> > -
> > -	return vma;
> > -}
> > -
> >  /* Helper function which provides a wrapper around a merge new VMA operation. */
> >  static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> >  {
> > @@ -146,20 +19,6 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> >  	return vma;
> >  }
> >
> > -/*
> > - * Helper function which provides a wrapper around a merge existing VMA
> > - * operation.
> > - */
> > -static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> > -{
> > -	struct vm_area_struct *vma;
> > -
> > -	vma = vma_merge_existing_range(vmg);
> > -	if (vma)
> > -		vma_assert_attached(vma);
> > -	return vma;
> > -}
> > -
> >  /*
> >   * Helper function which provides a wrapper around the expansion of an existing
> >   * VMA.
> > @@ -173,8 +32,8 @@ static int expand_existing(struct vma_merge_struct *vmg)
> >   * Helper function to reset merge state the associated VMA iterator to a
> >   * specified new range.
> >   */
> > -static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> > -			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
> > +void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> > +		   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
> >  {
> >  	vma_iter_set(vmg->vmi, start);
> >
> > @@ -197,8 +56,8 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> >
> >  /* Helper function to set both the VMG range and its anon_vma. */
> >  static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
> > -				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> > -				   struct anon_vma *anon_vma)
> > +		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> > +		struct anon_vma *anon_vma)
> >  {
> >  	vmg_set_range(vmg, start, end, pgoff, vm_flags);
> >  	vmg->anon_vma = anon_vma;
> > @@ -211,10 +70,9 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
> >   * VMA, link it to the maple tree and return it.
> >   */
> >  static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
> > -						struct vma_merge_struct *vmg,
> > -						unsigned long start, unsigned long end,
> > -						pgoff_t pgoff, vm_flags_t vm_flags,
> > -						bool *was_merged)
> > +		struct vma_merge_struct *vmg, unsigned long start,
> > +		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> > +		bool *was_merged)
> >  {
> >  	struct vm_area_struct *merged;
> >
> > @@ -234,72 +92,6 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
> >  	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
> >  }
> >
> > -/*
> > - * Helper function to reset the dummy anon_vma to indicate it has not been
> > - * duplicated.
> > - */
> > -static void reset_dummy_anon_vma(void)
> > -{
> > -	dummy_anon_vma.was_cloned = false;
> > -	dummy_anon_vma.was_unlinked = false;
> > -}
> > -
> > -/*
> > - * Helper function to remove all VMAs and destroy the maple tree associated with
> > - * a virtual address space. Returns a count of VMAs in the tree.
> > - */
> > -static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> > -{
> > -	struct vm_area_struct *vma;
> > -	int count = 0;
> > -
> > -	fail_prealloc = false;
> > -	reset_dummy_anon_vma();
> > -
> > -	vma_iter_set(vmi, 0);
> > -	for_each_vma(*vmi, vma) {
> > -		detach_free_vma(vma);
> > -		count++;
> > -	}
> > -
> > -	mtree_destroy(&mm->mm_mt);
> > -	mm->map_count = 0;
> > -	return count;
> > -}
> > -
> > -/* Helper function to determine if VMA has had vma_start_write() performed. */
> > -static bool vma_write_started(struct vm_area_struct *vma)
> > -{
> > -	int seq = vma->vm_lock_seq;
> > -
> > -	/* We reset after each check. */
> > -	vma->vm_lock_seq = UINT_MAX;
> > -
> > -	/* The vma_start_write() stub simply increments this value. */
> > -	return seq > -1;
> > -}
> > -
> > -/* Helper function providing a dummy vm_ops->close() method.*/
> > -static void dummy_close(struct vm_area_struct *)
> > -{
> > -}
> > -
> > -static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > -				     struct anon_vma_chain *avc,
> > -				     struct anon_vma *anon_vma)
> > -{
> > -	vma->anon_vma = anon_vma;
> > -	INIT_LIST_HEAD(&vma->anon_vma_chain);
> > -	list_add(&avc->same_vma, &vma->anon_vma_chain);
> > -	avc->anon_vma = vma->anon_vma;
> > -}
> > -
> > -static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> > -				   struct anon_vma_chain *avc)
> > -{
> > -	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
> > -}
> > -
> >  static bool test_simple_merge(void)
> >  {
> >  	struct vm_area_struct *vma;
> > @@ -1616,39 +1408,6 @@ static bool test_merge_extend(void)
> >  	return true;
> >  }
> >
> > -static bool test_copy_vma(void)
> > -{
> > -	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > -	struct mm_struct mm = {};
> > -	bool need_locks = false;
> > -	VMA_ITERATOR(vmi, &mm, 0);
> > -	struct vm_area_struct *vma, *vma_new, *vma_next;
> > -
> > -	/* Move backwards and do not merge. */
> > -
> > -	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
> > -	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
> > -	ASSERT_NE(vma_new, vma);
> > -	ASSERT_EQ(vma_new->vm_start, 0);
> > -	ASSERT_EQ(vma_new->vm_end, 0x2000);
> > -	ASSERT_EQ(vma_new->vm_pgoff, 0);
> > -	vma_assert_attached(vma_new);
> > -
> > -	cleanup_mm(&mm, &vmi);
> > -
> > -	/* Move a VMA into position next to another and merge the two. */
> > -
> > -	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
> > -	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
> > -	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
> > -	vma_assert_attached(vma_new);
> > -
> > -	ASSERT_EQ(vma_new, vma_next);
> > -
> > -	cleanup_mm(&mm, &vmi);
> > -	return true;
> > -}
> > -
> >  static bool test_expand_only_mode(void)
> >  {
> >  	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > @@ -1689,73 +1448,8 @@ static bool test_expand_only_mode(void)
> >  	return true;
> >  }
> >
> > -static bool test_mmap_region_basic(void)
> > -{
> > -	struct mm_struct mm = {};
> > -	unsigned long addr;
> > -	struct vm_area_struct *vma;
> > -	VMA_ITERATOR(vmi, &mm, 0);
> > -
> > -	current->mm = &mm;
> > -
> > -	/* Map at 0x300000, length 0x3000. */
> > -	addr = __mmap_region(NULL, 0x300000, 0x3000,
> > -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > -			     0x300, NULL);
> > -	ASSERT_EQ(addr, 0x300000);
> > -
> > -	/* Map at 0x250000, length 0x3000. */
> > -	addr = __mmap_region(NULL, 0x250000, 0x3000,
> > -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > -			     0x250, NULL);
> > -	ASSERT_EQ(addr, 0x250000);
> > -
> > -	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
> > -	addr = __mmap_region(NULL, 0x303000, 0x3000,
> > -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > -			     0x303, NULL);
> > -	ASSERT_EQ(addr, 0x303000);
> > -
> > -	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
> > -	addr = __mmap_region(NULL, 0x24d000, 0x3000,
> > -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > -			     0x24d, NULL);
> > -	ASSERT_EQ(addr, 0x24d000);
> > -
> > -	ASSERT_EQ(mm.map_count, 2);
> > -
> > -	for_each_vma(vmi, vma) {
> > -		if (vma->vm_start == 0x300000) {
> > -			ASSERT_EQ(vma->vm_end, 0x306000);
> > -			ASSERT_EQ(vma->vm_pgoff, 0x300);
> > -		} else if (vma->vm_start == 0x24d000) {
> > -			ASSERT_EQ(vma->vm_end, 0x253000);
> > -			ASSERT_EQ(vma->vm_pgoff, 0x24d);
> > -		} else {
> > -			ASSERT_FALSE(true);
> > -		}
> > -	}
> > -
> > -	cleanup_mm(&mm, &vmi);
> > -	return true;
> > -}
> > -
> > -int main(void)
> > +static void run_merge_tests(int *num_tests, int *num_fail)
> >  {
> > -	int num_tests = 0, num_fail = 0;
> > -
> > -	maple_tree_init();
> > -	vma_state_init();
> > -
> > -#define TEST(name)							\
> > -	do {								\
> > -		num_tests++;						\
> > -		if (!test_##name()) {					\
> > -			num_fail++;					\
> > -			fprintf(stderr, "Test " #name " FAILED\n");	\
> > -		}							\
> > -	} while (0)
> > -
> >  	/* Very simple tests to kick the tyres. */
> >  	TEST(simple_merge);
> >  	TEST(simple_modify);
> > @@ -1771,15 +1465,5 @@ int main(void)
> >  	TEST(dup_anon_vma);
> >  	TEST(vmi_prealloc_fail);
> >  	TEST(merge_extend);
> > -	TEST(copy_vma);
> >  	TEST(expand_only_mode);
> > -
> > -	TEST(mmap_region_basic);
> > -
> > -#undef TEST
> > -
> > -	printf("%d tests run, %d passed, %d failed.\n",
> > -	       num_tests, num_tests - num_fail, num_fail);
> > -
> > -	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
> >  }
> > diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
> > new file mode 100644
> > index 000000000000..bded4ecbe5db
> > --- /dev/null
> > +++ b/tools/testing/vma/tests/mmap.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +static bool test_mmap_region_basic(void)
> > +{
> > +	struct mm_struct mm = {};
> > +	unsigned long addr;
> > +	struct vm_area_struct *vma;
> > +	VMA_ITERATOR(vmi, &mm, 0);
> > +
> > +	current->mm = &mm;
> > +
> > +	/* Map at 0x300000, length 0x3000. */
> > +	addr = __mmap_region(NULL, 0x300000, 0x3000,
> > +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > +			     0x300, NULL);
> > +	ASSERT_EQ(addr, 0x300000);
> > +
> > +	/* Map at 0x250000, length 0x3000. */
> > +	addr = __mmap_region(NULL, 0x250000, 0x3000,
> > +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > +			     0x250, NULL);
> > +	ASSERT_EQ(addr, 0x250000);
> > +
> > +	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
> > +	addr = __mmap_region(NULL, 0x303000, 0x3000,
> > +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > +			     0x303, NULL);
> > +	ASSERT_EQ(addr, 0x303000);
> > +
> > +	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
> > +	addr = __mmap_region(NULL, 0x24d000, 0x3000,
> > +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> > +			     0x24d, NULL);
> > +	ASSERT_EQ(addr, 0x24d000);
> > +
> > +	ASSERT_EQ(mm.map_count, 2);
> > +
> > +	for_each_vma(vmi, vma) {
> > +		if (vma->vm_start == 0x300000) {
> > +			ASSERT_EQ(vma->vm_end, 0x306000);
> > +			ASSERT_EQ(vma->vm_pgoff, 0x300);
> > +		} else if (vma->vm_start == 0x24d000) {
> > +			ASSERT_EQ(vma->vm_end, 0x253000);
> > +			ASSERT_EQ(vma->vm_pgoff, 0x24d);
> > +		} else {
> > +			ASSERT_FALSE(true);
> > +		}
> > +	}
> > +
> > +	cleanup_mm(&mm, &vmi);
> > +	return true;
> > +}
> > +
> > +static void run_mmap_tests(int *num_tests, int *num_fail)
> > +{
> > +	TEST(mmap_region_basic);
> > +}
> > diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
> > new file mode 100644
> > index 000000000000..6d9775aee243
> > --- /dev/null
> > +++ b/tools/testing/vma/tests/vma.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +static bool test_copy_vma(void)
> > +{
> > +	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +	struct mm_struct mm = {};
> > +	bool need_locks = false;
> > +	VMA_ITERATOR(vmi, &mm, 0);
> > +	struct vm_area_struct *vma, *vma_new, *vma_next;
> > +
> > +	/* Move backwards and do not merge. */
> > +
> > +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
> > +	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
> > +	ASSERT_NE(vma_new, vma);
> > +	ASSERT_EQ(vma_new->vm_start, 0);
> > +	ASSERT_EQ(vma_new->vm_end, 0x2000);
> > +	ASSERT_EQ(vma_new->vm_pgoff, 0);
> > +	vma_assert_attached(vma_new);
> > +
> > +	cleanup_mm(&mm, &vmi);
> > +
> > +	/* Move a VMA into position next to another and merge the two. */
> > +
> > +	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
> > +	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
> > +	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
> > +	vma_assert_attached(vma_new);
> > +
> > +	ASSERT_EQ(vma_new, vma_next);
> > +
> > +	cleanup_mm(&mm, &vmi);
> > +	return true;
> > +}
> > +
> > +static void run_vma_tests(int *num_tests, int *num_fail)
> > +{
> > +	TEST(copy_vma);
> > +}
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 2743f12ecf32..b48ebae3927d 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -1127,15 +1127,6 @@ static inline void mapping_allow_writable(struct address_space *mapping)
> >  	atomic_inc(&mapping->i_mmap_writable);
> >  }
> >
> > -static inline void vma_set_range(struct vm_area_struct *vma,
> > -				 unsigned long start, unsigned long end,
> > -				 pgoff_t pgoff)
> > -{
> > -	vma->vm_start = start;
> > -	vma->vm_end = end;
> > -	vma->vm_pgoff = pgoff;
> > -}
> > -
> >  static inline
> >  struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
> >  {
> > --
> > 2.52.0
> >

