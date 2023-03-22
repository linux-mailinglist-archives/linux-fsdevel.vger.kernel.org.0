Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674B46C47AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCVKcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCVKcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:32:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524804A1D5;
        Wed, 22 Mar 2023 03:32:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m2so16473048wrh.6;
        Wed, 22 Mar 2023 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679481170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1CeLNOWnRlqe1bR3xMhj6/4uAXJ9YfiUxVG0ziEESs=;
        b=M5p9FntqrNraUn/1fryCXq6NzFVy+lQsgH7lt2dwu/DakfDB+h8t3YtR/D9zADE97D
         mwTEhubIVJBVEXK4mjYpYPFbKGliQt9/jjJX4ODWOVLVbcD7rl6opRH2GIbQ+9Ir31go
         ynnd5v6PdiHrFQSFE04Z5fEwmhDNZCmX+ybnjW69kHzU1wBjQc/NIG4MoDkNUxM3hQ5P
         iq40Tjochukfgt/Sp1MMhvquA7l9G/tfwrrvGg1MfSChQE/gUy79uzfedJdRqH9VH8Lq
         Wq4lEHKUy+GyM6DYvW+J5jOvVseJFAgy6gQtHkaW8OMkGJrGzpi8yuD8kyiao6ld3g52
         tVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1CeLNOWnRlqe1bR3xMhj6/4uAXJ9YfiUxVG0ziEESs=;
        b=eYfmtfCGdrbAvfHs52Jk44QYnmAeGRISrPnkVTjtQdzXwtXSIyjTTXwY/nm3PmJOu5
         6+3ZUb0T9mEx2QXIS0Qx3UrzpN20A3BTFUvLWbox5k+IlRGT+NMglIrwD+SiLo7cOxJb
         syEbeJgxbfvID3pZScAuWhXCmenYnKxoS7CvvL+IedJvq26mlV/snK3T6PF1nXjo37Kk
         rBwiida+BixqDaQP1WKbh3v5EMG9Vs3fSv3e0QJcgMt+DaGVhBDbSvijdBbtzmFsn0Za
         kaPwC9EOdmQV5wabMrOTIjp0oZUsF1kMIPgRs1mDM1Q8P8TnV5P7LB3wL3StQSbxKDDm
         zkoA==
X-Gm-Message-State: AO0yUKV9OwppT0LaEQu7iY1sxFTvAs1N0KDzzrmBBx6EK80IsoROj69B
        NXIODM/XN6uZeuet/TubgZc=
X-Google-Smtp-Source: AK7set/53fxO++ICPo9CDCI6k2GRYpLxmnmZZ+pCn6q2L+UDEhM2Lva/0vi7LOq/h8NTmOccPbVvfw==
X-Received: by 2002:a5d:6245:0:b0:2c5:4ca3:d56c with SMTP id m5-20020a5d6245000000b002c54ca3d56cmr1406977wrv.0.1679481169582;
        Wed, 22 Mar 2023 03:32:49 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b002c3f81c51b6sm13440307wrq.90.2023.03.22.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:32:48 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:32:47 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/4] iov_iter: add copy_page_to_iter_atomic()
Message-ID: <a961ab9c-1ced-4db4-a76f-d886bd01c715@lucifer.local>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
 <ZBrVtcqATRybF/hW@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrVtcqATRybF/hW@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:17:25PM +0800, Baoquan He wrote:
> On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
> > Provide an atomic context equivalent for copy_page_to_iter(). This eschews
> > the might_fault() check copies memory in the same way that
> > copy_page_from_iter_atomic() does.
> >
> > This functions assumes a non-compound page, however this mimics the
> > existing behaviour of copy_page_from_iter_atomic(). I am keeping the
> > behaviour consistent between the two, deferring any such change to an
> > explicit folio-fication effort.
> >
> > This is being added in order that an iteratable form of vread() can be
> > implemented with known prefaulted pages to avoid the need for mutex
> > locking.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  include/linux/uio.h |  2 ++
> >  lib/iov_iter.c      | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > index 27e3fd942960..fab07103090f 100644
> > --- a/include/linux/uio.h
> > +++ b/include/linux/uio.h
> > @@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
> >
> >  size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> >  				  size_t bytes, struct iov_iter *i);
> > +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset,
> > +				size_t bytes, struct iov_iter *i);
> >  void iov_iter_advance(struct iov_iter *i, size_t bytes);
> >  void iov_iter_revert(struct iov_iter *i, size_t bytes);
> >  size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 274014e4eafe..48ca1c5dfc04 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -821,6 +821,34 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
> >  }
> >  EXPORT_SYMBOL(copy_page_from_iter_atomic);
> >
> > +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> > +				struct iov_iter *i)
> > +{
> > +	char *kaddr = kmap_local_page(page);
>
> I am a little confused about the name of this new function. In its
> conterpart, copy_page_from_iter_atomic(), kmap_atomic()/kunmpa_atomic()
> are used. With them, if CONFIG_HIGHMEM=n, it's like below:

The reason for this is that:-

1. kmap_atomic() explicitly states that it is now deprecated and must no longer
   be used, and kmap_local_page() should be used instead:-

 * kmap_atomic - Atomically map a page for temporary usage - Deprecated!

 * Do not use in new code. Use kmap_local_page() instead.

2. kmap_local_page() explicitly states that it can be used in any context:-

 * Can be invoked from any context, including interrupts.

I wanted follow this advice as strictly as I could, hence the change. However,
we do need preemption/pagefaults explicitly disabled in this context (we are
happy to fail if the faulted in pages are unmapped in meantime), and I didn't
check the internals to make sure.

So I think for safety it is better to use k[un]map_atomic() here, I'll respin
and put that back in, good catch!

>
> static inline void *kmap_atomic(struct page *page)
> {
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_disable();
>         else
>                 preempt_disable();
>         pagefault_disable();
>         return page_address(page);
> }
>
> But kmap_local_page() is only having page_address(), the code block
> between kmap_local_page() and kunmap_local() is also atomic, it's a
> little messy in my mind.
>
> static inline void *kmap_local_page(struct page *page)
> {
>         return page_address(page);
> }
>
> > +	char *p = kaddr + offset;
> > +	size_t copied = 0;
> > +
> > +	if (!page_copy_sane(page, offset, bytes) ||
> > +	    WARN_ON_ONCE(i->data_source))
> > +		goto out;
> > +
> > +	if (unlikely(iov_iter_is_pipe(i))) {
> > +		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
> > +		goto out;
> > +	}
> > +
> > +	iterate_and_advance(i, bytes, base, len, off,
> > +		copyout(base, p + off, len),
> > +		memcpy(base, p + off, len)
> > +	)
> > +	copied = bytes;
> > +
> > +out:
> > +	kunmap_local(kaddr);
> > +	return copied;
> > +}
> > +EXPORT_SYMBOL(copy_page_to_iter_atomic);
> > +
> >  static void pipe_advance(struct iov_iter *i, size_t size)
> >  {
> >  	struct pipe_inode_info *pipe = i->pipe;
> > --
> > 2.39.2
> >
>
