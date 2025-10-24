Return-Path: <linux-fsdevel+bounces-65562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79769C07AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2C3AA637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F934403A;
	Fri, 24 Oct 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CHCJ5QvO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mWoJRz/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71120254B19;
	Fri, 24 Oct 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329546; cv=fail; b=bk98TvxfmIpA8Y5k2KYR4y9tbnIGKKnh9MWZ8ZDMdUobKKivGwjzCKDeEzygikmFA52vL/lrt7V58sjvo1d07r7tQHeAWbbjQFTnbiXSVXe5O08t2fKJd/YXB8MkEyUvkk6m9nlGhL68EXHNUTv3QPFKz4Z8ryH0btindGAXerg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329546; c=relaxed/simple;
	bh=92jv8zpwZti0DfeNlDqK7b8XuA8RwGquqzjqS13rJUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDORu153aOzajJ+0Gg8xFbFv0iZjgfVES3PtImu9K5Ro5/JGcDkGAlWNjGvERS1YGrmTyQImP40kfzWUmzZEhcJFiHND6nmFzZ2P8d6wz3zZn+J5/h/2Jyk72rtE/IGnHsUiG0WDbii8HR4IsS27CxN/lPYMw4Of8X4N+DrrAVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CHCJ5QvO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mWoJRz/B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OGuBkd001052;
	Fri, 24 Oct 2025 18:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tg6A3WTTxLyaqU+GvI
	IgTqPrMQm4F+fuKxt57VvywII=; b=CHCJ5QvON/0BqC+p0pp8I9rEj/7DpqdsZF
	NieatateJX++sUCGPuFsiqnksjYMHLzazeoDqQ35e950k9cL6i3405rUOFA4KoUz
	edlFmPAx729wLuNp586FvrvqO7hCUInbtGMBDNcZTTV/RiGKUFts6APozZq5ICVb
	cpjTXQh1739y8YpcUQiGYv55OuQ+XUsqxX3JEo7t6ssJCfbNC7Ab8bElTg4fGYUG
	qUrnyd6WR2zfjeImmzLJ3Mbomw90LRwAvo2CJPn+MOgc5FNzwV2nGa4bZwpGa/zY
	y9HfOIdv7u2ic6cJlLtK8fevQ/Y3xpSAe23QviHI6hwNxVYvZAHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k5ekk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:11:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OHf9iS006447;
	Fri, 24 Oct 2025 18:11:32 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwkarcnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/oq9wLzQy0DUDxZ2iSZAwEJRs0TzokiE63cW/+GkW11DvJdxN5xrmddM9Qe+U1sjYIMKCyXgojRv/7DB3ja+WToDWgyWUgWiLzWhXJ81aY2G+d1/uQMu4zr0MfRFDU/h52UubRcmYmQlOjKHZDrmCk/08GiN5dmlvmRNvti1b3GoGY2cpn9KhqzsplLtC/YZmrjErNF+itUBEGzqIdriKscd9PSy5rcnBOlQCu1lEsIu1siEpxUi2TjZ+CjPmeGy2FYH37EBlR4f22Vt39oq81BMiuNUgtx+7cTG+54Rf+NnSWc7jaDYwcLY1jm/vvMGHl0+KhM4SqL1UeKuW4g6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg6A3WTTxLyaqU+GvIIgTqPrMQm4F+fuKxt57VvywII=;
 b=rrlYLXXNPsurz3fvzH0Iw6EG0kP1T1dOf4YrebG46Hu/62Gv/OurQ/HdRW+jAcwUdIk8KDQ1pYB6+2yPJlSAo25FHEHwgvpYtqVl81oz18XaoxLCzQApN5BJN9PTxS+a5fviE1PUnIALBBkWEws33/shr2yjxhieWCt/sF6YyX3pst08QT4apKPXbhikMHgVJ14EJXBdkATgMmry8NSYFb7rUzUy5Gdc4CTdqRC3xsdzFhFELNHL9xKpOYcUfh5V2KmvAGGL9YPhxsbcmT/PbEM6HQVTXrbiwwocgJADp8qSxjmGLgsBD4iofW8P0FSLkazCNollfx8wlNeoBoyKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg6A3WTTxLyaqU+GvIIgTqPrMQm4F+fuKxt57VvywII=;
 b=mWoJRz/BgYKFdgXEWvUB/yiAEdhILmy5AeOGWdAJoqYle36djQjy8U1FFQPADvc6570xqpWZTsef7qbC4RcJ7wjkEyPvPJexdejP1nmk+xIROfF/obUoVWbh68/65WqANcDT2EhHXtW7voQQqq1i81n5LibsAJyei0qoQC3P0hY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4156.namprd10.prod.outlook.com (2603:10b6:5:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:11:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:11:29 +0000
Date: Fri, 24 Oct 2025 19:11:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <74b5e3aa-114f-4b0b-85a1-81fc5432e4b3@lucifer.local>
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-4-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022033531.389351-4-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 696bc3ff-5301-474c-fa9d-08de1328c0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiHNM29XDq3wVT+J7JfJlsbzFTPA5CqgkyuoJ1FHArDfjIqCfWKTdl8OptyT?=
 =?us-ascii?Q?0kaHmkeM3DsLZ3Q3Zk+maDbPLT1EwP1Ku24R/Ygh5SQl3/d+6W8J2Yjfs2qP?=
 =?us-ascii?Q?ucBrDml2ds7aRiNjYuKhRqT8Ic9C+A5Qwf58QUNiu82tHf5MOQ0G8XSoLGKy?=
 =?us-ascii?Q?4d7ezllfWufDEDrMBAg/QRKYRjx86xFRlO5JA/yp1i4zRtQteetHGYPRZWeB?=
 =?us-ascii?Q?RXEFMJUgvZqaGxPoKsI+BtzfbP2L8TLumcvMdGO0n9dwwHiaSl9fViP56drr?=
 =?us-ascii?Q?beS7ENZnsk+8gH9nGNKLkVfz/Nx/n86CD4UVxnIoVzillkU+ZVSutOJvQV0n?=
 =?us-ascii?Q?tP+aPJoUTkt/fsjJ2QmZ6An5VZD2blLnHcJv4njeKfuR6eTjDUzuMXhpCXai?=
 =?us-ascii?Q?+3YCiwxXXsPJOnA/Yx5Eh1byTSorNZaejagZb6xFm8Ay0+iKQLATEvCtYMlc?=
 =?us-ascii?Q?VI0HFnaGW32qwWLaFggPAMvyWSml0/00euPwNsVqbuJEvN8qIj0pkPDOuArP?=
 =?us-ascii?Q?bUiUkXQTgrswKO740JzdnDqT37y5h4C+5Y/swUNeqAHB1MJSUJizj7wYSziw?=
 =?us-ascii?Q?tMQHQ04ealDMTg82eWX6tkpOJdjGSB51zRuggOGIDxIv0y8j6qnTljuOFhLs?=
 =?us-ascii?Q?f1s7oJR9EqPsuCei9DkxEabaRWF2bqmZyAHpGfzeu2NBBjNFLIruYlzP3jd7?=
 =?us-ascii?Q?IuO2U9V0ZCpT8zwAVmlVMSqx4LN+YppsXC1ejxTA/mOsXnvJcMftlVeRnnGr?=
 =?us-ascii?Q?rOkQK6UCRqpxNzVXVv5WgZzoGSKiRdQeSMxUaYJtdUvUC/zDLYpoQ8Y7EKRx?=
 =?us-ascii?Q?/IYE/nK/5by+vfn8NNKPwKRY76Fjai51EqCF583oc9xfhbwhSeh3XQe7OMqk?=
 =?us-ascii?Q?YgvPDzua4mAbzfRpg1TggkEewTcqHWykPWJcClHSyN1Ucq44fDr3Tw4dPRcK?=
 =?us-ascii?Q?lb8RNiFKH/yDHZ7R4rnJc6FQb6YjxRGfYXnYJ33ai29b3bGWO5L49QiYdbFq?=
 =?us-ascii?Q?nClFizCGZ01Zbzwb87biZiUTsVO2jVULztr+OXv3ej2/o56EJ6zpK68ezhQY?=
 =?us-ascii?Q?yDVvvOy6xUDBhz0A5PHU4LncmBA4mnle2rSZw3wFcK04jsn0xZKAc5iWlCzk?=
 =?us-ascii?Q?RnawroSd0ubNueIYoEqO9ScCsV6J1epUcjDstn1uMPZypdEuhyQwdqk+eUV6?=
 =?us-ascii?Q?H+Y0za/UWNeDGPrr6rZvwE5UIwtnuDmkMmDq2+2qDHysXEE/uwtEmsBYbR7I?=
 =?us-ascii?Q?3neosLwsAkg6Gq/yX7gGTU+sAYJL58HwJeGHvWEBTicH4hzWj1HDB2DSPWX9?=
 =?us-ascii?Q?ZyW+vMtSknSyL7Imh1ZfiJzOxhljtNEGGMz5bM6uAlUshZvibvv1zqQSGqzZ?=
 =?us-ascii?Q?TxKBLlxBvwiCx1D8ywPRAxf3CzIEEDe/BSC2X+IEyfnr7kKt6KnRwg8banr/?=
 =?us-ascii?Q?vNMA3HKjhNUuSClQjC1xjVbMLbcReRPu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zAerqOXMS5TTwfp7zvCC04SAI4rAqA74M/0f3KbQvxys/BLqfXNDNKYV4O1?=
 =?us-ascii?Q?TQORY2fF++yDiGW2692FKe5q0Msbg7WgdyPGM2T3Pt+/0nskMOxEBXyXwbVN?=
 =?us-ascii?Q?pdDUxwc3uc0ki6hQDYVWEvTE8g1jfiizcWSDQIT4qFOgR77HpHASjsjEBkHQ?=
 =?us-ascii?Q?K0HSeGjk43D+g2ArgcB7rTqobDbF2J9Y5yJC1VMDJa03ZqBXK35aEuyz7Adp?=
 =?us-ascii?Q?CO0czM0elJLO1rkVoTdWrdYBGn1QNCq6scyelmoiyqfndJUBTtdPaS6J0mCK?=
 =?us-ascii?Q?5FiCAS6voupN7uqiqPzNC2RLzH7zwMLws5NwJXQSflF6GummkOu4uNi7tLay?=
 =?us-ascii?Q?7xr/p2u8SM99hvaDj+RK0wXtkm0n/ZTz+T2BvsC6PkUdenn06NwXwWmMiUWv?=
 =?us-ascii?Q?BpsribSInsQzFhdlgAGRP+SC2MNRmjm5NKVY4wiHUXoo75frO0IpdQBYbIgs?=
 =?us-ascii?Q?fCdqZGl87Knp0KZANMT4UHiIoVXyqiUHq11Wn4XVLVEqyyBBHjhbTINbdJZJ?=
 =?us-ascii?Q?G3H7q1jTZTACxycdtOoCK9YkST/OGJ8ubXgC1MqY/2cGCqSHkpXTLRZ996mN?=
 =?us-ascii?Q?5lP7l++ad8p+Hi93DIpOtKK/iwu+9y4677Xx4dZvOsxwof4VRGfcIA12Gsqi?=
 =?us-ascii?Q?cusVDbshHD3Q5CcSmHnoTyuG00CscwNDt97kQvEMcT+in/Nygc1vId6ysbJE?=
 =?us-ascii?Q?8ZcQSVIAa8I5GxCkKZLfeBJ8xW17v8rAjWPTkuXpApvzbDnpTZHxMc4OpjJS?=
 =?us-ascii?Q?oWNl0u5m28R84ETPebPAGCosH6Sxdyi/JVmG2x5dvbDSXuUG8urRewoA913S?=
 =?us-ascii?Q?f8tjz07iSZjHbFy+C1osBRaBLKxkEt/r+JLbiuGYY+A+rnQ+2GhA5cSoJf9T?=
 =?us-ascii?Q?Sw/hQHl3inQ/IF0x07iLkwmWGnYudFocV28sQW8276LhA8J+3Xs0fR2/5baG?=
 =?us-ascii?Q?alWigLxl/AIq+W+JM2nWMyxn1+htpqHlSikPlMKTS5rGsXCgQCWzMfo85Sey?=
 =?us-ascii?Q?77bK1GrEsTG0AWmp/7B3bmGN3je4+UvVw6tKJaHdxQ4q2GZLRyhm/wUpRTav?=
 =?us-ascii?Q?6RbD00pkF0cZmX16aZ8ECDS/l8AaQZr84in3nTDk++YFEr0z9Ix7aJYUdaOP?=
 =?us-ascii?Q?vsxQWdeY+85D/MslLiCpJ54rXltqDCgFVjPFOZ7tULvqB84AgQl/iqbyb6ev?=
 =?us-ascii?Q?l3xRGvApN3Ug8l1zqGxQX+5vnkDu07tqZ5KoJxwge9cWV4D4phKP2K14/TiI?=
 =?us-ascii?Q?E06uIcPrzZ8K1xlytpNmUi50K+ByTEyzM880TtWXBpS6x4lEjTOoi4h3V6yp?=
 =?us-ascii?Q?jdbnpb+X9TmdmQWOxf+YDIMus32YNlImEJTPDV4SenO9smyjwKMUKnkLmmML?=
 =?us-ascii?Q?D9H48xSTUKn4asUmbO6DVrwVJX7RUW0KJChfhffUnY1t66DDtZ16O+Ux+zA1?=
 =?us-ascii?Q?p/15WX3p6knxQTbQCvjMcrbWva++OWkhZKGkOnUa/nN2GmK1XPUSww7e7zxg?=
 =?us-ascii?Q?rE2uNxnCIifa8Ol+zNvcaeiPD/PjxiKOP5r/gSdiISQxstebKs80mb9itT2c?=
 =?us-ascii?Q?Ke52wcIQDOiZ9m4AOInajOEO/4RxQx2WLT4iqi/StJOV0JdxXU29hT9LysXY?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cQLohUdrA0IavrySp2w0CiJ7rv9kC+RHBCntNTz6eqU6oubEqISK76tGfPV4rVu8mSdFEyMf5gGdVz2Zkjyz+sYl5x4xqktiGcz8B7PST2zsb41jSQrTb4kqVLYyn7xE+JhUnEwuwdVSCT8iT1Vx7hZfkE0GX7M3ezJ6ONtNVieKie+1qjMOP5s9WjAqY0Rqf07c2SGk7GsJOXMKBQEOVKvjGgNXcRgjJvDms/GopcEG3FaXjlobhERKAom3TeOfESGWVtfG1H0XZBSJffr3helZa0tKd9G9VXbnS/A52nNbJ5nwzLAkHbUfCHPfu468qhVddJdIOpFVaFSvvYz3ch57sGOa4WJm4/YBCWDS0ueXk+8wfrW77dQ1Lp3bKlSptvP7B9TQ7bntdCALCow6qKcTEjee2H54zye/VH31qxLJ9FZ+z6z1tr89AvsFPoTjQdNTqHFwAGP96g5yGtza0pZDggmEBvWTq6xpuSwO3cEOvgW1i+gGn8TW7BZsAakviitaoKJldvXjpmfsxtRnwRS9bQNePbXmuAi6aPQzcclLrYlYDPbH3u0xn12n2X/3KF/c8eQ6Z9dNOdCVqQ21FU+C0zBMRoHjIJDcUHI62E4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bc3ff-5301-474c-fa9d-08de1328c0f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:11:29.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoD6kFM4049Sy/JbSeTTzxAqLGnF3OlyBSqDq6QpZQnRXNBCHndyGbZuPzbiC7c1TEn9DY0qrgrzuon8D8RSEBPcLqf/6J6cOZYtteuEIiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240164
X-Proofpoint-GUID: 2KQQk8ImEpjrunj5m6x6pQsOiYJrEnoe
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fbc154 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=5gopNaVvLyHoqqcWb2oA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX95SDOaL91bxU
 Ethys5/oMwG3q6gyENhYuzOW34V0jutWwxnrOniu6z81vFOBS2tB9EPLGcKc+shUsNfciPLOUnU
 q8t/OL/i+hdv0RnZWiVQI75KbzEtpt6fdvktNbwZYWsZh4AKzjP4jNlWrKsUgK/Cvcgb6pqvzyB
 eJE5WTpWmNcMmTOdKIWd66ELWjNzLY/MetmPCcAIo+xp6M5dCDqBwJr7grG9x3y4t7muzVtsv2j
 V7mrOEmPA31EtovoxmBCLLY5lICdYMjp4U1IG2ZZX81KRnVpRXBUuW+3X7R7xzPVPtA1rc8Z9XK
 J/oPMzYnDDfv3EQIx2rU/ymG9RoUD76nXztLKNPBZS6LqmY89XcOhFTVI4b8vOeqrjeIUkV5RaN
 FFIWm8mK9KExh2ITSAM9absS9AqOoHS03fjQ7OPPW7qFyT3cORI=
X-Proofpoint-ORIG-GUID: 2KQQk8ImEpjrunj5m6x6pQsOiYJrEnoe

On Tue, Oct 21, 2025 at 11:35:29PM -0400, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if its min_order_for_folio()
> is not 0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, with David's comments addressed, feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/memory-failure.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..40687b7aa8be 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>   * there is still more to do, hence the page refcount we took earlier
>   * is still needed.
>   */
> -static int try_to_split_thp_page(struct page *page, bool release)
> +static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> +		bool release)
>  {
>  	int ret;
>
>  	lock_page(page);
> -	ret = split_huge_page(page);
> +	ret = split_huge_page_to_order(page, new_order);
>  	unlock_page(page);
>
>  	if (ret && release)
> @@ -2280,6 +2281,9 @@ int memory_failure(unsigned long pfn, int flags)
>  	folio_unlock(folio);
>
>  	if (folio_test_large(folio)) {
> +		int new_order = min_order_for_split(folio);
> +		int err;
> +
>  		/*
>  		 * The flag must be set after the refcount is bumped
>  		 * otherwise it may race with THP split.
> @@ -2294,7 +2298,15 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p, false) < 0) {
> +		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> +		/*
> +		 * If the folio cannot be split to order-0, kill the process,
> +		 * but split the folio anyway to minimize the amount of unusable
> +		 * pages.
> +		 */
> +		if (err || new_order) {
> +			/* get folio again in case the original one is split */
> +			folio = page_folio(p);
>  			res = -EHWPOISON;
>  			kill_procs_now(p, pfn, flags, folio);
>  			put_page(p);
> @@ -2621,7 +2633,17 @@ static int soft_offline_in_use_page(struct page *page)
>  	};
>
>  	if (!huge && folio_test_large(folio)) {
> -		if (try_to_split_thp_page(page, true)) {
> +		int new_order = min_order_for_split(folio);
> +
> +		/*
> +		 * If new_order (target split order) is not 0, do not split the
> +		 * folio at all to retain the still accessible large folio.
> +		 * NOTE: if minimizing the number of soft offline pages is
> +		 * preferred, split it to non-zero new_order like it is done in
> +		 * memory_failure().
> +		 */
> +		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
> +						       /* release= */ true)) {
>  			pr_info("%#lx: thp split failed\n", pfn);
>  			return -EBUSY;
>  		}
> --
> 2.51.0
>

