Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D652516A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgHYK3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 06:29:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36924 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgHYK3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:29:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PAPOJx078060;
        Tue, 25 Aug 2020 10:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=eYOBrGq+oIN0aCgQgUHudJMPRgvhB81SD1iHx4MSQQ4=;
 b=J/arBTGQW/QHlSBjkq9YtT0uCotUCrSo7RyLr1Q5UjfA9XzjxXOZb8ukdTTio6bcVass
 F3/3JySMpw5/8eMSsiFWLI1x3hRZVPXe0YEgfU/d6ktOONu3xGvUFLBhRVX9Mg3ENs3U
 vN4iUEiI6CJGYMlOhD8BZAtPNXgmWIqVt8W0eHK43l1IY/yAo9vSC0i8XiLVVl+JmgKL
 VpiFpuLOApElDLdSp9WpO5MX46CorU6Ch2bqgGrZNtNOTMV9aapa7v//m47uNJlkmq3S
 1A9BQpju++mbT5eoSXgVb8tdhfbgzf55KzEhDwVFzdkvJwJhJnmnKNMvWvq7ZH40FTGJ EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333csj1qf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 10:29:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PAPHQB176374;
        Tue, 25 Aug 2020 10:29:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 333r9jcmjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 10:29:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PATHMO005180;
        Tue, 25 Aug 2020 10:29:17 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 03:29:17 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3\))
Subject: Re: [PATCH 00/11] iomap/fs/block patches for 5.11
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
Date:   Tue, 25 Aug 2020 04:29:16 -0600
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E04AE83-85F0-4C90-924C-9A6792D453DE@oracle.com>
References: <20200824151700.16097-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Really nice improvements here.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Aug 24, 2020, at 9:16 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> As promised earlier [1], here are the patches which I would like to
> merge into 5.11 to support THPs.  They depend on that earlier series.
> If there's anything in here that you'd like to see pulled out and =
added
> to that earlier series, let me know.
>=20
> There are a couple of pieces in here which aren't exactly part of
> iomap, but I think make sense to take through the iomap tree.
>=20
> [1] =
https://lore.kernel.org/linux-fsdevel/20200824145511.10500-1-willy@infrade=
ad.org/
>=20
> Matthew Wilcox (Oracle) (11):
>  fs: Make page_mkwrite_check_truncate thp-aware
>  mm: Support THPs in zero_user_segments
>  mm: Zero the head page, not the tail page
>  block: Add bio_for_each_thp_segment_all
>  iomap: Support THPs in iomap_adjust_read_range
>  iomap: Support THPs in invalidatepage
>  iomap: Support THPs in read paths
>  iomap: Change iomap_write_begin calling convention
>  iomap: Support THPs in write paths
>  iomap: Inline data shouldn't see THPs
>  iomap: Handle tail pages in iomap_page_mkwrite
>=20
> fs/iomap/buffered-io.c  | 178 ++++++++++++++++++++++++----------------
> include/linux/bio.h     |  13 +++
> include/linux/bvec.h    |  27 ++++++
> include/linux/highmem.h |  15 +++-
> include/linux/pagemap.h |  10 +--
> mm/highmem.c            |  62 +++++++++++++-
> mm/shmem.c              |   7 ++
> mm/truncate.c           |   7 ++
> 8 files changed, 236 insertions(+), 83 deletions(-)
>=20
> --=20
> 2.28.0
>=20
>=20

