Return-Path: <linux-fsdevel+bounces-45784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583CA7C1FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC87B3BAD33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59121B9C1;
	Fri,  4 Apr 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AKkCoiL1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FoToWV2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39478211A23;
	Fri,  4 Apr 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786009; cv=fail; b=iSN5hMU6iW0o5W7eneg39jbccIO80U7GzxLF19u5X1lV0YQkMoAzL2XPqvbBKuuPrj7gdBW6OlFFsytW8tSyKMkC8IcoHv9oJWsRo0FhvBfEGpDWHIL1REk+fBVUBCCi6o8DREGpQKxUpQXXrVAPUdcrFuFmojmG9fORu8uDrbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786009; c=relaxed/simple;
	bh=teHMk3RPtztTPJo2IYMSWXByKxzcfynmY6NTjD7u+nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iq1PREnglpM3Q1a6lq6PcgJGjIJxBvunAxiFi8GnYwzrYEaTaaH6QZ86DiB6XgWLhBhbRhKK4gpy+qNX6Y+UScqWfICAXzJACVyN/Rjeiyy3pZIbpuYIRryguqWyrs2EHAPv6F6OFX8wDFYF4ycnrVRutWZHxPk34IeqDBgHA04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AKkCoiL1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FoToWV2H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Du3lg021123;
	Fri, 4 Apr 2025 16:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LnnLwwDPzxAIXO94IA
	6SsURV0kDcFXmTwzIWf2LLFPY=; b=AKkCoiL17iIgf6XBKwwKusUnp4sa/EF9Hf
	3ile9SC9q7r7AZ/dbpPIAH588GEYruc+FTK3a3SvQBNXQvp+mTKHFbul3nyGxHjG
	aKm8NeSJICl+A0PPDwtzUYPJ3C4U24/f4B0do1HjWuofOlN4MmP8b+C9Rohm2MzM
	2FgCZ8hH5RplUhdSLqwNCrq0BE9QfHVQS5ZniGDvHulpABjd2m4gJCwumAwL18X1
	cnZ6Ii9m9aRoizg1nrJB3BovSpdLwlrz8CexLjPTjQe2n4r0i2FNFeAMxEgDq0uX
	fSoQ3bn/zwv5sh1XJrTY7R5PQxC7U8X7D5NScYySHelaRxNgWApw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0qchu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 16:59:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534FqdbM036176;
	Fri, 4 Apr 2025 16:59:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2nuac3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 16:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9jEPvaz7FA9/vjzbfdLa5NPjRR1nOSwLjkAVOSJC9DkED4ns5chY0OgnGnB+DHbD98h7VlTpsP/bZWIP5ba3PIWE7CcasP6rfY7Vny9zxeEwajllbL39zwi/+drS4REl+orLPEj9bcWf+eAr58W4grlWZwCx0ZU105OxQ8bz3U78jcs2Y6Lirf5H4tbgxK8sqZ2eiu7qkJA36O1YRFCoUOO+jDiG/KsocEPXtnMZ3QrTak4ESQKcLQNSdG8jIMhs2bjuwDEql8WXzqFLYIzvsgL1uEHvwIjFx4l52l8b2e0IyCZDfFnm8xLTx95ptYcub3KMH9kr6ij49XLhOqhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnnLwwDPzxAIXO94IA6SsURV0kDcFXmTwzIWf2LLFPY=;
 b=yxbtL+0iNCVAt48mMp6+LDsSFTrhFFZsrli3huxiqNT+MU9EdzCVrv+X835rZnNUp20HrXrMw3uJ1XMYg/mRBW5XMMNNIXChBPZg3PJUqMPImHwb6YDeCIPCujAyygRza2TDrLPOpVF4aKe0IMmzcCX+lepnAiKc6tGUq9wFpAXVvZc8roN6BSyjSrJAkEvRYMUrqggxPp+mukKEnR5hFH5psvLIxWuRSjPL0RWpyeQCFxZPlcsLOFUGz5eCA3Q7mFo8H9Ev9jtriKDx+ZQVc9Bi61M7qBprlHnQM7ymbdpc/g5RgSHoId8whMeRNytdNIneroXUJrTN3DnyvpWnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnnLwwDPzxAIXO94IA6SsURV0kDcFXmTwzIWf2LLFPY=;
 b=FoToWV2HyDdjquwBWZLaKZnLkf7+3rL12lDUZ4xBiH4RjPZo+UeiZWvg3NwfK3WNgGp5KwyYFqfDjKs+HGJn5v80tIQsXKBfCCTYC14zfhsN/P+HQu56G5qyMnvBBVorV7XeJpRZJ0SMNX+Vw900nsWPMkG8x5+1A8oCGpiW4Go=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 16:59:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 16:59:40 +0000
Date: Fri, 4 Apr 2025 17:59:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
        hughd@google.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, Liam.Howlett@oracle.com,
        jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
        jthoughton@google.com, peterx@redhat.com, graf@amazon.de,
        jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
        nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <6bba1a40-76e2-44fb-8f9c-e15f89ff1d0f@lucifer.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <dc4c72a2-41c1-4548-a6ee-5a17895e4940@lucifer.local>
 <7b8d9aa6-99ff-4986-bd16-664de63ecb58@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8d9aa6-99ff-4986-bd16-664de63ecb58@amazon.com>
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: b830c9a2-01a5-4f68-18a3-08dd739a16e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OiEHASj3zezNrAdJftpQjzf2UkkVb5vcbNupivSrQlCHzefgJiWpv//q+TXV?=
 =?us-ascii?Q?ssIUBn/EbCpMWZrwhSDAUlAxWvsPuf3V3dW7t9/NJ8cvqqtCScnuVsSe7xOl?=
 =?us-ascii?Q?mrqSag1GeULX/zSKgnLacqJkGmp57Esk5ug8k6Lvh50g2VmknZaebVGrSPli?=
 =?us-ascii?Q?ApQcEj2CaLl0lQGvuBrUaIJhNVi+naJgTkRpJHLW1GSqSL3mD4TNdje+TlzA?=
 =?us-ascii?Q?tI9JwEXWw2mKRUqmK1IBOwrK55O+vCvVXwNAqrOujquIfKw5emhrVfN1M9s7?=
 =?us-ascii?Q?wtcIJcuHTlTEJHuILyrrNGg5zMvgLIZu5pAEYGk/QP8ad3csf1jFnHc7Ps5O?=
 =?us-ascii?Q?irt2TW5CHF2yvJ15vt3WPugWd/GqYXkt2rrFXLSsouAT+3nXfo1mcTERr9xg?=
 =?us-ascii?Q?lrh0kn8BKoMFJz7WX1/+qswfKESS7+1506WTJRL4woG8J7NEp/rb0E4iwBQL?=
 =?us-ascii?Q?w/uTXIwDJ5PZVknu1NHo3NAC2XUVR0AV9bWoI0GMg4o6al/mqBySAsWAh/Vl?=
 =?us-ascii?Q?WJAeAvvUmD7wvNK8AIBmmFDdNyKtvAxGP6AR65l89wPcojB+UyTk+ISOk+UU?=
 =?us-ascii?Q?yLEiz3o/D4P/tmOxGwaxuj6pzeXoABUXs9krGI4/P+7IvacthEp4y50W14CQ?=
 =?us-ascii?Q?4KVQJGtvmTAHpPepIRduzQECslR5Do470cZdLmzLbtKtBhaEfLMnlbXLHF4S?=
 =?us-ascii?Q?8lztGZ9jxHykMP1hZSER2MRZfTTKtxSpx0YJuRt/1KbfoUehBvZRrOwsmCZm?=
 =?us-ascii?Q?Rfl/5i5Bmj6RRklTxL1yJ36VB5YXNXMdNgwdR21qFDvwpJXeZ6TT/buoDTZN?=
 =?us-ascii?Q?OKlz2+Zt/u2lCGl/Zuj/C6IMlBKZCILKh5edJjRYxHbvF1DmWAeRjfdSiQT5?=
 =?us-ascii?Q?jIyXMU8reLJgnqNWjzwIhJbLeKhSzkMFmN/wMXxPY/BFVrfzIBB0ceF2HMnO?=
 =?us-ascii?Q?f9dcp4V46VY8s6ozSFdwsBMJ2JWaEN24ueBCui9PvZFh2PmhKHcaT537BvuE?=
 =?us-ascii?Q?Jsb+YJNadiqXrbyq0Ttvu2V4sDGMieXsVoeUD2BmgEV5MNcYCQzinrJoXSg3?=
 =?us-ascii?Q?ueAYQHZlp2Z5jtVT9TFq0YHrQ/VjOfDGaXWWspXZI5JYe7mZnWNrvmSdZLGh?=
 =?us-ascii?Q?Y5lelnZsNiOhj0xNzGJ/+P/YY+uhDoZ1xtwwZD2xJ7nlF08rgyQVK6FXQ2r5?=
 =?us-ascii?Q?HAnn0+K7XqsS0idCAjCRp9Wa7jKPbJHMWLva84P5O/afl3+0/ED/5GiTvEb5?=
 =?us-ascii?Q?u5xLAWkNBp7xYAM/nwEW/x3XxU1VntINEBnd0DWwBQWCCrocgqg7NRpUZ/IT?=
 =?us-ascii?Q?X68SbrLYWcCtS/2EpNf2HoSQl8cOHWGWq9ctuvC1VFx0Jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9GZGd1t/dr6LUifuY1jui9YgQ6N0x8jVUkmi+pYFr3vf2oLXPcEvS2A0CN3?=
 =?us-ascii?Q?RLgznhvpgsldkp9sjSuIawKTTisbhfE3Nr3+ZpcTv3VAthJGX4d0l253WP7d?=
 =?us-ascii?Q?uNUIAsZQqogTBQ95oMm3G/14Dq2VsWVwTL9W4GTA/nt+IfcTUdEeJZPpuF04?=
 =?us-ascii?Q?XvW+Q+5BZlaTuv3fMA0LJYYPOidXq1mbzowYo1hpe+q6p2QVAGq8qwo8pvAm?=
 =?us-ascii?Q?+MgIEjzGkYhqcPAzGtI9asZ+HTKAImH8gP8HxEEWN4Vy7P/z9BLlUq4VJJ3M?=
 =?us-ascii?Q?1MHRoEUOrHCyNsHPGMfIH4C3hgmj6m83GcLVUi3XalhrXrWd8NZXBidKhg1k?=
 =?us-ascii?Q?sxDeQcSKuqMJ/lBNEPt7jrFMTJcS33aCC1xHnIEVfLlee0H+0/zv01NCi8eW?=
 =?us-ascii?Q?1236lJ2FRGlHfn1UWEkLbznm5sotfxXlZpUvbly+acC6lxpbHPIJgXHNnM9B?=
 =?us-ascii?Q?X8vA3eZiJDvUmmnAdu83NuUWWaq9TJS9pL2qb7pfFEaCnKDHorKeCRBRQfpE?=
 =?us-ascii?Q?W/vE/zono24wnl/OzWOEX4m7yBNW2RZ8IfxHbW5LOUxdqBEzEdpbass3Tfh7?=
 =?us-ascii?Q?w7xvQTaPMSKZGszG7uv0me6Hm33ADdoeu0aS6psCfAQDoVNFDYXOXSJbI5LG?=
 =?us-ascii?Q?FXwEfDOv5WmyxAmQ5PPg4rgDFYP+K/chJirP9AJGPp8PqKYzbsXJ0pIdaXwX?=
 =?us-ascii?Q?uhZ6WCcN/anP8Sq9YfzWkqumUian4dLSjje7nNYeidnX7KyX7D6dz4Zi0cv+?=
 =?us-ascii?Q?tKGkiYK1LXcn3updasJoVCtN8KispvNp744TtTSGCU1mIpB/wXT2v/bBPbmZ?=
 =?us-ascii?Q?cCz2d1QAfbDaxdUUlcNHBTt83zq2viocJuXD54lhM95YZzEjU4VbEctkpa74?=
 =?us-ascii?Q?7O6KvMHxEmSMIDC9hCw+ZeopfwuLduO4uaRk8NFVvHFFEYU7A8TMmWL2W8vx?=
 =?us-ascii?Q?+ICkTwf4FWpHi4DPR4MOC92MtufgiJ8/cMPk56ArZY9nP5cUJNfSU1UrOFoz?=
 =?us-ascii?Q?sa32uZd5pA8cKsIjEzhh4N0nXaARFCctdpYWY8NBd9Z+LqovJsbri21j/MmN?=
 =?us-ascii?Q?fPiUiltwkQZ/fkySPYd51SMurQp17KtgvVbWp8sLkDLV3B4cZImBx6RnDXeW?=
 =?us-ascii?Q?yAdfNXKbDVfFzF6p+n4O3Gklwym6LHG5+YojRzom+19Nh/XTSwVXf9dpekET?=
 =?us-ascii?Q?aLXB7UBcF/4udbmZPyT805vHuP+DfL0uIe7TwR7yeXo/GgGj5F7CCk/L4F2X?=
 =?us-ascii?Q?QvYxPJFn1KUeJVpgun0cqDrgG7osodbdfrwZ9EMYy/IG5Kngm1rs0+VrkpJG?=
 =?us-ascii?Q?M+x29VnVPbATGV/QYOGolM5DRuUvSnSYDy8aycL6MxDJWB1+bIyjAVC3Hqvv?=
 =?us-ascii?Q?vsP3+oKPRMlOXWyPU//42Qp6XPEcEN7BSK4w6lgBP0dXtNrrPWrjEqf9jss9?=
 =?us-ascii?Q?qeRWRKSOs1ZzBiJDn/oBzfhiPBAxbEjsb9j3IAaOtG+z0oJethlUtxzU1k5w?=
 =?us-ascii?Q?dn0FzC15ucP/4Lec4fOZXMhjoqwpwKyozbeEkGWbXXMLxwKe2JCNmKfOH5Xz?=
 =?us-ascii?Q?G1EpZKbHeTLuZ4a7FjbX0jetLqtum7k2Of42dBbw9+7/O6ZsctCalfU25fN0?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JycFjOjRiRWDE0uPX1iYOQcxVqkddZ7j96JvxKKrM3YWc6WfcFk6D72+bzozthtW63mcvejIMprW9hwwRNduth3sZSDPgMcwNX9XaKm7krB8K051epah5XtaPJQYC89F0KgAnoXD2v6Jye2bMrfdBXVYfoYVPaByknMLnQmvUAr3I6qh22JJAZ+Q8PSFy3HzbabW9NzYCTQjMO1+F5t3moPGd3x4DfAh5TtHxVTUc/AfYT0uAcHgeQzWasiKZFJxzuBlKkTt05yiiyYgUb1iUM8JFPRMoIvqNojDkpUp89rddkzordsocEQsajef3rxmrXIF04D8dMZi4wiD3zDKbFKgDHL66aUEz1mZXFZuQ6j7YjcKLurUsBQGQNwBoEQ5RL9Ex61ktO/N3zopa71n0GlMhDPAFAuqzaK+t/HItcFqXmJcLVa8KFP1nKhrt/zJRBmzUBiSdEhL0KcVQoQ+P+I8dDZ5QGsMvqwr/oatUjs3r1wPCPc6JyBcifq5PF6J9OkwFRWxb+L3H/mL8afNS9/Y+e6PCwUNFViCfu/LLk/y96ml+c4IKHmPkHu4u1zsTvVK0SAtsAxPYzJEBzepFbeVMtBgprl2DjSXi8TWIMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b830c9a2-01a5-4f68-18a3-08dd739a16e1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 16:59:40.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZwHjzgPxBd2rLsY9V8khDWtX28M5rhOSN9umg2aNoJbSJx6x1DY9BMaGKeeb1801FAw156VRjnVkz7Shg7edGtbH4lhQVv+FtAC6rr5s1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040117
X-Proofpoint-ORIG-GUID: vWTlQ7td0_rKa7nM2eSeilp4tlaiZK2t
X-Proofpoint-GUID: vWTlQ7td0_rKa7nM2eSeilp4tlaiZK2t

On Fri, Apr 04, 2025 at 05:56:58PM +0100, Nikita Kalyazin wrote:
>
>
> On 04/04/2025 17:33, Lorenzo Stoakes wrote:
> > On Fri, Apr 04, 2025 at 03:43:46PM +0000, Nikita Kalyazin wrote:
> > > This series is built on top of the Fuad's v7 "mapping guest_memfd backed
> > > memory at the host" [1].
> >
> > Hm if this is based on an unmerged series this seems quite speculative and
> > should maybe be an RFC? I mean that series at least still seems quite under
> > discussion/experiencing issues?
> >
> > Maybe worth RFC'ing until that one settles down first to avoid complexity
> > in review/application to tree?
>
> Hi,
>
> I dropped the RFC tag because I saw similar examples before, but I'm happy
> to bring it back next time if the dependency is not merged until then.

Yeah really sorry to be a pain haha, I realise this particular situation is
a bit unclear, but I think just for the sake of getting our ducks in a row
and ensuring things are settled on the baseline (and it's sort of a fairly
big baseline), it'd be best to bring it back!

>
> >
> > Thanks!
>
> Thanks!

Cheers!

>
> >
> > >
> > > With James's KVM userfault [2], it is possible to handle stage-2 faults
> > > in guest_memfd in userspace.  However, KVM itself also triggers faults
> > > in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> > > PV EOI and page table walking code when fetching the MMIO instruction on
> > > x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> > > that KVM would be accessing those pages via userspace page tables.  In
> > > order for such faults to be handled in userspace, guest_memfd needs to
> > > support userfaultfd.
> > >
> > > Changes since v2 [4]:
> > >   - James: Fix sgp type when calling shmem_get_folio_gfp
> > >   - James: Improved vm_ops->fault() error handling
> > >   - James: Add and make use of the can_userfault() VMA operation
> > >   - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
> > >   - James: Fix typos and add more checks in the test
> > >
> > > Nikita
> > >
> > > [1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
> > > [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
> > > [3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
> > > [4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/
> > >
> > > Nikita Kalyazin (6):
> > >    mm: userfaultfd: generic continue for non hugetlbfs
> > >    mm: provide can_userfault vma operation
> > >    mm: userfaultfd: use can_userfault vma operation
> > >    KVM: guest_memfd: add support for userfaultfd minor
> > >    mm: userfaultfd: add UFFD_FEATURE_MINOR_GUEST_MEMFD
> > >    KVM: selftests: test userfaultfd minor for guest_memfd
> > >
> > >   fs/userfaultfd.c                              |  3 +-
> > >   include/linux/mm.h                            |  5 +
> > >   include/linux/mm_types.h                      |  4 +
> > >   include/linux/userfaultfd_k.h                 | 10 +-
> > >   include/uapi/linux/userfaultfd.h              |  8 +-
> > >   mm/hugetlb.c                                  |  9 +-
> > >   mm/shmem.c                                    | 17 +++-
> > >   mm/userfaultfd.c                              | 47 ++++++---
> > >   .../testing/selftests/kvm/guest_memfd_test.c  | 99 +++++++++++++++++++
> > >   virt/kvm/guest_memfd.c                        | 10 ++
> > >   10 files changed, 188 insertions(+), 24 deletions(-)
> > >
> > >
> > > base-commit: 3cc51efc17a2c41a480eed36b31c1773936717e0
> > > --
> > > 2.47.1
> > >
>

