Return-Path: <linux-fsdevel+bounces-23080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C56926C66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C32826AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E1191F9E;
	Wed,  3 Jul 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e1ZhcvoI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QoYFDwEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9B1411F9;
	Wed,  3 Jul 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049082; cv=fail; b=ipGr0GG1WVut+0bUBhc6SC6rDzR+F27EpvAfehz1Hs88B8T9IEm3/PQLlvubjGvxyeomtMvTTuWZX1YW2ZrcbxvgEzQPJql3t2coYQspBHL3fP7ff5fIHczfbsLxlQTntb/iyx1w+a6kSl7CzZs78f8+34l7turh0WXBy4xSHsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049082; c=relaxed/simple;
	bh=N3GJTM+w2NjZtVJbkUA+ty3PZ1HUS7dPa+q0Fk9xtKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAC3JKdjCN7ZektQZ1jLFyQB+Uuf/ha8pGFqyOhO44xRuvPo+kYeI14didOq5I03OMMsbr1v9FO5FOMY+qaWfeTD1wlw4cfT0sUBJc1w5E70G4GgkjRtIFW3W+BO/39T3BJg70qkzjHv3/sN7mBQ0yZ7XCCInK2ULsjBwV9UPJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e1ZhcvoI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QoYFDwEh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463MZuMM030979;
	Wed, 3 Jul 2024 23:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=LimfSSbz9z/19g0
	pQwWLztjF/+0J6ixsaNAYi1ClFZU=; b=e1ZhcvoI8X9bWUciIF+Cw/xscvAkNtB
	dcBImZdrYB8O3mLkWtFjJeuPbUBpIBVHYgHDDTPaSQz0STA5azi2alWoaNgq8ShF
	keYb+VR5LOeIXufutrBqRDoW8MKMYEuxzzEIpjPt0751LmG44q/gxtmo960qzwtj
	0oyjdAX1jX7E3OY8CoXhP5KU7oeAHbY3d2UB1pLTtEuYItt2wZMMEa67blcgN0zU
	P5Kl6s+d1Lb6eoBsJDvLNvIiqUnDAbuWtiBuVd5F/HKWkxoBGEs+4jMBW7C3OIg2
	IJtFW7q2C0sP/GG4OadGEfXBOk80O206HBU6XrsW3SeD0wnr+37ZxeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacha88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 23:24:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463LmeCM024203;
	Wed, 3 Jul 2024 23:24:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n10r3fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 23:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNiNDYUTuF0P5O8Zr8HbDChO1Z3UoEkW6186bbGPO0Q5I2t32b5mXdYcZECy06tBTXBsVEONgKDKirtpSeWYtuNGpHWD1F6Fe8zRyDwdEiWj9j2UI1AQuqxuUMV2KgiVa0kcIeK6Wqm9oM+kXJBNiAsA+RNDBcgBADfF+EYr+crgQfbp2+Tb5ZP+cwvaab2IyE0fgIqnBVqJ75qUytaTEWuOqzTdfDAZaCdwlj6MkwnPSXWb2yaEuFvGRVoAZCYDdyc3xgewZ1FaHbCwIkRvON8FIJp9fBTyJ4TJBF3OcfGXYv1m63vx0bWWPshbjEkqKyMzFX2USDOrA2NYiGjBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LimfSSbz9z/19g0pQwWLztjF/+0J6ixsaNAYi1ClFZU=;
 b=XKrk3wmFmcD2R31xBCzPv+W6aulyjCgFnJB5dPuGNzknk1YkDAhMqOfuzvW0ii3OKOPIFO1kpR5fMFwN9h8yqm9owJs6E4WKNSPEcTQAzPAKlHXoe5gPpQAzRhAZ4dzNOGIE1fdnEfLq1hDHQ5b62NUiLvUMA8tAizAjyf2+s8gjMyiReRHwAU54QhDd2Ez/kmTX9mnNLx3kgOXl6jMdFC8WpqpyGjSBpd6anEF2dy0qNTTn/zqOvvAGExjfxllU9ilw37Yj4nEjWFPxd2CmFwmW5BHEi4PVMj+PLUcxUpsNT3HqRWfxTSg2iPpo7cxhY4OZKmhX4yVldRRQKlpBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LimfSSbz9z/19g0pQwWLztjF/+0J6ixsaNAYi1ClFZU=;
 b=QoYFDwEh3sti+jpAESnwGqLlx2PmWWZZkQwgq1Vg2bDKhHibplidelYIzAuLBEHyyIjhmPv5juBukgQjmVhfRhR4AHEP7cJpN8JmH6JvzCyIpMLOAKatqG9jraslUTNzbhqP2RezqMlIYWhEuN+W00lfo4ANn1ZpgL2n33wW7+o=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 23:24:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 23:24:19 +0000
Date: Thu, 4 Jul 2024 00:24:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-ID: <1edfc11c-ab99-4e9d-bf5d-b10f34b3f1da@lucifer.local>
References: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
 <20240703225636.90190-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703225636.90190-1-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf525ab-15cd-4ee6-e383-08dc9bb7437b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uredjFms3PMqWf6+ecPUk/pUlICQbjP34kBbPvySNSOcI2VzR6NhIb3Kaop/?=
 =?us-ascii?Q?SiTwr0W40+EjX3KYCNuJu8EeFEJys13i54eWFW3QH7DFFssTrD8WpfXi4qGp?=
 =?us-ascii?Q?N+EFqJ3evaNi/mnj3LpJ3aP312QUcHcQ21cFODH3HvuywwOLsuL6+WxZIUfm?=
 =?us-ascii?Q?l1hIWF+L57VITuXrAlTnmmVH/TAgizpB1oWj11bRgvyUlV9koQgNuCWMaHIq?=
 =?us-ascii?Q?iLpJrXnPVkGKtW8ZWYG43U/mJ/24NPGmREZNlMajuxZfafobEi1IVkbqUs4S?=
 =?us-ascii?Q?IrTJpiVePs4eeFtNULHN76esExvY1hCoDaWtCfytIXdmiQ4KxoX0JmSodNG3?=
 =?us-ascii?Q?HnMW0YJwXDTqquM4KZaF2Xxwbar+nxKATEEHbuV40qcGVjYZxsSMuviKFZ2Q?=
 =?us-ascii?Q?YfKDN2D25k7H8UrM/Qbs61yYdzNSLLd/XPUfFcu+wmrDCzq6adgCHiLLcPZn?=
 =?us-ascii?Q?8NZK1nD8zPIzHMO4ZA/QvjeWM+F4IBbmNu3iCXRIayV5dcm2hOr5hCQ5oUuh?=
 =?us-ascii?Q?p+94qtyreryFkCWpXE2uLKerxFlw+gBuAlKMuSj3gNVMqYbTQG6cOlejCcCR?=
 =?us-ascii?Q?WWbGrDDhIeCxtSp98aRn2EWVSCKMcYkGSt4fG43bDmm/368U+BS7jc6fiFu/?=
 =?us-ascii?Q?jVMm/e7JRW95X0+cI8Yds4XXo2E6565FNJqDeGN1G33ehyxOtHQwLwP0Rcgo?=
 =?us-ascii?Q?2GaZAHmN38Bw2+6ExQIwqIodf4U8gaN9gGERhP846vD9P9STFl7HvFkoWE89?=
 =?us-ascii?Q?0V3fhIkHfk09h4y7DvaJZBIBn+zfamPFVPbDaBGKhptV1r1fHUTPrYAjeEzO?=
 =?us-ascii?Q?r4WUQ7XAWz75jFABa90pTJo34lbDUJikCbW31BZx3GaC2KMYbxSWJD+dyTl4?=
 =?us-ascii?Q?pXSioL86jbyLIVXYbsuK3WWkiM2z35tDAPVk5hAxZBKy/LTPHAlPHv83zjGH?=
 =?us-ascii?Q?bUkJi3/UI7X7A2rjuz76MVyqs/N8zap5K8MiyUTOdfFXfiO1Y6y1eCY/5aHd?=
 =?us-ascii?Q?woXGVZI28fVlIl+MsQryormxx4q9SeMS8hBbqILfqPSU/3nqUXetg1ikhQev?=
 =?us-ascii?Q?Iu5fVj/OhH+MaB810JxYbJVSwaC+vtl3OukSrFyNAaAx0Z8XdhCiI2MGAm9V?=
 =?us-ascii?Q?qHX7mIXgZahdVB5WGc0bJB78yUSxAmqYvC2HZKfgwIv0cPi4jm3FQ5NhLasG?=
 =?us-ascii?Q?jf0f5ajuZGbKEb4wkAE2KpYQsRkucOXP5u54vUG+pdFoPShyud+BW8NdBIe6?=
 =?us-ascii?Q?XQ+IJjFuXQdeFnk7OuH7W3k/sbVqdUrTwSGOchWqX1L1w63CHz+qA7g1j8qX?=
 =?us-ascii?Q?pDAgbrQXCkOgl2HS8VpuWlLs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lqA26+o2VB095Yz3pgP8GS+nOSLWf2O91qYjKkbgm1OL4bDmm9pPkWyZYxts?=
 =?us-ascii?Q?88ozPntaqoPI+TUOg+EKcphLMaEVWpdKt6nC7jHtuddO7bTsNgwinXLhdfbL?=
 =?us-ascii?Q?A9APbr6XAe5NcBTT4HiTAmhqDn6Vo8fUQ+LPtgRIcHgN3wWkx/IFtRtV0GAN?=
 =?us-ascii?Q?hWpWISfOxaV7PtaZK9hvbpABgujoANeNFigpupdXoCh4aD2R5UaFILEXEZrA?=
 =?us-ascii?Q?gS0EH5qy2UglmcJGJ/V/E8e5DyAbO/LBM1kZRa10kWK5F8aIrpr3QZIy8RJ8?=
 =?us-ascii?Q?otzLW17jloT/Bh6BsxY0NYEZmUG4lAheU76NPg+oEQsDuYKLJWXDIYL8VhEm?=
 =?us-ascii?Q?7mhDv5SrvoslUKncPkbISnx3zHfTq1ez92VuEnYKZ9U7zdnySxxIREVQGiZV?=
 =?us-ascii?Q?aF6zVrGyZgEmK8IC6nGi7nGs2DIc+N94JnRa5BQZ+BCAhoOemspoeDB1SpGb?=
 =?us-ascii?Q?FvmNntmKOm9ZNv+oaCWajHa3McEigreFLbeAFdvgX36uv3UEXmZYYyOyLnyw?=
 =?us-ascii?Q?ymYtEjW5KYLNM3dVZX4PX59fAuxCu0yVMDtNqr8I8sQrMFNGTzN0bsmfKP4w?=
 =?us-ascii?Q?+FnKHDscK+VhYqxFYY91NC0lyvl6e/0f3d6iLcFgBZIMWPWzRPnHTV5SV8jV?=
 =?us-ascii?Q?SDA6+BPJCqj4pAq9bL+oAsb5D3JJOL1fihd7nliStE88ynWFmecasrBYtVuK?=
 =?us-ascii?Q?9kt93fOwK9yop+uDZaQSsjozn/hQNcCj1O+0uyUWimlt4suUouW+bVzrGEzn?=
 =?us-ascii?Q?xAf2E+C8Cxvb435g1ZJiMsF4NrOQkD661rkLThHZ5L+hCMAWlA3Ui1D5soG9?=
 =?us-ascii?Q?nBssuLJfkYQtTF4VZbze/5U6OZUADly7WBTf2vIfsr091TDJABM0JJkRJZc0?=
 =?us-ascii?Q?xinX7qZkcZF2eFZtRabPOM8mSYF3AxtwV33jiBrw/qO9Y4GlV7UVlx+yCDwi?=
 =?us-ascii?Q?f7aKieZcYvkYHVE5b0eOZBEVzQULCvpzVcsO4iZ9qEhsSxR9/5hRwaj4X45X?=
 =?us-ascii?Q?aqIkw/1GGd9CUY5Uh+7X1D4QcWvtH8xnaksZTuuYAXjuZSHxOVrbRraiCgg3?=
 =?us-ascii?Q?cYdOB/nXR4/ddzNFNJbwEQaGtHtuDsI8U1k4wjaDUcsI7j+yzN/r+r05Tp6Q?=
 =?us-ascii?Q?DxPn1/TYP7BbiE4Z0uNldy0yrtAmnSd4xgbxUr0ro5NOrTHvAQBCtUU1LUM3?=
 =?us-ascii?Q?xklDQ4xpqebKm+IEaBT1JNzHScS5z0/HvjmpNsradZwe77BMGO2F6b/EhwHv?=
 =?us-ascii?Q?vO5YD8RPTALmdlmoirinoE8+gzf5FlxHgNCNNYc+O7QRR0p5VEbj1+FlezmV?=
 =?us-ascii?Q?kmczW1Gnx7SpkvN1njsmineoPo/8eSwXbHeW25tnj0cJtGgDiPxH7EPp7v4o?=
 =?us-ascii?Q?aqWK5Zh09pIRKImPJb5qpTivfU0+9+F2n/h9vSxrwqLf8O1H0glu7s2bysCA?=
 =?us-ascii?Q?04ELrE7an81lTsknyWdAg4Dduiyv3tcvicKEp68ZPfYsakw4XfhEpFlWavzS?=
 =?us-ascii?Q?s9LCV45lft2YXjR2GAhriIN/0MwdDt/zRslHY/XZvlXg1JTJHbdYWTInn7jW?=
 =?us-ascii?Q?mBLdsNHmzkVyZRYJ7YmZERehyVA3XGsrZmHyFllQeQRtlMp/dFY3p3iM3e1E?=
 =?us-ascii?Q?9TCblelHRnmCD1zgZoYBxUbMoiS0XODo9jd0hU4JE0B7rmyVQd5QXrwGLqRf?=
 =?us-ascii?Q?EWuIGw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/mMriMCccJdEfFL7BiuT+4OxOhO3r3SBMYIbDyUvoylRVKXGJID7Vgr/zwiMQRlAEEJC8WWyAw+y/yn0dEFfHX+KTT/S6u6oxRK54HEqf7eBuEgFkeNc/LE+mpN+mu4F1LgyySydQxgFi51h81vSm9X7k9PlD9dyIlJmwPkpWyWIytab6CSyTxExD5nWuF5baqXu5kG/zcJO/7p23cEWSkB60jDVGQw4Fa1WRIu9xvznApADjeIqZK+8m8bpt3/htYC+CAZZfCcdGuKzmiBHulkUdHp7oMP2NdqZvP4wWg0HhhATs8qF0nWBfEgoNxn4LXXKRf2qeI7qEYJw8dXfWN6NQAzL5KDL0LGCXlk9vp5rCVdgCyh2w6K9WSFzCb8N0fMNSI+EQkvDV4lX+EqPXHcj7ChX2/LpwVqkFmrBL6sVXeWk14z2OTyU422tTA3gI4h0xqcbm60OVtWdC5gMv36EoWHc0Kp8V2DQqtNVGhB5hq+GcUce4kTDIG0CWxZ4Tz5gFt70WNaeAvGqM6yCJGEcdJMvl+pQjNlywvCdRC66LMkTwmUiYLGdhZckub1KK67Xq9hsZhzOfi0sjbS3A7l0aj7/SMaYEClY3zZ2FSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf525ab-15cd-4ee6-e383-08dc9bb7437b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:24:19.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4yB1Xcb/9Yurp5d+es3h1rgWNbR4Y9QzlZnXA8aM8WE1cYJD2QGbTwzKbDH986as5yzUd+Wj2qOascdIzewVugNPk41GnB3mHedCSyFneQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030174
X-Proofpoint-GUID: yRzCUJYvvotO-SMIgXY1UePvq9y3jYJL
X-Proofpoint-ORIG-GUID: yRzCUJYvvotO-SMIgXY1UePvq9y3jYJL

On Wed, Jul 03, 2024 at 03:56:36PM GMT, SeongJae Park wrote:
> On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> > > On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> > > > which contains a fully functional userland vma_internal.h file and which
> > > > imports mm/vma.c and mm/vma.h to be directly tested from userland.
> > >
> > > Cool stuff.
> >
> > Thanks :)
> >
> > >
> > > Now we need to make sure that anyone who messes with vma code has run
> > > the tests.  And has added more testcases, if appropriate.
> > >
> > > Does it make sense to execute this test under selftests/ in some
> > > fashion?  Quite a few people appear to be running the selftest code
> > > regularly and it would be good to make them run this as well.
> >
> > I think it will be useful to do that, yes, but as the tests are currently a
> > skeleton to both provide the stubbing out and to provide essentially an
> > example of how you might test (though enough that it'd now be easy to add a
> > _ton_ of tests), it's not quite ready to be run just yet.
>
> If we will eventually move the files under selftests/, why dont' we place the
> files there from the beginning?  Is there a strict rule saying files that not
> really involved with running tests or not ready cannot be added there?  If so,
> could adding the files after the tests are ready to be run be an option?
> Cc-ing Shuah since I think she might have a comment.

We already have tests under tools/testing which seems like a good place to
put things. It's arguably not 'self' testing but a specific isolation mechanism.

It'd be a whole lot of churn including totally moving all of the radix tree
tests to self test and then totally changing how mm self tests are built
(existing code just runs userland code that uses system calls) for... what
gain? I don't agree with this at all.

The self tests differ from this and other tests using the userland-stubbed
kernel approach in that they test system call invocation and assert
expectations.

My point to Andrew was that we could potentially automatically run these
tests as part of a self-test run as they are so quick, at least in the
future, if that made sense.

>
> Also, I haven't had enough time to read the patches in detail but just the
> cover letter a little bit.  My humble impression from that is that this might
> better to eventually be kunit tests.  I know there was a discussion with Kees
> on RFC v1 [1] which you kindly explained why you decide to implement this in
> user space.  To my understanding, at least some of the problems are not real
> problems.  For two things as examples,

They are real problems. And I totally disagree that these should be kunit
tests. I'm surprised you didn't find my and Liam's arguments compelling?

I suggest you try actually running tools/testing/vma/vma and putting a
break point in gdb in vma_merge(), able to observe all state in great
detail with no interrupts and see for yourself.

>
> 1. I understand that you concern the test speed [2].  I think Kunit could be
> slower than the dedicated user space tests, but to my experience, it's not that
> bad when using the default UML-based execution.

I'm sorry but running VMA code in the smallest possible form in userland is
very clearly faster and you are missing the key point that we can _isolate_
anything we _don't need_.

There's no setup/teardown whatsoever, no clever tricks needed, we get to
keep entirely internal interfaces internal and clean. It's compelling.

You are running the code as fast as you possibly can and that allows for
lots of interesting things like being able to fuzz at scale, being able to
run thousands of cases with basically zero setup/teardown or limits,
etc. etc.

Also, it's basically impossible to explicitly _unit_ test vma merge and vma
split and friends without invoking kernel stuff like TLB handling, MMU
notifier, huge page handling, process setup/teardown, mm setup/teardown,
rlimits, anon vma name handling, uprobes, memory policy handling, interval
tree handling, lock contention, THP behaviour, etc. etc. etc.

With this test we can purely _unit_ test these fundamental operations, AND
have the ability to for example in future - dump maple tree state from a
buggy kernel situation that would result in a panic for instance - and
recreate it immediately for debug.

We also then have the ability to have strong guarantees about the behaviour
of these operations at a fundamental level.

If we want _system_ tests that bring in other kernel components then it
makes more sense to use kunit/selftests. But this offers something else.

Also keep in mind this is a _skeleton_ test designed to prove the point
that this works. We can rework this as we wish later, it's necessary to
include it to demonstrate the purpose of the refactoring bits of the
series.

I really don't want this series to get dragged into too much back + forth
meanwhile blocking a super conflict-inviting refactoring that is actually
valuable in itself.

I think it's more valuable to get the test skeleton in place and to perform
follow up series to adjust if people have philosophical differences.

>
> 2. My next humble undrestanding is that you want to test functions that you
> don't want to export [2,3] to kernel modules.  To my understanding it's not
> limited on Kunit.  I'm testing such DAMON functions using KUnit by including
> test code in the c file but protecting it via a config.  For an example, please
> refer to DAMON_KUNIT_TEST.

Right there are ways around this, but you lose all of the
isolation/performance advantages, and then you end up dirtying the mm/
directory with test code which ends being more or less doing the same thing
I'm doing here only in the kernel rather than stubbing?
>
> I understand above are only small parts of the reason for your decision, and
> some of those would really unsupported by Kunit.  In the case, I think adding
> this user space tests as is is good.  Nonetheless, I think it would be good to
> hear some comments from Kunit developers.  IMHO, letting them know the
> limitations will hopefully help setting their future TODO items.  Cc-ing
> Brendan, David and Rae for that.

As I said above, I really do not want this series to get stuck on a
back-and-forth about test philosophy. We already have tests like the
_skeleton_ ones I added, we can change this later, and it's going to make
the refactoring part of this more likely to experience conflicts.

>
> To recap, I have no strong opinions about this patch, but I think knowing how
> Selftests and KUnit developers think could be helpful.

With respect it strikes me that you have rather strong feelings on
this. But again I make the plea that we don't hold this up on the basis of
a debate about this vs. other options re: testing.

Kees was agreeable with this approach so I don't think we should really see
too much objection to this.

>
>
> [1] https://lore.kernel.org/202406270957.C0E5E8057@keescook
> [2] https://lore.kernel.org/5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4
> [3] https://lore.kernel.org/f005a7b0-ca31-4d39-b2d5-00f5546d610a@lucifer.local
>
>
> Thanks,
> SJ
>
> [...]

