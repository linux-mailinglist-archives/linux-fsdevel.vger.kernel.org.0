Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA37A6977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjISRQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjISRQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:16:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9BF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 10:15:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bfb17435e4so96446131fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695143753; x=1695748553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/DYm89xKha5hIifMM4jmGfL4V1kBTUvXfrruUWsBFU=;
        b=S7v1r3G0WqI5VNAoekGnMqHbZWD09PfgKrIzmO28mh5iiC/tOl9Kvo6HTTl8LkEYE7
         A0jA76BhKsSPNSpynw+ngteEG2iQeSL7hnSFsGheIRPtGrgIDGgolSDHEszGsIK2eOgG
         GL2mlxPSXjDX/d8Dd2HGX09bYcJV9cz3Zjkr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143753; x=1695748553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/DYm89xKha5hIifMM4jmGfL4V1kBTUvXfrruUWsBFU=;
        b=RukNmG1a6qOBrTMIv/o743YbXPF5DD9jutppI7r1XupOe87/7udLpw/U4/HPlehalQ
         +cb87zY6NA/iYcrxeIHpQVKfXwHlWe1AHdBQfHmrS8w/ymNcx5rZf0XAPQ5lUCBXX/v3
         2y3U8cYam1caKoFCF/aM8MKrULbDks6yW1DeH9GpgEdEJ3euyFRAHKbAGPbhnBmoQNs+
         1Xwj6sek2t2pPcYz/PqBHP9vNlgtMFy7EBo44hVO6hcPg5lpZQXD9ZTLp1+Rv9QuqrE+
         wPvnT3Kas6UVVi5Z3nRurOHXnqbZoRoFUmdOKNkDz3gMEqBMqk0a5hDNiSAHdeN5bp8K
         yAbg==
X-Gm-Message-State: AOJu0Yw11xkBoRPU/IcW2rcmsJfKapa8lUZbmIPRPU0i3VrKi84HyHhn
        k2XFAUGsssOru63Ot+aF0ea/10bExhujNZkzyBYiyLAi
X-Google-Smtp-Source: AGHT+IFbi+8wK7U8ZLg524iZyKVn0Mn1Os8E4m4laG34dgFqWygVCPAB40JpdU9LbZibmKX3GHj0Ew==
X-Received: by 2002:a2e:9f4f:0:b0:2b9:f27f:e491 with SMTP id v15-20020a2e9f4f000000b002b9f27fe491mr47630ljk.42.1695143753630;
        Tue, 19 Sep 2023 10:15:53 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e8799000000b002b9fe77d00dsm2712763lji.93.2023.09.19.10.15.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:15:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c0179f9043so33259881fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 10:15:52 -0700 (PDT)
X-Received: by 2002:ac2:4186:0:b0:501:b97a:9f50 with SMTP id
 z6-20020ac24186000000b00501b97a9f50mr245158lfh.65.1695143751987; Tue, 19 Sep
 2023 10:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230907071801.1d37a3c5@gandalf.local.home> <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <ZQj2SgSKOzfKR0e3@dread.disaster.area> <ZQku4dvmtO56BvCr@casper.infradead.org>
 <ZQnNiTfXK81ZQGEq@mit.edu> <ZQnQMobKwIbBTL9h@casper.infradead.org>
In-Reply-To: <ZQnQMobKwIbBTL9h@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Sep 2023 10:15:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNP7uXWcpGe7Owp-TePruH_S3jH38h=W2-YvbD9Mgz_Q@mail.gmail.com>
Message-ID: <CAHk-=wgNP7uXWcpGe7Owp-TePruH_S3jH38h=W2-YvbD9Mgz_Q@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Sept 2023 at 09:45, Matthew Wilcox <willy@infradead.org> wrote:
>
> What I was trying to say was that if the buffer cache actually supported
> it, large folios and buffer_heads wouldn't perform horribly together,
> unless you had a badly fragmented file.

I think it would work in theory... I don't see a _practical_ example
of a filesystem that would use it, but maybe you had something
specific in mind?

> eg you could allocate a 256kB folio, then ask the filesystem to
> create buffer_heads for it, and maybe it would come back with a list
> of four buffer_heads, the first representing the extent from 0-32kB,
> the second 32kB-164kB, the third 164kB-252kB and the fourth 252kB-256kB.
> Wherever there were physical discontiguities in the file.

That *is* technically something that the buffer cache supports, but I
don't think it has ever been done.

So while it's technically possible, it's never been tested, so it
would almost certainly show some (potentially serious) issues.

And we obviously don't have the helper functions to create such a list
of buffer heads (ie all the existing "grow buffers" just take one size
and create a uniform set of buffers in the page/folio).

                 Linus
