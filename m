Return-Path: <linux-fsdevel+bounces-51593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC402AD90C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DFA1E3814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C31DF751;
	Fri, 13 Jun 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lu9BfuvU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JM+J3QRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C25149DE8;
	Fri, 13 Jun 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827244; cv=fail; b=amU5D+wtBBhlEz9XNwKEyd3n61crRgV0Gh6Rc9yOek68sDlQW3HXGG/ZTyvpQ+GQ6S9U34+49e7zbm4VxMkaUivHFiy3WNapLFGJ2Yad4O6gTICJc8WeLuoGM3Y4GUVR4iTVyi2jZMA/3ywYDsdZPnlMFPhvDmfziEYRExC/oaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827244; c=relaxed/simple;
	bh=fdPGiZy0KJebfma2LKm11ekdkKGrWTzX0ahOY/x6MmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqiAyg9u5mhklnV1zwFo0rmkCIQFY5h0m3nVVK6koh6TItAV6Jfo6/Lp0epqrVBiIwGmtCQ5C1Dci2xzorCUjo1ujsB1Wg0uJx8EVZBMyN/dFb+ne0D0h1lbs+2ZgbUnvEeomJZBZs6+gLNffjkSE8iW8iVu+CXzOPsZcYDOSws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lu9BfuvU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JM+J3QRG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtZXC009418;
	Fri, 13 Jun 2025 15:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uYUN5BvXpHTCXle2er
	92WkskC3mOPfvte/V4fWarjmI=; b=lu9BfuvUCg0W7+lZdYpuJRXc6zcN8AKkFJ
	BQSlaAKR4Bowur4PkUUaNYWA1dLwVT4TwJYU4/kcfb5Krrz1aLyJgmPLJ818Ji2j
	aWs05Wj3AAFgoK00krNRNKRxGJTH/2DSkcnZw8UYS2oaYx7Ba+W3wf7ROUdrD0EG
	YLRUeLeIHpK0XGuAizO4lzKqC//B0XsfkFUgHw1vZHTYQkAPgmxRVGE7mK22V3Vn
	Q8vrQOdMLP84B0KKqc03UcbyX0jhqBhTM3y2dTRZo0ZOs9FSM9hLrPuTUAhnmfAk
	ggt5ah0OlvzQuOkcv9gvyOaD+a83iVCWZSODs3LAhYeHFU1FdvZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk370u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:01:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DDP2TV009127;
	Fri, 13 Jun 2025 15:01:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdqv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOfMlQwnVmuHrayWfcNQf/gu56DNpn6WWVX96u0wrP/dnEfNkHXK6IBzluY35bAGz6VPyRHQFQNerBUL0UK2Abtz8Ptm6P9V6HzF4BykWu3ZNerZRFcDNvtwrnDYPnfolUI8uT+ZsNbWL/LBWWTrReJfrlClnsyuvkmqHAc07bHM6Ma4yY2j6zDRplyYUeTJHbMlPVJdGl3CN3yZ4L4GaH/J7QqwprC6/mJErMCjjqsVywVlNV/xBuai5PrijfUe2uj6BUAwktJbi6q8I5abp7ltPBuggbbdlQFUlxq1T6wHDodnbt4WH8Bz5gPz8RSyyfSKLkJ9ZQ2DF5B5SZJgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYUN5BvXpHTCXle2er92WkskC3mOPfvte/V4fWarjmI=;
 b=kPVEZhcRmAEgibGyP9W4JdMCVbEPGeOuzcdXESIy41QGI8WPJjEtd2YGYZM4FlffCw6nIsmtAOAKm+QYn0ceTqCdNAXe7Nc5u4CP2BDxPbCOjB15b6jfLh/87n6AHjhcDRHzMcrkc+LjIrFXp/DdArom8kPjJUXPOf0Tis86d0fkHNdXJ/3vG7WInFjIBQvE6wbXEhNgVBwAf8fDioAFAtz4WLEgdepk0e6IMtkOLk4bTXvzjNkjUJogtTw+Afc46h1rziGi2P8RoHUGZXDEh74QnwnIm6JecJ0k3N+SUgufvHP8hQHQL23fPrzZQEfwcqRfjtpu3YFBxJox71nCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYUN5BvXpHTCXle2er92WkskC3mOPfvte/V4fWarjmI=;
 b=JM+J3QRGGgnwf9Rsff7AjrRUVjULPrMF7A8/vQAHSklKbsvAcvERoz8I95QZj02SOg8vMSQblOKO0cbMY2caClbEnwIHME0kNwkwFJE5uGPzp0YDQMFc3NHIGGWbygBoZ8iHqMNlWFsiOESWtcugl2SqU6My4vJeKcv0lkiXk68=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7168.namprd10.prod.outlook.com (2603:10b6:208:3f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 15:01:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 15:01:42 +0000
Date: Fri, 13 Jun 2025 16:01:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] use per-vma locks for /proc/pid/maps reads and
 PROCMAP_QUERY
Message-ID: <e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local>
References: <20250604231151.799834-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0444.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3204fe-c35a-47b9-c80e-08ddaa8b348b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6xTir3ewvCDANsBg6ifzMf4n+Htvc48hFLvw6xTRXME054VpFMNyxRbHdF3?=
 =?us-ascii?Q?dvazg6ox6dQ5MpBHDQtaAyNXx4moH4H5XZ+/vX0oQZoEzyrDCCamiNJ9WUdV?=
 =?us-ascii?Q?dWKRpYqNERVDpxEXz4zEOCy5fhYyzbE7TCa1strt6PSbn9FL9EU+W+0jkOVT?=
 =?us-ascii?Q?1LCEfYtuDcvIOHx+PGdatM+r7i3g6HZ9DQd5MRM22JO/0NDSUcGGSd66gaER?=
 =?us-ascii?Q?5I4lXEhOIMpVBF+ZSarfOmSBk0huJ51BW7Fpp66Y8pziUolWqUja1gNDCker?=
 =?us-ascii?Q?l3AvMqjWaTIx2KwCW68SRPtozCj/b6QW0jD24OXIVt6djpn+kk6VasiEoUUh?=
 =?us-ascii?Q?2pO8U0HpDv6g5xtfMKMG2CMv7uj1vPz0xEJswJrB/fOFWK2XM0LwaZcg336t?=
 =?us-ascii?Q?7m7JSRhmB/KL2F54SeyMKFkyQj5j12XPLc1+Hw8rCOa9UuUzUetjIgQH1wh5?=
 =?us-ascii?Q?qreEh61SRdaCOcz10ZpioGd2IlN9x06Vzev+MZ87QFwjF37gdnYkgzsL5U5S?=
 =?us-ascii?Q?BTCgdU2sxKqF0cXF5TPfqC6qXnOQeVvWKIYWTIGA/kZanhPEnv2KpjRP5OK9?=
 =?us-ascii?Q?5/bG6/0q7yVBHg4vNrZTshcG32CsLTo7XkogrRaYNaZZtSkRzLduU1JQKZ3s?=
 =?us-ascii?Q?SL/ZSPe0z7kj7fOzAwOpQyGAHdYFKGoTVK6nk9N4Zj1sJzHyb9ee7mwTrO14?=
 =?us-ascii?Q?2pUfBmHqZ6LPyGCHUAIu4xVF3CH5qrOJUTkaiS3KSXi9/v3OGOZHjK7+A9Um?=
 =?us-ascii?Q?as2msKlBNUx8vZeaw1TU3FlEhhTpP5xdQyaje0Uepxzrp3cDZgonH0qM6R6f?=
 =?us-ascii?Q?i0Mv8yntDPCtppJH9ObVkOF4Rxy/+T4oVQBR5tvBtsXJOghElZwSFhAn7I9z?=
 =?us-ascii?Q?S9AVylEMTKDgJaMTfiEWx+0foIYs765L9v9P4ZQb1FY44/llfID2HVp43Np4?=
 =?us-ascii?Q?/zIQ0jmFCq0G8wbwpn5s38B/0tS0ifgKgTuiJnirELWnnDWMJTxGHyzxUdEW?=
 =?us-ascii?Q?nOdltKct8KxiKm2YnF8lpOfM3LCC7AfRYnxGU8u4f8UDucUFJSH0O7R6FO+0?=
 =?us-ascii?Q?GL7GRC79I2JkKhFVqxZ0z47F74lTe65eb9bRNlgwW8yu2TrEF1Hqp5wkweAE?=
 =?us-ascii?Q?JahnViuJ6eaaw2t9H520UGLm/GhG0tCQpuBDIf6UdXn56FRPOfH4nH0IfB4+?=
 =?us-ascii?Q?Mmh+6UBiZa4AWqOvtwB3sN2MfEwsOjSNrIscVPVY04Syet9OQEpcBoHNDYPm?=
 =?us-ascii?Q?duKRSBUh9wm5Yj8VpCcg+Ej9aqZ4ZEkqB76MbmL71Itp16/Ojpqn94SRGGGd?=
 =?us-ascii?Q?tAJAJgI3NjEsiXYqnu74sUK/xeDN3sX1HU1pHeD2scancvLVfU4MzMPl13HQ?=
 =?us-ascii?Q?XgaPJZ1ljLS3k4aixdy0BnaAtS3qKBhqql2aKov9unmIILHDRn8PYsABgM7C?=
 =?us-ascii?Q?exjRuMuqhC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oFe+oZ2VI/4G4J8B2h7JtdaQWnCYpmU3/7QjfDl2w2XLFTdDAfDWlfTA6esn?=
 =?us-ascii?Q?WHiL72KOWBD6Gq1ilyEyky5Dlj20waiGUaXtXLhZ9mPs9mTWnZN3XA5W/1e5?=
 =?us-ascii?Q?w+mDni1HoPE2DqC0dy4+T5Om6TjbqGffr2z7pB6NPFzuZGmYAdYiBiniF9SH?=
 =?us-ascii?Q?mxhTEX58XgTigyZ6TAWuTmRsyz8egYuUQhYD2NRkZWnD8+I2Ny9YUKlv+MwK?=
 =?us-ascii?Q?CGZYtAQF+HT5qalkUo5+9H2ZKfypUiB/08wbFIIDLsyxzxCveeDPGWvOrpRa?=
 =?us-ascii?Q?8cmCRl8jvyZAfi8o8felW2d/dOa0K230YZoeqi/Z5af+2mWzjj6rrxyB0vY4?=
 =?us-ascii?Q?GzZG+O7NrBiD11Q7aqhhbwdSfJj+MjJbojnJ50JirUSYgzvBXwoSo66Q0tHQ?=
 =?us-ascii?Q?SSE0GQUcQqvE3oEEts/RdeG/jF6ApvYk98jT6sYvIxXmKSkPNB5jqcawcptz?=
 =?us-ascii?Q?UfVn2x3ep8dD73p15txdYsxC3jLI7GU0h9Nk58CkWyjUMb8pyhVs75GfQRxh?=
 =?us-ascii?Q?GXUEHeAlrMmICa3fHtR0bvq24ev6x5biXvSSs1J6aAElLzd1Wk8rn1McEFYI?=
 =?us-ascii?Q?+AUeLJw327x65e/lF1hYATyIq1u3xaYcO9KuOCWr5ej450tZCfTJin0tMof+?=
 =?us-ascii?Q?13ntPLm5vOKeKOiBmhKaWd9CMM0LrTrX1thIY+Sr2oUARerhkFzEwvuzPRS0?=
 =?us-ascii?Q?IP89IOnp0TUNm0kVr1M/Kgv3Zh3VKcpMpqu0tAi+J/bq4lXuA2AdoDrmpwws?=
 =?us-ascii?Q?hdKeQn0US4g6rIxBQkmiPYyyKI/xCtODfgbXRd4rSYRo01eeqi8YGb1yD9rW?=
 =?us-ascii?Q?2Ru2Ys2sOnT2twICbnPk2WSbcyec7rQBNBwU9n4rc//QjXnHtcofqOoWk33J?=
 =?us-ascii?Q?6HF/64ll5gOttsi0YlukaOqWZ/NzojtPpgMKCh1KW0lKd/dylkryCUvWTfZC?=
 =?us-ascii?Q?UoufWieKqDuRaZqDdWhvAQT7gnhOeOSBzyq55g9Xn+ABx/MgaPAi27XPIZOJ?=
 =?us-ascii?Q?/VQS7lgfWS/H0YDkIDSO85BEZX7VS/cNlYQBKlaXbPDM49q5cwEVJBKkW6Rx?=
 =?us-ascii?Q?O6/g1BQpHQR9Iwt5L8p+L98S6vuqteGRX7vKJ1gCUKEhMWU4l/QNaIHVUIBO?=
 =?us-ascii?Q?6UdB5hjGiDWNxN8l8RE9ucptHRQ89C0Ek6Lx6qSr00mmbqAmiCfs8VH0AZHY?=
 =?us-ascii?Q?yWMstu4+0R1ONuFog+w/o3o90y+lH5uTrBzaaRFBCq07A/4z8mbZdJMYDY/s?=
 =?us-ascii?Q?YOVfpc8L2kDOwP8OXbERrW7JHWpsSZDhcqgDHCXNV7C9zHeDhvxNNnSbnv3O?=
 =?us-ascii?Q?tLmS7V0DTWmaXZwVaBN96i2VXp+KBRkdFVfgfUriuhHc6OGzLqtQAVokqTpj?=
 =?us-ascii?Q?iXtnaQB5mY4IZMAaglby2vcVI34V0o2+5BiIeH0u7kH9P3tS3R9VRrpQ7Nw+?=
 =?us-ascii?Q?1Pa925ewXZ0eyqQVQqs6O45q2L2+HO2z+zFV1C5stCAnjmO1FaP07JOJQ8MI?=
 =?us-ascii?Q?iP9O+NN0XDCzTYqUSyjq52IG0wF3yqy/T6tYumjua13NjKi7dOjAjziG45YV?=
 =?us-ascii?Q?Ls4Tgp5vlZ/ZzEpRMyGBu30oyUaFM/mxvXloGTIt1tmi9P7JFazX8RbzGWPq?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BmYlA+7NpsJNksQrC9r5+pGCfpkIgsFYHZS/gqyYpjNNE1Ax5yZQ3YW0kAcGcsuHLmzDBZ1Qn4P0+kA63NSd8cQ1Vdys7AKZ5NzsVLYgTVp1f3pXANBwrmElva729Se3PRph1XpMev8zlLo3cibplTOVYxcAeeRAxijtYzbfD9+WwYntgYrVFXbIDaWXOrRek9ExSVPodZY22deLtywfDKdLLNJzmEjeaCjyI3gi09JODHuEnTs/vsF0UT5OjKgtezBBRWiYW95OZTWqVOK0ZIUizCJR2dC4VMDllSolv2O7YvZ716/YHyxXFx7At6m6284LC3HFG0AlWi/ie0mvS24rVjtfhMwmU0b/x3rc2cW061ngsdFD32OpHpA5SY2NZPvD/KBa22n0lOfAAdQSBD5AO50uDQIM8huog2VjfvTI2xFVqyRQLL9rKN/rYld92uemLm30P45qFKZYVjHpbKXOGA7lhOYEjyMeH3iDJHoumyEH20jcXCN8OLl4VW/hWghBy9hOI0Nl6bTi+2mMcJu/eDd2bv6TI7ZuQNzxrHVQd9H2uyyzzla8/0hvzRHy7aLeKUFxOdXUwN3dJBEhiAeoCWTMIWaCANu6ICzyi6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3204fe-c35a-47b9-c80e-08ddaa8b348b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:01:41.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/bWTc7bzg6P95WuIA5Y0HG8vbcWbhAx3ZjSfipmYNpbfq2ixBHyAJ2oTNpuLW+pjdxRdROHJk00UK0l4TWBYbell+Bu6bttZWnyCO5cuSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=984 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130109
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684c3d59 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=BY1yGMaX3i0BXbB-MCoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEwOSBTYWx0ZWRfX1pwFoPsBdX81 SRDn4WoCEx6Ue+ojYOUaHiFITp7xePM1y1uNWNMrkP6XfBESwzjMYN+cnaO0qqCR3KOJ3nLVWV+ rNPhORsGw0+hovdayzs/k2hfYpL/lrFO52TLwjzxX8cGLunYnCtcU4GL9L6cte97TIVTroiRNU9
 SpZlx2ygKWiVPNb17fSIsh4EmI+dbebOpsupne9xnSMLCYxAuReJsIcpD/qMC5qHXofq89hh6NJ BWNtFFLdX4kiCkdsjOy1asElUbf1V2Doosl2cbGc0/CWkVrEE18SaOhrKwUY5k0VENA0pZK9E4e x9AvGPqp/rVgvqLjnqj67hK/vkIlZzrwyOfDGvDTcorRfThRwvnJjkd0fu9wyFiBltGTH7z36m2
 mUFIsGYqLI6H5uyzJ+dAYM3rh8feQc+Sk8vs0mlvHnwwztEQU/CQDCg64a7RPO1juNh4neQJ
X-Proofpoint-ORIG-GUID: RcnJWWtX8rc0HZu9M2546GRLh0LsBsQT
X-Proofpoint-GUID: RcnJWWtX8rc0HZu9M2546GRLh0LsBsQT

Hi Suren,

I promised I'd share VMA merging scenarios so we can be absolutely sure we have
all cases covered, I share that below. I also included information on split.

Hopefully this is useful! And maybe we can somehow put in a comment or commit
msg or something somewhere? Not sure if a bit much for that though :)

Note that in all of the below we hold exclusive mmap, vma + rmap write locks.

## Merge with change to EXISTING VMA

### Merge both

                      start    end
                         |<---->|
                 |-------********-------|
                   prev   middle   next
                  extend  delete  delete

1. Set prev VMA range [prev->vm_start, next->vmend)
2. Overwrite prev, middle, next nodes in maple tree with prev
3. Detach middle VMA
4. Free middle VMA
5. Detach next VMA
6. Free next VMA

### Merge left full

                       start        end
                         |<--------->|
                 |-------*************
                   prev     middle
                  extend    delete

1. Set prev VMA range [prev->vm_start, end)
2. Overwrite prev, middle nodes in maple tree with prev
3. Detach middle VMA
4. Free middle VMA

### Merge left partial

                       start   end
		         |<---->|
		 |-------*************
		   prev     middle
		  extend  partial overwrite

1. Set prev VMA range [prev->vm_start, end)
2. Set middle range [end, middle->vm_end)
3. Overwrite prev, middle (partial) nodes in maple tree with prev

### Merge right full

               start        end
		 |<--------->|
		 *************-------|
		    middle     next
		    delete    extend

1. Set next range [start, next->vm_end)
2. Overwrite middle, next nodes in maple tree with next
3. Detach middle VMA
4. Free middle VMA

### Merge right partial

                   start    end
		     |<----->|
		 *************-------|
		    middle     next
		    shrink    extend

1. Set middle range [middle->vm_start, start)
2. Set next range [start, next->vm_end)
3. Overwrite middle (partial), next nodes in maple tree with next

## Merge due to introduction of proposed NEW VMA

These cases are easier as there's no existing VMA to either remove or partially
adjust.

### Merge both

                       start     end
		         |<------>|
		 |-------..........-------|
		   prev  (proposed)  next
		  extend            delete

1. Set prev VMA range [prev->vm_start, next->vm_end)
2. Overwrite prev, next nodes in maple tree with prev
3. Detach next VMA
4. Delete next VMA

### Merge left

                       start     end
		         |<------>|
		 |-------..........
		   prev  (proposed)
		  extend

1. Set prev VMA range [prev->vm_start, end)
2. Overwrite prev node in maple tree with newly extended prev

(This is what's used for brk() and bprm_mm_init() stack relocation in
relocate_vma_down() too)

### Merge right

                       start     end
		         |<------>|
		         ..........-------|
		         (proposed)  next
		                    extend

1. Set next VMA range [start, next->vm_end)
2. Overwrite next node in maple tree with newly extended next

## Split VMA

If new below:

                    addr
                |-----.-----|
                | new .     |
                |-----.-----|
                     vma
Otherwise:

                    addr
                |-----.-----|
                |     . new |
                |-----.-----|
		     vma

1. Duplicate vma
2. If new below, set new range to [vma-vm_start, addr)
3. Otherwise, set new range to [addr, vma->vm_end)
4. If new below, Set vma range to [addr, vma->vm_end)
5. Otherwise, set vma range to [vma->vm_start, addr)
6. Partially overwrite vma node in maple tree with new

Cheers, Lorenzo

