Return-Path: <linux-fsdevel+bounces-36374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB69E2A50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927F5285973
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0041FCFEE;
	Tue,  3 Dec 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqjjE1I+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k0qHHnBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AE1FC7E3;
	Tue,  3 Dec 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249149; cv=fail; b=JNI1uUWtZb3JvACgrLRuW982Ymf2p1k1OZfaL+gHDcnOjSLScKe5KOYHTjk04ZdpuNgc4zWKIaCr9/HjcOYoiUclT9VCXZrXl3GwhxjHteuCmuLyT9KO1oy5PzLQ3U3lJjd3efV1Eh7yM9NmQH025IE4Hu10DpAO5mCbzTqOPd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249149; c=relaxed/simple;
	bh=cDNI6jzu43bDmxceP/M9BMewURl3fetf1kpz4IuYgno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6stuVe6tfGJMZyeKmQfVQLY7URlldMs3uv0BaUWeyO7ybzsxLrH0doQmmVeUPuWiBJMoq/bzX8Lu1/azo6RAjcbYrAo6M4wmJWnyHeR1IFxx4hIViPZyiURs3621YmXkAfyQ3vGE+HRmEfCOUVVGVg177USqzs7u+lx4P6Kncg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KqjjE1I+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k0qHHnBd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtbW2015938;
	Tue, 3 Dec 2024 18:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hltgmps9iDSMuG0QlMXpwxtDDGFu6Wuu6TFqLL2mhzc=; b=
	KqjjE1I+iBMm3MBAxDP9+95DGpR8w4fNjU4jGfYQBj1ZQJunmVHj96yHZDs5p9MW
	wKXOgbhP49rvIoLaLxv+UKZfSK0WyNRMFY/lnXUMudzvaGcpSJY7o/hoVpstoXYC
	AqHvuAfjQoMttBye15vT22epqlNX10oMolxWVMSSX0+2if2/GB1D+WGp1hF12ZD7
	684j6t4scwTSY6YnoLdU2A+lC/BK/t2Qzd8pvGSAJA17bF5lMIjnjRTyri674v19
	C9METtM/XZznMGPkvCAZAAh891YzqnJhiFE2mAB6Pw15F3WMqInIlPwoN9VPTFUH
	UDzbTk/bOKg+9qPzzMBNxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk8xgr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3GpVdO038066;
	Tue, 3 Dec 2024 18:05:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s58r9fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge8K4GwnyIedgXbdNMLIdwZrSZJiq3b/xvQEkTZDHJV4OUET1O8X+KYr92HM+BvQQkw+PM2m0Oa8X4CcqloTtsiV0dg4ECXUoFKygIW836v+XJJp+EzM1K95dV7Wb/ZL/+4T/RhJhfgCCcWQ+1FZFyWyn0gIBY5W2NLG5mkqWtiywEhaSwdaEwCKJr/JUx5wQdtTdXXrHdF+CLvSVxMtMUb9DiyoHO7vWc+mMf4Aew8GD1338IGyFrik0mQGyR2ZCbWXZCM0UrTxYV+s6KJ4hURg8z869v/cA9WMp1NIjtvFnAU5DIM7+lVdLJte4DudcDKk9RLW/FLLLL6IxUDe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hltgmps9iDSMuG0QlMXpwxtDDGFu6Wuu6TFqLL2mhzc=;
 b=suTlv0fKOaZ/MO4272OWvZZmO68krdTqyR64MZHmGqXuC1ZBKxxcEaQJXrlKyU4fhjYBamuRI80EQsZi/+MCPeMcZsBq7YhhnMiI6Gf7dhIl6t6bI7Grod+n82kD/V6JTh+Ozf3b4mvgVo39E8p+OkkjVzZsyd3ReTjaJ1gh5TgE7Js2zgHqEfYYVclc8f6JI0ObD01Wp3dkTk6Z41Vzb7EA3p+zJjyfHzbnVOteR86GUpUMcIWruQHJu+8laPmrFHtRdBKQ1CG931AUe/TQlGuRK0M5F0ss2HW8e4Pgw+v14Kfcq2zmcZQ3VqV6AMYaATgae5HDAJRBryy9w7XL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hltgmps9iDSMuG0QlMXpwxtDDGFu6Wuu6TFqLL2mhzc=;
 b=k0qHHnBdNuA7ckmrnjJ1sSlZh+nZaSp16vO7kQwqSCX7UPOMp8G+ULvY9J77P/LHBabZ6HFm7BDOj30v/p/NnfULFZ9N0oBog+Lwx9RIBT1EXPtBXrmzYlSY6bft4YYgq4RdYssFaMiQIyl8EzWHvsG64z+ZAvYgcyCQomI8iwk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:30 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
Date: Tue,  3 Dec 2024 18:05:08 +0000
Message-ID: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: b3867e69-d84c-4850-7013-08dd13c512a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gc1vywAMQIKtME34s60yjV5nDZdeCSaVbQ3mV3iQ1qoND6oanXTsFqk1pXwa?=
 =?us-ascii?Q?Ii/t4kROKHJvBVKRVUkCQRYKILJsw53+S9Sh5xKJjeH3Mj2t2TtOI3UDpI8Z?=
 =?us-ascii?Q?oNiGPRoBtwiyr098yJfZf1wtgLjZ7NcJz7kPqgK28XWNZzKy/yvOdIVgfR/8?=
 =?us-ascii?Q?to/3VuVsbezY+7v01I/FC/GFMKP7ryIJkHPhZKd5nwCVlfHHA6n+zUPtThXe?=
 =?us-ascii?Q?vIF1yz5YKSzuL3sSFLaPyfc/skGFV1IPDQf1bK1XV/gNU/YMvnqEjyG8ZR1N?=
 =?us-ascii?Q?yt9pRgJAX/Kfjw9gfk0j/1PDm2hVfY5L+F3lc9r4GEPz8ybPQfyU2tSjQ61m?=
 =?us-ascii?Q?wqYPSmU321AY/zW/HFY9cqV7zbQMCLqCdxmwPl412SF3pH03UljzFf/sJ2Ak?=
 =?us-ascii?Q?aayGmZkIRWmcYUwNiTscDluecRyTfdIyK3v4Pyhf4Wyo/FP1MoP0lYZR5ZQd?=
 =?us-ascii?Q?uRItT36UwsIqrRBOQYU5D+wq4jDj6LwnExwAfIs8swySd3ct2B8/6Tv7mS29?=
 =?us-ascii?Q?6kjJ6jDb8gzcL9AsfbSEvs3j92tdxgZkkfB3onX3veIWXuP81nwO69/jjS3c?=
 =?us-ascii?Q?AwCeg71Kqym0ZdEBCp3Q2jR4vPjFvs3zQn/P1OtNjh2y5lQa6ulrwzCECL6f?=
 =?us-ascii?Q?EvBkp6mTZLI1hzz+1vDakxxOS914t1rfIxYj4lrPNfw8xxC8qtMK6p/Zf+os?=
 =?us-ascii?Q?nc/3Rkxt7DX+SQFR7fCr/0CIM98h8bC+oP4IVYfVlFUYk8tnn4ckI4/uf6wL?=
 =?us-ascii?Q?MlQ4x8rfFgtTD8SWwLwvXSnzMf1JuSRqj+mMqiruWQxLRXy1tX4ez5h54TUH?=
 =?us-ascii?Q?6BPxN9Gtot9OWwlyOrvPcyiCbQfQo9W66LJVRl0YYw9PPHqfl/s16fF8HtU/?=
 =?us-ascii?Q?dnPXpQfbr67praiI4vnGGCx2rx3ujnMdZNxHQppjFvbIKA+tp/mO80Hj+jjO?=
 =?us-ascii?Q?6JB7JaD/0MXSmxsk171Ye8wd0DD2hnjzAQdKf3ImXMWbWtLRL2UXJtids21t?=
 =?us-ascii?Q?OUvn4XwilAIaHf4mRw6qDQfZ2NOrMZG7w+6/tzhFwHeb8ea+4Uu3YjWklh5k?=
 =?us-ascii?Q?kv/5xKq9fqPfJiErHFkOl9LcVSxm41pPO9IXaXdQfrOpgAm0ElehldfdxJNC?=
 =?us-ascii?Q?fwZQ6YvrNNPbuBDLGlYR4dDafl+1NpMgxu9O8pYEgsGlwaXXmdzmpUt1LGMV?=
 =?us-ascii?Q?PxfaP15kRKXqR9YNC/fxI7Lu6f7YPXG7tXbVPJml7wuhDR6ZZ+JRC9krLbnD?=
 =?us-ascii?Q?Tvl0a38cdEJZH2dta3cO+VlrNxLe500DslSFGtSnxrFTP3C702oMcq+3wUkm?=
 =?us-ascii?Q?OaoP1cUX6yDlAKQhjn5NzBLRzMhSWlC5+BQxObqlTf1J7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oIn+51rhXvTkqTqqnCo+YnkF7Sw5ZOoah65KKLN8irZMqwAICHe76nQq1f+?=
 =?us-ascii?Q?kEp/05MovFQcuPaJAimAh1TLkJz70V1/UL/l5kIfFScHN+TTvy/IYe1Uiuqv?=
 =?us-ascii?Q?7w/lqpZ/Y7mDuFC6pNG06u+iB0Z9Uu8P84k3C895itlrsw9uwNAaG+HtM/Qx?=
 =?us-ascii?Q?NZouaXu+CD6QEJGlcx6zHC9F5cSxL11HnpL5WGSao+JOWLkZAFCe3HsBSq5X?=
 =?us-ascii?Q?W2pTEsrEGLClUqyEyhfFCVaE9Yp/8Ab9B4bDjDLspK7fmkTN0V3HrboO6/B/?=
 =?us-ascii?Q?qiEvKM+d/xuUSVK09X+2f7xcc49YjghjUZvKNcuNUr9VqH174PKfE+f8YSt2?=
 =?us-ascii?Q?ifP217rtML2RvcXnCHcaCSmB/Hrl84EoSk4IxAx7OWwlFbthlAtqVwGOG/ic?=
 =?us-ascii?Q?24A3FphAat4F1HI0TM24kqBnifZryDjkU4lL2qoG/Y/6FcfOUSEoxXpRXPv8?=
 =?us-ascii?Q?twJaKVXDLhrarZrJrhD5dF1GiJKjTCeSMV8l/0s4pNgF+kaWBBPZfN/gpPh4?=
 =?us-ascii?Q?X0+qUFEobr2vTbyoJKZwkOtdIFmir7X8t66rRQwRh+7o+c0KVruocGkPf8Wt?=
 =?us-ascii?Q?NLXLqlgK7JJCExKNzmEFUsDZi2HS/qE0kMXdU8ytV0kGogTLzmTzF7+Pp+wF?=
 =?us-ascii?Q?o4xtFtBiEcWCHS3SQMD1SY6eHK6PxDwUoP3IB9GA9rAibZEjY5h81n7cCAP2?=
 =?us-ascii?Q?pG097U8Z104a1itY3ku3uJ1B9WNgOoFvgw7WtU3jfz90QQQWg98/TAWvpmVz?=
 =?us-ascii?Q?t6NvLIwn8/IKo0CmiU09gX8qEED0Rbt72I06uyloFaNzQlgbPxEGzMA76Xje?=
 =?us-ascii?Q?dSfLlBVvuEHmDGhC9DxveO3OCs1zcCD6jeC8zVW5i/DAEaHz6H8aDP9phOCK?=
 =?us-ascii?Q?ubQ443WaI+RUvZepnbULGL5VpJGeIONu9+QlQ89djrdsRlSpVrEK+hlAIdzX?=
 =?us-ascii?Q?TaX2j6k63XAYOuPN6Ht1rcti/Ndcy2wHUA/dCqNYLs2cmPCEpHN/6Vynr9Aa?=
 =?us-ascii?Q?KfV3Mq2Nc/bMo0/TCFlGM2HAslcnKj7eBvERqA8HoTEwyZLs7Tedh27k7bcZ?=
 =?us-ascii?Q?ACF9RGxhGDtWPwNgPTvtHE7JcErDfd5QTPGoviisS5h4wHQiAyBeh0SB4ICR?=
 =?us-ascii?Q?1EITwGb51RRLMgDDN6ZdMBUE6/4MlqmHf1Z0tLYSco9sMnXTYW+xutz0H/5K?=
 =?us-ascii?Q?XJr+eNa5c8sojx7wveaBLIpw00Ir/TlabbttTMfPaoQF8JaBrJRufZVFc2RY?=
 =?us-ascii?Q?qJn2SwoS8Lxx8Z89dYhDabR1DpjSdlSwQcMguK52SV8JgqguIpbNsFM7QbbL?=
 =?us-ascii?Q?z7s/t84pjXAjWaDD3pGx7i9iXUFgsGL3JV+u5e7lKprcv4dSGw/CatHNZHpO?=
 =?us-ascii?Q?Nr2rCqlN2siqwWqnZMMzCLgnBBGOP7Gj/pEEFGQavY8hE4ezlKHj2lUKUbI4?=
 =?us-ascii?Q?LVu0VIHit1NBwImI69SncDHcCASLZaAg8vIeVT5ZcrEfncg3tJShMsF2nt1Q?=
 =?us-ascii?Q?N67rpADuTE+dgY20/oZ6gzApS7O6Sn3PgpG0A0Vhg/aITseFayGlzL0wLBol?=
 =?us-ascii?Q?laiOHjblO6hQd3XH1w8Yq42m3Zoi1Q+UMwW6awWPSeZFKjCNQgM4jqJF+zSm?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JaybyQ4zxaxz5Kyv0+bqMWXDmEi0sdqQhPOmCdqG6h8GcEKbACtxBxgHhS8ya1NQhyJ1purkhu3LCOg0mNRjqk5NyAaXItQRF9v0+V7wwlJt31yjqt2x64kO+SAojvP6GHSs5qvFkwsF8JQP8PbR0LgkqfCN7iH3dABhPediBPE9RDNi0eMJc9wUsGfuHOgNSwE2rnJVCsI3r73wiO4HkyX2wMPrzRF8tzBOpsZ7799r+atD9QqfS2Nu2iLUP6/hMASSUy4lXXKk+YKN2Gvb/2L4YImN/ZQqA9C91n3RQ069HBYVtEaRvIUpQkA1gSX2IRaXYGNedq9xI/5KwZ/2ikcxo9uW7QB1CBu94r2wMca8YnUZ1uIUxnnOAVEKQI11sTw+SateItzOjFxTkOvtycodt1eUEK4qvcNdxYrZoRo1AsTxuSmpXl255HYG2RdXDhriFSWuMYNpQgt++WcW038fM3QuYI+DfThkLO1ZkVF7UNlR4PgPYTKkTDusRDkeBOhAMagNKGXhP9e2lO31am6W7XaonUYp7sSyIAEgXUUIRjmttuz3ju8KqM+pnSXOPKYcvVWhlzyjY7F4/iQ93pItWb55f6X4c6Q1jz3yuD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3867e69-d84c-4850-7013-08dd13c512a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:29.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBP9keJDsoUtlq4OtRAVSX2iRXyfnGDi7jcjRzYcTXW0EepnQPUYiAJuG6GJ045f/GW/0812p6qsNaGVqIRVy0td4MOAT9npbL+cKdDS5c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-ORIG-GUID: c3FV1hkGjGUzLb5QGTpUzIy9MRnj5LKR
X-Proofpoint-GUID: c3FV1hkGjGUzLb5QGTpUzIy9MRnj5LKR

Now we have moved mmap_region() internals to mm/vma.c, making it available
to userland testing, it makes sense to do the same with brk().

This continues the pattern of VMA heavy lifting being done in mm/vma.c in
an environment where it can be subject to straightforward unit and
regression testing, with other VMA-adjacent files becoming wrappers around
this functionality.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        | 85 +-------------------------------
 mm/vma.c                         | 82 ++++++++++++++++++++++++++++++
 mm/vma.h                         |  3 ++
 tools/testing/vma/vma_internal.h | 22 +++++++++
 4 files changed, 108 insertions(+), 84 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 16f8e8be01f8..93188ef46dae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -111,8 +111,7 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
 	return mlock_future_ok(current->mm, current->mm->def_flags, len)
 		? 0 : -EAGAIN;
 }
-static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
-		unsigned long addr, unsigned long request, unsigned long flags);
+
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
@@ -1512,88 +1511,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_brk_flags() - Increase the brk vma if the flags match.
- * @vmi: The vma iterator
- * @addr: The start address
- * @len: The length of the increase
- * @vma: The vma,
- * @flags: The VMA Flags
- *
- * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
- * do not match then create a new anonymous VMA.  Eventually we may be able to
- * do some brk-specific accounting here.
- */
-static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long len, unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-
-	/*
-	 * Check against address space limits by the changed size
-	 * Note: This happens *after* clearing old mappings in some code paths.
-	 */
-	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	if (mm->map_count > sysctl_max_map_count)
-		return -ENOMEM;
-
-	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	/*
-	 * Expand the existing vma if possible; Note that singular lists do not
-	 * occur after forking, so the expand will only happen on new VMAs.
-	 */
-	if (vma && vma->vm_end == addr) {
-		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
-
-		vmg.prev = vma;
-		/* vmi is positioned at prev, which this mode expects. */
-		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
-
-		if (vma_merge_new_range(&vmg))
-			goto out;
-		else if (vmg_nomem(&vmg))
-			goto unacct_fail;
-	}
-
-	if (vma)
-		vma_iter_next_range(vmi);
-	/* create a vma struct for an anonymous mapping */
-	vma = vm_area_alloc(mm);
-	if (!vma)
-		goto unacct_fail;
-
-	vma_set_anonymous(vma);
-	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
-	vm_flags_init(vma, flags);
-	vma->vm_page_prot = vm_get_page_prot(flags);
-	vma_start_write(vma);
-	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
-		goto mas_store_fail;
-
-	mm->map_count++;
-	validate_mm(mm);
-	ksm_add_vma(vma);
-out:
-	perf_event_mmap(vma);
-	mm->total_vm += len >> PAGE_SHIFT;
-	mm->data_vm += len >> PAGE_SHIFT;
-	if (flags & VM_LOCKED)
-		mm->locked_vm += (len >> PAGE_SHIFT);
-	vm_flags_set(vma, VM_SOFTDIRTY);
-	return 0;
-
-mas_store_fail:
-	vm_area_free(vma);
-unacct_fail:
-	vm_unacct_memory(len >> PAGE_SHIFT);
-	return -ENOMEM;
-}
-
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
diff --git a/mm/vma.c b/mm/vma.c
index 8e31b7e25aeb..9955b5332ca2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2478,3 +2478,85 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
 	return error;
 }
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @vmi: The vma iterator
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
+ * do not match then create a new anonymous VMA.  Eventually we may be able to
+ * do some brk-specific accounting here.
+ */
+int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		 unsigned long addr, unsigned long len, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
+		return -ENOMEM;
+
+	if (mm->map_count > sysctl_max_map_count)
+		return -ENOMEM;
+
+	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
+		return -ENOMEM;
+
+	/*
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
+	 */
+	if (vma && vma->vm_end == addr) {
+		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
+
+		vmg.prev = vma;
+		/* vmi is positioned at prev, which this mode expects. */
+		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
+
+		if (vma_merge_new_range(&vmg))
+			goto out;
+		else if (vmg_nomem(&vmg))
+			goto unacct_fail;
+	}
+
+	if (vma)
+		vma_iter_next_range(vmi);
+	/* create a vma struct for an anonymous mapping */
+	vma = vm_area_alloc(mm);
+	if (!vma)
+		goto unacct_fail;
+
+	vma_set_anonymous(vma);
+	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
+	vm_flags_init(vma, flags);
+	vma->vm_page_prot = vm_get_page_prot(flags);
+	vma_start_write(vma);
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
+		goto mas_store_fail;
+
+	mm->map_count++;
+	validate_mm(mm);
+	ksm_add_vma(vma);
+out:
+	perf_event_mmap(vma);
+	mm->total_vm += len >> PAGE_SHIFT;
+	mm->data_vm += len >> PAGE_SHIFT;
+	if (flags & VM_LOCKED)
+		mm->locked_vm += (len >> PAGE_SHIFT);
+	vm_flags_set(vma, VM_SOFTDIRTY);
+	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+unacct_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 388d34748674..83a15d3a8285 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -247,6 +247,9 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf);
 
+int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
+		 unsigned long addr, unsigned long request, unsigned long flags);
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index e76ff579e1fd..7c3c15135c5b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -39,6 +39,7 @@
 #define VM_SHARED	0x00000008
 #define VM_MAYREAD	0x00000010
 #define VM_MAYWRITE	0x00000020
+#define VM_MAYEXEC	0x00000040
 #define VM_GROWSDOWN	0x00000100
 #define VM_PFNMAP	0x00000400
 #define VM_LOCKED	0x00002000
@@ -58,6 +59,13 @@
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
+#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
+
+#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
@@ -122,10 +130,22 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
+/*
+ * Flags for bug emulation.
+ *
+ * These occupy the top three bytes.
+ */
+enum {
+	READ_IMPLIES_EXEC =	0x0400000,
+};
+
 struct task_struct {
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
 	struct mm_struct *mm;
+
+	/* Used for emulating ABI behavior of previous Linux versions: */
+	unsigned int			personality;
 };
 
 struct task_struct *get_current(void);
@@ -186,6 +206,8 @@ struct mm_struct {
 	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 	unsigned long stack_vm;	   /* VM_STACK */
+
+	unsigned long def_flags;
 };
 
 struct vma_lock {
-- 
2.47.1


