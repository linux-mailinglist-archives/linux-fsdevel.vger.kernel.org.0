Return-Path: <linux-fsdevel+bounces-22661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8291AEA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0907C1C2220C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C919AA47;
	Thu, 27 Jun 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OBAgD03P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zhW0hcpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24418645;
	Thu, 27 Jun 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511188; cv=fail; b=gD+cn0VRGPHcVK9SZSvB2QaTVRYD8dQGzFWbUb/mORRUB7IRp1H68ix0wL/mqzewj7ME4uVKbukIkzwmjNVXWCtBGD2tN5BMahNN3kCNgxVMITzOBCCbs3wvqZ4AT2ALR7yJFaSAituxpW+AY6OxU9wTd4JPtQctk+A238jsfZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511188; c=relaxed/simple;
	bh=qOOb4SECtrXsW3fNvUnWj0Y9ZcTFLthOyk91HaNafSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RNS6WBcz+qUpqXvlQztwOO3XdyzCHXhrfwUWtJOayOEOFTMk6jTDRns5OBHOjV4J5Z2iJb7rTaE+saKM6dFgf863cVdZ/1bg+xau5Y6cMtxXHweQXgipMrPo7JrGM0DuR+CGGFHDeKR9A2ifBmfrEbeHc3NVqqGQD9sH8GNfYNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OBAgD03P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zhW0hcpy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtY7S019447;
	Thu, 27 Jun 2024 17:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JwsAHD3TiPIeM4Y
	fooT71JwM/aFG2WUqzwi+dVGwJCo=; b=OBAgD03PxbQPunO8Bv601sXAWUKDgjp
	KSPMsHUTWsJBSxR9UMXoPVrggzWSNyOoIn1jFIYHdg2ihoSkPFCKj2i97FY3TNXN
	zyLQI3LI3ZkwnAyYPuLFCAhZrxw5rKDBkxnJGD5JzLHjOqmPpOD5cOUhqAAzyxG3
	GznpB/zH5d9SF2a1268/AHdU26OCr3Cfep0CdzEjMWkTcsLdhPaX1RtMY450Koa4
	BNdb4//G8wn7J6MNKSnN7UY1EKDNEkudwGIUWxRrWsOVoPBd2Jx7GZVU6Z9wjpsO
	2U6OA444AKYafUCe+rP0yZc0k6wtpE78K6D85tkXBT0/uqqL+8lOfmg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2pr1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:59:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RGwQIu023323;
	Thu, 27 Jun 2024 17:59:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2h9mvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrpZK0NKAQSLwMSGYHTNRwGtu6+UkaL4stypZyAkFmHgEoe0gRvGNtGNvbG/0eytucU1o3FJhhMQGBF0pdxHziPnAA5pPxa7XEKq+LDOKGxN/M3AEUUI+xe0enmIbynt7PGseUKi0BzLTX7HIjlGXv+G2jaEo2KAy4QiMWzHlduSLD193MHLcIbzfjiC+3nqHcrd2IYJR6mpeVLn4WwFB7Bc0jhIao1Vu5Itk9rrhxQq7dskWZc4Zy3nyZeWkohvtglRwCFAHwOIwKjC9NIOF58r1wCO03/gNb+4Z9lmfo7lCrQq+W1vDG7EFNhHZJRAckoXBVjmMZoiGmb7ts9X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwsAHD3TiPIeM4YfooT71JwM/aFG2WUqzwi+dVGwJCo=;
 b=Mt8ZsPjieLuESOEShnSuELb9iGagEXF3or6do+1F+skDAqHsc7mP7HuSxALGTZFMUuIzJRMebbxN5dhBQ81Jxt8reVBByR9Jmx78Wc/uewEseqoUJbe924u/ktYnd7f8JlE6AUFU0TcMzUYdQMR7326TTVYAGu1Qt6O6xCBfRHo/WKC/vgQ3ZDqedHpfN8xIdCK0elBo8AdIujns5SPNaCLg6sKCKTzquUvBLCODh/7af90jW3o4jhX+Jc04m3pyyfBf2QroSJTTFN07eh2W8ocpXTtbXwLZ64Xh57hChZMq0pgZoHxizkFNYjk7GRzLEn1dE4X3KUOEH3dlkmNsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwsAHD3TiPIeM4YfooT71JwM/aFG2WUqzwi+dVGwJCo=;
 b=zhW0hcpyUI1RikA3ekZbmCqVKBILiqy6teMVDPs/OqyUng3x/tV9KwQk33s2sRRnSXEpNVSPB0VYHhTihz042Rsahk4iU4jpmIgckjrS5yJbp1Z5qGREtxlJp5h1qV1Sp6p+kMMOBRe+JEHwG6mcHaJhm34hPbiMinYZcDGBZK0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6550.namprd10.prod.outlook.com (2603:10b6:510:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 17:59:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 17:59:22 +0000
Date: Thu, 27 Jun 2024 13:59:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 6/7] tools: separate out shared radix-tree components
Message-ID: <3kswdhugo2jmlkejboymem4yhakird5fvmnbschicaldwjwu7x@6c6z5lk4ctvy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <c23f1b80c62bc906267a8b144befe7ac96daa88c.1719481836.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23f1b80c62bc906267a8b144befe7ac96daa88c.1719481836.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5efdf4-9b74-4287-6598-08dc96d2dfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4wvH66OxWjcLYaS4kuxqh5is0sVPo7Z81EhGMrAippRHCfn52sGmBNAU4ebI?=
 =?us-ascii?Q?g+bAG3J1KeG/U3SXmJmctBOreNMci78sht94H5diMYczGNeIKU5l0wpbvD6H?=
 =?us-ascii?Q?GDSfJx96FixNdZvDhJXwq/CP9ZX5pkOyEaz2YTHd7LH//Dl53p8lcLqD8mgt?=
 =?us-ascii?Q?PIyARqQt7FeJjQyGWju/Eunp5w9c8W7MVEo7Md7iyXFV2CbMwa2Ooo0bJdfC?=
 =?us-ascii?Q?YNuwy0YS5h0OcnJg4npdU/DHe0IXXGs9DMCFJF3iYxOjzhMh7BjNvF79ixZb?=
 =?us-ascii?Q?nsyL4l48wyonCeQuF908UlcI3qWS5Z8cOcoJMl4pY0EEIM6QcOduisploGvP?=
 =?us-ascii?Q?tVGovNZYlY5xfNfM40uL67CZGtghBSGW/QHSqAa7hUl24cm2hitfuOLRRqmO?=
 =?us-ascii?Q?TmyfECGG3xpmjvGPXFPnfnGYrx64SviS/ah3xoKdFrRb09zKkPxSsaW9Orvt?=
 =?us-ascii?Q?S9WA2LuaqXFj/xvWPm1uh6SmGnNGLvVqz+7ma/zz//u5znQFqR+uKMz75iTI?=
 =?us-ascii?Q?rs1T7cr7EYzrmlS1Usts6DcJtvsNYV7gTF1ZrKTVJjbObD/QzFnrWXd8w9G6?=
 =?us-ascii?Q?yZHrRqu2K7vdoe8C5mJR1D0zmjAZdtS+X8aZGUN2rqh4UHxuj6ES5Hrk0PFW?=
 =?us-ascii?Q?aCUghODQW4cwtDIKv/jZxoGSoi9I58Vdjismnr54B6diKyD2CLSRDdTO76B9?=
 =?us-ascii?Q?yTfyiT9XEev0A1XuhU7vhK+cHXepiADcwg5JRGfQsmNIF2wNatIk9vANIUd0?=
 =?us-ascii?Q?pdCtYofhE4qGB2q6JcC63/nkrOI+8NgErwj7RHih8wOjk/vbtIwtvz8v/kXF?=
 =?us-ascii?Q?moNqkKES5Pyg20sq0IrZwVwh5t2owHJBi7Vb2FVtyjAylhPn7Caxk7pdBGj4?=
 =?us-ascii?Q?OIjIJ7sDxORyPb6Ao5WCQXwkBSib9dL6z6XyPDx6a3r0aKEPfWUDqQqexvzZ?=
 =?us-ascii?Q?kJ5Vi4yKm0/g1Mm8u3QXNE+ZNweIRz3MLC6BiWBHi5Zp5qgXXNEX3ftf5XXg?=
 =?us-ascii?Q?IKMIuL239TnIjk75ftXn5yNjkvyBHR78JDOO/Jawvh6IapK2l1q/FjaLOytc?=
 =?us-ascii?Q?4LPt1bvpLOZY8Tg7KHTTxYiKqvn8u4IQYML3wb8YOfMJ/xlYAaB3CEXzhUKH?=
 =?us-ascii?Q?qUeM/W/FY7JPcemHnW2vfUJ0LQMKliK6Rbp4j70UIJBThVyQku+Qf4l9DmbY?=
 =?us-ascii?Q?mAjqXSabVHy0DtMA0Su3I/KckSontkMOBtLkWgVuw1GeALpukj4/CrU148Lk?=
 =?us-ascii?Q?wHHkRUZi5BB2PC/4ui2qVW+g686ZMJXsQwCh7D14OFh10dfxWT7JEQgNwfXH?=
 =?us-ascii?Q?bPJZG18fAtJNqW3Jerneimfvg0GBMP8yhVimG/udzVDaLQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rlegU2QYs4B45W+vPkRvSxS4scJjKQFCVTF3OP92NlgZuMIDuguvJrNn70Js?=
 =?us-ascii?Q?Pr9HdO7hpC5YlHDFmiERvV2/sppO2tPBmb+FBSrY29Rfgk7gGU9SvRZCWuCk?=
 =?us-ascii?Q?ZLoZiPg2G5IIvV2+tHfmUlTIBZBHYwqxRjEP6N59S3N7i/jAmm899Gj+GZNP?=
 =?us-ascii?Q?x97GQHLWAsMe84nCA95WWF7Ka/BuXDcB/IJtF0+dRkK65fgSNTV2YG4djwlf?=
 =?us-ascii?Q?r3F6N7eZGCJACR0VsFXtBuoL+5xlJvbx1OiI9oLjy9aoLJ2lKWFeTkvSJBHF?=
 =?us-ascii?Q?UMwKaG0ctE4nRKwwVG2X42/Ta6CTfyicWSAMxDESWOfCg7fn1vMszRNtmpTL?=
 =?us-ascii?Q?dhXxIRkiUbR2CXvv5Y3cRtqiYd7woEcdlR0MywEfAupXelAkG1u41eXA7hkc?=
 =?us-ascii?Q?IGmNNUr/py9HbhkoWzcyLX3hhoKx+T+XERLr8HapTW8gFtt6XXFUDa0fdJAw?=
 =?us-ascii?Q?3+4CKJsYmc55UTMoWBl7rlBM7AERufFApdwl2VhTnB7gpo6Gknfuk8dUx9az?=
 =?us-ascii?Q?wLajwK+V3o93+rOhE28q6cemHYU1lchi3c0asXSz8EVzk6Pwkf+Mv0OVwJi6?=
 =?us-ascii?Q?BxsoNKD0NtKx3iKrXWZBhxoyd+ZNtxvXzk5PBGlWY0mq9jc8U0gzcS8GUHrd?=
 =?us-ascii?Q?ixkVvljHgpDuXrya4MLEo6j/UYym9Yvvyl2E+m0zHCy8vbBqFDh4wZx0gjL8?=
 =?us-ascii?Q?MA2hzDyDAWH0iKqZzi0Cnvj4xRzGVkxPl6RMgNFe9CjlFuoPtxH2l/Xz2C+c?=
 =?us-ascii?Q?zbjdjJImHNOmLp+Ib3UibkEv9r5a+e+HGY8PnI6VGSd96XLjY0IXlzZE4+46?=
 =?us-ascii?Q?P8BXnd/520iA2DE6novxSNH0E1C9hI6lH8Mrj85qIw+DQ7yHRjfEmTJEiDZr?=
 =?us-ascii?Q?OSixfEp99vqsts5bsDPs0gMdkgX2lPhQWdhq0dVsIxQW/QlRgXHOGL62ensy?=
 =?us-ascii?Q?jKp2Wn8ok5FBH/sxMZ9dPrpz71Ozbo7J7Hv3vuf4K1ecYpsm8gWj4RgNLw1f?=
 =?us-ascii?Q?vM2S9aQz30iMbOZbs60VKQj1RUCKlF+UxiDh3MPYHJaCjbqmXlCmKuGqr2Dc?=
 =?us-ascii?Q?l+1ytL2JayUtSlj31RoeyJ4nCMfRQhfrv5xIqDJ5sl/2NcTjKL3wecqSRxRk?=
 =?us-ascii?Q?wLEEW64ZLFW7I20RcNrabaUeWhAy6NgPHvMPAZb4+f/6JLYh0e3vfIsbjuHJ?=
 =?us-ascii?Q?X53QK7bw4PYAfNoVsldVnkuBBH/5DJ05n3rzIR8QjrK2eobuuY31FTrdKj/7?=
 =?us-ascii?Q?lCR87vZuiCp0mrwNJaI5ON5GEmrk/5YNuqHeiMOGXgebnU8IGYAxqK1ubq9P?=
 =?us-ascii?Q?QYSCmrWSY75aEwz+nrdLJ+o5RUlRAxcO/g9V0m84cQEHBo1mW8aGusejrocJ?=
 =?us-ascii?Q?IMe68aYwqvq9kUNHIHxn1tAvPVZ5WvICtarsPdWiJFrkqz2IZ5/umYK/nrzU?=
 =?us-ascii?Q?yBqVHdRsKYgSdlKJtjsRuahSjVdZp/TAOsGEoEolGxJZDIij2x0ce0OFqFRg?=
 =?us-ascii?Q?JiR1Z3Q72XMekRFYR2eR9ApbG41SXYiWmzYFM4BbU+qk9hhEV8wJg7oKUjy6?=
 =?us-ascii?Q?/3G0R7ZgAUBbGkEqvJzotuiK3SdhnMTTRpjfW1wOwPs3M1lgr0LMl6x+c7vT?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MTbwZsvt+TX6RJuchYSAhEFt0pNhaSVrxsLlyGaAfmSUmNxgzAIwHuIcxd/M6KwZJTvZKH8uvMHSVhYZWiMCVu1kLv/LOQ4dCDaIY91Pe+1bBx5fyGsH24W+pWlxJl1P9Gge35+hDj52WCQaIk8fSpuigJAwBNW8Z9mmAQLWT0qLpAjI7A5e1+zN0sUnd2l6V+5xMlxclyOuy7wTN4aexSGUM+zaq/SadTmwy+wGC1N8eRhVWGjV/JJ6S7+sFUm0b27vVlr7Knt01/NfZw+NOjvxhX8Q6Y9yuoA6MPV7xr4w2b/2gE1YFtYmWAWr25BLZJ7W3mdHlB3o34B35w5PojAqA+kjXEXboMycabfp9PDyOtEho6t843s+uvBgDn7noJ5hhrYa0yu5KYfSLsks+l2EGoFxSWgAlJ3PDodrDrgmBXAxzIEJrdNBVB0Ro4H1qwzHi3XITSpG3eWJC3FHEdyE5JcSpKBzw83/YXLmw4fVBh/uPI/Mm+a53FYKoI7gHf5BCEP1THXvsI6XNEWofk85tBaOuE5q7ar8oCx+1OeDWBOaHt0M1KI3kGHFRsY19liCRzshgZ6boEsYbH6qZ5wBRFtK+k/VBACgDJmisSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5efdf4-9b74-4287-6598-08dc96d2dfaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 17:59:22.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwWZCmLIL1o/9iu9pQUf3+8EHzhnQYe/iFwaAXBhVRa2GAJoFpPX5KXiMpPBNBo5zZm+h2bF4MzmOjD75+4bbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270135
X-Proofpoint-ORIG-GUID: ceaLWtvrBsXlfcaR3d9DLNrvaaSY-8jb
X-Proofpoint-GUID: ceaLWtvrBsXlfcaR3d9DLNrvaaSY-8jb

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> The core components contained within the radix-tree tests which provide
> shims for kernel headers and access to the maple tree are useful for
> testing other things, so separate them out and make the radix tree tests
> dependent on the shared components.
> 
> This lays the groundwork for us to add VMA tests of the newly introduced
> vma.c file.

This separation and subsequent patch requires building the
xarray-hsared, radix-tree, idr, find_bit, and bitmap .o files which are
unneeded for the target 'main'.  I'm not a build expert on how to fix
this, but could that be reduced to the minimum set somehow?

> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  tools/testing/radix-tree/Makefile             | 68 +++----------------
>  tools/testing/radix-tree/maple.c              | 14 +---
>  tools/testing/radix-tree/xarray.c             |  9 +--
>  tools/testing/shared/autoconf.h               |  2 +
>  tools/testing/{radix-tree => shared}/bitmap.c |  0
>  tools/testing/{radix-tree => shared}/linux.c  |  0
>  .../{radix-tree => shared}/linux/bug.h        |  0
>  .../{radix-tree => shared}/linux/cpu.h        |  0
>  .../{radix-tree => shared}/linux/idr.h        |  0
>  .../{radix-tree => shared}/linux/init.h       |  0
>  .../{radix-tree => shared}/linux/kconfig.h    |  0
>  .../{radix-tree => shared}/linux/kernel.h     |  0
>  .../{radix-tree => shared}/linux/kmemleak.h   |  0
>  .../{radix-tree => shared}/linux/local_lock.h |  0
>  .../{radix-tree => shared}/linux/lockdep.h    |  0
>  .../{radix-tree => shared}/linux/maple_tree.h |  0
>  .../{radix-tree => shared}/linux/percpu.h     |  0
>  .../{radix-tree => shared}/linux/preempt.h    |  0
>  .../{radix-tree => shared}/linux/radix-tree.h |  0
>  .../{radix-tree => shared}/linux/rcupdate.h   |  0
>  .../{radix-tree => shared}/linux/xarray.h     |  0
>  tools/testing/shared/maple-shared.h           |  9 +++
>  tools/testing/shared/maple-shim.c             |  7 ++
>  tools/testing/shared/shared.h                 | 34 ++++++++++
>  tools/testing/shared/shared.mk                | 68 +++++++++++++++++++
>  .../testing/shared/trace/events/maple_tree.h  |  5 ++
>  tools/testing/shared/xarray-shared.c          |  5 ++
>  tools/testing/shared/xarray-shared.h          |  4 ++
>  28 files changed, 147 insertions(+), 78 deletions(-)
>  create mode 100644 tools/testing/shared/autoconf.h
>  rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
>  rename tools/testing/{radix-tree => shared}/linux.c (100%)
>  rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
>  create mode 100644 tools/testing/shared/maple-shared.h
>  create mode 100644 tools/testing/shared/maple-shim.c
>  create mode 100644 tools/testing/shared/shared.h
>  create mode 100644 tools/testing/shared/shared.mk
>  create mode 100644 tools/testing/shared/trace/events/maple_tree.h
>  create mode 100644 tools/testing/shared/xarray-shared.c
>  create mode 100644 tools/testing/shared/xarray-shared.h
> 
> diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
> index 7527f738b4a1..29d607063749 100644
> --- a/tools/testing/radix-tree/Makefile
> +++ b/tools/testing/radix-tree/Makefile
> @@ -1,29 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
> -	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> -LDFLAGS += -fsanitize=address -fsanitize=undefined
> -LDLIBS+= -lpthread -lurcu
> -TARGETS = main idr-test multiorder xarray maple
> -CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
> -			 slab.o maple.o
> -OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
> -	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
> -	 iteration_check_2.o benchmark.o
> +.PHONY: default
>  
> -ifndef SHIFT
> -	SHIFT=3
> -endif
> +default: main
>  
> -ifeq ($(BUILD), 32)
> -	CFLAGS += -m32
> -	LDFLAGS += -m32
> -LONG_BIT := 32
> -endif
> +include ../shared/shared.mk
>  
> -ifndef LONG_BIT
> -LONG_BIT := $(shell getconf LONG_BIT)
> -endif
> +TARGETS = main idr-test multiorder xarray maple
> +CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
> +OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
> +	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
> +	iteration_check.o iteration_check_2.o benchmark.o
>  
>  targets: generated/map-shift.h generated/bit-length.h $(TARGETS)
>  
> @@ -32,46 +19,13 @@ main:	$(OFILES)
>  idr-test.o: ../../../lib/test_ida.c
>  idr-test: idr-test.o $(CORE_OFILES)
>  
> -xarray: $(CORE_OFILES)
> +xarray: $(CORE_OFILES) xarray.o
>  
> -maple: $(CORE_OFILES)
> +maple: $(CORE_OFILES) maple.o
>  
>  multiorder: multiorder.o $(CORE_OFILES)
>  
>  clean:
>  	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
>  
> -vpath %.c ../../lib
> -
> -$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
> -	../../include/linux/*.h \
> -	../../include/asm/*.h \
> -	../../../include/linux/xarray.h \
> -	../../../include/linux/maple_tree.h \
> -	../../../include/linux/radix-tree.h \
> -	../../../lib/radix-tree.h \
> -	../../../include/linux/idr.h
> -
> -radix-tree.c: ../../../lib/radix-tree.c
> -	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> -
> -idr.c: ../../../lib/idr.c
> -	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> -
> -xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
> -
> -maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
> -
> -generated/map-shift.h:
> -	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
> -		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
> -				generated/map-shift.h;			\
> -	fi
> -
> -generated/bit-length.h: FORCE
> -	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
> -		echo "Generating $@";                                        \
> -		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> -	fi
> -
> -FORCE: ;
> +$(OFILES): $(SHARED_DEPS) *.h */*.h
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index f1caf4bcf937..5b53ecf22fc4 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -8,20 +8,8 @@
>   * difficult to handle in kernel tests.
>   */
>  
> -#define CONFIG_DEBUG_MAPLE_TREE
> -#define CONFIG_MAPLE_SEARCH
> -#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> +#include "maple-shared.h"
>  #include "test.h"
> -#include <stdlib.h>
> -#include <time.h>
> -#include "linux/init.h"
> -
> -#define module_init(x)
> -#define module_exit(x)
> -#define MODULE_AUTHOR(x)
> -#define MODULE_LICENSE(x)
> -#define dump_stack()	assert(0)
> -
>  #include "../../../lib/maple_tree.c"
>  #include "../../../lib/test_maple_tree.c"
>  
> diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
> index f20e12cbbfd4..253208a8541b 100644
> --- a/tools/testing/radix-tree/xarray.c
> +++ b/tools/testing/radix-tree/xarray.c
> @@ -4,16 +4,9 @@
>   * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
>   */
>  
> -#define XA_DEBUG
> +#include "xarray-shared.h"
>  #include "test.h"
>  
> -#define module_init(x)
> -#define module_exit(x)
> -#define MODULE_AUTHOR(x)
> -#define MODULE_LICENSE(x)
> -#define dump_stack()	assert(0)
> -
> -#include "../../../lib/xarray.c"
>  #undef XA_DEBUG
>  #include "../../../lib/test_xarray.c"
>  
> diff --git a/tools/testing/shared/autoconf.h b/tools/testing/shared/autoconf.h
> new file mode 100644
> index 000000000000..92dc474c349b
> --- /dev/null
> +++ b/tools/testing/shared/autoconf.h
> @@ -0,0 +1,2 @@
> +#include "bit-length.h"
> +#define CONFIG_XARRAY_MULTI 1
> diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/shared/bitmap.c
> similarity index 100%
> rename from tools/testing/radix-tree/bitmap.c
> rename to tools/testing/shared/bitmap.c
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
> similarity index 100%
> rename from tools/testing/radix-tree/linux.c
> rename to tools/testing/shared/linux.c
> diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/bug.h
> rename to tools/testing/shared/linux/bug.h
> diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/cpu.h
> rename to tools/testing/shared/linux/cpu.h
> diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/idr.h
> rename to tools/testing/shared/linux/idr.h
> diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/init.h
> rename to tools/testing/shared/linux/init.h
> diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/kconfig.h
> rename to tools/testing/shared/linux/kconfig.h
> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/kernel.h
> rename to tools/testing/shared/linux/kernel.h
> diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/kmemleak.h
> rename to tools/testing/shared/linux/kmemleak.h
> diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/local_lock.h
> rename to tools/testing/shared/linux/local_lock.h
> diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/lockdep.h
> rename to tools/testing/shared/linux/lockdep.h
> diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/maple_tree.h
> rename to tools/testing/shared/linux/maple_tree.h
> diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/percpu.h
> rename to tools/testing/shared/linux/percpu.h
> diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/preempt.h
> rename to tools/testing/shared/linux/preempt.h
> diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/radix-tree.h
> rename to tools/testing/shared/linux/radix-tree.h
> diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/rcupdate.h
> rename to tools/testing/shared/linux/rcupdate.h
> diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
> similarity index 100%
> rename from tools/testing/radix-tree/linux/xarray.h
> rename to tools/testing/shared/linux/xarray.h
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> new file mode 100644
> index 000000000000..3d847edd149d
> --- /dev/null
> +++ b/tools/testing/shared/maple-shared.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#define CONFIG_DEBUG_MAPLE_TREE
> +#define CONFIG_MAPLE_SEARCH
> +#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> +#include "shared.h"
> +#include <stdlib.h>
> +#include <time.h>
> +#include "linux/init.h"
> diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
> new file mode 100644
> index 000000000000..640df76f483e
> --- /dev/null
> +++ b/tools/testing/shared/maple-shim.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* Very simple shim around the maple tree. */
> +
> +#include "maple-shared.h"
> +
> +#include "../../../lib/maple_tree.c"
> diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
> new file mode 100644
> index 000000000000..495602e60b65
> --- /dev/null
> +++ b/tools/testing/shared/shared.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/types.h>
> +#include <linux/bug.h>
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +
> +#include <linux/gfp.h>
> +#include <linux/types.h>
> +#include <linux/rcupdate.h>
> +
> +#ifndef module_init
> +#define module_init(x)
> +#endif
> +
> +#ifndef module_exit
> +#define module_exit(x)
> +#endif
> +
> +#ifndef MODULE_AUTHOR
> +#define MODULE_AUTHOR(x)
> +#endif
> +
> +#ifndef MODULE_LICENSE
> +#define MODULE_LICENSE(x)
> +#endif
> +
> +#ifndef MODULE_DESCRIPTION
> +#define MODULE_DESCRIPTION(x)
> +#endif
> +
> +#ifndef dump_stack
> +#define dump_stack()	assert(0)
> +#endif
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> new file mode 100644
> index 000000000000..69a6a528eaed
> --- /dev/null
> +++ b/tools/testing/shared/shared.mk
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
> +	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> +LDFLAGS += -fsanitize=address -fsanitize=undefined
> +LDLIBS += -lpthread -lurcu
> +SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o find_bit.o bitmap.o \
> +	slab.o
> +SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
> +	generated/bit-length.h generated/autoconf.h \
> +	../../include/linux/*.h \
> +	../../include/asm/*.h \
> +	../../../include/linux/xarray.h \
> +	../../../include/linux/maple_tree.h \
> +	../../../include/linux/radix-tree.h \
> +	../../../lib/radix-tree.h \
> +	../../../include/linux/idr.h
> +
> +ifndef SHIFT
> +	SHIFT=3
> +endif
> +
> +ifeq ($(BUILD), 32)
> +	CFLAGS += -m32
> +	LDFLAGS += -m32
> +LONG_BIT := 32
> +endif
> +
> +ifndef LONG_BIT
> +LONG_BIT := $(shell getconf LONG_BIT)
> +endif
> +
> +%.o: ../shared/%.c
> +	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
> +
> +vpath %.c ../../lib
> +
> +$(SHARED_OFILES): $(SHARED_DEPS)
> +
> +radix-tree.c: ../../../lib/radix-tree.c
> +	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> +
> +idr.c: ../../../lib/idr.c
> +	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> +
> +xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
> +	../../../lib/test_xarray.c
> +
> +maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
> +	../../../lib/test_maple_tree.c
> +
> +generated/autoconf.h:
> +	cp ../shared/autoconf.h generated/autoconf.h
> +
> +generated/map-shift.h:
> +	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
> +		echo "Generating $@";                                   \
> +		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
> +				generated/map-shift.h;                  \
> +	fi
> +
> +generated/bit-length.h: FORCE
> +	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
> +		echo "Generating $@";                                        \
> +		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> +	fi
> +
> +FORCE: ;
> diff --git a/tools/testing/shared/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
> new file mode 100644
> index 000000000000..97d0e1ddcf08
> --- /dev/null
> +++ b/tools/testing/shared/trace/events/maple_tree.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#define trace_ma_op(a, b) do {} while (0)
> +#define trace_ma_read(a, b) do {} while (0)
> +#define trace_ma_write(a, b, c, d) do {} while (0)
> diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
> new file mode 100644
> index 000000000000..e90901958dcd
> --- /dev/null
> +++ b/tools/testing/shared/xarray-shared.c
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "xarray-shared.h"
> +
> +#include "../../../lib/xarray.c"
> diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
> new file mode 100644
> index 000000000000..ac2d16ff53ae
> --- /dev/null
> +++ b/tools/testing/shared/xarray-shared.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#define XA_DEBUG
> +#include "shared.h"
> -- 
> 2.45.1
> 

