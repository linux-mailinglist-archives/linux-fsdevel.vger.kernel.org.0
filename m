Return-Path: <linux-fsdevel+bounces-59779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F539B3E0B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBC13A4BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39E30E0FA;
	Mon,  1 Sep 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p2vCmEQa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UatYLO1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81F2580DE;
	Mon,  1 Sep 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724247; cv=fail; b=XuDrj1cKlPjpAK5sfzI0j9JlgZr0utiMOIxD+GAq8+9S4IwiT0WJpHo4ByvqT9a+1A+lsxduFljvSYrDo84TESfWOTB5r9DNt+O1T3mSemNMFojVhIUYNm0bv6LeKl1vY+7fxSSaKqVoDrBqbM0DD1GUFOMYd/L+5KutaCS0upY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724247; c=relaxed/simple;
	bh=3FJYaQzqQ9xqwVLE7wJY+6rTj0W+CQnz+t9vmoJ6C4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6lt9stl8zU+rErpujqYfiAA/c3WUAs5ueLLTqI3NzHkdK46/+2DdsZg98emBp+/R8e6eUrU93jMxwYnqNuZZ/NO7dOxp6bnmcQiSoma6LJT1j3DNTzagHzJ5i2zo4aTGVEVpNcFZnBjeIiq0zHv7m8vWdgd24+grvrQbInBvcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p2vCmEQa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UatYLO1H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fqE8024291;
	Mon, 1 Sep 2025 10:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3FJYaQzqQ9xqwVLE7w
	JY+6rTj0W+CQnz+t9vmoJ6C4k=; b=p2vCmEQalbaP7v/tyaZtwuZNZd/fbPTG5l
	5QkP1HF3/O6Nf85QFn9JvuoEvYWXOXrshenTrMGVlf+IEcXCPlAyR6lZ6Ax8A6nl
	SpYZnYOvuQJ1BnoLZbEJiG2AaWIK6Blsaf7TC8WuQYDFtomHCDcGU0EkVAG277aB
	Xt3JxdJ9/MSq193jiKZTWRoNy2C4o99mkjcCJKluj9dV0haaa5aabwr+j9npqkSQ
	0Dwj/VB+cjavW228+418oIb9ZjmBscGd0kirmWbARaedMJ3ycrh0q0XodJJchz0B
	lLE3KhbRs2SnbY7gMJO2pK2/65RXJrzH2XmUZZvpQp11hWbcYICA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4hqqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:56:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819MkoO028734;
	Mon, 1 Sep 2025 10:56:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr81v9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgPYZ6Yo8EpY4nTzhic3WKoIULwDa6/kdrX8d3b8JH6jrTrnkVtfNeKNDTDcWhHQppnqcvrXdLjFVw+LMd3EMpCkqcSdSDPkwJWZ2qPsfmkPt/PpFm2yM0F1C5QNG5cBwr0D05+OC5adQXnS25eWgssGmhQl55DC7Wip7e9dDyZ+LN3/YXcxMzGR8EBz2k7VgJvAndRZwiGFALp2/yD5b0E0ixoWmRaIpBwY9ksvNLq1qp8u789kflu34SbjF/CCMaffQMrWy1SzPsMsOnzhMDlDQPTdg4DgHpQHc0yV36ooW66tnlGZJLTrBoH+EMwU8tJvfh47cLvZRJOHmNtEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FJYaQzqQ9xqwVLE7wJY+6rTj0W+CQnz+t9vmoJ6C4k=;
 b=kr+ZmBzMmtJX3aPMJlPqby8wIyU+WI9oxJ6JQNfTk8qE8Cx3SmOyJvVI0i+4v3dMzSv7QavusbQTa/wGH+1U4Rjbmjjg7ZIYwkGuumCAqvRntUefIHqvhshKpZ69w9Zi43pWYTmNB6DfPkRhrlvY72AiPNEwbsJC1+q4aJkrPbd7vdavWo+ECwNnKKn+M//glmwTt2IB67NLT9Wn1P9GbTTjiaLaiS6jimXi9GRrEsoEd3lyBKMOhoj38SMHN7TYellryRTVeyN1tyYkFaTuaEoMnsb0FgX34FeJvzjs+NY/Kt2znmVcVziEwwH0gd9lYc09IdCcqnzVDjEApGv0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FJYaQzqQ9xqwVLE7wJY+6rTj0W+CQnz+t9vmoJ6C4k=;
 b=UatYLO1HQ/E5lIADHuc9fuzF8NreMiwZgk4L9fxIN8ckHfcYTHfjp9WZpKJ4vBO1g6YvKfx6i+sBurRZNfemeDJEXZTZL9rJyQN7IhwRI8rx8xuVsHqvvlIcNY9W6KHuWdQ112mxS0/CaoEQXjzTWynN+gnzdx7gX63LsHgrDB8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4240.namprd10.prod.outlook.com (2603:10b6:208:1d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 10:56:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:56:08 +0000
Date: Mon, 1 Sep 2025 11:56:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
        hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
        linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        conduct@kernel.org
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <593bf6fc-bb12-42bb-b763-383ca16e3adb@lucifer.local>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
 <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
 <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
X-ClientProxiedBy: MM0P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: a59fc083-2ea6-436e-43d4-08dde94627c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJLfb2Nwh1oxI/RIaQsDAREqYw93lsH2Y/EA5DCHrQA+TNz3ympx/bYrvo/Q?=
 =?us-ascii?Q?wO/SbfWAWBGF20sBWFPlHSuQZC0KYrAWEbfzIihQWUQIfv6koJH8yqOLl2K9?=
 =?us-ascii?Q?gmJ8XLXCfMdYn2dc/aji/UM9dhorfbLCxmPXzTAxp+vDVEJunHJYZntLCNEB?=
 =?us-ascii?Q?JqYRVk8ch8bQqJPiyi8rZs+7g6pTYQ+n/oYJHu2W6gCBPGLdQqQOrMShdqLS?=
 =?us-ascii?Q?yeOZUu7ABwCrGDQqhMU5ibhN+/iyDpR0nXqaUN265VAUt0e5jXe3nO/bcg+H?=
 =?us-ascii?Q?pjodzsZXvceVwFKuZzKgJVy3r7vKtj1Wdl5uevjTD4wgOK7OmzQLKMujyFBt?=
 =?us-ascii?Q?tQaIZarEU4Awesj/tAKqGTWjipr8vkYB/+glgKCcfB6x5d7+DDV/qtcssdPn?=
 =?us-ascii?Q?qUfoEZR7kEEHPKXKY/MyENey1G/DuTCJDnWhcOZ0ZNCOMad3h4ZfJoBUrgP1?=
 =?us-ascii?Q?HeyUIG74fnO+bGAIpRpzq9W4yeU/PtwXb52pzgJODnlmRkSpJymlWm8msH5+?=
 =?us-ascii?Q?RSKCcZN1+XASSgv3SR5BNeCoLpPIWx2tXD92GxWw80mAr/rndwrTejDvyr51?=
 =?us-ascii?Q?AzUkU3dZWhKHxod9IWMMlg0zc7SPvDFdSftnZ6PY+PNQwiZB1AlGci5zqE/2?=
 =?us-ascii?Q?7UwFWUrHBME8XivCFLS9TkW/0+W1Ozz9wfc66rgigGpdPezY6JUc2q2csdFg?=
 =?us-ascii?Q?Ey5n8hJWwn1VuNLMSTTEeRGKonRFyDbH37Rwe9bqzcsP34AnLLBdOgdMqXxm?=
 =?us-ascii?Q?hXLRNgwFvEqKQhYfmUJh5Uk6T3pXSLLlQ8wcPPfItDKbBztZI9Z5ucPV7P9G?=
 =?us-ascii?Q?BgeRgjXge62pSyG6TQaZHxY5QgYRV43LkU/9dqBc7Fju3qlzvoAbMcusk0Fq?=
 =?us-ascii?Q?OfQn1kwzzZyuYGPynzErrWzDay7lqjClgIMdqpWV4LxLi8v1RYULWc2RqRD4?=
 =?us-ascii?Q?WaJpfXYh9X6J7yj4zUC5aMn6MSvl2pBW/17NySHeYlXZZHFFh7mqkixXHaJJ?=
 =?us-ascii?Q?CuYLp/yKy2Eb2XxgXofqXzQ5UkwvhoiQpefXK4xOZ7UUwaFCkEwGxXiyjci7?=
 =?us-ascii?Q?F+C+T2udO3s1/2nxLIBQe6UhpXl36u28TzUSPmCp297ULkxmgMjRnI2zPYDw?=
 =?us-ascii?Q?1Eozi+G5o8f0Oyrr/Q6zY/76rQXDXi7Sx2mgov6yI0zgxK40KZ+2SRzVfXt/?=
 =?us-ascii?Q?Qj83win10RgC7cYnZn+l46UuVeQ9MEi3c2WOJAtQin1sz0s3/liiVkk4G5Aq?=
 =?us-ascii?Q?dHrVkt5z+0VnC9iH1eVFhA+ZVNfHIkne9B/3bVJEAyzaTJMn5OPKkmMjBa/G?=
 =?us-ascii?Q?cqhj3YNzh7nX9JTn77zkd7nhj1xqkFdgodwmwB1Gxs9Wc4qH/KhyZE6Li5Ti?=
 =?us-ascii?Q?mGZCWvbkK8yGbr2/RMvS5ajt+L+VJGH2e4jk3ZApzwZh/eOw+vw5Eg8oVheX?=
 =?us-ascii?Q?815J0rkpO/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlBtv80gqTeG/Gn20jY20VYX6uqw1aMqcG4+yIB89Ba3RlOgiNXWdCbZcczf?=
 =?us-ascii?Q?RRCs5RI+bDhc4ueHmxRboC3nHSHPZQ75CuQlW+Y3iMcFX6ORygBbu1ltK/Te?=
 =?us-ascii?Q?e2kXZ0mEVfAZLbrUMLUeJXj4u72qKnupTO9xbLacV9pkGx8oJwop+LfBx0Hg?=
 =?us-ascii?Q?k1gnK5xcYjPS5xtwM3ol/OYb04Ldj1gHuYo+sMZwDzVenJ1dknIFm3kSY2AO?=
 =?us-ascii?Q?fpbmlBOvKNd4GOf5OLE14Sc7Cr434aCGvxJ/5JRULSS9bc0QSZ2f/BF4uD85?=
 =?us-ascii?Q?sBLBugN4I2O5++vkJlsU7z72HEcFR7296gwYn9PqdBW3EiNCFvkCgZfd2Js8?=
 =?us-ascii?Q?ChYXPBcFpvIqbeFGBXvuwH2Zca6BrgLqQtbddd3gBZDIWX12EwJ0wSg19fqK?=
 =?us-ascii?Q?zD+/edM4OyuZNVH/qpXlNusfePnA7Tb36o+4DJSa60vLzDdHbWzYXP871v5P?=
 =?us-ascii?Q?OgyhR6hmGoYuTXAQCAcMsMoaxakIX+OKvP5Gqpr3nOuWHyQVnBC5MSWvVn0K?=
 =?us-ascii?Q?VFvYHj77Ck+gsKyrkG3mqJaRV4X6lmsgkgeCXBtRrevmdC64R9QLhu5+nWBu?=
 =?us-ascii?Q?xfE7qTq22ILtzp/76QbwpQwjpAwCxbYCJk5QYJvasgP0RpMTATlvDb9wDLPV?=
 =?us-ascii?Q?z4PxAqPBr9B5Bgm5StipJwupgTUXVeKqzFdUJ9Ir2cOuENishQUBbgqpWB26?=
 =?us-ascii?Q?63KXuDxl2kMSb3X+Hu98opIbuSZGe0JRVwAwobkiKEaKQ1lVNHbYMZ9U5pyS?=
 =?us-ascii?Q?VszYF3DvnSNIgRlPuKmqZfufUa69LDAgutx+P/yFG5gkjYI8WTUaZ4USSuS2?=
 =?us-ascii?Q?ifv8rlCKak2AATm35NE8R2tIVt1tNAPJFwZR5hO8w6MiEnox+aPansG0NCjQ?=
 =?us-ascii?Q?/j9gDUTDFuWmSbk+djyKPEqesm8+DRci/sABJb0wOTIWnPMbQUOWolOeb9ua?=
 =?us-ascii?Q?iZOjjnvlXnc5yg56c+jwvcvIHh+e8kIkJV7h/kLgmKGWN+QN10WUbXTYd+CH?=
 =?us-ascii?Q?Jp6kvAm+lTYLmaROOQvu3gl5oePsjI3EWrFlwvSGNx7tbst3B0ph2WbH4mtK?=
 =?us-ascii?Q?PYJRnCQwPbLF8Kx16osjhK7WrnrIXWxBq3Bzc87Uc/SaCi39MCJl4fn/L/JP?=
 =?us-ascii?Q?h2sXhu5klOqb9RchcyZdUAovt5NN0h+n8Qf1bF+6m/ThlDzLVcNffF8FcUIS?=
 =?us-ascii?Q?bOj48ofUgvumFKUUu44BaIjsXQpn4vaVxiyj5TRLEhCuCpX+jhW7SXBuo/Ok?=
 =?us-ascii?Q?OEdr20u69B2To3LRExuQHrN3H7Ji7xChyhDIVgFaOZOt8rFJ46O5Na7KMmsY?=
 =?us-ascii?Q?AOgzoACGjB6ddAo4bV0F9CLk1WGTWs2a8KDdjZbRumIG6qjHP7/pSkHmA7ty?=
 =?us-ascii?Q?RwXtj8yR+HGvknxC2/skagFFAlZ29fLa8NYG1lgBLmqC93+Lrv3Db0gLQU8d?=
 =?us-ascii?Q?xHybOywKUhApj6GQ37KsW3l6ijh0qadY0l4k7+uSeM34IGS5LOzq7k3trNli?=
 =?us-ascii?Q?C6riU+v3jhFyo0cjZGIFubzxX1FmC1goDbdGAbNTJWSyJESTslwxia8fRZPm?=
 =?us-ascii?Q?h4g217D+A1UyCOjzwUqNdB4aGTtA9oe9UcPZA9aAlS7dsAQaKGhQ6FQ3yi4n?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cudAxWwIxJeSbm6nVFgOSGuJgR0myfcF/mXgzVJH8nuZjPtnIhJMlgPQOMS8OPNcWSbadUQzpe/B1xX2/Yy2u5AnW8Tm0WaumcsdZAcoKsVx16dQKlaFw6ngqrSuKL6uJD95QTt5eO5K/1vMfkHGHj7Frb++ArEAK/I5M8JYIyudZupbUF9drwid3OA215mOm53nlYytJNqrh2chCnlUM01K5VxM5flXTILRbq6nPQVKBZBrGj4YbZ865sll9CIPo7jZDskJZgh8rSiwzqJI2yIV63yVSXAhwe9tif6IX5KMzij3Tf6OYNqrcnMS5sq9lIAIkY7bHMHIeMZSq2+FQQ8Wj0fiGef5gCmWqsNzS99hUBpkXaquWuoXIAGnsYWvAtfYUwC3gEP66WuQ59O09L41mgw0YwRMkqfOq6L9/j8ATvM3bCTJvEXZFBX5poVXB9JXmuIGYQxAZlUXQfzeuyfeeRv/BnyjgLLI0QQSaJL+iGsn/44zTEOe70N+JvtEkUfUtzABnJ9OBnL95qeM+wlENzVS7/p0W5laGr02SvoINRYYNNZp/2WMe0kKPtIuib2EjI5oPDJxPJ0J57p++Kss1jOHKoB93mqa9y9rAUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59fc083-2ea6-436e-43d4-08dde94627c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:56:08.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dInvLmXpeiWnyP9ACCSRdlVgJQBPMq8TflN5ck/F1jI25W9l9VNzW3qMubWWrc0XffY+83SKaKAIyKRtYS8f5KwAOPUXLaxBhs4NrYUvxyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010116
X-Proofpoint-ORIG-GUID: sXhquN9EJwSakq87Oo1QS08nrf3xmXpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX0inpNdHGQoK4
 B7vqjrjmT3e7B87oBmuji4/9SFvSBubUvccNnTkcREv8pprRNMnPfR8uOl/WeaKOhJWKgzBtRlx
 rAdzYFB0XVb7HmZJMVR5DhNJE+LmXJ5Rv6EmL5L4mpSu3hw9bePEwyb/s3tgwwl8HKjzfDM1UGZ
 jFg+g6HVIEkNIUZaAusJuupwKm1TPYSqO7xnGGpwPwHx9SNaqoQwxNx5llP/7oE+cXWUrgwE7s8
 8vcbM+XUA36UN9HlJDtRIfwVuoHoOZ2C1/6WpAasQ5vJUwCIoknAnraP7/wV0n5qAVtDFecC2ep
 OEg1kNdMW5/QFGhfwdQMeoRoS1MNSxTbsilVDrfVXNTjw6YLceappiMNUfuoEJfHmL2ae9ud9uy
 2neGr4SEhaqKJHDRsDlZygoCHMnEDQ==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b57bcd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=FhFobDzODQd3fHLQtk4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602
X-Proofpoint-GUID: sXhquN9EJwSakq87Oo1QS08nrf3xmXpH

On Mon, Sep 01, 2025 at 12:43:42PM +0200, David Hildenbrand wrote:
> Let's all calm down a bit.

I am guessing you are not contradicting what I'm saying here but instead
trying to find a solution as to the _series_.

However, and I'm sure you agree - I want to underline my view that treating
people with disrespect should not be tolerated in the kernel.

I don't always feel we emphasise that enough.

>
> Max, I think this series here is valuable, and you can see that from the
> engagement from reviewers (this is a *good* thing, I sometimes wish I would
> get feedback that would help me improve my submissions).

Right - absolutely - the entire point of my review was to allow the series
to land so I agree there's something valuable here.

In some subsystems you might be waiting days/weeks for a response. It's
important (for Max) to realise how valuable this is.

I for one have given as much constructive criticism as I could with thhis
aim in mind, as have you and Vlastimil and Mike.

>
> So if you don't want to follow-up on this series to polish the patch
> descriptions etc,, let me now and I (or someone else around here) can drag
> it over the finishing line.

I guess if Max sends a respin that addresses review correctly and in good
faith I'll give it one more try, but Max - please try to have empathy and
respect in your responses.

This is literally all that I ask.

Otherwise am fine with this coming from somebody else.

>
> --
> Cheers
>
> David / dhildenb
>

Thanks, Lorenzo

