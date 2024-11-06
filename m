Return-Path: <linux-fsdevel+bounces-33803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C839BF116
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC80A281729
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A552010F3;
	Wed,  6 Nov 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebJ+UmQk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UWTvnlUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9030537FF;
	Wed,  6 Nov 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905433; cv=fail; b=P7FHMceqO+qF9f5FI/98HEO3bg+6DSsxOI69KLZVxQUGRQ67lmKfGWWJHK3TzBGznIELVva1pim4p3VKXLwtd4Md9va2RyGut4CDgxCvHur8z5/cI+FVPXTRrWDdJsYAyuWeTNDxszdSMkW6WHFur8IJVVLxmooBn7UejztX+eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905433; c=relaxed/simple;
	bh=9+cp0DaN4NWBnPFsk5LiMCH/To8eRQBExW5FlncRiEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMecV8aghZoigCqzw6tVywj9xrHLrnkkMM+s6THy5sgTkrv8zow0vsoO6pZEpIsOK5r/IsEzVXrlZdgjtoYzAL7uDItF5m31wl+Y0pFcwybPSln9362pBrQlCxsyyVqmRBv0J2ZB6f7VUiuBm49Mex8HKS5PZHLs/edmUGKdieo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebJ+UmQk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UWTvnlUu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CiGhv019132;
	Wed, 6 Nov 2024 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=iD0Kb1YMwepQa7ngRp
	1rwS9UgEpN4edkvz7o/NFEl1A=; b=ebJ+UmQku9ILrzpGnsfej1YhBrtobaRQSS
	YMKJPTuQ6Jaln+XlAWzm2vwerNack+gsju+5UNAxBnuEQEIVw58ZbEjBGZoWEuv2
	Arq6hG5K+qLnLqhlaVKVk6l0JXv2pLRZIKRM6IZPE5JTuPToGMv3JasD6coNyhIX
	UBvAL0DeD6Y2nVknu24ydaJfBjVK/2PNhROTc54qwIFScO8fKrFNrVOuuLJT0/ys
	jt6SfNSNGrrTQ2Tvxh79yOe5EInSf8Qifi4x4yCko4Fwjy4vjVN9hvLI8VlYgmkR
	fPl7xLgK4LV10U0qVx7ubAd30+/VdxUOu7HLUxoKJdzR7yi+/+dw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap002g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:02:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6DxHAN008460;
	Wed, 6 Nov 2024 15:02:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8mrkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM8tOfXSDLBgcO92rYkzo2ECfpVvuw5vKX1RFFbAmWojvvdKZh1ZqFweBVuWL1kTqbQhJhGYMzyGBB3r5G3klU+WfCiHGOLDHwz7B+otuzB2MX3oWpJmJNn1k4J2Y92SagaSfnGm557zLQPTR1/3cP0JzYF6ux+rhFcMQjVZiioVenbO2GfugZkzTULHVyXcUZ+mXTz4XmOykarbSYs/uVxGw6rU+sZuHULd50Thm/2OTY4bVJps069ips056ibtKLGe26l/g8zdoyGgfQ/ySckUTlbFfym3yooYpf83aEGjBJKekIo5AclT+QGuiJgUGDr/M05Peq46Iaf/U+OPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD0Kb1YMwepQa7ngRp1rwS9UgEpN4edkvz7o/NFEl1A=;
 b=NDkIHwCW9GcDNtBy4gM1hIyPGycL/+hrwycln07dlMMq/6k5w46iNZk6T9utsdKZC73NwFvcq0/5GCVarbPnayIS5j9fAQZp1lvQwlGaykmLDxNHBkUshD/rlxd1aoIv4Y6hi9Xbmt3m1xtEdexmApEwMwmbhxC2G9FbJuD4KoVcG3OO2btOXRn11lNO5Y6QRNGIWgXO08QzFrOX/cNHoNqhC4jSXHO6yC6bwDU69TqdgUdmATeeqsvk3tRi/bkmyds+LhPtDKeq0R97A7l71DkgdbmVBMdnolgmhleEG6M/od+a6RzNjwIfODnfIQY+zye0jXeRq2YCzFVTHmu4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD0Kb1YMwepQa7ngRp1rwS9UgEpN4edkvz7o/NFEl1A=;
 b=UWTvnlUuEeFBoULrrtXDhjpURJ+j9WpxkKdKd5/TY5mUhMS49u5/Lvz2Hy92bq85e2wNaKBLGxf8QNWH5xn8WfJcqdy3t1YBsWEWg8ZFENgza8DoKHCJVUVMkV5uWPraWiZHhPDzF53pM2aTwUwZ93FLBN//3NGpKyPaIGTby50=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 15:02:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:02:16 +0000
Date: Wed, 6 Nov 2024 15:02:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, brauner@kernel.org, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        sashal@kernel.org, srinivasan.shanmugam@amd.com,
        chiahsuan.chung@amd.com, mingo@kernel.org, mgorman@techsingularity.net,
        yukuai3@huawei.com, chengming.zhou@linux.dev,
        zhangpeng.00@bytedance.com, chuck.lever@oracle.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 6.6 28/28] maple_tree: correct tree corruption on
 spanning store
Message-ID: <7740a098-fe11-48f1-a693-df81ef769f08@lucifer.local>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <20241024132225.2271667-1-yukuai1@huaweicloud.com>
 <20241024132225.2271667-13-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024132225.2271667-13-yukuai1@huaweicloud.com>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0490340b-8b1e-42d4-6bc0-08dcfe7400da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrw+QLMa6kdiAuQeE4QruZvbPo8Y1+iWokFVjnULptzQDwHOVRTuciTwDPRp?=
 =?us-ascii?Q?yj4N4Dh4WoNkcJEB/2m8vSHibjSukNsu0IcCGwkwP5WAbzfXCZ3mYUlkgdw9?=
 =?us-ascii?Q?Lbz3S94QuxMEymB/EbMm/GAKIz9R58FPzZAmh/HQi4TlpRkHdPppvtZHToZG?=
 =?us-ascii?Q?OEthoFBmZxXbwQTWsjfqmLZ6UWSnSoJ9biE7LT450meStJ1/NKp0gHDuM7UW?=
 =?us-ascii?Q?T9IuosMSlg6YX1bpuGGNXTXFcIvzNLHodHrB7n494gmu5yIWoRmd1mLM0uju?=
 =?us-ascii?Q?CFU/lAkfv9bHIzYWJb+Xlb010RflhMnl38GvYbQRtCrIMkvFytL05JEd7n2G?=
 =?us-ascii?Q?OrkW1wdvbVAAQ7UxD8w0NicVgW4qOORDowI8afXaUi2j9uQK3JDjK3niFvdr?=
 =?us-ascii?Q?g/WmOTZFcieN55Q4I9ImDV7tZBke5l20r2BYIUaUqAGB4epPDfzZ3TaWU29t?=
 =?us-ascii?Q?xDdpCaqmThH7QnpT/fVydOX0VUE8Q/FY+QrKY/DqWy4/x/OsKfjRTJrY3KhA?=
 =?us-ascii?Q?L20ZqcPxAYON8Q6aFdAAWVkSzDGBlElEd72xJM74n9xn1Dzo7//W34qzY/l+?=
 =?us-ascii?Q?DzUrHmPq1XQ9r0tCZlNKfu1P6NjvRwqb3pFZfRvggvPifj5Y+QX5X65YX12K?=
 =?us-ascii?Q?0V5SRs1fk0rBKwpv60UVxhWhiP9D1r0sLyq5lkQiowdBtxy1OOO0uDRg0WSn?=
 =?us-ascii?Q?1nX0nw+PApHn9RXLRHqjCLycbGP9SnpQIUtNqrE/Vrd6KtUAPweKvlcgLLEr?=
 =?us-ascii?Q?xSRX7ut2rHjVFToU5Rs6lVwDy39J8glNWQ9endEfv+RMV4xWcy29qdIgcbAB?=
 =?us-ascii?Q?djdjPD3HkIHn84GSzwo9Cnti2Gu9/nV2kZDhO3VzuBCaYY66jvZ6mtBeqlYc?=
 =?us-ascii?Q?xqa/dJga1koU+goGFTIbeDkq8xpT+yKyAuTqHMbufFLrr4eerfENqBObWWLP?=
 =?us-ascii?Q?QzdFlKexuxHU4zu45o5KPjKHW8LqLHfNU/P/5J7guaK6pnkevo1QmznmS7my?=
 =?us-ascii?Q?RTCfj9nqS2X6VFvAs9v1A05nN3sKPFgPjGYkGPR82TIC+nN7KcGzKtWmGxa8?=
 =?us-ascii?Q?QpD5/rdaYlMB1B7FPzmHjJN+k36MTgXEKBwxpQ7WiNVV64YUqhrS/b9hGXeg?=
 =?us-ascii?Q?uZVvInZGtK+j8eXXmIiT0i4CFT5QKfU6MlzJN/uJH5453VpbgURuHubz70nF?=
 =?us-ascii?Q?DWdPdol61EA2nOg1RX03AMgNavAjoaGDb1zYz/HAesg/RoEs0UYqPz4YHiEO?=
 =?us-ascii?Q?h4udtFK8vchTwH0hEWfCRCG410skUUv8XtYyvVXn870B3IblksDkAgkoJ2Wa?=
 =?us-ascii?Q?Z2KxPRRl4FcTINDK9gw+sucq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEqSMNIh3LGbUj+F1fFNcKsjl0TpSKacAP2cQnfoQTGNoqOZtE2/Vb+FuUDk?=
 =?us-ascii?Q?wJF/qjr3CdbFeZvC3d6Yfuj8lshBKLncCJjfixyRarwhfnyZJHAtT/qRrcPN?=
 =?us-ascii?Q?ZKpqwfbwQcK2ozfFojvr372NsFrNbUvK3S69cDHTdWyw3gCc4croebmQpaeH?=
 =?us-ascii?Q?DlVn8QZyHDHL6zQe2V/HBGK5sICkyxlzKwwl+VlXZRp/sKrhrTLidbEOJkHh?=
 =?us-ascii?Q?Kh0lMTkGF3CK/KT+i9lLKJOwc+gVgdq1x+2gayuyKD1HRhiN4YOrXEOyMPGH?=
 =?us-ascii?Q?mmPxsccFNCjtb9TkDeWKO7/WILHfi92NgzlBafNxFcJH0vFF2zbcwbmr6Vb0?=
 =?us-ascii?Q?wDdlRgUHScqlpB2qaNqepq4HCy3dTqs3a7qeqmdH8bmFI1c0610ku6/tEdaI?=
 =?us-ascii?Q?IT9Szekmw//yd0AG3u+65MrV/FySlZBGR8arWq5PHfbjxFpWmfF9dMGJQZqJ?=
 =?us-ascii?Q?RfoaP36t201bpeugt6LIjtktih5UBAOGGLqCQT2nvfD4W8mN8bd65LKnt2KT?=
 =?us-ascii?Q?//Tg11oW3iH6qWEbxoIiSdapeFVU+bVpz17n/y4mzI0IQ2J4z3lX0Go9HJCz?=
 =?us-ascii?Q?adevKZxNnRwLCbpntHZ+DYoZL7Ozf5R0DqpoeZ4djSuE3QlanjWukR/gvL9S?=
 =?us-ascii?Q?BmTZl8f1sLrlfD7p4Sn6ovU+M+iK6BVQTcLw0RXoHTwVe75Q6wmmHADuj6ov?=
 =?us-ascii?Q?qr8RugFHTN0h4Xgkr2vHw6IXFWwKD4XFw/9uK/k4hedjV8W1sU4FsP8l0bkR?=
 =?us-ascii?Q?C5mYsvk5pG4FAaL+ocSnetXeYNPYR/CfkXcjS5B8dzGyEI8+2QlL/Qb5IFBC?=
 =?us-ascii?Q?n5xSvUnduWN9RPZNUfTHfzFRt2kZjOYYQGs82/qDuZCO2JZtDmxzu+TdPGuX?=
 =?us-ascii?Q?G9QJztft8znD3/QMjjxbulaL80RVpAfvgmiP3uxtIdifr8wDzeKE8oyEL42U?=
 =?us-ascii?Q?T2v1lhn4OcT7WteKyP6T0p1nJWKu74xU4lEhbK72d2/e9VzweneK7M3nke+o?=
 =?us-ascii?Q?IYNS/ZqeePuqjelnaLYD46tT+m5qsdizhnK7Fb0BbKniZwGjqt14Uuy3M4ld?=
 =?us-ascii?Q?I+DgOUFzkF2kFfAH1f69JoxLWF/ZqAyMxQH0eHA0VGnZNPZLOulDhyo24cwF?=
 =?us-ascii?Q?9+R4YHJiPHMj6zqTgNEzTaBsKEOI89A8YjXMS0ctC6lwZ/BCohEdB2Q2k6gw?=
 =?us-ascii?Q?vtMiMZpAPawr39wy4uScw0NJjBHxmbIa1KxJJrEVHj25H2hXj25QNLwhImz5?=
 =?us-ascii?Q?ja8TKC4vEvKwSCVdkRuhEYH+2k2NdLgflRi0YrSpth/MAr/G7ChAAXJa9yg5?=
 =?us-ascii?Q?LITpPaaYbPLqxZW0CAg4I/ek4YEJdyTlJUryodJYLa2sWOxsTJtgPL5Lm4xA?=
 =?us-ascii?Q?cCI0J7+oaYg3Aa4M/0MUzTiRSYlTwUngzHNQschpTuxJRorJjvMlhdJew/3p?=
 =?us-ascii?Q?kX26d3XF7crUBKfB5OzyyXnx/mSzbNhfBP4Nj7weic2LjGDYbk19mVL8enDU?=
 =?us-ascii?Q?tLZ78auADK0xJUtD0nuz/aetqBAstdk50ov4Ureh0JYDsyaPyXL+9CqwKrFB?=
 =?us-ascii?Q?TgJ7HlAkgcNfIobJrQMZkx73bQsOEFm+lnjiA7fBKEExTa6PrrYgOj1vPgu1?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xa1/QCR91n3+oT0ITYCTp6+5TEHb5OEijcPGWuLdfxsLeN7c1OPjD4hxxj3LsL39cOnOIOX7I0xU1bfys24LZc4U3SU8caxdOR6u4iJhOYHQ+POt70u0GyCwens8I0GnuD+vuGLVMhh5Q/n8pb0u7nvJM/rD9m1VTrc0eGVA7mzpY5Lsc9pIu8xLGaLfIs/DwHwkNm05hCqkqhST2BjDaOYKeARu3Tx+AkoHRrxa+uuvDZqfSYf6VRMZxqcCvXZQv34hHxr1FGyE1HsVIZ4VRUvu57OZuYLkJH+zh3xnJeBrpdI0Z9OwZZETkMZWNA2J5TWB5qUuCh0njt6YNmF4uMqNuaZiIolG3B71TW2Il5//fwwXjQ0fPjAtTYriA7emzOnmGrmn3j2EWe2jXosYOWOb27NueeLBSjHY4GWAq0/l6sD6EjYW8tnH1CNvC52VrvMukJ57tSBOEqn3WDRJ6Yqug3j60BclNYCNXLzJjLFXJhW9k01UE64+qroa2DKk1jKJS8yDGgN0HygYSH8GmeeurVNTvgaD/OrzptxRxbRBpQzMslIaTQ69pPssRf+mrF7jgr5Sn2ruE9fMFqYcIjnVbZ1EhCY7Mv80ziVzs60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0490340b-8b1e-42d4-6bc0-08dcfe7400da
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:02:16.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDLtNLr9ZMP8xjoN4gzkRGY7XWoCEIChKtiQNf1fUpAnwZDML/7zHFW5AHwPKcEQa3U3zQhm9oIhv2oF3sKQR/kRXOnqcmS7/oyg8jWW9uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_08,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060117
X-Proofpoint-ORIG-GUID: gjIOlAxRPC6nbCVqChdAYPANRUeDdALA
X-Proofpoint-GUID: gjIOlAxRPC6nbCVqChdAYPANRUeDdALA

On Thu, Oct 24, 2024 at 09:22:25PM +0800, Yu Kuai wrote:

> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 5328e08723d7..c57b6fc4db2e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2239,6 +2239,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
>
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
> + *                      If @mas->index cannot be found within the containing
> + *                      node, we traverse to the last entry in the node.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3655,7 +3657,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  	return true;
>  }
>
> -static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> +static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>
> @@ -3664,11 +3666,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
>  						  mas->offset);
>  		if (ma_is_leaf(wr_mas->type))
> -			return true;
> +			return;
>  		mas_wr_walk_traverse(wr_mas);
> -
>  	}
> -	return true;
>  }
>  /*
>   * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
> @@ -3899,8 +3899,8 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	memset(&b_node, 0, sizeof(struct maple_big_node));
>  	/* Copy l_mas and store the value in b_node. */
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> -	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <= r_mas.end)
> +	/* Copy r_mas into b_node if there is anything to copy. */
> +	if (r_mas.max > r_mas.last)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);
>  	else
> --
> 2.39.2
>

This is a good example of where you've gone horribly wrong, this relies on
31c532a8af57 ("maple_tree: add end of node tracking to the maple state") which
is not in 6.6.

You reverted (!!) my backported patch for this that _does not require this_
only to pull in 31c532a8af57 in order to apply the upstream version of my
fix over that.

This is totally unnecessary and I can't see why _on earth_ you would need
31c532a8af57.

You need to correctly identify what patches need to be backported and _fix
merge conflicts_ accordingly, like I did with the patch that you decided to
revert.

In the kernel it is absolutely unacceptable to arbitrarily backport huge
amounts of patches you don't understand in order to avoid merge conflicts,
you may be breaking all kinds of things without realising.

You have to find the _minimal_ change and _fix merge conflicts_.

Stable is not a playground, it's what millions (billions?) of kernels rely
upon.

In any case, I think Liam's reply suggests that we should be looking at
maybe 1 thing to backport? If we even need to?

Please in future be more cautious, and if you are unsure how to proceed,
cc- the relevant maintainers (+ all authors of patches you intend to
backport/revert) in an RFC. Thanks.

