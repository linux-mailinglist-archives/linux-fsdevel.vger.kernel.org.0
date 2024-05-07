Return-Path: <linux-fsdevel+bounces-18923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB08BE8A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94AE1F2846E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BB16D307;
	Tue,  7 May 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="esRV53WM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BShKId5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2C16D302;
	Tue,  7 May 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098756; cv=fail; b=JUWMFKlSQxKpLrMC6zhVSVFZXjzzBZRxVutSJb5wsYTuew2JtMM9vl1JGs083l2A1SeASLn5RPz8PRC4uIw5tR3+AurEBKk4ZKHdVERC/alUbFJEEpUn7oa9Tv6nQDGWEHdT+65/s/mvKtN6jszySYoTG3lQdhcE9D5kR6QitoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098756; c=relaxed/simple;
	bh=E3EnNBaCrBqi1xLK/yj9vR+bXtZQyi4tyafp+CUXQy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LSdB155yiLaGqgvo+wo3/cwFioxWrl/He2zwXMRGCuQotGJKkAd+inHTvVqImXrjHSw/vUrib0noP2phCWUzLy5Cg1X47tUTWMATq8T+0FLdhbbHnlN2IGvs8Dv+RkeZUMKxjZXxcjVZQ6NzUEL39FKE0qtCF3Ecc5zGIzzxNN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=esRV53WM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BShKId5r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447947QY016601;
	Tue, 7 May 2024 16:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=PdjQH7ndETKUhbYg9P5vMSqQguE1LmS+M80bmGHyeN4=;
 b=esRV53WMsQUWKJHELPmYZK/h4E937ef/tlJdEnHrRrCX6SGpoIjpw17j6X40gc/edtJe
 opyR+vgPn6ul2KPTpMWemwZEF2ktHGXoeDBbuWNTH/xUuUutfAePH6pXjGxJm3APOaHh
 XaHzlov5Fv3eEFeoPFemg1xCxImW1w+a8MbsW8W/ofJj6qg2Dvdcg+Xu5qYc8VY2DUdY
 QSC8eiR2/86bjW4nzzRq1J0rNCK938PlU11PdBv4FtQLxdIUe/KprLUC0t7tNYzb9vhn
 bKy2RxM3BDwA0ES+SoROWYpX+PD+dPViMcWhSthEtidcTtXepfHKF0bQTZKz4TftLZb2 Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt55eav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 16:18:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447FVhIx039371;
	Tue, 7 May 2024 16:18:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf78dbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 16:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC/mKf6jUV0aUemrWJ8UOWM9pTvEIVlZ3p92ru8zo38uaLBYugE5yQtX529HAb2dO9miDzx4vnIhUK28W+HgB6EVeDDta5Hdrl2hlmknalCu8J9K4lJ61xQYx9m8kz5boSrNZLDcTA/2BXNaG7ElZuv5kJWSEIsMGVhuHuMoEQf5jQ3VIM04oGOS9s6oMkufRPexRsv4q7I4Pg+xfn8NYWDZWIkN0ato4UtCwqeUq9c79x0qXoemOz5IrAw6Kd6a4q9weOQTmXhuC0IIDdyxi2YmoJ15GWXWVOIFV8+r0d1Ovl/5YBLUwEa+oFjZKng78AUyqgyq2rEc6ASn/D9yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdjQH7ndETKUhbYg9P5vMSqQguE1LmS+M80bmGHyeN4=;
 b=Cl56nCuEDnDHo0VzJnIAElsgLSeqVHKhzftW+HoEnRdZKKmGFOP2uizQSh9+Jr5Y2DfKOVYOb/CVxNz03JjA+qSHGiExyk3Ypp5hVGN5nr9Wenmf9kNnO2uFnXYF5lvhnkbh/frQd2AyePHIi5CljX+UItkDEO1edL0DimfdCsy+tUZ+zT2yB2DJt5pxwl6b3Rr1/c4QJTJEprnFloOPWAdLUevcVe1sTe5oObzEiFxqmmJz8MWvgODuzIJ6jxsrRB4IuuY58e8JjHhdyJgZg5JRuFjlo6GLGgtIDO89nz+VtUJ5rd1Mj1jWIK5iqXmSACK/JoUaQOopYwTNiForXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdjQH7ndETKUhbYg9P5vMSqQguE1LmS+M80bmGHyeN4=;
 b=BShKId5r9ESYrsFX36v0UFZIpyKixzMogkch8iOa23sk3wdhiCHibTFfNkCI4TwQAMackp5iux57uLVmK+LtAhJG2RcsPaSb+qfxKcUzTc/R9THuRQzD/lMGgDBdYjYaA86WSZMRpjPuVZ+PNYDF1W8GdvEYYa7hVmaHKS+5F3g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:18:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:18:51 +0000
Date: Tue, 7 May 2024 12:18:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <rfnxxcbejlysbmwgslpz37jliuhaghynipymjzrafs4qoyf3dj@g6jubiu2jjay>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
 <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
 <ZjpSYmgNdmIAF9su@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpSYmgNdmIAF9su@casper.infradead.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d8d683-bb67-43bc-668f-08dc6eb161f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LDqg1HS52T0/gz/XhRO9iNuNTpv78cjkLSdyhgBdQZTYT6GAxA8ZVvxRQO21?=
 =?us-ascii?Q?+O8NQ4H4NtqiEIV1r3u5wiPlDRYV2Qal3F52tkTQt3mn1dueQYWTXZ+X1WrN?=
 =?us-ascii?Q?z/G2CMcMgXE8pc4mnl+gGO0RKKXyumNODBQHSe9cRaxASB1ykb8XrG0Dd5HX?=
 =?us-ascii?Q?zhocPNKmCYSAtgLQIxmC8JqM0hpNyohLdC5mJMK3CPvwZ7jLOVbBD49HnbTs?=
 =?us-ascii?Q?AxKR+c0L0BOwFveZNKtdrpOza+fAGmbH3ugy+TO8l8JBlvz+4DnVLSIVKsOi?=
 =?us-ascii?Q?1AjZ5WhdNT5w0dq11EKM/ixrL6uRkHdvv4pjCdAbrokAOc/5DcsxwSsrn3Nx?=
 =?us-ascii?Q?44S1bIN/jPpS4iHw7IQQZs0kK83ew/zECt2zFGc8u70TiXdFNtbI/XQYP3pL?=
 =?us-ascii?Q?Elpj2TUV1N7USXamsCIDnkYhw7iQiqyYm4C0XfC5olMSCLS56/y3TeubW9gc?=
 =?us-ascii?Q?EHbgsILywMmynlAGSXJ8Bp+1ajulRGqubI/vFIeRaA1ruoz3TeZGbUx7TE7B?=
 =?us-ascii?Q?S6IZJGZtG6+f/v/HvS0yRsUB6Ad/AJnRqlXJ9UC62h+GfBoehtyCeY/ABzrQ?=
 =?us-ascii?Q?/kBufXSzaJ3Gn1yDekU1SlYmZrPzycCplhDGHC+R89H7nu71tx55r+9ITW5D?=
 =?us-ascii?Q?BYGWUukldJWT1ThzPy3gVb1es/5ZvCozVLyy7tw+MoaUhKcUzrBN4cd0Z7SH?=
 =?us-ascii?Q?WSXzt7j5+eZtaZdJBm3Y0HP9TY+UxBXoh3hL/68BafT+ywHRtn2xWG0IVxAd?=
 =?us-ascii?Q?X+kCfLlbKSnCzACFrCSOCOpSci7xrr25DbZ8TbbCvvtxkPOyFzT8rbGXlENz?=
 =?us-ascii?Q?iWvrTfhJDva2+nvTU6kNkLaDy0yAKuXqvA3cbBIjM3VHYTGQf5jVPgUOrxEU?=
 =?us-ascii?Q?TBduLO59Sgmu3BDhpiPZ1FOxVQBbrpnVFJ6oLk+iPjnVdmaRhWQArgd7pu+m?=
 =?us-ascii?Q?yWrfnJEYkGmxwp/Pp/kO9/Mhv29w0V8PL+46g92iInEcnflTXREtebOl7Uo3?=
 =?us-ascii?Q?CFhzYS5LrsxpDv8y17ApRt/Fk2G2/Gk6k5JYok+o5v2No3ZrDgNsp7bxGplC?=
 =?us-ascii?Q?zclGJWQU5yCPKwMjUbhzjnRkhDaODctRFe4nl4LwfzpC3EXtde7h4hBK+pWq?=
 =?us-ascii?Q?1+blu6jCvDZq1ZDL1lhKWbj9aHpN8BpiGYKgmrQl2gdrcS3tSS+IEcW1oagC?=
 =?us-ascii?Q?FsGo6CMmrf7QsOvJ1mpSY5o+CyJmWILuTi3B7hT/eeFMZ6iAYBlOnQqEcflJ?=
 =?us-ascii?Q?VYz5GkTXPkh+UgDfVGXIoTKhXsZ0+azO98TwIRGqxA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WQnEpxs3MeJhBzqd/8GEsJSQz7ZALei1L/vPCzA20A1B4bmtUI12DFnyZdpG?=
 =?us-ascii?Q?R8Bn5oe5xLt4OOY2Q1VheDYjNrDABtEavXq4ZPJI6FpZDr1NwZinGbxPwbRp?=
 =?us-ascii?Q?zfUQXVEDBv2vL9nLC1EYDxLVGg0zZO774N3Kz0CMX9PC1lnaNy6kdKJm1TAV?=
 =?us-ascii?Q?inl2hJAufZ+BwUFnQFUBFoug/dw7xaDRL3Ckf1yLuWFgwJzfBzua+72L4zG9?=
 =?us-ascii?Q?XW3Q/jpgOtxVNznUhK9bhVy8+cVd2gw2IAwLk32KwbMVklhKqrdTPv6283M7?=
 =?us-ascii?Q?ZWOj06EOwHjqzzUxWqRJYlj1/tH3yn9V2+9K0g3/Qi4NhXO00kTEIMSZdeJg?=
 =?us-ascii?Q?HfuZigrLgahnbtuU6RA9Dxb6ct0IJ1eeAS534RoB5vBsFaa7hoqdgkQ9jct6?=
 =?us-ascii?Q?vs8lfiEeqH8qOfiJ5ysTmW6vn+rOuAPyzfIIKTLO7/cFdPGySTTh9gl+MJy9?=
 =?us-ascii?Q?olRgDQfenQr+bwNK8TB+0VqdEn3v2l5yjAu9NBuonp+UI+DfP+UQHSCO4leN?=
 =?us-ascii?Q?/2tKewqb0LddW3lcnYJqvaAH/elMvBt1yOcCnzd8INCL2VefqP4Atzys/0uM?=
 =?us-ascii?Q?176o3sP5H7e05ljDkHmqqvPPX357lahrNrZI3A6XuhZd3zJlwP961LmkyNEJ?=
 =?us-ascii?Q?B97pNsIITbY5nSo000L/ylaxRc7OAfhL8bGAIfwuqlvJmCPVTNQZwPxbXpxF?=
 =?us-ascii?Q?U2xLRWq/LTb5AT6gQ14Y0VyP/GzQQF1uc5OSeI8UA8usfNNOJQ4OSWp2hc2j?=
 =?us-ascii?Q?NpvRmUuen6WmVlhL+45SG76E1wWcOLQsiZZ10C1DsUaPMGjuXC/mtOnY6FvR?=
 =?us-ascii?Q?XGmgksKaVov4xiEx053NB5DVAHAbHAnIQLDw02g950j3TQSYoqlkb3WaE54h?=
 =?us-ascii?Q?9cBKVKow2Q/IwCD4vOKQnb6xaPQutrRpYiOTH3/LbTRG7K3wm5L6v7dl/Hk/?=
 =?us-ascii?Q?K6lrkR5uF5PCKVXVKpbgqoDt0bbUltcf24SUSgeULGbIGLNYT8ApRVGodi3q?=
 =?us-ascii?Q?qr50yuAjRhBlYtwBVeHs0syrJcL0SpjeztwZxOwebbUhiLm1tcoSEB/7rbyj?=
 =?us-ascii?Q?Z4G47S+Vq+34XiDPgjo2P9xx6fL7wV9kaLZRXpsG+rcaBjR7JavObdu1W39t?=
 =?us-ascii?Q?mejWAbYV36z3Tdcab/Yd0/szBblSB2C+VQOfNBanrWfNaGhX4HvAm17gUx11?=
 =?us-ascii?Q?+L0QZZvzG2JGIPa5qIAPpdFtvP5hM1l7CUkUC5XtPy56C1Nzodu9piO9MJmd?=
 =?us-ascii?Q?WUQd+drKz1j4cWqSiAZdKw13vtZBnWQLHDQa8h6uOYC37TtHsIfQ4EXlyoR2?=
 =?us-ascii?Q?pLcooGAL/SSsuVKW7VYBluS2bskCEhnLc5OI+hnkXI08FSnNm7aEXeWkl7FD?=
 =?us-ascii?Q?miUdVaA8r08gHlW0sEh0k20c8nPdACfedDOmgcwuMmwiaHZpKOJ2EgRsdJCd?=
 =?us-ascii?Q?d+VLj8AW3pYjh7GofGXny7WQ3P0/573xqKmswcpivN3OMb1TlMEZ/a506y/B?=
 =?us-ascii?Q?P2iy212/HGexW8NVFi8L6FIpdTn1ZSlPzq1vxT/m6C1gZk+y1/15YvS7tMbj?=
 =?us-ascii?Q?eBiPVrMEuYmFvLtX8N9w4wkMCQT2Oz0sZEHIqX3k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bWYa3m/e5jeJxJtjzRc8Hfgs90juxqWdIAGfG+4S93VZVDyOC6XLB1QSGdBTtRpyOXBQ2IzL+7Y2nNB69daRQTAZNnznZ25djmt0B6UI5HFXS2acB6EaImGj7jw5Lnpx0SjEEYHhRN28nA2kgAbJwqVU0RUDzUg5z1kn8ULSG7FF007mlgU4DBS0+un/IbAc0WbeCrzY6JpKC8dnUWnxqiEGHqMZqhu1TZ9h6k1Fno6D8V/xZHf5T5ukTP0MLIzfQ1SEcyX+Pnn0lyJQY8t6t3DG3sHiv5ExjK9axPC2SChUr1tPpKnDuPg7hGiiLk+k4FCGbXh8NEY2jbZmzGJdbApmDn4gDkAzW3ANIl13kjMvZYAp/A4IxEA80UfMXBjEa3URFEHwxFFkgRBrttmaTmT1z22tBLrWqnXqbEmWR2ASbtxbPLF7hKcuBO4Bn6TlrPyLW7x5Bf2dw5H5tOk0JW0DRh7MH5y6jpQtip7qUX/Es/cbGbiG2hKd6NREDP/PrCCykJFjvzI1ZBHmmZwttAi6p6o51qiKg0rr576q2OorwfaJGez2oDxRvPJdXtp2HbeT9Dibrv1wxIbH8dcXagYl81lLAl76ZBWiCKV0yVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d8d683-bb67-43bc-668f-08dc6eb161f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:18:51.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eA4yrBDNWU44I4yX9XHCLgcFMvfy3bhFbhk+tUVDVb0pofpOy8dL0Ce3z0QXJUiA37dbwAztmTx//iHo3hl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=831
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070112
X-Proofpoint-GUID: YWSDDc9qjWD80W0pKABtcPvdgc98gHeb
X-Proofpoint-ORIG-GUID: YWSDDc9qjWD80W0pKABtcPvdgc98gHeb

* Matthew Wilcox <willy@infradead.org> [240507 12:10]:
> On Tue, May 07, 2024 at 11:48:44AM -0400, Liam R. Howlett wrote:
> > .. Adding Suren & Willy to the Cc
> 
> I've been staying out of this disaster.  i thought steven rostedt was
> going to do all of this in the kernel anyway.  wasn't thre a session on
> that at lsfmm in vancouver last year?

sframes?  The only other one that comes to mind is the one where he and
kent were yelling at each other.

