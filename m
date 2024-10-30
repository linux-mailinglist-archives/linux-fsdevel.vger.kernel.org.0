Return-Path: <linux-fsdevel+bounces-33261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6949B695A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D011C213B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853B215008;
	Wed, 30 Oct 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJYkK3gB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PU3jqRkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528B1E47AE;
	Wed, 30 Oct 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306289; cv=fail; b=PlFybQ/KeE3vh+xsmsFzbolM2IS1rJxYXTC1ISl0NHyow2Sdhpo0LDDWSyuG6BPACnHHJgeUiEBytYgjdPO1w/g5a8PTL8mXy4MRq5U7nPOE51+GadqewtQvu8oVZ4cKfpcq3Y1J3JqwtYrxkZ6un+7ah9hXsU1wOoQfHlq7r/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306289; c=relaxed/simple;
	bh=Xh55vb0S0DEfikFwaQvIl3xXgSR2O74Ez71IPv8ukpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HcuYsy+gsx+YF6jqCGzvw+EfIPb4uQxVRo8EPfy2AIFLRWqtGVSGthrgsrHZ+DeLQKMqBNP3CZ7z9gIdvOcfM0S1F4ECCzQhYo3THAtATcGid7qpH9kHaB/Ms5fJd+QSjiNQWzNZSCHnN43nISTxrDIztLTi+0aCHm57ta87u/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FJYkK3gB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PU3jqRkb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UGXXH1029191;
	Wed, 30 Oct 2024 16:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BzEQTExDozXehdckzi
	w/UewveUbnpgzmqTDWQmDUosg=; b=FJYkK3gBbvtrMSK5A75Uh7wyrLXYI+XFrE
	NIKmDHlbMen8olOYpu6VnGTJilNWgFlIu5GESHPs4cfeXkrO1dEeP86Vb9UpxFk9
	RWuNQR2OqqKk2Pekx8+bQtBPDT0+FFOi8sHPTjho8ZlOjn9CP3zCSgHoru89okHL
	jPKldAPK2GhKRaf0cOqwa/3MtlRjfDyQl4HAHaaO/CytHZQh4RlOO5nbdXM7BWs7
	7BvAWtUUlX/vtSYZcvAgSHICvyi5tt63HV9AxTE0ZPyiEWTlxV0+21Y6TVBabprq
	87CifaOF61Os36T7S6esQDtoQ9amotqHIXzdtqYOkq8b+zhga0Yw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys8h53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:37:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UFm8of011865;
	Wed, 30 Oct 2024 16:37:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnae9rsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjLWuHjl/KrlW2wrEqSaNUhMTdruHCqXF85PvtZ1+LJzWE4Kq6gsC/xHsrcYe2rfxQSutu44rr8xAFJ7z88dBGI+D/6zj3fkvCgXNRTAVc+8NSTRTiW4+ofYPS72f7QcTzpv87NTaTKYl2QXRX4Bkh9PXzgOXbk/9uNjwIMaMVvXpJqYSGNRUeopvBJRPrdSZvY+RSm9ZRH2pZr/j3DAK5jFcBnyTgUnFiKTPiBdQZuRwVj4EOHnKHHO8pdxwHf/lxf2v7ocObuUBhelCtkReJIe3qn3U5Lo6PterxjUdAc3WqvXASeFAZVMrmYzRhCWdhmrYXtWJ5KupYigcqk+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzEQTExDozXehdckziw/UewveUbnpgzmqTDWQmDUosg=;
 b=QLUIveBGDs8s7mjri2k9RxiHAvqTnae431xgOWTan5pNBI/fvom9DtTVwZ1/uGJoGh231qhAk3sBMFPJz7aCNjCT3j0KTV0tGYv3+Ms+2STlhmt3m5nMUsn9hAXAOSd8PTV7BwmeLnO3xpj8UcBE+Gy3ehp2a5j/WqyKrdJ+PPlc8cgtrM8EYzHUPUmDOikDJayh3MCZjAMKYX909HW21PhzBHSEi/2ZxjbJUMwFLdhRSLwP2vrtkmv+Zx9P39nuZX6Iem/BETyG+895sRSnCq48riWU2kQQ8YWp7Hk/iMzqYx0DF7T0ILRr7LD6c/tRP2nBgX9cjnrl70ZIqucaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzEQTExDozXehdckziw/UewveUbnpgzmqTDWQmDUosg=;
 b=PU3jqRkbkurSzaNO4e+iijZIB/wDi5wV5edAYPEpUfpLEk3dDh3fi4nDO6i4bj+a6ds+lBDurUz6JGXn9nRn3NGiUDruHfaBFwPjrRuekcbbgqUMuI+4tZc6CHVwy5ivoEO76qPm9f1k+n33rzvoL+hwNMBkkfq5Xj2hvq0Vp/g=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7870.namprd10.prod.outlook.com (2603:10b6:408:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:37:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 16:37:41 +0000
Date: Wed, 30 Oct 2024 16:37:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb52032-603d-4a1e-2dbf-08dcf9012bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HMucaN3TSmmw3kd35Vw2gtJOe+a3y7EK3V7Ja9i2XsmT17lNiDC/83VVZZXo?=
 =?us-ascii?Q?4h3PRvbFnaHX2Bg8Etz1puPSbs7i9YDo47fSiLTXLQAdmrVFtWmL3nJxCUdm?=
 =?us-ascii?Q?xkWlwNS2Pz8BT/iSeAFDeWPV0UfvygFnr45GdWZ0E0RURnus6xZeDPe9jU5O?=
 =?us-ascii?Q?qsfyaDI09eby51tGXtqrnpK9fES+OJTsjxgnE8/0tfkE46laHvoJrB+a/zms?=
 =?us-ascii?Q?mdLuA4WU/+yVjHC2xpt2COZOHZgfEkgX0WLrBgZIYNr3+HVKFPeTgXjxEKnQ?=
 =?us-ascii?Q?/6TBCyJ03bSZgLGb/jWUE1DyKwFYQGcbaz+gzRfnLi8JwBkct2PxCapwvgk/?=
 =?us-ascii?Q?Blw1pn15oBABdSEWC366fwi+5UPQ7r9qwJd1/9iOqlKtWUH/oFaHoosNdj6q?=
 =?us-ascii?Q?wNE6qNW2Lchc0yq/QBUa/apV3XqWI72lvl8zvHdrClQmt+VRGUbYuN0qgjVk?=
 =?us-ascii?Q?rs8L5H6LhQ00lnBpYnO/KnrvfXJUAtZhMae2nL08QeyicA8ZlJO149diVXNI?=
 =?us-ascii?Q?BHfqGsz0Z3qtuZf1JXw/rYJcY7UsFkixdc973LAH8fOIbSVAYMFdwMrJs2EW?=
 =?us-ascii?Q?z5FaIE6wleBlprqhrutfGB5Tgqx5k38NUue0V+ZP+zEfQXF0igEKvZZgc8hI?=
 =?us-ascii?Q?ztnLsvQB/+a+9eyGRbxjrV5bUbJXcfGWdWWbjnziU2eJ+PYWYgMwKeLBKNuf?=
 =?us-ascii?Q?HP8Y007ujLqoqK3wgjw6RDjUKub4i/HTFYNlCh9kWq3570EkXsuFmxbQ61SN?=
 =?us-ascii?Q?eqS5ilUySylPkbHH0pUiIklmiq0W/rYlOemAUQYV+3chLvQD7fVZx4I40LVz?=
 =?us-ascii?Q?GYGgeV4+FZs8jRlcGrllN4Xd7p2ATaRhmylo9En1dPuZcy3C3oeti/tszorb?=
 =?us-ascii?Q?+/aPdKtAar6rgYIy8Imb+IQgFTIOEl/PHMW6eJwxniR9OYnhSxkn2hogeeJ0?=
 =?us-ascii?Q?61kYvn06cHzN98mRFBbSUd0A0fcsbYSLDch0VSmzVeelcSK2AjmAJYCcDFha?=
 =?us-ascii?Q?5/SZSuq5hdUWheyexjisJ6QkOBSkuDVlEb/5TEMGQBRJVeovJjYy2MTm+65y?=
 =?us-ascii?Q?pCZsNbMt0jeys+5njNz3EkB8NjdZYjD55EY5rj7tVdFsDmmGafAVuYqM3KMb?=
 =?us-ascii?Q?Iz7/+QvhpOM3mJjgv0d425p6g0W3e+1T+Z2mfz06QkVfotulXf57cd00S8bk?=
 =?us-ascii?Q?7PkDpiVyzWHoHzRvHxYonjgdgExG3ToMJhFaEc1K/gj3kIK88VJrHHfGi13N?=
 =?us-ascii?Q?mmQpig06btLXjac1Fyd8AYuazzLIMIjA7tzw2tTAPcW3p8fRfybIMnkZt8gB?=
 =?us-ascii?Q?EyouaW+yrnhh6U7J1KXbtz32?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xf7U44FOLX/7g8hyMzHHpAR3Wq83uSk7McZL1swhKjbhFsX9CI0WTWljG+2g?=
 =?us-ascii?Q?XBT6J5It7iUd6G24MnWvlwNxMSOWzOWzYadZ3m3oVdhEJOBBoeMSyVySlfqI?=
 =?us-ascii?Q?Qui8VuIAhQ/mG8ydL/1Zw4ADxX3c/E/EAffkxWe9hu/8j8Z5bmqd+MK1Snex?=
 =?us-ascii?Q?04oNnMxRkLweRgAML8DL777Lk0L2T5Q1twT4yoziSH+3p7DFXwNsTcoe9QKu?=
 =?us-ascii?Q?DxCBv6uSrbnWjtRgWOPjvqkfZUIxOwG6DT8Ij1ztw+1bhxxofxv66xzy1MYZ?=
 =?us-ascii?Q?RUZkE+ZdEdiO5OjXKh0Y3cG2hnT/Q3nepAS9BElvgCCx3a9CJFUqEwJ9gwWm?=
 =?us-ascii?Q?Pw6PayJooVkq5x82I2ZINXTsD1VRjhQ4si4Icy8vqEmQAdUHgXcJzUGppj3u?=
 =?us-ascii?Q?wrXZx4/Lp8a8+6FnmasSyuI22qgaY9ntjyfpFW8aEESwo0rxdqKWZS87rVkd?=
 =?us-ascii?Q?BmNZ0KK7WU8h5IKPk0RR2bS5YQqmUKbOVBEa30R4FUDlo7IZhVi2U/2zzXQM?=
 =?us-ascii?Q?BW+nvNcakNDEM7hU8iE9y4/CkXS/G/MVsinbkURe5BoKI3kijvU0ws/JyjjC?=
 =?us-ascii?Q?xXl7cQurqVwau+Le3m5NsYKnxPXMEzwnR2Xcd26vZuj32ir9p5qFdWt+jNC5?=
 =?us-ascii?Q?14oInJHGl9cMBVgv6SKkfJQo5UPzeaqsEWNmz2gXTHnCUuRQwixln2ruICwp?=
 =?us-ascii?Q?s2CkbXFfBn+tywWcXoTUFRr5WfZ/u+RL1/7Xlh4N59Dk5W9g3Wm+1+RwqGVu?=
 =?us-ascii?Q?XHtNvb03sYbPmVCNECw7M9eOshPSnSksQD28xX1gMGpIfvfv4BwLm5nGSib4?=
 =?us-ascii?Q?28dbsQvyJDzvee/w3mQyGUCKtmdybro5qt2AH8r/xZvDLQ7Jf0NIXYTCE9m1?=
 =?us-ascii?Q?tHU/1Y4rI4LoLFlkr+U0g1TMxeTrE0KaxIvCL6+XVZRUfTvL/J+UKk4gefQk?=
 =?us-ascii?Q?1DSv74YPwMNYWpQJ+QxNWbxukZMozueTBHnJ0AouFXfVQIcX05hroOICEo36?=
 =?us-ascii?Q?uazONJZmp5symYFbV3au+x6vwhXlJXHG5s4ym7THzCuaAgWnDUqdyicjYF/F?=
 =?us-ascii?Q?y/Sm4lZMcF1OknbDNYJl4zTYHG+0zi4uOIRuPe+RCr3Vam6rwZi08bn68KpO?=
 =?us-ascii?Q?SqguuH15VwE83hYlNyuQ0N+v4Qn0ZR6ydNHqLyhBiwayVGGzVV4Gl6Sv7j8w?=
 =?us-ascii?Q?vtWMFwreV+Z2CPI0BQvyJKoQMYlxwpV5lVod/h68ATyzwfGfPn9mjZk86yur?=
 =?us-ascii?Q?Dp6Ty+FDmJN6gJJB62Ml7DIAL1QF+QCffM0cjfbJFJz4+4sM1s/bMsEyIEn3?=
 =?us-ascii?Q?mzoWMkVE0y09+wTCT5zz7H7Xgz+Q2j19IZF4OZw8DvmzaH1crr/Mquy1KMNf?=
 =?us-ascii?Q?YD2V8w/mJK+UvrBCsbZhoeiWPh6mKWdTPQc7Zfg/BRKPWCPgc23NWm8rDdB+?=
 =?us-ascii?Q?P2IA0cikLk6bz0T25/jU3k5CZKu43Ku7pFwd4BxF2HGn9H5bNxCMcDn6tP5+?=
 =?us-ascii?Q?yqBH89PH2GpojLv27GMXxv3neo/s/C5/PluZgBWmBXoRGhj0eom8PHVNGt68?=
 =?us-ascii?Q?u+OntRfoK4tIUpJs5i9uKcO3HbhT56+fQRYwsbq2QXlCNuouhBW8BD2i9M8C?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C/qQKpRR7LX4xPj/2bcKuL7p/69nVTMSFwDVUbogHCslt1zDskk5cHrpl3DCd0RAgnF4W6rq5mPsy+M3uq1aI/eVXe/0YDLev0ZOUfQkG6ccwD5A3X/nVkq9c60/GYtYRDNF/++O0IlEbV1CVm0dI0g0o6+PL2gQazzBX1wOHNVkkRTjNr/NAaT/eY2a1KuyYeFh1s+hzIOCVSg3FB+UOepP5jf1Q5cVHZRu/NCat8Q6n0WnDLA3jZrWWfR2p4Zl2qV4+oAEBW0G+MYFU+mO6GBZrOg7GUIjrVXzXiMoagY0QachYu0pWG6DSZSmtXh9qPnSWXVr8dYIbM5u1JrDeN/N46FjwnhNCc8gKAEzZo7Ew+e9CGLbOiAefT5SaTSm5yIy4pzum6rMedG0B2X5LYJF+XTqVk+ouus4/YmiP+/iIBVDbLPEw3nzL1YBagpEFlTmgt2AJX+T88tjPPLcbeS4msygsRtHx6nBTgHUbvr4zzhG1rJ7wd4HsKQBOKh0KVT24z9gSR3/L1ikF4cJ1XyxCAtNhpnYDwM38c40C+CkNSiGfWWQLxT7097deKlBF2T6A0bDt/6gl+Mt1tgWQsJ2FL4Gi8Xt5rfVSwBhmgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb52032-603d-4a1e-2dbf-08dcf9012bed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:37:41.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFulUZ7jiEUo+KWIREHaGyY85iP7u4eZbl+o/zd82wZ4sU19PntnI0EtZ+bJf+R5hwNBc87RS+H6BFmrhEXe3VQhade8FBhUP1KflvaBin0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300130
X-Proofpoint-ORIG-GUID: oIfarKMaDnMV7FguXTbtTu_ZiuR4fvpg
X-Proofpoint-GUID: oIfarKMaDnMV7FguXTbtTu_ZiuR4fvpg

On Mon, Oct 28, 2024 at 04:06:07PM +0000, Lorenzo Stoakes wrote:
> I guess I'll try to adapt that and respin a v7 when I get a chance.

Hm looking at this draft patch, it seems like a total rework of pidfd's
across the board right (now all pidfd's will need to be converted to
pid_fd)? Correct me if I'm wrong.

If only for the signal case, it seems like overkill to define a whole
pid_fd and to use this CLASS() wrapper just for this one instance.

If the intent is to convert _all_ pidfd's to use this type, it feels really
out of scope for this series and I think we'd probably instead want to go
off and do that as a separate series and put this on hold until that is
done.

If instead you mean that we ought to do something like this just for the
signal case, it feels like it'd be quite a bit of extra abstraction just
used in this one case but nowhere else, I think if you did an abstraction
like this it would _have_ to be across the board right?

I agree that the issue is with this one signal case that pins only the fd
(rather than this pid) where this 'pinning' doesn't _necessary_ mess around
with reference counts.

So we definitely must address this, but the issue you had with the first
approach was that I think (correct me if I'm wrong) I was passing a pointer
to a struct fd which is not permitted right?

Could we pass the struct fd by value to avoid this? I think we'd have to
unfortunately special-case this and probably duplicate some code which is a
pity as I liked the idea of abstracting everything to one place, but we can
obviously do that.

So I guess to TL;DR it, the options are:

1. Implement pid_fd everywhere, in which case I will leave off on
   this series and I guess, if I have time I could look at trying to
   implement that or perhaps you'd prefer to?

2. We are good for the sake of this series to special-case a pidfd_to_pid()
   implementation (used only by the pidfd_send_signal() syscall)

3. Something else, or I am misunderstanding your point :)

Let me know how you want me to proceed on this as we're at v6 already and I
want to be _really_ sure I'm doing what you want here.

Thanks!

