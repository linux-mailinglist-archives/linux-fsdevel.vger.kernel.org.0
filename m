Return-Path: <linux-fsdevel+bounces-30945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33998FF9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E38BB23012
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6174614D2B8;
	Fri,  4 Oct 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOP68+aE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HcKJU7dw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AC146A83;
	Fri,  4 Oct 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033838; cv=fail; b=p8hvVlp55m8TaFF7+e9EYUIB4vryWYdzZUXTUaNbxxauqi4fdkRYQVJ2BK5O/hhmX4V6fvAT5nMJoS//debR4SIRj8zqFhrVGtWeQ/XyCIuT24RzsgcdnN4ert3r8iJKXDpmA3Djb9Z47kGlN3sEzgobdiYqsjlmm5m0YcfuRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033838; c=relaxed/simple;
	bh=TAzP37++hmpuFbFVQkxSu2KA0N+1Jo2Kjhez6BFPptw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNyeu++l02qsjiAKUTRaZZIMrr8EIpA0aGsgWmwTdCpASCw4UhlUwANpC04y71TT56BR+Xp/fx2O5WVf/oWKF2MKvHfff48JRglXxYc9ivMuLq+AYmG2gn8fPNqVi/H84IbdnGptacKdxXfGJVtt8u71xVOp2/q0QMJXIqjK3+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hOP68+aE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HcKJU7dw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tmlu028984;
	Fri, 4 Oct 2024 09:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=SEh6EgqhI235SAC4ltz8P09XppVss7GZT57kJx5LopM=; b=
	hOP68+aEaJWv0JJ8fD2ojgasR0bqMKcxXUfWrkCAeF2dDrwAN6BByu28qHIh3cT5
	b75U6At93WrxN6VA8JgT57c2SgR68QICurHMk1bbQw55+lLqMv7+KoBU05wj+kT/
	ghdl+84KmcYyYqoL4MybMrXfQGV4Z/qoQi8+Xc6m3UYjY755x0sa6jPFUcGglmzR
	jjIBlkY3srVAtCdIO+m9xkkSj/wY774GF5DWGYIwP7Owy2NcEvhj/NXUFh8RgMUr
	vpXQcBnNU0ENEwJnMdwbE2KT7ldvVRs2nfE324O4nF6T8n93IGFsRbE+m9RJdRH7
	JtKBI0SlHTZkKyIMke3MtA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gs6fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948oNYX038396;
	Fri, 4 Oct 2024 09:23:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4220550xvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paZerGR1faimhIVpG/8KqXiTdQETdIVVXikujCH5O5r30eqUsxz0PheZPE7SpQKgK0uQgziY3sE8Wdwg+F9F4mtrRIrSJnOEfERsysNGa1RA3LEL6R13IxK7JDDQwIlJLdsOv+8FUSq7URY4nFYOpoukSKhQgv1YG9gowIhRnNOEnosu6QJb5R4bsXdE0Nq1heZJgOIMCOLoB9brxfT6Vw5d+CWguH6WXcDB2IkN0B5RmB+8hDcxZPqsj9Due+RK8M6qW7izgTBDRL24RuwpK9cd0z43XYV6Ma0akGQVBBICvlHXExlwsGTqugIyGF+aeHdZ6nhBh08HskdJWLwWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEh6EgqhI235SAC4ltz8P09XppVss7GZT57kJx5LopM=;
 b=l0KU539sAYCWA8Gfjt5pMr7A2zNBZBBxaXwHeGSWRvxc0bifhl+tcx3tUlmsjUVlfJBhq65zMaA/f337/8reEZEW77xm0BE6KDVAJp7k6jKZuRWl8/o/V6yUpjl0SQtUZEhNloZBLIkA4vuY4U7JADnHLUNgbrFq+RFKxccigSisAm5VWkuLj+sOGWz5rR5/CanJhJMT+u1uQmFlDURTi5uksHlxInPmkLllca8Rdlixt2nrxzm0WTkDx/4mYqC8bBwpyAjmv0FJjUo6brkZCcc2Xu8wdKxthtOO/qps7kFv8M14wlRdCjvo58dBGxFTY1rCk2D1rfjNtTyn7Jg6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEh6EgqhI235SAC4ltz8P09XppVss7GZT57kJx5LopM=;
 b=HcKJU7dw0n1PB5T3JfmnQDOz3jDie8p5JQl73TtFVrG23nqV9dJb+bpJbku2d6D5/DKMEae0xpPdKbst+xIKpkjWbOeiNebY3TApaO+bjkSV3R2cnWSKH7YzGZ+OXoBfJldzyz44tuSt5fKK3RrqyUPgWLQY+WmhH3YVqaNYKJc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 2/8] fs: Export generic_atomic_write_valid()
Date: Fri,  4 Oct 2024 09:22:48 +0000
Message-Id: <20241004092254.3759210-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfe748a-33d9-4a05-2753-08dce4562dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOOJjfXwOQ48yRICC3vlG0k62ldVJgIlPvrjUdJ9Y9Pi0LhwcobWgC2Mx1p3?=
 =?us-ascii?Q?jKWVbdbrW9VIDQmU/m+VyN/Y9lJHBsh3CbLJiM7UowN6Q/0nXZNFrF3KgfxY?=
 =?us-ascii?Q?wT2YqJNkSGlzwqYuiS77alM5dMAbqTmUyJrs0OFLydXNOF7Lj6yzRzIRK1pG?=
 =?us-ascii?Q?ICurg1BFV//kSVNiFOGWIEAtCoBOELgrRBlVFty/C/3pCD8P7v4wa9RU8RU5?=
 =?us-ascii?Q?t70n25CthIEH83qDpYla8tZqbODEIE32YVsXrBz0I5t36kDyymMozXvw78Ne?=
 =?us-ascii?Q?NHESn99w7HRqtUGvStio8tjsK+1eMP2PO6caoQJX3oeVLsa7oSpDcGXjFbed?=
 =?us-ascii?Q?WJ3bRhPocyvNupc4LWv7yhI9kkKICqp/QNfLGs5TuLwHG4Lj2UUtC30a2Yr+?=
 =?us-ascii?Q?zf1y3DUIF+Gj8v0HrqAFgUdfn1WzjC9DTwpvD+6gTzWmqZ7dGYeqdushs9IG?=
 =?us-ascii?Q?mlpXqazLoz7VSabOYYiQtw6eC3x0H/kpdqOScgh7pLJrLiu3RqG1YpxhjSqV?=
 =?us-ascii?Q?pnlCYakJwEHz29UUSuEBN+HdqaA7UP+SXy+SuUlBs+SG7mO1FDXNOpJU8tkq?=
 =?us-ascii?Q?xh5EI24eCzc7qtdu+juy8nyt5T3D5pyR+9oHpYfpYiGreFxm8Jjm1X/Ohi8t?=
 =?us-ascii?Q?dIulDehLlO6kTs82gkOM81aV3aSR4P5y85IRIsWzzIJ52OhIpcjXOMZ0F/8h?=
 =?us-ascii?Q?L+UO/xvOF9LHmVpvhnMy7EZ1cQuBGN8D413lVt+dRdDNFsmEVrCkwRZKxzig?=
 =?us-ascii?Q?DYd2kDEQHOwOc8EZPDGBCKBMOlOV3DNm7OkkXWewoDMsXvvdB3DYrazGbgb/?=
 =?us-ascii?Q?u4D6qUCs3qcDGagbfiEfojAI38H/dkB19mCxg3WpqIUUxBkVOjie/DkQrmJa?=
 =?us-ascii?Q?OZqAdPpjRQn0wrJ1GlGGv3wZ1xIrcfWWqZQSjnNXnyEwBP1jgdhut5+1wMkf?=
 =?us-ascii?Q?UgWvUH4NhO3EZp226GORC7hjKKbGks05AzrXYA8adQBZrwHT6F6jE7baWTtK?=
 =?us-ascii?Q?F5CbybX5BPR6wpdoxbBVcbQt2hJu2rLpj0IzKuCXW+l06RuMM66Ta2zTBIsW?=
 =?us-ascii?Q?LhxjB2XP4wv8R2dsSrVJXWH78TZtQ6JGMXkbwouaiLNZUjC8A4bJnPuLBOZQ?=
 =?us-ascii?Q?L3LsIuNEp+CYCHkKcYosk1NoX6pOlQ6pwAdb8W+ConQ84Z0xqBv1EVWvXkVB?=
 =?us-ascii?Q?4eJi36vsH/IKFgF+WuBlLismQeSA9qK22Z3eda1N2HTPgy1FPbbfQ9Zvc52X?=
 =?us-ascii?Q?v+Cttb3aqeYXCzIVqwA+6u2XRgTnR6QKR9GuGaCrnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrXdCVzeW50dMYRxwyclEVtixdrhYOCt+Rlc2MPhqRp93P/OqtZ0IjVuWfsi?=
 =?us-ascii?Q?p5ehcqz5y8rC1FOLg6eBycSXO889v17NVIS6x6Rdjmy3fwj+BAMjkxM5KBEL?=
 =?us-ascii?Q?V9SE2SklZrBvKFLRJHs/Z2U8SkRektnxNTQudnxrXzjUKJRo9kAvMKG8Xltz?=
 =?us-ascii?Q?OkA6nFA7++Cm/wtc9/dGsgHrHuibLDBFYEAUpXAAnpBs2pprkIpt+F8Kqb9W?=
 =?us-ascii?Q?8v8x1CBFsK3fA9h1/yTDot4rTWpqFaptZHS9LvUI4fDk7vK1dng/E2C6ThZ9?=
 =?us-ascii?Q?EcCEW8TNX92aiveLUvf6ixDngZf29Tyoxc7tybwFcGxUhQH4FC5WSKTKJhdF?=
 =?us-ascii?Q?Ed9AJElogPATDjSrFZMYzDFUOZI3lUJGhQC7XgTpFOF7Pgo3UTrKPAU5Zjg8?=
 =?us-ascii?Q?JqEDRVmjGOfY+Vvphqm7pdTkWRnOO2uLpEdUpRVrPT8rr3Koepoj2YDWEq0f?=
 =?us-ascii?Q?M0DJFJFw7oE2MV9mRboRuZNAM2RI0ksbaeGyJj2rqV2S/TJKP/TrkUii56TU?=
 =?us-ascii?Q?nifgop2sQpuBbjdbZDeb8yd+yRd/poXDwEauI18KVP2YlcSKvH9vtbqjnVSf?=
 =?us-ascii?Q?JE83MD5Lr6IQV/S73IJkhNYLew+rlosVuUrAPn6wjwor/gt+yNP2uo2qU5to?=
 =?us-ascii?Q?2d6JGbtnz9/btbU6pE2DdPxKavp+N+bSeyUbIfNMEjiNVGtEPe47xo37zaM6?=
 =?us-ascii?Q?qE1fK3FEVT1iFRK9zYOOgs8oXmog14F71Wvj4JtQAmYa963tiSZNqL5JvIFq?=
 =?us-ascii?Q?K0zR09SjNqZ8JykzC4f5HEPmy0544Ux1UtuNsXtcI0u2zINa7pTcDBavaAeW?=
 =?us-ascii?Q?nVcB88dzmD4rHJviOEZNeZUvASIGGMlFuYaXwBVu4Z9EW3xTnJPcYz8Bc0XT?=
 =?us-ascii?Q?Gf0yDccCmFECA8mwpYxAkXtuuQGTZBdKec+68esCONlhdFhv2/dz9AtuPZ+5?=
 =?us-ascii?Q?vw3B7pI4Qj7Zsd6u9NNthNxlvRvN6N1Mq7Ml7emPJv5Dp93k2eQt/bOE6uYP?=
 =?us-ascii?Q?lyW1NdbGF/qeaxsveXYRw7gBNE6xFH8IqDSXNOgYHk4XvYB25+SyDEACkA5S?=
 =?us-ascii?Q?RH9nTTjSl6d92PZ6s6qQ6yfCp+5OOycyCYgoVNTxyoPDfBiQBUdZeC9UTzIx?=
 =?us-ascii?Q?v7w/OXCak1HL+iuezAd3jzdWdkXxwW+xwZAsIkgVhbUIYMkJDaGaT4uMIvMf?=
 =?us-ascii?Q?gVkDOfIUkN98c5wrI8JPmmLS19v+CSe6h3T91//1fjHpnhIN81zElBsTbRb1?=
 =?us-ascii?Q?gRcy0X16gkO3+uLmai+AvIu4ouvn3V7yhA8C+9CgAQWewrUbDcQeAqDrXxp4?=
 =?us-ascii?Q?QMDbB3VQEvSq1YfpkT8Ssfy6dFX+5IRW1XgiQVXkURAAu6M6x7mIDxAi1uwl?=
 =?us-ascii?Q?EXSzV4M0IbttGk+g+juZ/Y9KGUonDcWr7yYFDuqNIz2UiUHuOcXCv3lI6Z++?=
 =?us-ascii?Q?JuGI41otieWgXs5peZJl9Qx7LHoVBlpEwGh1gs8mMxIR7mb2SZzPs88FTlme?=
 =?us-ascii?Q?og1+sdodcuzK/PzcGmgmNSDmp5Nyz8UALQRsik3cCpcheNnNm2qG6FZFjBrc?=
 =?us-ascii?Q?wiEsFQxzWxnq8Efm23bmwghYAwml/zYE4h0fmByR2KrUew0HMu5k8/AHHlpc?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g5RtjU8dxgXfrCH3T9HZpcyiDKNF8SNKJGA3gDI9lVXue5jo2F/yvpXFbJvJpMccWiz9KTC9WVKfJeTIKTDsk6FhnSlVK16smJZn26ftN+i3DonQHMv2d4+h4Vm46EH495AuukJFDD8lj0stO1cO8LJya/XoKGic2kqX9yTPPJwS3FetkKHyrSj37pnKjIsU6nyjdPmGesFFxNgtXSW2DrtdjDcIqT0JW9r7y57ubHiaYkBG7Ek9Vxk97sIbLeDgyaafxr91XNBo6bfCTqcLI7f9sHLTxUScGDJ4O6pCWQ3LckrFmiteFFmW/LfFW40EUfjd8MSfGYggujwfpnpTFIdhhhflfGm6mokA3ktZNrR0sXw7hoiYSq6xRnQd1GXZ9k9DyIlL7kr7tRVR34hB5JFqVabPT7vgaxpiXQVXqLMIEsShqW3fnQZs7aII9zJqS/6LMcOirS5o1tSKfoQUUDgFTPE+BJSCVHk4ZIsndYtWEuLk0aKFHWjmpxWf1vCzeOmFP18BTZ1kruGOGUwqhuEWgIqGCNeg7tjzsBY3HyOIX1JFotGHJr4TQ/xkcq6L5YhTzLySJ3Nis1TWg5+WoMPs2eJGyzCDOEih9VkY6cM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfe748a-33d9-4a05-2753-08dce4562dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:16.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHdXGPL1Dpxxxa95mYsz9+jce+Q9hO8Ll1RtvAyoJIGTQbQJcWNVlsiu2F0dE0Sj36JJmTFeuyZ2sa02JWJNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-GUID: 22QT53WpdFqdCgimkjCfQ8aNBqBmumHM
X-Proofpoint-ORIG-GUID: 22QT53WpdFqdCgimkjCfQ8aNBqBmumHM

The XFS code will need this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 2c3263530828..32b476bf9be0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1845,3 +1845,4 @@ bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


