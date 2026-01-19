Return-Path: <linux-fsdevel+bounces-74548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA18D3B98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FDE1300A9B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAA82FFFB2;
	Mon, 19 Jan 2026 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhwHhWgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uctdaZtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858ED2F90DB;
	Mon, 19 Jan 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857674; cv=fail; b=ttNaTE50aEpIkAeFBygRpgzmh8AUVZTodCxWfxNVnSCwshSHkj+YLnTgkLZQD5uHbCKA0ez4RpwuVrr7Z53UI5HkSq8HXbELFY4JkG8U5W1xxJGDRuQ/mQXkzRDpuzu//9eZ0niC9vmT3uqlp9JNOhMB/uQABaOBZP/t0tFe9YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857674; c=relaxed/simple;
	bh=tf7lpqB3NQntSw3Lpl+pECSy5SVKHnwSnF4/UYBhB/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wwmb+QSRlDUlsmrYDgAw4xkSPu+1XKeDxD6LzaYNgHGfutWlyWFhd2Q+jvs5LjWKTccLvOlABmX0snfW0YuHThOVeWCx4OoiwiQNwDI0kR5GOlXEBqLfRH8/8zMw6RTL85vHe/YacOeoh7v7N5wICmCsPUVWRIabgH8jKgfPlXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhwHhWgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uctdaZtv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDRjx1269413;
	Mon, 19 Jan 2026 21:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tuK3aAzqu17k3RgUNLxxDzUnVyvUaP6w45olOLY99GQ=; b=
	JhwHhWgl7jOyFFaN1p2mjWyMKGr5SEKYfmjHuvTJ5H88Adtd2dpxNh7IEe5UcrOy
	1uulrnLbeYr9PW8ZfPLbgRUHTgquZ+qDyl6nyAif95llCr2tYDJvDVhyWzOFerE+
	z8dZyAZVtJ7nAy0WxzZauw3NOIcn+cnpmKbQEPDUsNlpAkSolCLJZw0JimKEITOF
	dtWFg0ZM9XQBznDWV+baA5bPvnDhZCw08VFORI+NB8H78EPBtrShACYT8ZSS43ry
	DqajyNo3gCo8f81J38bIugmuOc1UsPn6a7deokV8nHFPHppanfMACd+Wmcvjhv5A
	0c+eCZhBwvTAs1VkB/avtg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8as57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIQNgZ017988;
	Mon, 19 Jan 2026 21:19:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sb8j-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5XPQi/7eerV3LCYePJ9xeMA8JCBh1m719iD6iIQiaK8daeYdkd2vWi+n5e3IcTlC4F+B5dUY8dhBJiaWUsDBwhCq6w6U53xz1hk7wPmh2lr/gkeypej1wNDqqWIM7AHH1iKoZe2lz9HH3OYxz4FoxupjdWH6YaX01g7OpI6ckl+e5uA1hD4dCtapp+/0ovTwOeyXa4w2ja1Of6Mpcq6odcqbSVEDTJ3vcrdtKd5J4ChnIjFL6De7zopeXDoxikRX0BM4lkp1eyALSr6N0yBPe8Xq14VUScEFndT+3wTKquZa5VaSPfro0/H66y48fJcCNCi9AMJfi7TnORJHC682A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuK3aAzqu17k3RgUNLxxDzUnVyvUaP6w45olOLY99GQ=;
 b=JhNAMKY7aubmlKXvCyGzWlP7Olu/EngofF0zZgaH9Z7jq7uZGw9Ev71ioiOkYDoPaiT7faWJYeIb0f3eU3/uGL+8G7yy2HH2eiO2ieK8Ti8wUNncLAg74lm/tOm5JXsTPIBcQi8ZHTb+d434R1Cn8tfIYLLDoVzKZvZ0RWdf9P9auRep+TKejeWF/u2T9Jrq1IUFbrExkvJCUDxBXltK2PZeCtXUU6Xlb5NBsfyhid+NoUT0lvprxvOLpCFe2gTqKDmdDIgGELpSmZYcCv5pcv9jcwqqBVcKqQDDZb4xuNw1XmC43W+k4QZrjLyaZaU3yjMg07zSHOeqcclIsG3u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuK3aAzqu17k3RgUNLxxDzUnVyvUaP6w45olOLY99GQ=;
 b=uctdaZtvuuoErgtNBqGDJKtkk9sY5HCO2rH7ekGYMDa+H1bQy3Y2YdUden4sszY/famBJwre1lJB4oUYk+Fguo45LzuyIClkq24WPNgGO7lhjqVIJQhOCtC39vBD3/xsMPosWF84lUPE7y3wZNrxoiabhtRm+Ek/UdeXtmPQvQ8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:48 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:48 +0000
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
Subject: [PATCH RESEND 12/12] tools/testing/vma: add VMA userland tests for VMA flag functions
Date: Mon, 19 Jan 2026 21:19:14 +0000
Message-ID: <5a3224c9913e4d57d039ea4ddcc1c3c47adf2315.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 458b9127-1273-4215-2628-08de57a07a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FflnhQ5E8GUmiWmws+xIhtUkW6UOBGtVKTpZajOeE/Fg0V7mz4H8N2e+jJ8o?=
 =?us-ascii?Q?o+xAKXTMDbiEeVSMdisrb4+AcTD3TfH3MLx8aU9GgyJBJWhFytW99S+AwihR?=
 =?us-ascii?Q?MAPmZXkUhppsDWjTh7MWBlgkUMFfovhAMnw0DncuqCW+DI5RqBI59ZfgNP+L?=
 =?us-ascii?Q?hPjGfiTctYU0vaTGTGDUDfo9DCfYgFwud9Yg4ioIOpf2FF9qUeBvsZdFA/GM?=
 =?us-ascii?Q?cMiZI2m8UCVjnH5pUQil+GZmNozt0cF1kMAyRxyH1VCQ5fky1oOZPsojZjx2?=
 =?us-ascii?Q?D39nTfSedTAs72t5V8meo1giDm9ALVS2/m+YreeDiWPR/b8Vj0oM+OS1D8jP?=
 =?us-ascii?Q?7fLoUqrrse4JG3/1FWRkjdzksGrzGieU08azPx9rMUwY9aH08OeRASOJttKA?=
 =?us-ascii?Q?JcBdA+8/C+KFsBQDg5xJEPJZmZiPzF9TTJjwTue9sDK2DIuDZh+YsFKkhT9S?=
 =?us-ascii?Q?RWgXeBQFb6BVE88nojCYFYO2Sn/N/VlgWz8mYcsFmMdESqX40j5YBZmB8/xR?=
 =?us-ascii?Q?826qD0sZZ8gKwxPFuREta5a7KzkPSs13NcT57Y4bld9gZK6z88wlu7QPNRXz?=
 =?us-ascii?Q?rO33ZCYT6e7jywGqFz8wWidg9558veRUg5x8F2I6BetKIeQQ3ngH9aTNtVYQ?=
 =?us-ascii?Q?BP6264QdzlbkiXdyZNnHb1yyV3ncUjg59A5zuIBRggldkLlceTEsSUTabdZJ?=
 =?us-ascii?Q?1on4eAzJoH9JiQbTKP5VGXeHxLTXECjW2sfqMuATiR65mDPAb6GAyXJ8+ryu?=
 =?us-ascii?Q?zxALY19eVS6qKayfGy072NVCz8OcVsrZG1MOckC0lwJ7h1DiCOQHqOvDkl8t?=
 =?us-ascii?Q?u3StnsdjT88f9uPu44Zijto0wmpfcdzYUsOx/uenWrWpAeicTQDEe1FuaAvc?=
 =?us-ascii?Q?FVFfAaSTL0DdHo2LAIsyM1R5ahA0FedjmloaEHsmwzGfxsqKnxYiV9PB4NJM?=
 =?us-ascii?Q?aJms/eNOG36CfgBywxOyxr9R0U0aj+KE/TPT1VicYN4uwi9Dqk/tIscZnBRn?=
 =?us-ascii?Q?NmPwGhN31o9n1PF7CtAaEjjfaexn5S33UuG1EkLPh3J1SGYCn8JSjHrOndCK?=
 =?us-ascii?Q?2NvsEl0xBvaLis6MS3SC8m+iuHPl7kq/iRRBj3fJLzv7JfJKgnBjfyz1NWvw?=
 =?us-ascii?Q?AKKa9qguLNI/LW21MLTzsw/EnpBM9xM3oTpbf0YeE6y/FndF8oAD1OfDlzyX?=
 =?us-ascii?Q?kWxohtvaX0ObhgOd6/8asT1pNEGs8vUBzpus2Ga8zLYOHNZjsFZkqOTnKBht?=
 =?us-ascii?Q?vMviVWdYaTpUYcJ1bjRwiWf1Rq17HL0jjK6JPRnyGt3kCAs4291WBI/v8Unh?=
 =?us-ascii?Q?PZKrQVNbI5Wh+x46/4n3ZrEnk+pN73G80WthLnONI5WuuZDqq6YkWjETJbid?=
 =?us-ascii?Q?Hf9dkfOIWCjuOjAM4YwyH+D8vEFECFv1BWwvn7q5GNFkKuN+UNYiFDrYFl4W?=
 =?us-ascii?Q?od8FCj8aJEYM1f/aIxPAw9ZYAm4YMjhb9fzDhhzGjc5G+SVzVIMoxAdHXnxs?=
 =?us-ascii?Q?srx9qoHzMYPwidB3Kf6BARqSpXxpNAz+d+kgquMhPVNcNNOelmSJVexsTAY0?=
 =?us-ascii?Q?HW0TM1B6P5/pTuDOUxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qx42t219nzJzB9D07y9chXPPOmlV7ZPsuwoN2U9Alh/EWhYxONVWiegw15Fv?=
 =?us-ascii?Q?vnH5HLzb44vJABrKXQTOq03tmryHlICdfVTJUIEm8Fyui9zSQ/yHOHjjs3Vl?=
 =?us-ascii?Q?5RoJaRkza1Gu2H2szRcflkVhlaMYcVzwOqfBOrJcYd9CsOmjnNDd2jw2BpTp?=
 =?us-ascii?Q?mk1kPUdIFqcpQobkRlmivSw73iqn0bs9lxxBgo8fjsd43LnXLQuwxtCYKNlz?=
 =?us-ascii?Q?iDb5UBrRbuzEh2ge7Og6x52lC5k72siLZ7xdqy3FgYjPpX+9Ml9cy386kwQU?=
 =?us-ascii?Q?OjmAHvHCJ05Nzl+4spc24Y1wARDp5xZM95zC3CiThFQpeXl8tpLx2OORoVtz?=
 =?us-ascii?Q?fp/9L3ifyhlibxjDHLpzHW2sPltd8y4LZzpCTKTWyzbrEzjoEOQsaNdpU7nl?=
 =?us-ascii?Q?nkqJYlFGkiMf2tLoiwZkWf158JNi2kgp4tqjgOkNNlkD17WmFQq1yRwd0h63?=
 =?us-ascii?Q?0ISP0Af/Po4rYJXjH0rpYAZdzPx1yM6J5Tj4yy1BAN/KTfAR2ZgxVOrGLRAb?=
 =?us-ascii?Q?IYdJxFJiCiYYv9mqPDjC0rIZoAmwU8w57h0xG98LhIhcFN8xZMx4xxLJnjQl?=
 =?us-ascii?Q?spds41HHvo7ADv0QrFC/lBmWb9QUDR6tuUTeGY4cB3QQZlOQl8zodRWcePMj?=
 =?us-ascii?Q?0mUr+3qLf0OeULuzekt+2mcY3swbaMLyup/t77oQmGMyXsb+m8kqiSsFf5Aw?=
 =?us-ascii?Q?fXLvhdBVa83pHitHVWKeBNDsfkMv6kWn4HWnq0wtXXCFlBXCY8tIpFT4Fmc4?=
 =?us-ascii?Q?p6LvL2tRn9ivY6LOWpVfykWHR6JnPUdyCj2ktPQAjHIrZ/51831KNBt6ivvf?=
 =?us-ascii?Q?LDFLz2eIcNH2IfJI9lIsZnHBbcNv/DG57O0evr6lT/yuJatmL6K0YBh/C0e3?=
 =?us-ascii?Q?ioz/OGz4dSHQl1GY2bJKJTU+Mk27dHn441rhn4nWyX1ENAHCIdLCjP6pmB/r?=
 =?us-ascii?Q?kActwYhwB8y6MlLqA8Z3LW8Q7NqHBLdiIbcroIIYs9YKrasuhYAS79Pr9Ynl?=
 =?us-ascii?Q?zXJ1eQ3Cxhg5N1wHkV67Y3+FlKLTkEVUanuSXaiygfrF59BQT7mCanNSTmcl?=
 =?us-ascii?Q?3bLvOLyDAkdccgVvQT3dQJJSlzTBzU1HFDnNn7v1YCLECYduFt3MwENrNDeK?=
 =?us-ascii?Q?bYOxjwjwg7aF8qzsgUTDvv1wrKSbHTOCAgOe0gD3VnhoANNcis6MmaqYDogf?=
 =?us-ascii?Q?4XPFG2Xdf1PAKJpCYr62N0ik2QLb5fkObt5HW167k5LCRAp1x5aa1MWvhxE6?=
 =?us-ascii?Q?lxb3gKuL4siz1TOYYFecd7kwO8y+G4pyc9/l/pRwMGgSyT8gKt0vHkYj/8o7?=
 =?us-ascii?Q?VO5cFwMl5Oveai5HZDiPKbJvvXeMszaO5AGfujgVQpI7Cg7z2RLg7vetKSKi?=
 =?us-ascii?Q?edH4ehpUevbyGz9hPIPL6v+O6mIaec1kIfUwU5OvSvd8qxA3cXSXAs3vhmql?=
 =?us-ascii?Q?1diHvZTn/Zs9hNBpgq/WhL1CsiI3fX+9VHZYBYYMQE6aThlu4piemtESOr/5?=
 =?us-ascii?Q?UAho5lEmHYbPxzqp1ptyHVjiuw1HI4rf3iu3GfqCZuVNZQQlQAxPrP8rSNky?=
 =?us-ascii?Q?LLH6iJ/WT6b7F+Z5lS5tyRlWEZR2NOzWvzJh5q8KctzLWGCGqmtHNw+MUicx?=
 =?us-ascii?Q?icOTpy5skLOlSJZh5CIANlefS1Glgt1LNRODyNrWs5Jr//Vo5PvLZswovnxK?=
 =?us-ascii?Q?fLYUk1eifl+17kZs0ipuZzzbEZq7HtB9rIn7rG1hqQjPyDJyZRzXruREU00T?=
 =?us-ascii?Q?vjaTvMzQ9scf4Vd+iUGTUtUdBx3mI+8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4hQbhMLkFePK1B/q1Gk+0qavTqBRsEsC7970HXWcNeUiVIIkuANJV3USS8i2W9o2Jyayojw48Pk5G8iDJIEwjc2m2uOkHGojPM0NyIan5uymQFfISZeVWUzfV+3dKZbTDE8mXzAWZsdJ/wOgUwf917OWBrt40rCKQSn4edFJx90S91Ax06y0V8PQb+rPSB6nVHq+eki2BjfMYY/M5xJsXGSi0KdX9eaZvPxubztEJcQs2G/5gbOVEb+I7KujF+AJi4cwA2F4YL13GLgpw0QnoouOskNVHDvFrv//DzL1sL3Cyp6ef1XpaoB6ZxkRNHNwGRenkbsoZcihbqRkOI9uq/KIFm+7g82pwqy6uaNot0XFNyKXKmT6KJksjcEj3ATDFT3F2hInJLVmpjpnQJZmUA1SKiVjMjDa6GQIXEmIIjGEx9RQE/LjusRw939AVMU8ebgNA8+rlQcaH9TBkdW29e0KoZVoRN3+Qb6j7CVzTOEmneubrjoeXyAaz3dvJTma3Ij0MauJZV4pVaqe+KNgIyMULbsSs//nJRzdHCkR+gQVN+/9oDqg+41LcY+Dakj/HMWI5Q7qFj1ryujwfzntYw9pZNJoygMudDRvIymkiVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458b9127-1273-4215-2628-08de57a07a06
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:48.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEaE1971+amMSlzy4OfMJliMNv/6DkY7+ddP4z0ihxon7QFSlYwfb+3d/sodVyp0kD9hRjWijJlIv+KoR2gSAqRBmrwRrxIojPuH5dBsztM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e9ffd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wdtOZTiSbmFhyPzmQ0gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfXwXcVEYey3/s9
 8f7F0XUyeDQHgIob450lxpqjmAMxUT2wB1gJHJThY7S6CWmT9p4a4zyLq59CT2UYkdz3h+BPTp6
 GFU5SJxTsMggRzR/u27QBedCcflNFD8nxWjGDwJJvGUcEC5qoWufXp9tHHIMz0sfriFUUUoGxrL
 J9Jm413DVO3HBJU7O0LfG37jJpmfPDEkBm/51p3kzBlJuZOmdicqUlfrFeCU4D88m8L1Nd9TObw
 VVuauv9vv4zFO0awLkXm5CaCFyrTJzucTmF6lQdsWYVuLeqBh9VbjI8KBOo6CBHDkVB48418Rj8
 PqPQ3b3aleGfe8AvGOduyMiuLUbTHW+Rf4id5V+gYkbI92oT9B1FPsETYsCOJlK9yMES6fQm7GG
 uSJs/+HYNbyODDE3hsZeet8MpzmH6mph4iFNjzSDxhlbtHbc+bQh0UwHYeYXLiWONwP8RX7++fu
 FuJ75LQyExdxzhT0E+w==
X-Proofpoint-ORIG-GUID: 6JfiMpAIsoNZuGZ7lKuciHe_HtBsPt2I
X-Proofpoint-GUID: 6JfiMpAIsoNZuGZ7lKuciHe_HtBsPt2I

Now we have the capability to test the new helpers for the bitmap VMA flags
in userland, do so.

We also update the Makefile such that both VMA (and while we're here)
mm_struct flag sizes can be customised on build. We default to 128-bit to
enable testing of flags above word size even on 64-bit systems.

We add userland tests to ensure that we do not regress VMA flag behaviour
with the introduction when using bitmap VMA flags, nor accidentally
introduce unexpected results due to for instance higher bit values not
being correctly cleared/set.

As part of this change, make __mk_vma_flags() a custom function so we can
handle specifying invalid VMA bits. This is purposeful so we can have the
VMA tests work at lower and higher number of VMA flags without having to
duplicate code too much.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile         |   3 +
 tools/testing/vma/include/custom.h |  16 ++
 tools/testing/vma/include/dup.h    |  11 +-
 tools/testing/vma/tests/vma.c      | 300 +++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h   |   4 +-
 5 files changed, 322 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 50aa4301b3a6..e72b45dedda5 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,6 +9,9 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma

+# These can be varied to test different sizes.
+CFLAGS += -DNUM_VMA_FLAG_BITS=128 -DNUM_MM_FLAG_BITS=128
+
 main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h

 vma:	$(OFILES)
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index f567127efba9..802a76317245 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -101,3 +101,19 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 	if (reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	/*
+	 * For testing purposes: allow invalid bit specification so we can
+	 * easily test.
+	 */
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		if (bits[i] < NUM_VMA_FLAG_BITS)
+			vma_flag_set(&flags, bits[i]);
+	return flags;
+}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 3eeef4173e5b..f075a433b058 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -838,16 +838,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma_flags_clear_word(&vma->flags, flags);
 }

-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
-{
-	vma_flags_t flags;
-	int i;
-
-	vma_flags_clear_all(&flags);
-	for (i = 0; i < count; i++)
-		vma_flag_set(&flags, bits[i]);
-	return flags;
-}
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);

 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 6d9775aee243..c47eeeb9d80c 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -1,5 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-or-later

+static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
+{
+	const unsigned long legacy_val = legacy_flags;
+	/* The lower word should contain the precise same value. */
+	const unsigned long flags_lower = flags.__vma_flags[0];
+#if NUM_VMA_FLAGS > BITS_PER_LONG
+	int i;
+
+	/* All bits in higher flag values should be zero. */
+	for (i = 1; i < NUM_VMA_FLAGS / BITS_PER_LONG; i++) {
+		if (flags.__vma_flags[i] != 0)
+			return false;
+	}
+#endif
+
+	static_assert(sizeof(legacy_flags) == sizeof(unsigned long));
+
+	return legacy_val == flags_lower;
+}
+
 static bool test_copy_vma(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -33,7 +53,287 @@ static bool test_copy_vma(void)
 	return true;
 }

+static bool test_vma_flags_unchanged(void)
+{
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
+	vm_flags_t legacy_flags = 0;
+	int bit;
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+
+	vma.flags = EMPTY_VMA_FLAGS;
+	desc.vma_flags = EMPTY_VMA_FLAGS;
+
+	for (bit = 0; bit < BITS_PER_LONG; bit++) {
+		vma_flags_t mask = mk_vma_flags(bit);
+
+		legacy_flags |= (1UL << bit);
+
+		/* Individual flags. */
+		vma_flags_set(&flags, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
+
+		/* Via mask. */
+		vma_flags_set_mask(&flags, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
+
+		/* Same for VMA. */
+		vma_set_flags(&vma, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
+		vma_set_flags_mask(&vma, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
+
+		/* Same for VMA descriptor. */
+		vma_desc_set_flags(&desc, bit);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
+		vma_desc_set_flags_mask(&desc, mask);
+		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
+	}
+
+	return true;
+}
+
+static bool test_vma_flags_cleared(void)
+{
+	const vma_flags_t empty = EMPTY_VMA_FLAGS;
+	vma_flags_t flags;
+	int i;
+
+	/* Set all bits high. */
+	memset(&flags, 1, sizeof(flags));
+	/* Try to clear. */
+	vma_flags_clear_all(&flags);
+	/* Equal to EMPTY_VMA_FLAGS? */
+	ASSERT_EQ(memcmp(&empty, &flags, sizeof(flags)), 0);
+	/* Make sure every unsigned long entry in bitmap array zero. */
+	for (i = 0; i < sizeof(flags) / BITS_PER_LONG; i++) {
+		const unsigned long val = flags.__vma_flags[i];
+
+		ASSERT_EQ(val, 0);
+	}
+
+	return true;
+}
+
+/*
+ * Assert that VMA flag functions that operate at the system word level function
+ * correctly.
+ */
+static bool test_vma_flags_word(void)
+{
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
+	const vma_flags_t comparison =
+		mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, 64, 65);
+
+	/* Set some custom high flags. */
+	vma_flags_set(&flags, 64, 65);
+	/* Now overwrite the first word. */
+	vma_flags_overwrite_word(&flags, VM_READ | VM_WRITE);
+	/* Ensure they are equal. */
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Do the same with the _once() equivalent. */
+	vma_flags_overwrite_word_once(&flags, VM_READ | VM_WRITE);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Make sure we can set a word without disturbing other bits. */
+	vma_flags_set(&flags, VMA_WRITE_BIT);
+	vma_flags_set_word(&flags, VM_READ);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	flags = EMPTY_VMA_FLAGS;
+	vma_flags_set(&flags, 64, 65);
+
+	/* Make sure we can clear a word without disturbing other bits. */
+	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+	vma_flags_clear_word(&flags, VM_EXEC);
+	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
+
+	return true;
+}
+
+/* Ensure that vma_flags_test() and friends works correctly. */
+static bool test_vma_flags_test(void)
+{
+	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					       VMA_EXEC_BIT, 64, 65);
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+	vma.flags = flags;
+	desc.vma_flags = flags;
+
+#define do_test(...)						\
+	ASSERT_TRUE(vma_flags_test(flags, __VA_ARGS__));	\
+	ASSERT_TRUE(vma_desc_test_flags(&desc, __VA_ARGS__))
+
+#define do_test_all_true(...)					\
+	ASSERT_TRUE(vma_flags_test_all(flags, __VA_ARGS__));	\
+	ASSERT_TRUE(vma_test_all_flags(&vma, __VA_ARGS__))
+
+#define do_test_all_false(...)					\
+	ASSERT_FALSE(vma_flags_test_all(flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_test_all_flags(&vma, __VA_ARGS__))
+
+	/*
+	 * Testing for some flags that are present, some that are not - should
+	 * pass. ANY flags matching should work.
+	 */
+	do_test(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
+	/* However, the ...test_all() variant should NOT pass. */
+	do_test_all_false(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
+	/* But should pass for flags present. */
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
+	/* Also subsets... */
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test_all_true(VMA_READ_BIT);
+	/*
+	 * Check _mask variant. We don't need to test extensively as macro
+	 * helper is the equivalent.
+	 */
+	ASSERT_TRUE(vma_flags_test_mask(flags, flags));
+	ASSERT_TRUE(vma_flags_test_all_mask(flags, flags));
+
+	/* Single bits. */
+	do_test(VMA_READ_BIT);
+	do_test(VMA_WRITE_BIT);
+	do_test(VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test(64);
+	do_test(65);
+#endif
+
+	/* Two bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test(VMA_READ_BIT, VMA_EXEC_BIT);
+	do_test(VMA_WRITE_BIT, VMA_EXEC_BIT);
+	/* Ordering shouldn't matter. */
+	do_test(VMA_WRITE_BIT, VMA_READ_BIT);
+	do_test(VMA_EXEC_BIT, VMA_READ_BIT);
+	do_test(VMA_EXEC_BIT, VMA_WRITE_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test(VMA_READ_BIT, 64);
+	do_test(VMA_WRITE_BIT, 64);
+	do_test(64, VMA_READ_BIT);
+	do_test(64, VMA_WRITE_BIT);
+	do_test(VMA_READ_BIT, 65);
+	do_test(VMA_WRITE_BIT, 65);
+	do_test(65, VMA_READ_BIT);
+	do_test(65, VMA_WRITE_BIT);
+#endif
+	/* Three bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	/* No need to consider every single permutation. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 64);
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 65);
+
+	/* Four bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 65);
+
+	/* Five bits. */
+	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
+#endif
+
+#undef do_test
+#undef do_test_all_true
+#undef do_test_all_false
+
+	return true;
+}
+
+/* Ensure that vma_flags_clear() and friends works correctly. */
+static bool test_vma_flags_clear(void)
+{
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					 VMA_EXEC_BIT, 64, 65);
+	vma_flags_t mask = mk_vma_flags(VMA_EXEC_BIT, 64);
+	struct vm_area_struct vma;
+	struct vm_area_desc desc;
+
+	vma.flags = flags;
+	desc.vma_flags = flags;
+
+	/* Cursory check of _mask() variant, as the helper macros imply. */
+	vma_flags_clear_mask(&flags, mask);
+	vma_flags_clear_mask(&vma.flags, mask);
+	vma_desc_clear_flags_mask(&desc, mask);
+	ASSERT_FALSE(vma_flags_test(flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_flags_test(vma.flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_desc_test_flags(&desc, VMA_EXEC_BIT, 64));
+	/* Reset. */
+	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
+	vma_set_flags(&vma, VMA_EXEC_BIT, 64);
+	vma_desc_set_flags(&desc, VMA_EXEC_BIT, 64);
+
+	/*
+	 * Clear the flags and assert clear worked, then reset flags back to
+	 * include specified flags.
+	 */
+#define do_test_and_reset(...)					\
+	vma_flags_clear(&flags, __VA_ARGS__);			\
+	vma_flags_clear(&vma.flags, __VA_ARGS__);		\
+	vma_desc_clear_flags(&desc, __VA_ARGS__);		\
+	ASSERT_FALSE(vma_flags_test(flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_flags_test(vma.flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_desc_test_flags(&desc, __VA_ARGS__));	\
+	vma_flags_set(&flags, __VA_ARGS__);			\
+	vma_set_flags(&vma, __VA_ARGS__);			\
+	vma_desc_set_flags(&desc, __VA_ARGS__)
+
+	/* Single flags. */
+	do_test_and_reset(VMA_READ_BIT);
+	do_test_and_reset(VMA_WRITE_BIT);
+	do_test_and_reset(VMA_EXEC_BIT);
+	do_test_and_reset(64);
+	do_test_and_reset(65);
+
+	/* Two flags, in different orders. */
+	do_test_and_reset(VMA_READ_BIT, VMA_WRITE_BIT);
+	do_test_and_reset(VMA_READ_BIT, VMA_EXEC_BIT);
+	do_test_and_reset(VMA_READ_BIT, 64);
+	do_test_and_reset(VMA_READ_BIT, 65);
+	do_test_and_reset(VMA_WRITE_BIT, VMA_READ_BIT);
+	do_test_and_reset(VMA_WRITE_BIT, VMA_EXEC_BIT);
+	do_test_and_reset(VMA_WRITE_BIT, 64);
+	do_test_and_reset(VMA_WRITE_BIT, 65);
+	do_test_and_reset(VMA_EXEC_BIT, VMA_READ_BIT);
+	do_test_and_reset(VMA_EXEC_BIT, VMA_WRITE_BIT);
+	do_test_and_reset(VMA_EXEC_BIT, 64);
+	do_test_and_reset(VMA_EXEC_BIT, 65);
+	do_test_and_reset(64, VMA_READ_BIT);
+	do_test_and_reset(64, VMA_WRITE_BIT);
+	do_test_and_reset(64, VMA_EXEC_BIT);
+	do_test_and_reset(64, 65);
+	do_test_and_reset(65, VMA_READ_BIT);
+	do_test_and_reset(65, VMA_WRITE_BIT);
+	do_test_and_reset(65, VMA_EXEC_BIT);
+	do_test_and_reset(65, 64);
+
+	/* Three flags. */
+
+#undef do_test_some_missing
+#undef do_test_and_reset
+
+	return true;
+}
+
 static void run_vma_tests(int *num_tests, int *num_fail)
 {
 	TEST(copy_vma);
+	TEST(vma_flags_unchanged);
+	TEST(vma_flags_cleared);
+	TEST(vma_flags_word);
+	TEST(vma_flags_test);
+	TEST(vma_flags_clear);
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index e3ed05b57819..0e1121e2ef23 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -36,11 +36,11 @@
  * ahead of all other headers.
  */
 #define __private
-#define NUM_MM_FLAG_BITS (64)
+/* NUM_MM_FLAG_BITS defined by test code. */
 typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
-#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+/* NUM_VMA_FLAG_BITS defined by test code. */
 typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
--
2.52.0

