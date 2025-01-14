Return-Path: <linux-fsdevel+bounces-39108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE78A0FE93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06321169EAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845923098C;
	Tue, 14 Jan 2025 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZrJhxPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971BAD27;
	Tue, 14 Jan 2025 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821037; cv=fail; b=uefcMl4jzjOu+yCi4UUBtoZp/6iV9WEKlKUORUbAOY4Uk/aizoHUADGBzuxZlk3+S1M6krlkvnOTxx9pE3BJGja69PDKmRtLFnLdFTJ1nshBvnkg6f7iloRucmwzy9v1bbVxiYJGMezrIw0pWyBsBW3X+DmLctO2m/jaP9Fp9S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821037; c=relaxed/simple;
	bh=dEYTSAlt9VO2iDDuVtLevqxTBnrZktPoMKb3hUUP/4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/wtJm/orBtpNtD5bg8bYeAevW0ra5V1e8CNv7Es4dXF5CMvToATQW507cJ20PIxOUOhm2PI0PCVrpWWjLXlYeMTsqwOBAhXJE9zfn3+gZV00LTRWWnpdx+VAmRwgj1x74DR+3Y9aStEZzXOqLFI1bSoZU2scNcNntxkKvefe6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZrJhxPc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736821036; x=1768357036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dEYTSAlt9VO2iDDuVtLevqxTBnrZktPoMKb3hUUP/4I=;
  b=mZrJhxPcj7kegkaIRvhNwnayT2AZp5vCpHDFEAAvNmbTm37y7X+zAGgs
   0UTlIh4dbI0LJA16ScAvrdxsw7yEok302w/caIMOqbzAEl8VB72u1skz5
   nlTMVbts8ZfvOfqQGV/jYEsGvpm7iRrF6EHsoEVqxeyMfmmwa6FN3bjW+
   cBiVcNiJ/ttinD926U3eqMsMPFkGsbA7zsUuQjHH3NY8AnlTYJjReFNdk
   QP9/GYCjm9wUVzBtQQSXkjJ/JUKTUfSjlgp+kLzTRoA36Rv+YNFO7Dvd5
   PwWK1ETZqLCBlSV3zeh76UmZDP+3XwnGsNvEGKSowBi0nvVQSfKEVFiOU
   w==;
X-CSE-ConnectionGUID: qoHq8r+wSKOvIrojKCkpYQ==
X-CSE-MsgGUID: ZutpXmJpS5atB5rCbk2DNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47595540"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="47595540"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:17:11 -0800
X-CSE-ConnectionGUID: RSHIJIpHStmfkH66EClzjg==
X-CSE-MsgGUID: wQTJnQSPRXa68Na9ievzSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104433169"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 18:17:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 18:17:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 18:17:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 18:17:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA55TWnscC/3BAQPpe0tbfhSdTnQwke71hjz4+U+L28wGQ7rHgoa4THoU1HnwdxhVaFZXEGoKXtKeYd6DypADBvpRna3fF1IZ9imrl6YqrIrFO0Uec36jEOLjgRKE8pEovTohiXJnfcv87I4UEPp4qPB0RwX7p96+7HcrjgAuLdq3v6MMITJXg+NguIBoUmtvLnOC9Glw75sKUel0b9kEtrsEvX3qigJwaBMCqTz4jNQpSaqneELWahbruGGeCKU5nGuuZm9T3+dZX5ccuzhADfarZtqZ94JVFN4vBTBbJjIqYrO82aGMXrxSHon4yNzpJovSd3E/XTyTwAKBHWlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvPQ+fPxu9/8Mwfj6PzqbgmO7XfngvRA8FwjuabHsJ8=;
 b=gJXT4fdtJooRMzt1bgIjGzrH6eLCx1WsbM6rOhZVI7W5vHQISi0FjoZw1EsZ6lk68v6O9Hm2yhyDsaZR+xr0A4EXL6cvEi67e8FfhRyOIqHTmMI+g5wxqyXx2uuGirmzREKp55RziuwrldTJ6A63xENc+5cbPs8nU1Ia9ZcTj2jsgw4oJuBDBoQBT+n5+vYkkRE3Ph5TTKAC1paPEKxBF7tClWVSAmoT+/m1jXmlNm1AZvLx1w6F3Wegwl36+TvbEot+orjCN2CE9BHa3jM9k37gzH+rHNxqiiAQN7I//ASo2ALzOtB6T0cBP6siT6pkxeDAHsdZoo0dhtIFpyXEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:16:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 02:16:26 +0000
Date: Mon, 13 Jan 2025 18:16:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 18/26] mm/gup: Don't allow FOLL_LONGTERM pinning of FS
 DAX pages
Message-ID: <6785c8f6511d4_20fa2944a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b2af3f542813d357a08f07e396df2793822035e4.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2af3f542813d357a08f07e396df2793822035e4.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e59534-ca3d-4491-7936-08dd34417305
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wcsZxmCZGnxfcSGmt4tpobTD58Xxrs/zcrI32/9ojrsVxkKBrZr4OaunUnoR?=
 =?us-ascii?Q?yjKkX2cmGrwCTc3rJxZVdbIVcDpgFh1HjYVxBszhfn7x3SqVpZSOOIFU8/tw?=
 =?us-ascii?Q?KN4yh8IeVunIuzp7CCKVGTPRacxXqXawuBrPBGhh+rYQcsvuXEwe5EHOHMqk?=
 =?us-ascii?Q?DK0SP+LpI8kptV+TlNQrTLuHtH5PGBiX8uACkPrSYqVDPfoam8p+kjOeuvw8?=
 =?us-ascii?Q?6Ih0jLRpUZIHMrrpdCq5bN6pi2+XTGjyQw0pvR314eR9taQIHqoOV1QZx3oA?=
 =?us-ascii?Q?AnWYIZlsd46BPPZq/H3Pqu4mJdeU5EkC94+VcYBUb2lC82AvXAVFGWLvWr0c?=
 =?us-ascii?Q?/vkHo2c3jz2SUd7h5OSZDemW4CXsWp79QXACa4hH+eFMnUJs/Q7n8QZ1RUQE?=
 =?us-ascii?Q?KmlAhDC6nHA++K+2JS4tivBcYVHPqDPdqQP8aJjvEz2fukwY82LsoExHN3pK?=
 =?us-ascii?Q?5mhiFWuar/TA4oNkZ8E9kL7QGQ8JYhOnzUlTamioCx7bVcGv3JqPVN148REg?=
 =?us-ascii?Q?9soj6G7rNuWE1zAqG+90druOLv/bjeKISb/3K+T9n+6kTAj9o+3eIln1NWoy?=
 =?us-ascii?Q?+urr8mq6mE8hS1tOgWL3l+illscbM74JBmMqZI9eggUZ8wXFibwdHRKFN77m?=
 =?us-ascii?Q?6HR60fhO5QtbDW02hrrC/6ud5eEOmhRmyIQybCAUPkfR/hf61W3kEoaZjdHp?=
 =?us-ascii?Q?of29dnW559unvFVC8EVpJN2i+01+z3GSUFxffqevFMls/PPq1Ra0bI+7n9Gl?=
 =?us-ascii?Q?o+4AE5+bYI0w8ZXZxAMWC6JJBXb8R4Atahh+Mr7sj/PFAzD93VifjXvDm2+J?=
 =?us-ascii?Q?gXwhpO6UmExoo1Hc5zwQOwOy61mPAS/0VqQEUyukoaHheMQP2Nctw4ciX029?=
 =?us-ascii?Q?XpbhN7WPVYzcEo57ClHK2wns3/8xihbppmi+paJCSSHzKEJ4c8WMu6vdE5Xz?=
 =?us-ascii?Q?zxiEK9buNvLDIkbtV5X8wwn+bKivhQJQUJ+AlWUqS+qfwCkRDudv5pqdUs/1?=
 =?us-ascii?Q?tCmKzAkFPrYM+iQgTjtBARcheaGzm3q0csPIPKbx995CdiRA3aP3PQh1fLG0?=
 =?us-ascii?Q?WJZZjK9RzpynK0j210QF7VmYjizFI4muWnUpszPnpa3tR+bevGWs8eBZPyP5?=
 =?us-ascii?Q?FHxKsujqXAUKUHMWL/OrinRV7jsWeNc6aYilDNMSO6wuauX9FUdpUG2LUdqS?=
 =?us-ascii?Q?+Aghu135wU3CfPKcOeZ/IDzeR8xug99u90MhOhI4fUqpau9cemKbxTKtdKMe?=
 =?us-ascii?Q?t2xabMocux95xAvAPR8OaRzoQXSBWYaNtWZffAs4SOOj91USzBuBg7iAkPT9?=
 =?us-ascii?Q?K3KACHF+1d9NZkWXh9UZV2Pd5n97r06TC+JwiYvXNPbjLkSxDJ5Z86iW0Ja4?=
 =?us-ascii?Q?wFS1AyAkiBIrVQ2QkWte1uP46nzL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvN1dFEb5YmRV0O5W0NMjHPNVhC4NfqVVDzOOvn0lhz3uOG9dNHyZdXo7XUP?=
 =?us-ascii?Q?Lh6cKfpannElRLEfmtLe8sk16YuanEfK5dXOVeL1iymXU9G5dL1Atoiunhgf?=
 =?us-ascii?Q?+YnrRYksShIZasPXY/5dsIHLjdsdUEWTaIMgqcsUhTm7BSI10+5RVXtubMPm?=
 =?us-ascii?Q?JIz97A7hUJs0JCSl5SHykd7bv7mIt2RFub6payPy47T4jQmMbYaDF6lLSoPQ?=
 =?us-ascii?Q?91ZGNGz/XENS7DsoWIPBxDexacgWFLGxvDo+3vOHsmsLfZvRiuGDXdbD+HzD?=
 =?us-ascii?Q?oSZTDW5R7SkPRjK0kNwUrqdexkFVo/q83zis8AjQaL36Yk49fwgmajV5fluE?=
 =?us-ascii?Q?zov9Gb7ToIuXJDPuSfChtzgqzylIXv+pkB2ekUrxanmsuugKNzvtpAD1ZAw3?=
 =?us-ascii?Q?92WxYpJLcnzLF2Q/N6giaOhOuCi+61tjfBuF1ij3DCMtkvX1RqgN+Zu+0iuH?=
 =?us-ascii?Q?rC7Ce2yJ4CTRCQum9GGKDfanv4pKuyCw7GC5eKkXTkJyD0I0+fj/nGhVl2cs?=
 =?us-ascii?Q?Vv8szQJ+v16pX7QhGOFVikX/DmkrgcmjlQD1jtnk1jllkUcXJ2ZqayJw92+r?=
 =?us-ascii?Q?rUqumVM+XPuqGYfE/usaSmYfrYU9eDFR/eWN6E8ivAyH+XV6ytCOSKv3OZEj?=
 =?us-ascii?Q?AWpoIFTzgRi6+8E/sLnjX2JI5EjyyZEvN/wbRhUCYpMjqP03t/fxz5l7iNuq?=
 =?us-ascii?Q?hnYfoiGMR3MBNbFWcmhlZ3IDsRuxvxU3vqMEoXdu8p5ZPdAUWP5BexY9g6MT?=
 =?us-ascii?Q?h2h+Y/V3wjYjmG54AK8kIgwBCD1nC9dHJuObGp54JBSNeMcXqHlE5v2KMEA9?=
 =?us-ascii?Q?2cF7v9O6TQ2GALirHgpT22o8o9CPfik02bvDR6qLBh1J0fQxDjWg3jXZGV72?=
 =?us-ascii?Q?EeMeij3wMjO9OgU77UuNJymLPPwwScGu1JUqpcjf2c+9ryyGL767dVffRXnt?=
 =?us-ascii?Q?jfdF1Ig5Z7wrW2X5d4RJNWaLokvLY77c5424quI5yb5I829wJgu3ftHtPAGT?=
 =?us-ascii?Q?cytwBi0JWYrpr1t/nWIrUHtwBhShVpWglD8btKFkEpIGJOEZWTyohaNzaNba?=
 =?us-ascii?Q?fUqAySyfNOBxtrDJUYIGiiTHLWR4CJjsNFflLhjVUmBvdMxsm5X2fjMTS4vl?=
 =?us-ascii?Q?GmyW8FvJ08h/Nvmgn1xsPy+nwMCWZ4gh7uwx63R5Vbs2bgbJyPlUNXH6jYOR?=
 =?us-ascii?Q?F0DBFJRtierCd3XhxjNke0H+6BJa7ewJPB/cYHWwT7H9x1VDcpQiZ0Uvy7O0?=
 =?us-ascii?Q?oclcAjpVPt/oPGvyJm+b83HHgoYzZ4ibQTeEFK9Oc6ZBAnHd+bDNTsI4tf6J?=
 =?us-ascii?Q?rNHPa80BbJfxD66Hc7mzTJyV35q8W5XZI5/DXMaFxLi+ez84kLGu1qAbIA1b?=
 =?us-ascii?Q?YFKGtvCck3RX/8Xo5K7Yya0c3kXXbSRzkC13mXCfaeJ26kMuqlPbV3Kuy0Lr?=
 =?us-ascii?Q?zO0miAMeMGwnUOw69p3vmZsQsifMoQZgy1ie0lSBOV0FJpNoqSp54+8M2rOi?=
 =?us-ascii?Q?9xJjp9xoDtWmGXHhgZeWsYrYnNHq2f6j/QiPkatsAz89h3XvkWnyTaveffBu?=
 =?us-ascii?Q?VCmz+XBmvBsXLaQWwGJ1TvVrLZsLZhgkjET+Eww09FhnPcQWulLQhARJCLWW?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e59534-ca3d-4491-7936-08dd34417305
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:16:26.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5WEyZ8bKbuOI/oYbgAuP3i5rLgiS+vEpDMq9/hOrZQXT8EFAWEI1ptC8WrNRXBXte4DflGcRdaogirqRQI952gVXpC6z51y3kJnpJiSfX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Longterm pinning of FS DAX pages should already be disallowed by
> various pXX_devmap checks. However a future change will cause these
> checks to be invalid for FS DAX pages so make
> folio_is_longterm_pinnable() return false for FS DAX pages.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f267b06..01edca9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2078,6 +2078,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>  	if (folio_is_device_coherent(folio))
>  		return false;
>  
> +	/* DAX must also always allow eviction. */

This 'eviction' terminology seems like it was copied from the
device-memory comment, but with fsdax it does not fit. How about:

/*
 * Filesystems can only tolerate transient delays to truncate and
 * hole-punch operations
 */

> +	if (folio_is_fsdax(folio))
> +		return false;
> +

After the comment fixup you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

