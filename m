Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166A1367612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhDVAKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:10:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235076AbhDVAKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:10:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M00pAL007547;
        Wed, 21 Apr 2021 17:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kQX9SwDx5Psw+ILxHA6YHKFa8tmyphGgCCgbYqxY02A=;
 b=BtQFBgGi/o0bl2q+LZ5nStU+zAgg8dO3BlfWT4crbAwMfb7GsLvyIbLqzsGF8FcsghYV
 WHirq7eF2+YyuZ4Lw3eEPZSOW/g+yLoIJ2jHHaiNdbq4pP7WGpvH1Z1bEYiTys/tVEPM
 xKijlAJ+FkLa5tbnI5pZHfw/hrlpQAwd2H4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382npsutpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 17:09:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 17:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDQwntw5P2pJIoXcEGVQ6FdXdY+lkJoAH0xPBBFKesVEYblJp21CXdFvzocS6sKio6U/GT2Bq9RzSZmAaoJoz5ghF0b0+Tt0EcO9ycZLOMpLaCdBjM/nGWoMaUFhGVLh2P9kq+9aopR8WCrwjUIm8AGNVcl4ElFGZqpA/GYiFsvxTSa5kKq980CANdhgnY8gfz4P40wsjAxxRdZ3g4lLJWc7FW3GBseWYuthlXFgpGruN/sRebPSz3xsnAi9dcJN1nz+OiZHLiowEOgu/MIlH7XWm5MGnmr+Qf5rPOhpPV0I+Tbve/i5QAif7T4DD3phe74ZrMCxSjySbovn77dVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQX9SwDx5Psw+ILxHA6YHKFa8tmyphGgCCgbYqxY02A=;
 b=JjggYas+82MOGChs711f8SYD25+SdbCcvylJtinNKFq7Zlzh+FF1beC+acUzUv2cHHYJSm97TXMCSbhw8RL9A8GDBXDgCh1LI1Q2VW1KimUwoSPYmyTJfSDoqnSuXuHJrZAB0Ax2sCcNMZktW7pf8EuURCjvs1ZEnp5romIgRVs4orLn69F4VYXu4fhAv+2d1DuoWo0ChangsdS++aC4wtkOR/ZtiD9xTUsJFrSuqbWqwa8b3qhxfGuA8+7uGHzpt0SVXOhigdQ4zlnPr1sz1Tu7VKqi5QSihIN7MMA/7MEuG7LDsaD3ib9rFDSOHBatdJxzil6bWURFpH/DWl7JZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY3PR15MB4897.namprd15.prod.outlook.com (2603:10b6:a03:3c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 00:08:58 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 00:08:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Collin Fijalkovich <cfijalkovich@google.com>
CC:     Suren Baghdasaryan <surenb@google.com>,
        "hridya@google.com" <hridya@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "timmurray@google.com" <timmurray@google.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
Thread-Topic: [PATCH v2] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
Thread-Index: AQHXKnknEhLdpDmfP0aTj6hRIe6caqq/wmuA
Date:   Thu, 22 Apr 2021 00:08:58 +0000
Message-ID: <16D17333-1BF1-412C-8EE9-95CF61F741B0@fb.com>
References: <20210406000930.3455850-1-cfijalkovich@google.com>
In-Reply-To: <20210406000930.3455850-1-cfijalkovich@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:c34b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd0e5b8e-10c3-4441-10ec-08d90522d352
x-ms-traffictypediagnostic: BY3PR15MB4897:
x-microsoft-antispam-prvs: <BY3PR15MB4897132D126942C9238CE744B3469@BY3PR15MB4897.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6z/xbcLHPHkml42J4mleSqJbKVxefN3zfaLoXzcWJcJ+o2k05kJWYotdK3+J3WZ8MfpYhm6ouUQrcO5zvRdjZTppxRUKdw65k6B/hl4OjoabVwa/sOLJLty8+T5fkfoQ/RrztBytG/rPqo0beVJYp8hxTeVHrpcnd9qY/kPyDY2/s0NUjYRRTy1JE9bP6CyimV4zR9UnxMcmOSegj7CwNtmIR3rD8kpvS7Dv7iyvurD2xGnWfnF4arqUSetED/tOtHW/1U8iH4zVIZTlEpZgIOeEHrHeCtRWKKq/7JvJOz2v1gdySgpiSyDT/ohf8MK04wuWWGXiLv82UAqw9iDqaAZZ2rpaGpblzAajErya19qp5wQKncO9xJR68q6eyRThuP4fEAfsAY5PtYrdJswNYPcxIpGVuiJL6h8XrEiQ8FvoGUB94eJoj27FZLjy5LGvh95vGtfNgJgsmnAoxdxBYkbCenUQzYKuAmHw5q2Cg2qY6gkZvq2hgyK7kjQuBo5GedK7GOwfKDgGaTo76UV+vqr+/oJHm2XNeL6qxWBV1cR1V/PgZgs5pgE3MtFdg19Emjwsx6OrsPYtwGUkWMBnkr8GztbGBX5XcSyb9lnKBb45sO8O55mZ2/4Ab+wwiEmQx38CKOXbKbCPZTGl8J69Vn5dNNmCJToE8+Cp7KhrnnfBXC46HEmg8vOx3qbd68P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(91956017)(66946007)(64756008)(66556008)(5660300002)(316002)(66446008)(66476007)(2616005)(6506007)(54906003)(53546011)(76116006)(71200400001)(186003)(478600001)(7416002)(4326008)(36756003)(33656002)(8676002)(86362001)(6916009)(6512007)(122000001)(83380400001)(2906002)(38100700002)(8936002)(6486002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fsQuXuM8EE8yRb/1Rm7k1LaqJiS6JEkILYPVtcSHE/ZjNvViSkakXSecaVGJ?=
 =?us-ascii?Q?FqBgntq76zxeuWBalD0CVNaHpJFozx7/VJogKx7NbYmS3NUOiZxwGt1/OL4X?=
 =?us-ascii?Q?H2vphwQPfeI8+h87u37W++7OnPMr3NQ8AQTM5Vs5kRw4lgUACkiCyTUXkEdV?=
 =?us-ascii?Q?DX9TSRUQbeEo+AUHkP23d+e9OfASbbNCTz+dzxM8uBmtWOX9fbsjiKg/6Q50?=
 =?us-ascii?Q?AEZlgRch3lqZ9tRnMf7Q9el4dr6DpYzyrtQm9MOrfx5/YIHZ9dnLj4I5F2Qm?=
 =?us-ascii?Q?DqnN18BADGRYh+CWxaXoU7QrzP784L21F6h2DkafcBU5sMRL51SY+hls0vev?=
 =?us-ascii?Q?FX3rzkfhWPJyz9eXQ91vOgdHmMNb6v0bK6338GyNC+xgFerL535EVA+DIJZi?=
 =?us-ascii?Q?Cu6QzdQ8NqdXyZ3DjVJozoW5oarBTEynpFWM+3WDNNCK4AIssy/o18IIjBqN?=
 =?us-ascii?Q?Vu/IxVerqbuTF/Ub5bBsSwZyVEKFRjSlzqC/WRuWVhnwppOf4zQiXJLvYJW1?=
 =?us-ascii?Q?sOjNwJlc21lydu4aEtE3+zm73d1uX6+tAE5WDf0F5WuidxVEQmHsgB7BCA9c?=
 =?us-ascii?Q?17uU4cDoIVHkESgZDQ6i8ANQppn5/OcuNlBAUtWBgs1tog6vGrysI8quV1K5?=
 =?us-ascii?Q?tbhV3htmQd8c2G3imgfLW1vklMQwUHhTOTSqyq356bnCJxzOL+XTCHQWXvYq?=
 =?us-ascii?Q?rUL8cDCQrs3YgLCOl92OzV8UKuCT2ucdBgzQ/wvAgHWft/R8w4PnTMFZ0m+E?=
 =?us-ascii?Q?j3psnlOaGsnRxz3HKELMIj5KLUjo6p1ZZwEzp70WvnWdgPVCLKwDrosFBe//?=
 =?us-ascii?Q?vmsmv6nVAkEm/EDbUqrhxQ/1GzhqrGme+qG9DQjxbE1oJu+7NsVBtuKC+iFv?=
 =?us-ascii?Q?N8tRkhO+/EwtITcMm67g4MQu66VS8cATRvwc32fHckm17YaKI86ySY2CCIRL?=
 =?us-ascii?Q?3BD3HXCjG3AQOl1DrCgdU+6oNarawCSHrxhwyq34wT01dX1qVmOm9NdGzdMO?=
 =?us-ascii?Q?ITb1UjVTFf/JywAUNf/GUAVKPKdmVUYyz8nTUvDxL7luCDJpqSUlqDjPNH/C?=
 =?us-ascii?Q?IImcr7CG4/LYU2uGHf6M0b8g2YNnVOmDn61z7uBPomMfoEi0pQaQpItuuPn0?=
 =?us-ascii?Q?OUAoaonUzAPpImQrg/S3hU9sGWGBPq8B9HR3EDkvCkzwdvcoTTroSLojiB6e?=
 =?us-ascii?Q?FgWboQU5Qs+1RG2okard8GILeb5kLuXoYHTE3moqAsMTfbU25YE99pFd+hVb?=
 =?us-ascii?Q?WxSjDBmbaOvyTFB9TNdl03veiSLW6eznd8QSlorS1wha/15Var7i8D4Fe0sD?=
 =?us-ascii?Q?d3CHdrGX8VceKqJaWbfvEkpQpt4odh13WdJ1iIHdhIPXAteItn71f81Bbvca?=
 =?us-ascii?Q?BsuOYFY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D395478EFEFE084A9DA631861376CDC7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0e5b8e-10c3-4441-10ec-08d90522d352
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 00:08:58.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xces6YhD2jUbMMQ2XH5wJCTZrD/43PUkvr120GlzKp559CtWCebIXg+oRKu2h18sO63x7cBRRCwnungv9P2Raw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4897
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: iGpGaTnDlo9Kqe0WQsRnDZMbi8Oydbqe
X-Proofpoint-ORIG-GUID: iGpGaTnDlo9Kqe0WQsRnDZMbi8Oydbqe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104210159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 5, 2021, at 5:09 PM, Collin Fijalkovich <cfijalkovich@google.com> =
wrote:
>=20
> Transparent huge pages are supported for read-only non-shmem files,
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
> Comparison of the performance characteristics of 4KB and 2MB-backed
> libraries follows; the Android dex2oat tool was used to AOT compile an
> example application on a single ARM core.
>=20
> 4KB Pages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> count              event_name            # count / runtime
> 598,995,035,942    cpu-cycles            # 1.800861 GHz
> 81,195,620,851    raw-stall-frontend    # 244.112 M/sec
> 347,754,466,597    iTLB-loads            # 1.046 G/sec
>  2,970,248,900    iTLB-load-misses      # 0.854122% miss rate
>=20
> Total test time: 332.854998 seconds.
>=20
> 2MB Pages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> count              event_name            # count / runtime
> 592,872,663,047    cpu-cycles            # 1.800358 GHz
> 76,485,624,143    raw-stall-frontend    # 232.261 M/sec
> 350,478,413,710    iTLB-loads            # 1.064 G/sec
>    803,233,322    iTLB-load-misses      # 0.229182% miss rate
>=20
> Total test time: 329.826087 seconds
>=20
> A check of /proc/$(pidof dex2oat64)/smaps shows THPs in use:
>=20
> /apex/com.android.art/lib64/libart.so
> FilePmdMapped:      4096 kB
>=20
> /apex/com.android.art/lib64/libart-compiler.so
> FilePmdMapped:      2048 kB
>=20
> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>

Acked-by: Song Liu <song@kernel.org>

> ---
> Changes v1 -> v2:
> * commit message 'non-shmem filesystems' -> 'non-shmem files'
> * Add performance testing data to commit message
>=20
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
> 2.31.0.208.g409f899ff0-goog
>=20

