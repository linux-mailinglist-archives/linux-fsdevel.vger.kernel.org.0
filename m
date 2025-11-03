Return-Path: <linux-fsdevel+bounces-66765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B60C2BB73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3D18901CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F130C366;
	Mon,  3 Nov 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljUyvMHw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E3BHRhCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5030F957;
	Mon,  3 Nov 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173268; cv=fail; b=KWXz/tHfKyXnKKyuVZOhNNR5/Z1ayPxlUtuj8IGuLlBY8zXn4HC8MsQ1usDlsJWoLFGawAOtdNRPLIllWWYXYabyx9p5Cp+jaXuwHeQj/0gU0YGCelaX7zNGAoAH5UZBPKYSHPYUJ3Ji1nwoXMj9bOxzm/ye33pKtBZgyIcGp/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173268; c=relaxed/simple;
	bh=0bhCH6BKAJKHCHuIJEOTigcn6iNhUER+/FHq6yvAFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr/pHPMS8kCM7HZ/iaN2Rkri6RPbpubdMkINYScmdwFVSYYN1kLFB9FUVde6o/SSxchiXznL72YlKnXThFn8sv+BcgX83ec45uf2eOP+SImQBzs6p9NfPJ0NzSjoBioePhQqrmxAixddFNIYtXcBxfxQ8FQeV++wGsrFggGrvXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljUyvMHw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E3BHRhCS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTePi019190;
	Mon, 3 Nov 2025 12:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IkriKesgB/vxrru3u50o8MIIikPKy++jEbdYcLdyS+g=; b=
	ljUyvMHwEm6hVcJsVLoM4JzqOLAqH74fynJZPy3G7d0Gq3tbVqFz0zC0V992V00R
	dU3i26wLXwcaNPetvomXjIhqQ4uO5+qvBWEMSTRqHWz/X3cF8t30FBXpT/Ar5Oz7
	iZjesPvXhOXBm+KEncTQKvqwFtNKOdNdjgqp0euRIqxSWRQOJiGwVj1TvRd4jB51
	mbmBmT+U5bFjLCNnlSNRL6fvJ/9To7LHDm9sWGKV5h8cD6yQ278ClH5GnPBXSORT
	KxKKXK83O+gipfQ0B9sljfXHGrzLtzAp8yzLCfVm1sO+p7m5i73OjCeIVVyDXsY0
	96vC31Hp9s27zIgzDgcuLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6ven8091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BWos8007980;
	Mon, 3 Nov 2025 12:32:41 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbkq71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxVRd+l1SDMPWK8E9sG7hcvISMzCbF0bO1E7mxMWz3e7jSNNDIuNBOgUN3jbR24Fl8zAqcIi+WVNUC/lIPbXYbH87wtJqcWiWfUn7u9dIVSt/pJOQrZ4CujxVFfLiSeJQioYN9RYOWGDPaedHO572spAyNwNPMp+9kjD/4c9iDozxP/hTpp9585Dm0ck51PJJqwXtyFlSODG1hzpsTxsBmC4FoJ//lOyRvi10CrR8kwlN5m8n+pNzxZwSpFa1ryCbjVbCLjKINWZ2ZoyzK8EZi6EatXqYjGv/e5tKUyowU0OxzAoeGVpiTDTXQTNNWx2nT+rcr49HCHoMePZDPs6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkriKesgB/vxrru3u50o8MIIikPKy++jEbdYcLdyS+g=;
 b=WaYber9LmjNNXqdijTLeFnSvmMx3GUwV6R634ii0gKhI0VBbKoGkGhUCQ4i/NIXvguUiIUerZW16PUQv72zdaDfsGkYAtttkRNlvYKU/4kO1zO5AavWx5SwDgMjf9H3EFwi0jrWrBCJ73nCGpJ+jf2FCJVY9Euseac3UYvg4Tm4Z4httysu25Ldhw3OUZN3lO5NAsEFynGHtW9DxWwYX6DEjiVWvfFeeAroVUFNyZbgVCpiO6Xv3wKw+iBAaClsi5qCXjJKl1qY4XWnb+0tZDt8/LNhtNPfXjnWfllHcYHdloY2/Mwgn4VzeN/0lISQgsWfaB7+cbjSpI7N21zGuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkriKesgB/vxrru3u50o8MIIikPKy++jEbdYcLdyS+g=;
 b=E3BHRhCSppzi6Ao81RPa/0LKeBXw0osrASTpgndzE9wLmSh276RkMB/DrWmaAJy1gvl8uOIHAHohPTZx3HGcFaVm9XNqDNuQvoJmuDX/IN6DXRy8IWObUxKraedt8wGF4k5c7a7mtyUVGFj3yqpXWKI9U7gNnLCEBH413cdP3ZU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH 10/16] mm: replace pmd_to_swp_entry() with leafent_from_pmd()
Date: Mon,  3 Nov 2025 12:31:51 +0000
Message-ID: <38c26e75ed00263e9ecbebb0c045dd6d8183ec67.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: d53f5c61-41a5-4473-f97e-08de1ad5126a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGd5ZO5jcEVH0RUsubA99AJs5BekJRXy4sRZUoq7UiBNtJI/6cgTC1KbwHws?=
 =?us-ascii?Q?fNsUKO4J0sDMtlSzY0wpjEc+aUgvRa8VFcGcoWcqxztM8kN3dsRe3Kg5WDLg?=
 =?us-ascii?Q?PrltEN9VLDjlauoNS/pRC8+8v83e1PQJxOcgurVG2V4/W3zQfC3SoDqhmgI0?=
 =?us-ascii?Q?HFXxAkxkvHEPrUmil9zyGb+FLsKiO64n5gAIB2759LIQNl/FCqZRTJitjkyS?=
 =?us-ascii?Q?6AfEYUFSW4GveHXHkrlfDXdgh/y6nUWOuQMhFLEuBmyeQpAALBuvqbVlQ5dC?=
 =?us-ascii?Q?Lpjlp2vdVtVdmxslsX7NYwzx4r8dbstL6GtF8HYU6GCuQOll0VogoeVEh0o9?=
 =?us-ascii?Q?B7EW/HmLuT4JVivG9HJoz9MDi+FcAckZrqm94m1R0MjEe4MWBm9SiGPKPozA?=
 =?us-ascii?Q?Anld5LWnLEiYPhV8N04/hcj5AEZM5l0zrLGvrTGBAeMfnJjSp64dPtHDvPAx?=
 =?us-ascii?Q?CCqbj5vtXGVHVhbPhAAyn+k7Tn67g7GQ2ckiFhQ/Lkvj3e26bK1QaNTT5gSV?=
 =?us-ascii?Q?9uVOdXeOK8B8nz+umRkfU+z7uww3Q6CpZ/Qio7ldyUWd43plncT98HpO32SN?=
 =?us-ascii?Q?5/j1gC86/rxnXbRFnegzwqOk5od4Dh1f7Q5GQiQTaJNIJP+JCmUxrD8bpmiE?=
 =?us-ascii?Q?wrK5q3gFYcbUft6XlMgX/yDBxSmYxryO4ssLKp+mlFSTS+DIuXzi8n8XIN86?=
 =?us-ascii?Q?Gk+0zv8w22D+f/0LIMlhStN38dgz32tBADofI/S+CDFsveoDxzmobAt5iDFZ?=
 =?us-ascii?Q?JxHQeOBmKURugjBqZQp7rsq4V3KRj6vNK1/D7VrI1WlSYGeG+IDXj0ZFQ3+A?=
 =?us-ascii?Q?NeRyBL+KctOrhbFEhihTqWpAzyAExJ2m4mOqeBYg6daeRj+QNOBh1lMKWW8S?=
 =?us-ascii?Q?zebX3FDFEi00ciWEsrKyso8wLACwuK8xmut3XGStDTKmfeimu7YxNMb6qObY?=
 =?us-ascii?Q?rLJe52CpNQEKgeTCL1r2Nd5baYVpcuiX9p9XxnlNUolFAJyxhX7IMwIfZiub?=
 =?us-ascii?Q?etAmw8WIiSuo9NTnwvAhiC/GR0Lb2gIR51O8ZZECPv+eVHn5W70YsUCtteG6?=
 =?us-ascii?Q?/6gdpl/xlCKwjBxPnlU2JC4K1D2HSCEfrezhRRVz/Dc1/RdtvurLMispMt0d?=
 =?us-ascii?Q?5BcdIDU8YnX/TR6J2EvfF2fcCRI4GFa4GqNAkxfzvcfA4wDtFs871phWIFIu?=
 =?us-ascii?Q?SAOn7JUf9+47352zYfJsuy3dB9k73WHIY7PdGWWOanfVEQGw0OJTuYEbfgqR?=
 =?us-ascii?Q?1zIp9cXlbuMAFOwIzfeZHHETe7LS1UmsTpMbjqbqVGqKc+aQBFcVdL8hmfZr?=
 =?us-ascii?Q?D/qG+qtRzg19TXC4fjCCLKh82bInVOIAYWcQtmwhvA55TtOv9B8cyJ318PKr?=
 =?us-ascii?Q?GpDrrwOzwB81ZnoQskOjk5XMUzdTqIGGTLmtRHqmX9AiCvWO1h6ih8nMf4BG?=
 =?us-ascii?Q?TUR2BXK710dPVMl/7oeXojFRLJN3YgNW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uaiCnG6HuD96xxV6j9vwfa2rLsNjdIm4T9nbQYGGN8pc2yOgDTGUBnwXZ8A?=
 =?us-ascii?Q?giCo2jzmEVjMhf61kwg9UV1st5HNqimfkCPm+ngMpzJv9jbYcoKTjXDJfGmh?=
 =?us-ascii?Q?cLBcOpYSI0TNh97lAXlcer+dF3wkZLKcwANfp/EkXPvwYFnOpqr231pj28Cp?=
 =?us-ascii?Q?kkgEy/Wr2O40Om5ov2C54ZW6V5JZav4G8+GeJycLtPxPI3hIQz9o/5Mbuakh?=
 =?us-ascii?Q?w2caRMy9uty0tVQ7dn6M2ZquO2zUMN9MWaGQHwhTuIoGchujI4Xqbu8UpGpl?=
 =?us-ascii?Q?c55BW9AQdRaLZAoqwShWtf2emnJM2UEuTr8tyOF2n0SEO9AsPRXFPUBTpQSf?=
 =?us-ascii?Q?axK75JBh56sEhK+Ujc64n86/17B5SajXk38Y8L/HQq18aofgVeuhx2fXJ0Ky?=
 =?us-ascii?Q?a25jCbrhWI/z6iLFezJsGAG5U/Q/du3b5A09sWlVbwi0opl5+qPsim3nCTgo?=
 =?us-ascii?Q?1yDSIhugnHY6mV6FbXX/FmF1ilg0o8fXU16ktWQvYVSpZ3LMJxhahKBpmLPe?=
 =?us-ascii?Q?1jDczfCr6MZvkimIr7DmsjbVrBCG1R9lecwH5MBKxI7sQ0CiihbEKTCZe8T1?=
 =?us-ascii?Q?1vgU+D45i2I5firoRnRL0bYwrQvZvVGnF/xPZSDMtDyncdUR0G2u8lQ8URqI?=
 =?us-ascii?Q?GtissYy9EPO3KxTEsGoysgk26Nbbm6pDngmnYnt/K3wMWW/Yz0qBu6akh2FM?=
 =?us-ascii?Q?x9aVYDD0lTEannZaIbHLNqd31oUovKSag1jDiCNtpfBaCTT5CJTcl1AdZ1Nl?=
 =?us-ascii?Q?O5ujAheAeLHtIsLfps/20qMKpXaIIgYtGps7Xzh6+ilwhsb1hLwyOHeTjM8D?=
 =?us-ascii?Q?FDYD+DcgYD0rvTc5Pl1LloeD9kuGFVRPClgAZA19H/mQZVYVwtGFQnAhfPx2?=
 =?us-ascii?Q?GtKncSYMkjFxSrb4pqIw/D96Vi74xQ4TC+iZJhkhZGE+mlnP7E72xOcNOAiI?=
 =?us-ascii?Q?ZEVyvrzAWC5ff/nEITxvmVQg+ib0/GHzD33eulc5UmEw/OM6NBQOzVXFa9iq?=
 =?us-ascii?Q?TOZSHWsTwy0WN1lYS64BC1GGxWjSs4zDXZbbC9Xd4W60uchUyGkBLAuiKR2w?=
 =?us-ascii?Q?RfEcSB9/rlFg/7thIhQUt13geBYzQcC+zlVIljTqcWEU63Qkr/9cfeM70/6d?=
 =?us-ascii?Q?VB6De2c/50UcC8sw2aTKK+9DY/dL00EcQvaIHocdgbrZOEjrhdtXXtZ5P87Z?=
 =?us-ascii?Q?BeAOZFslR82SWqy5WEibfWzbc2lWi/QFdGiEQKnJmluCQxJsbldMT7AahFCL?=
 =?us-ascii?Q?HKAhW/ZfboHb0bWxt7rBk539Q5zwwGat/AKsWZvLG8BE8ndjLHe4VYZbtAjE?=
 =?us-ascii?Q?reGMtEsMg3rfU8PQuRXBOsTN2BhEMlrxyfDh61JFM2j1ymXn9GQIzUgBvjRd?=
 =?us-ascii?Q?KfGF9een65tBzuqwbjQPYB9ri/3sseJrkVlSRv/3lrBFRE4ds4p+BqNR1Sh7?=
 =?us-ascii?Q?zZP3McQ2paeAoJ7TYc9E4iuttYjgOX92aSvMzgTZF12QfrL/O17nv1MVCrlc?=
 =?us-ascii?Q?XReIFbBRsjYw3MundSLEjgHbaJG2esHBqICsM6MA7Zpr1Cmooo6aqzl72GJn?=
 =?us-ascii?Q?1LOqEaLYR1pin9jb68adcZ2sekSTaB8PjNmmN1RY5k+1Y+kuCT9XE2Je5za8?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tccvKpUClZ4LroST6HnWEsCBMU/C7wfXQtApRXYLQyhKKjiWL+4BYBrOxqD62Th0yFWaR14FLaoWCsXaOoXox9yM007CWBLwr/Vu+1gEfgxNug/c5Ho5/FRIaH3r8ISOJRw0Nn8nFm1sTxSyDO9G597iT/g1ZrlHqsxgRZXR58mrU//nOoyTjq+ZhiIaVdvvMbrAJSNB3e9oDVGDgD9y/FrbY5P37dJfKqRm8SV8UdlBNruwZYay0KlxoUNp0PCrJKwJUYMgRcja0rxm/DgKKoBmo3T+LZu63T7cCBEpXAAoogeyLNw/7Dp6eYY0LNdq0gjw9WxoTFoQ0BJHypsPqgh0HVLpNjSoEx9TE8QZl8iEBGKZL2Il02wYr3AKvKOlZweOu4Bht2SJMni79Yd9FrEqigQIzTmKhq52YSGuXCbcS3xtHKi79KWTioIAB/Ao5aaUJZTdQWoxudBgxM2m2DHVs1op5y0FFxk1spJCrGn0uf0PNl0Af9eAds7B0JmNY3Ny+fmJotE7/boOBIR1Bqw8jLHQ5VwSx3k5+puDcqpwA2ZRro2rdRefjZwHYn0JB0KCieuHCTNJ2u0OfkQqz/zKbhQioxjer2lapf2Bc68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f5c61-41a5-4473-f97e-08de1ad5126a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:37.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOGYuVIFmUMD9veVjjBSRDF5Z5EVDF/cB2JJJcj4DjJDtq7Halbe4Z8texqC8SvWI+sB/i4B6/7QQQtTxRiCBcg2MICfH8p1XmeVcOfHJQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030113
X-Proofpoint-GUID: a6bGNVlpbZQ_wwmP3ZoV83MQuvU3xvf5
X-Proofpoint-ORIG-GUID: a6bGNVlpbZQ_wwmP3ZoV83MQuvU3xvf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfXxGRNX/EUwMOW
 8oN47L6kSXuuZKusT3Y7HcOybqwAfL+1e+nSpbdFoEvVALE5vqzv9eyN3DDjeKTUO32Fi6QOZez
 gRUnhbsXyDZZooz3ZDhEtcPT9fW7T9WmIQcCnKkazyzTpryEnl/HSS03RYiKq67irurW0rNck/4
 0+d0RJdnhg/MDk8L10MS2lKG9DuiLms3cIbnlupeS1MN3LIAGz/KqFAOeNIh/VvDB3MA/gogRgj
 TcLNshudSlHS2rhOLBCGmyYY6Yto1oZeu5qKlxVfgwr7P7CoQsm8uEBVnX1unVQXHPWk2uXrSYo
 OEzCVLofO+NMeqD58D93ncZ85KzEJ5F7+2YcT29J5s6brlvU+9zIQH2kkZXwF6ZLDw22nS/mGWy
 YbrRt9OzSMZWWxlAYd0cYFEU9nECzRSvOa+ZFibBF/zfbmmMfm4=
X-Authority-Analysis: v=2.4 cv=MvBfKmae c=1 sm=1 tr=0 ts=6908a0eb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1B2o6Llj8-7n3TOjnuQA:9 cc=ntf awl=host:12123

Introduce leafent_from_pmd() to do the equivalent operation for PMDs that
leafent_from_pte() fulfils, and cascade changes through code base
accordingly, introducing helpers as necessary.

We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().

This further establishes the use of leaf operations throughout the code
base and further establishes the foundations for eliminating is_swap_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  27 +++---
 include/linux/leafops.h | 210 ++++++++++++++++++++++++++++++++++++++++
 include/linux/migrate.h |   3 +-
 include/linux/swapops.h | 100 -------------------
 mm/damon/ops-common.c   |   6 +-
 mm/filemap.c            |   6 +-
 mm/hmm.c                |  16 +--
 mm/huge_memory.c        |  98 +++++++++----------
 mm/khugepaged.c         |   4 +-
 mm/madvise.c            |   2 +-
 mm/memory.c             |   4 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |  20 ++--
 mm/migrate_device.c     |  14 +--
 mm/page_table_check.c   |  16 +--
 mm/page_vma_mapped.c    |  15 +--
 mm/pagewalk.c           |   8 +-
 mm/rmap.c               |   4 +-
 18 files changed, 334 insertions(+), 223 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0f02bda5d544..0ccdc21e60e0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1065,10 +1065,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
+		const leaf_entry_t entry = leafent_from_pmd(*pmd);
 
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (leafent_has_pfn(entry))
+			page = leafent_to_page(entry);
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
@@ -1654,7 +1654,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		pmd = pmd_clear_soft_dirty(pmd);
 
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_clear_soft_dirty(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
@@ -2015,12 +2015,12 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
 	} else if (thp_migration_supported()) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const leaf_entry_t entry = leafent_from_pmd(pmd);
 		unsigned long offset;
 
 		if (pm->show_pfn) {
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry) + idx;
+			if (leafent_has_pfn(entry))
+				offset = leafent_to_pfn(entry) + idx;
 			else
 				offset = swp_offset(entry) + idx;
 			frame = swp_type(entry) |
@@ -2031,7 +2031,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = pfn_swap_entry_to_page(entry);
 	}
 
@@ -2425,8 +2425,6 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else {
-		swp_entry_t swp;
-
 		categories |= PAGE_IS_SWAPPED;
 		if (!pmd_swp_uffd_wp(pmd))
 			categories |= PAGE_IS_WRITTEN;
@@ -2434,9 +2432,10 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_SOFT_DIRTY;
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
-			swp = pmd_to_swp_entry(pmd);
-			if (is_pfn_swap_entry(swp) &&
-			    !folio_test_anon(pfn_swap_entry_folio(swp)))
+			const leaf_entry_t entry = leafent_from_pmd(pmd);
+
+			if (leafent_has_pfn(entry) &&
+			    !folio_test_anon(leafent_to_folio(entry)))
 				categories |= PAGE_IS_FILE;
 		}
 	}
@@ -2453,7 +2452,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		old = pmdp_invalidate_ad(vma, addr, pmdp);
 		pmd = pmd_mkuffd_wp(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index a1a25ca152ff..2d3bc4c866bd 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -73,6 +73,47 @@ static inline leaf_entry_t leafent_from_pte(pte_t pte)
 	return pte_to_swp_entry(pte);
 }
 
+/**
+ * leafent_to_pte() - Obtain a PTE entry from a leaf entry.
+ * @entry: Leaf entry.
+ *
+ * This generates an architecture-specific PTE entry that can be utilised to
+ * encode the metadata the leaf entry encodes.
+ *
+ * Returns: Architecture-specific PTE entry encoding leaf entry.
+ */
+static inline pte_t leafent_to_pte(leaf_entry_t entry)
+{
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry_to_pte(entry);
+}
+
+/**
+ * leafent_from_pmd() - Obtain a leaf entry from a PMD entry.
+ * @pmd: PMD entry.
+ *
+ * If @pmd is present (therefore not a leaf entry) the function returns an empty
+ * leaf entry. Otherwise, it returns a leaf entry.
+ *
+ * Returns: Leaf entry.
+ */
+static inline leaf_entry_t leafent_from_pmd(pmd_t pmd)
+{
+	leaf_entry_t arch_entry;
+
+	if (pmd_present(pmd))
+		return leafent_mk_none();
+
+	if (pmd_swp_soft_dirty(pmd))
+		pmd = pmd_swp_clear_soft_dirty(pmd);
+	if (pmd_swp_uffd_wp(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	arch_entry = __pmd_to_swp_entry(pmd);
+
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
+}
+
 /**
  * leafent_is_none() - Is the leaf entry empty?
  * @entry: Leaf entry.
@@ -146,6 +187,43 @@ static inline bool leafent_is_swap(leaf_entry_t entry)
 	return leafent_type(entry) == LEAFENT_SWAP;
 }
 
+/**
+ * leafent_is_migration_write() - Is this leaf entry a writable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a writable migration entry, otherwise
+ * false.
+ */
+static inline bool leafent_is_migration_write(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_MIGRATION_WRITE;
+}
+
+/**
+ * leafent_is_migration_read() - Is this leaf entry a readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a readable migration entry, otherwise
+ * false.
+ */
+static inline bool leafent_is_migration_read(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_MIGRATION_READ;
+}
+
+/**
+ * leafent_is_migration_read_exclusive() - Is this leaf entry an exclusive
+ * readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is an exclusive readable migration entry,
+ * otherwise false.
+ */
+static inline bool leafent_is_migration_read_exclusive(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_MIGRATION_READ_EXCLUSIVE;
+}
+
 /**
  * leafent_is_swap() - Is this leaf entry a migration entry?
  * @entry: Leaf entry.
@@ -164,6 +242,19 @@ static inline bool leafent_is_migration(leaf_entry_t entry)
 	}
 }
 
+/**
+ * leafent_is_device_private_write() - Is this leaf entry a device private
+ * writable entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device private writable entry, otherwise
+ * false.
+ */
+static inline bool leafent_is_device_private_write(leaf_entry_t entry)
+{
+	return leafent_type(entry) == LEAFENT_DEVICE_PRIVATE_WRITE;
+}
+
 /**
  * leafent_is_device_private() - Is this leaf entry a device private entry?
  * @entry: Leaf entry.
@@ -181,6 +272,12 @@ static inline bool leafent_is_device_private(leaf_entry_t entry)
 	}
 }
 
+/**
+ * leafent_is_device_exclusive() - Is this leaf entry a device-exclusive entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device-exclusive entry, otherwise false.
+ */
 static inline bool leafent_is_device_exclusive(leaf_entry_t entry)
 {
 	return leafent_type(entry) == LEAFENT_DEVICE_EXCLUSIVE;
@@ -339,6 +436,61 @@ static inline bool leafent_is_uffd_wp_marker(leaf_entry_t entry)
 	return leafent_to_marker(entry) & PTE_MARKER_UFFD_WP;
 }
 
+#ifdef CONFIG_MIGRATION
+
+/**
+ * leafent_is_migration_young() - Does this migration entry contain an accessed
+ * bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the accessed (or 'young') bit was set on the migrated page
+ * table entry.
+ *
+ * Returns: true if the entry contains an accessed bit, otherwise false.
+ */
+static inline bool leafent_is_migration_young(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_YOUNG;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
+/**
+ * leafent_is_migration_dirty() - Does this migration entry contain a dirty bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the dirty bit was set on the migrated page table entry.
+ *
+ * Returns: true if the entry contains a dirty bit, otherwise false.
+ */
+static inline bool leafent_is_migration_dirty(leaf_entry_t entry)
+{
+	VM_WARN_ON_ONCE(!leafent_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_DIRTY;
+	/* Keep the old behavior of clean page after migration */
+	return false;
+}
+
+#else /* CONFIG_MIGRATION */
+
+static inline bool leafent_is_migration_young(leaf_entry_t entry)
+{
+	return false;
+}
+
+static inline bool leafent_is_migration_dirty(leaf_entry_t entry)
+{
+	return false;
+}
+#endif /* CONFIG_MIGRATION */
+
 /**
  * pte_is_marker() - Does the PTE entry encode a marker leaf entry?
  * @pte: PTE entry.
@@ -390,5 +542,63 @@ static inline bool pte_is_uffd_marker(pte_t pte)
 	return false;
 }
 
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+
+/**
+ * pmd_is_device_private_entry() - Check if PMD contains a device private swap
+ * entry.
+ * @pmd: The PMD to check.
+ *
+ * Returns true if the PMD contains a swap entry that represents a device private
+ * page mapping. This is used for zone device private pages that have been
+ * swapped out but still need special handling during various memory management
+ * operations.
+ *
+ * Return: true if PMD contains device private entry, false otherwise
+ */
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return leafent_is_device_private(leafent_from_pmd(pmd));
+}
+
+#else  /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return false;
+}
+
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+/**
+ * pmd_is_migration_entry() - Does this PMD entry encode a migration entry?
+ * @pmd: PMD entry.
+ *
+ * Returns: true if the PMD encodes a migration entry, otherwise false.
+ */
+static inline bool pmd_is_migration_entry(pmd_t pmd)
+{
+	return leafent_is_migration(leafent_from_pmd(pmd));
+}
+
+/**
+ * pmd_is_valid_leafent() - Is this PMD entry a valid leaf entry?
+ * @pmd: PMD entry.
+ *
+ * PMD leaf entries are valid only if they are device private or migration
+ * entries. This function asserts that a PMD leaf entry is valid in this
+ * respect.
+ *
+ * Returns: true if the PMD entry is a valid leaf entry, otherwise false.
+ */
+static inline bool pmd_is_valid_leafent(pmd_t pmd)
+{
+	const leaf_entry_t entry = leafent_from_pmd(pmd);
+
+	/* Only device private, migration entries valid for PMD. */
+	return leafent_is_device_private(entry) ||
+		leafent_is_migration(entry);
+}
+
 #endif  /* CONFIG_MMU */
 #endif  /* _LINUX_SWAPOPS_H */
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 41b4cc05a450..010b70c4dc3e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -6,6 +6,7 @@
 #include <linux/mempolicy.h>
 #include <linux/migrate_mode.h>
 #include <linux/hugetlb.h>
+#include <linux/leafops.h>
 
 typedef struct folio *new_folio_t(struct folio *folio, unsigned long private);
 typedef void free_folio_t(struct folio *folio, unsigned long private);
@@ -65,7 +66,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(leaf_entry_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3e8dd6ea94dd..f1277647262d 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -283,14 +283,6 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_YOUNG;
-	/* Keep the old behavior of aging page after migration */
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	if (migration_entry_supports_ad())
@@ -299,14 +291,6 @@ static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_DIRTY;
-	/* Keep the old behavior of clean page after migration */
-	return false;
-}
-
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *pte);
@@ -349,20 +333,11 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	return false;
-}
 #endif	/* CONFIG_MIGRATION */
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -487,18 +462,6 @@ extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	swp_entry_t arch_entry;
-
-	if (pmd_swp_soft_dirty(pmd))
-		pmd = pmd_swp_clear_soft_dirty(pmd);
-	if (pmd_swp_uffd_wp(pmd))
-		pmd = pmd_swp_clear_uffd_wp(pmd);
-	arch_entry = __pmd_to_swp_entry(pmd);
-	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	swp_entry_t arch_entry;
@@ -507,23 +470,7 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 	return __swp_entry_to_pmd(arch_entry);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_migration_entry(entry);
-}
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
-		struct page *page)
-{
-	BUILD_BUG();
-}
-
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 		struct page *new)
 {
@@ -532,64 +479,17 @@ static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 static inline void pmd_migration_entry_wait(struct mm_struct *m, pmd_t *p) { }
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	return swp_entry(0, 0);
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	return __pmd(0);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	return 0;
-}
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
-
-/**
- * is_pmd_device_private_entry() - Check if PMD contains a device private swap entry
- * @pmd: The PMD to check
- *
- * Returns true if the PMD contains a swap entry that represents a device private
- * page mapping. This is used for zone device private pages that have been
- * swapped out but still need special handling during various memory management
- * operations.
- *
- * Return: 1 if PMD contains device private entry, 0 otherwise
- */
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_device_private_entry(entry);
-}
-
-#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	return 0;
-}
-
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
 
-static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
-{
-	return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 971df8a16ba4..371fcc4d1b65 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -11,7 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -51,7 +51,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pte_present(pteval)))
 		pfn = pte_pfn(pteval);
 	else
-		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+		pfn = leafent_to_pfn(leafent_from_pte(pteval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
@@ -83,7 +83,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pmd_present(pmdval)))
 		pfn = pmd_pfn(pmdval);
 	else
-		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+		pfn = leafent_to_pfn(leafent_from_pmd(pmdval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
diff --git a/mm/filemap.c b/mm/filemap.c
index ff75bd89b68c..eb1f994291d8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -21,7 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -1402,7 +1402,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * This follows the same logic as folio_wait_bit_common() so see the comments
  * there.
  */
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(leaf_entry_t entry, spinlock_t *ptl)
 	__releases(ptl)
 {
 	struct wait_page_queue wait_page;
@@ -1411,7 +1411,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 	unsigned long pflags;
 	bool in_thrashing;
 	wait_queue_head_t *q;
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	struct folio *folio = leafent_to_folio(entry);
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index b11b4ebba945..cbcabc48974f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
 #include <linux/sched/mm.h>
@@ -334,19 +334,19 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	const leaf_entry_t entry = leafent_from_pmd(pmd);
 	unsigned long addr = start;
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
 	unsigned int required_fault;
 
-	if (is_device_private_entry(entry) &&
-	    pfn_swap_entry_folio(entry)->pgmap->owner ==
+	if (leafent_is_device_private(entry) &&
+	    leafent_to_folio(entry)->pgmap->owner ==
 	    range->dev_private_owner) {
 		unsigned long cpu_flags = HMM_PFN_VALID |
 			hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
-		unsigned long pfn = swp_offset_pfn(entry);
+		unsigned long pfn = leafent_to_pfn(entry);
 		unsigned long i;
 
-		if (is_writable_device_private_entry(entry))
+		if (leafent_is_device_private_write(entry))
 			cpu_flags |= HMM_PFN_WRITE;
 
 		/*
@@ -365,7 +365,7 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
 					      npages, 0);
 	if (required_fault) {
-		if (is_device_private_entry(entry))
+		if (leafent_is_device_private(entry))
 			return hmm_vma_fault(addr, end, required_fault, walk);
 		else
 			return -EFAULT;
@@ -407,7 +407,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
-	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
+	if (thp_migration_supported() && pmd_is_migration_entry(pmd)) {
 		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(walk->mm, pmdp);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40a8a2c1e080..4f8d4cd106e8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1374,7 +1374,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 	spinlock_t *ptl;
-	swp_entry_t swp_entry;
+	leaf_entry_t entry;
 	struct page *page;
 	struct folio *folio;
 
@@ -1389,8 +1389,8 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 		return 0;
 	}
 
-	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
-	page = pfn_swap_entry_to_page(swp_entry);
+	entry = leafent_from_pmd(vmf->orig_pmd);
+	page = leafent_to_page(entry);
 	folio = page_folio(page);
 	vmf->page = page;
 	vmf->pte = NULL;
@@ -1780,13 +1780,13 @@ static void copy_huge_non_present_pmd(
 		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pmd_t pmd, pgtable_t pgtable)
 {
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	leaf_entry_t entry = leafent_from_pmd(pmd);
 	struct folio *src_folio;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_leafent(pmd));
 
-	if (is_writable_migration_entry(entry) ||
-	    is_readable_exclusive_migration_entry(entry)) {
+	if (leafent_is_migration_write(entry) ||
+	    leafent_is_migration_read_exclusive(entry)) {
 		entry = make_readable_migration_entry(swp_offset(entry));
 		pmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*src_pmd))
@@ -1794,12 +1794,12 @@ static void copy_huge_non_present_pmd(
 		if (pmd_swp_uffd_wp(*src_pmd))
 			pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(src_mm, addr, src_pmd, pmd);
-	} else if (is_device_private_entry(entry)) {
+	} else if (leafent_is_device_private(entry)) {
 		/*
 		 * For device private entries, since there are no
 		 * read exclusive entries, writable = !readable
 		 */
-		if (is_writable_device_private_entry(entry)) {
+		if (leafent_is_device_private_write(entry)) {
 			entry = make_readable_device_private_entry(swp_offset(entry));
 			pmd = swp_entry_to_pmd(entry);
 
@@ -1810,7 +1810,7 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = pfn_swap_entry_folio(entry);
+		src_folio = leafent_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -2270,7 +2270,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	if (unlikely(!pmd_present(orig_pmd))) {
 		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
+				  !pmd_is_migration_entry(orig_pmd));
 		goto out;
 	}
 
@@ -2368,11 +2368,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			folio_remove_rmap_pmd(folio, page, vma);
 			WARN_ON_ONCE(folio_mapcount(folio) < 0);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
-		} else if (is_pmd_non_present_folio_entry(orig_pmd)) {
-			swp_entry_t entry;
+		} else if (pmd_is_valid_leafent(orig_pmd)) {
+			const leaf_entry_t entry = leafent_from_pmd(orig_pmd);
 
-			entry = pmd_to_swp_entry(orig_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = leafent_to_folio(entry);
 			flush_needed = 0;
 
 			if (!thp_migration_supported())
@@ -2428,7 +2427,7 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
 static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 {
 #ifdef CONFIG_MEM_SOFT_DIRTY
-	if (unlikely(is_pmd_migration_entry(pmd)))
+	if (unlikely(pmd_is_migration_entry(pmd)))
 		pmd = pmd_swp_mksoft_dirty(pmd);
 	else if (pmd_present(pmd))
 		pmd = pmd_mksoft_dirty(pmd);
@@ -2503,12 +2502,12 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		unsigned long addr, pmd_t *pmd, bool uffd_wp,
 		bool uffd_wp_resolve)
 {
-	swp_entry_t entry = pmd_to_swp_entry(*pmd);
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	leaf_entry_t entry = leafent_from_pmd(*pmd);
+	const struct folio *folio = leafent_to_folio(entry);
 	pmd_t newpmd;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-	if (is_writable_migration_entry(entry)) {
+	VM_WARN_ON(!pmd_is_valid_leafent(*pmd));
+	if (leafent_is_migration_write(entry)) {
 		/*
 		 * A protection check is difficult so
 		 * just be safe and disable write
@@ -2520,7 +2519,7 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		newpmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*pmd))
 			newpmd = pmd_swp_mksoft_dirty(newpmd);
-	} else if (is_writable_device_private_entry(entry)) {
+	} else if (leafent_is_device_private_write(entry)) {
 		entry = make_readable_device_private_entry(swp_offset(entry));
 		newpmd = swp_entry_to_pmd(entry);
 	} else {
@@ -2718,7 +2717,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 
 	if (!pmd_trans_huge(src_pmdval)) {
 		spin_unlock(src_ptl);
-		if (is_pmd_migration_entry(src_pmdval)) {
+		if (pmd_is_migration_entry(src_pmdval)) {
 			pmd_migration_entry_wait(mm, &src_pmdval);
 			return -EAGAIN;
 		}
@@ -2983,13 +2982,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	unsigned long addr;
 	pte_t *pte;
 	int i;
-	swp_entry_t entry;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd) && !pmd_trans_huge(*pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_leafent(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3003,11 +3001,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			zap_deposited_table(mm, pmd);
 		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
-		if (unlikely(is_pmd_migration_entry(old_pmd))) {
-			swp_entry_t entry;
+		if (unlikely(pmd_is_migration_entry(old_pmd))) {
+			const leaf_entry_t old_entry = leafent_from_pmd(old_pmd);
 
-			entry = pmd_to_swp_entry(old_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = leafent_to_folio(old_entry);
 		} else if (is_huge_zero_pmd(old_pmd)) {
 			return;
 		} else {
@@ -3037,31 +3034,34 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
+	if (pmd_is_migration_entry(*pmd)) {
+		leaf_entry_t entry;
 
-	if (is_pmd_migration_entry(*pmd)) {
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = leafent_from_pmd(old_pmd);
+		page = leafent_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_migration_entry(entry);
+		write = leafent_is_migration_write(entry);
 		if (PageAnon(page))
-			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = is_migration_entry_young(entry);
-		dirty = is_migration_entry_dirty(entry);
-	} else if (is_pmd_device_private_entry(*pmd)) {
+			anon_exclusive = leafent_is_migration_read_exclusive(entry);
+		young = leafent_is_migration_young(entry);
+		dirty = leafent_is_migration_dirty(entry);
+	} else if (pmd_is_device_private_entry(*pmd)) {
+		leaf_entry_t entry;
+
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = leafent_from_pmd(old_pmd);
+		page = leafent_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_device_private_entry(entry);
+		write = leafent_is_device_private_write(entry);
 		anon_exclusive = PageAnonExclusive(page);
 
 		/*
@@ -3165,7 +3165,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Note that NUMA hinting access restrictions are not transferred to
 	 * avoid any possibility of altering permissions across VMAs.
 	 */
-	if (freeze || is_pmd_migration_entry(old_pmd)) {
+	if (freeze || pmd_is_migration_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3191,7 +3191,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
 			set_pte_at(mm, addr, pte + i, entry);
 		}
-	} else if (is_pmd_device_private_entry(old_pmd)) {
+	} else if (pmd_is_device_private_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3241,7 +3241,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	pte_unmap(pte);
 
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		folio_remove_rmap_pmd(folio, page, vma);
 	if (freeze)
 		put_page(page);
@@ -3254,7 +3254,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
-	if (pmd_trans_huge(*pmd) || is_pmd_non_present_folio_entry(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_is_valid_leafent(*pmd))
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
@@ -4855,12 +4855,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	unsigned long address = pvmw->address;
 	unsigned long haddr = address & HPAGE_PMD_MASK;
 	pmd_t pmde;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
-	entry = pmd_to_swp_entry(*pvmw->pmd);
+	entry = leafent_from_pmd(*pvmw->pmd);
 	folio_get(folio);
 	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 
@@ -4876,20 +4876,20 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (is_writable_migration_entry(entry))
+	if (leafent_is_migration_write(entry))
 		pmde = pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
-	if (!is_migration_entry_young(entry))
+	if (!leafent_is_migration_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+	if (folio_test_dirty(folio) && leafent_is_migration_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_NONE;
 
-		if (!is_readable_migration_entry(entry))
+		if (!leafent_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a97ff7bcb232..1a08673b0d8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -17,7 +17,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate_wait.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
@@ -941,7 +941,7 @@ static inline int check_pmd_state(pmd_t *pmd)
 	 * collapse it. Migration success or failure will eventually end
 	 * up with a present PMD mapping a folio again.
 	 */
-	if (is_pmd_migration_entry(pmde))
+	if (pmd_is_migration_entry(pmde))
 		return SCAN_PMD_MAPPED;
 	if (!pmd_present(pmde))
 		return SCAN_PMD_NULL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 398721e9a1e5..900f0f29e77b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -390,7 +390,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					!is_pmd_migration_entry(orig_pmd));
+					!pmd_is_migration_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index a0ae4e23d487..ce2e3ce23f3b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6362,10 +6362,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto fallback;
 
 	if (unlikely(!pmd_present(vmf.orig_pmd))) {
-		if (is_pmd_device_private_entry(vmf.orig_pmd))
+		if (pmd_is_device_private_entry(vmf.orig_pmd))
 			return do_huge_pmd_device_private(&vmf);
 
-		if (is_pmd_migration_entry(vmf.orig_pmd))
+		if (pmd_is_migration_entry(vmf.orig_pmd))
 			pmd_migration_entry_wait(mm, vmf.pmd);
 		return 0;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7ae3f5e2dee6..01c3b98f87a6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -110,7 +110,7 @@
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
@@ -647,7 +647,7 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 
-	if (unlikely(is_pmd_migration_entry(*pmd))) {
+	if (unlikely(pmd_is_migration_entry(*pmd))) {
 		qp->nr_failed++;
 		return;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 862b2e261cf9..bb0429a5e5a4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -16,7 +16,7 @@
 #include <linux/migrate.h>
 #include <linux/export.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
@@ -353,7 +353,7 @@ static bool remove_migration_pte(struct folio *folio,
 		rmap_t rmap_flags = RMAP_NONE;
 		pte_t old_pte;
 		pte_t pte;
-		swp_entry_t entry;
+		leaf_entry_t entry;
 		struct page *new;
 		unsigned long idx = 0;
 
@@ -379,22 +379,22 @@ static bool remove_migration_pte(struct folio *folio,
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 
-		entry = pte_to_swp_entry(old_pte);
-		if (!is_migration_entry_young(entry))
+		entry = leafent_from_pte(old_pte);
+		if (!leafent_is_migration_young(entry))
 			pte = pte_mkold(pte);
-		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+		if (folio_test_dirty(folio) && leafent_is_migration_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (pte_swp_soft_dirty(old_pte))
 			pte = pte_mksoft_dirty(pte);
 		else
 			pte = pte_clear_soft_dirty(pte);
 
-		if (is_writable_migration_entry(entry))
+		if (leafent_is_migration_write(entry))
 			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(old_pte))
 			pte = pte_mkuffd_wp(pte);
 
-		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
+		if (folio_test_anon(folio) && !leafent_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		if (unlikely(is_device_private_page(new))) {
@@ -404,7 +404,7 @@ static bool remove_migration_pte(struct folio *folio,
 			else
 				entry = make_readable_device_private_entry(
 							page_to_pfn(new));
-			pte = swp_entry_to_pte(entry);
+			pte = leafent_to_pte(entry);
 			if (pte_swp_soft_dirty(old_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(old_pte))
@@ -543,9 +543,9 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), ptl);
+	migration_entry_wait_on_locked(leafent_from_pmd(*pmd), ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c869b272e85a..5cb5ac2f0290 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -13,7 +13,7 @@
 #include <linux/oom.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -145,7 +145,6 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 	struct folio *folio;
 	struct migrate_vma *migrate = walk->private;
 	spinlock_t *ptl;
-	swp_entry_t entry;
 	int ret;
 	unsigned long write = 0;
 
@@ -169,23 +168,24 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 		if (pmd_write(*pmdp))
 			write = MIGRATE_PFN_WRITE;
 	} else if (!pmd_present(*pmdp)) {
-		entry = pmd_to_swp_entry(*pmdp);
-		folio = pfn_swap_entry_folio(entry);
+		const leaf_entry_t entry = leafent_from_pmd(*pmdp);
 
-		if (!is_device_private_entry(entry) ||
+		folio = leafent_to_folio(entry);
+
+		if (!leafent_is_device_private(entry) ||
 			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
 			(folio->pgmap->owner != migrate->pgmap_owner)) {
 			spin_unlock(ptl);
 			return migrate_vma_collect_skip(start, end, walk);
 		}
 
-		if (is_migration_entry(entry)) {
+		if (leafent_is_migration(entry)) {
 			migration_entry_wait_on_locked(entry, ptl);
 			spin_unlock(ptl);
 			return -EAGAIN;
 		}
 
-		if (is_writable_device_private_entry(entry))
+		if (leafent_is_device_private_write(entry))
 			write = MIGRATE_PFN_WRITE;
 	} else {
 		spin_unlock(ptl);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index f5f25e120f69..7a26ed53d875 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/page_table_check.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"page_table_check: " fmt
@@ -179,10 +179,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
 /* Whether the swap entry cached writable information */
-static inline bool swap_cached_writable(swp_entry_t entry)
+static inline bool leafent_cached_writable(leaf_entry_t entry)
 {
-	return is_writable_device_private_entry(entry) ||
-	       is_writable_migration_entry(entry);
+	return leafent_is_device_private(entry) ||
+		leafent_is_migration_write(entry);
 }
 
 static void page_table_check_pte_flags(pte_t pte)
@@ -190,9 +190,9 @@ static void page_table_check_pte_flags(pte_t pte)
 	if (pte_present(pte)) {
 		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
 	} else if (pte_swp_uffd_wp(pte)) {
-		const swp_entry_t entry = pte_to_swp_entry(pte);
+		const leaf_entry_t entry = leafent_from_pte(pte);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(leafent_cached_writable(entry));
 	}
 }
 
@@ -219,9 +219,9 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
 		if (pmd_uffd_wp(pmd))
 			WARN_ON_ONCE(pmd_write(pmd));
 	} else if (pmd_swp_uffd_wp(pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const leaf_entry_t entry = leafent_from_pmd(pmd);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(leafent_cached_writable(entry));
 	}
 }
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 4597a281356d..b69b817ad180 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -242,18 +242,19 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
-				swp_entry_t entry;
+				leaf_entry_t entry;
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
-				entry = pmd_to_swp_entry(pmde);
-				if (!is_migration_entry(entry) ||
-				    !check_pmd(swp_offset_pfn(entry), pvmw))
+				entry = leafent_from_pmd(pmde);
+
+				if (!leafent_is_migration(entry) ||
+				    !check_pmd(leafent_to_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
@@ -273,9 +274,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
-			swp_entry_t entry = pmd_to_swp_entry(pmde);
+			const leaf_entry_t entry = leafent_from_pmd(pmde);
 
-			if (is_device_private_entry(entry)) {
+			if (leafent_is_device_private(entry)) {
 				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 				return true;
 			}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9f91cf85a5be..fc2576235fde 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -5,7 +5,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mmu_context.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include <asm/tlbflush.h>
 
@@ -966,10 +966,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 				goto found;
 			}
 		} else if ((flags & FW_MIGRATION) &&
-			   is_pmd_migration_entry(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
+			   pmd_is_migration_entry(pmd)) {
+			const leaf_entry_t entry = leafent_from_pmd(pmd);
 
-			page = pfn_swap_entry_to_page(entry);
+			page = leafent_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 1954c538a991..99203bf7d346 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -57,7 +57,7 @@
 #include <linux/sched/task.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/ksm.h>
@@ -2341,7 +2341,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (likely(pmd_present(pmdval)))
 				pfn = pmd_pfn(pmdval);
 			else
-				pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+				pfn = leafent_to_pfn(leafent_from_pmd(pmdval));
 
 			subpage = folio_page(folio, pfn - folio_pfn(folio));
 
-- 
2.51.0


