Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC163603174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJRRSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJRRR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:17:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D9EF591
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 10:17:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by36so18855528ljb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn0g0uPQNgWAIulTAHlL4xKStBrdvYdScpOKFuxEci4=;
        b=UJmeKnfZ0F5FNYAg1B4ZlTGwoxmU03fABlswDVlVVDgdYKNPZcdY9WwV9GCOovjwDd
         pr0rk37er31wg/7euIBifdagIniBWY3V0gmHDwx+y5etMY0U3a0nYe+C+MTxtfPZ/5fc
         1r9Rz5GR/ByFfPvbdaoFylxy8TMIeEtwAFCRNWDfb6Hm8/aafKJks8N+CyJYbwJCL1ow
         mUYyOmuY/7jxV9fy7uFfgEwwCOG8ZIOG50gL1ZIE/NaVnCDyOk4j9YQLEPwjYgbEiHkP
         5zLk7o1Cz4NUUL0z/K4cBYl+DvRpVssMkoS1R0RBaGTRoyWBJ0hRzdPNVtmg4vkuYMvW
         DqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn0g0uPQNgWAIulTAHlL4xKStBrdvYdScpOKFuxEci4=;
        b=2sYh5Jq4x7gmRbAms6Hee2KXbfSohYPIVUqSzC2EyqTdg0rUwKdq2I9mUA/uzqtn3l
         6NpFbziIfjHwFpgTno9qcpqjRftgndCoCcYEhiRkdTmKKJcKleRjN7ANs/4jfXH1L9gA
         9EaYnGL+tk61b2diIXs393Pmfs1GiNGL/LCEtwYBM6XzhzxEgTvohqBhKp6UscR6iOVI
         MjX4vsy/nhZpFstAe3+NshCc1gLHjjHyjuTMu5pl5DXISuXU6VSA1LsTxGbGDjuSgj0q
         X2a4WMySlwEDxs70sq1nyWWHsOgBnCPCu3hbjJWWhqHbKzZyjsFpoeq7FsvFl3qYljAW
         ko2Q==
X-Gm-Message-State: ACrzQf0ipb+XG05kB0+DGGCH32GMASHqy9iET0Nxjgne0GF7bpqszv6H
        i0ehoeaKNO3TLexc/e6c6Va8VNDTSU7myguSzUSogw==
X-Google-Smtp-Source: AMsMyM5Xl/iFuj+/VH/qkFLvtSgyGhPwva9B3V2p0knCNY2j/1i0nJ5N41af6+MwEGFUhgjJzb9tjkAuGpSPlyxwjxI=
X-Received: by 2002:a2e:92d5:0:b0:26f:a674:94ac with SMTP id
 k21-20020a2e92d5000000b0026fa67494acmr1465830ljh.470.1666113467907; Tue, 18
 Oct 2022 10:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <Y0T2l3HaH2MU8M9m@gmail.com> <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com> <CABb0KFGCm=K2X3-O=y3BJN85sT2C-y+XZRtLxnuabuOg+OrHwQ@mail.gmail.com>
 <17d7d6f5-21dc-37e1-6843-29c77a0e14b6@collabora.com>
In-Reply-To: <17d7d6f5-21dc-37e1-6843-29c77a0e14b6@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 18 Oct 2022 19:17:36 +0200
Message-ID: <CABb0KFFGRgy9D212skxxFMsHV5n3qjqUP9d-bQaWLUmtH46H3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, corbet@lwn.net, david@redhat.com,
        kernel@collabora.com, krisman@collabora.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peter.enderborg@sony.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, figiel@google.com,
        kyurtsever@google.com, Paul Gofman <pgofman@codeweavers.com>,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Oct 2022 at 15:23, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 10/18/22 4:11 PM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 18 Oct 2022 at 12:36, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
[...]
> >>    * @start:             Starting address
> >>    * @len:               Length of the region
> >>    * @vec:               Output page_region struct array
> >>    * @vec_len:           Length of the page_region struct array
> >>    * @max_out_page:      Optional max output pages (It must be less th=
an
> >> vec_len if specified)
> >
> > Why is it required to be less than vec_len? vec_len effectively
> > specifies max number of ranges to find, and this new additional field
> > counts pages, I suppose?
> > BTW, if we count pages, then what size of them? Maybe using bytes
> > (matching start/len fields) would be more consistent?
> Yes, it if for counting pages. As the regions can have multiple pages,
> user cannot specify through the number of regions that how many pages
> does he need. Page size is used here as well like the start and len.
> This is optional argument as this is only needed to emulate the Windows
> syscall getWriteWatch.

I'm wondering about the condition that max_out_page < vec_len. Since
both count different things (pages vs ranges) I would expect there is
no strict relation between them and information returned is as much as
fits both (IOW: at most vec_len ranges spanning not more than
max_out_page pages). The field's name and description I'd suggest
improving: maybe 'max_pages' with a comment that 0 =3D unlimited?

[...]
> >> /* Special flags */
> >> #define PAGEMAP_NO_REUSED_REGIONS       0x1
> >
> > What does this flag do?
> Some non-dirty pages get marked as dirty because of the kernel's
> internal activity. The dirty bit of the pages is stored in the VMA flags
> and in the per page flags. If any of these two bits are set, the page is
> considered to be dirty. Suppose you have cleared the dirty bit of half
> of VMA which will be done by splitting the VMA and clearing dirty flag
> in the half VMA and the pages in it. Now kernel may decide to merge the
> VMAs again as dirty bit of VMAs isn't considered if the VMAs should be
> merged. So the half VMA becomes dirty again. This splitting/merging
> costs performance. The application receives a lot of pages which aren't
> dirty in reality but marked as dirty. Performance is lost again here.
>
> This PAGEMAP_NO_REUSED_REGIONS flag is used to don't depend on the dirty
> flag in the VMA flags. It only depends on the individual page dirty bit.
> With doing this, the new memory regions which are just created, doesn't
> look like dirty when seen with the IOCTL, but look dirty when seen from
> pagemap. This seems okay as the user of this flag know the implication
> of using it.

Thanks for explaining! Could you include this as a comment in the patch?

Best Regards
Micha=C5=82 Miros=C5=82aw
