Return-Path: <linux-fsdevel+bounces-45331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F76A764EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1111681B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4D51E1DF8;
	Mon, 31 Mar 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2n5x9F1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vYI0FyGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5613A265;
	Mon, 31 Mar 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420433; cv=fail; b=WdFjufIFK3HZQFsgr7i+XnDENOHjxn3hvFx+2C+T4A5ytSuaQ2QRQHmEXNwrC7Jh0HNAk148GiWUl8VIjxGpqkA8YauEGb7ciV6/9ACel5ELg8vYfzlnQIWFIedUtTU5PxqjpP2iUjaOdvVt4ktW99QySR7m9aMs2bgojkaX83U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420433; c=relaxed/simple;
	bh=hSMQnscFjG8sG6US6A7mYyituRPd74JfiM4Fi4Zox/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePoMwAa+CR5Kg91iZBTv3qymFsQ5i1zAIriaGHcsmrlvoa+X80Ps00PUgrzPVbuvVyduBrNktpJ4H5pnzREaHjIQv8pYVdUZ0vVaaRerB0ScRTWAhxcx0jd7muUTJzXm4DUn0KjAkxB/MczrjRjUcSzHPqPZc6PF5fsYEGV9FUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q2n5x9F1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vYI0FyGI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V3NbE1021882;
	Mon, 31 Mar 2025 11:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=W6HdaQI7yVZroLD1oc
	gDSXGttzSW3vH6E9300TcmhwY=; b=Q2n5x9F18AhosGLcj699OzsWU8f8yMDtjG
	3DU1bfA5l0kY42xNyEN9JCB4LCe0Rr/K0ELA850LFo9UQ4f0xJmZAN0hnXmf9C9d
	fMQCt1riBNla4d3U8/DpgexwvcYshGOEdxwlPrDwOHrT9XpauIlfgGGhhGAxp/PG
	Br7JYpugi65Jw69HJ/GkHYfHwYmag/n+6xn6xtltidRbEIrudbCSgFndtYzSGql3
	HoX2ySv1EoeB18/3JznTpKBozC62UF8p6i0YJhuHdOm9vQGM/vX5vszvK/6k1Tlh
	iPF3ggIeQGaQExoeGWPdHQ8SeQg9FhCId0yDpSU+d0aOWD3UECaw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs30qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:26:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52V8S05w016937;
	Mon, 31 Mar 2025 11:26:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a7j5yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUcFJI7a/fSu1kyS6BqhkzZ4baqtukeryLbQTYzXDI07HVdXcZj4kR1bV4YFShZATkGJVlg71hIfhXkqe/irfvtEPItjfx17PQbi1ZOb2zMeJenV6InRnWvqNg8pU0s+RF6T1p2Gwv13KlmfJ2oNSge4QM95qCrsIYU9z/rHHFIP9kAbuUPvfhU+L6VCeoNlq0nPFPIJi4tqKQ6hSYljbYiMYTGN2QWnI8ECEymo5EKRC52YUvzCtxefAEOZM0pG7H4H6LhtLDR+uXBoVuzjyPa7j+Py4zVg5EZ36tPZb63Lan0exWahVxt/B6SbUuLRuDXSEiqEZ0QXivFafXEqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6HdaQI7yVZroLD1ocgDSXGttzSW3vH6E9300TcmhwY=;
 b=H2ID1RT45/rOCYEJRILIGsoh5pV/IiddVHDuKcUWa6Y6JGRPr1KtjNy2O1P8WPl7L19VIphe/VtQ/A/ZJrDEnzk5L6teeh9zO+QlLM3rzaU6GrlYO+3A+YxjRvvcWY4Lg4TywtNGDR0BLoL4IJprwE1s3OZ/Fvv1Ic+NHj5bw+bL07o2gL94ledW3NWvSQcgQeUHSkQ0ecnsbCPyUMD1tQE99I4dZ//mDbFnWTl3P5/HuoKqHsLHTYnJR88FcByY7P0pV4X79x4Ur5etK5c7lXPBkuqrTRnlX3Zb9P5veg5hDMGzawSJGJYJlpgTrn8UcVHvGOBVFAKIxDtE+imFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6HdaQI7yVZroLD1ocgDSXGttzSW3vH6E9300TcmhwY=;
 b=vYI0FyGIAhy0T+bF20xC1IGNxYaHTIr6bRYYDAFQIxHhzAOEEDLeOeQX/LqIYQ5HQltf/mdBg9IuWQJF5tdluNy2xJ/P6f/UGxoLumDS3UjKbcvNamugZMalYa8jr3oDPn1RxCqKYjnaYeKODSzbtMRIV3Ip4ZszXBokyxP4Ffc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Mon, 31 Mar
 2025 11:26:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 11:26:43 +0000
Date: Mon, 31 Mar 2025 12:26:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        criu@lists.linux.dev
Subject: Re: [PATCH 0/3 v2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
 guard regions
Message-ID: <7263e869-d733-44f4-bd2b-9c6f89202909@lucifer.local>
References: <20250324065328.107678-1-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324065328.107678-1-avagin@google.com>
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb10a67-d7f0-45cd-b757-08dd7046ea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NJOHKjDCjsOt3oWeUg2b+pRdRydC0aqOebhQo3kzkG+UaMra2NPCx1tA1BVC?=
 =?us-ascii?Q?d0fyj1THx72olk741JGS0l2n/7otwkJD3z0FhDU02IVT5pb3ZAl4JeKcLEVR?=
 =?us-ascii?Q?QV4RgOD57JPw/HzCAKi6/SdCbwykVoEWpmI6WcrXuyKT67Op3Py4zanHAYf/?=
 =?us-ascii?Q?3hXH1SItcEpnQ0RKvjPePlD9uEOeRvWujSAAeLVcBk+CbK1lXyVZK+ofskNU?=
 =?us-ascii?Q?8fDBjGVGzCJMzqZFIqTDG9j0/PpVtClxXsCsNmnM15wnqdLsXuQBCIiaT2dP?=
 =?us-ascii?Q?S8nv49vyHnFS7afn9N2aHM/JZFRrfuGrMtMUfvzX38JdasBunECVDV/g4q6h?=
 =?us-ascii?Q?ELFG/Gd6nLk8wrXJ8UOgbymFbMjhzLyrbyEP10LuUr7Br5YpFB5xqYw7XmnZ?=
 =?us-ascii?Q?iiVc10LeOKSqg5VWVIj5LzA3FP+oQQcE+61pRZ+gWyTEGMHLiOhofAqDzM/p?=
 =?us-ascii?Q?FDS59k3k1Y42Ck5kCgU5zyA+A1y3oRO6Ie6e6CXy/1P53+16IEm44Oxkf2rK?=
 =?us-ascii?Q?GjyNKX8IRaR+Lezj3HCYy4ojsB2FK6HqJ2hdkhTNbqefr6ru830BBJRDPhMc?=
 =?us-ascii?Q?2H/fO/pwrTgYsnZz8mTRYDVXhQt+hUGy0bYP4aD2Z8wkXUvWVG4G7nK26RlV?=
 =?us-ascii?Q?gZ1rEKzgfgRtNLYSquLyy8rJIeCFwfFRfF8KwF7ywOGHxGOIDj3Ht36jlbdN?=
 =?us-ascii?Q?QCK9GOY/e9ACsejfKG2oq8Aevo3pj2NWM6OmIoiRsTdEWm/wsKI08up4Lzie?=
 =?us-ascii?Q?ECis4rH99ve4ORamEbbgfpAdNVHaTy4dyhlRldFrFQP7lbyBMfqydcwIhl0k?=
 =?us-ascii?Q?KrmMNmLNFMgNHmkGyJZHdHPkDwpRjSwacjF3qwtDFMGB1E3UOMTr7mwB+OWW?=
 =?us-ascii?Q?T7PehcU3eAX82Fj/yd8jcm3RWa4yEv3GJXVqkyesnp9N1pmlJYGp2lWQjgTT?=
 =?us-ascii?Q?h0Nr6fUvv8IplnYS43z+N9IM8buyXMhVVMh+h4PwN9t0VfYtrR8kFeyBYbo5?=
 =?us-ascii?Q?c1d/chS/WMlH/Kx0QkZR/IacF65ZvU16inEvT1GgEfQrSGGguZWQIT3dAtC8?=
 =?us-ascii?Q?tnVNcdaXSeVx75QKQo5Dkoj0z1FYLkNhv7O3QI7Of/Xe+dFIpuUlXqVdQKVz?=
 =?us-ascii?Q?uQOWZBbJ22eFcwYE028Q1Tsxj6T1/sGSEo8suQkCpR4VwwKQn0ZHF+xNQqNh?=
 =?us-ascii?Q?uqRMIgOoen/2y0bENrqP0W6h9RnIXvJn/iqka7oPifvhWwqMqGDh3dkBFSZR?=
 =?us-ascii?Q?jjr5Cwi8+6CldHJRjoxrSP3NI9RFXzmaYZeGvD94xWpEVkPzPMBe+fNIBgpI?=
 =?us-ascii?Q?v53WworsC3oy22lDIlNo3tzCnv+opqD70gjBPqS3PA/Ssj9NVWoIdG+dG/bY?=
 =?us-ascii?Q?YWx4fqnpzCMxQw7DOtSruoeB4Evo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0azGjZNCo6KRe/QDVrYU4jes34qkc4vUHXeJz7VkCM3P47A4jQqjHMmE6H+K?=
 =?us-ascii?Q?E2vmb7B/MICtOqkzj5nXGU8+x8VgPOjLQxLmKS2U1Pd0NY9zZ2E7Zyjmwkr5?=
 =?us-ascii?Q?evFGbky1yDf4m3kijF8rMNbQnffaJqOP1Grpauzah6Iu0zqk421HpGtGjlnn?=
 =?us-ascii?Q?NAgsvh4If0WW4QGsmBX7ApW0QDZAwxoNvEWa0gbGzby/D/vgWupNnZIANNwd?=
 =?us-ascii?Q?QKwUbU6TOuCRMeS7sdzZVHGi50ssXU8w9Q+pZMCslyL/OZD2aXBA+ew8vDgK?=
 =?us-ascii?Q?pygCsAr7jhCVrt04jxWODPhNYdVSIYrQua4hMK3Zy2whImUBNFmSFAabE6Zd?=
 =?us-ascii?Q?vg0HhV8+5XlbjAOzZUkAAxZRWPiokC47m1aY+/l8mdspq+Q2IZjMj8dclpJn?=
 =?us-ascii?Q?3MlSN15iJfiH00YeVR2e+ueig0tzYc5peL2jmzhgLb5wy8HMaZlS0rOhONGU?=
 =?us-ascii?Q?616w+x2E+0cSRccAAPifGin1Zs1W0laEh9L8fVEZjqZ716KHbOpCpI1C1tn7?=
 =?us-ascii?Q?IzwxC4x8m3dtkiNLD0u8iJB2ThfnHctYXasNb1eQ+08S6KDbosuMwQrpTazE?=
 =?us-ascii?Q?C8h2Weh0KJfq36HU5GO8Gpu+4olPH9oOViNVAzAdSaX1ptq6Gapn/QHbgGHJ?=
 =?us-ascii?Q?sGkaYdqHNsHrBvujgpjHAnn3fe79ZFKxEkZt+7iJ0u2eCsB8pMC33LxhKiHx?=
 =?us-ascii?Q?NEenmgUQXFrqFVftRMTrwyxWMNYqC8IwLC13ifEuH/eQv1kLt86QTlch2FiQ?=
 =?us-ascii?Q?+MjiebEn4vEHbRtsQufZGLv/J64iOoa1hT0B5FkVa8SK7TJcIX4ZU5ziThAX?=
 =?us-ascii?Q?Dtfa23eLbWa9a9kMcu1TLMBqxtbgOI1psCgI5kRLDJy1ja6nzzPhR+pLy5XH?=
 =?us-ascii?Q?RrZBIybKAdR2+lZGgbkN2RZP8F0DOagr7FuCEPupVtwsq9VC5lL0Vn8MeYrA?=
 =?us-ascii?Q?noQMqINeu4g/YVWkO8tL/+2/RlAQ/HOnwl8tOkMbLeeY3BJ+5HNtNM0XuTB5?=
 =?us-ascii?Q?QyhjtBh0Eu1YqXbn71oXsSX48cxtQnSQ7bbUXEbxa+cZNohtoVc+v52T4nQk?=
 =?us-ascii?Q?vfJYflcanhc6hwl8tYfET4OdwSQK8/W7xN5wv5OJbR1KG5K4hnFIww3+2vz0?=
 =?us-ascii?Q?/dJDphkJgDOe5IOZwVnXqN1pVn56A/nQFi0KHZCnhpb9T1hQW5ptBk6zA/6r?=
 =?us-ascii?Q?0qn5+9osJvLW+/AfyepjHH7uDO94l8ygEZHj7Pw78Bpcc6f9vZ77C94lZjnj?=
 =?us-ascii?Q?Xva4MWJeWFaZZwBc+77oMu4e9NgS3p1LJL6fM4Zm74e838R5NMlTQxqmqFX5?=
 =?us-ascii?Q?vQadElGNtY6mRwCf1oL1pCk8IolmZAmatCTxH+rXKop2LaH0NKSvCY9qtfIe?=
 =?us-ascii?Q?xw5XV8tFDF9aHy7mLRIb0mDDBJxZ97fiSalYdUqjCwCx5KqdMgbrtbtPpD/I?=
 =?us-ascii?Q?d/XwCI2DbvkArXAyfWOcGOrgIw0+SPOVVDjBONG1iYhuB8EqJYrZzIAs0YGg?=
 =?us-ascii?Q?6kpoB9RWKSYVoT3yesoJDxiD3gTU+J/DVbKn5fQBcQ6dO4XV7PNbej9K4t96?=
 =?us-ascii?Q?v2OhkDYO1ufNBDHCP5p1nOpUlQdD0YdRYk9sNzit+1zcHE5gNjfEs4i44ujt?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bc2HUAnC57eyyc6/s17X7RVOtTFWgTbSjACoYcLXzevL1uhwgXQ9k7HBOD1shRz91dcV27CxGbM/3RNbaa+WzwgWBaJU1Kw+9hqa0/JRT/HqkzX1lfgJhSaOu2KBNGoCFMgJxIM4zOgw2ludJ7h017xjvdXB1tRFgEctzD+H2gvqL0pBOuOcyKZOtycucyXeY97PwcwNktWH0oovOYLpLoQfsWIOPswJIKLmpc2n411tDh3WA9651C48Z0fd77iSOkqTEVFOfxqgiLmBfZpbdDO3cn3fgzhNhENxCMuOb11IKnRp1iW8rIVkjRSNkxPQx/uUNbuEieANtgKWsj0qZhScpVBDCgYf0y1hUXQ5kjT0640oU66HmROf2cSTP9tohIy5KoLg8Zqz87YiZvxqYmrhbe8RiXsk4D+vALl9zTQPK8bna3Ltw162WX2nDzUuMpO0UswtkiEYONWBiRlIFrqFT9vdpBCoE0YdV2UFvELfgsdepPNudQSJpNtgyOY+SrWFVEPOT2YUIoj9WfPjq81avM4eVmucJcc4GOc63n7TVWj9KotZxprybYd9JOgN/FY+yWbwr9xr1KmvpUOtI3W5NvVo3M4UF5m6eHPtvbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb10a67-d7f0-45cd-b757-08dd7046ea1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:26:43.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XG1AymnjIAHLcjOZzTEnifg659AZx4bu1vMSK4E0Kl9c7AEbTmcubBXmcx9hywRzBfhp7umgmVp4jOE/MFalV0FuVqp3CTefEbR1lgR8+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=821 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310081
X-Proofpoint-ORIG-GUID: 4amMDmltpN2i_s1FVFFp_eSrnikSpklL
X-Proofpoint-GUID: 4amMDmltpN2i_s1FVFFp_eSrnikSpklL

On Mon, Mar 24, 2025 at 06:53:25AM +0000, Andrei Vagin wrote:
> Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
> information about guard regions. This allows userspace tools, such as
> CRIU, to detect and handle guard regions.
>
> Currently, CRIU utilizes PAGEMAP_SCAN as a more efficient alternative to
> parsing /proc/pid/pagemap. Without this change, guard regions are
> incorrectly reported as swap-anon regions, leading CRIU to attempt
> dumping them and subsequently failing.
>
> This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
> add guard region bit to pagemap":
> https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/
>
> The series includes updates to the documentation and selftests to
> reflect the new functionality.
>
> v2:
> - sync linux/fs.h with the kernel sources
> - address comments from Lorenzo and David.

Thanks, sorry for delay, LSF/MM/BPF is why :)
>
> Andrei Vagin (3):
>   fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
>   tools headers UAPI: Sync linux/fs.h with the kernel sources
>   selftests/mm: add PAGEMAP_SCAN guard region test
>
>  Documentation/admin-guide/mm/pagemap.rst   |  1 +
>  fs/proc/task_mmu.c                         | 17 ++++---
>  include/uapi/linux/fs.h                    |  1 +
>  tools/include/uapi/linux/fs.h              | 19 +++++++-
>  tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
>  5 files changed, 87 insertions(+), 8 deletions(-)
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

