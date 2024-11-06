Return-Path: <linux-fsdevel+bounces-33805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F19BF191
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99871C23549
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A92036F5;
	Wed,  6 Nov 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fb5emkFN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSmJTpO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D17202F76;
	Wed,  6 Nov 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906727; cv=fail; b=XWqf503l2pUHEdLwOIO8sGJSzpxOcuwYxmfS87m7ZT0ur1eFAVQLpQ60sgVO8T/aLJMYAmOn6QebofWGtVvUyMPwnECbqI3sNo4ocaCxVRE2K7RTCqW8MFJnK+196psC3/Au6hZcpsE98q1f57qcQbJxcKw/bUzgN4qpVQ6b+Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906727; c=relaxed/simple;
	bh=pQL4VDqnj/mM/gg3zdxodDnFci1Cc+DEAXoQYM7CwaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STZhzZrHZ1BKdM4Opnuw6tUVmm2MO5uUJQ4/JTN8r1s9/HL0qe0ucIpRvbsU9ISE8rIhY7uecjEUi9oXFCyXXhzkVTl3RLcES09s7/5K7HZ6nagTej4cxQGveglHseOKwwLzedOVDhZfYlZVFN9jcpQZSr+9AvKcbCmjZHnfdnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fb5emkFN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSmJTpO/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CiPpU008266;
	Wed, 6 Nov 2024 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pQL4VDqnj/mM/gg3zdxodDnFci1Cc+DEAXoQYM7CwaU=; b=
	fb5emkFNakiAaDb5TuPQgWi1W4Ey8Yssu4LrCsAaqKPwAY7xdGkmHxirK9TffsBn
	BSqUHye25inCL78XhoTy+B3ab+7Op89sowZAQJTrJ6QWuDHVLlnPFziU9BXYPSTF
	XztH01hH0BmfsmNV5lNZyapH8i0PxxfPOto6qkVrWuuh/8GGCeqnKix2+ubAH7Sx
	YMRwVBDXXqP5tVXR8WeLfcb/9bRGUfNXQPgPs7pHSDJqb7UuQDvqnKeOzSiiSKu+
	c3r91aU/vJk8g5NBm4OMXcQ/Qn3gexkfKUvep3vu3tUsN7+0ENjraPuOGpQy2tq0
	6Or/Goq2tr+vlzzomlkx+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c05y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:19:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6EY6FS005147;
	Wed, 6 Nov 2024 15:19:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87c2akq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khU8ZTDbmMaZdlruuHYUnl6L8CLbs93kS/tfkDM6RRDeLtCbnYK9o4BBx421ENwWGqoBMVyWRUEvCubzoxp5LfxKBTXbgbQxAkuyxCjMl/kTHrtZUXhYoqLEIuwatRk5dujSdwVzOiEpzRQxAZb+uqeVs0xWXgtofHeFW2uQKeasNpCp5+MKaFG1saMZF8BQ24vVicxQAmkTaVgLHc0RYMYwJ42nEIsvOqwO+0yZxL23jgsNlLxbrYUa3szHrg7PdjhhyO/UsoSBYOmY+jxJQPV07VuJN8zXgageJ83wKQEiTc8MItEXtJGCOPI+1m2ftA8+uNB2lKxXWQvnxMEx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQL4VDqnj/mM/gg3zdxodDnFci1Cc+DEAXoQYM7CwaU=;
 b=wC1aXKLPS84J2tnWwu38dAoyLbWTdS8PzGspAlWFo0yN/q7520fq7zC/YB7YbHxUxzSxU5q86suY+quD/TRE6jL0jglGUu71gQm4BAYJA4jmicgbvN52IPL8kD1KJKrx5GJVC5kio04iOhWgV9BmgUaSJG/goRRt+8u7oZCNf4wNkVlOD7ET4W2svIcwS0BZo36ZTz2kggcT9iLydnlAb/wHOooQ3Y8VN+Ta23SohT1uzo2bkAHiC5hgptVNtGQWKQhw5BwaGbHPhK+XPq6DgFhC7KtarqvEg/YI6Z1eHsRa03dg/zDPd3iAxc5Lgp8A+K0XLZxYP5huPMm+J3rvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQL4VDqnj/mM/gg3zdxodDnFci1Cc+DEAXoQYM7CwaU=;
 b=uSmJTpO/HEPQe/RNVX5bGtJ2xZ9lyfm9mxbs4/+OS/wF9dKKN9p6TZNmjRQT8oZ6RtoDzwQ498lM3v8PCtJgD786Ea7mIw568Pum0PxYibc0u4brbDuL0Tz7WBuQUd4a/F1nFqSOffhEVWgL/IO7SfVhX9pOYUNzWnCJvvuNXzQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 15:19:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 15:19:33 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        linux-stable
	<stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com"
	<Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>,
        "christian.koenig@amd.com"
	<christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Liam
 Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)"
	<willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org"
	<mingo@kernel.org>,
        "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org"
	<maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Topic: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Index: AQHbJhfg+I/QGRtH80+9+XvDi7dLrbKp2oMAgACX0AA=
Date: Wed, 6 Nov 2024 15:19:33 +0000
Message-ID: <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
In-Reply-To: <2024110625-earwig-deport-d050@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5653:EE_
x-ms-office365-filtering-correlation-id: 2d0ff02f-cab9-456d-2f64-08dcfe766af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkRBZVRNSVlVOGF1WlM0bGdEN2prMmdkQUtOY2ZZSjRsSEJLVStIWHM3R0xK?=
 =?utf-8?B?dWprZ3dPQlJKbUg1aE1LcFU2N3V2TmQ4M2pNVk9PYzNJT0UrOUN2K2FLa1hu?=
 =?utf-8?B?SG1yWEVLNG1Td0dWMFlVTVBTVGFvOHE5SkhrV2srWlJ1TC9uVm5BOHRDL0FW?=
 =?utf-8?B?Rk9BcG5NTkYzajJ1RGFYRzJWbHdjUHBDa0M3ekxxR29nUnpsNHUxNTRnczVY?=
 =?utf-8?B?V2Z6VUpyT1p0eENhdjZ5b0VQWmIwWjM1TElVT2FsR1RnT2hqRFMwbnUyS2Rt?=
 =?utf-8?B?bC83NVJDNG53ZmhRa2FIczB1NWJ5N0tzRTFIa2JhdTg2UjM1V0lEdkZIQWJ2?=
 =?utf-8?B?M3BjVThMOVRVUjMvSWxyVzR5VjJia09TdExBUkhKSEd6dHJ0N0tzeTh6ZGkv?=
 =?utf-8?B?MjRVSVUrcEtjZWpZUk94YzUwSFZTVEpsQWkxTmlzZE4zZUNmOVFxR1RJMkha?=
 =?utf-8?B?dE1QNXk3S0E3SEo4YnJKelEvWW1kajlTMC9oRENyRmVGK1ltdGxKUlFDWncz?=
 =?utf-8?B?VkJFNVhETkVOM3VhRUowaVF1RE44VFFuMlFXTDRlVyttWEJyZzB1aS9CT3hT?=
 =?utf-8?B?Zk1DaDN0NDBpOXg3cXBkczJSUkhlb2Fnd1N2SHQrTHBCZUlRRXY4ZWJ0ZHhh?=
 =?utf-8?B?UlNjQm1mcnJpU2RIMXluMW9pdVcrVWJBRkhmNjhYcXd4RmJibTl2ZERGNXE3?=
 =?utf-8?B?QUdIZWNvclRhbENvNGtJZUt2TVplekJGUnBRdUxKL2JoM3dzSW9sMmFtVng4?=
 =?utf-8?B?Z0xab2kzZXJUbTUxSyt5M3JPVWFEUmFhd2hYaVRiRjFOM0F6emRUUmo2K1lO?=
 =?utf-8?B?b1NOQVh1RkVzYkVsRGxiME9SUU9iSVdvN05wOWg5eVhRQ0REOHlBWWpUL3RY?=
 =?utf-8?B?K3RsTWJ2Z2V4Yk14MU4zbkRNK3kvVDFUeXI4S0I4dUczdEoyOEVZM3ZRTmlo?=
 =?utf-8?B?R3BYVDlYYldNVWNuMGNjbmNiUWs4V3RBaS9XWE4yZ3k3d2hIVW9oOFE2MTly?=
 =?utf-8?B?amlCeEgxZXkzZktvNFVZMmRFQ3h0clNOWjJOa1lQbnZ6b3B5ZUlOTVFwb2lU?=
 =?utf-8?B?QXpkUjgyeXhRWUo4OGM2R1U3R1VKU0JkOWJZRkhQcng4VXlJa0VHSlMvb3lE?=
 =?utf-8?B?NS8zRDQ3aG5yNWJ1anpRMDZvN25SMjJkcEQwS3pEdkMrTFhocGUyMTA0dHlK?=
 =?utf-8?B?cEJ1a3ZiMGhtTE1qR1UyQ01PbmVJRFBhNTV1SmR6ZFBRYzIrOXdOam9pUG5w?=
 =?utf-8?B?SVJNSkptdlVnNnJYb1FxYWVBaG9tR1ZrOC9GcjlLU1RMalZmVzZoVXlTNkty?=
 =?utf-8?B?VS9nOVZSMThDdjF6UWZPWmNSWGVYRlpzOWFCV2thTzhhRzlWUGJ2K0lTR3Fh?=
 =?utf-8?B?SzI3c0VaT2xCbUJHNVNWZ2Z6eUw5enBKSVprMW8yd0JUT0VIUnAwWW1hYXky?=
 =?utf-8?B?QnlGRVpPQlhlQjJJY0tCeThtSlpUU1haellQbFVLTlo3eUZjUXlRQklwcXRt?=
 =?utf-8?B?MTU2QWk3MFV3NXhON2J5dlg4U29kWC90d3Z5TTVDNnIvdlpLMzBBMTZ4QjNS?=
 =?utf-8?B?d2Y5YWtJUVE1NmxRZUVZMy9GMGZ4dVRQVHpDbDU1QmxDK1dTb0ppZHl2VFBx?=
 =?utf-8?B?MnRIQllVdFE1RDcxWjZOQnB2L0NuZXRKWXNhVVY4OWRueWgwak9Lb0x2ZGl2?=
 =?utf-8?B?bSt0d3ZxemhiR3QyRWZKUlhodEhFbmVSTmxYTVBvUDBXbDBVbEkzVVhpYlRo?=
 =?utf-8?B?VjVaSHlEaUhsb3ZaQ3psbGNTaUptRmhzZldMa1FDOEQ2dDBRTzBNb3BxYVVk?=
 =?utf-8?B?WTIyb1dOQTREWGJtVXcwWGNBWTdXNDRscXpucFQ1cGlCQkZ0RjdGZUsrYjln?=
 =?utf-8?Q?siyjcPGJfuLmd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjBPSTZsVXRkRXhRRFVTZnhlVzdBdVlBSUpPMlhOcXVPOS9ES2NOWWNXVlpo?=
 =?utf-8?B?SUk0REZmOHQwUjRLa2ZvdG8xcCt1cEQ1WCt1VVlPZXpVNlYyQ1RHK24ySzM5?=
 =?utf-8?B?UXFpZFdHd0tQaU5Tak16dUJRL1A2azJKc05ZYnNmRE5qajhBVnZmMjYzbC9p?=
 =?utf-8?B?NGRjYXYvdGN1ZWhvUk1VNnN5YmpRSjVUZkJ1dHUyNlQzMWswZTZ0dVU4Tjg2?=
 =?utf-8?B?c21KVDQvSzZ5VG81QU1sdlQ0RVpKMlhsR1dsNjZnbm9GeHRLaVVvS3JzYzBJ?=
 =?utf-8?B?NDBRcVV2ZU1yRUVBTmNiOXJielFvSFppSVh3NDJrQTU5M2pPMnl3OHF3MWda?=
 =?utf-8?B?UEJZZENhVm80c20wdlZMK294emNyNDVqdm9aZDZwM0pVUENBbVRIVnVHSktR?=
 =?utf-8?B?c05mdGVVSmJOdEhoZjNiUkVZdE1YdEJnRGtBdURQc0JxR0F5TDVwWHZQd0NN?=
 =?utf-8?B?SC9ubjBDU3gvQlo4SFpBdFEwVk8rWEh6UDlOQ05JTmh2UEsxRDhhdEFGL2tp?=
 =?utf-8?B?QXZBZEJCL0VBU1BVcll4L2dDczhUL0dPMjF6OFZXRktmbE5ZL3hUc1Y5ZTlj?=
 =?utf-8?B?dDcrMEIwYkdFRnZVRmkwZjlVL1lJMm1IRDc1ZWxwcjdOWGJIOUM0dGxONTFv?=
 =?utf-8?B?U2JRU2RhaGUrYkVITU00LzNWRFUyb1dWdThOR1VIVW0zakZIK2oxT2NlcDhx?=
 =?utf-8?B?dTdTdnVveW9VeWZJSWJJV04yNCtlbFNMcUZWU01lQTEwd24yUWVPWWQ0RmpT?=
 =?utf-8?B?ejNwd25FN0dMTDJXb0ZkV1p4dGJqVFlrUjFRTHdEdjlzRDV6ZDBqMzQ3Sk1T?=
 =?utf-8?B?eWxMaEZMY1owdndxSGJOazh0NEtUTWNNOGltVGxHVCtRWlQxWDE3WThvUkhU?=
 =?utf-8?B?dUZUSEVCMEpBbmlZVDBueGF1bmJtMFZBTURnRnkvZmtVQ25XTVhlYWFQWVJP?=
 =?utf-8?B?dW45azBRYXNpc3owYm55dDduUmpoMGF3N2ZrN0MxdStxaWVibnFYRTh6R1Ni?=
 =?utf-8?B?TEpSaHNCZjFwM1duaHhuWElJNXZNSUVZU256Wjd4cGxYZ2dqaXkxelJjUFJU?=
 =?utf-8?B?VG9GZ2dOMHBSVEFJUGhsRENrL0NDTDZmNURCR01PYys2MHpkRnZsVGdidjJO?=
 =?utf-8?B?OWZLMHZFL092cWxhbkNpN2hiWGNTNXl2bXBlb2pUWmFmb09RQTFtQzFNUGFI?=
 =?utf-8?B?TS95VXpsakhHYUE4ZUxTY1pScU9FaUF2RzJYSkJONTRnemhERzhIL2Z6NUg5?=
 =?utf-8?B?SVVnenFzQ1hWUmJZYWhaRTRlL29lRlR3dXVvV0prYzJwOTliNThsZzBsaU9o?=
 =?utf-8?B?elRiSWFXWUJ4OFlWTkdST3VaMFR1WmNIVHlvQlp3K2owUml4UHZrc0VSVGJ2?=
 =?utf-8?B?YVZjQm9yMHAxeEhLWmpPL1V4bzVJN01KZXlZY3lHRnpZSi9KWkU1Znlzc1h3?=
 =?utf-8?B?NVBsZzFDa3RmY1V1SHRmM1RyelkyNHYvNzdTQ0x3aUNBRk5yNzE2NG45SXh4?=
 =?utf-8?B?ZGV4TmErb2x4akM2TFhqRWg3MGNlVWFBQmJ0cnpiNWs0RHhpUGpSYXh6K3kr?=
 =?utf-8?B?bnpyY3ZPcFFKZU1IWDBZUkxlSVI2SXczUWl3NTQrTW5aTVQ1cHlEcmk1VTYx?=
 =?utf-8?B?WURzL2hsTVZxV2NEK0R1RVpQY0M1eUh0S3NtR0xBNU51SHRsMkhqWlpoaHcr?=
 =?utf-8?B?dHNibnIyZ3JoWloxZ2tpK0kxZGw1UHk4TWV2emJEbHFGNERrVEpMSG9jdStZ?=
 =?utf-8?B?a0lKVWJpdGlTSUh3MEtDbnIxVDZOUjg0emRIZkZxdmpKbDZjZGFnY0RDd3o2?=
 =?utf-8?B?b0hUaVZpN1hKK3BnOTJnY2VyYS9JaHZSTk5NeUF0QmNmZ21xU09vZ3lDRW5t?=
 =?utf-8?B?OTQxSTI0SHZ6QjhTUzRsc1EzUXNLQ1I1V1FFRExDalVONUVzOGdEeDd0UTNn?=
 =?utf-8?B?WjJVbWFUQXpOVk4vODZqSGQ1WUdQWXdGY0s2ajhHdWtmd0VTdkZsWGtqQWp1?=
 =?utf-8?B?WG1sc045ZEhsb1RjQ214MGZtM1J2YXpDU0pMckFOY09JUjdmc3NxSFpObDl3?=
 =?utf-8?B?bit1aVh1Nyt2alBUUmIyODM0WHpvQ29hOC8yNjliSlpKbmhoRTk4dnE1MU9h?=
 =?utf-8?B?UGYyUzcxRGFFdU1NVGpuS1dyVDZNcU9vUkxHcTZ0a1hvSmNqQWhremVCeG1J?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7018CB106F97C843B387AA18DEACDBD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cJSy9q38QrZrClVkgj9EpRm0YA81BYs+WIWTFZ9TdgbCxoM5F9czfgLjcJKkhGW0KCQldUXw1UMBfoRtdpQnc1ltSg4dtHIEQtZwCNWrakJ6+5yMS5APcMoPjamBTmweCIGWFMxFuNjS8nxFb36PueAnGvZtF/nFyCUJziJosX5S16UVc95hNSVurcoJ+ZSLUMdky2FK1LEGiiuRAphVsG/9m6lU6BSctB9GHuKtPUNYmMbSWgX2VNFkpHRTDK+jyIGKq/D6B9UTHf2DNXk6eEdOw/5CRmTVoaDZ3kR+lfk+59YFiQ28RJyqCYaZSqgC9D3sfbFKcyknL0YQzyqk1ZlcUNFvMxZqFL0cQbSd1ntP06xJJnFtiQ8fBCVv16qlRwfEN82cX54OhUUmwIfuSODMsO/BRZej/cedrYNtKpy4GI4KwhFnqgNrw0L0QZz8JHtv0q0WsHV1qU/6kSrrYBhsxkvYnzN7dnKVHsqtUp5/Z2pY1D8yRgCKp7I1CBa/yHqfFBsbTBoBWYCFn6HSWervyJNwPt4yaXTxJrstACyEFybEFGIE9gywgifZ/zQ5yhfibtgH1/ejjmBBACXd2/IpyyGOu8CRmHJw9Vjeh4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0ff02f-cab9-456d-2f64-08dcfe766af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 15:19:33.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muE3Ba2ZXXWIWQcJXWJbeie0qqU4JQBpQwhRi827Ytl7nDNMU09CaeHzAnXKzZnvrFpcuC0zTL+dZRvTOul1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_08,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060119
X-Proofpoint-ORIG-GUID: YHMzDYOC9hHvGWnfJc32YUsx3XuvV0A-
X-Proofpoint-GUID: YHMzDYOC9hHvGWnfJc32YUsx3XuvV0A-

DQoNCj4gT24gTm92IDYsIDIwMjQsIGF0IDE6MTbigK9BTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMjQsIDIwMjQgYXQgMDk6
MTk6NDFQTSArMDgwMCwgWXUgS3VhaSB3cm90ZToNCj4+IEZyb206IFl1IEt1YWkgPHl1a3VhaTNA
aHVhd2VpLmNvbT4NCj4+IA0KPj4gRml4IHBhdGNoIGlzIHBhdGNoIDI3LCByZWxpZWQgcGF0Y2hl
cyBhcmUgZnJvbToNCg0KSSBhc3N1bWUgcGF0Y2ggMjcgaXM6DQoNCmxpYmZzOiBmaXggaW5maW5p
dGUgZGlyZWN0b3J5IHJlYWRzIGZvciBvZmZzZXQgZGlyDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3N0YWJsZS8yMDI0MTAyNDEzMjIyNS4yMjcxNjY3LTEyLXl1a3VhaTFAaHVhd2VpY2xvdWQu
Y29tLw0KDQpJIGRvbid0IHRoaW5rIHRoZSBNYXBsZSB0cmVlIHBhdGNoZXMgYXJlIGEgaGFyZA0K
cmVxdWlyZW1lbnQgZm9yIHRoaXMgZml4LiBBbmQgbm90ZSB0aGF0IGxpYmZzIGRpZA0Kbm90IHVz
ZSBNYXBsZSB0cmVlIG9yaWdpbmFsbHkgYmVjYXVzZSBJIHdhcyB0b2xkDQphdCB0aGF0IHRpbWUg
dGhhdCBNYXBsZSB0cmVlIHdhcyBub3QgeWV0IG1hdHVyZS4NCg0KU28sIGEgYmV0dGVyIGFwcHJv
YWNoIG1pZ2h0IGJlIHRvIGZpdCB0aGUgZml4DQpvbnRvIGxpbnV4LTYuNi55IHdoaWxlIHN0aWNr
aW5nIHdpdGggeGFycmF5Lg0KDQpUaGlzIGlzIHRoZSBmaXJzdCBJJ3ZlIGhlYXJkIG9mIHRoaXMg
Q1ZFLiBJdA0Kd291bGQgaGVscCBpZiB0aGUgcGF0Y2ggYXV0aG9ycyBnb3Qgc29tZQ0Kbm90aWZp
Y2F0aW9uIHdoZW4gdGhlc2UgYXJlIGZpbGVkLg0KDQoNCj4+IC0gcGF0Y2hlcyBmcm9tIHNldCBb
MV0gdG8gYWRkIGhlbHBlcnMgdG8gbWFwbGVfdHJlZSwgdGhlIGxhc3QgcGF0Y2ggdG8NCj4+IGlt
cHJvdmUgZm9yaygpIHBlcmZvcm1hbmNlIGlzIG5vdCBiYWNrcG9ydGVkOw0KPiANCj4gU28gdGhp
bmdzIHNsb3dlZCBkb3duPw0KPiANCj4+IC0gcGF0Y2hlcyBmcm9tIHNldCBbMl0gdG8gY2hhbmdl
IG1hcGxlX3RyZWUsIGFuZCBmb2xsb3cgdXAgZml4ZXM7DQo+PiAtIHBhdGNoZXMgZnJvbSBzZXQg
WzNdIHRvIGNvbnZlcnQgb2Zmc2V0X2N0eCBmcm9tIHhhcnJheSB0byBtYXBsZV90cmVlOw0KPj4g
DQo+PiBQbGVhc2Ugbm90aWNlIHRoYXQgSSdtIG5vdCBhbiBleHBlcnQgaW4gdGhpcyBhcmVhLCBh
bmQgSSdtIGFmcmFpZCB0bw0KPj4gbWFrZSBtYW51YWwgY2hhbmdlcy4gVGhhdCdzIHdoeSBwYXRj
aCAxNiByZXZlcnQgdGhlIGNvbW1pdCB0aGF0IGlzDQo+PiBkaWZmZXJlbnQgZnJvbSBtYWlubGlu
ZSBhbmQgd2lsbCBjYXVzZSBjb25mbGljdCBiYWNrcG9ydGluZyBuZXcgcGF0Y2hlcy4NCj4+IHBh
dGNoIDI4IHBpY2sgdGhlIG9yaWdpbmFsIG1haW5saW5lIHBhdGNoIGFnYWluLg0KPj4gDQo+PiAo
QW5kIHRoaXMgaXMgd2hhdCB3ZSBkaWQgdG8gZml4IHRoZSBDVkUgaW4gZG93bnN0cmVhbSBrZXJu
ZWxzKS4NCj4+IA0KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAyNzAz
Mzg0NS45MDYwOC0xLXpoYW5ncGVuZy4wMEBieXRlZGFuY2UuY29tLw0KPj4gWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTEwMTE3MTYyOS4zNjEyMjk5LTItTGlhbS5Ib3dsZXR0
QG9yYWNsZS5jb20vVC8NCj4+IFszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTcwODIw
MDgzNDMxLjYzMjguMTYyMzMxNzg4NTIwODU4OTE0NTMuc3RnaXRAOTEuMTE2LjIzOC4xMDQuaG9z
dC5zZWN1cmVzZXJ2ZXIubmV0Lw0KPiANCj4gVGhpcyBzZXJpZXMgbG9va3Mgcm91Z2guICBJIHdh
bnQgdG8gaGF2ZSB0aGUgbWFpbnRhaW5lcnMgb2YgdGhlc2UNCj4gZmlsZXMvc3Vic3lzdGVtcyB0
byBhY2sgdGhpcyBiZWZvcmUgYmVpbmcgYWJsZSB0byB0YWtlIHRoZW0uDQo+IA0KPiB0aGFua3Ms
DQo+IA0KPiBncmVnIGstaA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

