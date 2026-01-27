Return-Path: <linux-fsdevel+bounces-75597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL+8GJjDeGmltAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:54:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED1952CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE53301385D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE035BDC9;
	Tue, 27 Jan 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEQuxTfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6433491D5;
	Tue, 27 Jan 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522036; cv=fail; b=fo3FuGJv6FIn5Zr76tXHQzRZF8BpVPWVCuHUkWAnWcTqB3g/AZTvb2m/vwmVrOA9/gz86Q0Z38w532AjrP6/uFz8pP9i1LrHicDxYpLuNEt5SCBSQ07aMZTaiegw4sTqpb95YmeE158kcKtKnG95eF+cjKmakFelB9C4TYuLrmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522036; c=relaxed/simple;
	bh=MhrfkX3dTksT6K9xm/iT3CPlegeUFhmrjzurclDVAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o6ycGIcsjq6jTz6nFK4tuxUAMyyKnvPeJbmRZ+5HipqRPdy7SK/A4vJaG1D/MANxHPMthpplaQXWzZLUJQN6sJZcnc+3+AZU49G4r8A/HrA/OIiiw1MbgubwizU721NJ7MQp0MxBbE/42LQQmg6xUHUaA6fjBVCRbEMgXFvJ5dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rEQuxTfL; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoJSBm+KCKFpH+/YERTFRm9qpvrSgblyoWTqR5N4ypYrMyxGsNPuKhw28ga/dQSWFHivndYkGabEyocTpxWeJnDQFpU+UrCUEo3X+1UiXO4wbfKju7caDqEBjEiFfHO2lR7lNMXA7Z7KOaealXoSGh6gt4Idrrh7aoV7tD5LPdeRheuDurTrP0Xb0bZ+otpu/vZ4PvvIpLqVAAqzKWIukUiMTKZHolkbsN1YgXNtTlBIbxvEZW+9wZ4jn1F7+CZU/bmPCkpQZ/8loUJhLBBqNJOWCk368gu1Id6fqXY4H9bmlEgNyWJOMIb+7rNofNhFsj/IE/4uGXydchgBnpWm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp7r66ObLQb0uIcsfYchKUCHoARYZLzJSdw5YZym29E=;
 b=yc/McpkpE40/U1EIDkQhwuSazZVcfjtylRVRT67RNC8pxe6WMp4jsDWsqqpGDIdfrB46X5IpEyO9rg5ms0fSxvX4Gc+xMrs64bTiFVOfDX32VTmkGE6mfTXoui4y7vV2G/s7nJnqkg0egXRboYiuOkLsV37tVJudX6jZljihbFtnUPIQ5Nh1QqdMzH1OUnFURBVHlTr/rDzpgjJIlOWBV5aAgpatxKzZ02+nReE23ut9lryj/8nn9m5KpxsYTUcgNvzZ9F1L57NYlqGrVssLQdzYfgb6pQrGXrZsMSe85msXglRgqwbduBlQkg9QsS1k3lN1FyBR6TAeJYfUjI9nfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp7r66ObLQb0uIcsfYchKUCHoARYZLzJSdw5YZym29E=;
 b=rEQuxTfLSa3ej3dyz/LwMaY8zCZWuS/7Uj5hrA2fGjIx24GDHRHTaYGKIidmhfn2dnnZ6sOO86SPFxv/wVDMaVhVu+pZT6BxcpZm/aNMffFFeaoMVZqQCawL6sZvQVeBGDaOPTxlnN9p1bpXb1B0eksF6vacn+fC2CkHOWm5iVtAQrDLFmtD0OnOsgFrOBKBic/YTgPEGcdB34nZ+C/DlHDDM/OOSdThSQVToHuU9hQwswOjC70q36PoAKZuvF+XRp4HrtrdjBxVFBG8JX97hOq+3y9Gny7S9vd+FdOxfkiyiZw3wo6tEzHEsARh5NrL/B1txQWbB5mzVvOydnINKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 13:53:47 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 13:53:47 +0000
Date: Tue, 27 Jan 2026 08:53:44 -0500
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
Message-ID: <aXjDaN4pwEyyBy-I@yury>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BN0PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:408:143::35) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 54efb381-a22a-4dcb-5551-08de5dab7da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1Z3sdgypy98NySAh7VUz1YFlwyjsRQpJrTrqge9OT4LxBhFw1ZHWhwA0kn1?=
 =?us-ascii?Q?EdWdIv9zU1js6p6Pp2iGl4JWRZcrxuwSPLiz1pysjXk0XhR8x6+ODtUcNvUO?=
 =?us-ascii?Q?QYqkeVk5EuibIcjCueohuHzciywhjCpUuSLFtSiAQth0S2QFfqLVk8epQxlB?=
 =?us-ascii?Q?P+uNJBRyQKfuPsrOlAnC1mJQKgyWEcbL1omRs9OmRxPB/empTErC2+XMQjf9?=
 =?us-ascii?Q?viZpoyBhoh8SYLsH39TVxkZ1dlA/8uKvCH3lH96OkFkpnucXxvgfrDrGK93p?=
 =?us-ascii?Q?QoVbm9hoD3zO0s+FPgcMi2vyeFYoIQL6TepBk2fW45ghkNYjJvm03IZyZd+U?=
 =?us-ascii?Q?hsaTkus/O2xO5rstKBjQ/VG9fJMPS48nLM8xbitOB2JT3XGUcVIb1Ov48zqN?=
 =?us-ascii?Q?+YiX9vKbWRibPsF7ypn6cCDkRK+i4PvZWQ9XO0Pk6KqE4rlgiC5XjPWu4TMI?=
 =?us-ascii?Q?QlkQs4+9PBRMJNhTtpdcLchatsugmyu1I+a5QDijQ/BeO6Xcpx95K8vbTNdL?=
 =?us-ascii?Q?EUg123AXJNKh/swYOE87Yk06VOX+cUI07BZXOo41ZYXGB9fwQ9Yz8mRheoGW?=
 =?us-ascii?Q?YLThRouxAjfTrOFJnwYOQu4myR6liFhUEjsBUrCZxp9rbbyDfSb++LNoNeu+?=
 =?us-ascii?Q?7SA48RlXXBP3ZaGQr1/xYMdob/lyY1k5K7IQOM36vvi4QJpYsm8ZYuZsyXfR?=
 =?us-ascii?Q?RWF5CyQ5QFHheivpot7YAX5p/FbqiCuTxJU2e/1apVu/c2BwaU7qHds+2GV2?=
 =?us-ascii?Q?E8Fg4AAre46CRr0YBycL1GnSMfBtakl59DhxM3ObThuJbSqg/NjOUN7uAF9E?=
 =?us-ascii?Q?2rQnTqF1/Y7h+GhiA20369Mv++0epzdq2y5yF0P9rO9ORWuC/bgSSInm3a5E?=
 =?us-ascii?Q?aKv5AEgVySzB4jdHnHDmojAoGKQ2FwFM46k5tvEwXRvQNVQNmc7/J7aqbUrT?=
 =?us-ascii?Q?QBlEr52LXZPjpvUEy7F4rKhqI8fKIa85f2FjYqL31TKyy2Y0l5lKbJGdW+rO?=
 =?us-ascii?Q?qxMfeLzb6RRN2WA+2JiD/XqQCL+plCFdhn815t/N78+bhkY5qnLaOa5/4ItZ?=
 =?us-ascii?Q?IjNbQQKguRED7KlFOpVfiYz1Frk47rernMsI3jrLIHqIl4ZXecypKlR5vmXD?=
 =?us-ascii?Q?ey+2Ru3PPYbxN0KMY7p7KDJQTxFZ03FSG8yluYGtyhDFowL1rl+Bl0RtHS3u?=
 =?us-ascii?Q?KG7zi+/txZ+JtWsnhOP56mLkt3lY2wLTYQu9ER5jn/9cimUIxjBzIQ7t0ua8?=
 =?us-ascii?Q?SvUpyozlDeNlSjlKH1u1jp3s/y7iu96fMLEETvrIqAcDUEXuU5MAa695DUU6?=
 =?us-ascii?Q?w80zgF0Mm8PHW2ScKrgKVY1lJ3N+Kx7W4RUjOjGRxPtKMuS/IBIH07tk0kg9?=
 =?us-ascii?Q?AwJcx1VEtkd5T4HiypcslGYET99M32oON/n09O0XH/5+5k/CQvuCme7IsvHV?=
 =?us-ascii?Q?7QfLpwHxYRGXqMK+P+f9pulFKt7Km3ymMz7kQu9M5Jz0FUGFOGy/JSwToDPg?=
 =?us-ascii?Q?53OQPSw6aYdIrsciIVNmuYaUlVaoW9nOQ8OS72obrDfIyPcpQ7E6Nb57R+4B?=
 =?us-ascii?Q?H016jP3M7mGMnVfDajw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9+6Fz9IQu1u9yFAziFzK3yyroCvzjZUZ91LbxNzlY9aItC4HbHrRA5L/GrL?=
 =?us-ascii?Q?eBXzf1q15dhNY6aIaeaYq9K1lMkNk4RcSeyDF6C00Z/SSGsMQJlsK6UklzzB?=
 =?us-ascii?Q?r8FwlqMBcIpKe7YOQ4sF40N3QhOmQRcBo/ayDPJDZwSZL4ZoPSV1Ah4MS9oc?=
 =?us-ascii?Q?7itM1LSW0lYVeCH/wguHMJu0l3Xf3NDGkY33I4MknGd4Iwod6QzON971rSZQ?=
 =?us-ascii?Q?aY8p4Bd63rhKwZbOCfEy1spWInuJyRpdNyArgd8lWZ3KzmcXwkwnABQc4Iiw?=
 =?us-ascii?Q?SaLXhoFwMfJre7B2oOfgtwxbgOnhYeOr/c7oXIJhgbTJK9idx+eEJkmY5F9O?=
 =?us-ascii?Q?ikuQe6OAvIwQt5A/gdFePo4rEHXbjI4yRCeSSJNVOfSotsYm6/8wjKon3kso?=
 =?us-ascii?Q?5wdnldELIATp//HBQhwEM+21WESDrUUgREr+xoTRFPn1eDRzyFn/eoEA4+xF?=
 =?us-ascii?Q?ZveILnVv2YYlB6yqZw6EqM60+VdrhFfEqKWcdUaaoo0gN+KRnkKjAueqBb5l?=
 =?us-ascii?Q?g9qQhqoAPj9lF9XmhuJJgdUdoRpzMT1JK4Qc1YeiaHo6dgkye1kTsiOPjtEx?=
 =?us-ascii?Q?KAuJj1iBPcO1PIdYVSKD8SeWs1mDfDmP5GsoWrjaHY2HO6YdgwrVqKFIyzbt?=
 =?us-ascii?Q?TXrZpvYLzeFlD/tzOlb9B6US/3n3S5hLtkKTWa1b0zV9vV/f/T66eJq8+10Y?=
 =?us-ascii?Q?/9vjrgu4GmmVul9BW/m8/vC3UD1azefKU4zkHb3tUjp3y73/cbxSjNIFtufz?=
 =?us-ascii?Q?+nPo8O2PsJ/aXLlkURmNljGfhUL3Ko9T3Q/+By8RcwLat2a/NgbV3BgsCRI/?=
 =?us-ascii?Q?f5uSBvN7zeMROhDy6Sc92KUfk7rR4GFvFxGXAAs277jXTLPtlss3kJFyZlvK?=
 =?us-ascii?Q?MahHhH51uz/MEm2hMcpzhfwwtfd+aPcOVItP25UdKBkTP4FBoumS+aGt7Umy?=
 =?us-ascii?Q?INFGi8JQgYTfEfQnLRQDFH07YEtMMUeqNyjsh0+W5UPWH9ygIHMRHogCCKTv?=
 =?us-ascii?Q?Ws8i06glyPrB7CzfB9i4iAcnuFreOu8iRusgo3kpPTZrZK90c3odwlHhns6N?=
 =?us-ascii?Q?vsR3fbHB8tGWmaTYtmPtgI/BMbaamPCAynCGFhzbxzNVt8tAzIt36f1zgvr/?=
 =?us-ascii?Q?5VjnybLjtoX4bFBDU5uKqyl8BnQzgUWN/UMDqZYEuJY+5XLlKyr7qFEhWzoy?=
 =?us-ascii?Q?/opH+kNjzMN/pZ9Q1VAcp7+mR6Xoe4GulNm2ID47CbWhe54WDqdgRuJ01xY5?=
 =?us-ascii?Q?aS7S7MtoMWYzlJfodvUofJjmweshr+HPFB2yJ26YwIAWiE58VnQ6XHo8pumL?=
 =?us-ascii?Q?Pm1AQQsp76yYfYitM6mpAV1Q5ou/2OfzzmHPLNXcWC/xX4SiGqvjt4VVeYWg?=
 =?us-ascii?Q?SgL8Tg/u55/hoajnKbRBWURVhmUY1JEO+DlC9TyE7U4qSLlQxKXHW6Hf5+KO?=
 =?us-ascii?Q?DaFSptzO9A0utOKzeCXepfigOp985wD1jjKV3hJf6Jo4zQ947nn2WzTzitqI?=
 =?us-ascii?Q?X9iQ2F/ykOC4YSTExqY2YrCQwz8K8NylmwA6WnUBLI5YteIJKxSLlB3SZVm5?=
 =?us-ascii?Q?tje/gLefKg+VWoqsqXqQdelfw+WHwhUNyXavSNzq/CGd7oMDuN3XQogbljzQ?=
 =?us-ascii?Q?0XB56sMEwv1NTGayQGu9ibQNXfmQtYLoyds8T9dXzpkTk54Ruhu77zFydOZZ?=
 =?us-ascii?Q?cj+/e8NwwBpAo0oXEFd2P8xArwe3MDGMsymtbVNFkHbBCBCYiVxkiCudGzmT?=
 =?us-ascii?Q?UbtUphY1zlA1geR8FyDDB2YyadDjTxZl8qRF2nrqPmv/ueujTMlz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54efb381-a22a-4dcb-5551-08de5dab7da7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 13:53:46.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NnDDl3DNBs283dtEngBrphLoIRRxNKNUyR7drzZ0Sm+AZ0f3G/bwfnAnW+UP+fBRdsrWGUZY2LUBFZmPZqp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75597-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAED1952CE
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:06:09PM +0000, Lorenzo Stoakes wrote:
> We introduced the bitmap VMA type vma_flags_t in the aptly named commit
> 9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
> future growth in VMA flags and to prevent the asinine requirement that VMA
> flags be available to 64-bit kernels only if they happened to use a bit
> number about 32-bits.
> 
> This is a long-term project as there are very many users of VMA flags
> within the kernel that need to be updated in order to utilise this new
> type.
> 
> In order to further this aim, this series adds a number of helper functions
> to enable ordinary interactions with VMA flags - that is testing, setting
> and clearing them.
> 
> In order to make working with VMA bit numbers less cumbersome this series
> introduces the mk_vma_flags() helper macro which generates a vma_flags_t
> from a variadic parameter list, e.g.:
> 
> 	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> 					 VMA_EXEC_BIT);

This should go on the bitmaps level. There's at least one another
possible client for this function - mm_flags_t. Maybe another generic
header bitmap_flags.h?

> It turns out that the compiler optimises this very well to the point that
> this is just as efficient as using VM_xxx pre-computed bitmap values.

It turns out, it's not a compiler - it's people writing code well. :)
Can you please mention the test_bitmap_const_eval() here and also
discuss configurations that break compile-time evaluation, like
KASAN+GCOV?

> This series then introduces the following functions:
> 
> 	bool vma_flags_test_mask(vma_flags_t flags, vma_flags_t to_test);
> 	bool vma_flags_test_all_mask(vma_flags_t flags, vma_flags_t to_test);
> 	void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set);
> 	void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear);
> 
> Providing means of testing any flag, testing all flags, setting, and clearing a
> specific vma_flags_t mask.
> 
> For convenience, helper macros are provided - vma_flags_test(),
> vma_flags_set() and vma_flags_clear(), each of which utilise mk_vma_flags()
> to make these operations easier, as well as an EMPTY_VMA_FLAGS macro to
> make initialisation of an empty vma_flags_t value easier, e.g.:
> 
> 	vma_flags_t flags = EMPTY_VMA_FLAGS;
> 
> 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> 	...
> 	if (vma_flags_test(flags, VMA_READ_BIT)) {
> 		...
> 	}
> 	...
> 	if (vma_flags_test_all_mask(flags, VMA_REMAP_FLAGS)) {
> 		...
> 	}
> 	...
> 	vma_flags_clear(&flags, VMA_READ_BIT);
> 
> Since callers are often dealing with a vm_area_struct (VMA) or vm_area_desc
> (VMA descriptor as used in .mmap_prepare) object, this series further
> provides helpers for these - firstly vma_set_flags_mask() and vma_set_flags() for a
> VMA:
> 
> 	vma_flags_t flags = EMPTY_VMA_FLAGS:
> 
> 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> 	...
> 	vma_set_flags_mask(&vma, flags);
> 	...
> 	vma_set_flags(&vma, VMA_DONTDUMP_BIT);

Having both vma_set_flags() and vma_flags_set() looks confusing...

> Note that these do NOT ensure appropriate locks are taken and assume the
> callers takes care of this.
> 
> For VMA descriptors this series adds vma_desc_[test, set,
> clear]_flags_mask() and vma_desc_[test, set, clear]_flags() for a VMA
> descriptor, e.g.:
> 
> 	static int foo_mmap_prepare(struct vm_area_desc *desc)
> 	{
> 		...
> 		vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
> 		vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
> 		...
> 		if (vma_desc_test_flags(desc, VMA_SHARED_BIT) {
> 			...
> 		}
> 		...
> 	}
> 
> With these helpers introduced, this series then updates all mmap_prepare
> users to make use of the vma_flags_t vm_area_desc->vma_flags field rather
> than the legacy vm_flags_t vm_area_desc->vm_flags field.
> 
> In order to do so, several other related functions need to be updated, with
> separate patches for larger changes in hugetlbfs, secretmem and shmem
> before finally removing vm_area_desc->vm_flags altogether.
> 
> This lays the foundations for future elimination of vm_flags_t and
> associated defines and functionality altogether in the long run, and
> elimination of the use of vm_flags_t in f_op->mmap() hooks in the near term
> as mmap_prepare replaces these.
> 
> There is a useful synergy between the VMA flags and mmap_prepare work here
> as with this change in place, converting f_op->mmap() to f_op->mmap_prepare
> naturally also converts use of vm_flags_t to vma_flags_t in all drivers
> which declare mmap handlers.
> 
> This accounts for the majority of the users of the legacy vm_flags_*()
> helpers and thus a large number of drivers which need to interact with VMA
> flags in general.
> 
> This series also updates the userland VMA tests to account for the change,
> and adds unit tests for these helper functions to assert that they behave
> as expected.
> 
> In order to faciliate this change in a sensible way, the series also
> separates out the VMA unit tests into - code that is duplicated from the
> kernel that should be kept in sync, code that is customised for test
> purposes and code that is stubbed out.
> 
> We also separate out the VMA userland tests into separate files to make it
> easier to manage and to provide a sensible baseline for adding the userland
> tests for these helpers.
> 
> 
> REVIEWS NOTE: I rebased this on
> https://lore.kernel.org/linux-mm/cover.1769086312.git.lorenzo.stoakes@oracle.com/
> in order to make life easier with conflict resolutions.

Before I deep into implementation details, can you share more background?

It seems you're implementing an arbitrary-length flags for VMAs, but the
length that you actually set is unconditionally 64. So why just not use
u64 for this?

Even if you expect adding more flags, u128 would double your capacity,
and people will still be able to use language-supported operation on
the bits in flag. Which looks simpler to me...

Thanks,
Yury

