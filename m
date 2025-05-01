Return-Path: <linux-fsdevel+bounces-47852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3765AA6248
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1442B9A84EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444221B8F6;
	Thu,  1 May 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSs0Vsmc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFOfAWYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82F2185BD;
	Thu,  1 May 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120449; cv=fail; b=o9TTn3NssyXzbPaBjte5pZc2RnaWUZPYJcptSCBv4OHCXORWDyr4PSZbABZpXg2IofbhYzly2SKFelaJkOuQT9JTwOmhSFenRtuMFTJTTeHdkvmPcLXMvM6nRiTcFCz8+C7LEz1DVGBLpF6OtRwHF3huhN3oflWjgWPHh+N/Rvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120449; c=relaxed/simple;
	bh=CVWT5f0azKXXBOn4WkXf/jjXfEHLltg4Y8gcmFOQ8io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Okf/2GEsIhRyAskNzUwKpNKnDbXYRQeuRHVFgOZZJ+aqLaJO2lBWRbKClKs8BGiLQMSW+6g64WInzlzUG3/ubjPZbNCTimzN5rITIKl4dixG9ehQG+A5hvhkuWnmf3wZXmL7VqulnpUNLgK1C+XL+e1hELYHHOeLzu4OT8n1xS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSs0Vsmc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFOfAWYm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541HN0mL029868;
	Thu, 1 May 2025 17:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=; b=
	eSs0Vsmc7aIuD1/Pabm81OcuDqDSkTsR6KW5jaWEAZXRp5VrtJZbhRiEsS75/I4B
	jKy68M4QF3a3afD0p3yN2gIQTktJopmu9Z76e2K8OnVkekbNL8BT3Ficw4NNtTVs
	MZMRWf21XSiIAxwPrHeJ03+oLdiCeWg3l1VbsoGz3QsUJlHGCYjS0G4Fgmy6LT7q
	BpVwtV9w3ZxOJ5A0nTl6mCzBlYz/y4ml2CC2iRHjGJSObs/DksqjY+/yOErPOGiG
	OqSxBm5zqvANE+JIHKyuPKhY0Db76xrs/Nugdum05A5LfXOj2wJYPRoGCoBDsm6I
	KKColGcO5TpU9d8wIPjjQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqkjem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541HLuHT011245;
	Thu, 1 May 2025 17:27:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxda84m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG2tj7lZZSX7gfGeA6T8yhtNutZ4o7GI22ZC3aNw2OCkHQWSATcShAqD2F5QwvCA0LZVY/Qv/OFgT5qCvvYA2K7LlFoJoJK9Ia7WsylMLd3YcBV7uQ40hFkWUS/X+xnuTIuDzsyAxIQKIQEUef23+auUN6wUprpsaWiP9NdSWXuE0BuDnDysKlEdp7txsbLkow/kaj8DyuyLhVgRrulHlEeIoiu8mocCPl4UiqPJP82gIjCzMiBCX7Yn6RzAIYOlnhm2k0ag+rUq8FydW4w0g0X5jFksFyoc2L1WpNJTYK6vtEzH9G9l5Ae4wQqk2bUge1nKI1Hhykmk5Z1qKpH4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=;
 b=wfEl9IKJLyu5QfTj7oMXR+bGTPcdOqF4+gxG6CQEcUPYuiUwkXSuZvDVpKpPZRgbZgu7uwQmCysPlfvSSQwm9qh4zuxbqPg4k748YwgUYczBI6umReRFI5xd2WDyKNW25nVZISL9l75yhY+A+WZV0HH+eAIVuo4T3qb2y8GDmZh7LbmNyDcJo1oLnDwVNhl9N0XYAC+zMtlz+ZrSuZUo/K+LFQ1i4URbd1OtcmrFAAxG8i3VC8XmI3VJkd9A2QdgDskB8MMY5rcYRfoQXTeFk22nIOufySJ2Hlpm+hPoesudb8LqKxZ9T4+I8q/HOg1MxRrGhA/R4vx/F7dbxaUHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=;
 b=xFOfAWYmvhcsQmSG3utJonaxWR3HqARC0U9Kvb3lMK0z8LvBo3TKV3UXn4OwuhA1xY+a2i9EhxZJmWy8vNNJN4MhC+GM65KeiyjaUTLRmNqWH/RybFHl3o6WVmlILGTbRaCM3n9l3aGPGZY3RjsXMLjb9T4FphgNj/ycNRS+83A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 17:27:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 17:27:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Date: Thu,  1 May 2025 18:25:27 +0100
Message-ID: <fee7559b1cb248a3be4ce0a90482b2caaa52b746.1746116777.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d85cfb-d3c4-4330-32ca-08dd88d56431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5H4FuDT0P9p6oqZn10GYAc57o2affZOOTXJ65u9kC3XGWKRw0bsfHzj7vF1c?=
 =?us-ascii?Q?FcDI88fgXymCRnHx/dJDIxR9Yh1mjZfu+CcVnin2/9dTOrZbJ/gzzpceaHM1?=
 =?us-ascii?Q?wVEpiSWvH4T9ViFK8UINm++TrGQhCKZmd6ITgxVbmKHS+Ikk94uB0kEaF3Xf?=
 =?us-ascii?Q?pI80rUa94hQlwrvfKmpNk3j+9XOtXnT60OM83G7MG3/QPdm/OnL0EY2hcEEF?=
 =?us-ascii?Q?YfyutANCC1hoFrUdKHq16Y6gyAszOutN7HX7pHzJ6OFWOaN+slFTKlSTMyZG?=
 =?us-ascii?Q?PaC4agoKWKv23sr96eCtQjdqZekz6NSRTYPfYh1IaOskJ/GasRqFvp+qqYLz?=
 =?us-ascii?Q?1UJ7ISefvJOQwIwxVvFJdFaRDuanTErqnysu+TbADENkno9f64676QLc+/zF?=
 =?us-ascii?Q?orpPiuqCeBkKsUseW6vmw6h63qRoFtpWvvk/JxwKlDJCazCwCaxSFj8Vwf9K?=
 =?us-ascii?Q?xb69xHfa0WkRX6hZimeYgDIKZJmQQIasMKmEsMzvGR0oyPrQWLhWqvyAbV+9?=
 =?us-ascii?Q?QSLoILXpby+H0PmQfFa6/cneln0Sa79k4gI5pLobQ6mNmaMTacMcVfnbm4EQ?=
 =?us-ascii?Q?QK03iEJk7m5/8yIGooJM6u2k1zffpV4Fup5dVT41c2I0NF4lVVtB6YydMzmJ?=
 =?us-ascii?Q?qRw6vJiLOoBsGa28gqtK+rqahHrbTdfRz8slunFNP9mAE1SeTXA5vQDsAu5r?=
 =?us-ascii?Q?wPxrw1BbQ7V8JFBS1cmboOUN+L8d8FsQI9MIq5I7WmV1iaOHoCHjNXfWotL1?=
 =?us-ascii?Q?PtL2CQngq2RtswUT7crrMo0HryvEqntedEwulG7n6/DipS9QGBHr/kDP9p0v?=
 =?us-ascii?Q?wMSMrFQjUZE5DioxwjuVF5h16/DVik/2naV4VwkF2whio9BugHCgcYbaX5+W?=
 =?us-ascii?Q?RDvYsHkkGTpAMqSpTQbCTCQGnPxN+4gZmMevRa3Gm/ykrTQhzR3JzCMwwjJs?=
 =?us-ascii?Q?7cdUYXAwfBwYb4mOC+sm1dsQn710VAZj8UdlZRuINPRAE875a/cdcnpT/6x2?=
 =?us-ascii?Q?Vn5MCBtNCk1BL0av7M+IyHk5tJeGI7+3nbLEgkj3UIsSXauxAgVMlt1rIbOy?=
 =?us-ascii?Q?wNATj7FFd9fazwEGC1gqk2yWEqvwNm3MDpA4UBE3SviMFgqNJpzkAie/OdPl?=
 =?us-ascii?Q?FACo0D7m4tOMKhjYAbOF36VsuKzkHp7MWr80pF75Lf0vwJj6bd8nYkBLWap4?=
 =?us-ascii?Q?i7lJUZZ7/r/gE0WGo7ZsabNCYdcFBDkX23QZev7HGN0+5ukyqmYHd4y6E5YQ?=
 =?us-ascii?Q?HZoSXfHKKTtTQdxON8X0CXzH3TjJzHtk2F3rA2C6T75ijhde6aZni+cCmP8q?=
 =?us-ascii?Q?zLz2Zzdi24jlvEAUzRsHFBOwfaT4OmjBFAoOsg/za2vA6rSVWCZwFRzgBJU0?=
 =?us-ascii?Q?3rbAZdBQnQo9IVP0fjpL9m9VGK7PdEC9X24Slg/Jaa83GjIUV3snCFLQBlrQ?=
 =?us-ascii?Q?fB7RX8QFq+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CoGY2R31Z1kjGRzIF3CqtOK74R7jffeVO6USWKOYZqL+O6BxjNl0godqVxV?=
 =?us-ascii?Q?JQmumAg4GVC8MCqN9g1cCvQVyjApAk1eCnRz2PpFIeazpmz2ncsWg5YGCGFR?=
 =?us-ascii?Q?JfB6zc8I/nvY/ONJnYEO/rOx2ovUa9Rcoje971oH8kx2IOOs9ymMAHp7d/FQ?=
 =?us-ascii?Q?Ki8X64EaID5BDttKUs2FmU4UHdW5tO3yXNqdAjqX5R1mNmddbCCRamADeWOe?=
 =?us-ascii?Q?KvpTACR9SKIHoZ4OioSUuwLjRpjvnqxbkDU0p6NWBh7cHKmPuxaiacpS9YSh?=
 =?us-ascii?Q?35x+VVsrPGXkgi5dqRKHa83Y67/4l375PoFaU5Jcz/4XUDhWrDKUH2cm/Usv?=
 =?us-ascii?Q?9RgSuu9P6ncXfqzs9MUiX2gyvOMDVLrBqCMoJr1WPJowJH1mahj8qEK+4jKu?=
 =?us-ascii?Q?kp5pyZ+mYSEvCayIq+a6IgVq5YKyvqx5Cryp1LZ9PvcIGML7q97Bch7R51aM?=
 =?us-ascii?Q?FOxCFJUqfAvTaTB0rnmru3yp8oVDmH/Fal7UX7wO0OdPziSwKe+oJhl3d9Bt?=
 =?us-ascii?Q?GFcunn6NpkmgtUFLADt/I+2rwq56I/8wflK7eNyiQ/vnKdKlK03K1yE9mGYR?=
 =?us-ascii?Q?p6odwxTiY8EHZW4uvSqQIHJ3z0BnVJjbnKA3f7JMwmEjwRKNHs9SMzOEaALI?=
 =?us-ascii?Q?NVB9v6KOfCR3G11d62LEiYms0yOpU2gNya5sTzlCinp5NInRm9cBrahixq6k?=
 =?us-ascii?Q?BoVyQD+on846D21kJeWW2XIRFHRVhhzSvcW5b0AWIdOMSjBVxkqHiLMUvZry?=
 =?us-ascii?Q?gYsp1l2prlM2SmnkdgLgPirUWLEzpaelEBhcnMJlGtlElc6dM9XVqaA9gwTC?=
 =?us-ascii?Q?j6ATh+M0OcwSCm9nxBPdIxmjT7OWCiFO5H+XXWdaoORX+GURMJkgpHvcTlx+?=
 =?us-ascii?Q?9QsVh6Miy9EawzRZpQFV1RO5mjGqyt8gytOYqXED/xNIBK74i1P5DSkAmhp7?=
 =?us-ascii?Q?cNTi87rP4E/PCLGT5fnJzkDHLdjdFIfrsksE7vMOT4wEDYSVu7AEtLJlqv4f?=
 =?us-ascii?Q?RDlhWZHLraU3bOiN7KV3z/7w5Gd88zWJdPqFJ7MgU+r3QtsgE22WYEtUN+VU?=
 =?us-ascii?Q?f1PCCBZHrLIdMX+M4ZreRwNQEQwIYm8rnaFoBGywTKIdRvyA22LUFFd2geiM?=
 =?us-ascii?Q?AZ0acbXo45/lRwrBmALxn2AcJp8E/ObiAHX6IFDaIeGboLdnywaI3EJBhgOB?=
 =?us-ascii?Q?BM0VzcKjOqmby4s+PFSKPJTsGH9sGoyPLEpr48+mZBcx2GDl83kf9kZh7cAA?=
 =?us-ascii?Q?bCGqJuvMqj31QhB8CO/etKOb1tt21M5nuM8Q/ax3pNC3ZJCqrPDH58+7ruID?=
 =?us-ascii?Q?7bUJxrmOY/BsM2QbKEnhxUN8OouUpTIFa5PMYbMX1eZUjBSxDHDk1kZERwe8?=
 =?us-ascii?Q?qn0w+CtRDs7bBvATFyJ3CQdwADKCq1DDoZkjGw3pqHVR7wla91N+sLKUk/91?=
 =?us-ascii?Q?PcEptRzECebTyIrb3c9UDMqK6eSa5FeR+g+esXmWxtrMmrXh4Y7me29kyjx3?=
 =?us-ascii?Q?KNV1wsClV2o/fGOyoUL3IWdPGwA9o6onsfmfptK4H151RAhWxBXaA0rxqKuC?=
 =?us-ascii?Q?cP9e9NPzulgGf/Ec/xjghkbUSMHgEk0E/SxoSYiNiJwyZ1bUPpaDa/zkISFj?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pzz10Bdul3uVG2vrX7aPyvJkQSdlTjOoD4O+9Ph4Fu7kiViQJlRDZBt8ASK4HDchyftkrmT3UDBHwkazp4KjWAgnnkxsOxNqm4KN5K7+inXN7XguvVmcij/3yDBaA8HxHzfCwo0MoE7UAgGhz9LKSHVNDig8fUDV/mGDf+tUr8ywWN3UclXYGoFGh55F1We5AAuwe6cDAAfJEkCkO5PB+sO2+CrOoZKrpYzqaSyu4WtYRySUYIBxE/ytI6ZMIyPlPMUYnnAAZBxDQJmd0YwyKq/jVYOfAxW656T6ieg3u7G+dQdT8XtgwcbeW0/iR1s2HhoKh1x1ApDBioLeShy6v84LoJQZfairv1ZppRXi4gRVGXnvaPehBLaR+ossNDzWoi7h9zykrndohAA6/MpID9I6DNLXliCFqiAidS0px1dDcIYW0G2wKuJ2KFZLup7fTyoukp8CWudYee2ifwpLrvfe/fsornTKNfSErxL7yT1L8G+Oz8qo6EhNpIDaadBCpt/uHIPhmpqbVwfkUlGOSn2Z3Ydo6ttYopl+Cl9osHGTW6To3qvBogSNkPUvD2LZfWSHDH3GatY/WesPeqJKspwsKPNA6KadxLbFp4BRXno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d85cfb-d3c4-4330-32ca-08dd88d56431
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:27:04.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKvXgPpNyqVLJ4Q5owiTRsEmV3PmyAwF9zolmiElH+07izS+8ATd1QNdbHrW044TlNmPn3BgZiz+2OM4NHFP8RC9bKbL0sMyIyHruEYmaik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010132
X-Proofpoint-ORIG-GUID: AocXVUDG8EINd8-p8pFleM1lKxj3uuBJ
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=6813aeec cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_cC7IYOJfOS3saVh3_QA:9
X-Proofpoint-GUID: AocXVUDG8EINd8-p8pFleM1lKxj3uuBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEzMiBTYWx0ZWRfX9fQ2FYdTh2gi ofggn0dfTc4wfIMnlYcpY+8EPL+N0LbOk8mdabuLUTv5WelSbDxft1HoDa/PYrno0iDFRA6/fpA qGWsXXmsnhM0ZKr0FUKx9TbGh3MUhgOoHnUfgVUQ4BF6aL4Idy8HbNs7VbEUTt1VPHpDPZQ54yx
 1fyzC7RXwtPDRat+n3fxv4w3ODVbBCItQ/3XqWvnk+UgaY0T7bQxv5C2YCK708TFWHF9h7VPas9 NPrdO3niNSB+8SvQbaw59xLorxKEYqf++KPutuoULXJBmxxWToaKWYVmohoNaI03Yn5MolkxdO4 hfvGFebAFj+BlyQCyiYinZhKi2oF2mmxIp13sZvX9vpVQBFaFfeYBTuCyUYMds29p1czPHedEfT
 JR22yI2AEglMWm2gpf/4AcAhLuqDdUooNYLc5PNyolcwo6NlaHahs+gTvCwa3Ov6veYs7XMB

Provide a means by which drivers can specify which fields of those
permitted to be changed should be altered to prior to mmap()'ing a
range (which may either result from a merge or from mapping an entirely new
VMA).

Doing so is substantially safer than the existing .mmap() calback which
provides unrestricted access to the part-constructed VMA and permits
drivers and file systems to do 'creative' things which makes it hard to
reason about the state of the VMA after the function returns.

The existing .mmap() callback's freedom has caused a great deal of issues,
especially in error handling, as unwinding the mmap() state has proven to
be non-trivial and caused significant issues in the past, for instance
those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour").

It also necessitates a second attempt at merge once the .mmap() callback
has completed, which has caused issues in the past, is awkward, adds
overhead and is difficult to reason about.

The .mmap_prepare() callback eliminates this requirement, as we can update
fields prior to even attempting the first merge. It is safer, as we heavily
restrict what can actually be modified, and being invoked very early in the
mmap() process, error handling can be performed safely with very little
unwinding of state required.

The .mmap_prepare() and deprecated .mmap() callbacks are mutually
exclusive, so we permit only one to be invoked at a time.

Update vma userland test stubs to account for changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               | 38 +++++++++++++++
 include/linux/mm_types.h         | 24 ++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 70 +++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++++--
 6 files changed, 208 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..d6c5a703a215 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2169,6 +2169,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*mmap_prepare)(struct vm_area_desc *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
@@ -2238,11 +2239,48 @@ struct inode_operations {
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
+static inline bool file_has_deprecated_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap;
+}
+
+static inline bool file_has_mmap_prepare_hook(struct file *file)
+{
+	return file->f_op->mmap_prepare;
+}
+
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file_has_deprecated_mmap_hook(file);
+	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
+
+	/* Hooks are mutually exclusive. */
+	if (has_mmap && has_mmap_prepare)
+		return false;
+
+	/* But at least one must be specified. */
+	if (!has_mmap && !has_mmap_prepare)
+		return false;
+
+	return true;
+}
+
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	/* If the driver specifies .mmap_prepare() this call is invalid. */
+	if (file_has_mmap_prepare_hook(file))
+		return -EINVAL;
+
 	return file->f_op->mmap(file, vma);
 }
 
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb1..15808cad2bc1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -763,6 +763,30 @@ struct vma_numab_state {
 	int prev_scan_seq;
 };
 
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/memory.c b/mm/memory.c
index 68c1d962d0ad..99af83434e7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
+		 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
 		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81dd962a1cfc..50f902c08341 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 				vm_flags &= ~VM_MAYEXEC;
 			}
 
-			if (!file->f_op->mmap)
+			if (!file_has_valid_mmap_hooks(file))
 				return -ENODEV;
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 1f2634b29568..acd5b98fe087 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -17,6 +17,11 @@ struct mmap_state {
 	unsigned long pglen;
 	unsigned long flags;
 	struct file *file;
+	pgprot_t page_prot;
+
+	/* User-defined fields, perhaps updated by .mmap_prepare(). */
+	const struct vm_operations_struct *vm_ops;
+	void *vm_private_data;
 
 	unsigned long charged;
 	bool retry_merge;
@@ -40,6 +45,7 @@ struct mmap_state {
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
 		.file = file_,						\
+		.page_prot = vm_get_page_prot(flags_),			\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -2385,6 +2391,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	int error;
 
 	vma->vm_file = get_file(map->file);
+
+	if (!file_has_deprecated_mmap_hook(map->file))
+		return 0;
+
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		fput(vma->vm_file);
@@ -2441,7 +2451,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vm_flags_init(vma, map->flags);
-	vma->vm_page_prot = vm_get_page_prot(map->flags);
+	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
@@ -2528,6 +2538,58 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+/*
+ * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
+ * specifies it.
+ *
+ * This is called prior to any merge attempt, and updates whitelisted fields
+ * that are permitted to be updated by the caller.
+ *
+ * All but user-defined fields will be pre-populated with original values.
+ *
+ * Returns 0 on success, or an error code otherwise.
+ */
+static int call_mmap_prepare(struct mmap_state *map)
+{
+	int err;
+	struct vm_area_desc desc = {
+		.mm = map->mm,
+		.start = map->addr,
+		.end = map->end,
+
+		.pgoff = map->pgoff,
+		.file = map->file,
+		.vm_flags = map->flags,
+		.page_prot = map->page_prot,
+	};
+
+	VM_WARN_ON(!file_has_valid_mmap_hooks(map->file));
+
+	/* Invoke the hook. */
+	err = __call_mmap_prepare(map->file, &desc);
+	if (err)
+		return err;
+
+	/* Update fields permitted to be changed. */
+	map->pgoff = desc.pgoff;
+	map->file = desc.file;
+	map->flags = desc.vm_flags;
+	map->page_prot = desc.page_prot;
+	/* User-defined fields. */
+	map->vm_ops = desc.vm_ops;
+	map->vm_private_data = desc.private_data;
+
+	return 0;
+}
+
+static void set_vma_user_defined_fields(struct vm_area_struct *vma,
+		struct mmap_state *map)
+{
+	if (map->vm_ops)
+		vma->vm_ops = map->vm_ops;
+	vma->vm_private_data = map->vm_private_data;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2535,10 +2597,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int error;
+	bool have_mmap_prepare = file && file_has_mmap_prepare_hook(file);
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 
 	error = __mmap_prepare(&map, uf);
+	if (!error && have_mmap_prepare)
+		error = call_mmap_prepare(&map);
 	if (error)
 		goto abort_munmap;
 
@@ -2556,6 +2621,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
+	if (have_mmap_prepare)
+		set_vma_user_defined_fields(vma, &map);
+
 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
 		struct vm_area_struct *merged;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 198abe66de5a..a2cc54e9ed36 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -253,8 +253,40 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
+struct vm_area_struct;
+
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_prepare)(struct vm_area_desc *);
+};
+
 struct file {
 	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
 };
 
 #define VMA_LOCK_OFFSET	0x40000000
@@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int call_mmap(struct file *, struct vm_area_struct *)
-{
-	return 0;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *)
 {
 	return 0;
@@ -1405,4 +1432,46 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+static inline bool file_has_deprecated_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap;
+}
+
+static inline bool file_has_mmap_prepare_hook(struct file *file)
+{
+	return file->f_op->mmap_prepare;
+}
+
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file_has_deprecated_mmap_hook(file);
+	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
+
+	/* Hooks are mutually exclusive. */
+	if (has_mmap && has_mmap_prepare)
+		return false;
+
+	/* But at least one must be specified. */
+	if (!has_mmap && !has_mmap_prepare)
+		return false;
+
+	return true;
+}
+
+static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/* If the driver specifies .mmap_prepare() this call is invalid. */
+	if (file_has_mmap_prepare_hook(file))
+		return -EINVAL;
+
+	return file->f_op->mmap(file, vma);
+}
+
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


