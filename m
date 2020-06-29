Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21E20D8FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbgF2TnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:43:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbgF2TnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:43:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TGvINi195048;
        Mon, 29 Jun 2020 17:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=b/NHNW9cL/f8WvCDejlTmfEoDbhtKb5zkYQElFuXlNE=;
 b=yYsGWHSSiZtSHUmKTIrZLkN+ltgQwpHjQSEHkCfa5oiJ1ZwBGthb0KEn4P0uEInffgkK
 iikidg1zED8lyZWtNWCTSSuGEWhhRTtLfh0f/KqgJfDpoKx5z2iFQy5g533pipJ6wDYN
 WOXzsjJ0nggCOvgR9A97aR6oMfDqvsVWRBxrb8HlUiJNx4cXTw2FSGDOuQ0G22P8ZYcZ
 dIJ+A/Z6t2YkI7KFuaOoIp6TSEkWc0wTCxj9xqtfNPQfrSiVxCpsoJVQgwv9oqCzo4RX
 Hm4kaiGQl4JGmx1PDgVgyxfLY0b4HKSqtwiX/9nRIB6K/tmXYoIyhxwC1/YXL+mTupHc uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31wwhrfs59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 17:13:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TGwdfw145766;
        Mon, 29 Jun 2020 17:11:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31xg10vcqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 17:11:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05THBIqW023706;
        Mon, 29 Jun 2020 17:11:18 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 17:11:18 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3645.0.6.2.3\))
Subject: Re: [PATCH 0/7] THP prep patches
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
Date:   Mon, 29 Jun 2020 11:11:17 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB1195A5-85C6-43DE-9CD6-927C3A83E9BA@oracle.com>
References: <20200629151959.15779-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3645.0.6.2.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=897 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=894 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Very nice cleanup and improvement in readability.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>


> On Jun 29, 2020, at 9:19 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> These are some generic cleanups and improvements, which I would like
> merged into mmotm soon.  The first one should be a performance =
improvement
> for all users of compound pages, and the others are aimed at getting
> code to compile away when CONFIG_TRANSPARENT_HUGEPAGE is disabled (ie
> small systems).  Also better documented / less confusing than the =
current
> prefix mixture of compound, hpage and thp.
>=20
> Matthew Wilcox (Oracle) (7):
>  mm: Store compound_nr as well as compound_order
>  mm: Move page-flags include to top of file
>  mm: Add thp_order
>  mm: Add thp_size
>  mm: Replace hpage_nr_pages with thp_nr_pages
>  mm: Add thp_head
>  mm: Introduce offset_in_thp
>=20
> drivers/nvdimm/btt.c      |  4 +--
> drivers/nvdimm/pmem.c     |  6 ++--
> include/linux/huge_mm.h   | 58 ++++++++++++++++++++++++++++++++++++---
> include/linux/mm.h        | 12 ++++----
> include/linux/mm_inline.h |  6 ++--
> include/linux/mm_types.h  |  1 +
> include/linux/pagemap.h   |  6 ++--
> mm/compaction.c           |  2 +-
> mm/filemap.c              |  2 +-
> mm/gup.c                  |  2 +-
> mm/hugetlb.c              |  2 +-
> mm/internal.h             |  4 +--
> mm/memcontrol.c           | 10 +++----
> mm/memory_hotplug.c       |  7 ++---
> mm/mempolicy.c            |  2 +-
> mm/migrate.c              | 16 +++++------
> mm/mlock.c                |  9 +++---
> mm/page_alloc.c           |  5 ++--
> mm/page_io.c              |  4 +--
> mm/page_vma_mapped.c      |  6 ++--
> mm/rmap.c                 |  8 +++---
> mm/swap.c                 | 16 +++++------
> mm/swap_state.c           |  6 ++--
> mm/swapfile.c             |  2 +-
> mm/vmscan.c               |  6 ++--
> mm/workingset.c           |  6 ++--
> 26 files changed, 127 insertions(+), 81 deletions(-)
>=20
> --=20
> 2.27.0
>=20
>=20

