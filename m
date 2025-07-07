Return-Path: <linux-fsdevel+bounces-54074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76AAFB0E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D60018906B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28888293C71;
	Mon,  7 Jul 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WnkyoAJa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bxJqjBxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC5262FF5;
	Mon,  7 Jul 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883271; cv=fail; b=pzacug20etPel2XQ09DK+L2SE9WbornpRCvlWNmSmnPtpc9mtAXvhID14tM0A+RfyF46wXMf1BfnfEfCHZBs1mi/ZgTx/mAVss3dU4G+CF952tAXg18QO8VoOEeQLapGuXa+/6e7AneQjRmpRt2UB3IDmd5kH+eNtyd65tvLuhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883271; c=relaxed/simple;
	bh=1CUU9Y57gi1QenFIj6nsuCvEYqDzdr2tJ4H8fyCkKcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GnaJ7j40mCfJ9+DDZ9qElWnGVzoAPrb5WCBpqhnsg1qa7Q1G08nO8pYKrnvef5qOPJ1UbTFIh55S4cxelcxl0xw7i/BsK5igjivGxYBwWm41hkrDBVXsSydizV0AkTtC8P+suPPgYzziQ3fFG6SrkfdFWh0CrRDdl25WhJmSp84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WnkyoAJa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bxJqjBxX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679r4QY004666;
	Mon, 7 Jul 2025 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HA0EBpqNYrV2AryXwv
	8FMhidEAXp6SZ2ElHc2m0MFQ4=; b=WnkyoAJaMt5lZgkLAuSTVMApMCNSnlCL6T
	oIkB5V0/Sk49ybn4Oj+qECzhs7DsjlN+xGePAIdUEyzXtrtUiGNor71oRQhxlPkC
	2YPSxIeltRhGfDcjN36hs2BKUUYaxLkfgLEHAa9xA2VBzey2CoW3r+DmEVdbadUV
	zS63z3FsKUAOLvXmIflJsZTp9DNdg6RyayuhNqhpztm9u3/mwI3PX4wU4oUcT1WG
	lyusDwmNACSgD8SvUtD4ATmLAeJ8gG++jdegeRTeSjNjJRPeZ8S3bgmZPfAZF5yZ
	Lvk9xtrLagrX+HmhUDWXKOV0kRYZkxLzFIx3qcuiWqAHfrLHJGbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rbyqr199-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:13:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56787824040477;
	Mon, 7 Jul 2025 10:13:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8a5m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhHK6v6RhAi0yfYapESAR/sdIqNlj/GbNneHoV4wBrENfyIE7Q5MJwdTt36K0EvFNEM1Py9Flsoibz08MYoSn8149caEnjYKRD5uvqQCuTXxbxUpscq/HMcqDqw81/7z8446VaLgmawH5gAUaUvSQwSFLGvkFHeDHZ8X40n0kuuvXwP+6zNxUpQhUW6C9t5hZ992K4VRV62dNZFqv8M+wPYIBm37WONpF2tJspMEoMNKQYYf86cEf2btXbMQo07OzdqBqV4hKTRoMD+pwkxQcn+lvEdkm4hwt1uaUrkAUZ5cz+O7UsS9wUg9rAlDN4rRxQf9/2veEMoMebLlJax1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA0EBpqNYrV2AryXwv8FMhidEAXp6SZ2ElHc2m0MFQ4=;
 b=NzC77dYRBK8UNboj2qUdQ0aSgGxeoORaKMs2Bm99dMZrB3qA6cv+mXqMrijaZ5GcrP4Kzyy5EHtcmnqv/wCBKHkmDAV3BBXg27gNMy1oVDdIXo6B/ZGckg0gw3qSZUGJh/mhuvYGbaJJxZRQ+MfswRf32egBkOTBQW8OPiS5wN2i124D+SY9h4elLA0zb0lxEwsBWl1K0yxYTa/B+0Wuy1eBfqZKPJlkP6sGfaZkQFz+u8koE8D1ru3KOE91rK2Ts3HffzumJZjdUSaSdQbBFdEOh4a8tTqw7jN2KLdC00Gt7WCI78TqvmOA0hKZuZo0Bkpn8XdF9CfAUO6jWQLvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA0EBpqNYrV2AryXwv8FMhidEAXp6SZ2ElHc2m0MFQ4=;
 b=bxJqjBxXP55aX25oArtcAIa5vkRl0sMubCFglcBbex/8ctgn6cCRTp4da1YFGvjcGge+NojSIwb+hmUX4yqvGC8O1B/KmUyjnd+hCwlsN9fTo+N9s6n9xEh/yB8GU25H7ywApa7TXiTIBVrWZyocIMyiZiD60uHKWC/0lrDHN8k=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3689F8B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 7 Jul
 2025 10:13:17 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 10:13:17 +0000
Date: Mon, 7 Jul 2025 11:13:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for
 mremap
Message-ID: <3dadd329-484e-40c8-b04c-4c4ffab24957@lucifer.local>
References: <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>
 <202507071505.e2HFMCH2-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507071505.e2HFMCH2-lkp@intel.com>
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3689F8B17:EE_
X-MS-Office365-Filtering-Correlation-Id: d43dee3e-079f-41b4-9824-08ddbd3ee3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmeJTdLOiVTOpYvPoNIULnFxNb9xJs4U4E58rzbR+XOU0eZCrPDLYlKXk+aW?=
 =?us-ascii?Q?Nxisa41Ms0TmA31ncbLPFHJ28tarGPH+gmA8BKfVXQn3FEhvpCR26Co9iE1P?=
 =?us-ascii?Q?W7BlB2u29nq/lYKdgrmUPMRAt+zvhG59JgkfEc420lYikwIiTS7GAlVl4vwm?=
 =?us-ascii?Q?P/5k3zCTM2odmgRXQMCwBAYjL12So9RDZmvT7CQlykJ7wP58avxJXRdiAc05?=
 =?us-ascii?Q?6OpXiKkJrTHz2pUarbLsiKkcHrK6wi92fMd/H8pQ9UdpjLjxZzELxYzcWSqO?=
 =?us-ascii?Q?rA7jBwFsac7AzVS++8x1xNXSV+fHEw6ITlCEXebrVgoCIynmPrNeXYE3E1bs?=
 =?us-ascii?Q?zzzEPuIO9mt+eMABbmrhqrrRNGTkFhosZ2uebZKxlQsoXx8m/RLBEuxWiBjy?=
 =?us-ascii?Q?TBUYNJAV5cXggCOjSgLEpxlCYLHKWid9clOL0BDDOAwkm6zN84nK45AAuFnO?=
 =?us-ascii?Q?TT6U95465AO9boIiCW1ipxHESUylteinbAw9306MTqPYp/o6GEbp5CpF0WZL?=
 =?us-ascii?Q?j7uclZ1u5IMtBUMc5Ujczra7EZpsky2l3vlVcJ30mRLdzcjw9sggMo/zs4Ek?=
 =?us-ascii?Q?9YNliekQGDOoUa8AEkVCM52jY42oJO0fpdM3nCZhh3j8O9z+j+o9wMbMn5Tn?=
 =?us-ascii?Q?XqN0eesh+214SgQu/LuXSd+ARcvYGVW8fkc8Bp1Q+jGjPJVkldXKO1OaTeq6?=
 =?us-ascii?Q?cmNlisf1JDYtS7kiVOrAxEE06AcAMpZMtaaGAvAuc/SsDY1tZse1M+Nqpfcs?=
 =?us-ascii?Q?pAYPn07k1J4Z3DpkOOnjM1SI/LMcczaVy6ZvCrdNmIZjDMJIFcxlREyKrsRL?=
 =?us-ascii?Q?8lG1R5yuHaNOVcIpYJf56fMr2fa7iIPyBCGkU1z0I4ez0bvHll544IaWt2du?=
 =?us-ascii?Q?hwEJrwp69VrBnnY4KdVee5HhhnalyG6e+CpyUVAbcAeqk4AexZQ5jezTHf2P?=
 =?us-ascii?Q?VP+SgO7vV6ZOcUhXa+kXiFCjOt9oZcLACmUDBTkr13VMh8+imBm6dPWHvI+s?=
 =?us-ascii?Q?a2XRIBpg77kP90MXg/c2NG6p++YmemwUWVCUBBFLs3VOLNpEjIUAUMma+nEm?=
 =?us-ascii?Q?S+k14X4K7HX9n2fng9S87Db27uKJEiwhg2BGjlKlaXeUP7MbGIsn5fR6zaw4?=
 =?us-ascii?Q?M36znByaqDULfaJX/E+8/ElYhHFfl8B9Uw+OQjHY9QRzQrID+w+IexbuBo7B?=
 =?us-ascii?Q?XFvW0iOGiQrhTOlObQm1qhl+jZJL4SIDThrleVhOH6H1HFfJ85RZ0ZZlRDI3?=
 =?us-ascii?Q?IRBBG/gvaRPAXFZVOeLXWe/CsvDfsM1V7Dcu7J0p0Yc6+wPPpLFKC5yL3Pov?=
 =?us-ascii?Q?myYxt76MzkHdkyEBuuEUn8/Bv4Sj88F3jlOlFIBcFWCdIj6TC4oIQxXloYZr?=
 =?us-ascii?Q?agE+NKEKdFXG/GfkOjnzagAsv2NM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2pEkujz2duH3gPv24a6NOwHio5tTbWO85S9hPwz36SUFDGBKNA7B0BGy8lQQ?=
 =?us-ascii?Q?+Q9hF9Yli2CO7/xMj8DNS+Kp4r9Kl22mLWPOcouC6eIPMPjXAC0sXjBDc8vv?=
 =?us-ascii?Q?zjz0I4xW843s1X2G9cwIbChl6m6kqEZ6MLcDt94oH8Pqd3TUJVQDsLWss8mk?=
 =?us-ascii?Q?gJOr0L74WoHKKCKou/8ZB2URqBk/SZ2CALW/P2vyv7AwuEexp/AnsnGnTL2j?=
 =?us-ascii?Q?rnLcrXFzHQebEVtgvfCjrEn1FjHjz+5mt67RSdn4KAqGTs8ERPT7A44YIJVD?=
 =?us-ascii?Q?w2wn34dIvkg/oZI1pWrh1ZbJ/GueP0cZJw+KK5NdJaPldGxRbDVOLl19dBhb?=
 =?us-ascii?Q?fpdCNVv1tp2WwZ8+EMyPsLQTJuwQeTh2rQzO8lheysRLqtpyWNUvhB4lENWe?=
 =?us-ascii?Q?U37gX2B8wJS+zXep1kkDn+3K9XGLRDwtImnojO84nfOMlc1USnoSvNxpGWo/?=
 =?us-ascii?Q?mv5JU8c947rmoFrTjeTsbyRGO0y1v7e8Zj7APm+dJh2yTlM66YaBKscjtB3O?=
 =?us-ascii?Q?apzTT0YUCD8y5MYLBZCxeyE7vY3L0F5NraLW5x1AzX/x2HcUcoqPM650YTK6?=
 =?us-ascii?Q?x2QV2HAAAJ3G3edT0fNer5HrYOZ5CYCHN0K9erdXtNNP5URHgT4i0Gu+gIJb?=
 =?us-ascii?Q?lWFIm6STOLGzRh54Wqmm4No1g9t5PR8y0t5USbny0HZjCv4jTvX5KvE+eoqt?=
 =?us-ascii?Q?JJC5WwVp6DUfYT/VM15sjEkrWIPHJpGtSeZgfiGqadADr6pfW5h2cmBthJkh?=
 =?us-ascii?Q?meqNWTIn2bnVTljd28i+eRgOny1Be5rUT/UKYzoJxoILTygkYkgA8x+NeLJt?=
 =?us-ascii?Q?2Eww9A++uQoCnz5qZSY8ZYrwwRIdP5n5jkxEWyaLUt9IHQ9C3O/xgjCbpY5q?=
 =?us-ascii?Q?0+vio1D3GQydSSJuQ61IpPWNZ2ps93rHKgIKDRErsdLCpmrJLrWhDr63mw50?=
 =?us-ascii?Q?fJtYaOzmHdSqdx/3xBtuJhUks0+OQhyR7/SbXpywVGLa3szGuDa8R89BQoE+?=
 =?us-ascii?Q?9z8jsT7CRkegzHAWK6AnVEfK4TKGZ5+kTxpELG06aaA7AC/L9Q6l0GC9d9b5?=
 =?us-ascii?Q?esm52zV772kqGehOa6jRmdmFv7us1ky2Z8yHO3R8cI+018l1yKgtlMIg/Iag?=
 =?us-ascii?Q?So0GdX2l9snit9BXoNViawf7WxEVwPejZC0hj5si5X7YKlUJXUjYEmHf9gCV?=
 =?us-ascii?Q?uCYvHypetI1ZCvHa6hAdqy0svzOI3ybZ4XFLpYXUjT2gkTg29OiuYYqrj80K?=
 =?us-ascii?Q?IqfZGMCLix5mrJyhVQFZGGj6i3d0DzbpLurGB9CwF7kM1A4dmBNFBDnUUlcD?=
 =?us-ascii?Q?4dM5JywZpNiV/HVDKg9ZdOmnUKMHKNeM1hcjo/+UFCwAXnogi9pXn9o0hFty?=
 =?us-ascii?Q?j+xt/d5NypCj3VDWaXuTDhV5gxEaQx3vw2br8Z7KepsL1klQ/4dA/wQNK4ZW?=
 =?us-ascii?Q?IUSgnJ/jOT75541WLRw+9gaOzJ8kGf0q8LBNk1Jn6Ocq7SVCDXU05uyaS9oj?=
 =?us-ascii?Q?9cKd/eizCoKUhwfjZM/LiWXwzTjlVxmIo82TuTxfHjgD9sL/Lmg4nbhT6ER/?=
 =?us-ascii?Q?pOOcXcltpAoNC3T0kNRydZ6VfcRPm+e+0ZI87jMY1oxEW750obRCnSkcp3Fj?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JCZyAOna4lSfZZ8pzSBCo+5auhG3IMsxPhdEuXFz0nsV6hKbdXWx7M1HYIiLPqLSdkzpI/runBJ8FamUsGntZ64w9zULbHgxIBykxq4b+OoGv8ypQsRgpA9UtoIfOJIa4XnNFr2sLPzvh4Dxzl2cNa3p18Mb0h1KJsvy0kGkHlz4MVzAJNTFrfmG6+a51gFyD6Ylop95rOMn0zgsw7gqF1njbPS1sPjrZC047yUjLsarnnE39gucISGYraza9yF2v4S9pQzmrZrfNoiGb7m53VCpyipvlaHRYFC+j9mMCgSG2MG17FlolKBz4AcxaHo0AqYMKqKHEMt+/B0x+KtbrOfFErqII39rMzQqX2cHBgszgksCBw6xB8Pq04PVR8zv3j1ufPV4JcxZUEgkWIYRlNw0ch35gUJDaQOeWqS+506ZRfDdkLa7YmB3D0CeghsX5Fz45Roolt9T02qD0JI7DlDi93vpR/a0L671BXhoWvb2z6h2j8SDX6ZtUpQB9vsur7f4AOy/s1rkOZr56RL+8g/h1FvabPo1fYVC5k84dgF8SRQagI1jNUFy2QQtESbS/MDqbiInlnCmBAu2p6lizvOt1WHUVrkBUXRIERKp0ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43dee3e-079f-41b4-9824-08ddbd3ee3cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:13:17.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJCy7G3punwpGxrmo074l4RezZWgWmwCfgPFwT2mNxASvgjh9E/nCFLti0668agbFgwgiRlwcNQdBp7fJ+NYngEk/nYLIPh2+t5nQtuFR1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3689F8B17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070059
X-Proofpoint-GUID: oNZF32Lv1TakOzQ9Gsur1PWqJLDRZl7O
X-Proofpoint-ORIG-GUID: oNZF32Lv1TakOzQ9Gsur1PWqJLDRZl7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA1OSBTYWx0ZWRfXw0ACv3LeGjAc ZZrku8vqH54X2oOzLyOSOj1ioC/G6nuq7xX6Wpov2pozJ76T8XigPKteRdlV4HAVlEVn2zJvU2q HV6bPTcQUvJpBWo2Hvo/e5CEzA+cpn/7ldqQbCfrur1p00zrz+eL8jCkM60oNWLB+vLO4XY7lGv
 Bbw+EsxhnUOa+Dpp8mGKR/saAQh3T4OIBui9ZaykIZvTK4OaxPzADzjJouUGpGgI9wOQ9/tFUCW 5pI4I2Mkh4eIXzWKylL9kVWUdgF3RZ4iBY98fh2JwMg1laeFD9xGjQk6kh2OB3USC4Q0c5r2zJI xKhtTRnvE/oMA2YaKAF7GLGEVsWJ6pUM0Wokg8eRSdH/bk+PBXi2JYFpjZm6wKKlRCOjtZqe9Dh
 eqTKyugl6QgCdOGFojfJkJ8/A6krWnzBFXNkyH7+C3+l0L+Gz3oM1fKoZPYuTQgktQ+skrt/
X-Authority-Analysis: v=2.4 cv=ZOXXmW7b c=1 sm=1 tr=0 ts=686b9dde cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=XtbzWmrbHnPqotb3VYQA:9 a=CjuIK1q_8ugA:10
 a=mmqRlSCDY2ywfjPLJ4af:22

On Mon, Jul 07, 2025 at 03:56:53PM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]

Thanks for the report, I just need to add a stub for this, will send a fix-patch!

Cheers, Lorenzo

>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mremap-perform-some-simple-cleanups/20250707-133132
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes%40oracle.com
> patch subject: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for mremap
> config: i386-buildonly-randconfig-002-20250707 (https://download.01.org/0day-ci/archive/20250707/202507071505.e2HFMCH2-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250707/202507071505.e2HFMCH2-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507071505.e2HFMCH2-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/mremap.c:1739:3: error: call to undeclared function 'mremap_userfaultfd_fail'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     1739 |                 mremap_userfaultfd_fail(vrm->uf);
>          |                 ^
>    mm/mremap.c:1739:3: note: did you mean 'mremap_userfaultfd_prep'?
>    include/linux/userfaultfd_k.h:363:20: note: 'mremap_userfaultfd_prep' declared here
>      363 | static inline void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>          |                    ^
>    1 error generated.
>
>
> vim +/mremap_userfaultfd_fail +1739 mm/mremap.c
>
>   1731
>   1732	static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
>   1733	{
>   1734		struct mm_struct *mm = current->mm;
>   1735
>   1736		/* Regardless of success/failure, we always notify of any unmaps. */
>   1737		userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
>   1738		if (failed)
> > 1739			mremap_userfaultfd_fail(vrm->uf);
>   1740		else
>   1741			mremap_userfaultfd_complete(vrm->uf, vrm->addr,
>   1742				vrm->new_addr, vrm->old_len);
>   1743		userfaultfd_unmap_complete(mm, vrm->uf_unmap);
>   1744	}
>   1745
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

