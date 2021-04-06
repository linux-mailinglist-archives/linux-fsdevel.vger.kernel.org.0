Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7151D355EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhDFW1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 18:27:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36398 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDFW1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:27:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136MKBqG170607;
        Tue, 6 Apr 2021 22:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eh6KIcdMVnKMFVb9DmGGHrVmeJva3yCXUcrUQuiUD7U=;
 b=NvDGPuIA2pKfTujWEZAYJ0OOQ+X70li+TPlpABeeJjMRImYDgdjb4lzjQy90NVyY6EVF
 CMFm9JKDY5G52hvXLHyux2DpJTDJKcDtW2YYPRhIgRL9Wxt7BlzbopkxLttw/AFQ7Ti4
 lrBTbdjGU3YcvP+dTArA2AuQUO9Zvpsmhw9WF1L5itbAQs1iOvaciOg7vAszGmQv/qI0
 AOFY9H1NLwnmoAZd+Snp2X0Jao1Eu2mLTOWaotpFzJCRfkAN9cl23iGyBpprnQq9azM1
 gmTohPEHhZgFpIZMOXBbr6sVtp7rNh9DJw/Otfvzzxfmll9ltTqbjMb9nDFNFdEnYT9Z 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37rvaw0p5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 22:26:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136MP328025463;
        Tue, 6 Apr 2021 22:26:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 37rvaxsbxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 22:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZKtjJpgx2NsdUXbgqf/7R4YWILY2VwPkggHjMJk7WG6vFKJ1kx2JjaBgOHTLRzXCXU365i/4ITUKWwVLitu3tgLPgFjBsFXj88U84hKBCqc7SIhyW8MvOv/KonIj9IRqaWzxYWk9eD/KSPgVhnCmdik3bQU3BQsDHcL+LpKweQvU9+mrMOQcG7DYSBk26y29Cwa4yHY53yS2xM9jTF16HxCCG9jT8A/bHgAb6bNDsCR65nBWnqJegkMOPpLo/MNPuuK4lzpLKBIBNnUEDnJ3v+KUJLJSxyUayoE5nNeECdhMNXK2qo+AGCaAV6hnGfYiIAlGTLUtwrS5pQRPddM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh6KIcdMVnKMFVb9DmGGHrVmeJva3yCXUcrUQuiUD7U=;
 b=XIJnAQj1tZI6CJ54WkGSulL2Hn1quf3rDtHdxEALTnlIDUyC2ncJkgpJW65cGHvIVvnQ1yVPMdYKbuRuDTiw2m7drbXxIbvIb5xEUK8flvfqawi21eQ7zfy8fAQ4KhHqLW8m49ESCJYZ6W4o49ueDhULx8NFyEE6kuDvmFSmG9H5pQuZS09pivIYZNMmy3aguchftlVvWJis4DJYjPDKYp6BRATRAClymDVcqnITZTOi0nRDN8fTm5Db/z+W8YORMQ4MFb+Mlxp8wVDdCo/LfwBSl8wGzUwdN7WXKE7xtx6cNjdzQzjiDP0FBbWumvq7dN1SxnZvI9n74KMwMar7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh6KIcdMVnKMFVb9DmGGHrVmeJva3yCXUcrUQuiUD7U=;
 b=Odq6Y0P2pACbVPNoPqj+FafNGi+i18vJtovIm03M4KQcDmEfxjh/22cHIsY8NunpTJj8BBuQ1AQyagcGPtIMJZU5PU+M5MjWZS7nzFC2i+4w1GGP0REL7L8fErQ6/R1HrKLMwPiOj8CJM+fJpThgZU/iPskXahzM/tNqaJYjiIo=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR1001MB2198.namprd10.prod.outlook.com
 (2603:10b6:910:42::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 22:26:52 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3977.038; Tue, 6 Apr 2021
 22:26:51 +0000
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
Thread-Index: AQHXH2bOPa1UqQyVl0aDup/ffvlZfKqmtSUAgAAeiACAAQeTAIAATdOA
Date:   Tue, 6 Apr 2021 22:26:51 +0000
Message-ID: <BC8F69FF-AA56-4CDC-96E9-DB2AEEEBC4C5@oracle.com>
References: <20210322215823.962758-1-cfijalkovich@google.com>
 <CAL+PeoEpuOMOOL7=TTu7dKhHxO3Yb5CoTiMFeYGskx23bXkXhg@mail.gmail.com>
 <7CC369CF-66F6-4362-BCA8-0C1CAE350CDF@oracle.com>
 <CAL+PeoHrnVT5rFWxhShLPxQU_dgOqK24FCdcJ2s18596sS8jqw@mail.gmail.com>
In-Reply-To: <CAL+PeoHrnVT5rFWxhShLPxQU_dgOqK24FCdcJ2s18596sS8jqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:dcc7:3a69:b5ad:c0a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdf12c44-5ee5-4499-9a80-08d8f94b139c
x-ms-traffictypediagnostic: CY4PR1001MB2198:
x-microsoft-antispam-prvs: <CY4PR1001MB21987220E215617A077B660881769@CY4PR1001MB2198.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53Ro0HjbBQGL1XJxMpYyMoHA8UTmB5JZpAttxk4Rl9yDsNU02FYR2T5IoGkISzM9bxoZMqFdVRhSdqMlU6mgXbSMarGRK9aVVEMykzXOK3n+JSTCzec4s7UPtwLrCAsZh7qLzQ6AnFFSXxqDsOTSVX9PtR5sx95aETIhz7eVA/1wtv4LxdbhqzGU37XGwr/+E+6MOlga2A5ZKHOC2J3gL2dwXLUlF0ANQMXMcaA4oPFGLZQL45UmrXR+uuyTRHE1w12vmWYZsfKxB6j1sbSAP8s4PbHiowjcki2nc4sNDQnShuEBB2GpnfGQVilialSwg4KA06sFXqVzF1Q2HaqfmXL3pDMZDaRNSN4FKYZntKCbcG2wPRSyg3NJphae1hVAwEkDrKmBv/3Lz+30+tQprEL/sysXA3BaByiF80h4qGLfp8X/QF8Zp6qOuSJffkDxTaYkv3HqsHoaSGjer2gjMXY/kSmmfaj3E+p4ssTcKxcKigoIql/24jCYS6YhcXQdmolWmxyV56h0bk6WPb5zjCwiT3H1w2h1+L+1AWKPOAI5GCyAaQ9gZ3jCjkxR4XFT8goykB5zkxQXqogcfcGluWNKYbVzUSEqHyFrCZg/qjTLqVlrvniPqsNTj/HyETLzdA+97DCFH7+pdESTJLPVhtLYykGh1vW+VFIKG1OqFJuObkmspSwlQ3de8tCKd9pWtiEHDpE/DxBBHXPu4wm0OHqgj9duOQAoWDS/s2ajrGoUUQs59Pw8jmIxlahXbqFs6AXLdugGHXE/dt/ekjnaui4muuKK5Xhh5SkZMx2OO1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(38100700001)(6486002)(2906002)(5660300002)(76116006)(66446008)(66476007)(83380400001)(4326008)(44832011)(6916009)(6512007)(8676002)(33656002)(8936002)(186003)(86362001)(36756003)(2616005)(7416002)(71200400001)(53546011)(478600001)(6506007)(316002)(66556008)(64756008)(66946007)(54906003)(966005)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tHqWfeUxfGX58zbeMoiAOi+YS6gOrWdRr8+OvYThxLxQDrG8ebfhGJTxubff?=
 =?us-ascii?Q?MbEwkDTeaJxmvLlkzFAtuq6682vcjP75++4VBUh9tnSiv9mojhatOO3ndakW?=
 =?us-ascii?Q?8TKkUwNS5p4srK0zFpGpJdFnvWF4GwGr5xlRqYOR8njvD+VyM0o1WGWa3Cyk?=
 =?us-ascii?Q?/5XloHrGhU1l2vm6tOcaD4Zi1iomSGIqyooujT9q5ZC61+6eWqUCVf5A7q+A?=
 =?us-ascii?Q?u8+0Af11GZl8Ohbyi0aAX04sGTcAcddoEKSw6xJzQM6iCmCGxTqQwsYmlDRw?=
 =?us-ascii?Q?cvtB9Z9O5VRXfTrq8/wjudfr3VSNMLWhobwylOqNdaWL9pi9aUg4+3DXe6Ir?=
 =?us-ascii?Q?Ne8982dMUXl0nd9OCrTZPxZ+qmkBuyrz+F9YyXxIScEoaPsyPKdwYLllJLmO?=
 =?us-ascii?Q?JE/GmVuVNtdZzxzghCA52k63s+1iKWbzMIibNRLU5ehSVK/afmKJo+ydlAdy?=
 =?us-ascii?Q?txGkNf/UjPMQBQTG27wcPP/5v2AhMuYrv3cb7k/JyNUBjx8klwO+0bOWFgKg?=
 =?us-ascii?Q?rHayubAPpCJ0Aze49b0VC5KfIRNETmBqpJVUwj/vIhlGbg5zalvkG0lVSExB?=
 =?us-ascii?Q?VMvX1S1rraUvbL4UCk7mPUdw6TNfgEXd1nSLggq9jam9Bkk5bviHymJGZRAm?=
 =?us-ascii?Q?K2712dHlzFnNFyBvgUpb3aCRCkUN1eVJVvEFAPqMGpJicFTAr70fOYcBg0np?=
 =?us-ascii?Q?0mcC7JzjBhljXG4NmruJj8Jc0rHGJ54xd1wUgAqdLgU7MVLy/vkciF8ylMv6?=
 =?us-ascii?Q?4nVK1CQUmdnFwUbbBiGKY/8LG5XogaVUWOpV1QxnHf8DBd9tXplib4kNwpQa?=
 =?us-ascii?Q?54P3aiL/K8G4kSduRHO2iEoWxyw+Af8+1lJq3W4qKHwu/Vnk87k7Kbwlx+51?=
 =?us-ascii?Q?/64b7kktTnMBvuUABz25l510zGr8nUgDV56jbKSOY2nIVHYXfHlsBVlPSqL3?=
 =?us-ascii?Q?O3WHjcKVTH5aW+WHbD+sxM9QGdYLu0YeazGELa+7/1MDmJBciLQrhgnZrazq?=
 =?us-ascii?Q?syU7zLUC5XeJJiPstYKvqqjYLKL8S1Eld6CAVszh92z2zI2q3XGBLtLDhcvU?=
 =?us-ascii?Q?KP22AOr2dzAYFZen8zl+CXx+rZclMm6fj0lI7ianZyS9ULEowbnw0Cxqhbm7?=
 =?us-ascii?Q?lW76HApDW0yQZ3H6Xz9TgNb1aggjVKpr0MN4GCTUy1LPNXZLP/6xAMJ1CYiY?=
 =?us-ascii?Q?JGK2W3StCn89GRaBkkR5d50Aq7veK/plXEjdsIcQ5/PLuYQXb8xLFtFIV63C?=
 =?us-ascii?Q?X8aNfgCS6IFoZTE5gSxY1KDBBP1a6cr3ksOI0UXrZM/PGCqMJabLPc2FwUrX?=
 =?us-ascii?Q?R0d0kOYYEDKPUDZXnb47HWBYd75kJQM2u0ZZo3p7OiBd7iAjwusU7Q4Kf6sq?=
 =?us-ascii?Q?mqXauDdMQsh3bpBVMqXfRaLOgxlp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <837666B295645644BCC04DCC8DB589FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf12c44-5ee5-4499-9a80-08d8f94b139c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 22:26:51.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ih3L31TckDLKuJVUdvorDTtbzTssStbZ57Z9F1xfAFUQ3sZ+5oFCDktQikff6ZfO27KuUnp9VNkNJXrENh2aw34ZTtNMlVc4IrbhAFfPfzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2198
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060151
X-Proofpoint-ORIG-GUID: WJv445eV-bcSd5hTMWQB-3n01dHmMhEe
X-Proofpoint-GUID: WJv445eV-bcSd5hTMWQB-3n01dHmMhEe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sounds good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Apr 6, 2021, at 11:48 AM, Collin Fijalkovich <cfijalkovich@google.com>=
 wrote:
>=20
> Instrumenting filemap_nr_thps_inc() should be sufficient for ensuring
> writable file mappings will not be THP-backed.
>=20
> If filemap_nr_thps_dec() in unaccount_page_cache_page() and
> filemap_nr_thps() in do_dentry_open() race, the worst case is an
> unnecessary truncation. We could introduce a memory barrier in
> unaccount_page_cache_page(), but I'm unsure it would significantly
> mitigate the risk of spurious truncations. Barring synchronization
> between do_dentry_open() and ongoing page cache operations, there
> could be an in-progress delete_from_page_cache_batch() that has not
> yet updated accounting for THPs in its targeted range.
>=20
> -- Collin
>=20
> On Mon, Apr 5, 2021 at 7:05 PM William Kucharski
> <william.kucharski@oracle.com> wrote:
>>=20
>>=20
>> I saw a similar change a few years ago with my prototype:
>>=20
>> https://lore.kernel.org/linux-mm/5BB682E1-DD52-4AA9-83E9-DEF091E0C709@or=
acle.com/
>>=20
>> the key being a very nice drop in iTLB-load-misses, so it looks like you=
r code is
>> having the right effect.
>>=20
>> What about the call to filemap_nr_thps_dec() in unaccount_page_cache_pag=
e() - does
>> that need an smp_mb() as well?
>>=20
>> -- Bill
>>=20
>>> On Apr 5, 2021, at 6:15 PM, Collin Fijalkovich <cfijalkovich@google.com=
> wrote:
>>>=20
>>> v2 has been uploaded with performance testing results:
>>> https://lore.kernel.org/patchwork/patch/1408266/
>>>=20
>>>=20
>>>=20
>>> On Mon, Mar 22, 2021 at 2:59 PM Collin Fijalkovich
>>> <cfijalkovich@google.com> wrote:
>>>>=20
>>>> Transparent huge pages are supported for read-only non-shmem filesyste=
ms,
>>>> but are only used for vmas with VM_DENYWRITE. This condition ensures t=
hat
>>>> file THPs are protected from writes while an application is running
>>>> (ETXTBSY).  Any existing file THPs are then dropped from the page cach=
e
>>>> when a file is opened for write in do_dentry_open(). Since sys_mmap
>>>> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
>>>> produced by execve().
>>>>=20
>>>> Systems that make heavy use of shared libraries (e.g. Android) are una=
ble
>>>> to apply VM_DENYWRITE through the dynamic linker, preventing them from
>>>> benefiting from the resultant reduced contention on the TLB.
>>>>=20
>>>> This patch reduces the constraint on file THPs allowing use with any
>>>> executable mapping from a file not opened for write (see
>>>> inode_is_open_for_write()). It also introduces additional conditions t=
o
>>>> ensure that files opened for write will never be backed by file THPs.
>>>>=20
>>>> Restricting the use of THPs to executable mappings eliminates the risk=
 that
>>>> a read-only file later opened for write would encounter significant
>>>> latencies due to page cache truncation.
>>>>=20
>>>> The ld linker flag '-z max-page-size=3D(hugepage size)' can be used to
>>>> produce executables with the necessary layout. The dynamic linker must
>>>> map these file's segments at a hugepage size aligned vma for the mappi=
ng to
>>>> be backed with THPs.
>>>>=20
>>>> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
>>>> ---
>>>> fs/open.c       | 13 +++++++++++--
>>>> mm/khugepaged.c | 16 +++++++++++++++-
>>>> 2 files changed, 26 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/fs/open.c b/fs/open.c
>>>> index e53af13b5835..f76e960d10ea 100644
>>>> --- a/fs/open.c
>>>> +++ b/fs/open.c
>>>> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
>>>>        * XXX: Huge page cache doesn't support writing yet. Drop all pa=
ge
>>>>        * cache for this file before processing writes.
>>>>        */
>>>> -       if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapp=
ing))
>>>> -               truncate_pagecache(inode, 0);
>>>> +       if (f->f_mode & FMODE_WRITE) {
>>>> +               /*
>>>> +                * Paired with smp_mb() in collapse_file() to ensure n=
r_thps
>>>> +                * is up to date and the update to i_writecount by
>>>> +                * get_write_access() is visible. Ensures subsequent i=
nsertion
>>>> +                * of THPs into the page cache will fail.
>>>> +                */
>>>> +               smp_mb();
>>>> +               if (filemap_nr_thps(inode->i_mapping))
>>>> +                       truncate_pagecache(inode, 0);
>>>> +       }
>>>>=20
>>>>       return 0;
>>>>=20
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index a7d6cb912b05..4c7cc877d5e3 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_stru=
ct *vma,
>>>>=20
>>>>       /* Read-only file mappings need to be aligned for THP to work. *=
/
>>>>       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>>>> -           (vm_flags & VM_DENYWRITE)) {
>>>> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
>>>> +           (vm_flags & VM_EXEC)) {
>>>>               return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->v=
m_pgoff,
>>>>                               HPAGE_PMD_NR);
>>>>       }
>>>> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
>>>>       else {
>>>>               __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
>>>>               filemap_nr_thps_inc(mapping);
>>>> +               /*
>>>> +                * Paired with smp_mb() in do_dentry_open() to ensure
>>>> +                * i_writecount is up to date and the update to nr_thp=
s is
>>>> +                * visible. Ensures the page cache will be truncated i=
f the
>>>> +                * file is opened writable.
>>>> +                */
>>>> +               smp_mb();
>>>> +               if (inode_is_open_for_write(mapping->host)) {
>>>> +                       result =3D SCAN_FAIL;
>>>> +                       __mod_lruvec_page_state(new_page, NR_FILE_THPS=
, -nr);
>>>> +                       filemap_nr_thps_dec(mapping);
>>>> +                       goto xa_locked;
>>>> +               }
>>>>       }
>>>>=20
>>>>       if (nr_none) {
>>>> --
>>>> 2.31.0.rc2.261.g7f71774620-goog
>>>>=20
>>>=20
>>=20

