Return-Path: <linux-fsdevel+bounces-74196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A5D37B05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E74531680F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1733A1CE2;
	Fri, 16 Jan 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPAQA1fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5439A81C;
	Fri, 16 Jan 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585921; cv=fail; b=FTIwF4bN2vuqittG8zee9LyybtYFTaZC8/s6xrQywfz2N0EQNg6boHy6gnpnLtQoAccYa2UfPEELSM191v3bzgZ3DXijMNNs0u6ywFo8gKmsyNzM9rxLIWCIUJBM2r+o7iY6B2PeQhADdZ1Y8ryLYvSW2PgQE0si6I2lUcilYpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585921; c=relaxed/simple;
	bh=/MjWgA+xCKmg4JNWpQiU8rqBPGfg/TXisbDLcIs8HIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AdBr1zOi6WHGR9UP7CHGKlBOwRuN4aTSPHxFzcwWTwBMITthOQsBfZ8pAPZG1Xa/dnQUPU2XpzWQlg0bU4PJocYGnj9FQG2VuutkfSstfbm7UNYs9jNBNMxgJhPv0ONSDqa/9pSM5vUEfRkXEOmU5f0A1iHv9tZNCZA2z2p8Gzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPAQA1fb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768585919; x=1800121919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/MjWgA+xCKmg4JNWpQiU8rqBPGfg/TXisbDLcIs8HIU=;
  b=bPAQA1fb7Q6HR/lc14XWMeCH2u4Qu/6NWqYFd44071kZRkMSXRedrLuu
   j118Q3xaOXu/yk50FoVfIwTTVe/OVTbEIEaLUk+LZO6CVS3uBS1Y31GzK
   JQdcPq8tdsnUM8HM0i2sLUnQgxDMDUe6U9Wpkn3FIs5S5gtK3YwD32FnF
   WGdMUTMSEXLilCRQlJihrQ/4ZfNGzWdXZkwRmgQz0coAICbnzh1A8dbH0
   y78XAusrKcvgjWavELW1hrbAv/TsxdOWCg+1XcNAKxb/EMCLIr1cNa66I
   krU4+L+30RivPx5u44uI05ZrQzEwS33jRmak5U8DTa849Q5vHRz75yNSU
   A==;
X-CSE-ConnectionGUID: +7gwTR0EQB60AFhXm7nx2Q==
X-CSE-MsgGUID: rUzKQwMpTrWLbOlEtyIbzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80625549"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80625549"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:51:58 -0800
X-CSE-ConnectionGUID: uOIRotoQTk6QWA9gvZ7FUg==
X-CSE-MsgGUID: mQeSjCoiRUupi53mopjLxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209782977"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:51:57 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:51:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 09:51:56 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:51:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWkm1XqoQoPxhsx3/KvaDRaK0Zv3u7M5aapUewJaWpfhDlbWvJdVadvO/iiPw4Kd+N4JoydpO8PQfgNZeMMGkMJL3xq93+7KZdkjjG+6j5dqv4cO/GLhY800TA11IDPxjvD8e1FWlqsDIv5RxgCJJxJTJoCuO/ZZBhLvriLDi4aiax/lWMjpAsn1oxLgwaagc3P3vfwF72RaYmUw7kPKUHd9JzWfVNDQ9z/ddk6Jnxwh12dLk4FXKNxsccWksGPKWTlQFVA/5f7FZnYSEKZ3ATpkELpTOF2HGYsRAGai1DHxH2/zn7jIOOk1/olV9HGrFpPWlNSqsdWHNJhs6AV7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MjWgA+xCKmg4JNWpQiU8rqBPGfg/TXisbDLcIs8HIU=;
 b=F+KY4DtxrldxqBBc26cC6em9MoQF/xFBcIpLhX08Og99hfwITl+LlJZmQd7UX15xxRYczAP6tHsBvMsF0xvdTDhzQLNho0KE29ifFuLjSeo8WXC261jjJAAi4mCIWCZFoKdSRhn+zrMCBGC/7O9IZwwQMQxCPBxEfRUgCSyB1Ui2LmEC7CzUkQoYkWmh8ScPUwfddCxRV/x0xZUZ74WSkoMh1drGBDD2riDyGNsrFNrmH9HbYRzGWxY+7/pinf4xqqrsUObt8uNuBX9nQxajCwYO582kaTVBOeJzMSc7a3SElJNV8ygH6XGVC0tBWyzNPvtMSQ92PCI7mpQh8nL5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 17:51:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:51:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com"
	<jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com"
	<riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org"
	<maz@kernel.org>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"ast@kernel.org" <ast@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"Annapurve, Vishal" <vannapurve@google.com>, "pjw@kernel.org"
	<pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org"
	<luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org"
	<song@kernel.org>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "oupton@kernel.org" <oupton@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"jthoughton@google.com" <jthoughton@google.com>, "Yu, Yu-cheng"
	<yu-cheng.yu@intel.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"prsampat@amd.com" <prsampat@amd.com>, "kevin.brodsky@arm.com"
	<kevin.brodsky@arm.com>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kalyazin@amazon.com" <kalyazin@amazon.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "jackabt@amazon.co.uk"
	<jackabt@amazon.co.uk>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk"
	<xmarcalx@amazon.co.uk>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "jannh@google.com" <jannh@google.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org"
	<kas@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT2boAgAELpoCAAAmigIAAASQAgAAkzYA=
Date: Fri, 16 Jan 2026 17:51:46 +0000
Message-ID: <4ea222e917837dd14d581fceaa65a8e855678e48.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
	 <208b151b-f458-4327-94bc-eb3f32d20a68@amazon.com>
	 <4781ba9c5d16394cdd785d008cf2a2d81c5cda35.camel@intel.com>
	 <aWpcDrGVLrZOqdcg@google.com>
In-Reply-To: <aWpcDrGVLrZOqdcg@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: 6a0b231c-2769-43a3-6bd1-08de5527eab2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dzZLQjI0cFZ4QUJyYWRQNDJwVEtiaXpTdU43NTNVNlZROGJjZDE4MWNuNm1B?=
 =?utf-8?B?UWpOeXdxTjJ5MWZJQ0RxSThnTGw3cWtURVlyUGFqTGJJbVRaY3dBdUZEcitR?=
 =?utf-8?B?VGFuTzRRSjZhMWsrdjZRNE1ScXg1ZkROMFh0WjU5UDVTL1ptbGFuL3dybGhn?=
 =?utf-8?B?RU8yaFN0Si9hS3phSkJ0bWZSYlFIalBFOGdNMFVkRHZERFdySkxFK1pXbUVP?=
 =?utf-8?B?WUovVVI5b2dWVXg4c0VNa3YvS0czTXYzeWRZd2FreU5UMUNWdWVUV1dra1Jj?=
 =?utf-8?B?RGR0MTlQYi8wQk8xVy90N1g5ZDlEMUVEWmhUSzRScktwTDU1eEdzWHNOMVFX?=
 =?utf-8?B?VUZ1QXUrbitQTzNQSTJ1YithSGE0MmF3c0x0eDZEaGFqY1M1MlBqVnNSM0s2?=
 =?utf-8?B?dzhQQTRkVFRaQWhSYmZoRDR2ZkRxTmpsRGdtTFRZSWxRL1RJVTJ2VzZzUmhI?=
 =?utf-8?B?NTJzdGRkWjlDMjU5a3A1WlYwV3UyK2d6cXYxSHhlMno4bG54Q1N6QTloMStP?=
 =?utf-8?B?aUlmcWhlT3l2TW9HZW5HSnVERmxWWTVZOUxyV1NMaVRWL1dNT2pFQjBUTEsy?=
 =?utf-8?B?Q1pJR3ExeGlOU0tVcFNBbzBzUXpYOG9LRGg4dWQwcElwYTBpcmNwaGIyKzY1?=
 =?utf-8?B?VU5XcFVOQTZkTlJuWCtRcnRTZmRJOVBmenRDOExZbGZtcXlGc3lpTXAyQUpE?=
 =?utf-8?B?aE1KMTNxbEF2M25GMjd3TUVPKzVSUGN3aXAyRjF4bmNLRHpFdGNZLy9mT3kr?=
 =?utf-8?B?ZEJLcEs0WDM1NEorRlFLT3FGSWlTczdSd3JUajdqbFc1ZGlJa2xaVk02U1Zw?=
 =?utf-8?B?ZHVVNmNNbjZudmRnajBUY0VOL0VTM3ZiRkp6OUJnbUpuVDdUMVVtcnNwSm9U?=
 =?utf-8?B?Y09lSWN3cEpET2RVakR2WTVnTmE0TzZHUnpBazk5Yjl1TENzMGhtekExZTJ6?=
 =?utf-8?B?NUdiMG1LZE1mbS9vekl3QjA2Y3ovckRPblV1NlRYR0JYdlVabUc1eUlUWmZh?=
 =?utf-8?B?dFdoMWZoSzlsSFptdGJxTlo3Y1JwK1h4aGUvblpyS1ZWbWNUa3B5YnFYVVdP?=
 =?utf-8?B?NjFoZy9RVEM3Uk12alYrSVZHcEJxVjVVUERqVnJOc3VaMGdoYjBEZ3ZkL29T?=
 =?utf-8?B?Qld2czMxMEpwSWpTZ2FNZThuQlNTUVZkV1c3ajlhazFWMEovZjFqRzhJYjFN?=
 =?utf-8?B?WmJhSk4vQndtNDNQdGJIbGQ1cWZxOWcvT3AxNGV1RWpJNTdaYVgrcUJVNEdH?=
 =?utf-8?B?Z1BWMHFMc0J6NENlMCtJa2x3ekliMkZKVVpURVFsYUhwbmI4Y0tneDR4aEhJ?=
 =?utf-8?B?MDNnVWpLZkhwQWNTdy80V3RsMGV0NjBsM2prS3NVQmFpQyt5L1BpVEVDNFRX?=
 =?utf-8?B?UytZZDJvMVVUT2VwWGxPbExrZitYWDlRblp6SktVcG5UMEhqUmhOWkNoeVNt?=
 =?utf-8?B?WUIvYlEwM1NMa0pFbSttbHdaYUlDb1M4NFVQV1VXNmdESVpvRzM0djBpOHpY?=
 =?utf-8?B?bEJycWxtaXNuL3kxZ2V3dGxiQnZJcDhBVkhwRGVQdkJtV0xVWnQzRVFzcVA5?=
 =?utf-8?B?ZVoyN0Zib0NGTTNFMzYySHRPZ2xwUjRsNWVJMEpXK1R2ZFRGa3Q2NXVDZE5k?=
 =?utf-8?B?YlY1Vmw2QkRWR1BaOUhIenN4YUorN2Vaek90OFF0ZnlyWThTa1ZNVVhWVzhi?=
 =?utf-8?B?MDJCU1B5V2dGYnA0RmZYY3F2dGF6VWJUSU5UNk12ZFhubUR6dTh3NE9COEFN?=
 =?utf-8?B?U1VrWnRsa05KcnN3cUxSWWJ1WC90RUhDMll3dEJDS2JiU0F4WVEyTmszOUtq?=
 =?utf-8?B?a3VsQUZYTGxDeVFmeEVKRjVhdzV6dEZmVnh6NDVvL1AyaVEwMzAvSEhjeWlV?=
 =?utf-8?B?VWl4dWxYRVhDcSszYTlTUWhlOWViL1RJNFhBQWN2cDlkLzJLdk5ZR2ZRTnpR?=
 =?utf-8?B?MXlOZVk5a0tPVnlvY0w4czNLc1RGRTkzY2MwVGlpMTBOVFE5b2JuZUlJSFp2?=
 =?utf-8?B?dkpaZHpPZlJ5S2NrZ284UVhUbGg3c0ZLdGxSeUpjSy9NeHhIT29qTlhpQ21T?=
 =?utf-8?B?WnZ5K2h0TGpia0s2WTRIZDFFVmV5eHh1RjRZT0NxM0wxd0l4bWdUWGZDSDZs?=
 =?utf-8?B?VDg1NGdVVFVsUzJvYmxIYkEwbjNsazg2TnZnMEtLaitvR2xRYXV2alZLeUhM?=
 =?utf-8?Q?JowBjk/BQ9LYvxQS0zPahOU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGRKbmRaUmIrQ0RnU3ZBN2NFTjJKQ1NTK1V0TDM0SmFpbE56TmJ1d3lsd1BL?=
 =?utf-8?B?cVJMREo3dWRHS0hQMEJyTlBTcTJtU2hEdXpXengvMWhweEZUV1RtVStNVWZj?=
 =?utf-8?B?cEQ3NzA5Tmd5Wkpya3diT0tiMkZZektNb202M2xhVG9RY2YwMmlueWhaUDhw?=
 =?utf-8?B?bmFzYThoK3daUFk1UHlFZTF3RVVrczBnNDdyeHd5Y0RTWWpGNU9URlliZDB0?=
 =?utf-8?B?NDF0bzV4SzYxMkdDT3lIOXc4cWFtaG10cEhxRW1oMmhUSFVudVBiTnFqLzVG?=
 =?utf-8?B?eGFTOGRBc2drU1Y1cXh6RWNpYy9GSHM1WlJsQjBRaEhmTFk3QVM5ZDVVR3NW?=
 =?utf-8?B?Tlp0NXhhSW5uV3AwZEpuczlUbGlMQlRIT2dBeG8zajhqQUdjY3pZV09QUkxR?=
 =?utf-8?B?aVFzMjQ4UHFIVGtmb1FWSUlHRDY1U0RkY3pjTHBieEFKTWs1Z2g4NGFTU1N2?=
 =?utf-8?B?Z2VLRTFlY1RtMW9TSmlucndMV1J6L1cyd1gwNnp1NUFjZDBxWXRGaGFaRHor?=
 =?utf-8?B?TnVjVm02T216YjlqR3MwdzVMMlBlblltZDVCOW5PWThMR2F1RWZVd3h3Slo3?=
 =?utf-8?B?M0ZkUFhQSW1rS05tQjhLR3VqejMvRng0R1VJZnJKcVVNV3kxcHhDbXdjck5J?=
 =?utf-8?B?Z29vTi9TRkNPQ3hRV0ZiYjVYR3Vid0grN2lFQ2ptWEJsWEpkQ3J3eWpTZlNi?=
 =?utf-8?B?bitwdmdJZUVNcC9KTHkxTUxYUU5sSjBwTWFBZFhaUm4wL0gxMHVzQXBZS2w0?=
 =?utf-8?B?OEMrN0VlbWdoRisvQ1ArNko4Q3MvOEVWNzNKb0NveWRCY3Z3Z0E4Z1FwUlFp?=
 =?utf-8?B?UmpSeTRVOTlVOC9FZmh1MEtGNU1NdnhUWGZWZDJrSVZtR0JpTGpzdm1oaVZy?=
 =?utf-8?B?T0doT01Ub05FQ0taVitQL3hsb3ZhdG91czVLL0FXanhtdDFVRER6SExva0tT?=
 =?utf-8?B?bEN1cEVuZzVHUHc5eWltb0FMVmt0K1FsdjYwdGhWaHJ6cTJ3NnUrTWU2NmdY?=
 =?utf-8?B?RmxpTStpOXpTSllONHVJS2lJbXhEc0pxNXlFeWZhS2twQmJXK1ZTcnVhOG9P?=
 =?utf-8?B?a2FTTTArV2R5dUFMcVh4YnBnTWhIMHFZWkd2ZW1VbTY5OXNSTjJyZzJidEZy?=
 =?utf-8?B?UEVwekkyNmN0aGVtbDNwUG9saUFSYW1tRHBBckdiWjNzTlRLSmJDbG9FYnpZ?=
 =?utf-8?B?OEVYeWYyTTZKbUJhYWhvQnREREVDUXV5NHlYU2JXeXBXRURmY0VLMlBCMHRO?=
 =?utf-8?B?ZERJSDZtcW5LcjZlaE04cXZDblovNUJKb0R5SEZseWlKWHpHU1ZTS0QvTkZm?=
 =?utf-8?B?MEhybElJUDlOd0hNMHo1S2FCbjZuVWxJTmptdTJZM0NLZDhkdU0wS2I3cUpF?=
 =?utf-8?B?TERjSGllNXdFOTViZHh4OGIwc1gxamdNMWJjRVdOR0pVMWdsdFVkOEhUUXIx?=
 =?utf-8?B?NlBHMG81UkppbUNEOVg4QTRlVks1dEFDSzNyNEdFR0dwS3ZVc1FBeWhlTEU1?=
 =?utf-8?B?MUdXTDN4ajNHZFhMNEE2S1pBZ1Z2U2c2ZG01KzNoRFhjRTV4MHBJM2YzNGo5?=
 =?utf-8?B?dFhKQVlrYWxsb2JrVkdtT2M4WXRmenFxR08ycXlLdjRnaTNrZDVoblVZQndO?=
 =?utf-8?B?dGgwaGFlZCthbzJzQW0zVU8vRjZva0k3Vzg4SjcySGRRdHp6ZEpoaW5zZjBS?=
 =?utf-8?B?eFRzZVRHUkRvYmxFV1N6UmtLSVM2eGgzOERLSnFkU3E0TE1aVGJCeUZmWVdY?=
 =?utf-8?B?UEFDOHZPYUN1eWdZTTBQT29XbzB0Q2c1VXltU1VCRjNsN1JzcE5LeWsrRm9x?=
 =?utf-8?B?R3BHOUNXMUpDcUcrVjlNMGhjVGt1NG9Ib1VvSFFJdGxNQjFISXRyQnk2UXRa?=
 =?utf-8?B?S25MOTkycjZ0TjMrSTQ1VnVGZXZmeENEVURiTUNHazNaTkJESzlQeGJvcVRK?=
 =?utf-8?B?ZHMycWNmcHNTUDZKSG9HNUpYZFgzVncyeHk3MCtjVHpQaXZmeXpQSEtMeW5V?=
 =?utf-8?B?ZUJrM3dOQlBNU0VTRXAyazVrZitiSVFNa254QWR6eTFqTHh2TGRHQ0tnNHVS?=
 =?utf-8?B?VTdZQ25qa0hiTVZVOFE2VWFRSzhSeE9mbXJVMXZ5V3owdlpCV28yeHQ1eG53?=
 =?utf-8?B?K3Q4QTFacWpyckphUllIZjZ1NVk5Z2ExeDR5WkgzMjFuSW1rVmVGbkhnUHFx?=
 =?utf-8?B?OVNIZmpPa1Ixa0lkVThzSjg0b1VFczNCOE0xUzNESnVoOXBiVktwQ05WZVhD?=
 =?utf-8?B?cjByamV1NnhQajZYMXFoQnRDeS9Xa3IyaitFK1hDUHFDWDlWRWpzSG0vR2p2?=
 =?utf-8?B?bCtuMGN3ZFBiOUxCUXFWK2I3aGxVOEtZeUxPUlBzQVlyYzZwL0JjbGVHbnNl?=
 =?utf-8?Q?pmiTC8CGL5SWmDRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96115EDF90DE78438172247512E39021@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0b231c-2769-43a3-6bd1-08de5527eab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:51:46.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naf8xvMt0X707siiC9jwQulrMWGPwfa4S3TTO76NDkEbd1f5D1/fhdjGLUwZIIjqrH+ZTHzveYXotpeemjihc78WXJ4SdjUE09WFZRc7PPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDA3OjQxIC0wODAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBQYXNzIEBrdm0gdG8ga3ZtX2FyY2hfZ21lbV9zdXBwb3J0c19ub19kaXJlY3RfbWFw
KCkgYW5kIHRoZW4gcmV0dXJuDQo+ICVmYWxzZSBpZiBpdCdzIGEgVERYIFZNLg0KDQpUaGFua3Mh
DQo=

