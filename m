Return-Path: <linux-fsdevel+bounces-52110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF92ADF71C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BA5619DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057B21ABD7;
	Wed, 18 Jun 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aZCSIWp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mdzUWpfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248C3085AE;
	Wed, 18 Jun 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275966; cv=fail; b=LmPtSvomE7zVqX6ruvHXYQ5ZYMh8aI0X/YOzKxAoyAUgM+VSeXEcB4iD+8VuwRF2Eek+9TycuypfybARSHM8A1vw1zewdgpUB3TTgBQvZ3DzCUsPmY0nJKiq77T0CmfEECWeAOD6wXk3IAi7hmj170tY/Eb2cQaMzET9ImFl5vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275966; c=relaxed/simple;
	bh=kAf2eBcKBidGVzvx47/s3rLVQnYvlYeUjxRCadtSg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uExX83BE4B8apXbZiqQ9acVD/T7fqWDPjQ6/c+IOWRDzhGP7DJe5Ku69FAjrEhfvRmV1t/AXtc8pP75KDGiEyDJeE5IeDJ4Po50ZqKDM9fkE9BfSeCk+z1fsSvYRfRRH3/n3TbX4Ud3FWU/V7Aw7O9eEdNlGFx6nAHTJ9ZViQ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aZCSIWp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mdzUWpfr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHfa4H020621;
	Wed, 18 Jun 2025 19:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wW/YjoZmLhtAi6e+cdntJIeLAgh3Cg6FpJGw84pVHj4=; b=
	aZCSIWp1tpun18GwDB8ctMAnl4NaLtveo94e+sBbbpGXHXoiemc2sJb7uW/uW8hZ
	jk3WeoaIMVlq/e8dKZNdTQ0nEwyvGthWnUlxzLaANhNtXarBy1H+IjtHKkq59DQh
	bjsTlfx0vuuOHj5G/TPL3WNfmhY3Aeeh0V9rDjxi8SdDgKn96PfuWRvlVWhS2ZAq
	wrTWqzCI3HD+9jS0KE9CSkxBhA1UbYOgrhdvbnYpQ2r8tytxXHnqKRfPGOAI+d8I
	rCON1gqJak+ZeqaHmHY/UbDWB8zc2u3RJDiZ1TGwwfHHepHCrQTk29tV4XZh0i/F
	6fPmVK7cFrJx0qlXEgB+mw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4rmpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHxTWj035207;
	Wed, 18 Jun 2025 19:43:22 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhau6qq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq48LJCCPwAB341wi6CbLUmd3Lpdp0hnbk7T2hqiTCLKhe5Gm720lSvZSmlQmZtWgrWULbNxC/wWMc4LsJ/paYqD3o/AhLiA2bB0hzIthe79XdBjk5/djuxrY/lDx7itfZek05/ZReH6ykgho16mveCWR14LV+3DliK9JcTJWPMlqQpLLNfLeSR9pxlv+y+KTv/t8vlSkP4mfdcmI8CWySVjAsV8zNlWlJpk7kyKAZ/CL1KzKhTa3LiTnqFI+nvboFTPIRRDzfEF/g794w+NrXNOgWh9B8Esa01rH+qyAzb5SDz7aCEk/qcy++mjk73acgDVD+Griyp8YdRWqx9LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW/YjoZmLhtAi6e+cdntJIeLAgh3Cg6FpJGw84pVHj4=;
 b=iIBv0zecGWpNPkNX5MN5rlOsGRBwtqO2PoGAvcJgiCT4vqS049+hN7VmfLQS15NC762axgWGAod+keyWQ+i9VVzYGnWzDuPCRZAAVGO+QmmalFNMFQpYOFK6NSE6AuyRdAJ5Kf08qSCiToPLEVNzP7XRs8JHDtc39Qce0ibbLYMVajhRxsdGxTXQ8jdWi3PBdN1L+V1XcHZzAA/wqCHzbXGmIJkOm8FGEYdaOMljsxURLosNfj5GKgcOelotTlU99TEystlRM0fZk37j7Nla5RJPbsQBhp5EWYzrJtILUbPlFdwikJw7yKkmHyY4Zge9c1kFF/jvOjGuiyI9JLPdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW/YjoZmLhtAi6e+cdntJIeLAgh3Cg6FpJGw84pVHj4=;
 b=mdzUWpfrNR8VxthcPpYlaCd6VhnlV4FCupke5vtH8MtrWeue5BLY/ZBHCYYfksp40/6OiOLz/025jZ+p6NvLJMJ0ThsPgVjpsFprE9DPEBtJioLeXfgXU6iQ0ibB5OXHW/zYtF7ecfCRcsP0mLs8tpY0R+B8NLvCNvQEAP+AMH8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:43:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 19:43:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t argument
Date: Wed, 18 Jun 2025 20:42:52 +0100
Message-ID: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: bb152b02-b581-49a0-ae97-08ddaea05e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rafAPJEV/+BD2y0q/iPlqrbDbIpgWTXMOmg3l6l5UiCWrh1MwetsQwptE0e3?=
 =?us-ascii?Q?ycjy6MjR7gMoGGf/7001YWaNRlgDd05IUFVkwxZUsr+RcBo591N4BBUHozB6?=
 =?us-ascii?Q?IdlgkdsVLGSNkPazAp/epkD288rwJgjaKqd3xeupx8I0l7vFr2TVSo0MQVvo?=
 =?us-ascii?Q?Yf0U4UtjSb6q60WP0dQfXzyxaQ4uJnHKTvyS/vsrDMVKSlpOMkOIbRtQw2/f?=
 =?us-ascii?Q?Z5FJ46PxNfPM/DQKGHU/cfvkmie0dMhW3UsL+bDjknZPmM4EfwP1HY59EasT?=
 =?us-ascii?Q?VpcfoOg0WGpXjEU1Ggpz0bsuTN8n0fKQy8WNoGCoAJ+wvfMo2zARH1yyymSZ?=
 =?us-ascii?Q?7chicNuaSs/6G6ijFXRfJqkn7PFBtE7nTJiDQW4xcm+1a1BtZgQsEXm/rWy6?=
 =?us-ascii?Q?lqtmKZjubOHWbD1dDvkGrB/PTX9t/fG2mnaDhrp9u//8VulR52vpkjYBz4hK?=
 =?us-ascii?Q?W/VevSz7bE0TFpSEOm2FbsuqFS03NIMHeMWI9uhssl8DLrYHrGUR4H82JL7C?=
 =?us-ascii?Q?2O9Pi7A9kQ1psf/ZDUqm6OwjVr8ScPu1XefIWKpQ80CW+hz/uNyorqr3PRAY?=
 =?us-ascii?Q?7bDsZ34r3v7QW/XM1qqeqVwAhGEqdbqUAGpfeeDJYEV65znMb945i4iFXIEr?=
 =?us-ascii?Q?s7iZMc3aU32KSQ9wKwTfLG/Sdzhmky1gx/fEm7NlIi1iu3CFnW8bMcZp7cDS?=
 =?us-ascii?Q?YV5g1Pq8m5XPy89qMxIU4XTVTPXtyZx7bGRsDCnj/OrxW4usehLb9Lncmw9t?=
 =?us-ascii?Q?HHQ4qGN0dgJjUV+uNyGGtz5PCQZZETC+8nYNv68tAovOftqUjGQeMGgix1B2?=
 =?us-ascii?Q?OuYMhoExzKXUV4UzkKzIo+q9O8+aowE7qHFq3wsju+ZDG1IlTu6gD7lMsDRw?=
 =?us-ascii?Q?9dTsm5CjsPyTZNPZoplsgLMIzV2XShsRDogVHI2JV9I+j2MoLr0meIotShjw?=
 =?us-ascii?Q?0jplwidn76jFh5hJs33rq12akLNNb/iD+f9vx9fgeebqSdLBjRyeR82g3Y68?=
 =?us-ascii?Q?zDathHbbAB+aeSfVEaBBPZxBG0mVebzEPF0C1GeZrPz7CPQ/sztTdVl/lGbG?=
 =?us-ascii?Q?fQs3j5MqSxFIdupydKp88egYkIlMvXXnnTakm9Y9GIGVzkPNGi5teDPMWlu2?=
 =?us-ascii?Q?+iTAh1XfpO3TXufvFDIWvhcCoEDc253PKjFjhXNnoZZ310xukXCxeDUZuo3L?=
 =?us-ascii?Q?M1Q+IsEUTnkHpz6vUcAW8U+50vY+I5W1qlU7cF6ikIJCg22IjrQLjXXHQd99?=
 =?us-ascii?Q?mlpNK6AbsQ4bLsc5b+OARC8lEPByI99DmMII54hNMOMPKawj2K+tMlcWhBpx?=
 =?us-ascii?Q?eHMr3WHsBxVy/cr/L0JLCNfW9Ng9T9+H9cpBNdEz/EsEV1EHLyZRsm5iui9K?=
 =?us-ascii?Q?RKtevy1ntFosx6ezunGnMDlnduNUUpiOEgf1R6ilbbG+n9X+6+AqxjGrhrQF?=
 =?us-ascii?Q?TfeTIDv/hXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4SUCovtzpeaOEwXzIWVNoRx7aeIFJnv0GQ1fxx9nlzfv9eHg/J9FTlQImH2?=
 =?us-ascii?Q?Tbq23NFAEifBXsPVMDFxj5xiVbkFB+i1/P6W6Ocj1P8ZfEF9dRFRDjWZQx0u?=
 =?us-ascii?Q?AQv+baDFVVM4EKt+7VCSQsawnwlYZMaheLUOdQuTH4n3O02uHT/C57N9muf3?=
 =?us-ascii?Q?GAnfBsFSrBspKkBEjTW73tj9v8KxX5ql6+kbjhFoTWPM/InczH02hBTrleoM?=
 =?us-ascii?Q?kSgEFhwJG7n1DN0fJAWEAjagJnlVnkRaoo2nbDV1x2zVpBC4wj/xCp78V1in?=
 =?us-ascii?Q?YfvAE0ThSkF9iYo6V0ZfmwPXyxLARe8wNSWWwSygXsuOaC2MvKB/9IxZPM+Q?=
 =?us-ascii?Q?V+mbA/bt8OJ6w6CsnORwX+KpalWs94ILxtDIiOwzHjnhSOpAAReOjFFP2VGr?=
 =?us-ascii?Q?PYpVznlD0l00FZPG+qKAVurLgriMZIZ9yQ+KV0hemV48bkkTGl8zVzC/yyhm?=
 =?us-ascii?Q?KL5bhpNGueAAgnU/RSyBK6jD5XZy4ZFIqmT7ccUrz/TCSECApEHzBPKaG1Qa?=
 =?us-ascii?Q?abk7KnnFKBGxnkw31XYy5r5ta1LvRvvXECItv8tU4wkLEahoNSSkk01jVQQE?=
 =?us-ascii?Q?+NZuhETM9buWjI/d1rIZaUCcSlMhRVT8e25bgjiJ0TuMNGrMYAeKIw0wJcuU?=
 =?us-ascii?Q?VW7Yw1gHg7CBY7arC/GML/XQ2eBxQrWEI30xxIPS2eQaLAcZWq5ZV3pTOv0i?=
 =?us-ascii?Q?fmuPcaTA6tJqryk0QFFrGWIiOagQ7nk6FyBLA1pvr+WqH+O8i6Eij5y/KyLR?=
 =?us-ascii?Q?o7dFUoatoo6W9T+JomJBCzGKV4A6I4voBOGoIBuWcP/SfcllbuOSljJQotfW?=
 =?us-ascii?Q?XPMIskJth328zzVLm8gUKdtyP8lKlRJQoeA1dFfgawRPcVUsE9lLUKBKQTNy?=
 =?us-ascii?Q?KVmWDeLObkbspeTafLMBuK7SrjLmIi0T3Nd5uMX3V3dqq7hwMNkkD6+v3qNM?=
 =?us-ascii?Q?X9uAoDw+0ypENtMv3bN0XvdVaGtbBag47ozuL6qKlcYVdnI7G/Ayo0q9xRFj?=
 =?us-ascii?Q?mRJQUjJRXH92n0hiu+EEitz6GZUFcItbgsjvmfKevyLL3g4en8n4XQ3xXnqV?=
 =?us-ascii?Q?A3q0pNw2N4u/VFv1HBnMiRZfo7D5SMJHue2mb90/zCdEz88YBPQf7F4y1pWp?=
 =?us-ascii?Q?eGl13HRvMxPa2L3flBR5bpStAWaLcidU9bDRscYLv7mi7gK2KD8bvuVCJV6J?=
 =?us-ascii?Q?Nvz9fm2OY/mnuC9mr49vIXtJnUQ24/pbGg8uzo0R+TStcc73HOy5G/Mu43tC?=
 =?us-ascii?Q?r3i5fJsZdkzyB8ELS5QhTORV4o/9cGU+vkrI29Mj297/5UXb7R7p1bE3VFEi?=
 =?us-ascii?Q?czBxLOdgbwhTEssvxTdi/m2UPJxyDAKToeZJZy7miPhlPfiySxRMxC8+TWS6?=
 =?us-ascii?Q?HCQ8cF18ZntMo/1DHLxGL0NHYZu7P6vwMWjcgY/Rmh3WCpzbXoLCNTwZcK0C?=
 =?us-ascii?Q?GquWNOx/S5x2pHTxQbyZbbSmRRyAL4UOcSxsw1sIRo/WUl3Jyr4BlTm5I275?=
 =?us-ascii?Q?Y56oGqGJrMcCdfXSWkqKMHE8zfKQp9s2FKMR0kCj16COJcIrc3b/O+zEzbB9?=
 =?us-ascii?Q?KOjIZbAE9C3C0Z7SBYhj087+KP7QTEr1GqNwP44dMQhnAHo1fvP7SjDRmIbI?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HwPD6n2qvLg+BqfBHH9+65hH67qpna6iUkkZfd8lwrvuqZTDcKWzwpWX6TgFC+rBzepu5Edm51aRezRUH4BSffwZOxa0wK+NTILhpqTdktFhjDF9bLFCjAW2/xleiDIk+27xhYZLw4CJlOJuzvOFhDCODxI/BOQjxRPXhL80sxNZfGN0oK5e9mVG41dtL8gPC3fNqMIUuFRPIT7lM+oWvueOehT25tDb5zD3Ebi921Br2O2J5yzjih2S1Ni/X28ppEauXTb0TxM6KGYFqG/7tbkEEo/lPj2O106EZkE1bcpxeJ05sFsR2K6M+/f1mvCJYRjTptrF7BQGJk+esWgsIbZIG2oVFWTP9rXQ7gULjcK7zkL+wLVhNTmMTBWkiISMzGhU8hlOf4A2bOucB2zzmQZ0HVyPQsPkWzinV0xkO3UmS+jxYl6xqGI1omO9brGxGk0QzN3R7hCEOkWDJxyMckGZ/vz16EPAl3Z0sXWcu54ZKAVEYbvVDxQ7+1SsfGnPtDIgvYtGto9A/MSaENpwm8uBsl+pX7AwpROVREaF35GzEYI9PlM4hr2VzKPSv9qGefVFeH+ZWMdlT00tgxau51B888PKW3KkYUZR2V4CtJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb152b02-b581-49a0-ae97-08ddaea05e7f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:43:16.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyVYgD3BwX42Zimc8yr9VTb5tCsJQJj3JawLX/x9rM0iqfrNoIlk1Bbe0O4uO0A+TY4RdgcHCFuHEIgIYsLExdYSygP4NOLFOYHmJsBHzRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE2OCBTYWx0ZWRfXz3gcNZBdb/yA 8OCQccMMkRJvGJ89/vBFv44Te4Xiw4rwFEehyujo4FUQHo6n3CdULzYBrJ8pNyn2sZx9DO43Hs4 FNzsi5KakXbNXy6S0pBIce6pRv3K9miEk0Ld69Qbi35PPzy++1Aj+11FGh7/95CtUycnhInxecw
 f+1mj+5cPuyxm2GICekd94AQIZsr+fn6tj5486hrNdDUCe0vz+s8L8ZozgPl/Gj2SKib+4GYRhY NLvSHCDkvB+huGDAgKsmuGGMKH1MutGUw3FlM5y50kzB3xg8ZZhazGJ+9WdTZw0bYNBJIPqa37F TpFnO/1YlOhul9aXwKmS6yaipNHJQ5gEPCEffOG5J/paZSHeeV9Rbs+TsiitZrKOKGbjW6tH1iD
 z4/Ea4eC+7thAQMOowh8HvSG0yUVQyRuBq2a9AfAbwcFy5JX8XRPqaACSPU3pTwtErGfyX7R
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=685316da cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xdWvT78vWAzaNArEY18A:9
X-Proofpoint-GUID: nTUesMU39E2jIvCqP7cuA3pg7ChuA2Tr
X-Proofpoint-ORIG-GUID: nTUesMU39E2jIvCqP7cuA3pg7ChuA2Tr

We abstract the type of the VMA flags to vm_flags_t, however in may places
it is simply assumed this is unsigned long, which is simply incorrect.

At the moment this is simply an incongruity, however in future we plan to
change this type and therefore this change is a critical requirement for
doing so.

Overall, this patch does not introduce any functional change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/mm/mmap.c                       | 2 +-
 arch/powerpc/include/asm/book3s/64/pkeys.h | 3 ++-
 arch/sparc/mm/init_64.c                    | 2 +-
 arch/x86/mm/pgprot.c                       | 2 +-
 include/linux/mm.h                         | 4 ++--
 include/linux/pgtable.h                    | 2 +-
 tools/testing/vma/vma_internal.h           | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index c86c348857c4..08ee177432c2 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -81,7 +81,7 @@ static int __init adjust_protection_map(void)
 }
 arch_initcall(adjust_protection_map);
 
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	ptdesc_t prot;
 
diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
index 5b178139f3c0..6f2075636591 100644
--- a/arch/powerpc/include/asm/book3s/64/pkeys.h
+++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
@@ -4,8 +4,9 @@
 #define _ASM_POWERPC_BOOK3S_64_PKEYS_H
 
 #include <asm/book3s/64/hash-pkey.h>
+#include <linux/mm_types.h>
 
-static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
+static inline u64 vmflag_to_pte_pkey_bits(vm_flags_t vm_flags)
 {
 	if (!mmu_has_feature(MMU_FTR_PKEY))
 		return 0x0UL;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 25ae4c897aae..7ed58bf3aaca 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3201,7 +3201,7 @@ void copy_highpage(struct page *to, struct page *from)
 }
 EXPORT_SYMBOL(copy_highpage);
 
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	unsigned long prot = pgprot_val(protection_map[vm_flags &
 					(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
diff --git a/arch/x86/mm/pgprot.c b/arch/x86/mm/pgprot.c
index c84bd9540b16..dc1afd5c839d 100644
--- a/arch/x86/mm/pgprot.c
+++ b/arch/x86/mm/pgprot.c
@@ -32,7 +32,7 @@ void add_encrypt_protection_map(void)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 }
 
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	unsigned long val = pgprot_val(protection_map[vm_flags &
 				      (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98a606908307..7a7cd2e1b2af 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3487,10 +3487,10 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_MMU
-pgprot_t vm_get_page_prot(unsigned long vm_flags);
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags);
 void vma_set_page_prot(struct vm_area_struct *vma);
 #else
-static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
+static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	return __pgprot(0);
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1d4439499503..cf1515c163e2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2001,7 +2001,7 @@ typedef unsigned int pgtbl_mod_mask;
  *								x: (yes) yes
  */
 #define DECLARE_VM_GET_PAGE_PROT					\
-pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
+pgprot_t vm_get_page_prot(vm_flags_t vm_flags)				\
 {									\
 		return protection_map[vm_flags &			\
 			(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index d7fea56e3bb3..4e3a2f1ac09e 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -581,7 +581,7 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
 }
 
-static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
+static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 {
 	return __pgprot(vm_flags);
 }
-- 
2.49.0


