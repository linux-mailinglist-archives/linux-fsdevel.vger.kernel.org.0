Return-Path: <linux-fsdevel+bounces-60530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2CB48FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703431C22500
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A930BB92;
	Mon,  8 Sep 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3qlpWmh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XV2pbl8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D485225A3B;
	Mon,  8 Sep 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338686; cv=fail; b=ANCB0wR+w46S10K3pwl6kLgRNa7lJxYzOlCtMOYVM1VbxG7fyoA+uZ8H6ST5tC1x+rNXU9megOnCoxvUTSENr9h5KHgtUfxN4nuRTusyfAkWX8eFYv8wUPLn+VQNGXecIlkxJTp9BYz9VXt0aUqp/G3Kh5Kw9iwcmB/L5wRNv9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338686; c=relaxed/simple;
	bh=56IIqXgg7uYRnAy1l1QiDuHXSaFcdlldk+8gVCpLZX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KS0hiq/fL+MrnYMmeUek0zPx/yf2OJhLNXILsDvLtf6aH65NhH6vWX/AJ0+PFVM0eFFedwCN9XkOlqFMg5uAGry9goic5rMq0l8mcRw60y2LpYlbtj8RHW/wuo8r0gj2UfaXMYLCrNDlWxSBb5ARS64IBQXtNaG5ehSC3+UbXUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3qlpWmh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XV2pbl8d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588D0lwx005677;
	Mon, 8 Sep 2025 13:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gwIxBqBclQv86/ati1
	fbZ0mVGj+PzEqvYDzaI6mk2fg=; b=i3qlpWmhTtZ6CglMusVL/XiQzQVRz3pACu
	miexsnydFh4cMU52XRc3XE65e1IEPvWeMI1Jgn/rtKM+ICvMa10rrs/NshRuP06g
	M4tl0aO398ruuXCtWRxVZYyAQ3oSGesFlfqpNt1xP+suGyE2FJ6dEn9o1tMdYk5z
	X3b5ybNi3f1XGJUoqhgVPnu5DOjV5zVkBD2mIrA+16xjDOq+pUX18JwJg+tiCS0k
	35f0iFg6nWhSEq5AbOe2+9ixT59M9q4iGMGuSsLyo9r0tuCCYBOwpz6T09gy5DWA
	TZFlN0BtnHKnD4NCM8PncfH2optRPrF2BYPfDRXBUV3CtamkwSEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491y4br50g-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:37:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588DGkof002759;
	Mon, 8 Sep 2025 13:19:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdepn38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd8q1BvVLrJIjZZkYkj5VetzTsU40c/eNENS17rSakvZG0cTdI64RfTkBxBph9Sn/HS3Ty17DCFFaw0DxV7j7Rhyc52jUjTdmKjOauJN+jYxGrznvGqy5cLhpUx6JTgLPJ9nZqzOL7GF17BOO6eCcxKut+RS7qM/nS+bp+Yfu5sUUNmtI7yBKJa3BaPtP5qWp27n/ug19MJcuK6Cb7/8hcYJcrTBbny1iGO+tR7Osoj40GqWc36hOk2MSTVFNRXrCvxcOl/M1RrQkPdw/tliUVOz0isRqZ/1XUEPa3aqi1bQjqFzyMB3OOxlg46dV7LIXXDMxo6I3mK/Eg1J1mCZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwIxBqBclQv86/ati1fbZ0mVGj+PzEqvYDzaI6mk2fg=;
 b=MvXfEuvgZXtto2o69gjEMhq2qy3IZEDT8CabjfPV8pDHqtVsFscae1e4hewldjZFj78XFWl1nu2XE/6eVAQoUIdX3mJTHIeIsekBB2mWVUWE65BZAfzaIbA2OLp9pFbXO5jGRVzLYat0yE1sd2/umYncDYZ68ikinPbJsI/DW7MKW6cPUe5ztmSIW/2ZTh7aUEF6bOv4reQQ7XFKMqwSRaquma0arTAJLyoll1rwJWLtuR41kaOF4NM129p/+YnoKbBVbjsQzGl4jnjcWFYel7hmTsf8Ev6BkNTgcCWApBrMwhGKawu6yWxGcaEW7n5QWwGYDjX3YZ5blVedB06aMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwIxBqBclQv86/ati1fbZ0mVGj+PzEqvYDzaI6mk2fg=;
 b=XV2pbl8dq3rmcHuMDQ9HA/n0D3loTMKtgzF0OGPcCZ/ThTp2tmuVK8bxyEfoFObGpZSqdDsl/idJl/a+XkBd685rpNbHPHoF+JWt+OEioWig5leIU5Uhj0Tb43AlZsTzmPLZhDCSIWStuEHZ1TgqhxTo2R1Whs5d7DAfdIA/9yc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:19:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:19:17 +0000
Date: Mon, 8 Sep 2025 14:19:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort
 hooks
Message-ID: <0df59b0c-dd8d-4087-9ddf-3659326f57e9@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125526.GY616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908125526.GY616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b508f6-bffd-4656-45f1-08ddeeda501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOQtH+YWiPInnydj3XcA6gtlIiwdxuhhtUvPbTOUmUYaZ5YChR4SruE863W/?=
 =?us-ascii?Q?/ZUoRXXK0EYoFrsp7y5biN1UOs6TwVuNAa0QrXAfIL/B3MCCgVXzw4Jf63Qa?=
 =?us-ascii?Q?k9EVRoNA3BNb0kQv069IUTPB7bH9pcfAYTIvxBQgX3df6WNwQr3rFPqN/kUB?=
 =?us-ascii?Q?0NN0guNAPEe4nFxSzLgEXSqIxNhYM8KXFdlPwel4ronUt1FPVzbhGUqpgTvq?=
 =?us-ascii?Q?FzWIsuOaZ+y4GOFikdhuMT3PIVw+B1SSHgvejXI6HpBVYOAXQLuVuRSdmWQM?=
 =?us-ascii?Q?b/wfswQOwipCJNv58wy6gYhXvGT9DHc2QHCGc899WXn+Kj9kiFNB6v40zjBN?=
 =?us-ascii?Q?QRAY+efzWGplnhrgQ2G2Y7XFE5nMnxvWV+CHWngSwNmT2aZGGPYWmcVVxztz?=
 =?us-ascii?Q?uFFvPqpj1JXXBQKIHj6g6AlbWOxiBCxgouuSiHmT1NGuAsCvBgN4vTeZYubT?=
 =?us-ascii?Q?v4BZ8TvyBES3smEAnYtgXIf/P5lKxv8LuYdcN0U0W7cRV9emHdcU7Xq/vM8F?=
 =?us-ascii?Q?dwZGpCQ+s2l6tCs+pvlKc0J5aCLkDuv7GNGrV9H6w9V6LwIqMWK1qKMt3TsS?=
 =?us-ascii?Q?drFecKC6MnMCKvDIvXESr1/pIA7fOAFj8+/8XCWOvozIDQAXm76P85B8io6k?=
 =?us-ascii?Q?AD8c28n7NMMZDQAl6TSyTG6NQ8meuXgK07ogG0PY2o63THgsJqpiGGcah+U6?=
 =?us-ascii?Q?aw4PkvwX1Iej+17UqTYSdsSbbeBJgJewY4ikQ8VBVeAsQQn1awPbPvMQ/R9p?=
 =?us-ascii?Q?pnjPrsH7QPaEOL7pBokUGn2/+f3nD/gOSpEId2byctKvQ74HKXwonXOWtyJc?=
 =?us-ascii?Q?P0VHsIRLitZbMdVwtVTxWaubHjD6hCVOtMklRZe256WDE/rcDTDXesselrn9?=
 =?us-ascii?Q?YuKW5Lp+2Q3PN5z7wpVx7Ydflg8I6AVJ/0rU7Lz8vjdCQ/Htlre/lFx3BEwF?=
 =?us-ascii?Q?WUtsI5hXROPRpstNno6s6adn3ujIJ1xgYRcy0j5loCry/5lnlytG4DWwE3P7?=
 =?us-ascii?Q?dvmNRULx61KKVApZQf7sek0CQxrnjRzGAY+dcBT7ZUdzWEf675wTWRE3Mg9B?=
 =?us-ascii?Q?w4VM02ZFHv/EdqRTNUq/7mBK3PlCjYDsJB8Frm6U4OyYjysqnY2ziJRl4sO+?=
 =?us-ascii?Q?rNfEguAuM5sMv6GhATcPmqCo9jssKSBhTHBlhJ3/3DCaqYoZrEv0j6YSUne1?=
 =?us-ascii?Q?CPwMxV8BjF1xrKWsqujv4cOw/lcHt5dYmdfqpT9WMGo2xomw881XfZXX3I1S?=
 =?us-ascii?Q?nDSRGoWhcpn0j1DWfI0kNe2tOV5IHWBzqPrVeU7b5YWl9DC4SviEZfSR2vn/?=
 =?us-ascii?Q?3NbnRrFDvW8MFxisE0SJbm61i0vFUb5q4WgVKuIPudTXDkX2G9LHq9eCCf53?=
 =?us-ascii?Q?ytMEeQuAefA5KOd2xHKczN+ZVGb2riUaXHJDF1IUAUWU64zv3cWLUAAFNkgP?=
 =?us-ascii?Q?28Sdf1ltdR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wQ5+KHgwYZMGzu7PdJolbi0UNaD70M2cfzqnRikylhdzvugpF4C7b3A4C/d?=
 =?us-ascii?Q?G7LUV6eztYwZn4BwykvUeCHBjvZqXFBMC/x61gZtQrCcp+z8OH5tkh1vi4Xg?=
 =?us-ascii?Q?Uqp0uvBfazz9D59NPd/KlOoFEIgXb+U8w0TdskfkwtTRNuVb0Nb6QQSZFwnl?=
 =?us-ascii?Q?0q/aPIjHSxOFIOgG9fSlcyG44YB71bHtRK1PHS1jleaNBdqhbtzB8BmxVKQl?=
 =?us-ascii?Q?3a4kWFDSGAX+nqJsGyrMNSmYre7TuLnxn0S12lMBpKna35DEJ4VacvRVEgiV?=
 =?us-ascii?Q?mLCAdAgiZ9ugfMVmvfxISJaWWSfH20H4+iMEXTLgpAXHrdbUCXzKnI6ySkfl?=
 =?us-ascii?Q?h/hd/HDoAbaOb/G3Lnv1JgmItMRnpPnYSz8IZHVZXTb9qeNpFbLYQTBmkouS?=
 =?us-ascii?Q?mBbFSoFEPkJ+6ldyhvWP+q0tDMVyi752cY/gQir8R0f10aCtia7MsbUOY/+2?=
 =?us-ascii?Q?N6LDF9krgJpIcCpPnWZt3/lafZh2w7pOSFdqV6POb/KYoKqF4DnnwjxL+Z36?=
 =?us-ascii?Q?KCyW57Z44PqGmv9rx9FyScu7mjOyvrHW9NSZg8cgvQBeyTW6vdHrrY5zijAo?=
 =?us-ascii?Q?sjkI4tq9mrseCkP7g6Qazix7vLtCA8SuBwuI2cVmeBgc8i079surcLtZRf6e?=
 =?us-ascii?Q?Bxi10nt3T1z1fMUuEA92qu3R9JsPvadzO6HcU6C/3WtxxsL1EePbrwnc2M/V?=
 =?us-ascii?Q?n/2RqKrx1j/Utq/C6wlolBSacMVyJDX/SnsnmAnXvB6qAhZrm2SYtVS18gqn?=
 =?us-ascii?Q?OROjKkavaBvGAkcB8zSkAttu/oxLNoy7pe/048e6JRStLAMyUeHHyz/+16I+?=
 =?us-ascii?Q?jeNSQnj+G5iFtpK6TLUxumT25ItUmpwmxQs1Lv2PU4ow+RVqOZSP/+0ieXOv?=
 =?us-ascii?Q?z/xtL/KNVQTCkhZ2Dg09bL19xo48crj5d58HcRfBt0kyBkEiLce+SZDp87yX?=
 =?us-ascii?Q?LUOMz4MEV/n1/g7bMb3CLBNS6fY+Xe45XNBbQZ3oFm33+gws0Nqijvr+giG6?=
 =?us-ascii?Q?5QFJa6RVZgIYYXr9VUHj8PTARG7xEwoj9hCLT94MP+jYb2fkZ+04i0WAVB2q?=
 =?us-ascii?Q?3TH8b8K7ENt8aPjWFAymFMkujWQU3eCoc0nsi1Unq15SnMI3tXIS+gAoXjxO?=
 =?us-ascii?Q?r3CHNfwkgAxzcwpWj/jOA16TG8tnhnAaGc4sq/yZRqPbRadrGJ5nFvlc/Swu?=
 =?us-ascii?Q?9QOIh1rjwnx+hB/lh7i471ZjIUGnJD9jt1ccBVWre3AuWq0rQkosOuU+6/Fm?=
 =?us-ascii?Q?0AMpsps+V1P9OpG97Fl2FnC0hihdSvNdh1USYsIjjLubQ7HpN8rP96mI+fRy?=
 =?us-ascii?Q?BgHqdWRxcGRK01WyXGxVmdN/IdtYQOzbNxV7jT7YCW0Sz8zSSjUlSn4wkYOP?=
 =?us-ascii?Q?CWruFw+PNfz3JIHfNUbICdWTx6rDJ1SNN4vPyPCBKgs2lrD1K2hY2e2IfEAw?=
 =?us-ascii?Q?yX/jSBIjjqdonlUCoTaKeiK3S0CtJO651t/9eI2tvnPC1ILtUkjOHrt5vpTv?=
 =?us-ascii?Q?2PYw4ArzMj9e6/eSRfHxvTygIBecEIg8hWZ15029VFlN3ZkkMAcR89v4O0FP?=
 =?us-ascii?Q?tuDYSfWRNsgTQiqmQhretxvDETr7mK17CiJAByvjSweescXgvzuCk8+F8TC3?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uUcUXiX+kJ1gjxVzAwzrHlGcW64V5mOBed2mkCeIDaCBhqiWyKyCKLZVKawK5cXu5VhKWMTbi+cBWxSWki5whXDCRA7gAZodFa6uFTnkQKIlEkjm1IR3xs/OOCUyLbBI41zWClhIMaReEIS06IUEKZn4ZR3KBYrl7D1RBDx3DOn3jb7KIm3n8Fyb9FMisuVA8heCT2q8NOtvI6XZ2GcffkCnC+lk46IFs3M2tzU36o0k6gij+827LAU8xc+hKp++qvBQAC/k+jsZOUb8KN72J61iqM+TEdJr9aeHdK4pTewb2lQ4/v2tMdzcrmnqNwNX4rMY/NFiQ3GjHrLEjj/l50Z7EOQ3jrL/Y2cIyAAlZmSSFa2OpBBGUCQHb5L2xu0vwO3b3WvctP+aTnu/jp3ikwP7BlAYBoQlYrzppado7k4tzU5g1Yr1FYiSj5i7Aphb8sMT9s3GK8OQBnB7JOb1biUeYMtuadZqvwX7uH7eojGxIqxpZGF+B3mTtHZ622YwHxp4Loh3Jbymryh5PW83W8UMlRDeDPFLCbrY0mo3+MdEshVeC8Vu2iip0+0tCn/Zaz18B4oLR6V1/tCrxB+db4n0TomsSeYTmx45s/Up6J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b508f6-bffd-4656-45f1-08ddeeda501c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:19:17.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzS2Y5s4KexMsdva0kHUIrHXWXr8/MtjxUaZPK+3Ksm7cTHEizy+PN7ikmCzFhWqAjOWRk60TPKWVHSZTPjggDP6T7uAD1UnovryvhwRLB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080133
X-Proofpoint-ORIG-GUID: XiK2x3xyJQv5mjRr3pvPFXWW2LoxNB2q
X-Authority-Analysis: v=2.4 cv=ILACChvG c=1 sm=1 tr=0 ts=68bedc13 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=sd7PVl68wqFViJiyaNUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNCBTYWx0ZWRfX7cbQBPKxMj7N
 nJT0g+cwWIX2E6G65eAunircjqUDIgY3Ocyehk4+SSFUk36Jm8GIDyifgbUOQu05oFX6WO9vHS7
 4qZRtqF+0YhVjpVksFA/E/4OxnGiflh5AL5HZQnDjkygaOCfDqo7PQhFPl6ECOnLYfPjLF01N8r
 qta26wMtPFBRr2IQa0Ij7Lu8+XyQbSOhQTbgj6EUNza8H31wye2VocjHS9T4ZZ1LLX1KVtbEZFL
 jkdqCrO2Q8K9f+5MHtRj0HRV1bIixgC+5iZ1vjGZI2iX4bOz3QU3pI66+PmGQy7D/oK/JtuRul6
 7MGy9ysSz9r0RLGYT46NsGOsnpQYv917wCRaGjg+kO8NGjuioYZZz5EEA1XofGxaW/HUrDZtHFi
 ZxJh6khzFkrNe/HNa+LQv9rUS1BK7Q==
X-Proofpoint-GUID: XiK2x3xyJQv5mjRr3pvPFXWW2LoxNB2q

On Mon, Sep 08, 2025 at 09:55:26AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 12:10:37PM +0100, Lorenzo Stoakes wrote:
> > We have introduced the f_op->mmap_prepare hook to allow for setting up a
> > VMA far earlier in the process of mapping memory, reducing problematic
> > error handling paths, but this does not provide what all
> > drivers/filesystems need.
> >
> > In order to supply this, and to be able to move forward with removing
> > f_op->mmap altogether, introduce f_op->mmap_complete.
> >
> > This hook is called once the VMA is fully mapped and everything is done,
> > however with the mmap write lock and VMA write locks held.
> >
> > The hook is then provided with a fully initialised VMA which it can do what
> > it needs with, though the mmap and VMA write locks must remain held
> > throughout.
> >
> > It is not intended that the VMA be modified at this point, attempts to do
> > so will end in tears.
>
> The commit message should call out if this has fixed the race
> condition with unmap mapping range and prepopulation in mmap()..

To be claer, this isn't the intent of the series, the intent is to make it
possible for mmap_prepare to replace mmap. This is just a bonus :)

Looking at the discussion in [0] it seems the issue was that .mmap() is
called before the vma is actually correctly inserted into the maple tree.

This is no longer the case, we call .mmap_complete() once the VMA is fully
established, but before releasing the VMA/mmap write lock.

This should, presumably, resolve the race as stated?

I can add some blurb about this yes.


[0]:https://lore.kernel.org/linux-mm/20250801162930.GB184255@nvidia.com/


>
> > @@ -793,6 +793,11 @@ struct vm_area_desc {
> >  	/* Write-only fields. */
> >  	const struct vm_operations_struct *vm_ops;
> >  	void *private_data;
> > +	/*
> > +	 * A user-defined field, value will be passed to mmap_complete,
> > +	 * mmap_abort.
> > +	 */
> > +	void *mmap_context;
>
> Seem strange, private_data and mmap_context? Something actually needs
> both?

We are now doing something _new_ - we're splitting an operation that was
never split before.

Before a hook implementor could rely on there being state throughout the
_entire_ operation. But now they can't.

And they may already be putting context into private_data, which then gets
put into vma->vm_private_data for a VMA added to the maple tree and made
accessible.

So it is appropriate and convenient to allow for the transfer of state
between the two, and I already implement logic that does this.

>
> Jason

Cheers, Lorenzo

