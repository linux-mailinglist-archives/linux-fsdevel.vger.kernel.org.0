Return-Path: <linux-fsdevel+bounces-67734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35618C486DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A03ABF82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9812E62CE;
	Mon, 10 Nov 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j65IQrlj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yJcvlQFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1862E5427;
	Mon, 10 Nov 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797020; cv=fail; b=a2zpOIVxRJiidaNi8v4NU7PyrlAQQgm5Pc4p/GPstxq//gef2KFPpJVWyvkBRD8/A+JsVuyopF9GwNFe0sCvNb25UD8mxz9PLHvEb0HJaiae59Kx4KxQ0GptfXNp2rI7hsyOJFucWtRb+mfdBFPI63qAZJQ6rwYNQH4/z/nUQak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797020; c=relaxed/simple;
	bh=NUN+gJrJ8B2oxUZ1fzKfQt7ncCxswFgqBSaqC4zR/Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXGHROrqM8yuPhOxfENaOru1MMfwYtd39eOwSojjYhw//AmS9vaaRpUSUZmhzX+9YHH+JJfm9HTQOV2Y/ussuUKULr3pwZYQpKzuASGtR4xXKXa9XV6VaRI/+GpTfbNfnyja+5uoXWyRiS4DRCHDtj2zO0NLWgtWR8shR7jSHxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j65IQrlj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yJcvlQFL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGuuce006744;
	Mon, 10 Nov 2025 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6DsImer/HlYHtXHQct
	JQQ8XXDz71Hcy1mqbJMVV4owk=; b=j65IQrljEagruhRfPlaS4im7QWBxGRDPzj
	F7WbjlmjY+7OfeYX0bpyxEurjWK+nzzHejm3DrL/Xm0HoOW93lk1smxW75RSo86b
	l1r8DVv9g7IBb653fHIm115yPeegAP/76vA8u25X4i8AV6kRpsk1QEfyCzIBvPLl
	uR9p2HptAvmSOz4t1g4iOLVOYwIh7U/xSZ8cj1uXxpxMtW3X7vb7NuM64yOQODly
	FcwBU+9LOcUQz65+s+v5f65byLJ0pJuD+16xiArRK4OdziNLn1kE5xD9/IprO45v
	HBISYsmARseWIknYF7YR9jtUSTQZLox3pOfHUDEK0fQHh7y/0fVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abkb6g8q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:49:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHbpfG012831;
	Mon, 10 Nov 2025 17:49:44 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaby8f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSiWi/2OJzsiOW9dXZz1pIEQRT0vkxfXY9pm4hmKq6g4GLtjlHwvy7mUXtMje3+Y3pySSFrxhLPAFImGMlK56iEvFEMnX2SHCOppXJvWg8i0HLi++TQpzCQjB+jMt1qYO61jgZyAFZwGKXLmXYNg6RIl4K9n3t/dhYZjPdL2gbR8Zn9ie28DrDqa52brjn+SLsrM+yduD3dT1KrcPt8P/DWLZfS18sxOwl7Ex99PKHevMK/hGzNDfQKfbvlskzTa0dsNssvGktljHxf/imGdZHVy9NC+akCRI4WgCAJ0e//NUvUu5Cdv/iyszILh0KiyULpxoOqEwsyCX9XsGvreig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DsImer/HlYHtXHQctJQQ8XXDz71Hcy1mqbJMVV4owk=;
 b=txRZAUtAF0SQLsyU8yXgYIyqx6w2i14p5HZnQJ/cro3a4XFlMtkInq3qJs0Mi8qXhhAaF5OCHx+f/p20lOp3cxiLx1THQK7DJU+hUfOddmWO6I4dqwqw/GZ7s9egiR8GiTBJ6IKiTKcfZTGrzFToJ63u5Cg4wJmDxNWFoUFh0NYy6lrtnC5+44qLXbXQDfscBqwyUf2FhF9n671ZBbRZWlgpw80E1ocmmw1tyox1Go904HJBCsW2O5ELaIcvLBvliokYMJHGVnaTWV8NYexi4ppETyOPqDdEkX8xFoJ3Mu6TQ6wi/zWtnumSclLLeBeZi7SE+PIX7XdeMWvVt9SbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DsImer/HlYHtXHQctJQQ8XXDz71Hcy1mqbJMVV4owk=;
 b=yJcvlQFLJJ1oLW06FCTwzNmbPlTWmy/4CwlczsBaDLLqiyhdpYYN5lYdpT2Nkh6v+HuwrgpCXWYS7mvS2jaK0WROMftcto5iQqZakS6LBRhUpzgJxLDxz+WHFIj8f3Db9lj/M7bwdm8Hp/lpIMx698aM2GvdCetRPFTprg4mneo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:49:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:49:39 +0000
Date: Mon, 10 Nov 2025 17:49:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 2/8] mm: add atomic VMA flags and set VM_MAYBE_GUARD
 as such
Message-ID: <7d34ecb7-2051-48cf-8741-44c7cf2b4143@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
 <00f05e58-b10b-4a66-bd6e-41dfa60ec364@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f05e58-b10b-4a66-bd6e-41dfa60ec364@lucifer.local>
X-ClientProxiedBy: LO4P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ea7eaa-7dc1-46d7-e400-08de20818520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UcQWC+EkfB67LmtP5Cz2+iOe0oNLhpXlkmId0alIHaehm/gMGQfaihaUxz2N?=
 =?us-ascii?Q?D3Sl99RNxITJ0e2zHGoWTbnuLKWbGtWFB+LRDHqJXfKy9s1L3Z8ALIW4fR4m?=
 =?us-ascii?Q?EsNApzIeXIN1cf1PO6EB108Jw0XcF9Ra+vYuMqgwh5dzaelxnCvQPtFPuoby?=
 =?us-ascii?Q?ppwKI7UronrlO1lWQd5S0B1ZZDzeG9MCbFLsT+/L93fnQvtDI7lW4OwwvZrt?=
 =?us-ascii?Q?YNjrmsq9sEzy8pbIcgJfVQJ/5F2j4dbsPOhYrJaIREJpKqyxWDtRy+R3VH1v?=
 =?us-ascii?Q?5Ph5px+rVbCHCVlNYkGxInt1xNPE4Xg7CSGuCBYtwlj+CfBLjG/so57amfzn?=
 =?us-ascii?Q?pdlc2TQL/Rjm9jZZEB+Ed1Z5q83BM4hrylff73hpcuAbVoKLTqp5h3iie+8h?=
 =?us-ascii?Q?RiM8rWjzAQCRa5Nn4V7eJRkMP3LobZxlTSk4ggarP6ksIqzqzXy7KJU2F9L2?=
 =?us-ascii?Q?3GAJMJQIiHciAekftNyZzyD9uYW3m1xEYlHymfWmgMW0M1q8LIIYjeFGmuSa?=
 =?us-ascii?Q?dmi5meZ8RsEx9fh2DH29NFy9KQ8X2jPE53kVWfDkT/yodVWJrQCS2m29K6/P?=
 =?us-ascii?Q?4bszHHLBl+sFyFUns3XEruGkVYYIo/05SjTnjxkSZt5OoB7w+MLL2Oj+KhJx?=
 =?us-ascii?Q?aGaNstvH9lT+t9MWnObPYXWC7lcm7/BbAN1Qbh6vSKewYdScGJLFYp+5Ndb8?=
 =?us-ascii?Q?hMteiZ2M2sMpw/Jfb5P0j7WfZuc3XFxENfqRZXuobVqcKruLSBSyAX3c5g7i?=
 =?us-ascii?Q?m3QMDjFvyi3hg+dPsyS7EioztG00ipK+IkXklpehwiYkFpbKeYySegXqUOgb?=
 =?us-ascii?Q?LSMBILUu6TEXuSnFJT4P+T1EasiDgFLjr3Rb8cwDEvnQDn7alrpZ6W90PaQX?=
 =?us-ascii?Q?uczxyf6C4t3r36V2BZyfxtLrEzBFhJrNUB2dM0TmQXfeTOoAN36RUcYZN/op?=
 =?us-ascii?Q?RJkBFTqILIc6UiNCdhILNp46wn3ypVGiVQYC5xth27lWfA6lk4mwZVV6SfRh?=
 =?us-ascii?Q?EEUrSKp/ZCw35aZSjKJoD0g3HmIU377yZvLDTjP+MDtFHX/fQESIK3azE4t6?=
 =?us-ascii?Q?+SvDKQLs7tsRVjLp4d9eKfAcU/t2tcxkuyCAEur3ify79DBsexaueH7cZoVC?=
 =?us-ascii?Q?fwXlawU/t6CXGE6RrbNosuwjHnyRgc/uo+K2fCjX3clDMIkvzE8jqxU4hZgb?=
 =?us-ascii?Q?oA0McLp+hPMEvJehhp9kfCX+yEZ8+YT6Jjo5tvkGRKGqlxSbuLQta4dkUewR?=
 =?us-ascii?Q?u1K11dR3MsjyDwVrps0ZMYPSWITNJcoz5M+MOCGU6b8ep48Ye7E9jNR5J+37?=
 =?us-ascii?Q?IeKHy90130GP8laTTSg7IihYtb5dwGXy2hI8S/SJU4nAsYTz7ja6DcHS0GQW?=
 =?us-ascii?Q?Hd6Eh3IPJB9gvPGZ9tnd+bkFinnPo4pH1xc9rAVXerEj2Y1dECoJWkXlly8/?=
 =?us-ascii?Q?KJv19lErGZDzWvyS9XrYVnvIdoQecYV6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8duipEv7v3uyp/CsVkLt0yw/UluwTvKTjXjFordiYCeQ/EYwWpoDve3OUtGN?=
 =?us-ascii?Q?qdaLBM/z/EbgPoM5RlWjRicGECS7yLhiCCz7JeEbpxPovEs0tYCD3WSOQIVq?=
 =?us-ascii?Q?triXSNITWyl8W+zsUQxGkhmO7NzcrF4HV/WN0CAyp14ZkGLc5E4jvJ0uFpqW?=
 =?us-ascii?Q?/sSMKuJEGRzNI+xnuZl3rnEfKM9qAUSl0e42gvRs6ikxM2S0nZmTq6X8igfT?=
 =?us-ascii?Q?L9x8tcznJoY3vspqC2Q8SPtbqdCCm766GfR0we6ZsmLBgFuBzxqYS+q/Dh/w?=
 =?us-ascii?Q?w5HBXhlfKAKAHYEWWsoopbdlZpjxURGPv6asKJEu11XfLDMrVrqg5vlUQbY8?=
 =?us-ascii?Q?EfPr6+rQM42yWsTcrAMDxQ9dAev+pC/2fW3x7B1ttjKMNtviwhHkWWHGrycJ?=
 =?us-ascii?Q?LG6r7kT5e0BInwyeKCpaYKEDzgur3/B3H6FMbEmkZaMbFefHk+B3/phOzFwS?=
 =?us-ascii?Q?CPxVlbezUNBk+BChHuZZ9g//SsCJFhv2q7qT2+d9uzAWzr5aJVQfjLONg8ht?=
 =?us-ascii?Q?n6iqGA0ytSM5c4Cp3Gtcl6r7feK8sPqBDTTJ2M4N+dxF8MVVyOAW6Qgn0bl4?=
 =?us-ascii?Q?IQ8TQC8QN2s+O5nBazdcb3E07Bmbtr4Uxs/BS4zkMUEkq+9jHwzYSgr1Tae/?=
 =?us-ascii?Q?4jfDWWZHgmwV2A6GZ/EG+MB1330Ym+kykQWEmRXiMsgwKaT5ex2MFflljW9d?=
 =?us-ascii?Q?pWPxZRvR1qK5l4q08a3vezOE/Pea6ie4Me2YeZIYUdGYkQhxYqiNaX/wqHIq?=
 =?us-ascii?Q?euflCKlk+2+jTkktKA+nJ8OaMPGmYlFwCCIKtv/+I/57PX1YMvucFOoHCda/?=
 =?us-ascii?Q?gME28EQwcYpApByilScForm+Wjgy9HkRgo98m0P+cV/Ve5zH1q7ERxGMpGBX?=
 =?us-ascii?Q?rQ0SPeyNjZtzo3McxfaxzMjmBVDlUGV0y+2Vi1W4A4xUW2TCour+/n9csHbG?=
 =?us-ascii?Q?Fcms0wEGNtIIG98k4GkWBEaQFqQyfUAPNkeaHUjaJ8qlDNC6oJS/XU7ZYQOI?=
 =?us-ascii?Q?V5nQscgkLKqrzAhUx5+HaqCkKnhocywaU0QCjkExLkHmfGQT/xonUWPkBVzu?=
 =?us-ascii?Q?tXprbPBcIK5lsgjuVLHauV1EA4QKdB++XeWtu1WW5PcLhCypvZVRm337c8IN?=
 =?us-ascii?Q?SqG4JYuCx75VK4uzol3fGw1fuFVcNfF3u1Gm3wFAvL1KYmziY8bkyl9bcEHj?=
 =?us-ascii?Q?m7alEDZpyKQZoU43X5c/yGnoFcWVR1+pjjCHWhB2cLz9LuHV5Pbh1LroVNnZ?=
 =?us-ascii?Q?XSa54WFq45OxQPHtLi5xUoPzrMt00G6BaBm6lDx6s2vDB0ssqibrZgL4t6RI?=
 =?us-ascii?Q?WivX75yavoj9BuQ6SNisDalQdu+Zo71uW9hzbpPzrHwXpXvLMtapCCv1lMHv?=
 =?us-ascii?Q?8gX3J0lYb/jji9vXke9RQUcGHjUSdjODk3Gmr2S/xEkWJi4wH/xnJGiTGzt2?=
 =?us-ascii?Q?KoMLaQOijXj+GLIg95xSqz/G3ysMUoGogQqyHAGqDSd4W1omQHEvrpT8lXO4?=
 =?us-ascii?Q?AzpbaQRonpnenRkkd1MXNoj728Hsla6KAHw5nsO4W+JmPPQSRS4D61aIngyb?=
 =?us-ascii?Q?tA3eBUAH6JMRPYaGJXKhSTft4cC8l046fagD1HN8cEFQ0gG1tgzGN2gzCIil?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qEIDxzE/0nVF+GdkUTAm075+PxO7TpX7ftmTkSxZSd6mWcDEZGEOrjGuu5cJPdT3siDsBGeU2j/EihYTFFVS1kb/qDvB1NOxxx/DYVSOfJ422jV+aN0uvHjX50dWpBRd4GQKj0LLaBC5IMxod+HWFmeuW/egDW/cBRJKlAhy9IZAypoDg0yfXnZaxKgZAWGmu1R+V6icqD6oam4zU5GZL4nINqdnC1asfx9e5gqWo60i1Qp+xHC2mJtVkVBShRF3xm7ZAseOF6WoeJ5DyBKaV1PO+Jq0tXHSt0+UxSM/T1NFlOUu9Lnl6e5IOqe9v0sHjrv2KhI/Tuo1dDkdjPb2sI2lf1ihPgUawDlmsjd2n4bWP/1IYBM31hXuFXLRhf+Zv9sD0AM+QjHCWhDThPf+gmRuB3sIMebzRYLnZYukV1ZYCUhyk5ZnAmw+UfrcZUoiLBpQgt5HZCiOtXKpw+fjXvnBbg4EMwb3/3EYVnOkLPGE3L91Idu8nfvQI3IiKX7wylndzyALpcDeDGU16lmC1XGCChxn6f1MVDlJSqlfIWbXOeKfMelHDHeAyGQ4FrovxE6YKC5Lq5/ckdQMWEwkx810y3+HX5b0bkd+y79oNtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ea7eaa-7dc1-46d7-e400-08de20818520
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:49:39.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFbh6Mgb1/IaHfiIDS7mkuWoiPtHk4zittg2kANaxhBHIR5ZszfJS+PmDicGS/jNfn+C7+t+0dMqaXhzH7hKJZL1F54MipCQi9y9UxQrb5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100151
X-Proofpoint-GUID: rjBX9RwHA-DBshT0PmB8zZfBqH44QC4W
X-Authority-Analysis: v=2.4 cv=ZLXaWH7b c=1 sm=1 tr=0 ts=691225be b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=uXbQtwrmqkC_BVthq6gA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: rjBX9RwHA-DBshT0PmB8zZfBqH44QC4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNiBTYWx0ZWRfX8CAdtCQJ8AiT
 K4o6DhAeqOhx0SbztDWdT9mOEGO6bTHBTL839wsTXyE0eLr73akMQTShXS+pUAfGigYtFbVcRUD
 u/MYRooINCnLL0N+xtzEhU4x+AdlzZWLNIAg7jg1OHzr7PN+rf6T5URVfQtuU5rkqXLI+62SWsz
 IaFkhpJBKh8UZR1y9hAthHnHwlQAqyD3bVOhfgoj4TL0l8sIYsSQsE5ncZuTWSN8trDMh6NHBti
 O7tWvK7kaauNx1p7hxMSdMPrfH6l6GPIZx9+N4cAXlvqYLooET977u8VMjw3yose2vCAKJLP1IB
 RXMu4xTkGlBW9iaziDxogeT/z3BvtppCzo/t5ruRrBSNes31nL1CB4Z8ku9CFy4NbuLAf7ldOhc
 usenjPbh97OKBAfT1oEysiNdAYyzevQhEctTumr+lI/S2vlkum0=

Andrew - actually please ignore this, let me send another that'll fold this in
and make sparse happy too.

Cheers, Lorenzo

On Mon, Nov 10, 2025 at 05:36:29PM +0000, Lorenzo Stoakes wrote:
> Hi Andrew,
>
> Please apply this trivial fix-patch.
>
> Thanks, Lorenzo
>
> ----8<----
>
> From e73da6d99f6e32c959c7a852a90f03c9c76816c6 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 10 Nov 2025 17:35:11 +0000
> Subject: [PATCH] fixup
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 699566c21ff7..e94005f2b985 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -900,6 +900,8 @@ static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
>  {
>  	if (__vma_flag_atomic_valid(vma, bit))
>  		return test_bit(bit, &vma->__vm_flags);
> +
> +	return false;
>  }
>
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> --
> 2.51.0

