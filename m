Return-Path: <linux-fsdevel+bounces-55528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6300B0B55C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAD41627A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7281F4168;
	Sun, 20 Jul 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nVBSfPPg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BfYuyrZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8972E36EE;
	Sun, 20 Jul 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009541; cv=fail; b=P1ENS77L4Yn1WNQ8A90gUZ6ffXz9J9wuuZr08Rc+qOpyq3EY2rKe2HQ6IQ9G0TPZxjmB5HaF2XLBJ0CQH3WksZF6eFDTcQmj1vouOUeY758aFY5SGeCQQi4+BQxwxpH63fa+6dxFifI6Y5TTV3fLvDGgvv0X/Cl89QogRKyKiyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009541; c=relaxed/simple;
	bh=8BZm4KYkzukrczBVGUT4BtH3/b2M2KiH8rp9igDTaSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwpkqaPtyslv9MKq//r0hMUAwScwm2CgBDGxYsSUNUUqeo8yw7O9SOFvwBU/HK8H8GJYrizZp9bMlhS826xZpHNJ2xWlF1YhKtyB5hCAmuGkIh6oW5zWKsJAQ5saFch0c5ECVXb4GWFsNDskXBO6cZQQ/hbsnlWKP9E+wp9PTW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nVBSfPPg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BfYuyrZ6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K4lm6c032040;
	Sun, 20 Jul 2025 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9FVVB80wixZwXbhy7Y
	PDUs1vkgBRLRDvh3ZhlcjnIVI=; b=nVBSfPPgbS8xGTZzh20yP6nDuH1hsl5O32
	POReoEC/9SsEgQaFQC5G9194jszqwiO6MJ3y3PyxMR/L3pKCbP9Im80KLwCaV/Q/
	cde7uvR+waZtA/BuQBpsdtYfb7faw85Pzm4DClkCd0GH9epsj79OkB5GZ6KEN0Rh
	lpzBC8HQbG6fVA4UpJxy6rTbcvZy9WbNc2STisuYZSnFL8tdOb2TyAYPQkJLesAf
	g6GY+iUn/quVXmN/0VE8jiD8gcWfst/zu33Vh10AhXBCnA+/rlj5MipjPjCQ7vJW
	s6CYmQ/2wzqmu/fmxHgTspvgRGW2mW6dOm5aJHNtCt24QXugQfBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576h6h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:04:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAmLEv010797;
	Sun, 20 Jul 2025 11:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t74f18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDQcdn+2/T+fNpC1xDYyMMo/vfg0psrPO43RHKebExbMgFmlz4J3WfkcP9yzHn4C0inzHutIV9h70ZCzFgj8yF0z/h6p1WZ9noLe6dfW9eNpCeM3YJZuqcr2hyNm8vdUoZV3dDGcSkThfJOYSvz66f59SXdMSyjcw5DS6YkO86L8RI2OUOs6uDs67YkHxDPcK8JPY2Dg75elfaAP8cjo3sWmgZGhxk6slafTMNVlsjZLZ3odYWa2yMEKefdCoYGSqUpv/6RmQzx+DTIEucCvN6arT+Rqhz5ka9W/mWZ5fglFo0Xs4YbVC0ggP2XR758Fe2rQfbSArWOb6rAjWlLXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FVVB80wixZwXbhy7YPDUs1vkgBRLRDvh3ZhlcjnIVI=;
 b=xIQq85BUdN8CgGstjd0NTduRHs+9g0E1Y3BpVub13EUFR10lbDOVubIZ423rJiqnOz+WKLZM2cKzinyacC1ecdacxbpiwfJlLrVP+wQMsA2quX+Tnpv4v8whjkU2bNJu1R+hiVVluRI4FHd/LHNzOSpdD52fuENpgF9VHQzon0hnvJTzu2iYZx11FARBOsoiDy8XvUy1gV5tu4zvGmc1bIZlEOlQ26nTVaMCp5GP2PEgelwJ0TRT+n3Uidz6mjiS+J17dGwhOBCffYEOCBpnzHQul12qCiBPW+blSfoIqdFzXTuP2q0B3gpHAYoJOKLvPvBTJKDz6Wb1Ta2LU26lMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FVVB80wixZwXbhy7YPDUs1vkgBRLRDvh3ZhlcjnIVI=;
 b=BfYuyrZ6qNxrMEy+B+Q894QC0yI1NXASEQ9mrCO/ad1IQfGivm9KRkTYh2wCCH1VKB/SsVfk0jCibFdJVDRFRQdVw0ZjVnnG1Kb+4djtJaV8ssm7vNC6cgv31xE++wXL3v5enQyU6R1gXTX+pehsL6P23l3DbEoju64B2D6uvB8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Sun, 20 Jul
 2025 11:04:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:04:45 +0000
Date: Sun, 20 Jul 2025 12:04:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 06/10] mm/mremap: check remap conditions earlier
Message-ID: <8fc92a38-c636-465e-9a2f-2c6ac9cb49b8@lucifer.local>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
 <8b4161ce074901e00602a446d81f182db92b0430.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4161ce074901e00602a446d81f182db92b0430.1752770784.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: bebd8e44-83cf-42d9-14ff-08ddc77d3bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IzMMeoLTnzofTAUatytQjBjjbycdP5zxoRmHJSSqZD5ex32zQvKKImIG0mQh?=
 =?us-ascii?Q?0a/4KHFBOYoWVULrFB90PQeWqKGjFitu9jeUSXMyDKGg5raUzWDncXldwEFf?=
 =?us-ascii?Q?zSvltHoFbc43/LbvxH4bYhOeEA9ih672UmjzL7Wb4docQd7dVhxP1mM8dIOX?=
 =?us-ascii?Q?1so3lT+7aRvBhSaOFp6j0hP3lgqH1HDKAkqVJ4VsBrzcaIxinhSnkD9Mrq/1?=
 =?us-ascii?Q?Xdj6T2JUpcO8BwSaO1McArp5Qm8Gcx3FJUypPWWS+WTnFUSzQ/owDfNQK3qy?=
 =?us-ascii?Q?nJSIuZI+VoMcqC7fUXJfQU+JI2tWKfh0Mi7MxRtxvUipzgWtLMWwNNdK7wc+?=
 =?us-ascii?Q?k5W5gX3o54+VaZk02N23zHpGIWByOmy8aN6JCtdrCMy60RZ+SWpTLhPUfdL0?=
 =?us-ascii?Q?ZUeH2xUOLNyKVyw0/lPDWiI/ycbaMDDs+qnuGNmuwELw0Z19k1NESWcQ8tD1?=
 =?us-ascii?Q?DyLjgf88P4Uyje8TVVbOqCoQK7tQWykB1dMLbxI7zCFbpNhvv3oF//m+Mmon?=
 =?us-ascii?Q?/ioTxfT28MN0coRcX+T03W+EcY2zWcS7A8pKOXs742Za4hiYynAEs2koArEy?=
 =?us-ascii?Q?hsBIU5MbTl8GXt8qA8W2zGFgWOQclgMrsYJ3PoD+TDPnao3eQa949JnFzE60?=
 =?us-ascii?Q?byhvtS4HTI4Ubg93RxHos5zVUZgFyKHhkzFPljXGrQGvbigkMb4MEFyOgozO?=
 =?us-ascii?Q?4w9LSQUrTG/Uj8cUbwNmN8C4GP5QYxDe1Dy+V3yr8Lwvprz0evvDqsJPQ1bV?=
 =?us-ascii?Q?naAycid2UJ5HSBxknpN+Kq1f30f7V79mlO8zSPwYKdmlwMxBSyWyL6/XcOzd?=
 =?us-ascii?Q?LjqtfI16fjhnMzzoRI6jKM9F/S5+EzSKerXlS7uSyIuQeAEpeJbm1Tuj7ikm?=
 =?us-ascii?Q?EH9Lh8mRjXSJiI5bIOD2J9CkHX7ClwrFXNsrdEa5oaOaxNLZQj/59Lsq/gQz?=
 =?us-ascii?Q?My3doa/9mZV6eaEFw3hraw04PPIXcXT19jI3Py8dI0kOF9gRFCEiPR4+YCMN?=
 =?us-ascii?Q?0LO/0tqZYeVduPFHs1Wm5CeJpGjB4cdeaBOaHtpoB/NG4Vo8Au2HIOscqNPl?=
 =?us-ascii?Q?H7o8KIjcJOznUZ945qRxrVEb8RP2tXR7of4l0O3JUmkcwh0vfJf0nUMMOPb9?=
 =?us-ascii?Q?29SmJSC76/cGJcGeQiY18Xh3FVOqTEXsQ5SUMl4i+0lI5qvS7+18FqlrM8sK?=
 =?us-ascii?Q?hAvPgFJExtEPdN2bYabBAheMBBuWxbs8flB4lp9xspcxFyZDrORfj1g8xQYV?=
 =?us-ascii?Q?rtXRA+Wf/j7/ZPlT3tbv26ZwTIUQsbstL+roxrksM/MHJSa7ky2kVK2fv9Rb?=
 =?us-ascii?Q?XzSFmUw9dsLqhcehXBgoqc/vwN0kbaRYZfjuNAhSJsLjQ9ZFCYWw26MWUPQ/?=
 =?us-ascii?Q?vCLE5XiWJNXu1Sb1a0Kqwy7JbJq7/nMbL1Acw7uYwDRAwYknS81ILp2ujAKf?=
 =?us-ascii?Q?OcCgSL0To54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DK7nuyOzNE6gRqalJUrtDhyy/Sd/5t9ID/UYnKpcvfJFB5TgvlIZQaN6/usb?=
 =?us-ascii?Q?BPVeZD0qxbsT4TsMXjNJdy7g3PMhFa4wKog/M7biTN2kw5MwPpZuiV0eXVXK?=
 =?us-ascii?Q?4pcSKwzmThiNYVxbnxkdfKv2D4B5brZ2+pMvO2ug+k7/5uOOKDBEOpp5rvGB?=
 =?us-ascii?Q?avc8ASSxxaA65lwG52+NNcF1ixuVakLkSMolTeH48eolRLJnOWOLTzUBKbnW?=
 =?us-ascii?Q?aVKg1e2h5ktpW2iZF1rAFBQLLD5t7HOr0cAfZi1N4Z86OjIIKrwUjGXGt6Sc?=
 =?us-ascii?Q?KNCHsR1zA+93Fa/IYH+RphiR0Jlg9Mq1QUWMYpSx7GFIs6bbjhY0AZc5oG3t?=
 =?us-ascii?Q?98sQ0NS5NnJzWhDYTO1pHksTWUfBVcn9HwTBPv5WROrIZUWCJZdbRRniQ9zz?=
 =?us-ascii?Q?ZqY5na6Z5L/uebxtux2w3W4ZqkoH4NWi8Z1ewT8xeQ57Wct50ndBu76BQ0Mu?=
 =?us-ascii?Q?iM+02FU4sN1XR9X2fGsXVbJ+V9hPL3G5bvAfgt/chTXkB2I7pbsadGDfWthD?=
 =?us-ascii?Q?9Ncyy3FRF4y9Fsb2nbt9QSqde0h/6JaRiX33UC3IqhEGGO9jEEMvKlPqzDdN?=
 =?us-ascii?Q?o/sLSCskYva4YjFGuudr6vcyoztEdnJzoWZ7NpkIHE9QcDUrbuQ0C8WCW8tZ?=
 =?us-ascii?Q?LCatymOJ25KU7y1pyaSuJKDYRQjahBU08cFt9oWGEdVP13HX+dPQjq4oKG4v?=
 =?us-ascii?Q?zTyZN69mK/p2vfLFEm6BspB1GkeTeueMPAKnm+KzE3rPdwGU4gLxaKCw6yf9?=
 =?us-ascii?Q?O3eu8nNTsDYD96avyYzBKJNgqCSYBcoWnXvQ7l05flhWDSaEGnqlDThfA1D7?=
 =?us-ascii?Q?m1cnj8EHbKww/pf+XwNiGTj28N5CmlEsCS17lR9rbTyX2F9HOsrMNv/f6IbG?=
 =?us-ascii?Q?s496QaKMknuQderJ8HNfhcZZ9B/BRwhq3rp00zDo5eeshEkNe6VrikysccXS?=
 =?us-ascii?Q?O77Jx8DISz6F5T3uT1eXHLsosx3K7DW30v7N17WeeklaNPwiv4SWy2zuKAlP?=
 =?us-ascii?Q?B5e+IEmr6+lVnZ/ovoPn4Qinw39NPoSevD+KNyBCSChoWuP+Iv3KquSNZJml?=
 =?us-ascii?Q?RvIp/8LqmSkrPWZsMLf9h5UUaj8WtsUz4lDchxauBKQyZBHajRcWA1PEtu9U?=
 =?us-ascii?Q?LIHsM6+E2pcQb8h7WXuOGquK0P+6VLhfUe56Og1Tm7/E7mgJI2qUzwtWnoFe?=
 =?us-ascii?Q?fVNUf1f+D/OCsfMZ96qtb+WZJM8gYtbSDMpkSwKvBK9jMAoEINVOCirJJFpS?=
 =?us-ascii?Q?P0bt7U8hXeinjJGonJh4wRPHkkEYoNecU3UhVd/ZCZGizez8CAMQ4q/Wb+AV?=
 =?us-ascii?Q?U7znOGVR1TqNyz0EhVOjE+dtFVyFyKIuz4KNRIlDQKryAUbZSy2GDXm9sJlp?=
 =?us-ascii?Q?2B+vXT3s/LdRPHzUw30JVE7iCPWpukilvMU2uKwZ93VBi5XwBv2uPdOU/7gZ?=
 =?us-ascii?Q?x/3S+lBkO7o/2kIeVqw9YnuR5vBNxN4vGpp5/sy+gBOGZ8fQ7QS0g8ZTlKHl?=
 =?us-ascii?Q?PmK9KIODSz6DDpY+nD6O4rVTsQLGKEiLtxnT5sMq7NwSfnzhq0hQZAnzvtMD?=
 =?us-ascii?Q?gtZu3+3kQSzXJVdJ/3aU5ZrmqkbSUcOWKy/+M7GcUD07Brl18vP2btMTvxqZ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MU3WMXypRT4DjwwtPjef9NhqYdQCHiRt4295J/UJ86AwFAzUPxvf8hCggRVbMd6b3+9SXGm3kWkxjXKQ1USufr1wD7wlrM9Lq9ceG3bGH83/hI+y2l6KWKJUteT5oqfu2V0PUW0V/EsqNZs+kt5cElJPHnmSLghIg3lhZ13TYyX3SDMjnJukjnwjmxBZg3IuAX1oU1xfdNQlsmW8FBl7eOgRe8vqseZ5HiCHZ5tMMwXqo6UkzOK2f2RrKowfv5cy0kY157Md6B5+28w/3ivNV+AtxQlyUdqtvcCIDXPUgSuFcADEcCr5TDlmIQJ8HF1iUUlnw5lMDGW9XCXcaSCQYQ8W09FExCJeVdFEgmXltrcq3L+YLgBfdgW5R98l2fly/fMpqKAkKzBRDhC7/0rNtyej6twEjjY2ru/nQu0r/rp2nIbkFGUpztjjCrN1w4bZMQKg7ANA8Ggh+J/LaO6ivbiT/wWpw44Dk/0BH7EDqNq9yr7TUKGlTqouEoVR/VxerZDfKDVb0Q0UBLpZQYB9NskEpnM0KO8NGkWvgV7Nl2uSfs+QaTyNQwF+g1UWrt/61S9foD1gSVwfNRj805Kwwsi4yAaEGilaRUWWc31Z+1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebd8e44-83cf-42d9-14ff-08ddc77d3bfd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:04:44.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I7pQYTwdGUHdXphpfW41YJA2f5Qw2lUHgLyYV/zWA+r17UaafphhFF2fodEsc+5jVbUwd+yNes09wmg0l8RXSo1JH3r+xDy+Krk5Kjn6FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507200106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwNiBTYWx0ZWRfX/M2nNsip85Rk
 KMwLlVP6qRa2w6BWZBYVHe4PWCttr0BT9K1HyN7dr/fRXJvNmV2Lmaxz1A8fxoFtgr7z+Ea3V9z
 HIr0/dD8H6S2x2/SiEihXrj+jLXwcYSEcajWQ0h++iF7+Y2LpohW2SHJ/ziQylFytSHxrH3o0pi
 lqkrdNnv3IhMZdsa1jqy1ZoF1ykxN5hrCC7oPGQfZoXGV4B0WtTWY3rukn8mim0+6P2aJLsusbk
 TPR/4eMPiU+rZuhsbWAw5thBAnOX9uG9unTiNf4QexNbrchdRtO6C0+/eYheZZzRVqXQAo9NUpr
 SYJxV022DMXhPrfYPIxthiIY9rQOghGm2x4uy+ReU4zdMogGvTSniIWkvXhQrXDnQGJahJafWck
 M5Nh6RzHyxUIWvFGEJNTTAiMTM7L21MEx4XkQbMq5rk8Uhfzxxru8hxOmjqSKvF0bmeO/sgL
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687ccd5f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=5W1CHJM56yEcQmTypBkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4V6fym9tyLFQr9EEUIaBNQNMQzpgWKaX
X-Proofpoint-ORIG-GUID: 4V6fym9tyLFQr9EEUIaBNQNMQzpgWKaX

Hi Andrew,

It turns out there's some undocumented, unusual behaviour in mremap()
around shrinking of a range which was previously missed, but an LTP test
flagged up (seemingly by accident).

Basically, if you specify an input range that spans multiple VMAs, this is
in nearly all cases rejected (this is the point of this series, after all,
for VMA moves).

However, it turns out if you a. shrink a range and b. the new size spans
only a single VMA in the original range - then this requirement is entirely
dropped.

So I need to slightly adjust the logic to account for this. I will also be
documenting this in the man page as it appears the man page contradicts
this or is at least very unclear.

I attach a fix-patch, however there's some very trivial conflicts caused
due to code being moved around.

If you'd therefore prefer me to send a respin, I can do so.

This doesn't reflect on the series itself, which with the corner-case VMA
iterator stuff sorted is fine, but is rather just an undocumented and
unusual behaviour that it seems very few were aware of.

With all other tests passing this series should be fine with this fix
applied. I've run all self-tests and the LTP tests against this.

Cheers, Lorenzo

[0]: https://lore.kernel.org/all/202507201002.69144b74-lkp@intel.com/

----8<----
From 23b95070152b22f7432c4a9da9e4b5718f9d115f Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sun, 20 Jul 2025 11:41:48 +0100
Subject: [PATCH] mm/mremap: allow undocumented mremap() shrink behaviour

It turns out that, in apparent contradiction to the man page, and at odds
with every other mremap() operation - we are allowed to specify an input
addr, old_len range that spans any number of VMAs and any number of gaps,
as long as we shrink that range to the point at which the new range spans
only one.

In order to accommodate this, adjust the remap validity check to account
for this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507201002.69144b74-lkp@intel.com
---
 mm/mremap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 20844fb91755..11a8321a90b8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1339,11 +1339,18 @@ static int remap_is_valid(struct vma_remap_struct *vrm)
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;

+	/*
+	 * We permit crossing of boundaries for the range being unmapped due to
+	 * a shrink.
+	 */
+	if (vrm->remap_type == MREMAP_SHRINK)
+		old_len = new_len;
+
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;

-	if (new_len <= old_len)
+	if (new_len == old_len)
 		return 0;

 	/* Need to be careful about a growing mapping */
--
2.50.1

