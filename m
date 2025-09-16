Return-Path: <linux-fsdevel+bounces-61755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F336B59988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FC1170305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA832CF6C;
	Tue, 16 Sep 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfcTYfHd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cAVQ6M0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361A35083E;
	Tue, 16 Sep 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032010; cv=fail; b=POobJB4dsYkrza+7ZTKDMlLOXQRbmBvPO5zRofqaJWkjBSrQAx+Jib/1GCiU3Fgkkc7o8DZY29DyYhOCW3CFaQDsJ3WTtkxKGhd5YUN0JsK4xLNrL43n1YxtK84KRq32/At51hKi2+SV+fQfAHlVgFV3V2Qfzke9QciF/7DiA3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032010; c=relaxed/simple;
	bh=XDpVTNzwbLKqiF0Mo3ciWhMbgefqNDVk3fLJaX1WRV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mlXJIrz/m8fU8lPWhUU7aFzfryDAdtPQM37zbqxybA4v7Oa/3/l0aWQ6B6iTtydc4J1MW4xWkoq00fwvUB8CNM3CEjuH1A1ciuhpamK8aniy8lZw5yW9KNJtvsOJa99D+z9cso4IFw+BwO6+1D99yqBvbLys7JoRkBD43yhQQIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfcTYfHd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cAVQ6M0V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCecqq003101;
	Tue, 16 Sep 2025 14:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K1yxSfHFLB+VgzTlghaZZFYgl6sRhMJpd+dMeB5lG/Y=; b=
	hfcTYfHdwBPwMX360v6JjcRBAmoSeTnXG1bIdSo5l1aNj+KrZDDHFXI3z41xZEDc
	M4dpdUpQfg+kIV7tY1NC2KNOPr45409prBqJf/hLTDvZaF6WjVUA+xYsgt9rP30f
	sID/4d8Y4hK9QkdE75Y74pW+TLk/geAexkmbq/cj+dn3AIq3JId6Ne39wQ8m5H5w
	Kvc1PQTJJAvorVHmiucRxp5iHRs/UavBO/SjBm5UDJrg4D5Oj33IKuHKBePwccwx
	YpE7iZSa8t9KIqQ/kU873Zz0DOdEp4PLZpAn2/eFOvoGoD/YGafyyUFBmHRxXFQY
	dDaMPfi6SZOl40RUz0Hs3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf4th9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDeh0N028955;
	Tue, 16 Sep 2025 14:12:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ceb51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBKa+a+Vnrc0BFg/qgICmv2TLhaoPQLjJOWkholfBfkPq8zQ+6cyVGvZ4frMhxkbC5T3OFxjRR7pIoNAl2i0Ezqttu8BC9QuMtSN0dfAzM9Hq0ImrON1m6WEAxUidhKs5Ovo0vIRXjrDm4yha4Ie00tFREkKZ/sPOOonRt4jgvf9v4Oig6021TYQaKX4UvcygSA035kliG8vnEE+fSqP9YQKWGcvxskWKQ8HvucB48duJZxXIC0ES6JAteA/kVxnSVFamntvb1j8/C+0RY/blxFx6C+aHl4Ngr5eDtFUZwccd3Gvnof2tvHkBs1q06/Hi0N7jXJkS9A6DFcfCG3VFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1yxSfHFLB+VgzTlghaZZFYgl6sRhMJpd+dMeB5lG/Y=;
 b=jfsuj0Y7De0LsmInFVbMwk3tOdxY3sMZ1/AUs9kr2+B29Bb+31nyCZ/afgxCoaDnO0KJPHrRNiEAhilgC7ScsbwT/k7aNEkVpzyR3Wx+odR65qaGl1Zsfc+SKqMD8PNblDj6K6s+W5cgwvhHbrGxLnZnnI4SsDwOyzAx3au+c6/iHRt9YeZufhAFIXD3UX3TlvAmni6fSDuZa70pYQUItAM332xQaUsXce1xtBkft/ZOcEzUp2rdv6N6bfM0N0V7ff2+VIqEEqqTTLO1FmZAPYHidCXEi+DFZr53PglbZudV/wCkGZrMMU+p7EN3Gn8qvxTMtGvZAQcg8lWDYsDaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1yxSfHFLB+VgzTlghaZZFYgl6sRhMJpd+dMeB5lG/Y=;
 b=cAVQ6M0VTMwhMuG9UVM4r/4bB9m4ff6+2YJUlWvljsNYEa+hDNGMG6zlhj36ztojAoE5UptpNDVWnQGy7dsQv5OZfIe8EOfobdHIaBjZdyC4zeAmRcksSQYkVlKsto8oKVw321X09TuNxs4Z+RQMYxlSF3TlDTCl5KV9N962rX4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 04/13] relay: update relay to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:50 +0100
Message-ID: <ae3769daca38035aaa71ab3468f654c2032b9ccb.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bbab46-bd4c-467f-3642-08ddf52b1b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTQSI1+QVrfxhMaZRs/TIt4K+Gn7OtYBbvWsUN9oK4kqhdgav4pDxpyR7lKV?=
 =?us-ascii?Q?4SkUSx86LVl9+NnijhbDALPNDca2UF8O6+XB4xvBKyD4UkqddXzonSBTcEoL?=
 =?us-ascii?Q?j+d5V8TV4EcBpzuhO0jea4D/mk+4maQYtLFw3hFzTdE7+VjsWzM60R0pzTam?=
 =?us-ascii?Q?eGed8Z0QQJhzjDpfLOpP1cdFerirTRLUQj0NO5SejTstFqtgtpLEkPsSnhqN?=
 =?us-ascii?Q?e/JaQG0klS9DmnFjP3lcgrX74mgKtiT35woYxXWvk942g8yFj815WvPZqvfh?=
 =?us-ascii?Q?XdjaBfhP4duc1TLx3oZ8i2kk/6P3R9g7Vvs+yEJnjs/MWfUNxwIJU3uWb4ZV?=
 =?us-ascii?Q?7pardNm2HoWKOQ0G/Jwdkx1gG63VY9/6DU9r60EO+a4u+qkwvRuB1GhyZtco?=
 =?us-ascii?Q?4RutMx4o7N+cbwQ0SKHi715eepMzX98GXInIwjjgQrxAvAzB/tDJLEUe6hg7?=
 =?us-ascii?Q?Pbn3E0BsCtolKQ4nqmMg0qxBhFNjI7yckN/PSlWjoGh16Srss3GYwPqCTdkR?=
 =?us-ascii?Q?0W/oYV9dBAxX+CNixB8omfj94PsRbhUpvQ8dSSJX4fH9xduvc6WzHa0elJ+t?=
 =?us-ascii?Q?h2AsVYBptfcQ2xWCRljVBMu1C6yfKiuuiJ7DgFMGbVWMBYZxc95au3faEqwF?=
 =?us-ascii?Q?SZbE4mz7z3rgvnepw2dAkE+/uEpx/I+jyguZ47Jr7zr8wN+/8n6EG8uIvo9j?=
 =?us-ascii?Q?yT15KpfQXAPbBNP7Ap1PlCDDWiPk7YqmFEnxWQNIy7v81Ii9FLDXQjnI6l21?=
 =?us-ascii?Q?QK6LVi3LsGFVgGHeBvBjBxT5+i7cSsKdxa1t6X64iADCXo+DI6IiOtqGzGeo?=
 =?us-ascii?Q?rmLB2Y+HRtvLBjM90EpTBoFzOeS45EEbEgfWtqV2hxiRJxUabawOhYbI+lvK?=
 =?us-ascii?Q?FYsYFqfxcns190mED8BVmQX0IOCztKG+aMrkQ6KqZ6HlKW1665UT9JexS+gt?=
 =?us-ascii?Q?Ocd9l6E3Nc+pVfAcQquFG2niQMrnH0Edqkk0ggADDrTMPXgwlApQpS0jW0RV?=
 =?us-ascii?Q?22NH5MGqlbq92EQ5kaUphZqBFKSGWOQckpnE3COOhw6vpbQbL0UhpOCrW8O7?=
 =?us-ascii?Q?6C2DSbQDnBvsFCNGl8UCwnhec51YdJKbtEs1Zb1mASAegJBZZ3nN0fYC83/h?=
 =?us-ascii?Q?cjferF3q2TH+A2gG6+8m3DMBE9oyPRd/mNtOmnhKgbK4lxS7GdWbgk7rBgfE?=
 =?us-ascii?Q?Ih7trr8Zwd1DN+2SSgS9PWGrsltPeKc6aM/TEdpgtWYKJD2ZqXcTKZfhIODy?=
 =?us-ascii?Q?2P7UEYWZx58xHCZIlTeyt5TJmkArFM5+0HSucK/f8+Bd81DsDojnE99fQGoJ?=
 =?us-ascii?Q?+Osya5qGvySDc/LldVFpz8jaz1gPlmVlWcYCwjCSiJ/xitibFvoIh73Hj1cc?=
 =?us-ascii?Q?HmL3k4fyOd1pM86Zze9gfiPm0ryKfSDM6DSY5vaGaiXY6n6iVdHhYoeUaaNU?=
 =?us-ascii?Q?/ExAxVAc2y8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLlLclz/lDPZdZf96wbFdKUyKG55XKEYmiIN4BztP8CdIBp00OIdpgUUdW+r?=
 =?us-ascii?Q?0oFyl7ikbQdhwcGqJoJlJ5N+hMlmmvOC4b10/PaMMDyRu1HJhenfZI1blgyr?=
 =?us-ascii?Q?NWWRzb3+a0ylRJAHDcWCO/BavRiU7Kcb1w3AYoTBschUrOI4J0XxNjncJddc?=
 =?us-ascii?Q?jIzXEMzzCItRzRVF3PX0Ivg2RZLGO8nYOJvD09lZAWmUtMnymG0VRaq5cBel?=
 =?us-ascii?Q?PyFV1HFv48xohG4KPB2ZfLJbLO/2Ej3OorWJjfPWXtAH3Xd+1xsO34kmQLJZ?=
 =?us-ascii?Q?v3F4rbPNMNpHpMO7OnzpX5gaWar8XJzYVeatqdggG0IBA9sDYkzCPgKNjtTJ?=
 =?us-ascii?Q?fQMHoo0UiQraU73vtZqNsV9oBAW0U9pCBXKpiDGaQrLizQFC+VR6FkslHe50?=
 =?us-ascii?Q?o0+mNTI/+CpIt8z6Ez/ciGtzSEaNVk7D/2QH5lFZvCzc+VZ1BOJWvCNMjB3a?=
 =?us-ascii?Q?qa7MZmvqa4Ud/591LPpnDdmJuKeEHrFjyRSe63hNdU8dSdJ/sLr8Ct1zGzyk?=
 =?us-ascii?Q?DPfcdRELzQbKDNYMYDsZe8FWrnWazN+Kr6FILR8rsl1vAvl9d2XArUTVWAZx?=
 =?us-ascii?Q?7P6rOJ4w7FGQduxGpw+Lk6Pif6EOkNAo89SKbPkXoBNJpgPhF+h9LorCY/Mt?=
 =?us-ascii?Q?3sP0CZ+eIXxKW8dxoFPsRq/wAjEYYfPixEyyEMmIDZF0m/z3ZrrAMYQ9KMuE?=
 =?us-ascii?Q?dm69bWDtq2Jl70sa9DjEOojHyc3FYJ61lxc8x04OQhMxKa/XLag5lqmbq+vE?=
 =?us-ascii?Q?z3GCUUkKXYHU2u/YlbsCqRjcBD+71BsvQejxau9QU7+c438701ENbMTJb7qf?=
 =?us-ascii?Q?/nzdfTP50uiiwkJtsUuYzofbyty+XfBSxfnsPpaeSWwPsIAp8i0DaM+DDLoi?=
 =?us-ascii?Q?tRiI8ADDUg+AWhlcFhDPrHzr+fGVLA+vUKFNRfTTdrET6EborIII2H2HwFv8?=
 =?us-ascii?Q?WTzzhKfV11g8A7grobo9ltU+AyODcwcQarbZk7gh14xVCA1r1nY8DNDMC4j/?=
 =?us-ascii?Q?RyUYIa+pNPMa+1Bpeu1+NpUt0Fk1e+CsvBXOUWw3ENJj6hORlNgYnjxgCAUu?=
 =?us-ascii?Q?a3DZrxs1mhiTJOxLjtVj7iSj7do/zxaqymkQcWCqMKktweDRZK5xZqsfULih?=
 =?us-ascii?Q?sHS9+ectk1igTvPhiQ+ZzA8fOcE6qry7nkVuJbV5lv9ZIKYyicYlnklalggo?=
 =?us-ascii?Q?Bc0I0byYofxnoZkJnDx4ISh7stpkV6KLrkgaANCKIPx672EfZeT6A4jpO6Ym?=
 =?us-ascii?Q?HNcFAy9nXRa6ZDE27ky502xIdHsxqgu1E936FvKFN4fKNerNByjbELn9t3co?=
 =?us-ascii?Q?m9uclpfOSxyiJqGKcc+if3AoCN6MDWKlATvnVrKRrwfvXV1yKkxVyDajdc3A?=
 =?us-ascii?Q?AWy6JTxTtiIbyDnrx66sICJ52pxWBH3+9Aplb5S+SsHeSuWKbTvxbkMES9bP?=
 =?us-ascii?Q?F1+KBweC+pHQLsP9fLQsn3TINAeUThMJo7nGJCF9sjTHYAuHjEFjVVX7H3Mi?=
 =?us-ascii?Q?eJg8C9ljkgHf0sJAaz2YtmlXufK8L7ncISiUNvHie3s9nsiCVj+a8J0Uvne3?=
 =?us-ascii?Q?zPV8u0PpQa+6zWe3EcPa5WHHFMC0AVjRiuEDmzxenJW2gljw7s6uc8cglYUV?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q1RPNmPfMLuEDGKuzUHJ+W1wgJZcWI425UzD+CuBgLqNqmI/rkOYcKmaXitvb/MzsUoNKLpB+/AVrZRCLW1x53T9mQIQYB5hOaxAPpHp2qzGQsOYHoy65XC3W5sfUi6aBG0GwUC4FEvTrh2gQH86D0wRyHCKOYiFJQtfEFHRLMFcBQGpg+oNnlbvar2+bcWymiwKq1V1DAjvcSYJYPi3L0PK1Yvgt3l8llBHgKXe+TmLnjuJFVdtartekGDNUcetgij9vv6QCxS+53Inw8ZhlTMPhXwFoWjzOYFP2y6K3sDBEhMwxhOFl18YPrRfDe2JJQKphbv6sRXzhSTNrTYGRTWDl4tDsukZ574UmS7Gt4IfbNnlmSX1Aejmz+vgaWMvnvoHI23L4Vnaf/NGBkuJ9VgKox93MbATuuD3fjp7hIpWOgu/02xbXiLhAi2gsBv3CMArfVy3B7RXl+L/XItc/888fQE+U5IckY0xI0PbhYrsDUIVVu9xvvblwrdNRhWwZC9FYtrCO+DqglxZOjAiuMTOuWTw44F8DsvQBVUzdESjrxTAmE+LMlc2ICYTc0+X8NFXOcPm5/R1zLIXSANvKoA3cSXcmOjrQ+CF5KQylgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbab46-bd4c-467f-3642-08ddf52b1b84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:45.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyRzN61sQAcWpz3QRohGNXpYQKSV/Q6LJng4X1bU6xABwHrshefj8slRn2zfSbqzfjfRj78IvFGpz4aqdwWWhwdrwAyy1a0sHf/kzi1sto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160131
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c97061 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=kVp6y68UWkg0hX7IE8kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfXw+m3CY6F0i5V
 WvYxOpE7D53NqiRYC8QD4fQGGEYz6BLsYkUaVpKQwWbSiF9HXPxDBF5rMu3f4vgXJl4MbsY6lyB
 W0f/9xg4OdDRvQRiY0Tq01c5Ipkdzq8h654IK/ns4FwYwBXwF0vdb0X4NSKveq/KPeFP3HZLt3n
 qyPdjNkGzXQzoGgQ8lBRMl3Ax3Ar7vhBflchGceVV62VyQAiarrsaUqQJQyfk+i90R+gC9Tv222
 gt7ku8KjrhvX3OD3F1lsxVHys9oBZ5VrAWbqy1/xwsRGAKdXa0gVsW0NrFuft9Pzo4YNf2OPZYn
 pzQllsRo1QN8LOZjX6SYF3aQwLFRAB1U8f4oBLpfzkn5+hTsf8g8+1sv3js62EGHOHL83lkabfP
 cT7dZNCp
X-Proofpoint-ORIG-GUID: pfDkDQHkOq8xAE8iXN_y5egpBUNPGKl-
X-Proofpoint-GUID: pfDkDQHkOq8xAE8iXN_y5egpBUNPGKl-

It is relatively trivial to update this code to use the f_op->mmap_prepare
hook in favour of the deprecated f_op->mmap hook, so do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 kernel/relay.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 8d915fe98198..e36f6b926f7f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -72,17 +72,18 @@ static void relay_free_page_array(struct page **array)
 }
 
 /**
- *	relay_mmap_buf: - mmap channel buffer to process address space
- *	@buf: relay channel buffer
- *	@vma: vm_area_struct describing memory to be mapped
+ *	relay_mmap_prepare_buf: - mmap channel buffer to process address space
+ *	@buf: the relay channel buffer
+ *	@desc: describing what to map
  *
  *	Returns 0 if ok, negative on error
  *
  *	Caller should already have grabbed mmap_lock.
  */
-static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
+static int relay_mmap_prepare_buf(struct rchan_buf *buf,
+				  struct vm_area_desc *desc)
 {
-	unsigned long length = vma->vm_end - vma->vm_start;
+	unsigned long length = vma_desc_size(desc);
 
 	if (!buf)
 		return -EBADF;
@@ -90,9 +91,9 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
 	if (length != (unsigned long)buf->chan->alloc_size)
 		return -EINVAL;
 
-	vma->vm_ops = &relay_file_mmap_ops;
-	vm_flags_set(vma, VM_DONTEXPAND);
-	vma->vm_private_data = buf;
+	desc->vm_ops = &relay_file_mmap_ops;
+	desc->vm_flags |= VM_DONTEXPAND;
+	desc->private_data = buf;
 
 	return 0;
 }
@@ -749,16 +750,16 @@ static int relay_file_open(struct inode *inode, struct file *filp)
 }
 
 /**
- *	relay_file_mmap - mmap file op for relay files
- *	@filp: the file
- *	@vma: the vma describing what to map
+ *	relay_file_mmap_prepare - mmap file op for relay files
+ *	@desc: describing what to map
  *
- *	Calls upon relay_mmap_buf() to map the file into user space.
+ *	Calls upon relay_mmap_prepare_buf() to map the file into user space.
  */
-static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct rchan_buf *buf = filp->private_data;
-	return relay_mmap_buf(buf, vma);
+	struct rchan_buf *buf = desc->file->private_data;
+
+	return relay_mmap_prepare_buf(buf, desc);
 }
 
 /**
@@ -1006,7 +1007,7 @@ static ssize_t relay_file_read(struct file *filp,
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
-	.mmap		= relay_file_mmap,
+	.mmap_prepare	= relay_file_mmap_prepare,
 	.read		= relay_file_read,
 	.release	= relay_file_release,
 };
-- 
2.51.0


