Return-Path: <linux-fsdevel+bounces-53388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE3AEE486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9DF7B071F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F128FFE7;
	Mon, 30 Jun 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qXr0LHHu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6n68iau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEA28C2CB;
	Mon, 30 Jun 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300821; cv=fail; b=MckUuRYxixrsxNM+Fxk5XftfPBT1iRUasq2OVvWaAwPA/zjI7fe79+emOM1wKZ/CgAjOP13qJueF1v2OGpuwc1YsL3PnX5Ja1TfZq5js2QnEFIbiwSmj0QZ2WZcuBq6LYJPqvo0+cz8zrNSG1OlzmXSvBitJMvB1MWxrleE7uwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300821; c=relaxed/simple;
	bh=WPpveK98ocEBCliDCFONxTeVFQ7a5Bk31A3qyAbNm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uNWChPd1LhEacYy1ncO3yFmMoOEM5b+PWJ6H56OmGfG//Rsi4ne23RVJA2m/+rEqyvrHP05P/HySbGv6bTuhAQW8eKeDPSm+te2FSnukoXkindE0AHMJY4cWLuW/D17W5D1RxLC49z24IcS70lbFDr4I9zXRqj1eoqooHKkz0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qXr0LHHu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6n68iau; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkrdL026520;
	Mon, 30 Jun 2025 16:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=B5jyVCsp3lqglkj91Z
	Amf59ho/RkaAeb6MqXltJ5jIw=; b=qXr0LHHu1s3ZwHNbEpnfKGc8O/TCpzqpt+
	xVWeq0AAebGyKLtq9jtmJL47uUx+FC/PUw+UhWlI77UjTbR6pABOZ+47BxHzNHTs
	fvNDuijtnPZU8V1zBpXmqmIjxyK7vPTc9t72lLmU3RUm0wyg2Hgwy1yeySvAZUnc
	+2oCzAJjurRcW44V5rFm+hG6ZkgF6egQs7SQ12Cn4iGBBG/lP6wDcDFmzQ4a4+Ms
	g6tcVgHgBGWWNXYrUdrI7bFDOqdsn9hgxNoCxzKSPJO23Opqdj0k2wagshTWRfva
	TIhNO2sLMA3UOlqFGNB6v5ERqGlvEe91Vy58nmRTpr/R6snOT6aw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfax0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:24:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFNGlP017477;
	Mon, 30 Jun 2025 16:24:52 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1dae44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT85KeV9DOQTfbDVAONvN6XqmgILbBkAbkdhKN0pqAoq1X24FyzU9y19hgKh2HtYudVjafQCyW22+Jn3W+nTG3addrbZpRHv2x+eRkSRJXc0B9gRBV3sjjsEPtHehOSpeCZCe7FzmQmOBP5Z7pNs6t/vaEIYfZclnVpwDc9iaCaZAzcM317RcffootFHLFWZYsyv7RmlBSdw1GsjArX7tNbeykVDTjT2yrIy2j1Xs/E2e+xVzrJozGmoUhRRQpnKdRPGn+jVIo1EUMbjgxfHPhUQnPCbYiFMEPeosKqQcV0Sfxzffk0zlRvHdm4f163kAKPiLKE8u4eSFc+fM/JnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5jyVCsp3lqglkj91ZAmf59ho/RkaAeb6MqXltJ5jIw=;
 b=RaX1cVrliCeyP7mMmr80yetMEaKM9/9oClPil1lzdo0lUFQsMln44183cKoOzN0tiJd4eqc0K1QhJ6zv0w5A+4zsIqr0pqYkOEn1YXrL2O5TnuaomkNPXY+EKZGc4yUwR0WD6A6Ew0bEW+/yNj1mWe5/bgncRdeNYaoE9kaFMKKvbpyylGVBiGXtXHWWyTDhV671m/9qIusDa6X/GqGKXY9FTpnVFGSazE7tOwFQWt9lzfhrMbITFo/39ghDW0K5Bo0LAegGMZF9XB7ms6nMXe7B07r8HLLQGvrCQ9zBqDSs6EwHkAr2TNhJjdYE5uGkqdAg1X1hoRoZ5Sw8Q/SpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5jyVCsp3lqglkj91ZAmf59ho/RkaAeb6MqXltJ5jIw=;
 b=p6n68iautLVJvSzEIj4gpIiQDnM71P7lTJwckEwegbxdxVEP9lg9KgEQwbkR99oF24EHFFggZvNNFga3itnocn0tJZOq4m7w9khZ/2XWs3H8o5UlkCr8wRQzCP2uJmVwGvNWuHTdwQ7mxWmSBWKvODtmA0atLARA8IntD6p8RQQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF0995E25F6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::788) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 30 Jun
 2025 16:24:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:24:46 +0000
Date: Mon, 30 Jun 2025 17:24:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Message-ID: <a014bf06-f544-4d24-8850-052f7ead738b@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-8-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-8-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0151.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF0995E25F6:EE_
X-MS-Office365-Filtering-Correlation-Id: aa812b49-5939-408e-6585-08ddb7f2a0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOO6D82a2Abpp1aaSVykAlPFiH2JAh8MXTkwC+Et+7UvjaOjiYAoXnbygoRA?=
 =?us-ascii?Q?2TxVzDYntohQqUIwHh+dsfidqTVVr7ln2vIQRp07BCrQ+RNdbUcjU+0aoDF5?=
 =?us-ascii?Q?t/CNdL8y4BDrA7eE8Rua5p5C0mnSvfqDzy8GRRmquTqXeB01JG/GSNXPRavj?=
 =?us-ascii?Q?JhKBB3/d7bp0WlyGmBAlrjWduRpT09yx9XhKlb/YnhBGE6EWwbhv96G+33rm?=
 =?us-ascii?Q?SLdIRH4L+bjNzpHNYRqkVCNzQI2WFTOfTTEaBW90GaNFfAnx0M/cqWsUx77b?=
 =?us-ascii?Q?ZRk+xMR6CDz9/w4hej2H5j8KnCgOCO+ESmS60N34hpeOfn/+bMVyOX+jbOzV?=
 =?us-ascii?Q?qCRCQbzjfFuE32UleEtdXhxoO/+UrwwK9ZCEtaE+SjMjfUCZJ8lfTxAVSWeE?=
 =?us-ascii?Q?tN1lA6mWxLu5mGWtBBFRgqvOMggi4bj+1SJ1m2r9mqj/yhl8VCifq+5ZIEB5?=
 =?us-ascii?Q?rVinIjzAemxk5X04sy6yZ95cqExi0MsTfYvcxV9Ii5h3Zsa/GqMFmHK4PUAW?=
 =?us-ascii?Q?n/o/aX3PX3b74NwHcPCG8Tai3cffzfHFe6nw5lXEGS5KFihU0nuJieNR7Dpj?=
 =?us-ascii?Q?7lNDZNLRCseC1udSag9d8Vi1MR2AtUs/i7siD+DaUPJHUyxujO3IylirHfiE?=
 =?us-ascii?Q?AbC2QXF3Q0WCz0cvd3VFm60FQpmwNdTXH+wh5v76Ww4tFAwg0tfo9xDo/HeH?=
 =?us-ascii?Q?sCS8mdNDjGlUkCROaQN1mDP8hyxRDDcwV/9qbX9UrXxdftWYc4sCQwLzCLiM?=
 =?us-ascii?Q?ZwAkwgl0RxdvHCZauRD0uNYM3tz8BEYV5VdV3F3VsxYxdx5Euy06CzOmArU0?=
 =?us-ascii?Q?ygfHNUae4JSLrztICZ8MI9jdV/0f0K4aVk1LfxC5vf6522UY1eyl2oX7yprs?=
 =?us-ascii?Q?wvWeFXP34YvBqdx5QzbeuU2M2Ej6xG9XMeK1V3DrVC+KybPOG6fot+czeZL1?=
 =?us-ascii?Q?KKx3rO+VD3F8DC4Bjf49TF1T2HHSisEw0bYLw7S+JTrVj8IIQqu3tUamfd2g?=
 =?us-ascii?Q?orX1W+JjzhoI/9fP2wto65FxcihJDDimU4nuzGQQe4z3At9jccMmkARFOH5i?=
 =?us-ascii?Q?CplsSVt/EYFb5NDbkTPeSjVln5uC8cREdXEcVWGgfDRZnLUZ/GXMyRHqW3iL?=
 =?us-ascii?Q?qitQkQmCfOqFEfUkOJ1LVVEXolU3VW6Zuj7WXkC+/SchSr1AaS9u7mkmtmqP?=
 =?us-ascii?Q?I+Tq97MPy5L3sarB/0g2dRa9SJR4EDNaQHs6rhU7NUKCcEHogIHIog17BUFF?=
 =?us-ascii?Q?SEAo4GyqnGwNG8Uv4JfSyXy3kmQNXI6OTqH0AH69eINPlETRMiTbWiijzEUE?=
 =?us-ascii?Q?aF97YVJteTYju2MiyNMhcZr5LeQ1o9e5W5ucjP8l3UqEhwTL3cOYb9Hk8mTw?=
 =?us-ascii?Q?x4e9tGUQRYuzNn4Z9EizloRk/FNzsymRFdXEHEh9IAKrQlO1XhUEMQiwRAId?=
 =?us-ascii?Q?viPuUXQtdL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMFqUos9hkblDaEutfCf7bhB1T45fVNOAxQuo3x62qtnsjxBGByUIZelG8Nm?=
 =?us-ascii?Q?Mz4JbqWTIPhUX2JNW8AC94+iJL39hWboLqVUHbStc/XU6MoHOxtjM+l6ZBH1?=
 =?us-ascii?Q?bmb6qA4wPuwOPQeKyfdt/XALOVzonnTXxH/FAX7osEkjYtlogwwb/SeK5lU8?=
 =?us-ascii?Q?XNJbu7O/GMpKNbH91CIHToDqAp6B6XWRUwHqvQvxeIbHJkFnPkKiOf2H9tr3?=
 =?us-ascii?Q?eVrWbB+F4WkHO2f+o4SjE4Yq0Imf0IApSq6YtNIUUHI0fkZG+R3VY4EuaCUN?=
 =?us-ascii?Q?VxemaJZR4M+ZF1t/CbaoAPKh4sKkzVPuywD/xrUxCs3iCgqil+xif5QlPglK?=
 =?us-ascii?Q?13xQQ5A7hTZq+DD9Sh7dc2bkkA3l6aMidCfBNQuaPN7TVd/D4MfuUcNSfME3?=
 =?us-ascii?Q?s8eRx38hoCVCe889e6c4hV7ZfE2XfkpfDHUOgoHIV8PAcmtVPwmXRxfqG5Jf?=
 =?us-ascii?Q?E0c8wszWzGLAazKT0PU0DCo1a75tZUwc6UtqQVZ2feSxjfcQcRJlzJRVhfB5?=
 =?us-ascii?Q?uxNH8QAHod1cLsxOBKo2+eLo0csSzijF+4RLHvaA+NwZf/dXA3/5Q6Q/mLo9?=
 =?us-ascii?Q?VPIl19qvDY8Yx0g0da8Xoyt/xjw6jKPKsfKNebPju9G1siD7qXjXlEJmNhUU?=
 =?us-ascii?Q?Lyv6HqhDPr3ETQRyJ247C7AdOmf93czv+ALPM+m5TAz67WGGPia8hFN+og9C?=
 =?us-ascii?Q?/41AeX/YYYJ+qg4bBuUCM/qLGDF73ojt6wN5NEKl7ET7Dc5ED+S6JHK6Zk1m?=
 =?us-ascii?Q?LOx5nAHvsPVoSOe6GboYn8ZwFt6VI7i6r2RnUsEh90WK0h+S7m7rc1KHeRoO?=
 =?us-ascii?Q?1PIUHfekbsYfTYFuvjVBb5M5jApUK88Ef3i0RuaDjpzF6uAVFOngnFwIcjpZ?=
 =?us-ascii?Q?Zkp2uDORdRo7quXJ1ydAxkNIQ1u0+m14P/DWm2WEc2xJfjK4UWwR8flSqGsg?=
 =?us-ascii?Q?QoJqeTJxjTYCHlAVg/wTcQG1C+ezWF6Az800knWePb0pGAODffTtNT1R9j/0?=
 =?us-ascii?Q?KZDFmBhkuB5Av9sukk9fKblW6dwEApcq8KV8eDp0Dsvcb3mG2POfXzG465fX?=
 =?us-ascii?Q?3X5iuKWN5YkJnJ4m4N9IFwbQ83p/zLV9ayja0mMyo5jfLqC1MBuQclGBuPWE?=
 =?us-ascii?Q?7Fr97wddbnOxXU/WTFfKZvKyHffrHTuJ4C3bT6B+1wNi/++JNYm9d+4D6w4D?=
 =?us-ascii?Q?RgKEeqLuvY3HOdMMLGvv1JA23OHqVUvW5hp7/v1day5XJt/jhFo3Eporu8lI?=
 =?us-ascii?Q?09inWocv7GnXb2yzSvfTNIjyRk0F5PPQ7hqBH3cdwSyOLrn7hk+Sa9vA5xPU?=
 =?us-ascii?Q?8OhCwDcZHJMqsqENLqu+PwHzJpmrnmcH1JhnsCsevCH6b+Xjr90UrHBxes9B?=
 =?us-ascii?Q?vhcVEGLMHZgvbCtFkSNPz9KIDLc2/iOtQHafUlHZPB2XaPIRbZjnu/Us/HvD?=
 =?us-ascii?Q?PiI1mWlbYzBCk/QbxllzLQxj2cwLM3vlF7/1oe0Bn4qT+zITtqW1dV8K0uNp?=
 =?us-ascii?Q?22wxODggWKTxOGbQ5P/W7e+dZNe3RKKe+dPXxwBzlcVfAnT+ZjzDrdV/8coL?=
 =?us-ascii?Q?wQB7d7uNNSxHuQJphK9ago8clsPU8m2tfTukqdon+xitnTWvH9ZZh/S2eaeM?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b1lPsLOIGNRkhYMaHQ0CdSDahju3Q1r+R9E4LLrdGHLvs8cKwjxrdNYD1/LvFfzEpvsNgaAY50Ss+Y9qLjhrRL/w4Ro9RAqZ/Pk5FVJHA7TD+LJwFBgtd2f+Td2sY2SDylR3Sn4P/3+kUVGG3PeNu45LgeCOjx5XBGATi2C3CkMYZte7g79XshQ0qXgo0hOUNIAonlHnc4JUOS2jB+SyYw6TMMPHVS3tp5tbL17QoH1XMLiceoqd57o83OaNlpE0u9WyL7vuRcccIHKbxaPp9/20D6BXmfTOqi2SHEGmudQku+S862lzks5DQLS6+EatPiwQWOOa+dFcR5WAAgSrR4iqtqMA+EoEHr1uhVmxolfPJStJLRzml6ogLRyHcXGB1QahBJL6aUZJ1AYZzNBrtrtD68NKMGyOrXuOo+lAiFnFuoeWt01l2+oz5zJqnPpQCoMUfEwBYgYyrxagCBpnrbLhAnXQ0nFfzSc/HVXzyo5jtRWQ4xYjtqs0i0q8YCptHQgFeoFfnAvn+8A+9qo8aEU4L538KhKptEvWuH+k7IPNjW6jCp4tgM4rT4hb1Gz+6w+C1cKSRw/uMXrpw9UEVZpDN9g0v0kxAqvAxyymF94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa812b49-5939-408e-6585-08ddb7f2a0a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:24:46.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCMsWAWfDRiuw80ngZirnYKnnp4/z5smx4BPMziSr5x9A9jRSBdOJFA+xtvmTJPgrul3XvphfGPurweuxYmAgY2bPen2uGBXwBuyEdF8ktI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0995E25F6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300135
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6862ba55 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=NdD-p6NJolvgpzY0LqwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: Y2nE-yghYdKlBAqx_uRMKQJNPxhgGdR0
X-Proofpoint-ORIG-GUID: Y2nE-yghYdKlBAqx_uRMKQJNPxhgGdR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzNCBTYWx0ZWRfX1bEmAz29MOjz 864DBNmZDrsDjbgaUNxZKYe1dBt+CC9iR9iEZUM9ij2HqksNi7Mdo1Gsggy6iTSkhbCWErqhvL6 9FeMCaxrXY2+pXikoOsduoESdJOQ0mMV3FQSZ5HF1xqHNKpc3SlxkQpcxgFd1YpIdiWz2OEQWuG
 5q3yIh40rJLF7UEjCsUAOIvpimCf88WgjF2Pl/5RK7xyjc0izbr0pouilu0/UvlKKfJ2K5Ou84w TsqX5s/3kMtXlWJBmeegXWWSoXMEM+9pgtOFY9cED0l/EuEMJTgw1KN+e7b0sTPgCDirbWQPPhN 9PJ1sLPjwtQZz7tu3bqumR7n6mbt0G7SifoAKPntY/4MWS88pVe61OWdMLV4J2jWE0X6HqGDUmZ
 FsdC/SdCwf8UiXWJsQOuz72SfhSJbi+UbXGcm0TIwNfRqngQxOlv6GZdDaHy41gJcxxfply8

On Mon, Jun 30, 2025 at 02:59:48PM +0200, David Hildenbrand wrote:
> ... and start moving back to per-page things that will absolutely not be
> folio things in the future. Add documentation and a comment that the
> remaining folio stuff (lock, refcount) will have to be reworked as well.
>
> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
> it gracefully (relevant with further changes), and convert a
> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>
> Note that we will leave anything that needs a rework (lock, refcount,
> ->lru) to be using folios for now: that perfectly highlights the
> problematic bits.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seesm reasonable to me so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/migrate.h |  4 ++--
>  mm/compaction.c         |  2 +-
>  mm/migrate.c            | 39 +++++++++++++++++++++++++++++----------
>  3 files changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index aaa2114498d6d..c0ec7422837bd 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -69,7 +69,7 @@ int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
>  		  unsigned long private, enum migrate_mode mode, int reason,
>  		  unsigned int *ret_succeeded);
>  struct folio *alloc_migration_target(struct folio *src, unsigned long private);
> -bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> +bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode);
>  bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
>
>  int migrate_huge_page_move_mapping(struct address_space *mapping,
> @@ -90,7 +90,7 @@ static inline int migrate_pages(struct list_head *l, new_folio_t new,
>  static inline struct folio *alloc_migration_target(struct folio *src,
>  		unsigned long private)
>  	{ return NULL; }
> -static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
> +static inline bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  	{ return false; }
>  static inline bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>  	{ return false; }
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3925cb61dbb8f..17455c5a4be05 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1093,7 +1093,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  					locked = NULL;
>  				}
>
> -				if (isolate_movable_page(page, mode)) {
> +				if (isolate_movable_ops_page(page, mode)) {
>  					folio = page_folio(page);
>  					goto isolate_success;
>  				}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 767f503f08758..d4b4a7eefb6bd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -51,8 +51,26 @@
>  #include "internal.h"
>  #include "swap.h"
>
> -bool isolate_movable_page(struct page *page, isolate_mode_t mode)
> +/**
> + * isolate_movable_ops_page - isolate a movable_ops page for migration
> + * @page: The page.
> + * @mode: The isolation mode.
> + *
> + * Try to isolate a movable_ops page for migration. Will fail if the page is
> + * not a movable_ops page, if the page is already isolated for migration
> + * or if the page was just was released by its owner.
> + *
> + * Once isolated, the page cannot get freed until it is either putback
> + * or migrated.
> + *
> + * Returns true if isolation succeeded, otherwise false.
> + */
> +bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  {
> +	/*
> +	 * TODO: these pages will not be folios in the future. All
> +	 * folio dependencies will have to be removed.
> +	 */
>  	struct folio *folio = folio_get_nontail_page(page);
>  	const struct movable_operations *mops;
>
> @@ -73,7 +91,7 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * we use non-atomic bitops on newly allocated page flags so
>  	 * unconditionally grabbing the lock ruins page's owner side.
>  	 */
> -	if (unlikely(!__folio_test_movable(folio)))
> +	if (unlikely(!__PageMovable(page)))
>  		goto out_putfolio;
>
>  	/*
> @@ -90,18 +108,19 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	if (unlikely(!folio_trylock(folio)))
>  		goto out_putfolio;
>
> -	if (!folio_test_movable(folio) || folio_test_isolated(folio))
> +	if (!PageMovable(page) || PageIsolated(page))

I wonder, in the wonderful future where PageXXX() always refers to a page, can
we use something less horrible than these macros?

>  		goto out_no_isolated;
>
> -	mops = folio_movable_ops(folio);
> -	VM_BUG_ON_FOLIO(!mops, folio);
> +	mops = page_movable_ops(page);
> +	if (WARN_ON_ONCE(!mops))
> +		goto out_no_isolated;
>
> -	if (!mops->isolate_page(&folio->page, mode))
> +	if (!mops->isolate_page(page, mode))
>  		goto out_no_isolated;
>
>  	/* Driver shouldn't use the isolated flag */
> -	WARN_ON_ONCE(folio_test_isolated(folio));
> -	folio_set_isolated(folio);
> +	VM_WARN_ON_ONCE_PAGE(PageIsolated(page), page);
> +	SetPageIsolated(page);
>  	folio_unlock(folio);
>
>  	return true;
> @@ -175,8 +194,8 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>  	if (lru)
>  		isolated = folio_isolate_lru(folio);
>  	else
> -		isolated = isolate_movable_page(&folio->page,
> -						ISOLATE_UNEVICTABLE);
> +		isolated = isolate_movable_ops_page(&folio->page,
> +						    ISOLATE_UNEVICTABLE);
>
>  	if (!isolated)
>  		return false;
> --
> 2.49.0
>

