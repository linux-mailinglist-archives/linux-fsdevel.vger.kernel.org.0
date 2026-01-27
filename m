Return-Path: <linux-fsdevel+bounces-75626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGcfFwLpeGmHtwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:34:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D097CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E2D3015A68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E4350D6E;
	Tue, 27 Jan 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EcbjrO7s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZvmTYO/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C627A477;
	Tue, 27 Jan 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531644; cv=fail; b=CJtSrxGMB7PrxNjdOnJm8nszM6tNZEWPKkxUtZH5HarhCmvsRPFmKzdIomHnVFAPIaYFZaI7OgeF2aYpR4o/EL7QTpl+m6d8rkfw3hPtIp8XrMs+HbpTFsHiXCW0mV4VNt8QEiuHwf+qnWcZszdP01fu6C39lTJiVb1DV8aFYLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531644; c=relaxed/simple;
	bh=0DzI++x9i/ssPEy1ghnMFuSHNPu0KG3WlUofckYl+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azanXkEx1S+WdObR8JQV6MC+A2EPjDdYS2+8PVYiPD430LecrNZn/lcvE5dDIug5wSeTOoJIv+OSkcz0kfb4zmJzt+nouAF39gVpfMZA1ohNqaGIhbFymqsm/zLqNXH7hkW3iBBfxPKKSwHJ3GZvUQlgMn2haGymNLfMluw2uSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EcbjrO7s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZvmTYO/I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBESkV3328613;
	Tue, 27 Jan 2026 16:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DirloQme3ZfyXo1rbV
	I8WgLIfQvGEQ/2pShhKn3Jo10=; b=EcbjrO7sT/+rX3k9wnwUkO6wVUmP+HJB9l
	XuEQWrJZyUdVdRES2u2tmwToAZULGzJJfKcqoa27LPlNl/V03ABi9nDbnx1+N5hy
	9IIm8W4JoCPFCz9mV8voPKccVNyWBEp6Wn35khWyWW4Lz9muzy5l1SElHyGkwWFH
	EsFw+UObsEMMdBpqv+K3zm6uMblkMtPr38W6iUElaKIoT5YNIxGjWObeFec6RrGZ
	E0XmJG/dlCptvJ9nr005VPQr9Z5r3XDBiRl5Cq/1VOYZoKrgSo7PiDFTvFFvxKay
	51iAGkBZ5mKJJe+yBC/fAhuc4peovi6c1EEZpZPS1C6AyWHAIimQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny4cg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 16:33:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RFmlsd001766;
	Tue, 27 Jan 2026 16:33:50 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhe6puj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 16:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGlKp6vqR+2pQ3OW4QK6AnZqSacDUly4ulQC7pjn/CgGSF3/y9CBDb87rQ/Q3rzESIIgEUn/YX6FlCJJ7iygPh9xC0HbbXLJzdfXRjH3/s9PCziLJcEZs/Tj4QuMFix9TPa2haZoC3IeeMhcqPKrip5vlGwd/H7X5hSCfjxp58UnnnhgzlwsO3MjhqfnGjIdKfJujhIwsf1HFElUPEk+Wl8wTwwVu0GYk83HztWyvZfzoQg4bmZsJ2kUxHsDoFoTpFByNc99FA2gfrsmdGc4H8c6Vv+l7bzviz8T2+wQwoSV2Isy+zM+IyXsMqpywrXfztDnSey+aM4r4yxASbyG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DirloQme3ZfyXo1rbVI8WgLIfQvGEQ/2pShhKn3Jo10=;
 b=DU6Pb61zWWq9tWnLtuIrVjQ5vvZa+K7F3maICye6bCsSUhIDGbiVY3aBw/y5hvWJVyHdE9WSbvBtqATONINxTtZEhqqhflhh/y20FcbOOEqSEUFTfbBuwMBmpKTvpzHXKIrA1iAo6S4drKSfWztPLsJPcPzdYmCrR885wzz2HRpPQY7veZa4tjuUhcGx5knj4dLMsKaY1K9KFkDjSsSYUgeHslwzwzLLdWHNM2/zBuyYq4AfPSw4lFQ/zlegxPMMipJXbVET1YfOD4HIMwRN+DFtScuxkfNvIOwdmlv28/NzG5xPydzWUhjzAlPQK2Wc33cYZKi3TzctCwnfZJv3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DirloQme3ZfyXo1rbVI8WgLIfQvGEQ/2pShhKn3Jo10=;
 b=ZvmTYO/I8z6Z8jT/K+NZ7gfOoD/h+i4GPVHhkhcrNibXZPkNNEPfL/N6Dou4UY35lnUcgxRzd+lzoq1J4ud+2iA9m7Ya+8c/zd8Bx/K6l07x0YAoi4f9jMInqnsrrPw3jLjHNFXEsYvUKltLW7/YCwHDmTjgkRXSRAw/ZgJEZLA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 16:33:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 27 Jan 2026
 16:33:39 +0000
Date: Tue, 27 Jan 2026 16:33:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wilson Zeng <cheng20011202@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: fix typo in comment
Message-ID: <1499adc5-7165-4537-9fcf-b6b99aa71e1c@lucifer.local>
References: <20260127152535.321951-1-cheng20011202@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127152535.321951-1-cheng20011202@gmail.com>
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9fbef1-9e38-4b98-604e-08de5dc1d355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KdD5J61dM+whFYXFaZ4xxXVGWzW9jYvtden80THkqfjPAh0duKbQGMADTdsl?=
 =?us-ascii?Q?v5whQ6Czwh2nNFvt5C3SHIVPSl7M/iSOH1Bx5txKmO8lN2kfcbLOUDeq5xFi?=
 =?us-ascii?Q?As1yWwN9tIedkz3pSzgjRszEczZplG0Ey7IuiVdFSTdyy+zj0f0OleBSoHxb?=
 =?us-ascii?Q?QEI8DjGZ/xvadOOhaigFqtZiELbicSti7qPyo6L5TZDvkIqH4i8fDE3s1nDE?=
 =?us-ascii?Q?gEgwW6ylFDSubE42sixhetsjDWxdlQCJFtn0fQq66z5QkG8Wm21mimnJ9bVQ?=
 =?us-ascii?Q?apVLVcN2DcmBuaB4BGHs6q37iqVpXrctd2u8TMQYJDsP62OyQyg1dvdd8J3Z?=
 =?us-ascii?Q?otyLoPNSCIYPiXNy4l5GUwq+f/A3v6werrG7QhS/OjzL0cMIM7RyUbtoG2V8?=
 =?us-ascii?Q?O36QQl0CSeijmy7HgalJvlNfk1jSKAUWcBrQCXb8IS9M2n7XXlERjOnDKQRX?=
 =?us-ascii?Q?xNhMCDPaOM62j/b6RwUqXeeS3nE67ifnXCeVd2Fl8GZrL9zohQJkhwhGQ9O1?=
 =?us-ascii?Q?B+WIwI9nDZ4HSLYFW8Z/sj739ZmDTwQ210rIDug+kYaY1WSpa8E/o5n2Ic7W?=
 =?us-ascii?Q?541iIJfFZS+QJy3DdMOB8YDg4FPn7J3u/R14BP67SM/rpo2b0NS6shiveAex?=
 =?us-ascii?Q?twWJKD/Q1EkhJKq06RYbaQiD3CRJE0+FZsWLW6BzsfffU6YaSy+lGzcvEYpV?=
 =?us-ascii?Q?Z1A2B9hhBP85JtOL+Z2v1U4XiD4o4TVZMeGZ2opYDFRy4m9pQVmiPwZ2v6BL?=
 =?us-ascii?Q?vMeYoJ5T89rSYZMogHjZ1ught8JGRMOG82HuFmxzQq+tsUE+zUYqBxbERsMv?=
 =?us-ascii?Q?Pf/P9t/ekC/oDB4rCjIyzRkpr+rkOz/mIHayCDW3GwoUmzENWM48i8wDgSnN?=
 =?us-ascii?Q?yYJneKNLV73+8sBeFfU5upIT9OCG9LTq4j3ZWMspuUs8cVUHgZbC6xs/fM1k?=
 =?us-ascii?Q?tIh4sw9IpOwKtnbsemWVOxYCkDYDnepthpr1KUMtMZc3QfJq4BM9O8GGr6nN?=
 =?us-ascii?Q?g5p6+SXnpSvG5rlvv4lIhdf4Y2Deq8uKXXA/Ve5vwCHR2vQ8Aso6zgpre8Ze?=
 =?us-ascii?Q?L2NgDNAgWYWXXURSkOx1KAJtHVHt1iCFqqDPuyjqNA8c6L0CtAP3Gc+Zjrdq?=
 =?us-ascii?Q?Zw53avFSEaiYoPW42j6GSeqh515bSnDRO5ikLqP84z7Sza7ugkewglCqs7bS?=
 =?us-ascii?Q?PcPs/t+XsflDKNT9a8vX4/lQPDY0CzJZLkjCr4/397XS7b/IEBrOENMx+1x6?=
 =?us-ascii?Q?/p+siK/s/yeBBxbRiuuqo096groxY/zwOhOa8UXn3Jjn47Uexgajpml7JKcR?=
 =?us-ascii?Q?sv+b77pNJibW5ablTFmEihaaEQyrwPZL6FSoGACKUypfGaJ7c829f1FJ+kNH?=
 =?us-ascii?Q?+/agLrEOJhRbhY5OjpL3GbBNxaNBhe2KxZp3sfYwDUumcxySsBpK1Li1Rw/Z?=
 =?us-ascii?Q?I4OdaF0bvDnMNxNShPqFsvfcq4ykYRm4uJCwfdULzUXCFS7CymrBJkyjnUUx?=
 =?us-ascii?Q?hWaYQ4GvLZ7E9OwgbJVmSNO/PURBvVry/SpB0r9XU4Ul6g5Ptjzqx/9YxzqX?=
 =?us-ascii?Q?W+1Z+qMwiwGuUlf1kCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?562pPJKvOOfg8+2i4yc4HTScgmzgrxckdCXltwQH/F9Lr5N0FQ0DH8tI8waw?=
 =?us-ascii?Q?VMQcg92TzQPhRLI1tLXWxJSMc3vYTkHXsuemygPIfIsz1Nn/47mP+ytedsH5?=
 =?us-ascii?Q?vgCp7YGbsg7o/1R9jnISmv9iZQTd8sxaUD7wLUbJ6CXrytfyWFxGlstFARKt?=
 =?us-ascii?Q?uaTZaro3UyenuRD0Wjr+P3s5Oy943Mk2sWUkbO4d28+3NuhIZddfNKxERJD/?=
 =?us-ascii?Q?HYy7MR3I52TzuHVAnxRUKsuj/vgW/mCUEcos8FqkjFlh8h/hUK/LeHkYIMSZ?=
 =?us-ascii?Q?iHRqRwMoEP0oADAcTIv7ztsx0XJj23+jYB8cAa/Hj9NSI4YilBTEte2/lN3h?=
 =?us-ascii?Q?DI5nMAaYEJ3QXKZlGIek/6jDzw7TauYlf1giufg7ibS0s5Dc7IbodxMq0npU?=
 =?us-ascii?Q?mWxqklWuGHv4GHoWVMtHcsQq5nrw8ops9VQjtX14F6RWY1sFNEglx1Tl6fX/?=
 =?us-ascii?Q?hBcXbUDMrJm/rfOdBgVX+ISxxOhyuRJTmQaHZwNxVYHyMUCamkRl1vjvMqJq?=
 =?us-ascii?Q?iK7130bmwR896mXSVNQkIBZsvCHQfp4fvnszXVRsMS4Hdv/cLCfvn2z/Gs8A?=
 =?us-ascii?Q?KsmS+g2j1TTj82yFPhiTzUsGWw81YPI7oGppfI8d1PpMlBU2dtggDNSbTZ01?=
 =?us-ascii?Q?9B5J/v4OKzSJ5/B7JhaDFwmeCQpD283E/brdNaRKtxOqwZv/ll+wlzVf4tZ8?=
 =?us-ascii?Q?j/mwxEP+kWUaNcRY1h8IJ91wXTWMvH1CaIZauAQJXMQrSMy+qL6lXwsPssd/?=
 =?us-ascii?Q?0ZA658VMd4ozZgl+ELDOWEBww+45pSn29E50zVF9T5k0P37E/eMu8OeGbui6?=
 =?us-ascii?Q?+u/I7mVyXQMvdWTEryB5BJ4+l9SJiA1Yg0mXwOpwfni0SRM9zHVavB27zdwY?=
 =?us-ascii?Q?ba/AcCIp2I4BVjFf4PVcUKvF05tr9fBq24g27NmuxSowDvgA1BZkkoz0hkDM?=
 =?us-ascii?Q?gv6GQ3p5jUe0alRoFjrBUlX7UHzqco3qZzrt5NeEXwwJFEWdo15b9g/vzt1v?=
 =?us-ascii?Q?HGi0/CkNUCK5XoDV8QWsMocKS4JKN+f/3d3NhgPYMqW3I5h8NPVV/IJx46WP?=
 =?us-ascii?Q?OfloiEzgRbXrPyCOK7Hy2TB21klakodP7c+xAmylhP2I4gDc6SCJRF9a5IgY?=
 =?us-ascii?Q?kjhxYwbyJwuL9mLJYiJdW6goYHbBG9qOTjGRK6ZNlQgOqP9TKSVHQ3VYgACo?=
 =?us-ascii?Q?cT5RlNl1lKKd0MJ6oO2uoG4NLp/eGZdDDX8izxh+Jhf2Mj7dH4bp4Ttsm1uy?=
 =?us-ascii?Q?S1kGOsrYumXfPSmoZDnlSMtXQUjKmVKRzQoR3Nbam50k0krC3nFgvXjQDgWR?=
 =?us-ascii?Q?DMkz01ZAxUFGLL/K1XoLPfckvAjDYLFgMn9o5f/rdiLkuGTYkMdoK/L1iF9x?=
 =?us-ascii?Q?Q8Qdv+oeWWQR7W0k9OQQUpqz0kbDKiF7nqMFyLNags6/pp6j48Fbess/c0Zh?=
 =?us-ascii?Q?86zaqkUMnF3+FJ6Fuy/PW1r9Ey4F+pMRobEjk9DlUPBIc3AxcjRWzyDAb+9n?=
 =?us-ascii?Q?A3tiMKaTR+AS21XYGj+a9PDRHt4RJl1+9NlwixavNllEH4zy1lSeqXqHJ8PL?=
 =?us-ascii?Q?RYdiz96HzNTOD2+fR5dpHtTkoG8xSaIzzyQJTuAY2pWhJpOcdZeVGlzvQSyG?=
 =?us-ascii?Q?Gz0q/EswejKx+8VeDGfOEym24Y3vA2czfnntWtPuEKVA8BS0/9bBC9vK+9RO?=
 =?us-ascii?Q?rDvBTJay2/08Lyi72bV+j7mHqFRzNzLDGxIaEGb/n3OSHC2kr99idWVlvg0k?=
 =?us-ascii?Q?Ct+I64/VJZG6x79tpYdAh+NkDi8ss6w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2o0iR63x5XdOoVVomytPIJt9oVClJdctLM1kopFxWIMcPU97nMQaPWdgPVvjDSWWHx6ophv7UC8Cw8im+WXveivpEtZv2djoS1eDxudZn1zNTXH+pz3R1FcyKePZmLYjya5Y4A+DJWiYOlEPyKvmbMFZT33s+53VbLbumUaBYx/bvH0uAN+HRDwnIF2ahcWsn4A/yBZSRgIAiD+ZofqsuioRQzOB18e6S1PV+8Y2SHO3veWBjDGBTkY08jEgCv+MktkWcZjh/vVp2iGKnJuRkxkrDyPX61vJjsUUVYOTjxa7NdOWYYy7ZGMYPgWntNcQHG83eW8KReWs6S5iJjP0P43WS4gwPrDoFNGuvOiUI2G8LlyvAVRLHMATrBldOHtlINNV4z9oBgk/GpGSCB5lGHvH9CTNbCaRMDaAo9RoLscx0ey0CKIYe0TE/CL2TNSsoNiXU/dS4p2dP3AXfDVJ+o/QHftrLIb6+p6vtE3EjGwDv2xtNT0TEEwc0eG2kqrVBngaAxZFNqh2vO1hOURPD4TIwLNWxz8kGMRQjeGYGKFMD4uJ8PZukekT+dIvRAZTnOV/56pwbp7uDJaJDvqePLps+p2PsRkF8FDYpISLSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9fbef1-9e38-4b98-604e-08de5dc1d355
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:33:39.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvH1JN5WlgnQolYM+09ONt2T0/IwknBdLlYAT4CJV+dbUNd+gxtfRDTnMORQuaO+SroJdokzclYxOQxs3ZuD+K7pVP6Qs7jwklsFziWxD/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzNSBTYWx0ZWRfXzqhuGQYe8mIj
 PGHADFnTLMA85EJ0BNWd1Jb0ogGXyn7WrJHFrzf1LpTjpP5joelPCUsi53p27MANhyoKXvEW4Wu
 z+QIgNEVHqe+inBZJlQuOjNNRrSGMT22GeC/pYI7oigiZOc0Z4oasppHCJpOlWtcN/SaJyFnsiI
 4uiTalRbBMhct2Ot+aGuoeKGPVAQRl7o9ZCTvHFdvBxfsB49CT8KvVLrWJ8KSWSw7C2cgbbqrnN
 OfHo8uc/nxxBrzBndoPUaHcWPDa93aolkM8HsoJ33M2RyM7Dubamy7k6MZxafRCO2FRAT59p9si
 0xpCbluqcguBXs/8ebpaCcrQJFSY8TQZxJFQQzdRNo2j4tCYjOMcW3n5D5CF/S86i7Y+R8SeM8d
 bFEph8X1KYqfxpE+uBar9LVxGPRCTkLjkWrzSKvc5IJAgxDZ0BoxvOp7N8wCs3RkKSauxLN9fss
 nwRLO5skEmiWLXZuwtd4diReD+jEuMoNID0ojkKI=
X-Proofpoint-GUID: 3tYN5DVW0EiZ21JRZXKPFRMSyKkjXwez
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6978e8ef b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=rsC4ewNWawHHegim2n4A:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: 3tYN5DVW0EiZ21JRZXKPFRMSyKkjXwez
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75626-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E08D097CE9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:25:35PM +0800, Wilson Zeng wrote:
> Fix a typo in a comment: max_readhead -> max_readahead.
>
> Signed-off-by: Wilson Zeng <cheng20011202@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/readahead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index b415c9969176..6f231a283f89 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -436,7 +436,7 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
>   * based on I/O request size and the max_readahead.
>   *
>   * The code ramps up the readahead size aggressively at first, but slow down as
> - * it approaches max_readhead.
> + * it approaches max_readahead.
>   */
>
>  static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
> --
> 2.43.0
>
>
>

