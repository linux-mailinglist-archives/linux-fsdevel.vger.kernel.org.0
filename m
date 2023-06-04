Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14665721555
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFDH27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFDH25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181EE0
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685863685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVM5jYUzZ2n66xWhGOhqwBQIXf/tDJSlaltfL9geA/4=;
        b=FS094YhFP2zUpsvTHJWmLTdR1c2n5yqU9RBIAD2S52aJBRYat8JWyzwWR73lwtNlyahZGA
        MdJUId4qoHPz1tDps1PTlHMiOYxDlZxUNw5Z8l1kPudkbjDFAa5BF4l6X0TCh3b1i0LZw5
        UOiR8UAPGqbrOPbsXH+i5tqW+p678pk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-EWsYtouZNu2rPuv3CXel7g-1; Sun, 04 Jun 2023 03:28:03 -0400
X-MC-Unique: EWsYtouZNu2rPuv3CXel7g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6570c5525a7so199879b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 00:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685863681; x=1688455681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVM5jYUzZ2n66xWhGOhqwBQIXf/tDJSlaltfL9geA/4=;
        b=jzlbvQFuKe/6iuuKtcxJ+2HNCX0B4WWclbjp5zXBgn3VQNVU0hTqWazOC2aB5ml0gP
         sucwrOTOEX2fB/cJ2IEQAXhznqE5l9yhoO6R7Crln9EFiOxytyeINH2RkFuxFS3BGsac
         E4WW/wxZJX2oZj76lSlBf2XSxA4Fx3QiJWCmG0VSpu/dgRW1kPmX5anwNZmJEBUMB1UT
         lZSgnTx07V9IT0n4zI1BK927Ij8qojFZVWrig8Tx8kxF+A+wKZ8/vCS4NLhrNjtX750W
         /vUKDQ677fTnHHNPEozyQXiV1r4bZjkcKqkaKa6gbGB2QYwnGYQ0AH0LQLCQdpG8ds+S
         aAyQ==
X-Gm-Message-State: AC+VfDypRaWMYE0ZMxb5GXTy2W27E+npwdDhtC9xSgX/kf8+0c8xDFOY
        L7PfzpHFSHf13/zDWMb0TrzWzWyz7dLRkAXMaK7fbjI7EZC/saU3DDGuJOJtMknKR8KatZdvBRg
        Okbgdee3Bz92DmU1jGGa/JLiTaJGMCr7tlfG0R5B4227elE5R6Fle
X-Received: by 2002:a05:6a20:918b:b0:114:9bbc:c32a with SMTP id v11-20020a056a20918b00b001149bbcc32amr1748396pzd.9.1685863681615;
        Sun, 04 Jun 2023 00:28:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69zmeOtpAI+1Goa2YbFwjYqdyUHtfJLDYR4bsav+OGtu2I8GoA18rJmxHu3V64/eooDGcRkZidtiojaLhnAgc=
X-Received: by 2002:a05:6a20:918b:b0:114:9bbc:c32a with SMTP id
 v11-20020a056a20918b00b001149bbcc32amr1748392pzd.9.1685863681303; Sun, 04 Jun
 2023 00:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230517032442.1135379-1-willy@infradead.org> <20230517032442.1135379-4-willy@infradead.org>
 <CAHc6FU4G1F1OXC233hT7_Vog9F8GNZyeLwsi+01USSXhFBNc_A@mail.gmail.com> <ZHwGhsDPYZQlYksK@casper.infradead.org>
In-Reply-To: <ZHwGhsDPYZQlYksK@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 4 Jun 2023 09:27:48 +0200
Message-ID: <CAHc6FU470Aip5fTsg-8nWjK=p9ND=JCOMSTgxskQ=cwdxk7RtQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 4, 2023 at 5:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, Jun 03, 2023 at 11:34:14AM +0200, Andreas Gruenbacher wrote:
> > >   * This is the same as calling block_write_full_page, but it also
> > >   * writes pages outside of i_size
> > >   */
> > > -static int gfs2_write_jdata_page(struct page *page,
> > > +static int gfs2_write_jdata_folio(struct folio *folio,
> > >                                  struct writeback_control *wbc)
> > >  {
> > > -       struct inode * const inode =3D page->mapping->host;
> > > +       struct inode * const inode =3D folio->mapping->host;
> > >         loff_t i_size =3D i_size_read(inode);
> > > -       const pgoff_t end_index =3D i_size >> PAGE_SHIFT;
> > > -       unsigned offset;
> > >
> > > +       if (folio_pos(folio) >=3D i_size)
> > > +               return 0;
> >
> > Function gfs2_write_jdata_page was originally introduced as
> > gfs2_write_full_page in commit fd4c5748b8d3 ("gfs2: writeout truncated
> > pages") to allow writing pages even when they are beyond EOF, as the
> > function description documents.
>
> Well, that was stupid of me.
>
> > This hack was added because simply skipping journaled pages isn't
> > enough on gfs2; before a journaled page can be freed, it needs to be
> > marked as "revoked" in the journal. Journal recovery will then skip
> > the revoked blocks, which allows them to be reused for regular,
> > non-journaled data. We can end up here in contexts in which we cannot
> > "revoke" pages, so instead, we write the original pages even when they
> > are beyond EOF. This hack could be revisited, but it's pretty nasty
> > code to pick apart.
> >
> > So at least the above if needs to go for now.
>
> Understood.  So we probably don't want to waste time zeroing the folio
> if it is entirely beyond i_size, right?  Because at the moment we'd
> zero some essentially random part of the folio if I just take out the
> check.  Should it look like this?
>
>         if (folio_pos(folio) < i_size &&
>             i_size < folio_pos(folio) + folio_size(folio))
>                folio_zero_segment(folio, offset_in_folio(folio, i_size),
>                                 folio_size(folio));

Yes, looking good, thanks.

If you haven't already, could you please consider my other comment as
well before you repost?

https://lore.kernel.org/linux-fsdevel/CAHc6FU6GowpTfX-MgRiqqwZZJ0r-85C9exc2=
pNkBkySCGUT0FA@mail.gmail.com/

Thanks,
Andreas

