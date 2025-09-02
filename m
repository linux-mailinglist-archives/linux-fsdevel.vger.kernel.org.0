Return-Path: <linux-fsdevel+bounces-59937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F463B3F522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F0C3A2E0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17002E11DC;
	Tue,  2 Sep 2025 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCphKlvJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCPRYMaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0D215767
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793737; cv=fail; b=oxAEc/lsxu0DPWZZtXSn/SnfeXXROurI4cGOhHeEXsJYq9L4HmCITciqwT9RZ8+nhTCiBSvCWMhMwaQxJhMTt/9YroK5JNeK8nfDsz3ob23qHa4ehLAibKEpMkC8Zxyz1y13nBQW4gcp3mMNtkU/etJUvavXgbVbXYtt0B+TXqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793737; c=relaxed/simple;
	bh=B1pg5TkzNxIZtde6fMkiz+6N5p5DPrrlUg/tubv0UhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUNly+e2OGaQUangK2rMEztSpShCUThCpMeKJ1diW5TvIXqtLAO+SZTxOqdHX35WS421UsAsTfwPiPcmX+L+uDCYF4bbLwbworh/kW9fYmjWAyErTk6DHQZmE5Evj69brB8XAK+J2Fh2QWJ0L5FF01pu1Smrm/Ay6RaqKZxm2sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nCphKlvJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCPRYMaC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824glij007980;
	Tue, 2 Sep 2025 06:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SqIGMyR7qfVS0vcPJD
	26NL/Z7gpCz8cz5QbiJ5+SPxQ=; b=nCphKlvJ7HtjwcnN56QDzY1uE1YCDi6rFE
	T8pSQ+vYDf/P86VF+9eBwjRCC5tmN7TCHgPH11dE8rSttjw8l8T4YhFpi723sEtu
	kkt0oK5Cgn7wthpsG3JAT/eyKtHomeMpWl2jteu/aAX80oKOiHQ00UTDLeloS8Ro
	ElFZc3GFWFvPcUH0ZTiadFi1TtlZ8sAMTOxGgBXxpXKILBT920RX1+38wHUFeKle
	hhsgU0m82BU9o+7vYrCFBeS7N1bDEgYFRfTY0N4A8XY9r301yNjyXcsP6ocIThZE
	4B+2MGCQSjC5Smq+YiYJ2JDVphkJJ+CmNPnPMjd30x2L9Zv7/rAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4js5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:15:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5825IjRq026894;
	Tue, 2 Sep 2025 06:15:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01mycwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjY9LtyjGdzm07lpCKOHgTbuaQODsDxiJoRYc9ltvm1hxChM9l9eLummUwe/tr7TLVKlDSYd3hTFnjsZs50fq2BkpqttCbesje9m+8PeIMNIBxEcQxibP1wdakUtOBg3q5JcBGyTE82b3TXjrc079gRddhWPxsX4tyOAsBe8HU6/qgWlEV/vk10Zc5GgESIysNCBxucQtevVk2MTAlj8pSIzJZ0nbCd92fw+70xjVKp5DcvbfB0iNkw/5HsvgFksXssg0ryGWJQRDnkUw6REK6HVNs61/bf4outZqoPDqIAYw/+kgv84dsDjaKbarmg1LfDw5fMOBvhs5GxciKEpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqIGMyR7qfVS0vcPJD26NL/Z7gpCz8cz5QbiJ5+SPxQ=;
 b=tD/RUo54n8lWRVhWT6NhS+Y6hRZ1JnHebJiXKd1HO0uaHdU1NFMgTfjtkiWbDqdKkeRa9DEnBYOuH5VabTTRd++f1s16gRIj3qaW4yiqH23BqbxckrTlKziBilNHupXT8fF7AiwTCJQpO1IwVDJqUkstMa9fr9f/TjV5YTF/QonFuOsA0GZ7GfF/OhvJOs+GhzMr6RyCNDAxnXSfp5yVVvmrtYzkh+by1ObiXckuHiy7NzOmW1Pi4vFGVyAFHihOGsvQQTLzlDaOWTlEDLR0PMGkLI4kKIypI2JkmOOW1wQJkPD45Xugv0gBQd2IkwGU77tgo3B6N22rTBF+jri3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqIGMyR7qfVS0vcPJD26NL/Z7gpCz8cz5QbiJ5+SPxQ=;
 b=HCPRYMaC3lHDOFgHxEai2irBFGLC74mqpZ1SgBkOaaj3EXOMpcpNXALc3Qlr9OQU9P9I679yRwB30yc8wU/x4738wMZbO15cFO6QAgnUfc6Jl009raa0y62LqzEtfbrfuTvkrYXFxuCISkT3kw4pNhVIGUV+JHUF3aSiY4SJxz0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 06:15:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:15:29 +0000
Date: Tue, 2 Sep 2025 07:15:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
Message-ID: <d0ed628f-709e-484d-bfda-3c4410a21e40@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-9-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-9-max.kellermann@ionos.com>
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a397223-db97-4c10-5b08-08dde9e81db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEQEhvDinV5cogvbqaYSFVB2HizXeD5KUUPyrMTBtx5/cTMq+WVDgj+LQFQM?=
 =?us-ascii?Q?2lHIYDqBo0/XqjQj+pJiD1GmoMhWXZAlqzT1dObPVQP0Av8B2ttkM54wKTuW?=
 =?us-ascii?Q?GrdG8pDK5Xsmp3rLtMGu+V6U/PD3u9s+xfGizORzLd9hqqskVQay48biWSr1?=
 =?us-ascii?Q?+0P64EMt5Dzvs+FcGdRDv3EKQ37kCmodSmqKlyC8JAmWRgtSzptKz//tLfYi?=
 =?us-ascii?Q?Krf4RQbRdK4HHY/W71zIyEWspl5yBnz9nOYSbxj6aZ8Mntejwgw2YSpKodWa?=
 =?us-ascii?Q?6ZNATchTFhahB72dcelV7EUlBbGbhBY483H1gZlVksd6YW+hiAmQCZpmzkub?=
 =?us-ascii?Q?IfEiXG1dremdeDLXai+cIva+QH3GQ86XQBLZkicbY/cXmB76P9/OwVf+YqsC?=
 =?us-ascii?Q?2eipiv/nojk4ftdwHzGkYtpt6fPBDIS6tC+PIzu5wctN3Tyt1Xvv6v/mXX2m?=
 =?us-ascii?Q?Ky3t1aORuX9B4ubT1e4UAwM9tJDTTry7kSHa2TD9hB2apUxTFlyUvWpVLVNO?=
 =?us-ascii?Q?eKQAiQa0GDUyll5LCP9+UhfzZkyu4YaV56qqo2Z0Dqh+B29G66pmH+CD5PW6?=
 =?us-ascii?Q?YOvMrnyIa+AwbUsAzCC0v3i76FeMnzCVX4VHG9eNG9XGWLP4BrprdE10o98K?=
 =?us-ascii?Q?0PcKxmCxUtL4njVKV2FrVelwycxQryDqsFbKylugJOGZ+tIMs5DvY0RDQJ5m?=
 =?us-ascii?Q?zVH9RsqyN9TKk8gvR4vkTpDFrecD/Xr0jaXcjnNApaVMB1ra0OqnNGhaxLD0?=
 =?us-ascii?Q?LE45rzTsthaUHEsv6IDwTYyWYlF+2aOSDj7BDbR6xHtfmZKzcGWLQpPk3ruV?=
 =?us-ascii?Q?g/MpWbPCQzLIv6jF3lWIZxqsVOxxNQENunw+7ZhE7EEOraHBeemQQfMKBiBX?=
 =?us-ascii?Q?9N/eczCzMDSaPG5jcUr8Cz7OUVz/QXL4Q/yhQRe+NA4yCc+GkEgRVGevx0eh?=
 =?us-ascii?Q?wJJDuoHAqh+V7bSGOXkLrtzP9Pa6b66qUaVYSuskNW6HQ8Y2ij/ZAUXErDw3?=
 =?us-ascii?Q?wu8xENNVuTORGRs04NO8pDQ0W0bTGbBSKK9J956x71fsRpLVwG+9IColObcP?=
 =?us-ascii?Q?3A+9aMF9gd0D90aXzmWhrDe9dGZ6MtUjhy+aK6OCHSkHsw9GLYYbiQcPM++p?=
 =?us-ascii?Q?k+homvAY0wiydcAwt3fG/99ZTYWSk95RwgJ5sc81ohmRWWRZA3z+thC+hqt7?=
 =?us-ascii?Q?fDzxTG7AXhqxe4KJYT/sOs9P/lNxGyNKP+k0+eUpR44E41WrmHgVkLvHPmcW?=
 =?us-ascii?Q?KpVnVe6uxFLoecjUgwjFbc8taENOQIG31yDBBcCX0lVXv+xzQGemfDekLslN?=
 =?us-ascii?Q?AT2kb82WVgGik9VVwzxr025LBLid1m9wu/kuXSxiOvFAHQxvm091qjPFznRz?=
 =?us-ascii?Q?Q7P5uCq+DU0swGtmavGW4pn+TulO5t1Np/i9EmrH3wwr5HbQTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?napLo8xrSD4dyVskjv2mqLwKWwGQ68EC5Sa0KyZwcVTY0fHdAbkTstIfA/Rd?=
 =?us-ascii?Q?GXWYgsXgGXrw2fZIfZQlErLjOfN0+ns4Fq5YpV+sR6d9S7wvpRM7jVJJvwQ+?=
 =?us-ascii?Q?boBD4+FIRIbBtzif0lNTujfh8UP62pKKdIk9t7LHyKAyOcA2cr42quuHpgxX?=
 =?us-ascii?Q?chrAMCidNulyO1q/IwyWTwXY/JcmH2iNvb1zbSCBAdfUsMBBYfutTxRAf86u?=
 =?us-ascii?Q?Q+yDt+fGuynFhmv/TTncsgFNo7IIW+yc1kQO0g12eGfmcCEa98Up7NvBizVE?=
 =?us-ascii?Q?ZUGUzNQNfRsDlUJgDLIGqlxvJh2DjyBOVKMKL3dKn8nf62L7FvKd4FHMGvaP?=
 =?us-ascii?Q?zw599bF/cIdbnL4emFzkO0wLXTRYtX/9iN+JoKMH1RmS08JaWSJ5UzeMifAX?=
 =?us-ascii?Q?TYLvKfrzorWEEvoYvckEMNOWcYMKbYsu0ixNDtk9nGhY9zPAdAkxu/UFVzmY?=
 =?us-ascii?Q?bmRE4zHm8u/sSV7+ueP8/UIDgUxVGTL5wjaB4ULsLrVJvq4s0LlAePOWRsad?=
 =?us-ascii?Q?izgERYDHexKCb/v/EuKWkmo45E/i/rYDMNSOfpengIFZBgsNrzn8fL238Abp?=
 =?us-ascii?Q?cPn7XPkNqn9JpVlYJwuYFPUtQi7bq2GRsKXZOhfrJbRvaRKtC2/T+EKvbLK5?=
 =?us-ascii?Q?0QEzq4yoZUS61Wc9PULdXqV/RjPPiPVShnfifXLkNkz1GTgA0XlCbk7o72dN?=
 =?us-ascii?Q?KmBoJhah0imgrG4MoRmqExnp4uX5BwVCKX0fLNOV9JAwEXFOzLH8b+5SCeZp?=
 =?us-ascii?Q?4R2XiqFvXp/BhvrLPpw6WyikwMhp0hAwu0GOfurNeh7675Zc1WYV78E8yg7K?=
 =?us-ascii?Q?0wOgq8GbE6VFc5AVbAIxYzY0Wh4/WK1ZWRPLqaYVHaIw/7ZqGVeoaZKhVXVR?=
 =?us-ascii?Q?7oEgnWpr+GZ8k29PqNiiTd/nHdqNeY9k1tlej2S3Mmd2owF42w1Lv5Gv7s0g?=
 =?us-ascii?Q?xfNqC1tiCkZMUUpPud3Ru51HO2XKFWYG+6rmX9U0cTyQJ2KERxg5RIecq3lo?=
 =?us-ascii?Q?hTY1Pjset3//hdkYVMTHdDjPwhWELMySVRDtoTJUhKiVZhRx5XTXNWP1FClG?=
 =?us-ascii?Q?vVPrKC6LyT35l6JsnhuBlH+ZYNru1G+e1nkxNWayN0WoZ5IolZilU8mLvI9N?=
 =?us-ascii?Q?3ggUGCnh/27y9G+Xdc1sB1ZxRTDbyB+vFIWC1gO3NhZl5Jy9eMIjo03cT7cp?=
 =?us-ascii?Q?dgU/I1cN6Plc77g0YH9kg3bwIjbuE9bQQfQfS6QKDLFHc0HUvQbdFRHqftuV?=
 =?us-ascii?Q?BNQ8e9taBUZx3oNS56spiFkdVd9R0lBkH2EoBT5M03R7394bRCQ0GjNYvt9T?=
 =?us-ascii?Q?oe9LJFq/oVEQVU2OD6Ib8r6wuyoAbQh8nt58wJndts64El2VUz3uwvexRsmr?=
 =?us-ascii?Q?Gs0G6YbUMu+sP9cUw5/UWT5UtjOAWaHbljc90p5kMYf/Quu8Brl3+vOtCZlu?=
 =?us-ascii?Q?ovYTysjqVpgvwAoj0PvIh3PeuqDh9ntaRBBYdq3oci5AkXDNJahCA3aOcY5I?=
 =?us-ascii?Q?DAOrBK9tlrP/EitzrZACXulmXm3IsdpY4Iy9oGwKQ3yYfJR1RWeCDD1vZvfR?=
 =?us-ascii?Q?Gj3uquPn09ykqaFWjgbw3s7SA9q8+34hnd4d4UAHb/2vurEzqQ3KyMGe596Q?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9unH2rsG1qbv+2682QWU3UkpISHoUQkWXbeBe4Ez9Gbd8t8dCv+7wI/pkv/8GGzbHeWKnJLRfuTvpSNkOq+dw7TWGvlxbmVbyKR1o5eFWYc7RJzI7Kt/PHsakDuaKkxjRKq27c5Oar9XNuM3XLykf0ItCfUaj8fsr+FO4x43yO2Q689wrJlxfLuITmokr00KiU5Vuiku/1uCZQ9n34WW1I6jrrU3GlS0+HPIVQJBs6eu64TC1pb2ig+D2iRn9bnui81yyas2fc+C7XmXJRl6k8q0W6c9c/fPbbVBAFm8jWXyrX6IIf5VU9KYIkafSSgAMUjjwHbsNWowjxLqpUYeQ8XA2icu1cm70HN9x6WBaAmZWj0i4ytCV64tIlVfhjpZaUhvGkwJARzBE9Lp3ubQReJhOd7glMZIZvHK7250Wzli1G3/+vNg1dy9fcZNtLQP2eIsvfjJxnU2VwtW0GCKar7NzKDzbTtnMJ1WyM/ywahgMQc5a9GlKXnyw1QY8Jz7VafA7Bn1isutzVbze/ORL0S9XGx0BC2ivMA8F0rQpijOsuTZw5NHA6Tzws1q8PvyBiSNZUjmPI5RlOqc0Kng4UAnfoeWJvMheZoNnJ3eS8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a397223-db97-4c10-5b08-08dde9e81db1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:15:29.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPmUVQDINDRv4jIgVssANO8/qFhwgKbkF4QD0rTp3id5LI8hb/wwHVvFjG8ZSbU4Xw2Wc3fSbB2cQ2hGB2FGei+4ODEwRslkl5jH+1wtl+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020060
X-Proofpoint-ORIG-GUID: lp5S0ij-5fs7sqTB9Lb8icdIWa_Wl5VW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX6jKsfQ3N85B9
 Fbc/69m5Om2NioF8ehc+YyT0XOzdbtIcylwdP9LgD8/T1P4BVOrMtt18DFZ6FHphRTo0JnFeWCR
 U6Mjp01xOzIGnKMKDqY0HPjrhmdOt/NPtlsnCzJuwwGbxoae5Npa+cHqv9uUG/CupLEcmmmbkLC
 uhIzpYD4cZeViZC5lkqwh9sfUf36+hbAklTfzZNTYPxRku6lE98ojTgACL1BbdTnmjnTNMEVBDs
 flC8NuWC4+5h/lDObdq5/M1qLXil3AHc4IcumntrSYrk6pokn0fJeHG2NFzorbdHehrRHvovj8/
 4Z8GpFUVhahP+7ajQ0CzfP9ERs23ent3UWoT5AJGa9KVbS7UYd5oiAi8nGqY0xSrxNSF3FPHcDe
 TzQ/KK9q
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b68b86 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=rvKY6sMXlUZX_cKRuZcA:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: lp5S0ij-5fs7sqTB9Lb8icdIWa_Wl5VW

On Mon, Sep 01, 2025 at 10:50:17PM +0200, Max Kellermann wrote:
> This function only reads from the rlimit pointer (but writes to the
> mm_struct pointer which is kept without `const`).
>
> All callees are already const-ified or (internal functions) are being
> constified by this patch.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/s390/mm/mmap.c              | 4 ++--
>  arch/sparc/kernel/sys_sparc_64.c | 2 +-
>  arch/x86/mm/mmap.c               | 6 +++---
>  include/linux/sched/mm.h         | 4 ++--
>  mm/util.c                        | 6 +++---
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index e188cb6d4946..197c1d9497a7 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -47,7 +47,7 @@ static unsigned long mmap_base_legacy(unsigned long rnd)
>  }
>
>  static inline unsigned long mmap_base(unsigned long rnd,
> -				      struct rlimit *rlim_stack)
> +				      const struct rlimit *rlim_stack)
>  {
>  	unsigned long gap = rlim_stack->rlim_cur;
>  	unsigned long pad = stack_maxrandom_size() + stack_guard_gap;
> @@ -169,7 +169,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
>   * This function, called very early during the creation of a new
>   * process VM image, sets up which VM layout function to use:
>   */
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
>  {
>  	unsigned long random_factor = 0UL;
>
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index 785e9909340f..55faf2effa46 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -294,7 +294,7 @@ static unsigned long mmap_rnd(void)
>  	return rnd << PAGE_SHIFT;
>  }
>
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
>  {
>  	unsigned long random_factor = mmap_rnd();
>  	unsigned long gap;
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index 708f85dc9380..82f3a987f7cf 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -80,7 +80,7 @@ unsigned long arch_mmap_rnd(void)
>  }
>
>  static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
> -			       struct rlimit *rlim_stack)
> +			       const struct rlimit *rlim_stack)
>  {
>  	unsigned long gap = rlim_stack->rlim_cur;
>  	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
> @@ -110,7 +110,7 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
>   */
>  static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
>  		unsigned long random_factor, unsigned long task_size,
> -		struct rlimit *rlim_stack)
> +		const struct rlimit *rlim_stack)
>  {
>  	*legacy_base = mmap_legacy_base(random_factor, task_size);
>  	if (mmap_is_legacy())
> @@ -119,7 +119,7 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
>  		*base = mmap_base(random_factor, task_size, rlim_stack);
>  }
>
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
>  {
>  	if (mmap_is_legacy())
>  		mm_flags_clear(MMF_TOPDOWN, mm);
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2201da0afecc..0232d983b715 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
>  #endif
>
>  extern void arch_pick_mmap_layout(struct mm_struct *mm,
> -				  struct rlimit *rlim_stack);
> +				  const struct rlimit *rlim_stack);
>
>  unsigned long
>  arch_get_unmapped_area(struct file *filp, unsigned long addr,
> @@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>  				  unsigned long flags, vm_flags_t vm_flags);
>  #else
>  static inline void arch_pick_mmap_layout(struct mm_struct *mm,
> -					 struct rlimit *rlim_stack) {}
> +					 const struct rlimit *rlim_stack) {}
>  #endif
>
>  static inline bool in_vfork(struct task_struct *tsk)
> diff --git a/mm/util.c b/mm/util.c
> index 241d2eaf26ca..77462027ad24 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -431,7 +431,7 @@ static int mmap_is_legacy(const struct rlimit *rlim_stack)
>  #define MIN_GAP		(SZ_128M)
>  #define MAX_GAP		(STACK_TOP / 6 * 5)
>
> -static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> +static unsigned long mmap_base(const unsigned long rnd, const struct rlimit *rlim_stack)
>  {
>  #ifdef CONFIG_STACK_GROWSUP
>  	/*
> @@ -462,7 +462,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  #endif
>  }
>
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
>  {
>  	unsigned long random_factor = 0UL;
>
> @@ -478,7 +478,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  	}
>  }
>  #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
>  {
>  	mm->mmap_base = TASK_UNMAPPED_BASE;
>  	mm_flags_clear(MMF_TOPDOWN, mm);
> --
> 2.47.2
>

