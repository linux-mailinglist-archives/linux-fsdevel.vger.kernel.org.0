Return-Path: <linux-fsdevel+bounces-23011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD99257BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7018B2408C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CA1422D0;
	Wed,  3 Jul 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cji+/Ui5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JQhtaEMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70A17741;
	Wed,  3 Jul 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001011; cv=fail; b=juZN2LEwQr4wrE2lpyOqXAWW9ZiBObMBL+qmykHtZ32e18htGmtbgQWt9c+bwGlWBb6s1sKfCvfR79yjoZe2PmIQ9unSbskgPKraSfr4UkCdjN+ZuuaaARo25SW3EGj0jPp1FTXmnk7jqVtebYBRA84xNZW/1ZKS4S8cR7+xE1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001011; c=relaxed/simple;
	bh=sz79sk/6iJ0DInJasC0b5S/yXpsghuD2B8lUi0/8fvM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2Qf8FoRn+P/aqrVVYDrZjN4lwUJGhyKKrKhqSFfqZs5eDaVJen4H31RJzIjqtgLGpVp2MthKB+DVNqQK/a+SWzCgQZAKJr8VhbbIEUjNC8S0aj+hCvOIarCdmNCoKrwb1f0z/V3rcmVZqjeEgP3vojUomFGb57zYo95mX8sW/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cji+/Ui5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JQhtaEMI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O7Jg028553;
	Wed, 3 Jul 2024 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iyhRIvZmbaslxi4
	lvphO8BKHPtBB5KBKc+QPISlSk3Q=; b=cji+/Ui5XN/xu+CUs4QPd49OhS0GM7b
	31wMFV5Eqf3Ihhowz9gtTDkEoyfaHpuNApOErLnP3lrDi3pszMF9i7oYmMhA9D0M
	AegpBgNXwamXNeFFvQCdoTtGjJxGs0WgFsCJjoInqtr52OuQtNvIyzi/Yz+Lxia7
	50N7dzCMZ9dgMiCBstptV2zmYK1376PiG/PtRFz3XVsH2YGMeq2BNnH857SHx+j9
	yB8sDYXLzHd5YI58kLK3AlCgJLowDJbQS3aTdQpYTstuqI89hYBzVD7Th3I8uqcf
	NlkpN+CulrmZtq3KctZYd6Skl8Fz7ed2XYMWk/lRzzrPle7/qb9uONQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacfutv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:03:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4638lbRr023603;
	Wed, 3 Jul 2024 10:03:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0yx3sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu6fcoE9AW1cVEHR/v4iRtr6xXLigTf9kSnK+7e6OyhM8cX1HGshl6+WDljcTXCtn3VKDiXc2svm1kP+lah11FVKTu65T4vp6KEb4dVtxnm0NTAUMOglwuP5VqYKHGVJzb86d3bspzqJea46yreAjRYni+6xOfkJ7rvEwZqrndArO3WTv7YnxpO4WT4kyqxJYaik9P/JmGD17zu0ftsu1DMnUdghc3m5fTNsC/YltDpSt1fPIsxWi2IAA6fOlwwlxvaZbCCb1oLkrsunsp2LwFALmsFV6rn+mJ35l3FgWOr3FbOKfpb3tdYX7MZdC6Sa8P9VE1oUtBHX3HweisrzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyhRIvZmbaslxi4lvphO8BKHPtBB5KBKc+QPISlSk3Q=;
 b=kSZo0JpyoETfE022WzSlV2+y+kX4W2Qy+W9CnrI0h4SDcR55qcRxh1cFah8JatrXWAVYiB1i+pHDkO/l5HoluygQ03R48FPtztP6qJ0Ksd+xp1ll3Xtfqn+LFjSrfiKh3CgpTrFtMNuqzZLtbcwnxMYHzPmPei4tMqYO5B9OtaRZhl1YBH40sYl8Rgo1twheJFOCZW+0Cp3AfqSwX0Rpdtraj/zUTgnVLi+UY45dLPOKTA2gSV3IRVTpDVi+BOhMMSYXg6HQtzpo3ZG5I7MCJqK8LwQDUH+Jr0jZ2aqpYGALqJiWTczFoszRxE+CBp5tmabKia9g21kGa5EG6P7PeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyhRIvZmbaslxi4lvphO8BKHPtBB5KBKc+QPISlSk3Q=;
 b=JQhtaEMI2i1SRdF2S/QrLz+4ASraZzxKLagjDGDRc9IxyhSXbAf8zh8yAxvUj5b+MKsjgPB/G9F0dRYxWK1kcuw9H2msWApFGOT2R0WOpU0BaLSUfF2sfdbmSkcZ0tICdxnmByUSJkwLOYDRoU3eKeT1jtNmxZLQRwCAHlpAOWo=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by CY8PR10MB6466.namprd10.prod.outlook.com (2603:10b6:930:62::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 10:03:04 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 10:03:04 +0000
Date: Wed, 3 Jul 2024 11:02:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 3/7] mm: move vma_shrink(), vma_expand() to
 internal header
Message-ID: <f8b544e5-a61f-4b90-8210-979439f56db7@lucifer.local>
References: <cover.1719584707.git.lstoakes@gmail.com>
 <b092522043d0f676151350e65be57b5bb5c8d72c.1719584707.git.lstoakes@gmail.com>
 <lm2brkhp7jfqgfazr5dlz2pxvz7k4fhpfie2gddkcijwmqf3j5@rqoy7efjnpvb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lm2brkhp7jfqgfazr5dlz2pxvz7k4fhpfie2gddkcijwmqf3j5@rqoy7efjnpvb>
X-ClientProxiedBy: LO4P123CA0677.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::20) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|CY8PR10MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 695bd753-9332-4110-7bc7-08dc9b475493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j7jWQPFLVrVFI0of3rPxo0bBGb13BItdsbF7qwnMkFizkHApTNYIdi9prYvX?=
 =?us-ascii?Q?9dKJWUMd6g5J/uv3XWvwwHwcqibZCxHh/Gdogpes45jBc+FtBjSSqKmD0Ejk?=
 =?us-ascii?Q?lt/X6ECiC3QemcQ4ebZHNtjkHqb+xQwqBNEtRD2UeA2aTGtUf9klQLs5Rzy7?=
 =?us-ascii?Q?+veDLoc8qFW6LJb3Gyk/PJtSsnw3IVvsJ6fi6QoCTr55QWmGi+WrbhFgUzpS?=
 =?us-ascii?Q?I34hrABclfer/aWjiUvC2f/37AzYlPBySDTMiSa380ER+TB1zdobszoLjg0O?=
 =?us-ascii?Q?sbwfZTcg37NGRqW56HSruyBQDSwqD8QFr7UGYcz19amUrzHblJY8B7Jq5J63?=
 =?us-ascii?Q?rzTDf4hCY8OJtMxPhjwtxymE1L8rZoF8Q7C2ijdyLG7z5Mn69I6g9DatySxE?=
 =?us-ascii?Q?JaX/eWak977hQa6VzRwJcMkXJcyMK7M0u9gKZUsqbcM/hegtRXHIgYkdLjqI?=
 =?us-ascii?Q?+Yq6jUhd6ZftJv3J7yFjSpMjGJkv5BwFWm7LW1gbUXjalXDssNQ7vQ7V+0gJ?=
 =?us-ascii?Q?x/KIUTXEmbG103nxySziD1jcAV1khywwzlwnQZMHi3dTQ8JwNAx77TQJiLwD?=
 =?us-ascii?Q?QttGqip99z9FYVA/KD8YcRt8l9+Rrvl6gNJpDS5FRa+pJBNmR6N2UmjaTO2m?=
 =?us-ascii?Q?G7NsjfE4hZpo8aZFUyOBJR3iE3uSVbrYpk+Mcr52Q+wKhuY/F9htuffGKmfu?=
 =?us-ascii?Q?mjSg/SoL2Eq3Ippp0xOLSIgZfwWDC2ojYf6jceNqM5efnJJH79Gdn9UhK9Q0?=
 =?us-ascii?Q?T76oomMeXejLCa+yj0pyIgU9LL2wqWdXNYZsDnmzTJ9pCTFGUJxlq0+sG4YX?=
 =?us-ascii?Q?PLVb3hYaqpHh47HCt8451s7MF7rqNdWHlxlcV0yqwoSLUjixQRPtvQJNjxD5?=
 =?us-ascii?Q?5f4pMRyHnQcdE4cb+yIR18zmfA1/kDHr0ar67Qf5HBrP/K3mgeMvYzGZC0jB?=
 =?us-ascii?Q?yfQZPy9qV+uSJcsp57jQRgyJtJHGnV6C6VwNPMGHVGmTS6EwpQ1NQk3eQOFO?=
 =?us-ascii?Q?g8guROQmoAN1jwPCtSrH0zw0+cMX4M7K8kEVI8craYHd4m5Sa3WX/e9wz9gO?=
 =?us-ascii?Q?Hq+rPBhseA1dR3utJtORzMBijYtx35u+rduitD9cg7JGEwNvzEfS7Z0PZR2J?=
 =?us-ascii?Q?40ayPTEklXA8oCMrbTamhjObZ+zSqZ/GtljJ78BOa+4+f8Ad4AjpUX+Nk+5q?=
 =?us-ascii?Q?ejQVW2Bm0Nd1rJhy4B/m3Bf80Lt0o+4y8DROYMGjdmBP5qxbXQgdj7OTIASj?=
 =?us-ascii?Q?CUNO8aXg5LU5fa+YM64GFm2t9wbp7WmZ8uJr/v+uuJiTBQ1IZzoShpvgGUu+?=
 =?us-ascii?Q?MCLGhRcugDuqlr96ReLmFsrCVoCCattVeroavUySrw3wsPAj22zxformfgfk?=
 =?us-ascii?Q?1fq0UnBaxnqJqtiEZskrZz/9PA1p?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2OVjjrAQCaxT6mqdTzzw5EEAyD1jC5zWF1CdgJVvYdiWORZXFVD/fTa1+wTx?=
 =?us-ascii?Q?SXADJ1l4t8Zk7XIJbASMwFAAc1RH1hi9K+DEMjx0Nx/5ZEixDJJh6hkr30+L?=
 =?us-ascii?Q?wJ8k7NnYLKlsEpU688Dzu2+jIh6ZVhAoeydTHt8UnwU1gQVkyGrylqmOdPuu?=
 =?us-ascii?Q?5+Hcaw4WiTHrb1Ezd0nCcx5d2/7EG9PvVVbjXX/DFdmaVJxOT7c3pnuUvvJN?=
 =?us-ascii?Q?1GeQRzSGKc3uvF5/S0QWWHgte4vytw2zNmqZN/plY0jm5E/fYuq620LpWLJy?=
 =?us-ascii?Q?tsacHjG3ovClZSEOdrLfUi6riLg4bRjw9RBHnYiCPzGCWrZknQ33Ua0u2L+u?=
 =?us-ascii?Q?Zy+iYuXR3A+EiCNqSZ/VfB6vXj8/xnjRCcoT56lS3MVTLAbzuV1s0h3vUFl8?=
 =?us-ascii?Q?xzm4NmkstEltwMI8ALV2knsOqst7Ci2mO9e6IDJgLfW0+2V8ox9JpLtYKqjN?=
 =?us-ascii?Q?Kokhu0M9BipdRMQP71MYYzB62vNpbQSsdjOIHZLvUjcuLWWPeRNnooQMEMvm?=
 =?us-ascii?Q?Di3dxUFGcFcMp/nQJpvbEVL7XRRJ7/cUdPZha+vAhsYU9O/5S4wcMrztf/Hd?=
 =?us-ascii?Q?JZy1JpobhqvRDxq1OgzLynWL1PiQl43/mbhp70Gp/YsIftKwNV9MBPZl0IOT?=
 =?us-ascii?Q?67y8oG2ysNnBKWDkMPwJr0xcJe3Ns+Xk8CjvA/4H4wmb0CQd5bqKydWWDP7V?=
 =?us-ascii?Q?NN8I7cNGdFPhlLhZmqczL7TzXqMOkwAeeP+PMVxBdKp3Elbr7SPLz891Svxh?=
 =?us-ascii?Q?v+I5SitGM1pDNBJnTT4nKh4iEkSLfuEHb7YRXU5QJez0B4H5Afwqr0spoepn?=
 =?us-ascii?Q?feoA7hcY/mpYau/tf2uXnYCoVBFyh9nraLlQ9g+51DhJkmpUPPea18Y2vGu7?=
 =?us-ascii?Q?RIFu9MGZCwv+hF797qwpNCVJDYI1YQr5DuStxs05RUCSaWbJrQdIzABXafB2?=
 =?us-ascii?Q?zEclJg/ha8sSDDB33zwx4wPvtOkcUmNDLOqQp55HXkx8R+ZIQ3eLKfDP/zyQ?=
 =?us-ascii?Q?8V8SdKhHLMsgxfd7yGkJcjD5oT9f/SwiT61ZOfKRTAD6Vx7FqeHwBMyKK3VN?=
 =?us-ascii?Q?EGKjpi5+55TCbtkPNBag6v1SwRpU+gHRh2R5rRdFZ/Ogcfe8PYc9ITK2JKZt?=
 =?us-ascii?Q?mYR1gyHBSIXqhL6zJWnxI/FasSQlSMQ/TZYoirGDUX4kR6ilz8uaIw4rCOry?=
 =?us-ascii?Q?sm/Dk3UUc0sSRgRjmIZ8WmiBJniQ+4O2TThaVIkh2mxKkOD0zw7foEa5ds0W?=
 =?us-ascii?Q?I7HvVuirY6xy+rCu/KeftmTUb3iN4nkmRROHIGsZGChwBsktkVABeRdmEvsR?=
 =?us-ascii?Q?Cn0qJFuEZIo2I8rzVi8pROTWAoU9Sgwsl+jCWq4fzt5ka7naXK9RObh3DpMl?=
 =?us-ascii?Q?pEKdxzpAntQnLfQTsGLlAxMryFNYZb5b70NRUcmWC1c8xIzAKkoQWzMSNRMW?=
 =?us-ascii?Q?+0cs4ieQNHtDlMnlXvbRPSGIlGmZW5/Aj9xiyLFmv2Mi3c39hwtatHDN+NmC?=
 =?us-ascii?Q?rq+L0dQn8u8LjpgSTx2mFIyiqTAClxbOLObB39wu7N+HxTMTwzyV2Gequuwh?=
 =?us-ascii?Q?mg0DaORbG1MJ9OWYqIA/fyU4m9cPWbwMfkAKY2WxQe4GgOi1onZmFeH53p8E?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+D0xgRnS9x3xy6DLDj7A+KAcePDsY6JRcSYvhRgpb3jFmRczXolI8bdgQjaJhEFx3D3X8HAHkpMHeLnn08cTWv9WVmJVAi+csnhJhB3bTFJLgOdcvhqIcny5v0NjfGUFpR5cmEZThYBrz2cCtPH1chKmT8Zl3UZc3yR09euOcTIrFF9zYqIS7JlgV9DggqVaD3wlZwEeyS5Lz2mpk1zv2mU2QF/rUy4W+/iuvjfqElJpI7+jvyd3xNr59wM8Qk7QG4yqegUOvZaSAmsmN1CVZl0z9FALhUZd80qQKDlVWIaFSLicN6NesBRqu+BF4wituSU4hf3DJ8a2A3YQOrPiObtqo6vom/J+b7tD8eNX7jZhvDuS86dfNAz22CJ4IoXcXs1gwaQPA2or6TgmHnn/jhbc71QEkL9BOFex9cdOca5EoSdIVdlveGUpQTuUwtFKZvqXG6/1IO9H78+lnJkEm7PxS58raoobJXNL2+cGjc4stbx8VwufTDR1HzTsJeztnyROA0z1G7/b9U7Fjw6cderAWcblk+NIAIQo5oOxW7v9X4jfbYAnOwubbTJ51eEwVXG7wTCDpekdpBy6Z1zVEAjtj8Jx8VsO3VpuefnW5jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695bd753-9332-4110-7bc7-08dc9b475493
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:03:04.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYvMNnuWDSnD2SIqsVMQzPG/CFXnu3ot9RDUBwTi5ltCOGjahAhRxdtC3uOgXNZD6p6FpCT2X+5spABqvmwY3RU/oSUpaswqHj22asmLO6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030073
X-Proofpoint-GUID: v_j6Z-0ScgAQDn0mhfWlwoieqt5D5-_z
X-Proofpoint-ORIG-GUID: v_j6Z-0ScgAQDn0mhfWlwoieqt5D5-_z

On Tue, Jul 02, 2024 at 01:24:36PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240628 10:35]:
> > The vma_shrink() and vma_expand() functions are internal VMA manipulation
> > functions which we ought to abstract for use outside of memory management
> > code.
> >
> > To achieve this, we abstract the operation performed in fs/exec.c by
> > shift_arg_pages() into a new relocate_vma() function implemented in
> > mm/mmap.c, which enables us to also move move_page_tables() and
> > vma_iter_prev_range() to internal.h.
> >
> > The purpose of doing this is to isolate key VMA manipulation functions in
> > order that we can both abstract them and later render them easily testable.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/exec.c          | 68 ++------------------------------------
> >  include/linux/mm.h | 17 +---------
> >  mm/internal.h      | 18 +++++++++++
> >  mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 102 insertions(+), 82 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 40073142288f..5cf53e20d8df 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -683,75 +683,11 @@ static int copy_strings_kernel(int argc, const char *const *argv,
> >  /*
> >   * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
> >   * the binfmt code determines where the new stack should reside, we shift it to
> > - * its final location.  The process proceeds as follows:
> > - *
> > - * 1) Use shift to calculate the new vma endpoints.
> > - * 2) Extend vma to cover both the old and new ranges.  This ensures the
> > - *    arguments passed to subsequent functions are consistent.
> > - * 3) Move vma's page tables to the new range.
> > - * 4) Free up any cleared pgd range.
> > - * 5) Shrink the vma to cover only the new range.
> > + * its final location.
> >   */
> >  static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
> >  {
> > -	struct mm_struct *mm = vma->vm_mm;
> > -	unsigned long old_start = vma->vm_start;
> > -	unsigned long old_end = vma->vm_end;
> > -	unsigned long length = old_end - old_start;
> > -	unsigned long new_start = old_start - shift;
> > -	unsigned long new_end = old_end - shift;
> > -	VMA_ITERATOR(vmi, mm, new_start);
> > -	struct vm_area_struct *next;
> > -	struct mmu_gather tlb;
> > -
> > -	BUG_ON(new_start > new_end);
> > -
> > -	/*
> > -	 * ensure there are no vmas between where we want to go
> > -	 * and where we are
> > -	 */
> > -	if (vma != vma_next(&vmi))
> > -		return -EFAULT;
> > -
> > -	vma_iter_prev_range(&vmi);
> > -	/*
> > -	 * cover the whole range: [new_start, old_end)
> > -	 */
> > -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > -		return -ENOMEM;
> > -
> > -	/*
> > -	 * move the page tables downwards, on failure we rely on
> > -	 * process cleanup to remove whatever mess we made.
> > -	 */
> > -	if (length != move_page_tables(vma, old_start,
> > -				       vma, new_start, length, false, true))
> > -		return -ENOMEM;
> > -
> > -	lru_add_drain();
> > -	tlb_gather_mmu(&tlb, mm);
> > -	next = vma_next(&vmi);
> > -	if (new_end > old_start) {
> > -		/*
> > -		 * when the old and new regions overlap clear from new_end.
> > -		 */
> > -		free_pgd_range(&tlb, new_end, old_end, new_end,
> > -			next ? next->vm_start : USER_PGTABLES_CEILING);
> > -	} else {
> > -		/*
> > -		 * otherwise, clean from old_start; this is done to not touch
> > -		 * the address space in [new_end, old_start) some architectures
> > -		 * have constraints on va-space that make this illegal (IA64) -
> > -		 * for the others its just a little faster.
> > -		 */
> > -		free_pgd_range(&tlb, old_start, old_end, new_end,
> > -			next ? next->vm_start : USER_PGTABLES_CEILING);
> > -	}
> > -	tlb_finish_mmu(&tlb);
> > -
> > -	vma_prev(&vmi);
> > -	/* Shrink the vma to just the new range */
> > -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > +	return relocate_vma(vma, shift);
> >  }
>
> The end result is a function that simply returns the results of your new
> function.  shift_arg_pages() is used once and mentioned in a single
> comment in mm/mremap.c.  I wonder if it's worth just dropping the
> function entirely and just replacing the call to shift_arg_pages() to
> relocate_vma()?

Yeah that's a good idea, will do. Can move the comment over to the
invocation also.

>
> I'm happy either way, the compiler should do the Right Thing(tm) the way
> it is written.
>
> ...
>
> > +
> > +/*
> > + * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> > + * this VMA and its relocated range, which will now reside at [vma->vm_start -
> > + * shift, vma->vm_end - shift).
> > + *
> > + * This function is almost certainly NOT what you want for anything other than
> > + * early executable temporary stack relocation.
> > + */
> > +int relocate_vma(struct vm_area_struct *vma, unsigned long shift)
>
> The name relocate_vma() implies it could be used in any direction, but
> it can only shift downwards.  This is also true for the
> shift_arg_pages() as well and at least the comments state which way
> things are going, and that the vma is also moving.
>
> It might be worth stating the pages are also being relocated in the
> comment.
>
> Again, I'm happy enough to keep it this way but I wanted to point it
> out.

Yeah, amusingly I was thinking about this when I wrote this, but worried
that relocate_vma_down() would be overwrought. However on second thoughts I
think you're right, this isn't ideal. Will change.

Also ack re: comment.

>
> ...
>
> Thanks,
> Liam

