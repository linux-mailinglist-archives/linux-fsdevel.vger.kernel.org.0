Return-Path: <linux-fsdevel+bounces-49849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA68AC4174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2827AB164
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D19C214A97;
	Mon, 26 May 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kr7s0N2g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OsjPnPt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3882101A0;
	Mon, 26 May 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269899; cv=fail; b=Z2K5w9DmtvwQPYLiqBSXDTjD6kQmRVLBHAa0dddcLpn2W/BX3uOJ0yg6z969f2VrYZJi4GMIBXME5jOdmxkTJFRndrpagUtsedumY3Fgn3ipDKFpsK8aYatLVBDLZXxKLfcOmogHIvc7WPJKHlNS6zxEf0kOIUIKdBiu3Y2kbo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269899; c=relaxed/simple;
	bh=Lyqqylk+yWTfukNhaXZymngZr5ZI7S7JGabkMD4Uj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUT557I9ZoLu+aR7GxR7vk1KV3YDm5axM343vYQe3MuJEWiB++BGm8g1bXvccAphlcqNgW9djZS54j3GUM6sZ3FKOMPAPVzr3oOnsWW6+MOKY61ICn07u6Aa8dChqckX/XuC4m4EH+cUNiepUjMrkq+vOrDFkAirR1zIG9aGayk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kr7s0N2g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OsjPnPt3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8tv35005527;
	Mon, 26 May 2025 14:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zjYoH7wmeRmJcAIoAD
	BSxPoGuXjM1OG65tjYrSGDmkc=; b=kr7s0N2gmeL3xitB8dsxUsqdDs2i8CXe9L
	jD3cPopegiAOHM+Shp3zaUMDxxTqPML0sHS6e4uJuBY+ucL8eA3whrvV5KtYP9F9
	MJyqsC6Qeo3Ny0rOiePy7kNSLzl1o0arDsYFqTef18TDXCFvaSGPNloSyNbtv5ef
	xEPvMOJTqxgV2lrT4LwZDaIP0w5u6KF1DlqFdkIHe0D+lb6JWRcyWgKvBdW5r3X0
	cbresIV73MbrGpCNSbRWhuBoQOJpJZC8kYc7gx2YJ8tV2g3jbV7B1UaBy5rkB034
	0TrY7iGhBAo1TXzfh3Xv2OtV0BDATMly63RzCFnZ9g1nxZS70fwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykskbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:31:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDOr0v021061;
	Mon, 26 May 2025 14:31:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jebsn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNR0OeA6oWL8+myVxAmGUZ7ZgwyTKLpyYrMMkRNKhaEj/lwnVi7WSe/H/5QcTojFl0eKz+bNOulEiDScUPD4vTpmA7Fw2F82ZEERcVPCyDai8XKfenRKicKhlq2Ji1iNOCL1obaWNdZkyVxiNo3hJAIV5BZACbs0Xnv2PRbX6u13PZnTShGb9jE7FamWXOJ8Y06A083GDN7pQTNfPZgmjxDmLlO4a8jEZEqHPi+Yr91LlE7YKqMXeJikQv3/bodPk794dCZ8YwialV4osl/Y9FXCLvHXPMzR7d/5wBvF/LzJjbrqJoN6CnqZTSpFiXb4DjGiy6gQVynWocwlmVV9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjYoH7wmeRmJcAIoADBSxPoGuXjM1OG65tjYrSGDmkc=;
 b=AsoNGdGebm4u7ce7Qmyr3MKwC4q2FV1jVKNRz3FlZ9xrTa2YuoM4Jnm/siZfhAG6mOanM1dZMYqmk3S1QZV78ccNi8SEVwL8zcytZ7OsPukdj0v+zj2A04ddEbA3HdXJsDJz7vS7rgyerfB6uNn31jz3hltEWPB+hKhxD+suvJ87NmImRPqpKkcQ+Pc5fK3p5s4CPHCIoVbF+v6028nUeS0m1wRoj9SzbW97AuON6RKv6yrbyY+pPlHi8rvDY4YE63QEM5ZPIIr23QTVj2ygb8ND/hSeSWfm9I+l6DJE9Cf8NW7CgLGOXcOgmYcI9ukx6qD591ZhhbOvV7y32uEIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjYoH7wmeRmJcAIoADBSxPoGuXjM1OG65tjYrSGDmkc=;
 b=OsjPnPt3cP/oF6fh2kLhXdnS9hZCaA8dp8dT56G2zyV+MczXZqBrXC7f6S9cottlsggJ4Wzo5uzOAF/BA0Sd3juFt/i7YWJXY7wbfzz0XeMyz/S+Ok91DYZEJ+o1McUFA2/Sf2luK+On2T4yIzfk04aS5ghK8d2Be7y58cXzqe4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Mon, 26 May
 2025 14:31:14 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 14:31:14 +0000
Date: Mon, 26 May 2025 10:31:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2 1/4] mm: ksm: have KSM VMA checks not require a VMA
 pointer
Message-ID: <yr23sllpmca4hy6vsrtiwan2npl2bqkrpwhfdbfeaaf7rctsay@dpashpl5cw57>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <b7f41a3d8a8538d73610ace3e85f92bb20f8eb42.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f41a3d8a8538d73610ace3e85f92bb20f8eb42.1747844463.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ade1d4-3e48-4248-6c38-08dd9c61f7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A87SfVuXt3/1kZRoe9XqpNsIHbSGqRNinzpY1FNmD9MUtBfssBR9FAMWWB7t?=
 =?us-ascii?Q?+tJ36ToyMYOeEU8z/MIaLe3eORPQsMmRES8/otgNq6IOLextsJGmg67ldu9Y?=
 =?us-ascii?Q?BCYOEf2xHKZO+wAkae1Opu72Ufm8YweSSjCShz5M0ePQOf3mc/PzxhwmYBqf?=
 =?us-ascii?Q?sUkAI/70Ky8k/HpGQYaVf74Y3jgFt7pNEmbmRfRZnLn3eB1U3iBRdS+Jlljy?=
 =?us-ascii?Q?HYcVfynxE5L2XCvMxvhFHW6Q3yRFzv8UHTnHjql9EbLAf3OcRvy9NwSWqSs2?=
 =?us-ascii?Q?GnN+qR57kuLsVSj/u/Re0PLc1JkRU2eZSdNfl6D+LT8ckyd+PgBFIAvXwkRv?=
 =?us-ascii?Q?nD1w0MkMUE0GzobsXU//+ueksoF5zMG0FIPcjEjh7vxKOhI7Wgw4FU7zHyjs?=
 =?us-ascii?Q?JR/Kchk06khkhI4NbyPP1I7RlZ0l/JY+VeK77BtL9wXBnm+ForgArPVfzlvI?=
 =?us-ascii?Q?a8KuKgNlhg5d5Jjxl4CmeK1YxBhuOdzXVkeBVxISk9Y5+rAGot21b3iSkzCv?=
 =?us-ascii?Q?X6GYwbfeED+RK0Bv5FLRQPTCWZ5fcRXmkrJXnV6WM7MU4KdZyHKhj+iYTawj?=
 =?us-ascii?Q?zFHCk5tjHO4nYc9CgMKTDMCULjUMz5BqoxtvGH+StVFo9K7AleYlhWlxXmGK?=
 =?us-ascii?Q?wzM/0SffnJo3TQlWVmVQlkGlY+F5gZ3Kw9WfuR9wxU9LhEjbz5qXPzrkqP3p?=
 =?us-ascii?Q?xKmQlDjl+EcBL9O8yvcoKMtsTLkapQn78ioerhDi3nMk3wWmm1h/E051CZxw?=
 =?us-ascii?Q?mISrpVZZrDkNnt7nwT53ZZxIAsbrAwfMXzcYiqE9DDGVUF4UAtCGV5GVw6w+?=
 =?us-ascii?Q?ngj943DhmSFBTbP/doyvZXFS++CU6goJiY+1KEVrfl2vR+D3gTwMSzhRbfVL?=
 =?us-ascii?Q?OueZfbmN/tKIjsghgmk3gk9jpyyVUnykwxnhWdRu0TnRhYTpJqMA2yo323eJ?=
 =?us-ascii?Q?yqYR+XG4N6diMBuy/AFELVKRuH9NnxUHTmFsQcw56BkTfujCsQzgJBqQr5P9?=
 =?us-ascii?Q?O+4imG5DmWbF36vvoQCGXdS2w6MPfwNR1dlT5Vxzl9sUxAztXKwLAW1w7AdI?=
 =?us-ascii?Q?bLfyfVR78dFoqEXvgV+zFo+yMK7K/EhaO3wv150PVkhO9tfTWnAERleqgmn6?=
 =?us-ascii?Q?mYJBDnH/oxgspXQJmmhJB3W9naWmCQooRdXHJpnwOH+k9x/lqFSlzAB+sZL4?=
 =?us-ascii?Q?fHhUHPXRAhMoKT22Pg8Ien6bAGeXlHg+PQTKP6U4g0MCgqNIFkZQfVHr1Kow?=
 =?us-ascii?Q?oN/xQQq3OLelRIoFF67SHCxJlKWRO5oysJdsNh5L0cfvrIT0bVY71XRl23pj?=
 =?us-ascii?Q?h1LdiMD83lwHmNBO64EpmBtKeW7ZWNhaG3xDjLzuIY9c7+uWEHXyESGpuhjt?=
 =?us-ascii?Q?QU1J23FPfuSpYH+MCAjwq5kU49TUfBvdJEyU7DiDqumzI+6R0nVbDU8z3dGv?=
 =?us-ascii?Q?mHjE4VgVzS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvEQbSrRR0cr2DEYZFUdytZBgrs8YhmV4C+bif4aQSa6sll4JzZixU7m9Gu+?=
 =?us-ascii?Q?M/6540nTPeRa/fn0ddxiBzkb7s1sgpjFgBZALMxbQq19uO5xbb77XsLvKQ5h?=
 =?us-ascii?Q?NEJCObqpxPmEIjHWhHIfwZaQd5Kl025Xg4uQLcSL/ey30/1mtuqbBi89DaRD?=
 =?us-ascii?Q?SLhk6/CXNLiFABwo8QJ0gFXMmLtua9MFpAc4o+701K5y1RkjI78Ugvka+AHI?=
 =?us-ascii?Q?4XFlZfoHXPnucYmzt2Hj1KbnYaJEHcJVOGNheBveFQ2TQufSO6kZ9qJRZYXt?=
 =?us-ascii?Q?fFoDCHHtxG78Addc1cEyDlK2D/Kq0erE1S3/N8uL1yYajSLcUH+4b9OSyB5B?=
 =?us-ascii?Q?rPBauK+2nI9+GBpLOnJ2fT2yNgp9zkN1OCEVnzlFvqcK3IkGMz7jqnsO8dsm?=
 =?us-ascii?Q?rJTp8S6w8QKMLKWdTa3ym5ar7IO3XY9D7v9IPRcr0bFnMlHUHX9RVUGecf6k?=
 =?us-ascii?Q?pZUW7jjREJQyjuEYk66cMLD7636HdtORObfmjAPFjSgvMjsA9LY4ANuIFQn0?=
 =?us-ascii?Q?/aZmfkG/qmK7qQBP3lFgIWa40jHlGg6B+icZfMB0KgGQjs1KBHA7AUvO+jPk?=
 =?us-ascii?Q?xDws6/Hi0FqtKQEFUk0eE02XG6qk28jx7l+lQhhB0yv6bxNhGZ+L95kO/Upw?=
 =?us-ascii?Q?fq/5pSYChhYYXQRiK/7pBxBSGMQLn6WJQThZhYHeUT+pMvox8Url0NPyQkke?=
 =?us-ascii?Q?3rsuG3RCdfuM7OGC3PPdzfBQ7bKBMud0EcoGtp/947hXARhY21kLRtpmmnG7?=
 =?us-ascii?Q?QX0+WJ6hjumKfZeWulH8NVZrxyFteZp7rNTdwbsuLsqgPdy2uUW8jsEtx6j2?=
 =?us-ascii?Q?wRkFv9PlviF+0+Z6J9AyMtd3uRBRfY0BhU6xESK2gutdUYKFSVOVhurE3xb5?=
 =?us-ascii?Q?KuCgUqK7fthwZPL3Fvyh7MvcAyPGgtVp4Kb06gyQ5TJpK6LDulFWzVwoU+PQ?=
 =?us-ascii?Q?UtXOYrhSfHxrt3R1zFMxKUPMOAvvpP1aE6VbinXSsfQJs0F/eXBzK7q0a+FI?=
 =?us-ascii?Q?xK53Pg/tjtth5G6Mi2bl5sW/njObwiTkhXAD5GFHf1waqas7jdOBozhAlqLO?=
 =?us-ascii?Q?wS35dmdupAWR8qq8+w3V0pbS5I83UXXebF7AfSMCLA2RFOwgym5bXGWv9c1y?=
 =?us-ascii?Q?RHeqRHeTAJRJn+iab9iIHg6HdlXaCz7Oen1Vhq0PBimJWGX9Adgozl16Wcey?=
 =?us-ascii?Q?4SqkOGw0N9hXxJzy6Hg/9dm7fnDRVYuEGEEHR1U1d51+pQCkSROl9cUfXl52?=
 =?us-ascii?Q?zbNL3SyTH/2eSImmoG8UYpS2KuO1YuoDoDndnpAk1vObbNpTNn9vTsVbB+v4?=
 =?us-ascii?Q?+T1cjlO1w7KIxRDDTZ6ghGJeLUfNMC8nchxmydBQZGc6J4+AMSUaEDnw/SZ/?=
 =?us-ascii?Q?cYSaP5pBVEq4EwlsSeLBDKTF069oIRDjILGZyfClYKOouGPp5FG7LeRHkJ97?=
 =?us-ascii?Q?FtM4Xmr6jqe9Fhg2fHTuD9UtInWqnUDUvyMvoFSxBa3p0JwAPF+cHcrfX3cn?=
 =?us-ascii?Q?Iwbw9Gpo3hS3mljL4wJcDNRX67D6mWAhWm0dHum1ucPB9UZuvd6f5Rd6xycg?=
 =?us-ascii?Q?t+OVYk37x+hrSGdTvOGdZS617hGt3UgqVfovb1YC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9rfEf1ak9JktphSZ6b3XtLtx4ZASUPbJumezTJDHdP41PZW0hGTu3pvljSFViE2h75AhQrD5ITmwzQfBOyikE5wUH6rpOYeb0ongHGIAf9eajKR9FBq3EnQt/fgw4/udXqD7Lz8kMOnn3L074ev/6t13yQD8pdgUBRS6N2Mr43q5HNsNyvd83IDsUemUnzfUaxbj6tqVz/mXNLF4ypwOxz3yvrdFr7hg6I82m4Aiu0W9RwHuQIUGNfRsYz647qskP5FTynRZpmpR+laU3y8sHf7SHv+aQKRGX89oHk4SOpGh8AJQdHUV24LR473g54FIYsFhSbdBRGtC4Rkyepy2ywLdu/bgjEeqKJHscnzi4JU2XavqXZ9I6ZB59TXo2zNlJ6z/TiVLTiGHCMEKY2vg40KJjvXWJfQZIHdxv8uA290yphWvKw0t+wh0Iyud9+x9jkImCgiKI2qXIHuM38tpSxSKGdLjuPLBoT82xwrzj0TkMVwGQRXuSnqymZvrJV1bsyhPksmf+zEn2T8ftbDLbX37GdWm1eYy5bRbwUcU4pasySWhW1Y3wGQEqJ+xnJ4T+sdOab3BWNvbfuGyiSu8hsB0uG7wV+6VnQobrqVaybY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ade1d4-3e48-4248-6c38-08dd9c61f7b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:31:13.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NQ7UeKblTiCICFVID/oD0GqhUiAJG63pHLrrM1WMPq4+3+UAUhKvoSjJBWVnLpyfqSQnkH2alU68usmA5eyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260123
X-Proofpoint-GUID: 8ML_WKF6Hu_NfFhCYGpBAq9FJxf9MHy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyMyBTYWx0ZWRfX4v9zXla3k5Mi GYOemKa2o0I4EoiJ1Psxq4ULLr+1rF0KpqwOXZ5mu6GvE0kMcnVt+VLr/431OkYs9MERyX6g8xw /67LVBwn0OXGb9zg1RMe7q2od0ESA/WHOnrE1XZDj18T5UjuzzFE52O2xZByzW/RkLe3WRci6q3
 /1ni+IDuiUEuJWCb36zZskcTfJ0utdQy6pzzf20STG+fWC9veOXZngBL7rrMnVGOyFI9RTHQB5A r7rlNs0fprOkrlc1iD0g3J0Yq7Mt3UInslZGWrgU5NmzvvsbsLVDDnfzzWlGA+YwwNlNnk3bS15 d0gr45gwwvzetozHsfHo7wlI9ky7no3wji2OwdrlcziDsn7vozyB0zPCnH6Enl9w4pyW+J3ddPx
 mlAL2oShGdO0toQWK1GinxP6V8OWGXw8mO+OYR4YBlS/o8uiJ3XrgA43IYwxZZ6RAyJCPptd
X-Proofpoint-ORIG-GUID: 8ML_WKF6Hu_NfFhCYGpBAq9FJxf9MHy7
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68347b36 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=r8WlCrXwO7bBcKSW3SQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250521 14:20]:
> In subsequent commits we are going to determine KSM eligibility prior to a
> VMA being constructed, at which point we will of course not yet have access
> to a VMA pointer.
> 
> It is trivial to boil down the check logic to be parameterised on
> mm_struct, file and VMA flags, so do so.
> 
> As a part of this change, additionally expose and use file_is_dax() to
> determine whether a file is being mapped under a DAX inode.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/fs.h |  7 ++++++-
>  mm/ksm.c           | 32 ++++++++++++++++++++------------
>  2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 09c8495dacdb..e1397e2b55ea 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3691,9 +3691,14 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
>  
>  extern int file_update_time(struct file *file);
>  
> +static inline bool file_is_dax(const struct file *file)
> +{
> +	return file && IS_DAX(file->f_mapping->host);
> +}
> +
>  static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
> -	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> +	return file_is_dax(vma->vm_file);
>  }
>  
>  static inline bool vma_is_fsdax(struct vm_area_struct *vma)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8583fb91ef13..08d486f188ff 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -677,28 +677,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>  	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>  }
>  
> -static bool vma_ksm_compatible(struct vm_area_struct *vma)
> +static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>  {
> -	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
> -			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
> -			     VM_MIXEDMAP| VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> +			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> +			VM_MIXEDMAP | VM_DROPPABLE))
>  		return false;		/* just ignore the advice */
>  
> -	if (vma_is_dax(vma))
> +	if (file_is_dax(file))
>  		return false;
>  
>  #ifdef VM_SAO
> -	if (vma->vm_flags & VM_SAO)
> +	if (vm_flags & VM_SAO)
>  		return false;
>  #endif
>  #ifdef VM_SPARC_ADI
> -	if (vma->vm_flags & VM_SPARC_ADI)
> +	if (vm_flags & VM_SPARC_ADI)
>  		return false;
>  #endif
>  
>  	return true;
>  }
>  
> +static bool vma_ksm_compatible(struct vm_area_struct *vma)
> +{
> +	return ksm_compatible(vma->vm_file, vma->vm_flags);
> +}
> +
>  static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>  		unsigned long addr)
>  {
> @@ -2696,14 +2701,17 @@ static int ksm_scan_thread(void *nothing)
>  	return 0;
>  }
>  
> -static void __ksm_add_vma(struct vm_area_struct *vma)
> +static bool __ksm_should_add_vma(const struct file *file, vm_flags_t vm_flags)
>  {
> -	unsigned long vm_flags = vma->vm_flags;
> -
>  	if (vm_flags & VM_MERGEABLE)
> -		return;
> +		return false;
> +
> +	return ksm_compatible(file, vm_flags);
> +}
>  
> -	if (vma_ksm_compatible(vma))
> +static void __ksm_add_vma(struct vm_area_struct *vma)
> +{
> +	if (__ksm_should_add_vma(vma->vm_file, vma->vm_flags))
>  		vm_flags_set(vma, VM_MERGEABLE);
>  }
>  
> -- 
> 2.49.0
> 

