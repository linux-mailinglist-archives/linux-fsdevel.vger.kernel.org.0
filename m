Return-Path: <linux-fsdevel+bounces-60842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B93B521F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EEB189BB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0C303A15;
	Wed, 10 Sep 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FYc6vDVE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MW+UZD+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFD2EF66E;
	Wed, 10 Sep 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535810; cv=fail; b=Uuv3y9Pzz9nJdalOGy12vA3jfABH+y9jpUHC/Z90mdTS2HsLfdLsbAj6cqfPNPo+OYaiUUuxIx2bYDPNQ0oGxX+whPUgunHIx802xhiDY/OcyZ/uk///ll7HWml9A6HqDSdcDx+73KY2KT2pphONQY3iU8qWkO40f48ciif6e/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535810; c=relaxed/simple;
	bh=eqmWanlp5PqI/UuaJf8XHJa4uLlr7+r5MrTuolcBxC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8vMmQHkhBtj93tB8CbrrseVR+JM7QRxCaWF1WRvX45DYTm01QhofsKE5QGHGM8Y+b9pHecJz4MaFEixJWgZtOyHLGrKup5YiFsIdLMVcoL2tyXVCIQ+fIDbK8awnYIJHa4QcyVH7fu9EBW9y/eRZjeeI1pfWh0iHF9BF1OgrnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FYc6vDVE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MW+UZD+7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfiOw005176;
	Wed, 10 Sep 2025 20:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GS3/V5WNiXqrJTK4i3TRXt7cqXTN+Djzsv5e/3LDIRE=; b=
	FYc6vDVEntpQx+vij6xn2g1NSjDZSUOWWNCrjNimucgGj8v4YEQ4hAwUJLDCbFRe
	5oPfDazhFo/beUR5rfrXjJC8cSxr9tFmYbQRb1LuqFeL3qV2cE+wCXiohS5Ea4hd
	RfoDs/+LLSvK4gD4OZKHNNUJKHTJ0e8UfdLtPdCWyUdB3AO+oEnQEsBEODmMK3qJ
	Kks9NMPZUc8nnkrmvUfs8dqFRJ5kKyUHe0WgmFPFbynfULWbsKXEGNPbdJqfcRRx
	OkMeEf78MVJOtmQMf8iun3ATUdbj9t1AZXIy+sAktNIG4EnEBK9407yxTbck9GtA
	NNrud/HWVV3NV4NKRRMBWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226svyxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AILQCN038766;
	Wed, 10 Sep 2025 20:22:49 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbgtpk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3xoI7N2z6C7oIPxod+jv1zQU8uZWp/41RPLxJnw6KCJI/kYD8pZMaWFxr64y5UrSuiG6nJtZA+M8IIttRs+Ai39XC59an5C8SP4ulC/14Jv/LZrvDmcZXbKHdqQe/Vz5msQwjllAQKy2BQsKoKPsy0j6fIlP6hFcVjo1ZcDyMQaxF3qlyorRwtCcC4Pptr1TsxZ9NEMm1V33x0Hal4WmDaWdaL+0K5ITPV1UTk3hxAGLW7cZinwM/r4tzxxcP7wUegpfDAsdZJAJtmYesG/4MROQBAzYX19n+5unQ0AUi9pmB8qMALd0u0+heUbMvOpIr+EjpF8TuXsPBURtpYEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS3/V5WNiXqrJTK4i3TRXt7cqXTN+Djzsv5e/3LDIRE=;
 b=KUAdaMpl0hwlg+W/MACJhDIhv+un+EaF8uwiblq4mFDDlm2zU1s6xclFEaD1k229LOjPQzzHtvaF33wvFXbmg0AiWIux5Ypo6NPwNSeW0bLaKBi+FnIe+/vHDWMVooBJTiwR3V+NZcYOdK9Npc41lpypv5E0Kxe6ytBnliAqRTqzGYig0ytjC3B1TfPbi3DkyQxaFcQn0efT86Awv1nZKgbFWww+6RCv84JrMt6OiXydAXTXAh6SiD7BUywKrL6sGtsh3dKf1v3P8XLWqBtKljbg9RPyzK5HnMa/uVw3ih3cnI9FPZap0dakKxtlRT9/1L8zGUuPipHbkXTZeBUweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS3/V5WNiXqrJTK4i3TRXt7cqXTN+Djzsv5e/3LDIRE=;
 b=MW+UZD+7gNsGWkGFhZVBj7IOHux0ABpV2vD1rLyayCN5neWxv7q4rUXvyjoDlgp715NcU22i4aI0FJZQSp98VqkY068S9eTbrkoDsjfXZwu0LgpRyW1/hcOSeaHBEOWD0W+6YEy+8l/IoGDvWgU2Szgve8AuNNNUTZzcO1L8yDM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:22:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 06/16] mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
Date: Wed, 10 Sep 2025 21:22:01 +0100
Message-ID: <b84a0d7259be8c56dec258665ea98da1e3cbda54.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A7E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::609) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 622f981f-85f5-4d18-11da-08ddf0a7ccdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nU3NsoFUMJxB88lSpSblUhzn6ZIThl3KhgLLLVcZeHXDFZDzIkc5jTGyEz/R?=
 =?us-ascii?Q?qnfRy5WwJN7S7jDDzn+4lgq88KhxKoIMTJUv89kVN8VyWzWZEtnvPb0UyBaa?=
 =?us-ascii?Q?oAazaIpZW/jzJADSosLKiMu4YTfIG2D11c69XSZeam2Hlsue+aozgnHUOcZr?=
 =?us-ascii?Q?uFeGU0ptvf734gCByyJq9wmiHbv+yrfPAqPAJoTGsRHvRrwNZV36BRYpgu8B?=
 =?us-ascii?Q?MHBxx6u1HkOJXuEAQpcPGWZBYqdIzbYjf3HNedZOg54KEQbxFhhNnYJ+Uh6q?=
 =?us-ascii?Q?KPOWczq/fBN2XzrgkOUoaPWr+dgtgVBdj5yX8Xmw0Y5XJg68OEyrjdgYb5tq?=
 =?us-ascii?Q?lI6FTVWEokc4QQBMh+vLlQiYknvLt1PVbPVr1Fr0alD2SFbA87SQCSOVu+Vq?=
 =?us-ascii?Q?daz9Ma5pqzukoZVMkvYo9rCOru4QZoXLo4wnyW87dRqBRxLPuBtMy1t6Dq5l?=
 =?us-ascii?Q?lapFYUpH0dv/PuogZH37Leb2rMz4J2+2qL5gEuHS55tL+jtSbiIhOA26PRTU?=
 =?us-ascii?Q?QP59XnP75ACyo57/AQijuy39qf4UQKCrKnJzbBBXTQ2DfHLmMpU0w6FPyiab?=
 =?us-ascii?Q?NZFX5BJNBnI4GeRF2kZQ2+hUYiWBA/iTHQGS8W+HyGyI6BcQ7kw39ru70lEW?=
 =?us-ascii?Q?XfZVhbYjO5aD41qLMHTJtm7jPUi8Bjog8imuAQG6GVHckR7SFaDxkZcyd/jY?=
 =?us-ascii?Q?siyJlqIuEYtooDicDu8FfAb01li0mtCMb9CicFqWQKzbB4x0z4cbqNYDPN2g?=
 =?us-ascii?Q?TCyvUtJa0YFPd4Zy+UGxCP6K1hsfGH9Ieif41/YUqQMdog6cErcZF4yK1i7t?=
 =?us-ascii?Q?dOprdKOvnCaJZE4s8tb3FFF1VLL2S13OOxc7ApIk62BZTfrhTnkFua6AeEtX?=
 =?us-ascii?Q?61mc9w3WIMOyVfgXT9IraIAKyCj4N5jmZBCdqQH+vXldF9g8ovLABxMHqTFD?=
 =?us-ascii?Q?u53nB2F+Q+doow9LMylpQtv9CxHgTW7hVx/Rvs7IQGlXIfM+tAe62DRgLlNL?=
 =?us-ascii?Q?fGEIY3X6GG2e9YEMHpbrwJSmLxBIo7r4juwzH1Ui/FdqDxnpeB83HN2pdN3K?=
 =?us-ascii?Q?/0uUSaq6oHKHsX9U4wlXxnzXo2S209RJxUmlnhC2PlaoDaUrzmf6I2e+xKTy?=
 =?us-ascii?Q?DHatOzspOH3KGS6ECs0z5ZootFFvw0No4RBdn0u/gaNw83cgIS95Fu4CgYUB?=
 =?us-ascii?Q?WUWh/uL8NXZ7Wn/noTpNCYx8Wucevq7PC0d5NjX+6tnIZOzdcdyu0Bya9ZOD?=
 =?us-ascii?Q?qjrx0L4b2lmUffdNAU0FkgS45PgqO5Q+MbabUBlzvNsUFVWo3akIFouL2+7C?=
 =?us-ascii?Q?vRy9rKOlJyP8aSaSMxQHCmi1gKnIQUcGWqUfq0ZgwUdlxsN9qVeanbSevuUR?=
 =?us-ascii?Q?aBg8ssRfw94/XnYXs83cup7kPuzn1RJBAjN5QwVuOYtFi11Pnt9OmiSuQjLE?=
 =?us-ascii?Q?6B00bBZzF4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtUL6V5/C+YcJWpHeg9iMvVn74XbHw0+2woJ0cXyEu81fSjDpZbO+KcQye7I?=
 =?us-ascii?Q?jP4VlBv+GRbtQLYkaTXRPV3qV/62HfpyNbqL9GgSnfGzH9RM+yjGlFBmAoxP?=
 =?us-ascii?Q?KZLUj+p0byE7No7ROnIz3oMQlRwAFVmiw4Wt+auDpkXTvjVlN95aAQtdcgGP?=
 =?us-ascii?Q?BEAjj0pc0hs6lOlPqY+PfSmP0zi6W6MkkZNW46IZr3rKnB8OKNoQuqlrmifK?=
 =?us-ascii?Q?xl9ckbBrNmUJzq2oSjb+3Bdz6szuyLfrZyj4M9IvUunvEcloxgSJqsSXDh7v?=
 =?us-ascii?Q?xxi90ZbfV84zkzW6pVMsU2TFuP0gDkhrOBRCySy18mn2ljEq4IjArmJ7HN1x?=
 =?us-ascii?Q?qKfZvIXJCeLuSYkTtFG07YoAUgXqDkAdIfa0kTko9tTpK01Yo6uJUHA7dqAM?=
 =?us-ascii?Q?Zizm/sv740UbAMaQQ23Cl1g7LByl17IROAARuHnSOYbneJDxyzythUTSTpz2?=
 =?us-ascii?Q?5+3NBuapGFHia27qteahSEq7c3oSe6mpjNUOuPPE5cPbuNPIUCSJzGvjNWio?=
 =?us-ascii?Q?u4K2X02dFsYN2C5xWqz+Fcjebbi/qBL4Dd0R8f+fzuwmJoeH+EzFBEEv50qs?=
 =?us-ascii?Q?X0C8JDOwRAPELptXYQTOWQA4vMK+jysUhdEseuKBRgIS4YkHppLmUgLjjoRa?=
 =?us-ascii?Q?bjqSOZXqBLqDIybSyYeFJUaABywtKJ+XnFKdjlJD+kSCKTetOdb4OZLxYFVE?=
 =?us-ascii?Q?NzWJ3ur91Dq8ihmjluziXKq3rkfiIYrHD5O254Uxwzr4EJToKAqFUmrJtwwP?=
 =?us-ascii?Q?M4V90EB6IDyohnibX9QUg68jrbTHLLr/4mw+t+MNn16pUtSIb2cPmaqaUtSN?=
 =?us-ascii?Q?Q3a7R56kIrjF+5tXtyZKer2ZKIh5DeA5UZoUULxh+S5u4oE2ijU9wkL8MUkE?=
 =?us-ascii?Q?HqLt6hokBn1UtOFpte86H6z6XjHhBr9zVunRfdDtOGfl9veSCGqJ2zJD00iU?=
 =?us-ascii?Q?1Hx8Ax4Ci8rKP8NGevVeaWurX7haRMK5eR7yLeD1qR/U/mMOubiqPvHXILd9?=
 =?us-ascii?Q?93wb6bzbHog91jrFBsKzdDbiVFgxIokZOKDBIAOzmPKbmlNuQO6X/I9ZVRXi?=
 =?us-ascii?Q?FQ3rgX4dE3COcofAOHqhKD9Y5NhTqWtlxjttPrlvNXiAfKkyjWicHfSjAW3Z?=
 =?us-ascii?Q?3YIWVZBWkQxDoiwDLyMt4MFLd5TKPnD09ObcdWOsS1PDI432CYo/sPrAEGaK?=
 =?us-ascii?Q?LRoMgOfPfGa0oeoK3VT1NuFwAzp2o7+sK3oPzpe2vXI/Uq8IAEvox0hQqNvt?=
 =?us-ascii?Q?FsWhg3BkaVezbNoJ4SeAitPnmf9FsVJ/KkfRFzwgdO3H3aMkKvehuClS25c7?=
 =?us-ascii?Q?iSS/e8MOv70+LXCJ2dOPDqf4vehFHiyG6pI/nUbkubTyjphql+aMVg0A7Okw?=
 =?us-ascii?Q?jTaOLMtzRZtq6K3ZALZMnAwx2k1vyafNXswbyXo6l4nSESRnO9YNWW7AUk8K?=
 =?us-ascii?Q?IgAzy55bROm47OjNFyZ5UhwrEMkPS2VOHGUX6JVR0qqPfYU/BTppVXTVr6Ip?=
 =?us-ascii?Q?Bz9XnQqfjSKTQA92HZrWffpK5tNkMNjdWyftENIp5QOI56s4EzYBuMAScd4W?=
 =?us-ascii?Q?9JEa2JBDyU/9ilVUn5mSVB5sXm//NM6SHoElCyLYlfcgXBjJfgLVQOYSNUbP?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZMRI4MnibRCP3elHc6VlCUbqdyisWjLLNIfkOptZkn3P9RVQAmEpNJiLuEMd1v9QTj1mGmQbkOaPOUqUsyXNy4ejcwierGq/4qeDvKUpwmQ+ggFc2nw3J8RZH34JIADkdq+9IMCtUIK6TrWPzAxov13lr91LqmYUH0l652EMfIkO8+Zp2QVS9V2tQDIBHiKGSxWD5iUSU9ikjVifUBXkMsc4cDDhlyttWxzw64xPJly8o+SxZhLfFRe0b0XnQn4/bYEUkP6Ipklq1R0w19O46KF0aqa7pMLqNUExP4jnIg4vquhG4DSkcSmuiZgfz541GpSsEdhNy3dpRqd2QWuPiTngvu4tCqDP0n35H/UpnKgmPnr+vA3ZgM/fPIuHtqQhIHzuSmYclEqHBpZOmbyk9n3AFVm9giUW86qXwja+9q83Sbb9D8Q3Ov/SdYY3VvG+A7jHUQnuEJT1/IVaf4QezunPiEjJKiE2jY/YbpGn8WbG49Z8qMMvTPAW1GImRtMyDluvqFJFEv33O2478zzR5aPq8vlz6S0YNAbB8vAJfL8tGuzsJQzryVBIE216yfvwnX4cFdjd4EHX9wrYKYPNQltivpbTwDJdQXYo0Yv06Lo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f981f-85f5-4d18-11da-08ddf0a7ccdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:44.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhCTxD4yZn+DdXPBhC14wF5VsqiYKzuUG3l/C+ingG1/zLftVKQA3CFdoyA93G3ouZdZi/9Hau3uAz92jxp1M7Fmuvi/VlbCjgugMa32vyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100189
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c1de1a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_Jg6trKoHIQy0Easoy4A:9 cc=ntf
 awl=host:12083
X-Proofpoint-ORIG-GUID: -9iLtigKb8WGKVwRRKR8D7eEqEPIknQ0
X-Proofpoint-GUID: -9iLtigKb8WGKVwRRKR8D7eEqEPIknQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX0KpOVVV7GhhD
 v6d3WoUQNXeS6EYa0xw8fpr3P4fDkXNUUpCXTpS7h3nKQzIB9qWn3jBcArfb3lei9BM2pcYXyS2
 DDF/qcD8jX9FbT681T3M2c91ZmvzOTFpxqgZ9WB5Yo1RjcntY3OZedX6ffRDH3PRPbJJt1RrDt9
 rBs7vmxfF2RJuBaVYcM3vyMkGJRtQGkIafsReyXwRHxgkuABZ69YErVbmFqVxirJw0aDrpDu7Ap
 K08wxyoOR0RpImWIk5Xs+TSk2jTXVC44YlnmituKa/aeX4ZgjZmkLLhNp5rw0Yf2wTNa6ax4HN2
 Wnmo+RbxQTzA0YM4ZrfdCNCR/sOwqJCvbpUnRFyLxl2/ujSdscbk7nkdkCxTTUu7m5b7iqvkuiW
 bE79jWn35oJilED3SlSDvj8TRgLiKg==

We need the ability to split PFN remap between updating the VMA and
performing the actual remap, in order to do away with the legacy f_op->mmap
hook.

To do so, update the PFN remap code to provide shared logic, and also make
remap_pfn_range_notrack() static, as its one user, io_mapping_map_user()
was removed in commit 9a4f90e24661 ("mm: remove mm/io-mapping.c").

Then, introduce remap_pfn_range_prepare(), which accepts VMA descriptor and
PFN parameters, and remap_pfn_range_complete() which accepts the same
parameters as remap_pfn_rangte().

remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
it must be supplied with a correct PFN to do so. If the caller must hold
locks to be able to do this, those locks should be held across the
operation, and mmap_abort() should be provided to revoke the lock should an
error arise.

While we're here, also clean up the duplicated #ifdef
__HAVE_PFNMAP_TRACKING check and put into a single #ifdef/#else block.

We would prefer to define these functions in mm/internal.h, however we will
do the same for io_remap*() and these have arch defines that require access
to the remap functions.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |  25 +++++++--
 mm/memory.c        | 128 ++++++++++++++++++++++++++++-----------------
 2 files changed, 102 insertions(+), 51 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b97589aec6d..0e256823799d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -489,6 +489,21 @@ extern unsigned int kobjsize(const void *objp);
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+/*
+ * Physically remapped pages are special. Tell the
+ * rest of the world about it:
+ *   VM_IO tells people not to look at these pages
+ *	(accesses can have side effects).
+ *   VM_PFNMAP tells the core MM that the base pages are just
+ *	raw PFN mappings, and do not have a "struct page" associated
+ *	with them.
+ *   VM_DONTEXPAND
+ *      Disable vma merging and expanding with mremap().
+ *   VM_DONTDUMP
+ *      Omit vma from core dump, even when VM_IO turned off.
+ */
+#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+
 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
 
@@ -3623,10 +3638,12 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
 		unsigned long addr);
-int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
-			unsigned long pfn, unsigned long size, pgprot_t);
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t pgprot);
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
diff --git a/mm/memory.c b/mm/memory.c
index 3e0404bd57a0..5c4d5261996d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2903,8 +2903,27 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
+static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+		unsigned long end, unsigned long vm_start, unsigned long vm_end,
+		unsigned long pfn, pgoff_t *vm_pgoff_p)
+{
+	/*
+	 * There's a horrible special case to handle copy-on-write
+	 * behaviour that some programs depend on. We mark the "original"
+	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
+	 * See vm_normal_page() for details.
+	 */
+	if (is_cow_mapping(vm_flags)) {
+		if (addr != vm_start || end != vm_end)
+			return -EINVAL;
+		*vm_pgoff_p = pfn;
+	}
+
+	return 0;
+}
+
 static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -2915,32 +2934,17 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	/*
-	 * Physically remapped pages are special. Tell the
-	 * rest of the world about it:
-	 *   VM_IO tells people not to look at these pages
-	 *	(accesses can have side effects).
-	 *   VM_PFNMAP tells the core MM that the base pages are just
-	 *	raw PFN mappings, and do not have a "struct page" associated
-	 *	with them.
-	 *   VM_DONTEXPAND
-	 *      Disable vma merging and expanding with mremap().
-	 *   VM_DONTDUMP
-	 *      Omit vma from core dump, even when VM_IO turned off.
-	 *
-	 * There's a horrible special case to handle copy-on-write
-	 * behaviour that some programs depend on. We mark the "original"
-	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
-	 * See vm_normal_page() for details.
-	 */
-	if (is_cow_mapping(vma->vm_flags)) {
-		if (addr != vma->vm_start || end != vma->vm_end)
-			return -EINVAL;
-		vma->vm_pgoff = pfn;
+	if (set_vma) {
+		err = get_remap_pgoff(vma->vm_flags, addr, end,
+				      vma->vm_start, vma->vm_end,
+				      pfn, &vma->vm_pgoff);
+		if (err)
+			return err;
+		vm_flags_set(vma, VM_REMAP_FLAGS);
+	} else {
+		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
 	}
 
-	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
-
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
 	pgd = pgd_offset(mm, addr);
@@ -2960,11 +2964,10 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
  * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
  * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
-	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
-
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot, set_vma);
 	if (!error)
 		return 0;
 
@@ -2977,6 +2980,18 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 	return error;
 }
 
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+	/*
+	 * We set addr=VMA start, end=VMA end here, so this won't fail, but we
+	 * check it again on complete and will fail there if specified addr is
+	 * invalid.
+	 */
+	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+			desc->start, desc->end, pfn, &desc->pgoff);
+	desc->vm_flags |= VM_REMAP_FLAGS;
+}
+
 #ifdef __HAVE_PFNMAP_TRACKING
 static inline struct pfnmap_track_ctx *pfnmap_track_ctx_alloc(unsigned long pfn,
 		unsigned long size, pgprot_t *prot)
@@ -3005,23 +3020,9 @@ void pfnmap_track_ctx_release(struct kref *ref)
 	pfnmap_untrack(ctx->pfn, ctx->size);
 	kfree(ctx);
 }
-#endif /* __HAVE_PFNMAP_TRACKING */
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target page aligned user address to start at
- * @pfn: page frame number of kernel physical memory address
- * @size: size of mapping area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-#ifdef __HAVE_PFNMAP_TRACKING
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_track(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
 	struct pfnmap_track_ctx *ctx = NULL;
 	int err;
@@ -3047,7 +3048,7 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		return -EINVAL;
 	}
 
-	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot, set_vma);
 	if (ctx) {
 		if (err)
 			kref_put(&ctx->kref, pfnmap_track_ctx_release);
@@ -3057,11 +3058,44 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	return err;
 }
 
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_track(vma, addr, pfn, size, prot,
+				     /* set_vma = */true);
+}
+
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	/* With set_vma = false, the VMA will not be modified. */
+	return remap_pfn_range_track(vma, addr, pfn, size, prot,
+				     /* set_vma = */false);
+}
 #else
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	return remap_pfn_range_notrack(vma, addr, pfn, size, prot, /* set_vma = */true);
+}
+
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+			     unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_notrack(vma, addr, pfn, size, prot,
+				       /* set_vma = */false);
 }
 #endif
 EXPORT_SYMBOL(remap_pfn_range);
-- 
2.51.0


