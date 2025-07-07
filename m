Return-Path: <linux-fsdevel+bounces-54054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152BAAFAB00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BC3189BC10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C3275862;
	Mon,  7 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L3suyJPv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GdpgHyyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783682727EF;
	Mon,  7 Jul 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866215; cv=fail; b=DYIZNuT78mo+I63+f+jeFBMy9LTUY7t3nfe8VXZCHIw3ocXq5kLtFeLVjtCbXEE4Pj/ckEEdORr8FoObFyooNainfE+pifGjnctCcTKdsUqM/lNf6T4DAX/wlvz0PLP3nrYL8GcelFIv18WcHyomTGHf7SwxyxZVyuxnZ5KyQk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866215; c=relaxed/simple;
	bh=NoWBRrNpjpw6qO0rVl5rluz5jWUuzERY/iHUB9wiM7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WHLUzpTYLSDMdbO2DheaiLIMXHj4AMwLWBppX7W4eGx/1j2/7EkUXSWi+ar5lGgcP7KHP1tgTcfPZFAfSb6HgCww0gRwEH43AoJ1JEX/NQLtNvM7yctd5XH78vxGtDdgTJexvO7QzE1sKU1cynxeUc0R5BtQX4uOxfsj1+s2Q1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L3suyJPv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GdpgHyyD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ2jH024217;
	Mon, 7 Jul 2025 05:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=e59VfOKiaAszZPfi
	EOJJfua8qop/a2x1zl82NDgfCQI=; b=L3suyJPvCmzse1oJe3MNOu9di6AgF/gJ
	wyF2qN0SJ9vqi9YbhPzYf58sF93dOGmMlc8nrUHw3+eGDVwl7YGWBxh9CNzwgoCy
	fCvl3y/cTHGacMX4rQNFFEKGJMWtUTghZXZOtu3/84yz7wKmQzUaSmbP++xZroDv
	7fi66+0MvZT6+efVE8UNKpx+DowbxulTUeOlCpZSS3O72C5l4uhv572vphu5fHFA
	boS+RTFXbCPoLJwvYyG0ZrMx36IOmaTbp642Tsoeh+w5g6ZM1p9SAi/Tbhv1Rcd8
	X2uOKmWZankkzUDUO4D/igwX6ppRHCc0DoxP5vu1Wp2DrE8O3L9eMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47puxjhya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5673PA9V040504;
	Mon, 7 Jul 2025 05:29:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg820yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+lImvBcXi5t5jXwejZN/kiComZRPV6Cvpf88vcb/mDFsVopvPEIKAUJagZCe9mxuy9eM8ioVZ/RAMGE6jdegfDn54t7UET1mkjLPTN58yJVmlhcovzF7dLqv6gEx4t10JWI7dG31XCsqy51CLfVbyDu2bMkF99IKDNaYWpUyrJqMc7rp9Oz87/Sfh6oMvioarzIbKdDoc48mTzCWEY+v/AeKO7Eh9stZfZANTRvYamS1tepIBHPZYV/BuuEWYeii0ae4ZlvT9YQmfRcTqOYCMIyGPovtle329lsVArpDnRfQxQ2aNaFgULq3Wfry/TmYlU970vWKS7/H9Ae5MUl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e59VfOKiaAszZPfiEOJJfua8qop/a2x1zl82NDgfCQI=;
 b=PgnGjdOXznD+ddCgcm5mjnq1jKHCw9+8zNSjNqLasIUd3WXMCn9ZMw86Uxe9V9TkjS3AJw+lsXnBeOJroglPok6bxsx9euMXHbtNz05hwSJaLlIYw5A4CzDWUHMxjbHP3twBUU8ThbAZGwIVE3UQ9aeCD/iRheSVOjpaU6p0iYUFsZKnTO8oro0FABS9WTafuJtsivTEu+/li7GYOOcZ/LQeDyfszocNuid2iMUEJ9Wmc90zmNVIp3+kI5XvFKKLh01RXRv+aC8yYVKxMl79InKrp556pqmH92+rq+bOUSSmHW4zOwaSc2mm00w2/yBe8ghz4SoAU7RU3X3Sry8pMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e59VfOKiaAszZPfiEOJJfua8qop/a2x1zl82NDgfCQI=;
 b=GdpgHyyDTOZ41voarxlv1TatPkagUiXq7+KfLRcGW96jLIgDvZquHhswKAOYBtg0cWtN8XFztRqa6+5J13bQJdOyEBlJtb4JonBlcRgQIRTxawFuEO5RODhFEtHfJev1+EyVxj/BHQghkYoGeeXvvBGZJBIkW6k9Jos7zdG7Dzk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 00/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Mon,  7 Jul 2025 06:27:43 +0100
Message-ID: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c41eb9-07ad-46ae-bbb9-08ddbd171d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t74PK48yLLoAiRM2aqRWiCfJs6bj33V7HAREy3SRTcjcyza4yzLsKXKblE9C?=
 =?us-ascii?Q?SNwRS8CZ+q9POxXeAOGAEjAH8XuoAd32OLqusckhmJiEqfGYCuQTLUXDkqbR?=
 =?us-ascii?Q?m5yw74Pae0lahlUMFD0G9XbdwzlZMLkExRJyqq7+R/1ng4G3PJ6FRD05J19Z?=
 =?us-ascii?Q?ay+NPD1oRasoNpJ+AYNmq90d8/+lc4/TtL0f7w9VOPBwyvOZriVy5Aq1L2n/?=
 =?us-ascii?Q?Gs3GiOtviLS1IuRJWGEdmc/CRpP7qFA3TFLEBs4E7CYYjTQJfsuR/yCZXkJ9?=
 =?us-ascii?Q?QyiNwiknAg1ssRJiLSIU44sfbDC076z1dd4Lp8iCNiPwjK6Gw4Q73xgacHo1?=
 =?us-ascii?Q?OLELwY+3UsqoeZ6JRx3hy97d+3HETrndce6HQrkPqU1a31rUuEKuxDRdBQ8k?=
 =?us-ascii?Q?PEdyD5hhZDec0zPrsSihD9EWnrTv8WOxw2h/awIQWm7gB8s7p31WA4pYWUeA?=
 =?us-ascii?Q?ujaK5OmvbqLAvw5ld5D+LSWy1bqaM9piDsrGUlETRlqIhLLEfpkbhh1PEWM/?=
 =?us-ascii?Q?WQCttBXOsUI3hJaIZJzhj/3giJoHoELm5+Jq02gm6octC6PMgYqBkojZ1ae+?=
 =?us-ascii?Q?qNt1X6HreRAdamVpa6fgOtm8xG1ssoix+ogxY/P4mZqcxkgvJ/ZY+LMJkiRf?=
 =?us-ascii?Q?JcbPfTqx9Is8yfz5xU4vAtd6mtcc0RAcd+kIIKgcQvbLnZJoKVeKxgPJL9RS?=
 =?us-ascii?Q?Kz4v6cqiibpYtFmUfuEbppeJn0b57fxUTtPa9qo6PU5ZbC6iObCLxVcPaD+R?=
 =?us-ascii?Q?rLCqOGu/+ToMPxKipSKJTaoSd1cweOP9Mb3eT7PRuAPu2zH+vGsrAO7CVDoW?=
 =?us-ascii?Q?LISC9iMH9vV/KsvAPaqT/4TuGmPkvBANwxGwqojKxtUeaSS5p/AmCAFXT1XT?=
 =?us-ascii?Q?EtfetwTPHhK6Ok/nP/wrmgYZGVpTUFWlIUF8dLvDykcg8yH5KrnN2F5JdQ5M?=
 =?us-ascii?Q?W8lUfL0O9CocaKglrDaZODelHp5rSckTaGUifyft95dfnUNxDHx0I0Gn1q0j?=
 =?us-ascii?Q?gK3RF1Wj3wxwz7+iRGfLu8jBtG9dubdOYWcwe/sN7YRS33xDiVfZ5eesqJBx?=
 =?us-ascii?Q?pT7hUJnInwQlWZb8Cr89dleWxz8tEWVhsa9VzLjBELtj1jPGWn4kha7IUe0y?=
 =?us-ascii?Q?tXAj+bTzahS/Zi8xPcbZxvIxIQEbZx9/x5v8yzuqe7z/lw/rMZc5DGcU9Fa5?=
 =?us-ascii?Q?+kXJstkHEPAByRxNR5QOrsDjXCDldal70Z4STvFDCrtsx2LHezmHQZ76a7lX?=
 =?us-ascii?Q?hgcFrBlGzWM44+4nILzx3icaE8XNGUdmw3WQ5sFfVD2LvNVkgggbQgP55gCH?=
 =?us-ascii?Q?8cZxZKju8dBL6zQGMehGY0oafC5zEj69P6dn7cbS7nVeHUHktMGtChYwKFvL?=
 =?us-ascii?Q?dMhYR4LnauoQCzJu0n4+N14CkW5HOQQlMuuOmwNQAMavE3IqzpUFQtikddHS?=
 =?us-ascii?Q?+91tCiZK9+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8khFmvUthqziP/U7Qh5qxH18vKkRrV+7Ry70dU54xgou23anwDIiOmO/M9v7?=
 =?us-ascii?Q?GJckyrw2Hosr6yy+o5lVy4jZD7ePGHax8k3FXBxtB307rh+BAyx72EqZFMGA?=
 =?us-ascii?Q?5dPZ7u1Wj2k3tlv1StLNtJsZeut6S07ohzBsCiXaLENlnruTWgSK4O2J8tLF?=
 =?us-ascii?Q?oucqtjBmTyljSxXq1MUIwuy0mcF6dn253w3rkrmhOH+OoiMNwm9bHiwTUzWq?=
 =?us-ascii?Q?H12aX9wmRyHTfJnfG5JJQTysLHrAwEw94NuG7ELeRC8R2lMrS3EN/aXzQbJa?=
 =?us-ascii?Q?s4H7tm+OuJB4zfw+WxNom8gkNp50dQQsq3s3y4hp7lvZfdZd3Xejl+7xRVMW?=
 =?us-ascii?Q?yMYQQGhAcoZSoqHJ/t/D9z0IW/VNU3XRbx5r5j/HpIlmZL36LLSNOInprOBG?=
 =?us-ascii?Q?V87eyfXUb8OXsXua4u1AjxK1q8CL48Rnt5v+JHaVLZvaG4/Rq9Wngxtu275G?=
 =?us-ascii?Q?uNRr7Ice9rz6W5sdDyeZ6c2xHNK73FUryrr3+Qv2lC3UGlXzjw9xHXu8wpjR?=
 =?us-ascii?Q?Z+/zlUvBuVqyy9bHyvd391/3EkEE0eHKkeA7u6uxVOoy+QH+1hEHNRGZxvEE?=
 =?us-ascii?Q?Rg3qa3RoLSCTHLFA3pSMIba2Nf0/OduiVmlPltkKhEgLgiqlmC0Xhk4YwLHD?=
 =?us-ascii?Q?aeNJwlBtTxpdv0GsBsb877d+ad+s/2DGeip05wQ/5qH9Nc9lTlyYzXSBC3oE?=
 =?us-ascii?Q?UyfBuNd2wvM8A6j6JBXD++R+2QnGVo8BYndKK3d+z1MxtuUpMO3AoDDNHTEd?=
 =?us-ascii?Q?c/ZdX+1sgZSqiXWlV3/iDN+is9SNmhac0haFS9Mc/w0IRKKGjUGCtE3vEKjH?=
 =?us-ascii?Q?BfQqMwwwCQ2c9bg9OP0VI8lKJEStcUWR+rAIfJ3dvuLVyRbxw6sntoD/G7CO?=
 =?us-ascii?Q?EKYzbff119eCXi1TLNuFbgQWLMpIa7EzgsZhwcVqyp7EUJEewzOkmzfOhLg1?=
 =?us-ascii?Q?WEyBaBTBcLxZ0QuJSigJ6R2r1cl+q2DXJVpPuh5FQqfJwsJxFDIeIhazfvtT?=
 =?us-ascii?Q?qiNJm6tPxOX3sUkdXHtYBJZzS/e0FqQKn8suQFVrvhWFOLLWgVMPBox0qCZG?=
 =?us-ascii?Q?ONtnWMFZq3Pln3xrmUsQvX4hoGGbUy0ulDLUFdrIkGvTWkKhhDMGfUcmOHVU?=
 =?us-ascii?Q?yeeDRw7ewecAU0Zx8GpmJk7qfglgxW1leR3AIRAqnROD1iSyPKCXd58iOMq7?=
 =?us-ascii?Q?v0btMUjfI9uKmrqI0YP9lL0jLErhILqoOpABZGEvhF4bikThEoWsC2HGubxF?=
 =?us-ascii?Q?n+s4XcNEgxU4z2hrR1k5pXHWeVXZOLFjFZxmLf252li3jZMbiu0EXk932mTo?=
 =?us-ascii?Q?6I5Td+jbq8Zb5UVm1sxlZ1NHhkA0Xz2CsiIVbh8PP2LmR4xe/exP4wi31XOA?=
 =?us-ascii?Q?wq1e3he4makBFnjUDJky5YWhTxRr7aY4cu9wmoQce1JHnlhc62/caaCadlnn?=
 =?us-ascii?Q?ixBro+D0jyqFNneZDK9j+/M5CxokeW+TIvCslSqj5cLY6tLlWC9w7D6wT8/+?=
 =?us-ascii?Q?s5te23sPK6hSGgH7e9QoFx4IcqeI2Sb8iswBlltruIAHu1Cp/LclI7fJ45Eg?=
 =?us-ascii?Q?iR+HW+HQNUHQMq6EFJWwYnUfC955c84sPw2xJ7p1g8V865UdB+e4DJtxTscn?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QhWDTsDwSIDuc2xBVyX1Z/mk/gO6gCkxk9eI38QEYNT9ZEzAAnV9LER1FP8yfXEFFyNHh78VgSnxY1m3xtbmTbi8XaoIwFZYj+ciSUocA4KSsgjL+Ocug+rpSsGqgrCcXdY/cVVgsVVVeQ6S2L06jkF8atjGuiwmyDFLWX3Fjd+efcGWtFm0i+yz0kF/N8qQt+NMfzKcFBkiwFFHhRoOzPRIru+w3EBicbrzE9nF/k7SpCxmUZDqbOs8Y5vU1kQhAl6WLleKTie7iZecrWbNt4Svf24yfxAYk2nQXDzryJRx8ahTRK+g+5RaHeu5L7j7/9c7/1g9KOiDhLF57W6izUHXoYoAkQjFVnGmr5W237EvJzb0WKMr2JXWOkTKlasP4e4Mtnre4rU2vINyxVob18y8wBQTqp9S5JFtEVE1Fxvy3Jur+un4vbJ7QlY6du7v4+DdrQ0r+nDY4MTYxWGV4PIUMcENMXvl8RE0Rjc5sQjsx6Q72VNIS9dVxAWqHS0MZ+EDL7UQaJntcicJJh06AWg1iMCJwWx+3hZ6PN2S/XlYCfD4wNRlJeMpjUPgbIsSCysEdmC6OI3akmYgYR/0QDOGdtkDOphoqDNtCHP59GQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c41eb9-07ad-46ae-bbb9-08ddbd171d25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:32.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W0OLNjwLGMK3WRR4G8GAQzhcFe+1R6wInlIGaXn41H4NpNX7ftGP1loUcyetfL/ffB/q5NiyOrXVzBErDC5EeOL63ZUj6JGK3Jh4ix+3X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=Y7r4sgeN c=1 sm=1 tr=0 ts=686b5b1f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=HQSO5TfIMKuNO2st8UIA:9
X-Proofpoint-ORIG-GUID: gAUsx7d1WCZBKqJmauBdeLcd3oXC8Umc
X-Proofpoint-GUID: gAUsx7d1WCZBKqJmauBdeLcd3oXC8Umc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX32QGZcJRO8gp BR/83CyCprQbPGIKfNkZA2Qk5vyTwqLWm1a9yakmcqlTzWcHU3n816bZOyQZNztLXSfBmNK/dFx AIKT9hvidYc+fgmJCFq4Zxxqm610PgSxKR66zsJNd16jyI/zFkaM/Uft2JFokTBO+hA4oGyK2MY
 E97wdBDzmIERlC+v7JjTh7H4h2JVImqoUAc/4VmtnYsbPIxOWq52wT8sn2TFA4ZkNdq5HVn1DIv C7yrWbY/YhK4dwW9v48pe2rTNyPeMKh/q8AcmEkMZ3dQ3h7mEJeMGvIfouFuKRPxwGLQBrN8cCv byYwOSvi7G9ve+WUhOTNErp/Lbvt6a9Eyrd2sDh6qW65+kBGOxmFWD2gGF09JTsfwwG+wEApCp2
 pZkqsV67huwtD1Rs4xJXRWQkRZ4rIKN/W8+riKs0nrPRrpCcojQEwGLXXsvlXI2lP9o0x6PV

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

In order to do this, this series performs a large amount of refactoring,
most pertinently - grouping sanity checks together, separately those that
check input parameters and those relating to VMAs.

we also simplify the post-mmap lock drop processing for uffd and mlock()'d
VMAs.

With this done, we can then fairly straightforwardly implement this
functionality.

This works exclusively for mremap() invocations which specify
MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
notification of the userland fault handler would require us to drop the
mmap lock.

The input and output addresses ranges must not overlap. We carefully
account for moves which would result in VMA merges or would otherwise
result in VMA iterator invalidation.

Lorenzo Stoakes (10):
  mm/mremap: perform some simple cleanups
  mm/mremap: refactor initial parameter sanity checks
  mm/mremap: put VMA check and prep logic into helper function
  mm/mremap: cleanup post-processing stage of mremap
  mm/mremap: use an explicit uffd failure path for mremap
  mm/mremap: check remap conditions earlier
  mm/mremap: move remap_is_valid() into check_prep_vma()
  mm/mremap: clean up mlock populate behaviour
  mm/mremap: permit mremap() move of multiple VMAs
  tools/testing/selftests: extend mremap_test to test multi-VMA mremap

 fs/userfaultfd.c                         |  15 +-
 include/linux/userfaultfd_k.h            |   1 +
 mm/mremap.c                              | 502 ++++++++++++++---------
 tools/testing/selftests/mm/mremap_test.c | 145 ++++++-
 4 files changed, 462 insertions(+), 201 deletions(-)

--
2.50.0

