Return-Path: <linux-fsdevel+bounces-32340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC09A3CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BCD1F270EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546820401A;
	Fri, 18 Oct 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7U6nu6l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wqFUvqGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C1204019;
	Fri, 18 Oct 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249266; cv=fail; b=IcVtHrXRpavQPJqvRBxMvrki8vuLe7SFnHAke86ZAJdIimU9x0+ouAMCddTqmN91198SP6bvlzvdhUl3fUTb1LoXcpi2B9LcIQfQ007wdJ+UCYKi2/9Nx457HIzXbUnqIqrNYLvCRbgGusLWhJwofFHHaijMQEXxDD9FxPQOR/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249266; c=relaxed/simple;
	bh=bMQn7Q/uiZT5tq7aXSGXF5FR8jnpB9TWeiF24nxZeLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fO4prpZEGhqoNkdFDbYUKJSIBMZOKhzZodnAs2mm6+6ygQHgx5Wuhisz3DOHRRu5u9mhXM+cNQWh9WWX88wDzmIAlDLhJa9Dtj9Pnqk1TD9Val4gfYIlN+1VO46W3YKFhHyLuQVAwsKGUM78vWeWro59O06BsUJOtD/aSgIjeEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7U6nu6l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wqFUvqGX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9ipeq008536;
	Fri, 18 Oct 2024 11:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=aN8MsLzdiQHU6y1OEe
	zilCRmoFPQly4jQMnSitMORuY=; b=i7U6nu6lIZGVnYKA5pzxCJhae2UfxUK26P
	egqgOeAm502wTJmMaglZpi3LxMEv6P7haqs4aXMa3T7ceL+f6sBxdMCcDFjuG02a
	wgeSNQbpRvZv+T0EOYRL2SPJZtjgK+O9WLlZgcrV3BaVpvqSnbHkb6Bm+9AC6mkC
	e1Hc8qv4gKFtgvbh4dW6tuiPQzZy8xwL0OHE9y10ubbdberRUWfwr2HqHsBTHbN9
	PCHBOpVJK/mWZWLIatE+ZXi68QBuafscOF65pNgCC87o5aIzwFpnxil3uKfRPAmM
	hb4qGRYvx1+nDtTALGoylm4JVHY25TO4L2eGVDoEz2KM8ygo2Ebw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5crx0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 11:00:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8d5UX019899;
	Fri, 18 Oct 2024 11:00:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbf8vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 11:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMctPKnPby94yOwQC9kZlhmyFbeLpw9fHs0JCHntDZbosuyKlPIwAFtSJiJNPNloHjI54VTgKDoKXudsRJ5y/UhgNLtCE3vA9i6qbZ8amL9pdPDQICLcM2PNalp6AOnYwRRR7Rw1A6T7ka6HmvmOQOSQaY0cl05zam747Lg6I7z7PWiLarrYcKHu5JcNlbMzyBtQ3pGLl+8Oz8VVni0Soe1tc7kSAlajpEgzaElS4mxG7UalAVaoA1kzvM7xCYpecFNqMV/P+pdLBdQZeVZ2gwPtdISfSl5P6/U33NjWtbsSzo0JcNPYXMKhFmJlGD2zuMAEBGoAFUAM585HVxXV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN8MsLzdiQHU6y1OEezilCRmoFPQly4jQMnSitMORuY=;
 b=JmFpeiGvlPiSiXuU8b+3w5piJLh8ri+rhwXbAn5N23oyhh9sMSkTX1I4LDKewQ3ZDP4ogfDEuD/BhS96HxYk0Yu0rpAzRcUm4Hi0tTLooAR+/h9gGecatCyRnCjqeQcf6Uw+TlzqbpuokujJkHOZ/dz/z7DMSP88DDxD5yGrS+hr5bMB2qoAdpCUG7kY8Qgp2dEJlYhFHK2NOD84THwYctPZZax5NSDB2nF7+dC27wOPIrVo1wbN+V5hrc2DfO1ULuVYallQQHxh/Rn2pDE5VQGNdAKf+TK747aAfnCoy9K8lo1un67mStjjqd19gAdb+sqp6KYXLcmnPmby1/JFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN8MsLzdiQHU6y1OEezilCRmoFPQly4jQMnSitMORuY=;
 b=wqFUvqGX6+WQSXgojCYrmQT3qZUxgdHsyGiHS+rvHaQN94vUrR1jUgJWF40erJzC5/wCHlhAL4Q7TCwWbOFV+COMRMW87/q25I/s2jABbmMi9WInhKAy6HQMq6rqD+wKlHha1PIzH+IxPqh1xH4NLx0FGX44DJSMciznFSN6ynk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6907.namprd10.prod.outlook.com (2603:10b6:930:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 11:00:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 11:00:24 +0000
Date: Fri, 18 Oct 2024 12:00:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com,
        kirill.shutemov@linux.intel.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
X-ClientProxiedBy: LO2P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: f2297461-69a7-4e63-4156-08dcef641143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5GQ3YvlRRG0ivhDbpQ9sXt9Mw+mzqpfcK0O9UtkT7rFC6VqhfXeyOeIpnPO?=
 =?us-ascii?Q?Phe0IFf20+gCjkd+MEqhVpNYV5F8SbKJ6UrUgdwimfSOtanhV83O7W9xigP2?=
 =?us-ascii?Q?7Hsnt3dLrMmpespQUGqIR8o6Vze32qmphSO5yn9YNxIbgSXzVBqmkv/tD2SX?=
 =?us-ascii?Q?Gm7INxbt7qLydenpf34W3ecv0DCQsaxmAbGF9GUnJf8kCVAMY6+pRVfizDL2?=
 =?us-ascii?Q?xfdIHN345WWwaSrXnxVMazS4mjZz+DFMP+UYJk5VgrjBKetAL3liVTTkyAAW?=
 =?us-ascii?Q?GYEVqwl1Tge+rIFYVMadGsNmPFYZxJFoQejGvj86f4YCVIKscqVlCOszqLgO?=
 =?us-ascii?Q?rO/zL4P+znnjZtaNul29L1AHb+OhJh2C3yhPiQnARsYWicBU0qnR1zMbrtEb?=
 =?us-ascii?Q?Iyks+dAfGT4RpoOAnllU4GNHbpcfmWm3PDIKPuQehHac7VsRDwInkRwihox0?=
 =?us-ascii?Q?mKF7rD87K6svMlhumJvod6fCQpDznjS4555s9AtkDiSrS/0fK4owrAMCIsil?=
 =?us-ascii?Q?INdtHCuhyYyEfYoA7AbBEQ5ViD+XlDlbsfSXX0UpxvUxBdKFMS2LkFB5wviz?=
 =?us-ascii?Q?G3rWEJp+bfdluLWmtkdWacky6v5U78VmLLncs/COxkwqXGHBGyBC2E5Rsdyb?=
 =?us-ascii?Q?G3Gx6/tpfFWHRCXrowxtkwDki1DWAP+6V/lhgW22HRPaYE9Dt/ByWVmIjYza?=
 =?us-ascii?Q?iU7yaonSunMf5dFqEk9ai+DlsOszECmqWK8AqCbIFnHv4xC80qvmMO8/VUZW?=
 =?us-ascii?Q?pig59y4n7/8yhVoZqMludj5RJGO5IC4tTOiYQ4BPI96yBRzk3ArA/xo9RTRX?=
 =?us-ascii?Q?wjBE+ubTzjl6NCQ77IArutE1LkmskL20r3JESx6bXwFSzfvn69GbzJ1jkHwO?=
 =?us-ascii?Q?KJVaePPu4Lf4W8t7CHd3GZMHY9PzRGx0j6Jk7fSvvLVIyw2JnQgCE9JH9rfF?=
 =?us-ascii?Q?SZdXcCtorDP9/ZB/yKXRYPgLD3N56avvQNSmzKF0T8tb9mmMFholO2OyQZU1?=
 =?us-ascii?Q?q52aP895KlibAkaFpx3YNU5ViOqu7uaeqBsCng57h4k70onxSX8o3B2IEMdz?=
 =?us-ascii?Q?5DBpvqKRLjYpL4YN8ESfNk8R9SabmZwH9pMOowzTigdlOagSRYagutdLyr0e?=
 =?us-ascii?Q?OnP28ANpeAaODHdluFeDFeTx2YKT5QU22MEzQ24l2cb15Q+hXWo/lPc0tU1F?=
 =?us-ascii?Q?rCxK4bIsUcmXUMOI5Bgk5GP+dan8rwhdRImasYgIYtnYXImCrFoDZ8Ouv65O?=
 =?us-ascii?Q?iDVlKAqNimxVv1+J2dsrPJD7d/NPCjapNI391U9LuA++jB6QUnXJNux/kntW?=
 =?us-ascii?Q?AucsnLddPh2YxKJiMACnKehZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Fya/xuOV59yx/8omllOno1vCY5S8sEvAFCR+5SYMnVfMdK3l8D0/G2MGzAq?=
 =?us-ascii?Q?C9qUBsJU+lpjbBDL6livQjP+kdbVpf+D1Z45L4pnJd3ieIsYNax8gSOCEb2H?=
 =?us-ascii?Q?gY3ZlGKe+mmcFjL6aZXOt4sWAr/9bgdhthShr/R9EUXB6LZ7zRVuI7U2FXrI?=
 =?us-ascii?Q?n1Msy2QlXvQIXr+8tcPU6DOYxw29dVw2odfkP+Uak2bEorKgDkpQfeLgl5lB?=
 =?us-ascii?Q?jnIQ5oAr69QEMfhnLaip0hxXz9HiWSQH/ym6pgkLHAVukBLjFQfi0Z5y+pCN?=
 =?us-ascii?Q?qhnxeYYrBuANmQu17WVGFWhZNywVQ+oamDkS0osSrnM/ms3fzkVMPPAX/M49?=
 =?us-ascii?Q?58W1XgYY2/quNUd7p+ElM0Wvsav67G5EWCCI8jwQLeVRCohO7Z7M0qIk3MhN?=
 =?us-ascii?Q?0Xt3dFQnHwozhOnNmfpUWMIzJ94CIO7kS+vbPTqJOFzHNpBFXIeZs0G38Gsh?=
 =?us-ascii?Q?gQ9ktbV/oTxVHUTKGyUh3glMd/dY0gYI+Lbk8V8km9Ri7vIN915NHLbeWD7y?=
 =?us-ascii?Q?muakiAffRgMcD/dlRot0eShfUs+pEc2Z6h91ZfEq+FcV9kYPYr+XmQR/UQ1C?=
 =?us-ascii?Q?CLt0krI52grwU8zxIEKhadoEQvzJgP9XUxXqTLWs9iaTpClW9xxvyMlshJB4?=
 =?us-ascii?Q?2MHdp++4KeG+jpUOklzdatkOU4z55lqOdVdeg0z9ULryKC+NcD3Jwml71I4X?=
 =?us-ascii?Q?C/GF1TjebOpDStx78G7M0F0vLP5akXwpSNvPHUibbT1D+7vK4MP+cMPMX5OY?=
 =?us-ascii?Q?c+hjy9yHhPyGLqKsn6u79V8gS3ad33twtV0YOrP7qROwdi37jrRqfHHJJlKZ?=
 =?us-ascii?Q?IhWN4E4Tez+RL9r0ds155oK7r1yj7dJ2HmELEruqxxAFcLZkUw7cIeovEUYl?=
 =?us-ascii?Q?2SL5YvJmrihcqI9Mw4s6JfslVH8/DV46Ptz/GYh0XtjfkQ6NfulnyhZR6z2B?=
 =?us-ascii?Q?mSjnXlYZv5/aje1WX+PoIXkUGcKC8GvMl17viooymHo1DOLrElS/L3kB3Z4P?=
 =?us-ascii?Q?wltDiDjIiOOEXNeW9nOom751ZPM+FL9sf4Jzfgj9aSBSW6rY63avkiHftRth?=
 =?us-ascii?Q?cxD/hAlPcdxCu9ZpU9fYMj74gyXy7vh+GrlnD68whv/DYrJlGSaYg/gbZ4hu?=
 =?us-ascii?Q?HsNRpYtfI2rI7KYeib8ac4PXL2cGQ8IGkNQSQPjY5xkX+vxDyB1l7vhl/ypP?=
 =?us-ascii?Q?Bmw9MZGHkEGgCit0VM/3xXkWvSE5yT+K/ifbGiIiGnOc96D4XmelvMuUOu4t?=
 =?us-ascii?Q?Vi4Q3o2d8AetmeaU7o9rTsdDQKlo9cYJ0jCK9LYoOegTnVcCHOd5ZJCSN8WY?=
 =?us-ascii?Q?OlB5VpOfVZBscdI7DrbtBAp6dgoddEGU3pjquOKWdLQ8Koli0vXbF4udKfBn?=
 =?us-ascii?Q?4c6jwsnmx/ZhdIdcEQFP4Ib7gJt7wyfWheh7YnUjbgdGxTDNBMvEY/0ly0WL?=
 =?us-ascii?Q?AOBtdjMTIQJxOHGQX6GU+RG5gN2CsLUtj7hYlVfXNadQh5QcCiLcxMX0ROKm?=
 =?us-ascii?Q?eyiDq0NLGahValKbh/f/o/xxIX62PozBJKsA8ngm173/kMyvb6Sc5VF46AQq?=
 =?us-ascii?Q?PJzFyvl4O5y1ECldOvLMS5xyxr4VuCoWOjdHY1pjxZ0mxAIGRRW/laUYgKa0?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qAzoEFybE7j2s5FZ2c6CM39xpcSOII4sB6SBDJyU2sMBlB4r9BOqOov/VPLXrVfQrmD2F8gu4iIZDvDWVczgpWq68jWVtlH3gTxAkA1lOogg1UqmDr4uYhrxtvrx7AksaqXMCzIUweHiQbQ1Wkb5UuIphbnOi16E/4HLmUaqbfW/b0Sd+BvAtjX/8JIXxKWPoBlLn3C8cUVGFOJ/XWaEwfllzClv/kLHhk/9ROvPqBsQAjcQPWBR+KTuntmqMgrecgK6Emylr/MlM/2lAWYdCrfmPVTkxVJoeYPHL7UnoIJQ8/EcBElw7Q346FBX1XiUQ0+OI4q652os0oXoziBqte4OPlmQrLW6NeYgGD3v5bsmisQHs0CuOGJlJciBUQT6o3OcuBW2I129YsjTCf0FRys2qZcAqm1mFwbYe2UelzRFoz6N1ASOOu8vRoMDxKQdh7Z48n690cPZktXAbPH+SogRSDj6VWIOQBgTznNIEVf/yekbL4CfcuiB7+L1krci3YmHl1OM38FOmwA4nvUAFaDEdJf8s0XlJWjSa2bxaU681nDSbr0O0yhwei0f8XbDatnfBcanOtbBNeSA+SD8UP+Aa0l6axUp1ncZSnRsOmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2297461-69a7-4e63-4156-08dcef641143
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:00:24.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChK/qQfqDV6plgo6l2qDMbi+iigM8qHZ7fVq4yz0HTMH5cV9xFOvymTUCap4v5F2XziERWv3aVatx8Ty6bhCYhDz2/yN8pLIfoube1TQL1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180070
X-Proofpoint-ORIG-GUID: 5qrdI7BYbkcIGDpRmezheuBXk_g-D7e_
X-Proofpoint-GUID: 5qrdI7BYbkcIGDpRmezheuBXk_g-D7e_

+ Liam, Jann

On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > Probably it is hard, @Kirill would there be any way to safely move
> > security_mmap_file() out of the mmap_lock lock?
>
> What about something like this (untested):
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..03473e77d356 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
>
> +	if (mmap_read_lock_killable(mm))
> +		return -EINTR;
> +
> +	vma = vma_lookup(mm, start);
> +
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	file = get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +
> +	ret = security_mmap_file(vma->vm_file, prot, flags);

Accessing VMA fields without any kind of lock is... very much not advised.

I'm guessing you meant to say:

	ret = security_mmap_file(file, prot, flags);

Here? :)

I see the original code did this, but obviously was under an mmap lock.

I guess given you check that the file is the same below this.... should be
fine? Assuming nothing can come in and invalidate the security_mmap_file()
check in the mean time somehow?

Jann any thoughts?


> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>
> @@ -1654,6 +1674,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (!vma || !(vma->vm_flags & VM_SHARED))
>  		goto out;
>
> +	if (vma->vm_file != file)
> +		goto out;
> +
>  	if (start + size > vma->vm_end) {
>  		VMA_ITERATOR(vmi, mm, vma->vm_end);
>  		struct vm_area_struct *next, *prev = vma;
> @@ -1688,16 +1711,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (vma->vm_flags & VM_LOCKED)
>  		flags |= MAP_LOCKED;
>
> -	file = get_file(vma->vm_file);
> -	ret = security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
> -	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> +	fput(file);
>  	if (populate)
>  		mm_populate(ret, populate);
>  	if (!IS_ERR_VALUE(ret))
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

