Return-Path: <linux-fsdevel+bounces-47754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D9DAA551B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36044E1C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33927A454;
	Wed, 30 Apr 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fv5wHf3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x1v6/CMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430A279913;
	Wed, 30 Apr 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042896; cv=fail; b=QiQpOaw5VA+oUbovAMCO2t/Qs2rrM5dK5HxdFoAzaZ1fka9xnf6X6ZMUdrkYBiZ4J4Dcef/llDKVizDSTCF3rGOgO4LYy5eDoV0O5r03udOgtMVirX5wXwoyu3asbXf5Es+gQBg+YgogoZ6qIXMUtHwo45wKtux6q246aM9D4xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042896; c=relaxed/simple;
	bh=jo0/0aIT/XugcDN6/phBLgpySvGT+UWgLpe2A/UQmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ompRjAmGjYei378VffrzAnnbjOVIiDA13Gd9XrZwhRzSWoQWkoLvND2q3EIL0y6qbHCL/e3umignFWijj7lEFuWbgpIgPNDE0zQYiLeQ4a7rPw5uXJDc0SsDkv07QAtWuMBkLBVYCQw6SFiHYeuALfEB8+bO+QK7RfvXLDlJy58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fv5wHf3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x1v6/CMN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHtxdY017065;
	Wed, 30 Apr 2025 19:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=; b=
	Fv5wHf3oKRsyv4SJbl15yPrmYU8G0b316A5e3PbytvpBYJaCJcO0slgSilRhLz5i
	7o5dRTSJRont8vgh+Es5TutPIUEBQTDVcg2p2EcYIIAl33CIC/pjxxVzhvG+sSnU
	+6g8p2585zWJwJ9bvU/ZgzGNRc+mVUTpodEFuF8EiUVSiAbmQcrU+O+Ka7cL0S53
	Iuun4UVDhjnf+sPvxn5yyU5f66T9U0gaUoDsTdg8AEj4hbeKFnJ+mLk+H85HyvVL
	dZKjy+OFpeT+h7tHl7+fGo7hBsyoVFzUduVym35IjWQ5wowtvNqyBsBRItlyzSS+
	u5iTmY94h8Hm/jL+3dbKdg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uma01f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJIC28011981;
	Wed, 30 Apr 2025 19:54:38 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxc9snk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqaJ5Ud+jdWO3uT5UQrDqYSkQKzEI9oKWXrK7i8KWwwwqZKkEnjkVayVB/6NsLklM63iKLhFNPHuXDZoz5hhSt/AQK9xFmg6iH+GGmrOJGK7ayABTGwMxnTfNyp3+RP5gYmfmraDWb4g1/yofwetdEsWocp4+2dzAVHIfGRbdyTf1ynY9IxC7cAd6V/h+Q6dz1gpP8zgwGof/XI+swoO3RvyMlnhmafHqtPDDk5xJGqC85Yh4qi3h9fFac9CTUBTOQn0qOXEqVNvHo3mK/WJtBR9ixkEBhCo3Tz9npysTXZDBnYT2Fo2w/Dq+MAFRX5PtFHUEDgndzrC/Wge9v9SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=;
 b=wxx9XW6Rv5acbF2+ZNVZhjc+hg5Ma0KWm0RvvXgW0gN75Tk6I0pCMfDTTP0Sn2oJTfQP9I9v43rDTYMxccXDtUE28+keYyPJRcXeM3bkN1tfqWzBjlsIf+QGN+au+79S1mrJIFafF95SijTw/QxgCrxJqYag0nGqBpcg1Y94cR2pLyv6oVqpTDf6KztwwrMBlPKHYsdcO/Mt2fWn4pP8zHUbFn1IISvElzQEDWUpame9jHIgmBh7sFC6YxHan1fzWhqlBbdpO2A1orC25zhExdE2BVY018ZW/9S80Z0Zniy2Jv0AnqRRSotADZJC8nXnphd4BHbf/fvea//CFK/9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I/HV1cnAxwHYKohd0J7clXbAg05cRUgE8nyzc4Lvms=;
 b=x1v6/CMNabNczSdvE85CbChwoghbL04Q6ZMCP7sSilINvneWa62zEKGhEbuoykqtzMUevAiUh7fgRadoCzXZl8d4lE6KOhFwWfACkHKIugKytv+U2AgdL3jKw0nOe02+Yz74cznduc1VoKKX74U3f9dxBL0hv9MC7fSEwfVld0U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 19:54:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:54:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan --cc=Michal Hocko <"surenb@google.commhocko"@suse.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 3/3] mm/vma: remove mmap() retry merge
Date: Wed, 30 Apr 2025 20:54:13 +0100
Message-ID: <da9305fddaf807eeb7bc6688f0c6cdf14c148c27.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f4382e-be72-42b6-d90e-08dd8820d5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWPIc02pM/esGcfsS66spUzocHWPGEzAbX8Yr69wNV15LLFm9QF4bTzFP8N1?=
 =?us-ascii?Q?MZAkOuvfx77Ar8AmmeShQYmoCwMCqZbwteZ4pQAvNahuubY9GK0/QfwOIEmm?=
 =?us-ascii?Q?eQNICI9YJyShtqe7QoF6DV2dfw81NydkfJQ5HSBtSYJ+KvMzfhnF1+MzYzJQ?=
 =?us-ascii?Q?qKrCCylqjDT0Yq/C4sL2gopLU8qZaRsxaPOBue2qQ33Mdo0Dw3UYM1xt23eS?=
 =?us-ascii?Q?GgS61BpFu6jcbdbzxzwu0CGBBxNjUIvjBUZNy7OO10O768OPHgoARubAa7tZ?=
 =?us-ascii?Q?CTcaE3oJk7VoPRUhljO9LA4i2cVld8DVzjLgoZWO5t6DthU5w6vjm8+w4n+z?=
 =?us-ascii?Q?jvxM1dErNcfERWebRXapEZN3eKknVY/029UPiMIy8VZDvZeteElr0MCPLNJa?=
 =?us-ascii?Q?GZXt1gbx9q7Pfd8o6ODLEDVt4g7KD31LOMRK1ijRi/HBRDfw21fJXCTywX9g?=
 =?us-ascii?Q?cnEk50a6QOgmRNzrsPrVHCOh+S2EefjUurPf10ODykpzER8RbySbUgJG5HDK?=
 =?us-ascii?Q?0A7gUrPNRDbzRcab+4vyr8MCZBF6KlkFzUlpcd2LH8J3sp4LUpaMxhoXRaic?=
 =?us-ascii?Q?DseCGyVHJcaNxJkD2i/Ya3NmMbfP78yRz757iajZDdkRXDA9cYg7qwE2DPvQ?=
 =?us-ascii?Q?47sJ5i7w5toqzpcq0T7D9qE47HE9wDNVbkx64jCqxUwzWUM4BJiI5ppZHefV?=
 =?us-ascii?Q?9XV8rJ3xiMmTStypEbxX7EoznUCWqAhOJYk0JlQmjRndn8J8k9Wuk/MRFF9C?=
 =?us-ascii?Q?V2vanFGJ2YzNaGcNoWhNL1IIvZi2iOH3PsVSH6QVdrXu1gmtnMKdUBogvWqS?=
 =?us-ascii?Q?TBOJ2P+GMAmQUErbJKAdnmpqKMAgVsbtWAHNGlpJL0CpXXYL5QJafniqRufa?=
 =?us-ascii?Q?cZ1vpNz+XruXKxLQkIYRZltakNoZ6FtKF16nQstNvhTqEDC5zNvjbpvcgtcg?=
 =?us-ascii?Q?EIboXJxIy7LDqHB5Yw5G151glrTnAVvSsSjVLSrdVZsjnDWFmDzVBFqFtBuB?=
 =?us-ascii?Q?WWbzDV/IvVcfjyCKzCpOSDaS8vNjCCHuk7P0bKphkbNekiGvXPbKvRMKG41k?=
 =?us-ascii?Q?AKgNZPSlteM9o0SqPRjP7WFP7mU3iuLQpV4PxxoH5e6wCYDKfNTBC16JsQQy?=
 =?us-ascii?Q?+QrN+oAmNIrCmZ7gr9CANFKXv0zx0xsxpeqYngPpI9qI/gx+67ziGEn9E1BG?=
 =?us-ascii?Q?A6oxKSXsvODpIeU1WFudQ6O8ytQdMNXQbohjklJY9EcBaK9fr4AyVsiIGtSU?=
 =?us-ascii?Q?o+7O0AKdHY9thhBnxJjC/QCPmfOguL1SHPFlnRhZK209Ef+A3TfDnXBwUnQn?=
 =?us-ascii?Q?lEd4UxCBNZqeal6NT8s0VIce2zeYM+zzjFJIawSThklS3d3eUWyr0G61s8ji?=
 =?us-ascii?Q?WYTbPxYXU54T5ox+gHP9KBFzi1DZa6KN24/H/dp2/hhVdJcTbYU63DP5FYV8?=
 =?us-ascii?Q?ovgqh62T5Ic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxZnCzSkWMWjAw3ortcnMafYiI7T5sc6Hn4fUejzK/J5XA3fjsTSZjiReHbs?=
 =?us-ascii?Q?8bvzgRKxBWW/Z4k3e8dyPztgEqTdGaZkxsX1NOgKXdG/BQTH/T/WOwD9P+Yz?=
 =?us-ascii?Q?3HxSpVDMmC5GrrNHolTZ0Q4oCIEHtAqfFUBEYGMu5uyWUGuoNW+jGT3uFeFk?=
 =?us-ascii?Q?YIOy3lLRMSypywSBfF/+PvTO1VXCKNaX7DYjehqFq7hclFEoOPgJg9RrjDc3?=
 =?us-ascii?Q?jrcec7XRB5yzo76AjBJn5Sb4K5w28FU5jSeAf6qSdrjjm+2QMfEBvWuotjcq?=
 =?us-ascii?Q?Lv8zc3aZNnLt4FAnW8Q+umTVDbZV7J+vpHvmQK78/b/xBkYTA11NN1hlCZf6?=
 =?us-ascii?Q?6+Iy7GiebE5infv0Uuerb60q+RyPwNLVCw7/sQe1c7DX0hQXdtCS9NSZFJRs?=
 =?us-ascii?Q?wWajlYLzO55NKRLlD0lEpab2/mrelGElq42hvJm1YpDQsY6wOxB4dxFZJotG?=
 =?us-ascii?Q?yjn7ysRvakC5S7QQeco494o8k0IQnIjj7r1iP5r9GNapfD+ivUL8qEVMyeN3?=
 =?us-ascii?Q?DrHOKrl4O9a2RQsKLMuJm9htVshkRMlc8HuR8kmnjf5W2awkzrBdL45JRYBO?=
 =?us-ascii?Q?VfImVSV5VGokiS08oxCGnLV/wTFDHlRIM4diViI0qVFiV/ki45gabyctR3rx?=
 =?us-ascii?Q?2HeUP5xpwiY5dXwF8rounLj8/HIpXQWkKuNYriDEADkMBvnwHo3VDdt6k+vB?=
 =?us-ascii?Q?oDirry2FUji4slAsWlJ8eQHo0uYwqCNCL+5nlHl2UAET0oxoCGV+UqOuX7fV?=
 =?us-ascii?Q?DKN5VDvl+4egtBeJIE7DtN/YhpS58eHAvDSD+qznUEjEU+Rsa1CRYm4mpK2P?=
 =?us-ascii?Q?cO03ZuQdX+AdTsJh5xncy/3ityOBIHNQknYxdzhKmoPxxKjLwLw3kDAGR1cJ?=
 =?us-ascii?Q?yn+JVjz72RPhhbwW8N90l13hiEjWWdfTmu3mAFmDQTeF7BxDrE4tmlwnnjCF?=
 =?us-ascii?Q?h3WeG5CBPG/gBgo5/a54mi9naGyPv7nEsl2V7yfTlk2rkfUmmD2p7xjst6lP?=
 =?us-ascii?Q?Xw8c9cHzRHlLV4+MxlRVtKlqL+jKD7eEKcw1JOrLbY1jCTKqLTPiVpDFnr1L?=
 =?us-ascii?Q?bFZXWp9cnxuYylD7Qz6JTjal26RqPU/5L6KgqfB+FBLhzdTkZ6SZAcq+58fK?=
 =?us-ascii?Q?Zi0jf5iO6nQB8mnbIElE/sWi5PFboO9vSBnd6utvzmvz9oR0jgfHI+X6iBEj?=
 =?us-ascii?Q?+8qOIDPMkVhu7EoiTyhO3SvXwfTbgrKrFhxn/wpDv+61XT206qKWugs2hJZW?=
 =?us-ascii?Q?xjwLoaoy8nWrO8IiBmGa+1wdtPnGxfS3HW8x/jOqBnht3CjZ2GwifVAujXyY?=
 =?us-ascii?Q?R2cER3QLJlamLHW260J+i8rUPdGGS/CcSq0Oat3kWkdZ4lBKy7UX6CGmN5dK?=
 =?us-ascii?Q?g2FkncmiBXQqjsRq0U+kRRNiG2YaosgP1JIvKa5GzPqNZcAjpK8MIS5sffQV?=
 =?us-ascii?Q?vJ6rjrDz/0XGXb1OCW6HzSv2SVtikI6oSmsGcbT6+BRL+T38KJwQ/hR2UmDQ?=
 =?us-ascii?Q?vEu7Vdbff5dzJzSvmafhvucO2RoEwbiHh3UFzkVpUZJNcyOoeE2biH/mbxxe?=
 =?us-ascii?Q?rzUX+Ec8ynHHR1HF/0c5BGqmBXdFgJqLkcS0XzH0E5AyD9A3VLJSI5VWF/qQ?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	00cxG58O9BQ2m0Z7moYPciIehnT/PN9tZN6SesHRigPVJ/l3Sq+Bn3RinQxisOVdWLIZnqbaX5asEYqa729lvSsOZBmwaC5zUH7oAwRGMokxKgA4H1p1NWz/yOSf0Dd1W07Dlivtd6+6g1OaFBIzynnQT76JrbtsaFaIk3MRF1+0PkJqF/Fy2VBO8Cg05GgoummNWO5c+fS1E1UhF4vl1nxBuRk5oZ0qiZQtKawTjVk/OWkI+oBU7Y5LSJaNhGXRPldOfT0m2hlkaZYrC5m/wZD7GTbXJpfgG23J1j8C0Iem32LQqIZJ+VVA4otCvhBIoJIt2hdeu/K3HH/cOlTILoUEccMDlj3wTSs/PsevJtao5/5IjeIYzKtQGAbMdEpNyA/GXt3DnTU947M7ceDphVdHLErezzrC7ig/78kYRmFertdxGAA83ceAML08aKSmBNs58C/pMFankqoqlJU4As/p8aAS/ZbennwDQiGqZXKIN/++QaVJk3x/u5dkhOtmaYLM5eYItYIHkzqYb/hAsd4GsrumhxfFLtccWy2d5LN58BOYIJ/LKOtMso2j9uWGSWDk8kfCpf0PBJjQSuYkGfeTJcRDu+PA+XUA/UvqbME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f4382e-be72-42b6-d90e-08dd8820d5c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:54:36.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVjZ8LXj7Yen5ymlerm+CpXUytTVr8nrVUSF9vtrUZWA6LVE+XdspFiKvj75nFoL4PtTm5ugJZR4K7CaP6WAhupWzJEkmkVyXOdW1xe93qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300145
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68127fff cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KWrF3PiNL9PbMbJVJAMA:9
X-Proofpoint-GUID: dSnkcayLPEKJDfUGpRwvIlTNL5Medaol
X-Proofpoint-ORIG-GUID: dSnkcayLPEKJDfUGpRwvIlTNL5Medaol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NSBTYWx0ZWRfX9SUIM28TrBvl wKOaXtcaRABWgdLhrdwqSgqk0I7iSq7tGGxhbSQlRGFzuIClKggH4KJ0RjOWE8Bv6UAQhY4cCAn aLkrRFPu80RPJN00s18s2jS/mjPnGRYR8iitUD3JfkwcyX/L5nUrEmv7Fk/fv9fLeFqpYdwxxo3
 Qdwayp3SVTBFgL6Wa+B1FtyP0cESUPsge0LF/OqVZeLXVnGR/qo85lnVpRHqKl/7t9i+x6Err0n qot6ihkEunL8vVPsYwIqMc8bHgaYyyw7cQRqvSHgQbLvGOcBtEJDO+eIzr48a8sd+BuUYI7KYhh qw2GNckscmZ5Wheg+zNrlMiYPvmRHI/VxDinZR75lPHNG0bHMV7midCFwqnVd8w5DL5fnoM/K9T
 k+7p7YkXouJTtSJwjBl8r903JZGajKknG6n+LqTftCvED0PCZJoOsKs7I4+NeQYA62n/idp+

We have now introduced a mechanism that obviates the need for a reattempted
merge via the f_op->mmap_proto() hook, so eliminate this functionality
altogether.

The retry merge logic has been the cause of a great deal of complexity in
the past and required a great deal of careful manoeuvring of code to ensure
its continued and correct functionality.

It has also recently been involved in an issue surrounding maple tree
state, which again points to its problematic nature.

We make it much easier to reason about mmap() logic by eliminating this and
simply writing a VMA once. This also opens the doors to future
optimisation and improvement in the mmap() logic.

For any device or file system which encounters unwanted VMA fragmentation
as a result of this change (that is, having not implemented .mmap_proto
hooks), the issue is easily resolvable by doing so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 76bd3a67ce0f..40c98f88472e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -24,7 +24,6 @@ struct mmap_state {
 	void *vm_private_data;
 
 	unsigned long charged;
-	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2423,8 +2422,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	/* If the flags change (and are mergeable), let's retry later. */
-	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;
 
 	return 0;
@@ -2641,17 +2638,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_proto)
 		set_vma_user_defined_fields(vma, &map);
 
-	/* If flags changed, we might be able to merge, so try again. */
-	if (map.retry_merge) {
-		struct vm_area_struct *merged;
-		VMG_MMAP_STATE(vmg, &map, vma);
-
-		vma_iter_config(map.vmi, map.addr, map.end);
-		merged = vma_merge_existing_range(&vmg);
-		if (merged)
-			vma = merged;
-	}
-
 	__mmap_complete(&map, vma);
 
 	return addr;
-- 
2.49.0


