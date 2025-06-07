Return-Path: <linux-fsdevel+bounces-50912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D7AD0EC4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786553ADD59
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524A20ADD6;
	Sat,  7 Jun 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NU55HkX2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hAtnRQby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC28145B25;
	Sat,  7 Jun 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749318264; cv=fail; b=JI3uLcAoRNTN9AR+Vnnqlk8dJumxpIWbAdgKKeQHE/G6QQunoT0nKoJeTU3n02HD93YSIaldD4b3PeApEB30dYD8kIG8mBrcnGjrhT8mO3I4vxLE448ZeQVwQ+IslzJ/mj2G2YHdNolRPNAIkWiQmaYZjyFZV3Op6DXAG6B9HPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749318264; c=relaxed/simple;
	bh=WlGqZbuAM1xeZfmvq7C9y7F4x1S0Y2tQ+lzfkMbVMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mTZnaJQiDaLshMHd1IgjHWyLcmROpynR8PRkj8VKLpxoTrBvlb6QKLNMK1J9V2HpD0OYKbjvZ9pFjZEOaWXsZ/jMksy9Nf6vW1DMZUL/dhFKxFwWP9DG594XcYExVxp7VcZ1gdopzEilWN9qlmQySWLbOOH6x0SYA0ekbUTiO6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NU55HkX2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hAtnRQby; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557FswfQ012708;
	Sat, 7 Jun 2025 17:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BJDUzE0JEu5ykA7K0r
	lVP0ZexOmOvjRO/A+YfrxldPk=; b=NU55HkX2VpK8bl9F3EWFOLKL1T7KlIw6x6
	q/vAowxXPZ7qJe1O7F770JgvPAO077G1IFuHhEUmT7qX2NRqrKViJFNtMiQOU72P
	JP2jD+AvGFKwQQPfuTffIJ+0rIZ7l/BQOUlLA+6VNPQ5FpLtDouLSeoAoJsMzDjv
	rBrkNCIjac+BHU/HSVcLXfI2xAUfa8eLl9uxM8Pn6usgNBDJ+DN5tlKkUGmbHiD2
	X5yPaWN7JF2k6BMYvHfncxUrTn4TeVMslRFSxzYfAae2pzHIgWHi288568e7DMAF
	AVt1+vedOyTk8fgsQyWpOq8yIpEkMuuYSRPkpywzQvcx3lO8OUGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf0dn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 17:43:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 557CPDcd020934;
	Sat, 7 Jun 2025 17:43:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvccuxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 17:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLzZupG6BO4MuQswzfMOvOMjqX4uGDOl+84Sjtxkp8SHVM/yNbfh8x8GTBoWrKQCBv+WFUb2HvPCdf5Xue5y4YRkFUER9iZGrAZTF+ZtLVZToilxQjQzLSqbvrKTYCNnedczOAaC6gsHO4DUCFCZEvGQYWVYSaq+GqUn/pqkUQLcQ246C/i+bvnZ/N7yYBJts4fWj21+MSDTNSoCo9YoNN2fx+6iS4XwsIwMNvVPG1g34J+X+Oz0lsGIzX0Y9fGM7BM7ejXq7RHV1Q2Ypt0vKL3zt/dDVRj/FxMGHjOj7/4FaD/90a7PAo/83dYRhthVr+yoXJCtVfPg0Eo9TaSJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJDUzE0JEu5ykA7K0rlVP0ZexOmOvjRO/A+YfrxldPk=;
 b=FmvgDQ9Jecj5P1wMmTFMFgK/c8YxVPZILN8lFcNQ9fCeFSpW5a3//QiM7IsdYl9Kr01ZUHF5KQMlEJA9CVwgHC0v/bZRIIAdSmw9EARGURxe8quuBBPPLOzv6L3vjTFciSbHx9QcNle79noYKF3iiAgGVVn6KKrazLy36eMpSaVSQaiYgzWeDyr9uxfhZLYaLWTL+qSx+NyWECm2FkJPoBTgtJ8Me4D+BLU93AMQTxvjJqYY2qesZoHHx19CiwNZBkUecOmWROcs7N5BlDiK6w2y5E5pcnLqVrr4oVG07EndFc14iin3cBcA86D/BRSDUEME7YZSUC0PRL0NJZzEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJDUzE0JEu5ykA7K0rlVP0ZexOmOvjRO/A+YfrxldPk=;
 b=hAtnRQbyL9xiYo/7DOL6hEG/FOshFVbJwYoaot908yfsNLZiPoRDl1Fo8ndp3s/l0ubjnyjqj16zK/m3X3/UjAI0CB4TCdTG1hxb5j2D99oto7mgnhiYJKDKHXQeS8YVKCQFy5YiZdf28zkqmnLMFrHC4p/KSPGXxRqOY6yULA4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5965.namprd10.prod.outlook.com (2603:10b6:8:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 17:43:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.022; Sat, 7 Jun 2025
 17:43:23 +0000
Date: Sat, 7 Jun 2025 18:43:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
Message-ID: <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local>
References: <20250604231151.799834-1-surenb@google.com>
 <20250604231151.799834-7-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604231151.799834-7-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: fff18b27-94b3-42a8-9546-08dda5eacc81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cykV4qLQqhsMjHfwrdf8M2au7sK9+7Rg0NtlVI5skm2+pY1e2wlabYcEuus?=
 =?us-ascii?Q?U5NuBk9ymyec5W18gNu0nueU9P8sKG1M5TbHOjpIDD9lqevrM6fZbtID4llf?=
 =?us-ascii?Q?OuIQ/lfVMGWH0ThNKfeP8eU7M2lBtHMDkWYPTAi5zIw3TXCJ3OUXIMwAbtDC?=
 =?us-ascii?Q?BVZGDiek0OuVUUllShk+Lyq331jwiogSj4R0e4ufxKYX27umY01L3266UBzH?=
 =?us-ascii?Q?YxF6MnLo6UqKzF+dITOFKrJB/C6FLo19sJnSrNGVSX4TPGFhOJS0Kz++yf8y?=
 =?us-ascii?Q?w945MmSQ4oSM6zggsO21HNqX72vkMGDeCHcCb+l2alvRTHQQptaXfZwPZdR7?=
 =?us-ascii?Q?ecwtN8Mwpoph3suAx2lTngLACt7M8fuau2OGSvc+PID2qpwoPGxGkZlIBisa?=
 =?us-ascii?Q?l+kUIte/ndU8mLGhCYkJMzv1JxmHr9YZk+Mln1ABdRpvbwGHtCCEVuRbhI6C?=
 =?us-ascii?Q?nVTL7Gh9eZCOMxjJ1/FvMF7EBwvvKXCcDszd0MVb+cBaaxN17fFygjeqQTrD?=
 =?us-ascii?Q?xHSYFd0sXf03sdMsBzdUCb0rrxyyWKJyxgpCxbQRxKATtMW7PLsHnTwclGE1?=
 =?us-ascii?Q?POQJdrKjKqVXmKOjjUpcXYqJ4O30RFmxTvzktSwJdoVmiKor9Do/49DeS3dX?=
 =?us-ascii?Q?IJ4Vfy58iBPdRrPq1O73+LTVv6RucCXeG6VCeXG6k+JyC6dZmcDA0WzHzeDQ?=
 =?us-ascii?Q?q+9GCproREMN77kH9hLXIUmqq6Cj2gXg0rZhjsc8APNG8QQ39BCnhjfOs2bQ?=
 =?us-ascii?Q?bPy0j5qylLwXBqrwZ3LQ6LWbCt5rTLlK9gB/7uA8fJlcBBgljz/DR5nxdHky?=
 =?us-ascii?Q?1F+mQ4xHLsm/5mssYqRsbEbOAo00cQtp7V6FJPXVz2QPcEapzMaUONQveh3h?=
 =?us-ascii?Q?2xt0VbpD0GxTOPlg4/YMwHfNTLT3hLfFi+Q1Cr/qOGjyIYBxvcV/zYKiAzWb?=
 =?us-ascii?Q?7auexo8CxlEiPxbeFTv1ef96i36qyoGLCoyOcjc+8a4jgBoueGjhtEEQXMGV?=
 =?us-ascii?Q?tm5ek8jMpbK/f11DGzM43uxYAIUXf5XjQQ1Gc84vS4CSWsVzHJGuPAipemzV?=
 =?us-ascii?Q?D3H8G4E2EVkhbpBrQstQv691ycJfWn41TWZJPs9kzqcTlNo8k8ORtpQRTrrV?=
 =?us-ascii?Q?Fx6NmUii2EAEUdcKehIQA+QAg4sbd4CLnRjhoZ8C1DiGhNWEJ+Eo++9cQN8k?=
 =?us-ascii?Q?1IJ1aiucviLJmc8s9LpBXFs4VCj4wBNVSMJNgXohyWfA4rantj8yzhGLqXmv?=
 =?us-ascii?Q?+2CMDUISAK/OnKU6s+ArSEeGgMmM+EDrBZcsxijqtRJNfCq/UVlrLBjgRErY?=
 =?us-ascii?Q?aDsZrPw3Hq+hi2YYHfMnUQmzKNUaakixe5zClhFhsksCS1KaB1sv8kXD7UIH?=
 =?us-ascii?Q?FQV4TkEewkllqnZF75ootuQdHbMxOSl5SZBlq8PcIVp4tgvEmUWjDMGyC2k+?=
 =?us-ascii?Q?Bylzontnqtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfQM2lmewa34s4qaVNXKDDl63ZKTskJG0w2q9WdRcOms6qvr2nGVK5Zl7Y+E?=
 =?us-ascii?Q?Af7VwL97Qp40EO+JupXcoJe1Vhjl57PWnk1hoGeysuOwdyVb3WheXfLP3Sgk?=
 =?us-ascii?Q?MUUYTQ6A6C2u4OUyJFjkEXCrXq6jXxKOCuGrgE8pB05J4A4nO9wfqLKldQgH?=
 =?us-ascii?Q?2Bgk5Hsm+Fxl1OsoqkAvNJ/B7m+1Xl3qcftX6UdCiGQysX0HFzw5vM3CDHLG?=
 =?us-ascii?Q?PFYKvXuZHuuMsHLwroU/dRFXeCRvK52T7Jg5MSkQzf77qcn6Amzdhs6FwGnm?=
 =?us-ascii?Q?r6+xjfZbiXLSHFTi9ltzJeaMGf1UYdc6ggvm8yIjmFfWzgZHl/4wsYv4L0O9?=
 =?us-ascii?Q?7/Pbj6Hit4RnTZqTPXFWXYAGC/jHCAecnEz6fdgQmyuV3KT5z3umTiplZYjq?=
 =?us-ascii?Q?vmbIYLI4kJmIVPbS426BTnzcAGpNzAlQBy4LbfBlNqYP6TIamGBtOKuluVtM?=
 =?us-ascii?Q?+3z49oN9GGUiqyj6e5Xf8Y8PJxB5AC0QN2IAXwTj/qcTcO4FufPgUW/oRMXG?=
 =?us-ascii?Q?Mkvzd1ecr/7cgzpSd2lplrbHb7e/m8viPCOKVRlOPurIg2i6mpcjcf2clWGL?=
 =?us-ascii?Q?vnyTeqp9rewPtRxu22Wp7el/amZByYxHJ25hOGcHZf4+k6QOoxiSH3vzcZFS?=
 =?us-ascii?Q?RXE2XuC65i6UrnWwh5RrM5KBCGF1nGAAhlyf482KMS1XVwXzA/x6RquwWLyM?=
 =?us-ascii?Q?q3EmEBymjSNDJ4fZv+dbNTboHGtg4AaFSLaQbwnl/1Y0way7VyF7PgcDpe4x?=
 =?us-ascii?Q?qz24AHo6LOiL45Gbs2Uw974csF2orJW6uCNjrJNARlHoqJVIwt6Z8i1ttjUd?=
 =?us-ascii?Q?PZ7gD7LCrd6uF1ynt5KodmtBQ/KV+Hf0bsSQKoCGqJXh/TUTyQ9pu2hpk3Kk?=
 =?us-ascii?Q?xpb9TKc5fQs8VGcj8VlWsQfV6bDhIYiNw4Mm3yxuSZWwd5uFvKYeTa4JzkTU?=
 =?us-ascii?Q?2S5ev+c2ouiUTSVsZkHAalPF0tjiIsqcEOqvjnTn9M3eZ4BARYYaSb80Lk/8?=
 =?us-ascii?Q?geBwzyxsuSie6rdfiG0ILAYZ1VFn5GYBRj+Xx6pKhxjya5/df/CMiI65lXPU?=
 =?us-ascii?Q?pPMGqSjT8j21Sa2oxhvujXjCESH08gF8uGAhUYsUjb7t0rQ03+IFQsy/Stq0?=
 =?us-ascii?Q?6iwaAxN37Xx5DBLcT+OTO1ABOIhPJmgQialbMPxGlR5qJsoRj6GIb8QkpTME?=
 =?us-ascii?Q?DAAZnIIKXUHj9bLCAdi6UXz/GPPEnPl5JXmjPMkKeY7oKQfue9kTz8VMoPqy?=
 =?us-ascii?Q?5QgL7Hcre7GSYXUy5bnWBE3xGQXrXB7JnjLFC/7xBhKojFaBp5rUeMcN7ubQ?=
 =?us-ascii?Q?c8V9rvd0toOmL7fyFlX/qkSy+i5dfDMDUmPCGcomjH/IbHVi+lwhtYxxns4y?=
 =?us-ascii?Q?HU0TbZTxZqGuTDg/QDdgbPOwi0cUByiddqPw625HXJqRur5A/WTj5kzK87U5?=
 =?us-ascii?Q?K3HLBpAIuL+I79/5U024yf52+kgRt0eZ2f/kN2zoZD3NGBWo7tuY+TJUFlv3?=
 =?us-ascii?Q?d2fJj5IxfkqdQTfsVgG6Z9RTCP/782NRmyjLHa9qbpgGMngda1gTV2WuDp7F?=
 =?us-ascii?Q?GzPJG7m3r5ct6tfxZdt4bdSYGnhyetOk5U05vW1iYzbvycXj57Q+PKKYTyrK?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gZ6xKclEqAsoQoppqkXn7CHWdOmYNu6/XlKy4OI6BHAmVLYlAdbW8YT0scXenFGWGJVdoLpaLqXIGj/XOf9xO+FOcsbsbc1HRqxtlMmu5Evp4XeGjYrDdZSvRKyQX+RoxbGr5LfxuGLSitQDQmmNd+ZGFf1M/OiggrxGexApwZHCdql/TGd6tbDREEvl5sNiU+5aXQhbuqUPdAipxrzeUObIx9J08c1dA4zZKgcz2ba13oHHmV+UCZ+WNc9fYbC3N5KeDHZ+yZitbNaasYqil3GZFucNLtrvQ4kKqiTe9FLZogH++2pLVx5ce8BNrPKJ01C8ffqJxBCr5iRHcE1BirrG2VIR6qRYnNe5WZsZq/CZC3xkNDwldam6A6DoDjY5PA1x3tMDG1Yh7muDk+rtQKKfQCHMqm9CO9/rjWbbzeH4SQzgfjIAfN5ab2oJOm1PnjDVRVx0hN2vfk5L2tFMl5FYg6a7j7WbGBczl06/fucZhqprGLgT3Q0c9c6tEypK/BLI9I7IUPE8iz8Okuskp7+udjZjgqxZIzkDcdYkPQGp4jMnaVUNGi7wnSXUOJcKdfKrRBDHGbj+QeWwH7RQjS/wD108EZdK6B5fsr9nLDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff18b27-94b3-42a8-9546-08dda5eacc81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 17:43:23.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj00tGfmKyRu/NVIbeM4RKwgrB6BXslDE4lej+/818mPxOUgFhUv6td62AuIMnzhqi1WYFOwKGv+w6y71+bRhZzNDkVpSTLeve1SmjfU850=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506070128
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=68447a51 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=EylVzbqQyrDnQY484CQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: G4QsCGlyKj9o9VcqAQWcrOkjDl1gAp4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEyOCBTYWx0ZWRfX/3XFgqJr9CCX uRb9hk+qu/8aPGpmFiUG4xSpJjRDnYYfYmngDj1XzoDMdFocF67nK1DwyBeyTXN1r5xeGUXQkBZ s+/CtdecZ2mq9BY8x9Mpp+Oa9fz3bAedo39HS3bTdT6voytBp2DaM5cjB9Yyva611JifooQV1Kc
 2G12IHhgeORT++fISLRzEBn0wqbEc3Sbu58b9No2pu9vj9zzQgdL7ysy7MfjT6pNPPDCg0W4e/F ret2joMTJz/485JvdsfetvMBLJjVI2hVb2YKDkWBGrgDORObpRTvmgGHxzd16QRNaCEHFooEG2M 3wMMkwtQjclLpz1gLZCQNMn/Mr5zNzwJaXKd0mPr/1Pa4XIZXO57o8rcetVLceRHwQWUNnyFnld
 BEiqNWl8zrPlYJQ0kN3fGtgWqGZbqI7JlLaLLpAbRWSLwXyHu8ajo+NNzpcHjcBGCxTBhYHT
X-Proofpoint-ORIG-GUID: G4QsCGlyKj9o9VcqAQWcrOkjDl1gAp4h

Hi Suren,

Forgive me but I am going to ask a lot of questions here :p just want to
make sure I'm getting everything right here.

On Wed, Jun 04, 2025 at 04:11:50PM -0700, Suren Baghdasaryan wrote:
> With maple_tree supporting vma tree traversal under RCU and per-vma
> locks, /proc/pid/maps can be read while holding individual vma locks
> instead of locking the entire address space.

Nice :)

> Completely lockless approach would be quite complex with the main issue
> being get_vma_name() using callbacks which might not work correctly with
> a stable vma copy, requiring original (unstable) vma.

Hmmm can you expand on what a 'completely lockless' design might comprise of?

It's super un-greppable and I've not got clangd set up with an allmod kernel to
triple-check but I'm seeing at least 2 (are there more?):

gate_vma_name() which is:

	return "[vsyscall]";

special_mapping_name() which is:

	 return ((struct vm_special_mapping *)vma->vm_private_data)->name;

Which I'm guessing is the issue because it's a double pointer deref...

Seems such a silly issue to get stuck on, I wonder if we can't just change
this to function correctly?

> When per-vma lock acquisition fails, we take the mmap_lock for reading,
> lock the vma, release the mmap_lock and continue. This guarantees the
> reader to make forward progress even during lock contention. This will

Ah that fabled constant forward progress ;)

> interfere with the writer but for a very short time while we are
> acquiring the per-vma lock and only when there was contention on the
> vma reader is interested in.
> One case requiring special handling is when vma changes between the
> time it was found and the time it got locked. A problematic case would
> be if vma got shrunk so that it's start moved higher in the address
> space and a new vma was installed at the beginning:
>
> reader found:               |--------VMA A--------|
> VMA is modified:            |-VMA B-|----VMA A----|
> reader locks modified VMA A
> reader reports VMA A:       |  gap  |----VMA A----|
>
> This would result in reporting a gap in the address space that does not
> exist. To prevent this we retry the lookup after locking the vma, however
> we do that only when we identify a gap and detect that the address space
> was changed after we found the vma.

OK so in this case we have

1. Find VMA A - nothing is locked yet, but presumably we are under RCU so
   are... safe? From unmaps? Or are we? I guess actually the detach
   mechanism sorts this out for us perhaps?

2. We got unlucky and did this immediately prior to VMA A having its
   vma->vm_start, vm_end updated to reflect the split.

3. We lock VMA A, now position with an apparent gap after the prior VMA
which, in practice does not exist.

So I am guessing that by observing sequence numbers you are able to detect
that a change has occurred and thus retry the operation in this situation?

I know we previously discussed the possibility of this retry mechanism
going on forever, I guess I will see the resolution to this in the code :)

> This change is designed to reduce mmap_lock contention and prevent a
> process reading /proc/pid/maps files (often a low priority task, such
> as monitoring/data collection services) from blocking address space
> updates. Note that this change has a userspace visible disadvantage:
> it allows for sub-page data tearing as opposed to the previous mechanism
> where data tearing could happen only between pages of generated output
> data. Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.

By tearing do you mean for instance seeing a VMA more than once due to
e.g. a VMA expanding in a racey way?

Pedantic I know, but it might be worth goiing through all the merge case,
split and remap scenarios and explaining what might happen in each one (or
perhaps do that as some form of documentation?)

I can try to put together a list of all of the possibilities if that would
be helpful.

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/internal.h |   6 ++
>  fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 175 insertions(+), 8 deletions(-)

I really hate having all this logic in the proc/task_mmu.c file.

This is really delicate stuff and I'd really like it to live in mm if
possible.

I reallise this might be a total pain, but I'm quite worried about us
putting super-delicate, carefully written VMA handling code in different
places.

Also having stuff in mm/vma.c opens the door to userland testing which,
when I finally have time to really expand that, would allow for some really
nice stress testing here.

>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 96122e91c645..3728c9012687 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -379,6 +379,12 @@ struct proc_maps_private {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	struct vma_iterator iter;
> +	loff_t last_pos;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	bool mmap_locked;
> +	unsigned int mm_wr_seq;

Is this the _last_ sequence number observed in the mm_struct? or rather,
previous? Nitty but maybe worth renaming accordingly.

> +	struct vm_area_struct *locked_vma;
> +#endif
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 27972c0749e7..36d883c4f394 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -127,13 +127,172 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>  }
>  #endif
>
> -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> -						loff_t *ppos)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static struct vm_area_struct *trylock_vma(struct proc_maps_private *priv,
> +					  struct vm_area_struct *vma,
> +					  unsigned long last_pos,
> +					  bool mm_unstable)

This whole function is a bit weird tbh, you handle both the
mm_unstable=true and mm_unstable=false cases, in the latter we don't try to
lock at all...

Nitty (sorry I know this is mildly irritating review) but maybe needs to be
renamed, or split up somehow?

This is only trylocking in the mm_unstable case...

> +{
> +	vma = vma_start_read(priv->mm, vma);

Do we want to do this with mm_unstable == false?

I know (from my own documentation :)) taking a VMA read lock while holding
an mmap read lock is fine (the reverse isn't) but maybe it's suboptimal?

> +	if (IS_ERR_OR_NULL(vma))
> +		return NULL;

Hmm IS_ERR_OR_NULL() is generally a code smell (I learned this some years
ago from people moaning at me on code review :)

Sorry I know that's annoying but perhaps its indicative of an issue in the
interface? That's possibly out of scope here however.

Why are we ignoring errors here though? I guess because we don't care if
the VMA got detached from under us, we don't bother retrying like we do in
lock_vma_under_rcu()?

Should we just abstract that part of lock_vma_under_rcu() and use it?

> +
> +	/* Check if the vma we locked is the right one. */

Well it might not be the right one :) but might still belong to the right
mm, so maybe better to refer to the right virtual address space.

> +	if (unlikely(vma->vm_mm != priv->mm))
> +		goto err;
> +
> +	/* vma should not be ahead of the last search position. */

You mean behind the last search position? Surely a VMA being _ahead_ of it
is fine?

> +	if (unlikely(last_pos >= vma->vm_end))

Should that be >=? Wouldn't an == just be an adjacent VMA? Why is that
problematic? Or is last_pos inclusive?

> +		goto err;

Am I correct in thinking thi is what is being checked?

          last_pos
             |
             v
|---------|
|         |
|---------|
        vm_end
   <--- vma 'next'??? How did we go backwards?

When last_pos gets updated, is it possible for a shrink to race to cause
this somehow?

Do we treat this as an entirely unexpected error condition? In which case
is a WARN_ON_ONCE() warranted?

> +
> +	/*
> +	 * vma ahead of last search position is possible but we need to
> +	 * verify that it was not shrunk after we found it, and another
> +	 * vma has not been installed ahead of it. Otherwise we might
> +	 * observe a gap that should not be there.
> +	 */

OK so this is the juicy bit.


> +	if (mm_unstable && last_pos < vma->vm_start) {
> +		/* Verify only if the address space changed since vma lookup. */
> +		if ((priv->mm_wr_seq & 1) ||

Can we wrap this into a helper? This is a 'you just have to know that odd
seq number means a write operation is in effect'. I know you have a comment
here, but I think something like:

	if (has_mm_been_modified(priv) ||

Would be a lot clearer.

Again this speaks to the usefulness of abstracting all this logic from the
proc code, we are putting super delicate VMA stuff here and it's just not
the right place.

As an aside, I don't see coverage in the process_addrs documentation on
sequence number odd/even or speculation?

I think we probably need to cover this to maintain an up-to-date
description of how the VMA locking mechanism works and is used?

> +		    mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq)) {

Nit, again unrelated to this series, but would be useful to add a comment
to mmap_lock_speculate_retry() to indicate that a true return value
indicates a retry is needed, or renaming it.

Maybe mmap_lock_speculate_needs_retry()? Also I think that function needs a
comment.

Naming is hard :P

Anyway the totality of this expression is 'something changed' or 'read
section retry required'.

Under what circumstances would this happen?

OK so we're into the 'retry' logic here:

> +			vma_iter_init(&priv->iter, priv->mm, last_pos);

I'd definitely want Liam to confirm this is all above board and correct, as
these operations are pretty sensitive.

But assuming this is safe, we reset the iterator to the last position...

> +			if (vma != vma_next(&priv->iter))

Then assert the following VMA is the one we seek.

> +				goto err;

Might this ever be the case in the course of ordinary operation? Is this
really an error?

> +		}
> +	}
> +
> +	priv->locked_vma = vma;
> +
> +	return vma;
> +err:

As queried above, is this really an error path or something we might expect
to happen that could simply result in an expected fallback to mmap lock?

> +	vma_end_read(vma);
> +	return NULL;
> +}
> +
> +
> +static void unlock_vma(struct proc_maps_private *priv)
> +{
> +	if (priv->locked_vma) {
> +		vma_end_read(priv->locked_vma);
> +		priv->locked_vma = NULL;
> +	}
> +}
> +
> +static const struct seq_operations proc_pid_maps_op;
> +
> +static inline bool lock_content(struct seq_file *m,
> +				struct proc_maps_private *priv)

Pedantic I know but isn't 'lock_content' a bit generic?

He says, not being able to think of a great alternative...

OK maybe fine... :)

> +{
> +	/*
> +	 * smaps and numa_maps perform page table walk, therefore require
> +	 * mmap_lock but maps can be read with locked vma only.
> +	 */
> +	if (m->op != &proc_pid_maps_op) {

Nit but is there a neater way of checking this? Actually I imagine not...

But maybe worth, instead of forward-declaring proc_pid_maps_op, forward declare e.g.

static inline bool is_maps_op(struct seq_file *m);

And check e.g.

if (is_maps_op(m)) { ... in the above.

Yeah this is nitty not a massive del :)

> +		if (mmap_read_lock_killable(priv->mm))
> +			return false;
> +
> +		priv->mmap_locked = true;
> +	} else {
> +		rcu_read_lock();
> +		priv->locked_vma = NULL;
> +		priv->mmap_locked = false;
> +	}
> +
> +	return true;
> +}
> +
> +static inline void unlock_content(struct proc_maps_private *priv)
> +{
> +	if (priv->mmap_locked) {
> +		mmap_read_unlock(priv->mm);
> +	} else {
> +		unlock_vma(priv);
> +		rcu_read_unlock();

Does this always get called even in error cases?

> +	}
> +}
> +
> +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> +					   loff_t last_pos)

We really need a generalised RCU multi-VMA locking mechanism (we're looking
into madvise VMA locking atm with a conservative single VMA lock at the
moment, but in future we probably want to be able to span multiple for
instance) and this really really feels like it doesn't belong in this proc
code.

>  {
> -	struct vm_area_struct *vma = vma_next(&priv->iter);
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	if (priv->mmap_locked)
> +		return vma_next(&priv->iter);
> +
> +	unlock_vma(priv);
> +	/*
> +	 * Record sequence number ahead of vma lookup.
> +	 * Odd seqcount means address space modification is in progress.
> +	 */
> +	mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);

Hmm we're discarding the return value I guess we don't really care about
that at this stage? Or do we? Do we want to assert the read critical
section state here?

I guess since we have the mm_rq_seq which we use later it's the same thing
and doesn't matter.

~~(off topic a bit)~~

OK so off-topic again afaict we're doing something pretty horribly gross here.

We pass &priv->mm_rw_seq as 'unsigned int *seq' field to
mmap_lock_speculate_try_begin(), which in turn calls:

	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);

And this is defined as a macro of:

#define raw_seqcount_try_begin(s, start)				\
({									\
	start = raw_read_seqcount(s);					\
	!(start & 1);							\
})

So surely this expands to:

	*seq = raw_read_seqcount(&mm->mm_lock_seq);
	!(*seq & 1) // return true if even, false if odd

So we're basically ostensibly passing an unsigned int, but because we're
calling a macro it's actually just 'text' and we're instead able to then
reassign the underlying unsigned int * ptr and... ugh.

~~(/off topic a bit)~~

> +	vma = vma_next(&priv->iter);



> +	if (!vma)
> +		return NULL;
> +
> +	vma = trylock_vma(priv, vma, last_pos, true);
> +	if (vma)
> +		return vma;
> +

Really feels like this should be a boolean... I guess neat to reset vma if
not locked though.

> +	/* Address space got modified, vma might be stale. Re-lock and retry */

> +	rcu_read_unlock();

Might we see a VMA possibly actually legit unmapped in a race here? Do we
need to update last_pos/ppos to account for this? Otherwise we might just
fail on the last_pos >= vma->vm_end check in trylock_vma() no?

> +	ret = mmap_read_lock_killable(priv->mm);

Shouldn't we set priv->mmap_locked here?

I guess not as we are simply holding the mmap lock to definitely get the
next VMA.

> +	rcu_read_lock();
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Lookup the vma at the last position again under mmap_read_lock */
> +	vma_iter_init(&priv->iter, priv->mm, last_pos);
> +	vma = vma_next(&priv->iter);
> +	if (vma) {
> +		vma = trylock_vma(priv, vma, last_pos, false);

Be good to use Liam's convention of /* mm_unstable = */ false to make this
clear.

Find it kinda weird again we're 'trylocking' something we already have
locked via the mmap lock but I already mentioend this... :)

> +		WARN_ON(!vma); /* mm is stable, has to succeed */

I wonder if this is really useful, at any rate seems like there'd be a
flood here so WARN_ON_ONCE()? Perhaps VM_WARN_ON_ONCE() given this really
really ought not happen?

> +	}
> +	mmap_read_unlock(priv->mm);
> +
> +	return vma;
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
>
> +static inline bool lock_content(struct seq_file *m,
> +				struct proc_maps_private *priv)
> +{
> +	return mmap_read_lock_killable(priv->mm) == 0;
> +}
> +
> +static inline void unlock_content(struct proc_maps_private *priv)
> +{
> +	mmap_read_unlock(priv->mm);
> +}
> +
> +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> +					   loff_t last_pos)
> +{
> +	return vma_next(&priv->iter);
> +}
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
> +{
> +	struct proc_maps_private *priv = m->private;
> +	struct vm_area_struct *vma;
> +
> +	vma = get_next_vma(priv, *ppos);
> +	if (IS_ERR(vma))
> +		return vma;
> +
> +	/* Store previous position to be able to restart if needed */
> +	priv->last_pos = *ppos;
>  	if (vma) {
> -		*ppos = vma->vm_start;
> +		/*
> +		 * Track the end of the reported vma to ensure position changes
> +		 * even if previous vma was merged with the next vma and we
> +		 * found the extended vma with the same vm_start.
> +		 */

Right, so observing repetitions is acceptable in such circumstances? I mean
I agree.

> +		*ppos = vma->vm_end;

If we store the end, does the last_pos logic which resets the VMA iterator
later work correctly in all cases?

>  	} else {
>  		*ppos = -2UL;
>  		vma = get_gate_vma(priv->mm);

Is it always the case that !vma here implies a gate VMA (yuck yuck)? I see
this was the original logic, but maybe put a comment about this as it's
weird and confusing? (and not your fault obviously :P)

Also, are all locks and state corectly handled in this case? Seems like one
of this nasty edge case situations that could have jagged edges...

> @@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return NULL;
>  	}
>
> -	if (mmap_read_lock_killable(mm)) {
> +	if (!lock_content(m, priv)) {

Nice that this just slots in like this! :)

>  		mmput(mm);
>  		put_task_struct(priv->task);
>  		priv->task = NULL;
>  		return ERR_PTR(-EINTR);
>  	}
>
> +	if (last_addr > 0)

last_addr is an unsigned long, this will always be true.

You probably want to put an explicit check for -1UL, -2UL here or?

God I hate this mechanism for indicating gate VMA... yuck yuck (again, this
bit not your fault :P)

> +		*ppos = last_addr = priv->last_pos;
>  	vma_iter_init(&priv->iter, mm, last_addr);
>  	hold_task_mempolicy(priv);
>  	if (last_addr == -2UL)
>  		return get_gate_vma(mm);
>
> -	return proc_get_vma(priv, ppos);
> +	return proc_get_vma(m, ppos);
>  }
>
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> @@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  		*ppos = -1UL;
>  		return NULL;
>  	}
> -	return proc_get_vma(m->private, ppos);
> +	return proc_get_vma(m, ppos);
>  }
>
>  static void m_stop(struct seq_file *m, void *v)
> @@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void *v)
>  		return;
>
>  	release_task_mempolicy(priv);
> -	mmap_read_unlock(mm);
> +	unlock_content(priv);
>  	mmput(mm);
>  	put_task_struct(priv->task);
>  	priv->task = NULL;
> --
> 2.49.0.1266.g31b7d2e469-goog
>

Sorry to add to workload by digging into so many details here, but we
really need to make sure all the i's are dotted and t's are crossed given
how fiddly and fragile this stuff is :)

Very much appreciate the work, this is a significant improvement and will
have a great deal of real world impact!

Cheers, Lorenzo

