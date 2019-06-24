Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29FC500BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfFXE2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 00:28:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfFXE2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:28:33 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O4MUB0010133;
        Sun, 23 Jun 2019 21:27:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XuTjufMvw1F3LPzFlw9eNFH3K9AJjMcbnTPS75xB6GE=;
 b=TLG0EvqLadctEf3wQ1gcbGiwKgnt1GAGZKOIpnat2IbQuTi8Qw6TJWDmnbWXfacm7nRQ
 UFDywD2TCrH8KrowxuRGSODlmkHrv1SGnoV99x8BHzoJUHpicHE4Ob+xmdOiAPeerKG9
 jSUCZdsJbLKnbtHC8H4gba+LLyHbeaBzjr4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9he9mrd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 23 Jun 2019 21:27:43 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 23 Jun 2019 21:27:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 23 Jun 2019 21:27:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuTjufMvw1F3LPzFlw9eNFH3K9AJjMcbnTPS75xB6GE=;
 b=B6yi5Vl3DUKwpCdutqT7m6zMQPeMRwyAWdC14fh7GRh4P5dCZ4VFjYx7plw5cTsHxbXJzuyVkEO7sGCChYl2xZi1RdoILX5mB+BIE8SAjDv4qy2kAZ5jK1oatB1LeEEev7Ha8OaPvJ3dBvMp0BT4KfAHMIzc4kCni3tX81jtQis=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 04:27:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 04:27:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKjs2dBa2nM4KLk66F9b20QIHQqaqNccA
Date:   Mon, 24 Jun 2019 04:27:24 +0000
Message-ID: <3959BFED-F105-4CDC-8490-B48337812276@fb.com>
References: <20190624031604.7764-1-hdanton@sina.com>
In-Reply-To: <20190624031604.7764-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:2524]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f412b9e-6367-44e4-7336-08d6f85c4225
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-microsoft-antispam-prvs: <MWHPR15MB12780CE6476F80A4233D7CE6B3E00@MWHPR15MB1278.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(446003)(66946007)(46003)(11346002)(99286004)(73956011)(66446008)(66556008)(64756008)(25786009)(6246003)(6486002)(66476007)(5660300002)(71200400001)(71190400001)(486006)(57306001)(6436002)(86362001)(229853002)(476003)(6512007)(53936002)(4326008)(6116002)(68736007)(6916009)(76176011)(81166006)(8936002)(50226002)(6506007)(81156014)(53546011)(102836004)(2616005)(76116006)(2906002)(8676002)(305945005)(7736002)(316002)(36756003)(33656002)(186003)(256004)(14454004)(54906003)(478600001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fh8FU9fBWXQPfCRS0fNoGHNF67Y+mYRaB7q0GheRnNGJXWIzQxvL3rtZ3zwbEt9DrjKel0OA4PDbjcCSXMY4gYYXzr7/aEzanRERh4UcwSyS4j4OVi9dogaSXCcZUzbBlD+SfbiVEiVgFJ6I3+tIfhEduCQVr656ug2cnivHWlNgSNYUTXF26PMYQ87RvZ4OOoElYby4EiYv52YynLX2qLExI2aEY1i9Nlp4F89ZzpHOzOb/124acPnOjBG47QvExoHbv7mSDlNMdyLNSknhT3oFheydwSr0nLxF+1hl5V8iJB9c+CosZpNEqwMcz7BJPxCbhJzYBHoyV9XJx61l4iyIkvK80ZXm0Ch61p0al7dI7y853j09gMUArTmJGuktl2m4i3FlRqjp5oQ1HH/8QW1OW+cJC2RJ4y9duzMOjlI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B635E38414FB2D44A9FA87A5C78512A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f412b9e-6367-44e4-7336-08d6f85c4225
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 04:27:24.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240036
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hillf,

> On Jun 23, 2019, at 8:16 PM, Hillf Danton <hdanton@sina.com> wrote:
>=20
>=20
> Hello
>=20
> On Sun, 23 Jun 2019 13:48:47 +0800 Song Liu wrote:
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
> The ext4 mentioned in the cover letter, along with the subject line of
> this patch, suggests the scissoring of SHMEM.

We reuse khugepaged code for SHMEM, so the dependency does exist.=20

Thanks,
Song

