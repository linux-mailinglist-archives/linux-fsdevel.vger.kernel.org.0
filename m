Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3A6F334E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEAQBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjEAQBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:01:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D54E43
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:00:58 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230501160056euoutp028019869d6ae0fcdd3f0d0497535b28d4~bEFgIhxR70496604966euoutp02q
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 16:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230501160056euoutp028019869d6ae0fcdd3f0d0497535b28d4~bEFgIhxR70496604966euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682956856;
        bh=5bPsp2g0VrYtWLji3rbRewaAYsdPIfyZMtsPhsv1sbI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=tTmKA/fekwc01cr/2d+EY/ip/WsHT2VkebkpLF/wmjaXpP6VDG7AoZcIvEpdwmcVl
         nLB7Yc6yol6Rp/hwvPo6Q0o1CkN0fBQxHZMQVEKRsF0TeXJnLxIhUvR+Fbi2juXpRj
         KEELYea7KK1YllEWzdM6c3+dWNJc7WmwPxdcnC6g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230501160054eucas1p2215c8b65b65a2b6e83d32e9760f172f7~bEFe6oP7k1454814548eucas1p2I;
        Mon,  1 May 2023 16:00:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.98.42423.632EF446; Mon,  1
        May 2023 17:00:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230501160054eucas1p13f970393e34ba354e9cc0f8d4d730873~bEFehod0e1104711047eucas1p1l;
        Mon,  1 May 2023 16:00:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230501160054eusmtrp26dd77538775ce6d394c1cc85cf621753~bEFefz-OM1544915449eusmtrp2I;
        Mon,  1 May 2023 16:00:54 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-07-644fe236b3c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.CB.14344.632EF446; Mon,  1
        May 2023 17:00:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230501160054eusmtip26faf98cd3d8de1b1aebc0c3abf9fa111~bEFeTEYl01679116791eusmtip2z;
        Mon,  1 May 2023 16:00:54 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 1 May 2023 17:00:52 +0100
Message-ID: <6dcf69ee-21cd-ae06-c250-e991652989ac@samsung.com>
Date:   Mon, 1 May 2023 18:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH 17/17] fs: add CONFIG_BUFFER_HEAD
To:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Daniel Gomez <da.gomez@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <linux-xfs@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZE/ew1VpU/a1gqQP@casper.infradead.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87pmj/xTDC49VLOYs34Nm8Xqu/1s
        Fh9uTmKyOLn6MZvFu6bfLBaXn/BZrFx9lMli7y1ti5nz7rBZXFrkbrFn70mg1K45bBb31vxn
        tbhw4DSrxa4/O9gtbkx4ymjxbPdGZovfP+awOQh5bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeL
        x+4Fn5k8dt9sYPN4v+8qm8eKaReZPD5vkgvgiuKySUnNySxLLdK3S+DK+NP4gbVgrUxFx7PM
        BsYnIl2MHBwSAiYSP++qdTFycQgJrGCUOPF7GiuE84VRYuOyuSwQzmdGib72PWxdjJxgHS1d
        7VBVyxklJnz9yQhXNefQTKjMDkaJQ8sfsoK08ArYSfz42gXWziKgInHwRycbRFxQ4uTMJywg
        tqhAtMTifVPAbGEBU4k/V9+B2SICARLTp10Fm8MscIhF4shDEQhbXOLWk/lMIE+wCWhJNHay
        g4Q5ga6bfHc7VLm8xPa3c5ghrlaUmHTzPSuEXStxasstJpA7JQTecUp8+NjHBJFwkXh8/Ao7
        hC0s8er4FihbRuL/zvlQNdUST2/8ZoZobmGU6N+5ng0SktYSfWdyQExmAU2J9bv0IaKOEjNv
        aUGYfBI33gpCXMYnMWnbdOYJjKqzkMJhFpK/ZiF5YBbCzAWMLKsYxVNLi3PTU4sN81LL9YoT
        c4tL89L1kvNzNzECk+Lpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrwfCv1ShHhTEiurUovy44tK
        c1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTCxBBq6+35Q+rtS8cXhS/IaXyJL
        nHa9ef/Y4LRFnO7UIy8MnMUvN2xhfcQjKK8Y8OHA/uQnR3daz672PZk2T1HqvdKZNa91mUL0
        z6u8WPGpax/LlYZ1F9QFn1Q0rWNkP/LtqtWjPbUKh1zU31jzaS+dxjHlntL/KvPkpwWxe7b/
        09f6d8qsP3HSjKf5h3Ry1u2Vbl1v+Kdg/WoWiY1h+aXNBl9bPk3269KSOlNYnctbsipZav6c
        NGXmxTx76gvZHt8r+Vha+efe6anKFhmKZx9Epf1PW6V3puP6bkaP5EPR8y/y6NmsUCk5asWy
        surS7WlMpqdFTJQMhMqWrlsZu/PkxJ6QPqGnUat9ha++vBuuxFKckWioxVxUnAgA/vdctfkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xe7pmj/xTDP7f4LaYs34Nm8Xqu/1s
        Fh9uTmKyOLn6MZvFu6bfLBaXn/BZrFx9lMli7y1ti5nz7rBZXFrkbrFn70mg1K45bBb31vxn
        tbhw4DSrxa4/O9gtbkx4ymjxbPdGZovfP+awOQh5bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeL
        x+4Fn5k8dt9sYPN4v+8qm8eKaReZPD5vkgvgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+NP4gbVgrUxFx7PMBsYnIl2MnBwSAiYSLV3trF2M
        XBxCAksZJd6tPsEOkZCR2PjlKiuELSzx51oXG0TRR0aJ7vuvWSCcHYwS83oXgFXxCthJ/PgK
        UsXJwSKgInHwRycbRFxQ4uTMJywgtqhAtMSN5d+YQGxhAVOJP1ffAcU5OEQE/CRmvQoGCTML
        HGKR2HAxHGL+NSaJ/4cns0EkxCVuPZnPBFLPJqAl0dgJdign0AeT725nhSjRlGjd/psdwpaX
        2P52DjPEA4oSk26+h3qmVuLz32eMExhFZyG5bhaSDbOQjJqFZNQCRpZVjCKppcW56bnFRnrF
        ibnFpXnpesn5uZsYgQll27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeD4V+KUK8KYmVValF+fFF
        pTmpxYcYTYFBNJFZSjQ5H5jS8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg
        +pg4OKUamNSLL+lJ5BoHKriueHfcQ0FA2uBak/bkST+uPgraEPbsRvKOcIVrd7p89aNvLU+T
        1MsOqN0aYHZxq8zqBQaTJ29+ZaT1ZULD5jiGy+/36q2e/dKNb+s2u8U/DkeFtS0zmab/Zsfx
        0Jn55Q3B7lG8N8sEGVLuCC07wWV7+cKCF9fT/k1Kn7dKNXxKBQOn0TH5sPNlffFP94beuzfh
        3e+enZztGzweJMydWjFB/LL78zSZ/8emzlgo0JBzVrVk/SamzOrLLltPvIw9vUrg3MvtQUHe
        vafzv4ewKy+6Oy/fNkHbOLk4xqM+R3BzQ+tHm8BPwi9nzlfmr+6+2vvAdNXusg49qZ6HH2b/
        Ub02a+dnl3YlluKMREMt5qLiRAAR06BPsQMAAA==
X-CMS-MailID: 20230501160054eucas1p13f970393e34ba354e9cc0f8d4d730873
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230501154622eucas1p2d9dea99a75a8b2ccc347fc6e8ca7decb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230501154622eucas1p2d9dea99a75a8b2ccc347fc6e8ca7decb
References: <20230424054926.26927-1-hch@lst.de>
        <20230424054926.26927-18-hch@lst.de>
        <ZExgzbBCbdC1y9Wk@bombadil.infradead.org>
        <ZExw0eW52lYj2R1m@casper.infradead.org>
        <ZE8ue9Mx6n2T0yn6@bombadil.infradead.org>
        <CGME20230501154622eucas1p2d9dea99a75a8b2ccc347fc6e8ca7decb@eucas1p2.samsung.com>
        <ZE/ew1VpU/a1gqQP@casper.infradead.org>
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> No but the only place to add that would be in the block cache. Adding
>> that alone to the block cache doesn't fix the issue. The below patch
>> however does get us by.
> 
> That's "working around the error", not fixing it ... probably the same
> root cause as your other errors; at least I'm not diving into them until
> the obvious one is fixed.
> 
>> >From my readings it does't seem like readahead_folio() should always
>> return non-NULL, and also I couldn't easily verify the math is right.
> 
> readahead_folio() always returns non-NULL.  That's guaranteed by how
> page_cache_ra_unbounded() and page_cache_ra_order() work.  It allocates
> folios, until it can't (already-present folio, ENOMEM, EOF, max batch
> size) and then calls the filesystem to make those folios uptodate,
> telling it how many folios it put in the page cache, where they start.
> 
> Hm.  The fact that it's coming from page_cache_ra_unbounded() makes
> me wonder if you updated this line:
> 
>                 folio = filemap_alloc_folio(gfp_mask, 0);
> 
> without updating this line:
> 
>                 ractl->_nr_pages++;
> 
> This is actually number of pages, not number of folios, so needs to be
> 		ractl->_nr_pages += 1 << order;
> 

I already had a patch which did the following:

ractl->_nr_pages += folio_nr_pages(folio);

but the variable `i` in the loop was not updated properly (assumption of zero order folio). This now
fixes the crash:

@@ -210,7 +210,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
        unsigned long index = readahead_index(ractl);
        gfp_t gfp_mask = readahead_gfp_mask(mapping);
        unsigned long i;
-
+       int order = 0;
        /*
         * Partway through the readahead operation, we will have added
         * locked pages to the page cache, but will not yet have submitted
@@ -223,6 +223,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
         */
        unsigned int nofs = memalloc_nofs_save();

+       if (mapping->host->i_blkbits > PAGE_SHIFT)
+               order = mapping->host->i_blkbits - PAGE_SHIFT;
+
        filemap_invalidate_lock_shared(mapping);
        /*
         * Preallocate as many pages as we will need.
@@ -245,7 +248,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                        continue;
                }

-               folio = filemap_alloc_folio(gfp_mask, 0);
+               folio = filemap_alloc_folio(gfp_mask, order);
                if (!folio)
                        break;
                if (filemap_add_folio(mapping, folio, index + i,
@@ -259,7 +262,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                if (i == nr_to_read - lookahead_size)
                        folio_set_readahead(folio);
                ractl->_workingset |= folio_test_workingset(folio);
-               ractl->_nr_pages++;
+               ractl->_nr_pages += folio_nr_pages(folio);
+               i += folio_nr_pages(folio) - 1;
        }

> various other parts of page_cache_ra_unbounded() need to be examined
> carefully for assumptions of order-0; it's never been used for that
> before.  all the large folio work has concentrated on
> page_cache_ra_order()

As you have noted here, this needs to be examined more carefully. Even though the patches fix the
crash, fio with verify option fails (i.e write and read are not giving the same output).

I think it is better to send an RFC patch series on top of Christoph's work with optional
BUFFER_HEAD to iron out some core issues/bugs.
