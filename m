Return-Path: <linux-fsdevel+bounces-59267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D8B36E9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515C146172E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4A36999F;
	Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dAaLmFyY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I56ef0nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A02FD1D6;
	Tue, 26 Aug 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222901; cv=fail; b=RdWTZTiN2ANX5ezdVY0qSFuZTQ6SiCanFex9ZIgSVFXEXzxist1eMXOYKn1byuFCL1941s5309LOj9MK49CReQpUiYej8gR5tn0k9fZdt79j9eycBE19I0LCMI0p1kUG7hkefcf7x6BMrEibWsczgA7iL4uviDeAhY3jjgup66o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222901; c=relaxed/simple;
	bh=IVbSpcyFdI6HTnOLUaoZMZX6XbAK5i6ZgTw5SlJ57SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfjJRxH46pHXMIW0M/YAvs0lFArBB/jVgJ3owe32TLc/WzVLxPB+SzqG+3em8VIBVYlRlgBhXxpAix7aTpblTc7pMyM/r5DGuU3oGkj3r8fLOwm/v7c/kuJKzq3dK+QPsFcWuT8kcwW0N98KcvDQZ2n7Z6V1I27jYAzhpY2Fhag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dAaLmFyY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I56ef0nv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFC8BM023697;
	Tue, 26 Aug 2025 15:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=s3hpAn+nLBChFlTUZ3
	dlcmuGTS0lisTIuTe6nrFXAaA=; b=dAaLmFyYzrpQDTJUZBN0Ddorqen6sxx9jg
	c/eNrEXcyIbAkmSqB/nVPDgo86TfXBEOYQclkJqM5LrR4urBvuF8ZwpkwwTO8fDF
	jykaqRmGowmNdUMNI/Zo4zkG/p5ZY7GNNn/xbOaQ2oPtAz6HlTJCB5BukpZoJq6M
	TaPabPGjqNuaDu0k9prE4Mx7jllfOy7HA5k5Lrl7lGoAC5x6zwCapwnSOYc/hXGl
	SkWIj68UugpjQPpoeu97jOfEALqgd8lyjDd/CgZXLxPx/x1WsREvM7FwmPEvWsEY
	3QCiJ8s+aneB0QyGK0ymprqjXwO/iu2eZPdQmh8NJUh5tTF0H3NQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s4qey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:39:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QEhplc014573;
	Tue, 26 Aug 2025 15:39:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439pase-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZgA9geMEz4rpiAXzmRjW0GOEiPdkNwDdk13WXApjcZrb8BoQuYiJJTt7wJiW55FeMCQU323XRimFzGqfFXF1CDFdHCOsnztBpiLlPhmTBqA3mzpawQ1O9fftLzSdISK2WD10wSFPcRtrvLahqIK5a+tuQ1qVVdqqv/3YeqFs4GXMx0ZSAZtdsi7CHmPQONpO6QlSu7E9MJVFHzxVElcULLoyaGWzPBt81Mp9iXY5W8wNYQBEvCbOZuT0lU+DsLbmgcOxchy22YHosBuMY2DseCFxdXsHlyjxPZrZu7PR3QSyzyVAB1Fj8kyK822DW58/8H3s3uP+Blt0HGHf/3R7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3hpAn+nLBChFlTUZ3dlcmuGTS0lisTIuTe6nrFXAaA=;
 b=yWb9TNZaXYBFAlCRseUmaVlNhS2ysjGeRq7A4F3H5XMLe+T6rwL77Q92Ye+xU4fmeDmWn8Gsm5P6CGgIDaNYRnvHAuKdvqBEShmt9sqoK5jdtwB7YkIx7LvqkeY71g0PnJfQ9BoL/+1jpI97Gbc5UDsaHVGurHZFzByeXne5El4NGihWYdHBGMMW83IXR64+qFI/TNPnLPsgftyZHE1gZ3bM/kTlL9NKGe/fyEaHGQste+vVyXDSG4oCJTnyfrFwUG7/LPAHTpZ7AdhbRsq22P/vAbb4ibQcoe+LS5xX5SxOFPWYn1Sa5HIXHVsW3OzmjHDxW5vq3BSCFLT9j+oLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3hpAn+nLBChFlTUZ3dlcmuGTS0lisTIuTe6nrFXAaA=;
 b=I56ef0nvkLem3gq27PaPECisPOswEtZkQvUfj/iAhn+xKYuI/UGtbKd+U0bSjzb658OvKGt5whM+dzRya2Uf7a32MB8+m/REmMMWYzo8j7zR2yCDON07zmRYSnF/ZRX4PdFxcESkXfSaEELCOlPPfQtbmcQLFLh9CXtA8g3h/dY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 15:39:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:39:41 +0000
Date: Tue, 26 Aug 2025 16:39:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
Message-ID: <9e7f5149-afb7-4e94-b231-78876c41a438@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
 <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
 <d4f8346d-42eb-48db-962d-6bc0fc348510@lucifer.local>
 <d39e029a-8c12-42fb-8046-8e4a568134dc@redhat.com>
 <1743164d-c2d2-44a1-a2a9-aeeed8c13bc8@lucifer.local>
 <e91f7a38-3b17-4a0c-aedb-8b404d40cf59@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91f7a38-3b17-4a0c-aedb-8b404d40cf59@redhat.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf07b97-c374-44da-c2a7-08dde4b6c5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FnAc8Q1xVxvNejAPq/29FCdC3Ksw4gAruEJGoCGWtxso9XZQQhJ8z4TP1abr?=
 =?us-ascii?Q?tffPHndBPyTCSmCzDSrxudJc8OhKFd85h+gOIh8wpxlJzLiH9VwgyYTbr4Hd?=
 =?us-ascii?Q?CZT9JlVsgZ0XyHCDv2VvwI6Yv3kjqIwdN3FkNI6vqyb4P0wEmo/MPN0/fctW?=
 =?us-ascii?Q?fUFQXkMCgq74HcOpgt/6XFlh+B8FAd/QPwonuhS87V+h+ifv34B/WRMD3mD6?=
 =?us-ascii?Q?YtjMYLDzMRCQOzWwEo7ipOjFGZ/LH0CmSWYQA4YnCVJv48fjNW5+JbwQS0Us?=
 =?us-ascii?Q?QT8ILb4fH5MOO8G1YptnowL7OQbm4vTBR5Z9SL36wdBfSRJz/wDf8bsiuLOY?=
 =?us-ascii?Q?E30oEkqSV3h4iMtZMWHmU7V+N7915+m502cvwm7XYTf50OFgbvHYePk9hJyX?=
 =?us-ascii?Q?x4x//anWDIJaYAVjhQeCQGjjvr7zdSddpcry6+ZFXe3ef6fzhWdReHEhSVIb?=
 =?us-ascii?Q?yMJbVKBIsuXFsbc3bwGe39UedIDtQ8pj/dqaS4F0keCJ3UCmRpwHBTpa0gpu?=
 =?us-ascii?Q?AIxbi4gN13YNyOctpexbBmaASYrPzsg2ZQOF3jJzH6XAqHXE8T48wkvojZmt?=
 =?us-ascii?Q?warrgt/Cv0jIz5Cw6lCrqjFLzqhWEuoCiRwL0Qc/tlffGYcdgf+ipmtwuef9?=
 =?us-ascii?Q?C+x+dy896NdduZwBa9SyS+SQVDGVTu0H+uXNjVUjG7nAegRCwa78KbnWH32U?=
 =?us-ascii?Q?wvpujXGIguDQr/209So4CuBcLC8L5ruV5A6sU0pK8JSZ1hR8zodktThyreqo?=
 =?us-ascii?Q?j968Z7XDu2bfJ34Eu9sZFuXJ8xOG3Yi1bI6fHHZgXwTFnq689mrO+WgiH17Q?=
 =?us-ascii?Q?EWjtwmGGbesFPSSqkckoGvxHg2rJbbDbr9HPEMdaJL6YL6ral2+0VoxtduPs?=
 =?us-ascii?Q?QB0d6TDO5FnynR8etMoMEfwTVY+t++SRxrkPYdM1KR8cajJEbpmrEbg/ptKv?=
 =?us-ascii?Q?hyV+Pf82qUy6Y7DcsZRrJZRSvjTWK/2t8m3aHG6eH7YYNaeWwpyk8Bvn0G50?=
 =?us-ascii?Q?m+ePy4KLGmdYoIDGEyx/aBl8kbjCC7aEYzdRN9VxCiCL/lQIPZ2+tUVCXrcl?=
 =?us-ascii?Q?vNpPDEl8vvjB2I/AeGM/+TTJxPYdSzznesjLq8fCxWgYTVYD8JItdkJL8wLJ?=
 =?us-ascii?Q?HCLzFX99LpNTWkcad1PteTrJcHfBMjux+RPTWivqp89yFriNo2uhR5tx0ZUD?=
 =?us-ascii?Q?WhDueHUOL+VIrL5DszXkkz5x0i8e1bcc9a/VPbMP/iBFmUZdo9ex9ZbniKTq?=
 =?us-ascii?Q?wt++d2mJMBCjkN1AObMDcJOVQd7o1LMkR+H7CHmtjtyIw3OAvg0gCBinFOdm?=
 =?us-ascii?Q?+bKCxzHr8se+NMoMSKNGe88LCEjZpCOUqMQv59NyWlWEEzUoHijytHsrqw+k?=
 =?us-ascii?Q?XbRkYLNnJwMWKk15bt6Ewg8JE4gl7LR+X2ZVXKag0/q8sJIQGYmQGEr10JD6?=
 =?us-ascii?Q?ivFyyv0S3KA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9hpr0s7AFSUgAPEAfGJj0RD9Dk5IKfZhYeaarHko0OmU5hhTm3SrzW7t80B?=
 =?us-ascii?Q?c6KR/79U3QkcTPNGcssVh273xipon6cYz/zm0VvrWp5yZFUp+lAPv++tsEMI?=
 =?us-ascii?Q?ljk8T64wIpZSvpYwp+e+YZGYr05G4r/08JgknxYjZ5wRHBzFeNiHEEQWgeg5?=
 =?us-ascii?Q?fJ2MhkfmC2SvUbv5fwU98uI+bFr5K66PkKckHYd8oeJQsntSJfu2SDANlvMv?=
 =?us-ascii?Q?/Nmdf++DC3d59drcxLKRqtEvMy/CShb2XQm/dYZruFyJKOer/ARmE99YsrUR?=
 =?us-ascii?Q?JgAklx6Qbk9kMOhMNu/NmjHQGgSykBWuiqgZcVCaKT7eA1CVFcKpJ5uTiy2/?=
 =?us-ascii?Q?9CEarzPuMKKIVaWIX9fys8VJcnQ5zVvczF5SRTyDplDch81feB8gGv3+AnTM?=
 =?us-ascii?Q?/OFvoH6vwJ3rtGdnnxWGVuKR32MsXGW82n6w0D80SFsvPzCX7YQ5x3VM0GxP?=
 =?us-ascii?Q?9kbvT7tXemlJl0L4evMgWM+oIX9v19dHbIp4qPw+46NGZL36g8fzmPH2sBp0?=
 =?us-ascii?Q?zQf+SQcRPkCiHXKBnKZp1F6xGqVUKUpkjVnLlVD99VWH8xHkCip2orq5r8CS?=
 =?us-ascii?Q?dz4bnN8/wmsxAloTsSp/I3pn/BX9nSKmie10tVBuj9bPWW9CXYe+p/ivU3q/?=
 =?us-ascii?Q?m/9Fjo2/CSUT9Vaqcl+QulSj2rdfl8jbXbJxQSjLD5RWU7ChEJ2UrHdM8A5b?=
 =?us-ascii?Q?C/Xwv/7EPzOd9cnAU60Gxqt0rVgmjt+Af5K8yROJqtaZ6vgR+N8BjQ7+nbV9?=
 =?us-ascii?Q?NzfxMcQRMYsiyZOzb2a/Cn1pIDbl5BJM9MHuYx29sFYY+oTgUxg8nDKoLKch?=
 =?us-ascii?Q?SuSrELnBJ3upnQ5+jgzm94WstCSQEYcc3lDSNN0qiL5Ulk9nBd8hw6fFe6kA?=
 =?us-ascii?Q?BiAi+W39FNzlUbEUZkSp/DL2iGhfBnLbzvqZw1oB2SVE2hbm2JdZRCTbXTVA?=
 =?us-ascii?Q?kDa7VKL3SJw2iPxCxQTyczmpF2ROgisUSL+dFqUkhs8+QMDAzFCFoiL5aSFK?=
 =?us-ascii?Q?teKvpht5qEaC+qzvN/4rjTgBPWSuHx3bSBpDekt7OxdJ7Lj6boaRoWzrjMR7?=
 =?us-ascii?Q?LLcoriPtgRcucMxEbdsqPbsSuQleNa0S6qW6Iz0hugwRTZNIYPUrUj1AILk6?=
 =?us-ascii?Q?qub+KS3l7TztwTU+EnueaAzZbaFiI13QU7BtfSZ8/TaodrrVqSgmxFF8K6Li?=
 =?us-ascii?Q?CCVvM/rO4cdhZmfb7xY3lpaM7RiInklYJCjK3+/Brhj5CLRAaoLCwDP6jD2k?=
 =?us-ascii?Q?DgKt92Rn2mUS12cU98OqeWK6ZZH2f3YfBpyE9UWeNhY5M3GKBkTrpsurNRlx?=
 =?us-ascii?Q?Pzy8TuDAvJSkQT6U7ZI3GidnxKX2GXiaZCQ1FOe77FoCP0T6bNp86Z31c+zT?=
 =?us-ascii?Q?kZg+gapCIOQQR5O3hIiu1+jz3vnyy27nlLUwFjz/TonMg/2MamOzYfcX+8Rf?=
 =?us-ascii?Q?8JfR+gR4zwTDWJfrKjTYE1C/qhxcomUwT2P1XenDxx+d1agveaKgoHWUbfVv?=
 =?us-ascii?Q?qGNGb9BF3uGT11Qkcyg3SNmMSb8DWBuRF2k/mqXR+iwtNcCoaZBYYmyt685c?=
 =?us-ascii?Q?SikjFuNzYcZ+wb4do23vyg8AMVT0LopAwP4OXq8j4xDzCVBODTZ+Kk/lPkIv?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iSYOFokJQ1nMBjZMSakAT5SbKoN1vsFm01jVcTXLz04ncIuttbsboUL+Qodd3jmYFlQmp3nX7hVVxQAZ5RcRRv6dkkToUoC2Nt3/S585MCSHIbENXRIt6I1E7DByQiuPQZ3e4+WxL32pyhVTp8cSpTDYTm0SvJ6lCRRSnzkhzFKRyv1hlOLjGDCXzRjWruXbakdGH9C7o1bRrGAUXY6NN5Xailml/7KgZSNB0mikgjdJkybOHkd3CwHowOjp+Qi6Ew0t9ZryH1kiXiZ+TTCBCT/gxtnt4dfKSJMDLpFLRPj28jZhj0xkgX4eY8F69tn+PqMgIV6MTJFIVfW4ZtaWI6bYXxp2jpZdRJ2VKaxl6Ct1APmLJrF0345VP2VOcZw/PtvfRldILdjj2Rtn/fMzc/V1IKDGv+DgTS0716nknpPd5xOkMl4Yq6Xkkvxfuo5lsMo94PdmRLJ6+MeJEKt8sZHa8kf9z1m3SNgHmps7ROsxkKL84a3iALXfHylQVZNO0lJbKGwmF7zaPSSqASwiA7TiHPn/NQizbXqE5cY6SXrfObVi/Yp4NB6r3gBky5MkyKmIVuVoPSnfBSM8flyFC7l1cG3gavrkv38kDshNNdc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf07b97-c374-44da-c2a7-08dde4b6c5e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:39:41.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxsEGjneVnCk1mOkT5uNv+rYMu9UCiK61VMVk0a1AapxSboIwq2azozUUO0elHfL7mtfQ9LRLN5/7n7CJtcXEBq7RjVpKxuuLd3i4nDPMKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260138
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68add542 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=n3WvvtQ5RJhdEwuKYYcA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602
X-Proofpoint-GUID: VSLXKvM3LlXKcRNyEu37rDtsFkrcCRKf
X-Proofpoint-ORIG-GUID: VSLXKvM3LlXKcRNyEu37rDtsFkrcCRKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX8Tjq3Fku+NVV
 BbTYB1Gd4eiY8zpJ9hD8XP2BRlV0KLYxWO5QA2yHlEa2ERrwOpvEagW1AU4VjcGUytQCYb4F5tC
 HLCiPUlHT1PEhVJRNzMClurD3v1wtwl0Q25wH8eCgkY/Ly4RSpgX/dQaP7POOQG7p4zm0FKC4Lf
 rl/avyfFjzTFpfIxDFWRrCmgBL5Cv9DzQnBKzXz7QnzUi3WIflOEVdU84+zRRzkuiUkhmyJAWAS
 wxej0fa113ipA41cNxvy90V09r+gkTobZsL2j7QgaePFxfwxpjQrIqMBBr5oYg3c96QyZy48R5p
 uG/c9ckhBvdXbghIc+YCtBiZkr++pbZChgSQ4NeElGaj661eG85885UH4+E+SjrqEwptP2K147m
 3mPz3FJLZpIv0pqTvTudsskEIKCWAQ==

On Tue, Aug 26, 2025 at 05:24:22PM +0200, David Hildenbrand wrote:
> On 26.08.25 16:32, Lorenzo Stoakes wrote:
> > On Tue, Aug 26, 2025 at 04:28:20PM +0200, David Hildenbrand wrote:
> > > On 26.08.25 16:21, Lorenzo Stoakes wrote:
> > > > On Tue, Aug 26, 2025 at 03:12:08PM +0200, David Hildenbrand wrote:
> > > > > On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > > > > > We now need to account for flag initialisation on fork. We retain the
> > > > > > existing logic as much as we can, but dub the existing flag mask legacy.
> > > > > >
> > > > > > These flags are therefore required to fit in the first 32-bits of the flags
> > > > > > field.
> > > > > >
> > > > > > However, further flag propagation upon fork can be implemented in mm_init()
> > > > > > on a per-flag basis.
> > > > > >
> > > > > > We ensure we clear the entire bitmap prior to setting it, and use
> > > > > > __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> > > > > > fields efficiently.
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > ---
> > > > > >     include/linux/mm_types.h | 13 ++++++++++---
> > > > > >     kernel/fork.c            |  7 +++++--
> > > > > >     2 files changed, 15 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > > > index 38b3fa927997..25577ab39094 100644
> > > > > > --- a/include/linux/mm_types.h
> > > > > > +++ b/include/linux/mm_types.h
> > > > > > @@ -1820,16 +1820,23 @@ enum {
> > > > > >     #define MMF_TOPDOWN		31	/* mm searches top down by default */
> > > > > >     #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
> > > > > > -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > > > > > +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > > > > >     				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> > > > > >     				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> > > > > > -static inline unsigned long mmf_init_flags(unsigned long flags)
> > > > > > +/* Legacy flags must fit within 32 bits. */
> > > > > > +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
> > > > >
> > > > > Why not use the magic number 32 you are mentioning in the comment? :)
> > > >
> > > > Meh I mean UINT_MAX works as a good 'any bit' mask and this will work on
> > > > both 32-bit and 64-bit systems.
> > > >
> > > > >
> > > > > static_assert((u32)MMF_INIT_LEGACY_MASK != MMF_INIT_LEGACY_MASK);
> > > >
> > > > On 32-bit that'd not work would it?
> > >
> > > On 32bit, BIT(32) would exceed the shift width of unsigned long -> undefined
> > > behavior.
> > >
> > > The compiler should naturally complain.
> >
> > Yeah, I don't love that sorry. Firstly it's a warning, so you may well miss it
> > (I just tried),
>
> Upstream bots usually complain at you for warnings :P

Fine, but it's not a static assert and they can be delayed.

>
> > and secondly you're making the static assert not have any
> > meaning except that you expect to trigger a compiler warning, it's a bit
> > bizarre.
>
> On 64 bit where BIT(32) *makes any sense* it triggers as expected, no?

It's not a static assert.

>
> >
> > My solution works (unless you can see a reason it shouldn't) and I don't find
> > this approach any simpler.
>
> Please explain to me like I am a 5 yo how your approach works with BIT(32)
> on 32bit when the behavior on 32bit is undefined. :P

OK right I see, in both cases BIT(32) is going to cause a warning on 32-bit.

I was wrong in thinking (u64)(1UL << 32) would get fixed up because of the
outer cast I guess.

This was the mistake here, so fine, we could do it this way.

I guess I'll have to respin the series at this point.

