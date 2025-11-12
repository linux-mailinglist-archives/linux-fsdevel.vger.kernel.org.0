Return-Path: <linux-fsdevel+bounces-68078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DAFC53A38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A57508282
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827932D7DD;
	Wed, 12 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SZl95x36";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mkFLOrfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930C23909F;
	Wed, 12 Nov 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963253; cv=fail; b=qW0kbatEsIhjKt4re4q7x8R/I9rQTgDV4Hkd/vzRH6nhMo2sMU2QNbQrfdWJPSoSu+MCS6JV0/D+1883E9nge8ZIlxZ2R3lFVziyW4I9EP8trfoz+hJS7K2lxGwChl7TSwxCM11kS4cLWGWKlGpeNyMiBxcHq6CFwdCCVr2Pb4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963253; c=relaxed/simple;
	bh=hxjin7Rv+bs9k8vx36UN5vkpJ4rJSL0L3ZJTf5sYPYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECXadluF5+Ja5Drt/3YWcLB47IBCPDGMWuNoGGk7j5N+o3h/fpUwrik9FzR6mOGQ/rXhtwq/wyxqeD+Ep3sQQ5oU2NM06NwJjUsuCdL8bcSrctzFz2cTOzu4PNhMMhZFwIC1RV+bRQ5LGGH0zU/+5sXlpXWn5v8KMAHGXbYX4tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SZl95x36; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mkFLOrfF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFjiDr007502;
	Wed, 12 Nov 2025 15:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OFr3uPNhPrMcHEWHvt
	S9pkcKDKBj2txonLx5UwTi8Ew=; b=SZl95x36lMkkF3NPmK68Ts9+sfQECGQIbB
	wo6XdEw2Cwi5ql8zKTUSa5vBYwCwVmnU4aOTNKVuxpEGnsJivENwA6vkf6rL4/Wg
	gcoxhvrDRovzgwQhS+q7pJck5seG82RR9KQ9M8MNZe63aWZB/pnTxb0yW+2lCqH4
	icXiLhhEgz9qLBiJv60X8L17BYeL5sIoQcA3by3/Um7UK4WBqBNk6S3a7y8mwcPv
	Vx5x5UigvJ3S9DDvaytY2AopPNcd70RnTPApe8wjD1nut9qCEkBy4ilAOzIpskEt
	XRfVfQy87mnJ5uMObtsxlP7ILmAnmhVG1r2kf1R6fxFhz/VRdYTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acw5f01e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG2rX009915;
	Wed, 12 Nov 2025 15:59:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabdg2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcAdzESENqEpYpDxozsLPhonnNGeYzaUVDvLjH1ybYq0sQ3tLqX3wsO7XyeUt1TNKijDtkJQKhRlDGG7ueabwSijIetEY82dXDvCa2IAE6hcIEPsLp1xS+eDof2re0xhsPSVwBTgSjVSYLvAA7Hr6AupI0LyGDmqVO4PDzeU2SqFMHhBzI8LFafks4O6FreW42k09wJltzbCj+d0hyNWM1sftK/42CJeqmBp2aTIWq8hQ1shFjZPrvWmYWOrUHIwtqpwCLque5XrFHca9Hy1PLgBwC9xQOkqjLzagXNXyzbP3O42I83r9UOXXXily1aisdMvGZvWvLk0SRy2LVvRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFr3uPNhPrMcHEWHvtS9pkcKDKBj2txonLx5UwTi8Ew=;
 b=Nq2DR1fcbV2z/pd945z44YQ3Zlwisaw1GKDCnscZuazSqXYun/qdRjfSgFYn/a6wO2lO7DpGFL47rlD1Y8682FRi/Ql6vQyCDhVcsoV7mtlY9ubNN1FGRThQa8FJMcA78iuwWsj5c87M/sEuLUcV2zOp8Xt2Ggc2BjajZvFtm5nohrVwLax6dBKwUo6tTVA3ilUoNN4T9WEWEzwiTUOpX/eL+ixnvewdlXYM7CcVoGaSwEbbXg03hunEULGvDVTs1IhxUYC7jpdPjWJRlLUsu3cOK2zNvuLuQAp7nSsFQrMQeGeRtQZunwO4rrQTMvx7rnV4UVYVB8MFx+qaH7uL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFr3uPNhPrMcHEWHvtS9pkcKDKBj2txonLx5UwTi8Ew=;
 b=mkFLOrfFtrB4Kr8eSeekzHryzYUc+lAecV/CqiZN1y2vD3LO1PCHDi8wEhpOfCO9Z6SeTiE7NHdP4wDvr5MI9R8BXi3HKtjBpGRe4bDLfzZLfdXFJnMFW941gtMUKyA32whAgoEVzz/mCH0nDSwWHFzzD6PiWBYqc9hPtxyGzjU=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA3PR10MB6951.namprd10.prod.outlook.com (2603:10b6:806:304::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:59:41 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:59:41 +0000
Date: Wed, 12 Nov 2025 15:59:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 03/16] mm: avoid unnecessary uses of is_swap_pte()
Message-ID: <c69f57ff-c4b1-4fb9-8954-c5687dc2d904@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
 <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA3PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fc8fb6-1098-4465-70a6-08de22047d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R14e0ipqaom+GcEAwEcqvsYBHJ8q451y7zKx2GpzahYJFDiJBG3XiOM5YAdS?=
 =?us-ascii?Q?XP+m0c8s6LVbXTZ+GqQTJvBtSpnvxxyar5k307sl9kU0nUdtGDZgOOZxjK+k?=
 =?us-ascii?Q?eer6koMpAbnUNFYsddjSx4HFnnJ4ROjmLeWjtbtcfMQtFVjx6YR3qpEkIVY3?=
 =?us-ascii?Q?wuE3Vz90Dk3R5Vsimvi78kOx2JEkXCz1rOCwb78OQEaFXRsrIyXoGg6td76B?=
 =?us-ascii?Q?sjrjkeJv31p6boS0vdHLBrMTdax841OsT1+7Oay0RYUDL0CMxh+8prE69UoM?=
 =?us-ascii?Q?E0pW16RmylRJkSYXDwUEtsARYrQpkofmsCCxXNnNUY1uNbZdgF+e2zyOEv1T?=
 =?us-ascii?Q?hquzFVftpU2J4rCW4PRINiBglj9mQ0uafYFllTgIz41Zii7OfFO6cWi+QQfM?=
 =?us-ascii?Q?w+G9jj2/7qZuVoAH44Pnj9OfP2HUhp2DU9jwFX0GnwK3mgmCExTEVBIGOYo1?=
 =?us-ascii?Q?0IeqoNW0Ikc7ZNmDf+zGu8zU3tldam92zWZ/lQuU/CpaUPOsxxPeDMxzc4W7?=
 =?us-ascii?Q?iI7uHa6MHTBfIGO/Nhvt0dow9j1Wk+bMBMgBQ8FUwHv7o5IhR/npBfa3lTWJ?=
 =?us-ascii?Q?Lux4w+sYYKpI6aCAMQH0mXQEEQ28sAOnHG3KQsFnY41fBGHF9KPcZyKDWOwG?=
 =?us-ascii?Q?hMBnVIEvD8HlLWi76K8HunyCloYxyN0bHCPVKTwHra6y+Xlle9ms3haBAv/g?=
 =?us-ascii?Q?9PnSI85A4Gg2oK3/42hxmJsZkqSxQUURgk4B3U+zgchv5ioBhA+lGiu0MOHA?=
 =?us-ascii?Q?RodZLmuq7MG88Fvg8V04Tq4OBUyEYBd81/AvKjyxNRDQE6Fb4bPK4B101sIl?=
 =?us-ascii?Q?aLHJA/5aJWuiZP3J2nrXHemiRq4g/xxDToNUiLMiYwvvmWFYWGQiamlyMamr?=
 =?us-ascii?Q?o9naX+2po2O98wLC3Bqj3t9h2+sryxyEJPFzQMoLH0CA1ABBYf6ASbpbCjic?=
 =?us-ascii?Q?Wo76f0sNthvFdDSoqYNpXTjKdozwRSmzswLY5ncoNjRDFuH93b9XhWun2HbO?=
 =?us-ascii?Q?iTA08IGdzpY9a/tVuxy7Y6IqPwnH45zouN5FP4fv1n6ddyC7GxQc7aL/EoU+?=
 =?us-ascii?Q?CUQu2ft8zlmhDRka8ggWQrBf8C8JZJS3lup88OtdyR1ZWlFSGVzYIUbZYpi2?=
 =?us-ascii?Q?JPZtwnVG7d9ULDunPAWEHX/2JWoPGBwa7sX+2f7Quddk9sk50PWo+Tv6a802?=
 =?us-ascii?Q?qOuZ9E4B67O1l00T5OycRew3sQy3zrNrowYbg7INHaVjeZ9ONJ8RDcpo5wcf?=
 =?us-ascii?Q?byYWRpJX7cQLqFK1xDAu2hproPS/G56e/QfPtZIKkM/iIvIb0l++PEE2Xf8X?=
 =?us-ascii?Q?cFOH0hRUG8FDH4PduGFk0tUNtbxFEbKTcShIUX5K62B13dNyPqlbnnonpT3Y?=
 =?us-ascii?Q?vxUUCC0nit9Jp+VwVoxEANrz4U6LCm7VPyfkHTA2GxNGyzDRERYQSZ+6LwtR?=
 =?us-ascii?Q?g7gcv9JCIGoJzQN2hO/ykK7j0EYRZzgE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WI/4pWNqFg03o3FjU9NRJsOgxmBhnS4/B8FoP9+yhVWg14vZAN2jUZcxRi7q?=
 =?us-ascii?Q?tw/DZhlJwibd3/kSqpird8VXSicsS8adqFAgTyK2XV43HqUYwLvG0lRm3hPK?=
 =?us-ascii?Q?XjXv5kpwk8S0kXc6W/6L4JEBZi7Equjpf0ljm5U4u52Iq8/AQkc2IAClWeH9?=
 =?us-ascii?Q?H8iMjgO6b92IizrmouVyI3ZkLXYA/0UlxKmjSJBcC8Sydz5OHzOEosrscoiU?=
 =?us-ascii?Q?O1N699ER20rvfCvkxr4V8nPHGu7sNBP+kwCq15ySfNsGqHgXrdOiBNj4ihdU?=
 =?us-ascii?Q?G3dd+ejRAZGAGzSH7nNrbA7utzdcATe3sl/hqPnC6bvH+YeqWiJvybM7d2DP?=
 =?us-ascii?Q?0/JAP3pMYLuY0zUPthQhmR/3lFvrnRvmB5A4k1/ozRYCi1eFoajWo/O14grS?=
 =?us-ascii?Q?eO7DPJwUKXamWkUP0FmSxArkAYnxXAHzbQldSQjO86BxtqdxI7Jgb2OENQHw?=
 =?us-ascii?Q?V5/1r0G5elMkgDBccOkpU9IU1q+ducbYynlSVzLCP0LRzZZWTdlCLcKVd1LC?=
 =?us-ascii?Q?uDmcyx4m4my7YwhR4CqUSeTY3SNQMtB3O6UBtAH/4IAug18DJDeOqw0Z30Tf?=
 =?us-ascii?Q?aNrUKfcBkThZT4UPl0b9YVwWxZ5uIg83exKEdHtxG1xbjBQ2nvmjgZKSHj1A?=
 =?us-ascii?Q?nm0ExcTlxqVP2lVJUrFFWSnGTvP5MvsOyQ2yYkLESS4WG5cy4/RknQ4RRzx4?=
 =?us-ascii?Q?rg3dcGql+qYYjddk7kX1/DRxkJvYMOtzNBqU3g0F8NwrkfE9B9fQ6loET+Vu?=
 =?us-ascii?Q?yf7VmZj8mmxQmZcHfNZp7eWtSYXgaBfxYW14jqL6svATR9Yw/77+oM6LFo3U?=
 =?us-ascii?Q?L/thCZ/v9ZwzKWs+fOmZduYqD9c+0NBVYaaVsiIayRoDFVpvhEXFvaxxbb+R?=
 =?us-ascii?Q?IhkGJ9rB5pWv1o3XQdwO0GwX9Mzl2q0Reqcix1kVJn1odlt1zr9i6B2o3pV9?=
 =?us-ascii?Q?pdA1rPqDaHdaVYRZjJvZMVhnAzyMMjcsuyqgo0kTYrdqFB0IxQGj1PeSz8iC?=
 =?us-ascii?Q?diKUj+2VwvgFAjSPphblIdgnsYRIK2q2S45MCMdAnnzH/ZLrFLPIzxD9uXGM?=
 =?us-ascii?Q?/0H+VxGn3de8TX4HhqIBuM4Gg1meF1VenXn8d4y70ZStCk50ZeyZwrRCn/Bs?=
 =?us-ascii?Q?MBb3xAeNTEVjpkGo5LTFk9VYIFZxOh0+0E9w8W40tN+TvO5enikKFH6wG+kK?=
 =?us-ascii?Q?hW4xM8hiE+ewAwKP02tDHD7QaPN6fHCpIWnh+ke55M+oJJqIYp0yhNG8ht//?=
 =?us-ascii?Q?ZbJKIhmzIdBZOHdax4QP6dT2YGfls7N0HXOHln3xN0tOUQUGRXaSYH//n1zB?=
 =?us-ascii?Q?Egfjf8ISy38LfTYAB9iewkG59MP3OgVMU71VBBhNjffI4l4NBNs1u/FETBac?=
 =?us-ascii?Q?wjDfV6Tnl1VdmApKsn2gr4BEm2eTw+RNPzpfaWHBJx2I53/o65lb1DHEVYoQ?=
 =?us-ascii?Q?XefG9SEyfS+3u5PGWvhAXU9h8Ozv6koUE4nfcntggHgiLgrLzhxkQwPvO3rI?=
 =?us-ascii?Q?4f0Apu4gIeomNutFnx/M4qiCQFQmnDWvrp+7wVanaqs2oeiSEk+L2rptLGC5?=
 =?us-ascii?Q?/1g0jp/wP2TV1r9UFJxEPwm7J7JUtPrwDIxsVxxgDhkucjrFFwwS+Hjnek64?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbWDF/g9yz+qc5zV1mpZCR6ocaC1kCWWd1cglJZecHP5m4HaAv/yHIg6zGHxGGfc8V+5tDzlZz9FEhzOuXRgdvmlFqKZcPZHX0oNFBrDAO1fJWpYVEErtPge/Q0fUke0u5vwiULA+o5LSmm1ttmOVvExze4XQP7wKTeX+chmaaUAzNFmqCAgaz4dc3mxFq+78yajEPpmyweK7EVthvwIak3yjo83283LOL08pH5DWhGpwTiXxPHmQaGM88KTV9RhJ4v8O9oBew27zZLbq8vQqjoauwUgs4j4lLwJ+JE0+2FpAVvX7ktk2RddwFF7LAitwmGWTuo/Oq+iyZ1/RCr68vwZaqEkBUUeWMa7Jy1xCpl6+EpiaXYYfH+zCrZfgScvJ+Qe8fHD/bAKpPfIiD7q2Pm+H9jOYKXaw67x0dy4pt6n4jColXj1eujOm3xsSG7LetqEqgpQPDwLrBrcLvRzJJqKJAzIff7VMVGMJu31VJqbtCtdxcmBcIASez4XmenYexRT2E8OUf4FPKEUf5SzdYS5RIlKq4XQVqY1r+NUM3hsHCRUweA2u8fqupQe/Bof+ziMTdaY7lcmxg1qJ9syuj1Yp2WUoa+yohqSExEM2pU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fc8fb6-1098-4465-70a6-08de22047d7a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:59:41.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjrQB4vf6DVF13YCnofV2wHgrS2VU6eupntw/UQpJiXS6jr0rGUjn5W4w+yQyquXAeHNNi9sCIDaB4hnRz3P+IHb+xmPI57odQ2WuqV5Ubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyNiBTYWx0ZWRfX8jPwXFSpFVxV
 LmM+ExqyIwYTeQOXldLnWnG4phmGSObWtlAGUqeGJtGLrq/YBURQm0G74aoZEi17DAArJfQNpdX
 cjbgofROhXYY3m6C19oOO0Kvigr28MlzbWsqR6TkuxvYmgJANvrlVbxHfkhIUqnaYb9eajdDizW
 2SqpGweE/u0bHeUq8uU2MLgObo7KoZi7ZHZRnSyKqORlBpWXj8kIOlgsmd7uLTje3OqNLkIFQwY
 BOSVg8pOC3uyy6n98B02Zcg9c4+YFp53ae/CEEIXcpev5/SmBQovoMbOlYOYkNiM9BrPySiQtaX
 HZJIGk9N0/tcPgIb/TcqeR+/tF8AU8Y/O47u/m52qs0zjSwhzC74r2SymQ3AaYXbEx8eyMfKiZa
 AyqHsBdaIFDFbbfV3NbBGh1C05kOmg==
X-Proofpoint-GUID: 56FyKXBWuXl8S423LVwFh9Kyy_ul_bx_
X-Proofpoint-ORIG-GUID: 56FyKXBWuXl8S423LVwFh9Kyy_ul_bx_
X-Authority-Analysis: v=2.4 cv=Ju38bc4C c=1 sm=1 tr=0 ts=6914aef4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=8oKMxynL1-BeT_Us9OoA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

On Tue, Nov 11, 2025 at 09:58:36PM -0500, Zi Yan wrote:
> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>
> > There's an established convention in the kernel that we treat PTEs as
> > containing swap entries (and the unfortunately named non-swap swap entries)
> > should they be neither empty (i.e. pte_none() evaluating true) nor present
> > (i.e. pte_present() evaluating true).
> >
> > However, there is some inconsistency in how this is applied, as we also
> > have the is_swap_pte() helper which explicitly performs this check:
> >
> > 	/* check whether a pte points to a swap entry */
> > 	static inline int is_swap_pte(pte_t pte)
> > 	{
> > 		return !pte_none(pte) && !pte_present(pte);
> > 	}
> >
> > As this represents a predicate, and it's logical to assume that in order to
> > establish that a PTE entry can correctly be manipulated as a swap/non-swap
> > entry, this predicate seems as if it must first be checked.
> >
> > But we instead, we far more often utilise the established convention of
> > checking pte_none() / pte_present() before operating on entries as if they
> > were swap/non-swap.
> >
> > This patch works towards correcting this inconsistency by removing all uses
> > of is_swap_pte() where we are already in a position where we perform
> > pte_none()/pte_present() checks anyway or otherwise it is clearly logical
> > to do so.
> >
> > We also take advantage of the fact that pte_swp_uffd_wp() is only set on
> > swap entries.
> >
> > Additionally, update comments referencing to is_swap_pte() and
> > non_swap_entry().
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------
> >  include/linux/userfaultfd_k.h |  3 +--
> >  mm/hugetlb.c                  |  6 ++---
> >  mm/internal.h                 |  6 ++---
> >  mm/khugepaged.c               | 29 +++++++++++----------
> >  mm/migrate.c                  |  2 +-
> >  mm/mprotect.c                 | 43 ++++++++++++++----------------
> >  mm/mremap.c                   |  7 +++--
> >  mm/page_table_check.c         | 13 ++++++----
> >  mm/page_vma_mapped.c          | 31 +++++++++++-----------
> >  10 files changed, 104 insertions(+), 85 deletions(-)
> >
>
> <snip>
>
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index be20468fb5a9..a4e23818f37f 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
> >  static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> >  		    spinlock_t **ptlp)
> >  {
> > +	bool is_migration;
> >  	pte_t ptent;
> >
> >  	if (pvmw->flags & PVMW_SYNC) {
> > @@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> >  		return !!pvmw->pte;
> >  	}
> >
> > +	is_migration = pvmw->flags & PVMW_MIGRATION;
> >  again:
> >  	/*
> >  	 * It is important to return the ptl corresponding to pte,
> > @@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> >
> >  	ptent = ptep_get(pvmw->pte);
> >
> > -	if (pvmw->flags & PVMW_MIGRATION) {
> > -		if (!is_swap_pte(ptent))
>
> Here, is_migration = true and either pte_none() or pte_present()
> would return false, and ...
>
> > +	if (pte_none(ptent)) {
> > +		return false;
> > +	} else if (pte_present(ptent)) {
> > +		if (is_migration)
> >  			return false;
> > -	} else if (is_swap_pte(ptent)) {
> > +	} else if (!is_migration) {
> >  		swp_entry_t entry;
> > +
> >  		/*
> >  		 * Handle un-addressable ZONE_DEVICE memory.
> >  		 *
> > @@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> >  		if (!is_device_private_entry(entry) &&
> >  		    !is_device_exclusive_entry(entry))
> >  			return false;
> > -	} else if (!pte_present(ptent)) {
> > -		return false;
>
> ... is_migration = false and !pte_present() is actually pte_none(),
> because of the is_swap_pte() above the added !is_migration check.
> So pte_none() should return false regardless of is_migration.

I guess you were working this through :) well I decided to also just to
double-check I got it right, maybe useful for you also :P -

Previously:

	if (is_migration) {
		if (!is_swap_pte(ptent))
			return false;
	} else if (is_swap_pte(ptent)) {
		... ZONE_DEVICE blah ...
	} else if (!pte_present(ptent)) {
		return false;
	}

But is_swap_pte() is the same as !pte_none() && !pte_present(), so
!is_swap_pte() is pte_none() || pte_present() by De Morgan's law:

	if (is_migration) {
		if (pte_none(ptent) || pte_present(ptent))
			return false;
	} else if (!pte_none(ptent) && !pte_present(ptent)) {
		... ZONE_DEVICE blah ...
	} else if (!pte_present(ptent)) {
		return false;
	}

In the last branch, we know (again by De Morgan's law) that either
pte_none(ptent) or pte_present(ptent).. But we explicitly check for
!pte_present(ptent) so this becomes:

	if (is_migration) {
		if (pte_none(ptent) || pte_present(ptent))
			return false;
	} else if (!pte_none(ptent) && !pte_present(ptent)) {
		... ZONE_DEVICE blah ...
	} else if (pte_none(ptent)) {
		return false;
	}

So we can generalise - regardless of is_migration, pte_none() returns false:

	if (pte_none(ptent)) {
		return false;
	} else if (is_migration) {
		if (pte_none(ptent) || pte_present(ptent))
			return false;
	} else if (!pte_none(ptent) && !pte_present(ptent)) {
		... ZONE_DEVICE blah ...
	}

Since we already check for pte_none() ahead of time, we can simplify again:

	if (pte_none(ptent)) {
		return false;
	} else if (is_migration) {
		if (pte_present(ptent))
			return false;
	} else if (!pte_present(ptent)) {
		... ZONE_DEVICE blah ...
	}

We can then put the pte_present() check in the outer branch:

	if (pte_none(ptent)) {
		return false;
	} else if (pte_present(ptent)) {
		if (is_migration)
			return false;
	} else if (!is_migration) {
		... ZONE_DEVICE blah ...
	}

Because previously an is_migration && !pte_present() case would result in no
action here.

Which is the code in this patch :)

>
> This is a nice cleanup. Thanks.
>
> >  	}
> >  	spin_lock(*ptlp);
> >  	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
> > @@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> >  			return false;
> >
> >  		pfn = softleaf_to_pfn(entry);
> > -	} else if (is_swap_pte(ptent)) {
> > -		swp_entry_t entry;
> > +	} else if (pte_present(ptent)) {
> > +		pfn = pte_pfn(ptent);
> > +	} else {
> > +		const softleaf_t entry = softleaf_from_pte(ptent);
> >
> >  		/* Handle un-addressable ZONE_DEVICE memory */
> > -		entry = pte_to_swp_entry(ptent);
> > -		if (!is_device_private_entry(entry) &&
> > -		    !is_device_exclusive_entry(entry))
> > -			return false;
> > -
> > -		pfn = swp_offset_pfn(entry);
> > -	} else {
> > -		if (!pte_present(ptent))
>
> This !pte_present() is pte_none(). It seems that there should be

Well this should be fine though as:

		const softleaf_t entry = softleaf_from_pte(ptent);

		/* Handle un-addressable ZONE_DEVICE memory */
		if (!softleaf_is_device_private(entry) &&
		    !softleaf_is_device_exclusive(entry))
			return false;

Still correctly handles none - as softleaf_from_pte() in case of pte_none() will
be a none softleaf entry which will fail both of these tests.

So excluding pte_none() as an explicit test here was part of the rework - we no
longer have to do that.

>
> } else if (pte_none(ptent)) {
> 	return false;
> }
>
> before the above "} else {".
>
> > +		if (!softleaf_is_device_private(entry) &&
> > +		    !softleaf_is_device_exclusive(entry))
> >  			return false;
> >
> > -		pfn = pte_pfn(ptent);
> > +		pfn = softleaf_to_pfn(entry);
> >  	}
> >
> >  	if ((pfn + pte_nr - 1) < pvmw->pfn)
> > --
> > 2.51.0
>
> Otherwise, LGTM. With the above issue addressed, feel free to
> add Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

>
> --
> Best Regards,
> Yan, Zi

Cheers, Lorenzo

