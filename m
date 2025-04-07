Return-Path: <linux-fsdevel+bounces-45893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A45A7E432
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB533AFA69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861991FC0E4;
	Mon,  7 Apr 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JYkImPgY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a1mnBLnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319361F76B9;
	Mon,  7 Apr 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038931; cv=fail; b=ovjn/eJWM/jJM3O1g9BcNZRQHdLHK+SyH6DAHWOQiyggr/EREKpUqwp9kcIJcZJFnEEW77KcST8qhTWFUalYsWIZOe9yXh3G74+nQrQjM/UJ4uVZ7qgw7vmER/0nI+xTJoVMiUzKSoU9n0BKc8iqEXGnPhd5Qb1OACPt37WyDak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038931; c=relaxed/simple;
	bh=2AGzF0ffBnv9NHAhUGvROeW6Z6qRYE78KevcYcbo3W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oK5H3heO1HsxhYK+5cejOSC1Dnx2JFciXDv9lnxhXPGqqi2vbsol43INXe9vnTYNbQ7NBrPcBvv/EH6wgQpcAF2ez3BvpLPSFNk4dmcSqDM/wCS7qPMVAqN/8BZKoLYE1Lzubsipece43rT8MTH9m39o6wBrYGbUV9eEccpvPuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JYkImPgY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a1mnBLnn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537DH0jf000842;
	Mon, 7 Apr 2025 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Jb9vfMzix//eEOtnBN
	itd4BMUj1MvoaMMX2PXa9KG2U=; b=JYkImPgYfapicUlKeOa4CtBF4x2aRDive/
	CYnAlAdG7UhOwopeNb+ycCnBevyLdFSBsdfwUwd7AqPyaQQjl6iOQWbv0BZC6YUv
	8yr/X+4pTh7ELxcxxgjJb3pgAjCprVnoF1u1IeTior8VCJJzF1dLDZEYT0bXDavJ
	hOcUqSHEwnRu59XTo+XiiU4Lm++/9YmT9UmdMy1mdT1EE6Spc/FT31oOpS5S5P6J
	uk457EdeIdeBaauhLM3dpLh1R44gqYDt9Zf2qxGgpbg6N9iUpV2EEsEIZ6J/dFlg
	0aBKGx5RcklX45LwkOahQZjozl8E+tz/QBKadIVK6jIZUpb+gdXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41avd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 15:14:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537F95HM020931;
	Mon, 7 Apr 2025 15:14:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye78nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 15:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm4nXUJjNBWwYgPe17UimcX/9gr8R1xod55JFN6UvQoKjEyznr4/D6PCDB5SMjJAvhvQpUD+k75AWHc1Hq8IlpMT2wKsBbqLiezoPivybuUxqSdi43i3gv8xqKfri+AVBlg76DPg+7C7SEoAllLry8drS/EHg4+aaCyT6y4TTFpVpxJdnVL4AsRfJsnY5w+SZNq6UmJxKsNWqwQBmSeIuVOrnNs/wNZau+D8Y4zK274vDOlSGEkLY+mvYCFRajmQ15VskYVk9jiVDdGIaakSnStUhDmv22d+wsLys7QoipsAUCw30AAHmXfu0+CHGPj4cFrtbZ1m53EXoYz45F+iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb9vfMzix//eEOtnBNitd4BMUj1MvoaMMX2PXa9KG2U=;
 b=JXdTRZ3blKE3mgwKxPBw9vT/hQdtUlXQP0UCqdH5ELUGP31bHBj4qvRnc/0yKy6VcoFeYNtTU4TpiggstTY2T+VyYB2Z6OQEvOE72luedRNn9EpvI4kfMBQ8WO/NBXtiFTFit58gYe0TUGruQSv00y8BXYsyh9Gwg+d65/Ao7lY65k04Q39vWgA1aXPOQwvfhYU15mns+jfmQdGUeJUo45hD1V4lMFQMixwlqwkakoXzlm8ftbQYGarfZzUlcMrlYYHtZM++Quj37L5snaQCuTVdk+OF7o+muTwKMw6rGpM34LnHRiSySIwj5GkixzPIr5YE/W7utGtHLSfd5IUzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb9vfMzix//eEOtnBNitd4BMUj1MvoaMMX2PXa9KG2U=;
 b=a1mnBLnnTy2zfEdfrSnt9KtFE9u8c4QPk9xouia0b0YaS13TJocIyNkNdImsN5+FH9mP4T6gCgRqNxliYad4HJRWmQYYRPiI1u+0txTHhhkphZScwLP2oth1TD7GC6Z/OtTslga2Ize6fbIuMjuwDyLe8yY2qNDzswdU4Wo02nA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 7 Apr
 2025 15:14:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 15:14:34 +0000
Date: Mon, 7 Apr 2025 16:14:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org,
        pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, hughd@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, jannh@google.com,
        ryan.roberts@arm.com, jthoughton@google.com, peterx@redhat.com,
        graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
        derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <4a32724c-0891-4ce5-81b1-dfce9cfb91f2@lucifer.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
 <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
 <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
 <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
 <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com>
X-ClientProxiedBy: LO4P123CA0513.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e63e45d-4358-4756-8c31-08dd75e6e786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K/RboZbU7CJijmCS6KIXggbukKA/Y3cTDNz6Md3eI+AZ4YWlKFQeDiurmsvr?=
 =?us-ascii?Q?ZQT5odO/GKCvjfhsgdTlEfQs8VGm9aeT0wlNJ7IVJNVZ+OD2JmIyP9+5nXIk?=
 =?us-ascii?Q?YJWyUbmvZzn8GWrY+Aao16YJ3vE6LovBIJTF74+nOXSRRY51kep2SvJza7op?=
 =?us-ascii?Q?LCNVIdoTKaaUmyFBX1sd5y/2I1t+ZlSGAAe63XxZDAQBwCro3oohYFU6qAD4?=
 =?us-ascii?Q?Tl9tOSmHGoy9mY4hd9UcyGuHrQLwM7W/SQgW1paia0MY5kdP/WpvmrOLjxE3?=
 =?us-ascii?Q?Qi+WH+Iygj+ikRFmXMEtIL0UpNJgbbxBNLkFoYqF4FdNHBsbursZcMIiKxKd?=
 =?us-ascii?Q?gqriSlozycYa1+8DLOyxxevzyeYuR1F3e9OYYh5AxuW/cWLIowhtmf4TIm6i?=
 =?us-ascii?Q?LyzhFUHNVcBQW0A//UZLY3bfJaxFEt7r0OaVu0n0qZ94Xh+HKKJxMjY6FuTJ?=
 =?us-ascii?Q?pVhalx6qMkZViuVnvLDf1f8o0stP2u0a8VA38QHjjtwxgpFW9n/GEvTJVRQr?=
 =?us-ascii?Q?6wvwwk5B2ID1u2RUXzHq5/iW3KvMe+b+8Vs8jWsSGevf0OTVgPZ+KcELEmS/?=
 =?us-ascii?Q?3CM0fXzp335Ilc9Bc4hrwrdlLpYM9sHgws9sy/RAd2bFnXreL+l0VI6jgQ5V?=
 =?us-ascii?Q?GDnWILvOVfwgqNOB1ivOtAtAuK+vfS6Lk9OyKKlPJMlobV8ayqdih2aOMKIS?=
 =?us-ascii?Q?lL8g6mDwzSgGd8DO9h4CDvrL+5meo8X9XXaksseS7YUtdDRSWlyDITrKGbLC?=
 =?us-ascii?Q?tsrILE7NNHJL/U5xEX2u5Q0FJB11GCYs5PmcW6gGc4CyDzS+gNu+6WUDlmzg?=
 =?us-ascii?Q?lirB+RWzygDwXWrIBVP88ttrBZtW/c9WfuG/VOnxUvbEkX+AdCwz5+maZq4w?=
 =?us-ascii?Q?9JmRx3rT4dewX6XHiMbZgfHcMoT1w26kBumhwdJ/MwG1PzBhcHzTVyMmwkja?=
 =?us-ascii?Q?8I8wOErCAw73MHV2FZWr8gohlg5eiJHmWIPi1IrlhEPMKi5NtOHs00ncCcXc?=
 =?us-ascii?Q?iGI92wTs9L1AVsekNj3pv9AuTZMiwjYcFfQFkydAxtTar2eKzR++N2E9jbri?=
 =?us-ascii?Q?7yJ2cHrU4Yb5Psa/a4eP8VO5uNGvoMQg5RWFnmXMsSc+i88+xTIGaBHjblZN?=
 =?us-ascii?Q?kgUWMlJid8OcByY9cDVhCvBIA6OlLB9xeSgdD1OUcr8w/bnTiUw8DXGx/6Rg?=
 =?us-ascii?Q?+jbMjv6TMb5oESI5evcy6OZ+qogQ0Vv/UTBZB40AsMcARQy9PfnOeGz/v62n?=
 =?us-ascii?Q?s3l20sFauA31vZSOPVaRmPZLY2qlFFQaMPBigQAmCuJI4wMv2fQSdZUwivQp?=
 =?us-ascii?Q?+YFgRqeiZMVQEUkSRD18vZ4b+9gEWGH0iVz9H950DK3jt7m7Z3y65DQappod?=
 =?us-ascii?Q?8AIBqVCXRde4gGyFxKAkqnVVt42n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsV3Achm51duLaBfqdlM7/8/LBz0+694e5ux84ByfreSTNS3yfqqpjhFFFDQ?=
 =?us-ascii?Q?xXo3A9Zu1dszwmq5uj1F/aIAjpD9bNcfjQv9wU0bl4aDTkq80u49pt+4OALp?=
 =?us-ascii?Q?rYfb2JdccroDLwTBzhcRPDz4nLxin7LUBUhc1LZBen9PJdKoyiVhS0GVACGL?=
 =?us-ascii?Q?Pv5FXQNM1gq25XEaTafGMOG5g2m+zFyFGnnq/5bmdcypI9401wlaEPlDj+Rk?=
 =?us-ascii?Q?9jyhHhoGBrMMOLvQfXKL0BTn1gqseYa+85qhTPSxpoqKplAuXJfiuGR4865+?=
 =?us-ascii?Q?QffNCXmr05dMpvB3cIRDiz7xOhZfPxdEQrso9oSIQ04WC6iJLiCUO270i86Y?=
 =?us-ascii?Q?TTsxMNx+V05FNSHyq+B7fDus8PFvUm2d7Lyo/GwYRssnuPJGE+8T0BR15SCf?=
 =?us-ascii?Q?l0QsniiLx1xDt1OzXxaEFpiOqx3RtUwiCDwhtbWtRLYR6JNphauqK3iWWaGf?=
 =?us-ascii?Q?sI5EewEbqCqmpTgAWTyMhmh0JNpDAefg2xGV4mayxmFreti5UnXDkgkCMK2s?=
 =?us-ascii?Q?mwM36B1bFiHwUembo62bx0DgxZ60RnF2X/MWOJfHhj9hDBFrhyKuPrnlSa0a?=
 =?us-ascii?Q?TyUIw8t3BygitS6QFMawAQBC2E4k+V5HRg9mmi281kP8MIL15u2KqSO//CJN?=
 =?us-ascii?Q?96XN1xc7KqoyqTAOuJivmWEjOMK3Yijevrj0IIUO6dmOk5EXTiqMWoa3o4bg?=
 =?us-ascii?Q?VI1vnzK7wVUbBD7pALvcpTF/ntHb1LRCvY80dMg9D2EWzwqGKoDFc9ttBKdg?=
 =?us-ascii?Q?5UkXDx0THYqSdQUje2qVuZ6XNbxd0Fp0XZqIo+j8r7iqn/YFkugCMzVZO1JO?=
 =?us-ascii?Q?7h0oSVzzAsjqPYPAx511rTEwbTvh6HUtGif/MH1LF/GsB4G0WliEhgw170b5?=
 =?us-ascii?Q?CjIqviM4ABLR5aOox0xZA2BJ3grrY6upgoHxNQHfH/EWWMWCH+z9/nqPnO0m?=
 =?us-ascii?Q?aW6qYJzHvfF2gGyvTGUH6NvRx2aanQvqnlwkYYnQTgum2zYLwu6ODRY9ejCm?=
 =?us-ascii?Q?9UhTTeBCOpedLAnCwKffa/jNB/vhT/L8dSzw435AjH8e6yPp5hnMHGoEvaUU?=
 =?us-ascii?Q?kXeK53TsIPkrzlLnTIMZDSpT1mH6MZcQCrPbfXerCzMQgSS/64Bt2x/v8tb/?=
 =?us-ascii?Q?/AgFEwEvQvcLs7aJM1gZMgtfNkAfk55QjMPk3db1mB6FrylbKCBogvv5KlqV?=
 =?us-ascii?Q?oALqObb2+DixyJl5hEgRVvK0ShkJiozQ86OqlCWFCxhyrav3SOHzmbK5Tugl?=
 =?us-ascii?Q?3ABeMEwJpxEo+taf8dX2vc6KJzFb9Me9FsWgFso1qwcgkdkL6Gj/3dke05rr?=
 =?us-ascii?Q?slyFkUHIbNtNY1IlKFMq5Lmu4JOERcqPwW/idTqshvVny5QlEuXwCiMih3qE?=
 =?us-ascii?Q?Lv3ClWeXvDHfgpQKuUNdUHW7yFJI9gWH0HBTTLuwkctOsCc3nlPi7fqsTIc7?=
 =?us-ascii?Q?MpP8Iw3wJJrAD81/jtH7LrnLs+aAbA3ZYztMOqDjIT8yzUrOhp6FKCXGm7Vo?=
 =?us-ascii?Q?oiyuHHFyzDLUBRV7CPDuB2+kE0Zll5DkMnvkXFraSgmQSlaOHT54q4jXbYJk?=
 =?us-ascii?Q?atm4D0Zg9sWHhEgP/yETytBuo2TV6N5RyAj6zqqhqcy/itxdToi+vzI7HB8k?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rr8yEqMLrBo6OPuDBq4moPj4jCQLp/07EPTNTGYfAWjkbwNU6Bvy0EFxRwNB8y3uIFQ61/yq3mQXEH7pZEhee5X4OeRgG1ra+mQBAlqERCv1xrfQ3dtGB88FAmxiRpFDw8cKv7AkL1vGDYUA3TJsFc/twTC1ctmUFEQNTuv+tGLk7SlpI+IXMTjmlFMKnQUgDBtMoH0IV+LqpFyJWShQMVOJreMQdv3Vp3IWh57qxqeHCRE6CRDr6WGznX2exy07uN0FoaxiL+oZ5YyTbpFsoaLODmKZC0k8hyjKkKFL6ipan40Sman3iu+nI7AGKRm3RwD/RydYTfEzYupqWMXnDbUfNMd+G4fODwKj267vGYEZYiV8TLRo2+Zprwy6obbWgIf4AKkjf0kIWZrxjiooi06eUaRHqjrRH9Hd/hFnDtPtYsMTSHGOITbjvaecem+Y1S7qoRlcgFQseHfPqBQq3v5PHsDKvECeYXtDGKGsm74yrdCcu5Sw5GFdLNW41XlV2DBdHluOvWHlmcCU7g93FnFaxsWgIEG6wubUvMyK8nLpFbyHsB5I8EC1KBSMnfZyMrRoxTil0Gf/WlTAo+6Bz6ztrXnyUaMWqlZcpbpZnTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e63e45d-4358-4756-8c31-08dd75e6e786
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:14:34.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVzdUprJQV0S+EZCzmlj1Ti86Okeazb7ce4x4RyDGbvmWxD6t5KL6z8wsU/HiqF7XgAIad8Z6kUqw0Sw7OcnD+hG5BlXU3MiDkhUB8hWOUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070106
X-Proofpoint-ORIG-GUID: UVN_UlojEaQQ8Ex5st0MFMwyTcKwUcSv
X-Proofpoint-GUID: UVN_UlojEaQQ8Ex5st0MFMwyTcKwUcSv

On Mon, Apr 07, 2025 at 04:46:48PM +0200, David Hildenbrand wrote:
> On 07.04.25 16:24, Liam R. Howlett wrote:
> > * Nikita Kalyazin <kalyazin@amazon.com> [250407 10:05]:
> > >
> >
> > ...
> >
> > > >
> > > > All of this is extremely confusing because the onus of figuring out what
> > > > the final code will look like is put on the reviewer.  As it is, we have
> > > > issues with people not doing enough review of the code (due to limited
> > > > time).  One way to get reviews is to make the barrier of entry as low as
> > > > possible.
> > > >
> > > > I spent Friday going down a rabbit hole of patches referring to each
> > > > other as dependencies and I gave up.  It looks like I mistook one set of
> > > > patches as required vs them requiring the same in-flight ones as your
> > > > patches.
> > > >
> > > > I am struggling to see how we can adequately support all of you given
> > > > the way the patches are sent out in batches with dependencies - it is
> > > > just too time consuming to sort out.
> > >
> > > I'm happy to do whatever I can to make the review easier.  I suppose the
> > > extreme case is to wait for the dependencies to get accepted, effectively
> > > serialising submissions, but that slows the process down significantly.  For
> > > example, I received very good feedback on v1 and v2 of this series and was
> > > able to address it instead of waiting for the dependency.  Would including
> > > the required patches directly in the series help?  My only concern is in
> > > that case the same patch will be submitted multiple times (as a part of
> > > every depending series), but if it's better, I'll be doing that instead.
> >
> > Don't resend patches that someone else is upstreaming, that'll cause
> > other problems.
> >
> > Three methods come to mind:
> >
> > 1. As you stated, wait for the dependencies to land.  This is will mean
> > what you are working against is well tested and won't change (and you
> > won't have to re-spin due to an unstable base).
> >
> > 2. Combine them into a bigger patch set.  I can then pull one patch set
> > and look at the parts of interest to the mm side.
> >
> > 3. Provide a git repo with the necessary changes together.
> >
> > I think 2 and 3 together should be used for the guest_memfd patches.
> > Someone needs to be managing these to send upstream.  See the discussion
> > in another patch set on guest_memfd here [1].
>
> The issue is that most extensions are fairly independent from each other,
> except that they built up on Fuad's mmap support,
>
> Sending all together as one thing might not be the best option.
>
> Once basic mmap support is upstream, some of the extensions (e.g., directmap
> removal) can go in next.
>
> So until that is upstream, I agree that tagging the stuff that builds up on
> that is the right thing to do, and providing git trees is another very good
> idea.
>
> I'll prioritize getting Fuad's mmap stuff reviewed. (I keep saying that, I
> know)

Which series is this? Sorry maybe lost track of this one.

>
> --
> Cheers,
>
> David / dhildenb
>

