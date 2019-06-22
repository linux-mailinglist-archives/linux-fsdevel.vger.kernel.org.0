Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192644F3BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 06:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFVEtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 00:49:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfFVEtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 00:49:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5M4dhdk002638;
        Fri, 21 Jun 2019 21:48:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ge55FUa7qfaj4R5csk5DvO4vnJxSG45JSpxaqoQOo1o=;
 b=Ahuczc3YMlaD7KIyAWJOcA10zwJBwrJQc16cDLb52TWXjIvCEGNuhF7RcDpTBMPE5eej
 lJ9x69Z3BCwwCYMo4BLRX+rUzWzCbqWjLgXcbXcjerjKaLapBaxeGhuveWFUjLOk5R62
 TZkQN26EFyLQwSkMumtlEIcwigdibALHc40= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9d3er2eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 21:48:41 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 21:48:40 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 21:48:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge55FUa7qfaj4R5csk5DvO4vnJxSG45JSpxaqoQOo1o=;
 b=MLNpD0rZgmzdxlqnaMRyhk/OW5c6NDpNm+Vit2jhcvoGO1HHQa3O1qIlL4gKk7jeDq11N2sr07GIsNAa3RrgwrkacAvgYm6fEF6W/4soKmBXhbawybfhnGE3Th3pck+VjONyTm/EOkIB9Fy2S9lQntKMQBcCTEExmSLj+nnRmP0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1471.namprd15.prod.outlook.com (10.173.233.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Sat, 22 Jun 2019 04:48:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Sat, 22 Jun 2019
 04:48:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 4/6] khugepaged: rename collapse_shmem() and
 khugepaged_scan_shmem()
Thread-Topic: [PATCH v6 4/6] khugepaged: rename collapse_shmem() and
 khugepaged_scan_shmem()
Thread-Index: AQHVKKhH0iJY1YD8bkGfCTvF/8doEqanGiIA
Date:   Sat, 22 Jun 2019 04:48:25 +0000
Message-ID: <55244DE8-D7BD-4DBB-A518-45CA746DE4FE@fb.com>
References: <20190622031151.3316-1-hdanton@sina.com>
In-Reply-To: <20190622031151.3316-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:e75a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19273941-80fe-416e-04be-08d6f6ccdc82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1471;
x-ms-traffictypediagnostic: MWHPR15MB1471:
x-microsoft-antispam-prvs: <MWHPR15MB1471817921291D172FA05DD7B3E60@MWHPR15MB1471.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(14454004)(81166006)(81156014)(6512007)(99286004)(76116006)(64756008)(102836004)(8676002)(66476007)(66446008)(66556008)(66946007)(73956011)(54906003)(316002)(71200400001)(71190400001)(5660300002)(68736007)(256004)(14444005)(8936002)(25786009)(86362001)(4326008)(186003)(33656002)(229853002)(57306001)(7736002)(53546011)(36756003)(478600001)(6116002)(2616005)(6506007)(6246003)(305945005)(50226002)(6486002)(6436002)(486006)(76176011)(6916009)(46003)(2906002)(476003)(11346002)(53936002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1471;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Ky2ztEtEzuGvqNpculwpX8J9tTFv/8GssQEI+4G+zFbT/9rNk39rUkl3R6X/zaT0g026qFpTe26pbC863QN3Nm2Ies+buc0h2Oegr4p2DZxeIZuix9XN5T6uNsDaTi4fLQc/SlznCNBbrTBd6OCeZa11lYPi6OAQEer0y2Y0ISJ5leKAjnvYIZtV7SCNqkfeaqicIRzlemyPCJN4DHgmOiF+m0J5uAkAEkkafLfZbOYPQUMrhhDEIqZMPbTIMHgADuhbhqrlo/LIn3NfZih4eNCpAe6PFpxysrQUrrEi+Xjg+jr9kmMYNZ79uEl5AwDNQQi38ZHBwFsJN7IAligXItzWw1U7YGD44tKRCVIx67EkbAsfKRqQFWPtU/Gv3Ob5biI/YeigUED2CrI/BsCEh4B5DrycRJuoZpuQXJpZHo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0A1412AD7F79E4083FAF55DF07CF8C8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19273941-80fe-416e-04be-08d6f6ccdc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 04:48:25.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1471
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906220042
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 21, 2019, at 8:11 PM, Hillf Danton <hdanton@sina.com> wrote:
>=20
>=20
> Hello
>=20
> On Fri, 21 Jun 2019 17:05:10 -0700 Song Liu <songliubraving@fb.com> wrote=
:
>> Next patch will add khugepaged support of non-shmem files. This patch
>> renames these two functions to reflect the new functionality:
>>=20
>>    collapse_shmem()        =3D>  collapse_file()
>>    khugepaged_scan_shmem() =3D>  khugepaged_scan_file()
>>=20
>> Acked-by: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/khugepaged.c | 13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 0f7419938008..dde8e45552b3 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1287,7 +1287,7 @@ static void retract_page_tables(struct address_spa=
ce *mapping, pgoff_t pgoff)
>> }
>>=20
>> /**
>> - * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
>> + * collapse_file - collapse small tmpfs/shmem pages into huge one.
>>  *
>>  * Basic scheme is simple, details are more complex:
>>  *  - allocate and lock a new huge page;
>> @@ -1304,10 +1304,11 @@ static void retract_page_tables(struct address_s=
pace *mapping, pgoff_t pgoff)
>>  *    + restore gaps in the page cache;
>>  *    + unlock and free huge page;
>>  */
>> -static void collapse_shmem(struct mm_struct *mm,
>> +static void collapse_file(struct vm_area_struct *vma,
>> 		struct address_space *mapping, pgoff_t start,
>> 		struct page **hpage, int node)
>> {
>> +	struct mm_struct *mm =3D vma->vm_mm;
>> 	gfp_t gfp;
>> 	struct page *new_page;
>> 	struct mem_cgroup *memcg;
>> @@ -1563,7 +1564,7 @@ static void collapse_shmem(struct mm_struct *mm,
>> 	/* TODO: tracepoints */
>> }
>>=20
>> -static void khugepaged_scan_shmem(struct mm_struct *mm,
>> +static void khugepaged_scan_file(struct vm_area_struct *vma,
>> 		struct address_space *mapping,
>> 		pgoff_t start, struct page **hpage)
>> {
>> @@ -1631,14 +1632,14 @@ static void khugepaged_scan_shmem(struct mm_stru=
ct *mm,
>> 			result =3D SCAN_EXCEED_NONE_PTE;
>> 		} else {
>> 			node =3D khugepaged_find_target_node();
>> -			collapse_shmem(mm, mapping, start, hpage, node);
>> +			collapse_file(vma, mapping, start, hpage, node);
>> 		}
>> 	}
>>=20
>> 	/* TODO: tracepoints */
>> }
>> #else
>> -static void khugepaged_scan_shmem(struct mm_struct *mm,
>> +static void khugepaged_scan_file(struct vm_area_struct *vma,
>> 		struct address_space *mapping,
>> 		pgoff_t start, struct page **hpage)
>> {
>> @@ -1722,7 +1723,7 @@ static unsigned int khugepaged_scan_mm_slot(unsign=
ed int pages,
>> 				file =3D get_file(vma->vm_file);
>> 				up_read(&mm->mmap_sem);
>> 				ret =3D 1;
>> -				khugepaged_scan_shmem(mm, file->f_mapping,
>> +				khugepaged_scan_file(vma, file->f_mapping,
>> 						pgoff, hpage);
>> 				fput(file);
>=20
> Is it a change that should have put some material in the log message?
> Is it unlikely for vma to go without mmap_sem held?

This is a great point. We really need to be more careful. Let me fix=20
it in the next version.=20

Thanks,
Song

