Return-Path: <linux-fsdevel+bounces-76764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGifIRpqimmbKAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:13:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA3115580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEE29302444C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F24326D63;
	Mon,  9 Feb 2026 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEj/bhHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDD326940;
	Mon,  9 Feb 2026 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678801; cv=fail; b=Mg2fHOLLR3JlOyGWaJ/dX7Z0QoJjmG141raFZ1g1dcBuz9k2BXRfdMdVRvQ+fAp5RIb1b06ysLWd758faJWpa/l+IOrdQdOr/AQHYp8QNxM0mYdcioDbDYvYjMKkqXcFGNY/2PHoKdg1+a35A5UTt/VtVRjYMoe1AH1EtjgbKCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678801; c=relaxed/simple;
	bh=3HLxH5JcDDOGxJ39ZH949NzIsJoat7jKO8u2QDtfTSA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dcT/VeRlnIiLrCyqS0DOCNXs3KfB6k3FfTUXgA1bmj6Se9N+upMvW+RK7Op5tBZAhvc6p4c6H8ior3nQdXcNNTtZoSoOUuRlXz272oxyaS+QzUPCtNBsisihGUGq3i1UX2/Y/yzrE9P3AHivN9fJxmsK/yDSzJKSQuyDugC9enQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEj/bhHF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770678799; x=1802214799;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3HLxH5JcDDOGxJ39ZH949NzIsJoat7jKO8u2QDtfTSA=;
  b=SEj/bhHFeM6fMMa7yT2105p7OBw5Nf6eTkh/LBK5ecWc2/Dh13SZpKgR
   GzFeMazBpJ58JLqpCE8ltXGAeUMEaVOlrvUv1K8z0H6PTBg5cXRijTG81
   J1ANgpzpiC6+GEadlXMUEBMHwxb3K5/7s0g1tym/hhqu/9Hx1DQrCp2Tq
   DHmV/tUJGDIZMp+bGINL/EUD2jFP8hH2fd/ZVVe/K6klVDXb7oR9sys0c
   pPkU5hP9CVxR3H2x113JNIaIQbZQpK3MAXzTZT0YYMo+M9YzTwd7XXFY3
   8CiYF1RSQiScV7gb0aQ4MQB9MwsIYEFG/sZDYjyy0qWxd1n3hsCzdUBvw
   A==;
X-CSE-ConnectionGUID: 8yq1XYfMSwy0IxmY6JaY/g==
X-CSE-MsgGUID: 7ck0Sa/8ToisvoUtHnPBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71786579"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71786579"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:13:18 -0800
X-CSE-ConnectionGUID: s+IbdMmnSTa19kJPoBH/eg==
X-CSE-MsgGUID: tIQTMp40QPKseneOlDNIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211419608"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:13:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:13:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:13:16 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASYrxsgKQe96yffLpbbdGcc6AjHUfZo6B33O85hqY2ATuqGmgxhuy2mrQmsoumnQMukOjVKJG66sdt//NHuN82ItQCOFZAGjps8BlDOO89VNawqzcwLHwG1VuBb2/l2Jxa5YoMVv3T/qqLIufpO65g35x49Z2qI2Uf85Nc5ktZk1719svRccBCDgvDzMaEZXVmqhf/wzr2MGXbMCgUN/32K3vd18OFUWP9mg+bTKIbOnuZyD2vwNOfkt46tfyH/2dDbUH9Mii974t4lDRQiV9v9grUz9UkIAta80u6LDe5PtJcrqpziRpz3c1LwiRnc1uBff99au/NC6+zAo/iOqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HEWPtLyaRih5mTivedAmmS7Zk2CBGx/CsMNqHAx4AE=;
 b=VlLq3mwH2x7kG9ugtoPkrsR1ETVtMtB0q43pMxl6N5s7Io7vxUOKRDXDRSlGRuuN5wJgWL5g+402zzdt/7A8c7exBF2kVdnbc/o7wjaHFnKIxPt/ufzhZEDEkM6W2XEsLNABuRW5yMupQwpaDec5FSaem7lPjwfd/C2vPNhvYkm3x2qe0xQG0uhcM9SwFOC+QS0kC44Y1hgdEjBCgaacT1uobsMEpkuYavkSAesyiizrLdYPVm95IPkB3X6z3+UXYEA006uMvvxZCUK/aLxh06j0aED9mGvQ2wnsEJmgTa3XcTFpNBs4y2X6akQQEdT8+A6eUUVeGXSMNCCRP2ulgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:13:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 23:13:13 +0000
Date: Mon, 9 Feb 2026 15:13:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: John Groves <john@jagalactic.com>
CC: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, "Dan
 Williams" <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>,
	"John Groves" <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
	"Jonathan Corbet" <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, David
 Hildenbrand <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, "Joanne Koong" <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, "Bagas Sanjaya" <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V4 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
Message-ID: <aYpp_ShERlNvt4T_@aschofie-mobl2.lan>
References: <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
 <20260118223548.92823-1-john@jagalactic.com>
 <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2df817-29b9-421d-1d7b-08de6830cca1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Bh2vjPol98U20WFb/43HaJKWW308Uzl6nKYp8xjFQhvEvRL/Kwol/9qoE/n?=
 =?us-ascii?Q?1lSHgwp7golIKf8cPOs3pHNc2/tYyRCIcPrPY7I/e82KX2M19qBqChkMn4F/?=
 =?us-ascii?Q?qyBL7vyWtJ6MDz4v6v1W/LpcPBsC/3fif6aaT8L/JVply6RLjU1o9S2JwoZN?=
 =?us-ascii?Q?OYH7G5J0KfRPBEXs854WH6wQJWVwGMFqmBJij1+irOtQlYuI1uhjyh/J6cMU?=
 =?us-ascii?Q?8xtESKgv9aqtmcYd1esNUV8DaOaQC31RtZX6a9pMLSAHiC6aqXG51Z5wmLVM?=
 =?us-ascii?Q?9o/i4YWiKRim1YQPjXcfFN7PkUp5iQQblXOWvzJViO6WOHgoEYBlf7gTwdph?=
 =?us-ascii?Q?TFHhMSSLkKGT8Pj5rk+vtmw5KIa7uUTJWbFuhGcFj1ecgqP0ZjT8iS1J5ldK?=
 =?us-ascii?Q?iOlf+WNaGOCa1ZVmCroBcvrUFxDCMqEzuu1RBcTx13aERAnTpXdAMZbf+4V5?=
 =?us-ascii?Q?qNHt0NbHeMlVHNWGjuPLLTB3X4dmsalVHPKVkm+hTBSfB5SppOAkJ8UTNSdD?=
 =?us-ascii?Q?oqqNoZaTpCr1hcRfsyngK/MR8VWWk/+AAuoDxufXA6/e+m4D8zLykPbCi6gY?=
 =?us-ascii?Q?9nAZ2z7JlI5uJYyvO5hBuaw2vvMyfhCsfVna0BmHqGGoULzOFFQsvaz8zeZX?=
 =?us-ascii?Q?JY2z85nCRXmZOiQYVYspEbhDLEJk0XOZ9kE13Jmu17GkunSdYhNzTtR85+dl?=
 =?us-ascii?Q?8ffc3K6bIXpazkji1GbQvFh+N9dYejZiUMooBTyYvwsO8p5mAwKiZcXgYjb5?=
 =?us-ascii?Q?eNpjtOWy/Kk3f0tKXWcMAHa2KMBMQteArb89FNZyWpk1E004u6rcKlqWa4rL?=
 =?us-ascii?Q?sPljWZrDACu7UyUqlZ4rpKgB2H2XqRaMTgQyk1u9dwB3x1IcVsPka1LTpb+K?=
 =?us-ascii?Q?ID0FRHaXvXTvLCxwvomHThnd93DLrCZLEgl9Dm+S9eNIj0DogkNEhmoH2J/N?=
 =?us-ascii?Q?oxWSOA1L5xYWrJufCnC5bHpb7QAmayIUYiEn/qrNOkur7NsBrzZoBjQhS4f7?=
 =?us-ascii?Q?C0AMEaKnDNFpYw1Ha4Ofzw/SBCAX8dB2paAJxgE3NgWgvleUd+YY0lRxSPIE?=
 =?us-ascii?Q?a7P6pQMcODlGusI/MjZ1go4yfnKx959WUYUnh8ednAjO7TtHmG0wc1RIG+QZ?=
 =?us-ascii?Q?Gq6C8VVLcpqPg5U0yOKZfp1+PKQK1psclNCQDvcLepr111jq4IICCehscHop?=
 =?us-ascii?Q?U2Fi8iM+tTgupWthh9q6CaOBjpxpJLjmdZDEncICLlohbbRutlTygCBWhBaD?=
 =?us-ascii?Q?s3BKBSpJ691ZPfrhy/gzb8QORPY7wlcvI6rsxlHdf8yg/Afbb/L17hDcWt8n?=
 =?us-ascii?Q?UKwBBaFJ72TPxbX4YMPWLURexLIR6jhS1GwbX9XKcOg6ElZsqIZzK1kLCznv?=
 =?us-ascii?Q?oRHfTwWEVJINAu0gG3Zle8epQ3HHwi4vtNug2hPoqKUtiiml3cC1hR9xeUxc?=
 =?us-ascii?Q?mzMT8zcKGQIHDumKZK39QwhkUk09jqSohxvmBRHb89sTYTYWY90/xix/aZLO?=
 =?us-ascii?Q?GtCO2Floe/GRJW7h45a7ZYWiwVVnPNDnT6YT9v1WB0fNqB3Br6J3loK2lG8n?=
 =?us-ascii?Q?scEP8nEvHV3gF3fnZIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdnA9lXr4aLn50PMkHVpJnZjjWl1VvBDxFWIRrMfJLx1D1/i1XtFj3+mxACT?=
 =?us-ascii?Q?honbyz/VdeoC1PGdLj6RmDQQoLHU7/lenFQYLG5Vr32wKCqWBJxn3RTEjBd4?=
 =?us-ascii?Q?3VjMxD5IQs29q/tU7w3t9MY7EO0/ibdf9OCdfRqoe0XfoPGTAhKAzRDqkUmU?=
 =?us-ascii?Q?+HeAuucMS18HvOBXYcunkcTT1KOT/ZRaEMHTjAkDJIbI0RQvzqkF8Ts3ZFSm?=
 =?us-ascii?Q?PJbdZaqcBudCVMkeP6uaVSXzSCqmigEfB44TkhSEHBqfauJrqaO0HTHk9pBK?=
 =?us-ascii?Q?aRCOME9pBFjxm8DKOgM7qBoWH2xIaGqCf42tYw/dj0w2iIf2lVzbzntRkTKY?=
 =?us-ascii?Q?q8ol5NpUnbKpulpykobBspkfXfEGwl+8v5K0/ooID3kBHb6GFYDb33vLr/2/?=
 =?us-ascii?Q?0dElU8OT00Fi2inWxl3sb0yST+mtar2BmDjJMfUTS6TPmUynAznqun0LrO/5?=
 =?us-ascii?Q?3z0rpUJaUndEjY93miow0fqNrL42qn3P08/AIwpveut/2/zYrLcAi1kvjWej?=
 =?us-ascii?Q?GQrio35kGed4lcTF/NtJ9G7HIrNoxLyXlKZQW304y/4J4qG2gux6OYrwKqzd?=
 =?us-ascii?Q?wVTRA88hGobG/1NgOQB+2mfAWnqvy/aRh5o9bWPtg+8Zd4pQ+oyE+pj3a6Zv?=
 =?us-ascii?Q?TIHMUPpwkvNF1A3AUmm0qKLma5HzuTt7lUwu9gYwytWsHBFyLJObp03eBXTF?=
 =?us-ascii?Q?0lZgXclWdrzZz7cpXrjCbU6cN9XZPaCoF+ySu7Z7skPPs84ZmmCsnws8g0uK?=
 =?us-ascii?Q?Sxu8FyFcP9Bt47rhZZBoDlJ11WheByYX1ZSwgvMZeiKqw5SOWDeXWKIsf01R?=
 =?us-ascii?Q?8h0dPjzr/HaeWyGzzVhwDLjCnXQeQjz7/PODmHLVQCOAAZNgne0beDEqD9Gp?=
 =?us-ascii?Q?e2UE6b1bT3Vo8dp8xGeRjvTD2kowmXBsag8JirYxclkDveulNT4/AnsDV6Ht?=
 =?us-ascii?Q?tYamDSggWa5gBTH2ABABnQXP8fsF7mQSNxKiQEvdVJOdX5QyT7+RbA+9WbZt?=
 =?us-ascii?Q?TcskjKiTuYiX/6kKPBMPk525QJwDVvx0lQ4h79pA/UZCMKY6EA3tPRRiuyXj?=
 =?us-ascii?Q?PkjQGQ98Giu397tL5B4Mwf6tONEqIywV3zQv7tnj6ZbdNVgMZJc+3XNYtWbp?=
 =?us-ascii?Q?uoFt75iSCZAjEeloB6zs8sM/n1QAavItKVsZUhppan/GolHx+0SjOhSZwRbx?=
 =?us-ascii?Q?wdzBfeBQiYDTdAXr83TPLozJxnV5S3CqgxP3G9UiEUuxpOtipv1iQS1jbK6Z?=
 =?us-ascii?Q?H8gOUkQgmR8+QU/niRDFuZ0LE1z2qht7FNbRQ35BX2rxXYt2GtsPPuK18iXG?=
 =?us-ascii?Q?74VgDL7xS8jUab1VIpezpf3pGfzSDm6CWs9lfWmqzy2g0zwOSA15mNvhb4pM?=
 =?us-ascii?Q?2ng49oJEHPTxvOeHnEfzgNMOVcrJGhjPH7fulwZ0ksj7V0BJzC2V5ssgonIP?=
 =?us-ascii?Q?zoaz2cCB3t3E2nHhLdQfBv2Zc9QlkXjvkKGOYVZzSrhq2uiIvLuD7JuaKK5x?=
 =?us-ascii?Q?F0o69cnIcoQHpep9Iv4rE4Zx0jRmNETeF87pnmKkJ6xDYMEzM5tL9ZldBf+L?=
 =?us-ascii?Q?tsoxld8EMhbUZWorTM7+PZwyRlzAainhU6Y2S1QIaQeskS5PfJ/5NoOkaz3q?=
 =?us-ascii?Q?1EuNz2K7NNuCZ8c06Ti19dS1kAW4sQzYKHKCMpcXEyfodzAmlzUfnvvNZkF5?=
 =?us-ascii?Q?lpQ7Ek96241++ocUkc6GAKr4K/bRP/eubWLbXZ7+kmpg6O2VUWuHVNYTYw9N?=
 =?us-ascii?Q?2j7qPrVwn/sQV/Qgzzqw5C925C0sbHc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2df817-29b9-421d-1d7b-08de6830cca1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:13:13.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bos/maR/kKf77j4LX/CuyFEAh2p/XKVuAt1tcJlGzs7SbEgvBF1/yZZ6Nb3UIhgKJyg8d7kjQsyeIP0L7SW/8MCKpe6XTZmMSMzUwlrftpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76764-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,groves.net:email,daxctl-famfs.sh:url,aschofie-mobl2.lan:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F3CA3115580
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 10:36:02PM +0000, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> No change since V2 - re-sending due to technical challenges.
> 
> No change since V1 - reposting as V2 to keep this with the related
> kernel (dax and fuse) patches and libfuse patches.
> 
> This short series adds support and tests to daxctl for famfs[1]. The
> famfs kernel patch series, under the same "compound cover" as this
> series, adds a new 'fsdev_dax' driver for devdax. When that driver
> is bound (instead of device_dax), the device is in 'famfs' mode rather
> than 'devdax' mode.
> 

Hi John, 

I fired this all up and ran it. It got through all but it's last test
case before failing.

Three things appended:
1) the diff I applied to daxctl-famfs.sh to run the test
2) testlog.txt output of the test
3) RIP: 0010:is_free_buddy_page+0x39/0x60 kernel log


1) Diff I applied to execute the test:

diff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs.sh
index 12fbfefa3144..a4e8d87b9762 100755
--- a/test/daxctl-famfs.sh
+++ b/test/daxctl-famfs.sh
@@ -9,6 +9,17 @@ rc=77
 
 trap 'cleanup $LINENO' ERR
 
+# Use cxl-test module to get the DAX device of the CXL auto region,
+# which also makes this test NON destructive.
+#
+# The $CXL list below is a delay because find_daxdev() was not
+# finding the DAX region without it.
+#
+modprobe -r cxl-test
+modprobe cxl-test
+$CXL list
+
+
 daxdev=""
 original_mode=""

2) Log of Meson test suite run on 2026-02-09T14:52:40.498801

1/1 ndctl:dax / daxctl-famfs.sh INTERRUPT      230.60s   killed by signal 15 SIGTERM
22:52:40 MALLOC_PERTURB_=233 LC_ALL=C TEST_PATH=/root/ndctl/build/test NDCTL=/root/ndctl/build/ndctl/ndctl DAXCTL=/root/ndctl/build/daxctl/daxctl DATA_PATH=/root/ndctl/test CXL=/root/ndctl/build/cxl/cxl /root/ndctl/test/daxctl-famfs.sh
----------------------------------- output -----------------------------------
stdout:

Found dax device: dax6.0 (current mode: system-ram)

=== Testing famfs mode transitions ===
Device is in system-ram mode, attempting to convert to devdax...
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]
Initial mode: devdax - OK
Testing devdax -> famfs... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"famfs"
  }
]
OK
Testing famfs -> famfs (re-enable)... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"famfs"
  }
]
OK
Testing famfs -> devdax... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]
OK
Testing devdax -> devdax (re-enable)... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]
OK

=== Testing JSON output for mode field ===
Testing JSON output for devdax mode... OK
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"famfs"
  }
]
Testing JSON output for famfs mode... OK
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]

=== Testing error handling ===
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"famfs"
  }
]
Testing invalid mode rejection... OK (correctly rejected)
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]

=== Testing system-ram transitions with famfs ===
Testing devdax -> system-ram... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"system-ram",
    "online_memblocks":0,
    "total_memblocks":4
  }
]
OK
Testing system-ram -> famfs (should fail)... OK (correctly rejected)
Testing system-ram -> devdax -> famfs... [
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"famfs"
  }
]
OK
[
  {
    "chardev":"dax6.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"devdax"
  }
]

Restoring device to original mode: system-ram
Error at line 255
stderr:
+ rc=77
++ dirname /root/ndctl/test/daxctl-famfs.sh
+ . /root/ndctl/test/common
+++ basename /root/ndctl/test/daxctl-famfs.sh
++ test_basename=daxctl-famfs.sh
++ '[' -z /root/ndctl/build/ndctl/ndctl ']'
++ '[' -z /root/ndctl/build/daxctl/daxctl ']'
++ '[' -z /root/ndctl/build/cxl/cxl ']'
++ '[' -z /root/ndctl/build/test ']'
++ NFIT_TEST_BUS0=nfit_test.0
++ NFIT_TEST_BUS1=nfit_test.1
++ CXL_TEST_BUS=cxl_test
++ ACPI_BUS=ACPI.NFIT
++ E820_BUS=e820
++ CXL_TEST_QOS_CLASS=42
+ trap 'cleanup $LINENO' ERR
+ modprobe -r cxl-test
+ modprobe cxl-test
+ /root/ndctl/build/cxl/cxl list
+ daxdev=
+ original_mode=
+ main
+ check_fsdev_dax
+ modinfo fsdev_dax
+ return 0
+ find_daxdev
++ /root/ndctl/build/daxctl/daxctl list
++ jq -er '.[0].chardev // empty'
+ daxdev=dax6.0
+ [[ ! -n dax6.0 ]]
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ original_mode=system-ram
+ printf 'Found dax device: %s (current mode: %s)\n' dax6.0 system-ram
+ rc=1
+ test_famfs_mode_transitions
+ printf '\n=== Testing famfs mode transitions ===\n'
+ ensure_devdax_mode
+ local mode
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ mode=system-ram
+ [[ system-ram == \d\e\v\d\a\x ]]
+ [[ system-ram == \s\y\s\t\e\m\-\r\a\m ]]
+ printf 'Device is in system-ram mode, attempting to convert to devdax...\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -f -m devdax dax6.0
dax6.0: all memory sections (4) already offline
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
+ printf 'Initial mode: devdax - OK\n'
+ printf 'Testing devdax -> famfs... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ famfs == \f\a\m\f\s ]]
+ printf 'OK\n'
+ printf 'Testing famfs -> famfs (re-enable)... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ famfs == \f\a\m\f\s ]]
+ printf 'OK\n'
+ printf 'Testing famfs -> devdax... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m devdax dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
+ printf 'OK\n'
+ printf 'Testing devdax -> devdax (re-enable)... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m devdax dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
+ printf 'OK\n'
+ test_json_output
+ printf '\n=== Testing JSON output for mode field ===\n'
+ ensure_devdax_mode
+ local mode
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ mode=devdax
+ [[ devdax == \d\e\v\d\a\x ]]
+ return 0
+ printf 'Testing JSON output for devdax mode... '
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ mode=devdax
+ [[ devdax == \d\e\v\d\a\x ]]
+ printf 'OK\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
reconfigured 1 device
+ printf 'Testing JSON output for famfs mode... '
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ mode=famfs
+ [[ famfs == \f\a\m\f\s ]]
+ printf 'OK\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m devdax dax6.0
reconfigured 1 device
+ test_error_handling
+ printf '\n=== Testing error handling ===\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
reconfigured 1 device
+ printf 'Testing invalid mode rejection... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m invalidmode dax6.0
+ printf 'OK (correctly rejected)\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m devdax dax6.0
reconfigured 1 device
+ check_kmem
+ modinfo kmem
+ return 0
++ cat /sys/devices/system/memory/auto_online_blocks
+ saved_policy=offline
+ echo offline
+ test_system_ram_transitions
+ printf '\n=== Testing system-ram transitions with famfs ===\n'
+ ensure_devdax_mode
+ local mode
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ mode=devdax
+ [[ devdax == \d\e\v\d\a\x ]]
+ return 0
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
+ printf 'Testing devdax -> system-ram... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -N -m system-ram dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ system-ram == \s\y\s\t\e\m\-\r\a\m ]]
+ printf 'OK\n'
+ printf 'Testing system-ram -> famfs (should fail)... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
+ printf 'OK (correctly rejected)\n'
+ printf 'Testing system-ram -> devdax -> famfs... '
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -f -m devdax dax6.0
dax6.0: all memory sections (4) already offline
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ devdax == \d\e\v\d\a\x ]]
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m famfs dax6.0
reconfigured 1 device
++ daxctl_get_mode dax6.0
++ /root/ndctl/build/daxctl/daxctl list -d dax6.0
++ jq -er '.[].mode'
+ [[ famfs == \f\a\m\f\s ]]
+ printf 'OK\n'
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -m devdax dax6.0
reconfigured 1 device
+ echo offline
+ printf '\nRestoring device to original mode: %s\n' system-ram
+ /root/ndctl/build/daxctl/daxctl reconfigure-device -f -m system-ram dax6.0
/root/ndctl/test/daxctl-famfs.sh: line 231:  1266 Killed                  "$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev"
++ cleanup 255
++ printf 'Error at line %d\n' 255
++ [[ -n dax6.0 ]]
++ [[ -n system-ram ]]
++ /root/ndctl/build/daxctl/daxctl reconfigure-device -f -m system-ram dax6.0
------------------------------------------------------------------------------

Summary of Failures:

1/1 ndctl:dax / daxctl-famfs.sh INTERRUPT      230.60s   killed by signal 15 SIGTERM

Ok:                 0   
Expected Fail:      0   
Fail:               1   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

3) BUG: unable to handle page fault for address: ffffc9000f508033
[  343.806681] #PF: supervisor read access in kernel mode
[  343.808158] #PF: error_code(0x0000) - not-present page
[  343.809635] PGD 80a067 P4D 80a067 PUD 1936067 PMD 12eeb9067 PTE 0
[  343.811357] Oops: Oops: 0000 [#1] SMP NOPTI
[  343.812634] CPU: 4 UID: 0 PID: 1266 Comm: daxctl Tainted: G           O        6.19.0-rc5+ #106 PREEMPT(voluntary) 
[  343.815263] Tainted: [O]=OOT_MODULE
[  343.816423] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  343.818507] RIP: 0010:is_free_buddy_page+0x39/0x60
[  343.819466] Code: 00 00 00 48 c1 fe 06 eb 0a 48 83 c1 01 48 83 f9 0b 74 30 44 89 c0 48 89 fa d3 e0 83 e8 01 48 98 48 21 f0 48 c1 e0 06 48 29 c2 <80> 7a 33 f0 75 d9 48 8b 42 28 48 39 c8 72 d0 b8 01 00 00 00 c3 cc
[  343.822668] RSP: 0018:ffffc9000f50f828 EFLAGS: 00010286
[  343.823719] RAX: 0000000000007a80 RBX: ffffc9000f50f8a0 RCX: 0000000000000009
[  343.825021] RDX: ffffc9000f508000 RSI: ffffff7c003d43ea RDI: ffffc9000f50fa80
[  343.826343] RBP: ffffc9000f50f838 R08: 0000000000000001 R09: 00000000ffefffff
[  343.827651] R10: ffffc9000f50fa38 R11: ffff888376ffe000 R12: ffffc9000f50fa80
[  343.828834] R13: ffffc9000f50f9a0 R14: 0000000000000006 R15: 0000000000000001
[  343.829725] FS:  00007f0f83e087c0(0000) GS:ffff8881fa8f8000(0000) knlGS:0000000000000000
[  343.830765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  343.831581] CR2: ffffc9000f508033 CR3: 000000012dec6003 CR4: 0000000000370ef0
[  343.832517] Call Trace:
[  343.832964]  <TASK>
[  343.833385]  ? set_ps_flags.constprop.0+0x3c/0x70
[  343.834099]  snapshot_page+0x2ca/0x330
[  343.834679]  __dump_page+0x2e/0x380
[  343.835260]  ? up+0x5a/0x90
[  343.835757]  dump_page+0x16/0x50
[  343.836324]  ? dump_page+0x16/0x50
[  343.836861]  __get_pfnblock_flags_mask+0x6f/0xd0
[  343.837520]  get_pfnblock_migratetype+0xe/0x30
[  343.838192]  __dump_page+0x15b/0x380
[  343.838692]  dump_page+0x16/0x50
[  343.839111]  ? dump_page+0x16/0x50
[  343.839504]  __set_pfnblock_flags_mask.constprop.0+0x6f/0xf0
[  343.840093]  init_pageblock_migratetype+0x39/0x60
[  343.840589]  memmap_init_range+0x165/0x290
[  343.841069]  move_pfn_range_to_zone+0xed/0x200
[  343.841548]  mhp_init_memmap_on_memory+0x23/0xb0
[  343.842062]  memory_subsys_online+0x127/0x1a0
[  343.842542]  device_online+0x4d/0x90
[  343.842986]  state_store+0x96/0xa0
[  343.843393]  dev_attr_store+0x12/0x30
[  343.843809]  sysfs_kf_write+0x48/0x70
[  343.844231]  kernfs_fop_write_iter+0x160/0x210
[  343.844714]  vfs_write+0x261/0x500
[  343.845185]  ksys_write+0x5c/0xf0
[  343.845584]  __x64_sys_write+0x14/0x20
[  343.846040]  x64_sys_call+0x1fbc/0x1ff0
[  343.846480]  do_syscall_64+0x67/0x370
[  343.846905]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  343.847432] RIP: 0033:0x7f0f83d01c37
[  343.847838] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  343.849536] RSP: 002b:00007ffe63e1f148 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  343.850282] RAX: ffffffffffffffda RBX: 00007ffe63e1f708 RCX: 00007f0f83d01c37
[  343.850997] RDX: 000000000000000f RSI: 00007f0f83ef543e RDI: 0000000000000004
[  343.851692] RBP: 00007ffe63e1f180 R08: 0000000000000000 R09: 0000000000000073
[  343.852405] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  343.853112] R13: 00007ffe63e1f740 R14: 0000000000414da0 R15: 00007f0f83f3b000
[  343.853789]  </TASK>
[  343.854109] Modules linked in: cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cxl_mock(O) device_dax(O) fsdev_dax kmem dax_cxl cxl_mock_mem(O) cxl_core(O) dax_pmem(O) nd_pmem(O) nd_btt(O) nfit(O) nd_e820(O) libnvdimm(O) nfit_test_iomap(O) [last unloaded: cxl_mock(O)]
[  343.856252] CR2: ffffc9000f508033
[  343.856656] ---[ end trace 0000000000000000 ]---
[  343.857172] RIP: 0010:is_free_buddy_page+0x39/0x60
[  343.857678] Code: 00 00 00 48 c1 fe 06 eb 0a 48 83 c1 01 48 83 f9 0b 74 30 44 89 c0 48 89 fa d3 e0 83 e8 01 48 98 48 21 f0 48 c1 e0 06 48 29 c2 <80> 7a 33 f0 75 d9 48 8b 42 28 48 39 c8 72 d0 b8 01 00 00 00 c3 cc
[  343.859395] RSP: 0018:ffffc9000f50f828 EFLAGS: 00010286
[  343.859929] RAX: 0000000000007a80 RBX: ffffc9000f50f8a0 RCX: 0000000000000009
[  343.860614] RDX: ffffc9000f508000 RSI: ffffff7c003d43ea RDI: ffffc9000f50fa80
[  343.861333] RBP: ffffc9000f50f838 R08: 0000000000000001 R09: 00000000ffefffff
[  343.862076] R10: ffffc9000f50fa38 R11: ffff888376ffe000 R12: ffffc9000f50fa80
[  343.862753] R13: ffffc9000f50f9a0 R14: 0000000000000006 R15: 0000000000000001
[  343.863477] FS:  00007f0f83e087c0(0000) GS:ffff8881fa8f8000(0000) knlGS:0000000000000000
[  343.864268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  343.864855] CR2: ffffc9000f508033 CR3: 000000012dec6003 CR4: 0000000000370ef0
[  343.865542] note: daxctl[1266] exited with irqs disabled



