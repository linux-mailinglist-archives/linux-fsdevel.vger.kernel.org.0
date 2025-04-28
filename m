Return-Path: <linux-fsdevel+bounces-47541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46636A9FA93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BC7466993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E31DE2DC;
	Mon, 28 Apr 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPs1gLQ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MeJg7Wx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF61D8DE1;
	Mon, 28 Apr 2025 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872124; cv=fail; b=HikXKiASVknovYHGnmUVEhvOyho4zsjDSkQjJGeJ662RKgNU6JItUry/0ueH2LUjtobrBd+GnGqFEsZNAa/rpWkND4/0kwkia0J+10gYDAuLUa0qesrGRCOr+xKMl2hdAEhcRxqwLvrSxl9Yuum6h9w0xd6yjDKuzGWTZ+5/Da8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872124; c=relaxed/simple;
	bh=sqIClIfZGDnq9/BejRwAHRzkmNaRnxX1oCTmXLzU9UE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYJ/7cDU4KWS2zlMX0uP0b5XYjGX04zpJW6mRQh/RqYjK/22dE1hMGHYQhgDQHezE+xAlx2BHT91MDLnf5D7Cpob5HuUrHNFuroqMBs8M8iou3fX3EfVcwQd8mhun69cTsaC3BqVKzHlRGzi1++h88dN8jeUrzU8FhovmCBOsOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fPs1gLQ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MeJg7Wx0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SK7tJT018251;
	Mon, 28 Apr 2025 20:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=01dXgoxRe6Ubk0R7KZ
	HUBtgDEjxs6pfVXeDZhBe18Xk=; b=fPs1gLQ1cpDufLwsajKbomM36GnaCVzii8
	DaDI4f++6GdYL8nE1Sl2bynCq6WDMSYJkDwtFruRWJBiCZpDbiIIdrGqxmFbl6bU
	+7pEszr1QWF6v31420CxQJAsrTEOqf7EUis6oEu8x5jrJ/i9v7MwmWPMMq2SFFHP
	JZTVECfo38yHCKXH3NhzxAAILn1k2qyfwOaDzLYw3EW6ZXjf2d8PsNoH+4iJgbrO
	wpcJRgkc2edBQa7MaWrlyg5rvP8+4dNKVIsaZVZsIFrQTlawWBULc9saJ8GXOz1Q
	2h7hm577VauKIvTmVX46MLWIlHk1Zjyv66E9UP8Rnw6l+x7wUlGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46age481ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:28:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SK2gZ7023906;
	Mon, 28 Apr 2025 20:28:24 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012014.outbound.protection.outlook.com [40.93.14.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxf64wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCGpsnH9JkfgxQjOH1AfwOn1JVg1wbJPKNi8uxFumOxYXoILXEA2rEZGOROdZyE/Ei3DFt0mxy4bYKyflqejLgnE01mN/XzOdnUEfNhXlva9xBBp89WhehWKHFz20Gvyt7MaRTksDcOwSaEwYRdjOK8Gt9+vG05fwe9OHIZWUMfLgQoi8HVEKiY83ZA/vWOM57nFzabwPELVLJI88uSxjZ2r8MMomUFqN2++RSO+BnCMErNbpTc92N4IqsaqgLnfX3Ck4cTqoRjHjg1Eq19HEin2VBlyEjeK26CjQWQu3GhewM+/T1pUR1VJN4jqpWmzhFo73RJOx0G1LtyXdAWQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01dXgoxRe6Ubk0R7KZHUBtgDEjxs6pfVXeDZhBe18Xk=;
 b=mxqKfqDSbWB9vZWQ3GI9/L9h04Phfv7UQ1zSasQUL8X22gxdgczbXCa5dtIF3LSq5Q5ImkHO2UTvTe7oKIrQvKwPcHXh6/BY7zOnedZ2xwToKxVBu/2IafIGnrvGwTzlBkWPdB8ppVe3KSGrNOU8rWXBhSq7aDWZBN25uru6TJJZIM4xCToVKIlh1sJLnxKyeCmpksJ1f/tJ95PjZ9IB1KJnARuCaED1R/W8fK9p0XRt9+yUYjRKy1whdQBGGlPLkJr9SD2Ur/zJ90Qt6c4wDF+mt0i1glju6mRw3aZR3mjy3mXBYiPjXSnKOTVkC29uA1FmKLw7Hd7yB04QD2GJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01dXgoxRe6Ubk0R7KZHUBtgDEjxs6pfVXeDZhBe18Xk=;
 b=MeJg7Wx05kZGkzBxRpB0fLBrp6oZ7cF6iZr+r8k2CLmADPGz99YI+YBSsg60i/xg4ATvtcDWpcujaRX8XYkGQbL+zlOT5CUo+8ADhOcgbzPG6MUMpxBNXqT5e/E8wUxj+SxEB9X/vP7+TptlhX5VXAV3zxLOO2+OMvluBNOd8G4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 20:28:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 20:28:15 +0000
Date: Mon, 28 Apr 2025 21:28:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <c188d550-7d49-4df5-8908-4ebdc016db03@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
 <v4gd5swog7nbzy3atupcj6apbg5k4m25lanyfrvx324w5pbkzz@j2brxlfhvptn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v4gd5swog7nbzy3atupcj6apbg5k4m25lanyfrvx324w5pbkzz@j2brxlfhvptn>
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a0d53b-17cb-4767-2844-08dd86933459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V27E8xc/dJ9SOjUOwrxS63kEKdUc4bAOdNhDykyUdTT5SHCBrezMmd2rf1hx?=
 =?us-ascii?Q?JFpZeTSa4NswIn0fqMs5uo8A1v/iy1yX8CXRRS3zIa85jzZkfkKfCFP2eqLs?=
 =?us-ascii?Q?P9Jp4GZJyyD3OBJPQaqq5VH/KwP7X/ki0u6Bd/jmnQB4Be50A5flJYFfj9aJ?=
 =?us-ascii?Q?4db66/L0sWRG+/A1iHkSbiHh5A5GO4hQRW0RhNpdMFJ6v8WWo/AlMspL2Dbn?=
 =?us-ascii?Q?xJ8laj21eJ97rcnsJzRPq30rOPlDJTOLziDx2qrroqE62eSQpzEayvs/psHt?=
 =?us-ascii?Q?Qb3tjmHG+hN9j08lCQdrrQJZp55L0wB8s5tCPldOvsuJ/oyb2jXRdPSKEFAO?=
 =?us-ascii?Q?uEdKk3shuunOJqqOJs0GTrATt87uXUL1prcA0K8GdS4qLmYCx9sdNvfgpuf2?=
 =?us-ascii?Q?xmzUIZafgIKwl2E934DX96bRD6Cxj0xtPxbzgjNpOU2dg8i2FkbAHS+XWUco?=
 =?us-ascii?Q?fyXRD7PjzVemGPVjCoGCGRfyWR72hmtgMjRbhzkTU9Vla555aNviHmViWxMO?=
 =?us-ascii?Q?1UAocaAVJDcK+Z12At23soDRCMBo+JJKSOUUhRbRdQ342P3BXRLfjTli9X/H?=
 =?us-ascii?Q?mC4kp8sSuUBTJnPnGGTtFo7Rqi7EGzUbyWziHl5blcWKs/wbh88i0bDTEmWg?=
 =?us-ascii?Q?GaQEkAxXGZq+qPFKFvUW2csJh9V2Y8PLlCDP8awkLUUWZpesatHemsOTdAV1?=
 =?us-ascii?Q?yX/Epgezs7jKH2Z0riBoGNZYzulnyXZ94XFfUnbp/EvvjkjBq+xRAa+BiUFq?=
 =?us-ascii?Q?zsxgmCX5BSs8bhiZiwmjOoT6yR7pE+pNaSUnt2IENqceMSACCxwYGxOhFVLJ?=
 =?us-ascii?Q?WaP7VX0T8SkfjTAUWtyRCG1xv6ig3tp55ct6mYLnIi9540e89cTPwBFa9tvj?=
 =?us-ascii?Q?4hyhweqewx93Rratis8kd6CPUdO6b58mXozLoQzuManZg12KK38fyfisl5el?=
 =?us-ascii?Q?g56EGXY9S9NdowGyPuWgBCs5DiXn/J/G1qP/xwlD0tCB8lI+Zkv/I6KBr7Sk?=
 =?us-ascii?Q?q/QB7gz3IUNVPz8kSXq/DtQwcSmnJY3ZYQ8Wj2pkp8WIcnWfNG1NTfBa8HkC?=
 =?us-ascii?Q?TXkvRquYOiWTbTt2R+IZIWm+4Fp6ZnE79x7NKJVIRF1rcVoFCyb7W5URDurY?=
 =?us-ascii?Q?8+ZZq1MUHpxRNR/HJtPmJcv4BQMswccSdh+LY+/eVKY5/ijWmKsSQB7hVvPm?=
 =?us-ascii?Q?EayqRE9D1H83+160DXmRgegyd78KSWYFRzu+h/wI5reHTALkptqarW/diJ7p?=
 =?us-ascii?Q?KKI09xmU8cJubCmD73V7XdHvm3jrqbJ9frr7wIEn0QVoSKSwJYjsGFfoQnl8?=
 =?us-ascii?Q?F/+y8YeAy2N0rUe9WPvUxH24xe2O/i44Tw5IMxBwBH14DDDq/gGP87NfMOZs?=
 =?us-ascii?Q?A6k4xmqM3Dpy54Wp3a/uX+pj8Sd09L3564vpqwHvrNwNKuze5Eg5uwxaTfd7?=
 =?us-ascii?Q?DM9PXs8l1Skp5mD+XQGAiNv+2qYQ1IzyIwDucqrKCIJKaDOsYoDPfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLS9hRXkZ5epJpQZRYF/nkrwb70w4KVST/cxi7Z6JD9l6/O1wPCWQILq5mO3?=
 =?us-ascii?Q?ydZ0iM5A9EYvkzSvz4SRIIUUvuLXmRW9Ue7SZtR/iu0BzKpjaZBEdN56CK6a?=
 =?us-ascii?Q?BdJKMBs8eO1OOqWQvLh5KRsd0s5Oja78xH8fnG90cJ5XGyGXkMgVw6iLrsc9?=
 =?us-ascii?Q?s4bHErV49TjLVW/s/TPX33mh7c6O+/nOQZP1JenuQCD8g9+WHgNRKcM8PE16?=
 =?us-ascii?Q?kkEBaG/eYy0gsku54McosQOl1D5XJUTV/u2dhiN+MvNIw5uTuAaDpchhCNjs?=
 =?us-ascii?Q?J9v4iABtT5zEVV5ttI0xQ1PyXD4bwS6ib0D+nrkhoPSpv+RvS7+V3ZWE5xlg?=
 =?us-ascii?Q?uqwU2ujTLwvgo/sY/Ngi7Zw3RmJmw1oV//z4mEg2lUfHRgTGZ1ULivIm29s+?=
 =?us-ascii?Q?H2ayI7r3fH4UryMMUVKrL28W0DSLFUQBtYapfg1rS/lZX9KZajLeGUFRYMc2?=
 =?us-ascii?Q?TdpaVVOffwec+m/9W46q/AjJAYMgkk8NV1Y8Cef2bOBsVJSV2V2iqzahfJQ2?=
 =?us-ascii?Q?axlP8Sjdj5VfV26DHyKNNNmRxThm1dZdbnRz0Mj5U4Nmd0/Xjx0W6wTbdaTc?=
 =?us-ascii?Q?6V3+i4HVmFrKzMkCDuXuU29tw/kkawLO88Bt5TSabSzh2v7rzAmSl7H4EiYa?=
 =?us-ascii?Q?Uu/hgjUnXbb8wcqxOK0lZQpHMDNfnMf9TjFfjuplv+N6utmAKD5UMaryNnXg?=
 =?us-ascii?Q?wS7gcsO89IRRxdlctNisPMlAbQCElGWNXV6Bcxz4v8n468BEPAzt8ZUGTmaZ?=
 =?us-ascii?Q?ANshkO4+fq6EiiLwHJGGGUgejwgPbYQiYO7kTy25Wgi/+9f0fXsuyYgdA8tQ?=
 =?us-ascii?Q?C32xL6JQ9LtCphD262k5V7NM523ry5/svRG2II7SUoGnfG955OivJ0OefBmH?=
 =?us-ascii?Q?re1+WiepLs5kLjPfgYsIfmbTPS2OYQaci5niFJ87IHm/DDg3HKpO4507llI6?=
 =?us-ascii?Q?PKPVVG3RjwlKH6NXosJEUzvhg2Fk+FXPx0RFSZVMxpDKpVgvqxZeb4naHbfF?=
 =?us-ascii?Q?BSuO39d2DWYSnn116bnVlvvL8JOP+TS76EGJZP8JV3+hMmH1TookmlC9aHNm?=
 =?us-ascii?Q?GybXli/aPm8ZRJy2Az+PCiGVD61BCQpBL2Q7UzPC0xQQxWb75S2Cgy03cdiY?=
 =?us-ascii?Q?VOavuwBy9l34CZes30t5H/y5HW4U9uECahyyt40n5sw9w9y52cqvyoxSOJOs?=
 =?us-ascii?Q?anvFofEAham2dhJMBSlJGCLEn3Y9NklhMtMetl6N0O5qJWhHfRBA8X3LG90z?=
 =?us-ascii?Q?tlodkgrGR83tGv/5Q2OLIvhYQnjL3MnXSU+QIeX3jDtQdysPUdopEfOwUAUl?=
 =?us-ascii?Q?uxCnf0s+VyiPR5YMpJ74DitmXR23F58np9rQrHzYav9R0QvlfuK7gvKQLPiz?=
 =?us-ascii?Q?qvlc3v+HYCLXyzYe1Q3kGYyxKYMpl0hEyOYGJGOsHDcpN3CrS4TFDJDVEUcI?=
 =?us-ascii?Q?IYkE+Q6+J8H87fQamlKNQpMCQ8e9skgwc3548Tzj1Bw02lUUxejp/mSaVAol?=
 =?us-ascii?Q?vUZS+Je2RTFdTI6W1PfzgIOpI3fBRQ0wFpV09KOvqP4dWD2tNw6bPwzT5Eom?=
 =?us-ascii?Q?zE5lxFzkIuz289mi9GlzsNsE9qjAi66b0jhuBjURRzzzVUzeuzBiEwCmBmIc?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aOY+Xc+CKHu/926uOIrZ9j78yDmWR/dULTaeHo3jhRd9Pu+tXCH8eoTUuCsfbHtGhJon8VvrBd2rLWdLs1GkwdOjzBGZpM1IBNESpPj+e+l4oBtg+PbwT1y6u+Wuh0inPbIhxY/Z76uwJEIDg0Tj4/T7+Nx4z+sZPi4t38iHAWsIioG8L6vEQwznNHnPhSSGiktKnukYU2PTu0bcBB5lKd/F/XHTCCtKEoavvpQlGwjnMhvUwTNHeiXSkg1F04SmDcFPnoguVBL6wRhBwcFE6XExbf+PfR8jnm5bJ6BSrGQ5f5+R7v0gCmDJ5NsplwPz4Ns42KiZxpqI+pCFnIJHCCFFxWmo2y4JA7HEM3zo+PPmBedwtM1HeZAl4XJGRBskTuRU9GuHCYkPMCfUoXRN/HJp219Q7SUv8NW3copXUe+uCm1eh8giQ6ZmXnkuwALbrULkcw1T5FP9W73XG/kAoNZ43DOqJrhLTeXYSfnXG4NPgOLlIixLgkn13ctV4/DaYCt3s325rYqCGTm4PDaIiGVtoBP7vS6ERCCEgitTL8dBIl+3i5tKPtT80nNpuUUyXqnxEqFp+A9DL5Tj+BQLx1A1XI2d5AYXZSIMObClrh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a0d53b-17cb-4767-2844-08dd86933459
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 20:28:15.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9vdg2J06UksLYgBrgizFdWgTWPaDLUU2sy1hlHRdmj1JFCWnU8qusX9Bz0kcgAPPs9hX2fJmTYeHnN4Jg2spQemmsOl8EGaI5H24C+eufY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE2NCBTYWx0ZWRfXw8KW4Tw9Nw22 AlUo3xszF6Y5vr8DAz1g7177pBF9txfqijD+Gmnfdjiwb0jDFwX76GMBaMSx0gLlBst8u6M2qW5 Lnmnlf07NGK7ad/Ay1RfpGw9Cl1wqk4IwIItkixPKytURjFmhAU0xMNDJtPYbA8Ls/lFsat4S7E
 w7pvEhXJ1ZseM86tRf0dO8AAgPxCC29hQ0dlcHEkZElchXperrvx5NGXgfdtqsikIeKY9nLUOdI 0tiIWFfMY8+W0IVscjpY26SFM4a1EgUeq9KWDGYIBLxw+c+flna7E5taBycO4FiDz+pBI/tvftk OQujXxHdIfdjZcxM9R5M2inunWlm/adTpeCCP5brUdtRCuNyHTNiQUrHTKmdlrD0+emkTscr8HZ +H7EZAvq
X-Proofpoint-GUID: gbbjHc-kw9sjhleBDD6O-f8C5Lm9B6iN
X-Proofpoint-ORIG-GUID: gbbjHc-kw9sjhleBDD6O-f8C5Lm9B6iN

On Mon, Apr 28, 2025 at 03:14:46PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> > Right now these are performed in kernel/fork.c which is odd and a violation
> > of separation of concerns, as well as preventing us from integrating this
> > and related logic into userland VMA testing going forward, and perhaps more
> > importantly - enabling us to, in a subsequent commit, make VMA
> > allocation/freeing a purely internal mm operation.
> >
> > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > CONFIG_MMU not set, and neither is vma.c.
> >
> > To square the circle, let's add a new file - vma_init.c. This will be
> > compiled for both CONFIG_MMU and nommu builds, and will also form part of
> > the VMA userland testing.
> >
> > This allows us to de-duplicate code, while maintaining separation of
> > concerns and the ability for us to userland test this logic.
> >
> > Update the VMA userland tests accordingly, additionally adding a
> > detach_free_vma() helper function to correctly detach VMAs before freeing
> > them in test code, as this change was triggering the assert for this.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> One small nit below.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

I see Andrew already fixed up the nit :)

>
> > ---
> >  MAINTAINERS                      |   1 +
> >  kernel/fork.c                    |  88 -------------------
> >  mm/Makefile                      |   2 +-
> >  mm/mmap.c                        |   3 +-
> >  mm/nommu.c                       |   4 +-
> >  mm/vma.h                         |   7 ++
> >  mm/vma_init.c                    | 101 ++++++++++++++++++++++
> >  tools/testing/vma/Makefile       |   2 +-
> >  tools/testing/vma/vma.c          |  26 ++++--
> >  tools/testing/vma/vma_internal.h | 143 +++++++++++++++++++++++++------
> >  10 files changed, 251 insertions(+), 126 deletions(-)
> >  create mode 100644 mm/vma_init.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1ee1c22e6e36..d274e6802ba5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15656,6 +15656,7 @@ F:	mm/mseal.c
> >  F:	mm/vma.c
> >  F:	mm/vma.h
> >  F:	mm/vma_exec.c
> > +F:	mm/vma_init.c
> >  F:	mm/vma_internal.h
> >  F:	tools/testing/selftests/mm/merge.c
> >  F:	tools/testing/vma/
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ac9f9267a473..9e4616dacd82 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -431,88 +431,9 @@ struct kmem_cache *files_cachep;
> >  /* SLAB cache for fs_struct structures (tsk->fs) */
> >  struct kmem_cache *fs_cachep;
> >
> > -/* SLAB cache for vm_area_struct structures */
> > -static struct kmem_cache *vm_area_cachep;
> > -
> >  /* SLAB cache for mm_struct structures (tsk->mm) */
> >  static struct kmem_cache *mm_cachep;
> >
> > -struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > -{
> > -	struct vm_area_struct *vma;
> > -
> > -	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> > -	if (!vma)
> > -		return NULL;
> > -
> > -	vma_init(vma, mm);
> > -
> > -	return vma;
> > -}
> > -
> > -static void vm_area_init_from(const struct vm_area_struct *src,
> > -			      struct vm_area_struct *dest)
> > -{
> > -	dest->vm_mm = src->vm_mm;
> > -	dest->vm_ops = src->vm_ops;
> > -	dest->vm_start = src->vm_start;
> > -	dest->vm_end = src->vm_end;
> > -	dest->anon_vma = src->anon_vma;
> > -	dest->vm_pgoff = src->vm_pgoff;
> > -	dest->vm_file = src->vm_file;
> > -	dest->vm_private_data = src->vm_private_data;
> > -	vm_flags_init(dest, src->vm_flags);
> > -	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > -	       sizeof(dest->vm_page_prot));
> > -	/*
> > -	 * src->shared.rb may be modified concurrently when called from
> > -	 * dup_mmap(), but the clone will reinitialize it.
> > -	 */
> > -	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> > -	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > -	       sizeof(dest->vm_userfaultfd_ctx));
> > -#ifdef CONFIG_ANON_VMA_NAME
> > -	dest->anon_name = src->anon_name;
> > -#endif
> > -#ifdef CONFIG_SWAP
> > -	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > -	       sizeof(dest->swap_readahead_info));
> > -#endif
> > -#ifndef CONFIG_MMU
> > -	dest->vm_region = src->vm_region;
> > -#endif
> > -#ifdef CONFIG_NUMA
> > -	dest->vm_policy = src->vm_policy;
> > -#endif
> > -}
> > -
> > -struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > -{
> > -	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> > -
> > -	if (!new)
> > -		return NULL;
> > -
> > -	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> > -	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> > -	vm_area_init_from(orig, new);
> > -	vma_lock_init(new, true);
> > -	INIT_LIST_HEAD(&new->anon_vma_chain);
> > -	vma_numab_state_init(new);
> > -	dup_anon_vma_name(orig, new);
> > -
> > -	return new;
> > -}
> > -
> > -void vm_area_free(struct vm_area_struct *vma)
> > -{
> > -	/* The vma should be detached while being destroyed. */
> > -	vma_assert_detached(vma);
> > -	vma_numab_state_free(vma);
> > -	free_anon_vma_name(vma);
> > -	kmem_cache_free(vm_area_cachep, vma);
> > -}
> > -
> >  static void account_kernel_stack(struct task_struct *tsk, int account)
> >  {
> >  	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> > @@ -3033,11 +2954,6 @@ void __init mm_cache_init(void)
> >
> >  void __init proc_caches_init(void)
> >  {
> > -	struct kmem_cache_args args = {
> > -		.use_freeptr_offset = true,
> > -		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> > -	};
> > -
> >  	sighand_cachep = kmem_cache_create("sighand_cache",
> >  			sizeof(struct sighand_struct), 0,
> >  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> > @@ -3054,10 +2970,6 @@ void __init proc_caches_init(void)
> >  			sizeof(struct fs_struct), 0,
> >  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> >  			NULL);
> > -	vm_area_cachep = kmem_cache_create("vm_area_struct",
> > -			sizeof(struct vm_area_struct), &args,
> > -			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> > -			SLAB_ACCOUNT);
> >  	mmap_init();
> >  	nsproxy_cache_init();
> >  }
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 15a901bb431a..690ddcf7d9a1 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -55,7 +55,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
> >  			   mm_init.o percpu.o slab_common.o \
> >  			   compaction.o show_mem.o \
> >  			   interval_tree.o list_lru.o workingset.o \
> > -			   debug.o gup.o mmap_lock.o $(mmu-y)
> > +			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
> >
> >  # Give 'page_alloc' its own module-parameter namespace
> >  page-alloc-y := page_alloc.o
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 5259df031e15..81dd962a1cfc 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1554,7 +1554,7 @@ static const struct ctl_table mmap_table[] = {
> >  #endif /* CONFIG_SYSCTL */
> >
> >  /*
> > - * initialise the percpu counter for VM
> > + * initialise the percpu counter for VM, initialise VMA state.
> >   */
> >  void __init mmap_init(void)
> >  {
> > @@ -1565,6 +1565,7 @@ void __init mmap_init(void)
> >  #ifdef CONFIG_SYSCTL
> >  	register_sysctl_init("vm", mmap_table);
> >  #endif
> > +	vma_state_init();
> >  }
> >
> >  /*
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index a142fc258d39..0bf4849b8204 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -399,7 +399,8 @@ static const struct ctl_table nommu_table[] = {
> >  };
> >
> >  /*
> > - * initialise the percpu counter for VM and region record slabs
> > + * initialise the percpu counter for VM and region record slabs, initialise VMA
> > + * state.
> >   */
> >  void __init mmap_init(void)
> >  {
> > @@ -409,6 +410,7 @@ void __init mmap_init(void)
> >  	VM_BUG_ON(ret);
> >  	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
> >  	register_sysctl_init("vm", nommu_table);
> > +	vma_state_init();
> >  }
> >
> >  /*
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 94307a2e4ab6..4a1e1768ca46 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -548,8 +548,15 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
> >
> >  int __vm_munmap(unsigned long start, size_t len, bool unlock);
> >
> > +
>
> Accidental extra line here?
>
> >  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
> >
> > +/* vma_init.h, shared between CONFIG_MMU and nommu. */
> > +void __init vma_state_init(void);
> > +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm);
> > +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
> > +void vm_area_free(struct vm_area_struct *vma);
> > +
> >  /* vma_exec.h */
> >  #ifdef CONFIG_MMU
> >  int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> > diff --git a/mm/vma_init.c b/mm/vma_init.c
> > new file mode 100644
> > index 000000000000..967ca8517986
> > --- /dev/null
> > +++ b/mm/vma_init.c
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/*
> > + * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
> > + * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
> > + */
> > +
> > +#include "vma_internal.h"
> > +#include "vma.h"
> > +
> > +/* SLAB cache for vm_area_struct structures */
> > +static struct kmem_cache *vm_area_cachep;
> > +
> > +void __init vma_state_init(void)
> > +{
> > +	struct kmem_cache_args args = {
> > +		.use_freeptr_offset = true,
> > +		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> > +	};
> > +
> > +	vm_area_cachep = kmem_cache_create("vm_area_struct",
> > +			sizeof(struct vm_area_struct), &args,
> > +			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> > +			SLAB_ACCOUNT);
> > +}
> > +
> > +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > +{
> > +	struct vm_area_struct *vma;
> > +
> > +	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> > +	if (!vma)
> > +		return NULL;
> > +
> > +	vma_init(vma, mm);
> > +
> > +	return vma;
> > +}
> > +
> > +static void vm_area_init_from(const struct vm_area_struct *src,
> > +			      struct vm_area_struct *dest)
> > +{
> > +	dest->vm_mm = src->vm_mm;
> > +	dest->vm_ops = src->vm_ops;
> > +	dest->vm_start = src->vm_start;
> > +	dest->vm_end = src->vm_end;
> > +	dest->anon_vma = src->anon_vma;
> > +	dest->vm_pgoff = src->vm_pgoff;
> > +	dest->vm_file = src->vm_file;
> > +	dest->vm_private_data = src->vm_private_data;
> > +	vm_flags_init(dest, src->vm_flags);
> > +	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > +	       sizeof(dest->vm_page_prot));
> > +	/*
> > +	 * src->shared.rb may be modified concurrently when called from
> > +	 * dup_mmap(), but the clone will reinitialize it.
> > +	 */
> > +	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> > +	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > +	       sizeof(dest->vm_userfaultfd_ctx));
> > +#ifdef CONFIG_ANON_VMA_NAME
> > +	dest->anon_name = src->anon_name;
> > +#endif
> > +#ifdef CONFIG_SWAP
> > +	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > +	       sizeof(dest->swap_readahead_info));
> > +#endif
> > +#ifndef CONFIG_MMU
> > +	dest->vm_region = src->vm_region;
> > +#endif
> > +#ifdef CONFIG_NUMA
> > +	dest->vm_policy = src->vm_policy;
> > +#endif
> > +}
> > +
> > +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > +{
> > +	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> > +
> > +	if (!new)
> > +		return NULL;
> > +
> > +	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> > +	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> > +	vm_area_init_from(orig, new);
> > +	vma_lock_init(new, true);
> > +	INIT_LIST_HEAD(&new->anon_vma_chain);
> > +	vma_numab_state_init(new);
> > +	dup_anon_vma_name(orig, new);
> > +
> > +	return new;
> > +}
> > +
> > +void vm_area_free(struct vm_area_struct *vma)
> > +{
> > +	/* The vma should be detached while being destroyed. */
> > +	vma_assert_detached(vma);
> > +	vma_numab_state_free(vma);
> > +	free_anon_vma_name(vma);
> > +	kmem_cache_free(vm_area_cachep, vma);
> > +}
> > diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> > index 624040fcf193..66f3831a668f 100644
> > --- a/tools/testing/vma/Makefile
> > +++ b/tools/testing/vma/Makefile
> > @@ -9,7 +9,7 @@ include ../shared/shared.mk
> >  OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> >  TARGETS = vma
> >
> > -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
> > +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
> >
> >  vma:	$(OFILES)
> >  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 5832ae5d797d..2be7597a2ac2 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> >   * Directly import the VMA implementation here. Our vma_internal.h wrapper
> >   * provides userland-equivalent functionality for everything vma.c uses.
> >   */
> > +#include "../../../mm/vma_init.c"
> >  #include "../../../mm/vma_exec.c"
> >  #include "../../../mm/vma.c"
> >
> > @@ -91,6 +92,12 @@ static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> >  	return res;
> >  }
> >
> > +static void detach_free_vma(struct vm_area_struct *vma)
> > +{
> > +	vma_mark_detached(vma);
> > +	vm_area_free(vma);
> > +}
> > +
> >  /* Helper function to allocate a VMA and link it to the tree. */
> >  static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> >  						 unsigned long start,
> > @@ -104,7 +111,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> >  		return NULL;
> >
> >  	if (attach_vma(mm, vma)) {
> > -		vm_area_free(vma);
> > +		detach_free_vma(vma);
> >  		return NULL;
> >  	}
> >
> > @@ -249,7 +256,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> >
> >  	vma_iter_set(vmi, 0);
> >  	for_each_vma(*vmi, vma) {
> > -		vm_area_free(vma);
> > +		detach_free_vma(vma);
> >  		count++;
> >  	}
> >
> > @@ -319,7 +326,7 @@ static bool test_simple_merge(void)
> >  	ASSERT_EQ(vma->vm_pgoff, 0);
> >  	ASSERT_EQ(vma->vm_flags, flags);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	mtree_destroy(&mm.mm_mt);
> >
> >  	return true;
> > @@ -361,7 +368,7 @@ static bool test_simple_modify(void)
> >  	ASSERT_EQ(vma->vm_end, 0x1000);
> >  	ASSERT_EQ(vma->vm_pgoff, 0);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	vma_iter_clear(&vmi);
> >
> >  	vma = vma_next(&vmi);
> > @@ -370,7 +377,7 @@ static bool test_simple_modify(void)
> >  	ASSERT_EQ(vma->vm_end, 0x2000);
> >  	ASSERT_EQ(vma->vm_pgoff, 1);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	vma_iter_clear(&vmi);
> >
> >  	vma = vma_next(&vmi);
> > @@ -379,7 +386,7 @@ static bool test_simple_modify(void)
> >  	ASSERT_EQ(vma->vm_end, 0x3000);
> >  	ASSERT_EQ(vma->vm_pgoff, 2);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	mtree_destroy(&mm.mm_mt);
> >
> >  	return true;
> > @@ -407,7 +414,7 @@ static bool test_simple_expand(void)
> >  	ASSERT_EQ(vma->vm_end, 0x3000);
> >  	ASSERT_EQ(vma->vm_pgoff, 0);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	mtree_destroy(&mm.mm_mt);
> >
> >  	return true;
> > @@ -428,7 +435,7 @@ static bool test_simple_shrink(void)
> >  	ASSERT_EQ(vma->vm_end, 0x1000);
> >  	ASSERT_EQ(vma->vm_pgoff, 0);
> >
> > -	vm_area_free(vma);
> > +	detach_free_vma(vma);
> >  	mtree_destroy(&mm.mm_mt);
> >
> >  	return true;
> > @@ -619,7 +626,7 @@ static bool test_merge_new(void)
> >  		ASSERT_EQ(vma->vm_pgoff, 0);
> >  		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >
> > -		vm_area_free(vma);
> > +		detach_free_vma(vma);
> >  		count++;
> >  	}
> >
> > @@ -1668,6 +1675,7 @@ int main(void)
> >  	int num_tests = 0, num_fail = 0;
> >
> >  	maple_tree_init();
> > +	vma_state_init();
> >
> >  #define TEST(name)							\
> >  	do {								\
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 32e990313158..198abe66de5a 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -155,6 +155,10 @@ typedef __bitwise unsigned int vm_fault_t;
> >   */
> >  #define pr_warn_once pr_err
> >
> > +#define data_race(expr) expr
> > +
> > +#define ASSERT_EXCLUSIVE_WRITER(x)
> > +
> >  struct kref {
> >  	refcount_t refcount;
> >  };
> > @@ -255,6 +259,8 @@ struct file {
> >
> >  #define VMA_LOCK_OFFSET	0x40000000
> >
> > +typedef struct { unsigned long v; } freeptr_t;
> > +
> >  struct vm_area_struct {
> >  	/* The first cache line has the info for VMA tree walking. */
> >
> > @@ -264,9 +270,7 @@ struct vm_area_struct {
> >  			unsigned long vm_start;
> >  			unsigned long vm_end;
> >  		};
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
> > -#endif
> > +		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
> >  	};
> >
> >  	struct mm_struct *vm_mm;	/* The address space we belong to. */
> > @@ -463,6 +467,65 @@ struct pagetable_move_control {
> >  		.len_in = len_,						\
> >  	}
> >
> > +struct kmem_cache_args {
> > +	/**
> > +	 * @align: The required alignment for the objects.
> > +	 *
> > +	 * %0 means no specific alignment is requested.
> > +	 */
> > +	unsigned int align;
> > +	/**
> > +	 * @useroffset: Usercopy region offset.
> > +	 *
> > +	 * %0 is a valid offset, when @usersize is non-%0
> > +	 */
> > +	unsigned int useroffset;
> > +	/**
> > +	 * @usersize: Usercopy region size.
> > +	 *
> > +	 * %0 means no usercopy region is specified.
> > +	 */
> > +	unsigned int usersize;
> > +	/**
> > +	 * @freeptr_offset: Custom offset for the free pointer
> > +	 * in &SLAB_TYPESAFE_BY_RCU caches
> > +	 *
> > +	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
> > +	 * outside of the object. This might cause the object to grow in size.
> > +	 * Cache creators that have a reason to avoid this can specify a custom
> > +	 * free pointer offset in their struct where the free pointer will be
> > +	 * placed.
> > +	 *
> > +	 * Note that placing the free pointer inside the object requires the
> > +	 * caller to ensure that no fields are invalidated that are required to
> > +	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
> > +	 * details).
> > +	 *
> > +	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
> > +	 * is specified, %use_freeptr_offset must be set %true.
> > +	 *
> > +	 * Note that @ctor currently isn't supported with custom free pointers
> > +	 * as a @ctor requires an external free pointer.
> > +	 */
> > +	unsigned int freeptr_offset;
> > +	/**
> > +	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
> > +	 */
> > +	bool use_freeptr_offset;
> > +	/**
> > +	 * @ctor: A constructor for the objects.
> > +	 *
> > +	 * The constructor is invoked for each object in a newly allocated slab
> > +	 * page. It is the cache user's responsibility to free object in the
> > +	 * same state as after calling the constructor, or deal appropriately
> > +	 * with any differences between a freshly constructed and a reallocated
> > +	 * object.
> > +	 *
> > +	 * %NULL means no constructor.
> > +	 */
> > +	void (*ctor)(void *);
> > +};
> > +
> >  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
> >  {
> >  	mas_pause(&vmi->mas);
> > @@ -547,31 +610,38 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> >  	vma->vm_lock_seq = UINT_MAX;
> >  }
> >
> > -static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > -{
> > -	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
> > +struct kmem_cache {
> > +	const char *name;
> > +	size_t object_size;
> > +	struct kmem_cache_args *args;
> > +};
> >
> > -	if (!vma)
> > -		return NULL;
> > +static inline struct kmem_cache *__kmem_cache_create(const char *name,
> > +						     size_t object_size,
> > +						     struct kmem_cache_args *args)
> > +{
> > +	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
> >
> > -	vma_init(vma, mm);
> > +	ret->name = name;
> > +	ret->object_size = object_size;
> > +	ret->args = args;
> >
> > -	return vma;
> > +	return ret;
> >  }
> >
> > -static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > -{
> > -	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
> > +#define kmem_cache_create(__name, __object_size, __args, ...)           \
> > +	__kmem_cache_create((__name), (__object_size), (__args))
> >
> > -	if (!new)
> > -		return NULL;
> > +static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> > +{
> > +	(void)gfpflags;
> >
> > -	memcpy(new, orig, sizeof(*new));
> > -	refcount_set(&new->vm_refcnt, 0);
> > -	new->vm_lock_seq = UINT_MAX;
> > -	INIT_LIST_HEAD(&new->anon_vma_chain);
> > +	return calloc(s->object_size, 1);
> > +}
> >
> > -	return new;
> > +static inline void kmem_cache_free(struct kmem_cache *s, void *x)
> > +{
> > +	free(x);
> >  }
> >
> >  /*
> > @@ -738,11 +808,6 @@ static inline void mpol_put(struct mempolicy *)
> >  {
> >  }
> >
> > -static inline void vm_area_free(struct vm_area_struct *vma)
> > -{
> > -	free(vma);
> > -}
> > -
> >  static inline void lru_add_drain(void)
> >  {
> >  }
> > @@ -1312,4 +1377,32 @@ static inline void ksm_exit(struct mm_struct *mm)
> >  	(void)mm;
> >  }
> >
> > +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> > +{
> > +	(void)vma;
> > +	(void)reset_refcnt;
> > +}
> > +
> > +static inline void vma_numab_state_init(struct vm_area_struct *vma)
> > +{
> > +	(void)vma;
> > +}
> > +
> > +static inline void vma_numab_state_free(struct vm_area_struct *vma)
> > +{
> > +	(void)vma;
> > +}
> > +
> > +static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
> > +				     struct vm_area_struct *new_vma)
> > +{
> > +	(void)orig_vma;
> > +	(void)new_vma;
> > +}
> > +
> > +static inline void free_anon_vma_name(struct vm_area_struct *vma)
> > +{
> > +	(void)vma;
> > +}
> > +
> >  #endif	/* __MM_VMA_INTERNAL_H */
> > --
> > 2.49.0
> >

