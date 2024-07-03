Return-Path: <linux-fsdevel+bounces-23074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C879269A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 22:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF41C23015
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC518FDC8;
	Wed,  3 Jul 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SZs5ICCY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SkBeUbSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA934964E;
	Wed,  3 Jul 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038827; cv=fail; b=NYPhl+rnRACXbh5kee/24Ssykdnx7xmp0MJjcvyktcgRuAKx1op5Lr17eHEtCym0tEf/ZyC/+KiC3r60ln7pD083yWbzPDn2s+3h3mOMNqxFI1sEaL55mKBkRlwXvPFXrwyfiXuQShMHZdFrhVhcP9c4ac6S2Te37WFOKhMzppE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038827; c=relaxed/simple;
	bh=jiOEubiq6OTLJDS0ruesnb4GABUH+77Tybw5GTK6YFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgTFbTLbDRD7t+ayPyXTkcq26Xq4iQ/5Eu5jlSepTJIEBVTcgatV2b5+iW1YUFGipyBUCOOvrGuSXvmAJNm4w4MXcIHnRNV4gymam7KMmb7xW005g9448/sPTrIdtavFL71VyFdAbfWRSShXF0TP/NZVLbdqn0qE6AEIRdhAIpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SZs5ICCY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SkBeUbSD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463JfbM7013498;
	Wed, 3 Jul 2024 20:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JjvpUaAsAGgIc9T
	zpc5LA1+SUPqHfcWGed2vM2y4bxw=; b=SZs5ICCYzc5A389ZxvjtGUg0R44NMJa
	GtiPDqp2u0DT/lwBtaB4a6w8f09T4xhzkt0OBo3rB3hSj2002Z2CCYI6g2IuF70e
	Y+HCJcRZvd3b0XpjaDbxfjVCec6A9B61QrncUgtB4VBOcTQPXlxUgBfmraty53rc
	XD3uaTjCxPYhEzPyqy/gniHedUVCcdlTl/BuSw81pv6AEOVybvZWbi+iE6hrSW3w
	+XczdZj7ThKlnudTKpTTv9b+l4SM+pAB1A6d5f+5UOKj4DQD6iAKfcSyR0NNo1uw
	XFcu2FzJB8tfvIhvKbmbrgxfonQvqY+4pSEkeu94BWWYaGIn/cv0yNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgjjsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 20:33:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463JwNAe024631;
	Wed, 3 Jul 2024 20:33:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qa15v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 20:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3v1qfILRtTERCeMCAXnyLh6ELjfw3ubFbiCYZSH9sZ4x8Sc+sj3Qzn+PxmFWN/zSI+TM9Vc618CHBoWOWeQoTbXwmzfY3GcMU9leqz5J/mhqsU10XhqusHjtC+Gw8LmNfAGJ+zG9F/0jyQGh3JVKeQ/UAAe1BVrTnpESLj7zSSP2LcPJr1xvZ7GNCQmjQmZypjLq6VvNxf4AyBVBYAVqYPm9MDc2oe/aLRkM2e5JcFk8JnDh2lFJHK8TDZ7xwbbeUT1R/vmNJ+9xg9yV9gFsi2FlX2hOtBUSnRGVNccHLrSUOfhzPOQIR4Frj1wDlkzYhFyMaAVUGXnFwv6yERUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjvpUaAsAGgIc9Tzpc5LA1+SUPqHfcWGed2vM2y4bxw=;
 b=McKNUrpHSQnpVsFjGZUSdBMW/e4tKLAQg1UoT1hunnSa2W6LVTX26D1cW376Btl/fc7WJOrOHToAreluZCTMvnUE5SSSwY9eOf/y5D6vvNinFoBlTV8yRJOQPJs0Brapl/60cx/F0+ehoSXOKvY7TfPxMmUwBaJ9UgPF5/+e6tYAIFPh00QcqSLnplw72uTvQC+o8LbUYOVZinvgnRm5yxFgXkdft/kUpV0M26fRZlft+BWk9Vg8y8KcLeZBI7Hf7F50yu182lRxH4u7K8rvhdDw3SN7YLAH80H58z0NLvZSyvKWtPLuId3ZT3fwp9eNjF/NjP28NZi7SYutKHXAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjvpUaAsAGgIc9Tzpc5LA1+SUPqHfcWGed2vM2y4bxw=;
 b=SkBeUbSDbwbr2tZpyk39NRfuINOSIQmRjpxd5DtsT0dVkkbKvktoF5WehEGP7tEAif0A1/Jt4WpnWFZr74SslOuXhVCeswBnXxeNETukX9zxOcXJU6mwbeZWaCXgeDmOZXVhsNesRdL6bJxW+ye+mqfUHftgcZco+lNq9YxGApI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6593.namprd10.prod.outlook.com (2603:10b6:806:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 3 Jul
 2024 20:33:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 20:33:11 +0000
Date: Wed, 3 Jul 2024 21:33:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-ID: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
 <20240703132653.3cb26750f5ff160d6b698cae@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703132653.3cb26750f5ff160d6b698cae@linux-foundation.org>
X-ClientProxiedBy: LO2P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e41c80-7374-4ebf-5a5e-08dc9b9f5b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vRM+MCZ7rnDheySkyiB/lNmDuxP6XbmAeurwoDYeO2C2f9c5jY7xBf6ts5FO?=
 =?us-ascii?Q?8Y+G+4laCll8hGvQ+ZDrcjNCqbpSMCYwnbUoL7697dxTXJIBRjZds2EKElyJ?=
 =?us-ascii?Q?PpAKb+5+uIZ1X57S0CqERjtZ6BCH5kiTN20z2F2ZTRZLEwfgw9bdhMB1iuVM?=
 =?us-ascii?Q?TRccbWXCHD7mNv3IPdr9IdWNFhRzxgJ2Ibl+PzIj5BiQ3Dz+ijUzNZS12BSM?=
 =?us-ascii?Q?3OHZoKMDlRs/pMEQWHhhrvM0YYf/kdO8uOjl6lcrqJ+PXiZhE16t7AHrVQn6?=
 =?us-ascii?Q?jMTxCyJ+nkF+D+qYZuegZfkjT6xzZKcN1xMXJHNJt7RM+FgUh/ebQIRgHnGU?=
 =?us-ascii?Q?0SH9P8UHd6VWIktZJ1fXu8/pPkqi5ndwNCI/MJ0ZB7wP5JmGe3dVUaF2S4jp?=
 =?us-ascii?Q?fMoAcyDFNcWvY/7/tBGVvXU91uNbUWnjeTvpI8agqyQz9lt7DULJOiA+c0U+?=
 =?us-ascii?Q?Q6jsQmzWtGh7jiJ+dcudZxUx/GPp4sWU8oYrmtftqD8DKR82DC9MSXOJCPfO?=
 =?us-ascii?Q?/njLPd0uoUXqLdGjyzWrfWVBYBmqs7UArTxavEAt5df+cJYk9edD/27Z0MBS?=
 =?us-ascii?Q?WK3B407Ox7VftiQJvD1U5n6vB2iyhZRBLOacl8a5YE/GyhW73d6fmiDLSEFs?=
 =?us-ascii?Q?vUyOfotxIIHkIuGxWI1TQinmlheDgjztcy0+9xWYAjwn9R3pgzxqZqQGHtrp?=
 =?us-ascii?Q?JSkWVMpXvNoMSdEg4422CNRT6NJyCi6QuEYzxRlC49QiQF040vZVc+V/ROT5?=
 =?us-ascii?Q?76f0FqIUr8XGcz4X8ihvbwkjjQEuZy2Ck+qTSzkwsM2g1du9AmLWLcfwTxWX?=
 =?us-ascii?Q?lwdozMjez9QKFvyGrOpL3sNcnHHXP7fEXBXnEH8zKqpEO0RACbA4veMZgbbq?=
 =?us-ascii?Q?sZY0EISuT8J1sBpFKYFLvK8oQ8Q4njdMKKPSfQtIHUGiDYqv8Vr3C8rPEvdz?=
 =?us-ascii?Q?1YzdmltJEMeuCh6tLVelDkigSmhzf+qpOEs1rwYxEvvdfqjlLck69uwGKfWx?=
 =?us-ascii?Q?sI16JxmB2BPT6Cwwzqat1mQR0Ju4mILoTo1J47vVnNzI6ifMXsRvyMBs1Ll1?=
 =?us-ascii?Q?JeAkdAG5qJsXz7AZhLEU6rxxVvzB5roZiBzPcYLT0JaJUp0Y4ZeBU7MUKiNN?=
 =?us-ascii?Q?1I8wYA0kMG5do9ONnAxi+Jkax/lnxOVMDC+LWzLKnh0Q6f6CEkzt5zZVlzwF?=
 =?us-ascii?Q?N3xEz7RyAq6zXg+utazwl3KOPnH2QTtb47na8DNWCLJoC2uVLLbWu/7ajFp4?=
 =?us-ascii?Q?ckUe2z2IRq687I04M15OLslRG8ZC/ts+uPMz52TmCqwQ0Js0NwpgasxhHtUg?=
 =?us-ascii?Q?OKKaee71Mv6Y82Rm/pHlABlb9WZ5/8SOio6f64hRV8ufyw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tDgceIQCeWjpKl0xaAtAA3PdNXEmNfjRfoVwic3hlGo2/2W91Aa0vxMpbgHH?=
 =?us-ascii?Q?r8HJYnPEi5kMAOi6bfUzQnKtSlKpAK3sCvSKPIckfacY2vwFqGK8rRspB+mI?=
 =?us-ascii?Q?EOiDaWuGHAX95lIb0TpSIh+e6AFxlM39T7xWqZWBt7KNtb1FSjdJCx/aoYcc?=
 =?us-ascii?Q?AtJ5gaW/tV3Jw6FqR4Sbh2VPoGNG2/QXDOcIugycx3b7NS2NAOw5wchCvEsd?=
 =?us-ascii?Q?iUn75DeyAJkfqNK2K33c3eYQPeFjWneXILeIV9L4Ugsb1mTb5qud3mQxLCkg?=
 =?us-ascii?Q?akDTMijIwIPAqeox1G3x3SVvnw2o6hmKvrTqDxwEpsls6vpHw/jHQ2JatC2t?=
 =?us-ascii?Q?bUmSr8JXVLAiloTqNWgg91xhiLEyaaniOrTybMuTfsAsfzC9vRSNOzMOFOso?=
 =?us-ascii?Q?zywCrbRwol6jYLgynTLGEkCUxzGRKvAmtXR3Q/v0rOLwFLhdfp1pp+HFaYJv?=
 =?us-ascii?Q?3Z1c7HVmaikWS/StRQNCeRnUL5bIKoLUtF6PFLLKfb6KX0cwC3a2SeKwLMe9?=
 =?us-ascii?Q?yt/gCTWQqbEulB9Rn0UpE3AmnTeZX1xDaXsTY4TiovUbIrqT2vrJGQnz2FzW?=
 =?us-ascii?Q?B1Rcjp+S505MqHjwv0E44OayEg1+u5Aza9MJm3nEW22p47dr3avlt/6s4kFN?=
 =?us-ascii?Q?mXXprpur0WqmCNyme9N93oqZPnrJLzX3X1KQeRiO4OjA13y2o4C7qBbAUBWN?=
 =?us-ascii?Q?80bFzdqZJcwwDPPC2HUwRf3IVvtizjICxQ6SM6lwMBZMD6N+kAi8QR+jLQji?=
 =?us-ascii?Q?rbDv5k6W5cfm9cs/HcC1A4klIBvZAJnwM5+bdBN0hwivKD4Rcxpjk4o7Aypt?=
 =?us-ascii?Q?BY0t1R9eMnsgyBSZrCXcx6ryw3+uo/AE+iZmnjt+V6Sjnt4i1U0dTSotBC16?=
 =?us-ascii?Q?LW99B7OXNXXoCcxdw+FPZGPza1x7upZrk7E2OxBOqt8ZyTHCy554WnlyrD9y?=
 =?us-ascii?Q?aVOCVYuTRfxDNvw/GlXNv/MLFSCWZOG2SZhJGyQKXdG6ov0Y+MuZkkyOCXpM?=
 =?us-ascii?Q?JmuNRidyoF6iuv/nWJCffOlpEZ6VfBDzEbhSgLbrokY2Gyhal8ngfu5ZGEe9?=
 =?us-ascii?Q?Z0y0Wy6zXEbJauowDT6+buvjKBT6TxyyPub342xHdWx9W6lyJf0dyMJ3ANlg?=
 =?us-ascii?Q?vyFENKBeg8ScBNhvesDIuAPS/g6Nl2cTCNH+ypKoZAuHRWX5TGzq7i1mMgmL?=
 =?us-ascii?Q?iBKnFJizuBQO2oGx+O+nHnqKGktORAF2XcdDXCIQI4N8r3pqf0a3xCY9GCgd?=
 =?us-ascii?Q?Kqq7bX0SyL55zDtkkPwutFxVRvvqU2Mv1FVk5D16gkZphjp8sJJMRdCsBt/w?=
 =?us-ascii?Q?pg2R87hOzx1IXYhRFBiio1fuWkKPyl2eGkihj/4//OxF9/4KaBvIclWAhcF0?=
 =?us-ascii?Q?xOjh1CiKFT+tmgGeIoZKAP5wuVxt9Jf4+rJ1sMUsuix4yHAHHmoit5V5XEFT?=
 =?us-ascii?Q?ISC7OEBw+P73oEMqAPn4PltKF35OmJ4GEfM9voRv9T7u9XD53u4QB5ans/Nk?=
 =?us-ascii?Q?cEVgm4+oc/GCzhuoE0As+b6Ghdg/38QPc219GcMGw4uuLQ89ty6oRmKt1CDi?=
 =?us-ascii?Q?6FV+/cKP0QFOr63toQA85tXTW0J06e0NEfSYANIJ07skAi+STAy9+FBP76+A?=
 =?us-ascii?Q?sKytJms0QiN+nW+hv8WczJDH01gAB0A5HDGXj6Lu0PUNVbGwVDKUut9qVvzh?=
 =?us-ascii?Q?zdpORA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w87cUgIQO4br5q8HgwKyinSYx9MLgFddRqmtmkLH9fcxsj3IWYNl6bduutPBX0XAD4G5vFYvvG8tx6wxBrWrKRstwP9uxv2Oqg3Ov8Qp0PTPZeJujx3z+Njwz+WdtmFRJjyPgkUsmEDfPDLm7PbnSoiAkduRX5vSJS6hMctoGvx3bDQgkVg89I4RiDtlCtkCofD7pmZ42izgdyzV6tJJewpYtmHheJ0pQPvGdOq7Qjrpc3Fmlpv+0NUjhIlZZ/qIKDi5+FZ4TssYuTIKJXuaXorNBvAFREYTR5TJPjT+9tOH6lIMPOmg+GiJwV1PstRzq6KsMHW52+Ydzst0vfLqm7fiVAHKbcbNhQGCdhoGRtEx8YjBUevo69Pyl+or3XTKF+ABDK7Z0AzkHx6F8iuj65TyUiMox54/oKl9/qJzGOH8g2zkua+bpWk2epqzMioz9c3/YOeA3z2coMdQTqyAbiRumrXS0jfR0E1kXfZoipdr9YsIDgkKIBUxGYtdIRnP36wMeH7AJMY9ETyBSoYluPDlbMsMao/urIdh/U3ml1qw9Si0oDJa7uW07pZQk69y7UR/yjzPlhXmcdDuTCMAgOoHa1o3c3GdsF+JRpjJ09U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e41c80-7374-4ebf-5a5e-08dc9b9f5b29
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:33:11.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGKMsEm0BskshOPJW+1X37AuAfs6yHyz4rtRauO8wANk1CsD7FXYeOLxG3cCCRPyN1XUlTXYbEM+X4ipOGpXr3dRcKL+J7ZVrYKH4cyVeJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030152
X-Proofpoint-GUID: pbs0PbEwQZX8b0nzOXSm9Fe7tPN15yw3
X-Proofpoint-ORIG-GUID: pbs0PbEwQZX8b0nzOXSm9Fe7tPN15yw3

On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> > which contains a fully functional userland vma_internal.h file and which
> > imports mm/vma.c and mm/vma.h to be directly tested from userland.
>
> Cool stuff.

Thanks :)

>
> Now we need to make sure that anyone who messes with vma code has run
> the tests.  And has added more testcases, if appropriate.
>
> Does it make sense to execute this test under selftests/ in some
> fashion?  Quite a few people appear to be running the selftest code
> regularly and it would be good to make them run this as well.

I think it will be useful to do that, yes, but as the tests are currently a
skeleton to both provide the stubbing out and to provide essentially an
example of how you might test (though enough that it'd now be easy to add a
_ton_ of tests), it's not quite ready to be run just yet.

>
> >  51 files changed, 3914 insertions(+), 2453 deletions(-)
>
> eep.  The best time for me to merge this is late in the -rc cycle so
> the large skew between mainline and mm.git doesn't spend months
> hampering ongoing development.  But that merge time is right now.

Argh. Well, the numbers are scary, but it's _mostly_ moving code around
with some pretty straightforward refactorings and adding a bunch of
userland code that won't impact kernels at all.

So I'd argue this is less crazy in size than it might seem...

