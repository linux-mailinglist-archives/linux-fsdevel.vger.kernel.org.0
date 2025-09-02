Return-Path: <linux-fsdevel+bounces-59985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB653B400EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A212C1AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4628CF6F;
	Tue,  2 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCVh+SWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FUP781nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F3288C2D;
	Tue,  2 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816851; cv=fail; b=OVDn7ts1hKJWZcODotPCIx1uFNP7fkRkXurpcDVG+Jp2+l4CiEjSu7jjLSeacQVECOGcclqcERsSFxxUwK72JmTIMtMB0m0rOeeuqNtwAhCgpMAL1IrQiFMviETXuPY4nxELDGxp3x0OulV78PSaV/0fh99WABBgrWLYq74+uhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816851; c=relaxed/simple;
	bh=IHomWNo70KjKaohxUcgHtm7Xc1tJ69M6Ck34/DKmg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bDWOUoFfjEzO17CH2NMYArUNqiixhqzApjz1s/QVMX2n9mZmu5w5YdouEPNocEJs4aPXM4QJidB9aJZrFMCyjVj9BgqxWrdNfU+hTivTzPkowsr8FvEdb2kxW2tGc5lSyTZU68O1wrtgzAl90IPdJRwZtyAqH4bwn3mmp6Bm1Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iCVh+SWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FUP781nI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANqVB028341;
	Tue, 2 Sep 2025 12:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IHomWNo70KjKaohxUc
	gHtm7Xc1tJ69M6Ck34/DKmg4E=; b=iCVh+SWJU0Y66TOs735MKKKnXTbmn1h/ZT
	HMdBOAnoBf61ADnZai6gHjvIJopWZEFjCLORmcMaAzx1+PndQ8uG9VpqkBAoOgi+
	OT/Yyamz+YPSZxDmzB+iXldNvXCR6yjHAkLpKVz0O9iegvjiHZYgIMcM8EEYfEoN
	yxv4CTF+SLavKBW59aUd600qFz6MqO3lsZT0h9Br1hrglX+dp+8adPf16JqlXSU6
	Y5N7WXg5CQj4W5t2Qw04Tiq3VFMl+l4kfXOYAk1rlboRmiGnRSYgbeCoJr/7cpL3
	dvvzwofWWw4eTK5xrmK20jOSkNXlwP/Q6q3hXzZL8tosgk3mcF4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvuy7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:40:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582BqDgV030968;
	Tue, 2 Sep 2025 12:40:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr943w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfDNsnBe6tGPUk3v077dqU/AHxqpGBeGnvLAd2jSY/8mxM5NsbbQPwnyl2iSOK3boYLOjMifVsxPHdFJtPe57sibocf5pZA9XQaHwZn+Za3HRZJOQpBT4i/fTxuhI4v6HDKlGpHfjRkHJQcOHmoyeKAlHall+1HTC/IChDgdNAzFPHHvKeh1oiY0r1q1evuOjWVAJzncPK3ZNKiQqs/VI+iTIaKx/IFaNYzXAqf07QN47m6Iv8P54LbOWi3TGvh1xoj+dHtHPBN+iH1hH72dJJetDo+xqfr87DdY8xzW/gGv5VoVSP/2hb64V3V6jNcaqNQMOs+agXHHsCLb3gprzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHomWNo70KjKaohxUcgHtm7Xc1tJ69M6Ck34/DKmg4E=;
 b=ZxtIoazTM+U6gLWZGkGrSIxB0uXYQzaSW5gg+Kw7XOhQCXScfAWrj4unLcWUX8YVpmUMnHqMhdiLv9K9IT3nPgh8EbGLfSCOIOQd0PcIHrmmu7PEk7PDbCUuZt9w2Y4klwCqWvd5Ta6ECD7TDOgtjjOZoXlpuc+0PpO+5UaySJjHEqH6TMdJu+Hs1ILBbD3RDDdzyIuDn+ZzXBHnUjvzb6u2oRs3XbSVXIJa/vmy8sYUhWuL2GEsy6C/QNxO9LZ0/W/2OL08auT5Bn6susreqocqVRnpe7LKLaY+Q/KPeA5YftDjpKHzdxcYh4yZx03rfSzv9IREMTb59W0gQKdC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHomWNo70KjKaohxUcgHtm7Xc1tJ69M6Ck34/DKmg4E=;
 b=FUP781nIrHbmewsCqnXi8znUXX8XoL5FLwTDfdWptgy4YsQN049XJ0AHNm3pdh3aX8b1zy+t+/IUfKmCVEkpWs5+FlsEA8vjIkV/IHeKqidE/I/71Oc0F4/1y3SHRPl7jrs1RlbozZa/867DPNYtI+6trmMJyPuEpJgmYRHDYjs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 12:40:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 12:40:29 +0000
Date: Tue, 2 Sep 2025 13:40:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <4345bd3a-3ac3-4eab-807d-15388f1a7422@lucifer.local>
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
 <20250902-kapital-waghalsige-7e043061b0a3@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-kapital-waghalsige-7e043061b0a3@brauner>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f71bf-6dbd-43bf-3ef6-08ddea1de62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Cr0N6JhC32kLYbeeo6bwYfLw+8JXIOsn/qqo0dWqIB7nlo12FEwYNM1q8zc?=
 =?us-ascii?Q?IgeBtkPlzDP2Wri268nZ69BpaaFXFVk4o2zHq0JWj/x37uD5fW4ZD2kQHHl4?=
 =?us-ascii?Q?rgg53FyRmFtThBvSG0iVaLPnsjglTZ3OiSgfZY9Yeqb8l/lGIOZ12C+PJSQd?=
 =?us-ascii?Q?MRmeQM/+byVuOuEFRaEBXOVY2NU9A7GV+x9p/pD34ndOkQNKXIO0+OA3Iovo?=
 =?us-ascii?Q?SLCfFj1yJq9+Kkkg7R+3/+/LfplMXJCVdBy3Gfk2JsyabQGCPaNC2fpWCRbv?=
 =?us-ascii?Q?24gG+atEyJq68PIC/z6sV2x6TECB85S/T3UCHBFr2dpV5xdcRGy9ou5qKu3N?=
 =?us-ascii?Q?sO9qJ62odrPL83IodXAt5e4k83p8FpShTa2Jb4FIciOliPVqkcbUvP01cu0B?=
 =?us-ascii?Q?EARW7aZtS/OvgPCDJdjRzm+D4gwkJBAZIOIjvp+WaxfNqc9mLRzJHEU4eSXi?=
 =?us-ascii?Q?DeLwd7uHdwnuAFS40j0jeV4k1tmYlZ4qrn8pkl2OAyaOEI0sxcO/wY9kcSfJ?=
 =?us-ascii?Q?4g1PMVhnLcz+UwMSvT7q+C9LNjAZOkSRUnzr5lh8pE/sl4hpaprT8ZQgxgvu?=
 =?us-ascii?Q?sCjlEmMBVVwhKKZ8M59sLEfIXBn2OX7QrMnQZOPRINyevhc4PAqM19v0YdUg?=
 =?us-ascii?Q?Sd/m1/ar+TW+AwyzUewP3m9ikjOcTgCfHZChBIuQh4g+6fQhwa4Ds05Lfq7Y?=
 =?us-ascii?Q?Sr30xsv8pigHrZm7rvDNFtz1r6IO6jTxQgOBEdYO/mfmtGRVkOCUc8wHlWAo?=
 =?us-ascii?Q?oeq9T/oQokd6vsu2HjWw9AIIDI4O/HUc9Nwkh/Ukfr5Bbs8XPkvygbBancEp?=
 =?us-ascii?Q?2UbKacspdLAgBDes7gmF0m3NgeFPedIx7r8Jqz23UEmN7JMBBlnP6fuLAkif?=
 =?us-ascii?Q?CL6vuXzP5CAUjA9z5A52VuOvKtlt853bK5qYVvZrdIYR87CUeTgid4xE50FE?=
 =?us-ascii?Q?enelTp/vjfl9EvuskPG9P8lMgiySeQILYasDQfnxd3MokXUTViuzfFvwKZ3S?=
 =?us-ascii?Q?21QDqiQVBmBIDiVawgRVzl5YjH08iUq+omo5A9p9aWtt4kqwLdfpZHPwtsjl?=
 =?us-ascii?Q?U2vT+AadZSosb8ZrcvsmrH9du5FgaXZp7FbMCigVdsWwfek1ebczLG/cuN/O?=
 =?us-ascii?Q?T4Ei5LP6PDoJzcZGrmB/UTn2jbZV4TJkf+ZtBrVbA2GGrysWAGs6Ck9/EiG0?=
 =?us-ascii?Q?1k0dqtTQCiBILecHRgKpzOeJhY+U1dyubvTIzleeMGfKg3Gl9KIREGlenA06?=
 =?us-ascii?Q?MWFq9v8SzJ6MKpqaUX8831X+7QbyIzFzZv1L/vKpuRIOdDLxqPdXd1MNwlTe?=
 =?us-ascii?Q?9mxB/tIU01p27Dt5ef3IUWFRfGPmYJiawiHwFUUqArbKSMwc5zyCVYAOj7/M?=
 =?us-ascii?Q?T2ciL/pdCqAj3r9PkEFhTW61PQM17CddwsYXaivwxbdmPcUgSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRPPe17RbDs+DW6zB5kd6QuhUuWAQPn7+Z7CjppXgy4lDNDcwozouxJyENQg?=
 =?us-ascii?Q?zKify1WOPmg5uKVfbMr8RqU2ItIF4yztgEp+Zx3yNvUCnujR/bZ1Z2y2+tnE?=
 =?us-ascii?Q?WhcJX7M3fZhZC2iWU2kfbMhDWRKvFGGZReGmxGMEJii/jYxizwK9uXtvxV51?=
 =?us-ascii?Q?t4AWnXNJmZkQ1L814lUfOW/KVLH06s6atTViPfBonbfylNrtLuS3yjyDL+ZY?=
 =?us-ascii?Q?bIj1kNNLRzH2z/4NkB2rTE0WiXwFLo4aC7joGx8q4fGP4yll+hxVzFJeyuYx?=
 =?us-ascii?Q?sbn/Hlq153F40J1QppyZycSBlIGI9fOlXgbIEU4GgzKwiflsvX/+LJz2+1MD?=
 =?us-ascii?Q?Mv7sSn9IimiOIRkFjlbkZuxwBRVDoC+Wzh2i4LQ7/+XAs56X10MgV2Tilyx4?=
 =?us-ascii?Q?2a5X0S1aoeBxOlxOC/MP/OOAqMR5YzQEbYizmtv9wn3g0GZHIiEfbVS6QwNX?=
 =?us-ascii?Q?C/OkvZ1mc4889hzaR1aqKLerYILZ8vMkZXSkHZ9f46BpJ7d8kJqlVY1hO0Yx?=
 =?us-ascii?Q?XbERBP3azVBX6d3obqWIeZ6BjMpIOH5DLYpTvJ5+/vyap0GX5d+2rnHKR16a?=
 =?us-ascii?Q?y3iI/UNtUJX1VR2ZCc42THXd+ebZJTurJxQPqeFJGnx1XT9pzfDnnpYq0nhZ?=
 =?us-ascii?Q?kgr75reF3Z/OReTyTq1vf9zsLOWW9EVsw+ghpcOZRy0AUWt5E7aW1cmBIrAf?=
 =?us-ascii?Q?N7DwFvMczfj2SfamvKIMLf+2fqkwAz69Jf15uPt36aRhe+zRnRIpU0Eu1jhN?=
 =?us-ascii?Q?8c+cKcao8p2POudj391wt46pTMjAds1C3Ksb6XMug+VAnR2JGfqpzzJWMmVZ?=
 =?us-ascii?Q?vZQ0OYt+5/Kai79V+NZZT+CwMbQsfbDaPSVC4AEHCMOP7e3gKep3V06fVRSc?=
 =?us-ascii?Q?I914xswIkSsupGPRd/W23wm8k45oboa2y2RmK8aMq9uzRKgXVAe1dADCq0mG?=
 =?us-ascii?Q?CblNi3FpnIdKFgUuPJwJ0SdQkbK/D5EJMBa74YTye1AMcUeGjFbpR02I/F+1?=
 =?us-ascii?Q?YkKtaIgs4q6nTMD7hFFe2iJndOJraKvVF5UBk5lsGez4cE8vbt6+GajWWeYk?=
 =?us-ascii?Q?KX7oAjpnF+P26QJh2my/ebOCRzWEfmwNYVQi1ppU+0PoqQem4GJtM4y3ogJD?=
 =?us-ascii?Q?8hUg6eThBLW3tNHl2VmFU+JqM2avFJpsWGUxCV5d+5SBMhovClPhtvciSRGg?=
 =?us-ascii?Q?rKCyW+Bkl62osZWf7ey5lIZdNXBfBunLjIlFhj2x1EtHvRpJuxHYoirKyjBv?=
 =?us-ascii?Q?4r2EFpKcjA/lrmAIt3lv9a+CxBCRYJTKquQaH7bRCxJrelT1n5Ift/GxNA8e?=
 =?us-ascii?Q?PuLE+GKJMr70FSlzzDQRnW7zrH/Iai8m/zNiKGtyEsaeEIZ1fK6t2wUmwhGS?=
 =?us-ascii?Q?gZbTc+OH1OMY4iAVkFKzWeDXhTgChhABfFXerkdvItJ2u3xIZEXQkZSVp90F?=
 =?us-ascii?Q?7ivC1mRRA8eqYuZ1mnmvs6n4ScLVcEBQPVZhyszt9WzCJe8ksDxLwD7l7Hnv?=
 =?us-ascii?Q?11uiu4bmsOVPBMnTOusx+A00SdE92C23N5oWSXAoO69j3pjw9jf9tof+megT?=
 =?us-ascii?Q?gW0LoD2LDKDVbQhlJf6QGollea9/uD+x552vXO/ullZvrDQGSnYcqOvnONcR?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4m5V8XDSKfkfXkubiAGeZgLfOygTNyWkwIF0/HHXs0b/xUFeoE4GSw/u8tyuLgnYYNThn2l/dwznYRBASmlpg7nij2sch6wG8NMZTk2Csu0LOBZKtr9FboS9MZwNTkHxzcp3+/pwd45QEo2hS2uD0PD7XHtvpR/zDmf6t0Zb3zaku7Ip+1hMYn9aFSbxzv9EmgmtXHPncNtVhY095REyT98LInt5n75HRa1lwPYOMFcrAulGjpyGrmdnyRGab7P7wrqlg/w9izOSrQ1h28UpVLTnxysU7NXYY0ZG4l7icq7+nYGkwEnFns2/8kd0NN6ehWSB/OdAlQfvAv3L9sCaDvoJLkE/PDg06HHHcDJLMok+njr29RI/XDFFK2byNvoZpkLdwY/WJdKuWW/+gLFAHs9F+5/GWN/SziZpi70yFFEv0BZG2tjLtQN764+5qdYU9Rx5r6Rr39qA+ytT1GPQkG+COE46m2s0a9DZDSKJLutPbVTee6xXHMf2X+aDaxw1HGOmZ7rXmvdWtu91iw7SZ6zsR9HUZIvQi/dUm2uY7CD8d4GVf9cNs7NgUVWvlUapcalEJooLJdjudmEJUp0IlJFqnyk6SSc+MI1FPJoasiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f71bf-6dbd-43bf-3ef6-08ddea1de62f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:40:29.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laPcsy6c5UxoVnc1OpkarC/kdMvkmG+h/JEpQ3XT5bXJAFU7I/aEJSdgCjxxVO3TFClrWs7GnWM2RUQZi/Gc41YDK276PzljI/fxYr8EIZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=753 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8MxcnDu+u9Rw
 HFg3ao2P7DI5ogJGU8aelp2/v9lrZRcpfy+3Oc6JgIB5BHpZoJ71getwGHl9L8+grS+1KwkkrYp
 pz0/M0lvDuJDjlABq0hQINnO+bWTuVKRDdM6+cVj5rksqbtixzgjHTdUIOcfdsCNNnlYJyS8OvN
 4ADlD1W6gHs+ckAtotz5lOsoqHR9T+c1WyROaBKCSHmSahnJsIQ9ZXD9i2ZeRH/4jrkmLgcCKY4
 A3BrYkTmm2/m4Uip7FBCuubnAWGgfDuFSS+mfZJ5BrCi5NFwubaYofqcaPzTjGa5c7O78ux2p/3
 D4P3aRBoBwPojbdxUVQ2ljw2sefe1FVrzlAz1qhAADjGpDa/LBQ0t+R8b1A7vdimNpwt6eYWFHZ
 d2/WWWnVCtQg8ZFyyuYXFCoLt3zkDw==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b6e5c3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=z9AGQiVS9zrA-VWx8mwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: gSiQ26b5CHfwd3PAHfC2FHiLkMOI2Ayd
X-Proofpoint-GUID: gSiQ26b5CHfwd3PAHfC2FHiLkMOI2Ayd

On Tue, Sep 02, 2025 at 01:09:57PM +0200, Christian Brauner wrote:
> On Tue, Sep 02, 2025 at 11:45:33AM +0100, Lorenzo Stoakes wrote:
> > In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
> > nested file systems") we introduced the ability for 'nested' drivers and
>
> Fwiw, they're called "stacked filesystems" or "stacking filesystems" such
> as overlayfs. I would recommend you use that terminology going forward
> so we don't confuse each other.
>
> You've used "nested" here and in the code doc for
> compat_vma_mmap_prepare() you used "'wrapper' file systems".

Thanks, good to know there's a general term (yeah seems even I am not consistent
there :) will fix that up in a separate patch if that's ok.

>
> Otherwise seems fine,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!

Cheers, Lorenzo

