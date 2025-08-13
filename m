Return-Path: <linux-fsdevel+bounces-57786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5AB2541F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FC1888359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85A2D028F;
	Wed, 13 Aug 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yp3/SxfH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tbllYNzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803681DF75B;
	Wed, 13 Aug 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114894; cv=fail; b=QK4JN9aVwexwna5VrWCaC0aIGlxn3DSy6mpguKUrucYFPET8htjBPfv8xjunKOtG91QoIqosZ/bmaDVprpiMGcR+u7VlP2Wdawg5JsALy2uul9YAZ6Xe+bJxiT7FsLnJfcaklgkOKWFbGEEegjP7aDCcEstEKOYZIKdp9GSTbmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114894; c=relaxed/simple;
	bh=7IrqOIYFrpvbVXHOitaVYiX+xNsslLwr5Vxg24up77c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEzLOqZW83EzurhiEzyRWUekdEe0FjmNvtuu3tuFO6O4V/Rjy5qzTCBf5ZZbdTwQpXS3K40LYpWxzsq/sTbiNn2WgkZvHxpyhMb0LAtAKryeeSuFGTsVwMG9ZxblQpQQn1gFCHr5sVZa9SyWM8hgNDhSH0aIr0I2MY0DoYB2NX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yp3/SxfH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tbllYNzv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DIN5uv018386;
	Wed, 13 Aug 2025 19:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9/AE+vhS5Rm37i8iOw
	c7FMLD+ZwIig023T6GSPxvAfM=; b=Yp3/SxfHLiymgBg/Wt+n6VZOGpMCBHXrnr
	Slwy+2BR58Bd9XrI+E+pUMzAQfs2h3K0OAg23eXGuSaCFJIVfrZFt3K7IZc99Qh6
	IAUJDMHZUh/KYaU5+lfal//RTOlqmvuVGEpgffkr7jCmaYOoEBSfBj74ciKUnqTU
	Xb4OuXdCxFXoBHhgnxVh6ecUeTS9mM38V5VqlnGFIiU2ppB2lg6uL7Y889145CN4
	UB6drkiSpigcssfokAq/nxP3oIpvJT7mlVlOK/IsjmrG8P+AgTRTpmuRtv3RVSM2
	qjww0PsH8byVNVwgDviXSZBSOxpfM65BNzJZHyeRLZQ4rFK3qd+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf8f44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 19:53:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DJe1te030190;
	Wed, 13 Aug 2025 19:53:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbue4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 19:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFaBZxIxfF9aYBhtKCXbqKfZhuVnP5ftqjvmFg0Ae2JNXTW4isRpGpMe17uSEEuojbKTOB70Pd6ry5v+Si3obQNPWjzvbpRzRTPUwS01iXMTQePkLrTqli2zcP8sU68F+9FyjMl0L95y7lcn5VFUMF7byh33PsTLPCVeY1GAmLtFegvbLeGURq7m2DpvW84h+Lg5haaI87sINZN4diWxUC0feeTAOQwQsaOl3hSg4ZuX1w00AqVCWoAxU+IXt7UFgea7Nw6R3UgEz+YocGsFGilChid2FucudIsQDNVy1pJiLFgl5LcAi4UssvXFSX1oLusa9rhV1y2z+aKmpg6m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/AE+vhS5Rm37i8iOwc7FMLD+ZwIig023T6GSPxvAfM=;
 b=zPLCXuyrVL5qKa15EFambr4dn9xGu2VxtCj6Lsq4gxOl9VLVJznj7Xn2rg0TLDrOeX8QWoo8rH96lpEkrICgd+4+cX3So8rNza00ZcYoqs6bGqLx0pG14s4rHKuJy8JA6Iz6Tji0jWtcHoKLOoaLb5qC3u26BYFz5T4R2Pi6PEahCFDRfMBSDuazF1mylKVESLGQNXCm8/3KOmSunHDvf4bmjc3rnRRjBlLkYDHC4NW2B4LbvB1OrOJh3PAVUBrn84ucnCeU3UFDdBoAzIsLfoEJnZwUBWClFHtQHBj+pgcTdgHLtYEA+4oVDyiXm7MBqyupIaItejRBPtb4oqR6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/AE+vhS5Rm37i8iOwc7FMLD+ZwIig023T6GSPxvAfM=;
 b=tbllYNzvGlSttVZrF1n+NvI6Di5UypOqkUkM7s6QMu4UPnee+vvEGA9qYG//y7PPWx3yJTsu5Q/5EOqtkJSvMHxyWaQlNV6Wgm5as6t9d6bnNP0Dp9PhCbxmaLeA6C8Gy7bHBiZVssCVGDg64TzX4gJXOqXbYYDUoSLjuSUfxa4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8591.namprd10.prod.outlook.com (2603:10b6:208:57a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 19:53:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 19:53:18 +0000
Date: Wed, 13 Aug 2025 20:53:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: Re: [PATCH 01/10] mm: add bitmap mm->flags field
Message-ID: <d4ba117d-6234-4069-b871-254d152d7d21@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: GV2PEPF00003828.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: ab83ea47-cd76-4203-7cfb-08dddaa30c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjYb+tdD5bwUmE5Tmd9hRcAyWj8WQkdqI0DNs4M5RBxMy6gUe9grjcCbCE/8?=
 =?us-ascii?Q?CfsFD54YWy4kzJXnvrnXXtWe6Ot9JC0FI8WsQ1jjqJdWJy1ZTx5CZlbc1D4J?=
 =?us-ascii?Q?p8b01kqXSE1WrJKCIq9KygJa7UNReINRDHBL5HVnA7oRH+gL3MsW1uCEieZc?=
 =?us-ascii?Q?BCabC+0hTd8NXy6cc5qQ+GguC+xkWKZrKmepKP3HJObuKv7kAand9lnIApPn?=
 =?us-ascii?Q?QicLnS4v0auAeqXKgEfxYPBgTWvtOJrZpWYa/+dtdwnasQnremcXwW7hRmmk?=
 =?us-ascii?Q?zicjd6DlRAn+70a748evwoyZEhykWN0IO5C/94ZiQGDYmncEwIgUtdxnSLno?=
 =?us-ascii?Q?6j+uCcNXqCl5bc7Vdo+OCsUTofdqauzPINFYk6almMTTanZiiebRkN5duXfQ?=
 =?us-ascii?Q?NwEmWpEwXnPuayu3RN6y5CnTAVTdIhqqWgiMFisaG8dBtAFo+/HrZDot7XBa?=
 =?us-ascii?Q?DS2YQgcDwau7egQLIJLhbDfB1NpyHSPUjuneEtMIHe1XhP/KDQsSEvujBCtA?=
 =?us-ascii?Q?pcuUGzFoQ8mNNB32+IVJrzTCrsJ06Fy3RAiTkSGEqvbHo7y64lIgRPLVmGvh?=
 =?us-ascii?Q?1yGKy8DCxMkJT0MzDRAglEkTIMRW8z05MsmYQscTmOsZmgff+TWY/xhjFXHy?=
 =?us-ascii?Q?Zw4qsiKneXee3OR4d+M95L/rLf6d+oTZZF1/3rnl0lvhvV0uD2mLsj6vqG5g?=
 =?us-ascii?Q?PSWKLYmkQZ4QzYHQrWduPixmzY4dSvpqOZhgZxiYlXXsFAeODPZ88UyP3got?=
 =?us-ascii?Q?TCFmpn88potoBDqtaOmePyrpQxpmhs7w9X+q5nmKw4lNTENjGnVdNJBy2xte?=
 =?us-ascii?Q?04TDYFLNzhJNLfkSLutoHrL0IAwy/eKyJcFRuM5/6Yl00NmhJdAY2E7ubFuU?=
 =?us-ascii?Q?947ss1T6MQXngXemDrsSzR45jDTl5xSz0Q5SOwmBNJy0D1BGmWcMlCozGjFV?=
 =?us-ascii?Q?Kt8ZukJb8Tbl2zSfqps7bklj+qfmA2SFyzNU/RCPLHJFc5xUeR3mUuMLL7VZ?=
 =?us-ascii?Q?y+Vc10SR+mCGH3o2pt1ArOHRUk/oXiDxlm5VVOj+BS3umQDTDKoQdUpU8DzB?=
 =?us-ascii?Q?FrOmfaG2Yvq1t4+Wa7vMBHKkv86z0zrgKvjMLTpPk/lUFIidRsYKGUmKRlJQ?=
 =?us-ascii?Q?1wkLwkpcSCHx9uv7SIvjtnqWD3C307OXOpc4ccrd5pADoUDAvImVxk0cX3PI?=
 =?us-ascii?Q?KGRHR7Exltha3Bbqdv+LXdwl1tzugEc8P1HuI6Wzo9hSb6Vkb1MthzEnKF/3?=
 =?us-ascii?Q?yy7hvaH68qn0ASttLlEIN4p0uzGf1OjJK76uzmqn4EcZH/FbylGLmAHgBAht?=
 =?us-ascii?Q?usXgY9MSZihIhJFa31WsIDXsaSJJF3gelm/cqJsW29JfFw+02meurttO4ab8?=
 =?us-ascii?Q?+8JvgeqTQEojNkcL3bfaTxjKXiUPIp/LGDqeHaR1WHVs514ikOwgsXXSuWaJ?=
 =?us-ascii?Q?6Mf6RoAbRZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOcF+GJ6GiECOZbw+rLnLbnQOmaAK0AaENc2DiOQKSI5rx+2UaOCku+dChCJ?=
 =?us-ascii?Q?4wRr0LDXAse7U/U8gT7CKG7w+XgGmTXAHOgyJdLXAMwfG84PHHqkIpxJCbSe?=
 =?us-ascii?Q?+WM+DapqjN0RvV+4s1tkYyt02r7wEnpL6ffUC5+6Pl1LgVaCES+mdYH6r1Q6?=
 =?us-ascii?Q?6T9Hx2gUJsEZWsVosgpTfS6q2pWiZXA703NZ80Ety94tD9gxB1Hii6jUYTaw?=
 =?us-ascii?Q?AzBGexaqo1pFmsAhfUYPEQ0YlbukQwrD0xEkyMn47zVvqzrSHgaAuso21I4H?=
 =?us-ascii?Q?wGwm7cMtVq+OVQg1Ef4R1cshhfprf4IOqrlz9n5BZDUPWdty/bg/7lmoM7kA?=
 =?us-ascii?Q?Up3+r7+wcoPjGc7sWDhonIIS8AQmzAY6AEdB5eGYd3fLAPN3jVb/1FoZMap/?=
 =?us-ascii?Q?x+g4rLSA2p30BuoaOc6Eq1wLlGTPBcfyGP+lISHbedaO3JN48UpzZitDkqDi?=
 =?us-ascii?Q?r4ttWwJOP5Y8m4G6y5ISXcztGszCiWm6ZX6d9As6RPhYxFf31i0BfpYsXYGN?=
 =?us-ascii?Q?ntOLI9OuSS98q6rAOG8XxW4SD4ssVQxbgaHS3EH9JXZ82Mozna66lY4W4IVC?=
 =?us-ascii?Q?LSeDysKP2/iSdmdZndajw5iV7wNJH8pNkB9/EHvHu0Cb++wdax4yHPSfegXU?=
 =?us-ascii?Q?vulpJGdEhEzQK5DHxQuaq4GZeSyBxrPoGjNI/ptTtRmXZVTjw8JknPkB5uZB?=
 =?us-ascii?Q?TWvQIssGdgc31T0rdsdCna3QJ2Nu/HBqPwRewRqotm1GwOkyd4kZEir0iapg?=
 =?us-ascii?Q?N4aXbEPrtIPvQZsEsTPaiEAAOobavr9H7bO13NWWz7tAJnFgHNfUClxx/C4x?=
 =?us-ascii?Q?mm7EzAK37DQshiRR7Cgpnwemkbb9avR4NIe+p5JE7Qpu8zE3o1Pyr5sCbh0g?=
 =?us-ascii?Q?tOSp4Em5HlgdQSKbiRZqp2gdiMEZwOU3DXXexhLzQHrmTcZ7iW07rj+Sbici?=
 =?us-ascii?Q?/P73hWvLxYSqL6o18/xiKpO216ZRO2KQTCE4z5fU3u38zvliaoT6ZUrBNsRB?=
 =?us-ascii?Q?ndZvO0ey9shjkvLdac+VHi9Y6tWyY/yIKGCty+drs7w5fN/y1b1A5/I8Ltva?=
 =?us-ascii?Q?VCylGWUtpM8vxI5IO+89+GTbwZ26JmMY2Id60EGEXu5f0IxiEa+bBwZ3AylB?=
 =?us-ascii?Q?xSdRDuQnGBiaMSmBKG39QtMnIh4zLwMBgeD/kfdhT9BNTBvdjCePHOFZ3T/M?=
 =?us-ascii?Q?CA8V3ido2x7OPY1kYdw16bf5dAScxflJ9mwFxB66jCNRHDrh4ckIdRC/IEFM?=
 =?us-ascii?Q?2zSGELh9jrBobE+fYgN4xLw4b3nNZCBX3+n/kA3rsn50+fgORyHVgvzi/Nef?=
 =?us-ascii?Q?caRs9YRrpzIHyy7TMsn3/gznmYITW8ZkLZFexbkdTWFgQtOdzATRp4H8k4ur?=
 =?us-ascii?Q?hJa/dGvsHCmMIg2xZ5MLy+YVwCs1A9SpTQ1Plei9Wh6jwuJ0FQ17/pPH7iJF?=
 =?us-ascii?Q?tRZ3jGV7gfv16CmI75UMxKJDwLfQRJ+EeUsuh+dyqNL4zZPMw/EFRwmX240Q?=
 =?us-ascii?Q?cPizcdnU7f9Rf+HtXpb3bu2xOaM0tXiiqnvbsMUOzgHM9tb8CxVVIXJj9zRz?=
 =?us-ascii?Q?MZAyZ53WLxdSPOPCsLT1YmOnME9asA+67A7Lgrm048TWyJPQCX4kjwhIxPuP?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	agt/qQABnXBYrHfhOLtQe2cK49VBzgGJbxy2BOGrowQsz2laVXse33lfrZ9y+oxrtmuJk6gdYlsCWJrSdV8lXryr9qolZuGiNeznI8Fe7Zv/mVYgLzAPWSMAZkENWaWsdggyAjre5CXOMHWLgPubU84ilZmHxkQJo3hM1jxb1CEiJPgc5pti2ISGW8tE1NFQo7m+4EI9kreVvVOfxuVyDrduzVK8OaglUsmrhV7HtIeFLR7/h+y6Fv9E68ietW3wt8N4/Wq4YZcfao390oulZ5zXcwZzG9kAA107+j2h5JCbM5L8Cqw6HFROkau6rt5bUYKor6p2qgcCuOF7jKU9tA2fIpMDFyO0JrwiFLCeNlQcjqXDkS82a92y4cn+rPD2knbJYZPIZzntqdpzTz1Bb0bZlnJrfVxp4qLsMvmPlITKsS8ju2ixAOllToIQOHXg//yo/gq2gnM2Ohaio8dVQQVJHfuTf8U3Vr4a9JInTEGmXji7kRxrBu++gCMbl4irscLfBO+N+JAOES3zZYGGGRhEm3y59qUUArKCtf4yMAqB8yvreWlJHMjn9pbzV3Idbesny8Yn1FZAXnrrb9B4XBreQy076vYibfRRrcOULcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83ea47-cd76-4203-7cfb-08dddaa30c97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:53:18.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwBTJKlJg5qAM83s0dnAFEvVQRWG7omDZl1uWg8uG/h2mVXHem325L5m/dmVv1YJfs9bvGwtX4jfDHwgZSKoIE6hT5gxwCJheAAMSjVkyu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130185
X-Proofpoint-GUID: dllCVF8UlnIvz2ED6ggPDp520rIXxGqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE4NCBTYWx0ZWRfX3T51GYgJcFys
 EElhKJE43ITbY5yLIBiHkeHKkYszLAMB5GKwKlLAMkL/5qRnf0TAk4Rq5Ye9O681fGGxuifwRE2
 baDBw5AnApp1y2WkTfxwQkpzxvrZlFocJFbrnQshG5opwkgXum4G3h4trZJxvv24szeaK94bjVT
 70HAGpM0HC1a7AK9LgGUUxFZJq4RsksY2SpRUk1nR8q98W8y4RfuLNOkf+yE/PaK+nSkT+B1FIc
 MFmOQNA3QJbWNlXuU/c+jit7/J7DFw89YwgratvW/jnk/oXfT0Tqsg8gXkIegnP3O3nCoFTjcMQ
 XPYPzWB4ujiJ0ADj2YhG2oTEgR9+9catiN7D7MfgqlNPCX0VIuD8EKFtbBhM0s7DTJc/esCi7v9
 3p4jXHM6NTU/NuY6Ixwwy3rLL3lXvxRIS+PDwajirpjzdWYoW2fk6fzb5Hrx8kpWzgWcUU/N
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689ced49 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CwLAwcwTAefBDsDzhiMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: dllCVF8UlnIvz2ED6ggPDp520rIXxGqr

Hi Andrew,

Apologies, it turns out I put the __private sparse decorator in the wrong
place :)

I enclose a fix-patch that fixes this (now *ahem* tested with sparse...) as
well as fixing some trivial whitespace/code reuse/const stuff in a couple
accessors.

Cheers, Lorenzo

----8<----
From cbe60f2c5e35bf1fcffb00c51f79f700edc17e06 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 13 Aug 2025 20:40:10 +0100
Subject: [PATCH] mm: place __private in correct place, const-ify
 __mm_flags_get_word

The __private sparse indicator was placed in the wrong location, resulting
in sparse errors, correct this by placing it where it ought to be.

Also, share some code for __mm_flags_get_word() and const-ify it to be
consistent.

Finally, fixup inconsistency in __mm_flags_set_word() param alignment.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 46d3fb8935c7..0e001dbad455 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -934,8 +934,8 @@ struct mm_cid {
  */
 #define NUM_MM_FLAG_BITS BITS_PER_LONG
 typedef struct {
-	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
-} mm_flags_t;
+	DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
+} __private mm_flags_t;

 struct kioctx_table;
 struct iommu_mm_data;
@@ -1233,17 +1233,8 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };

-/* Read the first system word of mm flags, non-atomically. */
-static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
-{
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
-
-	return bitmap_read(bitmap, 0, BITS_PER_LONG);
-}
-
 /* Set the first system word of mm flags, non-atomically. */
-static inline void __mm_flags_set_word(struct mm_struct *mm,
-				       unsigned long value)
+static inline void __mm_flags_set_word(struct mm_struct *mm, unsigned long value)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);

@@ -1256,6 +1247,14 @@ static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct
 	return (const unsigned long *)ACCESS_PRIVATE(&mm->_flags, __mm_flags);
 }

+/* Read the first system word of mm flags, non-atomically. */
+static inline unsigned long __mm_flags_get_word(const struct mm_struct *mm)
+{
+	const unsigned long *bitmap = __mm_flags_get_bitmap(mm);
+
+	return bitmap_read(bitmap, 0, BITS_PER_LONG);
+}
+
 #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
--
2.50.1

