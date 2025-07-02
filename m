Return-Path: <linux-fsdevel+bounces-53646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E1AF595E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BDC4E2733
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D370280A51;
	Wed,  2 Jul 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWvL4OTT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YtdL2BB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898A27603A;
	Wed,  2 Jul 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462708; cv=fail; b=ZULHDX4LfFhn4bU5wU6l0zGfdEVOJUhoWo2VyDEuM25o4qcyp7xt8tK06HS2FGc1X4GiVrvyS5bL0lzdtRC5VQtkwXtSAgU+AfM/wUcvbDCD+HVTdeSFln2KAb5XIY/J/0IOedjbeB47+34EJNTEP0o6EiHByAifeeEfvwEQmGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462708; c=relaxed/simple;
	bh=BDo3lnxrX0K/wwDBd4zmjszPUYCj00kkoTonKIf6ZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUK5UBvpFvMI2rcCdGAIe7LalRXN4BhPjllVXkLVGVztKnjFvDrsbiF+/M6ATBrBmDcelTTxGGNSFdsJGAYDrzaPTwzAQ9voHBq5GbNck8aNrJKv+VQk7xFCCZTddfw2Onc6mzNQN2oUyP3VoCp6iD3JFFEpj5k+wEyA4xWsdD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWvL4OTT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YtdL2BB8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bitxe003688;
	Wed, 2 Jul 2025 13:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YwfaVuHRuCYfejovDi
	qyFuenYuTD3M6aelyXoUt1rBY=; b=JWvL4OTTogfurZIFf1lYXoEX6fPFI7bV7H
	hdZ9nXypW+5Io+nvtLsAjtHkQHOE/TUlfvgChy3ecJZe4W6oOzc9cDXVf/E6j6hx
	DIK+HlOwWiBQR7YGalY3Bc7re5mqCLjCNIu0xdVL6HSjZ4SxVflVEbdBqu2P2XXl
	quGNB7UC53j6tfI71BGCFw5Abx13cca7NE2BrjeffGgB/FpXv1ND/Zzgx1eE94dW
	xk6Y7YOfXyzLc4dpd3ruvkQt5hDIbAOncav4c7+VO4rvGxlcoinucgnrti/OdK5E
	ZS9Myr2rWTbCtNRNHs8GxiAaY9Fp/NCiCoWbTAa1RxXzMI1Rf+Yw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6whe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:23:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CSp3Z019616;
	Wed, 2 Jul 2025 13:23:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uay5s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy+YQY0VRYlDFrsn4inUuVp+XdTUFRyhX7cDqySuiOSaNL8alEWpVwhwIXXFzv6x1XLyUlfecx592cZ+4NRmHl6NXIRG4RcZGuwh0jdcHjOOsFt4xTh8n2SICItgocsXGtImXVQ7iDi7JuPB55gSnHDaqdPVrvuRzIsbt+Wd5kiMAjU/9C2osKQ5+cJw5Pj2oHPtwUMRfvPrRz69jA8JcyMrKXbsEXWgJvk+tKD7xXeeIfSodkWL2DX1OWOxiTGUE2tM6jWG+OFZS+qAn8u8glCL4wXOuHAA/hE8dRqH4rfLa/nbXc4pRwbwDQTjV0ZOofnzTI8C3Q2XSaEckUAoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwfaVuHRuCYfejovDiqyFuenYuTD3M6aelyXoUt1rBY=;
 b=Rg+o+Qzpr8i6KsSxCY7xO9men7lx6z/mAKaFOK9j6jVAjenaE5LyvibISXKhmq5AK4Y3446ahOxkUNy5G4pShZoPVfajV2pg0dl8drOxBq+Iq5cS0kPS6Uk3PfqzXffNY+GzjL6/6OYaWGDsjwcJ+r4Wl/DvwXmEpjMRN34Bw07sN/0Z74UPCo51iw+JFAPqQ0/Of0nPqn2sJGZh0kXdYGRwVULygqYhdgWgyQRb2/9YrYxjl/x6BK+KGI99cJ9VAp458Kc1uibkqjgSNAcFBNyYA2u2CnQ+q7Me79vuT6MIKYz73a10qDTKKdQ4gZmvCulRM24aJOg9Mzkc1gP0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwfaVuHRuCYfejovDiqyFuenYuTD3M6aelyXoUt1rBY=;
 b=YtdL2BB80AwFmGqC14bqspfzHOblh8AaTq+WIJiTVPt5z+xTLG0FTQbODvQ/e0w52UQ7qsRBIx99izEV3x6+DW9MCEg4gSPdcAuN3ScZQXuQZimHp6zJLzB/MoXsU13tc08zn0UiBeLkSVK4Lk161xFukRXzTB5hoOTF0quBqcI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:23:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:23:26 +0000
Date: Wed, 2 Jul 2025 22:23:13 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 24/29] mm/page-flags: remove folio_mapping_flags()
Message-ID: <aGUywfoP3R9txcuz@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-25-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-25-david@redhat.com>
X-ClientProxiedBy: SEWP216CA0063.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: b00ea8ca-771e-4f8e-84ba-08ddb96ba068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIibDj/jK8wvBEMm3fEUI9RCNgsaZ9QnkvS3PqOTmsqw4pbEFQOe42CIPoPx?=
 =?us-ascii?Q?J5LYatEeSI079pdjYrWDD+YLQBNKaD60eneBaSGY5q4Iv7Ywp7hw9371DRWx?=
 =?us-ascii?Q?033rMKmA1qeK+z6r9Gai7DjFF6eELVe00FdqpdIUZWlvROjr6SeIBXbmbxM8?=
 =?us-ascii?Q?28F9LAlGkX3UvGrWqhRnxGmnW2U9FW7J6lQt6suqbz7S8vJW6evNXsBeafl7?=
 =?us-ascii?Q?cPmqhNPi+gBkGMMSFWX7D1B+6tkQFHnjEQfmpdIbwDhkoe9jrJ4xXYusz/VY?=
 =?us-ascii?Q?hQ7xoDJMpPUOY0yZFhG5Nh7Cs+qlpZYoWOU7Ba39UDL4/FouApsKbcltQ5tz?=
 =?us-ascii?Q?+/akQ3YOaHaHm/BHOXNNk17fh3WdwZCGuzcffFhdIVOXPPzfym2x7sqMMgOH?=
 =?us-ascii?Q?WALtUW6zvspQPqL+Tu76ySVaOYC1FCnZ3gjZrYcPRUGjt79tSLCKXzQc1LRj?=
 =?us-ascii?Q?PLM4Ar0FoP62vX0GeUOVs8r9C3tEdtbl7Ju7SAnBMRMXgSTGumaFjeuUEpq0?=
 =?us-ascii?Q?wT0PMXTQ/Nle8Vrikg8yw3lpeig5RlYcHQG7tlBYJl6wABRfpmHqOOPtgw26?=
 =?us-ascii?Q?i+EUfd20WUEkL3LMgdnPlsad0KF1hC3JYXKdj5BIfPq8nSLPnm9P4U4dNRPz?=
 =?us-ascii?Q?e3xlE9GrmU49thq1gUJl8ahcGqkmzi3Twd8lCdtdXRG3qlelRUlu4V4Hr3ON?=
 =?us-ascii?Q?MdvXVjK0Oakqstl9Qma3KiLvY3+vm+yN+nPEswOEigZUCXAEkPLuG17Fk8fW?=
 =?us-ascii?Q?bK/UoRLqMRvzJ1bcYP1pbLyYH4oxKv6Eq0wUNc8HBQ1oTP74C70qm2EapBc+?=
 =?us-ascii?Q?aBMXQtcD7808O6mEg7BoOfOGiE+w5N+MpH4FXh/wNaqIaWDSJ3raZ8CzuTie?=
 =?us-ascii?Q?m+uK6fIobQV9ZA7Vo1x/10hw+W/AofNcMip5GFypAbcpZ0DJ7Vhq0Ky4lH6L?=
 =?us-ascii?Q?dtkyaHm66LrOImbQErCAFDoUe3SEr95I2pIjPf203lPELD/9tC9YZK5AXbQO?=
 =?us-ascii?Q?TWqVidX37QdsuCq6x9mtFB84WOjWu+Ta/iLbfjWXQ5jqtpDQhgDJDw4t9TMj?=
 =?us-ascii?Q?AYb21tyHCI8UscqiQ21zSA+VC9g6AT0kYyTJ8dzZkeP3YT1snda5M8dNMbMT?=
 =?us-ascii?Q?Y3/aaj8SFCtwpH04MFaGiJPJDraKSM0GvkxctEx1BgtyftbrJZzA/MoA5LzH?=
 =?us-ascii?Q?io3+qa4N/evLNBFU0N/WTDeOFhWTUubasaJanVbrCFshO52CWyfUHMn+Q00u?=
 =?us-ascii?Q?VGXlHjZTahHkxsE0BYElg30tuk88o8DJG/wUy2aVDLbWn+AKRG9ONWqg9dUe?=
 =?us-ascii?Q?/JHQ5pdManTE+c/H8PMQGP9KLHRyJ4BF0y6n9T9RyeuM63Yt/kFLelrl88Hc?=
 =?us-ascii?Q?7sEqgv7yxe8YnmiwFNEnTzXHCldiLz1ELrdIGsdna4Te+jueBxoDsSpiX4gP?=
 =?us-ascii?Q?741pSHgE6wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uiE+KLpm1hPy3ELZeRDVkDlzJVax7YP0NZM1DookJZMHZ3yYErkSFMGNLlbg?=
 =?us-ascii?Q?Ty6XviJ06u2OhXtGXS+WKs7XVXsUIlaE1BkmyrRf8SLEJFrCqKS0WSmEEA08?=
 =?us-ascii?Q?zwa5bnkOPcB29A8IOS1FsN+cIoO9T8cZ93Wz9/xzafWwBCVJrxaLobmyVU2Y?=
 =?us-ascii?Q?aaMxNZUZoRVmtTFkuF+ZoWgbNF+yS0rizDIk7wWxPV/0ONN5ZiMGa8yawvPT?=
 =?us-ascii?Q?PRmG47B3taLsCFrWWCmMZYYiuoonP7hcnRVmzgio819AA0i+hlNp/c/bc8/3?=
 =?us-ascii?Q?7w2/SLbeAYEBOr8THyKp58BxQaItf0AtI90ppcgmNhqmgSH308mBIS53miuR?=
 =?us-ascii?Q?bYjKcyvWtJmoWLE+cFyfe9jN+0FMUmu1l5TISXkHZ4GQh04vbkFoikxCJt6F?=
 =?us-ascii?Q?DJjBLyfr96ZJm7C8n2qoYudxW0EBCNzwrNbwqeqMlkXMu/l1LV1XbYXJ8kWt?=
 =?us-ascii?Q?l/R6SWufmf1z3qwiIulZBVwy92vc5JqfsdZ8r9wYGy05ZA/OCVG4MS5XTYdi?=
 =?us-ascii?Q?cXi07qv0tjQ67sJ3hyqDxoqB8hcv5jz5gOImTu8MprD5oJbciFJQMSRFw1Oa?=
 =?us-ascii?Q?TBjDQqSQ8zTKUVacnr6zaBLIYyvt2xQbyYBtO5RcJ2BU7W5EoIQKFI2TcvQ6?=
 =?us-ascii?Q?1XM3TVqWXyxyHlUA5dCahUpqCqxnprBzxveeQTpb7N7ksvUG3wjJHyT0ochR?=
 =?us-ascii?Q?WJdW0IHEIhU2H2T/dwkqNODvdSN9sDaqSLDoGOdBjHDooBbAb2j33aNw/K8F?=
 =?us-ascii?Q?ZcgFNbqQk1CLEKKR+Dbzk6wyOwo8ygZ1hsR8eQx88aSB3DhJHE1g3ifKNMMx?=
 =?us-ascii?Q?nmHECrj0Eq6mwbJgpgjqihKcbKfcOsFwcvTcFPSaUuBaDZnXD/zxZc59H2Pi?=
 =?us-ascii?Q?EOrZMe51n9CVuFPGpidOkmaIsWDvLvOCNA6CY75bn7j2wgxFOBWL6FhU1vJU?=
 =?us-ascii?Q?Ekhit04d4zqvO8AjGdzeS+iATCi8cjg6rqLJHLhbvIc3DDsFe/HsfE0OaRIe?=
 =?us-ascii?Q?kO7ja7PeWkZaKAj/lMpA1XpCiD/tZfTKIzP++dkDf9QtEs74f3ak7CYHSRru?=
 =?us-ascii?Q?Hw9oN3He8htcTzLiSxzey4Qx7EvVWa643EhS2llP+OZYrKTN9bQRciSxUwlf?=
 =?us-ascii?Q?VbgB+e0FwMxSzbXC2wIXsgP0inhvvgocC6xCcps0ImXcmROJdHNc3cZ24FN6?=
 =?us-ascii?Q?94rRWR0l9WCmDaKHNFUo/xmYNagsylOY4ybyDamMXi64WLYFsVLbadAFofuT?=
 =?us-ascii?Q?ivRUUVJm/QgHE8IwYzZCpZ3P2jV9ch/BHyQMYDrHl1j2YrEhQPEv0M+QgjzM?=
 =?us-ascii?Q?pmzKKk6ZA8sg0oq/K1f2H9tYoYTYzTEiK5unO+Zr3lukORyAuTrxKNEtkK69?=
 =?us-ascii?Q?p1BdEa5qLQUvdWus46KEfUkMbIuylGeBHFPMJEDb2iYPA5uQzo5yiaVgFQIM?=
 =?us-ascii?Q?E8kLJV1nBrWQ7xne7wOvcbcxFqo8I9U71Fkh83T2ydH1lsW7kZEflMqg9SDa?=
 =?us-ascii?Q?It5HQ5tG/igzsAFn9uYSJYlVVMfWeEnHNn0rSmN2cmvbv0fS1L/uAAXnd+ni?=
 =?us-ascii?Q?B1S053KheXSghXS13pPOV5UUv9Ae3ZxUkEhTB7XA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oehIF5yi3+RP13tQQ63HZHRhSxxKQlCEXdd5qa1v8KijMFOYmjo3jsT4kaazYTUUgQjqkX5jt5enLEhZhyuJCyOilkTGRL/RkOV4L+Qt1Apd98+eEkXAN9pWJmIR5QXRpA11v4Vv5ck8RNVqVX1naE2I0JNotl+KofRTUfxqYi0Z8JM+4irI1m+BzOrK3yw63ZqO6whQssNDWoqDGcwsOHZduC0lVuzyhwuqy4ZanMp2h00jwogmHJwGTFj9kM1REKGxxmaAqWL1S4VnYtS+sZ9WHJHRP0amUaTff4l41Y6coQJ0DLI4mYoGEW3O5iZFtwzzmkhI/nFi4XSkn2LJXZP8W0k46xk/AWBKOc/wkx8CHUuyelzTu8W7UsePqaqT9bxoclyhKe0sVSdZAGEFD8cpRrCbwhWXXnCro620i2OxzVn5/7Cn9pNYnUlZ3fs0o0T6D7MyaOsyw1Jc4N/K1pm0ThQcvDWZmwCKrXM4CrtKkemZ9dDvOx4+5K1HJqnwbhNtjK7y+hJS1cBVETkMVlMc4sfs2LdY5FWsCxgl7cZbv2+CFmoGxtCljogr78sQA7yLy25I0GAIMgt16O1ZcJeRPvXPcT6FJ5D0EdMns1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00ea8ca-771e-4f8e-84ba-08ddb96ba068
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:23:26.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmSUUExdqDde1HkVnKbgwlL9J6SGnJ6KECJ08OwQ8hmHBNFv1CkUQ04T3QfSblk1h4dK0xW4QvsvtnoDJwq1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020108
X-Proofpoint-ORIG-GUID: 6Kdco9DD45fzDWnAhMudX_jjOMPObh-S
X-Proofpoint-GUID: 6Kdco9DD45fzDWnAhMudX_jjOMPObh-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwOSBTYWx0ZWRfXwSYJ5SXMsMTI IIYyCgOvvYl7bBCi6ZdlS3M9UfN19G5OezRCkzo9EBD3qFR3j/2yL+mYymb6Gw5awH+4PRkqGrY ocvTqolIUcQmfw0y98grK++3s2HXAi/z5PIM3bqEjRVSaajFU/yimr61Shcl49MjkdszJ8stxya
 9pNKtm+8PDvtYw1HVcd8B48yEUAnKc1AGnmp0ICat3nvaHQZPr+dQVX12rQcXBjqgkV5gCBgOIp bf3OQ2DYLE48uMXR6JzgWwrxnGEboMhzWyAC7WGcWKwWdAlQ1hlmqU6EbaF9CyQ+n9gDfJDNR6u GDgSvMOvK50K46iRRaFOB43BITknMvc1A1ufZCzRag0AfKeLA6OX4u6Xoer/lyU89fKCx5/THEG
 O9fDcieyimcfRPzOvOS6J530eOsKPfx4UO+QlODBxCrHXN3j+a0InhCBA9ZqoIHvBdLr7Kfl
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=686532d2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=YxqHlbMfpNV8wT5CiVgA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 03:00:05PM +0200, David Hildenbrand wrote:
> It's unused and the page counterpart is gone, so let's remove it.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

