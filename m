Return-Path: <linux-fsdevel+bounces-28851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D996F708
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247F0B223FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36001D0494;
	Fri,  6 Sep 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnguzOGr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GoQ0ryLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDB1CEAC9;
	Fri,  6 Sep 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633425; cv=fail; b=G0+y2LRm9vM3/az2cPJEeBPnT7g5mJIiF2zHr90M2/7w30QjRt+fNDzW6ntZm3Zj6RxESW/Lnjt4Xyldren5G1U8tICPfxpkTqZbfA8+PSccuuyXphMqKw/JXVCyfFpamvhJayv/87gnPjDbKLMWxYxZbSpwhBIbCmOlLCSAFOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633425; c=relaxed/simple;
	bh=p+MC9DfEh83cSNsU/OkIiYyaqD5+WDbz/0lOilwCYPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDJH1i8DCkmRRZXcw2HFO4/gi9b0qDVMYhDkq53lI/T26zvw0XuCRyeMtdWXcc0RcUuInhaK9zU3/FCSB42OauBn3Tn91hw5AH6joR1p1N9UeEcKSRu+y5qGCuj+at/yc8JyMW4ZwW6reHmtyj4nrUi7JIdwidyjxEkNUN+9ORY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnguzOGr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GoQ0ryLQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486Cs5nm012991;
	Fri, 6 Sep 2024 14:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/gi6Z1MNJwP8AHt
	BYN/JM5R9jgHYDXmC4wqe03TyEhQ=; b=fnguzOGrw1NwwfOg+ZuWzPJuqyLcm2z
	rOt3keKW/jPzYl988uaq1OUbr/BIOPnM0lg2mg1ng662W/gIzSzBXUPkaeJV0/wH
	KcHZoLDKeQVcdzFLw+UxvD2zxgHRQin0JlQ/QkmuigRYa3kmxd4pqgUv4ydEfNEI
	4jPZdOB29nBwoLNc7qO1F2IIVy+ZKBBQ9cFYifMk5LmI1ecM7rLeVLQ/TDfahRga
	fn8Lp5cSctERsjbKyrcdJIUOo5m6nH+iA88jHU4B+oH4Z3hu3gh49VolZMJ2WBwz
	Ll7xCkwXk5ViXp9bVlIEZQcwGzk04RLvOA/ybhs1djtOhskDlyWvYXQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwhhsqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 14:36:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486EXpa7036884;
	Fri, 6 Sep 2024 14:36:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyg0yke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 14:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3hH38PPaYIrSbqJktqgEcTcSgkrG5oG76GtXaXMJKA9hlYbYxW9mCoIVqyN+GCqSdQqWWgl9vjDm4+zRs9Tvf6e751DPwB2ac6gvNPp7ZniUrdpNMhNvtPY8kZcfiRYsTaz7PbotPcVcKsi7nmkDsgLWtn3bEkDvL5JQqhoMOUfEkA9hb9qtAmYHI7JDwIpVUw2QdQPkJHdY4BUY+OYoHvER54wRhQp669uuLHesc0F4o0HB/pagU8GvsenCt5DAeF5q62cu0XX1hBJezKHhXJyF36VNnf9ywqPM+Pe3xTEg5ftOs0roohsEqcHLLo71TfKeUajRPqzfAVbxPtNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gi6Z1MNJwP8AHtBYN/JM5R9jgHYDXmC4wqe03TyEhQ=;
 b=trUP0Pz+2PU2Q07w4Pe8mNTY2F9NiffQ++8Kde9rocGHygD6xgVYqcFw2NVf3WngoPSan8fhGOO4i3o/974fbS+yQSVVByew9Drz04pi+Gc6vaHUMnF2oHtvKshMzle/Vqz6Bd9M9491fdljBcY5UHFo05xTiheCDv9rxLdk4EQi3YvMhf38XmuvIOmqZZ2LLQCTYQp2FWIxpVffh2/kSVFSzUKlHrjX6OyYTqx+oBKqnggTWzyhFxTiHnXrWhblwQCHwDucGIu61/5yjjcJs5gQRimS5OaURZBAaEyF+CccdLo5GCUtyuYTkIqy+2dJBlacwhSoMbswIHiwrcWzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gi6Z1MNJwP8AHtBYN/JM5R9jgHYDXmC4wqe03TyEhQ=;
 b=GoQ0ryLQt2rctMP7nU7pvSwyDi7UNKEal7wqrMGCmnCywSTW0sWQTHSxSy6WhMDr6mdP/wk2X46d/mVXJ+JFODVqDfJQECsIyXtPHG2HMCk1Ko1cIxKOKpa1tK7Ao9QFTmNvwpLbJ1j3thdmgilnJUGL5qJJtVS1LWVplqs4B2I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 14:36:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Fri, 6 Sep 2024
 14:36:47 +0000
Date: Fri, 6 Sep 2024 10:36:43 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
Message-ID: <ZtsTe1Cv7B3uLpVm@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
 <f20e49db181de1152ffb1b102450963937b4ec4f.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20e49db181de1152ffb1b102450963937b4ec4f.camel@kernel.org>
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ec9340-e8b6-4434-bba7-08dcce815642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBpxCdmI74aqzQ4lWT+Ru2TY7mLKCEKugYwTMHwgyyvV22yuijwkHLedvcme?=
 =?us-ascii?Q?p63n/e81CeFgflWRwMAMVkADtke96hvdnk6+jszfw+wNc2VRaVAKhNCve1Go?=
 =?us-ascii?Q?xphzuCKzsFOSshusrnVLisd67otihpb9kos1/2hb/pShZZGaGdCRei332Wm2?=
 =?us-ascii?Q?H1vJlDTb1aKTa/p9jJDJWHGSOsX7wEUayBSJ+KV4A2TWq+Qeh70RUUW5fkiq?=
 =?us-ascii?Q?iC2sm95I4vqzCPPRBA//lFG9QfLsHDfbLkrfGK3utwcANLyoobTgfnN/Jwcc?=
 =?us-ascii?Q?S0V0PPEtQs1oG7w8khQfgSTIKWH3itLCCtm6AdEO3Q6CAuZrkpGeftuvYxIf?=
 =?us-ascii?Q?/r0c8esvHSb7w4+0kJ3Z2U06ejywLeAGGHBSFvb7rceRif9khlChFQ53kZe6?=
 =?us-ascii?Q?iIhYNFtsh6jNmfZMLZEpZejkb5uS7z/F/TczisnTzywPA9IuXXnnPNsXLp3N?=
 =?us-ascii?Q?uTI8kgIPGnzDOTZLP+XUii9HtUX5VJ+aqG+mJebhdn/AVxR4nM48bJGTeR1g?=
 =?us-ascii?Q?vbx7/miGHPlFnAc11YtAWabuWW5ywZ+uRxgX8QxiDd6oUwfGqMuP+N0HrETN?=
 =?us-ascii?Q?kXdaJoZJ+cnNfSsCa+Eeh0WjJv6XB26k494sfxC7LiJ2AretDzytQuKqI7Zu?=
 =?us-ascii?Q?SFN4l7vIn7G7hCqohq/3mdgW3vg7KVsAJfS5FGYh4Y4OlwvfXaAa6FbFmGUP?=
 =?us-ascii?Q?55NNY5ATt7quWnpp0kOTuLvbrIp4Gfqgjd8P/h46RDN5SIUkMX8RSiYcVzeH?=
 =?us-ascii?Q?vPZwHL3Fc2duVCnUjREZjmS/4GWKNoiJ6xD+M5LCQ8cO21A52k47yltiP5tq?=
 =?us-ascii?Q?6qkpFRTM6T7QtyDNUT/o0vT5i0an1bviKLzTr6zsbatb/0K5NJRRbSRnWc/j?=
 =?us-ascii?Q?ZuR2eteHQ2e+Ght7IS3H/HDmTEDKi2sf9a63UPhWyoAAo9CPY2fGbdCsYoE3?=
 =?us-ascii?Q?n+fg7Ykt/4SaHN8gCbuarM/Gt52dKwafHdRZzZ4W0F7MZl5A8ZRH5EwA+JbS?=
 =?us-ascii?Q?2DL0Iqx8VOqiSO80EaYHpItmY3bgjt9UYWuJVpOfk21Kn0pVL15PxlRkysm/?=
 =?us-ascii?Q?ck95yKmXuh8AuQwAOLBaVUFjAgmqNOE+aN8q9jFutkcbaYQbD0yfbghvZtQ3?=
 =?us-ascii?Q?FtIgvqyNlCLL4/K2j5KFdCJI+EamP0bUWb62nqXik+tzYOA3soMXW9AXg4Jz?=
 =?us-ascii?Q?7FMhulmvN+KTxD931E5yJQUg5tOLE5X/eiZS5puJp1dYoh6cy2GLXJUXRRE0?=
 =?us-ascii?Q?o2EvGb9eFlt/WFo8fPx3YTpdkUpRUNG1su2OmmNEd2pW9cxcKtZ+2AKOJhj6?=
 =?us-ascii?Q?MveJGT0Wu/QxDfDknuGrLA12p9r0SWnIWarPkawRH64/8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQfDadSw2n4ARljRwjGCtC+GTNc5jq2j9L4nGa09qqNuiFiBY80sZ91YI+iK?=
 =?us-ascii?Q?pb1FsNoOqxbZSWC/36jm/1oLVxfWB0INhL8Q3MKZ12pRvfoKWILueo+yPTpI?=
 =?us-ascii?Q?DmpnMsaBtXo5aoD7ZkL6ARFK9slLd54rMzfB/cnge6n9Zp118ebZpM9aeYou?=
 =?us-ascii?Q?srEMNYY5hSF0r8Q+QZndTghl8KfQdXcH1tBeKtJOOzYcxdqOYwu4bcjdV1ge?=
 =?us-ascii?Q?+BSg3ametNfg0c/rBADcRr5lZHAsR+nfwcWAS0eyK/ltTJRryQqTDDetibrO?=
 =?us-ascii?Q?CJ33K3RW3rea0lf62wQbKPqH77gs6msUbEqt/nASvxkCeeFBZswaWcYC18vK?=
 =?us-ascii?Q?HHxKa1AsS20x7uzJcJizbtKmuy3ZXDKsmGcD7HNVfcgMfKn4rGNVqkjQj1Kk?=
 =?us-ascii?Q?q+0POyua/jYBEsj4vnpkT3ikpDr3KiHCKrCf50YRkebP9oxtqeSoBIkBoDlL?=
 =?us-ascii?Q?phnVBAKVpaMCtHaxqYb6vaVBjmYR4GKWv/fXmE8AhczhMhDomx7FV2b73+za?=
 =?us-ascii?Q?zQftK00hyPhiU+XNyMJsewkHfctvflMZ6Ez9TE02HwGC5dqGAqse74IiMM69?=
 =?us-ascii?Q?rdgLPv+DTVRZmEMuDNtL4++MfFVhw3IHsvi97uKy0r6C0aAFboB5QzTkHFeb?=
 =?us-ascii?Q?XbwfCgWbr4F2zpCNaHiya0jQzL7vnPCchUirm3JsINImrxs/66dC/62nkhoG?=
 =?us-ascii?Q?RTfToxJQDoAaEWXB6kmCKBYjYv6N15KcQBDllugs0BQyCqapv3/StRxjxZlL?=
 =?us-ascii?Q?41Sns3RpZUHbxe/KAqd2Z5uZn0aEO4Y2+BnDTkofZGhzYN8TzewDIMvo432l?=
 =?us-ascii?Q?W72HeLQrCDQ5l9a7AX+Po2OS+RWHlY5Gj1vaCHFfm/1AMWqQNTI4Sr9pO7xi?=
 =?us-ascii?Q?uxM85X4RIva2ESgPSql8ablnc4FHhGcmfq+6eJvg9J9QJgTZnkkrRCsT/p0L?=
 =?us-ascii?Q?kuj515QfJ+9Is6MKeWZtqzkPv1b1UwtrP41uiyBHNfzbuEBhcH2TsCoi48KI?=
 =?us-ascii?Q?vbcu7ODcb5/1nlEbK8y27zunVU0wvw3ZwUA3p4BeE4sQhUqiyWOsNxTzKQej?=
 =?us-ascii?Q?zcpe45h2hAlSmqnDuo2cMWeeYEWb9t5vOL1sCZttZ0i053jBKoomloHL8yza?=
 =?us-ascii?Q?HvCyfunFimThNdfRILXPiQeFxoLS/+uXJLak39iZOU9OAp/yoMV3F5XR+Zd3?=
 =?us-ascii?Q?C3ldBvQGzbYUkXHqYpufC2wfn7/d88doTXUoaQuBbrk3FM+SRhqi+awPD/Mj?=
 =?us-ascii?Q?YMFWqO5jiOIZLYFCA2PzstMvU8V+xOzKb82t2f2uqfgkHsjD9D8UM8xv0ZvL?=
 =?us-ascii?Q?AJJhwFGG7bVxPeKAUSagF3OSSrerYCfLXy2K69UHuBbj1Sagnjkh66Fg2Hwr?=
 =?us-ascii?Q?B6Dpro8Oe/ABsZPtS8tOuxz4Nkx+P3EwXqE8/Fh0NTdROWEne6c8iltVIXcT?=
 =?us-ascii?Q?RoCWPBsW/X4j6nYhlhvFmgRfbetSGeYyAI5O9Z7cGXunHC4vAzQCRTdROl7r?=
 =?us-ascii?Q?IC4eyEsLsuqTcVvA6LmqzGVNCeBQq1IjcgESn5sIYNpPflP8YMMX1x+xrdfm?=
 =?us-ascii?Q?GbIJLLyMLYWxnVgRxgvgdSfIOPAyPAs+qCRdj79e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ci5OFamx0ED3N16zUZQsLJ8SaIeoNQyhemh48J43AIuKOUZkcWG5YweRLyS+Dh3qL7Yf3TvY5l/ilYSIARKYYcB9JvihaoO2ciEiHSMIc17b6ouROTPgeLXpqNfy5K5t2bpGyqsIU2Jucjc827bFSfxlzP0LzaM4N20cH4Z13akThEfO1eBUPaOE/CgqycZM4IAHBfo+w0kafZwcGBohx6B63VurWsahh7YN7IVSKsNXlxvrXbkOMr8cgM77dYZ/cp/iGRbiKSyPlpIVJO5ONRykIGc7mJc6yuO3mHC4xzOdmHGZiAHlBoW+AruyXrMcNv+qWcJ67lY6A6klQHvGtDt0R0UpZ8fWCk9jmmqFAUX4fEA+y8DX/kds7IQzv6ckoUSwZ1ShQYqvhK1tAisiXnfxek4sMImmXmErZx//+k9aTQrL7uaY5I6/573SpxBub4N1V199pPSrVZLRck6ZYhLtK7SltX5OTLIbNpl3QTcTPRZ+XgxY1Q84c/JXiTsX9E5d5hqoz5ASwSub302Tf2wO+N1jOoKs6Q4m2cQg2TDZ1bg6bmhxOnhVx9Oq/nx8g/0lyxom/Wi4UFLNrAfJ3dmaqNbWMb0JceNEq5+Ici8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ec9340-e8b6-4434-bba7-08dcce815642
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:36:47.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kLclcNCpHl7YfHwEkmrKvLukQylrXkJkx9LFCLMgZh/XXOprh1QwTdMVFDsa17zICxJjjg8Aa7CHdRhGf8SpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060107
X-Proofpoint-ORIG-GUID: 9r25i5PXN80_q_CSB7ly6Zzgzc11ZWgE
X-Proofpoint-GUID: 9r25i5PXN80_q_CSB7ly6Zzgzc11ZWgE

On Fri, Sep 06, 2024 at 10:08:29AM -0400, Jeff Layton wrote:
> On Thu, 2024-09-05 at 08:41 -0400, Jeff Layton wrote:
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index df69dc6af467..db90677fc016 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
> >  	}
> >  }
> >  
> > +static bool
> > +nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
> > +		     struct kstat *stat)
> > +{
> > +	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
> > +	struct path path;
> > +
> > +	if (!nf)
> > +		return false;
> > +
> > +	path.mnt = currentfh->fh_export->ex_path.mnt;
> > +	path.dentry = file_dentry(nf->nf_file);
> > +
> > +	if (vfs_getattr(&path, stat,
> > +			(STATX_INO | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> 
> Minor oversight here.
> 
> I added STATX_INO when I was debugging, but we don't need it here. We
> should probably drop that flag (though it's mostly harmless). Chuck,
> would you be ok with fixing that up?

Fixed and squashed into nfsd-next.

-- 
Chuck Lever

