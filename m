Return-Path: <linux-fsdevel+bounces-29989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF8984AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE98C1F21341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01FC1AC45F;
	Tue, 24 Sep 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsPB5jyE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ErWhSIWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F31581F8;
	Tue, 24 Sep 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201269; cv=fail; b=F9tPXl3Ker4tQqRnMkfzGwoLkZRYCST57cABNUa/qsUaAZLa9OVOrylc/ASKGi5VofZCrHIMkdvTdy7T1F6pGcV5B/pRCfwc2QKk3IE5AVBLR6puPlMrJ9Iqua72QIBm3YyKBgHJTh2pvcArsuEuWI9I6muVxatkn3Y19ywEU8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201269; c=relaxed/simple;
	bh=3jWLTHm5eqY8/OxQfnv5cbkGVtCduHFbHeHukqdxQJw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TWJOBbsdm43MTwYMfN4RDraG+63SVBA2mBv7bab+uDSPE5csGM4jVNxQgYPevmcsWHKeMwSJe7gJZu+5NU6mgtO/0Cpj081f2rTjhkVSfwrWA8YHD/PhuN3sjNOUPoRtUIPfnRdUEXWNoj1BpOsCReS3TPn7yTa9OJfG/eN8/eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bsPB5jyE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ErWhSIWO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHMZER010240;
	Tue, 24 Sep 2024 18:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=28qEvuulWQT4eI
	mKMQMyDo919Nn8bEJXkAJ0DwmHlVs=; b=bsPB5jyEXOWaoFaVjWUj4+MTwbNjOl
	RR6geOqQLksffp9T4h8EMgGkdyWnzNqKzUVCcmMGdAzpEiJYjx3qGUSS4W89PcT3
	9v923GDxvl/cwSPN09Nryuy25tSFQaGUSBhpxAqMN4bsTjh3MPpGXwrxBJzx9vfn
	4u51dyyNfFi6k91POUmCbjvThV2kfiQq7+iIJc6rH586lTDplost9o68PPzV6kJ5
	AO3IQ9BLdrNLI7aR/LlbFsRt+AXSjg5w9MskxFeWykPKYfCc6zf7IhX3MaM6R8Zo
	DhYGYQuhhqsIN8DSslGbYsJ/8NnRJi20Oum7fisItLBkGiaJZ0qopdyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx35t6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:07:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OH9xTd031285;
	Tue, 24 Sep 2024 18:07:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc66u5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9FkU68zF4o0stbLat+DgR10JmL9ukjnjquq3zFAdEppuqpG88VfWznYVm/xiKFS6LCVPQ4Tdk6jlbBA/LGGJ4vr+dVDQWqjq9kMnKF896Q3UHuF4NpgGZiYYyEbOIq1YJ6RLdXgPnlEc4JyAsPlyDDy1t7Ij6lKggLrKSMg9ngQbHatge3mcEXvwjiiYTLRnUtiDr3Utj0yL7yS6k8gxfC5flBUFzWV4pj9kdBsKfnOwrzUcBEKGJNYLBX01ic3gtXShMmrgWah54XoAlEt7Lmks0KAC8epqd2zXjSmvqDaZpOEP/4OhCccDbmXg6XsaRtbuDT9nNHYKRRACHwG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qEvuulWQT4eImKMQMyDo919Nn8bEJXkAJ0DwmHlVs=;
 b=FP5TSYgddehh7m8djbHTIXrm31nzYUgeT3hl+OjaG4K4zt98CEew9L/5SWgzEZzgb3vfBAduXcWNDxYVhSVpW1Q1v4TFZ6K7pXIkiHdn5i/8kFywxvttfMPmcOIBH9sinfJ3uKf6gcV2F+qH/yJV6ytWqlK3Dgb9AJPQMOqSZjwdf8HIJv2RP87nXAFtgmXygX1S4JXz2aTz9XZhfUR5R5toKaJ3Z3RSXVEbyzGRXUOdeNNHgSv3b0D3LW/dtKa7IiREpiMmZATJVZx6ONpKPzYIZEKVc1qgOcZOsL+uxoocYdG1nkXfjgY//HacH+3JarASweU+/xGOsUdC2QnssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qEvuulWQT4eImKMQMyDo919Nn8bEJXkAJ0DwmHlVs=;
 b=ErWhSIWO0igBnH6vc1hxtpgBOTThja9hpz9SZUVlsdhJFhoxZaarTb75CgGfhDii9cDF2hNiIx3+Ptwr1hwZyKoGUjpEJ9i59bpbu6ntsQD2GnJTQnkEyWxbR9ox1RxAbT8NiTKFnJHTdzatb+q1EmTpjHrzcIX09aOp1hM0hA0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Tue, 24 Sep
 2024 18:07:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 18:07:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] tools: fix shared radix-tree build
Date: Tue, 24 Sep 2024 19:07:24 +0100
Message-ID: <20240924180724.112169-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb4539b-69bb-40aa-0c66-08dcdcc3c110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IgqYmX+4hHkPIaZ3yAqFDxx3fvnfjjbPy7wv0DQ8D4TYEB0ILk0KQ42MZFXF?=
 =?us-ascii?Q?7YbzYKvTCWWKMiMxJ6d4CojfnAMhcjFskVeHoSP7WaJJY7dQUoqAZhU/JQsG?=
 =?us-ascii?Q?fwtS2gyzt1oM6zN2xa+E07DtYWKKKC9M5CKxqMCJb6QMSdG0lvNx6mhYSzuX?=
 =?us-ascii?Q?kWD5zrFrUb1frVwcmftZMDHuYIvxHNAqCdlGIGZJQWrpZ2K5VF+5Qq/7xiLG?=
 =?us-ascii?Q?SVCD0qscTV2XcJJE3rqZ2VfWUsTRomZsDNPb8RgyX89Q6gya79lMYH/RqWVk?=
 =?us-ascii?Q?YJ4MpAVwR7yiw5gfdPxcujD+5VxPuWFlhRL7HQuyLg2XF9ziTVmDC5X4Oosi?=
 =?us-ascii?Q?jTF9XnOcM9DX2F2eaUqDwxQpXjuqM0qArqHwQ3VFeeGDVR8ELpZ+/1pDWI3s?=
 =?us-ascii?Q?Y30vQT+XfKpI60GYITchc+wQhdEptCSDVQ/zFYo7d9vTwo3aD/SPbjYzpgtg?=
 =?us-ascii?Q?HK23eePVh8VX1qjc8hrNyVL2Gawict5gy5gVU7KtlZ+vfp0uijLnHd46HxYR?=
 =?us-ascii?Q?7Xxoys48wc3s2EBz7CMFKZ/uxSUlmNApCrChAlbB62OBWkOXjlCB5VAt0yjn?=
 =?us-ascii?Q?6kI2BL8xUQ18A9q3T/KtOlt4Tomw120TQm/Ch6gzrwy/HTlPHV9z/GllPnUp?=
 =?us-ascii?Q?DOFcGrYQJEvA/PfUp7N3t4lm0Vnkj6at1URWBuAogAz8LNLMtnmqMwMK+jl/?=
 =?us-ascii?Q?RH2uGdTtmn9YcOV8QWbq8uT1pi9w6PuZJVgmfO/aPUovIwIL2aL3gIaxgnfi?=
 =?us-ascii?Q?ND+6vPiQlysHkvnAgE5K2mM1xv8EODSLTAUB5CLuLAX5C5l/mo/AKrIyKnCw?=
 =?us-ascii?Q?ooTNuVrKiNucASNFG0PFtR3TeN7D/pROG6YnLkknAMbjL/Oo5yd1g8amyfo/?=
 =?us-ascii?Q?IxOPY0xM3cqd7MXcF1v/4cpiakHYw2Em++0qVJvN7CjmuL+J90BLblRe+L9d?=
 =?us-ascii?Q?g1UuOY/jD2reGchhrylegp+dZC/ILNSpaA+SWAZjxoTv/x0o2GePzMrd4nmX?=
 =?us-ascii?Q?Oin0J+qLNPZ5vjEe2yuNXNXKVz/OpTsK6QGMDDICe1BX6ymCqE53zUKN4i9F?=
 =?us-ascii?Q?utw4KQsF9Cv+SjydoRzHajScvwV8ufSC4eJKvizAjPQrCz0TBo3H4z2T1jla?=
 =?us-ascii?Q?ezLbIZaGLR5eQTNwHEXj4VNGF2XcRMN4Hk0jGJ3JCx9eJX1VrxsQr8numeEc?=
 =?us-ascii?Q?hYSEgxMRvZc6puxRu8u6ojZgB42/jzJWm7GJYhkPVO472KFEDudoqVjISe/J?=
 =?us-ascii?Q?KINRiMdNR/Hh0qIuGESKpGUX8PYEuPeLhpyZk9sL44r5hCoHV1mLgyS6zkIr?=
 =?us-ascii?Q?bFidAgyCf31fpfxZuSWgZYIiahwaRb/SfOp9R0rRywfwkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8k8T/AxM/ENOVrZxtY2gVtaVpI2A5yzw3xKmYLO5EScVhzu7qWwW92WNeaF?=
 =?us-ascii?Q?nDfZFpCzQjv8ZErglUfRput7wqzuoAtiPC01pltCJjhiK7diU1sUdkf3oJt/?=
 =?us-ascii?Q?kMrVm6WJ1QKu9AkJWGcfkaDslRzY3pbKy6ISaRSfkgWB25jHRRPqJlI6Qps1?=
 =?us-ascii?Q?OC57iFQ8kToJ60Hn2K1iSLrG2wnSCxPQpdReK/2/Re0ikyWimO2Xp0JC6ez3?=
 =?us-ascii?Q?86qH2m8t/dY+NFqehv/mpcwpHfhp25nSONI1URdAvaq6uqNxijYyUQPVHmDg?=
 =?us-ascii?Q?PLvZvwAJdoq+pZMjex2EuxGHCCjGtw9a1VluquVvAngpE6XLEnSKuijWE7mj?=
 =?us-ascii?Q?IEHp0I9oDyCQxfzVZQ2PduBGw0mdFMQ3YNsaGk0apwRHbDB1ARx9iYOEqhUo?=
 =?us-ascii?Q?EsExiIZTt/vx9pyL+DdyzToAeNIZZV10+ZDMZNJMiT4EuKVcbcCy3EFHAj/C?=
 =?us-ascii?Q?qOabrtyU9LPduARQuB8+YSH6etpVN09Syh2EEWSFRHZ7yrj+ybaEb8LGITZJ?=
 =?us-ascii?Q?Z0/5obGOpi2/wQ67HB0DsDTkY2ZLDk1dNo1TmmoPIrbCekr79TgDKKxWQMKw?=
 =?us-ascii?Q?EubaWlJNcAU4yQq9CNJ5k5f3FXgTjICk8v2BHxThcWLDGoz3Xrgrrhio3Ytr?=
 =?us-ascii?Q?4ZqOnZmbqpDGWT9hcJ1ywfctcH6MB9Og5URShRrD0o23eVmzY41/c6lyMLvf?=
 =?us-ascii?Q?0aP3STDL0fikVxRM6rXe8rkA/LWx18VQ3nLxzjCYLy/3EGtUK3T5hRV2i8iU?=
 =?us-ascii?Q?FIt7YCISNM4i0MXOsgBbDNRjFP0igT8zDWoNx+Re8I/AyCHazgTxXyzvdwS5?=
 =?us-ascii?Q?Hq8Wato+8TeLxdaukRNhRC3kJTACcij7kxDWLfemJdfkoCTMMnaoF4INW2hZ?=
 =?us-ascii?Q?MNE6OAn+d7GxHqg8ssDp8KcCZmOAKKm0meDPWVPNUqVqW65BICYgJsZNRG64?=
 =?us-ascii?Q?dbKEYiN+C89dzZhvPjem8jNCm3UBwR0+eoS4Fx6KfFN5pLfEahJ7jCL89F+Z?=
 =?us-ascii?Q?NqCNvzJ86IivhW2oerIdcjZFFUfbV/j0mnJZLQ661QVoPe+m9eiSpcLk8WrF?=
 =?us-ascii?Q?o97aUWtS/5uIv90z03pI+LwsD9SlAt0sXK1EymH9qFygiX/tnLwkJZrS2ezs?=
 =?us-ascii?Q?MvyCN8a3gRx09UeGsxR98A8zoBFoZhRrh58dK4S+lY/aqQm4Kpyl333Uv2va?=
 =?us-ascii?Q?Mc3wxddgiVLNrQEuYucfBwr3b50ecCP2EqYmmJz0d2xgUIUqjBh2lWXMUG7L?=
 =?us-ascii?Q?2KsHQELP0E7p8ZBjfJ8qXN+YLOQNvCKcP0NmCrGyef2at2ZJ0vzhEVDHqbT4?=
 =?us-ascii?Q?sfE9udgLZz6Tg8fPnmzEhKPKts1plh8F2GtaY2fmNBdM6zwp5RkkedxylwqC?=
 =?us-ascii?Q?ZRpulh4MpAO9R3JP6hPeqpwiSofTXv6UjyIRJ6FXxwEHxc+/hE2TAX+l/Q8D?=
 =?us-ascii?Q?ehg1NwDtA9/gIApJ/44CMy7drzscA8so+gRJDZmQ3Bj5xiupR/iNEOuW+2sj?=
 =?us-ascii?Q?pYsFiM5KtxJunONLSspnfEaLxLS/ej1SrjVsJDGlm5peOcSdiFFbB6/2/53w?=
 =?us-ascii?Q?23VPS+Pfizrvvs+6cvTwm+VkQIg4o8oIiDwP9IDrnRltV+pI1AYcp+8Q5GpQ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ICxLTmIN/3Eh3hr9gDxHe7/QBEOvyJOlJpFhjDv7p+w9S760/G3e/v+XVCH0C/MF8iSA6ZOOuM6lv5itE70CZ5M+3PDGBpV6BHu51RSKJCFkw59xdLB3WCEOR93aN3Xqg3gaMpBP4YhsRwXCQmTwFzIbqCt0O9U6E+ZIzTXJK3EcAi/lbSMTZPMVV0it/rULECyW8teF7JBjeXJsKAZE42v8fwg0NW7iDiMqRqRy7r+MhBH9eRrnADZmxYq3iss5iUVb0JJsEXYj0WODkJODZsiqmYklmcdsM+qAzLTMKqzxPaqYzxy9RvyCGZIyjGMyIhQ7c0ap2AFYjquEqm91jcYSzZQ++DGk7Bpj66XWdjISP+u8aWGYppeqLC1zfRHDOy5UE1xXhQh2wW+2qmFArF/bl39YtEoMpOytNvLkLIAFsfnXaQQZRu8w1mGHutxyrBRqDlYb7sxTL9I7xwx57itS/TRkACeLSXekuo3OkX1N9bnF/jZoAWTdECVeFIdte/Ui842LUYg+dlqeHzPGOXWnJR+sUjdM7y5zd1ctLKYR0HXBWJvESOCHy3HTNYAX6lnVYmW72FCoxmWbLM3u1ZPtlRHe0/YEQgFopICLbEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4539b-69bb-40aa-0c66-08dcdcc3c110
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 18:07:29.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Z3YCYXJtaTqLhUmVr7gNMx4wu5u/ln+iXBfqL+biSXLyNJcn6HLHzGIWrEj5fle9mTA1aAR4xYWMLVLUJgp4JcNtnQL/Gj5+iy83wwMitc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240128
X-Proofpoint-ORIG-GUID: xnRED9SDl3eVKp_pZykNF2HZuujtBbcF
X-Proofpoint-GUID: xnRED9SDl3eVKp_pZykNF2HZuujtBbcF

The shared radix-tree build is not correctly recompiling when
lib/maple_tree.c and lib/test_maple_tree.c are modified - fix this by
adding these core components to the SHARED_DEPS list.

Additionally, add missing header guards to shared header files.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/shared/maple-shared.h  | 4 ++++
 tools/testing/shared/shared.h        | 4 ++++
 tools/testing/shared/shared.mk       | 4 +++-
 tools/testing/shared/xarray-shared.h | 4 ++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
index 3d847edd149d..dc4d30f3860b 100644
--- a/tools/testing/shared/maple-shared.h
+++ b/tools/testing/shared/maple-shared.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __MAPLE_SHARED_H__
+#define __MAPLE_SHARED_H__
 
 #define CONFIG_DEBUG_MAPLE_TREE
 #define CONFIG_MAPLE_SEARCH
@@ -7,3 +9,5 @@
 #include <stdlib.h>
 #include <time.h>
 #include "linux/init.h"
+
+#endif /* __MAPLE_SHARED_H__ */
diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
index f08f683812ad..13fb4d39966b 100644
--- a/tools/testing/shared/shared.h
+++ b/tools/testing/shared/shared.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SHARED_H__
+#define __SHARED_H__
 
 #include <linux/types.h>
 #include <linux/bug.h>
@@ -31,3 +33,5 @@
 #ifndef dump_stack
 #define dump_stack()	assert(0)
 #endif
+
+#endif /* __SHARED_H__ */
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index a05f0588513a..a6bc51d0b0bf 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -15,7 +15,9 @@ SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
 	../../../include/linux/maple_tree.h \
 	../../../include/linux/radix-tree.h \
 	../../../lib/radix-tree.h \
-	../../../include/linux/idr.h
+	../../../include/linux/idr.h \
+	../../../lib/maple_tree.c \
+	../../../lib/test_maple_tree.c
 
 ifndef SHIFT
 	SHIFT=3
diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
index ac2d16ff53ae..d50de7884803 100644
--- a/tools/testing/shared/xarray-shared.h
+++ b/tools/testing/shared/xarray-shared.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __XARRAY_SHARED_H__
+#define __XARRAY_SHARED_H__
 
 #define XA_DEBUG
 #include "shared.h"
+
+#endif /* __XARRAY_SHARED_H__ */
-- 
2.46.0


