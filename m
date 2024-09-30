Return-Path: <linux-fsdevel+bounces-30338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBC989F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95279281444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851218BC36;
	Mon, 30 Sep 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhLtDEI9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MlunKAG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1417C9AC;
	Mon, 30 Sep 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692813; cv=fail; b=rjzlLlJJmgJ0+678OZLLct8P/qlOLoRfsYlEHY6j4Kg80QYrtxptGjiqie6cPGau2J/gBdhMIxVzLs9wX96OkRz4kBB8e0PGp/hbhv7RbiLC7Hmso828oTMzfY6mVa60UwUIHOxVjKIBJil7OKaVO2zEEYnYw9gzPWoonZd2SXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692813; c=relaxed/simple;
	bh=GSNIMcwGrMaH9wwaDQdKmoCabj91FLfSZWczIbC3lnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZ4LyKfMjKL7wq8dUgANFGfLJ9OmBrOOZSwMGxwOuqc3DHoWbrES9QE02TvW8+e4A8gek7B+Wh3SxtXZRq/hxpf5rEfu0pzg3mePYZYWufa4ItsBDr3TRCW6CLK0TzPaWc9Cp2h0Jul/SSy7lWxEKMMqc1g64w7ejmR9c/z0ar0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EhLtDEI9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MlunKAG0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2txwc015690;
	Mon, 30 Sep 2024 10:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4XRYZhx3WG9zUNe
	WSC4AttJNadLrvFib072rBVqabZc=; b=EhLtDEI96BitawxSIezTH2yvaYiWAfo
	Kpkh1ogTTBsY4Qi0KTXPyN3rvJRtytn9Izli46UZyp9g8Utu+t1b4nt0h1K+lcXP
	gMBmxhUwJUZyOK9K8iTJkVqfBQTn5Wz1gATpzvO0QmF/0NbW5a2n/9k0qXQiLapB
	shfRghjFk/WZk/NMTEtY8jDsyeC9G5arHxkIeEPK5L3BY25fj9hExyKhSSm8AqBM
	OuIZuZ8ULbITPL+dhVWd+4z7b9yt/tknJ8idFWA+ca6JFq5JGb8GxdzGAG9yeru7
	2iD07ikNPBnOgEn7LTHH4PxCd3aVNpIcY/mIHafYques/UJ5YrXuouw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1ayju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 10:39:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UA1fSb039273;
	Mon, 30 Sep 2024 10:39:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885vfkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 10:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+36bQALUpO5vKlSLa1rDLZSQ9z6KW6O9ca/nMvgUdLQlohbylPYc7Q95Zun+1+p09bV2+RY7IsSm46szOM+UUOddo53wiyqyFDn2P9/l6aQCFUMkhs3kL1tONKJAw6A2NuGIcha8kek1P6/KipgITt3IxE0lG9fqbWIWsh0fhpjLJZcRHcMOfwRO9gaife0QSA9UUWMGM6Ajppy/xp/s26gMxA3Hvhw54SGyUgUMGedi6dlducBm1P8FIonKdPJgSGzqUBz+RYdpARkKj6Mu2kPn26Hn3izwhxDah1F7cimk/p36EprQZK9SJ3+zhAkzUFdpXy/vz8II9193DAwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XRYZhx3WG9zUNeWSC4AttJNadLrvFib072rBVqabZc=;
 b=kcfaquZiaYTeei3VaQI4jHu2Pt7oBnKYxbqbAB+rIPGtnKQbDO/UHuySpjFBSoz7Y7USTSk1BsQx1G1B5TZ6aqZMSqsJqOHVdRSwXLSvrsI+PZEnzyCqcR7jNUd85kytpFtf1ebS5Hy8CD6Y32ZiCY57vNo/4dZTZbCf2wLcNSOeQFWg1/RCuLPhhkTWjMfbeXAbgeH3h00wV4DuaVrfStJg9vtZursea2Zfq5pAnAko1nhdQ3gJAGDGNr6CUehMH+2PTxYyYfrqVCS5cXJGrNZzUk5agjxHT/hekpnh/fddRuFW4rxPBCuqdm2QPfmcHU6skAYdyveLL9SYwmqC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XRYZhx3WG9zUNeWSC4AttJNadLrvFib072rBVqabZc=;
 b=MlunKAG0gtSte064HX5JqYEHRnnXjq67t24JoXUGxxy7mNWhTVui/FJagOxRC0WvavVv5Ltob67WqgDszIxXy3K3AowA8PeaPS1zdLGuYMMPPfGZ4mcRHJ2HbeX0f7pvWvVihyU4F00ngMlUqRItd8gYbD+ENRyLNpJPege4Y6k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4608.namprd10.prod.outlook.com (2603:10b6:a03:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 10:39:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 10:39:53 +0000
Date: Mon, 30 Sep 2024 11:39:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: 75418256-9f5d-48fe-e796-08dce13c3826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WRv/zukiTEwxh7S+yK4xI1ufzFiKmuUG1m/DTNcczdk/kDYXFauBJAh74l2I?=
 =?us-ascii?Q?ZIlfKzlkY6XA8NqWjskwLX6iwJDnarXfKTUhTIO4dIWrMTZWNeUBauHN+oLb?=
 =?us-ascii?Q?RQqUv3rgP5e7i73pH1HnZPo37k9Bkq4F/fRTg1hJpeQ9Jt8aaaAzM/qQ6ykH?=
 =?us-ascii?Q?2jOyMvIgllDkRrKSJzknvvj4lLweDS3gSMYnStzsKsi+/C6CW7HWhMMglH6C?=
 =?us-ascii?Q?TxBlUncZAJwZOZrkGgpTOM5KtXozwuylPfyM0qTCKYDful06UAX4qRRj1lIy?=
 =?us-ascii?Q?M/C13wqmfRg0nh+HzlQpbXpF6tzHtun5cZ7MNIpI21Tw4TOXSOiK++4N06WZ?=
 =?us-ascii?Q?/mH2JHlEDUywz6vt2F8bb0TshjMN7zVNziqC5DRdtGRDX5tSh8Aqxn3u5GE4?=
 =?us-ascii?Q?+lujZ+xDUKQEwtWoiZ9h4kNloXdaqNzeeXb4DcfQKdamcTDh1eIx0apKdW/s?=
 =?us-ascii?Q?lsc3E5nT6WJx00yMokXNWXSxKIagDB/YlkTH8SNr3Kk+av6jlgifG4NmMfj4?=
 =?us-ascii?Q?MZEOnRPDRONAqvVKkPFzhq9FuHMA+HJdzojDTNGlD+/axY2VCJYljqrFUNfs?=
 =?us-ascii?Q?kGJKjC/BOVbQDwup5ncZvF2SW0jjjuTKUqjBungxUrXG2WgEDJrasvwtnwMG?=
 =?us-ascii?Q?OQJyU32O88B9uXlJ74z0LrlTd7WpAVmGmVsb3Hm9hgNbsd0PhXUIyHyWn0SG?=
 =?us-ascii?Q?nmFomJ5SDCDjSxbyltD3/MYsPhi5pcNjVlilntjYs0+I5f2y0leFYhb+1EBX?=
 =?us-ascii?Q?gDFBDX999n2W+eeHUVZYPXkPBX3xoxGISBQdr8GbzFxf8bviWJE37Wjv9ClH?=
 =?us-ascii?Q?YmFwNz2XU3Gh7Ghuh39IJwHHvOvkXkxTUQ0k15zxA2BpJZ9cgmVPu4P2xgrs?=
 =?us-ascii?Q?FpLWPodl3jNs6gD02heuulw8+y1ieTNNvr3NMEBs+IVgAK0NiMWTPTXUPZDi?=
 =?us-ascii?Q?i1QcjlkHiQwUEFbeefUfuzMim++UTOE/x4dT1CWamIM/akB7l/lY7VcBNigz?=
 =?us-ascii?Q?3/TprYPNRdYWElTO51zc8VRDSuW8n5m1afs9OR11F7UF+kGhDWjUqy+mipwO?=
 =?us-ascii?Q?ng/HIoHelLO3zb+0yde6O1HNOR0U8ouGpoNiGBlvFEnhoZGCdt3rL5o98rpy?=
 =?us-ascii?Q?jWFMt1yuH1HgN0UbANQfyXXFNyA1tERWgYbut3dDbKk+AtlribhAGyXZVgun?=
 =?us-ascii?Q?Sd73gW2RJ5l6oyqbSTVOQ42hRaFhrk15iB97sqd/a4OjCnX3dtfkMDhLS+OX?=
 =?us-ascii?Q?HIfJuWLfxiasB3wTrlEAMEQ+GhcjsMao1SoCe0fBsZ4UZYkHJUcmU4QLoIa3?=
 =?us-ascii?Q?v7Po2RY/g3cBW2PG8LsKQqh3YtKXSlFDYXQzBHozLYONbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwHPH8SsPhJZ6a9Z9aFewm/4OSxGjuhUUchSTPSiqRb1WOtd7nlbitEyj6zn?=
 =?us-ascii?Q?SImz7++MUwbNiNbPlqkT0wkJQAkPuOifOY7N+Ml/BZ944VlLziaAoUl5ZKFJ?=
 =?us-ascii?Q?FWFNSbmj3kH0m3Kygnz1dbQ5bysDTIb1S1GaF5qXRpERwm395RZ/p2NANQhi?=
 =?us-ascii?Q?h0a5TjQ0QwD7ZG46iv3RZAzTYfn/aCOjhxZNd8LyN4vtEfdVztLJfe8tEBRb?=
 =?us-ascii?Q?g95959JEcQgsaHzw4ss49nvw5Ckf+60Vh6+jViCe3840zOvK0erlLVlR9n6+?=
 =?us-ascii?Q?EbYKv3uQIMQqJqzqKwTLiZIYMIgUCbMYkUaIF4BVvoKML79ddXcVOCqL2WOc?=
 =?us-ascii?Q?sur/o2cy0m3XGJoB4aVfWh6Pfr9kxWMNNt69RRkPaw8G5pdADk5e31mmy0Wf?=
 =?us-ascii?Q?6Kb0J8T4PFy2LIIOGoUnSJsLRewPsuguKDXe5hdgKmwrn5uVkymTYkiEY1xJ?=
 =?us-ascii?Q?Q1YcZ4Tk7r1N2CwZteu2lOIs1aLB4n7XHrWYEAbVy9Ig7lYk10+WYCfK0gL/?=
 =?us-ascii?Q?f5X1oKNIWGo9gQ4nU+5K8SHGHbp/Cm4W8R4SD274jTG9yhdlc8FDzeeUJ2+L?=
 =?us-ascii?Q?9azcNeYxwE18thdnTymL7nQwSZQbL4DrRi48QiJbJrawDL7V8JgrWk8KMeC5?=
 =?us-ascii?Q?nZj8YJ4wHVj/RB3n6r3YUkQeFLg8lSnw/Mc8aNxOO6DeXcczo9Fjw1tQx0Co?=
 =?us-ascii?Q?WTNp2tZIUvcGmNPvd7TcPjm41bARbY++pnqgZD4KZPoJskw/6ynfh5gd/TOP?=
 =?us-ascii?Q?cv1J6Luk2XIgIKnmjm3nP7wpsdkBRNG+rIAn5ViAO8R7LXoq6ghVlNqU46Ql?=
 =?us-ascii?Q?C6Fvw0huNk8Eb9us7JGvFLtvUYlHJv/ZgWt+T2AI+4QjxfdSnn2fg9wc63iR?=
 =?us-ascii?Q?1wcO1sOlwom7jq98RpvMlnlWA6Qiao5YT5RpM9MzWUTJhFrdeB62ebS+38uV?=
 =?us-ascii?Q?uKNqvVw2u8HJONEsaKM2oduRUmXhpDeznJpBgyPMSzibbykYEE3NJINzp6/n?=
 =?us-ascii?Q?uGSUM3OodNsCP1uNLf9huExpJHWLSU1QxLWggrnohE63xLW6Fy5jF4cYy9hr?=
 =?us-ascii?Q?6jgJVTADTbIotbt56DNPXydy0dNMwbmlbY7des839ay2fGaOB3iG62jX5N0B?=
 =?us-ascii?Q?fbI85Y8qNqudn84do47ipIoPk5bihlc479SW+QwSphrn5r41fZsEav9xzYSL?=
 =?us-ascii?Q?PfgLndDTqAc5FQMinh/fnXVMK/rne89TpLXQilMrLQ7FKKcDO2m+qfTc+OS5?=
 =?us-ascii?Q?kzZpdjja5b5XAr+ouieUZ7Goeh4RrrwiJcDqgInipKG3CHfnmRFnHQafNa8H?=
 =?us-ascii?Q?5atXZ34kpRJ6j0XAOr7EFYuWElI75vbCG+iyskc6N6XJFwkmsMbvITn6aZeV?=
 =?us-ascii?Q?PLNqagy4QRkCGklu7HBWNp2M8YEbA+yPQ+fJRVCnAESgPMFJHhSOIoZ3TytF?=
 =?us-ascii?Q?dW+QKArmeRpVRvKWpBCW+7oDKBXGPXm54ycIQphguWlmwN2w/yJkjUgnayrM?=
 =?us-ascii?Q?4XHf0n95ZugD6EEHnlj9/izkntjF11omgVVUfKen+EQUBCpLmPG1CkExGFrt?=
 =?us-ascii?Q?EG1NlShCp1+5rxX2hHwwHBGgnmznqHIXmiqVbza68qsmFN5fGQ2S9R+TxdL0?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b6m7kWTFQDxXdt3HwfUsXtfuigZLRSq6BdKKATxnM/srps6C8Ty3Uip7RAZwyAVc4PLisTSpAu8itKbP1OLowgv195zNZnP11sP5tRb2sBhvqX6aycjASwTI5mJ8fNMXXv/BjOpPlbqKhreOp3isHJFqJUKU7nM2lHX9Et2lfSrwan7u/p8djixjIdqmBW/1F2uzJriwHXjmpCXXSawhXGve+l1vW1o1ZHpuHifBm3y7eBv06M7NK9dnYSvQJ4IV2K46bk/GvTlVJF10sQcY/XbGeA49qrJ27eSbRB1UGYuBmFQi8gpPFKoJtKPOk1g1XB1DK1XFr0mNgDdYrnQOu+QMilqU/5cUAh9EEUPyVdasn1S7db7QVeplEvyCm1TvyF19heuE3UUGsOpgEkhTwJocioMNHYXreSX73YCPpJwX1C9Q5YKPDx9QPSQSVl8ON+ICSUTXQtCa0ZtBwlsgopF2851djTS5tv8OTodj8FdxnaXsU8SnvAHF+xC5cHJLQhpte/GiSzlhWAUqJtNbIjehR/aBhTwHuIcUFsywgIDsrwCT3B0M9u2xKk140FrnMGkV5RhSs1otk+4Ufx24Zt+w1gAcg/IDCUi8mmMs3YI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75418256-9f5d-48fe-e796-08dce13c3826
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:39:53.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zfCe98ow8MRxt5qUz0Bar49Ug3OmKGimcVDKTI5EQ0j33qm+IqaeFx2CU1Y5ZCdtqUb3tRDnEH7ZB6pd+c2hMDW7qWqnb+MPglBOgt9CuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_09,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=947
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300077
X-Proofpoint-ORIG-GUID: Kxjz_3lM5x1QaAdCb6fL-uGk3PP4o8P6
X-Proofpoint-GUID: Kxjz_3lM5x1QaAdCb6fL-uGk3PP4o8P6

On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> * Lorenzo Stoakes:
>
> > If you wish to utilise a pidfd interface to refer to the current process
> > (from the point of view of userland - from the kernel point of view - the
> > thread group leader), it is rather cumbersome, requiring something like:
> >
> > 	int pidfd = pidfd_open(getpid(), 0);
> >
> > 	...
> >
> > 	close(pidfd);
> >
> > Or the equivalent call opening /proc/self. It is more convenient to use a
> > sentinel value to indicate to an interface that accepts a pidfd that we
> > simply wish to refer to the current process.
>
> The descriptor will refer to the current thread, not process, right?

No it refers to the current process (i.e. thread group leader from kernel
perspective). Unless you specify PIDFD_THREAD, this is the same if you did the above.

>
> The distinction matters for pidfd_getfd if a process contains multiple
> threads with different file descriptor tables, and probably for
> pidfd_send_signal as well.

You mean if you did a strange set of flags to clone()? Otherwise these are
shared right?

Again, we are explicitly looking at process not thread from userland
perspective. A PIDFD_SELF_THREAD might be possible, but this series doesn't try
to implement that.

>
> Thanks,
> Florian
>

