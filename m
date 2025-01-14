Return-Path: <linux-fsdevel+bounces-39098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB757A0FD51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C176B1888B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5BA1F5F6;
	Tue, 14 Jan 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8oLyHX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B0F9C1;
	Tue, 14 Jan 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813998; cv=fail; b=IIOpCR1raCV0uQXyAQc1EYKPlLF4V75lbGo1Wf6LIHsDlKqFGFnTZKPhf+Xt2l1A5WKlsTWtOvMY7PftbOR+hNP58Ff0Q+w4Bk8cv03Kwld/6pWOrdRK30KCltj6t7+Ot+1Ti5VolHrv9koXTof9Kp3HbeDLN5lKfAkMsrR4KZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813998; c=relaxed/simple;
	bh=rwU+UsO6zI4bPzyC6eBN46KIdct8xT4jSDf+Y51Hda0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Glc7UaqCvOznh/TO9NS0Qq6mdPnOSesA+UnyE7/c+5Xs17zeBbh3dzQRFRKOjwQdhRF2JFf8Qjb2zhcLf5XHAW0e/0Ou6LYht6boHhdbsuHCSbYWo81V4nDoDdSRdPxK+AswOzcJU1UIW7x1JiUmBVaL4RbXS8+Bf9+7gg8DTcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8oLyHX7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736813997; x=1768349997;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rwU+UsO6zI4bPzyC6eBN46KIdct8xT4jSDf+Y51Hda0=;
  b=T8oLyHX7xrQfl70woatRJTzvgcyHY1yOXXZMRSzRhF60qAYZ+GtiQop2
   Zv+4+tZ8nDFw7RkxaGTyUFDdFD95kuwqFansblYfTPBSyae2zJnEuyGC1
   nMc8YRTcWBcryESEkVXPV6nRUcKLwuqCPQxYD5MZJWvWWk3AuBCRJIJOf
   vzxOhzfez3OWPZAdo9iJ1r4fMB8x/CxZoL0MjRyzf7HodFc1jWdktJpc7
   XwJsNI7FDhgF/rtFwda8jtr11ZQ4tCr+cb41rTCefvyKqevBLEzmNK9kr
   +RXhJzdj867VGHhgCSBZt/M9lTH1CZNuEuUDErIR4340JRgxv2M4lUZON
   w==;
X-CSE-ConnectionGUID: Y+RAquZUQ9yasOKIX+EaAA==
X-CSE-MsgGUID: 0lyBoNDbSwGWYA+k4n0QNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59581530"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="59581530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:19:56 -0800
X-CSE-ConnectionGUID: 1vs3gYaKR3ya9Z1z5C4juA==
X-CSE-MsgGUID: szdNbJGPS2eMf+fRPGBj/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109622774"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 16:19:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 16:19:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 16:19:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 16:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqy8g+qLUs4V3hETka21izlunlzrULvcRXkisqj5a6gmCVu1zESmd3xSWR5QjmN3DJYssW37CGVN3qzsyvf6hSXC8TwMg6QA/CexIBhhpdbcztPpH3UW4O424pUw8ALh52RwmPEBXeTqd46bAOEqPCEP8BXFYZMbzDdFduAMM4NhJ7po937T91eUWFlTUH6DXY/ZMMtYllAtggZJCpxT3s/FRiks+ZKjeSM9gnL8XfVQ0NmyzXLUbE52Esg5kIq16m3UfwZHCaXX/iPY6vYP9YXSOfvrGOen/WDSExorghxgjj65Xrx/eMnYsal1dS5v2jTY2rQ3ATC4RhqytJoOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBCVzAkowphirq3DXJhaHC1BtwnZGfNuJFJsgiImkxM=;
 b=OTDltwSCETp1ACviz+YPAEqWyDmK/7d4EF9SIrWUbx3qd6ZvNdJIcHQGPidJgSBeHL7d0ty1/vbHCRi9+0LidBJR73w17ABDVz4pi6lb9CLReWuPrabi7AVBtxmIALiYUb659bzfbZTeFZgsvZCL/YINUhRVZCrLE4AWfMVTDPP69NH3VBAxG2kWWuduZkyoy8TYBMDVx1qbzzyzFfrohJwSJGGj+IxFVAMTarAT0a/IKzWjNlZnsP+C2S/vqP2vA6VZbLG5Iq+I19QhVTWTUdwv9gIIUwNvShR+Ge3sZWnUoTk9LiE7GSr31IvpJCZZfSNLelp1nscxUC6O3TCImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 00:19:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 00:19:52 +0000
Date: Mon, 13 Jan 2025 16:19:48 -0800
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
Subject: Re: [PATCH v6 05/26] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <6785ada48f85_20f3294e1@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:907:1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6651a18f-cabe-4910-0505-08dd34312a3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blYvK085RkJHTjZsVzVEY1FrK08wcU1WS1pZN3p4ejl5Z0JOeXdvQzIzd0tH?=
 =?utf-8?B?OHZqNXBBVHBQUmtWWmlIWHJZWGthK2NRSGtLaU5RcGNMc3B4SkJrQ202anJi?=
 =?utf-8?B?S253UmdQYUpvRGVuSU1uZEdRM2JVZlFXc29sZjcwOUQranpUWXJrRUtMRDh5?=
 =?utf-8?B?NDkwUC9mc3I4SDVVL1NUaTYrNnl0L0JoNFZBYnBsVzAxUWs1SjN6aTFUTVVS?=
 =?utf-8?B?c3hFTUNnVkZvcytZVnM2VnJrREZpK2IwT2tDOWdPL2RVS3dDSUsybHV0TjI3?=
 =?utf-8?B?dlNDcVZYNVhUZnhaKzZrVUZ5U09GdUprSHJQeUpJR0pxVDVNaFljWG8zOFlN?=
 =?utf-8?B?ZjFCWVBEbVVtenFQb05lOEVNcGNZVFJPcEt4bW9PK01xNnlLeHcwTzNlcXgv?=
 =?utf-8?B?MWtCMG96UG4zSkJXSHpuWUN3dFlBMXF2NzYvNFB3RGNhU3dPSmhlMngraGsy?=
 =?utf-8?B?VUtIZHFPZ1ZlUEFDMXFzdVNjWWlmTnFoUjBxaERVZG9NRGVMQkJJZGllRnhG?=
 =?utf-8?B?SmVzMlN5WHVuRGJ3M0xRdmxnOGdzbm9CcUJvNHRleFRuKzlubW84cHZHdHdD?=
 =?utf-8?B?RmRWb3RMWU1EYXVjVExMa3pWZGE5elVLRjVyblR4Z0JodDVjRTFIVC9YeS95?=
 =?utf-8?B?dlhKMGs2UG1ieStIamJQMEhXZ2FxQ2dpbnRpMmUwOXdWRmFJbUVIZGVjTW9J?=
 =?utf-8?B?NzFlWlJydEY3VjBjMDN5MFRUYmtuc05pdlg4eVRjZ1NRYURaTVJLZGloMzQz?=
 =?utf-8?B?Ykx6N00xVlZSZDJUR0lBc1pDb21kb3dpTWI4ODVHMFZ6am5GRVRUYmZPeU9s?=
 =?utf-8?B?eE9UeTliVVI5ek5yVy9laHdhSVRtaUorbzJPRFpZdVhGZG1UQ3VSVGpZQmRH?=
 =?utf-8?B?RDZndkNNMXlQYmFVNy9FYlF1dFRaYUl3YlpUM3pKcjBXcE9EM2RsaEdORFRh?=
 =?utf-8?B?dEtHRHdyTHZoTEFtRjZBblR4TkZJQjV0ZkMyZFNyL2dPL1puWDlBSy8vSmIv?=
 =?utf-8?B?Um02T2hrZlNyQkV1bHBJWjlsNlFCVllvTkl3eHQ1S1EreVlUZEtTcStpeTgy?=
 =?utf-8?B?a2VCWlBDeHdIK3NWNEhjL2wzQXZYSWgveG1URVpGN0tKUHFHYTRZeDFaZTJB?=
 =?utf-8?B?SUtpS252TmRnSDNFZEovTThqd2h3SGFqZVlQcCtuRWMwOVJLeHdvVXltVUFH?=
 =?utf-8?B?b0JxeDZseExlUXhoS3UxQ1pKQ3hpY3NFeE8yaHcvTWpZdGF6dFkrR0FxR3Zr?=
 =?utf-8?B?bCt5Qm1GWVRPaHAwYW45NnRyUEU5UVkyRUJ6bmVuaEtwMWZKdmNtQmtLTFVv?=
 =?utf-8?B?L0VmUXpYTWZwck1DTi9hdG12SFJDRktyZmoxN29zSTJvQ2l2MDhWaEVITTMw?=
 =?utf-8?B?ZTVKdEY3UnE3K1Z3N3BsWFRXVUc5ZVVKUFhpV3MyNjdmODZqYSs4T092TXc1?=
 =?utf-8?B?TWFFWlo5Ulc4M3ZhbytWSmRveDhmOFdGY3pxdStMbXVGZjh0U05naWZNUG1R?=
 =?utf-8?B?TUpmQUxoT3R5Q04wOG5RZ2hpclFjNWQ1Nytqc2RlZkRzVUdJUG5iRFBWZVVx?=
 =?utf-8?B?STlraU5sOXl3TlpQQ1VIeHFEQWlSYjJZMjIwZ3VCVlRaMXpRc1NwWTMxVzlk?=
 =?utf-8?B?T2ZCZzdzYUkxTEFBU3pqOWxMZnBzSTZYaU5mNURyQU9lNTJ6RFZZRlp4TjN6?=
 =?utf-8?B?L1R1U3JDbE1HMlZtK0Q2Z3IvVFQ3bDgyaW1iZldvV21KeUVyamxWQ05BSmtF?=
 =?utf-8?B?U3NTU1JQWXc0ekhaRG4yT3NwWUM4b3Vjc0cxWTY4VEF5OEovRlFzdWpoeGp0?=
 =?utf-8?B?V1lCb3ZUNVhsZWZ4YjlWOGdsQW9IYlBmZmdXSkI4ek11aVlvUWw4elBrbVFG?=
 =?utf-8?Q?q3EjPmM+wX+CD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQ3TkE3cCtvQmZsT3daR1c4eTNiSktSTjduS3FPNGNQU1Z3amNRQTMzOHNn?=
 =?utf-8?B?OEVaNTljRElxRGVrS0N4NzNrL2F1VWJ0WFkwbVFxcnh4U1FQSkF0dnhxanoy?=
 =?utf-8?B?VW5VdDdNaGs3S1F4NmRKUTExdWNHRHFVSDZyMnlIZ2hLN1dBbFJzUnVYRzFQ?=
 =?utf-8?B?Sm9EOEsyMXBrd3lMcmMvVnNxUy9UY0I1MFhvdTRMdXBXZzMyOHRyK2F6Zmc4?=
 =?utf-8?B?UCtKdDRJRGZxQXM4a0hETUZJOGJnQVhXMVRrbnMwdUlOUTNoaWRZV09qOHBY?=
 =?utf-8?B?VEhvbTdUek1lOEYxT0txQ1p4UCtLTDFQVWhmbjhXOWZGN3dxRldVRldFWjE1?=
 =?utf-8?B?Yk5vWjVkdXBORm52a01EUnUxWVBna2lvc0h2TGlCWndSZng3WmVpeVplREVW?=
 =?utf-8?B?V2kvTmRiR2lnS2tLTDJhQVB2bzNhNnhyMmhKcmphWGcrUW0yUWNtMDY2MldU?=
 =?utf-8?B?KzdBWTV6alRueHlmZjkzWXkvbWlCeHlvQUNlTXUwbGUwZjV0aUVSN0NydGtt?=
 =?utf-8?B?T05meFY1dklDaStoVWlWKzhpNWhNcnpud0dCYVRVMUpxWXduVnhvWUp1WmtT?=
 =?utf-8?B?Q1N5SEhwY1hWM1kzaTN1bjJBTVdaT2FMOUlmbVAzQURSMUl2dHhQOXZBZnJm?=
 =?utf-8?B?bGY1V25TVDJyeVdRbnc0cTFYMUM5RW9uVXBmUUpsT2dBSUFnOXFVNXZybHRO?=
 =?utf-8?B?OHdrajBjbkdvZnNwTEd0YWlIeUdLRW9BaFlDMi9SYjBGb2hweXRTMTVEUU5i?=
 =?utf-8?B?MVRtVzVYUjkvUk00T0tqU2tEcDl4OTBHOFNzaHFQTnUwS05SaWhlWkNqbFhD?=
 =?utf-8?B?NXZtYWJRcGJhQmNiMVZqZVh2R3UxQTRnQ0p0OXRoRUlVQUNNRUVlbmM4akFM?=
 =?utf-8?B?R0hUVWlHMncxMWc2QjNvcHB6ay9qSkFhWVZSemQxUWxyWXk5RXZ0VzB6VDlw?=
 =?utf-8?B?TjdtY2xIcFY3a0F3OFAwbEl2Q2g0czJDbkhaL0taTDEvSFZuR2dWbU93MXpt?=
 =?utf-8?B?azVMQzFpK2hISDd2Sm9MeVorM0swaCtPdWtpUjd5ZmFzalcvWlUyT1FFcGdJ?=
 =?utf-8?B?dlF3U0hJTnI1S2l6cXd1ZW1aVHlEU21UV2FPb0F0MzgxVHNBN2pPZGFEUEJm?=
 =?utf-8?B?V1VxRW1lY1RWZW56a3M2dkk5bDh1TVV6ZU8zeThWc3R3L2VFdWdRUTVDUWlR?=
 =?utf-8?B?bTByc3FTaTdxRlVXbDRHaHAzN0UvV2tHSU1uUTdYSVZWYkRkeVQzWnJ5b1Fz?=
 =?utf-8?B?MnkzRmpLQjVtZjUzWEtUZlFBRGJVVDFTM3ZCT3JtTnFhd1Vtc0t2L1lpT1FJ?=
 =?utf-8?B?WmhjczNZOTcwSWlnZnJMM293OXVHK0F3Qitacno0ZCtVTE5xNzhuMG1sVDJQ?=
 =?utf-8?B?Y1AydHd1eGovSnFNN0IvVW1WK3pkeUM3cm9QR1o4QWdyZHdGaGNSc3owQTRJ?=
 =?utf-8?B?VGFTUUF4RFJINDIzWlcybVBDeXJrVG56R3RvYWNzYURqVHZmOUxwSzRuM0Uv?=
 =?utf-8?B?dWg0Sm00Q1pEU0dHb20xdkZEb2xzd3N2WCt0a2RJUW9IWW1BajNPUlhxcjgz?=
 =?utf-8?B?eUZ2cmVmVUoyVkpyQzRWRVJVbnlzMkRrTS9VS2twZGh3UTF3YVJmQ1BPcUlG?=
 =?utf-8?B?MitJYmwxUnprWGxQQksyY29jUnlOaDFSVEpJTVU4Q3oyTERRMGpWSkVOZ0FW?=
 =?utf-8?B?UjlDbnJxaGlGV2Vza3FQRGptMGhpRUtVeGJuaXU0RlhzSm4yUmtlbFVYSkVj?=
 =?utf-8?B?K25mWktPSVljaFB0ZFBQTjRTaGluL0dVelRKNGZNNElQaGxaWjR3amU2eWkv?=
 =?utf-8?B?aitzTEhmZWhPdDBYZzMrcHUzVmV1Tm9Id1hydUFRN095TGZjYkxENTdoNlBq?=
 =?utf-8?B?S1FBNlA4N0FydTdrTzFCVW5tNWtSSFNXdFl1ZVpvcFNGZXEzNVhwZ1l4RXlz?=
 =?utf-8?B?eEpQVW1ZTUlUMW4wOUVtWWE0L0tSUW9ndVF6Q3krdFRHL1kyejM2eEV5aUpj?=
 =?utf-8?B?cnBROUZLeHJJVFgvdUJXOEQ0aGNIbzJHN0FkblpQV09MQjU3NVpvWU93RzBm?=
 =?utf-8?B?RHRXQy85NElaOTlrNEdlK0N3YXV5c1NVcVlQdHJ3SnpmNUZvMGlKQUhpSHNa?=
 =?utf-8?B?Vi9QdEtXcTFLbDV2bkV0aXJIQ3MyNVdNTFZueHh2QVNBdDZXVkx3SFhmRHAr?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651a18f-cabe-4910-0505-08dd34312a3e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 00:19:52.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1TrGKFP5D9WMMTtQPvGLcwWFzV7VFs91Wst9JATlYMO6ARemgRUaaBGDE5Dm2IhyuWt5nU4lMvk3a+6ib4TtIiW8zPLdDM0ds6u3N6JUyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Prior to freeing a block file systems supporting FS DAX must check
> that the associated pages are both unmapped from user-space and not
> undergoing DMA or other access from eg. get_user_pages(). This is
> achieved by unmapping the file range and scanning the FS DAX
> page-cache to see if any pages within the mapping have an elevated
> refcount.
> 
> This is done using two functions - dax_layout_busy_page_range() which
> returns a page to wait for the refcount to become idle on. Rather than
> open-code this introduce a common implementation to both unmap and
> wait for the page to become idle.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v5:
> 
>  - Don't wait for idle pages on non-DAX mappings
> 
> Changes for v4:
> 
>  - Fixed some build breakage due to missing symbol exports reported by
>    John Hubbard (thanks!).
[..]
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index cc1acb1..ee8e83f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3917,15 +3917,7 @@ int ext4_break_layouts(struct inode *inode)
>  	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
>  		return -EINVAL;
>  
> -	do {
> -		page = dax_layout_busy_page(inode->i_mapping);
> -		if (!page)
> -			return 0;
> -
> -		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
> -	} while (error == 0);
> -
> -	return error;
> +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);

I hit this in my compile testing:

fs/ext4/inode.c: In function ‘ext4_break_layouts’:
fs/ext4/inode.c:3915:13: error: unused variable ‘error’ [-Werror=unused-variable]
 3915 |         int error;
      |             ^~~~~
fs/ext4/inode.c:3914:22: error: unused variable ‘page’ [-Werror=unused-variable]
 3914 |         struct page *page;
      |                      ^~~~
cc1: all warnings being treated as errors

...which gets fixed up later on, but bisect breakage is unwanted.

The bots will probably find this too eventually.

