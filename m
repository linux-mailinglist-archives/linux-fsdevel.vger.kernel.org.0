Return-Path: <linux-fsdevel+bounces-56509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24DB18100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209C31887F69
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F457245033;
	Fri,  1 Aug 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWlZaImO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MwI1dgGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CB2E36E5;
	Fri,  1 Aug 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047342; cv=fail; b=XsO4eOULSoqnBIPi1zVjL3CuKE2ZFNsTWEoA2j03mPH24cvOCFb5u0ZvR2qDXaxkSMmeZWzJv3lKnq3VFtrzSGOa+nytwUIKDvYTS46cYneKbLkyzf/+f+BYppFX52v4ehDuZHZPUkoeyy4hISDuE5fS66CYgVSCg5newS80heQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047342; c=relaxed/simple;
	bh=AS1c58QgL4t5gD7d+lvZM875S0iI7ssfz8zN4ehU5ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ATg4adgzXFOmAjl3AvI6avvmVVtmezC1AeuTY5q4w2ZLwqNpG/aNShgpwuiScNSCBVuaRDko5q2evNjxGQnYO6pWDj/kfRaOFvjATgjw/0uu1b7oLEfSIre82eJAOLQ/afbcemh30wwAkZfahZgovOhAM9vZaJwVfoE3gbbMFgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWlZaImO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MwI1dgGs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571B74jq032145;
	Fri, 1 Aug 2025 11:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=v8SCqTh25wYvD3lRt1
	Mt3Pm46hZjAlAsY04XA2Lv4Gg=; b=SWlZaImOq9V3LFegKWTR39rKsJTS9lETah
	fZbr/AIpifNhIUWy1A1Uj2ci+2mTAOKi6viHJc2GWFWRQchnounkydViiuFiJ6EF
	46+/YBJsnq844sQ0Lv5YwmbHBP482nkLkODp2WbQKChsmlbk96LlxJnRAgCb4pg0
	8DoKvg5fI7+zfLJngiL6UsYhlmtZowrQkVOTjZS6p98Wh7624qY7Lv34VLkBDgxP
	awhAD5GKnTaMfJXFzC0wQSm1YkPgC51BYiC9cbLq4VA4oAc5tRhKJu68/l8dH0Pa
	UcE1qIU380UQ4cJIf9s4HFAZCImwiNCaPoYXK4eMOpiAghgFkmww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e6bew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 11:20:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5719UUpj020488;
	Fri, 1 Aug 2025 11:20:14 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfm1kur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 11:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr/ldLhWciKJ0HSJaz9JGYkYPOe271e6dM2lfNQCnEknfLTJqpXkNr/FqjSUoKMhGuLizxGnqBwUWwI5Xa/a1omTgCO+v4uxOxkvest3xcIWbCl7sUZgMpuPHYiiDku0zIMT1WB6EHAzrON9cbzWeYT1QkY0Vg1yEli1DuJrWnhGMff2kfyxPXnDh8d7MuwM6OFWJ4Ome+uRORjPF+RpZ3zySRp5wMisoOgjyv6VJYyaBI+1na79pwd9KuxKheUeE+S2j5n5NACKK3Y3rHhWUyUtXPqBc63/EH0v8ui7l/k0mTMEMei9vi4Wm65qK+8yv8FiRj7LTWKSEmFOlWVa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8SCqTh25wYvD3lRt1Mt3Pm46hZjAlAsY04XA2Lv4Gg=;
 b=QnIja0B/irL0U0dmXPnQKjZHjNjsnpr1bLVsC14DoRkuzpt8xDM6wU34qMnieaAxChURbhr7iho1Y2RL0mzfsVtSHV+81ynQW/aJKnBrDG5HPPKqSi03pOa3IVkHOh/hN07Fh/84y8ohTVLyH+gg6JGfd2cyIZOCt8HOsWKEYiHN3ca0B4rZaF6I6hUGE2Nu65nGFAgQrmJnaOtfuncHLISqYXt8h5kg2dNJwmEElj8nAvfYHU2Q1SjveQPeEy4qbyQqzefKqlk+9rpAZS+xU9hT7+8I7Oqn0sI+MKYpN1axkZaO1i7EhpASCklYlzeUMJQ8qayJFZW+Y5qF1cf31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8SCqTh25wYvD3lRt1Mt3Pm46hZjAlAsY04XA2Lv4Gg=;
 b=MwI1dgGsuzXBmnbmKdJCjDrGZiroEkBLTmYIwkJaTkB1ZO+VVm03HESBTWG1Lnp10WaFf4teuHCqSJgA9ZDdFtRm/ZqWUyPbkRWznuLxT5xNzPGyV+us15f0EJkafYtJaw4hGGlOAtfOKB7IPbxk6RjdEnW1X9VphWxFqS58cck=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6541.namprd10.prod.outlook.com (2603:10b6:806:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Fri, 1 Aug
 2025 11:20:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 11:20:05 +0000
Date: Fri, 1 Aug 2025 12:20:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Rik van Riel <riel@surriel.com>,
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
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIkVRTouPqhcxOes@pc636>
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: d34b2c87-c0ec-4d31-ea22-08ddd0ed5d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWSkbU1craqS4JZ0irEe3l5RBaybj1Up9v/xLp6tilUhM81pFJe+FnJ0d2CW?=
 =?us-ascii?Q?gdtpO79o/td5nhVkxo6aPXODXCHS+2KGBkGGtujndb12wDj52879QF1CV2jL?=
 =?us-ascii?Q?0BZEdyVYH2dYTUXfk7IzHSWoBo48FgB1A/hRQ4TKOzU0yY+Lt5xXUa+n2SP6?=
 =?us-ascii?Q?68cuVqK+q9hpCXx1olQO2AHC9RZty6Ask1fPO0lIQSF1f7vOC1AHJB5okVMw?=
 =?us-ascii?Q?IoXkMZr3Yw5Xis5Z7S9NY6Qf1a5FHt65A7jO5bWLdMV5OLro88SPJgUOPYOS?=
 =?us-ascii?Q?4od93MU5Y+HuNlvY/JYv6RNCcq9qZTG2n4O8dzBvflKtJvjBdZTpfG+/saZW?=
 =?us-ascii?Q?8gFhojcNVS4qtrxxnaSno1KWGKDixjrSgJA0M+PF5YBd8EOfS+kar1CqC4VK?=
 =?us-ascii?Q?GXxZ81XkSr3DGfx3lB3IFsoKRKg9xG9qq7lNOlU1HOFyh/oLLvjeHFqL4zX8?=
 =?us-ascii?Q?aPQur/6JUSmxbXhi6ebPtkBIisPb93ZXoewXJoiKxokivu07VYHKsApqnWIw?=
 =?us-ascii?Q?XaVR7RxBY51CEDGycybxfa1zNmbghxa3DsPPpJ2fDjY9Nf+whjfj8H66O6G/?=
 =?us-ascii?Q?58Ma2DPq14xvCuxftwnNntvxqda7a+ISi6uHmbgIMWukiHr4Ti4mlfNWnnEI?=
 =?us-ascii?Q?UrNzO5veH1MPmjlXBLIujsmu3MfsezZIUReT6cgA07PO/LZCCL68+W5665uA?=
 =?us-ascii?Q?ihRLAmGdvXgRrS9odVlRpduHHcCp7bcc3avHo6rc+pzcyN+8cWsqxUj2vwpy?=
 =?us-ascii?Q?i9Qtqy0aOBUo5q2CuQkjZBCmanaHLpydynyvgHbO67HrYIrpCSB91Lm0OFLq?=
 =?us-ascii?Q?7qcpZuzTum32Ph53FbnVQXhOuEhgbFW4KUTwaVCPb0JiMgVewVAxALbjjkz3?=
 =?us-ascii?Q?4EQDyQQAYpRkaAi/4hbRVPJBchxghIinbctBeMyjZreVNAZQ9SvXHWUaaE3z?=
 =?us-ascii?Q?6KJ+YgRuewzA3CxYYVkU56FaCYvlGveY4mqJyvI4W6KtN+Qwe6jZu43LCjkz?=
 =?us-ascii?Q?pmSFuuxpX/NV1Byc/YGcV6ZKipSkmWf0bRKCsbYoZ+uCGllhQBB7F8vBAD0M?=
 =?us-ascii?Q?dFcY5WbO14y6NRIEUA/Qpiff4nACPCtoGRgudm6+dM9FApX9G4MG0U5lKxCe?=
 =?us-ascii?Q?40fZ5zGkvQkHo+uByu2C29+eyCM713+9/L22BScmqU9TTdW5HWn+NHSKqQ4m?=
 =?us-ascii?Q?bDWXHTzImYprMxhu+8u7Au6lRa9zxFnl9oPYGi1REyyUmOamrjKYd8miy1U7?=
 =?us-ascii?Q?tw9W9qOLbKQ+g+84nA5bjRf0SrWm8t7qFEoWzAPWrU4FY9YukDjaDpe3iEMl?=
 =?us-ascii?Q?54lDaK35z+Z8VXzqeeM17ON4itIn1OE1ucxk9BwlhpKSqv7CSv9ENuQiWYeG?=
 =?us-ascii?Q?99PCd5wVjddI/YNhJN7cGHLzp9FzajKrdRQjLTawPStxY1AZWJb7UubQs22J?=
 =?us-ascii?Q?12YOdztPGiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c24tHN7toEMUnyNpt/551N/ka1StxPezcyLSbB9t2YBu43+h9U/OFDYs5Xft?=
 =?us-ascii?Q?jYR0HIccVUHxeEzxLf/2t5NrryRfCScP7AzZTQXt6zsKdMI5T8i0h2/2ZNDv?=
 =?us-ascii?Q?+cETPFmdHFKsU60IP5eyWrOkPQ/ojS7eDSmo4oQS55/IkQUV6mwlj+q4EmOg?=
 =?us-ascii?Q?j7aUfruVJXKD8f+4IQjkUglGT6OuhKaAJBuiIVPB6/9GUsUK+V0z23/4kagp?=
 =?us-ascii?Q?lJmz1xVaWS4VfgtwboFQs4E/p6xYnxYTEffoG0/EUhfKkZFUL7mEu5d2Q7pa?=
 =?us-ascii?Q?TuJrLk/Rp+2ij5M7oVKAn7Y+UzWj0MmzUb0cYeAnuKUPcjK0KIhxR1vOFYms?=
 =?us-ascii?Q?gXm7h2eQrrHtJVt1mBUxYpNA82qB0Aj5PrVyExVdo1lGyuQWXDW/gwjIL4iv?=
 =?us-ascii?Q?FIMXvt0KiN5cmqEpBuaAHlHRApCtey/xjjYEus88oCk48uTij74fEMk9UuMV?=
 =?us-ascii?Q?Hk2PkqBBiV0pgjNcL6Agv/MlL7p7C7XmfTFjmUh9iUpJoij/tShKrJJu2xLc?=
 =?us-ascii?Q?Zw7gMxPyLCbWnKFKl9qveHFdumCNsB/uJkGVrct0WgpeF9iwgPPWnj6l5sQ3?=
 =?us-ascii?Q?VHn5Kbl3QMlZLSqciZEXXX64bGWQaklL4S5hdlzsgcLJ0FAAPJ/prgn3DsCv?=
 =?us-ascii?Q?4SlScDicRqGHQqchnw9n2Q2uGXDFIgCB3g3tfrjFFZ6rWl89YSj7a5bIkOR8?=
 =?us-ascii?Q?HDfecZi1e4QezQPUxvkq3dABzzN43QhNbmIWt8apQWBGVGt/68k1e5wZ6XdI?=
 =?us-ascii?Q?nSRLkoSGSNgiF/xvCgPtMUcVLjcVZoTEgITsBXWtZFo6pEhqPVXDdBcotY5N?=
 =?us-ascii?Q?lIE0cMCHrQLJl6Zk88ekO/hu703T1ZmhB4bxz3610Q9GmW0E962RA4uBJHI9?=
 =?us-ascii?Q?eXLOKEoIgtfJ4jXX9lz4rDp/pfvXftXMhIqw/ZNe13XHr4VUp1ZOzqwL1HdZ?=
 =?us-ascii?Q?jcBxAeWXdVf8xckrBTQVWB1SBW3FG/PysodLjKebUnBlWrBgKeNol4c2fq7u?=
 =?us-ascii?Q?bzgtLNtBXx/bHylRQoaOSUQlVlh9bJTkpRXU9Z/kP05OJamZBBq02S0J00aJ?=
 =?us-ascii?Q?+28ve10nTJG80g3n1xouCyK2pK09A3spyjZqgf1o1pzLdLIcIjOSz4MtKrO1?=
 =?us-ascii?Q?OQCOpDYAwtEOcTcrFu+aFxWNOdhK9CMzMOOpXTurQsV8DdX9L/cIpiwd2jKl?=
 =?us-ascii?Q?JuguRzUraciWCOfk2T1P5BabQhAApNrD2S/X97PUBJL6HP8mnFcTUVIFajC1?=
 =?us-ascii?Q?8D0AVc0kbNHYCxaYWs+C9xvcNzvAqPIVJegw2y+Ihx+89z9LBV+dF1Vj249t?=
 =?us-ascii?Q?d9SWgYtwRh2R9/+Y5eEganPq6vFoXFTwFmHpvOF7FgQtapNtr+EGOrvoa2pf?=
 =?us-ascii?Q?QAXsqPsnuXK13ItYuDn0IivMrjHw5+/Uyt/84stbkZclzE8Buf+dzylEca0a?=
 =?us-ascii?Q?oja7q6XNHZdB4oLX+dstiEGzyUQhbg3I5g6XsBj+mJq6aVB2do28JoApzKHu?=
 =?us-ascii?Q?7UpUFY3KuKHAWrxwilk/2iDLwDMYGWfKPr/+UUak+v8AbP1lhpJC+YGC3as/?=
 =?us-ascii?Q?Oyi2E9AeRi/lL4HNlITsA86hM5uGIiWJzj8z2k8OFRXSTV0TYT/OI7cNcIbl?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ABFRZTqIzRaYdJnU0E6r7vVg2NIgRKcCzAQ88xuJbifkqisqplkTnYesqYR0zBD96ajWpFhpJD0QaEqSOcWeBvG6FNSqbjvgQe+W7r7qUB6kF546sMurtVJdYKCjOOhNMM00CDF37FbLmj+Zj/KI8ssCX2DzqMGlRFOERvMKYNE8mjEuzYR3OCO9HSTh8SYFH5kg3thNCFXwhsacf78SQQ+3gYYJs68meY+1gCFNQiIrOOE+4she6XrD3qYWFj12e5EUHzAfwkuw2C/1XTW3qF/H0BVdPFfUaqUVw1j9E626VszYg0ydJ3iou7YXKvCjFnUnX/tNII3q0XdYkpmq/FEwDaTwh4R3j+nJPm9908Yj/eK//vELbZLcaiQINtzfEJhWsouqyszpbn6GaoexDG8vH7zIqZznJwWzFuSJXvTpGh0tMg6TGMxYGkk4ju7eilD2ULqknJjJ8emCO0gDHalw9EOLNFg3nCJrorQmQOEHdtgZ+59m81MTwdJJvsdreko9NW9DpwsFnyJYXy1lvDvx5mPWtugsUbu792TPME1I+4IynNWb1Qmy6jXCwXhufOlk921OYALLZW9xifxd1qhVgRksVc0Fo4xknDZBLm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34b2c87-c0ec-4d31-ea22-08ddd0ed5d74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:20:05.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/Dht4xGSlTexB+bH3Zc7JWdrK16mU04qNCnS2vhW0KDXc2IN8BipqetgkcfkMIG4lTXCl6WJenF207MtG3upAu9UMHMu5NZHgf496ofGdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010084
X-Proofpoint-GUID: QbY0ksTySb3ICLjARGSaAE-e8bUUM_8y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NCBTYWx0ZWRfXz4Fptl4lFfwB
 Hh37k/kwahrwn/adEL0PSebzfDU5R5P2K0y9DRUmy/KAdiTWEBFM7lPwjCGd+3kDahMbGZqbIEN
 mK+99i5JZnN+rIDwad0lFzXdpsW9TWZLBqK0ghxm4vaFkIoJkeTTH1tmxM3VyIg2IMvCmMltUTT
 PNNVC2Wvx5YaZOEw+63cDXqfDNZMrejUrUFY+xfq7uC6+U+tu+kumQwYZyAN9FItjf7736loUQg
 4YDKPolIfxBON1+EVzfurrFwwyUWKFeDtnviCG25Thz443lDwWwVFq1xyfOohAsGV1USU3/ETTA
 WXZmrvUbTuWNN+FawHiEemXXqgietv5NiZikszNfkU9RJUGU+Xhgod9u5noeyZS4mGRa793aQVz
 2bWvLCFPsYkIngtd/5YCxDRx+cJYRVDntOPyZJoBPBqQmFtojd93YjO7UMzs+lIFqWZD0nf7
X-Proofpoint-ORIG-GUID: QbY0ksTySb3ICLjARGSaAE-e8bUUM_8y
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688ca2ef b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=W-BuJQ1ab2AFM1Ey5ewA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12071

So sorry Ulad, I meant to get back to you on this sooner!

On Tue, Jul 29, 2025 at 08:39:01PM +0200, Uladzislau Rezki wrote:
> On Tue, Jul 29, 2025 at 06:25:39AM +0100, Lorenzo Stoakes wrote:
> > Andrew - FYI there's nothing to worry about here, the type remains
> > precisely the same, and I'll send a patch to fix this trivial issue so when
> > later this type changes vmalloc will be uaffected.
> >
> > On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> > > [Adding Uladzislau to Cc]
> >
> > Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
> > same name and (currently) type as vma->vm_flags and is already the source
> > of confusion.
> >
> You mean all "vm_flags" variable names? "vm_struct" has flags as a
> member. So you want:
>
> urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> 29:                          pgprot_t pgprot, unsigned long vm_flags)
> 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> 85:                          pgprot_t pgprot, unsigned long vm_flags)
> 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/vmalloc.c
> 3853: * @vm_flags:                additional vm area flags (e.g. %VM_NO_GUARD)
> 3875:                   pgprot_t prot, unsigned long vm_flags, int node,
> 3894:   if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> 3912:                             VM_UNINITIALIZED | vm_flags, start, end, node,
> 3977:   if (!(vm_flags & VM_DEFER_KMEMLEAK))
> 4621:   vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> 29:                          pgprot_t pgprot, unsigned long vm_flags)
> 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> 85:                          pgprot_t pgprot, unsigned long vm_flags)
> 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags ./include/linux/vmalloc.h
> 172:                    pgprot_t prot, unsigned long vm_flags, int node,
> urezki@pc638:~/data/backup/coding/linux-not-broken.git$
>
> to rename all those "vm_flags" to something, for example, like "flags"?

Yeah, sorry I know it's a churny pain, but I think it's such a silly source
of confusion _in general_, not only this series where I made a mistake (of
course entirely my fault but certainly more understandable given the
naming), but in the past I've certainly sat there thinking 'hmmm wait' :)

Really I think we should rename 'vm_struct' too, but if that causes _too
much_ churn fair enough.

I think even though it's long-winded, 'vmalloc_flags' would be good, both
in fields and local params as it makes things very very clear.

Equally 'vm_struct' -> 'vmalloc_struct' would be a good change.

Let me know what you think,

>
> Thanks!
>
> --
> Uladzislau Rezki

cheers, Lorenzo

