Return-Path: <linux-fsdevel+bounces-47751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91171AA5514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A01BC7667
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFE27586F;
	Wed, 30 Apr 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PlnSx7/B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="paOTo/Py"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E925218E81;
	Wed, 30 Apr 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042888; cv=fail; b=MauYjWqgFagu5eNHIxLUtWwraNUE9OIbyPl861ItogiPHIH+R/8BmtFUbaZ44CKZpwY/AEucAG6T/rGUtZxBOuS0J8EMRJ6a3wnRqwPNINKiR6fzLVcHhiun3DAwLSH1xN07UhrAhziBbYiNaLNNiGUUK/l5y8Y+tWTWac46rbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042888; c=relaxed/simple;
	bh=JXL35mgWehkuuRtdtKm7iUjNXSnwLSJ/4YD1vvsTp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d2P+pBKG8aXde65tYg7w4X6soiu2rTjsxDGEyRs8CCmtNLQxVzW0IZ+N7+uINRjdbYzsZ1panMKeVYk4k563z44tvUIaxedy+lPqKyMQ8bPOiSGH1LE5RvPeQhYjOJUxBPKTr5foR0+D/IdZ+76/tTHKKfM0/WXSzif9bpNxPVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PlnSx7/B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=paOTo/Py; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHuOhj031763;
	Wed, 30 Apr 2025 19:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=UTq+SEqqreKx6qnx
	u7QsV/akvEiqVob8VVdFb6zS0Fw=; b=PlnSx7/BaMW3iRIZdhZotW4g4otmJVXp
	uytVgbub/FlsdnQ/KR2Rz7+Ruvt/EnhX6JDWzuuUclPo4i6AtGs7koFhP2azIAvd
	J1m763RSAgkjqwkMmiEWbpXV4tEBFPEEyn7GpO8zfMa966ue0GlTeleFPRVsnoiU
	zBmdLsd6mtW+jEVQp1UM9FzE0v756vxDjQHoAYOsysZlTSZYsjn3Qs+RIf/YCOpD
	mRQQgUbSn8OtNwwLkE2Mhq1I6Cpgqk099+TmWE8GYoPh9d7mC8AWSJkBF9V/6piD
	6whYC45wetWz/QhqcMzskouqjLNgdnz2bhCRB1DAt3WTdlJ9i7f7Ug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucj0gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJmPgx023726;
	Wed, 30 Apr 2025 19:54:30 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxj1909-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJGTUvx1HpWL9ecMFu+lkwUCHf602g2KtsbMJAO3vuCWdf/pt/CKXj/qsAzp6dkZieHj9WfbMiSA6iUZ8W0fVQOm/Ril2XbwsrFncNkMmvMWSJ8xRkcv0wb+uCj0oH3hGfXTUwzZv5nntE+DQIEJF1BzhDjkG3k8VSzy1gajy8C2LvKbrJ+MfjYT9hXyIX1CJjbGUVe0BNanmrh0tPo1735PbOWplQIsms5OIIIOA7XdFWArOFg5b8nHh5LzfT2sOqVceSRrPsbmVjf9nGRaYemqWZQtjYIcvE4DMnxJ4p5kYkNWIL9/+gGvOKH25WNtPOzc5vQGfgqjLm9z/GeE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTq+SEqqreKx6qnxu7QsV/akvEiqVob8VVdFb6zS0Fw=;
 b=gU6ke8k3a63baX2aJvBFtoFKWhrg5yy1g4b5uDG9tXToQEqpkg1qxBlItfoKy7dXCzMV97a2bM6jWthNbhYNwuM235f2dLcadUPDb+kDKPuzaxAjJ+RuaB8IfW7EvW4o0cTwT4JThSrROGh8vULCthRDoBWxbMmlLUmQVHa02/+/Ok7Bu/5hiRea7W6IZry9euT4+2Yz8hWR2DrFg/NuOS6BL1yBffHsOr1QlsCAPmExgi3bwI8oRpDdT+wgvi2Afu3sCx+dKuvPi1S0Om3vipoCnVTF/HgZMpOkd7dBgInsy3JtxkCAGW1CV1obufe1V2WiYOfaNsRIcXBAosGebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTq+SEqqreKx6qnxu7QsV/akvEiqVob8VVdFb6zS0Fw=;
 b=paOTo/PyhBm+joM9JQoaiWvecghIup88woOqz5Ftf0yAOixVx85sSOMYiKUjePRydogJbNLIFnwqK8q0nnTTuZ2TjUFwEeZLLF1QwXxuydtsnPaw4pqz8fWJuy3npbGXbqVYXx6RzDJDFrCE34VhpoBDkXe5EvIDhI0cZPZr8X0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 19:54:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:54:27 +0000
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
Subject: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto hook
Date: Wed, 30 Apr 2025 20:54:10 +0100
Message-ID: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0578.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a0ad1a-7290-4003-fe1f-08dd8820d0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xxYWvnkQSTCgZA3r+Cm6l1+VejfdUsxt8twbzYul6oCpf+mkXT6l8a+e1T9M?=
 =?us-ascii?Q?nh1zUwJA1VwOd9Bapi0VXChhR2QQbZgEqL8gGc/rFdo5kY/Xpwi/AnUKHofo?=
 =?us-ascii?Q?iQZRTmiXzqRUmaX35FU3BBxuXVnFNyLtHJmJpOp5YbM7vrPedd4Djxc1oBiJ?=
 =?us-ascii?Q?2UtsrbOTEW7jhMdslojpjwPjQAGmi6me6E4Sc2tTJnq2YZaSdukIEz/+DOCV?=
 =?us-ascii?Q?nPxMdfe+cl8Y2OwdF8dd/323U/R6BQfNQfeeQFEXiSb8Rzqsr39Mv6JEU3dC?=
 =?us-ascii?Q?LNTbi/WZLlT+vr8y5ndPXd1MXjRg0WKdq7rZHnNJbtbX7Pf0Quev7Flgs42U?=
 =?us-ascii?Q?OAvWwtoy+RsrQwYLuCeuTmfPVLO5/lRSbVwg9C4H8JNECjunDQOXVvMt6wmt?=
 =?us-ascii?Q?W9ayCBdRPZpC6ijUajsoVdyZkKBI8XQ+CV2bRVXsXzv0HCyCZH7TH6l3Su92?=
 =?us-ascii?Q?y7kJ1p7o90fowaAwDOJDbq1TZSI4jfofUTfxTdI+X1tatI1fcJg0B6CWyUId?=
 =?us-ascii?Q?YK8Qq/Vab5fWFOhkPUyvkbjaHo3KU4qLdDB2qC2bc6i0ZKZ8S5SHZzBXIf3u?=
 =?us-ascii?Q?TYV47cgVVhemh9XS9m1r5gFadO904etQ0SyWHlz1Wk9CVNh/ngZTMjAaoPj1?=
 =?us-ascii?Q?0AuU4KZDYZxjXq8xoMCP3PFTHxlqIYRQbL1VvCWpNawnk/NRkvO1lw+ECT7f?=
 =?us-ascii?Q?Kmf/bkG5IdJCaiDb60eOEcrBLMwDbfzdlg+KNVdDRQl1hhOCDn3d51Z/ZNuA?=
 =?us-ascii?Q?1NIuybsFBIkBNIfQpduvNbvrj9PuLH5Hb3ysg+n7zNUg156lvMND8dObNvAt?=
 =?us-ascii?Q?QkyG2gM6wTLPvbLfxrHwucFTAeAQw84TT+Lp2UbGDdu6IVyAgIdlW4EWPAN3?=
 =?us-ascii?Q?tNm4gnlYAPVjORZm2ULqM06F74ntv+gLeisnl72trkGtJSXSntsUZKgb8crv?=
 =?us-ascii?Q?aoytVloJX0TQKoO7PyQd2enzqxrAs3SZ04Day+C2UXUdZ60lIXncI0DedUel?=
 =?us-ascii?Q?/2URPxLPWdLqEgICJNryJ12350El01uDYzhD7b5pyLYZnCOSk9WrdezeoDQW?=
 =?us-ascii?Q?DiYD8Kf719TGG0SqVVAxz9mMGWbnEqnTiKiZh7DOdIGYKIrziZrzzhGQnWKC?=
 =?us-ascii?Q?JY9EDwVQg60VrUy04A5VCdEG0ZXY6sGeGiWJ48CeZneRID3fEPcpSfKc9/jD?=
 =?us-ascii?Q?6uzhDVJs+Bv43b7CyIv8I+15gVqIDixKhpfKKBMCawUb/y0XZMheMjZx/4NR?=
 =?us-ascii?Q?2dxVu3PUm54bNp9yCYDYTCAewvcX+9BuHDy1+ti1fu/w0tHNJutRm/agctsn?=
 =?us-ascii?Q?b9JA4ygbmAA31uv+GYuZJQobSH+Z8zlRTRwYJzxL3SkEAomuWOhjMlAyaNSx?=
 =?us-ascii?Q?FtZTc87F2KS2XqAFWxgQsChyVRzJXNyvsqT+OMvXB037gAaFshoFVF7yWg1t?=
 =?us-ascii?Q?9FwM2qeR8+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NaANflqOyYlDwbu0GJ4Ws5VH5gUhRnGir+ympwzOIX2I0W0imRupCJFtJij?=
 =?us-ascii?Q?pcykflY+zj+0IqZU7fsspOOzReX9EnixBA8pS4kCJkf0Y6j7oJ/hntFyAgdr?=
 =?us-ascii?Q?m/0oY1WSTqKh5Yi3QzlVBp2b3/Jvn1SImeZmJ5VH2es6TvQwlVRvfvn4ka54?=
 =?us-ascii?Q?YghDizbHfBH0Ic7io4oNXTL5EMXmiRBcXIRqR+2mHpFap9KCBCNSX+PE6Hzu?=
 =?us-ascii?Q?G5wJ5TjR1VQJaMWO0ZYKMo+2pRlM5SIEyN3nYoH+6E2QdQHdxOlqg8gNIjFv?=
 =?us-ascii?Q?mjbqNhxDy8FiKqUiZqzJQCZ+qBY+tQCt4icCcyBsLyR2asjBE/ieA97zq+kh?=
 =?us-ascii?Q?wV9czDou0wXd27Jk22YwdUNh+rFelY8y8/roevqHXs7VZ1wlvp/T1+2wCEnS?=
 =?us-ascii?Q?pFUeVDNvvHQIixpFSk6/avPuYs8y3OM+0JTdBtAcuTgDkpXD6jMGbQqPtdSm?=
 =?us-ascii?Q?X0J/jS0vdwJse5jECwnr6T1Qy3vQJ9FxU1DLe5d52ZrGsqUDiDadZ1yVhRrA?=
 =?us-ascii?Q?YKBE58pqNHcPzLW8f6Zsi3LwHDteYU017dAKDLhbLPexE8Ji3wTElup7Qnyv?=
 =?us-ascii?Q?aJUe0mJVrcI5Uae8jhihEkOr7ibR8m7dATI/lO7U3tiEpRsan8EQZT6e+468?=
 =?us-ascii?Q?/yHPftGEwRRAD/4DKt0jKe48NCykVtlnlZzkKzvpM54/ZRm3i9KWzWH9OKQ8?=
 =?us-ascii?Q?f+ybbk8IFcgZu8j6GzTX0VOIy58p75HdqHcjCAlsACcwvmvteA/WHTa9Mv3N?=
 =?us-ascii?Q?vemamCvpAMN3Ki0TwPn/zTwhoAux5gFUNwVqtjnRuE0FfIeySVZ37/oyx/Hc?=
 =?us-ascii?Q?dUukPPnn7Bh/05x+A7qLMXUCUVsc/SqhLKSmh3BxyGySmmVKkzSycD/UgSWJ?=
 =?us-ascii?Q?qZKLbMFmTXi1KGsCe0LDCr7SLbJVRXJVy8JRb6F2K8K5KQIM/hKj+Pj0gZaJ?=
 =?us-ascii?Q?Yg9hKKDoNpYPnchVI4kik4wAPeu6lMiC9wH/a9GCnjIe0xqa88lynaUnWBxh?=
 =?us-ascii?Q?fcpIpjsrNqZnkfXMzWcDmVBlSEO/TjHhWwz7N6ijsM+kbaAwE+oLP+htoZ9e?=
 =?us-ascii?Q?7ULqGVIs8ipqlbqXNGw3GF5G8cLWUMwy5p4s/KwKYet0Km4QFFQBtPpV4TlA?=
 =?us-ascii?Q?c0Dpnvk8ZwhHUSj5tMah34hq9RApw2AMW1XXDr+Z8g71n6IdYFYb4PJUrNJa?=
 =?us-ascii?Q?VPiWIqx+axJ+UjKpbl7XT+sWYILdDKcEqU6BTqYH6F1Lu5L1yZ5As+cVREvu?=
 =?us-ascii?Q?6Y5o/sZ4nVzKlBiKYkQczgQD4ZfOsAlBxLTXdl2klLZGO1N6A2orldfwaC+K?=
 =?us-ascii?Q?8Q6jTikzFcjmDap0EGRCAk0k3ywHCzsMqYNQFnuDGIe/a2hBmKmawQlU4+MF?=
 =?us-ascii?Q?fbyxdx4/d4z3jtnHKBTB9zd1WcIxizX9FFQo6PHqo/JfGUk4dKYEOHu6HeOR?=
 =?us-ascii?Q?/kffT5Gs9dRBLL/xWrOXtdZP0RgqEqAl0C+LlP2wi1+Exom0n2Onlu6DXvGq?=
 =?us-ascii?Q?jfy2Ux3oaMV4kkU5dIG4X2E2X/FUszsp6g52HUs0OsTW60bYAddoi5QpcLZl?=
 =?us-ascii?Q?k9j/iGoxtijRNgiwRMa4em0dzBz+c2aY3DyKDHE4EOLrBcp3M0GHs/vxxL0D?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0xwAB2omBQvv2oR8nQoqeobezGNR3CV1Qkn4e3UcwP+YkqPC7Oi1PXmaWCO+we29l8QNW5ml+YUI9d/lhrWOcljhT6l0GsnjqwQO8X3XDwNPc9MyF4MDQG9X8sxSsHM/wcHdMAOQVGYn0nmqrETy1s/+5H4TR7x2wNok9eafo3rISIzZ/mOA9Ohfe0xoixa8l2pkUW1TM63XzMJlyqL915VeR3IoVa7Zzn0TD6bPTvZYliOMK0ctZ7CVfryltN+QkXj+SpiIyfQzm5HVoDVUDQaMp9eNIaeQigoFaEOPY6+21le3NRJ60cnWok8VzSS96uAD4k3JIilE9t9Hvo3ZTka6IjfJoX7/pdHJLEYXdREa/D3oUvx/yiEgEf+Xs1OB9QKA1SkcNl7vTBn3bPmdqCzSZmfcTraw3s3Gf49A243eQ1VpYkMD8YWWAa4faY3X4oYRx/UpWpxCwg1X9bgBXzBN7lrEyA+IWNNf9aIOTAvE5MeWwpqY+zPxwokf/pkCiKSlU1rkvB1JXNdtetodcpoko+Dsk7GjO2xJylbGfBxSVC2Jhwk/fYmvZcE7cwh7fBw0AgeAECs3e+++Ups3UokyrNmLq9bXU7Ouk3FDEN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a0ad1a-7290-4003-fe1f-08dd8820d0a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:54:27.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erwHXpUpavzEHcqSgtqlAWBoT5BC8tySAuSsI8OnwYswlBBcOGF5/iDy325EAPIS3gGknGRmom8ofq0+2nRL4Y0ugmZ9K36XcB72bkbG7S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300145
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68127ff7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=oEByBfoX5-KuNZ1sLPUA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: DwKSF6aZkjH5_Bvx_3_ALKuiV9kRZWc6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NSBTYWx0ZWRfX/HtINtqq5Mmc 4CF8a0yi1uK6wjXw+U17WSsSQtMJ1y6XXfYtkfeD3lvG+z+kknV9TwacPkRL7xZXmBSb14gJHmt 5IBAIo/DEWBSkJEuoiAL/G+6vtOO32erHM8GuCjJkFltueKFGpgqBzZaaSVqqB/yQv9Zj/kCbTO
 DljLb87f8UlE5LEseKaxPDikShlvURXokUSB2heSkFu2ee5jmwR+g6LsGnzkTLgbfwlmfDLS/dy hnnon6+SlSBUvPjjxfV69MfID8l3o065AUzOo4zXWZbLtdR7OAqr/YmorwJfI2IQ/BdWwUEHRjq cuqqq/2l/KpoU3iHWrE8cB9bJ2RsZc+lX4sbzv4bIlIKanM+HwTnxV20FXMPDZxBkfNn/gKkr5j
 zVG0TlpviE6y17kjJJXVT7pRmmiBlyLpYDRqEQTwf0erUBe0kIF7w08c3qeMa6DSmOqr+aNs
X-Proofpoint-GUID: DwKSF6aZkjH5_Bvx_3_ALKuiV9kRZWc6

During the mmap() of a file-backed mapping, we invoke the underlying
driver's f_op->mmap() callback in order to perform driver/file system
initialisation of the underlying VMA.

This has been a source of issues in the past, including a significant
security concern relating to unwinding of error state discovered by Jann
Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour") which performed the recent, significant, rework of
mmap() as a whole.

However, we have had a fly in the ointment remain - drivers have a great
deal of freedom in the .mmap() hook to manipulate VMA state (as well as
page table state).

This can be problematic, as we can no longer reason sensibly about VMA
state once the call is complete (the ability to do - anything - here does
rather interfere with that).

In addition, callers may choose to do odd or unusual things which might
interfere with subsequent steps in the mmap() process, and it may do so and
then raise an error, requiring very careful unwinding of state about which
we can make no assumptions.

Rather than providing such an open-ended interface, this series provides an
alternative, far more restrictive one - we expose a whitelist of fields
which can be adjusted by the driver, along with immutable state upon which
the driver can make such decisions:

struct vma_proto {
	/* Immutable state. */
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;

	/* Mutable fields. Populated with initial state. */
	pgoff_t pgoff;
	struct file *file;
	vm_flags_t flags;
	pgprot_t page_prot;

	/* Write-only fields. */
	const struct vm_operations_struct *vm_ops;
	void *private_data;
};

The mmap logic then updates the state used to either merge with a VMA or
establish a new VMA based upon this logic.

This is achieved via new f_op hook .vma_proto(), which is, importantly,
invoked very early on in the mmap() process.

If an error arises, we can very simply abort the operation with very little
unwinding of state required.

The existing logic contains another, related, peccadillo - since the
.mmap() callback might do anything, it may also cause a previously
unmergeable VMA to become mergeable with adjacent VMAs.

Right now the logic will retry a merge like this only if the driver changes
VMA flags, and changes them in such a way that a merge might succeed (that
is, the flags are not 'special', that is do not contain any of the flags
specified in VM_SPECIAL).

This has been the source of a great deal of pain for a while - it is hard
to reason about an .mmap() callback that might do - anything - but it's
also hard to reason about setting up a VMA and writing to the maple tree,
only to do it again utilising a great deal of shared state.

Since .mmap_proto() sets fields before the first merge is even attempted,
the use of this callback obviates the need for this retry merge logic.

A driver can specify either .mmap_proto(), .mmap() or both. This provides
maximum flexibility.

In researching this change, I examined every .mmap() callback, and
discovered only a very few that set VMA state in such a way that a. the VMA
flags changed and b. this would be mergeable.

In the majority of cases, it turns out that drivers are mapping kernel
memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
VM_SPECIAL flags.

Of those that remain I identified a number of cases which are only
applicable in DAX, setting the VM_HUGEPAGE flag:

* dax_mmap()
* erofs_file_mmap()
* ext4_file_mmap()
* xfs_file_mmap()

For this remerge to not occur and to impact users, each of these cases
would require a user to mmap() files using DAX, in parts, immediately
adjacent to one another.

This is a very unlikely usecase and so it does not appear to be worthwhile
to adjust this functionality accordingly.

We can, however, very quickly do so if needed by simply adding an
.mmap_proto() hook to these as required.

There are two further non-DAX cases I idenitfied:

* orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
  VM_SEQ_READ.
* usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.

Both of these cases again seem very unlikely to be mmap()'d immediately
adjacent to one another in a fashion that would result in a merge.

Finally, we are left with a viable case:

* secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.

This is viable enough that the mm selftests trigger the logic as a matter
of course. Therefore, this series replace the .secretmem_mmap() hook with
.secret_mmap_proto().

Lorenzo Stoakes (3):
  mm: introduce new .mmap_proto() f_op callback
  mm: secretmem: convert to .mmap_proto() hook
  mm/vma: remove mmap() retry merge

 include/linux/fs.h               |  7 +++
 include/linux/mm_types.h         | 24 ++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/secretmem.c                   | 14 ++---
 mm/vma.c                         | 99 +++++++++++++++++++++++++++-----
 tools/testing/vma/vma_internal.h | 38 ++++++++++++
 7 files changed, 164 insertions(+), 23 deletions(-)

-- 
2.49.0


