Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97778721D67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFEFQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 01:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEFQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:16:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC818B1;
        Sun,  4 Jun 2023 22:16:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso11556680a12.0;
        Sun, 04 Jun 2023 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685942204; x=1688534204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ7AliJOD75Tb5S11OerW1AM3XqRaEbsDLm/xR/jW5k=;
        b=XKSPVvRaTb3R9jfeXaQoGfspYSKgmB/g2SrEW9E8dcqarUXximSqXM86XzETFPmmuL
         z8kB+lky28mtl8+H22MNC6CpW72rpEQ7Awkem7suP1uHlL0ic2FH7CKh0POSJV3Bvoib
         PXND2ZxUrh8h4vot5QbujY621x2Aj1fNS9zecsbOlBkAl0/lBjp0nChYvGHYOmgzQf0M
         kzp1scqS/g7MmVTIau3YsSDVn6kUh+wuK+sVTSP9WCtDnwtj1vYsbU9UztdUnYZD6iVB
         NwSlERxsUzYFaiQ1cQYPdNG+gHn0obBxzCh/BVNRqaAOm0ShvuI/fI/Td7MrJd6zQhi6
         TcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685942204; x=1688534204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ7AliJOD75Tb5S11OerW1AM3XqRaEbsDLm/xR/jW5k=;
        b=HFaRD6sSKE5ITJG3Io51kEwTD7MeRJv0Wy4pDCA0/VN+JTiVnE6iskOvC4NLdMAKaP
         dROvYR2rVAxweXww/tUIW72Cmu6SRXyKq9HWzilsXVEZpVkBRm0RGohG3xptHauGvWDY
         f6hHO8MBNlpTKRyCn0MaAIjoaSFxf1svrQPd6mTIruWWqQpI8W8l/VwgkVwRX+gKqp4Y
         W4WpSsdmE1WFHRuOvMhaCl8es5+AXroFIAhIVZV8ZBjFuEFd5yi4DYAMnRlJCYucgcx+
         a9q9I26p8Vd63njDzbDyUtojs2r9axhU+4GzwPv81ptRH2cxg+BlEF29vo4m5yN/4j1/
         gidQ==
X-Gm-Message-State: AC+VfDwf8NxhQ3WdWR3JX+dANcrDpeTNjAsJElLQsBILWlU4EE+JdTE5
        ryvzsDnlE9pHyMd7YzHZ+wj74VkEvQ3wtK/OE9M=
X-Google-Smtp-Source: ACHHUZ5RaDZh5JN75AMSEnARed2B1/PcWtmFub1j7gFr9acGCZAAdpjvZlGqCQITocyN4HmYVed8jqOmBgoK0q6OcOw=
X-Received: by 2002:a05:6402:1485:b0:50d:8d42:a454 with SMTP id
 e5-20020a056402148500b0050d8d42a454mr7905401edv.21.1685942204056; Sun, 04 Jun
 2023 22:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685900733.git.ritesh.list@gmail.com> <0d52baa3865f4c8fe49b8389f8e8070ed01144f8.1685900733.git.ritesh.list@gmail.com>
 <ZH1XcNIe+qIt/H6Z@casper.infradead.org>
In-Reply-To: <ZH1XcNIe+qIt/H6Z@casper.infradead.org>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Date:   Mon, 5 Jun 2023 10:46:33 +0530
Message-ID: <CALk7dXqpQ4yU+XKGmk0N8KuMXCzZ+sd0YMHvTwWbHM6SwvnyZQ@mail.gmail.com>
Subject: Re: [PATCHv6 3/5] iomap: Refactor some iop related accessor functions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 5, 2023 at 9:03=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Jun 05, 2023 at 07:01:50AM +0530, Ritesh Harjani (IBM) wrote:
> > @@ -214,7 +231,7 @@ struct iomap_readpage_ctx {
> >  static int iomap_read_inline_data(const struct iomap_iter *iter,
> >               struct folio *folio)
> >  {
> > -     struct iomap_page *iop;
> > +     struct iomap_page __maybe_unused *iop;
>
> Ummm ... definitely unused, right?
>

Yes, I will fix it in the next rev. Will send it out soon.

> >       const struct iomap *iomap =3D iomap_iter_srcmap(iter);
> >       size_t size =3D i_size_read(iter->inode) - iomap->offset;
> >       size_t poff =3D offset_in_page(iomap->offset);
> > @@ -240,7 +257,8 @@ static int iomap_read_inline_data(const struct ioma=
p_iter *iter,
> >       memcpy(addr, iomap->inline_data, size);
> >       memset(addr + size, 0, PAGE_SIZE - poff - size);
> >       kunmap_local(addr);
> > -     iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
> > +     iomap_iop_set_range_uptodate(iter->inode, folio, offset,
> > +                                  PAGE_SIZE - poff);
>
> Once you make this change, iop is set in this function, but never used.
> So you still want to call iomap_page_create() if offset > 0, but you
> can ignore the return value.  And you don't need to call to_iomap_page().
>
> Or did I miss something elsewhere in this patch series?

No, I added __maybe_unused earlier to avoid W=3D1 warnings and then
forgot to fix it, before sending forgot to
fix that part of code.

-ritesh
