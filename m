Return-Path: <linux-fsdevel+bounces-47758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E29AA552E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663294A844B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1B27A47F;
	Wed, 30 Apr 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EniMQwkz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XWQwjsD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BA283FD1;
	Wed, 30 Apr 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043220; cv=fail; b=Zhdt9byOVrCOpqZyqO0xDl1w8Axw5Pw5JnwU/z73mxcbDIQfQxtknZmBxQZz1ZxSl8Uirw5ALjBdDi9/HP2f2MSLb4/Wp0QFoO2mMr3W+70k3J+iyRzkwPMz1eTP2fZAHoOTGR94AA0e6xCzG4jMpHhZ0XafRxiOGkjn9SYL2ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043220; c=relaxed/simple;
	bh=ag840OWJ74pDTOnxviG1+PHbJZvJTBNbBMFdFvvOTFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzCJzB6LG2WzYCI500gkasL194Way2dh3k5SibtdDH6kqMPsr2BwK7sJOWrYAyUegE9a5EmkUwn4Gat5lmb+j1jDnMVp8KwdA3CAkszyLbuu2u4z3fEp47CZzTxX/n6oIsCTFYdx88wzMzD2bLUG64lT3WHss6QVUelfbTDaZOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EniMQwkz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XWQwjsD0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHu0mv028536;
	Wed, 30 Apr 2025 20:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=; b=
	EniMQwkzY12N2A4FK072oaV3/HE1GYuzOW5p5G5HfwA6NdmMXxMysQmnIRFd8yCS
	xKslqbPJIHJIHHIjRZ2JqcN91wIG9Q0Nd9hpg7aYEvvHTCsmQ23O9YAdvs0N1i4e
	vic8V0ykX0d5b027QZLHPgx9VtagQYuUtVj9SH8wTiMGZPX4WaLfJGtKXjlCgdLX
	UZD3Z4jI0dRMGmPS4PHyLovNIGhYIf0VN4kxiE57ee2W81g+G8HomiNuNhpY9Rgr
	lwuYOn0HSU3SDwfgtgq+yaend43xEEEVRcQ2qKhaiFfpIQvpNi5Wy9TFtYxPKk4K
	StHn9pxNAv4SPeQ8RiT2pQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqj250-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 20:00:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UIrmJC001349;
	Wed, 30 Apr 2025 19:59:59 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbs59b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PURgYsZnUyol25MbFb2rCmf/PK/YAwllQ4BgeY+qa6Jbe0XIV5QPJisxfA+gKPVcPolQ4x2kqdU+Zgl/eXbN/3ha2N/Dv4dUch9UPTqEcyZORecyi6cgSC9KmknnMs63xzHznELwuIh7pqr4BwYENCnPfbZoli3iAMIUk4k5Uc6Ic5T0tVBYtio3iPkmArTuzs1tdVlB/VG6z+4rIhH44/UWp0AiFsFi2C5fmXMsprenK4z0PGYGlW7wJ8rJD556ywUJ15SQgwrjY8zALR0HS9fvxjLJtlNnDsxwKoBCQz0bDRqvLNbbI0ZJ7pDXMbbNYWWtKAOaec3lytI4bJOMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=;
 b=sqph+SDRRd0imWpnCPmBe8Py6AyWgBJyvotJpPB52XfWfqjCF8vzCR0Fos/+cLgiDY2dUHOQg0d7Sirle8CciugQeAIjGJrb1+9fIcA8TK8MDOPuohqdL+l6IDnd0zy6NHdbsVlgJOTqDbp7XIx8VFqVXqFM2npXTVQf0zRdDB2cv9u/1urdo821sb7yYFk3jooFfIjqZsqgSXBjxaAWxdcK97CFXVwrI3/vc93Nxy7bVvfEz6gO+4HYsewtb5dB9TDPLjzX27aSlmPwmlJKL6OiMB0Z8/5Qv1YGondjRSqyxVYou3hZ9zWK5Un27HnxukpygTS0Dm1NS5mhK43mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=;
 b=XWQwjsD0hNRbUujWX1V8k5w+fvgTerxY9MBeBtZy4N2ebGj87G6UuquhYPKS5gduC+bo54agLpme3te51g4BZNT9Vy+YaQZf8BlmrScbF1Y8C9alAOdB89wmTtz3tMTIdZlKHFCN8GlHAolJrp8lWr8e3DE+VUFoUsHcOzNAuzc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:59:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:59:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 2/3] mm: secretmem: convert to .mmap_proto() hook
Date: Wed, 30 Apr 2025 20:59:36 +0100
Message-ID: <7bd9f0abd33677faa7d9aaeabede8d310f361a16.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a61cee-5b4e-4a71-92df-08dd882194a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eel92Ts98sWvITci5N7UwkSiBtDr5NvkcEXLYOxW19WMwtNlAPHnoqEHBilO?=
 =?us-ascii?Q?j7I5oy4ia8Kdr/tUN41Xx8tvQ632MlBI7VOSaD2pze+zlaLkxG3BXhTQokw2?=
 =?us-ascii?Q?uU9viFMQj48Wg0QURxQeSenQp3KtdHz13RBMHhIU+nO9yJJ3M3DMEZbtHXEL?=
 =?us-ascii?Q?JLU2ebo+1Lb2EE/RPyE8iApahhZ1/hbUNwNrcDYkFJMd2ZagRMcOklOzkvfT?=
 =?us-ascii?Q?qMxskb4mqFhWtI69PmdZBQ6UZRZSazCrckPCE2FyXAdcKr7IpL65hMCU8hBd?=
 =?us-ascii?Q?cLU15aV7opBuqsjvw+9PBFNCCpcGp9uWM0IZPx4NcO60gC8SvaH4dsJcyV53?=
 =?us-ascii?Q?51wJYp/8M9Pw05OyBzVf/IjTJJY+NO9irWfoHYRxo2hRt7XyxX6BiCW+T2Rg?=
 =?us-ascii?Q?RS5K+r7jt58Hyr0UvN7Zgh0SdvghrrpJyA4DNTEZq2SZj9cORRY9mNSXobA5?=
 =?us-ascii?Q?s/2aTsjlLD85mKiEB45ZstxklFbxlK1dFve3/GjJXdIRXV4vYo+rDB94z+Wf?=
 =?us-ascii?Q?FCrq1IXI1sbcDYMysRGXWbCWdge+OGHeJRQ5yN0BXXDvw3sv58cXfF8KptOO?=
 =?us-ascii?Q?L0xaYrkSBLJqakF1TSvxJG56vau9pEttGsJe6rSsgdxl0Ds7efNvj8Yg5xpU?=
 =?us-ascii?Q?k7fPy00ZpKC2wKi0F+83p5G58Lv79SSktd455v32Uywa3q+cFwvKQupibmCd?=
 =?us-ascii?Q?zZIaBFrRjT/qh2g0wTu0OBw1Wg/W/jhdYbBADhM0h9/Km04iKjb4Sb5qci3V?=
 =?us-ascii?Q?JX858aQoqzEJ3t4RdCO3NRZN8gruV0EF8pdr+avGqQlQU58MOtv0Ub0IDspb?=
 =?us-ascii?Q?B7pt/K1bNqBvSHGhTJOWWtk2sxcgWwU8flRRJiBHoa9xH7Y4ZVI7A/b43BEH?=
 =?us-ascii?Q?mWImmDPuK6Rb84DM+OOE81qfgs8oxL9qP876FqsrdrTz2HnLDxu4jSiCnkGy?=
 =?us-ascii?Q?PWvKfjTxOStWlAsp+yD59phw0QsDL0Lk6d6UnzC63IbHsYLDAy9I6Ang2Tak?=
 =?us-ascii?Q?4GcfcnJ8nrhKtShoUmbCAu/oty6/FpEyHRGSwnqluG2Y+4T2ItArGUUsE/jB?=
 =?us-ascii?Q?2RVoVBd4jq/B6IjjC5qfZlEu1mSFdgMg4INs9JCO8aH2yuU6LA2GMnKx/UJp?=
 =?us-ascii?Q?HoWzBG34BsEqc5kEokspo4hQ2YK2QSuKn0420pyR+vU01kT8Ql1wl4vo2/kO?=
 =?us-ascii?Q?HtDT8AukNit3AE+cNkhmPlV2xnsp3goFvPUZAn8EV/1KwHO6H73k8dqRILnf?=
 =?us-ascii?Q?5mwYKmqexqqocddl6fNRokEJEAxJ7xoJ/iT2JAWT+UK0k0FFU6BNP4Wq2QmE?=
 =?us-ascii?Q?ySM2daWG2uIIHyqmY2XP0lkhH/6S5TuYnj6hb1A6qqTajGMCu4raO+aceXh1?=
 =?us-ascii?Q?ccUhwJasoHNI5/QgJaYwkmYugoXg+ylH5W+YwglOFOAbALj77IfwyTiQyAjA?=
 =?us-ascii?Q?5+TidanD7TY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lp7cMe0xNo2E4+dVT6YP4PUyK9/n+/iANywwpyJGk+TleGnzz+QfPAttlXf8?=
 =?us-ascii?Q?Oj96qS2irX4cRaBKFuMYJV3bt7JjrmEYfjP8qfCiqd+OGkiDyR+Bs+VYcBOl?=
 =?us-ascii?Q?16FhxFxoeIDQOE+veb1q9Zm+9SocCMPo3p8sWBw0uZ8KmuK9KnoaHhyunOfg?=
 =?us-ascii?Q?UUmK9sPXFGfQaY6VoAe+zgEECLKsE2hgywe0lPqcSaMAUtn8+qHmd5hTUiIH?=
 =?us-ascii?Q?L/3htfVL7HW6DKBpEqqkiNgqqQwVu9ZUkVXKaoFL8cRI1PhZ6ppE7w+KIK3T?=
 =?us-ascii?Q?uM49XGTTtv6noHfo4BRswMG3/staNEp5PdE0yDPZNfWVBYuvkOjEdHBmUmKV?=
 =?us-ascii?Q?Dlj8HMxNFjuMJboaWxNdroU21dRS5Jem1/vXVeOiSfCU4x4ey/EgtDr5B9yM?=
 =?us-ascii?Q?JfxguVVJc2/DyqN5mPNaZDIGmNy8fyQ6vSDO0810aXb5tv/mWKs1FUgUMI/R?=
 =?us-ascii?Q?WZFNctzmX0uguH3ZeNLodhoMXZQ3pr2L2IH05YpVyxbwkm42ZOC1L5kbitKW?=
 =?us-ascii?Q?0AQGqbhEbEiE7xdjPE76XPuuDH/18n5I+Ds02oY/Di54GJGzrU5eYLtapuvb?=
 =?us-ascii?Q?E2hCKBjnJhUQdD66w5fgyll7YgsLBjjPakYrvp0jkYtU4QmU4i/0jSqzrCwg?=
 =?us-ascii?Q?afPJPP9x7mAqJWATkqH7+gspRAqzbrbSCQi42vkkJw+891fFmqEbTgMdeiLM?=
 =?us-ascii?Q?Y9Tmx96tusVjnhhRADGitBXHUjz7c5z1QzT+qj3qYKQueQ+MxGwGF1uddfNx?=
 =?us-ascii?Q?t1PK1Fco/JxAcAvo34uEIpoRsOQZde/iQZhoIpXgSwZPcTMHcC77XMWI0quP?=
 =?us-ascii?Q?MEQdGtvCBeYKyMySZ09sNQ+1pMN3zhoFWTay9bg3Z9gf+RNKDrVAQsvtJhoj?=
 =?us-ascii?Q?LqKv9T59BMN1wuasjfbR+xTbXNJRfbDydvBM+AlrQIUosE3Apbu1uLhwNaw9?=
 =?us-ascii?Q?INXQtBtECX6CkeA74Lp+D0tXaHHx6swjIHZbtWP928E+giU7UJ5QZwmFWFAu?=
 =?us-ascii?Q?H4sxvt3vKnLmq1UXv+5n5YojqkjcKVp8LpYKab8ybt3y84PMbD3johVLM3gB?=
 =?us-ascii?Q?JAIas6yoP4EGfEDPHuG9KOUfIM405NaEU4J3qJNtG5a7HJWv3jaMnE9YLlIE?=
 =?us-ascii?Q?jFtaD2rsCFFkk3KqfQYaANKfZ9ahggTprStBNqH7f/scDHERdN8/C+BUS6IQ?=
 =?us-ascii?Q?UHXngvgIMRS1Qc88GIk4FW5ZRLCgx7cP3cWmk5U0DeHyYbkIcSGYBWQ0F2+z?=
 =?us-ascii?Q?WagKYYX4d7EkPi7rSSGnXdiSFsEnXZxr3XoQDAM4CWwls5irJ02vqf7WhTNA?=
 =?us-ascii?Q?XKColtUJMA6eZ6R+51qC4YfSXIo5LSXGWMII8/Ty2V8TxivxdAGc1TGp7YQx?=
 =?us-ascii?Q?+jBMGWUFr1n3lSDvVoiGD53YD2ILiW69KX/oFRfoLtuy2sblmw7zq7Gxo6WM?=
 =?us-ascii?Q?l5SNUKN/6myN0Hd57I/zs4yPQNVPze4HoYB8b73bBgmcw/LFizuhNe/VD9Ru?=
 =?us-ascii?Q?6FshjKj3MGRM4dd6jdXa7990SEC41o7T7rr8jridIzlrET+4d/4TDWOdccmA?=
 =?us-ascii?Q?55HlWUM9tdMo98BtXANn3mbMKpNSsvGXGarWfZDDyw2W082zn6BdiFN31nHb?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Co26LQGltvrBRux/u+pvZ/SRsRNYiAf+idh6g6F8evJEyfPw4VPi7DepO1HZPhXK5QUClY4JqTqA+5ir5pR51X1zZ9Y84OzVCryQF8nUwvbjCNEsSfn9yn+D3uMRGn2vxF/zXY0TU2LJ1gQDBjjLZemqiYPIg2RQ0AdyorwEBKR60b4hmBPpP9cA/Eg2JaYH4NaXHk6oQCSUkXAgvpoll72f0IpN5PMxLqWWIqJimHO9iAfOxnhPWTuWpl/vO3uVnK6zUODD7A+TaF+/vDgJv8SBO/N8ChCND8XsJuJV1W72HIUlur5F8AWLvyo+6kVFGyKeQ1KyzZDO4OtVZxZkC2Qek72S3Wgk5xS8w0Znieqn0rdu7hFr613+WnxavGogbeEEpEfYMmQ2bMAqob3tEBfCzWNKR0NwYllAcqMMdj8JP7cVn6R7SC+eky3CvO4KyDqPV4wqMXznQvn9TJXEuWU26MTwyKuYpiTiy3I9NLawY9VCPF9n0e4BwkdmRnXHkMRUsD8YoAg6rxwYi1Dl2ApENdJI5xDdc2XgSswcg6+zGrlFxlqC+6XCEVZXuUlSRV+1I1a+mnVD4rHME0aiSDBunJbqToBi8xsX8UaTI0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a61cee-5b4e-4a71-92df-08dd882194a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:59:56.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q04bdaZubpz6ZTcMgachW86QcJ2Bv8yTdBDMQklPalqVGfTopwzMPGSdK04kNAlDLouMfdfqGf6InqbyExkrzw7uP1bgoqAJFdQq4x28HT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300146
X-Proofpoint-ORIG-GUID: OsOohCeyhA9f39m6TcF14hs9sRA0hA3j
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=68128141 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eMrKcSYToJjtSuUrl74A:9 cc=ntf awl=host:13129
X-Proofpoint-GUID: OsOohCeyhA9f39m6TcF14hs9sRA0hA3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NiBTYWx0ZWRfX41u5SUKnX7ZM 2YqxWoLsKUnoOiLxeNcuih+k7UCQnR8Y5LDuM47YV+PqSTQ84p29Hjq77BtTteK2DClOhQn5/zY N9J/1LsO5i9zWFJBSrk/bQSWmLDQSJGjAjqfcdM6vYWJVYrqt9FBjOqBSRWdadYdyvkqU21PBJ8
 gRHYmTlWMzq7dPNxtVb/q3OZuYqWNUTU2O012xKRZQDPdk2S3cvLMWtYGky93AlGl4KWuSBv7rA 0oeKBMrv0rnpXhEc20q1ZTgPpgcjhUO9bXBCDaJXz9jc6MrY09QmLHx/fLBW14eIs5Qp390cNWH IG5fGG/yGQH0LZJH0FLWTBe2Ek8SXckVIewRcUmjPKeOOkid46x9ksjWy7hfsxf+MBrIazIWhPm
 yH+y4/6f194+dHIIoH00qgtSv1khep3w9NveI7lt7DsG0NZQ4t/hgN30GDZfDX+bwMaW/6kI

Secretmem has a simple .mmap() hook which is easily converted to the new
.mmap_proto() callback.

In addition, importantly, it's a rare instance of a mergeable VMA mapping
which adjusts parameters which affect merge compatibility. By using the
.mmap_proto() callback there's no longer any need to retry the merge later
as we can simply set the correct flags from the start.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/secretmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..64fc0890a28b 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int secretmem_mmap_proto(struct vma_proto *proto)
 {
-	unsigned long len = vma->vm_end - vma->vm_start;
+	unsigned long len = proto->end - proto->start;
 
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if ((proto->flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(proto->mm, proto->flags | VM_LOCKED, len))
 		return -EAGAIN;
 
-	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-	vma->vm_ops = &secretmem_vm_ops;
+	proto->flags |= VM_LOCKED | VM_DONTDUMP;
+	proto->vm_ops = &secretmem_vm_ops;
 
 	return 0;
 }
@@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
-	.mmap		= secretmem_mmap,
+	.mmap_proto	= secretmem_mmap_proto,
 };
 
 static int secretmem_migrate_folio(struct address_space *mapping,
-- 
2.49.0


