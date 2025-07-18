Return-Path: <linux-fsdevel+bounces-55427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E3B0A445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2725A4D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398E2D9EDC;
	Fri, 18 Jul 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fIxbJj3H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fEjEpl/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94629824B;
	Fri, 18 Jul 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842183; cv=fail; b=f9zLtl8br6p+nol7tDFhWCdLvfY86HscW6df+9bLFf0RIdt69itfN9J2P4AXjE4EYkgekD0aZE5DtYUOQBlN7pmPBdV9VvW3e7B6o0BlwgHnsfrDrHlJELQpfTfIFEnR9QBF3YJrjRLHsTEO00Fx2QLS9a44diTJoUGanx53rWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842183; c=relaxed/simple;
	bh=s83BWpmYZP71Ar+ROGlihiLMTVTlH6qV8NOUT2cCHzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tTvp0mGFoQvnHVEOPpSrtrMuEp/x0VTSgeeV1twboRsgiQmKFcVH6tg0vryphQk0N6BwMyofre2GHwIXLiFJEi7gj0GGJtt3xYpCYA69vpYskcqf5igwyZ+Gqq2ofWYnq3NA3pXU309w6vlLcFxwtx2QPA9Nii1O9N52E3d8GtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fIxbJj3H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fEjEpl/r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fhJt016059;
	Fri, 18 Jul 2025 12:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PGPRNwN4pu3PXQ5swL
	S0gVK8l1QEymD2y97Ry48GJDU=; b=fIxbJj3HkxtGVqK8J0uOiT1ZATdNXPH6XN
	PXxHKMSfP3bdXDodFPONvVq4tAU1KIkgLrGgiDDfElGy8LvAC+JKeWp/prMQK660
	r+BEuQFgDHLttz/jhiZQEe6KCU+c9UOX3Dd+CEMh9+k8bPNldWzKiIHdsN1Sn89V
	E/ngnROiIyKvxWO4yCqL1Njhsy1Kx4Kphbc+fiPrC3m91+6w0+41Cco4mzDI/kew
	Psr7t0LqbfYFSLg1MVBcd3RWkPWNpVKVlrS+Fjwp5VbQldeGDdL1XNxSmcTbu+zP
	xeg2okjt6+IEpPxiyKlw+EuS1N0jOIMEk/dgsJUJNQxoTFA5lDJg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g523p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:35:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAbmFl023944;
	Fri, 18 Jul 2025 12:35:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dyj7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8d1l6St6MzD8+jGkECAVVihM+oEIma/hZRSPwbQPNtlJ40CmtSSSQEKCEyBAiOlQQxmWVfMOvv2+BGILSFXs6GGdv4S37kv4iMfdJQ/eQUPN6GehAXamVet1TohwOJj4IlpKPcki5mrXI5uQ4G9XzURaOJeILGybF5iqtrC9NTMc/bp+MzNUYBGQkSh2SOywYMuUcywDcMzfa67LTvtjDzF0UYZ+YUop6NLsNZfCmu5K9eH+suwO/0z8BXPO5mrVmQjynt3WzOGqAGJR77tc4d19RTf/o5oSR+T38IQ8TwIQA9JsO55FUmxEQyZfM9KTvAKUzytgPFmza5Wg3gGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGPRNwN4pu3PXQ5swLS0gVK8l1QEymD2y97Ry48GJDU=;
 b=D4uxWMFFi5qWFuF1SF2+XvSdfvC5t8xDustCg3enyeI1FmPbY+pD9V53sLGP1vUTaD5hajlMU1okW32MXWDK8sMISDN2QtnfOHZCdeOQAa9C/cZdMjYsqWImTTeaMvFL9MJTnKnRoDUUoTh5mAr9QqnjdWWmjmFRqoug+eSz3mgSa8qEVUEAQMrdR/FGI9czkVXXCfTtrL+iZM6/oh6H4k30iOKygivaolM6hGnYmNotJYYM70fRfKkum8LTE2x/kSANjBLApA7ZwCENp6XGBtAW2XeXZtMIZT2O/LsGlQRC1tijblK726H9gxxe3lGVGyDZlDBAtrqD7xViP8I9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGPRNwN4pu3PXQ5swLS0gVK8l1QEymD2y97Ry48GJDU=;
 b=fEjEpl/rIHcl1P9ebtVRAyb+fP/Gdbn7Xn4wd+wRNcWmQZ0Mi+o991PLTqwjkMPDuziNS2YpJLumkYmJ240Cn/V23Yjb8Cd2zsoILS8ZRGJKn8/r62wL7FlO4SiwQwkDkRt5LTll6N2TRhns9tmbMloKjsjwvoHOdZhpa7ePFbg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 12:35:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:35:37 +0000
Date: Fri, 18 Jul 2025 13:35:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <ca28318f-290e-4d03-b2fe-a6ff00b9a9e6@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-8-david@redhat.com>
 <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
 <d62fd5c9-6ee1-466f-850b-97046b14ebff@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62fd5c9-6ee1-466f-850b-97046b14ebff@redhat.com>
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fc4514-08a1-494b-9d8a-08ddc5f798e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Goxxv8ECYTlE+30Y/PcTHQ7TxYkv+dRzdgoAIYwCbY+LabZOoUDYkbITp+5p?=
 =?us-ascii?Q?sznu0ItdoSBp3gZs45fA7tcVhV45ON+dq7W5c4td4zF9EZBIdjT9FNER7f90?=
 =?us-ascii?Q?UmLM/wn42MRb8Q/9l7jh6wXxP9dijkAeTm5rZzOwqZPxFSSzOHtCbKPyVOFy?=
 =?us-ascii?Q?qxv/xZbnKBoGn+kHzfSoKxJj5FkH8yTfKjRliqvgg6RbPkLtv9633XbaHv+4?=
 =?us-ascii?Q?6qUwVyH/9p2nuA61MNDLpHO8KLB2HSEdb+zwnTP81wKJ+92eLxrFTb5TXcdT?=
 =?us-ascii?Q?wo3LlHD9lE2xhPb+IZsoFLbahRbEszato1EsUDUhjT7wg/FAOEjMy/H0cQZy?=
 =?us-ascii?Q?CV3OofmcfYjs3boFPTNdDf6t0G30oVACigwEEIIDZ1Kk5PMnm0aJfrGO7s9a?=
 =?us-ascii?Q?CZgTgXHjoyaEVQt/3bBPdaec/MgwwOI+sd6rcyUOIqZjIX8mww+EW3OCurwR?=
 =?us-ascii?Q?U6JuJkkd41Xh5qGsuNGhNBT4pNjcE3iio8bCRqz4re8NCawYiOXB1bF0W49G?=
 =?us-ascii?Q?Vr+ar7eh/jkd4MwYdViVuG/CcGxyMqMVW+UX/Kd1vqaVZXtMVKfsQtRMA3vJ?=
 =?us-ascii?Q?S9riEj/4dyOv1u0a5oJm1h5yaG6PJddqByZp6/i99Fuhy1zQyr+D4sxWhzve?=
 =?us-ascii?Q?380XIT/oqMoyXiy7uMkP41UbW0ibhE14QviioJNNE1U3QKEsRBrnpwRYGoQN?=
 =?us-ascii?Q?2uMlA/rSwhUNkFlntiJj7fDK4x/U97BPVuMwkOuisVsk3SpdyAi8HiUBLXpa?=
 =?us-ascii?Q?Yu0hTBNaPplocOPAacVbtGNnZWbh+6kaJv5lovy5yISAtSr2wQyitNkreZSi?=
 =?us-ascii?Q?IZ6iBXHAViRYSVfMnOnZiylSEBGkcXEIf0VdNeP1KAfWlQqgGCOWQqA/X87b?=
 =?us-ascii?Q?iXLIBk9vg5djrAgE4rHWT+lETICASU4ofnNeFewLwfZkvAyLA9fezfapvHnN?=
 =?us-ascii?Q?7bgG8Mwwz2M1TcWtugoIno+jM5Wi+INsRlaXlAIEozYTcSCrWLFyX3oE3sw1?=
 =?us-ascii?Q?Nr3WnnCaxOtqVuDHKzfJ0NnYTMs8zYy6NkrBKEbXvFgm3Goalvh06iuk3BIZ?=
 =?us-ascii?Q?vZLMaZdCC4BJiXzJmubuk/8I6v9cFovpTHfC2PLIt8ChwjXxBC8BACSTOIpM?=
 =?us-ascii?Q?HP3VoG4Xhn5xzkMtX0cjJhh0JbitqcTnnc3kXQYGuamb3FkAdp4XjGUSzM/I?=
 =?us-ascii?Q?2yEeUy4hsBT471X2g13TYn9IeXhUsK9I8tqQzXhbLkIC/HrYZ9ZSJXekiO6z?=
 =?us-ascii?Q?fITxUKIfzSWWmkQEM+N+K0x/Ij4FRneGF9lw7a3FrcOnGLdK/tyrJvBPn2Bn?=
 =?us-ascii?Q?ZGBeW0sQWAgwHLPe+9Nl6/pI4WArRLCxO0yd3edE8ymgzx1lBosIGq8fX/JT?=
 =?us-ascii?Q?sjUClA7Pwm2/J3cWcah0/wjXJJ7CocJpvbgzEfPK9rEaV6htpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHe1Xk+LQF9JBU5o+8kiwbqrZw138YgsdW+3ILo86+7VOF1hzvKT+5hZNGT8?=
 =?us-ascii?Q?3tOTsCPPcxdwLCTVZQSSaEDgOf1tyCg0oWvgT6+Z0husY/u+GEcN70FpOwGZ?=
 =?us-ascii?Q?UbhloIaBIVuhIbK1KyC4WdNp33jQWQhMB/NvIYyt5YP4WyDCxjxVD1M3xcJK?=
 =?us-ascii?Q?cQwMhvDkakUw/nsgCR/Sb0MSsxhpZGlOwK5QZUoPwJjOltta/yAZIWoBnqJt?=
 =?us-ascii?Q?sYbmhACPLEGIhmdBPjVVDc2+7lPzlMFhZ7DsIKryKy/B8DDJ1Gd2jL4qvqva?=
 =?us-ascii?Q?T8kUamNXddk22U8lzahCwGNlnfdhh/9tDM84RW9/2CzdruJ3SjOX7dhAfvv8?=
 =?us-ascii?Q?IOHgFIDTk0CJqzLnsKmQUitlB+8RysaiHnRsXxPY4bGklACQsL8IocYs33ZE?=
 =?us-ascii?Q?hko3f2d5ry8i7cFrtxZaqqvNBRBiX3xe6ymQ8q5J+O09xyQtB8TRutNGYtDV?=
 =?us-ascii?Q?F0ei+4JtBkrvkjATZdIpwRc1jvuInBIC1kO0VxOLd8SNkdbTJ9nldVgSCvgj?=
 =?us-ascii?Q?cYL1MbD7dET1jiPScLfVxERWhEd0nwENxhFcl3FNyxcn0CCV0WgWn+STaXu5?=
 =?us-ascii?Q?LGX9Ab6lzIQQwHPAjqd6iBwfPW/M9r2i8UvNRS3PdH4rNoY6IO2rh7vQJjtf?=
 =?us-ascii?Q?Vaa6X02dkmDbyataUyrDKJpK62BiAnCHClnOhgnF7bX+MjyXq4NEzUrNjQ+O?=
 =?us-ascii?Q?xupru/7ePM27UTz+B7XdeKSvh/3nOfzlnv1kWjkHIESVwyWXAhIZb+r+5Y7M?=
 =?us-ascii?Q?wqr85xtZrDS2+HxXpLqQzUySA+WPwBhg6OB4xqcxJYSH4apQiXLKRgLVgzop?=
 =?us-ascii?Q?chG9Z58EWSeO4JMJpN1bETmPCO36RyzWTVTV38AyXtwMVstPxq4CffJOyItA?=
 =?us-ascii?Q?V86R1eRZnwLsGFPla+dHSn0mIJNAOKAenVddszrTzlB3Q4Ysg4bLdKTUHSJq?=
 =?us-ascii?Q?sKaymdAkFcm2NDw54Jxs695fAolbAqJ8TrvuoRIIpbeIG8iOjy4f4CFY8yNU?=
 =?us-ascii?Q?w793Y9Q+RySsr77PldeM49rv3VmXs8YIjNqTbPEkw0p59cOt8YJw2EelVCNi?=
 =?us-ascii?Q?m9sxRXiuHVOi20lVawM3ghb24THib52E1Gp+1TU1lbwKuX3Cugx8dTrgEGW/?=
 =?us-ascii?Q?vPwXxINy+DowHOW+syQZrpu0cqR/zMLAdf05wsag5LQHRHj6iyARX0Qxtbq1?=
 =?us-ascii?Q?ryzcv6d6iniTZDDxsrq9Yq9P2HGeF12FbO5gLWqRw8qtSy+G0f2bk0kbVXIL?=
 =?us-ascii?Q?xlWn9hU7hwQyYUzy52yzNo9o4S8Op54oEfozNRS4iUPN3hp4w65nZrP4ksbt?=
 =?us-ascii?Q?0k9Q+NYYF67gbIFyNxaU2G/mlo6+ncReiwQKC1ZWtvDrho1fWrp8MWeo4zh3?=
 =?us-ascii?Q?F2KBQMMaPSTc+Y6dgHsi9oL+MHC3ih0/Ufz1hLfzZ95vbrNcai39UmrZVilY?=
 =?us-ascii?Q?VU0y/EPIo0nI6tU0jK76Ffku9IBflsJWeV022wZv/Gat6mR31mcrspFWLHE0?=
 =?us-ascii?Q?f3pD7MqEe9kZVVmK2ZThiIbQDHUwNmwztEr8VqlnDnYhQlZ0fgb3yJbNMmw5?=
 =?us-ascii?Q?v9ZxCMrcevS9VbeLPgIFgeCkdgFYtIjMTi7vZdJj7CYKWb32yMue6vCD8ZEo?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QVI+PstvtL+OLlvttIikm5XcgRJ2Bz7lyYJ3CwGmObvhJIQxnIFb8YIrKFDBXWTediIxEhVj4qP+nHdSWufSSUSdCE4MBER4KC6kRDGJtIdsEzkuaA5CmmyCCvqUxCvRfCSWKAprbhw/yIrp6KFRT1B61gx7/Fy0urMcYlGc2RqiGK4KzdX3243k+Qat631RBsw/7e0GD4qxLnSQ1nN8P/xsWccif4lhkGGa9m4nVM2K4ZqI/tycsOACoFqdICXbPPAZpWWV4Q62M8PaFA55BScXNbCt9P3/xLlXwG8jo1BdpCxBi1Y6KJZTN3LgbI6xWKpBKs8C07TyUzhkNokwI7n0rX+NJtialJR4QNFtsRbneY2EpRiRiuNr+L5pWzXBo0Q42Nt1rfrYCPFzuI4buqVbPJWPIgI04ISy24PYmNGIxBh+Rybj0ZEyudQOXomjxNzzvxozCMi93xbDw9POm2HdkMbsGyzhjpAPOgXs2o1mu4wuQm+UN48jWuNgTFuzfpg+qReIdDAMqV7MzAPSwKdQhwgIGx4K5Zj1mW5sLUmHI/v4pA2wHt/JzfmScY5L9dAVzM82cHeVpeDySzjk4LfsnvUkfBzJnZujOAWe+yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fc4514-08a1-494b-9d8a-08ddc5f798e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:35:37.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTAhcizpKpJQsE/CaGJ/oexvrEphDlymendqMo9Uk1cfGYY+6OBjSEUaB125nLbs2CE1+i+YZ0Vw2lVKH7C6vpU8iLgU14/HGer79mXftEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180096
X-Proofpoint-ORIG-GUID: 1K3701reWHgTFpg5lycL87RUnutklGTX
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687a3f9d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=rNIe8tJn33Rh4yoerTAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1K3701reWHgTFpg5lycL87RUnutklGTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NiBTYWx0ZWRfXwYDAPaGwDVFW vMOtC2NZQQSYGHFG/0J2CKnyVcDFurPb3YRfildhDK26+lCL/EaIIChHI3eBlPSg+dTbViBEqKm jgkeYoH5WATqfRYblV0nupGnbn0yp1Ki5XNqNcM4jjDeEt6aW2+meofIeEbV3frws1U9QZwkOos
 z2Nlz9cxfin8/9o+eYjjE4dJTD7kNYGC9qnpb5fd/AC/l8sE49yK9qX2VVkDzAWxvkpriWYveNf 5SwbP156Bwamyi46zQVuIOsVO3IuBO/3z5+TiHkCUx3SXfFVWQnCj3Y5LN6gLeoeycvw3H6oezF kmUk+CxuMUjqUDswQH5jtWEjfxWcmNzYFK/rog0F0b9Q4CjMtpmiYVZB9n+Pn6iWO2Ax+o1Hvkh
 2oa6on6aMLx2+xE4hFpKCr1HpoDRDbQHnq0X3gUShTuFeOcUSzv+nlCZ+W1mNrsanPfLoQ5W

On Thu, Jul 17, 2025 at 10:12:37PM +0200, David Hildenbrand wrote:
> > >
> > > -/*
> > > - * vm_normal_page -- This function gets the "struct page" associated with a pte.
> > > +/**
> > > + * vm_normal_page_pfn() - Get the "struct page" associated with a PFN in a
> > > + *			  non-special page table entry.
> >
> > This is a bit nebulous/confusing, I mean you'll get PTE entries with PTE special
> > bit that'll have a PFN but just no struct page/folio to look at, or should not
> > be touched.
> >
> > So the _pfn() bit doesn't really properly describe what it does.
> >
> > I wonder if it'd be better to just separate out the special handler, have
> > that return a boolean indicating special of either form, and then separate
> > other shared code separately from that?
>
> Let me think about that; I played with various approaches and this was the
> best I was come up with before running in circles.

Thanks

>
> >
> > > + * @vma: The VMA mapping the @pfn.
> > > + * @addr: The address where the @pfn is mapped.
> > > + * @pfn: The PFN.
> > > + * @entry: The page table entry value for error reporting purposes.
> > >    *
> > >    * "Special" mappings do not wish to be associated with a "struct page" (either
> > >    * it doesn't exist, or it exists but they don't want to touch it). In this
> > > @@ -603,10 +608,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
> > >    * (such as GUP) can still identify these mappings and work with the
> > >    * underlying "struct page".
> > >    *
> > > - * There are 2 broad cases. Firstly, an architecture may define a pte_special()
> > > - * pte bit, in which case this function is trivial. Secondly, an architecture
> > > - * may not have a spare pte bit, which requires a more complicated scheme,
> > > - * described below.
> > > + * There are 2 broad cases. Firstly, an architecture may define a "special"
> > > + * page table entry bit (e.g., pte_special()), in which case this function is
> > > + * trivial. Secondly, an architecture may not have a spare page table
> > > + * entry bit, which requires a more complicated scheme, described below.
> >
> > Strikes me this bit of the comment should be with vm_normal_page(). As this
> > implies the 2 broad cases are handled here and this isn't the case.
>
> Well, pragmatism. Splitting up the doc doesn't make sense. Having it at
> vm_normal_page() doesn't make sense.
>
> I'm sure the educated reader will be able to make sense of it :P
>
> But I'm happy to hear suggestions on how to do it differently :)

Right yeah.

I feel like having separate 'special' handling for each case as separate
functions, each with their own specific explanation would work.

But I don't want to hold up the series _too_ much on this, generally I just
find the _pfn thing confusing.

I mean the implementation is a total pain anyway...

I feel like we could even have separate special handling functions like

#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL

/*
 * < description of pte special special page >
 *
 * If returns true, then pagep set to NULL or, if a page can be found, that
 * page.
 *
 */
static struct bool is_special_page(struct vm_area_struct *vma, unsigned long addr,
		pte_t pte, struct page **pagep)
{
	unsigned long pfn = pte_pfn(pte);

	if (likely(!pte_special(pte))) {
		if (pfn <= highest_memmap_pfn)
			return false;

		goto bad;
	}

	if (vma->vm_ops && vma->vm_ops->find_special_page) {
		*pagep = vma->vm_ops->find_special_page(vma, addr);
		return true;
	} else if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)) {
		goto special;
	}

	if (is_zero_pfn(pfn))
		goto special;

	/* If we reach here something's gone wrong. */

bad:
	print_bad_pte(vma, addr, pte, NULL);
special:
	*pagep = NULL;
	return true;
}
#else
/*
 * < description for not-pte special special page >
 */
static struct bool is_special_page(struct vm_area_struct *vma, unsigned long addr,
		pte_t pte, struct page **pagep)
{
	unsigned long pfn = pte_pfn(pte);

	if (is_zero_pfn(pfn))
		goto special;

	if (vma->vm_flags & VM_MIXEDMAP) {
		if (!pfn_valid(pfn) || is_zero_pfn(pfn))
			goto special;
	} else if (vma->vm_flags & VM_PFNMAP) {
		unsigned long off;

		off = (addr - vma->vm_start) >> PAGE_SHIFT;
		if (pfn == vma->vm_pgoff + off)
			goto special;
		/* Hell's bells we allow CoW !arch_has_pte_special of PFN pages! help! */
		if (!is_cow_mapping(vma->vm_flags))
			goto special;
	}

	if (pfn > highest_memmap_pfn) {
		print_bad_pte(vma, addr, pte, NULL);
		goto special;
	}

	return false;
special:
	*pagep = NULL;
	return true;
}

#endif

And then obviously invoke as makes sense... This is rough and untested,
just to give a sense :>)

>
> >
> > >    *
> > >    * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
> > >    * special mapping (even if there are underlying and valid "struct pages").
> > > @@ -639,15 +644,72 @@ static void print_bad_page_map(struct vm_area_struct *vma,
> > >    * don't have to follow the strict linearity rule of PFNMAP mappings in
> > >    * order to support COWable mappings.
> > >    *
> > > + * This function is not expected to be called for obviously special mappings:
> > > + * when the page table entry has the "special" bit set.
> >
> > Hmm this is is a bit weird though, saying "obviously" special, because you're
> > handling "special" mappings here, but only for architectures that don't specify
> > the PTE special bit.
> >
> > So it makes it quite nebulous what constitutes 'obviously' here, really you mean
> > pte_special().
>
> Yes, I can clarify that.

Thanks!

>
> >
> > > + *
> > > + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> > > + *	   NULL if this is a "special" mapping.
> > > + */
> > > +static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
> > > +		unsigned long addr, unsigned long pfn, unsigned long long entry)
> > > +{
> > > +	/*
> > > +	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
> > > +	 * (incl. shared zero folios) are marked accordingly and are handled
> > > +	 * by the caller.
> > > +	 */
> > > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
> > > +		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
> > > +			if (vma->vm_flags & VM_MIXEDMAP) {
> > > +				/* If it has a "struct page", it's "normal". */
> > > +				if (!pfn_valid(pfn))
> > > +					return NULL;
> > > +			} else {
> > > +				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
> > > +
> > > +				/* Only CoW'ed anon folios are "normal". */
> > > +				if (pfn == vma->vm_pgoff + off)
> > > +					return NULL;
> > > +				if (!is_cow_mapping(vma->vm_flags))
> > > +					return NULL;
> > > +			}
> > > +		}
> > > +
> > > +		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
> >
> > This handles zero/zero huge page handling for non-pte_special() case
> > only. I wonder if we even need to bother having these marked special
> > generally since you can just check the PFN every time anyway.
>
> Well, that makes (a) pte_special() a bit weird -- not set for some special
> pages and (b) requires additional runtime checks for the case we all really
> care about -- pte_special().
>
> So I don't think we should change that.

OK, best to be consistent in setting for special pages.

>
> [...]
>
> > >
> > > +/**
> > > + * vm_normal_folio() - Get the "struct folio" associated with a PTE
> > > + * @vma: The VMA mapping the @pte.
> > > + * @addr: The address where the @pte is mapped.
> > > + * @pte: The PTE.
> > > + *
> > > + * Get the "struct folio" associated with a PTE. See vm_normal_page_pfn()
> > > + * for details.
> > > + *
> > > + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
> > > + *	   NULL if this is a "special" mapping.
> > > + */
> >
> > Nice to add a comment, but again feels weird to have the whole explanation in
> > vm_normal_page_pfn() but then to invoke vm_normal_page()..
>
> You want people to do pointer chasing to find what they are looking for? :)

Yes.

Only joking :P

Hopefully the ideas mentioned above clarify things... a bit maybe... :>)

>
> --
> Cheers,
>
> David / dhildenb
>

