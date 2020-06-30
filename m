Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E631F20EBEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgF3DTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 23:19:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgF3DTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:19:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05U3J1h0094294;
        Tue, 30 Jun 2020 03:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=9/SHvuJmRjFE0M7MkkWXyxwDqyzBkq8L5x2hKXhoR4k=;
 b=rbcciLB7P/1DzURAAjyWemo9hPdDoGxg0Y3ABoaaILPRl++dCDPQc1aYqPdd7hMMIEsD
 bf5ixYUGny5vn9ryMJx76iV7BkC8pqA6CJntSKCsiE/i3sKJmXYpg/aD2W9PNTaC0eVJ
 MnJh/MTV4tHrFYfjReZ6SzSOYHyCBsNOTYIMMEw/JIamTxqoYPJ3bBviVCxBDG7MaL7n
 gz7YTGaBXT0ZwdeR4r+iQixJvsZvayYBNqHdddX7rn9YEkQ8LgUIl9kvS7ahKIJb0IF1
 cU0gNa4ePzcVU23Go3WSMqbl/By3Yai1XICpgTmdQWdUtOrPaKmiejUK1MEEp8/t9cnL bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wxrn1ny0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 03:19:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05U37hww169160;
        Tue, 30 Jun 2020 03:17:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31xg1w0rs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 03:17:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05U3GxGn021311;
        Tue, 30 Jun 2020 03:16:59 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 03:16:59 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3645.0.6.2.3\))
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200629152033.16175-1-willy@infradead.org>
Date:   Mon, 29 Jun 2020 21:16:58 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <975DE645-33A3-4207-A6B7-2E304B78727E@oracle.com>
References: <20200629152033.16175-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3645.0.6.2.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300023
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Another nice cleanup.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Jun 29, 2020, at 9:20 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> Following Hugh's advice at LSFMM 2019, I was trying to avoid doing =
this,
> but it turns out to be hard to support range writeback with the =
pagecache
> using multiple single entries.  Of course, this isn't a problem for
> shmem because it doesn't have a real backing device (only swap), but
> real filesystems need to start writeback at arbitrary file offsets and
> have problems if we don't notice that the first (huge) page in the =
range
> is dirty.
>=20
> Hugh, I would love it if you could test this.  It didn't introduce any =
new
> regressions to the xfstests, but shmem does exercise different paths =
and
> of course I don't have a clean xfstests run yet, so there could easily
> still be bugs.
>=20
> I'd like this to be included in mmotm, but it is less urgent than the
> previous patch series that I've sent.  As far as risk, I think it only
> affects shmem/tmpfs.
>=20
> Matthew Wilcox (Oracle) (2):
>  XArray: Add xas_split
>  mm: Use multi-index entries in the page cache
>=20
> Documentation/core-api/xarray.rst |  16 ++--
> include/linux/xarray.h            |   2 +
> lib/test_xarray.c                 |  41 ++++++++
> lib/xarray.c                      | 153 ++++++++++++++++++++++++++++--
> mm/filemap.c                      |  42 ++++----
> mm/huge_memory.c                  |  21 +++-
> mm/khugepaged.c                   |  12 ++-
> mm/shmem.c                        |  11 +--
> 8 files changed, 245 insertions(+), 53 deletions(-)
>=20
> --=20
> 2.27.0
>=20
>=20

