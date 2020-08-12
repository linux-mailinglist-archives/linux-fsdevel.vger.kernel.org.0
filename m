Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07426242522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHLF4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 01:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLF4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:56:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F4C06174A;
        Tue, 11 Aug 2020 22:56:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5jjy-00Dv7D-61; Wed, 12 Aug 2020 05:55:58 +0000
Date:   Wed, 12 Aug 2020 06:55:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
Message-ID: <20200812055558.GP1236603@ZenIV.linux.org.uk>
References: <000000000000f0724405aca59f64@google.com>
 <20200812041518.GO1236603@ZenIV.linux.org.uk>
 <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:29:47PM -0700, Linus Torvalds wrote:
> On Tue, Aug 11, 2020 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > fix breakage in do_rmdir()
> >
> > putname() should happen only after we'd *not* branched to
> > retry, same as it's done in do_unlinkat().
> 
> Looks obviously correct.
> 
> Do you want me to apply directly, or do you have other fixes pending
> and I'll get a pull request?

Not at the moment - I can throw it into #fixes and send a pull request
if you wish, but there won't be anything else in it...
