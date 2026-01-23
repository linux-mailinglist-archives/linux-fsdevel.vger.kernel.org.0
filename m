Return-Path: <linux-fsdevel+bounces-75279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B57hBR1qc2l/vgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:31:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B17F675D3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB313046061
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4932C21C0;
	Fri, 23 Jan 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YFftTnzs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bu1uHQ4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22532C21E6;
	Fri, 23 Jan 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171279; cv=fail; b=SrSmMj4xy55dU+4AtwGvZ545+HtKVV7aCmpTIY/uwssHKE/5h1PCXPzZm+0q69Xra45KVg8GA+hLASX0z7IY1ab1TMWztmGVtDtTxLegcfqAVgcPCJ1u3/kRg+0cxA9toHTNBvZF1dZUPwO3dsBDyMhxgNIdWHYxs+RpWO9DDx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171279; c=relaxed/simple;
	bh=e5TtOV6sWOWhkpTuJnAxECxrcqTYx0UW7N2XOWZXNjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyMus3ayP44Zl4ul727ihFrCWVmwZi9WBmS05zaHYHFoxvvqXs4alfFFw0OGbo++ciJZrIlWrr1Rege2nIIHLzZX+gPmUePHKGLG7zjw/Oz+lp4XA2oY/MVdcuOSocAyKdoNkZcXrGdAtLzf2CnYt0q8Tk7e8tdtnOgLP20D4FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YFftTnzs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bu1uHQ4L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N3ENAw2029744;
	Fri, 23 Jan 2026 12:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=keYryM5AFiB/AP/Yfc
	sjSF8CpTiPLtpaK+U9pZ1eAm0=; b=YFftTnzsicwxN4jumgTINiC9AOpyTxWF7T
	aQUGA6gK/GjA+dZbYsddiP1jtbQ3wsBrPluN7pPMNpUDrIVLA6EI1NZVoesCv9hn
	bJ5RuWowk/PJE2PlffEGcR7vGDirqBb5IubgWAyI5JcYp0gMRFDqoKGEMuo+GlQj
	9MofHgFk3Z0cXt9SQ4N96Om6u+igYxiQs17M8SdGCTRerABChFj3WnprwnH0CX0K
	0BRRsxA/Hb9CelqxajpqGbIbxlldAJzXRZZpbr+hefqvU0kCfPX+/PkCh3j30bcO
	CJS8qGQY3y7qqtlp/fpeHH0wgrWbcBfoNJCPfRWlxZnc5hzPDzdg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5t70u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:26:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAL3fq032913;
	Fri, 23 Jan 2026 12:26:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvesd7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro2tbNteEEMctZQGkhQkOMQ/S4Iw+vez5eCxG+TfEHml8Ievj+IXgfXXws8IsQFNKeOorcp66x3+agm9yzu45UYzM3F9INFN+AfrnhsawBLVaSnm3F7sph9AVaZoZcqGCUiCFdTgDHVrsETGJQ/VVzK+47QA1W5Rqh7+QdAyM2BMDPj11/h328Zy4+3Ges+Rq2HfHhYBdbpeIgsG0f4fhBcl9CVKu57wbDquYaQUAu4YLJYNT1EuuvJK9wcBrOxcWMLreaCt19zO2P8jvZmXoDTQCnJSnCJFHRhaiwvgrMl6HDewXRtffeGA/lXEJiSMDh/Dh6SiM+qITUAo9nU1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keYryM5AFiB/AP/YfcsjSF8CpTiPLtpaK+U9pZ1eAm0=;
 b=RWKG/rDdLBFzzF8Qhlt6pT2fLn1jE0xzMy4ZDEpgj2sXDpwwHO8piTgQtggLvrq8XepVpEAQoSBJB8EztrhcGtte9oK9FM2L8NX97ruy/FUtQ7FivkawH0wtbcZOSMZtsIyCTd6SsXmi20NipemdrlrwpjKVdSDnh+Gm1zYydIm+Dn7yKCRmZbz3spLR1yaFmqyZswwNZuVdq6QvVq+neW8lleYqd3gBTq4x7EorTWPBYJIDLuqQzhCmRo+g9y2+dl+NcthJ6J2AIbCLFitmJV4NMPK8vIpW3Q6y+uxEF4D9MpE1Ou/bXs/DUxjdz5ee0J1uxz+4pIaa6S6SkYRE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYryM5AFiB/AP/YfcsjSF8CpTiPLtpaK+U9pZ1eAm0=;
 b=bu1uHQ4LPHPA+7Y4fLIne4G/WqQZFbJhjkwvLe3M5uYaD4hMfgxA28U0DJuLtSGzPhBEyKfgyAxB/luqF+ZdYfz2n4Qlcb7OGqpbNGvt48qrPioDHtb6YvaZem174KEUdDXqUwVKYfMczVBhAB5bFTbs5bSaEz0MLcvmiiowST8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:26:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 12:26:45 +0000
Date: Fri, 23 Jan 2026 12:26:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Darrick J. Wong" <djwong@kernel.org>
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
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
Message-ID: <ad9ceac2-b1f6-4d08-9741-3cb72eeba9aa@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
 <20260123074652.GW5945@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123074652.GW5945@frogsfrogsfrogs>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: fc35f4e4-4c6a-4e23-8791-08de5a7aabfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xDckhItBDGJWbyyC9vPaY17yqhTWP1TMGBGCGs0AntuFvVSDBVPGEOOm8XXh?=
 =?us-ascii?Q?ZfM3QRZjMBJJZS+cC8T8LqHxe2RbYTJDKxZkHRoQm5G2dgT7ji913gYpaq2n?=
 =?us-ascii?Q?TUKYcL4vDHgXgpE9bfWEkM8QjTHyofgFiG2rZI5DTJZD5hACCRTfCCrgdiHs?=
 =?us-ascii?Q?4E15Q35YDUoULccEqvy8UXd+a3VdD49xypQOzWCZgg62MXxSJKq8pB5xOkLs?=
 =?us-ascii?Q?FKYASm4NSn+TwfSyJQ+N7JV8QYE+MFVpMXAAXOdkS9g5u7P2m9SsrOHZk6J3?=
 =?us-ascii?Q?eJrjC2Y7GBc7cCaJTYk7gS090Ru1IwQ5VHYygmwBuiKfTTrOlMk5T40evhpN?=
 =?us-ascii?Q?7XoAGXqrr8LhSOsCYNWmt2+MoZxzQCJv68OhCu5d/EPBOxfRNDaT2U+GymRb?=
 =?us-ascii?Q?hzFoF64QCp698ehV5BHhK6SVkyQLMZdQF84W3MCFEv94qA+8eJeMNK2o6FMi?=
 =?us-ascii?Q?6nMLy+jsPnvp80m52kuCWPysghVTDm5a5mvHmK2qmhb+bxchbt+0vHcaYKIL?=
 =?us-ascii?Q?V/foIPx4jVaWAHf3epMFqVrerotjslyNc+hmRaAiQq8RJg3RfjYcTcW4irpJ?=
 =?us-ascii?Q?tTxy57J8boJXqdtvoYdybk23mmD1zOx0aVlYM9K4db0v/O/Ir9qvwVG39pwK?=
 =?us-ascii?Q?r940PhrtK96dZrvJzkhakE5EJGJtXan8bUnBjrNkCmTm1ury2knxHx8lnWNO?=
 =?us-ascii?Q?HTi5DCyUgkZs5YtLsE9PUO1ok1LoRCF0sLKCQvgAE/J6OrCbL7SGRiJa489Y?=
 =?us-ascii?Q?9rvvXk51Yk0l+4V0lr40GkmOh77rZUrr3aLbk6GWhod7kEbuwpJjLy8hLDZg?=
 =?us-ascii?Q?qmwaPgsLISZCsuRAOA/N71WCp+CTjGM79LryAc0RYaihvhTIRah9EOlBJHzo?=
 =?us-ascii?Q?I34Sx24WsgA6cDxDodnwpbp18+vD3t/0O1pODSc+bH/N1pp3DCgolVLGgz9t?=
 =?us-ascii?Q?vc14I1W88I51Dr9uogN873b58rBG+4YN2IoeJn+QQYA0vapiSyMrbvTiQnyj?=
 =?us-ascii?Q?ELHqTTMH/J6JyPt6ppwpERDKtI++acgODe7foE9SXcCOYyf2mEstMLC5+KJN?=
 =?us-ascii?Q?OOyeXOu5FAd1unb/+8iKDWi4fUNwLMZhyY1T+eqO+zQw5aisLY5dLTXdoiWX?=
 =?us-ascii?Q?lsEjIp9LJolfWLfGVC4ZScGvVnK/qQYdWbH4p+SV97ZAXPIFAZtW7P3JKw7r?=
 =?us-ascii?Q?wNDRjDqF2ykV8S8wNberXPGL5DE/2E/N7nKigHJoEZvE+OdQuq8ZKx2lYGPY?=
 =?us-ascii?Q?QZDVLL0xtpwT4g5yytUDid7diWz6D/KvCA6t9D4nhtt8ivByIAv7C7hBR2FG?=
 =?us-ascii?Q?95WeA5jXh/fYU6AbtYUsfiu+6AQzTC3Iv1q83Ic690tXG7/r1d7pwuqB9jV/?=
 =?us-ascii?Q?/1MJLmQ3YVD81/laVlbB6H3Cb8KLU1WHtEfh2h0uOkFPXRJY8Tec5znCZVLH?=
 =?us-ascii?Q?EbRBPzb79ZdLv1TJnsCZ9y76HQ+PbxrrBflGFfUgWxwuut18XchkIirv8wbl?=
 =?us-ascii?Q?jtdjtpHJ7OJuGvKCjUFUo3hiVZXb0NtFJ8Tt0EdQKtn0+l2uz8NSQzxIsa2w?=
 =?us-ascii?Q?+YtHZ69Bx4eEjJHFs0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vNZRBHEzhAAY470+2RaS07yBEaXNHO0/CD3PpgjlfjMRK9uRlNrg599/L73?=
 =?us-ascii?Q?ZX/fZ1UEWTSZKdZrJ9p0tJsOL3CC1eUj1VFYhbG5d3wOky+11NSFoHhIzXC0?=
 =?us-ascii?Q?C19/RlsGZLkZPnsvMy1S0ED2aOt0FfcVtavY+843eZs8GR/cbVG+uZefigMN?=
 =?us-ascii?Q?ZdBATixqxYNCr5i7Op8oOhi0zeJUFgAAJUadcUwfcBtlmH6p1qVfbGc7thvT?=
 =?us-ascii?Q?lv+hkdYAaow2rUf6RAJGsWEyCyeAy8ezg4yUYLhr5ek76PvVwXRG9Nj61w7L?=
 =?us-ascii?Q?/9HCJShMg+ikraDIO0ZUibxWxuskhc0gKtiAZg6g6/zf9blg+ZUK1+GWNQhP?=
 =?us-ascii?Q?fbrPLZcPzcCYMtbUbv6GFQ5Pya+Oq3eQ8LK/eTeEwZKamux2ZWepXvLPN7us?=
 =?us-ascii?Q?vRU9WFBhSAEqqw14RLWLbxDP6/MixmpJPTNf8MPKppXP4l/BK6NnwvCMPe05?=
 =?us-ascii?Q?BzwZppINwk5OLHLSpLf4Xp/QOQI7WvVcP1bkoYmhQPyb6C1CVEMhmkOJEitT?=
 =?us-ascii?Q?VLWoNGFWhYLXxP8FxIWU53W4f1shrEJ+vTDQH6CO6MPYGrAJDYoH4MpHQ6MQ?=
 =?us-ascii?Q?7vp7eelNgmZJ05AufZtl067TqtZKLifa6TywNrnnKGXG6DSz34+1tva2CzWZ?=
 =?us-ascii?Q?A1gVQvlvSKJZXO7Og7dE8o/LPNpMa2yLa5PidVcTOSpRZ5S71B2HorDNW4om?=
 =?us-ascii?Q?SgSXCOSbcBbVeh+XPQAWHojk3eMhmY86Aw+nMXCzAGlv9ukjxCBDgqT3Q14j?=
 =?us-ascii?Q?97iIj6zjuENfxFCLiwPyKu63XMAqbFc8eRbi/ERmLLjW7v5QIzGJFOfBhbnr?=
 =?us-ascii?Q?4mxahI4v9gN0Ww+LYbjdc1He9jDwXUpLZp1txRS4CsJtY2OY94zu5bEoL+Wu?=
 =?us-ascii?Q?akyR6lAXi64Skbm3/jjHmhTS65bBgGQk4f90CUf095q7pjBA/9/pQZ4iMXHp?=
 =?us-ascii?Q?c79uyhcfDTtascWEOgsT/NVC7+aTnZmhcIp9WDjqZe/WmSodlxSpkSe89XyN?=
 =?us-ascii?Q?9sTHf6t9Xe+VT1/btwJ6rduBf+2vfrU99Tp1fqSRmLVQDkTYj9BF1mbJRp8u?=
 =?us-ascii?Q?MOqEJ02BcipexNTM2fCHfb1BVPyYeHLAX01uD0BV14XaNaOwLM7xGtmktmWX?=
 =?us-ascii?Q?RpvVJRp7bvBxEUf95eRX1TgYbjAYijkr41h2R+O/wW3NClWudAyazblEzW76?=
 =?us-ascii?Q?vdFXR5jkgDzEUqxmVdePrU1LxcjpsVjgzxfVS6fv/BhYcUu4A6/PJv78eq/z?=
 =?us-ascii?Q?myj0fpWTO2rFWt8PJQTuwH12GHMwWXdlxfMf01JbL1Ukqnl8w94BZQR/h9p8?=
 =?us-ascii?Q?IFz4BEkkMOOeWmOc8idyNp3mer47Q3lcOyvGWohppwmHu+gylcPb0SW/Cm11?=
 =?us-ascii?Q?bRCkavWJ3qKfrCmChsR92zvfIu/kc++MBhoUOgiLkd8PTmOyBwFd/fXPs4fn?=
 =?us-ascii?Q?DloO7wPXu5fmzXgrTn+o3eiqvV5MAvmDC28FzjexvUziI3lJidAFY5iBRCg8?=
 =?us-ascii?Q?ZmdL1HQWbvmPFvMr1c8+MzWNtxja9zVPYsYQM+4Bijt3OG5zZBKvBzWqlvql?=
 =?us-ascii?Q?Cjsb1zNNXEZjaL4ShmZivdN6+CUxYzsnazF/vJCjcx6GYCxGWZhfWuQYRGeK?=
 =?us-ascii?Q?vhsHeEAeAoeGasBdpjaATFMKoBRfzWi2nbXakALQ8+jUYuc2xsgtXG5rZ6tn?=
 =?us-ascii?Q?ixWruurgoQffn5DDCHmDAxefGApSIZBauc6aZGig3V3JOrKD3UljNS8xFPOy?=
 =?us-ascii?Q?kE+s+A8jA6juA6O4eZ/ER+JNEBZk4bk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KDQ/P0JmmhwQNFsvVv1dsTXqHssOU+XkZhtQf8apxZzoA/Fmpq9O3BYxIfHWJh6M2CJ9MTTcmBSTwtH0XI8iM8BZb2UdVZd+pVTYxsNFcYJqpEW6HBFQxEQ7dT4m0BfeOGZApKfpUYOA7i59UreQ8k0Qpqt6qCDUyX0gZPCuPGIeGeDVrO3hwdCI2/BxIb2O6gDhDwe3inFKvGRNY/7I668qCL4HZPHCtbn3x56K+rHNExOQQc7WQ+7cWxIDUqw15SThzIqLqKFzvIN95znA32hi6TetwYDeavg6DYKvMtvyEpN7F+r79NNqpY9NHO9GOuclsjq4nycRcd70uCCULrPi9Ac0xPSkSBRDJ0O1655+OQfOhKEaPptqRGmfMXGv7+Z8qUD+Q+lxN5rcCbwewqB89USRZCB6bJD0yoQjAF5WWqpAlq+5sb1iD4DfhOwMrBRfAJy36f4rSq01sFkK/guuRiHrEPQlyNAbXi3eamN0h790wsh4EaWN9xUPtK//pA6zqjbRy71gLn/lfwk3yTBh6p74A+n7XZtQZrYd6a2MO6Jctld3gcSRcXqMkeohXfAmXdsf868wyErpKWuZ5LttGpeVsli+cxmRE0HblvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc35f4e4-4c6a-4e23-8791-08de5a7aabfb
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:26:45.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcJ7gPcZmuA73X7jceOrX4r56uR1hoHKOwFynHYTuRpxX0wN9BM99gIXgzFaUAGNcM9ujz3TwU03sDPpllIgGtfeqzu4O2wj8WHCZ/u21mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwMSBTYWx0ZWRfX56Q+ElbGHOOl
 WuKKtcj0eDk9wj4JM6pjlT/ElFm6uRw0Tqtq2k6MgkuBtcU95j4qb1N9luq8DY6EhYrY2QLF09n
 YqZbcxd1l6Be/w5nLI+ldAHw8im9tJpq10LFzAW7Jwe4v/qhkEbmXMe7Bwvu35qvkZ6nZ2owLUz
 3P3+6kmUT9CxeR6J8fyZGAowKCuMtSXRMREcZrqZvRfWjyjZomvJnxvQy4rVOqQnvbaDjWnDQBP
 yxkgB8Z8w4B4m3/PfK0qx+xH3+nB+iDxr8VCiQcqqmzCLUcfFsPg8h0NY/vLW8PCr7tGgH4L/dj
 RKjcmj7EruZumFppWW6pIJYtyIhm6bLD3CQovW3t7Ue1oFmhqn4szq9lHTeaaswYc4okQURRnmR
 8m18xOT7rVRUC470Ua5pjkX8C84jiACSeaXhPg2HHmLdLFNZO9kIbs6l7Qgtzz/iOOw8IOF5b1u
 xFHWfixHT5pUWAFoLCw==
X-Proofpoint-GUID: Vtc2vZbA-D7s2qccy8FssJUeiFQcC1bq
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=6973690a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=qRh2Kd9NKieOObZev4IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Vtc2vZbA-D7s2qccy8FssJUeiFQcC1bq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75279-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B17F675D3B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:46:52PM -0800, Darrick J. Wong wrote:
> On Thu, Jan 22, 2026 at 04:06:17PM +0000, Lorenzo Stoakes wrote:
> > In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> > shmem file setup functions to operate in terms of vma_flags_t rather than
> > vm_flags_t.
> >
> > This patch makes this change and updates all callers to use the new
> > functions.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
> >  drivers/gpu/drm/drm_gem.c                 |  5 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
> >  drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
> >  drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
> >  drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
> >  drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
> >  fs/xfs/scrub/xfile.c                      |  3 +-
> >  fs/xfs/xfs_buf_mem.c                      |  2 +-
> >  include/linux/shmem_fs.h                  |  8 ++-
> >  ipc/shm.c                                 |  6 +--
> >  mm/memfd.c                                |  2 +-
> >  mm/memfd_luo.c                            |  2 +-
> >  mm/shmem.c                                | 59 +++++++++++++----------
> >  security/keys/big_key.c                   |  2 +-
> >  16 files changed, 57 insertions(+), 49 deletions(-)
> >
>
> <snip to xfs>
>
> > diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> > index c753c79df203..fe0584a39f16 100644
> > --- a/fs/xfs/scrub/xfile.c
> > +++ b/fs/xfs/scrub/xfile.c
> > @@ -61,7 +61,8 @@ xfile_create(
> >  	if (!xf)
> >  		return -ENOMEM;
> >
> > -	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
> > +	xf->file = shmem_kernel_file_setup(description, isize,
> > +					   mk_vma_flags(VMA_NORESERVE_BIT));
>
> Seems fine, macro sorcery aside...

Thanks.

>
> >  	if (IS_ERR(xf->file)) {
> >  		error = PTR_ERR(xf->file);
> >  		goto out_xfile;
> > diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> > index dcbfa274e06d..fd6f0a5bc0ea 100644
> > --- a/fs/xfs/xfs_buf_mem.c
> > +++ b/fs/xfs/xfs_buf_mem.c
> > @@ -62,7 +62,7 @@ xmbuf_alloc(
> >  	if (!btp)
> >  		return -ENOMEM;
> >
> > -	file = shmem_kernel_file_setup(descr, 0, 0);
> > +	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
>
> ...but does mk_vma_flags() produce the same result?

Doing a quick fs/xfs/xfs_buf_mem.s build suggests so:

Before:

	movq	%rax, %rbx
	movq	%r15, %rdi
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	shmem_kernel_file_setup

After:

	movq	%rax, %rbx
	movq	%r15, %rdi
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	shmem_kernel_file_setup

Quick google to remind myself of x86-64 sysv calling convention and RDI, RSI,
RDX = param 1,2,3, presumably top 32-bits of registers already cleared and so
params 2, 3 being 0 is correct.

So yeah mk_vma_flags() would work too, I guess EMPTY_VMA_FLAGS is more
semantically nice.

But actually could be nice to define EMPTY_VMA_FLAGS that way rather than the
empty initialiser I use now... :) Still no delta anyway afaict.

>
> --D
>
> >  	if (IS_ERR(file)) {
> >  		error = PTR_ERR(file);
> >  		goto out_free_btp;

Cheers, Lorenzo

