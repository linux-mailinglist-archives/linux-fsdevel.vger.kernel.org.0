Return-Path: <linux-fsdevel+bounces-24200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D793B2E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0145F1F222A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04215B138;
	Wed, 24 Jul 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpZp03RB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515615AD96;
	Wed, 24 Jul 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832055; cv=fail; b=i31kvbCmdtad60AqP2GBbZFZeQEolM6mWn5W0TGoon7P36Tbcnhmla4J0EhanI03qgpRGplCeL9lZy1defsZQPcrvMR094RR+8amHosVi4KdGy5Nvx7SQHyFa/YMxz4nw2zB5OO/CVXbUcVOSmYiAvFAvAcDp9sl/rJp01gyVvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832055; c=relaxed/simple;
	bh=HpSh8bvQPoseYLX6HVboE2oyw6greLNG39EPQhaIK4A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=McCma/qu4lltLyeNg50orBA9ePMoZ4z4x96+L+2fWcawUMSPB0ufAksEf1OxVb4A3oqM+HLxZ0wTeg05W3nzrodnZlfzR22JiycDh/xTF/q3Xx9zWbc3jRdh9iCN8vLqU1gChPOFzzhn6JGc4S6uoQJy15L7bWdQmD+qgb8pFUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpZp03RB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721832053; x=1753368053;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HpSh8bvQPoseYLX6HVboE2oyw6greLNG39EPQhaIK4A=;
  b=CpZp03RB0x2BMkGn8C2mjZNGIu8RNsb0T0A7nTXPbE0BE0DbbuI5lL/X
   rhj9ulZ3RGNDsWk0L+ung5frx88R7XQ+XHUBL2UMOZqOlHniHS7xsoJ6x
   x9w89wGYjF7l5TEJgrHkFdljsEtRm2ohk0n03ztsfl5D4t5Jl558FCsWt
   /2msW/j63pmi+AoC1FKgDjcWO6TAnBwxTLmwsNj7YSEPnYQyrm/aDYwpb
   WR3GXlnyHqq9c7eN0uMB0YY1oyvx36HUqtHz93/M7mMXeCXbz5w0eIwze
   vDaMyswH+vTFXpIsyFt/+/g8uXi4EHmet0TNZ6C9KsExxyr/Ec3gAO5Mu
   g==;
X-CSE-ConnectionGUID: y30hyAiwTZqCP0kS/9gJdA==
X-CSE-MsgGUID: Y/PyTgmgS6ajhfAImmAePA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19369386"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19369386"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:40:52 -0700
X-CSE-ConnectionGUID: vheZ3cLlRUK5g1m6Ckj19w==
X-CSE-MsgGUID: rh+MIzZcR0mqHkKgrrunJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="53377008"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 07:40:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 07:40:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 07:40:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 07:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbnmbeVHiR2HYau4jRRV8ZhbJoJeIQvHw0cKS658poNOdT6tGICblW5Qo3DkO4ip0pkJngSNOLBPPau/K7Kt3SqZcCJPQxdNqokMsqDBYdUCV4f3V1S4iJOkV9HE7zs41iHsh656/eyyCFU5ddExILdZnAphd2ksuQ4yINxb9qP7QholzbcWu82gXiCEdU/KPX0TOyGd1QhUakYosV5bzQDzkh5Ri1tjQmES8txMPipn4ZdyAE0OYiiMT/4cFqBqq9j+rncoe6UUgoUIU+bRYqMjEmlEhEuojiMoM67lykI8QCrqC+9LAVjMimpjk7gV2mMuSLLd0/TDqyOSzXiOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba9+QL4PExn14RgEYZijvX8UcIhw7f7JbLZ4gDOZ+1s=;
 b=KaUd0dbnqh4wa1Jy+62QpyZYdLNtFWls50hO3gqabTeuB65pTyq2wvCQjQZIN//SXtXGoEvW5eCpZdYu6Y0Fm/TgiyapQQ6k+j9Bf/AAsXo0WvRuwKMssNwDRH7/t9YH7+Ew0Pa513GEp4STDLdVKn0FjsMsHG4UxGsu2ozbDiQpGK/5iPKhSv1XfXCWuP72kXHPc02tHc48heJ/OgMpAK05m52Mat4evblslUcvJeeZBemqdMoab7dTeS60CgSmzA1Ksufui5/kdaoB9qLWFCqfCVkVHYBR597Btcdq7EhR59pg13GfPpTL5NEv7AMTNTP/Ch3BNWUbjAi09bpaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 14:40:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 14:40:44 +0000
Date: Wed, 24 Jul 2024 22:40:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>, Christoph Hellwig <hch@lst.de>,
	Shaun Tancheff <shaun.tancheff@hpe.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [filemap]  9aac777aaf:
 phoronix-test-suite.iozone.1MB.512MB.WritePerformance.mb_s -14.0% regression
Message-ID: <202407242232.9109947e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5ca942-e9a2-45ec-735f-08dcabee997b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kNsKC7WGFpU8E7W5XaHe6FBAYcZAgHxlRAofukmqE0Y165nNn/gUn6O6iV?=
 =?iso-8859-1?Q?/8uVLHId79ea1CIelZagoM/DFFeEktmqWskC5uEccD94WZFqkqubySsvnh?=
 =?iso-8859-1?Q?XsHDILFbrqThoMJ+BH3In8n8l5OY533JuAqGiO7n02bod5owmiAUdjNcOb?=
 =?iso-8859-1?Q?N8apota4IsTO8MeLRJrJar+H0VT8kK4rlgXvHBs9z2aly+UOAm2n7s21nm?=
 =?iso-8859-1?Q?BIvq5X0ELLYHuxDURjT2/UpSFYO7q/idMzbNT6g1e7zPiM/a8oFmmgO1py?=
 =?iso-8859-1?Q?5jRCPho5mdCXKs1F9XDQl+haYhgzGmPZ8FJreXdmo3kXotHetssF6xNs5q?=
 =?iso-8859-1?Q?qEvuWFVmuyokTEDZ2WPUoY0YnpxZQ9VOx/pqMSUff2kCO4mPX3cL9HC+WY?=
 =?iso-8859-1?Q?fh3ahZuKeBRPr90CWk8TIDaRzghZjA8x00LLL6J0MhOqXDTDBzBWWhmfYT?=
 =?iso-8859-1?Q?CgowSEhwCSxSJfUop/wObbx7DVIFtcgCpWhGgait1H6N87M3X2YN4BjQ4j?=
 =?iso-8859-1?Q?qQfggYng6xn9zBdh7Si0VXKsCvhyAdV4lXEp+JvLSYyy2vPbhFr5lHxHU9?=
 =?iso-8859-1?Q?qlhdrw7uadBgSN4RYLJIw+CDgFvvEuvvDYwwLMt+GGRlfNL+/cy8GqAXSO?=
 =?iso-8859-1?Q?c3WZtvTo3F/olVMkzVP9J0k7zdfzQzeJDt9ZRyBU5hm0kLg5Z37Kn3UTHz?=
 =?iso-8859-1?Q?Wo/g7gfDpNvCkH1DqYZ4HXTXcAoo4u2sNy5VWvV7Beh+tsolWdxcbFaqkb?=
 =?iso-8859-1?Q?8vO/h6UK1DBzI5RnJ8DVm5oVnF0NQhN5miPePFKZDQ9NDy6Hf34V8IGNmQ?=
 =?iso-8859-1?Q?pr2FEQ0iT2mgBXxquVQhnmDZy54HswPZRJ0BnPKlAHkIxmy8u5T+33qwNf?=
 =?iso-8859-1?Q?VQcGbZqa7RMWO4FHf4R/rbHJDY9d/GMU9ppH54q1a0UTKYe8x5F8y18Im7?=
 =?iso-8859-1?Q?A06LnQuKA6EJK4ZDf0DjfRRXNOaz+l/m+zjg5wJsLnXaDkcL/dYcCo3NCk?=
 =?iso-8859-1?Q?gqCp6BJbixbj5N/HFXXSq+KctJnqITARY0dvftV9kmvINn0Jd0BaTeTZHN?=
 =?iso-8859-1?Q?W3gdZK+kis5d2n81i06otCM2epcF1H8LC7zWdEkWnrtf652Y9XGxH2SuFH?=
 =?iso-8859-1?Q?jmhrFK13VUbdwXxMOOhrOYHh/B0Ges9N5sOiGrSh+PLMniGFhOV/6Ed/RQ?=
 =?iso-8859-1?Q?jEAdE4UiupGHc35bKV33WXWvYEOVqteXdQLgDf5ldoaAt9WYUr/sPql8Il?=
 =?iso-8859-1?Q?zD+12PAteu/hgP5wwdSe4hXeBFguPNNV4aFTAJvUokaxlsNj/Eo1I3oB9l?=
 =?iso-8859-1?Q?M01y+E6BuMFLgvMuwQt9DQzRlzI1IJqFog5h8xM+A+4+vF2RCZogBJuIB8?=
 =?iso-8859-1?Q?8PXESoI0Q1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AdFs8fo/ELtKe8KTNc9yob0lDS/HPQ1cmqO9TY9LEG4zQyTHDjs/mF4qyG?=
 =?iso-8859-1?Q?UaJaqICV49ohK85OFSGxhR7UF2Bvxy/6fUH5XDMzpG/KvK0HGCLwkcGNhK?=
 =?iso-8859-1?Q?e8JhMTO9JSv31McTDXRSYG2Ax+angoJM4CzjPoGrvgcStQZ6BpUgXw8vno?=
 =?iso-8859-1?Q?AYhycPBRhhcLVaio9Jv1J6cNlizdlKDBlo2UjYToBH52yy3vvvXEOBcMCh?=
 =?iso-8859-1?Q?L+3LoYgvsgSJuYv+vn/hda91GihUyesntko+d39LBle6gLPlZM5INJLNhU?=
 =?iso-8859-1?Q?hEvyH4nHsAWLGZrujnoT1I0BFVZP0E7QOX39ylV5XMhWkLePPr8djLJ3kr?=
 =?iso-8859-1?Q?AqO0EPqCFsCT8VV6io3GvStKnC+CDt/IWbgM0Yj8Co7gPsWU+erLKsllLR?=
 =?iso-8859-1?Q?DXVYcpdZlbXHZk46SObd1o7EDpJ63+okPBQdXneUGAXIxagxBUYvZxAuWW?=
 =?iso-8859-1?Q?xbIXKD2wJ/JKdB/IHD/75XxfuhpwxAMeM+rFYLmeEBBtkxnhgYCUqJf0DF?=
 =?iso-8859-1?Q?uX4SCOemN8z+b6kG9xX/39A3Jtph8myyHSEgE3qQzkVqzC7HqCLoxd3W6f?=
 =?iso-8859-1?Q?irgtRkmZxJObRuL75wtFxxTx57QMkSrdv7uYHP5QU+cRTpDmWlD9zFDWfj?=
 =?iso-8859-1?Q?OG4fY+O33yFbd/lkxAUmbtgomtg/XzpmyGoH+Z3IEwD1q1GM5DTyFKFnVc?=
 =?iso-8859-1?Q?Tl3K5yqaYtMir+pOtD1HD8/27xDQk/MnwuC+OCllq0AmZUjXzkp3429iWV?=
 =?iso-8859-1?Q?poO/eco7z4XAWHa/p19viZUQQoDbORhilzxq2b4JZvQHONeZomhwL8HC3F?=
 =?iso-8859-1?Q?QNJpFeOLQahSHUOGppqHbvGkZLyNwgUCcLMI0IN7JENvlI/rDr9b4jSOpf?=
 =?iso-8859-1?Q?SlvzWCzFlDQ1IBnF8lTAUvqYC19/DsWDTJb+b2RP76MdGDnw7CbMeN6rb2?=
 =?iso-8859-1?Q?HJ3SHfgDuiJx+Dgn9fhNDo9299cD0mkT5sYX81n2qaTGafsooyZ+DisnrM?=
 =?iso-8859-1?Q?6fy/cWwICemt/kuYN/e2SpEEU8iYEI4AouSErLFlr3Pbfe+8i1WKUuWfD7?=
 =?iso-8859-1?Q?Ja02toTR8wLTi6KUf2FT9eQB0k9baLI95Xy8bfZzv0H2bNaVESYETe77jp?=
 =?iso-8859-1?Q?a0IlLSKK+wuHsur4vgEZqWSc5A75SESbvL/C6I/NGuG9ObrsHjssPMnOpv?=
 =?iso-8859-1?Q?ItaIImuuxM7CjnN2IyaE70IQO2YIb+qRW9/kHHK9dpwMRK8rCXtbdAfPAa?=
 =?iso-8859-1?Q?Kf1Vb1HjjDmxNwwCgmFoaY+Cd2DHUctgGo77FOMofmqis33p55KJfo9BRX?=
 =?iso-8859-1?Q?CniZ4SPtK8wI3fL2yIFZBUv1z+bJNlPQF8qzK7NggoAwjFl9oRYOo3BYjX?=
 =?iso-8859-1?Q?Z4kbNR0GpZ5w3yJm8mrKgORuiNVUTQI8/TtQJw6z9cL7UYBKMupKIP3GT5?=
 =?iso-8859-1?Q?Rue19I9py0jtDzRWnzm1PdI7KO/BKPc4/Wg5rM2WNi263HVGDM6lFal2ja?=
 =?iso-8859-1?Q?fzyP09mW95jjK27d2X7JEs66NJlcNkEUVoL7YBzZbGpRqa6QRxG+90d9Oe?=
 =?iso-8859-1?Q?nMLydvM0oh4BJGAUVmcUVFe0LGHlJoIFZdE90QGPrn7romV/N4dUzHRoBZ?=
 =?iso-8859-1?Q?OAPvY8oETwjjBlr5UtgbBS4ctErtCwLeRhTvSOXphdTinvQ3ASwKvdwQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5ca942-e9a2-45ec-735f-08dcabee997b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:40:44.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1pa50FFbNgpJ6wUyh1DFarvjx9wDien2r7964NkR8iKCOtMjVFug81whsHTgWVlM4Byjk+jgH9Om6Byw1JjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -14.0% regression of phoronix-test-suite.iozone.1MB.512MB.WritePerformance.mb_s on:


commit: 9aac777aaf9459786bc8463e6cbfc7e7e1abd1f9 ("filemap: Convert generic_perform_write() to support large folios")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: iozone-1.9.6
	option_a: 1MB
	option_b: 512MB
	option_c: Write Performance
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407242232.9109947e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240724/202407242232.9109947e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/option_b/option_c/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/1MB/512MB/Write Performance/debian-12-x86_64-phoronix/lkp-csl-2sp7/iozone-1.9.6/phoronix-test-suite

commit: 
  146a99aefe ("xprtrdma: removed asm-generic headers from verbs.c")
  9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")

146a99aefe4a45f6 9aac777aaf9459786bc8463e6cb 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3043           -14.0%       2618        phoronix-test-suite.iozone.1MB.512MB.WritePerformance.mb_s
      6003 ±  6%     +21.0%       7262 ± 21%  proc-vmstat.nr_active_anon
      6003 ±  6%     +21.0%       7262 ± 21%  proc-vmstat.nr_zone_active_anon
      0.62 ± 43%     +90.5%       1.19 ± 43%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.avg
      0.62 ± 43%     +94.9%       1.21 ± 40%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.avg
      0.59 ± 36%     +99.4%       1.19 ± 41%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.avg
      0.59 ± 36%     +99.4%       1.19 ± 41%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.util_avg.avg
      0.62 ± 43%     +85.1%       1.15 ± 39%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.avg
      0.62 ± 43%     +94.9%       1.21 ± 40%  sched_debug.cfs_rq:/system.slice/containerd.service.util_avg.avg
     60.61            -2.1       58.48        perf-stat.i.iTLB-load-miss-rate%
    910966            -3.4%     879846        perf-stat.i.iTLB-load-misses
      5100 ±  2%      +4.8%       5346 ±  2%  perf-stat.i.instructions-per-iTLB-miss
     57.76 ±  2%      +3.0       60.79 ±  3%  perf-stat.i.node-load-miss-rate%
     38.99 ±  2%      +3.9       42.85 ±  4%  perf-stat.i.node-store-miss-rate%
     61.51            -2.1       59.37        perf-stat.overall.iTLB-load-miss-rate%
      4574            +3.3%       4727        perf-stat.overall.instructions-per-iTLB-miss
    885569            -3.3%     856059        perf-stat.ps.iTLB-load-misses
      0.02 ± 58%     -72.5%       0.01 ±119%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.00 ±103%   +1162.5%       0.02 ±112%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 75%     -87.1%       0.00 ±106%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.fsnotify_destroy_group
      0.10 ± 27%     -64.5%       0.03 ±105%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.06 ±  4%     +89.3%       0.11 ± 27%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      0.00 ±103%   +1487.5%       0.02 ±111%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 79%     -90.8%       0.00 ±104%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.fsnotify_destroy_group
      3.89 ± 36%     -31.4%       2.66 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      1097 ± 14%     +28.8%       1413 ±  6%  perf-sched.wait_and_delay.count.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.02 ± 18%     -56.5%       0.01 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.mmput.do_task_stat.proc_single_show.seq_read_iter
      3.87 ± 37%     -31.6%       2.65 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
    425.39           +13.0%     480.82        perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.09 ±102%      -3.4        0.72 ±223%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      5.98 ± 87%      -3.0        2.96 ±176%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
     15.00 ± 80%      -6.8        8.16 ±147%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.27 ± 61%      -4.1        1.15 ±223%  perf-profile.children.cycles-pp.sched_balance_newidle
      5.27 ± 61%      -4.1        1.15 ±223%  perf-profile.children.cycles-pp.sched_balance_rq
      4.09 ±102%      -3.4        0.72 ±223%  perf-profile.children.cycles-pp._compound_head
      5.98 ± 87%      -3.0        2.96 ±176%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      4.09 ±102%      -3.4        0.72 ±223%  perf-profile.self.cycles-pp._compound_head




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


