Return-Path: <linux-fsdevel+bounces-55724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CADDB0E416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB88AAA12E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262A284B39;
	Tue, 22 Jul 2025 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLzZOyB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2A21E097;
	Tue, 22 Jul 2025 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212370; cv=fail; b=ZN1KfaJb+fUXIg4d8+qrmLR/4PpRDwY8bob+Utc5X0Xr1p++Ok3TCy89HFq7o4X5DQwGHA55D+C3mLtYgIojs0NykTJlIIHFccjeDelqcjmJ7v7Wuht2O46ETUwHYwih/iCWmapyTLsRvbe1DadjAMNzrbZVQZrwKJwX0HHHacA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212370; c=relaxed/simple;
	bh=Whg6epYQvhbtqMgOGE30xNXDYKMeWxfemIFfKc1fXxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6Ijuyr4J7ldMLtgBwWIvP53e48wRC+d+3fqCh3YnQj0Dhhmj9TiY2BayEt2tfEpJwt6HEBOrueRstp1DhKi0XCYfbmrmTvuN6Dx2j0QsFlH6V26BM8jdsvXWgoFf+9oXvlczCXVHFm2c21UZ3A758y2FtU2kApD3RJ+iyLZvys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLzZOyB3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753212369; x=1784748369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Whg6epYQvhbtqMgOGE30xNXDYKMeWxfemIFfKc1fXxk=;
  b=RLzZOyB3MhByaDAciP1q8VAqM4ozx1yvuiWXmNdvAxfM1gjVwUW16BQi
   1jix0ropl8tmteiOPNCRoRZzcVtSswW+p4zgBX/4/hXuPn5zNpPKK+dFG
   zX/vbi7HZTws1+Lr99DiQEONVllovMgppaGfUouh0z/FMZVoAtgxeUx3r
   zA06idvh948LNt7NXSHEIEiGJWjQVaS0HZ2RCVghbL/I4xd8XKZqqxMI9
   CiIFB+uwrSVIswtRM0GFMcEkfnyJPSytTUO0v2RloT1JQzBKP/ks4Z9Ms
   lyXg4yzOnsVsywH4qG0ZWy5kQ6AtZLPRfPR19lMSjmT++stUij2TX7o98
   Q==;
X-CSE-ConnectionGUID: qqYfV8dKTZmh5kDMoPlI4A==
X-CSE-MsgGUID: lTs8kRShQSG1Uwv6FnAmxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66909041"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="66909041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:26:08 -0700
X-CSE-ConnectionGUID: 61ZN1T2URx+EZYClwcAhTw==
X-CSE-MsgGUID: b6Vzw6UkRlqG8ySU3PBcHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="163276495"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:26:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 12:25:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 12:25:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.72)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 12:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbbTaRYKWcCwIoDimpecWFOOhgbHsvnGtoloi9TEEUPFoMGFzzS++GVkXVSBOrVbSIfUpk8cqDG/YMrE5uvI2faqN4CoXIQUKPLVIni4iDeCVzP0o/55tYyfYIiRQ1RQm3aaJbEKL/4ZRDbMv1/XdshRCy7Fnwpel0CQHOk1chV4Jio7dHgmAxPbT7N18P+ZXDs5SxnU9Sg+uRW83GF/QZ8bghLe/CagFiPXFC73Ib/ZXj4E1wr/3CxLGDpVXOXWkwgA6J0+RbPFjd5tk6xzmf3bQviqGAXo2w1zBnOOSLXd663YwXAkBe+EInmdwVMOJrhqhMPGyqPUoa3KpTCS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whg6epYQvhbtqMgOGE30xNXDYKMeWxfemIFfKc1fXxk=;
 b=xq3PUU5jvsXWYYW9PoqYsPWHzAQY6PcYSRANFNwHcWVP4excyR6NTURgS1vNreDnqJ4KdK4UmRQ0c34cTYax6cVRZgO/rcNlPDhoRRRVMbQm8EImTJHeMdGRej1kLDTX9sYErTww8qiHXVlcblRrs2WTHSx26SiD4SVzc0FjLfzUz9HaBNa0IInqV5dPyTtDWYr2hj/0btwubM5moUxAcCLa21G0H4b1fG+isSa4BqkVhcQtoJMddVzO2HqqUXQ5RyJG3bm3+CoGPZTJNt+jdQXYJVZpvRsrfXgSWyOu39PqDfDP4UxhffV7sWQheQdRg0RTNQXlAUBUwYeW1JbZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7362.namprd11.prod.outlook.com (2603:10b6:930:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 19:25:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 19:25:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"kirill.shutemov@intel.com" <kirill.shutemov@intel.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "peterx@redhat.com"
	<peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "amoorthy@google.com"
	<amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, "maz@kernel.org"
	<maz@kernel.org>, "tabba@google.com" <tabba@google.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"keirf@google.com" <keirf@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "hughd@google.com" <hughd@google.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "Du, Fan"
	<fan.du@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>,
	"steven.price@arm.com" <steven.price@arm.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "fvdl@google.com" <fvdl@google.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "anup@brainfault.org" <anup@brainfault.org>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net"
	<mic@digikod.net>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, "Aktas,
 Erdem" <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"willy@infradead.org" <willy@infradead.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"will@kernel.org" <will@kernel.org>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "Graf, Alexander" <graf@amazon.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "seanjc@google.com"
	<seanjc@google.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Thread-Topic: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Thread-Index: AQHbxSn3iSZ2XhLbXkS2H49k5P/AOrPbRx2AgAA9VQCAAAu2gIAAB56AgDagiwCAAE9tgIAAEXMAgAw0/oCAFuecAIAAu0KAgAB7+ICAAKWngIAAz+6AgARfFwCAAh3LgIAAEtsA
Date: Tue, 22 Jul 2025 19:25:08 +0000
Message-ID: <4c498701b6e012a7d55b8da58dc2050f55090959.camel@intel.com>
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
	 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
	 <20250624130811.GB72557@ziepe.ca>
	 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
	 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
	 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
	 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
	 <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
	 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
	 <687a6483506f2_3c6f1d2945a@iweiny-mobl.notmuch>
	 <aH4PRnuztKTqgEYo@yilunxu-OptiPlex-7050>
	 <diqzwm803xa4.fsf@ackerleytng-ctop.c.googlers.com>
In-Reply-To: <diqzwm803xa4.fsf@ackerleytng-ctop.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7362:EE_
x-ms-office365-filtering-correlation-id: 13f0213b-a384-4517-453f-08ddc95578a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHBpUUl5dWxaSFhzWmY3MGFTNGR2SjdJUkZNbUhqdTNqWDhPK3FiSzZCZ1dR?=
 =?utf-8?B?bWROeUN2MHRqYzBkeUhHNUw0ZmF0dHNtbGVmS0J4QVdhbmFPem1hckdxaCt3?=
 =?utf-8?B?cnV4dk1kRmpCRENLUkFwMVpka2pXU0hNTXNvK2pVTVNZZG5WZW0zaWloTXBi?=
 =?utf-8?B?MFk3QXROVTJadkxtL29kRlZZVWFpWUlHTTNKOGhJMDlaQStjcmFnQ2p6Q0ZT?=
 =?utf-8?B?aFJ3K3RVYVgrT0FOWWdkeWZ1ZitRTVBwS0RGbXdYRWYwSVdFMG9KV2cxMlI2?=
 =?utf-8?B?TXRIbVNvQmxKeEZUbFVuZUxTd3BuMHg4NG9Yd09pT0NUdlNLdEF1OWI1QkMw?=
 =?utf-8?B?c3UrMEkvVVBjL3lxYTZnMHZNNFZwaVRXMnkxQU9aZHpuajV2OUVteDhiUzdM?=
 =?utf-8?B?bmNZdkxWOEY1aGFCV2pRMHNpOWNIZVJzaVhDbVZ1cDEvdzdKUzVoWFNTZzJw?=
 =?utf-8?B?S3ZGbGpZaURMVkNGU0lBbUU5bEhwWkRRa1dOUjZNTXFRMDQ1QlNNMWk0S2g4?=
 =?utf-8?B?am5VcjRDazFWQ2hNWFdNeDNRTlFDVDYyaXhCMi9XUDVFUVllNC9jcC9GT0hh?=
 =?utf-8?B?NWVuZldJdU5wYk9NMHErbktUTGJZeFNZSE9VZkZNOURuYndRMWtia2FSUjMz?=
 =?utf-8?B?WlZVbCtrZ28rdm9WK0dEMVNsblVnWlpVV1gvTW5Zc1BuT015WGswVTlLODhu?=
 =?utf-8?B?NXFvSlhhaTVBSlNrVndZVDZ5RnF5bzhxSUZqaUZQdkFFRXdLQ01GTGQrRGNh?=
 =?utf-8?B?bkFRV09SMmNySmxEaW1JRzZGcjF3cTh2bytDR01JYmdHZ3lVTjdNNEVlV0lq?=
 =?utf-8?B?TTdHdDVoTkVKK3JBakpJYnQwSUJtU2V4Mzl5WHRHeG12N0tEQmFXcHVPT0tz?=
 =?utf-8?B?VytLczRQUXFreFh5WXVERzRNN1Q0czFMQ3FCTkVSL3ZndTh5T3ZraXZ0dEo4?=
 =?utf-8?B?VnFNbE13NG9Sa1pKa3ZhTTNQb3lTUG5SZDVDamErVGdUSmkyMnBDR2FiTG9l?=
 =?utf-8?B?aiszaGRER24wVVNTa1JEVjVDalg4dm1lWFVEcU9jbnpab3RRRkwyR00rTVlQ?=
 =?utf-8?B?YVdmRU5QcWZJK29VdEFxcUs2U0FKcFRzeWxveUpEZG1WSkRmQUthVjV0RlZq?=
 =?utf-8?B?c3ArU2dweVR0YXFVb0k1WjFtZEJHajUwa2RCMU5uSjBZaFkxcE93QWh3UUxJ?=
 =?utf-8?B?V0lxQzE3T1FpaUNybXl2dURTNXphbmZFTjBRZldwUWRoYWdSSThjQ3Rvc0lO?=
 =?utf-8?B?YnNST25aNCs0MUxmZGpDOUNjVkI1U2grUnNoVldFckRmYTVzUG11S3g1R09M?=
 =?utf-8?B?MUw5ZG5SYUplclR4cFhCY2J2V0tJUEUvTUFqVmE2MmZ6Z0tEL2tOOXc4TFBG?=
 =?utf-8?B?VXl1b1BHcEtvZU5FWkprUHB0TmFlc3dnb3d2SStoQVAySzJHVmJrVFBLNFMv?=
 =?utf-8?B?NkNZMmJ3L1ZzRlRrK0Z5MEpacDFHSHlUU0NnekJ6Rng4aXgxMS9wTXVqOFkw?=
 =?utf-8?B?RzRIbHdIMWpVN0Z4K2ZzMXBNakVzUFVwakdkdHVYOWJuWWEvVFdueWg5STRj?=
 =?utf-8?B?ZXptbS90ZzYwUWZ4M0pMSW14UW1NRlB2aUkwRFZUODhNTmFVZTV3V0N1VVJN?=
 =?utf-8?B?ajhieE9VSlV5R3lhWjZCR0FJS0hVMElsMm9lOCtKelQxSDVqV1pPbVZtTmJI?=
 =?utf-8?B?ZGVmNnA4U1BtTXVCQmxxVjF1ank0WkEyUExXT09VQkhoZnhBanZVbUNhQUp4?=
 =?utf-8?B?NURRZUR6VTE5emVKbWVMSVZUWTgzZVpjMTRIOG1TRVVzVVNlaWd1UFVOUm5H?=
 =?utf-8?B?S0pEaG4zS2pxelc5c3RoR01LZ0tJbElFMnRHSmNYTkRTeXBiL3NNblNsc2pI?=
 =?utf-8?B?di9adEQ5R3FLWWd1U1p2OFhHM2dXM21zNGloUEVXTkxpQUtPSzdYcXM0TFpl?=
 =?utf-8?B?Zm41cmNURUs1anRNdUNhcC9ybEh5ampHZUJzU1JhalRWNTlrSGNBWWcvRnhC?=
 =?utf-8?Q?PhogG2WP8F70GG1I7BUTKwT9/oyqAw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZCTklUTEk0dkxhSXNTTWd3YTEzYmJucDhvaitaSjZKTGc2NEpzMHBMV3Vj?=
 =?utf-8?B?cmh4NFVLZWc0WGE0d0dGMVhuS3VVUzlETmYwcE9rcVhIdHNCOTRMMlZuVU9Z?=
 =?utf-8?B?dXdRYWJRK2NNYWJ0dXljaUxRWWZtb0RxdEpkb2JveWtKTkw0dGY3THNoTVVB?=
 =?utf-8?B?eFBiUFFCKzVEdXFYbThpMkFpMHczZXlicTBueDkzaTd2WGN0czI4MnJ4RmVB?=
 =?utf-8?B?Q1Y0dFR4TEpkSllGeXB3M3RqR2tBelVtQ0JoM3BhOU9TbStJVGd5RWlNN1dN?=
 =?utf-8?B?MDFlUElGUmh2aXd4VkRJUlhOR3pOTnFsVFNXUWNMMWlLaGJ4endKTkZkUi9V?=
 =?utf-8?B?QkxQRUhpL0dGOGR0bkdXSmpkVWpiY2xEYzJtb0t2TGtLdUVTRVhsbXZtSTdN?=
 =?utf-8?B?OWJtYVViOWFCdDZneXJyT2JyR01oRmZJbmNzK1BKK00wNFRxQ2RLZ21ETjVQ?=
 =?utf-8?B?aFBPd1BVUk9xc01KMGF1ZFNNNWtqdFFqZUlUaEpCZ2h3dE1vVnk0T0Zyancr?=
 =?utf-8?B?d3VIdDNuM1EzSlBVZiszZ0xUNXdNSEpiUk9qODVYSllQZkVQODJLaFBGNEQ1?=
 =?utf-8?B?eitOblhzQnBDZmNMbDRQSTczelRvUFJndGtBR21nUWt4eVFLZlo1RXljTVdr?=
 =?utf-8?B?VndZeEpUR3ZETmFIYXB0TE5mdXhNMm05aFk0R1pCUzFrMmFVdzE5Z0ErWGQv?=
 =?utf-8?B?QTE0WXJmVkplaW9FTWhkZjZRL3ZyTjR1a2Y5dkU1NzR3emRtZ2R1czNYaWRl?=
 =?utf-8?B?UjV1cjR2cVZnQTQ4NEV1Mk9kR09rYWhpSVBpUElzNjFpM203MXFnNEZJT0Vk?=
 =?utf-8?B?UkptUlJiREtCOVl4U242MUNoWEQ2K29kVSszbUlMK0hYZElaZThpc0RUU1M5?=
 =?utf-8?B?UnM5Z0JROUNZUDJ4b3lHeEN6ZXJWc21DRStnMzNiK29qSjN2b2M4NTFpRURQ?=
 =?utf-8?B?QkdDTEwxcUFDNXZLNGt5aDl1Y3UxRXJCcFk0Nm5EWFBoYlhkMENrMEduMGR2?=
 =?utf-8?B?bENYZG1pdkowSyttMDd5c3dITDY2bFdqZGs4OXVxcWNqV0YxSkxLeHFMU204?=
 =?utf-8?B?dlNYazFBRUhhcHN3UDhkaitZeFJxS3BBK3VRRktOb0J1UVdvcFFnc056N3U1?=
 =?utf-8?B?dkUzRFAvRy9kT2pMaEpUMmM1ZFcybDhSN1Uvc2xjeStpOGVQUFJ6akxNTVFB?=
 =?utf-8?B?R3UxQXczenoweHFOTW0zUFlZRWhVWFl2L0x2dGhrTDVvRHhEVXhKU3IreEpB?=
 =?utf-8?B?VTIyaFJWRlBWTUFMakUvVVVhekJxb1QxZXB6Z1JJVTR6OWRhTU9RbDhrSHFR?=
 =?utf-8?B?anNVOE1yL2kydTA5M1c5RUpia29SL1FQZW9lSDFlckNBT3JLdHZGVmgyeGpq?=
 =?utf-8?B?VjRUT1ZncEZ4ZGVJUm1kZU9UN3padklyTldYakE5U01KVkZmSzJYY0RLbjYr?=
 =?utf-8?B?NGhIUGRmTUlleXc3YkVNUlhOWk5xVnh1OTNTeHFTclFZZUQyelR6dDUyaVBa?=
 =?utf-8?B?QnpCNFgzMjhmSEV0aGNWZ2RnbEJuMlBMNFc1SDhNck5rdWttbjc5Vk4vUTlL?=
 =?utf-8?B?Y0xKeUdhaEE1anJwdHZxVG9ucm9hTk5jUHpYL3J3bEMyVHJVdUZrdVBZc2cw?=
 =?utf-8?B?SzJvYXlWbXdwd01FYlUzOUs0MkZaWG92a3Z2Y1NFbEFrWTQ0aUhtZU9UNVpn?=
 =?utf-8?B?dTlWS0E1SXBqT0FiZFBtVFZXTG1TbnZ0WFZzTHpyblZpUUduM3ZXRHhWUE9n?=
 =?utf-8?B?a041b1dvOXgwR0ZuOEtkdzNvcVBOclB4S3R1bFYzeGsvRTRiUzRrZFYvdmZu?=
 =?utf-8?B?TlZIbFJ6WGxRQUFQVS9wYmdwaDRjcnRjRXZvQi8xbUJISFdjakZVZ05BT0Ro?=
 =?utf-8?B?N3B0eGthRGFTanN3bURPZUVQQ1R5d1gxWm5vckJYK0U1QVloNzFlU3pHYlM4?=
 =?utf-8?B?a1R3RWlyaUh6ckpqaExSU3FTdXdIK0NOMUdNSGZqdm9CVk1nNTg3SUJ6R3Bh?=
 =?utf-8?B?SVdxeHNYcmU5RXZ4WExDczZ2bThSY3UwUFNubjhKQlNwSGpIR3E4WEUvdHkz?=
 =?utf-8?B?VUJ2WnlMV0dsU0FqUEp2OVZ3VE5FL0YzYllONXE5U1pJNXNMcEUrNU1LQThD?=
 =?utf-8?B?NkpSWjZCYkg0R1lYZ2I0YldydndxQzROdGZWaUpxMDhTRVViRVFUUWNsQkk4?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA87155BCA43CF4A9ECE96A30D3DEC4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0213b-a384-4517-453f-08ddc95578a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 19:25:08.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0noXCFGmIc+BiKTdGrDBdOVa6ARWb9ZoAiWO+LWNJPZH9ZchfoYY2brX5H7/Iz5mHrKypANpf+BJUj+LA+KRY+EfBcexWaiuFmNV86plEOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7362
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTIyIGF0IDExOjE3IC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IFNvdW5kcyBsaWtlIGEgbWFsaWNpb3VzIGd1ZXN0IGNvdWxkIHNraXAgdW5waW5uaW5nIHByaXZh
dGUgbWVtb3J5LCBhbmQNCj4gZ3Vlc3RfbWVtZmQncyB1bm1hcCB3aWxsIGZhaWwsIGxlYWRpbmcg
dG8gYSBLVk1fQlVHX09OKCkgYXMgWWFuL1JpY2sNCj4gc3VnZ2VzdGVkIGhlcmUgWzFdLg0KPiAN
Cj4gQWN0dWFsbHkgaXQgc2VlbXMgbGlrZSBhIGxlZ2FjeSBndWVzdCB3b3VsZCBhbHNvIGxlYWQg
dG8gdW5tYXAgZmFpbHVyZXMNCj4gYW5kIHRoZSBLVk1fQlVHX09OKCksIHNpbmNlIHdoZW4gVERY
IGNvbm5lY3QgaXMgZW5hYmxlZCwgdGhlIHBpbm5pbmcNCj4gbW9kZSBpcyBlbmZvcmNlZCwgZXZl
biBmb3Igbm9uLUlPIHByaXZhdGUgcGFnZXM/DQo+IA0KPiBJIGhvcGUgeW91ciB0ZWFtJ3MgaW52
ZXN0aWdhdGlvbnMgZmluZCBhIGdvb2Qgd2F5IGZvciB0aGUgaG9zdCB0bw0KPiByZWNsYWltIG1l
bW9yeSwgYXQgbGVhc3QgZnJvbSBkZWFkIFREcyEgT3RoZXJ3aXNlIHRoaXMgd291bGQgYmUgYW4g
b3Blbg0KPiBob2xlIGZvciBndWVzdHMgdG8gbGVhayBhIGhvc3QncyBtZW1vcnkuDQo+IA0KPiBD
aXJjbGluZyBiYWNrIHRvIHRoZSBvcmlnaW5hbCB0b3BpYyBbMl0sIGl0IHNvdW5kcyBsaWtlIHdl
J3JlIG9rYXkgZm9yDQo+IElPTU1VIHRvICpub3QqIHRha2UgYW55IHJlZmNvdW50cyBvbiBwYWdl
cyBhbmQgY2FuIHJlbHkgb24gZ3Vlc3RfbWVtZmQNCj4gdG8ga2VlcCB0aGUgcGFnZSBhcm91bmQg
b24gYmVoYWxmIG9mIHRoZSBWTT8NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvZGlxemN5YTEzeDJqLmZzZkBhY2tlcmxleXRuZy1jdG9wLmMuZ29vZ2xlcnMuY29tLw0KPiBb
Ml0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBR3RwckhfcWg4c0VZM3MtSnVjVzNuMVd2
b3E3amRWWkREb2t2RzVIelBmMEhWMj1wZ0BtYWlsLmdtYWlsLmNvbS8NCg0KRGpidywgWWlsdW4g
YW5kIEkgaGFkIGEgY2hhdCB5ZXN0ZXJkYXkuIFdlJ2xsIGludmVzdGlnYXRlIGEgd2F5IHRvIGhh
dmUgYW4NCm9wZXJhdGlvbiB0aGF0IGNhbid0IGZhaWwgYW5kIHdpbGwgYWxsb3cgdG90YWwgY2xl
YW51cCBhbmQgcmVjbGFpbSBmb3IgdGhlIFREJ3MNCnJlc291cmNlcywgYXMgd2VsbCBhcyBhIHBl
ci1URFggbW9kdWxlIHNjb3BlZCB2ZXJzaW9uLiANCg0KSWYgaG9zdCB1c2Vyc3BhY2Ugb3IgdGhl
IGd1ZXN0IGtlcm5lbCBkb2VzIHNvbWV0aGluZyB3cm9uZywgdGhlIGd1ZXN0IGNhbiBiZQ0KZGVz
dHJveWVkIGluIHRoZSBub3JtYWwgVk0gY2FzZS4gU28gd2UgY2FuIHRyeSB0byB1c2UgdGhlc2Ug
b3BlcmF0aW9ucyBhcyBhIHdheQ0KdG8gc2F2ZSBob3N0IGtlcm5lbCBjb21wbGV4aXR5IGZvciBj
YXNlcyBsaWtlIHRoYXQuIEJ1dCBpZiBhbiBlcnJvciBjb25kaXRpb24NCm1pZ2h0IGNvbWUgdXAg
aW4gbm9ybWFsIGNhc2VzIChpLmUuIHJhcmUgcmFjZXMsIG5vbi1idWdzKSB3ZSBuZWVkIHRvIGxv
b2sgdG8NCm90aGVyIGVycm9yIGhhbmRsaW5nIHNvbHV0aW9ucy4NCg0KV2Ugd2VyZSBwbGFubmlu
ZyB0byBpbnZlc3RpZ2F0ZSBmaXJzdCBhbmQgdGhlbiBzaGFyZSBiYWNrIHRvIHRoZSBsaXN0LiBJ
dA0KcHJvYmFibHkgZGVzZXJ2ZXMgYnJvYWRlciBjb25zaWRlcmF0aW9uIGJleW9uZCBmb2xrcyBz
dGlsbCByZWFkaW5nIGRlZXAgZG93biBpbg0KdGhpcyB0aHJlYWQuDQo=

