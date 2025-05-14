Return-Path: <linux-fsdevel+bounces-48951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A09AB670D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC9B7A7B54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279922424D;
	Wed, 14 May 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bOiYRL09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lRm+YzoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA922370D;
	Wed, 14 May 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214016; cv=fail; b=L+dxbBNeRJb7lLKmFs+OHwRtvqmB7XCdMD0AFnNEEDBEi21keGtv4rXt8KNYuM1FjuTSW7oX3OW44XxxdjLVcqv3tLhUh40pdu1g0cNU6vuDAWBC2SyjwIdBMjGFKuMeYfLkKut10+xw9Tz8b7rG294RhUT6JsYSDwr/KrHT6sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214016; c=relaxed/simple;
	bh=idRvP8f0r/0lD3dLfu9TGWs2KUxFHYYMhWBcw8VDAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yd2Gdj/YzawInGHnFTD2vPCoc6o9qh/+J9xiEWlm2nQFFyfztNTiTLoBAQ15/sYT234Op9S8nFVqyTZhcbNspbk5zzHtzYbaGe9kPKAWNBRAI+69AxAr/BF2NpAMP2D3yAFbB0OKmq9IDUCPj1ZgVI/+QeFccCdWZbs9Pyu6U/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bOiYRL09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lRm+YzoK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fs6O020297;
	Wed, 14 May 2025 09:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=F4ED7rRNdN0seGhv01
	RJy0uE7XzZQVo8dIGe4zaWCw8=; b=bOiYRL09Mc75iEBGVXVs1S/qUDemwfQbxO
	MlS+SidlgQykkXhrP5ULZMPH30z3F1h66mK4SwLsHE2BLHCIHNRWIDGBdK/OGgQI
	WK6Lp5ENCvZ+q7N1DtdFZm3IhRhJRNtmLmRBzfdkHOPyyixP0U2jql5xzEJuFpRy
	g48G07Cg+HM28xasHGFjWoYQ3TjCcHWuASu17qC/tRAJPjdq+VJhYs2+FTIiNdio
	utNj1ftETjx3diJeGTPw8dSgvaEKX/UxBSU21ptoRj9RYVOVEwlLnq5rGKykUZjB
	ffnPJlR3PBLkMgmUXf2MnRoopS5VM/Y8SzbCoc9bZJt5KB5ZA02A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcds58m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:13:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E96ZaX026129;
	Wed, 14 May 2025 09:13:18 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt7pmah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgaSo3Iv/0CxPkddHSscU8jPp0cX/u208EzTnI8rIJa/RWL6h8V3JhOGSrH2JERhD3JLlzEraByKPl7NjPmA/zZj0waxnJzElasTVRVmownHwF9lIWh+GbW19qLWpgux5Rg65dAoCR6D0ufHYQ/sWjcGU9IoxIBSouM0qm/9cJfgZNbMbt9/Koh9CLkTfW1QA4ajvzSbfnCCo2RQ96bwBhWfhRqyVdG6OrbXfforkB2933VEIo5OX0Tf8SEcJFVZL7aGtAW4rhkdY5TxmmYqDNPe0G7fNF5zN+xxFoe16HtLeyk3OC3XUgC5Sxn3DOto8420kpFG1JfB4PIqSYmenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4ED7rRNdN0seGhv01RJy0uE7XzZQVo8dIGe4zaWCw8=;
 b=qlCstH8p93tsSDn4LvE+mqgolIHzMJWw9roD8f4eppUmCo+QPKy0aLJEio/3GBSjRKoVe7wJtG+SwPeZx7tUukU0Oi1PXRh57bpzvS4koq3bWi+MQnsiDYYRUbeEF4YR6GM4DPIt95kyI3NRA/o2/wdn7lmEw7v6rnUW8GlK5jkeuc5HyFAesWIPgQeF8F+Gjmv2+FL6w34l3Ojz2TsxtKcejAX0S6Q7LnWL3xiEwcocU/JkuKoVIMpe2cpwVkgGQ+lMFUdqxTOwp8aAekB2BGIbG/UNp6CgthU+sWhSf0+bjYJYxdl41PQHwbjsxeyqo7OPHeKJXYRVvKeptPlfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ED7rRNdN0seGhv01RJy0uE7XzZQVo8dIGe4zaWCw8=;
 b=lRm+YzoKkAGe5uuFtr6LhNYZNv6z3ov95fYGdAMAC3XSHH8LqkFx6u5jAe2V27kgMnUEJQkpeBYGisf9Q94jo9N4pEYAiL5SEsaW6BrGtHAsEkH8X4VsFJHmiYXorFU1sN2qwq5ikdwK+CSFJTN9twyoSjy7HMEPevbaefm/+Cg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7778.namprd10.prod.outlook.com (2603:10b6:610:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 09:12:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 09:12:51 +0000
Date: Wed, 14 May 2025 10:12:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <e18fea49-388d-40d2-9b55-b9f91ac3ce11@lucifer.local>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <dqir4mv7twugxj6nstqziympxc6z3k5act4cwhgpg2naeqy3sx@wkn4wvnwbpih>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dqir4mv7twugxj6nstqziympxc6z3k5act4cwhgpg2naeqy3sx@wkn4wvnwbpih>
X-ClientProxiedBy: LO4P123CA0322.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fc7bb2-dfe6-4bec-6e00-08dd92c78092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+kp/2gA7uWOmCSLZlWDtt65mIxT8NXZpa8jnmTmLZQYOWGJ92dY+qaVByxrw?=
 =?us-ascii?Q?4W3+BVgcMVE9G64JWy2qgtbhg3A4fIvzKKJsdc152wNZs9iEo49E6YBLyhOi?=
 =?us-ascii?Q?ZtOcZJgRBwJi57rOeekVUciI6qZOnnRgQ+otXgl9G7oP3qaIRPff5DZH4uIS?=
 =?us-ascii?Q?u04kKetNkG7zZLIM9wZdd3OlN8vda1kPpZS5wJ1ET4MkmyrHgvUdc1Ex9sU6?=
 =?us-ascii?Q?edJljfxc0TzjWSfR8hi+PAxDUnRKsuIIP9HfIMhqO24e6DQd5U2epoOyaHkS?=
 =?us-ascii?Q?NQovyfPJYZVF3pKIC/I1QnLMJt+Oibq30UO8Uh44PfJaPY2ZnaZ92t9pOE4X?=
 =?us-ascii?Q?T5u3SP9QjrQKvb0TzDYULS/F8wHJs4oCjexysL2CnHAGXT0QZgF2phdfohUn?=
 =?us-ascii?Q?CHNCqKg85klQstrCAWI20mJq8g695G4H8svrngrR3LfRTOGs11FCa8yxFYdb?=
 =?us-ascii?Q?UFoHcVRBr/4zyJ4fq0hvVfd+/2E0dw+zmVJIngFUwbdaoFeHZft3DNxpX/yo?=
 =?us-ascii?Q?PpNhIt2Ad+P9jwnPkgwNqIc9YnfAwZwtA5G60vpKUelf49bw/btdCivvBCzo?=
 =?us-ascii?Q?P6NcRqCnFttjNotBU12K+uuCIL4xVbc68xKHUgqPNTsm4jj3xU9TilwANAZo?=
 =?us-ascii?Q?EGa1INJJh1dVfeQdYFNSwNjuQayeAdB1HMpqE9OXHIsGX5tmpaRonwv6dupA?=
 =?us-ascii?Q?rKbl49V4PF579zx1R9LkfM4h/EDYZtWyE9MCREOqufls86O9bOTjaFLcY2NG?=
 =?us-ascii?Q?j4dfJpOKqEaxTlbZf+YvG7xlpxPmbMDSRaM+E5xMiin/WMsrUxuTUN55siM6?=
 =?us-ascii?Q?5oIAS2AUW7lmx/5fQifjKYfJoJHlTS6O2FoFppDZifktddnuUqwVV6RTVTGw?=
 =?us-ascii?Q?Xa74bP4ghTTOyytz7eBLN1vN4rm6K3Osz+FYNNZLCqErsVk6NAlAxB/xyIZC?=
 =?us-ascii?Q?IeXAg/HPRTz33cRzgaed+BIwj+FKBY6sTfK1UI6cb4PQwk73m4Zfm5mYPlOX?=
 =?us-ascii?Q?dftFsCxBWrTa/NQXYSFovgHsA7aoxjjwV+NBdw+CTgczSbvCz7r/dXkta0SF?=
 =?us-ascii?Q?D/IJbr093cm5PLYxGjo3xf/Sy3enl+kkIMnOpAWj7YUlu62oaSmGPJPJyTRE?=
 =?us-ascii?Q?lwEGgjlOlPMl627gahdcrrrEO2dz3uHYLUa1vh4LG+qf1CEeucXlflldtEfJ?=
 =?us-ascii?Q?W5m5vl1Aov6aie7i4kgyvW4/llYuqD6PS9/ZDSZqsDHS/DYbOS3Bt158fHs9?=
 =?us-ascii?Q?CksAw/SFDl2x0bqk2vKgteFbQXUkEygVUY2DdLl1j8QGJBbaqjDupAsA8Kjs?=
 =?us-ascii?Q?1om9dtpH2WjkohUeRpL6U6u7Z2JoiUW2Vla7IAdcMl+xnP9uv89wBtAJBj2q?=
 =?us-ascii?Q?5ifba8f5gGJeKZr2LNSd9K1F9c1yDSa/SA89gRIu+Mke8h6qvNP4okleWWne?=
 =?us-ascii?Q?+yCM71NOKN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVjlTDhvRCI+kYFkdAxLaiwHoWiaYX5+HOO0eGBmS9EYND7VTReMNQN2woWD?=
 =?us-ascii?Q?En+eUuz8BbyWZ97wYLsLGfGDLUPqvaFAn0zScWy+EGdEfRhd6Pn9AOSs95If?=
 =?us-ascii?Q?zvQrt9NK5oMjRuHlZQUeWiy9zdPKohgu9i7PaBOj7wzgv38YFrIR/G00z4OX?=
 =?us-ascii?Q?14NjyujSTdF1PYM4hp9Ld7YCviCHx4ZFE216GgD28yjxO2Wqmy5EMkOw9XBZ?=
 =?us-ascii?Q?PR2NY21k3wjhenNGuewHfer8kFhUzsHzfUHcJ/RX4nsaBVZ6ZqsDRhWnvl3t?=
 =?us-ascii?Q?6r1dDws67tVbhil4cjPTD/raXBjKKstR1DXgC66JUR3ZvOKLzsaVgfC/Hg3z?=
 =?us-ascii?Q?INTTuf1jztcdft2TYQLs3W5p/l5x3+CLX67dKuLJzU5krJaee8a0tOsjcd6Q?=
 =?us-ascii?Q?ipnFYf+6jrNaRgP7TsiLeAFCUefc+meUp5eSUPfFFtx+zRd2pHHLnqWh+Lyp?=
 =?us-ascii?Q?AmcxXs+8o8lFfmTmqIqInZaaBB1Y2WHbrdtyVwXsCQG+kfSzY7jmcv50yIw0?=
 =?us-ascii?Q?ezUQ/Ji7pnTTC2wGe0UMtizmntO6hjHrHus5pTI39jFFAd6KcuJMOE5e+b0D?=
 =?us-ascii?Q?wOA8ki3YqXoS7NuChYAdI6bL6USBaMY/eKFZdNSWxnwNrh6j2E++F/fFuPn2?=
 =?us-ascii?Q?TV0W5U0YmsNgX+xnYb6OnHWv5FVRCLlvtRMpnseTgmjFfnt/mv/mvw95d597?=
 =?us-ascii?Q?kcf4BKpAgybRd94r/wYq16Qm1Kl4q7Rav4GLJ2vLwRTYs8Ef42bCZScubFhS?=
 =?us-ascii?Q?5W3clQgvO+uqBMwhtYNRXJLo2nxXO7UT5FmXwXjND/uFW9ulJNlSM3upeF6V?=
 =?us-ascii?Q?kQvAqeyD2M8dlKipThdCdA8v2deRTYI5aq3+EajlfTvwUThq2Ig2NVYQZQ1g?=
 =?us-ascii?Q?novJu1qo6wltNm9b+5JAP8zUAzdV56tTSg4cu08AXUtYd8uBwD/32UvSQEAJ?=
 =?us-ascii?Q?X5KKaIW2AJG2cy+GRI+YE+QUKfVy7lsOuPMib9W6HIX4mbMceL7KQ8X+3LvV?=
 =?us-ascii?Q?usm6HiQNYsE5a2wT7cc5OakRohNezJih2UpBAA0jz479dGovsG6HkvVmM7DB?=
 =?us-ascii?Q?RvVrAgdfOmxX1ET68GsQ6lxYpiIpEKkzBY8BqA5NZm+/KHZgwK9H4LtCKwUA?=
 =?us-ascii?Q?MYr3kts98+fzhtLiHWOXTgX0m2VEXUzK485M6TG/JeoO5I81FYCknfqrOCfS?=
 =?us-ascii?Q?FHxyhqit6/NfHg9HE6RxyL553ieiN5L794ryrP4/L0J94ESHnJmJXPKfw14H?=
 =?us-ascii?Q?9OhiGFbl0UGvDi2f/vaxY4t5SRi6/d2tiG1PAN0JyQ0irHrWti2oqrgrYret?=
 =?us-ascii?Q?e1s4lPRrJVaydR8ZW1XKWrVgAj6QzgOWvk+MEuZxCJOWm4UaXKqX/MpcWLym?=
 =?us-ascii?Q?U3kLzoIlnwQsiV7xYaCToGE/JJuJ3CC8J2IIp34/qbqRam9mOCfz+AdrYJUY?=
 =?us-ascii?Q?XLt30RhLuaPqBHiF1OXm5HoBFCB/qIQsd6Rd7Fp/M8LNQRTVVOo8FgcXbrq+?=
 =?us-ascii?Q?nQSuC3e7aSlOd5jMP/jzwDdqGuaTOlgWrWVETA5LVLJn1xsRIUUcQ7Vusyoq?=
 =?us-ascii?Q?BVP/QNlLytDSZz6/LG0EebGS0YzdudMmliIP3K9BXHdJhOii6ojdcEwwByxB?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hvv1HE7mPKK1GzRvskbFZJNHlD06hx8/3/gmvQUu9zvrmrw5s/a8QPZCzDo9z8JfIx5Kc//tsRN6OIOPjunyHMCXS+MBpFQU7/eNPkEO1KyTTbnGrSXvFLzctHHaAi8GWQtS2SfpZ1vLcOXa6WeTtV/M3Xy3PmTvnr1OO9xv5KSOsXXW+9a3nHGKvRohbs3q2jjnPOWS89euJtS4owctzmb0c/WsXPp+Age5eRgGy/kL5vIBBRVcCBtSwXbDQFF9K8Hb6l99MufalIwngWQaEMcsU7t0ShUX4dczA/a91fdv1WWVv8rJ1po7KJtmpXDjUNpq2kn1rWqlZdxL+tPtJnXRtOlHt1NZTaBR/AeDP6sO2CngYok+kfAgMlE+iU4sWV7H2TTrShTYCSLyq8G0o6XNy7JvYsgKv87psFqMLPx7/kWNxBL7r14f1c6kKOVJXLfSKGH7srDgTxIox/0YoS5nOpi2EgHB5OcpdX7Bap0ZuxM+8HZq591mh9GLnfUJwJgqmUgZGLFyT+fgAlVJKxhaw3g+/4Sov0Vxit9lB+Dnsz86jqTF7wV6X5W2joxKbzW1g2EvlNZJDvHRVxkfdfYrRrirmZa2rJzAg2qrZOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fc7bb2-dfe6-4bec-6e00-08dd92c78092
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:12:51.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Nr7ylHdCClGYixYOZkNTPF7u4Fv4g1I9gzmPxYfC097D5ss/6/DI5nMj7X4iHGhWFtF3SlW9Hdho66FzVsRItrSnUOOiv4V//4H4rm753g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4MCBTYWx0ZWRfXx1YkzoneK1FM 4CJvmWQf8TClLf8aidZZGl0XV1KKBLZ2vuN9Ux/SwEdwuTNqTSObM/R/2Ab10hsEkDDT1vS9aJb C7F8fRcBwkWEoZeIkFs0BIgF1Ecz5h1mgXE56d++RFPd/13FLkbQPTh68bBXmasnBmFf8uCP1Un
 9Eiskd9FsF2UNgkazd4bKVfGX0MqiQqbdUGGNikHQhyneMuk3w8ETt4mHfPn+yd60u1Wd3ruY47 2/JX9Be7F7cgmX1YkqWYvGbKPLhXDG6g1k7ip8bvDEd6A9UCato7X5/mZ8FQ+F0gzlnJgsyPhhu KJtjmQWsLwfdgcWNyunhVoKvj0g2clRgTNxjzqD+AohSkeR5A8RTz3VTllzhcfwGmJv1GxNigXV
 LyS81XVliIXIfFWapuNKtYvq5hIwomieZzoaIBKCZbbdF6IXLNqUFtuWejhXF53HrQW+ISWR
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=68245eae b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iap-qV7jxApwZ7o55zkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: Upsu-CGMBjNfRvAAkENpXgSxWjchVwAN
X-Proofpoint-ORIG-GUID: Upsu-CGMBjNfRvAAkENpXgSxWjchVwAN

On Wed, May 14, 2025 at 10:04:06AM +0100, Pedro Falcato wrote:
> On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> >
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> >
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> >
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> >
> > The .mmap_prepare() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> >
> > The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> > exclusive, so we permit only one to be invoked at a time.
> >
> > Update vma userland test stubs to account for changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> Neat idea, thanks. This should also help out with the insane proliferation of
> vm_flags_set in ->mmap() callbacks all over. Hopefully.

Thanks! :)

>
> However, could we:
>
> 1) Add a small writeup to Documentation/filesystems/vfs.rst for this callback

I looked at this but the problem is the docs there are already hopelessly
out of date (see the kernel version referred to).

But I'll look into how best to do the docs going forward.

>
> 2) Possibly add a ->mmap_finish()? With a fully constructed vma at that point.
>    So things like remap_pfn_range can still be used by drivers' mmap()
>    implementation.

Thanks for raising the remap_pfn_range() case! Yes this is definitely a
thing.

However this proposed callback would totally undermine the purpose of the
change - the idea is to never give a vma because if we do so we lose all of
the advantages here and may as well just leave the mmap in place for
this...

However I do think we'll need a new callback at some point (previously
discussed in thread).

We could perhaps provide the option to _explicitly_ remap for instance. I
would want it to be heavily locked down as to what can happen and to happen
as early as possible.

This is something we can iterate on, as trying to find the ideal scheme
immediately will just lead to inaction, the big advantage with the approach
here is we can be iterative.

We provide this, use it in a scenario which allows us to eliminate merge
retry, and can take it from there :)

So indeed, watch this space basically... I will be highly proactive on this
stuff moving forward.

>
> 1) is particularly important so our VFS and driver friends know this is supposed
> to be The Way Forward.

I think probably the answer is for me to fully update the document to be
bang up to date, right? But that would obviously work best as a follow up
patch :)

Have added to todo, so will follow up on this thanks!

>
> --
> Pedro

Cheers, Lorenzo

