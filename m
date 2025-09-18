Return-Path: <linux-fsdevel+bounces-62126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A04B84D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9831E62327D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3EE306D5F;
	Thu, 18 Sep 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDKxkTrx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sUhfY8Dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B18F58;
	Thu, 18 Sep 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202284; cv=fail; b=UXfR+eU+454xUz4uSkKl8wcBcMjTXEBTNOFfyE9you/qoiqpiZaaBAa6mW6R6CkxYX557L4zb6oY17+/QBoQw+g7v3eGzBMUNu+2d48dStQ2jnVATbptxwRpz1wqD3WJVEtuq+JRvoSEFvX5zIyIElB72nuS8+X7aZO4dFiINPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202284; c=relaxed/simple;
	bh=5fbKzBd+GYf3Fe1BG1bT0MDduCZw61uWe2MMqoIWEis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dmSRjXe3LCjrYYjZASfZEZaSQ+NmyRjHrAjftJjoFzJH0JcnLLYHGsV7hOMcyP2+Dy0VcIJn92XMeSzdqgt3XwSqmBNDtyNE3RVH/PKICwvhbPUeFDsIF0CsRmh1J5hBZMg3iucp7u2soVsF9AG1xit5aByratZIM2MIrQA7J7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDKxkTrx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sUhfY8Dr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7grIB003450;
	Thu, 18 Sep 2025 13:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5fbKzBd+GYf3Fe1BG1
	bT0MDduCZw61uWe2MMqoIWEis=; b=eDKxkTrxWhbFJWDc33BfA64bc3dFMA1PpH
	u7S2HydQuzYPQqoUsqGI5T6QjtnV1OSpGn4Z+bXZzF80FN6R8ryTCSxPNpQzoWHN
	TtllFVAYraU7cJ80w9Qm44uctE1LTg/g+93JxKTfs7ie/5P4jbOP6ZcKVXgCWLfc
	+4m5CrJ1veM7CF+SEbPEUoBNL4Iig2nYYPjiMJfqAwmq72XfpkM65dMVawyu7pDe
	ROVwQ4FnkrpTCxeIG/eGijNPzUB3cCb3BtAcD9rHokhLX+GUEibp8XYsz3KW0KsI
	PcgjoViBCozMyB6tAputo7dWjcFOoKO5peorYKIbyq4Jh1Pw/I8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx93edx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:30:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDQiZd036766;
	Thu, 18 Sep 2025 13:30:49 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f5pnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsQhA1DS7weLDiwTblfvQRFclLlEi1OlB6mNClApIbz8AbEZwXb0pRYUB5l5cQ0AJq4AiVoZRLLNzHglQCbwGNwUJBUaudzfHEUS29JHDKWxJzVrvHNnrLHY9dc6G+HVITW96oWK4+04VBoZ0eYrigZIRME8tL43Fvo06wRSSEnwB3ypRcO17xiCvOmJ/KDJOK/wbKvMrTlGr830ab155Q4UDwNoG5eJc8fwlHuoTBrOLXdgF7wYCsy9Ppom/W3dQCYcK47Xr/RtNYW6cOh3oUjxKMtEJsFDN/h3Ylkoo/baukVOkyo9180yTiaEAfjf5PRAhSUoQRp4CvwMV1u4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fbKzBd+GYf3Fe1BG1bT0MDduCZw61uWe2MMqoIWEis=;
 b=JLZ9pgg2FVnyJrFhP9YB/HvlrAk4W0sJ3rmXsnP5Ni5UW4wcGPfvzbfaJsumf4bNgYfCrPAAfDG2BwKbOVpvbznHPo4DoaGiaVeKmuBrlFb2MMRz9kKXMry2VEn0+Im7ZTgoIH9Vpym730DPiNVIvgRWucSQvCjY224sQlu5Y+WFG2aWM/jaAJpSubrWn3WmKjos8HP/h+XVUSb21w+KSnH4B9kcWSkAon1/0QQEwJMyhW+O3CYtDxM3On2vg+t8bWOIkWkzHKZKtoFUUx1DjAr8ImDBvJwesbXG9iB7/ioI4+setMe5BMMZoeXTqMP/DU+I1rkjCC5+yGPFe3qRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fbKzBd+GYf3Fe1BG1bT0MDduCZw61uWe2MMqoIWEis=;
 b=sUhfY8DrKEAz0U77JPbE7uygw1IalWTfeL7bvsPKdmXGzv6NDZy8FbsfLbGqbfjpAPuEBFC+tAom0Jz71IDdz03sLOogFbehSRc4TZObVbHFxgicQpWIRt87MFSuB1SrG3RmxCWheVBK7q62LwVDZZeYYHhE0Jir0M0QRfHPNQQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4923.namprd10.prod.outlook.com (2603:10b6:610:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:30:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:30:46 +0000
Date: Thu, 18 Sep 2025 14:30:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
Message-ID: <a582d334-3fd2-4364-9e5f-cf0383d1c119@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-7-kaleshsingh@google.com>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b1a964-b108-46ca-e708-08ddf6b7933d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2GCKfSOwqfcuf51sQKf4KCWB6KRqKt4a95yvH+XGwPL4M0yxP21MXhn/js0v?=
 =?us-ascii?Q?9gJatrz429EL8BDG89U93cUoCHu0z5YRtKezcZ+1enUQHt6V7ujZuVzoMODA?=
 =?us-ascii?Q?P3nCx8cypXuDWmsFKxchjrZApQG2IMF4E8BRZepvtBY5b0ocdZRH/QCfwbyO?=
 =?us-ascii?Q?pZeoF8VKjsGjXiRNA4pwoMn6ZvLZOgEUIWpILs7nCIc+bigdrCQTOpv/v14F?=
 =?us-ascii?Q?n/RwqZKkfVwFY4qKBPL1wWTBzYI0oCLaVaxjBZJ2mKYp8bmAOqJrSX0WATUy?=
 =?us-ascii?Q?mUYDc6Bs7YwcXGyqEGfoWt7265Rv1Vt/fC23oAUaMEp3k2KFQu9YlpFqSW++?=
 =?us-ascii?Q?EQTPIFNKh2eM8RJ13apJl0cJZ3ZLirATdy8/4BoURnN75167+kR7Xdm6FNDH?=
 =?us-ascii?Q?MmYoYyAcZUGHFY/+WQbJ0w9mPnzs1ljLqdLyPtHHUVKaZ1NYt7rvPZaAV0N8?=
 =?us-ascii?Q?j6dZ+7RKNPCRU91U29j1LAZHPrVTh+oH44x97hbgpXkFZ8UTXc8Z+Td9WKin?=
 =?us-ascii?Q?94idTUOqmYwe2wFvCxb5L2csDbRo5PUPtNePIUrHRG/Gzbsm5prqYYT1kUIv?=
 =?us-ascii?Q?+thkkxJcWZcWV0UMuHLXbhx34bnSq390Ove+cYlTxifnezCWwVqzfOCA8mS0?=
 =?us-ascii?Q?KP74t33obSu+L8JWntLTZWY1NhUdVPsvZ6WVLm3TBI7sYIb4BZMwnKQ8idlW?=
 =?us-ascii?Q?WaS4hSDkswt69Ren3Wm1Tvax7FFqFp0UjnzjMfLeUgE+Y5bG2o+Po+hTCoMX?=
 =?us-ascii?Q?WLJQn0+mYz0COu/XcZiNeTIAcvTlhg92lt0+20tKMuOmZBV3awjHm8pKIkRP?=
 =?us-ascii?Q?qobcwBSAwQtPFWwKBg945n0XOHKPsrlohbQdgKl8a0gM8BHR5wLncMXNsjsJ?=
 =?us-ascii?Q?5qirMQXxtG9tSnWt/5t2t7kVK9rBQ60WsZ8zM2H8bjAIDU7uHX64PIx/tnvT?=
 =?us-ascii?Q?KlcYyAI51UGxCn6p4va/cdw+za5froO3Bo3FT7yYSgcE3DKYgm+lwKS+kKMp?=
 =?us-ascii?Q?y+EN+Oo0Jg5DBN3SvPxGfqp1Uj+QGCGhSW52tPYC8ndfp2zK8LByl3DRkDJW?=
 =?us-ascii?Q?Gni4u53iZBRBEZxrJw53XSBC5xJwipQSz8JuPN4gwBua0N2SC0yjCVP/9Ydk?=
 =?us-ascii?Q?ThIQgAEbY+Z/jRcNfVkBfhYMMuELSx/IbhHUk0RrNrXZxJr3EHDpEXf75un8?=
 =?us-ascii?Q?aDiIIE4Lm84q7vZ3BXGMdEwUvBtBLgA9EIBM43v5DR5PQCiwHyvIpSWjiSkq?=
 =?us-ascii?Q?45QxCBfBcnQFD2wlKKInbAIrHfiq9SZ76UEVJopAn7hifi36Ltu+q0bnH9ku?=
 =?us-ascii?Q?FOAhlXHxp/mueEAU9jVnYzf07qm/JZBAPJcq12DyIdZpTjcQdSKaCUzdM7dc?=
 =?us-ascii?Q?B/LARWHjyC47e29IynFW567RtRsAeVa4P2rmRy+VkLNTyoWECw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+xc4nHn+fc4hbb8rWctpCiVkoiVloO0vTKhcGI2gOP/Lrdlb3xDtmro6Uai?=
 =?us-ascii?Q?nid4jZ1NMYjBSa4lQsRWsAKDTeUPU/rvKTjZhtB7c2o2mAi0Z7GYC8jzJ8Is?=
 =?us-ascii?Q?UXPvURqe9YhaiHQYU0XscTxGwYwHSXGUFymT7YfjkyJulgs0nBXWewRGKKfD?=
 =?us-ascii?Q?IqDtn9tOwa2y9JDS+V3r+QqoZm7WVL7Pd6+4QwcqvBWITI/kxqrD8h9WtwiW?=
 =?us-ascii?Q?Xh3syu1//5X5cT+2ySybArA1XHhEkTpQOIZ/DzivliW2GhxqTGqerkJlBUnX?=
 =?us-ascii?Q?aWmyucqhDLvE5dYR+xqk9jaMWP3pB4XqwWbwMcXJVKbFXeZO1fZOjjNzCkRH?=
 =?us-ascii?Q?adWV3Vk+V4ejHWHNrC4bdjkAarcWlUBkE8aqp0TgXYVfSn+KeOu9Ecs+Sho8?=
 =?us-ascii?Q?ciNwxKEjG4/zIEL6WsV3VF/PPb6BZcPTKrAwTTdqVmSTh70+jEBglBPo7stD?=
 =?us-ascii?Q?tTz9M8ORgSBtLH7Vj+g/hxlNgJRlCDtOXDKxiNPMVv4G6ADPs7pvcv4YAVUf?=
 =?us-ascii?Q?hEAK0nfpl7icB4Saw2xj5H/fHOnlPfgkD/3zUERDtI1uwvXUAO5cOx5EhbJ4?=
 =?us-ascii?Q?Nk10s0lePjD4Qr3ufwObqWJE35h4dewcfZkdBRIRBUcp78aZzjb2vSsePAy/?=
 =?us-ascii?Q?c7yAMm3i5u18qMdN3jTP263V2lUl0yB5aqWJHdP+Ki2WtbDc5lRhEP5u4zbs?=
 =?us-ascii?Q?OK1GTIMM3j92xThcmmv3cpf9zbFCBpWQ83elPSmqWAbEQpOskQqj8jXLFQiB?=
 =?us-ascii?Q?u15baN8OkbfF1Qc0FY+fZuoudL22fZff7b3UbzSVr7i1vVsowF2ftIOBSGWS?=
 =?us-ascii?Q?bUuEDfGSZU/g6jx24W+mC54D2mf2b4flsFRgHVFxtfkqpRBKKn7cG08p+tdP?=
 =?us-ascii?Q?29D7Zp/ZtwtpTg9TGMoijHVB1aX5GBr/kKxDd/rGE2pL5VeaaS+uumgQD0Yg?=
 =?us-ascii?Q?PWynyV6acUYgkb/0ef75eDiU3LnnsFATK4MNLdASA379Q8mRLHIbKASg269F?=
 =?us-ascii?Q?R58xqm7l+8QqOPu9MZqe82/Hbj8pv3KwhPTjsopDuZnzbeufVjBKjkNBqIXX?=
 =?us-ascii?Q?AzQFtgv0ej3phihyiv21YGwO1LHw4w25tO52n54n9lVMFwnrziUoDx5s1eJN?=
 =?us-ascii?Q?gPpWTN5+yrT7YfnZUlsOEZr5yeApYLzpy2g4hZEICydNJjf3EdyAbVlyDhAV?=
 =?us-ascii?Q?krboQispys1/qEd7iq6KV00ybYQ6nGGDe4JtmcqrV0k3X81Gp5igUjPTOxck?=
 =?us-ascii?Q?5roG8l9Z6JcHbTVLLO8V0lsDXCOC/2cNZgA7bYLMxi8Shq09DFWFrfhH2+g+?=
 =?us-ascii?Q?q9DfdWmqeWRjaVIk21gcBmyrqZWos6q8qF7ZST4wyaRSru1SgekhjMLVPD/x?=
 =?us-ascii?Q?vhsAEQl1jJOS2PYLwudRb4eG95mhDJ4035zItO8/d9NMuKlaiQ8St3iqFoDH?=
 =?us-ascii?Q?ZDJd6pT7YiX8aD3+AVA2o3CkD8VHeu4gDFB+EvcDF/cjH7epIoUaHUrDZaVX?=
 =?us-ascii?Q?LPqQ9HjCyfXAbVNOPyi+5drAn66qucWtDD6titMJGu9xHJsFmBN/OIxIQOth?=
 =?us-ascii?Q?2FlLWvJUZMVaE6upPhMSdXC+yZFsl6yrY/z8IrJq8t8yELWQYTPLTTn08MHX?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kIOO84chgWOG6zl3zjSTxQbHpFH9l92sxA+E9TSGtjrtOoD91zbCcV9kNeRg2Pw0+8hIEZOUpK0QCcQEC0hV4u/3YyNf26xLCQefT12JMuiCkZ7U04Mzy+zLRaesEDemDpHHKiHkL9Rz6HSCc88o9E86/p/Bbjub3ex3RUssBfGTKIjxuh9WiVbL1xPAT+M0fTh0GGvVfcfiAaLzs3DkfKoGpW5v3W/JwmGK4ivp9pqJxUNW3NvueXWbL/rsOiGYxMLd/qN/Czf7eSIT4riKz8/mTCDjpWAC/xjHY/zxzCyx3BJcz0dBPJERCRMthrYXU7bZ0rJUvZ0EK4S+BH3CZUf2MZMnGELYlHM9xP28Z5Mjk06bosqjJ+6KEmXKPxowCJwED1GJxZlV/mGMILmnEPcocbtmtFLsZJc0GoI/mQ1EqoS9DILQzr0mYLTyu8370qhfIz/d85Jc6gsibVf6TS7jBYLOjOCGee1o9n7WNfG9S/RNAlEOpOjTY6uhoPPh/0AZSom7C11G1Z69vUUTu522qlICEsrCaab8FJnAfi+tYDJTOdbugozKzzX1zeu5/qUXW8bEsrVPcGvHZMzvhld5jRQVIstmrsAxMfJRhl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b1a964-b108-46ca-e708-08ddf6b7933d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:30:46.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /piK9EPo3nEtF3a6SI6D/R+zNsibWlgDY+/wSgb430u/cQ+zC53rKZd5whtmHn9QRRl8GnDIfcykWxxhUzjaF0OYL1u6bFl62GatIm29coM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=826 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180126
X-Proofpoint-ORIG-GUID: k0AWgcECeH2m8baLSz4QJDTZg1JsNus7
X-Proofpoint-GUID: k0AWgcECeH2m8baLSz4QJDTZg1JsNus7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3NsFqJXJxVq8
 Nbo+MX21KIOAwknT/D3VtjTXYDfN5CFDmYcRYoWoHLIn34uDCotHb2nSrWzoLsTSeaCpDSPFNW6
 I6mabxa80F+YB4lWweRfg58GQSTFZjuxhLghCc+MfdNadkpLtQvGzv0veCghBz2/hXfwNG1sqVn
 d/q8nSlT8UYX9t8jxYkgW81nWgW6eyG1AUQU5ajfqZPqXA9DVP0auLoASlpTawA/SERzgEW0wEn
 oTBwAE7Fnqz/06K/McGXOCeVyHhM8pZOabuerknDIYKAnXEWAMXoX6EOxY8pCKRRwtDR4llR4nZ
 k1ojpccuMMIUwoByrkukMTAQYTUNafsg2IDgm9uCLAmsn43Lro/FU60tX0UuR8TYCvhUlgzVNVJ
 Qqb9roppmEch7B7X/Dg/D6MAWKcSxg==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cc098a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=V5HFdCmXdFhsvwO3JpAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084

I see that the review is generally to drop this one so it's moot, but this is
also not applying:

Patch failed at 0006 mm: add assertion for VMA count limit
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

When trying to b4 shazam in mm-new.

