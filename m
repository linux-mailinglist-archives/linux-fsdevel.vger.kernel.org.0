Return-Path: <linux-fsdevel+bounces-32323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C19A361F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0150DB242DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F118CC1E;
	Fri, 18 Oct 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLKAqYQz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tP6k8Tx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FA17DE06;
	Fri, 18 Oct 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234218; cv=fail; b=hKDZXpZW/mYy9eS7QzLOzwkPJznklr++sIU/anqgUEKA+b5sd0kHyEyK6AAaR3euT6NbiukGsIx2SeAnNOw1oZQGB8mGvBTdRDRGXz7ObRuMTj+7n80ZNkEONax1Yl4ugtmqarZLomYjjYGAW4iGx/JGs8ZT/a/BwmP448AwkQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234218; c=relaxed/simple;
	bh=XUs3tN2gPlGXzD3q3pZZfmCgJAmEGYni4N6k+M2lLIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqXhYSxVHNlm8NUr0d3eFYL/mz6kk0LGAVsv6unbJEpZS3Km/8OzItFHbix/wgplTzFzyN3aio+Um5gC7pOaucwWGau7gZPzlTf+zFVUW3Qaym4pDc6WKshC3MZy+q47TdIA3AavwmWSrb7//b2T7vJ+23nhYhkNckZ+bIk/c3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLKAqYQz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tP6k8Tx5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNnEL1027749;
	Fri, 18 Oct 2024 06:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CGlqIH34uwi0G30pgY
	AvAq6bmvIEty554TR0KJ1iVLo=; b=JLKAqYQzJVL0AZH3IwND3hPphaRp2FCeFP
	sSkxNQqpTl46z6EZJtaawGQB3OAoFVLifAVfK8IkETCL/6fAyAM26BBajhYEJNgZ
	nC8P+b3FcWcmiHRrqj7349fuWED6spGmr4HkyOIG6gzz7wrfFbXr0/TNM5ZdsYxL
	CSpJuNrDxcfj01/zubNhCbycf9hDcH1y8lbCqX4XvThi2ljONayoz10UsguHidDC
	OG9Y8/v0Qx2cltz90TtQK6UuiMxTClYyy3NJ+NOYROTEfudpYCJtCgRzfl885Ebq
	X2lq7zNut2J5jiu46AW83MxaRESu2/3/pdRBx9Pmr56zQ1ODf8Sg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5crfqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 06:50:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5t1Cc027250;
	Fri, 18 Oct 2024 06:50:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhu6jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 06:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgPcm4eMalsSTGtiqyMC+0fARb0BlcDLjEVoVYxIhPY46Zk3K4EWcbMPcNLph3fhzUyzaQgrYwCErmje30GcD5MXqPCw88KTm5MBLTrsN+g+0g9eGou0avuZe564UMXSyGfU1q4HjFLDys0BJ81PbKjBC8iA9Om+7cTypi7j465D/VvK1d1p6nz9pmozY9Qkl/9QPZ5tYy0Zyuw5I9txhfumkrNEl21UQsox/KZ5T52mQZjlLygjrnYzfE7zZK0BjeaP/DRk/7jLm/bedxc2epetnZOl+rRDPoVv7Le62CaRP9W7JII72vuqPQRtmxDPhxRGGHKFlkPBFCeViOoNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGlqIH34uwi0G30pgYAvAq6bmvIEty554TR0KJ1iVLo=;
 b=d2BDV6QoFz4rInCKf20kDoW0+Qhw2gHdZa9BqZZ3dyhROBbcJbNdemhSnNj4pTh7gO1+eg6a5r3D7ediFaaGJNI01wumZafMRX3vKEVtH/P+pXCdCmhoP4OGxrev6GUbXQFH4mOPYTDco0kEcVf7k1L6aCrwwKBwoTcrOSypx5Rvwyz4l10Kup5+zmT+ELYJoh5i/aC4rxUL6aeOjs8E03B2PxLzK4APW1yCaaqhotJm8/y8e35v+Fdw7lQCpXuZiZ/TOo1yz7FB6GdB9uDM/qMKgNzs3rM4aK2i1HACb3kdO8jRoGRaxgyBt0gKP9FImC0bAz14cGWuA975Yr9xQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGlqIH34uwi0G30pgYAvAq6bmvIEty554TR0KJ1iVLo=;
 b=tP6k8Tx5NJL4gtII2H19LeWGyXx8U61qegaGcFslFMKNzOVcals08owTEVF/HKLyjpX9hu9qTkZlHN8acnJ2dGBkQnRq0ChxHbddypupRFPD8O3B2A822RV6KK86aFp4fErvcRt8Qeo2t7W+G2r9TL/YYCPkq57K8EjlETTX5bM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:49:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 06:49:58 +0000
Date: Fri, 18 Oct 2024 07:49:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
Message-ID: <bc07dba0-90c7-4926-ae38-71c3c3e17e16@lucifer.local>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
 <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
X-ClientProxiedBy: LNXP123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::34) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: e3338751-dd4d-4647-5b04-08dcef411515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZesKflPEdw9fxg4cSf2TD6U1zn0rkWrewnNpK2szpF7m3rK/bFpsjW2kq8E?=
 =?us-ascii?Q?Wjdd2cBxr/KPR3uxCML7Vsvfh1qbumy1u1zrqO844cnerRDFcFWST15o8mt5?=
 =?us-ascii?Q?9OTeZYstWPH38VMs82ZaU7CgC+HFKwAZV7wTUW/q3iR35JowrzCYbGjhahGg?=
 =?us-ascii?Q?vyHPyKkcJGcYbC+9s5fFAS/dCTbMzKm/Xtp1fNXtnGMBLdnHQms8ZS+hWBLZ?=
 =?us-ascii?Q?7YT1Nm0qGFJLWZMjh4Y7yZpRiekEM80D9yFazGfSSyqebr7QIsps+XYEftR8?=
 =?us-ascii?Q?NGtZTD29voomhaZVYkTc1tJGfvR1WORXu9YNm5/a3l8U+dqtLOTyaz/BF7Mf?=
 =?us-ascii?Q?bjuJI1a5GwTGsr6q4oaRgi0CpZA0BNQkfRarQN79pm/lE2Jp6gygX4q7A5eP?=
 =?us-ascii?Q?e6eMK/J0Irs8XSgMcnsJUNCSvYDssR+H2UGkBlzTxzpmPRa5pkQ1YcvIVTP2?=
 =?us-ascii?Q?NRv9h12IrLVIJIonWtd2M3jaB7yD+iDAvQncM8treEx+bbvEUZlRpHaQZ2bB?=
 =?us-ascii?Q?rhVG67BkRVE8Lcrrjm1ekS6ThueNUJ6buSqusTxLUA3mwrICGZk/D/lA/Odf?=
 =?us-ascii?Q?HIBzfqQMuh52RroNC6etYAHWNI02pj595z+dHc4/sDHOp08NhQyBeyWWyN1U?=
 =?us-ascii?Q?Sxpen88k3JxUymEIGidS1fg9uujg20fpcWlZC+1jw8UZ87ChRV/NtHPJgV2G?=
 =?us-ascii?Q?QPpMZuutbGSrePvbTnmeku3BtiEPIHjVcBhkV3usku/al4Gh6hrUXhtT4C45?=
 =?us-ascii?Q?FnMzkCUqqDbPtaPoajsi4vUrB8zYjRtp4ziQUfNsnc4ztLC7vankG5TZohdH?=
 =?us-ascii?Q?yHIiWWxITfbRkjSEFHdJxksCe1166LTPQuIQ3VQzVpfu93Pw3ZksYF/5Va2u?=
 =?us-ascii?Q?gSjzbwHuRMpWBOg6wWiqVjstr51yT64qcoj+BvSg2si8hwUZN99Bw23FIkEJ?=
 =?us-ascii?Q?HwUdyORsxshw/qXhTQK95TMnj4RWhO06GNL3evrma+sj0SUu5HW4Fj+fDLBh?=
 =?us-ascii?Q?Xb55JuM/Qe+s3vN89uFGER6c/veMhG9z5iCFdQYGuecx2oFNtlPZWgM6Vm93?=
 =?us-ascii?Q?63jRZbURv2WaJ/sJ871AC6TGBsRx4s2bs57oVJnRX1jTnyljCxdS2hPYZxI2?=
 =?us-ascii?Q?dl8LM7NQeXY0oUpHCXVNlyjYwWY7PzAV7Q/Xq3v3OHGh66jg0VBv7LM/tIEj?=
 =?us-ascii?Q?ziOBmJ0EYpksRUgJD4tAZVYJhGDHJKWMxsnvCLdOWZ67FBEhVK4vSrAwfZgh?=
 =?us-ascii?Q?YUhwItZmyWL6JqUSvGU9jvENoK7Na/uYoHBMG2GdSR+WdTK9F/skAsS+ZhfS?=
 =?us-ascii?Q?CrJ6kxbPxLghB6Kt2c2ientR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNN2BDyrR0HtoI58ahqrKP0XUTZSY/+K4AVSpFGgjBHeBZncwQFc8I2oKMyK?=
 =?us-ascii?Q?5LhxhUw3ACK5ByISDPoFZofzofIC47UUOIrTGQwn1Dd4DnyAKRu0JMO8KqAT?=
 =?us-ascii?Q?V1n1UAMo83PoQpaVaTgCpuN++h5LLSdgRYo26OAVGsUrmY0/CHx50rPF4UyC?=
 =?us-ascii?Q?d/r+Aw68cWRFvKug3GOedSYzMRCl4SvWvNtYouKm1YVMLJWwoXNWZDBhFRST?=
 =?us-ascii?Q?/bP9GhG5z3f/s2jF9SAIJuj57wosU1EGblBlErzP41O6vVk8iUFKy5MxVHmS?=
 =?us-ascii?Q?PXBhs95K68F6O4BZ8yy6lEDBvNN0Ml3H/sYHfhOTQpQGZlYL4fWUvtZh4XvS?=
 =?us-ascii?Q?e3CpkMETT4j8g/WkHVkZhGHG+KUrkOPyTXMasO1ukz9oQL3eRAZ2rQn8dF+A?=
 =?us-ascii?Q?ROKFyJQ6W1hA2z6VQQKVHDJTCBvziJ3xHn+yKFLXWk0JEfXiWxvmcRsouxFA?=
 =?us-ascii?Q?kUl47TNpkBkOHkYLzIkf3zir2yJMusmSQlqFsdtrH9AUfCFIFQCPCKnHbR1b?=
 =?us-ascii?Q?9JehzDk/ygCL+DPi5lObCw1IVTZ9ulDKUMIanYO2L9BbTs9qYJigD2wCEIYf?=
 =?us-ascii?Q?lLDJhf17MZJpGio1cf8zd54gdV6DVhc/glBMjDsrnVbsD92DVHsCtHCE7GEk?=
 =?us-ascii?Q?OpX1+lMebS2FlOZjO+CaaBL3e801P8zGQlM9uE7bTZ9IovWo6jsOPopJXnch?=
 =?us-ascii?Q?y/1eExI3k4c8SOZb0VycX+HkHs4FP8K3G/snJk4wC9vjWRNPrBEw+8JiGNqZ?=
 =?us-ascii?Q?S8wDSUk9XrYfU0y/w6CadBBVPRyLHK2/K1U6762K0dxm5xqOaIyOEIG+iksQ?=
 =?us-ascii?Q?qzNromrXkGTyegu/awwFffyD3qTU9e4GmhlWDcSoEJ44Zir1uAhtyZ0LlUp3?=
 =?us-ascii?Q?5jYL5LkOP8KcyG/xw5sjBoA9GRnilUDulV05RwT8PVs9HYmKv9Lx0uD4Lif4?=
 =?us-ascii?Q?+ig0+k1pVuUVzcOHGO1mSkT/Q/yajTUV0r8fp9sBtIOdS7aqU1j2EztHQlYB?=
 =?us-ascii?Q?IbnaYfMRhZkdnI5w48nYzGBJsR3M7v4vxw6os8ne9lbR4AWAPYtH5IfofdQs?=
 =?us-ascii?Q?LihCwWXkqRetm+uKV9m2RqvR94vtx2ARJnzDZUhKE2sdGRWcO3Osa+/W6J2j?=
 =?us-ascii?Q?uzVcBlWRmHqFuOq9c8wb6PJOGMaDroosRg6h8r3EMynqCPQQIcOwoI+z6d+e?=
 =?us-ascii?Q?bgq1o7P7+fI4vXbzkizqVQqw+/CMQO1bYAqCJcq5hZPJO21wmQ02P7VDAn6w?=
 =?us-ascii?Q?Q6afb0/vdQs5/o8MsBrYuPRY+GrQBwl99wsX2TIPEsKS+XKjY1yNfrj5gQTZ?=
 =?us-ascii?Q?hPzhJgQkXODmpldr4GqAjPb6q5mv5IbWey5Luda6SpYbwAv2z7Gu6FDK9E5w?=
 =?us-ascii?Q?JnSRvXC9dEsMQ5HDW12yon2+r3JywsE0EGXJubSb6yQY7+lrwJ7FFd/r3/f7?=
 =?us-ascii?Q?u7GTDQ83dfiPjUm4MYL+zRdztQI7V8aCz1IXjsYvNTfjt+bL7gTXP1Ogc2JX?=
 =?us-ascii?Q?qvn70SODSrS3c/GwEDHWpCHQhiWdvLIGhW19R/PwrD42P3Uv75eipxM5JWOE?=
 =?us-ascii?Q?ePraunrNGXOmZtCaRiXwnGzveBkzMW3VAtnPz/jb9lPGYSvHmK029mDJS7uE?=
 =?us-ascii?Q?5N2lYYHjkAy6pAwZ6HOTZyMwe6hxnME1B1a20uIsayz5sgLl3q03JuIr1U3L?=
 =?us-ascii?Q?XSkrJw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIWqQTaiOYm7+AVZeSPJcaCCtrcavO65lHhjisTHhJz5tnvKU2aiJz5QrDa0X5yaX1XNsNdxunyQ7aZpuiuM7eBpup1MSeY7DKEdlbmXI3LLkEYzX8hZCUOcCnKOe2QyPcCgDr6U2LPywSHGNdcVSptV+k8w7mBMwbf9uZJ7fA0mkgbtAmeHN5MnlxOMMwiO/514P0fOoUWA49kNx1HA10F+1MBHVOL3cvYAyltshiZ2QTbG7qBXu4gxD0Oy+fWHooEpasKJWoIY7s5kiHdOECoJ6sFnPqTQ4gnBcE1gSnqEJk97C9WGfPUUNNRtwJrJUWrJglV1EmFjhCucMsygf8zeg0rozgnfecFNOEI3Ps9FZQwOkIv+rHmpLEuiI227m12f3Vs7ZdDIk+93v6H15yVT+CS+n92xV6n4x8jVFUMXnsvigr+Fv05GOxn2mdlkR8j5PSsbESMO+uEvqdCj+R5EiDf+wIKVNjOllrak1snyPHbetCpHNFOQhr3Pmr71Jf00dSBcjZ0Ewt3mu9igvFcy7eqoHU2QPGjwihj1YO7R3fuPmkSr+5TlNF6N1jS+vl5ekLqVNa9bhUpjK5oS1YfTXhimoImmgiLwUKWqM1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3338751-dd4d-4647-5b04-08dcef411515
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:49:58.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnn6C2QAGbyDXMJ3vPSMcZ2EGYNaPDxeou5sCImoEjxIy+bT9wudxBLH6nNm4+/1hl0OLcA9+Gy9zDfGeQ6okvflebPxHZLkiaBSnUr1vOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180041
X-Proofpoint-ORIG-GUID: 0bg5BdeAC3PX98qha2FRHRHjGexckR6q
X-Proofpoint-GUID: 0bg5BdeAC3PX98qha2FRHRHjGexckR6q

On Thu, Oct 17, 2024 at 02:45:43PM -0700, John Hubbard wrote:
> On 10/17/24 2:05 PM, Lorenzo Stoakes wrote:
> > Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
> > the linux/pidfd.h UAPI header.
> >
> > Work around this by adding a wrapper for linux/pidfd.h to
> > tools/include/ which sets the linux/fcntl.h header guard ahead of
> > importing the pidfd.h header file.
> >
> > Adjust the pidfd selftests Makefile to reference this include directory and
> > put it at a higher precidence than any make header installed headers to
> > ensure the wrapper is preferred.
>
> ...but we are not actually using the installed headers, now. And we intend
> to continue avoiding them. So the ordering shouldn't matter. More below:
>
> >
> > This way we can directly import the UAPI header file without issue, use the
> > latest system header file without having to duplicate anything.
> >
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   tools/include/linux/pidfd.h            | 14 ++++++++++++++
> >   tools/testing/selftests/pidfd/Makefile |  3 +--
> >   2 files changed, 15 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/include/linux/pidfd.h
> >
> > diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
> > new file mode 100644
> > index 000000000000..113c8023072d
> > --- /dev/null
> > +++ b/tools/include/linux/pidfd.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _TOOLS_LINUX_PIDFD_H
> > +#define _TOOLS_LINUX_PIDFD_H
> > +
> > +/*
> > + * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> > + * work around this by setting the header guard.
> > + */
> > +#define _LINUX_FCNTL_H
> > +#include "../../../include/uapi/linux/pidfd.h"
> > +#undef _LINUX_FCNTL_H
>
> Oh shoot, I think you, Shuah and I were referring to different uapi locations,
> the whole time. And so the basic approach is different after all.
>
> Your include path above actually refers to:
>
>     $(top_srcdir)/include/uapi/linux/fcntl.h
>
> ...but what I was intending was to copy a snapshot of that file (or a
> snapshot from the one generated by "make headers"), to here:
>
>     $(top_srcdir)/tools/include/uapi/linux/fcntl.h

Yeah my first version of this used the uapi one but I thought doing that
might conflict with snapshotting? Also it'd mean you'd absolutely have to
have the $(TOOLS_INCLUDES) earlier in the include priority list and better
maybe to special case in this instance.

>
> ...and then use $(TOOLS_INCLUDES), which is already in selftests/lib.mk,
> for that reason: to be available to all of the kselftests:
>
>     TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
>
> The reasoning for this directory is further explained here:
>
>     tools/include/uapi/README
>
> (And I see that selftests/proc has started using $(TOOLS_INCLUDES), that's
> progress.)
>
> And now, it's possible to change fcntl.h in place, instead of using a wrapper.
> Although either way seems OK to me. (I'm sort of ignoring the details of
> the actual header file conflict itself, for now.)

The fcntl.h and linux/fcntl.h conflict is apparently a rather well-known
horror show. It's a difficult one to resolve as the UAPI pidfd.h header
needs O_xxx defines but we also need to include this header in kernel code.

An #ifdef __KERNEL__ block might be a solution here but fixing that is out
of scope for these changes.

>
>
> > +
> > +#endif /* _TOOLS_LINUX_PIDFD_H */
> > diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> > index d731e3e76d5b..f5038c9dae14 100644
> > --- a/tools/testing/selftests/pidfd/Makefile
> > +++ b/tools/testing/selftests/pidfd/Makefile
> > @@ -1,8 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> > -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
> > +CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
>
> Instead, it would look like this, which now mostly matches selftests/mm/Makefile,
> which is also helpful, because eventually this can be factored into a common
> piece for all selftests:
>
>     CFLAGS += -g -isystem $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
>
> I apologize for just now noticing this! And these kselftests shouldn't require
> so much fussing around, I know. But once we get this just right, it will work
> well and last a long time. :)

Yeah I know, but this won't work due to the header conflict, I was doing
this previously.

Also doing it this way means that uapi snapshot doesn't override the usr/
one if you have that, which I guess you want?

>
> thanks,
> --
> John Hubbard

