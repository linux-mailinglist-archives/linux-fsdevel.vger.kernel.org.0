Return-Path: <linux-fsdevel+bounces-54972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CFB060F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A1C1C47323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989F2E3718;
	Tue, 15 Jul 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+Rxbski";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AchifLFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58828283FCF;
	Tue, 15 Jul 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588219; cv=fail; b=ZgAFO9TPARuw8eVGo5j5BR6nOU4PXjwzKURDkcQf86mdkk55t2h6cJN1s7+tsi0u3IQGJUWkt2teHt+RFKrwkIXlqyplfGa2aWyb2450OSD3qAtqzNfDWNvrvtactWL8owSWQGj9ahyWkmcECC4DgT03jHriXicp0kfe40RySBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588219; c=relaxed/simple;
	bh=8ksl8w/9h0FllHy1YgGO1wk/3rLaWoKS6Bc2eepLADs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LieQA4G0sz+4c4EjdktJ4/HskUNekinOgNl0EUh7uIQxr0DIkkBNQWDHRyaPnubHNxlkvLUFOhxXp3Jf/b7e7i0MQH1+/TTwHKY0JZohKRMKtZdyRzwfXobymjaAv+q/lJfZGFk6k4nZvIYvAXu4QvcR1GPaYW1623iyHlOvsoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+Rxbski; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AchifLFC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZCsZ015157;
	Tue, 15 Jul 2025 14:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VeXLgzKBfk8n/zjIFq
	D4yDODJUkEK3m1P23FKwMYtrw=; b=g+RxbskiKlUtA97/zl7W4LQb5l6cz7sUu3
	Qet0qjA2udHxFI996WqwcU6v1oEH2gNfAE24iXAJ9r9qPgCgjmTYH3taHmq+xvVh
	x68uWFd2cAxb1xBNaQ+mEARmPAws37Tp+eneSKH0QPkOJVyKHwnfJ0xYUvbil/xa
	BWXE2mb7TJaQ0zGkxwWjBDq43QO09thL1zso4vyFh9OK2kUAK0L1wPbxX540fG9f
	DtJX5/1IgORCu5a1qBnpaB8Ag9fRRyawFouExSCY1q4cMNPKqUfoAy1iKrVeXYho
	8nUNV7Jtw1Z3Q7XkemMRfX6Pc0QXyan6YZXmD7bfcjN+YNWkLPdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1axqng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:02:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCDgG8024809;
	Tue, 15 Jul 2025 14:02:21 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a0k1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5EH7T0Y8tRTwFhClW+T0Vdb/jrHPMPbz95wVcdp+7aZ6UR2g0vuvXtOo8uZOOzV328OAD7nYrUwVUf7zm/kgQRGRAfdUdWWcJepoY4SYnPQTjmDZCHa3oZo1TnRKy2mf2aaqdU4AmNGwvtepbLy7aO4BE2AQy1Cd/HD01Yw5zUtRmFVJeDC7asYW8754F5EMbkNTPo4k3FAJiXk1IdBesX99GUjIYXJRi93iwZOxxvLhExiqmmga828CHa9o8QVrs4UldFXg8qlkwtvrWyILZUdbhqfpt5KvlvhOVBmnkn08WaJl+g2QKY8Nfsl4kq+9Dx+FT0u2ouyQ1tDJjeAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeXLgzKBfk8n/zjIFqD4yDODJUkEK3m1P23FKwMYtrw=;
 b=BT8h2fgazTsiUITovn36jV8OSBfqCshdHFTh6wg1o1tv+Ac6LgQbrcsfWZCvUwiy7fRNFcijU3H1zqzv+8m2eedLmciW/iezu/6Je3T+zO7e+TH+eoRP0HoYqVD+rs+lxnM8iRdLidFRVy08BKTKiqIILCRKC5yyLpLZzmBhrnmroY8VfOUFllFk0aP/KRLJPk5L5CMdKdGfT+KvTFom+oTGwbgNMmLi/8M76ATg1MfRWqHNAlyX6SyfdXHeGGq/tOOSbjawCdjryN9p/a+5DoQUlj6ZXJ6o2Wi2m77ZMxROlBMz+50BFyTL78SWaVmA2GE0C04wQa7QS9lNbhW10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeXLgzKBfk8n/zjIFqD4yDODJUkEK3m1P23FKwMYtrw=;
 b=AchifLFCh5WkYsuvpw8rYBHARIkrgPABtRxpgvAAMk//ZereLueNFSnb/4DIfR+en71UDN6jxHdzsh92s77B8GfsHmH+0oAdlSq2w+YQ1llaBlao2yggFrGuqh9l887dlTigFV+reXyZ4rILzDUs5VBUn8YQnPUOPlHw9HtYk5U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:02:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:02:16 +0000
Date: Tue, 15 Jul 2025 15:02:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
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
Message-ID: <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: f193500b-2c4f-4975-857c-08ddc3a834ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzYP8FjeMdeGvb8c83sxEkLX9zuXd/FGZSIdd45+rFQO0j7ofhjFjYx8p6oB?=
 =?us-ascii?Q?xWRQIMW4bzjfrxIQD90goZnADQUpKvuRcB3S5o/oDqyat7kepKoOwwbaebRa?=
 =?us-ascii?Q?r/qYOHxfqaV7rZILgms5t2k9mqmKC0eDXKY500iRJGQSH1k8uQyyYFJhfXMz?=
 =?us-ascii?Q?FTiN267ZAXQ4TvzVhMCt4vDM9zMRWtwfSuP/hMmLhYmqy/a2FgYBUBJXgCX7?=
 =?us-ascii?Q?RlN+nk3MQom0rVk8fH5Il+emwGK4tBx/MNo0HPbSOuGpJtE0H2KL8g6teROX?=
 =?us-ascii?Q?+zgtkIZ6mRAnuqPLPcuRTZ8ur3oL/RQ5p9zpWgkNaiY8zYj4c1B7zWC1JlGk?=
 =?us-ascii?Q?iklZM7Hc+EcyHjBhKiNdrV1XnO2gZ7kmUWR+/anlL/AQeqjUAZouba4/DE25?=
 =?us-ascii?Q?V89mvTalc2IoJhj9T2KJDkAf4UBt3Tpuqq7DJw3cE/d1M558Fu6w/8LAyEeA?=
 =?us-ascii?Q?3X7alg0mXRWTJsw7Ljg1tfrxGVRy5cXpb2CYjJjaqSseDQ6wJ2HGONGhjA9B?=
 =?us-ascii?Q?5ojpmcEtIjiMLKCXd8GImlyk1SV2NeyiiYdq0B+9Khz07Q/WIy5ENw3Mbxe5?=
 =?us-ascii?Q?jlrLnkRLRbitWVczDSgufhsKneo6f0pZfzWRG9FHrIo8OeTqyWGECYXBe87u?=
 =?us-ascii?Q?sfgwK6awE0kF9F8B94/MChIQ0t6uC2rMSPcak6buixYrjGAW2lOYSg6JLorI?=
 =?us-ascii?Q?0/3MA1hWzhSBDFy4ZI5B40TBskQnvpjm59AojNQzOaSpkAqxiP3UQkfcWvox?=
 =?us-ascii?Q?OSlNY1C+KHUuAstm0GljAGcDJc1T2zNAsSua0SiDL/niZI9BPJD4Nrz3IlqG?=
 =?us-ascii?Q?UXRbXNsznA3DOwH17wfL5aw1d/zXqvBzc5c9MOQHLGE/yaQqycPAm67hjHTl?=
 =?us-ascii?Q?2tS/h/88WFSPWpWMq5u+ilkEqEoey7xnHfr4Mb7W6bOujrq+AD6FyGHV5DNg?=
 =?us-ascii?Q?Tv72wHDquo9lXZdB/qXBK1SHIwzXnLvTDb1Xd3MOp/v9BTvCRr4n0wDIGEaH?=
 =?us-ascii?Q?kiKykp37C1g4ybO1BCUWPe3KqZcqTUhhb7sWvWnI7MWRJ4sZ+Brea0MwOoB6?=
 =?us-ascii?Q?DXIG+uY57TTJdTRSXxWRCy5uRHIRkQTAtN+zVPie1ge8mexBs99Ts/blFpU+?=
 =?us-ascii?Q?ugC8A+g8KMWThprsNBoN9/W6WG4e3f10Rsr6SpxZ6lVvJuxUWsGyocTPFaro?=
 =?us-ascii?Q?pV8AvUz54vTG3pfiprWu+sN+iaBP0wPTV7N8Skiqlq9hfHBF/xOVpvbWmZFa?=
 =?us-ascii?Q?hfMNHciw8q3lACxT7W2shMp2W/Bgfnxr5/AbHDTm88b8h9SOOFZt3tC0k6Ew?=
 =?us-ascii?Q?26Ql56vjGwPs4YR7QhFo5Kc79MlHwkN2QuEwv2VTU2npIJLqqSwAFDWKFHFL?=
 =?us-ascii?Q?oMIrVcG6p/XQfti6kQXhwxmy81pj+hzjHMGAL/f0md11ShHaz0aJbWttXbAn?=
 =?us-ascii?Q?FcvZDu70YNU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqByl7IqzjyN8rbCGC2TiSa1fIifb2R/k2sA1a/oNJvyiRZXHowDXXTvlEFt?=
 =?us-ascii?Q?hFYlq8z48A8/v4TZH44eEeAWx9Awf9ItX+0ro9q1KSTThcaO6n81diYvw2uK?=
 =?us-ascii?Q?KA99kWFn7DIRd9OaTUt8WSTnHYkbpFy340SeL+eE0tpOUXUQTzEHHjmZUt8X?=
 =?us-ascii?Q?TmGMW+vfKfyYOqKrankLzN4dPXdgHLajRchNpZ53RCmZ1hqyDFm1nnXthEqw?=
 =?us-ascii?Q?65e7j/hbM8dDI30r5OHbBXxOqbc5xfe5k6RhMCkg3FlZkfrDfBF8TGzF/OMj?=
 =?us-ascii?Q?5DWVGUTEdu8ru1XHWYg2us3tNifYpSR8muzitt1NA2wLabNmWZsVVJy9i4zh?=
 =?us-ascii?Q?Yau79THJMv3MhAL2PvqtLoTutyBf8neI0ezPFCmXWkOsga59ZBKfkhon5Jlo?=
 =?us-ascii?Q?scb9jUojTFcdRGn9vNN5g2CbkgUqwniqSKjWCqsdwI6aaW0NsDGABXiL3okX?=
 =?us-ascii?Q?Z/c8+0BohhNDG2C/ew+RcYQMxG6+reW3hkKBwjpzRw/RPgl1qW5v5kKK7qen?=
 =?us-ascii?Q?TdczanxXsplBvf9VkNjclM48G8lCcmXIlMRUjuVGKBQ6BcjElx0t+uA6ElIB?=
 =?us-ascii?Q?tfFwMqTDQRbnvZCZ3VGgDNJcIhoH+2hhqMMHsWAWEcXJd/b1+0+8O0YRRNET?=
 =?us-ascii?Q?BDOudCmvqNVujI2+qq5+y+u8TD2KkFQ7cGc/z+YfeB+Yj8OWIdDVHVz+xiFx?=
 =?us-ascii?Q?+fVyOXTmwAhUVzpN/Cb4G6PY0qWo1auEdodNNbLkvyqgGR6QDTw0CSghvE11?=
 =?us-ascii?Q?KyR2J/TJY2vKz6LOlTwoFVEawomfsA87j3e9jKtkCqF1l8DWB1jqyCMvuG1v?=
 =?us-ascii?Q?XrNZyUy5MgtibVBwGO0YiG/7vHMDUyBKStjuDQZZ4zlfj16K/i42e+1xVcJB?=
 =?us-ascii?Q?mFUU/TraehCE1iTr1hOE2noDEHwG1ZRAYl7+EZxb02Iaihv3PYSlBuwD2Zqs?=
 =?us-ascii?Q?ue756siC+Dv/NnvWpi/XATRDzi8a43UdGkvEiZdsL2LRYF4ftkoKI9U6Rdsr?=
 =?us-ascii?Q?kgRLh+WpKdyXX3qsXvuMDvPAc56p9/UpQIJOesFYaZmF5KYwLySXDrrO2C8q?=
 =?us-ascii?Q?kHrwDKZIJaMwNaXXYNHn/vcOm1dsSkhwFO+4c1WQsdVXO5IAEggA5dUbCono?=
 =?us-ascii?Q?+9wskyifQGXLddzKWpRbIBszgYykqgRjGKpT+cF9Zeonzeg1OPdWRqDPMFev?=
 =?us-ascii?Q?00aOQGSqB+/93Ata/x+ae8c8LUob71jL/AGP8nmWkfyw6b49Fhw+tfFK0L2H?=
 =?us-ascii?Q?wmU1fc39qrMPLBvbM5xO3PtY8XnYRBACLoqv/v4ECT2aQaF3D7iUdD35PWlC?=
 =?us-ascii?Q?WNuPr2ooXLBU/M/I5GpTt7ogKp4bR6K2pbEvTYzbuFtyr1LEtjeqtXEKbCWq?=
 =?us-ascii?Q?tITSL4xXgDzj/z/0K3Utukzk6RzpbsLXegDDBCIIUZkljnJ7WeVDawXPjvgE?=
 =?us-ascii?Q?xCdyisFqix7BwwfikHupep3gFD0QQPDccKy5y55UaHtJLQWGCMLw5TeiwRFJ?=
 =?us-ascii?Q?JAxgNgE+yMqaiZQQVx3TmiqH2yLtlUUVBkHlzS//ZDGUKK98bYUAfQnG/41C?=
 =?us-ascii?Q?gwVUzNR/Z1S4HR03ih5X7LM6rCZTT6c43jngRhjyDy1H59BHsaF2YBFFXRQJ?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1ZSXQTFUm4v/7u3y0EY8i4jAn8VnvoW37DgK0eSnbdo3yfsKepfHsxNlL3DC+oIaaJSMTWWFIMyhTUsHYwIpttan71uOd5QjQd7iIC+8S1zb0LxBTwE7u4S6+l/boL+bh1NzQDjyrVowN7pekx+9ktaWQiqftlg9J/znKKXi9vLiw+zdZwI8Q2L6jC9ykusfVisROuDG1Ak4siMe2zVdRFyW0BjYkJwLzCDF53JHlSXb8x5leB18BphS9hcc+xid/vnCXg7OY1jP7rttG2wEWCLb+CxSuW0iwUHk+4+M1TP/iKjpD1/AsN55Dm/xxvFX0Frvg2wcANHBkaIv7hH+2UxhlWCpOKyBvLaZlM/rzYpgLzypdGPJHPMtAbMG5wjaswe3JYxXkfxe57DxVmnTTg/fvdJ3qIVM89DANy1vwtjbJG2kmRfo3SPJ8LAFw5EyZ0NrZKXWV7JFAXtnD/KICm0bQ3urSrNJ8CauJMrGnqmWZ4Rlaa9Fwul2yacjjjdqUoN3x1kqldRmT+bIX0ptjb6lpcv03x5bA41xVnhawBNMLHaIhL55bpyZ0dZKhN20CyLCalh61qDE5qgqLMZEx3EmQb3WPyOtGca5g51oJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f193500b-2c4f-4975-857c-08ddc3a834ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:02:16.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMOk76RUic9NbcndAjmKeAvAepAuYNfVdFbcB501QdBPKScPS6Yc+6R2PeWaeI6fq2/W3bdUwIzo2pKlC+i1H7EdGSt5VyWFfarthleVkAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyOCBTYWx0ZWRfXwbR04zZTCFl3 Wy7MAorQtEIiEMjhKfnXYKLk0rx1TBQTUKbwoyN1iUZqwH8SitK0eiokdfjpIYMQAYQ5MqvNno8 +s5dw6LkYuzLARE9XEWc7WcjHZR1Fi7BiD9OdNBySKCUh0vHVMxupJSUoHhbrSUsCLwpjClfotQ
 R+4+6ULbkN1L6gTgOiTk2YsBnqkRm97i3lY3E/kQ/rGlPnJJnsZTrxMk6Rhf6Ipqiuc4QcynBsC uzTjudZnwXq6aL6D9OkmJYYUo2MdGiO2QEWajRLnD/FWMpBpTsPeDSPqQJv7c6R/wuqBW09TMw8 ITNzNARGzK9gqdNrzuXbBDG2dsUPowg87STk9LJVas/HPbtC4bcKCIlOF/iYd0f2HbTwp6RmMrK
 2zugIgdkeevnon1RiHIc2TA/oRq286OdftZsQyxGv1U4Kl81JLRvAXwCT9YlEynadYPReT9X
X-Proofpoint-GUID: 4-rYGllSlw98Yrrdr-fVPaQzQ_bw_VKG
X-Proofpoint-ORIG-GUID: 4-rYGllSlw98Yrrdr-fVPaQzQ_bw_VKG
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68765f6e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=ZilgsrC4lj_j55ij0IwA:9 a=CjuIK1q_8ugA:10

On Wed, Jul 09, 2025 at 10:03:51AM +0200, Pankaj Raghav wrote:
> Hi Zi,
>
> >> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate the huge_zero_folio via
> >> memblock, and it will never be freed.
> >
> > Do the above users want a PMD sized zero page or a 2MB zero page? Because on systems with non
> > 4KB base page size, e.g., ARM64 with 64KB base page, PMD size is different. ARM64 with 64KB base
> > page has 512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losing half GB memory. I am
> > not sure if it is acceptable.
> >
>
> That is a good point. My intial RFC patches allocated 2M instead of a PMD sized
> page.
>
> But later David wanted to reuse the memory we allocate here with huge_zero_folio. So
> if this config is enabled, we simply just use the same pointer for huge_zero_folio.
>
> Since that happened, I decided to go with PMD sized page.
>
> This config is still opt in and I would expect the users with 64k page size systems to not enable
> this.
>
> But to make sure we don't enable this for those architecture, I could do a per-arch opt in with
> something like this[1] that I did in my previous patch:
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 340e5468980e..c3a9d136ec0a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -153,6 +153,7 @@ config X86
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>  	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
>  	select ARCH_HAS_PARANOID_L1D_FLUSH
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select BUILDTIME_TABLE_SORT
>
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 781be3240e21..fd1c51995029 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
>  config MM_ID
>  	def_bool n
>
> +config ARCH_HAS_STATIC_PMD_ZERO_PAGE
> +	def_bool n

Hm is this correct? arm64 supports mutliple page tables sizes, so while the
architecture might 'support' it, it will vary based on page size, so actually we
don't care about arch at all?

> +
> +config STATIC_PMD_ZERO_PAGE
> +	bool "Allocate a PMD page for zeroing"
> +	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE

Maybe need to just make this depend on !CONFIG_PAGE_SIZE_xx?

> <snip>
>
> Let me know your thoughts.
>
> [1] https://lore.kernel.org/linux-mm/20250612105100.59144-4-p.raghav@samsung.com/#Z31mm:Kconfig
> --
> Pankaj

