Return-Path: <linux-fsdevel+bounces-61940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3204B7FAA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA89D1899CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028C30AACA;
	Wed, 17 Sep 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="et9sWCdr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDTT178t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B519CC0C;
	Wed, 17 Sep 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117328; cv=fail; b=gD0lVTa4+xrQKcCC+CLHNN5fytLMOjgkbIuC1084CJ3X8OsOZKwWrIOgxJGkS1cv/eCaqG5PdYVYZsMB2baa1qp4hWZYPmVbG5iVpQeUH+U7OG0WtLJV9NNvVn1CkwL9QoZemWfWg91WzOtkBDWjvqyBx8NNw88Jpp8/xaY0/mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117328; c=relaxed/simple;
	bh=68Q3c8gppl5oxHllFWoV6u7SXl13qLhagGa3tTq7PYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADXUBNsl6ddvIXfBVeBGIBTduZY5+6CHibzTJEpHEnX6EHMKzCvUr7OcrhqgnZ1R1WMkQ0De6Ke9aHaKlWN0N7ryI/Ta/cm7E137yX+fzj8BJdVC8SzvyCkFc3q2zHhVVNnZ+WrTmgG4RMREmCLwplHexKTrHe9IpUTs1SROWs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=et9sWCdr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDTT178t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDg0op020903;
	Wed, 17 Sep 2025 13:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hHJ6VBioz1MO+Vxoxi
	NrBznpHElZFHXNpSNPXucuTrw=; b=et9sWCdrP1l4Hw7WB+ij8CPVocdBWaBuNc
	IHlOBMvW/uMS/ZZZXnEwJp8nyP+N7oOwXU9ISQURXyXq8OfLTKoNSyzV6F/2nfWz
	60T4vlj0qzAGtmW5s3VpwpbvH71z1T25qdyiADEF4Pu4DzQxJHa+7lIkAoUGJ1pf
	RSU+7Fx8Y85KH1i202zVhGwdxBk5Am8uQ7Uaqk83Y950bV6ZsHG6kB/5B0nckETU
	WW9SrHPLU0XsQ0wsuzPJ+jVbjeuENyMiCsfsoBr9YAW0+sglX7wyfDlWXCKSTOmn
	f8n+wE/VPBAtef1boC1S9UkSu8bz+l/vmOK38l6mtGx10ISm2nAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9sbuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:54:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDhoAX028863;
	Wed, 17 Sep 2025 13:54:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dshdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGINr6ixMwx3bq4YKz260r7EMat2TajwjO4222wxstGgxgeD4N0QLdQomkTe6X6AlKNzwwZLJx7yj1l774VE1OLLeizQrFmQ2KmWa0yzOv+a/Ya/tuTzmLEb3BjAM08+TUo2hsf4h4XMtgbAGwCnE49KYhq2KSXWwZzT2hMcPFGFw2Q3cn0Yet6BU5w7jup1M+JQmXeSQyerA1sSQrYyScopKhFu9xXku+70qb+OMoiQB8JT1iaVrL+tADB2Hk2qDBB5M2HofKoldNYP3xrW84KzRdKdZnIhBkxHgse2/QD/UI0uu21w6BZLsQ1XrU7FTiblZbx994o+9XxbvtWVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHJ6VBioz1MO+VxoxiNrBznpHElZFHXNpSNPXucuTrw=;
 b=zLv78ihTHYVkwmwWycMbNQhg3XkySWPMo5apyirMB+g8Yi4KO+B5BGTX9p4GNRXv4hiNRI8VPzvb5dKZvwsLETmtF5rFiUNvGYt+UGO9EZrhoXbFivA626AcdEitEqstXjN8SF4XXQCD7BpIhhBL9MgSxdGB/2Pe967JDdp1tPnq9/3JFXk2l086YLtd3G3z1v5BgcelFHVT1Sfbg2KFqcr1iSbYpwgVHKCB0NitvWmhhpfCxO0njuN2wXNzK62S0JG5s+GizNtgwYsl+I+ot4DiLT0QRAIlQI6Lk6ochutkJlqB/EBeyf4jZQjSh01tZNRcZbeS8PJ3pGh4JQpetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHJ6VBioz1MO+VxoxiNrBznpHElZFHXNpSNPXucuTrw=;
 b=DDTT178tW5sokCFgpAcDSa6NTEMQU4HnzQML1ik8l7dmA+ypBlqKfY6++LvrAyqrvEInqKwoL9OX8Ag+QvBIF8fEh1jx11I4hN4GNtnehChvNW6SIOftTNiSgIpDEPwajlu5O5eTcicxtql7G8TCRvRSRVaUkUF+3uwv9pB/k8E=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SN7PR10MB6572.namprd10.prod.outlook.com (2603:10b6:806:2ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:54:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:54:40 +0000
Date: Wed, 17 Sep 2025 14:54:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        kexec@lists.infradead.org, kasan-dev@googlegroups.com,
        Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 02/13] device/dax: update devdax to use mmap_prepare
Message-ID: <4a0fa339-56c7-4a6e-8d47-f683f6388132@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <bfd55a49b89ebbdf2266d77c1f8df9339a99b97a.1758031792.git.lorenzo.stoakes@oracle.com>
 <2jvm2x7krh7bkt43goiufksuxntncu2hxx67jos3i7zwj63jhh@rw47665pa25y>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2jvm2x7krh7bkt43goiufksuxntncu2hxx67jos3i7zwj63jhh@rw47665pa25y>
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SN7PR10MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 11844ae4-4448-4a19-b82c-08ddf5f1bf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ue/X8IlKv2ESluN3MFNJ6xyeMLFHrQaKCCwYtlR+ALLmeLLq4W7qLd4ARUyC?=
 =?us-ascii?Q?b2NHmbSeeyJBf74jPjEftFEn+Z4l2H4Rxqcu5ySuxC+Vi5Bk2clDJsAEEOCa?=
 =?us-ascii?Q?GAUyvtrVr1RgcIaJBGX5CKgDkltIoZS9Syu3uEznKOuGzwmudeaXQv+kV1Oo?=
 =?us-ascii?Q?H2jn76/29ldlDr26NguXxq3p7huimU7X6X3YgGXa8vBVtdoVxIWzXuuN4/Bx?=
 =?us-ascii?Q?hLXBplcGghhfo0SU9ZvdgyZgell9C7ut2mYxbgQ46XBGY04iSshorSDZiw/C?=
 =?us-ascii?Q?LzOQ4C7PB6DpVHCe2rch0f4eTOOj4wQSTeiBguJfhawOLHDJaitkv9a/Gttu?=
 =?us-ascii?Q?wUoBdlhZ6RxGo0BqUYBRIq4qo3Yh/cqFEBb3mPBbDk8xbZOCy2mUtcE0Mrpw?=
 =?us-ascii?Q?qlNcr0/XOAvJE0746+aEHoYJqa0j7gT/Ky8IGxCno5YQ1ynmdL9eJrOXBlhm?=
 =?us-ascii?Q?5NRqzCGZ192X5ZLhqZbSk64WXDc0JdsR1PIs+Wp+W0NZqvPDzHyL3rQhUza7?=
 =?us-ascii?Q?H/Lm09c86Rks/uNToF/HNEpv50tGQVsN0ENqUO/vrbKN3Rh9QR8rGdic/unH?=
 =?us-ascii?Q?1KaPXyXHxalBPouAw/myAuHYqjAB96A4bNfxvGzSVW6UNo2SlNEsE9+ZbCue?=
 =?us-ascii?Q?g3LW2hAPR+gsyNo747Zu9jiDCSMc+IVYoilMpNMVkdsRqpeCznLYVpV+N/eh?=
 =?us-ascii?Q?W5VeaHdjQWFdlvUMXVRAsPBeN6cG4+T6NWQeVPL4loMO6Yn18HG9+R/cjNr+?=
 =?us-ascii?Q?g+7LkWxaWlup08g9Q76Mq4vu6BFUAxG1K068FQNiDf7Sv0+W04/B9TrZpXr9?=
 =?us-ascii?Q?e3g/6Py0rXdKGuWAAUtNAUEfnfucFmakjb5eJdeb+G91My73xK5O+5Vs7bEU?=
 =?us-ascii?Q?9PqlgON3Yc5i/5IxFdTuHn+/hjHjgPIazdL6tE+YNn+HcotxUUAYf5GY/eZn?=
 =?us-ascii?Q?w0+yMpQx1mvJTLbCXtbvqCvyFStc9JJYw7Yw9nx/GlKhTJi12VlgUzTS3F0i?=
 =?us-ascii?Q?anV2ysNqg2KeytUL4jixoM38DJ0ndo08KChfT6qsaAk8Dx9/4eP2Skvz132U?=
 =?us-ascii?Q?gW8q65O5soFzDeyLVUcseiw7MOMCNk/14JBh76kvR8cmKDN8bt1C+XrSKGX1?=
 =?us-ascii?Q?4io8OMVihgNe/JVvuROiOyrO9nUKXXOeAauLVq25oxczLVyX1ckaNknL+RVq?=
 =?us-ascii?Q?GfPR0oc1hOvPprFSCM9pjswRd1Ko/wOychbFbojlVNGM7mCRXUOgJQA3gZ+r?=
 =?us-ascii?Q?uaYcMehWgzZjSyeacfKLc01znF8TQA23e7lbwo6+SUAAdY4vgR9fewyWiEFC?=
 =?us-ascii?Q?dCpQDFRws3wgtAuOObhhAwQ9Jxoq0dTkUghv/g3WjmK1BzSOJ99NAl+JUizR?=
 =?us-ascii?Q?yWtxGgLtO6RvcsSrt4Em3QC7kG/VUJYAiyj1QRnB7W67PKihDJt8n/+SXcQY?=
 =?us-ascii?Q?JYMGXrheg9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37G1svZM+o+0AidZsy7ayS791J8qD0SrQ4E5kWfflA5or4A6oKDACwBMmGOp?=
 =?us-ascii?Q?OpX+zq2k5ezjut0O5duUGY3aOe4iJ6rErGrykBuqZXKQcp2fOrAtuopWE5Yj?=
 =?us-ascii?Q?LUi4CqxfDgQzytJQi5u2TPTCC11bNVY9pTpFAQ2TGetf4KnaA2X8+Xzk1xiB?=
 =?us-ascii?Q?4sFBXmZ7cq17q1DmAdM59sgB0EHHHkWMjJnuaY9k3Gqb1p5AaW7g+TkzemGC?=
 =?us-ascii?Q?qRUzkYivLO5EW5jsQy5xFyXYpgGNGmy5pxecH0wL5q5a7XcqUPLxD/pq9vxU?=
 =?us-ascii?Q?0yNASvHMSINYR2KPXvwo4X+8hgSGyZvknaMngdPcEm5IwSWcreUYJfOwLUTO?=
 =?us-ascii?Q?jKEzdhWOhwhk0yT6pFx+wq/WDl/kKuf3h0i+0O6FzN9aNN9XxQc02rx/Ztma?=
 =?us-ascii?Q?I9O0JAlNrNB5aldjY3JP3u+UnwpFbvKQWfTZVPPaPYELOEOq5rPCC+ojK1Sv?=
 =?us-ascii?Q?LAE3M7y65IcpFIwmlLkWxiD5W+ty9ThOqRBSeBdNBmMIUIi/c6Q1J2j3i3+x?=
 =?us-ascii?Q?ygoDHpc5jnN/btKdLZx1CUj3+tk4+A+z0YAm1YR4CIJI6yuFDEYN6KIcS7Id?=
 =?us-ascii?Q?wR6d9YguT1HHdpm5RqPEh3OgWuwdPO6pDXrh2GAjqqeP9FQcei48zA9OkSnc?=
 =?us-ascii?Q?44a69/ipe3wLFLBbvRCiNWxBOld44ePbTohAGdmb7/WVq0AlQG9CMeyttWu5?=
 =?us-ascii?Q?8r77SKnaRkUDFpMjnHpLWmyKOHjYzqK3aq8USrAN84PeeyZI4AFDVPvbtpX9?=
 =?us-ascii?Q?rRbeG1XCQ3mwO29soGI/DEv1lr972EIiBSGNWCAhy2rNLJBLY0vip+l/ibAe?=
 =?us-ascii?Q?F3xTXDODq17dg1xp9ruIjBjZG4tFjqsX6O8KZHmP4FfqQZpshbZj5v3jD5/T?=
 =?us-ascii?Q?hmQUvAKzxpDID+95v08SuQk22UtkDqEdRVezZZpSrb6JZp9VigU/xDPcDlhU?=
 =?us-ascii?Q?25SWcyQ/VPKieF3MBBUJaMzvH8JRaYkdHk4A8jHITiKommZVsm9RkJQNXRA2?=
 =?us-ascii?Q?c2qGesoko5HSd3O1OhTFyk1CUAYx7E/X1OAlavArA0SE/26wm+Z7ghBmwAa5?=
 =?us-ascii?Q?JIs8AOISkhpttBJb6Qoa61MswDGxWyPmVo27HzBEp0zhzkZfVWLOrYwaLMMj?=
 =?us-ascii?Q?5V660vkZtlGiwBBbiO+vsC2+Z1XRm6sdA2/MMG0b+Yo/9QBr5aHizfbtJSwX?=
 =?us-ascii?Q?hzl1T7zTAAtgQztGG1z7ICIfaMtJRjcDMQnbjdnxUm6+5s34pdMNAbJJNh7z?=
 =?us-ascii?Q?sDDyB9GaEw4bSYznDQ/BQaUzoZUeLWA3/Tr0rtgr57HykxICIDucMccbnnAp?=
 =?us-ascii?Q?THJp6DThfRD90j/iqRsobOF7SuzUoDSPaF/f8wNkHGnnutdyH0cLGAnvUgmm?=
 =?us-ascii?Q?MvguOpmZYjcFLog6VgrxdyGrVr42YV2VH5vOnkd+MSopva7l/J6K3fvhHv3R?=
 =?us-ascii?Q?9sNG4znRWDvhCEs4Ii1q7ecm/N6h4IP9scvOu3I4iFTUjgXPP+1eHtUKEmd5?=
 =?us-ascii?Q?iQ38IoWZKESIFQdach+jCu0bT67oc60ZRfV6ZLle31dB+wjYcYxZThzE0Y3J?=
 =?us-ascii?Q?zPR276JRzAbmSoWH1S2WXOmPv79ms1TAkbgMExcchNZbllhq0rS/P8rx6h9i?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hxkaLiAnU9hkOGJJE2qIFrwZ296dYLnVMLR6ywxpGQ+AyjrSRd/BQydgloHnontVtjhVx8jCN+NCEABOc3kxy24f1ynE0C9obRMyEeQSf50sC4tLypHvrj03a/GVa10H7E7NSKb4sdjmh7NFaxKCX5ahJG/mwA8lGB+XGKiZYSsED01PVvEo98+ERHUesIWkklZw6yQsBBxpsb1sggd7VHHmycUgzwifUDbpBWA/9f2wLIokUevJZTPcI1OqYOHSWeMNiAkNQX+sb8u6VsFuecxK7fZ3IiBCChFi7xSGYEL6WzEcw7ySgafoyQ1gDoSh+RC9jXmLbtCSGwRv9B5KMGtZJjZ8MvxhDwjiU4dheTbgyQcKMRM+kzOmti267UcYm981FkzApy00nJ1gKkqZSLB/EciGar7R5dfp7FBunADx9nBps1+mggtbrzpMf1cgJa8DROceMC5qCIKFXTiOOobbwZ8g1Y8wprpSijtb3X26Y4SSSdu2uQyuRs7C6WgHTy0QnIoMnP81muqd4g+vFwGDa5hWSHj6v8CZAmXtcmk5LWZeqhrM2dbECx4jTMf4/toYoyHC7MbmVWVewhO8+daLcvjZ6qmP1Q4EWzHMtig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11844ae4-4448-4a19-b82c-08ddf5f1bf1a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:54:39.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VqUy15quXP9ZRhAoCoItLdKF0rvaPyo8vJGg5zrAwiUgvs5pUvYfJF7onWZnE19T2ZjSO2TLNxbs4ArlwOD5Iexm4UNffG5CqPKPUsJVNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170135
X-Proofpoint-ORIG-GUID: ZliNQQeCdJxqiycD26sV-MWbggyCDJKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXx0y7wwqYqLEJ
 Wr6qfVX+233tWzMCvRnBqKGrkc9SIL7dxkzr6QiIvgbhHL14z5X9K5MwCwHbHaWYfNeJ4IQPKsT
 Aqnxt7jZg0wirf2uqF8V7lHF7G/i1rjT6YO5pOOvo33s0ft2Ytj/K0lxtATP2LRanIprgf7bUEC
 oFQ/OhPCtlbehzqBrcwvBT6Q/+fQZkbsY07G7foEvGl0eszSUdmCyP9oPh/epPO82cBhyK/8us7
 VpU4zGWzJjiMTXWFC8dQ1Tov0pXvpIaDjpMzxSTgkTgwXFswTFH35BbjzmFMGogf0dZxBbtO7SH
 348YSNHyyNnTQnfDcd5L4AOZkXo7AFmF41GQuAm7AWCQNz+fhdACxesJo5XF1Qf9Hpog2rcIHCv
 FuGxd6NB
X-Proofpoint-GUID: ZliNQQeCdJxqiycD26sV-MWbggyCDJKw
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cabda5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=TYjx_FbPIwLi9LQ6WlsA:9 a=CjuIK1q_8ugA:10

On Wed, Sep 17, 2025 at 11:37:07AM +0100, Pedro Falcato wrote:
> On Tue, Sep 16, 2025 at 03:11:48PM +0100, Lorenzo Stoakes wrote:
> > The devdax driver does nothing special in its f_op->mmap hook, so
> > straightforwardly update it to use the mmap_prepare hook instead.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
>
> Acked-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> > ---
> >  drivers/dax/device.c | 32 +++++++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index 2bb40a6060af..c2181439f925 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -13,8 +13,9 @@
> >  #include "dax-private.h"
> >  #include "bus.h"
> >
> > -static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> > -		const char *func)
> > +static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
> > +		       unsigned long start, unsigned long end, struct file *file,
> > +		       const char *func)
> >  {
> >  	struct device *dev = &dev_dax->dev;
> >  	unsigned long mask;
> > @@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> >  		return -ENXIO;
> >
> >  	/* prevent private mappings from being established */
> > -	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> > +	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> >  		dev_info_ratelimited(dev,
> >  				"%s: %s: fail, attempted private mapping\n",
> >  				current->comm, func);
> > @@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> >  	}
> >
> >  	mask = dev_dax->align - 1;
> > -	if (vma->vm_start & mask || vma->vm_end & mask) {
> > +	if (start & mask || end & mask) {
> >  		dev_info_ratelimited(dev,
> >  				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
> > -				current->comm, func, vma->vm_start, vma->vm_end,
> > +				current->comm, func, start, end,
> >  				mask);
> >  		return -EINVAL;
> >  	}
> >
> > -	if (!vma_is_dax(vma)) {
> > +	if (!file_is_dax(file)) {
> >  		dev_info_ratelimited(dev,
> >  				"%s: %s: fail, vma is not DAX capable\n",
> >  				current->comm, func);
> > @@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> >  	return 0;
> >  }
> >
> > +static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> > +		     const char *func)
> > +{
> > +	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
> > +			   vma->vm_file, func);
> > +}
> > +
>
> Side comment: I'm no DAX expert at all, but this check_vma() thing looks... smelly?
> Besides the !dax_alive() check, I don't see the need to recheck vma limits at
> every ->huge_fault() call. Even taking mremap() into account,
> ->get_unmapped_area() should Do The Right Thing, no?

Let's keep this out of the series though please, am only humbly converting ->
mmap_prepare, this series isn't about solving the problems of every mmap caller
:)

>
> --
> Pedro

Thanks, Lorenzo

