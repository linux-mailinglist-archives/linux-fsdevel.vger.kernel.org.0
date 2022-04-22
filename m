Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA550AF9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 07:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiDVFnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDVFnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:43:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A74ECEA;
        Thu, 21 Apr 2022 22:40:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q75so5145349qke.6;
        Thu, 21 Apr 2022 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAQ2pbLdTfhl30ocu6C+i1NM+Q2M0iWmeznVvUstHlo=;
        b=cUpqEGNJFGjvcc9JuIKeWlJ+JFHIyTAM3pTNyWHFrgX+4i24Jz04tla9xUNfTyCzl5
         bVuFcQlxAE26UsTsQxAN7GpSdben9COgaKlYI/iGO40dFVZKmNe1TqyiUrdJs6ZYjbaz
         s4xxezv+/nxuwd708wIPqKFaoPQPqrp1Ml5ubK4d9F/HTzuaWcHHpMDKbzLDQ4salERd
         LjqebR9MH14fAY3T9gGWCQtIvNvP8GaV2KRJRmUGUNR13OtDCXyIMhTXzscHn6kE6p53
         N08EvVn/iYw3ZG08FCdnMZRB24CoqNB2RN7zDRN4MecNix57jMnprdm7Rd1UFbtqLOD0
         2EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAQ2pbLdTfhl30ocu6C+i1NM+Q2M0iWmeznVvUstHlo=;
        b=tXDMuRQqbH72jq4j19aTfNIvKPAlpEf9NXp+kTVjLgFz9ZJO0X8YqzCA8IIWWRrd88
         1JXs4jjv+kAOkcA3h4w+kWSiO+qkJKxR/huAlU+ae9CBURjallx7pEqcy00bCPXOdcrl
         0nvBmtR3CcN3INxoy0gB4rI2GnQ26MwObGbxECp86t8EVWTDs87VX2b4SL2Ol1iJ75ef
         /TVcbU8dXhT2uJmbOJYfDFW9FZSW54I4OK69BqQ2jnf7x5aw8a088bjLY1S+o9aHBd39
         WFaj+cLYMPdh3RPBmzcSC7U0ilFT7kCQMBfOtTByuLWDMz3GdnteEHUBUOY3XRJCmFcu
         GXcQ==
X-Gm-Message-State: AOAM533CGD85LWuLKKv0jp7ozjYUYSg5IDNhh8fBpsmHV9KLOqNqKKlt
        qdzrafGosRJwmemlAG8m3g==
X-Google-Smtp-Source: ABdhPJzeaQoIWaOjnQOFgQA3ulm2DVNPu04DBzQixKkQFqrNtoHzoLH3h5SHG6932KbYJ0RP8l+S2Q==
X-Received: by 2002:a37:bc1:0:b0:69d:ea33:7f2e with SMTP id 184-20020a370bc1000000b0069dea337f2emr1638627qkl.74.1650606017616;
        Thu, 21 Apr 2022 22:40:17 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b11-20020ac85bcb000000b002f35ab13e36sm229485qtb.51.2022.04.21.22.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:40:16 -0700 (PDT)
Date:   Fri, 22 Apr 2022 01:40:15 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <YmI/v35IvxhOZpXJ@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422052208.GA10745@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:22:08AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 22, 2022 at 01:14:48AM -0400, Kent Overstreet wrote:
> > Christoph, you have no problem making more work for me but I can't even get you
> 
> I think you are misunderstanding this.  You are trying to create more
> work for people maintainaing the kernel by creating duplicate
> infrastructure.  The burden is always on the submitter.
>
> > to look at the bugs you introuduce in your refactorings that I report to you.
> > 
> > Still waiting on you to look at oops you introduced in bio_copy_data_iter...
> 
> I'm not sure why I shoud care about your out of tree code making
> assumptions about block layer helpers.

Wasn't just bcachefs, it affected bcache too, as Coly also reported. And I wrote
that code originally (and the whole fucking modern bvec iter infrastracture,
mind you) so please don't lecture me on making assumptions on block layer
helpers.

Here's the thing, I think you and I have somewhat different approaches to
engineering. Personaly, I find good engineering to be about tradeoffs, not
absolutism, and not letting perfect be the enemy of good.

So I'm honestly not super eager to start modifying tricky arch code that I can't
test, and digging into what looked like non trivial interactions between the way
the traceing code using seq_buf (naturally, given that's where it originates).

I like to push out code that I have high confidence in, and the patch series I
pushed out I do have confidence in, given that it's been in use for awhile and
it's well tested in my tree.

Now yes, I _could_ do a wholesale conversion of seq_buf to printbuf and delete
that code, but doing that job right, to be confident that I'm not introducing
bugs, is going to take more time than I really want to invest right now. I
really don't like to play fast and loose with that stuff.

And the reason getting this from you really irks me is that _practically every
single time_ I trip over a something nasty when I rebase and I git bisect or
blame it's something you did. I don't even bother reporting most of them to you.

I don't want to be calling you out for the work you do because on the whole it's
good and appreciated - I saw the patch series go by getting request_queue out of
filesystem land, I'm happy that's getting done. But I've also seen the stuff you
submit get _really_ churny at times for no good reason, and some really nasty,
data corrupting bugs go by, so...

Please chill out a bit if I'm not super in a rush to do it your way.
