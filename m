Return-Path: <linux-fsdevel+bounces-57541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12CB22EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DD51604C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0E2FD1D9;
	Tue, 12 Aug 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCYb1Ohw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XM0r9QuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BB2E8895;
	Tue, 12 Aug 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019556; cv=fail; b=YHbpYr4apkAVURnDhEM4FxJvWXvG2TbLAMe0N7tE9EGh09m2Cj5ePdrL7Y7jseNwwvJJB386elSmUZvj5g+OY1ilfPy7HeOz/Zi8ZdcGTP0leUKY3BfFaIDsGBClBAVv/ez5DafwRom2tViCGuo0GQB3rgBx9t6ZCkKcGnZmZcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019556; c=relaxed/simple;
	bh=3pxYxyk2JKv+lXdDSQsI70Y3Znj0xhaLXrRyEKzhBFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IvAW08DKtBo9xpGJUt/W51j4s+ZzFOI9M4hJPxUlcA+RhJ8PBkLQtq5VPzmHGxWJburyRaH015uXPBX206pUbUO3Td2xQ6miuZLCw60wS1pv/qOeO5BhIRu/cRfphVAP5nH4Uk57jCtQrIWmsynJ/Xp1imYIZKm0ME8rFuDFj/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GCYb1Ohw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XM0r9QuL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC6vn006392;
	Tue, 12 Aug 2025 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lIPbGxUBOEImxVCZhZ
	OQHsc6Rp3lMg/SywUmYbTisDM=; b=GCYb1OhwVK7W9HhZAEtkth3jPy+WWTpEtU
	/ntREWf475nQrGr1BFIzofAN04ZbtbKEtoXXRAFaTJS7DS9ffz5lfoMICwi6RL+2
	VGABz9lvcRFGQB8WcNRqHHckknLeE5KceqiugYI3gr+B3u7nWWX1N5Hj5xgLekq+
	4Sb9yMzwBgLmAlJwkkS9eHFhei7lex+25amreVPnl+NSvckWITNDliPX0Ufq096x
	f77LCD6aXyMpMe6ScDFxh1GNSVQnkwHEjUH3Ik1ajZofTxKLsrMNn490QK9SCSOu
	EAamq+PO29tHohDu+maRN6ghAndW7uxr38uIz0K/X8REvIdb9Edw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dn4t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:24:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGB0o6030163;
	Tue, 12 Aug 2025 17:24:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa8xc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keOjakNPO+c2SyjtuQLZSThTsh0b+a2HFtPm1bHfmiOKfRw9TE+OP5vca/HM26p6ZXhxio7tzOI49v/BvzFSEpPONlz+ynjJKOdpM8IZWlWe6xU8KBdRBXb+0GmB08FV91Jg+3osH6YQeuonXigr5emhRLLiGePiVXKKPSKXe5WS47Z2lPoPnCV30c2QVtYyVIUvvX3J5EujTuuI3JmiPXsymO+IyRYzWJDp6nHue9Tu0fHyuJFBrjahjH8mW+guPDOIuDKe40jEmOZA4JTtnrBdTSl8jIDwzJ7DpfDw01QOEgEbWQ6OHE62PWIF6PAJwSJwxw+TqyL2FoAr92R+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIPbGxUBOEImxVCZhZOQHsc6Rp3lMg/SywUmYbTisDM=;
 b=bxhPaxLdqwE/CKt4YADaOGJ6ObJ3yK9OIZBbrFBXWRriIXtFCtZKtWN3U3+pzRBeiVOlpVJeG3uyuxkGinm/o8BnM4w5RXwpkaAXp//E/ldOIBgyIcI6TaVXn5TSG5VM16H1d0y/Ty5T0pRAjWzyc4tooKF+WzzTlU8r9VydzhwSQ0zu7dV8uWqx52KVQTsUErlv4tUhJBdmPYfcC0XFbwZt7J6aFG6a1/g+iow48VQH+7bPV316DLuNTqrBfijJP9urcbrX2D5vuz4W3bT4pTRlmDQTiHN8EbDDK1PPMMU+cm7iRAgjLNmo9X4u7ikC7cGLdoAERlPgCufpBtWgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIPbGxUBOEImxVCZhZOQHsc6Rp3lMg/SywUmYbTisDM=;
 b=XM0r9QuL5iIAg1P/G/nxRwGISbBF1vHKMP/TCEfUohWyRG/77F+WZ/bXTdzf6Jc3jjn3atIz9js05vyR56iv7+122tyM/4DEEuTtqP0v9T2sjsO+PXMcAbsurNUqFWgV44HC+TfYqIuuY323L9C3C1ut41F0womjXh4kmeWgfeM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4327.namprd10.prod.outlook.com (2603:10b6:610:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.24; Tue, 12 Aug
 2025 17:24:53 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:24:53 +0000
Date: Tue, 12 Aug 2025 13:24:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: Re: [PATCH 05/10] mm: convert uprobes to mm_flags_*() accessors
Message-ID: <yoxxpbxsyyzelu5gyf5zkjgxusecbutujydn4lw2ubvphtlu4z@lxvv4xfde42g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1d4fe5963904cc0c707da1f53fbfe6471d3eff10.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4fe5963904cc0c707da1f53fbfe6471d3eff10.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 77604366-2d37-40d1-7ee7-08ddd9c52614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcDdbHyIIAsSnGzm/h+eJjuR75LCS38xUe9D7g4CYcLR2nUnajb5W//fzob7?=
 =?us-ascii?Q?xAB6EZXkAKjaskIUrpA54tmOvwYVaK5izwbG+gvAcys0WQtPg2h52yWMwqkR?=
 =?us-ascii?Q?3t4yQsDM0NMkDFnSRkxcKFcm0ta2ZCLr8WV1kBCCm8DV3KNV37a+cxWegadf?=
 =?us-ascii?Q?Kd4fRPFRLZyTD73D6RwUn6P5uYadF2AIw+Uy+fcEtH/uTtD13kpQYW2BNp9M?=
 =?us-ascii?Q?U8611/He+AvBpVsof+JOBERBzYWLmmUY/ERjb3HJOff8A5oTGJgiEdTx8ALi?=
 =?us-ascii?Q?kmuwIQHxviP5r/KHKXMr9sdnCNFBkQqw78WnJtTHvNmtwJ8MG+ztG2wKYzkx?=
 =?us-ascii?Q?IxYY7YXZ7IZrpkiSpYSCc6/cvSzSORnK22NrFtNbASHY8c9lZRmo0lHoTNkL?=
 =?us-ascii?Q?H7MuoNGmwINRbRaolwb8wbfu8M57VlhPoSG3pVrqNypDlqc57Epm4Vjmfe0F?=
 =?us-ascii?Q?vHJUklpm+Vbedw1qkHx9qyVRNBxecifnWm5ladJugDxx3k50RVaIgHuUfb2Q?=
 =?us-ascii?Q?1faeZj20B0Tzszwatc63Oi1+AZDKCeTHFsQ6zU5y1ZKfq4QCIJHHpW1X523h?=
 =?us-ascii?Q?3WHYSSlnpILJPmfRqqwSAiZlPCyyKeTVW3wsDK1FreW/EHXJAvNTdMFQr1IB?=
 =?us-ascii?Q?TLfp4kDrW2iLHPRUvNmKEQ6O6muP92JwIzvg9U98DErHMTLICrz+aVjJu6V7?=
 =?us-ascii?Q?kKhLQ2smlP68PWzLu0UzOQb6EX+gGqKrj7RcM/QXCTMzGne+P2v/fHuSTPeX?=
 =?us-ascii?Q?vPPduBYovw0Ro1Bf0hyw5qsaakDJuauVFMAGMLEQ6g+QAFik/6gYPwKSmPaG?=
 =?us-ascii?Q?zR5OC8oHrLK/XTSF+nxkl5kE5g5cv6y/Ycj2OPm8g56G+5Gt5WPjhPpupgEo?=
 =?us-ascii?Q?tKgdOEeutitW/ungLILLSFfR6aGHUhz9uNIPX3Hfg3krxXfX/r5gjBYBtqNi?=
 =?us-ascii?Q?a+UnAp2PwlqDuvR+kj3nLZ1pBxvDueipi4UielZKVsd/OTZKLYGBGsDlTPeV?=
 =?us-ascii?Q?0ABUr7eIXhFasJShqEHvsMOYavHhgyQ7/Kq0jTDc6OArOC1hXnpMsDG5wlw2?=
 =?us-ascii?Q?uR3qPzxUD4RMzZLQXBvuXM8UV9V4JvL0LYnJGKqJld3CUxcycy7hWzDA2Zlg?=
 =?us-ascii?Q?j8pecOUIExv2YtArv2jGh8usPfTVercJH+J0+drj1FtFrs5hG6fc0LyDZJ2L?=
 =?us-ascii?Q?L4FUXpNQOopdmdwTQzChIvU/4VUx9XiklDbA5kwBNHN9Rkmsu0+uX1AMyDyb?=
 =?us-ascii?Q?bou36lcTNcyLjjxBIzvOvKFVcgFsxWbW44AZl7T7DL1vOe2/rb2UPhnrp45Y?=
 =?us-ascii?Q?pdC0NX75wl3cC1n5dtPM0jwDUPf1l2pUknU8wvpnN/yPQW2QEbXweKQsP1e9?=
 =?us-ascii?Q?ky9C4ru49Y/x+N6CtF2GZYXDxu1jkHmsZDY+/oDL80kCc52io/qSyobRiTbf?=
 =?us-ascii?Q?k38AjNuH6zI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHL8gGH7S6jZT1XBjhJTcHLN9Cw1w5v5sYvrS1t4sz1NlX3I5Nw9eBVdNujT?=
 =?us-ascii?Q?U1rzU6hPYhoMhV/SFFo17k/yqWugf0N5pWYolHLLLDxp1nr8VUr43fv3yI/H?=
 =?us-ascii?Q?WTjmDVXOl6ETH/l0SsUKixUcs65pVg39Xk8aWj82N5jYcqZqTItX0UcqEbvJ?=
 =?us-ascii?Q?Fm1sYCE+ygDRqtOoQNHgBEQQAen3adSyf8txubL9YKkpPij+2CN18/FmN1fl?=
 =?us-ascii?Q?rT4Od4CQYnrMA2/uYTtB2cFjLA5H0uhK4y+mvJp7oWTHCsjK0EUp7/qwVN7j?=
 =?us-ascii?Q?D8KoeRN2MuvoE3c+v4ZTW76YLSux1VWPUfH98RnJBcHI4krQQLhmn911fyNn?=
 =?us-ascii?Q?sTEYwPWgAfuklojssKHzqUqLkV/JeP21LB2DhmyTO8p3OUOXiiCNHLBDsMbB?=
 =?us-ascii?Q?WsDa1YVJZOLQFE8hYOsTsqgN+Gm5Wt7bLN7er1qvAITTYoxHcUzNmuknsjEc?=
 =?us-ascii?Q?Li6pHPBRFtN34PjKvMFjWVcKtX3JsE9mfU6x6BX4o9aPrxSjvfIQ3JAucgHo?=
 =?us-ascii?Q?XwziV9yr74T7OASSWYFHg+l2CsmQIachry7M7m5Q4CBe7PcJookQtm4Ow1Zi?=
 =?us-ascii?Q?0SfNCbVtoGgrXLQI9IWLSw0M/OPZH7h13rd/EDmiDW8Eg3ZLmJobkevDHKCJ?=
 =?us-ascii?Q?tSUkY5ekYc4EJ6QwMyOGwA8fAKjCVFCwY66UuN61XOhhfaDMGDijNXkMVgv/?=
 =?us-ascii?Q?BVdizGzcTSNC+piaCnkzC8LGP0OkV/bqEtBLHX0oHOTwITQ0dfTGcFCsdsqU?=
 =?us-ascii?Q?ZrzQDL9zhYy5IuINzaYXiBsEC0/aop/+jriRX7k+uezRQbfKjsbgt/iXVl+F?=
 =?us-ascii?Q?oULn8OtcLsdaotSvUKE7h4xpZaBpdw3+F3HfHag28rE0slYml3Y9AR93ixRV?=
 =?us-ascii?Q?brjZLDMml08wqA76jZuZZSufMhiwu6vneRQURUdjp6pr0YzClLP+FUychOXD?=
 =?us-ascii?Q?BLMlI9FbO7uBGf7ijQRvYD2wKDNIKPlxZ5aCfs9RJyWmp5eEk88zLtccLOb5?=
 =?us-ascii?Q?8nWgQ1s1R3/XG2EMUjMLeyYuIgM30gls/d5ZNKS+3XwC4k1zsjWi4+HuBC6j?=
 =?us-ascii?Q?5x44B5sHRAPxTaQWT1w+zUNxa5r9tLyQrqb0mt3Hs6Fmz2jMYUhnkDTgJcqv?=
 =?us-ascii?Q?yCvhl62KVgOwet7kIY/Kby6YpxPfw0zEPwTS2qWKh3iehoxetZY33IBgA1xm?=
 =?us-ascii?Q?JaOLzJsMaasZ/PE+jUi1V4/ljNHGXGQoRMcKOQekA67A9AYpw08OEG6Rrux9?=
 =?us-ascii?Q?Gmu3qJtmnkx+05MyExz4/G5BqbJ/9HrusnOyw8dhx4PNIC/tHKoCt7EfuE1W?=
 =?us-ascii?Q?aUcTsLG+Y6MV7vDqCFPebl4QKdlyJwKwohYKJF2Hom+TReFsqhK0UM+xQdGe?=
 =?us-ascii?Q?fKdHVGEPEBMgDKEKOyLEZtjRGew66RWI1wZuzMBoW4pAQrYQqcLFES9VUxiL?=
 =?us-ascii?Q?eIusoJcCECI1lDSrZGpp1KBIt/JkmM6XRZZ1c90BRM0K3NrI0edmNGXXycIw?=
 =?us-ascii?Q?Nf6Mx9N2o7DIa59EbVB5gzGdcLUbMi6mL2+Nn4ltuFqDbr39boiyfBlfhPvG?=
 =?us-ascii?Q?gq1n1vkrN5k/NoM/E5ypQY0ZScloBzWegPjy6lHH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CEs/ScZaPxQFEeMAtfBSdNPD/hrlv4ChivtC6MMk+mYGzVa00rbswyj+SoJLLFC+TRCOgiNpXdSmfgIvRPODAaNz2hf+yY101PcC9y5O1rcua2qZSBG0qvzk0CqEaxCTJmcmzRPb8edubLzBUbGSc+kerlc/PhhaDEZuv559fBFqeganKmrsecICAr7pwn/4HykaZQ7/a/kRzsOxfcafSU1T8lX6DP7r5UJ5hOWdizpJuGOkTEDuMJbTNpdqNmYDg892RF296fPrTu7FHcou1xncAMTkdaNJv+ENDx5QP17OXPZpyYvHYJlnrhpWOFmHdSWbg6UZzOLMkEDV24kAXYPsPYa5MqNfrV//iRcvZjV6OXi8W0OZ0X/npniqRlKJ1ZuLoXd6WPowsrRAlKCsK1itn7UYRkwHaxtFJn4bMUwQkK2A4LFBemAH4IQIgRaAdBsrIDhJTcBdm/Ujtt6cVvstEicBMwixE5jk94i/D0WBh5Fdb6FtU+YME2m+eOQNoCm5fYWgcdTTvGJT1xLNFdtbjz4gc2OlOujKcTgQFKnPRFj4QFtlCtnZcL9J6laxcaMUeoiz8F0y6nRtCNTczq/6Q3f+t7Yj+XUVLTU0aR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77604366-2d37-40d1-7ee7-08ddd9c52614
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:24:52.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWF+I9UY14XXI1RHXCSvJ0FAWtu3Wz9ueI0kP3aal3/mb5+Z5WEqcLKdytA3fZjP0RXBHTlKQVupjlb/sp/HAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120167
X-Proofpoint-ORIG-GUID: JWcqFFaZvtXg5wKXKd2YGnmFVGgAxk4Y
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b78e9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=cl4-EDHQmaQnC0XNiMEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JWcqFFaZvtXg5wKXKd2YGnmFVGgAxk4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NiBTYWx0ZWRfX2TPDWMwehnMX
 bKrMnc4uNMjk46JYwQF8BOqruwOi0Bxc3N1GL9sTEAkPQ0akPCl4TfPY+HBA8eGg/V4sSdseXgk
 STyFXl0PT0jeSK3Z27uAeGaSaEDGUFrSmbyBl28z+qGGBmiE1wF0fD/HyjCwCd2/HrdaRmvHhDk
 mEeil4f/8OUilcaYPK9804TbI0NWONlaTvEOEat9wZJJWFeKyaWRyRYFXVNoIfXjuxihnDQOBfe
 ToUgyokZ3fv8uGnAgmc37MYilDeTyrzABNsh0gpw6qT6FuCdjjnMS7p8LSgRd6It7OBy0CdBROQ
 H4yUvdJ/9awXCDLAtinaJjJ3d48w+22vfo3OcWMWj0dYI30TuteIF+sLOEkAC26ye2m01JyZlJ6
 weOu+obaCusa0Xl8B9yfHSFxinDDEVgUcXGnhyKzRO8ngjCEY/lAjompPPM2cGnxswU/fZ26

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/events/uprobes.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7ca1940607bd..31a12b60055f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1153,15 +1153,15 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
>  	 * set MMF_HAS_UPROBES in advance for uprobe_pre_sstep_notifier(),
>  	 * the task can hit this breakpoint right after __replace_page().
>  	 */
> -	first_uprobe = !test_bit(MMF_HAS_UPROBES, &mm->flags);
> +	first_uprobe = !mm_flags_test(MMF_HAS_UPROBES, mm);
>  	if (first_uprobe)
> -		set_bit(MMF_HAS_UPROBES, &mm->flags);
> +		mm_flags_set(MMF_HAS_UPROBES, mm);
>  
>  	ret = set_swbp(&uprobe->arch, vma, vaddr);
>  	if (!ret)
> -		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
> +		mm_flags_clear(MMF_RECALC_UPROBES, mm);
>  	else if (first_uprobe)
> -		clear_bit(MMF_HAS_UPROBES, &mm->flags);
> +		mm_flags_clear(MMF_HAS_UPROBES, mm);
>  
>  	return ret;
>  }
> @@ -1171,7 +1171,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  
> -	set_bit(MMF_RECALC_UPROBES, &mm->flags);
> +	mm_flags_set(MMF_RECALC_UPROBES, mm);
>  	return set_orig_insn(&uprobe->arch, vma, vaddr);
>  }
>  
> @@ -1303,7 +1303,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  			/* consult only the "caller", new consumer. */
>  			if (consumer_filter(new, mm))
>  				err = install_breakpoint(uprobe, vma, info->vaddr);
> -		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
> +		} else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
>  			if (!filter_chain(uprobe, mm))
>  				err |= remove_breakpoint(uprobe, vma, info->vaddr);
>  		}
> @@ -1595,7 +1595,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  
>  	if (vma->vm_file &&
>  	    (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
> -	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> +	    mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm))
>  		delayed_ref_ctr_inc(vma);
>  
>  	if (!valid_vma(vma, true))
> @@ -1655,12 +1655,12 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
>  	if (!atomic_read(&vma->vm_mm->mm_users)) /* called by mmput() ? */
>  		return;
>  
> -	if (!test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags) ||
> -	     test_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags))
> +	if (!mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm) ||
> +	     mm_flags_test(MMF_RECALC_UPROBES, vma->vm_mm))
>  		return;
>  
>  	if (vma_has_uprobes(vma, start, end))
> -		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
> +		mm_flags_set(MMF_RECALC_UPROBES, vma->vm_mm);
>  }
>  
>  static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
> @@ -1823,10 +1823,10 @@ void uprobe_end_dup_mmap(void)
>  
>  void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
>  {
> -	if (test_bit(MMF_HAS_UPROBES, &oldmm->flags)) {
> -		set_bit(MMF_HAS_UPROBES, &newmm->flags);
> +	if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
> +		mm_flags_set(MMF_HAS_UPROBES, newmm);
>  		/* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
> -		set_bit(MMF_RECALC_UPROBES, &newmm->flags);
> +		mm_flags_set(MMF_RECALC_UPROBES, newmm);
>  	}
>  }
>  
> @@ -2370,7 +2370,7 @@ static void mmf_recalc_uprobes(struct mm_struct *mm)
>  			return;
>  	}
>  
> -	clear_bit(MMF_HAS_UPROBES, &mm->flags);
> +	mm_flags_clear(MMF_HAS_UPROBES, mm);
>  }
>  
>  static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
> @@ -2468,7 +2468,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  		*is_swbp = -EFAULT;
>  	}
>  
> -	if (!uprobe && test_and_clear_bit(MMF_RECALC_UPROBES, &mm->flags))
> +	if (!uprobe && mm_flags_test_and_clear(MMF_RECALC_UPROBES, mm))
>  		mmf_recalc_uprobes(mm);
>  	mmap_read_unlock(mm);
>  
> @@ -2818,7 +2818,7 @@ int uprobe_pre_sstep_notifier(struct pt_regs *regs)
>  	if (!current->mm)
>  		return 0;
>  
> -	if (!test_bit(MMF_HAS_UPROBES, &current->mm->flags) &&
> +	if (!mm_flags_test(MMF_HAS_UPROBES, current->mm) &&
>  	    (!current->utask || !current->utask->return_instances))
>  		return 0;
>  
> -- 
> 2.50.1
> 

