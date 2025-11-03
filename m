Return-Path: <linux-fsdevel+bounces-66773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EBC2BBEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 136C5343F68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466330E0D1;
	Mon,  3 Nov 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXnNz26J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="REWwY/kP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1C283CBF;
	Mon,  3 Nov 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173538; cv=fail; b=IJkFYbYvCNXNO45eFDAcdPkbOBRIHNJlaxLEoAqzUubeU8vBAs707Q5jFc68GmfxjMtM/3zefHp6PIvR14OAHLDMjqBuIks9VDSGWUpkXyTn1/6/AjlH1kXfHzDdGZoyIUMNc7GGQNr8UmP8+Zht9BbAXBdm8rESAiCA3m5Y8TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173538; c=relaxed/simple;
	bh=QV5bnX+5mjZsiw57H9uq+znm8pFF1RGxxblM1BlZYSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiSYxZvuMarhWdFWtsIRbu5IxCs0lV5ASEvahz9xCIw8vZRq0hwz3cJjpjEqmsVptg3wSjI87b3hec90QrHSjcYkAEH1XZE40eDbrqj0MSX03sd0PIgER5ta0ytklaAN/lg9MdAirrxZavWx7J/RWBjTrDEvO/QcpreT/nizqHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cXnNz26J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=REWwY/kP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CP2eK031542;
	Mon, 3 Nov 2025 12:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8VyPY5KuGo+/6XHmI/uGvnOahcidViWOsG67x7t6fyg=; b=
	cXnNz26JHf+IXn81QUNCP4nNS8I5YI+FXE6lW0R1FdluVyrZECykKQGlti/n0X45
	zokKL3PwOlG6GFLuSEzZDUrvdHZLrKBA9tjqdPvIjU0aAvv0mufQ2MTE0bbAH2AT
	kIejMyTzD8HLMIDv12Xe2ad+wOxUKVgldq4MsvJ/HnC7OLsc23RG7iMbjg+aH1UL
	QoQUZYS8ivqKN8VyizqSgpoeJGjZ+rGVekBvO8WCRSaS5e/JR9Mjsha3+88dSdsl
	R3ezk8vM+tIxab/uLIgFtS8SzQ42Ph/58M6oH779JBZgJFDPvuKZqnYDwXyhxVU6
	x1FSfULsT8vnNZpgfHyk+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vcb80g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BIR77007356;
	Mon, 3 Nov 2025 12:32:50 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbkq9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujDj5HgC2srMi6TPzakZURIKkehbFWEljGEIDWIsVIspa9K5N2toTAlLB0ltXESYzngnExnYbt2+45afblnIsE5MC+fdsgVKfbGu8l7rxKnNFu7KLQ84uKyIXMXuRimgDvrMAO0GqAvDbTslmg3vfAWTLB/k9OH4iMa0olSMRQGHscwmmf5o1+6VBzRISr+74gWcABbf6y/zpB9alhx+gPVfB5VH8c6v5VuimJoCkGJM2unFXqr3ypaL2L0W809/w/yLWG2dChgobk/l3IecTZiH7puk8TeS5BDEYYuA9qGTJJY8MKeTvcB48bZgrV/nl0cqj2Qq4WMco/u1TV3fAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VyPY5KuGo+/6XHmI/uGvnOahcidViWOsG67x7t6fyg=;
 b=oI1Tjb0YFOr2UEqhnlTeBauumjyWfA+wD6BH4biNm2gFyIVBkNDjavYOmzvmdEmTWo5jiCmVAmUlzKlkJhw6aTUbF8LZtQ50Dio51BnOtbLzSBuQO8z0CwhgA2jpCZFApqJTxUUw4+sv2JtEw/kfg3GryW3guee2iUuEGPauPgFoLJE7IDjztxeFUxJOgKbTlDJViLx73Gnob14xhNJR7AEtAaj64jfWMCxrn8IWES/zH+9Yw1XxRM4LJdPrtNLIihZrlb7dn31mDEqgTkNL5dvXDI0haeSAiAYXpK/NRP7CcIK/EsuKqi7yHISvJH7xhvxCzS2GYdaHaBF2YcUdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VyPY5KuGo+/6XHmI/uGvnOahcidViWOsG67x7t6fyg=;
 b=REWwY/kP+SPy+/fkB0z5wT7s/e8YuUG741fopviVgZGBKRBKSh8UUdUKXxrpMwjra1puzEBS0/U2fjrE9DfXpxe1ICfDAXmcX3EXlG6g0pqMyddBm+tt7AlcCaVHF47VH2QlFkdrdiQkFuIET20LpVHMqahLReIhUDglF+ZfRDg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
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
Subject: [PATCH 13/16] mm: remove non_swap_entry() and use leaf entry helpers instead
Date: Mon,  3 Nov 2025 12:31:54 +0000
Message-ID: <b4925aeaf6b7e8255b1cf1585476b718862b8104.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0110.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c06d2-439e-41a9-015d-08de1ad51820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/w8ebB/us7l/zb6rl6NKOqxxb9k/ZGYOewqYUYcplatw0Zwan2Db+NEhLwUS?=
 =?us-ascii?Q?Ofz85phc0yV/fcybxqiOG39v68hrptBhBiHkq8jw1j7WjzNd3kEbiRo2D8El?=
 =?us-ascii?Q?41V5I88NNdlbECMJre2NUDmPBjwguxpdSHNQYqVY6+BRYsl5Xm8OREs9hPBm?=
 =?us-ascii?Q?olfReBszFdS8QVmqdlOpaLDviWM1T7iBHEQfA15L4lplw7rAGgtFgn/vqf6c?=
 =?us-ascii?Q?yIKxNZpR+nOdwe7QUg87pORC7Jaqakl6eM7fWCEIFfVsTeTmtEeWYbZheUaH?=
 =?us-ascii?Q?Gf5mHJcOSiqpZ/n3KdX261EVbU7kgRV6w/mZGwY5tDNPT8AEniFHNs3Zbohw?=
 =?us-ascii?Q?hjsM5w4+Ax7s118d2dTna9cohj6q84sXDVFODOGpfa0hwSvyChZ3Dq1FJ5AB?=
 =?us-ascii?Q?2uiSum7i7m7542S719h9k937seFF4o4AGEuj5nslum0DHgBH1sRBixbWlD6N?=
 =?us-ascii?Q?T8MIUvWbJFnljD54pCmuUkh7kfijvogqDSL7przwA8wiuIPlgLQjbU0ghVIn?=
 =?us-ascii?Q?Uz7hvITUIKd27tdltZw9nF6QQxmloM3CTCgswqaY65Gpb7qlOhjkwYR8Lw04?=
 =?us-ascii?Q?3ZGaCCrdvMywYgLKNZLpQQohcqWLDsmaa5jgQ/Zhqup29h+3oTIpJ0V97UiW?=
 =?us-ascii?Q?FiDdijNfwQGtnqzW107c4YoEfpTUY+KNe0PmMk+R9jAXdO6UpgyYDc4JhT7S?=
 =?us-ascii?Q?nZ9ezIJoGV1qNLJrYaHoXjbxXjDBE8m7o2uozLVmewZc03uyPh3BImaT5UEg?=
 =?us-ascii?Q?mVZJxQhieJy61rzOwxXpenXTjNJymVzNY1Hs1MQ0nQ2bWukUMcHWR/Pb7IAF?=
 =?us-ascii?Q?OV2RlTqvHhGnkfklQiTGI6FSBWfcVvg98NHaJTcUuQJSfAS4unXzFIXiKBbZ?=
 =?us-ascii?Q?k59NrQAjNgykG5YhhPA3gdfcn6+lbGqXHoK1X2Rg8YjZPeEzvMNFQemn1+nQ?=
 =?us-ascii?Q?5kUiCBX/hO8RAa9XS8VQ1UXqanZtDIy9nVMMMzruKwzoQaduJqnQF9QPjW1p?=
 =?us-ascii?Q?mVlgG6rbi3v2qhn0BPh1Tbu/G/aXZMzzBt30rgtydUujeRjU+EtEnscxzRfx?=
 =?us-ascii?Q?c8ExMKQPUV1wY1zmjMa6u2KvJIc5edodE86BbBnsgsRUf8f5GY5IQ75/eGxS?=
 =?us-ascii?Q?i3xTHdIAGpXdHkHrjjTtAM6GkM07n0sBtwrNSXrDebDh5r50ZnOGeVCQsxtq?=
 =?us-ascii?Q?Cu4IrqYVMp6eYn1mgaEenTwcoIqeiAqutV2slFTmE9iAuAB+eDWm5s1F+4GO?=
 =?us-ascii?Q?3MLLSZZepWSXNzvUGMa8qQE6PmHUEkXfjoe+J6UXycIvOBzBGRomMMp/UPz2?=
 =?us-ascii?Q?IhlWnN9BECcCLVdZ7rL8ki+H/dKXDf/STvg/h+6qhnjBQfApnbduMDrPo6qq?=
 =?us-ascii?Q?htwOm/QJBHLZE6i6WhoCVpQF5mr/cRy2BgoR9fWPcGI/2V8dFTB/aM60wecv?=
 =?us-ascii?Q?zT/N7XCQ3VxwiD1F+2PMQAou0nO/3grb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2I2+n2sMOXdcVTdSNzhopvTm8p2buqVGk0bOjJdU0OSLOpCaXAa/dnBpGLEH?=
 =?us-ascii?Q?5F83u2RWN3wJ5F/ZKZm48G3+wV5R62y+jekhYijv5KcPmy2tmpWXwM/KhY5P?=
 =?us-ascii?Q?KQm5/pz7DV4bjxnlYnS1X8f26KaPswU1w5R5t/uXnEskIOMlci51Qo7jBb9s?=
 =?us-ascii?Q?PulQgEf1m9+o/2WGU5DH3YhbbVUvWiW91yrr/NVaGbPKSKjzQvpi9vpWvWjA?=
 =?us-ascii?Q?ymoyF78EpSfqnCLA7yILZz7nsrQkmFDBOXeRDyJjq+ILEbT/+oXx7im2xp50?=
 =?us-ascii?Q?1/+uLxmmwqmOxUeIwntoUvXtAgSN6NbhYElIaekIAjV9AKGfRPzlpTIVxn2W?=
 =?us-ascii?Q?0z9W05xt1gh0p/GmVvCdzUJz28/sSQP0lhumcZWf3Gw42RtbGeG1yafUYRMC?=
 =?us-ascii?Q?5sj2EUJ+h4DocRlQBHuLxmkrK7iX/RxFH6BfS/rP9Mj2EoaQJNBj06hDi2nj?=
 =?us-ascii?Q?p8+jUnrxzdJlfqJe5nIPXwCyKSXfRdOP7q//KTlcoFS26cYAXN+mF/HQ+38E?=
 =?us-ascii?Q?jGmgFDRtNKpB9aTJOAWoP0QMN7SbvWw5USAMmqfW6BuPKeJjmfg64u/+dVrH?=
 =?us-ascii?Q?sDMShNw6x5U+6hAwt0Os4wkkDKKEvEgycJpUk8Lz3LQV80JCuWKRL1iNuYJm?=
 =?us-ascii?Q?otPAYzCVHb1J/9K+a+HR+tl4k0Jg7ObN4TVpLoMo3HK+HQM5mSGCaRvrpCZQ?=
 =?us-ascii?Q?fmYTZKUfdXtEzUq2VumaKV1kTYHF/IrCpP3/UUg09bLg4mB0sPiPF/OqhLoR?=
 =?us-ascii?Q?GXU0T3Fr4D+0TZSxbFX1ukNFZki6Yzot/WZ83GI5XCU9HuAR8Z/9qYkIPLdv?=
 =?us-ascii?Q?ecTPYxrLWICUN8CSJNiCQWAXpt3SqiGXTpMuUHhcudsG2xEGAuWCmq1p9Crq?=
 =?us-ascii?Q?jGZigsd249dxyWM9KlaxbpdIh90AP4bsxA9+fYF+HMvGGB8MdJb/mqyjr7Sm?=
 =?us-ascii?Q?Iun0XOS0J8lw6ShRrOMiaGj6YdsXTTFbox6oaqFRKeZsyyEyM7PofChQ+1JI?=
 =?us-ascii?Q?jwHCaQceLReQPnQ+Q3OBXt5INoAtV5NA2yxhhg8l10txloXrJiwsQ+OORn/c?=
 =?us-ascii?Q?Eg/aY8NQsF3NtUdrJiwjmPBDi5UnAogzS7pqztGhj38MnIX03VLvwluF+ovM?=
 =?us-ascii?Q?r5O6gYQNxgaZKRPwpPx0L5XuY931e+4/kuRHxS6nDnd4iCU9oXaf2q7QN/aR?=
 =?us-ascii?Q?zrMqghdeJjsd8eFqCZK9k7GmhpGbvdS5iMbEg/UWhVCqqN/TVPjXu7imzVbL?=
 =?us-ascii?Q?Ay5rOE2J3HKeXEmQHfkckjGcByIpEf+m/B0c/UCI8I8Lcb4IEVcxhVbkmvwX?=
 =?us-ascii?Q?fSIR5n9iHy5FIMCHEBzFihVbQRWHVBYOCp22asxuHN1kbD2C+HQ/Fw8bxmWc?=
 =?us-ascii?Q?x4gLRzbRZSamC7gQeWIhFQVZTeAgM9Ftv16kdSI7GhdOs+RdU5uee32gJqDi?=
 =?us-ascii?Q?uN+/G/+k1hUvmUQGnwIUnadYXcdPe0k/yHdNJod5lv6/lnLXvJDDiJZkJy+S?=
 =?us-ascii?Q?LEMCV+2nWNKWbuCN2nFEv/k/JR4MTsMypiWJ7/BRcLu2nOn/S32GyeSNaQuH?=
 =?us-ascii?Q?ymEBn0VhGOs+kpWkj1tiZRssPbc5JQAVyY7vZVC23wy8h9f8m6roShW6BcrL?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2am32CdOPV5mdkVXOB0iB3rJpldHUAC+dq8wnQz3oy6LWSJ3lHfbp8v4wKVNs31XX4j1j/0VK6H2u0QIx0X38T3tebwGBBjw29+8tRfEpy3zJiFucWCrH21tHT1vkpnOG7SLjn0RD9kI+FVgx5iYE65g4/UkaazIxkX8FHk29gocFzUEhauwscaXJx5DDNrw/iP287AWIaKM1eraT6g42r+6W0zUQH2GTJUlmtqy/3RRiCbwcKH9aV7ED85fafGsORaZ0I5aSaZZ6qNZPSh8g+lGCgi1jibJZPq+1Ff+xzM1fN1QfUN0uQA9jbr/h7jb9/h9ba7cPvAJwfIB0XmLw6u1+Vt19f/RSCaN86I4tiERjCQz0+Iun9GjpON79Hj9i0FnP1mLL0Dq133OKXK7qMnChwOZFcNaIxmiHd8YP2TvIRPtuxzRUYcPSQ5iUJ532Uf1yz/Vq8IkLMip3KglQmQmOVi5/tK+1SYBamGdLajZguwvmdcavbzYYQhxHUxHwye24NgWyjALIh0zh3yL4zREuEyCo+yTbpATnlc872nWEkWbBv9NmHt4vuhZryDu668UknZdYCPSbwNZwTZBmznxW68uX3BB/kkkKQgqlak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c06d2-439e-41a9-015d-08de1ad51820
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:46.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6t/+8BMd9EIudiQHYNpA+j9x7NgB7hvXAjZ83SGmUoArTfuL0iqDqEiZVdG/Nqihwph8V/CLJLzGNBz4MIEIMxRMtmZPf3ld25QfSNQ9ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfX+6Ox4x/0+bdu
 PHyuHz4d4xOl0MsiUMhu5xpfVPTRPgzEMmICTNNw01+cT7bRBLfsjhepN0FgbyIaLanC14yo0ZD
 8qDYUfNTftsDJLjmdk86vo5wen0R6G1uLtZBXXU61EPhjysmYKT3f4ZpicAT1LRyMfx2eIxwKyh
 fp/fvWC1kHHfbSYNLn5F7pCMWqPo5JW3vD0BUncKlN5SPcLib7J2CgelJKNuCGDofngI1u5kPJ0
 jPLdtnXuWlXarLPDSjUX9eENae+os2IcDQOEOakUx5rEpMqD49/i996BN9P+09yDcaHHbUoWvlc
 sEzXdNiCCBM0sWixkzwC7pDNObuAqXESYj3muVZYeaSKV55GPLIiVMaZWlTAlv9TTePzBYjralr
 2x4x5YT6P6y4ws3yJdH7oI4u4SXYagJsK9Fico0fj69YG8SVm+k=
X-Proofpoint-GUID: GM8-RzTcd5bdfsZsIDBuDXt1jfxeO-J0
X-Proofpoint-ORIG-GUID: GM8-RzTcd5bdfsZsIDBuDXt1jfxeO-J0
X-Authority-Analysis: v=2.4 cv=P7U3RyAu c=1 sm=1 tr=0 ts=6908a0f3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jXjnEuVU91_iq225JjgA:9 cc=ntf awl=host:12123

There is simply no need for the hugely confusing concept of 'non-swap' swap
entries now we have the concept of leaf entries and relevant leafent_xxx()
helpers.

Adjust all callers to use these instead and remove non_swap_entry()
altogether.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/gmap_helpers.c | 18 +++++++++---------
 arch/s390/mm/pgtable.c      | 12 ++++++------
 fs/proc/task_mmu.c          | 12 ++++++------
 include/linux/swapops.h     |  5 -----
 mm/filemap.c                |  2 +-
 mm/hmm.c                    | 16 ++++++++--------
 mm/madvise.c                |  2 +-
 mm/memory.c                 | 36 ++++++++++++++++++------------------
 mm/mincore.c                |  2 +-
 mm/userfaultfd.c            | 24 ++++++++++++------------
 10 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d4c3c36855e2..0cf856f38ade 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -11,27 +11,27 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagewalk.h>
 #include <linux/ksm.h>
 #include <asm/gmap_helpers.h>
 #include <asm/pgtable.h>
 
 /**
- * ptep_zap_swap_entry() - discard a swap entry.
+ * ptep_zap_leaf_entry() - discard a leaf entry.
  * @mm: the mm
- * @entry: the swap entry that needs to be zapped
+ * @entry: the leaf entry that needs to be zapped
  *
- * Discards the given swap entry. If the swap entry was an actual swap
+ * Discards the given leaf entry. If the leaf entry was an actual swap
  * entry (and not a migration entry, for example), the actual swapped
  * page is also discarded from swap.
  */
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_leaf_entry(struct mm_struct *mm, leaf_entry_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (leafent_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry))
-		dec_mm_counter(mm, mm_counter(pfn_swap_entry_folio(entry)));
+	else if (leafent_is_migration(entry))
+		dec_mm_counter(mm, mm_counter(leafent_to_folio(entry)));
 	free_swap_and_cache(entry);
 }
 
@@ -66,7 +66,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 		preempt_disable();
 		pgste = pgste_get_lock(ptep);
 
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(*ptep));
+		ptep_zap_leaf_entry(mm, leafent_from_pte(*ptep));
 		pte_clear(mm, vmaddr, ptep);
 
 		pgste_set_unlock(ptep, pgste);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..7805c5a3755e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -16,7 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/sysctl.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
@@ -683,12 +683,12 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 	pgste_set_unlock(ptep, pgste);
 }
 
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_leaf_entry(struct mm_struct *mm, leaf_entry_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (leafent_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry)) {
-		struct folio *folio = pfn_swap_entry_folio(entry);
+	else if (leafent_is_migration(entry)) {
+		const struct folio *folio = leafent_to_folio(entry);
 
 		dec_mm_counter(mm, mm_counter(folio));
 	}
@@ -710,7 +710,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 	if (!reset && pte_swap(pte) &&
 	    ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
 	     (pgstev & _PGSTE_GPS_ZERO))) {
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(pte));
+		ptep_zap_leaf_entry(mm, leafent_from_pte(pte));
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0ccdc21e60e0..1df735d6b938 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1020,13 +1020,13 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else if (pte_none(ptent)) {
 		smaps_pte_hole_lookup(addr, walk);
 	} else {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+		const leaf_entry_t entry = leafent_from_pte(ptent);
 
-		if (!non_swap_entry(swpent)) {
+		if (leafent_is_swap(entry)) {
 			int mapcount;
 
 			mss->swap += PAGE_SIZE;
-			mapcount = swp_swapcount(swpent);
+			mapcount = swp_swapcount(entry);
 			if (mapcount >= 2) {
 				u64 pss_delta = (u64)PAGE_SIZE << PSS_SHIFT;
 
@@ -1035,10 +1035,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			} else {
 				mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
 			}
-		} else if (is_pfn_swap_entry(swpent)) {
-			if (is_device_private_entry(swpent))
+		} else if (leafent_has_pfn(entry)) {
+			if (leafent_is_device_private(entry))
 				present = true;
-			page = pfn_swap_entry_to_page(swpent);
+			page = leafent_to_page(entry);
 		}
 	}
 
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 41cfc6d59054..c8e6f927da48 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -492,10 +492,5 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static inline int non_swap_entry(swp_entry_t entry)
-{
-	return swp_type(entry) >= MAX_SWAPFILES;
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index eb1f994291d8..980ea9f20993 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4566,7 +4566,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
 				/* swapin error results in poisoned entry */
-				if (non_swap_entry(swp))
+				if (!leafent_is_swap(swp))
 					goto resched;
 
 				/*
diff --git a/mm/hmm.c b/mm/hmm.c
index cbcabc48974f..831ef855a55a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -253,17 +253,17 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	}
 
 	if (!pte_present(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const leaf_entry_t entry = leafent_from_pte(pte);
 
 		/*
 		 * Don't fault in device private pages owned by the caller,
 		 * just report the PFN.
 		 */
-		if (is_device_private_entry(entry) &&
-		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
+		if (leafent_is_device_private(entry) &&
+		    page_pgmap(leafent_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
-			if (is_writable_device_private_entry(entry))
+			if (leafent_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
 			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
 			goto out;
@@ -274,16 +274,16 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		if (!required_fault)
 			goto out;
 
-		if (!non_swap_entry(entry))
+		if (leafent_is_swap(entry))
 			goto fault;
 
-		if (is_device_private_entry(entry))
+		if (leafent_is_device_private(entry))
 			goto fault;
 
-		if (is_device_exclusive_entry(entry))
+		if (leafent_is_device_exclusive(entry))
 			goto fault;
 
-		if (is_migration_entry(entry)) {
+		if (leafent_is_migration(entry)) {
 			pte_unmap(ptep);
 			hmm_vma_walk->last = addr;
 			migration_entry_wait(walk->mm, pmdp, addr);
diff --git a/mm/madvise.c b/mm/madvise.c
index 900f0f29e77b..67bdfcb315b3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -249,7 +249,7 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 			continue;
 		entry = radix_to_swp_entry(folio);
 		/* There might be swapin error entries in shmem mapping. */
-		if (non_swap_entry(entry))
+		if (!leafent_is_swap(entry))
 			continue;
 
 		addr = vma->vm_start +
diff --git a/mm/memory.c b/mm/memory.c
index 1412fc84172d..3d118618bdeb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -932,7 +932,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct folio *folio;
 	struct page *page;
 
-	if (likely(!non_swap_entry(entry))) {
+	if (likely(leafent_is_swap(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
 
@@ -950,12 +950,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 		rss[MM_SWAPENTS]++;
-	} else if (is_migration_entry(entry)) {
-		folio = pfn_swap_entry_folio(entry);
+	} else if (leafent_is_migration(entry)) {
+		folio = leafent_to_folio(entry);
 
 		rss[mm_counter(folio)]++;
 
-		if (!is_readable_migration_entry(entry) &&
+		if (!leafent_is_migration_read(entry) &&
 				is_cow_mapping(vm_flags)) {
 			/*
 			 * COW mappings require pages in both parent and child
@@ -964,15 +964,15 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			 */
 			entry = make_readable_migration_entry(
 							swp_offset(entry));
-			pte = swp_entry_to_pte(entry);
+			pte = leafent_to_pte(entry);
 			if (pte_swp_soft_dirty(orig_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(orig_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_private_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+	} else if (leafent_is_device_private(entry)) {
+		page = leafent_to_page(entry);
 		folio = page_folio(page);
 
 		/*
@@ -996,7 +996,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * when a device driver is involved (you cannot easily
 		 * save and restore device driver state).
 		 */
-		if (is_writable_device_private_entry(entry) &&
+		if (leafent_is_device_private_write(entry) &&
 		    is_cow_mapping(vm_flags)) {
 			entry = make_readable_device_private_entry(
 							swp_offset(entry));
@@ -1005,7 +1005,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_exclusive_entry(entry)) {
+	} else if (leafent_is_device_exclusive(entry)) {
 		/*
 		 * Make device exclusive entries present by restoring the
 		 * original entry then copying as for a present pte. Device
@@ -4635,7 +4635,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool exclusive = false;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4647,15 +4647,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
-	if (unlikely(non_swap_entry(entry))) {
-		if (is_migration_entry(entry)) {
+	entry = leafent_from_pte(vmf->orig_pte);
+	if (unlikely(!leafent_is_swap(entry))) {
+		if (leafent_is_migration(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
-		} else if (is_device_exclusive_entry(entry)) {
-			vmf->page = pfn_swap_entry_to_page(entry);
+		} else if (leafent_is_device_exclusive(entry)) {
+			vmf->page = leafent_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-		} else if (is_device_private_entry(entry)) {
+		} else if (leafent_is_device_private(entry)) {
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4666,7 +4666,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				goto out;
 			}
 
-			vmf->page = pfn_swap_entry_to_page(entry);
+			vmf->page = leafent_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (unlikely(!vmf->pte ||
@@ -4690,7 +4690,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			} else {
 				pte_unmap_unlock(vmf->pte, vmf->ptl);
 			}
-		} else if (is_hwpoison_entry(entry)) {
+		} else if (leafent_is_hwpoison(entry)) {
 			ret = VM_FAULT_HWPOISON;
 		} else if (leafent_is_marker(entry)) {
 			ret = handle_pte_marker(vmf);
diff --git a/mm/mincore.c b/mm/mincore.c
index e77c5bc88fc7..a1f48df5564e 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -74,7 +74,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 	 * absent. Page table may contain migration or hwpoison
 	 * entries which are always uptodate.
 	 */
-	if (non_swap_entry(entry))
+	if (!leafent_is_swap(entry))
 		return !shmem;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 055ec1050776..d11fa8eeaef2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1256,7 +1256,6 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 			    unsigned long dst_addr, unsigned long src_addr,
 			    unsigned long len, __u64 mode)
 {
-	swp_entry_t entry;
 	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
@@ -1430,19 +1429,20 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 					orig_dst_pte, orig_src_pte, dst_pmd,
 					dst_pmdval, dst_ptl, src_ptl, &src_folio,
 					len);
-	} else {
+	} else { /* !pte_present() */
 		struct folio *folio = NULL;
+		const leaf_entry_t entry = leafent_from_pte(orig_src_pte);
 
-		entry = pte_to_swp_entry(orig_src_pte);
-		if (non_swap_entry(entry)) {
-			if (is_migration_entry(entry)) {
-				pte_unmap(src_pte);
-				pte_unmap(dst_pte);
-				src_pte = dst_pte = NULL;
-				migration_entry_wait(mm, src_pmd, src_addr);
-				ret = -EAGAIN;
-			} else
-				ret = -EFAULT;
+		if (leafent_is_migration(entry)) {
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
+			src_pte = dst_pte = NULL;
+			migration_entry_wait(mm, src_pmd, src_addr);
+
+			ret = -EAGAIN;
+			goto out;
+		} else if (!leafent_is_swap(entry)) {
+			ret = -EFAULT;
 			goto out;
 		}
 
-- 
2.51.0


