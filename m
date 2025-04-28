Return-Path: <linux-fsdevel+bounces-47521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D3A9F47E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4D2189E6E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF81D63C0;
	Mon, 28 Apr 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9fI+Yhh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AfNUANeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12326D4D5;
	Mon, 28 Apr 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854374; cv=fail; b=ihoLELQtBvjKwqzhMeRaHFJp9jizebBi8YR4pO0v4aH9JSp/9RUGOgifcX5aN0BHHwviMYAi9gnRqKSbLmeERutHpTbCRU+UhHujR7rj8iKvptJV54+nAPcMB5Ji5ZVI+n2FaZVvAvCV9SVVCo0XHv15t0QLfyz6uApXWqoix/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854374; c=relaxed/simple;
	bh=9S7EfEXwZR/3uu9ToK4OPavP+aAzm8D40RICC0jDppY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VW6tUOmhjh0ucHcBzq8zE0ZE06rBacA1ryfVUtRolADrtryOniVUl/7MsAAd1iT7fcYvfjzUaPMHEpfzqdQce/v7wk1ypg7JjcJ6viqloc2g7AFZbfZIxp8zNirIkkGjsty8sJ6JARSvW0KOVakBMLMQ/dd16waOx0HvNxYcW9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9fI+Yhh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AfNUANeP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFMuVq010816;
	Mon, 28 Apr 2025 15:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GGjfhe8z8hREZVuk6RU/Sq8CVsI5zVDernyeDHcBGPY=; b=
	Y9fI+YhhhuwAaz2+bmy/PlhjV49VQ7AiaRFXlgdCpOMTtvfcOM0yyc+9jGY7PfG5
	j5cADFo5MDxgVavyOPf5wHrGN8S54lIba25nRQqb1Xk/BEuciCBybP0uXQxIKpBK
	R8msB1AB2mFx9Vxm3EoqG2bGW8NxBG0uSf3TGeRr9UwFZivYfBBwXl2Eauqgh7fq
	ZgQxb4Mu5KUcYnxhKvHDjXf07kgOwSA2viyJuctmX++30SNOXpMJw0pzRjpss11L
	NXiCdXbSBhAnlxrLw39JnxMR6eU5ecRLBhT+zQSvfizMKNkd/dOXoruiK+iRqDlH
	s0ccdQQzdoBWIIuZE7QrdA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46abkd85r8-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:32:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFBUCq025919;
	Mon, 28 Apr 2025 15:28:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxetpv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeGG1+vF4z5b6KiK5UXTyqMdPFlTs4ihSR1ZAOTl6LezJ9aY6wkfHNJSGiMkgU3PjcJEMhOnBwaCcTUOtzMtX4V1pt9ztrheALYOs/papr7jHnxfMKDofGQrD6h9Bc+nLSnm955XqexkP/WI0eVxF3PRhsDicYUMTXmQPJ+md299FPA7mGcxrsdjFVSl1165HzBsMwVca6La+jc2E3kVurztl2opns+kJlFlDVDTxVuqzvgU1WNhfH21ysoI6eQM9FIYyDkHoAgCLsQJ0UZfjRpudqquFTAClWrp+yjwSa5Azwj+yrB57vnooUTz1LwZxtT5fhWFm2ka6ehRQKeRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGjfhe8z8hREZVuk6RU/Sq8CVsI5zVDernyeDHcBGPY=;
 b=Crn1Ov8mYZt25mT/Y3mC+NZvBJ2t5wqtqwv86b3Rxbu2y+0NHwb3nQSFQum1KDULYOHkgFSGovztdabnX7jluKxyfDUAX2JSo9jAHY1GwWibTUGB907ZSvG/QApWPypH2Wah3MsOztJvwxGHvZf86k4CsLpXsHGeDtiL/VpUXkNxiR7YD1FvgaUsDzf4dZdchU0w/ZvdbS4NjrSmP9ISsi5rDaDtug4aITtYHzR0uRbo7CAdW6AZU6oYJkQYr0o0NB6foXnndssuGPb+mFjGQ7V8OCgh1GW9pvrP3vfPgMll6kNLubo2oTa1sSXVZzBj7JC0ovZOBd2BlisERuoI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGjfhe8z8hREZVuk6RU/Sq8CVsI5zVDernyeDHcBGPY=;
 b=AfNUANePvcPA/2mLpkjI2hv/DDS+RWCBT3K6u5WMVAGrLzYd+w9novc8ga7gkherz9667xHi/bT5Ml7XpTfEdtdwVp4L6Gy1DMgbpusfgiYSPHboNO4nXAFi47YpHzxQpsm7CXThovBuyN4vuDvpsWt4ruwIp2xdnuhcObLJ2qU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 15:28:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:28:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm VMA functionality
Date: Mon, 28 Apr 2025 16:28:14 +0100
Message-ID: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0394.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 823a8d58-802d-4ed5-64ae-08dd86695139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XA4+SibcVt7xy4Y/d/txhKWHncVUrDrN2BSmDwkiAu9AQBQWsoZrQ21Wmaft?=
 =?us-ascii?Q?yZNIdZI/FiiLJ+H+4O+79ww4suf130+4tWvZqUFGT4qQc6PK8xonSZn8f2iZ?=
 =?us-ascii?Q?zWYofoCWC8TndUfo/HJzamhZzbx1umlYQ9IIGk2mNJ7BRy7/7qxLjzZqRP2w?=
 =?us-ascii?Q?uAQzyTJdhQX7hrcdRVvsdo/tubtc8tC5KdPiSIrxXL361mrQ82sWDAeFwPim?=
 =?us-ascii?Q?T8jbMxGjiPl88/44YQAoU8c5Z3oX2JKz+AkQzdV5sEhwoil98eJOMCE1+Yza?=
 =?us-ascii?Q?tro8IngTDsyuXQ+fNLwudpqanUKUp4muAv0QQBnrq37Znzkb0oNtDFoCrrkF?=
 =?us-ascii?Q?RqbCR90ixaoUD5d9g/+GtgZCdtgETVqHd2WYsClpjjFtSDftXSv+Jpz6Yke5?=
 =?us-ascii?Q?Clr4DDXnl/pZKu4fB4jhxEZGl5b8OOQRLgRQQLLOcPEQvWMe987zUVBk4l+y?=
 =?us-ascii?Q?NLyjatLkc2LhKfb0dSauGfi4OLvV7IJnVogo/hLj5BU98OWQW79UBFI2ITkP?=
 =?us-ascii?Q?ZEGnGxQdJ0FJAXrzZq3cJ/xl7mbUjlcCSw3swZQzuBfV6xuXqLEHwqan/QJ+?=
 =?us-ascii?Q?hkTBz+wR1WdciU8z6BzbSF5Gea4AY/Civ0k/53s8CIcqbHsRA20HMuSEUVtg?=
 =?us-ascii?Q?eB9fJUe4pQFkJEXUlwu2ngDzVDkvF+WZjVpbTAHe9JPKUGXih2dYUIKO7WlB?=
 =?us-ascii?Q?8AhbqlWzrS8D8q1gMeM1SX2nZMOGkp1hO2BNfilHKGWcCfLaffcJXUvxJKd8?=
 =?us-ascii?Q?RHTmEEzviPBRhwYqJzoIO29QZvyIx6dtFXZ0HasL1prur4+j6GphkAVFgICX?=
 =?us-ascii?Q?6SH7RXP5ZHxwkA56lb4Ph9ooKfNZsNk2NEdEM6n9ZzYCuVFaeHuH+OrjuIwp?=
 =?us-ascii?Q?kf4SXzRCcLANjPjlLn6qfXnPQGIcg+8KAtwuIK2Diifuh9PXU/tQdd0eeCeo?=
 =?us-ascii?Q?Ft5v4Zi6svl/FunQKddNkOAFmxWOyN2LmEFK68kEcgnuiC2P74Fy7RZV9Hvi?=
 =?us-ascii?Q?uQ9mJSRKTGV1SdpD8d8TbkUe2w3AVlVjKBCEFuALuw3sf85YlVeTKN7xTuxV?=
 =?us-ascii?Q?dRMQjr+8xQxwof3dRW7hEx3x2h6YFIddRArx7EFV7FgxNkQ3GTGEs7S/ooh+?=
 =?us-ascii?Q?8b9myImfjFdrAB7j90/k5yC/cEd7ED5muRqmbXcM7Xt26Rn7wqw42luVWH8J?=
 =?us-ascii?Q?GXV0DHUy0bNw8P++FgItaU52bCkatFXmZCPA6zarHuZVKYeHSovxJG/VhEGN?=
 =?us-ascii?Q?x18apZwVFLecsu8Xma6R5xxTHU4ByjTQFcYz3Y1A6yoDJQ1KMeRWzHswd3OQ?=
 =?us-ascii?Q?NKtlkYzAt8fpTg3CL3xsnv3/g8NWhVwtfhqYIy6eT4oKdmR+LKVby5tggu3C?=
 =?us-ascii?Q?MTzVc0Ww0aIsZ8i/LIGaKIJbf91TdERwiZnnSkj+0ojgCAJem8ontZz0babN?=
 =?us-ascii?Q?fyZtJneQZZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IlCIf3VXMSmaWjhK0l0zaMxXVy3obqWB7yELieEB63xdml5vkNr8R96jbND?=
 =?us-ascii?Q?4VwGXprUyvcttYOYyfYAsTFljf7j8Sa9pptUpqeuF5KXPSmNOr4NGwUD2z20?=
 =?us-ascii?Q?8fs5S3+29xEk8ePt3nIQIppMuMoLLX+kpGN9+6QIJr8Ql9TDf3lHiH2ucpOy?=
 =?us-ascii?Q?HmQ5bwcp6xaeYSIh7iLunEG0MIyToUUR2w/m97LxPGz+Hdak6Hc6QFrPhkAD?=
 =?us-ascii?Q?mBZGjMR5ZHMO8qQBNPL+Zf2BE1BPr2DeYznWS8qgtF+64iPSgoZGhKMk8GSj?=
 =?us-ascii?Q?P7yoyJzsYRixnGim8524UP1467lBoTeJnf/UAqWAdmXlVZUCbB4VqwbsYkdH?=
 =?us-ascii?Q?loZkx0ZdEJSgcezpSf0NKzV+0LaCgDw9Re9/iCXWOnav/CST8tWvwhzzkJ5C?=
 =?us-ascii?Q?4BrCwK8OjDchrctMfwSTLL73z0Sjz9uwg6OGBW8UF+ln7KqXNt+PzBYoXTaB?=
 =?us-ascii?Q?+dvIqyTu9yCpDzrxY0NJWmxpKXoQ8v0tZCp0OX0iDBKDgUg1wlRbKe0AwRl7?=
 =?us-ascii?Q?rG2c0qvFGW2u/GZKSK7z11TVUzwns/NRKxviFwYa+TTzZn/SAEyd0zyA/ryC?=
 =?us-ascii?Q?E9lOlKI8SdaPWNmJ4i3jKSp/y5XQNOsPZf/AmUfMd1MhwPrMw/HEArrdRKHF?=
 =?us-ascii?Q?KxbPKMGRdFngdDApH4j/ZFGGCQUz3DwwyuUAFDHTb+e6VWFgXlnzaDqFJAvN?=
 =?us-ascii?Q?PgnEloV6Eh8ZCoQv4IPQ4ofbQxdniEoErM9wDm5mNrtHmq/jpmMYnHHvQRgm?=
 =?us-ascii?Q?FfjJbh0o/UWyE4A0KWJyq9WaskdZlbAVCPbXYBLBzcsKJ8wL4sw/d/LtXOG1?=
 =?us-ascii?Q?Eaba4by9/BRskCsXP9rifZQq8wWaPdFnwllHQ8v/5hPFhJ1Ad+C+kDM7Y2fR?=
 =?us-ascii?Q?VuaPYvtaYLcCEWQOMCvGrtPqdj0bgiUCtZXSsEXHHLKpFZCqwrQLBIuAUSB3?=
 =?us-ascii?Q?6MZLO8kcbrOEGa7gN+V9vQbL/xe3iatT4pkgGQU/eGVZeunc9OOhLsIdfel5?=
 =?us-ascii?Q?rPttP/3KWr+IJar18GcbOMUNSzbhZ+ezlzvLLeLTEK32Jjrdm3tbYkuWq6Nx?=
 =?us-ascii?Q?tUARSlo92uAl+dkPTVY7/Arowc7gBTUPzcaJhQyj1tjQ6C0bz8yyi8/dD6b1?=
 =?us-ascii?Q?XFhv92SCGlcSpvUGk6Mt0d2FJ3RJ6JK2YMnA0uSy56Qi52MVG06Ecaus8iw7?=
 =?us-ascii?Q?/a9O3RFetqIcg1MAAZX+E2TuU3EMSj7RoH2p7Jnkx66kdvB+/3IARwvbfolh?=
 =?us-ascii?Q?vdbikox+LMWf0JpvLFnFhfWR7dQwFwjLQfrcJet38m9435eNOEMH4ne98AU6?=
 =?us-ascii?Q?p25VGy1i7QREyxrNopyPp4j4Lx+eCeyDEBkqmc3GDYXeGfKxkB0HQK+tWNIF?=
 =?us-ascii?Q?XqB68ff0JrhFb8MGApMhWv5rQ1NsTD9Qh89gCbVqJ2ILyxx18vJW86iym8DH?=
 =?us-ascii?Q?GmK4avYP7oXEUp6m6ct3/RxN3ARplh43es+Y6QiWCum1Yhc8rs8APDtJ7dJT?=
 =?us-ascii?Q?OGlBpfw/17UF0p3FrRGcN9hDrMf53jWKSisajGRtKqCUZFmpvQFyGE3ybKmU?=
 =?us-ascii?Q?Fh64jtlsRnm6IluuBLGjraqXQAINXre61JF015vU3IHYGsMIrrVD7gavU6Iy?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PPpdqNM6a5CF2ojy1wdWJ+yI1jWMLUyphCmBnDdhKhbfIhjjGRXmlHG2DaS6FINWfdtBNjV/GFdkiwskOdeApT0Xcd3sVQIP3QZXrCELwkV3e5Cy0wF3Dh0uQBoWQZwRln4oHbp90w1p4S+l+KExJrVvn7JtyTu3x+qR4yhiVUjfX8lsj7N0WjlvI5DlrbpwwN2r0EFefsFmxZWZC8OJkq1T/41SDDGVTXewgZ+AJENEx7MkLJo/LiNlxvW69x2i7lNo2d1CHIdHPyirg5CmSlV9+9xHkZ2i3qLkO0wFqNV4H7NPDCJb2SuCw9ORbwDl/4Q9WUqE433quLTafouvbOBSlT1lrmZiZXEuaUTgauQ09Qdq9Qu6/n/8ZNiOGTgWxXKAwuSDrPiyGcbAsdHuWL0l3cBiS9m5Jm+UOc0DZxPtz8M0o1L2dYbW/VKp9C4ZN10nicodC2VHzMwswLVFLjEYNAim1Y9k0wkpkmp+T/f/5RIKSPm7xbtpoX1L8Pns9TzX+RoJkxwNjsSx2YwrUtI2PghG7lB1FXoWTwU3Fze8UZMuEAGVsE4GSl/A5Xribstgt1ULWn1CgmoUM/7xqNeVWfWUywbfEdOZhsAgRMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a8d58-802d-4ed5-64ae-08dd86695139
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:28:25.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdlIDhCdnKc/hnVJ8kcKQBxoQuVoRcHB3xkGPZ/dQLvopQxMBK155NQQAowF+O+RbeSjLyI6RWuk9r9BDduXteiIqJdwXzWSFdXynkkm/Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNyBTYWx0ZWRfXwYjtaLch0gU/ I5zBHomgeYu68yyZX5II6fBENH0KFEdgqrNhIg2/eMatpN1tW/S+YRXg5qhJsbgvmAXUvUSdBnE r2uPfw5hCf/fUp1w0l29VKrj2ts8cBjPvJu+a/dcAuFig9YxnQHzvJcPnuuuvBCH6kLzA9uU7Lq
 EjO3l52q75/dlkQ7bgFkP5ZBOyO1iZUDHUTmAE/HuUNFhwYsO1DN8d74Af3RA5YekGHEHbVR0ZG mZYK3q11qi/EPK0ua0e0yPd1KREykvKA56NXDMKip8Y0Snzi4I5jjA8h/SBXd1yZnVttpegUBV1 jOLWDZI6k/LlZCI85GaeH2tYysIGKt/JQ3CwKO0k1/yW04dNfpFHh7loqH5svKXbinF4vEXBTGe TWdMZkMg
X-Proofpoint-ORIG-GUID: 4jv5Tu0DFn-TbH0I7PmMfzvrD4xKIDNf
X-Proofpoint-GUID: 4jv5Tu0DFn-TbH0I7PmMfzvrD4xKIDNf

There is functionality that overlaps the exec and memory mapping
subsystems. While it properly belongs in mm, it is important that exec
maintainers maintain oversight of this functionality correctly.

We can establish both goals by adding a new mm/vma_exec.c file which
contains these 'glue' functions, and have fs/exec.c import them.

As a part of this change, to ensure that proper oversight is achieved, add
the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.

scripts/get_maintainer.pl can correctly handle files in multiple entries
and this neatly handles the cross-over.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                      |  2 +
 fs/exec.c                        |  3 ++
 include/linux/mm.h               |  1 -
 mm/Makefile                      |  2 +-
 mm/mmap.c                        | 83 ----------------------------
 mm/vma.h                         |  5 ++
 mm/vma_exec.c                    | 92 ++++++++++++++++++++++++++++++++
 tools/testing/vma/Makefile       |  2 +-
 tools/testing/vma/vma.c          |  1 +
 tools/testing/vma/vma_internal.h | 40 ++++++++++++++
 10 files changed, 145 insertions(+), 86 deletions(-)
 create mode 100644 mm/vma_exec.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ee0390cdee..1ee1c22e6e36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8830,6 +8830,7 @@ F:	include/linux/elf.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h
+F:	mm/vma_exec.c
 F:	tools/testing/selftests/exec/
 N:	asm/elf.h
 N:	binfmt
@@ -15654,6 +15655,7 @@ F:	mm/mremap.c
 F:	mm/mseal.c
 F:	mm/vma.c
 F:	mm/vma.h
+F:	mm/vma_exec.c
 F:	mm/vma_internal.h
 F:	tools/testing/selftests/mm/merge.c
 F:	tools/testing/vma/
diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..477bc3f2e966 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -78,6 +78,9 @@
 
 #include <trace/events/sched.h>
 
+/* For vma exec functions. */
+#include "../mm/internal.h"
+
 static int bprm_creds_from_file(struct linux_binprm *bprm);
 
 int suid_dumpable = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21dd110b6655..4fc361df9ad7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3223,7 +3223,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
-int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
 				 unsigned long addr, bool write);
 
diff --git a/mm/Makefile b/mm/Makefile
index 9d7e5b5bb694..15a901bb431a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -37,7 +37,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o vma.o
+			   pgtable-generic.o rmap.o vmalloc.o vma.o vma_exec.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..1794bf6f4dc0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1717,89 +1717,6 @@ static int __meminit init_reserve_notifier(void)
 }
 subsys_initcall(init_reserve_notifier);
 
-/*
- * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
- * this VMA and its relocated range, which will now reside at [vma->vm_start -
- * shift, vma->vm_end - shift).
- *
- * This function is almost certainly NOT what you want for anything other than
- * early executable temporary stack relocation.
- */
-int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
-{
-	/*
-	 * The process proceeds as follows:
-	 *
-	 * 1) Use shift to calculate the new vma endpoints.
-	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
-	 *    arguments passed to subsequent functions are consistent.
-	 * 3) Move vma's page tables to the new range.
-	 * 4) Free up any cleared pgd range.
-	 * 5) Shrink the vma to cover only the new range.
-	 */
-
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long old_start = vma->vm_start;
-	unsigned long old_end = vma->vm_end;
-	unsigned long length = old_end - old_start;
-	unsigned long new_start = old_start - shift;
-	unsigned long new_end = old_end - shift;
-	VMA_ITERATOR(vmi, mm, new_start);
-	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
-	struct vm_area_struct *next;
-	struct mmu_gather tlb;
-	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
-
-	BUG_ON(new_start > new_end);
-
-	/*
-	 * ensure there are no vmas between where we want to go
-	 * and where we are
-	 */
-	if (vma != vma_next(&vmi))
-		return -EFAULT;
-
-	vma_iter_prev_range(&vmi);
-	/*
-	 * cover the whole range: [new_start, old_end)
-	 */
-	vmg.middle = vma;
-	if (vma_expand(&vmg))
-		return -ENOMEM;
-
-	/*
-	 * move the page tables downwards, on failure we rely on
-	 * process cleanup to remove whatever mess we made.
-	 */
-	pmc.for_stack = true;
-	if (length != move_page_tables(&pmc))
-		return -ENOMEM;
-
-	tlb_gather_mmu(&tlb, mm);
-	next = vma_next(&vmi);
-	if (new_end > old_start) {
-		/*
-		 * when the old and new regions overlap clear from new_end.
-		 */
-		free_pgd_range(&tlb, new_end, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	} else {
-		/*
-		 * otherwise, clean from old_start; this is done to not touch
-		 * the address space in [new_end, old_start) some architectures
-		 * have constraints on va-space that make this illegal (IA64) -
-		 * for the others its just a little faster.
-		 */
-		free_pgd_range(&tlb, old_start, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	}
-	tlb_finish_mmu(&tlb);
-
-	vma_prev(&vmi);
-	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Obtain a read lock on mm->mmap_lock, if the specified address is below the
diff --git a/mm/vma.h b/mm/vma.h
index 149926e8a6d1..1ce3e18f01b7 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -548,4 +548,9 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
+/* vma_exec.h */
+#ifdef CONFIG_MMU
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
+#endif
+
 #endif	/* __MM_VMA_H */
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
new file mode 100644
index 000000000000..6736ae37f748
--- /dev/null
+++ b/mm/vma_exec.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Functions explicitly implemented for exec functionality which however are
+ * explicitly VMA-only logic.
+ */
+
+#include "vma_internal.h"
+#include "vma.h"
+
+/*
+ * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
+ * this VMA and its relocated range, which will now reside at [vma->vm_start -
+ * shift, vma->vm_end - shift).
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable temporary stack relocation.
+ */
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
+{
+	/*
+	 * The process proceeds as follows:
+	 *
+	 * 1) Use shift to calculate the new vma endpoints.
+	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
+	 *    arguments passed to subsequent functions are consistent.
+	 * 3) Move vma's page tables to the new range.
+	 * 4) Free up any cleared pgd range.
+	 * 5) Shrink the vma to cover only the new range.
+	 */
+
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
+	unsigned long length = old_end - old_start;
+	unsigned long new_start = old_start - shift;
+	unsigned long new_end = old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
+	struct vm_area_struct *next;
+	struct mmu_gather tlb;
+	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
+
+	BUG_ON(new_start > new_end);
+
+	/*
+	 * ensure there are no vmas between where we want to go
+	 * and where we are
+	 */
+	if (vma != vma_next(&vmi))
+		return -EFAULT;
+
+	vma_iter_prev_range(&vmi);
+	/*
+	 * cover the whole range: [new_start, old_end)
+	 */
+	vmg.middle = vma;
+	if (vma_expand(&vmg))
+		return -ENOMEM;
+
+	/*
+	 * move the page tables downwards, on failure we rely on
+	 * process cleanup to remove whatever mess we made.
+	 */
+	pmc.for_stack = true;
+	if (length != move_page_tables(&pmc))
+		return -ENOMEM;
+
+	tlb_gather_mmu(&tlb, mm);
+	next = vma_next(&vmi);
+	if (new_end > old_start) {
+		/*
+		 * when the old and new regions overlap clear from new_end.
+		 */
+		free_pgd_range(&tlb, new_end, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	} else {
+		/*
+		 * otherwise, clean from old_start; this is done to not touch
+		 * the address space in [new_end, old_start) some architectures
+		 * have constraints on va-space that make this illegal (IA64) -
+		 * for the others its just a little faster.
+		 */
+		free_pgd_range(&tlb, old_start, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	}
+	tlb_finish_mmu(&tlb);
+
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+}
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 860fd2311dcc..624040fcf193 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,7 +9,7 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 7cfd6e31db10..5832ae5d797d 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
  */
+#include "../../../mm/vma_exec.c"
 #include "../../../mm/vma.c"
 
 const struct vm_operations_struct vma_dummy_vm_ops;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 572ab2cea763..0df19ca0000a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -421,6 +421,28 @@ struct vm_unmapped_area_info {
 	unsigned long start_gap;
 };
 
+struct pagetable_move_control {
+	struct vm_area_struct *old; /* Source VMA. */
+	struct vm_area_struct *new; /* Destination VMA. */
+	unsigned long old_addr; /* Address from which the move begins. */
+	unsigned long old_end; /* Exclusive address at which old range ends. */
+	unsigned long new_addr; /* Address to move page tables to. */
+	unsigned long len_in; /* Bytes to remap specified by user. */
+
+	bool need_rmap_locks; /* Do rmap locks need to be taken? */
+	bool for_stack; /* Is this an early temp stack being moved? */
+};
+
+#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
+	struct pagetable_move_control name = {				\
+		.old = old_,						\
+		.new = new_,						\
+		.old_addr = old_addr_,					\
+		.old_end = (old_addr_) + (len_),			\
+		.new_addr = new_addr_,					\
+		.len_in = len_,						\
+	}
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -1240,4 +1262,22 @@ static inline int mapping_map_writable(struct address_space *mapping)
 	return 0;
 }
 
+static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
+{
+	(void)pmc;
+
+	return 0;
+}
+
+static inline void free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
+{
+	(void)tlb;
+	(void)addr;
+	(void)end;
+	(void)floor;
+	(void)ceiling;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


