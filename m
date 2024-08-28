Return-Path: <linux-fsdevel+bounces-27635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565996312B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018FA28675B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDCF1AAE1F;
	Wed, 28 Aug 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9kZgixQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zxfEaC7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7EC125BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874414; cv=fail; b=oWnMq02h18qOJ4o4WdWVxQHFLUE3XBA95UHv6ljQOPtLB1DcdWSbW58UkRwZVZiQgLFXKbE4DkNdXu7fnMKapLEsCGkspqriV+PPkbWXK2HJ1doke9ID6I/5WfY4PZy5HaGu2aqlbWXvUIlAixQnaSQxxMZk6/HcUeLaZslp82M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874414; c=relaxed/simple;
	bh=LGQ2aeQNSRD9dDEic41TNmj6fl9RRW9OS7l6wEx1rMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxk4AVYeZ2bOtz5GobCSdS0TrJEblsRRiSZ7/FPLzcHTHNTlrfVcBGJ3U4l4BZvo6RD7pIJrDAEbHBWyDohZwPphbSYuhwNLAdX26G1Mf16lXT79SxTApDJFrzkWBo9KNXJQnUvyMC8VAokeLxaWaHBiIEY1RCTLgMc1q9+OkpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9kZgixQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zxfEaC7g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJY8Z3009516;
	Wed, 28 Aug 2024 19:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=xTW4natDoTFEevt
	u+iTsswXZ7SvGdwTQxVG5+PZcWH4=; b=Y9kZgixQctBNc9pGRhoNk/1NN9hO8n6
	IysigWiJct+3tnqBfDiv3MM6v3WvUlDJob+WiY1Yg9FJU5j3kMp65KxARecENfEM
	fEqH9/XyCfGlEcIfud7hM6Q3zW4koYZXIMYLgpz0Gn0F+zh/sCBZCGNFvhEKlpVN
	uysOuAg26Nl4N+iadPie+Pi/rlAkIStzNvDTBWOmIyFigcp1cnT0xil9KGFJaSoV
	SN0Km8CUkJwFW8KLoiFdKS3x4uDEAqHqKJWqCFZhbfejZBNvOrv+3uTC8FrJuCKn
	vt1Evy9UThUuPULJe4kLJG2xHHoSa/TXiMxMVE4/2x+nzK5cohhQBzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv269m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:46:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJg4TZ032483;
	Wed, 28 Aug 2024 19:46:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vrt5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izeQaXW5+BbF15oPT4DidPf6ftW9lKs17sF5TU4bX6k2u03oWW8JYqGjxnrR4TzT5rPo4Ji1p+/iVNrL5hN0y+KPJGe9M13CeYk4t3u/QIldZhBxw65Kn3K1TkqjX9OqVBXTHyKPFMbdRjL6cU+jrKnoEhLUBDYCFAEi+fkv2LzU8uszh+8cE9SURD9vgzax8os44LNfM8C3LFWVIq1Wl+EFVO3Gi2CwSFpN5aqg1w0tRavqlt87JoSRovmvAcBKFsKRv8uz6JvoUdBNg3apxNGBjZq01JdfOXPUkamrKnZm/vSlnwu5IaPKu/pYdPBbqY5RuhcOidot+8pYC1+rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTW4natDoTFEevtu+iTsswXZ7SvGdwTQxVG5+PZcWH4=;
 b=KA4b8VpF0i+RmRuvQTFy8aAPcLikSP3qF385zlcY0J7oHPnJGsTE8tVJIFIj7sHCPpq7nsa0fiJTU7jYh1Lv7SI15l6hh0dPbCzmGu847Vr+bmWnUPDxykCntsw2GzdkpzPwl6/ypu0p6hw7E3Pwm94FuQPTWzz4y3Z3aM2/govprxC6i9T8p+T9snyufPyv4HwB98vp555dlIWCGHApn0IQ8d2jtosEngzMjVkkRloUMHCoQWIQmqfPd+fSXTj4HoD0NeeiPYxJppQBYNJAruIQjgdTiKoPKrTZshaKVBZV0K/ezClUQzFWnzh/0TJ2/afMOJc4hdKTCLQjz2QMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTW4natDoTFEevtu+iTsswXZ7SvGdwTQxVG5+PZcWH4=;
 b=zxfEaC7gIuvuckEmylCU0+wk9e8mI6a6/Rnk43HLzJo8TIkpJAzwF457GGvoVKz4TS+b4C+3COP5g3xOyWEIGuUG683jhDVomfrTx2rfZSvEaW7uDu5YsmPnkmnOIZeTYWfkjU/TnY1nXRIgDo/2HWagLHw6dEHfJa5JYX98Qn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5984.namprd10.prod.outlook.com (2603:10b6:208:3c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 19:46:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 19:46:37 +0000
Date: Wed, 28 Aug 2024 15:46:34 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <Zs9+mm8bElKJmz65@tissot.1015granger.net>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs97qHI-wA1a53Mm@casper.infradead.org>
X-ClientProxiedBy: CH2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:610:4f::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a580d2f-8724-489a-a5cd-08dcc79a20e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNzK8FXR6pvPl+/P0YCRhoh5peU0GBe9SwRPZPDzSh3b4gwGelNye+Fvz+8j?=
 =?us-ascii?Q?e6Xn/2NSxEFj17DaAyFTBQsXEWpoeGTbHcF08XKlUgZror5Qjbax5UEfAUW/?=
 =?us-ascii?Q?Ca6KNbWkdlq2wzD/d97jB7pfh4uTv7DZll9pq7RLfbk1bzE2kAo52BVQ1d5M?=
 =?us-ascii?Q?5kI8jMr/KI7hNvVXlpEBBlaNXCGOy0VIHdtlYiC09z5wWPwWEriajSybq/3H?=
 =?us-ascii?Q?vZ+m0AH5W1elZs+5dw1/b2xgUjPnrV85+5MwM4UpPFH176wS+BZIqdV1u7J0?=
 =?us-ascii?Q?L7EpRb/8xOwnvLr803//bShOzyeqMR7qBkyyQdhXWopYN/OmIs4bcqaWpnSb?=
 =?us-ascii?Q?WEklrHkD7WAwUSEc9EucOcNDmoX6pRodhW8ghO1Z4Wc7RqwUk3bVe7lPG91h?=
 =?us-ascii?Q?SY2crFGWxluL7h7p0e4ACSYQfmyEDlyukUCWAXQAZJVcUTtvU8THPv1qTJP9?=
 =?us-ascii?Q?w8sI4Iq3uvqLOc0/4YzNwNAHsr5c1NkYBQ0oKIpzwBJUwi+IZMt/9TzzFo3F?=
 =?us-ascii?Q?f9XvtTLN+FjXroL/fjv8NayunQ2mXigKEHqtXbhcIyJdpoRefLDCfMRfR9Ns?=
 =?us-ascii?Q?IkT1qshblal4vQPiuwqxW+/ZxxqdSS5tWqWrdRCv8DqE+YWKq4wtyxY2rK8O?=
 =?us-ascii?Q?M1Y72UUzv+lXiOkR/pXW827YyMTOwKha9cCSXm+v2sk1OMqFdq7DxHaock07?=
 =?us-ascii?Q?YRC2Ix5g8Hijb2CXdgeNDqOrvDwXyC1ulPxf++k3j0cQe3d/sTJdk6jPntln?=
 =?us-ascii?Q?+laZX2yd708xoFtnVJakVt0/xfl08uZrwH/a3WFQpM36ksvkkAu6yGo2RcfX?=
 =?us-ascii?Q?CDBwVBKXvTyLPNshKjE57WnF82QXDevAuMcSZVenLSHGT/4ZvVdqKnru/epg?=
 =?us-ascii?Q?FUL5nUdGDv8sLQA46rnp7lIO9gnBymSCXIG5GEnPI3p1DqYEtf2foOgu9/1O?=
 =?us-ascii?Q?1BpX6s+ysPJOTkiAFVSB5H5uGjF+P/iM409ou1ed13WFKb1kA0JybA0fgSYK?=
 =?us-ascii?Q?FwPuewgjqwOepjSDyiwphqExaYDBPJM9RGe0iQ0MVeMKrhpvGpFJhqm85Qtq?=
 =?us-ascii?Q?Gd1ku7oRc+ute0vep91cRTlp+Sb5MaPXvnE96G67OmHtIi7FQnIRw2YlM2/4?=
 =?us-ascii?Q?r31cL6HDComVckVzXvhzu/k3lK5p6AvdE9NPi0pzZBwrePuo+ClwIJi+fmt9?=
 =?us-ascii?Q?eqIxUDOSV0lMUhLiPlbvCF4Oq9AY90fPOFGfunIaZf8CiWNTksJxYXjFzzqQ?=
 =?us-ascii?Q?0Qav2ZGzpJuBGkE/hwg/yjF/PPyLEp/4u5c6zxaYM21GSiik/rauxyyK/PpO?=
 =?us-ascii?Q?MnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETcTRVpupJTBPlbCFGy8ns0aHvHq7/8/1n7d5kwB83wz1yyK0Odlt61Qm1Ns?=
 =?us-ascii?Q?CHPujE/7Qx1AhxENRHfUAxh/ezN2hn8U/zXM/tpJBDthiFEakeOlFwMtzyWt?=
 =?us-ascii?Q?lwHCOQXJvaYlnIh+W4MK9gq1rsdbsJXZqzonTl8v6tcng34OXoeYesd4IC4o?=
 =?us-ascii?Q?90kVYeMxDk+svnLnk1ZhpJglHJYjoPniEmvLuKPGjde2qbVKD1opvxEq9WFF?=
 =?us-ascii?Q?EM2FoFq4RD+CuLyhANO1Fu/fhZzkZufHS/taLyCtD50jEoPHpVXZ278EXYlW?=
 =?us-ascii?Q?mO4NfJhNJOw/giItxPeBbbeCkPtkFVJcm3awU/TtL0vwcvBB4Jku4+sALPcH?=
 =?us-ascii?Q?IHXu8lLvoajE2N9ROBJA8wYMUmYvL40zDY9PfD9Ipw89yfnWDX6w52fNnI1P?=
 =?us-ascii?Q?zIaUlGQoPSCldRDVRaxHAIqKlWKeaQI+L2GJ4YSw6vg+W33vfybAlj0cBCI6?=
 =?us-ascii?Q?B6ze7rqMpttQnvwNiAADeqmOXwftPWpHuJA774VaKA1WySWmW+IN1RBSXPQE?=
 =?us-ascii?Q?s3Pz6Z6krrcOVO2CqOYnDg6kRFUB23CxJDkCttMOQ0fjOHQ1982rzf4D6cyc?=
 =?us-ascii?Q?/g0aL+PmGWTZX+2cJoWcsCx/QUKnw8LcFIravGuMfKkOCk5nrbl+p7vaJh4d?=
 =?us-ascii?Q?lbplkJKJXYBF4ikNzYRO2pxHXjHgZ71ngfCMeDzyllS6bhyK5/pJwNjgrH6p?=
 =?us-ascii?Q?5U+AfU2tZTHOMLnFbuRo2SurkK5tz72gMxA1TtFCJfw5o6Z23e6/P1SqNbij?=
 =?us-ascii?Q?wrqE9DkqKXPydQhmUH8h1gVm4TRlhB6u5J06QMejwKlOpe81ZABpbGTDNlxW?=
 =?us-ascii?Q?4c+3d5XAx927bQITo+DdKLg4vskz/5wAwkI7dBYqGmP5ajXEvVFtVQ4Z4RrP?=
 =?us-ascii?Q?5JOSUWZ9XFeuDNRulZ/4hODWHuTY1mEAvyMi9aqvg5h8LoXHRMZMSH88/nz2?=
 =?us-ascii?Q?67A5+K7qz6CJVv58SZL3BJZHceprRIF/jb4JXlAlKjet4H223jhiYgtWA1HS?=
 =?us-ascii?Q?jFb77knYOhNCLGzdNhzPIZRnMLTblTCgr2mv5SecGLGceA81EOZ1SGS6gvUR?=
 =?us-ascii?Q?25AYZYY1AQdJRJHRFbDqG+E7TRBaPXLvLzlR7bC3RHrCPWDc03r/DaC6c8Gi?=
 =?us-ascii?Q?ceAt+7mbP++l16uVqspYYTKGYrlMMXoetA7DBqLsxFcTzsbdsoyqY0iDDNQJ?=
 =?us-ascii?Q?aLxxuWwzhbk66oNdr64nih83l9sFIPQkYxGwnjpvhzZtnq+coXmzyslrsCZC?=
 =?us-ascii?Q?xXtKK9XCM3zqZL7bS2BQw3U3f0ArlkGLbbMSqfRIgcqE7wC61te8USO0WyGX?=
 =?us-ascii?Q?3ofH+EBccpisXT8L/wWNt9k+jfYXwLh1FJ9ucBgDH8UZncWdeRHF5fuUatcX?=
 =?us-ascii?Q?JtaI4rgj/Hto4GMTPuiKwVY8rRmuxlOwq8Zm++uTmwrm7wO1aTUT/5ee/Pof?=
 =?us-ascii?Q?uoaDOuM83oZoHLWLrLysyTOjaxqJc4TLaNZcZp9UR96xHTi+uBPwU+fen8GB?=
 =?us-ascii?Q?ocLbn/88gr1Uj74aVuZ+RqgXedywwy46FcUC3GdxdyPtQ7Ws3kJHwH4ozc3g?=
 =?us-ascii?Q?lWFmvnn26Bnx5BRrUarFS2wogwMfsmKiiwtIUU+i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wlgpOcFvaOb+FDot9igLcFzTqtDCeEF8JzrkVq0kA3rtGXyATIoYJ5NVA+j1dAemXNtPVm4HLtK0RcjplkKkPHpmrZ2RwzT1CnYtRFlGQywC7xRbeOISnHEGnaUxDtfAx7++Iuvd0Tsi5gIpJbG0bE6Qytr2yN+G8zO0eux9h+7zHdi92VL07Zvv950zFjyXSoFSOhahjrz/FCc5vdM1YY7jQpgkjczZzpZm+S3Z8j5Bp1PWRER2AQJmNTNPfhd2uoD/6S0jTEs2B63KYYU9tvhZminjeokbVchQ6sUMV5qdoiem4L8wZcpF+mkRSZF+n/BKAsmhT5eUo19jCRC9uNPf4rN1j3ztq41hKGlMSG/JvbWjBiljkRfDH+AK12K+37ylsLzzTTo5h9AZ5xJczhFAROAkMppw+KYbWzKXQtq/oItI+PLppd4XoH76eCzZ2Wh/SGvROC1KKL0i8+RlWy9l/x+ctMl4K3ftJBffFYyuAwGZgL1cruNknuSzArSjDkTUw+Rh7pfuj1KJoMzHujnWyNXoWqoWMwbZVchrqydJsYsS85UfzfQyJXgVx/Tl4SXGJTiGsw9IMXsW6bnff18oSr/bTQI6fKLm26TaBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a580d2f-8724-489a-a5cd-08dcc79a20e7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:46:37.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1Z/pWky/bmNxu3DqUvegDVu6uYynTirD55M32Udwoi/msKOBtzVlw6XVOJUlUrrHbI/rM6621YxdxggNLuRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280144
X-Proofpoint-GUID: EJoLFZWKLr2gNlhSW8enTq2MyDWMjTRB
X-Proofpoint-ORIG-GUID: EJoLFZWKLr2gNlhSW8enTq2MyDWMjTRB

On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> Today it is the responsibility of each filesystem to maintain the mapping
> from file logical addresses to disk blocks (*).  There are various ways
> to query that information, eg calling get_block() or using iomap.
> 
> What if we pull that information up into the VFS?  Filesystems obviously
> _control_ that information, so need to be able to invalidate entries.
> And we wouldn't want to store all extents in the VFS all the time, so
> would need to have a way to call into the filesystem to populate ranges
> of files.  We'd need to decide how to lock/protect that information
> -- a per-file lock?  A per-extent lock?  No locking, just a seqcount?
> We need a COW bit in the extent which tells the user that this extent
> is fine for reading through, but if there's a write to be done then the
> filesystem needs to be asked to create a new extent.
> 
> There are a few problems I think this can solve.  One is efficient
> implementation of NFS READPLUS.

To expand on this, we're talking about the Linux NFS server's
implementation of the NFSv4.2 READ_PLUS operation, which is
specified here:

  https://www.rfc-editor.org/rfc/rfc7862.html#section-15.10

The READ_PLUS operation can return an array of content segments that
include regular data, holes in the file, or data patterns. Knowing
how the filesystem stores a file would help NFSD identify where it
can return a representation of a hole rather than a string of actual
zeroes, for instance.


> Another is the callback from iomap
> to the filesystem when doing buffered writeback.  A third is having a
> common implementation of FIEMAP.  I've heard rumours that FUSE would like
> something like this, and maybe there are other users that would crop up.
> 
> Anyway, this is as far as my thinking has got on this topic for now.
> Maybe there's a good idea here, maybe it's all a huge overengineered mess
> waiting to happen.  I'm sure other people know this area of filesystems
> better than I do.
> 
> (*) For block device filesystems.  Obviously network filesystems and
> synthetic filesystems don't care and can stop reading now.  Umm, unless
> maybe they _want_ to use it, eg maybe there's a sharded thing going on and
> the fs wants to store information about each shard in the extent cache?
> 

-- 
Chuck Lever

