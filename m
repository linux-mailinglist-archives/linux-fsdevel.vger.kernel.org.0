Return-Path: <linux-fsdevel+bounces-22682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B549591B00D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF141F210BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EC19B3DE;
	Thu, 27 Jun 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1ncMCS9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IrSozVaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD145BE4;
	Thu, 27 Jun 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518630; cv=fail; b=Ype7jW/XB71SHmWQpotu6MCqiRC5fkJJrpv7LfFUOj/aq7GAHzFKacFUMfmn2/ORvYUtii/w3kkxLBvKXAK19sWX9o8+ekyijh9o1U+aJ1hyRs1ja8Qyl8omHrMziL1z9Bvvs29CJHgr5oXGseVg6Wl4YSbTX0RSfE5IIBTFPqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518630; c=relaxed/simple;
	bh=q+Vx/8vwvLU2tH5p+vCxz5KSgWlEl/nuaLju2s1+hrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mEycIGiYdIoEof37BEG0+iQx1zmW/57Rfo8mYTsglFLsMmcS8Xv9gRg9NgJKsWHsEMr9dMzY3Cvh5vp4u/7v4rDWpUL+Go6i5YQZyPP3X++fo3pRRsgmZr3knL9w/uahznt5e5DVaK6iUPDvYnuRBoGX7Gr5M+G1IuRrPA+hQy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1ncMCS9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IrSozVaF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtXYx027176;
	Thu, 27 Jun 2024 20:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Z5ON2SqwtD3drdU
	opAal7M3kwCvZxsPTGwcKQXPq3AA=; b=g1ncMCS9kGWahIVTW7gqu5TJQzVJu+B
	DV7b6DrY2lBH1HN2yDHPzZBm6DTPUi65sm4e3BPHLxIE+VzPUn0lINM/ZvQvqvos
	t1+QUMtXghrFFQrpQ4BiDn++rlwdVVw5nqS/5z+hnGE2vCmsQRKekfxXhQg1Sucm
	cGukv+63HAI/JYW8F/oiHKsVCdGNaxY9POzyhyX68jKWpYbH6s11SZtAEUxQQeHQ
	+/867bIapM0ZJhMGzA639k0uZYGCzy7m0PtCoqKGYwCK6eQSdzMwL6LKs8ztHDR/
	EQWfJCQiz5Ph7B7OeY/43qwV8LtVjxSod7lI3Gbi5WRhWqQw2YkO4LA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9eku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 20:03:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RIM6MP010788;
	Thu, 27 Jun 2024 20:03:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2hddpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 20:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMbOWexpUA7z0jjexX7Pi6Pj3A3M+tEXsSyA69f5UpLWidO3jK6ykxpMbbuK30ZAHmIHqscwPbKUJx9VapGa1UKG+iIlkj8PE4dSNNi1QJzt5oFGDau+17uh9oL08o7AGz3SOG1UtDdNgBkkSn+c2EPDoCSj0Ps97YNKQhqlevbhldIbbumeCBJftcyWkqjM1Fr9UQQyD4wwOyAUptiH+4rKABUUvybbgg1fyH/f5u4Aa916VTz2bqTJhfuciaS8QmywT9pnN9uvu+TU4i73Wa9rbJcsmkFTahbfXdpwftCGkEw1+1EIR8YYwwrM2xUgknQ7pygAsHH9326NKG+HdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ON2SqwtD3drdUopAal7M3kwCvZxsPTGwcKQXPq3AA=;
 b=eFk4QV4/GQ0j+RqPJ+5i/blooQlVwVNKHdU6wVkdQ1hyQui7rZYTopdndtje9moWISzkl3Q+EnwPZ12Ysh5YxpONJnoDcbWTKl+G0N9q5HNem3QylncdmHzljDRydOrpWywXY6TELIUrBagJkKcvjK5/dKT35R/4CASX6gjL8syBfplG+mqZ/SS6waQ41fDxlsAEM30op1mXlKTxyixGlzZvhGVZeS7ekcepzAeDs26DUEAMvBmKCSHTgaGQZtLaDyvF5AyGnvJkmFOWnAstkYEhpEFRCO4GZxvAMRN8lHCQ53gO2mJvMIjBM+275RS0/KVgebA4To7oMQjOm4MsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ON2SqwtD3drdUopAal7M3kwCvZxsPTGwcKQXPq3AA=;
 b=IrSozVaFdWLMlnMWiLbczdD03Z+No0lYHmY0qtp3EAVg1yJ38bh62DKFKzIvQJoHlxBLnK6xQEj/5U1IK0HuDEF9EwAdau5DGJabayhW7jJVG2YhegrfBhAqE8IAa+VFBWf4C5xAO7AhTSn4/qKH6EhpQ/XlVoGMyjyLbGXM0fc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB7484.namprd10.prod.outlook.com (2603:10b6:610:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 20:03:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 20:03:24 +0000
Date: Thu, 27 Jun 2024 16:03:21 -0400
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
Message-ID: <mqqoj4c2777ypdmj2o5xyofvitytijfuxwjqujnaww7y22zrob@rof2tmdb7hwl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <c23f1b80c62bc906267a8b144befe7ac96daa88c.1719481836.git.lstoakes@gmail.com>
 <3kswdhugo2jmlkejboymem4yhakird5fvmnbschicaldwjwu7x@6c6z5lk4ctvy>
 <c2797b55-59cd-4731-899f-015631c1e553@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2797b55-59cd-4731-899f-015631c1e553@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d88a219-1ba4-433b-1ab1-08dc96e43365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JGxHXTTqoO9C3i4evv+xlLOFzCpdW69V2sVxGWaawS7dOkU7Iblm0Iua8ee9?=
 =?us-ascii?Q?A4UIW+S3QfvPMd+PNQ5Au4dLv/F/zcyV5rrTUu+w4dLLEW0SogpnqBIsWjdx?=
 =?us-ascii?Q?z5x0hU45L5r5fazC7h+hkhZbUZ4I6pujoZpWkvUexbG8DKCwV99cOEMD5z01?=
 =?us-ascii?Q?V1zA8FxXnRdxSwAG/8/RkENQR9rzYuwofKDcVvCqKvir/vUhPnrOdhSniezP?=
 =?us-ascii?Q?vVAC/EZRrxIxCuMct1tntgRwkv05ifp/YF6WZTNB21hYtXPhxzBlemJNA5Kf?=
 =?us-ascii?Q?P8qeoWtmQWJfX97i0ZAb/GU53wBvi9wy+rZTIsbphC8QpBTJQp2dzxFb3tSk?=
 =?us-ascii?Q?lsU1+Q3l+Is40GbuMrPCBde1lua6KX3MZygpRaWXAfhiQQldymuzV+8yV3q5?=
 =?us-ascii?Q?d0HWe1KoihFvkErluMwW8zFSE97i7HavVWndm2KT0O5fMGF1a7TYx4MrsVEn?=
 =?us-ascii?Q?MRyc/ZaLzBVFXfs1LMLgvNKI6pu5+gw5tqYL/rQM9TWH7FmCFbTrSXuNdahU?=
 =?us-ascii?Q?FM1kS5djXO4rzrWGKuwcEU+e2pIdpwtsiUUckELU53zqBDPx8+Ppi4HiLGZ/?=
 =?us-ascii?Q?7LZCr4zMGclJ+DaFyCwD5TuoiNtD3xUUhd8c/tBxpychu+cDTbSevAVOTzFA?=
 =?us-ascii?Q?ZhYM+gOsrOGtmbat83ERUcVCTyow0I+36oWGQOsz9H7E6/peT4i6uA3/YuVc?=
 =?us-ascii?Q?9oUC2XnvE3cjHGYXRrHaWFgnAnpBWPocOHongQgq9na+DCM6OLz80WaUtAZ7?=
 =?us-ascii?Q?JSNHJJWANUu6HRxFoi5W1DP8tNhdtiHCYDR/qqao/CKLH2oYiqFIrBgLqikX?=
 =?us-ascii?Q?BMNHGcyxNyXshY7PAb0JmMHlYR7hDcHTD+xI2kwuyU5u+2iATzx+GL+slBOM?=
 =?us-ascii?Q?l2qKfqe3PFws+YvOCqkdB4dTVzZjQO9PkkABb+0kG6Uy+5cyrxPHCVQ7xpVC?=
 =?us-ascii?Q?R+T+T1KRqA/6Odoaf4BvsbYILcfusP2ocDw7mzjKp3eMkz/IFn0QjVQEdDJI?=
 =?us-ascii?Q?ruDJiBjRD+d0thZuRgVCQUhd0c3alb58x5Iod58RikHMh/jZ87G7917f/9Hh?=
 =?us-ascii?Q?0GCWmalu+ebScI6Z0Q+E4Pn5MzBfn01jKmwcppyrXe2OBIq3d9R/S8pHdp79?=
 =?us-ascii?Q?+cBwkoZsJosN1CA51DwqkSg0nW2xjtozcURY4JcmjdW3eYSawRlz+5X5h2k2?=
 =?us-ascii?Q?7gGpl294pJ0j/lox8cJdH4cIiaN66IkTyNJLe1rK0hGXgh8ZEKkYG2mC+U1t?=
 =?us-ascii?Q?2QWm6DHWjH+eqS0mIRAJHPhDYsUPPi3SpMi6c4yFzMqbOtSAhiQiN4IXI1MB?=
 =?us-ascii?Q?1YFVTbhX5QyDhUZKHBLiRRwhgX7bo1aSQrctI4FZouSEIA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8t+CPHTLveQdxn4msIoSH6AcQ03z1HDx6Iqh4/tdFbZK5Xckr/b51fMLEv19?=
 =?us-ascii?Q?3WbEeT7DBFGST2wDcr+2yZiSNFOuoRI6+IpjJLExY2C/kJuP8Uqq7u6pzxua?=
 =?us-ascii?Q?ZH3pm9NbLCYVjAfuCfwC5zFHYVqesmG63rVrTI/79BLypdYfRiNKOg1uUMGy?=
 =?us-ascii?Q?WMchHgmlu0VUlYsVFlfVmY5NatBKNvNQHIagHFFrPZBqa8jRBGH2agnkDMc/?=
 =?us-ascii?Q?l/QgfBU6vSiXsD/WaofMBas/iMTDw19NwLwV01/t5gsfylpJmVk/HHTfWoOR?=
 =?us-ascii?Q?bqEbVnmFtKveORAiRoA/O4+YaWpzhbUMENZSDWOl2T0TL3kcIL7dmoFGwHZk?=
 =?us-ascii?Q?DFHthHz4eEcn1PYNdOAK0p2rmFwJQqrSTvkLLgFGxzWnU9xkQ3PMbsuUrzfG?=
 =?us-ascii?Q?/JTJelHpJC+O5/vOCUpAGiw+RtXiWOL5kQ3C53q7K6RFC+g5Bu2g0TrMlXA3?=
 =?us-ascii?Q?Hl/sCe8baufGMPDDmw/yPA374Il1xiYTYdvWVelldRpIh/U8G10uhV044LbQ?=
 =?us-ascii?Q?EHZ3ZzKqdmQUPDVK+aAjyMlcCqnGB8kzygdqacN4RdR/FZutY9dzSyWItsVX?=
 =?us-ascii?Q?LW9ulnHkNK4zxXb+pQ2Dc5jopi3lEIg19RmMa210IY5TIRgB6e4pSzm6EIeV?=
 =?us-ascii?Q?Xd5ofBhIwHZVrUVKy6ytO+yJvFZxCvAocBM8DOcuN2MUIs5IFsRKqCdD4nNr?=
 =?us-ascii?Q?wGh9KIUd6nrIxf+Spct/ln0wE7DzEEDBl1GVfqV0jjJjSFH944zaRWIoBE88?=
 =?us-ascii?Q?enEX+W4HqKI12g/EZUT2xA4GLjZB3cs/bptt1D5cEKzIgRwXmNltCH98dHuv?=
 =?us-ascii?Q?2NyRMbHv/XRVNn9HmvZfYD4uOluyi8EzZ9lPnEFBslWl4zWnL8rCnfTkpask?=
 =?us-ascii?Q?VUHSupgl8dlwsArbUy6Rgn1CaJDBbqmbuj5LZmWRK0v/o/+4teoWJNGn1+gK?=
 =?us-ascii?Q?MgzwMCVm6UMPxCqx6iMYToAPPT4Gy4/BbJdt3skSg2AiHVQbQWhRDWS77MD7?=
 =?us-ascii?Q?3OZb6FY+RIvrXifFvhL0mreht4TXno+z14DwRUGSyomoMYw5Iyx5ZtFVLnQn?=
 =?us-ascii?Q?hMznA42IpQykWwiRc9EbzAr3amqc1kYNQ2sHVPpjb/0297rDq4lbBpdYS5aG?=
 =?us-ascii?Q?R0QxVKog7GiIGaOG5fAUgZ859Auf0VHRRWmxbYNvl2kCPJ5JB/IrYLKExcM1?=
 =?us-ascii?Q?9EF/stFVMkLZ3p5Y0ih27YDfvhQwQJbCfgvMojP5tAbh09hVTkzrspCxBOrE?=
 =?us-ascii?Q?5cCbDT+oiTc+x/0FV3gL9viU1TnLNr5b39DzhmeQ4uX0k7huzHeFIhOfcsB1?=
 =?us-ascii?Q?8cu7NxOimKap10gEG5PvNjudiLmP0Go+SyDIdRKeEyAwFWwRDfcw5I6dyDWN?=
 =?us-ascii?Q?+AcDwqxekqXPlWSE0Y7VWH0SmEWOhXcHSIvGold7PjTIJ9DxGz0xO4//MqJI?=
 =?us-ascii?Q?kCFk0K4z5rsZ0toXgPZv94BCNCO6uA9GxskuU4451k2BMyZZ6T6dWaAAV+e/?=
 =?us-ascii?Q?VNOV63Jf3SxRTgknHTNZg49DwyDvHdAQ4C4lVQd7uoYztgF5l/zCY8gNC8Xc?=
 =?us-ascii?Q?LD2FC/2ZVBfHOBK2edxgHVcMK8gfY0uqkpxxgqkNFN2cP4AJ2Kvwf/ntGWJc?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MjRuTnly3Ef+PCPzFZ3dQjCmSjbdjNaBWQQmFM+OQAObmAM/7mpWSYkMJsIyddD0smbpSXrNAAUDBQgbVZzJQqD1f9eFXVBhigmpuHPMaHPq6ibBmPRmhyeEdDn8xQFBcNcEClV+nVXj0eofBRM/hPz0NCTTstpX5h0Jiubh4eNa19O7GiVN4YxU0rSj9QW2yf3dGZb26grJVo3aJvnbZT9czy3CxFx5aJB3gv4++GsMKUhVlzaRbZI/UbjxHUdcxkiaS17cbQy0mfAWitixI+dMW93a6n+UErkY6x335t4Y3X+2weD19B4PQvi86LqaOS500bEbrSWLweTrxOQ0oZ44qp8ulN6C9PVKSfy+UNjT4TWnRrPnWbEfOHLL9kgfGAfb+3DSaxLdhHFiRxDnoZtuxcqAvN54372bFM8orGOz7LC3VPW0HetZys2epvZOyrs5gEcq4dr6qTgbgLiBcyjSBp1Y6EtZKZiWuIIjS9NzBMOiEpOOIH1kYF4rVpu+lYQxjTud4397/DkJMJcfSlQpQVobSNEK03KwbMFpZGo1iGMTXB8tONGfHz9Nd3FGrK16L9qZl1l4FkDya9wAsatU6EAVEK+gOLGc8K6XJj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d88a219-1ba4-433b-1ab1-08dc96e43365
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 20:03:23.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB07vZeCriBpgRb4ZBclS7EbXEqGs82605ieReN+KDdD2JqU9cUjXB8+UizpXn3dZpuR7OjOMQ7DSNCI/1qhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270149
X-Proofpoint-ORIG-GUID: 4Kt72v-B9DPCH3HedR45b_wvNgWOXiBH
X-Proofpoint-GUID: 4Kt72v-B9DPCH3HedR45b_wvNgWOXiBH

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 15:47]:
> On Thu, Jun 27, 2024 at 01:59:18PM -0400, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > > The core components contained within the radix-tree tests which provide
> > > shims for kernel headers and access to the maple tree are useful for
> > > testing other things, so separate them out and make the radix tree tests
> > > dependent on the shared components.
> > >
> > > This lays the groundwork for us to add VMA tests of the newly introduced
> > > vma.c file.
> >
> > This separation and subsequent patch requires building the
> > xarray-hsared, radix-tree, idr, find_bit, and bitmap .o files which are
> > unneeded for the target 'main'.  I'm not a build expert on how to fix
> > this, but could that be reduced to the minimum set somehow?
> 
> I'm confused, the existing Makefile specified:
> 
> CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
> 			 slab.o maple.o
> 
> OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
> 	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
> 	 iteration_check_2.o benchmark.o
> 
> main:	$(OFILES)
> 
> Making all of the files you mentioned dependencies of main no? (xarray-shared
> being a subset of xarray.o which requires it anyway)

After replacing main with vma and dropping the vma.c, I can generate the
vma executable. I had to generate map-shift.h and bit-lenght.h, then
execute:

cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o vma.o vma.c
cc -c -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/linux.c -o linux.o
cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o slab.o ../../lib/slab.c
cc -c -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/maple-shim.c -o maple-shim.o
cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o vma_stub.o vma_stub.c
cc -fsanitize=address -fsanitize=undefined vma.o linux.o slab.o maple-shim.o vma_stub.o -lpthread -lurcu -o vma

Dropping a number of the pre-built items.  When I looked at the list, it
seemed too numerous for what we were doing (why do we need idr, and
radix-tree?)  So I tried removing as many as I could.

> 
> I'm not sure this is a huge big deal as these are all rather small :)

Yeah, maybe not worth the effort.

Cheers,
Liam

