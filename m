Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08C7AD4A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIYJiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIYJiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:38:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7373C9C
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkLcGwG2sfMkHkxG4/noaW4YYdP1mkNN6we6wlmfT00=; b=LaICF3w3iIyyZUNhfYP4OPuj+K
        4V7sR3px/7x3riN+8pPbbbeQh2W6psT4kJ4M1Qs69/bjUoHPIlmo4P6JOuhpjUc+9ioZtgQ0Ve+MJ
        +vBLbe9kpLUzqK9EHx5LTCK2lyVTjAE2pgj6wxodrixYc/t1xXZvgMeXLkYR7RtEpjMhPVBSYe7XI
        0RanCTpizHSRn+YCwgtv9dOn1L+dMeF7Th630EWuBdwnxG+Qh+U9WFBBeCDnii3GSPzWOE3nwvRM9
        npJ6wdrpYzEjEhU1+LYJ/GEWIZvQbPz0KzK9hvKvVKhsfCipddqaPnDm6wX5p/u9m7EXt5X3/p4Pz
        vAvupWuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qki35-00Ds7v-1M;
        Mon, 25 Sep 2023 09:38:39 +0000
Date:   Mon, 25 Sep 2023 02:38:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZRFVH3iJX8scrFvn@infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> I haven't actually heard a good reason to really stop supporting
> these. Using some kind of user-space library is ridiculous. It's *way*
> more effort than just keeping them in the kernel. So anybody who says
> "just move them to user space" is just making things up.
> 
> The reasons I have heard are:
> 
>  - security
> 
> Yes, don't enable them, and if you enable them, don't auto-mount them
> on hot-pkug devices. Simple. People in this thread have already
> pointed to the user-space support for it happening.

Which honetly doesn't work, as the status will change per kernel
version.  If we are serius about it we need proper in-kernel flagging.

>  - syzbot issues.
> 
> Ignore them for affs & co.

And still get spammed?  Again, we need some good common way to stop
them even bothering instead of wasting their and our resources.

> 
>  - "they use the buffer cache".
> 
> Waah, waah, waah. The buffer cache is *trivial*. If you don't like the
> buffer cache, don't use it. It's that simple.

FYI, IFF this is a response to my original mail and not some of the
weirder ideas floating around on the lists, I've never said remove the
buffer cache, quite to the contrary.  What is problematic, and what I
want to go away is the buffer_head based helpers for while I/O.  Which
unlike using buffer_heads for the actual metadata buffer_cache has
very useful replacements already.

