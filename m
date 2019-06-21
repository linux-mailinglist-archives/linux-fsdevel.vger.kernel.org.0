Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF14E8A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFUNLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 09:11:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbfFUNLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:11:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5LD7TtU008392;
        Fri, 21 Jun 2019 06:10:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3mNH8d2ax+z7OFnWeODsqy6613ZIbW9/cA8R41b6d3k=;
 b=m+UEaORhTnmiTIBHiQLRdZwebhEqvU9hnHWa55oOK7JmHe/dEn8KWTFO8ZCwCMS4i1gJ
 +DHpI79SHtlYgpwOFUkuThW9IocOCkQ6K9yPPOZBVZwodKK7x28BklgYeKO11lTCOntK
 JpdMQOkl+KUOXjkmCblZyukpXqywMuGzTpg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2t8v6wgr1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jun 2019 06:10:56 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Jun 2019 06:10:56 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Jun 2019 06:10:55 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 06:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mNH8d2ax+z7OFnWeODsqy6613ZIbW9/cA8R41b6d3k=;
 b=VNo6uaHBJtTWV65SrpBeb5dr2s4SVMOh97ULL6zF+oDxG072COUcFvETuhYf0A1X81z2DHC5XK4wLIUKU0zuaS+M1Tv7e156u2VEtjX7RadRQuE+NGRBwkSeBUOhAsZeaQ47d8ZQZq6I+RXpKNoaPdy6CJq/r5/XWy3uijFd/o8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1263.namprd15.prod.outlook.com (10.175.2.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 13:10:54 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Fri, 21 Jun 2019
 13:10:54 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in pagecache
Thread-Topic: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in
 pagecache
Thread-Index: AQHVJ6piUxjnrZaN9U27pEvDQgjQg6amFUcAgAAA5oA=
Date:   Fri, 21 Jun 2019 13:10:54 +0000
Message-ID: <ABE906A7-719A-4AFF-8683-B413397C9865@fb.com>
References: <20190620205348.3980213-1-songliubraving@fb.com>
 <20190620205348.3980213-7-songliubraving@fb.com>
 <20190621130740.ehobvjjj7gjiazjw@box>
In-Reply-To: <20190621130740.ehobvjjj7gjiazjw@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:ed23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98af95fc-39f7-44d5-212a-08d6f649e46e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1263;
x-ms-traffictypediagnostic: MWHPR15MB1263:
x-microsoft-antispam-prvs: <MWHPR15MB1263530D843C7EFE3EF39EA1B3E70@MWHPR15MB1263.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(71200400001)(33656002)(53546011)(6512007)(11346002)(478600001)(229853002)(54906003)(36756003)(6506007)(6436002)(446003)(486006)(46003)(50226002)(186003)(8936002)(6916009)(66476007)(476003)(53936002)(68736007)(316002)(25786009)(4326008)(102836004)(8676002)(81156014)(66946007)(81166006)(76116006)(6246003)(57306001)(76176011)(14454004)(5660300002)(66556008)(6486002)(2616005)(64756008)(71190400001)(99286004)(6116002)(86362001)(256004)(305945005)(7736002)(66446008)(73956011)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1263;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RLTVzRCAsYpYpYgoiLO+ozzalgkFlp5XFOqNysLSpXP3xaM/9m52drPWsg1LPH+3okLGula5vW5wuyWcKBoeGeSgBOuG2gL6aM+iiX3fG1QZLoUu5PAoOPFoRHGeJOOtb9ZYSIFG8F8qzT5BPGdZszlDTw8T+ZyymuMEMU/fYCpu731O9iFFhaC/cktX0oFQ9ctGHhWKQ8E0kgjIlXkM/w6Y/2OJFGqQ9W8qj/Ueel5W6T1Sj0TnqGvoqUfzEVslWpqV3Js5LZecPKeUrNnQP8hyXhiG0xgRIvWf7wUzZkdaeiIXA4T+TonPD3bjrIgkuRjRStFSZ1nAFP0/dZr4/901H4yPF29dwldXtvDEcwNP4go7i2762aW6wa+sUlZiLPd2lgwD242YuUtl1k3I3O/ZNee0b5AOrlBH+wjZGqs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8692315AB159FC40ACBC2F9949F95E6C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af95fc-39f7-44d5-212a-08d6f649e46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:10:54.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=795 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210109
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 21, 2019, at 6:07 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Thu, Jun 20, 2019 at 01:53:48PM -0700, Song Liu wrote:
>> In previous patch, an application could put part of its text section in
>> THP via madvise(). These THPs will be protected from writes when the
>> application is still running (TXTBSY). However, after the application
>> exits, the file is available for writes.
>>=20
>> This patch avoids writes to file THP by dropping page cache for the file
>> when the file is open for write. A new counter nr_thps is added to struc=
t
>> address_space. In do_last(), if the file is open for write and nr_thps
>> is non-zero, we drop page cache for the whole file.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> fs/inode.c         |  3 +++
>> fs/namei.c         | 22 +++++++++++++++++++++-
>> include/linux/fs.h | 31 +++++++++++++++++++++++++++++++
>> mm/filemap.c       |  1 +
>> mm/khugepaged.c    |  4 +++-
>> 5 files changed, 59 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/inode.c b/fs/inode.c
>> index df6542ec3b88..518113a4e219 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct=
 inode *inode)
>> 	mapping->flags =3D 0;
>> 	mapping->wb_err =3D 0;
>> 	atomic_set(&mapping->i_mmap_writable, 0);
>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>> +	atomic_set(&mapping->nr_thps, 0);
>> +#endif
>> 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>> 	mapping->private_data =3D NULL;
>> 	mapping->writeback_index =3D 0;
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 20831c2fbb34..de64f24b58e9 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3249,6 +3249,22 @@ static int lookup_open(struct nameidata *nd, stru=
ct path *path,
>> 	return error;
>> }
>>=20
>> +/*
>> + * The file is open for write, so it is not mmapped with VM_DENYWRITE. =
If
>> + * it still has THP in page cache, drop the whole file from pagecache
>> + * before processing writes. This helps us avoid handling write back of
>> + * THP for now.
>> + */
>> +static inline void release_file_thp(struct file *file)
>> +{
>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>> +	struct inode *inode =3D file_inode(file);
>> +
>> +	if (inode_is_open_for_write(inode) && filemap_nr_thps(inode->i_mapping=
))
>> +		truncate_pagecache(inode, 0);
>> +#endif
>> +}
>> +
>> /*
>>  * Handle the last step of open()
>>  */
>> @@ -3418,7 +3434,11 @@ static int do_last(struct nameidata *nd,
>> 		goto out;
>> opened:
>> 	error =3D ima_file_check(file, op->acc_mode);
>> -	if (!error && will_truncate)
>> +	if (error)
>> +		goto out;
>> +
>> +	release_file_thp(file);
>=20
> What protects against re-fill the file with THP in parallel?

khugepaged would only process vma with VM_DENYWRITE. So once the
file is open for write (i_write_count > 0), khugepage will not=20
collapse the pages.=20

Thanks,
Song


