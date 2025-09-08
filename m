Return-Path: <linux-fsdevel+bounces-60564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38EB493AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AA64C0398
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47030DD11;
	Mon,  8 Sep 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XByJjYp3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ULoCx6Rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB01A262A;
	Mon,  8 Sep 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345790; cv=fail; b=CDCPPZ4QJ0UzvtWHUsOK6k+shJtgxjDTLdvNwsqe5kcJVzRzD9nCgq7zE6uIv5faTyhBNHgIoUuklW3DREZwQyNXR6mjjtPfpuwwztZ75TsvWYkefKjpOacj9PIrBtY0uKyzjG8tfNTGH2+J2RZHAwzvHwsVdP5Y6LA6RyC9OvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345790; c=relaxed/simple;
	bh=Ndc4kzhRkcXd26uQSZUPijZIACimQnXGl0ElXf/AspM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NCms5/xqe6rgWYFzfsjxtQHoWy0aRfItQftN48nZYv987dmhpz0nR7WH/tSluvkKNoZmae6Xw//H9NjFjg4gnbsMJEdw5xMg+5D280APK1MyGsxlTVkHHaEuCxKULfj8NbS3fXqpb3DrBLV6gITx4wK3rF7dsN4UObMEyTQWQDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XByJjYp3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ULoCx6Rz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588ExRv3029121;
	Mon, 8 Sep 2025 15:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ikXNTcHVvEsKk9Nx7i
	tjKZwYDa5C6eOkm48i0GwcJWg=; b=XByJjYp3zJHje9A/OqSbzBJkQpLqpZQnTo
	/+kxKFq7bxucCjkio+4cDvo9ESQDIrkEqulknx1q7Scs8+qKDKbZLscRMUh6VF2k
	JggQo7QlIqQtnwD6nFBUPljlst1wVWKXjWquK+BoaPa0+FbFa3mL9M+CizOAhQp2
	Q/TVwg7V41zSJGJvUHQGHrkCuT2XFFlAAuXceevlG3OLUh0kblvj+7v1JB0NPI7v
	lkeR87m8DEOMo5UYdQaEREeCFlzJusTsyB2A0+Ef/d/UkNhAXUkCgIoYgZcAvtyS
	2WzN00QZCYnVdDFhvywvSLzCR2FsritGbjGTUrEr2BE3vXnrY00A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921cyr3wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:35:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588F8k1G031517;
	Mon, 8 Sep 2025 15:35:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9cgy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHBbEHWDRXDlIoSqpnteufLSCkwUkAYab6r7Cexxm9kwPw92eE8a7t55dl3gy8gdJtmNbRATTWEwEIm0H4yYOvi+3s2XMRFYX5fjYL+Uyit1R9ah3S09W9U6ymt5ImOacSNSihp/9hvCI50bKkvk5jJyAe0e6nw8bsLHMAHqm1P6zr/74BabVz/gGPnckYE7vrl7u9wmUeHtcCIWM4ggUaz1UDMybKJWEaorI0N5uLT/6/K9M7MefzH14V7xeH82NL9QllPN6CD/IHmT6PpOyLmajcvbdLTBgtsLvZdiOX6nb06LIIvWmcPgk9093RVur7nvnX+0lQiurSaYuQ7B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikXNTcHVvEsKk9Nx7itjKZwYDa5C6eOkm48i0GwcJWg=;
 b=dyyCxNwvSXbI1Ibj2BWMHNG30RHcvO4O6qcA6ohw2CZkhreF693Ezp07ou1MYDtmxSs54cOk5vzOeFoxXlWU9mzJrhutdYxwf81VlAwfNqnLtcTzD6H3kEMEVVA+tDKE8F0m2E4dwkroBOMOOoQjsLU6qVDnE7GFS3+v+edHDbCVpwnLgd+ga9o6/Q9qrr43CuM1cuykHp3C7xet8LIaNDxvcOvUzJIV0zf6ZoFEjVCsTakJ3fvhsexQT4jYKTDJG1we8wia1urMejYSOnJqwj6N2oLohea265j5OrSBw56WG2PkOlGzSJ+7L7HhNi1oTCVisFABOiE5zgEBlMCIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikXNTcHVvEsKk9Nx7itjKZwYDa5C6eOkm48i0GwcJWg=;
 b=ULoCx6RzZ3K+EF4fS4irrxBkPaswfFF7pcaGE18qHXs1s1rSoUzOJyYNOUnLUxUdPDCnuoMOo3ABqOV+4d5Q2eMN7XlcaQo1HPyLVxT4C2dKoWHu+01J4BPeq3Ulnf7rdmxyTJhIja0Qq0Rwy2tCC+oA7nPQy4ap1vYsi5IKA/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF6AE862AC6.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:35:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:35:43 +0000
Date: Mon, 8 Sep 2025 16:35:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF6AE862AC6:EE_
X-MS-Office365-Filtering-Correlation-Id: f7514a03-7358-4c7e-07be-08ddeeed5f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yL1ka4/gQuzP8ybRUKqDqbOj1YEhmZ+TIuMIXYUw8dICxc7MsMcQ+PsTR6m2?=
 =?us-ascii?Q?OFslpoNTc5INwqUSzRWvP87osrbZB6wLK90CUr0XW8d2rRffDJo54q9MhiFu?=
 =?us-ascii?Q?zY7PCp+b6TDdP7O/AbuCJcYC+eP8PhGhkPnPJOBjVFEOXiQRyMq1rH3+ZVpw?=
 =?us-ascii?Q?Z+7/ZqJc+rflTFO3dF08HPJfxROvftwrhpRimanegI8JJxJvxHUqBtj6On4L?=
 =?us-ascii?Q?kBJfeFSn60Ja+ZO+BLhW6Vy8vsRg1GvoL+llKNbu7i9FDlhxx1zXNlv/Fr3p?=
 =?us-ascii?Q?GJGVLVgh+Kf0WUV2/zua8wrEt9T6rTWd5HIYWXbDJdioo6dZUE75QsypKfWv?=
 =?us-ascii?Q?xOaPXU/FPwSRZPXucms2nEX+DYlzNpCDCkJ2mWE5x1HXdxkG0Q95DSJfEmtp?=
 =?us-ascii?Q?2J8EwOfD2QgWHEqA2Jh/Ji03VuKGMP4Y14qSqoKzAiq7Bt25V/6qttYpbyNp?=
 =?us-ascii?Q?d12L7SnGdkSMaY77LZ8F8OIv3MvHgWhN4QHNrU0ToWOZ2B+gSOxHCUNA6MG3?=
 =?us-ascii?Q?5dAObCabs/wOe0CDK6/xxkOKvO2CJ9BI+Fnj6HR6us+aIUi16e1sVqvDr3B+?=
 =?us-ascii?Q?3iW+2IgQKRW60bV52J9ufgKyeFeiiihAZv+pLAmJkCbBSp75dpHVkgDanREc?=
 =?us-ascii?Q?enI6MsvmVmg+jAxZInoqvrsNl19Xd6baUG5VGf6Gn0PvuZMRmiocZnz2Y7jT?=
 =?us-ascii?Q?4CwVp9hFILIkKTdz3RWMFnbAJDo6oPtbs8YuFFHIArUZ3JT8fHoi1u4t88iD?=
 =?us-ascii?Q?Loh3ybJLthFviJwg0ToWHWYCKOt8tDlNguxN+Cgid5g4vFdNQCKHcW0D7ZNe?=
 =?us-ascii?Q?B8YC+6b/EdlVCUWxBidq+3nupD5T8QQUt+g6PdGnlgiNLiDhNtEBkWF/Vtkk?=
 =?us-ascii?Q?7tAfuVuZY3g0HCN29IowVxOT8/aizYi52QMkN4IrXjQW+dR4aWp0DCl90uty?=
 =?us-ascii?Q?2TEd3A9eruR+BdAyt2pP/1BRF3RsnFENB3PD7v1kpDMqQSgQLQ/dp5Vc3t5P?=
 =?us-ascii?Q?yECjpI7tpBMEgtvrpryg9YV8i4jxZ5knSZtSPYq86CDBsav8OtJGR3XL6GBR?=
 =?us-ascii?Q?S5kQ/v5TYP+JK3i6wphfZqXEohDCyVWCZHk+n4+KOU5saMni4XpzaHTGHZAG?=
 =?us-ascii?Q?JYptQCE3LCkKFG1tCh1EkqzTwXZcC8J2vzAdd9T5rFU92mosaTfAwZESptTf?=
 =?us-ascii?Q?J80KKuCY9Re2z98dqeRpwTHe399cr3YiDAPYrtfPOxD+7VM3aqvO+0HRwKgQ?=
 =?us-ascii?Q?ygCxTu2yWzCg1Ibr/s7yCDenM9m3f38kkx6xpY9c9gIBQaGpTeNFq5Rbhvp8?=
 =?us-ascii?Q?n+OH+y50oIfVCFGE7NiPmYZU8MZoLWJhcj+UB4DLZjYesmRJE2FAsSG75K85?=
 =?us-ascii?Q?lzdsEThLUcTLMFjU3/m1HE353fVYGrqsrXTuA+3FBVYzlhtzJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYSddy6dVi205aRXrTDNF/WhoAmRWti9HwQSrWWiN7PJ1wc2J2WlHQtZ1sfQ?=
 =?us-ascii?Q?mZcn3ovJSjUPT3lQo7DJ300gbt8JhurIyzTqz2TPQ+tNqBmkGA4uws+LrUEq?=
 =?us-ascii?Q?42kwOnWuFR+aiahf30q59JO3E07wd96YYzpl6bc5rzwb3eIeBcFLDmHUTCxC?=
 =?us-ascii?Q?yWV2yPjZBmBWn3qY4KuHZ/68Qy+3U0hyEhDPlHVdbgd0UCao49YEz7aMrcbN?=
 =?us-ascii?Q?p14jPCsOD6hteBTH7aD/7Mt9B0YVoNae60kAt/J+9gFLEBvfajIc0thq4Ogg?=
 =?us-ascii?Q?rdzlta73SLdOCdnboIkgKLmC6Gg7Vq+0z+89uTtTlHsgPVmeVc5s6f5LLgMP?=
 =?us-ascii?Q?u/Bom+QC1eUDFZPmHauKzU6of/+i9cHivTMMsh35B2LLMWbfXMj+TSx93tjJ?=
 =?us-ascii?Q?/pmiY8fbgstK1j6Yq0OrOtQ9PNBLiVcEdc3fdGdLvc+uqjHkOOO4bOWTQ1ji?=
 =?us-ascii?Q?7qY25U0SmYSn8VHiSgBB/lngyk/JlFdzSf9thxPYcrqIa86OeXK9/nd0sE2S?=
 =?us-ascii?Q?Ia3y8n8z9H/swWC0ajGN+oAQMor1JcFlZ6zeQqICOkoFrQAdMUKpiooGP2h2?=
 =?us-ascii?Q?aZx+Vlw/aenf5peaT2x0ozHhI0s8rWMJH/MdynmG6BDRwKbcuGUHvIy/R0ib?=
 =?us-ascii?Q?3T30kWBgzQbdRm6RVAP+BX1ijgIxa+cRq8O6Jnht1npkqdPC/vOYxtesFgLv?=
 =?us-ascii?Q?FNXI5KSVfusDZpyE6bXCVizD9J2xLwaDCjbCL9KrY+dS9PdVTQ7Lv9VuGcdH?=
 =?us-ascii?Q?7YWNyOp/q7a3qTOBLF6bsyt5m22pLFeUVXNFOuiisjKhHa3xgjkuV9sICMiZ?=
 =?us-ascii?Q?1cqDo1nJplJK/Njt/jjO/MsxQFzvr1y0x5Wo+i9k8NDOFmyKIgiNV6uStMTy?=
 =?us-ascii?Q?siykF8ClM4wEwLKyBTF1XK8QO1MxZoBDv+Bb2yJDE31vZF+9h9Dbbfl+EQlf?=
 =?us-ascii?Q?MXZqAFIEw3q7rYmP3rRlPdnVCs7AY4hKKARZkIIiZNd1XmMwcY2ZtyrYny0I?=
 =?us-ascii?Q?d7xvQ37gIKh7ebY6ECOW/UNK65ifpWqv6axwH88qqe68lxUp5rS+QE6YBdqz?=
 =?us-ascii?Q?N30iBc4mG4+6csrqohOevPYwWqwUsv2FqLW4J7ea6rSOqskecjqdeB3lWIy4?=
 =?us-ascii?Q?La/ctO9ofMaRumrgWIY1oH/NxFGEQ8u0nQFGpOz72EM7vC1W99Suhc3onQh6?=
 =?us-ascii?Q?s49EmiqO/yA0dB4XpfMvixogi3ztnLfFoUU6Bwogh+J/ZpwmFeKqTAxOFuAJ?=
 =?us-ascii?Q?QHCexPkESuy7dtn4RpPf354//ZjiaoBbrbV44oXOOfQEgXb6vnTkztIC96o3?=
 =?us-ascii?Q?ZjnmNgO89Mm3PXk6K8CIOEX9cclEcRM/uvpVpwF3TbmfunSSz2aLRwetzbWu?=
 =?us-ascii?Q?hZatW9U285YMAogFeXRSJStIa4V9s/hSw5V6FIO3Y1nW1qgbYikOhrNlWdWP?=
 =?us-ascii?Q?UoMcFNuIy5GC2SXyz+rYGoZ2fubVsSBhnISIq/AlaQWPiG+U3KHKr9DBX0GE?=
 =?us-ascii?Q?MFXtgpwk+Bnmrxe5XpsRmIhkBtDlOpk3oFYSi09l7WK3ivOzhEBgzfhtEfU5?=
 =?us-ascii?Q?qw//3YVA5WhanpE4VisTMwfol1bGtf8VTDiNy2SdQUMyBKUwOJdL2dX948E/?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ntzJ8QECYTW8rHec1TGwc15G9JqLJJtxCV9RQEk4S6tRSJPgWepD3zUsYLpIqx/gxjfxGXNKHFcnN0Q+aoRork7KNqq7+I2Oygtsh41PYhsR6WvO1EPAjz9UQUIheqmc0VY7oy9Wp7BSGatspyS5BBwZzeVb8gmOfUQc0+06NrLXzI6IlF+jbjpdiHM4WeC2D08tD54FueQfWUnxDySOjwHqPiQ351+D9nQb++0K06/XFRJzMDT3r4eAO4rK9V3zLXfnLA12z9h588yp1j1TuwBmCHCsD3bM+dLQxr0TBANr82Tf1R5AlTWUFk3NVBGGScgAzjNfbQb2Ynlz7ReCuxC4POD6jIBbAvlJATqAKwdOx5oENXpSSEfhxaWvxdfql0y+Wupe7EnGf7/RskYCpW3qu8jJw84wLpbFdownBSeK3zq0755SEaRlKncAExZ7c5e+1M9iMnaYAWkBEVJWheM8EF94elRQimC26GP7lzbRYDVNWbbnV/hk7v7xYztLf4XQwxHP2RDZEg/mPYS0RSTykY6Wn941WGkBi9zDzXRTeMHWCXe2aUH70cT8wHZ3JYIouPSsUVQgc7Av9Y2cKIqD3ccsg7pbICkuorYq6Ko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7514a03-7358-4c7e-07be-08ddeeed5f84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:35:43.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RIKeTEWzlWc3qT/K/qRyt3reHwfcc5QmCAfj19dnp0f8PeeTTMPctw9z5dsmuh0BmNWJowVjsFDhnGqZB6onQXeXUdUyxAZummoYmOcQf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6AE862AC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=966 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080154
X-Proofpoint-GUID: mQK-2BL7XaXpfIMGXgm31eaojlQfKBlC
X-Authority-Analysis: v=2.4 cv=BvmdwZX5 c=1 sm=1 tr=0 ts=68bef7d5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=D6T3AiggkppvC9Cbe2EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mQK-2BL7XaXpfIMGXgm31eaojlQfKBlC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXz41BAbc9Rx9g
 KrZkKvCxYGz5HC7mpBChsn6n96igklZpsm6KZtq5pDr/thnlKvdG4LZTLd9vVi827AufqSm3BZ+
 x+EsS3kR2BcbWns+qmg/yDDwXXysQ/Fob55bbaOTDcBEOjLTM5JI5wWPTb9DoPMMtOLINpQX0FS
 ddA5k3CcgtHUCjThzUzRfogcML1V8mnBsTH0CF4WHq97EXYl7ZxIAYV4Q7AovtOFkh+mlXaTJwb
 RB2Ui1DBhYd3wVuTVyoP7IyTvfPelsoOQ0ieAvQ9stbb23xwaOx/UNL9xSaZ+X5L5FAzHxjBdPD
 CViV1FYWPPMOHj1GVpICaOqZrHyi/A2P2SSScFmYWn01/v4YGVc/kNX4rNVeQRpHQs1wHmt6dJh
 a8kr6TYA

On Mon, Sep 08, 2025 at 05:07:57PM +0200, David Hildenbrand wrote:
> On 08.09.25 16:47, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
> > > > > Perhaps
> > > > >
> > > > > !vma_desc_cowable()
> > > > >
> > > > > Is what many drivers are really trying to assert.
> > > >
> > > > Well no, because:
> > > >
> > > > static inline bool is_cow_mapping(vm_flags_t flags)
> > > > {
> > > > 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> > > > }
> > > >
> > > > Read-only means !CoW.
> > >
> > > What drivers want when they check SHARED is to prevent COW. It is COW
> > > that causes problems for whatever the driver is doing, so calling the
> > > helper cowable and making the test actually right for is a good thing.
> > >
> > > COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
> > > something that is COW in future.
> >
> > But you can't do that if !VM_MAYWRITE.
> >
> > I mean probably the driver's just wrong and should use is_cow_mapping() tbh.
> >
> > >
> > > Drivers have commonly various things with VM_SHARED to establish !COW,
> > > but if that isn't actually right then lets fix it to be clear and
> > > correct.
> >
> > I think we need to be cautious of scope here :) I don't want to accidentally
> > break things this way.
> >
> > OK I think a sensible way forward - How about I add desc_is_cowable() or
> > vma_desc_cowable() and only set this if I'm confident it's correct?
>
> I'll note that the naming is bad.
>
> Why?
>
> Because the vma_desc is not cowable. The underlying mapping maybe is.

Right, but the vma_desc desribes a VMA being set up.

I mean is_cow_mapping(desc->vm_flags) isn't too egregious anyway, so maybe
just use that for that case?

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

