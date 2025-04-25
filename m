Return-Path: <linux-fsdevel+bounces-47343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAAA9C517
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15D83B3631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234A218858;
	Fri, 25 Apr 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eg6CPiSd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tlf679q1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2505202C5C;
	Fri, 25 Apr 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576343; cv=fail; b=KcgV2Z1oeSEZEcdz1llsoIguMhzZXFe0hHMYyZWxm+Bi2TpPOyO0H4iLCpb03LVqtjN9Ebp5jPmZLgHPt4HG89ppzz5qw88DNe0M41JQAnGLbW5docDnoX2iMeTeq3uYQhnC1+plCp2cCKWAk6FlvOtU8K7s+p8YT0an6YkWbtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576343; c=relaxed/simple;
	bh=/UEkCzO+QRX3ipXOIPfjsQdO/iLenXAJYsts8Uv79uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQQqKenxT0peZaRlEn+H/pl7KY+8y96gT+8amOYfSgv+OAOMCDncml32FQCPp6/9QjsenpOLLop+yptgsp9WvtuZg4IDnjrN4Dzy9CjUxuubpe8/uP0YjH8l1KdhsA5Zv2mIxR5zqBYiFuO46lIREvRaSCf9ysPGXHqOxIdzc8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eg6CPiSd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tlf679q1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PACYn5029046;
	Fri, 25 Apr 2025 10:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/UEkCzO+QRX3ipXOIP
	fjsQdO/iLenXAJYsts8Uv79uc=; b=Eg6CPiSd2DlstMpceU38D00QusgHCaBX7f
	+IorGrjcQn8Vh1a8QGYi1YMbMd7ycDjj8fQbpQwyDWlguwzUqeS+m3uICLbdjDSi
	pzR4TiKgx8VUML6c+0BXv7phnE8xmVOu7gjS/7ld+ce/zg2FXVUGTnm+gOR+CJu+
	DD9EAOW/lujO/8Vffw77WpA3LPhe+pvZqmHmde3irh4poXu30l5YnpDaVe6j2rSI
	hyjaNQU6P9RLJmRI8U1fFmdPDYLBDhghPISvP4/d1lt47rGM8enQrAndqeDobHxJ
	Mktk7IJgX8ERh05tNG9E4BivoEifxcpc9Fe2yHZSbG9LblE9wTLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688e58086-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:18:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PADMOX013811;
	Fri, 25 Apr 2025 10:18:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxredmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPQUBcl2ZALl2QMuoVdRabUnQDy1TRU06P7UrCtA6Gem87uCBvIZkoIdz5T7oItWUxHO76CBX8JJZM4+0BUMMYSiW4hqImHRkVml6gXSrf4O/M7mT3WKf50DsPkvpz16HlQJdeT8SQkNS3nP181n5YKlmsydzoeVeM7Lak+eSCL4IeJyHdieoApilpYrtFonMuLO201YBVcEqKhORCWwpn8FWMhvjn/JHsYJ7JJW95pIjkmiD3ychoo30pffcqz3i3c3Sopy+ajRF4O3Ud6OigYG50d3h7C0gGGJTUkH4Sozw2fRUMvHBBY/njIYkfd7ECos75q8+Xz2MrOv8WdAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UEkCzO+QRX3ipXOIPfjsQdO/iLenXAJYsts8Uv79uc=;
 b=OKPLJy+egrnuKRNrNun0yux/UA5rNH87NhuF+5N5IDsIE3Nn9vEQ0qRk4Pv8h3bKR57ADMKIVoG6PcxupwdYOVpg/ETybq+iP41r6t1X8TcYfbFXJEXo/NWk/0BSI2XGia5aONbn74LUSw2ex4dC+VjwvoErnk2nLiVZF+oe0MJOS8RqRemAqQPqolUTXwk6FBMhAjAg6w/9AcTamKCqLlr/IVh/+2eL1WnSqB+j+anpmxur41aBhQsSQB+Lh7Afjz/bMf+kYv9svw5DL7wkHpYqiaGHHA4z1dlBXLgUjRZlrA7Zjvk8k+6XSQc+K4fJQWAwMd6sUdyegMLymgI3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UEkCzO+QRX3ipXOIPfjsQdO/iLenXAJYsts8Uv79uc=;
 b=tlf679q17bnWCoWx0Agw0wVicAopNmt7NmroUMr4dl7ZraRhZu5XzmHwrSr8sZOMfCf0Rkbg1tLGsIIJq6Lbbb6+2FSQH7oBS0IqNk1eGblGAOa9YvWN53/CvIRy7OBwy7+3I3pf32tQmRAA1IbGAWYiwJvHpqIIDqDIqvgvmvY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:18:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:18:03 +0000
Date: Fri, 25 Apr 2025 11:18:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: move dup_mmap() to mm
Message-ID: <335502ea-6fdf-4665-bec4-9dc3c5ceb61f@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <4ee8edd6e54445b8af6077e6961543df6a639418.1745528282.git.lorenzo.stoakes@oracle.com>
 <i4g4glnafku73cfsj6yrrkkjxe2yape2eeamqkaqrw3zs7q2wq@f3oa6qkumuer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4g4glnafku73cfsj6yrrkkjxe2yape2eeamqkaqrw3zs7q2wq@f3oa6qkumuer>
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 281cd0e3-10dc-4e31-1e6e-08dd83e2769c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9m0yBvNfLlfZajcwdsl1I+2DXk0HH22VEQv5ZaIjMFzZesIZ84ZLFovW5xnp?=
 =?us-ascii?Q?WLrZrVSR04KRZsCa8vSjHJDhoRi8q+9MyrUoiF+/YNAKBZYyOy/TUQpcH9BA?=
 =?us-ascii?Q?WwzlulrKdecpyyMKJwQZr5f+qdXmKP1o4OKmQvcHCz08UwICCEe/qmbdDtlK?=
 =?us-ascii?Q?I2lveghi8RtGcgBlCJLq9kEibBLrUrYVPxwyeBLl8j0IPBPnDQGaDGc3l684?=
 =?us-ascii?Q?Ef/5XRrIiwmLrjBRrQz1CqET4Wa2nWTHMy193o+ZXOX/cX1Tu7NwM4jci5eT?=
 =?us-ascii?Q?HFPx2pTxY0JegjoWa/dz/qmxc9h5adtldoSE0NaMKz9NGyeHJcEMZ9OfI3U9?=
 =?us-ascii?Q?Jl8fXcMEhOJUlRYy7ij6ljY3KBY8i7m7Kj1UAM0UyjSVn1sRecwxZ9UEFZtq?=
 =?us-ascii?Q?rMavJ3lEB4d3F5JUPm41S7VgSeuoVJLVxC0UyYUQG7dxYMcEcPalPAEUvqQU?=
 =?us-ascii?Q?glx+bRMRIXl1eSHGLzck9TgVHSkbtUuYdbeZco4Yq78T5v1UNWwIPTDjcAN0?=
 =?us-ascii?Q?EV/TVZboT3ViN90MsGj6C6JX4U4/EH0L0iwBxdPo8JIwgAMBV+nuZ+PJQS22?=
 =?us-ascii?Q?S26XfE02893dEQxA8Ite6R9dunh9xHgCd5bc/pmBh1XxxoqwAPosqg4FFWIz?=
 =?us-ascii?Q?94KXzAArdqeBvMV61QpKVet8bVUe3nB4nfcTvmIUldlbYp3MGR+ZrvyHB6QG?=
 =?us-ascii?Q?bpUi9iyifcnr308VGQvKATrhNO/zDY4J8hqJ/zBwuF/DGryj8P/9eCB4F5ua?=
 =?us-ascii?Q?D4PYr51z4Zn76sIDOHPz8eqjZ8IqtEm2f4LR/8mV4BldaWpBH8e1QY+Q2aA0?=
 =?us-ascii?Q?Kr+gKRoLYz53e1B7LZwcFuLjWkfIk94NsY35Cfn9K9nwSuuzuy2I3iXbycLG?=
 =?us-ascii?Q?gmWdiyJHVbcbDV7f2V/GzU5/glh2jQqaUGFYpojQOaE+m2N5nHAh2ssJpwdA?=
 =?us-ascii?Q?Ub8ob1OE8OyBU1mI0PoWfG0ZrnkCdD6zK726poDSLdnYsvQWRC7sl+riyzGM?=
 =?us-ascii?Q?JlMIv7NJb5637CDWyATEkI369IHGBplqPRR0NBREi0J5lUodA2b2kxxt/SKP?=
 =?us-ascii?Q?ZKSy5ZLkYWBJO2hCwXARq46tQxF6zCgyLrATNuCK486HEWYddMG1GJWKvF11?=
 =?us-ascii?Q?WkOfm8xJfhlIZNks+/phcg777GRmKiO9/mqPY9CT+AafYtI3Q1o0TJOfiaQC?=
 =?us-ascii?Q?Ay3pSyVcn+21S3YumSKb+HlWqsCwWdP1OLdLXMnNN11MI9MQ9y71R88M5PkK?=
 =?us-ascii?Q?1sOcmJWQ8pkBRk6PQI3LUFZY1X4/3xtSZt1xt6/+yPz8IwlcnG9EErcRNCaZ?=
 =?us-ascii?Q?3gbKo2N4hrxo0X8PZmO2dHv6ky0Tm27OzJ396InbYcyjrxqedVL7fil/9prg?=
 =?us-ascii?Q?P9AQQibUVGHy1YZnJUInzZCawT7mRe/3z7fzJoW+DE/n6MJHhv/K126Mffqx?=
 =?us-ascii?Q?WGnQiNbbPlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF3Kvc1S8xVs7cb1oxfa6X5CCUWv+EpCQTAo+1BlFjY+RKNXiIhezzpTRb9P?=
 =?us-ascii?Q?27QZdNrmWuqZDp5w7uQjuMOfHV18BvTyJwStB+tz2HysJimr3+Oer2+DE3bm?=
 =?us-ascii?Q?tCi7pgA2WFenbZIw7rpZG1xLQSs5SnWKAF3dbN+Q4bHhB+nlZiygYBIs1dm7?=
 =?us-ascii?Q?IaI/eDuaO2pbcnQKvSmn1BkpJQ0TJqzbuArUPieHSr6mebHEKV8yLonpUUNN?=
 =?us-ascii?Q?kzvAbnU1dpTa+VDdVnvRU8mQWMJUvPmyl1/ETGjiCCbvWfK4nr3HUF4mMjX4?=
 =?us-ascii?Q?mWpDruZFePrT/i9qiaPyX3595mi+AS9Bh768tV1hueS3WHeTpDIEDgOn+aDS?=
 =?us-ascii?Q?wDdd441ismDiDtNMHqnTwgL5ZaeUXSRD2gwz0bZ01qkjGzr/xqM0LroZkwDe?=
 =?us-ascii?Q?4HKu3sJ50CWfO1jCCLqtn2lPXgAbiUup9vZAvAEll9nUfWvWjrd9ClAZiXgR?=
 =?us-ascii?Q?bMcPX/gAgvov1pjxwTdfRsB+j2elbp1F6zoFSVd5GDgTVxQSvd0NziB+U/E+?=
 =?us-ascii?Q?JQqgC0uu728u6xeRj3H4rvsIsS4qes1DgkjA8YNoeWTLJyfMmb9mkNXpsEMJ?=
 =?us-ascii?Q?P7ewEm5lwO8fh07BkJzCvzWZ1a4Iwed/CgidrwXb1z1TzQNiHxdDSNdiVFS6?=
 =?us-ascii?Q?Oj9LI3tfkjncHSw4kUPLp4wr2AfWdCrOcADVa7gIltn9z5bYjbZj+ord8lcb?=
 =?us-ascii?Q?k0IuSLFhebbwXsKEmoLp9aoRMfV7KBwnklPSaiYn01opRA0qConRbVk02jp+?=
 =?us-ascii?Q?OrsLuRK/PHO/eg4dhq56NR5z5Gt9H9UF7eu9BXPO4Vkw/4+7ZBxAKl0MJQbs?=
 =?us-ascii?Q?Kus8DDODOZgpTFsbKcZZUuUv8vRDGfVOK8wvqfvt31RGnUqc7S409cdDgsgf?=
 =?us-ascii?Q?rjqp3UGhDDvkQsFHRt70VYoITmKrQCiLJB99ClJeuCD//AQW1FL4aAmieDQN?=
 =?us-ascii?Q?xOabhok8VAArPYpoiCPs7TMf4Twt7bf2dxXoxE4q586iWq6tQqM5xSgnqW03?=
 =?us-ascii?Q?SvNuxBfpZY57E2hG6dxWn1ClPY4aaItVYjZWXXxJ2/ifAlEYdN2nmcxEMUkv?=
 =?us-ascii?Q?E6Kts4UY1p+VooaCpFeMOJo00v+A+sco4LmG/1KGUouvdpcsTg325C4GbQ35?=
 =?us-ascii?Q?PbV0uKN1FkSvp8T3oJB377n6jwbP3uli6V79324MEpy2iWQSV1XQHmq7J1R2?=
 =?us-ascii?Q?xnoTpdgnF5R5E9YSjUziLuetuqsMbN4XEmvaboXDaRtgHNLqmJeqKXSl8l/D?=
 =?us-ascii?Q?mTxZE6DG1my3ASOn9n6aj4OFjcGb1QNWFVg0GtnTqoV5HzCiPwaPddYY2Amm?=
 =?us-ascii?Q?Q/jWGu8vGj1FDrJRNfWD4OHyC/ccLWxf94ono0vcZt45bBEzqJVmEU5kIg8L?=
 =?us-ascii?Q?FeXpnHlPHOt+i4tiMUOjWvDrJkHtJsPLJobwnBl5xLwrSwJCfMXbcXSGszZ0?=
 =?us-ascii?Q?JCOa2Ct7G51vQubEi6rcC+D0kVrsEJs0F0mnx13QGiqPU85t8iYQoS248CkP?=
 =?us-ascii?Q?ur1uCh8JfuM6hxE/J21Q/E6HKvaphk4CTGkUpoBlcXgDHreqx9HGCPyOa8Mm?=
 =?us-ascii?Q?19UDozU/ga8VmvMP46x/3JuOiHuNSj5RpoV5Yd/EOaUNiDP/q9AElN28ActE?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QANJrCoUqY6Qib/1vi0j2avMw+mW6X0k1sazjBa0k9NX/W55MJ/dWKMGLZGURLkHvj1izW/tQn64w/ts/MTYdOmgzTRfMDK+ELCKRXPBycc1l1euSGoYJGRSQs5KqZoI/GQ/OGqkebt7BfEE78HUpBbz2k5esMMjTLqx8ChkaQ8bBAMfaQb+OXqY6O2QU4JhaYaZXVgBKz2MbNWHoPCB5OPz2KH+qtOwHSbeTwS9qALv1yqsbhxjQo62sykv78fZk0LoGofvcGrcmlERc4KyCnPJmfooDpjmP8YndFiWx0WgyLMHaggN12t9dma7N6rQLL/KEpsMM8PwUhO7W4UyxgsvfqqWZjv4CYy3FIzYvB6uwS0e7XraJ0KQK5oPgKs4gAKZ6guzlm/Rgxbz6nQpf/W50SFG53hwWjkwOzLEweK/6IsOuwUVShSJaCpdRGrAdihh/aP2Gzp6NVIvqyUGiEZmCvSZcok47zTYrZc3hriaAFQAkE43WySoYoSO9RSaClG2oqBIOYxjadH8joIp8V65uqv2JYnMXfkdb9hxipMAsYUMXZA53+XuM9B8fR5z3uxA5MaFpSPhEzdXHkdvfDRQzrmBAVxetfa+S/HaR/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281cd0e3-10dc-4e31-1e6e-08dd83e2769c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:18:03.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGF/6F8rMuJGhOLJa4iSYdb8mvFLIlTnvwZbGejPJLRWyp8pgSca0p15iJ6uHN4SYTeznh3r16KrQ6HIPW79EFWFgT4n9SwxX42xSjlS8tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250075
X-Proofpoint-GUID: BG1CAS1XkdKepnga0Sawuh45hi5dYrOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NCBTYWx0ZWRfX/cuoVzC+Kt1p 2MfF9QaqAR85qZPC2RRQrvrNh4fJ1B3E1rLZsXqmlfebUtWNObC7+c90K2VFSpySEgFhaDEMQIu 3xzPOYGybzMUocf/e6cALvfSQ3yxdSStaeh9sPJrpT1RhdbnDDfhs0uUYEOeTPibNHXH4w1b3vf
 lGJJdJf/9TWKgWvOGjxov3A7tG7WPOBkADtG96e4DsCwO1IXBE0gul6tXiuLRkZrAI3TmPAGF8j 1Ex3WNaOJmAqm7/ceRJhk4kDgE/6uVmjpx1DpuLKA6n2E0OYxJhkekYXE8icirWN30JDOry2oi1 lF5Zw/u88ZqRd2U5y2KrUhH7A9mmFcSok+BTdIMZCzg4uMd2687x/I3LNYntZVK9HFpN6bm2CgU sfYh9tue
X-Proofpoint-ORIG-GUID: BG1CAS1XkdKepnga0Sawuh45hi5dYrOi

On Fri, Apr 25, 2025 at 10:13:35AM +0100, Pedro Falcato wrote:
> On Thu, Apr 24, 2025 at 10:15:28PM +0100, Lorenzo Stoakes wrote:
> > This is a key step in our being able to abstract and isolate VMA allocation
> > and destruction logic.
> >
> > This function is the last one where vm_area_free() and vm_area_dup() are
> > directly referenced outside of mmap, so having this in mm allows us to
> > isolate these.
> >
> > We do the same for the nommu version which is substantially simpler.
> >
> > We place the declaration for dup_mmap() in mm/internal.h and have
> > kernel/fork.c import this in order to prevent improper use of this
> > functionality elsewhere in the kernel.
> >
> > While we're here, we remove the useless #ifdef CONFIG_MMU check around
> > mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> > CONFIG_MMU is set.
> >
> > Suggested-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> Have I told you how awesome you are? Thank you so much for the series!

:) Thanks! Some much-needed positivity this week :)

>
> --
> Pedro

