Return-Path: <linux-fsdevel+bounces-54651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69605B01E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64EA5A4C1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421B2D949C;
	Fri, 11 Jul 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYcRjhCk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+sSQ9Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B52AD21;
	Fri, 11 Jul 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241811; cv=fail; b=a5zeNiINQ6VkaghpgTwZ11tl7j3NhZnC2ktAtMZkqOUv1LXjA9low9lv6XW6eoKCac5Eet3in27+Ir5DEOHvmyo+h0KSMDbH+rpk1qXKmf0YgsWrwE9pZVjvnV4sY7R8FXWW/ambs/eX7DZkPOnwFBukzZKfF8qpG5B83/VlQtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241811; c=relaxed/simple;
	bh=7jttiI6d6NKhrd/7JPQhrXyEIXALCTnBNIfDFx9tgKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFNE8vcoWkld9G/0h7R4ypQnRj3BB3ZKVWGlE7jOLL2jUulo4ET52ddeLG5UaDEUanNOspLA31Ft60iVApuiTTniZjDHnZucnCYT3VkhCvGSNvi6gHAHUf9fh6x5v8F8DLamWUl1krNTNV+gRaGunnAd84yeKzbVM4XOcBEoNas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYcRjhCk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+sSQ9Mc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDfjSN003681;
	Fri, 11 Jul 2025 13:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=79p+sCxmG5VHYA4kVd
	OBMaXeOuAYj/khNYvS4wSGfo0=; b=mYcRjhCkT7Z2XLDbtxeeXLfHoThn05VHPT
	pWE0Lc5kklA8hV4/J0WzHQvr0bshV3YzVJvFq2aG5H0xy4JYMeny25rPYM4yjV2Z
	nnZPQpWvTJVq7qiTRMEXmkDBqVarlAbOhPqhKlGSkv9i7/G3uVukJhUjDmPE26JZ
	3XHwXEvmeHb6qVY3cX3wgd+JoTRSJ9+VdtafjLyntpMXzBI9Uv8Xqwn9bzHRcIA1
	f5ZDipIz/3S5UCzRWSXZXKCfoc5pfHyncLgThMlLrVWfzChruvMYsiKxmRM169YG
	v9eF4xWYUcPArmUM+ZIfppRku241uFkM+Maoq2jMzurNdkHPDzQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3qgg0ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 13:49:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BCk3tS027243;
	Fri, 11 Jul 2025 13:49:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdk0k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 13:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKGI50zIGSdVCjPi6i8LVxXvxtUb4SSvnW/UtR3DMhIAd5B70Lgr/SYC7/qn6edy/ChRoX6yOYpNMMWgQlHDa+ZCrgDLp5Oqt+lf0ObWnJLvDgvmpBI1TipHVWAto3mJWtwhI4e/2+WE/udVvCLo3Ik3C3cr5uhtcrnSxN/oHaS/ODl2aXFm/y2uQpzEHJ9Qf39Ek4jWK8BNH9+qPSY4g47Hdjiip51ghFALfdyw54Cp+wgg1s7KlfTQa5oAQEPMv4XmlhqkFaEiBZRGP5ZuR+X8auUBMBjzv8BGoL2PsyDgPlzq/tK5oMNOe6nCe8YqhZDb/yVxnZn0c/u44prUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79p+sCxmG5VHYA4kVdOBMaXeOuAYj/khNYvS4wSGfo0=;
 b=kKEl6Uurkn9DBoG3fNzjIE6mkEjKNLq8NRsUWlCncXPAWiS/l4BAijLWcn5fLSwYws79YHPbYxEMq/LvBoKHnQkd5KQC+JkIcT95+MyvfnSwVuO/CsBWEHHYRiL8dYgyhNNYDfD25VwLLurWwoz0dx6ILg+5MqnrhSc1fKrrM06Yw4HMEBsfm9eTXTLdgNNT2Tbbmz8s8paTNpUdIDexj880T5jt2IVWBmuZX8m/v1KSmBZByuuxNVP0n6dSOqWinKH+H0hUi4rhNVW+GpCVPFZSqp0aPOmn3zySby6z61RtpOs/cE5Pjne3eeT4uAeRWLYM+Y/fjoJ5hSpbTKKrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79p+sCxmG5VHYA4kVdOBMaXeOuAYj/khNYvS4wSGfo0=;
 b=o+sSQ9Mcqyvj+hWg5mLY77NI0oL5X6mGCXb2qocxraa8nHHZ1EfZNrmbd+aqlrN+fnznWrDYUt1dAkIYNa8qqxrH6FiOF+YGskWryRxNhCEgDHncUwJ/A1Urs6J2wi3HvadFSQ7QydzLlXkMGxmMYAHf3KWwITUabPjWJagtWHk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB5921.namprd10.prod.outlook.com (2603:10b6:208:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 13:49:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 13:49:30 +0000
Date: Fri, 11 Jul 2025 14:49:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <c9a86e07-1671-42ed-85b6-0b5fa4ce24c0@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
 <dcdb3478-68ea-4d9f-af4f-2f5438de45d2@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdb3478-68ea-4d9f-af4f-2f5438de45d2@suse.cz>
X-ClientProxiedBy: LO2P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6dd14-1bab-4f51-b0cb-08ddc081c276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRp0ZCYDTgmwusz56tpAtFCceA6IaGaKU/+tR43GbPQ6eBf37SArC3IjCpin?=
 =?us-ascii?Q?c9C0v2esVW3EbFUBZxpvDVJka+X0FbtBE+7np9pE9x9YrFUx8huSTXDekt2f?=
 =?us-ascii?Q?GSttnR9rJwvMW4iBZukTy+WEyhjLZJZ+9PBFel72TJl5mNMNyRIY+VJ8eJY3?=
 =?us-ascii?Q?Bs2Su/XBpPmTHJF0FhY0MbbrvGL0X9LIntF3ctWD2IvN2SZox4V1ofyqpWSP?=
 =?us-ascii?Q?PwkREiUeOmAE49AL2n3j2EACHpPu+hx77KygL61hy8AypbUaBpgZkA0URoyX?=
 =?us-ascii?Q?09bF9ABHrBhlPPVTURw4jUm24e+FLEvYPOuGPB28YJG0iBgkwL2btlwAX0QH?=
 =?us-ascii?Q?PPJ7oe4J2OQMJIkVwJuRzR+ZGfPE+DEKqcJWP8PnIdse/HGgQ0FaPA0dEkQ3?=
 =?us-ascii?Q?ShMDHOmvNkR4MZE52BwgFtrPGkOrVx9ujSEh7G32CJMStEj0AP/SVR84YvSV?=
 =?us-ascii?Q?wuRevbzLnklu2BGQK8DNCE7UjUBhBP5bwog/9x6Y3PURFe8dd7HJDmMolX3U?=
 =?us-ascii?Q?5RzxrenO+c8R5xhdtS0HanH8n8r3k6TRzAUSKu+svJAAfed4BazpCs1s8dp5?=
 =?us-ascii?Q?dy8Fh5Do1fSgQYSr5WdsLM5hsGwJKbH8tSaOHUYnjdNCxKTN7G8Qqa5+eK14?=
 =?us-ascii?Q?xzMdt9eaMFBbBTJxavfFADEC3gMDDd0nt/tgPU4kMgVgXN+7fdvUI9CkbpWP?=
 =?us-ascii?Q?CfV2ihtzSvuf4yloGFnbm6Hae1zxPiJRv9IYGAy+rScj6OzsA1o8wKs4aZj+?=
 =?us-ascii?Q?fqusblHmGUYm4Nvdg9drggNGRkkNO+IxfxayOILiZpkKuFJZ7C5BapWNOf3+?=
 =?us-ascii?Q?MkXPq4wilwRq5V4WB2sMz9Xnpio50lOlUTYPuBibCtT7F4bQGeoZL7DXD6cV?=
 =?us-ascii?Q?ZRnDXxxdZ5w7Qypf8jjt+6gqWOKvc+P4FtXiFDmQefnLfN1dwXL5wggMeqUQ?=
 =?us-ascii?Q?C6RMicRCZAQ6Wpvu3Tx4IyWOr6/7M7YhbqNqtIGrBPf5RmqI/jEhWPRqhQ0a?=
 =?us-ascii?Q?uYiQ4JEpBzlccKRIQXQCZpTSB9bOn8MV+RxI+zDCy+ljspj3I/uI4iPeUvtc?=
 =?us-ascii?Q?lHKNbjjg5NxQLNg+pZmTaQrNz40P+dmtQMqDsJ9QYDLNpk090ewpXX/1xJ0R?=
 =?us-ascii?Q?IMAphMT9hWuzpftceKCISuwYgil7bHGpsCHvE6rw6CuZmMg/wp1w8KT30jYw?=
 =?us-ascii?Q?SMqZuUuGuug9VTFhUcR2V2zZKmIWXh30pwLa5nx81U1eWDWAo+5Lz4ya6Rvp?=
 =?us-ascii?Q?u//zYNbAFlwNHGMDOshOomDvXM9XmipisCOExskVLMTfOKQhqMHH++7CUEiZ?=
 =?us-ascii?Q?b6NQCLewP9aN8zJ3G2ZbtDcp7mA0aGSDob9pJTjLEv+qe3rvcG1N93D9oQDh?=
 =?us-ascii?Q?grXKRY+kaiTIS8K978cMd2ZQKkUPeaDMF07i1Sp9P6hHx29MeNBmZoYwLCXm?=
 =?us-ascii?Q?i4iyEe2l4aA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pYYGMyWku/Zmi49Peq5+rziwXbEO2VPurXyd/p++a2Ipa2yDCueW9z1ErRJ?=
 =?us-ascii?Q?G5P3tXGuRId6ckD+8fekKkUQaWaVRJGcZ/Wvm6CuWvf5DPuqIqoJe0oPv/KE?=
 =?us-ascii?Q?op4TrgUDctK/QgfoUTR+qzvjyHs7/wRsuhZtO6GtoIJc/yc50+rlnJiA8Noi?=
 =?us-ascii?Q?urJT9LoA6WwV367zYc6J6V+UwS4oIade4gG3N59zramiYZZzWA/Aj/5uQMJ5?=
 =?us-ascii?Q?eASlGLeymnCrLXojmcwsKE0+ByjpHGaYsOhauKR4LyZhp5zaW/Mp6tATNa0K?=
 =?us-ascii?Q?ISjAP/2pesbl0OkFlueU/qpxuQbRdV3rzr7ooahym2xjZK8NXaLbtBjwtIxl?=
 =?us-ascii?Q?yG4X66dHVE7R5I8aqCPkpq0GVG7tuv9+3S9/1dYJZWW69F/a2yMXavfXqgF7?=
 =?us-ascii?Q?sW0aB7zhubOsEHE9Pf7G8hoY1/neKQi8S1MjE8KJiX0c7DB1pJfEikIhc50I?=
 =?us-ascii?Q?UlnPIoNHTIXZm4CxgMFBQfgAlRo0k+33TsBT2yIEsOOug4BMMyMwUWTtEyVl?=
 =?us-ascii?Q?McmtRdB7GsQKFrBIBhsvZlPQPXJKeZc8C0lyWKE8/Ql/OcH7QzfV9v9yons4?=
 =?us-ascii?Q?vBGziVWuIUlJU9SO0vUFdVOuBp69xfIN5rd2eAHpbqpSW1ml1Zb3hbDxyUJz?=
 =?us-ascii?Q?sZy5WQoypj1QFWe/PsuwL4KU6RYcSuOzTb456PTYQUmnfByiMM1YzIDVwJEW?=
 =?us-ascii?Q?7CnQ55BvF8GA/xnRU/fixaLV0slVIS2iPV4GBL54h8oCXOdWj5ozGXYU2EV4?=
 =?us-ascii?Q?CJpcRhqgWGiHPohSIPKD8zHDmPcwgA1/U9ZuSHVUMnY+1/abDCJjRM8KldVg?=
 =?us-ascii?Q?YgmbNNlsS1OnT4mWC1NCEG9GhRybZeOIro09xevCT3cD9IliWKEEhqGfHfdU?=
 =?us-ascii?Q?Cd+ChpOCwtsMJnDKWcssoHybv0bP1ySX2YUGa8u4jqvzfwzeNv9nlL4VPOVt?=
 =?us-ascii?Q?IuSbIX+lwFNdGnsVAtefpBDd48Uax/efnL3N+N6HS/tvM/7tdVboVcerlMpD?=
 =?us-ascii?Q?YD7N2cS2k0f/zdwQ4mTG49wiNIQztlqPmmHOyt8ZfmA5gjN/UJvaubTllHYh?=
 =?us-ascii?Q?jQnmJXOO+U6y6A2wUxAs0UOMn6JmA7COUcRXI+puo5l0Z1JhQRJAXH5SevQA?=
 =?us-ascii?Q?fT+GCHDUJQhWGI9OlDYcrTmN0FpHjOutCJ++DlFY+Wm9Kt03E5MbVCcVEF+Q?=
 =?us-ascii?Q?v6ECnApkrdY9yza0E700I6HDPM6rTKisLIA2wYK19jaV+mJPSr3UTFXLxyzL?=
 =?us-ascii?Q?W/s3KQ5WzyS9sWiLqv/JlzMhkBNp3BkZTWlsBzbV0mBwAn2Rcw0UlCNgRFmg?=
 =?us-ascii?Q?HZMrML04CuDGDw+/fzJhSL9Z+2d9Wr941LTo6akpOCusID3m7mOzx4PLzZPH?=
 =?us-ascii?Q?fiDV8Erjk6ynDTvjZ8lirsyR29INBDTaxxWIb0k7+aZ8dorWHWWrg5Q9G5Go?=
 =?us-ascii?Q?rSZFs1eD87l8yAiLF8aR4k8tqR8I6y8M/8I9bzd2jrz8uM56pOqX6P4Lic5Y?=
 =?us-ascii?Q?tulj3mYvpL18x56ICR903mddH3BlMAWZcILzGgDILVJqa5qvqmqgWbiTGBDq?=
 =?us-ascii?Q?b5doxW63HggHEFK6iCu5laSZ8d4JOhZ6/QNBdVV8a7JBT+yhNqRZtbk0pteX?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6XlDU9cA6THV8AP2ib3QNIzzEs7+LptX8r4BnNZfdjvKwZCm3ZZNVxe7/BI6pfhted1SEJF5TlSW0/85vDQAcoBktbTQtJsNsCtTrnXb3BMqXH4wprXq3LOuU2yKCo+Q31uL/2I1ooJ8jtPwzCpLNh14pcRoeL0Vej6sbSEEPE4oPhRlUuBPndU13NdkUq3c3p3Dmt4iBNIHQjUkJEUU3KL/43SBsoyg7FTG3qE67dKmPFxSHcft9MQ6StAdktedNmoVDMrECJYYKlRYiKw08AQQFOSOyKBWaehgbpkWjwOR6WApoUYXsL2KybDIR7/EsSfAfGEUFoKHOo05s61ftpmUbOFswCqaJIo6f76UR3r5Vfm8HbkMsprxsiaZtDsfmtok1p4q97d1YDpvH1xfr954psgQLj6J3t+dWxIwuWXgAf94ZWnUitNWPIZEGW7R44ywKFMhJK/2b0seWxgi4EdTwE4jaghfAGa6leT8jCHIJMVxZJnqcxMoydJAzctQW3ApIOYL3+QSI71qOE5WQ9oP1xLI2eXHMjeeJxSrH7xsHPGeSSbScXTT5monT5q0LcxRVlqiaGfgUkrgxLQaX/1qKjmlXTT0Q1N03SGSYOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6dd14-1bab-4f51-b0cb-08ddc081c276
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 13:49:30.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scQB1LLkgLT13XSl/gStapW3yD0AdYyPjp5wOvULa+fxajXvXBYhZ2wOr5AMsHuH5c52o7KPm6CF6F28vpDVnHCfd9SxFG2rt5yY/+tS6U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110098
X-Authority-Analysis: v=2.4 cv=BePY0qt2 c=1 sm=1 tr=0 ts=6871166e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=4S3n3rvaFqOYAIcgfNUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: mQ_j0B-XtMzHiWOo5Epy1Nha8E1m_RNY
X-Proofpoint-ORIG-GUID: mQ_j0B-XtMzHiWOo5Epy1Nha8E1m_RNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5OCBTYWx0ZWRfXyL4yeQksX9s9 xEpCbD2b0pJKp7Iuq+lCZmLOzzhB5pKL1FOuqPEDLXDS92eSo8rD09AmHU8chF7LrhX48NcP9/F 6ybLhjGGlllSpNwEIsBuCgrhuINGYMxIjpdL5knZVoS5xAuOVu7K05ELcd4bP9tIjWcxOZix+lM
 90Bugv4H8TEAfOwpVvRu/u3H1VA7OwuSMePP/NCpouap8fb5FIA2dZ4DLmB3dUG4shHq48RcvCq n00uNpTLpqSD3g5CTMOy0puqOnMtdTQoDqLKkIobHmk3T2gBxmewGIbU5EijFkgbV5H7jDW/DdK DK6IjiiYQZZw6hVVNK7lFBHmJiXU3OBg4Vdc9Z5AC8LklMSgd49O12jCDNn2iLZok6C3gUE5n1H
 R1Wwqd2hMh4loLZ6FIZQAOmK0suUeyq0Nus8ApjqgfQ/n+RfaDqkjDTsyfA3xWMeTEy8taDB

On Fri, Jul 11, 2025 at 03:34:23PM +0200, Vlastimil Babka wrote:
> +cc linux-api - see the description of the new behavior below

Ah yeah :) I sent on 0/10 also. Friday...

>
> On 7/11/25 13:38, Lorenzo Stoakes wrote:
> > Historically we've made it a uAPI requirement that mremap() may only
> > operate on a single VMA at a time.
> >
> > For instances where VMAs need to be resized, this makes sense, as it
> > becomes very difficult to determine what a user actually wants should they
> > indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> > Adjust sizes individually? Some other strategy?).
> >
> > However, in instances where a user is moving VMAs, it is restrictive to
> > disallow this.
> >
> > This is especially the case when anonymous mapping remap may or may not be
> > mergeable depending on whether VMAs have or have not been faulted due to
> > anon_vma assignment and folio index alignment with vma->vm_pgoff.
> >
> > Often this can result in surprising impact where a moved region is faulted,
> > then moved back and a user fails to observe a merge from otherwise
> > compatible, adjacent VMAs.
> >
> > This change allows such cases to work without the user having to be
> > cognizant of whether a prior mremap() move or other VMA operations has
> > resulted in VMA fragmentation.
> >
> > We only permit this for mremap() operations that do NOT change the size of
> > the VMA and DO specify MREMAP_MAYMOVE | MREMAP_FIXED.
> >
> > Should no VMA exist in the range, -EFAULT is returned as usual.
> >
> > If a VMA move spans a single VMA - then there is no functional change.
> >
> > Otherwise, we place additional requirements upon VMAs:
> >
> > * They must not have a userfaultfd context associated with them - this
> >   requires dropping the lock to notify users, and we want to perform the
> >   operation with the mmap write lock held throughout.
> >
> > * If file-backed, they cannot have a custom get_unmapped_area handler -
> >   this might result in MREMAP_FIXED not being honoured, which could result
> >   in unexpected positioning of VMAs in the moved region.
> >
> > There may be gaps in the range of VMAs that are moved:
> >
> >                    X        Y                       X        Y
> >                  <--->     <->                    <--->     <->
> >          |-------|   |-----| |-----|      |-------|   |-----| |-----|
> >          |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
> >          |-------|   |-----| |-----|      |-------|   |-----| |-----|
> >         addr                           new_addr
> >
> > The move will preserve the gaps between each VMA.
>
> AFAIU "moving a gap" doesn't mean we unmap anything pre-existing where the
> moved gap's range falls to, right? Worth pointing out explicitly.
>
> > Note that any failures encountered will result in a partial move. Since an
> > mremap() can fail at any time, this might result in only some of the VMAs
> > being moved.
> >
> > Note that failures are very rare and typically require an out of a memory
> > condition or a mapping limit condition to be hit, assuming the VMAs being
> > moved are valid.
> >
> > We don't try to assess ahead of time whether VMAs are valid according to
> > the multi VMA rules, as it would be rather unusual for a user to mix
> > uffd-enabled VMAs and/or VMAs which map unusual driver mappings that
> > specify custom get_unmapped_area() handlers in an aggregate operation.
> >
> > So we optimise for the far, far more likely case of the operation being
> > entirely permissible.
>
> Guess it's the sanest thing to do given all the cirumstances.
>
> > In the case of the move of a single VMA, the above conditions are
> > permitted. This makes the behaviour identical for a single VMA as before.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some nits:
>
> > ---
> >  mm/mremap.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 150 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 8cb08ccea6ad..59f49de0f84e 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -69,6 +69,8 @@ struct vma_remap_struct {
> >  	enum mremap_type remap_type;	/* expand, shrink, etc. */
> >  	bool mmap_locked;		/* Is mm currently write-locked? */
> >  	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
> > +	bool seen_vma;			/* Is >1 VMA being moved? */
>
> Seems this could be local variable of remap_move().

Yes, this is because before there _was_ some external use, but after rework
not any more. Will fix up in a fix-patch.

>
> > +	bool vmi_needs_reset;		/* Was the VMA iterator invalidated? */
> >  };
> >
> >  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > @@ -1188,6 +1190,9 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
> >  		*new_vma_ptr = NULL;
> >  		return -ENOMEM;
> >  	}
>
> A newline here?

I kinda thought it made sense to 'group' it with logic above, so this was
on purpose.

>
> > +	if (vma != vrm->vma)
> > +		vrm->vmi_needs_reset = true;
>
> A comment on what this condition means wouldn't hurt? Is it when "Source vma
> may have been merged into new_vma" in copy_vma(), or when not?
>

Sure will add in a fix-patch.

