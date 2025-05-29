Return-Path: <linux-fsdevel+bounces-50020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE8DAC760A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 05:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715841C03360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A20724469E;
	Thu, 29 May 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7j1sXcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ukF3iarI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091D2629C;
	Thu, 29 May 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487780; cv=fail; b=LN6je2KYLPgkRx/YEZYnsFd0nITd5IQfq5FSfyKib7xOTPaJ8d/UW0r1fVgFbIFTn8UF5jAhkFyPMF1a6rfWLqhrLC8URaw51e8Mvs7uY8CJRwVXJGj9S1OUNNxRFwLKrDDYB5oFaw2Cb0ENHwM8nvI2IDcXU6x48rmWVfLIOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487780; c=relaxed/simple;
	bh=3Fm1knflMp0MqUcl3mkMhniJMuxklZhiK01TtfID7R0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=e6i+dVGVSm45YFVfSsmuFyNAxfB/xx1E+ZKpPSFrfRpgt82hRux5Zvp0/2MbyPQU3HaWbQWf0Nmvo3f/xN5Zr3c6TTSMgHfO1mPsLsZ96Iyrixohtt+3fAVPIbRFcz+QT6RbRZope3TcasnE31BYHNz1weu9NNC7ulmn8qDy+io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S7j1sXcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ukF3iarI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T0NBxD008134;
	Thu, 29 May 2025 03:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pnGv4so+o4w5AfK0ze
	I6hdXpjQcPIgTcZkGps+fTK/U=; b=S7j1sXcCILB1zclTKcJXz4aRE3xJC8mqO2
	199letHBarU52HOwNFzYi8NarPtkqD1G1DwCQH2cJIehXaNcw+azHkm4KDDJEykJ
	lFhXpZ1jvWEyzj2rWQoA9H/6pIUycCOQ5B5zabFLme/29KdzipZ0ltG1QBwXY7LM
	jLpqIW8ZT3hSfAZW3HQitFxnp88jwJX8pyDg5pC9UNvI+8CuYoEOgp/R/S2rbbo/
	eU2rFOeRtE0kz95lSlJ1OPzHeQ0DSR9TPsUKp1dIfUXOrIz1VmVHghJ7P13K34jl
	eUhZ4ss9ABKGGY7/RV4qYWxCF93/BLyQJ/WRDzbm0ETM4xUk5doQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tycdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 03:02:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54T076nm023248;
	Thu, 29 May 2025 03:02:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jb5dck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 03:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWW6DDMeE0sxDEdysXZ25w4q8CaJ94SfBj0m0r9BWIjDGxR+moelg2tTmQn9ZBdl4NK+ed5PQwhDmKzVmCJBx5vdLcwBfPmJJG8/rEVGCBGUGjpUVwQkvCukWK8YxnDgaCvnC2sX8TIFrrkUq3gyDXde7vLRvJ8bFbqMgUD0gw29nebVzqx2iLLeYu3kuGxI5+TIseu5w0mzExMwdiKJ7TrH0VAZKTpM/kTea6Ji979SOMmFX88gEz+S0OkkkXU/xWBg2PwdSRY1eCx0TkIQs9UJgDJ2CRGdlF+Pcm4F7MSLeWkaYDYddA7XMEW76zL9HRrZEF65Dh3qCx6mrK+E5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnGv4so+o4w5AfK0zeI6hdXpjQcPIgTcZkGps+fTK/U=;
 b=VWE2YmuPPO41aLVcVWoyHJunuiOMAZxO2Sn4DsiDEscXYSs24dXphb8cggH7sWW5Lzm4/S3n9NPJbSg+VVOTP/qnvZPF57CX1Qqw6CEO6XPQrVjeEOL+YGWfD7UO5UeMGM4gxWQu/tE80c2omMlgJHN0BSuZ5PAulpPOzG9LAYM2ytOrmEvNJeRJy0XNKuCvMp5pYj0t4cNYj2KJ0HhgAS2nV4azdwupgVKkM0avYHmFg0OjO6FY968ZZhVeoTZP2yTAoJ3M9zbmca5i/RiehEuJTO4Z9hPKwI3KSmLjvsqKSXgTNTZ9S/1BQ1eqVqV/VeXymKrPB1yCfj0ayTVaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGv4so+o4w5AfK0zeI6hdXpjQcPIgTcZkGps+fTK/U=;
 b=ukF3iarI73Vui+6IPvXLVcfjBDNEXbAToqHkGU8H3f142uGUcWfmECfmIuPrfXUAiWUKnRqsYIq/YlQwM+HLFeIuuyW1EB5nBNlizxMvrSBTh3baH6/xRtavsbc6LzS3HMSn++fv0o9w6XkZ/9n1HtVQy5o1I2JL8uRPbfT0dmc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Thu, 29 May
 2025 03:02:35 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 03:02:34 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: jack@suse.cz, anuj1072538@gmail.com, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250527104237.2928-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Tue, 27 May 2025 16:12:37 +0530")
Organization: Oracle Corporation
Message-ID: <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
	<20250527104237.2928-1-anuj20.g@samsung.com>
Date: Wed, 28 May 2025 23:02:32 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: b6945464-6753-4dd7-1c04-08dd9e5d42c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tlLmAFfW+nXFvyZ5D0DKIHm+vhBOZNs5ryulRoqGRfS3IA6y70w+pMCFLUjI?=
 =?us-ascii?Q?Nyq416JND/SsHU5AMO5EsBcQ+qxysiMIJ2eeo3PXAGWdbKt7/8Z4kW7YTr7x?=
 =?us-ascii?Q?+RBf31tF6rklqYdWusEswDy1UxYM8Sa9flRGqt+YCzPxz9wXetBj+F0ahQqz?=
 =?us-ascii?Q?E1l0hXDeaJA+WMVdjv1HHa4n3xIP9PugkRKa7BqwSB9oNQ3H08pcCbG9Y93s?=
 =?us-ascii?Q?VU2vqb+5n5UuqA01Ifhi/CzzzjYUgslFTxNg7PRjIfnRH9eKlQvlh5IfKwi7?=
 =?us-ascii?Q?TTNYqEdVIiKJhbvL9dGKZHGzhkjxPActbnr0tpnluxShnyUASsCFdccUtGa2?=
 =?us-ascii?Q?fCiNi0MulQC0j1n+2Ir1RaerJdA6lwLqdMvo15/V8wC3/pJ0NctRhtAJ5bK1?=
 =?us-ascii?Q?WgzZVewZXB4+EBQDmuwEkRwUBRXNcFBExaKsul1cxDxk0xOQ1OxRyt7xWRtp?=
 =?us-ascii?Q?SYozyzFIzIwTJHZZFwzD12SgKdkBC7KqPJ4HO88W4Y+iVs0pygRbTlZKY60p?=
 =?us-ascii?Q?B5vm8Rt5RBnZGF1OU3/dWaE81Olh69MN2JB7iviVxZdy4VbX4ezVWkWuNUB5?=
 =?us-ascii?Q?G07dzFxCR0+FFwTEiQY9pGACVWeZF1TiXceUtJTuhdFPfJQ1QsgwwYxzJwPQ?=
 =?us-ascii?Q?KCGIt7B54n8JhxVDSRXaCDqfXOvJd3P7ehRJH8HYbascHFPvK4OG3rZog3nA?=
 =?us-ascii?Q?l0RVJATUQ5pendM6n3VjL3/dBhGozBFJxyt+n1D413O8sQ0TJwiieJm1rQUR?=
 =?us-ascii?Q?cHwbrs7sOXszgJp+IBN0SID3kFgE2MRjluU/AqPhbBMx7oVh7vFB4/iWLsuD?=
 =?us-ascii?Q?PnnsACqef8h3CZCAIn8i451fr+JpSibohwcCDQCCA0EMSGnhLbfzVuju37r5?=
 =?us-ascii?Q?HTHbcA7D47JNxounhryB6RcVqZ+OLpsJuOnJpyFCITH8PVY1s6m6Q6HOFKAd?=
 =?us-ascii?Q?+HV9HYs2zYeykPt0I+G/7TJVb5XKB4SnQoOvvnYNkKKN2tl1SfT0mZPcVcv5?=
 =?us-ascii?Q?B9xXWjRHbxTYanu9sPgVN1beWHvcgsyv3ioEPKnQPOqlFZKRwBmq7qK9M5s6?=
 =?us-ascii?Q?ZvBACWhuP6g2dXIWN8bD70DOUv4UKDw87EJ3CeAETpFATS/5hViUmanuhZTH?=
 =?us-ascii?Q?jouqO9G7JAU9u36/bc+hSP6Wx45x2V6CX66BKn8dR9S9GqgWUL7b8w2HOegN?=
 =?us-ascii?Q?CQJHg+0QCGVEofSGhzRPbgz45Bfe38wPl3uquK/S1KayQFznZCCcBdRltuRe?=
 =?us-ascii?Q?lA8Y4+aEmV/Btgd6i6ESK+MZ/gcLuWdg5itCW5etx4o4WScRDu5z4ciSMZ7f?=
 =?us-ascii?Q?kaQfiF/GcegST3dLnH04nmX7Yginxa6qtQ7SBxiVExsU8bea86ZRkABarns1?=
 =?us-ascii?Q?M1NQyHnsKOECiKVUG8kqNUs4a+AqK3CY9y6bzDmXWA446WzgsqnheSLzhqeH?=
 =?us-ascii?Q?h8CPPqOydIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ct5zpyEuvOhP0bbmACCpYOOiw0qzAbLib+2BwfgUlkr89cUulhvVNt9/Mwaz?=
 =?us-ascii?Q?roM36YMK7bhaMF3SwGc98K/bgvEozOBDohdpGNXQyKXSSJYlbxp8CSkV7rSb?=
 =?us-ascii?Q?1hJapwO2IxCuFs125FnQ8sS/S2lavSPf58u2dHTR86VLpKzE1NwjBebcOCZ4?=
 =?us-ascii?Q?kUicqhbHIpt8WwuxLp2mjgPe93kC63Nr7McS4grHFhe+WR3K2bAKDd/0C4rx?=
 =?us-ascii?Q?eVIjGVHV+By6lV7a0jrtwCDfdmhGmtqCyWYbrhmmkj9eGKG0gpg7XPVpE1GE?=
 =?us-ascii?Q?uaM8gQio8f6Z0esGYOo7JFbZx5Hb64Lq5J6oQ14zjH4iOPm8tMvCQhc0O1EW?=
 =?us-ascii?Q?u24+oxjQMKOrEyXx/8+RQXiJLYW6ZjFzyyniLb8oqDgsi9UC3mdoMAHtzF5B?=
 =?us-ascii?Q?354qOx++nWdP+mLkC1QmieEXptgG0pF44tVO02uvaKsXPttlrPD/IlZm5YSp?=
 =?us-ascii?Q?z6Kdmy2TeG7iw0yosbPbRsdNL5DQixZwERLyp1Ul2q/pBXVjIe3xeEze0UMQ?=
 =?us-ascii?Q?kFrNiEGkx82n3XlAV1DZY9xQq9N2sV1hopflUt3+INYalEFJGLiG/+2Mdh9w?=
 =?us-ascii?Q?wn+lMTVtX/8jMXwipx51feNXTqDWrQhOO6Kw++XXu7zNDExvqVi5AaecpBT5?=
 =?us-ascii?Q?NBiki3+UavZsmEW2y5JoOpGcCIjSxvUf3ohxZAHHEdXn8eFTK0lFVVKfy6cq?=
 =?us-ascii?Q?Ch/9uLNZvMq+iysGzfPlKbSdEkXxPY92+Q0b3jWizlKo67B7lCFolJoR7UNx?=
 =?us-ascii?Q?Qhwe7VlAppk5akrYZ3Owgk8ipB5NyU1YOc3poAprlhmkB60MP9DoXHNM2Y34?=
 =?us-ascii?Q?n3poweIfpY/0QsofmzDwiyv1wfvymSYKepWOEUkUipY51spNByHaZ4XqSUdr?=
 =?us-ascii?Q?WAClAloJ7W6w0DbaD+nCAqby6ewxzqOOruZgFMEz6HcA+6+ZpcnhE2nMuMBb?=
 =?us-ascii?Q?MGZpmCvBsqeM+3p711veJ+mka6KgxPcCA6RFVVfdb0IaFIG2Z9Ac++zINcrm?=
 =?us-ascii?Q?LKIUhcLJeIN87bAWGgRWnyt67r3oPqjPf3IKZRga5UQHCNcvICASTXz3rZMD?=
 =?us-ascii?Q?6ae3CQd0gCrDFpdxt+cCTziU2kvwL/TEBJka9JgCOYIL7YfHm3XYMXD+Efkj?=
 =?us-ascii?Q?uLsArRcAAOFAE3KsRnPumtDi44e668S/8v66AAoUB4IakqmGzt/dBmklUwc8?=
 =?us-ascii?Q?GovECc1zrdCVgvnmgGvRDuUh0lJEEeHSYkUrV6TDzvRWqi/ls9X6+iWmHRaB?=
 =?us-ascii?Q?8IcbgY5f6MwC91UK1UAyO12/XtXMFzLmYyl6WP/Q0ucbPh64wJRqBbkS3PXK?=
 =?us-ascii?Q?e4/askmdCOGg/YTMgAqR/Cmy0LkxotgMsI7EM4s6m/es8Ks1LAG1bTjLX6pM?=
 =?us-ascii?Q?MTQ95SClO/plYlPJ7/BkqenpadvMNSGeQDJkS2qCzzeOyFfN9etudjfnf361?=
 =?us-ascii?Q?+sZhuOI/w3avI7E+T4qxq31M//BgH3F3wJywj8tYcQL5QrOAkvf23abI1DD1?=
 =?us-ascii?Q?TWI+Gs8kS2Buy/0LlYVxcvNT/KMBYmewd+7whsZqmX+z8e670My3RORpAURZ?=
 =?us-ascii?Q?2V5NIkU1GKq4Z7lh/7bv5sbc455lcl3NO+2tUG9GIScoY64y0+CPgawxkhh1?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IEDebwEmoKW6FYOF071jAdlKCgoWH+8Z/HZsXUYY1xOFZuxVNQr5f3X4KWsM2IONIZWiic35WfSiQQOFUKjWALehNmpZ7qr8bK2ASrRIekkbCMD4yB+ANdkOGyQk+Xm1rb9N+8qNsXY5PpCiOBOhGTV3pHE2Uh81xY7Jd7Q0SFb45rlLSy4+hN5Qo3DGpWqHPIJThAJL5SALDtJi7u9XwZQWXlh9O87qmSF5u5Hb21w1bSo99p3aY/Zj4DbNTMVmU/TzcjI94U1dLZ0OvLyhUI2Q3XUlhYnxPFtF8fMkh7500CEjXViSXwDIhqnUBYiAGSFyPeTL4e7tERjcAMrMxGZs9xbx+kH4q2UTEWeoobHyQiT4Z8ge+9/ZrGhKgNv+wTTRXwNVOEGhwERJCUUkprY7UT8Sx1cTo/cVTIEKFCqD0LtIeyZ2IemRrdmOsRE3V2QSYUu0CnyVYS4/iDPSEPyTbipnngYfyWyjOd6F2A6gjBfjcMxcuRQwrZRUsPmHotERafHBgyjC99DOnphLRRSIrKIaAPPn4DbHWAu2qADm/tDbu/gUT8iVPTAhX8ekoggYapVNKwp2yqoIlEw/zynd8Ps12eRU3xC2HCLY+Dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6945464-6753-4dd7-1c04-08dd9e5d42c2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 03:02:34.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP+Bc0nn0aQHIt6QNcSJqTCoRAFJ+WCkc/AJffUOH3abxBXCk621h0lgj4HNyCZKk0CQorIuQTEb/pokZY+08sjOE2zMJdJQ3mcXIbNzl4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=859
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290028
X-Proofpoint-GUID: muXHBbtLiEUNiyF55C09fTfi5I-DRS64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAyOCBTYWx0ZWRfX1yhEhHH/eH68 PCNLjVxi7hZjmKPitk+o4dmyZAWK22rRXyZMDjVCUStXdsQgtIe8zrrbRTfcx2pdwHPMLAuyDFO D6lKCSG78Z7u0VJTYhFtrlENJ38wiy8CIwQdmNEtVXOV2mBAQrYdqkYDZRI3XhWmwg1ess3O+Fo
 d/mYwEuEv512MxQ7F9Ya8wtSbMLXlXEXZxCeSdlbGNSgpbGMc0M+GnYp3iixc88qLWcqcXq8mcC Lwp+AyXeDhZ/N05VADGRQyHRp6QIZv9HpDR5rjWz+xWuinF/+PACH1NVrO0JL/sarzzHrL5rTkQ Qkb60oNhyHikg5uajXn/Q3Z2uye2eJutD9QIjP5xsGO1X7fpKLdlnXbmWI705wPmhCuL/Z8YTyM
 Ce2peHWxTS5ddPuUEPs5tDFYCVxGMYclkctT5QAVF3fJZwKK9FM0sj3O7MqP3x4P5SWCbMZY
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6837ce4f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=4MfagVwJvyo_aCN8rFoA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: muXHBbtLiEUNiyF55C09fTfi5I-DRS64


Hi Anuj!

Thanks for working on this!

> 4. tuple_size: size (in bytes) of the protection information tuple.
> 6. pi_offset: offset of protection info within the tuple.

I find this a little confusing. The T10 PI tuple is <guard, app, ref>.

I acknowledge things currently are a bit muddy in the block layer since
tuple_size has been transmogrified to hold the NVMe metadata size.

But for a new user-visible interface I think we should make the
terminology clear. The tuple is the PI and not the rest of the metadata.

So I think you'd want:

4. metadata_size: size (in bytes) of the metadata associated with each interval.
6. pi_offset: offset of protection information tuple within the metadata.

> +#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
> +#define	FILE_PI_CAP_REFTAG		(1 << 1)

You'll also need to have corresponding uapi defines for:

enum blk_integrity_checksum {
        BLK_INTEGRITY_CSUM_NONE         = 0,
        BLK_INTEGRITY_CSUM_IP           = 1,
        BLK_INTEGRITY_CSUM_CRC          = 2,
        BLK_INTEGRITY_CSUM_CRC64        = 3,
} __packed ;

> +
> +/*
> + * struct fs_pi_cap - protection information(PI) capability descriptor
> + * @flags:			Bitmask of capability flags
> + * @interval:		Number of bytes of data per PI tuple
> + * @csum_type:		Checksum type
> + * @tuple_size:		Size in bytes of the PI tuple
> + * @tag_size:		Size of the tag area within the tuple
> + * @pi_offset:		Offset in bytes of the PI metadata within the tuple
> + * @rsvd:			Reserved for future use

See above for distinction between metadata and PI tuple. The question is
whether we need to report the size of those two separately (both in
kernel and in this structure). Otherwise how do we know how big the PI
tuple is? Or do we infer that from the csum_type?

Also, for the extended NVMe PI types we'd probably need to know the size
of the ref tag and the storage tag.

-- 
Martin K. Petersen

