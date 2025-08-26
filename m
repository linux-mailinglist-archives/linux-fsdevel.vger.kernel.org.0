Return-Path: <linux-fsdevel+bounces-59159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0272B35347
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6829E3B10C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2D2ED84A;
	Tue, 26 Aug 2025 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MN2U7dYD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eU1AdqZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570A2ED164;
	Tue, 26 Aug 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186007; cv=fail; b=JFFW2NhdYo9GKJo3hNhwb88ti7h0OaAsy2Gq+8tc6sDvK+tsjdAt6PWQq5CnJmj9MDBnGWvYd20/2cKlUikM6SCBfGyyYg6Uv/gysvn4shAtmkxYCgrFxw5XErdPvcGtlnswFGNVxwjaxFp49IznYdtQAhb6KWK1q4/1rAViIJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186007; c=relaxed/simple;
	bh=xBfppUcYvDt36LF8OdXxY+ysOhUI0sa29Il2vcjTI5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=joSsjZGZFs4E/rlFWFmlnfCCfbXmMm4fkFIYQbuMRegpImBIPd7LqFEr0clTPKqggVJYFK5DQ59xC+2DafSB+C3yQQIpVVAXc4e6o/4W8EOntHI7LJR45wnRwC0LNEUsxipW7kjQzkI4Ty7a4ffu/zqwZBGoRPhU7Xdbbx/jrko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MN2U7dYD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eU1AdqZE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q32aCV020052;
	Tue, 26 Aug 2025 05:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vel8oNyOvO1AThqNzm
	0oD3U2ao4nt7bMAEj6wH8VeCo=; b=MN2U7dYDIkGnX5zpgk4JWB+EHZX5mXVfoJ
	Xz6dliaXVIDXlQaO6unrdnZV3PAouzDlg1hO1LUxFQDaul+ndGk11lidx2LfOitX
	dfcgtFrW4UFX658YgWzjGETVYhPbijEwNq18P7NjGMG7j58JMG4MWZ7yO0rnnY1Q
	izqpMNlf+Rkhc4N1hzB2ydGMxuze2EiNRVppADtqjrtRAuiv25ULB2B4rVefIfiM
	ta8GETxO51wr4y3fV1DiHkpJVl0TCmDmp3r0NbpHH2ukyI2dBCHIPh+Go6IBzTPr
	CNEGaEF3w/QHo1UooXWkFUToIOr12N0zWBbt5fduKv6iF9YIxisA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t3gh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 05:25:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q46Ijf005024;
	Tue, 26 Aug 2025 05:25:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439911y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 05:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNqh44ppN8hBVHP4hTGaAqzfNEM6NSEgAzRljzG9KraSzoiLICYKz2yGuUYorJmacqlMumD/ywt1LRNfLZpnsVp3G97j6f0GojLnkDMP5nHHiJ9GHmxKt5GDmlRfvn+qZAQr1uPk3CjDIJ2sNs9fMwbUK42Q8WJx8J4owiP/6Ndb+K+kkRPVp2FPedt2+anR7gXMT4+8E3IG6UN7w7C5lP6sB0AfvTHIwnl9PM8FCmwHWUDLygc4E6t+yewXk2UtAj0Ox5VAupYKd4GBtj81hN4AHEbJyfuXZX4C3d56szxofbLINLRBCpSRH7MgzoRjYSzeJHuhJtXeYr8Qsic5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vel8oNyOvO1AThqNzm0oD3U2ao4nt7bMAEj6wH8VeCo=;
 b=CDURQt3PEEiv/6ge8UUyC81A0u4mHt7ctLZLEw5ZQwrfABLKCX4qaEwPjYwta6BAtwPwAjGPtSdSjtqDzk/dSvARZ/GAvH8ptb8cLuTfge5drll+jIbqIlbpZIsgcNuYlmEL5iGZSEPf8uba1j5z0Ytuu14kFyuMbXNMrX9vgIXVZJ8lltJWGMPR2Ux8bpTn4dhotL5vRsbk3dc7Yopexd6oHYeuFqb4i1O7sAPkZ60gqjQV4X8/mgeuSUXfgWj0BzThzI9Hg+f1dpdRnCLSeX2J1TKowjfb0mtxO+Hp3gO8Mj7+bRVvWtwGQTWVKs4W3AjcuDvWEkIC9p0SQ4fqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vel8oNyOvO1AThqNzm0oD3U2ao4nt7bMAEj6wH8VeCo=;
 b=eU1AdqZEsyMez0RhJ+5wiW1YXMKwmaH1/KYafAPzgL2EPY39SlfSm1Sarp6EGyGl5zVk4/cSLBC5f4IF1qnN+QozQ4iCm9AnIIM0xnJ1/1s3v8AAuJy+t0s9tNXY8GKNPOKRiRNqLB0KPxUZCnu6x0MQgaZJJ9zV0sZcMloi15U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF6A2C0CCA1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:25:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 05:25:32 +0000
Date: Tue, 26 Aug 2025 06:25:27 +0100
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
Subject: Re: [PATCH v3 08/11] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
Message-ID: <9ad69d4f-69b7-4998-9639-4e8f679a2d9d@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-9-david@redhat.com>
 <923b279c-de33-44dd-a923-2959afad8626@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923b279c-de33-44dd-a923-2959afad8626@redhat.com>
X-ClientProxiedBy: MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF6A2C0CCA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd7c327-1663-42c1-1010-08dde460fa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gCPB7wfPttl2fyFzUxsLqFDQCmusK3YYA+5MoDnIOe3CxxoQa81hHdDpShE?=
 =?us-ascii?Q?/M5MxssTrL0nooiiahgRwvSGNFFfJiZd1iSm1pOdHMzA/tMvwGToKN0od217?=
 =?us-ascii?Q?nwelXR1CsFaNsIXyFOGo+b3VnJu0cBOnTI2AdkD6qz6Fm8oaNwU5DFYlqeut?=
 =?us-ascii?Q?8S7/TtQa/jMn4lDTtYXIWq7Py7yZqTMYsHSaVlwIIxD7RoARL8t721yGRdiB?=
 =?us-ascii?Q?oaImAOqEnrIYUFIPfGW6h03Sx83suTRwtUdlVyS7Md6d9kow7eSHHbdrhSte?=
 =?us-ascii?Q?/IbD+cuNl62Nr3RxOrg57/4u75Qm2CNxE1+HtuuUCqUjYMBCZ0USmQ+GL/I0?=
 =?us-ascii?Q?eckogydF5XXOeIy3mUDIdNG77k8Bo06bcn2kYMzw0f0P7m/Wb19Fj8zhyxFt?=
 =?us-ascii?Q?NvQeaX8y1S8nYmm+35OLZwhAvnOMGItGxg1L47yqebMdcrhuopsHnVH+i65K?=
 =?us-ascii?Q?TpiZJeVHYSU5emLkvF1eine0oBd4Ze6xmo1DuD8hjmamlwaLRF74Od3C7WNV?=
 =?us-ascii?Q?PqoJtt8gML3JkfiTAlPZJTIJUPS6hpHLE528oAYFdysvP2TGPijO5OSd9MTr?=
 =?us-ascii?Q?NUvHvKswQCBC/aLpKFuwOhzBONDV5aE04j5nj4YLgd801SwcnngmY4SJ3qt/?=
 =?us-ascii?Q?rgsq/eyOWtAGwsVROYPD2SYmgHclj+Cls38F/GZUe1fnQYu4b+OiGphWu2OL?=
 =?us-ascii?Q?Ci7zdwDS9CjKTpeucsTTt0dM1A9L/MVi7jQ9RMLtVhkDMTEMYtqeyBATR/gz?=
 =?us-ascii?Q?k7vAmIZfRvajoI5axTfXpUDZ/BG4wc7+kmdEVbRT0yjj5AiE/2CClbhxNMRU?=
 =?us-ascii?Q?ab8BhkJgm3V++s1+FHH+d8MWCC1tzak8k61YngXe2cDehEjVIdJO6aMekk0g?=
 =?us-ascii?Q?oY+4VzoIVIgjcxtpmcJwKoOcFEqY+EH6jST6+NKUnfnpGS5yps+IEfE442Ki?=
 =?us-ascii?Q?ZYUcwkCmaDQjhvWF3TaC/FQAfNYskgUS9rQQ18lDMIqcZE0mIy8eGeNvjgqB?=
 =?us-ascii?Q?+jd+fsImwkR/y3GKFDlwVkD+nnAI7OI/utZUGAFDUQi7/+qEHw7/Fi1lzkVb?=
 =?us-ascii?Q?VRVIVvxCEeQsPhhqXNaGFiuhPJMHRyEiQJ5YeHPiKzVzqc3uM+ZResun6bmq?=
 =?us-ascii?Q?HvxCRqP/cO/JQWlwzL87/5lQ9RhGrTU0h3G+nHmZDrfQxMUdyAMovtbJK/mK?=
 =?us-ascii?Q?k6FX/lNH5Qs/A8aVPBZpGDUNhrx21FdRrb44Z9YJu8OCPOOOio52ZYwbmWDo?=
 =?us-ascii?Q?+KJGt6e3T6KF0dJHLgopgfZg1LXgev+1qFAycXgcER0i2CvhW7aTGLx4IcI0?=
 =?us-ascii?Q?PTEZadS+HYgcWqNiFBw8WvOujhN5McH0FCiYES7Yul4yHcA2ZGkM2o+iGk2h?=
 =?us-ascii?Q?0RQ69hykqHAtCsWKqRLGhl1A7ff0l9L4iP7pNusrThgmtGR51A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLkVBv97j0z2VIJFADwwACSdrZOxzNCKOn7BFx+E53zTzkixDPLxN7e8AJrG?=
 =?us-ascii?Q?46pamtfm/0dSqypTHEZf5Uj8ySNh8JbbYpRAS6eTk5p3NxewkVI5Xh8DYVxG?=
 =?us-ascii?Q?mqCq8HKbytp6EyWrYNdDFu4E92fWJMGbqI+3CfCz+1hCfKn0bV5UKV4L77ok?=
 =?us-ascii?Q?KRgw8mlKxtpsf4KWgljK1dD9e2RalsdJXNCJxKdiOZvQR7qJw0hRBNLcyVS6?=
 =?us-ascii?Q?hO3ClzoFhsbyIQMQcIzbnpnoSdMLATPWgqrvC3MKakHlIbMIcuO3BHAvn3Z5?=
 =?us-ascii?Q?iNYcxbQLFXl3xUUt497/lsSHarLa/PnXQN1aioURYtYt4LW57yRA8JP/rlvW?=
 =?us-ascii?Q?GlQmtfANlQZU5YOOdkJWOutvMPZ5142e3atyz7xcd7RH4aCM+atUGHyXB5jT?=
 =?us-ascii?Q?luF9EkbNHkdqHVK8suIqt/loNTGxfslN0E5iGviNX/wNsZ4OMJD7g9eAE64j?=
 =?us-ascii?Q?NLdAy1ChLbNFpzrii8ZNc8lfgAR94PV/UYQZi3ZtKVhG8xLGz/EKDML27Ax0?=
 =?us-ascii?Q?pKBm5mpg6WJV7Y2Sz+aLWCAYo6g9Hnir61u84zJ3IO3l1ZZmGfRHA0Zv71GA?=
 =?us-ascii?Q?LVr0+ex1qKQSceKv2Jxs6uZQs+oFcfShmzWT9e/Z2jImIGPoEPjJqcEASTwd?=
 =?us-ascii?Q?YeqnHJsiyC87vqD9AdHZ7x0v/109CGQKKi8vZaxAoRH2Vin6uvlUpMwPnTKU?=
 =?us-ascii?Q?54wBcuNeGbLKh8CbshvxS7f1IN2IcqI0W7aGwg3LvsAb42a+qgoPrjLQEzmN?=
 =?us-ascii?Q?Sa+WRbzcEAXYbfQJ+a/vUJ1k9wvPNcUb5WhBDMtRic57sZYK5WT4/hvXKOzk?=
 =?us-ascii?Q?4q9wpOFLuRiyZejBXUPqC5aDl9/PP6dP9MXPaQBDwV75tOcQ6rsY0LNokuvJ?=
 =?us-ascii?Q?UwWaNJVQupxE90tObf9XSulTdfncCOB+KBQVpYvTui7t9S32YY6xtCsXyKIL?=
 =?us-ascii?Q?7/OBF35W+FZT+Iw2fSIgD5t30qa3MpcNM4MyzfEmNZqop/PhZbu+ntWT/m0l?=
 =?us-ascii?Q?5HG4dTxHFQvIFWVr1dg3aAwSsRCI7LAb3O0vet9KZCpJzgros30HBbzEhObE?=
 =?us-ascii?Q?vXPovShcKJ6qMpO1y8pqpshBfjnbF/++wyIQqDPxvjrUKHY6vXgaqOZRLqNb?=
 =?us-ascii?Q?vXf0oE8rJy0yASZI0YmNoUi/yMTMAIBVkAL1tPEY7POmQn48mYtshIIA7kIm?=
 =?us-ascii?Q?KkqRyzG1Nvq+0OJ1AZKxBkCYsvbFtSTM6Rwb8KEGyBFgxwZ2yweoZKJ+R1kn?=
 =?us-ascii?Q?dadt+Yfjt4rDzzap2/c06V255ylga/u2ZqgafqNJh7IdH2x642xJZpEJ37Rr?=
 =?us-ascii?Q?vUX022P9SZZ0z/CK1vWxPVAU5TA3PeVYl5HTX06HDhYIvQF2AiSW93b9UxCC?=
 =?us-ascii?Q?6Rc7QAMNw6akAig9yvT9VcJa0IL2SXhiYhPyp/NinTh2v4RIgSbWCUFTSZ1Z?=
 =?us-ascii?Q?yb6FJHQhCd9cKVsnlmtrrw+WMbPNJ4iZsYuLVCOgnu0MpDgVzvxXX7mYxKP0?=
 =?us-ascii?Q?UHbJD5XxE1OikEHLVK54OY48J55h9NsJL2T/zXfpOEPySB904JEDCoDo82gc?=
 =?us-ascii?Q?3BgWSNeNP/OoQTdvO47iikkIbY0eHPunIMmU4+ZbDDuK4MwygQo3w0YUVfEq?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WauXxZH2ODbyo7kO5C050ZM+b+EntlqzdGC7LmSdvpMwhwmZYDW9UsitBeFLfknZIVst5/0nC1TQsvCBgxcCkzAGz52kIl1G3Im5Ypl8yRHtxYBUguqOumPzGBwgUOWz2GKUIEdxeELhvfC/2nIHfqi8vTpgBIewF8sS1eIFNvXNUqyr2bmfPyx9gFwDqe9DA7SVccCqq8PRaWUjd5u1h8D36NF5de51cGsaBCpGpWb2z1Vxoz3xbPU6uvBMceJ/24obatLEspRhnM7oxNKfM1lI0lQYDdIYLBXVJpM0bP+Ln0Nsu+8zfL18NuFhUhjUVjGX+HJV+iMjhB60JkLLNHyrh1nAX5e//ZXG+Si5fWPhSuE7X33QhMUg+ArzCfs06AzAo5WsimMriyjxqsp+zKJPJREl2AVd5e0xwKqgcNNr1rqIxQj8L27dnmkCJpm4fOnyK8aclLAGk+IpQMmKsu1rufaS33iyQG6pk/R54PnuP4aQkevyxyxfsD9AlcRqO0vgB0EP5oWmlSFPjYfzV+mAA+lSxFNrRd7f/DtOQ3e7ZkGwphBHwalVdf4sEEpWuAvv6CAKL5EGUS5pBuragPB9JBIRURpADrwKuEHIb5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd7c327-1663-42c1-1010-08dde460fa72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:25:32.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX9LEStoGpIY5pSwPrl1a2B0guOoXOszxxYN7ebDItmrnITDWhLry6kv8fH/G8Sb4MuOqgR2C8WKHZXdWKG7zH+07IvtjPLdwNzAVrdjhhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6A2C0CCA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX3S3OAvTgs1se
 ICIx1k+JpHiUk/hDSK6YHfxaqVCLX8l+6yeLurDm3fftk/zGWsy+yRT1Qyw5PT5SuJZxVs+j2Ym
 aOVrTq74IYthO6XIqYTNJnEiW95lPaRpZbjwmMjr/+HRSk2pe6/u5dL7kKihzB04cVOdEyC57VY
 FWZi9oUxlTo2lW0Ef+q7naVW1VaH7e2z4Ny5IhO+SqAj02a3r3lPgoi+t1TZXZ+ziz44PaTGXR9
 OcpFeA40BXPW7h005DfLIrLi3GfaAVtuXt+kCHbZNPVIzKcKZ6aRcoBtJr8oDjg7iRKCmqo0V6m
 av5fMcgPJRyX4BDT5ZyvMlhNVuL0q7I0Gcpi3ALZdTi6ycUU7dX4bxlWbE7EXX71rcmHhZUQlEW
 KcJ71Y7v
X-Proofpoint-ORIG-GUID: b_wT2ChkV3roPJ_4cMWLcFcgvB7ftvTv
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68ad4553 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=7_9BownVNW7tUeIFdskA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: b_wT2ChkV3roPJ_4cMWLcFcgvB7ftvTv

On Mon, Aug 25, 2025 at 02:31:00PM +0200, David Hildenbrand wrote:
> On 11.08.25 13:26, David Hildenbrand wrote:
> > print_bad_pte() looks like something that should actually be a WARN
> > or similar, but historically it apparently has proven to be useful to
> > detect corruption of page tables even on production systems -- report
> > the issue and keep the system running to make it easier to actually detect
> > what is going wrong (e.g., multiple such messages might shed a light).
> >
> > As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
> > to take care of print_bad_pte() as well.
> >
> > Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
> > implementation and renaming the function to print_bad_page_map().
> > Provide print_bad_pte() as a simple wrapper.
> >
> > Document the implicit locking requirements for the page table re-walk.
> >
> > To make the function a bit more readable, factor out the ratelimit check
> > into is_bad_page_map_ratelimited() and place the printing of page
> > table content into __print_bad_page_map_pgtable(). We'll now dump
> > information from each level in a single line, and just stop the table
> > walk once we hit something that is not a present page table.
> >
> > The report will now look something like (dumping pgd to pmd values):
> >
> > [   77.943408] BUG: Bad page map in process XXX  pte:80000001233f5867
> > [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> > [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
> >
> > Not using pgdp_get(), because that does not work properly on some arm
> > configs where pgd_t is an array. Note that we are dumping all levels
> > even when levels are folded for simplicity.
> >
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >   include/linux/pgtable.h |  19 ++++++++
> >   mm/memory.c             | 104 ++++++++++++++++++++++++++++++++--------
> >   2 files changed, 103 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index bff5c4241bf2e..33c84b38b7ec6 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1966,6 +1966,25 @@ enum pgtable_level {
> >   	PGTABLE_LEVEL_PGD,
> >   };
> > +static inline const char *pgtable_level_to_str(enum pgtable_level level)
> > +{
> > +	switch (level) {
> > +	case PGTABLE_LEVEL_PTE:
> > +		return "pte";
> > +	case PGTABLE_LEVEL_PMD:
> > +		return "pmd";
> > +	case PGTABLE_LEVEL_PUD:
> > +		return "pud";
> > +	case PGTABLE_LEVEL_P4D:
> > +		return "p4d";
> > +	case PGTABLE_LEVEL_PGD:
> > +		return "pgd";
> > +	default:
> > +		VM_WARN_ON_ONCE(1);
> > +		return "unknown";
> > +	}
> > +}
>
> One kernel config doesn't like the VM_WARN_ON_ONCE here, and I don't think we
> really need it. @Andrew can you squash:

Out of interest do you know why this is happening? xtensa right? Does
xtensa not like CONFIG_DEBUG_VM?

