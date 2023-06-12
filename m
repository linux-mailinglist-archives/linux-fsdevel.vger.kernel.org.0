Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6EA72C9A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjFLPSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjFLPSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:18:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075F8F;
        Mon, 12 Jun 2023 08:18:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-653fcd58880so3477661b3a.0;
        Mon, 12 Jun 2023 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583101; x=1689175101;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwMxHWntdZQxEtbYwPoeuyEsSqRwC+x1e76KZ+LdYKU=;
        b=LfnL2vDn8hwk0nUMu/8bA4TI0NsPQ2+TVE5xrtyR8ZlShuMVIOkVWMYEIZ1umTYnM6
         ezoYJZjfX8Ahq8S6uNijF33zGxBpDa52IEPKPRuPjdpRA5a6IuBNl+y998KpfwmhgtDr
         998pG+kHML7K9Q+Qh2dNuLmxu2WNB5XWNkAHGRCuXDElhu1CaS/BAybzPXLWSkxnd8co
         WfSNVAnDH5CIoYmEh6O8zlsZOK2lf0cIVfzNeZg7iUkQHeOz6emkHo/PfycPiXtffD3P
         +0ULJg3ZQgW3DxQzObAGK5eEXQGx2b8mRF0UOhFuVikShasrRcvd4mLgsDZew9x3Yh84
         +SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583101; x=1689175101;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwMxHWntdZQxEtbYwPoeuyEsSqRwC+x1e76KZ+LdYKU=;
        b=aiSgD7H/yg+cXQ/Ef20WfL/zNvJ7ilPZFWhXaJs+twj6+mgoZVVWWkJ2Nz8S6FxpzF
         nXqEqhR47dkpzU5UMy3pHmk4KZf4TVFRoPZlMCm8L4Xn7Eu8HBlgaqbbZ/IO6rnd2gbU
         SEkeLvxErMZipZb3n8PYSSlMyno4ZD3FKgTpwWZ4SGAgMzzgjXcxa+RPHbrDYTXPxwZa
         aboWZyeWR3WXTJbcQjcSm4ZRaR/iJ1+2U0kpV7aXo2No/UgN0suvpRMk/+x46aIY0XG/
         LTazDl1i9PNwsUNo7FSilY8RkUvd0t5BszfRN+ivcMCdIAH7qagfLLpuUvATRrGkmD3L
         XXLQ==
X-Gm-Message-State: AC+VfDwihteQSkErnop1K6AtVIChybr7CiSnF95mfq7pVRVQaSoWsTrV
        f5LZBIncxlyIPaNRKVG2hMw=
X-Google-Smtp-Source: ACHHUZ5fXlN3Wa4lI3fNCYTPA8m0WhO5JxmJ3Wo2T/61/b8Fo4O9/rYr1GxJek5I5flAWTcr4ub9tA==
X-Received: by 2002:a05:6a20:7288:b0:111:1c17:3fc6 with SMTP id o8-20020a056a20728800b001111c173fc6mr10801033pzk.10.1686583101226;
        Mon, 12 Jun 2023 08:18:21 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm7665614pgx.0.2023.06.12.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:18:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:48:16 +0530
Message-Id: <87o7lkhfpj.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <CAHc6FU5xMQfGPuTBDChS=w2+t4KAbu9po7yE+7qGaLTzV-+AFw@mail.gmail.com>
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

Andreas Gruenbacher <agruenba@redhat.com> writes:

> On Mon, Jun 12, 2023 at 8:25 AM Christoph Hellwig <hch@infradead.org> wrote:
>> On Sat, Jun 10, 2023 at 05:09:04PM +0530, Ritesh Harjani (IBM) wrote:
>> > This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
>> > and iomap_ifs_is_block_uptodate() for managing uptodate state of
>> > ifs state bitmap.
>> >
>> > In later patches ifs state bitmap array will also handle dirty state of all
>> > blocks of a folio. Hence this patch adds some helper routines for handling
>> > uptodate state of the ifs state bitmap.
>> >
>> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> > ---
>> >  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>> >  1 file changed, 20 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> > index e237f2b786bc..206808f6e818 100644
>> > --- a/fs/iomap/buffered-io.c
>> > +++ b/fs/iomap/buffered-io.c
>> > @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
>> >
>> >  static struct bio_set iomap_ioend_bioset;
>> >
>> > +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
>> > +                                            struct iomap_folio_state *ifs)
>> > +{
>> > +     struct inode *inode = folio->mapping->host;
>> > +
>> > +     return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> > +}
>> > +
>> > +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
>> > +                                            unsigned int block)
>> > +{
>> > +     return test_bit(block, ifs->state);
>
> "block_is_uptodate" instead of "is_block_uptodate" here as well, please.
>
> Also see by previous mail about iomap_ifs_is_block_uptodate().
>

"is_block_uptodate" is what we decided in our previous discussion here [1]
[1]: https://lore.kernel.org/linux-xfs/20230605225434.GF1325469@frogsfrogsfrogs/


Unless any strong objections, for now I will keep Maintainer's suggested name
;) and wait for his feedback on this.

>> > +}
>>
>> A little nitpicky, but do the _ifs_ name compenents here really add
>> value?
>
> Since we're at the nitpicking, I don't find those names very useful,
> either. How about the following instead?
>
> iomap_ifs_alloc -> iomap_folio_state_alloc
> iomap_ifs_free -> iomap_folio_state_free
> iomap_ifs_calc_range -> iomap_folio_state_calc_range

First of all I think we need to get used to the name "ifs" like how we
were using "iop" earlier. ifs == iomap_folio_state...

>
> iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
> iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
> iomap_ifs_is_block_dirty -> iomap_block_is_dirty
>

...if you then look above functions with _ifs_ == _iomap_folio_state_
naming. It will make more sense. 


> iomap_ifs_set_range_uptodate -> __iomap_set_range_uptodate
> iomap_ifs_clear_range_dirty -> __iomap_clear_range_dirty
> iomap_ifs_set_range_dirty -> __iomap_set_range_dirty

Same as above.

>
> Thanks,
> Andreas

Thanks for the review! 

I am not saying I am not open to changing the name. But AFAIR, Darrick
and Matthew were ok with "ifs" naming. In fact they first suggested it
as well. So if others also dislike "ifs" naming, then we could consider
other options.

-ritesh
