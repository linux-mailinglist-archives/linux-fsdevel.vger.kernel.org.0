Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F972CD52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjFLR54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjFLR5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:57:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF812E4E;
        Mon, 12 Jun 2023 10:57:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b01d3bb571so24695705ad.2;
        Mon, 12 Jun 2023 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592674; x=1689184674;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/51Bi1UkVZlS59hvczkfp3IUubDxrwBQefoJjlP3Kq8=;
        b=r/wRrfS/3T96nvop7OABuVrp9W/8AWtERwhYOULZL0UZWsb9fb8k7ew6Uzhir3VASZ
         Unwp66qbVpBDPvKqmy0oqofSL+A48j/QbbxBWZ+d+hbEwNOKS+ugXDI8i05ziT3WLRLY
         9dnGDafIgtT+jARuaIwmiuXVJNcXl/kA2sRd3H+wITF9aKeOEd0KytUFZb6rPLaDmGBi
         eMKKzq9euzypDLs6l+fzeaI7HQ4H4f+jnGRE1JftUrxoXYkSduF37Xj77JtZnxPNbIit
         yLqsbuUD5zloJG6mSEhqE+R34pbjqLqWPwBY9xFroBeZAZA809TCtLlyrsv0PeUB2vU2
         foOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592674; x=1689184674;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/51Bi1UkVZlS59hvczkfp3IUubDxrwBQefoJjlP3Kq8=;
        b=bidSzLEhmiXB6UFGfQILY9d1/al34ZFATsCeG32/rQ6CvIztGjrHub/ZYWPDfWCYnu
         IQ3YdON0bTG2zsvVMuoiswKNUPkrLVEuegHnab1JMPVenddTx9EBs4N/XGgLyMTLos/C
         Q5Baut/w5buADlaraFF3yRX9WRbSxdWYTv07ZCjspLtovItSuFjY+LJquO3/fEHlL87E
         aK6rjZmOuKI4PKwj+o0hJTLaoL/vAjSNrc2+5P9raBjKmeb7gTJiiaIErhIKPNHa6hwo
         QlYrNqglMceuaJiUgRgJjlUEA//xTploPnhrcnkW8r0ZesYUYZ6H8tLAnlTzd2t4/PPB
         iRAg==
X-Gm-Message-State: AC+VfDymJ4hU0WuuYxWV73MYKsj8VdVA088Rr1pmjJFUkYQ0ssiHbng/
        dhaUGcUvYVTdvdvvWISRj5o=
X-Google-Smtp-Source: ACHHUZ6BvjQmFogjAwPycbaTbzlX3om8jAzJojDPaQXsX/e/F38PAhjAMGn2+X3MUU+csXF8j2ny4w==
X-Received: by 2002:a17:902:ce8a:b0:1aa:e938:3ddf with SMTP id f10-20020a170902ce8a00b001aae9383ddfmr8371724plg.7.1686592674224;
        Mon, 12 Jun 2023 10:57:54 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001b176ba9f17sm8524918plg.149.2023.06.12.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:57:53 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:27:49 +0530
Message-Id: <87o7lkpnqa.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <20230612161617.GE11441@frogsfrogsfrogs>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jun 12, 2023 at 09:00:29PM +0530, Ritesh Harjani wrote:
>> Andreas Gruenbacher <agruenba@redhat.com> writes:
>> 
>> > On Sat, Jun 10, 2023 at 1:39 PM Ritesh Harjani (IBM)
>> > <ritesh.list@gmail.com> wrote:
>> >> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
>> >> and iomap_ifs_is_block_uptodate() for managing uptodate state of
>> >> ifs state bitmap.
>> >>
>> >> In later patches ifs state bitmap array will also handle dirty state of all
>> >> blocks of a folio. Hence this patch adds some helper routines for handling
>> >> uptodate state of the ifs state bitmap.
>> >>
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>> >>  1 file changed, 20 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> >> index e237f2b786bc..206808f6e818 100644
>> >> --- a/fs/iomap/buffered-io.c
>> >> +++ b/fs/iomap/buffered-io.c
>> >> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
>> >>
>> >>  static struct bio_set iomap_ioend_bioset;
>> >>
>> >> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
>> >> +                                              struct iomap_folio_state *ifs)
>> >> +{
>> >> +       struct inode *inode = folio->mapping->host;
>> >> +
>> >> +       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> >
>> > This should be written as something like:
>> >
>> > unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> > return bitmap_full(ifs->state + IOMAP_ST_UPTODATE * blks_per_folio,
>> > blks_per_folio);
>> >
>> 
>> Nah, I feel it is not required... It make sense when we have the same
>> function getting use for both "uptodate" and "dirty" state.
>> Here the function anyways operates on uptodate state.
>> Hence I feel it is not required.
>
> Honestly I thought that enum-for-bits thing was excessive considering
> that ifs has only two state bits.  But, since you included it, it
> doesn't make much sense /not/ to use it here.

Ok. Will make the changes.

>
> OTOH, if you disassemble the object code and discover that the compiler
> *isn't* using constant propagation to simplify the object code, then
> yes, that would be a good reason to get rid of it.

Sure, I will check that once too.


-ritesh
