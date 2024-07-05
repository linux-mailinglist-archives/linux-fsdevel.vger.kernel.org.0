Return-Path: <linux-fsdevel+bounces-23216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8A0928C37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32291F24D14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664816F0DA;
	Fri,  5 Jul 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UnC/eYM0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G76jPN3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D116DC38;
	Fri,  5 Jul 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196729; cv=fail; b=oFTOTCEzwdibM3gFZSJc30U63+HSQhUB2qxJ3iCjyelR4jJO1nAWCdu8KzoTZ2qncGtoguu25NODdBhkgHR6vW9K75PE+7BdZS95i0cquj9FGv7vsNGbmWiPx8bpWrbsW7cUnAFlFa+1NoHe/6vp5OkE5XQsc+sXm/O9RB3ccGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196729; c=relaxed/simple;
	bh=dND/GHlUBFEXj0+DDCl3fAJI2QXHIFtPXp906M0Smqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2aZfcCId+E36BF7LF/ACXBiuJwkUIWBsWdnp6vkxgPQ2acdrJFO+oNMzMQZSJ8xrqurJJteJU2c84/dLXXbcMNodRRKDRS68oO9PpuftET60qtUnoylWy9oPFtG+s6zkwnMGBy1Wa2TjaWIf151PJOCooLZk2AfjZuYk/AMeLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UnC/eYM0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G76jPN3T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVLh024638;
	Fri, 5 Jul 2024 16:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DT7Dy2BAnYcdONpZTU9BhgRkuFjTpBYvYIoX2uX76YM=; b=
	UnC/eYM0HTFKLu0Xxkzk69dVT17UsU8OBN9iz0g0JmAl5B3ZgJxVOClgHpz1PhGB
	Txro531HAtLgf4bZyoYxEFWaLkvkPW0fq16zo24Juyj81831Z1TkZvLjeTXkI2bC
	iXHduZjl+aRaF1W9scq42lYdDl71n3+LOs39BgHP2XqkjxUF4odiytjR+VboQOF3
	Ttcd74tGru9YTqD8PXTNEXPhJ3as1Gk8Scs4WSjIyYmnF1SdoaD5kdMCdK3U+LuJ
	Kgd/i1dNN7HDuU7TT7PSW0KCxHwbmhGo4J59tSq79jaA875VG2Xc2WwAHrUDwEgS
	W3FILfxOiisC8oDHohKJtw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59c035-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465EErou035660;
	Fri, 5 Jul 2024 16:25:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb9g3x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9HMk7gAWxy8xjXeEfRH7Pgm9E5mDRwSSzsggIi9dfAaE9cKjRGMfAOA94V2sv02uT2p8/S8+rSycL4wo0hCBZ3mnbDhzKurO19fFOe+jgjSEApwhwHM6dJSTmCzJ86/ASI/ykFacvFaksIqzEd1IbDbDzpyCdvVEAkTSr7zOugpKJ/QWnJ7IqZYwQvuIg6kBpK7ONnE753/Ty1GKMxZTFesHOPDKNe/wALgOludTfvyd/1SwpPe52CKn4RpSfA7zSVP+v8c0e2NIeRSvDEvt8eJ2zqKoekHv+Axx/2psfzwUwFz/amer1rqSr9EiqyMyHJ3Z59m/tXDOT3IhCHi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT7Dy2BAnYcdONpZTU9BhgRkuFjTpBYvYIoX2uX76YM=;
 b=HOLTi+v9PHtpSGR63hJ0OVFF8p3Hf8AukWNoahP2avyD16kKlmFeppXjGznkRgYamwdlb3aq2txhmyUdg9plHQGj482rAn1/KfRZcxZ6rKusctVLlLHpA52mrw4FnSEa0efs++OL+85CruOPnlp/Jb+n6SRuRHmlggYW3r9OXkHvo8y9KbQOovNbf6Uew0OWLfQSfwHEF6aRLrccw4rw82r6+eI84Tw6ExpEHD2MnmqBnkVxCrnkHuT92GZutSpksOoMCzG/d/LUZdgX7Q19gN55Vswjtoz9+k1JDegYnqKDZ0NjEkbkuQtIKpZIWuL+LgxBmddHAcwJ/FX0A5rfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT7Dy2BAnYcdONpZTU9BhgRkuFjTpBYvYIoX2uX76YM=;
 b=G76jPN3ThWrfW4mXaitznOPz6OdbRQQRa4YzetkKHxcl0/z9EkWcbr+yJGo+0V1COf9p8mNI1HFD2pRdGJ27ohqoLeJjl7NclO7BJF3uareUcWtrXaXGsZD39Yyl2CrUeVpKchbJT2dji6+CiMk6O0YAa6bWHwH3p0JFlACXssI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/13] xfs: make EOF allocation simpler
Date: Fri,  5 Jul 2024 16:24:41 +0000
Message-Id: <20240705162450.3481169-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b44c35f-249c-4e82-d3e5-08dc9d0f0c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IHs5bG2AAoklaT7p4J2qx6OWwfJZY1SwCVa7juIdiybblYw56BQ+l/GpAb4Y?=
 =?us-ascii?Q?9mbOMwmHkLfHj5/jtMQj/xNiyh2B4TzbuSsNg6KCyM3NbfBu8UwFAxL3pm1/?=
 =?us-ascii?Q?VfWFZMZeDjD9wvnKJqlaTLL7eaVZO8RY7xq7xhQXpbxX6ol+V+i7QWkFmGRp?=
 =?us-ascii?Q?SFYMcyajiS/1F2+YTZd0hf7KANcspDNJxbFYFGGKIIJzHfcyU0vJA8zC3jfR?=
 =?us-ascii?Q?BhKrwPcRZ3Q1f7YMWzqk6+PODAPii/v4uAzxek7Qb9ePZXLKCLGip09m/Fvw?=
 =?us-ascii?Q?BAM+JuDdXQnFVnR2vfyQLwdvG5q+phobN1Ss3vgx8CpmSMxoKyGfIvcDeQR3?=
 =?us-ascii?Q?dGfSRFW6JuSmipTW7hHiMHPvykVKwu+X072PaLeBQ6Z98XpIKFOcbsS+UJKZ?=
 =?us-ascii?Q?W9ij209IQj/G1VbEXieMJakuwWHM1WYHnxp5EcUIw2uh2h1jTVjaTSS0dSRX?=
 =?us-ascii?Q?EfIMQ2MJjzOhprubAQ27zLR8KoT2mxiZpW2ugSkV9J0KL06GMIXsBkosslkP?=
 =?us-ascii?Q?NlZCPHneZPAcHeu9yGMBd5AcuYEeOjnUL94AquIq/zVRtme1GVjv2QLFvi6F?=
 =?us-ascii?Q?+GhLV0gjXQi5Cd37e5qcmTNJzYgplypB5k3CwNd3+3GW0YKW/tI3b1ebwseb?=
 =?us-ascii?Q?ylWpnSmvPQxssfkiwRCtcUUZB2g0jhWY6xjrVERGJWOhiRZv0pU4D+VMXwD9?=
 =?us-ascii?Q?J7l0eF4ppMFc1mD25NBDeJ5b1aKPgxQ3OPN8ltxliVaBOBPP9DgdCdVLmpk+?=
 =?us-ascii?Q?sO5N2Mk3+ijLsswNeexXkw9nE/s/zbG09fK7b/+PIglKkbw5B5m85gjMoFoO?=
 =?us-ascii?Q?NZ7X1JPsCJCN57C2ECCkEyXDeKkrGgcOKaYVub0EwJbwuTF+dtWJ+HdP2HsD?=
 =?us-ascii?Q?T1dWxrAK/fMCHndxSWv/BVw5Ql9dMT2RtT9+CnhWl9NarhFZQOJE9q8jT6bE?=
 =?us-ascii?Q?xZ39Su/5dLteQb/ye+UWC/sPwvgNyBVaQxwwxidwHiTsztlysENxcMUi8C28?=
 =?us-ascii?Q?fKfL/McdYh83YB7mkVoI81ORtxDwxbRFWGZdgbebpKYl7e79OSlzLUf4WLZa?=
 =?us-ascii?Q?ytm1U/RpnOKzPvDXc0RE54hXuHVon/QpQSvYexhxpiooWYKgZjnWduu3a/HP?=
 =?us-ascii?Q?S4UalocVSpwzZJxNkYZMvFKLsJsQ2cHExcAnU1CevI06Voa5d8e2l/hNimi3?=
 =?us-ascii?Q?54RpRWqkX547Imd9CRAUqQbJETXhRcmd6hlyi2zrylCBI+HrZf8tz96SVuQn?=
 =?us-ascii?Q?gkewWCpQFsAoAK7tYDOFNVesL438Gw3oXGWinC4oORP9lzvEVX58oLuY0WCT?=
 =?us-ascii?Q?1HjT/9WdO7tOaDmNbRMvEWVIY8AkZj5WYunHlCAz4tomKQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s7tfjides653JVX4fHn5aA+ZNPMbqVRh5qnthj5Bj9KZiowkKhGssOHfXcTT?=
 =?us-ascii?Q?Eipv0gP/T7+wIvWRP1yu7ascvE8jPi70rVIiQo10AG31zQIX4SkiW85GUW97?=
 =?us-ascii?Q?2xyZibU24Z3mCADBQAxum3Bi6hS6nG4c+cWfvZpEikwQ9jXU5NhVwmeZ79uk?=
 =?us-ascii?Q?JbiJ9G3EFaJY0JRCbzM6XA8d5TrIdjfsN3C3jTz96iGI56hock8tUD0b0WGe?=
 =?us-ascii?Q?DzzHXLZ7eE7wph/ztQuMCjJ3uP7mU5jOV31s2hjQfOHS3pd38YYig5iFscx8?=
 =?us-ascii?Q?+7KRLfuJ8cbihdKgrkSBgEGTM93hUUamcq+ddg5hxxnujuHnADB945eS2J1e?=
 =?us-ascii?Q?BG9YS530rH7RKQkYlsaT6JF7KVhca2qozsXH2u0UmC+A0rnxx/3LGSWK8zzh?=
 =?us-ascii?Q?G0rDyA+0njOtnhbe2hQbXM7R3CYCKBj7/OA6NsrqLQbDu3ErIu8glj37rk6G?=
 =?us-ascii?Q?dyTrqO1+ICK6OwXXQLsCSyg+R2eNK1Umkr662TVGY6GYvxCtBEBOL3dDu7Vs?=
 =?us-ascii?Q?qCqISrwPnU8S7oglulTalrURbDyvsoiQ6nF4ea9sM6ElBeOLxzMEE2YqRyC/?=
 =?us-ascii?Q?TeXWX+HPrdWbwDjzEWv830TQXw3FUq71d7D+7jAS9fu0Ju2MNrO6VKaa8OOf?=
 =?us-ascii?Q?cer9B4ZSLxt8EyFbqMb+EOtIgtB/kqb1/u9JvszNIV+bf683b+lWywA7swEk?=
 =?us-ascii?Q?+Fqpk893mNQjoIuUPKaKoI70OnHl732ruqMJubmYlx6hQlmPM3HXLEeY+GGy?=
 =?us-ascii?Q?k8ALx4r8F5lKOOoVsZeH5n4Lrb5CzlpKd+nYNLSEEsue2YEb0n3XFoPtOQdY?=
 =?us-ascii?Q?LseoLl7wCZs7Z8O8fiJOFjcyUs44yxAp5aIzPiemqedtg+1sm1HSuEeZmU6A?=
 =?us-ascii?Q?vOnCpr9ys+maPaW3iVA/MaZjYM5d3x+rb4BHVfiAVzC8ZmQnrUbbEXmgVA+x?=
 =?us-ascii?Q?mxRTDlYdV6uKfpIrU2WPltYjhT45ZNIdwOUzhsgXOt9da/WTpRzMtm2P+y6o?=
 =?us-ascii?Q?lV1gCI3VMcEYQ1m5W4OAuC4va1/u1hytI+BTi7SsEraBNGpfbP6vjP3J3gBB?=
 =?us-ascii?Q?WzaI/+QkODGNo5DCSB29KL5EnS9QOyJ7TewVKK6NBGcnSDViKBqQElJyVs/F?=
 =?us-ascii?Q?AFQeif41xVPlRROI5/4+MwmRUW5c6gcfH2MtxuiVW1aOw+AZOQMZ26z1JpOY?=
 =?us-ascii?Q?+QNsE5OEI+CZk1U1va2z1i9RTV2hqcRAGt72SxEDpDCB5zjGNRYuBXbLG1d3?=
 =?us-ascii?Q?0fxncwnLRwbNpZDYuK/Prx7w/t8xIdziLqM4KhKGAxD3nt5nHg08wMPuHrS2?=
 =?us-ascii?Q?U/yS+W6Wlu46U6WKehvB//efFDmerofUW23fIMjCFV/GzJTrfjnF//KH0zsG?=
 =?us-ascii?Q?/eRsq9u5g8Dkp+OaZXRDn7KVXH/UokCo/FKF/eXSvIjoy+uncwpLpGuCKGof?=
 =?us-ascii?Q?/MmBZbPw9BGvTlSyq14WitbvwIeA8wOLKrTu1O6BW+6aXQ/lEXi0hrPgHXpx?=
 =?us-ascii?Q?kwp2nNh+YpUFhpgvk3Rk0FF5JqVw3F0rA7UUKjVJYomLtahFcIFVDq7YQYuq?=
 =?us-ascii?Q?AFz58EVFfl4cSuBobcN/v0u3E01+NxjvdaLzulx5b7zLBkmNtmZBrwg8/lwT?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5fIAfEV1keuoPFLbj/9y1O3FRShjuZXZB6/EbB8ZsL72fgcZwdOhFBeAkriLB3EupnZpFDxOT/TZkziRRoXSaMbWk1yNqin1werlhu/389/NQy6hx3zW7FL/RPV7CCg7bTvRyP2Zm+jWMF0srLoKkKNkTFRT/rURKKXpgm23fO4TXfNVexJz3EoddE/KlFy9ExpABtakuMuEEN5oaJksRSZ+4L7T7wEImyGG4bdlsDQihm6b+rFZmRsV73KABovyshpI7a9eG3DtVdflD/pANIlXvioxg0HAdNf7NeMabzkQe/rkK5Qt5GukCEfyGpK+7YxTIQ5O1w3rue/zGEOjqV0JWDCOI7SvJYUvismJUTpraUeUwzSSZe7hHTKMd6IKb0Jn0lUroitKVgwHDO1e86lZo4N34d3pz0jFff46lbLu5OaUBZCdLlmh2VoOvwr/t2JTZID5Hd6ezlsd8y/VkhUaQnbLO1WqFR99RalH9NKlmFIE4p1l4BHmExhM3l7Lla7b4NoXKvQYV+IzEgWttwk5XTgoLOVmDLpQpNMEaTdEqRKIk3w7NT1AfcpciN1JwkjJ/JUWWXyxX/0AZqLpsHcluHtudZ6QgYsd59C9Z+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b44c35f-249c-4e82-d3e5-08dc9d0f0c3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:13.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clQ6NwYa1aEPp/5B0IJssSUEDzmD7I2O8bHzfY56wGa8fGEIW9dhcni+Qow6RgPTUrAAOH5huogTjS44gYWcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050119
X-Proofpoint-GUID: VEUg6orhsVzBYAy-JXlmJUCawKtokB-6
X-Proofpoint-ORIG-GUID: VEUg6orhsVzBYAy-JXlmJUCawKtokB-6

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index b5156bafb7be..4122a2da06ec 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3309,12 +3309,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3328,19 +3328,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3550,78 +3549,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignment space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3687,12 +3648,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3714,7 +3682,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3725,23 +3692,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 9f71a9a3a65e..40a2daeea712 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1


