Return-Path: <linux-fsdevel+bounces-57980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6043AB277C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 06:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C831CE7503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181682236F7;
	Fri, 15 Aug 2025 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UZUAN7iU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gq498Ubf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5E1DA60D;
	Fri, 15 Aug 2025 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232111; cv=fail; b=NwxiwoLAw+RfIpUug4XEBCzkW34neuTYuQzVFtq/q6/ssdmTR6K9SuM35cxXVyB/+imatGOLo7OFM33SMt4E4/mVS2MHvYB10sbTl/Pu077NsNIecTX2ZGQvH2wqIb/8XIO5Qg7ZMfo8j742zZZFf6v226N1VH6uFkb432mWy7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232111; c=relaxed/simple;
	bh=GXC8DX0F9GCJ7VkRoIJbpsojh3+m5V1SFMYzmQoEtMk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I5NHdT56II7dreXlPfy1yPR4rco8uNOVTo1EtbTb1dOnEjRl1fBonfMtGGmFwhP8sRWfug+meMVK6WYdAfaHFUqzkAKgEzYph5T2hz6roSNMdVMQDQeberJP8o+kdFjAP7lM/iS95ByIJeV67Zh28Jo0Z2yXfY0VQBjiYk30U1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UZUAN7iU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gq498Ubf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHg7FB010902;
	Fri, 15 Aug 2025 04:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7qLYyZAfJnweZAsoct
	XJlibuoHexmM+gDPA32McjOP4=; b=UZUAN7iU5ruD84YQlZaczaTWNG5SNv1sf0
	dtnwkDSzWtE9mGh8oFzgQqGgKkCXPGGazql8WL9DjiQ0zWbF38yj8jMsTSHki3Tz
	iqFHpVupbakAPuXIECzNYKU/8pbKiZGkBHywFsxxDhY1XrStLtrmFk7M81znpguy
	YwMa+78RZNLKZAbwQWCQUjhjP4xmGiX3zYLmMco1IHPDWw4f1DnF9fPNSSCcy/ll
	4baKn6f4QGF0JxIO2Mr7sFHMS32OgxUbWsB9xVAqz40wWRieRH7OFiW+W6xpQLqf
	DrQi7mODeox3aSad0W9Weq331LPUxO1vxN5fM93JVYxWJfXbSa5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw453d8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 04:28:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57F2TfrS038587;
	Fri, 15 Aug 2025 04:28:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsm5ayq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 04:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsxqaw38y/DfnpW6Ks1GAhDqHqUjQXtMKsR0bF1WLN7P8hWYZ1HXdnwue6fiWKcGXYY55FA+vWYTNwITHL7bzTytCPtpWketpKT2+y99ynt8CYBHUT3v2ZtPlPGPxmEsOzm8p1fP7mQQv/TrqyqKqqui35GflWPkcvOP16seo1Y0OiWLRSh1WL4QAOhDwf4Ql0jUdddkR8b93fhe2KrW0XgHgUfTe5oLG8lGOmrW4DH6r4stmlPeLacFPC0VXSbGqrChq8HzS8qfdMcaCzFdRM5KNpjW7PmiW2Z2Sn8PI8EzrLSMmypkEWgTiUyYxJ1XhmHZd/Rx7TQbHRiJIe7U7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qLYyZAfJnweZAsoctXJlibuoHexmM+gDPA32McjOP4=;
 b=w9E2noNFwKeU5Dw/4J0k/iEKzxMU9FTVvHjJcCCBV2g2JpJk0/k5ngxMStKBIpTzGY2LMyzGy4Bm1B63R8HNdGJ4RG6lOEJSrhAhyWuxrfH7yk7HqHNt9RH+U8IWlHqSjuALBMFjrMzc6icpHHlHBwtq1Ej5/gPodO7AmFKdw8lPs98PSrb7Q/BbCKngH6P44Ldj5HL2mOSNHUPV97d+icC+fweK6EQKte62VrNXFMRTnqsv7L+kxSjda0tL5QrLhkXFRBIFW74tm8FVgP2IuNB+DOJNBX1U26AsCTmBT/txsaE7MaBwT71x0MyW48rcI+kk46HZpGccWZohJz35fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qLYyZAfJnweZAsoctXJlibuoHexmM+gDPA32McjOP4=;
 b=Gq498UbfaFTt3tzQ1WdFjerYECap3q1B3EDzV01mzVRqCIGo56VDfXVtki4PRZQa47WDTQdXxlsaSEuODDvwAES8InhO4EaDI9MhiAcs1h4SE98TixavJF1z+qa3dEht/nTMfN56RO/2AqohUQrlYRQBu21fsTF1/9xJiOQ17bk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5002.namprd10.prod.outlook.com (2603:10b6:610:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 04:28:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 04:28:07 +0000
Date: Fri, 15 Aug 2025 05:28:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-ID: <97e3a596-ca5c-41ec-b6b2-8b7afafca88f@lucifer.local>
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
 <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
 <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
 <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be3b0a4-a671-4124-c3d1-08dddbb4224e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6EL/q19NZtEhsndVLBTEQxxA7yxpbVU+PI6JZCyjeQx1CokJgcw8t/ExxoQ0?=
 =?us-ascii?Q?p/RzZT1CvMED/2OsRme2uPOJUqtH+2DBH5GBFDLVUiy+jo/05pdtndimPBJx?=
 =?us-ascii?Q?6LRZcrfDkAWoaojeYCyptsgT3chlaetBfNkj6Rc7qTaIVgnT5Av4kaw6KNHf?=
 =?us-ascii?Q?WP+Fbkb1Km7WlD3G61NNmKyPBDPuF66UUxSiMiJfttI3zZsrwHpLHVmaiQgY?=
 =?us-ascii?Q?aWhSzRLB1aHuqed62BhMaWXYjo8Haftb11tW2TCO8QbyodmjEHo6SIFDWizT?=
 =?us-ascii?Q?xqxrV6S4N294gpTI6cnWKs5dyUguPBj+rFgSF+mn4LfmOBklO0HJB0f8Yrdl?=
 =?us-ascii?Q?ly5nPGqbetYMB7V+EMtLRjpP/xR8Fn2ovKiDhNs/SJmqKS9sVyDRrKaj7k3/?=
 =?us-ascii?Q?by0qHGqL51xDERags+dBZxxsYhsT7poxQox3Ms6EZWY+Sl2wsTH5ju5urdBA?=
 =?us-ascii?Q?qKdwpcy45r7cFKHeWbGkOePcywa/ZjDuF3yOnhGObixlv4bCldOe3seS9qHa?=
 =?us-ascii?Q?A0pLK986HdbLqYixDOGHXX3qlqVhWnQQxknSEMOZ+ZBl29Y/lZvhnHZrzPgu?=
 =?us-ascii?Q?phbEbZSMR2Mv73e8mjzO+5sKW9Ll1sGncMPupcgDIGqSGCVIW15cDteS6dp9?=
 =?us-ascii?Q?NvTrBMb8XTxnGkJgKZVJXHuMmNkc8EThMQswQyErh90HJElFgiJK22m7V2El?=
 =?us-ascii?Q?WbOTHL4nsgLdyEPepdEC1Md8WBvBIZzt8zG8sGwvfnItEPgI4L16GiFOrhje?=
 =?us-ascii?Q?IRosrx97bPo3djIpb/OuMmAJUTn2dtnuedGuvKc1bYRJADzNesseyLYLXeT+?=
 =?us-ascii?Q?Chd8V+rc5a1+JMsjCutePihPREIX2qrrsM59B+hU/yhVbpCrhOeoI29Bxtp8?=
 =?us-ascii?Q?4shPDV9esQa0GeXHi/UtKgEE5Wv1bHLxKvFXZ/6Ons+ejBBjkNFUvmidcK4c?=
 =?us-ascii?Q?9lTqsetH3dpEXxxyAYxM/AaTny7ms3lLVi1txUuQv8yUpw6JTwhxPA4YEYbL?=
 =?us-ascii?Q?7uK+S+TWWe9YfOqpU3FwuDEAabhHHmSi/eoZEmSXpEhujQdRfvEop7xX2I0l?=
 =?us-ascii?Q?kX+Re21btpD20Zxl8nxDWWgrUpsZN2DgFZMxFU6ic/xHw+psM1r4i1MhNFyM?=
 =?us-ascii?Q?gZgP6EoDO5aroWzNJ4BdosKxfjNiIjf+XJKBp1KwdoORRJHMDiVTwIfJkesz?=
 =?us-ascii?Q?/ZiiNHvpsNc5CrFHZTX4V3ZUSHXEm9osjtvR2icWur1fs7Or2wOKNtphLFzX?=
 =?us-ascii?Q?oZL8WQCDG591MfHi4HJ4gtq8lqeF7CoVZjB3Pvd0AbFcS2F/9bRip7q1maBa?=
 =?us-ascii?Q?vSLSwvq9TC28a8SbT7HT3trbeaNTCnSU2k6rPUmq5ZIGU2eEKbT8w/o2wvnM?=
 =?us-ascii?Q?RvBtj1Dou5+re31TVsN1jRY1SBiE4lsf5O/aHjWlI1P+gVcoF7xfBC6/tACB?=
 =?us-ascii?Q?8+3+7aa3Z5uyZDS3/Rqoz8gyvzI+a1uWytVbIkzAvyqglYmsOhEulM2tatJd?=
 =?us-ascii?Q?DHHC3F9VH/pixLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3uPb+8YwygGdXOPHzW18+q9AGNxNIi1uYX991ULCH4i2L9IZWxQu+DpwK+K?=
 =?us-ascii?Q?dsb68RqAtW79ZmBi1pKilPL2JW66U9+G+vk2fdP1ggCdVAn6R8ZgqnGkyLqo?=
 =?us-ascii?Q?KtaW/acJBRvaEZaDDvJprhZFS6xCGZfqGcvtgYWlGqniLYBkSWXn9QkshWE5?=
 =?us-ascii?Q?rjHEl817ok71ivNt3iL+vC1nwXwJhN7K3duL/Pw2CMVS/cVLVG6jh/2vK3LV?=
 =?us-ascii?Q?mRHqNS6gVp1E6f4uaHTs9jVG/X0CysJpLEE2Wc0RFl154lAzUuFaJZ67foQC?=
 =?us-ascii?Q?+w2oPFIkgJX0gZ3WMv874dSVMznWGZAr6oB0ddVOkp3xq+cFyc3uEHB8CiRe?=
 =?us-ascii?Q?rt/DNlFF/cFsGAd0a5KSsvg5ualdNyv3nEv5aZPN8uTeJfvz7f8rv4bXzWY9?=
 =?us-ascii?Q?+dM3JTUiLWJtWJUZ5OK9Yj8Rz8q1N+DPRbd286BCtic0wuT0bZf4YOyMP1Cy?=
 =?us-ascii?Q?HZagB40PTGhorqgw75y7SJONt5l1eaDIgD0WsvzpIO1xuy7o2y6MTzTHqMAt?=
 =?us-ascii?Q?tcrQSLNLJRNuYpS7HcZSJ6lLs/45ddRAYxLARsMiZF62xUGDjAm6tZILhJIx?=
 =?us-ascii?Q?MbrY+p5cf2TvwfPwJLRgE3/WYKTTXZbGkaoNhxxCOkYEQOi67Qv2TmYkc8qt?=
 =?us-ascii?Q?xcZNBwM8KodBhaKMdDAYRBfvRqXgmaPKUHW+a4cbuuX9qYJDtuQyFy/jRac+?=
 =?us-ascii?Q?ZA7NPxX7BVuFUciSSjwX9q5HeQtAl05ESOeQEsddZEQAzbt3THtfGDLOJRew?=
 =?us-ascii?Q?XPyQtnCHhK/oJB0TnfhnDVUEQqsbTdnNBNUro5uQ73KpJ0Rb1gvccjz+KzxM?=
 =?us-ascii?Q?oT/g184N/UZeagkneZmnWXTAscb6WYnVtNFPwAf6MR6pBGTq4lwcwx8ivhW0?=
 =?us-ascii?Q?FGlELuYV26fJbhZr6HaNFaYNtY60K++HlykGCEQlTfR60wbtdph95sN1r8OT?=
 =?us-ascii?Q?4j+0hInpOXCgtlty6TmxTsLmnTYKFOWzroWw7neprNmt7+TbcOq/ZM96AvXv?=
 =?us-ascii?Q?wegRDwevgmuxXNVjVkL6dlZLCacyiaU8ltDo2lp1bOxJU+uTfpuZOhIfetxW?=
 =?us-ascii?Q?LJc6yLNHcWSzFESBKoy2pzH0G/chRphY7XAc4TJ9hVMR/yEfR2W9QHOua83d?=
 =?us-ascii?Q?VAzfFn9V0Z547G4kYKG7+RBmxi0BgJgsbjZqJwxsq+QYaAzjfOz0zKwpmruE?=
 =?us-ascii?Q?9EoDMGGt4IaiAKfRFCUFEZzHLStTR4EKrmkwUkLP6lT9pyfN0cQFUjHUgEV5?=
 =?us-ascii?Q?5PVrUPHDU/0zsa0r0T7zkem/svzyGq+ouvH9U46/lRZPJpinFV173XPfWLu/?=
 =?us-ascii?Q?CPmM1Bpk+NSeS6sjuxQ13RKu34+9XMcCKCbv548tyxCUlw72f9Hv16BkUInA?=
 =?us-ascii?Q?LKwhbR3k35U0cyQEUvrYcJLPnvmiwxswfxE0wWCm9E/hLcNh/1m4F5NwVxJs?=
 =?us-ascii?Q?lYyEs3roe/BGkYQ2GoPCOvMJUpxuSCTkoA126vxaIKIPKmNE93DJFCbDx1gh?=
 =?us-ascii?Q?mq6vPMDbEkv2RxjQeBmtsovEGWz0RJQ/wNYhgVNFxI9aK1q6EDcvzYCFuofG?=
 =?us-ascii?Q?hCx9jKgK1/GAEpB7WXKP9pI0v4mEePket1iX0chzhW78l33fQKOfnE1b+UZu?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wQCBOOoyVKMVp8Oww9TA4EjRWnwe3e2rPpYrVvD/30GQHeZwMigxiWdLta8lqFUMAxDX7yzuLIsFbYOSHx5rPAoLTHXBO0AZFIPvFkNco7EwVo4Lcwlh74jpzVDPPsr0yYhdjsc63Bdz3AyorK5dc934bplfETCXu6qaY9lo4wbQA2QEcJ6dw2dbWR6G3ey4g4Y+gS84wPih+UYdrVGAXMzlU6KBoowTek2HJJCHx3ba1kiJ6JlPSE/xvvHP7BlXH3jI6BtcwgRVCy5Mx3qeJSnSDjvNm87b2MQ1vYZtCcOyD/a1ptiXHRK6paBwdT3YGZUq/vXyLyIa5nBW4iQxUelutRZ2ZBIsJ3rNNSmA0RHQKazwQDx6WiLFG3fZ2Pv1ao5Vm4aTjJnJ4joKgjs3m0ESBl2rmZY8up13Ncqi3RwkdNyID/xmoIdxbQq7E35eJVlV7WmSl4HeVLz4P233qKA3+luxVR43bA22ullcggZBn5XcR3oQejaM8yvxO/YHrb2MRlShFmdezIDK+AUZOup78m0WYw0sUDWMQb/b/JXOgwNYyaF3xdZlifC2Ri9DITJHwS9ZQP5YqZEm53oOYYZ3PwsZ1kj+roQRSxVjKJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be3b0a4-a671-4124-c3d1-08dddbb4224e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:28:07.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4R/GRrQH5SrkJlu+imin/MzH0Z88nAv73Z6/q4D1V3fIKnDxcgVEdo/Fcd+FY2njdFsgYL1cbnjfykOCCgtLMSf68HKGBrNJjKz64x4cMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150032
X-Proofpoint-ORIG-GUID: M9BS_noHuZIJPwQRwd03pctE6wC2FeCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDAzMiBTYWx0ZWRfX6r8TPy7aRkkX
 5T1+OsPltR8UVm3j+jCv+nn+qMxz2Qk4rcJ1nCXUax3s4iIAxYR21CcFdTHXmb1q4lisi11F8zA
 vMmSl9UCQjUZzW1MUbpasd/hY3yXi1JtkfH0oEKxIhKStNpGWiiIsOGH6evhI11nipD0W9oYEnm
 XA63xvz0iA6eCZHIrFqOjgC54Q8lG1dgkQDamWpBnvPaicFkNcPK13deTScfMKvF+Vqqn7Qi8Or
 ih/Npy6iQSqpJX4KNo/MP1FZAo4qyF88+rs/6aJtNvtAb6GPaMp3PrrikYb1pKtjKkuHdw98aAL
 AWDoOxJ0jNO0ihzu0atQm7/1RVmQcFI/oPw6ZiHv4BQJ5d4OZuJn37IRFWTxZYHdAGUEedhOI1v
 BIot+/Gl4soWXOa0f7bypQB/gNBJNY7ecaLczNimbw3W4g0bQfwm1jAADOxk1KIdW4ZFQV/C
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689eb75c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
 a=iWkXV5H4AzQr90wf8OEA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: M9BS_noHuZIJPwQRwd03pctE6wC2FeCt

On Thu, Aug 14, 2025 at 10:09:15PM -0400, Liam R. Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [250814 21:02]:
> > Well, can we have this as a standalone thing, rather than as a
> > modification to a patch whose future is uncertain?
> >
> > Then we can just drop "testing/radix-tree/maple: hack around kfree_rcu
> > not existing", yes?
> >
> > Some expansion of "fixes the build for the VMA userland tests" would be
> > helpful.
>
> Ah, this is somewhat messy.
>
> Pedro removed unnecessary rcu calls with the newer slab reality as you
> can directly call kfree instead of specifying the kmem_cache.
>
> But the patch is partially already in Vlastimil's sheaves work and we'd
> like his work to go through his branch, so the future of this particular
> patch is a bit messy.
>
> Maybe we should just drop the related patches that caused the issue from
> the mm-new branch?  That way we don't need a fix at all.
>
> And when Vlastimil is around, we can get him to pick up the set
> including the fix.
>
> Doing things this way will allow Vlastimil the avoid conflicts on
> rebase, and restore the userspace testing in mm-new.
>
> Does that make sense to everyone?

Sounds good to me, I didn't realise that both the original series at [0])
(which introduced the test fail) and the follow up at [1] were intended to
be dropped, I thought only [1] but dropping [0] obviously also fixes it!

And it looks like Andrew's done so and tests now fully working in mm-new
again so I'm happy :)

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/20250718172138.103116-1-pfalcato@suse.de/
[1]:https://lore.kernel.org/all/20250812162124.59417-1-pfalcato@suse.de/

