Return-Path: <linux-fsdevel+bounces-53305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0CEAED540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBE07A6478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298121CA0C;
	Mon, 30 Jun 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p+fzrjJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="enhnpzkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F2218E97;
	Mon, 30 Jun 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267371; cv=fail; b=DZfPr3ddopDwX0kB/5vZ6sQZ1rnqzKaSMrpY/AmwpzpC3ZoS8WE5nAg8nwF6c+2Fl09PyVh0Isgj4V769Ch0oH4ZOO+gqsB1+/UGSnKrILVbMPqXCMYRimYSMfdcyc2tI9p6IdL8lpFvKF7ELCOE3dDjPtY+sfv6fsqPRv9FiGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267371; c=relaxed/simple;
	bh=lDYrQrqJ9JQpz89d1RDDM8Bdrbnqlybjyf/szqr3Aa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UcDVITQMYUYe4fX8ItugYObJvy/HTAlfZS+o1ASW6sk+hsHBqweJGXjTrOY+1hzc45RqTpvNpBoO8COHU6ZLZgo7rWcQUVHy8iZjdErP5tqSQbJ7fY2F9IJKbbjhFTJfTpyDbzz+Yl1KW4eJ93x0eeAPhwOivWwbPcF/PLH61mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p+fzrjJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=enhnpzkQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNVnJG000471;
	Mon, 30 Jun 2025 07:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2YfoH3bc3QP54NpB10
	IXCbcS4iDpR9Ukf+CeCVT2N78=; b=p+fzrjJzCdRSQY3r+j3bZj6EfxeZonYdZu
	3xkWe6ozjVsCAvqRYHmBXHbJXQBlcht31G0Y8+KCtju1Z8DZbTXbpjFTNq4TCaW8
	XYnTW8HdwfYofAZWzpHL/IwGr8oceM3AYo0/n9A82f/z83r/FGK+ca8dWZRwgGuQ
	AwztVPhVsbJQsaW95ipWEpylxWLbH56VUxBHu+4oGXOoozplA4RXneky+OqGEKJD
	uAFUR6k8TMHXew+uvfjP9BuIgrjtrPeAcBgNCnFSMpPdmL5ZdNPZA+dAkd+9QbQu
	FbhzmwnOO2C46C2+ILJaS2kQxcut/lgzhUj4QGoFRggCZkN2Qdcg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7049vgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 07:07:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U65rxO021580;
	Mon, 30 Jun 2025 07:07:41 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1cqbgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 07:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOonzmJhsBmPT5/zuCMW6gqOcpAhXLCxhMrXyH2lcvLfZ1ebYi6eWmn3IRmkFuF1+Vk36O+gtemZUwzq/j2OyPGsVsTjr6JAkpdtDFjtjBe3kJdPkoXTGt3cbhC8vGXeSSCtv3hwKJXGSCJ/9dtGJGsq51Rh67qlD4MFmZJMv14AIEIMZqegSz/4M3KSn0p5hID24ZMTE0y9W7xw8iqhFvyVAOm3IhLC8ieZ9cZr1UGysX8oqMfXEhVkOuel/rIsbBcS/pOapG+xz+uiGpzWLbeavRgJ6wQvU70ELOC2Fu6yHVWhrHp3qDqP7QMaJ4JcAnf86RNF0KdLJDJHR886Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YfoH3bc3QP54NpB10IXCbcS4iDpR9Ukf+CeCVT2N78=;
 b=P970I0vflvihv/ToBqmQBn28P/OdRjvZ2HPYLnyORBlMe1nLUgGamv5YodET7wLC76KeclVFsw+gnX9VxuoJH2b9JYJv7OuGbHwccVKYLSeEKuS1V3H9ythyTyJAa/UydsI2S9kBO4fNNq0kF+gRY1RnNwQAJD3J1eP8+nVUrqPbvFA3qlx5PuU/qlairAiu4nLGuVMT2dLXEm9pBHoWy46dDTL7Bs6257XVg1malcIkJlxFVtdgkpz0osbZd1M8oDC1PtskFsvcQFsY71TCPKn8fpGAkZkuT0eyYnX99lnEINU8slpMcLIgDOsIrzwAx5tfusmkl33310AiMzKd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YfoH3bc3QP54NpB10IXCbcS4iDpR9Ukf+CeCVT2N78=;
 b=enhnpzkQPBKGGJ/GPGQv2LrxYC+Ih1zev4CK5W+OiEIy84wpL+yaHnV0f9Vn+Dzf6CaVJtKaEUJ4n0ReOdIwme4nIYl9uF/c3TQc0tmf5IC7I2iJwdsU8Jtqx9nCYIfbtP2+EEoe3bF8X9klkYHOWaAfFCngFiJiPtB74rcdKjo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 07:07:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 07:07:33 +0000
Date: Mon, 30 Jun 2025 16:07:19 +0900
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
Subject: Re: [PATCH RFC 05/29] mm/balloon_compaction: make PageOffline sticky
Message-ID: <aGI3p8phIxsNWxwG@hyeyoo>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-6-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-6-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0111.KORP216.PROD.OUTLOOK.COM (2603:1096:101::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7c2cee-7f4b-492a-b7a9-08ddb7a4c8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rmOXMWBc5BNeO3JUblX1y/5S9lHsnHJbiAz7fo8SAw73PInCE/8FJV77WB/?=
 =?us-ascii?Q?1iGj1hw8qeAVmXL4GsPPgCUw2NwCiPgZ2O3mAvgaIwl4vXBgyfDYixqp/OCC?=
 =?us-ascii?Q?15pbklBbMxv9b0MDvuQniW5L5JHFNoDUz8iLDhmqv/wDDaUJzl4aF73NzrhW?=
 =?us-ascii?Q?dVdd161+AKFmH+LKrbV3nsLEBVUgVCorfHwETv6i9qnNkPVtejsenNp+3Szw?=
 =?us-ascii?Q?eajYQ/ZZaWe0fzLS0INSRI1g/au2HsTKe1IqxK9Q6bRnxh3pzxc+ioikLXJ5?=
 =?us-ascii?Q?FiGnLOnN+ULjtwbtXMuIbnu6Lxlsz19V4LkQCn2NbBs73A2noJ5zYk6ry3ww?=
 =?us-ascii?Q?PbH7r2biunLF2hFX2dkSDHRAdGVZG3zAhfdtKICbCR9HEsbxcLp/PuLroO5a?=
 =?us-ascii?Q?SjVsBxQVQe3LPPfteRSI2WQ6dzr9ow+a9zSv66hF9fYkCfYmKeIEX1aQ7xKu?=
 =?us-ascii?Q?fijI+Z0ML+WXhPr3L6zY/MrRQ+i8yMRegaqVaHrOKggMGch+wb30O/rymom4?=
 =?us-ascii?Q?L4k2qSKWQMbR31yG9EgttUfBlprStJ5rJyRldkyY2ZLEmI10pf7zRmWUObSw?=
 =?us-ascii?Q?/BFAgkpMFSJZHkMWXjmtA7+BvQPiBJXpyagWzsssF8o0wzzyka0bDRxIjyF3?=
 =?us-ascii?Q?9WWnfDqLBA2ZqrZ8QIGXrRofa99M5xLAAdjO//yWCyj6dlJwK/AIeLLWbzXw?=
 =?us-ascii?Q?+JkH1qx4Pad17n5/i8tMYw/t5wb/xJADiwTtNIuBhkqtKVRoj6f64zHxW2xZ?=
 =?us-ascii?Q?DJz5YmcqjiD7s8q8hYpFw6VM9QQfZCsMYKas0eELOet+VxfZfUx2Jh/d+A9z?=
 =?us-ascii?Q?4xroRDC8kKIYWNG95zhyoEMYc0LBoKFawbdOn+yV6m8Wut1NZPssmGrlL0ia?=
 =?us-ascii?Q?Sgm4WpLBnTOPKiogI+u3Je3+41S9ShuCFSu8qtm8ruFaEr9i3WKEIlVsXszF?=
 =?us-ascii?Q?BSPLxJTFIQ0T0xTKs2y3o63NyhUAk3RuPZXqzU77K600jPKSjFztpic0CU2c?=
 =?us-ascii?Q?atgjgtKAlcYtDyS7OTPDP3c8/ehq87eg3GIK7MViqBisb0vEXZ2gUUTwcCSw?=
 =?us-ascii?Q?pJzIw/1lJGl+2wwF8aUgIOKsMIiR8GWbr4ysQzRVpXs+3EIYtzbuIN0qxPSE?=
 =?us-ascii?Q?V3bV0Wm/oGNYiNvqE4nh9WGKX6dg6AvWl+vOH+yTkhCgHv3Cre5bxXQtTmRK?=
 =?us-ascii?Q?GmG6lFyCUUNhBhnqcNbw8ybKnBrqEBR2OTHdKt8+L8WmPm9aiHf26kJv12lJ?=
 =?us-ascii?Q?IzUW1y/+nALfA6LIg2Foamt7pLBIC6974EE3M04HZ3SM3rW/lcHSPo5DP+9B?=
 =?us-ascii?Q?hNxx06RT1lqYRXx0e32m1MBGNZu6jQAr3rvPqVjcHtijPHeKtM8ZvAv4bWnl?=
 =?us-ascii?Q?bc/2bAEKkoN7OV1qHuOAzy+PLT9lZXCxEgvLzm3Amwclj6E6FZs4kmv+FErs?=
 =?us-ascii?Q?ZwPFBiKVrpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2PHQwPhzRPa3SgBIa8z/Q8v7z1O0EhFJs25P+yKtK61etwYAH/DImCjRx1E?=
 =?us-ascii?Q?5mGOxALGCAt9UI80v6n+CuCFtAPyMFe9GSj2Y38HQNOznW8/6wAvVxClVcY2?=
 =?us-ascii?Q?i3a7jkGTHk/PPNlXV7Q2LVzxvUHliqg1L44P96xz++D2RUH8Nss8kI7yv8h3?=
 =?us-ascii?Q?H/mhLfjnqWPj67YU1E2RC100UdyyssofRKlghU8PgtfYhgQPCafYQ2pY2ksS?=
 =?us-ascii?Q?b9FY4zlA1Far1RGYuggQqw+bnRwz89Oj99SBtAR5gx7qvo8blX1BVnfM6Wbc?=
 =?us-ascii?Q?ruUnYZ49BMR3LG9Sgu92Rz86lWkmr481GQM5rnpUA5Zq+ASc7vu2bUqjJS0W?=
 =?us-ascii?Q?VZyoPxpKwGyveXEk8PM90zq95CttcdiKz/DKpUro5/0ZLr8apB0LcE6uLBBl?=
 =?us-ascii?Q?yt6Bwxe2rDj74nVHw7DuUhkBhihyfgucg7aSxCUi23IwOCpJD0UBQOY0tNJa?=
 =?us-ascii?Q?oEqZMkSMFHwUZwTrtSlXbeU0E3Rbsx0lygSD40me5phOs3GKIAr2KYUzcKWr?=
 =?us-ascii?Q?L9SpqR0XXWulG41texz4axhKZmg1AMMJhjfV/16opnN6hK/GGdB/J09JO9tM?=
 =?us-ascii?Q?iunJ6LjLQre4biMby5q8MS8qAQytxIWkMYCejHxHFU0mLHt3TJDYQ7g/NA3H?=
 =?us-ascii?Q?gBKcr9keghbbdLncq4oe2bSX0Ro5dDAIX+kWjNlaKYD/wXEdUGHzhzPkWxow?=
 =?us-ascii?Q?Pp1NYCJqX4cNl/GshN04CXCaQ/AuaAJZb5+tPrQkaBhLrfsHJdGBfS7ZkNmE?=
 =?us-ascii?Q?qPhxWqbz5JEPsy1mq0Sdkbz5DuXbiqfTIfWCtNcHBKsD1+X7YLX2ZiavxZZu?=
 =?us-ascii?Q?z/KNBXSgyEPJa3GwyC4cm/iBLolilWna3rPn6ZEdIy8E4LivmCOrAoA5p3zI?=
 =?us-ascii?Q?EL9VgEQmtiOWUhmm0DwH2y4mdR5O/nUCsJgT+aUvNg8TipGVBE6dpo/ky5A1?=
 =?us-ascii?Q?OII+Zl3JqCJScFUnxxcTTJiNsQTN2Vg8J0OcD0hQjrixsZqvYdoh2XyhiHPk?=
 =?us-ascii?Q?0RbmiZ7oAdTrbuuil89fDHra6xOrzWAbOouUk2fagQhGd0fgnbMTQ4wqK/rm?=
 =?us-ascii?Q?78yps9OG4VZ43RqNa6rT3D1DX5APow65/cK+27kxjTaUu8iPRUJq8IIKGS2g?=
 =?us-ascii?Q?wgK/B8kltIYENIIUTGtRyOUDuwhJhbge8sWxSygFSgFxxpdhnEMwsvjAd9xN?=
 =?us-ascii?Q?iDUsyRBbrjOTF+kLSA25OP+796n2uZA+Cmt++Q8BoRpH519SXSyF6dRrL+mn?=
 =?us-ascii?Q?nQjW5bu4c6wImMvuQ9UrtVk4JdS6l/0fpze2ubxeTCgevq0DSqcCD2gsK6pq?=
 =?us-ascii?Q?+FIMrbjJ3s+qzkUQ6U3NV8CkL82VyXWzf4TbjtjJdNLEEFhsHybReU/RXk7+?=
 =?us-ascii?Q?ulX+SQE4UWJYzo913X2pZRLGTeGV/SC4hJRuyRN4Dgt/VSrz9Uw7M9oWICPd?=
 =?us-ascii?Q?E8luwBbVl/dknRZGLjB2pDlw9jZkFEoWSUMfrRES5VTjdTP5quAsRUUiuK+U?=
 =?us-ascii?Q?i4E1gEexdm4UbuyNakWHSVNnnK7GGt3M56+ptCWRmP7q9Cp7CyrbdBYjY6Sj?=
 =?us-ascii?Q?X8UiUJNg+gwOGhXeRMT8fxD8Mtv6Y+0yYKxQkiI0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	49Wovub0JFdbbhR2sT5tTD0lE3Xbi5hIuyNkAPS8OfxVx+kyJ/0FYLrQxVP0XV1ZnxrkdTX652cprh9LTcBe3P3UAhaIMtGS5kf5BDneFJPaWie0iMmJg+u3o709KpAC+17HahfWAM6YrNlT/sd/Lhj7X4UeRLdDhiKeLryqgIYRL3fdYQ10l58Ql6q2qY7F+6LFwQrTksxpwP5M4q41bxxmatmDoBMbqSBlcd/4/YOsTD4T4oXgjAzOf0qPz8eTSq7VKB3q8acQl8cAkKOyJf78pUSjE0DAM74INvRg7iTg6UluxJKRuqher1WGIF5RuboWL5bnK/p7op0dE43qpI9hhv3N5+dIZ94y5dviRNVYiMdb37Qi3EeaBuNenW1+edmESKzSsLl6AywzGF1NG6HiJ0oFHANoXRosuQirVmeUF8LfEIVYzRwnDUUeIjhGfxBTT7myRKIUEq8aHryQ3m0z42+aY4VaOiJZxlPHBS9ZDaalvdFBc3bPW0WpiBeeL+Ns/OuXxZWF+9E5g4mj58OV2yvzL2i4tZGVIR5DbXRnfMItwxvjOpqINYQJ8Y4P5T1GrJ5y9q/P8ZM5uaDFFqPadOoXzHDGpGpyX/U8ztk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7c2cee-7f4b-492a-b7a9-08ddb7a4c8c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 07:07:33.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/vXaG+uBQWaSbfmbtzK+8eVToFW79TAF0GScRb+KToaNmrP5ESQmMFQYyHJFKoA6W2swKTtMTnW5zFUbVPw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX+3v8A19AbV4u qCs+XbQq7uIDGV+6Trc6tTeaYXrBFqzMR5sgeTkJa+2uoShypD5kU2mkbBzjfKsvHXvaqFFOEQA 9rm1CeUJIUhKqoJDcZ9R77NUJrfUHvfuV7KQNUMG7/yzNHz/s3s3gnl6gP5V45MvUeKZdLNax8A
 2P+gerIXmW/JUllkmEaFLFhgLKzHf3bGTdqK+Od7+PFARvN+71CElEuTG0wdddKf32HmcPabmlA WJ+6SGLhaP1sQvkQT/GzpxBDkB/31tJvINv9nImuXY0IRmYZP2VhPVVsD1ga/cgXtTRhWKZpqRY I/cYzij/n4jhV8EH+miKxt0ac3EYZAkelq/cFclofRy6uR3HsZMoEpr29q60j6zMvzWXN8zIPXb
 n3Adbykg5wgS4qthQo3dr5BkPPIApfQ0uTbwUl32/pOXY0uPjUpPRs0B8T5+ycywM7GZk/5Y
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=686237be b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=PXzck_wk1Z_t0jL3Ei0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: V5ZI4KyY_YD-V5vLIrOy59A424XhK_ou
X-Proofpoint-ORIG-GUID: V5ZI4KyY_YD-V5vLIrOy59A424XhK_ou

On Wed, Jun 18, 2025 at 07:39:48PM +0200, David Hildenbrand wrote:
> Let the buddy handle clearing the type.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

with the updated commit message,
Acked-by: Harry Yoo <harry.yoo@oracle.com>

>  include/linux/balloon_compaction.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index b9f19da37b089..bfc6e50bd004b 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
>  		__ClearPageMovable(page);
>  		set_page_private(page, 0);
>  	}
> -	__ClearPageOffline(page);
> +	/* PageOffline is sticky until the page is freed to the buddy. */
>  }
>  
>  /*
> -- 
> 2.49.0
> 

-- 
Cheers,
Harry / Hyeonggon

