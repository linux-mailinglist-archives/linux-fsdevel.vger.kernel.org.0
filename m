Return-Path: <linux-fsdevel+bounces-75603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKzFMHHIeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:15:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AAC9577D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F89304B4E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B368357A55;
	Tue, 27 Jan 2026 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W9qXrsDT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OZs1yWfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913ED356A38;
	Tue, 27 Jan 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523145; cv=fail; b=hKiprFlPVk+M4waJ9CAHhm8x4Hglcpp8DqG/os0O4hQzL7eEIet8ZyuDz49q6vKfoAGE/BrHgqBoUvPorvnq51td0RHNedqIY0V/GquA8TbCc+jhk8ZGtCND2mB6GBougB2fppzGWClJdZKDlb3cjrqLsFoZi9KH0sSGU421pmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523145; c=relaxed/simple;
	bh=o/GKlBDv3+E1KRch0ZCjj9LOGnnQwCO1Syj1IL+/yFk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=oIBcYFgO/sccc6l6FToU+YTISdJSOSg9mhBXCnH+YoCQA/qA1tj0mIDAd8bhx5hdXk5AXNFIn058K9P/VU0WIGSJe9DwE6J1Gr7m7lMrc2tadJcG4TvpUJSlrEdjKV9X8ZgFE84ghCIfrkgozEtRqRv52LqtTXSiXBgFnGHkC1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W9qXrsDT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OZs1yWfP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBF8l53281973;
	Tue, 27 Jan 2026 14:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=012IbqDwO8TJvuucJC
	vMzDqUlfBZwtGj7eKb/NiYjFs=; b=W9qXrsDTUqVtlrQw1XB1TFLW2/O1/VhRNx
	b8pMWiL0zCdFIAdJVKHqyn6zmEPHwqSkoDgqxvdsuVmiY5G+WRG7Ry4laFGVj1qA
	Zk8uQejWInduQsEuMRLIO7a9TwWrKaoh/RfiARST79Cw+RkaglnpEz2pjuj777Ez
	+3kXGsSSHrZrTZhHCDZ2NJlbzs3rHc+eQ+uoxf/RTUhc2V0TWelDIRML5Am+DFev
	tW+C9E+3pwRt6oOk7j8fZ9DnsBpCgwP700bgE5fEz5nSJqAd05TLclUFMhwo0tVo
	OJmBHdnycMdW+i24PwgRTxYKhul12B+V1WWHs9XsSuInWAcDzHfw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmrc1yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDYMQ9001851;
	Tue, 27 Jan 2026 14:12:11 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhe06vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ7a7vkcJhpZYB0U2+l3/b8MdPDDxRUnd/rf42NW7Dgc3KQ/vRfGjL8IwTG4a3gxD9qvZ9fUfNOkSWcFJVdABOMRfcoYps3uWmHvamGsFNib2PlNaJqzsAngixsxRBH9N0KxkiUonA4yrKIQj4CTotSTujeQa6toCtYUi5R4jvsXpniPSFZYED/MpVKsKGqfjBnNiHeoRX+g59mAAvoLECIKxOLi4sL4VcZ3aqnDnl+pVzKHGRbWMWhhR284b4hYU1EJQi5WQf5YqkUS+x9Z6lDfYKEoxeLm43mGFtDo8B+HEg1OMAshyIOneL1hDuIvL7bQ00HhPRoG7PFKvmLxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=012IbqDwO8TJvuucJCvMzDqUlfBZwtGj7eKb/NiYjFs=;
 b=vi8Ak6kl6nK84PLXLPYakvT3XgE+pFz20bo5sqUOwk5EWAOBZV90Ys4p22I4BmvVuewvMQmgSnk9mA8sJvI6Aprurvm7jXt5XeKkpojBEHV2DnI+uNZUrpBWX9qLBwUFdw9Zz9p9+YW9O49Xs9cwR1IbgMO4aqohoOJvwWsz8pJXSr9j4z5Y/QLUQgPZAdaA2Q5kKG+q0n1jSTGd9uMFffHpmqple3f+DRMR8Ps8vOc3wwX6G/ffuYeoQGzS7BeZgzSxbIrWC3/4+uNSEP+eLAdAgAEsPUX6R08JrD4C/iyTZjqimiADfSA8D0rtuU9KYNH5RUFulx3VT6FK2SWaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=012IbqDwO8TJvuucJCvMzDqUlfBZwtGj7eKb/NiYjFs=;
 b=OZs1yWfPlwIas+TsUwIu2w/ovXCuZdRvquhvRgqPZFnZvx7Hd/uN0yLtBOoAMdI872E0+1eiI/xX8V0j2yn4dNisSrZaqaR/H5U1XA/E0b5o4ydYzjxZW6TiP0Zo7RU046POSFdbJLlhIxjYxL7VmKFSGDqLzGGtkzybJYHIW4U=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7788.namprd10.prod.outlook.com (2603:10b6:a03:568::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:12:06 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:12:06 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/15] block: add fs_bio_integrity helpers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-7-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:14 +0100")
Organization: Oracle Corporation
Message-ID: <yq1zf5zuouw.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-7-hch@lst.de>
Date: Tue, 27 Jan 2026 09:12:04 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::7) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: a283583d-4c9c-472f-4f68-08de5dae0d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsXBAUDYIp2fCvRPBSOBiiylW8cLUo/c/qP1kfq1PnTI0uUYPiju+4UtQ8TH?=
 =?us-ascii?Q?NG+G02AIhFgL3XWlHapLxKt0Wa6YoRSVb7zVSXc/jemTA1o9bLn9x96lYGkn?=
 =?us-ascii?Q?ReWfMekalXmxl9vKKPhem+2fbQQBHRSj9zJzOoGlRNwiciejKx3juBH+6Xmr?=
 =?us-ascii?Q?oOCyogCATVp2o3GFbQs01WGT7khivibRdAGBPVk6+ghqQdW34nIcnQFW9Tjl?=
 =?us-ascii?Q?D8nxdSk8k6Ogf3eFb1RVuy9uSBwr0RLJ+ni0Lwg4FSZyurhuleSnuEqTZZbu?=
 =?us-ascii?Q?1rdsQFDt6yJUNTJcV4jDecyxNcaljcwTZNe4y60g++2DpcNFGQPWbhy6Gnxa?=
 =?us-ascii?Q?zHhiJwo4q/AXkl5u8ILAv0+v6hQtpyiMRfZJLnXbk0xcvQewHs1rRaWrS2C0?=
 =?us-ascii?Q?uDIJxpDgNRQOqlGaFwBikNl/ViVL8nV99ZejUWRneB8PIj35U2hfnJ+eizL3?=
 =?us-ascii?Q?lZYa47CgafrOVtmlNVe/wLia3Bw1OjVFv7WX5zFuuf+uQ3KYfIaxix4aESbD?=
 =?us-ascii?Q?EXFZl7to14p9WyPRYmBvl3QemARr8FUuDwMNnvtT1rqFDQS8M1eGwUZgKf8V?=
 =?us-ascii?Q?CN79HmO+b15wwxgmaAjPM0EAjHUaQXMm8UpU6Wby6y5dABMWWarZpbpTHemE?=
 =?us-ascii?Q?k7t7I/NpmFaBA4QCM6EiPpIdSY+j+JsPEvYGJQSwC1R4ON5RpYQ+BgseoHDG?=
 =?us-ascii?Q?wC1RzGglJDTfU/j8TRk0nZzJNxSmnWbiJ7SNRDNjSH0oGCUgQyLxpLlIbDkA?=
 =?us-ascii?Q?we7jlNRBh2tWBZzrNDXwLimXdubuJVTjEAcBlX8ikVl4O9fkd2tGN+kAAtn6?=
 =?us-ascii?Q?Mve+kcZ4C63nwKOGDoFqEdB4iwI1onErTRYXcr9t7QM3Mc80rfaG+FHG1RfT?=
 =?us-ascii?Q?unN5xqIdrHbZR/KWrJC9u1+w+402W2bIErgbKfQbwuOzTVwE0GpU7DUsNx81?=
 =?us-ascii?Q?3J6rCuZ3eOHBfb5kXfRQakteskwgq8pLZ4u88BXrPhs3zrory77BDMDawpFG?=
 =?us-ascii?Q?VnGFJmRNNzTaW/aXlcn5piadiBW9V8DYanbSSbfgNMNSsCCsaLGpU01siqrd?=
 =?us-ascii?Q?iyxR5LbS46u7LWkI143q0vBXcsf3Gy2H1JSgpPHhf2FFnPFkuLLGKZa4x+dY?=
 =?us-ascii?Q?iGiYy+aRN0LcAWJupuzffGwAvfN8eUR0AbqoLns/BroGBLy0AcAqcMC81N2u?=
 =?us-ascii?Q?wMTV14M4urvvX3t8nl0Db2sYy+vekzOb0oAV7FxDpcrp/ZhbwtTnWFWr+tPF?=
 =?us-ascii?Q?vBGev7jz6gPveCRnBksGJOSboXxLP9fLKlbIqPb/ndYMQQ25BWvWL8WFNdWZ?=
 =?us-ascii?Q?2lDaCoxTI1rCkVE1CpgbaWJ9ZbEAv/7yhzT+OYQRf74zzBEgcMAlaD6RMRls?=
 =?us-ascii?Q?UKZf6natMqNaIMMlT8OBPkzUqiwNRWBN1olArIq1nKxDVvHt5aP2efKcNa6W?=
 =?us-ascii?Q?BBpGGf6rqy8YsSWHJZitLaN5p545RMabkSG5Km1+r5SmGLuiktD0C3ok/0aH?=
 =?us-ascii?Q?uW0oWiE7Wx2Z/XiI+dYh7v6ZqFsrHo1ZI58yw0qFIRYjSvmuPgoN3yFIsdAj?=
 =?us-ascii?Q?jFgRMPgOa5tXVd3hoP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mC+n9YaPHEXIjxpCppScz52L5BrQOD2PgloPjI7b6+dcqfZsBmbb9hrOPM+E?=
 =?us-ascii?Q?qtY7UxmJvOPS18qstWf0Nk6zlqg9LKs7t8XSTSRD8Mye59P0zIybgIo0WpRJ?=
 =?us-ascii?Q?ERiqVXsNODeMf2ODVvKCzVTFI2nUgtuS4rFEFXoztbjD4fQ1F53Xs2s69a6D?=
 =?us-ascii?Q?jELAbLqpzTDQJMgpZx9wKDAo+kEQZQPgEsSzY1mRTwNKAjK6KoSFBb2eFYn2?=
 =?us-ascii?Q?eRNBuyJeCVIfy45VEwKir3jt+o4yqjOz0EsgEZz0jQ6qQ0HoP18hfZaX1TWD?=
 =?us-ascii?Q?gHSvGyarw3GBJu+DY62JtVmjBixm4GA5yOwmacXEATJOAyypou88aoWyZuQI?=
 =?us-ascii?Q?mEGvDP/ES4UbNaDofxkJgZxfwGXTpEtNnAuzjwg6bzeLANePeF9jfhrQEr83?=
 =?us-ascii?Q?CsgLwj/PFSE/QdvwJLlKa1enibIbE9Rnkipm+FHB10tALsYXBvhHAQjQb4FR?=
 =?us-ascii?Q?UXzWVXM3rcX64ZL3rsEADj1MeohbH8vK1ktonlPBvgq4mI4tkK1rhQl3WKXM?=
 =?us-ascii?Q?CcSJoEX0zAQvfu5/ItyLxEKiX+GqyzBkM2srO28oyZ8ZUopmGCqo2Cdll2DT?=
 =?us-ascii?Q?9u7ODdkQgrBjlA8NnEMGkb4lvXyiu/C7kwt4OQ7Wq6U0iH3ihqTUj6omOyGc?=
 =?us-ascii?Q?7sEUAYd2L/T9qQE3dpcMOy9U14ZT9e3U5S1JX8im5PhQEh9DyeKFWVGV3wQx?=
 =?us-ascii?Q?2nVU3hXSgkXNzc+/P2kGLR2oNv8PRALZq9P9nN9bmmVR08v8JH+99QvWI8CS?=
 =?us-ascii?Q?vT0ff9vWkDvqLj4W+8gETLrDi/3uqVAsAJETP9h65ptQ5XE0gX8Abs2oKVyH?=
 =?us-ascii?Q?RAs9+ljFL3MVxNXkdlq1gWUZFKqi97jVuQXAIKOwq0FBcs9fzgd4qx6v1+9q?=
 =?us-ascii?Q?1ojQ0pVDlLFpghG50LETMwWsj4Cm8yaFMamuI9/B33fD4iRHe+n8IiDaZTyo?=
 =?us-ascii?Q?fEWuqvPdDdusjMB0mv0eb+i1LkLyEqtRp1brpD30o8vCtOziwYB4Hove9E40?=
 =?us-ascii?Q?K5bjQFrL4ytWmw3YKESGnqrcrWuJ4axP2iL37ZzFmDSe1jPupClFFwAjYyOI?=
 =?us-ascii?Q?IKRk4aba3DzckgcEpeDHtfynDC8vpRz4zWIoWH0m71QU7iITL5/fCe1fhVUD?=
 =?us-ascii?Q?QiaqF6COYolMqaKfOoWOVPB7SNVW+mEJKhMzAMOq/cXvIKjvL+BB4mFuXPG0?=
 =?us-ascii?Q?v0tZQZkl58LPY199UxLtkgnXOa/ElzJo/GGjENEZBnUknz/NJEuw1N/a4d1a?=
 =?us-ascii?Q?mF0kybxfoihpCnEk5+xhklNFTJBSEOoNVTDEbsLNVfVo2q8PxUHco0r76ljO?=
 =?us-ascii?Q?RhsJswXl+/G2uDfMXrC/oJiuKRPD891prR/FVg2vw7xoPt8tc8buqHGaFkRL?=
 =?us-ascii?Q?qyZYku+4KzmNOMGYpShaGqlb2rYI8cJFIPoGxms+df23xEArh3cZd2KnlT01?=
 =?us-ascii?Q?lD4dAO65qHflN7/tDyiMkuFD09yLlMaq9HUIZph1WCp+7zvEfaNMGnKmX77n?=
 =?us-ascii?Q?5r2ExuvHi+VS8LfIiL4AkyJPEpCpGqssqcNnUteVsVI9QvjArpdqAiVAD3MG?=
 =?us-ascii?Q?7qf1X1iis/HO9dxHfX2wsyCez4A620dvxr05ae7llRG8OECoHaAO9WbjIuDN?=
 =?us-ascii?Q?7cWzyXciUxRiIVA8+ZbVr1ECDMVWRU9waX9u8OU5nGo4NL2pX/8EepdvWeCG?=
 =?us-ascii?Q?k0Yxi0I5csZMU3sO2EXVrzJ/iDPAdchl6rJSqZ+Yg3dzAgZDz3CreppH05zJ?=
 =?us-ascii?Q?K/RIQiPWBrTKrxS01iMVdWT3p7qVIKs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Gf1+cfFdDLPjW2Ms0qOZov9cVPwe5VlU6m69Yc0IaWAWN79cGPDT4qAFJsLB0IWWSNsf97lfMlOA3vynE1cRUNpXkTMChS4X2Dt13aG0V4bLS47rQmZBrZem84RflPPt2hvLrgRZhOHNWZ7EDEytWG8pUA0aC2OTuoj0RJ/fxsgrvK2VWPgPBt3wfepoHBg01pxNewwEJPk1E4wizfyvcy14BChulMzTQr5cMXxRNW7Qh51c0fbC8rNgH+D/NmvTZe8DlX2DiJPqoJqgTLwnpxD94Fi9fFJmJWzh2Pdh/1B87ouYy4Byv8uy0ntumRN8Y5ACD5Vk33wyOvTyjni4RjpEfRhiYZN82UUnWFmYIXqXcb+BvmN1iDF025aMDamJCKFgtgoDdGdo+LcI0aMPieGtBafy6pqEXI00jERvfp+OHmArI5pYo5XbSCUFcYTgAc/BGKQlXNagMa69C9L2Mi9XH3azAxdjVfLUG6derOjo8RcESnq/zOU0jU356HP8mSOT8vDtlqBA9xKCEk3AqHzwGePkkLlraXO97DgPDlfel6MIp8XXIej78fLdzvt2dqQF5HCtzHcieO/892eNuvDBmoy7UeRz15dGSFCA1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a283583d-4c9c-472f-4f68-08de5dae0d8e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:12:06.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYuwkTxV7Q5Y9FSq9UI5bz8ZPx2XNDZH+f39oQ72dpU8N8CxOyRzmYp3LfIrPtaSepmgq44Xhu2iweYxKUMdAkw8pS4KfCclWuYgQozCvJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270116
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=6978c7bc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=G4-tufHDdpXdRD0AetgA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: aQHN5ljtVN4aS7DhqIAawGutOEfl2aRp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNiBTYWx0ZWRfXzRUfpCq62qJk
 sy2xGgefQhYht4i/IborXWLbnJAbU8XdJ+VUnxbfCCiELkAcTZ+WgrragJZHFqL+tQrfmJyXMro
 kZA5WNR5qicMu99QB2mGJUV9ZRr62UfnuJfSseXqV5YA6haEQuUItuKz0Xe5LQR5GsFdgeB7qDP
 iVXzuHkCwxRU1Nt59HfJzrV90T9ov5QGfyc6HZcm/gbdJmXNwxnYOkLxXv7RaxsiYM9FqRRVS0K
 G27vkLIHtA8FRC2Xj3Rb5QRCpT/eJRrg9jCgPYE7o3BTjMYdsEMTXduV+6ZutSR7MZQwp6KxdZH
 izR1QzTjvsdOsxXfSlyPQi7mX0wRxxgJ6WKsPXBibhkZJaBd3V/ikKwjcWvk/zKMP9naJXYapRJ
 +5SzNpR/Y6D5Hv58Crc9uF/+YH5az7fRmkWKWH8bd6NxS9oCZHKJtm1q+yPVlMho1znpm3QeK6m
 Z3M+2m2g/5qN/6N83xG7n23iKYZ471yq2MfR8wYM=
X-Proofpoint-GUID: aQHN5ljtVN4aS7DhqIAawGutOEfl2aRp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75603-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid,oracle.com:email,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 33AAC9577D
X-Rspamd-Action: no action


Christoph,

> Add a set of helpers for file system initiated integrity information.
> These include mempool backed allocations and verifying based on a
> passed in sector and size which is often available from file system
> completion routines.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

