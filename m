Return-Path: <linux-fsdevel+bounces-46663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52956A93446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EACA448655
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E026B0A0;
	Fri, 18 Apr 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvuzY5aw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9526B095;
	Fri, 18 Apr 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964004; cv=fail; b=PWUCfGGBVL/L3h76VnsIezn6StTcdxfhUBvWyq5EQbR4V91iY3SPuv2AVtzI4p0k95yqvD4NtaKhjLarZq39xr70KQVorcJNnm4jGMt7981bnHemG7qZoNvfrSIpDSUYo92oTqE3BBl3hm4caj/N0eGT0UGycugs/rp7kf/hORQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964004; c=relaxed/simple;
	bh=L13RTpJIGVAN1skNZ5WvmfPqObdNX8DPaHWtQFQSJLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=at45SgjUTMp/VjKW6rOFTxmC89CVFz4H2ukCZ4xi2U/yiDFREQFYJd5djtSG7ADW+y0zD44Q1r2lhiPv6U03lIm4d02YQBs6S1oeGZFbQbycqVE+PA3ekD9AKNw2v8Ptw+pg/aW2FGOocx9okRmGg3wYIOFCgoSvY40Du/BzuMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvuzY5aw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744964002; x=1776500002;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L13RTpJIGVAN1skNZ5WvmfPqObdNX8DPaHWtQFQSJLM=;
  b=ZvuzY5awVktE5qX6Ct8Ar2JkkjVj3nAWog1ZjjbTeSApHR6Ntp6awPRa
   YfVvbAjIOQjoq6dSucnIYZJw9FHaX6E3ZoTwoOdE6boKaP16U4ElX8i1v
   Un1PwDAxTkO0n1ywDlTvpJpFrj2i8HriMaRaUMvFrxuyWQbOlVqYV0fgU
   s8kU3Xav47u96yNdsJfSuLlA+DRf5S2EMz67erAmw8gtrLSGlCnPzsGlb
   TgrkDvdZ5jnbkMaJWpk9anif6IfqGQQ7liBuOJ25QNP0iUmYjXthPPs+k
   9gRjbajeWNOSTY22/Qv/wuLLtwpWJCHovTvLT6gxp8WCkH7rcoov3v6t3
   Q==;
X-CSE-ConnectionGUID: gZIH/W6SSk+y47upmcn11w==
X-CSE-MsgGUID: Ihz/LGl2QxWpbN81q0Hxvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57963193"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="57963193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:13:17 -0700
X-CSE-ConnectionGUID: 8GyCivrITQODPY9HIfSm7g==
X-CSE-MsgGUID: p5tAKDeGSCmRE+cMupGPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="130918466"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:13:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 01:13:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 01:13:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 01:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX5Yj7RyXItThfxtvBm3OLyeNiziAiqQKWftdsSJnQeWVeLfxter4qd1xglTNnNx6U20obMwgnK6UsSP6ubsPgApyDsFUGeQ8gcgfDQChlIKjKQUvKLOl9yxp0bIJEywhlZMLuz6PjMzRdZtDDep8PqXVoMqAnNRn2HpeXcqY2dfOXK4gfsZdvmh3NSQBvIwkO0qIKdXc86Kyapb2KR9FIJp7VAJtTwIAIWwc20FfzCTelsQIb0kzQYoqzuUWNAJHlf3v7glc4bDC759TSQt0PTODSPz1nC9QA9K0yEGtKZZWanJgl1ossKxUQcp6t1nyWBug8V0X4ApM0lajlT3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzqn+pHDYCXZNmnMw6Y6H2hs5sHmmrc+vRvPHqOUusE=;
 b=LZbrBoCZw/+llRCchzktvBB5D8Rcoo/sAWaNH+ezOlRNu4DPAJWDUSGUkG0Cj0OVIVlzjbKtk6MCnCA4w3jFMOdDcRM64CfIC4gvTIVp4nLzoe9NOPcFRNvdOIrIv7E1bsTI8XGU5HSlxm7nH3YfMHt7kWCoBBglzUnSGB8RAJXDXr992qSHBr1AfFa1NNMERSmyE8L7uWFNhSrFLqKQgMGhwrBN4oa29UJCER1Z/wYbwqf3zO8FAsAp/LrtLb10I0+uxO6cI0VfS5qc9AuLLMhtE8wnI609i7mSO0A/wP8snMRsKKUsPjCBWqHeor5MoyiDsPyqgZ/z5Z/m5dh4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF3ECB6A513.namprd11.prod.outlook.com (2603:10b6:518:1::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 08:12:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Fri, 18 Apr 2025
 08:12:44 +0000
Date: Fri, 18 Apr 2025 16:12:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [fs] a914bd93f3:
 stress-ng.close.close_calls_per_sec 52.2% regression
Message-ID: <aAIJc+VxVPQC2Jqb@xsang-OptiPlex-9020>
References: <202504171513.6d6f8a16-lkp@intel.com>
 <CAGudoHGcQspttcaZ6nYfwBkXiJEC-XKuprxnmXRjjufz2vPRhw@mail.gmail.com>
 <CAGudoHHMvREPjWNvmAa_qQovK-9S1zvCAGh=K6U21oyr4pTtzg@mail.gmail.com>
 <hupjeobnfvo7y3jyvomjuqxtdl2df2myqxwr3bktmxabsrbid4@erg2ghyfkuj5>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hupjeobnfvo7y3jyvomjuqxtdl2df2myqxwr3bktmxabsrbid4@erg2ghyfkuj5>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF3ECB6A513:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0ae0f4-5a61-427b-e7cd-08dd7e50cbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9QSzJjSeAVWQsjUt3GTdXfkVFbLVojDqN0c2S57V/zrTL4Ernr5nemzjc9?=
 =?iso-8859-1?Q?AIAI3thXx/+uRuSZQm7EqsGnWv2Bz6Tz+u1BFTwovrGwGXUGdtSy2pVdvm?=
 =?iso-8859-1?Q?M6KtQ+vqnYK8D8UcVzYl1o94Dj+oprmWc0ynI3ogYDlLt1zw3fWFLsZhAE?=
 =?iso-8859-1?Q?S0FrVEavRAa1aMD58wSHTf1MqinvSDf/VkJ1S/II0CoKc34+vETp+uKZ/x?=
 =?iso-8859-1?Q?i7Z6NYMpKeVESlgMJTDfhDV0xyk7yhT0/kIHV17Ibq9bmMtCKONsB7lUQe?=
 =?iso-8859-1?Q?RKZEkeMOXWHo2CwMmN2X+I1zeTl5UkXUhfz8iDBXNsoeIWIZjzt8A/ZW8b?=
 =?iso-8859-1?Q?O1/KspTbWCiRW/xrAlxzedqO/yOhCEOamTAWgr++5DNWeuZJupwlbtI+5H?=
 =?iso-8859-1?Q?IL0V21G8S7RfGPd2Z8X9N/CXaSIU0wObN7a/TU+6jLi/+tZ5tR4nA2tBXq?=
 =?iso-8859-1?Q?7XriGAC5CR3derXPO2dqaMYNi5ufHoFcgGlBG10mI6sRakW6CkfzaiIWFj?=
 =?iso-8859-1?Q?en6zHsLXszLWj2TuK3XQEyUgd1Mfx/o9DH3FegDxltplzfR7Q6Nfe5t7ZQ?=
 =?iso-8859-1?Q?YoJeMG6DRE+eUa67WERBa7vjDu+rsk5zEpRKh+ec7Rk7Dns8ZKD/bq3HSq?=
 =?iso-8859-1?Q?E+beDY+tDZFsPhXjal2bDk1D8mV5XslI63Jb98P4w7Wsc34osdOIdzNZh7?=
 =?iso-8859-1?Q?FJGAERDqc3pL9X9Fc9V5xZpZIfcyZkD2inA7sGNDfHO7dTZtwSfq7wLle9?=
 =?iso-8859-1?Q?gqHjVSX8AyXSSWqIdzjQvgw8MTXbT3CWY1/+hpK6tqTFUytefFP1DF94bu?=
 =?iso-8859-1?Q?wSBYe5CaqexB3oIMTz8nqLx1o9z59MuZpTMwBLqRp9vaACVH1/hwvVTyFX?=
 =?iso-8859-1?Q?6F49btRWXDDlw0draOQBZs5fWx9bNfL4HsWRvnv9DYAlKf3GinBoHSji4y?=
 =?iso-8859-1?Q?EwaG9cayAVH3C3vfpa6waTKdkA7kYgEF1bLEcjdc5nhzuGvl9KBez3AFnt?=
 =?iso-8859-1?Q?UjoRgf9lu3IzKA7Oqqd5i2YL+FR/zaVedcUUCKTLds5soDTiRMrVdNeMQ8?=
 =?iso-8859-1?Q?0TsVxibKUt2SogHU7nd0NcK+1BH+Wqdbky15ni+074k64LzESWz3VjYYu6?=
 =?iso-8859-1?Q?tcJk9zOp1uFDKhgdJ4sipt9m8qxSJ3vzMeKiSoL4zm6V5eID7XSClI6zl9?=
 =?iso-8859-1?Q?P3T/aKM+7GwRtnEkbtUNthuXMMRSkgDp4jwMWXyy4S2OZUi6xo5vfk/uFw?=
 =?iso-8859-1?Q?QNL32x7IObAKqQaJN8SgauY3lyzhtB5tIdmMyCgeo+uNkg0oKO/5w8r4fo?=
 =?iso-8859-1?Q?AB+eEQ7gfqO89DkpBRkOqZe3VP6sAKLZBe6BSv/RXnoIqFgR4v/0SSM7HO?=
 =?iso-8859-1?Q?gBIt+Hi8JeDn18+Li3rxIIDGnaMoJUwas2f2WAi1eXy2rNiumZZnrnZChr?=
 =?iso-8859-1?Q?tA6T966ziSJUZLCGQH1yB5BxZegMfKIyLrtxL2SgRzwBLNqF6V4QdxFlzx?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CceHOf2jHrKfMCo2eQvrBllFoDkymLFxT12gYZP2sPA/eqlT4W5HNoGFru?=
 =?iso-8859-1?Q?0jrLA9oupOlUnL6pfFRXEhz38OMcZHWsNqCAWtSf+LAD1eULr8CKQ2ZO8b?=
 =?iso-8859-1?Q?s+96/KLiCYE+MVLjnuix9hVDmlFaIwE1t8C+hn/om+jBdBqS+leRiDDZYu?=
 =?iso-8859-1?Q?mTQOCwg74oR5zAuZo3TyV/8KaZcnnj267pxmGWTOKW66eFiPmpm0HL2eLi?=
 =?iso-8859-1?Q?HUmzQ5ZB73Zt8KuGPda8yTDZMbxH7sNOQy3SYLQkK3sFzNqPXWON+1d/eS?=
 =?iso-8859-1?Q?gnozaD3i5StxBOpVozRCTohOSyo/WTyaEYe+sndbygbO3AcYOCv+Z7tjiE?=
 =?iso-8859-1?Q?CSd2eRInfWnz2Vn71jPmJqfI1pp9KVqjWHF+TVlelelny2wuoKIc9yrYbk?=
 =?iso-8859-1?Q?HiBY98WdAci5LAaS+zMzY7lXx3k/alP6wZK9z4APIN3ofAQSlAEu1TZtPz?=
 =?iso-8859-1?Q?d9/Q+W09P+TgwOmCE9LLKm9tYCUsLBzzTM4Sc7gEqtKkWonB8H9rOzPj79?=
 =?iso-8859-1?Q?xt4aFf6e9prMrF6NUuM/H06Ok3o89+bttzmgJoTKFTqPcw1QUJEwiaUek1?=
 =?iso-8859-1?Q?lKMOkiKS9J+OyzJhr/8bKE9DGVpMlfvYFuNI5V2WkzlA0E8pW+1E6iUL3p?=
 =?iso-8859-1?Q?/o5H9wz+1doR2+La2Ww/J4vP6Y/edGVZFOirsyQ4O+hUXbxFbziUGl/grr?=
 =?iso-8859-1?Q?08cFsVxPNP8IvUSkFkpnXAh63aa1Nl2Bhx5uMB70M/EnWUA3vZYKCTs6GN?=
 =?iso-8859-1?Q?X6+sso/9N6SLUGRWQr+mXwMrZtyZJSOK175kfX7EaLks9KNvt/I/v932RD?=
 =?iso-8859-1?Q?9l7jRugV2/9Iv7P5Mjs0wSbsKq4UIXjA+WsroNj8b5pOu+2iaZSOx/Hq6c?=
 =?iso-8859-1?Q?4CiFkMPK9e2clH44Bo3x4oQNPry7+QeN62Gx8qLdvDiV3uI67jxX04hYsg?=
 =?iso-8859-1?Q?fjyq+RXJzYcc4w1Njba8+3oefQSE0lW4zMSPasEnswMKV2trf7V9iUsbrH?=
 =?iso-8859-1?Q?H498Tz7CU0DrsRWqkkiJnGmODI155+8q05uQxgh5NvhNAhLx5xBlAOl/Ye?=
 =?iso-8859-1?Q?acfGifTcYX2quurpVF6GsWz93CNuv4hJR5xkFMkJiFSMJcMFQEQjhlOPK2?=
 =?iso-8859-1?Q?wOfjxewZsDh5lal2mEgOfq62eDyr+zVZFERXQPDQKIT5W05xB3xsbBA+AX?=
 =?iso-8859-1?Q?XfoWQ6De6MwHl/RIK7vGkuhmBdtT5YEK58+Uk49Wp1/3CkH1BHfdfNdUYe?=
 =?iso-8859-1?Q?molKhoz55+MHxiqKxhOmX8yg07o8trkRCunlvZKWnVEDe3kbiTF4JNNo3y?=
 =?iso-8859-1?Q?VmzXH6Al29EQlLfv9xC2+12CPcDo84wa9ha2zNYJL45X3MJfl3JthQTfR0?=
 =?iso-8859-1?Q?urXl2LB2VX8ZUd2RoDPVKFhFKIl2dd1uAfmT0G9ZDNTCefR8kyjSfnr9y5?=
 =?iso-8859-1?Q?Bn2AiFfrexb402hww5TIXBdRv83DkpfqJWY2lxOEKW7YAfLoL38CPGAFvS?=
 =?iso-8859-1?Q?tZcuh0bGasyaZ59G4LE9TcvVpNT/GtNz1ZVNVkpRTLh4/fiQ7XHiEQU6ey?=
 =?iso-8859-1?Q?GellOre0Que3LeigxcT5YQsqK3CfCynH1a9F2fjF02DHr7TRQxwc3zL4ny?=
 =?iso-8859-1?Q?5Koagwu4KU0YhKtZ9XZ5TOZ0GrHSTh/Ah4Ad+6vud1Ww7OocvBVxuZdg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ae0f4-5a61-427b-e7cd-08dd7e50cbe7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 08:12:44.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MG7JOvl+Ic6WqFTET/rW1EhY01CwWlbKWKTBqURRnuCmIeLbebIlC1GRC5+KVLFmm7d1NCY/qCTjS47qJd4NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3ECB6A513
X-OriginatorOrg: intel.com

hi, Mateusz Guzik,

On Thu, Apr 17, 2025 at 12:17:54PM +0200, Mateusz Guzik wrote:
> On Thu, Apr 17, 2025 at 12:02:55PM +0200, Mateusz Guzik wrote:
> > bottom line though is there is a known tradeoff there and stress-ng
> > manufactures a case where it is always the wrong one.
> > 
> > fd 2 at hand is inherited (it's the tty) and shared between *all*
> > workers on all CPUs.
> > 
> > Ignoring some fluff, it's this in a loop:
> > dup2(2, 1024)                           = 1024
> > dup2(2, 1025)                           = 1025
> > dup2(2, 1026)                           = 1026
> > dup2(2, 1027)                           = 1027
> > dup2(2, 1028)                           = 1028
> > dup2(2, 1029)                           = 1029
> > dup2(2, 1030)                           = 1030
> > dup2(2, 1031)                           = 1031
> > [..]
> > close_range(1024, 1032, 0)              = 0
> > 
> > where fd 2 is the same file object in all 192 workers doing this.
> > 
> 
> the following will still have *some* impact, but the drop should be much
> lower
> 
> it also has a side effect of further helping the single-threaded case by
> shortening the code when it works

we applied below patch upon a914bd93f3. it seems it not only recovers the
regression we saw on a914bd93f3, but also causes further performance benefit
that it's +29.4% better than 3e46a92a27 (parent of a914bd93f3).

at the same time, I also list stress-ng.close.ops_per_sec here which is not
in our original report since the data has overlap so our code logic don't
think they are reliable then will not list in table without some 'force'
option.

in a stress-ng close test, the output looks like below:

2025-04-18 02:58:28 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --close 192
stress-ng: info:  [6268] setting to a 1 min run per stressor
stress-ng: info:  [6268] dispatching hogs: 192 close
stress-ng: info:  [6268] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: metrc: [6268] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [6268]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [6268] close           1568702     60.08    171.29   9524.58     26108.29         161.79        84.05          1548  <--- (1)
stress-ng: metrc: [6268] miscellaneous metrics:
stress-ng: metrc: [6268] close             600923.80 close calls per sec (harmonic mean of 192 instances)   <--- (2)
stress-ng: info:  [6268] for a 60.14s run time:
stress-ng: info:  [6268]   11547.73s available CPU time
stress-ng: info:  [6268]     171.29s user time   (  1.48%)
stress-ng: info:  [6268]    9525.12s system time ( 82.48%)
stress-ng: info:  [6268]    9696.41s total time  ( 83.97%)
stress-ng: info:  [6268] load average: 520.00 149.63 51.46
stress-ng: info:  [6268] skipped: 0
stress-ng: info:  [6268] passed: 192: close (192)
stress-ng: info:  [6268] failed: 0
stress-ng: info:  [6268] metrics untrustworthy: 0
stress-ng: info:  [6268] successful run completed in 1 min



the stress-ng.close.close_calls_per_sec data is from (2)
the stress-ng.close.ops_per_sec data is from line (1), bogo ops/s (real time)

from below, seems a914bd93f3 also has a small regression for
stress-ng.close.ops_per_sec but not obvious since data is not stable enough.
9f0124114f almost has same data as 3e46a92a27 regarding to this
stress-ng.close.ops_per_sec.


summary data:

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp1/close/stress-ng/60s

commit: 
  3e46a92a27 ("fs: use fput_close_sync() in close()")
  a914bd93f3 ("fs: use fput_close() in filp_close()")
  9f0124114f  <--- a914bd93f3 + patch

3e46a92a27c2927f a914bd93f3edfedcdd59deb615e 9f0124114f707363af03caed5ae
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    473980 ± 14%     -52.2%     226559 ± 13%     +29.4%     613288 ± 12%  stress-ng.close.close_calls_per_sec
   1677393 ±  3%      -6.0%    1576636 ±  5%      +0.6%    1686892 ±  3%  stress-ng.close.ops
     27917 ±  3%      -6.0%      26237 ±  5%      +0.6%      28074 ±  3%  stress-ng.close.ops_per_sec


full data is as [1]


> 
> diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
> index 7db62fbc0500..c73865ed4251 100644
> --- a/include/linux/file_ref.h
> +++ b/include/linux/file_ref.h
> @@ -181,17 +181,15 @@ static __always_inline __must_check bool file_ref_put_close(file_ref_t *ref)
>  	long old, new;
>  
>  	old = atomic_long_read(&ref->refcnt);
> -	do {
> -		if (unlikely(old < 0))
> -			return __file_ref_put_badval(ref, old);
> -
> -		if (old == FILE_REF_ONEREF)
> -			new = FILE_REF_DEAD;
> -		else
> -			new = old - 1;
> -	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
> -
> -	return new == FILE_REF_DEAD;
> +	if (likely(old == FILE_REF_ONEREF)) {
> +		new = FILE_REF_DEAD;
> +		if (likely(atomic_long_try_cmpxchg(&ref->refcnt, &old, new)))
> +			return true;
> +		/*
> +		 * The ref has changed from under us, don't play any games.
> +		 */
> +	}
> +	return file_ref_put(ref);
>  }
>  
>  /**


[1]
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp1/close/stress-ng/60s

commit: 
  3e46a92a27 ("fs: use fput_close_sync() in close()")
  a914bd93f3 ("fs: use fput_close() in filp_close()")
  9f0124114f  <--- a914bd93f3 + patch

3e46a92a27c2927f a914bd93f3edfedcdd59deb615e 9f0124114f707363af03caed5ae
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    355470 ± 14%     -17.6%     292767 ±  7%      -8.9%     323894 ±  6%  cpuidle..usage
      5.19            -0.6        4.61 ±  3%      -0.0        5.18 ±  2%  mpstat.cpu.all.usr%
    495615 ±  7%     -38.5%     304839 ±  8%      -5.5%     468431 ±  7%  vmstat.system.cs
    780096 ±  5%     -23.5%     596446 ±  3%      -4.7%     743238 ±  5%  vmstat.system.in
   4004843 ±  8%     -21.1%    3161813 ±  8%      -6.2%    3758245 ± 10%  time.involuntary_context_switches
      9475            +1.1%       9582            +0.3%       9504        time.system_time
    183.50 ±  2%     -37.8%     114.20 ±  3%      -3.4%     177.34 ±  2%  time.user_time
  25637892 ±  6%     -42.6%   14725385 ±  9%      -6.4%   23992138 ±  7%  time.voluntary_context_switches
   2512168 ± 17%     -45.8%    1361659 ± 71%      +0.5%    2524627 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.min
   2512168 ± 17%     -45.8%    1361659 ± 71%      +0.5%    2524627 ± 15%  sched_debug.cfs_rq:/.min_vruntime.min
    700402 ±  2%     +19.8%     838744 ± 10%      +5.0%     735486 ±  4%  sched_debug.cpu.avg_idle.avg
     81230 ±  6%     -59.6%      32788 ± 69%      -6.1%      76301 ±  7%  sched_debug.cpu.nr_switches.avg
     27992 ± 20%     -70.2%       8345 ± 74%     +11.7%      31275 ± 26%  sched_debug.cpu.nr_switches.min
    473980 ± 14%     -52.2%     226559 ± 13%     +29.4%     613288 ± 12%  stress-ng.close.close_calls_per_sec
   1677393 ±  3%      -6.0%    1576636 ±  5%      +0.6%    1686892 ±  3%  stress-ng.close.ops
     27917 ±  3%      -6.0%      26237 ±  5%      +0.6%      28074 ±  3%  stress-ng.close.ops_per_sec
   4004843 ±  8%     -21.1%    3161813 ±  8%      -6.2%    3758245 ± 10%  stress-ng.time.involuntary_context_switches
      9475            +1.1%       9582            +0.3%       9504        stress-ng.time.system_time
    183.50 ±  2%     -37.8%     114.20 ±  3%      -3.4%     177.34 ±  2%  stress-ng.time.user_time
  25637892 ±  6%     -42.6%   14725385 ±  9%      -6.4%   23992138 ±  7%  stress-ng.time.voluntary_context_switches
     23.01 ±  2%      -1.4       21.61 ±  3%      +0.1       23.13 ±  2%  perf-stat.i.cache-miss-rate%
  17981659           -10.8%   16035508 ±  4%      -0.5%   17886941 ±  4%  perf-stat.i.cache-misses
  77288888 ±  2%      -6.5%   72260357 ±  4%      -1.7%   75978329 ±  3%  perf-stat.i.cache-references
    504949 ±  6%     -38.1%     312536 ±  8%      -5.7%     476406 ±  7%  perf-stat.i.context-switches
     33030           +15.7%      38205 ±  4%      +1.3%      33444 ±  4%  perf-stat.i.cycles-between-cache-misses
      4.34 ± 10%     -38.3%       2.68 ± 20%      +0.1%       4.34 ± 11%  perf-stat.i.metric.K/sec
     26229 ± 44%     +37.8%      36145 ±  4%     +21.8%      31948 ±  4%  perf-stat.overall.cycles-between-cache-misses
      2.12 ± 47%    +151.1%       5.32 ± 28%     -13.5%       1.84 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.28 ± 60%    +990.5%       3.08 ± 53%   +6339.3%      18.16 ±314%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
      0.96 ± 28%     +35.5%       1.30 ± 25%      -7.5%       0.89 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.exec_binprm
      2.56 ± 43%    +964.0%      27.27 ±161%    +456.1%      14.25 ±127%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     12.80 ±139%    +366.1%      59.66 ±107%    +242.3%      43.82 ±204%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      2.78 ± 25%     +50.0%       4.17 ± 19%     +22.2%       3.40 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_cursor.dcache_dir_open
      0.78 ± 18%     +39.3%       1.09 ± 19%     +24.7%       0.97 ± 36%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      2.63 ± 10%     +16.7%       3.07 ±  4%      +1.3%       2.67 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.04 ±223%   +3483.1%       1.38 ± 67%   +2231.2%       0.90 ±243%  perf-sched.sch_delay.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.72 ± 17%     +42.5%       1.02 ± 22%     +20.4%       0.86 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.35 ±134%    +457.7%       1.94 ± 61%    +177.7%       0.97 ±104%  perf-sched.sch_delay.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      1.88 ± 34%    +574.9%      12.69 ±115%    +389.0%       9.20 ±214%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.41 ± 10%     +18.0%       2.84 ±  9%     +62.4%       3.91 ± 81%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.85 ± 36%    +155.6%       4.73 ± 50%     +27.5%       2.36 ± 54%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
     28.94 ± 26%     -52.4%      13.78 ± 36%     -29.1%      20.52 ± 50%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.24 ±  9%     +22.1%       2.74 ±  8%     +14.2%       2.56 ± 14%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      2.19 ±  7%     +17.3%       2.57 ±  6%      +6.4%       2.33 ±  6%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
      2.39 ±  6%     +16.4%       2.79 ±  9%     +12.3%       2.69 ±  8%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.34 ± 77%   +1931.5%       6.95 ± 99%   +5218.5%      18.19 ±313%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
     29.69 ± 28%    +129.5%      68.12 ± 28%     +11.1%      32.99 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      7.71 ± 21%     +10.4%       8.51 ± 25%     -30.5%       5.36 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.seq_read_iter.vfs_read.ksys_read
      1.48 ± 96%    +284.6%       5.68 ± 56%     -39.2%       0.90 ±112%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings_kernel.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      3.59 ± 57%    +124.5%       8.06 ± 45%     +44.7%       5.19 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.mmap_read_lock_maybe_expand.get_arg_page.copy_string_kernel
      3.39 ± 91%    +112.0%       7.19 ± 44%    +133.6%       7.92 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
     22.16 ± 77%    +117.4%      48.17 ± 34%     +41.9%      31.45 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      8.72 ± 17%    +358.5%      39.98 ± 61%     +98.6%      17.32 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     35.71 ± 49%      +1.8%      36.35 ± 37%     -48.6%      18.34 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.04 ±223%   +3484.4%       1.38 ± 67%   +2231.2%       0.90 ±243%  perf-sched.sch_delay.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.53 ±154%    +676.1%       4.12 ± 61%    +161.0%       1.39 ±109%  perf-sched.sch_delay.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     25.76 ± 70%   +9588.9%       2496 ±127%   +2328.6%     625.69 ±272%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.53 ± 26%     -58.8%      21.22 ±106%     +13.1%      58.30 ±190%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.97 ± 48%    +154.8%      12.66 ± 75%     +25.0%       6.21 ± 42%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      4.36 ± 48%    +147.7%      10.81 ± 29%     -14.1%       3.75 ± 26%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    108632 ±  4%     +23.9%     134575 ±  6%      -1.3%     107223 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    572.67 ±  6%     +37.3%     786.17 ±  7%      +1.9%     583.75 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    596.67 ± 12%     +43.9%     858.50 ± 13%      +2.4%     610.75 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec.__request_module
    294.83 ±  9%     +31.1%     386.50 ± 11%      +1.7%     299.75 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
   1223275 ±  2%     -17.7%    1006293 ±  6%      +0.5%    1228897        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2772 ± 11%     +43.6%       3980 ± 11%      +6.6%       2954 ±  9%  perf-sched.wait_and_delay.count.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
     11690 ±  7%     +29.8%      15173 ± 10%      +5.6%      12344 ±  7%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      4072 ±100%    +163.7%      10737 ±  7%     +59.4%       6491 ± 58%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      8811 ±  6%     +26.2%      11117 ±  9%      +2.6%       9039 ±  8%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    662.17 ± 29%    +187.8%       1905 ± 29%     +36.2%     901.58 ± 32%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     15.50 ± 11%     +48.4%      23.00 ± 16%      -6.5%      14.50 ± 24%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    167.67 ± 20%     +48.0%     248.17 ± 26%      -8.3%     153.83 ± 27%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      2680 ± 12%     +42.5%       3820 ± 11%      +6.7%       2860 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down_timeout.down_timeout
    137.17 ± 13%     +31.8%     180.83 ±  9%     +12.4%     154.17 ± 16%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      2636 ± 12%     +43.1%       3772 ± 12%      +6.1%       2797 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
     10.50 ± 11%     +74.6%      18.33 ± 23%     +19.0%      12.50 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      5619 ±  5%     +38.8%       7797 ±  9%      +9.2%       6136 ±  8%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     70455 ±  4%     +32.3%      93197 ±  6%      +1.1%      71250 ±  3%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6990 ±  4%     +37.4%       9603 ±  9%      +7.7%       7528 ±  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    191.28 ±124%   +1455.2%       2974 ±100%    +428.0%       1009 ±166%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      1758 ±118%     -87.9%     211.89 ±211%     -96.6%      59.86 ±184%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.24 ± 48%    +144.6%       5.48 ± 29%     -14.7%       1.91 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8.06 ±101%    +618.7%      57.94 ± 68%    +332.7%      34.88 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±146%    +370.9%       1.30 ± 64%    +260.2%       0.99 ±148%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      3.86 ±  5%     +86.0%       7.18 ± 44%     +41.7%       5.47 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      2.54 ± 29%     +51.6%       3.85 ± 12%      +9.6%       2.78 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11 ± 39%    +201.6%       3.36 ± 47%     +77.3%       1.98 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      3.60 ± 68%   +1630.2%      62.29 ±153%    +398.4%      17.94 ±134%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.20 ± 64%    +115.4%       0.42 ± 42%    +145.2%       0.48 ± 83%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.exec_binprm
    142.09 ±145%     +58.3%     224.93 ±104%    +179.8%     397.63 ±102%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     55.51 ± 53%    +218.0%     176.54 ± 83%     +96.2%     108.89 ± 87%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      3.22 ±  3%     +15.4%       3.72 ±  9%      +2.3%       3.30 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.04 ±223%  +37562.8%      14.50 ±198%   +2231.2%       0.90 ±243%  perf-sched.wait_time.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      1.19 ± 30%     +59.3%       1.90 ± 34%      +3.7%       1.24 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.36 ±133%    +447.8%       1.97 ± 60%    +174.5%       0.99 ±103%  perf-sched.wait_time.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      1.73 ± 47%    +165.0%       4.58 ± 51%     +45.7%       2.52 ± 52%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      1.10 ± 21%    +693.9%       8.70 ± 70%    +459.3%       6.13 ±173%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     54.56 ± 32%    +400.2%     272.90 ± 67%    +345.0%     242.76 ± 41%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10.87 ± 18%    +151.7%      27.36 ± 68%     +69.1%      18.38 ± 83%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
    123.35 ±181%   +1219.3%       1627 ± 82%    +469.3%     702.17 ±118%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.68 ±108%   +5490.2%     541.19 ±185%     -56.7%       4.19 ±327%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.do_epoll_create.__x64_sys_epoll_create.do_syscall_64
      3.39 ± 91%    +112.0%       7.19 ± 44%     +52.9%       5.19 ± 54%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.12 ±128%    +407.4%       5.67 ± 52%    +536.0%       7.11 ±144%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     30.58 ± 29%   +1741.1%     563.04 ± 80%   +1126.4%     375.06 ±119%  perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      3.82 ±114%    +232.1%      12.70 ± 49%    +155.2%       9.76 ±120%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.__mmap_prepare.__mmap_region
      7.75 ± 46%     +72.4%      13.36 ± 32%     +18.4%       9.17 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.39 ± 48%    +259.7%      48.17 ± 34%    +107.1%      27.74 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     12.46 ± 30%     +90.5%      23.73 ± 34%     +25.5%      15.64 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
    479.90 ± 78%    +496.9%       2864 ±141%    +310.9%       1972 ±132%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
    185.75 ±116%    +875.0%       1811 ± 84%    +264.8%     677.56 ±141%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      2.52 ± 44%    +105.2%       5.18 ± 36%     +38.3%       3.49 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.alloc_bprm.kernel_execve
      0.04 ±223%  +37564.1%      14.50 ±198%   +2231.2%       0.90 ±243%  perf-sched.wait_time.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.54 ±153%    +669.7%       4.15 ± 61%    +161.6%       1.41 ±108%  perf-sched.wait_time.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     28.22 ± 14%     +41.2%      39.84 ± 25%     +27.1%      35.87 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      4.90 ± 51%    +158.2%      12.66 ± 75%     +26.7%       6.21 ± 42%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
     26.54 ± 66%   +5220.1%       1411 ± 84%   +2691.7%     740.84 ±187%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1262 ±  9%    +434.3%       6744 ± 60%    +293.8%       4971 ± 41%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     30.09           -12.8       17.32            -2.9       27.23        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.32            -9.3        0.00            -9.3        0.00        perf-profile.calltrace.cycles-pp.fput.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.15            -5.9       35.26            -0.2       40.94        perf-profile.calltrace.cycles-pp.__dup2
     41.02            -5.9       35.17            -0.2       40.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
     41.03            -5.8       35.18            -0.2       40.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__dup2
     13.86            -5.5        8.35            -1.1       12.79        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
     40.21            -5.5       34.71            -0.2       40.02        perf-profile.calltrace.cycles-pp.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
     38.01            -4.9       33.10            +0.1       38.09        perf-profile.calltrace.cycles-pp.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
      4.90 ±  2%      -1.9        2.96 ±  3%      -0.5        4.38 ±  2%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      2.63 ±  9%      -1.9        0.76 ± 18%      -0.5        2.11 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      4.44            -1.7        2.76 ±  2%      -0.4        3.99        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      2.50 ±  2%      -0.9        1.56 ±  3%      -0.2        2.28 ±  2%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.do_dup2.__x64_sys_dup2
      2.22            -0.8        1.42 ±  2%      -0.2        2.04        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.do_dup2.__x64_sys_dup2
      1.66 ±  5%      -0.3        1.37 ±  5%      -0.2        1.42 ±  4%  perf-profile.calltrace.cycles-pp.ksys_dup3.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
      1.60 ±  5%      -0.3        1.32 ±  5%      -0.2        1.36 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ksys_dup3.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.6        0.65 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
      0.00            +0.0        0.00           +41.2       41.20        perf-profile.calltrace.cycles-pp.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
      0.00            +0.0        0.00           +42.0       42.01        perf-profile.calltrace.cycles-pp.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
      0.00            +0.0        0.00           +42.4       42.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
      0.00            +0.0        0.00           +42.4       42.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close_range
      0.00            +0.0        0.00           +42.4       42.44        perf-profile.calltrace.cycles-pp.close_range
      0.58 ±  2%      +0.0        0.62 ±  2%      +0.0        0.61 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.40 ±  4%      +0.0        1.44 ±  9%      -0.4        0.99 ±  6%  perf-profile.calltrace.cycles-pp.__close
      0.54 ±  2%      +0.0        0.58 ±  2%      +0.0        0.56 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      1.34 ±  5%      +0.0        1.40 ±  9%      -0.4        0.93 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.35 ±  5%      +0.1        1.40 ±  9%      -0.4        0.93 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.72 ±  4%      +0.1        0.79 ±  4%      -0.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.23 ±  5%      +0.1        1.31 ± 10%      -0.5        0.77 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +1.8        1.79 ±  5%      +1.4        1.35 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.fput_close.filp_close.__do_sys_close_range.do_syscall_64
     19.11            +4.4       23.49            +0.7       19.76        perf-profile.calltrace.cycles-pp.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.94            +6.5       47.46           -40.9        0.00        perf-profile.calltrace.cycles-pp.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     42.24            +6.6       48.79           -42.2        0.00        perf-profile.calltrace.cycles-pp.syscall
     42.14            +6.6       48.72           -42.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     42.14            +6.6       48.72           -42.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     41.86            +6.6       48.46           -41.9        0.00        perf-profile.calltrace.cycles-pp.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00           +14.6       14.60 ±  2%      +6.4        6.41        perf-profile.calltrace.cycles-pp.fput_close.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
      0.00           +29.0       28.95 ±  2%     +12.5       12.50        perf-profile.calltrace.cycles-pp.fput_close.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.76           -19.0       26.72            -4.1       41.64        perf-profile.children.cycles-pp.filp_flush
     14.67           -14.7        0.00           -14.7        0.00        perf-profile.children.cycles-pp.fput
     41.20            -5.9       35.30            -0.2       40.99        perf-profile.children.cycles-pp.__dup2
     40.21            -5.5       34.71            -0.2       40.03        perf-profile.children.cycles-pp.__x64_sys_dup2
     38.53            -5.2       33.33            +0.1       38.59        perf-profile.children.cycles-pp.do_dup2
      7.81 ±  2%      -3.1        4.74 ±  3%      -0.8        7.02 ±  2%  perf-profile.children.cycles-pp.locks_remove_posix
      7.03            -2.6        4.40 ±  2%      -0.7        6.37        perf-profile.children.cycles-pp.dnotify_flush
      5.60 ± 16%      -1.3        4.27 ± 14%      -0.7        4.89 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.24 ±  3%      -0.4        0.86 ±  4%      -0.0        1.21        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.67 ±  5%      -0.3        1.37 ±  5%      -0.2        1.42 ±  4%  perf-profile.children.cycles-pp.ksys_dup3
      3.09 ±  3%      -0.1        2.95 ±  4%      -0.3        2.82 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.29            -0.1        0.22 ±  2%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.10 ± 71%      -0.1        0.04 ±112%      -0.1        0.05 ± 30%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.10 ± 10%      -0.1        0.05 ± 46%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.17 ±  7%      -0.1        0.12 ±  4%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.15 ±  3%      -0.0        0.10 ± 18%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.clockevents_program_event
      0.04 ± 45%      -0.0        0.00            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.06 ± 11%      -0.0        0.02 ± 99%      +0.0        0.08 ± 24%  perf-profile.children.cycles-pp.stress_close_func
      0.13 ±  5%      -0.0        0.10 ±  7%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__switch_to
      0.06 ±  7%      -0.0        0.04 ± 71%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  3%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.49 ±  3%      -0.0        1.48 ±  2%      +0.2        1.68 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.0        0.00           +42.5       42.47        perf-profile.children.cycles-pp.close_range
      0.23 ±  2%      +0.0        0.24 ±  5%      +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.06 ±  6%      +0.0        0.08 ±  6%      +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      0.26 ±  2%      +0.0        0.28 ±  3%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.08 ±  4%      +0.0        0.11 ± 10%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.set_pte_range
      0.45 ±  2%      +0.0        0.48 ±  2%      +0.0        0.48 ±  4%  perf-profile.children.cycles-pp.zap_present_ptes
      0.18 ±  3%      +0.0        0.21 ±  4%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.folios_put_refs
      0.29 ±  3%      +0.0        0.32 ±  3%      +0.0        0.31 ±  4%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.29 ±  3%      +0.0        0.32 ±  3%      +0.0        0.31 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.42 ±  5%      +0.0        1.45 ±  9%      -0.4        1.00 ±  6%  perf-profile.children.cycles-pp.__close
      0.34 ±  4%      +0.0        0.38 ±  3%      +0.0        0.36 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.24 ±  3%      +0.0        0.27 ±  5%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.69 ±  2%      +0.0        0.74 ±  2%      +0.0        0.72 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      0.73 ±  2%      +0.0        0.78 ±  2%      +0.0        0.77 ±  5%  perf-profile.children.cycles-pp.do_read_fault
      0.65 ±  7%      +0.1        0.70 ± 15%      -0.5        0.17 ± 10%  perf-profile.children.cycles-pp.fput_close_sync
      1.24 ±  5%      +0.1        1.33 ± 10%      -0.5        0.79 ±  8%  perf-profile.children.cycles-pp.__x64_sys_close
     42.26            +6.5       48.80           -42.3        0.00        perf-profile.children.cycles-pp.syscall
     41.86            +6.6       48.46            +0.2       42.02        perf-profile.children.cycles-pp.__do_sys_close_range
     60.05           +10.9       70.95            +0.9       60.97        perf-profile.children.cycles-pp.filp_close
      0.00           +44.5       44.55 ±  2%     +19.7       19.70        perf-profile.children.cycles-pp.fput_close
     14.31 ±  2%     -14.3        0.00           -14.3        0.00        perf-profile.self.cycles-pp.fput
     30.12 ±  2%     -13.0       17.09            -2.4       27.73        perf-profile.self.cycles-pp.filp_flush
     19.17 ±  2%      -9.5        9.68 ±  3%      -0.6       18.61        perf-profile.self.cycles-pp.do_dup2
      7.63 ±  3%      -3.0        4.62 ±  4%      -0.7        6.90 ±  2%  perf-profile.self.cycles-pp.locks_remove_posix
      6.86 ±  3%      -2.6        4.28 ±  3%      -0.6        6.25        perf-profile.self.cycles-pp.dnotify_flush
      0.64 ±  4%      -0.4        0.26 ±  4%      -0.0        0.62 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.22 ± 10%      -0.1        0.15 ± 11%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.23 ±  3%      -0.1        0.17 ±  8%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.10 ± 44%      -0.1        0.05 ± 71%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.08 ± 19%      -0.1        0.03 ±100%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.pick_eevdf
      0.04 ± 44%      -0.0        0.00            +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__x64_sys_fcntl
      0.06 ±  7%      -0.0        0.03 ±100%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.13 ±  7%      -0.0        0.10 ± 10%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.09 ±  8%      -0.0        0.06 ±  8%      +0.0        0.10        perf-profile.self.cycles-pp.__update_load_avg_se
      0.08 ±  4%      -0.0        0.05 ±  7%      -0.0        0.07        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.08 ±  9%      -0.0        0.06 ± 11%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.06 ±  7%      +0.0        0.08 ±  8%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.filemap_map_pages
      0.12 ±  3%      +0.0        0.14 ±  4%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.folios_put_refs
      0.25 ±  2%      +0.0        0.27 ±  3%      +0.0        0.27 ±  6%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.17 ±  5%      +0.0        0.20 ±  6%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.64 ±  7%      +0.1        0.70 ± 15%      -0.5        0.17 ± 11%  perf-profile.self.cycles-pp.fput_close_sync
      0.00            +0.1        0.07 ±  5%      +0.0        0.00        perf-profile.self.cycles-pp.do_nanosleep
      0.00            +0.1        0.10 ± 15%      +0.0        0.00        perf-profile.self.cycles-pp.filp_close
      0.00           +43.9       43.86 ±  2%     +19.4       19.35        perf-profile.self.cycles-pp.fput_close



