Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A43354AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbhDFCFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 22:05:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhDFCFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:05:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13620WAp145949;
        Tue, 6 Apr 2021 02:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Pefr/D0FGl2miTZwVWcLJqGB3IxjhpCBuap0udEf40E=;
 b=FeG+lTZjNHaSgSoy0XiInTCpYrH9ih57LQQvM4aB//X438YCn63psCvKnO0PuOH0/pwH
 OCj5CcYHLGHifnHdX060V4zXUg8u3NCmLLZ2FGMua70ZUOMYREB+asPaJcb5BzTmL4o6
 0HipOpERunT/eoqqkh2KwKp98kkkEoSvk45zbrFxZhYtC72faHEy3nk5Ei2my3Ax5aGh
 RFNkmL/+g5spM+659cHUYKsYRnkpj2Uq15NvEWfy3X8k1vYPWyGxMYoXOL4S8VBAdEz5
 FMHjIU8t/sK+I+O03nDUwWtplI3LowgTtuMCdH7dpvUDv8z9jWlpPaHq3OtAZzMuuEPG QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37q3bwksrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 02:04:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1361xxxO092371;
        Tue, 6 Apr 2021 02:04:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 37q2pbx0bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 02:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULpvG3zN/HakQOugDO/P+XeY2tHRRPNXGPvOykCQOggaTaSuyn2atBOOA0wssYnLSOgMKSgzIqOW3BMz1e+Hy61GK+kdhMNJXg/2F49OV3WzRvsmGGS62/0ugBH26TnpBJS+SgM03MJp2544+T2vLPVlokvxuXOdUjadBkb0fclk2vryoLDGRErBkgi9Q1oPW55tP2njdbkV6DhdLCpo5eCGodfCdEZe8h2Nopa3kZfLG9hNC8NfCDSKAJYOXXmoYypkVKujgak97Z8W+06UWtwPlTeFRrdXWjVeFfvWeIgSEqZVvLw0LhJe2QbwleIQjsQHerj0x6eSP8kkZr+1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pefr/D0FGl2miTZwVWcLJqGB3IxjhpCBuap0udEf40E=;
 b=ZEIr9xM7eFX1JZ9g0MyuZg3r6pX9RkYPY1fMJ84+nEhXf7tHJ3eL3ktJgGThmdROOdcOMq2JRgCq2C2lIamBYnSZRTvGNHbpibyqTgEDij5B3nxMQSAtoaJ/b8SfaxAVYft4tKFVLilTgFZ3Z27WcIR67e9u71HVHBQnZtxfL0LGumcY+qD4sZ+So+rdWH1e574mVyaCGGZ3oYHUDp6lysZaZiIAAOW6+pAmZ775duJ/O06kPxp9AqXSzhFCmw3+gAl9zC91cBDQ4OyK2dxIvrq0JceXtcwju3DGiohRPJPKvOcQppHUJ99u9OV6JdZn8WIRlBJk2gWDbOyviRB4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pefr/D0FGl2miTZwVWcLJqGB3IxjhpCBuap0udEf40E=;
 b=ZO5EmLaUbJBgaJ+pa9WyWF3idHFcwovTg02k1hUxR56pg0pfBu/QDR/5BUOpr9ZWbRkeQsgfWKmQZzK0O+5kpYExIq2afoiiFWQ7BFIpvKXKDpE5WBI7MCNGUKcv9v9cTojI8z3EmXwfisP68HKJ9VsayN+PaOpynsEKGI0xVyI=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1896.namprd10.prod.outlook.com
 (2603:10b6:903:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 02:04:57 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3977.038; Tue, 6 Apr 2021
 02:04:57 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Collin Fijalkovich <cfijalkovich@google.com>
CC:     Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Hugh Dickins <hughd@google.com>,
        Tim Murray <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed
 THPs
Thread-Topic: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
Thread-Index: AQHXH2bOPa1UqQyVl0aDup/ffvlZfKqmtSUAgAAeiAA=
Date:   Tue, 6 Apr 2021 02:04:57 +0000
Message-ID: <7CC369CF-66F6-4362-BCA8-0C1CAE350CDF@oracle.com>
References: <20210322215823.962758-1-cfijalkovich@google.com>
 <CAL+PeoEpuOMOOL7=TTu7dKhHxO3Yb5CoTiMFeYGskx23bXkXhg@mail.gmail.com>
In-Reply-To: <CAL+PeoEpuOMOOL7=TTu7dKhHxO3Yb5CoTiMFeYGskx23bXkXhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:61fe:a02a:5420:fb73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e9bed76-88e0-4f07-3bfb-08d8f8a060d5
x-ms-traffictypediagnostic: CY4PR10MB1896:
x-microsoft-antispam-prvs: <CY4PR10MB18965E63BF0953A674F3593D81769@CY4PR10MB1896.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMNIannAMAzfUVAd4Yk2dt2M/qo/AGGE/4j9NrZv2ADgvFnHYrkdkHzk3YL3t+1HUs3f8GaoFvA+Qba1KRzM4DHz6l/UkqzxfRNRaXnBVkbbg9Z+LXl+zupomqIqkmVUHprx1nwNcUKE8Faujw2A7s0jBdzciIOd+plL4AM14fvoF77HhHb20y2uP/hRvcKzwmDSrDwLZLVrCOAkvuYWunyK3whQkfBdM6VDle74C/QUytSQkCyC25KTDzeKudUqS8e5i93qoPFbVtqr8JV3JKs0PAOuvqFUAVUoDrBIGZl7getUzfR1YVLrhaUM15V0ZendME+SzeoRIhzSl/mxGbMY8GC6t3NT805FA02Tw25ac8aY6h7iYSzYkPXfU0nu1hBVWMVIUZd5E7tzPq+t1TLAHtHZ0VqwFUsajTd21C5KSonNfQk/Wd4B2LcBNf8gl+asWDRnohG+6rBGhvSZwm6U3bFFvgBY/PinSnBVYk79OrfeLGV7m7dRLGn84Z8F0VUN9rGEPicS1PiyDeBX82ofLDEE/pyQvZQ5BfnZfnbBLQmxGtG/CJBSpp6Hu3u1sh23FLeTd8H9vW5ONmJgPHDYUZM+LGCM9naE9Oa8zNkiTE+ANrL7zpIowqOZXh8wz6lYTTxVW3mtxCUFMVJclgF1e+Y6hwnvnfyl5ykpA2wETBx0CSF6optukHgP5jZWst36JxWAjup9FXW0M83X+vyzRiLHzscwgElY1Q5xGt+WLTVA3+7sqxfoWHmjte+NeOdtw/9YcZHdxYiO4DWgTeES6V3snkf2KzVAS3pd3VA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(64756008)(66946007)(66556008)(54906003)(316002)(76116006)(66446008)(8936002)(36756003)(478600001)(7416002)(4326008)(5660300002)(6506007)(86362001)(66476007)(71200400001)(6512007)(8676002)(6486002)(2906002)(83380400001)(6916009)(44832011)(2616005)(53546011)(186003)(966005)(33656002)(38100700001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u+bRC/55iJKo4KmMlZU541pMwyxthS7UPOlg1u+JldThoXzzxjZ6ilws65RS?=
 =?us-ascii?Q?DqtQDXL3UX5qA+sx3ffKJHyeG2cMCI8b46WI0kH/HGPVulTDUSRQOZRkKHsG?=
 =?us-ascii?Q?AxL96zJDo6NFmm4/QasV0NP/TbczeT47BsVV34CDhayGrnts8n3bz3xMdR9z?=
 =?us-ascii?Q?qpaNM/eZRyw1j0wKxpsvgJ10KZ572Z7eBRSFDYMoR5Ol9M5/e7S0sGbz9g5V?=
 =?us-ascii?Q?Sj+3CqYdf31OxbfBiN3zTXDPw59j2Y+k66JPX3woMsEzHKGaaUUmTkazSHrf?=
 =?us-ascii?Q?ras2e6q+qZl1PMNOfZvQDf0D0tNXNDC1ldFDjJnVgBBOvw603q5j1ywydk9Y?=
 =?us-ascii?Q?ibMG/pWyGdQJzPT/QfqCPXFIzj7scznEak7DuZpvqz6122sobaWTQWEm5wJf?=
 =?us-ascii?Q?1JyR869+2mPZqbyyQf86Abp/JkrMEQujJNYRZi2Ima4ipYI7pWQBtCluqmej?=
 =?us-ascii?Q?C9n3bVTd9BMKAuub9tKYOGYf9FqwLvOZwxXTaokvSLOLj9pSqvQ9X+lFcTlA?=
 =?us-ascii?Q?x+8Iz6+dMqKR+VoBT6jVymUvRombctCxIxm1oryWhXDLzjNkpX7MQdW0dyyh?=
 =?us-ascii?Q?SoqETwHbpoW5KuvqQFM2UABf7dPWJDkdl+/Lg8eYfpt6rchwf+7lS4XJ2DzA?=
 =?us-ascii?Q?TOU368pQROkCU/uouJ/fdoq1NsMwcvw/g5Ryuw++7Rbn4A5d7muUtSz8AtsJ?=
 =?us-ascii?Q?9I7kYP+H04o558uOPE4uSIpV5f2UK14/10nVn34e0CAMR9/9y0zqKBB2H9DY?=
 =?us-ascii?Q?TCYciwOUbvtDjFLBIoqa3UO10UD4TOtZjTfFMokZHaj4vTrHgRQtjt4Bezgg?=
 =?us-ascii?Q?NFHN1vTXsO7a39UnmHZmF7oCZvw9OrE2MrPZ+YOvoHhgfAEmK7VKtA3viR+n?=
 =?us-ascii?Q?XfkOD1h0hQf0LdIvn36LUZlVb77yTgTw2RWdvBCEmKAbRX8kxGB5J6PCEkQp?=
 =?us-ascii?Q?IvmhnX7lqVBSb43VBS0TyDy8TtpQ3jn3y32HsbVf92YEc+dXJZEE2tvE6Eqh?=
 =?us-ascii?Q?nK8CmYPZIBcq4/n8lCyKO+ZrGrKzUOg3nbV5zp5aghbccu9dD0ltDhKwewjC?=
 =?us-ascii?Q?6kmPG0QQF5uEafpQUE6WJ3ovPuWyAUXbJsDPivJ7IW7El4TEVGfO9jMVBs0R?=
 =?us-ascii?Q?aTHKil4H2ROATxOAWFbi5MOswnSgXzBP4j+baOlho2s86QfvWQp1HoJghajg?=
 =?us-ascii?Q?9oLFx+0oycXlyZ4H+tW7kQn7CVgiZQvwkMJJijXxTITLxfi+QlSA9UstMaJu?=
 =?us-ascii?Q?RKXPQ3cKbh0RmrWzeY09IX0eH/zxIqIhq0nQoPxEVDSBMwspHIXYuet+C1v8?=
 =?us-ascii?Q?kcdq6ieYte5Fft2yB0CvS7aYJwW5r8VYu5jtaqPNWmalVUA3qWRBScnsdUtH?=
 =?us-ascii?Q?P1sUEapZT8A+nE+GJD1Syyugwx0s?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8077B905E16C214686AB5D9EA1A15C68@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9bed76-88e0-4f07-3bfb-08d8f8a060d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 02:04:57.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wc6qTvuRAoNRaPuekLZqiaf5yapbiGEipYG8jY5cv3AXo57O+ipKPWhzuN5CVl5gXunKN2A0caVfv0c+vY7Bvek4gTN/Su9wGdbpxou67YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1896
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060010
X-Proofpoint-GUID: l-lJ7Ri0qVPV6qNaUaWHq-AWr8plL8zc
X-Proofpoint-ORIG-GUID: l-lJ7Ri0qVPV6qNaUaWHq-AWr8plL8zc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060010
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I saw a similar change a few years ago with my prototype:

https://lore.kernel.org/linux-mm/5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracl=
e.com/

the key being a very nice drop in iTLB-load-misses, so it looks like your c=
ode is
having the right effect.

What about the call to filemap_nr_thps_dec() in unaccount_page_cache_page()=
 - does
that need an smp_mb() as well?

-- Bill

> On Apr 5, 2021, at 6:15 PM, Collin Fijalkovich <cfijalkovich@google.com> =
wrote:
>=20
> v2 has been uploaded with performance testing results:
> https://lore.kernel.org/patchwork/patch/1408266/
>=20
>=20
>=20
> On Mon, Mar 22, 2021 at 2:59 PM Collin Fijalkovich
> <cfijalkovich@google.com> wrote:
>>=20
>> Transparent huge pages are supported for read-only non-shmem filesystems=
,
>> but are only used for vmas with VM_DENYWRITE. This condition ensures tha=
t
>> file THPs are protected from writes while an application is running
>> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
>> when a file is opened for write in do_dentry_open(). Since sys_mmap
>> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
>> produced by execve().
>>=20
>> Systems that make heavy use of shared libraries (e.g. Android) are unabl=
e
>> to apply VM_DENYWRITE through the dynamic linker, preventing them from
>> benefiting from the resultant reduced contention on the TLB.
>>=20
>> This patch reduces the constraint on file THPs allowing use with any
>> executable mapping from a file not opened for write (see
>> inode_is_open_for_write()). It also introduces additional conditions to
>> ensure that files opened for write will never be backed by file THPs.
>>=20
>> Restricting the use of THPs to executable mappings eliminates the risk t=
hat
>> a read-only file later opened for write would encounter significant
>> latencies due to page cache truncation.
>>=20
>> The ld linker flag '-z max-page-size=3D(hugepage size)' can be used to
>> produce executables with the necessary layout. The dynamic linker must
>> map these file's segments at a hugepage size aligned vma for the mapping=
 to
>> be backed with THPs.
>>=20
>> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
>> ---
>> fs/open.c       | 13 +++++++++++--
>> mm/khugepaged.c | 16 +++++++++++++++-
>> 2 files changed, 26 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/open.c b/fs/open.c
>> index e53af13b5835..f76e960d10ea 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
>>         * XXX: Huge page cache doesn't support writing yet. Drop all pag=
e
>>         * cache for this file before processing writes.
>>         */
>> -       if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mappin=
g))
>> -               truncate_pagecache(inode, 0);
>> +       if (f->f_mode & FMODE_WRITE) {
>> +               /*
>> +                * Paired with smp_mb() in collapse_file() to ensure nr_=
thps
>> +                * is up to date and the update to i_writecount by
>> +                * get_write_access() is visible. Ensures subsequent ins=
ertion
>> +                * of THPs into the page cache will fail.
>> +                */
>> +               smp_mb();
>> +               if (filemap_nr_thps(inode->i_mapping))
>> +                       truncate_pagecache(inode, 0);
>> +       }
>>=20
>>        return 0;
>>=20
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index a7d6cb912b05..4c7cc877d5e3 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct=
 *vma,
>>=20
>>        /* Read-only file mappings need to be aligned for THP to work. */
>>        if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>> -           (vm_flags & VM_DENYWRITE)) {
>> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
>> +           (vm_flags & VM_EXEC)) {
>>                return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm=
_pgoff,
>>                                HPAGE_PMD_NR);
>>        }
>> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
>>        else {
>>                __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
>>                filemap_nr_thps_inc(mapping);
>> +               /*
>> +                * Paired with smp_mb() in do_dentry_open() to ensure
>> +                * i_writecount is up to date and the update to nr_thps =
is
>> +                * visible. Ensures the page cache will be truncated if =
the
>> +                * file is opened writable.
>> +                */
>> +               smp_mb();
>> +               if (inode_is_open_for_write(mapping->host)) {
>> +                       result =3D SCAN_FAIL;
>> +                       __mod_lruvec_page_state(new_page, NR_FILE_THPS, =
-nr);
>> +                       filemap_nr_thps_dec(mapping);
>> +                       goto xa_locked;
>> +               }
>>        }
>>=20
>>        if (nr_none) {
>> --
>> 2.31.0.rc2.261.g7f71774620-goog
>>=20
>=20

