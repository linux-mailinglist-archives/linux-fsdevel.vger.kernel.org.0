Return-Path: <linux-fsdevel+bounces-30330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC6989DFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EB91C2263C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F918872A;
	Mon, 30 Sep 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onxbaVbR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l8tPOHLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBC1885A6;
	Mon, 30 Sep 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688179; cv=fail; b=Yeu156f0olamBBkzx9Ja3DxABf4UeOb9YFjldFMDBY8+qlPXaTl9vq0/e2g/9dVBKIGg6M0Pu+4iKK7oM+oG7s721Y7PyfKB3KDnW45KyTruh7LlZ1zdtPwN1ccgpMhTzP1TJzADEVqT29lXE/xtjDdNe/KT4U73YrBgbCKezDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688179; c=relaxed/simple;
	bh=ltbOeDMfe1OWnc1jc+IhBX+gUlA9XLkrovG0G6EkBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jcdsp4DMUuZH+WWdXO4copQiA5whDb6vDoqUO2QcfCMnj46ZWS/JluNa/bSQAwKO5h4iwF5NlpiXPGdK7cfnLNxEb51z+J5+y0csJjzzNzAlWiZO2owHHrjmCpJqilela3JT9IOq7CdAZicZhtZXLqSV18o7E56sDTqYDD7EwL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onxbaVbR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l8tPOHLl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2thcU009535;
	Mon, 30 Sep 2024 09:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=4el6H1mAR3r73/0GbUniY3qR2QbvpTqKt5q05n7V0bA=; b=
	onxbaVbRxMIRzYSnjIh/YKoV+R/EzICK95kTEA54NbcDq0Oeb/CkyCWANoG4ygsE
	GGWR0zvaiw3UTG1xAIB6ywE4s1DdNgtoMTbn7SBUEJmIWYxreM9IJzoWuF77k8y2
	GUbITgTQIEYYcj3hJv9HOhmWKgi7wOyvXKaAOxiEa7SOh/dx69iGgiZ7ak08wxo8
	d5s7VojZQyi4xFyhSiXd6z0ae6/PiYpAbHDHLLX1ddE4hHd5KjkzFy/Q/5pyicup
	jhsbwb4cE1K/PqU4BH7Zja0ovpHnJeo+itqxjpbRS861EAEG/rCf9afWjG2hNwQY
	+fA5R9+T2WkPe4+McfR61w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k32ut2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8XHtN017481;
	Mon, 30 Sep 2024 09:22:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885stpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl/Sx2m/9FxUrZ3fsBPQPpVJTB3Z9Ufdk/wYNOMtbQp2BShatbOLIKNcbV2YuUdCxrs/mlYAZWacHP+0M0UXUfBkioQKuX7yGfVBMhzPF3lPyNFJnt3QOhts7JGooSfM8xe8L5FIunMvd5v6DNaK9s9gXEDlzVbM3lkK1vuSrxaXFF8w8n1MCuAq8tv1H9IS56huHQrO+5Jd/pPTUVX2w+KJ/JRXDi3eJ8ubJY20j85bjusUJDLqjAffeDfe+wns5jO3xRvUKTpUZD/mbZqyS9e+jVsvnNoxgEK9w4Smq3SU/FIbkStNcKCY6xMPAQIO3kqFGM5xK7GEf4kWf4h3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4el6H1mAR3r73/0GbUniY3qR2QbvpTqKt5q05n7V0bA=;
 b=YXSgWxaHNHfkzYqfm9kFckuxSja+2RZs6Kyj6cyR4CfaralxHWfZ+iIjrjFxcGwYf0UI41N1IuO7Sqmy071OXic93IhimoE3xUiYPnLJmWiZ0J1v2i7tTwKwaht+BGXrj76vtBj27/SUJ1vlfR0N5VlKMn5wJkomqbDmuE7khcQIV5vUk/L8RJ5UNyZww/pjuuQD47BBnkDk0MsXk+Pf20OIFgbTzNNrF4AD8bgh6CW2PIh2GYQ6PR7zzOcEKL3+2yVyG/3iiytafEHszXYcXNZdlN/B/cv08ktKSlFIIDB9EMw1NFVC1/cpb0/Pr67vkRyEboanzko0mxevD3UhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4el6H1mAR3r73/0GbUniY3qR2QbvpTqKt5q05n7V0bA=;
 b=l8tPOHLllgH0u7DzqFS47Xu72ybZs9HIWAj/EpJ18a1Mqc3h5Iv4Mt0JfJVPAM84mPho2j3Nsx60euvPqE/jOVVfkZq/eiFTHQmjEd+akhUVuu05b8kP4jq8ZUlHxzxO42sIDlrAi3aYu6W80FxduRQnqt0RkfVORBWdTyrl3eA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 09:22:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 09:22:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] pidfd: refactor pidfd_get_pid/to_pid() and de-duplicate pid lookup
Date: Mon, 30 Sep 2024 10:22:28 +0100
Message-ID: <32bb395f982cd7017af6251d27eae53c31b58acb.1727644404.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0321.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: ce481eee-740b-44e8-0693-08dce1317022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SweSOk8n+QD3n4uFy612TuRFDhZprteZ0LnJprmXmMxRP+5jP4UuFWnd4Bop?=
 =?us-ascii?Q?M4m50jLK/kGJre0Qf+7KBfeIANgGtAOotGdRxUgOjA3ITf3HwwFZJFqURIal?=
 =?us-ascii?Q?JnFDizmcSVVvzYV2/uGma/0V41XEPQQF1bE20ANy3eWvF8b2QGo61M/J41Mp?=
 =?us-ascii?Q?KnDuukfxbLyFJveunVvSGKChy8J+ssA8yrbcR+FcpP9cE84yqdcIB/QUVKzG?=
 =?us-ascii?Q?tbxC4Z3PXUI/bN8QPLMLzYLD0cvGdVrNHVkQvdJ4cY5ZAm9mt5r37uRws0BA?=
 =?us-ascii?Q?jjIBy8Mjd+9Djmu3SMiEB+81aHf/LJrmWTB/Df9dUQ/xmalBERarFAbO/CZW?=
 =?us-ascii?Q?rjxCnBNGfb9qqj1l1Y9P5hwHBWx3vCVkXDg7PIApKwcpVoUkiF9BeOYZVO0B?=
 =?us-ascii?Q?ObGLz5MN0OIwe/uRRTwZKCgxdQHYi3E0yttA6rDcTMxjKBGNDpo1CykdTsgE?=
 =?us-ascii?Q?rDLMdn6X0h+VktJaUnakQa0eI6Saq8UMIzp5X8kAJr8wU6uk9jvtbrE3fKQE?=
 =?us-ascii?Q?okou9n6t9yMy9m+RHtD+i6xw5eIAcucaYea2mbToSoboYHjT2EN9aAtwMWsR?=
 =?us-ascii?Q?E2YlX5yB+Q7iTWHjvTkLfGwEamX8EhGuLQ8CWoP4oY4TyUQ0DfcapuJhj5LK?=
 =?us-ascii?Q?zRjX4WOE8UF1ya5djOHqvx/7hAN3GwLFcoPvgY7dRKxVMOPBwU4LTrSOGbKW?=
 =?us-ascii?Q?tSLwCvsc2qgkrBJLma+FtCbTHNM9jhppD5bzbmEZF3unwgzXl3ZahCDAPOv+?=
 =?us-ascii?Q?5viUEJJAdgHJlCzRJiZKkUcvWcCa5mhkWZ+1lk2U611p/lRd0s4v+2VeK7Fq?=
 =?us-ascii?Q?d9G78yGy3Zrq/EKHKYHl7F9ih0jdS9uNpigMmIohkjvsJfMVHjJm3pKe70Xm?=
 =?us-ascii?Q?OBESjDp7odaOA+DZedM25bP/4wcGwiqmu/aRToyNoW4HvlMiYKEzv7HwE2+Y?=
 =?us-ascii?Q?1v5R0AJT3E+eLiC+73IIqKjRv8XvUSRdWMJVXvLUWXblMqWlRB4xxi4Ljv0N?=
 =?us-ascii?Q?q0fB9WnSKve0AbpKKN819fqyes2uU/vUUQRQG5bOiDRStYP9UFwqAduNVoDw?=
 =?us-ascii?Q?uiLg2Bzk2+Ag170rYwzcKmSK6g9x8vtIqizZEgvCyFUr7D5b4GPrhmJgS9ZD?=
 =?us-ascii?Q?S0NGwaXoI8/xduTx0TynNVk0stHWylD2CQ2ki97fHQaFEjU41N0xLbkK1Rjx?=
 =?us-ascii?Q?s+26SJM0mwoR0S0qKUdoOBw/YYXw8KKjfZm8qKAP1M76Tci1B4M1O2d317pH?=
 =?us-ascii?Q?BKg6sfavp3ax3INWV3EDTwMWEBfBA1oninhmnCdJ66gMPMlIQXrgoCk4rf2N?=
 =?us-ascii?Q?Iy6qSoJhNmUccgkudrrMz5a0p8pLCDspswsFsjo3NrkRvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCJ+dqhYyCVysPH8MTHPDdSj59QdgshtQoclQLdKUhVFIwukTScAaf2SkR8Y?=
 =?us-ascii?Q?HenaFE5u0HXzt5DGWvScsS4UlU7VRR45cBuiye6lbPOSVSEUPfzGycnma0si?=
 =?us-ascii?Q?Cp6WE6Z5QOYFuvXwPmwUrU6Cta6PUSD1PbYUTZlwTNQgCIL4Z+/Nf8MSPSr2?=
 =?us-ascii?Q?M3wi1w/wFAx9KtJns3z2vDLDefcblYPwt63miIMrnlXeaeoB7vwhsxplx33A?=
 =?us-ascii?Q?I3BkjBhbS6xts44GRHV05Be9lL7sMoeGZMjrwuR3+Fw2NbiCSbSGQVfXuVqy?=
 =?us-ascii?Q?IhckFhWLF5LouBSHoMgFA5+a7qOIKowGMBxa5Sh15tSJfqLA+jF3smxXJVz7?=
 =?us-ascii?Q?s5mrSgMproon4CSBSgrH8fAwebFUzS+iDmurxWcf3BJC32zEpNmrWLh+/5NC?=
 =?us-ascii?Q?/wAU8J+mMr2AC311YK0Zi52oBkdx9kHwBiERwenYr5rFMKLTt/H8urJW6mUM?=
 =?us-ascii?Q?gWkRPlVaZW0cC8jwhTU4YCKZ8kaVe9hm9M6iFV6I9WDf174+jmq3VgUbPg6t?=
 =?us-ascii?Q?Nvm7TrYv6QND+UWjE82eC1FP2R82YzwOUJOTzcSVT1fMp/ABbTJPAnHL4Lbi?=
 =?us-ascii?Q?9Q3MlM4GoiXgiG2nmuge7FUb7ReOHZ/op0rnAsie2x+YgLDD4QSUIqIRksVv?=
 =?us-ascii?Q?PoZANY9JlJf8ZW1fL3XnYer/XqqGjEDHXvS5eci6/P/t8Q5CGefCPmEBCyug?=
 =?us-ascii?Q?NA7AySqd3pHj7nGX7BeXzvqT0rSiCPrqUc4tqpXc5JZ2pVKkpywakFwrzpg+?=
 =?us-ascii?Q?l6gbA7p/ezG+anUnV8ILKx0BLxidYlzrMG88IHqQ4m4O+QmVd5amkyqWtyuV?=
 =?us-ascii?Q?BSdpRW8XLN+ZYYnoQa4mnLuTvA2db6ZU7ikmAka+EIqumGQ4RQqDYn7Ift6P?=
 =?us-ascii?Q?n3xPlGYvlReZvVG5k1GFBdezkNGKdbCrCu05DR94T/SgyxrLmoWq7yPoVx5S?=
 =?us-ascii?Q?grafoR2i8BCekpUXKoGY4n58GAqUHku3e4PxyKDtA7WePaUtDavEQlRuBUD7?=
 =?us-ascii?Q?5gnz51PpK4QAfGkUZ2w01YWheaah2nKzlG41pc3K4qV4StUtzXrFKlwTLyf3?=
 =?us-ascii?Q?OuWyYPFQSHWOpPdihiVWfAwstXAhfeiOoeDy9pj3Osnb9PH7FFCpEYt1JoLg?=
 =?us-ascii?Q?m3z+yCiMQUJnN+lFGNBeQ9Lzu5SIVWgRBnIIuW5WmI5vXWjMCLCahh4AsK1v?=
 =?us-ascii?Q?ivTcZjVeElNkyXO7Qec5ZBgqb+an21f4odt8KCWaig0AufJu/GtjQ6yhB1dr?=
 =?us-ascii?Q?B3y+c6VT2wq52gyj3htOIgDUNHMgoHQ93r0Zr+7y2YKkhsC7V3oFO0CEoeMV?=
 =?us-ascii?Q?L087LaZLz7BAPQ99BzPdSrWKuEUEqlVHVkzA2+BmRNfVBQ/T4d/fSzD+4dnq?=
 =?us-ascii?Q?4rh++NBAtuWwpbL2+5fhdIRht4WAv2Moq/gmzvD23LTNCiIZ3KoIynWbr4vY?=
 =?us-ascii?Q?gODzfmTuqUcqYzAueAMcxSrR3ivwOux6/2rXAFOYrGnPazSF/ZwFmR8dQlla?=
 =?us-ascii?Q?c8YzwffYPtwZeLAT0Ad9EATHH2UU/v9QzPlXj2983VwzmqrpZiMiXFAVXQVh?=
 =?us-ascii?Q?KaQQ+fqEGbVHD6OO5fwp+dKAO2bYzfkJsafkfcCuAU8RMf8THvUPIk9dsUpT?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f8sQyDRzZqvETviq9/T5Na/QMxX74fmYnY/2n9b6fxo9c/rjqsAVGzm5Zi4K9Nw6pPO+ZMc7t/BiGR+MywqFgiEXmcDTDNi84aCUjAJH760xZQrfFzAcgl7Ly3jtScMHguHAYy+IMqFjWbhpoHL//ClyBjR2XlqHLPucV9eo60cJN16ZcboOYmWnX1N5rXjECSXEi+a0RRhr+rwajwivGSjwS2K1NCfBuhAvryQbvOSFnMo9CmpdFfaRxXLb4ShFMprU63vX7CSH5KD+sCb2jX7B3+h+Mw0GR8Mvl18p63gBm5JHtwSgjUGij3gtiqGRjFxYT3h4sbmwLfChyw70gbiGzXnFpbQzYupdOOLMprI1Y+J3IIjh+EeTPfEoWS2Gy74Ke1zAnOAcMKtOlSUMqfGde0wrrCRmmWsPlB048S0DpujiMMySm2ZwjlyiMuO4khuIWEz3wWMwEYbOI2a8OwhrJt7x9mLH7M39eTUcS75qbqukpgzCoS3TWSSNsaGuM0MNf2Eh+2qh+RTJzDz3PN+QrpJnqiyRstJf85Rs/pwTKCOkd37XbbyHVkAedNo9V8WEEuR5pi6zES+qAfqmhFMNyEG+8nFk6RqhEFoo9xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce481eee-740b-44e8-0693-08dce1317022
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:22:43.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLuNhIwOYk8Yrgki6RitzlQpYFHqiNcsD9TRewxDT2eV5vgGOn/ul5Rwmzt+sus1wQXCti3rPVDT5yZuqO8/rvp4SaJH9V6dqSbsErrnSis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_08,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300067
X-Proofpoint-GUID: AEJHMyBTC0vEllORlS1n2JE3dqa0axBK
X-Proofpoint-ORIG-GUID: AEJHMyBTC0vEllORlS1n2JE3dqa0axBK

The means by which a pid is determined from a pidfd is duplicated,
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which abstracts both approaches and provide
optional output parameters for file->f_flags and the fd (the latter of
which, if provided, prevents the function from decrementing the fd's
reference count).

We add a wrapper function pidfd_get_pid() which performs the same
functionality as the original, only deferring to __pidfd_get_pid() for the
heavy lifting.

Additionally, abstract the ability to open a pidfd by opening a /proc/<pid>
directory (used by the pidfd_send_signal() system call), providing a
pidfd_get_pid_proc() wrapper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 42 +++++++++++++++++++++++++++++++++-
 kernel/pid.c        | 55 +++++++++++++++++++++++++++++++--------------
 kernel/signal.c     | 26 +++++----------------
 3 files changed, 84 insertions(+), 39 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..68b02eab7509 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @pin_pid:    If set, then the reference counter of the returned pid is
+ *              incremented. If not set, then @fd should be provided to pin the
+ *              pidfd.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ * @fd:         Output variable, if non-NULL, then the pidfd reference will
+ *              remain elevated and the caller will need to decrement it
+ *              themselves.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
+			       /* allow_proc = */ false,
+			       flags, /* fd = */ NULL);
+}
+
+static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
+					    unsigned int *flags,
+					    struct fd *fd)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
+			       /* allow_proc = */ true,
+			       flags, fd);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..26e2581210c4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,47 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd)
 {
 	struct fd f;
 	struct pid *pid;
+	struct file *file;
 
 	f = fdget(fd);
-	if (!fd_file(f))
+	file = fd_file(f);
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
-	fdput(f);
+	if (pin_pid)
+		get_pid(pid);
+	else
+		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
+
+	if (flags)
+		*flags = file->f_flags;
+
+	/*
+	 * If the user provides an fd output then it will handle decrementing
+	 * its reference counter.
+	 */
+	if (fd)
+		*fd = f;
+	else
+		/* Otherwise we release it. */
+		fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +773,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 6e57036f947f..abbb1931deba 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3894,17 +3894,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3931,6 +3920,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3940,16 +3930,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	pid = pidfd_to_pid_proc(pidfd, &f_flags, &f);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
@@ -3958,7 +3942,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
-- 
2.46.2


