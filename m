Return-Path: <linux-fsdevel+bounces-67195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A66C37981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7491895C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F30343210;
	Wed,  5 Nov 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pe9z5wHi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="plTvXWVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C9320CD1;
	Wed,  5 Nov 2025 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372637; cv=fail; b=TXCXGwBQwtlPAgzEEgg20VHSq7q9TsfBpeOZf9UQgVIWI+XBoSQ6zIQ9tAk+hnpohFWtP38gNTCK1g1sJHBj2R29bBNaPLW0jZB9p4jc3RuO03bHmVIiFvSJFo+AiiRJZwmWSfG8uUx/5CUXyiX8dOWHOD6zeaEUWP7BMZ4YaGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372637; c=relaxed/simple;
	bh=/FFVpZGYYqWPHxXUfQ449/r+KqZtTqQOuIL31Zy+Gf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huQ1R5bpW2QdxipwzxCvvg9FKR7X7fHPAMLvrr3aAvUjJpURoCv1w4gXiHvL/71sYNAhN6Wsk1fn5N+9TPffPwiuoNobgpdTbUR2aBFB7INdYGAg4juIia8fBHMYxkR6FZyxZKBZWHiA7rJY4pte7dzIzzIrw6AtOqvvQk+4oYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pe9z5wHi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=plTvXWVz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HTV32016150;
	Wed, 5 Nov 2025 19:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MULgnlS1iPcjk1cCr/
	fn3tC0xm9DOPEMwPLIHAS/X58=; b=Pe9z5wHih4GKCxwb2ovx6mRaeJ3UoF0Qcj
	FWF8/Ru+M1ZGPK8P/EhgyuDXXrniZ3Ev7L483tB75mq8W7M5PkUrvd/BWRjGa1ln
	pVsvukamtcddk65Qrz/ovrbqFeFZbxHkkMGRE6VhkGz/dvxlzAqQUWxoMQdRgiJO
	qoQ6OXKbNP+vEh17BINW/3d97W4H4bQcSmGGbACUfxISvrGqptHdmcPqj97dcaj/
	OVxUn+7j9MCD9tXVdgLVf3YpX+C03p8ITsIB/hmp1kaMFlWHkybGxNZXmINYcU3+
	14+LnqupPsMGoCqOQfJuC22nSUrGJMha8HfDHiMr2B65/DgMkaFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8b1a8au0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:56:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5I6DaJ039423;
	Wed, 5 Nov 2025 19:56:17 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nb71w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf4iYqYa2tzEfGIfoghzc0GnGAcdW6uXxnVmIgnOU6WhpWlE443dsnLsntS0WzcHYFNlmwZKg5q9OW8TlaeU4c9Z6hCahjpA9r4OEkKwi2RWslQBhYpa4sMOCVIxIrkLa/60FxYHxJmQrLc29MKlwQaEtczIO7J2lX4dVsMCmvslD3sKKTWYI+28pzsXAsOQHvIHbSNrfC2ctr+RcPsJkshezbvaGwH3K6OGCqG7lSljqGTyCXX6IXwR/4mI+RM2k2rP7ZKsAiI0SK3xXtDCsvTmwrBVVmfUqSWU3+ZYIVueYC3xPPjYqCO80lPMMuC5wgcuOJMxWSrOafxvoT5pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MULgnlS1iPcjk1cCr/fn3tC0xm9DOPEMwPLIHAS/X58=;
 b=eeSBNDvBwJ0TDY774G5Z01LED6mXiYnn3cD9FZq9GoxowBv1WM+XVYLNtvqTBPOEl/aHElwJx6M0DzOsOIp3JrVNZYUp/4ZNS6Cmx4szsnJFsGGN/h8QoYjlrx5Th6zEWuUJ008hSBjY8zlAL0Hm0DmeDsHMYfcIjo+UCjcB8sIGjCBkHpwZUloMlTMxdDl/b2JDODhWxuclIR41FpaWV5s5Quwj8EkppdaVKMaGgAR40PE6daRFNcDdOHrSWbFUZnAgtC+iVuwSHJ0VNsWuiwAsqN8a6MDLuvsKgTC9+nULWg0pjn5pxXj97coAi6WOgmdMnL9dq7ydeVaW+KZI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MULgnlS1iPcjk1cCr/fn3tC0xm9DOPEMwPLIHAS/X58=;
 b=plTvXWVzZWLss5FfEQpUbEn2ZLTYALgFXLEXAzJjhKiv0RbUEl95t9Qax8/zs6gkg02CscGVXyKKX1fZLNFBfpfxCLUctQeqkjfsHjPewb7EUlE3fPvd9Y5ivsOiV7O1tFRyXIhzQ+3/2wtO+rj6cVsfkfCbBg8xDlQjRJZOpI8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:56:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 19:56:12 +0000
Date: Wed, 5 Nov 2025 19:56:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
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
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <f8f748ca-3bf0-473d-bd91-ca2bb1141511@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQugI-F_Jig41FR9@casper.infradead.org>
X-ClientProxiedBy: LO4P123CA0238.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: cbff7888-31cb-4569-2b16-08de1ca55f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T38Wo9Qg4mfXhXUgmWOz0PoiNI5A0pV6OW73fNxJgac5ZRKclCbT5skKoIRu?=
 =?us-ascii?Q?4xF5boL6s2KyhybV/RO2T6X5lz9BKubnFiHAcHeOCV/vvAcd7cL2NnIeOjpp?=
 =?us-ascii?Q?tnCpXyNOG6H7M1VrSyUWLMae99/SwRYYBHyiTxKxRSvmoviJvWuyeHHGwirK?=
 =?us-ascii?Q?6PhKfJ/YBClz3AkYBYqXhvDQ3jLO+9QmdRi+9fT/KsDOLYxUCeFUAu6YExqt?=
 =?us-ascii?Q?Gwnw6XZA2vBtKRiQy+BvTDoqBVgQZqQA55rdCjfeH1wgOtNvWTxiqjlT3tLN?=
 =?us-ascii?Q?NJH+6U7NUU9grCFi8l+Z3MLAYhpwgV1aFC9VwdTSE4EBS74H5HZ1q8Ax+n/y?=
 =?us-ascii?Q?QsyknWM3ii9g/tQynBKqZj7VbBfEMXYbNf5RlmZsnHpB6gAlJlnzxrK9UD+x?=
 =?us-ascii?Q?R0lxw5ZCIJsqvpTrGJsm0hbyXL2xVVaFms8r58bS0kYSabt+rHmoI79vSoGi?=
 =?us-ascii?Q?E1oroN3Z4B0vo9vG/Yq/Ot58qQPsG1usyyDSetx7WvMAkjhYBpa4TigvLyeX?=
 =?us-ascii?Q?FVkMKBbpYKDRr6Ao/nx0sLTbyqt5YMQQj0b42gULhNk7fofBcCqLD16Q1NI3?=
 =?us-ascii?Q?p4rgYnWuCr/QpHFWSNPXro/q9QGNdRwbBAbHS+6z01w7NP9Suw+gs4hlcb+M?=
 =?us-ascii?Q?8EJmrmBY1Sdbtx1hsQkcgk7AD2diJVu9G4Nv7B5OcNrjEO+pACzNBFkg6gAJ?=
 =?us-ascii?Q?gJNqgTYE1DYR1u1tuv2+6kC+evzhlzhD6mM0L/tGbkFWHHi6zn2UQqY3bAPT?=
 =?us-ascii?Q?CX/7UHn2igEuUynZPKQHogJ7fWDNLNUr0xwQg73Emqe37L6KXuN0ief948y/?=
 =?us-ascii?Q?0z0BuFVnxUCM2oPWUa4j3VUNkAboVNSr62z1krwFm7amSRl0rN7wJ5SQMLWm?=
 =?us-ascii?Q?LTZqwKFdlJLDAJd5ZbztCWizcYUUcDwctI+fbogI4ufsnA/d9Icw8zYSE366?=
 =?us-ascii?Q?lyoNh0oN3BCVknMZ0ZmeFwD7kebrD4PgSmWpKUIumpGf3mkuPfo5Fq9E6fof?=
 =?us-ascii?Q?CxawxDZdK/2HdYOvyotMlKifk+n3iL+KPRilblgI4GwmqUXew6A3BY1q98B0?=
 =?us-ascii?Q?MqPXxYdrMvp35QcanhL/y9NqeTZPv9zeXoou9t+FLOcBsIFLFGkJfp1At86q?=
 =?us-ascii?Q?MW8nJY0gafKYOJG9QnSZt0g2l3Cz5PT/gXQF+b4QT9twDLCw+03x8kMn/64T?=
 =?us-ascii?Q?CGXMOAfxYhmY6D4A4JgrRrOyQGUZWXFeZEKmNYyWzaJd0CMatyGK1Gtu0AKT?=
 =?us-ascii?Q?aOhlkbx08d20YXFqc7FPkdHfSn7SLhk4VsiXEsdZEZeO/iMQCubBPhqJjZ/R?=
 =?us-ascii?Q?+hCQrp/O+MuD+lSUfS57qCPssQjA+HfXuLtQhKAEUA1yGtFOWp3qTo4Py/uw?=
 =?us-ascii?Q?XWG4U2PpKIgDpA7l/YqrYTmxQx+ONdbROClFhCgvzDMY680T08Fb/mikBGj3?=
 =?us-ascii?Q?8VPIRuLyS7waJnVcmJsKovKf8HT81Db4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSE9YJbcr7C93TjP8JPlefynyGbajN5y80wqLSb8qxc6wzQNjSebabOZFCMc?=
 =?us-ascii?Q?DKWOC8YrqzHUw1o6I8jhh0qyMcjgFwqBWSAytG5XCYN0H49rr8ySQJ3mXxuQ?=
 =?us-ascii?Q?oc/11Ca36qeO0GiZzP3Oqp1t5stzB1bwsRr7Q0dA0uOT97BEuIYLJDx3Jkj/?=
 =?us-ascii?Q?EK8nBjw/IAWU8j9Er9tTGHr4vIveBRvMN0tbzoHMsFzCWbcucFhJz0EzaaWN?=
 =?us-ascii?Q?90A+4xB73o8kNMiPzM9vdPO+PKsXVjDbpp/3tf5A3tOx/8HO/qHwDLndS27w?=
 =?us-ascii?Q?k9IiUFqPRfsCpCzw1sl310XvCC3vYXiTIdp+gGAAG9/GBLfbGECcZ23UwiIl?=
 =?us-ascii?Q?dSANEtMQJLME3BRfSdR7aOoJZ6HxviWMlmkCwcxdxOob9nPjHEkScz17iRU1?=
 =?us-ascii?Q?CudUkybNNcm9fIqu86mYD53geFLxfOlNuCSaRkX81/sEk1wYAJdgaPEhAvhx?=
 =?us-ascii?Q?bvBe5RYXwlbIPTlwtBJCVqZqDXaGh+6upugp8NaF/I6c7fZW2OjNpyAJnvIo?=
 =?us-ascii?Q?Kn6JYDENLsJlbfGY2qC0d0kNSlwddrv32eTVcdgmJ1nbrwL3n6MP9I8/wOT6?=
 =?us-ascii?Q?lXEwkHsK6/ttZ/U9MAZ7Or/USKDGntw3Ligvoh7clbLskSo6F6fFxyp3homl?=
 =?us-ascii?Q?ROMx6ToOE1Ut4au/9LnHo0W+TVnf5kTH7FlUDBgGJpnzx91IJarlAq7Mow30?=
 =?us-ascii?Q?yKKIwGbME4C5KPnbDcESXeW5fcCXpUJCMS+fnSd4jv5DhTKFyeJRJWp1yatq?=
 =?us-ascii?Q?fpE01WCa6OZszTvDXVSwblPOPFT4k7A0DlRK2xFZStQ+yeapeog6uYd0hAdv?=
 =?us-ascii?Q?Gy+YGh60udmuiHWOqdFGDM8PT9PZeGesKsddWtTE1knSkjw4KHNc+rszjI2D?=
 =?us-ascii?Q?tkaAMhMthGFDw72FyYy9/0c1i7bwFhKORPta/wBdd6L5Wc346CO1neBPEOk/?=
 =?us-ascii?Q?TyDaVftC/R8QePMLZV6b9CWPWbMzwkSIYK7Y4DZbQczvrPCkRen3h3v51YIQ?=
 =?us-ascii?Q?LtA0dccyrQIj26oJH6gnCV1LQAPO2flJhcddHZz6kVfnbSk1RpUY4hO6uYRh?=
 =?us-ascii?Q?pJM+tnO47yJNrVoldEm1lIkyRK1KSCr6qVkfBLz1iSLE/RIxp7ksL+moynWM?=
 =?us-ascii?Q?e5UnaKPROAFGbwXGbJ3a1EtiO6Zie1ERa6zqPZYeuqfOW6gz2sSriiAK826y?=
 =?us-ascii?Q?+USzEUzrs6GMGcPTYF0GNm1iPHoBcbLE6zmr6VXPhDE/vlXoeWOA+j3DLyQU?=
 =?us-ascii?Q?vU7C39bJPXuWL4AMZElL/ZJ++3rnfqZ9Brq57koqm3fymCXILuIsmLhiyRvA?=
 =?us-ascii?Q?fSUN3XY57TunCfmz67tqZh0L2lAZ4jEjCfJciXcf3Afav1gJ72b9DZ2MkdmR?=
 =?us-ascii?Q?MSrzdGbnsCu3M34igcedxjag719QK7DfbP24RuSW2TyoCY3OlBz9lvnhd18Q?=
 =?us-ascii?Q?rdylTazArQbl/eN34Qd6nOMVzIearY0l6VEFwZEH79EzjAgTU/AHosm7mP9Z?=
 =?us-ascii?Q?stD5YZQVejhYkY9bR5XPAOghOj7WowgL/J+yli5LajNwU/5dy3an76vAlkFz?=
 =?us-ascii?Q?FJ7oDr8bncgGreHBnIrVfO1r1N1RoJcd3xcqC6tenn7NZQFBfVehp6iwoawW?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MWXa0xBPoXxa9RVbSpkrV6P+6NdTW0VX315yRc53r9ONgNxhlaq5pwVHJvtemWLmPdu52ctJoqq/w58/GRERRmo2nqj/bn83Bgvcm+oUvUVVvrc1/q9PwqY9c5L5FFsznhDe8749LP9dTgCNskn0o2zKmFNuYOAYQhAVgYOpKTBpgHWgJ4VLdCicJWdZGeJQTniXwqw1Ad5B7Q9HCUu5zQZKqUHjRMdjSzi76ZBo/neSDZzjQGGBr6ev5YF/77l6+upQKn+T8Jz86dzf+6YXbWnr6O9voFIXbdEGSV82EAPGutAGEmPvfn8IX9qV5kRou/n/Ak2ZrGCWawZw+6GIvf4O4P47EMhQoWaCNYy22pRZAOuuRl/68m+VUTYjtC8gEOO61yykNsJ5pKcew7d7HJV9HScrGzys2YtCw0buGiw7GeX7mhbFHOK9eZcSkpK/uuYTaJf/yeuPRILBiUdk09atSDeT+4oK2VQoIIecYLMf6/heiOJuFUnNicCigt7mDyrl0YlBO7tbEg2l8jGMht36SI9r9tUKQWtuoNyB+460K77llqUscxedudlBrmOvdfILLQuir2uDI5FhGvslOSbIfh4AupVtOlWV6kzgA9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbff7888-31cb-4569-2b16-08de1ca55f46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:56:12.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo3zmhyi8E0HxOHELs5sxRG6agJ7DlRI6DDPRV4wZG65YvIFgOMRRVXyLvm89rGd8j4Hukfd2MPHvLUzyps/TC7ySke162azQvcntWoWppA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050155
X-Proofpoint-GUID: 0p09Z5DiJL_0aEaI4iqbFKLAoah3YVPL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNiBTYWx0ZWRfXyVPh2VaBWDVR
 KMj7h2MfZTR9jpaWSdM0Tlghy90CRVxH7t8TzSsyeVyV/+8bsUTnAZLiT/F1DZiLV2eLlhu8j+r
 Fz3OWALL22pYFrxEi9JWF/gppZEOZvlT/wS6uEe3cDmkQ+3GehSdRQNhGsbLWRA20Zzav1kdD2P
 +sr269T0w9maeqhNuM+2ruG/vV0cNkpFSk+YGiP6EtH3T7cbIaWS/e0mxGm/sysrsGFgWba83mK
 x6f0NWntvlZn2jxoO1o0hmZABOFQ0hz0m8NqZMsjrmq2UEizDp835KVONLRuKCMxiV33DOVMnBj
 3gF+LcFwXA4zTndvjs6E/TzIUOrPulttjEfA7lLw1crW7XP/N/UeBPOuGkT2EVJ15IFmK8/idUY
 DmEHOKmyriFVA2YJDrIoaxQ25MPp4Q==
X-Authority-Analysis: v=2.4 cv=DoBbOW/+ c=1 sm=1 tr=0 ts=690babe2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8WywiDPCvVzKtv7gWyYA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 0p09Z5DiJL_0aEaI4iqbFKLAoah3YVPL

On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> > The kernel maintains leaf page table entries which contain either:
> >
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
> > - Everything else that will cause a fault which the kernel handles
>
> The problem is that we're already using 'pmd leaf entries' to mean "this
> is a pointer to a PMD entry rather than a table of PTEs".  So I think
> we need a new name.  A boring name would be 'swent' (software entry).
> An acronym would be SWE.  In the XArray I distinguish between pointer
> entries and value entries -- would calling them value entries work here?
> Or we could call them something entirely different.  Say 'twig'.  Or
> 'cask'.
>

Yeah as discussed off-list I do concede 'leaf entry' is overloaded
vs. hardware leaf entries, I just found the idea of sw_leaf_entry_t a bit
gross and unclear.

Of course we now add a new ambiguity with this as really we do mean
software leaf entry.

How about:

soft_leaf_t

softleaf_xxx()

?

Cheers, Lorenzo

