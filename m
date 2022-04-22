Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F550B039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 08:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358725AbiDVGJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 02:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDVGJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:09:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCD13C49C;
        Thu, 21 Apr 2022 23:06:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x24so4863831qtq.11;
        Thu, 21 Apr 2022 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nlwTOZ4YA/xOCHbD8FxUxJ0ALmhsKy74mVaGByAE/8I=;
        b=ioNzbL2gm0qTBiumcIbqb1lW02l7rCuVIZkqQHRgPSCHyQ/iSFaBnqgC6hI6k9OMaO
         ySyyLvesbK5A1AMxTg1+fGrgu41/+Q9bl340D8UifBxdRbgQkdDdwA7p3KSi+yZ8U4YT
         nItp/MoET7VAA/G5Gtrd1jxeCOqLEweeplauXFCUKCT7voyCZtIpeli9W38SnbD8T0P8
         Y1EQRAgrpSdsXUodnvkmaFiUzfeDmil8vEemhX0uowrKcUBQqa2FfIeuK7b0X10HHOvR
         PAbKrmBTK4rdhbTXM+rd0HpMige7E/RAMaA69UwRSxwnOW/0uTMdflGU/ftaz0rGuc/n
         d4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlwTOZ4YA/xOCHbD8FxUxJ0ALmhsKy74mVaGByAE/8I=;
        b=y9956ZBlcAUac7OQ/UwNcqEYOr11/lG1XVvIbB1HrCwDeRVlZOg1tU9uw+WaL1IEOC
         Tlp5r4Ir/Gr+Bs8u59GksES7H7DuxQQhbPBNQe+hYj1QmIBCxG5Z2qc+h9qd9Hp6JTOm
         k3DBXy/X6i54RRGCNqkPpYq43Ho5bPlTGK4LhiGMh5w3Ef7Q/Tq2DD8E3NoQz/SAPd4i
         jk4lkCFqRdmntXR5BNBLUNfRfEB4J58axrItrfc3A+CTiKXxN73P3UVlFZywvbVYbThW
         m28ejMY94jj5fyz2HxwPLP8W0hsPwM7m62ifqUE7lZkaAxreii9pfznFyegwN8i7SHmk
         +uqw==
X-Gm-Message-State: AOAM530j0iR3rD32BLEmNQK5vXGnOQMXOaK723XZzUA0R38yGtiG5M5F
        GHLBYl8aSTXD2MvVIyufalkElsFJM/+p
X-Google-Smtp-Source: ABdhPJxBx0pVVOt3R/hgC5qhlwNRAyGX6fTiF6NzSOaDtaiiJfoWmXioOxpYYXOgp3DOPsKkZrO9wA==
X-Received: by 2002:ac8:5a81:0:b0:2f1:f20d:173a with SMTP id c1-20020ac85a81000000b002f1f20d173amr2073685qtc.686.1650607607411;
        Thu, 21 Apr 2022 23:06:47 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bk18-20020a05620a1a1200b00680c72b7bf4sm564935qkb.93.2022.04.21.23.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:06:46 -0700 (PDT)
Date:   Fri, 22 Apr 2022 02:06:44 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <YmJF9J5cCsELY++y@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422055214.GA11281@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422055214.GA11281@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:52:14AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 22, 2022 at 01:40:15AM -0400, Kent Overstreet wrote:
> > Wasn't just bcachefs, it affected bcache too, as Coly also reported.
> 
> Well, I've not seen a good bug report for that, but I'd gladly look at it.

Thanks. It's been awhile but I'll see if I can dig up the original bug report
tomorrow.

> > And I wrote
> > that code originally (and the whole fucking modern bvec iter infrastracture,
> > mind you) so please don't lecture me on making assumptions on block layer
> > helpers.
> 
> Well, most of what we have is really from Ming.  Because your original
> idea was awesome, but the code didn't really fit.  Then again I'm not
> sure why this even matters.

Didn't fit how? And Ming extended it to multipage bvecs based on my proposal.

> I'm also relly not sure why you are getting so personal.  

Put yourself my shoes, I've honestly found you to be hardheaded and exceedingly
difficult to work with for a very long time.

But I'll bite my tongue for now, because if you'll start listening to bug
reports that will go a long way towards easing things, and we've got LSF coming
up so maybe we can hash things out over beers.

> > Now yes, I _could_ do a wholesale conversion of seq_buf to printbuf and delete
> > that code, but doing that job right, to be confident that I'm not introducing
> > bugs, is going to take more time than I really want to invest right now. I
> > really don't like to play fast and loose with that stuff.
> 
> Even of that I'd rather see a very good reason first.  seq_bufs have been
> in the kernel for a while and seem to work fine.  If you think there are
> shortcomings please try to improve it, not replace or duplicate it.
> Sometimes there might be a good reason to replace exiting code, but it
> rather have to be a very good reason.

When the new version is semantically different from the old version it makes it
a lot easier to deal with the merge conflicts later when forward/backporting
stuff by giving the new version a new name.

Anyways, I'll have a chat with Steven Rostedt about it since I believe he wrote
the original code.
