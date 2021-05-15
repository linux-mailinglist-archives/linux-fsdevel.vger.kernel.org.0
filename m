Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC33817A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhEOK2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 06:28:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41542 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhEOK2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 06:28:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAO2uV087236;
        Sat, 15 May 2021 10:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QSkrnblB8Zp2R7owUOsaMHflYUVdBhoJupQtiM/X1yk=;
 b=aB04aaFHJT9gSv6YDDy7EvbZQf6MLtHm+h7rbof1DgcDU2DSw9tgS1FMDyWVaS9loBwG
 NgYBiFHMUHHTZ1/zQ4OuEQE3Q7407L2X5Z8fXKJd80CseiDwSCuXO1L0h4du+KiJbTlK
 I280US0IqGb9ti+bw+jW8tUZds3V610y1cTYk1d8tOLzS9zqhn+NGzrRGj1SorbELBw2
 eq5yauDv7is5OIJ1ywDe5sB5YOZwKX7QUVkk8uwk9gNYrdgWs5oyvJVaw4XQU3GytBsU
 662R+RCVofivPtsP9MBoazv7o1/sIQXWEm/XoiH2eMoIM6dn+QRqdMr6GYjgCjBuo12+ cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38j3tb8e4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:26:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAOtqr022191;
        Sat, 15 May 2021 10:26:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 38j641gtnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiCzH42R89xGXHU2UpoTwPtOxtiVWByd1Llg+Qx8vAEDk/rRiyqnMugdhOJIv+mb0Ro4HIKXojYA5cTBDyO8k3NHkHsATTgZ5et018ftCgz5gxLPe7PNMHmGyECO6yS/Hw37XwGlRvXKF2r4tjMv4InBDRPVPJJPJRTo19YQB9zaaZXwhjcBKfMh9bIiXVtoOUUc7S14xSRRWyli/8BBxUO/Z4sk4/JvIofLu6BZdprKvzvB23J4fHVn0nUcdkKHM/s9Ql7L8DSh4JZdJ3jSt6/PaNh4kj8baIrfLF41jk5L/li50scEmi2J4InfvEGkubhn+gTKrzWRXsFMPDB0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSkrnblB8Zp2R7owUOsaMHflYUVdBhoJupQtiM/X1yk=;
 b=QOKu0nBScx8bnzLe31fojsHf5kC8oDyZVGz1OFuDUF+HAHcBCdlwjCxYStdse5Q/mrB0a1RbiUs82LV5qlYtnIOrHqtHhv2cZj5LaA3oIEf0MYHf9cD9UhnMfyXeho9Dz5clS3HOLH5Cz038Y+9KGcAdaO0zcrLR44S7uS8ZmeCcwkC7kt3/t+Vk4Do3RxGdR4acA3/4PdL1M/7snivAFs38tTZJu5dNpZd0WO9NzmkqtvqM2hw0ZdqdDZC/BskhC1O5lT8ISP6YYpsXjrXvlcgRsL2F8ojuQ7FJCorKzQ5LxStfx6DhZq8dkbuCWIAl/dkDPbOmlnNW4qNITqFS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSkrnblB8Zp2R7owUOsaMHflYUVdBhoJupQtiM/X1yk=;
 b=d9Pkj+CAHdFBSq4rgA85jcBGoIHLZDjCOq+jtFj+kEOIpTPAcMk2SxVcEOyWS1W//Kdp/Vp/LACZukC8nQ/mHvBbg6kZcjR78xUfi8DVRNzpVY8JSzCL2nU3AS6xYr+DX956rNYaQpJVUeA/FaK83nSkororwtDvLLNaSNUBmko=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1975.namprd10.prod.outlook.com
 (2603:10b6:903:124::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sat, 15 May
 2021 10:26:30 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581%7]) with mapi id 15.20.4129.028; Sat, 15 May 2021
 10:26:30 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/33] Memory folios
Thread-Topic: [PATCH v10 00/33] Memory folios
Thread-Index: AQHXRq9jswEPtfPw80CEn1XLLho2uKrkXCmA
Date:   Sat, 15 May 2021 10:26:29 +0000
Message-ID: <26A8948B-00BC-49F1-A0B7-CE6310FA7A71@oracle.com>
References: <20210511214735.1836149-1-willy@infradead.org>
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:3d23:2196:422a:2535]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3081ff2-2957-469a-9583-08d9178be76d
x-ms-traffictypediagnostic: CY4PR10MB1975:
x-microsoft-antispam-prvs: <CY4PR10MB1975F3E23C34BAA58DDB292F812F9@CY4PR10MB1975.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GRw4YFRb6RKJ9xi0MTcJxIVZZK/GM/xnNTZlJzeXAYJHFvECv4TYXHYcTR4dVMpj4FiwQsgAVMvlAt/LHe9e/ugb9fq1QAQ9WGevIk7+QbJw6jUzR4R8GWxqD1TZT4uFsNQArGL9PC6SywAY5c06ktis4ZW8Hq6BlWS0J09BYwr38JfdCkr7mmkvNtrag9yxpF124gD0FIG3vVCCJ4OkheJLorYXnKquj3kBwMoZiF6tSm+5QjPnkgx7cX4rb3K6DkDQow0iTptpSeWcKmBKM5qWme+sIq0/JSE7Zx1UfUZfvMeJbAIq+3lyybXHHISbldRZ+G3NIS8CCIndezHyKTveRVKDM5aro6Qq3CEGC4zyi4P/GlcVv3/CUu63wDojG3GnIIw0ZmeK/0Onv/zikTTfEwqzIuGsQ3PXyC8j/5SAofoMkZgb2wjhGQN/GMfs4kra7Lustc44jSkNa17HPAFPjuQmrEvYQMIHN33H7OfqvNKHKaknuDUrr71iOaaQofYf+PTXsaABuFtUCIwl2zt+HT/Cn2/VE9l/ky0cmIurxTJjA//mEzr379qXhNFndPgm2zGBJxpVP/8GoeIser722FnQ94N1GqjNSCxIfjfbLOWlhdICow7QCUusZ2OvC8fC7yNRN1DDdK4IYVYjW8uAwBMscdN+5hDvH6TB99Gaul190DQH3ZIkNigUHpY2S9ZMuOGOmWG/zhhv0vpQzTOLu/F5Ug9d4GWAfh3kZ+5GghnBp/ZRsyNevZGQcgRk/P2M2FR7iYWdY1BzXQp4lWkMoch3tdN0xcyxS4VRn1k6Sb/aA9P9eAoFiSIU652e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(8676002)(6512007)(186003)(44832011)(316002)(2616005)(66556008)(122000001)(66446008)(66476007)(64756008)(76116006)(36756003)(66946007)(966005)(6486002)(5660300002)(478600001)(38100700002)(33656002)(71200400001)(86362001)(2906002)(6506007)(53546011)(6916009)(83380400001)(4326008)(8936002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1pG6ov9hKx7Qc2f+V+ImSIo0nQUnMf0nirQm9EmthmAnQT3ZC2gbCI2wL+ld?=
 =?us-ascii?Q?z1JNeg/iffh7M0sDNJ6g1f1qxI4+FKx0dis5btGQOaMgpVWa+l04qkQNM6AN?=
 =?us-ascii?Q?yMm9Bn9U5GkQJPHcEa/K+UeonG5N8DhNFQ5P4d819apcyc8nGT9egMzDoNRh?=
 =?us-ascii?Q?mhw/3cVns+BI+O4ZWwUH08LNEJDO4tKWwPAhPa28X4EJbAD7wS+e6wk61QAH?=
 =?us-ascii?Q?34zuSS1uPfiNnHBG5HYEnH5BXfgNmRaceXa4NE7sRJ30O9+dJSlmdh0DTzI5?=
 =?us-ascii?Q?/bLWwlRRwQcSpKAsth9ysHBsLCSN+PTGL3/TMiO60hoUCKE1JL8+IAOKAPbG?=
 =?us-ascii?Q?W/4PT6GpZ8ToNahTE57v4YohXt87qC3fn+wGIPFuTqJmI0gN6mw4LuJxU6K3?=
 =?us-ascii?Q?nt1PJwhrYs0Wc2/abVrMUFmrko/Ix8bZG6ncSDRpQSbVkp9NODkPiQNjeuDJ?=
 =?us-ascii?Q?QIkXT4kdibXVqjYDTvphEyYMaSzp7puKEQTUc0i1keSwdNZEbRP082orVQZF?=
 =?us-ascii?Q?rTHgi0HUt0WGlPtXcr1BZD3TML857jvEmAw5lCIB3Gk03e5gf5/vf33+ErTv?=
 =?us-ascii?Q?6SSNeQ3uNqSQYv8bfZUh40ZFjxM33XXER5v6kO50WQzdJ/RxBbqn8vnyiSbq?=
 =?us-ascii?Q?uBrN5OcmfBnVy+BEtE23ObOtiH4+AbAakcPjcU41KMgteqlC01Sp1YiPsSdj?=
 =?us-ascii?Q?vE7SXTInKrWnwoY1TVqINuFHbOmdVxSknApJ4rt4KG5m7iUtV/EZJhtN+tUY?=
 =?us-ascii?Q?3gtY7Wjm901uTT3w0a7LzDfz64ZNRc3hJ+EOzKR5kIWi1eTng1oynkCJhs8l?=
 =?us-ascii?Q?Qva9Ody905jxzJF6zoGMuNNSz90mQYqqC0ohni0Vf4C3jEzx1/uX+xIbIFud?=
 =?us-ascii?Q?jl1JQxMs8BY+PIwBUznFjqDE1eBf2pOCTcTPU8ZUPluVle7kn1r3PTIGJc8l?=
 =?us-ascii?Q?xDTdqbxcV4zlRD4qEBY7V35/Mg47PSY92hwZ/pJjlO5I0cFKP6B06e9O+xdp?=
 =?us-ascii?Q?Fov5vctkfZLdh2AmKbD5ZXPpcnonhE5ww/dbmpUigL3VMNYG3qZl8yMGRmN0?=
 =?us-ascii?Q?DaO8lLqQ5PeNOnJRSScYGzThlvRyO0+lKLTfgDctbOO63QQT+pceIIH2Xv4m?=
 =?us-ascii?Q?eWhxrHxrBvaF618IrFzp0o5AFqoSFFTIMGUCKISYAvjeyWsCvPWgLSdA6f3W?=
 =?us-ascii?Q?W+WqX0eC9AnTthFjYtwxfjo7+wGdiNWCVKOZtGDkjgaDu0NtLdL4nmcBILif?=
 =?us-ascii?Q?aZkVITGfZnYBFVwtD/V2CcJ+EEqnrRDEw/nQPPX/6dN8tFDJFsXJTWq3loA3?=
 =?us-ascii?Q?qY4+4RAfdDoTW13yy1brAMMU/pAcwrhOs7VHw7ba4kkYgXwRXALgrpPm409+?=
 =?us-ascii?Q?wx5SKXJcBgDbYEPahKbWfw8yWRt3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <585260EC2198C641BED1A659B50808E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3081ff2-2957-469a-9583-08d9178be76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2021 10:26:29.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYq4jbC3OEdciAjUMTTAI3kXatXU7tNaNh2NT6sxzXoFoGsh7FQqKDRNe5NMqWWryA1RaInq+8t+eKbYFAg8Fdc4k+r3TuIbqaZhLKUHxRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1975
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105150073
X-Proofpoint-ORIG-GUID: lANRIqM2-J7w-UVJ5Fb1ksLNYrhcp2zU
X-Proofpoint-GUID: lANRIqM2-J7w-UVJ5Fb1ksLNYrhcp2zU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105150073
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a nit on part 01/33, but will respond directly there.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On May 11, 2021, at 3:47 PM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> benefit from a larger "page size".  As an example, an earlier iteration
> of this idea which used compound pages (and wasn't particularly tuned)
> got a 7% performance boost when compiling the kernel.
>=20
> Using compound pages or THPs exposes a weakness of our type system.
> Functions are often unprepared for compound pages to be passed to them,
> and may only act on PAGE_SIZE chunks.  Even functions which are aware of
> compound pages may expect a head page, and do the wrong thing if passed
> a tail page.
>=20
> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more hidden
> calls to compound_head().  This also happens for get_page(), put_page()
> and many more functions.  There does not appear to be a way to tell gcc
> that it can cache the result of compound_head(), nor is there a way to
> tell it that compound_head() is idempotent.
>=20
> This patch series uses a new type, the struct folio, to manage memory.
> It provides some basic infrastructure that's worthwhile in its own right,
> shrinking the kernel by about 5kB of text.
>=20
> Since v9:
> - Rebase onto mmotm 2021-05-10-21-46
> - Add folio_memcg() definition for !MEMCG (intel lkp)
> - Change folio->private from an unsigned long to a void *
> - Use folio_page() to implement folio_file_page()
> - Add folio_try_get() and folio_try_get_rcu()
> - Trim back down to just the first few patches, which are better-reviewed=
.
> v9: https://lore.kernel.org/linux-mm/20210505150628.111735-1-willy@infrad=
ead.org/
> v8: https://lore.kernel.org/linux-mm/20210430180740.2707166-1-willy@infra=
dead.org/
>=20
> Matthew Wilcox (Oracle) (33):
>  mm: Introduce struct folio
>  mm: Add folio_pgdat and folio_zone
>  mm/vmstat: Add functions to account folio statistics
>  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
>  mm: Add folio reference count functions
>  mm: Add folio_put
>  mm: Add folio_get
>  mm: Add folio_try_get_rcu
>  mm: Add folio flag manipulation functions
>  mm: Add folio_young and folio_idle
>  mm: Handle per-folio private data
>  mm/filemap: Add folio_index, folio_file_page and folio_contains
>  mm/filemap: Add folio_next_index
>  mm/filemap: Add folio_offset and folio_file_offset
>  mm/util: Add folio_mapping and folio_file_mapping
>  mm: Add folio_mapcount
>  mm/memcg: Add folio wrappers for various functions
>  mm/filemap: Add folio_unlock
>  mm/filemap: Add folio_lock
>  mm/filemap: Add folio_lock_killable
>  mm/filemap: Add __folio_lock_async
>  mm/filemap: Add __folio_lock_or_retry
>  mm/filemap: Add folio_wait_locked
>  mm/swap: Add folio_rotate_reclaimable
>  mm/filemap: Add folio_end_writeback
>  mm/writeback: Add folio_wait_writeback
>  mm/writeback: Add folio_wait_stable
>  mm/filemap: Add folio_wait_bit
>  mm/filemap: Add folio_wake_bit
>  mm/filemap: Convert page wait queues to be folios
>  mm/filemap: Add folio private_2 functions
>  fs/netfs: Add folio fscache functions
>  mm: Add folio_mapped
>=20
> Documentation/core-api/mm-api.rst           |   4 +
> Documentation/filesystems/netfs_library.rst |   2 +
> fs/afs/write.c                              |   9 +-
> fs/cachefiles/rdwr.c                        |  16 +-
> fs/io_uring.c                               |   2 +-
> include/linux/memcontrol.h                  |  63 ++++
> include/linux/mm.h                          | 174 ++++++++--
> include/linux/mm_types.h                    |  71 ++++
> include/linux/mmdebug.h                     |  20 ++
> include/linux/netfs.h                       |  77 +++--
> include/linux/page-flags.h                  | 230 ++++++++++---
> include/linux/page_idle.h                   |  99 +++---
> include/linux/page_ref.h                    | 158 ++++++++-
> include/linux/pagemap.h                     | 358 ++++++++++++--------
> include/linux/swap.h                        |   7 +-
> include/linux/vmstat.h                      | 107 ++++++
> mm/Makefile                                 |   2 +-
> mm/filemap.c                                | 315 ++++++++---------
> mm/folio-compat.c                           |  43 +++
> mm/internal.h                               |   1 +
> mm/memory.c                                 |   8 +-
> mm/page-writeback.c                         |  72 ++--
> mm/page_io.c                                |   4 +-
> mm/swap.c                                   |  18 +-
> mm/swapfile.c                               |   8 +-
> mm/util.c                                   |  59 ++--
> 26 files changed, 1374 insertions(+), 553 deletions(-)
> create mode 100644 mm/folio-compat.c
>=20
> --=20
> 2.30.2
>=20
>=20

