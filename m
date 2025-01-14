Return-Path: <linux-fsdevel+bounces-39100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48CA0FDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0851889075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3D39ACC;
	Tue, 14 Jan 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCsVTbjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CA8BF8;
	Tue, 14 Jan 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815993; cv=fail; b=f6xl8itIr9DDXXHGHBmT24us9czd4O9WzfUAoHm/BhSitXKDIzHhUG5+w5jwQlcyPiH2mdrjhEMPFxGlSdP6G/Ua3Ps4vp2OMc45c3CKJlotIXvv28XlyzA7/4la+pN25ieewZa7IsHSok8rLBGIB4qkDpl9Jx2mno3GBwvbxoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815993; c=relaxed/simple;
	bh=Fy+oWXZoO04vfjx8tNv5ufVOKcON14nWaCUXDKfmSp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VL6nmcqBLRxXrnxr1z1jg52GwAf9EipDynz/E9/v7lBUymdk54ZXkaRXo4083JoTYkqZqToK1vahCcL+2xpYpFtbdSl/1IPbhxwRCQcLvGNj9nXfxx8bhiEeLR5oPUjFreX5DhLvUUtUsoBYUEv6eUroKKTtCGIZEus+taDDUyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCsVTbjs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736815991; x=1768351991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fy+oWXZoO04vfjx8tNv5ufVOKcON14nWaCUXDKfmSp0=;
  b=bCsVTbjs3YqdkwG5hYjwh7+tnLrpvZlNtZVPt6/TAC4YOLUj3k3Q4FxY
   erF+U4vsjZOCZJrtCYf5MPRnxjl+CZ3H+dn/60+o+MXV8BHWPis3SuorG
   Wdltiewbb3JZizItqn9ra+xERadWUM48bcD1PzgRW3gdk4bPq8nHg9Wmn
   +t89zALM3N8+lu+N9Rd3nMaI+XCpSVqIysPyCmpv7m2heWb50AjvH4vpy
   mntUTG1k6WbObaA7j3J6+WQpPRTbNCuSr0syXayJf+zWcw+hfCwOTzvUo
   kP6p9/+QlZY9TroB8uTzs3blXed1/K+MOKm8ozptBDz/MjMcuF9Y+wgzL
   Q==;
X-CSE-ConnectionGUID: SnzCyGhTR2qSg/MYG0qliw==
X-CSE-MsgGUID: EWGRm78yTciOEM8u0vG09A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37214024"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37214024"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:53:10 -0800
X-CSE-ConnectionGUID: Xdfvy6ZzRY2Dp4I70+/E0A==
X-CSE-MsgGUID: Yd2HPV1ISBiIEUdNw3SCvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109632548"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 16:53:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 16:53:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 16:53:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 16:53:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+s8H65ic82k/zpoElmrgYd+q1o5MPG1Y29NJHi53TFJVZ6SsLtDgDzQ5y6A+EZ9+8fx3ktYvAThbUROaiCBQ+q12if3sTcb8ZTKSFIu5dRYxKF4Nrbp/qvvktbfja2qm9gLMEWS6jY+jq40Rr3AXpkUOo2OlV6Y/89FWrhCl95gIATAXKdtdKMIKwNT9SrhH5v//o5t0LlTIuZbGjtw4s5HlGx+EJqo8FU+f4ZyLmTl/338965PCFkWRzB02yv75hOm85JXgiqKDfH6Dvb8s+tDlVO6yeSTeYSAa+fn8co1l5u5wJcQhS//kCJOpfmahMwoL83ezClKuLKUFUhtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSFxISSDfwluD9O4dg9MCl2MFC9m1ysTr2vDH0AoHOs=;
 b=MWq/TmrCSbtTCqA/oz2t+P7wZsbb9MqoKXK/q/jFpgxY5Ms/LoWdNkWSg5/ECQbeObaah3/QjyH6Qm5ihF6ZVNDODn16V8NHj+eQ83uDgKxrFzb6aVpDELOnikzhbOirdqGuwkfHYKSyR4yEwGgQFkJ5UEZiGx/EeXZYfb5/cTS1CYrsHuiAh78qPII84bHWhDxrmEOd8D8Uu9sJxyRjYgHhdLrY8Becz4o7jqKU7s7nSGY7LukYRBToSIFou5PJ81sgvF1kZhsFQMnNt5l5BCn4uHcO8sTYiU14jKiw5rT07Im/XpnR4wQtaoLZQAtoxbxim4AQ2qY3AI7LOlne/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 00:52:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 00:52:38 +0000
Date: Mon, 13 Jan 2025 16:52:34 -0800
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
Subject: Re: [PATCH v6 08/26] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping
 flag
Message-ID: <6785b5525dd93_20fa294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b8b39849e171c120442963d3fd81c49a8f005bf0.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b8b39849e171c120442963d3fd81c49a8f005bf0.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: db15e0ec-4b30-4357-c226-08dd3435be4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lm9PI4H+wuCESxA3g7ET6waP+GNpzkJxwe5KTDwsIeYBp7L5aJnuJyrhFkX2?=
 =?us-ascii?Q?dw3LNAL84pUfDx3ubYGlBJ1Pfq0UuUIDoBf2bZouHGumnIrPW3rNmzwDkg7m?=
 =?us-ascii?Q?Fi7bTBIiuM56+iOuDJl9/obgjIar8FP0zORfJZHtIWsl7wUsRPEhSdXJSZP1?=
 =?us-ascii?Q?uwHe23lDb76TJBbRYzvvHMmjIJNuzjc7YSGBHNMNafUl2JfA8OFRugEFr12t?=
 =?us-ascii?Q?qicdbMstYSGzuZnWwhUfFRIp9lyzDLOSwLeZr3rK9MBzDI5/kHjyB4FyhhoJ?=
 =?us-ascii?Q?26Helyn1gwOKxODX8MSzf9tFaBwBOEMbKh39SEOGr/Q8ypqLpnna0NdWgcUj?=
 =?us-ascii?Q?scmZ8LZ52h+CVw2CFmQGyS5ZFQ3jbNrW8qY0BzercAbmZfNZNd3WGhdTafd7?=
 =?us-ascii?Q?9uokX3v0ckzAghIAa0ckazBBEqcrh/qaXQ17178eX3Cl1rOL1YoyHRYoApqQ?=
 =?us-ascii?Q?Rv6oBUqsM0UhaqIWQgfb57JzDpKvpZpKCalzCwBHwjQGiMInS58iUU7yZAp2?=
 =?us-ascii?Q?6LCxV827zeF1LASjKOImhvZGhrM00REoo0JlhI+y5n3qO2yjIEBCgQCIs4GB?=
 =?us-ascii?Q?HFZmzpLXjgILTonpApLcA/a3U/+0c8XRDXRzrPX2qo4jVHLWZGH03oNC2TBy?=
 =?us-ascii?Q?x1YKAF2bIywlNjhHeVJVsQpAidK+4u4KqhBI25+YAH50FoYP9yzi7NLufaos?=
 =?us-ascii?Q?wmkJqE//6Ra/3M8PNxNSynTSGULywdK8WSMP03pvHoHGd2drmRsGj5lEGrTz?=
 =?us-ascii?Q?UU39tsdE0UuHGg/bH4psvfRbOWaVfw+2byaY8ynntUeZgAqm4RYYcNqogAnV?=
 =?us-ascii?Q?VsxUZNLNWO9FDneRWMvjnGiG6QWPEUDI5kfQiDPWl83GgnQgIQwWsK4U2vwG?=
 =?us-ascii?Q?06rWX5Ojm4QvsI99bXoVJ9XF6fhGSnc2woZCGYiLIRRVjvgOEAeaYSEqDXh9?=
 =?us-ascii?Q?BKDld8/SFohqHga8ylL2VoMoD/arcfKwukXEuaQ1krUozmvQj7ac13bXpAcY?=
 =?us-ascii?Q?Rh7YfvsftxTSR19Ei8f4gIOeE38AZePywkSzQBh1B+wbf/E4fs0lKfmDLihR?=
 =?us-ascii?Q?i2Vbx+ckSf+z0jzWMcDjYRWmCMbVBRrjPPJAAFXZ12jHkX64xUMp2AiAF34D?=
 =?us-ascii?Q?VfB9u9ndWKxJ6/jU9NQ9mFc8EUH5WQ1x6lwV6+C+kUPkJqxrdnD4PQK0EXQq?=
 =?us-ascii?Q?LqbudIDloNIYRjFxHQyawyHKgpQ0OSHw0kZGc8hi13JiT69ckhJTSupDijLb?=
 =?us-ascii?Q?3RHMg/LtbYyQeDX+/sU7g59p7J5Obaqhak/skdg6gF0OoMvWcgV2s+qjErhs?=
 =?us-ascii?Q?3Rje3GRHNNINAkWCuEfvUB8iZb2SfdJObJv1MmAsDz2yN32AT83uwB+GuuJ5?=
 =?us-ascii?Q?NXAwhq8W0Fsfat/y2vEA+5qG7PWv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7kILchC1jUZPK8aasoyuhFxfE9oHnrN6JsvA4pP9BDeXZ5d6SGPO5pJ6+68?=
 =?us-ascii?Q?LaPLoM9wFyZegGpbuGvPfe2Iqq6jwYH68xmu7WcELiXyd1yJ3t1tLhJSP43T?=
 =?us-ascii?Q?svVgGG9n8wnsc7nMd7h98zvIk8D2gLZ84Xmog+a7hBPbGUQIok5O4vdjjRpz?=
 =?us-ascii?Q?bf2sbqWJ7vRBNxcORm+cRefiCTRLCJMOHKGsyo3chewfR3S+szHEFPxbYKFj?=
 =?us-ascii?Q?9p5UndGsZ0VCx8f5UVchYcewXnXzd0XJsSi7MyoUkCDXgiqtLlQ49DutB/tK?=
 =?us-ascii?Q?AGDa6E8lSiMfHEbF6SwNAzfcyXY7yh7kqc5nXLWRXHLSJa5P0nYcPy9mghg7?=
 =?us-ascii?Q?Iewm+8NF9mV4TBzAuNN0zDf9AT3MtpsuHji3a0mCO9lDCltVzqbEZ4mRPlwy?=
 =?us-ascii?Q?lyrwz33VOYx93KIDva4wh5UfdJguIMKu4H03nEu6XO3QLdwKBFUR7pvGh/2B?=
 =?us-ascii?Q?Eb9X3EI/weDUMVkHrvlirNswInxYGvuwDiDlEmb+FzP7XchKCXpXmTICUirb?=
 =?us-ascii?Q?/sxmp3mJ1KaNtlM6D1v/FOGlpLteoZ8fhYGNLtQdLr3I6OXRcB+JSihyVqBN?=
 =?us-ascii?Q?GgkMAB0Sxav/sn2TCJgbLoQoacITSK7QjvpKTk0Ipk+UWIyLhJo0scRtVjyY?=
 =?us-ascii?Q?oGgS6rG2vnk5aLnC6Mdx2sDrSop4c4buzQWuVePAQApmLVOHqlJ/TQCuWokx?=
 =?us-ascii?Q?pnaWkrtho2tJBCC2kPl9MObBo2oCyu9pIV9Pfgln40HlbiH73XQoXEfH5P0+?=
 =?us-ascii?Q?R8YbKqUvv+lHHNR5bWv6S7QgA3RxDjjF7Z7sOilhsUjNA0eTpEFPYugpY28k?=
 =?us-ascii?Q?Oe70SV6DDJs7SR4DYMqVPk2MmRhMMWA1wX7H3A0Lgoi6pdzr4JAg6X7CUYO1?=
 =?us-ascii?Q?2WS0XrXPo2/AyxTf31MOJHICA7UnHbTxW+2lVwe9na2ldYihTp/Mpe+p4DhO?=
 =?us-ascii?Q?gr9XayuYcUfp/5UvvSVnvAwcDWRpDOUmrgn06MO+qZCJ65XmTyNrM+y8IomD?=
 =?us-ascii?Q?HWQHXywn7tsOSgsHkr/XdPh6+AznzUgwvuu9jBg1yB8C2xV2e6Cs9pmeuSpF?=
 =?us-ascii?Q?kmxnP9vPW7MLoRd0apuPVBA587vyCVOFGMOgIvN/sz+OWmw+WKwCy1vXXoRO?=
 =?us-ascii?Q?ADSovHrs3tmrJP708B6ko7DeSlTnzcXQZPztHBixlfNHwLEz3h7F+FwcNeE0?=
 =?us-ascii?Q?5sGz5RRQ1ElLF+dbBpQdawzf0xrC+XL5dxg+eLfopz/8VlCak0zv+tmrKcq3?=
 =?us-ascii?Q?Tr+1dKP54gW35FONI3E6Wko9IMqQEoM44CUBfnwL/pvBZHeCGgQAYCsFPfdY?=
 =?us-ascii?Q?fEOtbIJSLROTjT3V9qnmtOR9McQqW/PfyNW4ELsaeYiI5+UtVELaHsftHzMm?=
 =?us-ascii?Q?ilg7W14IOvX1CYU7bnaGv1XMEKhEtdTzg7pwMlh5707+N9uOi5BVJ92z3dF+?=
 =?us-ascii?Q?zsK/+7hHCN+p1pzPQD4NkFJfzzUOC7tyBAQx6OAd65gToBqGULjcPihRLAzg?=
 =?us-ascii?Q?X4vXg33SAMFu6NxYhmiAvxGFbEOHpzVMbqKHze9mAxLYIl/im6oCCVf5s4ww?=
 =?us-ascii?Q?IbXna+Y9j8ACOiyhG+WvDtgAh6ptYhNAtMoGTOIJoxr1mbN2a/BNzuIBdSH6?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db15e0ec-4b30-4357-c226-08dd3435be4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 00:52:38.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An4+64mw0PfVogtGYCWgxhrg/FuW2o7tBiugwuVa0To8jeh3MXKNhHC5yF0XbaNIbTi8viteIXLs2HHa7UYBEyBzFwKIzwdlk1jiLx/471g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> PAGE_MAPPING_DAX_SHARED is the same as PAGE_MAPPING_ANON. 

I think a bit a bit more detail is warranted, how about?

The page ->mapping pointer can have magic values like
PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON for page owner specific
usage. In fact, PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON alias the
same value.

> This isn't currently a problem because FS DAX pages are treated
> specially.

s/are treated specially/are never seen by the anonymous mapping code and
vice versa/

> However a future change will make FS DAX pages more like
> normal pages, so folio_test_anon() must not return true for a FS DAX
> page.
> 
> We could explicitly test for a FS DAX page in folio_test_anon(),
> etc. however the PAGE_MAPPING_DAX_SHARED flag isn't actually
> needed. Instead we can use the page->mapping field to implicitly track
> the first mapping of a page. If page->mapping is non-NULL it implies
> the page is associated with a single mapping at page->index. If the
> page is associated with a second mapping clear page->mapping and set
> page->share to 1.
> 
> This is possible because a shared mapping implies the file-system
> implements dax_holder_operations which makes the ->mapping and
> ->index, which is a union with ->share, unused.
> 
> The page is considered shared when page->mapping == NULL and
> page->share > 0 or page->mapping != NULL, implying it is present in at
> least one address space. This also makes it easier for a future change
> to detect when a page is first mapped into an address space which
> requires special handling.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  fs/dax.c                   | 45 +++++++++++++++++++++++++--------------
>  include/linux/page-flags.h |  6 +-----
>  2 files changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e49cc4..d35dbe1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -351,38 +351,41 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> +/*
> + * A DAX page is considered shared if it has no mapping set and ->share (which
> + * shares the ->index field) is non-zero. Note this may return false even if the
> + * page is shared between multiple files but has not yet actually been mapped
> + * into multiple address spaces.
> + */
>  static inline bool dax_page_is_shared(struct page *page)
>  {
> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> +	return !page->mapping && page->share;
>  }
>  
>  /*
> - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> - * refcount.
> + * Increase the page share refcount, warning if the page is not marked as shared.
>   */
>  static inline void dax_page_share_get(struct page *page)
>  {
> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> -		/*
> -		 * Reset the index if the page was already mapped
> -		 * regularly before.
> -		 */
> -		if (page->mapping)
> -			page->share = 1;
> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> -	}
> +	WARN_ON_ONCE(!page->share);
> +	WARN_ON_ONCE(page->mapping);

Given the only caller of this function is dax_associate_entry() it seems
like overkill to check that a function only a few lines away manipulated
->mapping correctly.

I don't see much reason for dax_page_share_get() to exist after your
changes.

Perhaps all that is needed is a dax_make_shared() helper that does the
initial fiddling of '->mapping = NULL' and '->share = 1'?

>  	page->share++;
>  }
>  
>  static inline unsigned long dax_page_share_put(struct page *page)
>  {
> +	WARN_ON_ONCE(!page->share);
>  	return --page->share;
>  }
>  
>  /*
> - * When it is called in dax_insert_entry(), the shared flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> + * When it is called in dax_insert_entry(), the shared flag will indicate
> + * whether this entry is shared by multiple files. If the page has not
> + * previously been associated with any mappings the ->mapping and ->index
> + * fields will be set. If it has already been associated with a mapping
> + * the mapping will be cleared and the share count set. It's then up to the
> + * file-system to track which mappings contain which pages, ie. by implementing
> + * dax_holder_operations.

This feels like a good comment for a new dax_make_shared() not
dax_associate_entry().

I would also:

s/up to the file-system to track which mappings contain which pages, ie. by implementing
 dax_holder_operations/up to reverse map users like memory_failure() to
call back into the filesystem to recover ->mapping and ->index
information/

>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
>  		struct vm_area_struct *vma, unsigned long address, bool shared)
> @@ -397,7 +400,17 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		if (shared) {
> +		if (shared && page->mapping && page->share) {

How does this case happen? I don't think any page would ever enter with
both ->mapping and ->share set, right?

If the file was mapped then reflinked then ->share should be zero at the
first mapping attempt. It might not be zero because it is aliased with
index until it is converted to a shared page.

