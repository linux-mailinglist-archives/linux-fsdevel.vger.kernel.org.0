Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF234703C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 04:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhCXDv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 23:51:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhCXDvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:51:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O3ohuX020057;
        Wed, 24 Mar 2021 03:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=frBJMaMpuJ3HbvO9cs6h3WpZ4nzincwrLEiOJiLNCkM=;
 b=LPxTPzX06e0S06SPiLod/p6+n/bC95+RUHL0dFSnOcwaHJrFNQyrWTSAPIqWdVQSKDWv
 kYL10efy0llz2BXVvtuw/YlrzYwIKR5MBr5KOW96X+oaut2g78z6A5IWKDwksmLPC5F5
 lKVFJ5r/TCAw6T34Eud/3lyguNmymLSPIP+DVoo4PvWrcnoo2n2OaSVPzJitF9i+FrmO
 6VencsIVRxXtphm5uqLRizzN0OXmkxo6NKOtmbflHHhLUTOjxr3bZn8htKhYtx/7SChM
 1NZi1uSAOKm++knetE7o9KOMEpr2/pkTvjACTUuGIoM1EOpGMbLbfROFoz7o7e4W/10L Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn1992-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 03:51:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O3pBmi077473;
        Wed, 24 Mar 2021 03:51:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 37dtmqb34q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 03:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up+kQhBAwIP/AiT18LNMuUkeY8YsvsFMIUE3kHlCytjjX4WpixN7frBOkvABHWzXrnQsyJky+l88thL3VyWX0JmY1P0FEI88lpVq8LIQyMmQ5ZEewcfJUeEk0Ptru4WeZaE+jQBOFs3hqi5P0nKmTkDoXaq0OOSQP/Y5r4idTKb53Pp9PnNh4ym9TgzEq4Sla6lWZFUKWY+IYUH7KiojCdKBlakadJQDX0jgLtreOtBoOYuA7Seqn8Z8/oVTZ8rgwsxWCMt3sIfL2mSlWltOKEfoSmaRI0bR4Ghg2r/RAgPmF7lZOo8dIrl1flWRoe7cqJYTOvn7ujh8MZ11MED6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frBJMaMpuJ3HbvO9cs6h3WpZ4nzincwrLEiOJiLNCkM=;
 b=HuMoplFcxuD1/I4CUgdO0Ifm+JhUP7pjvBscv+AKMYJfpB6jA91jbSap7crrredmROKi/YdV0ayk7oh6YevOJfZtH7sCjPjJ0zjrPHYxCkWWWFgdkk9YsjcpxuYisSPqtc3O9mxV8xcSXbfq/0QD+hIzB5Gq6nLkasgDVXB/ni+9jFklw96hg56mvSwZtjlyODIt4kg9j6TJYr2/0V0MazgwYtOWn15ofIgC3RwUtXVBFX787nOMzNoKmBzzQkvw7nojgB2bcKyfkfsCgkaiV1a54kKGu+FmP6XELL8iBJf3KVJRoeYSwEnXyydlAAXmwtB8EqssWjN99PWJh6t4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frBJMaMpuJ3HbvO9cs6h3WpZ4nzincwrLEiOJiLNCkM=;
 b=WxZZzqk8Q6o2s9NDBDSF176KYcDvdeLNtIkRwKoms3/SLAVGZBpCmE9ZuQ5K6qzAgHWzcte5xogQPbD+uKT/yUGchmJ7AlbyI22pVeB+KrlAl/Aat997ro5eRn1AxHBO+GXJ7uFlXt5igpbf+AQ4OOmM6Ia13DWvZU7LVGaz7Pg=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR1001MB2261.namprd10.prod.outlook.com
 (2603:10b6:910:41::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 03:51:13 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 03:51:13 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Collin Fijalkovich <cfijalkovich@google.com>
CC:     Song Liu <songliubraving@fb.com>,
        "surenb@google.com" <surenb@google.com>,
        "hridya@google.com" <hridya@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "timmurray@google.com" <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed
 THPs
Thread-Topic: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
Thread-Index: AQHXH2bOPa1UqQyVl0aDup/ffvlZfKqSgw8A
Date:   Wed, 24 Mar 2021 03:51:13 +0000
Message-ID: <FDF4AA6D-1350-4A5F-9C1D-36032E2E25FF@oracle.com>
References: <20210322215823.962758-1-cfijalkovich@google.com>
In-Reply-To: <20210322215823.962758-1-cfijalkovich@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.20)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:4d2b:b909:57a5:8009]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 612b689e-19f9-4df4-be86-08d8ee7811d0
x-ms-traffictypediagnostic: CY4PR1001MB2261:
x-microsoft-antispam-prvs: <CY4PR1001MB226147F0576F87E93A07F70881639@CY4PR1001MB2261.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJxy6DPbzvrP+qEuyvOt386RtWZnTqbYs2wi7P2zsohclXQVXZe62Hua6hBFSQ0yoGKHT6TUaU9o9Fz3+Hf8iTd20KBAbODdHN29n2E3v/NYw6+i7RdsbMTq+GycOcB0Sia7jaXbZZ1TcYRZulPlvh0uAIDuloq8GhRPauYreHmsZa4MX4btuaNrF+qDBfQ86NJI32u5wMUQrJg6N1rhDymdnx3/lrJdy/cZIi+OkxtwFS+pcDRl42504Q6uJfwKk27KYnZnV197abBMO/R91IAFAecxm/dEvf4NQEa9C0/BDLWq15CQKML0JRxPL7Ip8GVDf6J0/6yRU0UpDD3gAhQL6Dtvxk7CYGCxhCFDUJfz1jabq9PeWrnjXle1h7SPZBfhr9Jw+UsuA9j0hC/gA0eTOFCIC5r6sTxWu/NzG2FPuJqC7gNSK3PofS2xe9ZigEaHaaWGYBZKW0CxH52XCvMhP7TGcg0Ww9dTBYLc6dIrBvkzCuqWkEmrQsxGPcvCUEzOR+DQzwTR5k2cm+klkkiSbj2L1EoYepUF1pR+wiEBqHvIHYeGbKlBKYzziIhHDgWHYIWN3VdWdoPiwoEduRmJEJGUtlYl+sfsktf/Wkr6B9NwVUjaPhCMrm5YdNYtctZRyLTZIs7rYc3tCPOCKrUV9Ur0w11ZZFNqJw9tbIqeYzTnaYfv/MRdyJK30hXL8KBxjyUk8sHkjkH3MlRe3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(66446008)(2616005)(5660300002)(6512007)(64756008)(44832011)(478600001)(66946007)(6916009)(36756003)(186003)(4326008)(66476007)(66556008)(6506007)(8676002)(53546011)(7416002)(38100700001)(76116006)(8936002)(316002)(6486002)(33656002)(86362001)(71200400001)(54906003)(2906002)(83380400001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gizTl1elVbnQCtIs14hiAmQHuru2is7jG+iOF+Do4tf/a4JIPppw84qj9o49?=
 =?us-ascii?Q?h5ADckwCxdoCpzkpzk2i+BLMk4DEK3YgEVrGSiGBShUdPW5e2imT01ANsdHr?=
 =?us-ascii?Q?8ZuQCPdn3n0xlIMJr61PsJbK1ow+6SK68qzYrvOSy1zijeHHLvHCjw02etOL?=
 =?us-ascii?Q?d4L8owmUyanQtfcVi5FggUSuZiWF8/1588Ln8Hxv5LmRzLFdFjmRZdmZIwsr?=
 =?us-ascii?Q?9zZGKPIrwNU2ag+QR9WKW4LQmHTWxCJuYFBHTjkbfsHnCnKXrMpHmjM5f278?=
 =?us-ascii?Q?5SOVdGzY0ry05ZcocsEmvKNZ+eecJjI67y1H2Bz3SyIXDaJ/nkt9w8oCSqup?=
 =?us-ascii?Q?EZgluXHLG87OfRH86tg3JBhdQEcv/2L9MKSjP2A4qur274mcaPZ4IO02cpYq?=
 =?us-ascii?Q?WDugvV7dhUsREZw++HU2vXLYyNb+UalF7Y8GP4F+5vDLwM8Bh0ldobeseU8W?=
 =?us-ascii?Q?Ur1ls/nLg1qUCy8d+zPBB+skeARs0G+dbpapbMKoVzPvQJ1qXAV3oV+CNhsc?=
 =?us-ascii?Q?cXP6Ug4UJEag5CNy1wVTNkUJQlZtgQiEyzso1O0ar1JUF3Y1UsotucC5Ss9j?=
 =?us-ascii?Q?CEt//+oV6ZFnnmgHJpaespsqyFSrW9YjBwHk93lK6JKQ3ldUiWczpfG3bbcs?=
 =?us-ascii?Q?IBkc4xFhkJdkY4HcJ2DD2jMHLXkG7zfFGnoYwrEXnAJVpBhJvH+qm8jiBWao?=
 =?us-ascii?Q?bDuVfDn4gRmHkXv65uAfqTYx6RQiPkXg5+CMjk9t9AZKUwEuMVryBsRjbkh1?=
 =?us-ascii?Q?pHN8VoKEOuuVNKFZ1nVKdBRE2CQxwej5GuHF83eVKqmztzsUJg3DgbRfWhNu?=
 =?us-ascii?Q?st/flCvnFC42CVaFiyIV2BkvS2uq8BR9mK00ZL/4alymjWUZnZS163WS9m7u?=
 =?us-ascii?Q?fDSnWjjGM82L/+U5yQtH6AhITndR2NfTlIGKNoXtTnRNlQLpoZddF/abF1XB?=
 =?us-ascii?Q?3wN7ZJ4w0sHUhTJEDuZlhPgZsTcxrYI0mALDX5isjvGTJ1824oxCrQvPEJ34?=
 =?us-ascii?Q?oMFBlroPa9OSWlo9ZFrKuZZousG4SpynjNYGVADW6KMEW6gSf+sWX3J5DZTZ?=
 =?us-ascii?Q?ajmJM7seuSettrZi+9QvQ/6O8ZXAjo4295+ujc5ymVfl+YGSxCP8LBNLLGO5?=
 =?us-ascii?Q?Trk2pMSbhoYa4c6d+WytVbYsBvPSmqGZVjDe6k3YI/4mzn/pe8F3ufVfob/0?=
 =?us-ascii?Q?jb4vaLjR7BWHEs2Wwz1TBNMwnDctLDJmbbckWa5YrRFKDFIqPu3nyAbDqxvH?=
 =?us-ascii?Q?Z0kDpY4dwSRO6f9brvnDhHRY4XKhizryP7GDh7hTxjaAAA0pfPBcnUcnCOgU?=
 =?us-ascii?Q?tIJ/LlhkGUcp0X38XDDUIKfpb38C5/xFXO3YfQ86vM4KcDzVAUtOF3euyOdz?=
 =?us-ascii?Q?AGlS4dYB8MmxEhPh9nOQF07iueif?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDD0DBB880B4D14E8BD82DAB86956567@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612b689e-19f9-4df4-be86-08d8ee7811d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 03:51:13.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoTX43xlFxLSY2JzbxVhtgR/S1mRvO5pGjo6DnH5RehHo3fsiZty3T8O1OBEdfJLkC4fNnqqtzExqGHIHXIopWgiZqgDAVZKrHbLtuZtVUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2261
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240027
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240027
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I like this, it reminds me of the changes I proposed a few years ago to try
to automatically map read-only text regions of appropriate sizes and
alignment with THPs.

My concern had always been whether commercial software and distro vendors
would buy into supplying the appropriate linker flags when compiling; your
solution is at the very least a good head start down that road.

Matthew Wilcox and I had noticed a lot of ordinary apps such as gcc, Chrome
and Firefox would benefit from such mappings; have you tried building any
of those with the appropriate linker flag to see how they might benefit
from the change?

Thanks,
    -- Bill


> On Mar 22, 2021, at 3:58 PM, Collin Fijalkovich <cfijalkovich@google.com>=
 wrote:
>=20
> Transparent huge pages are supported for read-only non-shmem filesystems,
> but are only used for vmas with VM_DENYWRITE. This condition ensures that
> file THPs are protected from writes while an application is running
> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> when a file is opened for write in do_dentry_open(). Since sys_mmap
> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> produced by execve().
>=20
> Systems that make heavy use of shared libraries (e.g. Android) are unable
> to apply VM_DENYWRITE through the dynamic linker, preventing them from
> benefiting from the resultant reduced contention on the TLB.
>=20
> This patch reduces the constraint on file THPs allowing use with any
> executable mapping from a file not opened for write (see
> inode_is_open_for_write()). It also introduces additional conditions to
> ensure that files opened for write will never be backed by file THPs.
>=20
> Restricting the use of THPs to executable mappings eliminates the risk th=
at
> a read-only file later opened for write would encounter significant
> latencies due to page cache truncation.
>=20
> The ld linker flag '-z max-page-size=3D(hugepage size)' can be used to
> produce executables with the necessary layout. The dynamic linker must
> map these file's segments at a hugepage size aligned vma for the mapping =
to
> be backed with THPs.
>=20
> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
> ---
> fs/open.c       | 13 +++++++++++--
> mm/khugepaged.c | 16 +++++++++++++++-
> 2 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..f76e960d10ea 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
> 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
> 	 * cache for this file before processing writes.
> 	 */
> -	if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
> -		truncate_pagecache(inode, 0);
> +	if (f->f_mode & FMODE_WRITE) {
> +		/*
> +		 * Paired with smp_mb() in collapse_file() to ensure nr_thps
> +		 * is up to date and the update to i_writecount by
> +		 * get_write_access() is visible. Ensures subsequent insertion
> +		 * of THPs into the page cache will fail.
> +		 */
> +		smp_mb();
> +		if (filemap_nr_thps(inode->i_mapping))
> +			truncate_pagecache(inode, 0);
> +	}
>=20
> 	return 0;
>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a7d6cb912b05..4c7cc877d5e3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct =
*vma,
>=20
> 	/* Read-only file mappings need to be aligned for THP to work. */
> 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> -	    (vm_flags & VM_DENYWRITE)) {
> +	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +	    (vm_flags & VM_EXEC)) {
> 		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> 				HPAGE_PMD_NR);
> 	}
> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
> 	else {
> 		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
> 		filemap_nr_thps_inc(mapping);
> +		/*
> +		 * Paired with smp_mb() in do_dentry_open() to ensure
> +		 * i_writecount is up to date and the update to nr_thps is
> +		 * visible. Ensures the page cache will be truncated if the
> +		 * file is opened writable.
> +		 */
> +		smp_mb();
> +		if (inode_is_open_for_write(mapping->host)) {
> +			result =3D SCAN_FAIL;
> +			__mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> +			filemap_nr_thps_dec(mapping);
> +			goto xa_locked;
> +		}
> 	}
>=20
> 	if (nr_none) {
> --=20
> 2.31.0.rc2.261.g7f71774620-goog
>=20
>=20

