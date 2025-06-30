Return-Path: <linux-fsdevel+bounces-53372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF02AEE251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D5E7A6304
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701128FAA8;
	Mon, 30 Jun 2025 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noSEuLPV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ILSRFAyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF428C2B1;
	Mon, 30 Jun 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297070; cv=fail; b=TA/TUBLC2y9KZyzufNJohFw+OPq98LXcXAEgP3D8AxVGA/Sc1EwHR+el2ymtG29uD7/skMgrblpcOPv9cclrqYBJ622JgMZe+qdUMwNFP43ZIUkHsPuzKvPhol+CrU915nJe7W+MV+Pk5rmVgoG0//Ghz1zpltMof9jBXFXNNBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297070; c=relaxed/simple;
	bh=zWecJbHxTbg1/bH1kaVu7SrzXjJrorTfKbfxJMAioWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OStqnXH5ty46to6pfhngLjlcjsTY/9pK6F5+ufLe9rhakCIWU1ldukaeQeGqahgLoimaoDIxWB86TNsdyN3mxZTsf6nYqdVP2ZmOCP6lAY8Kwa/kXorHyXco/jHbz2M9ZLh4M/PRubTP2Cg/MwqtQQOADF7lNZX8rQ2M6bKE3TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noSEuLPV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ILSRFAyn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UElAq5020137;
	Mon, 30 Jun 2025 15:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qtzBvvNhKjJxGcJFIR
	E3kK4dLNdItU6NUHq+6o7O9Uk=; b=noSEuLPVhOlGu9KYZ8OX3nXOw6WQNrnEWx
	2Lxcr75MpDD4Aj6v0hPkxMsBiCFnwAO0Pb+X6zzk1r35+lotucJobr4AspNsI4To
	KpanbUwIdXGvHxaqGO4e23KBTxFghCh3sdQgD1UIHIvI1mgqut1IHho7Upx7oxYf
	LYzT3PNt8cQk/9P2AZex5cLYDo33BuPcOWPNZsmA3vZa+uPJ+Nv9Ou7R5eUNW8Tq
	IgoU9Wpe69ILjeaQdQajJdo0bFCaJySKtZWdzz1mZC1kS657B1eIS0VsBDEBOpXM
	gKQxvdyIrRHTpb2r847F+IVp26//OBsQ/yjuy/s5QUOKGZSJTS+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7t2t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:18:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE3QJV009072;
	Mon, 30 Jun 2025 15:17:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8g19v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbEvPiPbFr6FdMss5HVvobpYI8RI6IPLfktamMJEshq2JRLAbOOoaiiTXLwKARy5ZK/Bh3Qpo264iJPDOXZt6g/9Ljnaxh0tN0CSyKaWTc8ZPP4KprI5ufYUdEhXFcDftBAGfHjHcFHKMljXcRKiiqqR27dmC4MswU0E0I/Pt1RHcll0EC9qrr4ODBBJZyDn18uhjUaF6oCEGp7gJ1hs1AFap07a8wUyF8iPl+ktyW728dDwqoUUAx/k4GQToJY7PQ4O1sDk6vPOxnT9dwYmrIS6mDNZseG7K8bH8CfTAYT6cZLxMcCAmZdC593Jdh2z51V5O6VzLqSszmWyog+62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtzBvvNhKjJxGcJFIRE3kK4dLNdItU6NUHq+6o7O9Uk=;
 b=CPWL+wNCEQ3xyI/qSMrez99y6bM45hIGnxKaQKiuJZuwjzGwILWPy++0YAUkJ992rv6tkZu+wbvw3FpnBYJBfqO4K0z3fECm24kuSRuMAgZLlXWCZ3ie5lzOUMvPqc9HlTXunlZqqEZt7h6xwb58UbxxReMPkSlTsjgrlEhX+dGrbYtnTKC+V6l++89MDEdIR7MUVfIp8vWJvRbgxChX5nf+BMPkOpWA0bl37ewYdAvPfXN2w9rxNWt1r9kntqeuYl5Ujx+/Us38H+7IQORkupdFsOPk+lUeaWfhP6Rg425SVqGkNeE6GyVje31vLz/la1SUp/AjwLYWFOAeMs7stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtzBvvNhKjJxGcJFIRE3kK4dLNdItU6NUHq+6o7O9Uk=;
 b=ILSRFAyn85SN060xUSkznd/wHF9TpgdELQB14BkDHoJR50v0TtXt5TTWqqCx+kjrUvjh+3im0gw9ynWvYBz2RtTkr55OObHr1qphUwj1xepELHpH/dves5Ef3VEqDqdJsYl5RQtzKTj1XiBl/5oysT9wMpZRP/VmDKaoSDebphE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4219.namprd10.prod.outlook.com (2603:10b6:5:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 15:17:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:17:55 +0000
Date: Mon, 30 Jun 2025 16:17:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
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
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Message-ID: <ccc333aa-46c2-49ae-8d0f-ffbde95cb22d@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-4-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-4-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c1c045-5b2a-4b69-61a2-08ddb7e949f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blJHNrFBGBthgLPIvVlPHL7ifjl9i5pim7MWksFOMtBCu9sn62lPfphlJMn8?=
 =?us-ascii?Q?BQapaOQJsOAuWtbT6zGayCMVR3jSEZuyFRL/dAS7HybLsgWx6X/RgwCi6B2+?=
 =?us-ascii?Q?DJ001DuxR/B2zAcDWxWOLlZcg/TIKeYkJ7MsVMKS4uKYIgyetvDVMFNGD229?=
 =?us-ascii?Q?IFpI/GbAJv8WGIcmdlANax5o3XbctwKH1MZ+4Lxl9s1X35w4zZEU9vyEJhnj?=
 =?us-ascii?Q?LmTx17lRQH5g0pmrKav0JoOqbbo3oBIvZ4Omi8Mt272iejJgL/F3GErdXXE+?=
 =?us-ascii?Q?p4x6vAuIjKCqZHNZ6hB0UkPQR9zxqhVlQVYts+3sbsytGwA6cZ2qLSDbnQf4?=
 =?us-ascii?Q?ZSrp34eS3CvPwaOmGfXXdHsJvkvt2i4EJoavHeEnZ/p3Q7eaKPqu/Lh+uLwx?=
 =?us-ascii?Q?/PJZ3Qlz6OiCCJWWqc6T8jWMn5xdhPVIQF1eJtPlUDQ4cgcY74tT0t+fjg/y?=
 =?us-ascii?Q?fE62bVilGi0hjsVn7hzTTg3BiNMT0KinWpIjROT9Sr0J3K8r3k19MsxZ3dlt?=
 =?us-ascii?Q?7pUm1DVI5kMC9HUXUqBCdJHl006cOEPl8rd7msJpKs21isXK4AOvDwalp2Jq?=
 =?us-ascii?Q?D1njer83Mv951//r0F5wsNCv1b1S33P/B+zdtYBVXTZ8mrj10fvikrMLEo7w?=
 =?us-ascii?Q?NB6+EvVnWh9FZn9aeDM5dSL3wCUdk5DZAEpYaMSt+IT62IeQWlu83rnPur/6?=
 =?us-ascii?Q?ZCpz97LmsEs/kWXYR1JpwxhpJ3ftK1kpmOarpIyOjC10itGPyApQdoI3OerO?=
 =?us-ascii?Q?fCvsgtfUoAXIfZ4SU8t/uAFYWviSEWjgF1QlKPiQq2Zx88Epa/eXnAiqqmt/?=
 =?us-ascii?Q?wA+pBF+hHBE1Sg36QUFsWBS2g1kDaeuA0azwZLj+lN9/ut3tfyUNuIBKmkBu?=
 =?us-ascii?Q?RqSRY90oHJUKNbQ/FmrQ91CDTcPl1E/OS95HZnY6+RHEs0BSNk6vej1tJ8p1?=
 =?us-ascii?Q?MbMfbhm7jufVu+/yBa/1cfu67agSe8qLxtYaCOb8Zk2+M5Y9T29U+Z2+6PY6?=
 =?us-ascii?Q?9mnsw7RRgeCpyNQ/BXe2Zb1EBgcpqgM2NXxj++ItKJUSV6yTktqFGo0IEZHV?=
 =?us-ascii?Q?/RpnJQh+KnJWzwJgVsEQNW+uEneurBi+PGa7A+NNCvHN+HjrUq/qPE+zwFI3?=
 =?us-ascii?Q?67fXkoG3ruhRhh1lhCriYwaNHUi99YT6YlN8/mTTPUHpfCfMHlS7ewhN3hha?=
 =?us-ascii?Q?RleN+S6BSTOKQgyMNDyqhNV5MzU8FSedP32nor+EVKXh9alU+IhvD+odKIUL?=
 =?us-ascii?Q?F1QckrzbkD6IfzDFmpc1sEt/vExx8SH8fWxhoa6RXLoZ4vNm3Zq43szJZhdu?=
 =?us-ascii?Q?PtsvB3RNOs3MClyKmf280NnAj+cmMotT/aaedNfxbmrFa2QIU8NHbCNjSKQY?=
 =?us-ascii?Q?48keIWvfD144Th2i78zW4iVviGzv/F2xpWXd0+dHzv6DTecdPswicsxDOxPU?=
 =?us-ascii?Q?EoC7Gmrnoe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTn+GKiJjBGt4SgeIpbFxQ79TUMUGFU5OgOyT2rfAbDaAcZbaZThyrRJXG/K?=
 =?us-ascii?Q?iOMcJmcRhtXyX4fN68mFFIQXBqpD24k2dry9+AXCRtkbUGaXLb9pByN8VbSo?=
 =?us-ascii?Q?0RMs1DVg7+3eg4DNUikxiR/59EcEVdQyysBbnD2g1zL1L8pJxcdXC+2T80tD?=
 =?us-ascii?Q?U/FHrJyAwlH9PjXsnVdHPmQmb3MUaYEP+gAAFb7QVxVsrXSADoZl3CtUGfyk?=
 =?us-ascii?Q?+F09FPYMD3zyR8eG+aRLVExJ21R8315lKfSM45W+M0q+83khpf4KBJWqGjD3?=
 =?us-ascii?Q?TjCXFPYgw8RW4qWLwymIRiqIjOCQt5Js59NDulv/nFkq3IsmYK8Y5CXmn8ov?=
 =?us-ascii?Q?82t8eDF4bcgsFvdE40gnuLJ/Qj1Po8T1kTLv2CTxrWnc2XtxIB37RsFYQ8BF?=
 =?us-ascii?Q?gDVFWKUFmPxD1OoK/VYVeIKvNwQ6Wa6eW1n5LlgalHC4Ds4XQxAliFAe6z40?=
 =?us-ascii?Q?9q9kkcAs6w4z7vRztrx38NQEc32MWMxUyZvHsvPK7fGRzPJo67OhwOuvq6r5?=
 =?us-ascii?Q?AFZjgKrv+nKDUUvFWTHlUmzC2nybApeC6/M09MK/w1kipzZR2mZX7gJWyHw+?=
 =?us-ascii?Q?946vF47FL+kUByGKFcBJtN91zxJG9RYcx8EDVmT6PlHU24fGEuzsnvqMQOi/?=
 =?us-ascii?Q?JJmUma5tK8EM6yu5JMJp1d3lYycAOqkdPxYidEnplKV8ZYAKS5aIhxXzcRrc?=
 =?us-ascii?Q?pgMPjwwpfE37zFogoqRGbFRGDGPykXFaaeW1b/DvNUe1kxyffqKrvX3fen5x?=
 =?us-ascii?Q?dqIAQT7HE8hZCZFAP2mXJcUwNAmdTjSCgBw6KGWcPCFZ56LH5akK9xvaPP0r?=
 =?us-ascii?Q?kwdaEgP89FXteuvxXNC/vt+3V0ifgYUCA2ERsbWnO+RN8TCqizuZ24Lb8rt4?=
 =?us-ascii?Q?oHHokKbeTXLJpWE3LjehPZrsclbbbX0iAmpOsEwpR1lKldCQeLJkNsWM+Brp?=
 =?us-ascii?Q?IJoSvTDXJm4gAu2hAqAKxGS+UQTGyIr5wmTu7IcJXGFAsMv8gkI5om6oK/0c?=
 =?us-ascii?Q?ayOKzEWViMi7OKOooHaei3x15OkcXaDo+IDgYfGafKQuv8NFBvHp6iRv8n4Y?=
 =?us-ascii?Q?yGkLfgCNGdpc3RjieqPziaCv4DBI4htNIl8w0kAVSA8spdwExXqfgoYUFJnE?=
 =?us-ascii?Q?w8VPCPkzWQg+OVT+Hima7lU+WUeZMxAZqGx/aZ4GrV3t3L1tkfYxWV0v2iah?=
 =?us-ascii?Q?K++ABhOcTx1Je2b9DpW+kDRZxZJ0ThBH+2fQwWOnhQNfQQ6skG7cag5YqbHk?=
 =?us-ascii?Q?pjMoA3j8MtEuevVPPJg+j71Tt80wHMsNzyPGun3EDObquz6RTQtkMBfGD1lF?=
 =?us-ascii?Q?DdeyAB3ABkCoYTMAu0N4uaqadCjzS668ZRL4v1ucX6FSFCVxxZuqinmad6LY?=
 =?us-ascii?Q?cD+a/zRijRANOwWFhBTYVRx9Y8MZxUSWfl12dPpAXdwn4uEypJ8vMa9kr5/2?=
 =?us-ascii?Q?Z2+xIrMiIoYDBipNl+sM1hzd8FFILl2vO7J/KuIDTDIGj63FD9VxTwOeiYiU?=
 =?us-ascii?Q?JTZdJ7opT33UwGx7XuGda9hYZ2TBRuAYEL/D+qm+lQiIsOJ+lNsWRGq6Nw4J?=
 =?us-ascii?Q?ibN5pK3mywOXjMVAYngzM4oook4lIIYDMT+ZLPRv8Dvm3nqzZCDk+uBmvqt6?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HJQP0RuCJ12Z7uCkVtBqoa6mFCOJup153adKH3iPDx2X0w7V9bLR1bCDgcp30IRwlQ49Zc9QerDcyKXurNoHtARROiq8sbYHikn8BURPepU8+xq2Oh1MgQeg9HNkVWXQSwXMjlZZ/VYPa1bxt1qMQW44yIXFR+6xf+eAPDx2s8/Kx6jJv25a2Gupgpn+ILP4mGXuH+YhAieQTVOWGRBHWOSn6RSQGwAn2yXyeSReGokEo0GOMLxE21cjmDRx253TUpOTB5SmoB/v3D9Yz3T87rMRARV3fdO/GuyTbos9E+8mUCGOItet3DsCiwnqKcSX+6cGYn1t7lb/w9esOxRzqQ7RyTZyhCtkat7z2f/pg+qalj3DET3ci/GZFky3uAtUg0Ig+FUi17QLDKAqhasgHDFQfNddvBnbqUkwsbiDvdic921ICz+1S1EIX3ylj0LxIZgiTbRvib4z1GHqnC34juePy/RuB9+L3ZCXZZsy5YjCOxtxHrYsMSXDp/3g3cP7sZf02jci3NXeLIT5vFWo9Bxeey29pxNbs9i0oMO1xvH4D9L01NJI2hh0hLzExP/4G6w3y48SDVSI2gdJN3kE5BbVThEuS+lk8MGG/D9vpTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c1c045-5b2a-4b69-61a2-08ddb7e949f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:17:55.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMSDZot3SXQSZ+/d72PxPa4Tyy8l8MxkQ+eQYvhEFo6ncv6WsGVIb3u/mOLTXDTepY1IfR37di9c1niLdUMpU7Nc0ZXL7IFQONnDuA+L+HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyNiBTYWx0ZWRfX/+XOFYXShQ3M DrVSIldYMb80FmkPdep+TC3I7BOebHqF8B/oLzZrUZPYaQbZyzl9nWPP/fiOyH1Z6yjNRFL8NKi kotTvh+f213qDU5J0HO/3hRr8aL6HgTQHA5vALP/JPQpy0u+oPdYm4RMrduJRxPQQj1eKM3ZoVi
 nqPv9geMKUa6/FkElLNROE84QoV3aM16uEDlV0xnD8nBa4ewT/Tsv3fWpdeAizqav0Clm+TIsXG nwN3otfkxcCMVDqW0BmtlyERZGENt5to/DQ/LUh1340oHS3hLq885npNvb373hUCxBzmwuzEVV+ Zvuji3lcqBioB+wfDupzMyipXPxLwo3k5zghdefgjfW4RQQd99sy6POl4UhQITd1p9nPJMlOHrl
 Y8+tzq/igzwvxFXLkL4Zb5BbC0DACFAyImBFFmGPJRD7pW/Tz7dvlOZRvGmnky5A8+Vx5gvz
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862aaa8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=cm27Pg_UAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=ZkVTOE4x5hDWK6vl1aUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: TKRMaYLVLgoX6V45NaJl39ofPqCHo7US
X-Proofpoint-GUID: TKRMaYLVLgoX6V45NaJl39ofPqCHo7US

On Mon, Jun 30, 2025 at 02:59:44PM +0200, David Hildenbrand wrote:
> Let's drop these checks; these are conditions the core migration code
> must make sure will hold either way, no need to double check.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, one comment below.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/zpdesc.h   | 5 -----
>  mm/zsmalloc.c | 5 -----
>  2 files changed, 10 deletions(-)
>
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index d3df316e5bb7b..5cb7e3de43952 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -168,11 +168,6 @@ static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
>  	__ClearPageZsmalloc(zpdesc_page(zpdesc));
>  }
>
> -static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
> -{
> -	return PageIsolated(zpdesc_page(zpdesc));
> -}
> -
>  static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
>  {
>  	return page_zone(zpdesc_page(zpdesc));
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 999b513c7fdff..7f1431f2be98f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1719,8 +1719,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
>  	 * Page is locked so zspage couldn't be destroyed. For detail, look at
>  	 * lock_zspage in free_zspage.
>  	 */
> -	VM_BUG_ON_PAGE(PageIsolated(page), page);
> -
>  	return true;
>  }
>
> @@ -1739,8 +1737,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	unsigned long old_obj, new_obj;
>  	unsigned int obj_idx;
>
> -	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
> -
>  	/* The page is locked, so this pointer must remain valid */
>  	zspage = get_zspage(zpdesc);
>  	pool = zspage->pool;
> @@ -1811,7 +1807,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>
>  static void zs_page_putback(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageIsolated(page), page);
>  }

Can we just drop zs_page_putback from movable_operations() now this is empty?

>
>  static const struct movable_operations zsmalloc_mops = {
> --
> 2.49.0
>

