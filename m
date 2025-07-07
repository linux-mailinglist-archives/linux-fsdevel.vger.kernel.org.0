Return-Path: <linux-fsdevel+bounces-54081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2542AFB147
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525B4A1131
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9A2951A2;
	Mon,  7 Jul 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jftr91qR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0TV0O/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CB293C7E;
	Mon,  7 Jul 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884367; cv=fail; b=s7QwjumJlJxwYsUma7OOzmhELmuLCONejC6rqxs4HFHntr96JCKGsmshNMfiIuGecY/s9UIvjwMdnywdVbvPBH1rf4clj72olkGaBsSCpuF28k6vXyTiLUgkDAdDYXTJ+sSJk/GVgkme1gdCDKn50PlUO62L3hv20keu4dgowyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884367; c=relaxed/simple;
	bh=4oWjkMEqxb9q4tF4cL73uE419kf1C4i+w38gV/nJmd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GEgK0MGZTacJi0DUV2IZi3c7ljiQjjPsVGnD+1wZnS7ah+HD8jJ5JpZDmL2ZI/xrz1XJ09U1RJBfYqZn5u1Pe2qaFsyH1LBEnn72AhDNZG9TGITmsRvRCJnWyWQANyfqZds0t6Jsu3dLzffsIy5pDbGnmY6tvX85x7Gk+SJvMIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jftr91qR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0TV0O/I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567AOQBT013447;
	Mon, 7 Jul 2025 10:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4oWjkMEqxb9q4tF4cL
	73uE419kf1C4i+w38gV/nJmd0=; b=Jftr91qR0QhvZhf0ZZkrnY+CL1LXsAae/9
	LJb43ZyfWe+TtVXqaDD5sLkVQQoj9lHwi3XW9Gj5EsIoJDPvbiofpEiIKlAIaL+Q
	K6MRinG8zMCqpURQ7gxRVMOwEzjjqzyr6EP21WRnEyEnatPA6Zb7CPFl8g2k7Lmc
	ZbY5odGyLxvynIU2ddaUhoWX+2zWnspgmRkYozHSTbdrBgWyr+861HfH2KXpzqEx
	VsGmkZHReLqlTpemx6BZFo9SEEfSc/+VZoy9vLsVqSys7A+rCVwC4NRHrtbGKlhH
	tsvtebV3E9ZXF0XRBW8BOXjgj1uXsQR8/QcfN0hr9Q29mV9XFQlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rcetg0d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:32:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5678T93E014299;
	Mon, 7 Jul 2025 10:32:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8tpnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:32:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edSJOSbLSr0Ea4HLCB5QuoA1/WRdygVbtEVKsCmKEBNTU9odF1pH+oNjLkO5uTp+SfO6DU3eTsG/5zIzGqrV/3p0+fqEeaOzTqt4+Kbb0WuvGgcX8Z6oSe/yGXltS1QfmyqNbL6C/26iwRxHdvDdyXzU2VeacjqLdH4SR7LDNQx5gzvtpEOcdfT+k1FySoJS/aCrSzYQgkbT3Bi8XT8O6bSZaqFP78FuMTk2jgRY5KunDwIRmrsWPk2xkoSBLMWSlbP80ZdNcFetujrFMhj5zmjbLfl/7SNUFgSh++NoJnzbwMqSIagXRh5CrKV5Od2QitoBG9bXEB85xfIqN/9Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oWjkMEqxb9q4tF4cL73uE419kf1C4i+w38gV/nJmd0=;
 b=uDafKH+UJb5WGkDBXF91XEos4HNR9XFtLDn/M0CWLgwZV/WmJvdnyh+vHheHi4qQ1Yw+K2fpqpYlhwZh7pc//BjW7UTNcnp8iGfcLOFBi7WLE7o5lANw6mBfHBmjnpMvi/tgUonHHJM4pRzNAu/XjnEgylfBdecmxk5OwJYV1IHCLkpJfjhK/jdwzddu1+FOhT8wUo5J1q6OGUL2QTOpHLA2r2481Qx5QsufgqQ2+srEhDOYlkyQozNALbl07VBlKVEHgCzQGRfIi466FA4/N2WFOFDUFPVzwt1mGNJNmu+7GDqtmx2Ge6FBqB7XaqqAP9lD/dRBznt7018kwMba2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oWjkMEqxb9q4tF4cL73uE419kf1C4i+w38gV/nJmd0=;
 b=P0TV0O/IgplyfKLZBF7ESqmAVrj6m6keFladJ+7K0UnzH8ECWJRpkwKioxhVh4qMZaiHHzUqHBjaR99kb/htPzIbijySy2SAeoAkvc/QshIhKk2ETizI0BRP1behBfxqxuEYu3LyRug/DTsvTZczEYXIcdoT7lzhTM8n3Eekmqo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 10:32:08 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 10:32:08 +0000
Date: Mon, 7 Jul 2025 11:31:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <a6e413b5-ff59-43c6-8f59-ee2eab485096@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <4a4344b5-ff68-d57f-de7a-68a091bcb092@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4344b5-ff68-d57f-de7a-68a091bcb092@google.com>
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: ac09511a-62f0-40cb-25d6-08ddbd41802c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMg53BIvg0MpzmUv8RmK47n51bS8e/6jXYZ9FYmdgwMTti7yPhB0LoNmfwvx?=
 =?us-ascii?Q?3YqOzkvV1wgGO3yCSIhKguSP5eTSEUxrNV+6qbQXN1ApIPA5cT1x7ePm2m7M?=
 =?us-ascii?Q?DOwQ8NK4+MsJqNoSWFWzksmKJ6iQGYW/4YQd2sSUxwvS6jM1XFuEuv4iwql0?=
 =?us-ascii?Q?9OSgkGxfK3/3xL5gsOuRtyPrHMq4/EmpLXuJtOWTlJXVFoLxQdmFqS0Yk+zl?=
 =?us-ascii?Q?0lckgqBDZqmfqp3S0uEdmp9M7HBUVlbWe0sqzXEF54Q6VHoTQGNTjECtEv+K?=
 =?us-ascii?Q?GSH4yw2yEhMAmZS5nHHAhilzKA3gfu1GwoQ9Q2hT7IGUEpsJrfv65t56o5TN?=
 =?us-ascii?Q?U6R1xLpixNTAPVs8tJFXMVFIRAGqp4mPbyeHJSdf38I+iuLMA2gAlEJ82nzs?=
 =?us-ascii?Q?HNFpWb48M1HC1GqjiD9ILYfezXc9W70QX9P7M4W7fzxdgtOMd5Oe9DuJlQd3?=
 =?us-ascii?Q?Zeu5KeFkwU75o+7+ZnsSD07Av0RXz7pdZpV2JlxhVa5/nTvHGfEV7N+Dm+oR?=
 =?us-ascii?Q?zPFcJarVvnrfNyJndQNsIc40rxsYPJ2kS1pwh8mHxoRql/1Tj8L40piPi+G8?=
 =?us-ascii?Q?qv+LjFE9NHeQtPxR6djz+4laJsOWVIEa/yY6OBPY/CJ4GKD0037sffr+YLZ7?=
 =?us-ascii?Q?PdzyY1r0wI7vtaAaYvyLjSgVChdVyzxjt82zOfdZvpEtq7DaxJYlmj7Pn+lt?=
 =?us-ascii?Q?/9JVTirMNl64cRSWBeypIaeAHQ1EKA5qJShSy7/Kn12nhNKXsXLiHlNAr0Uo?=
 =?us-ascii?Q?kZNzN0kL7v+8VA/zaBRgq/Chd6ynh+nC90kW+xTIRY4Z6cPgSY8dGkYikfdk?=
 =?us-ascii?Q?V7JWzWxXQz261LaK2tLq98KaWRYtne5EZukcsekFaGOBVEfFWrxLUMrNS1YT?=
 =?us-ascii?Q?0DRjHGQST6dytUaO9knjinwr07YbNS7Q885ubf31UsxVQ3gfRUrsFIDsw+sj?=
 =?us-ascii?Q?6nEXo8VafQjFe/gY67UNdeKtY1gfrbVBfK5GEFsEaACFyXNe0sFvwEursn8q?=
 =?us-ascii?Q?8JWnrEpwmPZiRxjuKNh+kb2JUREzd++LaOK3MAEeH4krah8L4P9bdzVOvgP5?=
 =?us-ascii?Q?Anv0YqYKsrVlgm6GZE97ALtFbfDkkNq7QZiEx/V29A/zUUnNMKOkQizL90/L?=
 =?us-ascii?Q?p4+qFe/pogJB/srmek+lHp+hoFYo3HZ+YHk8bkViurJU4cU3ls1BSTgPso0T?=
 =?us-ascii?Q?k6vBFq43CAnn62hdo0S4c16e4R8XGkdCYlyftSU+aCgI26GqA/uW0Q5jdvuv?=
 =?us-ascii?Q?xz1KQCCV256mPB4bAYtsaAswD8iLt1/Mezs5+rwPHlrvEtADPkeMTaJD3Zyi?=
 =?us-ascii?Q?GT+17AAe6x3UFdG27VVxYYIFjtP/fkhehkWkTpzaWkdZ9JgfDkTRIP19c+Kr?=
 =?us-ascii?Q?/clz/FBdA9O2cM8SqSRhoGiU+wYt03W8ZjgXGKH8Bnf64W2IrswaOK8XjQa3?=
 =?us-ascii?Q?R6lLI7lDPE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8aXWRNGQao1duGhGAqQ8LNoE0EYnIN0Gq82FS3UALSligMbvOFb/Sz0m6uE?=
 =?us-ascii?Q?ocd2QO1dzgiV+HZpXSPBnfWeJeewbFz8J6KSIgpldpFct+HQ6tGbYzdv+Nvr?=
 =?us-ascii?Q?oGXS4Ca1m3QqVWbdyMIYGrng6h4RIvCow1GUiQmkRa16LwoKyGBHh9HBjGw5?=
 =?us-ascii?Q?nHEpiukMAekikKTgJ/rB8/SLmvd+88AlsaNZPHtN+rXwniMdULBSRl1iIBZm?=
 =?us-ascii?Q?PuyaBtLek+QiVqjs2Gkr7JRYS+u7g4vzSVvuIa0K/U+wFv0f3z7fAKVqZ65s?=
 =?us-ascii?Q?CSonfbZSuAxFpJENS1aa8boaha4s9idQEON2wQ5l6e8nbjsSpEAeIRRTIgTA?=
 =?us-ascii?Q?MgSxB4PapJ1MdCVmMvwCYCK3akhC0TpKHQxRo6qVN1u0D9kyEPDS46WTrXnV?=
 =?us-ascii?Q?9G86406+wZbCeTnpEK2rg4LxrA0eoFczxjeSWHtocRs6UvbzRtgiMmkApOkU?=
 =?us-ascii?Q?Fd95k7tOf/DLHRA0fAj1WPHGrLntMhr1sB4VOSpQe36WkXtiasd0Q2nn3IqL?=
 =?us-ascii?Q?65Db0Ky3t06N56pngVohkcuTNtuxDX4COGvtFK61ngdn+6mDg5HnIsKmxCq5?=
 =?us-ascii?Q?wbpgALWnwNZFBNBi4xeA+TG2NY49vYJdPY5UC2+CeCHfmRKmhrHfQy2jgrdv?=
 =?us-ascii?Q?JFE7wLg+ilMeY3EzvFTd5YrXBNm9lMAt0+Ht3biEtvh+kkzz0FNPcHEoZYQP?=
 =?us-ascii?Q?7y5lqLnz8yfSToBVD97rUO7f+o9Z4zMp5VuJaGFr1Vdy1pys1MJAxkXHFY7i?=
 =?us-ascii?Q?QoZWLJWt2gxCOzB2LIa6E57jlLFzLlpqjWAEQJvY5kEMP/qXKehwciYej8HW?=
 =?us-ascii?Q?n7TabL8Bxr58lXocLsI3uI/iCeC4ytfmCvonYrApp/6xDeqABvvDw1ZRkjmu?=
 =?us-ascii?Q?wPnclRCiFLpCfeNhIb754SZqOKUnYBJ3Ln7JhTfQq809PtobWk2C+OG2pq8x?=
 =?us-ascii?Q?ePIyTh5a8WNnTGbd4c2DenZN7HNNKBV4voeaySKXvXaVF4w3nOCV/Xs6Ae0C?=
 =?us-ascii?Q?mz73NE8G+Z2E+n/yrVTFMimdvezLsBMJ1tbtn290iuzrK5Tt4O4ZQ+oxRZMe?=
 =?us-ascii?Q?CpSGTRncsOU/PMeSLkzmvM49OZw2hgNKPgKZ1lIOzU9pidC+2GLz3X1whFGP?=
 =?us-ascii?Q?U8elecG+A7jc1zhcIZdGukCyQ4FtTbOJNkYDsb5YzbrWU7TnsuLKvPuhDdcM?=
 =?us-ascii?Q?PdSQT23jq578/anC7+YbN8Kl+PJOmAZ65NCvDFz+siy+f1oWOOZRgrKFNK9y?=
 =?us-ascii?Q?2+xOACnHX9ruYdhTuzyZV1ZeZUTqGxG7Uq181In14GBp/ajthFl6fG4WmSQY?=
 =?us-ascii?Q?CrUPWBEtgRMW3svU4R2Yvg+sLCY8M5YYD32ntlLwIHaPFIuniPcknjl2T1hx?=
 =?us-ascii?Q?tOkV0p0vHhP83Bi2lopXHtmAlvf/mkF0OA+ArIK5shicKaRv+ojGocvF7c0/?=
 =?us-ascii?Q?zXJe4mr+f7CEBqS4G0O7ARvOI6jQCszgnivrzXvX7x9MfX3KMU5i2Y580DM+?=
 =?us-ascii?Q?jnh2j70aFLsbVu5znQz79h+8KY8KXvP0xFYz/9wFVSloJ7OXQ/itz3LJlpsQ?=
 =?us-ascii?Q?Xu6IFhOw9CIfxQCcAo5qItCwrptio7YI75PeSiqpojDXj6jVVLFPXEpqJMGW?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O/ivLIVibYqqHdhTXDtUVl4DyTEeTWn9itEG/KdN+v0v+AxQGX+OsyfRehmzb+U8+dVdEdSfxrAdrkNQUk2Rgm2Xo94VzU7VSd21no0XFImDTsWWFc34pql0M2FH56bK9wrUENAtse3We7Ywaaox2FyWOh2H7FyH0t/WqdZVfZJ5X4qk9Z5ZTnTy7p11HDKdFUAym9n4Ru+T4ttrueBFXaM158sBKdFjm5xUTs2RZl74TA0grZ2eypz201LaHoDq9128qeYdcGm8Uk7p8AuZQ03y5ylKaXJoddS+h1BeSfOq8KC4N7of7H9ge0LECLXuTzSsiW8DcBHgteC2vfMXo1vgraum/hd5ww0eQv8oowFY6WQ0mryfoXud+x/qBARhfqSDfoFEUtdMipz7Ete/46pbr+ywBidy9MB7XOGOeMxjOvGA29Y3JRAPVp6XpX7kPj+rVTZZioy70hGEW4HzgLppOeDetClk+HnTNMcYO6DP6Wb6Pn1umtQPtDzB7waVtRMpH+fT3y6P7oPKpAFHgIEg1hL4uGOeTQhfh7imm/IWBZmer/f3tEER90fBjYLAjNHjd0+JWTDBIbilDuwEwuTuWr1dk5yv8oH0rot63sA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac09511a-62f0-40cb-25d6-08ddbd41802c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:32:08.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JOZIvF7hVqDey8RNwry1d7IKD+SezQbpir1pr4bOunyiihaxTaQRWxmr5Mxf4InFbuRNzxeDpI+20hMms9wDiEkgeCkz5F5uNcFfsfaDLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070060
X-Authority-Analysis: v=2.4 cv=a48w9VSF c=1 sm=1 tr=0 ts=686ba22b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=g2bAIOH-da_5tRg_o88A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13565
X-Proofpoint-ORIG-GUID: uRNmto4qto28oo6WLaW4c-AeErTCoCZf
X-Proofpoint-GUID: uRNmto4qto28oo6WLaW4c-AeErTCoCZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA2MSBTYWx0ZWRfX7NyuK8iwlSfm 1jn4WCLklSweqLRswgySAHwIMai4u2fqUGi3z2RIa2xv33Vr5sKvz/vTneXhEFgNtMKzbkNN6U2 SGpO7/8txQ9le8OUWTIVq5Ec5H6IVurOJWg+FD5gSvxn4YPsfGAkIBi5MvjjtB1O/itpCor4xLn
 nsWtgce+/hlLbN5zRbTB7ekZuFbUb5G6J2C/2Tu4FpjR6g2sOirumNQZ2jEqB5gVoRgNt915/TE sb1y1SgoApWuiahu5hE0pDHmrfOrmmiTSUjb5rAz3HTpsf+o6TQ23+nPJxbpa7t4Jrd8lpCfBVw LlfVIMqoIMgSfr7J22PxY42lbtbB7CiTaRH4+ttlKWQxu3E5vIKsAr82IDuiN6Je0P9HnXrrPjZ
 seTUicnMUAGzsCayXP/UBhZD1yYgywLjuXEZ53B/O0hDyrsi6V2Gk/kECV0rRKNNYoVgEwZG

On Sun, Jul 06, 2025 at 11:12:35PM -0700, Hugh Dickins wrote:
> Applause!
>
> No way shall I review this, but each time I've seen an mremap series
> from Lorenzo go by, I've wanted to say "but wouldn't it be better to...";
> but it felt too impertinent to prod you in a direction I'd never dare
> take myself (and quite likely that you had already tried, but found it
> fundamentally impossible).
>
> Thank you, yes, this is a very welcome step forward.

Thank you that's very kind of you! :) and please, by all means do feel free
to prod or to give your thoughts and opinions on things, they're very
welcome and appreciated!

With respect to this series, I think it really underlines what a difference
refactoring can make to being able to have code do something new - prior to
my last refactoring series and the refactoring bits here I just don't think
it would have been possible.

WRT to the relocate anon series - I thought it'd be interesting to talk
about why it didn't work out a bit in case you/others might find it
interesting:

Indeed, while I'd like us to more efficiently process VMAs in the anon_vma
case, it turns out there's simply too many moving parts for it to be
feasible at this time - I reached the point of dealing with many many edge
cases addressing the points David raised about folios in the swap cache and
migration entries (which might also fail to migrate), having gone to great
lengths to avoid having a not-reliable undo path.

I'd even invented a new means of 'hiding' anon_vma's from the rmap walker,
and did split folio work up front and and and :)

But then there came a point where unavoidably I'd ahave to do a split folio
mid-way through the operation and GUP fast could race and increment a
refcount that'd break that and... it was just obvious this approach wasn't
workable, and was far too fragile.

Important to accept when one reaches such a point, but it wasn't a waste,
as a. there's a lot that can be reused and applied later, b. I learned a
great deal, c. it helped further my research in this area.

I think overall efforts in this direction will require a more ambitious
rework of the anon_vma stuff, something I intend to do :) but it'll all be
done incrementally, with a great deal of care, and obviously working with
the community throughout.

>
> Hugh

Cheers, Lorenzo

