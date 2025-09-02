Return-Path: <linux-fsdevel+bounces-59935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC9B3F512
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68BA17F682
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E02E282B;
	Tue,  2 Sep 2025 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUQ/Pfbs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zzdfRKB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FE1865FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793631; cv=fail; b=AzCCGJ9uFWXgSQw/INO6pfNaMHIRfXmusD4CIP2KKqkkXwXGGbKCySN/m7jH50jP6sTlgTxineVKlyfcE8t4ezHGci36pasNQdI8OCmW7cTGdP8E04J9HzBfmnerKAe86TufdtBJMQCVxw6PQNA8mFk6dnP1qAZORRFzIDC6w0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793631; c=relaxed/simple;
	bh=84y+g/9/dxyehNwpPd6ynA4EZjm/QHRgY5MroGcIBNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sGqlFCU8kU5CypjCed5BeW+NV6YoamAQwlSJdysGygMdlmRCxPIIO3KAI73XxcqTJ/iNrcU8y0HgSQi6P1XRolKik7O0S+s0+XXaRyaiZoCKtRzXm0liCobhd7BpUQlfqlIhZ+KQkayn+7DLVQFMmGDeEjw2R8y61XfztJTVys8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RUQ/Pfbs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zzdfRKB4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824fuKq002840;
	Tue, 2 Sep 2025 06:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UuogIjHOxCvtXyw1y5
	1V7f/CF3cYIvmFlQKjKO0l/DM=; b=RUQ/PfbsiqUHa8+wfJejsoTv2D0WErrXZt
	vHUg4/albLw0OJJbraLE5ZH+ODDeEvjhV/NBKjDirP8fC0nSVEOB6fYg2ZnY0UC1
	Wo/bzGlki7LSzlGZj3aV/oOeyIN7RLGKWNHyKSG/iUgw5KrvZ0Q3dDjSIo0N4Aua
	xW1Tz6snDbM8JXLzvyLS3Yv4djDhW29dOnS23UyA83uO0ckgIGYZVc3nHl6LlZwk
	c1X9DGlTnY2d+t+LgJe4pRx90B0DfegAzhpCMcuhOja9o+JLiaJtqupsouzPdtGc
	r8QB6lrwLnmF1cmkJvhgp4YK+hdGJ2ZWWDppvgNS9FhLFYPDaE+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvua8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:13:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5825OZlK028703;
	Tue, 2 Sep 2025 06:13:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8rf41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axY9q5L0tPXelj2y2YOqZVBkAjXbZzCHNwKC2l7fWNNW113DIIGuFNTwTmbsEOaTH4fTPPqAvxG06bQ+DmvZGiJ2WdDkJ9XSV65CZeqLlD0RSe/SsashXGY01X9w8MrQ1/VCJkaEqDHuMRoixYG/CMvi/GkD8g9NvF6GX96CxU6QEmUEdu+Mt0hemWy+7bRx3DOT8ujSWsHNYZ2qbx3nhgTcYZXUWjxTOK6EmtLOhkUqqSGuFSY16vcMC7gNRJwzxMir8tU4MyBJfzRAIgkN1iCB6U2rSySy2tNmHw2RHIBYJN3yYilkoFyRzTC8iJjqeN2d8PJdjRzfu5KrKALtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuogIjHOxCvtXyw1y51V7f/CF3cYIvmFlQKjKO0l/DM=;
 b=CB7iyK8SyASwXp23BvCIHnKriTK5lWDcsR2mcW4Zz9R7i88kUyjPqEg/4hALqaAjr7ZmV18pFSpHOD+CPIGCpNiR6kFN/5Jf7D1o4JplW7aC8pntEa3lBdW9qh/QHGxYKjRQXLWHQkYzkqwGeHuDsoiNs3Z4jdhiOlMqx5H0J2T4YcPFtv7CId/PsFH6LEyxfyQQghDS08j/rdw4z/t73StZjpBjKb0mL7H4QKp7mcN0wkwjVeAyGxrsx6qqNmRDQoWOk8E9mUiLTrsKuTKISx3PjP3OUqJjuuh5TX7zCXyi2x5/fcQg0oFH92tPWkpsyHJFinwuvB49pET62JlHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuogIjHOxCvtXyw1y51V7f/CF3cYIvmFlQKjKO0l/DM=;
 b=zzdfRKB4FwcpgaePub/46AYvfnHfEPs+LHJOQcoBZy/XCzoS7HoldEU8J69sK+i3hpxOKQ2GNKBU8xRnQlyMhqlw8XGnM9WiG2IkHy+wXca4uRF9w70KxUzfTNKNpC7n4tSa5hHUpSJl2NKutjpl2mIrXdj15ExGE2RQ40cqbjE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6192.namprd10.prod.outlook.com (2603:10b6:930:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:13:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:13:37 +0000
Date: Tue, 2 Sep 2025 07:13:34 +0100
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
Subject: Re: [PATCH v6 06/12] mm, s390: constify mapping related test/getter
 functions
Message-ID: <0d709350-3016-4676-8b13-3fe5dda916f4@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-7-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-7-max.kellermann@ionos.com>
X-ClientProxiedBy: LO4P123CA0680.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a34ba8-ff31-4500-4d55-08dde9e7dae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1OLVALtWAiuZcfna10tn519MPfKZ8yN4PDwwLrcvi02ho9fOlORxWWooJxb?=
 =?us-ascii?Q?+iGuoTxYGeWxJ52aczVMxvVGpaCmEnaX4FMlPh+qoB7FOWStLUgrrdR88Ud6?=
 =?us-ascii?Q?T/2zY56nsKpcLNBxLn/j8JCTjaz/JEB09yU+mEQNx8lHUL+AKX8efXXBJHEu?=
 =?us-ascii?Q?zJJ/2YGKy7HCfyPWDk0jaAaZybFnoOVOgzjYwxwLvXjpeZz7dRhMg62Il5Li?=
 =?us-ascii?Q?77w7mI3Uc0CT8BIzCVnYWBsAD+jfdi3SH4p8jccETM8qc4tzgjIw8DVJfiX+?=
 =?us-ascii?Q?UkJX6/k/NfO7bC3EsKCXC6bQ0QdxbLnUOGkIS1r0GL0vNLsIW44E7JdbNPiQ?=
 =?us-ascii?Q?KGubOxBinzdMMR5N4FGWuSiprl5QOlycZHp35AVmG/TlG2IH6Mka5+cobONb?=
 =?us-ascii?Q?iSO2hNuPqbRmyLTRAyLZRKcpzw1n8pgecwpO0BUtph5Wda/c+pPtO2Ti4YqB?=
 =?us-ascii?Q?+4wdO1ChpEJR0/aThFobbUrLTIYEyMr/qqQ9hU1jNTVOv6sOMQ2Ct06DaBtU?=
 =?us-ascii?Q?1JRh72L0e47W8Lr/2MkRrKDw8eyu4fhnCYzxEU59lzlvm2A9fb6Nx3WmH+21?=
 =?us-ascii?Q?vtLZPEpxlR26gESQ+Hx7dqnhLqEz3UCwsG1oA34SAzd0WIN8SyX5bZCulWNf?=
 =?us-ascii?Q?3KcPSXW7VNiyjSotZqhKJwD4not66TjKNIyEEJcRQdmnm+xhesl8Swp6tWKE?=
 =?us-ascii?Q?oecaXNNfWKN1ffXWesL5YVoRnwMcYS8Ij7WrexAiIFK3iDeVUOGRG8B6hAQ5?=
 =?us-ascii?Q?FBXQTAS/XhVVBUraOEqlG49WkKM6Pt1ALI9NzhdqtYQGZteGf5aWm0+w1Sti?=
 =?us-ascii?Q?diwaNitSQtDolgyfTcjnAP/1gwNdLL3vK6EeC6AcQA8fY8LtQGWHiXguxUaM?=
 =?us-ascii?Q?fqQp3+NUJWSC33ixODZREQ9P8DY14CjKUvXUXUTtSNyD8KJl6U9hlCTI2J7k?=
 =?us-ascii?Q?MrdeqY98ojgjxKkao+HUIwfYehT2musI7M1tR5ORizadR/e7gDLUS6CV5/hr?=
 =?us-ascii?Q?oEksoTd6YhmQT2133aoephnRi2hMeqJMIi6/7bsYClubvw9GEPtHsneDDS8m?=
 =?us-ascii?Q?/xD0+hnmeqdF5kfE1IFrCKpwPTKKXI2MtnS3z65qiIf3VTkp2R95alC9in0K?=
 =?us-ascii?Q?1j8rdWNrt36DXl4daVjvUb0h/KYdC6sIrkt6lZ7EispuHbn7svu2QdKgBT/U?=
 =?us-ascii?Q?dNtr495z63ocmtf752nD5Q57Ds4egDGEZh5u5O4QSKoRuD9UdNvCPCySCv0m?=
 =?us-ascii?Q?303+LNdFRRmn3gy9gBVZP+4XwXsrKLaqPP25VMMb/hvQB76bWwLIideybk4v?=
 =?us-ascii?Q?YB5NnENAXGiG0Qyea/IUEcBQOldKTsDN4TSbID93mqNUHZSlbjXG5JSuF87N?=
 =?us-ascii?Q?2UwFFUB4c2Gyrzjvy2yfDm4v0C4q2ne+LnzY+Ga/IIo+Yexl8QRG+1FDShv2?=
 =?us-ascii?Q?s5Sn9g87yHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMFD+eWxf15qj8UIZxxHrIWBisG2ocB+TIHO1wL8plTNza1Y3fGST9TkhVXt?=
 =?us-ascii?Q?eRL9vI4r1z046U062FCEYijqh7nnjhrfOc5pwYcIj/NKrs0QYWrMDjtwmUrX?=
 =?us-ascii?Q?MLmIwE3+U6k56QTt4+GkmAO104IAp2nqmZsvjNcRWFBUrfsLihn/tauFSwB4?=
 =?us-ascii?Q?Y1UG/ucVlWiSwDBedm6y5ZTHMpK+dECuxOKLMN+JIYnBLQMXlLV0PflS/+S/?=
 =?us-ascii?Q?UzS5E2zirD7pWS1lknfUfj0cHbBJIT6wJOhMnzDuebOYwrneI+iUCfTRj4v3?=
 =?us-ascii?Q?4UKj+xFYDOFd00LLODdA7g34Q4ZD0ukrZtZzS99c6s9iCw6N7cUoIfAlNvCG?=
 =?us-ascii?Q?b7gNR7OWihxb1C9AZGP2I4FVNFsRLGvFxYftdG75ekt0USlSnxZpucIpzjFi?=
 =?us-ascii?Q?EWGIh8RZx1YAG50QvTEeAg6kxySBhWyxS1RX6MaZF628HP6TkAlNDki1NsM7?=
 =?us-ascii?Q?oHB1ZjQ2HACQ4kS55Ft0cCjNKyrh5qj2W2e0Nrv0dF2wTsG3mhShZ6b15v6A?=
 =?us-ascii?Q?OyeW66uDfan9x2ZJ6j1RP2vITMpzFYHt27inV0KocrhZDWIf3CnxnmTgxhMf?=
 =?us-ascii?Q?9aL0UIkv4+b8GQKiOqKKO8KCyhEgHcQzV4qdWWOfUcfwaKyukz8tJE5M7gE5?=
 =?us-ascii?Q?ievOYGOapEW0TFG858YHsGB4aVhMIWuakpoGHPR7coLGeOz4RR3z/nA4ER48?=
 =?us-ascii?Q?t4mp3mVhbEHjzwj855faNrSrfnXWXEosHLYtJcAghXLw3eeE4cbnK80KD/eA?=
 =?us-ascii?Q?CMgNb/qKUgWX1bgLywYdtxHBft3hQ+8iPi2kbbRjrAfw6twYBVp7cJMHqexR?=
 =?us-ascii?Q?eBZUNsRZYnJe/B5UaiRn6CHEhnsi6I2EWiV+GeyDJ7EM6F61y8a35pklzT77?=
 =?us-ascii?Q?WOE/THzMqYaoUw7LYrzrperJMeXAC9gPgP9vroRZ2/opwbLmttGtL9290RXv?=
 =?us-ascii?Q?e1833SkFzRkB5M/RN5+mSnBAPUxAmdrsHt8NUGiYF4z4pQO2GQ263eSSEMFz?=
 =?us-ascii?Q?mqVPM3waLlEXqtptVrZ6O348afnZShSWZRZVDi9MiArEOf4UsrWfrnxZpgvX?=
 =?us-ascii?Q?t8of1oy2N+Vb961aSYL2kxye1sMmAzYxnHNJbndpQ3z/V5xcNtRxEW8Jmfdp?=
 =?us-ascii?Q?1tW8Td/PAKjuKL/WfimQ1QzhykVDrRU4o1FraXcx87YonPICkttcqWaxra+D?=
 =?us-ascii?Q?ycWLElf0vvhHzKuJ9C5EbB5bxcL3XNiGuKxG03DM5PsHWcEhpHMyYxjdILN/?=
 =?us-ascii?Q?hHD7fThrfupjO0ZrrD+lLinONyEya/LzPSWYdOogw0uwQgnncf41BzCenhE+?=
 =?us-ascii?Q?nJD1bwfzy03rugZh23gP5hCJQ39DB1bc6MWmkp0+s8kSb5gBxZDA5b1+BxUH?=
 =?us-ascii?Q?UdRemqvYm7wbGT2V1+s+Hsa6NmONynZxifZmjuFUcjI1rC0U0B+iO2vpST9R?=
 =?us-ascii?Q?9C/F8MWln0Qtw7LPIx5pLuPonIu1JX/Yt2YD+L3OG4sGWD/M4vazUeKsTPWH?=
 =?us-ascii?Q?R/aw4fcE9Bzk1mflZaexxrFJcUduJUoyVJD9qrGEc97sTefrzWiyG/p9h7N6?=
 =?us-ascii?Q?X00KHUH8Iouloa1Vo6v/Z0EVh2dLwaFI6Rkd3kF62aiCskhtI01tEaCpL5Nl?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dd1OExIMhKCoOBs2kuoKJi8uOh1SN5r48cFZSgCPMi1ISy33Far9OxixV+jviEcfOmvHHFXPUg2SiqkdJVAEQIpXUSRn2R26uR7jWJ4YLeHNLl2W2OkekjX6GIJSQkmfL9FHrizCO3/KVUt5FQUYQK1wcdEvRvPbaHUfApHycWXscY/K0zXDax7yOI6vwkA59t2P5+zwcNuLuWxMO43v1HCSnQ65inJT66exzYNyXaouPLPxEoCDCXPixBSECfSdhvGtR7JESIzHfdm//figTFvTKQNzORZXibQJyLrOvxUX79guavDUXMkzX0v5CBNdEDuYnidJx01FDhu2u1qdI/bYzcG9yw0C7S8WmYYuRH1R8TvT0iRAyuhtCa42ESM0imK+ROF1OcUTdDPsHTdib1IMHHnWeDh3tSYjHeh5sx/XTLrhiPW+yvs9xEnlzDzc+yxZzjwgcDsfsI7yPpdy/TxnlaGtQfyjgHdra4kxr81yj6HwUVQuHZFr3/gdzNzpOIr3/Y/Y69qvo3W+Ag8VRGKlqVCyxDDmI2Hr0ZTc/CzihVvGWDB77XyLmKGYeB6p5NiAkynah+Hi1i+NgyTGdIcBJVgWeSOl3dpRslwBqgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a34ba8-ff31-4500-4d55-08dde9e7dae4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:13:37.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE8CTDArUVGUequS/Bv24dMVGBPIXXpqFAbCbIj9pNX28P79UtA3sU4Ey0YpZVD8VU4BXma53DT1wUI+9o7CD+BaB1rktTalO3JKx32zxc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0bPSDpDRNxME
 qfAlACDwy+Oyv/v10HS2ekSiV2rD9Z0drzUQ1b/aCF8Ib6tN9y8qWCmlgkEzrDdWlPh16kSSs8F
 eB5/zNx/6PihQf2LdBKdlfCxAgrFg+Mpu5C7AluqiU/dkBjZF7aR3CuM1jCcjhUkUO5tNde0rjF
 jeoMxnKnACYZpdkyH474LTSyXCMtmYykLz8WO4FaSejrSBkG1BlCIE7ul5lNWVsdoNBrWQ8KWqD
 xzkTPl4rHVoogZb8QIZXSXBglIOWQYfhFjrQsSQXJb9FvI+LUcPbSR05i9K1LOypstWxKmM6dQR
 iUm8necPbGWOdwp5e32ZDW5JJ2m8wDNQpgyTBl/LYq893XJ3v3t28c9NL/UGsvas/zHQU5bVdIU
 E6Bf8V9Hc1gGgbdyv/yd4WJCeGaAxw==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b68b16 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=vV8DskIK2e5lZw2h430A:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: jp7J2qG1FcD3wMJnK0lL7vI2-Tb_gMSc
X-Proofpoint-GUID: jp7J2qG1FcD3wMJnK0lL7vI2-Tb_gMSc

On Mon, Sep 01, 2025 at 10:50:15PM +0200, Max Kellermann wrote:
> For improved const-correctness.
>
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> (Even though seemingly unrelated, this also constifies the pointer
> parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
> the function exists in mm/util.c.)
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/s390/mm/mmap.c     |  2 +-
>  include/linux/mm.h      |  6 +++---
>  include/linux/pagemap.h |  2 +-
>  mm/util.c               | 10 +++++-----
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 547104ccc22a..e188cb6d4946 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
>  	return STACK_RND_MASK << PAGE_SHIFT;
>  }
>
> -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> +static inline int mmap_is_legacy(const struct rlimit *rlim_stack)
>  {
>  	if (current->personality & ADDR_COMPAT_LAYOUT)
>  		return 1;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f70c6b4d5f80..23864c3519d6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
>  static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
>  #endif
>
> -int vma_is_stack_for_current(struct vm_area_struct *vma);
> +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>
>  /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
>  #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
> @@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
>
>  int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
>  int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> -			struct task_struct *task, bool bypass_rlim);
> +			const struct task_struct *task, bool bypass_rlim);
>
>  struct kvec;
>  struct page *get_dump_page(unsigned long addr, int *locked);
> @@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
>
>  /* mmap.c */
> -extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> +extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
>  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
>  extern void exit_mmap(struct mm_struct *);
>  bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1d3803c397e9..185644e288ea 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -551,7 +551,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
>  #endif
>  }
>
> -struct address_space *folio_mapping(struct folio *);
> +struct address_space *folio_mapping(const struct folio *folio);
>
>  /**
>   * folio_flush_mapping - Find the file mapping this folio belongs to.
> diff --git a/mm/util.c b/mm/util.c
> index d235b74f7aff..241d2eaf26ca 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -315,7 +315,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
>  EXPORT_SYMBOL(memdup_user_nul);
>
>  /* Check if the vma is being used as a stack by this task */
> -int vma_is_stack_for_current(struct vm_area_struct *vma)
> +int vma_is_stack_for_current(const struct vm_area_struct *vma)
>  {
>  	struct task_struct * __maybe_unused t = current;
>
> @@ -410,7 +410,7 @@ unsigned long arch_mmap_rnd(void)
>  	return rnd << PAGE_SHIFT;
>  }
>
> -static int mmap_is_legacy(struct rlimit *rlim_stack)
> +static int mmap_is_legacy(const struct rlimit *rlim_stack)
>  {
>  	if (current->personality & ADDR_COMPAT_LAYOUT)
>  		return 1;
> @@ -504,7 +504,7 @@ EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
>   * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
>   */
>  int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> -			struct task_struct *task, bool bypass_rlim)
> +			const struct task_struct *task, bool bypass_rlim)
>  {
>  	unsigned long locked_vm, limit;
>  	int ret = 0;
> @@ -688,7 +688,7 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
>   * You can call this for folios which aren't in the swap cache or page
>   * cache and it will return NULL.
>   */
> -struct address_space *folio_mapping(struct folio *folio)
> +struct address_space *folio_mapping(const struct folio *folio)
>  {
>  	struct address_space *mapping;
>
> @@ -926,7 +926,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
>   * Note this is a helper function intended to be used by LSMs which
>   * wish to use this logic.
>   */
> -int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
> +int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
>  	unsigned long bytes_failed;
> --
> 2.47.2
>

