Return-Path: <linux-fsdevel+bounces-67454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEBC40CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEE350545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FF3314AB;
	Fri,  7 Nov 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLzK7Zfl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DEj40GEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0B1E5B70;
	Fri,  7 Nov 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531977; cv=fail; b=nboxgIe+zB/+BKPsn0jSLOQmQD/QrbAGcC9KmX8jE046dX4p3MpULWsWkpY+TRIJ3dMQ3+zlMSpkhnl3kKyPv/C8ayqHQIgVcyq/8PLhqZ2rma+3NGs5QlMJ4BuVn9KAvhV5Mon8l1Uo8YvDTPWuovlYmqv6gs5P43i6PzyMDTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531977; c=relaxed/simple;
	bh=kOaPbsgk0DyMF5/18TgHzD91U463nM+n8C/nY6UYIUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgnEuZyctNx9YbuXDnVS1VLk67FYsAjaPQ7T4GUVPrj1ARt/nvHF5xooPVAUAPopfG9Ke6zCQksEO/31AZHdzpZYFfi1N9QMxl0qN8RxYmsqOBZNhr5oeTnO9wgLnrFIMJexl9hVWfZ1WWmTzfB+6GdoQuM0jbga6QK2Ht5G5fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLzK7Zfl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DEj40GEN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Fihom030405;
	Fri, 7 Nov 2025 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=; b=
	JLzK7ZflS1zxqkV88AoNgD+Ez5Or+B6/lzjpVKDh1RoQ6eqzoN+jOBC4zXsV8bNE
	FU/tGLHMUm1ZcWjxsF085r0oMso70tDKUM8c4n4S7qy+yCj9OCpqxb4HwVffb6Vl
	H7FsdMAiuWkpV+LCa148j6FE4JSC6t2Cd7sd9BIBMU+MRdx9OUKuELfndkOxFHzG
	r8YD6zSqqj6Eo3JoKbwk6cKrxQnlnNra7y4zQHO6ZjcMjBMa1QgoOUbMlF3Jryxs
	9amfixjcq38cG3/+UU02GYeKE9Cu66BPFlqTJWJM/KcajJfGFvuwO3jnBJ7ieeL/
	BIv9Yaur7DA/TuQCzxH+Iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9kp3829y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Efi72014934;
	Fri, 7 Nov 2025 16:12:19 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndqmqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDzGcFAZsAA+r4kpqLz9sNIxq0MNbXds88+uXimuS0czeLxwvS1crJRrw1htgM7X7cDC8NES9PNJRG7pM7eYPxV+tyKuBB4sIeC/Bgc6Ln6Ysi3/pYUnZifhtNGvxjCXUh4tL+2dEb2HKB7J0aaTrfmDHbRR+A84j6HX/xV0eJ+z1lVTBQImTcI+i0ZMpo9kO1d1Q6ibG7N55v42dRvl3Yt2jiUX+xRXA7C+Y4IPDu/Yqu5vteoZagCm6a1bzC2ux374y0g0SVCCtkVbTaxlh1STa4QEjTT2wHSppzvjSIR38wRMzPLtkNbTG6KBPccCNV5VnOv2lfCzYeow7HH0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=;
 b=hXUBsf7GA3HsW0iqfof6tdir3xd/501xpR8Y3yq5/b3WRXucWRX/u35Ui4QxOTMgm9xO0nU87+rciKfMBYS4Vd5m5zZbKS3O5dTISSYXzb0ZOeo1RZ9G4TsTlsCAx+XN+eLaLtpB8jbbUW+VqhIHIygDG9qXWp58sd/XHLUNguBWZFF6i/oD01b5CW650d5VjZ+BYAcNnaKFzm5jeKXuPeHwNjInvB0Deiswn4LqKlLHsqHcfwyIk10lXtWnNVk/e6Z8jNQ9BeV5TIfRv7rdLA1KD3hRngpaL3JGto9fY2sJtjIa/RykVhbsZwhG/GgjWHAL0vsBVGQO/rS0EscQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=;
 b=DEj40GENk/QqOv8nOVyqULC8lgKXtbnVKr0qwhUMegAJKznLB2Qg4gW9MF5SwpbSn27qH9sArkjxIKXgWIpn9Yk1sabo4oLfzlTnEdA3C4O7PlJR4Rt3RujiURZ6tYUSA8TDhEBeqsxYXVeiMFlO9oCWaW9N5wbnJTkN6z3RW3Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFADA73EAD2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:12:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:12:12 +0000
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
Subject: [PATCH v3 6/8] tools/testing/vma: add VMA sticky userland tests
Date: Fri,  7 Nov 2025 16:11:51 +0000
Message-ID: <cea1bd69624a67811de4252941ac615801d7bf19.1762531708.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFADA73EAD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b73c760-c3fd-4208-f603-08de1e1868a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iBvwBhG3Dnmy4T7/WI1ggIPLo5IDMgXh0jHoMRx1icJzPAuE9l6w/0DB7ye?=
 =?us-ascii?Q?ggf8CaOXGGZoopVaL5TVN3hLBdvFmhrDtt8d+vydrbXd3+vfGzloGxDGuvQG?=
 =?us-ascii?Q?ij11hn12XMhU/YQ/sDurHmotGP1cfh91LvkWPUtoj5F5WpLI38ccExwkZitu?=
 =?us-ascii?Q?uxrfnRfGw99okS/weaK5/twZu4sW/kPfSASAFRmxrQ5uuRBCvZitWY4OAZ+U?=
 =?us-ascii?Q?IRrrtNKmDe5yFMAOMZXyv4+pWV1KrxCsFl0Uiyz065zPXzjvfNtyIN8I/lMj?=
 =?us-ascii?Q?BSL5ycIEO4N3urYt9hNu90anZ6mCctDo5n05tnIFCcw5qcFX6n7kqA+xEElk?=
 =?us-ascii?Q?I7bUcmO2D2gXxG3pzhjuEvluhnXvUZftEVDSidxJPVh/qjG6l+5dXhuytTZo?=
 =?us-ascii?Q?6IgP+ZbAFy33G0TrjpFGJ4ltRDeQ2zOYfGff7HLsVPSm03T5PsB55K177KN5?=
 =?us-ascii?Q?OoOoNAKtESYIjwzo+kOuac1TtglRa9y5X8+r8LGd2sUAKAmGMGc7nFq+xE4I?=
 =?us-ascii?Q?O/9W96sU/XJ8EKB/ObXaMW8WyN+xp5AwjUVLWe5C/ZZhf/TrUr/5U8sh+f+G?=
 =?us-ascii?Q?roz40/PQKbnOAgKQhK46n7ucbOzK8Vn9DFP0zxZk32wIQkvIWEHM893SHJi9?=
 =?us-ascii?Q?ip0lV347NcFheBX69IC2RU0Q4KYYDEk8QE/Dk84HSgwP8feC9DvL32SBxVRZ?=
 =?us-ascii?Q?QZL2No+FwCeSItNIyN/yqXM2bGvW+FQJM9QVynkFFE8etn9cMfLlIq6kYU2P?=
 =?us-ascii?Q?QF+UkXS58zeJLEd1NP6DwkUpr3xiD+rjenke/6su23gR7WZGuQ/ym4qe0IJX?=
 =?us-ascii?Q?rg6oCspCylAvOkt5uf9xYa6FDsrLWGIWXSLFzdsCPGa1gPADCjC+czywr2n9?=
 =?us-ascii?Q?7x1IcVJ3VqAtZFhZFWA11aFi2JoA21hhV6XPOvCfcPu+mOHyV6RSBPC2T71J?=
 =?us-ascii?Q?iX3PVLMYhTdUIhOXxRLiVSYAoEOptYHiseS3FzoHJxOAJcn5qjptX8BdAhSi?=
 =?us-ascii?Q?WWAwfpwFcIGlvBQs/1ucGdGbzvqQMCxz7KeQkltujy39+RkOf7JuSwH06qbK?=
 =?us-ascii?Q?OMIqlfrUupMB577IzWvCt+dDX3CEh5QTGd4y9kBOjl49rSEfheiusekgoksq?=
 =?us-ascii?Q?013T3vfaVR/UHv7Qb+4f/CYrP6aAQJ2ThH5sytyPIblwtO1lLbwSGfM6eO6c?=
 =?us-ascii?Q?lYuSvGiv/a9n0AckS7q+q654VQpixCvUbcz7qlYVln64J3Rf17hS6RhGfhgD?=
 =?us-ascii?Q?6fTuOktRGM+xLr+IeFSNrZJI9zAMgfHlUT+zo9fBRynJvFYWaQV2XBWjxMxW?=
 =?us-ascii?Q?pu+cAlImt1fmqarvJijrQdjqdmp2EW9Vh1DgBdY7XORDodOi+f1ryj1rTFq4?=
 =?us-ascii?Q?3+iiz+6idPl1kHMFgDVoI9JT4UY+Ui/YaQsgs8qTSrA88Rb4ZA6dL2AdyDXu?=
 =?us-ascii?Q?kBSIAEF3+DlVvK3GdJEAFgF8F2LhhLPl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kibWEEKf03WpEq30HKgaBeztavtLC00ZFXQ9HYZ/YqA9UYf4mqXnU/apLNa2?=
 =?us-ascii?Q?xCnp2DCfRvAVqIrR+24uJ/ZBJAQ+IGuJpe8sOqDgTzA/ETZ1mTJ6on7qDRgJ?=
 =?us-ascii?Q?AkXI4KKhs+EXH7Ti3lIbolTXznGRCKkcu5jry2z1OFLUjKCkKhEb/vtPHY22?=
 =?us-ascii?Q?RGGeZp/qErOMfrNWZMiR9XfK+M/pquhm4zlIsqS27PuB/rLrn8GTSptZ9HPJ?=
 =?us-ascii?Q?nvVeRV8ZQFA0RoWV3aFc4QqjiVSDXJqQ8aAkkbri2g+dzGJ28z17Ss5qzQt0?=
 =?us-ascii?Q?Ymh7bj8Mr9dhXz5+ZqFBKfJttlPD6SpVioXqAkOBufrnDSWHLLM+wcKyyhmd?=
 =?us-ascii?Q?D7T3w6vRurA1gMYWgQxwUs7/Zou2PUfHIzULO3zcmgJAlHNoTmQbcMRJyNAO?=
 =?us-ascii?Q?0QLERamdcUzkhdDglbE45wxt7n4rE7DX26E68VIok+DaS+2oFC09/DxXfE9w?=
 =?us-ascii?Q?0FzjC/JnX7GGdcldQlLIzAfDyxAgSlxGGyIE4vz/d5AyxXfn6zsRJrLmuQGI?=
 =?us-ascii?Q?ULufS8JT6jya/Pj0ji+pyc+CsfqnhyVHYZJrFNSYho607C5U8VVtMqO3Fst2?=
 =?us-ascii?Q?y0MJpnBluW61JB1KLpsRWEUXNWGgWAhh8tEB7sr+1t7KoKcSKzQkwnR+VksQ?=
 =?us-ascii?Q?/Rwx8gattPBr3x5iCOZy8F2vXXdlxJsuQyf7FxA64AJ1gk/zHgxdhZwF0r9x?=
 =?us-ascii?Q?z17TDbftgEX96kRolpN6DRtubnweQgAuctaJRkbamFpTrE4q1nGw7pNs97sF?=
 =?us-ascii?Q?H5GX2zPUmjVcmXca1FzwmMuXYF4oOP4zjg7J9HMPl74Fmzp9hoO2TFKEHE2F?=
 =?us-ascii?Q?YJHSdWJNRUmsPICnWUk/MdJFTViQFNWqqIT29qHSBNaC6A7lxPtqcXB3IJtL?=
 =?us-ascii?Q?JyvL1Cx2qAxJsSaHC5E/kqRk8yrRkU09mpjMcC+nhp3l3NRsmsJcd6JE3943?=
 =?us-ascii?Q?UXq7pt34yv3N6f6+4qL1lnO8gbweLwLEbomGUH/NLa1tO6G/y3GWESr7OCM0?=
 =?us-ascii?Q?WGN5/RWIuKfkXDD6+e8h7g/m0ggAinVjNaJlpZWj9RaomqUnUsAz6Z6zVNDh?=
 =?us-ascii?Q?YOav6ZKMa105DsZzCn3tKMkDzbFMLx7Rnk8pFalSG2EV6ordzOGyMrG6UdmE?=
 =?us-ascii?Q?nv0Nkx9OpMJQ/VYB7wqYPcHViA1rOVouYz9fJAPC7MAAr17/HCcw9pHDO+ZD?=
 =?us-ascii?Q?KVjsiIvHhwS64iIkMyKLR8dWLDk6fMy8pnYxE9NSj+bhpAQ02HH45DAH+aOz?=
 =?us-ascii?Q?5+CUc5oc2y58QtfXKa0G4hcqS3qR334TtjOKYlvaaWcHvo+72pDog7Bn7hb0?=
 =?us-ascii?Q?dtB3jHduK4sbWPHNsTDIk2hlNf1Jo/UmBhzgP9NLha1VeRRb3dsXaHhEqMwI?=
 =?us-ascii?Q?xw8hzqT1n557sP2Ic/gJD6XplONQ2doDvCjtBjdAPzT730gpLV6tQEsWutsn?=
 =?us-ascii?Q?Gz05wwSiArJI4AhMU+3cxhfU8V4BldApQHI+j6vH2dk+2FYZqrwPAfxWWJEU?=
 =?us-ascii?Q?onujF5OgU1jFZJPwyQHD8a8QoztBlEYxuTJlICSU5mDkFfQoGq9YkoTZc93G?=
 =?us-ascii?Q?K7ZgREfGBTBFEqVxFrnFEPSHsCWpr0LGWJoqwdxQwxMrm4tIqs2YEJ+EnDck?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WINDuv4G7PzAAtZAdHxRjcD5cgGRNJkFFyNpeh5DzhECsHBMVy2lwd+VM0tt7pWUBQUDjIDdx+Z9grBIUvNLxdyrMTuQvFJl6ZkVf1h0Ye2ViduxGmSCxgZsIWQmwnSRWVkOq+jZqVWQeWs8P8kGVNuQKAlKDza0QxlbFnubXW5wnSXQD0LBfpG+aBUTfnEDfkDYA9Q4yEYv8PxF9JkMf3quoQTM6ZHMzmmU/I/4bhcOjcTHtigNSDRlIAWQY5g8Tyr71SIAkLgjTOuG5gYZZ5LlicR69jzy8H+rmr6CxaqDhHyJVUXHXu1l6pwf4IhK143cUB5MfPc3L5nAlGtQfOM1JXfZ2kUdBYQ8OgcMQGkt9NWYgzVXWBqJtoo/r8rirFlDAv5Jcw22Cy/S48Ccz2oDzNzTDgvXTPoooSBz49Sqb2b3VBxmaaF0cXo05sPMnpBWnFpieOeSMkNKOMAoFamzDX1dwSTB+BIuWCSEP5Cr9SfwkfUahJqWDLCTga5ZCXqQvE3e0r61bMDaHXP1PWwSPcl2Yi9i5Kwx7vo+Zj5hdcRytJVkQkCphGJh768Of0i321iLjOsTB8LmqfKhgX9Fh6Q5qjUWQ+vijF4mtZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b73c760-c3fd-4208-f603-08de1e1868a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:12:12.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no0kUK/rFv7CRHeHyZSJ4xarMhoUA3dx3bLqNrfohZyOieAkC4gg2DO3i/cd4MQyVwuE9v60u+xSj0w5IdMC5mkYrfvdw3LmJiKxsMZy1bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFADA73EAD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Proofpoint-GUID: WJ0lxtNjFToIzAx1bzRSuigmw5Fo7bfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEzMCBTYWx0ZWRfX9NpaJWxgS907
 VeDiY6SB+zr88CQDaPn7x3OlAAr/HfI4MlUU+23lr5ML0y27xzjZnocqhs5mdV2V7T5xjl/8voV
 8G9NCYoVa+vyp+HxCz3xHZ7gcbpTcP5XOcY8FOMLSPpS0mWUwWTo/PCkzNYzcpu2VtHFhLs85UX
 pnqzu1tglErp5pbhUxlh7saef2Sxa/rVSBfF3k4g2WpVvDAhSp7Pn9xeRgrTIA623ZOUTtr0dJx
 lTkEHXYjjUqNNa3xEqAhIUlA4XuRX/rTDJPVlMwr1F48EymMZaDAJJqWgkgZ3+Ov7/DPYyC7LpE
 01dl7jywzWHXI8R9l+pIdI5aWv4UuvHEacjOvF8aP8MPNPxrnkgyknvqPHSl41gGhrJ9bKL7GHB
 cS2MA2M6Nz7fO+77R8vUGbTc1BTvVw==
X-Proofpoint-ORIG-GUID: WJ0lxtNjFToIzAx1bzRSuigmw5Fo7bfB
X-Authority-Analysis: v=2.4 cv=Is8Tsb/g c=1 sm=1 tr=0 ts=690e1a64 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=p333gLL91CABKhuAUmYA:9

Modify existing merge new/existing userland VMA tests to assert that sticky
VMA flags behave as expected.

We do so by generating every possible permutation of VMAs being manipulated
being sticky/not sticky and asserting that VMA flags with this property
retain are retained upon merge.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c | 89 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..ee9d3547c421 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -441,7 +443,7 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
-static bool test_merge_new(void)
+static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
@@ -469,23 +471,32 @@ static bool test_merge_new(void)
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
 
+	if (is_sticky)
+		vm_flags |= VM_STICKY;
+
 	/*
 	 * 0123456789abc
 	 * AA B       CC
 	 */
 	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
+	if (a_is_sticky)
+		vm_flags_set(vma_a, VM_STICKY);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
 	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
+	if (b_is_sticky)
+		vm_flags_set(vma_b, VM_STICKY);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
 	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
+	if (c_is_sticky)
+		vm_flags_set(vma_c, VM_STICKY);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
 
@@ -520,6 +531,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky || b_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -537,6 +550,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -556,6 +571,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky) /* D uses is_sticky. */
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -574,6 +591,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -592,6 +611,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -609,6 +630,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
+	if (is_sticky || a_is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Final state.
@@ -637,6 +660,20 @@ static bool test_merge_new(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	int i, j, k, l;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				for (l = 0; l < 2; l++)
+					ASSERT_TRUE(__test_merge_new(i, j, k, l));
+
+	return true;
+}
+
 static bool test_vma_merge_special_flags(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -973,9 +1010,11 @@ static bool test_vma_merge_new_with_close(void)
 	return true;
 }
 
-static bool test_merge_existing(void)
+static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t prev_flags = vm_flags;
+	vm_flags_t next_flags = vm_flags;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -988,6 +1027,13 @@ static bool test_merge_existing(void)
 	};
 	struct anon_vma_chain avc = {};
 
+	if (prev_is_sticky)
+		prev_flags |= VM_STICKY;
+	if (middle_is_sticky)
+		vm_flags |= VM_STICKY;
+	if (next_is_sticky)
+		next_flags |= VM_STICKY;
+
 	/*
 	 * Merge right case - partial span.
 	 *
@@ -1000,7 +1046,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1018,6 +1064,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1033,7 +1081,7 @@ static bool test_merge_existing(void)
 	 *   NNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1046,6 +1094,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1060,7 +1110,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
@@ -1080,6 +1130,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1094,7 +1146,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
@@ -1109,6 +1161,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1123,10 +1177,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1139,6 +1193,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1158,9 +1214,9 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
 
 	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
@@ -1203,6 +1259,19 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+static bool test_merge_existing(void)
+{
+	int i, j, k;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				ASSERT_TRUE(__test_merge_existing(i, j, k));
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-- 
2.51.0


