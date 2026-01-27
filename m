Return-Path: <linux-fsdevel+bounces-75651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DudOgcweWlovwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:37:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000D9ABDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C88D300720D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F462C0268;
	Tue, 27 Jan 2026 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RpMkBW0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1B28469A;
	Tue, 27 Jan 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549822; cv=fail; b=Ldt/ZO5qJxzXq55DVjVwns5jbZs71wG7qudj6ZLxmlCIhNrvBA+IQJYtrqcFsU+OXFCyjUi7wNQoDNXw3PzmlUJvoicfew2bUmxq1fv2y7wvqjqNzapbehu6CMONR/mccfVR/GyRPsooPH0zilGHLN3Xu73QjqCZvGjrxpUAkzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549822; c=relaxed/simple;
	bh=jGK45oPnIug8Tg8H9nYMWNWysr8GBSUjYm03cmpFyyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IXSfhQ75VQgRCl7PpcpsmLDfeujAsjTap+xQH5GyAHaV6JkylkbCIjifbnMzPcTGsw7a/ZiugD9LAlDxeiC+/b7nADVhmi2SNFe7LsgzYjUlKFOJHXZa11MEFyATR6iSyJr7QN8RcU9zcjWcqK7UD7jUSACPhW97BqiHLm0Htnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RpMkBW0T; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXNpxYZPw8pXapf+T9FPhcGZWo81ilcCLkKNA1fXrkUisP4wmezqsiygZBn4tjJ85McBX7zoVVyUbyB0jA8udwCXuuW1b2/DyWjQ7+evquA7AgwkiVLMry9NZMsbhIHgcvkmyIIBa8yvPQExws94BLY6KJXl9cBk6fYPgSHKr1WJk6Rbz/h7U7ZyTIPJBQvN37ghVpgIVW55OoCg6kR5pTsy0DXj3+GzLKcMTWI8KnQovtkaNXTs55JV75iQIsbB1vRqTAJGJOnoqPabLcE4VnTNrAFmZbq1eXl2Kle6srukRQs/4DT3sPI2atpHiEY2DK0sEgHa6Qkm3otXyVS+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qv8p9swejJ40jcF2xi9qe5Fp2Kt5Ct6peel7ONdu54=;
 b=kQN89yT0riLtEG9ahpe/BtL7ofgc4VE/SO++HFs0aPWjBUIGUeh5p7csO9dfxSsRcXn+JPFdHY9PKPeoNt1reNpjbNA2wbYdwPQBhSpO/iTSY+YodvcOvjwTakkTbWPCU571iul5FXQaD3Mb669+z4Hd9xlCYOm9pYom/z7rT5RcWxM0GEe4iXueonGsJzhZGTX8vELL0UbwQHWH3Ry5Qxo9j0ahs1js0o7N6odREuiFqtA2fWHW01am6DEm41xSbOl4FbMBDEcroez3hQiPl3xtvEzje1qRykuhgfqCDq0NCMzeyO6uMKcvO2B7Rd9l1fzArC6KvWrwqdc5BFerzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qv8p9swejJ40jcF2xi9qe5Fp2Kt5Ct6peel7ONdu54=;
 b=RpMkBW0T0y/KsE3WQkthBOhVVtR/hQf+VW8+bHb+Tvn5tH4UD6UezSgDNvw9LmjM9MFzoB3YYKu7CzsR7j0YIIOB0mxV7JPYZwK4R8FTO1IoKEfvMRdhuius6maWGWb39QIQG89FjmSt9E/EwkUZCVqoi2Vhn9X8gzrHvrFKzt9Qp+rYTfokW6TJCFaG62JFckOXaibw6hxFLhSAQM35moJCyHcGcVeHE2F4ZrbMxi5HhMuc45Rm14kNrIyLELR6kfgo8Pkfo6NLtp9AN4DxHZaJKLoDSC0neFPzwgfqhA7iujtIBcIVWJCD0JZf8cqskaUKT2KPNOzZpFYefqWVNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 21:36:49 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 21:36:49 +0000
Date: Tue, 27 Jan 2026 16:36:44 -0500
From: Yury Norov <ynorov@nvidia.com>
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
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 00/13] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <aXkv7DSUbdY-RD5d@yury>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <aXjDaN4pwEyyBy-I@yury>
 <5f764622-fd45-4c49-8ecb-7dc4d1fa48d6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f764622-fd45-4c49-8ecb-7dc4d1fa48d6@lucifer.local>
X-ClientProxiedBy: BN0PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:408:e9::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 9715e4eb-27eb-46f4-124e-08de5dec2d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/CxFGOmbCbqIf4nVNlqlax8EqAx+3g0xSd7lsfdJekbBxdAXPS7XO7aq5Aa/?=
 =?us-ascii?Q?Fz3XrLTea5juPeYALAIdLfSryni+ZvFO1A6JgvH7pfyLM1eocH/0P/c2LcqK?=
 =?us-ascii?Q?TF2wNlR47IAtORpVVCNwNoyezQxl232MhFdHIA08ROQ3Q2Mt4naD1klB8XqK?=
 =?us-ascii?Q?W6pJUpdod/z1Rmj2BUIzrkkKbz75ckPMHmHS+OVlLLozgO/30jPyWgKxsN72?=
 =?us-ascii?Q?WkgwunEbCfIa16G+cpcoTUFEHwtBwpIKfFOaQc1UEsFPdz+cROavwqJu914/?=
 =?us-ascii?Q?MzUQQ4gj6SgI4sr4TIlHGILs+sPS5M2rNjgo9GWFdLuGfuvrYh3adDe3dgQ7?=
 =?us-ascii?Q?OtioEdB8AYQiijLs+iEx4Ar5BDIK/9fima6bDf+rRIm3iTZtAen7l2LqUzsF?=
 =?us-ascii?Q?bcOp5Fv6EhekEfiXNdnqpe1qJeg6+GjkFVZhCpbhiQ116ZfzQzaqfPzm43e/?=
 =?us-ascii?Q?kExvyrWEryUcTz+v9WwZGBPXSeIybka4f1qkmaIW2kOG+sONJbdr2nhnMwO0?=
 =?us-ascii?Q?hX8Z8Pv6anPYiYeoz/yuGNH+/o4RsCpjtXFU2bdCmlRdZ9U51Si0TwPEjefs?=
 =?us-ascii?Q?sg7gvzQihC4S8HsSAL7UPBJGaty0K0CB1Y3gTszxXUa9xgPbQLMzWf5y3aVx?=
 =?us-ascii?Q?Z7yTgjDsToTGh6uz50HJmZqnc9KeoJOVMlTfGLRvlOF9kpx2UQKO6VHpDv4L?=
 =?us-ascii?Q?UhMTx/o7SvqxavW/oezKQvSRj7Es+wj9rCoVfHuu66ewQX2uM17UhcNJ7umS?=
 =?us-ascii?Q?lorvi0wtzlhrpZj2cpWefb1Ijlnp9gEO78Ru2HTnj2IcEKttGtMA+SVvY8qg?=
 =?us-ascii?Q?OAXPv0I44fEXgaQ7jpC7AL6/ReD2P8KxNJf2D35zXcI5afE2j4yHXjWPLroW?=
 =?us-ascii?Q?l3MtlrgtraS4S5ev+4tpTIGPKyFzvinb35mnyaFKkhlVO/ivMny6IDUepBAV?=
 =?us-ascii?Q?blCrYzGS6YiOdOnRy8zVeBNO0UJKtIlgjUDw3JMrd6kLUdBe9Q8CbndMMcTa?=
 =?us-ascii?Q?BCw2qFy9gb4CH3c3yZKQuKF8Ybw9Xx3uu1wDipQFP9Yq7fY/UfQddW0NcCdf?=
 =?us-ascii?Q?Uha9UJpw75t1oJkVumk5S8+0XyFcWWoq2kNKwXOcbxtww4YlMRhFlB4K8Rzy?=
 =?us-ascii?Q?AXcezYr1yQzBniT+lXwUnO+Oij6E4IY6ZKLGxGSd9vj5cm6zsqxbEXqxmARs?=
 =?us-ascii?Q?+zOp9S1y3uDbY2ojcJSHmZL23O9X1h8GTGmN8s6raLkhtU7IGC9grgw4pqNV?=
 =?us-ascii?Q?yOh08QRCT2pnLfhoXvL1uZpJbKb64LZcqVzvaupRbfcP2m6ArxrSiTPmgVME?=
 =?us-ascii?Q?x6TYoYmTPQxrqaQ72nViEA3VJ5S+luV33Ix64fwWxnbwZw6K/sXmwE+xJZSw?=
 =?us-ascii?Q?zEmywJg3Pzt2bltVvvof3584zlLOKMQ9ZOq8Re2gYszykswkTGRW/GWxJhOh?=
 =?us-ascii?Q?bQWi9IAvjjd8YyrD6eNF7WKJUHH5+G334ug4uqO7FjiAxjYaXjZPqkT9rMvj?=
 =?us-ascii?Q?2hdXMlUhLEe9m4xQjzQftxdg5D/BWdWe7joDKNvQ7gyx5dEl9tAqrmZVMZkA?=
 =?us-ascii?Q?rF7aZYX+AxkDVe9Bn9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nVr7vf4K4dD5oV9cnVY2LyP/cQnbgrl/4k7k5SNCjndzCk3ODsBCSvLNneT0?=
 =?us-ascii?Q?MHVVrq8U05fL14fg1qZ/ePW5eAXd0QhqbijK3TfxQFAYxQDv8Av4P2kkjVtP?=
 =?us-ascii?Q?esLecIFlRrj7+uwllckDyzTvoNnltXYtv0a9giyrDj7ea4lv5pMwCzUm80yg?=
 =?us-ascii?Q?vA8JjZVAyBJYTc5QwKtQ5ZoqztIGE+OK5C0ehUqaQ/RHJukz/NRLr92ErW60?=
 =?us-ascii?Q?nyJyMJykBnT8SQv7XVzgRVFCEewY78kKX4UC1nD8WOTZ0zsJ29inMt0kfedP?=
 =?us-ascii?Q?Q4Tohnw9x4D5anQDoynDGC8EaAZ5TzYJkGQ1PJ1OPZYFWHCb3LOoD/hnQ9NN?=
 =?us-ascii?Q?nal46GgENpV0VBjafRfN+0JCFgXvh+bHGaxuMUgl0Pq82My4+RaqjkiG0v+g?=
 =?us-ascii?Q?asFXL5BIKsH6QCYFY5+qkk8sQ1HoWWqhz2v+8APmtsFqNwtIXbgoT8IShJTj?=
 =?us-ascii?Q?T7BjS9+R+QLtvo2klfwOsncZTnodVLi10USkU+Y5yws7GTsy+bbVtLnP3gPD?=
 =?us-ascii?Q?Mc3hbuj4YEE/x2Dt67VL/E+ufl93u5CXmPAqR6HSMh9z4QmUFU7YisAw2Mco?=
 =?us-ascii?Q?qviE20o7ZJ3mWeqD4szpnpr+k7xMBDE0PyKD7Zsr+3c/qR1tPSdYII9e4V03?=
 =?us-ascii?Q?zLlZUitJB6RTVV3KVaBw8B2XSP4VYvdvul5oFfCRR175xuNsn85XH9cwvsle?=
 =?us-ascii?Q?RzH3G9cam9ECRPekQUtvdW4dghZD/biGnuZ50UwtwJPAzq8ySk0gwsHz6Lme?=
 =?us-ascii?Q?UIYiOqo5F897jgCwErUcEO/BjfWffpjQEkvD0vvytSTf939CWWKy9z/W+YVz?=
 =?us-ascii?Q?mMCsF46Q/KZO53dATdRbatRFfxQwpgPmaBEgarRlD8unm2icPK05kLlF0M88?=
 =?us-ascii?Q?/eWHYdfcYAyYqV1j9CwmD2JK3ZMuCR+U6+h5IJdzQQd8OYSliyQsKsuKDe2l?=
 =?us-ascii?Q?xoxwCzRxMrGJ6vjMVsCgJ5IWrEFcdhklsyA7I84X5ugfpVSGeCkeWPETveWm?=
 =?us-ascii?Q?3iUvR1NH+Z10MzLqYMGbONK/Vhozr6nMyWZLosRPPIq6GrvMhxBysFVcBxby?=
 =?us-ascii?Q?dSeoXvQcAUvmk4w1B9VmGu6aFSq7aZZsR2ZcRmBUE+sDNm436W7qIRDDcAzx?=
 =?us-ascii?Q?lHWbdGpu8vmvvofm8Bfzl3+abzt6FPplapMlAbZsRj0zaOgg2OhHJdjmHb7A?=
 =?us-ascii?Q?sSsfP9Q7fcqw2xB8OGjwnfMPZYJUiOGj8KdGCv3y09wHxgHOIFarzxjda8q+?=
 =?us-ascii?Q?IWgxqeOF3ucvO4YaZLCfslnvnmON3MO5pfB7omAQrIr2zm5i8zS5R/kNep8M?=
 =?us-ascii?Q?CkR0Pjh8UR/0a131NKfPrsYUSaQOsgzdH9ytbGoqgOPVUdkas/U2F+/YdfQ1?=
 =?us-ascii?Q?K0B1eh6xiCHpJhuqT+Lxo6mgphnMR7ImcuJTP6geQKgy/Sp4Q8xfyhn7n2pJ?=
 =?us-ascii?Q?gvZUSr3z2EMATrKxrxv1vkG+Dn6HbyBgxeLHeUuJ1SqpRvPyATqfaVxmcc6Q?=
 =?us-ascii?Q?/YURxDwmu9gLa5EvFW1lmq781zUEKX4v76bRAisP9Mu7zLFhaaD1Zit2vJbj?=
 =?us-ascii?Q?ad7w3J7g5ZtdcgJ3r5CV35pu9ytgR0id0DHV/vz9VnGCu8Eca9wDqSNpj+Rk?=
 =?us-ascii?Q?znOA6BVLTS49d6JyOKzXkuB9F4/IzcFf8oVw9/kdIVJUAIScY8+ZE9nH3u/g?=
 =?us-ascii?Q?BjK8dxAQ0HkRg96p/a+qEdjRnwgHv0gwciA3o4DU6NsvOOMuB0/dgGDXrIWE?=
 =?us-ascii?Q?cfHoqYuTMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9715e4eb-27eb-46f4-124e-08de5dec2d78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:36:49.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJQwMiYJ1JxNiQOeUsQsB3o0tMV1NN87hW/jO/8uLDBsvXWmb3F3KJNuykw328t2Qcr1qGkVlVVw3FAcJeZsmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75651-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6000D9ABDB
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:40:03PM +0000, Lorenzo Stoakes wrote:
> On Tue, Jan 27, 2026 at 08:53:44AM -0500, Yury Norov wrote:
> > On Thu, Jan 22, 2026 at 04:06:09PM +0000, Lorenzo Stoakes wrote:

...

> > Even if you expect adding more flags, u128 would double your capacity,
> > and people will still be able to use language-supported operation on
> > the bits in flag. Which looks simpler to me...
> 
> u128 isn't supported on all architectures, VMA flags have to have absolutely
 
What about big integers?

        typedef unsigned _BitInt(VMA_FLAGS_COUNT) vma_flags_t

> We want to be able to arbitrarily extend this as we please in the future. So
> using u64 wouldn't buy us _anything_ except getting the 32-bit kernels in line.

So enabling 32-bit arches is a big deal, even if it's a temporary
solution. Again, how many flags in your opinion are blocked because of
32-bit integer limitation? How soon 64-bit capacity will get fully
used?

> Using an integral value doesn't give us any kind of type safety, nor does it
> give us as easy a means to track what users are doing with flags - both
> additional benefits of this change.

I tried the below, and it works OK for me with i386:

$ cat bi.c
#include <stdio.h>
#include <limits.h>

int main() {
    unsigned _BitInt(128) a = (_BitInt(128))1 << 65;
    unsigned _BitInt(128) b = (_BitInt(128))1 << 66;

    printf("a | b == %llx\n", (unsigned long long)((a | b)>>64));
    printf("BITINT_MAXWIDTH ==  0x%x\n", BITINT_MAXWIDTH);

    return 0;
}

$ clang -m32 -std=c2x bi.c
$ ./a.out
a | b == 6
BITINT_MAXWIDTH == 0x800000

I didn't make GCC building it, at least out of the box. So the above
question about 64-bit capacity has a practical meaning. If we've got a
few years to let GCC fully support big integers as clang does, we don't 
have to wish anything else.

I'd like to put it right. I maintain bitmaps, and I like it widely
adopted. But when it comes to flags, being able to use plain logic
operations looks so important to me so I'd like to make sure that
switching to bitmaps is the only working option.

