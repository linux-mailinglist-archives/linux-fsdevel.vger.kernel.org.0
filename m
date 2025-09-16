Return-Path: <linux-fsdevel+bounces-61715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA0B59313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666FA3A7CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414BA2F8BD5;
	Tue, 16 Sep 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oeh5BLXP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V6QRjO2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E12E8E04;
	Tue, 16 Sep 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017554; cv=fail; b=DPRpTUNaWMwhkg3fry65kEYrrPIF24FBTIQn0etBwXYzouRWYn3IjSQgfHQ2JgTzCEZ0DO8VstOwsCbJa7a9aIYiuraVt/FkMm8MvSaBXHzzCXB/fEMj7uKwaRQQYa9AqH+ffNB66qp+l9891+NIuSpZ3WzZvF8DAu5qrTfNuMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017554; c=relaxed/simple;
	bh=oB3m5YcIWph2FDStFlDwh42pF5FSoT22KUivTRJ52Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pk6/sj8QZ0wrGZ5SspyhgYuKKBtqtCjCC7K5UrYiHps5m4k7RMtI1yE9t7q6pXuUdwbWDwx60kMqyD3EREn62pPbSDg72G8dXne2PR8C8inFP8u4kszmE0WSacKSWrRtqQNpdjTIPaFQ+c2titojpEsy0REIE//6t+oj+Efgk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oeh5BLXP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V6QRjO2h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1fwDM002166;
	Tue, 16 Sep 2025 10:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Nz90XWyNVdL/kLbzzU
	CBT0MN+ibd+/KniE6vSmRhE8k=; b=oeh5BLXPaWP48AEXmuGMrThqvpK8fYygD5
	pFcw82+LEMej+W4orync/0Tt/WfgDbxeZGsrBei2qrIwwZf/KRXoiLt1QCn+16Dt
	AKw53/lxXCGleVKfvUkhNhestyKSrpYt+dU41alF429IylMJJwJR6gHAl/+Hqu57
	zikyZJ0fwLx56CYF7/DwAkpMpqPc9tTL8ygy8zT+jvWMsHc9NRJKVfdFrRaqOIVl
	9fWtEd0n/VGs1eRl1uflLPHDWy1r+he02VzYNUwh4htNoEw1GiXJenTUb20DOXg9
	Nbcx0g8Z8In5/4FtMkvh5IZBJLwTro5firqrucYyEgjY0yF8BlgQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf4c4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:12:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9QEUj033672;
	Tue, 16 Sep 2025 10:12:07 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2c5ujq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll2T8DcUZ6vMuH3jg1lQo9nQkvXTfT0Q3iXnLzDv6+heSVx42VnNqQoaIOnuDTo48dW7miOrwWQUwJMQtHd6ZnHcqHDPR9+6uMuQPz6Bd7O9GnGXsGlhmdDeYt0eywvT9ud4dNoqUX57xLZw+83752wzxUtiw1U9XZf3k+lFlPA0iRafZ11UJB+CUoph1wmSmKCmxfeVaCDtAKb0Z+W+a+jHAw0YfwD6QBeHimSQy1khmyWb/X/qLmGuCXorEnfnRAq75dOVkWPasgahMQnBMNoay6QCXnBGvoWWuc3sFbaWslqnYPFyVjn/ZU+n/ySB3MhrjhPS3kCCpqpn7s0j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz90XWyNVdL/kLbzzUCBT0MN+ibd+/KniE6vSmRhE8k=;
 b=KfgMeHYuSA9O/XfOaQBmagFgPhDrCm4oW2ez7nYjYbo3Y0KmUulOjIQ3i1YSJJajtDYg3vu4wnUFVD2Ayd4NSqfTXl/xux0kqM5rNTeYX+7eN2gTYkLIz1+FAvAg8CEcMkSRzs5oVOB+ry3eeQA5adJk8VHZW6AAzUVvhTbcnRJ5dJcq9WxpdmPvCEzqeEbF9TvLI2qEuQ6mVueiyDxvLXfo9hV8mhIRaLlqH2n8Ls2D9B5m08l1MCRsTyLytY4kSv+BJZ6ruKuGCKvEaWsmR2xMFT0Gxlilb0yX3wJ1BnufzFxL/5HzsSy7KF83EjWeHb1hiQvBtA8+d0zs+8yeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz90XWyNVdL/kLbzzUCBT0MN+ibd+/KniE6vSmRhE8k=;
 b=V6QRjO2hyhYrBgK5sh5vaKU+z5t5F8sKTFnsFeS9sBUWKh0LGFNfjeZfqnEJEnXk1a5Z5E7cBm90lTfhet5ljP3wClE0jH66y5VDatn8GlBMOilB4WArfymCQCYULOZSjFLJfBGmF6vI5FzWiNwDXEyFrBpdp9ARiOelWQaRHvM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 10:12:04 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 10:12:04 +0000
Date: Tue, 16 Sep 2025 11:12:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
        david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org,
        pfalcato@suse.de, kernel-team@android.com, android-mm@google.com,
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
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-ID: <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BLAPR10MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d777016-5962-483d-8ad4-08ddf5097c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Akgc07TR40HtdGPWWOxKJHIDr5ZCTVsBQzkpfk3kddLTa+FpN/6L13Au/yJw?=
 =?us-ascii?Q?CKTWcWa3mbULLEtHu0L3l9BaIE6Gkurtj369zblHgHpBZUIqL6KLt8S+fbVJ?=
 =?us-ascii?Q?A22SLRJUpYxHUmXf2uVFoM0MGULsZE1bs7RX3+9p5lkJGivr9EiVAYeLtRGc?=
 =?us-ascii?Q?h+SEdFyc/pcrc3amtJJyS5NRPW8bpMmHb4MvgJG75lPqpGe+zWWryB4Fedl5?=
 =?us-ascii?Q?uKct/voMDwtjvP8rDpgFLdVoyLSp53ro1vFoYst41Xx64O9oZwdofipoCvT7?=
 =?us-ascii?Q?DzZfzus5MayCTXPRpHe7cK+JJJoVRGIzJs7cE1XqJ0uAElXIrw/Jl4FNfWRm?=
 =?us-ascii?Q?kyAEo2gsCdNt0uHh4XxPtmsk1PqF2q7fiserXOabskAfSeRQ6XYWMGQ86Z1F?=
 =?us-ascii?Q?VZdtrBRu6Z8vdftqaAkr4ejjqqWOtKliZKZgVZar+YRFraJzH0K/R1D+Wz7V?=
 =?us-ascii?Q?K7WFul+mYMnv6LJ326xMy92gwdCntItqbEOHGQraa7plklwqyRSYwGxHNine?=
 =?us-ascii?Q?86ZfDwe3QnxSM9nqWdu0mhkYqaPF1r2QWMznZlS0PtsEFYwld65PLmNnaL+J?=
 =?us-ascii?Q?FkFlLru0Xktc7qTn0NW1vnNXmYsbgt4Ru//Q6cnlhpM+pAnuzRtnJyO/Tzyg?=
 =?us-ascii?Q?FXuGr88Ao11UVwLQwPVhsTRfxZ0CAqqfkHQbz+1D2J1xwE4wYZCV/7Bebs/F?=
 =?us-ascii?Q?NiJ1SFVMjIO+kC/Ri9kkTXChNL1YwQjmh5lZxqFk4XZjzu+MWxgYxvXDHzi5?=
 =?us-ascii?Q?QBochMFcHOe4ReHX1WVuJ582Jj1niJPWkhzEghZ6WpVPhh9Y6wzT0KspxP0I?=
 =?us-ascii?Q?BPuIIzrNVM62nQqoMJKeakhZLQCbi6b7/YlTXiYcD6rQPC8HzxQXB57hsVGA?=
 =?us-ascii?Q?9KoUag/JDfeqZpVVhXKj2dQYjAorINFSGZ9Iv/5RN1mZ8qzuEawOxu4GRm0P?=
 =?us-ascii?Q?LsX3ZFPPMBzgfcysYLvE3OfKbm35brkDgFEDZU+Kq23bLrNMnnyY0mcoIRha?=
 =?us-ascii?Q?LVsSLZGYkJ/0ZPtSi2FZs50eDp3aralMm9kmbrQbzQpNgmXa8QnvMCd2dgyx?=
 =?us-ascii?Q?fAfP+zLiX77j6KdT0Ff4xZpJ5ZgL3rM4Q5iv9H5NIrhjTtsddUaMTFX9qWQh?=
 =?us-ascii?Q?wGmfcfszfXq+sgOhWP2zPL8+80P6Z/LkMFXNlVyThXPvUcKvi6NW0FtIir1u?=
 =?us-ascii?Q?67wpubkqoKDQkukFqxrEq/JfaQjxjiCJBHZjiXtqjcx/jFPh2irPJKFAImpc?=
 =?us-ascii?Q?+UhNmNN1eCEr/ImpfYS4iA8u6SPWNBuJcctpScy3M1t/5ZPsOjDF/JLHZQ8J?=
 =?us-ascii?Q?IpBrOuv/t5hm04VR1vdbGTlWa+vLsE3dq3R/ZLPRUiZI1sHUqRQWyMTsdS1k?=
 =?us-ascii?Q?4LaErZG4NuMsQdFttlCvzLRVCAnfVEXTtGh65mufxk23CSGmTRputAvok24A?=
 =?us-ascii?Q?/OBawjcmB+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXD8fnAyy67Fa44z/zBBXYVIaRwQP7XggVsnnF+Uv0d+QqhgIugp14RImXmf?=
 =?us-ascii?Q?Dub1BpxROWTQfbLckkFZhtwaTiDEIIR8M8HqgQDgdoX2IOfDk/0tWnRucDfG?=
 =?us-ascii?Q?t4pMutHoeFruHA3xEKaY6TqNGOzO2nrVnqeaRN9ew1UPpQ9pn9z4+HoBFyhh?=
 =?us-ascii?Q?T/QsSwD5tVlMiyyCj6Vb3UQyaLtIWJ8cXwCuVK6v7Txx8bFYAdj7hyC6Jyhd?=
 =?us-ascii?Q?lADUa/6q4PkV2R9EQhWjrqIMIXfCve9jcUA/PD2nNf9zxLrpd8XLWXNSUInA?=
 =?us-ascii?Q?XTfndsDJHfezWCFN80aw7PHttanmc2itXOOv8AOL4aEQgVa0Jx0Dq3CWfVuY?=
 =?us-ascii?Q?Tq9/aOnhHc3LbWXajA5cuc8V7p4geyn4zhlCqUMk3bRC3mulvYa95o7RM3fp?=
 =?us-ascii?Q?gIak4G1g+TysaIzGzXStxLG0gMAJlAcOePzaRC4zi/BJWjj4wlBTDyQTw3pE?=
 =?us-ascii?Q?qOQnuFBTHX3Yq0bJpsldPq7L2QCBcS3cXw62cxBFNDEyhWWcm/7R8MmxvJ9N?=
 =?us-ascii?Q?wmepboxjMnBDtPPjYB7y1W8P3WAEv8TqgIfiJbD8Q5GSFscd5r6VTaQJkY+Q?=
 =?us-ascii?Q?Xdmfy+6JKr+ww1pdqm7hRVbx+O1fNPzBu/u9ictkD13zipObIzR+yhcOoLi0?=
 =?us-ascii?Q?hHYLh/uAQ0liwK4hcEQfp5JFwktOIC20+HPW8gaAuXuH53J+NN/yJI851fcH?=
 =?us-ascii?Q?7yaundJdmxPLH+fFs03cUoUnORBlc/pZTaDV7dFuxkmlJNoWiFP9kpxG6Ua4?=
 =?us-ascii?Q?7JY/hZy2RnoLMPVfTXDOiZfIUNGf1YfP0guXNAi1btLlVC8O8ImXCLKwgrt6?=
 =?us-ascii?Q?js+w2LrmBNM8qay0OI+lRc8oPidgxYWyMylBU8jKaP2W+zWHeveolfUQFjiK?=
 =?us-ascii?Q?2/LdwkhMNeW0qq/HUtT6wAIhyVqnHz2kTGsOouAY3qOi5KQ5X2QxnHG1sZOq?=
 =?us-ascii?Q?TCSeEhUOIkRc8PkiChnhMK2zLXbfhv+NDaKFt5Z6kfHiaxdVKiu+chkDZM+8?=
 =?us-ascii?Q?XJ6jT+gSxPufGgTyifnwCqLKpktCYTokGZXoxUPNdBQwPledN+XJ5BJL80An?=
 =?us-ascii?Q?VPsuK32c7c90HlxoKCGeNO9A0jAIWGmATX1X8BkhPFsgMZ4CIbUsyy83+jQd?=
 =?us-ascii?Q?sDlpcaLfksDqeQ5zZInoTR7wiTde/UJ0j5sLVmqWKCuPT65wtm9XlDwlS/Ie?=
 =?us-ascii?Q?9CKEDuESeoySpcX18u7YZF6DxGmWgsANf/7U4WpsvrViTMDsWonJN2CquVl7?=
 =?us-ascii?Q?gpLV57F8Gkk62rdQlqQ1J8YGRmX+TrdRTkdIem++0Q/ctkQ5QKlrU2xNJlQq?=
 =?us-ascii?Q?5y8XxtYtlIavGQN3WfYUlRUP5MA/xxvWvdndj/Hiy+ltUXP3C+Znxeg2rrex?=
 =?us-ascii?Q?KJ3JmN3sYjcwDStE2iwnpf5u4S2NjPoNSrn9YdW9+J9cHYGjCqnF1MuM0fxM?=
 =?us-ascii?Q?WF6XpznYMF67QuZfSEctFrZrWPc5zxubAsvT53y9/3J5PBFXaaZrHynj2iQl?=
 =?us-ascii?Q?lfAcyEdZ1DkkqnX16rbJ6DcdUJr4+uGOtS6FohkVZd4v6+Kz097UhbvxdFvg?=
 =?us-ascii?Q?KvnGCuZgEiuANUFefwEJ4dJdBgjDwgYmZbBE7Oj+3vZ/gxHeh7OC1sEqM5mH?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5tJ30cbKGY6wvBhqwaTqcdeGq0NWM405nhVvzDZ+4bkw2OfR4AJmOYuS6iBzVQEWM0/Bmr4r8InNMi0oArYo9MiOkWlbl6hpY9/n8xX1xpBBcjDUIrgaCDzF+abfrunQSeHSufiFJ0ci1O6u6W33oPfK/yFlvkNoRC6BbEZ231+xzkusf7fk+8pPK0Nh8pK81L+Jrp/CJkPmFziot+JsS48LzfMtHEZpQvhWQ0gRSOi5xuXRvuH3Z4N3UDYMtRDzsSxYiPfZVTMnEdtPQa9QCqoomBRwrNVICoWLdHzcSdJLr26z/Og+7vwmxbIrfgC2Mu2zlfwQtOd0Pw8fAv/YAh0a6mUMe+7MrwP4XcaePtP846PagUqTpT0yMTrijcto2KV1ofls//9BoaN1At3H0536IQK5fqP/8T5ErfaNr3AAqiBvLwKoYa5qka3mzJx36YCGegqR8th6XsVbwWJDMJRm818Zt6NQYSz8eSBt4LvBuM3yNHXJebVIbOgnwH1exeFT8PD+839Oqc8ioRFyaKE13NLkWA2CXM9NiHhp+Ot3pUonNqCzuMMs6T9SdGfaRHaMjVSlLryN1XJH+4yEELyR+MVDHo7+fvlJMHWfjqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d777016-5962-483d-8ad4-08ddf5097c6d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:12:04.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+otXIY+MmWWBRlLuiSXtrgmR2Jc3I9/Kok/bjvK0gL8Qg9IU+F+t/WyRu8WT95Oa6JDtw0394wEodHFCukce+Q24nP1SuOfvSVRtIgIYLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160098
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c937f8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=gwjC3emH5T4WlV2ZA8IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX7+D9Z139YbZN
 WaLaRES/8dPet6oEUFX87wI67H3DzZQjwARKtFviy9VlAO/8ngg0EYhS943q0NJwHqKtJD617mr
 /454CnpiXhoAgswlsFxj4vQEOrOgfh7l1yPllDnGV+jJQt09PF9WGWAPZtQnWrqSOz/XHZJGXdu
 U8Ex4cbVwuba3D6PkZlOtRCnN7gmo9yzJMI54/zjASwF28tznMkVyrziQop59mIJTqNd2gl64IN
 XR6M9dE2G31xrodSWSXmNK3G+wwRNOigoJRU5xkJ9evnWr2Xg2TQGn23w3W8LmRmCnHtsBNFvst
 kRnqQC2Xa9cLslgRu6yciQCzrlS7t2KtdHC2EcaTad/FnadvyXcCLfg0zMtLaLkOMCcvH/ZaaKK
 ReLQ1aV+
X-Proofpoint-ORIG-GUID: AXunoa6iLJiZQFxP7qpM_JPibuVZwL7J
X-Proofpoint-GUID: AXunoa6iLJiZQFxP7qpM_JPibuVZwL7J

On Mon, Sep 15, 2025 at 03:34:01PM -0700, Andrew Morton wrote:
> Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> feeling a need to slow things down for additional stabilization and so
> people hopefully get additional bandwidth to digest the material we've
> added this far.  So I think I'll just cherrypick [1/7] for now.  A
> great flood of positive review activity would probably make me revisit
> that ;)
>

Kalesh - I do intend to look at this series when I have a chance. My review
workload has been insane so it's hard to keep up at the moment.

Andrew - This cycle has been crazy, speaking from point of view of somebody
doing a lot of review, it's been very very exhausting from this side too,
and this kind of work can feel a little... thankless... sometimes :)

I feel like we maybe need a way to ask people to slow down, sometimes at
least.

Perhaps being less accepting of patches during merge window is one aspect,
as the merge window leading up to this cycle was almost the same review
load as when the cycle started.

Anyway, TL;DR: I think we need to be mindful of reviewer sanity as a factor
in all this too :)

(I am spekaing at Kernel Recipes then going on a very-badly-needed 2.5 week
vacataion afterwards over the merge window so I hope to stave off burnout
that way. Be good if I could keep mails upon return to 3 digits, but I have
my doubts :P)

Cheers, Lorenzo

