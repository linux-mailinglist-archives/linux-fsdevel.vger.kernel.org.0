Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625EB797D77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjIGUjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIGUjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:39:53 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8F1BCB
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 13:39:50 -0700 (PDT)
Date:   Thu, 7 Sep 2023 16:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694119188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQGQTowjqU+8WontTn7qGPYrYPgcE7gPYsf2gTPImVU=;
        b=pS3Eu7i0s+dGGpFi5A4Q2ba1YcAMHfzMatlBiEKZuHYsEvt6i8mNCVsv9HX9WF1xXrV2uJ
        LB0YNQveRX+ufr/H/R1rzb3Ia+hpLGUUk9w7/rF4CVEw+XIroF5uOQ1KqhWoPACYgyKCeC
        ydIviSEa4WAkDzXhEmg6rXWraja+5sQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230907203946.xbtd2ddp3wztcffz@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <20230906222847.GA230622@dev-arch.thelio-3990X>
 <202309061658.59013483F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309061658.59013483F@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:03:06PM -0700, Kees Cook wrote:
> On Wed, Sep 06, 2023 at 03:28:47PM -0700, Nathan Chancellor wrote:
> > Hi Kent,
> > 
> > On Sat, Sep 02, 2023 at 11:25:55PM -0400, Kent Overstreet wrote:
> > > here's the bcachefs pull request, for 6.6. Hopefully everything
> > > outstanding from the previous PR thread has been resolved; the block
> > > layer prereqs are in now via Jens's tree and the dcache helper has a
> > > reviewed-by from Christain.
> > 
> > I pulled this into mainline locally and did an LLVM build, which found
> > an immediate issue. It appears the bcachefs codes uses zero length
> 
> It looks like this series hasn't been in -next at all? That seems like a
> pretty important step.
> 
> Also, when I look at the PR, it seems to be a branch history going
> back _years_. For this kind of a feature, I'd expect a short series of
> "here's the code" in incremental additions (e.g. look at the x86 shstk
> series), not the development history from it being out of tree -- this
> could easily lead to ugly bisection problems, etc.

Chris already commented on this, but - we really want the full history
available, that's important context for anyone working on the code going
forward. Brian was just mentioning digging through the history for
context in the meeting last Tuesday, and I've been going to a lot of
effort to make sure every commit builds and runs.
