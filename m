Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA232D4FF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 01:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgLJA6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 19:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbgLJA6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:58:01 -0500
Date:   Wed, 9 Dec 2020 16:57:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607561840;
        bh=SLnGH1+P80XGCfepu6iRSaors5BYzu6Ub1B8QSb7zm0=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m7u8Hb1gLxKmF0sDca5CaQtGltb4U9MM4Nmu3WkdXTuHihRyfTIoaRkK/nsFBvdl2
         pLQ6q28z/nwBRkZeG0365uad6/LZybJNLqsRX4FcUdFRknJCtKUQpsLHY47ghYjBeq
         q3LrBoM0ThYzinTzJjBE+Uq3B5PoxZrJhKGlYBFWhKGtth4hOdHcbEJNgqneQ0/KW0
         w7svau4extRcSYzs6IrjMKo7h8fy7k+FuYoS0VdfHVVTY8TKBZp73o26pnnvsDfeA1
         7hHzX2LNuXPoClCIEuRJQKRCXo6ScDRRecTF0n4oex5/LdMTtjfvAJlto6jNMUoXF9
         Z+POeHkFgWRUQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210005720.GN2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
 <20201209230755.GV7338@casper.infradead.org>
 <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
 <20201210003922.GL2657@paulmck-ThinkPad-P72>
 <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:41:06PM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 4:39 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Like this, then?
> 
> Ack.

Queued with Matthew's Reported-by and your Acked-by, thank you all!

							Thanx, Paul
