Return-Path: <linux-fsdevel+bounces-53444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A2AEF161
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCFC18973DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFB26C38E;
	Tue,  1 Jul 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJ6Ga4zB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sD+sAw6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DE26B971;
	Tue,  1 Jul 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359126; cv=fail; b=QCvW4FUtvOTA08hx5jRvuz42jxrCUEPvJ8itrgukxC+gnbcvcwyTowaj120KM36ZvVwHGcSOdMpnEC3U+qjK+vHlJ5Wd8w83XxdgWx/joTLPZ7ZOCkSQvXOzNi3f2PaA6Feml9sLNNpHgxx9mADB0QKzEKaxW1IIKtQW+4Meikc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359126; c=relaxed/simple;
	bh=b6EoKGqX+0cCuez3AcJUMlCrMmeDj3ous/RjA4SPcjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=daUNDbEoRtt2Hgbu/qwLXne4//txLsZs77XvEFKUHROMIKH5ELWEeDILGzS9wphM+Z/2kCm0EzzuYBdmOQA7G2GVmEuxOnSZ0WOmNqadPxusjEzs8nsrbYUMKjPi0cfamBSenqvJ9W7YuFiuSMMBeo5URo1Luc6dIEobTLPR2cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJ6Ga4zB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sD+sAw6l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MeID023776;
	Tue, 1 Jul 2025 08:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qZgWi+sR98uE+ZtIQD
	+ee2zIavzo+dBExBIzbSgrjhQ=; b=hJ6Ga4zBVzP5srsHhUTmlfNmr764c9/yzr
	xYzg5o8zsjifNhIasnk6E/e32DylGwo17EjUdWUMqeD3X3hUiEQQ7UNDg5yBvQGp
	BlXSgPtwWv/F/+L28+nVA0J+pTm9YzwecWvA+fY/TqJ3Cy1BVwk4xabnwNbA+JAK
	sAcwwFywPKtChFkK3qhKzp0+VHNcV0vpVTjZOdCg9u0jgti018kz1dWN1lNVKZNF
	sgHI1w0wcGvn7PgZiSGaJpZdSvmXpKO5YnfhDjwRou09xDzpLm1C7KrRgSC/k7RQ
	Jl3AniISiWonruZeBpztI6kx0yTh1CQZt0NFcHTc0gkr9yPVNRuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef48mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:37:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617K1JX025831;
	Tue, 1 Jul 2025 08:37:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9f38p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WesZuEbj9NH0guFIqHTwmMZ3YkC9KmF5B9hvM8L69cVFEz+UBCP6zG19z1ABtYRsyjOAzEiJIhepgaErsZmvuBFAWkVzzZkhVvnS34ySKy4rpudWlv3rxrpc+ijw+PLfUR0TqIrnz+fakWrwoiBPZfsnH9rC4iAFiP5j7GHvj4rzjzifRzI3Jxo+qMFG2melZQN97N+RLT0wvLdLZVmmgPDcJ2m6aXSyNb2rhzsP/3e+mpbYhGSHtxYtPGtHHHYjYrmNcVlG3e3hNFi/9X0m/4Bc2fGoVS3o65dbXAFOw8Ug/onDDyOxIUB/geGgc7KZ7ifKRBjBvbeiAsVE+wb/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZgWi+sR98uE+ZtIQD+ee2zIavzo+dBExBIzbSgrjhQ=;
 b=J/8CSAr0HQKjAotMC8Ihx7qVK+VbMYa/GQkiEiVi+2XXJaf2yzedz60c1EJuZ+RNNGCfTieZ/NuPQ7ekuTjd+8u+PveMRmc4cn1c9RBbdWR6MhhhALSCG7eblT4CMw+5ig4pHE5MgY/h963VmagY87taOVJv46Xkzh425CxK8uqgYl6Zu+/Q+kVdtTPklb8oLOFu68FRe0U4/qWKLlXeZnWVWYHEyVA5yCig5IVyc12Qkguj19bO1tvtC6ZfLIM4EA8/VpsIVtJ948PoKk00pKNhwvbSUia5Dqpyvtm58K8hb8ewLMlHX49wtSf2FjOqi9YxQL4/nkecJb8126a72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZgWi+sR98uE+ZtIQD+ee2zIavzo+dBExBIzbSgrjhQ=;
 b=sD+sAw6lFO95sQ2YLgG4or2ekTDyQz5Nlqr13XTh486qsyZhnge7yI7juk+GDZkxWqiIbWr7Utre57Mk5hD3qXy61Yj0SSXhEXYPCaAcf19LpmJZ+QckUbfF015ZB8JkE3OrMerMU5AxWr3q0ON5gnZKPGjjmIShz6kegxMjI/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4960.namprd10.prod.outlook.com (2603:10b6:5:38c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 1 Jul
 2025 08:37:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 08:37:15 +0000
Date: Tue, 1 Jul 2025 09:37:13 +0100
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
Subject: Re: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set
 page type
Message-ID: <b0069788-2940-4634-ada1-224b927154dd@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-5-david@redhat.com>
 <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
 <d4d8b891-008d-4cbc-950f-2e44c4445904@redhat.com>
 <06e260cf-9b63-4d7c-809c-a9f2cda58939@lucifer.local>
 <84e1eeeb-c78f-4735-a6d2-4bb15ea1fbce@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e1eeeb-c78f-4735-a6d2-4bb15ea1fbce@redhat.com>
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7aae4e-3a1e-45aa-8be4-08ddb87a7b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WGBAEn+UUz+srKLsV+brNZObL/Wbm9wrZ9FMdj1YLJNy6bP9ldTEDaWJBHRL?=
 =?us-ascii?Q?0lw9Kq/6QAH0oIVELrec3fAEBPVf4GjlpYBrzW3M20B0iZbOYt93ZUqJBSuJ?=
 =?us-ascii?Q?waa6x3mjpFjDsxFvdo+HeKwt00v7nyGDKqCvkzpHyMG8PAEm7/cPMBAXgPUd?=
 =?us-ascii?Q?1iH5RIuKxK7IX5kxwtdGA3D4r3hcHiMZa7LYPJPlWCYtrfkhlIZycRugQBaT?=
 =?us-ascii?Q?zlwRfaI8xO34zYQzpjxNtg/zAHGLwmAYvNr/mijbS36cx3uoquwFWRVrE0uI?=
 =?us-ascii?Q?l6HymiU+kHMeKyXiOLWGroGLXSGcmAkypusjpU/0tqQxajwfE9k33JLBgXSr?=
 =?us-ascii?Q?9o5sBuQ5NGZYEI85t14GzvHpcZLgVHJAmhmw0DYQM/xmuSAIOHfM7yArQgwq?=
 =?us-ascii?Q?mF7B0Z8i4SmrT7vXx6mxVqxn1zXY6hnVfAmUXqP3SBTsaR7/UdNsqNw7icAw?=
 =?us-ascii?Q?mkFqrwEjGTc+aLAPZ7O8lvJSw9kEFdPT+/vc8Kr3asdIHtR11VgD4m1qld17?=
 =?us-ascii?Q?FtHkEbAmOZSDZU9YgxINSSkjEi6lBdd9zlxUeIIvTS+KzXawjO7ZzYp9dJcK?=
 =?us-ascii?Q?3O3x2J/avGQ9EeGIMt6Q0bauHAFVyzyNdVM8Ne3X0583sRkcQhZxhieef+VJ?=
 =?us-ascii?Q?qDPgkg4d8oLG24LqS8LYfQul/HtoALAwgWDNQ5SKVu9wFw7cbnERsgJYj4nQ?=
 =?us-ascii?Q?HgYuyfa/abQ+bopeNnjRNps6FwWJdX7hzq3YopGTj/FVKThRT5QFnoAdl+x8?=
 =?us-ascii?Q?JqFgqdCar/PGprZk4WYuboRvoQuHW2SIUAJNFLWheVQnaZnLtzIBG6C5taF6?=
 =?us-ascii?Q?6BL/DDGgu/PKPR6xJ5DsgkhGQYLERuIztRGySQ0zQ8eK6PRMk9HM1uFEOndi?=
 =?us-ascii?Q?ABhBLoHF8FkV28OUL7krGMpH+KnFpXoENynMkAgxickr5m5cN/+btlqax1sq?=
 =?us-ascii?Q?kHfjlbHB0L9kmeLuvzISaY29Gc/t5Wi7cJL1+hbq5N3nqRPLsbUg+S/XL1Y3?=
 =?us-ascii?Q?eAFb9jd8vhApWgchDYFhOyGdKttCfnuJP4RUp8Rh0FZlUxKkZ1uFgNlLenGF?=
 =?us-ascii?Q?X+InntaeMT0uYzfsE4excVAIDpz7Cw7dFddVg83v/fjwuFSv2XjR6+3hloZh?=
 =?us-ascii?Q?m9j/KkSf1GxRIZybPV1K47P90DigHu1JBBJrGbwXzTduiFdzEz18cth1UHBn?=
 =?us-ascii?Q?d5FOCMPQ0TJ0JTPDjn1ez1pMYj3Wpu99WLuRvN9F9W6OHaEv1iJ64kjOZ5vq?=
 =?us-ascii?Q?sp/Wygq0jJmm2nq9lcBFVJH1PeHvZg+Cv+1NWezzLvGJbMngMPQkx6mMZIBA?=
 =?us-ascii?Q?yuSh3QonWWmoWl5GC9Du8IlYjKqTwOpnKIz4YcWFiHn7YdJTCVbK8z4S7HMj?=
 =?us-ascii?Q?PVwC5rOt53ifWfHuX1YWZeCi7jytuCVwIe9KPi/DmuaCVJ5mrUnwxHi8iOyL?=
 =?us-ascii?Q?oD6MiD1rYcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FIvv6HpOdFg0yg7I0mTojWtCopImsXzE+XUR0MSEs6w3Vn/qYwyfsUeVGiF?=
 =?us-ascii?Q?sxkzeIPVCdkk+46jG88JuPhV0K9qcCdRRcr2LwmhnshhaP7eG6eMQHup3H6v?=
 =?us-ascii?Q?Q2fmskm1yNRfeNS65F82CJh5XLZmOtiy/TRhAaSoxKVcrzegYzDJ6iqHXM4e?=
 =?us-ascii?Q?4Sa2ypoyNik6Ihcy/+4gic0dqrD2rSOoYHT/wSA/M9NmIgZ7bi4oHPpsHiaX?=
 =?us-ascii?Q?ClUDVVG5ju5Cj5K9Yzpdy9EOzW9ewKLwSD8Vul8ppwM4BbL8wYP6D46NB9IE?=
 =?us-ascii?Q?G+be1o6Fc36G7eqcOfXv/YpvEtBAx0i2jN1oOw8qRhEwZ19sjaIAwW2hdPHk?=
 =?us-ascii?Q?uv1ygm66ZstCR+J9PJGM16XdbpER94YmUWpB6OhVFAWzPu+kuA1O4/WhbpbV?=
 =?us-ascii?Q?CCilHjumCNIjIBR/GRiphp++pB3KFtSUZ3ewq6g2Q0t+0eMbWxVw00YSKIGj?=
 =?us-ascii?Q?qK+F8H77eSrNSt+6/DFCXGMu3oPtOzJR4vrjyY0DvDXzTrWhSc/82h9KF5GT?=
 =?us-ascii?Q?whxfFf/TaY/mpwyu4lj7vrhl3kB9OnvbchBOyeWuK25x/kVKWKdF0kY3AT0d?=
 =?us-ascii?Q?oAcTy0zbhZxL3CjDQ+gx2ygkmddm3w27OF5Iwk5w875lyfaHYYRT3hGZiekN?=
 =?us-ascii?Q?nYliAA/RsNLAbV2Chbi9rzstGF5qU3VmEQLyHqzHBe/KgCdqpGtBgDGKoNDO?=
 =?us-ascii?Q?BEvLY0RhX0Q374OY5gVQ0MyRWPZpphBPR2qwfLYenf2pnA6C6mIZEkO2Ej7j?=
 =?us-ascii?Q?sMO3VxBsCbSjC/Wwi5XFPmexcV08ybNDOiBPcQin0F8/2pE5oLR3SCGIX8S2?=
 =?us-ascii?Q?TagMI++AqF6n5WzuBdRRnhFxm9PmwcdWB1U6NodNbrLQ1BodrDLR8LefDxC3?=
 =?us-ascii?Q?86BWVhBYQ6l/vgIoo1upvgf1b7OfC56W8vM12ewRYcjWdy5JDTBO+R7PZsSs?=
 =?us-ascii?Q?uTtlFnuk22E5cApZp1xhyZYOsbNXbeoAbJbQIT4nTm8CgRiTQaeEi1TkNWWA?=
 =?us-ascii?Q?4TawKsF2iuwQ2LrOKunuDsPejyD43xFdC8e8IIwFvR7W6KjbWeWlFTg0HR4M?=
 =?us-ascii?Q?3+hluy7zkrj/lle+begr2Y1C2lt0I+5YPel31gwgTeT++hQAlbk3jMDUzaGj?=
 =?us-ascii?Q?zEMMAycVMRkqEmdiF/V/5C0hyduJz6XtAdZjtPYKzfK5bKLxmbE2eKCcqBT8?=
 =?us-ascii?Q?6wAtBVDFQgWoFr/duL8MCvltqKqBJ5tFnLJM5LzxeKvCIbZFaspgnbF6fKBo?=
 =?us-ascii?Q?GvKZNQ/Awa4mLI4Exa60n4cJRakLegl9To7cTOJ/hYGurmboCZjKlXn6m/fg?=
 =?us-ascii?Q?dz+421l11J0Ho/PqAOvI9qAMQpaxU8wKx1zjOFx2NQOnQL6O8FZYaoU7qAZ4?=
 =?us-ascii?Q?IOf16Vn6z5pCVcqhVLFwbfQUlW6ml4rTi5Tpmdr2SJMWcLTItJBRJGYDWLjR?=
 =?us-ascii?Q?yzfvk0gefozFH/jegLjYcOXz2lpZ3rKqOyypID2BHfjNeJQkVG3H2pwhUlss?=
 =?us-ascii?Q?KodH1xf9pHUF6ozUUYTNYx/f7CQfr51qbonI2AGAgfItpOTeWCjegsvjTypI?=
 =?us-ascii?Q?OYgfKQGdqlmJfSjq7OGe4CaYDoRF32ZThWODD1nH9Q0ts0Is+Qm9ethneKI9?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j9U2rdLTEkStfNHJrMkM7H/jqPspIN1tPZksW8TqUABchjkZNC97FyqM0CH076hpUrLnNrMVq2hgp/zlGSEQfArF6hlZoHNq65jZEd7uCJtc8ftHLq+G6O1eQhgNilugteWfEYszoeyVOdtjruK3CZJPN7jpxyz/0Cq7qRQ0j0DGZwNL0RMGh4G/LNpy92g9ouD87g8RE/BTUsy3Rp2fifyqRHma6TV4z7+SJ/0RZrz0wJQJHce9r+1NM8F0V6tN5TkXNC47RWuh0DenBbKYCcEOzZ++i/aPN8Es7lNLEOSKRbd4ifrzlu1N2nsMfiHh1SdQFDBvbSyim58Y8xuiKbNZz5TBQRgSTFFLHWQwFNcRjsUnoAb4IGLzDsWbgEU9nz5QCkOCHfcb3HRscxJEX6+glgyzyWJwbDi14JChU/iM9kIMXfy+AuJJ+oRFv+ijsvk0ajhz4WQt2D6Lyl3YVOOPLniETrZIc7k9lJAwDetkQ2vNBOGk3j3uIcWIZJy0c7S66DsOBL+rxl4kJk2d+CMuxHRaEToDMh5eadk1hyqTc5KppgpKORwKR2u1fepRgM/bvmXyXG1SnjqaEjNfowuMqoINeOS/E5UFGREmeqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7aae4e-3a1e-45aa-8be4-08ddb87a7b76
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:37:15.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH0jHg6INuoKMfyzVn1kijj2gKKy145dA7oBNcexzEPhMvAWHaOYsjPrmMNFjPNO1bY+65HehOzzpUmMGkqA99eUNcxA59ypUoAgQA4Y7AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010049
X-Proofpoint-GUID: Z5JtoLIeOYZrMeiPTcoHh1SgNt9YG2-h
X-Proofpoint-ORIG-GUID: Z5JtoLIeOYZrMeiPTcoHh1SgNt9YG2-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0OSBTYWx0ZWRfX2f9mm5i01k6R divcnH1M+/BFkLXj+Z3OY8W2Pz4TY0VomGURXAn4CJKEs3tOAth/3RIwDj5d+Mf0fSScWz5z9be ImuL6QcYY4ud5aoO946oB7prKANVk8F9VXCjRZnRKYpw6543C7gNAzP29TGmFbinZ7dMICMjwJE
 ZZwuKCyL7m7uMoFKTIrHRms/kVhgsvzRXVCukHCZ6iw/BdSZJV3c2tB8IgB65ERs1FAhDAY4O/g bTWsv7UE4tAJxLPv4rzXCbB+QVtj5KnVYZyhOdJQJLCcAgefaLwUZipUgLuuM+hCG8WswFjUybj Qpw7tNcdNOwakLnKaGbGJdyXf3gQA3iJJX0k2Gkpi5OTlWisne/k7/6tDR3EzTUOisOFqhA1tyW
 uae6nRk/6IZT5bdE3QvFqcxUYgLsYQE5BWSNcE2gfeGFY1k2bTqDruCQ6dJE9CP4KOFdwm/4
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68639e41 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=L9TIf8G5Rp6rEUXyDIQA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 01, 2025 at 10:34:33AM +0200, David Hildenbrand wrote:
> > > > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > > > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > Signed-off-by: David Hildenbrand <david@redhat.com>

Based on discussion below, I'm good with this now with the comment change, so
feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> > > > > ---
> > > > >    mm/page_alloc.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index 858bc17653af9..44e56d31cfeb1 100644
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
> > > > >    			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > > > >    		page->mapping = NULL;
> > > > >    	}
> > > > > +	if (unlikely(page_has_type(page)))
> > > > > +		page->page_type = UINT_MAX;
> > > >
> > > > Feels like this could do with a comment!
> > >
> > > /* Reset the page_type -> _mapcount to -1 */
> >
> > Hm this feels like saying 'the reason we set it to -1 is to set it to -1' :P
>
> Bingo! Guess why I didn't add a comment in the first place :P
>
> >
> > I'd be fine with something simple like
> >
> > /* Set page_type to reset value */
>
> "Reset the page_type (which overlays _mapcount)"
>
> ?

Sounds good thanks, have an R-b above on the basis of this change.

>
> > > But... Can't we just put a #define somewhere here to make life easy?
> Like:
>
> Given that Willy will change all that soon, I'm not in favor of doing that
> in this series.

Ah is he? I mean of course he is :))) this does seem like a prime target for the
ongoing memdesc/foliofication efforts.

