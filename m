Return-Path: <linux-fsdevel+bounces-62129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A4B84EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687B37A96CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84361F12F8;
	Thu, 18 Sep 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGNfXx7o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WLo70YUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3001DF74F;
	Thu, 18 Sep 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203661; cv=fail; b=k3ykkbtTLksaXPgfhk2IPBFScKBrz6TS8Jrjc/aueo6yEV/2XBRM0Mw7iP66x9TRY1By55wq7Pg6fKF0lZZOvZrICNG8WH7NQdZIgn9a7r6aMkt9g4xq8mud4vYdHzVJbPqrpKlQA4gLyKL0El+xyNIeNjMFRFvETCxkTDnwDgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203661; c=relaxed/simple;
	bh=OmMx30OR9K47yVi3g+H2u9HmX+NDG9BF+DdVn5rV8nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdFwJ6adAwO9JxIy5pSFHjtilXONpmtQ5qVS8kleL59PbIyR30AwxvXrHAYa/1wnOv0QPGp3QAmW5oT9BR5YRxcVAoDLLJ959jEfAooW9Zpf8nkI+zbUM0IqnrUCNp7RGYAP59VZ8EYXWasL/CRAq9IMewLjEqhhYlu6g/zbo/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGNfXx7o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WLo70YUf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fuAf025171;
	Thu, 18 Sep 2025 13:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z50a8U2QFXyexucU4o
	X35FyAEOGus+a8UFUqZYJPGHo=; b=CGNfXx7omVOhXJl9mDrE7MtuwuxwNDNXy7
	ZY5OxcB4jDQqE+cHx1TKgsDeNVcIFnJsPgCfqehvIgmxoO3/E7eotW/dH7ADVzZ+
	6xHZgGfQpvx9x27IXSNTlwUtl6U2Z+Mx8ApyDKmFBQQk4h/RHOFbWSdz2tgMM0G7
	O8PawimOC+fG0Vzr0Q8/GwFs81ODlCdibnksKRoT3wt1NJxYTREUuKrpNFmvJDZR
	z+0MJfL6ZNYEMzjHF78cMp1CqqLu0ZSjZebgpfussF+6sgM7CeqPakW6ip1zVGe+
	HsmdD87ka17CCO6/pHIsTaitmPGYvwp0ZTHLv3cjP2SER31Glv1Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb3hek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:53:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICxbjT035235;
	Thu, 18 Sep 2025 13:53:45 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nfj20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5iQoBwWndX0o/DB7R1x858U0zuMdgVkLVIMLgWc1ONZZEjMuAwXdGYBA15i7Lpkb6VbilBEGLeZ85MLeQhi/djVBGwP8PxiKeMiE187mgEmhxE4ah+l+RObgKWl7O0CLc7Do6XVogQvpjWN4Fm8JEEixIe7VyQ+vhIlRxVGr1bu/A6uT9LH0LxBbFxO1U97cWay1bxYnbn/5IO/kWlMthvn3uze/+2/RKb0gaQdnhQ/q5dGqvUbf40/Mf2FRG9W6u11gOJJkL5ietdEYE/+JS4tvV8OFAoxNJIZJGlyw1o1nwX4lhMA7Tc3zBJKd8y08WPFxOvBHlnDKy5MrqKKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z50a8U2QFXyexucU4oX35FyAEOGus+a8UFUqZYJPGHo=;
 b=g6qLd/qG5sOe/1+NvC9Phv7VMcAQtuN7FxQHkME3azDZtFM4TPY4UknYCDa0Z2tY1wbOZjaBngr1Bxf3PdqVo8z8PnzzbmQYXJLpUeLnWHuOKvNo/MC46dp3E5vrUk4tM9BV2eWpJk0Mp/Y1BigxlaBj5G+x82WdjKqRNl0rFmGfE1bMBboBS132ZLuwnYHwaW44TgP0gNTWHx1KPYIEAHftvHakrAdlDT64r5sCQKInebWrhWa2jVRoTl+mktE+5+7ckLkg+agAG/7lA0aDb7jnVKDoPbhHjSVyGS6i6nOW0fyt92LM2T8I3aJFKZM0AOYI1jitjSPZCtjCpiy5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z50a8U2QFXyexucU4oX35FyAEOGus+a8UFUqZYJPGHo=;
 b=WLo70YUf0kgbDsvy9TQ9I1luOMitJVOWLYQ+J1Mj1SrpIlrvF7qecrzmUZvN1uHG8nmoRfDUySwkp1abI0zX6Vg/z5eIRVhSSBKfABm15gEVaaTZA+hypq5pX1zMcEwztQ2iU0vi3LZPPblt5+R8/H9gkf9cqqKDLqNCuNeT13Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8127.namprd10.prod.outlook.com (2603:10b6:8:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 13:53:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:53:42 +0000
Date: Thu, 18 Sep 2025 14:53:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org,
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
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
Message-ID: <cce3596e-101c-4da2-8e88-1fa2fd943fb7@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fc2cfa-bd79-48c9-fa9f-08ddf6bac742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3OJ944yeKuSRooQueaCu79RsSa4wtWZzP4T/J49exJhrCILm0OPQepM0I95g?=
 =?us-ascii?Q?y5OXa31jPPvHzAMs1rUpnD9hCzet6zXEwvC1ZPok/pIRmkQhn8/G2mc/KoPP?=
 =?us-ascii?Q?r+FAVriwkMg6bHYC71m83vg6fh9ApZA4jQ8nNohPb8Kh6KRDZW6NEJKeRzni?=
 =?us-ascii?Q?6Jhjj7w5b/9C6UZCI3E9JHMD0fWtNKoeKJucl+zErTpTJYan3nqLmOlciSx6?=
 =?us-ascii?Q?M+hjBaA2vheu2LMHZ8K+Rmg9RUVGAyP8hmshzWxsvSQy6Tml2ZPfZZPpAIPS?=
 =?us-ascii?Q?BZsv95Ed1+o7hDDdA7BxlIjlbOHrV9/NoFhXZ9rxSm4N/cWH1mAZZuAsrPVj?=
 =?us-ascii?Q?lCf4JSxcItRDCw/+RE19tOvfbhjZ6YJqJ+ralBUP5eAUf4fWGD00Wh5lILfz?=
 =?us-ascii?Q?djkQpFmzWsGG2B1W5NE5nOCjnoMa7eFmz+EPVyHd2YMQj99qRcaB1ujWSojz?=
 =?us-ascii?Q?swnT4NKZIydlcpCmEpkMAFWhIjjzfrXq3Rg6njDGKYsGMEUvrDVShkDKeJXn?=
 =?us-ascii?Q?g5YKR3hUWOxcXax/LVgBMltjB54ecRvh4sLpLXrKeW64cyq4ZYJ3bD+dqcv5?=
 =?us-ascii?Q?rl+/fLnAcgg1IufXofQtg385zYRXgboqPI9JKkuKQHklPlTAFoAlfemVWOQQ?=
 =?us-ascii?Q?9v3AC/xSn2sU3JeO0bgdZ9WBaiinmujtwmq72LV37fyrVmqpM8sR4PrNRXRL?=
 =?us-ascii?Q?2H8kASzK3jacon4loC79iQLXOPOBtmfZUjIzD9iCTgvxJMM36MMUQLakW1+2?=
 =?us-ascii?Q?CD/I1/aTAPxWne42QlRGY1QiyrOtxWNxjOPX4xouPHoI9Kdb5w8aa/0/R6EG?=
 =?us-ascii?Q?lpx8jSfIQKmOZeF3dh9jUIztV6RxwZW8IHHU85DJey7VvAZiyptHxxm/HQ8t?=
 =?us-ascii?Q?WVttAgPdsnm0zzsasmUewxzCrkp0wpYP3//vVPbwSSFIrKcBCTy9T4dowrKf?=
 =?us-ascii?Q?DLU20u+JoBPjgqiEU/YwK1hwZ7KL6stptimIyIwYJpJHRth46LafAYgvucmm?=
 =?us-ascii?Q?QLHyJ/nTR4ZDPv2fa3gDmd1uxqyuEphjsSqwUqn1QlFLukzeD92E8OEQicQB?=
 =?us-ascii?Q?Zk4MwUu1sN8RFbUJKFWe0t2NUdNJ5UpNySaAA44+62EcQ63hVZg288X1iO03?=
 =?us-ascii?Q?zzLMRuOcyXtFywkU1JOE3ae5KzNCOzyCkipeRDO0XSKmNRYY31kuL2ng7mF/?=
 =?us-ascii?Q?3sM6uXxJ7KpRb+3eHrTXeac+lmwVHcgOGbXqCCmkL/pM3Vv7OXo8UfzCY+cU?=
 =?us-ascii?Q?NRorp6HK8xvOpUOfUnl4mhQHR0j/O6L3+QRKNA1/obheEm1I70DV4Llichzk?=
 =?us-ascii?Q?/601cNHYWdjJ+gQbSDYh7xTMFLvqs5sG8+hjON74KEELk8m3Po/LINx89YMc?=
 =?us-ascii?Q?WXjQux7Wi2h9OXqbha2zEPHv7b5GJdL6bhrpMGmognRoaS9y0C+o9XkAsgLr?=
 =?us-ascii?Q?wstF1jQPLA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vzRxXh94u9a2p3L314318aY/kvkp8NcWqIRMw1QCkdJZX9Yc0q2wjYH5XWs?=
 =?us-ascii?Q?K+cz1ZtXow0X/500GvNWach17IFCHhj3HFi1WpFPVML3FzD49zLvW4myGgEN?=
 =?us-ascii?Q?6apWF7VjqsRCHignnAQ84YUaKEOJkiXz0BCYtc9s5qr/Wn6A6SPvF27XtuST?=
 =?us-ascii?Q?q4Lv/J+76S3KvmX4kcaLqzUtnp8suCqaMNcJWQUnQ355maMUNqIwghvRy63F?=
 =?us-ascii?Q?4X0oX/dWdMvasSK0K2RC5fnqsGtncCwdw8qugbMHxUrO4sC4AanGsoBQwetU?=
 =?us-ascii?Q?sks+L9ucBjWxJHuuuez2tVCT5VdOAJJSRSWwKr3e+WvtgMYs1BSm18eVVyPp?=
 =?us-ascii?Q?ffXqKxtndScc7MqHaJfL3Xt5KJrv6u1XkpUhjszYe2IgKNyStG4nMkxsMqGO?=
 =?us-ascii?Q?Ru6Z2aLYXSnTxK163k3HWjuGq9xDYtniKEuoA2AK+mtflIzCe/+hjrmC+GNL?=
 =?us-ascii?Q?UjYPdGgZh0bHLRlYA+u73aMhcA9bY065qTVfrAlSAe83aMFw/x0s90p8JMpr?=
 =?us-ascii?Q?OEng59YkhQViOujJN3mqYGGubznOpAbvqBkxqsxeoALZjI2EGAhTAVSLaVdO?=
 =?us-ascii?Q?eaYTpzK9KK98YC1CBL+CyfZ8zx7RST5SCXaVTjxp3fsU2o3XjU7gS/V/l2Lw?=
 =?us-ascii?Q?G3/6NNnVcoj28MVc31UxlpLiOPUv1FYW4wWxZUFJKZOFdcBD0QIzuPPHFccU?=
 =?us-ascii?Q?/dLZGZS490VJAsLvgeD/UtU8g+YtuCzAEHnmEq/JZkshq9sOhGn9dVIBDkB3?=
 =?us-ascii?Q?ZJf6s+ipDynuS/OHM/jw7HDPMcNggtvClwYrvjOv47yslMBRa1sBRjYvkKOB?=
 =?us-ascii?Q?onkHVancDPu/lQMOsPf4jtColwJ1fHyTjKNEMk6qvcjavB2mcujnIiIeaPvg?=
 =?us-ascii?Q?6Lp+DlsNFBzd20gfYP7HUUvSFL2+nU3xzkr9aqeePgL6zR0NHWaCFdL31zeH?=
 =?us-ascii?Q?EhgqNgZBGvB34zBcQlJ/Huw4El0RLjo3EBMgP+8DOpYf1PZkOqthi+iqfuh+?=
 =?us-ascii?Q?86sFEcmdZLwTUjt/AUNxA7+QRGWEXLHhIpgvTvrEFK9OShTx7wzzN5G4onEF?=
 =?us-ascii?Q?2/a0v/4Z8OWTthIuJ5gCA/VEiEWcN2ybp3yV44MSuBT0AAxecCvVExui/lWb?=
 =?us-ascii?Q?NPNofakAECydzBTFu/AfpZxWJZMSM31SBKYVsU9+2Mv7EYw4mZ6sYpQvP0Xg?=
 =?us-ascii?Q?gHL3tpahdSLNq0xuT/AoC65LirBLasQhQmObCF2xLnZIo/EiPEb8P83Uvtzv?=
 =?us-ascii?Q?UlOhiwc1lFva4tU+NJxWmEGVL+yzdu2nSNMh7nckEBLI77xeD11kwx+0RPyb?=
 =?us-ascii?Q?w4J9j+4d/9/6xwYBqA4a1S2+XRu2iipzcg7g8fseqWekxq2mzPSdnwY+keSW?=
 =?us-ascii?Q?S4scfFBljWZNGK2UbRduOBMG+QPiQw6qSAtawJDDu39YzPuWWFw3bewjgV/Q?=
 =?us-ascii?Q?EkT7MbAGx15xnSJi//+xZJEiLlhQg7jOXIn1bk+Y7fL9y0eER4TY7HnDRZPN?=
 =?us-ascii?Q?N2E3t/Wjpkp3F1HXuRHbZAUB0oQwdjJUPkjhWCdy6wmMSKwFYBdac58Gt3ni?=
 =?us-ascii?Q?nc21E1aK4PUa8pIvARncgzt7xIWloWWw7fCc9nwZ1vBUAHSRNFGjmhPO26F4?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WCy+XWboyrgO14/OUZEgMVuySTIVPiMnV/6WgBOnX/zKMPWpbHSNnhwjYtjNB8zluqNPFgB1MeDG7LLLKn58naJYlbS67cjQ/8I1frfbZ20fsxqYxCmhtDxTzIP36zZ9PHT2FVd/W80ODrbd5y+r7L77GqC6d/sExqcZmgjohhc3HzE/gPuAomXXdNUzORp9OO6O+0EVwBK71lIcfwvM8DkGYY6naW3p8Fs6JJBhbtmPj7ICwSUgUX/S8R5Y2McaWcR2/fng1oKWli/Z6raNEpgV5Jsgr4Yp7+chcpgf3DopsE8b2hGdlUrQieiY7ra66p0eFJoa1rtZRlmcRUmMt5zTvwlzzmKtTrU5r0Mzo9FkU4obhXseMLMJlIHpdwwQrAtX5BS4ame9A/4r5lbQ2p/z1NZY51FIAfexoLW92ME9vLEaJXvfkIoOSRmW+h4YSDbub0pgT02pxs+R69mdfDDeSS6UaFmYVKhGPswAazUttFPm5anazcWplXOGe/ZYZySrVD75i1GYjlal9NMJ3nQQhbotBEEm9EqLKQwmz+NDeGT2htF31eYLD3ZeB/3Bs1tDgiaeImvZ129XOgVXJlx8uBPEl4bkh/YYs1pd5aA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fc2cfa-bd79-48c9-fa9f-08ddf6bac742
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:53:42.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDFqhYRjSHfq02vj7TXNURjUTsWz/KxFuoygX6Mi2scpNXCQTdmEs6oIXvZ8ZnWqkWZLaHgnFWs3aTpwlxNHs8b35aBQ8eWk6fJuPSTUm84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9YapoTHXpXui
 i2exf1spBRXPLEAPaFZakAPjRm2KBWmrvTP3aOasm+3X9hR8u3CKauK5nUhIQ/yX0FwS2AMQ6KM
 MNYrxQkK67MdO6oOgCohp4y1UcxvZ8GyMcVfyiDRjeSXvgM8MtNmtnzCQti8komukvcmEklcbWc
 TDNFb3PDG/pKWNr0gXgf80VO2oBrlW1L9PdPrIq9w1LXJLhQTmwYTaNu4Wy6EA+aTRkF6HGd1uB
 UefPEgJ7GvYKqKclRBQP239xq9Mpl+EvIKZ3R5GVT00GqfNjnHXKgmlN4dp4ExvqxOoSPW+wzOG
 Sw+ceT6AI772wZUh6P8ehrYGIpv8OWp9Pzo0MN8y+wBcmNB+3Q6+x3nODwA3IACd2IPd8sZ5S0W
 6J6zsx+Ajy93rKLWIiQIb3GX7hWejg==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cc0eeb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=DyYKtU8DvG_RnbHTk08A:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13614
X-Proofpoint-GUID: JajHhxxGdHE6RGqE6fOVKPwksbYCsRR5
X-Proofpoint-ORIG-GUID: JajHhxxGdHE6RGqE6fOVKPwksbYCsRR5

On Mon, Sep 15, 2025 at 09:36:32AM -0700, Kalesh Singh wrote:
> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
>
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
>
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.

Nice spot :)

And also 'doh!'

>
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>
> Chnages in v2:
>  - Fix mmap check, per Pedro
>
>  mm/mmap.c | 2 +-
>  mm/vma.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7306253cc3b5..e5370e7fcd8f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		return -EOVERFLOW;
>
>  	/* Too many mappings? */
> -	if (mm->map_count > sysctl_max_map_count)
> +	if (mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>
>  	/*
> diff --git a/mm/vma.c b/mm/vma.c
> index 3b12c7579831..033a388bc4b1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>
> -	if (mm->map_count > sysctl_max_map_count)
> +	if (mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>
>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> --
> 2.51.0.384.g4c02a37b29-goog
>

