Return-Path: <linux-fsdevel+bounces-47339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DCA9C4CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A043A74F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01F23A9BD;
	Fri, 25 Apr 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RndacCoJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4YZNh3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E36238C04;
	Fri, 25 Apr 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575847; cv=fail; b=KB+iQJJ4Mq9NKAuZMOGPDDYvT13YiqF+XVsbhffbe+dLUuCWISP4+D0CzyMWrGeNdtSEzLNW5B3HDroM5MZih8V2ZHjzRZnG7fXjN+gbyprUL+eya55iNvjqi/fgr4luWXk495PBHmF7Nr81AkLdDD+mEKHML0P1hEoJKxw95Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575847; c=relaxed/simple;
	bh=g0Zf0dwkNB9EXSECCWnpXwaXswtIkAfumkt6inaoJDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Su1HByeYh//1Lro3xJttoCQn7lgbIdhBY0DNKTHJCamHe6tIYJ47ZGUGO0atArNorMlBnaXPmhKv0l8qf/7AWSmCezQh5+z+kc6ijOLLqZOZ6czDJE7XEILWABIIBd/Y49gYOmiImTqA65EzBOWYvK1WiszYN2Pdb3/fsvJUIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RndacCoJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4YZNh3W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9UVBP020638;
	Fri, 25 Apr 2025 10:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g0Zf0dwkNB9EXSECCWnpXwaXswtIkAfumkt6inaoJDs=; b=
	RndacCoJLTNa9DgIpCmZ/S9Cm9AetjtWezZVlh+fKRX2hz++aS8apxfanWdxwNg1
	BGDFINbML6oMvT6SZv7giUa/gRlibU+kj02FL9ck4ElBuEGqwbI66iOh7oUby3wD
	Nh93OyfGPVjLxw4yOxUQiJBTvOx7zKmj8RilCwWxknKQymV+HROPcSnGpgXJzUgw
	fSKrrGqAPTK7WGL5ZJ5PdShfoSqew16teIyE3cmGPmz+UIte9aMt+ypYrRfmvo5j
	nDIiq8fGbq2tOQA7UPBHejWIkOieqw+kREqVvK0VPanUmtmghcefB5pJm8e/Y/jn
	ccxddeAnhFkAIt/QImVGqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4686tmg6h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P81U4W025237;
	Fri, 25 Apr 2025 10:10:32 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbt79k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpVVwsF1ttrj5H57a65bNlzpJzn6VT/UvHg7R1MBblJ1b8gvbaNVVMX/03kpu2E/43hHL9FAhyyov+EuUZbPUwD1RrVPo7LdrjTkjeyT7ES1O2qH4qCHZZwtyNoxij2wFHEgnp9GPsKNb0zZ2B2DynokJY9Kk7KSNgqO4U4Xj9sx8pWWoju92QOocdgZ5BFnkHGnHEfCEljtJrdQ3jdn0p2LswsuiKJuiv78mconElxZSLh8abayt0eq3abvNFXwk2XglW+mRv3s0yvKH9MgkaQjnhtkIkWNp0IX1oeBPsX2HEl+dFYbTPg6US5w6FZrpvXTLDtGQea9jgLyg+eM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Zf0dwkNB9EXSECCWnpXwaXswtIkAfumkt6inaoJDs=;
 b=lv93yiZ854v+xJyDfuDi3can9TpHi+voV+Jg9w31lJbM6TmXV9ul6FjIHFRTX1SLzKGzAJrOz4xg5Iziutu+PwCVty6ZGboIW+oCzMXMIy5jIVVUI+/lQhKIV8fHRfAxLPlHAqqvMCSIoCXs/BWhfKnJ7WYA3csJY+gdQluorL6UENk5mDRw1bNKLDdEau5CfLR5jviXZX5dFQUM2870yn6NIRWdzYpFCJaOp8TvH0F1fD9fAfUWg7w4BJKLIfrkU49+tTPW73KWxHjEuz5zP2tXQUXIuBAiY9U/UVznmz9mrsEEyYcdTLptIJVhfz37wGei4YeTjVQxfabJ3YydxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Zf0dwkNB9EXSECCWnpXwaXswtIkAfumkt6inaoJDs=;
 b=X4YZNh3W9Z0+GSnKKSXBG5Mzx4uqjSx3vHzOHUHX1ybPV+4Zay/4FjLo52/vpSGkKw0vevYp3OKz7shBxZGV3VodQsNl+qIL/o5Z/qZIjoDR3/gG55i6eBM1GCZkla9OIl7HrkIs40SGADhaY02C6HyaKgGWUraFqf08G/D7MBY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:10:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:10:30 +0000
Date: Fri, 25 Apr 2025 11:10:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: abstract initial stack setup to mm subsystem
Message-ID: <06a60411-d8ef-407b-b8ab-0e28e0b88037@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
 <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
 <CAJuCfpGx0UTXcFYE2Fw2Xaw83QGTVhWVOx6zt-TSgZWHVAYHCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGx0UTXcFYE2Fw2Xaw83QGTVhWVOx6zt-TSgZWHVAYHCA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0180.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b93c7ad-ea9d-4012-1e91-08dd83e1687d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG83QkloK09SUkpRN3VsUFBNZ25ZTWgxVGhJZWxodFQvVFdKZTNKOUM1Vll3?=
 =?utf-8?B?S3BLREdMeGlFNTgzTG1WUnR5VlBEa0hsOWNNR2VFTisyZFdtWTB2cHltUjBR?=
 =?utf-8?B?Q2FYazI5TXdnNEVwc3VBbEZaMDRhcUY5V29od3FHa0Z0RTBQMDgvZW9TVEp3?=
 =?utf-8?B?U01venpNWVdqNXlYQUxoREMrYVN6WGFOcUNvK01mUTlLRmM0bzRMcmdJRURl?=
 =?utf-8?B?Zkx6ODZuNjYzZUkyak1QTjJ6aWVDNjRNZmJSanVwOXZBWWJyVlJhSXJPRjRi?=
 =?utf-8?B?dm5IazBWckFzY0p0T1F2ZXJsTVBmSVllYXk0NTZPSVlqYlhHQ0hTTTM3Qjlz?=
 =?utf-8?B?ZjJ2V3lldklhdGgwTlgrUkhEOGtnclBLT2RMSlRkRWl5ZjVnZkdlemdCMkhH?=
 =?utf-8?B?U3JtdGdpYmk2WDViZG8yR3A2N1RxRDd0V1c5OXVvWUtSWDV4cngwNXd1UWtT?=
 =?utf-8?B?L1BQTS9Sbmg3dFZSeTVyNVB6SDdHdHRaRnc3NG94T3M5SW1uOUwyeVBJVDlp?=
 =?utf-8?B?WFhSNW15a1dHYi9NQy9UT0tJZ2VmR09FQ2FNQnFFZkNmaG8zSGpMUTY5OURI?=
 =?utf-8?B?OFFzMkVnNUcvdy9VR2lqM3JuUE8vOU9uYlIwMmtvVWgwUVZxNm9yekhlN0Yv?=
 =?utf-8?B?QU5iRllQSmdUQ2FYSVBvYSs3R1RJVFl6VGRxM2JxdkZnbWVSVTJKeUJYclNQ?=
 =?utf-8?B?TThOSW9wUEszSzhXdnVhMzg1U3g2QmI4WmNwc0JOTUxadXcyTmpZemthRkNt?=
 =?utf-8?B?aEVaaUFXZVcwRGpaRG9idS9ic2xMVVU3TXNVTzNUd3JsTlRZaUxjWiszMGth?=
 =?utf-8?B?dDc1Ri9IRXhGOU94UDR3RXFDQ00rWDdsdGkxMUl2VVlsR28xMGYvTnc0ZWl6?=
 =?utf-8?B?NnhGRFBBWXVVKzZ4bkhXOFMyeEZhWWhYeko2OTJoY0R4SlVOd0lqOElkNjlK?=
 =?utf-8?B?N3d5VXRuRndmMFd4ZUFYM21PSTBPNDdtaGJYcndWaXNjckgvQU01dEFObFRa?=
 =?utf-8?B?R2pLNXpkbFRiOU5JaTRReWkyQitOM2VBRGNHWkVBM1ZFSnBULy82K29KcExT?=
 =?utf-8?B?czVTL2cxTVZxYmdVZWk2OFBEcHNkd2JCZzFhZzNRZUN1SUR6ZmZQNEMwc3Mv?=
 =?utf-8?B?eE5yNXlJRW56M3RlMUFsMEZQL2FnMkVyUjFwRGVPbUo5bkVXcWJFM2tBdnFk?=
 =?utf-8?B?bGhyRys2NzNVOUlJK2t2RlkwOW5hUlFtTHZSMXlRZ2NCZWhWUzgvQkJOVHZw?=
 =?utf-8?B?RW4zQnNSWHRNN0YzWWMrOTJiUFNFZWVIME1aRVd4eS9lVmJLTENpYkRlVHRY?=
 =?utf-8?B?QmpHVWk0dEpDMUFBYmVKN1psL0QzWWZRYWExbDZjNmtyM1VmQzZtcEtqcmNi?=
 =?utf-8?B?UlI0SjNybFVkclIzQ3hnZjdJRnFkY1dDT2FQeFhHbXNialdYT2RaS2w3SHQ1?=
 =?utf-8?B?NnZIRUVFZVc0b1cwRXBJKys4WEZmK05MM0czeXBYQU00VWVFUEtUd05iak9p?=
 =?utf-8?B?Z0JPdWowRGlTdUdyUHMvSlhCOG5HQ0dobzhnTW44ODJvU2ozV1NLWENDT3RT?=
 =?utf-8?B?V3M5WURmSzlZZUtUa3lvWStJcTNFdVlIMWxhZjlRZExxanEvZExtSU45UjFl?=
 =?utf-8?B?TEVhaktYUnUxNE5PblprdXdXU3JCMmY5M0VjWWhsZWZhYmQvbG5zM2huVTNw?=
 =?utf-8?B?MzZ6cm1sY08rU3Uva1ZMNWNzdXhuYzJRdldMUlBCUEc3OWZVUjNXRys2b3B6?=
 =?utf-8?B?ZUlveG42SlZZTXVLckZGSFQ3M3FSTjVhWTIzWFZqNkVqM1Z0a3ZPcVo4Ui81?=
 =?utf-8?B?aVplUlJ4K0xJY2ZLeS9aMHhOeTVFeS84KzA4bG9Rc2dTRFROWnpKclF2YW9a?=
 =?utf-8?B?VDc1anViYmFaeHV6bW00NmFOcy80a1hxdUpRVlF5V3lYcFd3Mkx0a0UzdVNR?=
 =?utf-8?Q?qkV7yZhT0vs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2Q4OVAwYUU4cm92SXN5STRjcjQzVUNEdVZoNDdVRE5qZXpjc0ZKTUFXWXBB?=
 =?utf-8?B?UnJtS1VLYXU5b29ya2NPRU5sY2k2ZW9TMmJHNWxFWlZNUS9RWkJXcUZzbkFU?=
 =?utf-8?B?S25hVUh6R0FPS2lCZnAwRmJjOTU2UFdHdEd0ZWdGb0REQUdwOHNVcXBTM0lk?=
 =?utf-8?B?TXY3K040SFF3K3RTemNwcUdTa1l3N1l1dEFud0lLai90dkRhcmNNL3IxbVJF?=
 =?utf-8?B?ZXdiVk9tbHBYdWtCVlM4UzNsL3kxSDJFdEVRV3RyTWhsSFNCK3hra2I4bnhL?=
 =?utf-8?B?Y1ZLZzdvcWlnYnk5RFNoRHZMMFkvbEoraWJSK3ZKQTlhcUExSVp4YlhjYmZK?=
 =?utf-8?B?cGdYSFJCa1E3TzRSM050VURoVFcvQWZpQkE2TUZDeHlkRVpjYWlOMnNhU21v?=
 =?utf-8?B?cCtrOHJJTXBqWU9MMUt2c0Zqa0N0dFYzSnQ3QkFubHYxcFBTQlVrWGZnMmEz?=
 =?utf-8?B?bmhDVWgwY3VYZHR0VEVRWDN1YktoYUlVajdHYXUxK1RWM0dDYkZENldxWGtV?=
 =?utf-8?B?eG9aWm56S3lPRHBtK0xZOXBtbExnT0NtKy81aGZub3lqdzZYWHpPUjhLbnhI?=
 =?utf-8?B?TjhvS3BFUC9Cckc4SkNzVmJiaW9mZkw3UWhjYXBWYzBTUmpSMUcxUjBVZGVo?=
 =?utf-8?B?MGo4blFvQXoxc0tDOTB0QlNNdWNIWFRxRUQ2a2JWM3MxS1FHVU1ZVUlEL0M1?=
 =?utf-8?B?L2hndlRYTzJ6c0lleERFNkwzT0txOHlWSjZjcU1YVThLYWF5MnU0ajJEa1ZC?=
 =?utf-8?B?UVE1YnU4Mzczck1VVTRxNVNOdFFOdGZnMU9lbkJUOGN4N29ZRkt3V3dOQk0r?=
 =?utf-8?B?elBHOXYrRHJjbXpqeDJqZlBrdEE1OUhBbWcvWFF3bmFQNWtSSlBrTjQrclZX?=
 =?utf-8?B?NXZhalh2YlNORFBaS0o0Wi83ZXpnNHhJdmk4eU1PcGpySFNYc1NZQk0xelZC?=
 =?utf-8?B?UUNMMjNPQ09SRWNjcG5mbVlnOVdsem0zVEIxd0FjY0RoSGJmMzV3R2FYVmJw?=
 =?utf-8?B?V3ZoNWs5QVJzVWd6dzY2RDU2dThrMTRHbVFZVXY1QzJKejBna0NvMEZJV2FF?=
 =?utf-8?B?T2ZvV0ZoaE5nOVRyelVsQkZQaE1Kb090M2JEQ1JxM2lCZTVhUWZ0NXVhTFBR?=
 =?utf-8?B?d3BRLzg5eHVYYnAwazZVNUpIaUpMSDRRaitmdFJJUGpYZGhPNHczUmRRcjAr?=
 =?utf-8?B?U0ZtTlZWclRGbGpnUmgxQm5IL3JQVi9yVHNaUm5yM3BKTk51YUMxYzNDZzNk?=
 =?utf-8?B?SHZrSnk3emJEMDZxdWc5bHcvU3JkWm5TTVVhZjM2c3NLalppOWpUSDBXckFt?=
 =?utf-8?B?YTJEZUIyVlpwa2Zqa1dyTjVyZHVpQUhoVDlRczVxRVZtRTNNblN1bmhzTFZI?=
 =?utf-8?B?WkczVVFyN2ZPOU8xUGRudEJQNmhPZzNrOVoyd29BS1BsbmxDd1ZIb1R5RnAv?=
 =?utf-8?B?VGRBS0NUS0pIcVlVcXJubUlGNWZhTEdmZk5Rb1ZTa2lrTVVFMzVkbUlGRGZt?=
 =?utf-8?B?TkJxNFdOdGdsanhFSnpJSGw4QXVjWkhjMENrMTFEVkJaZ0FuTTE3a3IvS0Zm?=
 =?utf-8?B?VzdGYjJ1OURONWtYRHdQMGJ1UjhLdHJXdjNGTVpodDRxcG1lL2lUVGVXMlBm?=
 =?utf-8?B?czAyM0pJQTg2aU05aENSczBFYU42Y1ovMTU0c3NuZE9jUVNCaDkrQTU0T2RT?=
 =?utf-8?B?V1dwOXRBN1NXWnVBY09RUDF5NWp5K3RkbkRKejd0Vm80NG5UNFJTMXZ1bzRi?=
 =?utf-8?B?bWtSSlFldW5Wb1RrYkE1c0Nmemd0MnZaRDhjWTJ6UU1mZXBXbTBqMUJzTERw?=
 =?utf-8?B?dk80bjNlTENDU01Xb3BpUTZmYklEZHBhbVBtdW02UUgzWVBKS05MYTJJUExI?=
 =?utf-8?B?U3NLT0ZYQXZjRXpScTFCTmdTMUNpNy8xSFlDdENacXVNcHBIdEhnb3BxSHZr?=
 =?utf-8?B?d01ieTNIMG1YRUMrSGlmZEFJK2FUMGxrT3RNRzVocTZ5TlozMGNKN2JHZzRQ?=
 =?utf-8?B?RmUyZEEya1RvcncwVnFmV3E5S1NsMG1XNTVZcms2VC9CZTNBWjdwUEw5WjE1?=
 =?utf-8?B?RUMwYkowRXVkTldwVFNQVHkySEgyN1VRaktXbWdwNUFxNEtZZjhDbjhzWTdt?=
 =?utf-8?B?WndZTWwyR24vbnpSbWVVemc4U1dFRzBwWWJMelF5S0VWNVVuR1c0V2lYc25z?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sCL1G0JH+rPKEtKA3BqWXN6JsZDMMwZGENYIF5doCcTy6Ij9Too/D/srCimUUVxzicoys+mrcq/dPG/b2se90oHRRdsYZedGopsX79eYnQPnpvSxsYE0i1zUjHeVET1IkGhORXdIDC0pt6SLKaPPSHww3a86sl22trQGTI6VAan4tFN4LZ7fPYABIvyZnuTG6uMvHSZQOsoQsB2CCjbxLJ8X7iXpG06okRvc9LAqNjwpYSpvg8QFX1EwagPthyHCbC7B+d6QsYwRyZptYuzgBIiXTKhQbqEXIF84/QpWGmFmsjExPEJc1iX22mNPIadUxMilA8dlaVJHPgRCJyd5mT3xTuZsd/6gcdlMLSGeQdOlDcqflDspcWk0KDRd+kG7DtPYk4J/EUeqD6bgz8709QtyNTCvSxftnMGm51OcvKpEdRgTqCmX6E5vS7wuRmK+h4QBr+yuSSXw/3g6ns1iRumOGbabUDVXAEpfXvFvOYRU43ecWSyy4qLpgw+kkrxxWs4fhp/3s6cvb+zz8+uaBiDf5edkGGQG/LzjS+A62qraJgqNz6o0FjWyQb8pqUYXGpYa8cKNgfBz3SnZ2uDrZjZgSDA5BRFZOaqxphNOX9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b93c7ad-ea9d-4012-1e91-08dd83e1687d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:10:30.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKxl+15keEroX0bEWKn7RsIyu54PbHElisCG2FNydq5fJ9AD8PnEB/b5JVPpZI/Iov2P7/lQfw3K1kf4eHeEcP90QC3tE7xWZkOV38eY2Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX+fasB7X4Xjas zXnF0iu5tcv2FCoMPZblQc0rKPD/ymGmGWxP2mDSABnvRUDPOaAh7C1vLSGOnrfxscWkG1bQrpa +Lo1UQrM/+ItejQ4+fwjRz3WxUSXWaKziimM7FTwwUCFDdUsAm7AqDwcox8Gnr9jVA3PEv7PyNq
 9Ce7tZY+zN9TIU5wWNNut0nmyTI7krzUzvKjsEyxpKctgNwuz5XlDtOjIDo4672wB2Rph3j1fpu M8QtRDWm45Vxsapmqcq0mgIfRqKHljUEeudzwY5H44QjArPue7r3CNZCINOqjadPQgHXEPJUiGv 0JFcDSR6No8vku3Nau48Op76LE1P4pRE/GZjcb1BbagWyMzOg1WuIOSHVjjv6t/Sit+5NXoTPzD 4wB9V28r
X-Proofpoint-ORIG-GUID: 9WyZyhQPpHorVF3bC-sGJjBMMbjSsUgF
X-Proofpoint-GUID: 9WyZyhQPpHorVF3bC-sGJjBMMbjSsUgF

On Thu, Apr 24, 2025 at 05:55:20PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 24, 2025 at 2:30 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > There are peculiarities within the kernel where what is very clearly mm
> > > code is performed elsewhere arbitrarily.
> > >
> > > This violates separation of concerns and makes it harder to refactor code
> > > to make changes to how fundamental initialisation and operation of mm logic
> > > is performed.
> > >
> > > One such case is the creation of the VMA containing the initial stack upon
> > > execve()'ing a new process. This is currently performed in __bprm_mm_init()
> > > in fs/exec.c.
> > >
> > > Abstract this operation to create_init_stack_vma(). This allows us to limit
> > > use of vma allocation and free code to fork and mm only.
> > >
> > > We previously did the same for the step at which we relocate the initial
> > > stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> > > establishment too.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > ...
> >
> > > +/*
> > > + * Establish the stack VMA in an execve'd process, located temporarily at the
> > > + * maximum stack address provided by the architecture.
> > > + *
> > > + * We later relocate this downwards in relocate_vma_down().
> > > + *
> > > + * This function is almost certainly NOT what you want for anything other than
> > > + * early executable initialisation.
> > > + *
> > > + * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
> > > + * maximum addressable location in the stack (that is capable of storing a
> > > + * system word of data).
> > > + *
> > > + * on failure, returns an error code.
>
> nit: s/on/On
> You could also skip this sentence altogether since it's kinda obvious
> but up to you.

Ack, and yeah probably best to just drop tbh :)

>
> > > + */
> >
> > I was about to say, if you already write that much documentation, why
> > not turn it into kerneldoc? :) But this function is clearly not intended
> > to have more than one caller, so ... :)
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

