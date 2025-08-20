Return-Path: <linux-fsdevel+bounces-58415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15DB2E87C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B1D3AD284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262702DCBFB;
	Wed, 20 Aug 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPPzOL+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3412DA76E;
	Wed, 20 Aug 2025 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731703; cv=fail; b=TZ5Y3BOX4NSrJnSx9fZr6DDXyzlsZts9rdYXOb2ZmQ5qtVVbRfAW0mqCo9Mg8KwAzPxfuviLzj7rSXz7zv/QGHPrvFt3Bgf6Igt1WeBnd0TDkFy+hSiQVM6WS0mqCC/8ACkqiHfr/hV5efVFiOF3PbHQBk+wyNQY5o5Qy2Dy6RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731703; c=relaxed/simple;
	bh=MenjGkEtpqgBjXwIiwzRXS5XPE4HsgHmP+0uq66x+o4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYpcsxL8D49S7N9hdWAjwZAemMJ466DQQX9giMKf6Vcb8aXkf5z5g+iJ86KqGNnOdiN5wLwWhB4lhJs5fVCE6N6YAhr/P/ivRbfeVKcOadqpw9POS5uuwe5/1u7O4atfhSBZq9L5NZ2QNrVsOaEQS5sCAsTULSmmggeNm9kGZCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPPzOL+3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755731701; x=1787267701;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MenjGkEtpqgBjXwIiwzRXS5XPE4HsgHmP+0uq66x+o4=;
  b=gPPzOL+3j4XUBjq5XXSOlufyNjGlc5Ql2Jlouv6GKOoeaup8aQ65U3D8
   W6gzMg2V4bIgW6rJ0zZh7BssyoxJsQSS62MAizWD6XEPWqdK0q77wgLfi
   xLRdhwz7ZaNeGoKU3BGToqbRuk9W6qkkACyTqEbMlW8YO4vrCSHOFePWM
   IA4y+qFT56UoBl3Dxb2PGFvMvhLfOvrMppYXRwJvP5K60ZZ5DyH4ZYHN/
   H/RQZtLtxltInNoLkoQmSfmoSYs6XmVf5IV34oO954fHB0lWXWO92gFbT
   kZ53t+2l9HYM33ATmL3d7bZAiNR3IqcVw9MoN60Fws4qrVDrilmkdfyFX
   g==;
X-CSE-ConnectionGUID: MvxWi4hAR6CEKTRo3+c2yQ==
X-CSE-MsgGUID: JKetJJf2TraK/J8aIKVAtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69386152"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69386152"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 16:15:00 -0700
X-CSE-ConnectionGUID: 1wIyD1A/R9eGModLIFnm0Q==
X-CSE-MsgGUID: Wr7tyi3UTDy8W/pZzdLMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168179287"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 16:15:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 16:15:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 16:14:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 16:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdpOCikQGdW73vc6HVnSueAJ69xV38fkDWfOPIA/RfxoU6LabZu///psuImO2QcNJ0Dan9ZI9OtbSuhNZVc5qPW64eg/ZsUYZUH+2vZt9DdMva31Rj3exWtJUk+TGJmIVEBsiOzjcKNV4jOeAGwx/Mw7ZTDl/q1/aJpUqIyyGETFLO9lOVnKMJEPTFsWo7TEpxV90HzMNPJTKWSQ/sMZhMdcrQZMXpHNfyGj+5KoBxrGBi5QZC58nD2/9HJc3Bkg3M3D5BZ6IMf28fZPBtXucENAmH/obrVbaM3dRlVuE2Mth3/Sk9Jsu31WNj2EScivMyJqe36M1Esnk5boWj4izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eTOpL5jkjn1EKdPdH7PwGmR4CSfmRY/WhfLVO0Yx2E=;
 b=AdbaPYBA0S5wPerA75qdw9cKiUnC4DZ2apQL1ZDbzb5O57hq3VnLeIQpNFp4A4UdblDg2D7sKFvFyT2QB4HwrPelQYdL6TwpsBBhuAIyN1f/PWPEBmxgYnKb+5Cw1i96YpGdiapdP0peZwXzdC1XMVXUcn+y9hdnyZjLGMttLO2eVhIkBNCerMl6T1H7wdJ9xXfAzOWCa8XTDcFz3sB55dUfyIoWwy5hcW7F8OL8f+MBVJf55y0A3N8MNdLtUK089un3xavAw6/uaLJviUtoDiYXdDOWY89skI7wegTQYTu6i+qecrbrnNs6zvBX9qnrdDygwuJnoyxr/TZMwmanlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 23:14:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 23:14:56 +0000
Date: Wed, 20 Aug 2025 16:14:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Peter Zijlstra
	<peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate
 with cxl_mem probe completion
Message-ID: <aKZW5exydL4G37gk@aschofie-mobl2.lan>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
X-ClientProxiedBy: BYAPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:a03:80::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 99178011-3256-493d-a15a-08dde03f6069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vPSYxI6ajzo5L7Qz12NZiHk4KYDVruEIXoF98z32ve4IesMYqWPoWR9MF6I?=
 =?us-ascii?Q?Zw69Pu8P7qfVOfTIyzkPLRJ4vjIL1GQE4SyV2eUAsWzF7nrW6O/KPSEuOqMt?=
 =?us-ascii?Q?FWt/3eSZTgRKSPBDXm1pfj7tgtGQ/mMiOymDTjKE/lfbOA7vdudZ2huPduAz?=
 =?us-ascii?Q?9AseFHYfTK9uo2WDSF+0HDAki5RNYMpjhv9oDLvOCxewAnt8TphL3cXyRebt?=
 =?us-ascii?Q?zkPTciz+P3/QXhdMa5n1JYj8ZaiLdwnOa5SChbHqkLQpcaRc7eMCbc9EXzq3?=
 =?us-ascii?Q?HC/cpBgkAKo5rdqvOGTdc5W5NNuAf7Agy4JV67zpCfwAemoK5eQ3CxAmuBBZ?=
 =?us-ascii?Q?Rzo9YtGmPa/Jxr78ANoA0hb/41jfQ24EAWN9NijF+5fmb/M2on3AeeibC90B?=
 =?us-ascii?Q?Tuy/kYAF0HTWHqwBVWusOg6lnPjN3VFaTjxBsZ3rFeUkOessiG/+/zPNoRx0?=
 =?us-ascii?Q?sh3ONR5cQT23x7NoTtH8msxLw8Luk+JpkCwsimfdvi+H6ZqUQQ/vLPTVfyq7?=
 =?us-ascii?Q?zcG3CmsyN06cYXe1SmQs0WuN0nbl8ZeBxT4SdGI69bPA2QZQs+lhCN5etreb?=
 =?us-ascii?Q?vuYXE00vGX7CuXOv9JMJ+KPyv5of+eckcSNj22Fs+jjTi8UksQ+wrckqUVhX?=
 =?us-ascii?Q?zIFEn7Q1v8Ui4Zywplo2Xtua7mnVcFpTb5CFnkwwlEHKE0t8PpMsCBBuhA6+?=
 =?us-ascii?Q?8l7Kcx7CIDL9lU7tA8ZS2qOWSIA+7YWDQi/uVEkSlXcZJoWK3/J/MnwxEYe4?=
 =?us-ascii?Q?tGdrOtf3t44K1tx0sjx1TWnu76e1vTmPSDppOiItaSkwKLN01ZYRfL6kYYTf?=
 =?us-ascii?Q?Q0pRiME22pNWEh6N81HmATcM3oZJpj6A96YxOOVO4llbj852IYTZ+3S5i12u?=
 =?us-ascii?Q?ruurMDB/51bdOTjlcH8UIHXkG5228vykS/a5JQfPBFkz9jszjW1hDmZxEIoQ?=
 =?us-ascii?Q?w2nOhEMDLbSduv1y3f5wLHiPY3BNCCSVQZo1VVsPgqXexMjLY/suYDZKRlUg?=
 =?us-ascii?Q?+7uEZ02BlQrryfrFVIIJAKXJtfmIjO6HBZ1c5k8ZLlFTCIWWLwjcbDrpBttt?=
 =?us-ascii?Q?soNhN+RddeB3DIeaILrlL7G3WwIlBMPrcXf97tBt9jkxEy6IFY544fBkAF64?=
 =?us-ascii?Q?GUXP6BnE6fnXZw9fsRM3KFtwCM9UxBKuEaeOjVezPQhULkTVnHiYDmh8FKPS?=
 =?us-ascii?Q?sR07GH8jULbpZZLhiS8tPZoXaaCrQUxiu+T5IKN/8zUbAp5gc+KgD73aRVy0?=
 =?us-ascii?Q?7H36PnHi2rIf3I1hGUbm977CFnFRPAzP7SAFDrXeFeGK+kW5sP9QiMdLu5eP?=
 =?us-ascii?Q?Qu0/ufq7QJ3b7SPuC8cW5e7G2hIVoyhmuOfN8XzDim4qH6iyQJqV3/kNENK5?=
 =?us-ascii?Q?eXQ3gfsE/lezeVN4cSfUBzW7TNqmx85K8l7ItUBFUwKFTM7UyYHJXwPNTzNw?=
 =?us-ascii?Q?Xl9XHb59DVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QoWFE4hpyIAqYXGk2PSuigg+XroqwNd1Zu60mvOv3hlBA5AT1xPpjzDEiT82?=
 =?us-ascii?Q?Hw1MDNpkkDhDKf1HY7CX1wutSjJaU+PARnv/QZCVOztfNRuWbH+YJlYECQeh?=
 =?us-ascii?Q?D8Eg7QSwhyjMNEsL9mL18wKT4QBjTg5Hnlbo2q5nqAXqZdJU3CoC1QwxYVL9?=
 =?us-ascii?Q?Pz4tlIY1Y+9L0poOPHIrfXJlwpsUIFlvPEl0lWSapEszZIQlDjG3seDFfZBb?=
 =?us-ascii?Q?CI+RNu0G53lYYFz8iBNV6PkyAWc9z7EATlfEb2gb9F8NFpLOzaz5Wrzo8YQi?=
 =?us-ascii?Q?t4qJCgGPShIeAwcF8f7ocD4g0BjPytISxyUbxsHbahjOA7xsXlPkAkt2MjEM?=
 =?us-ascii?Q?fYXcOjA2HQWY962XjLf2Oa1rmVuXP+LOklykIoNfP4F5jcnfG4s+VetHILqi?=
 =?us-ascii?Q?LEdbuQFUqp61EAZPcx0JLeWZATkl8VBWf1iL39/GeHT6XRARLciKYgh8I8nf?=
 =?us-ascii?Q?kf47Khza7xkrqtE27YKhBTjDQaz/gGrTWRTDlZFM98Q0LTVSjh6LG2WgUjrc?=
 =?us-ascii?Q?eBm23N7tbAxPrytLrI+AGAAG9+tc/JxZOUhT9FTOx2R/GjwWzEJh7uAb151d?=
 =?us-ascii?Q?D7SXUJwDaLPqDjoaDHb3MbmaFr738lnYNtbw8apG1YcINql7b3O4/5lG86Hq?=
 =?us-ascii?Q?GpGRN8FcSe8qWJEHEe3NVnFc2SmTyGuug46aA7Tf3/TTBGr/L4L0Q5dvkzDg?=
 =?us-ascii?Q?93lSU+nGU10/FMgcOZRUfIuUwJw1Daizm7t1ya2Py8wrGqspYEBHpVu3917Z?=
 =?us-ascii?Q?TpKS6EAbt70HcrBOz7/7/tabw6PDbOrlpVRCAPd46foB1Lbg6oX7CK9ZzNe9?=
 =?us-ascii?Q?ZXFNm8dLOcGcSR7DEPr8T58Nw2e/OoYjAHN4GrtFH+keVLb7dE+cBXtMZ2V1?=
 =?us-ascii?Q?oilX2/GCf85SbcxWNGPi5a7hZM49BDYLSVSsXZ3u7ycaV7EOZo15Jbdmis3g?=
 =?us-ascii?Q?T0GS/UrJnK+4hz+xTt4O5j8YSb4JaoBMDm70DtMNFCfndZ/7fibKWZGx1uGg?=
 =?us-ascii?Q?cL2KNKlpA23w98QM1nmSSlWY+Y0NjvVhc01nw0m+yi+KSt/4goMKptIvCu4w?=
 =?us-ascii?Q?413uI2Eh7SEnqFsPIffCJeZrw3MuTwrscuTrqotoiLv1FF6STre3338WCmn1?=
 =?us-ascii?Q?9JOaWKmLuUUva60XoWfF6S6BPN8fR4uRe6ytwELI7qb61lrjmCQMiHxM2jNH?=
 =?us-ascii?Q?78U17JClAhUJUZpsATLVv4IgJeAcJBHli7BHhKhvsFXVnOtRCeAJX/MPr8EY?=
 =?us-ascii?Q?yEmVpjiaNUtXG/DPIxHwSWPIl+lqtxBOYauRO824BhC6pVnxcrdN4sNG2EdD?=
 =?us-ascii?Q?c4K1i76xApSxuxEaHdwNiKKL1gn7dxulO+t9izmMBkdLQtNcJhUOWzCO6llX?=
 =?us-ascii?Q?yuC5hHX3UpkbW3VwfHzkbf7gUj0QDU5q3hoUDp3vX0079u1P0nN7aFGqqd5B?=
 =?us-ascii?Q?Et5JVIzSiG+sC8ltyH8TdsQF8FZjEfvnrgb4h+x7q8TXLcPUWp2ZcUSR2wi3?=
 =?us-ascii?Q?usHgdbWIQUff8Fzh+4H+ZAt4qdxygU1KI7EUn4KStgwn3s+Cwvw/AYsRNZaz?=
 =?us-ascii?Q?pRDwoJLYJAJNvZtxImZp5Hoh6LXUykr4myNuOqIsWnMVwS5Yrm0NR5OfPe+6?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99178011-3256-493d-a15a-08dde03f6069
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 23:14:56.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9sDwJs4QSo2x1fFiAWl8PlJI8P0Bck3e4v4ke5plC7l82aqBNc1QBE0sgv6deWfir7Z6a7gQ8fanA/swAPIvrsWfjDmdUzlj4xS4wqZaeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com

On Tue, Aug 05, 2025 at 03:58:41AM +0000, Zhijian Li (Fujitsu) wrote:
> Hi Dan and Smita,
> 
> 
> On 24/07/2025 00:13, dan.j.williams@intel.com wrote:
> > dan.j.williams@ wrote:
> > [..]
> >> If the goal is: "I want to give device-dax a point at which it can make
> >> a go / no-go decision about whether the CXL subsystem has properly
> >> assembled all CXL regions implied by Soft Reserved instersecting with
> >> CXL Windows." Then that is something like the below, only lightly tested
> >> and likely regresses the non-CXL case.
> >>
> >> -- 8< --
> >>  From 48b25461eca050504cf5678afd7837307b2dd14f Mon Sep 17 00:00:00 2001
> >> From: Dan Williams <dan.j.williams@intel.com>
> >> Date: Tue, 22 Jul 2025 16:11:08 -0700
> >> Subject: [RFC PATCH] dax/cxl: Defer Soft Reserved registration
> > 
> > Likely needs this incremental change to prevent DEV_DAX_HMEM from being
> > built-in when CXL is not. This still leaves the awkward scenario of CXL
> > enabled, DEV_DAX_CXL disabled, and DEV_DAX_HMEM built-in. I believe that
> > safely fails in devdax only / fallback mode, but something to
> > investigate when respinning on top of this.
> > 
> 
> Thank you for your RFC; I find your proposal remarkably compelling, as it adeptly addresses the issues I am currently facing.
> 
> 
> To begin with, I still encountered several issues with your patch (considering the patch at the RFC stage, I think it is already quite commendable):

Hi Zhijian,

Like you, I tried this RFC out. It resolved the issue of soft reserved
resources preventing teardown and replacement of a region in place.

I looked at the issues you found, and have some questions comments
included below.

> 
> 1. Some resources described by SRAT are wrongly identified as System RAM (kmem), such as the following: 200000000-5bffffff.
>     
>     ```
>     200000000-5bffffff : dax6.0
>       200000000-5bffffff : System RAM (kmem)
>     5c0001128-5c00011b7 : port1
>     5d0000000-64ffffff : CXL Window 0
>       5d0000000-64ffffff : region0
>         5d0000000-64ffffff : dax0.0
>           5d0000000-64ffffff : System RAM (kmem)
>     680000000-e7ffffff : PCI Bus 0000:00
> 
>     [root@rdma-server ~]# dmesg | grep -i -e soft -e hotplug
>     [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-6.16.0-rc4-lizhijian-Dan+ root=UUID=386769a3-cfa5-47c8-8797-d5ec58c9cb6c ro earlyprintk=ttyS0 no_timer_check net.ifnames=0 console=tty1 console=ttyS0,115200n8 softlockup_panic=1 printk.devkmsg=on oops=panic sysrq_always_enabled panic_on_warn ignore_loglevel kasan.fault=panic
>     [    0.000000] BIOS-e820: [mem 0x0000000180000000-0x00000001ffffffff] soft reserved
>     [    0.000000] BIOS-e820: [mem 0x00000005d0000000-0x000000064ffffff] soft reserved
>     [    0.072114] ACPI: SRAT: Node 3 PXM 3 [mem 0x200000000-0x5bffffff] hotplug
>     ```

Is that range also labelled as soft reserved?  
I ask, because I'm trying to draw a parallel between our test platforms.
I see - 

[] BIOS-e820: [mem 0x0000024080000000-0x000004407fffffff] soft reserved
.
.
[] reserve setup_data: [mem 0x0000024080000000-0x000004407fffffff] soft reserved
.
.
[] ACPI: SRAT: Node 6 PXM 14 [mem 0x24080000000-0x4407fffffff] hotplug

/proc/iomem - as expected
24080000000-5f77fffffff : CXL Window 0
  24080000000-4407fffffff : region0
    24080000000-4407fffffff : dax0.0
      24080000000-4407fffffff : System RAM (kmem)


I'm also seeing this message:
[] resource: Unaddressable device  [mem 0x24080000000-0x4407fffffff] conflicts with [mem 0x24080000000-0x4407fffffff]

> 
> 2. Triggers dev_warn and dev_err:
>     
>     ```
>     [root@rdma-server ~]# journalctl -p err -p warning --dmesg
>     ...snip...
>     Jul 29 13:17:36 rdma-server kernel: cxl root0: Extended linear cache calculation failed rc:-2
>     Jul 29 13:17:36 rdma-server kernel: hmem hmem.1: probe with driver hmem failed with error -12
>     Jul 29 13:17:36 rdma-server kernel: hmem hmem.2: probe with driver hmem failed with error -12
>     Jul 29 13:17:36 rdma-server kernel: kmem dax3.0: mapping0: 0x100000000-0x17ffffff could not reserve region
>     Jul 29 13:17:36 rdma-server kernel: kmem dax3.0: probe with driver kmem failed with error -16

I see the kmem dax messages also. It seems the kmem probe is going after
every range (except hotplug) in the SRAT, and failing.

>     ```
> 
> 3. When CXL_REGION is disabled, there is a failure to fallback to dax_hmem, in which case only CXL Window X is visible.

Haven't tested !CXL_REGION yet.

>     
>     On failure:
>     
>     ```
>     100000000-27ffffff : System RAM
>     5c0001128-5c00011b7 : port1
>     5c0011128-5c00111b7 : port2
>     5d0000000-6cffffff : CXL Window 0
>     6d0000000-7cffffff : CXL Window 1
>     7000000000-700000ffff : PCI Bus 0000:0c
>       7000000000-700000ffff : 0000:0c:00.0
>         7000001080-70000010d7 : mem1
>     ```
> 
>     On success:
>     
>     ```
>     5d0000000-7cffffff : dax0.0
>       5d0000000-7cffffff : System RAM (kmem)
>         5d0000000-6cffffff : CXL Window 0
>         6d0000000-7cffffff : CXL Window 1
>     ```
> 
> In term of issues 1 and 2, this arises because hmem_register_device() attempts to register resources of all "HMEM devices," whereas we only need to register the IORES_DESC_SOFT_RESERVED resources. I believe resolving the current TODO will address this.
> 
> ```
> -   rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -                          IORES_DESC_SOFT_RESERVED);
> -   if (rc != REGION_INTERSECTS)
> -       return 0;
> +   /* TODO: insert "Soft Reserved" into iomem here */
> ```

Above makes sense.

I'll probably wait for an update from Smita to test again, but if you
or Smita have anything you want me to try out on my hardwware in the
meantime, let me know.

-- Alison


> 
> Regarding issue 3 (which exists in the current situation), this could be because it cannot ensure that dax_hmem_probe() executes prior to cxl_acpi_probe() when CXL_REGION is disabled.
> 
> I am pleased that you have pushed the patch to the cxl/for-6.18/cxl-probe-order branch, and I'm looking forward to its integration into the upstream during the v6.18 merge window.
> Besides the current TODO, you also mentioned that this RFC PATCH must be further subdivided into several patches, so there remains significant work to be done.
> If my understanding is correct, you would be personally continuing to push forward this patch, right?
> 
> 
> Smita,
> 
> Do you have any additional thoughts on this proposal from your side?
> 
> 
> Thanks
> Zhijian
> 
snip

