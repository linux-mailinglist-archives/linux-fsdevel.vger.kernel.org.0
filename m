Return-Path: <linux-fsdevel+bounces-49596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA40ABFCC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5191894EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590428ECEE;
	Wed, 21 May 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7HKfb92";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XkezYo6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F31E3DED;
	Wed, 21 May 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851832; cv=fail; b=Qu+YRlXKSwmHsqcfGkfZC+5X9HQmddUEgWiazuocQb7HZAcURRYfJNq6f9kjV0CKkPj4ZHihyE2BnnNtlvfwR8EPfTb4ro8OkbmgUlXhdqLJBzRw6OKNDz08800ZvSNu3OB/mX1Yxhl5PY389xzUYRq+g02l4LbPVCH9uXVjCOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851832; c=relaxed/simple;
	bh=ib+i15n0PNMrEguCtMmAK6Wz03cO2kqaola8ucdh4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nWv6l0b2lkW87ejvlEkMpz8STXlIHy7Wd8xitn7NcilWdZv+2DMWnbX/pHQFNM9BWOsddxZXlIDqR4j5Q9WrTtRi7z85IsAWVwzQSVA/sG6k0SAVgYVo9xVHOFTbefgQVVEazQRIL3GlIlN9X172UMQeZs5p9XDuQmzUn4fhTIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7HKfb92; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XkezYo6M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LILkRu007060;
	Wed, 21 May 2025 18:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PE0pyafa/niEnO41Ts
	XiObjymQM0CqdwyXUopgKgyN4=; b=Y7HKfb92IMeH47oANB2Y1syRJOZAnqApDp
	elggEn6m7o0Q2heA9xc9KhvQP1JkTbBqDqZggehh/ef27E171gO/qlLukOxJKlRg
	RUDFQBpcFaX350crxNXMdRttvAxCuiqqzbEZGzzMUibLq9fmKHMGtZv+kkJVn1Aq
	ZGg0376LjV/G95LcOkenIOKa6/NohZwLXP1BO6FonuhPmn+XZfEiu+toWytrtyua
	bFFeOqgY+pUGnMfxKU1shMTHD+8tMeGpi8JVSIrdYL6oRHQ1rIYdBQ/fWffs2nos
	AZXAkEu5cLYc3xIoWR8bLN5S3NIZiW6VQ+ZL3D0FPuCfld4jQizA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sm1vr035-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGpbpu020290;
	Wed, 21 May 2025 18:23:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu7c8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY4AdQJ5J+EZIlot7KchX7AHolNktMQyupyrnbYig0KlqOgCZ3Kepqo4PmaBCVh1w7+H7wEigIful9FtPjzm1Fk9tFp4+rBdtmJNkX/uGf5/3Rae7dyQHDnjFN1gwkUwBZQyqYbEP1jASLmAErr2WTK6DNPs5m39Cqvw13fK7dj9kaTEEZ9Zc2U5Q2QA3ieDRmjtZJJsL8/Bxg2NGBL3EN3DypK1IlSYvZVF9/rO61ROzQZNvg1JAbKtdoL4kwJodNAhPm9CzWuI5LTd5hnqIUjaoQHUD69U38I8wlhsVf6DKjiJXBDcJ4GqDfC0drMsNZlWyuShYrYs09MbmOzlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE0pyafa/niEnO41TsXiObjymQM0CqdwyXUopgKgyN4=;
 b=yhragVa/dA2mTV4AqcwRdPyT48PrFSufNbcRk7B6IXobIaqKrweoZvbVTzUT30F8oIennJkw7vlFelFKbPqs78PBQPnUtdv9+hAIopDtnx4+UT07ruxZFNdcaMfMOBvQeWzLIJhJx6QduDZ5EFvVq5Ja2Jv1IOIuOHqkToHzKIwDOajyCY/CvAFwQghoZzPeh5oUkito9eSB/Qyg5R6Qo0y4zXuCwgwDd1EMCy+1NBXHYaoW00AsnhABxvP20paUXErWkhPKshC8aUs2TWCzdwVIpEci2ZnJlJzwWTToUF3c58EMRkaffOIH0BYJrrBB5PA9/ZsYrh2e/KVzEYniBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE0pyafa/niEnO41TsXiObjymQM0CqdwyXUopgKgyN4=;
 b=XkezYo6MQG+8hmWut4wTAs8/Gcs9MEfTgs9OkXJ/+DYS8T9KHx2LYV6TdqGyHIDBgqq1aeUFfiN7EIf+TY85GjP7mjQEIeA6/DE1cgcxneV6uP8S1z6BtWiYZ+nOAtxkLpfm+tth+NX030vZXg/s6fVXA6tKT2Weel7dQgWCZiY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7274.namprd10.prod.outlook.com (2603:10b6:208:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:23:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:23:20 +0000
Date: Wed, 21 May 2025 19:23:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH 0/4] mm: ksm: prevent KSM from entirely breaking VMA
 merging
Message-ID: <c9de8232-b938-477a-a6b5-271c27ed85fe@lucifer.local>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9df1cd-defa-4a5e-510f-08dd98949073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/YSnPPqclLVTQ+nDg2qE+lgOmTuFBHFeJQE1InrpW/qJyCA+JwA/iQJ4lVS?=
 =?us-ascii?Q?YFsW6wSBhh3+Xdo9TO3MnCTJTZzwxQ3xs2oaDYEC7bLGwAXLIR/fXz5GdfXm?=
 =?us-ascii?Q?sGF4C6vqG8NQgHJDcdlnfpWj4lhE/9+JRpsTArBxvxupz5LcalUtgw1FdRd6?=
 =?us-ascii?Q?wMPyx3631HYO2As3YYGyhABqpgfSCZnbcYci4vHBUXJ0f3ZV4TRFHO1QJ6p2?=
 =?us-ascii?Q?oaSDWBQDc2f6cvoXYwXtOHQp8hoGVIv4JK/17E02U9ieWA7648r5st2vmZWu?=
 =?us-ascii?Q?9XzLHPK38dm3pNCeKTPPii81iyCCheszhWQmWDZGs01IafOybuPuRT7OXRe7?=
 =?us-ascii?Q?FRIcLbToTSwp1JTF0Cbp5hGLdoTyuUjQrCOa/acZ9eWmMXbmwW/LqUmeExt+?=
 =?us-ascii?Q?pGVTHRq49CXig9flJYC4P7R8RZXrYfs3hvBAXVmuIWwHGPEof3ENJyOhB4HF?=
 =?us-ascii?Q?EZYQA7PKYOMTZ5msRrKVbupBsuEUHl8Y3Pn7U4ollyfbtB55eE+ItrLmwpC2?=
 =?us-ascii?Q?wPV9LyXwLS1skO2OR3r2UUbGH8lQ5QlI1ft4SF9QfSfwoyNHLREQ0wyOHHuj?=
 =?us-ascii?Q?d4kAXttoO+dSD5YJWYVbVM4RpZSdxhVf5zirDP37a1Z5FNT72k7rVK3QeNow?=
 =?us-ascii?Q?WqRAk+B+LT3e/ngc6Xg6V/GgA1isODzraJrY08anvv+kOYnxjzn8TeEh1NWM?=
 =?us-ascii?Q?Ka6vbB8qMoqjnhC4SCqgWZ24tV4gN1qBOKoHG07Ed1gzSJ40LUZal2r/X3Fa?=
 =?us-ascii?Q?E/GkxlwaqQq9bONZCk62ynP3Kp6gz/hertrA6l7PFleE2N2UIwkq9wi0qxbB?=
 =?us-ascii?Q?QD3mrs81mi/Nwwh8Coer6ro19E0ASOQjVg9u2mhl5RQvV6S92KBexLDyS55O?=
 =?us-ascii?Q?dGQJK1/4XEy4JMl17sL4o3O4FuaB/JP6q+yWZCkvegCeSgJ03F4rR2Hr1E4j?=
 =?us-ascii?Q?GlFNF0/K7Nx0NQaPO9NBf3GJTNwkji8UBY/FUfS49ts/BIgK8kHGErjGWdSx?=
 =?us-ascii?Q?cXYO82V2JcNDaz5U2n1sdBGcd3WF0AZYPjvUEbZ2XKBSMOwEJMCagqLTX5Hl?=
 =?us-ascii?Q?R/n3QqC+3H/FA2wdexdYfMY+YTZ8ugHJgQaARxRnyXMT90cyPp0fT9MarX8r?=
 =?us-ascii?Q?Vd77nxK52V2MEmK24mXizqK/1LhMzW+oaBCETgwqBmMoI2oZ/xymgjecSEP0?=
 =?us-ascii?Q?V7PdpZPxu3Sz/OWyiTo6fwomfPAmVc9xMRgGHYT1rH0zHBxuJ+PeBLm4AZAL?=
 =?us-ascii?Q?/W4EPA3DNlT73oBv4Uv+dr+EHMDvaxYoVDDWI/Mhs66b14oSL1VsNe+8Aozq?=
 =?us-ascii?Q?yi3oqYJ34/YF3Rf6QKGNyqzX9KhLMMcnXfDctOJdlJiQMERf7ttjhBW99lsn?=
 =?us-ascii?Q?UMmcxZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Igp9z4PGYE5aBeO+anNFhy1HAKcygk4mtpHTKyrPWLRCGfLQtbGBodIZ6pA?=
 =?us-ascii?Q?+vyobMvona/T6HNkHRAI43C6vxirWo/KRbxQ77pn/MVuMkOUkA4hcwlBri1N?=
 =?us-ascii?Q?mqiyQg0QIs1DkwQZPpSnPXmiTHa3n5NBSOmGDsh419rCH9/Kh4Qwh0Kqkfbf?=
 =?us-ascii?Q?LkOywLNjq8At50OyKjcAqR84y2gLtknB0FBlspKyj18yZRsv2NUcNwrsX45x?=
 =?us-ascii?Q?Nu4G5eZjtE3zUB6MMFj8BBMI8D47Ujqa+pZJXws3uHSKa9rNgsXAzkZtpA8S?=
 =?us-ascii?Q?oLeUCHanx1yS1QFZ6CBgtrOmKlTf1XDlVyURGuHsOOqpB3aMeOscFEqdNP70?=
 =?us-ascii?Q?xfQCFVkknQJFvK5YH5W5gjdqFljEbLDKnGXoiNTisslM+5pjglkMTBbz1T45?=
 =?us-ascii?Q?o+f4C13wXTB/XWxAD87ZyQYIt/s9VcLK/pz8wiPhZhMsyd9DuSiw+NgAbBqB?=
 =?us-ascii?Q?mjXIieOUTD1FQO/dEfPhqaimkHCUWwfdRaerAxTjqP+KgisLCgjiRd12cFeA?=
 =?us-ascii?Q?/MwzRzv7PyDFoyE4okV5/7hv/7W4Gwg+uzqRbwGDIZF65Q0sh6bqM/BZ7rqt?=
 =?us-ascii?Q?yQ/e9hkWzSmsKEAMWtUof5bZsEMW4ZfV3PHL770vY5MfCG/BpNPMLuUfubLl?=
 =?us-ascii?Q?UH+dwOMvnX+43RyNQHGd1fGd26ev1vKFRkllDVdQBhFFEOAKeDfoayO7DjfT?=
 =?us-ascii?Q?Y+xoTvPGMxcxy9WHt3xWWsVL91Bl7GX5QqaSpjZeO6Phv6hjAkaOJrBhIQOs?=
 =?us-ascii?Q?yHTWh8T8inHKLiboVdFbH18P3DU6lKDzARF7T7LT8Ufdwjn6HaM6uUQOCvxP?=
 =?us-ascii?Q?ioYlFmiw6+gBVipIE5jL0/Zua8iRCEsxLx8esuMBBfqdAC1XGmlTWQjP9q50?=
 =?us-ascii?Q?L9Q4qsUa1Wpqz+pckXjzZ5iCaJSSj7hg3MF9+k19tECNtm2i+7MkORBsMknL?=
 =?us-ascii?Q?oTKtFgWJNtdHXtRdF1gxD9E1l3X0JEq1uvOfuLmWhK1QlL12x4RruAytFr6T?=
 =?us-ascii?Q?rch0XMNnxThln+Pra+NugZ0cKOZQ5ZVf6ig8bWH2Rcoy+bOppFJ/SplCCGET?=
 =?us-ascii?Q?eukuAbNUKbX8BVn1iR4SmALb8KVfq3Wv8UmzkO/Y2IWhzVtLIPhn0uFIbNQo?=
 =?us-ascii?Q?S1eVi8EfI4Q/PFSbnTAS9VJokyHyiNnvWHo5XTlExNclBno6TQxpeWCJift3?=
 =?us-ascii?Q?aTExBCKQMAQ9GSBeXI64VWvReIyAer7FgMNLZzd5+NZXWQE6c2HRutRl0RfU?=
 =?us-ascii?Q?/fn/iYxjE411E0v4E+gAMCEhw5rIq2DQEJe3r+0c8G4WLiExIbpL5yenjmYW?=
 =?us-ascii?Q?fvrBiPIf59LUX/megjXEHXVuZpcVINr5m/bo9vqSNxGsz/+n2i9reIBm10Ng?=
 =?us-ascii?Q?wbaQe5pAyp0NDNR6CL3sNk507Cy2JzbOIK1J2EwJWWAWWqKT3h+RMk8wXRTj?=
 =?us-ascii?Q?1v5q0nfFb45e3314UIC5Q4pBYbECLtpI8n7gZCIoSa4ocpePKANKyrGg1UvF?=
 =?us-ascii?Q?sKeRv7c59Tk6t8Yc6fMPs0ig5YcRZFyAOIttA6bvPtapXuekoK81+eI1w5i/?=
 =?us-ascii?Q?v9SnP1rhU5Ht9u8P3ch9zt8OPy3yKoU43oqRIXh0x6nt7cZSbpXDr/to7J8z?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rHurlgBwMryc6RRJBEHxNf87/kXHRyzo6PxPEFyGXgK7kmn1I0rTLc5rSIye8JAgPXmOMBh1yoBZuO/fUplVyhPMo5EPXM2KpkBy+xvt+ZwxEYFqe/XEZwuqQJw1lwucdY0FrrhAw5tFeL6gjalbdjSR2EgIK8Ffm+0ZnKTem+50tA22BXFFe0NHL5r+tjlaweOr5hdV/5+XWt8IfFtFIxjMA/c1DyvYpjypEWzK+x4ETfFA/BXvmuBZVkW5xNsrly0kdSqzYHxC+JRRK+5p23KHNvtxouyjwwcGPCfXYWnd+wJVx6ddt+5wd+STAgw2zPARuhj41HgY5CEznSo7kRQbJYOGPbCk5pOw+6Flr1RK6bmxDm6p7zUTrEGhLr99qbs2S/LCbuzcTEcEBd4kW1BNqlEreuj6qDiYBbEbwPLuXKn1j+vYirsCAlsnR1kkIbY/VF5rFjAu7Cg0UARELEBYUJqhSAWY75Cm81UR+V4ivtpswTJ/Q6rSsk7tZYtJGagGpgQK0LR+DudU8EdzWlP9eWc1tkIueIDDu+CqbVYRhb0p66YNxzi8P473zZXJW1Ml0lFr9YVoFVBAJxJ7h60XOpL2f1Rm1lj6MbHp/Qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9df1cd-defa-4a5e-510f-08dd98949073
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:23:20.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu9ImB9CzJby9JkKz+fPgXlfOXxILcTPYFDMV+xq166jzIqTQrRD4eUru+om/JBnZDia1k4G1N+TVB+9l2t4p79vBUSSPrEf/gXwdq6AZt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MiBTYWx0ZWRfX9SHQUzbuM5/Y 8QgY3m7ZdLNP3Ap5IU9t5HpLOlm/YOuI5Q1vVxi1kgrQNd9Uu33AxYG/+wB3LPEzHD5rTXiQbYI sjAIwEmqpBKKE7pvl+WOoow2GQ+uMVni3DMankFGE5h5DiIklRZwoMa4fh0L9ukifEqyFGrSEjc
 fKRms065mINLP9gvgYvEqIrKUnix57EnuH+4Ke7PI/jcGWYgQK5Lobs6iB5x5+Cj97p6Z4dko6h Hu8UeuTJHdlTxyGKE89R7jg0lhmbMyyVbvkYVCuy3uCXBeOdFgl9I/nv7XiAGm2OrYcW3O07kbk cJ1ylD+v1R/i24nr1+d9DG0QH+dmZaAaOGnuvzbDDC4BrrP/StAo3bfaOwG/AVSanj/7KimaXTo
 nc9k95ahXwgLpuBeERsT0r3FbS/OgZ6p+OU0BZpBeQZHT+uAxW0OKBZSm1UNE0rT/OtCdsdv
X-Proofpoint-GUID: xIFjdSpLUOSdahnAjrklwlX_gRl7YEGn
X-Authority-Analysis: v=2.4 cv=IZyHWXqa c=1 sm=1 tr=0 ts=682e1a24 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ss07m41a0F6sz3xA8K8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: xIFjdSpLUOSdahnAjrklwlX_gRl7YEGn

And in the annals of 'hit send then immediately notice mistake' we have
entry number 1,379 :P

This subject should read [PATCH v2 0/4] obviously, like the patches that
reply to it in-thread.

Apologies for that!

Other than that, series should be fine :>)

Cheers, Lorenzo

On Wed, May 21, 2025 at 07:20:27PM +0100, Lorenzo Stoakes wrote:
> When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
> defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
> them available to KSM for samepage merging. It also sets VM_MERGEABLE in
> all existing VMAs.
>
> However this causes an issue upon mapping of new VMAs - the initial flags
> will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
> (this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
> VM_MERGEABLE set.
>
> This renders literally all VMAs in the virtual address space unmergeable.
>
> To avoid this, this series performs the check for PR_SET_MEMORY_MERGE far
> earlier in the mmap() logic, prior to the merge being attempted.
>
> However we run into a complexity with the depreciated .mmap() callback - if
> a driver hooks this, it might change flags thus adjusting KSM merge
> eligibility.
>
> This isn't a problem for brk(), where the VMA must be anonymous. However
> for mmap() we are conservative - if the VMA is anonymous then we can always
> proceed, however if not, we permit only shmem mappings and drivers which
> implement .mmap_prepare().
>
> If we can't be sure of the driver changing things, then we maintain the
> same behaviour of performing the KSM check later in the mmap() logic (and
> thus losing VMA mergeability).
>
> Since the .mmap_prepare() hook is invoked prior to the KSM check, this
> means we can always perform the KSM check early if it is present. Over time
> as drivers are converted, we can do away with the later check altogether.
>
> A great many use-cases for this logic will use anonymous or shmem memory at
> any rate, as KSM is not supported for the page cache, and the driver
> outliers in question are MAP_PRIVATE mappings of these files.
>
> So this change should already cover the majority of actual KSM use-cases.
>
> v2:
> * Removed unnecessary ret local variable in ksm_vma_flags() as per David.
> * added Stefan Roesch in cc and added Fixes tag as per Andrew, David.
> * Propagated tags (thanks everyone!)
> * Removed unnecessary !CONFIG_KSM ksm_add_vma() stub from
>   include/linux/ksm.h.
> * Added missing !CONFIG_KSM ksm_vma_flags() stub in
>   include/linux/ksm.h.
> * After discussion with David, I've decided to defer removing the
>   VM_SPECIAL case for KSM, we can address this in a follow-up series.
> * Expanded 3/4 commit message to reference KSM eligibility vs. merging and
>   referenced future plans to permit KSM for VM_SPECIAL VMAs.
>
> v1:
> https://lore.kernel.org/all/cover.1747431920.git.lorenzo.stoakes@oracle.com/
>
> Lorenzo Stoakes (4):
>   mm: ksm: have KSM VMA checks not require a VMA pointer
>   mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
>   mm: prevent KSM from completely breaking VMA merging
>   tools/testing/selftests: add VMA merge tests for KSM merge
>
>  include/linux/fs.h                 |  7 ++-
>  include/linux/ksm.h                |  8 +--
>  mm/ksm.c                           | 49 ++++++++++++-------
>  mm/vma.c                           | 49 ++++++++++++++++++-
>  tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
>  5 files changed, 167 insertions(+), 24 deletions(-)
>
> --
> 2.49.0
>

