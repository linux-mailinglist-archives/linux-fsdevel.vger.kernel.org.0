Return-Path: <linux-fsdevel+bounces-75098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAIPC7pPcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:26:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79269E56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 913E030004FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26E3A3CA8;
	Thu, 22 Jan 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HkfN3qH6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZUPFkl6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DA377571;
	Thu, 22 Jan 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098124; cv=fail; b=ILzy22OgdEmJ+w93AtSPKVi0SJGEnTv/690HqGvNLv+PiywnZXb+hKsyAV8KcY4BMMP/hHEdUAjaZXiEDqCwvigxMw9TsaioZFHvJh+sr1bbSARC5tpsecKcxinsiVBi+C26KGcSGPRXnRxUefw6kgjAh57u7ZvjevnbGvFEfq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098124; c=relaxed/simple;
	bh=g9MMMK5x0wcJGbbCSzisoGNrT92lDIr+sYWjsAZj2wA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FMLGgO6QgR3wOWY0pBZDG9Lp6uK/hm2552FhvrqWSUWDdsgveF59Vbr7a6PVfhAiMnrZNF3IQZdytMR8FS+weRWFR2nktSwpigyw0I+2xLlaeuQXrpUirdNx2Gu/Pu23ybyvaQu+0Po2+30rbwqAiz8g8Mt57S65b8nGzxZTV8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HkfN3qH6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZUPFkl6O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgLub197752;
	Thu, 22 Jan 2026 16:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=/ThAKSict24AiaWS
	W7chCDF46B5UE/v/dAxOdUukA7s=; b=HkfN3qH6FOUGTeHR62ExzobY1DT0/Db/
	R6F/uMDC02PuVsO12anf0xz/JxFLMeXUvrbC7AiXUsFpwx1Z44Z5t6EzsAdhjUKF
	BOuAWfRY6jzdvFk1N/zuvomFAqxE7Q8NnQnMj0y6XJN80+Zk98hXoiofnR5sq8yb
	f6Ko7iB/jc/6jmrbfGaF6/dgZY66BJ1F+wITJtbDNEoh3WCN+w8W+oWDe7iL6Mpv
	SYn98Snb7gnIkX8f/Jii2idNRaRn3MGCq0rMuMlaKzPi0whfmW88J+GOx23W6ckS
	pk9GMq8JgeFdcLseHBcdgkJBcXOg2ZI+8OF3/JcYYsVsDMl5UQ9oPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypyvjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MF57eU039307;
	Thu, 22 Jan 2026 16:06:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd1568-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWDLenn2rB3bm56Eo5+wUilaeHhuxhlWTJRbLbjuAVb0za6+jpblLrhshbXx4CNJP3O2hghaNG63BQ4YA+RRiyZLfOC403a7e7BX5krPaC3iYi+7IUSi8gU5x1Ge0/J8gZXz9dK401tE0kRm8pKFPqhKyWh5u1gFhTFBkt72kMaFTAOW+XQlwwmY2U0sd8+EyuhEdOdU4Flpulc900SsGJBCHxRuVNyhCzIYdnlh7T0D22WtPihDNjzR66kwMpDNwt4x5ZuB2X7+6K4SiIE/HGaJ38Ng10p5HqoAfzL7Ge98nJocTCaAhxiLtELSE7OMZg5oEfxxiE683zAEFh5LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ThAKSict24AiaWSW7chCDF46B5UE/v/dAxOdUukA7s=;
 b=ZY24lYX0xB36oYBT23uCM+znXxtY1yF8c10nPEqGz3jOlqJjyiE0Zp8yd4HQoHCrKtHM7uEMt7Xzxj+sFzOhVwDRXgrtJyPiMbmLwpbrm5MqvwaRt3Rq8DfepGs4/RX9zoap1oInDZhAdGQyAILfhhc6zLQxjI80TVr+0gi6EPjJ4tHO6PjgIebRx6YzZrnwV313lPATNoD803juhWSryP4BXJtyRzVgyoUfpBDsVJeEqi7zKClnAjXH4Hi7qu1WrYGvGA5AKpWw3u01fvRX6i1zf5um38eiJOnrWRqJ0wGrDmbigxBLOmxHywC2d7uo/UXyQ0N/k4/pW1+TADlqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ThAKSict24AiaWSW7chCDF46B5UE/v/dAxOdUukA7s=;
 b=ZUPFkl6OMl52HL2xQqe+XIRknzPTjFusAYAPN4B6/FQ+2I7Zo9te5Zx1Kad2GlSEhDKTSx9o10IMhqjs9kq6aaMfs39brMC17j+e/UBexZMS9EH3JEAyvP0lsYEGQ9LWu8mvnKpqFAgnDnd0AqpqDkEuzO9Ba/UjL+MLe7jRwNc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:06:23 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:23 +0000
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
Subject: [PATCH v2 00/13] mm: add bitmap VMA flag helpers and convert all mmap_prepare to use them
Date: Thu, 22 Jan 2026 16:06:09 +0000
Message-ID: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: b196cea9-cf34-4f80-fb5f-08de59d03012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X8joE8i0EmToO7tZu3T251InQh9EquE5EmNTZ60ZgDf5KLh7YuFHsrma6+x?=
 =?us-ascii?Q?KkxpU+++vjGot6HpKu/26DGK5VYvfjXRtF+aQQFNSzuKDrs21IAeRFB/L5Su?=
 =?us-ascii?Q?0gtlizgAUdsJJwtzGNDiA9eD7XW+0Dr+kJZsct1LFkQqie19qSB7yA2wNEaF?=
 =?us-ascii?Q?IlO4gZ6hKgHg4SUqOy+8XJFddMe6mNrODtiuuDN71TYDL55RRdX6DavdPGhh?=
 =?us-ascii?Q?J0zTKoZVK6uPbTlCXeARfrmDYn0wXNb7/x8x1ppIO6BDfKRe8KkF5N4RtV8L?=
 =?us-ascii?Q?hNEuyI4BEdQ/T+oLTfA8cVThhImSIT4K3mQ56hylQYpEDNki5aaa9PRvzftd?=
 =?us-ascii?Q?FqDkG+AJNpe0hs16yYWx5Y7CsjDr62TKQ99mT6cEteZqnxumuFhszHuExge3?=
 =?us-ascii?Q?fatD240X89a7lBjc2dwZoVeOhRw1H29MCzY8Zq7UU4L6vGoQaPp8gLfZIRta?=
 =?us-ascii?Q?4B7e/B4YHQiKfL6BhbWWm5sok6JeXWy/nO8yPIDzSA529+xCUWt6cF8nOwoi?=
 =?us-ascii?Q?RHexVlfpzY4eXEcekWHt7jrn8Ii8QzlV5t+0pSPBUL32n/D2dVAi9jAUF3/A?=
 =?us-ascii?Q?a0fJFGLyADvxK+sKm8IhvjQbetfM5JpZFfz/o/7D7W1OFpi4dTUTEgRJuHFY?=
 =?us-ascii?Q?qThhG5i5qHunm6okbttn24vU14V7T2V4VMeTJIy3XOZk+30jtgbAnPQyeXxM?=
 =?us-ascii?Q?gZNPUpyTCCvFhRiY5BJH2ehpTcBhsl+3WC9l4kbPyKjcPWY8KWMKlIp/cuxd?=
 =?us-ascii?Q?6odTqAuEpzjczu1gWrN1TX5E+zIL2Is2aM0gfOxuVZEAq82YKXcE8EvctCWI?=
 =?us-ascii?Q?7ED0Ngea/3/ppS4yhEVMivg3/Hvae8pi/1TGqS5HoIRnBq3zJgaREjWT1h7X?=
 =?us-ascii?Q?peG/lH1xBvBNWoA+QMU6STqKkm4siSvGzdBoXtliD+5cJaVeiXHMYZ4k5eLV?=
 =?us-ascii?Q?cAhWJ4L+G00f3JgXvR0RCpvqw1Pujc2FTSlZjt2BxUS41mTdVJUqe2QXz1oF?=
 =?us-ascii?Q?EIN4eLMu/TlXIK14i6NFn55Yblh30hYrnjKkBdDx6ntxkfejiwXCqWLXjVc/?=
 =?us-ascii?Q?LYwenH4AU/Zzyi8+VJn/YCQ/btHyUmhHlpsfXr8UmGIehgrUpQjVyXv0c3L+?=
 =?us-ascii?Q?4ygOt/Stc+by6AZS9Bwb2CF5dpZobSutcskCo4HKVvJ38/ndkP+8wXzzob+s?=
 =?us-ascii?Q?IXevz2CAzvAgCgkWKcQjarw4naP7aCK0qR10u0ULxrmkHszhLiGBbxzGhpDR?=
 =?us-ascii?Q?NNkm56YUZITITu/R6aOSa7P8k1wgFdH1vezm1Brb6KIK+7ZMCX3mqg+bdhBD?=
 =?us-ascii?Q?IYyuKyKjmRqsBDqu3M7UwZ6Bc7VAPNiFJ2FAIbUq8pBjxqCzk1TnhUyTTtqQ?=
 =?us-ascii?Q?eFUSAOKflwKKSv9hLZWw4ysswbWogX2mKmQNA8edu5SpSuLcio55VL2b18UK?=
 =?us-ascii?Q?UsJgOGmI9LXAYlPK1D+XlLwHFUMoBn2DVG5r7O8VbVWG32+OMKHARJ7QQ5Ik?=
 =?us-ascii?Q?upKFemvYnDujMCYoIDQUk9dstrl2MY5Jf5DRNc0AB29FFQ9QoYokIWsV/FWb?=
 =?us-ascii?Q?xFLqfe1wTLUxtI+OePdT9gxFSWvsk9/3NpeGttO+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81Etw0+zP/7Y4h29v8xbC1W55rLTg3CT/IwRzwiiLF+OkhTLGWOxAcnY7LVF?=
 =?us-ascii?Q?4A+fKh0jsCZtVS+HV7NbJB0mWS82gYBD92sioHEqwsAL0RO/nGrGKD9uDuU6?=
 =?us-ascii?Q?FDPAcKme97juXOKS/HHrHaVgkLIThdnAFHGnQcglmsPohwnPaKco6x66Blj7?=
 =?us-ascii?Q?/j4cCtzs56xXVUTUksiRELFx7q71D4gIXVxmTvMJKzQKK3erw4CyPHpiPnvK?=
 =?us-ascii?Q?YsBM5foqRka4RRD+tWCqTtt8l3SZdA8Bi2oB8XaxRqJ+gNVgNULjfFlQfD5Y?=
 =?us-ascii?Q?tvg/LDy20QuR+XKspqEa3tKQXCDjbn/eRms+aUblKL3tFxbLgs84JG387j0z?=
 =?us-ascii?Q?PCgrIuevA/Z3mOOJuNCebYOUtMQ+fspYvIDQCfC1NWRlfMbME3cYR/S+75kJ?=
 =?us-ascii?Q?exoU9T+8UDzZRFQl3RrEAznqmwBtf0QapqQh5RVIIjLz3nZsE6qn7n0mkzOT?=
 =?us-ascii?Q?LsKZha8Wreze5Ta3nlMe385bmHKVTQmc5o5imQvqQFK2G4CwAFOy7hJCxv39?=
 =?us-ascii?Q?3qj3++bVki0LxP+rPilnk/JW5NqSrX0+jLfeMl9GAsSps0pssCszBgRM3CVN?=
 =?us-ascii?Q?3K15GwfR4H8tVqf+fXbrxuklu5FOu4OmO9ryG0+j6RV8HCu0hTZeZUxtEwHw?=
 =?us-ascii?Q?HWKRUPKn+FetOwYeni7cF1KYyTB6dGy1uZx9SQAHxSu0KEdTZbinFgY/mx7P?=
 =?us-ascii?Q?m48i3IlQXvu4ziVrN0XXIDAPR7MH8gbA6S7xKLOzs5PKGv5E6whEFga4pTG0?=
 =?us-ascii?Q?j63Bbr35atwBHl5yCciEon42bbsKXd6EvzTweeciE45PskiGKuhxF7BvQBJc?=
 =?us-ascii?Q?+kxd/lKeFyNN9azUo67jjjxxWE6hpdttmB90kVasCHfcIKlWCeyWEuv0scPv?=
 =?us-ascii?Q?EsAnPYX21k+HTpGb0xOjiAjjsLBYhGyZWLVgk6vKFWGs/zgiILdkXYGPxJ9j?=
 =?us-ascii?Q?yfKJioQVMn9vFK5s1u2nq8Pc8PVxjMURYtN1RQU7Cw9aNM0b3DFOZ6HEerKv?=
 =?us-ascii?Q?/KD9qmOHQz8XtNrRc9dssW6RNVWc5Ei8j9oupq8uvophP97z1RMv//DNHNL7?=
 =?us-ascii?Q?+2EklguuaTHYMsECu+kXp9LMIe8i4A785puUpW5hX22sEXDyj08u619hgaYh?=
 =?us-ascii?Q?1dPdQAKNMFxnW7sQ2W+kGLiBsygdG4Hp6t3x4iU5icFe8IxSNGsT7NQx36DV?=
 =?us-ascii?Q?ZI3f3CWr1s/gP9O26Qko+LQ6x+yx0v0s/qP3uXCWQ3e6+/6NJLDX26c5r2k9?=
 =?us-ascii?Q?rj7jFJkqD8EI4NP/pJpfFZnc7ljStYhIHtSRcyGywOe4nuCQZkm+xb+osyju?=
 =?us-ascii?Q?qT9HuwiLRUHfiguuMcYgPxHSUS91f77fBI09uGTT1GkN9YvXo7LwhhyjgaXO?=
 =?us-ascii?Q?JCsARYoA5S4RdXeRBHRgaoAu1aHWya3J8pqPkaAeFVsmFMEAQYbzCHPYtUH+?=
 =?us-ascii?Q?quz2G8ATsb9NS6wayzNVLx3O76Pq8/3OlrGz0z+1Inb7LuKFviQZ/XVC2n9n?=
 =?us-ascii?Q?MlSed8z1FlSac1XqqyBjIzxFilDbL66SkYd1E01BZunvcS/bduHvCPmr1mB8?=
 =?us-ascii?Q?WZCN5Z0xUwvmCo9FEiO70FWTV2faNERAV0yrexYAILnZRkuTIOQrs87tZjmu?=
 =?us-ascii?Q?qvuev5Qz1aX3sGYimEqx+OeedG89zLrX2Z3pBR+ZRqVNCUe+QHFUWIyBKcni?=
 =?us-ascii?Q?A+6UQvL2Qaqkl2OC0sM9nlg7VsSQcbRCl1YcFGG0z+oMIgbsJtJkozgCosuP?=
 =?us-ascii?Q?c0UCzRCzeKtdmXYmbzjfNoTxjSLjHzw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/peyvIVXQnziuJbJKjPLbNGUBYr8wJ82FefWHIfT5wUDuKgRej853NTaiUYK39fSHfdkgLJkYmNJk/o4BiVnmXbpWRhaOygl1SEf8PBA3+FpFCX2wzhIcAWaT4aMFWihaHujvn89DR8FigVaH+e8bFphrsB83RvZbp0ouNHdn4WBt4XYXBsV7k1y8O+HGnsggEN2rKTt6dGt77VgKBiaLHyXEazm/Bl16lTtgyXsYw0tCVqdaR7vs17XO+OPzjc/j45vj8no2jZnbMGiLW+7Ip09shP2LU8oJlTsP9IYyBm7m76NRNkVQQ8PdbD4YghH3gBIKL/2PJhwpMu4k91983XZDsddU/yqpIS/1Xe6At6Bii7/xF9uFjMgzlDbMubyPzgRMbCVn3L6v/XeXK9p7yFVtGfDOgJ/7O6TY4TiUz7yKlicATJ/jUUFqAgdMtkuKypopl9lHmVLxHp0mtf5LGYFIUYxRbSEy2Ib3oc4bckV25gowPH/w5H4sawXg06yMjtIrTs2sJSxBmMsGzvfj+BbD26V4Pb9XvIYChYalPdR6C36bghEHz4HOTBFdrzIlm+TMj5QKBQdWH+1IBhh1egnGDjMnXWPa8TSC60O+5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b196cea9-cf34-4f80-fb5f-08de59d03012
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:23.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdcOO1rHxvDeLGKeTypSXRNEcrl/+60q3uhNLDKvBJ1xfZWVxh2JGUG71xw5N/kHbZ8MAi0ht1B3/YiO2ocMESx7EzOmM1A6q58iaj6xdHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfXwO0waHi9jMke
 DER+pAaozo/HD5sLZ2N6DBY6qFjUb8q5uNrfDYbJPwR+BJL68OQv1SdMI9OR1FuQDrAXq3Vqy5G
 Uqe8OjL/0ZF/kD/1Q/R3JdiHgPoR913QfYbTeam+RyMlvJRLkZ5jyfxMb0mYWRc+i+/NogUk2yb
 S4RRTEG3t3UuubVgT5Zdx6uBnmce42ad0tolPJ5pBN30nZuPEQboGDpAr/8w3qbuVGWR1gfJG7q
 zuEQSHSWPf+Q8zsKRNKSCwxzD/2VAg4jrM97o8A0zkQYFPQn1JqaSeAHeD84wR6r2kPXRlC7yea
 e9XHvYDqaDc1z2c9QOjySUE3cQbtWsg/6mhIEPF+WUjVrjJ/wwDMTyQH3mJuxkIWK2J+9C8LyMf
 raVgnGdQup0k2igSJBuBjlXCITnEvr+oTSOO/fmiLWrO5+m7HgP0MDNFqY+FJtMy6xO9w7C4Y+M
 FgtLTECAjzeIQzGvpUw==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69724b05 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s5Ek7r6PGOe4hPFufVEA:9
X-Proofpoint-ORIG-GUID: UAySrUThtQdZZs2FPfTK0A6ul3wqVkVV
X-Proofpoint-GUID: UAySrUThtQdZZs2FPfTK0A6ul3wqVkVV
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75098-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BC79269E56
X-Rspamd-Action: no action

We introduced the bitmap VMA type vma_flags_t in the aptly named commit
9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
future growth in VMA flags and to prevent the asinine requirement that VMA
flags be available to 64-bit kernels only if they happened to use a bit
number about 32-bits.

This is a long-term project as there are very many users of VMA flags
within the kernel that need to be updated in order to utilise this new
type.

In order to further this aim, this series adds a number of helper functions
to enable ordinary interactions with VMA flags - that is testing, setting
and clearing them.

In order to make working with VMA bit numbers less cumbersome this series
introduces the mk_vma_flags() helper macro which generates a vma_flags_t
from a variadic parameter list, e.g.:

	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
					 VMA_EXEC_BIT);

It turns out that the compiler optimises this very well to the point that
this is just as efficient as using VM_xxx pre-computed bitmap values.

This series then introduces the following functions:

	bool vma_flags_test_mask(vma_flags_t flags, vma_flags_t to_test);
	bool vma_flags_test_all_mask(vma_flags_t flags, vma_flags_t to_test);
	void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set);
	void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear);

Providing means of testing any flag, testing all flags, setting, and clearing a
specific vma_flags_t mask.

For convenience, helper macros are provided - vma_flags_test(),
vma_flags_set() and vma_flags_clear(), each of which utilise mk_vma_flags()
to make these operations easier, as well as an EMPTY_VMA_FLAGS macro to
make initialisation of an empty vma_flags_t value easier, e.g.:

	vma_flags_t flags = EMPTY_VMA_FLAGS;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	if (vma_flags_test(flags, VMA_READ_BIT)) {
		...
	}
	...
	if (vma_flags_test_all_mask(flags, VMA_REMAP_FLAGS)) {
		...
	}
	...
	vma_flags_clear(&flags, VMA_READ_BIT);

Since callers are often dealing with a vm_area_struct (VMA) or vm_area_desc
(VMA descriptor as used in .mmap_prepare) object, this series further
provides helpers for these - firstly vma_set_flags_mask() and vma_set_flags() for a
VMA:

	vma_flags_t flags = EMPTY_VMA_FLAGS:

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	vma_set_flags_mask(&vma, flags);
	...
	vma_set_flags(&vma, VMA_DONTDUMP_BIT);

Note that these do NOT ensure appropriate locks are taken and assume the
callers takes care of this.

For VMA descriptors this series adds vma_desc_[test, set,
clear]_flags_mask() and vma_desc_[test, set, clear]_flags() for a VMA
descriptor, e.g.:

	static int foo_mmap_prepare(struct vm_area_desc *desc)
	{
		...
		vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
		vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
		...
		if (vma_desc_test_flags(desc, VMA_SHARED_BIT) {
			...
		}
		...
	}

With these helpers introduced, this series then updates all mmap_prepare
users to make use of the vma_flags_t vm_area_desc->vma_flags field rather
than the legacy vm_flags_t vm_area_desc->vm_flags field.

In order to do so, several other related functions need to be updated, with
separate patches for larger changes in hugetlbfs, secretmem and shmem
before finally removing vm_area_desc->vm_flags altogether.

This lays the foundations for future elimination of vm_flags_t and
associated defines and functionality altogether in the long run, and
elimination of the use of vm_flags_t in f_op->mmap() hooks in the near term
as mmap_prepare replaces these.

There is a useful synergy between the VMA flags and mmap_prepare work here
as with this change in place, converting f_op->mmap() to f_op->mmap_prepare
naturally also converts use of vm_flags_t to vma_flags_t in all drivers
which declare mmap handlers.

This accounts for the majority of the users of the legacy vm_flags_*()
helpers and thus a large number of drivers which need to interact with VMA
flags in general.

This series also updates the userland VMA tests to account for the change,
and adds unit tests for these helper functions to assert that they behave
as expected.

In order to faciliate this change in a sensible way, the series also
separates out the VMA unit tests into - code that is duplicated from the
kernel that should be kept in sync, code that is customised for test
purposes and code that is stubbed out.

We also separate out the VMA userland tests into separate files to make it
easier to manage and to provide a sensible baseline for adding the userland
tests for these helpers.


REVIEWS NOTE: I rebased this on
https://lore.kernel.org/linux-mm/cover.1769086312.git.lorenzo.stoakes@oracle.com/
in order to make life easier with conflict resolutions.

v2:
* Rebased on mm-unstable again, and then on my other series :)
* Removed sparse __private decoration - it is not doing us any good, and
  anybody accessing vma->flags.__vma_flags will be very obviously doing
  something wrong (TM) so we don't really need it. This will shut up the
  various bots reporting sparse issues :)
* Made functions which test VMA flags reference a const vma_flags_t *
  pointer for the flags being checked as per Jason.
* Updated entire series to affect this change, including userland tests.
* Fixed missed fixup in memfd_luo_retrieve() and folded into series. Turns
  out this doesn't get built with allmodconfig due to my arch not support.
* Fixed up issue with dev dax reported by Zi (thanks, much appreciated!)

v1 resend:
* Rebased on mm-unstable to fix vma_internal.h conflict tested and confirmed
  working.
https://lore.kernel.org/all/cover.1768857200.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1768834061.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (13):
  mm/vma: remove __private sparse decoration from vma_flags_t
  mm: rename vma_flag_test/set_atomic() to vma_test/set_atomic_flag()
  mm: add mk_vma_flags() bitmap flag macro helper
  tools: bitmap: add missing bitmap_[subset(), andnot()]
  mm: add basic VMA flag operation helper functions
  mm: update hugetlbfs to use VMA flags on mmap_prepare
  mm: update secretmem to use VMA flags on mmap_prepare
  mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
  mm: update all remaining mmap_prepare users to use vma_flags_t
  mm: make vm_area_desc utilise vma_flags_t only
  tools/testing/vma: separate VMA userland tests into separate files
  tools/testing/vma: separate out vma_internal.h into logical headers
  tools/testing/vma: add VMA userland tests for VMA flag functions

 arch/x86/kernel/cpu/sgx/ioctl.c            |    2 +-
 drivers/char/mem.c                         |    6 +-
 drivers/dax/device.c                       |   10 +-
 drivers/gpu/drm/drm_gem.c                  |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c  |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |    3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c      |    3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c    |    2 +-
 drivers/gpu/drm/ttm/ttm_backup.c           |    3 +-
 drivers/gpu/drm/ttm/ttm_tt.c               |    2 +-
 fs/aio.c                                   |    2 +-
 fs/erofs/data.c                            |    5 +-
 fs/ext4/file.c                             |    4 +-
 fs/hugetlbfs/inode.c                       |   14 +-
 fs/ntfs3/file.c                            |    2 +-
 fs/orangefs/file.c                         |    4 +-
 fs/ramfs/file-nommu.c                      |    2 +-
 fs/resctrl/pseudo_lock.c                   |    2 +-
 fs/romfs/mmap-nommu.c                      |    2 +-
 fs/xfs/scrub/xfile.c                       |    3 +-
 fs/xfs/xfs_buf_mem.c                       |    2 +-
 fs/xfs/xfs_file.c                          |    4 +-
 fs/zonefs/file.c                           |    3 +-
 include/linux/dax.h                        |    8 +-
 include/linux/hugetlb.h                    |    6 +-
 include/linux/hugetlb_inline.h             |   10 +
 include/linux/mm.h                         |  248 ++-
 include/linux/mm_types.h                   |   23 +-
 include/linux/shmem_fs.h                   |    8 +-
 ipc/shm.c                                  |   12 +-
 kernel/relay.c                             |    2 +-
 mm/filemap.c                               |    2 +-
 mm/hugetlb.c                               |   22 +-
 mm/internal.h                              |    2 +-
 mm/khugepaged.c                            |    2 +-
 mm/madvise.c                               |    2 +-
 mm/memfd.c                                 |    6 +-
 mm/memfd_luo.c                             |    2 +-
 mm/memory.c                                |   17 +-
 mm/mmap.c                                  |   10 +-
 mm/mremap.c                                |    2 +-
 mm/secretmem.c                             |    7 +-
 mm/shmem.c                                 |   59 +-
 mm/util.c                                  |    2 +-
 mm/vma.c                                   |   13 +-
 mm/vma.h                                   |    3 +-
 security/keys/big_key.c                    |    2 +-
 tools/include/linux/bitmap.h               |   22 +
 tools/lib/bitmap.c                         |   29 +
 tools/testing/vma/Makefile                 |    7 +-
 tools/testing/vma/include/custom.h         |  119 ++
 tools/testing/vma/include/dup.h            | 1332 ++++++++++++++
 tools/testing/vma/include/stubs.h          |  428 +++++
 tools/testing/vma/main.c                   |   55 +
 tools/testing/vma/shared.c                 |  131 ++
 tools/testing/vma/shared.h                 |  114 ++
 tools/testing/vma/{vma.c => tests/merge.c} |  332 +---
 tools/testing/vma/tests/mmap.c             |   57 +
 tools/testing/vma/tests/vma.c              |  339 ++++
 tools/testing/vma/vma_internal.h           | 1847 +-------------------
 60 files changed, 3055 insertions(+), 2314 deletions(-)
 create mode 100644 tools/testing/vma/include/custom.h
 create mode 100644 tools/testing/vma/include/dup.h
 create mode 100644 tools/testing/vma/include/stubs.h
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

--
2.52.0

