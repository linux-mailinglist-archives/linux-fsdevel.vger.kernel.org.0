Return-Path: <linux-fsdevel+bounces-69647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1FC7FCFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A85A4342FF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190932F998A;
	Mon, 24 Nov 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jUgSejCm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J611SLNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F72F83A7;
	Mon, 24 Nov 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978953; cv=fail; b=e19IIL35oyEIL20rgQNVpqxaaJlsIwJaDn6fpYYfJlgiDEmMOyXo2qA1T5iSEL0MKt9IxqYmLjafhaDK9Q8LrXfkt33clVglVN3KagxH9D05oIt1PcRK20iupeX/k3l4w7DgKL+Pgd3LARCIKgV3IrhNRwdoEd4/Iwa2qrV7prE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978953; c=relaxed/simple;
	bh=mY8qcEsXvxd6EjX0g+sBvjqwL+lJoLSfB1s/4lTwt24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOaXjddQo4TyHpfbDPmZOC1s5t2+2HbVxq7STNcLJkPWreW/n/sIHGC/bJkp51mhqE1MOJi1b0wWK2indNaNZz65g/7LuKEh/8EbR/hkIYkx0fGtpGuWoesxSxnE+50q6K5I5KJHi43bsHjIvd2i5D0vBiLwUQC9AuJ2bBb13j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jUgSejCm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J611SLNm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8v3rY724785;
	Mon, 24 Nov 2025 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mY8qcEsXvxd6EjX0g+
	sBvjqwL+lJoLSfB1s/4lTwt24=; b=jUgSejCmFqHN7u9cJShYt3rVi6ixpeBsxY
	Jsy8tlOzjnZyTY+aNUXkAmlQwrQeAEMLdyYGS2wrbUBKr93nfzYpA6iHg0yG9+0v
	WClf0RzNXWoKRsc/0DIku3GIPEsxk3YsjlTVkevIbq8gKWLx+f6xw2KQ+Kh+VpTC
	q3eF3ueRL/QHcWuy+PUT7aA2IUJrTXuXmPvAzKP2HIH/icu80nxfSFVxkqTCInhX
	fjgU5Y3Mi7G4vnC2aYpIcin08Bc2R30svFEc3ojABqkI7+idW9ODsadDTIG+Cach
	9ajYkalX0nO+r9jvQ3+ohAqSKOmZyTI4DrV3aPNC/HmAnn6pUkAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd1qx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:06:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO9FtRi033083;
	Mon, 24 Nov 2025 10:06:46 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m7ws4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:06:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuokoouSR1tGnvAMc3PfvFVGcnM+HHkdaV0hK2Pt3yQvez93n9sSVZQKx4dlZVCMagTMg8vfUvv7hUqcLbE+il3cmaqLSDti3A4XJn81/6A0Laoifo2l4sxd8bxHhD6+qSnF2EamQQjtN0D+y4WawCcNnvxo5YUj4RXASrg1uZt8KMCEPmWIg4lumG+Wihn1Mms5tRS+pAToyP4nBPvTAgMb/qv+sSaWdIHrn7bQm09PU84BEP155on2E95Q35ArWexAlegy3jm/9tnyZHjrNxQY8wXkAGSLJR5tpHn0kQYdgvl+NETAJKWOcLgL40rmRcwlLR1hc3S3NuXDuADQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY8qcEsXvxd6EjX0g+sBvjqwL+lJoLSfB1s/4lTwt24=;
 b=xfG2gtm61T2NHKMxEtJvKmtMqFPySpTE+cKW8PRfAswxVpKLmsZg5VxcIHdhcO+WAjpSZvYy5dxiaM04hoWlzLXlSNiqRx6srcVuCjEhu9pQtNlpUQhKWrE7mbG7CqCvJzBmihW8jYXdh12uQOFS7zj/LwkFwo/fZrt0/3bQelxs8KfWa95iPtat1mQnlNKFlPIwzXeNgECNDkunJb+xrthdi3C25swjyA2PGLaNYhHzwSCyYTTy5BwACKVZRvgYs5o0uYYkqMJkM6p3XDjKjQELAUjTFwgX9mcrlHQa0OrjPl73bTHGlJrJ3uvgo/pDu626+bUbMBK3m6einqosqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY8qcEsXvxd6EjX0g+sBvjqwL+lJoLSfB1s/4lTwt24=;
 b=J611SLNmBu+PDCvXN1vpKmARdEbDs3fFjolQE3KYTPIFVY60BQtL/HIdJI1trAIGzleoC8QOHDFALsxLywfJEDNTzHe6NTkVjpYu+hcSmOFwlLzKO4d4slCd2rPOyHLrmm+rW1bO3Hbeoi5Dp45YHUGh9gtR86pdks5DkhXsitk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4119.namprd10.prod.outlook.com (2603:10b6:610:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 10:06:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 10:06:42 +0000
Date: Mon, 24 Nov 2025 10:06:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <0d3191b0-9849-4d6f-936f-d950381e9e34@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <20251121234456.GA383361@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121234456.GA383361@ziepe.ca>
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbb1e7f-e818-4273-db2e-08de2b412acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odsOyqMdOr9ZznWB7gj7VB17358oLZoQwMUfFYwbKYcI0+Fu8Sjm/yUxqZQ2?=
 =?us-ascii?Q?MIPtqHlAia6SRZcnYcHWYGbGtHjWYGwhsqhd8AAkOFEJOcmQMcQBjQPAIqEc?=
 =?us-ascii?Q?/DtkXGsOXJU9mkO1ZNSjk0wmw2j9j3XwCgF0E7C5EU223yehi+e7DARy7r77?=
 =?us-ascii?Q?AGW5MdgG4lrXfkq25hLtqH+tcxLIcj9XnG8ByCMRX0pIhmIj5H6l0oHPXT0t?=
 =?us-ascii?Q?NH13KA4K3fzRR+VNoArQ8zFCcNRXBaNpXuk9eHYgNNlH9RrlR8vxo5ph9lwv?=
 =?us-ascii?Q?C23cFG7Qg3gB93aVDwzsdOIhOuV6mXyQAQ1tX+DGnxGy0MS8L7r3fZ5t9wqk?=
 =?us-ascii?Q?zWmRWVO4ORw02RkFRANGdRKBLnxZfs5ALmII6CwFO+4fMKmatFOay1asEzhD?=
 =?us-ascii?Q?I5IL1FsFUvt/7Z8Jod8pS7LgY7AQjOOjtiM8GzCa2GBqdGb8HrVH+MHKmDHm?=
 =?us-ascii?Q?ZxvVm8yvYvS2Xn9hkJhA8Qdjp7RdXq424AGvtRarre4lsx+02kFgVX71d+OA?=
 =?us-ascii?Q?AqXRJbo0dmHv+5DFZzHn3U1xJU/OAzSdCtnSyRMQqHnuuvtbM4RwBpFyYhlv?=
 =?us-ascii?Q?uPWzCcaD6z5cnflJTCx1icU6Dra156v4Ak/ArbZ52A6cmpCayKLisWgzGqWP?=
 =?us-ascii?Q?hpJhLZcb7S/X4tTgYmoUhSRCiJ0rJvFSoG3X+mgdhDwCJC+A7ffUFOh/OtnQ?=
 =?us-ascii?Q?RVJEE3q5zSDBkIieDO1NeY+5io7a01zRUqdLng29BCa5eMVnVNpkW1nGHLim?=
 =?us-ascii?Q?+P+4eX3CijVkA0lbaTIcRh70AvaHVDWeMCE+tPeBsnuzAARlrwh9JeL1XfJg?=
 =?us-ascii?Q?+pUJ7VYdMA3TUwx6lUUj8GZhrNlaNMijME5uEXaxKcSi79pVP8HnuVNWctED?=
 =?us-ascii?Q?xUCWnicllx72moRlXJpDXpARORSPAmtd5wcfC2aV8zUdkTaG0Lej90FWcY9H?=
 =?us-ascii?Q?zNmoznwoDVxKACibVTsh89dCOSolKllRdjw9FQC3qnWdBeBrC8k82gQ1JhA+?=
 =?us-ascii?Q?7ZnEyW0LmAiisFieTz5aMbAd878uaRqnC0GiPWODRqv1r1JL3sqSLidIgMrF?=
 =?us-ascii?Q?zG9aqOU1cTrCNirTY6S0H7E+ejRvmj+2B+2mhQdzILMOjx5vgPt//+Pzc/Db?=
 =?us-ascii?Q?qBpsSiJBpqTlF4TWQxvq9uOfOB8iCGJcHjXiuN6ayL5NN0EFJwwTTd+0uFKb?=
 =?us-ascii?Q?QQ2Ml7fRdQOz335gWVgPNjAlVItKuzeQKQF0eW5Jh1+n8jV3Qr3ffdVcAdVC?=
 =?us-ascii?Q?UdOroL5U0ty6/OnnCSsqA+99vGaJFWbAEp0cxbLO8aaxXeaKwJ6gcGUwed5s?=
 =?us-ascii?Q?44uCB8UvWc4OT+8Kf8V5n7e7xWG99Nh1uMgKpxyax6TOFk0GwQRhWUI7HpUe?=
 =?us-ascii?Q?+RN0jWkywskdzhLcmmSxvY12bn2SITuBNonqawIw0jOpGGxoTpX6f69I4r4s?=
 =?us-ascii?Q?/qMK+d85eWeApm6xBfzku/e88bYiK8hW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AW8u8uT8YZ6yflthjZW7yFXDdrl9tUUMgsq6yy+eJfCEhvTgJrs9gemHYY/w?=
 =?us-ascii?Q?2sJ/F2gbwIc5bLsPbHc1wPbmcstnf8uALJtkBiddoapB0I7ntbtMhabB5+bS?=
 =?us-ascii?Q?r5+eouA4dkYpBk70KB4WgbvGzzMrmbyWF/+0hr3QW+boxq8MhmElt2nYW2gc?=
 =?us-ascii?Q?pL8Xa0TGxeuYKQl32qLjn9O5F68uN/ff9L1YmyKYItMml74i7+XethV4SMo1?=
 =?us-ascii?Q?vVq8gqBI7QTWDy6Y/OaMJ3ko5cGrlNkiJJpbyiGQGW+DUIGYNjUAbmcGMCFx?=
 =?us-ascii?Q?SbBZhqgrTCmFYDg4oKkgHLV0MztG+syQ66xqc8IHv6mx8r4WoJZFlpu4jY0i?=
 =?us-ascii?Q?lPf7obbLwYeT0LTyBxgPOaCxuketecsyxd6EQOUXq6+bY1iSzwJa5u8szuSa?=
 =?us-ascii?Q?1eDFbpbMj71YP7Qq3NFyO7PQA5unr5eY0mUmUge/l8IqcPlCMD5KAtkCwl89?=
 =?us-ascii?Q?1rccDLwgSkPk5ACuYxUPmdJolSK6nS7lbn9f5SDqKRb4BVorjKDC8K7fldzK?=
 =?us-ascii?Q?G9uWNUvHrDhJHWjkUq3uy+nMa5DcZ9YVJqMiJbMdGw6bAAZTZIe7C8COc8H4?=
 =?us-ascii?Q?kJCkhoGv05f9+p9uvkPxwxLULAHFCrlON644lnCjnm/094MJiiHCuas+twcD?=
 =?us-ascii?Q?XBN98+Sso7cD2Pobb5+H62tkDiHdUUH81wNPX75B1PFadq1ACJr/ai/hmtR2?=
 =?us-ascii?Q?z/yaBd9LnJbJns1CUpLeCiI+UfkKIo6bOt92CBMPhQdmn9MwR/GV1OcI7DG8?=
 =?us-ascii?Q?76sUzSDTwlgrcCG6rqQQ7KbCedpdOf0OCgulpysHNIWLGWSD7AzmTjE5D5JT?=
 =?us-ascii?Q?JVPp7Mws8yhNYX0H4qHhyrU+tbJGNuWVQ5gPqoQg1bv1F9MHKrSXxAfB5r1S?=
 =?us-ascii?Q?4kXYpAMkjouw1aadD8DdQAbGqWqWPp2ucY4OhL+c0O2uVXQP6TtqAX1icl3e?=
 =?us-ascii?Q?xAzk1KuO2uyvBQoz1NnIRwtB059QIf6YrNRm7t32bWVIrl9yAnrMumMM/OTo?=
 =?us-ascii?Q?6CAdpuI6YSplL/CObJE/++6wkHi4hJtnbw1KplHAV8POm1bWuchelOpdMSK1?=
 =?us-ascii?Q?rvdk6IJx01OShE2yUIe5Ndc1UmeuQONoSpZ98fydTQZomZEVl7z3dqaW1Hnz?=
 =?us-ascii?Q?T1NhwAbp8BR10I0rGp1bEkopmI1AldLLHINGW3bAJJToODMyKYmrxB4ChUsW?=
 =?us-ascii?Q?7b2guP7Vd17ULOnQ//FbLraumvyIUENAXifP5H3kQGIvBgVoNM9/492RIwvh?=
 =?us-ascii?Q?T5mvxgUJE3nwUu8x+MODHGL+WnSgqwfYKe5E6rpNNSXYzaCtU/4iw+BBaOvD?=
 =?us-ascii?Q?fTIzY0h2H6aBCasZLjPFzdWc/byrjOPoExkIHyL56dk/AOwrVlAkaYe+V39c?=
 =?us-ascii?Q?QDAknmGZVPaopneT2a5W7so1nHjfNfwvUIxxabKyeCI22TOYV4Dw40kU1YY3?=
 =?us-ascii?Q?xsln9V+K1oFhdRPhcxTr/e0mP+KN6cGt+HGstGkczfUgK9kyXgWnmW2JRjo5?=
 =?us-ascii?Q?v7dTlPdL94AFQrRd6XNzjik6w6gAxEjXiQwIOTgLz5jgGgG4sBp06pcrTd+S?=
 =?us-ascii?Q?7G47+/4/G6v+oStokb7mwBNyR0r2pmly/21yt/SL5JtqISnXzKQDvOKwUcP+?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DdXIc/fz58/zcd8Ud8LVkZWStKr3Z7y1GXq53InBLyBS8hUVA7CuDcnoTgGrOfhRBmwaKRDtrKNwAQvOquqdvTf3uSXmRrYLAzPwn+3viylPgz4NU5ohM9VRrw2o2lWINEO1T2emgrHOcNdpCNYqaXhXJd6gF81wAmobdjOdC8m/TPNxu5vDOQbwuSGwz3qElZ2jbEEb7Ccu6trNb1PSP9/bl0h4z6vrGPLMrEhlDhlcaU4+EbaVQN/3JXdiEyGPVn9gqveYN3bBXaIqPzcXgp0T+vRq5RQMd2PuH+AdPWh6Xj2xbrK3jSZRwkqQV0jQg0SJEy/r8aobVM1J8/mNTYr0T84wZaWO9w8OLLjtUI9yYGIaPNOCc222NRYV1vrzHX8LU7LPsgv9V0ehSkc6gOGPJ/4a5B6f5TsfhInh/zmcT2tiHfw0vacTk7V1UFFAEGqu9ugZMKgqBqOCnF036qgNmwUZ1Jenj+zGQxC5RVjKRYRNLBfFB7jUkYirCD/X4kPHCSdrNZYRojtsFa0vYa+qCCkvixUFrS4ZlGKSOS+ycnHh6JlppECY1GvOneuJW8VdP5fbkWn56GMu8ClxNBsLjA2NYLP0cBFZmRgQWQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbb1e7f-e818-4273-db2e-08de2b412acc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:06:42.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ez/1BQtdxa8M1IqkrE48M/1Y0PgP7WRMJWEPNiRe1IDEOcW1ZrYtiUvlleYyN3AMTpSULsDtR3rUtLmBTHPgsGie2HQl68JyvvvwnfmJYkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4OSBTYWx0ZWRfX1R25MLDkJ9Fz
 aGOJVfPoVGzoHMzgQdMjxTmH1zahpX7bh93u6OLlkPalosNOC5Et9ttswPpMSywr7hXE5mD0S8L
 MMyvI/6VqqgXb+Vlja+jlMGsiAer+4LySKZkIA31Q5d2RlGvqe7g/i1OqL8P2req3Fs4zQ90Zbo
 sQmmh4Hocbls7wgyytcChp9RlD+qHC7ZdZR+BbHNDQ8o43vtEbLbqnX8Uf/gAQLcw80Zqz2Q3A9
 4DGv0P+6WyjpQCedE1grz6EdaWTVGW+V7pqIqqjYthNllL/iy4WknjQsa03cPwGOxxwwW466HRf
 ZF7JepeJ5pimonCi8DwElQM7CeLi+RwOSQEASEQdlDp/anPD0ghs7TIZWnjgPux2zGxbaD2kzEa
 /yJYtuUT3R16LK3zJh673myl7WT9LQ==
X-Proofpoint-ORIG-GUID: I2iPR9EQ0mIQjQJLFFrKCBDf8IzJ_LhZ
X-Proofpoint-GUID: I2iPR9EQ0mIQjQJLFFrKCBDf8IzJ_LhZ
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=69242e37 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DkZWr7lvzT-ektGKoR0A:9 a=CjuIK1q_8ugA:10

On Fri, Nov 21, 2025 at 07:44:56PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 10, 2025 at 10:21:18PM +0000, Lorenzo Stoakes wrote:
> > There's an established convention in the kernel that we treat leaf page
> > tables (so far at the PTE, PMD level) as containing 'swap entries' should
> > they be neither empty (i.e. p**_none() evaluating true) nor present
> > (i.e. p**_present() evaluating true).
>
> I browsed through this series and want to give some encourgement that
> this looks nice and is a big step forward! Lots of details to check
> the conversions so I wouldn't give any tags due to lack of time..

Thanks a lot, much appreciated :) and of course thank you very much for your
input which has clearly driven (+ substantially improved) much of what the
series does!

And absolutely understand re: time, always being behind is something I'm
gradually learning to accept... :) gradually...

>
> Jason

Cheers, Lorenzo

