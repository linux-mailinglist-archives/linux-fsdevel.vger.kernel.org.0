Return-Path: <linux-fsdevel+bounces-47372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2FA9CC5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9E7BC0DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172A25A321;
	Fri, 25 Apr 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTBcXOh1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VdwOjVEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85325DB14;
	Fri, 25 Apr 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593484; cv=fail; b=Y7ZacvimJbw2USbMFRAcsgBA3AnHED5LrPyoXNX2jeJFLjovEPqbHWsyyTlq/MlUuNI24eroJa1eaqyQlUq7Pu8+2eNmDm/+mHWeis677q7GxFDuW6ltyfY7nE+SyZTwfv6cdfOrf7PxsrIUdd4604QVUso/tAqnrSNbkgL3+aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593484; c=relaxed/simple;
	bh=I3620H6LfufVGI+FnEVslV/lakEIQSeZgOt+aM7R8jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYuyTwkHaVDLCZRgLoETuJN/CAcCfiuc/VyNHaTKApyZeBXg1deaojthQDWx3/TlQLRb6hzFhP97xR2TxMAed+Y6IraGLS2/9Js1Qt96FW45E/9B9WJiXCTtzLm7zJ1YO6aduU4HCAzG1zY9eUlIQddJdsEE4UxaiTdi//d976A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gTBcXOh1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VdwOjVEP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtpeh026456;
	Fri, 25 Apr 2025 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WoFsmy/S4lVvvL3hRlwsWIIMpQdQWGOGTE0+2NOIz8w=; b=
	gTBcXOh1qaqpG9hYB3jHBSRgnfru6ZwW95Bds5c2z1l9lczcg93DQ89/XH+YEHJi
	whDFvmRcuIoH9EfCcDLeso1sY9rlGaFd4OwWEaqyk9NRnjvhCjd8OjVLerXZR0E0
	JboFH5Er6bXkWItkPgz4NaeNaJgCfs+Aiu9mhC6ofvt6o6guVsbHbhO8q11b4iwz
	0JNQk7bQHhb38wlhf6PLVv+oclqaMpe6qSugRJyjIukh/ixlm9K04PapBuS5MK7h
	qYSnvXTX14OtuyjO5AeAXRUQ3mirHYBlVyrtL8zNasSAlikbMO8gMCN5xEk3qgBn
	f0Xg/vb5i912lW3ufVO22g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468bs1860v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:04:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtB1e024802;
	Fri, 25 Apr 2025 14:55:13 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pucw37r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS9hQdbJzJz0cDo80/skhp7cbN7XjR8uWH8S+80Vv2fYgEf1XUZmycQgc3ssH6rLVFvuR43327jj/cEDNBsi2/58pyR4GOJFTVc2JeCdFokR4quQ55Kn2XtFaxq7s1FxIDeRO6HWe9VhHTmeZNXBVI83r9UQtoryMSaR5WSeR1F3ZNrz+bzylYYCyF9bB17+Om4vo2G7m8BTM1mBqWYm5iRjxz5yEHwQMwAVc4DVoxsSNJzNh6B1XvCcGCoR5uhvd/3ecLX6046eRsmZJ1DDVDCOJu1usM+zvu5y9mEXL2LGJFjr5plTLDN3/ipT2jFowl/zbKFaEH6aSBnjSkf5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoFsmy/S4lVvvL3hRlwsWIIMpQdQWGOGTE0+2NOIz8w=;
 b=aC5+GbElVzZz17JGhYwQOOR88YGVzCzCM7lim5XBRVkHy6fgr6NBIeS8NFZRlUVlRFkvRdiLHVBaZQSf70sQD2RLQ5ShbO4AnhZ+kyBfaQJFdbSizzy6syV3Lx5TXnp9XnmA9bZrO3yDeQNMXJ9b/wfkA3q+BYDVq2Tn/wzg2LFnEZSrQv4hr2dXXZfOpfRfEh7/JPd8IWCHZl7b8eDklwL7YixZ71cS5/W3rGlUhGD3HweI77ElaSEO/22kfPFISTRKwv3NJ3RBaYBJeVTBvYjlpIFDuEsp1FZu7XqTyCDL0FJmADr4kzsLUiiUEhQaDCFLcRzM6m9tzVaTKwCq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoFsmy/S4lVvvL3hRlwsWIIMpQdQWGOGTE0+2NOIz8w=;
 b=VdwOjVEPnhoTH/hBOuvE6+M8DQV4Etxyc3rShE5UOIKIHwlWpQB1pUx8WYw/9fm/fITdTN/5eLRTunwAXfOgSbbY+QUuWPsa98mZ/cOSi5ATJ5XAdTzsYt6Yrw4jyUQRhvaYnc11p70lvtotTvCixkhmCVbWPSs9TL9Oyd/qZsU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:55:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:55:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm: move dup_mmap() to mm
Date: Fri, 25 Apr 2025 15:54:35 +0100
Message-ID: <ee69dc5af045dc438ef54ac37747c5a17d05f923.1745592303.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ed28cd-e12c-4e94-34d1-08dd84092c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rj7rPT1GnR0w44Iqb8803yXOLD0ojxOgDVJNtWeHoQl7jtJWOpKavXBo8fM?=
 =?us-ascii?Q?CE+EQ0SmH21twJAtgKtZnfof43clUvgDrsr5TZEx2ql8oUXk8nkO5v1rs+MQ?=
 =?us-ascii?Q?cuh91SYI9EORZhIrMjr+g/V6t3uycOpaFM5ERhSw1CKvK4cTvZ7Rki/ZFWAo?=
 =?us-ascii?Q?ekPY0Er0uGh+bSVu7XqT1/Sq0BDeYrCE4ZQBTCg6XPZ7S2O5CGu4BPwBo++p?=
 =?us-ascii?Q?l4c0aSGkQTlcD3jem4H0dAW+4epJxrJ94/h1zlEgIzeCLHqaptQJ7ecDapMM?=
 =?us-ascii?Q?3ucpZBeSn5IGndQn/8gcbRnQ61ZiY5dm2esMN+K+s6jtjlWdEeNN1IvvcWn9?=
 =?us-ascii?Q?rFcadqjDW/FcyMD4PCY82O8M9hA4HMnp29C+2hhg0ZRfGOssVlr9yG2tQ0OP?=
 =?us-ascii?Q?6NvxrCKKtUuO31KP4sHl2fEJA0SSlWfuwfjFIdDRMmzgSOqlQsD27DFCzftD?=
 =?us-ascii?Q?/DC0lLSnhl9Ot3rps8Bjwsb85Z9VGQUR32TJokhsxojrONrOVoDW0awQvrwF?=
 =?us-ascii?Q?AiKd33KvdmGbbCbT6D0PS1CZj/gDVaehUNWefRJHQANBZuKZa7ZA5VamuBBu?=
 =?us-ascii?Q?C5bslbIPfWjVHP/64nBSOsBQyZRp/iKP6pQhwAPzpaqEd9ZRxe1e2c6B15Cz?=
 =?us-ascii?Q?vL/S1owTk0vCaSlCdAc7N1wfSpWCcITjZdWbLicETFne1onkZiRgCgYavKAP?=
 =?us-ascii?Q?+Xmlrx1au/mlnmwz5IrqGYsc5c/qK4Z7yveLEju2u2cieqCEV/1ijlVDyxIZ?=
 =?us-ascii?Q?q2x0esIBOxTId7pgycDE5/sfLNCYffw9YZGyJjiJKRKv4UEi5e29HuhF2gSU?=
 =?us-ascii?Q?j4FtPfzbeLkTnEjq0z13SyxIGFcBHU8MwKqIf101+E5ysWkSPBTypBiK7NmO?=
 =?us-ascii?Q?lrQqmdz2e4gGx1ajhpKszWAeZ16Z/spUN22hIvJdhklwE5UoD+RkUd82xpzK?=
 =?us-ascii?Q?C1YN9h5vLzGJhejou/SbxrzIvPyVg7AYmBWNTUXq6QYnUPwd3KE4n3pdxbjA?=
 =?us-ascii?Q?1ISU3HrN2izYbYFW7BCGgUSC6ezE9UB+cISrq2KU1ZauS0dhFbcz0xsOzapw?=
 =?us-ascii?Q?lMHaxwtGWk1QtFHVAKPLkwfBMj0kCoEWHWxjgEbKRb5PvPamaZKBVyHSa2K0?=
 =?us-ascii?Q?49+WdnuFWj9tVt51WvtQos5/Y8rXYQRKA2ftVsPuxK4dzEHW9iElxJDqGw6W?=
 =?us-ascii?Q?B18TxGx76lduC8aVK2g0p1nbiaeb80PatdhSvzQiAM+2y45aCuGZeuacimyO?=
 =?us-ascii?Q?LJD6xUpfobZFwXfR/hPpFU/eBjxA89YZFPUkV7Yp9d9eH8ZKvWpJOE/QCm3R?=
 =?us-ascii?Q?P5hRAdlgPCPruFavURfquenguZUcs+rqKhgkGpKQoyDIhr1LGsQmNgBbXdPa?=
 =?us-ascii?Q?q2r4H+3JCe8525umpQI0BKN/LUN/IPww44dnumxKTcSQUaFYgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6vdR8iiyaV/txItJOiFYy+NZviooPwgovLpMJgDQ7OkPKFeecwPC5+UxCnj?=
 =?us-ascii?Q?9gJS7IOw7EwCJoFhR2/tozBC1pmbgYAvSqM+M23QkUqj/p2Q09k7jh1g7HlI?=
 =?us-ascii?Q?8TyHpFoe0mrGVNtt22tDPlQZQe4WSYoumCnc0sUYT1/wVQSi0vkAsRxe6MVK?=
 =?us-ascii?Q?kHWCS8WXdNzgB4ABLTA42vCHpESgncSwrCBjdBZvdv3o6cMHHMt70/zj31YO?=
 =?us-ascii?Q?WjVuMApgO619AOjBrhuUbODqFUngxXaWZ1ZEyxOi6DSew7BD93F3oH/HUPR+?=
 =?us-ascii?Q?m8A5i6uzKyMguu2Hr1zWfVzpH9CiLaJ5r8/7v55QteiiVrKyGUsqQi/HiDwe?=
 =?us-ascii?Q?6SPUE59xG5xkmOsvAD/tkci/9c//Si/QGU5imoDl8SBDg4p77SIZKPEYB/jj?=
 =?us-ascii?Q?RtoJhZxtVj1JBrLh67vKRu9lscNP313OLeBNZEBOX0OUZAJZTuQi9u8O0oTj?=
 =?us-ascii?Q?b4uBnyqUo3mnm/W+zed+bH7f8Q8uvnKD2k2GzmVFWJQuOZPnt2fbmEfMlp35?=
 =?us-ascii?Q?sy9cZdpjcVWUOCgctD1GOv8a3a+7rTAgcbnjnBYMqvBB7j/XjJ9pr6GYScTD?=
 =?us-ascii?Q?FdgxxWWrwsw+/IpXbchcpSNRRRFvGZSAFHwZBNlhx8aWmctXuxLURikQNKhA?=
 =?us-ascii?Q?czCxwynY8S2mpTWm/ljUbNq0naXkhrugjZ7fQeSIL3wxymj5An33lHbOLyzT?=
 =?us-ascii?Q?sdIajcBL/CCUlZ1hzEIPyVexhtzZVV8gWa8NW/NPRLTEJB9/FNKL1iM21J9t?=
 =?us-ascii?Q?oXweqWMlct1e8AmorkNME6pbNrBl0YWP4Qm+uBk1GJp6oFGunXGNtz3PqVGF?=
 =?us-ascii?Q?MAsYeP5syzdTjQpFIrLcjQ+3TNzFH2o+LIT8Tafb1KmEGs8bM6KPFj5Dc1RP?=
 =?us-ascii?Q?P6+9nYTyJmoHeqQNCeq54nM4ISNMVEO9O4a1HbzeaiihOCpCgDB8C7LZlPzk?=
 =?us-ascii?Q?TmtZ9u2IgHNAIURTM6An0xOpJGg8SZbc4aeUFoq2St14yMeidJe/37ZEOqTc?=
 =?us-ascii?Q?V2T8VideGwJLAUVfzFnHrCPbDnT4Zer02VhL/itZr120LnCl8JxeBULvdEib?=
 =?us-ascii?Q?Op81ooWZrluxplq0SR1mIwtuznVw5KWJ4+eXcloVJBQHzJHd97H66jhwY+WX?=
 =?us-ascii?Q?jBj0YXhn8WWHEXfYx5l/SmV6qW9vG1GbK8Otwf0lHMAGNMKODn+fyR64gafw?=
 =?us-ascii?Q?bbifhpYm6BT0EK8jPfdmriiOYO+yWrPVVOztxL0w0e2Jh2p7RpovnAJp2cm0?=
 =?us-ascii?Q?jDvk+80vccuRDrpPZ1mGzTllY5E6bg96oCu/6hSGiW9GfFHnSPJh2jfjlvqH?=
 =?us-ascii?Q?osE/W48ozWiqwYut04jYIyHpc+DPnpPU/Ts2h16epy/JKAN2Cu+0ovq5zY27?=
 =?us-ascii?Q?GARnzk5nEoLWIXnTzHiwiuX19ZJLUumc8ZCk9oafR5am2dVthHaFrgS9XfFW?=
 =?us-ascii?Q?CJ1rj5SF1EygGYEtmh1vKqMTzMv8LCLnFxowfY64ZP/g+g3Q5hMmOPIoKO62?=
 =?us-ascii?Q?S8h1H+TY5sjQbmEoRtfSXBFhbHpy00SWR3dpOMnmmT8acF51jTTD8u+uXhOY?=
 =?us-ascii?Q?OGvhK0xs8bV0DxaZFp2D+C4HtI4x7udjKg1tzjBpnpz4SLsDpy3IHHLZ/MZF?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4NeX0cVo/jR6myHrEq7CSxNfWoBHFR7c8+2dyTOOyUnJ+ttXmieGSjQvhdDxuq/NFEAPHjGxHBrai4Ib9gtpMbIrVKpIJh6T0S+IBCQb01LwHV3vUqbRdYPqEFQ8cH/uKFfF1IgojPgHgyesuBj2cniLgJV753F6YvqArJA8nfTy4OobF5jD+s6cnIPeW2F85XnWYZqg55mkvLz94ja0Ct0q0Y6tlDbKSZYfJWXcmUxUeP9x1R7NKqGm+rZNqoXMyVQ2nMAqALaohKA/6SAGyIS1wdaIJJ9f2p/fuOrhLHbCuMroofs71gQb4GGgNuguq+wk0k8ztZF9mGdp+7rJQg6o8h5A92d9+mRXPJss9et8tEQoYsxI8XLNCyLCPdk5OoMFnbRoMIX0PYZ1JwPbfHE2RBlSUIAdkawsW6JD4kdvQLGncgYwNn4HDMX88AcNkG4XLGKHw4wp5g2iieQX/X4wlan1n76dqVbNRQp3tnrsrS60HK5UaHfdb5YZfXsn1n4AG2ac+DQIwFpbE76x6L9LHdlMjfsWT3BS7W/Qa625qMkpD363ZbM+RhlVHHjHoL7s1MwOvlzDnU26gz1fZCjtPFeTVT3IewE+x32foUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ed28cd-e12c-4e94-34d1-08dd84092c77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:55:09.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4Vhxwx5ASQjmuZU5lpZe2H2EIt1ZhyfUErU6t8m8Rg/UxlzphhUYTXerojuJqVzqmG5eIdPGhRSVgfe+dvKY+htQnNimiKSvrdukryeYr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250106
X-Proofpoint-GUID: w1KjMkgp8IWize8DvUfbH35tobWNnmHD
X-Proofpoint-ORIG-GUID: w1KjMkgp8IWize8DvUfbH35tobWNnmHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNyBTYWx0ZWRfXzBUuIWy64ML6 6FZc6yIrG2ncASimVfVCE21CKO0mVfsMBZwPl70K1A/lZ/FcwVcncIfE5XLUny6ykvmfDR3/dNi ZkuJ5/4AHg3gEEnSiXhHqENxitnt9h/QXhsbAoaHtxP4X3oheGEOXyAk97QWM87oxCSYa4XgRqO
 Apt9QaSn4V03nRicosqip/8e5m3TSpSo0hZJmRyaQ4HcYHEPUQWXKxEBAFXvhNNHE71n8NZHMwE QIQH47gvBN2C0iA2vupDd0ETherAAGnqZax/EpdJreXt6IbXDDFJMdRb/E2YX1LbJ1yizvWTtf4 EyZlyI2q2k/WF5WaKqQwsI9Mop2XBxOgtj/Ymd392ICreT18zVXlUAjb3Xw0fpxq0/q/gIax6Pu 8Fc/Ppat

This is a key step in our being able to abstract and isolate VMA allocation
and destruction logic.

This function is the last one where vm_area_free() and vm_area_dup() are
directly referenced outside of mmap, so having this in mm allows us to
isolate these.

We do the same for the nommu version which is substantially simpler.

We place the declaration for dup_mmap() in mm/internal.h and have
kernel/fork.c import this in order to prevent improper use of this
functionality elsewhere in the kernel.

While we're here, we remove the useless #ifdef CONFIG_MMU check around
mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
CONFIG_MMU is set.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 kernel/fork.c | 189 ++------------------------------------------------
 mm/internal.h |   2 +
 mm/mmap.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++--
 mm/nommu.c    |   8 +++
 4 files changed, 189 insertions(+), 191 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 168681fc4b25..ac9f9267a473 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+/* For dup_mmap(). */
+#include "../mm/internal.h"
+
 #include <trace/events/sched.h>
 
 #define CREATE_TRACE_POINTS
@@ -589,7 +592,7 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	struct file *exe_file;
 
@@ -604,183 +607,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 }
 
 #ifdef CONFIG_MMU
-static __latent_entropy int dup_mmap(struct mm_struct *mm,
-					struct mm_struct *oldmm)
-{
-	struct vm_area_struct *mpnt, *tmp;
-	int retval;
-	unsigned long charge = 0;
-	LIST_HEAD(uf);
-	VMA_ITERATOR(vmi, mm, 0);
-
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
-	flush_cache_dup_mm(oldmm);
-	uprobe_dup_mmap(oldmm, mm);
-	/*
-	 * Not linked in yet - no deadlock potential:
-	 */
-	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
-
-	/* No ordering required: file already has been exposed. */
-	dup_mm_exe_file(mm, oldmm);
-
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
-	/* Use __mt_dup() to efficiently build an identical maple tree. */
-	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
-	if (unlikely(retval))
-		goto out;
-
-	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(vmi, mpnt) {
-		struct file *file;
-
-		vma_start_write(mpnt);
-		if (mpnt->vm_flags & VM_DONTCOPY) {
-			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
-						    mpnt->vm_end, GFP_KERNEL);
-			if (retval)
-				goto loop_out;
-
-			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
-			continue;
-		}
-		charge = 0;
-		/*
-		 * Don't duplicate many vmas if we've been oom-killed (for
-		 * example)
-		 */
-		if (fatal_signal_pending(current)) {
-			retval = -EINTR;
-			goto loop_out;
-		}
-		if (mpnt->vm_flags & VM_ACCOUNT) {
-			unsigned long len = vma_pages(mpnt);
-
-			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
-				goto fail_nomem;
-			charge = len;
-		}
-		tmp = vm_area_dup(mpnt);
-		if (!tmp)
-			goto fail_nomem;
-
-		/* track_pfn_copy() will later take care of copying internal state. */
-		if (unlikely(tmp->vm_flags & VM_PFNMAP))
-			untrack_pfn_clear(tmp);
-
-		retval = vma_dup_policy(mpnt, tmp);
-		if (retval)
-			goto fail_nomem_policy;
-		tmp->vm_mm = mm;
-		retval = dup_userfaultfd(tmp, &uf);
-		if (retval)
-			goto fail_nomem_anon_vma_fork;
-		if (tmp->vm_flags & VM_WIPEONFORK) {
-			/*
-			 * VM_WIPEONFORK gets a clean slate in the child.
-			 * Don't prepare anon_vma until fault since we don't
-			 * copy page for current vma.
-			 */
-			tmp->anon_vma = NULL;
-		} else if (anon_vma_fork(tmp, mpnt))
-			goto fail_nomem_anon_vma_fork;
-		vm_flags_clear(tmp, VM_LOCKED_MASK);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		/*
-		 * Link the vma into the MT. After using __mt_dup(), memory
-		 * allocation is not necessary here, so it cannot fail.
-		 */
-		vma_iter_bulk_store(&vmi, tmp);
-
-		mm->map_count++;
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
-		file = tmp->vm_file;
-		if (file) {
-			struct address_space *mapping = file->f_mapping;
-
-			get_file(file);
-			i_mmap_lock_write(mapping);
-			if (vma_is_shared_maywrite(tmp))
-				mapping_allow_writable(mapping);
-			flush_dcache_mmap_lock(mapping);
-			/* insert tmp into the share list, just after mpnt */
-			vma_interval_tree_insert_after(tmp, mpnt,
-					&mapping->i_mmap);
-			flush_dcache_mmap_unlock(mapping);
-			i_mmap_unlock_write(mapping);
-		}
-
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(tmp, mpnt);
-
-		if (retval) {
-			mpnt = vma_next(&vmi);
-			goto loop_out;
-		}
-	}
-	/* a new mm has just been created */
-	retval = arch_dup_mmap(oldmm, mm);
-loop_out:
-	vma_iter_free(&vmi);
-	if (!retval) {
-		mt_set_in_rcu(vmi.mas.tree);
-		ksm_fork(mm, oldmm);
-		khugepaged_fork(mm, oldmm);
-	} else {
-
-		/*
-		 * The entire maple tree has already been duplicated. If the
-		 * mmap duplication fails, mark the failure point with
-		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
-		 * stop releasing VMAs that have not been duplicated after this
-		 * point.
-		 */
-		if (mpnt) {
-			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
-			mas_store(&vmi.mas, XA_ZERO_ENTRY);
-			/* Avoid OOM iterating a broken tree */
-			set_bit(MMF_OOM_SKIP, &mm->flags);
-		}
-		/*
-		 * The mm_struct is going to exit, but the locks will be dropped
-		 * first.  Set the mm_struct as unstable is advisable as it is
-		 * not fully initialised.
-		 */
-		set_bit(MMF_UNSTABLE, &mm->flags);
-	}
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm(oldmm);
-	mmap_write_unlock(oldmm);
-	if (!retval)
-		dup_userfaultfd_complete(&uf);
-	else
-		dup_userfaultfd_fail(&uf);
-	return retval;
-
-fail_nomem_anon_vma_fork:
-	mpol_put(vma_policy(tmp));
-fail_nomem_policy:
-	vm_area_free(tmp);
-fail_nomem:
-	retval = -ENOMEM;
-	vm_unacct_memory(charge);
-	goto loop_out;
-}
-
 static inline int mm_alloc_pgd(struct mm_struct *mm)
 {
 	mm->pgd = pgd_alloc(mm);
@@ -794,13 +620,6 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 	pgd_free(mm, mm->pgd);
 }
 #else
-static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
-{
-	mmap_write_lock(oldmm);
-	dup_mm_exe_file(mm, oldmm);
-	mmap_write_unlock(oldmm);
-	return 0;
-}
 #define mm_alloc_pgd(mm)	(0)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
diff --git a/mm/internal.h b/mm/internal.h
index 838f840ded83..39067b3117a4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1630,5 +1630,7 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_PT_RECLAIM */
 
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index ec8572a93418..5ba12aa8be59 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1869,7 +1869,6 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
 
-#ifdef CONFIG_MMU
 /*
  * Obtain a read lock on mm->mmap_lock, if the specified address is below the
  * start of the VMA, the intent is to perform a write, and it is a
@@ -1913,10 +1912,180 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	mmap_write_downgrade(mm);
 	return true;
 }
-#else
-bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
-				 unsigned long addr, bool write)
+
+__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return false;
+	struct vm_area_struct *mpnt, *tmp;
+	int retval;
+	unsigned long charge = 0;
+	LIST_HEAD(uf);
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (mmap_write_lock_killable(oldmm))
+		return -EINTR;
+	flush_cache_dup_mm(oldmm);
+	uprobe_dup_mmap(oldmm, mm);
+	/*
+	 * Not linked in yet - no deadlock potential:
+	 */
+	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
+
+	/* No ordering required: file already has been exposed. */
+	dup_mm_exe_file(mm, oldmm);
+
+	mm->total_vm = oldmm->total_vm;
+	mm->data_vm = oldmm->data_vm;
+	mm->exec_vm = oldmm->exec_vm;
+	mm->stack_vm = oldmm->stack_vm;
+
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
+		goto out;
+
+	mt_clear_in_rcu(vmi.mas.tree);
+	for_each_vma(vmi, mpnt) {
+		struct file *file;
+
+		vma_start_write(mpnt);
+		if (mpnt->vm_flags & VM_DONTCOPY) {
+			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
+						    mpnt->vm_end, GFP_KERNEL);
+			if (retval)
+				goto loop_out;
+
+			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+			continue;
+		}
+		charge = 0;
+		/*
+		 * Don't duplicate many vmas if we've been oom-killed (for
+		 * example)
+		 */
+		if (fatal_signal_pending(current)) {
+			retval = -EINTR;
+			goto loop_out;
+		}
+		if (mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned long len = vma_pages(mpnt);
+
+			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
+				goto fail_nomem;
+			charge = len;
+		}
+
+		tmp = vm_area_dup(mpnt);
+		if (!tmp)
+			goto fail_nomem;
+
+		/* track_pfn_copy() will later take care of copying internal state. */
+		if (unlikely(tmp->vm_flags & VM_PFNMAP))
+			untrack_pfn_clear(tmp);
+
+		retval = vma_dup_policy(mpnt, tmp);
+		if (retval)
+			goto fail_nomem_policy;
+		tmp->vm_mm = mm;
+		retval = dup_userfaultfd(tmp, &uf);
+		if (retval)
+			goto fail_nomem_anon_vma_fork;
+		if (tmp->vm_flags & VM_WIPEONFORK) {
+			/*
+			 * VM_WIPEONFORK gets a clean slate in the child.
+			 * Don't prepare anon_vma until fault since we don't
+			 * copy page for current vma.
+			 */
+			tmp->anon_vma = NULL;
+		} else if (anon_vma_fork(tmp, mpnt))
+			goto fail_nomem_anon_vma_fork;
+		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
+
+		mm->map_count++;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
+		file = tmp->vm_file;
+		if (file) {
+			struct address_space *mapping = file->f_mapping;
+
+			get_file(file);
+			i_mmap_lock_write(mapping);
+			if (vma_is_shared_maywrite(tmp))
+				mapping_allow_writable(mapping);
+			flush_dcache_mmap_lock(mapping);
+			/* insert tmp into the share list, just after mpnt */
+			vma_interval_tree_insert_after(tmp, mpnt,
+					&mapping->i_mmap);
+			flush_dcache_mmap_unlock(mapping);
+			i_mmap_unlock_write(mapping);
+		}
+
+		if (!(tmp->vm_flags & VM_WIPEONFORK))
+			retval = copy_page_range(tmp, mpnt);
+
+		if (retval) {
+			mpnt = vma_next(&vmi);
+			goto loop_out;
+		}
+	}
+	/* a new mm has just been created */
+	retval = arch_dup_mmap(oldmm, mm);
+loop_out:
+	vma_iter_free(&vmi);
+	if (!retval) {
+		mt_set_in_rcu(vmi.mas.tree);
+		ksm_fork(mm, oldmm);
+		khugepaged_fork(mm, oldmm);
+	} else {
+
+		/*
+		 * The entire maple tree has already been duplicated. If the
+		 * mmap duplication fails, mark the failure point with
+		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
+		 * stop releasing VMAs that have not been duplicated after this
+		 * point.
+		 */
+		if (mpnt) {
+			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+			mas_store(&vmi.mas, XA_ZERO_ENTRY);
+			/* Avoid OOM iterating a broken tree */
+			set_bit(MMF_OOM_SKIP, &mm->flags);
+		}
+		/*
+		 * The mm_struct is going to exit, but the locks will be dropped
+		 * first.  Set the mm_struct as unstable is advisable as it is
+		 * not fully initialised.
+		 */
+		set_bit(MMF_UNSTABLE, &mm->flags);
+	}
+out:
+	mmap_write_unlock(mm);
+	flush_tlb_mm(oldmm);
+	mmap_write_unlock(oldmm);
+	if (!retval)
+		dup_userfaultfd_complete(&uf);
+	else
+		dup_userfaultfd_fail(&uf);
+	return retval;
+
+fail_nomem_anon_vma_fork:
+	mpol_put(vma_policy(tmp));
+fail_nomem_policy:
+	vm_area_free(tmp);
+fail_nomem:
+	retval = -ENOMEM;
+	vm_unacct_memory(charge);
+	goto loop_out;
 }
-#endif
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b4d304c6445..a142fc258d39 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1874,3 +1874,11 @@ static int __meminit init_admin_reserve(void)
 	return 0;
 }
 subsys_initcall(init_admin_reserve);
+
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	mmap_write_lock(oldmm);
+	dup_mm_exe_file(mm, oldmm);
+	mmap_write_unlock(oldmm);
+	return 0;
+}
-- 
2.49.0


