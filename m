Return-Path: <linux-fsdevel+bounces-62139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D17B855FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61C51C84A49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3930C0E8;
	Thu, 18 Sep 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pV+AO8he";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j6g8Lh2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88727147D;
	Thu, 18 Sep 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207178; cv=fail; b=W1Fxq1yu8IWcaX6MXMy6DUKyOrZg+/My9oQvgOspTfazNobni//AHT3clVb/4Aj6RRRYVcmysVRXDn9P5Q4VQaiLIXo6bVWt47bxRz4WDcCwKTUYe/4NFgND0mP1c0Dj52yeJuk2UBL/wNEnRB1CevU1RQkBkyxgUl58gviJszg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207178; c=relaxed/simple;
	bh=sR5JHgEUZ6wQumNNgk86NDaysXqTLwV1pddmAjld7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDZve95MSHXTARWFLJIYpMDwsfpsapACq15VSc7MRgF7CbykSdFMtJHf8tVucK1brK0bf6HxihlwmFORZSkZkRZqBmzpePzM2fc7KX6Q/qBWdX+KCh86Qs9xea6I9V+ruU5fTjQaCB1Dl70RWIa5DGiqW6RO0Ha/OrqH6Hd4boI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pV+AO8he; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j6g8Lh2R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7g0Fu007109;
	Thu, 18 Sep 2025 14:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1pWYjnf1djoaDPWk/R
	K+pFrT+08ASSx1+jpdVdhwOVo=; b=pV+AO8he3r5DDzNe9AQSfKfKQT4qchVpSC
	EtLcY7lpbdes02wMh73vE/m7O3keYjNGXqWzvMUxzZaFwI9CheTOWnacgayts7Dv
	7ZorbvW9yAg7FKXSEDMSuT5Z4xLD4LiOrLCFshz3JHfaXHasUaETz1TLxyb0Gvi5
	020hYG0iT6bri45TSmzYsxZHp6S7HnIKvsSaqPwq7Jnk2V58guODlZFztRvGb7ri
	Ljx1Fz+CIBpmKGhP5RkMo8BiIfCXuMeR8Y5RKtzyGDeTwBGZyLtpIc2iEVdEsWkj
	Dg3PxIji2zrZ2+SKz2u6sWPoeOYnJxHM9IdTcpwOxnrn7PRQwm9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kbqrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:52:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEIIrA027219;
	Thu, 18 Sep 2025 14:52:29 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nh0hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWq4ll6yDMqLUW4ET1A61Daa+u9qgZMd1OjDbDB61M+wUhQebjFTtVZ04y/Tfv/V/m/iu2xaMPhItIvlUNmBeqBipHf6un/6ZBwpaqKLYsf0iHs4IHHXO1QxUoVDMZXC5pEpUDLcUPCRjnV9NG93nVGZQhcjDd6HzFlsV6sweVMeNm6eEIKMYOM3QVqOhKGlAkESONu/3Z+01WdpD9a8sGJ+dPlpSLgttxMOYSe4uPCcwmijXgKPXVAeQRtufh7EEDYfIlzFBpvHRs1iBq/o8m1c3ZeCh6GkSUiqdMIHwxdwUVXVseHKHSa6Cd3BzE8aQn72JNVrhLu4uXN063T6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pWYjnf1djoaDPWk/RK+pFrT+08ASSx1+jpdVdhwOVo=;
 b=ybJS5KLoHr4+gwjKw9vCvUY7/jts4hU61fe95K+f35HoViXKzYzoOk2yUyKhyyxyzA9Z5szVU1wNxkmRIsJpN7B1g7VBGQVYXgPgk0tvh1MpObPu+63JBcAirGFQdm0bxLcKDLrfxZPkfgp5zLOdHON7sgL0x4nu77eC6IfjbH3GHMpk8Zw/kYwIlnc/jTJ3uoRpx3Ah8O/o+m8oll/BexVFSHyMuv3+jPsLgINp2mFvfYwSxfpX2ifplo1ylLHZi9y5J4bhTKjsg26jcPsaQhW8c/bBDpI5WRBl41rKpZmJKh+D6lo11jLFjTG7WGnPn/5Vw9TtDi1owr57gtLYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pWYjnf1djoaDPWk/RK+pFrT+08ASSx1+jpdVdhwOVo=;
 b=j6g8Lh2RgiuybiWQzT0fS9sJ+yGV9SigwCT4Zen3fpMhtRSpuGL99L4D6ogt6zm5FoJeKsdVkPZ/9UhM4GUU+bqKCaihqG2PCPB+o3PBnR1MG48b63LXKYRa440NbUgHqUxXIgc51MG7jPExpZ2p7066abAg3elOimIkdD6GiDg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 14:52:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:52:25 +0000
Date: Thu, 18 Sep 2025 15:52:22 +0100
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
Subject: Re: [PATCH v2 5/7] mm: harden vma_count against direct modification
Message-ID: <eb254603-edbd-4bc6-a4bd-57b6a85191b5@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-6-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-6-kaleshsingh@google.com>
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4876264c-2511-4728-bcd2-08ddf6c2fad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5Wv/s9bvOeOLzAryYPfgRGPaGVCfSZrsWalVeKPZGH1cqBZG3zKXVDyJGOC?=
 =?us-ascii?Q?9J1nZS4XWfgL0FC4vQyQFHZuL2JfMpm0Es8fJaokROk86uhqadIHJuiB14rx?=
 =?us-ascii?Q?00cQMJQrRhq4DaiyKwkEdUj5y/kJ02Ml8uYm1q2nMEEPI8JZFOvJ8nHtA2V1?=
 =?us-ascii?Q?juiqSh09pVAuxjls1S6MVsZwdFRk8Q9Rr28DXRrZ/E1NnElycVDOOpQkvsc3?=
 =?us-ascii?Q?8Cb46mw3xFQZTcCACoG05He2hStkci8MZ0xLia9tjDqWafLn34d7WY8OTYCr?=
 =?us-ascii?Q?UYUec24MzeV1Pqe3Gh1dk5e3iKjJFQNHN5oJnB2lZH0Qs4dceZNceSy8XWSM?=
 =?us-ascii?Q?HivRNVfHdX4UXTd0l+egEJj+KedIAB/Tl6VOqfzx1jd6GOs7mjcm1Cdt2cz2?=
 =?us-ascii?Q?JZnbMXINqR0cz0IvHhRqMj8QebIWg7PA9yG9Cx3wwKDeBL7xUXv8wQ6sSCzY?=
 =?us-ascii?Q?8RgO2o11xNtzwnqCw/ffX83R1qXtQPm1LykyUQthAhLBf2zhT5Z3i2BA1jAd?=
 =?us-ascii?Q?SFnphand7qGuOFGlvdn3iO/UmlBRrx3PYiRvoQ7eExw4xEG+yLHi83WymnS5?=
 =?us-ascii?Q?dJCBks3JK5sIbFbsMecodAQyrSS4uKpVw5Qef9aO2qjomNKuUmyp9ddDyDBR?=
 =?us-ascii?Q?BVV/hhIuWfWIaQC9NEKnoKLfrAGWB3bZUN0X9LnAWCqui1WNsvJwYORn7tpm?=
 =?us-ascii?Q?89dOjYe6OMdQQ65aqfDC+2k3cfW5CqPfvFyk2lmEfMcIyA+oC+Uh3GoyIfGu?=
 =?us-ascii?Q?iWoG/oxvTrDwgNEyfuYi+92kXyUdAd8Ha4bnAFNhQIUVxhK4PcB5ho8O2diq?=
 =?us-ascii?Q?CtNIwpC5MnrRHLAI3ivRNlX6i0kMQkLKEmxzOPWwsh1BwZmnXg24z7QRQts1?=
 =?us-ascii?Q?kY8oDvwSsQdOIvk8ZqUpOe8r92ZpWZXXqRM1xni9rCqq5QswUyGvkQJ2fofs?=
 =?us-ascii?Q?CGobsKJhGyXH3UQeDbhMEp6nvRONsx7jA0gNF7ZY0RI7jnPAq9cKQXteQQp9?=
 =?us-ascii?Q?Ida9FoLS7GW4UnHTPfvkGh2JGaHdE92cG+AlrBHyzzEaSZpIjp1ZyZttkBCo?=
 =?us-ascii?Q?CUtpRWVRcPgxIgpnAE1K7IKfNoZAgXnL6namU+UMz1n2kI4tf0NyI7tE92cX?=
 =?us-ascii?Q?a7TGUf+enHPncR0CWsy5URsiRfaTkcB7uiLYlsoVbKoBruNGHgJeEwfr+sdA?=
 =?us-ascii?Q?yJx7pARNos/5trULFK9AzjqUlKtboJg8Mjigv6vSeoBa50I7raDl/MaIPvMo?=
 =?us-ascii?Q?zKzKayTUE7WRlzBPvNPvKFXBgj/FLZDUz/txw/vR2t8SXI/YiHsIbj+ok1q0?=
 =?us-ascii?Q?1RB5lpg9h+ywbRxjE+8CYHCuQI4lEJgVHY78e4Iu6yKzYjlQSYQ8hYz9lPyU?=
 =?us-ascii?Q?8V3TBcV5h2HFCyVYB/gaz8VcBzjHSOUyidD+LIFAg6oAv65VjHTBLjWKcOLV?=
 =?us-ascii?Q?ZWgbF2PTpFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f366lktQiFDCGt91rQdouxlHh3IG9/8yoIxu7rYu0DKivTLa8n2+5rqNFUe2?=
 =?us-ascii?Q?NEMPY4L9ZuX0RWZhLerdFaA9O5xYbQAYfSdRHezrWXMpxTzMVODvLQ+Nqv/7?=
 =?us-ascii?Q?wF/aHvN5rOoIeyGVvfKUMIZsOE3Xk6gYjfAPhhrmvlynZi6zDGfRjxn8ihGz?=
 =?us-ascii?Q?zrKJiWuR+eZBZ2VQtUUo/8xJPWcUpJkt4iDFjDjuEAfI8Epy8wTLtqv991AM?=
 =?us-ascii?Q?L+QUrd7TEkGPbcMS/QvzQFoLWCZo5RpYGEchXwTZ4Pfwkw8RJ+mG71+oMAlA?=
 =?us-ascii?Q?meg6KeErZ9M3HMr7F/1b8L1bJaBZwOz8KSMYJapjyMt7TNG7Fsxgw75NG9Ih?=
 =?us-ascii?Q?QAOPV60s03nqn1g1JK7tMYxAGZWIxzLhbfsliqvraLS7bTOPI+DIBtgplhls?=
 =?us-ascii?Q?i0kv9d31XTP+i9zB/zuogD3WpckVNJQAX43usRrfoQ/XCqVek+yXxG7S14O7?=
 =?us-ascii?Q?nHexzRv4TahKp0A9E8ADtr5IrmEP8UH5Eizg7cbTPXhpDqMs44V0GKLuFrG1?=
 =?us-ascii?Q?Xje7OytkdxuRkaN2o+37pUxGKVusfLs5Vcs3S6wDH9OzFsMF+5EWbrKj7tml?=
 =?us-ascii?Q?Ewln4bGmuvZvTXlb1uc5U9lOax2pokcJrsDSm91vIX2bOh1eF/5I7pXVepcT?=
 =?us-ascii?Q?4xrQnkHrZccg3zw8+dPM1pQEP7AQ5IdG70hgB4QKz+vtHaDyOjFZMiCScrGK?=
 =?us-ascii?Q?dAiSW8i5IFmiS5KD79liN/P19MaKWfVcj1nAV4HLFU3y72LSrSurDl2DpfLI?=
 =?us-ascii?Q?ZkpJjlgSQG9IHnd+HztCJwab+uHajnQIqYl0TIzcDEpUxJmj7MKakYUYsTqi?=
 =?us-ascii?Q?9pOY5lQxlHJHF0JBEep8QDbO7pktFzlTPpbQ6LHH/dp/uILG6X2b2eGmR2/a?=
 =?us-ascii?Q?YlEtwfSb4/gESAUO8r3H+vzrc85tqVD+e1tWS9tvLDbU7Nf8iY4GEF3kO0MU?=
 =?us-ascii?Q?P4QiWRC0wr2rrsU0dCpH+niP0rfVAGduGWZn45NiHIAy5eTwQTSUNBG1ux7S?=
 =?us-ascii?Q?+4sd+cX0sxxLwayA7Tx3Oy+SQA6kG+uUwu/1zK2k16GXtD9wv54dwWRRFN3s?=
 =?us-ascii?Q?1B/VVV3uqiBbjOSCL+dLjw72+B2zoz7ig/hUc7BHlvFD8My44hRBhiZcAuwK?=
 =?us-ascii?Q?8dkNn7/VlsjVB5Hcb7sDaAoU7Z+QEFgl+YGPu0zUJUGvfX6yI4jVU/I3wgie?=
 =?us-ascii?Q?i2GYzcnK6j5d2TLy82RUUFiRJFIcIoh4Ba6+rYC+pP38qXnA4ZImY4gziFE/?=
 =?us-ascii?Q?JhsupvIab4cIuJb9q+gY9n7kyPCErBFsCXGgI9jJw3BPs7KEmn2Y9P0OG8ez?=
 =?us-ascii?Q?j06ms2Dp4UVTbWDvEERNHRXTxbXCj//+X2K2RhG7B0Ik3fjRrdFT5hmjEWj1?=
 =?us-ascii?Q?/waClnynkcXA7bFVadJHupflYHNnr3ZxOJlZbkzNjm/08NPfnJtoqzFp2Muu?=
 =?us-ascii?Q?OeN8+JZI66JLcSXP1GnBMgLx7QO02yDBPWkXvYJhF6xZF6tGf2/c/lX1cI9Z?=
 =?us-ascii?Q?iN1fGJV3c5PkiCTwZsi/TXxSFm8zTJuyP4H6vQrnDKeR7hJEWIKDCZGpjHx0?=
 =?us-ascii?Q?da97dqHl8BE2JFq7gwsjFWIn1jwaOkAL+B0ejnG665HGY8e8qAnctn6JjVST?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2LdU4r1mOhN/TBSgM5FefeyCvQGPhD7h5rsQV0U7pv09Dftfgna8m5TU4/AI4NYjA3t/V9m0Ts6ZabDkA2wjTzyQBB1GkhAL+mGVwBhCUKG5cJePWVMIFBxNOKi4KHHA7YwQqnPhkgmeJn7/57rpG5Y0W0eKy53Pz+Hkjnmh/j/8EO77e0TmW+BlWsu6iJ+wOo+AAue52X5l2AIGG1IdRvrasTV4mP2+tRnlv72NsmuvdBaJNwca85A+EMInrhIotXaqNGw87IAccjVgfvLSON+GWOHuytRRvjj4L/OoO6Z/FP6+vbsGFAZQal3//+dNOvLc7KWYk6DE+Xto/IeBhydkh6UUWAGW2QaS+2EeffFA09vjHJqk71XGfD/rl+4Zn80haWDORQPQsNS5P85BKvIxkbyN0ihafyznm604uAr3pXzpkLJcQa/+R7hZu17ufKbYkruEGPon0EL8kwEQd/bLjD5NO9VZTFuTmVFgzYVJE14saUcfXEOWElIQfXi1jTyumWbucbrExzxmY4KzwhVSBQoGRRLeEbZV1GhUsUrjAtf/O6ClZNMz5XZ3Fp+oMS5rEmnH3JuzpUl79WpIpIQroao+heJJz8FEfUyZHPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4876264c-2511-4728-bcd2-08ddf6c2fad0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:52:24.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CyPISB7seVgM7FWgtGmKPUP3s4eORSUcPb+ieBpvaZQtr+yyho4r9Qsz2HkxLoKj6U8KCNwyv5P5CuhD2xir4zZHNVhrGdV4Hs5Up/SFfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180133
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc1cae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ge8nY5yZ1GVF99pibm8A:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12083
X-Proofpoint-GUID: LxSTB2hr5KNKxGkIqvlTYjtNuYUzlOo-
X-Proofpoint-ORIG-GUID: LxSTB2hr5KNKxGkIqvlTYjtNuYUzlOo-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX5mO2IvfQzWTl
 wJX1+371xemiTq1FytJH5L3oze0nu4h4B7EuM/kqpEc7mc0vyGCOpVQWr4oBi7zbO9P/IZbGpsi
 V6NF8IGaEPrwYFUcn5fuVIPzmSG8BQP7peJrL1e/61eS23PN6mE4kfjH+jzFKtiZcEqPQb1LWnO
 +2ErhvZ2M0VC0daTl7pJgMmPzZEZ2wLPzgMkqQxwrYDSlxxBMpKA2lHJHTyfsEZlXS5hfuH6i9v
 YJppnRh/QDQkNAiitJypWZErAYtktV0rTv38I7CmmDw7YnnFfs+hYL3D9DpE+7UthNo1PDyhdzj
 7jEV6KXOuv+idrw/t0UsTnUgScGTiqWPS51CyU2h5KauX7+NFs/dtnjg3YmUq6DJrKAkdTAHTd7
 DkCQ6zNR3IVfE3R8a/bATAsU8Wgdrw==

On Mon, Sep 15, 2025 at 09:36:36AM -0700, Kalesh Singh wrote:
> To make VMA counting more robust, prevent direct modification of the
> mm->vma_count field. This is achieved by making the public-facing
> member const via a union and requiring all modifications to go
> through a new set of helper functions the operate on a private
> __vma_count.
>
> While there are no other invariants tied to vma_count currently, this
> structural change improves maintainability; as it creates a single,
> centralized point for any future logic, such as adding debug checks
> or updating related statistics (in subsequent patches).
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Hmmm I"m not sure about this one.

I think this is a 'we don't need it' situation, and it's making everything a bit
uglier.

I especially hate vma_count_add() and vma_count_sub(). You're essentially
overridding the whole concept in these cases to make stuff that's already in
place work in those cases

I don't think this really adds much honestly.

(You're also clearly missing cases as the kernel bot has found issues)

> ---
>  include/linux/mm.h               | 25 +++++++++++++++++++++++++
>  include/linux/mm_types.h         |  5 ++++-
>  kernel/fork.c                    |  2 +-
>  mm/mmap.c                        |  2 +-
>  mm/vma.c                         | 12 ++++++------
>  tools/testing/vma/vma.c          |  2 +-
>  tools/testing/vma/vma_internal.h | 30 +++++++++++++++++++++++++++++-
>  7 files changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 138bab2988f8..8bad1454984c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4219,4 +4219,29 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>
>  void snapshot_page(struct page_snapshot *ps, const struct page *page);
>
> +static inline void vma_count_init(struct mm_struct *mm)
> +{
> +	ACCESS_PRIVATE(mm, __vma_count) = 0;
> +}
> +
> +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +{
> +	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
> +}
> +
> +static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
> +{
> +	vma_count_add(mm, -nr_vmas);
> +}
> +
> +static inline void vma_count_inc(struct mm_struct *mm)
> +{
> +	vma_count_add(mm, 1);
> +}
> +
> +static inline void vma_count_dec(struct mm_struct *mm)
> +{
> +	vma_count_sub(mm, 1);
> +}
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4343be2f9e85..2ea8fc722aa2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1020,7 +1020,10 @@ struct mm_struct {
>  #ifdef CONFIG_MMU
>  		atomic_long_t pgtables_bytes;	/* size of all page tables */
>  #endif
> -		int vma_count;			/* number of VMAs */
> +		union {
> +			const int vma_count;		/* number of VMAs */
> +			int __private __vma_count;
> +		};
>
>  		spinlock_t page_table_lock; /* Protects page tables and some
>  					     * counters
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8fcbbf947579..ea9eff416e51 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1037,7 +1037,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
>  	mm_pgtables_bytes_init(mm);
> -	mm->vma_count = 0;
> +	vma_count_init(mm);
>  	mm->locked_vm = 0;
>  	atomic64_set(&mm->pinned_vm, 0);
>  	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c6769394a174..30ddd550197e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1828,7 +1828,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  		 */
>  		vma_iter_bulk_store(&vmi, tmp);
>
> -		mm->vma_count++;
> +		vma_count_inc(mm);
>
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
> diff --git a/mm/vma.c b/mm/vma.c
> index 64f4e7c867c3..0cd3cb472220 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -352,7 +352,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		 * (it may either follow vma or precede it).
>  		 */
>  		vma_iter_store_new(vmi, vp->insert);
> -		mm->vma_count++;
> +		vma_count_inc(mm);
>  	}
>
>  	if (vp->anon_vma) {
> @@ -383,7 +383,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		}
>  		if (vp->remove->anon_vma)
>  			anon_vma_merge(vp->vma, vp->remove);
> -		mm->vma_count--;
> +		vma_count_dec(mm);
>  		mpol_put(vma_policy(vp->remove));
>  		if (!vp->remove2)
>  			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> @@ -1266,7 +1266,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	struct mm_struct *mm;
>
>  	mm = current->mm;
> -	mm->vma_count -= vms->vma_count;
> +	vma_count_sub(mm, vms->vma_count);
>  	mm->locked_vm -= vms->locked_vm;
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
> @@ -1795,7 +1795,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  	vma_start_write(vma);
>  	vma_iter_store_new(&vmi, vma);
>  	vma_link_file(vma);
> -	mm->vma_count++;
> +	vma_count_inc(mm);
>  	validate_mm(mm);
>  	return 0;
>  }
> @@ -2495,7 +2495,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
>  	vma_iter_store_new(vmi, vma);
> -	map->mm->vma_count++;
> +	vma_count_inc(map->mm);
>  	vma_link_file(vma);
>
>  	/*
> @@ -2810,7 +2810,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
>  		goto mas_store_fail;
>
> -	mm->vma_count++;
> +	vma_count_inc(mm);
>  	validate_mm(mm);
>  out:
>  	perf_event_mmap(vma);
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 69fa7d14a6c2..ee5a1e2365e0 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -261,7 +261,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
>  	}
>
>  	mtree_destroy(&mm->mm_mt);
> -	mm->vma_count = 0;
> +	vma_count_init(mm);
>  	return count;
>  }
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 15525b86145d..6e724ba1adf4 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -251,7 +251,10 @@ struct mutex {};
>
>  struct mm_struct {
>  	struct maple_tree mm_mt;
> -	int vma_count;			/* number of VMAs */
> +	union {
> +		const int vma_count;		/* number of VMAs */
> +		int __vma_count;
> +	};
>  	unsigned long total_vm;	   /* Total pages mapped */
>  	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
>  	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
> @@ -1526,4 +1529,29 @@ static int vma_count_remaining(const struct mm_struct *mm)
>  	return (max_count > vma_count) ? (max_count - vma_count) : 0;
>  }
>
> +static inline void vma_count_init(struct mm_struct *mm)
> +{
> +	mm->__vma_count = 0;
> +}
> +
> +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +{
> +	mm->__vma_count += nr_vmas;
> +}
> +
> +static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
> +{
> +	vma_count_add(mm, -nr_vmas);
> +}
> +
> +static inline void vma_count_inc(struct mm_struct *mm)
> +{
> +	vma_count_add(mm, 1);
> +}
> +
> +static inline void vma_count_dec(struct mm_struct *mm)
> +{
> +	vma_count_sub(mm, 1);
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> --
> 2.51.0.384.g4c02a37b29-goog
>

