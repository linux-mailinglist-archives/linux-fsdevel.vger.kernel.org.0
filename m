Return-Path: <linux-fsdevel+bounces-67884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C98C4CC46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7673434F3B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE82F49FC;
	Tue, 11 Nov 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H+lnrnnd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgsbGJLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35228D82A;
	Tue, 11 Nov 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854559; cv=fail; b=Vop/cbI5sPu2YQdHylmexr9yp0JvhBtQQX34JchFDfvEJKXj7cwlbXpwgHnZTnKpcVLUO7hJii0AXjRKMz68jZE9hSFCNprFEWPQ5+SX8u7lkPvGSihOGhJUcGfgm+FMJG7PPOX1FaIC46sLM6IGujypEvbDLtnAGCHPLWSg3jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854559; c=relaxed/simple;
	bh=bhh6USNudRBVQXkDz/636bJsWMVT5oZ0L6PwJxiQh0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtkShH2Lm5WRBS1pToMYboxM0hXwzzmZzp5Fe+dV1sSrtH6x99qo0gwIiFe2tm1jGiKBwreYECF/+GyRUew2f4/3WiGdDkM8DknF3LSqdVMtkFDwan6pI2ob6fZPkq4ES4QUYFqXifDeeigAri+hf/NAsLBnHBnmufzOfqsz5Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H+lnrnnd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgsbGJLR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9MwHH025706;
	Tue, 11 Nov 2025 09:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/E8HVKdbNH+gNPNZZ9
	3y/vsNm74oem6xN27Is0MPwv4=; b=H+lnrnndHbaIm15l6cEauaPb35GMdWiwZS
	bjRDxz6xptXthnDL9s3Xo3pyBudlPuwW0kK4KaJTVwYQgCw/gZN+3Tu4yEjZbngC
	chRoUhOk/+xT7+19mBeAa9lv3TMnazOQy65QK9fd7bg7MV+ApDaPUdluSo+XcGP2
	WxfwC4S2+relUuod9Fv7WTDRQpoLem0X99kIdTWH6UhSq69KchlAxwHRsd1oQnA4
	gwHWF6DFRWO99UyMhH8Kv77T0tQOoE0S0U3tizAfjam3SqUV3hqEoH+oqn8vTo0l
	g5feYtTEKwoW3NWR9CfT1po5uqQxb0irY5WAD0D8UBsdGMN7GVmQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac1wkg44r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9YXsq039952;
	Tue, 11 Nov 2025 09:48:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9a31d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrryvjaYkdzJbEVFo/mzWMXSV9negxxfMGIo7k4y6LGWIr5+mxkePp+/iAnxi1W0ejiUJtgcFx5T3MglwfNYzWQxGHpzFxVY+/qWGSuF9kL0wl81I4EbFB0EMXZBvF/ItdYSZqtOVqa4zrK1IQVjUWd7BxkIviSnqDAIq20xr1zO4zShQXu0HX2l4RwXma18Ghpvw1bhOnfLHjtdIGWrgz+pmKA/Jy+Vfskvapbrr9hNUSyi+TtTKXR4EAleqVrKWuY/uQjzVHtUcOrJY5IGwZX/EtWczwovzOqmpEtAHtKg4K9RjVb7vD5MZEIg6hWOnmvecPlcYfU7LN/J6gRr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E8HVKdbNH+gNPNZZ93y/vsNm74oem6xN27Is0MPwv4=;
 b=YVjO4BuS1d2o/Y9CEiFDWxCRqms1TY9zN29JHF3X3J+MvLNmLKj6BFhHaDy8EtRDZ4F0Zt/EkVXsIk5FazdROeOBAlAhmIJt8yR0k07wGd7Mbs3c/GmbfFMICvWh3RK6sFWoNAu5y2t//XIYAFQdlCgFc1qc/uckPwfh5W0K0ehxIeIckWZRLQpc3lt740ffwleG9K6DldRqtOU4eYpTMgxN6lC9tswJNKpEQxt5v3AqmglraTP8ZLmYnFmWJUcKNrG73DjUQCdqKdWw3c1WTjMwxNTsMYwKSJkqmyOEPpgp3NWQIPdyfCddLEPJksAUzSrcD6CdZwHlkL8cphrLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E8HVKdbNH+gNPNZZ93y/vsNm74oem6xN27Is0MPwv4=;
 b=AgsbGJLRfFQpL585C/jU9trPpvR3mKXVyjllqNAxMOytqU/scJ1vIt0JmZj4lRDxbMbmcRe02IiyOlvRsE1wSBUAIya4UapbgALXcIIc05512uL8CiyNrNFydrNMesBFk6IqlaD9qJtY9RGltrbkhm/Ts3ZW4znuUptql+pjGOQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 09:48:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 09:48:19 +0000
Date: Tue, 11 Nov 2025 09:48:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH v3 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <362cbd1d-dd01-4080-b6d9-5df580581a6c@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c38625fd9a1c1f1cf64ae8a248858e45b3dcdf11.1762812360.git.lorenzo.stoakes@oracle.com>
 <aRMEX5YP7ubGOmqo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMEX5YP7ubGOmqo@kernel.org>
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: d336fe8b-b4c4-4058-86d2-08de210771f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AObJ+oA8ekh73K7drA8Z7TA79uTkIkHpwQYc8vaBPHLB3d7W2rmC50/c6R5r?=
 =?us-ascii?Q?JTUqRvF4FwmCwajoYdBN2BGNioPmpWEFVYtR2YBF35g3cSRDgWyDMwb8anLt?=
 =?us-ascii?Q?Ttga4ptWxmMl25hANCCQdgCTSC0alsk4MvIbpWsvLxEpBLix4AafO4j853gL?=
 =?us-ascii?Q?Fim2/kk/fE9tqn5wiF0rPy4SeJRvBEIvibALLHIcIfh4Zv8QsvMle8s3eg1y?=
 =?us-ascii?Q?H21cwKe0dQ+ylzr3XLErfrtGuFRbMAkVNyVul5sGNvPhtKtzDC6YTTNy0lEv?=
 =?us-ascii?Q?RokSnICAPAUIx+5VqHUXNgYBuIVyIGw6ml7EoLtU0bJKIPlT7WWI+HS4A0DJ?=
 =?us-ascii?Q?vqVH0oCZaD7QJym8v1S9bwv1ufkI1j+e3e+0nMsQBCY9BAsZChlayPk+6IQl?=
 =?us-ascii?Q?dS1U88YKwXWdZGLCYEKp+7B8EENL8vwHOEv3w/BBV/oCMSwCu8znfMykvh5e?=
 =?us-ascii?Q?xC/iMVnWYTW82hf72dgibCwodakjUkfz/0bT5PiI+LbDTB7pPAcXKfNsmHLP?=
 =?us-ascii?Q?ALNdC+6GmbuL6eFBV975VoZimVZyNysT/8mZ2k8bhxMpDVvKNB4dcxkGL9wg?=
 =?us-ascii?Q?I8ByiKTw1wGQ7Kn9cpEjkbT9yAcPCgGSlFglfHscEKrOlqxJ18L3mP9dpJMJ?=
 =?us-ascii?Q?dja2gP4WaIMuvT/voFH8skjLR4fmEPzUx/bjoY/9tZl8etRiSZrh471EmP2J?=
 =?us-ascii?Q?MrMkLO7lu4xUvcXBHL2uGgNJgzVr/pf62ZBV5xsh7QvOKjxSqujMdAqaRYvh?=
 =?us-ascii?Q?FwdtlKVgj39Kecc7WqQJGd/GE9ZkqcvmJTI6lfRkKc8vbkosL9T3P8p4iSRS?=
 =?us-ascii?Q?oO85uG/I+ECVSjgRrlmZ9V8cTQN/r5aqKwxeFS+ej2yWF28hwj++5Rv/GVyY?=
 =?us-ascii?Q?zlddTbnC899rhaVD2Q2Xe0TwJ0Pya72kp6vSGDcJ3vGAfIzcEfpSYFlQJT6B?=
 =?us-ascii?Q?kbjwqGHPDb+aJaal2NCeTyPr86I+98RnHoXL6WZmAgdtCuZS9ihpK1A0Fw30?=
 =?us-ascii?Q?Qtucb6+suO1jtTTlzFfR35YTyKTM2HosaqtH3QY86i8LC7AJQZ9nrsEG7+RL?=
 =?us-ascii?Q?veqcar+yCsXALyKIz6vx9j8lqP/SM5q7HTYLUHSVtD842f1zucJAEXCUWThr?=
 =?us-ascii?Q?PSohxP6ZhcN1OA7eLBMYAcghdNvUyPePf7mV9rrrNiuWeeY4PH4rnB8YMlPW?=
 =?us-ascii?Q?jKjFnE3spYugwZ7iYmu4dfcmFFyw0Fu9yJeWzkWM/RDQAaUn7jag9/grQrab?=
 =?us-ascii?Q?tIQQwEC63lTvTwlrbD4ad8Zsmw9iJRPu8tLKqUgONQ8QQUPZsRXJ8usrg2dJ?=
 =?us-ascii?Q?HzVYLBGPvoof4oNBtkLxNfgDL2Pie9yu8AVqyvu4+RgXjYnQqcltEnpA2Qol?=
 =?us-ascii?Q?+HU2MYV6KU1z2yX7khcjmHF++yLVVI/BtJcF26Mz1ZRtRaddOXdHkz16+t73?=
 =?us-ascii?Q?Npd1Q/i3tElYTdwO0KODTm3vCj3Ec6Zq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qUJubWSRSA2qcLcMxQ7GL5r6eLP9Er+05+zm2TBx0r4hz+BhevN7+HRfxxVZ?=
 =?us-ascii?Q?DsNpMveuPJN8X28S5JoeG0dQmCnIqKIkiich2cVzPSzBXONMy/PIVn4OLUVg?=
 =?us-ascii?Q?EeUUCdz9YxQAN5zMo966LUYCf8gR+kVO2VlXChL3w3d9QqjTEsQ/bRdP8i3F?=
 =?us-ascii?Q?H2sMT5P0FrL8VJ3OV6lAsfyz9MvPnrDx8iY7WbrLPNYhEUKasG3+Fk1TFQ3u?=
 =?us-ascii?Q?0mL9nJVDYBYwGNwsLCxVd3+1fpU0no26ZfW87DmyqXLYDzbxGcOrlhQuAP65?=
 =?us-ascii?Q?aVKhZPCo+uxONMAuAl6rsarcHoEwWnf3jaz2ZFA8RxzglIiCVOxAxmt7XFGh?=
 =?us-ascii?Q?2q33RU0G8K3XrOx96rCLSNDypDOTwXv6vJZlXRCtpjluGKZK0+f0DphSEhv0?=
 =?us-ascii?Q?qFlPlfvChkQ+lkA+cOUdGjlZB2k74r5xYjFgbcsVH0kRN2DxUntJqGcp01kA?=
 =?us-ascii?Q?NeO6DXbKxi/mFjulCTddxbGE/b8Ee0xBVOsElRV0Scm30fmtdBkrZRfIf4bv?=
 =?us-ascii?Q?F3u9JeWF0hmTtmTpLPMyyYGibELyal0LQ6qvJE6MM+dPGrAPB9FAljZqGOuF?=
 =?us-ascii?Q?2dq2OPBQ9zXPdZssAgO/OdvIBgQIwz11qvi2HGIHMDlFdNmsDEt9D7U2fp8+?=
 =?us-ascii?Q?f251o03nCyBhYoY8pOdw696PSybK11zyiFwJGKpgLQett+ruIto+Q12B4Wlz?=
 =?us-ascii?Q?H3iX6GVBLC/95eMAiIbYfqWj7JBYIWIYhTc877q8Fe4MEslH0odYqcThH3tf?=
 =?us-ascii?Q?quaqWdAMLQqDa0liHcFS6fJ9nysSQuK2yr8m5ddsAKAOwvFNLurkv0SOKqmV?=
 =?us-ascii?Q?VuSjcfoxqOBC0DwXGU53B3bPK+D+3e3A9rjjMJAxeQrsaTNcVMWBsnP6RsNZ?=
 =?us-ascii?Q?UDGwOfdgCC1eknHTmiN5GKKP1Sqn78OqMxGVApEOHG6sACe+zbZF9HEo8VFg?=
 =?us-ascii?Q?xilAYsowoLeKQ+nvlchAeE56hX0WzRaguCCALcbRxFDsKWf0roKLNhrNQ+kD?=
 =?us-ascii?Q?ljWSbtSDA+Hqq7PDRdQwyrUuudTLzCSS8EUEIaSUK5tpfV6zXjeiqEftXUYO?=
 =?us-ascii?Q?XCUCjUQCz96IjiXu/MZHlHocvAbqBd3/f4Bx/6eQZDA9ulWzz7cbpkICPPsz?=
 =?us-ascii?Q?WDHPoBVfki2wn9jbmjbqIfSqZs9lFOYAckd50TOasn8AiRsQQwcGWXmuGwjS?=
 =?us-ascii?Q?PfkftKKUGHirc5tj7d1K7UpBdDcixXNpr85R/Zf6PCmZUnohjdZgBtxUjvN1?=
 =?us-ascii?Q?2FYGCPyq2kpBppTX8LKP1qaWZGglnsXM8xjuixYyYVcUBYB1pFLyEkp4RcV0?=
 =?us-ascii?Q?PpdZqIPEXSm8MUnTKdg6mO/GmJO7gQwPotbTDl0QQOiPTzXXfx0dJ2wf4ult?=
 =?us-ascii?Q?wJJrOky7velnR5aNPSaUvdLKV1/3G7Mcqgo+yCszvi2RzDrq7Tu2kHq/ugpw?=
 =?us-ascii?Q?fDHpnfAviGNoWB//WCS+SjPUOaMN3n/TdoGIm9MDYC9U2PU7K+gMCOO1IZ5r?=
 =?us-ascii?Q?ncJIvYj1KFU9VN3GPKE7a8BkKepPeJS0FYAhv3axL64BSNZPyJ6LjWr5OIwN?=
 =?us-ascii?Q?/ghgixlgR6t90wwCg1boxsYOUQSk5ob2a9UlBwtAJ7wPPEUlceJQNzEjwvLl?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ZYs4Ke7ee0CpsjMqm3BIlo1Nd+8niFzF005a3EApPBhQc0hioRZP9kr0DpMACBu8AAzsB6QAFwkG2Hofx5cgcapsP/kZtQAzcwDvTQXkKuAC5hW/ueoi22LTJ/b7U4l7zQnjqb7B8pKlniU9FlpAcJREa28ZLcwdqFFmh5qHVksTT8pP26Xux9iQXIf494XTvv7FbxkHOhxT9otu/CwlAjRGRop27z1+pBdkR+JftzWmVwCMJAQYnZRe9Q6yS47SXJ2xoB5AIFzG7OkzVssYpdhdeKDP5egjzDJpoyKSFLL5dTog9pSA5PnPLRYMf8mvTnywVv8AjP8iPxow594fAVWJTpfgJE/+YK/PLFtorUE19rAtdnuJevLqJRySlm8dCNjGI87HJQb6kBPJHJW2pz5wXYtMVUVQBES+nURbAL+JhucjKA/OdXYu2o04jMmKFmI4T2Y2d/0r2XYH1QlbPG6pB2cEefp1tfEh7ETtr8bgUu4fxjZxazVN/D1ePU/vtLoJQ5pIbu//yFUJ4iTbH/EgegLqAhn+ITsqcMXL3gogTeJwNPyydszKQ5WRT2vDARPrVy6rORGs2pD6kChp64of3GhfoeM1ME9jbm32Mc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d336fe8b-b4c4-4058-86d2-08de210771f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:48:19.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNCfHs75rQdsfs5Ao9S5I3Fmvf/05ZysrOrZ+NqFIngptrtrV7+z+VuukZfZPipkTi/S6/vags27umpFaKvx25gMo33DdcDnJgxQX/gdzIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110077
X-Proofpoint-GUID: _meX3-RUJC2MwJD3M0w32qDoy-Rj5vme
X-Authority-Analysis: v=2.4 cv=LcwxKzfi c=1 sm=1 tr=0 ts=69130668 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=TLn_SbsqcReqLRZgLlUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _meX3-RUJC2MwJD3M0w32qDoy-Rj5vme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2NyBTYWx0ZWRfXwSB0wz9PsayY
 x+vEL5JJbpUb/BUCc6DeiX7jF+2ccFe4kh0bahjZQUHdquH0OLiIX65CCLrtEbEo7xlfYJRQaEU
 cko3QP1pw1UeU2pdVYSs5IKt1lStyNmr0vaTvvNQG6GOnUC6o7FXUxOcuQwqqleNGpPPERT7DdZ
 4rAcCxienFALzxhDZRPu7/QA4opOdmPRaVcZkQD8HIEUYXQpriQVkUgxx/SZaQjZhCscBT0x7y0
 OiZSUfOXMZsDSfnz/ZI4/93oQQOePwzREsL76B9yG5pjzZtEVrptn/lmuDIUqYx9SgAoIdgYqzX
 c8mEbE+N1wmo7WiItLMjNlfq/lD8pTCYMBrcrsFTHZdI1v6fg0sfPhWXbfkxXn3tO/+AbkeE/kZ
 AxJkjq1z/YRM8lZ113S9neJFehamDw==

On Tue, Nov 11, 2025 at 11:39:43AM +0200, Mike Rapoport wrote:
> On Mon, Nov 10, 2025 at 10:21:19PM +0000, Lorenzo Stoakes wrote:
> > PTE markers were previously only concerned with UFFD-specific logic - that
> > is, PTE entries with the UFFD WP marker set or those marked via
> > UFFDIO_POISON.
> >
> > However since the introduction of guard markers in commit
> >  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
> >  been the case.
> >
> > Issues have been avoided as guard regions are not permitted in conjunction
> > with UFFD, but it still leaves very confusing logic in place, most notably
> > the misleading and poorly named pte_none_mostly() and
> > huge_pte_none_mostly().
> >
> > This predicate returns true for PTE entries that ought to be treated as
> > none, but only in certain circumstances, and on the assumption we are
> > dealing with H/W poison markers or UFFD WP markers.
> >
> > This patch removes these functions and makes each invocation of these
> > functions instead explicitly check what it needs to check.
> >
> > As part of this effort it introduces is_uffd_pte_marker() to explicitly
> > determine if a marker in fact is used as part of UFFD or not.
> >
> > In the HMM logic we note that the only time we would need to check for a
> > fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> > fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> > for a guard marker), so only check for the UFFD WP case.
> >
> > While we're here we also refactor code to make it easier to understand.
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

>
> with a small nit below
>
> > ---
> >
> > -	ret = false;
> > +	/*
> > +	 * A race could arise which would result in a softleaf entry such a
>
>                                                                     ^ such as

Oops, can fix up on next respin :)

>
> > +	 * migration entry unexpectedly being present in the PMD, so explicitly
> > +	 * check for this and bail out if so.
> > +	 */
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo

