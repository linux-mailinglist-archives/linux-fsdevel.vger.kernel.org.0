Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709D6359EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhDIMgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 08:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIMgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617971747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQb7qzHISTbizitMiYm8wD/fZ+45DgKONa+egqhiCY0=;
        b=U7OQrel0DTaGAJPLlRV3kCq1+Jwy7BykGjXltX3kBBviGmYauir8QpiAPv8dmrtsBA/AA9
        sUjRLCdlryI+5YA6qzNQL4JQinyACFlKKzit8CK1MKN4OGrt/9aCrwRnq385SkhELttLKm
        dV2va1WkUgf+WsOVUptPZfHabxk4TLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-1VuZXlZMP_qGLOcyqDfQHg-1; Fri, 09 Apr 2021 08:35:43 -0400
X-MC-Unique: 1VuZXlZMP_qGLOcyqDfQHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC5B019251A1;
        Fri,  9 Apr 2021 12:35:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65E55DAA5;
        Fri,  9 Apr 2021 12:35:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210409111636.GR2531743@casper.infradead.org>
References: <20210409111636.GR2531743@casper.infradead.org> <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com> <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jlayton@kernel.org, hch@lst.de,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: Return bool from pagebit test functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <625170.1617971734.1@warthog.procyon.org.uk>
Date:   Fri, 09 Apr 2021 13:35:34 +0100
Message-ID: <625171.1617971734@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> iirc i looked at doing this as part of the folio work, and it ended up
> increasing the size of the kernel.  Did you run bloat-o-meter on the
> result of doing this?

add/remove: 2/2 grow/shrink: 15/16 up/down: 408/-599 (-191)
Function                                     old     new   delta
iomap_write_end_inline                         -     128    +128
try_to_free_swap                              59     179    +120
page_to_index.part                             -      36     +36
page_size                                    432     456     +24
PageTransCompound                            154     175     +21
truncate_inode_pages_range                   791     807     +16
invalidate_inode_pages2_range                504     518     +14
ceph_uninline_data                           969     982     +13
iomap_read_inline_data.isra                  129     139     +10
page_cache_pipe_buf_confirm                   85      93      +8
ceph_writepages_start                       3237    3243      +6
hpage_pincount_available                      94      97      +3
__collapse_huge_page_isolate                 768     771      +3
page_vma_mapped_walk                        1070    1072      +2
PageHuge                                      39      41      +2
collapse_file                               2046    2047      +1
__free_pages_ok                              449     450      +1
wait_on_page_bit_common                      598     597      -1
iomap_page_release                           104     103      -1
change_pte_range                             818     817      -1
pageblock_skip_persistent                     45      42      -3
is_transparent_hugepage                       63      60      -3
nfs_readpage                                 486     482      -4
ext4_readpage_inline                         155     151      -4
release_pages                                640     635      -5
ext4_write_inline_data_end                   286     281      -5
ext4_mb_load_buddy_gfp                       690     684      -6
afs_dir_check                                536     529      -7
page_trans_huge_map_swapcount                374     363     -11
io_uring_mmap                                199     184     -15
io_buffer_account_pin                        276     259     -17
page_to_index                                 50       -     -50
iomap_write_end                              375     306     -69
try_to_free_swap.part                        137       -    -137
PageUptodate                                 716     456    -260
Total: Before=17207139, After=17206948, chg -0.00%

