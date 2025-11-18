Return-Path: <linux-fsdevel+bounces-68926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD4EC68C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 9D82228B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172334678C;
	Tue, 18 Nov 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WD3gnKP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oRY6yfgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBB344057;
	Tue, 18 Nov 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461183; cv=fail; b=V/bVo9CNJRLVytei1xGfDGeRzJ0vrj9rn8Jxp2+Nd3vEeuoXhxBV0nCy9rOhEK5CuC8B+Kuk/QLBPVxcya86RFCWbP+10sWMLdIUqT3iG+gIDW3eSmOuKcVlmRbZZJkNu2REKg91OTJ3etjVcJbeTuLU85p0uRAq92S9vusLEZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461183; c=relaxed/simple;
	bh=er0llcBZGx8WnGYVgZhTRCCxKmQ44DQr13KwH00huUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgGA2Z51yQXB350wz5cVAfqfvl0fFZLSp7VaXvEWBhcfJAVkhu9Xwit1lrPm6e4SulyH+S010yIXWCrDuGDTJH/6/7ila6/3dG7dgAvfCI5sgOftUzgdNyyXXlbaWUmOsY6Z+e2DxSqyQDSw5AQXkvIlxEQzgi3NSBuYdhKicpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WD3gnKP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oRY6yfgd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CiHv026659;
	Tue, 18 Nov 2025 10:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2Racm7SUJaZEFwX/ZNz2EJODs9wLk4W9UjaEYg9ICkY=; b=
	WD3gnKP4dWXKftVXh473ofEDtlozJ/F1VxrEQ6531hI6tE7X1udlDrj23864N8vm
	IW6FCJ+nB2W0CGHdUd76NM2IHx0JkyJHWR6XsSwGBEqaIixQVf0Dzo0SbA85WfL8
	+o28aWZrL9EqES2ag5EivzBiPZc21B70QesLeqPwkFugycYU5w7/kRYCnVs4EZ9c
	eASD9c6sboZludsNajEdTcm8TZUFZ+3X7G4rzrYCxnPLgBlGCje+cf3fS0n0QIOP
	kmIhox0g2YduONAztYkmJb8PYJITHikdYEEIr5OnEO4aTus0sCIOQSiZcx7IK99a
	3agINSYJx0xu9Bgtp3vK+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1cgcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9NsrX040040;
	Tue, 18 Nov 2025 10:18:40 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyk8qpj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHrYFDp+FVqWwuuCmSwK+W+to78Y2Z8ytF9MPGIGwzJF9Sk7k8dTzC0Ct4Lf2Bn0OCyFIwIQoBKtMxnESYfagc+FSydHZw+98p/Dnthn6mzNONLKJBSwmKQWAztzKgbPLJJyOz//7b3eh8EMTu1snnaYblAb2DtfyI6T8D8oALxyE7HoZmWmj0wTeg9FxrPTYV7MTTpsUBmCz7G93IDJ/51Pw1UNv1dm6DPoIkMi2HLty+tjRPgevaju6L1svWgvqajE9kaTNuRVOqGL377TjK3mpVIy3IQ04wjP983A5j6vbltewSZfIuv9pAYiJ99RuRl0WbUNAUivfZouJcsUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Racm7SUJaZEFwX/ZNz2EJODs9wLk4W9UjaEYg9ICkY=;
 b=i/ycdzTBNylGinBPb+EzEXXRHb8t+LVOZox79E5SB0aa0I9gxQbxO7CP3HatC5VlTEA7oHazOrhNGNh75+1lDnsVA3oUzOrrLZr2sB1BlW4qq6wso6hdZWJZ/bicg5D3aewpYODcTcQjfgkAVK7J//gZxSMhsu8ChjhDKIQuQzLx1NFqDXJYiB7crZeYuE28FjO5yd089GcBuekxrFbJ2L3Z06l+WR1Gg3KE4vyCK4U8Xi5zk6RJaFGfx5siMa80yeDGAGXhe5Y4zA3+laCtmcv7lxDtIeNB1t2yfgvrurswqUocif4Lqwl54t2Drr0MUWfijvi6VouaceiC3ygajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Racm7SUJaZEFwX/ZNz2EJODs9wLk4W9UjaEYg9ICkY=;
 b=oRY6yfgdKL+zD8+Jy7/5fsKuwtYkUMLmcGblXnkaroc/FxYLGm/K33W7BSsmtOYMO3XuvJiX/Qb23hOcWaviuaUYX/K/Bi/HQSSVksHKm16lKsv3KcPZkt9GvYKk//HPcvhlvaPBAdl54APvW2lYVTjroGEBDkCMzsYTcjjsa2A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v4 6/9] mm: set the VM_MAYBE_GUARD flag on guard region install
Date: Tue, 18 Nov 2025 10:17:48 +0000
Message-ID: <e9e9ce95b6ac17497de7f60fc110c7dd9e489e8d.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: b27b4857-95c1-4617-23ae-08de268bd42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rZr2hzDXr7Vy5k0WWNUVMDKrJ5n+Hm4cpHrJStwwXq533vLVQ7wXCt2xAk83?=
 =?us-ascii?Q?pUoST5sdjsCl8cms3WIJUJcQSmQ40snIO27t39xBZbgvhB2+8XL/2bPoGVi5?=
 =?us-ascii?Q?8d6hszzP5Jo2Qxyq9wDzJw2iQZflElzLs5/aqKSgTo1METDkujyoVhDjT72Z?=
 =?us-ascii?Q?gR5w7pFbvL/HxppzF8Eq4zzV1+pQS77RE+nPMvYa7+M8ZZMzO+t/KWUKlIiq?=
 =?us-ascii?Q?nwpts9rrMe3RgIFfZCqwAgwvfmmUXNMxRiKOp02XeQFyJcD5Nx+vDJ4dHMt0?=
 =?us-ascii?Q?17wmUtT3zQFjdlI0jq+f0twgJNZQnWVk4u32k7AZwQ3QotrzYn1GVkJHfOqv?=
 =?us-ascii?Q?zgSrKCCCQxa95jZdr7v/irNTlaSMs7pAebJgmniacLzy30TYDvmqW7171hzR?=
 =?us-ascii?Q?zwKJTTXz/1cnxII0MRAc7BD6nJCEgtha/EWvd51AJn3brWPyqLuFsx3DuKjF?=
 =?us-ascii?Q?ULUb1ogB9aOz8elOHaj5Bg9fsbERji/PP4GFhuxB91eX/4Bp/zKjvIdbGefQ?=
 =?us-ascii?Q?TX5lmvyFMeqUHfl1HJQk026VqFlQKREWa4tiJAW/CX1dltOGq454TS9r6dYW?=
 =?us-ascii?Q?i2eIB9U7MEXan5MZbpoDX0IsPiK1GyTSZ5WkBqMMkMZFCtMM/p+6Qkd+tBzb?=
 =?us-ascii?Q?odew7eoLBul7DqKwsjTYy1d5n51yE4/1GXbr6QNp+iTJbdqmPIYqfxRpWrOo?=
 =?us-ascii?Q?Z/lOvXwhoEO/cb/JtA/qQJJVKPNOED//7IQCjtJ4tkqkNif35+8p+Zi8+MJM?=
 =?us-ascii?Q?LstkP2TlmTNlDygzATauSNybHJ8+1DTfleKYXA4tDrWrQWoFS+kr2WCquwHa?=
 =?us-ascii?Q?IYLi6zck41QJ4U0poftJMHPInjWYunjV1BakB703FWXlERVpcNcGU7Fkji5N?=
 =?us-ascii?Q?O3vgaYIsGhbKy0k3+ACyNfpvoy1UVO0zGo8CwveUR3lWQqd0aSGWgPPwvPou?=
 =?us-ascii?Q?WjuM6osgA9eCx4Orb0KDLAqYa1f9NgqH1BbQncMLyMwjj0e29AF1lwTjnapz?=
 =?us-ascii?Q?MoB7T68WFLt6ohYhN09WGdQaiN3SonDe3SUfmevPM7kzOv9f3sWBZuU6/4Uu?=
 =?us-ascii?Q?pm11crCnJgg4oV9owntnvlGRVJmmdHDEU5iS2WL+827/UVbJH4xM+t+gA0qN?=
 =?us-ascii?Q?eAzi7hAAo2DyftzHx8olF96hNY3mIo33MSUCSA6/tg7nQ6oFMWHsyT6NRW3i?=
 =?us-ascii?Q?opSFFmY8nQBpygocJi7kZKNdtU9ytf5QXCu/8Q/H9iri+7WHwhNzOKjHN2hP?=
 =?us-ascii?Q?1Prrp0k+RAO4lBwefyXYDQK2Q9zqF0qKz3sG/lOFM4QnHMWvGq0hBOHcIT44?=
 =?us-ascii?Q?3IiKW5H23bp/W56DfzxNqOeVsPpysL0aKVOALcwZhzuAlLKa9LmPyOkrvfbt?=
 =?us-ascii?Q?YL860rOvfXATzjnv+CgRVmNLYzVqEnQU3HjA22+sqWxQuq4YMM5c8OONth6C?=
 =?us-ascii?Q?a4YAswviELqaWY4W+FY8Py9IOWfkRe1x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Co4lX67WxGUq+0Sc3IZdrWnzsPbLGEj+4wF7eUVheAAtJscCn41QdFuXgkQZ?=
 =?us-ascii?Q?/lav1rr7ONle59XrjZeSgswcJejitLO0p7bL4ye02I6VxiVCfIefbvy5EnON?=
 =?us-ascii?Q?6OwiKg/CCwop0IyQTrIFi2jHOehTd8eA3ugpKg9bQISsQV6atn/JiBzTcN/O?=
 =?us-ascii?Q?UflE1NXlic4Rvxn44QER/4gg2Vq4iZiR9BjEOQhI8d7ObgxIE4ez3XtxzOJ/?=
 =?us-ascii?Q?pdpKHaFMVkfCsoiKwV9IMBLfIomqo2czskt/F01ujRTLW3hGb7Z9MgyCzy2x?=
 =?us-ascii?Q?EF/onMv5A8MU/pZ3vq3V9h+hgcHCd+zeB4oK7HFe+HYSggT9ptecFASgQ+2b?=
 =?us-ascii?Q?OC+9PNkR5rSfz8rj9LQ+7yoaL5XuLYAQkWLOAvV9pvl6ZFVjhFUhy88J6thT?=
 =?us-ascii?Q?jCrTY6zJqjn+wTIPKaFF8pKDuB2eOUaCqYaePQ1zLZizr3eikjRNnvgBlzjn?=
 =?us-ascii?Q?Avc64V+Xgjc9hqDM6sumvBrdlN8kyX1+NyeDPcxfElq/UF1giDA8NOxLLfsi?=
 =?us-ascii?Q?SzvpVn7zLEFml0mTHyTR1MlB/Rcs8S6tiH6rjrajbEkzFH6pH1Sncr4GoJsD?=
 =?us-ascii?Q?rCG/rEAntlIqDgi0Jg2bg8gM6gC/fTgenQdSbNhY57CahaCEs+Xis48TIcGO?=
 =?us-ascii?Q?buEoSIJ9sKxRweu1UEg1rGunJKO2qdvdjQ5+MzCSvkQL91l7OnYQp+frhpti?=
 =?us-ascii?Q?U5/Zmg/czsgP1pfiykz0j94cL+QZ4nMXKp8F1DKZljXHGVk+DPcjcLmk9jEP?=
 =?us-ascii?Q?pz7LYBY6YCSvCPsJ/pRzFrsGvGvS+HsSpRfnOCTHVNapJOM0hbM7jdp3SYRv?=
 =?us-ascii?Q?g0v36o2+/Imcl35VFKSmCNagkUMSsldRHfqTTyP/QMB1ruTAjJAw2SyAdUE3?=
 =?us-ascii?Q?oHvmTZi5/hYqzb1+sk6e+se4ph8OCJpm+jQg5R1hB9eHo0LG7HN37eDeAnDs?=
 =?us-ascii?Q?39wOmYSctKDH3yMXj+kqxs0viJeP+m4U1fS+OhrFIhJneR/TfHBgfd/I21yT?=
 =?us-ascii?Q?jiht2NpczzTMmFjhxTCX4/RJbLlho0eeKwifGI/vAGkjsPMuVECocjFYIp6j?=
 =?us-ascii?Q?bvNlqMQB1kxS5V9rZXVJrX+GgpR9+8CgahzMkDkSdL8QWoJclz3xQ/E2DYLW?=
 =?us-ascii?Q?1PEUNconrsi42S6oH4pEgJTnsHa+t1SGMgx/HBFRjG7c1xKTGewOH6RltuHP?=
 =?us-ascii?Q?lvft5FDq4f9mX3aejRk2id36oAn/YqZn5mdUbi/6Zlrn8hlOR0Nh2Ug1uqaw?=
 =?us-ascii?Q?WgI//TgaZp1+hPCpY6kkO26xpQFpItZC1SZnlVMndTL4zcsC1nUz9SN6RPLo?=
 =?us-ascii?Q?2/xv6UHdyDXW0UP4Tb2j5pRdTGUAaHf0WgSC9M+HMdU9UaQdwqv9HXHX6/yY?=
 =?us-ascii?Q?2CImrGE/gcrNKFY2BgrXKKp1hmGvUbKNcPfH60nLwgx+z2V8PT1Q5P08TIG5?=
 =?us-ascii?Q?HIEqwQSksepNk7Tup/pXsd3+DwGQ/PsNKH7yusxjGUbIm0zftU3nB6dIylBn?=
 =?us-ascii?Q?tWKazn/FQ9rKPJRfcrrjouUXHBHbULOXBmuYbymAO/WlSHMoP1PHUlotzQOq?=
 =?us-ascii?Q?nwD16Us0oywX/gb6s/nWC4ZKUFR14+uscKAQxJ0rY2oDt0erdx4ZiuIAV3GJ?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hFd0Wm7AQk12FGPrVdgt1XiHrIrQPDNjTZyrHuy5T1dFH13M3MTndGKMhcYUserWJEjjU+dII2K9sJM9uSHx1Yaf6+rKVEsWcGJPFJPdPOx0SSNYjXU67BN5WNANMUNRXJjWf07B9fbN9S4dlLCGHyKqxbCJCBp8pW2iig5SHwiWnPZg5Yhptjai3Qi2YyyTL9eO+cHI+MW/tXZc/g/Om9G0AYRDiPJAzeXtxJHp2Nbeq8O7T99pVE+GMOO4UT5df5eFdEQyxSgLEINtJCOthVO3PywX14agboI7XizpM6sXdTJjIricHHOwRCDQIpkc00ZV8R4sYYwtG1SBbCYrbna0EqOc9lct8/icUUfhE3GyLaSvAY3ZEtDYdyJo1gSp3j7EsThz06qPaqFRvRBi8z6zxC3yTZci911TDGFfHLsyhHklktBhVgZKe89RR4vIdwrCtvQKu1VAKx5TbZKz1EvfF+SnArJS/zhR1x4U5w3hwyGlJD807hIXvjeE+ckVcxXlXnVh9PRfP+cVikfhFZ2Q7+TtE8Fd+1gphaDIbkLeRNqDoVDM54eeB7/6Tf+oiPN9GkB8DEs+5syGaf3fwoLUEefYdBKypnkMnwvgulI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27b4857-95c1-4617-23ae-08de268bd42f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:33.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wiXI+5UyhrZuvxaJ/ytvyNO26RH8rj7NjwnRxv7y9L4RLMzVde1o9A6fAdcJ/PdakOCp0zlPO5nkYm0sZes2QwsFHKrV5SEaYfy5/TZyFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180082
X-Proofpoint-GUID: Lm-P4E8PjDXnGg7Z3aAAUB1nh89Cns3q
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691c4802 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=NNagTMxLXCr8bz9WFNoA:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX20VPG9hxB3O+
 WsYSYm9LpvA5V8ONo+DUFpmYwdKkMJa4+QHa+RNat6tv4f7LPMw5jqargnjU+gPGOBOzmlT3Iwa
 rkEftyfWWgKaCf4+S2XjdKzKxHQM/w2R4+IOScIPXCdQkMW7Kq4vZiSVgwm3Bomv8ifdjHRqBip
 hs5oFeYOHjpqQXkGdTLx2Bg5g6Ia2mIGFQzYXk1pcc/kGdNA7/SWexVchh15+i3pSdMyUDf1Dae
 Pq4ayGZlg29gcjv+Qm9pU8tD54/hCPEQo287GVPMxGEecP9ylg/3/f51m+hHNyNtFdbZiEKVzP5
 tRzVQEVst2QTHtZYCpOWpBTKDDfI59aGSPIzo67ScP2jyXuzC7yaUn2KUtZEZSsrMlQfBt0Oaeq
 KcnfBuMoJc8cUtLkO2gXEIhg72zheJWLwnz2dgKtilC/s5DW71Y=
X-Proofpoint-ORIG-GUID: Lm-P4E8PjDXnGg7Z3aAAUB1nh89Cns3q

Now we have established the VM_MAYBE_GUARD flag and added the capacity to
set it atomically, do so upon MADV_GUARD_INSTALL.

The places where this flag is used currently and matter are:

* VMA merge - performed under mmap/VMA write lock, therefore excluding
  racing writes.

* /proc/$pid/smaps - can race the write, however this isn't meaningful
  as the flag write is performed at the point of the guard region being
  established, and thus an smaps reader can't reasonably expect to avoid
  races.  Due to atomicity, a reader will observe either the flag being
  set or not.  Therefore consistency will be maintained.

In all other cases the flag being set is irrelevant and atomicity
guarantees other flags will be read correctly.

Note that non-atomic updates of unrelated flags do not cause an issue with
this flag being set atomically, as writes of other flags are performed
under mmap/VMA write lock, and these atomic writes are performed under
mmap/VMA read lock, which excludes the write, avoiding RMW races.

Note that we do not encounter issues with KCSAN by adjusting this flag
atomically, as we are only updating a single bit in the flag bitmap and
therefore we do not need to annotate these changes.

We intentionally set this flag in advance of actually updating the page
tables, to ensure that any racing atomic read of this flag will only
return false prior to page tables being updated, to allow for
serialisation via page table locks.

Note that we set vma->anon_vma for anonymous mappings.  This is because
the expectation for anonymous mappings is that an anon_vma is established
should they possess any page table mappings.  This is also consistent with
what we were doing prior to this patch (unconditionally setting anon_vma
on guard region installation).

We also need to update retract_page_tables() to ensure that madvise(...,
MADV_COLLAPSE) doesn't incorrectly collapse file-backed ranges contain
guard regions.

This was previously guarded by anon_vma being set to catch MAP_PRIVATE
cases, but the introduction of VM_MAYBE_GUARD necessitates that we check
this flag instead.

We utilise vma_flag_test_atomic() to do so - we first perform an
optimistic check, then after the PTE page table lock is held, we can check
again safely, as upon guard marker install the flag is set atomically
prior to the page table lock being taken to actually apply it.

So if the initial check fails either:

* Page table retraction acquires page table lock prior to VM_MAYBE_GUARD
  being set - guard marker installation will be blocked until page table
  retraction is complete.

OR:

* Guard marker installation acquires page table lock after setting
  VM_MAYBE_GUARD, which raced and didn't pick this up in the initial
  optimistic check, blocking page table retraction until the guard regions
  are installed - the second VM_MAYBE_GUARD check will prevent page table
  retraction.

Either way we're safe.

We refactor the retraction checks into a single
file_backed_vma_is_retractable(), there doesn't seem to be any reason that
the checks were separated as before.

Note that VM_MAYBE_GUARD being set atomically remains correct as
vma_needs_copy() is invoked with the mmap and VMA write locks held,
excluding any race with madvise_guard_install().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 71 ++++++++++++++++++++++++++++++++-----------------
 mm/madvise.c    | 22 +++++++++------
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f6ed1072ed6e..af1c162c9a94 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1710,6 +1710,43 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
+/* Can we retract page tables for this file-backed VMA? */
+static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
+{
+	/*
+	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
+	 * got written to. These VMAs are likely not worth removing
+	 * page tables from, as PMD-mapping is likely to be split later.
+	 */
+	if (READ_ONCE(vma->anon_vma))
+		return false;
+
+	/*
+	 * When a vma is registered with uffd-wp, we cannot recycle
+	 * the page table because there may be pte markers installed.
+	 * Other vmas can still have the same file mapped hugely, but
+	 * skip this one: it will always be mapped in small page size
+	 * for uffd-wp registered ranges.
+	 */
+	if (userfaultfd_wp(vma))
+		return false;
+
+	/*
+	 * If the VMA contains guard regions then we can't collapse it.
+	 *
+	 * This is set atomically on guard marker installation under mmap/VMA
+	 * read lock, and here we may not hold any VMA or mmap lock at all.
+	 *
+	 * This is therefore serialised on the PTE page table lock, which is
+	 * obtained on guard region installation after the flag is set, so this
+	 * check being performed under this lock excludes races.
+	 */
+	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
+		return false;
+
+	return true;
+}
+
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
@@ -1724,14 +1761,6 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *ptl;
 		bool success = false;
 
-		/*
-		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
-		 * got written to. These VMAs are likely not worth removing
-		 * page tables from, as PMD-mapping is likely to be split later.
-		 */
-		if (READ_ONCE(vma->anon_vma))
-			continue;
-
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK ||
 		    vma->vm_end < addr + HPAGE_PMD_SIZE)
@@ -1743,14 +1772,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 
 		if (hpage_collapse_test_exit(mm))
 			continue;
-		/*
-		 * When a vma is registered with uffd-wp, we cannot recycle
-		 * the page table because there may be pte markers installed.
-		 * Other vmas can still have the same file mapped hugely, but
-		 * skip this one: it will always be mapped in small page size
-		 * for uffd-wp registered ranges.
-		 */
-		if (userfaultfd_wp(vma))
+
+		if (!file_backed_vma_is_retractable(vma))
 			continue;
 
 		/* PTEs were notified when unmapped; but now for the PMD? */
@@ -1777,15 +1800,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
 		/*
-		 * Huge page lock is still held, so normally the page table
-		 * must remain empty; and we have already skipped anon_vma
-		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
-		 * held, it is still possible for a racing userfaultfd_ioctl()
-		 * to have inserted ptes or markers.  Now that we hold ptlock,
-		 * repeating the anon_vma check protects from one category,
-		 * and repeating the userfaultfd_wp() check from another.
+		 * Huge page lock is still held, so normally the page table must
+		 * remain empty; and we have already skipped anon_vma and
+		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
+		 * it is still possible for a racing userfaultfd_ioctl() or
+		 * madvise() to have inserted ptes or markers.  Now that we hold
+		 * ptlock, repeating the retractable checks protects us from
+		 * races against the prior checks.
 		 */
-		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
+		if (likely(file_backed_vma_is_retractable(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
 			success = true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 0b3280752bfb..5dbe40be7c65 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1141,15 +1141,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		return -EINVAL;
 
 	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
-	 *
-	 * This ensures that on fork, we copy page tables correctly.
+	 * Set atomically under read lock. All pertinent readers will need to
+	 * acquire an mmap/VMA write lock to read it. All remaining readers may
+	 * or may not see the flag set, but we don't care.
+	 */
+	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
+
+	/*
+	 * If anonymous and we are establishing page tables the VMA ought to
+	 * have an anon_vma associated with it.
 	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
+	if (vma_is_anonymous(vma)) {
+		err = anon_vma_prepare(vma);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
-- 
2.51.2


