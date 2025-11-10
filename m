Return-Path: <linux-fsdevel+bounces-67763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DCC498AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4BAC4F16AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B1341AD6;
	Mon, 10 Nov 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IFudrTzO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NTZ8zVvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35813337BA6;
	Mon, 10 Nov 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813459; cv=fail; b=ttCxfWSX6aoj3Va07bVX6ZnBjdpAaFwKzBsbgj+vcjudxM+WFdrgPrFMDKAAxUNwPLCwpWR+0Ahf9DeloTQw7FvNG6x+QU+wRU7Hu9gs/ZRMtzy79zwLhBp45dLewbWJs8BIvfxeVvC0G/1jYcQhTz0cx0W9xMq5+PJqN19Gl6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813459; c=relaxed/simple;
	bh=T68qemNrU9aXNg9BwcHhuUskC8JepUns48gZSOBTgIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsFUjnLHwEh7yoLb4dWa9ZyVb5o5EM2kklDHTz0ZUG+gKtO+LsE+s6kPfmCTrPoM4Usuyt2kJqvEc49jMjji7XOyQOPl4UXQrARR1+2K1xLMbwlEg6NRpfzpJdnmVm5wLnnJ6NdhMYtu2wGLgMimBxuZ14uVQMPZ1seCyS0XvGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IFudrTzO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NTZ8zVvx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL8hmP009313;
	Mon, 10 Nov 2025 22:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=; b=
	IFudrTzOO+hppA+LjraInZ7zQ97TLrUBezN/8ShnlXnecLP8kvAwE+TyFCNli+Pw
	RTC2Zs42I/ACdUS6xbQSosJh2qN8oi+TyPI0YKl8/KPSeO+1rXjXONFMHwQWKSpm
	iiZ9GT0FhPDAAKJv/RyyvUsGenBl0124/rlC72pDtxh/ou8trY2DvUKYr/ZBAa7K
	byKwy81tyuP7QkgHlRplyTKPGVMGNtu78mqsT3Over9wMD2pGXQqIqo2ohJ02UBS
	D44qw9Ox0kCPsy+TCMkbgsynl7xaRNBHU5wIFjO4cf52eLR1ulofr7uNgXsiDd90
	K7tMWV7N+y4/3x9bik8dRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpug5ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL8Wxn012637;
	Mon, 10 Nov 2025 22:21:48 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vac8sq7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1XOQVn/GIpJWuiyP7pD2Q/i7FuS5BF/mKA5S3pCJNOL0SkxsDAB2HXeu9LkoNY7DZQHgXr2AtDV+2KH0Z/o8++WXt3mvzW1MDcpQuPrm7O4K8H8VHDdtRtv0HkmCkQOXg1HDYgq00vWQcAnmbLPrJ3u5GXC9K/CN0JHbk+Ob0ARiiIO/rL43MInUYnWprnW+rQuX4pRZgPbB/nJ3iVe17eR6n4gnXrDv0dRS2zNBrwe+Yyo5E+pOqa/v1XkGygrEIKBhZ1pzvFSx+j9Eba6HLevs59nN3Y9/7WlRZfSCs8eCA/+l3h9m0gj6Ru2l/HMWAQmppwAOUoeJk0BrK0mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=;
 b=f+NxEZ8fqd1tV9LvT3rXM7aF6tzHFwR48dIkhQR6L8iWOBQW2wFwiwnR6/Rjb+l7GBuRr/h/CPxb2mheS1rec9r1g/l3NKzzjMp1Se0NKt684PmEIEAisIvXoVRdRosWz/U5dF68xB8/G3+G2xuoAjMwIE8OLkhYsYl+pKiQ+evg2+I6xwlapQksOz8QCV8L0+q9jM4hy0YZA0PkxbVpUXVDhkhzai9jYAJ65ouyb8lbEGQIB7vkI4qY7mn6USVQti2yBKqsAeX4zFXoel8usVrG/m1A5mUxf/X5r6k0kXyJXB4IFhGjx/lqH3hNtcVwElHU6+R/7SeQjU4qcDnLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=;
 b=NTZ8zVvx4sYo3cVCuHrErKCiMUT1twVR1SL6gdGQPj6+tQTl1kg/Hd4g/OCLbSO0NMsjAooCiy6dQvZOnsWrOMxoqadjFTBChUeCDUpSu3Nc5TQzIsvtQhGZoPm/36BN+hwmobH1EZ95A2mi66WkayUO9hx3xdXn9/qmOEb+gHc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH v3 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Mon, 10 Nov 2025 22:21:21 +0000
Message-ID: <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7ab494-5256-4354-8a85-08de20a7878c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ztwg7vIpxGWz4ZdCpAeDrPTVfl+5VT8htDKDKnB0G8lUvCtc9mnc7PfBSViQ?=
 =?us-ascii?Q?01ww2bDJ+ayjccG6Qw3HewvTlADwrTHfdD0zkswFmhiyT9xxkaJTrAUA7IBU?=
 =?us-ascii?Q?Z0ZNxsYO/heGVxVi6pW2cdYXjOuL7GImUW3RmU2ABwr8jC/T1fS+sPUwzhUr?=
 =?us-ascii?Q?Fli+EQ4SQSIjIrhVOzdO3au1KZpWx0Sgs9gnYOcBVBTcRyKTJVmmCxrdrT7M?=
 =?us-ascii?Q?7oKBYHOEZ/I4WWjhFrxEcLUEOd0ml8kEOvras29DClvEjE/d+peLKHTev3c2?=
 =?us-ascii?Q?YXQctnOGADUvaARC/B//0eXdvm2eT00z5uKym75neciWrep7ze2h1khWrEL+?=
 =?us-ascii?Q?a9rpfnxR5fuLHHe6i2AaHdH/cHbL2+BbRZUwB8pp0Vsr8Yl9AyK2umYp1qMa?=
 =?us-ascii?Q?zXpSUimzWSUubeQa/GFBQJJ4PQwcmCE7VuTUbDWsSb4cPP8qHXb4AWREA/pb?=
 =?us-ascii?Q?IXzMtjJ5Na8mh/gUNrs2YVnc8vCDPLiUP8eOwyIcEpMN6T1Ez0XC3XwG1BP/?=
 =?us-ascii?Q?mtnL3rKLR9/FLHYcoL7myPlMZFOd1zPGPryFgRfxg66CdBSr+NsH49FmWZ/c?=
 =?us-ascii?Q?+U4K01yHQkS3nSTtyGZueMuFEJ/xpOSyJb6Lnq0S4smlsryep4tYChWHleSH?=
 =?us-ascii?Q?Ac9MwCHcHn05psHWlHPdXW2EU84WW3hpYURPpKGkd8ncwTR+LeNVOaiciXYF?=
 =?us-ascii?Q?cnvw6reMXJCLFoRVaAzT1ZEwNbWcDnEXQEb2BddCbEU2AdnpJ4hJlk1DUfy8?=
 =?us-ascii?Q?7NZxoOXAerGRHvA12DivwPQSX/2ocVLBctDvvBnjfOrr2dWer4qebdCdj2rX?=
 =?us-ascii?Q?isjY0Fr5AJVHlkxYuAI8e5yNBedLsllzfGnTAcmt/KuRYtWJlaJx9TizGm58?=
 =?us-ascii?Q?q+Yn4/h9zXrHV9rDQVJEs9PpJlAy+VUrZj/hTttpYJSFb94+DRhGEBmcIEPA?=
 =?us-ascii?Q?riw+6aZ0P/fQ41yNgVppG8MtBSg6MIk2L/cUwXnmJsBzf2KrvElfFZnQhNzN?=
 =?us-ascii?Q?triWfW2uvo5BL++lJe/hdFy2kJ4fovAHMftJWiJ7t+eqwNY0n3VU0FCo7mQE?=
 =?us-ascii?Q?GA+eJMd85gqn1p7RF/wFiqqttgdSBJuVfsNLyX5HANFhvYB5tcCfoZrVTg0Q?=
 =?us-ascii?Q?/p8VKyrx3WgKFEK5RgEkTlH0DHhKflTbjs24BpacX9MKWa2EsDJzBJQ0ArGi?=
 =?us-ascii?Q?tAT3I6C2CVpdWeiK4tKDuGqsnn8Iuq35sW/atp45LUvpXtMFAMtybaNkZmwa?=
 =?us-ascii?Q?QXzOKAHYjTM0KwsFPj2Hq1aznb07n8mm6hJhcwjyIBtByqXpSqe+yAKjM+Sr?=
 =?us-ascii?Q?Lhtn1hkfml7fTqIO8JBr0Tj7yPk0eQ3PyfgVvk8/LQLglyhPJ07zuQemVKCw?=
 =?us-ascii?Q?0saaSNndhhMFtphjDXuLqQ7OnVecq/4R2+1tB58d3JeH9Ah5C0F/eKoRtxr2?=
 =?us-ascii?Q?NDU5XH7UcT76oAY84mCJwestjO6PzCPQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OGC8Vavjvpncuh2ZhCGTHS+XVtuIWK61bC08dfhvo2MhfmomfQMv2kzLeVF/?=
 =?us-ascii?Q?YTuJLXfIscZgw433mQjbaGOQpfyPaKj3E6kCu5gVPl8wUNLKr0x/yhObpVDo?=
 =?us-ascii?Q?2v61FksTHasxZunTknYm/j1UqtLSa9pkClrZJjwr9hNaVPrBicYHMh0sqqb0?=
 =?us-ascii?Q?pid9og2rymJtLmg68DK1CjmkHGuW0mRh1ForXHetzNtgTRphCQ2BLFNar4ow?=
 =?us-ascii?Q?6QbnC71JuRmQKfr9dq3UgW7UBTvq5e6v1fUUo3obCIwesQN3LLvLtkIvHE0i?=
 =?us-ascii?Q?3DJFjldvkbcweD+Ec0a4WyHjm48W7KekmlZozEx5DMBHDwIPiC0DQfLxcorg?=
 =?us-ascii?Q?1/2FTXgh9EAj2NQqAG4VNtzncoInNKhDhYtKUJkfKhyx+GifNejJBHCGSYf9?=
 =?us-ascii?Q?J9i/W7/QF+85I3kM5Q+mOU+wKJF8p6oCYBYziynRBCyvIxIA6pM4yZgGURqb?=
 =?us-ascii?Q?JAsPVDK9MNwE8+tUIWnbF5ta2OH1SBsbxFxtRjdHvxMJDELDGELJkIPsXYuR?=
 =?us-ascii?Q?tan5KBeoDneIxLL/NMBPFqgmy1WWe6y1gP1OG3BlDSOF+VJG6Who74ihJtw2?=
 =?us-ascii?Q?IDYTLM2DeXRRR5qsS2lI077/vO4fP9Y0t5PqWoju/gNKkOarH3XkDOvYOxUV?=
 =?us-ascii?Q?YopcYRP3jzEjqMsg1jDsrBXBXXNCnHUHjF+ShdeL1PvAQm4N/zUd7gu7pl1A?=
 =?us-ascii?Q?5JZoBJ7o9xAi967zxsxgRVaPusew5rU5Jrzc4HvP+nA0ByzwbXwbBtT9Ddw3?=
 =?us-ascii?Q?2jPMEn0KWcn/YnE0pB+pT+Nc2nAtez6FlEBbohhCUWLEjto/RM9k4NW+Yaoe?=
 =?us-ascii?Q?Xk9WAoPCqsT3Ob+dG1Rko28XtRlQKoVVcaMmZcsA6rgpwUvuDI3uWpJNgXs6?=
 =?us-ascii?Q?5yddI/6Vn/SZfpWld5oVGqM+Y+/M20hCptCsduygyrfoUFpT0h0SSRV8tBSw?=
 =?us-ascii?Q?ltyrh8SKvNzPvKBDeEQYCYm/2UJJDsqXaditzQG5lmBjIduSHUIZeh/Zx3G9?=
 =?us-ascii?Q?GV9jgiRlb9oJo5oMDA16HOnPxdaj04L8jQMVC5nOQ7P062frXNLdgt0Pgfbd?=
 =?us-ascii?Q?KIP2VV2c06Zr/+CLTPvQTDJ9M5zrA9FmwR/TLyCw+IAWz0TPGQ29KtHwjUEh?=
 =?us-ascii?Q?VXXSjK/dRZjiFgvEDlmbkHBZXlQylPNQBWcu6z+RI9vL4Dh8N9SZo8W1ZxQD?=
 =?us-ascii?Q?1XyZ1rpol8LhkYheUHTu1szSXwCRaDTx2WX5u9uJeRrSUPPj2+RAjlgqWSLL?=
 =?us-ascii?Q?zjGVwMHftyUPOjKPQhXREJ40yo/HbJXcB8xsEGnnzm1xYAt9mNFAFrsVcNuC?=
 =?us-ascii?Q?v0xOmiQeh0U9Dapv96r8T5MZF056arpFVnGIZyzYql2tqU5QcWDxffNWZWWn?=
 =?us-ascii?Q?UumFMA9CKPyB1FlYSOQ9cuzFIUM6RwOmRtPchfZTlq6233kX6692oA2emLqA?=
 =?us-ascii?Q?ec7g8EnBKpZuW3gUavdLl8NlFyC41RgVufdZPTYyDPwVBk8XADj1roGtui7K?=
 =?us-ascii?Q?B55PCjYlHFQg0NAmyFjXsVAN1bKF+FsPKGLromnNFl0zUyPtdZvyaQ0Tb4oH?=
 =?us-ascii?Q?xfShORIOr3+aenPbx2FqHsdqPnNF6WBqQDmGBXcL67G252oubsRT35VGBeoz?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EVky+rKXSMgX6LVljAeq+xD7AK1h3xfxz8sDDDTk/AUD6PX0GYOheVgxTK0CP3JOx6IqAQVOMVjQyAkoiaWL9EVaRxyVT7hA5SAPpk+DidYYLHNArP/PV1QkD89Nn8t6pDI0gaqbFBxHfgYib0LOtwWnM8WqoNduI/A6yT0gPC4RMjxvQCuzomht4NfZhK3NMq79PzT5OG4nQHRtVWf1v2G4fD2G5e1jIvJOYEdzHxPOeuMlnSoRa5vPlQYSSRAcmF1AU58++a27NKHyEQ3jPfpzVYUQBs/CjI4kh55/xlv5z8iH80yLUDGcIMNrCG8krwk3VK/dxfIj8742SyZPm4SwEcYjj64DF+E4hpXkd1lj13MWFJaOhVb1h+VKxTzrOxH7KF0He3hXKhi3wBGGz9OHP2dT0fRWmyHCx6XMiQLWKu3cF77JXQcKFWmEOSYPvliMULfmRvTqlmNvJiXEQ50hjL1AUZs17Iw+WmutytDpW8Dpwuf3WbGw6F1sWRwQ6jA/p4eZVAEfot777UeNaspKwTeXlHj0S0+IdZ857dtdE64NvTBe7opeAtRASz6gVTx+/c/WznC6tWFqFOpFN4J8nQ5ubD3UqEWD++IAAoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7ab494-5256-4354-8a85-08de20a7878c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:44.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjS2tF6VKyKW/RTZ/T39Dq1I1BcrWm9bp9ypKoUXbLEgoEY4h2/J0D5t1Hj0yljVCPhGpAg/pUnMcuSG/cuOGcSxSiRdM2HBnMGvmIt9ZiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX2vgdA1HuF8UP
 mdn/USE6yqSXesFmcRSlc3CWupQy6ndMlnv/t5O7VBjSombWqyMVbBepZ/LJ4nuylDBp/Oe8AzH
 /tDNEOgljosh7RtPXVc2poGLq6Y0MIFmJknTeKwFc6WfZ+Kv45g2vHE3ANQD+RXJK4ZA51JpPM8
 7+oQ9cyJBbmDI+tokAJLupu2QSbDykS17qxqKYgtDoJyc4DjI2X/5ADCOc/cWvjWz67sGRxhETr
 I60o/sghrHDhbVHnnyQnLynvkYGXl2FBpkhbSlJn0a0j9qJ1h0p4FNo12hfLAhq3a+vaMFErH3g
 5aKvRcMPv6vjhva9BbFH+C9ROBfjAtNhzfCgzSgf84hGwrJfAg16vmoF8pTYVtz5i4e8TNzfkrm
 lNF3BmFDRcyb2IsrKr+7Ek+3cTHjPkigkGlZepQuo3yjZIN6I9w=
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=6912657e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=360PBzQsUBXz8B3xgqMA:9 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: DhBPEGfWLUdPm6e88BTve8SJ9KafYEr8
X-Proofpoint-GUID: DhBPEGfWLUdPm6e88BTve8SJ9KafYEr8

There's an established convention in the kernel that we treat PTEs as
containing swap entries (and the unfortunately named non-swap swap entries)
should they be neither empty (i.e. pte_none() evaluating true) nor present
(i.e. pte_present() evaluating true).

However, there is some inconsistency in how this is applied, as we also
have the is_swap_pte() helper which explicitly performs this check:

	/* check whether a pte points to a swap entry */
	static inline int is_swap_pte(pte_t pte)
	{
		return !pte_none(pte) && !pte_present(pte);
	}

As this represents a predicate, and it's logical to assume that in order to
establish that a PTE entry can correctly be manipulated as a swap/non-swap
entry, this predicate seems as if it must first be checked.

But we instead, we far more often utilise the established convention of
checking pte_none() / pte_present() before operating on entries as if they
were swap/non-swap.

This patch works towards correcting this inconsistency by removing all uses
of is_swap_pte() where we are already in a position where we perform
pte_none()/pte_present() checks anyway or otherwise it is clearly logical
to do so.

We also take advantage of the fact that pte_swp_uffd_wp() is only set on
swap entries.

Additionally, update comments referencing to is_swap_pte() and
non_swap_entry().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  3 +--
 mm/hugetlb.c                  |  6 ++---
 mm/internal.h                 |  6 ++---
 mm/khugepaged.c               | 29 +++++++++++----------
 mm/migrate.c                  |  2 +-
 mm/mprotect.c                 | 43 ++++++++++++++----------------
 mm/mremap.c                   |  7 +++--
 mm/page_table_check.c         | 13 ++++++----
 mm/page_vma_mapped.c          | 31 +++++++++++-----------
 10 files changed, 104 insertions(+), 85 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 24d26b49d870..ddbf177ecc45 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1017,7 +1017,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_none(ptent)) {
+		smaps_pte_hole_lookup(addr, walk);
+	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (!non_swap_entry(swpent)) {
@@ -1038,9 +1040,6 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 				present = true;
 			page = pfn_swap_entry_to_page(swpent);
 		}
-	} else {
-		smaps_pte_hole_lookup(addr, walk);
-		return;
 	}
 
 	if (!page)
@@ -1611,6 +1610,9 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 */
 	pte_t ptent = ptep_get(pte);
 
+	if (pte_none(ptent))
+		return;
+
 	if (pte_present(ptent)) {
 		pte_t old_pte;
 
@@ -1620,7 +1622,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1923,6 +1925,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	struct page *page = NULL;
 	struct folio *folio;
 
+	if (pte_none(pte))
+		goto out;
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1932,8 +1937,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		swp_entry_t entry;
+
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
@@ -1941,6 +1947,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		entry = pte_to_swp_entry(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
+
 			/*
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
@@ -1969,6 +1976,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
+
+out:
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
@@ -2310,12 +2319,16 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 					   struct vm_area_struct *vma,
 					   unsigned long addr, pte_t pte)
 {
-	unsigned long categories = 0;
+	unsigned long categories;
+
+	if (pte_none(pte))
+		return 0;
 
 	if (pte_present(pte)) {
 		struct page *page;
 
-		categories |= PAGE_IS_PRESENT;
+		categories = PAGE_IS_PRESENT;
+
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2329,10 +2342,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		softleaf_t entry;
 
-		categories |= PAGE_IS_SWAPPED;
+		categories = PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2360,12 +2374,12 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		old_pte = ptep_modify_prot_start(vma, addr, pte);
 		ptent = pte_mkuffd_wp(old_pte);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_mkuffd_wp(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
-	} else {
+	} else if (pte_none(ptent)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	} else {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
 
@@ -2434,6 +2448,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pte_none(pte))
+		return categories;
+
 	/*
 	 * According to pagemap_hugetlb_range(), file-backed HugeTLB
 	 * page cannot be swapped. So PAGE_IS_FILE is not checked for
@@ -2441,6 +2458,7 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	 */
 	if (pte_present(pte)) {
 		categories |= PAGE_IS_PRESENT;
+
 		if (!huge_pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (!PageAnon(pte_page(pte)))
@@ -2449,8 +2467,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		categories |= PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (pte_swp_soft_dirty(pte))
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 983c860a00f1..96b089dff4ef 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -441,9 +441,8 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
+	if (pte_present(pte))
 		return false;
-
 	if (pte_swp_uffd_wp(pte))
 		return true;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a05edefec1ca..a74cde267c2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5798,13 +5798,13 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
+	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	else {
+	} else {
 		if (need_clear_uffd_wp) {
 			if (pte_present(pte))
 				pte = huge_pte_clear_uffd_wp(pte);
-			else if (is_swap_pte(pte))
+			else
 				pte = pte_swp_clear_uffd_wp(pte);
 		}
 		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
diff --git a/mm/internal.h b/mm/internal.h
index 116a1ba85e66..9465129367a4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,8 +325,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry
  * @delta: The direction and the offset we are moving; forward if delta
  *	 is positive; backward if delta is negative
  *
@@ -352,8 +351,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 /**
  * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry.
  *
  * Increments the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f6ed1072ed6e..a97ff7bcb232 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		}
 
 		vmf.orig_pte = ptep_get_lockless(pte);
-		if (!is_swap_pte(vmf.orig_pte))
+		if (pte_none(vmf.orig_pte) ||
+		    pte_present(vmf.orig_pte))
 			continue;
 
 		vmf.pte = pte;
@@ -1276,7 +1277,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none_or_zero(pteval)) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		}
+		if (!pte_present(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1296,18 +1309,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
diff --git a/mm/migrate.c b/mm/migrate.c
index ceee354ef215..862b2e261cf9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,7 +492,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	pte = ptep_get(ptep);
 	pte_unmap(ptep);
 
-	if (!is_swap_pte(pte))
+	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0bae241eb7aa..a3e360a8cdec 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -297,7 +297,26 @@ static long change_pte_range(struct mmu_gather *tlb,
 				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
 					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
 			pages += nr_ptes;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_none(oldpte)) {
+			/*
+			 * Nobody plays with any none ptes besides
+			 * userfaultfd when applying the protections.
+			 */
+			if (likely(!uffd_wp))
+				continue;
+
+			if (userfaultfd_wp_use_markers(vma)) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
+		} else  {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
@@ -358,28 +377,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
-		} else {
-			/* It must be an none page, or what else?.. */
-			WARN_ON_ONCE(!pte_none(oldpte));
-
-			/*
-			 * Nobody plays with any none ptes besides
-			 * userfaultfd when applying the protections.
-			 */
-			if (likely(!uffd_wp))
-				continue;
-
-			if (userfaultfd_wp_use_markers(vma)) {
-				/*
-				 * For file-backed mem, we need to be able to
-				 * wr-protect a none pte, because even if the
-				 * pte is none, the page/swap cache could
-				 * exist.  Doing that by install a marker.
-				 */
-				set_pte_at(vma->vm_mm, addr, pte,
-					   make_pte_marker(PTE_MARKER_UFFD_WP));
-				pages++;
-			}
 		}
 	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mremap.c b/mm/mremap.c
index 7c21b2ad13f6..62b6827abacf 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -158,6 +158,9 @@ static void drop_rmap_locks(struct vm_area_struct *vma)
 
 static pte_t move_soft_dirty_pte(pte_t pte)
 {
+	if (pte_none(pte))
+		return pte;
+
 	/*
 	 * Set soft dirty bit so we can notice
 	 * in userspace the ptes were moved.
@@ -165,7 +168,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
@@ -294,7 +297,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			if (need_clear_uffd_wp) {
 				if (pte_present(pte))
 					pte = pte_clear_uffd_wp(pte);
-				else if (is_swap_pte(pte))
+				else
 					pte = pte_swp_clear_uffd_wp(pte);
 			}
 			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4eeca782b888..43f75d2f7c36 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -185,12 +185,15 @@ static inline bool swap_cached_writable(swp_entry_t entry)
 	       is_writable_migration_entry(entry);
 }
 
-static inline void page_table_check_pte_flags(pte_t pte)
+static void page_table_check_pte_flags(pte_t pte)
 {
-	if (pte_present(pte) && pte_uffd_wp(pte))
-		WARN_ON_ONCE(pte_write(pte));
-	else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
-		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
+	if (pte_present(pte)) {
+		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
+	} else if (pte_swp_uffd_wp(pte)) {
+		const swp_entry_t entry = pte_to_swp_entry(pte);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index be20468fb5a9..a4e23818f37f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		    spinlock_t **ptlp)
 {
+	bool is_migration;
 	pte_t ptent;
 
 	if (pvmw->flags & PVMW_SYNC) {
@@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		return !!pvmw->pte;
 	}
 
+	is_migration = pvmw->flags & PVMW_MIGRATION;
 again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
@@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 
 	ptent = ptep_get(pvmw->pte);
 
-	if (pvmw->flags & PVMW_MIGRATION) {
-		if (!is_swap_pte(ptent))
+	if (pte_none(ptent)) {
+		return false;
+	} else if (pte_present(ptent)) {
+		if (is_migration)
 			return false;
-	} else if (is_swap_pte(ptent)) {
+	} else if (!is_migration) {
 		swp_entry_t entry;
+
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
 		 *
@@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
-	} else if (!pte_present(ptent)) {
-		return false;
 	}
 	spin_lock(*ptlp);
 	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
@@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 			return false;
 
 		pfn = softleaf_to_pfn(entry);
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t entry;
+	} else if (pte_present(ptent)) {
+		pfn = pte_pfn(ptent);
+	} else {
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
-			return false;
-
-		pfn = swp_offset_pfn(entry);
-	} else {
-		if (!pte_present(ptent))
+		if (!softleaf_is_device_private(entry) &&
+		    !softleaf_is_device_exclusive(entry))
 			return false;
 
-		pfn = pte_pfn(ptent);
+		pfn = softleaf_to_pfn(entry);
 	}
 
 	if ((pfn + pte_nr - 1) < pvmw->pfn)
-- 
2.51.0


