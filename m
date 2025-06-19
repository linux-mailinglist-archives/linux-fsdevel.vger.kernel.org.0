Return-Path: <linux-fsdevel+bounces-52190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA524AE01AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CDA16F1C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922B21C161;
	Thu, 19 Jun 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1jUE46s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58403085D0;
	Thu, 19 Jun 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325473; cv=fail; b=jMNXbPkuVypk1o02D1PucKWsENFhfMNqRP+FFOt1T+IVOz2Cxe/jgFHeIrD+914i4yDYok868i4lJHfd9Z6rDeoKm3dRZpDExWGUp/DU3Ohp2X0F+pE4jSdmItNMR+V6u331Wmtb0m9nZqn0xlCDUymYn2zYdTQQiHQyHvsmJ1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325473; c=relaxed/simple;
	bh=SWSlWx3bUPADgENNPOf88wsE0zu6YTF1jspGZSnZkYU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oxO2329cxocqf0GAZkA5QPPphJwFcxGD5YUSo3qpmR6RGeRJsKfSnNa65lowbBi5SeDQWIW9MjYJ4SxsOroNuRiRDkAcddQlEwFGjmoARUS2NIWNtIMjUIokAJ+eB4pSlB3VIRJINw7Ratb5wiUiP3goMK6zNoZuvaW476ARnqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1jUE46s; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750325472; x=1781861472;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=SWSlWx3bUPADgENNPOf88wsE0zu6YTF1jspGZSnZkYU=;
  b=Q1jUE46srtSB3tJzfEuc36ZFBpF8VjBQK3D31lpJG64v+137Cy+8lNmp
   4vThtAt3pbadJfNQYFeVwxz6IkWCUjAJeeEiHEcVn3y2V5LqyARh8KACC
   7TY6QjBRlwXgUnW+CVi2JdYUJl0goXzCnzy2FQ34xXLSbo4xVGypJihN0
   e4nx0fR65rsF7kUHEs3ou/kYZNJU2qr0I7e3ioXlQ1JXuMRY5xu2gdtm4
   I1ELG2BI5hsW5c4wVTw0zTB3n6qyFt3WlvKeS5R8LG+9qM23DJ5PULwb4
   EnOE1+BtirRbuYinc3ECX5uSx5JaJIMbo3cVnYFpHg4kk91EMZyuDPieH
   w==;
X-CSE-ConnectionGUID: 1wj54vu1T8Kt6lDcc/yTVA==
X-CSE-MsgGUID: jDTCgpZSQ66sZnOCERBx+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="40183411"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="40183411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:31:11 -0700
X-CSE-ConnectionGUID: OuU7F3VbQ8ewlbe9mHy+Ww==
X-CSE-MsgGUID: mAOjKYumStyBsqm4RrWiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="155160522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:31:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 02:31:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 02:31:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 02:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7n9IePFffczQo8dIzdxE0+X2Z+NFVD/V+/Wo+0hdPy47Oo5Q4n1Y968ZMQHIIcuw5LsK3nXcvitTd5V484M62KFxIDrLoPwQglbkJPDTyEji7CFyJG2CFoJlesGGpR9OE+FVlc5HNhTXsGl0CE1qCvojnRQ7LFre4ci25cghIMK+HcLDmc1+0hzs15htVRhRmF9WQaoIrX57QJuNly4DtXrbd2M2jwXF8Jzdm9RNkFv7VSqvkyp0HD95d10TX7ZZKXn3DvObIX/hvcf0Q0z7QfjMdDUGF2dJjHCzGNgoV4nkArQ5HfCCx72oNOFubVv1xP+d7TTWMfDr9C1SDA3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66sBDpxvn7r9vtmaihaoCKdCD2zJ9R16mx97rLf9tfc=;
 b=tdQ84sWQf6tKld47TbK66MwB4O4Gz/pCO6UC0lQrS3rWr75wWqizzWHWR5xDWbQvNb2KP57qqpGMyLCeJ+uyUSRKKIqWNngwmOx6m/BcO9pNMIwClZDFLDxqcW3p4PCw99nn2rod5348Wg+0vgr/FNbx57XK0aNta8zRlbMM/mTrnKeiyDkFjRDCMAhVuXlJZz4p/xxZR2ZmTUBrRnLi8VfHLh/QjaJgOWvokEfqy66QuauDIRGJB7ctnrwN8X9IHOiwPO9yZCVt41bY2dog174+aaKIdQNcNxd8pH81bBlmanLUiXas58EkMtH0Leudmo6Msx9wJQRRPcwDud/tYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SN7PR11MB7467.namprd11.prod.outlook.com (2603:10b6:806:34f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Thu, 19 Jun
 2025 09:31:01 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 09:31:01 +0000
Date: Thu, 19 Jun 2025 17:28:12 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <yilun.xu@intel.com>,
	<yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <aFPYLM8U7GhCKkRC@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <9b55acfa-688e-49da-9599-f35aee351e3d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b55acfa-688e-49da-9599-f35aee351e3d@intel.com>
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SN7PR11MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb99a0-b1f8-40c7-d58a-08ddaf140142
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LxVZUxfi6wVKWZ51mhvBWcq/Zc0galDUNiH/vjVCaSUCWXUna4v89KrI1wO/?=
 =?us-ascii?Q?omHzhL2qfzWE8bWrCxgc83lMg2VrfVx6+BOMOUeFp9t+HByT8O2pWANhS8bB?=
 =?us-ascii?Q?MVz+R3QSSPzoCXfQUE3D5bh0ZpghTSnzUAf/xNHeILiVY6oNSD9WI7IXirhI?=
 =?us-ascii?Q?4GH5koURAGWiG3yLRs6qb8VIec7t/k2splgoniN8R/WeA5sO+hlVBBrtZ1I+?=
 =?us-ascii?Q?Mb3+9ezJs4HRut6lQMuR1cOMFltPgtvoJ+wPLhKBAkUjko1nSP6C9gvVqnyG?=
 =?us-ascii?Q?IEAXkZM/GUTvUWmbXC6s02OATw7hzNq6hMTDjRJsiwhGg8KnOpCIIlcYXzmP?=
 =?us-ascii?Q?u5X0c+NHyhBaGqiEVE8ZGNCHIJEvEcGLcf7VOn6UuBQe1QCEs5rEDgci7JXG?=
 =?us-ascii?Q?Ap42xzk9ENOh507PVCJpWHGKaNIHMf7tdyfccqLBg7Ifui7GsvIJ6iklot7/?=
 =?us-ascii?Q?F92xuYqBeaCR+2HuRu+V8AgSsakVHqXbw2NsR86n1wUGrLrzFaKOymSioCqC?=
 =?us-ascii?Q?b4Tq7HP8hB+RsT1WWCi2qfWmwnLSMwwgOOxzhzHNQDzOrvxL6PsUpR1RQlpH?=
 =?us-ascii?Q?bgoqnEu8p66q1H04fXjoAzsDDUAxVVNM5vbhPOXC82W0bM1A7GPARSDNyZ6C?=
 =?us-ascii?Q?mkPZTU9JLygIkZTQO6N0rYrzDQ9hAJ/gf11Qgm7kPs2hBgH4SpmmXbDnw/jY?=
 =?us-ascii?Q?ivtD3c0FBHDRHV6EaIzKPO2Qdu4nJYSMXpCceMBXXCZBdT3Mcf3NGxDjiK3x?=
 =?us-ascii?Q?g2Dow/2FeEtGNHqvUXx7vt5r+Bsj2godfBy64IRTt034mtMPoaafVylZmzxj?=
 =?us-ascii?Q?C8sfgvMB+mm/qUZIgOYhvl6yiGBeG5pCs1FLHVZ5vfpHPhiqwpBFGUFsCxSu?=
 =?us-ascii?Q?pLlHTqAmudaRGq3buKHK0aWFALxBnItbvx25GLBkw53sDaVWBVOSizJOypi6?=
 =?us-ascii?Q?Vh60ZkR/qHxcQCUeszosneBdS9hGG5HwRT3mnYPRb+HJgu093oiw+HwOxTlz?=
 =?us-ascii?Q?XmTwgg1fpMMaWtTqX1p5ZR8qAMJkpTBoKbku3WrYWrJggVuVw+J75UHpHCp1?=
 =?us-ascii?Q?TYA9zgSGlsqCWxsrJuQc5wrV48vBjEQnPTIA9C0zg9nfc5NMldxUxUa1swbM?=
 =?us-ascii?Q?5JQy0saY8o2zUsUGj7XEj15StEvsilRC4R6oYqGxCgY29GJ5VqkT6dfE8M42?=
 =?us-ascii?Q?zxgZphduIdWgTFhtdnFojME4f0jgA0nhVAjapPek3KgWbjUN7ZVsFJxSSxMH?=
 =?us-ascii?Q?lTImKmuBXbkoKAc6XV6aFckCN2vy4EPzK2UWuiumlA00hl6sqTp0PHnUH/Mq?=
 =?us-ascii?Q?8OjCfQLHJSl+/+aO849LsRFhVPxfIsNswo5L3un5H66AWIOV/WrBuu7Zelb8?=
 =?us-ascii?Q?00Vc86ZMRygSQ4heolHK2fqsQc5N/3TBb6kYumpUvqpagsdVNGlV1+990JBr?=
 =?us-ascii?Q?UeLz45Jjjck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuETculvXRzfaOhylWAq0b7nLzkWDT3DftdXh5yGIZGwpn/JLCaFxa/sEIiz?=
 =?us-ascii?Q?gD94xF7bru6BezD54+feq1LA3Z+/DEF43ik0za5KH2Z4mINHgLQfA7jPG2XB?=
 =?us-ascii?Q?ZVwFMpgI9Vl8KcG+mK4ldra7+WdXqkVg7Ka2B0lWCC5Wd5dymBiwqqQEPxqs?=
 =?us-ascii?Q?07vrxpPginruuwV4t7sEp8F6KGtWZZ31xas0kfikKxpUcNTHnvs9Vyg6ij33?=
 =?us-ascii?Q?ycgh3f07kynl9ldtznlCjTN0WjMYxx1gj806wQm2xLsvZH1a2v3czZxYz1sY?=
 =?us-ascii?Q?MYH/w3ONt0890rkwqX16yOdYMfYthgtLPfFx8ws5+bFYQ+S5lNCxjEH4TFK9?=
 =?us-ascii?Q?rVlws3xLzbHgUeO8P0m0v0Waipjq5l9v4JcEoO5cDuZfbGsni5sPEqcw77m3?=
 =?us-ascii?Q?jxVxn4f5G/TaJ1aXkYPH+K8bFRYkIEfIYjLvalSyWk/L1Qc+11B/B+2t4Clm?=
 =?us-ascii?Q?9ZoYYVfoIfRuDc8YSiPpVtYwZnaS+0Ya1zSwU+eMBXKvdPzlEuDzp48v/AHm?=
 =?us-ascii?Q?Y7qg0Ysqbvz/ekjEWI//Cr33MiY5YNmdJMXSxD1piyrolyTPX30afDMfoJkD?=
 =?us-ascii?Q?D5DzfCJAt2+e7cfyLSpVfDBUyRyMSU5zYsiG/aSW3f566hfLFReHXF2a+8nd?=
 =?us-ascii?Q?4r76A/VT99A/oZSuteXr+wQXMluWAohXaoNx5dKwyNTspoFfoP7hYPdE03mV?=
 =?us-ascii?Q?sGbyovnJ/rTo4kWqoedapLuL6wl8344ZDuJi5wSG00kOffTvkdQnS/awbE1b?=
 =?us-ascii?Q?gl7kaXCOHaAysp8QtbmxtCM80S1C/7u1wxhkuVkOFbkZNK1ZGmLxLbwlix6v?=
 =?us-ascii?Q?FXr/3nfiB4eU5QvM4Ot8ukNKZQmjGRI3Q+lgRYQVcA0f+aZp3kxqF5IlNUk6?=
 =?us-ascii?Q?Ntq+Y6vfL84LRchupu0CGyvjCeFTSfjsTompRt0IN0o6hHt59FTzzl9Uy4Ed?=
 =?us-ascii?Q?4zoDIVsTjHSKVd9pl6mC4m01yO5SKOurjwM5HzBVr6ylPi1OELlcxi4PFPmg?=
 =?us-ascii?Q?m/aoH+bImhybCWoajuJDiOAhoschl+S1Uu9B3YfXniiUjK0SYxsPDfIi3+h6?=
 =?us-ascii?Q?iFjHLwl7Cv9Zxm/cZadreJzu179mJKXvvbBcM+snkyM7I8DSEBVGB0+1Q+I6?=
 =?us-ascii?Q?nk3FA881Rs1fARICRRc0Z6Sc2lJaglRkjeggzcw23VcSNFr3qH63+3+tNE/C?=
 =?us-ascii?Q?zbbhRz/IAoQmz1AVK7IRZliORQL3oOyTp6dMMIt1kdopplEW6i83D96bLNoo?=
 =?us-ascii?Q?OhcsY/hdirwOc/gNBlrnXUAMguLiyopc/pMfl2iB1MMtk0pjib8uUqteN7GD?=
 =?us-ascii?Q?3155YdfOIsJJk4g+plj7UrBEwVat4JoT8wQ+2yF8ojLj9oRL08Z6b9sdfcw6?=
 =?us-ascii?Q?cfoB4bEQoSqTMkndXIm8Wtu2dfnNCvHf75Omq/JspcgBLDHM6KxRyCjr8UFL?=
 =?us-ascii?Q?sJwDq2VRQ1C/jZKjYhyc3k4Alr/OUGePHah6TIG4L2GyAgB8c5Cf/D55dfDc?=
 =?us-ascii?Q?UGJlj2RHkkyzi6O9xqA5PP0fhDp41e3M6bGioedIv1OhcXiTRblj/QuAI7/c?=
 =?us-ascii?Q?2eM+oogZVpB5WsCrQQ+GrO94QIrbNpX1QSrK3HfE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb99a0-b1f8-40c7-d58a-08ddaf140142
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:31:01.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tZozOrcZXC4d7Dra1eZ+1HG0hVpA/BsS1ph31rau+Ey1Cu8l26jReuu9kAnrUQYxLrzAo+dh36sENG/ZcFr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7467
X-OriginatorOrg: intel.com

On Thu, Jun 19, 2025 at 05:18:44PM +0800, Xiaoyao Li wrote:
> On 6/19/2025 4:59 PM, Xiaoyao Li wrote:
> > On 6/19/2025 4:13 PM, Yan Zhao wrote:
> > > On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
> > > > Hello,
> > > > 
> > > > This patchset builds upon discussion at LPC 2024 and many guest_memfd
> > > > upstream calls to provide 1G page support for guest_memfd by taking
> > > > pages from HugeTLB.
> > > > 
> > > > This patchset is based on Linux v6.15-rc6, and requires the mmap support
> > > > for guest_memfd patchset (Thanks Fuad!) [1].
> > > > 
> > > > For ease of testing, this series is also available, stitched together,
> > > > at
> > > > https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-
> > > > support-rfc-v2
> > > Just to record a found issue -- not one that must be fixed.
> > > 
> > > In TDX, the initial memory region is added as private memory during
> > > TD's build
> > > time, with its initial content copied from source pages in shared memory.
> > > The copy operation requires simultaneous access to both shared
> > > source memory
> > > and private target memory.
> > > 
> > > Therefore, userspace cannot store the initial content in shared
> > > memory at the
> > > mmap-ed VA of a guest_memfd that performs in-place conversion
> > > between shared and
> > > private memory. This is because the guest_memfd will first unmap a
> > > PFN in shared
> > > page tables and then check for any extra refcount held for the
> > > shared PFN before
> > > converting it to private.
> > 
> > I have an idea.
> > 
> > If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
> > conversion unmap the PFN in shared page tables while keeping the content
> > of the page unchanged, right?
However, whenever there's a GUP in TDX to get the source page, there will be an
extra page refcount.

> > So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory
> > actually for non-CoCo case actually, that userspace first mmap() it and
> > ensure it's shared and writes the initial content to it, after it
> > userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.
The conversion request here will be declined therefore.


> > For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
> > wants the private memory to be initialized with initial content, and
> > just do in-place TDH.PAGE.ADD in the hook.
> 
> And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space to
> explicitly request that the page range is converted to private and the
> content needs to be retained. So that TDX can identify which case needs to
> call in-place TDH.PAGE.ADD.
> 

