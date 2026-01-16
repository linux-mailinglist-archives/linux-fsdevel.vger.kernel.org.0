Return-Path: <linux-fsdevel+bounces-74197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAACD38401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92C23018D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC073A0B1D;
	Fri, 16 Jan 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jlf5NaEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA223EA86;
	Fri, 16 Jan 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587015; cv=fail; b=di0TuJ5ZbZhF9rYcDYG9aoh4FTLDZ02+rHDkkiRC+DeVga3VIESpLmmh+6sj/6DnVq31y5F7J3bd5Rj1IPAOXDYTVwhQk7RBYFgdr4KPEwsQ1Ul/oSrbY+25UkdGzUV5ylM+FQVBJoqB/8gi6QIn6L5jdGcvhaNB4G9twJ2upKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587015; c=relaxed/simple;
	bh=n+j8Jb7pzzZTaNKwufFIRcPIsc3hxN0HZQChve3xxi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOydX5N9dawSwWmgiBTR8NQ7rDu5Fyr/pEub9qAc2Y5p1mtWz+MqKLN3MLqCLL2BOpCjoRM/xBf7EjLUHwSd4dwc3yvX/d4b6JxHe/3yzSvatUPZv7Z1H3fe5xLDb+TmmciJ4/5fyhguFNcA+J8LYlyncb1aAEppK2Wd0/VhFik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jlf5NaEP; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768587012; x=1800123012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n+j8Jb7pzzZTaNKwufFIRcPIsc3hxN0HZQChve3xxi0=;
  b=Jlf5NaEPSfP9PePlt9VZqiEQmuA9tqJIEH4sXSPTAYu6mEaXkLKQs563
   LwrdlYWoa9p8DOBKrbOwFChBMJSgWRjMaYuVUElBAz/Q9ObDOh1z5H0W0
   sERirsLK7pWe4kJA1JvfoCYI3VTxU/dmrph0m0WHRRhmOIeo1ZtA+WZN5
   fLQ/uW8F5KAv0M8lOyblzyVBeY3hYVKk4fG/Kxv/RXLVnb36eRkJxKtFi
   62K4r71VvmKEo/5UWOxXitjiM/3XPQU/q3zN4VLlgcIQVbkOHSA+Vkw1P
   tp/YtlXoVOZqtXhlW/WYFO+QI+lkhBeTbP3NHsg+xXZXiag4eK6w8sY2P
   A==;
X-CSE-ConnectionGUID: lODv++51TrKYQiyTJPC+Xg==
X-CSE-MsgGUID: stgTDBJTQgKylldiEJSnFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73750836"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="73750836"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 10:10:09 -0800
X-CSE-ConnectionGUID: /Cbh8zH/T36C/4PSGw+yFQ==
X-CSE-MsgGUID: M3RZpiiKTlyeyd6rQEjLqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205335177"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 10:10:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 10:10:08 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 10:10:08 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 10:10:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToMsq0IpEcLVEtpuSWAMccUgWE2/YI+nEPKpAxRfgmxZ/8jPP4WY1YRR7ZwrLlyPnXWTa3xjWv/lEvPgOs8igKAcUTq2PNoZtganQBDj/ZGSCn788O+OOG8YNfT5FaQYdCqaNrhio5fpeHSLDPLpWrCBOYP0rDiFV8HqNMvK8uMpPaWzwXY2H/OHpCAxABHIaMRzP0dINIeeKMu5qHEgvwZRtupylI8/5Ld9aW2X81PkxfOdel9Oox9+jB3dF8xghlw10rCg84GWcJnTV3da87FxQlm5GXPc3gSGzuqRoKqfht+4SkKFTCvMbqSgwIH6x3LYsMiSVza/4Qd9zLgcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+j8Jb7pzzZTaNKwufFIRcPIsc3hxN0HZQChve3xxi0=;
 b=KV6B2tl7Ky3mbRB22+2u9zXG3/zO9TAP0Js47AdOlQSHzd1u5L9DWLoJ5hQ4rmLEH8YKbxngG00Hz0yP0aJG5KCGMu1sSowN4n289QUz+P5Js85FeEaurUkAFgFrt3cwNaHmg+EuTXhJsPweRV9/hx4zM5H1b5CEHcq9LNTd33QTZLG0fazjxHZ97/uQvfphxctlIVNi+0LWzYMvgHsGDGpXPyokaQIrjtqQm5bpbCy7F75zXlQxyN8pue1T/zX+oWUxVHKRgGFqf7CnoUqxmavdMqIRNKlVNj1ZZY3h6MIumRK1mdJ9gcsITfDlkMXyIXbyuo9VjSajCdJJ+hLcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 18:10:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:10:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kalyazin@amazon.com" <kalyazin@amazon.com>, "kalyazin@amazon.co.uk"
	<kalyazin@amazon.co.uk>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "david@kernel.org" <david@kernel.org>, "svens@linux.ibm.com"
	<svens@linux.ibm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de"
	<pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org"
	<maz@kernel.org>, "peterx@redhat.com" <peterx@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org"
	<luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "peterz@infradead.org" <peterz@infradead.org>,
	"oupton@kernel.org" <oupton@kernel.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jthoughton@google.com"
	<jthoughton@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"itazur@amazon.co.uk" <itazur@amazon.co.uk>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com"
	<derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com"
	<jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT6T2AgAD7kQCAAAm5AIAAH4kAgAACwQCAAAPBAIAABX0A
Date: Fri, 16 Jan 2026 18:10:02 +0000
Message-ID: <a84835708eb92d99ba524149bde819c4ba944cb9.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
	 <294bca75-2f3e-46db-bb24-7c471a779cc1@amazon.com>
	 <bb58a21f91113ca39f8888d718d4450a5fd72808.camel@intel.com>
	 <318407ba-ecb6-4691-8911-645fb8c20250@amazon.com>
	 <c42cc00f3902673b1a964c3d098b8c3f236cf9a1.camel@intel.com>
	 <98b8ea1e-3bdd-4987-8acc-58112076d451@amazon.com>
In-Reply-To: <98b8ea1e-3bdd-4987-8acc-58112076d451@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6168:EE_
x-ms-office365-filtering-correlation-id: 06345658-b1ce-4312-60b7-08de552a7867
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?Qmw0Q3BGQTErWTF6ZWJTZ0RZSlluR0lKQmJRa2M1U2psenZISitBdThlUnNW?=
 =?utf-8?B?dXJTdmY1Z0pwQTRXOG5UOGNad1hFalVIOGQ5dDNvWW1CVXdLK3BrdzJkcjJl?=
 =?utf-8?B?bDNNL0xEcmtIdFZFeTdIMVIyaGtTRi9MYzdpWXBZMStWQWd4dStQNUVQRnpM?=
 =?utf-8?B?OEZGbTM4MDFKZ0dKTDBwS2dlRC9YQkRMZDdpUXYvejZrazdrVkNSTk5UODRB?=
 =?utf-8?B?N2RGT1NBUkt0TnNjN2RRSElqbVp2U2ZtRGRwdWxOeVZYcHdKVGFpei9DWFYw?=
 =?utf-8?B?TXNCYXZqNXBlV1dMNE5SeUNZS3JaOE9MOE5aT25IM3RiV0I5WldhVGNtK0Nq?=
 =?utf-8?B?REZrd0VHN2M3TDJWbHZRbHNIOHVNZDI4cDVMSGRHQTNxSjNZVStuYzZoc0RU?=
 =?utf-8?B?U1RQdlBMUlBIR2hUS3NaWERHM2hHZ3FSb0JSaDFLbjVTL24vNnlMMjdkQm45?=
 =?utf-8?B?enBBOW5WY2FNZUJEQ1Z3TlFxQ0pYVFlGZkVZTGVuQ3IrNElOS1o3U2xnTGdk?=
 =?utf-8?B?eWVzUy9qdnQ0UjZmM0tjU2dvZVp4eklpZUZ3WHdZL1FVRHlXSlNqUmtNd2VQ?=
 =?utf-8?B?RnZPR1MvOENEdGVFLzJXRU1zQmh1b3VmbEhuSTRpUDRDZTNyaDloVHJmeFdP?=
 =?utf-8?B?RTZDeGRaRWNPVFpVS2o0MkFkQWZjSW5RYTBpN3NPY0NRRTh1ZzZwTnZjYk5n?=
 =?utf-8?B?aTQybUprb0dWY0hFbStjajRBblVIUWZpK2lEcU1BWG5RRThnVjlFSWZMWnI5?=
 =?utf-8?B?d2k4cFJ6MTJWamw5L0QvbTd4elFRRkJTYWk3dmtMMWxIT1gzejJtT1lEaTNr?=
 =?utf-8?B?Q24yZzJPVjN1OGVyVEU0U3ZEUlZpeXJsRkFCK3M0Wk11RURWeGMrdTFSYlRL?=
 =?utf-8?B?TzMzcUpMaU9kcjBQdGxoU1Q3aTFCKy9venZzY01QWGFTN0xhODlSTUtHOXJY?=
 =?utf-8?B?YksvT0VpeDZ1WkJEODJQMS82UFl4MWNHL2tEa2V2b2V0bTV2ZlU0L2NpZnBq?=
 =?utf-8?B?eFRyNzhoTE5xNnNRVERPT1dZWU1FMEFnTzVtQlBNYndLazl5Rzc2cHE5TlhL?=
 =?utf-8?B?eHJxRTd4N1hwblpnVC9ja2RJWUdwaEdESHF4NTZGL0N3cVpudU9FQi9BQ0tP?=
 =?utf-8?B?cVAyOG1NeGtTU0tCNXU4amFtL1BKY21MWnRCZzQ5ay95dmJFdDd4UmpRUXFn?=
 =?utf-8?B?c001b3dFTXJWcGFwSUpWU2ZWU3d6dk9zZ0l6c0xpY3loNG85cGNsQ1lpcUlO?=
 =?utf-8?B?WTcxZTg0MVFDbXhXOTMzU3d2c0VoZnZ6Umx5akcyQ21VbWJIN3ZCSXhzdVpW?=
 =?utf-8?B?TXkyc1BONVRwZmMraFVCekVPTnhCaWZVR2lTb0ZvQjRheVFxTzhtRTh2djA3?=
 =?utf-8?B?cVkyUmlIWVhyU2p0WkpPWEl3TXlxVGJJSktuemZtNHc3MWk2NHgwT3R6U210?=
 =?utf-8?B?UzN3V2l1TkNQVjBhYzI2UjlsaGhRWHh2OEx0b0o0ak5JRng1NUdlNElMbW4y?=
 =?utf-8?B?Y3ZpT0FzaTBDNHFtRFpndzZ3OXBrbXR3UWVqVmErVCszVGNScUpDY2oyMnk5?=
 =?utf-8?B?MVZKTXMrdUZqbXppMHMrSjhld0hUOUc2UkRIV3c0NmJySllZdEI3ZEVxMXFB?=
 =?utf-8?B?YnJpRzVJSkY3V0V0dzhwV3hVRHpKTElEUzgwL2FHK2diRlJNVUE4WnpkS1RB?=
 =?utf-8?B?ODlBMk5kL2tOL1hkSjVRZ2dUbkVTd1NSNnZaSnR2U0NFajBrOGQxdVFiZDhS?=
 =?utf-8?B?K1JJZzJWM0tRTnZmSkdHSWhjSWRXRERSWmtoTStRWXF2Q3FGRnRQbTAxM1NF?=
 =?utf-8?B?aE5qR0k2T0FqOWhXS1BZelJ2UmVwL1FTTDJqd05rYllZcXVBalB5cnhOOHBr?=
 =?utf-8?B?NmNEeG1ReG9BU0J2SlUrZlZXNFB1WnppakMwSGY1Y21LVEtHOWV5MUZmZnpX?=
 =?utf-8?B?SC9FSzZGL0ZJOUJSc2lIVHplQlRJTW1hVDIzZWIzY1JZZ0dIQnpaZVN2RWtn?=
 =?utf-8?B?R0dIdUl5d2JSbVFCTHJaZTJyQnlPVThTTmFLL0ZLRUJMMU4wcmp4SGZDYW0r?=
 =?utf-8?B?S0RFbW43c1FDTSs3bnJYdVRaWmZLakdlUHdleEJ5Z3paY3VOZDNqdVAwcSt4?=
 =?utf-8?B?ZVRkRHhRSkpOc1ZyZFRJcHhRR3pQN3NsSUNFdzMzTjlOTTRmSnh3NU9SZUtR?=
 =?utf-8?Q?Dnt9sK81MLA2iSOkLTwolFFTbnKL1WnfeMnxyMElWfYl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BlOWg3MXpkNWtIU0picm9rRU5hQUxpZWd3alV6c3NKaFBXQVN0Wi96U2Z2?=
 =?utf-8?B?WjBSVjBZZlZkeXZiSjhzMXBuNTZ5NWxOK3lpczVzaURMUmIrdnFwMmxTOGwr?=
 =?utf-8?B?MTJXczBVOXhaK29veXpPYXA3aVg2dEdRQXVKTXI4dkNpOURQc0NqR29YbmhZ?=
 =?utf-8?B?YnhMMDVTbG5PQzlmd25BWDFINnVIcGZxQVV4YU1SN2t3a3h5ZjVad25pWHZn?=
 =?utf-8?B?UmJEa2hpNFU5VFA1d1VVN0lnZGlkbDkwMURMZ2ZOVmx4T2hFN1JBSlVGQVM3?=
 =?utf-8?B?VzZDR3phemdXTkZGbVhZYW45aU0zZ3hpUXB2U25oY1AxYUNYVnNlejJ4QzRU?=
 =?utf-8?B?d252V08wV3RiTDhjdjZuRmViZnRlelppNm9qaDFMc1dzdWJZUWpWeFc5Zmx2?=
 =?utf-8?B?cm03NnpUS1M3b3o0M0Q5djd5VnFCZzR3Ykp4Vkc5YWMyQTZMZUM5N3l4NXBj?=
 =?utf-8?B?bnBhajJ2cXJlSkJPZjVpUlJCMFZ3blJFMm5sYytqK0lRYUR3bG1uRkRpWmJ3?=
 =?utf-8?B?ZXNzL0NtR2RlbFNrNkVseWpKeDVVcVV5a3FpcnhaZFFWRXRFZkRFSkg3Tlg4?=
 =?utf-8?B?UUkvc05HWlJucmRSRzE5UXF3SHZ4WWFKcGcyOGNyMjlobWo2WVcyNVEyOWNy?=
 =?utf-8?B?ZmVVc1phZEhKTmVSbFlqSXN2d01CY0FvRk51MjdZcFhOY0xvSXhCY3VEc2dK?=
 =?utf-8?B?K1o0VVRvb1dtdjZ3NjBEMnI5aTcrNkx1cTRxckFyUk1QZGtBMU53eFRPSC9a?=
 =?utf-8?B?ajQ1WmlQcHFFaG0va2ZwSXNMem1mZWg5U05NZnhmOG01TXUrZ3pkV2VMMlFu?=
 =?utf-8?B?cmFSL29odkcvYUV6Z00vZ0RRcDU1YXNaUFgwNnpXK3pKM0Vob2xpLzVOcFpv?=
 =?utf-8?B?c1p1TFgzNVJncE1kb29pMFVCaDlTYnNVOHZ3UTNqbTlNZGNuOVRZSTBkZENC?=
 =?utf-8?B?c281SGVKUVVxVXBkTVMwYVpZWTgyOUlPYVdqUmpRKzA5M3IrWmdJaFZnbklB?=
 =?utf-8?B?cVc0bGhKU3pVVExMa2dTT1F5WFFMcGVnTmdzckw3UWw0YVpQRlJBdE9UZ0tn?=
 =?utf-8?B?OE9DZ1VvaE9yRTFIQU1NMC9QNVQyVWVDby9KRG9vRXVZZVByWjB2a1hlcGZ2?=
 =?utf-8?B?SzNJMWVRUWN5WXMwL0E0M0FPNGlGdTRsQmhYWVN4d21TNklXNFRNb0ZWMzc4?=
 =?utf-8?B?SzZKN29yMW9hMHlSaTI0V1JsVnAxb2h4djVqWXNGOFlPMUhQcnhOaHlPbGls?=
 =?utf-8?B?Y0E4cWhUd0M4aHd3d3BFL1RtTDdKdVg1M29PbG5sVXR3R0p3VVNSZ1RrbDNS?=
 =?utf-8?B?Z1JaYWlPWlZwY2NOUEk2eW5ZMlM3VlZwVVFlMk9hUGlMUVpPbEZDRWRlT2dT?=
 =?utf-8?B?ejlZdzJtWjRJWXJDNlZhOGh6TWhQRmhmWGxzTyt3dFcyWDVlVG1GSTlBSVcx?=
 =?utf-8?B?R2dhbVA4eTJjK21aQlZEQ2s4U2Iycmo0cjR0OC9zaTBrUUsrd052eUdibUVq?=
 =?utf-8?B?cVYveDFOOHNob3NzVytJQkJHdWZPdDJyazRDaGZnRXBaVkJYU1M4blYrOENx?=
 =?utf-8?B?UGVtZmJuMXdSTVhRZXg2WitZeS9NWXpXZDBYbE55UFo1VGZIQk56Q3VNZjVW?=
 =?utf-8?B?N2owN0dyVjFqdFAvVHBjMXNCaGlKSGV5dW8yRjgxaU8vM1M2QUo2d2dqcXhL?=
 =?utf-8?B?ZDl3NDBGeFlGTzZLZUs3QndwNDlPbzRGS25jei90TElBby93K2czVEdiOWhy?=
 =?utf-8?B?eUFvandtNG9HSTN3Rm14K1RrM1BtWHdzZDE3WElsbGppWTMydzZEbE0zSEtr?=
 =?utf-8?B?NnYvNGpKdmNrQkkwZC9iNDBtQTV3QmhCZWpDU2JwdENnMU01R1dUbHdsUU8y?=
 =?utf-8?B?RENDcTIxd1VESXJYYUhHT2FjdCtxZ0xsb1FzSVg1em9HQjFiQ29IQTB0QTBo?=
 =?utf-8?B?TERmNjNiT3hzZDF2eWc0Si8yZTcxSXRtVmpmTXR2bTY2ZUpmKzk0MUQwMyt2?=
 =?utf-8?B?dVk5QUttQUJiVGVUMTdmVmJqUVpQdzFXZXpEZzZVaFdTbjQ3VEJkZldpa01N?=
 =?utf-8?B?dG0yRzVpbnE3RDlrOFVGV1BVSmVNV0FpRmRyOGs4Q3dSQkp5WGxONjN6czVS?=
 =?utf-8?B?QjcydWhGK0FET2tLMEduZlVUQUI3SW9iUGJOVTdGc1RwSnhUb1ZOM3lzREoy?=
 =?utf-8?B?WkhPdGszS3h3VEE3Y0VsaW9Ya3p2WHQ4Nldrd1BBSTdwclNIdDN2aTNFcnRS?=
 =?utf-8?B?anJlbTk5cmM3L2R2M0xiUm9ROUdCN3A5Z1cwR3NMckp5VlljeERvRVJ5YTNQ?=
 =?utf-8?B?cE5GVFJQT21Bc0s1VjJ2OEJNaVFmcnVuUGgzTWF3T1lTM2t0cTltdktqZUZQ?=
 =?utf-8?Q?xIXNIj8wnFGh9mE4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70AB1C6FD4E1964A95109CC6645278CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06345658-b1ce-4312-60b7-08de552a7867
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:10:03.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o05B0u0QMLBshbYhauBBP2lNZYgxEPpUsUAIka//Rapb7dWLN9hFUJy4wpuJ1wwU1wBQSw+M9nCQdxqwL+rYk/NsL89TxECWx1+nIeabeB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDE3OjUxICswMDAwLCBOaWtpdGEgS2FseWF6aW4gd3JvdGU6
DQo+IFllcywgdGhpcyBpcyBhIHByb2JsZW0gdGhhdCB3ZSdkIGxpa2UgdG8gYWRkcmVzcy7CoCBX
ZSBoYXZlIGJlZW4gDQo+IGRpc2N1c3NpbmcgaXQgaW4gWzFdLsKgIFRoZSBlZmZlY3Qgb2YgZmx1
c2hpbmcgb24gbWVtb3J5IHBvcHVsYXRpb24NCj4gdGhhdCB3ZSBzZWUgb24geDg2IGlzIDUtN3gg
ZWxvbmdhdGlvbi7CoCBXZSBhcmUgdGhpbmtpbmcgb2YgbWFraW5nIHVzZQ0KPiBvZiB0aGUgbm8t
ZGlyZWN0LW1hcCBtZW1vcnkgYWxsb2NhdG9yIHRoYXQgQnJlbmRhbiBpcyB3b3JraW5nIG9uIFsy
XS4NCg0KQWgsIG1ha2VzIHNlbnNlLg0KDQpEbyB5b3UgcGxhbiB0byBtZXJnZSB0aGlzIGJlZm9y
ZSB0aGUgcGVyZm9ybWFuY2UgcHJvYmxlbXMgYXJlDQphZGRyZXNzZWQ/IEkgZ3Vlc3MgdGhpcyBz
ZXJpZXMgZm9jdXNlcyBvbiBzYWZldHkgYW5kIGZ1bmN0aW9uYWxpdHkNCmZpcnN0Lg0KDQo=

