Return-Path: <linux-fsdevel+bounces-68073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E618C53573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95574624619
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8DF4F1;
	Wed, 12 Nov 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ncEr8Ywh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="igFPrUJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8539269811;
	Wed, 12 Nov 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961615; cv=fail; b=tPTZmJnWPcZhejD9Q07Q27rTf6aUTT33I3H+Go17QqVoXsEMWEWypvvXdUuu2Mc+8rSRqd8H6D6xgnQMEr1TjqXIVo2hzcCTh9Xl6tn/BiPRJDRSXTl2MbHN45/2sRvoa4gh1tM/I4krP3MpFLoDP/jsHuw3PjID2KT5E8tRACA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961615; c=relaxed/simple;
	bh=97rSpIvUBiAaU4+2zqqpnDbGpdovwHtIA3IC/9o6ZUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQeQOtfgkWhL2/Y1b7rzfa8pBkVDFEHsGdDUUmQQHP8K/aVdtg2TLI/SZ/5sUt8LoJo2r0FQ5YaWtmDrd/iwP20Obm9Qph+6fDVU3GO1pdy7QW3I+Dax+IaDD5W+1zYEwhwD1fhBabg71gLn5gK/s/7HMa4O5CtWjE1iR77K/z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ncEr8Ywh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=igFPrUJB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFSRwd020574;
	Wed, 12 Nov 2025 15:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lEZuC53QDsqzFgVIFn
	EOr8fxyzZvswm87kGa9AzEq0g=; b=ncEr8YwhbAvjw94rHJOJCBk4BaCo4fvPBB
	s5+oLxpCq1+QyEzsvVC3wtAWFDgA1b7GngTKwY7Fhzh/MI9Dftk/KImI+F8Z6nZ6
	zS6bOr/M4OameatSdbc+wOW57o14s/KCO/IvrjOZ3j5WymqGnift/O3Jv+E6MkVE
	n+fxE9VSjw2PgOzwasM8IBAVp3e9Ho1ACYn+G8bvHa0KORTbm2eFq46giOL4WCMK
	aaf2ZHqtxBmVThNwqYopEumIlBQpV4PBmM+TqTtHPXsBKht6YFoK/NE41AzdfB/a
	T+gGt9hw6ac197JwHfsXzT/v4aS9utuB5B94o4RitPjwOV6OjmHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acum886nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4V7018657;
	Wed, 12 Nov 2025 15:32:21 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaaudku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARPMzQISFMGnBW/d2qNxk3PZhwLrL0tBMxjKy1BkJ1U1LjzUN6bRHYVVgEx7wcJPRTawiNw1r9A0p9wl+7LqmCWk0ndh9bxtM+o4YwtjKEomvQGrcmhhEaakc4eJQTpagoEjiMzZ+5GfdGZv2bn1cUdJX5KOggH7FLj5SYue6LP0UJ/y6InJW5c3oiLAAWXalUvA+6Ux0z9ltk3hFs7cXFi93vlHn3GG9JBxQNRZXDKSwEs9C/5jznkrtbFLtMMkOH+acL0uty+/sRZW5m/4Gw1hGLU1ZmVIVknQCLIiuJj4fUfSGenx9V9XsOG/YNdoeo/PDzI5lDdxyBNcJOWNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEZuC53QDsqzFgVIFnEOr8fxyzZvswm87kGa9AzEq0g=;
 b=CQJQKXkyfImTKRe4gaIYEJa7pwNvT1xXyhIAiz9KI3NUCJoJBJJj5waUyc8J05k/NybB/CoFDmcTAyeRcjLXQru5ij5x6Z5Q30pZ4g789Kze/UNifBEb62ez2DQBI/6N0pr8d0rZhZcFTyVpzz2zDZsOfQEB4TE1bUKls2k+t7zsKfnKVCIswCJjRAYgqPShWtAybn2lyGm0JgCXMc85OMwRlqOm8gp0c0hO418KhOay0K9ilnQkj9COdjIUKYhcdo+T4PZ3ra4yywKefePgI5chNBbhyD8pcKn/vTtnPTGLGDZCt6x6YcZezTJ4E5jTv5u1D3jjxyg0FfyFIfUP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEZuC53QDsqzFgVIFnEOr8fxyzZvswm87kGa9AzEq0g=;
 b=igFPrUJBZyxWNR8KTT0yl5wGqOVOpARYcHCkK+MEHWM9oRTl6Njy4xF3FtJH9fZbNOJBWjxPFZJZkL5QdjoUCjBig1B/XpOIfCpuc5kA1/y2iAGUf+nTJJKSftXmhLyg/XZAwY6WARPfd+pEinJ8m+cadSNpDg63bbnjM2hIfXM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:32:16 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:32:16 +0000
Date: Wed, 12 Nov 2025 15:32:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <68ef211d-8aaf-4b13-888a-d00dfcebfef4@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 630c1422-8eba-427c-46c8-08de2200a8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IC8ZfZ0YBKoZxK8NmydlmT8RTvuGkB9q+C6sEsIj06IL1pIjVj3FaapQ+EfT?=
 =?us-ascii?Q?jJaORq0fmSrs4nsXUIyQEn4mV+h0+gu3BTF8Ci9XSAfiYnKHHpcbTq2CDotA?=
 =?us-ascii?Q?Kr2qHaUTuEKhO5r78akfBx3+bWSk5H2Vpx/DOKml+3+jmMq4lcvbGu4tR1F+?=
 =?us-ascii?Q?p7QOh0r5kvH8lQrMbTCMf1BZPjZ4XNHeR5yv4T+thHWZmIMxNfMMf7oMhJVN?=
 =?us-ascii?Q?bX1fita7SJpOyfTaQT6lavfF7mfXfSnI9U0I4GKlu8uVXI6hYnUTlDrJDU2v?=
 =?us-ascii?Q?wV6vXrZixzawItZgzNx60yZ2w56a3jL9cDNAVn3Ou2yrNnvQdeDBhFpetpBR?=
 =?us-ascii?Q?pmz4olITesEL8FfED6UhMWrkXi/QAUK/LPOp9mi9D7iruR01OLYTyrmj/oNN?=
 =?us-ascii?Q?jLKv+BUIwxJabHmPlHw0IKK9lAcqHy5xVn7aX7lYrOg5Hlz45Mg7wcCMp4WB?=
 =?us-ascii?Q?3nd99Vo7cEXCWBIPi0MBHK1CXbcJR80ntd0ZYwKOelFy/f2z52FCiBpI2T1k?=
 =?us-ascii?Q?HNHEyCRFzMVLKeOwTgds7bslEWNCtoRMuLNJCMcVlkQeQ/1Ox3rIXaBfz+Yn?=
 =?us-ascii?Q?2cKUTbPgqO32CaJcWvJwHfwstg1xqOs0ZeNDraZ1OKDz7/e5yuIz3WlRe4HS?=
 =?us-ascii?Q?ZJWkgaueFeN5ZAmSgny8CwqEE8i5G/G4i0JKm+z0hiSb8uNu3iZYL1DLBkAE?=
 =?us-ascii?Q?OZJw6wpwun5BB03xGhCjPrRqlVJL+/nuC+jSIb5P/S0z/jBvKeDlsOymy9WR?=
 =?us-ascii?Q?HGRF1r3uuj9O+rS3cDC6Tqdl4oSR+0HFUTRXLXSVeeuiiqxTRYDJKTFf4RUn?=
 =?us-ascii?Q?dRaWM5iW6RDLLcwZbihiFbKC5RFATQE7aDU/c5S5HNMfzPKEKpIcbOmanbrU?=
 =?us-ascii?Q?vg6EJ1oHSuj+7Oo7aTQUABm3a75U2eLHnZ9DU5lI2tgUv8WCL8NLYGZqj+6a?=
 =?us-ascii?Q?P+xHlpbDrwyDlWKE7NoRZjgfw8JIoPf1c4R9GDUPTHkTvr7lx6oa3/UbuCRA?=
 =?us-ascii?Q?4bxIVkeK5HgnN1ZxJv9hQj5mrSW5GCHlqAbwW5cbTYiLuk9bTHmWC/vddUn7?=
 =?us-ascii?Q?2CnAMwnB2YxiT+YXzglZ3YkAg1FGW/SSw7hpw6/FXMkU+kI8HG4XLZrqz44M?=
 =?us-ascii?Q?PdWt6uOReXdqg2aMLu36k+gBdUG6/vMt3idF8rMY90JVtoUmoMrEstQydmCf?=
 =?us-ascii?Q?y+Nr4rC9nsi4CDR/ixYKn82l/lGxVW/pHmiKtdnbEeZXOYlOBMyMZV6kL1Ii?=
 =?us-ascii?Q?1Ac/u6WQ8hU4rDeMGcB5USpBPb1gnbWgkz/GsD0rXuJZxXXKkAJDVt1S2O2q?=
 =?us-ascii?Q?a9hlyQiuxYmTo6Q0WSPu1ivTWALkFRfW6k8UaqD8cKbEkTwLQd2TseIWVV/M?=
 =?us-ascii?Q?CsgpOypFnlFE/Aw7N9eU1nPDA8DFahbfVjeVJ5UallW0S5LZMPpZATl4kI2m?=
 =?us-ascii?Q?59p4STs2IcJEXxamIa+SH/lhxKbw6BSj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqtZYme+IRsQHN7nCsiak0Tq2gBW6VE1nntN85sy6PGRDWWq6sW3rnE7NIhH?=
 =?us-ascii?Q?NyYCqEinpYV2wtKe3gBdMWidVJV2qqAALHSNijpEJkJHwTzFmDIn7JphvX7B?=
 =?us-ascii?Q?Rs/3osBd/6QRCITjMxvny1/NDHPy2tDGBL7pSvBC4WVcJIDsCSHvzbHcS3Hy?=
 =?us-ascii?Q?EDn/Oc8fdQt2QWBtoroG/GyWkteN0k9rNlu7ddhSB7lM0/hFJ4MZZsjc+UiJ?=
 =?us-ascii?Q?E0RV380e5TtgYOuNTIgBvAOfaHb0execqqsVbxK1735Qx2TaF5KDAZEPFhHO?=
 =?us-ascii?Q?IBXP++OqwexQyw+xbdt5t9kfcCkBXl7KPHz2UWzq+07Orws0STLQUfmTbmg6?=
 =?us-ascii?Q?eaxouGAzUsOP3mmhn0W2Afr7mbVJA1xKS5Tak0z8wEdV7lDfnCZCcxBU+YQh?=
 =?us-ascii?Q?oerqwYwgg9H4TcGpbgP3o+aM59opmBrup9F+K/W2iKgJu3+pnoSeXGIZXwTN?=
 =?us-ascii?Q?f0U0v4Gls/4if6GikFJGhfxw3GfdjaGtPaVc3pwJsQL0vahhVubP1xOoUXIq?=
 =?us-ascii?Q?GMGdQIIqgVaxsxg2UIeIQ+Uol8WlRMLX9Uj+kJH9Cp0hgIFZWwnZKjuJqzcp?=
 =?us-ascii?Q?lc77GBmuwwYvxkSPx9Dcl8JNW6FqlQ5sFqJXRXtY83sum9RNXkXMNX4NGVNp?=
 =?us-ascii?Q?J9Vc6NsKFXihGzgmf4bG83NoKEDRGv0ggn1RB35SJxvrQNfFuJil9A31JIXI?=
 =?us-ascii?Q?tu6y6qv1XVEPzC4rsd2A1JtPtcIhpfRL5BnMzTyT5hoIx6m4uH4ZCNwEvGP6?=
 =?us-ascii?Q?5UMof7+g9u7IfJrMnshEDb5x50hMDqeBA2FhZheyzo8D/FudIv5FH4lBasX+?=
 =?us-ascii?Q?ICxmjIi8g398xeStaL01D6/ox/raxXCYLojXfABemyQdDUq0mbkG2MePiQrK?=
 =?us-ascii?Q?qU1cuSeQSpDkr+UDc+o4hou9958MacgCGuL7s/L1IRpoGcD/a6R6msREQvDh?=
 =?us-ascii?Q?LDCg5GC1Y0+sLqfAd3Jli8Nv4hahdRm65/JLnoPciQPXHwGMg7tPzMvGQxXN?=
 =?us-ascii?Q?nnl7q7mlbUXyg/ZAuAsWLc+1Lg6fvnUZcAbvQjG5kv2qPWlzH7UsYFAiMYyZ?=
 =?us-ascii?Q?vfkTXCQ89YdAOch7dy2ZCw6ATUytU0BP3lr0gAtllwpcBrgKUEPSC3g3fsx4?=
 =?us-ascii?Q?0BTMx1ZnFZ9guQqSIOEVtcNVD7rotpMLtgd5xYOLV6Lnuf+gdS+n1uXoNSDo?=
 =?us-ascii?Q?/obWWn6IIMf7CIQ+7w/UXDeunR9y4Dsl7OIXGZHPlOwb/YpJ932TxgdCxW0A?=
 =?us-ascii?Q?4WQRuPmg/QC84dV2ubf4nbFgCyFkHs9YCLdXEXVdiYsNtyH2pfu5cFjsgMiP?=
 =?us-ascii?Q?hFYbovc8NUwDiCbWh9ogI2YLnudX9yv/s7u8x4pwTLt+Y1iYi7ZQDk+0MJRE?=
 =?us-ascii?Q?zyT+NFr3tYOAeDHeR6cLDkL/vvAUuFaiHdycnGs46MCoHZ4GJ43ITxic1cs+?=
 =?us-ascii?Q?EgOttfTNyppLN6LL3sf+4sDeVHAMz/FBIB1LnqsfYUM20Mw7J1znekzPrOrg?=
 =?us-ascii?Q?TVPaoAvrtOSy/JIX9eXceZ8wPOfs/X7wksJ5R8evSZ/dLUkUd7uPg2Fede1/?=
 =?us-ascii?Q?QrmVdqnStiz44yrMhuGsYxJPjo7zGUWc8ax80rVT80bmo1M0JP1IiKeJEh60?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nT4ZS68uPZ9UtI7yuPyqtcgoBv2FPa3PlRLgu//hMfHLuGciCToXFwb3JboFdv9WtvTlcJG7rfcdXYl0G3KDBkKMgBZa6mYy/PuqVCEzDCAoBBcpP5pbudBfciV+3f5WtSwAP6KxuxMkIqc5NlKUKLXukJBctF322o+Q6bOM/GE4iWFJfHvW+09dcEgfqDrCCbkwfRf9uHukMbGWHVyavU8rrZ8qSYnB+0npZ5vqPEyMLLdeJ+rjuKYkSbJmKmm/cWYc+Q3L0Fopy//KQKROHxdSArOxaBPIGo5mF94y5vOUn0lP7SCpbWO5btgD+tiJLMFRE6RYT00JlapGgustjBPuhzcLQoXOnSHJb9UW/280KI90kWmS5HQT/ibV1Uu5A1c4zhQ1kowvAajlwKWaPmpy+IymAR8sY4WDd35xVpdERrO5YkWN9VgLtuAb1NUSlSPsb7xd8Q4C3hKC0FGC2/ME0TPJR0D+aeYQgOwDZEJdL0exGUzDmV9N+tfoZTP7uzTp87xHurc3CJG0TuG7tsPR4JavEvAAg+lkv9e1rRy/lG4b8cYYEUQEpagS1vUzQuaaBgAq4Rd3MzqjdOz4WUv/VHPVGDrLki4P7PzEARk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630c1422-8eba-427c-46c8-08de2200a8b1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:32:15.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m3yxH1OTFtZtzwwYyeK1qE7+moQyAp/E5IJN2nGRAa80copGDrpv/FFslr3HczmGdT0A//Q4AiwDF5EN3b4dtWgUlaqURemcN7PyCvZ+uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=836 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExMyBTYWx0ZWRfXwOKXJ7ybjf7F
 5Uy3hRZVVpsxrxDgAYFdM8C8Zr9N6BYtneLqeos3ZKJIfmrTHhj37nFioD6T4GNXWPIDfQjisKq
 HKQ9BycPBOMwP7JUrvxR7sq1wds7v29apaaGsGb5FS/fmJqNmfO117rnlHHiXd7H3Ar9Ob2dkVi
 WQffCY7i7FDD00kzbfPAau8XEJ1R8ATTszwHr6ifArTB6jOoeIV3TMoSxxln3yFlesWAYQ/S3m/
 TFnOIJS4+pa4khix1BWGNtUGDfblk2VtrYWBBX3VdDZkERE3RC5LuRFyddlmaXPgZEOwRg56SXF
 DZu6AysYp08uibkU+ZWCt992NgLglqvShSnLhVz/plbduvubTSr1MSFV35kjiZPO2COqSP2PmC6
 MXaGXakYyUFpdsmeCygUH3IsZwp+fQ==
X-Proofpoint-ORIG-GUID: 1TFDxFApOZY0ycJAFvkbB77qMu6R7YOX
X-Authority-Analysis: v=2.4 cv=KNhXzVFo c=1 sm=1 tr=0 ts=6914a886 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fAjwdPMav6DNvfFMvhQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1TFDxFApOZY0ycJAFvkbB77qMu6R7YOX

Hi Andrew,

Could we replace:

On Mon, Nov 10, 2025 at 10:21:20PM +0000, Lorenzo Stoakes wrote:
> The kernel maintains leaf page table entries which contain either:
>
> - Nothing ('none' entries)
> - Present entries (that is stuff the hardware can navigate without fault)
> - Everything else that will cause a fault which the kernel handles

With:

The kernel maintains leaf page table entries which contain either:

 - Nothing ('none' entries)
 - Present entries*
 - Everything else that will cause a fault which the kernel handles

* Present entries are either entries the hardware can navigate without page
  fault or special cases like NUMA hint protnone or PMD with cleared
  present bit which contain hardware-valid entries modulo the present bit.


Thanks, Lorenzo

