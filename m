Return-Path: <linux-fsdevel+bounces-53310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3AAED6A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E3F3B28C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2181238C3A;
	Mon, 30 Jun 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="To/KT9Rf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="whC+UTq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E01FDE02;
	Mon, 30 Jun 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270761; cv=fail; b=hmhk2vuF5YD2DgnlSs3KD7q0/6sz39H5DEkLRu9ezkQZXfMq27uuSmlv4D77a9Q79WHmFWZrDLwPVPPEz8+MtBaYLZSsNaEDjFlrgCNLwfwDWKIQEUiWWaWbiE28CeyEmou4341kQirin4tpVDW6OhzEDW/ZznHIBvUkbqbzCs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270761; c=relaxed/simple;
	bh=gDdKvzE5ZVu/37UnmOg8vBtBiRTwbmKDfZk82G/82pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLnmEM0f5McJFULy2fwist+0vXx+9SX4MhfHe0vFgK3p0WNpbA/BShKeO2z2L4xhNevRt0RugHx8rgJ3fMMJ3xv49KcoOUObSUD3T+ZDLJ18Jb13rSjBmA3HATiRrzHW8GB8qJuhqGZogkSDHQDzLp3MXmjMA6tuep3BY8VOBds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=To/KT9Rf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=whC+UTq+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7thAL015740;
	Mon, 30 Jun 2025 08:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nhqeIp2P+YVTxBeFCS
	VK8CgkYLQ+lMXJo3Tb2Nw3cc8=; b=To/KT9RfjMrFz6MiPbNOo278Y1rvlj0zy4
	FOcmKlNEQ10cEs+FKTIEUWcz6ZdD6ofNrc9/tA0VdZjdLB9SJ0j36p11E/Wz1Asy
	rqtnonLeRIM9h5YKr5+ODVA4OP4y+Uur7s4xVxeQ5BfuYf0Xg+vJBz1v3weArUCL
	d4mWP85HZT5dZhf2U3LElhOBKqeGnrNteB/1JkVAAzeka/8Q24XoiRk/daoxMWQn
	chSgaQonk8k717e1ncqh7EE4WGuce/HvXWcgDb3etH80dxaBUEcybEv4qd6/Q9nC
	ri2zOZKIaOb59ofqpaeozCJ3NJMikcs6bsft5OWa/+phNLk4O6Sw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af1yd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 08:04:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U71UB8029028;
	Mon, 30 Jun 2025 08:04:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8190m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 08:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioxDmS66e2b0+mcN+Wes8d93m5CCvjdHJEzpVta3+dF1j87FqD4GShSP+lSm++tDL7pLNok4Ugkiz7Snaony1xbsJabHSwe/DFhl2DENIlsShuOBMjlHZEZ+kmU5DBnrT8jVlQtcMmLN0aO/WSYA9LlE8ggycUra0mwcrWsWKj6TOgv2CRgRhgdds8ZJszY98CYzUOpXqypRNDd2zOPV9IYe/zZP2jkrAeKOf0+NzOXVc7v8/9OD5CMLL6hG3Yg9XS7offIvZGzxLpwncmq6NQ3xgLx+rmy3/SzWukyEjgVkpPqnnKNJRl/QF6ZQKnTYxjZqzNAPlOCX9aaUnUixZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhqeIp2P+YVTxBeFCSVK8CgkYLQ+lMXJo3Tb2Nw3cc8=;
 b=fSplykF/zOfbp2E/EIiCJpi0Qipo9DEToOHVbo0ovmtBN8Gg3KyKuUx0zyQyongOfisIoWBLyHlWiVJdIMHMs49ux6RXTc1DfJEH5gz/CI3gRHWM5oLTlqaOcN/xtS/TjaEhKTSIpCG8L7OgPHO8/eZ5HbkVtNi9FJvFpbNyAnZIYDM8S8W1BR66Nqa0IJQ7ewh9qmoFAFao+yIx9yKoeLmi/KNlB30TR+no9M/KEzxTi+I5x6uaYDVaaUOgfVzWwsW8jn1biVS/bbIYGaYE9S7jffCOn6l6gfz3MfMbvp+9iu0qFy2yXzHgXWX46FbisOLfyZSumaYXXE+XZerg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhqeIp2P+YVTxBeFCSVK8CgkYLQ+lMXJo3Tb2Nw3cc8=;
 b=whC+UTq+A3Tmlsq0wZy4gGKF5zd7JMdOe4BEb6Po/hPAHVGVCjjPvsCIPnHbmWBqV3FmLgFwKIJLDI+TQanIICfLrj9nDMgzkqXKPILltDf5vH/reSRJ0tOBBOZoLqxC4E3A5ZFhzuXvimRAgxFm51mPj4cIDSxmbfOyGhWGOHc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB4879.namprd10.prod.outlook.com (2603:10b6:5:3b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 08:04:20 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 08:04:19 +0000
Date: Mon, 30 Jun 2025 17:04:01 +0900
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
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Message-ID: <aGJE3r5uSzRj8BsR@hyeyoo>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-8-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0167.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 45878c34-a7c6-40f4-2de4-08ddb7acb733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYFNYa66R/aNt6BfclgYmxedM/tY6BzW3S6FvQejIvQAbd4aaxZpL7ztGkdu?=
 =?us-ascii?Q?HyHVnLCHKyK5yL91AqZbLYzhPbsCod4TqbFG35+9UYEO/dtygVsOesOg27/1?=
 =?us-ascii?Q?WF64cQo72DiffqPkodRLv804Gl7QJ4aXxghZiU5/r7oYE1wDZCA9rZdertGg?=
 =?us-ascii?Q?43+DP1y85ZuDHd38bM07PgVx46L8gLpDSWjQj6z1yrhUHFI2KPX+5t008ttM?=
 =?us-ascii?Q?5mvCcNq+7T9N+25Mh7pGOKqjQ6jg816otKjozhC/Tj69z6Ydqtkw4WfTQcmC?=
 =?us-ascii?Q?uLtJ//uUxByYGdqWfmJkT1+a1lJC5cdzDj9lWCP8JVbxTwq0v5JnWY36cm0A?=
 =?us-ascii?Q?dRBv+spgt0PSUuUVG/31WkD+Xth7wlf8/ZfUPy0Li7MYdMqv1v7yVKqojmQC?=
 =?us-ascii?Q?wHiOchz747DB2Oj+30KULj3KFoXyy5sXKoyMm9/S+jeM5zUCLVrLL2Uc3Mxh?=
 =?us-ascii?Q?XBnscX2/7U6+p61C3GbB/tNSdbqa9CAZQYH3H5FarI74TvTJnWba0570O7A8?=
 =?us-ascii?Q?rfDwkb0VL4bYmK8TxEz8UQrWkdbUzsK5Erqzi9hUBtCSIO7NedT0W+A/2gMV?=
 =?us-ascii?Q?Spb7jUGF/UxhwhFR9KLjGKHo1uM3tLXcbj9yYJHkKO8TzlpIqplH5ELRWAYv?=
 =?us-ascii?Q?Zx4bFws6CgXxmtb5/L07Ef2mtVm5NJWd64HAtznJSx3WnbVrtmskDqcYYFIH?=
 =?us-ascii?Q?Fx8HNU8N3GAPzyYmh+H49u671AskkcLGaI/1Ye2EhuieP3fxKM67gZZu5S6M?=
 =?us-ascii?Q?FEasal1BSaq4pcnAWQRJAVqYx2tq0ER7+ZjMcrS63HKcWfeSSxcriVknqEIr?=
 =?us-ascii?Q?efm+6k3bH8WQGnoYhHDx7JOi6KHoqI554GBBA3y9rAExX8XK+YWcjgmYzuM1?=
 =?us-ascii?Q?Z++SkJnihv39aaMCO8wznBFK2FZCAgHe6N5CPuz+thEyNWUl7bKlqoSZCGP3?=
 =?us-ascii?Q?Jh82wd6QwqYLEx16qgwXYeInYQkhwH3cbOVIcPFAaa5LgbO/F/OvV1XYMTyt?=
 =?us-ascii?Q?5DbI8kvoqmS9eGp5FWrIjrR6g6Q0kn9i5D+Rvb486vDFp9dowoDZsoAyxuoL?=
 =?us-ascii?Q?0VKPzdmlBc5uIYDGP3Bw/QGvWJOQUvngujwRJnrGHDZIai3u56IRRpSCQZSN?=
 =?us-ascii?Q?jkZHEeIoNTTMkGcl1aX8hmdiwRE1TA3GUfehz7jeDuatXtewyGM7dm6VA7XC?=
 =?us-ascii?Q?i0Z5i6kMKcNxslkUB0f8z4eM6g3dakboXH82B/jS3v9ZuVB7562GQYZFqlV3?=
 =?us-ascii?Q?4CtZjzEfcn0Iaq4EHYPeBy6pRD7SBpWzIfTuz6zzxClvMVNLLByCbs29bg9O?=
 =?us-ascii?Q?Qk5eumPX7G9pA6natBTZQm8Vya/d/VcZjzbqpkxw3P+cnMm15YgWNIBXHyo/?=
 =?us-ascii?Q?jvbdoY7X8Qclqv9Y2+y8W6TSgvcrCsE1Z+/jW7seG38zes8ZlpfO29g/i0a4?=
 =?us-ascii?Q?m4XjDQJD7A8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uNCvWwCwzCUg0HI8NlBZjZgZQB78j5yPiahpdMer30q0AoJTtPMfsoUR8FB?=
 =?us-ascii?Q?Nz9iLotfdr5xWp85MCy76IsntxLz9B/XGEgoGDze+RL4XOJueVm0gLAAnj54?=
 =?us-ascii?Q?ZigoPt2pRTXMu0iTwF9z7uj2mrqfG4FteEznsGHg/2sA9T82Uq6FHZdLDrJn?=
 =?us-ascii?Q?o3jmYCqgd58Xo0YcBTzTnddzceq6Td2Uj5sGCTYDgu/MRrngSFqmlHpHIz8g?=
 =?us-ascii?Q?yYLrsGC6rGFLn0zhEwD6QzZzCwXlbuPSyw4JsKs2ZcOtCHGT2dHnoXeGXFPT?=
 =?us-ascii?Q?FxSoWDwgfEAuniFBxrgKenGj5RjDuo9HXltIdkqegTx1NLw/CeyFpWJ+crYm?=
 =?us-ascii?Q?1R/vT20iLV5pAOJxCxLnTmlGZCJsGS2DGO5ByTQGtNUDh3MZvlXwmwt6cmM2?=
 =?us-ascii?Q?7yk6ihj0f+8A2EZYF6yPCMT/71dLThbddcYbE4fI3BW/JL0QA7DaQW7ckjqt?=
 =?us-ascii?Q?IlcI8ETAMybaCkEBGSPot9W3mUywp3eFna7zibeseYfx2PwJxU6YmlXOksSy?=
 =?us-ascii?Q?EWWakIpONObVtcoyXTklvwpLYMuFHeuRH/0MiCIcDv0WnN94Kuv0+y07oUGm?=
 =?us-ascii?Q?nbrFjI2xZwJH7DKYkP5kHNdDjcveUs1rzwLBIl4wZpdkm9GVMWN8RG2qdhX6?=
 =?us-ascii?Q?y0FjPt/zJCrSHipSNCUyX56+gGPUripgfZVSuVbw2iA+7Yfilm4sliiG61sa?=
 =?us-ascii?Q?KP8Qo5K0vsYqp+eLcXz/F5IdKuZ3kWMViK/oujEgVJv5P5L0LShWjLCR63qa?=
 =?us-ascii?Q?CMI9NASBbH0WXZSBWm/+QQx/dwSokIzge2B3ny5YaXD23OYnWGpfTrc7tMyC?=
 =?us-ascii?Q?3OCzphrZayl5FwYo230hi+WdgRowZfI1I/AoG+pbh7ILnq2FdryCr8S/6hyK?=
 =?us-ascii?Q?6cbCYM6ih1aB15DgZ2xepwsK+mCBwOA1hSG5xQ4OQRXzCGAdLM5HLIepd73U?=
 =?us-ascii?Q?8r6LddaANItwDtV5vJi1Nvfk8qa5rai5yB2YxlYOj/bWu941+kNuLip7fO4x?=
 =?us-ascii?Q?46URmWGorElzEmFHRiJUYSWkNyVBZlw5V7qQkMU1lA08vt9C/gTXWZpUE03y?=
 =?us-ascii?Q?PKB30NgNABkUvrS5xheqeQ0oOX2n3VsTrW/X7oaoo0T6KUI//90eOjst0hOM?=
 =?us-ascii?Q?iWr94cQI+TK/g2uRq6IndsoBhl7U/VSocNGcZMYIw/2IPbYQiVKg0y7KMTPT?=
 =?us-ascii?Q?1z00CNnSy9BnsEkgDR+OSKbzugDmlzUXWavq1oQgTy4Y0roG5cIWpz/jPupy?=
 =?us-ascii?Q?rzpxTTnFDrxT5d+dO4xB48dochdMZYkyGEMC1Us8F6htGV9zIPjR8eydm2VC?=
 =?us-ascii?Q?qdVFC8xPxxPf7WoK7Hr6EFf1f9jxiZPpqVci/HQJw8CounfklxV6PZrgzEFV?=
 =?us-ascii?Q?dmCilG6M0BQ2wU5o6dMjeydV9IF91GKQ7M/V51QSpKxK2jE4sdlOEZZ5wx+Z?=
 =?us-ascii?Q?waIXEAoxYZyhz1WCjHjI/ncZZhzNtzJjkITiF3jXRYKx3B201iKAwf/xuG78?=
 =?us-ascii?Q?4dki9UETqLkFheIsqg/m1L26TnsONvqEnSCAEWd7b9o2ncxKQ0pz/B3NOPy1?=
 =?us-ascii?Q?bbEaSaLGM9wcjcwTsRZU5IfqsPwYiDWp60Rtud6m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VE3a95hbSryhqYytm+WA69RB9EsT4DPiEqaiht0Sba/6Ym9JE4C7X8vSkZjsH3N1DK/VkfYJfo2GXc6enqumrLjvr7c2XoPZT6fMfWHocBev6axuw4JqwTmgLvdbfYR/aRzvOakW/9NpZgZNtaN0HqgoK5PEX3lvUwx4EcVjf6f+ZhkCGtBWADommaX7P99mhYBsuP/69z66vlaVErSfh/OyEMhFDFfZrEajRKWsplBCM6H7PrZ2o7eBmkKZDMMl81jp4sINCFCqI/2+HPbqxlfosCDCtH6EoUF56vDnsX+LpgaCnnrnfaMk/NLhStW9tbEpHvCOuHDkVr+ws5eDyKYMXG7ZQlLXDWgWDo5m30maNnGUL1nVCk/Zvc+ZT7Gj4plYqfvfBHhtKVSDc/1w3ALSNfHFm6XFG7gs3SCeXOymAHGEF9te7QJ7mTZdxU+DMFXPItxMJte+tsT4SzPw8Wx2fNH3NYuz0fz1Xq/hpipJgo5WhBBl67vJhKrstH6qE/zVRQR+ou8s0fwYUeFvaSPlumPXhUxRP2ji4ZRHzl6SdbcyCNLaqPs5U+emqAtKevrCSf4O+GtBRO+Ul0p6ZxbY1pq1djHACFm6/hqs/Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45878c34-a7c6-40f4-2de4-08ddb7acb733
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:04:19.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f/xQAWHT5gQOOJxbr+vLv3Zg0v7bcGXtxFKlw7c2JajceGusc2D2vEibRaUo+gmjuYvxuLbrpsvNWm0U4MvTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300066
X-Proofpoint-ORIG-GUID: q3NQTjDzFlbMakvawrv_09_7f9VVlX5-
X-Proofpoint-GUID: q3NQTjDzFlbMakvawrv_09_7f9VVlX5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2NiBTYWx0ZWRfXw0aX64yJVyVU W7aWGRIu/mZ7BqyTJJ6bYDxamoZOYgHbSgu5QLeYUnb0SraUdcvAVlJubEDqjVyBgrU40wWtjpz df/f1KCIp03nGzz+Ixzu4YbMSXkGWY4Xo17w0d9sEqpvta82jl+mdpvtdBo3y6rFfhA5z9UpcC4
 4soNyT4o5lpinAF0OBLMoYO3z0wX+7T31cUpwFCNFT9gcH2+uRNVXd3LgyHg+pxcM4YTlW4ZISq mlyr8lfh83jzzFqCZ+9xg2XTvxbI7EECcB1UEnkPQLa/UvQIBa2li/RywZ93ieibfeaJwgK2Y2U OvSI/UAIOS7RMnpdln8/z4edjH8j35Vymdw+nATfgo09uZm8MpwJetOdgVCM5YhSC3OHop9AR6T
 TI4OKR41assDBfeZ+0I5adx8AQC52dO50JSD3n4XwHPCPDqIr5IBc1Og/ZKunEV0AZPyU5PR
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6862450a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=YMwQHEugdGb9FJnwGekA:9 a=CjuIK1q_8ugA:10

On Wed, Jun 18, 2025 at 07:39:50PM +0200, David Hildenbrand wrote:
> ... and start moving back to per-page things that will absolutely not be
> folio things in the future. Add documentation and a comment that the
> remaining folio stuff (lock, refcount) will have to be reworked as well.
> 
> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
> it gracefully (relevant with further changes), and convert a
> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Haha yeah, back to pages after folio conversion :P
But makes sense.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Side question: In the future, maybe we will be unable to tell whether
a page is compound or not, without first inspecting page->memdesc?
(e.g., struct slab could have an order and a pointer to the head page...
just imagining).

-- 
Cheers,
Harry / Hyeonggon

