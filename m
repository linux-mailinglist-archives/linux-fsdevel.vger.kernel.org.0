Return-Path: <linux-fsdevel+bounces-55282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E23B093BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F11C46532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398F2FE32F;
	Thu, 17 Jul 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNgnVtq4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MYzjIrWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A32FA64E;
	Thu, 17 Jul 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775801; cv=fail; b=VuPMTRHf1e0l1U5HV6EPphn1aVCbRt8gRXe7GZXOOPekrsM3bjMaM0nEgJjvX3nXjgyq278pNacg2k2urQ3xsbGm7aLTmrF4zqc6Y0EVck4FcyikA4+gU4jnmV1JogqOIhjQG3nfkVYftDlDOPTaNhtZsQ8QvJ2n3DeS2HcLD7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775801; c=relaxed/simple;
	bh=ju5dgTurrUmtKZsDrZhlh0/d5EKp65aborScxJjUm60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjSA7wmPQ7aDzl5vaGncQb8QmjuxTx6c67fiofjcfzMHKu0VdkUH9J+rK+YWpMggpXa6LMfnZZYrICe+QEsj1l9v7Eo+eR14WI2cxi5kjWGwmO6phecGNHu1sRUb6rTgSU0TABHqJXc/4DsZ6FhucZsCp9pjrVsLjwNk7amGGy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oNgnVtq4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MYzjIrWp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0l2U018013;
	Thu, 17 Jul 2025 18:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KI5fI51Vk/7q5+GpF4
	rDA5cPNmGQE7df4u1btPcrjv0=; b=oNgnVtq4rPh7mBzYdr1Ifpoy4cJZyoyWOO
	KVrAu6EBSjWAI0dBwDmp8AMGwwmljojVXXGAt8nQvVpy1STpeVwsYyhahs9ThLT7
	oSORwDXa8SQ/BfzQ24SefqG35Q4fd/8JOOBKptiNNU6aC41m8MD+IGR+kVl5KOgR
	JrvZ8fngZQKRxy5BDbpcQRGKBmiz47TLEl1DbXsFbwWRX9aLIKtHNEWMpVhav4x4
	Y0JLoUYAQFPoviOxFBpJVeLapq4P+QxyZEQnFBer8xpMPoE3XsN5FwhQqBIN52tQ
	g+oTy0Gar0YFrWLNjY61pZwpJmAfTd8CqLi6Bqs7vbj3p0dYfK3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4un66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:09:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGkr6V012988;
	Thu, 17 Jul 2025 18:09:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ckt8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nop0NcMAdIXGDQixjl85ZtURXitFTp8PXkrwpE4ukPRCQSOJaDDJB19yquRBqXsAq/e5C6QuKXbFC7aZvQKjfEGl9d4mg+wK6q8T0K2XuBxpPCTil0on8sQ3RjiJss/1FvISm+m2aCL469rMcsUpzDXGlzF4UlmI91TYZo+xIQH4TC7QVLbvy/8FTft8GQ9iDUriPobWsfsjJ1OLeJnZPO2NSO8sbQSceAf9XEs44hnWC64kxSuRx/yfWOorwZBwfDyuHs884MFKh+PY7TQm+PSpjGCyursMKCdeeyDneMdT/uR8d0x/VHa7xwmTUi5g8v3zJm4nTS7KT7TuW6CmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI5fI51Vk/7q5+GpF4rDA5cPNmGQE7df4u1btPcrjv0=;
 b=HmKM/VlWiEmTsrrr26FncrH72UteNSQ1B7247xgw2MSRiJjzsUOEawYsmIFASS5kFbONAOHmygUZ8KLSYJGMYKpDMlCzVPiX5F3Ov9F99Ql4N+CP71fQs4dpT9uDUhRbAw5ThM/d+/Ouk9lkVoIjteAX5bU5NQ0TIsaBBFQJxV+qCQguoYKIHtYBCZtpctMW2n95Wsb9wlKCvKbWAB0+QwhUzl/MuIK3uyloyaawTLe2iP7a25cclan1F78qa0rfRI3tSYQLkNOcfyc7APG4HpwFtSsehAu9wdIe/kJIL+Vvftq3urRHbbJaiQOfzTbhZy4lz2ptQlhSizu9yaO8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5fI51Vk/7q5+GpF4rDA5cPNmGQE7df4u1btPcrjv0=;
 b=MYzjIrWpS58KXzxKM6dncat1FgMg3t9kCBfZPPiUl8mhHKcDETtIiNVs1zT+AOZjDEJvreYkqz4hpPAE8ocl2bcrL4aUhogqn034nR3JYyuRbQ4tUQG48d+qK9UB9mX96ZnjZklXK7pxc4GCApMmESJOKawayyJqKwYAr/G2EQQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:09:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:09:12 +0000
Date: Thu, 17 Jul 2025 19:09:10 +0100
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
        Lance Yang <lance.yang@linux.dev>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the
 huge zero folio
Message-ID: <fd640cec-fca6-4247-b5a5-7365d0c5740a@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-5-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-5-david@redhat.com>
X-ClientProxiedBy: LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: c0744835-6705-4cf0-2637-08ddc55d08b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyCXqDcqtIwe6VzMJ29zzn1rhyB0R5JASrgM/Pdfv2sK0kkKwNxL6g0cfOzI?=
 =?us-ascii?Q?//IX5jjUul/Ry8V5omeALb/VzUEIoeWui6JR2Tp85/kZNV88vYr913eUhTaO?=
 =?us-ascii?Q?Bz4MgUh8EHrALppT/JU7wJNusqcH0uxMqxkL32ZuIJy3bUSjt+lHUASaf97/?=
 =?us-ascii?Q?OcK1qi/MtVI26Y9efMnFbzbsZ4UKe/K6PbB/6bQcEBMavZ/loBDjnI7tWROv?=
 =?us-ascii?Q?zqAbWvRy+ktHgJhJH1u7hya4F8RsjHS8lHJKBZETgksaIukWp44L44IBOv+J?=
 =?us-ascii?Q?etObmyodGbQ+dqgCJdK5JygYH8YTy81uoNEx8Wxxtzffu8eF+eteuV6H1vBN?=
 =?us-ascii?Q?ibc63kgkP29OQI4MrNocKOEOVgzHUE4+MBMf5yfxIO1bxyDFUlW+CSKW9OlU?=
 =?us-ascii?Q?Fr6lu8PLTEOTxakBlBZqKdMnZtVao+AI32gB3cAfechcCpJyjbLMxSCmhb2U?=
 =?us-ascii?Q?jBAWLnODkCZtqR0wxYh4qel2bQoDEM2hI1SltvRnwz1BNekK5oaJxxy8BsIm?=
 =?us-ascii?Q?lpCIF03qaXtvrSYCdOKj2VJgZhr/yhp5xP4fLKPqsrPzuS0y1gCR1BnBWD5K?=
 =?us-ascii?Q?0Ie1aVJ8f07oYY6dmEjMReUwR8gXTeydXRgI3Ot46i0ZWbHnODnM3dVU4TVT?=
 =?us-ascii?Q?xp9oNtCn9fE99uEPNoodcfZz/lrL+P0PsF0A5oo/A3aOW+iMAspgodp/5bmk?=
 =?us-ascii?Q?Fl2XB/qMQf5n37pufiJlhO0oW7ANqkGZk00J3Kzs6XuTOlFPPG0FPPbmU34i?=
 =?us-ascii?Q?pAGWcGTJsXuBgPprt02I7htFCAgCylPqPS2WlWTTN8jkvn4PV0xMODEGxh6W?=
 =?us-ascii?Q?gCd28MZNPYK6glKx4fEhhdng6QEoiHNC/5wEBE+bdhe23gLIk07MOy1h8mSL?=
 =?us-ascii?Q?Q+AenmXZeQ40l35U/ZCpaLsOYMvdZsXLrphrSVvUfVBKQum/hnR3s8sosRtx?=
 =?us-ascii?Q?Cuwf0nGjjjHglE11rw+/0SxR63CEVv0uyEXQI5lx4+lReDNjpvpvCMC/Nzom?=
 =?us-ascii?Q?dxu4urg3aXGirEseWQrIEuEl4yn2sFKSO3L+40P6NLvRv+WvHBjm4mvLQh8f?=
 =?us-ascii?Q?KF/LmBB42CPpL9gktvvUqWckWGdkR+/2fsqNMBuGLmsAzUhG683rSY1x5rNS?=
 =?us-ascii?Q?wHbwSOp2Camao+uCV3Q0NClHvFc7yPmq7QOSvVxHrf4IxS6ryTH+ZgF9OhKT?=
 =?us-ascii?Q?bQ3Ftzj/Z70SOSYg5jRUtDrfrOrwQ5q3o2kqZCrdEcFdZKb3qY9KcbpC2eU+?=
 =?us-ascii?Q?rOeBW4hpoCb7r7JIvehlESBDWCyV2inGm2OAfGUdaYm+613Mkm97dQJdtG8H?=
 =?us-ascii?Q?gruQGh53gqLASoDAI4CmkAPhobDUZwLPoOTE0BB5Nq1AYAsRncJQ5iupUMRC?=
 =?us-ascii?Q?7U9AZSJOjluTyE09uidkh1JW0W0maAFrgVl+3A34u2/Pfp2G6IRgCy1nP8ra?=
 =?us-ascii?Q?Wls/xwTCmn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMQu0ietdDO1fIlrtsvvvrbmxMNXLkIS3sNRojlPvo7sqS8bzHckfbf0o8zB?=
 =?us-ascii?Q?fbLbhuRzyWTRxEgZVpFHDEtg1nc6SEgtGuLg60Gr8SxfW32KOblACBDkYu03?=
 =?us-ascii?Q?k3ioZD/dxE7v7+cFnb+xK6r8puQrmJDq8Tn0muywut5OZ6kXMzg8zq9N69aF?=
 =?us-ascii?Q?SNEcRqqX8kkGwa/LgU27OriClk6Fqsss9C2w3fFLQ9n9uibrSw2RW09DnRBc?=
 =?us-ascii?Q?i9ajbndoxXAKZjG0813AWQWXqjUH8eIy6i2WDv5xpeUAgly7uZhllApZg5Nn?=
 =?us-ascii?Q?GDMdXU+mrH2Vs8OhLHhErIpSeLr91IkOP9IPkYYqMBnPCWLXyMnqaMvXg7mc?=
 =?us-ascii?Q?mNxamASOe8klTu9lE0rcjCIKIFCfsO+4uWGTHrgBsQZo0TM4Y4oNz30JH8+p?=
 =?us-ascii?Q?TzSu4AgSPWPjq8qMkHZXKrDpNhKCT9Mkwq5yCf1DWfg8QlT+6pJ1CCilazwR?=
 =?us-ascii?Q?QYcUaKFInugrROOIsDlWaSeLdpvLrRpQcyWfWwRJkjRLHkz+rdr/f0fjz6Ar?=
 =?us-ascii?Q?lA3/LOIj3zwva4eIILuUREX6uwgYTshhDM2+QHZhagKjphAEKJRvVOK3lj7y?=
 =?us-ascii?Q?Zl6ky/N6OON04iU+GijroJoMw7LOT6fustqJBShPs5IG3C4u9bHb3hnfbnY+?=
 =?us-ascii?Q?o3bfOW30I01P31r5FojyK3I4M0nJBjZl5cb3R44Ih3FqZO7IndjbOnxq9aM2?=
 =?us-ascii?Q?+D1FBNuYXxKXqyo2DrIzQpajC9khIqRfhNVQ7q6X01w9r90LBmbha0flKSF5?=
 =?us-ascii?Q?+d1hJDmiEx5HWNAAnArHias5lMFf0WSg5GdNvxgzsrCvnvC4Dy2PunxePz0a?=
 =?us-ascii?Q?ESfTHvzbGW3rTIWjCzI1gzkHV6L9yMTfRRjpZiqI2fbV3E/D6Yld6rAi5v4A?=
 =?us-ascii?Q?nm1mWXo7myK3Ae9/qs9eS95sgoTvEC0gG+JowkkLmBHH2pcgrhMlEUnJ14cw?=
 =?us-ascii?Q?HkaNHXiMA/Xo/4QT51huMfH0IVUoFF6OXL+qMhRy4ZR/GmddQuipHUS0/3x2?=
 =?us-ascii?Q?vOTrWvckSWHY2NAtau8d4NPI/StmHb4Ydwy2tMijGdUe3bjKCPXnSVMQKfzD?=
 =?us-ascii?Q?Jevw1C8ZDWCpP+uAKzOwHCpVTkTtVx+H9ODgq75hnSQDBJHyrxxmgFpWpmbg?=
 =?us-ascii?Q?LbWJUCo5E+HoFwwXVUM2MSi+H17drV7GmIExREqjxDV1PGa+GABF8Bkf+J1J?=
 =?us-ascii?Q?1DTYnTfOJLYxFD8EhUxQ7lNb/lqNmbC+VLOUmMbx2xGyNqo2+mQgrtu4ZeqT?=
 =?us-ascii?Q?bJBzbzsxi5F74/B4PLMoG3oh4I9x2XIXx0NnDesasLUJAPnWfT+/s72EkUP2?=
 =?us-ascii?Q?O4Ib/3+UmxV/CYcF6dxEuEI6+d0upJ0I3oLg43KB747OCvRSDf2c2y6cDsqp?=
 =?us-ascii?Q?6q0Bn78HTYGgmTjJUUV7fUk0BqodNmt1saWnFBVzm8iElMuAa50tSk7925Rv?=
 =?us-ascii?Q?CypX9tMdQht2cQckJj6CDd69eqDZdeWaPYOSko4JOo72GxY77bxvTkLpxByX?=
 =?us-ascii?Q?h165k9kP0ojPqkDCI2twFf/MUeBH0SbfdmCOznhyGGRBLRwrW3GOtBtAikhD?=
 =?us-ascii?Q?je1EIM84nK6Izp+stE86RUuE1c+LaglZVV8tP6wukUXbVnBv4uFZRrrxpoNg?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y2rUmC9lXoRxv9hc+in7qjqq6pw7peKGu5wTSbdL+s39S1AZV4+0odghB7F36YHVwu1jmGW9KcjqTgh297PzxsshQaTFzTlz86CtDMl9CKSSpcrFb8msR6wHkAxgwrIwJMhuVjX8nXeqcFsYgdZOofC5+MgTcIyvcB58g7xW7vJSozJWfgK5vuPV6LI805kAaUjHCGs5RIS8X/5RPU6m2/LUiWTNPdLy1jPlHgjql7HIqcp5I0fH3SfnG4MmreAv8kMMT/zcmrPd/0a0ZbhgO2wevd3lYrH7q+nAl8wuK6vh54gr9xOwVYQ5KAyUL9Zn6QyHJJk1Kc7Vzyvkm/ywou5GYcJUAy/gkZ/mwRWE2ITu7IE0uK6QUu/WOk+3ajnIWBqptw5S81mN7irtRvR+OLMpq0OQglvkvGdPEiKrgRMZ1U1sXmml2XqoqyiyRBcVpSjiEYPesNJB31yUSyhThDieWEE3IZHoTgKYdpD2micsv/ZzxChi0kxsWh3MFIuEXvE5DcyVFJL7ZMOqbegBGPQm1Vm0FDlxLE7LwHhR4MoSujkmFNadvqAhECWbdQFD4/SjPQ2ynMHrjocWTrlCV4kU8uQiL3yaqw2wd+6eDDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0744835-6705-4cf0-2637-08ddc55d08b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:09:12.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDeET7Mrjr5sXy6A+j1TSc5zjRaDiGu2EomMZrT0NVuXaPMcCBX+OR6akzx2cRNxa+tZRkAM7+hGzXOAhPaobv7URrr3k4X86H0EdZa2pts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170160
X-Proofpoint-ORIG-GUID: U3IFyOrkqyQZtzhdch99w7gRKpsDZluy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2MCBTYWx0ZWRfXy1E80a6cmGjS Qcpx/+MskQS4VW3zusBF7ZOjLSJZph6oJagpJINi2Q4a+4pS382bMDSnexMWl1gdoUU5E0SR54j WoKDhGJc+syQ3wf0jeA4JskqDM4xSZn5kT6ynbLPdlLLEifTHVM5K5YE+eb/DKM3zWOR3Z//8ve
 icJbaLAMkFYKG1lHV2BNYHDcGbpd7XjajJwN1xluFe3+wuRQAcva0Qls72bCS1l+cPYKkRNTC51 GOFmN76nIAClBlgRh5r1R3vVFe48sKm6/2KAeXs77uERnS7i+KPb3RNz9FKATrEv3pqDMxlwIhk P7y5RJtmO9bxtm4tZHHRGndWBVO0RlPmypEvlpea46wR1K2BPPOz7etJ8ngpKys0XgIWbsaSDJl
 vvxa9Z8gBrOmF4+VxKha9R5bywfxemxxUA+rcAlrioUqMiSmH0pPxeVu3uOcGXwutYKzrSTy
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68793c4f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=AUTNjgK7JwJGzwcG7FQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: U3IFyOrkqyQZtzhdch99w7gRKpsDZluy

On Thu, Jul 17, 2025 at 01:52:07PM +0200, David Hildenbrand wrote:
> Let's convert to vmf_insert_folio_pmd().
>
> There is a theoretical change in behavior: in the unlikely case there is
> already something mapped, we'll now still call trace_dax_pmd_load_hole()
> and return VM_FAULT_NOPAGE.
>
> Previously, we would have returned VM_FAULT_FALLBACK, and the caller
> would have zapped the PMD to try a PTE fault.
>
> However, that behavior was different to other PTE+PMD faults, when there
> would already be something mapped, and it's not even clear if it could
> be triggered.
>
> Assuming the huge zero folio is already mapped, all good, no need to
> fallback to PTEs.
>
> Assuming there is already a leaf page table ... the behavior would be
> just like when trying to insert a PMD mapping a folio through
> dax_fault_iter()->vmf_insert_folio_pmd().
>
> Assuming there is already something else mapped as PMD? It sounds like
> a BUG, and the behavior would be just like when trying to insert a PMD
> mapping a folio through dax_fault_iter()->vmf_insert_folio_pmd().
>
> So, it sounds reasonable to not handle huge zero folios differently
> to inserting PMDs mapping folios when there already is something mapped.

Sounds reasonable.

>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I've carefully checked through this and am happy that this is right. This is a
really nice cleanup :)

So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/dax.c | 47 ++++++++++-------------------------------------
>  1 file changed, 10 insertions(+), 37 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 4229513806bea..ae90706674a3f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1375,51 +1375,24 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  		const struct iomap_iter *iter, void **entry)
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	unsigned long pmd_addr = vmf->address & PMD_MASK;
> -	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = mapping->host;
> -	pgtable_t pgtable = NULL;
>  	struct folio *zero_folio;
> -	spinlock_t *ptl;
> -	pmd_t pmd_entry;
> -	unsigned long pfn;
> +	vm_fault_t ret;
>
>  	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
>
> -	if (unlikely(!zero_folio))
> -		goto fallback;
> -
> -	pfn = page_to_pfn(&zero_folio->page);
> -	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
> -				  DAX_PMD | DAX_ZERO_PAGE);
> -
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
> -	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> -	if (!pmd_none(*(vmf->pmd))) {
> -		spin_unlock(ptl);
> -		goto fallback;
> +	if (unlikely(!zero_folio)) {
> +		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> +		return VM_FAULT_FALLBACK;
>  	}
>
> -	if (pgtable) {
> -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		mm_inc_nr_ptes(vma->vm_mm);
> -	}
> -	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
> -	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> -	spin_unlock(ptl);
> -	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_NOPAGE;
> +	*entry = dax_insert_entry(xas, vmf, iter, *entry, folio_pfn(zero_folio),
> +				  DAX_PMD | DAX_ZERO_PAGE);
>
> -fallback:
> -	if (pgtable)
> -		pte_free(vma->vm_mm, pgtable);
> -	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_FALLBACK;
> +	ret = vmf_insert_folio_pmd(vmf, zero_folio, false);
> +	if (ret == VM_FAULT_NOPAGE)
> +		trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> +	return ret;
>  }
>  #else
>  static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> --
> 2.50.1
>

