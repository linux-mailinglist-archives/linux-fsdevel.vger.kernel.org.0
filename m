Return-Path: <linux-fsdevel+bounces-46692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF7A93CC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AE11B63933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856C224228;
	Fri, 18 Apr 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MY46du7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfTIYB0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAF221723;
	Fri, 18 Apr 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001071; cv=fail; b=JzUa7z6H+gsG7Z1vYiypGTpjHzsO72vQpqXjjV+cXKzq1db3qE0ENmjm6lY1/ZYU1jlsGirmml5pWEzB0rPVeA7ZXo5PDu8iYFVKYZMWkFQXFHdiupW61SffaSJRPDMmqJWUmVezAr/m02EEHG/RiIVo6QO1b8VaYEKCoQd0JJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001071; c=relaxed/simple;
	bh=Q0Nh3y+w7XFPzpiighGvnYeCN0tdmRCq65gp4rA4iQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSbIAzDPXgB5IrDXedjjr3txUKQ8qLNdz8PXJWAO0KRY+NFiqCxIXv9fzjNcdVdxDF4olEnocg7XnCLLqNMIllBSQpyWtyEm8N5qIDJudx+lGkK/MzeNRTNH12049nHTu2ZztI5Ld/ebZNZQzC9zEdws3Umc0xGbBaUGkIocsbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MY46du7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfTIYB0I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IHBfZw027572;
	Fri, 18 Apr 2025 18:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=24Uff8ZmVp4Jn7Xm3I
	jhmYekmVhrIbzllJHsIUxKW+0=; b=MY46du7h6P5eBiyfxecXkj9FwjamTn6dSA
	P3nHCiFhOuLe1hOhZJtQ59+EjmUnd73i0zGVzDY9yt3j2niwkOHqECtzvRIPKHH8
	mdig2zEtAqUshzUF2N8oBlIIZXcUyJDCpyJ2xGCW/8NXgXzLvzU+JmNJR/IjsIZQ
	mqJiuyaiW0UqvSxAPsSFuEh11gtTrFq3ZhYi2i+cg3UWdJVGiUqo2Kf1DfLoVwj4
	k9t/VoxCBk22dPKgX6xuSdo/a71LhbdAW0lBrwsEvXI73rLUfXN9ehX/L1nf1M0k
	fsN5i1V82csenDSckCzwqfaIcNUXwvRT6lnSSAD+z5EQ4woQbRqw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180wguyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 18:30:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53IHZu4B038813;
	Fri, 18 Apr 2025 18:30:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4w6wwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 18:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKqLAyYIz5BS04Uw9UQqjMVldxeCMIZx/7hMbaui58HImaUu+TBOlxHJxgTSZvqUF6frdgv7n65d6mSwkt7MNteta1UB/3lOBcXZSwDWsIKjrN0Mey0O/qifrrt6o14TZpXPE9Bz1NhTTeKw1zHaKwjAWgOxExMCk7//MwxWhvaCoGNbQc7kczi1h77foBVy4VT8u78Z6PEwQ8Vbrm2DFW3l+nulNAy4/oQo5XfFaEUmj5seyLp3S2NQ87BolAiolSS+LVKymCvbuRH4vT3MPIgHrWt8UBPq8kc9OsDreQ8WsI5c3ih0dciMJtFt7QhIYQmLmfUbRsSPZt3y5TQBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Uff8ZmVp4Jn7Xm3IjhmYekmVhrIbzllJHsIUxKW+0=;
 b=de4B/rs6bnAcz1Ug0tGPK3Qc7NXC2oeBiCy5kcxJvOZrAlm5Vv75TAkNw/4zA9y4N+voPvDThtzbRoTYAPL5fV3kB/zjic5Sg2k1ZSluNf0Xjyv1QLNWkkpeNIBn41Y6IDWUqLrrTxg5tqUIrUWgNEOlglyRZbwODAjlowjOTcrUh4cGTszC7gkIDbzES1c/X4l8x2Kgh9CTVHLzRaGwfg2/Ufk3PsrRZDQ+YzyDcPnnj0LrfNPCe9Dy8N/8dqj9bMEn/MxVVjyqtXck0QVOpOW16MiAGvuTrzW9Ch9HGQfj57nb3dlhweDbjCwcahLp+eksR0DQhLNa3UMRtDhL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Uff8ZmVp4Jn7Xm3IjhmYekmVhrIbzllJHsIUxKW+0=;
 b=RfTIYB0IMN9ysThyiSM8UzS1QZKPiPZqovJkf5NfRfHfKTFPrY29at6AvI9L9C7aYtrLiEcUMSpfdKSbe4yCC9rsrSEp3AOXTz8gtdR82Z36iAFMtBbxkMmO0CNrMHHeUIjy3xDtTwGYWLRq3dGEhtlnztiaQOTQVUOWz2f2qpQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 18:30:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.029; Fri, 18 Apr 2025
 18:30:30 +0000
Date: Fri, 18 Apr 2025 19:30:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] selftests/proc: extend /proc/pid/maps tearing
 test to include vma remapping
Message-ID: <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local>
References: <20250418174959.1431962-1-surenb@google.com>
 <20250418174959.1431962-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418174959.1431962-4-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 570bf10a-0e62-46cc-11e0-08dd7ea71924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOw2nHVdqDtLQI/Dj656iiF++3yl2EjfIZZGsCpwxwcRuA77myukVcm6F4wB?=
 =?us-ascii?Q?DQ/3HMzsMLC7UUF58/UjBgY31SUqqrsTeBjbnjDbCN2wtk4fWLTJR4g31PTQ?=
 =?us-ascii?Q?/SSmsTrai9gXhHJIAKfOsRk+YUIEC5tTK7cZyWmXQA1UV6cJLkFNKYUfSyuF?=
 =?us-ascii?Q?7tl8e4Bj9fZdxO5HJZo3ukHIDRXIsI31oIjUTkDYGfMsqayx3ydeznUo9YyT?=
 =?us-ascii?Q?tGVCkb2qMUO1k1sPk3jvMZnmWD79kSaDO0fQ9mnix+UCRA8Uo9n+hZYZT7At?=
 =?us-ascii?Q?9xhfpAPh2WFIRYEW2A+i9onktoyRhKCV1KxwgPcbxg5KqLQ8+bDxipubqQQh?=
 =?us-ascii?Q?w2bAIPfNou2PQS62NvOT/rr3AXUK4skgQAuvEQAH8na73OcnflMZaZsLR5oK?=
 =?us-ascii?Q?ZWJZnJtVsDVelBycO2NLIZbr+sJwbrP7mzXVBKWBm7cA3T3ss74e8rK6ESAv?=
 =?us-ascii?Q?Px8+pYQB0ZLqdNFCl9ZDsWGJaokAKOWDZTGdDQJCswgK6MrK4pCzLo/vrfMI?=
 =?us-ascii?Q?jZBuIt4Us8ZQJej38UJl3aWWpz50U2rMFV1cXbVjyQIxqHuPBf+yMApeYWFI?=
 =?us-ascii?Q?B4gr8BT9gOTzQhbYmJVVRiBYEyFafBVV1CjhO6dWFrbFOlgnoTweQc+ld685?=
 =?us-ascii?Q?/6gbkKC6dWeZCqOFA+Dzy4idxbUfvnYqWXHt39zh5SPQvi7F7R6OBLS05Hoc?=
 =?us-ascii?Q?sn49T5ZQNpy9Q483Rbo16AEboPSHtKqFlutyuA7dMdmIsxKssWe2wAcUsZz1?=
 =?us-ascii?Q?8H5bdVCvafzm42shmhdNiPgaBqArXgj2FI7jbDIvkVkqmoeU5IJojMpT+X4X?=
 =?us-ascii?Q?GIKPFYpJZFXlX2soGwR94ZYBmYsn96ppksQm2KxZf7lTDepfji/AvbDMMABy?=
 =?us-ascii?Q?TTB0PgL1R6dnFsJH1fmvMyjBZ/kkcJ/ktqNP9HkJA7QhA40SjVSvQa6y2PZr?=
 =?us-ascii?Q?pWdi68SCm87F3yZdxZq65Ru+9QJN4E2/DeGOtBF5Nk9WjsgmwiGjg9pc17EQ?=
 =?us-ascii?Q?tmd+1hGKPbSikDXshfuZl8v4cAQVwtE3Cy6W8xEkGGiimayDD4f9DHUjdHqG?=
 =?us-ascii?Q?LtSScv4kP/TvzDEnFb1QSmvm/2+gk5MRivuV/OTWJf7j7Os5a482J1UtH7rP?=
 =?us-ascii?Q?mQRmE7Zmb69mWQZMbky723UU3MDlEQhZbbuUhbkIE0W+K2aeNDgGXM7D0Vrf?=
 =?us-ascii?Q?n8VmCBUOQnXdiNNORP9NU03V+Ub9u2B7Ek9g+aOZNl+TzCQZMgOSeUaGBm4K?=
 =?us-ascii?Q?sio7aRWPa3unNprs5INqHKt84xBJEwIUqUzEKs/tRel+L6crpX+XFgamVw0t?=
 =?us-ascii?Q?DHcYGkT7SUwLJRD0bUZSnXoBk7S5EVPWxiRSbnQicum9sV/b6N1/NkTr5GvZ?=
 =?us-ascii?Q?6TKB2nxRijhANZ1B2w0HsDWdHIOlqABjc0iga0jLhNFbYMwiDQdrl+p36MAA?=
 =?us-ascii?Q?muJijCH1k8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNzck6BkFSnfkKCmN0dU25Y1C3bRscv/lSBcDJPQasFuLKbiCsLZmyu2i7bk?=
 =?us-ascii?Q?VsVyYAEr4HkHIC2oRO/63LsBO+UGuwRbtox9uZajw87XA5gT8nbk/RDxXTct?=
 =?us-ascii?Q?ogIm8rK418OOcoEd9y/b+NvBEctT5ubyc+qT1498exjP0G7EXvsomNtoSy5L?=
 =?us-ascii?Q?tmIWDnLH0tzqatcOYJqZ6Eec3VssGky8IK7nzoNy6UrBEknSEHpgDbYZbFpX?=
 =?us-ascii?Q?8XkyhTx5RGMiPol7UkkdW9oapfcFYjnhlzfu4MGKptU+wZAyYlmJH99cRQh/?=
 =?us-ascii?Q?hha08u7hdcRVYM8X5LUWpdhi/NirII3tAR+l380gD5XHFEISrl8VWMBbfAhT?=
 =?us-ascii?Q?4gj/PQJQuK9Ogt+r+OHD7W880CLAkmP0Lp2OkEhtArV2ojcsRGwsP4FX7jIy?=
 =?us-ascii?Q?kOnbgZemZITZEtFAR0VHI4mJZwpeP6QGcv2QUMqvlqxbTm/KhCZC25CnqpdT?=
 =?us-ascii?Q?E63QT3IBIZoqp1a74KCIvCyRXf5qkSF7qT4EdincVjkBn5caFkZxo4erE0T+?=
 =?us-ascii?Q?nwZvOJKzoUFAaNOztnBS1SvNlKVfUiPdLzKcviFtnbMNAgXI/NF6wMSK5v/e?=
 =?us-ascii?Q?v0ZnpsOggHDZIGHWN+BCDHP566i2fp070WD/NJrr2V9QRumAJc9zZhT0qT9T?=
 =?us-ascii?Q?Dt+IZpTUCU7LM3pQUB8rrwmdWUOUzkIndSBYRZ0ntLDg0hUT0vRHDToVicQN?=
 =?us-ascii?Q?krLdlMgj0VXQeX9H0tBJ8Bi5ia4HxtjN53mQaPJ01OHY1TWFpW2yj7Ml2PYn?=
 =?us-ascii?Q?PCEU9E9k3E95O83ay5li1EfkfM5WKWJIXTFHvGFegggm0+Yd3twUHHS6oE1w?=
 =?us-ascii?Q?6B82N7bGJ+Sei/z0/kzkPp5oGEJPSzOt/o5ihZTkJ3dyFUR8IMa8fj8CjvUk?=
 =?us-ascii?Q?aGGEK4ydb02xEGvwKlKgIa9cjLXNy5o58JSq7Tmyh5mfi/A6oWBepSFwe5iS?=
 =?us-ascii?Q?p/mG2i6+DbJ4ror4JiMu+IaZ549wWqwt5BRqK3eie3JD96ygMoVCGkye/4KA?=
 =?us-ascii?Q?iOHW0xlkYrIqa7j4i8yg7e6XPeR8JxNjNOpn1SZd9dx3tldXKbBZfls4blFV?=
 =?us-ascii?Q?g/Zaho8XUFixzD3PyNpu+sYOqUmz/zXPzFchUXWrFk1NuLjMfE2m2oarI8cW?=
 =?us-ascii?Q?nlzHh1LgXBWDuVyrUIRDieSTbgyxeSESLYDLxN7dk577+W3VT7N9P/xrUlks?=
 =?us-ascii?Q?q4sVaNPfKkjrMzXLrBSErESATSgBWKMOwJDrMbbnJUoDSb6k6H85bSfjml1T?=
 =?us-ascii?Q?mcFZptNCOd54oI0XR/CSkRmF209DAXSj9gQO5yccP93O6efw9tZaUrBUJiEU?=
 =?us-ascii?Q?kmDAwadeX2dsv238OuAIOAZvQnVcVXFBy1W0JWKUGJiTiV4AeZWJZSoKr6W0?=
 =?us-ascii?Q?ZB7fiMfuaZ5y7UnW70j/n0+uGLxfr1nSoJoiek9qAvf0WmWckG1YQHiHvdpA?=
 =?us-ascii?Q?AAiEuhFLNfJIPCofjXNNlt1TqpLEn7OWFScKcPEwujlS6egyT+b7Vzs0BUos?=
 =?us-ascii?Q?453R47uh+vDRX4U3XLja/FYh8YTBsceuDC/NxHPHxe99D7mraNpk5oA/AWUf?=
 =?us-ascii?Q?+1zs3Hmn29se/8zWr7yh24Jh7W7JUMioA/8ifn5z0hhfnJRP5Vr3YNCB8C0j?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TXnDmGAON/tHbWcBOlvBPqYI//X3YvxKORAuKPmJ0IfiXFNdWTKeutB84NzRLu8WUhMpDS/5qzitZ81GWC+wUKb2xNRyW5d98qzCbez3aqc9wz/9kIvQsni0prOXahsUatn16edH6g3rbeK55kIGNZGShaz+6lg3oLjYdekm2Yw5d6wD33a9WV4q3QdIXQLHNu1I1ztNlXDVtcOSvRU4PTb9rJQcxqR2wWIr0WqlwTUzSjSIIEZm6myEttvnpbWPwyfpuTme4mvvNxxqoORuecJfbyKaOnpODQnjAfx2cIiZ8kfJzAweFiEfEn7fhu9RBw0tiW4x9bleAUTHQbON2x5+iNtnJzCWdQSUbcYHk57bHWk9XYHDFDYBLP0Qv0rqQcSAoqwZZdGozMVdsXptcsyDfqcFlAkKIEvDmxDrTa+es2M9+PkuSO614COmwrBof399esVR46t/BLJ5SE6pu00UoCIynxAYn3W9+Cbwhgv6aq1dudvoBjrRliMLjcWjVDGIarZvsfhmdMkMN59iUr7qqVTyAgPG8sZz2iULXDVW68wI1qtncblpq3rHYPxdOLIbKO53viQFGce7tJUV5iC7kOphOPCHMp0KYudLPZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570bf10a-0e62-46cc-11e0-08dd7ea71924
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 18:30:30.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIfBlCUwLL7ZKikj5DLtuuEF84DNZMg+25iOPeMRlKGgTsTeMpaqR3lnfPulR4zRqlk8teM11fNVW/eLLRYfCLSCb7SzdslpFvuG2ZyMSq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504180139
X-Proofpoint-ORIG-GUID: D41ZTYueftVd9ZFqlip9HbnAOpDJI-8r
X-Proofpoint-GUID: D41ZTYueftVd9ZFqlip9HbnAOpDJI-8r

On Fri, Apr 18, 2025 at 10:49:54AM -0700, Suren Baghdasaryan wrote:
> Test that /proc/pid/maps does not report unexpected holes in the address
> space when we concurrently remap a part of a vma into the middle of
> another vma. This remapping results in the destination vma being split
> into three parts and the part in the middle being patched back from,
> all done concurrently from under the reader. We should always see either
> original vma or the split one with no holes.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Umm, but we haven't fixed this in the mremap code right? :) So isn't this test
failing right now? :P

My understanding from meeting was you'd drop this commit/mark it skipped
for now or something like this?

> ---
>  tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index 39842e4ec45f..1aef2db7e893 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
>  	signal_state(mod_info, TEST_DONE);
>  }
>
> +static inline void remap_vma(const struct vma_modifier_info *mod_info)
> +{
> +	/*
> +	 * Remap the last page of the next vma into the middle of the vma.
> +	 * This splits the current vma and the first and middle parts (the
> +	 * parts at lower addresses) become the last vma objserved in the
> +	 * first page and the first vma observed in the last page.
> +	 */
> +	assert(mremap(mod_info->next_addr + page_size * 2, page_size,
> +		      page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
> +		      mod_info->addr + page_size) != MAP_FAILED);
> +}
> +
> +static inline void patch_vma(const struct vma_modifier_info *mod_info)
> +{
> +	assert(!mprotect(mod_info->addr + page_size, page_size,
> +			 mod_info->prot));
> +}
> +
> +static inline void check_remap_result(struct line_content *mod_last_line,
> +				      struct line_content *mod_first_line,
> +				      struct line_content *restored_last_line,
> +				      struct line_content *restored_first_line)
> +{
> +	/* Make sure vmas at the boundaries are changing */
> +	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
> +	assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
> +}
> +
> +static void test_maps_tearing_from_remap(int maps_fd,
> +				struct vma_modifier_info *mod_info,
> +				struct page_content *page1,
> +				struct page_content *page2,
> +				struct line_content *last_line,
> +				struct line_content *first_line)
> +{
> +	struct line_content remapped_last_line;
> +	struct line_content remapped_first_line;
> +	struct line_content restored_last_line;
> +	struct line_content restored_first_line;
> +
> +	wait_for_state(mod_info, SETUP_READY);
> +
> +	/* re-read the file to avoid using stale data from previous test */
> +	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
> +
> +	mod_info->vma_modify = remap_vma;
> +	mod_info->vma_restore = patch_vma;
> +	mod_info->vma_mod_check = check_remap_result;
> +
> +	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
> +			    &remapped_last_line, &remapped_first_line,
> +			    &restored_last_line, &restored_first_line);
> +
> +	/* Now start concurrent modifications for test_duration_sec */
> +	signal_state(mod_info, TEST_READY);
> +
> +	struct line_content new_last_line;
> +	struct line_content new_first_line;
> +	struct timespec start_ts, end_ts;
> +
> +	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> +	do {
> +		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
> +
> +		/* Check if we read vmas after remapping it */
> +		if (!strcmp(new_last_line.text, remapped_last_line.text)) {
> +			/*
> +			 * The vmas should be consistent with remap results,
> +			 * however if the vma was concurrently restored, it
> +			 * can be reported twice (first as split one, then
> +			 * as restored one) because we found it as the next vma
> +			 * again. In that case new first line will be the same
> +			 * as the last restored line.
> +			 */
> +			assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
> +			       !strcmp(new_first_line.text, restored_last_line.text));
> +		} else {
> +			/* The vmas should be consistent with the original/resored state */
> +			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
> +			       !strcmp(new_first_line.text, restored_first_line.text));
> +		}
> +		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> +	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
> +
> +	/* Signal the modifyer thread to stop and wait until it exits */
> +	signal_state(mod_info, TEST_DONE);
> +}
> +
>  static int test_maps_tearing(void)
>  {
>  	struct vma_modifier_info *mod_info;
> @@ -757,6 +846,9 @@ static int test_maps_tearing(void)
>  	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
>  				      &last_line, &first_line);
>
> +	test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
> +				     &last_line, &first_line);
> +
>  	stop_vma_modifier(mod_info);
>
>  	free(page2.data);
> --
> 2.49.0.805.g082f7c87e0-goog
>

