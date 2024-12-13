Return-Path: <linux-fsdevel+bounces-37372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28F9F17CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599D318843F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D6192D6C;
	Fri, 13 Dec 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbpHC3Tk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rmml/9uR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060E1EB9EF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123898; cv=fail; b=MvkNdZVupfrJyHAyJl5aP6FXryfEfMSsWXgiUJtsRiT2Fny21zxi/l3D0WuefxZ2pxIkgKCQ4VnJnv1SNYZaPIO5lvge6iJRcytK9sNC+6O5NQ4tcXeQcoya0jMFhRWrQtC2ml6ilY5uf2O5oWxgeCeDKtczSN9aBSxNnA3WbSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123898; c=relaxed/simple;
	bh=K5RqlIrhSWA575/8euqzvtmSsJTCiqWpr5Mldo4kljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwL2nUtbZ2bSMB7qvuPr6YWWTy4QVqPv6UycHFlkofi1dzlk9WYOIsDuQ3JEYw4GWBGJjJG0/HnDoOUNiBaNWB9kMG5Jg7xAV7apFne+gJDYuBu9rYvg6X5gVae9ZH2dvanYrK1S1xzNXmbZrM7ehKgymE9eUgr9B8LfVdc/wFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bbpHC3Tk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rmml/9uR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKC3XG027615;
	Fri, 13 Dec 2024 21:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xh3VSfCdv8HWdDNzju
	N/lqzVspWkJlg6yyt5VDMGRCs=; b=bbpHC3TkKBvjM/4qjLVEx5LbVHw9658mS4
	+dXwfFTnTrogTwJ8A2DfbKCsoU10bf/oeSPHObwSIR5OIl6RHStzCTvOs0W17rUZ
	rj0Mz5P98svI7+pg3q3yzv05hB4NedRghoLxnusQvKGiOpvUf+o5zGUKzNMnFX4o
	HNS2v78gpQu2UNke2B0Sdqiswua2tIRyHv94TthrtfW4gHjl2Yed5DClxyIr64qO
	MALO03Cdu2EgfQqrxUVIiVLKfBcCd1MyOdqoICMyKayQiS9RabXgLe9sYjHLEHzh
	LbN79jr+19WStsRI4jm7YxZz2+jLrzk0/QNMXJoIlQlwPJ5TLY5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr6cc5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:04:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKjSkr008592;
	Fri, 13 Dec 2024 21:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcxjd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk8cw96A9INiZd3EJArt/V1jDN+N+T4XRAxjuvY6aCGM9bHHGmd1BO2XPw9/wdS5/gNyQFY1rnE4t7iUxDIrBfsK7OaEVze7jXRlw+NDWWnv43+tS+lRoTByUyLfLHzPA7vXnuzetQBoIs0TX65RHLUFyHK/09RE02YyYIEKZluNJKYBGAqR6G6vMP2T/vKSALX/KGj8DiJOUYS4xvYQqzsNJFyYK/f7IbOHCCpB6/2+XFnhuCzDLfMMe6+kt8/f2aZUw+myehOEzZXUPHPqLpgzCZupGjcG91HGwR8p/yK56QuxoeRSOrASWY5cnVXuxCQ/A7aXMAVBf7YxiqNnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh3VSfCdv8HWdDNzjuN/lqzVspWkJlg6yyt5VDMGRCs=;
 b=TbcNAS+HJH4DEYe/Wmg0IVIcPzGPXrUBmpiIDeO8UVRX/TfBlmTiT7hoqeG4VfwOiLxweL2kPX0cxEart5yUJXEzChi009weUrgz0tsEDBqFbtjpO1JWK5WJ4Phc/KZBPAF29Q49lARrL3WjLpI4ZUXvMZYNmLEgr0Od4jAZRIiNytQnlCOfIEA69KZPqHotVlSGcjd0jIP/6QN7ifxrH2n1Rgd0kEHFJPglrHZKgBhtqy5bBqMigGQeHqorATJsFcTM3EJuC+x1T5XuVa0k8eg0o5qvA7t90mBXVhL448rMO8Pk0GJAmRKN34/KnSOkPlFe52HY5trjvxjEApRGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh3VSfCdv8HWdDNzjuN/lqzVspWkJlg6yyt5VDMGRCs=;
 b=Rmml/9uRYcQWxubss+3x4sDp/RPAeaiPJCESNWg0BmcSe60so55zZcZ+QUsINPOd3AOYNBC/Wkk22RI0vIkViz96veACMEOTBiAQ+bOD4ETNTUqadJ0+UQgJ9lsolnfWGZH69fAgdnQ2PviMRoymu/U5MfC5viRD29olhmGEXC4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 21:04:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 21:04:44 +0000
Date: Fri, 13 Dec 2024 16:04:40 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <7tzjnz4fhpegb6y4fzjt2mgjlbrvuibkvkh3e4qd32l43zeh2q@43eedsimunw3>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-filmt-abgrund-fbf7002137fe@brauner>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: d77a0b5a-ef3d-4e54-7a6b-08dd1bb9c440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56l4XK94wDWIcK17jx+Yhoc99iTNqkN/Yij2oFL6Z9Yo0a7BQ/uAupBSQpFc?=
 =?us-ascii?Q?b1MUke1Hl+fd6Y512CnPociBtKoTnt9UWz9TQnBmqx0W7IXPB5mkOHNzSPm8?=
 =?us-ascii?Q?IL+ZI1cDBCtusWBaqmR2t79wRB1pOhmk6If8PmlQ/3Kk5rZNsWYqJ90ldt1G?=
 =?us-ascii?Q?Ut9ZGZeUUf77E8/q2H8aaEecqGn0MGJssVgt1SdUdNe1Gis2uuG5E6yjpBXN?=
 =?us-ascii?Q?YMIpc/PYiU63zRRMVlN0rb0H59PuOFWsY3XHDO0SiVEpYzTfPbJYxICb/CB/?=
 =?us-ascii?Q?uIoENVws5mvpvhHMNWihG8b3Rj/iswofWTkjnsIcwXRcVmNW8/WlJhwQzD2E?=
 =?us-ascii?Q?5vyGKziH7NhJL4ThKsWHVdVIuH2wPGVnRGXzFPsqEmxwwURCYCCIh2OsB1Z2?=
 =?us-ascii?Q?iiELkPuDjKWpd1pLM32Kk3U9pLuIkwxDqUY7H5pwbKslcYfdld1gpRvMsd60?=
 =?us-ascii?Q?cSfdf082hmim6gnrj3Ih/BDvDZgRdwBdlsl5TWI37kgS2Mz+/vuaofQCqrXS?=
 =?us-ascii?Q?PU1PSvVMHvXTGlrR8MbaAwK2uMqorI2gjRC5pDx3MkGhf5EFIbLOvMUkRyun?=
 =?us-ascii?Q?R1Rf6TqlI3yzM9KSqX7n88tSm88dE6AcC8M1zNOX8jspDRyoD378Rvxpgz8U?=
 =?us-ascii?Q?axNezZ8ZZPKNj5uVuEnve1/IPO6GZZWao4O+rn2LppwKY33o6vtruItB5BwP?=
 =?us-ascii?Q?KMlDCb/A17zhgYfDw++2/NpmmQAclzJ2tjCyslArhsCHNkAFSKiEGPRWswqx?=
 =?us-ascii?Q?qVqpmj6b5+10vR/Eu0mQj2fwqP8RjmDIdqinth5GXFSiLBw7IHWDEtYa/PA5?=
 =?us-ascii?Q?n2AJo/3anbWrHQo0I1rebtjl5A4XD4uQJMUmD3jY/h70pyPK5hm32GlAqzJ9?=
 =?us-ascii?Q?vi7yEvaj5BM3LXHRYt3bRz53iEeug1AxFknApoiOtiiNrK0qxqswT/tQV3F/?=
 =?us-ascii?Q?milCDvkx6vTStJmSKsAepkCZsAWdp51THhpqx3YeoYP5fJfBDbc314vIsCoK?=
 =?us-ascii?Q?RPlGAAc5/EG0/+i2RyxMvqWA1zsDNgBaASVuzKLAOpQUddvqlm58zgPd2RjA?=
 =?us-ascii?Q?KDC53O+qSVVzWFtFvokt5BkapcahLyQ2kck0q3J1CCm6TYbhIiyWovshZHrp?=
 =?us-ascii?Q?JeGqsrzS1Ro8k0Ve3iNu0Q+cVWcNRGg4lKBNrGbGAeqg6BVfQtr9fdzJF8BY?=
 =?us-ascii?Q?e48UAVkbSctufjuja9Y/zQiClzuroRBDZnFTpfceqBNRrVm11rDxvaifBhob?=
 =?us-ascii?Q?h5YlHjiSBUAlZd9KuyyWkTD1bCg79+5Ydv3okhPFHetcqzPGAEwWXGjOZ/Wa?=
 =?us-ascii?Q?sDw6KDNIuemrwFyJArGqBCvkhf9K8J5lhDvXz3AhIPd/cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9vtgS8K0NJ4Ng9nOKLP7m2h5OgKZFjoHomvPmUkiQwCy3QLlME1Vwn+LEcc?=
 =?us-ascii?Q?FhImdO7fhQJYnexvO+8isG6hb35RQNBUQEQ06VJUhUqkGXPhNVR6D1lBCgFN?=
 =?us-ascii?Q?Mxzy8sB3jXhfz/J4BSAPe5lE6VXEVj7mUiIDcQ+eamekeSSm5XDvEHoaTNJB?=
 =?us-ascii?Q?diilaDhxSjtxRyZO8NNV+YjWGCUFeL6PeBVJVmgqnZ3AlYh8PU73HhK6fWwT?=
 =?us-ascii?Q?g6n/Au8ISEoFN0yR87Wl6HjMPplp3bbu48zqNLCrUvwKaBq6ggUemdauhvod?=
 =?us-ascii?Q?ndLhiU4cThEEF1S7b65S83hjel0pSOMgZGtkC4req22tDNKrVmW0rhK+AIrp?=
 =?us-ascii?Q?6Vv12+0HCuzf7F/+wbG3/L/S6gUmeV9+ecX4iY64vNGKEohHSXTdJL83Dma+?=
 =?us-ascii?Q?IwqjXcFdsBV4zcfJukX5OC5MM402KHRKuBXwqv7HMnlocen/2YEibQJEZO/H?=
 =?us-ascii?Q?CcI9KTNOjqE+GTIggOkk8xVg81nqvKYovBnZPb3DTaAvIDfdvNZHkOas12Kl?=
 =?us-ascii?Q?ytW5pl2iZLjRVFzqbg5UeO6enc1wyaMdK+u2z4etcEK5JqIxx6ohJjtMoKIB?=
 =?us-ascii?Q?jUU6Y5S2HGDTXSgvHLJ6j4OzVYo0m5pr9BIPVK/iCLFKtri3lQOGGJDyaNBw?=
 =?us-ascii?Q?nDRXQvJLFIQe3G5r3LocwMhlJS9kNeNWfnB1reFfIXAyVP1MQIxMO7ewl7BN?=
 =?us-ascii?Q?iyOT35J5ZlB1GIl+7WILdlJX6ufqvx5IPmrWQLNbvW0+9/AdcKOU236/Gumh?=
 =?us-ascii?Q?qPRdY63qaS8zQj9aE36DHzeiOnZ8TGCJwJCc75Oabnni7jC4wi1QahgcEhS8?=
 =?us-ascii?Q?HiSQU7SaHUTsEesEC2bB5d6rQhFm5rqasiFVFiub5sxme8LVcC5yrkKH6V3r?=
 =?us-ascii?Q?yJ/RzarG+hBmSB23zyouT2Mv5IoymK3N/oInLwTP7ePR7khhAyUOvIIgBLU0?=
 =?us-ascii?Q?WiuzKFBMtmivVKgBgnCNcUJT5XUyOjGcw+ew6PVwACwX+2SM+hnIZBiqjD9U?=
 =?us-ascii?Q?sMJcf9LiMcJNjWAw8bOREMD56we9I6Cgfntst2sAg0Mvk4YI7sdpXCIGzPt2?=
 =?us-ascii?Q?2IJEXx0BZCXlybgZAeTy06Z0zilWImC5A/GEQLCBZgN0/Uik3uU5cgStmuzT?=
 =?us-ascii?Q?oLT6y2PfpW8yGUUJAc27doCnCBgwImGSoo/yFqwAICyNAdXBcTAxJDhOwE0P?=
 =?us-ascii?Q?pPknbtMM6dvbmouuGQvyW3UMZdAim9TFkVyokCv4ZcD+493Bo4sMI9A0Kzgs?=
 =?us-ascii?Q?rwqFrqORqzXE/y8vBHNr7M0lWIzSwze1lQ8dUaZbUQNkorceUGOAaLjJ/Ntt?=
 =?us-ascii?Q?CTGxfkxv+E6LnV16p0gDStq4pPDj9YDCc3O+87+rO7AIF+U5haBkehqj4JEp?=
 =?us-ascii?Q?Aap73xoxrSfG7TXlpC4vaAwZAV4aVnjFANGIzEORLkf8lTB456XDgVJDobnV?=
 =?us-ascii?Q?xr8VCoWWwf/aIoat99vmy0Lahb0lBulHWv4U1aHXbYrCuWEAjKMtoVL2YqA3?=
 =?us-ascii?Q?r//tlaj/efqscfODLESct9PIxgOiWcmB0qNsQe3GBzGtmFhOgxBccYv/sZIw?=
 =?us-ascii?Q?K12RHglu4uipuoUwwxQBYMo9g6YLPZP0WKt0phHA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ufI+4qNu1eKAXgQxwkZRI3mcApX8L/hkt0goHysCfHueJySATi8ukyFJA0AXKJEqbeZvYUTa+IMGbj7yhKvRmS/C6INmtoYxOhbCbsCHAV/WpWSwsRoYDX3rms+zXhDpHMzFYrqO7Lp3r1c9HihkyPsaGrxrG692M0/JvG3sj2wTBWhIcHzSP7/QkYdq73zfYV1HXIaoD0Hp7zJb4Hec7nhLK+wGSODkF6DiD6ZBtRriqEoWGZScGX2qehNe9PSc0iNEb7W9t4brsgIc3KN9hpcE6DYxli3+trc+6YnV2LcgBoYIKBJi86FjJFKKGMgDEkApxgnwp8jKrIL+CnvGGP9TnfdEstljVu/ZIfr+ZTkZ65R3lZMUKY7k6N4+a3YKjkiL3Kn80f3ZJNkyOxmjmGd6PbknkTwdfLpjbyKK92XKge7zTiOV0XjeIsKkWBU1UxsPgjTYVjqzlb2Ftss/ESS+iYWeLr5MXOdDpx2ulpfO1KLqy6KTrW95TnyMDNXzxSLIvA23OOODlWZEzLwnfpmE/xLaMqwVzBLQFGHvaSP7sT69re6Prk/sTaKd5am+B4GG0GI2JlSaU+J27CA8G+usGoEiAtPBkp7eCpLtBGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77a0b5a-ef3d-4e54-7a6b-08dd1bb9c440
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 21:04:43.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asehi2BbuVtS33L+Z35fFre2b6n0j41ZvKDoSYaiZjSG3HvdUVMKEOdIJhdzHLaPUnrWd0w672XnfxK5qJGlsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130150
X-Proofpoint-GUID: GoaAz_dsnw8kQMKskILHX57FmneGdeRT
X-Proofpoint-ORIG-GUID: GoaAz_dsnw8kQMKskILHX57FmneGdeRT

* Christian Brauner <brauner@kernel.org> [241213 15:11]:
> On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > I've replaced the macro with always inline functions that select the
> > > > > lock based on the flag:
> > > > > 
> > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > {
> > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > >         else
> > > > >                 spin_lock(&mt->ma_lock);
> > > > > }
> > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > {
> > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > >         else
> > > > >                 spin_unlock(&mt->ma_lock);
> > > > > }
> > > > > 
> > > > > Does that work for you?
> > > > 
> > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > close as possible.
> > > > 
> > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > as appropriate.
> > > 
> > > Say I need:
> > > 
> > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > mas_erase(...);
> > > -> mas_nomem()
> > >    -> mtree_unlock() // uses spin_unlock();
> > >       // allocate
> > >    -> mtree_lock() // uses spin_lock();
> > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > 
> > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > retake locks and they need to match the locks of the outer context.
> > > 
> > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > take, no? Any idea how you would like me to do this in case I'm not
> > > wrong?
> > 
> > My first inclination has been to do it via MA_STATE() and the mas_flag
> > value but I'm open to any other ideas.
> 
> Braino on my part as free_pid() can be called with write_lock_irq() held.

Instead of checking the flag inside mas_lock()/mas_unlock(), the flag is
checked in mas_nomem(), and the correct mas_lock_irq() pair would be
called there.  External callers would use the mas_lock_irq() pair
directly instead of checking the flag.

To keep the API as close as possible, we'd keep the mas_lock() the same
and add the mas_lock_irq() as well as mas_lock_type(mas, lock_type).
__xas_nomem() uses the (static) xas_lock_type() to lock/unlock for
internal translations.

Thanks,
Liam

