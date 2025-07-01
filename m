Return-Path: <linux-fsdevel+bounces-53423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F4AEEF79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C43BAC40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0C125EFBF;
	Tue,  1 Jul 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ow427NrL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TS0gCkV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BE1CBEAA;
	Tue,  1 Jul 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353682; cv=fail; b=PTDdFEj8qb0YOAz8L01d5fNEYaSGWZXHUtLjMrqx3dzZpZHuIB27BJ6nFGepSk5AmUWkL0MpP65rByNy24052qqFVZSPh5F+6woKs98QB4UZI1mg2Z/C03Z01TUaBCHiGTJAI+hUkpzBtBTc3wuf97yI05dek1wMkS9wj163fF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353682; c=relaxed/simple;
	bh=EzWf2QPHrMmoLpI7p5oQNlyVrz80zktcMtHlgX5Nw6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZ2t2ILqhYXtZ7dUlOekpYzQdh7x/5Nt5/tt30FZDXXR8BH0cgd01foXRHUUdnlNwek46Ze8BuzYgb2hEPUbfcPQJeMVpMoumgzjAEZ45tQCgFiZYz1n3s3u3P5GKVsjLRZLtM6xCHOnZtZ8YCVep0av9/wpXuQdYimam7F+hws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ow427NrL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TS0gCkV1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NNOg006068;
	Tue, 1 Jul 2025 07:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MODSW25xETT7WVVpDX
	bcIDdNzoFJMk7kWe87wdFTJ/g=; b=ow427NrL+hIOaCm57xuJX3FoakYF1f1sl6
	Yd+pZazSYjs5PRHQ4F20pyBU4FIL45+fpZaUEIUY4doJ9c7qNtFSORZAhk04PEc2
	7l12y3/nvLkvWXbQyX5C27CecouHZqwMCSMCi4oqzuyAPGbGW8Fm2QddNGWfJGUE
	TrOav1kJ6If8WlSYLLxU+PDDOICbPPw4mZ/zcdOKaxXlmgVr100h0YxpPgAO9kLP
	OAWz/i95sTBZQawmF7TVEHCdjg+0tq9zdZHdtN4jAdn5ZgNShhV/0wNOum4gk8Ha
	ZC2qyijaTH57ULkphCNyx6MLhhYDuMTcy1sZF3O0K0FhQMYoe81A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704c2yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 07:06:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56174n61005961;
	Tue, 1 Jul 2025 07:06:14 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013064.outbound.protection.outlook.com [52.101.44.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ugm2ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 07:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsusJ9m4wq8KtLdkA1fqO5M+xi27v/IulyWntc6CGFyxQPnyvgOubf++fOaVzh57FS80eVOCpS1NZOSn/9dzulT9btjVonpXFONgRr9bGoGl6hhryDzLkIiG6odc+euQVsC9a7hYtinVTueroZB5ak+O9wDPuQwpgE5v3fhLQRTGdmIk7GNPhu6uOvlHMWz6snvDLll6sFLatj0+tslKZqhASg8Uy2smX5yJnxGKe7eEOn3rpNai0TKZcVxlZvdUoSGnOXQ86/p1YEXpwGKketev9RlI5HVR0Ghd70Fhab0QzjANr3zjnU7wy6nVieWZ/IvN0N3e+M6E6j3jqD0Kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MODSW25xETT7WVVpDXbcIDdNzoFJMk7kWe87wdFTJ/g=;
 b=iysnD5NWcBYHXnvArUYiXUnKfUVzGoRkOVnIXgoY0Fm9+QY9/ZJ4/Exz6CU0C0OhtwXQuFUZuTfbSG1CAEiH7TbWXgZITxTiKqCUsnVXjutsOljbbSYTb2drwW6UuKhFRoBu9GMXGQA/vl9JhgllgKlurDFMQEmCUfrJxoYeOJKsixFLKXdVOBvxu5+lZe12ebz6HGoyoyBtKT8XBqMM4krV1MEAikSWxJR4MOT6sAhVwkRNImygJxnfO+Dylke3zCirQxK5CUl3DtVWMI4hW2Tix1KhxTu42exFOBrxFHryq7bnVVlZaCpkPFd0N9kfYg8DfYkrG9+Bg1xljgbtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MODSW25xETT7WVVpDXbcIDdNzoFJMk7kWe87wdFTJ/g=;
 b=TS0gCkV1idosocTfGnABm6Q0FOTqfBBO8CrFMKmpSTJFoTc23ZpH2b2uIDcLaL+EN6r0XGa2rnX6wz7SkzkLzbKTjvwXmMCBulAKharHvF1tROZ6SqoJfXDQkpRAIuWLOHRGS4vAGxMwrLiC6itJ9j8RoJu0M5GQ1JAJqIF4juE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 07:06:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 07:06:09 +0000
Date: Tue, 1 Jul 2025 16:05:50 +0900
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
Subject: Re: [PATCH v1 09/29] mm/migrate: factor out movable_ops page
 handling into migrate_movable_ops_page()
Message-ID: <aGOIzkTqqcnMGDKT@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-10-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-10-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0221.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 66616740-bb6e-43e8-5261-08ddb86dc185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMV6PpYvP74i9jHoLiWvYEhQN6RKIcDsyoh2ExO5c7NyQAVk9DuNnqs2Ghza?=
 =?us-ascii?Q?rJ8d93LxkSLBoGU+f9n3XOXuNyKwpUhJ9PBH86RSPj1GhXm4L8AzhWl+Y32x?=
 =?us-ascii?Q?sWJmu6SQy/dKvSIKTtrDEbzjyx/nXxCJ/EqgkPhKeQU2kpftgUifi42RmyR+?=
 =?us-ascii?Q?kHUZ3QF5/BXivFV7CJUQyPL5hjKWKxlge4GtLsFU0UYkOrefLKInnNXfFjP2?=
 =?us-ascii?Q?5Bss6Yq2bgpQgoALUI7aPtjBkWbUmPTJ72p8jcuK97fNnXFH67FoyZ9qinXL?=
 =?us-ascii?Q?yq+q4LexujVV57HudgyIFghrVzqta5ElRw4viwi8uNMLNqwY7oMOoDe9yA7D?=
 =?us-ascii?Q?9Cp6sMadgfMNutuRyF7NNlJ71OkJeJIfT8x9hbxQkDxaMkPOvK2pSB7CseLN?=
 =?us-ascii?Q?NiLiWIFD0rsJQQsM70tofKFGs1AIj6JRjKT88eL4do7GxNtzgS6qA5FaqaWW?=
 =?us-ascii?Q?h/fsPNi6ZZa6rx9IoDU+rWbuGX1VUl/j+W/3hN50GrXnAibZHhUPuitcXDrE?=
 =?us-ascii?Q?yavpwpRFpp6XXENmfLMPgGTo5PuQ5VeNq9LVNYgc3AfZ6I0rBdxMaykPm5mz?=
 =?us-ascii?Q?KI2y3r5AwGQKTr4C0MOYQO4PAlFqy9o3N44ddXxFRUA8p1tHkm5eJDfLMoMv?=
 =?us-ascii?Q?wDEd1vkaAbHHCcAD8Or5kNOjb096HCt4YCQNQ7CWeuk0ZeGTzXNx+S7TH8WY?=
 =?us-ascii?Q?NO9ohQDNbcQEZ/yFr9pWGkJ0qKl6rbu6LAe97Vs7+MqytBSe6M5lPbmTcYaO?=
 =?us-ascii?Q?ZHlFf1XQC87a4QkvQrsyCMFg2M7lZaXTHtJogc/qaVAOa14R+v37T/HiePlA?=
 =?us-ascii?Q?c53tDUC0XiGJOB9+E6zL11SUcKWdtgvFPAMjTCVeNPAucoELVdXbzhLtmxjg?=
 =?us-ascii?Q?lg6bHB3fF0bzoAGHVswC/oro6OaLAP28J5SzoyfbXloLJD3z1LpbFFiqFcgk?=
 =?us-ascii?Q?PEWz6mRCz5AEog4h074La6wd91YO4hotCc6BAZnko0htACxi/sbxfr1PrJ7l?=
 =?us-ascii?Q?ee/PbKM5fyhovQSStBJihr+X02OUAs8Tq0FuEkUmdnvRYiHdn69TraGJWqaI?=
 =?us-ascii?Q?Btx3hWE+hgAlEJn7HpjtkSN9uOStgUsO83xEDtc3FzFARpXJYhhhno50deqA?=
 =?us-ascii?Q?F+6/Z2F/Fu4jSVmsDHltfmiYUgkgMxHfn9py/2WPFsMDKkMPFvAHp/FX11w8?=
 =?us-ascii?Q?00KbEzeC8Yj2TfcZ753NqWDOhKis3dAtbbZ6m1krCJgeOzGyOEpeXVc+c9XM?=
 =?us-ascii?Q?8a95xCpC0gyAG1ppbtOIZrl2jyiryyuZn+hQ5vVQe2P89OBCi/cawcy7FSHH?=
 =?us-ascii?Q?Tru3VljhcJEqnWk7ckD/GB5akVsl8yGGqLuW7XCmHUuBvAYOXWHxTZ82J8on?=
 =?us-ascii?Q?SgyXpzs6PENQgRvMoLXf/rr2YpLO+YjqoMUshgUlBtxzhEc87sFovGIdefc/?=
 =?us-ascii?Q?bZudy2KZ1Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnCLwZ1wgspDpt3LJpO72x2z86f5KJcfcW4tK+1s2hHK3xsbGWaSlPflPk1i?=
 =?us-ascii?Q?fV/Fk43Ax0wQga/2wFiszgvGIrHuzA8XBSCIcI+7Bjd4W7Elv3uFZ2SkumhW?=
 =?us-ascii?Q?iBaS7bHj1CirbyCodEtak1L7Vf5QyGPqH4ZM11md7rqGXmRojnjFa+cvxD1Y?=
 =?us-ascii?Q?62HlO6SRFz1BCsI/hfvrpDk4n9SSDzRh7SSAMoq5kU4b3qJvpnAH4df74nWc?=
 =?us-ascii?Q?GxvNknUumevxkUmppHY6wMgu7rj0EdVtJcHiDfghmU4bM2ClJhGN50JuxMKi?=
 =?us-ascii?Q?M8/MiWF+TIXQR6bAoJz/TaljnzpTw4JeqAjtULt8VvUdQ8DbbyWnM3fHNQzW?=
 =?us-ascii?Q?sPZzHn+jEQGCJEYzyR3z0w7ffoIZnLe71u7/CJlna2Hj7tWj/jH/DUdJN71v?=
 =?us-ascii?Q?Pxsu0/GzDxSdxDimYH6fQMqCpGKjtfJ0dLtKlVGH9f98QzSub2l9h4kUiYyC?=
 =?us-ascii?Q?j7HC/JfbA8HAY64FXS1GIgLHKdIF7y5vdi4CaMXJVKBab2JW1Gv45dmEh7ac?=
 =?us-ascii?Q?aPCbB+7YQKtxVdVUtApZfzXNgFObDyuv5X+PUDBXjNOC6yWAQlmVrVkCJAKc?=
 =?us-ascii?Q?utFIZBvb44oZ7s/GeTfuE77H4qlTF4k9BEOeNS3j+Mzxlz8b72G2LMlWKVe6?=
 =?us-ascii?Q?6y8bNsxly8r4tkSYIOe96FqoCQB9JJ15JuKn/P4WEDk46K45vr9mFiXdjH+u?=
 =?us-ascii?Q?tnJXuk/tiZougpLJeey2lfwf9NLp771dB6zPFNbreAtrJzaf6ebFJt3G+AkJ?=
 =?us-ascii?Q?1M8le0L+u0F1o9wx+JFweauc8PJf+XcifJ9DvaAYc8v47QUE/f8sEueaIyhk?=
 =?us-ascii?Q?rOUYt0KAJ9Nqw83FwhURsmfM2D0LfdPG1FXm9klUP6LDNCjmcDB58Slui2w3?=
 =?us-ascii?Q?QIoTMLi6nAK2E82JwYN2mY4LpqiU1ELz49XaS9Fr3qOZtHSuxmY4vvppfB3h?=
 =?us-ascii?Q?sXQjwkQX2KTevHKtKBU+/I6bf6dRYs2Mbk1sMz7RlcfTejldjJ4dczdMmE2G?=
 =?us-ascii?Q?UBxWhxD+YtFfzghrjEfi7Wc+GV0WbMer8fzo2LuTDN3GkTpKeCj3yu8FxRKy?=
 =?us-ascii?Q?iVzJ3LtM9xeKXH1JEEIb1l7gN4ZhQaUTCZyRdYkvqTohyZS4uKbgXI+5viub?=
 =?us-ascii?Q?cGk67OFoEURzSXpGAMJKHBEDt4Kkh8mTv3kY4LMmVikA7Ig4MfqwXs+nfC30?=
 =?us-ascii?Q?zA8ZJN2KHcVIpdTr74zNPUC04WCeWS+GGDnXpazSX8uHdTxrmMD7/eBzAouK?=
 =?us-ascii?Q?3P/SE0NqBBmUzHh7q/U5YK7f/SUSGHYTtgclbAOHyvYOkmwzJ9Rd9Ja/4ChX?=
 =?us-ascii?Q?cR2am9s6S6co7jqrYda8ERsj4RaMLL5xQA5tbSVKydpeNKJLGd2G0hIk/Dph?=
 =?us-ascii?Q?3LV+Kx3H/y/WCUWwUo+z5ZsvBzeM9ZxUgbHp1Ggd593NzjztK3HdSb5oVO43?=
 =?us-ascii?Q?76YS6yk0OXHcK3X9bxmSMznlsS7ZO5KCfbpS6reA8o+PcEUoMEB2Dcb2P51f?=
 =?us-ascii?Q?07TOHP28txTT695SUnnPPMjHZDtzzxkn7RkHBujZf0UKXvVWsCocBjBtO3q9?=
 =?us-ascii?Q?gIUfxk/Rw2SkIdmLIQxm5MBQSRVmsvXgd2LI/e/0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cyk+89hn7KVLPZIap+0w7jUopYHZZ4ChIy/kAr/gHpKxGN1lFntogjwH0uwhAouGGHLqsCUAgIe/NPVkOVcK1aJZD05J/twkjMqarBURl+auFIItcZ/N5nNx2LxJxrFkqAV2mIJLAv0/jWlBtiv730bRwgXgGv/a3zzoXaZv9CVMTf1JMzsPsBLhwHRkrqTzu7/wEdAU/eBlyjX47Zekkq/HIMzEGtaKcQCTOzHQ+pBm248QE0cqNimOjuOTOlK1S58XM1wGVex3mVEPQn6/YlJckkKe/hbeWc4wLsPbyE+dTRumlWAfMJaUoqNsqRRFgHQ+cVkg3W9aSpVuAKjnJglr8SZ5s8CV2Ukl0IB4tOVlsmIUgwR/fv93w+99uku8xj5cwOUKJloN4/mwrk5J1rpg5hbo2QAeeOVtaHt6k/2GrBPsIXh95FONI67DHdCCwpivM4B7LnhC6vKNTcCiN40Gukh593P1ArDLOAQLtTn900RdaLLg5ZtohTowrqaERmZRjlp5mK5NOb0DJEQzlX63uORGPGyXslKCC2hQcDGNMTGajbkqVvY9Fie99WxBHFOohSiSHbXFt3wqmQBxznLgW3VK/w12xSWW/QnxKFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66616740-bb6e-43e8-5261-08ddb86dc185
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:06:09.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW1Z3L61BolshTRUK++f7X8YxCEm5mkoax75ae5YiEh6evSYdCCPCQiccGJKUN+KpnXGczvpFOO+ZaCjbKpA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzOSBTYWx0ZWRfXy4BQztcxv1fd huMqUsnGYPV0KUyjXxYtF2ewDvo4f+iRXAzaafvBqYxCa3LqiN9fbxmfuKyml06cZE+mZpSWFyW 4/8x1ulbpgWrWbf1AejD3FUiBqWLMpJiAEXSeF5jlVYTfi9RUIDa4WL7983vcd2plbvz4xtLONp
 8EmF6vcf/uLuDEDg3ljJN/cAf6qgSK5dv7+Ozt9JWPgFRIIzi02duZkVnggHCUDU+GOoerh6uXQ 7jnhSgAZSTyIVex56r+noBwgZSUN8sVC+2UNbESdJzli4LtYRqYZRR8aURwDM6mBA8/u8GeOdgt 4lJLDyuFZo5isY716kotpEPPnzR8/vRGmZo/XNzV0sLixx6qUlHJJ5CjVFACmJ6qAztgN7rHnEn
 O+/VD2jVQoVd6U9y24F+rd7Oi5Cr/hhau1KgqqVryDVVdJYG8BBPmWn0E+Dc4ix3crLG7rIA
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=686388ef b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=1-t0BdaaWiMLI8sv3eQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-GUID: Ardp9NL8XWDP4PippLR39wreZbQo9yum
X-Proofpoint-ORIG-GUID: Ardp9NL8XWDP4PippLR39wreZbQo9yum

On Mon, Jun 30, 2025 at 02:59:50PM +0200, David Hildenbrand wrote:
> Let's factor it out, simplifying the calling code.
> 
> The assumption is that flush_dcache_page() is not required for
> movable_ops pages: as documented for flush_dcache_folio(), it really
> only applies when the kernel wrote to pagecache pages / pages in
> highmem. movable_ops callbacks should be handling flushing
> caches if ever required.
> 
> Note that we can now change folio_mapping_flags() to folio_test_anon()
> to make it clearer, because movable_ops pages will never take that path.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks correct to me.
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

