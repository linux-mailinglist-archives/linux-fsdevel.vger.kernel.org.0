Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493777A392A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjIQTqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjIQTp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:45:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE47DB
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 12:45:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9f139cd94so513383466b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694979949; x=1695584749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwXgrTVODP9hO74p2+wYHWUrKTpTeCxYeIBxqntxU2Y=;
        b=ItIqoaRm+pUujPZboCggMHlCB4g56i9CMCpGI8BoTcLmzgHidfS5S4T46hKs1fXSi2
         yk8dK2DAVPJEwHPxwcAWUmhaU/MsgnjLn9u9H/bTnDPo7P4ybSWfq+//6rwlf+cjYS0Q
         EO5gwnVsEDltDyAV8yRkJaoWMYc+1zk6rKVUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694979949; x=1695584749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwXgrTVODP9hO74p2+wYHWUrKTpTeCxYeIBxqntxU2Y=;
        b=oHlEJFHrdBwUvWtJCiX+Brf1QUvuKh7KRAqSNag5GIeFUpONggQj7vhnvsoZQpHzBg
         /LpjRBq1/Mw3Y3tk6jouxAMf8pjULt8Ygfy1DvwhnhGmmcSzyCfqRfnYOrhJDZ8Cr2M5
         +wut90hD3Onz9gjTjbIiBk2nKQXKRiGD9xVNmugm2Mr004LSulen4j36D2SjhixPgKon
         DduNfOrumE+FDGLhK2feUY5A4G2+XBs4giFtYII2fVE+lCDUDI4PNGFeHkDfiEbcSG88
         SqMVL4p6+N4wH9vej0dnAyLHKUWSLQFSBGhTNMR64TlW+9oNcTmd5wlT48LTfaHKZGRh
         KPDA==
X-Gm-Message-State: AOJu0YzQDZRfoMqS+xvz0B503CqNU5FK6LpQeJ686J1LExLBBtCkf4wu
        si+7b2N1KO2XhmOgy59a8ABtCX4cf/TX5GUBf40UxU+X
X-Google-Smtp-Source: AGHT+IHsWcAGRGHAeSfl4By7nyUcVHxzzdG2KMyyXUPDyN3qWAhxfmpMWVB9CQ1Yo6MyaI4pPwFKqA==
X-Received: by 2002:a17:907:2ce7:b0:9a5:cab0:b050 with SMTP id hz7-20020a1709072ce700b009a5cab0b050mr6190214ejc.13.1694979949091;
        Sun, 17 Sep 2023 12:45:49 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b009786c8249d6sm5480033ejb.175.2023.09.17.12.45.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 12:45:48 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-401da71b85eso42278665e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 12:45:48 -0700 (PDT)
X-Received: by 2002:a5d:5a1d:0:b0:321:4c7e:45e3 with SMTP id
 bq29-20020a5d5a1d000000b003214c7e45e3mr1311472wrb.11.1694979948004; Sun, 17
 Sep 2023 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <ZPkz86RRLaYOkmx+@dread.disaster.area> <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com> <20230917185742.GA19642@mit.edu>
In-Reply-To: <20230917185742.GA19642@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Sep 2023 12:45:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
Message-ID: <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 17 Sept 2023 at 11:58, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Ext4 uses buffer_heads, and wasn't on your list because we don't use
> sb_bread().

Heh. Look closer at my list. ext4 actually was on my list, and it
turns out that's just because 'sb_bread()' is still mentioned in a
comment.

I did say that my list wasn't really the result of any exhaustive
analysis, but I picked up ext4 by luck.

And yes, ext4 was also one of the reasons I then mentioned that within
the contexts of individual filesystems, it may make sense to deprecate
the use of buffer heads.

Because yes, buffer heads _are_ old and overly simplistic. And I don't
really disagree with people who don't want to extend on them any more.
There are better models.

I think buffer heads are great for one thing, and really one thing
only: legacy use cases.

So I don't think it should be a shock to anybody that most of the
listed filesystems are random old legacy cases (or related to such -
exfat).

But "old" does not mean "bad". And legacy in many ways is worth
cherishing. It needs to become a whole lot more painful than buffer
heads have ever been to be a real issue.

It is in fact somewhat telling that of that list of odds and ends
there was *one* filesystem that was mentioned in this thread that is
actively being deprecated (and happens to use buffer heads).

And that filesystem has been explicitly not maintained, and is being
deprecated partly exactly because it is the opposite of cherished. So
the pain isn't worth it.

All largely for some rather obvious non-technical reasons.

So while reiserfs was mentioned as some kind of "good model for
deprecation", let's be *real* here. The reason nobody wants to have
anything to do with reiserfs is that Hans Reiser murdered his wife.

And I really *really* hope nobody takes that to heart as a good model
for filesystem deprecation.

                Linus
