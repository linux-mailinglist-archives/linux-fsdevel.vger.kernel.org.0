Return-Path: <linux-fsdevel+bounces-61753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D1B59972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D016684A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F0324B1B;
	Tue, 16 Sep 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LBc5rpnY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X5kx7Q0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56034DCCE;
	Tue, 16 Sep 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032004; cv=fail; b=F2EV3u66Lra+ix0UOAHlanHRjaJ+KX+Pfnsb2mTqamtfrgqWfYZb7lwjFzSXTTeXBOEl8MY3JqMpogAF68YirJuP2jHGmCvhZctY+uGB8GnMaPCee5SZxEkOFy6AMttLNSUOopAKY4ogKdTGYKm8KC8QID1mhsYoim1Wi/SFBfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032004; c=relaxed/simple;
	bh=2FqMSAQYa+pEc96t/HHaHyWQrWO378nIfRETs28eOO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pd/VnT0oFDU3icGKqBGA7/G8WpDVGFHBaBp3ef9KRTSKrP5Gl3UuvI+BR0iuMuSHmyHTt/mBzsUQ5eT6h/olPQAA0EsldbGOZTe8XyuBacjk3AfOpL7JI/QKPjgdQyFMIC5oTDLRhnJaKzbMXQk1cVtEdQxes+zZnUbEB50DphU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LBc5rpnY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X5kx7Q0B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCvvlq022050;
	Tue, 16 Sep 2025 14:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7OGL0AwbXVcbjkgF6o8i+Ln7SRugtu8D6R9H082ELCY=; b=
	LBc5rpnYbYbj1P9txw8xJVz7c9iBQRnYLR8VdnhRSCYYOFF/yIwoaD5oqyqTVGk9
	6dyhBVonEtMrq5A0P7XacP0tdqKjHAIEYom+Xw5PJ2AiMAsD+lpjkZhNcZW7htJ3
	QCG1tk3X/NwWO8zKYO6Bz3iGOkw6Fmzp8QAVI/hVSZxvb3sHrQz1PJaLcQ1EQoCR
	lZg6dojGRSXKyjuV18wD0tyJOLwUhTOpC3Y19hD6LN5yZb5y+ZG1Cc0Klxvko52d
	q2q3/Dhf1VRrc0turCae7Op14MclAeks3AUoTxFl3f45GbfGzqFartRbqITVb2U+
	jUej6NNEpCf6k9OJeD8qYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yd8msmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDR48s001486;
	Tue, 16 Sep 2025 14:12:35 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cphkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev3ZDOSbJvr1dMEUSiGvBnMpQcqPGm6B5MaFMeQJ2byQH/5QwgfAv8jT+ObdIpILiPPTId/Et632+ZBbt4ynNaWKUzT0bR6Mjua8bc/wy1A1mXtelszwFLXjM4mydijXMFmBk2jtrL9c9fcrZ5lYcFxneKUFkr0RAQOV4PPO/oI9KOfzfgb1avUBj1g/YUKvOSQwVi2BPGGTp94gyQJR2eMGfL248B2dbWB87mgFp420cmCHnvsrjprYIIAOom1TZwdGaybxOrYikE1toVwia2E0M19X/AHm8qgXmrbJacUV1/2fhAwzOMguLyDk3b1yC8l/WKOXR3XaaGg3NIOUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OGL0AwbXVcbjkgF6o8i+Ln7SRugtu8D6R9H082ELCY=;
 b=pQFWYmSpKrsXFwNwuBhn2IU4Zg60sM6GMqRrqXkDSVCiahOl7RSrq/q7l4Ij5WjS/erOqghjps8j2d/sY8SiG8Se/yJ2eFY8KUDoPoHL+c2fyQc6k5DbCU2Fx8t8PquZbTg+N5irHzGritM/3sYegnA8mKJo10UlYB+1tDtXiMNyG4k7RFvo4VwQXkm7+IR9Wx3eyjD8PGCyp3eaSZrDy/H4JYa2qbeKemNq1qk12ptqncTH8dlcwCSY+B4rsw7Bd5MvAsSy6wzy0fRfcjZypigHPdabBlwv6n2FfZeuiswNpZuRJzk5kJtwYqdsmIls4au6Zi1b0tC9GRvyJmpUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OGL0AwbXVcbjkgF6o8i+Ln7SRugtu8D6R9H082ELCY=;
 b=X5kx7Q0B6VqJ8XROi96HLwEnavvKaIWY86qhb0f7cU5p9ax49v53UFcg8BxcCxzG9FDcGvk0RiTdvk2cD46wAP6u5JlzhXjLU7ZVqBeUrI7TLudNGDU41eP8hjImi49eD5WC/sjHf+kzQ70m5JXsoiydwFubtFlfxrKeMLQsGIQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:29 +0000
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
Subject: [PATCH v3 01/13] mm/shmem: update shmem to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:47 +0100
Message-ID: <cfefa4bad911f09d7accea74a605c49326be16d9.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b25b605-ef53-41d7-8062-08ddf52b1221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avSaSNDBm8Sd0YE7sGOSWCFijHppfMlljV3fz+7KG58jjGA5UDqIbw3IHQmU?=
 =?us-ascii?Q?Ksy17K8u4OfIl2txigZzLd6DXv7EGoC4dkLvbWAIgQUKZNcFwfh1CVOjjIx4?=
 =?us-ascii?Q?SqmXHwBGD42enqLVGF50czwcweriYcU6iekDcl6gSqruZWxqNg6XgPOl0piB?=
 =?us-ascii?Q?NoAj4mXjC9NRT7JEW2/IqJGPKAFHlD89LL8quWMEnx1wedrDhTSRi/rPRWkH?=
 =?us-ascii?Q?VuKdaohKC63baKhS3uTYDNPNNSZXkGjsiot2TjFvNW3dwT8rQd+uEqtR9XEb?=
 =?us-ascii?Q?OsMV1hDg84bfTk/kueO24WwIDyqvx5v8cQKFX+qMBCArbmOHeuLIUtyd7FrQ?=
 =?us-ascii?Q?AJgazTfqD1dKkXzrC6bnyFnxAWDWW95OqSJPEFx7HOLUZO3TpHtZQve1Dn1u?=
 =?us-ascii?Q?ikOrRGj79IFqMAliKorfZwgMFZGhjgvig7Wk+I3RjjaxWqE9Nyhz+bFCKrAH?=
 =?us-ascii?Q?RXlsyiUFykjLvG2d/gIkQx8h1vmWKTTWIjbcNN7CbSHt6T5xBd0iWUIrxe6F?=
 =?us-ascii?Q?J5jIHZD1BWR2V092GW9M5o/uWyhiyQDDaoCCkQ1z7CIeVvtJA9+Radhw2xXi?=
 =?us-ascii?Q?dX2UeJcFNRC3c/VSgaLv/PV3uo5ElIYFoxYUpcZS52bBtX7h+pfsTJ8cozDJ?=
 =?us-ascii?Q?VTaM6E2I0GLTZZ0uj6kav3aT2Z7vd/tlI2lvdrX5PWhV7BdsQOoysdr48MNz?=
 =?us-ascii?Q?Bb1wMkdxy95/kAq+UcAWX1fwbY5RHWuoZ2KNgzMEkXpeSA7sUpK/hYDF/lJv?=
 =?us-ascii?Q?UPnpnY4S1zeGAR3AAjaeXS9c3B5+xjg6Dh4rVfHByA2kZ+RnTddM/fJAT+SO?=
 =?us-ascii?Q?Mxn3+WZvZ3yFenn0Qx8i3DNZKNdHvKhJIl3a4jU8Ak6XmCLFBtU/VxBoooYW?=
 =?us-ascii?Q?MEkJAPGLFs+70YEMgXaXvWEztw/kwY2TI/p4anJs7P1NUwlc4qxx7gR3VXYn?=
 =?us-ascii?Q?dTQP5m5AcocCl/nrTDzLF/PPoWbGeFCbNLoVWUjrvgPbgB8ITh/nEN4E4thB?=
 =?us-ascii?Q?pXZwfzdpP4D/JzCnwkk48rqkRDfUPHq9k8tH4dyULJA/FBBWIFtDHMMnT/Xi?=
 =?us-ascii?Q?dgTRv92lWzpNJBifW9+bno1RDmApgeCwC27DksD8jIc+eu+vdx4fppjPxd4H?=
 =?us-ascii?Q?aT+rQpCfI5WxP68YEMGiVASNnNdQudZ+nAWe2NfPAASur29MfZOBdXdKtjaJ?=
 =?us-ascii?Q?s1APdUW4kEnQR8LDytP4s8tT30nJU/bbXdtAnqVV++fkW6I4MdM31VapNyvV?=
 =?us-ascii?Q?JNmQkvOAi02hri2Ai/Eo4iM+oLpPkngkVLWHC7VmjXIqEikV/lPNf+uzasaH?=
 =?us-ascii?Q?X6AX9nqk0FsrYCKB9V/25e/n6EhGMgKohrlS53DuFgnFEfQyydaSYWjc4fRM?=
 =?us-ascii?Q?fn3Zn4vyzLNob4Zjka75HRgaOJVaKBUg/QFqG7dxmpxOdXLIssDP/hqi2AUN?=
 =?us-ascii?Q?iFq+/IEN9ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14XkaNNf2z2sqPcIsB/chfrpxxNA1bwk2h+RiJRs/L62FI2XbYIfrfNQJ2SD?=
 =?us-ascii?Q?Dr2lDFb3im3IbnSq8jEDqE1gpX4FbiB1lK01ocRLNBUkLZhIHLhCfCoh4/W4?=
 =?us-ascii?Q?ksekVRL0tsd858ktP0QtN8HI9/dMQ2MS7cMjUYJyEk1gFDUbTvmkrxKa+dut?=
 =?us-ascii?Q?tfTOJ9CEiL91qKbxjHH9WHg34xhoD1iJRUIptuRnwNTRTxuN09l+GoWXP6e9?=
 =?us-ascii?Q?qXd0ZCarz82wJwkg6bbBHFi+OEATeMt51IxbHTCZ62XoDdIC/s4ZpIGebdNT?=
 =?us-ascii?Q?98sb9AtXo6e00r1cpICW9k0noRacuhwxcmrYY/dhBGWVgYySbRjqGNIEfxBC?=
 =?us-ascii?Q?AYfdrVyCVNXuA8wRzYvhM9Js9ao/bL50D5863lFgcHo8Xwy4AQkbTYZ2nwjq?=
 =?us-ascii?Q?Jqhp/SOlFiJQ1iY2JraES/xQ8bgeQuIct68Y9noh8Pd5th6G1KwD4NAZE2AF?=
 =?us-ascii?Q?ZWjAqwH8AtrbH3/OPM/sjvKrB0ujfn8lexiln8BDfnyWBLh4EszmMHDplHDR?=
 =?us-ascii?Q?aqWhTYc74Idl1QVM+TQS11s2sjVHvXJTSuNflLjuvR19DpsTAm1cUyrWJiRb?=
 =?us-ascii?Q?b3dk5I99q83Qg1+CD7x2cn9uD53yo33wMsbJVLQShSoihB+RJk5fxa9J3c5o?=
 =?us-ascii?Q?bsmWHYUFwD9kmIca+pYm+hBb6fnjLA113irUouuQKF3CShVk0Od0bTESf0KO?=
 =?us-ascii?Q?8s+G64PQW+lg47I/Hs3GSGLTzUrFPRml7C9Ovv3GnFE3GI+eqQfcTXdaeW3g?=
 =?us-ascii?Q?vMfkofqyBlmsgOxOe3DK+3J6/WiLZUHpTHj2/w3SILBqgODhloKL1egkRgH+?=
 =?us-ascii?Q?cfGhPSOxHvhd4Yyb5ET/RqTuyW7SA6a/6am5yvSN7PRhOyzGiCO6joRAbsu6?=
 =?us-ascii?Q?3TcS22bqLhxXGjkuh0fjgBaN4IrZnPMioJ1XOarXUy+DgKyoLllzXFgWHND2?=
 =?us-ascii?Q?yvE9z6JHCXszF1YZGRxH3HC/KM6auHEJpI70EL99PmlXZLWadyhgN8YvttYE?=
 =?us-ascii?Q?EW54aTq6pUmA0ovssF30DWMZL5bfHQfEZvaCcUa7AFqZ+ASyFfdrFuQsJjfJ?=
 =?us-ascii?Q?PXj9CdzlLNU0+okFSIvAiWtuEsyCm9fn+bWtslkLG7Otmf6XkZWANv5VEY/V?=
 =?us-ascii?Q?sJh7Bdq/9noztLf6ExgV6K7zAglKnDRtod8IPt5j1yIdQ/vytx2UloUct2AX?=
 =?us-ascii?Q?WQjA1g2Du6eqg575Q5DZgQOH0Fig7hqaLBor8PmX/IlJf6AnkBKFL+3s/psR?=
 =?us-ascii?Q?0TBOxvsS+fJ0VAEqHL7Dxh3cGK5i6qqTIPgM2XEA7jAGj0soVD1QCnebpdJV?=
 =?us-ascii?Q?L31sme7jAbiuGVxAptDntHLfV9UwJHDBC2kk0Y1kRXJgMJZqTIST5bfFZWmq?=
 =?us-ascii?Q?bBQBkM4/ERWoGXD/ExU3wem2je+aRToi0SJ25S/4D6l17FuK/VgDqRGWbzis?=
 =?us-ascii?Q?MofIwtAKlJKrAw5pzjtIJJHPDeOtbpuGsaHUOxDp+GLlICuPczoWRlk7QBef?=
 =?us-ascii?Q?GZmJkInWZF3Q8JBI/SvyLEwPZXz9gE6Qz9YsB1wRn/0YyWzCukOQUL2fmf+o?=
 =?us-ascii?Q?PuB0lqOPn2gBMT+cT7gQiBqPRiBCFlLfrJPPVkVNYQIb5rKhSWCgpFzeFEeD?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g+EZGZ7BEsE4b1gpbKjNGuZH2dysxX5/hin0biXmnpqDfCAGFP7ZQFxqw4RK2seU/W7SyJsFNx7SMP57K/uCNG6lul2TtNl88vt7COOSH5nWX9qSpN+h7dGlU3i0aBHg7JUULge8wHJsPoyhuKI6j0y4L1/NkhsR/Vb5zEcPSZtuvvTOPYisCMUUy0vbynXeKec4PZ9/7Us6qpwODp0RWwqfT0IGvqvHg0RnL/LitChKxYK1bZnENA5hVIW30DlvsLaX9oJypgcIx1tcSsfhyUapFl+Dvrng73AxkHlHhkLyc7qT5mGTO2nn2zP3KXf/h0H6/STxhTAj+ObwQa/3I5zyrhL+jusHIAycnLLx6zEcOGz/tA/WXzJ2iNDZ7t4hIaRueesPNcGkERMcAat5bMJm38y7UoN/kJsTmucsM60AoeC7Ls4r2k/xl7+BJD4rI+2UfgQM3/q9iPCIPJooJ0avPaHpiqRb6aM7Sbid5WR55+mZy3mMZeo4+ycYTDHj+ADz/ZIXWz0hoInpXgJDeFyM4dTKj5syIzdA28/Epti1/Kd7P5bxCrfUnlhHmue6ZZI+17XwGzTB2S8tAjy5axPtY1JK9qG9clcKsGWUh5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b25b605-ef53-41d7-8062-08ddf52b1221
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:29.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FabfGFV2Zx1X3j+auIWyQmJsSpd86TlokYnvCcz41CpHL9PoniiVD9Ryck1bSVvDute9QP7W9zJPrHdTC4OkXS+Pcupw//lFT6UdoGqCcYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160131
X-Proofpoint-GUID: zkKzfbl2WbM1aOWiCOijfCAYawBeNRoV
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68c97054 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8
 a=ETZCYEPYCe93jH4IWwcA:9
X-Proofpoint-ORIG-GUID: zkKzfbl2WbM1aOWiCOijfCAYawBeNRoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNiBTYWx0ZWRfX/m+7kt3JXNP0
 Jgs0X1fD5BsVs+QndaDei2/1/2HEutg6Ht9piLBD/3zS3Xh4YB97/jiQx/UK0bl0pZx4NEo21xa
 zgs71R8WLFVMbPRNLmoZ1HYT4orVlhBYtyW52JIU9oNpVFI5fZ/LrsnjXMx+7K+IDZ/4LqhQlEE
 7iOpjCIfWm+zC0q1qgb5UIsLpUyq299RJi63bmVQmEYZnwWwUYEekOdApN0/lERowyMtz/dsnbA
 FEOOLC4+VlyjgM8I/p7YIs4E5WV2aYgjJoOh3HODsP5Zq2Cenrtqi/e+NuQ/GyvQLwhsC+2DX/E
 /VRXdmlUcxBjgMVikZNg9+KaeBYubMRdvNkKzR6e656wkwhkdqAo9qTlJwmKYq8Z5QZOp7HRST+
 1LK6od6z

This simply assigns the vm_ops so is easily updated - do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/shmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 87005c086d5a..df02a2e0ebbb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2938,16 +2938,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int shmem_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-		vma->vm_ops = &shmem_vm_ops;
+		desc->vm_ops = &shmem_vm_ops;
 	else
-		vma->vm_ops = &shmem_anon_vm_ops;
+		desc->vm_ops = &shmem_anon_vm_ops;
 	return 0;
 }
 
@@ -5217,7 +5218,7 @@ static const struct address_space_operations shmem_aops = {
 };
 
 static const struct file_operations shmem_file_operations = {
-	.mmap		= shmem_mmap,
+	.mmap_prepare	= shmem_mmap_prepare,
 	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.51.0


