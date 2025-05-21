Return-Path: <linux-fsdevel+bounces-49588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F119ABFB73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA811BC1FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C5222CBEC;
	Wed, 21 May 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="il9B+ayl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C431186294;
	Wed, 21 May 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845730; cv=fail; b=a+SixRJstS16atIt2gQM7gr6OIPA+swH1ULsfO1fyOpug0slotkOm27d6+dCYM0Ao17VPVu2RwJnazgdkblGGEHvJZJKvSiYKMWqrrlUCNfUzsJqTyGxOdt3E8h4SNec7LB8ISsbIAwqL2Spnpf8lJd1GcnNxFN0jC8+HvdTJJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845730; c=relaxed/simple;
	bh=dyVeL+zNm8GoUMqyuHhXD841gtkI98CaAEO1DOCAZXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNQStqm66KpLurZc+eokGR162y7rsHmbY+hqjcdobgLFKgiuT05mBInquRfpWJakzjwg6FRPZ8fz4xcinJSLoeWFS/sXPdkH1643iN3ixvMIZTvbDUEOYjUO2eCwn9ve2L/N7qdvioK+nhVZA49w+VR78EP5DSZPAfXSEczETgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=il9B+ayl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747845729; x=1779381729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dyVeL+zNm8GoUMqyuHhXD841gtkI98CaAEO1DOCAZXY=;
  b=il9B+ayldawceAb/eVCCJSb5vltfxNulVO0UPlAiIZeYQzyvnTWcr1ka
   D+lZarr9bBPeBefLMdXVNGLsCC1QcT2tZoScFGq9juA2wIwOwxvVfKUjJ
   ZFv/QuGVkjaN215/Wxz/l06MNGOGlFh3uk7W973yv6tfXJg54EQL3rmCa
   bw68S/TdudlKSc+ny0qXSBCj6Ak2Vdov6spc8z7I4mmbmTuGQVfyQV1Qn
   qArwDxlanC1bH9uEI9MW1zCE7y+w7/oVWJkL+lo73tRgG1xpItqGcUsTD
   tXUdvnKm6IS2PYq2lTz7ecoBC3AffghFs0Xlbun6657XJ7/RMqwrPkyjw
   Q==;
X-CSE-ConnectionGUID: qz3O8rwmQ0mDeHCHzVUdFQ==
X-CSE-MsgGUID: 2CcZxc2OTPaaQwqva25tZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49540312"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49540312"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 09:41:11 -0700
X-CSE-ConnectionGUID: 3+IYOxw2QxeSYAHaRZjfXw==
X-CSE-MsgGUID: 40oeKSewSky2TCCXPh9FIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="139996540"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 09:41:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 09:41:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 09:41:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 09:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV9aD+W5AyFmjoBHZ05jIexa0vsIeXjwOdf9rP8Msbp5v+M/tTJWSV1VjSyUZcgDExZLqOAxTdm7eNxwTc4sd3h61BjK2BVCtbGNfJtjnD937LmU/TxgFKcYfFU94RrZldpOKrj7PC6FlJuZHIZorEtcQ+WSayLVTNGb+cJEuqTU9LLv2JBrm9DbNypIL33k0fB+UYrRe+Cm5DGbWCoqJ6ynMOV2MawR1LO2rSqHac4n5RKncv6fvh6/RiTtkMVEXSNL/WJyGY99NGk0a3MSx6F4+jFIzQUSE1CsS3HgHv+yBzc2zdeDHTyiMuwhoLFM/QYoexNHZSwGvqWYFMbqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyVeL+zNm8GoUMqyuHhXD841gtkI98CaAEO1DOCAZXY=;
 b=DisCj75c0Wde9EcrG1sSVMlp9VKZVqZ9NOfUSQbOyRlYvG7tdje7pU6W3n9eDYgzGRvGkgDgfwTIkzP3xFTcwCxqMEKcoaiAh+Uy+KnOJ6emxBfxeHNDj3b4Ixgh8c4lTXBfmYqQm7WgQZ6iR0JIuFRIzdtMBpq8pkgZS44JRm4JB9pW98N+D80+NQ4M55OHROBA3kTzUbpv3nay5nkDIkEOP4KbZ00r7CAqICS5xpRxUHj+rfnka0Z3/W1dN/XoBMqT+jB3XUNRULIDD/T9ju3Udn4bPNwHaRO1j5ZndcPryCOiX9iw8QMuUzJtUpfKrJ0NVQrOXcSWxpAuAtUKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA3PR11MB9398.namprd11.prod.outlook.com (2603:10b6:208:576::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 16:40:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:40:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Miao,
 Jun" <jun.miao@intel.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com"
	<steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "jack@suse.cz" <jack@suse.cz>,
	"amoorthy@google.com" <amoorthy@google.com>, "maz@kernel.org"
	<maz@kernel.org>, "keirf@google.com" <keirf@google.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "Du, Fan" <fan.du@intel.com>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "anup@brainfault.org"
	<anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas,
 Erdem" <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "Annapurve, Vishal" <vannapurve@google.com>,
	"Xu, Haibo1" <haibo1.xu@intel.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "will@kernel.org"
	<will@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
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
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "seanjc@google.com"
	<seanjc@google.com>
Subject: Re: [RFC PATCH v2 36/51] mm: Convert split_folio() macro to function
Thread-Topic: [RFC PATCH v2 36/51] mm: Convert split_folio() macro to function
Thread-Index: AQHbxSoUbUZ2okt7Ck65U0VAZZLk+7PdU+0A
Date: Wed, 21 May 2025 16:40:58 +0000
Message-ID: <63839c7b49a97174fa58e3f44d148cf88d6ece9b.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <28d1e564df1b9774611563146afa7da91cdd4dc0.1747264138.git.ackerleytng@google.com>
In-Reply-To: <28d1e564df1b9774611563146afa7da91cdd4dc0.1747264138.git.ackerleytng@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA3PR11MB9398:EE_
x-ms-office365-filtering-correlation-id: 021339ea-069a-41fb-7de8-08dd98864404
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGVLbVlYb04vUnRhaVBUWm1hTjZ0MXRzUmlNb0IvczB6K2k3T3QzekhXZ29E?=
 =?utf-8?B?WW54RGRLeTZwTWVVbXRIWFRlOEZkQUtvMmZOU2dDcXJDdkZpdWpiVzhkWFNn?=
 =?utf-8?B?QzdlYXJTR1ZDc3UxdjFMWnMwVXJqOCtiMzYvVG1CVVNYZk9kMkNVMVdkYWt6?=
 =?utf-8?B?RGE4RzlpTW5kcXNybGdtSDZIbmF6MzNhOUlMbzVqUUc3L1E3emxVK2N5Y1Z3?=
 =?utf-8?B?VVZWczFUMjNoK1crZ3B0cjVtR3QvWUhwQzl6Y0FxVVBtcXkyVWFPVEdscjlp?=
 =?utf-8?B?b3BteTlnUmR6cnhmUnJCWWUwbmRKeEhUYmg1ZXFyckxZTTBrdnNOdTJpdGhJ?=
 =?utf-8?B?aXFqNGdpVUpjYXBhZDdORXJsTGJLd0FsblhVS2ZpanZxdW0rbHRuTEplb09E?=
 =?utf-8?B?VmFPakN0c0prZHZha2FHcUs2WC9GR0xyL2ZWOXVEc09nZDFEeFlES1hxRTFx?=
 =?utf-8?B?RGpjcmdDejZ1eVJHN1Q5L0pIcFdRYmZya05ObkhYTmJpcEN1dUhZa0hlbXVY?=
 =?utf-8?B?S3ZydjZNUzJtdkFWYmNxenhiK3VSREVPN29SOC83eVFON1RSdXd2anExSDAz?=
 =?utf-8?B?NVE4R1FPYXVNeGgzQTdDUU1yS211QUV3aFl5Ym5rYmhZWjJUeGpsR1Z0aVdH?=
 =?utf-8?B?bTRLd0ZQb3ZjelVhSWZiOTZhd2p0K29qSzQ0NVl0eWFDbE00QktlVEFuM3p1?=
 =?utf-8?B?Q0ZKVlZsL2NNMGozYnkwakJadWJZRWpwYXJpT3RVUktvR0hNOHZESm10d2R4?=
 =?utf-8?B?VFVCTzNqK1pnQVY2U25Fd0htSi91ZlV3czNGaHZSSG0xRDBqY1A4ZDhkckMv?=
 =?utf-8?B?ZVpBR3dWRjZZbVVOTkpsb1M0aVNXVDFXWlBZUWhsWUYvU3pER0FTaVFtV1Fk?=
 =?utf-8?B?NWlqR0hXTmgzcmhjK2RFc0xrTUJJS3VDSTUyVnBjOTFwMTlMd3U0cUJTdzJI?=
 =?utf-8?B?WjVkUVY0N2VPMUpTR21lWVQydVNySnhkTHByOVN5QnVRRjFRamtVdEt0cnFr?=
 =?utf-8?B?Sjc0ZGxKKzBwVDVSMzlhaEtKY1VDUkc2RTlVZXBUNXh2TmxQZjN1ZkpOZWM5?=
 =?utf-8?B?TVdmdVV6ZTVsL2dmN2JFdVluaXhsb0N3cDVzd3dKdTdXb3hCQW82WTl6T0hY?=
 =?utf-8?B?allhbXYwOVhVYUpyaVB0YjhBeWM0UktDZTJtM0RWSWVWNTZybk9pOWRVVkQr?=
 =?utf-8?B?WmxCNzFVeWJMRmhrWE52MUd3V3F6Uy9WbEtxekltN3FyMi9GcHBiUSszYWNO?=
 =?utf-8?B?NHZzQnBvVmRoK2paRjJ0Uzh0eHFFa3dNU0tYQjYzMCt4RFFOd1NDZHhPdnkz?=
 =?utf-8?B?MnNYRmhaU1JjSWdDa203NE5RUys1UlZPOTROSkU2UkFIS1BRdWlYV25QMGNr?=
 =?utf-8?B?OUVOZ1NLakVwVDBWL21oUTRRSnoyd2VORVNNbXJVVVU0ZWxSV2tUd2RaYkR0?=
 =?utf-8?B?T25LQ0ZQeXVZQk5ja2dVbm5BckNGOXZ5dXZKTy9PdTRIMGpmNFVGcHpZcWpr?=
 =?utf-8?B?M1l1NHh4YjFxUFo0dDJSdFgwZk9jc05lZnl2OHY3TEZPZTR2b2drYnYrNEkz?=
 =?utf-8?B?aUxkZWlIdWVTMURscHdzUmg0VkZncWp2eDEvYXcycXVvejRtT2dNMVdqOHBr?=
 =?utf-8?B?UHhNVGorb1EvVk13bGNhMVdTc2NGZVFseFVkeUZzeXVXdXRCZCtRSmhLTzRm?=
 =?utf-8?B?dlNXZkRFWjBBN1l1bHZkUlh3Tm93YjVVQVJpNktUenVob0h6RTZyWTh5RHUz?=
 =?utf-8?B?c2kybjB1QlloVGFMRU1abGpaVkNzTzB6Mm9qR0dvbjFoQWcxcE9WdURkbTBY?=
 =?utf-8?B?UzROZWE1bDRvYUlicWhoQWdvazFER2VDWmY3L1RpSDIybGZJL1Yrdk9JYXZl?=
 =?utf-8?B?bHkzYlYyNTQvcGx1TWlqbWpycGpTRVh4U3k2TldDenF6a2toektEb1hrNGRm?=
 =?utf-8?B?NUNteU1iV3lsTWZuSUZlS05aanJnV3RVYk5zenFUdEFxdm9UK0l3b05CMm5h?=
 =?utf-8?B?YUJWWWxTV1V3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlFkZTFtRlZWU29NWWg5ZGhnL1k3eDBMR1VCZTc3cUFaZlBxR3F2aHZFdzVV?=
 =?utf-8?B?K3lPR3BIdlpFMlZyK2hIdTQ4b2h0V3h2QkV2U3NmY2c1SmZ2V1dOMHQ2L2tH?=
 =?utf-8?B?S1hnSG1oQzNvQXVXdVNOYXhJTFJhM1NtUXh4ZjVYVXVKdHpEelczRmVsQUR4?=
 =?utf-8?B?NjM0ZzI4eGtQL1E2ZVdCVVVKQy93SGhNZGpDZnJvczJ0ZXRwV1FvZXVJKy9S?=
 =?utf-8?B?dXJ5ZGRnQ2sxeDZGK0hVT3BydjdyRVNMZER5SVRiK2J1a0N6WU9nMTNDeFpO?=
 =?utf-8?B?b2VZU3NOeWlwalBOcG9SYWFKZFRiM2I1cWVFTzIvY0xCRzl0dWRNVE5IdDAr?=
 =?utf-8?B?amFLdUJ5Y0FJd1hvVE5SME56bERLRUdxQmIwdHByUWcxd0k2WTNGTDhUaXBn?=
 =?utf-8?B?RGJKMmp4MFFqOTI3eUlURUEzYll3UDZSblg2S1hKVk5Jdm1JaXhDREI4cDFp?=
 =?utf-8?B?Q243Q0RabHV4eEpXa2ZBR05KTmhlc3AyWjArWDJhL2E3eUhWckF1aHBCeTV2?=
 =?utf-8?B?QW5abWNKNTVPRm14dnIrbUs0VmhyTVI4ZGtpelk1c09ETUtMS05RNGk2REpN?=
 =?utf-8?B?V0xwTktjcG8yamFoeWlKcmVRaWlVOFdrd2d3NjhVV2FMb3NibmwwNEpKQWlJ?=
 =?utf-8?B?TnNtdkJpZUZESDJDR2RJbVhpVG9DVnNrVDUwS2lMdmNaWklGZm1pamtPQU5O?=
 =?utf-8?B?WWx3YUtvVGlsKzB4eFphcW5SbnJkeU5NNmdub1FtaG96MXFERDNsODBrUlc0?=
 =?utf-8?B?Y1RsaWtEQ3lUTE1GbzZMM1Q1RzV0ZVk1TWw0eWxjY1l5akYxWUoxWFpidlBU?=
 =?utf-8?B?UmhiU2NRdUQ4ZWxYWHBWbytQOE0rTS9YQmwzeVliRWJSaGpsS1JvSmlyS2Zy?=
 =?utf-8?B?R1o2a0E0aDd3eXl0RHNtS3U0b2x3d2g0anZWRmNJL3FBQ09JeEJJbFRDOGhl?=
 =?utf-8?B?OTNTcWJ3cVdzY0hFZUpVb2d4bStRa0VtS3hPd3duZHlObzJRWnJLTU9peXN5?=
 =?utf-8?B?UHZ2NjYycDFtMWlZMTlBSW1UbE1DYWR5ZUtDUkF5MVNHT1dYR3hGeWtoQXdn?=
 =?utf-8?B?ZmI3cGd6akp6eEVGT0ZaamdLSHg3VDAzbjN1bVc5N3VWb0NvMDFiNk5TbzNR?=
 =?utf-8?B?NUplZnJCU2JmSFdwUjBxNWt2R2N1NmhrRTFQamtHd1ZKT0wxUjIzR3E2Q25E?=
 =?utf-8?B?YTdnV3JiTEtwZ0l3cmpXQkdBNU5BdnFTQkxzRGI5SVFjZWUwelMxMm9qSmg4?=
 =?utf-8?B?ZGJ4TWEvT0FENjUxamIyZ09oVU9oNlA1bTY2bkQ2b2pvQ01WRFhHTTV6QUhS?=
 =?utf-8?B?Zm1iZVA3OHF0Q0d6ODUxeUxwMjNTM0IyamVDUEs3cWlqazdOVUl6ZWtxcVpS?=
 =?utf-8?B?OVdRZXpZbTdXTzdOeTVvdnVSbXh0dHhGZ21jcW5rYkt2WnNZVy9Ub3Zsb09Q?=
 =?utf-8?B?TmtTanMwQlg2RUVpTXBpclZKcEoyQ3RVMUVuUmxYMmNSQnZNMW5XNTVUWTBO?=
 =?utf-8?B?eWZCSGZYMGM3UVlVYVBJRDh3S284YjdoKzZrcVpjN0JPSUMvS3JYTk5MNG0r?=
 =?utf-8?B?cTFaK2svSlA1ZlQyNzVKdUJ1RnljZERyZGNIT0c2em5BS2RYdUZLY2k1R1pS?=
 =?utf-8?B?TzA4SlJ6L1pHYUx6Q3FrYVhZdDJ6Nkl1Qm1JOHhDVGViYjAyU0thelowSlJP?=
 =?utf-8?B?d25kU3Jjc1RZL0dDQXgyeG5MY3NMVzNBNnh5Njg1V2M1MTQwZXRvcWVYR3Bu?=
 =?utf-8?B?c01IczZReXgyK3VhOFV6QkpiUkpBUytlRWNnUllRNkFJdXBjbUVNamIzUHRF?=
 =?utf-8?B?TytuYkpUOVdFOHNOOEwyU0tuNmNjM1paRU1wMTNuSVZyZzdmQ081TGE4R0Ey?=
 =?utf-8?B?dDBtNkoyS0tLdGdOVkVwV3hZWHN5aWpXYkhjUmduWFBLWFZtVzNvdUJOMGkx?=
 =?utf-8?B?T0xoMGE0RHdsWGF2U2IxMXloVkYwRHpiOTF4Z2ZzM0JvSTdhckpmQlNhUTlX?=
 =?utf-8?B?Zm9ZNzk2dnkwc3RLL1NraFowRG5pMDFJVFBZYkJ3cDlsUkJvNnV5bTJxcWtJ?=
 =?utf-8?B?OHlPTVBOUFZCc0Y5QXVyM1htUXU2NW9rOVgrbmhxa1laUzVDVDF6T1JTY2dz?=
 =?utf-8?B?NzdRajlWUVJjRkVwYTJuN1hTQW9mSVcyeHZWT0N3YXVWZlJYRVFuN0hzZzkz?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E009B072BC72644812A0A71E9E17802@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021339ea-069a-41fb-7de8-08dd98864404
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 16:40:59.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7rLaAj9+QKh2Vdg2dIo+cWXkB/Z1Fu9nUYwyLKpZ0zF4CYNoEVkC8kDmnMCnFQaycLYu3gOJkHR0nQ9vfTg0OCJuBKnZHzV8WuZreuAqaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9398
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDE2OjQyIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
ICtpbnQgc3BsaXRfZm9saW9fdG9fbGlzdChzdHJ1Y3QgZm9saW8gKmZvbGlvLCBzdHJ1Y3QgbGlz
dF9oZWFkICpsaXN0KTsNCg0KV2l0aCBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0U9biwgSSBn
ZXQ6DQoNCmluY2x1ZGUvbGludXgvaHVnZV9tbS5oOjU2OToxOTogZXJyb3I6IHN0YXRpYyBkZWNs
YXJhdGlvbiBvZg0K4oCYc3BsaXRfZm9saW9fdG9fbGlzdOKAmSBmb2xsb3dzIG5vbi1zdGF0aWMg
ZGVjbGFyYXRpb24NCiAgNTY5IHwgc3RhdGljIGlubGluZSBpbnQgc3BsaXRfZm9saW9fdG9fbGlz
dChzdHJ1Y3QgZm9saW8gKmZvbGlvLCBzdHJ1Y3QNCmxpc3RfaGVhZCAqbGlzdCkNCiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KaW5jbHVkZS9saW51eC9odWdl
X21tLmg6MTAyOjU6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mDQrigJhzcGxpdF9mb2xp
b190b19saXN04oCZIHdpdGggdHlwZSDigJhpbnQoc3RydWN0IGZvbGlvICosIHN0cnVjdCBsaXN0
X2hlYWQgKinigJkNCiAgMTAyIHwgaW50IHNwbGl0X2ZvbGlvX3RvX2xpc3Qoc3RydWN0IGZvbGlv
ICpmb2xpbywgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCk7DQoNCg0KPiArc3RhdGljIGlubGluZSBp
bnQgc3BsaXRfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykNCj4gK3sNCj4gKwlyZXR1cm4gc3Bs
aXRfZm9saW9fdG9fbGlzdChmb2xpbywgTlVMTCk7DQo+ICt9DQo+IMKgDQoNCg==

