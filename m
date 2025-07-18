Return-Path: <linux-fsdevel+bounces-55431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D3EB0A4D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368437BBACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF12DC321;
	Fri, 18 Jul 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWW+HPx3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRL6Tio2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB382BD038;
	Fri, 18 Jul 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844113; cv=fail; b=NRN5RjhLWL5i2BEJGkHjdyKaorx39jgI+orTk9WuoWjYFwDpu2VpaLsr3e9uxSYfyoGS+FH18K8+bxiiSPYwlIbIbuRoIYlGqwagbS9c/EjXdegsdBZivUTUBEiSP3NThKXEtYXf0ddHJIlUHB+XS4w9WmJ89jbFQndcEyTHvu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844113; c=relaxed/simple;
	bh=RuwnC5LGjVctqqG5vnGxrkeUKLL58A0ykTbSH2GzI10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uwfq7p5woEReOX8sQpdQWdua+il89WjFZOhgjwKQni8e71twObWCnGQOU7In90Ct5KrwfWqS5jzimrDvat7Rz7LBM5nBxQYeuBOwIlT/KQRM+sEB7zUEq1zqnrnIG8zv2cNMaCrGXqgK3n7HR93VQqirQM2CRqvrzVjXDWgy7Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWW+HPx3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRL6Tio2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8gJdU031675;
	Fri, 18 Jul 2025 13:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BwcGv0vZXRlvD+I+cT
	vIkPqHXggR9nTLtoH7einBM6U=; b=lWW+HPx3U09qcghLdQ6XiyMffQiLhprBTr
	BxTEp1ZWqDDr0jsH0Gw/nn6j8m9NyB28u+4RCr1DDzBmqg9xSojnhZ7r2feU7EIZ
	iDnvnhzIXc2LlMj5ydvWIn13m3nJGfO8aFPL99C4ranUy3jqc+w+UkEc2wHA1p7X
	vREfy4gu1tZWi0c9irqxM0gGVMfRTb4do8wsOkfgojg/ONDg6a2tnk3rtMrVcbrj
	MZ9NFZdzfhrl2A/G+gpfdAdbLxWceXkEALUMoGs4C7h7s6V0ZOiWpr0zL6+K0FxT
	KW1KSXYL+KRMS8dxk17RQoG/uhUsWDzje35egaAy6/+QxhUMc9ZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b51uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 13:06:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAt42C028989;
	Fri, 18 Jul 2025 13:06:53 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dr6x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 13:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3lUgYmSPPRnugSB0SiYgah4ih6pXNNKGcKJ6kql5RyyVeRllklNbeXpqtC+lX83q+rjIq477yQWtIw/MrYYUiaofWbdTK5L6jrILAWu5QgSABtWjAEiFMKnjOSF3T6fBMoYWBmkE0XRHoYtEngm0iygJeb2YMRFmFHp1CSE7qomgG9SL3UkNtwFsJdgR2RrxHExKmHgllygmS251ge4EkVzJNfj0HhTC66mL0kS+hp0uBhuX9g888bChV/Yylde5ZZG/WuMcAeA4xbpbAu1ILR/DFiJvIepkiy7OIDg2SeUsZttW1ub1dqyf57Zxh5PVk7tPK/NwlNq9hnLEQuwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwcGv0vZXRlvD+I+cTvIkPqHXggR9nTLtoH7einBM6U=;
 b=ppz8t6C0JP1Zodu6uyQjICafx1pVZy1Fqst4LOT53Zsvo04n+8jHDeQk2yPugv4Abcib+oz+LTiEoZCRvFjvwnn855u4TEUd2zdXVp9rE7QyxcCewOZB2SlHhMYivSSCR9Bt8nqQnEdM6O4eI+iufy8q2LzyyffYtD4vJ0MqHcRuavMLEF/vhcKUksJo5xocItNjRkdee3CVclguMuE9KKBtSfShWiL0TQhsNpHC7p7VTcmBJPwMfIcAYp5MMFDzIdsZiS5okQ1VhU0Ci8lC/MYLgVadwpKfRIkYuVGefwTqCAHy0RSDMDcjyf63ywxOEagqzGdJs1MLCYsCE9EVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwcGv0vZXRlvD+I+cTvIkPqHXggR9nTLtoH7einBM6U=;
 b=XRL6Tio2VlJ0Xe9/f10HS1lsCfxWgsw231d1wAf/VtKn0Aw/6W+Sa4OBmAzEONcMjXiqJlA4U3UtD12rFVhYJx/7kHteJ6I+IEmxygjyzHVUaVcFJZzASpXvc2tCasxCweKEmgWlGS/hs7b2TB6z4jc8pK+bYLnfsVI77pIdvfQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7582.namprd10.prod.outlook.com (2603:10b6:a03:538::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:06:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 13:06:49 +0000
Date: Fri, 18 Jul 2025 14:06:47 +0100
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
Subject: Re: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <acb1f888-bb96-4b0a-994e-f39ed4b24973@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-6-david@redhat.com>
 <46c9a90c-46b8-4136-9890-b9b2b97ee1bb@lucifer.local>
 <7701f2e8-ae17-4367-b260-925d1d3cd4df@redhat.com>
 <9184274d-2ae8-4949-a864-79693308bf56@lucifer.local>
 <8292201e-0ca2-4a2a-b2a7-02391cbf7556@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8292201e-0ca2-4a2a-b2a7-02391cbf7556@redhat.com>
X-ClientProxiedBy: LO4P123CA0562.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5f48ac-4bd4-4d0c-c387-08ddc5fbf4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+kyvJp3dvYbhNr++EBpCgVHVbW8MvXECw8m/i4WZk4IsrFjAPjL5CSDLmjm?=
 =?us-ascii?Q?S/MxBxNQUtDsQl9KmDCNNPeDIuWAKYj/KjdtMzHfH2RcxUw5F7Vk9Q2jSYvg?=
 =?us-ascii?Q?wx7CXVjXzWKbDQMZppmBwiaYqBs1dbPySbaqEG3dZBu8C7Z4idTJkwuHC54P?=
 =?us-ascii?Q?SO2xCZXF+oUyYmURq3gskvDNuVuIhH492qR4WwjM6nP4RJ5jR4xzB1U21HOt?=
 =?us-ascii?Q?/0HhTAMQgHDUrRwp9eDx14isaRy5KqqMoY3Be6Sl8nMWnB7bQ0RgXakz2GUJ?=
 =?us-ascii?Q?Reh5cGG44DNi9GknsjMjSq01C7vylHfDAJ860JeomRb7dOle+UYY9k8SlGR8?=
 =?us-ascii?Q?7hjrt/eoMjvTJ0iKgMohvqf/G0ZB39YybQ7GOfryFB1JElPQGWf+dI0CF/kw?=
 =?us-ascii?Q?EGcoFLbU0HbOtuvkdsNLIcLnRryBt0EANJFYrm0wW3gjQSEptCw64gTTsPRG?=
 =?us-ascii?Q?JT+FM1E1Ywj5KtN3kU59NgO1j3nPlahTqrgqok+hAreoMY+LDOiKSbZgick/?=
 =?us-ascii?Q?a2oXdmJ+itZPmU1D+dXDyuRgjJRqYHfX2ilgFAOQjgMJnBuY26sJ3ZVvUSnm?=
 =?us-ascii?Q?u4dg1uOmdKq/VKBKC1QFBb/HVVv/yD1ChcZSjvARcaD1ZjxRpzNFTTPIUvIz?=
 =?us-ascii?Q?Du7TTwXZvveVC8O/6/4yHbTSQwsEQTAB1kmnLmSnHGvWdLlWEYuFvaU1zPMh?=
 =?us-ascii?Q?tj1HSlNZJHnU8qFbkl5UyrAeLHsraJEHPqri2ZQAH+u3x/5q4cb4WT93uHrL?=
 =?us-ascii?Q?LeDANjvFhoy3S/SFHi0nN0OTa0ydtMU79Ne6Q0NCYNacMQiRXnjUVRc/SSse?=
 =?us-ascii?Q?w0EicgmBSxrd7RwubETNgQIa/CdzwMmN58NAuvUMV9u4nhh/U10uFp/fpHDC?=
 =?us-ascii?Q?wOm/PGAhuz20E5Rp1n63fkEglT5AYGaRUK0sj586Bm6tjtz0ps+6EN/ANNB7?=
 =?us-ascii?Q?jNsrF2+MmBeqrRRELtrr6Ok2Tmu3uNcaR7PwGVRlB2X2JcxClsR9XFYhPw6i?=
 =?us-ascii?Q?AiGXSYpRMutbbCI3s1nHzKtdZeSdIcLX3N5gx4pBtYDE62a3Pwl8iuNNKysP?=
 =?us-ascii?Q?WupURY4dIo/aF/Qv0wA3XRclnXN9ZmsL0mX4j6RgpCAzuYf+dG6w9nhbCG2a?=
 =?us-ascii?Q?Wu2rsFkZNFQFw3RkMNQt4fhO6Sx5P68v2Z60bq2pwnE8EKbVBqrLqMq+HmOR?=
 =?us-ascii?Q?G1DM4hHpUpj2V7Mf/pB4k0SHAstr8qfU9GpBgoet5g6MRN/khX+nTuhlyLUP?=
 =?us-ascii?Q?02uS9v1QCOdVhh+6CCDjhtb5ZZWde9NiD0FDUKFCFM26flrPScvTO+ufqJgW?=
 =?us-ascii?Q?bdokmsYutB10RNa4o6tITDq/CiShAcr5vQzBV1DY8dxJODx7OaWV7mN/vXhT?=
 =?us-ascii?Q?Qt0UWoEc/TkM6bu4Rs8vqFJfVlCeTCEnjYkTX4iJt3e3xaqKNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3N/RveFYsEUqzfS5/nPXDtnkT9dP1C6X0/4O6k6GvPe6KoulnnQv2pqzAxN?=
 =?us-ascii?Q?07B8t1QYzeG6jFqLl23RBGa04+V4PLrB/ZgSjxC4IluekyguaORXCBJ9qEmO?=
 =?us-ascii?Q?Hf1+2upNC6jALXuHLh9eIveDWrZ1GsgbtYIaP7tlbVbh7XBfuCGhPE9ZWYHA?=
 =?us-ascii?Q?WK3R6PLdeOpLTqizzEZ/xgUTv3zzd2xFsA21SZfrQ7QvTgLkCWBbq9Cdl3ZC?=
 =?us-ascii?Q?e4bxWEGnfJl1Gexa5oFNQtLCi8jqVL3EcbDup5R+Na49vprq7i8AnCQlIu0x?=
 =?us-ascii?Q?4Vw/Z0U69Ig5F+IH3kin7KT+BJTbwWznmrnvjE2rui/GnTacyDndeQ6TVN6l?=
 =?us-ascii?Q?PF/VvDPp9Odv+/NfLqt8xCI8XDkfjweo5UcDL4nDDTLhVFCogtsApQIt839r?=
 =?us-ascii?Q?qFN8OfC/+GSrb8XJZs6dubs9ITgqz3wIovNHxs2UQJ587PyIjTqIWSSd07Ue?=
 =?us-ascii?Q?hJwtQrtSgc7q8/F1A0E5Db7XRAP4X6do1jNRDhhNyT0ELYRRqjWabdyvufye?=
 =?us-ascii?Q?i4t3nhrUiIEvsERvTClGSHEUUl+0ydaem6riWzcOn6aiY/gR9fe1hUHK1TOD?=
 =?us-ascii?Q?dcjM7ktKhJr0fYZSJY6MExUoBlYp/3bX5ZJG02oc1FdmBUQLBbQwuIxoraN/?=
 =?us-ascii?Q?wBDrHcE5kEroJxtd4z4xByDWWI5+39ZM0dJ/ZoPY1q44Mp4djjpFIG1X279Z?=
 =?us-ascii?Q?9TV7K2UT6mXbz8aek57v7EKHIBT7/F02pRL1yQPYefn4jH8mCq5lAhllXdcG?=
 =?us-ascii?Q?dm4+LYX91G9Bwt+twQu1WvBq6Z9du6wRSSJ3P/FaT5xcFhPMolNMrA3k4QvC?=
 =?us-ascii?Q?zQbYoQktL5luo4ZYBGkdSXuIKOVhsTv9tWVcJR6W4zW7jY46uAFlK6nIV6RE?=
 =?us-ascii?Q?Fnm+bbtQ46XQQkT7oGxFU6vni1YJJB8bzXEG8losGgpVkgIrmReqtlV5k51L?=
 =?us-ascii?Q?jjdTdfjss6g5nrxliIt17xNBgXojqEEv3YsnTU8SwMDY+kStTil53XvlKDXs?=
 =?us-ascii?Q?wRPaDl+J5WZmdG71pWaVYqlKRGOdfzDQ1y3YfbFxz5hqtwI2bY4gGwINjNOS?=
 =?us-ascii?Q?1OumtMZqlj/VpeESFQFSYaXoAzjlj8Fxj/4uGNumIU7VwKIHKpxFhGpzw10P?=
 =?us-ascii?Q?nCWYdq1+fJOXJCxHK7KycQ2SgnTGW5OLtnkvbzqIBSQF0x7MTByopUCv9w3F?=
 =?us-ascii?Q?265z8BVXKlXA4poYJ+KHCffNNs+YCigX6ireVnEvQug20OCFE4uRKICqJjx5?=
 =?us-ascii?Q?ojPOH1LKuN88hh0K9LZd/pH5UmXYJTG4EdbNDhMCqSv14q6HQ43/Q5zgqq1A?=
 =?us-ascii?Q?aQUqkxjEnEOF8p3Hz9aUjXOvsmb5IJO1RivrStDrV3bNlpevUUGbKp8PBMoA?=
 =?us-ascii?Q?r5k2atuof6zYasm3qceIdEC2LT1GPo/zXMquQALtUnNoRU05WIHUcaT6Wz9z?=
 =?us-ascii?Q?9TaFXvHuUNWpLSNzMfz1ixf2/2bYScMmrA5NSrFiRxv1pDIUwuRsJgPSETnS?=
 =?us-ascii?Q?ogqGEsyzVWaLPBFmoWkrjhyA3lAJoVn4KpudUys2hXUdACThe75K13s6Cl+f?=
 =?us-ascii?Q?COoGgIo5m2bK7eMgUWZ2vEIeb9IX8SqqS6Ra2n5vobEu+zRQL7yAyQDPPw2E?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LZYxuAtS8DltICk4K4BdvVp7FSJbzDpRCUXrV35XyJH2ru24EwF0UGoN2JeGswanirtAISTNto7kaGAYICa82gU3XH5XgzKx6CgiqhuEgR0QsGV8pbiqc3mshfHCfcxncxp2e81HbjchotwpFW7HqsNtjReBYHxSxZU2R4WMIyu0JNpFbWFMdRxzEL7k2zmdAVUkwmwrjl+Za+CJ/hFZDHRd2dZgo1fqQ7mM2P+4bLsipRVC9taMq/JgA2IrBBREbmSn4SbkUGWq5rZ6v6ukQuWQB99TQ1AINbQJhbzQoNeeg2w3EMQyPjRhpb5rYbR86iP0Y2YsMBQTT4LOzekGTatB+Nf/ovXnfjMpgAx5DC7o6Q1EhnlzfEinG9JU973DWCbzIGHN1mAXiCxW7voXukpNmt0mUNQGOwMgZTfAGlfQVUqMuVB3msnxsH7SZyd8k21xOtVloyCKrXvH8NitD83XfTI1JeIL52QbBpWM+uEqv48iFBm1p6TX1RfXKOGmcrTb8Y487aodZbbvZbbRcjjvGv6aPT63uRU8mKQ8N4CxKd1bAPPlZ3ODNikS8jY+xQZOxw0CsSnB9NXUWb3nPQ7Z8HzrrFfSEp6kdllnqvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5f48ac-4bd4-4d0c-c387-08ddc5fbf4db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:06:49.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJJgCjJvW5i5iH6tucp6ixxXJ6NzjrdI02JTv0icynm9msPwOK4mzRHj0fexmoCjBPM0g1xJRk2lfKmd+DXWlgVCptMQUIRM/h7md7L5n0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwMSBTYWx0ZWRfXyi+iOnUmpEwj ANAsSKOXrw8lWzwe2y51jbuQK+cxuhDlw+b8RkOuLdcilYFSqNbTh+zATkkFEqC2QrXxUrUgBOw rej9JAKA01/Hg4leQumZIMg98ZZuATQlM5aVaHzMD01FzQ//lxfWJ33HL6JVsB/1O8bbFmrqzPz
 Fb82YitgbkAMNUYauycTb+aLzueVuNH4Sg2VwKBXOWrDSt6HUq72uwGKsmB7awWENY6spbWrIU/ /fMM55FPcLK5DqHn6tfyDG7Oj1DHXtwKS0mgMhMWjR7jZlHLRGUHwpQuoZAw4HndhMiKcx6eqby BHC2A8rlxk8VvSSJnxO7BCtjWDfrTXldCJXJ0KQU5PQJB5bhgGjM3x5fhvkc0yQA4yMXkGjWKXV
 FjTkleSgFn2Rr9x7EOdtj+3+QZB/EkeW/3KqjxYToNzTI9H6UAS9WgUlzqqWPQ1EkbXS3JZR
X-Proofpoint-GUID: VwKq8ae_vjBJW4brBfYBJnb4CEfP1sbe
X-Proofpoint-ORIG-GUID: VwKq8ae_vjBJW4brBfYBJnb4CEfP1sbe
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687a46ef cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=s_0-0YJjuExnHi4Yv5YA:9 a=CjuIK1q_8ugA:10

On Fri, Jul 18, 2025 at 12:54:38PM +0200, David Hildenbrand wrote:
> On 18.07.25 12:41, Lorenzo Stoakes wrote:
> > On Thu, Jul 17, 2025 at 10:31:28PM +0200, David Hildenbrand wrote:
> > > On 17.07.25 20:29, Lorenzo Stoakes wrote:
> > > > On Thu, Jul 17, 2025 at 01:52:08PM +0200, David Hildenbrand wrote:
> > > > > The huge zero folio is refcounted (+mapcounted -- is that a word?)
> > > > > differently than "normal" folios, similarly (but different) to the ordinary
> > > > > shared zeropage.
> > > >
> > > > Yeah, I sort of wonder if we shouldn't just _not_ do any of that with zero
> > > > pages?
> > >
> > > I wish we could get rid of the weird refcounting of the huge zero folio and
> > > get rid of the shrinker. But as long as the shrinker exists, I'm afraid that
> > > weird per-process refcounting must stay.
> >
> > Does this change of yours cause any issue with it? I mean now nothing can grab
> > this page using vm_normal_page_pmd(), so it won't be able to manipulate
> > refcounts.
>
> Please look again at vm_normal_page_pmd(): we have a manual huge_zero_pfn()
> check in there! There is no change in behavior. :)
>
> It's not obvious from the diff below. But huge zero folio was considered
> special before this change, just not marked accordingly.

Yeah I think the delta screwed me up here.

Previously:

struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
				pmd_t pmd)
{
	...
	if (unlikely(pmd_special(pmd)))
		return NULL;
	...
	if (is_huge_zero_pmd(pmd))
		return NULL;
	...
}

Now:

struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
				pmd_t pmd)
{
	...
	if (unlikely(pmd_special(pmd))) {
		...
		if (is_huge_zero_pfn(pfn))
			return NULL;
		...
	}
	return vm_normal_page_pfn(vma, addr, pfn, pmd_val(pmd));
}

And:

static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
		unsigned long addr, unsigned long pfn, unsigned long long entry)
{
	...
	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
		...
		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
			return NULL;
	}
	...
}

So it is equivalent, thanks, satisfied with that now!

Sorry for being a pain, just keen to really be confident in this.

>
> > >
> > > >
> > > > >
> > > > > For this reason, we special-case these pages in
> > > > > vm_normal_page*/vm_normal_folio*, and only allow selected callers to
> > > > > still use them (e.g., GUP can still take a reference on them).
> > > > >
> > > > > vm_normal_page_pmd() already filters out the huge zero folio. However,
> > > > > so far we are not marking it as special like we do with the ordinary
> > > > > shared zeropage. Let's mark it as special, so we can further refactor
> > > > > vm_normal_page_pmd() and vm_normal_page().
> > > > >
> > > > > While at it, update the doc regarding the shared zero folios.
> > > >
> > > > Hmm I wonder how this will interact with the static PMD series at [0]?
> > >
> > > No, it shouldn't.
> >
> > I'm always nervous about these kinds of things :)
> >
> > I'm assuming the reference/map counting will still work properly with the static
> > page?
>
> Let me stress again: no change in behavior besides setting the special flag
> in this patch. Return value of vm_normal_page_pmd() is not changed.

OK yeah I think this is the issue here then - I had assumed that it did
_somehow_ modify behaviour.

See above, based on your responses I'v satisfied myself it's all good thank
you!

>
> > > >
> > > > Also, that series was (though I reviewed against it) moving stuff that
> > > > references the huge zero folio out of there, but also generally allows
> > > > access and mapping of this folio via largest_zero_folio() so not only via
> > > > insert_pmd().
> > > >
> > > > So we're going to end up with mappings of this that are not marked special
> > > > that are potentially going to have refcount/mapcount manipulation that
> > > > contradict what you're doing here perhaps?
> > >
> > > I don't think so. It's just like having the existing static (small) shared
> > > zeropage where the same rules about refcounting+mapcounting apply.
> >
> > It feels like all this is a mess... am I missing something that would make it
> > all make sense?
>
> Let me clarify:
>
> The small zeropage is never refcounted+mapcounted when mapped into page
> tables.
>
> The huge zero folio is never refcounted+mapcounted when mapped into page
> tables EXCEPT it is refcounted in a weird different when first mapped into a
> process.

Thanks that's great!

>
> The whole reason is the shrinker. I don't like it, but there was a reason it
> was added. Maybe that reason no longer exists, but that's nothing that this
> patch series is concerned with, really. :)

I hate that so much but yes out of scope.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

