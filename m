Return-Path: <linux-fsdevel+bounces-43521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45505A57CA9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7118D16E2C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D961B6CEF;
	Sat,  8 Mar 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYckMyXs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wgdnfOkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0801494A3
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457786; cv=fail; b=OW+96WdN5gX5E6YgXDtmcorakxYAsE8LS3g0HqMDbzDyW+kDwUBbXQyzh0K/Nsm267xRKqaeEzl3cSqE38n3/x67nfumdWkiNSqSjtm4QCF1ydFfpeL68f083hCzFHZEEdSxElJJMWPyDUr+GQmLQGVAv5P4tF5BmIVnX/dAviQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457786; c=relaxed/simple;
	bh=RFNtMR5pNpqCDCcEQY6Qt5xE2yWVpXEjS/Q23lcLwCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4yTPrw95+TlJNC3WS/sPXzHA7dqNvidhYktowlQk2fFIZ0PhQUs5HyMa3chsgAEASfoNV5uHkS9/3qhj3HyuY/jJbM0T853TyFmH6J8kMcsLyHJSYdHt3h7y99DedjbV2Kv7Arx1GPiqeuc3VvHvLEjbKhlrL84Rc8JnBdoiH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYckMyXs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wgdnfOkE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528FVVZt009595;
	Sat, 8 Mar 2025 18:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CvcJZ6DYdnwZYZXrSS
	XSTcQt1Ki1RAvt0TsNQwot/OA=; b=bYckMyXsbOnf9QwZ0kuEIpZVZsqTwS3fFK
	jkD9pzavA7lLbRJZ0lFGXIZyv0DnPut3JNfA8OGTWa4B09tDPBZjQSFVIY0aj5Gf
	30C2bE1A41zlfPXFoglgmCrAcS9nDB2tkQJCqGEPNIrJKNGv55Iykavm9hf1wmlR
	Srzfkz8QrT4AcGTzzpTTykQ1aZfXoyzIQ2WcKgETh1dSNPXU99EWeCRiG6joHp+S
	dEKh3TLmNlbP/SmY2sN5Jza2ui6nJ39u1yoCVQFR4fLQDqGR5vQaQy/o5OUKurOA
	IfN7lPpfuX4kyVi67/VeEZTZarTYHVxnJMeASZi7OE18qsGTaeIA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxcge90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Mar 2025 18:16:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 528GcRqW026288;
	Sat, 8 Mar 2025 18:16:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb66red-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Mar 2025 18:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvsZr8qN1rZfjUb3pbegvo6PopWu0j5pVmADQuBdHpyWDPZ+cZPPAJ0Rk+w8baN9Zwnkj/hlYsno7GUvGMFCLQvLgruw2LvLiHjyHeFJVt4Fn96fHHeJX9RP1ZQ0xYgH9Epu3zyb5C+5vLEQhvslZ6yOts1n6vWgcRH8Y3vpuSQA9k/AOnJipl9KZvUOk+D93dJroOdXhxP7KEiYc3EkLo7YAmn7nbcuRzsBWS8Sx7MsmDF+imWDDML8z9EK65BVMFE+ZyGODpUsazHifJeghB/5lZykPjnW3vXk20EBpBz4HadendI6U+rGUcCzNAWbEpWMv2gZ1ubBH3ulo3WJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvcJZ6DYdnwZYZXrSSXSTcQt1Ki1RAvt0TsNQwot/OA=;
 b=iS6J9KCe9QB9dmsua029peZR5vAt96PwRsoNSQTN5iPPkCaWlwQ6bU6pNuLtsqCwTyEV4+4t+2gn1t7ksUsWo8dpDnNJ+IkRXfFJKFrtXvZ2+/EMRTav/19DuNwBomstfpyIEdM4PFquMe6xmEkVQwvQ8X7gD5wimjbr+g5+I8sEHQmssnymBsFSm+LIurCJk2Nd8ID2zTD+KxlGd3fSwgLbJjwLY9EcFQY7L6BfDcwgKFxo8PdPkVztuhShZm6hhb1kw3qWsrkuV9Nut/8AOyyUtROObsEyRuuMwtsiF3+5u8rJ12Q9N9oCl+CycMP6EFZha3HDyNjXiXRi6axeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvcJZ6DYdnwZYZXrSSXSTcQt1Ki1RAvt0TsNQwot/OA=;
 b=wgdnfOkECzHrbdsUJDvfDqPWKt+MLayfSmRthPqX4XR4cu62SEt6RlPFZ5YLNWw0NmGgNoysN7JSzXPf2Vl5f1Mq2x4Hv3jcXZQuVgonBUOLlScnZLGsbpTC/rXXHRQlVjJcPMIlWgO79GgzjSL2Vw8rlhrif21c3mdxiRbCTHI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ5PPF8DB18B996.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Sat, 8 Mar
 2025 18:16:04 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Sat, 8 Mar 2025
 18:16:03 +0000
Date: Sat, 8 Mar 2025 18:15:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <cb462622-1b56-4baf-a445-e0091478bdbe@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
 <9c2f802e-d1f9-466d-b5d2-b61e5461da30@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2f802e-d1f9-466d-b5d2-b61e5461da30@lucifer.local>
X-ClientProxiedBy: LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ5PPF8DB18B996:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a8d238-efa6-47ab-dc16-08dd5e6d491f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKTp3835DLuxtxRLv+Z8Zrjis4Us9CfPt30zH5Vdb8LDi5xNuxBfpvuqkfzU?=
 =?us-ascii?Q?CjHYIG2nQdfpROrmA3118GOCnAjO38TZHKnieBlDkiraJN8qAflbJlQi77tz?=
 =?us-ascii?Q?AsWrieshfrzwi6JIR1ViBaf6Qt2jrOPNCNKBz+om4aDI01GY8jPua0mGkWDo?=
 =?us-ascii?Q?QZbV/B4LHc9kDzb3kir0AbthIu9UIkTyMNmTbzH4RpgJrUs5YCyRr5kUMgDQ?=
 =?us-ascii?Q?z/LUXDB3aS4OXIorz69SyJogzafB6tnDCuCi14s1AVDrLhg3V3cNNkrcjs0p?=
 =?us-ascii?Q?Hn7DAiKuvU72GVoy+bhklcWe8imJfZGg4Jv+oLvYeczbvmpqFfKvnWxbOY3O?=
 =?us-ascii?Q?jm+GUTmEJ8Wbl/0KQywla2B+64+jO04e8ILrPSAKbUx07Ahe45eUc+aks+rQ?=
 =?us-ascii?Q?FeFBwuNSrKJY4Y1fgIs5c/7dfnPGjDpgLOEB2xu95rCiGGvUfQWQonOPlZ0u?=
 =?us-ascii?Q?uF4pY5iCetNx2GeCIzpDXkR2NdW6APRmjue0l+5UxcR0laPBayuHp1MsgN93?=
 =?us-ascii?Q?+uaRDG7kgW5gOlaCzlJ/zWcjYSIw+j13rOJs1/FoCUS4fV9X0Q1rMJH4tCis?=
 =?us-ascii?Q?gCpu+2n4Iihk4JsGqr9MmuQ+S53FV5X8npgjZpZpTkpNmYbnk95U2N0mZGJc?=
 =?us-ascii?Q?BEOUm18O5IrUHw1B+63yCwkSKuJ3rpN9+GsEn+u2KkGrEKZwNlkwwYmV18Na?=
 =?us-ascii?Q?wFedWiea1+rpcdXGjz+KFN78wfn8gm3GBD57HDGFPzQmqVem63CfwJMK5WIq?=
 =?us-ascii?Q?zEThggTRnjAbSwyiulOBKYdXMLzNJzEH5h5sG29+SyRzxn0fiV2B1tI909IJ?=
 =?us-ascii?Q?O9NyhV9y0D24Al/EQ2VvcJfwoXK82xXXba/heiZNHSTAVuSSJ5CYHpMzXgqc?=
 =?us-ascii?Q?o/dBr91IHM3QOOgtDHa7yImpmNIMXT3ZSYr9TZcFsUrs2wutiD7QU9bRRX76?=
 =?us-ascii?Q?B7ybBf4UZ8PZEuzuz+Hpq8cwlmq8BnH+MyKL3W8XVmy8vZWYJjE8qHoKeSne?=
 =?us-ascii?Q?G1m2ITEuhPWsXRqnpfW9ceo3Wehh7E7suU9etkcfLSwKMYaD1YqpDs0wDFeq?=
 =?us-ascii?Q?H1idjNZBbCMbXRQCwKqre690liMe42MvOdIaLu4QZruPJTXUmy47dkloN5LT?=
 =?us-ascii?Q?2sVwYKJGmoyAggGw98Ldb2nDr7Pe6chvNdLJvp1qgblVab3owmXFt4RuDQ2N?=
 =?us-ascii?Q?REJN8WGVZuH+voMYl87tpVi/ktg7QnNDCZLtxwepl95bmWo+GgWhKuo/pzlF?=
 =?us-ascii?Q?fzEq+OoG82+b5W9XnNSHY+37K7tcTivBIQz9kbI7O9/82nd4x1g5y7M3VOY2?=
 =?us-ascii?Q?8xNS7DnMMvACELnN0XMnp3Cp7PFbWXSwtaJWmhyaI9huE1wt+RbX4ssE1qvd?=
 =?us-ascii?Q?EzIyZ//uw1VjDdra81xOv5cnHSGV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TvN6GJULSqqzCi2j6BzGSClS6k7zlktj1cwXCFjddgXwy2B9UItkgQZXUtwF?=
 =?us-ascii?Q?8rjeBtoaxK6uGB5+wPxu35pRgSJPqGgPpWByFaKHAoSUV60kyWOu9doAKYAp?=
 =?us-ascii?Q?XhKrV+yHF8x9CI9VpAK6Gr7p5C6So64eytwFQYHGXjlKIT21mCsuftMT/qRP?=
 =?us-ascii?Q?L6svHn52QxlxlwcboVqXsgx2oPZ1fX5Bi4m8s0wZVQdF8RZzuUhLbC7TlqL0?=
 =?us-ascii?Q?sgXnkK3Z2Go0uekT1UzIj2yNEKzg6mzVuaxSl6OusWNmNDeocy6suE7hG2nR?=
 =?us-ascii?Q?KXuyZAyV5j3Nhvm7PydrLvwG3QfWLq26JpTZuOJ7yHnCISepsG6lxAZgFn5P?=
 =?us-ascii?Q?DcGENvLiihc+EvxHtoXT96fnS4ifRj7slyMy3xUckEkvAFI7hHYgrwbcQEbs?=
 =?us-ascii?Q?J1LG31217xnfxn4td3geVp/xBL4qFNSq7Q8Fbf+kKqcbRiZ9YIOOQaA6XVa8?=
 =?us-ascii?Q?/RoJaP9VmyS06Hb8cXbgGAdrwTL6u9VVyXuaS2sXFzqtg6P5sbiHN2s85FoI?=
 =?us-ascii?Q?bTJg38+mUCgHkgW1OM2ZPsPZ36gsLoVDj3AosWY3BrOTlFBLb7/GyEKHK7eH?=
 =?us-ascii?Q?yKm5dsLQP8YnA3QQmXHdngRpw1x0dhvJZ3NypeaZLYoOI6ZEB3LFXkCwKf78?=
 =?us-ascii?Q?0qtbxwmqBVv90EfU1rL3j0jGsxWidEhEQDjJeaQgN/w8EU5dyHDufpm9Ubw2?=
 =?us-ascii?Q?o9PEPnD4Jf3I/pXnjcf2MGtItHw53rJ87kc2MicuWNk/QbRg0TkhOFlefyVo?=
 =?us-ascii?Q?5PDBAPC7coGktu2cZyus3XKHFwjELV8rn2Q2b/b4FdV7Z8wLTuE2qHIOpnbJ?=
 =?us-ascii?Q?xCoxqJJy65TjIvSDqGcJ5duEokGv8uIFN5beM7ESZJf3EmSEeOiYuBIhKvs0?=
 =?us-ascii?Q?r1Zia2ie3qBUgO8MCFNmEtkGw8HSfURwCQdJKo/kv/X+SKHLdVWhJj1X772a?=
 =?us-ascii?Q?Mha4sNNHxEdKX1YknHdRyTGG9FUrFwf6rvd8xodXi1Evo0bqlMJZc8rok51N?=
 =?us-ascii?Q?FQwxipav20hLOOMFN+DYijy/gk5S88/NXirtTYpMIUiA9lzcJlwuU5yw/7ee?=
 =?us-ascii?Q?UhZ/IsRY15Ca924x8S0/8YHrbDXDgx7V2Y7mVOSc/Rcfo2Vu/ir4a/kODaDY?=
 =?us-ascii?Q?0oIEPQsjOy0V25kLp6wof7a/WP09XKiDcf/B7PX9B4T8BSRrmVfAVokjsu4o?=
 =?us-ascii?Q?Fpu4W0MHIzmOWnVNqKF2vQNWmUVNZaQKow/BcZuUgTZMjWR5jNKZwg7Op9jF?=
 =?us-ascii?Q?W5Zf3QX70Z1HbXdHdsQ0UKOfNwPun6sJQUULfP/VKJdz3/Bc0JpqHvIKqpjW?=
 =?us-ascii?Q?FIGXThHu72Z+M1Op9sB+WVPeI0n1mnaS6phzYMGssOYSMP4hegc7j5B01RVP?=
 =?us-ascii?Q?hZ/M3Z8gA+9qfjLke/jYKcc68+v0tCn/uYHbK4vqYoobHQxWid8dUxHNsXkC?=
 =?us-ascii?Q?Kw4f4WQF3pvcQeLkxYLFDUAlJ4pFebiHhvw+gRCKAIO5hWNwhxE61tJHfEhB?=
 =?us-ascii?Q?0ndNXPYAZWELu+09MkFSYrm1LKHhwi1aaEmR8vyRbrOC32PdTqzsVKed8FDE?=
 =?us-ascii?Q?fsaEIoXYJDGytIJwF5ZL/137qmCi5Cu+WseOuWp7CIuFgTLpAvwOjQO2arqv?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	506e8B74x4JZgpEO4D9rn+jh7G24qCI5p1z7ZuNaChE0SnzyczA1gQHvMK0H1OpCoRR9B09dt+Um04KKPkj/Xk3NnTAhk6oTpYGaWNsPmz+xBdTJ7o/sYK1av7viZfAXZhSFAMjNhsZk/n7+BB5qmEzWKrqaoulL8JcTqkNIkgJB9pONhEhpfzCKgGSMwrV+geLCIKbKqH//pyaWoYHUGuo6k4XJSTormgzJpncurgcObMYFnwE1bw+NduD+c5dZjgx+pXkKA3szhnhikOjn/IjH1NQ+/lqwcyt4YnTGMxEwssukAXGgl9AOYGr915awjaKK0iJdnLpXCaUyF2ZfWbhs116dGFXefFPyMUz1ugCOYNc/AzUdvnDDLVGhwTj6qAwAZAXua4nyIzSrQkwJlUDoFq4J1aSoj2PK/0jj3htUfQTb5lHJA2g4dQxP+45PamY6gz9uFpT+EHJJ2noQ4B3WKVOc6nqHwi3DnckpMa1xzOsRX2Ix03l77T2/EVgvCZR/xVeqWRreuc5fz4Zpxht6E71OMIYsXQ60A4csE5WZsecEs9Bj4Wsbizyn8EJJk0vLTUtB1xvuRsIjetqyuR1tI6AnuKFy3lV3fIqz2sQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a8d238-efa6-47ab-dc16-08dd5e6d491f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 18:16:03.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWL9pAvK6ccwL8AFRrX5EF88Z4ckOQKeB5bOHg1KZEJVPGYYt0OevfXWOPzV0HfA+5nloO/iMJJSawmDxiNCkCE0UNlPh0v6xtwhP9SLk3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8DB18B996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=898 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503080140
X-Proofpoint-ORIG-GUID: YbYqkzuCxpfwrD9tvU4VLOW3phsoCOO9
X-Proofpoint-GUID: YbYqkzuCxpfwrD9tvU4VLOW3phsoCOO9

On Sat, Feb 22, 2025 at 06:26:32PM +0000, Lorenzo Stoakes wrote:
> Having worked on slides and done further research in this area (I plan to
> really attack anon_vma over the coming year it's a real area of interest of
> mine), I have decided to modify the topic a little.
>
> Rather than focusing on the possible future ideal very-long-term project of
> finding a means of unifying anon + file-backed handling, I'd like to take a
> step back and discuss anon_vma in general and then examine:
>
> - short term improvements that I intend to attack shortly (hopefully some
>   of which I will have submitted patches for -prior to lsf- as some people
>   are apparently adament one should only speak about things one has
>   patched).
>
> - medium term improvements that require architectural changes to the
>   anon_vma mechanism.
>
> - and long term improvements which is, yes, unifying anon_vma and
>   file-backed mappings.
>
> I think this will be more practical and we'll get a better more actionable
> discussion out of this approach.

I'm going to further refine this to discussing anon_vma in the context of
VMA merging solely, and leave the bigger stuff to later :)

This is in relation to an RFC patch series I have been working on.

>
> On Wed, Jan 08, 2025 at 10:23:16PM +0000, Lorenzo Stoakes wrote:
> > Hi all,
> >
> > Since time immemorial the kernel has maintained two separate realms within
> > mm - that of file-backed mappings and that of anonymous mappings.
> >
> > Each of these require a reverse mapping from folio to VMA, utilising
> > interval trees from an intermediate object referenced by folio->mapping
> > back to the VMAs which map it.
> >
> > In the case of a file-backed mapping, this 'intermediate object' is the
> > shared page cache entry, of type struct address_space. It is non-CoW which
> > keep things simple(-ish) and the concept is straight-forward - both the
> > folio and the VMAs which map the page cache object reference it.
> >
> > In the case of anonymous memory, things are not quite as simple, as a
> > result of CoW. This is further complicated by forking and the very many
> > different combinations of CoW'd and non-CoW'd folios that can exist within
> > a mapping.
> >
> > This kind of mapping utilises struct anon_vma objects which as a result of
> > this complexity are pretty well entirely concerned with maintaining the
> > notion of an anon_vma object rather than describing the underlying memory
> > in any way.
> >
> > Of course we can enter further realms of insan^W^W^W^W^Wcomplexity by
> > maintaining a MAP_PRIVATE file-backed mapping where we can experience both
> > at once!
> >
> > The fact that we can have both CoW'd and non-CoW'd folios referencing a VMA
> > means that we require -yet another- type, a struct anon_vma_chain,
> > maintained on a linked list, to abstract the link between anon_vma objects
> > and VMAs, and to provide a means by which one can manage and traverse
> > anon_vma objects from the VMA as well as looking them up from the reverse
> > mapping.
> >
> > Maintaining all of this correctly is very fragile, error-prone and
> > confusing, not to mention the concerns around maintaining correct locking
> > semantics, correctly propagating anonymous VMA state on fork, and trying to
> > reuse state to avoid allocating unnecessary memory to maintain all of this
> > infrastructure.
> >
> > An additional consequence of maintaining these two realms is that that
> > which straddles them - shmem - becomes something of an enigma -
> > file-backed, but existing on the anonymous LRU list and requiring a lot of
> > very specific handling.
> >
> > It is obvious that there is some isomorphism between the representation of
> > file systems and anonymous memory, less the CoW handling. However there is
> > a concept which exists within file systems which can somewhat bridge the gap
> >  - reflinks.
> >
> > A future where we unify anonymous and file-backed memory mappings would be
> > one in which a reflinks were implemented at a general level rather than, as
> > they are now, implemented individually within file systems.
> >
> > I'd like to discuss how feasible doing so might be, whether this is a sane
> > line of thought at all, and how a roadmap for working towards the
> > elimination of anon_vma as it stands might look.
> >
> > As with my other proposal, I will gather more concrete information before
> > LSF to ensure the discussion is specific, and of course I would be
> > interested to discuss the topic in this thread also!
> >
> > Thanks!

