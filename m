Return-Path: <linux-fsdevel+bounces-66759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B00C2BB02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2BE3B6F05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565130CD98;
	Mon,  3 Nov 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jul6ITvl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tyv0uts+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1D30AD1A;
	Mon,  3 Nov 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173228; cv=fail; b=sj22wlYEbxiNFbs/pLiur07yOheMjtkuQUKk6r3n9m5T0fR4kVirkkjX5k+zAhTUVuXJsgzJaSa9LDZXJClO11pDZPr3ArCZTv2IemhH3RAfzuvOR42T9tUpSac8/axU2+qiY1ByJzLMVACgfh8gOCmzLQkE4XrJSt3iIEPiWtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173228; c=relaxed/simple;
	bh=wEswhEPB/UrhDyPK9C9sI1IHFlT5+kgMCKmd18ehtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUwbg0BemrzNGiTYWHbXpD2oHEQOAal9eRxygYWJwOeJ2uM8kbmU4zDTEwBxtzl1jKnBuyBviuV+o9GqUO1uq1x6LINdiK98L2QSIMYHOZZR14Kv4a+/RYjtxtUeWSA5w6PsjHUUHlzrYSpkfiobyOoWBiH3vt8Vdp2OlACrsaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jul6ITvl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tyv0uts+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTdoD019181;
	Mon, 3 Nov 2025 12:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=; b=
	Jul6ITvl1FqKpcPYqWVpvgiEcaVw5IlPT5OXCJtbLNttt/GfrFq8YjzV63eND8IS
	Lfx3AyzTTxQUmuOiBcpTGND5t9ilxYvj3UL86voG6EIiNhaAE9O8HhF0Eu57ruTG
	QLC1qOLN6rmjmPujJq2nUp+F4Xnrt0N6WRKLtWO3R7PAPc8QxZo6sSe3fQKqLIMK
	jx/+NYHNS5dGpH5JNBIbK1ijw6snClVqEJWuzDQcZTn7haeyHK3jpau6vfjWyVdZ
	puDDpXlKPbaDOjFSqzzcjtO9XM2+4qSevvIoCLLmgp1gVwklzMjzWM3oIq0Agz5w
	4aHygWM91cLQ9bNjCa1jRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6ven808r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BQYUx039758;
	Mon, 3 Nov 2025 12:32:37 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhux7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9054xQ4NV+44y4YYch76//RUOCadTeG3h9GURGb5zYREiFETUpJ1UT4uHPu0UKUiX1r1DQ71CP31LPGlnu0sQ0UkeYMFQ5rDvt3Dm3iybTqFkwXYURuJdIFjo5R+rb0oFcFpg1kbddEaumpS0KwUr4NHHxmnRg1H6yTQ0K3i4PkUaX6ZySMi5THYmsZfsPXU7CnAJguZEFLC7ZPghYCTLR6LCijQC/lh33njH68IbkccDwwgO2kwhWHBfdDK6jXedZ1iYnjpHCFVwXYoCfP1Xw7ISduxQZWlEdKcwWn9dfSgCSNB4T8bpL6mPHfq2Gdi7h2nQrERAXKFU14O+XKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=;
 b=OBDzDyVd/iuL0cAXd9bMNbcDYZXxLwbIYimi4n37HMAOOi5HTjPkW6T/doY3CRDGMhDrSKq1zyV487Jq+vOUBvooU4m7a8MjbsQrrCqIuAnNt9hsWA+LB/nL001neECbMyri3y8FojMKoq2CPhfuRI8sZ3R9SbWu6WrH8/3fP0VzBGRRKGUmuAqzdPUmUtL5G7x4IRln1BmmSH51vYQs1gw2z3Kpj0LW1sk1KE2fT2G9QsQMSrvkzFPcl9gP41I1rwlBh3xY1MzSHhXVcMT9Cbfwip47ykzN/n+WRBNiCcbOyMCcP63PbM7Ijfd1BrB5xAicWd54YMz1gTsy6NJwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES+ODnUpx6m2BxJg2i8m0/ywBdmg7etQq70a9R7KC9k=;
 b=tyv0uts+ZHiVhtsFuKJvAIAxiDlhoqpubu6r2jKQ0/Rn2MR1G5nKbMcBnKV3sA1YgmPZn3OBPnZbOyI3xa3ACgbqKhLux3Mz8Kb5mN31JZaUfBtfj8oBJRnHuT/asTLcPDNj+D8JZKJ+ZOcV2Sx7RRMNBXNPdjuhM0s12LqbmjI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:34 +0000
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
Subject: [PATCH 09/16] mm/huge_memory: refactor change_huge_pmd() non-present logic
Date: Mon,  3 Nov 2025 12:31:50 +0000
Message-ID: <9e8089923649205975e9ae39c9f628b7ce8b06d9.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d6d0c5-d4ac-4ad2-e24f-08de1ad510a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugqtwimc0/B1xWcF0tkz/KMrrAiYTydOF+XSzPXi8fnBM9CVK2pRhBx7BKba?=
 =?us-ascii?Q?m/USBhJEG8k4o/uRgTSdReIS0vdUwAM7jTNLf1KL10oUWoNrNTFvb40EDN9F?=
 =?us-ascii?Q?dCxJ/g238+3J7Rp6CePV53PXtliddKoLeeGUazjEToMj9T2j2JQZo4R0Q7dV?=
 =?us-ascii?Q?4zki3hU7BnV2VCewqf11jNQ4LzJhp3AHbfB5MTs9akzgwKMUH5e9vFrPdXzf?=
 =?us-ascii?Q?aOc09IxZ8Ii5w4OyEiCprf8l7QJoFWhpmofo2UjWarRb5yjs/xfcZXh2ROxy?=
 =?us-ascii?Q?PX0aTtO0PqyAZvAnvxTgRNG2YJIIndGjfKiuuUX2z9tuvsg+QtFMlwuBu+bb?=
 =?us-ascii?Q?CswE8Dfvvtv9tNvg6YzkHY012ha6SCWx3sNQnJkIbSS62ZByrB05tZkf8A3t?=
 =?us-ascii?Q?9unEl/3iGWkN2jwPkDqSpbvtc7vlTwn0r+OC5968Kjd5AaCZGDnkdthk9l9a?=
 =?us-ascii?Q?HJL+aQYfZTYJE2oym8PJv+2y/GeGR8q0shn8K6cy0CnPrsIvax3GRjAddekR?=
 =?us-ascii?Q?eQcwFUqb8gzG/rDq+Itbg7QeRQI0gSGWPot9+PziAsFxWY5tamc1PG1HSnYI?=
 =?us-ascii?Q?dqQ36RvuwE7y+MMu9ZD26PmyyHTAmp18pVte+7kS3X+TEbpbkVC4kI3DKRU0?=
 =?us-ascii?Q?zcn4wKG4YfyrIIxskIwPToiU0fzpomQGIlsUFBwhHUls3GqCFWiT+q1Bl3BM?=
 =?us-ascii?Q?ClWXk5Fw3JZwR4V+UQO9n5/TccTnf6+gxbVjseAr9Zu1cktHUOGwYZTbuy0x?=
 =?us-ascii?Q?KwZC3+R+PPHFUaaQyJ02HSkg7nQEEKJU8GaB/qO0Ys+jPIUAyEotF8oKnppQ?=
 =?us-ascii?Q?1pgfn1+ZOlVX6CWAQKjCC16JF5qtQrZyLmMDU4MXcSdAky7v2nxNUrkw3yuE?=
 =?us-ascii?Q?k3VgIGl3cyGC40f8InbJBBz/e1YXXXbufnoiahsukVgKYrMa757vdFe5DGQr?=
 =?us-ascii?Q?ME9fMt2eT9qEmDTKcUuc0r69+OfvSN33qc6L6gPWEFEYl1JkYneJTqUEq6f4?=
 =?us-ascii?Q?LfGGTXyilqnz2c9vTjeyhzHxwrQhBcjklsczOgl3alhSL/8UriEg4cKufdxV?=
 =?us-ascii?Q?+BjBPNZo2JAIMYAPhqGUplDGfyfedO2GmaUWh9WZEY6ROnmlwMd/Lub9BxcS?=
 =?us-ascii?Q?Bluhq1Iatk3WLTdSs4fxDNeyXiM9uhTebZyfDcif7Ge5DOdinRUw/PcNL3Ew?=
 =?us-ascii?Q?qsuA9FXETzgczFUVYvdqPuQ+iuMxXIckOD0rh9cZA0kAy0+O4K/O74g49DOk?=
 =?us-ascii?Q?rNZT7tFEmhjh/Ne3QMaOTl7lspcw6W5aXsmvVJBG3+y5JLT72/n7FcV7M6ZR?=
 =?us-ascii?Q?q6GV7dliVn1Vt98daeik8PlwhPqqwUYpRUoeVoFp52OVhfb6LSPzXlWhAqFl?=
 =?us-ascii?Q?gvP3YclK788W0TVvjf3N2nnsXt9EotDc8WyMKCHQmy2oU2R+EecC5ZgIEAsE?=
 =?us-ascii?Q?Sz/aJoTX63rPE/Fk1Yl5wsuIy1HrvpBl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juETJf4OrGyvNf8rWyCoU5r6GBrdOEWQMMBfqikFE7nfwa/u6Olli+99QhyA?=
 =?us-ascii?Q?urZZRicSMVAAOsi2tHKX3/OvLdWCRNdNaWmd9DWWhq6RrYdLvMLrZIze9epw?=
 =?us-ascii?Q?YHnG2Gs4B9nCxQNL0CxPjN5vsMkI/nB+l2LQY/+pYrNj7zKyfACm3+KRR3CR?=
 =?us-ascii?Q?aASEcGErwH0aTvRhakzvhCjr9SZFFmYsN67Ax+1CvK2HMuOUsc3ShmjfLnR7?=
 =?us-ascii?Q?tK+bSesr20uumfZxUTwMAsPi8NvehlrwHtgjwTrYlelN36STNx7JmfxhZVr2?=
 =?us-ascii?Q?pf7LG68lQXohDOLftq9t3bEqMZiMKgLl9JJyURespO0v/h4emSD0og5VPXkQ?=
 =?us-ascii?Q?AETiXbRXZOMJMW4qS0/3bWxEWLwMcKu/eXEwB/4DKjpvASrat52CKCTiX2lb?=
 =?us-ascii?Q?iKxfPTMAvGnAnamkoBgR9rB/tLSmHtZRGXn4UYR9fhsE08UwQDPKQf95VOra?=
 =?us-ascii?Q?PCbyLTlyW1+VB62oDLfOF3Z9NcL+apzP+mgUF6hLjnSc1WGqYt+x5apJnp5a?=
 =?us-ascii?Q?muPqziWFsLM5ifC+OoyhU8/56PcZxkM4iyhSP94WDKp5c/zOKQULydr+C8RO?=
 =?us-ascii?Q?4Ikr+FFHHqb54rXeHMGUzmpdhegidh7V1xKFd0+awSzURmDOR8kgi5jeo7zB?=
 =?us-ascii?Q?aMGcyWwTIKi4enyjJ0o6y5jqXFy00gN1MfK31VLRcTPxwSdhESbelr7CewMx?=
 =?us-ascii?Q?NJGKv2gY1u5A1fkvGZGzlcaAj0kU57rd9u8hkdvI+f7RhQOVZOgX3/YOGWEz?=
 =?us-ascii?Q?y6zehtjUxp4cx/0MZCZnQS8wv0b7faAyqGHolvQ52L8h3T2RFsEOprCGxhxV?=
 =?us-ascii?Q?vk9Vh6s4mjhyjzOOrT5zfNuzaK0NlwsG8RvjGZ9qHj7Fi3pvCJB1NCjJr+cd?=
 =?us-ascii?Q?BNWTFoT2mZxfwpGZRQEnkgQ/J2UywfbjYrlM2W9oyUAuoFlzvt2aw9krqCJs?=
 =?us-ascii?Q?SFQesw3RcsvCPqYF3yuhJhfpaGl++vCbv1te7QJqdoL4lUORu8FiI9dVBhZQ?=
 =?us-ascii?Q?ufa/eLIQSEzoXYjugr7vjYllv8h8s+6F77Xy7MjiWSiqzwKk0NvNgnd1IPdG?=
 =?us-ascii?Q?znKx1jAyeCE8X2wJwtryLjIUSxuKege7iQ3Si9WeUJLSdchAdDR+PZyY6aki?=
 =?us-ascii?Q?3nX5duzZKE7upeRa9wSAaA1cj0+39SRxrvOyMuVsgy0IxLzUbeh6SAi7xgwH?=
 =?us-ascii?Q?CecrlIJgdrA/LqZHX2gNA5nQNlnuTDb69MuUBjgibQSVugC6/olfRdTy8YOn?=
 =?us-ascii?Q?9ewF5VJfG9Nb4AYEJqb+2exobKEGq6SMrkjAOX+cTctNc3QfAtd4WQx7r1i/?=
 =?us-ascii?Q?mPcXrbkgUapDRWJRip7s920ee8qkAoRr+49iFJ3/vbo4PKlGYvnDKmZ8JRFk?=
 =?us-ascii?Q?cAiuzMc2WDafDH47oaDM9Q1wbFULm9teD06pp7MQ3lUYXd4DE8JpVt6kvM37?=
 =?us-ascii?Q?R0MsiMB9i7kCz4eRUG2mNvIH12K8NzQ2GdwA+122ThY7RkOE/wgDxy0b0q96?=
 =?us-ascii?Q?2iUUjDGJVmjHfyv3cm1t4b/D2Gs1ZoYaLmMjXTJuRdTiRHZu0GxKQUylx3EO?=
 =?us-ascii?Q?jQ6JV1FYTHUmywMVcUZL2MnX3rwJkhSdgVoM5fbIgyuhLfXTXrvVlMvGP5lz?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mia1wwCrr6OdHK5gWlBYugzfDxctpIUElx0A4JaEDx3cKgLZ+3XTggrY49LBGcrsPejFZzViDGFHd+NJSw9EDU/FjOshXQ9ufqOkWjSFoethxShLTiJQFZyTSj1xIXkg+TlVNxj60SpeNJNOsrdXr/LzELAff78iK/Och+pueHiud4vu4b3ixReDvdOrsx/kSBz77KrMtxvikaziVlLplKQ94Q1C+GSvmLzitwLxjU/Dv0DMTFZkDHAUUqy6ejElIZAjGkxzdle/MPewTOua0AN6AXDwwKb8vRhHsG+1dT3m4tnCCcVHBYl27wMBa/jWQ5XSVt+xIFZUhItu1+qDjB+mhBhjbhlylVglJSTcpTMYqfDYUuhHy/63oYV5+ZTjaml2/MObzyMLhztbwVTQHGFMW9ZOBrWUuaj1zSU5iWL2SLYxoXOAThhCrA6nH/Eb1sFvpvsRx8MZg9YJ+EclvUscN74ImsI2s3cfYfrswtreX//1reMkrGVC80tmKRJpUhyFw1l4zswuzeRGhjmnDswi/kyQkgW2OHUsmCO6FBDnG8Xlj5u6EBvLlyF2NfLqU8QNm3vVRbnoNr2UbRiXVchAHzMTYgoi2QM1ztXUGyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d6d0c5-d4ac-4ad2-e24f-08de1ad510a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:34.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9Qy1rl7kuaVjw/ycy3GBVmU525cSdV4x6gTyQtXTqk7v+/eQkNdysSQPNMT/7hYr4VjMfQ7Y29pel3GVrj1+efDMH30tsOR7avTW9HjxNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-GUID: H-PPbuuIxN6ZPQNu7dlbJ1txbwa1nzqP
X-Proofpoint-ORIG-GUID: H-PPbuuIxN6ZPQNu7dlbJ1txbwa1nzqP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfXzkL5AWZnTkP3
 ZXqrUeVDaCB7j6wYHQEst7Oghd9k5UZz7Jzxac4nG2zwBEMe8UOyXNj/5afINjDs9VFBoNw0FRR
 ak8VQvAfQPTZYvKaeBzRIHLHeXg34IQ/AAGc3x9/5B8DhhmdFHEgbUXRJ+DUc5/gDaGcLPtYFuN
 bb3xriCDGCytSzZ6kbC2hHrxvJJn43SfeCDCmyQqGZfTF9v9r+BMhIE4+sMTHUkk/jM+ekcLD1n
 w2WxG4prREn/TaxUvFc9HGL+b8wIJNIbmycy5DmZxxMTXnTU7ulk8HWvHfrJgu7R+5YqtUs+1yQ
 Gwp5HK9j7a1Cth+iHsbvb7KPciAKA1Ieg3cXextHutmH1VnDfDLJ6IgqnAIWEFZ3o/Q3U68tLzg
 /ut5EslzrolhH9DmsjikNb1yQPzpp4wAIBKyruTG0JTkGh9+uLM=
X-Authority-Analysis: v=2.4 cv=MvBfKmae c=1 sm=1 tr=0 ts=6908a0e7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gAL6uhOEssAPNySJDCYA:9 cc=ntf awl=host:12124

Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
use thp_migration_supported() consistently.

Resolve this by separating out this logic and introduce
change_non_present_huge_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 72 ++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31116d69e289..40a8a2c1e080 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2499,6 +2499,42 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	return false;
 }
 
+static void change_non_present_huge_pmd(struct mm_struct *mm,
+		unsigned long addr, pmd_t *pmd, bool uffd_wp,
+		bool uffd_wp_resolve)
+{
+	swp_entry_t entry = pmd_to_swp_entry(*pmd);
+	struct folio *folio = pfn_swap_entry_folio(entry);
+	pmd_t newpmd;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
+	if (is_writable_migration_entry(entry)) {
+		/*
+		 * A protection check is difficult so
+		 * just be safe and disable write
+		 */
+		if (folio_test_anon(folio))
+			entry = make_readable_exclusive_migration_entry(swp_offset(entry));
+		else
+			entry = make_readable_migration_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*pmd))
+			newpmd = pmd_swp_mksoft_dirty(newpmd);
+	} else if (is_writable_device_private_entry(entry)) {
+		entry = make_readable_device_private_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+	} else {
+		newpmd = *pmd;
+	}
+
+	if (uffd_wp)
+		newpmd = pmd_swp_mkuffd_wp(newpmd);
+	else if (uffd_wp_resolve)
+		newpmd = pmd_swp_clear_uffd_wp(newpmd);
+	if (!pmd_same(*pmd, newpmd))
+		set_pmd_at(mm, addr, pmd, newpmd);
+}
+
 /*
  * Returns
  *  - 0 if PMD could not be locked
@@ -2527,41 +2563,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (is_swap_pmd(*pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct folio *folio = pfn_swap_entry_folio(entry);
-		pmd_t newpmd;
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-		if (is_writable_migration_entry(entry)) {
-			/*
-			 * A protection check is difficult so
-			 * just be safe and disable write
-			 */
-			if (folio_test_anon(folio))
-				entry = make_readable_exclusive_migration_entry(swp_offset(entry));
-			else
-				entry = make_readable_migration_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*pmd))
-				newpmd = pmd_swp_mksoft_dirty(newpmd);
-		} else if (is_writable_device_private_entry(entry)) {
-			entry = make_readable_device_private_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-		} else {
-			newpmd = *pmd;
-		}
-
-		if (uffd_wp)
-			newpmd = pmd_swp_mkuffd_wp(newpmd);
-		else if (uffd_wp_resolve)
-			newpmd = pmd_swp_clear_uffd_wp(newpmd);
-		if (!pmd_same(*pmd, newpmd))
-			set_pmd_at(mm, addr, pmd, newpmd);
+	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
+					    uffd_wp_resolve);
 		goto unlock;
 	}
-#endif
 
 	if (prot_numa) {
 
-- 
2.51.0


