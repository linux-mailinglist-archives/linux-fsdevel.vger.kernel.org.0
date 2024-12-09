Return-Path: <linux-fsdevel+bounces-36761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75AC9E90D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9542163B6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3A217655;
	Mon,  9 Dec 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzewonLP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v9Mw9887"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47432130AC8;
	Mon,  9 Dec 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741287; cv=fail; b=g96b1rrHQ6hzyqYFebWmfwl6UzSiXdX9zEyL/+HZTdy4T3lZC3RPFNPj7R6Odg6/WJ0/C5Jefcei4ltXg/so1eKN9owCg2DgnwU1MLmbG+MHs49BDnH9y/tTqCnSE1szAQ9heaQRtpSJn5hajnA16Dnrrjs+ToNMdaw5ugl/cig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741287; c=relaxed/simple;
	bh=jJ0y7mh1N8FLgOZG3sQP3kLvlJNQBmnqJL5T6lxaVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tw9AgdMx12QiI3CFRPuVSqsXcss+NKq45jOfaWdrmmBvY5iQB7mp+5XqvAJ1qiM1YcUj/mqcEIjNR/sTuv/j3AW1VSEGDy0Rn8y41O1ik21lRd4fDH3pGu6vigmVHEHBT7a85xiQ1WRvbge2je+NTE347Yvod02CW9yyM/Hj/bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzewonLP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v9Mw9887; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fsYA011201;
	Mon, 9 Dec 2024 10:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jJ0y7mh1N8FLgOZG3s
	QP3kLvlJNQBmnqJL5T6lxaVgw=; b=HzewonLPU7JQPGlDjj2YxiesBgyWYGPxxJ
	uEgKX2rfG3XWtW2glmtvgx7omQTzqvh++r5TCbP1e5ALQtKYgWkyQRgO59+1SZYD
	p2adoySBUdWlciW0xABuF/aZE6PeQaDvSc3LDtL3NYVHsb6q/31kggyAttoGA1pT
	suZsBykknUGaeuVNoQQzLYe6mk0g3IPF7ru+HA/dHtI8u2jDLCJ7XarDPrm6UNOC
	LydOJofAT2S5SSyvSIhrf5nTv/MNcaJNFKJWDusrv/GCV43Ipgdy1U+FVh2EBZD2
	3Cu1j6Qo/+mh7vIeCeQTqVHWmFHbcj5c17vUckVUjeOUCXl8j99A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy02yre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:47:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99TGQG034958;
	Mon, 9 Dec 2024 10:47:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccte67cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbj5fl26N7mYL7tZYx+yltoZmHGh3QLcQfrNFPFNH2VbNGQQoD2fqCA6GXcquK+vYDMDcREldVreRn2HpraJ6fC0TPAfENkJBoJ8zaM68xruAbAe38lsyJ6HpmwGXtEmBrCmxG+LfdmAd1KKeFygPUu43igwMzwh6GYNd9kARQKBcefKPoGa0nTz8c2DUeOTm+zI0caE/vTKEMtP7VqzeQOk5hmRdCjJG76Ti0ZF3U0WyvikwiSc/aKjbDkPNZk5yY3ESUGlOtqUIEJx4tQ6yZ9PAqzlZt9YEbSR1F3LutH3eadvTB/Msq/eZBs+WoVE86Zo9E9BrMx3rm/9tNnrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ0y7mh1N8FLgOZG3sQP3kLvlJNQBmnqJL5T6lxaVgw=;
 b=kzZOUQKh6FsISsSSAYSGy8NLvRj22Xsf9b76BvNdTXO4wWDCOFELkzHlikYxwNutXBHORRwFsCKZ2AMuO8nRNH01cinc5PCM5UeTH93fs/zd+UEIikNjWhK5ctYaY/pxWbZPIR5jogIr+lXgWMAQMq38o1nKc2sYZ/vwNbXmiHiHR61qzMdZ28uHh9a8dAuuMSShuROdjJbGQQf+VTNxKfwgj13PhzjPlAsnMNsFyciOZHQrSYa5s1HGDiW4X4lOFn2CzgF4JJQ77JAEgFH+/D8AHdtPGdEA56YYp4EAmlGIYoBvrn0m/aRr6mHzs3JIn8NMLlJdu1bZIzsu9r81AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ0y7mh1N8FLgOZG3sQP3kLvlJNQBmnqJL5T6lxaVgw=;
 b=v9Mw9887DzXkqesc9vfG8Ia7PRVuoLxJiSrCxHAVFV101JUi7sEBHA7kzXqX7hqZedgP2Fwra7ki5bTL11+t2kO7RnU5pScL2nAnj1HmWof7nRcEbLI7MwQvKEAk8Oe0vxwThGgNxllzoNrTRymJ7XrY9e/AbDbiVDGQZKzu/q0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 10:47:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:47:49 +0000
Date: Mon, 9 Dec 2024 10:47:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <7205d7ff-22c2-4169-a3d4-c031c09c0f3e@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241205001819.derfguaft7oummr6@master>
 <e300dfde-b6a5-4934-abc9-186f7fef6956@lucifer.local>
 <20241208112706.cmzyrotgnjflv47h@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208112706.cmzyrotgnjflv47h@master>
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d5599c-0c14-4eb9-52a8-08dd183eec95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oW+GR1vjYdOKe067RHcjzPMHYdjjTBvRBbtNnxpER4YiVi3aNgdGgpyhVH8b?=
 =?us-ascii?Q?TDprfiOm5bXorFVLIRNahspLiHraX85v92hpTe7zzbYI2RiQ3Qbr+z4QT3Mr?=
 =?us-ascii?Q?h45A3KJ1w7yCZ/Knt7+K/cimdFkodrggXGV3CPkqIvsWV96aeqpoxqH6fDv9?=
 =?us-ascii?Q?5uYfdOQ7PuZpFiy0KEwgcGgvIKncGJrI0BNqYnvzeF97q3zebG8Z2LbSouIo?=
 =?us-ascii?Q?AGVO3QPOjg7i1AUKbXkfrIq7SG/aA+Ye7MczwMV1A+fmLDyk4VqvW49ezN6N?=
 =?us-ascii?Q?fmjndQtlf54jJPjb+VMCZfLAhrX7SLMwJ2ND4rroimFw8R5F5ZVCWjrftNdW?=
 =?us-ascii?Q?LAz3JQqwnwzUG0C0DjzQdeDDUgJgP7Gu4E2ds4soLy2mLPdy7f6G2nKfttjY?=
 =?us-ascii?Q?Fis7Ll6ShgsWy8v2R2HBfa06f2tm/gmPCF2mFPjiG4CzTH/MKUStK1RLVQTj?=
 =?us-ascii?Q?WDS6WYMQJ28ZJL9qsjlUGkFDo/NLjRXZzoM4p1yQWZsozv/ortzX3HcCpXSz?=
 =?us-ascii?Q?Pb/D1GNjNu7fAU+VPGv19/nU+YkLzzGb2dnmgbIGwj6oHtrobYYl5It93kte?=
 =?us-ascii?Q?2HyHW8o5ZIUeRftl0I/cxanzB0lccr0HLBrQoBAOmJxmkBk9T0a7UOXcdxvN?=
 =?us-ascii?Q?jLXcg0u+nTWw4AxNZHnHYWYmqNYnHZT9s+RXE6/7Di+PXXzrv4XmwixdyuLq?=
 =?us-ascii?Q?66mLefCYzklnroYRYrZtq1AAwyky9JD+BncfP2bBdzlRl/WahOpTkhetzgH2?=
 =?us-ascii?Q?xSrsZcxR3ClYJEs/XXrw3DbGrt0yJa97Xgt7Cs11l8LgZ5z1jI3sKHs8hgQE?=
 =?us-ascii?Q?rmRWHCPPrxXhrInzlZ5QNJZ8OgkwO2DCoTG5AdQynKmDtj9oZx7sGm5HQ18w?=
 =?us-ascii?Q?zuAmbe8OpjR9bQyaOj1cQ+ziLbK3okAOMmnGzAhiF3ww8hw7CNAUi0Erigkl?=
 =?us-ascii?Q?y0TxT8ctCVehZHu5XCntiessoQfoFXzzdl9phkWolq1ECaR3MFKAIiLb6D1p?=
 =?us-ascii?Q?N/E34mpToQIW0JBM98fDSQLO9yGysyCN1U4G1EFmWp1eK4pAD0Vp+71p7jMD?=
 =?us-ascii?Q?AEOx5GVnWvP8Ah0a4gVfXbMs69a7uwnuccMezmh1KIra28CXk3IK8naihwSF?=
 =?us-ascii?Q?6OshQnUvBJD/X+meK79gwPt8svHXQ+GlKtxiZVnxIsPOEtIV6Yov+47H+AUD?=
 =?us-ascii?Q?RqBqGm13OZ70/gonJcrxPLtY43ZX+cdmz8PSh6TxRZi+0CNe56V+J/icPWUJ?=
 =?us-ascii?Q?zVtHV2XNggySnLKdC3hpnSuhTPnkalGIOCm8y74KBQHlYl5Cx9QhOgHu5nx5?=
 =?us-ascii?Q?Bo6QM7vC5Ge4YeWHlZMSV6l5yBiNBYhb3SVTb0TI5Jli9MZT3mRrckNFpGg/?=
 =?us-ascii?Q?JRjE6pg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxXtzJinIPkbE1ZhjPb2zwQ2aZdLBAuhLJZ5kl89+fZQq6hTenJmDgy7n2sA?=
 =?us-ascii?Q?a5hD/51aTJVXHuXSzxNPc6ZwNpsflGiEYnGAA02eVxA9IDXBgB4knoQW0HZF?=
 =?us-ascii?Q?t+jqRTjouWMRx61WgbGYLzJSLIxu5YqGXK4FpDzniY5EyZ9311LxNEvsnuso?=
 =?us-ascii?Q?zK+GyoQw1kGRauPvsb6W+xMYqbkhnHpjNu4DD8jjoXt76jQiqM9vz/2uxIO5?=
 =?us-ascii?Q?PPdVlYFNXyg7mcSGCOoTCIRnFvb8q34QAJtnxLnbLrynva6Qjo3M66IdhDio?=
 =?us-ascii?Q?ncWAkuDEwWAbptD4+S/krpKcyZ/x/sfp+7mUNQsgbMFPKDZ0kLN8XDRluAJn?=
 =?us-ascii?Q?xuFOvYHpPg9/J4bdHz/Usn4wux86cNWbrkW3XFMQM8hjmDG1MsO3/B9lUkZA?=
 =?us-ascii?Q?as7+LA8Gb1TN9sA2tCua2+46KtQ+vIXX/qyt2RoisnlyFx3PTgHKyoA3lSR/?=
 =?us-ascii?Q?gqHa4V/KKN4IKWIJeWaw4FQWGUWg9sF+4AxhBWZTyUJge9arbz4M0Hrlgo47?=
 =?us-ascii?Q?NT2i1aMRuMNILQ85Gg8/8KJRk/7Rtd5CfVGhc+3A/YtaaHcJURxXColMMoPQ?=
 =?us-ascii?Q?y7wQAmknrEYo7JoyUg2HWCQ9CgDW3G6KR9aD/+gbu1QSLUH4byx1xRMTmr5W?=
 =?us-ascii?Q?7pzvAvHMrFu106tGlYjdy7VKBITaOvEw29yRyjIyFTYOnWbyW8LdF2y04hkk?=
 =?us-ascii?Q?enm6qvA7DirDJMwtIEQqsrX6xLuZLqOlFVO+w8O2h9jtXa2XDJx0S3fMgn06?=
 =?us-ascii?Q?ERnz6mQ2OU2VOJW/psYIAyuOX/+JzrrSxQrWV7xngj6oRu5wjEBcswzVTXtA?=
 =?us-ascii?Q?v/7W8fAN7lFVnzuj2RI9iv5htqSvHjARrGcZfbgo9Xi/zjoguA+P2I+euBka?=
 =?us-ascii?Q?tO/0d3gxlq5ZhF0UUTLdQQam3vayDK+GQ03Jlw1qMZcDsf5CCLR1Cd4JHpZv?=
 =?us-ascii?Q?dqt+sEj9vtIYV0doTv7jWk8+OUNcGCIBhx+xEIOCtvsZ+gXMEGQQnJJznIEV?=
 =?us-ascii?Q?V7WxNcDfz2MFx132oqGzt33v9/84Od8NHSt9Dl13D0gC+Xp1rmEburTgjFer?=
 =?us-ascii?Q?f2EV+gA8GKe/iUftpnlD0ps3fEcRErAffBI4p6CIM72K6m3FpUHtBgLPnt84?=
 =?us-ascii?Q?+7+kZpF0c1XsEHO+s+lGtVCV2yDFXyHvkBSvnFgfVWn6qj4V9OhMqtTMTHB3?=
 =?us-ascii?Q?iHonwRKC87ITrdev4eM4P/2i5Yj93vwrhfkzi08P/IYnNJ1m9qLIGOT013Kp?=
 =?us-ascii?Q?5Up2Rnl4PX7iw4HPAS35iSMwPE5TtsJ6zUmP1HXGeSbqOcnerV9Ac9JVC2Ed?=
 =?us-ascii?Q?RHxt8oRtjZeTolOTnKs81bhHlY0v6Ja1Jc8rnE6oTDgUhou61Po3eQnty330?=
 =?us-ascii?Q?txctuFRA9z0feiqQc22/y5ixAKdXCUe9rtVJ4Ix5rwsRY0T+Fod9dLT2U+i5?=
 =?us-ascii?Q?Ov3lfShmHnxJ5Ro2FdAYyO/XNWPHc50GUPmxourR30D8Efm/a7CQ9CT2jIBD?=
 =?us-ascii?Q?rbpwaq+35zRyh+WviTEUQaaDdjqrUqXigqZBr7WBr503h0l+9CX+pbXiDRLV?=
 =?us-ascii?Q?v0IDcUrFp2A9xsaJ7uLxHkaMY2ObesEWz9eUVpcO+XC/u9Rg2Bk/eo9PYRRm?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivIUiLYQgzz+/AiocEJHrd/qnm6X2gkLq9r/yI/Nwap2X31gj/P+yk8O1N+NYrlsBnylGqId/ufHEkcb1m0qOpnzm68v+FmFMqK4cpzXjxT6BE4BsRjGpazGEQ2F0B3g8qtpRsYrdYs4GVsXBpexKnrk7abLy9S+OBEHPOQ2kGwx9NcmVQWVeaey2h6gMatt0EPAYT15/Ez0ficUftYE67gAtVr3lVNZVxO0dd2QVYM59Kq/JHfAEwjv+/H+yv+L/+cvF3XS8rGvEou8FaTk8qZa4P9nnu/Xso9HOwZImQE186uEJPoyyFXumUfLpIsw0Whdw9CAmI1GRh06T2sxAeBRsvvEYdXzUQVRdeIZn6jh1cODTF8ggdzgMrwzkjddZ5fAdybF9xpPhpnbquOXn9US5FsQOnPxclF010LCH+uvjPxjz+HQcY+qoR/zH6lXThDmcFrmkMmqQAicwrZpQBzHndL8gXQOkvUtIK5jJ3UTa9qSeg+6YP1h+e0wiffemcTVincLLgRXugmmAu00eN97f1RBSUJCNcMxEFKJ3xjuFM4i7zOx0KBlT1I2MiaIeBx3I+jYhTqcrQKVt8iTrflN4+Jm6xrIVRlzMIbyeaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d5599c-0c14-4eb9-52a8-08dd183eec95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:47:49.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPE3CgmiM1rmYLJc9AJP8XN70W79P39FdqYumeqfzFN6DtHyHnMGf54WPoek8cvLrKj8QVwvEU9fB4vyuq48z5/XcntthztnspkZ9/NcFO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_08,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090084
X-Proofpoint-GUID: lZgTHN-_XuFCwLcbICi_62CcMscpkavH
X-Proofpoint-ORIG-GUID: lZgTHN-_XuFCwLcbICi_62CcMscpkavH

On Sun, Dec 08, 2024 at 11:27:06AM +0000, Wei Yang wrote:
> On Thu, Dec 05, 2024 at 07:01:14AM +0000, Lorenzo Stoakes wrote:
> [...]
> >>
> >> Maybe we just leave this done in one place is enough?
> >
> >Wei, I feel like I have repeated myself about 'mathematically smallest
> >code' rather too many times at this stage. Doing an unsolicited drive-by
> >review applying this concept, which I have roundly and clearly rejected, is
> >not appreciated.
> >
>
> Hi, Lorenzo
>
> I would apologize for introducing this un-pleasant mail. Would be more
> thoughtful next time.

It wasn't unpleasant, don't worry! :) I'm just trying to be as clear as I
can about this so as to avoid you spending time on things that aren't
useful.

On occasion I think, for clarity, it's important to be firm - otherwise if
I were receptive even on things that I thought not worthwhile - you'd end
up wasting your time doing work that might end up not being used.

>
> >At any rate, we are checking this _before the mmap lock is acquired_. It is
> >also self-documenting.
> >
> >Please try to take on board the point that there are many factors when it
> >comes to writing kernel code, aversion to possibly generated branches being
> >only one of them.
> >
>
> Thanks for this suggestion.
>
> I am trying to be as professional as you are. In case you have other
> suggestions, they are welcome.

Thanks, what I would say is that simply observing that we might duplicate
some logic in a non-harmful way does not necessarily indicate that this
should be changed.

Obviously if you can evidence a _statistically significant_ performance
impact then OF COURSE you should report something like this and send a
patch for it (along side the evidence of the perf regression).

But in general, if you feel the need to refactor just for the sake of
eliminating branches or grouping code like this, it isn't helpful or
useful.

Refactorings can be very useful _in general_ (I have done a lot of work on
things like this myself obviously), but it's important to assess the RoI -
is the churn worth the benefit - does it make significant enough of an
impact - and is it 'tasteful'?

These things are at least somewhat subjective obviously.

What I would suggest you focus on instead is in finding bugs - your help in
finding the bug where I (ugh) set a pointer to an error value in a case
where, if you were unlucky, it might be dereferenced - was a really helpful
contribution, as you can tell from how quickly we approved it and arranged
for backporting.

I'd say this ought to be your focus. For instance [0] was a horrid mistake
on my part, and ripe for being discovered. Having a second pair of eyes
checking for this kind of thing would be very useful, and discovering this
kind of bug as early as possible would be hugely valued.

So yeah TL;DR my advice is at the moment - focus on finding bugs above all
else :)

Cheers, Lorenzo

[0]:https://lore.kernel.org/linux-mm/20241206215229.244413-1-lorenzo.stoakes@oracle.com/

>
>
> --
> Wei Yang
> Help you, Help me

