Return-Path: <linux-fsdevel+bounces-53647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C3AF594D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5181416AFD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E8289340;
	Wed,  2 Jul 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRHGexsA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VeP8+/Se"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1119288CAF;
	Wed,  2 Jul 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462869; cv=fail; b=UFqLhQ7iYl9JKp0G+Vh1tfa/bT67HPYdB4PTJXmSXUwDcaSt4hPA600LQaVgKJwlwddprLaoWpRlalnQ86YWgGBIuJEdq3/ndiPHH2f76fDwvfJa/WKH5xgOvfkhIdbSh1YJJcM8PnfOEUjO7WZOg9Tu1ah9Hx/UrRTQE2r/gIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462869; c=relaxed/simple;
	bh=Rca1Xz/jDuF4VcZNlE37CIyOJkWy/K7dFVWRHYaQQs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kw3kgWwLwAaww+lK72IT81Ql+Df2UH1vwYXKku9HYeY5IvWFE2UzY+S1WX6+MOshPEbLXRKB8tc/8+iE21YNF7qN3/2FnGfMdBPdPqx1j1ldBpqpw0dfr0tNsMzbbInjX0f7yDXSfpGk2zPnZqg4ohhLx4QGDys/yDpL9nrrZ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mRHGexsA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VeP8+/Se; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bis6N016811;
	Wed, 2 Jul 2025 13:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=peolY477meIo5l7CsS
	5BIzLuPezkzJfOiiE+v8tJu/4=; b=mRHGexsATA3EiLZDa7BnmOnBPudpofpTbY
	tr9ZmmNcBWNwIxZuhDH/4WYZiRSCanObau1F1l5leO74lrEVDXyURrwVzBz1t/Fk
	xLDVD653R2s91HacEbk7udYq/SwlukljEJYGsdoUsMRhGQMlaPaZhwruNU71d1n9
	LR2XerzNbaBsn4R6j+F3aYyN370zNIXBsKL6ldmdErxUu7km1ff+WCejvGblmy00
	PqtsA932+lMNbocsQ3Oh7M30f0in41N27XXN+6ZHiT9cJ2Eq4G7wWgzzs/D7Lr5x
	1nAYR5xlxMTnquH/D01lOTrtwzNW3H8SYDho48yp4AR4QDrUyBnQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704ey2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:21:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CiwCj033740;
	Wed, 2 Jul 2025 13:21:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub6y6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLDkV1pDwPnAeqnwp8ILEsvLzyjkdvSSoEmTkEHgrVUX9mIxiFhOcQHTmTX3gmmWBPTSMMAJjYyt7kJvdhfcOae1O9AM8uJhiDbbiTWVzqf6PVJTBLQpYv6rKOR2KLjmHm2HqEycq42gfbs5wP698vUBqBHBFQTiiiJ3UdDFNPheG46bnnLDGSHpOrVdku1V36qVN0eK0Y0Aq9HZboMvQ+WqzMg+Wq070uT5zqoAy0TSPTUFvZSZa0i3iRBZfDRs8ObAABIo+9jGgBxdYNzrTcXYErgmoBU1Zz6h4X7xJ+KYaUVup2aiRnOHqr5uVg1tBo4pvMHsswnmxlq2qcnAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peolY477meIo5l7CsS5BIzLuPezkzJfOiiE+v8tJu/4=;
 b=OVLtsA4MeX1yExuyED+1sRoYIUWqjuKhLprOV5P0TF7wHW8T3TtToDu8bsAaQa013437zhSfYTFwoCJShEPz76+4IDith3Y88+/xYf1Z/AnHV38BGCbpez9JiKwIPDf4c0GQg84+daECZs7WfwyiP/TVT81pGtP0Oj0VJMHjefAvhwocw34+hrpjZFvWsSNYLWijcf9pF2lNrdPXB2u60uuST9H484a2STu6Jbjj/vgIzKHspdHqXLLONi4z2Qq+Ufp0lsI1TyfwybH1rFbyuYFwQYKWqnMfBbVuV/Bom/tDaCDrV6COS4GI/468JTVXCHS0fllb4wcp/uxQHBVPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peolY477meIo5l7CsS5BIzLuPezkzJfOiiE+v8tJu/4=;
 b=VeP8+/SeO6ILOK7cA3jMoRfJd9puHpwhN8rvZ0rzAg3XRIB2B2GLk944XVU92qPVFFTJIbEI8i3VraD/QOKbXz8qgDpx6j9lAtjRo+Mmw/lH4vl5iTShBat7izq7D+VgA/vkHmTB2n1cO99Rfwm9HU4EuSulBV4GuiS3+o1FzJg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:20:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:20:54 +0000
Date: Wed, 2 Jul 2025 22:20:40 +0900
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
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Message-ID: <aGUyKDvhT2WmhK7l@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-24-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-24-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0114.KORP216.PROD.OUTLOOK.COM (2603:1096:101::11)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 816c1439-ede9-464f-f95a-08ddb96b45f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5v1NPXAiIdpANzp+3p0LgYFA98/huOZC8W3TRMWCqXE2obfVSFOdjK8ebbkL?=
 =?us-ascii?Q?v6NBz5+qDQjBTVF7GWFLOSDZJzFOKToipOxQv+3jb+sMBCWmXiP/+x4bjNCx?=
 =?us-ascii?Q?5qdfGeapbIK5tHUASMpGNv+NYRyi+6dphXg9/6iZB59xX2+5RKNNdxoQqoAn?=
 =?us-ascii?Q?MjBvxo9Jz7oDS6Lt0NVIyvmfVcR8nBpwldu0496McS6FCqoaK3BS4KIl4irO?=
 =?us-ascii?Q?a7nH8AyXwAwM+bHvSerU37DSSU96iyVeA1YH+zJDJDVAIyG7PQdAXsgiTA6P?=
 =?us-ascii?Q?+P/fqL3jcAaoLeoKcwErOkuyxWwrco8gVagpeFpcv+KpDDsDowWNHeRASMNc?=
 =?us-ascii?Q?cl1L+MGloylkVLyxE9TTBU9/Tm64vLW6WimRyxa+WHulAK8GnbN3RRr1jqvJ?=
 =?us-ascii?Q?NRSIluyVgZ/BOkHIHPrzB0kJRFMamzp6LqkU77yyO5D2tw9G/vJUJ2V182oa?=
 =?us-ascii?Q?tMAiEve4Eg5syD9B/IgeG1RIKMFAWmRat7CUWMnVv77aBsFgbW2K9/7PWuwq?=
 =?us-ascii?Q?VIDyRSM6CtJTdy981pf0nMf+BY8En0lyztvzDxHyN+BLE1/xe+/qd0b2K1Yj?=
 =?us-ascii?Q?3cqCYbYtgT3IJPQZNEjsiiE6wQIDRKZ8yxMieaMw+uLeltgVzS/lB/LfQVls?=
 =?us-ascii?Q?vbgLgKGNzYGEegqNDoN6DMARGbEKbLsSgYfIT1g2DxDbOBWrQ6sSgwogvoRc?=
 =?us-ascii?Q?irOGCuUy9+euh51bBMiK1oLwaG0I4zJd/TDnIuZA4coZbFrlPcL6Lxm4qEhR?=
 =?us-ascii?Q?t0jDaJZHHAe48o+5o9paRBZ0UmjygJq95l3zzXWl10FV628YwiNXoQxVwzL0?=
 =?us-ascii?Q?eqw3psrxXC9nT5eoVvci9tMlXCWWm8Nt7LxakpmeAC+K3z3iLSdLtvxzOPUG?=
 =?us-ascii?Q?OIoH1pdGPK6tx2fRmbTrSADHPGYsPNisXq/bHa4o9aRguPxDptcNMUgDsLfE?=
 =?us-ascii?Q?uox/yeREEvq65vuiNbaCdU/zJWLMjctOs2cYE081W+8qDLYG1gIZphostHdK?=
 =?us-ascii?Q?Xi6Lt5o3mb4O4dwAyHzlQPQXq/x3LmUtzPVZynDc1NBNhx3JZKZNvB1iPBV+?=
 =?us-ascii?Q?/Dmr65DFnZ2tfj4luyqhG5X/VDP29+k4jk8wItm6t1vziQUyAOm7pOnWhBVA?=
 =?us-ascii?Q?KhYFU0DzmF6TeyDFxgkBaFOfxu2ECO8MI6poF+6jXR4whX4NxWJ4umhPRD3o?=
 =?us-ascii?Q?v9V4CYfOQkRcngquMNcI4cSu32NOVS/nU9g6QO+aagfJc3HRZ/1bbQgzUtKE?=
 =?us-ascii?Q?ksuH4up6q7ZMy+iHHD2KsxkYIrUrGRd1O3zuloqnfFhenaO8nWN4SiAg72nr?=
 =?us-ascii?Q?40UVXGvL+KU4sBnz/hPuvHQzXyshNe3l5bPaHH3VQLGkwtn6uaiJtWnDbDzv?=
 =?us-ascii?Q?3oXA3iU5gA0NH0so6YKN+L0sDWPFMzYrY5C9dx+jCBqzf/sut/Q+b/0WMGe7?=
 =?us-ascii?Q?9FIUPp75x20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7hmPaDnOyTWHU4e5tY03rHieFWl3nt1Vq0qL+/2HIqPPnuLW+qV4y2vNxI5?=
 =?us-ascii?Q?pUwdBuscg5da5M0/2083btr1saSOV16rEq45J/emmskZAYUoa5XG0clSaeGj?=
 =?us-ascii?Q?l0YQrGBS1HhGkkz3TixucMX36a8icHxKWrz6Zl8QVVKVru2oF09DII6YJNpN?=
 =?us-ascii?Q?vkilscHQSNjE3e2K4TB5+zDfMkLLioEBO8FziiBVzKXY/l5GHtrNPptRidEF?=
 =?us-ascii?Q?5I/anLal336b+NS2lWSF3OuXy3frcPkB+8MOmlpIM4ryyLHyg9yLfhNDupf+?=
 =?us-ascii?Q?Uhr8lBYJzz1ODGH8VrHP254JuKA9wuvRzof+R9gXoTo1cxekjklZfTNrEezZ?=
 =?us-ascii?Q?sq+UW6flLMvD7GlEw7CwyyEDToNl9QKWaY09F4wfiQtVrTSjYuNPOqtoTqOZ?=
 =?us-ascii?Q?aHjqdeUkJk4F1A9EZ9ThoPYvCK/Bq02KWZ7zzAuNmfcXr/PYzwOqS+7PCmNH?=
 =?us-ascii?Q?IWkPknFpVjWnwTVLlMQFU5ok5huZbHfo9lY7SSWzmTIF3PP7SRrl2BxjO8AV?=
 =?us-ascii?Q?g58VpvqRE2XOjvOt9IA8tCPSqS+o5Ap0TwUHcxl6fiFyIr+7pLmzD3ZyS8yJ?=
 =?us-ascii?Q?66hJdh138eLRMOFywjcCFLnNzbAHbAfNomorVCFUuFFlc+wvLKOCvf69xxae?=
 =?us-ascii?Q?bJwFYUdikmaWGJUcw/PldmyYrCmOCz+a4/fWDuQvwesoe8nvyjrDhbRc8cJL?=
 =?us-ascii?Q?18WVDCJH7swqYBtW36Dv7Th2AXOb8k/bJI1gq7I+G7P8DLOztPDKe5tV5N9y?=
 =?us-ascii?Q?wzIzZjOBvlxwngkAtw8AFKmZLa+ORqckCJBRdFc8vC1hOhiKbAsQUjre6vm1?=
 =?us-ascii?Q?sbdnHnd9NRpFz2VhiqDQjQCC4hVgM1ZP16dTZGc8pRmEGonJ44bmbaCfEjUD?=
 =?us-ascii?Q?WYVOVZrSDcJUiD6eObWXyerLCSRT2Xu+3qyrzp94UmI0BJltDKLxDLjBlXov?=
 =?us-ascii?Q?JgjMtSDITLkHPF7TyNbaHgysi+/IHlf20dv0O1V0rmGaXo0fzWsWquptm825?=
 =?us-ascii?Q?7Lo29MpMGG5oPiWPBMc8E8fv2/PkA80nfFaHLQM2l0senIkEAI65Y3kageyz?=
 =?us-ascii?Q?uNKb1CJpHFTcasHKGLMhcaBq7s8VqBRLRBL0e7OA0G/PGxcFT/Ax9hCI02rH?=
 =?us-ascii?Q?2jF4k62FLvHPOFYn6OMvvWOh8ImsgSZhp0W859Y45wTkpoFsBIuNF395NlUN?=
 =?us-ascii?Q?UPIC/zlJY1rYCPIBXof292mBBEaBvEuxzirUUkEiFxuyiVRsFsW2+PyfnZJ9?=
 =?us-ascii?Q?mxl90oRKb6kWeXmeXpDRdkgsvnXfEwFeSmqZTOb8498snY1wtE3NQujW3COq?=
 =?us-ascii?Q?34r7b42fMB2upFupCwQRK+WV0FYuT0U5IsV4twv74byMi3VqeUxoA5HtOIyy?=
 =?us-ascii?Q?NNlyhyB0SwvEmA7YReQxz2tuEglgz6QY8maP2ZeiLqzI4fzts+uCvL4Gzlhn?=
 =?us-ascii?Q?iilQomFsjEabfT2Tfc0pOev6GVDg55j0WegxSZYjvEGcuIBkv0kWN2zrjQGb?=
 =?us-ascii?Q?rBG+zTkYi/xn3avVIKthyNSfdU8jkugNv/z9xmxdYxq8UlGZD+ztq8Qjz8DB?=
 =?us-ascii?Q?1Lwq5jIOq0LNbMV5zjxmUzNDDJpdvvD1I9QadY/j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DY0NR3oU5kpItm4SbkQFJf659L20IblwXc3kLngfTLElq0UsfXsM6WrFTc/IJwOi8udkCt4GB5XjFHTr3oCIKtC3JJkBpWm6m6F9DvlUENivUcCP23zh4ZyYJ9c3D+C2hcoy2FT/bFTz8NkxLwZFSQfTE1ExCScfXGCrgUjjiwHJUsrbByK/BfOhC2EyWzd2F8e4Q7SNNElFAZ7aGhzMnr0c+TXDeHwdWJ3a7wqzAOLuDDV4Slr75heNbSkIt1+b2vzvVhWuFCisX/0kF2+9Zq9YLFutaWE+iTITKDOi1vdWbLYd7IQMTjyLRuS2xsQyqFd9oNKIH3AHtdadBXP4zP3O4NX7DGqwyOANSsqd4ynla5AeyavLDaf601hsIHInIxusSEVDTXLHE3UR4nNmjUS+yX8L54VukwvFn7qqMk5iJXvyx+mlaW8CStCkVU+Shkfv9yxfQ2mPCvvLlrOmzskKIuX4Dde9o7aNWEjD4qVNVmqY6klB+OYqPC8Wndj/q+0niSSCqP8VIzs5LoqumYqZ4KU/59VhREds/frjYnw2uO0SOKtX4we35KGjjSCxFWv7SNW4LRqYh0eQuZzP+4gohTbFLLiu54mgIz35ukM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816c1439-ede9-464f-f95a-08ddb96b45f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:20:54.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwoP2B086u7Dk9pWfsnFbdAm9MUg3LrQq5dUfvUigaBta0yFnNcfdW1kwbI3PIWOxmIT4LcxIcmIbneFosjrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwOSBTYWx0ZWRfXzwQtOiHAN72+ TbQAezI/uk8tcNcMYg5r/RBP2AHM09XTcUtTet4Xv5MCDm8dr/Caj64wsPSg5hOj3rP9AGTUvOh 98L6VSdaz2ZnlTNZA9xD7C5rJl1kT12DIWjtqDoo6MwFujv7xsnUlVhxEqcGE9PWk6mxR2DojT7
 C2M/BM2Hw6HRRJr2XsUvA2cGqbZkSCA43nc9M8MX7rEmtMRFSatRRMcfhlhEXV9nzntJnAyzGrF 0wZ6Urx7xXkUNpdKm3SKdp1xe9/l/9GDhP72s+63s2X9OjJwpknBwLEf0S5WuEgOJYAoJOzkyk2 0mTyLzLTw/+2c+8GdRIe7H4GWPhalGw4sOSr3HoDdAcGeLvNhEFyDrX1AISOPTNvfEt9ybTTgua
 Y4ewfXBJbfS7ivvzcO4zWEVLJyoH4tptYPdA+lSRSRBtiJkPqOLiC73b6S7BNGTTjNwiaCdr
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865324d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=2SdiS_4kd0qAoxTAw9kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: x0rgR1eCuC_bYxDlcChBl-tUHT7oWuHu
X-Proofpoint-ORIG-GUID: x0rgR1eCuC_bYxDlcChBl-tUHT7oWuHu

On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
> We can now simply check for PageAnon() and remove PageMappingFlags().
> 
> ... and while at it, use the folio instead and operate on
> folio->mapping.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM,

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

