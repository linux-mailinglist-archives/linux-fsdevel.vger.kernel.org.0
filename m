Return-Path: <linux-fsdevel+bounces-51041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FEAD22D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805033A2A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AE21578D;
	Mon,  9 Jun 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MAWTZ8/q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XcT2aWPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86082116F4;
	Mon,  9 Jun 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483879; cv=fail; b=JIE4+tGG4BOM8xg3FLSX/16t1hRsw6ArhJFAWbfafYc5q71SUcmBPMQZi/YdgsXWOo98XizZZChML/nxNXNWKyWRRx5r33lL2p4E50fQoLqTJSHZRhJnt++NXrO0IaGucQQ3SMK7ZdABv2m3pmONnTjPxRPgre47tXB0/yRgN2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483879; c=relaxed/simple;
	bh=3/JBvWyId3Yvir6nQhc7Q/DbaaK5oixA6qk0sG1H3Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a6D+7Lw7H+CSwNzKuk5FkTIyhYPx5v5sAD8S1mnGQZ7d0R9GDmfP2CTaZTKrUE2DKkmQ3mjS+WwFwk5iTSwOvQpqXMpf+dOq/kut6y+aFmBhffAUChNXf0zW0WFwHhiM1/hBMIGQvC2LZEZnqSb11e9xKJrszLVvvk5fHuZguEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MAWTZ8/q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XcT2aWPZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FYbKw006885;
	Mon, 9 Jun 2025 15:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MkYMxIu/KPWapgg/3k
	L9bRR5uViaPCysA0RnOhGmIz8=; b=MAWTZ8/qDvsjlRnv9VqG6o3EHBqN2Jo0kT
	uYS/q1dFdCdYf9i5a/wKjASapbcFhxJR2YEq183lh0iJYgxzT6fZ4XyE7cj146p0
	i30HLJSeuEAdzfd1jXfsUt4kwHhlS1/Kb81OcRQs4xgd9L0CVbzsmLzJUUVJv68b
	amrGhz651ku5CSnj7qnxlmtwIuOuAfuWNrARERnZlYfvDe5Pw3I6x5H5Qs6E9STK
	ZVw7bRDgc7l8flEhtmkEC3bWz8iQCZAeYtHn1Tl8eafWBGXo95UUS1isFxx0x8cc
	NwEhwmRr2oMm31T9YyonXsJVVLZsiiHgkteGUXc9g4WgU0vBn+5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjsrpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 15:44:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559FXMdv007366;
	Mon, 9 Jun 2025 15:44:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7bp0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 15:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4KyKZ9/Rdum5BZqDDqV60QhcpMxxuYzOxsFgSCTPXUQUeyBg5UccQRiLjK+ej3ViJpSjwYhQTONYE/9e8Zf37+1ZMuw8kajHxk6RmF/JwAvr+KoELA8qm960863cfjiZUjEb53f26M+GtE/Hrs7N9KODgkfUNP55GGdOSKau4dp1OoHVQfNie0Q3aK/9WJQuleq0512sAj64xSbAzyzDt0hyjoB8usTV+JSW8gtKKRvQ7Uvi71I+F5cK2NksxcD9YpaYVPClCbgXaJiM4xtEsIKXcQUvw9uEwnPHevGf1Xwk3BajPjlF5ymp0wcY49wkHrHy7RwFMkWjPEjykN6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkYMxIu/KPWapgg/3kL9bRR5uViaPCysA0RnOhGmIz8=;
 b=RwYQZ+NXdQ5Ncwb+/fAnOXIjFq8/zj5k+WuUm0eW4TD6p9r6qPVbW2HsswIaOBdAsod8jsVYuhT6XzL5y/58J0bzHAav5PwWFv3Qb43QSXMg5OAr2QCi/TtEGWzMzyvFYGjCJSU9w4eau3FRW7uUxzeRffh/44L+RG1NvQyy1shBnR1ysKDBlg/hWvrOsjvSiq11CbE9ZN5Y4dbsZ16rpt7fpvQBBozzNf0VoUXGlFvNiWPHgOfhxP1fPVYxQhCYmoSA+eAAGx6evcLeFzZROVxFR8mht9QIAHsXPMfCP/nF7wVnvfpe0PN41TlPPGTz+tuTLA5oEUMFnCfLi2HFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkYMxIu/KPWapgg/3kL9bRR5uViaPCysA0RnOhGmIz8=;
 b=XcT2aWPZDfeJezyHzoVdmKnvfxoicCd9vv1lkmukzdaHUllKdMb+jFdFweogSEWQjy/u9TRCIpX1qgkCHhA6WDpc/rvTTBZ1AeHBVKWlqvD+n5HJOMBihz4sqbc962LLG5kvmg3rrnh4s0ZrN1CjeonpHHCAde8+4J7wTQfUV5s=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 15:44:18 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:44:18 +0000
Date: Mon, 9 Jun 2025 16:44:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <dddd402f-1705-41a2-8806-543d0bfff5bc@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::29) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e6babb-6195-438d-9b0e-08dda76c7e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPC5ODJgo8o2vQKuua69iNbqfY87Ys8usuTOEZMuw6hHAECAxtmJQrdnCcEZ?=
 =?us-ascii?Q?HqrvcvMoae4OzRTvkwtIJ0RpVAGamL8vWxiEgM5PvuIgDuZI21IIpnQrj5IY?=
 =?us-ascii?Q?DIeWfpg/ZZ7ThYdRXI8Sna3TuXo0V0ggmZgcOHa0bMB55WrKYr/a+CN8BBxs?=
 =?us-ascii?Q?9jufynYvUm9M/sIlgxvcDg9cIHkmp29PgTJtsw7dD07e5Q+28mp3zfH4WI/6?=
 =?us-ascii?Q?KqovYZFpUItf0eLZSEowuiPpdVI+dJmUQgsFsrvuSwd42IkBzRHo+0XvzejE?=
 =?us-ascii?Q?4JZlnJrHsTVCR5kXWfrBN6ntEuUrK9f0UiVasnQV67pANoYcY242rDKW4rwp?=
 =?us-ascii?Q?d3MbCtJEwi6h/jmgGadczqW+KMqcxlnUz6V7+dc2GXMUKLffqz/nvZLSwqZ0?=
 =?us-ascii?Q?YP/XJN5FV1uQ3eOoK+DbF1QYTs8SNzYHLjeO9ur91r2MCa7zlARP80iXlpvA?=
 =?us-ascii?Q?2eKxAUgQ0sRlr5o1+xsCgUx6k1D3ZuDEmszUiMEMLHpNOlg7U/lNdYn9P/Ys?=
 =?us-ascii?Q?EIoKvixpJn6FhsdbkF85yqBPNwOQpbAzaITjGJAluFm1DrpucSKC+U3o70Wy?=
 =?us-ascii?Q?GxLD4ich3GAklG5BJ96ukBIyFhlkjM3RoCpGjLHPrtW/r23I3Z2eNIaZKD2W?=
 =?us-ascii?Q?dQR1/WhM8T+JNhpAVsRx10UdIXcFqfr6xDGFRif39P2ehU/IsHVOkvRuvl/Y?=
 =?us-ascii?Q?+TWn49qoNGtXYn+jr+9n6JYPhvULJfDuq3ks+wVEQUGqJmcRf/hFs0Cq7Vj1?=
 =?us-ascii?Q?4/QNW7lQ86dRbwpHJDXRSeOl7kZFwpkIKBleck45yQSepGA21WzPx8GUpsHi?=
 =?us-ascii?Q?JFPWHHHklgpkdUghbl3K1T6W5oQaXUJ8ITYY2fcNS3Pv3jdIjA4lku3i+RzI?=
 =?us-ascii?Q?njO5urc4lmSGp6i5bTxGFnM3GeA07DJF7BdHNJisSjG1EmtqnPeg5i1KWIhF?=
 =?us-ascii?Q?0dyxHKRMSG51Xa4XibeapJETLz2aPIZOn+5sB2ad76j8H1GSf4VjgKG7WrBr?=
 =?us-ascii?Q?/JOWpk/JKfMcm3tRtCtspAkOi24vX/UJZc5afyEJ9R9lp4/4MiQJiqgxhD7x?=
 =?us-ascii?Q?Bf+n/IaYivyJHBN1kJu65iPVl5u3AlJlXbxACc+NjU5WG4hQvoP9OlBL3ceo?=
 =?us-ascii?Q?0Tshdz98/Ftdb+5olj6D1XqMq6E+/tlccTGGHMp5MRQO0ehokGLipsQn0/2G?=
 =?us-ascii?Q?yYFWqhPHpzW76qs66J4je1GrIgbQwxGVeDKfhhog0szUlX2QZye+K/y5swEL?=
 =?us-ascii?Q?ZpE828GvKRhCeSI+/aiJ8DewKHYePJleao9T/4SP+jpVBCPWn/1+aqsAgw9B?=
 =?us-ascii?Q?tceaRYn+wbtZEGVqI+vjpd8OwRkzB+pgk4c1GbdeR6a9z5X4UATquk/Mi/aq?=
 =?us-ascii?Q?6hP9tzVMiFwMMqUkFXHWB0j4kr8eW651rdsMDQKBTE1aVMHt1WsXJT1vq3SB?=
 =?us-ascii?Q?9yucRM8Pq4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XX/t/iHXvBU0DqYFgsSP+Rm5ejXrGL7tHoyqgozHAM1QpYT0VbNE6J4N0taN?=
 =?us-ascii?Q?jIf/a4Lk65OPQPOMhdT8EiSLUGOPrp5VZJu6HL23DJDeh0qwNpt2gJnRIpk5?=
 =?us-ascii?Q?5vkeKQ8F+UoL7rADrx4TtiRoR/iincknlcb8hWzHSfOJqPhTbExGjbycftC1?=
 =?us-ascii?Q?ACH9o++4dQDCRtpr7PO6KOiDRwA5LJPo+vx1MfpOUz/hk6kg7rsv/G2V+r/g?=
 =?us-ascii?Q?jEMnEmjXl75QKZdnKcKMPdCBYq4tHrCDSpoxwUMkK712YxQwF8cOma55f9Qc?=
 =?us-ascii?Q?O7d8ytsDx3SUdFx+JbRhqjL3UJu++MUMrFxQ8+hkI7ovSxp1HSYIB+JhzWJu?=
 =?us-ascii?Q?xSL5rFHF98jsKpUgfTJDRxzkJy4E6MXuvfILJeHzpHorRqz4i+uUlinSeGws?=
 =?us-ascii?Q?uBHOKGLUqDdv8OdjXk35z7wKDnPEQPgLcfCiKqFs0Wn5q8BcvD/zfMJuOd01?=
 =?us-ascii?Q?tcJw5hTvP82rh+kUb+Th9Rsx38/hrD2r19iisDUHt+1Bg9QvJgcpVOMf34d2?=
 =?us-ascii?Q?FSOLiui0Ucrhi0kGHk0NvdATaml/g4m5neWLNczNsW+Omiwl6bwjAm8U15yP?=
 =?us-ascii?Q?UrakIKo8J8fKrNj0BQP6kBdiyuvUMAjFZaVvBOoac3qm2FtoQqLiMyure0zH?=
 =?us-ascii?Q?nYYuLj3eztQAzVdcGG1JBjX0JFHbNo2eLqtrvIXf1Fg2FY7STx+wYWXaTIBF?=
 =?us-ascii?Q?3S4vDAlHCVS+udHQnJoipeuWEA18gm/IxyA9S5Bh/lOpbp+mFksQbbgJ+c9F?=
 =?us-ascii?Q?DLvJ6pPjcyky/VlW/LND3/7FjKlgB+W/sXvE2Gc1+C6p4LodJtiLZ/pG6y9q?=
 =?us-ascii?Q?es1gPaXpiyFXQtA4ObKBxrwUAvQqzeOgGvzzspjj1DI257NJ/uY9DaeIOKL+?=
 =?us-ascii?Q?lcCUkLNntDbkF46Lg1pOpGbedM+SpW+iMIQAAtHL6dHYlRJdxlpfvFyniHS7?=
 =?us-ascii?Q?/53eXyXL8/RE9CrWMXubiY3cpLN93fgt0opydWjnowZYcUHIECPa4suVhcuE?=
 =?us-ascii?Q?1DBKXRuPvNBhnHcQ/MjpMo8OGu6jevANgZTh+q7lJ6Ge7j0mByIHFOieRmKA?=
 =?us-ascii?Q?74bqL1A8XwTtGNV6j+PHP/yXCRA9MDFxlVPPtiUlIya0+h+4FqZz+mnSjIZo?=
 =?us-ascii?Q?nVZWs/4EA5/Euwel8S16zpaEga2XuUbjCEUAgVk/u2F4eBmqua4KGzhZKNiG?=
 =?us-ascii?Q?7TnrLRJQFvfEPXag3+K0m8+qprl+NisXoHZz8yDXdqt1j0wJs+nnQSMgF2jS?=
 =?us-ascii?Q?6kPo6vuSdSbKEDxFdnZCulNn9HSpKK4A7NW7ktMpmH476TvdScrN+YvZRvUd?=
 =?us-ascii?Q?Xb0gjyNKGgbi6wXyd7eyvfseQP1qExwvUdpC2GEaZGK8ReSxxL3NDEEdUcLt?=
 =?us-ascii?Q?xXeSp9K2pxyo/21JBQXuRZ0RawMSMTUzWbeuJFBixIkJbPWeX9P/07BnyCUS?=
 =?us-ascii?Q?YFpfBwoYLlcEPLc4kyC3I/pCwOy53Qrz+ZNl0sgqb7gaV1EBAdEgesyYfOvo?=
 =?us-ascii?Q?54ppHVk0VcOJNwjZXn4tyr/5ExRJb8lTve5wGou8mEz+QrlWw2E1+mEqH3xr?=
 =?us-ascii?Q?GNDnkMlkMOWL2svhdqT4TclLjDqWbkLe3yLPYdPB0woGfBkQvJqVVFFG4gZE?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ieWOOOs43JDFP2FKwoYp6/2JywkN60eMRlFUlsxjtyAMkruIOgpNM7mCKC6+o/Q07VKuxQSYtUSR5MoQk7yXEHJm7E/lyUMUBl3bt97R/PrPf97zBVkupUf7f76T31OE0rtkka8ZQSIbMKM2RBB1VrwNQ4P8mhHAeeHpa0Bl0tnMz9knB/8izGOyLDCvhI258+dj+bTNXbLEDh5zWkJVG6BrmTWVDe9j4D4n3SjLSSKPNcYeZOQ7pv7nNL8J5hRXMyAaNJm3NBe8T2+vIbwW862oC+J0i0Ysj3lrm424ZZSENWWKowSDJG9G3BIBlHb41tTitD+pKDrJH1l8vk6rYEtJ4KO3zWNnhS/XOCuWO5Lip+vO/gthXZF2bocoCteScoZkUx478GHiSP+NyKEdM9sf2V+zxje9Z5hM52Nlgl975EJ0HwbUQ6PhkXwzkmPabS5pJCV78G0vGNtAJwShmw1/l7b/wrXTS9QlsMaE2PGR9nWevwfm6suHM/Mn6XBLClv2R1BRVND+hkT3XC6DR3IoH8OsMbH6u++LQ3b/FUjea0e5109ufQ3xef72/eIeuMCCu9lTwYWxgHWB24wq6yDnk3TWI9sodz/BQ3PHc0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e6babb-6195-438d-9b0e-08dda76c7e87
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:44:17.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arySyHlFafXcPrtdOk4VwQGcbFmRZu1HtdcLusIn8EwMedP7Dd3JaL1SjoF1heDFAdrt1rDadZyycrZqnhinYys3cpHF/eEQ7Fl99fptdYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090116
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68470155 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=HNhzTM14WF-LhxQSznQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfX84L73bbLManv WLAXnHjqh2AbU3FPUQtF5h/Jv/33Reqzy6OWuw/UHANqOajOz/QelpDMerZE5lXhorcWWgUikek SLpK4UDosErtxXmCGpAgEPAXSD12I4lwDrmSK+n0MUhjSRPjz68FlYmCc2qgEs07h8rTKoRGDI/
 aB1e/9t9fA7fIzmmsLfUVT19uzkShXeIH/8UQ8zaxrH3dZLuQBCCmS3MIrF8hlW9zsxxBuUztBx q2+2FfiV4uTlKJAdnvNth8pzvNnnBe21Lhe95wW+rC2qyc7v0k8+ojTCHdgd/ZNC0LE1MOSHQ7W EOsW4qTU8TKaPG3feZBaORQ4Nqe1CKIui4TrVqk2N3ozrNnF8pF8fZndKwUo3/xK+64kzgoji7e
 7xnNHQGdlduKbK0pDgM56BJr4t3OYtsfTpLhs+bZ8XVUnMfiWoAT0Ttj1Yyn5xhvn0vVQKcb
X-Proofpoint-ORIG-GUID: 99jdfEHLIWNPX8OdfE-IcsuyQ7Ub6ybc
X-Proofpoint-GUID: 99jdfEHLIWNPX8OdfE-IcsuyQ7Ub6ybc

Andrew - I typo'd a ';' when there should be a ':' below, could you fix
that up or would you want a fix-patch for that?

I highlight where the issue is below.

Thanks!

On Mon, Jun 09, 2025 at 10:24:13AM +0100, Lorenzo Stoakes wrote:
> Nested file systems, that is those which invoke call_mmap() within their
> own f_op->mmap() handlers, may encounter underlying file systems which
> provide the f_op->mmap_prepare() hook introduced by commit
> c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
>
> We have a chicken-and-egg scenario here - until all file systems are
> converted to using .mmap_prepare(), we cannot convert these nested
> handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
>
> So we have to do it the other way round - invoke the .mmap_prepare() hook
> from an .mmap() one.
>
> in order to do so, we need to convert VMA state into a struct vm_area_desc
> descriptor, invoking the underlying file system's f_op->mmap_prepare()
> callback passing a pointer to this, and then setting VMA state accordingly
> and safely.
>
> This patch achieves this via the compat_vma_mmap_prepare() function, which
> we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> passed in file pointer.
>
> We place the fundamental logic into mm/vma.c where VMA manipulation
> belongs. We also update the VMA userland tests to accommodate the changes.
>
> The compat_vma_mmap_prepare() function and its associated machinery is
> temporary, and will be removed once the conversion of file systems is
> complete.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> ---
>  include/linux/fs.h               |  6 +++--
>  mm/mmap.c                        | 39 +++++++++++++++++++++++++++
>  mm/vma.c                         | 46 +++++++++++++++++++++++++++++++-
>  mm/vma.h                         |  4 +++
>  tools/testing/vma/vma_internal.h | 16 +++++++++++
>  5 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05abdabe9db7..8fe41a2b7527 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  	return true;
>  }
>
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> +
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> -		return -EINVAL;
> +	if (file->f_op->mmap_prepare)
> +		return compat_vma_mmap_prepare(file, vma);
>
>  	return file->f_op->mmap(file, vma);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 09c563c95112..0755cb5d89d1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1891,3 +1891,42 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	vm_unacct_memory(charge);
>  	goto loop_out;
>  }
> +
> +/**
> + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> + * existing VMA
> + * @file: The file which possesss an f_op->mmap_prepare() hook
> + * @vma; The VMA to apply the .mmap_prepare() hook to.
          ^
          |---- should be a :

:)

> + *
> + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> + *
> + * Until all filesystems are converted to use .mmap_prepare(), we must be
> + * conservative and continue to invoke these 'wrapper' filesystems using the
> + * deprecated .mmap() hook.
> + *
> + * However we have a problem if the underlying file system possesses an
> + * .mmap_prepare() hook, as we are in a different context when we invoke the
> + * .mmap() hook, already having a VMA to deal with.
> + *
> + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> + * establishes a struct vm_area_desc descriptor, passes to the underlying
> + * .mmap_prepare() hook and applies any changes performed by it.
> + *
> + * Once the conversion of filesystems is complete this function will no longer
> + * be required and will be removed.
> + *
> + * Returns: 0 on success or error.
> + */
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, &desc);
> +
> +	return 0;
> +}
> diff --git a/mm/vma.c b/mm/vma.c
> index 01b1d26d87b4..d771750f8f76 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  	return ret;
>  }
>
> -
>  /* Insert vm structure into process list sorted by address
>   * and into the inode's i_mmap tree.  If vm_file is non-NULL
>   * then i_mmap_rwsem is taken here.
> @@ -3195,3 +3194,48 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>
>  	return 0;
>  }
> +
> +/*
> + * Temporary helper functions for file systems which wrap an invocation of
> + * f_op->mmap() but which might have an underlying file system which implements
> + * f_op->mmap_prepare().
> + */
> +
> +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc)
> +{
> +	desc->mm = vma->vm_mm;
> +	desc->start = vma->vm_start;
> +	desc->end = vma->vm_end;
> +
> +	desc->pgoff = vma->vm_pgoff;
> +	desc->file = vma->vm_file;
> +	desc->vm_flags = vma->vm_flags;
> +	desc->page_prot = vma->vm_page_prot;
> +
> +	desc->vm_ops = NULL;
> +	desc->private_data = NULL;
> +
> +	return desc;
> +}
> +
> +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc)
> +{
> +	/*
> +	 * Since we're invoking .mmap_prepare() despite having a partially
> +	 * established VMA, we must take care to handle setting fields
> +	 * correctly.
> +	 */
> +
> +	/* Mutable fields. Populated with initial state. */
> +	vma->vm_pgoff = desc->pgoff;
> +	if (vma->vm_file != desc->file)
> +		vma_set_file(vma, desc->file);
> +	if (vma->vm_flags != desc->vm_flags)
> +		vm_flags_set(vma, desc->vm_flags);
> +	vma->vm_page_prot = desc->page_prot;
> +
> +	/* User-defined fields. */
> +	vma->vm_ops = desc->vm_ops;
> +	vma->vm_private_data = desc->private_data;
> +}
> diff --git a/mm/vma.h b/mm/vma.h
> index 0db066e7a45d..afd6cc026658 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -570,4 +570,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>  #endif
>
> +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc);
> +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
> +
>  #endif	/* __MM_VMA_H */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 77b2949d874a..675a55216607 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
>
>  #define ASSERT_EXCLUSIVE_WRITER(x)
>
> +/**
> + * swap - swap values of @a and @b
> + * @a: first value
> + * @b: second value
> + */
> +#define swap(a, b) \
> +	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> +
>  struct kref {
>  	refcount_t refcount;
>  };
> @@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
>  	return vm_flags;
>  }
>
> +static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +{
> +	/* Changing an anonymous vma with this is illegal */
> +	get_file(file);
> +	swap(vma->vm_file, file);
> +	fput(file);
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> --
> 2.49.0
>

