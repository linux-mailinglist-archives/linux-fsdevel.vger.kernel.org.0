Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C17250A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 01:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjFFXRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 19:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjFFXQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:16:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E151BD8
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 16:15:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b6865c7cso57253411fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686093345; x=1688685345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyl/WcE6YqSdLzSAWk7AiiVSzw5Ws6uIFfgoB2cNJu4=;
        b=if61hhhtrZy4mItMGPSoKFbcE+MTW2vLcFdkQugEp+gst3bPCXE/KtNae4KlXWv776
         RFJ8+C7057/3Zv+HBAodN39c+Lg4rSx2u1YpybU8hwL/ykdaOCMuHhQQ/OQBwrPE5qvU
         VSEIcDaNKGJcV/aRfX2Kw73TkL/qq6ipfdHBrYZfsiBjJU+mWhucWZ5Edl5y5vt7uYb/
         6gMNa0nnXEWSx6UlYdkws/uX0PbCEuB2qQyZk8V8f8kBifxJ6Va3gqvLNuC8ACsDRkQX
         W0y+atRbFJ3NhKdhNELRkEUb+gpDtTJBWIz14QMbbAPCSmpHls+cxBMz8nYiPT5P0K7V
         jVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093345; x=1688685345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyl/WcE6YqSdLzSAWk7AiiVSzw5Ws6uIFfgoB2cNJu4=;
        b=LOy22LPj1hsF/pEMaw0mYdtdXieN8saqq1la6Lzdy5Ux6NImcAoUn0ZUP8urr4jRbo
         bLEGe3aikA0rjtGSrnuuOP1uh8Zgnr4ZXq+wDNnOpGhoqeWRooNY2GnT4FFfTpUymSH/
         bYoSx+t2HnehOQNv1qPbgIjv/9W81xo509M7TqsSbEwNIE2D2aNPNsDt1vqvlwn+aalW
         02sv4LvzV1dWq8T7IxQSLC5Czb3ff+RVPJmFc6HNP4T7V3pP0gsag411uzTGwftplB4X
         dCkTIs1vugLWuOEIHxwCXtypKvHJiDj+c1gMajyaxHxZTnXEV8ZXx5NRbW6f77WhK2zT
         2Vvw==
X-Gm-Message-State: AC+VfDxNpvekiEwstKMQSXOrIFNNXW5Oi/S9tC2JpSn1CckEMIJ8Puf7
        Wov3VHRXCv2ey4ORo0JqPHN+V518MrwaaapgNPs=
X-Google-Smtp-Source: ACHHUZ6vig3CbZKUnpz0pCOFJWHOQy0gXgLFYiEw2QsrYj5z5ar7ObRCxIWkbSYXJbRcUCkQ24O+sHsMWPwwS4WktYg=
X-Received: by 2002:a2e:894b:0:b0:2b1:ee25:973f with SMTP id
 b11-20020a2e894b000000b002b1ee25973fmr1641362ljk.39.1686093345233; Tue, 06
 Jun 2023 16:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230606223346.3241328-1-willy@infradead.org> <20230606223346.3241328-7-willy@infradead.org>
In-Reply-To: <20230606223346.3241328-7-willy@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 7 Jun 2023 01:15:34 +0200
Message-ID: <CAHpGcMK09P=56Z9UEUJx_3-7HPyfXDF4wxJ7wA5J0EutuxzfGw@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] buffer: Make block_write_full_page() handle
 large folios correctly
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 7. Juni 2023 um 00:41 Uhr schrieb Matthew Wilcox (Oracle)
<willy@infradead.org>:
> Keep the interface as struct page, but work entirely on the folio
> internally.  Removes several PAGE_SIZE assumptions and removes
> some references to page->index and page->mapping.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Bob Peterson <rpeterso@redhat.com>
> Reviewed-by: Bob Peterson <rpeterso@redhat.com>
> ---
>  fs/buffer.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4d518df50fab..d8c2c000676b 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2678,33 +2678,31 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
>                         struct writeback_control *wbc)
>  {
>         struct folio *folio = page_folio(page);
> -       struct inode * const inode = page->mapping->host;
> +       struct inode * const inode = folio->mapping->host;
>         loff_t i_size = i_size_read(inode);
> -       const pgoff_t end_index = i_size >> PAGE_SHIFT;
> -       unsigned offset;
>
> -       /* Is the page fully inside i_size? */
> -       if (page->index < end_index)
> +       /* Is the folio fully inside i_size? */
> +       if (folio_pos(folio) + folio_size(folio) <= i_size)
>                 return __block_write_full_folio(inode, folio, get_block, wbc,
>                                                end_buffer_async_write);
>
> -       /* Is the page fully outside i_size? (truncate in progress) */
> -       offset = i_size & (PAGE_SIZE-1);
> -       if (page->index >= end_index+1 || !offset) {
> +       /* Is the folio fully outside i_size? (truncate in progress) */
> +       if (folio_pos(folio) > i_size) {

The folio is also fully outside i_size if folio_pos(folio) == i_size.

>                 folio_unlock(folio);
>                 return 0; /* don't care */
>         }
>
>         /*
> -        * The page straddles i_size.  It must be zeroed out on each and every
> +        * The folio straddles i_size.  It must be zeroed out on each and every
>          * writepage invocation because it may be mmapped.  "A file is mapped
>          * in multiples of the page size.  For a file that is not a multiple of
> -        * the  page size, the remaining memory is zeroed when mapped, and
> +        * the page size, the remaining memory is zeroed when mapped, and
>          * writes to that region are not written out to the file."
>          */
> -       zero_user_segment(page, offset, PAGE_SIZE);
> +       folio_zero_segment(folio, offset_in_folio(folio, i_size),
> +                       folio_size(folio));
>         return __block_write_full_folio(inode, folio, get_block, wbc,
> -                                                       end_buffer_async_write);
> +                       end_buffer_async_write);
>  }
>  EXPORT_SYMBOL(block_write_full_page);
>
> --
> 2.39.2
>

Thanks,
Andreas
