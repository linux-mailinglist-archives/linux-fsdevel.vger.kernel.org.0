Return-Path: <linux-fsdevel+bounces-74685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENuaC0HOb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:49:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24449C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB45EA7C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641544A715;
	Tue, 20 Jan 2026 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BatpiT5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8DD824BD;
	Tue, 20 Jan 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922576; cv=fail; b=RzkNh6S02f+NVP9niB8YYpZQMmqpDSr9JwSbAgnY8FOX/dQmPXhNOWSbMWo1yWIyK1iDoY2x24SVDFRskTWf2ZxyMTcywlXZuA1FxqAJmGIqMz1VC2BDTmKyFGV/Kn2uk8UpsnTuvSvmgvjpswLOg1gY6uuD0pbtL/tb/tavMF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922576; c=relaxed/simple;
	bh=Zfpw0BAdWcsBrkrTSfWCb0EbBxH4gC9djyubW6XVUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PKGOpfUe5kDUdnIT6ZilXhEvGiKdbs4PVWZoze+h+GmSe1nRr4eC+k1LYip9ARyqJFzq079Ez4bDz5hyo7bK3WMMmJpywYT0o4WXf3MTDt/+bwAV2z2LH2+y9lnM8jd1caCAkVPLOlHjcRJaq3ngipZBt3QmL88NTvwc9Vfqra8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BatpiT5w; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRuq5sr9xXC59IWTzbSZs2WcRHIbfaoPX3RynLIXA/FZOlgvdugioIW37KPo2/tS77hqfOFhnb95EqAv4n7hzsgwzI+OE2N5A1DBxUKZhoUA5eHc+YqqVUU9+tO3WvCoVQcGhBxlUwb0FlS2muROC8Jk2OsqtCuNww4OrTRorUxKFbc563nvQDebyUSCUruKaxmuxD3ieAcNiMKH6VdoqRKVeUH9hjthk/ZePhDiHWJ5qMM83+Yu33FrVhhfnlXHb31d/GWmkSPYhI9YnovdfstOaBD9Nx7BSo6Xe/0biNgjJ4uKq3C0tmtnRmTIrdhOtspxIq13LqRIOJEkgvXenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS/Jw3z4S8CbDr8yBFqBv2BWH8NsIXN4rY4iWcszBm8=;
 b=TEGC4lALJwBwE/9Zt+ay17nHtvZZbjfMDFDbhNbO6gRBPcjj6ohQ+M377j1LzvzCmdKKLKjUeHSl9jPnPzjk0eXcrxHl7T0B3Dk1/v0g8aXHM3+vbTQBdScT/c2xsUgK6Gb86JMpBg28uOrdw4RFZDHG2/HqQFlTy0xT9TnVrMQSVs/qEseCbu8bhZcIP09WMBkh0PGbdmMqQU22c6oQAr7FWfHzTtz9RIFvVRTk1VgKtmM0A0RnQb2VSiFzsKH5USXrhwWTqpeSVzLi5/wsOSXj2LOAhU2P4HbdGu3k4CYzDPV1LtYV1qKrvPReHWQY9C6deGwoyc05iLoyGozqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS/Jw3z4S8CbDr8yBFqBv2BWH8NsIXN4rY4iWcszBm8=;
 b=BatpiT5wxfqvOok1Q6llgVzWiOEqlxOiVXaD9CRKdqRlof5jySxNAC6qiyNKQF1NzjBRRgLjLaYibwrKpuM2nJoL16JnbxHxhWjrSh0C3m4bC22HsT1MCppZdfCF0iFrTt85eTUsc0yt/43blY+iT/iNtbX0ZpuTmu7+4HP1Ena//EtuScTQ5naZH9WNKsBSE195mJUGk5VljULtVviJ6fGO7oJDX/KUiNO6D8juKJKeGOcH01BcNjdZE+WkNPhTXwHlG8w8gFop2cAjzwge2T1qDoB27ZQbpjros62/yu/n8wpkR3maR6EZpptGaC04iPJbREvYOgeT92b748TMvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:22:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:22:46 +0000
Date: Tue, 20 Jan 2026 11:22:45 -0400
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
Message-ID: <20260120152245.GC1134360@nvidia.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
X-ClientProxiedBy: BLAPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:208:329::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f23315a-38ff-446d-dcf2-08de5837c3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7/Chpr1IksxhPJwyfuAbHS5ygCLDBPt3GBXthlBe6RpZEgxhZDvK/EeXGxY?=
 =?us-ascii?Q?oC/10jmPbTFepyeay+zIJL80Jil+3Z4vza/iRF8KuWN+6nMaCJF/lv9xpTSH?=
 =?us-ascii?Q?lQkpWtN3LctlXMe0rIfTKjOxvdoElVZ3qwJnmDJ5y3/i6xnxEIomBWJw6h/z?=
 =?us-ascii?Q?de7BsZ7aCLTA+oVeYluyyM1roYB51VrjvZhchUJIOQdHl+pNJ9NrzsKkz0B1?=
 =?us-ascii?Q?Wj9TtOXC1dUGoIdZALrlcudCpkLyogrTU/pXYcUagZ66z7N//trTn/AkzM9w?=
 =?us-ascii?Q?ABdXafmkX410To8JNxpPoseSKGP6DY2pPiHs02nd0Y1fZlKZBzx2fwgeMGNt?=
 =?us-ascii?Q?vh830RlY9EWbFjWf+BM9afSTmgL4sVgSAF4bmnDS1StzyDZHgVpJC5VofvgE?=
 =?us-ascii?Q?wA+/s68acWDgmDnSfgSnBu2J8IBGaxpkpIdAQRa0Ilf/sQkZtkKWoYQdg9fC?=
 =?us-ascii?Q?HxaFfpyC+7gRsjPRMdcAnGHtW+pY+MdN9l7uB/xK0HzXkMUyW7CUzuyTf5HO?=
 =?us-ascii?Q?STc/fio2Gdnmq0i7wb8lWBT5wTACfWfOjLfsKIU7eS3hIOshP6lfrn8jKiI2?=
 =?us-ascii?Q?LNxiatqpGtCbjALHlLlWFGYm7FCUesDnBeC6ADwJhzMCIB1jjXXAqkLk2Pxs?=
 =?us-ascii?Q?MRYCWFodXBj7lKQd1oB601eySZKPv8cEsUaMSR8X6WSLwh31Gc6XEqo3CIBI?=
 =?us-ascii?Q?mHBZILNttaOhZtqdgb/BQ3/M2uSHUeKhhBi+7IQmFLdM3HG2ZXFf8iTzFT6H?=
 =?us-ascii?Q?wbwzEadcBgY7Zj86zSA4gbNa/x2vbSMAGSAG0FH/K/xL/DYf9L12yl6O9I/6?=
 =?us-ascii?Q?sMzYIQL6yE8PqedOeKV4wmHLucAuRrn/tiPsUgH7EMXselvhW26zICU9GIw+?=
 =?us-ascii?Q?Kl+KmHU/4Yuj597FdeaSh+AIVgCYYZoWkPSAEGLr7XAbVbgrzpGHZWA/xWMq?=
 =?us-ascii?Q?KRzpiF6SOX9DxBJe6JskMwXY9p9/MsEmX/jUx4HrpfjV2lkLJm04o9PTl+c+?=
 =?us-ascii?Q?JZco1lxEZdnGQY0Z+okRwbd/QdjZ6OzPGPc7Rcfqpxmz/RZtFiIxg253Jt9L?=
 =?us-ascii?Q?qduu76k5nvng9g7whsgXVWJzpy04EY8ALHfwrv2F1kEuVdRpIBZO1Y6/4o7B?=
 =?us-ascii?Q?AtN8neBpLaPuPgJ2VO/clt8vXv0jCI+cTWUzZ4bk0hZ1mwmTJJN5Vu5ODnUE?=
 =?us-ascii?Q?ZsxNezFcyj9q8zcOyXQJeRj3jeh9iplYgKvWQAqK4gkl8t7qJkXvkCPawdoi?=
 =?us-ascii?Q?XVtQgm1v1tvqiTBpwLCCmozkRnzbnlmzqqMwHAfrw/ptTu619PcC9j8GHG/H?=
 =?us-ascii?Q?p4kOU3HEDzEwFaw5lECO5pp/3BA5eRBfemBf7MasT14pB+MYqrJaSC/nt4+T?=
 =?us-ascii?Q?L/i3JzM3M1zY45ykCZE1Ubb+uyqH1x0bpnE5wf4I6GTsca0aGri8rpxO3XXJ?=
 =?us-ascii?Q?ApAtfRwSeV4iM0waUe1oK/XI6/l+sSmVZLVTzUNwJ8Zbc9Srb0fH+wxud06N?=
 =?us-ascii?Q?jpTZ47xCQlKlrNrMyzR57AX0I2wktbpt1uPEn1PopWme6fnrtG4xAUt7+Bs6?=
 =?us-ascii?Q?6cthP1EFkageLU4YZGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kJlt45gk9FgL+tTa7H+v4SFi+ZNQ9RsaoVOCXb/xzD3J64tWrLguNA96P6G?=
 =?us-ascii?Q?7SST+nPcDjISbyhaWneiUsBduaQhlMxHIRTYpCbkR5ghoXHbmRxp0h6Y0rI8?=
 =?us-ascii?Q?5I1vPqVYKd9wyrlZvuBYCEHNhzb8v02soHih+e1jcOYjHaM8tmxBOxxdGYhD?=
 =?us-ascii?Q?ZOvK6ARaLitcB4xpNvAjr5WcziN3Yr5+LnScixjM7B8SG6vvlppcWDjnjCbd?=
 =?us-ascii?Q?dUFEizcOiryu8cA0F7idsAn1PHnIIOnG0f09A6dWPRzW4bI8FLBmcfjwGNGK?=
 =?us-ascii?Q?XUfqdoiwjYbYi7nv4/ewu5UoaVa+xrXof2sLeBHA6i1Q4cMcGcn5Ns1MVEaY?=
 =?us-ascii?Q?4LHrXFFwn4EzKMdl11tiuzU7ktcWjcpYVN6aGiu83kuICgyBCWqLm2UnD/Ap?=
 =?us-ascii?Q?6opnmBFoui1CWXhSu14dgJHnnc6tYBgtKn2g71qXeMTGH96nqb8NkyBTkHYE?=
 =?us-ascii?Q?N7iuF0p3z7zMq7DAiKKcoduoxlaIu2q2gmPqXDH5rgb5Gwy/xX4pkEHiFwov?=
 =?us-ascii?Q?Ms7jzTk1126qiDQH85lAo1hw7WXFfXgWnGiMNz4OhxT3f47Hjrqu+WkfWWvH?=
 =?us-ascii?Q?1zdj4r8o+5da5bqEmu/ewgOARhZNK5vMQPKXU9UBWpD7I2wkhUo0UcmlJajN?=
 =?us-ascii?Q?69fzw/1I8B62NTd052ztVbYcJGHxljEp95ctXYYKZAseaqIGERg3gFk7xcLk?=
 =?us-ascii?Q?GrMs8EL1aHmD6z4FTIqWFRsG2dhH/cJzSqk80BTXXcYLSW3WRtZmA5kLg8Ax?=
 =?us-ascii?Q?oltduum7kR6adFTgODVGaw1VtaVUIaV7dTfwu5A3wRIR7ueMTZaKTwUTrOo5?=
 =?us-ascii?Q?Kl8rixBk2M4PHmnHqWq4uDvsYc7xmy6lE2ZuNPiroHCGDnTfIxXE5eZHM7r4?=
 =?us-ascii?Q?HpXYmhi80yWHHzWad8ys+ZW5UJ51atEMNawupsF8sC+7pYkI/Pa+vLwx+HcU?=
 =?us-ascii?Q?FC8qKyyQ64BUxTQBraipnmobWvBdkRmJoPVdH3j0rLsPhaQ2Jb8+y0rGrnu0?=
 =?us-ascii?Q?EzqOu2cYeTwB2EPwaYgPVnB8eQmDZbrT6uQuQpiizfYA3Do2zC0OOnH3MAgT?=
 =?us-ascii?Q?vVkuIljFgae+LyGOTwJms0I/DFolgvgDKnUTJMq5GQn1msGNxq/0QT8MI5+s?=
 =?us-ascii?Q?l+iI9fQt/UfCLcMXmbhMzHq9xUOFG5+p4xKU7fJ1hijPnvjebxCZk6z3SjV3?=
 =?us-ascii?Q?gqmxfyCNLRswvbcFcnZdcLYfKeL3ZFYyHwZMno9SMSx6FJFekEg2n2pYrmSJ?=
 =?us-ascii?Q?zgSjrVqnWokOEsj2ZaNfvG9DmXLgQkcb5lr4lw6JzJ4blJg4d+crgXKFj8Dy?=
 =?us-ascii?Q?WHL1CvzXAOfcXDnziLm3lSiacKn8NBz05dU2yrrymizA1ZGf5KAGE8n6YGSf?=
 =?us-ascii?Q?o1cx0OAhg1FACHHxiiPEA4Qg6i4p2+FQce47GILPV4Bjs53EZjUUO/cSI5hH?=
 =?us-ascii?Q?xwQjiswzcAIpAbzs1JENx6Z66ms8wBiQkdk7sK7Z8sEi6k+4L/ogSYjdQWbz?=
 =?us-ascii?Q?dDFz23ztYtWSvkerx3VZQLAhCTWihWjegdDVYo6cXSZHnbZNkqQBZ14TIkaH?=
 =?us-ascii?Q?5CI53+w1ySmBL+MLVcOhhjff1gjyRGvkG2MxDfcq468g+7EJLfBBkJZEY3i2?=
 =?us-ascii?Q?+I41IT+fn0OC9DAkgwtEmEA2gijr0p4+HUXrI49dpu46sp/u5EaCJCUfiwTA?=
 =?us-ascii?Q?zBeVsIZh82CQ2QIBEdmjeEw41r1+NTsR0fDU/d9ClT3gSK1tKKDGwVswl9Ls?=
 =?us-ascii?Q?rrTkETDyhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f23315a-38ff-446d-dcf2-08de5837c3c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:22:46.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM8t+KncR+kVgpD+4wjpPyVDfJmX+0Zujuw179fTvzYmv7LFNzC7aE8/u6m8O1mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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
	TAGGED_FROM(0.00)[bounces-74685-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: AC24449C97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:10:54PM +0000, Lorenzo Stoakes wrote:
> The natural implication of what you're saying is that we can no longer use this
> from _anywhere_ because - hey - passing this by value is bad so now _everything_
> has to be re-written as:

No, I'm not saying that, I'm saying this specific case where you are
making an accessor to reach an unknown value located on the heap
should be using a pointer as both a matter of style and to simplify
life for the compiler.

> 	vma_flags_t flags_to_set = mk_vma_flags(<flags>);
> 
> 	if (vma_flags_test(&flags, &flags_to_set)) { ... }

This is quite a different situation, it is a known const at compile
time value located on the stack.

> If it was just changing this one function I'd still object as it makes it differ
> from _every other test predicate_ using vma_flags_t but maybe to humour you I'd
> change it, but surely by this argument you're essentially objecting to the whole
> series?

I only think that if you are taking a heap input that is not of known
value you should continue to pass by pointer as is generally expected
in the C style we use.

And it isn't saying anything about the overall technique in the
series, just a minor note about style.

> I am not sure about this 'idiomatic kernel style' thing either, it feels rather
> conjured. Yes you wouldn't ordinarily pass something larger than a register size
> by-value, but here the intent is for it to be inlined anyway right?

Well, exactly, we don't normally pass things larger than an interger
by value, that isn't the style, so I don't think it is such a great
thing to introduce here kind of unnecessarily.

The troubles I recently had were linked to odd things like gcov and
very old still supported versions of gcc. Also I saw a power compiler
make a very strange choice to not inline something that evaluated to a
constant.

Jason

