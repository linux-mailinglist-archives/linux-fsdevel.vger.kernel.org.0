Return-Path: <linux-fsdevel+bounces-74451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFED3AD43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEE3D301331C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0300387372;
	Mon, 19 Jan 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvDGq65H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="szfDMNcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB537A491;
	Mon, 19 Jan 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834396; cv=fail; b=R7daBtqktz/czRPf+Hts6zswpjKkOXsamfybVEiwuikJCwMapXzk53s9faP2DIdFUR+M1s1lgMh96lJLfIHaTAjbBrBbb9HAaM9/531acn3lFlUFejGu7v2LZvxjlEK+WRf7x9EeJoKpB9FtDnyUvz7Os05yRhjw0OKdosOf18k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834396; c=relaxed/simple;
	bh=gA1RBonfLxAYCI7pDKwRTbCLJa10uPaq/R6yM5+M5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwtlIkIJz3mHFwa037U0ilKJUgqReFkNJzxdwn/0l68XJdsqUaFU7n+f/AiIFdKk6GV1qfKcmKUIDSxGo1KZ08RQP9BQxbBlUMgmjCRSo7tMjU2exrJ7mUK7ZZuNbH+JDchBN98yULpsspv5R6XDeUvWeG7eppiHqbfuilo9Y88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvDGq65H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=szfDMNcP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDRPR1269413;
	Mon, 19 Jan 2026 14:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t1i9sLRETIT7a1SwHx7sQ7ZWjeDZ2/X/fSP4uH7iUsE=; b=
	CvDGq65HXb/4we+P0W+JjS7VMQsalTh+3npl/Fo0DIJVfqw6ocrHNsQ0mSWt+6Yv
	IG6/QpA+QbjLU+u63BFa1ZdMg+kpHjqRCihb0dOMcbWxscHC4hm+Dt2wy5eBkRFb
	oqZLA6Hnm0No9VAdSdRtbq/DewkyhAXti1g2YH2YL26eAlQTmr23IGnc1xvPME8P
	ceXVMovSGfj81FW2PH32yQg2H6JGH7ExbwdH2b1pUw76d2K+hZgyfmz8tlHp76eu
	SSRtz41eC6zDjH2rb08HTSk52/Nw8HLY1z80e/k7j1779y/Isqfx9u6/UorcHGtN
	5jtPQudDC5cm76RX6DopmQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8ad3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:52:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDx6SV037634;
	Mon, 19 Jan 2026 14:52:07 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8f76v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6ABsLBEbreMrsemYW3TE+Ir0FqLjA2nkJaMQRA1DYSgYgaMRp7N1uuybjLv+RDbB+pDpvEBp60XtxxjnZvXe2Jo25V5Ln6EJT2/G3OR1DhtlulUCgamJWd9XPNJodtShxpZhISiWHe5SsKuRgqAYSoTdYIH9V50i5Cn+MD3KV8656qMCAISyspbHT/5jF+hmXwiZOz7gWMdjlE7TPUDSO2X1chSvYHZy2UDTJQN4FufEgFblvud4yalaYmPEIvyPJy6A50NTSZaAlIbRHTa6HVZXINah2TD0gkcnePKftz3N+hFyotT3dE9WGGP8oo8vpzxQ4n1Lr8pZctC9sovPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1i9sLRETIT7a1SwHx7sQ7ZWjeDZ2/X/fSP4uH7iUsE=;
 b=Op+yrxTUkOTP+jq43PXio4+/7UkAXcSi9Jl7tdnIE5lNLElqRh4mpERcOepRuIp65v+63WNTp1C7scmCRT+dkYFoj8C1IDH8BvLsayt8H54VrpKIN1YIMqZqj3YQ3T7PTW3RJXCnAtjFrXG5K4cQYG4zPv1WvDU6wkyAASH0OumAAxuItKB5zCe8kmwsAWw+hB2V1SDePGhFOvLPccbsGNA/vMu2idQLuUlv8Epiwg5pmLXPOCw59ulFasbqsfP5vcWeeI+IUqaz2YuyrgpvdusuibsMVAtjT5P0m8LrMnDOrqa2u+JIamew2mLoU+/13Qv1Tmjmzytj3mYa5DrZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1i9sLRETIT7a1SwHx7sQ7ZWjeDZ2/X/fSP4uH7iUsE=;
 b=szfDMNcPvxry78LAr8+TpXMbHY4ZkKFDbXJcaDp9GCGaJ/WUuNlk/lwJ+5lQuA5enL9NvaIVdtaBUq5g/8RKDswbVppGgjkF1H1Edz854lxdpgA5c1PGJcJ/ZZMTvw9VuLCYqHGZI3j5FYNzgHsbHs/kDiypzf5lgvX3omehsr8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB4767.namprd10.prod.outlook.com (2603:10b6:a03:2d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 14:52:02 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:52:02 +0000
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
Subject: [PATCH 12/12] tools/testing/vma: add VMA userland tests for VMA flag functions
Date: Mon, 19 Jan 2026 14:49:03 +0000
Message-ID: <2fbe7a18f517d7d8de9157f7f5b7bfc461cb7758.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0433.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0148b8-0feb-426b-41f5-08de576a4de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rZTvy5pvFIH3iXfS3O7ucuNSrAxqKb7Iusr5k8rDn0YFpOc4CnBaPYscWlw+?=
 =?us-ascii?Q?2VWfPQWWzk8Etw/8t0/lI73SjBHozSnz20jnjIPVhF4REaB8ZYV7J+GQorWO?=
 =?us-ascii?Q?ZbouijsqqFnbdFku//I8NjnvvhZGU33qe+OdKBMy30FJmUc01LwLYEtvz12H?=
 =?us-ascii?Q?83mwMWAsSwFmSGTwZHHqkKdPh8S7GfZqTis7/bGOy3gj4kFxuMyfZ/DcRuHW?=
 =?us-ascii?Q?apzNXO/rpfu7BRAEPy0/EERxAL/H/Eynpt4zt9ULsTRXxGh83QeuEaS0blq3?=
 =?us-ascii?Q?daYsrlhMWRthAcUk77YjNUtDpRiRYmUHQlV/QlzIkL8Q3ehIkXK91Xs+Pzyc?=
 =?us-ascii?Q?+8elpOWiM0XjP6ywXlG4XFovUQD5odc6ztgHv2CZw2mFqdU8LdzOJvzvSVUa?=
 =?us-ascii?Q?zqB6BXoacdyh5MJFjpYgfPecOloPBf2P8yH243pchxlC3puDQVUnjvjeZikn?=
 =?us-ascii?Q?yslkTHkJglIOA/1V7dVOxeePRvCRC04Snnq3JeMbu5NmbZ7d+ts5c5UfK4za?=
 =?us-ascii?Q?lcFEo20X1Uhgi80NC7dpfZnbCFt3c7BHRxaOlzVJwE3RwaWXaz1Zl+2QClxC?=
 =?us-ascii?Q?jg50hn760tPiNIhBV/3rOoupRRfAH5ihuYkB7W6n8fZRwT5AxgiPqZws7xbp?=
 =?us-ascii?Q?GqkdcoN+/BBbwi+civNsowgFLK2I1NYNsP5+2v0OvExpL7pa1pCGxUAWwtbL?=
 =?us-ascii?Q?4UYJIx5b8hD0ftypV1SgpqTU3l96GY/KRVM0KS31CyctKjiwebk5H3ATI2/d?=
 =?us-ascii?Q?5jsEEV2jEfz27191mbvXLS9je97LwJgNqwS7EpI72oKdcPH5aN0o1GZyIjvx?=
 =?us-ascii?Q?drJH+4rhWwu0aYwahlF0QW0dyhF1s08i44dAd6WRphlbrxAbfDX8WPhMzdnX?=
 =?us-ascii?Q?vyqsOFxdPnhP618xD5rb8BM9eMurqUXgx+c20BHWQ6bQLHEN4knSkYAxSmrD?=
 =?us-ascii?Q?WWvJjpldUup8Z3uPcUYbrW+LdxGtL7vOLTmD1VTypAKtCBtl8Dn5t/b4Yf5D?=
 =?us-ascii?Q?kWkZedQdAahpKQtxK1e8pysIm8RiHu4I9xmOUUKWjujV6ZBRZUW0MsLdV2yx?=
 =?us-ascii?Q?K0cUmH9FedhTxtrLkdtRjKz0RAPyDka9o/eoX+UHoz19Fv6atxQkgfygmo0S?=
 =?us-ascii?Q?SJDfpWC/YRDZdug/HXB9Iq/mWBEHhb25tX3+t3h2o8ywG9brgyqUdALa53KX?=
 =?us-ascii?Q?5T935VZUYyIn8+i1gLV5Pxv51wL4y0dmFQyyMOMQGQQ2oYw/FWXUs8jWhbRW?=
 =?us-ascii?Q?dklEwiU5c4aKR3fiJn6NqnPBNdY7/ogCYyqocD/Pbccc5QIlNMExSmLO18XT?=
 =?us-ascii?Q?mk8xbjfJuqeQX3TzGMoA3j6ZMZmc97MMd1tGAaA8a9s6T8vrhDOoRRwOvU0L?=
 =?us-ascii?Q?aOPgaGWjAlk1T2NnvpUStWzHfeyPJKtyWxFAioOqCUY/0RGkWlZei0sjwwwT?=
 =?us-ascii?Q?1iX5yJwpS8ZZGDf6rFRlmW4ZAJfvNfqI4H0ths5j8L9DSrM9w9/waB7blYHX?=
 =?us-ascii?Q?ct/HX2vMsP9VHmiHSzItnQRLi/SjZHhfLxQS7mfL5YtuTccLvnVarb/xSaX/?=
 =?us-ascii?Q?eBXt9SrP+celPoOQ8c8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwYbOAmatlThjJDDRxWpnfLOBhXbKjLMV0vF1+ncUnqScJ6oUKPbTOUnHf9K?=
 =?us-ascii?Q?0pIdseQts4pBPDWHMb+dm+135muzGOrBOsA6dGR4CTMCdJEs2uMk/SJXRzva?=
 =?us-ascii?Q?ojKKFTuHSulyJmzlc7h60KVjt/q2cuTNGhDvDZzBsluqrhDJQJkNbbwtxPlp?=
 =?us-ascii?Q?sM8fC7NfpV52N9mMW3sX/Xs81peLCDLTmfg4Hsh+bk49vz74iCs79pdyK+Pd?=
 =?us-ascii?Q?/98nH1wsZ5cKv/MRalkLb84Wedl+8NkzuX0qZAYxnyfquTj6j3a6OmXvE93g?=
 =?us-ascii?Q?svDw7amCwbqI4vqMrs23HOD9fxofIGLw4WiNMxQFPOzAgIagnXBG47aI89SD?=
 =?us-ascii?Q?t4VEbm/zAQgqClr4xd7ETDJAbU5DklyO11vjxWn2hcPzyN0X7kyx5DOCeX4N?=
 =?us-ascii?Q?sTmZx16BeVQMuFinGtMl/VJ9QUYoHdyrWjKu8oLrqOju01WlGzUCEa3TLfG8?=
 =?us-ascii?Q?coLks34rQ2pSqmBGsfVxQXEGUwVtUKaTcjOF0Hu/krhyP45ZUJuxgb6wXKzK?=
 =?us-ascii?Q?h8d7NtqDwbEp4GlrRTWVHRnnQ+0GeNnm81Q8eOpGCwTRIlN5eC+vLdRsKIE+?=
 =?us-ascii?Q?5QihAadZEqyxdRM+qsvVLu1/CS3cf4e1q0/WyTtclzhrywnI6MjTzZRgO28C?=
 =?us-ascii?Q?f2LEiaKkSki3oSfrzk8PiO6d7Wlp5PE/LCWJlyrFoybCi+WmRoIyG8QuO96A?=
 =?us-ascii?Q?1rh3bm+FTPL2Oag2G9g9SKh/MSg5Ht4IODPsnyk8tlxZ3agKVXszwpa4lyP/?=
 =?us-ascii?Q?jzwXciWFdZSAeSpV50v8yYODLWwjWKCRk7PO+M9LyqXkDRp4bx3wlJAzf6+D?=
 =?us-ascii?Q?EaCzqdVcg+Z3/h5fEGZdyRU1+QzR5EvtkJ6y1o6aq1F0tQJuP+OtV9ZWv68M?=
 =?us-ascii?Q?GfJi4WN+xS7r1Xrj1XyC61+8DbVpnKER34wCS2nzlPDPdS5dOywzIR6Bs9le?=
 =?us-ascii?Q?ACnf3vy3q5wBZUcFS/LCfXHdF4UmkAx3UIgiXGx1EgFZcbYJpyYbfybPf0CE?=
 =?us-ascii?Q?Bn5M29jj5/oaKm3C+tD8VBoJHYFnd1N0IcfnuOaxXVu4BRIaDsZfQJmycDXD?=
 =?us-ascii?Q?HxndenU3SdMnB7c191InYKcuObh/faSahvaHF2NC3RaI4Wl1jyEENOx0CVUs?=
 =?us-ascii?Q?Nh0J0drKjMrsp2hei3d5TrI7AdXRvjL5x6H886mUlFhLd6FI5Ojk57vYL+/3?=
 =?us-ascii?Q?Nc1yocFnlervyyJRdUH6b8AUZ70v/R+DXaJfG+N2nKxLttem53qvtekqq0eW?=
 =?us-ascii?Q?4hajHzBT5JJrG1PHDxSe2emkbuKwsaDMFd5KSW8wTW9qR8khsbBqdgwxAKE8?=
 =?us-ascii?Q?XqbM/kJSW0MtzMd1R1m6wdbyTWd27wDHZyicefEEye3ia5lFzeVLyIa7V/Jr?=
 =?us-ascii?Q?kh3lvg9NLYFqRRMiLUhaXwOu79eW/TXwL6d7BHjRpIhdvaEM7dXt6A0xQ95C?=
 =?us-ascii?Q?4suHdENJaF6dqZ2ju8ToGkgec72c24BlAD6S6YU2BjPLrtn0Vg5WcF8X/nk7?=
 =?us-ascii?Q?4AKO3+YMkT6RS7DyaWw9fCl4osn+x/gDzh5GRcxTufPkIGl+oK2SeI5/TSoY?=
 =?us-ascii?Q?C9PYtaOqxl03XAOxwn02ZmE0zzI0abvrVfaRQOQ7gLWTWfPLAOWUhtklXf+2?=
 =?us-ascii?Q?Fr/Jew7xNtrl4YmD4rmxwyaaDnwVzhk6iwceopbRA7kkcljIfSnl34FHXCAd?=
 =?us-ascii?Q?INPagifXWbBlbwCnjAK85RWSf7Sg06sGURGBt+lqDfdxq+0+Muaceml3uoxu?=
 =?us-ascii?Q?rgKeMvhBAIXBCar57vcADMMOWZNtMuk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rL53AShvL2vML34AK/WmUo8ldHARQ637jUZygePnbCxrBpx47ZHoi+wq1PQ/V8zcde0K3vwz78YkzrWoe8Jii4t1+Q+vINr14Uo5pxDs/gj44r3yolhMlgKAhHlU2Y1F2hfBPqbsxB9RYY2Oe6Xe8NSrzIEmxcHyjaDwEPATRCdpJTfiH3DN2KspwX/HeUY8wDmx54AI6m4V0T0jUD7DvkaJyE51o20i8y+kfdA34MgMNpKqXmk9UPCEO+g2PkncvIN36at0hvx8+vnomJIf1D7qk7rb9SctVU9uKdnWZ850YTucXC6tb7MG1/QLyd+02wTn3SOKXNJcRbNNfke1OItwIF39tyxUQvXfiSXctmmxW/x4yqCu8JG0YIb94yGs1SJcxGWlbgUBN6SYQ9I6GGdp2VRleci+be9dF910v4L5F9CyC4CfFjkgq3JF/5LBuzZbAYki6erorsrEirew8pti225/qxyaokZ+FYtx7y218L0XDTwe+CTZwBhlFL6hGkecQZIaabsT1ehLzBc7w1a4XV2/rgwTt6cvy9A7bUOd1uYvQ9dof+/VzGiP40TNXlCjfUcGEVipYg6heY7nTt8LS4fJlkIwLZ47sJq+kFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0148b8-0feb-426b-41f5-08de576a4de4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:52:02.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IPVXLRP7YmBW9PvemcPHBBIPqwmpKCfzvgrjnmmhxEn3q6e1Yq5tBWlnslK2R6Qs1w9qMf38Wol+zsGhp9ggTiGOIAf7PkpJbBitHqaDpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e4518 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wdtOZTiSbmFhyPzmQ0gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX5I0xdZYwEz8o
 LJIGZUF91BpdfAoq7O1/R8M9Jb6URvD1olq0MZlpMyruK1jIvk3vBAVTeW3+lc9hZKXHParWn84
 5LX2wubAuYMjo9VVGZ8V9Y5G6SC2OazAT5/U7/mJ/9kfNvwd59V9dx9PVy0e+HI5Q27rNqEs1Vf
 E5qxvevD9pncqtShycV5ySi7pwSRiEshxqCCQyNf/XnesmJ/nyHrAghiLs0Tpz32W/lWX3mRXJs
 66bcDojznwz6E8ks4L/GC/v30DWUWwvkwNB2fplowxtKf04KfDXagUs1qEFA5311JaukQnhSrK8
 sCKYip+jNKsW/BwYJdHBPee82SMht6KYZ2fWvAgk8qK2MRYLi9hQVfrG/VE7kFvHRZ95S0if1s3
 GDuFvbKWyDR0AabEFPtL/mwA5HUJEJggJOX8orfsHTBksLL01YDa1Skg5u7hWYxvuR3qQmvjU+Y
 ZUMABpgMAqmkFf0Zk2w==
X-Proofpoint-ORIG-GUID: Kx8BteBi7exn2E0ZLc4mA1XshhYpOIrz
X-Proofpoint-GUID: Kx8BteBi7exn2E0ZLc4mA1XshhYpOIrz

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
index 3f4a9dc63fa6..21b4509e2a8b 100644
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


