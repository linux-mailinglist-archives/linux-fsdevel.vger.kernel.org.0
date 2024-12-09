Return-Path: <linux-fsdevel+bounces-36758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD09E9081
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4029C162F4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11855218ACD;
	Mon,  9 Dec 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JrOxXf6k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sPCQ9X1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D75216E25;
	Mon,  9 Dec 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740570; cv=fail; b=BhbFEPCthuwH0+nHfC1h7rQuI1RiFxF6WfeLI+l84FD+rPxHkmtxd4gcjyKin52PdOWNU4CCBraAszPALzDQylrKp8NMVVFDSOzm5xP/qcjnE+zqwW1wZifOp1O5+rOZXg5QvhNwdV+0gNkzRy9zNN98O8jp8C5Tl+ltrbdpNr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740570; c=relaxed/simple;
	bh=W61x53nv1cRkQFArcHdc4OB4qPpHqMU8+V2RBbvgTTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pp+yGumc8226TnjhytGf351mT8cnJKGuHNOy0u8egnWSvYeHELqVmtrKBJ9d1KWRzrOjFRReg9uvq2Ih5ytb3kppFhhm47yyPMwASkIUMHGUh5JJQVs/v3jS1GnqIsRwiaqDn7NbDp3bad9pF+mG6pWldliNqZezLVW91xdLkfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JrOxXf6k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sPCQ9X1B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98frT7014823;
	Mon, 9 Dec 2024 10:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6w7w4CWio4LQfM6qAj
	Bk2SAUMhq77eelS/Ji95HM3cc=; b=JrOxXf6kkymXYa082eAUnVu/qqLnqGWJlm
	3R7V7+9Fw0au+yqikjBTZKjqV1Vn287bJHQSK3bWYWP+sTyS1q12YGWJn/4FSP3d
	gwsWo4+nVIUJkIn7BygJlYLYBcBPWe1SHv53e8ZVw3eKF0ZfL0ej/ubxCqwut4Rd
	STUq10sBBUSc5AuMK2meUTLK+l2WIFFfU9eVYjXNx0qSeQFaVMfjTxTI/jsdnQjR
	xyP2OPjnf85LlTP0Hfxr0dixcwfXXG6Iznuz2aywraEY19d2z5kN3c0qHEYm6Ryj
	GpWNNju0ab5gGALGHIEuu6Bn6rRmzRj1zF5MA8elb7PkIdDj7RMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr611gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:35:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99j5ZB020563;
	Mon, 9 Dec 2024 10:35:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6pv90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N71QY9AJMSeC2EGsMf5qKMakoIOLYOiRpSsQrNqiw9yqAbo0u3ILdPnmmPnR2o45MYvoDaTLS7tJdhIWN2iI+osEc0gBuBqEkrm+JLEX7uLBWIXO+VqWlxSmpCiJUxykqiBfirlGffs/lJndyg53OGD+RcW1Xp/wPjsYnKgFcq17FTSGeUoNGkqOVAqq8ZNBInmul4DRgq+BDKp2LvBkdA2Vis/FsP7T45Lcfk7+gPktBW5OhPI/sHVqqcR3q+qwQtooGtIoBS+ghG1dkgNGv36xwxFt6xKK87fbOXCFef9fOoxYayiYZqQjCwdDXJkW5ZtDtSbUq17rNyOSGSwcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w7w4CWio4LQfM6qAjBk2SAUMhq77eelS/Ji95HM3cc=;
 b=EbXbo/Vx/i5SJIgkmrbl4+3jEngPecOfVDAQJvdCZ1gE2VdpfL6PgHOE1kdRoRhC0Jfv6uk8HL3zSvKSeBNGkZHGeqSQwFIO256ROhSQvvQg6CcKIfi6lCbQOt9LDJaFPJB+cNmTC/HlNl9VlDblVPxcavq85RULza5j3gTrvF+bwujfbv15/d56iNEplAZB7ttvvOGdMWgHfG0qxxn4hdBeNuZ7LWzjVHekmdLvhBYcMrJJ+6z/LqVdboQXapXFizTjlKcSzV68aPjXIAofrd16SYt/OXHCAL/YBV6+ZTl+nap2rCmOlisHch7mcQ0pRhO9Mtk+8F0LwMmRZFv6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w7w4CWio4LQfM6qAjBk2SAUMhq77eelS/Ji95HM3cc=;
 b=sPCQ9X1BakurlTLJDzvQxjJqZIG+rt1W1GUe+HpqLf9SJrOx2ZJl2MLAflO3gtN2tzfGSzPYevNF7HSnrrMkfa2WdHOzG2WKx1rLrhuB2lVkbulzIsOOU5Up3kAZjiDuMKywL9Scz5E9Vq9zgI75FGzoxj3n/vCuac29QqaODvg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BL3PR10MB6161.namprd10.prod.outlook.com (2603:10b6:208:3bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 10:35:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:35:51 +0000
Date: Mon, 9 Dec 2024 10:35:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vma: make more mmap logic userland testable
Message-ID: <e15d144b-e32f-4e2f-8157-9b1320876ea4@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241204235632.e44hokoy7izmrdtx@master>
 <68dd91e4-b9c3-413c-b284-f43636e7ffba@lucifer.local>
 <20241206003054.cj767w67kydv3rms@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206003054.cj767w67kydv3rms@master>
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BL3PR10MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 31303640-a752-4057-b568-08dd183d40ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mg/Dc2x9rpFFM8jHtyqciB1sSKTuYA0XFDoGpi46uDCG7FrLFWrSEPebNf4H?=
 =?us-ascii?Q?+WNm8e+jWB3XKYMkUYLBo4E9yPRb/JH10uFt1PTHWCE9dj0BCtXFKe/6o+2r?=
 =?us-ascii?Q?5BAtpyzqBCYd62ujZp83QhESI/6etEk48jc+DTRIFPqBNVA4Tuch+OYmNBJB?=
 =?us-ascii?Q?awvi+cfYs3ClIJYMQXK5otbqfqMyr3lrBQdMyOcvQeioCyXKuSLaUzFwNtdL?=
 =?us-ascii?Q?KNOr7m4xJuJJBt5ytpQRb7bWTt2gYiIf11hf5//yqEsCJQu0uSVA2yQ9Va5d?=
 =?us-ascii?Q?bE6oqm8xNEAZ5WM2e8ZVznSQTezNszwC8ZHocUjtR8dwTRSMi/FKdJ7YnvDp?=
 =?us-ascii?Q?zSZLmtNB7puXPX/paDqQ2eh6tjahXqsBq/P4w5Lkv6IwcpZgVBWkyKJU+zmA?=
 =?us-ascii?Q?3XT8927o77mvxI2Zq6hTuc53ZxhWN/VrSIahhrfrmlMTaCuCXv3iFyidLlRV?=
 =?us-ascii?Q?30gOxNUOsNvowb1+CVQaY0TSVWz4564JL9scdMSpFNSVbd2sqMnhaYgf0xIs?=
 =?us-ascii?Q?NS/wW9aBBZUADKHHqrEfrM5aZs9sFUXjclMMfOlBUD97d+leyb0LmRLcnjtd?=
 =?us-ascii?Q?WZ4zMBCzzWyclZdVuBDEbcm1dufhk6tyKa6NVl53vAyQ6QOujCi6o0LtzGNv?=
 =?us-ascii?Q?PeLvdEi8Yr121hDQrAwMkSFJjPdmxflPQMdWX9h61Cvsubz2UEknCBUTmhq5?=
 =?us-ascii?Q?q6dSWMU1XS44fvRkNL67dH6QcE2mRwwvmt2rffgdFVcd6V8f7H2Jq4tS49rD?=
 =?us-ascii?Q?6s+e3Ms9B+L7Og0Hga+ocUWr/2ewg2fToWeLNcdR57huWdDV3wxmNOOVcwT8?=
 =?us-ascii?Q?ZNWaj0IfKtHDwmXTMXZCo0uOEGIFvOrRilvflKA2k1jbmOMleL7Rdze2WhIs?=
 =?us-ascii?Q?sxaR2RRxY37zMQDOdRrxnHKJIJu5CkMBxAHV8N9Z5XTtyRFs5HKoXml/k5KO?=
 =?us-ascii?Q?o1fU3XkK6iLIl0Y9ZPzrlAiX5S4IbtP/fHrfG9CWN3wd2s/TeGpQw3v766Ce?=
 =?us-ascii?Q?BPM+IJVULWJZyFRJdsgCeWjN7P9EV9IbMoog8dDgIPw6V6vLdPXCFVdbUoAd?=
 =?us-ascii?Q?ZvACmfTFvjyY2szjkqF+KNPySUjjxtMoBhSuBvmCOZNfh8Fbl8wFe40mi72X?=
 =?us-ascii?Q?11Zz2zqv3rZy30/UXMN+EY6TycZc8U1fdN1vd9q8nD2DTfue/21237ku7Hud?=
 =?us-ascii?Q?6gMADHZHyWdF1MYhXdvA3MRDVrazy0m6qsrjzlMkCRtCBr5HGY48n8X+buDx?=
 =?us-ascii?Q?ppA+KBcUY+jnhG57yIPA8ZYDzQJBeZXY8hpuv5zuVAgt0oP7h0mKlCl76F5P?=
 =?us-ascii?Q?BuE4dClnYYSytTlzFGZO3Vm+eGAiZwCeGH8nQ+wO3uEbzeWNCJmBSUQPL+9z?=
 =?us-ascii?Q?eG8NjFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+I23QJR/58/wp8OQfmV3GEeoxZlA9J9lJQ/o9z1F9mHdv8Z9dxC3CMb0OCp?=
 =?us-ascii?Q?cAURLRFkzEpxC3WBcIWvHPKfIWgPKkXB2kqdj7zNpeWdulLgeu1TGw0hr866?=
 =?us-ascii?Q?EUwa2jyqZecow/x86nw+sZuCuwHE4ECXiKtsqUc1PIxqVY2OFLQZ3y0P8rZf?=
 =?us-ascii?Q?9Nm3zSt6FJcQcPHS66ljjsUglg/rV/9WeRYWiAOB6hKANP2iSLcOw34pAZhu?=
 =?us-ascii?Q?oAS13GBQh2wAdiJTrfJWvatY3sf9zLPuRxgodJExBhz518mJw09Nnxb7IKip?=
 =?us-ascii?Q?IL3N9682KSFkviZsqde0kUQqNjkb2T/LJS8zvKC3zB2LvLXdwZBA5chRiJyx?=
 =?us-ascii?Q?BL9fvk/RdIVEYN4Fyg/OlkycDvNV8gATFyNLEwv7R+XHPY79CzLvcycl6Ony?=
 =?us-ascii?Q?mL3Sg8LyC+BbOyAsXFE1vfkltoS25KVi9sTtooPY1ZCOgpFrm7HAyvvqnfr6?=
 =?us-ascii?Q?XbC7cI4xfDbzT1ylEgdczu7VFo4L363L61swVz/MRHqOn18/p0ojNmgo22zk?=
 =?us-ascii?Q?AmrvJfKfI4ohf0s3T5BIvNZ0IF4orXpSDIqPWlhTmNEwx86hoPiS7Iih8JPy?=
 =?us-ascii?Q?lWl3+SPyjknBm7Re3Bb363nJVq9ZiTn7rlkp7sbUMMGsEsr7eDSkLwWsy1el?=
 =?us-ascii?Q?OFrc+GlZA8PU4WKl87mv8hyafmmStDICyoGaiymf5w0fTP6JQrzlHHeIZzTy?=
 =?us-ascii?Q?vtQM4DFxtxJYt1ftxEhmBKzoviY8unhojbxh3a0BwOs4YH45X0BnNHiLEiiB?=
 =?us-ascii?Q?PBloolvMaAdUwyNljHPRW9CZekNx21IHxrnfx8Nbf/w5jliIcTOrBGGC4W9K?=
 =?us-ascii?Q?aIqhEci01Fn0si+Qh33t1f8VeT90ttZYZq1l8/KX1ZvJLc0b/4hgAvgk26u+?=
 =?us-ascii?Q?grJIf7d4yIFlzW4INhWDN0pMXK60AA90LzoG7E1t7rM4guI4Dk4AEyUlafYn?=
 =?us-ascii?Q?4icGGJpH+ESkAmJAXiSziawVs1boE/lunWxvTQs1JghSsD/9kwRVsl1m2QjG?=
 =?us-ascii?Q?NQG8ZgxMidXvGKyAeiVzc5xAn+OeaUfrN13SpvaAFzwlqjrjxdnXwOlIUeHR?=
 =?us-ascii?Q?swTDxvVzO+EIw9RIfsvLXoIsn7VR2uQ7RmVuvoVyv0yAw6queL9xliccVwOQ?=
 =?us-ascii?Q?6rOa3Pv3XtwPXF15MgnQzDRJjZhS9ZFe7lpq4jOiOw0MWgyFFTOIf5CHaKth?=
 =?us-ascii?Q?Y+DKpw56l1MFas4gYkJlMPnM+6KhpvftGd0ALnpZGFJVRBIBhSHJhyXmX6c9?=
 =?us-ascii?Q?Wopxfhno3tybqmSEoIwop6OutC+4fkFRtsFtyklcRpgb3iYUpHwHI1TiSNA4?=
 =?us-ascii?Q?f1WvHn0N8lhTfqCwXzyUvPSZNopFpufxiojEtr/b0ror+fbtWa5qYwFtSLU1?=
 =?us-ascii?Q?AMF1SJn/XIXqsHMh5AFHk0LjkVo1BD/eA1LfTqOorvV1L+AnZDFwKhwwNQbu?=
 =?us-ascii?Q?txd2oN9MFg5VkU7TFpkBfm8JF6BFEN7Mirv5Ni2XiXatI7X84P0Sl/OwEVjl?=
 =?us-ascii?Q?HxbuIDtZRoeOphGBYuWFcirWZCRP+eIfTm21aifmTNx9hWw7CclkgD+aOK+j?=
 =?us-ascii?Q?8fgW9W5ilKvbniHNz3SvRcMHajOSpXUaGo2utMoebTLMrVohNRQ2ojW2whsX?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M8ndznYnLsa8qitwPkNX6BokFTD15mglmM8IEFJnsFytSBj8a7ybklE7Lxydg4r7V7YzVh5+TOqttdaoViOrZ++9Kb2KQ9kCc3sKavRg47OXZ98lTFtSj+tCnQo9Ve6zboGFTVYJi+OtvNELa8UgszKv25KaPrBuJS+AcKYr89+jWG57aCbnEOUykyKk++cO5J69AgYiQ6KGBVDowpfXizcZixbJwiZBbOYO6kAO3stebZxDiaibRTXBx190LLNwBsXz+d8ocdD0dpfL4I91oWkCZs91qVy+WsFdMRi8bsPv1j918IeIOc+4dKAartEkVm777pRfsEwIMdCSQiqZAgXUuTbpc191Yoi3xfbEP8DI8QQDgYIg+sCUtHdAvtG+8/6A02GtCHG3Ekz2nolpwRn2aAjFgY8ijpuPQjhC23u+IL9NiOWLtmMv6buYwhHmZGd8Uf222OOOvQZ5LWMyIocX22tCGKQhO4NPmK3CnY5NpeT7absARqmeOcZqacvAOwPTTa6xh12A82NmAd8B+H1oM4xkcM2CHz0wWwMDl/24rV0o7mZPAh13DEv0Nt9dNdvWlOd1YAQl3f6F7OPF6ceXv6kaw3+Nnft+iynUgTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31303640-a752-4057-b568-08dd183d40ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:35:51.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH4+wIOHghiE0Wxa8RMWMr5dChajVpVGA6UocM/wTFKS5pNhVDtcYCFY+ARTwlgtG14IZc0gO3NcUEG1kr/QVJ6tUWaCu2JWO77zFtZKffg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_08,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090082
X-Proofpoint-GUID: yHNawYLIVYBEdHJSniYCsqJ6ipeKPiaU
X-Proofpoint-ORIG-GUID: yHNawYLIVYBEdHJSniYCsqJ6ipeKPiaU

On Fri, Dec 06, 2024 at 12:30:54AM +0000, Wei Yang wrote:
> On Thu, Dec 05, 2024 at 07:03:08AM +0000, Lorenzo Stoakes wrote:
> >On Wed, Dec 04, 2024 at 11:56:32PM +0000, Wei Yang wrote:
> >> On Tue, Dec 03, 2024 at 06:05:07PM +0000, Lorenzo Stoakes wrote:
> >> >This series carries on the work the work started in previous series and
> >>                         ^^^      ^^^
> >>
> >> Duplicated?
> >
> >Thanks yes, but trivial enough that I'm not sure it's worth a
> >correction. Will fix if need to respin.
> >
> >>
> >> >continued in commit 52956b0d7fb9 ("mm: isolate mmap internal logic to
> >> >mm/vma.c"), moving the remainder of memory mapping implementation details
> >> >logic into mm/vma.c allowing the bulk of the mapping logic to be unit
> >> >tested.
> >> >
> >> >It is highly useful to do so, as this means we can both fundamentally test
> >> >this core logic, and introduce regression tests to ensure any issues
> >> >previously resolved do not recur.
> >> >
> >> >Vitally, this includes the do_brk_flags() function, meaning we have both
> >> >core means of userland mapping memory now testable.
> >> >
> >> >Performance testing was performed after this change given the brk() system
> >> >call's sensitivity to change, and no performance regression was observed.
> >>
> >> May I ask what performance test is done?
> >
> >mmtests brk1, brk2 (will-it-scale)
>
> The one from here ?
>
> https://github.com/gormanm/mmtests

Yes

>
> >
> >You'd not really expect an impact based on relocation of this code, but
> >with brk it's always worth checking...
> >
>
> Yes, I am trying to know usually what perform test we would use.

Mel's tests also pull in from the will-it-scale project [0], which these brk
tests I'm referring to originate. The mmtest logic just performs some
statistical analysis and comparisons etc. across a number of different test
sources.

[0]:https://github.com/antonblanchard/will-it-scale

>
> >>
> >>
> >> --
> >> Wei Yang
> >> Help you, Help me
>
> --
> Wei Yang
> Help you, Help me

