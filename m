Return-Path: <linux-fsdevel+bounces-52846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C223DAE7772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C901BC562C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D91FF1C4;
	Wed, 25 Jun 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOKlrlp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qnntC9DW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F701F3B8A;
	Wed, 25 Jun 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834199; cv=fail; b=haEPSIUmuPonoNhZ5KAhSczZI1wkA6uffufzNzR3VyphwejJqIWoBiLCaiPvY0r6fPixQNPOmN6H8sQCqfXcfF+q1/JKCTEdtQAC9LPhqfkNw7KVUW0t1nWhNWh82kDYVatMCKW6UKJKo00b5pKhGu+RoQvxvnLtDElm50oU2+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834199; c=relaxed/simple;
	bh=aO3T4LFnY9oVX+2Pjmrz0kLUwHgxJvI3uc8hyy5ylC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asEn3EJuk67GMEAJ008X1s9bxJPwKc+yWI1wr/5UICU0x/gQILgs4Jr7oNyn8hEW0Uqp6GUkmsChgxGAMNo13bCMVltzPJ4INlnM09sChupIJzS3QSmMSbqv8R8nOaOF1Vh6bid+wQkyWKjyzLpgRHfMexUh4uFl2EZ6E6q5RLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aOKlrlp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qnntC9DW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMieMn027065;
	Wed, 25 Jun 2025 06:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aO3T4LFnY9oVX+2Pjm
	rz0kLUwHgxJvI3uc8hyy5ylC4=; b=aOKlrlp1hepfPPYeXraU5a12tCoztM0Eu+
	jemxjOCYXCF38nG2SHglf6gWKBg2vugB/0XOdxobjBx58hbBKaxCsro0BWsDkIDU
	tv7wJtMaQkyvJ68rribb9/8FFFvXD0AEZlvRyYm5AJsLeANjbJBT2MZ25A/ZNKYN
	wPYUolmuJ730rV5G6K5DhbS3TL33vrwFyb9pnPVik62xtvcMG8CsfeVb6zkreWMV
	MZ1iysy/ZuEmdrIKH+q/3MkJt5Fa5Cty642Y6ZQgW3JYHLM0m6imjQ1uqbU3Oly8
	8wndsHe2dRl3TH7dvNTAJlGIOuudcnIHntjoRNUjUyccTjh3MitA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1dhm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 06:47:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5P5UC038982;
	Wed, 25 Jun 2025 06:47:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr5n3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 06:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5zfchnunT7E6DKCcPUhG7yaWOPC594VazDeJAbrVYq5NaDKB7D1cgQMBknuvnH+INvZaKDWzjoUPQe2T9n5COtwSWwnwZTG0xAPPvX8m0vmnLh3Fz8mlbysM0W9/Gz+9/rFyzsCGEXSzHbm+eJedrMLgkk78b7O5AIH+55+sNsJZHiNSCA7tiRA5fk3myEn9gU39o6ATv41khOd03xoB+EVgNQOiTcJ3ZNeEVHORfaLdj8TWpCLabu4wbTlT9/S9YHEB6WCyjwhUm5PAPtcdmEcwSZfH5rKbsJHaW27XyBRG1rH7WJmDAiZv3hnvlMrO05UCqgjHU2Lviw2AxWZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO3T4LFnY9oVX+2Pjmrz0kLUwHgxJvI3uc8hyy5ylC4=;
 b=DuHIguDee/fuy/d0VYAjW/ZfAHZyz4L0xGth+n2TEoDW2Km9z0BxBMC5Rkad3I57tD+PoJj2UD651e1kTfVWUGY7haE9FQQJxoJR7ZcZbGU0f7A3g+F2U9JvO8ioT6ZmGv9CwDHj4PfAGJ7cplHapcd2G5WDQN3JGRwQFcXBs8gpOCJjB9qivfn8LOC0IPL3tf8zO/r16G3C1PySd3A39h1tONjzxeMcgqu0+5Z7zwdkyTJf4P6BijClg/6Q/8RcKBt75PkWwmLMnCF28RbZogHN2e4khDGk1qt0AcMtphoUP45ax+gNswLVZol2A6Th318eYfKtXMTlL75TLpd6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO3T4LFnY9oVX+2Pjmrz0kLUwHgxJvI3uc8hyy5ylC4=;
 b=qnntC9DWUqszGULw5PETUYYZY8v/setXfsRbSw18FZtw+NbGQr28r1HjIuJh2IBzhfXudotSbgMatoBG4qmLE6Zv4105f2xh6VzZzRemZdibg7zadteK9gyTl32WC5Kq9nSCrewADbABcQFbiUMjVAIIT5Q3yAoFYcnjgUB2814=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6559.namprd10.prod.outlook.com (2603:10b6:303:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 25 Jun
 2025 06:47:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 06:47:28 +0000
Date: Wed, 25 Jun 2025 07:47:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH 0/3] use vm_flags_t consistently
Message-ID: <d4286364-b138-4219-b022-a9f8f49305a3@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <46432a2e-1a9d-44f7-aa09-689d6e2a022a@arm.com>
 <20250624215050.83229f93cee5994f580720e6@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624215050.83229f93cee5994f580720e6@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: fcee87cf-6aa6-47d1-b2c1-08ddb3b42709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86Cq6bc3VEpF9CDvGhMxdzZ45el61fvKn4h47CzvQtfSaBR0liI29ZCqslJi?=
 =?us-ascii?Q?WnS0EdeCMUyYj9TmukDcJqTYR2J6Ltd3wx69/9BRBE76MMj9wzE+G0rAj3CL?=
 =?us-ascii?Q?rLBGG5bYVnn5Yb766QEGISTvqOFqFEikQgbGZM74u4O47DoO8UYzd58607xz?=
 =?us-ascii?Q?kjzWzuL+XCdLl8uC3o3lQzcD3fFCmnBC1c8+M8Mbg2PV5A3nogewT4rlmj1W?=
 =?us-ascii?Q?snRKBygoWrU7HVJ9CoGNR+vMSlYpKwkn/51ju+izDRGa48s2TXukJ3AIt/5h?=
 =?us-ascii?Q?Fe2Wh7jAONYzzNfE6Ba6uy7Dpe7yQNfINEIzI++dtQmBphefxeyPoo0SaYER?=
 =?us-ascii?Q?SzTZsU7Cuyh5vrbzbvpQVHZM80YowTUC5tPDEnOPAA7jwTp7z685ImM3BfL/?=
 =?us-ascii?Q?bU+CG+cFs2RVH/y6BcVw7LNzltwaVtmkbj2QiBR2nCCHmhjT9vk6h9rp+cdN?=
 =?us-ascii?Q?G8eGSJVd+GTrx1AdFPFsGOuuWBb4jSVqOgfUwgpJ9Mrb3joxJdSoQ3WlxX6g?=
 =?us-ascii?Q?nR8r5f0yQ2SCEeWklLyTKB8n3qFaJqmltsDGStd3HFvvaEht59vTxpMmxFjs?=
 =?us-ascii?Q?5omK2OTR7eZPdyL3PX3G86naQDEPcIJWKpyHe2vAwVMQlAXTDu8UK9YkqSfd?=
 =?us-ascii?Q?pntEcQ+6zTu44WeaU9ajkcIslGyiLGfFYL+13mKtAxhiAnxGI+GUAnnBONBc?=
 =?us-ascii?Q?IvqAcnVn4x+QByXZaBggO4DLC5c8PWl41o6ceFC/fMP4o+LJTAiRbRyPAcbs?=
 =?us-ascii?Q?AC0knNDWr1WO6FUl7veWZ2bvT31QffQfTZfJS1YYvvSGGvtfxCDlgCNfvNgs?=
 =?us-ascii?Q?e5vXkyfJeM4V5GKnyULT+CgrpGvAW/u6oIHcg2TdWfPwbf9Z5KYHj7Woon1x?=
 =?us-ascii?Q?wCBl0ICkjNAYannXVzMX3MaOFRABEFILSswnddF6whRw0qVO2kHsGfM/HRIA?=
 =?us-ascii?Q?lfP2KKCIXi9Z7fK2aR841cvPqahX/HKQ/niBcQVnnPZhvzA1cAs24LnP6pFp?=
 =?us-ascii?Q?OIsdQvD5CE5FRt8a7LLORwscNk+50dTZ0znVUCc6rKcoqfK7lUi/q6aSPxER?=
 =?us-ascii?Q?X5hRSsBr7EeXUBdN/gUPaFWTSMwzwr4GWD4Sn8DVGkaIejvvpV3f7tU90Rh/?=
 =?us-ascii?Q?PpdCmFKM9TyQjG+oXkYsULCXZfs3Wrb9dfgGCuPfdofWRsOI1ibVA7vuKx4C?=
 =?us-ascii?Q?7SJA2G2HR+fIWeMcSOCtfdSJrxDLPTEdChwb/AAbZzltFjYRNQCj7o9SPati?=
 =?us-ascii?Q?GgXJ2Fc0P++jRcT7fqoOxM/lAmGHw1m9uERyouwgHaSsdaagOR2hVrTmK7cH?=
 =?us-ascii?Q?AUw3KDqSMKvNehNSJijWX0PwksC+ErwMsY+teGmnSObL+AG37uUPoZN4xRsJ?=
 =?us-ascii?Q?CRr223C+3iO5e0qpE/Z907C+iBIuJMI4z5b4I8Z69pw2MhxbxdxWtcqWEefT?=
 =?us-ascii?Q?t5ONEdk06Jw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXDfwIQTFvjHjCKqEHGBbpweWE5tGqTIfKW+4FgiPuLNz6ROaoNhH2IaSTEI?=
 =?us-ascii?Q?VY0A3v8N5o3sdujvmCppvUXyphOWzcaBQ8LbG5zXEjyEw1cQs87WaCkbYHRc?=
 =?us-ascii?Q?eqQUR5dVC2LgIDIfa8CQTIMT4bIvRBDyfg182jLZGmcsIZTAHCLOr3mFho7n?=
 =?us-ascii?Q?ouZ1/iQy0cP2w0I7LwUXh9XF78HVEfyNLy2vQP/EhZtgcN/lB+9q1lCE50g0?=
 =?us-ascii?Q?DgXrwnSDzm3FK7sDsPPZtTzYLOQyY8VbnmM0yt6jZAetU+Yl2EJzIBqaHdrc?=
 =?us-ascii?Q?JVKaE+YkQh0PDBc/puS7GYAQo30xgF0OR2cSPCUf4jaUEoLZkPIVoPRBcrTG?=
 =?us-ascii?Q?KLvgc9tFAngIl8KE7KXjR9Wc4zibFyErSJZIgf845W+RthQgtSJgZYjLZ+/3?=
 =?us-ascii?Q?TzwQPOjouxsV7F4GjxOGVq/e3fY8QXT5L9JrV9ZeGAEeaz3jjWpsLepEdocN?=
 =?us-ascii?Q?6eruWb5GQfazfc1kYhRe6nYiIyReVSLoYH2+UzMDUeoSgGKhwF2S31zQgx1M?=
 =?us-ascii?Q?IqgvtKCHfa4mnU8/CiBqDnZDSo2ASSTfKd1mCnbnoqMndgC9ClCVVt4NkqG8?=
 =?us-ascii?Q?ys1hScBqpDGn/yaVZPL8pWLB8zmKjp61fr/1Q4QnGP2pyUZOPGfJBNn/BUX2?=
 =?us-ascii?Q?MvNAeUiifyEs1ajyEVtYkSiKzu5Z2RoZys1gcOfoEXRilj9joW+HPL8pR5Od?=
 =?us-ascii?Q?hTykV/Gato6sR1l8eITg5sgYmsxaNaZs8NN5GCXvjG/MszNxKK1Kzykd5AKR?=
 =?us-ascii?Q?ltN3KBXr3LRsIB4YMhqW7iDyEw4/PrpkF3ut9bv6FpetdOIzu3FesLKkxreu?=
 =?us-ascii?Q?N1Kh1GpU1j9zMXYVHPTS6iYxMjdVrATkmHNLvSNvNXVCi6adPyluhL37aiRe?=
 =?us-ascii?Q?LPh0/WbWLseVoeZhGWDy7m2uaTNosNz8rLl5i3rp6keVqPyH717xoC36pC/f?=
 =?us-ascii?Q?OyKqVInHWOx/HQQwNKEd+iQAwT3UGSSjMoDkwqPRMSHTAQHub5nssgAY9PFC?=
 =?us-ascii?Q?UMLISn4aOjmqoHmNvw1Ny4pCk5xDREVkMh3GMU0bfE5POwVW/KJGPgyO/en/?=
 =?us-ascii?Q?jf19t8dy3c7pkWyraCnXSBfNU6QN1g/Blic78l9CqHIuBc82d7TOnppLJqD4?=
 =?us-ascii?Q?T3jVAoR975yD9slbFHYy38ajI6r9XY99bBmJTw8s46+pyhbmx8YFPW7gzznh?=
 =?us-ascii?Q?KXtEKpxToebRgxT3BbDqJ88ijBUTy9HDSng7P/OrVePFGVTMz5S5sihtW9Wr?=
 =?us-ascii?Q?HWddtkqvLrjpfbfPEYnn3OIjHnqswlAKPJlhp79BjS05hA7OvPZEYXSpsjT+?=
 =?us-ascii?Q?4MmZ8Vv4gl3wI2mpBl5++X4DUilUOWokKWzBo01Q/f9p8uQ2vodxcWaARo13?=
 =?us-ascii?Q?xpte/TfYt7Kmv3B/D7WBp4HQsMtC4O9jrPkApsDq7FYVta081DSq/V8+fbkS?=
 =?us-ascii?Q?H5RMfIwwZKzkNULdwVJIXIPnMA2JH1k37j7Eaimbl7UuecHUCBQRXqwVGkEv?=
 =?us-ascii?Q?dgP27hzpfKzWLpoZYIMIV4sBPvuFS8viIMGX7YJmO/hNbr8/StUw3tyjLIns?=
 =?us-ascii?Q?zCazIgucdZZKYu19cvnfjPc5bGkil5To0dLS8G/UnmPPSXvR6fgBquvzhJnM?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1hIZGFSuThG9eYxqK/ITd5jfBu9N0/YoDs9YCl8CFQeQFk/ynKoX1bW/4mjxZHGT5bTtn2BafMeyVKTf3bF/9koSEUp3IWJF6iMHVjVxqf9kcfYSBKYL5EKtyXfVVz0urOzXGCc65aIAErnaDt3x5jiYm4OXJgbliH40krIBPld/Kwa8rmQRr09zYwRqW/aM9sKQ5kb4opE8PS0kzzDlrzSnYwTahfJym9vCcpNyktTWgoMEcCq7z2vetlYJXTakZUSi8oXAic3OKbSDzWq3U4Fp6ajzJzpu0XMDbZ3ZIxfYo0mMG0lr7P7yzFaGPLoMVQk5hGt8HfiQWpYWX3ghrEAttyPVavSU665WvPUbSMZ5s+8rnvVsxJjt9y0bDXBQkxqRmS/OEf4kIMEC8E2d1dinRBiwNdSLQ3uuJIxxATtIlnHLOLcmFKIrKo4W2+3w3/XqkeXGiFgOluFtWLouNOla0givuXsucuiPGzdvJ0Hsv3dzzxKWixUGysOjRvHbtHEGICIqwK2ReZ7WVAumIS038IwyC8Ktub2jkGFWbPV75iEM4VYHMSKm2I5o2ZTLHwKZpevMrWhufz62ESMP4LikMpqH15aXZQ15Y9Jyg0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcee87cf-6aa6-47d1-b2c1-08ddb3b42709
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 06:47:28.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AHmbbjKu+rWodn04r2Er/sbC8H8T82qjUJhJ22zaqg66lxB7X44qU6yiayTbZApRZXk+tpknW9QA1LVXV+6Koebl7dKOdV9p2RA135fPlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=860 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250048
X-Proofpoint-GUID: oLr2_F-Tal5gz-R9VDd0opPybo2e-_Du
X-Proofpoint-ORIG-GUID: oLr2_F-Tal5gz-R9VDd0opPybo2e-_Du
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685b9b85 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=4-0xnxOgkHFIApZ0aV4A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0OSBTYWx0ZWRfX1yJt/Fy+O7qP 92BiULAB9HPhCTlDYkpQo3Pcr5F85wm5ZkvVtz9dzWQ1zVdH1FrdzBxbusSds+rKOpBFoSZGpa8 SQceJLYugZcSqGSZVTMe5KSRT2wliXCvMg4ex2rAhTV4f1x9foVN92puhNDFD6yoMxNN6p5Olw4
 J98fVOBoJB99w7YazvCZjI1gU9XkNwn+QJsgHz1SdxKSGIMdlrcfNabsX6ufnRz42ga1HT31LIj RfehLD8iPDszu/sxNfgF4j1n8YdwhJtlRT0u2jIrmA7TN2LmScJBQ42BS1brcR1N1RfBF1ATvoE NRoP4xXAwNhpTiAGZIpo+69/KlJ/02mdglF+tyfdBkX4ZlErHsQoiEbHyQVuXGRbgADAEKqGfH4
 gGpb/eoWikeAYaPpFtKy0+Lv/sOMO/rhC35eJ3HTQs8HQ/7OABnBTWCxldQSEE4DklUs+6Ao

On Tue, Jun 24, 2025 at 09:50:50PM -0700, Andrew Morton wrote:
> On Wed, 25 Jun 2025 08:25:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>
> > ust wondering which tree-branch this series applies ? Tried all the usual
> > ones but could not apply the series cleanly.
> >
> > v6.16-rc3
> > next-20250624
> > mm-stable
> > mm-unstable
>
> It's now in mm-unstable if that helps.

Thanks Andrew!

Just FYI Ashuman - it was applied against the new and shiny (TM) mm-new branch,
maybe we didn't publicise this well enough...

This is the absolute tippy tip of mm development and so may be broken in hideous
ways, but it's what new work should be rebased on.

Then if accepted + stable things trickle to mm-unstable for -next testing (we're
trying to avoid breaking -next too much) and then later mm-stable if all's good
for send ->Linus.

Cheers, Lorenzo

