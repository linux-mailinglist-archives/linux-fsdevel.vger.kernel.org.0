Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022858DBB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbiHIQPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244315AbiHIQPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:15:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7752BC6;
        Tue,  9 Aug 2022 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TCKyvEmFiAhK9XgiArHRt1OWtzko0NRAP2rBAjHvp2I=; b=u8LAlHby5grx8OtxaNFkh0rmqe
        xP23bl+TYz37xHzm+kIMr6/cy5Y5uJNgdFmX64u9jQl77RdcxICXs23Q15Rjq7XYa7395vAkKOl+g
        d6DCSVr4YMSjStIaGYoYXOSz2tFMUxW17HkHzxsCuexckRPLsX/lAYlfLWZlG9lc6/ANaH1F18mcK
        czR8tJdAVKttUCHnDnTVcigIxTzwOevl5oFcjA4dcU65P1WS2hV8+yW1x9YKNImEb7KwEN99B4i8o
        D+jJwwGu/U9JAlkSLqSA8jOnCye9JIoQ+XrFH3mcajMnPpFsQGrQUlu2oaEFMu1RMc7wjxt407u0j
        TqD4nvVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLRtB-00FZeU-Ly; Tue, 09 Aug 2022 16:15:29 +0000
Date:   Tue, 9 Aug 2022 17:15:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <YvKIIa+2bTRWXuE+@casper.infradead.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
 <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
 <8735e6qtjc.ffs@tglx>
 <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
 <87v8r1quem.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8r1quem.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 06:00:17PM +0200, Thomas Gleixner wrote:
> On Mon, Aug 08 2022 at 15:43, Linus Torvalds wrote:
> > But the kmap code may be so special that nothing else has _that_
> > particular issue.
> 
> We just want to get rid of kmap_atomic() completely. I'll go and find
> minions.

Be sure to coordinate with Ira & Fabio who are working on this.
