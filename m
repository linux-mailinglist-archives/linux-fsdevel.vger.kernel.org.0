Return-Path: <linux-fsdevel+bounces-57554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63696B2331A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3956E7B07E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE92F90C8;
	Tue, 12 Aug 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4fSHc0q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OX2Nv8/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52121ABD0;
	Tue, 12 Aug 2025 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023101; cv=fail; b=g6DWSQF6QkXQ2Mk963wioSQ/LT105GpoLYrL/ZLMtNI5DXwooAf90ESRQoP8Swzq708W1qmvDVExE75MQ4nQ55a1s52G52o+Yq3SHsdcwZLGK+McB//bY5n6pGyDGRaN1UmgJaabmxTY7TOmRt4/qJJlSY/gaexMnW2KWXx2LAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023101; c=relaxed/simple;
	bh=12XUCtUU5jzjLVF/pZ9eoLcjByEgvnj1m+dfBd3QZTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWB9dNRwOE0zU7Qrt1JJAznSFW3Hsojnm5VBSMi+thhFrSnA4FmzEscLYNJWOiGfwFQJni1BCSBTt3bp5V4U559AMooygBepUXGkUiFOyeGQoeYAONxTv+npEeA61cms6edB6+mlZMVwWU7E15f+7nC0h8SdN0MJh6/3eKl53ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K4fSHc0q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OX2Nv8/Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBvu2025249;
	Tue, 12 Aug 2025 18:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LRLxh63bBpzk+B+TYK
	/JgGtG2o83hREbhoS4E4Ugrik=; b=K4fSHc0qimiaggU/yaCtclUOAdFPQfpHFs
	8aQ0v1pS6T8PY5V03/UqiSIGfbYTAzy2sPZ222v2++LBwbpPApDdg+/NXZmgbOQ+
	zwTi0rXq6uvL/et4sObF2YnVhPWmEMjKEMEt8lM6zaUMbF8gi9xadnAzPWV1Yie9
	SRtJ3akPsgRQq6NbSubGY+qEgjUtcP6C665IL24JcbixyLwF3IuyOIlJpNC4NYuS
	6s8ryI079I53cGHkhwB9TgR/aNCOc5+pPhhi3z/cv38QIlNnZpP5EEfzYPC8hBE1
	BixlV6Kn+FZUF3KuFnSR/omzWvFeROjGECugrgHYjh/JxutZa2zQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv5akn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:24:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGxwm1016843;
	Tue, 12 Aug 2025 18:24:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsab3ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajWpR5tczdoncEyONrQrBQ44qhE+eME6AD6g8CTDUyxw1yJKZ1TEY2pjds+3SqApxkkSME4ELj20POYz3oRfuIlASGEjAiIIVa14QwqfIwWnTi+mVf49CDNF+G2Yu1w+8zWz5rJlA6Fz+NKnD+Di+NCDMEO4Fw/vtpYjXRCTmLVPQ5Pp+TG4NoUurmNXVuM33YviB3VLWBwo037oG6S7nwX59LyLe/TyhgxVV2bMt4tqF32KGXXYp4I8Fd2pgO3pJN1phbTON+hlnEsqzwKgCyGGMXTD9NLH5ksuPMz2OOxAqlNS00qmE71b1J57ooRqNQeZV0WREfEHFsJ6WdTBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRLxh63bBpzk+B+TYK/JgGtG2o83hREbhoS4E4Ugrik=;
 b=mBK+J/LhGN3JUprtlADJT4PElwMAHXg4IvGl0lcTi/8D7JvPhLNm4tqRdoR9fCuerY1r8uDPC3q1ZWzO3loNf4Ig1rIWifwY15u6ozeWbzN0Jq8skOrLiuAg9oQVXKpStAUSmnoCLw+wYwWw3ipbk2n4f2zo4nDBGLGhe1bqjRXNvoXh8ohQ85YBS55EZr93L3K3YgA6/xydDVVkR9s/Z8XVHSM2DINlPZVRZQg/R7V7r4NYe/+mlfCVfkPshBoP4up4OXDOywP8+2i6quOy4DJAwMZ+ee96D48iUx3ygQF6m5r6wGG07NebluUTlFGV1ZOZIiLoaa1bfmpLAhGYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRLxh63bBpzk+B+TYK/JgGtG2o83hREbhoS4E4Ugrik=;
 b=OX2Nv8/ZsxSPbQWQpYI6oHjy5BwUCt6OX6uRENPxaFZVtBNVuGX54neSsYk6uSpTtrNJDeAu10R7ZlHzPPAK5n7bB+bEX8oOKHmsHnhqXszN5f1ZKvEOMKA5XI1Y5PrcRfwGuDgkYZ8W4+a9aMTbNh/ZEkIht1JSB+EhfK6Bczo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7249.namprd10.prod.outlook.com (2603:10b6:8:e6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 18:24:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 18:24:00 +0000
Date: Tue, 12 Aug 2025 19:23:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: Re: [PATCH v3 06/11] powerpc/ptdump: rename "struct pgtable_level"
 to "struct ptdump_pglevel"
Message-ID: <dac9e243-33ce-4203-a598-2877cf908cad@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-7-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-7-david@redhat.com>
X-ClientProxiedBy: GV3PEPF00007A80.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60f) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9f9807-9621-43cc-0907-08ddd9cd68bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vDB+SkGXrTZafoZFfsx2CSVMCoyvmMVWIBqf5qV4Wj64Z1XJmU/vHBV/4UPg?=
 =?us-ascii?Q?4gUsNWkRDQaT5roHXTdIjTyOpCkShpLpUeqM7BlRKMggEgx2Y1I86RH0N1JA?=
 =?us-ascii?Q?Lbv5CdSHyENHxW0PnUUWUS1KXFj3D3rtLHb0TWidE93Sup1dORUdEsQBztUj?=
 =?us-ascii?Q?Pm1oz51tmFqD4IAEcpueedc8FQzaail2rcfTq3wWJsnHL0nYzZWt3MFkVlq8?=
 =?us-ascii?Q?rrZtR03WEKaOtD0EP9MvAzvz7iSm3aGxPUNFTjAhVnV3IBA7zeOR8jlssqa8?=
 =?us-ascii?Q?chv6A4wbUF+9yU32KIgrKN6bqTeEw0NmFWBgd7FzaalSPD/czFtotDY/KyeW?=
 =?us-ascii?Q?Vhwj/bbYRD7h3d/Nm9ZR7XjWUH631aWJW8+Ot5nrQp3VQZDNh+++inDGW+0Q?=
 =?us-ascii?Q?d3jpo2ysmYWbypABPPeKBf+MzYWUpDTrteKqB4Dzfvk+Sijp+DBzZlP9waop?=
 =?us-ascii?Q?TeQ+HUwRGwT/rlofi63eiEXmHuYetxOmppoJrA1wk8jDFw5ldnHntm6LgOqY?=
 =?us-ascii?Q?j5WHIo+zmGIPeArT9SxErKG3oCXEkG1l1CUOVrxysLA4aJzSDsiMFggCEB6k?=
 =?us-ascii?Q?tp1YbrfEzFBHpotNHxxIg1WsLLP5RmHFoiJHomKiglZE9vYyI80ENX9PGNdW?=
 =?us-ascii?Q?twK2+gbmPwa/Wm5aZzQ1Xax9AgeLjqF78XFXiWXus3P60eu5ZyEJiWgcVanK?=
 =?us-ascii?Q?0DeeoWcassm0daFmBn3rb8FxXOiSciLux5s0+nKYqmNGJ6ds8JXyO/rjDKzY?=
 =?us-ascii?Q?MIEZrgkmByHfCFFVjVxWr8ll2ptKAoZDpqelp1tgVWwUp9atp7xwfmXRu6zQ?=
 =?us-ascii?Q?+Swd4f2dPsXVLA2KyqbiXhODfQLoBcEgZ4YJoZDTiOayGQI4jPoE/0AFtrV4?=
 =?us-ascii?Q?lXoQuO21qSiFTKr/AX/NMx7wKvr1VidCtBYMO/GCppR6AJ+t97XjD5u8pAru?=
 =?us-ascii?Q?epRdSF0lhZFxAU6MAl/Nmf4oQC1AU2bN7dYZXw6N6TkU+8pQ+5OM5SdLzwLl?=
 =?us-ascii?Q?UOvGu8qyTLuh3O8O+5CwcHHCy0SlX6Y7dfSwCDwPbuTYHeZR9gxIiQz8eQjl?=
 =?us-ascii?Q?WT78zGXWSck3WKrq2V5UeCgvbIryy8LGkRCm2VvIMxsyukvH5xeRczlctXNp?=
 =?us-ascii?Q?G04bDnWMYOrrMUoIpGkRSprZ/tB2zmNGB0pUy4hY9NS1blJOdNa4EiwTwMLw?=
 =?us-ascii?Q?I0i/9vob85MDdvp7B/TAY6JZ/83OlveowjyxZV44AeG4QEt+YkPKa6w5/rpW?=
 =?us-ascii?Q?t96FcsMlww5GS3GQdYodOfsU2MWPG5V87Ly2+46olvGNiWm82cAyk5Oav4ef?=
 =?us-ascii?Q?23dwb9oNzzeQRVzz87ec9eKBm16Q4rC5wzkbq8vd4tXk0CxUXE0REXDN9Lps?=
 =?us-ascii?Q?cD65UaG1fkQWzKX4w5y7W7pp3Pj97ZSL3hlzs9LkIJXRAYBYJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22ZHMobURTzeEFnzYehUgtoBDEGqaA2jlNm66Q64gnguinaRJgqtJ5tB2fQv?=
 =?us-ascii?Q?dHTsF07z+5iRn6Z9awKtZeqF9wXsWJNTGTz6m4Wh4Bho4Wnr55zNSRb4c2qD?=
 =?us-ascii?Q?UeKWPORLWrjZKJfQxZQB4QIM2soj3qLaRc8vYbTwqIcSz5swZNXeengZ6STp?=
 =?us-ascii?Q?+1NE6LGGrHKjTKe+V6S9P8TiWovvGpJ3JFpvtHAkDoZfMViEaNZnia19PrhP?=
 =?us-ascii?Q?SOD5tp+V1oXcTEWt1SLEK+f9exgciMETtmgBSm/m6scmm7kQEBQg4sseckjb?=
 =?us-ascii?Q?rqFvLjYVrof68LUKR4h6u+6QSpsbW4QdLmI/84/QMKOsuYmqajkCz9An6Wi7?=
 =?us-ascii?Q?/2xrTfKoXGmqtABojjNNP/DT96HPFjXmWULempSCMq+X0d8oeoILJfi8Sa4r?=
 =?us-ascii?Q?/0wDNPnYo/FWEXWdQ+fixfdd0kU6ElSQTTLXgN2uWW5e+5muMjr4l91S9xWP?=
 =?us-ascii?Q?z+iDS/Lg8Qwz4kYgQFbaBH6qUPEtQ/LhwPYC82ufaT3hf6xLa35UfG+Z77rf?=
 =?us-ascii?Q?jfGBQ53oBoe18dj5RJl+qmeewx6wwEknluU+Ni2k7yOkf6RoScM/jf+gvWE0?=
 =?us-ascii?Q?QYReiHNGuUmOVPQIwZ2XBCXGpI2VZTvAIRJYTx7q8Hd/dRixdXFnqsLwOcjc?=
 =?us-ascii?Q?iWqnPKit3xJuSNA26ifSVn0uIkPV0SCsJLe4A3VctTs3yrMKBVPjkD8tTGgl?=
 =?us-ascii?Q?5qkyoHQyNks16QeGL7vtJisfDgEYnGzRrjHrtpb0b2K77fxbxwWS+vOazj1G?=
 =?us-ascii?Q?SFKjrvz272cfldWVogRPVSa7bLFW2i0RZEGzy4YK8CG0B28km18UkHPwmSBK?=
 =?us-ascii?Q?KXqfuUe+MVI8NCih+N8HzT7HQjbmiAs8hmSSWARiYFA1WkJcUP+leKIXLR/n?=
 =?us-ascii?Q?nw1pXbUfsZl66wWsBT+PJQlYxwBKNpsMO/78MupcgELLQt8zcfiRA73uF01S?=
 =?us-ascii?Q?p+RVO0qiEnc4tM6e7uVpeNOceUDX+Q+gUWQeBrWF6A6Jtmc/AN5vIc6nBHvd?=
 =?us-ascii?Q?Cp2vlcnBHpbs3eINLFCJ4RDzfAlLQiSXJb7aCpjpHkijdxkWj6UnHzryPMMo?=
 =?us-ascii?Q?e6EoRLIg0GFtfphNwczJG0HBv9bCqvyGHJ7zJFKNoSXF0j7G35/S1iVHlfQA?=
 =?us-ascii?Q?rVdqtLWu9Jqc4TJUwc4mB3dXhskk7zVqAvLju3wqpz8xmVJOhZmF3NQ2Dzuw?=
 =?us-ascii?Q?XTSTmBCn2rcwGCSiIW40Z2watRdCoaYaPd/kZ3lcpUIsReKEUBcsjin0dXpT?=
 =?us-ascii?Q?B6ORjmMsSE1a2YYtdTjBiCuaFHAEOdQ3YcdC+zOQOOS1JeQLHkyH23kVW2vb?=
 =?us-ascii?Q?OY+DsFA5/Dm8xUHK4dlaTHn2FPrpIy5FyBHHuGlLFHROSQy030FA28siEUqA?=
 =?us-ascii?Q?j7Eu2yIqza48yq1G1kj3oF1WJbow+KOEmEcIoSHjTmWNuAOk3Js8Iribiy6Z?=
 =?us-ascii?Q?YrTDhLT1HtXiWx3W5Wt6SIGtUEMSR0nkdS3FEk+H23eHNbC61POIbFjAEV8v?=
 =?us-ascii?Q?N5YWFYChyo39EQlAz7wdfSJ9J7VoWQ7CbVV+F5NqleWcVE1WTwMkK54O0Uzs?=
 =?us-ascii?Q?eQ4jJBOW+LPvFUwoiWmeTDl6Kn2sMOewAKfZHSManURyjIGPDVjIbCBB49jM?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cuEJNIOpKjUh9Sls7LmUCskXgpg82JRnXZQGy1H/UL0GYVdDtDqE7I2/f/Esfnmo5pDY2GH9RrSa/WqvMSsUYL47vrE5JB6b0LQVDMgZ289Sn3mLQfvmD2MdWCom1+1CmMpIfqZLExw57HK7KvUQ/KXIya0p38Fq6lf3SoQOxtK9Hgb/qWTCrh9yq8gyw97RfvwS+P24xHLBuOvhg1cfEP/+sqNjb61C24f5WBIDt7Oejc5ZVRf4v6aXd4LOLBM+e0sP0HuMjLDgmfmOjEnYeX7JR06Cjgsmry92R9+2OcV2ff2UF1uMsAOuZriXmYbtscCoON+G969cgTHjvTGwrM40wSy3dVwwIsOp/9pZCyLW6qOUIrbv2bT0k9VocF90xsfOpmIBJ8njr76LwvzJwLVs6tCf39Sa3/3pbAwliGOuEgc72Ojb5BSxxri9acb7MvIAw2RLqdjGxJXwsjNqKWaheDVydNvxSpHp1qn3SNk3EF84zSMrplvPFYh7lvbwzzHEFCQkaWjs/gn9UXL7XLXRxj7MSreUiIa8J8OVuTnkOqcEOM6pRrXJljkP8IU3o3bxozFy8H7ek7ICqe53s8wp2lWJ9azwe23EAAEAzd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9f9807-9621-43cc-0907-08ddd9cd68bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 18:24:00.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZQMqnGVHqsdI1E079UPzJ2u9IwwyI/lub+hrFQUEHhsGPvcgRW5PnoKeNpKdu7xQgaG73glvJ8jGSIeATjF0nMhRDP+i618E1tuwiT9MpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120177
X-Proofpoint-GUID: yppH4tVsUMrU8p5iTXvB9LDwMhp_GxgJ
X-Proofpoint-ORIG-GUID: yppH4tVsUMrU8p5iTXvB9LDwMhp_GxgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3NiBTYWx0ZWRfX3vwbZRkX+sU2
 P/bVyDoQYK53iCx4J5YixzYbgTt8ldp4a6matWXs6uwBD1rIkFlz7KknACebt49yx1EonIZL990
 ALdzY3wOuChnoGtYscaEAOojd85TqlMfq4QEvmoY51xyQbMSRyKWxTo9MubxGrG8Ooj2g7sRuEf
 +dBr1sQfkvltpy1GWT9fRYHqoq9kS0wIQXJ5TzL6Ey9CseLxw02gYofTrqBkWXNVCP76vBSsmYp
 Oa6VlEEDtT/APuXySYbJs47i4zu6vf4vosDUIf+T2Wrtf4MABPk/r02ixd5pRTzzOdKBQTN7fCT
 aaNE7Rs2WxmshUABcwN8Y6Xxj4q8W23u5aMpX6P4N9N6e4IyFd5mSTQ8OiTBZAaTsc1l62YTLue
 DvCpKYIhippkq8qcGrg7QHZWBheF+gUvbT/OZquw9Ao6hYyHDs4LhZ65FJHPZ/vk0M0+u4my
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b86c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=gQUxPf2MvKgvhwLpCeUA:9 a=CjuIK1q_8ugA:10

On Mon, Aug 11, 2025 at 01:26:26PM +0200, David Hildenbrand wrote:
> We want to make use of "pgtable_level" for an enum in core-mm. Other
> architectures seem to call "struct pgtable_level" either:
> * "struct pg_level" when not exposed in a header (riscv, arm)
> * "struct ptdump_pg_level" when expose in a header (arm64)
>
> So let's follow what arm64 does.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

This LGTM, but I'm super confused what these are for, they don't seem to be
used anywhere? Maybe I'm missing some macro madness, but it seems like dead
code anyway?

Anyway:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/powerpc/mm/ptdump/8xx.c      | 2 +-
>  arch/powerpc/mm/ptdump/book3s64.c | 2 +-
>  arch/powerpc/mm/ptdump/ptdump.h   | 4 ++--
>  arch/powerpc/mm/ptdump/shared.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
> index b5c79b11ea3c2..4ca9cf7a90c9e 100644
> --- a/arch/powerpc/mm/ptdump/8xx.c
> +++ b/arch/powerpc/mm/ptdump/8xx.c
> @@ -69,7 +69,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
> index 5ad92d9dc5d10..6b2da9241d4c4 100644
> --- a/arch/powerpc/mm/ptdump/book3s64.c
> +++ b/arch/powerpc/mm/ptdump/book3s64.c
> @@ -102,7 +102,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
> index 154efae96ae09..4232aa4b57eae 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.h
> +++ b/arch/powerpc/mm/ptdump/ptdump.h
> @@ -11,12 +11,12 @@ struct flag_info {
>  	int		shift;
>  };
>
> -struct pgtable_level {
> +struct ptdump_pg_level {
>  	const struct flag_info *flag;
>  	size_t num;
>  	u64 mask;
>  };
>
> -extern struct pgtable_level pg_level[5];
> +extern struct ptdump_pg_level pg_level[5];
>
>  void pt_dump_size(struct seq_file *m, unsigned long delta);
> diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
> index 39c30c62b7ea7..58998960eb9a4 100644
> --- a/arch/powerpc/mm/ptdump/shared.c
> +++ b/arch/powerpc/mm/ptdump/shared.c
> @@ -67,7 +67,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> --
> 2.50.1
>

