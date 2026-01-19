Return-Path: <linux-fsdevel+bounces-74551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2085D3B9B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979E43041037
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A330CD80;
	Mon, 19 Jan 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqD3wcXQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dnx4CJ6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB772FD696;
	Mon, 19 Jan 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857680; cv=fail; b=X6OQ9lZX9mSbpmAmAIWE/vayGS8Hzx8x6ri5ZQaqzCm1ftqhjjhSf0IOpZ1P4p3bjWOnL01LV6gaAsuaXqvpT+tx8T6+K5tYVsH3GZdyh8JNr/9Ka5RXPbECaOSRlB8vhz8cH6665bYxGjgG3a2BQTsH6DQi3XLNBTuMtI9nFWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857680; c=relaxed/simple;
	bh=tB1Ef5y2r0DEHl5o3Y4auaquokODLFi1bwRBbCjxzJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNh89RJsdCt2ZnCVSq8JTUUz0/QOtH/GsfVA3ep8c53F7OcYizruRK17dpJft9F7O+qF4gUpuhD1jnma8P/TldTWMrqG+6Dws1gnGeNzK7JjnvD3njDeJlJ3c3Oxnq6vHz03RAL7oW2R0AL2PWHEYckPxgzm/TQ4y00e9X1X0cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqD3wcXQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dnx4CJ6d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDh6t1342126;
	Mon, 19 Jan 2026 21:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=99dIOlHajSDAhPONkcgDQ9pxJfTUahLkH1Pb0NxZKFg=; b=
	UqD3wcXQP0Zq1OeVJvEGbZtrKtNbPFGWM0FKPzV9pqUHxjrY5Xf3cvPNnxXa4zxP
	0W4ouOOr84riCHlsDHOy3uzUeKEupjNc7ijMlg9Wt72bV+2F2J4ECDfcFcYbn6hm
	nOSxYdlkq6PrPCV7gnfu5kkamHQDaqemcRZiV4mJdRycDUgE3iGe73jq5IRmLjNu
	mhrIeZt0tsxV+SUacSy41edbsf6NFKUtemv+cIqLuxXrQx6xvccC+RivGknCMTtc
	txf0nkNz14GNMLC1dbJ6BMTDSv4MFkGEjNafUKWPYnOmrb1GTS6r7LLTGW2Ec/SC
	eJXTZIzTDlE4EgJJMH/zkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br170atgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIwScw037783;
	Mon, 19 Jan 2026 21:19:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8s2xs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu9jSEsfbmUy3S4yVMI5VpccJf5vaY7bqbW+nSSlZZPxhFIfIGU9oHRLUWg7S2LEi9opToZxdjg8fJ32LsrGPcJZ71xcYP7MsDCwXvoK3w6TBh36f/fsri0yCVNi60kJf+mr48uxf9/59+hiiI3zdtnVNErkktmMRlDI9teSpBkd6TvoQO1F0EmnjKCNnqJV+nt8Mh9aS+/rAJj1as1sHrKHzaeZjswf/ga6yoNvEVV4LcpjeuzTE9JFUUbBjW1ckpGnfhS4LEeHGey/mp0BySEduVWQA8gyC3zNgHVZE4rKPrRI+D8rJFtaFyNFx8DUpNOBT2lUalthNzKAxYyw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99dIOlHajSDAhPONkcgDQ9pxJfTUahLkH1Pb0NxZKFg=;
 b=nfzfIDL19KrTqg/W6G+OtfYrprTkPONY/u1GhpxEZdggg016+KofBKarQM4G+yZzJA6vIomC9dvIOhzbYyYUBPz+aveK9aOIfhyksvSJfnIzPmOboEZWQew9W0VqPQGRUEwsHoNY7xKLraIzOvTq0wdNANTsjebbH35l6drsJ+W4Bx4RcdkJ+X2pshFM8PT2j4vCIe1E+2bQBq7Bs3dSAiYQ60S6IrG3ueLMBrDxID4OdTfriiKT78zjl4vxMqqGVpVEptPtQF6fPnsOfaCvkQgPby0t888r2K71YBDaNF6q4oFOQiMfToi/hO6x+RoPJLI0HZ69ZXiTCrqLmKfG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99dIOlHajSDAhPONkcgDQ9pxJfTUahLkH1Pb0NxZKFg=;
 b=Dnx4CJ6dzPUMj1pamu/+ZlnkT3s45KefV6AEUMDkOmlx5b2cz+e3/mNsylkNsfE/LaJkUJ1Ta1sXVpZnxWVhUl8IEcLk0HbPYqsk9oPQdcxBnBWrdwcQ7C5ZxQ9+PMXf4lPZueKEGS5XlmbLLhbsVukHkByQK9zv09Lx8EkDSOk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:18 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:18 +0000
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
Subject: [PATCH RESEND 01/12] mm: rename vma_flag_test/set_atomic() to vma_test/set_atomic_flag()
Date: Mon, 19 Jan 2026 21:19:03 +0000
Message-ID: <b2bbdacddf1945a18b425b151b7f3f6c07b51223.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b8dc42-8476-441f-f95d-08de57a067c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOXJU1a7yrcgcaBkuv01K5IjYN5e4lSNj3Zd53Qoya5eiZei1joIVOKsZhav?=
 =?us-ascii?Q?l7GLp50tcSrV/hy7gAY7EHT5W0E5aiJjlCyQNn0SZvHx4SBWwMQTEl9FuHRD?=
 =?us-ascii?Q?vD1lYfL/Lzo+6Wao05MkKX0qRf4eW4QEaPodqkcXK4tGA9FiHZ/1PVfrqcEW?=
 =?us-ascii?Q?RMXpqCangoSb8jqmWw76e8UR6OjNYTn3O1QlaCToYD1a4NExM0bQo4F03XAU?=
 =?us-ascii?Q?0Gh+SxrXKMdBcnNbU5jZdZlnOm6+b2InbB8D8ueNWT/1U8CyN3hrOEZabkMW?=
 =?us-ascii?Q?3tg93AOUogBIA65Hn6BH+6HJPLFoTs47a8ryWiKJ9KpOIwiw9hRjJLoghdky?=
 =?us-ascii?Q?puwBtWPSRRgdzxfGX3KK7ZfnhtPnoVnXPgKmbyme2q+pbvd3bZ2u6llbLeAi?=
 =?us-ascii?Q?v7i7Nor0bkTsS4ndAbi7RUbwM7E+B573Ypafrsdngto029QtW3KbSLXH2cCq?=
 =?us-ascii?Q?eyGnHp0PWcx3BruqiLT2ajyrTqimWAeytYf1c/eMj5L/mHFDZNJZoaSam8+S?=
 =?us-ascii?Q?YBKVQTMa/JGJbhz6K3x3H7E+dRHADcQKfh2Gvj3qq9P4pfM8sBDxTuTivtgC?=
 =?us-ascii?Q?JaIAfQ7D/5E/JaNcHTxcxklfL21bU++CZLdu1NV6VbCQpodz4r/co5/4HOlN?=
 =?us-ascii?Q?q0B12rcEwHFa4Xhijy5DUdnaHzcp6ogUIHEk9OJMfTl+dOVACzj6SUxURdqp?=
 =?us-ascii?Q?wOPibhN0TEeFr8DWAEY+pe0KKvOhdFJ0Pn+dj3HFZdDNv3ZtYa+vrY1WsuGz?=
 =?us-ascii?Q?e8nYKCHKMZ/1rpT/WuX8vBqO5hksAQw8UBcOH+gwOLU8MJxta2kRiGzssTcq?=
 =?us-ascii?Q?uNwp0MvSEOpcBPTpx5ekZtG/vU4TqEkllG9uTO6AGDy3x0stbxlvR1HXnIKw?=
 =?us-ascii?Q?uGymqR3FQREKYigb+62sfS6pm7W8JwlnlVQe2TleF01Rsl9ndtqSTQLLwcod?=
 =?us-ascii?Q?ffV7uY1m4B5OvNsWVEh0KldxayDKScmS4igo9Qz8SjR0xt3Rbx+yNv8KifEt?=
 =?us-ascii?Q?KrduDtIjBwjOAOkFTRO0BRJyqY0m7DDhM+m7uNKKSFZ3ixoE/WCzPeNoJgZi?=
 =?us-ascii?Q?qgJ3jvtJSCFrp57oRcATwIhU/0zeMnG4In5eq7pTqQ/wegtjxBnhKgtDFJMw?=
 =?us-ascii?Q?X7Z3TApRfdHg0Rsp31QAT5QgKJj/tw/TW92m9v4Pmi4rmmsQZHksqD+4BPkI?=
 =?us-ascii?Q?3Ny7Kc+p2hszxZouVGNHLpHF2b4V4AFxNQdiRAg1heDizsJ9bgTZoOpLyGpK?=
 =?us-ascii?Q?AYDAaEVGDwbuXg1F/bmYfw6vWeID3SsEFsnAV8+XZ5++uN3k53Qx+sFir25W?=
 =?us-ascii?Q?9WnNCPqV+YtzDudGh6ebUPemtKbgYFqnJn4KYoQybVBJlNOvAa0vt1RS5IlS?=
 =?us-ascii?Q?WqY0cMbUls03vNw5YbIeq0iG/YaL+V8rrxTNoGYUNuJYju90ih7bPOvEG2LS?=
 =?us-ascii?Q?J/oVhzFJJOoiM42oMsoe/qLxGZ2EPuyHtqEuo+OpxgO/QHHNQ0fIOyX4Pjiw?=
 =?us-ascii?Q?Y8I/5HGI2/R4R1OptH5v3e30Vu2ccjAmloqn+WWu6+kHpx57JF/3/dGlOc0q?=
 =?us-ascii?Q?r1vTR7sukP+qlZTF1Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeboiTYBFh1pqimla1rCGTZRge5d2EpV9NCqu3+Q6rEYPxXpoDqHZTNiN0p0?=
 =?us-ascii?Q?0x6tcWeiBrsMiqqxsOIHlXL3S+guuETGtJr5czLnsSfSil3uO/oYKBVmq1Mc?=
 =?us-ascii?Q?abXotPc0IufaZP+exwbsKD9EuobXi9T4kptFbf8QnnSzJazNbH6iQy5N42MN?=
 =?us-ascii?Q?hgG7GxubSH9kCzOHFT21PseHNxjno9THx/OmpnMyMN8hANyYmWNDeFkZBcWa?=
 =?us-ascii?Q?fdvsetIgNIBEDz3ZC7hihihjQa96tQev7Ac7LyT5V2DEVnaSmv+C936VQ+pI?=
 =?us-ascii?Q?NB8bYuTKSNKV5890IDvcHzMUV8xh7S22l+h2q4GoDDl7wxoW3q0Dr//X037g?=
 =?us-ascii?Q?P6fy5gS5N/aiGl3/P04R5z+18KT920UQEbzEJME+BLZKirpAciuqKiVJCyaf?=
 =?us-ascii?Q?DBJ36qj4xgW0u+LWRb0JoBY9FdOAPv4eyl5au9K90e/oVEc06s03HW+ERiUQ?=
 =?us-ascii?Q?VA4ZiJVB8DsElRTsRZCkABODWJBV52eEJ7gJFfaKhHtjjpX+/Cm208tXBscV?=
 =?us-ascii?Q?rThU18wnX8M8/SBaAbxIUp5t8PkbzZ2GCcH8PpaTUhtUnuDXqZgXoEm6Zl8r?=
 =?us-ascii?Q?YmTVOuuJ4LZHADOI94uNLeVjSdCHsTluRkUq4269i+JWlPQBzvKcfhLb7QVr?=
 =?us-ascii?Q?YdNw0yet2cVD2gdvOv3rCBKSKbf997CE6EWEaAl8nItJjHzYbcD24MgF/k8V?=
 =?us-ascii?Q?kF1spBPaAJrbpivCCt1VRk/UCtnK3VAKVecBlc8Zxv06G9C1xNym8KUKPsn7?=
 =?us-ascii?Q?D0+8F5W5OhG0lCBS4cF4B/4vgUL8UgBxFWa1nurEefZmy3ykpLr7lTJ7NaA5?=
 =?us-ascii?Q?gDI9NNOblWkQSFYoDojq4yVEDBrrn2fGIZUB0IJ5f0J4pbC+dj3ji143LwuC?=
 =?us-ascii?Q?/DfEA9pwLyIC2gYfiT2BVnwyKVO8YOshpbF9+UfkZZ/4PAbO5+cjSffb4iIv?=
 =?us-ascii?Q?DF5m4s0MIvYKywhWmEpj2MwpeaCRuUxlmKwq4vWSmTHW1nmWPdP4sQ5P8aBL?=
 =?us-ascii?Q?QjyrEA3quw0MF73nYhCzxaWX2JLoga8srxxlCdp5PtK/22NSSE5etNlaUiqQ?=
 =?us-ascii?Q?pzG3Ep6N6GU2DGcRGPmuVWzyviatuJSEjoUmh6wG5vbzR2h3H4sPGm95cJ4N?=
 =?us-ascii?Q?9YwaUmDLKMxPQElITC9Slywnd6XwCkljlX6iZ7/M18jlVqWqdiGQVLdg7bWQ?=
 =?us-ascii?Q?LvcW8XSsgZJHlzenYmNCfguTOfrrvymhvQvajY4VNA5jQSsPhgJzm45cCj8l?=
 =?us-ascii?Q?a177DE2EDh5Bf/G5k52hhQHVDhaXWsoV2/hwAG1C26uYmRZz97Yy8L/rvqLz?=
 =?us-ascii?Q?PZdB44xZy990VsJNJLB88QIFsAHLbRw8fiehZKyKk1yffjYcw+sml4vyKgDq?=
 =?us-ascii?Q?keKgALFUo9dXenutbz545yIKKVBFq2aoYyFz/kc2UmPwny+hY0IpEZRiydZG?=
 =?us-ascii?Q?azotEFho48f/F/ji46cJDbV5JfZVBsUeIfg5OfT7jH+E0L4HrM6KPJJZOXpZ?=
 =?us-ascii?Q?vl25Prc6pse4EQdGq1l36xBo6JLpq61hEvKAYaDBaFPjo3nTV8T6EEnUOy6D?=
 =?us-ascii?Q?EZ1qNl/lKngd58ZxfrKitsiKqljtnBPEcOa4Rm2cL+GHjhhkE8UhteGLaKJz?=
 =?us-ascii?Q?/eGg5aiUHDMRv5zuPIDrsYg2tPDTNDbxa4NYaqbsIoPJ22lBWODRnQ/vPAK0?=
 =?us-ascii?Q?1l1MTZiYsTnM5LmP40wWACGAct2lSEVAcaaxS16WyweeYcwD8Nb4t6eXgI0s?=
 =?us-ascii?Q?lLgZLwPMu0t04VkZb+WNnHZ9uHgWbfs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5JzLALuGJ6Sg6EoZC5DTAZ5PcfrC5XJ3AXLHhiN6UkjO+wufzJaFCkrehXLQk/fev18Df98Y+7/S3dYK3dS9TyL6vzt27Eu43/uegcYashaxHFEI0kJzt25Pgbgi5hCGCA50S5bTpnL2HcE/EUwHeRv2cR6066klD+NtfzE1BFbUjX04SPt4SJug90NCottPnzj6PaXdytqMOtJhooH6nLX/mXiHo9JhFAGzILt5HPZ1jQYmfNYAWz3nlvDL62SqUrnBwdCeArTDLXiiUmiQzdlw2bW3ax9IO5g43Zcf3b7SUKoIVndbBdmq1zc3PPgYkfKaGUuonmrjBCKBdagV2pNxu3KxsTGuqeeQ45u55g8mqgdg6tacwBJ2WHKE3MKIF8OAJ1Z8aNmdqWhnRrQNdgCzL4DX947z47Io4dB+gBoLDaW5V2Dj02q7uhufwAdguAlmeSg3ldrZihFLyhPzVi4QudFu8kg1h/t6Yoi70MykwCkH1HyClcDgJc5jD7VglxjFvRuOEvaCZGSQbZdcLdL+x7ZR8S0dJnBMXmfs8qT6OZU2J1EhNdSrUs6WYbUdKrOK3HjgrP8hI760Arh+5rOaDkwJLx6JB8nQ8lMabiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b8dc42-8476-441f-f95d-08de57a067c5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:18.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpWQ8APYII3XFdFP+0bJP0NXeZlDFfyqGTbZvJKM86sNeGF/enY6XN8g3d0mK7/jk3Tb9Yy8XdbS4C1DsSCkyEb5LkKuvf/ddSIx48qLv14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-ORIG-GUID: jKNHuamwdkNyzFasn5hP9x2ax-UDoznh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX9gp/FmvOaGuv
 tKePr7qzYVNBJXPVVQg4AYARM4CF4UrLlcgnneXTrojhq9bIP/EcFS99bps6v+Eq3t2bENNTAKP
 bA/AMUK/Xa4hgGrKEQXGE9ke/VFNXMOElPvE0ndmBDFClcO9ghQgl+hGOkZYSQf1oCgD/q0X99g
 R+NsEzZ30d+ii5DfNBmkQwffxk8ZxXRjcWwy4DDlJhe+vdQMo1H5asCBeY3UgaUzerR/aRo8fjH
 Ktb6NH8yzjv7oih9hKxyQBoQXYGMaoydz7COTocxGTwLmnuta4jGPJEuc6m4Ac0fHvxilrOoMtD
 WgSGtmshgoSEIRqBhY761CaSvNBKTajJYO/nHWAeVZVKB6mUt3ylpEQNMr0JGegOLHhgLY6Oy2+
 8bXDgYeu2D8h6tg3jSaPk0laAArXQMzaRON9Jn5etceYI8asGFm4zxg7QdxPiBuKTBnqtcdCULz
 TD8g20wf8vJkB+p7GKw==
X-Proofpoint-GUID: jKNHuamwdkNyzFasn5hP9x2ax-UDoznh
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696e9fdd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=79C6M4AKyJxmQlF-J2AA:9

In order to stay consistent between functions which manipulate a vm_flags_t
argument of the form of vma_flags_...() and those which manipulate a
VMA (in this case the flags field of a VMA), rename
vma_flag_[test/set]_atomic() to vma_[test/set]_atomic_flag().

This lays the groundwork for adding VMA flag manipulation functions in a
subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 13 +++++--------
 mm/khugepaged.c    |  2 +-
 mm/madvise.c       |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6029a71a6908..52bf141fc018 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -987,8 +987,7 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }

-static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
-					   vma_flag_t bit)
+static inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
 	const vm_flags_t mask = BIT((__force int)bit);

@@ -1003,8 +1002,7 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
  * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
  * valid flags are allowed to do this.
  */
-static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
-				       vma_flag_t bit)
+static inline void vma_set_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);

@@ -1012,7 +1010,7 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
 	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
 		vma_assert_locked(vma);

-	if (__vma_flag_atomic_valid(vma, bit))
+	if (__vma_atomic_valid_flag(vma, bit))
 		set_bit((__force int)bit, bitmap);
 }

@@ -1023,10 +1021,9 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
  * This is necessarily racey, so callers must ensure that serialisation is
  * achieved through some other means, or that races are permissible.
  */
-static inline bool vma_flag_test_atomic(struct vm_area_struct *vma,
-					vma_flag_t bit)
+static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
-	if (__vma_flag_atomic_valid(vma, bit))
+	if (__vma_atomic_valid_flag(vma, bit))
 		return test_bit((__force int)bit, &vma->vm_flags);

 	return false;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fba6aea5bea6..e76f42243534 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1741,7 +1741,7 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
 	 * obtained on guard region installation after the flag is set, so this
 	 * check being performed under this lock excludes races.
 	 */
-	if (vma_flag_test_atomic(vma, VMA_MAYBE_GUARD_BIT))
+	if (vma_test_atomic_flag(vma, VMA_MAYBE_GUARD_BIT))
 		return false;

 	return true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 4bf4c8c38fd3..98d0fddcc165 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1142,7 +1142,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 	 * acquire an mmap/VMA write lock to read it. All remaining readers may
 	 * or may not see the flag set, but we don't care.
 	 */
-	vma_flag_set_atomic(vma, VMA_MAYBE_GUARD_BIT);
+	vma_set_atomic_flag(vma, VMA_MAYBE_GUARD_BIT);

 	/*
 	 * If anonymous and we are establishing page tables the VMA ought to
--
2.52.0

