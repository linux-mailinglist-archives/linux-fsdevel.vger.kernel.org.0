Return-Path: <linux-fsdevel+bounces-54530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD8B007DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0454217F895
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B552E62AB;
	Thu, 10 Jul 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BjKkcPTN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P4SoEFTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322129E0F4;
	Thu, 10 Jul 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162735; cv=fail; b=g0wUt5s/IH5zKYOVWfxHYywfHIkZws3p+0co7w7tXBt03BAkVfoXfC2/do3BaO10rZzYlXlSHASK/W0Bbphwn27QIZNVORT3W8RsSxNZFHXY6bDahEuR2bN9mYioHKkM8m4copkehGHNM168JMOsUA7CBGn3PW0Z3zIl5lgdnS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162735; c=relaxed/simple;
	bh=iXvm+GJzmq+6aRoft9XZMiELUBoxj1gUUYDdOebwrr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8/RIYF6noJ56nEr+g5weH3YEMS/lsASM3je5xJKl2o0EJQaLWZ7YE7J55onW2XStGDDYUwg2WvEO3XxQsbU0m0rCDRZ2+B5EACUm4vtzv1tqNBivxMhTyUsDxh6ws3lSPnHSS2am0sCca5HBtivumpSu+GPzRF8f4sTsuLhGUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BjKkcPTN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P4SoEFTC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFVtcR024091;
	Thu, 10 Jul 2025 15:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=; b=
	BjKkcPTNkegzN6AFoghtzz8OA2jeMYJ6OIrU8Yq1L7AmAslJJdmcyp8ky7ZmBtoh
	ayliO0rSDQQWBdw60m7s7QfZYEcw2/u1jwnAlLNigbcYQcLp2BJG8Fta9jULqgx1
	FgPoR9+QnHKTBnp8z0wHYYi3N+3nY9DD6QGJ6XzpWxzn1AING/oLKnhoBMPgPtBi
	gtRaeg/P5cUDQRXFw4VlZRDAWKgc3lmiv+K5r2qAp98oGgWGEhJOGXcd2jtNALYC
	MXoI2tN8XI6VU/c7AkLDB17TPoRg2rz4sOA2yrLj/vnzn0hIfWhKMAslDAigv/SM
	zhGpBF1JpeEX7UjcKF2vcw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tg84g1kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEkQbb013536;
	Thu, 10 Jul 2025 15:50:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd7ywb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMTwYGwpQrCQRoyE8Mw3lKW/Z0wh97itgbrelvEDJJTOhxNsqTNKW42oAM9ki7pqu9e8fCjcfmL4MkFkZ3dNJeYZEIghHJJ+lm7ujFwHg75epCYcCGRft2o6p5WMKii5Gr2FrTfSHGuXwKVuIlCv9io06XAT5kscRY+ziF2sDPWcRJLF7ao5u09EJKDK8B7vVVa7MiMU2otCKFviyiolK0dNvcelCfWvOUwPwRQElOjwnIqOpJ/S1jvMAkzePKHHcjvsb1glbXYPwdUGHsw19QaXhTzdzxzdO800t9iXAJ+vD6ILrXUuglXyAIPWLIBBQvuYcCRru0CAYB6pYOyAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=;
 b=TozWocIIOvOaFfYka/N1Gf20ipXr7D7Et6RkT1CR9XLKnMsPg3HYZuK1mZ51LNzD7HKnlmXwa96uh9OP8NXbp2PfKbrW/0TERKK5lpGiADvLeNbgY9yezVn9nlxvwU+iojVJyU1K9GE32leevkt4Yso1Ut7i7KpjsiwQXOdwdnlIF5/E/p4KAKNTsaetREPckDlPmVj6FPMbTrr29mwnOd5g9XMq0aWT3Il9HMEocWoI+deT7h9tjqTkqYp0tfNZnO3JU62OxWMfefw5HHQvWcweOnGxuXozVy9WHNgv9KOoPi0WijJe0evudwKfWxnWJpfMHd98eMZzOAGAj2zlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=;
 b=P4SoEFTC3+piISAnitVFTPY/86BWaqbbqCOcQ8KhQYbZzQKdOnh7PfH1JtWWidPzo11KHfeC9NyWG3tHrJkTsVn+3IPNtM6kY90wmooSOuMvm+nbKux1oOhgPA8hc1d2mEYDa6MipKk1YK/moatzuCf7VSyoA7k/wyXBEhJr3W0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:50:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 03/10] mm/mremap: put VMA check and prep logic into helper function
Date: Thu, 10 Jul 2025 16:50:27 +0100
Message-ID: <3048e54e92bb858493da5d9be3d5d80b1fee7325.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a40a4e1-9cf4-4c08-d9b8-08ddbfc98a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kuje++1kxfQgY3+VYU4lKyrmwKSrk4kfRdkacoNKabz84Gv18r+ClIVnw2/D?=
 =?us-ascii?Q?N5F/Hg31u5TTZryzGi2AKQmHYmiswhUNpez/6FVQBb1o7wSK5pwtcm29/7jo?=
 =?us-ascii?Q?6/1WvTKiaL6XWrKmtDs6zG+w3J+ZJvcpUtmVBJQ3x9EF5ji/NYFlMQlGrZdV?=
 =?us-ascii?Q?ShR3Sln0ybiCGY/btbkRlOXq3Ft1XZw3jz07KeUycALyez7W3ZVrVkkxc1Vk?=
 =?us-ascii?Q?JUgaoq2MSWfjNGBaIVmRIHIDOM1lxVchJkbCvVUxfGwL125vhwGMscnH59sI?=
 =?us-ascii?Q?tU6TXvqBBg8vJpL22WTY5ScpoCBFx73jXeDeqYi4n7i4nHusmTlD6Hl5KF/t?=
 =?us-ascii?Q?U583vM36SXXfKm07R3OIx2JKp9EgDsZeLTszVxDKDSJ+83KgkPs6eeWgF7h1?=
 =?us-ascii?Q?Smn8RH7MBAU1EWyOpOl9TqFu1RBzbIw7tJkXp7FojcdneLqpzgOUcQdHksIn?=
 =?us-ascii?Q?uatNWsFXVyo38FUqil7VrH046KlIE/oRR4R2/62L4C9EUTJ/NWe88qHvbrCD?=
 =?us-ascii?Q?wyuy7nBsq75BBfGaNUhmdHnjG6Cn99sTbU6T2Vw2KxEGNsNKjZ8CWkNMkvtd?=
 =?us-ascii?Q?j+LEL9YJO1PUJg5TDQ+ftuBNzz9IgbH3kuJmVR3sb5/DZCDljx3a2b/5VMjs?=
 =?us-ascii?Q?sVctU6o7/lnjCJZ3gcGjegzE0BT2WPFhxsPiq8Jb9TI0MAKxG7OOTZlK7kZG?=
 =?us-ascii?Q?B7dgSrirLJEG2dHeDF4iph1reoMj47twqnm7XARoPaMWhHh9X0PGENzSkVtR?=
 =?us-ascii?Q?6nQkT48Oz4utBtp8st6QfxcK5DI/kG8l4A3SHUXJ9EcCZ5o5j+ERyuGgkn/A?=
 =?us-ascii?Q?X4s9jFEYpT+LKSB9Y5pRWOh1NRxyuoSb2dGWp0kjk026xbZFKrzjn3KBcrzw?=
 =?us-ascii?Q?qXhltUotqOaUu2v0UgDH6nwa4vo0sTGcA17nOpu1eyjarGt/v8XiohDAi6Qj?=
 =?us-ascii?Q?Ze1JD6zDHxjKTHi7d9XDJwGHcZeYeLm13adKMkWOaSABJIU9keEScxC0kK+l?=
 =?us-ascii?Q?EHZAzu+eOXzTc8WGdZyWZSIytGMYMOaOQWGEjAjRMtM8wqHLkrvv8vKNE7ly?=
 =?us-ascii?Q?jRKZFQWOEwgDpiR9DSkuDuVNUEiPzy3i/gAY8g39YqRs2UHDBAwi1lN49zU5?=
 =?us-ascii?Q?NOCdA2XekLdBkamjoG1CE70SSc3m76XLHEmbm74MCeqFRlHqL1omuRO1nmc+?=
 =?us-ascii?Q?sQDJEiPr0TAWOoeP8axyybVQSGr1BuGCylGPLgGh4lgTj5xG1ZEBnOrzzfm4?=
 =?us-ascii?Q?z6mHj+QaMVw6E+uRko7TYHrlFUTHH+GXYCK1g+f8cVpzFC2KYgUXTZXOShUI?=
 =?us-ascii?Q?O2CA/2XZpuiAV2Zz99/AqzenBV/+5aRHUeNQNQxvVq/eNiWiI6gxQSTzkd5s?=
 =?us-ascii?Q?wB4KlP85iNArGolKhzn+ZKUM7aZbkTONZqWa+2bv8c22t3+qj03dPr1xOIMe?=
 =?us-ascii?Q?3nI7rjX4a+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfDmhcxmHimU+AxTRIWgEb9KA6dkUpcMt09d/pveiKbRN6eFyKPANi+tsSSh?=
 =?us-ascii?Q?fOMG/BN/6tkuZ6idAVa9F1Zb6ajLxF2EvndySxmittWRELDNCTxhn8FxAAFh?=
 =?us-ascii?Q?5tIpYrKlTl/yOnq6qF1UuActua7fPLiF787Qh2sIKkxa/K/zj06MP5u/zjv/?=
 =?us-ascii?Q?XU7BZ1bNBXmqzzekbIdwbLg6XPCmKs9b1RQERh6I0uWG/S7JcELxF2+WVIBM?=
 =?us-ascii?Q?vBmLMs+yt65SlwVyEeVx6GcO71Fr+ng+LS3KScNc92JguBC7A+sLJADcQ0Uk?=
 =?us-ascii?Q?TlBTaSCzkr0ptYtPK8E7QXcADdTRcc+tZNY8EXr3T2386AIhnxNNdPicVsrD?=
 =?us-ascii?Q?6QyxmlsXpQdDjo/3nWUO1kKFPeDoVoBCrHJ70fvmFPOuEniY8K9yu/IZo6p2?=
 =?us-ascii?Q?5JJ64e5kTUL9yBVgCXe0u/QRkWyQNI4riTWvi2eFpML1axuwX2ljZVe0NJkZ?=
 =?us-ascii?Q?nN/weEOpqvuKm1g1dmU+IIyMtOVya5QcHHI7w3HBv8QRD5grwM85Fh6J0Jjt?=
 =?us-ascii?Q?1q6MuvCKMXYPCFY7GoqvmHPxj2b2/YDYpRFdnwKZfThM5zsCUFK6GXS8EB12?=
 =?us-ascii?Q?99+5fYcxXVaCsF0rf0OZYqf7xaJRe9ptqUZybpK0T4kjPV2GdPKBoY++oxE4?=
 =?us-ascii?Q?dHNj8WixNuM1XSGVUgPIM+UIqqvd2CZJmthjG9gFvLC9v9u4vWVw83sb6ByN?=
 =?us-ascii?Q?utES0QVeIsQWj6jThewQQis+yw3sZR6GDYmGulmf4S3yuc3Ecz3eKbY9Etqc?=
 =?us-ascii?Q?dxzK/0KnKbq8E5TGa8oPP6pBOFjnf8GWxUm+HMhYkKsNee0SFBcgfe5PWmqd?=
 =?us-ascii?Q?w0U3AphALihIuVzYeunFtVS97ZxAS/eNgiSLA0vOI8vlc4MlnYbFX+Z9ByR0?=
 =?us-ascii?Q?60oO19BlhJBtng0wpw6Ks0GW5q2FST8yLaE4LuwbF3Tu1PCQdDaABiNTokT7?=
 =?us-ascii?Q?Zk4Q78RoJTC+Af84hyJwO6TNfTxjo0H6iFqbmngkVtZ/NHSQc2Vfg4+l7lPF?=
 =?us-ascii?Q?DWdKPcX8s1624blE5V7Tvmt4+BzT5L2mOiVKg5qVZxqciaWdljB0f26VH6YV?=
 =?us-ascii?Q?nUQTswLiKijFlgRR6Q8kJTcvSFu+SGNU2rARrJ6IRmAC3GGQDz9tWeXKPGXK?=
 =?us-ascii?Q?po92KXbeJFgfb/F/jSSfuBzR96wOwqXnhp9PF8UVJ6+d3YKhlL+Vbz5BUEiu?=
 =?us-ascii?Q?Wr2t+cL99UIDwoP6Zuw0i4TFSteoXwVpPAAxD1//94p1U95HBLVtXcGBSlDt?=
 =?us-ascii?Q?PlFkU5aG53NK9/5BJl7OsdHjmnQWTt41TuBz1w8Pmu1SosQsKv/z7CxnQlRc?=
 =?us-ascii?Q?Zae6ktNeRHSBl3GF47y4S3QVzSt+igGXm+a7fO9icElOGXL5PnJefK+O/EPU?=
 =?us-ascii?Q?BVagQh+OUH+k0vb2f5ptEM3Zfc5O13z+0kba2mnhO0/ugS0/3WMr/gfZipZt?=
 =?us-ascii?Q?SjVthFWXUtLk156mnFexs5f+V1iNOaTRrkOu2wqal8jhvBjafq7QX+S+rwgK?=
 =?us-ascii?Q?pg+8cWRgMGah6EXEukLs/L1Ibl4MXK3whO8NXBcdcCgoX9XLu7GUpr9ab8HO?=
 =?us-ascii?Q?IMBZY5nfVUGXmWt9K/HEG70ZGY33/AX6gqUXmVlZMtbm1ynrh+J5JvLv7otK?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HWenT4TBfz7vJhmZFkIzqk7mqnaUDtyPuBnuD0Z1rvH2SL5vOCYwL5c9uLiOCtoR6n0UjYJjHPGAfRgBkww63ht8adLHQeWc1Wus6MYWgv5hpo2ql8z4ry2IVlOlt609LGEOM6A3A+E2O+OVGnhY2XcrEP2mjdDOPAONpHjL38UmTMRmiKMaHXJl7ZBpHLtiGLwz7rHWTho6zQmb+1auXvGGmDvvEM3Kw40iS2J069i4lYgAXO9gMGI03BCiNXjA4z2LfqVFyamLPEb0k3ZASXGo61kMu6DJE5q2cRh6P7Oypr6deW7P/fd7fHC5E2DVLFc0fXjVed4JZ5z2aMuC5zUtD227tOX7CA5dM1u0DhhYgjMqBPJfriUiER71/ujrxicYTWNea1g4Xsqkmi1wmvxxf8z4Fh/FgGMqIinHKohisYJcvzl+wNe59USOlwdeF7HTJ0pijgVWqT1yOdR1jUxHK0+eTFVwKwYEO/QGvKscppiHrm0csLvq4ylttbTcN2v/+GiYhrsTjlcRMB9dqDiew4jbKa3dItOOBdZeryLT+BY8fxVHycISPksc7nSC1dZJo9iiw/WOWrtx8jjOqfTVFHcLpgtTqM1OIOlYBNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a40a4e1-9cf4-4c08-d9b8-08ddbfc98a18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:48.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN6Tmwp6Qj5Mv6z7H+KsPhBPcP8dTDXoFKg8z6FScGxk8/IUSBdeW3vt7m9HJMUfQxc6oLovHlxJ3vdE7rlqr8VGjkIQVDVcxJkW1HSTz8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-GUID: hRc9oMpGdTNNiDpuE20ErBx5y9xZGOp5
X-Proofpoint-ORIG-GUID: hRc9oMpGdTNNiDpuE20ErBx5y9xZGOp5
X-Authority-Analysis: v=2.4 cv=X/dSKHTe c=1 sm=1 tr=0 ts=686fe162 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iY89YN1uBm8AvMjWrUYA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX1764LF6H80pZ NrFYZUNu3HkMuMktyzvY0uMlFCH9nakrP/tos/SqnXzHYeVzVum2z3t9/PUuv6MLtWyKL16XKEy 1b3ELNweEhNMvU9gjZq4Znp7vzcB0036WH4wZPwRA8f2O74efv6uF2JumYwD4sk4fVE/eNspXw6
 YRfRwZMTNtSUB6U2kzQqpUBWyD1Ar7v4yXfwl6wRHSQAb0ieqWQ/UWUealW5shySe/rOF6SF3/C P+azNnlY5RIE88DTUWTuG8c/ypHSdH6ysyP7HF5ETb4M1WTxJtfzLOdZIVl9gomB/5uLpBBd8/z 5pgFG+W3xDvTWQOp6upDGPIqMXER+rBiT/OyNuUXyMd5I3CIMt0CT9+fioIkorId0AJ9MfRUrPU
 mi53hEkvimTtSeN12TrNtEzEsceiPd6V4xmIe4Hf6CKVB8PhRzY1MRKgiA9NNEM8ASG75yTC

Rather than lumping everything together in do_mremap(), add a new helper
function, check_prep_vma(), to do the work relating to each VMA.

This further lays groundwork for subsequent patches which will allow for
batched VMA mremap().

Additionally, if we set vrm->new_addr == vrm->addr when prepping the VMA,
this avoids us needing to do so in the expand VMA mlocked case.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a00da0288c37..d57645573e0d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1636,7 +1636,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long addr = vrm->addr;
 
 	err = remap_is_valid(vrm);
 	if (err)
@@ -1651,16 +1650,8 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 		if (err)
 			return err;
 
-		/*
-		 * We want to populate the newly expanded portion of the VMA to
-		 * satisfy the expectation that mlock()'ing a VMA maintains all
-		 * of its pages in memory.
-		 */
-		if (vrm->mlocked)
-			vrm->new_addr = addr;
-
 		/* OK we're done! */
-		return addr;
+		return vrm->addr;
 	}
 
 	/*
@@ -1716,10 +1707,33 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+static int check_prep_vma(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+
+	if (!vma)
+		return -EFAULT;
+
+	/* If mseal()'d, mremap() is prohibited. */
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm))
+		return -EINVAL;
+
+	vrm_set_delta(vrm);
+	vrm->remap_type = vrm_remap_type(vrm);
+	/* For convenience, we set new_addr even if VMA won't move. */
+	if (!vrm_implies_new_addr(vrm))
+		vrm->new_addr = vrm->addr;
+
+	return 0;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
@@ -1733,26 +1747,10 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vma = vrm->vma = vma_lookup(mm, vrm->addr);
-	if (!vma) {
-		res = -EFAULT;
-		goto out;
-	}
-
-	/* If mseal()'d, mremap() is prohibited. */
-	if (!can_modify_vma(vma)) {
-		res = -EPERM;
-		goto out;
-	}
-
-	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		res = -EINVAL;
+	vrm->vma = vma_lookup(current->mm, vrm->addr);
+	res = check_prep_vma(vrm);
+	if (res)
 		goto out;
-	}
-
-	vrm_set_delta(vrm);
-	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
-- 
2.50.0


