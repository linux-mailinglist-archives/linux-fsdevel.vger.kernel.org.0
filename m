Return-Path: <linux-fsdevel+bounces-48568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A8AB10EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874D17AB9FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02521A434;
	Fri,  9 May 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j/bB4FsY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pZ1F6q6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5428EA7E;
	Fri,  9 May 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787160; cv=fail; b=DgYVr2ALutU2hzCooYnH1KOwfBHrW5apAoeVMgm4h6QyB2um1t7HhX02A6ZB5/jzeW/zmBrfoXibeCqkBi6v/wY9UuL1xaMq7gga+ESKjOmGfm1EfesHvXy6nMiLKB+vDnauvYcohVdG+0cHYQIkr2lX0VmiFdE6CX3Vjpkdh/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787160; c=relaxed/simple;
	bh=Pt2mEjXT1G9VrYjgHB1psyzr4AQnNMx1lTGbVOvaxMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlYeqXhoDobfRUPq/DfiT9OlKXwLYHKTx5N4tb5gjkNJBXzRQEnxVwLKnxWQSwRV+hH2U0GUU4RqQuCdhGSE4Q6Yn4dyzCKy+chhzF/kFAN8uz8zZgfpVODJG3xKBeAApqDlb43KgKQmmqe9C+5yL+FjE+GALuTx5tsS5nf9z/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j/bB4FsY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pZ1F6q6O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499NFSE005947;
	Fri, 9 May 2025 10:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Pt2mEjXT1G9VrYjgHB
	1psyzr4AQnNMx1lTGbVOvaxMY=; b=j/bB4FsYuhlXoB2rZYCU7jE9Fw0QiHwbO4
	AqnkyZRNreVqqWdfMh81HO1nUr1AMgnDF6x8zgRShZS2j/9GkUVO3lgdAdbNOoIF
	DP77L8/PxO1y3reLnZBtjH4TYmd7SUANvj++pNLZ9AjEBwlpAxLHGLBIQbw3kAzl
	oV0uSjJvVnUrF+SCefxUT96TZsBQVE22ktFVnNW2AWe+gAmoYNZrKFT9uH2YmE5j
	YAdtjj9kA680uYkUG9ZUdQc+CVjilg8Y4buy9s4XecmbK8gyscP4n1QuuAvVR3rt
	xDbb/yXyO+zVIZcyskTEmG7Lp+2ivcpMEztzgBAlEYEW8+3boTNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hf0yg4sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:39:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5498nZgh036101;
	Fri, 9 May 2025 10:39:00 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdkcb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6jNxPpreu1ckUtZ969LSroUbs8CVTO6cr2W0zQyT46VsCYSJevZhS1SToy+BQqvrqDMSwJYFn374N96OSRjw+MU28XPVjHt2Rmq73bPvsYLqU0ba34XFC+Ybg8XSrEkHURfqiG3UHaEMhvc9TN3Fq6D7Tx5qV5MBBuFKH+eYvDZ9/douMzRXZFEkZZQG/moxr2oIrmq/ZfyTkOPT6v64hvmG6HRXHzzKc0Mqe4mjiH4jXYDiiS3iPfrNOch322zWSHjamEOy+k6nlCTJhWresuYemhOHisn0zMQ5sNSd7whPcVKXxjCvKcT/yAL1G8dac5O0yN79SkF/+HZAR3mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt2mEjXT1G9VrYjgHB1psyzr4AQnNMx1lTGbVOvaxMY=;
 b=k22iMd5j2Oj+Yf3F12Lm2reFrXt8FLRo9qGnaIH3otiHHUM22XtGyU67QDrdkEH2qBQ2XYql19UHBJhs3ugisu6g4522Ru9cW5dKnfjbDqBGwDZocUfzptMOL1trsy6U9KDp4H4A8ATm6Cl3/ck3Egj9lyNZV/zytbUNRkD7GijKitPSKx/pX86yrvQWV4xOhaZsEuP6HtNiplXF2unBzbL0Kkg23ZpcSXAdCYTPjclAbufPQuUluw/kt3oy5AQMeUZXRYmFbzQgcP+PnwtSHqlLh1+VbC/y3XChT5WxyYfksg5b3mqgxyixGoCUR3HBOkrmHhix8GqKyUoM0gvAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt2mEjXT1G9VrYjgHB1psyzr4AQnNMx1lTGbVOvaxMY=;
 b=pZ1F6q6Od+imOwrTgssqJxLj4mUTGAYhlnzhIz5jrcSUk5AxSbx5ePn49/wQ7kjEw6M7QB+S2wjlYzxyJOYBbY5Iug7kohPzumZJiulhk5FZYMAIG4GHhSBsn0y3Bas6nBT6+1Y07m4fg8DArauuSIhCyk5FT4mqC+hSdXSEUQo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF6ABE13187.namprd10.prod.outlook.com (2603:10b6:f:fc00::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.36; Fri, 9 May
 2025 10:38:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 10:38:58 +0000
Date: Fri, 9 May 2025 11:38:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/3] mm/vma: remove mmap() retry merge
Message-ID: <533100e9-8eed-4f5f-a02b-47a7acb2a646@lucifer.local>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <e18be1070e9fcd7a43cd72ac45f19cf1080e73b5.1746615512.git.lorenzo.stoakes@oracle.com>
 <71cb8335-ad53-409a-b947-d7ded8a3ef02@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cb8335-ad53-409a-b947-d7ded8a3ef02@redhat.com>
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF6ABE13187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a98b30e-76dc-4e7f-bc29-08dd8ee5b491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LvPwvpTIOnD1E4avtmyzZppHcfV1dcJcMMmRXts/ygJVdVeoTYkPzcjZrl+T?=
 =?us-ascii?Q?1a0xEwKpMWNZ0kdj2KSKTBCneP5aPo2ChnV4Hemhk6dIT4rT7+zlhUnY+mk4?=
 =?us-ascii?Q?0MNNgX0jI1JjAuRCJ3yNrsndCAQD07CAzG3phRlbd2QCSIkzghYa0Nc6B2aD?=
 =?us-ascii?Q?DGMjFT9fb/wLvihGZ670nSuzvQHr1oDt8rL77eOzojf/17C9FaFlKtIGsi0W?=
 =?us-ascii?Q?9Bk63ZFyXW0x11V3UEFLGq5GxPDjIyjN6sWVEjOhxVZszH45e/Y+VCP/ZJeg?=
 =?us-ascii?Q?aNpi+3pK5bjvx6HLgLfTKotuSvOOs/wIbrgi7NmTlQgWJyz3fVJuhrLGGiBF?=
 =?us-ascii?Q?VPdzh0tEaBE2ZBn9lBx4tY08NOrL+dsHqKNSoFG3Crke5+I/aEfAFWIeb6J6?=
 =?us-ascii?Q?pLMAePCKRC11MG/fWWYLH2EXiOzDiCUY7gkf/dIpxerPwzdOz+zB0RGvUo9W?=
 =?us-ascii?Q?7x5K4H552KYbWhusd4OzD2FrL61uz9NseLMgtZbEMvb0Ddtn2MwJYR2ggE8C?=
 =?us-ascii?Q?6vkZJJW/wS6ceYh+J43m2qsg7A4tZI41Gtee+Z9ZDEDJzbIPoyB5p98/kYrA?=
 =?us-ascii?Q?WTL/3/xskyZKRIwpq+Z2FGSyNeACVODcShcYdbLH0qG5dcVnjrt3SAMmfEIE?=
 =?us-ascii?Q?+BskNCwr8bSkvCjDfVbYdA8/a11F/7Zouw7sU4fwu9oL2h/uKgKZ2nudp9Dk?=
 =?us-ascii?Q?A9uKRJ6fwiDBBNToYHmGgEINhjHaOuYgrYhpYJih3ApYL6p2d/qnyUnPE2UG?=
 =?us-ascii?Q?DoA6kqhi8SQcj7sqPsficAWeNdXoHZ/2zDay3/WYy+kjjbRRk9SZo4enJ2J9?=
 =?us-ascii?Q?bOFmbPAOvP4oLOJw4xSPybwYitDiqBwR2hV8NJ1bEfvUr6GB8Sw4V+xvx7EX?=
 =?us-ascii?Q?UaqEhMBNStsQCmQ6pq4OT/gMsGf8BqkwIAFtojgEHlgXcdsBIKSW47TUWv8Q?=
 =?us-ascii?Q?gQkZBYFPlyAypHJuMTzk9vYXmkne/Z5Fy8sjaTVH6uD8+1WQ95OgQpXYNnuU?=
 =?us-ascii?Q?TBxZrQrHLi8NbG0KDweQT0hGgaTqtUF5wftXsmP3wbroN6L6wr6n4SC/Lh3h?=
 =?us-ascii?Q?93khevKMY4Fu+7vwjF98BMR4301PuPPPoWQnQ8nUVcg4ZQ3htZVBYk8FzHMf?=
 =?us-ascii?Q?aVFi8cncxgYBWca7oxvzJcM7oMWaXsMoQ0H0GKEc64gph+qsOu0zylhhtbMp?=
 =?us-ascii?Q?ySjufsYFSfHCS/M821o1tfgUJby24m7pX5VqlYqI26TTcDrjp3vid2/hUUYM?=
 =?us-ascii?Q?r8qA/ZLlk5g7KZt8COmKERAsHH2iJmRuiLexydM7Rtc9VsknC9xEmBGKNzyb?=
 =?us-ascii?Q?+nI2fsRZ5ioQ7oFetq/Yq+ruq2UJp6m4QMEdpoD62TsKCvGS5ysshyKmIj3r?=
 =?us-ascii?Q?yopNqvMOnht5pv172XisYvjGP/fvqUlCSOEX6pPOpBn6r0oBinlsxGzBO9GO?=
 =?us-ascii?Q?60oKSdasSFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQlPgwn6SeGxF/SY3KOUzaucZkAQsD/k7BixRoWkaoOYEGmybiTMDNtq256G?=
 =?us-ascii?Q?HWuTEvGDnay/e+7/wsfmSKTGDDo20ROcQQKyTPkb0WqB2iCK8MotTlqz9sK3?=
 =?us-ascii?Q?W84IJ4+m4zLV21QWzrpAsJSu0PNTf/MBagixv1ptXs3ZlXJbBg/8q8DS8Q9L?=
 =?us-ascii?Q?GbMCuY1xY1uKOMArgYDUH9RwQeEKPmXcGqZ3V5xfW4QloSB52a3m5XdFgYJO?=
 =?us-ascii?Q?MBa/qtqE2dN/M7z5Hi82KhPyN1I2xbsRuWhm6JyWbJcI+6YwOG2Wrptvh0xN?=
 =?us-ascii?Q?c6T+J+zuY//8Zgr/xzMtnuPDo/2gJRVyE7c5cRZfWQF2+Q1f3or/ERvc11+O?=
 =?us-ascii?Q?K/IHBzLogFzEMOod7X22cYSk3aufWiJ+530LDrqLosQfYDdHhe8bHFpgRMuO?=
 =?us-ascii?Q?qny0sDrhjALbPS5A16U2NMtiGTy+xbqW3X0sFn9AVpsah+Pt2qzy2mT9AyGG?=
 =?us-ascii?Q?r3DzI9enFnUxK1zK/iMl2ueQ6xCYIHyDkvBASBwEx/8xLSUVRo+8CmjVo/Gp?=
 =?us-ascii?Q?fZJp5iXAgjhS1uJ/bLQjoGkyUTGzIT5r/MjI2nlOGZbGrAXt1S9W3uQVrLqw?=
 =?us-ascii?Q?XcwKaGfIiRs45/HWhV2PKYVqe5YYqKHHBUdgMfg8vowb2CEgNdpH2XJXx4yF?=
 =?us-ascii?Q?Hev9VUtTV5Y5gD3wT+PnjqEWvcrpvvxqlMWFPzLOw86FKBKg+ySc1YvhRO9g?=
 =?us-ascii?Q?x6EXVoM12pc/WL95IgsgzBCLX8uuFd6g5uJShA96RMv27tl+MeVVV+krvURj?=
 =?us-ascii?Q?p5p5xkkgZBh60s5MPzu+Yy9AE36uoGY+2PZSL8XGDjOdrMlYBFJVqV2CAbzC?=
 =?us-ascii?Q?eT5YtYqglQ4jb0B2+xlJQVMPlH6skTsmW4GGlzbFVkhg/f858hEeAB7ueEEm?=
 =?us-ascii?Q?Xso7BAAKys/BkTt/JpNP0v43BOdbu4UB4VzBuj4/iYXvzoR51CTPfe15nv+b?=
 =?us-ascii?Q?ayWW9gKGf+9eqEZRqvMW/9wNRACLjTm2qN6rRWcwShsPmdPn8KahNsed+KRm?=
 =?us-ascii?Q?qsewKZDkCOfiMHMEaN/rglfeQy3AuNhz6uGfsS6I0yBQh3H1fUHHtwqdkl12?=
 =?us-ascii?Q?5wGDddakVhv+1nMyBuhO/YutJapoFxmbFkEjhrw9FmVTGEHlqWpEtZ5K2KxC?=
 =?us-ascii?Q?H1FT1ADeRnRB5D1EcaEE4WRwGfBsP03n4DfYOtBHgwpefzwSufMQkiPdr0sc?=
 =?us-ascii?Q?LTd+SwGa/6Auz90+fhKoTGbVvfUAJdY0DYzy4MZLP8R1sh//x2ckqBl83RGd?=
 =?us-ascii?Q?BIa4Pr635xTFEVgCXRE2PCwIoOfAUOnScY7BFL8n6TnqZOvLXYcnITrjazdt?=
 =?us-ascii?Q?rsn9LdKGWj8KFYmVDPptolCjcIYkhXzDtLJ4tXhsQs4yvwiMU1bE04UfYp25?=
 =?us-ascii?Q?TzIbkouPCCw89HqtJYV1P/AlmDnAwm1LCHZ9j2FrZ534cFnU1Q304WQHPPyX?=
 =?us-ascii?Q?jhVIh88ekF5uGNs/k3GrXTDGRUeB9HXnkDfYnh4aijXFEPg8ffcGCUiMS+oY?=
 =?us-ascii?Q?3D09nMckj4zkUivcdXUGzrVG0Pd1PiTBfi1vYKncBMJmMeMa+qfdCDPLYzJ4?=
 =?us-ascii?Q?xSLiQhyRRuoCGyUxmU1U0TJ0e7GaLC431dCNXKV1DRd2icxQ0dN8HowJMN/s?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqxH0ugILNVUs3AX1gc4pZ01Pel8TJxZ576VzEz9M2XER7WOKodLjFDOSWmTmhAlqGandYyrF7ZrNLMEdoWXDX7x0pICvGD5vJbtlT8lMeck6ubx/zjMIoHyYBaJtqkXtUm5dU4RfTemVixE63Xrfuswzy0EoE/XYQ0w7bZPe2dA9VktY7bgW5llkL7mG36g3JhCPRfVrN2zAXq+9/yZ5PbHdOzLwlYQzuSCi1BVfX6GZqgGhc/3RRgpno8N7EKAAa+I1vYUYDSLzUGpYoQl4SevthJkFQpl5bznI8/5MsOWLHwA4hldNjmPP8avqkG/n5O77LBAW8WSuYGmBF0JG6bsP8/oGNq+bwGB9LlGh+SXx6H2wGWfUFxkiEv1SoLzMz+9NwN4319CeDmXSjXdvwQ2alXdWsv/rZgyYlJf1di5PUYqO3WJ4lUb7b9jzUBHiRlWSAOsRUWs5ENU6Ps5hYnkaVzqoPo03AwX+/Sucdcn6iLO0UzqnYymN7VGaJJUbiKu3RWnSVOBNsYvUyB9+F3h2Dkr6/2oLJ2f4md79NAvhKPDZTLKj9lOdnpdRa8b195haTiB0zM5nbv6Le9fauWZa1qgoBn3OJ2NYNfDXzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a98b30e-76dc-4e7f-bc29-08dd8ee5b491
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:38:58.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m2oZiVmg1z1wk4rp9Hib2KSJKdnKdmq5/eZbrWqdJyqk0oClo2KJadcbD0cw2e7ZoPt1LcLhOvnkvEbdwKHM7kZ/iGuUvQBnqvm++uU98g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6ABE13187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMiBTYWx0ZWRfX8P93LpJUyOt3 XZsD/IjvJWqQ5yi+fyPGddZGFCaMKv7fbWn+1BZWqzfKFASEKOUFP1YNKD7Z/27WyG/Vge/RTdy kiP/efaZHvs2XJzSRITvlDnJ62jfvYC5Eyo2qo7v19nOQ/c6z1zHqc4mXHMkgCvhsV2n+72fsID
 a8/MGIh115nMxxTpQZoB9RjjsKGJ29tqWadZM/Dqi9vnzmNtKCJDcVMI3DqHDdtjrYq4j4O4V2c zoH6ILst+ajyBRxL9ZpPIKzkBnj5bGUN09DkdnWmmYo/4INdOnejYRXnQrSYUBqYfVhldsY8sQn oMsjiGKpt5I86DjCEANl+kT2zIM8cMVaFmsEIbNL5EzhZgCGfNpR7m6XvnkEl27yNEQz5yEFPIc
 q1+l7hHflYIt2aQz89k6sQGRiw3+2Oczj5ULxRsCNbPcq0swKWPq6iuMZyDKp3X9dvgMmqto
X-Proofpoint-GUID: VGdMNdJ9sGO5uFT-cwmfB5JjNOGxGfVf
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=681ddb45 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=bjTggLQhD0snZX9suskA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: VGdMNdJ9sGO5uFT-cwmfB5JjNOGxGfVf

On Fri, May 09, 2025 at 11:45:45AM +0200, David Hildenbrand wrote:
> On 07.05.25 13:03, Lorenzo Stoakes wrote:
> > We have now introduced a mechanism that obviates the need for a reattempted
> > merge via the mmap_prepare() file hook, so eliminate this functionality
> > altogether.
> >
> > The retry merge logic has been the cause of a great deal of complexity in
> > the past and required a great deal of careful manoeuvring of code to ensure
> > its continued and correct functionality.
> >
> > It has also recently been involved in an issue surrounding maple tree
> > state, which again points to its problematic nature.
> >
> > We make it much easier to reason about mmap() logic by eliminating this and
> > simply writing a VMA once. This also opens the doors to future optimisation
> > and improvement in the mmap() logic.
> >
> > For any device or file system which encounters unwanted VMA fragmentation
> > as a result of this change (that is, having not implemented .mmap_prepare
> > hooks), the issue is easily resolvable by doing so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

