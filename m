Return-Path: <linux-fsdevel+bounces-51008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AEAD1B8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC1E164CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2128253924;
	Mon,  9 Jun 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SN5eaIj3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r8p57pFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD22F37;
	Mon,  9 Jun 2025 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464861; cv=fail; b=PCFs5Hgj9vHgd8hBaRnwgqJksRzxspJTu3dG5QqGTW2EI0m+oaosaJxZ4pDaHd00JvFnMPwr1+cqwVz4h2pHshYMEnNHHZ2tztf2HduZ8og9cSsVd0ROeWh3vP22PWCE9M6K87QB9VrBroj7WBtaHpzxEd55MyCHljc1X6OzlCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464861; c=relaxed/simple;
	bh=ssaK6N0EybhTG78jnjctrfu8rCq+BmrIU1OMvd/Zjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdAyd4y7KIErI/6pmBNPVkizGPGXq5yvYzCCVHBdMADiQj9yOuck9J/O36qtdR+HqfPThu3pZ5WH8an/HntffbQ18JEpSOnSkilm5eEUkWdbw+Ahfm6qTJ/ujaMb9V+q0Ua1VuvSDXIcvLXIdKgCuni4K0qkSWyrgYZqoc1/2aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SN5eaIj3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r8p57pFS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593iepZ017184;
	Mon, 9 Jun 2025 10:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ssaK6N0EybhTG78jnj
	ctrfu8rCq+BmrIU1OMvd/Zjdw=; b=SN5eaIj31NJqP2KF/pUpqWyxMspIoqXITx
	3+IKPitaS1eG7yB7GKQDy05w/VrRZtBqnH/1HRjuUhD7YAd0p7H8X62kdrPayDVf
	qYtbXOriid/jWbzfK2lXJMEnDYBMdVa3hSSu4/MbzdfxG4o5epoTOVLKipHbgmla
	0EpAIjXNj0iLxTdBrf4Ahhcy83HCH/cFtPYl+8RXIE/A/3BjdYc8Y9U3ip9RVeK5
	aT8fxlY5bDYC0b+kqxjS5xzEeCpKEGsV8u+5zkGjtu99iSPMAMzJzpyid4q+4uFl
	hAPWlYMJeYFh+zht6rf5Wjnm72fHU9zCqdaWr4ACj5qfUbEDGihA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74sw6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 10:27:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5599UWRQ020413;
	Mon, 9 Jun 2025 10:27:25 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013026.outbound.protection.outlook.com [52.101.44.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdhd2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 10:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjlfKEzLHpNMnFwfa7WqOpSRB7JLUTwhsXI/OkqOrXbxhNUuU3C35cp7Kp+ekGvfOWGl87reAFWsrclreYmaQFk9QDmAHFgnp5haddPrh/lQhbr8Sv/pqy/m01MTTnDGCHGB02w/dSrjhIb6vxvEbi0fZKjrN//RYQ1ml7ZYjyWKdS9HecMNt/x6vAISqKWcXblSB+1HKuIeyW6EJj77UFyxE8PZROJjYjeUuxmCuQv9u7S7QOnxt1KVReQMpJXqc6QgOicPVw0/bm9sEKgrh+LhZmcQFsxkAPxWAhP8wW9fyRcLc6XwfCG1NelM5a1Bony0HYlyEGVOJn0sYtz05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssaK6N0EybhTG78jnjctrfu8rCq+BmrIU1OMvd/Zjdw=;
 b=ZNxS9BXgy8mu32cX4cFsV4hXZ6+mx72XfiKcU5c3fn/I+yLhV/iS2K9TIt/d1pLSdfZSe8Agt1LcWFovQN0+JVLAJeW0f0mN5ZQPo/daIxw8skrIdpk93FzKdI2KmkrmssLJ0qBFqsbh1DoOtnParO9/IhmjZwngSghLF0PGX9MaJj94rRyHGfw6CkgSK6eWb/OFAA6sTLfitCxycks0gY7s65EvNdcHxpQ9QNrkcjo/XjO+Q36SzfkGSB5YNP9Dbx3Tcw5nPMO7N0Hq6JZCLXDEohtzSXsZJqurB+LuwA6BDfOY+sVFFKVdckigsMxBckIgB0VQ6QCY6AB2ZP+cOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssaK6N0EybhTG78jnjctrfu8rCq+BmrIU1OMvd/Zjdw=;
 b=r8p57pFSo7me7E0yrnRgol3NdrKfm34634p/6QSWIS8ktdaHl1X2hAfYKtoNNd5qnFBocSravfbRidpfNJKF6cv7myYCRRJkjbJ2p78iAPVT72DzJbuhwwYp0HJUlwMizkiZyWVfag6uVSsUS2emgsalip7dmo24LrONc+baoxQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5800.namprd10.prod.outlook.com (2603:10b6:806:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.38; Mon, 9 Jun
 2025 10:27:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 10:27:19 +0000
Date: Mon, 9 Jun 2025 11:27:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <20b306d5-c0fd-494c-8737-0ed204a9f89d@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
 <30533e96-75f9-4568-add8-05a0be484cfe@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30533e96-75f9-4568-add8-05a0be484cfe@suse.cz>
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: e08cdf4e-674f-4fdf-9edb-08dda740369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kLM0vl8Nqo81MHUgutstFSUBP9TFb29xaDABz32SbE0uKbY7s6qvivL7YoT?=
 =?us-ascii?Q?ndvr7k3RrG+VWwz6K7y5lRdEeZFbJFEhEra7Wfe19XryrywAYZfSnTgI3YUC?=
 =?us-ascii?Q?BomXgle1A1SdkWsXeGgtqAy8xjZgf7oXmQtdtyNcO7UvTKzkyuMtINm4PYfU?=
 =?us-ascii?Q?nVJasjFjcXq5QztZTEBg3W2Lx2wsEVmHTfapwSDVfVvx4b7YvP9JJGs031D7?=
 =?us-ascii?Q?20o+GkNMue344wGzFkjdZYa3ecbWXtBQzDjyNsToo6YtZxwZ2ACAi5aNA9rc?=
 =?us-ascii?Q?8NFBVH6KwKFF1U4+lJBP6yEObXlfRcjxXBoI/3g0PJreHlentTig8re1okcd?=
 =?us-ascii?Q?J5PNoX1Rf4KXCRRoNj89Bwmq5dcmGlI/z5jVhvZumMa2qQc54Cnj0GP12laG?=
 =?us-ascii?Q?TyWvAW93XKYH55sr6JqtS3w0ZKR7PYamiSBUWVTANEJxkFY+An9fmQonu8/p?=
 =?us-ascii?Q?nGfwLIltAUeTUJJRSTngIMgBnpfSfKiaVx9+8Bk+3cg1PWmkJRYYwYFRhjB+?=
 =?us-ascii?Q?6uPx4gQ2aJoQQ+h4tVOQhlaDD9LIrGnRnVdc/qYYj9LsmFdDkL+Ry7Qm5Tws?=
 =?us-ascii?Q?rWelWlqrAwGYWIzle1w5MJaHB0NKyALJ6cvoU8RkxNfmTBNR6QI8eMPTlz3F?=
 =?us-ascii?Q?BSw2ttc7ZH5DH3ym66sUP3pVsAHOrPlGan27puMqQcHroZNAOgdgb7JABMz/?=
 =?us-ascii?Q?FL9bqO4ZVTPPlbXcqgN6AGgu313kHIWp6jPLctXfaRW0v82fFJ8xnrS/Su7V?=
 =?us-ascii?Q?gNP6mammmkAbEjcx4cLMdLnrc894ACa8bUwcZV5slgWcUMbxT1D6dmKrC4Hj?=
 =?us-ascii?Q?KF1g4ijkXVs9ixdsjOQgw1cqdkcxYMn3OLDSV0EVuByb9p8eVGMD4NuZh4cI?=
 =?us-ascii?Q?A3vCE2cGS/HGj1jI+5aW57Gu6FE9U9LeGdyYfLVoInKPtCWXeIoGj+xbGSAn?=
 =?us-ascii?Q?SsHa5g0lwU5npX1cTqSm0xCuq/zT9KiB6rfO0Ib9fbCVfF9kViqAEXR+eTPZ?=
 =?us-ascii?Q?JmR0DTct2e6wYNPZkl3sZUvMYWmLM3NimmHBH2G8W79Z5w2PSapeRj2TQqZ5?=
 =?us-ascii?Q?/9t8zAY39O44/UURCG+czFiHLvwYkU8gBDbR9BbmbgTSYD5q27/sTNMOXCXa?=
 =?us-ascii?Q?08NtkENbhdLrnvl7L1fi0na5FPx6Lzkar7WqeR5/RtXZiosPwjCZonKrfRGv?=
 =?us-ascii?Q?6yWojTyZXEuZRd7d9TrLhmsNfPPp/egdYvapzfc5GFbbEZzOACXNcVLmsOnl?=
 =?us-ascii?Q?Uc8KacO7b+3CnA3c2lkZIsTtPavcXk3LMkEEN0FGoNWXn+OhDN01yCtnOu3h?=
 =?us-ascii?Q?YvFQH844hhDTtdL7J2tY++lNkTa4VY1n69r07mglIrESiFBcO504VfZr7Dxr?=
 =?us-ascii?Q?NJpOxHahhF6EmYqI9GbvCcUWJPtsl644pLOyURceFChXjH/OlLFhA+1LLr+Z?=
 =?us-ascii?Q?Ua5l/vdgxik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSMvqcioi6MiYIrS7tlD2Rztg5UK7gtP17h5ahsLNAzIp3b7dryJZ8/+N08y?=
 =?us-ascii?Q?mCOGNGDlHgiW9etRzdVabN3uTD9X3VUc5j+mkps1xVVBatnzpp20OQOHVlKo?=
 =?us-ascii?Q?P7a5xSphOld8fP6N9f+PMMJtSLXYuc79xLzlA/PwglqlSLExyPuEh3mLfmYM?=
 =?us-ascii?Q?LK5ng5MH0M7K0OmA82oOe1DbrghnLrNc7//ryAs81M2opTiZMKyKnVlukVGB?=
 =?us-ascii?Q?EqircsDKDOIu4bs5Nmt+/spVpSeD68slt+kSX8Eff5oiwkILesf2fxA3A9Z0?=
 =?us-ascii?Q?+Qkkrh68tPlPQxib+eH02X6M3D9bVuMpTdi3xsSE93g5jJLswa4FWKveKMqc?=
 =?us-ascii?Q?oIt94/u97l/ZqDmDT7r0IJOAbVzQ9j5iBwqS/nvyISpHaBEMMFgfr0RFzfi+?=
 =?us-ascii?Q?1wHp1pP9nw2CcyXrTP/5WwcWKg8/hAyKR8597BcrRF7gWi3H/lsPZMPhnd+M?=
 =?us-ascii?Q?OTQX2GaYov5rQ4wnCd0wz5UIkht28/EtQQrrPOVE9CwUvru64b0gD0kab14F?=
 =?us-ascii?Q?2p5MMlzZsnFAIbFp9fPCjh0ykCzqbVT/io2x+nj9pZUi/DSHbZuqDD0CdtO5?=
 =?us-ascii?Q?XwNz+ecP/kC9xTSaVTOA+Gj9OEjLX7TGL6s9bFrpn/NI8+QNtpFl4q3qiQ5X?=
 =?us-ascii?Q?tKuTJFZ5aYqWSlg+hgnvPed/q5Mikrr7/vgi+29YfjdXi3d2U8vcE6mRbkH1?=
 =?us-ascii?Q?S3X/TBsxnLzC4hHrwohq/6QPotk7BYKx79MGZAljtaYMDy3ZXZiz8HyKfhbX?=
 =?us-ascii?Q?RBXAZIVTzW0dS07cQ6L+NnUH6izFH6xoAiNLJFzYKTYTJLrhIFWBUf6Ktq7z?=
 =?us-ascii?Q?biFg1q5Yy8qHwJteuTCtf5onCkCr/ScBXdfTuTHybSBNWeucdE1ZsbqlegqQ?=
 =?us-ascii?Q?qJEOGLFTnUxlveV+Y0IDm8ULDWhLYbcsnSONTdAD2yP7ZY9FiNgJkESDaZR/?=
 =?us-ascii?Q?KkwNmt8Si4Jv/+8xv/oJBeeF9BCwltGU9Spwpj1TXERBmtBf47gnVZ/nPyCW?=
 =?us-ascii?Q?gQlAPZ4QQLxAHUU1wqq1qn3z04XneIlsmemcUx0GLxw7a7hf0JDh/lRF6g93?=
 =?us-ascii?Q?mLhhPZ+Gwf/1g8Rd6lh8oGXlfETMWrI31vt3LDRO20wYJiq+kon1dSSmSdjn?=
 =?us-ascii?Q?tl/cSZ0WIFF6sKE4/KJ6lToYPozX2RsUmTZaNDkWP4/vZhGXZUyKO7EGB7m1?=
 =?us-ascii?Q?4aiiINYjCFLK/G8IB2U9etxP1ltJPu+dqfXJ3pe3J+8EfChfMpyhskYRLHbn?=
 =?us-ascii?Q?gROKp0CIvzYJpjpb2buLUhUs4lJN6uWkzRvcc98No7M7RvaydncXipRrLfKa?=
 =?us-ascii?Q?zCA8nnxO0Cjhe33dm01p2nvKAs7kHAaerAGILVplj5OT5KWNZ1bgMZ6+H6nZ?=
 =?us-ascii?Q?plfcHW9KdmV1QMX0cR1gf2I2jl1XA4iWugbLyEmIpbESzBFzlNwjrA2itg0y?=
 =?us-ascii?Q?ERDE750PD4FxQph0g88PDpJ90zK1bvy/HWhuhcpIE5t8F987Y0sq8UEdcPpC?=
 =?us-ascii?Q?oy6s+9TIhf32vXM2pN7IalUaTzOMSdn5eamvChoDuWf4H27zVNZaOWv6h6o8?=
 =?us-ascii?Q?DKb0UCZeZtt76xSpu+r4tHDJ0ZYgHvotW5sq/ThzKxabiUlg6TAZQx/t3OIy?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OJnPfliyqZZ6wYxzrJp6ZZ67cX0lAOrjJGvafpNNPFnNAFQ6+0jJaOxrWrRONlLhHgKJNew+SZg1PPeeF4hH4iTPZgNJVF7Pf+K3s7tsRPMh9pMTzzIyM144MNE2usZr05PHBr1EjGtJWr9RKYIBde+GZdaZ05+QQjUiBdOxpUB3aHkS83GOGvsvidPCvYJ8XT6ef6QsLCT1/hCmNQ9f1X+zfhOcoecgtYsxDwEV2RjXWxf7+OWw3YXGqeFx58D/Sw3lk8DZs3JCuAKaVWmOVhe6Q8BVbKOPcb3hBFwRWmJQatHeQvEQ1tMNlyyBYYiYLoliS1oR2ItFv7DRF8jJj8QbqHN6wDdEZIq+0KMHjcuQs3dzrrUhiQHDC4ycRTezr8I3nxeu4Oc9FjkkICxRkBGssdNojd1T1LOrK2oxGgrj8MDXVEiboqrpjYbmULDC1dO6hCRuyqeX3L4lrc8DfCfE2YnyxQyBOlZqrWds3abtBn7xw6Noavy/SzYlnBLYBA31bj4/VxcEN+g0f+bNLP6sYIoHleVA/77XOJ5MT7YR4O4xCqV++Uvc1G3Aa7WbcA7WRRQfseNfryNhii02daVa/4sgLhPJqu1OKBvX+3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08cdf4e-674f-4fdf-9edb-08dda740369b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:27:19.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUamEHUFoqlW8SdWGn9HIRw0hJpCa2YuukPpZ0vBozwanVixvN3eixSWJ8xItBNvt9NDBaAqbr2h1oBrkqa3bz+lgJ+lHE/qMiUYTMdN2/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090079
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=6846b70d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=qnpbg_UeXN5IRK7YgEQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: AWYU-Z865XKLrpwX-CLCwdhW5LZ1yCUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA3OSBTYWx0ZWRfX417YSZnvGiP7 xte+hFhup38L6/TvJxt82jXq7waiL+A18Z4FoT/OgeOjfvjANa09ajEKd2RBbGbt2abith9T7iB bfnDYKXMkEdl8T0qRUJObgXQwnMjiUcIG9fnQOqQ//3m6l4v85DsZiBDG/Tmia5wB2Ka88xMkja
 WsKWmpi0uUh5Hh3wvE8DvWWKFbGYDliCaQzpj85IgloH7+2Na4p31UnsJnrhwbRvomb7KJJFSUr KL8NGGZeE4DB64YABnHapgObCWwOTDP5++lB0tCNkhF5KO/LEB2wHB0ewT4WjloFH0+m8mAIjlp 5qrfbWVCYa5le1/fJHr3HicbTb5tOgvTNL7kIlGAUvAqKpQKEhx7/eiORaO0z2GSGAkjgOSt6L1
 sB33s5jUkK3dFlaehDxm2r4Y4eyaDk+6D8iqoYOFHBLyfQ5rC2jnh6rm5Xs/rA3Aia+APMX9
X-Proofpoint-GUID: AWYU-Z865XKLrpwX-CLCwdhW5LZ1yCUW

Andrew - to be clear, this should be a hotfix against 6.16-rc1 :>) Thanks!

On Mon, Jun 09, 2025 at 12:18:40PM +0200, Vlastimil Babka wrote:
> On 6/9/25 11:24 AM, Lorenzo Stoakes wrote:
> > Nested file systems, that is those which invoke call_mmap() within their
> > own f_op->mmap() handlers, may encounter underlying file systems which
> > provide the f_op->mmap_prepare() hook introduced by commit
> > c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> >
> > We have a chicken-and-egg scenario here - until all file systems are
> > converted to using .mmap_prepare(), we cannot convert these nested
> > handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> >
> > So we have to do it the other way round - invoke the .mmap_prepare() hook
> > from an .mmap() one.
> >
> > in order to do so, we need to convert VMA state into a struct vm_area_desc
> > descriptor, invoking the underlying file system's f_op->mmap_prepare()
> > callback passing a pointer to this, and then setting VMA state accordingly
> > and safely.
> >
> > This patch achieves this via the compat_vma_mmap_prepare() function, which
> > we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> > passed in file pointer.
> >
> > We place the fundamental logic into mm/vma.c where VMA manipulation
> > belongs. We also update the VMA userland tests to accommodate the changes.
> >
> > The compat_vma_mmap_prepare() function and its associated machinery is
> > temporary, and will be removed once the conversion of file systems is
> > complete.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
>
> So this is a hotfix for 6.16-rc1 but doesn't need cc: stable.
> Also probably nothing wraps yet the filesystems with .mmap_prepare? But
> good to have this handled within 6.16.

Only secretmem uses this so unaffected BUT I want to make changes to filesystems
in 6.17 which is blocked by this problem (I actually have a bunch of changes
queued up ready), so it's really important to get this hotfixed.

Also, given the change in use of callback is going to touch a ton of filesystems
this is important for backporting purposes, in case anything needs
backporting there.

So from that point of view it's important to have it in 6.16 also.

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

