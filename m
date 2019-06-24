Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE850D36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfFXOC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:02:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbfFXOC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:02:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ODtA7v005159;
        Mon, 24 Jun 2019 07:01:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=v3g3kTVrPHN1+O7i3QhpjmtmjpZbUVl4G5C6q8WUv5k=;
 b=Q0h3J6v4ETSbScxKqqZ5RA4UwG1mHHhym/rFJAlM0onGO34EtMsCgxAAJQV9VZj3f66z
 LvokUvBFYoyRF/hWtJW/HJ+GbDNhOuL7UAye9PEQeZfc7Qte40hkP+f4yi6zN0ok6EaE
 BCowW/ug9rY7NCWELyM5+JQ2fcQqNR7WN/0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tas8bs934-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 07:01:08 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 07:01:06 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 07:01:06 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 07:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3g3kTVrPHN1+O7i3QhpjmtmjpZbUVl4G5C6q8WUv5k=;
 b=m6+lpfpwUF6s9y52iuCZIlZHQSddYU9z6Gzij7GeADhUZu4en5ZmycdafVYPYtiFHFakbewasE6aAehZqd7wMUTBNNvrF7i5cR8tuEeQTvf2oupPO97cS68PI1op4lPkjJ31enCbPfCgeEhTQ6QYZSkqeOMqQwsXiRu3z2jR0pY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1853.namprd15.prod.outlook.com (10.174.255.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 14:01:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 14:01:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKYdGAmz09KUZ80Kts9GVGsmXGaaqwvwAgAAUeoA=
Date:   Mon, 24 Jun 2019 14:01:05 +0000
Message-ID: <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
In-Reply-To: <20190624124746.7evd2hmbn3qg3tfs@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:d642]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569c225a-65e3-42ae-b43b-08d6f8ac665a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1853;
x-ms-traffictypediagnostic: MWHPR15MB1853:
x-microsoft-antispam-prvs: <MWHPR15MB185309A0371466C4BB1CF699B3E00@MWHPR15MB1853.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(6512007)(53546011)(6506007)(2906002)(50226002)(316002)(102836004)(76176011)(99286004)(54906003)(7736002)(68736007)(478600001)(71190400001)(71200400001)(76116006)(81166006)(6436002)(66556008)(66476007)(305945005)(66446008)(66946007)(4326008)(86362001)(25786009)(5660300002)(8676002)(6916009)(6116002)(81156014)(8936002)(14454004)(33656002)(73956011)(57306001)(486006)(64756008)(256004)(186003)(14444005)(11346002)(46003)(446003)(2616005)(476003)(229853002)(36756003)(6486002)(53936002)(6246003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1853;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FQn27IbcXnj326Zn8r9r/sYKCz5HR1Od4yavvLcuKmEoAbg+O3FLXLig3D2QdeOtU5nNWa+qs7EQxwMcFeCiZl5MGMEcOn46zARax7Pyi2TCelW+doJyfMH+kTVFe4cqgVl2I474u7xPzRIOTTzUsSC+Pt448VfOWYA0jJj8OL2Bgcyhb+vDa5KWNGRIzEhNKALMOAclRs84RdXNETiqPhw5bdKfuV2iVjdkkb+xVJlPztjjDXJxULCUsGMtjFkr1NM4wtGjlbk6wVs0sW0+cLix/8p0yfocSr9j4YvLBTSxb/3IAb4JjjEY1f/prhv0qb2Gd9xkKmt9uQEw9YTAhEDQOxUWKKXFmVV1+lPnVzpjFTgtUxzLPZ5nS8jjw/EzvMOaLA7y/vWrN02Ew6Y5hzUPBu3cii+UVSjTRWnseaM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FFB1DDE0C11C44FA14633B7588DE2C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c225a-65e3-42ae-b43b-08d6f8ac665a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:01:05.3646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1853
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240114
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 5:47 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Sat, Jun 22, 2019 at 10:47:48PM -0700, Song Liu wrote:
>> This patch is (hopefully) the first step to enable THP for non-shmem
>> filesystems.
>>=20
>> This patch enables an application to put part of its text sections to TH=
P
>> via madvise, for example:
>>=20
>>    madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
>>=20
>> We tried to reuse the logic for THP on tmpfs.
>>=20
>> Currently, write is not supported for non-shmem THP. khugepaged will onl=
y
>> process vma with VM_DENYWRITE. The next patch will handle writes, which
>> would only happen when the vma with VM_DENYWRITE is unmapped.
>>=20
>> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
>> feature.
>>=20
>> Acked-by: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/Kconfig      | 11 ++++++
>> mm/filemap.c    |  4 +--
>> mm/khugepaged.c | 90 ++++++++++++++++++++++++++++++++++++++++---------
>> mm/rmap.c       | 12 ++++---
>> 4 files changed, 96 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index f0c76ba47695..0a8fd589406d 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -762,6 +762,17 @@ config GUP_BENCHMARK
>>=20
>> 	  See tools/testing/selftests/vm/gup_benchmark.c
>>=20
>> +config READ_ONLY_THP_FOR_FS
>> +	bool "Read-only THP for filesystems (EXPERIMENTAL)"
>> +	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
>> +
>> +	help
>> +	  Allow khugepaged to put read-only file-backed pages in THP.
>> +
>> +	  This is marked experimental because it is a new feature. Write
>> +	  support of file THPs will be developed in the next few release
>> +	  cycles.
>> +
>> config ARCH_HAS_PTE_SPECIAL
>> 	bool
>>=20
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 5f072a113535..e79ceccdc6df 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -203,8 +203,8 @@ static void unaccount_page_cache_page(struct address=
_space *mapping,
>> 		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
>> 		if (PageTransHuge(page))
>> 			__dec_node_page_state(page, NR_SHMEM_THPS);
>> -	} else {
>> -		VM_BUG_ON_PAGE(PageTransHuge(page), page);
>> +	} else if (PageTransHuge(page)) {
>> +		__dec_node_page_state(page, NR_FILE_THPS);
>> 	}
>>=20
>> 	/*
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 158cad542627..090127e4e185 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -48,6 +48,7 @@ enum scan_result {
>> 	SCAN_CGROUP_CHARGE_FAIL,
>> 	SCAN_EXCEED_SWAP_PTE,
>> 	SCAN_TRUNCATED,
>> +	SCAN_PAGE_HAS_PRIVATE,
>> };
>>=20
>> #define CREATE_TRACE_POINTS
>> @@ -404,7 +405,11 @@ static bool hugepage_vma_check(struct vm_area_struc=
t *vma,
>> 	    (vm_flags & VM_NOHUGEPAGE) ||
>> 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> 		return false;
>> -	if (shmem_file(vma->vm_file)) {
>> +
>> +	if (shmem_file(vma->vm_file) ||
>> +	    (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> +	     vma->vm_file &&
>> +	     (vm_flags & VM_DENYWRITE))) {
>> 		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
>> 			return false;
>> 		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>> @@ -456,8 +461,9 @@ int khugepaged_enter_vma_merge(struct vm_area_struct=
 *vma,
>> 	unsigned long hstart, hend;
>>=20
>> 	/*
>> -	 * khugepaged does not yet work on non-shmem files or special
>> -	 * mappings. And file-private shmem THP is not supported.
>> +	 * khugepaged only supports read-only files for non-shmem files.
>> +	 * khugepaged does not yet work on special mappings. And
>> +	 * file-private shmem THP is not supported.
>> 	 */
>> 	if (!hugepage_vma_check(vma, vm_flags))
>> 		return 0;
>> @@ -1287,12 +1293,12 @@ static void retract_page_tables(struct address_s=
pace *mapping, pgoff_t pgoff)
>> }
>>=20
>> /**
>> - * collapse_file - collapse small tmpfs/shmem pages into huge one.
>> + * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
>>  *
>>  * Basic scheme is simple, details are more complex:
>>  *  - allocate and lock a new huge page;
>>  *  - scan page cache replacing old pages with the new one
>> - *    + swap in pages if necessary;
>> + *    + swap/gup in pages if necessary;
>>  *    + fill in gaps;
>>  *    + keep old pages around in case rollback is required;
>>  *  - if replacing succeeds:
>> @@ -1316,7 +1322,11 @@ static void collapse_file(struct mm_struct *mm,
>> 	LIST_HEAD(pagelist);
>> 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
>> 	int nr_none =3D 0, result =3D SCAN_SUCCEED;
>> +	bool is_shmem =3D shmem_file(file);
>>=20
>> +#ifndef CONFIG_READ_ONLY_THP_FOR_FS
>> +	VM_BUG_ON(!is_shmem);
>> +#endif
>=20
> 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);

Will fix.=20

>=20
>> 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>>=20
>> 	/* Only allocate from the target node */
>> @@ -1348,7 +1358,8 @@ static void collapse_file(struct mm_struct *mm,
>> 	} while (1);
>>=20
>> 	__SetPageLocked(new_page);
>> -	__SetPageSwapBacked(new_page);
>> +	if (is_shmem)
>> +		__SetPageSwapBacked(new_page);
>> 	new_page->index =3D start;
>> 	new_page->mapping =3D mapping;
>>=20
>> @@ -1363,7 +1374,7 @@ static void collapse_file(struct mm_struct *mm,
>> 		struct page *page =3D xas_next(&xas);
>>=20
>> 		VM_BUG_ON(index !=3D xas.xa_index);
>> -		if (!page) {
>> +		if (is_shmem && !page) {
>> 			/*
>> 			 * Stop if extent has been truncated or hole-punched,
>> 			 * and is now completely empty.
>> @@ -1384,7 +1395,7 @@ static void collapse_file(struct mm_struct *mm,
>> 			continue;
>> 		}
>>=20
>> -		if (xa_is_value(page) || !PageUptodate(page)) {
>> +		if (is_shmem && (xa_is_value(page) || !PageUptodate(page))) {
>> 			xas_unlock_irq(&xas);
>> 			/* swap in or instantiate fallocated page */
>> 			if (shmem_getpage(mapping->host, index, &page,
>> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *mm,
>> 				result =3D SCAN_FAIL;
>> 				goto xa_unlocked;
>> 			}
>> +		} else if (!page || xa_is_value(page)) {
>> +			xas_unlock_irq(&xas);
>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
>> +						  index, PAGE_SIZE);
>> +			lru_add_drain();
>=20
> Why?

isolate_lru_page() is likely to fail if we don't drain the pagevecs.=20

>=20
>> +			page =3D find_lock_page(mapping, index);
>> +			if (unlikely(page =3D=3D NULL)) {
>> +				result =3D SCAN_FAIL;
>> +				goto xa_unlocked;
>> +			}
>> +		} else if (!PageUptodate(page)) {
>=20
> Maybe we should try wait_on_page_locked() here before give up?

Are you referring to the "if (!PageUptodate(page))" case?=20

>=20
>> +			VM_BUG_ON(is_shmem);
>> +			result =3D SCAN_FAIL;
>> +			goto xa_locked;
>> +		} else if (!is_shmem && PageDirty(page)) {
>> +			result =3D SCAN_FAIL;
>> +			goto xa_locked;
>> 		} else if (trylock_page(page)) {
>> 			get_page(page);
>> 			xas_unlock_irq(&xas);
> --=20
> Kirill A. Shutemov

