Return-Path: <linux-fsdevel+bounces-22463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645AE917641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F691F22D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 02:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AC9381A1;
	Wed, 26 Jun 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R40FKrXL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9hzrvCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0211BDEF;
	Wed, 26 Jun 2024 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369781; cv=fail; b=NZyw1LessZ166QPtcHQw899wsqaVmSmCETXXmOQEwGHYJRgEbRuIT3wrvXZinAHmUMPF45zpibvFCwwwXuHSXkvsZNhdSh8LRA06nuqpF9zlY1V8Uj4LozXJVkPlPuFtUudysgO+TxPijRg2/bNgw361IVFE3f81h4KG0qq4MfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369781; c=relaxed/simple;
	bh=ghYzhqjbMfEFFq8V56ZmKJVfwrhxRmpr4+Be1ooNpcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h7iAF7w4lCbCAnOl+e8xCkfNLQ9NSazUi2cdVKkSYv9SHN3o3BIjS6Oq3DU4HaqtN14v8b5hyMgylhx+9SzgB1DA6yyWLUOIF2CPi96h51omP0R6DDiF85i+1+Qqf4vA6nuicbqhpa5NcX5tQyGWbSEdaIllS1klZsMQWsLDefM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R40FKrXL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9hzrvCa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBWmg009695;
	Wed, 26 Jun 2024 02:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=cbqUB2W/f45LyuB
	Z3B4S3cFc1dFDCu/3BLogLCJQ1rQ=; b=R40FKrXLhqiQrHmGPOzUmTZyXNJ3vwP
	1D5FuebUB2wPY/TfPbMhEVkyqfjRzUJR4gPJfXrurZ/EVLF0MnH+uGzsM/Iy28TQ
	MbNXiCOZX5uUDL3n35PAr0yIwkjIMv2euG5oOo7I8Mmvl1fSw/uTIbeJlivcqxgi
	3EsttgCXg8/yrGr746NTeKpHKctFDjDQiOKOi4rkSsgRKS2fP+KF7NzBEQHiMDfI
	0aBSKmgpRqJxs2zwHkydo2vi5rE+lsmF7Ve48yRYr4R2dKERhL05dTuGPnyNYMNH
	u3vbQHYRdC6H/Sm6KxLlsoy17K+xWtuKE8E9u6SR8tF4ras/TGf7YvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d1yss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 02:42:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q20hSl023563;
	Wed, 26 Jun 2024 02:42:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2exqqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 02:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiwAQ1wwwOA8xxjXMAQ34gQtbT1gDq9G59U/KMdtTcQrglJdsbzge4Tb/dwPpepq8IiH3of/FleIBh1CcAfgwGvK6wopV9ww91IFcUIecEQQBw1MfMOYuaI0UeGZl9pT+qI77gwgzuFyMcv0h4UrdjA7K9uF2j4MSQfYHj+WcV9ZC95oUaoYoU+iEuQeYeV4J6IbAchXI2KLoapxxzm0xyjIe4PK/j2kD/MuLdVb1P40ZlvZ0KUw9yPmRlHeoyu48Nc5h+Aj/jV6HhAwQcHK11a82NhRASY7loE3Lk39Yy9Bph0g3LBws/ClvNZcjytAJSbJNGUwQgZzKDvdcTihyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbqUB2W/f45LyuBZ3B4S3cFc1dFDCu/3BLogLCJQ1rQ=;
 b=EZf7Y8T2hlkGHGafNqDvZ0pb36wyasIrdSy89caQ+Zsz57L5/WKpXHVdcYF+RbntalI8w7kczKnbG9b5lwpy5ReagX4zFCuNDZY9/IYzp7Gn3BAGduxzd/Yj49GoLC7K2eiogsaVcPmdN2oBgYylWirAK4FA0XJzrP06dNlw89octSLjy/TMygftBwmUQ3sz/jZbFMGv301n/Zp485F8LgMlbBYL0YNbPPz7+eKD86OFQZ8rM+4USFPuQKl7fOovdxblRhZ1UjrGnh4Xsd2LnbLKXlGlk4Y+0fyprAjueYHBTF9WFpHaXARyOgnv/+A70SNGP9gP2sJ9SALhbVEaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbqUB2W/f45LyuBZ3B4S3cFc1dFDCu/3BLogLCJQ1rQ=;
 b=g9hzrvCaWChGHOQ0Y/YzhpLfv1k1lW7ZPWETlz1SL7AgQrgK3MwCu/AM8zZkv+VjbMp627c8sVEAcHilTA6cEX9sbNxnV/BhIAAUB6+/zHYxjr5q2ejwCY6kii07DBoMR41HEXrT0zwvSvw3wxspNq8jzWJuF9ZdYVhW4MTQXYw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 02:42:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:42:44 +0000
Date: Tue, 25 Jun 2024 22:42:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
        surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v5 2/6] fs/procfs: implement efficient VMA querying API
 for /proc/<pid>/maps
Message-ID: <dqa4q42iy3yyzagm2fdvxqdlwbn5pc7uf5gizbdsvrsbcjglpo@s67nv7kam5a7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
References: <20240618224527.3685213-1-andrii@kernel.org>
 <20240618224527.3685213-3-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618224527.3685213-3-andrii@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: de0a4416-0950-4bd5-a8a6-08dc9589a80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WWfj93IwfWR62iGlWvnhCp26G/3eP/ZcTg8uPKkzrCxFWQNSF0gCqfhq3cXC?=
 =?us-ascii?Q?hMuGxTfv6cvk3vRJvv7AGT3EsDleeCXBfKdjINCPiwIGvw1m0kRL4EA+EM+v?=
 =?us-ascii?Q?e7J/MJd+rDe0UMLe5hO/V9zjMJVd7ic47/dY/4iG2bjhbbGN1I2bOyAR6Bqh?=
 =?us-ascii?Q?FP55Z7ggQZ4phf3XJskdOefw80ISn6K0Vimr4r7GMhlWGoV65Cgm40/3uvtq?=
 =?us-ascii?Q?mvehwR+IHFL7nV7F2x5eBpthXuNf7xnjRXRlWoFOVWpLgW+yvtOSgcVhELod?=
 =?us-ascii?Q?cGOYKjgHwHGSY6msHL0QSv/wvKCC4BYlLxof5fuoRLQ7qdV0kf2p8HHRye6X?=
 =?us-ascii?Q?HhuX9x1YW6sUNGbh+c2bnIwwln+CcOud2RsUDYsM4qfNlOkvQ+QB10tRTDqt?=
 =?us-ascii?Q?hClbBmfDyw9oJ1JA/RgK/4Y1kNnjgLaoqyL+9dJ92+OyyHr+UkoAV2as/EIh?=
 =?us-ascii?Q?ONj672AdBvn8lSHzBTB1QySNk4Ynyovnr+anDZb+meF261XWXf710/g1PnkW?=
 =?us-ascii?Q?vdO0ux5FytWOsQLWNduqzSJi22On0a5hA2vAKl0TL7tLUImM/RYQAGSCS2Zk?=
 =?us-ascii?Q?1sJmIuE410liqqguPPl3kpap+mWUTXgav2YfkDn9+oX/JaOaiDQIKP+9waML?=
 =?us-ascii?Q?fQ88n5hhLOfwZRi8UI+SU4du8lW+hc+VU6qhmbARKfYu+AJBzTxWGuhHJSiz?=
 =?us-ascii?Q?uoQkWqfR7sc8kHO8NmhV28KVoKaEguYma69LEas2on5jDrlDSD1C0TRsfSDd?=
 =?us-ascii?Q?+i6oLHxfPeBlN9vC6A4rbKi9q/0hosNJs3G+nscWLvUmLErzt2Op0xOyfZ2E?=
 =?us-ascii?Q?bW869nCF9e9Blpm79BJEHXODTYXpqanZgGvFtVMrdfpHZS6/6CLp1WsNTty9?=
 =?us-ascii?Q?gZfE+rTjGpaj/O8YxOFpZaxZ+PE4mGSxeckO/Mb269M/1Pc6uBmkP4gij0uq?=
 =?us-ascii?Q?4dkkzZRHY6eeVCDjw7MTrlkYMwd3o5tLP0GQFK5Lm+QpPZQrSfQTp4yl9LE1?=
 =?us-ascii?Q?66edlX6afnjBR83GP1+ASJ8Xz8LV56CJsYcUMGATwRLPv66lYQPo37qOQgtF?=
 =?us-ascii?Q?gv/59jr2pwRvW/twEzQJLrZrkN6kwIUHsQgkki8JqvxGcf6k3QZp3rdHOXOn?=
 =?us-ascii?Q?huErvHz7uQ7khGizvAJDMvmMYCCyej4+IlYSopGX4Uz8BDpSVa5Q+uDcE2tc?=
 =?us-ascii?Q?YuIeDzYEh1psfrqcrjxuz9w6bv3/0YFk6PuN5z08EsAF2KG6U/sXtDtB4bZl?=
 =?us-ascii?Q?33pSB2xur+twZRjRiZCifkwNwVOt+5Eq77yNnoP9wwjWK2s2hRwPoXj5U4XQ?=
 =?us-ascii?Q?eG6/4Ub7y+83KVA+AjFf/7AF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wRitSSrRDk4Aa65//4M4fbjmbPlilNcwW3tV+ZqKVL1KH7FUYGSrP6Ylobi0?=
 =?us-ascii?Q?LIQDYYoLGt3Z3AR/coW8K0zxsCMN84mqGYl/TkXfjBXeqafBfIap0cc1DLjU?=
 =?us-ascii?Q?Bb+Ucny0kekDctFHmYG4+vNfzDjsW5cEV6hfUbiEzObB9xGWGg+lKnnGWe7i?=
 =?us-ascii?Q?vUbWAj0MNoQ8M/rBDgBUWlgXGrXBZG6NW2dgNH6XYeS1Fm0+qHCGFMtQICwX?=
 =?us-ascii?Q?/s2mRUgbp0EbiP80lJKO/6Srt6pfeOBIONg8bw1Hsnsf01iiES4XTSUA4knL?=
 =?us-ascii?Q?Er13OgDa37vXr9EXi71mozvubc5cu50al/AGL8nex3L8AdGXOPR/WpMDkTIV?=
 =?us-ascii?Q?QbQ503Y0OpjqnWZai8vdFhlifog6xy3BVEPmG3rWBakvVF9tQHp1HBay4p6L?=
 =?us-ascii?Q?7xEsiUTJD/qnW+jW5resGK/q5R1UhblLsmhcaUw6hUTpOX/EKTe03pnLtLKv?=
 =?us-ascii?Q?YfKOGD7G4eUXdUz8mtdDT80ucFqJ0LHdrcxH6aA31snCFUItYQSaz6KDGkSp?=
 =?us-ascii?Q?7CSROSKWJttqngKY0jL3tI5D3gFv+9FKei2FmtNy5q2ExK26LyUTt/csypQu?=
 =?us-ascii?Q?LF+u3Z9e5/SzY6Oz16HePqk45Z5CEAazvId8ohOTr8zXy2yNcGcA8SVeZSeN?=
 =?us-ascii?Q?BuhKoSrLgWYOjE4y4LbV8lnYp4TLHqUqEfxRD2Kv+K3dExz6c+IYcpxTNalu?=
 =?us-ascii?Q?K9UNq1vqoAq0f9g1hzvN4kUczHqCBYBe3w/RYlJuB3ITpEDBZrzSUGXnBMxx?=
 =?us-ascii?Q?FFHM3pteY/LaCAfVNT9pJDZx8cCBIVYqa71G4xfJ/gG7MZlf31EMxdzxnaPg?=
 =?us-ascii?Q?EXtb2Y0CFsPE4CFrT+2QqA7txLuTjE6k+3soxvEF97WWykTO+s8qt69O8okQ?=
 =?us-ascii?Q?tIPT9q2idyozSnEAICOg/cL/C/SWb4kMh3cm16zWo1MSHVPLGU1vzetM86/n?=
 =?us-ascii?Q?kXexb3x0yxJvZHPBN8z4jbuj+rpr+2nEKjhNsuLba7btafXEoA1mHdqvYHg5?=
 =?us-ascii?Q?Bb3yXZrUewxfY3LC8lURzwkjWATdi9ZiaiyR5dI4QBPQ6WJJzrN8CdM+DTnz?=
 =?us-ascii?Q?Oezv6/tCYBucQQTTe/6j+8KGXqMYiGRDLPBv7a9G6OaNZtT6fTHmSWR4F1yY?=
 =?us-ascii?Q?GRdBQwzMVGILuGlzfx04v5QAxrxgrlO+L6P15dzv7TN14CnJb2UsJAmefMyi?=
 =?us-ascii?Q?Ogq1aEkTbBCeUzfkOe1Ygx3Ioea34ZwjVtArOYHCn9WI6Eq1ye6A+2S/lqWQ?=
 =?us-ascii?Q?yRXNibGwCtB2GDWSVlBIkWnc7id0gUxWJ+Y/0MLsDDwliU6hWCIAyhrDJ7rm?=
 =?us-ascii?Q?RlxnpMmNEeQ/Er1kVi9HNlJ0M452KUVRezoUsaNzm1Nxa2D0LNJ+mO3T/KxW?=
 =?us-ascii?Q?SRw9pFgDulQKN70wAIP7ZYnaJCtzjfByePICfzY3rmq63X0tukHLQtXiFBcF?=
 =?us-ascii?Q?mhm40fs+ejYll+TyPe6jtLyI6HNCUPFb/yT9JUt3BY8ESsBrpNL8Z0/tiGUw?=
 =?us-ascii?Q?0QGEBQGnpjJspbmQdK5J/puVQ0g96B4e4yWcuZ7DF6a9PaEqu764MgUYxLOl?=
 =?us-ascii?Q?eMj5s0H0cfU//413QKCIjCI8YQ/mX8YVa4Q+TAgILMLeqnzmoCHOXFlB9uLA?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y+z0rchXp9T44PxnrVN7etMbeTdYoRMNfL4Dp2xsbGMIDdL77GiYMV3lN38v4wSLzis318Vh/KNV1YFchyywk7R1nY9q2cpJuP1DRHHHVSdRjjaoaOOL+6h1iI1Jedn0K1IQX0n5u4UYZyzXW4SYlfPVsEdFuWdu6/7dZxvS/S0IjWVvQJxxSpG3VzFrGOfk0H1vpUZ+oCdvFonDTBGikRuDL0A1WySkyEfcX19hmCcrpBtjtYAl2NmUsq/xaYydSC/jek0O7c0wFNtgyOg6sS+B0Tox3XRRWerLWGr+h7y4I3ekZfRp/IzBmZ0nN8RzFcWz26muDIDKeWOuB8HThZjTpZZjV8nQ0f9hS7LgFzRKCWSXPniXZURPNbUSqdiQgyJxWJmX/vbDnqNUhJbjpkWWdFir743vmkHXts2UM9kwYJM7t8YIYzXh8iieXskkoWN6KFl/924FYBMCUJ/eVp7MQxrzavh4WvtBx9L94WDQFMca4EpSddXBhFGmUkyHcyAibMePT/6bEHp9HL1HWFYL8RmG2ODAQIHt+W42aAlTz/UrnAW/GBATr+GRknYZP3KHDwsgHf/C15qtHZ4O6H/b116YU528W+71BNLtPW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0a4416-0950-4bd5-a8a6-08dc9589a80a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 02:42:44.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psMAJUNHOMwmNxumUU0kY3ZScQFN1ddtosUuiSXSlX9jco3LbivI7V2KaImo7D0i85koYuEZZNSyEZxWWWK2kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260019
X-Proofpoint-GUID: n7OYpTA0oZw7h4M80rE9sk8RUqr-XK-E
X-Proofpoint-ORIG-GUID: n7OYpTA0oZw7h4M80rE9sk8RUqr-XK-E

* Andrii Nakryiko <andrii@kernel.org> [240618 18:45]:
...

> +
> +static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> +{
> +	struct procmap_query karg;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	const char *name = NULL;
> +	char *name_buf = NULL;
> +	__u64 usize;
> +	int err;
> +
> +	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> +		return -EFAULT;
> +	/* argument struct can never be that large, reject abuse */
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +	/* argument struct should have at least query_flags and query_addr fields */
> +	if (usize < offsetofend(struct procmap_query, query_addr))
> +		return -EINVAL;
> +	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> +	if (err)
> +		return err;
> +
> +	/* reject unknown flags */
> +	if (karg.query_flags & ~PROCMAP_QUERY_VALID_FLAGS_MASK)
> +		return -EINVAL;
> +	/* either both buffer address and size are set, or both should be zero */
> +	if (!!karg.vma_name_size != !!karg.vma_name_addr)
> +		return -EINVAL;
> +
> +	mm = priv->mm;
> +	if (!mm || !mmget_not_zero(mm))
> +		return -ESRCH;
> +
> +	err = query_vma_setup(mm);
> +	if (err) {
> +		mmput(mm);
> +		return err;
> +	}
> +
> +	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> +	if (IS_ERR(vma)) {
> +		err = PTR_ERR(vma);
> +		vma = NULL;
> +		goto out;
> +	}
> +
> +	karg.vma_start = vma->vm_start;
> +	karg.vma_end = vma->vm_end;
> +
> +	karg.vma_flags = 0;
> +	if (vma->vm_flags & VM_READ)
> +		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
> +	if (vma->vm_flags & VM_WRITE)
> +		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
> +	if (vma->vm_flags & VM_EXEC)
> +		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
> +	if (vma->vm_flags & VM_MAYSHARE)
> +		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
> +
> +	karg.vma_page_size = vma_kernel_pagesize(vma);
> +
...

> +/*
> + * Input/output argument structured passed into ioctl() call. It can be used
> + * to query a set of VMAs (Virtual Memory Areas) of a process.
> + *
> + * Each field can be one of three kinds, marked in a short comment to the
> + * right of the field:
> + *   - "in", input argument, user has to provide this value, kernel doesn't modify it;
> + *   - "out", output argument, kernel sets this field with VMA data;
> + *   - "in/out", input and output argument; user provides initial value (used
> + *     to specify maximum allowable buffer size), and kernel sets it to actual
> + *     amount of data written (or zero, if there is no data).
> + *
> + * If matching VMA is found (according to criterias specified by
> + * query_addr/query_flags, all the out fields are filled out, and ioctl()
> + * returns 0. If there is no matching VMA, -ENOENT will be returned.
> + * In case of any other error, negative error code other than -ENOENT is
> + * returned.
> + *
> + * Most of the data is similar to the one returned as text in /proc/<pid>/maps
> + * file, but procmap_query provides more querying flexibility. There are no
> + * consistency guarantees between subsequent ioctl() calls, but data returned
> + * for matched VMA is self-consistent.
> + */
> +struct procmap_query {
> +	/* Query struct size, for backwards/forward compatibility */
> +	__u64 size;
> +	/*
> +	 * Query flags, a combination of enum procmap_query_flags values.
> +	 * Defines query filtering and behavior, see enum procmap_query_flags.
> +	 *
> +	 * Input argument, provided by user. Kernel doesn't modify it.
> +	 */
> +	__u64 query_flags;		/* in */
> +	/*
> +	 * Query address. By default, VMA that covers this address will
> +	 * be looked up. PROCMAP_QUERY_* flags above modify this default
> +	 * behavior further.
> +	 *
> +	 * Input argument, provided by user. Kernel doesn't modify it.
> +	 */
> +	__u64 query_addr;		/* in */
> +	/* VMA starting (inclusive) and ending (exclusive) address, if VMA is found. */
> +	__u64 vma_start;		/* out */
> +	__u64 vma_end;			/* out */
> +	/* VMA permissions flags. A combination of PROCMAP_QUERY_VMA_* flags. */
> +	__u64 vma_flags;		/* out */
> +	/* VMA backing page size granularity. */
> +	__u32 vma_page_size;		/* out */

The vma_kernel_pagesize() returns an unsigned long.  We could
potentially be truncating the returned value (although probably not
today?).  This is from the vm_operations_struct pagesize, which also
returns an unsigned long.  Could we switch this to __u64?

...

Thanks,
Liam

