Return-Path: <linux-fsdevel+bounces-60159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9268BB42410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ACB4808D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA702DAFDD;
	Wed,  3 Sep 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tupi2oJW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u0y4CsC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9A2EAB98;
	Wed,  3 Sep 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911163; cv=fail; b=EeqLGCCLXs4zBl7ZdBJAqKO0DcvhXsY2l11Rjy02MUrgsFOExD2HzCZdovnowr0vmn3vCdDtIslyCHTD0BtMNQ8OV/bPzJ6z5OhEOeQqR71sNDYQq33wdJE/JUMUzS9JqBjHxculbelb5gvvWKg6LumGoGl9kS6aLwb2AbinqvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911163; c=relaxed/simple;
	bh=Cdjttbarr4FE77f+M8x7E7sJ96zVcE+UT2Zn6xvJAGU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3tHXe8ZfGw+wGnFm78We2bX9P04mKyd/dHlutWb/prDKKueaf4w+mgZyI9v/GqvtQ3HgwK5ZFqpJ4gFqDtad4SA51+7b5aqdvrYg/o7QbPhpl9K9bNuNeAcsoNStKuUZAoS7k74jxx5jP68LeL6HaIzxCaH8HuYMvAdGiRMIO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tupi2oJW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u0y4CsC9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NAAK002197;
	Wed, 3 Sep 2025 14:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eLygknJkAxEpw5zDl9
	hnbe4Usd+JOC/qZFY2Doc176E=; b=Tupi2oJWZwsrWlYRvvZY92aBXEH3zs3P6d
	GR8o2uKKGnaTopUYD/xcFu59JksC0YbE8kGPJpvSbyruEpTOI4nVm21pkqb7SYur
	SY2C9fmQcjhOd62JFQWHGdCwIVCGi2mUeLkjVF02mYmwmTxA3nJFFFoFsNWqfrh7
	vnqb+WuqMemdXl14K2IWo2rp2fpIjeL/45VwGRwLBuQmCsPOperWNl4sw13bOu5/
	HHKWqShEwHqa/e+DgkgYMZM+rzqQ2rc5NSW8l4ZsASzDRR3ocsKdji9hqwUiuUDY
	9wUfPhKPk3Qy5k6u8xf4SYrzOR1PbU0jhBvgMaUeobCEJgTZeNTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvxkmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:52:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583EdOxd040070;
	Wed, 3 Sep 2025 14:52:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrggkd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS0doXfTXcEnnrZGuSgpJGFMmTx8h+MIJBg81t4g3b4Y2kecr85TINgPJ3w2P6OpGUqJ8nV1PymApMaWPz/ENSsivIubWJTXpnZZwEZQW2gGCYi6C+YgrkbSIVKWJ7laX9Y0mfkpA8kzwGbTk7/fVeWcQdPA6GWxcBR9gZSBiRaHGkA3D0seZ6TFmp0Vg6KT+YfFNcIBcfPyVZWPHBpw9IMRVW8usAblZ3LOQx9xPcu94rU1oYGaH8ro/XaIEjsBZ7db5u5WKZyh4QS8XN/mKMtGyH6P+EdP8qTX3Wpe4pQVHfagyTHf4Jh5UoTxavwqNTPbW6LvvVsnXR5FChUvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLygknJkAxEpw5zDl9hnbe4Usd+JOC/qZFY2Doc176E=;
 b=h873qlGYaJX9zYLLYXuVnuOUMQzvZ3hLonB9RWjU2VcFuuWG4yLBK4dJk8p0oWmnis/WsbBxNa0Mc9rUDa1SIrCIjTUqDpoqZFfUkDOhtgVKkluZdb++gVmYG1Lc+dwSc0Kq6UtG7Ocv5fgF1balp4mZQoYW2N819pspr2kVwd0X47qU8Mv45tSvH6ygT6Fye5u90Z+UTCwmZosXhjHz0VTgDC8U07qq30cLA5gaUJ29VTUYxJaetKCLGSm6OuJGU292mONRRZ9yxF0RvPJ/EbDntxJj+bLONJlV2JoOg5ILqs/zrpgtC9Ra8u97tVTundjiChLCpFUx6IFAkXz6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLygknJkAxEpw5zDl9hnbe4Usd+JOC/qZFY2Doc176E=;
 b=u0y4CsC9jOCO0DGAuQdy5Tjh8fDz4RNPmN3GpGgCt9/TbTvQiBua+Bn79F5J/Z/W+vwZW9A3YgkKVMTGdUP4ryZyHO6HeyqHotXI9NwrDSKZiUb0kCHtuLwXxKFVwF4D9GrEORxKDcvY/KwCLCdGSGmx76Vv01wZI8Gz6u0rEgc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFF3A3AE169.namprd10.prod.outlook.com (2603:10b6:f:fc00::d59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:52:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 14:52:24 +0000
Date: Wed, 3 Sep 2025 15:52:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <68e2ab97-7855-4c13-8241-46fff7164700@lucifer.local>
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
 <fbxu5tqrhtrvxznrk7xpkzvl4uz5o4jhb427vupc3u42x3u6mt@e5exfypuzzs3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbxu5tqrhtrvxznrk7xpkzvl4uz5o4jhb427vupc3u42x3u6mt@e5exfypuzzs3>
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFF3A3AE169:EE_
X-MS-Office365-Filtering-Correlation-Id: af0c9277-41b2-4c06-0b83-08ddeaf97e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b9oSgBt7LzDC3P9jWEsM6iSVfdaYJ3fO4c70Z0sk5Zyuh1zmIdWELsOKOt+q?=
 =?us-ascii?Q?CpLXufldT5F99EygrO2ljHoMunv02HI38rK0/o5u60tVxOYaYXH5Mncg3UdS?=
 =?us-ascii?Q?qVvWS1E9Sd7CzWjbf3yaQAzP/sddfrCYnN+CehLxeWljo+aZ0PIECNta0j5u?=
 =?us-ascii?Q?mBxx2jAWOuWwdM2SQYVwlenVJdUhOfZ014jwGhY3hcaFzeu4ZqflkjFv05lB?=
 =?us-ascii?Q?wgQ51KtbekbiwZTxqTNuz0yMHaL2NxxOg7NuyCj4WFSodlzs9VHkqNEIgXcx?=
 =?us-ascii?Q?cYXgIp1LBnrlDiRhJ9x3bzN+B90sWxbzLB8rT7RM4rRgJbSJ1hAs1X7/QRea?=
 =?us-ascii?Q?9bfRpbHYPPnO2TyMZPcJ5BhAnD51CqNtjMqaMQaoUEEkSHD+Qe/8j9Nne2Ps?=
 =?us-ascii?Q?azE7OPSJ8A1x3oIBGblVX4Jhj+7oSla/SVASsr5vrmKenEdmGp4e0WY1dSft?=
 =?us-ascii?Q?vKsuDmNDrlk8dydP1mTf3oaFpU57Ra5NoKF5gSjO8u24pGiVLZNqvJBrdTQk?=
 =?us-ascii?Q?vg+8YaP3ajCdM2dUbLjp1KpklI5IuorY/bTED5mRmJJlXOSwfAvG8tULnM56?=
 =?us-ascii?Q?CswfvY0nLFZE/ma3TVq/7ynbJCojVXzTcDuxeqkf9UxfkplHve3pwXTYV5uy?=
 =?us-ascii?Q?V/i+hjDSBkEAztzfZXlhLvkuyonH31OUXOF2Ky8ke4p8rT27RrCsDjIdD6mL?=
 =?us-ascii?Q?YsCuu8QG7LCJEzw3B6uPPDLW8kWvTqseS749Em0jGdcwkaM8wiy17qDR5my9?=
 =?us-ascii?Q?/qgeXIkeboGm81C7rWNBe1/IDpR0lZZg7eWw4TbovdKaZ7U1Pxq88Md0EFSy?=
 =?us-ascii?Q?NzliF3pQQcyQleml3M0Ry3HqT4Lo+i96bD8hc8B2yrRuyND3HGNVjJwR8c3t?=
 =?us-ascii?Q?iAWpxhI1YE23o7TZKVqTnNY0JR35TQ3ibksyn82vexZhHy7kMrwkddzPBda7?=
 =?us-ascii?Q?iVy6YzVdMxEtoQaF1VnN4AM4v76iXsOC2eoOc/Q9FXFCp1gxIu2X25XtV5SJ?=
 =?us-ascii?Q?OgoPTbiS6hgGyUGj6YY+vO9mOGVDnaWofY5HSbWID6vUszo7NDgffZMR9rfC?=
 =?us-ascii?Q?WsZNsLo1OrHlIGD0z0lgriRG3aP54Hk1PREgXEM4FU5tJvWcdeKMGZgNa5+z?=
 =?us-ascii?Q?YPf/h2pXSan0m723DvIAXyYCAfmCxZORG65GVAbGLc9U4FovmgWLU9sBA2PT?=
 =?us-ascii?Q?oYR1e+lO//yHDP8vgBUiTZhLZ3AbfhaCEVWc1psCvCjnIdTDYdJ9qj6LEyTC?=
 =?us-ascii?Q?DQ/QGQ6gjJo8HF/ADJ56AH/miIGVMXJibuV98sYjZ0AUVY59B/nsMc8WZND9?=
 =?us-ascii?Q?pZwOBzystyEglUbI6bKEsRYb+fi9a5z1D2w2zvnIJKCXtXIZfH04kaV8ohhU?=
 =?us-ascii?Q?7LBQ9EiDhZEASDHA52bdIvkgYK6rBqIMIi5uvFL5QfQvphCj9Hx9M9f5arAX?=
 =?us-ascii?Q?2Uqsun5GspGuI9nMPvyYlQ3rcrdVG2S/Riqwk6ArIUUFMQk281sOJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3wzM4xvxsqRViKiYuvFoHkCz+H03wEmVuVKYHrCUBw1QX5c7KAvu3zSEjdW?=
 =?us-ascii?Q?OvW27sRGEKl+Y5jwFVi0W1y4Ovi8SJMcQ4LnSJVY2z2l/YKYY5LeSvchvjf8?=
 =?us-ascii?Q?jeL+SPHntzOnD0EtDonOuw+tx1sETVCw/mvvuqNvcyZBHzoc2BEpJk+/UK5W?=
 =?us-ascii?Q?cuo288KPhZUo6uXAbeVMkbq+6VUIInFsxyuV/ckSw3yKaJpH8kVf8IRvE1Nc?=
 =?us-ascii?Q?T9ruTZpSBZ+iCoq4Zz/1jy3ethNNZHmIiwAm7r7LnwI1p3aG9Gru4JeWi98g?=
 =?us-ascii?Q?Vi4/LSdCeYohdes/J1Uo0IXgJbwJz+axGGu1HQTpjgxLWpaA2r+tEuGFREsi?=
 =?us-ascii?Q?Iti8jRaDfNzCbaeTcgZf7a4JMligOmFsNCNd2RAErK7r86wqpf/Y56ZupuJr?=
 =?us-ascii?Q?Oo2VEhmQvZrixMrpx0Avq8KRf/URkldaA2ourvWfxHIy3SzKst+d4NXUrh8g?=
 =?us-ascii?Q?TKMiLjOu7mutIeBeR5oUfb0OeqswdsRKPZ+1WxL+ny4SSLbLOw/DTXIFoBwF?=
 =?us-ascii?Q?b+g9A3fZZfOyY7hKNoG38wBzPNEIAkTo5Zy4U4/Y2ORlaGbsb5cKV7d5OG/C?=
 =?us-ascii?Q?h0aOsc37yBSeY/bi7UP72fkMwQ+LLqGjGMBl0VJNlWCGY79axmzjTTj3R+s0?=
 =?us-ascii?Q?rwk2zAuDKS/G8wxpiRyPhYneHiyE6cRi1kiWTn+0ga+RlEdBzWeH0jKQ5Mq7?=
 =?us-ascii?Q?Q7dR0qu7kC574kcg0qcv5W20ebG2VJpZ8/HFA9yb7XxPCTpVIH7QF2r3oOV0?=
 =?us-ascii?Q?QNlI9NFqpSSGeZxALaFnUkq0xZnDIlHyhnqvEPF39r6CTs+HxNK0D4DkQMfD?=
 =?us-ascii?Q?HiSyQbTdq4dy4JD9/aIzrzGoGocnW6ZpTkM4mZhrp/nEdxPScue8r6y0AhR3?=
 =?us-ascii?Q?Wa9N/RrX2wa0rnNWSEUb7T0pV9RszlbrUJRUA/UzMjaJrQjWWtkR8RqCaOvH?=
 =?us-ascii?Q?vvC2cTyPksUmw1AJv7ul6LFsgti+u+1KMq31GGhVvId6FK3jZALvaVkyDdGt?=
 =?us-ascii?Q?1DEfWPCVt0tiol8V02ZFaoOK3/yfyFQHv1X8qgfKJMnXWm/vANd+5e2bjhXb?=
 =?us-ascii?Q?dn+ddZo4A9u92JeCmOw2G7yyS8Ylo1rfk0PUmwPo/Zcv+qoM2FJAGsJ50bSL?=
 =?us-ascii?Q?KSSlWsXupFiIcen80QN23OyfFSrxLwbo6EPnNPrMK2FYb617Php6ZAklLtyn?=
 =?us-ascii?Q?3kKe0ASLg0ERek7HpwrqQ/QiBYzkfa200zWots8oirUDtkXlQpru3Ndj+E0P?=
 =?us-ascii?Q?UvIc4GVaBwiX/e0dO03QHLS6/4E4notn7gkpBmL2OxUwxoQgRcuz3fNtO4MQ?=
 =?us-ascii?Q?D8U8NULxkvRjVHXPcLAo3uDkPkT1XMafAb3hgGlT4GYBpiswxIY/Rxcm5acH?=
 =?us-ascii?Q?Tg0LvQoDLhS7opZnyiob0bni3eR+bEvg5CduXHoBJudPWoYBVQQ545ReFD++?=
 =?us-ascii?Q?Zrh/jot6Tzz28coK0lk0kvlC2nVPz26Jv0DJfQ6wbOSN61bWq+Ki9rb0+PV/?=
 =?us-ascii?Q?zXVFM6/UouHwyDVqqk4SUnSrgP+TWcQDDLNYDBSqzWrqPWosJEsjYssb7QYr?=
 =?us-ascii?Q?yJs3JkRy4IVDA/k2n2434OqzFDYw7GYD8/kw21xr9wcUprEMPB7/fiiOLQ1y?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XvHsa9QvYRiVYwQqnoIxNN9FxCLEKbbiyENN3D8gYLBgGswh0pZwR5oMiClsyhwjAWWOyOlCb0h7DqFU/31C2MHuuV5pQHWptJDZ5WuJbSPt45YwoHYMAORVd2soSh6FzK7/yVWouRhe6d+fkmQCVqE65TnSojYltuoilxNMTPxmjoUsixRPBl4LqEx9rWTxQ6PXetOEizeC/lxNiFqPSQ3zzp+tyyCbzBhl828AuicePRDZuU1cld3hG4IZDEMyZr3mgmWAxkMSXNMbiqq8CjvXLumlUaiXeqwd9Y5UAVOPXKLr13fPdvp19PSf320gKnebSwgBzD2ASmTbWUJEXFP0NKZJ1qQae+E9T3q2aMrXP2EqoqicdyGnI0rUqK/vnNgmmwmVA/EgT8bttuo8fn6vI9h94+khkrNTiH86Jd/I8I22bnrlXvbW0SBn2SKfGaAPneLCFOLSLkXQ9cKejEjGR2kPX990sovU+mAgMKEF30hotKFPYQhUNBB9+iq3Y4SWHR+DOtyXR0EEzFjnnTbl92K8Ftcd+A2Fl3JWNeG3PffZhnuqOBT8amMZn1bR+TZM+2fhnoNH0/PC9/SSiFtIN3AjvkYLbtuxkfNkXEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0c9277-41b2-4c06-0b83-08ddeaf97e43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:52:24.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD2Rx5LGIrCtilhfpFoAYm7q3JspPB4k/LXkvC9FKeYrgQAwy9toj1sQVkeJpeDo9Y/k7kzAod9qMjK9HNCRlWfBo76vetTCv/3YB3ZEUCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF3A3AE169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxOd5cLsbejQk
 PYZ/7po8LNTGI2Eia6nyL+6TzsCaaJO1TQ1xEDFcjvRA1fYMYH7AaO9oQyQZl0z/UZB/UhgL135
 n0UYQkCVh6DSId7RxgFEDDxFoV0VjPHulMpqlnNReB6A2HePGo2hySgo3uIzh5nHg67y3VUXDWq
 L38o6HnZmUFjWen+GKzzulh1RA/tSLMEyX9EFcJJyNXVZkdzyBC3HLulkkcwfeHRpeciIXzrUTo
 Iqh0KSl8bWhPBCFNg/Lm09H4TIbQs2t7mpwANtxyvuW585jlb4McfA9YQzRPoVKyJnk0ebOmm4s
 2+ka3Htx73yXWzL2K9/CXpHyDVDKrCpRlMukizTJ76rYteG3Wd+otAsSzhA2RY5D2z43dmaRbzc
 UR8j8CnrR/zv78J50RxWYDS7qrqEMQ==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b8562c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=h97hwrtWmTJcXVqopcQA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: 9PWygj6-yw4xJoDqPb7ipx2b8eduS8JM
X-Proofpoint-GUID: 9PWygj6-yw4xJoDqPb7ipx2b8eduS8JM

On Tue, Sep 02, 2025 at 11:08:10AM -0400, Liam R. Howlett wrote:
>
> One nit below.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

>
> > ---
> >  include/linux/fs.h               |  2 ++
> >  mm/util.c                        | 33 +++++++++++++++++++++++---------
> >  mm/vma.h                         | 14 ++++++++++----
> >  tools/testing/vma/vma_internal.h | 19 +++++++++++-------
> >  4 files changed, 48 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index d7ab4f96d705..3e7160415066 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2279,6 +2279,8 @@ static inline bool can_mmap_file(struct file *file)
> >  	return true;
> >  }
> >
> > +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> > +		struct file *file, struct vm_area_struct *vma);
> >  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> >
> >  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
> > diff --git a/mm/util.c b/mm/util.c
> > index bb4b47cd6709..83fe15e4483a 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1133,6 +1133,29 @@ void flush_dcache_folio(struct folio *folio)
> >  EXPORT_SYMBOL(flush_dcache_folio);
> >  #endif
> >
> > +/**
> > + * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
> > + * for details. This is the same operation, only with a specific file operations
> > + * struct which may or may not be the same as vma->vm_file->f_op.
> > + * @f_op - The file operations whose .mmap_prepare() hook is specified.
> > + * @vma: The VMA to apply the .mmap_prepare() hook to.
> > + * Returns: 0 on success or error.
> > + */
> > +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> > +		struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct vm_area_desc desc;
> > +	int err;
> > +
> > +	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
> > +	if (err)
> > +		return err;
> > +	set_vma_from_desc(vma, file, &desc);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(__compat_vma_mmap_prepare);
> > +
> >  /**
> >   * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> >   * existing VMA
> > @@ -1161,15 +1184,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
> >   */
> >  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> >  {
> > -	struct vm_area_desc desc;
> > -	int err;
> > -
> > -	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> > -	if (err)
> > -		return err;
> > -	set_vma_from_desc(vma, &desc);
> > -
> > -	return 0;
> > +	return __compat_vma_mmap_prepare(file->f_op, file, vma);
> >  }
> >  EXPORT_SYMBOL(compat_vma_mmap_prepare);
> >
> > diff --git a/mm/vma.h b/mm/vma.h
> > index bcdc261c5b15..9b21d47ba630 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -230,14 +230,14 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> >   */
> >
> >  static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > -		struct vm_area_desc *desc)
> > +		struct file *file, struct vm_area_desc *desc)
> >  {
> >  	desc->mm = vma->vm_mm;
> >  	desc->start = vma->vm_start;
> >  	desc->end = vma->vm_end;
> >
> >  	desc->pgoff = vma->vm_pgoff;
> > -	desc->file = vma->vm_file;
> > +	desc->file = file;
> >  	desc->vm_flags = vma->vm_flags;
> >  	desc->page_prot = vma->vm_page_prot;
> >
> > @@ -248,7 +248,7 @@ static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> >  }
> >
> >  static inline void set_vma_from_desc(struct vm_area_struct *vma,
> > -		struct vm_area_desc *desc)
> > +		struct file *orig_file, struct vm_area_desc *desc)
> >  {
> >  	/*
> >  	 * Since we're invoking .mmap_prepare() despite having a partially
> > @@ -258,7 +258,13 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
> >
> >  	/* Mutable fields. Populated with initial state. */
> >  	vma->vm_pgoff = desc->pgoff;
> > -	if (vma->vm_file != desc->file)
> > +	/*
> > +	 * The desc->file may not be the same as vma->vm_file, but if the
> > +	 * f_op->mmap_prepare() handler is setting this parameter to something
> > +	 * different, it indicates that it wishes the VMA to have its file
> > +	 * assigned to this.
> > +	 */
> > +	if (orig_file != desc->file && vma->vm_file != desc->file)
> >  		vma_set_file(vma, desc->file);
>
> So now we have to be sure both orig_file and vma->vm_file != desc->file
> to set it?  This seems to make the function name less accurate.

I'll update the comment accordingly.

On this in general - In future an mmap_prepare() caller may wish to change
the file to desc->file from vma->vm_file which currently won't work for a
stacked file system.

It's pretty niche and unlikely anybody does it, but if they do, since I am
the one implementing all this I will adjust the descriptor to send a
separate file parameter and adjust this code accordingly.

Cheers, Lorenzo

