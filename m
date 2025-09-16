Return-Path: <linux-fsdevel+bounces-61758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8095CB59968
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665763ABADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18EF35CECC;
	Tue, 16 Sep 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0qmGtDX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fj9MFi4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D43568EC;
	Tue, 16 Sep 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032018; cv=fail; b=RflwO04oYWx4AZcmxSQnRW8JnmBeRSc8NykDK4E/ao2fIN8Sc96X15VPjRB3x5IWM5ahR9kuJi7pD+yRT93GvA/x0chEOQS4rnaT749Up3v8Lv2N/XdJiwY1ZtMwsYRoB5es2KKBh8pWgXBfG3HDnbKxSOMPS7KJseOjOVRtUyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032018; c=relaxed/simple;
	bh=OFlgBbhcK1nCHQ2DIlbyjRDN6n6+MnIRW6kbHOG07tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYGbSC9trWcQP2DCp/oqv1RoNxCwPdT/oHlhaZ0tsPG+REwAsanomd2DfkP8512m/LLJyONULN4sYFbsi5WrlCFIad/qV3sBampRa5VZ9i2aP1xMThi7dy71AND7AjOCv7XusH95FLsivHWLDoghLB45oLb45VHK9JLPAXRvtvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b0qmGtDX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fj9MFi4X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCecqs003101;
	Tue, 16 Sep 2025 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8ooeVojHmyBhf/Fim7kM9B8TADJxrG7t7D2Pd2go9oo=; b=
	b0qmGtDXOg/trW3JTQOo02zH1IfzmEi1pNnqiy8RZTlkP/ZgmKvcZ8eng6LE8h/4
	HHRNV/2h9opZuFPniIP5Lpzcu0sfLr1EfmOXICKwukMvyobcEI95fX+lQ6NC311l
	dV499yLGU5PVQeus2WpRApv1Ph6yUJfe0dK0+rMte/SidlRcDzBulcz/qMTLZQRT
	UHZhSc2ke6EQwCIYwBGG3ma4h5PyPPc2mBCXk0FOP66AyAFlg/O6O+D1Atse0xJS
	j9RFkEVi0qa4+DI0xA5nPf70+dic3Rcm2q/1CbBYf6jeyrFyvkAaBv4w3vGOd9kZ
	WN2Yz7w4VO/Fe7pAU5mKbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf4thg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDsc0l001477;
	Tue, 16 Sep 2025 14:12:51 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cphty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZRzHKwDWsEGDhQWWJ+my/bgKo29j0/aWsj2pJhEvN32Uux7eEYZMqP7pJgylaf+OgmkJpHUdvm6QoCNB17xw/QY5qQofudiB6jgtAXJ8lgyLZf3y6VaoRZ9VJLmNtWESfFjsX7NH9DN+fLREuQnO/ghv7HzDwcLon3WuPZRERE6pWRzO00IuK+4bk1ZV25Rggpsbivu4oxxebJXPfiWMiYns0f5hPhL1giDYuApac8TkW9QS5smBTYiZ90S7MHKuC5XdMD0tMQ7B4QO+UZo8YI3TTAlLYsCed525AYofgh2pQoifJp5MyKYNdhjJLV3gjD60RkhaNqarIRClUbMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ooeVojHmyBhf/Fim7kM9B8TADJxrG7t7D2Pd2go9oo=;
 b=Q1K1K3B0mwbUlmRVzandLgq8M2u/5YZiAY1QhiJSi9eMHmH+7QGbppCBwrOR+QXIoMJmWSVVwwIyqpJGoiro6APrc+BaI/4AciFyIuL+hUWqd/MMHV9bmzEg1u9sk8A4XIY2AnZIKAM/QHru7J332ADzPskANgad9jhpghd/jBB4mNUHKjNwu6klsy0qCJdidlrMFALo9nsqf50mmE5j3wS3P80rYBXs82PO+qW+HWOwfkgg9/s4fiuh98V26yrGjfT+EFuBszPxlgZDrhi/oo+xMTyU41TtKUx60+iRrUe04sFjigNrOMxje/pDMPCyQ79V5OIJRSHeo1LQfqwMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ooeVojHmyBhf/Fim7kM9B8TADJxrG7t7D2Pd2go9oo=;
 b=Fj9MFi4X6j7Hej3ugOfZjF+e10t13/50fIl2iOlzHVe53mcJ4DEnCgLV1x/mv4m3oBsG9trGO+cVpQ2D0GiMUwEhXLa9rYIZ5D3n3PwkNfnbHvXMZ8KWoNeAqyLG/Hntvj1+DczGTSvQJxD3uSpNFSP+Q4oHPpcpiGcyOHQ/Zdw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 05/13] mm/vma: rename __mmap_prepare() function to avoid confusion
Date: Tue, 16 Sep 2025 15:11:51 +0100
Message-ID: <3063484588ffc8a74cca35e1f0c16f6f3d458259.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e18b04-4ae0-4c6b-cc1f-08ddf52b1cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y94uOudhCpwCZMXK6m/R/CYrzvlySGjI4/TPjw8NQFyJfxbNir0PDvwCR6PQ?=
 =?us-ascii?Q?MHgBGggJMR3uWepLrqf/EYxwh1dEiFX06bu6mn9jBVIW1AfY97/3aj9G7oo5?=
 =?us-ascii?Q?OYc8Ewymfuyee5bvvTfd/2g5bzkWFVzz0SOySA3NH3CcF9p6LmfyFJDKETJp?=
 =?us-ascii?Q?Sw3FLOUNxwDSA/ivtX0oceWyrpU/JmCHzkCegDj5mFAjJopPSR4s1Bsg8QKw?=
 =?us-ascii?Q?IgQHxxVFQjTgSkl2hCiFjZ/dkDzP0w0zdJHJkMbQNmNIw7UDG96ouSWctiFO?=
 =?us-ascii?Q?7Uj1ewEiMtKMyVwPx2LFqgq40ZfO81Eaa/R6wVp0jCwNAe6o9WQpgGKziewr?=
 =?us-ascii?Q?GXVgaSL+PC3chYg+HUnlNW70fwGfA5vRU8A2VQG6k0BYYBP2Gbu7N7orMaYH?=
 =?us-ascii?Q?AIQtaHYYRRzt2D3RgTneMoRKqhvP3+qRxuXHqaJFzbAuo7d0adw9dL+i3QKF?=
 =?us-ascii?Q?MSZd6KbUdawwdY8GUD6pR+upNAEmVOVB08iJhRBZ9kmlN2nLLT57PaWFGMyI?=
 =?us-ascii?Q?lxT0phs+Ne4s1PnweFXiWsLRlCB4f055a3/m6cKAv/BYpvH4ktTm4QZU1Ytj?=
 =?us-ascii?Q?2l1cKlqB1FmMcqUhaRbil7cF6Xjd5MZ0G4iMVKfejuBJlYXgNCJncQHAQ/JR?=
 =?us-ascii?Q?vogKAsw8f97kZKOL7xez/x6XZvWHmvsoBX6H8cnF3JAEO1pdiQH1DhJPrmoJ?=
 =?us-ascii?Q?5PCY88JwFgKBgVCMpP9z6B9yLtO+s+JsPJ1mRkv2ARsV7XN6ffdnftVn5UIL?=
 =?us-ascii?Q?raG9fHPAOX8tZINC00Em1mHEdemtsTk+8I/jK8XltzFHG7z9JT47BFVgemIW?=
 =?us-ascii?Q?jUqYXNX5d/g/t+2QzaH8ghTUuqFF1xJkFKOH9LNXx4bm1TuUnLz+uKafOd0C?=
 =?us-ascii?Q?DB51OmLA9prOGfGmuRQJ/OKge7w8t2NsfIhi/1OuwAlbYdLFVFMG8Bdvm+qK?=
 =?us-ascii?Q?M2qS9XF5QUylzuIBu/1xzdtbJODogXk2DYyrdX3SFjoTZqlZL3NXt9iVwMW5?=
 =?us-ascii?Q?fncHTaEBeHU10QyVaxww16uXOi/rHlMJ5IiEopDdWv2jX4gGL2CUR7cxChWc?=
 =?us-ascii?Q?SOEdM3Jv573oCK1jmd7a1UUryc9/SUGAOLXL44NrXSIrJwP0BF76Pt+jKYxm?=
 =?us-ascii?Q?t1991hyjeiDmWFEsV25ot/MBZDB+xJMUSivdYjjxm2lA7hfA/31XSJUqPq9W?=
 =?us-ascii?Q?Nokdd9sTSojgMFX2hBbb0N+arevuWOETZBnuDv18vQOGYi6Fd2XZ/VcDoawb?=
 =?us-ascii?Q?5puWB2lTWE+eUyVuK27utkC471iaIPDmbfhUT9yy5VbKtXgM/YtZxkvnNq4+?=
 =?us-ascii?Q?txGA3sttV/qoDBbsbxcMxGbOBuPtDmtVQ8i5FW2V5DAL+wcrEcHVJ6ugMuVx?=
 =?us-ascii?Q?LLvKpsta8CEJeWUGTEtsvqpRtLlGym+xoQQlXkPjnu0rtpSpWcvndH3+LQY6?=
 =?us-ascii?Q?yXkEPunpnyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZYEweG0CsmxDDdpUhdGBUJ4qtRNgSvYV9Dfv01AicvWM7R7fECDc9yiKV9sF?=
 =?us-ascii?Q?ymS++QJ+FDF0KAxl452w6aIjYRkf+4UGTuYhA+65n4KS59OjF3eFck30j2iu?=
 =?us-ascii?Q?DikmUtheLqEJlkEPrR0Z5OCpR2OO18MuT2njoCtFlPN5wnLTq1jYiJclBfj7?=
 =?us-ascii?Q?55Wks3kPjFhQ05wuFWF3s4Q23XAC/PdxHklTfp1cb/oGkWm+8xge3bqs32uc?=
 =?us-ascii?Q?kDaeItydJwwgFK4W/YxY2LEw50lfGuKqt7CgWUt+VShwmRnH+WrJEIC82Tw1?=
 =?us-ascii?Q?k0+FLquDW6G1Kg7T/tW7Z43hfR6EKKwh+fWmV2H8WKONuRMsZErukHOYXQCE?=
 =?us-ascii?Q?yEBMfcTvH9QJ1V2J4GaRcGFysbvKKsn1lX9eblMmJ5KVy9a47jpeJZ9edAsr?=
 =?us-ascii?Q?57uGknb+VFYqfJhT7Fi9nLtRmj/W7Lj1pSqs6Ycfrq3E58xSrwVe3/IUgXE/?=
 =?us-ascii?Q?xAt9h3At0r+Sy4YyoOWc2sq4GrLasO281sCsgJ2Yb/haJ7C68hdZIO92MkUI?=
 =?us-ascii?Q?q/cbvfwcgmWEqD3SU0UZbCO1GBlktCh+izqmWd6/p98YoM/cXIScSSPRTlX6?=
 =?us-ascii?Q?jiaRKalwLz0ba88PJmbFcQDhHYzkhD/J47XUcDfLVndYIbcTWzVew4qanzXl?=
 =?us-ascii?Q?1yHyPHEdrze1iZYSlGXVc1StfRBZMBR49FvGaK+0i9HQ+hvrcAzsdhHcl9nc?=
 =?us-ascii?Q?c9Gx+EtYHBTT1vrIvDqtgNoGuJ1O10Zml0opITg2U4rsR54+yV2a9/qKAeGB?=
 =?us-ascii?Q?zi9bQAAGQeQr+g+PmW8HdOUE4Vt09epanY3tmjZiNP/llhZX7z8kFrvXM8NH?=
 =?us-ascii?Q?9FPQYu7UR3v/BRnI0GWHY0aK1NH7cjkjkXoZTsxY8FxygYeF9Zx0jyRIIYn0?=
 =?us-ascii?Q?A31LyXCWtTJWC+00f6qIbrcj0Q2/E5qkPLIjxCI6CB2ohYNxgR3tPAAlvpe2?=
 =?us-ascii?Q?RXK6Raydmkq6lufQmfBqDH9bLER5dCT8OqHUsgtburwp0JeJwxABdoTZ+6rH?=
 =?us-ascii?Q?4aaMzfaGBGIkvdasvW9xSvlb5utqUaNRSbFD11KJwP336UiIEPgXLahml6na?=
 =?us-ascii?Q?L8buMbCm+rN18I/7JvQ9Dd5ieCiySAt39+n33MachnykOTxRQfj+GtEtVaV+?=
 =?us-ascii?Q?PetLGPHvLKMmhAVkgGuq/eFie1YR0QjTdsJQqgP/mbD/Vcv+0SAM/E7tNv4J?=
 =?us-ascii?Q?XqJgJ0X0xo3TWL8Dke/PCegYsHcb4BF4zlEj3CwuaDIXDzYBAF2ZlBZjM/Vs?=
 =?us-ascii?Q?OGIR8T5v8CxRa+G5WF3u1cvklhT++WhOLxZAyBmLj1kFzqLWg8+j1kNCxfRn?=
 =?us-ascii?Q?xPDAzuP/vuKm/tuh1NA8Z1zTio/McaDkLIYg0UDWRYFcMywhhmC81Z1uU8SH?=
 =?us-ascii?Q?Dweohd23H9mmS8PpK4nlk+4+10AfcQgX3dqJeTgGhXtgaJp3paPhIB3sZRda?=
 =?us-ascii?Q?LDeb17pyAl9x8ztu7yIdVd/mbVRbXn9+apErQxukBFR67GMNfllpCF8BdG+q?=
 =?us-ascii?Q?ooFQ/bK2WHqdtWQ8hxHWkXrP9h1+rP8kbviALMb4PJZck2SSwfjHG+eH5ZnG?=
 =?us-ascii?Q?2VGHrDc1Uc5cNfmlzAIFzIWi7tpxHAIySB+ETnk3U3wYqc7dLVdrMUKM71fN?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4atTLl9Dov+8P0iLSdzZlQFqCgNncnd//sCVZR9b++nz2q4/WCcpfuql4IPJF3TbONeU3OB6Ens2RcPlb1Ln2WSjXTslT69fTnlb905VUiifU+yTV/j9W12Rsgc+J607jQd+OtrN6fVZjfOtBciTzOXB9xhRKwNmQaYDiZ6Cm3jbPGulRZe0/NK7NytxRw4Y1Xkhj+J4+GSmd03IM/jaCs0ep1Deja7OCB+DcxsNgLSfogVsEvbxbcsKuwh7hRytGwya5yAgKB8265RHwKPRtEMXlqWymJavU221XFwI3fehsDWURkzrSXBi9Fem1FbWImQ9dtGa44C9yxhgUyQ+ooNpVJiMEJp2hP+fyK6L9KdP3B4vsxKaAnfm498kEFv7p8FdsNOe5W6qnOOb5xhMG+ry+KWseyYTWP5ZCZ13OvCVkOiW3V/ItJCdMaEisCwDCP9D5Sce/1uSahNWNG9tu9hBjiV/8nQLBjGtDTcTxP4txbXAMODTxGfV0jd8WY8ToZ2S2kM7iHNtESV/NUQLwHbX22dtxJvTFEwuZPzFm/ugumwS3PguuWQqxlwCzmoBdOu7NNR3tsgQC7g2sujjzNj3a+08H75A7pRLMPern+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e18b04-4ae0-4c6b-cc1f-08ddf52b1cd6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:47.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh1gSyFa/QFF1tLOkY0AHJXwcDL3QXWd5G/cNu9PM8H6VbSPvvHVvbp/uadglfOd5U1HOeFfPCImxtxaGhuCfVoMUVop9yCxGMpPilo35no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160131
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c97064 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=69g8Iwx80a-1R0TaFSkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX+AaFtx6/+qvi
 kuIYeBTUxzaGTvB5XlsaS89F4jPvPGHMoUG1rQdzfQhI8qvb5qOUnvKQNS5zsDBJO41JqQIMg9s
 ruZcax5tdnnUgvWf6EHlaCJ9MpW3dWK/vJkB56EpIBVoIYLCK/ONc06PocT8yYe7Ub0FithSWUJ
 nUd3JW0tUetdQgk3m2N7d+2X+BlzGYiH96oxk4bil8bzOS2NH+1wJEa9tOSH9EfncVnOtR9Y/5y
 SCX13R+S7/pq6+58ZH7iReVwZiOdiqys7TX0ieHrIcbJFO36KjjqUTvIRBoCFT6eZcIjkCDntVS
 5rjGRwFC2QeBguUR+lSTuVy0Isp6I8vMCcOhwRrG+PTUuo3l1ycAQUJL56K5w9Me5DnLrP1Tt01
 MVzNvKMQ
X-Proofpoint-ORIG-GUID: uKyzkH_Q6q2QHUkAqJXq8VMIQUlE1FfB
X-Proofpoint-GUID: uKyzkH_Q6q2QHUkAqJXq8VMIQUlE1FfB

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename
the function to __mmap_setup().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/vma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index ac791ed8c92f..bdb070a62a2e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2329,7 +2329,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2338,7 +2338,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2649,7 +2649,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_setup(&map, uf);
 	if (!error && have_mmap_prepare)
 		error = call_mmap_prepare(&map);
 	if (error)
@@ -2679,7 +2679,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_setup(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.51.0


