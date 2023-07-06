Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B874A240
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGFQeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGFQeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:34:09 -0400
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F21703
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 09:34:08 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688661246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBn/mkChlZxb0dNmfL30mgqBPNGEmA84yaKWnN34ndQ=;
        b=emVQYAm5Dv/NFKC7yFbnHt6GKAd2RVpbw8V+2KvJCDKSTIrZDk/KnM16DbgHerM8iKVUYG
        cRgIqPD65wsytvdmEkjdc8uV1bHF+gFEpL6cx1jN/vTRl36Bw7K0WaYZpntpZCEoyI34Vn
        slIsd4IuwHS9WwMG1xSFve28Hr9C1+Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706163403.4w5iyeu6n6ug4x2p@moria.home.lan>
References: <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
 <20230629-fragen-dennoch-fb5265aaba23@brauner>
 <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
 <20230630-aufwiegen-ausrollen-e240052c0aaa@brauner>
 <20230706152059.smhy7jdbim4qlr6f@moria.home.lan>
 <48d69cae-902a-a746-e73b-a5b8fdf694b4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d69cae-902a-a746-e73b-a5b8fdf694b4@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 10:26:34AM -0600, Jens Axboe wrote:
> On 7/6/23 9:20?AM, Kent Overstreet wrote:
> >> My earlier mail clearly said that io_uring can be changed by Jens pretty
> >> quickly to not cause such test failures.
> > 
> > Jens posted a fix that didn't actually fix anything, and after that it
> > seemed neither of you were interested in actually fixing this. So
> > based on that, maybe we need to consider switching fstests back to AIO
> > just so we can get work done...
> 
> Yeah let's keep misrepresenting... I already showed how to hit this
> easily with aio, and you said you'd fix aio. But nothing really happened
> there, unsurprisingly.

Jens, your test case showing that this happens on aio too was
appreciated: I was out of town for the holiday weekend, and I'm just now
back home catching up and fixing your test case is the first thing I'm
working on.

But like I said, this wasn't causing test failures when we were using
AIO, it's only since we switched to io_uring that this has become an
issue, and I'm not the only one telling you this is an issue, so ball
very much in your court.

> You do what you want, as per usual these threads just turn into an
> unproductive (and waste of time) shit show. Muted on my end from now on.

Ok.
