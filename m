Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528C72B3E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFKUHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjFKUHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:07:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CE99;
        Sun, 11 Jun 2023 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Frvdbn/oC6N6awyzuk0N+5XMWltEJKTuOjEd/jd21A=; b=P1NwCL+9z1iDjLenb9/8csDYvD
        Pjd71+iibDfevuvzLA4SEFDLzS1pFcDbTFi/Nvg+8el6dzelQugFIZQ5poPZbj553EzAnHgl/m5e6
        lHYC0B9RnsC5szIApaslelLY9rLbne8U0CYqTMJTDzx+DRh6dTGfOPHJxatpBUHF/XxHkSWhQQb2z
        rR7FW9NDktT/50g2wgqZzx7WoKCH+ehhQk5R7BKmboefRfSYyaFBlVrtqjNFSelvKgNYcx7VQJaJG
        7tgLoB3K8j+oI0LSt8bXh//XxSZVhKedpDezwWEWJ/XHnoIIjhIwsPRiESRcdAzmOiDO5a/6xjkra
        cskvR02A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8RLO-001goP-Q2; Sun, 11 Jun 2023 20:07:22 +0000
Date:   Sun, 11 Jun 2023 21:07:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <ZIYpetKYwTH7TBWv@casper.infradead.org>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
 <87edmhok1h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edmhok1h.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> >> From: Mao Zhu <zhumao001@208suo.com>
> >> 
> >> Delete duplicated word in comment.
> >
> > On what function?
> 
> Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
> contributors into the ground?  It appears I do.  So:
> 
> Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
> changelog is fine.  We absolutely do not need you playing changelog cop
> and harassing contributors over this kind of thing.

Amen.

> >> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> >
> > You're carrying someone else's patch, so besides SoB from original
> > author, you need to also have your own SoB.
> 
> This, instead, is a valid problem that needs to be fixed.

I mean ... yes, technically, it does.  But it's a change that deletes
a word in a comment.  Honestly, I'd take the patch without any kind of
sign-off.  It doesn't create any copyright claim, which is the purpose
of the DCO.
