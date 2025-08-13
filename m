Return-Path: <linux-fsdevel+bounces-57775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74010B25205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403155A4B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1328FFD2;
	Wed, 13 Aug 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBQIJKxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F62874ED;
	Wed, 13 Aug 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105037; cv=fail; b=DTgFKGZAhuYv5dhXiEhTw7dM8S8nRWsal5Y/pc7kUlqxl9tpAP13OAuUuJ0Rb+ieS7hmUypCOlZuW44yyCQJmi24kmhiTbDGN7eduszTP8g+fRlBmXpIbd8AXmnVVe68BsDmPpZXxexixTxoYzMDH6WJrRasPHLwBD9/ljtDWsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105037; c=relaxed/simple;
	bh=+UkYD9mOMyelcbwk9K4I8wSGa4Uc0bO2OdPVydLYaAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYpWRdkwCJMQosh3/T/GuUXiXRghjfoBWaVWTBAHVr5sKj3wLQNl+WM3F6VVIjmpKX6olPROgSBgwxTROMUpH0B8tc+D2uXuqm0KOE1DkCtLIZgQ0/2tUrqB5FubvuHknc5nJGHbFQCBKHB1qQitVEkA7qDbavRQiySqBAVelU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBQIJKxo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755105036; x=1786641036;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+UkYD9mOMyelcbwk9K4I8wSGa4Uc0bO2OdPVydLYaAI=;
  b=JBQIJKxow90ZBg91Hy96AIWpzj4ngnOQg1GwG/uRLWpsnf4Q8Z2/Cxtk
   Es2EVwevTaU5XgwTc36oAogcfpRv+J5eQPklX0STvmMKc60qs+Zh/uUad
   cQ0s7jsy+rSkUBshzut6g2Tec35N0uZqZ6Sowk7hlf6SVBmI1qrlN2SLj
   ghz2Azj5qbfx6qrHMzXkGUgyRkfYVSyWiPbnPgiymYoQ8/IFjl6gKKNw+
   3BgjuDpdtVnCqKoHX/np3Dwq9ZoLO0b756eiVXMRfGojWdnO1LmYGoeAY
   Xsj9X+YhVEupXQo0Of9a6lhDTLG4zLUfV5iKnWpksJmsLIXuyWCbHZuPV
   Q==;
X-CSE-ConnectionGUID: V5G9nRAZQbGmNrx3quD0VA==
X-CSE-MsgGUID: xV8DNwZqRwqMIU/otf0kxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56622677"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56622677"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:10:34 -0700
X-CSE-ConnectionGUID: eYaZF0pdT9OZHyr9TlPwCw==
X-CSE-MsgGUID: Of6zqfP0T0mBgamE1ClLgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165751104"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:10:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 10:10:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 10:10:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 10:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZKOiAkn/M2np3gv8W4CxlZ0K7vmzJPuj/OcMjUfeFSesoUUQZRwF7+at2I4/B3bWSfdIJv+lR6wx08+sq3g37kU7JK1xBBCmrgWIQ7Qq+d1YlADtZZWZvIpGOfGPgqAkcZBsDszRO/q3YcoQ/ULHx36Ee2AzAt/NRaT9v0HhcyNF058HiZYWTYEM8n/y46+X9vbLtJx2sX617ezh9pdU6NpEk0v8sETo/SJbXIwRmZpWo3LPoixYiJAzVt87TCVwu31L4Acs7qkJJUfHx5p9GfZHu8AzqBHK2aOazeg2FuNWpUcLhPB1m6khJuh99jyVl25BOxFEHGLG4O/A1Qbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVLWpJkoY4MEf7S23k56wjC7TVVJTADyDQeZiTj6NeA=;
 b=ejWM8gTxry7e6CdD0NZ9rULj4cgbXgsu38G7xQaMGyTtazrErQB2lGLZ6YITJTsfi+E+5Io+cy/6NWJDwc0Ox/cnR0IR4l8971EdsDz7KqIqf5cC3z8qPMesOHd4sslMUbAWZ8oM5EZvsice5bw7bk3wwQjl/yprnptTku9RL1VDsGwCQmd/zediEu+M5/oYLJ3mC9gr8VB1SPcGLpLxl80PksQRBEWwT5+hhcesVx5t/HzSvcd4BJW6ehthFyuAsxSbg82YEyOdWS0POS8c8veZvOVZAP7YslyDQVSpV5phyE6tlsLi9soM9u5vh6z2GhPzKzrWp0iT8sW7hrXuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM3PPF1939049CF.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f0b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 17:10:26 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 17:10:26 +0000
Date: Wed, 13 Aug 2025 12:11:55 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>
CC: Vishal Annapurve <vannapurve@google.com>, Ackerley Tng
	<ackerleytng@google.com>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<pdurrant@amazon.co.uk>, <peterx@redhat.com>, <pgonda@google.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <quic_cvanscha@quicinc.com>,
	<quic_eberman@quicinc.com>, <quic_mnalajal@quicinc.com>,
	<quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
	<quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
	<richard.weiyang@gmail.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <689cc75bee26e_20a6d929463@iweiny-mobl.notmuch>
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
 <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com>
 <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com>
 <CA+EHjTxZO-1nvDhxM7oBdpgrVq2NcgKrGvrCoiPqX4NPWGvt4w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTxZO-1nvDhxM7oBdpgrVq2NcgKrGvrCoiPqX4NPWGvt4w@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM3PPF1939049CF:EE_
X-MS-Office365-Filtering-Correlation-Id: 0480a450-b799-424e-4084-08ddda8c4c10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzloZjRRVjNOU3RiMG1VUWVTTWZqRGpDSW1GZkpOTEw3YnNtczlZZ3BOYWp5?=
 =?utf-8?B?TXAvYXFWUFRGVm1UWTl4S2w3QUdTVm9xNVFzNUhaQlB6aDM3ZEdFa0VGRVpT?=
 =?utf-8?B?cU5OOENaOEp5Z3I3QjkvaWpnNDdiZU9OZ2pIT2ZtcnV5VXBOQ2tSWGtQblR4?=
 =?utf-8?B?djE0cjJ2TkpkQzA4UkJLbkwybnYrZ09lQnh6bG11aDd4OWVPeHBCMzRSQm1O?=
 =?utf-8?B?S3B2dHpFZFVVTWJlN3FPYURDa29Ba09hUWtzMU5ZT0J5OGIwMXFNQjlVd0Zr?=
 =?utf-8?B?NjIyNHRmdkhjY1RFWHR3ckRYU1R1UE5jbHlESjFXUGJrM0ZJYXBFamF3MExm?=
 =?utf-8?B?VCtEZFRoK2VPQ0JQSm5PQ2VQNEN6bHc1OHB2SW5oNWN6WTdKeTQ3STM0Zmlq?=
 =?utf-8?B?a3NEQ3JnVUNtMVRNOC9xZEZlaGRoWk5RWFdYcXNJZ3BhbG56em5MeGUvOEhy?=
 =?utf-8?B?RlNmeXFNQzdmd1Z1RHMweHMxc1VtNW5HVnQvanJVaWRDTjhWeE51VXZqeU51?=
 =?utf-8?B?WVQ5Z1lWeWxicGhucHFvMEE5MjFzbkFJNVhnWEx3cko1VDFmQkh4d0xOY0Q2?=
 =?utf-8?B?UGxXRjJsd21sK1dSUWhlUjVNQzJPTDNOenpmZmY0M01MNTAwa0hTWUt5WHdP?=
 =?utf-8?B?TE9EYm5qNUk5Q25TaHVrdFJjSzkvaEEzcjdmcTM0ZjVBY2hBbmFudFBnNnBY?=
 =?utf-8?B?K2RKcE94cWUyZFdaU1ZieDVVaXRmTE0xdkd0N2tGUzNOUXQ5elRJZHd2UzNQ?=
 =?utf-8?B?REpRcERhZGZCK1JGdkNjbVhYQ3JZMlJLcnRIb05hbTJJVk12K1hVZ2FCcVVD?=
 =?utf-8?B?MnMxeForc3lJUFl1MUlWWktVUjlsenhrd1Zkc0pFWHBRbVE0VkUvY0JPbjV5?=
 =?utf-8?B?cWhXQ2ZNNUQ0UC90YTdZT2s5Ukljb1ZiUytRd2NvaW16WVhwTXJ2Z3JvNnFN?=
 =?utf-8?B?OUhSMlY2V1JoY0RMamlsS1V2bzBFaWZWc0lWSXN4VEY5SVdYZkwxN0lEOVQ3?=
 =?utf-8?B?NXlXeHFFY2xLODNFdXZSRWtiU2x1SjhDZEpFNVRwVnh6WGZJUkYzK0VNanpR?=
 =?utf-8?B?dnFlQm5ENGJ5UUZ5NDQzYXBXK0VkZitVaTd0TjBVNGRNNWpxTDBBcmVIMFhK?=
 =?utf-8?B?VTRsWUFwb2NvVHRCTmFXVTJuNk9wMVp6dmIwMkNNNFF5YklvYjdLYXBQTG9r?=
 =?utf-8?B?Y1I4dFoyRUx6YTJzV3RmSm5GZ1VLS0J2MythMnpHTlVuL1d3cThwNTRsUnli?=
 =?utf-8?B?RzgycUgzak4zTlBrSzQ0WXlGbFlTQWo3cFFPdWpQcHlkanQ3UW90WEdBRFIr?=
 =?utf-8?B?RjB0dUViMW1kQnAxalJlcitRbDZCQTNVQURQVnQ4WWVkQTQ3NUFMRDFJWHlx?=
 =?utf-8?B?ZXB6M1RTdjJrYVV6SUV1TmpZVlB0M2hKNkMzVXNKTnNVQ1ZMMTd6ZzFDWW9o?=
 =?utf-8?B?Uk85bkROUVBzZVFRTkhtSWl1Z0pVTThPRXVlYlB3cW5hblg5YXVwcEg5Y3Zi?=
 =?utf-8?B?UFlBY2hEcy84ZWpCT01VcTlXNzZ1MFJCUWlCWldtMERXMnF3WTlVZVhGOXFC?=
 =?utf-8?B?d3VVbUhoZmFsN3F5blRSU1VReUdGYUdVei96MVVETU5LKzY1WGtlVHdFRHJy?=
 =?utf-8?B?R2tid3lVS2RpODRuUVhKTUFKT3UvcUJRbGVmLzMrRXdtYWU4VFlmQmxBVjVo?=
 =?utf-8?B?elNQYittWVcyNzM0NVlZckJXdFZDY0RLYWNEQjVCRG5QR1hndVZPclNLakxn?=
 =?utf-8?B?akJoS2RDSk8yalBQcndITkJSTzBPL3I5a0ZDR0htUjRnTWdRaTZiaXovb3hP?=
 =?utf-8?B?bURDWkphSkNvL1FMaEM2Sm0rbUxsMXpRQm9YTlFvalBSbEZFOW8wQVVaVkRC?=
 =?utf-8?B?dXFsWHo1TTkyd1ZPcEVUQ1ZvNGxrOGtvSzZRazFjMXlGZklqZDFsWXpwT0Ey?=
 =?utf-8?Q?g6QKReRhyPE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Z0OWNrYnhZcytKbVBtNGJWMDBVcXRuUTlFdUFRSGdPeFUrOGVhQWlBaVc4?=
 =?utf-8?B?b25NUGlDUHI0QS91aUlkdS9pN2krY2VJRlVpRlZKUXJhVTFRdDBZMis4MExL?=
 =?utf-8?B?SlU3bHRkMmJGNU9vTEFTRGJtNWZzY1dVQWNKejVQKzIyWktWRjV3MlJPNEhQ?=
 =?utf-8?B?eENXVktQYlc3VG54eDBnZkh5Sm9PR2ZJOVh4N3pPZWJXZ3VXcU1QWTlEWVc5?=
 =?utf-8?B?YkM2amdQZng5bVpDSFJVam9qbFVwTFF3NzQ4Y1huSzFBLzg0Vy9jKy9hTnV3?=
 =?utf-8?B?dXRSaXVSOVNiUlYxVWY4OXBINjBlYmlxNklyOTd6ZERzcnJVZE5vdnJuYXZy?=
 =?utf-8?B?Y1pEZUoxOFNDTWtERE9XRWQySGdSc0piTWJ3MHl2Vzc2RnFmb2xhcldKZllk?=
 =?utf-8?B?d1Foa3lDZWtyTDcrY2N5bFVWeSs2RjZWSTFCV0tlR3YvZkxEL0xva1hUOG40?=
 =?utf-8?B?eFBqTFNSQmhqSEQyd3pFYVZJTWd1VS8zQnJRaGlYYzhza0kyWlNYaDB0R2hZ?=
 =?utf-8?B?ZDBhVC80SGlEc2VzM29UYTZLRG1SNnRnMDFWUVIxR2pPU0lWcG9YK01oNTB1?=
 =?utf-8?B?ME1kZHdMRm4wTzRBZ2hhUlVwYnVXNFZwNUZ0RXdVR2haWWNBWVdIY1lDQmwx?=
 =?utf-8?B?RjRCMWZNRVNyMnJ2Vi9CRTkwU1RqUlhKU0JmdEpDUjdVNmNRQWU5OUJnSURx?=
 =?utf-8?B?eEZ1ZmdLNitlUjUxekN6b0VWSlBjcHNMZWFSdmIvMUw4VmNLMUFzWXlsOUw5?=
 =?utf-8?B?NUZBYWxDRHZaSENocVVTSVVZM0lmYXJkQW1oYTVlSW1GRi9EU2pmelhnUGVZ?=
 =?utf-8?B?RGNwWWxhMlFHT0huRGJpME1XQ255bnNEZGZQWTFvQzhJaHVSYnRUdnRIVm80?=
 =?utf-8?B?aVJFSmg0REN5Ynh4bllzd1FaelJxSHhlT3JWbFVTUVpwdGg3Uk02emtFSGpu?=
 =?utf-8?B?ckxZUlVsQ1c5T0d5YlRrMTc0aUdicTUxOTZhSzFYT3I4SW9TYnVnSEFMdmRD?=
 =?utf-8?B?MXRHcGl0UktEU1I4em5QMGZGejNwQVZ3cm8xTk5pZzZGQUhQOXRVU2poY2x3?=
 =?utf-8?B?K1MwdXBiK21oem0xdWE0RHdvMWZyQnNvVkdmb3grVEk5VFBNOHFBQTV5UXVK?=
 =?utf-8?B?cnZHWnpVY3QwMy9hbThZRjF1UHVtcW5rbkNXdmZ1RHo3cHlydEp5K0pOem1Z?=
 =?utf-8?B?a3RoVThISmQrRGUreHMxUXNmUkxzRytjNXFNQzkzUS9JU253YlVxcE4vRVhJ?=
 =?utf-8?B?YVBWV2JQMGgyVWhpdHg2clFyQVFrS1c0WjNYMWczNFZNQzFCL0l1K2pUOXRs?=
 =?utf-8?B?dkM2eXp6MDU0NVhxazViWGpSQnNPcVFTSE10UnBuV1lFNVJqM0p4L2k5SXly?=
 =?utf-8?B?NHBEWUZVbWlMLzhFU3NISG0wK1hRaG9oOFBrWVZ3RlA5RDZXZW5zZVd3WGMr?=
 =?utf-8?B?N0EwWnhNYnVva2FkMk9ObW5HM0ZWY2oxZ2JMUW1mYnNWazcvQU1iTHJueUd6?=
 =?utf-8?B?c21DK2NyRlhjR1dBUWFnK2FKSXNOcWxDdkZRZVdQWENGaU9jZjJsT2NrWDFj?=
 =?utf-8?B?UGRlMzg2dko4SUQrMS85M3VJOHpQQ3VMdXlyR1BBYU1uWTVsV1cvenluZDI4?=
 =?utf-8?B?MlNrVGJSUVRpZ3pCZG9TMDUwYzhSR04vMm04YzF4R2dGYjViNit2bC9WaU5l?=
 =?utf-8?B?WlNkMzJWdE1ISi9sbU5zTkxqSiswYUlTelZVTmNveGExUTBQOUU2MlVEUjhM?=
 =?utf-8?B?WE9MNWdmZzU3L0FkTHljZGYrUldvV29ZUEhnZlhLU3I1MGxYelJ1NFpGS0dR?=
 =?utf-8?B?TGNJL05TclpmSy9YYkpZZnJ2d25mR2Z3S0h4d3hLdlZYai9NaHhzODBmdExF?=
 =?utf-8?B?VE9kMjFNU3dIWkYzU1pQczRJVjdJdUU0clBJS0dGeTFBdzhIUmlpY1F3RnVq?=
 =?utf-8?B?WXpQU3NRN3VkOCtIS2NrcEVBV1JlSGl2WUVLYjMwSE1xNXVGUjR4K3FDUGwv?=
 =?utf-8?B?VDROMk1McWxYMU9zVUFtbW5sVzYvSUlSSzFiTWgrLzVldXdVcDNOYzJKSjRq?=
 =?utf-8?B?ZmI4dlA1OWJoQUYrL1BwSFlndU1nQlpSZnM1WVViVG5sR2ZKb0ZSZ1krek1D?=
 =?utf-8?Q?GK0XUIBM28CmxWOXA2FKBVG9H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0480a450-b799-424e-4084-08ddda8c4c10
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 17:10:26.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBDG/LLFZZXS1LShQ3I2P4cKkfqvE4JEdAg7C8OPlBYbo5/JpB5azeUHVQNG2/Od+ORK5h85ufo1O+X2VtPdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1939049CF
X-OriginatorOrg: intel.com

Fuad Tabba wrote:
> Hi,
> 
> On Thu, 3 Jul 2025 at 05:12, Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 05:46:23PM -0700, Vishal Annapurve wrote:
> > > On Wed, Jul 2, 2025 at 4:25 PM Michael Roth <michael.roth@amd.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> > > > > Michael Roth <michael.roth@amd.com> writes:
> > > > >
> > > > > > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:

[snip]

> > > > > > The mtree contents seems to get stored in the same manner in either case so
> > > > > > performance-wise only the overhead of a few userspace<->kernel switches
> > > > > > would be saved. Are there any other reasons?
> > > > > >
> > > > > > Otherwise, maybe just settle on SHARED as a documented default (since at
> > > > > > least non-CoCo VMs would be able to reliably benefit) and let
> > > > > > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > > > > > granularity makes sense for the architecture/guest configuration.
> > > > > >
> > > > >
> > > > > Because shared pages are split once any memory is allocated, having a
> > > > > way to INIT_PRIVATE could avoid the split and then merge on
> > > > > conversion. I feel that is enough value to have this config flag, what
> > > > > do you think?
> > > > >
> > > > > I guess we could also have userspace be careful not to do any allocation
> > > > > before converting.
> >
> > (Re-visiting this with the assumption that we *don't* intend to use mmap() to
> > populate memory (in which case you can pretty much ignore my previous
> > response))
> >
> > I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
> > userspace already defaults to marking everything private pretty close to
> > guest_memfd creation time, so the potential for allocations to occur
> > in-between seems small, but worth confirming.
> >
> > But I know in the past there was a desire to ensure TDX/SNP could
> > support pre-allocating guest_memfd memory (and even pre-faulting via
> > KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> > fallocate() handling could still avoid the split if the whole hugepage
> > is private, though there is a bit more potential for that fallocate()
> > to happen before userspace does the "manually" shared->private
> > conversion. I'll double-check on that aspect, but otherwise, is there
> > still any other need for it?
> 
> It's not just about performance. I think that the need is more a
> matter of having a consistent API with the hypervisors guest_memfd is
> going to support. Memory in guest_memfd is shared by default, but in
> pKVM for example, it's private by default. Therefore, it would be good
  ^^^^^^^^^^^^^^^^
And Coco's as well right?

Ira

> to have a way to ensure that all guest_memfd allocations can be made
> private from the get-go.
> 
> Cheers,
> /fuad
> 

[snip]

