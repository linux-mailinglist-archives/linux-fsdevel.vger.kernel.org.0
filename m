Return-Path: <linux-fsdevel+bounces-54976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50C6B06140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E97B5A0AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F7B29E0F7;
	Tue, 15 Jul 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C42kjBAn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OIHK1vsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F020296C;
	Tue, 15 Jul 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588783; cv=fail; b=Ll0dZoM5fysh/R16TGOxyabgzkOMmiUrcY6NWOf62czwEu/G8UHVneoq+SaKtlTheasitHBn5v94hY8eGxiWSvkfJCnoTeeP8meMd0ee7nQN5u83K8B/v6L0Y4zxQz/Su3h362XZBhxuoa39rsGMadKfe2EwBpR6+BRr2kDPH7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588783; c=relaxed/simple;
	bh=qQqoztFhUDSaEWNVVLyREaB0+0dhCObh3XgJWkkaw48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3hULkg+1JSfbnRmJbZk4RLKMDWiBoB1O6o9lfZTx63T0XL6w3csMZ0xlGjpSfhxD9ROQwR3FGqqeFTez3gIHwLkYeKq6cB5BO5pItOoI+L7/occY+rC23OysCCI12NZwLcqln59Ut7lOXvvqvEWt66c7+MlJivT+aHeUV70D8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C42kjBAn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OIHK1vsU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZCuO019089;
	Tue, 15 Jul 2025 14:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7DQRZ07eNCRk6ORg3O
	bz0tfK4lafdMSJACqhJe2plic=; b=C42kjBAncpoFyBXk86wgNOPkScXCTCpsgV
	B+2E9vwho7AmXFR3/y2YXKXmERyP7GGolbTfl7iw/gAuhivEGH53zL8aL5lJkJbI
	qOdvC2PyR4Aoy9qTSCN7MKQhzV4ZwpuF57XMIbZVa/Euc2g1ALGs0j+9LjfgMJxA
	Dhxi6J4ntTxINIWdB88TTB9Pptl13A2TFQ1QNSdXVIZlUBXEAxnpBy/ZuDZtQTKC
	982DAs86zjQD0m/KNk50i6Yslxcl8sh2kRf1VCtoAVrnm0tdWzDaZ7583RZx+x7r
	7Zk/4/6OCxtp4qtZ7md3+UHwRamcAQrzFeMWHFukpM0WhXVyNdNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf76b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:12:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDK87W039623;
	Tue, 15 Jul 2025 14:12:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a1rqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtpp0snZh6DGbTnTUyXVnbcTE8B16qnV3u37OeChL45tmE6SYRCqI1xz1Wxf/eJIgnxwjpiuqvG+YnNKUgXWHVNBnf/ST03pMFpDfF8FrVGt1ydR4zfTBJzKDFZFmAoi74BtShUyUVC5nOM2Uuudhkjnbuqa9U1u8oOsS6PIYT7NVQFYBtouF8rLlRDs0vwA3AU7dUfB9pQarKe9SetUfhjsVtIY+z1g0Ki8u4Dvm8MC8quDN3rlH8UTTDcDGWV3jlVoZV+MUozKMrJ7ITq/TFCoCqpoB6t5yPd/36ne5VA35kh9IOcSLJm9tY8mgu7eUwTSunwY6h5QdXuzEQ9cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DQRZ07eNCRk6ORg3Obz0tfK4lafdMSJACqhJe2plic=;
 b=j4ns5hANY5rmzoq9rL7XoJFDEaIrHfJzueyNQKmpYNYnhXMngKnKUn4/xQMFROLDboc3HzWd1ZEBbMlttUGpMrpkWEx23GxY52+jSpKxX0wjYS6KiRo3z/nSjjEy99YsCR5j5/eZEc9dx9luNBbUwlXFh3gFiK6WIk4QsS8pU7bQF0c2O4IsLyxpFXu5lPNGkZ07m/4+zeQMl4ueWkV/SEisRmZ7pyG8TYDn8kzxO/3Yw8Q96A/UMnmcusk2nzlx5RocRMquE7G1ChWjF6ZV2xWyDUzrWkiJXPWLNwFKpGe99AWUVERkO6E4Ot6LHPCRDZMBj3T4ZKlvCpFI64nMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DQRZ07eNCRk6ORg3Obz0tfK4lafdMSJACqhJe2plic=;
 b=OIHK1vsUHemBlg3HVyFvydUR8uPQhJwYNzO65lHJVbegQoqJNwxMLfVNBQo4YQt79tQT0HMgIsjSbbrWlcxbrf5mdCOa8bVquVd4LJ/Gg1FI17mGUArzhlthFlEUi48QT4lnhzCG8OffU6lk1It9X3zjlk0MlK0U6B0I/q0A4Rc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7296.namprd10.prod.outlook.com (2603:10b6:8:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 14:12:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:12:04 +0000
Date: Tue, 15 Jul 2025 15:12:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>, Zi Yan <ziy@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-ID: <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
 <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 799279c0-aa17-437a-e259-08ddc3a99360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I/L/O7iPWOLQObMbzYoNmZu7DDMap6bUFCaZLe9m6NF9XOYcY8XZDioizrR?=
 =?us-ascii?Q?OwcSqjt0YKY5um4ElIPhiIurRCOZ6Iy+HUXWeavvHR29BvgdWGzgP5rL59oG?=
 =?us-ascii?Q?yDNV1eHSKmmWw01QgdUvmbiRZL/5RBXZAOGGRI6fSeviyHMb4E9zy25on/NT?=
 =?us-ascii?Q?gRUmxuQ1ZtlA207nOUW4HK7TDWa0XdkoqJ8u+aGFWpFa9MHQdcpZA9VRaqmf?=
 =?us-ascii?Q?qpuXDUpnDlZcQsSFyquncdmlf0f+qb3CBaBdZcpGqS6tQuaVNeg4yFU7sXXo?=
 =?us-ascii?Q?U463OhGoyirJWPzBzRVgnYv7WmMdJOEaz8MEUcj7h5rjFDr4zDM6z/idaY/4?=
 =?us-ascii?Q?1flmQ1EHh3LkU/lc2wP95/tW2mQS90aYcEPPHeL5lAiobCdu0RQUHoHtHcqp?=
 =?us-ascii?Q?Brpxt23XYKG+A5yCZUPDsPY5oCrocOK8LsTubI2JqoQOpMbsxDvkDZZsaVJ6?=
 =?us-ascii?Q?XK5u7mIwhbTjhmdXQCF9nZNJWTidbsV1CYKl7ICiyu6btmcWhRBPbpm/k6mP?=
 =?us-ascii?Q?RPV92ijG1DIg3yF+mKVLy0ydQT5pjMyLk010C8T6Szrp4TSDCBsfZx//LjPD?=
 =?us-ascii?Q?9Iu3zG5CCXftlnpzvQtsZeHYo0qgd26+QZj+4xfGOniY2SHK1CsY2AUnJpqY?=
 =?us-ascii?Q?uU+AcoMYlncS2R5ziabr3o7FrxuRnNajaWsJMMAAZOo1symlZJw6dxtrCJ5k?=
 =?us-ascii?Q?DFVJkZ8U6Yy+W8C6+yhZklj84JIfby3KDgyBI/e4A4Z56wt/Q5JQthlG6b7Y?=
 =?us-ascii?Q?xf7lsZYk+OgPmD0tdfCdRPb/wnl3Km1sc27ct3jq0wKqrgonW2CyfJq7ID+A?=
 =?us-ascii?Q?w7R2L/XGUcBBUaRRD3ZPHhqA2wxJPi/0s+jNYdq+CPb8+/3tX2piX8qxl3Uf?=
 =?us-ascii?Q?QKF4svSmlUvP8igxRcoDhZ6/vNv5qIGJO4NbNcHQYrcbzB4NnbR27WpKIgJQ?=
 =?us-ascii?Q?zzNEY7Jt6nnG8cDBZzZ8BrSYvGy2rZv2ippvdGYlIOknjhLVTDeXLn/fanXu?=
 =?us-ascii?Q?u4jyQLaZfD+2CbABXm5QQJdWk7Zir0h7vZKT2Qzlvrpa0OcAjL/RNj6usH6V?=
 =?us-ascii?Q?ftFv6Hlo5trd8WxGRDKKWxxzCjQamyscgH0UPC76r2yobF5jsw4ydItUtvhG?=
 =?us-ascii?Q?ucstkhq9T16OrLumP45f5RoKwttDOelq+Rg98zVIIpgUR13uDmYBjfYb1Oqo?=
 =?us-ascii?Q?YZDlQrlrHPHfdC2KOBSPE2/YrFAAQ01q9REtJtuFaU6cfrB7c4+33LpJ6L/w?=
 =?us-ascii?Q?j3LG98Nj4q1m/TyO3oAOn+n3xK4H1w864AaNDd6r/W7Wq4l/7tV0v3jg/wX6?=
 =?us-ascii?Q?bg3sPV7SgbjtJ4L1luT22bk3eIj5tAIIpAtEu17zCCxGb040U09fgdTjr9rU?=
 =?us-ascii?Q?4EkHpaCu7I/RV+xKBj3p33WJU1I4NxNFVRZ5+q592IuNQ7TBv236fSz9dmrI?=
 =?us-ascii?Q?eoEiilfHNb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HUbv83WWNZwXend244WyWOFL0oj7yemk1ShNDBe5Yq8N1ocqvXIDDexyx6kF?=
 =?us-ascii?Q?VSKxLg5wq1EOC3mruxPpVfF3/ekO47gY8zFsWoC2OAj/yiFxPQPKiguOKrkr?=
 =?us-ascii?Q?5MNSyiK6kBhRCuI8GscI+oOtRpOGIe9jvQDCSbZEaBl93xBBgk3KNWQKhsUA?=
 =?us-ascii?Q?LBf3rj0gPI7xJvkJVHOHwtqsXReSo8OBlydTH6SRwGNUQjHOVvPniYvQZtPa?=
 =?us-ascii?Q?kWFb3vOxpMFsQLRyjutzaA3TgtpdpMGtaXhdJt0ZKp7ILZ6Wx0lbnWPSySrJ?=
 =?us-ascii?Q?FCNcHvllQxSJqXLGCF4m5B0HGXrH57uPqkqhNaxY+/hKQXfzJdxWve5NVi2M?=
 =?us-ascii?Q?0ejRMt3wfK3hnSqdszGuiOqVoRy1SiGLc1cD+59eiN79FYFki4qTHRSNqS/m?=
 =?us-ascii?Q?7K2v56o75hmZjFXyGGYz6i5/u8/iml9giraUaqeAEJi66gVk299uZgfbqmGk?=
 =?us-ascii?Q?Npnhl7Ht65CmY+LCa0EeTrGzBGD2kVM+kD8RsHm5ErymzZvILF6hgEcmGFLM?=
 =?us-ascii?Q?bFYAL9x14bzsYvZAPkktGFZxhFo6L2PNXGBZVNWhSO63hKaYS0BCMMjWeDFt?=
 =?us-ascii?Q?N7Wt7FRqh9AznafpP6HW3cC+yo3ZPa4kRG0lLDj8eaLkmpudS2jQe8ggrboS?=
 =?us-ascii?Q?qsbhRLdL5I8Xc4CRreAjLH33h+MmQs5e1Xx9Q4wTBBHNUN4gHh7PgmDBQLsN?=
 =?us-ascii?Q?qoRoGeCmIuBX11uvzAVNmx47CJgbAvgRBBfk814EtCNGph5PlHr/C2Rx/0lU?=
 =?us-ascii?Q?EsuIEU0EhJNoTuFssIytSRmQOaWzmdMuxG0t3dyZHISo60O1vBCcDhDoPXPj?=
 =?us-ascii?Q?6BoGIcnSmwiRXQ1yDbEmp4EZbJ0N8B5tmDYTXrvHIfPO/fJICHpeEiaQL5V9?=
 =?us-ascii?Q?6Dk96HddbW7P954XGuGE0s/UoAG9onIXZXhpqbMT+7LTeJEQ+014mFM7Hi6V?=
 =?us-ascii?Q?prF0m1TIhw3p9XKOpScrO3JnMGZ89RepEq2YQiUOIS9mZfv93YDFYaV30mde?=
 =?us-ascii?Q?foZ/R25UqVh8rn1dg8+ZDJYO1ZDrguyjIoaIOgIwCyBY4zPWCOxmbC/zjEEW?=
 =?us-ascii?Q?5WbrXwbNVQR74ERAWlkdtU3ycn3/3TkcTu+M8p+vB75QL6LRJ1mJj7W/yFGV?=
 =?us-ascii?Q?iMlYZ/23Z2hhsLSrdPcb9z3nfJYqRvadKiqlEmktAJolkZELkV9Kl+lavvoO?=
 =?us-ascii?Q?sbq0DYXs9WfWp/TOKHGp9fwuAAeYEc5IFMGyzqlu3DgM5DgIN2jEUCqlTwdk?=
 =?us-ascii?Q?j7kCbBaTNY/JSzS1utZJFUPvFJIsV6i2Gi8RqMLljETK2uVnHXYGkgw52n2n?=
 =?us-ascii?Q?uTcv6uiBOfkgPE9lKOY/UxRmEP2Q7tNkXtdTYqTf35oLlzlcl2MYC98qHkEf?=
 =?us-ascii?Q?2QYxOk1MZAe5VMrcPObjAKSnppcThafrAqRRNLH1zPPYpuNl+HXjCHul8tP0?=
 =?us-ascii?Q?6dWXklrXZkcmijo6+Aut2O7IWvk79r4nEvOjFUZvbcb/ZSozO+rpRSx0JLEa?=
 =?us-ascii?Q?EAisNDcFlCbM3IaLXETVBCaPJ0Xs2arTLPgezDFOInaenWRH1MJLtT2zeoCL?=
 =?us-ascii?Q?0lz4qg99JCRnKN7qv37QxYMoY1JXVwq60Lbpv+2L1YnsQl30jGWWSu+kO85M?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EzKVNi0q67TKinKqDXwIbr87IYQKzq6Q8+N6MjasPSvpFC5lVe+ZUMe/8DaPeOfk+eGcPXLSxIaO6eo7lQksuJ2Ayj2T+VDcTR+qfrL22mG4tGE2tMajuAEGjcoDTt30hxM6OrJUwCxYxhKCi69IARBw/HuSKlpW19lwWHkhVDHQDIaI/piqufMXz2Yp1J1d9inXZDJIMWXIcX5zmozYchtohOei5xegWBM+A9oteoxqhQag4cUQikmK8KWsYsb51eZoWdjjF/6S9HNX7lijD3NcN9cPYnU72KKYBiqaoiw7ddIghRw4hjZRZ7zFKW9zLv1opBYR4booFIS+wT4wIBL0oIwwoXRmZsus1reGVPbdQ6NtSb38CjmeCkkCHUDemFDA5ZCVepeGmRJKis0P9aDq8bQrhcqkDrad+KaTWCb36XrfLfgH1ifmm+K8HqqLAZ63MljREvXiFkDT11xU/eJItVYMCSEcPa+5opiFIemClhJgEve3Taiw5lukkM2ldYmIDjE9W0Y252R8MuTP/GI5vCzyj+eiUJSmjrEYMzUE9lbw4cvDOuWxD4izT523XqeYul8zVgBjyGs/Z4rLZ+yK9Kk2oQfdH9aqXSMF5s8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799279c0-aa17-437a-e259-08ddc3a99360
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:12:04.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA8aqou/ZjG0H5NW3SK9bHf2OH39aA+8YpHqNQzNHLpsRANm4KRjRu+NywRTA/2xzILl1d3g7REIcu8wg9o2R9mcn39yFGF5dfF6K/AvE0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=905 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150130
X-Proofpoint-GUID: Kx4Jb0g53yN7BgmN4VdKIsf_elCHaEs8
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687661ba b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=WdCzfWb4rf3GH59Tl6EA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: Kx4Jb0g53yN7BgmN4VdKIsf_elCHaEs8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX1IuQ9oqb21zp 4d+qvS7+t61mQE0/uwkcWfuPOwHKWRrMEJtGwbGGpUP/6+/mAOElLYCfaFUyGJa/3tdOCgd4xgi lvU2u1v0VnPjOsLyl8EOxaZXBjASsNasIdgworygsURRnmqbYu7YjNYemmUgw70IFIDoG2cZOY6
 dzc2VXPi87mvVtIONtR2CmLhkL5GYKUNmW+vLUWKt4CtUFDEYOwkvIql1QQuEAPLs4nLzUdfhXE ixT2cn+ZHWSxK/PBHH94bJHPU+/HJ9pYrlMKZcQwo+ge0QxR81y24bgPet+Jf3oyRrnrEvOgiyD +Vgt2+YzYgiDnmAWTpwy4LlqWCcjRXAJGY+OWNQtZaX85jBM7a2xToG3fV3MvQpyt7uSbfc1ESC
 PuwLLV+NBzXI9yf+saj1xy43ssZjRjMYrBr3/mvrMUXg3wuJLSejw9orkLePOq1jOYric0JQ

On Tue, Jul 15, 2025 at 04:06:29PM +0200, David Hildenbrand wrote:
> I think at some point we discussed "when does the PMD-sized zeropage make
> *any* sense on these weird arch configs" (512MiB on arm64 64bit)
>
> No idea who wants to waste half a gig on that at runtime either.

Yeah this is a problem we _really_ need to solve. But obviously somewhat out of
scope here.

>
> But yeah, we should let the arch code opt in whether it wants it or not (in
> particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)

I don't think this should be an ARCH_HAS_xxx.

Because that's saying 'this architecture has X', this isn't architecture
scope.

I suppose PMDs may vary in terms of how huge they are regardless of page
table size actually.

So maybe the best solution is a semantic one - just rename this to
ARCH_WANT_STATIC_PMD_ZERO_PAGE

And then put the page size selector in the arch code.

For example in arm64 we have:

	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)

So doing something similar here like:

	select ARCH_WANT_STATIC_PMD_ZERO_PAGE if ARM64_4K_PAGES

Would do thie job and sort everything out.

>
> --
> Cheers,
>
> David / dhildenb
>

CHeers, Lorenzo

