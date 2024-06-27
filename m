Return-Path: <linux-fsdevel+bounces-22675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C291AFCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759691F22E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438B19A299;
	Thu, 27 Jun 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LBKAuOWy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EP/C0u22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A454D8AC;
	Thu, 27 Jun 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517370; cv=fail; b=YLQu2+UxGpsyE2qykqmUkNuJObJpQBbKhjjn4cfsidzRvdEgIMH8OzVvOJmru+K5VjVmFAZ9SEiPwAQ8aOPIGymy0eNAWkil4N4QUVhIrIonnaEFzruo0ZTL/oAEA7/HULPbaiwTIzheNpXGi5N0Y8M8c9rUGrIXGYQPFS7gnJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517370; c=relaxed/simple;
	bh=vuQrjcXm72OTKp8K4K5o1DWkqR3qMlV1iJ4mKfjzztE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBUA72XS/CwhLNXIN0cRWUc+g+FJd6TMFjN+QVRrkmtlJFBWptxZxFsDHgQGVCEzgPfAJH8wk4z1Nk+7VaBmwYKv0ya8KyqAO0jl3bhFvGAcTkNMy6dOELgXcyH1eVlQDEsaq1wPNY44iOEvwzqYWBuVutDN7R5NftwRPKgrqdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LBKAuOWy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EP/C0u22; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtVtj018022;
	Thu, 27 Jun 2024 19:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sJUgAehO+D/QWzd
	z/uByZLwVpffFm0lz9aUQ0gQhNGg=; b=LBKAuOWyqf+n7JxfOPJvnt57lfajJjg
	OlEtGvwxKLGCLSsFDHsUeEnqDd1sdywsT3qExcmO6SWdKGnTiMDT+n57Qeyfvq5Y
	Ir4qPteM8X/RWGUwQ8KW3ETgASVi5WODlBbm3+Q+RwO/KO5sM2sQo1Sk0ccMFVRY
	x0r/duyNnzlpFmx/VpE2TzOp6QShmQCzijvvlxlLZUXieq4trPsLMxevn2U+T5ou
	6nrRTGJCsQgvpk0rzBSyXCvoDCT/paVxbBC1B6Ck+gpUrO5dKx0lSOygzL8nooKR
	fyqa6NReHNK7uTxHgXw+Lircm2Og87ZBIBMWW3zvDAu0ngT6bO5sblQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70evdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 19:42:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RIQ3WZ017859;
	Thu, 27 Jun 2024 19:42:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2atdrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 19:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7w/Gk65V7WzZ/NTe6/Ex3gLKT15Xp3UTzLVpPPHR6GJZUH+TINuPzlH2DCUynBH5eimur0g9ON+yWls0uJLzu8h3uQdLJM9IlCgSGCcQh2WPa6ogSQFKOrnJcv5BMJK1g3Rf/c78Ofy8VtN3o9jdbwgsJCMXcvkMYc5JfKlLpZU0g4YaCkm5TaOdDWb1hfidg3BYig6YU9i9BjfCT3I7yaSvCDKbZWJlyHqrrbVA85g0bt3SYYmHwVA/skWQMHR7gpaYBKSOzGKsARjoGhMeGG5fZw4Rxwsz7hrjlBH99fL6p9GuuA20Wxu7MyEzQLOCAAIW97Xv1CRR2KTqTvXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJUgAehO+D/QWzdz/uByZLwVpffFm0lz9aUQ0gQhNGg=;
 b=MEFRx4gw4k3OsUY5qFaEACUfKFE2PTIdPTVTnKS1zvWMMq8m4HzyI8Tx+T/mJZA09Ezz1mMf0lm1muUTG+M/KwMMY+7NHMhP6SCLzY1vc4XdOIIAjxcv+gxEiFuPoz8HfHQMVKCdQNW+MfVuNC/DbiUcWc3QV/eW0wklCxONqU/Pbc01u0JIDRK0x1dHrU28tp8h8JJSI77JqXZPDN1XyUjwhliryghxgwT2I5pJrx9Z9eXfppiDdYFkMUiPxGGD1xFfF+K/SQRYJNtoNvgn01uxaKnzCue99qiw5vhbekvW9P0ZBCot64+CRHm87hQfhtUydlD6tkEY94lZVC0eNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJUgAehO+D/QWzdz/uByZLwVpffFm0lz9aUQ0gQhNGg=;
 b=EP/C0u222+SKIpfC+ddOd7nFI6KMZkI9WO4n9fstvR/a8hjfLtJ1Ks0Q6DE3SQinB53mkSW2BB/vT7SZAO52HCVHt2jfjWSVssMKBQQuZl/dEBrb0bXVxubBZDkg9A78suf81laKDxQ6/T/8ztbU+vwCzvo2J7syD85l0K4+aL4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB5127.namprd10.prod.outlook.com (2603:10b6:408:124::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Thu, 27 Jun
 2024 19:42:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 19:42:25 +0000
Date: Thu, 27 Jun 2024 15:42:23 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <qtmnn7ed3tekdysowuniavokstwclxayvnjyhdeglns4lldvzy@bgf7loiqcl3d>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
 <mefk223e65nkizav5yvz2djgyqprrw3uclyctvebdvr2crph34@cktxpmr6bdgq>
 <6bd118dd-de4b-4ccd-bdbe-f8c45e8ea783@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd118dd-de4b-4ccd-bdbe-f8c45e8ea783@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: a09a1fa4-9560-4c4c-e66e-08dc96e1456b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pDdD5SRGnpW9GVxekjur0ewhQPjMa5OKcvUanFSeN14LcneT5qOxlFzK3AdM?=
 =?us-ascii?Q?YxjNFb1qOS6wMPoJZHS9CxH3e/yCU4ktyeGepOGeouuo6A/t5lQvIb5HJ1dM?=
 =?us-ascii?Q?tOqP7Oc7vN8glbdd6L/5eo5UXC99fRl/+A7/YInv0YaqNhVPO888AWToZ3WL?=
 =?us-ascii?Q?9ZlD43SDQHdIRppmgp6/G60iD6BishGoj/TFu+He0xQBt1lXIQ0Gk5dlWnv+?=
 =?us-ascii?Q?QVjWONU9QoTh4AOT+Vrg8wX9n/pI0OZzVAxiqbpPGOmJJM7HfvHp/UusQbM/?=
 =?us-ascii?Q?A3ejeNrhA7Gc8TWKgUPOcvjBovclQXBhaTNf8CBTnpedcj9ozCGVsTKmobGQ?=
 =?us-ascii?Q?tXv4n7N2BEaRea3qy0bDzWx2WztWxyAuy83XHnKdP9s2Dq0THm6AhE3Ru1n1?=
 =?us-ascii?Q?GOwjXUWg9B94g1VPJn0VwFwiGzD2dCFFGJnEsKl9kM9aUnbDTmyGRZUdvQqB?=
 =?us-ascii?Q?4WdJMoLkZB/Wnq30WiJOAHs48vPVqqFLvbjoWXK6ruzDGk2+JW+E0j9hwljH?=
 =?us-ascii?Q?fePCtMbfTxrs2qZEWr/1x0OXo/xiEGlqz4B8WHLGXSO6bIIgR38hJcxfPCqJ?=
 =?us-ascii?Q?VWOczlcEaloPOe6izwAzC8vbjPpEca5PlxeYPMtGZubSewTRjg8ptOA5xWqf?=
 =?us-ascii?Q?wHAtuJscNGWUtiRdEVXnhupTVdBiSYCAHV3nEaPC2bJOAJQRVYLYvY7p4GaP?=
 =?us-ascii?Q?SHt8Eh0Scy/kfxPxNrON6l+hiQdcbP5TqefEQFoDY+lIbFWTm+ldmnzN7eA7?=
 =?us-ascii?Q?pdl5HWdijdOvCv/QWOOy9dYe90zXopbd3CASVxTOQQjIz4f9Swk4I2frrCV+?=
 =?us-ascii?Q?9cikbewL4xGjahSIJK/UP9tlKmmxZPLisJlNbdTHBU0EJtYq3OBNVXI7PPjd?=
 =?us-ascii?Q?fSPQjW5HfNyfCFdluPvXVzgYVPlzFUMJzidwHzG2h6G7JKRDDJjl051Ns54k?=
 =?us-ascii?Q?x9GWA8NMKrbOSc8yks9XAqEz9X9Q0L+7o9g0jYUP9I5++Nb+pSLZQ6KDYuP9?=
 =?us-ascii?Q?dEKIqMLy5EAAiXarSYg9ZLAe4Xh3oB9sGX9isur3C4r/wwWatfVDM5V5GvEG?=
 =?us-ascii?Q?kmahtne0WNsYUzQ8hUGMGFnP+tkELjf/IkCIJ0cYYa8+ESMOkNRPV6Yg+oTz?=
 =?us-ascii?Q?6SOvxSYHCfNybLb/80OnI4vG5oEao8Hs1RXTlORDyev13IUjb9AXlctjdtte?=
 =?us-ascii?Q?59BKQzHcEniUpAbAHBs4v5X1HzsXs3wMCIGMnA3A4XFQtU0Afu97VxCqZZjX?=
 =?us-ascii?Q?qwa1AcmjkWCLN8d152Ft7RjT92iTX3IckbKgUFS+KeiPfidb/IZEmRLT9d5f?=
 =?us-ascii?Q?80b91dgNlFnSpd6FHTPghHaMw4PB59pNiV6EbkoIyhUAwA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZN7GlGOYBRuz/VT5+gmaKueYcbE3J/YXum39ge2oM8VbEUqOAWh9WBCGV/Lg?=
 =?us-ascii?Q?FilNuKJctnBFNALjNNw7SvstBPYD829trFdBowRsAYzion+4fcSGBdkdnJUT?=
 =?us-ascii?Q?Wtb6f0VPODUY3Svcinpon4FuSyzk3k+rwWT/6NnuSMfHYgJgk5fyYIQ6lNIq?=
 =?us-ascii?Q?Ft8NGi1sL3Z57T+3XnyJH2efWAO8pc7BdWM0fVgMbIaIWR9TfPGNOJhnixC1?=
 =?us-ascii?Q?MEueBTYN6/Qx6Gjy08Ib5eyy/wyy8HmUIljl/U8T+Lc6Mly2jbgnkLsXziwO?=
 =?us-ascii?Q?J3PXvgAYZkW7T3uR5OvWfCluszy9yVHZObAQewEU3K4BKyaxkStAhD06enSf?=
 =?us-ascii?Q?Ef6skNuUWsd6KnQEYBK4DEWpzIRqtAoe0RA9Ijoa4gkLcPtI6xmGAb7vZ1EF?=
 =?us-ascii?Q?fbZHkN1pCnsGOiSVRG1YA08k9YZEdrtFfKWit1/59AnVvHpyaPe29mXlZAUl?=
 =?us-ascii?Q?7/OQ4KpE2TB+Gz3xwrzZBy6zM0Bhcakzv5iYbSYbI1GWLXwwejdDzth6SG7b?=
 =?us-ascii?Q?x15agh8gb2W6vBbktCM+PirlhDreHp46KGpF3i2+HQE41/lTPqyKPOU0FofT?=
 =?us-ascii?Q?4rWejaR/ymfISn3iya0fzYPRSk5hvJVkSTKkCCE5AfqLa7tA6rPY2OY4+z1D?=
 =?us-ascii?Q?A7jKS+Kqu4vYVP8HyGYHYvIRaB6JIGzG72TC2auWsVnyqJyVuzW+BVF0CSx/?=
 =?us-ascii?Q?csPwAJQTp05ImCH2948U/EhthMhjCJoQHPdYPZUScs5/gdp3QAFC+JwOP4cD?=
 =?us-ascii?Q?RDCTwm6pbzL9eWi/UwLdOmoMlLYot+jtt7T+drgIcjzA2SjyjdTETzDmgNXD?=
 =?us-ascii?Q?X9Oec3dqP8rG+ix8LJQeRyno/nCbHTQHil7jjIG95QdZlCoWlE+a4xuwXk5T?=
 =?us-ascii?Q?Wm6WIa8P73xOj4ocVE915QfPXRLEz0ZPVbHff7oO8trxBrWUOdSOQ3q3o2Vd?=
 =?us-ascii?Q?VSdMFPTcc0UiKichBOCTXd2+BaU5KFO77aVU0XNob0OLEwD3mTT8OptlzFs4?=
 =?us-ascii?Q?W20FlZq7JOcl8WVn1x7hHBreL+oWsH9qAS5CCO6bSK1Ec5C9g5+4CqGcy5ml?=
 =?us-ascii?Q?dufq5m30ieCwhEn3pZvJuDoB0O4PNCa+w2gQd5EgRYk8RIY3u3NJ/on/S4C2?=
 =?us-ascii?Q?F6ZgiS6CcfLm2u9Gcd6xTI3cn0mk01pg6RFdCU+DgOIAjTsb4Y/9OeL6tVHB?=
 =?us-ascii?Q?oaty25A5Y8J06lwaPJtq1b7CdTiaCysjqw7T8T7KFq4VLe8JH5JPxopRptKW?=
 =?us-ascii?Q?mzltgeWK6xHUZJzDOswpQ+x8Qf1KUZwX7XjjwOt+gS+HsTdCKqSfLePqHkuu?=
 =?us-ascii?Q?seu/EywvGDKn3ZlZ9i89cyBWvDbz4c6i49JrILuN40AtyH0pLQlPDFYQIIle?=
 =?us-ascii?Q?GPqObleSp3t1hKXOxHHhpUsawRI9LS3+aBIxjMA2EsHzOEXkrKZtr1zjzaD7?=
 =?us-ascii?Q?ja87MebQg7M9GeqP/jIiCLR5Xt4/YSD9wiWfs3xMLNvPgHONtvT8dcFyuQ7c?=
 =?us-ascii?Q?N3UIdZVA9OTj/HokmM3WKvym+Kl5fWO80gn054ZdNKcd+x4O1QouTAKJ1HJ+?=
 =?us-ascii?Q?h0+KHdZ4xwisjZgP8+XHAnXxw+1XF10oTCB6XzYrhtJKuoxQIRUw7gQxtXFY?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xxaDx4+x4bm6WwFleWVbawrCgOT5kuX5Gcs+/MzPG2S7NYNAilcMnIOPcp21B8Bg0OW3xyLLOC773S3Z4LE9RsXNSphDROFd7hneJwiB/u/BbU4FcpEZL++3UzUW29Nke8t5XqthRbeXfhTC/q/hshyRdH8XRpSvhQDR+PuPbAszw6F8XPJQaZ+ymjEjVObrZ2e4w8zqmYbE9hFeViSzunckLn7Eu8T0juA8qt2K79RfATsK1YzmbBPPByY4mlhMsDTEKK6PhCNSxVed2wrSYvfCnlPnf5gcIxJ3AGAQckQNWZgk4Sd6nUjRP+lm692kFrO1NNQs6KU1MBtltnPyDmm7T7tQTCGtfcnWjzOUJj1jFkxUtuJiFvaxIR61Io24kk/iZxyn/Z/F6xMgu2ezbV3gKpK3D8KgTz9Tii+bi7TJkKy+Vs5RvMGP+kdyMboNFxaW4k9RAAqFkTb4vyh/+L+qo0o3TG+swTpqclY3BE6fqc1m+mXtQM8Ut5alc+nEDFk2rfV2Rtan6l2X5RnSsQ5TU2OkZhzNd/hOxJ1u5C4lYlQICpavAtM3rMWDb8GItFQ01YEHCAlHdnnuXiR0dbRzOw17fMV2BO0/6nIFUH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09a1fa4-9560-4c4c-e66e-08dc96e1456b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:42:25.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8jYb1DtJSv+vKSm+hcJh91clZ26o5g9YPdfafQeXNRE0y2s/+m6JTHJLlGWNJSbaJOGjZOqcSc6gGLEAfzw2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=932 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270146
X-Proofpoint-ORIG-GUID: aQ5uNwXCc_ofFwYhCxwxoKs27sB9DhOk
X-Proofpoint-GUID: aQ5uNwXCc_ofFwYhCxwxoKs27sB9DhOk

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 15:25]:
> On Thu, Jun 27, 2024 at 01:20:30PM -0400, Liam R. Howlett wrote:
> [snip]
> > > +
> > > +clean:
> > > +	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
> >
> > This needs to clean out vma.c to avoid stale testing.
> >
> > But, none of this is needed.
> >
> > What we can do instead is add the correct header guards to the
> > mm/vma_internal.h file, change the tools/testing/vma/vma_internal.h
> > header guards to be the same (ie: remove TESTING_ from the existing
> > ones), then we can include vma_internal.h into vma_stub.c prior to
> > including "../../../mm/vma.c", and we don't need to copy the file.
> >
> > Essentially use the #ifdef guards to replace the header by ordering the
> > local header for inclusion prior to the c file.
> 
> Ack this is a good idea, will do in v2.
> 
> >
> >
> > > diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
> > > new file mode 100644
> > > index 000000000000..e69de29bb2d1
> > > diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
> > > new file mode 100644
> > > index 000000000000..92dc474c349b
> > > --- /dev/null
> > > +++ b/tools/testing/vma/generated/autoconf.h
> > > @@ -0,0 +1,2 @@
> > > +#include "bit-length.h"
> > > +#define CONFIG_XARRAY_MULTI 1
> > > diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
> > > new file mode 100644
> > > index 000000000000..298b0fb7aab2
> > > --- /dev/null
> > > +++ b/tools/testing/vma/linux/atomic.h
> >
> > This should have header guards as well.
> 
> Yup, the reason I kept it like this is because existing linux/*.h headers
> in shared/linux didn't have header guards and I wanted to keep things in
> line with that... will change.
> 
> >
> > > @@ -0,0 +1,19 @@
> > > +#ifndef atomic_t
> > > +#define atomic_t int32_t
> > > +#endif
> > > +
> > > +#ifndef atomic_inc
> > > +#define atomic_inc(x) uatomic_inc(x)
> > > +#endif
> > > +
> > > +#ifndef atomic_read
> > > +#define atomic_read(x) uatomic_read(x)
> > > +#endif
> > > +
> > > +#ifndef atomic_set
> > > +#define atomic_set(x, y) do {} while (0)
> > > +#endif
> > > +
> > > +#ifndef U8_MAX
> > > +#define U8_MAX UCHAR_MAX
> > > +#endif
> > > diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
> > > new file mode 100644
> > > index 000000000000..71546e15bdd3
> > > --- /dev/null
> > > +++ b/tools/testing/vma/linux/mmzone.h
> > > @@ -0,0 +1,37 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _TOOLS_MMZONE_H
> > > +#define _TOOLS_MMZONE_H
> >
> > It might be best to use the same guards here to avoid mmzone.h from
> > getting pulled in.
> 
> You mean the actual [root]/include/linux/mmzone.h ? Just deploying the same
> header guard trick as mentioned above re: vma_internal.h?
> 

Yes, just use the same header guard trick.

...

Thanks,
Liam

