Return-Path: <linux-fsdevel+bounces-59872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D0B3E7BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13831446ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B0341ACC;
	Mon,  1 Sep 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hq/WPkFW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yeE2lLDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C930212575
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738043; cv=fail; b=ZSgR5X3Go7+AO1nF5lE3GoEkfHHOvmPUvXS5JnsB7/13AXs2loUkxS0sHZOA/+kbNv79u+hdExfRldGkhzwHizZRSl7jt5v6TdbEI+ySbHx1nLf+BGksLfmbYYh6qRdWdZgyNI5WqVjZ7ULh4kVVxPZwTl9aC0uicPthvGw+S3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738043; c=relaxed/simple;
	bh=a76ms2TnNJh+rdGACF2AoYsbe/5mP0TNHolwXW2J06o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hzQPyFy92OzrkhpMZS6jQrU8VvxRZwc02kPbP9VsG+AxUFp0LRfaYrCnskjEaVIrgoAzbbXhaegemP/6hrV26Wiu5zC1CnfEz9IXnAKyssVBs3rPP3ZLK52XMKELQkOKkpUImw9L7H2y8eeSYIPWOT8wUMy0oLogoebpavySu2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hq/WPkFW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yeE2lLDy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gcVL016660;
	Mon, 1 Sep 2025 14:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NTs+71+Kbw8P0AdJxR
	iH+fhBhOiYA1ktiLejhSFAPHw=; b=Hq/WPkFW+KM2quX08lkOTHJHyvniCSc428
	VLMUuDhuHAA2iE8J295c2cua39PvtmaUWauZdqFAUt3QXXmMCGWzbthhsHDpexHN
	hbaaf0LJ6Ux6cVfBoQv/2D2Z2XQB1qXN6CBB2eDaTbUpeQwZIM5KAWofAuCcR7Lf
	EdMLgyLW6v53T3al56H2erEiqaxE4Zveyn3uycWfgfMw/T5eTNeaFLBUIenMXX5F
	TNxf+zozwFhEcZx7jTmKZCg7DGf5Mqpx+0s+54nKYq0Buj7JVMqLOrMLb8Ac6gwY
	XSNfIrfeQ1Cwx3HhLBrFIKX49Cw6B/pLEiSeHZohNXfgtRGxHMAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvtk5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:47:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581EVKmr024851;
	Mon, 1 Sep 2025 14:47:17 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7xvfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVA3xTkwwzBTGfThrIhMlvnpBmaJmSrVhFMbR2JHLdLtFuMRUw0SLa1WJW8Wkb6GR5jNn1Miy03qcXI6Cw5TjWefA1Teufg4o7YuX5tYPra2No/9OAcFc+uqcEemGT9I4B4bnG/p08oaZSfEobmzubMuCDxpnzNscF2SceqclBdAGDnN9DDwE09vtZax94Uibs4q/AIvV+BRy2uhlMWURRcW1B7k5qCaEHzsDOgn1F/N7i/3hp7q3SC1j/dY/JOodOlFZ0oqVBOM+emEObfXj8xbTAk4ICVCV+iK8HWAXOOgL/68lZ2djdvreV9aCtmLTO+44QnZghm9ai7UDo5IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTs+71+Kbw8P0AdJxRiH+fhBhOiYA1ktiLejhSFAPHw=;
 b=i3wsGf5vZGkrInT6PKPdLD5smXu/fIt4e5AsFG3DkUeDYxFjKvY3oK59IXO5j5HqeGvmSU3jJrZTtEWF9uvyM0wa61Va2f/xWG35R/oilq9Nflb4hXFq2l/BMcUovE9bTjR8cJj54IY2UbwLFW038uPmyLA+B/utGY01R3phFb9KtuZGLIfTbm54Si9s/86CFdz9oqBYD6P8bNtUuhOY+oPd5yJ+m1m31O3xqoEhaGOqZA5qOSmdHz+3spD/TobeQtP9QSqBAvzgghEAGLG/VgWDyth6B+ZWHItW9A//ZaBqeudLgO3xcrF/zxUjWg6AesPLsayk7xY+zj+o67/AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTs+71+Kbw8P0AdJxRiH+fhBhOiYA1ktiLejhSFAPHw=;
 b=yeE2lLDym6HOOnN16mGbO7SsdAY4kDdnKh9BjT5mYbo4OpRZMU9cQWpkwdnfJ5QMzmqdopiMaL3HKC20DeIwngxOigncx6k400VhC00wfogZOn6uxppgMo4LGTy2/MyLd2M4g5tDVak9L0CfyknFoZWIAsB9bR3J4TjKcrGE2/Y=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8709.namprd10.prod.outlook.com (2603:10b6:208:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 14:47:10 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:47:10 +0000
Date: Mon, 1 Sep 2025 15:47:07 +0100
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
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
Message-ID: <8c19bd49-eb0b-4000-b3b3-afdb4af00341@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com>
 <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
X-ClientProxiedBy: GV2PEPF0000382F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:1b) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 386f15c8-26d9-4314-0d46-08dde9666e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Toj/oyVRxS+5rRdAkWRtQMDTkbsVYREkPCJBPq8PJ4GA5HSbLGe1Jof1e3oz?=
 =?us-ascii?Q?x53RW3dVXkES0aQ2paT5FU3hh4ERH1DKlutXniH5MPhIFFFMNlZdKFZPRqRX?=
 =?us-ascii?Q?wRcxX6ZWdYAuMZKsct8Gn5YDk0HDlhmQKi5SQ/313ZKmV4XR8N4oGvD26oRz?=
 =?us-ascii?Q?0SzB3O1n1TFnhrHmDB3iLlhZMGQuxMKp7bYj4AFWTbo1wtRCLzFOeCQD14mg?=
 =?us-ascii?Q?2NmB7SB9u8STbW+eS8rXlNTNRPZ1CgQ0JvDzFaeHhFBjQirKKMi2NoicQRsW?=
 =?us-ascii?Q?fYosBjfs4pzYB3/OafUdX3r4CNyuUg9OImDB25PugqlybmcorwVWGYawe6fS?=
 =?us-ascii?Q?2cIhU/GsjtQbQFmPaL7bxG1xV7RIudsUs4h7Fr+IrjImIYFmuKtnj3xUNvoP?=
 =?us-ascii?Q?Zh2AxZyYMf/dw2bEDKqf+WXs6pUnZDF4EsJj2uWJFCQ7FenVj/Pxhi1SEXQ2?=
 =?us-ascii?Q?Cj6QrnM6Ua30os8Dwyv2FredUyrbmIiTxLzQLKUz7SRq8Rje8jKgsG5ZiQKt?=
 =?us-ascii?Q?DtW7ZNwcuD/5cnBQ5IBwvc+RT5fU7D9PQplo/DsqPCKukjU3YJIEPZC1I/Ny?=
 =?us-ascii?Q?jk7PfJnfiUFGn0lNWBUBKUozzXqs0nq1xAsugbY4thlid63pvKLOKXOFIyuU?=
 =?us-ascii?Q?0zrf4xkxTmqj2UNAMPIX7xFJJJv0hvhQsrfh7ossH2P32jwcpF9XnK1XV5zR?=
 =?us-ascii?Q?85tvCvcqbKdZj0RoyePntR29CQVZOVLOqBvLxYYMEZ+6Ve7Ig7Uw38MqwqpI?=
 =?us-ascii?Q?cK6MwRUG7peBCd/WXndVbLoifmP6c/bvLsZjNExeb5uTodLA7NUczg9uzdit?=
 =?us-ascii?Q?OtGvkFZvLBeuNbQcjdQtGIB6BeceJwwrvbMtWKCf9Pz+QJAuixMmywSrtU5h?=
 =?us-ascii?Q?D4RX/5mB+vhUsV2nu6IlVe+Z1FCA6/lQzDE24Uvk3Xs50Au8+OCnvPmLkoVS?=
 =?us-ascii?Q?8STN0wMkvyAzz1cLptSeq9z5Q/LsGjxUs0VqRB7H2s4NTUf/YsiWEVEr+uw/?=
 =?us-ascii?Q?ICwKIR5vY4KwGtpoO3nydTLAwaDjUFYw4HrO+6oZhqo45HznZU89seNQNkhy?=
 =?us-ascii?Q?RZVQmgri9k+zAL1EJXeTPRuu3Ad8+bfwHvdk/ahEy5EVMA/r3TW8ktjXHo+r?=
 =?us-ascii?Q?HE1vo8bXas7wjGHikGgKlrRAUytUBgjFpKlxdM8/kQ/8C/DmKKDn7PWYIysd?=
 =?us-ascii?Q?ZeG4okko5vF4x1punGX0MxyWpUzOJ+gRMlxwc5/Dj8rqXbiReubgbtqwP8yI?=
 =?us-ascii?Q?e1efTj3VR1UN4uYoptTNzjltG158ehEvnfzobwtbO+Zlr7FQWbNSrtAsyQcP?=
 =?us-ascii?Q?jSCA1bF9WGMVhSvHuc06FB3Hhmz8pwyzVjEQ0QMgKXN/GKC+C9n2mpjyIcBz?=
 =?us-ascii?Q?+W3qi6N9iZRqQ8Ct0i12jSTprFvd4cNfifYwYuADoyuw4Nj9nkonzFHkS9jV?=
 =?us-ascii?Q?sfUWQBwG5J0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Es3L34HDU4WqbXDeexCQN3kO9QwI8bbGa9EB2l0FvxuuPYtbA4bRK4AcTW6+?=
 =?us-ascii?Q?bKAHzYE0mdcV8ozSoodS70+5gY0A4F/uwqKDNJajItTOzI0Fjc5ZpC7daecZ?=
 =?us-ascii?Q?sCmqJghT7vJQpzOOo2Z/zML6keZcmfLuBRNomLuBDO2Iv6B4SMvuzLocrPRw?=
 =?us-ascii?Q?JvBQjO49rX/F3jO5bs7rObbrdRnG/Ee7WWKmG1RaE1J/FCiIyeDjZcjezOHZ?=
 =?us-ascii?Q?OKxoq3XL986tGlkH2czv6MhnJ6WDdI3sDnwyrkOqNjWQgW/BJUGgztk/g9IL?=
 =?us-ascii?Q?ZDoIfXNQBmEOtpLl+hoQvwg1RxX3NhSMtPQCCb+VRsEwM/l10XNbn2bTAhdE?=
 =?us-ascii?Q?tWUSs04hQdAmaiz1a8q/hVJ0nWEx71oslv002FPJ95CXnT2jPfH0waIwOOzZ?=
 =?us-ascii?Q?u/LYPFXr2aJGJ7VSwys98cX6hE2pnLbsdBAx834Jqwoa3mKJj+vbPk2/LiON?=
 =?us-ascii?Q?3mPlFnubLSCUdJr/4aF4BQ0qWiw2sFatjv5cWRlM1GDMSYSfhvoXquabEfbV?=
 =?us-ascii?Q?kIbijfV5HJOMdmHY+UxIyHS9gmtyoaG3Csn30ulMyjzB68AdrM4+02FYGUo5?=
 =?us-ascii?Q?isQQ7KHMj0zKwL5UV1lJzij7d9Db0rIxCbwH/3pO1K+UYcVvMCjD6gsOcBGc?=
 =?us-ascii?Q?taLyqDkmy1a3KSjOFXx/pvbiH9nxN6nm5e0wCU2ikBu1FJ/zwXKsvzOc1tuI?=
 =?us-ascii?Q?ay3xWg0xtrO1GLA4nK4XeDL3/isM97MmT/pTqXvEZ7m50qoV5eQQeMpwfcW+?=
 =?us-ascii?Q?CcDxTcuntbF0HOsadhNwv0o6GERagjL8GVw9tjBDcXdZ9RvqqKZitXxds+Gt?=
 =?us-ascii?Q?fAO+q5oW0s7ezGj0gKap+RGWTj79LvGI8lVx34r0dFsLyl40yorAi+aWEaSY?=
 =?us-ascii?Q?2N9FB11QmuELyCevHamUonurBq0stBwnOnuqV6llkLUecbYjADyvmR90eP++?=
 =?us-ascii?Q?14RQi4tlJz3SsbR/7ohrXyzXRiE27wXSDFm9fP4fVrVqg7djKMf4KKjKmW1E?=
 =?us-ascii?Q?ZrH9+vA+UcvkpwAZzumqq2EMWcKjJDhZ3vjReXzlOz+zMbD3Mmn8gCjv60dC?=
 =?us-ascii?Q?tf9dRXJlmu/HbUGx0JVrJqRVleebQER5wQts4eOBxTc7uEFMXj+PmdYu3xgN?=
 =?us-ascii?Q?tehQgxyUfql/fuvZPWCXNj+4W6z1f7HBmAuANN/Hiobod+bYegzQpgxLTQLP?=
 =?us-ascii?Q?NS4aPbjHEUQpDNk8y8pQzDwIQ65DwR6lXIMIxHq92K/vUHob4Z8mfxqHSn/N?=
 =?us-ascii?Q?UdckZmFLswP0c3eQk6Xj9gkWYYBRNLWM3okI8AzyGYAxVaD6f9UOrlo5s7jG?=
 =?us-ascii?Q?aA+dHiLIpD5lSaXTqEQiZduBc/FPd6G0za0555zD1TtUEvEhl5cv97f+8NDM?=
 =?us-ascii?Q?0qWN5tZ6uYDBBzM3pSZ5f2C6xEgwxN213+bKkFVarqE8voVsK5+tEi7tN5n+?=
 =?us-ascii?Q?aKfPAkZw+cF/wBoc9NV4ZoDo8yg7b3CGREErJKXHotbAANzb13VYaeST+His?=
 =?us-ascii?Q?dZ1udOCcWwqn91UhjbqPFXP75yLs9/FbM2yiPQNUWNJGrkVg65g+87z6pyYB?=
 =?us-ascii?Q?z1Ygj1VwASiWb2auSS0vXX8+X3vyZEQsffNuEhirN56c8jJcKenjC34RN4Fz?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H2o+4nRv6AIRP2lT7oFAajpifioPfzwuIB+sv3BSgHCq67fmJVku1KhS2wCf5LxO8btMXwCF6sh3bragxMvSSdWaMcgQF9BU/BPqqUKLcqNUHd3TkzWITuOWHM+csUy+wQlRY+EBWGBsTKR0o2IIVq6Lr9fnzeLBgc20rbluhFoNAkJJpTBqWfcJkEqAEMMx0PIHNjAuCKNlBc6rMu7TVu5gCn4B/Jd+AOXfh+ndSgd+BymU576txKOkc1Du+zZ77eAFskI2uUrcGSb1z7YyFY/zFgPLtkDJ0skGFUgjHBUk1ta30qRk66tngLu78M2m2Hx48s+l2knxT+vJ95+2BIhJNTyaE44GbuTfYHV9LbWXTkFeMjARpImTUxcKko2X/JlFdy7XHSneo9Du7G/IJNDddBhZeNsY4thNRgqQ+lLLRXWdY1JUkOWq3JWoHmDphEPyGhYlBs+b91dMfajFSRxDQs1WU1r7JHqB9y9OJhFM7jw7XJlT9NdWEdRAZpmZLaM/ZanyFDCq5N8MDP7spPutcIS86yIoFLrIN7DDjyyGreedCGMUxeRJKdRP7lmzqwlJqNVVE/sYs1jYVlyNBH2qPukokSCpkdhECPQ4Rxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386f15c8-26d9-4314-0d46-08dde9666e11
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:47:09.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/Du1eRkPcGdYo4wVOg2hyUCsRyfIXEFz3BBoDIlIqwcVVPONDDWYTLTj9VZqAASM0dtkFDa51N2FtsiR8fCFHEDDoZ4u+iwYcMH4oJ1Yoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5l2ZHCOpuAZJ
 uvZew2SmrGNQiOnpPtGkfEhDQa+Qe/Hhu1qZqQmwoMS5t0JrJctuC3xBhSbKCpmTkBtOFhBxkTL
 NSZLfaoFXjBTQtgH3YmRGj5bKsmJZuqN1Gx1DYSwF8vEUVHZtLz4/+7L6awDapg1gZjeu0BCczz
 lB6PaqXZF9+FKKwLj/UKp2U0nWuFoccAMjihALE2IUCxhUujlIhEnxwkOB4GpQe9i5HihzYQMd8
 qg86FX7S6m5JVLIR8KhskalsRcM9hEEwCHESoDP26+7AZ+eLLgg9TFYG1EijUU3aALcM7UR5udh
 LXfHashsOrgiVX2YI+UkCA5Tl2Lco5gQ3T7GxOGVqBkDHjFjeGS29bTkc+ynjfjEUnNhhgRXWLM
 9hIRt23U
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b5b1f6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=R7ML32TYBnA5i74tcToA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-ORIG-GUID: AML1VPYGnUqt5FLEInchtU-CUkNo-y4U
X-Proofpoint-GUID: AML1VPYGnUqt5FLEInchtU-CUkNo-y4U

Not going to add too much noise as same points as David here :)

I'm still definitely leaning towards us not doing the double-const unless
thre's a good reason to or perhaps for larger functions.

But I'm open to being convinced otherwise :)

On Mon, Sep 01, 2025 at 03:54:25PM +0200, David Hildenbrand wrote:
> On 01.09.25 14:30, Max Kellermann wrote:
> > We select certain test functions which either invoke each other,
> > functions that are already const-ified, or no further functions.
> >
> > It is therefore relatively trivial to const-ify them, which
> > provides a basis for further const-ification further up the call
> > stack.
> >
> > (Even though seemingly unrelated, this also constifies the pointer
> > parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
> > the function exists in mm/util.c.)
> >
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>
> Also here, some getters hiding.
>
> > ---
> >   arch/s390/mm/mmap.c     |  2 +-
> >   include/linux/mm.h      |  6 +++---
> >   include/linux/pagemap.h |  2 +-
> >   mm/util.c               | 11 ++++++-----
> >   4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> > index 547104ccc22a..c0f619fb9ab3 100644
> > --- a/arch/s390/mm/mmap.c
> > +++ b/arch/s390/mm/mmap.c
> > @@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
> >   	return STACK_RND_MASK << PAGE_SHIFT;
> >   }
> > -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> > +static inline int mmap_is_legacy(const struct rlimit *const rlim_stack)
> >   {
> >   	if (current->personality & ADDR_COMPAT_LAYOUT)
> >   		return 1;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f70c6b4d5f80..23864c3519d6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
> >   static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
> >   #endif
> > -int vma_is_stack_for_current(struct vm_area_struct *vma);
> > +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>
> Should this also be *const ?
>
> >   /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
> >   #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
> > @@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
> >   int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
> >   int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> > -			struct task_struct *task, bool bypass_rlim);
> > +			const struct task_struct *task, bool bypass_rlim);
>
>
> Dito.
>
> >   struct kvec;
> >   struct page *get_dump_page(unsigned long addr, int *locked);
> > @@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
> >   	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
> >   /* mmap.c */
> > -extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> > +extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
> >   extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> >   extern void exit_mmap(struct mm_struct *);
> >   bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 1d35f9e1416e..968b58a97236 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -551,7 +551,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
> >   #endif
> >   }
> > -struct address_space *folio_mapping(struct folio *);
> > +struct address_space *folio_mapping(const struct folio *folio);
>
> And this one?
>
> --
> Cheers
>
> David / dhildenb
>

