Return-Path: <linux-fsdevel+bounces-52233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B289AE0597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173F21886F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75024EAB2;
	Thu, 19 Jun 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZiEUEvi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mh/+Fbd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BB23A9AB;
	Thu, 19 Jun 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335721; cv=fail; b=azUl8XdH3qHGUPiXJEJ6b5155limK+1PGDBDyXCIgpOHpuE7Fc4BuAbFQVAXxlJs96jgOH52G2Z3fqCtsmmB9yMsV0LFfs1PFCwE4pDDlV7gdUx8PprBjJAVR5tGjz7Zzu/BObmo/uI8mBCbPGOpgEvws3JgKCl6qFFMrW1BU3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335721; c=relaxed/simple;
	bh=Xauybx3v5ugIFRSSLQiGjGbO/hFeU/lnliW/Oqwq4X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0dQq98i9IDMDyA6qXxj95i2oe+rJkk/EkAqP5IMW7jJUQ6rm0tWRyKPO+m5r1mrHDsfmlQb9NG64+l+D615qOqewpLeVUjle7RryJi6GHBJvjPiRK1PqqTIpEKbznJfATwY38pKTXzZHgZr6gCCCeanJWP+gGG5dpG7C71yEiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZiEUEvi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mh/+Fbd7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0fnAX027951;
	Thu, 19 Jun 2025 12:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=72Lan2oQ8Bu/kt1C9y
	/wVzINyardzMwhQ+RHNS6+qAY=; b=JZiEUEviFVPAb8Ql9NDr44EJgB2aSf+AqS
	nelBlwr1npnj+MvTXuso1A+5GB5Ig/U7eGP96zPL7AWCiyf/NxFXEMezx9r++81Y
	4p/GncrBHCnYkwA1pwfTbUmC/MNR5ByLwj3XNDZJALdW0QbiAjWnoGSS0KBnxcOy
	LfGymDz+WZJZhFI/vm+NZ7TkxaLdbBh8z1f2c2jFoEusozFhLWxGqRNBN6FYLGaY
	iq8Z1vE4QLKBBm4FjFXqAz4Ghx6PzCFl5KKKB6JVbIueuXFlH2lU4ZDDrlmOiwoF
	dEbADnTSyMMZVgFNdXNMhsxGytBqy6kJKRAr5sP/Zt6NSfLI+CDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd9s8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:20:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB1Fjs038292;
	Thu, 19 Jun 2025 12:20:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhbuhjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 12:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD+SqB1HGl0prMAIzt9E6DaW9GJ/pmd+bKZ1+zp/HDobKe7IkSODlVmm4PC4yseoPMPZIjP9PxkB082idx/5jp0mDoBZJPL1atimupDwaEiYwKq+iilccQSzeiR4ksOD1fIdKW3HWEy7n37CiPYKi5XDu7AdFsKQy05OVzGQ9M18XHtcTx0ZHekPQvZXf3z3x3ENQ/1S2JxIXHuEEELhDbaM2FqcaZ6XeNjBFvQQ47RyrG51UJLZAut3pcdy6dpuQkFujQzp+wDV8ToUW6RkRzacUt/TRWWo9w0f7D4RD3Iibp5kkwlPaYmC6RR9YyqcWEkgKh5SO2PLq08xuWs4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Lan2oQ8Bu/kt1C9y/wVzINyardzMwhQ+RHNS6+qAY=;
 b=HSVmZtNS1a1QN5WQEI4+043Gh+798uGoRnNEM3PCW5bCRcyiwt6sxr+qx6nQfUinZIk3dXH/oyOKF2SbNWmPTzegDJ3s9Q3fVl2hGn+RMycYwmNtd6AUFbqVYZgSD1VSfKhwDlQnXuG4Idl7nt3va5vRgHwL1XNCGIK443nmg9GwX5kFO7xW+3/fFDySz7Ql4UFvSpTjjzMkCtKU9uOazUgfbyWuV7LV07igfDwgrkK7JF8VxlMwTN9kB0SEJe9mHjwIyfzZkgjQ5AGq8mRAa05gvNdCBxKpGWfjIZ+3u7kKKzU82yYM8ZNfvHHGoK3QiDTvbXeR1VTSdye/yNnPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Lan2oQ8Bu/kt1C9y/wVzINyardzMwhQ+RHNS6+qAY=;
 b=Mh/+Fbd7nAQezvnZE3xhMBNawG8DeqGfSc3W7/XKcroI6GfkLywotwxRIMqHJXWJ1/d+QShWGHASgK3Pla/Tz1OmGH4CoBQV1qbbJSOK9GBukCjpN5ifnNQjlFR4Qj7dNeLOPYDu3sHr/9ryRMdLoWP3hj+QocS6mXdKJzzY6TQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFDC03D7E75.namprd10.prod.outlook.com (2603:10b6:518:1::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 12:20:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 12:20:20 +0000
Date: Thu, 19 Jun 2025 13:20:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
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
        Muchun Song <muchun.song@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <73731c15-1464-4705-8ba3-4b4f7d3dff6e@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
 <aFP-wf0w8Dno3YyV@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFP-wf0w8Dno3YyV@localhost.localdomain>
X-ClientProxiedBy: LO4P302CA0040.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFDC03D7E75:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf77e25-dc06-437d-24ab-08ddaf2ba878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbcgFPmVauh6jUCJvO7pN84jqTBEkz3DrWp6jy/Uc0qUu99embVuuY5o1Okq?=
 =?us-ascii?Q?19Z8RLGxzIYPu3l7omrISEc0slp4v1r1NPc7j5STcqislbv7hSvpbq2RMqWP?=
 =?us-ascii?Q?3MdivjztckHngb/BLECfGVe5mqyjgHhdpSlMfq2w3olXJlmm1C/0OfHFaroR?=
 =?us-ascii?Q?d81RFSUM+lKOvU6LGdOfJv7qXd2vQEOJtJiFZXX8gcgrXVUDKgGgKWBZgU6U?=
 =?us-ascii?Q?v4lFUv0xUxMM0PaOLN/6dqN8QSmnGZAF6vUiqgMyVCK7DrtCDSJvnklr+e4M?=
 =?us-ascii?Q?j+3aotYSTHBI3COpakcEoqekxzD4DP8M4Yel5nEInEPfvV/P3l7U8tubcz4E?=
 =?us-ascii?Q?dGSjnk56TjeC1SMBZx3FTf/YVOJsNa8MYCwzJZWGeKrkpLUMSXxxtrHFws4r?=
 =?us-ascii?Q?OGOWoPKfAoLd8UvGmuhYDaLKsO+dhOE15UIYuG/3Ar5XCocdJpepjRdbShg9?=
 =?us-ascii?Q?s+RY+hVQ8ogJjIWh9wLIeRqaSJSLkkjrJK3Te3mPS4hXDP1Bn4mGBNdKrRpF?=
 =?us-ascii?Q?EXVQpltPnIoospOKuD0qCVD+cpahU9YcAXD+P5YwhmD+xErnePxTu7p5pBQQ?=
 =?us-ascii?Q?uv6PxG6jV+45oabarMDEXeVh/Pye2/CdIq1LYEoVldVirEiMgu3LWpCHAsmV?=
 =?us-ascii?Q?7MiI0LSOO4lC+Uxf+0wWy1uv6mxqO8eDAZEWHIPf8dhlRXu3/qDdlOUIYARt?=
 =?us-ascii?Q?OsqnwuXLmezfYV/AUh6nL8KQEeBE+YlZ6yAfFw31OZArygpcnS6rU0yAocPg?=
 =?us-ascii?Q?L6UZskUifn9U92fzzxhXOijDri6RH3wo+/QUWzM8K5OlvAk63OsLVoHWrx1L?=
 =?us-ascii?Q?264lDO91GiUmTghT3PGWZao/tIAg7C1frtAt3zcgjxQecf4BUQZsfzyVKQlt?=
 =?us-ascii?Q?sE5swN5nlC69OhRRzqYpCeMyWs/TqDyR0dJnCSm2k5zj/RNYn8w2fyKreV8y?=
 =?us-ascii?Q?gAS98+C6iHSkWt8a5ER3g+VBUjFHf+akKVyed9Pf3CV/8pU7LRenHvJnJlwy?=
 =?us-ascii?Q?9R99F9EBJVpTQomgUwVjuR6aGWmrZK2/VN5bCsotPGSP23BqgaM0HqEw2dqY?=
 =?us-ascii?Q?6g2Zd3H0gVhrKQM0xpl7R/XV7vXoNjFr6S0qmh0BlTuTKEkJnu2Y8LuPgcpC?=
 =?us-ascii?Q?i7lXy7GQvKTsto0eji0kCilp6n5SixURQc+91aGklFkQcXBt9saa7rnK/24N?=
 =?us-ascii?Q?x7G7hMKdMUHXIIGNJOroP9OJJII5tukcGIelqjiUMC/FIxUsprQc5m2t1tO0?=
 =?us-ascii?Q?GriYci3DI5AHreTX3amUM5wQulCe2jMu/Yojsgt4Yr9rncK1G+/20xDbPJbH?=
 =?us-ascii?Q?Oj5Xf37GgDXiMZVpTP4rfysOI6cF2PObQxBS3LkkLw++lxLmnLcK6raNIq6s?=
 =?us-ascii?Q?hN8TE9G25vjbExDrFDAguLIhlAOXmMxZ5ETvo4PP1BpLSKEDDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?49D1VjPSebwBFz6Djytza4phdJMSIefyJB5W9nJRJIdqwu0m19jNIBv3cKb6?=
 =?us-ascii?Q?+D8u9ZQPBQOPG0luWSJdAHcUd/2N70NrmzsYW6jDMGyVVEbCWYMJN50jUS7N?=
 =?us-ascii?Q?jwP9ITyxunWQHkqxtK13+kdki4//JOIJgoS2LqSaQQ2uA3wIXYXI+BP8Kg+g?=
 =?us-ascii?Q?zp3oDUrkCWjDL6aOLRQECrn5onej2QLmZt1xquuGAx/+NXhdtq1l5yvfTfmy?=
 =?us-ascii?Q?EBcSOEiKTZfpX+qhnaMaAiVsksXvDwzlJamqyQP2pN6hvFNNTuv7roq06B3G?=
 =?us-ascii?Q?9tRlLmcWIKQYd/ZgW/4PGN4RE8ceX6jbkh/DvIZYeLeeed3aZ9KFlWROLwF4?=
 =?us-ascii?Q?1Tb1xi2R4Ggz1pFrwaGIYckF9eca8oqQfEuzsYo4OWmC3P0IAwBU2qrfOpR3?=
 =?us-ascii?Q?/d+RI2At+NnALGW9bfEmThX4DQu0rqEstkxAaKh8IsE48o8bpHAkchbwLdtS?=
 =?us-ascii?Q?MVE1C6no6OeW0T+p3IEkwj36+cCIR7Z+ozSt6PfpPiDWkGb3w18q7Dcwu8X9?=
 =?us-ascii?Q?vAM+UfytKAR8+xgDQoztrWjTI1ee8HZ/HJReMppJic7uX1EkpTEpWUrfoBqp?=
 =?us-ascii?Q?LanWdUPidp0ZY96iCyP/0jPiERAn9S7qlBCiVJUa6MObvhCJuCgzaIC1tkB5?=
 =?us-ascii?Q?yAvX/dg/5VMApJrNrHnrjUJS4v98foMOFvcgoyJ2teJML0u28H6dfp/nQA4F?=
 =?us-ascii?Q?zzZIiC2LKmjSRXNptIa6sLS4XDZKLWBY0GKCwKdwO/4Y1Mr/iD6ZlLM8/N4x?=
 =?us-ascii?Q?yrrUjxiE+ePBPGadgLIoawm1X8jeRNFy+kZkQHOQOcdOuKkXhjXZ4I+wYYQr?=
 =?us-ascii?Q?7pbgin+jvsAZaisJIypnlDAa4g237zAOcL4HnaTPgZJgYpTsE/ZcmxtwPsEO?=
 =?us-ascii?Q?wjrH+7FckY/20bqeN2ZgfqaFZYvTt4EkqAkIyOihBrpCaOaizBHaBK48jzzr?=
 =?us-ascii?Q?eLJiMydM+cmTZhO/2Pb/ce8ah4cyGX1GQzuXBJ9uO3K/ULLF6JZiHNiIiuIf?=
 =?us-ascii?Q?KUZJZ1Yukh3iNRRKSLvOgur7DyE9MU3d56v6vwgQ9btn6J3cIV2ogzIWU5SJ?=
 =?us-ascii?Q?IlZfRA9RX6F0WRBkhl4DUA57EoIHeSTSdcnSk8s+FNiMPVl3AIZA1ryLkCzh?=
 =?us-ascii?Q?3aqqaaicvlnd9iPxMwqBCpszJMLCqK2azCJ6aCW2+p9tWGKQZL2cStBEWxdc?=
 =?us-ascii?Q?FU0InVD+Eq7+UrUWQZ1FKMCa6MLy1CjyaUIY6QA13/n7p21kCtuBDGT4K8Gv?=
 =?us-ascii?Q?nJ2Z3swuvtiVRMxDUTLNZ1mQuCyF5RM60NTqB+q3k8/Qdgbrp/QMFFImzt5F?=
 =?us-ascii?Q?OyjILHvdS62FJgoK8BSa+6MI+WCtguLVMbpBKaaic3xwZ54ZGXVrUhllyPDX?=
 =?us-ascii?Q?S7T+rg8s04cTyr3oL2Kivjw3qfg+cdyrPU/+AjdlGRetFGHvGyLNrYeUCqie?=
 =?us-ascii?Q?RPd2iVJH0UxX1ERAOdKA1xd0e8VmrFuEOZou1umhoiNr7UVR+H84j+ioq+oa?=
 =?us-ascii?Q?SSqFioeLEBuIaeVkWijQCBVWUBwuHpjjY+SQO670OSd2KDtiXRUsAYQrj5n5?=
 =?us-ascii?Q?Mhy3b+kzfDFZSGTvQz8B2ap1hayb0P7qrB8X/9i17mm9t5JPysB2/16yR07U?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cCcP2efedR0oB64myICVNJ6r58f8heQIT4nTt2BrlRVG7rsk19Cph9LsTatsbzPQNLimbQo938ODsQKNOfOuJl+x86KDAmD7K2JwnZyKzfJlp6WMmgElfir4zoA77HoqUA0TI8VPSjjhb5MUfjy4azqjX7RJMXj6Ksben0QjspqT351IaFl3UHbboaLl3BYgGU3n8PPIEJhH0Y42YYqkupgZJIP/zutQmpqq9bASIiA5lQazZ+gz6eLq04NxHTsZPwkTAqxz9MT9DxVwW1/kqNwhUudLy2rYDnJWmhx+dwqIWXUE8HODQaapO3rjw4zG/zMzr8i0tQ5tLWE3/DJwvmjXOXSPp2BB1nGn7Q9tdmS+4i5cnG1iUC3+WBfWEbYLV/ppeGJD2Jhp45hiZEdI2u2EIHSdvsRO7Ol8J1mJ7rKijbpnln5KfOhmttuEROEZmXrWwpi9U3S/CCluWpWF8ByhP+eEMGs6YLYX2RmozDDd+LRJmCUnkeX8mC1IDcDS3CXPf7lAndBz7XOHQgiSKndsjw+czdr/Gh+BnEsx4sjTP7d8iM24cikRN7hz+pWV+hM6HPwNdX7fr9I/4SgNiR+70/opwWHXm6a6xnOLX9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf77e25-dc06-437d-24ab-08ddaf2ba878
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 12:20:20.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvHCyNLF7tZ7vC85Afbn3kEwES+Ls5lCb4tasG8TNsY6hYW805rptauM3DN/uCrwG5Cv79GsMIaNPWcycZmU83KA+rubP1V0L6q5IkLL2QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDC03D7E75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190103
X-Proofpoint-GUID: tXjOMHf28wUfE5RODqKjVbQMdsCm9_SD
X-Proofpoint-ORIG-GUID: tXjOMHf28wUfE5RODqKjVbQMdsCm9_SD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEwMyBTYWx0ZWRfX1zSw3oOzcw/d rnSTre+5YOavg7vrYUn+sCFpVIs5iFMQXV2vYhdq9VRVRn1ooYT5zCwFZ6aY9raDhK1Gkb4qxL7 X48V0PrBlSnx8igP8DvEvCucWxmntkWw19XOUbk0DiCpIoV9lhx5ePq39956glhBwi+S8G5tP/f
 Bp6obpOBp7Ix+fqqqV4LuvtNJINhFFk0JZOBIKFhJBsUXPsafw/ifguncEqcB243s7Umf8Ldo0O usdvMVabaOa5ir9y8MtLybqQ6CY2+7ZpOnN8vc24Muy3XRhcc1vDCXf4bfl7Tb7pXkCl2iAe3hI asTUeYjMQY8/bD22IunoyXMeIuuVmenz9gePG7b9z0ZzVmuiJ+lXiA/GHGr1RM04MPftpvp/d0Z
 BiaDddaH33SGIwPVNcKZuIcR5Mj5dR+Rpk2sdbfkzzvTNqzvWty5CudQrliMJ5eGIIwavNA/
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6854008a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wlu9cXcACiiQqOzq1xAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Thu, Jun 19, 2025 at 02:12:49PM +0200, Oscar Salvador wrote:
> On Wed, Jun 18, 2025 at 08:42:52PM +0100, Lorenzo Stoakes wrote:
> > We abstract the type of the VMA flags to vm_flags_t, however in may places
>                                                                   many?
> > it is simply assumed this is unsigned long, which is simply incorrect.
> >
> > At the moment this is simply an incongruity, however in future we plan to
> > change this type and therefore this change is a critical requirement for
> > doing so.
> >
> > Overall, this patch does not introduce any functional change.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> Same comments as Vlastimil, you want to push vmflag_to_pte_pkey_bits
> further to patch#2 and bring

As I said to him, this is invoked by vm_get_page_prot() so has to be updated too
as a consequence, so it belongs here imo. Also to be (extremely) pedantic if we
were to push it it would be to patch 3/3 :P

>
> arch/powerpc/mm/book3s64/pgtable.c:pgprot_t vm_get_page_prot(unsigned long vm_flags)

Yeah I checked so much and of course, of course... :P

>
>
> --
> Oscar Salvador
> SUSE Labs

