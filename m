Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD15730D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiGMIVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiGMIUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02D5464E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:16:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so18497737ejc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8kgQPuUH8sMZbqBDu6Yvo0zZMPK8MB4N3c8nJfJPrI=;
        b=LWbDQuQkejb7dVQP9BxfiFEePUYcuSS8G2u4BCnVYvqCkjRhvsA/K0SzL5ToUlhMqw
         wsd49pLcDVMAW21ehoYq5RxXVptYyJfYfpIhOW6z+GN3pndMthVv1Fy0O95ab4FZ1flN
         C4MJQ1B42EK/jeCNCIr1ORAZbSXPd68Nnw96E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8kgQPuUH8sMZbqBDu6Yvo0zZMPK8MB4N3c8nJfJPrI=;
        b=ETLw8e6tBSe9S4XxGH7G3KtHXT5GTNC1e5fK+280BmWT5RAZRu7eNP8kRKBNGoi/lA
         FfBOB72fwAR+FIW05TDqLGqxw9rVFUo2Ze7Tt2vcGM2QKx1mNPo9/dyrtD+6CCcCTa9e
         eWLyArtclDYOXbiLMT1IGtwcdur9eWKjshJNvQYAWbFOvTzAhPWR4TutvxD52c6TxTV4
         09DZaYyYS7IBkrEbPwMqx9RRuZpsPvDwMo6QCF0X1G//c44cGkuZSZgpJ9erLzy84VsQ
         q3kWVzu9H+UhNuOi/zm1MakRWCsHON2TP3j8o4ELDrSFD8uODNN9fl1bQ10IZTXam/VP
         KV1A==
X-Gm-Message-State: AJIora8iLPMNVUUygTz35tKPdKh0/8ZaNfkI+NCJCMLJ6TO+F1oHkF3Y
        DwpL7RetyoTRXYTJGmz2LQap/trGewDLQ863fTo=
X-Google-Smtp-Source: AGRyM1tJcD3lqeCDIFmBwJKqOjnedKJKDtPhWIiwMz9fQI/Jj+MAK/Msqjjz4wXNl76vwg8W5rlBhw==
X-Received: by 2002:a17:907:7604:b0:72b:4ad5:b21c with SMTP id jx4-20020a170907760400b0072b4ad5b21cmr2182236ejc.412.1657700217900;
        Wed, 13 Jul 2022 01:16:57 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00722e50e259asm4631230ejo.102.2022.07.13.01.16.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:16:55 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id h17so14433906wrx.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:16:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr1919032wrb.442.1657700214277; Wed, 13
 Jul 2022 01:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
In-Reply-To: <20220713064631.GC3600936@dread.disaster.area>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 01:16:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdndJozh+xbecdMo2MJ4_ZhWs3UoBgmuGXN2xjdeUktg@mail.gmail.com>
Message-ID: <CAHk-=wjdndJozh+xbecdMo2MJ4_ZhWs3UoBgmuGXN2xjdeUktg@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:46 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Hence if we restrict EOF block deduping to both the src and dst
> files having matching EOF offsets in their EOF blocks like so:
>
> -       if (pos_in + count == size_in) {
> +       if (pos_in + count == size_in &&
> +           (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
>                  bcount = ALIGN(size_in, bs) - pos_in;

I agree with checking the target size too.

And I can see how missing that might cause the problem.

I don't think that is limited to the REMAP_FILE_DEDUP case, though.
Even if you a clone operation, you cannot just clone the EOF block to
some random part of the destination.

Anyway, isn't all of this supposed to be done by
generic_remap_check_len()? That function already takes care of a
similar concern for REMAP_FILE_CAN_SHORTEN, where the size of the
*output* file matters.

So generic_remap_check_len() basically already does one EOF block
check for the output file. It just doesn't do it for the input side.

And currently generic_remap_check_len() is done too late for
REMAP_FILE_DEDUP, which did its handling just before calling it.

So while I agree with your patch from a "this seems to be the
underlying bug", I think the fix should be to move this "both EOF
blocks have to match" logic to generic_remap_check_len(), and just do
that *before* that

        if (remap_flags & REMAP_FILE_DEDUP) {

in generic_remap_file_range_prep().

No?

That said, the rest of that code in generic_remap_checks() still makes
little to no sense to me.

Look:

>                  bcount = ALIGN(size_in, bs) - pos_in;

and we literally *just* checked that "pos_in + count == size_in".

So we can write that as

>                  bcount = ALIGN(pos_in + count, bs) - pos_in;

That doesn't look simpler, but...

Again, just a few lines above this all, we had

>         if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
>                 return -EINVAL;

so we know that 'pos_in' is aligned wrt bs.

So we can rewrite that "ALIGN(pos_in + count, bs)" as "pos_in +
ALIGN(count, bs)", because 'pos_in' doesn't change anything wrt an
alignment operation.

And then trivial simplification ("pos_in - pos_in goes away") makes
the whole expression be just

>                  bcount = ALIGN(count, bs);

which just once more makes me go "maybe this code works, but it is
clearly written for maximum nonsensical value".

The "else" side is equally overly complex too, and does

                if (!IS_ALIGNED(count, bs))
                        count = ALIGN_DOWN(count, bs);
                bcount = count;

which is just a really complicated way to write

                bcount = ALIGN_DOWN(count, bs);
                count = bcount;

so that side if the if-statement knew that it could just align the
count directly, but decided to do that in the least obvious way too.

If 'count' was already aligned, ALIGN_DOWN() does nothing. And masking
is much cheaper than testing and branching.

Not to mention just *simpler*: One case aligns up to the next block
boundary ("include the shared EOF block"), the other case aligns down
("only try to merge full blocks")./

Now the code makes sense, although it's still somewhat subtle in that
the align-down case will also update 'count' (which is returned),
while the EOF code will only set 'bcount' (which is only used for the
overlapping range check) .

But then, when you look at that and understand what's going on, that
in turn then makes *another* thing obvious: the whole existence of
'bcount' is entirely pointless.

Because 'bcount' is only used for that range check, and for the
non-EOF case it's the same as 'count'.

And for the EOF case, doing that alignment is entirely pointless,
since if the in/out inodes are the same, then the file size is going
to be the same, and the EOF block is going to overlap whether bcount
was aligned to block boundary or not.

So the EOF case might as well just have made 'bcount = count' without
any alignment to the next block boundary at all.

And once it does that, now bcount is _always_ the same as count, and
there is no point in having bcount at all.

So after doing all the above simplification, you can then get rid of
'bcount' entirely.

> So, yeah, I think arguing about permissions and API and all that
> stuff is just going completely down the wrong track because it
> doesn't actually address the root cause of the information leak....

I agree that getting this "check the right range" thing right is the
prime thing.

The code being *very* hard to follow and not having any obvious rules
really does not help, though. The permission checks are odd. And the
range checks were odd and inscrutable and buggy to boot.

Yes, I require that people don't break user space. That's the #1 rule
of kernel development.

But that does not mean or imply "write incomprehensible code".

And honestly, I think your suggested patch just makes incomprehensibly
and pointlessly complex code even more so.

Which is why I'm suggesting the real fix is to clean it up, and mover
that EOF offset check to generic_remap_check_len() where it belongs,
and where we already have that comment:

 * ... For deduplication we accept a partial EOF block only if it ends at the
 * destination file's EOF (can not link it into the middle of a file).

but that comment doesn't actually match the code in that function.

In fact, that comment currently doesn't match any existing code at all
(your suggested patch would be that code, but in another place
entirely).

Can we please all agree that this code is too obscure for its own good?

                     Linus
