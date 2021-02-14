Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746A231B2BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 22:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBNVTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBNVTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:19:04 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C7C061574;
        Sun, 14 Feb 2021 13:18:24 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBOmQ-00E13n-Po; Sun, 14 Feb 2021 21:18:10 +0000
Date:   Sun, 14 Feb 2021 21:18:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] sendfile fixes
Message-ID: <YCmTkg0vJWc8Ncam@zeniv-ca.linux.org.uk>
References: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
 <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 11:35:36AM -0800, Linus Torvalds wrote:

> Just to clarify: this says "fixes", but I get the feeling that you
> meant for me to pull tomorrow in the 5.12 merge window?
> 
> I like the patches, but they don't seem to be anything hugely urgent.
> They should make "sendfile to pipe" more efficient, but the current
> hack is _workable_ (and not any worse than what we historically did)
> even if it's not optimal.
> 
> Right?

Yes.  It allows to drop the current hack, but it's not urgent.

> Oh, and it looks like the first line of the commit message of
> 313d64a35d36 ("do_splice_to(): move the logics for limiting the read
> length in") got truncated somehow..

	Offense against style, actually - preposition torn from object and
moved to the very end of sentence...  "[splice] move the logics for limiting
the read length into do_splice_to()" would probably be better.
