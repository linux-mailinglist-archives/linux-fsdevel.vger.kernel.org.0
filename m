Return-Path: <linux-fsdevel+bounces-60181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D87B42851
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AC9B4E5251
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE955337686;
	Wed,  3 Sep 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BO54wOT5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZRP73EnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E633997;
	Wed,  3 Sep 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921749; cv=fail; b=HqokexImp3eo8nIkVAFXOJE/FqUkaw4Tv616WZAVS6SAakzxJNUWTLfStvIqXS451wWvFOZeHoxzkxtfbqTMMwHWNp5fg9kUX5V9yIKDhQ7J9PlZWJF2CSWKOrp9emYfsTB3nKnVJSRTycMHXVyE4PNC/MY97YlB7VROC+JCIKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921749; c=relaxed/simple;
	bh=y08psmN03K+KqEjXfuwuxfAM/QdRXiWpYJBM3Oh/GAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADvorORLhcirnaQsd8QXsJnvVxadF+ZAQcwdCqOkpJBZLAhoZgz4QtRU7m0aELjRRfD2WMcgJyUYA+F9jGmian4zggS01scdZRwfvIKyWD3sw57txQB/u4K8vhlXiwJyI2zlz2QXL+kOJ7NG4+AGpNrX4Wj3HJ1P5EHZRbCgJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BO54wOT5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZRP73EnC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583HL8T7003353;
	Wed, 3 Sep 2025 17:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e4/eRMHE6eR4XhfCGVnpWeeR5rNFHkieCq9aAOvX+io=; b=
	BO54wOT5wibMC9erKsFaFvfv2xoUh+HDivbifs46zpvIHKEyODng/sq3HBmYSsRI
	DaiJCAN4A3jjqUN73CtgADSIxU5uPHKdbsS66qdxeyG44GsnthQJ3yp1wlpIWeBI
	9V+f/DaWOEReXl1arlTU8jJ7xeBOJ9nnlzHmVsth9CC8ZEC/JcA/gSUXHx+ZGjxk
	PParaSLgy4qy9vLTUUEosoO6Kv5MDqw6LeGBgkAiFvpo1AFbzKGIhQUDNzFefMxL
	JON63I5giNWjKptag+/qH5wSlmDR/ka4gfvhqhnGAJ8hcEf4D6ZCEa/InDHix3vw
	FLQC1yKoFegfKAjOsyFc/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xsypg1w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583GDjFt032660;
	Wed, 3 Sep 2025 17:48:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrgxqh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq5PcUuKua6ayrrQXJ9JvQtpmPCgbahsZFe218YJmA0x+68dBN0y2j30XSKtGwujwKCsEyIswmpcGJ8BkbjgrEjGclR/ol6v2vxplrxT5uuqGElIGFf5FmsOnrMuDrsk6eoEzjsGD0TIBuqO2vYNhq5CPVASajfJxi5dKOWqHnGZl91EpVGDnv+HElWE6ytY1OpM2bJvbLtXlYb205hUtofWBD7UKZC/dPsF1ionN+wGAxxFp0qvK0KJzYvEQtoxf9tFE82IkACHYnzGof9EJzgVRKHbAfbg+qlkj5kC5Ov5rAtWx3fKfhHw+wFdFBdZ5rjOwFSkc77SB5B7+2xLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4/eRMHE6eR4XhfCGVnpWeeR5rNFHkieCq9aAOvX+io=;
 b=zHNKwsiTkS4Asa4GcbZq/18UFNwbt29QoVBGG8yeO5QELAUlQ+Hx0s5kdV8X1w5nwB8XjTku20oFXlwdthZKuUuB6bkmlsLTskQjkEpo4WRU4AB4jikbR0/jWviboox6D27MTrthvRjlVt7gI6eGORbpx0BLE30w/by95QA/CdluWkWhWpbhf71kpJ/hqpMV2nPUuoF+tcCdpu1LwrmgoaHMz340JJ6YBUVWRoCP4lBa8SIaAVIC58zKILbegJ+hlouSpzg24c7FEJD2aY8zJThN8fdVMe76ngNk3aBtDPujK9+MW3/K1NrC6hTSuQAGi0O1vglaD6zMiaDtNwr9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4/eRMHE6eR4XhfCGVnpWeeR5rNFHkieCq9aAOvX+io=;
 b=ZRP73EnCdlClwxoG787FnLCF/c1JfUHwjyvzxZ1ewA8QhnOFArlxCko1noD+99Os1bg/ZPyNJT1OFA7SfOHhglDpaHbJ6HGWU9qblv1SSC3Q+yLYXJHZvJPz2ODXOr4BddPpAMLYS5sQBRMkcZwbCrDP88KGD0WLDiq6F+HiaJk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF8EEA8AA65.namprd10.prod.outlook.com (2603:10b6:f:fc00::c36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:48:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 17:48:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm: specify separate file and vm_file params in vm_area_desc
Date: Wed,  3 Sep 2025 18:48:41 +0100
Message-ID: <3fa15a861bb7419f033d22970598aa61850ea267.1756920635.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756920635.git.lorenzo.stoakes@oracle.com>
References: <cover.1756920635.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF8EEA8AA65:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1349eb-136d-49be-1a06-08ddeb122242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yt7Xv6xnri8zhGXrYECg9aE2JaU6blquNxEkzw4WdwYzRl+87btd4bVBMlGV?=
 =?us-ascii?Q?dmb6/Kv+pGFPRsFlP4iT0atlkD3HVonO1xGDyMK5mD8Xit7fJx6uA3iPCBX3?=
 =?us-ascii?Q?ebbAomhMGpiwLNWMHebCaNbCUODW9FN1piluYXSw2X+kHbM+n4vMofW3x4ik?=
 =?us-ascii?Q?XayU1Q+DGw1jQGNCbbrH/D0iRqB7/vO79/8uqzG7pdEHykZk+ydXznllGzie?=
 =?us-ascii?Q?OpiU66Mw+vZ2/VumX0qgSycBt/OKMAEoiXhqCnVSXK7wAhuoEOvxqugFpzod?=
 =?us-ascii?Q?V/RBCOwTsq1a1dhU+7Dx/pb+zv4CKGvp/rc7hyB6nPHvImFibUtwFY4ZP8fL?=
 =?us-ascii?Q?oxGsd+tUtFz8tvqSMVAwFRwizWii9UNPvUbw/5EN9+jiSeYqzC90Z3KalzUa?=
 =?us-ascii?Q?g4fC3DfQTS2TYJ4VO20KQ7RjgKYG57Kx+OrGQ2QikgqIWGVnBZVKExVJCvpt?=
 =?us-ascii?Q?gDLlJuQiZWoIFwcAOQj76OvAw18Gov9GrTzGYZhlFVUVugMQ2JTkX0fG2zBo?=
 =?us-ascii?Q?Buv+faz9sRV9iu6WGD4VAsxnGkFOPh40TFql+8MrqpELmMQoBzJGiAkwtg3w?=
 =?us-ascii?Q?IW3rxsdph7b/orkrfOPTx0H8IsDa6FOKwOU2QjQ/C3coswOuN3zhc3IIZYZS?=
 =?us-ascii?Q?z1WxZFYdyzMp8cROWwIIDziXr0vJDqjR3jPm/K0DqRaak9zWQaWrszxrQWRg?=
 =?us-ascii?Q?9gATfUrBZwB1oBvnHbQiKa3iseLXtUMErrNnJwfFpwc+G7KCZu2ESk95kc3s?=
 =?us-ascii?Q?xxow2t/5oyG4t8yef+nwSVm0nNFHsL8C1m4TKCUM+6qKDNOzvYju5c0OicFQ?=
 =?us-ascii?Q?40urzgKuyduYuHWsxWccifxxgIVFqmp9olkhz8ajoWXfu3fahiZ9UYKmPbU2?=
 =?us-ascii?Q?vR9ebk5VR9qODcnBXHxdI35iBkrc9i2/J8KLVUHVVj8bumuAK4t3IT/Plkb+?=
 =?us-ascii?Q?IG0R/hn2n5GEDy3nQnFADMAjLN5crFOyUV9fN5Q8PV1/oK3QydRETGq0oueH?=
 =?us-ascii?Q?xOzG/DCs9b2XrUbyeIwcck1UfATEHZbJlZoxjrkXEu72XX89EbdzXPfcJFjE?=
 =?us-ascii?Q?zH8HLby75dvnlu/C+dzBOR1oMZdllkQ+BjIRYMhnLMsovgkVcXC3K3Gcn67I?=
 =?us-ascii?Q?Plli0+9lyVymsFClAUOpStrusXKu6goRQN2EisT+2EzHKwnP073UYGIFqJ6q?=
 =?us-ascii?Q?khMWcYxN/1xGfAiG6pwohWlpjkKnyFtYoPGcwTtUHqjX/T8ElVfL2mms8x1+?=
 =?us-ascii?Q?y2RpS+KR6lnDAqPbiJdmsWa7Liv+yhPVySmIyzMj6uvG7hNbKLZtaokQ+B0m?=
 =?us-ascii?Q?wyexJ7pjXHRoKshoAbg6WlN54fzpCWHO1EW+lLzjvp7dx3IGgKk7OvB4fw4w?=
 =?us-ascii?Q?X60bJLpgi+TZwnVAtjogjfjh/Jyl5dI65Cn17NudgovABcuJO0wjr95DnpJm?=
 =?us-ascii?Q?QFKUAmgeghE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+r/p/dKy4bM/bqf3GC7nDKxKoc6eF7s9YOrhSUMB/HbWc980LGJgk37sH4R3?=
 =?us-ascii?Q?6eBa6Km2Vp6gIwfMJKFsl1VNq/bSpu8uafiyw2nAxhN6/o6BO7LcMBUspq8+?=
 =?us-ascii?Q?oZ9PzZ5TUhlNAxVID1ECIzlCJDcXBw2E4up4xEj/il7LL33RHSQxP8TgYfuA?=
 =?us-ascii?Q?KmA6S3eHUuc33iMclXTXZeDiLMCN0Pq8Y3xzSGetZa3qp0AcNo+oY1IVOt91?=
 =?us-ascii?Q?SbBMIb5DsJyxze5nPPU8Kh9lY9VBWlEtQ4uAoUvOxyCG4YJnD30R6m+lK70Q?=
 =?us-ascii?Q?T9DTUKScbNakek1/23jY7e0IZFEkfqzSrl3WBo6Zv6lCztgOFUfgBEL33tmP?=
 =?us-ascii?Q?9wu+SJDsWuc4fAaLyFRo/b4PIJAImZpNDYsLeKj3HBRNVD4qxv7OXFKJd72D?=
 =?us-ascii?Q?q4rRMCnQ8HRxLtYk/d6n6xbsDyxoi8bzkeuKVde1w2zFii5Xfntw/gHaj6uM?=
 =?us-ascii?Q?WnqiAmmu/cZtdEYXKrJlE0Eb0kLRDvZipsHYeDWaySpoJx+/+SchpoPL/RMh?=
 =?us-ascii?Q?8NCTJ2g25QfE/KwkQFd8cnjJeH3saGtC0Ui//mHR3kwgD9TlocTMt+EhJiD+?=
 =?us-ascii?Q?shhnbXurKlyWx6dgYYEnOKE32Y95gytioAyiwXKgd77jxsbMZ0ANUNBEoeDU?=
 =?us-ascii?Q?kRX8sNwok3tEgd2+7znJ4ae9coGbfvTOhuovNL+WY5iebEV3lUxv9b09H42C?=
 =?us-ascii?Q?m0Ugs49W0e9ktMpghfePrqcypdou869gLmZ0l6WdQ/18Kt+I7sekTyrhRE2G?=
 =?us-ascii?Q?7317luGiMKXlkK7qPRnlQHvuRpLw2h0/9kstTe9+nb/SgSvwtLZPsZsdfMuB?=
 =?us-ascii?Q?o87amFYk3WZJSHH4kUG7U6v64l49DhmvRHg8Q2oiSOaf+uhn5NS1uFZhUoVv?=
 =?us-ascii?Q?L46aev8ENkPJ/mhl+87Ns1G9wGAIbIfXPyABmQSbL1j63yzG17O72XPwk027?=
 =?us-ascii?Q?RRvdM5sua4H2mYqHvolqKygRLXKh8ym/lzrqM/V86PIRcj3I2DbTbKvYtuZ0?=
 =?us-ascii?Q?Mro0dn9tWkYGi4YHQs9TQV3jSgW1lkeObTlgl6wjTKmvHr4SoTE5mJk907ry?=
 =?us-ascii?Q?ZG8c9Ukfy8TgLnowcQn1w6ML9ItwHvUZZUAqGkDwREm7VWfL1fs9bWEg+7w5?=
 =?us-ascii?Q?kPVmpNeQ7J2+rhwnKlRSnhBBpRPB4cK2NKb0+1N77CwnP2sACQYdli0KTmus?=
 =?us-ascii?Q?pzWPAzGnP6qdPcrClGpcZs9lCyoWojp9h6hxS1ZWhDZ/lpVvPNNWJ3w1fG9i?=
 =?us-ascii?Q?qo66xnTQvUlelX85/B8Y8Ziw+kvA2ppmRSI2B3Z+IFqDwKYpb1pTAgClTU0a?=
 =?us-ascii?Q?/rL633GfSNfe1cgG/VTq+5qRHPQLwKnbPcbrD0c/hlzHnlXgahszPsBXsQq8?=
 =?us-ascii?Q?rV/0vj+GyeW63b8hAJf/BxNTY5WQ5sH5IiDs/z+rz6rBGmzc9Rt6sHIayBn/?=
 =?us-ascii?Q?6a+cViSj8DtTTZ8opb4aS7SIdKBi03/WhAzdy5gr+JKcvZhdrJyCpSL/6arc?=
 =?us-ascii?Q?O7TVBb8CC9jnkHoxFWFBWKhbWKKftZ+3rRJfVG61HBAAwuXbK4uDRIhdJx2p?=
 =?us-ascii?Q?pirG6rpP6gRGFPTPvRS1aZm2f6D6b1haTUIe1U5ZlCTt5nEZ1vaUEg6lMkgV?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VXlcy72ywKLJj3KsVQHfMJYq1mLxSZZ1YH5bonrHC7hEHMzUeH9TC2L/E/WZ2lsUHNDmS/jbBIQdnJQYjM70gIw9XQ6iXhJPhuDzw9E48YWFfz3JyeONuYt3lInXS414tFwfm5v5Ih1ZNck9yL5yijPjbUsU5ZrM9X+dFLsob88MSFGGsgDhtOrmQo2Ly8PVIK8DaG59ov+t8CyTMRi7EO1rIwVJyEwJ+pxclPLJaPlz4BZh2pcO494KOyj/irlcfAT6BIifgRowZEG+0oO2b6mbOKc5I/RuSFVL67tjNi6Tv/zCUZxcJdkxZafRwGYz5uqeDATUClqsL5vjGngfIHPWCUILIfFPPt8FJ7Vak5Zmc02YDMCtKOqiVTSwvSPuSgaYVyQSUI7q5+V7TbjQoIo+bbnmxbc3DGsaz3EOqvSnDawCiFAY3PkDm9Cd7kLgvZYfVUKZRoGw+hIcfjSplYu7BCctBLAC8+WQm0ML/HwCnI7cJt7I7cCAMksH1BT/i6mU4Kt4RJBqKhuBs66BxXndUYUvP6vi2OpIEBuQR4ng2oVV+Z/Mlsyw4026TGoehSZtquo8Tgm///fifVPQFicMLUtW2pmlR4G7rBJBk9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1349eb-136d-49be-1a06-08ddeb122242
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:48:47.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaiFCw//NAwk8NjDMA1Ha9aTGZjDRwHx2XuRHrLnntSLcvx8PGsKcVTi9o6igneuj53qs9Mkezk16mw8yOX3fg2pqretk6YGtpftQWilXEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8EEA8AA65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030179
X-Proofpoint-ORIG-GUID: x4AvTrhDbM4uY9BydE9Ktp4pWjgl8Eis
X-Authority-Analysis: v=2.4 cv=eeE9f6EH c=1 sm=1 tr=0 ts=68b87f83 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=p6kc6yHgQUR4IRhy1WgA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE3MyBTYWx0ZWRfXwS7WvrvGg0Pe
 wsqxIpAdHtZqIPH7O5iOX4mQZSBa1PNOgr9Ww7q4Mv2YDnIe4LjsfPGHcdQVkkW5Jj2L+Cb7rep
 5PzPpVIGXjvoNq2zJQVCMvnxUR+iFkxk+odgvAezWY2BD90rv+CcBD8ysnzyw/xb83hzjDHy88K
 2t6IGAMYihuEuGGTnXr8X83EbmvU4seCpQUZlBrA3lKPXIiPcNsWU8w3ys3sRvIsa8/BsOA5UUT
 ObrZ/H29e4M+9Ennh/I0RQGsVVyBhcMhqi9FccYEHpCd1cU5VsGkCsi0WmTq4S6xWZdVIMmUynS
 1XZfIK/uc3HyJcrP46g8jiV8nX2fgrnY+jOjqqmNyoIO6QE/jfEulbvpOdzUSGgCUiTH7pGrwFF
 QHunqMulqJZLCewoKm2xtL/I8iNb3g==
X-Proofpoint-GUID: x4AvTrhDbM4uY9BydE9Ktp4pWjgl8Eis

Stacked filesystems and drivers may invoke mmap hooks with a struct file
pointer that differs from the overlying file. We will make this
functionality possible in a subsequent patch.

In order to prepare for this, let's update vm_area_struct to separately
provide desc->file and desc->vm_file parameters.

The desc->file parameter is the file that the hook is expected to operate
upon, and is not assignable (though the hok may wish to e.g. update the
file's accessed time for instance).

The desc->vm_file defaults to what will become vma->vm_file and is what the
hook must reassign should it wish to change the VMA"s vma->vm_file.

For now we keep desc->file, vm_file the same to remain consistent.

No f_op->mmap_prepare() callback sets a new vma->vm_file currently, so this
is safe to change.

While we're here, make the mm_struct desc->mm pointers at immutable as well
as the desc->mm field itself.

As part of this change, also update the single hook which this would
otherwise break - mlock_future_ok(), invoked by secretmem_mmap_prepare()).

We additionally update set_vma_from_desc() to compare fields in a more
logical fashion, checking the (possibly) user-modified fields as the
first operand against the existing value as the second one.

Additionally, update VMA tests to accommodate changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h         |  5 +++--
 mm/internal.h                    |  4 ++--
 mm/mmap.c                        |  2 +-
 mm/util.c                        | 14 ++++++++++++--
 mm/vma.c                         |  5 +++--
 mm/vma.h                         | 28 ++++------------------------
 tools/testing/vma/vma_internal.h | 28 ++++++++++++++++++----------
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..73c6c0340064 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -785,13 +785,14 @@ struct pfnmap_track_ctx {
  */
 struct vm_area_desc {
 	/* Immutable state. */
-	struct mm_struct *mm;
+	const struct mm_struct *const mm;
+	struct file *const file; /* May vary from vm_file in stacked callers. */
 	unsigned long start;
 	unsigned long end;
 
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
-	struct file *file;
+	struct file *vm_file;
 	vm_flags_t vm_flags;
 	pgprot_t page_prot;
 
diff --git a/mm/internal.h b/mm/internal.h
index 9b0129531d00..456a41e8ed28 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -962,8 +962,8 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
-extern bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
-			       unsigned long bytes);
+bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
+		unsigned long bytes);
 
 /*
  * NOTE: This function can't tell whether the folio is "fully mapped" in the
diff --git a/mm/mmap.c b/mm/mmap.c
index 7a057e0e8da9..5fd3b80fda1d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -225,7 +225,7 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
+bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
 			unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
diff --git a/mm/util.c b/mm/util.c
index bb4b47cd6709..ee2544566ac3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1161,10 +1161,20 @@ EXPORT_SYMBOL(flush_dcache_folio);
  */
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
 {
-	struct vm_area_desc desc;
+	struct vm_area_desc desc = {
+		.mm = vma->vm_mm,
+		.file = vma->vm_file,
+		.start = vma->vm_start,
+		.end = vma->vm_end,
+
+		.pgoff = vma->vm_pgoff,
+		.vm_file = vma->vm_file,
+		.vm_flags = vma->vm_flags,
+		.page_prot = vma->vm_page_prot,
+	};
 	int err;
 
-	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	err = file->f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
 	set_vma_from_desc(vma, &desc);
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..abe0da33c844 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2572,11 +2572,12 @@ static int call_mmap_prepare(struct mmap_state *map)
 	int err;
 	struct vm_area_desc desc = {
 		.mm = map->mm,
+		.file = map->file,
 		.start = map->addr,
 		.end = map->end,
 
 		.pgoff = map->pgoff,
-		.file = map->file,
+		.vm_file = map->file,
 		.vm_flags = map->vm_flags,
 		.page_prot = map->page_prot,
 	};
@@ -2588,7 +2589,7 @@ static int call_mmap_prepare(struct mmap_state *map)
 
 	/* Update fields permitted to be changed. */
 	map->pgoff = desc.pgoff;
-	map->file = desc.file;
+	map->file = desc.vm_file;
 	map->vm_flags = desc.vm_flags;
 	map->page_prot = desc.page_prot;
 	/* User-defined fields. */
diff --git a/mm/vma.h b/mm/vma.h
index bcdc261c5b15..9183fe549009 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -222,31 +222,11 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
-
 /*
- * Temporary helper functions for file systems which wrap an invocation of
+ * Temporary helper function for stacked mmap handlers which specify
  * f_op->mmap() but which might have an underlying file system which implements
  * f_op->mmap_prepare().
  */
-
-static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc)
-{
-	desc->mm = vma->vm_mm;
-	desc->start = vma->vm_start;
-	desc->end = vma->vm_end;
-
-	desc->pgoff = vma->vm_pgoff;
-	desc->file = vma->vm_file;
-	desc->vm_flags = vma->vm_flags;
-	desc->page_prot = vma->vm_page_prot;
-
-	desc->vm_ops = NULL;
-	desc->private_data = NULL;
-
-	return desc;
-}
-
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc)
 {
@@ -258,9 +238,9 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
 
 	/* Mutable fields. Populated with initial state. */
 	vma->vm_pgoff = desc->pgoff;
-	if (vma->vm_file != desc->file)
-		vma_set_file(vma, desc->file);
-	if (vma->vm_flags != desc->vm_flags)
+	if (desc->vm_file != vma->vm_file)
+		vma_set_file(vma, desc->vm_file);
+	if (desc->vm_flags != vma->vm_flags)
 		vm_flags_set(vma, desc->vm_flags);
 	vma->vm_page_prot = desc->page_prot;
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 6f95ec14974f..a519cf4c45d3 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -283,13 +283,14 @@ struct vm_area_struct;
  */
 struct vm_area_desc {
 	/* Immutable state. */
-	struct mm_struct *mm;
+	const struct mm_struct *const mm;
+	struct file *const file; /* May vary from vm_file in stacked callers. */
 	unsigned long start;
 	unsigned long end;
 
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
-	struct file *file;
+	struct file *vm_file;
 	vm_flags_t vm_flags;
 	pgprot_t page_prot;
 
@@ -1264,8 +1265,8 @@ static inline bool capable(int cap)
 	return true;
 }
 
-static inline bool mlock_future_ok(struct mm_struct *mm, vm_flags_t vm_flags,
-			unsigned long bytes)
+static inline bool mlock_future_ok(const struct mm_struct *mm,
+		vm_flags_t vm_flags, unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
 
@@ -1413,16 +1414,23 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc);
-
-static int compat_vma_mmap_prepare(struct file *file,
+static inline int compat_vma_mmap_prepare(struct file *file,
 		struct vm_area_struct *vma)
 {
-	struct vm_area_desc desc;
+	struct vm_area_desc desc = {
+		.mm = vma->vm_mm,
+		.file = vma->vm_file,
+		.start = vma->vm_start,
+		.end = vma->vm_end,
+
+		.pgoff = vma->vm_pgoff,
+		.vm_file = vma->vm_file,
+		.vm_flags = vma->vm_flags,
+		.page_prot = vma->vm_page_prot,
+	};
 	int err;
 
-	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	err = file->f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
 	set_vma_from_desc(vma, &desc);
-- 
2.50.1


