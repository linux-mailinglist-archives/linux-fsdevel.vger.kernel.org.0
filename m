Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6C58F7F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiHKGxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHKGxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:53:41 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D144333C
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 23:53:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 5BFBBC01F; Thu, 11 Aug 2022 08:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1660200817; bh=nhBlDGBzdW/ef8TRsMdZP7ZIRUnOqyqodEb3SWZVQ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bay5QxYSivGYW+8i3QnLyWyFkH6AUqS8erDhFkSJhUHNMTpAdFGEaPxYd9bjAYYdT
         lqgwC2JlwtXpvuzXeSZn78cLnCPQ1T3oT94ZDWbIjdV2J0M2iw677Wnn3tARdurvIZ
         oUrXXgHH6sbM5RbGfQnXEmfyHbu5h9LAWDCtC3Iuji9h1afI9/qqdgVtlPWT4jdjih
         LWJTjvtAxLndE5BkHf3SYWZSYD+B5qzT6MuT+KE0GejMecg14waCquWVbAijOq0tNr
         WpAb7apE2b7KWTTNB3JeUDOSJiF5i/SAMN0883YEspVA+Uc2lnbU9yyxjKuq8J2kJz
         JaoLZ3H3LufNQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 0029EC009;
        Thu, 11 Aug 2022 08:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1660200816; bh=nhBlDGBzdW/ef8TRsMdZP7ZIRUnOqyqodEb3SWZVQ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyWiPXvYZRGOxODrrkkASrryb0OKgCaqlyKaWB/dmHk7G6KWd4FAzvxndQhBCCqFq
         bpqUMeYP6XCBNw/oczqQ5Bt1qMbZELfY+3tM5U0Jkjaf4Uh4q22dCoSOyM7IUtBoBw
         BPKEKBa17TW1bWdVCcqeRyJQmBJIGr619f5hlMgEhEpCZodIfn94Hak2RA16dyYffV
         nU74kKuo7OQ69z6TT5u/CY9lZ+Iim0P/X+An5u7mzP3GrWyucp1nLUPt70a7YNYyOI
         dfByLVurgikEBuWJDVa2k/4rjsPkZiMRecOZ/ZkGezrYBXmx4VHYmSq+COY+1U4B9P
         KBFfQwfz3zVQg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ce3c10db;
        Thu, 11 Aug 2022 06:53:29 +0000 (UTC)
Date:   Thu, 11 Aug 2022 15:53:14 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>
Subject: Re: INFO: task hung in iterate_supers
Message-ID: <YvSnWrfU7kM4Ia9r@codewreck.org>
References: <000000000000da8a9b0570a29c01@google.com>
 <f00146b5-0a14-ac24-3d7b-3d4deeb96359@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f00146b5-0a14-ac24-3d7b-3d4deeb96359@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Tetsuo Handa wrote on Thu, Aug 11, 2022 at 03:01:23PM +0900:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=154869fd080000
> suggests that p9_client_rpc() is trapped at infinite retry loop

Would be far from the first one, Dmitry brought this up years ago...


> But why does p9 think that Flush operation worth retrying forever?

I can't answer much more than "it's how it was done"; I started
implementing asynchronous flush back when this was first discussed but
my implementation introduced a regression somewhere and I never had time
to debug it; the main "problem" is that we (currently) have no way of
freeing up resources associated with that request if we leave the
thread.
The first step was adding refcounting to requests and this is somewhat
holding up, so all's left now would be to properly clean things up if we
leave this call.

You can find inspiration in my old patches[1] if you'd like to give it a
try:
[1] https://lore.kernel.org/all/20181217110111.GB17466@nautica/T/


Note that there is one point that wasn't discussed back then, but
according to the 9p man page for flush[2], the request should be
considered successful if the original request's reply comes before the
flush reply.
This might be important e.g. with caching enabled and mkdir, create or
unlink with caching enabled as the 9p client has no notion of cache
coherency... So even if the caller itself will be busy dealing with a
signal at least the cache should be kept coherent, somehow.
I don't see any way of doing that with the current 9pfs/9pnet layering,
9pnet cannot call back in the vfs.

[2] https://9fans.github.io/plan9port/man/man9/flush.html


> The peer side should be able to detect close of file descriptor on local
> side due to process termination via SIGKILL, and the peer side should be
> able to perform appropriate recovery operation even if local side cannot
> receive response for Flush operation.

The peer side (= server in my vocabulary) has no idea about processes or
file descriptors, it's the 9p client's job to do any such cleanup.

The vfs takes care of calling the proper close functions that'll end up
in clunk for fids properly, there was a report of fid leak recently but
these are rare enough...

The problem isn't open fids though, but really resources associated with
the request itself; it shouldn't be too hard to do (ignoring any cache
coherency issue), but...

> Thus, why not to give up upon SIGKILL?

... "Nobody has done it yet".


Last year I'd probably have answered that I'm open to funding, but
franlky don't have the time anyway; I'll be happy to review and lightly
test anything sent my way in my meager free time though.

(And yes, I agree ignoring sigkill is bad user experience)

-- 
Dominique
