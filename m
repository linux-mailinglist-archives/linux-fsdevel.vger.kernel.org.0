Return-Path: <linux-fsdevel+bounces-21558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7E905ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829522839C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0E487A5;
	Wed, 12 Jun 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bG3gRfsx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwDQ5p6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25983F8F7;
	Wed, 12 Jun 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216915; cv=fail; b=oFu/Rsm9Q5DYpDJF5cinjF6tFNOJrRquP9+ugtFIkTba8cZXXwiiihL5SuuBFiPZ/g6yK5P7AHo6SLG0CHqTSDdNNM1brYkE32dBBMWPHHx6Ej0uZpoZQ9pSHdvs4mu+JQVgYYOZ190Rmkw1+K+iUVVLzDQGypEYbcRBZeyhu1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216915; c=relaxed/simple;
	bh=O/tssF8N467H7YEWxOaa14SJ8c9kk7I+NTHdHktmdNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mC2LQQDJH0pqUVv1wRyy/rId5GG/U3ZjBZTQfnkzbohwAEMYPiS7hlFcgV2kpKnASbciWKXZavD6+c9wAhmzsuEqmmsDgH9d2LshqQFO/mfNTF/Aokgo0HEF4/8Qu3Gxd85DCijKQgcOvvnnNr20Luact7VZlIpp4M9Q4YA8FeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bG3gRfsx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwDQ5p6l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CFGFf8008934;
	Wed, 12 Jun 2024 18:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=b6N5xqQnVM5rxyg
	7/qJn6eQbl2IVss4qPMcmG/8bekw=; b=bG3gRfsx/qIW8CIsxKWP+/RxoX1h4DF
	MqO/28FI7l4cujLkfUE/RUiCdQlCysPhwO0if3STRQxeI1iRnsMHxLx06jm2r1yt
	u4SUxbyBnMsVt8iyK/VYCJ+eiLhQH4nLrSnB9uz0iUSyyT8o9tcXhfdVXcaoF40U
	EpQjGxK6KOfFWy7M0/gw/2wLQ/zejXn7xEH4ctNXZF3m3u8blYR5MZyyfu8quTAD
	eojWvL72rXb3J9kCxlfhuybSuXAn0OTxIjaSMaSnKOCwFciVd8jGuBkM2Q0eTPoG
	fmMFYYhKiBYxa9rn7TYvuoZGzDeMHe5VVGi/DNacrAtr08wzddtvohg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh197s5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 18:28:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45CI9wsV014351;
	Wed, 12 Jun 2024 18:28:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncevu9pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 18:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei29v2SB5K43Y65YvCUZmN2jBTcG4Y9sYNSrMPyQmM0PlnPEzJVPB3WiGjGfO3LPlGKnpwTg6yoWLQhD8ygkaO4W87sYeRraDCI7VJOjNuPQ8kTEkglAdGLuL3oZn3nNeqtPbq01FVtwVwvGZuwDvB0T8jkWq0Kfb/nYTd8ebjoexsMn/VIKaFLRYU0SWgWFirk0fl/r9PBXsFPJrBhwP+10Rd8/udzZc2Cw2RCdvQAK3x/h3JBcFUHnprp7Ds+HNOxiPJPYxIqISyHUamHimENKHPCiyKyhE/onW94RlEMO+5Bi7nHjC8tQbi1taEUrQ9WWPE2pPlyD56ssC/4YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6N5xqQnVM5rxyg7/qJn6eQbl2IVss4qPMcmG/8bekw=;
 b=BKpWVA8P7nxPd9i8rRpwxzuP7nEqKF3KfKx1lyX1n1l2uEkvTIz+OHaj5h4SZ583Y8ODdZegtw6hdvF7Yap27E37K2FLmcLjY6AgFCAJbGPmn6IwD/NTHhxOGuvhzTDsAWwnfBTAme4Se4EEOdHB6YnsWxlTCR8H9eIIUMc+5c91y1ZjA5fISWVPxJ6I95yq57DFuuiyvRG/UnPw65mNuDQE8HCGIP2Uah7BOGxMpEJWwnfy1QCavidJUqopm4wW2wxvVI5jQbIK0EkoMIic3lSeOHRNXgMybDuMzb9Pdg3M3yYE3Xim28d+GqwvjarD0mYu1BtMloKaaZjwdgm+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6N5xqQnVM5rxyg7/qJn6eQbl2IVss4qPMcmG/8bekw=;
 b=YwDQ5p6lk3jr5YFjoSPSSr0VNUbJcSYQDat9EJujX0hvrSo+EmSLgtL++tKqVrAxgIfJhYOVUVuWWImpQ3fAm+vQgcZm3JiUfXtvU9ONQPzaOrhnAeh4Tfi5vkNLt/D9oUnHtkPL8zlOah/phYrHM3DQoV8SAy4s3yqNAQsVP9I=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 18:28:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 18:28:12 +0000
Date: Wed, 12 Jun 2024 14:28:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
        surenb@google.com, rppt@kernel.org, gerd.rausch@oracle.com
Subject: Re: [PATCH v4 3/7] fs/procfs: add build ID fetching to PROCMAP_QUERY
 API
Message-ID: <uofb56lk6isrwqf42ilky7r3wa4tetaaze2m2ususzqpbnftkw@hwskh5quvlfm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	surenb@google.com, rppt@kernel.org, gerd.rausch@oracle.com
References: <20240611110058.3444968-1-andrii@kernel.org>
 <20240611110058.3444968-4-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611110058.3444968-4-andrii@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deea059-752d-4e35-349b-08dc8b0d6a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WTNtpWRRFyl6RUmIQ2P2v28itot9dzbHYs4Vd3z7tXbm1d+f1KNKiHtBFgVu?=
 =?us-ascii?Q?QFK86Yw2dRhpPe1I2rl6dXH5s7ePxWVCCbRZePVi8Lud5nH1k4E/3isYfLa4?=
 =?us-ascii?Q?bTCRE+ehKROu+4wteXCMyYiGmVggIdfSopbnAcMuXIw3lDzZ7/xAK1UFcPJl?=
 =?us-ascii?Q?40w+3LUevBlcrkwgw+B/TDSNn7b0Z+r9C+3PVm+Y7QOfFj/dpCcAO2+FtQsd?=
 =?us-ascii?Q?a9IklXnAtVR7vlSjlWYr47ioUPwd4tFfGIur8wMae/N883BCSlVm+rpsxNVN?=
 =?us-ascii?Q?eT2P6JHU+p4+qyO6aRuHjEzqF9oxupddpIxg4M/O3I6t7d71F0uCSLS+RJTm?=
 =?us-ascii?Q?0Z2UYJSc/VeYDz1s5FxC+6eEYGz4FhJrsJ65y/l6dCNrb2MBRCWmN4M0JrXj?=
 =?us-ascii?Q?LIOrfSro5f2s7tSzYr6pzhHl3C3bgBofdnSaRmLenTG+E+yyzaY7/twdrRKV?=
 =?us-ascii?Q?7v70EmGEiQQ2vYMLOYD3m8pQB5yHKQiE8OtUw5x68EjEdtMlBdRkdUf3ujdd?=
 =?us-ascii?Q?kI4rwhIgpHIdGlc0SE2SXGFXfOTwsrzgTjwYt6yP/HhFpTEGF9nTIt62OO9L?=
 =?us-ascii?Q?C8QmmZhqB/8y6xZePf/J750BZ6WaEoddr2JRfn+8lcZRHtcH5ir+eeh3in/L?=
 =?us-ascii?Q?SbqKA2ZmlfaPluqnjcPdfaL4feXh1shUMfPfuCKNpN1g9keN9V94zrlnhwfQ?=
 =?us-ascii?Q?197pAGv9S94WIKWZK7xXO43IMM4LZHoa1dVTBImZ3sM22jQZqtpdA4aooq2e?=
 =?us-ascii?Q?RxJu6p7/HCPKuwQllWA27WU/tGDkkeCg5HWh8yRMJW+bu6Qswu1f4aFWq28c?=
 =?us-ascii?Q?z1OcdZpnIX+tuldKtNvmUQVmTbkjcSnQItahe9HMZFVTKIPixc+0adaPI5jB?=
 =?us-ascii?Q?itZjbSXl/Ai8bNI509ztjQQoGJ3hlzC6Tt7WM26sv/joCGJpzOIFrb4oCbA/?=
 =?us-ascii?Q?AqYlPwWY4NcsHnwBh1i7X2bjf5LId4Gu+9cLNOrJ24H9CZ5+A5UBXQNPW6v0?=
 =?us-ascii?Q?95KeBoDqx7TJQIymUnTQjyXJZRWAHQq8rIGUTyU9CBfDdY38YR/5vir8Tr26?=
 =?us-ascii?Q?mnJU8q60qxsVJi12BBaBpRV9mKzAnxzsJC5Ha42RiZvaozvUycA3QD70wWH2?=
 =?us-ascii?Q?2n4J0cMVXTM7zDM9wzC6id6Gn9/ydxcNZYPHyz1812IyMzunOT4d2ok4/wM0?=
 =?us-ascii?Q?IOsJf21DJv4YJ7S+aT3WP7e8pOFSxW2+DSShB8MZs86q8ZTMRJYcqiwZhv9Q?=
 =?us-ascii?Q?9tO6lUFHcclpsXW2nwSOUrDBsxJxJAE5XTuQeSdKhy5CEo8AdXSQnzDXbhQk?=
 =?us-ascii?Q?fKjs8jnMmy8uHk32kXgstEIb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H9oEHnVfE1fAkKNosmnKrwyVFavBYePeubicNScJUZFJP/YQwwf3Muf/RYqo?=
 =?us-ascii?Q?bwmTdP+ZovdWyIu1KUJ4mXwcXpET2uJYplslCWf0kZS3WEIi/XSdGoq/ovYS?=
 =?us-ascii?Q?6iws2mBAFOnKqdgoKCLIXdgsiEvFbRFzCmsNvuejYMUIhRiUJ7jYzvbjcFlw?=
 =?us-ascii?Q?0TM92+SURVf80cOuykz9UQjs6t2mwdw3FyO0Db5Ae3hfj7dtYXuJGuL6/w+E?=
 =?us-ascii?Q?zDuEPHrWBg0S1vnSE1kDrcyYrhOpJw6Vc8ztDVnhf2T4GTuFIXCwuylwob7X?=
 =?us-ascii?Q?bmWzMKsSCH3hsd8S/G37vEZSA/NGWjmINH1dtmzpfbDWtOWDYm66VsnNTuON?=
 =?us-ascii?Q?1xEyVD0cOgVOmkZKbxnVko6qw42JZAybdxLTkR1Bfauk80C+qQS0kfbAhbLw?=
 =?us-ascii?Q?xZC5iTKQWRk4JNqsP4VNB6YGPi/tUon0HcNsFI5CGYpoMwzvmxWeUXQXsZEw?=
 =?us-ascii?Q?bPmfohvyzhODehX0XFVFggK9qwhgFwwirO4N3JNplOaWprywWFJ/TSNauLNO?=
 =?us-ascii?Q?5V5q3BUYDlQ4UDzJr/jbpt0t17p4VEzqBqBkvD7NL3qbrh+50T3EKJ6ix/dB?=
 =?us-ascii?Q?i3YYxuZ/b0Zu98snk5ItAaIu1ad+w0/9nQeazK9Qqsraja648gxJ9trsfuoR?=
 =?us-ascii?Q?P4iQu73Avhtp0SbNf2ad/QkwRE6C3jiTVOwjbFRXJe5PKUYuCRnqTElodOI8?=
 =?us-ascii?Q?gBiCLhH7OK5WPPqajzolzVsXBk1Qs5WZ2Jff9NVMtVboQHZrYBg/JIF+XqsB?=
 =?us-ascii?Q?DBpwoc//f3mHT9y5mZ7m9r6bri++SxFG61DQ1EWaoRTF6AEyoxiaxPb0CmLl?=
 =?us-ascii?Q?tl3cCnXCc8pZCLNik5mESUcgY3WsyeMLaTdmBKlTlnN3h8amnecBP5SUCJbm?=
 =?us-ascii?Q?JIge3KcD4zyEqxZUH24VD3VIAwwQYN3talby7kTM3+YJiyjrOrPk+ccIBqsc?=
 =?us-ascii?Q?YUtVZCWcp1ZQnwtZDZ2Et22S7g93R3wI7NrEwz1wYVxWaaMnYEWmr1JMkFG1?=
 =?us-ascii?Q?7QzV4E2Ya3WSgXx++vyxKh/IxupGPTCBWoypKNJ6u6AZnRrJvbEeNEn5lF35?=
 =?us-ascii?Q?VAqut4g7LgTkI79Th6LjGLxdq1c1Q+zUuIy+EAw5d49F4t+4KEYxVM3/b6Qd?=
 =?us-ascii?Q?ltlMJjpEpiSEr36a9F+ckCwptDAhMrKpbNUKgEJC9OYIeDDQSuPMTTfz0E1T?=
 =?us-ascii?Q?fI/r1fXiWNN86DqnAXtS3rGZXx19OJ+3Arvhvo+Gk7HjuB33RkEGq+5ueiVb?=
 =?us-ascii?Q?2IKU5weVA9DndH7yHcEacr3aA9DQd7o1CgYj6IVfXb1H+syQLHAapZ5UZ9dD?=
 =?us-ascii?Q?hgPjmdRuSdkesBAD1GFB/q0cks72QFa0XmqPEMIkb61V81ihrclqTJ6t4yPf?=
 =?us-ascii?Q?geGRFo8X0WL7yQzjmLKmpoQHZnrgG515CahGb6jBEwYAmmUhQNLrUHm3tiTv?=
 =?us-ascii?Q?NEpeQWqraE0L50shHSXxSPQuBzHVhxyy2IwKI4PAgyukBxg/Zoj0fiMOP5I/?=
 =?us-ascii?Q?scYxpPqk/9f+eeDLIJIO4crOFXoAuus7v+Uf8QLm/xOMitLB0xRD+RW/7/4a?=
 =?us-ascii?Q?gHubd6Bf1kV4LjCHO48lLFKXbZY8wVvEkOK96IE9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RhVd8uwP0PocfIQGEV0z4TykLtge+vLHXvzsKUZuPGEhK8TiE2bpxCTdRjEBlCHlkN2PTil2XMzQ3055xWy5LDt1DozKcD1o0ToGzJnvwIbyqi+dkxa4OELdR3xnc3e9ylJHGO6Q6nQnPHGjYPNAZ4wRGIaTCRxivatQrTwRVwgVIqmZKTBX0EEdV6/9gLevTkQ99Apv7Si/8iTvPjX6TgGPu7FpwMFgRwfH3DX2Ea9QVfCIgdzU/Gj1ILTeFx1r0DLi7rxaSzJrH77DAevCth1t5iGmB98yW2g2BsMDUQzuHyADVicIAlPbCpqGwpsQxaJ500RJwtkAuiHdHHg/pMOB2v2BwmDXURcSmLCr+iPPBW9jPq0+Uk7NtyEjOlVvej1FGclWIsgyQHesB83VbGDYFBXpXDKMR4Ed0TSHwLEMprHgnOPmwK6YWYpmGzvPQbDRLa487F1N7tz8EGb3diAdmLA7fTTu3eLbh+wyFY3iCWfAOiZBFreknZ+ZBXqdUQ/AV6obXchFAdP4j2STzMrQloLYBl7L6p4hpMWqZejEm6VzKh0u6W8X2BlsHhoicLmytAo8G5nLaLMBouqVXzWh1oZhailxAhdWtiXMw98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deea059-752d-4e35-349b-08dc8b0d6a90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 18:28:12.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uztJBvHvEjhme2QUIZ+mTwaoAvyCFH+S4vhUZoFMnCxyIKJLUySqjRyLMnCT4CBPMtadWntYKkC0uFX5fyegsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_09,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=694 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120131
X-Proofpoint-GUID: wQcyU5rNRp76FpF08C5GUkVaWP9xP7cP
X-Proofpoint-ORIG-GUID: wQcyU5rNRp76FpF08C5GUkVaWP9xP7cP

* Andrii Nakryiko <andrii@kernel.org> [240611 07:01]:
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this.
> 
> To get backing file's ELF build ID, application has to first resolve
> VMA, then use it's start/end address range to follow a special
> /proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
> is necessary because backing file might have been removed from the disk
> or was already replaced with another binary in the same file path.

Can we please also add the vma_kernel_pagesize() to this interface?  We
have a user who parses the entire smaps file specifically for
KernelPageSize, which could be included for a low cost here.

The only way to get this information today seems to be from the
/proc/<pid>/smaps file and it is necessary for certain hugepage calls
for alignment reasons (otherwise the calls fail with -EINVAL).  Adding
this extra information would allow for another text-parsing user to
switch to this API.

Thanks,
Liam

