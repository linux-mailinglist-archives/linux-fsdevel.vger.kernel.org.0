Return-Path: <linux-fsdevel+bounces-49295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A34ABA378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4686550720C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687F27FB35;
	Fri, 16 May 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffSu0oPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DF1C3C14;
	Fri, 16 May 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422906; cv=fail; b=lpnN/f06e3qBAWkfjUiO68PPh9P2fV9C7ceWgjfx14eQ+Zd1fOgneMS2rC4qOv42oeV1ChJOeSjpSn/eWarZzky64mFeMbX/JMaLI9fgoHAgAJDLVFpaCqq/mPxwbk/8RqnjZNZ7RdNU0upSBG4/drElv+tI+edP1mfkCZ1KcjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422906; c=relaxed/simple;
	bh=DVM/BUhIxWZAAFkRZrX6v8W1S04WQ/JEMexmxxwQfEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/hfNbvVzasy7w1F97hgtgRM2h1xQfJO7ilXzkl3ed/jaHv09ctXP9oNB1VoazysIgw3GzcUK0BXshlQ0Gx3ViK/N7R/T22jCB+S3dG3XrV2vJvswBAzSgu/EYe3A5l46YfgP/W6ZVPJ1Vxtb3rJSIpUbDc/6GXdSvjjYICMpC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffSu0oPa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747422904; x=1778958904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DVM/BUhIxWZAAFkRZrX6v8W1S04WQ/JEMexmxxwQfEo=;
  b=ffSu0oPaWAnV3FtSlF3/sZJQG3lCHS18bK3Z1B08LbvO++lVemsWHAEe
   6LGxDUauVhZGLyHXz5ytikQ/iMLEcbI8SDgImbRnICePFpVrsLzbcsf3e
   tv9SzA10Z84m29kW+e/Uw+TMoBqXO+YNUP0Ga67G6hKba90R75bAgI218
   /V3FqSKM5/JcwV21l2wySgS8yiRwiwr9ge3lPmAr5/YCxSMpTyfAShQdt
   cG+Py8DembdvqPqKthzxZkVM3dwlaHpqVbOvswctYmAiNEVL+j6eU6UTN
   jFbmpB3MKfIjbvXczV5wslUkuscVcXys0dsd1bV6rcU/Bu5jFRejBgyvO
   w==;
X-CSE-ConnectionGUID: KqXZ71AlRnK84CeVHDFrxg==
X-CSE-MsgGUID: plQgoNLsQnSu6wmzkhz0EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="48660166"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="48660166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:15:01 -0700
X-CSE-ConnectionGUID: BeM33mQkQ9+YmA3ZObL8KA==
X-CSE-MsgGUID: pFC89eJSTAmUigeOY1el0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138832186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:14:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 12:14:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 12:14:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 12:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drFUh8CP8f19SKi5UdGI8wfbzekKSFkER/OAi4MeDm2yDad9Vs6oovqBHOO371IU22uJKwJA9qjcKXheSpqrM7f1wfciKrPFNAm6tnZ9ahryBph9ePPoq9nBRE5NoEA0FflJKLYLznQIq/PAWtNTkiF8jETaxsTeYFvQPwO+SK7XluHGEh6rH7b/XDYEeRgXzom9isbk+EL8yb1qb1dl3K4mzANGrzcB+nUFRzemfCC/qoWf6CPA1s8bbpPEIRE4agD+iWJ89AYoIcyaCpF+LYTtcDpqMCnEbRD+Qh+9Ea1kl4CEmvb0q3s7k3cIqqJOrXNLJKWlrsb4p1rQ+Evbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVM/BUhIxWZAAFkRZrX6v8W1S04WQ/JEMexmxxwQfEo=;
 b=OailfHjHGP9V3D8P6ufLkWbvOuJX58O8ayoEwyVv9LeW04CF64hwOs6r0uJip/cZx7wBZ8G3SwVG/7PJFMsxZ1kdwwzsJViKuoCiSf8s1JudfimYJ8rI/LMfcszF86RV21uVEXLLeD4NOhQ3xPi9UqrXWbUNy1vCLyWQzMviQUYZzGOlPNADXnm8k0hqhsMLZcjnz/JHV2J2mwp1bCZFzXvYLHTloW6fmDs4zvo82CPX0zhtkPX20y58MzlmYYhrxDJZ/S92eVz+EVe+IwQ1vIh+6Uo8yk6ZpEIVgenzB0fx7gtZfoyhjDp4gnhVh8+v2yF48RVK9W+9mIv4D2KV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:14:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Fri, 16 May 2025
 19:14:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "tabba@google.com"
	<tabba@google.com>, "quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "Annapurve,
 Vishal" <vannapurve@google.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"keirf@google.com" <keirf@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com"
	<aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>,
	"fvdl@google.com" <fvdl@google.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>,
	"willy@infradead.org" <willy@infradead.org>, "Du, Fan" <fan.du@intel.com>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mic@digikod.net" <mic@digikod.net>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"hughd@google.com" <hughd@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "anup@brainfault.org"
	<anup@brainfault.org>, "maz@kernel.org" <maz@kernel.org>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com"
	<pankaj.gupta@amd.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "Graf, Alexander" <graf@amazon.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "qperret@google.com" <qperret@google.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>,
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk"
	<roypat@amazon.co.uk>, "will@kernel.org" <will@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKAgAAK44CAAFGtgIAAFymAgAAUsICAALhjAIAAO8yAgAASaACAABcrgA==
Date: Fri, 16 May 2025 19:14:46 +0000
Message-ID: <8e783fa6ee3997567c661e5c10b05b5d456382fb.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
	 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
	 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
	 <aCaM7LS7Z0L3FoC8@google.com>
	 <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
	 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
	 <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
	 <aCd5wZ_Tp863I6pP@google.com>
In-Reply-To: <aCd5wZ_Tp863I6pP@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 54de5a12-2060-4709-7e4f-08dd94adebeb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFVzQk84WVJTV21PVnc0WUNLRWVnMElObTFMeWthdnIydG8wY0VKQ1NPQmxV?=
 =?utf-8?B?aU9kcXlRbHNxRGhsbGJVWCs2VjNtMmxGbFloMUJlQnE2UTVuZlNzN0lWYmdV?=
 =?utf-8?B?ZkFNVlRFd1cybVBKM1MvWjBLdHo3YWhXbmsrdVdQaENCQ3h1YmRRQklqY2tU?=
 =?utf-8?B?WjVlY3QzMFR0VHJXM3B5MExoQk1Dby8wN3NPTkU2Tk1RalFqZWxkVVhPSVlq?=
 =?utf-8?B?UUJOUUtqcXo2K0NJL1p2a29DeDF0M0xPWDRDM1Y2SjAyWldZdVp2WHZyNUwy?=
 =?utf-8?B?dzNxMm5sSlVuTnJVQjk5YS9KTUJZb09CN3dDZU1WUjJsZkNPTFZtRHVCTnNO?=
 =?utf-8?B?enYra296bDhoNnFZRTNZd1E1NkJ0SlQxN2hlRFRRdnNsRWNyWFNpZUo1MlRw?=
 =?utf-8?B?cS9CKzFnUnRMYU9QbnVsUVJqUkZoZ0R0VURUL3FVQzhnSFdYY2MxNkkzc3NY?=
 =?utf-8?B?bm9UNEdYc0JSMzkyOFlaenpiNSt3Z2xlVzBJankraWdmdDFVM1IvcHJPQ2Za?=
 =?utf-8?B?TzhmdTd4QXFGMHdjMHc1UzFkZ0l5NUFuaXh2M1VQMHdKeWFqajJONjdBOHdG?=
 =?utf-8?B?L1V1ZitlaHZUZ1F6aGtqRzlPUStFNFNZM2pueDdGcGFFa083Vk1TVytBL0tN?=
 =?utf-8?B?SjNsSkhqSFAvOXdlUVVtM0VNL0h4SXJaaHBXOFJLRU1UN2JnSk4xSzlFbXla?=
 =?utf-8?B?anh3Ui9KQzlzbmtrTDd6VnhPZC9EY0QxaDBMZzdVbTFRNnN2RWFVaDArdTl5?=
 =?utf-8?B?Q3FKVE52L296eTZEdkEwU2pqTDBCMVdiMjErNVlVekdCQ01scmw5aEtkaGs0?=
 =?utf-8?B?RTR5S3dWZGtPM0d2YjRqQVVNL3A5dmdWVXJiRGhZeWRNa3VhR1FvaVJWQkJG?=
 =?utf-8?B?RlFaRFNWa1pqR0FPZTY3bkExR0hkUmhhQ3dRRFBheDBveU05VUVOQU9BOFFC?=
 =?utf-8?B?OG8waTl1dXdrdnc0VmNjWXpjYUMvZ1NsSHMwOGFWYmg1M3h2MVZqeWVucDJE?=
 =?utf-8?B?d1g5Y3N4RFZ2TXIxekUyUnNVek81Q3ltTy8xT2JlZU5wZnNESG1xUWtzY1d4?=
 =?utf-8?B?S2NkVkxyeVlkYXI5OGFPc3BRVkduem1CRzNvdlFoQ0VCOHdGWFBpNmFLTmUv?=
 =?utf-8?B?S2l2bStIaVR1bUp3dXZRNFZPcFZRcDB6NXFETWpJdHZvSHZQQ2pBQVBkN1VK?=
 =?utf-8?B?ZE94SFNUTTNGUyszNmczenhDeW81ZGVJTm05R3g4aFN0QnlMNXB4OW9WMzBT?=
 =?utf-8?B?OUhvQzRSS0xYc245VTlQV2RCU2syVkVndUlOb01pcEdSZzZSeEJtSFB3cXB0?=
 =?utf-8?B?OHhiWkQ1ais1RFF3c2RaWldYL1krME8vRE9IQTI5ZmttZTZQck01anhINGhp?=
 =?utf-8?B?RkhVeDJHM2hDMmlNL1JRdUtCTzhSbVBsUmd0cUJ2VnFaSGJlU2k4U1JIVFN3?=
 =?utf-8?B?K3ZvOFg1MElkb1JQM2NxYmgwOEhNTk44d0doZUVWUEJSOHU5alBCdGVDWlVX?=
 =?utf-8?B?QlM5cmhVQWszeDcrMFBEU3FnM0tEY0cvVVFreXRVcVNabng0MWdjY3pFLy81?=
 =?utf-8?B?NEV4M1hYaXphUEpqWU1TUzVqb0VNVFJ6Wk11ZGgzRzdtLzNVWUJhOFBQVmhr?=
 =?utf-8?B?VXF4TXI5VHRnWnM5MjlXN2pkZzFyc2hJQWNvbHkycSt3cytBRGVlYXpSMjkz?=
 =?utf-8?B?aXhGTGw1eGJwYzhIbFJzOTRYZ0ZrQzRDbXNkcTNNODVMVWV5NUs1MVNQMEND?=
 =?utf-8?B?My92bVEzWm85RXRSdU1lOTUzeE4rN3Q1WW50NGZUdkZXOWJPQzVJRDZvbzFK?=
 =?utf-8?B?ejBzcVB1czd3OVQrVVl1UUxlWUgvSkEyMWZNZHlLVWZIR1Q4aUtSa0lnU1pu?=
 =?utf-8?B?OWN0bGJITXllTkt3T1dueE1qd0M0cXBvVkdMN0hXVktkTGd5bXdDMzR2ZW1k?=
 =?utf-8?B?SG5kS29KWGQ1VFdhRnRBUlR5ek52TnNRamk3N2lPQS9YRlZ5RzQrVlBkWnJj?=
 =?utf-8?B?WkdLV0hVMGFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SURDVGo5YWtXdFBLY3hDUGdtSnRva1VxbTdaQ29OOVh2S3E3RlJHN1loMDZt?=
 =?utf-8?B?TFlsN003QzBidEhLV3h5QXRZWlY4VEtzZXdaYjNEeFg5WlNoOXllai9vZ2d0?=
 =?utf-8?B?cE9FNDkvNmNsZWEzbkNpd1Vwak1tbmxFeUtWbkp5cTh0QzNGYkRsYm9VWHl2?=
 =?utf-8?B?aGhoanp5ck5MNzg1Nm5rZEZ1S3U4WnJHbEM5VGFZZFBRR29RUittbzczdlY0?=
 =?utf-8?B?UHRUOHo0TnFUUDk2U1pqeE1OTEl6ZkZwUU4xMW8zb29wenhsWm54ZTdhaW1z?=
 =?utf-8?B?RjhkR1ZVZEk1MjNYTVJHZmhMWHZRaU91eUdhM1ZsdE5Wa3NUSmFGVEZvelRB?=
 =?utf-8?B?TUdUN0g5SHVDKy8xZEtRZGswdGJWSWxsMEx3dUQ5VmM2ME9tbzNOdVNXbm1z?=
 =?utf-8?B?eW04Y1lURmMrY282UUFFM2g0QWFVUHE0K3RYQXNFcytxMWF3RGdscldrK0l2?=
 =?utf-8?B?OHR4WEI5WHN3WEcxM2RNRCt4U0pvZzVGSFhvYWV2M1ljNjFzWkVDRUl1Zmho?=
 =?utf-8?B?dnNxQ1FzVEdZenp1Q2pISzFTeVZTeGpqdThLRG5HVFBZd2wxY1dtei9jQnJs?=
 =?utf-8?B?K0hEU2xSOWxmSzhtaVlnblFUcUYvZ2F0M05RcnNsZ2lINjZHSVJRa0pCd0xD?=
 =?utf-8?B?Q2RLSWtkMTdSdmE3aFRKeXFITUxHb1lacUJJMmtrVXVqVWdwKzd0OGpxN3Z5?=
 =?utf-8?B?ZWwxZVgzQ2duMmxXbFhlbUlCR1Z6U2pTSDYrK1JnYW9xQ3Yxc1RnWkRzemx4?=
 =?utf-8?B?a1J2Wm56SFhHQVBVNlJTODg0UTNvNk5ZMHlxRjdUa1RuMlJaSFRFcFZ6Rm5F?=
 =?utf-8?B?eFdyQnhyRTlJM0k5YzM3QlBsNFo1MEhpNGRZRWZIWVdFRXhhamsyQlNYMHNR?=
 =?utf-8?B?dmZTM2g3YW9PMTVnNE12NUluZTRyQ2lnV2tEczJjWTJKOVlRcG9yTUVGSjVx?=
 =?utf-8?B?UC9rL2xXZEd1SnlTalh6dDVHNVdZMCtQQ0tnVFFiaWhnclVpbTVzQWxXa0g5?=
 =?utf-8?B?bG55S25IdmxvdEJ1SE9MS1pnRzllOEdBTTU5MGNodTVQT3ZkZXRZYWZhUzd0?=
 =?utf-8?B?T3Q3SWRqRlhIOWh4NjdkL2JqMlpTd2ZVaGdoeDJIK1ZZd1RCa002WmJsM0d0?=
 =?utf-8?B?OVJXblh0SWpPQ2xPWVBuOVhjSThZd1JrL2JRMjNwd2VTS3hHbFdMcXovbHhB?=
 =?utf-8?B?RFNSWmkzRGxJMWt3RW94dHlubDRqZWhSbjUxNzhIWW95WGp1RzBZWCs5L2p6?=
 =?utf-8?B?eEFpdStwVzVtSGtkNEJNYjFQbG1BalNQUWszR0tRNXlKQnhxNTZwTXhtTGxI?=
 =?utf-8?B?LzNubjBnME9IeGRqNzdZTjV5MEh3SVpFMXQvZWl2ODd3Ykt6eTA5SkxBUmFR?=
 =?utf-8?B?RDBMUHAvRzF6NnJBQ2tSWmhranA1MUFrbXFMSHgyTWhLcXJ3dW56NlRXR3Fz?=
 =?utf-8?B?SzJyREFqenk1Y3ZpUG9JcVJsZlpHTnllNWFmOU1BMGJDb3E3RlVVNGowK3dL?=
 =?utf-8?B?YVNLbElpOTltcEs1My9ha3FJNTJCM1dzT3hSSG1pd1RGcEJtQzlqVTRKOU1X?=
 =?utf-8?B?VnZoN1RxcWlKeWtPK0F2TG9ONUQ0SmJJQ0J4UmJVSHREcjZVNjh5bDhwakNq?=
 =?utf-8?B?UmpoWE41ZW9Va0F2U0J4UFI5UkF6YWJ3Q2NyZndoSE9ZNDVocU4wSjRpaVZh?=
 =?utf-8?B?V1daZnJiR0kvdkw4SW1xSlBLMmVxL1BLTjRwRm1nRXZPNFdTbzk2V2JGNVlT?=
 =?utf-8?B?OWJCTDNPbnlKMWJGMmk3aXBjTTNHOTR2eTFadmpwYW5telRCRXU5Wk5aWUlO?=
 =?utf-8?B?NmtXY0dJM202ZG9OWndnbTZBbS8zQ3djZnoyOGJaenZrYmpUZTJGa2Vkdyts?=
 =?utf-8?B?c0wwUEJtVTBraDJFOW9zam9BNi9nY0pEbS93QVdGRDFVakM3cFZYZXUrNVNI?=
 =?utf-8?B?M3pEZk9wMjNJNjd6R3JzOUJCd08yd2ZaTXYvU2R3Qm54c1puTEJPNU11U0JW?=
 =?utf-8?B?aStES3ZFYWkrK1NjVkRZdmlGTGg1SXJoU1BTUmJyZDBITjJxcE40S1VxeUhW?=
 =?utf-8?B?ZWVzSVMzYk0vZGp4STc2VEE5VjBHVzgzSytveVhJZU1iMU1SVmpLbnBXeXRX?=
 =?utf-8?B?ZjhyanlCQWVSNVhkQURCcEd6cnBiblNkV2o0VDByV0NUeFRQdi80azVrL3Az?=
 =?utf-8?Q?rfAIge550ym3pluVfJZDYsM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75A0492B5CF0A34D86E58B1E07A0DF9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54de5a12-2060-4709-7e4f-08dd94adebeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 19:14:46.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7ISE3M6iHxG/+jr38LimHsEpxOCObsQBUYGwQOQmNvaIxvicralPNTRdMVwT54vl3+OCd62IUK0upBTUaEwq7apueJtpZK1DUGVTKsot/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA1LTE2IGF0IDEwOjUxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBGcm9tIG15IHBlcnNwZWN0aXZlLCAxR2lCIGh1Z2VwYWdlIHN1cHBvcnQgaW4gZ3Vl
c3RfbWVtZmQgaXNuJ3QgYWJvdXQgaW1wcm92aW5nDQo+IENvQ28gcGVyZm9ybWFuY2UsIGl0J3Mg
YWJvdXQgYWNoaWV2aW5nIGZlYXR1cmUgcGFyaXR5IG9uIGd1ZXN0X21lbWZkIHdpdGggcmVzcGVj
dA0KPiB0byBleGlzdGluZyBiYWNraW5nIHN0b3JlcyBzbyB0aGF0IGl0J3MgcG9zc2libGUgdG8g
dXNlIGd1ZXN0X21lbWZkIHRvIGJhY2sgYWxsDQo+IFZNIHNoYXBlcyBpbiBhIGZsZWV0Lg0KPiAN
Cj4gTGV0J3MgYXNzdW1lIHRoZXJlIGlzIHNpZ25pZmljYW50IHZhbHVlIGluIGJhY2tpbmcgbm9u
LUNvQ28gVk1zIHdpdGggMUdpQiBwYWdlcywNCj4gdW5sZXNzIHlvdSB3YW50IHRvIHJlLWxpdGln
YXRlIHRoZSBleGlzdGVuY2Ugb2YgMUdpQiBzdXBwb3J0IGluIEh1Z2VUTEJGUy4NCg0KSSBkaWRu
J3QgZXhwZWN0IHRvIGdvIGluIHRoYXQgZGlyZWN0aW9uIHdoZW4gSSBmaXJzdCBhc2tlZC4gQnV0
IGV2ZXJ5b25lIHNheXMNCmh1Z2UsIGJ1dCBubyBvbmUga25vd3MgdGhlIG51bWJlcnMuIEl0IGNh
biBiZSBhIHNpZ24gb2YgdGhpbmdzLg0KDQpNZWFud2hpbGUgSSdtIHdhdGNoaW5nIHBhdGNoZXMg
dG8gbWFrZSA1IGxldmVsIHBhZ2luZyB3YWxrcyB1bmNvbmRpdGlvbmFsIGZseSBieQ0KYmVjYXVz
ZSBwZW9wbGUgY291bGRuJ3QgZmluZCBhIGNvc3QgdG8gdGhlIGV4dHJhIGxldmVsIG9mIHdhbGsu
IFNvIHJlLWxpdGlnYXRlLA0Kbm8uIEJ1dCBJJ2xsIHByb2JhYmx5IHJlbWFpbiBxdWlldGx5IHN1
c3BpY2lvdXMgb2YgdGhlIGV4YWN0IGNvc3QvdmFsdWUuIEF0DQpsZWFzdCBvbiB0aGUgQ1BVIHNp
ZGUsIEkgdG90YWxseSBtaXNzZWQgdGhlIElPVExCIHNpZGUgYXQgZmlyc3QsIHNvcnJ5Lg0KDQo+
IA0KPiBJZiB3ZSBhc3N1bWUgMUdpQiBzdXBwb3J0IGlzIG1hbmRhdG9yeSBmb3Igbm9uLUNvQ28g
Vk1zLCB0aGVuIGl0IGJlY29tZXMgbWFuZGF0b3J5DQo+IGZvciBDb0NvIFZNcyBhcyB3ZWxsLCBi
ZWNhdXNlIGl0J3MgdGhlIG9ubHkgcmVhbGlzdGljIHdheSB0byBydW4gQ29DbyBWTXMgYW5kDQo+
IG5vbi1Db0NvIFZNcyBvbiBhIHNpbmdsZSBob3N0LsKgIE1peGluZyAxR2lCIEh1Z2VUTEJGUyB3
aXRoIGFueSBvdGhlciBiYWNraW5nIHN0b3JlDQo+IGZvciBWTXMgc2ltcGx5IGlzbid0IHRlbmFi
bGUgZHVlIHRvIHRoZSBuYXR1cmUgb2YgMUdpQiBhbGxvY2F0aW9ucy7CoCBFLmcuIGdyYWJiaW5n
DQo+IHN1Yi0xR2lCIGNodW5rcyBvZiBtZW1vcnkgZm9yIENvQ28gVk1zIHF1aWNrbHkgZnJhZ21l
bnRzIG1lbW9yeSB0byB0aGUgcG9pbnQgd2hlcmUNCj4gSHVnZVRMQkZTIGNhbid0IGFsbG9jYXRl
IG1lbW9yeSBmb3Igbm9uLUNvQ28gVk1zLg0KDQpJdCBtYWtlcyBzZW5zZSB0aGF0IHRoZXJlIHdv
dWxkIGJlIGEgZGlmZmVyZW5jZSBpbiBob3cgbWFueSBodWdlIHBhZ2VzIHRoZSBub24tDQpjb2Nv
IGd1ZXN0cyB3b3VsZCBnZXQuIFdoZXJlIEkgc3RhcnQgdG8gbG9zZSB5b3UgaXMgd2hlbiB5b3Ug
Z3V5cyB0YWxrIGFib3V0DQoibWFuZGF0b3J5IiBvciBzaW1pbGFyLsKgSWYgeW91IHdhbnQgdXBz
dHJlYW0gcmV2aWV3LCBpdCB3b3VsZCBoZWxwIHRvIGhhdmUgbW9yZQ0KbnVtYmVycyBvbiB0aGUg
IndoeSIgcXVlc3Rpb24uIEF0IGxlYXN0IGZvciB1cyBmb2xrcyBvdXRzaWRlIHRoZSBoeXBlcnNj
YWxhcnMNCndoZXJlIHN1Y2ggdGhpbmdzIGFyZSBub3QgYXMgb2J2aW91cy4NCg0KPiANCj4gVGVh
Y2hpbmcgSHVnZVRMQkZTIHRvIHBsYXkgbmljZSB3aXRoIFREWCBhbmQgU05QIGlzbid0IGhhcHBl
bmluZywgd2hpY2ggbGVhdmVzDQo+IGFkZGluZyAxR2lCIHN1cHBvcnQgdG8gZ3Vlc3RfbWVtZmQg
YXMgdGhlIG9ubHkgd2F5IGZvcndhcmQuDQo+IA0KPiBBbnkgYm9vc3QgdG8gVERYIChvciBTTlAp
IHBlcmZvcm1hbmNlIGlzIHB1cmVseSBhIGJvbnVzLg0KDQpNb3N0IG9mIHRoZSBidWxsZXRzIGlu
IHRoZSB0YWxrIHdlcmUgYWJvdXQgbWFwcGluZyBzaXplcyBBRkFJQ1QsIHNvIHRoaXMgaXMgdGhl
DQpraW5kIG9mIHJlYXNvbmluZyBJIHdhcyBob3BpbmcgZm9yLiBUaGFua3MgZm9yIGVsYWJvcmF0
aW5nIG9uIGl0LCBldmVuIHRob3VnaA0Kc3RpbGwgbm8gb25lIGhhcyBhbnkgbnVtYmVycyBiZXNp
ZGVzIHRoZSB2bWVtbWFwIHNhdmluZ3MuDQoNCg0K

