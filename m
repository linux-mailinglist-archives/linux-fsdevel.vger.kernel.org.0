Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF27025A75B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBIJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 04:09:15 -0400
Received: from verein.lst.de ([213.95.11.211]:58217 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBIJO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:09:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8A9467373; Wed,  2 Sep 2020 10:09:11 +0200 (CEST)
Date:   Wed, 2 Sep 2020 10:09:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <20200902080911.GA26677@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-6-hch@lst.de> <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com> <20200829092406.GB8833@lst.de> <202009011156.0F49882@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009011156.0F49882@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:57:37AM -0700, Kees Cook wrote:
> On Sat, Aug 29, 2020 at 11:24:06AM +0200, Christoph Hellwig wrote:
> > On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> > > On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > Once we can't manipulate the address limit, we also can't test what
> > > > happens when the manipulation is abused.
> > > 
> > > Just remove these tests entirely.
> > > 
> > > Once set_fs() doesn't exist on x86, the tests no longer make any sense
> > > what-so-ever, because test coverage will be basically zero.
> > > 
> > > So don't make the code uglier just to maintain a fiction that
> > > something is tested when it isn't really.
> > 
> > Sure fine with me unless Kees screams.
> 
> To clarify: if any of x86, arm64, arm, powerpc, riscv, and s390 are
> using set_fs(), I want to keep this test. "ugly" is fine in lkdtm. :)

And Linus wants them gone entirely, so I'll need a stage fight between
the two of you.  At least for this merge window I'm only planning on
x86 and power, plus maybe riscv if I get the work done in time.  Although
helper from the maintainers would be welcome.  s390 has a driver that
still uses set_fs that will need some surgery, although it shouldn't
be too bad, but arm will be a piece of work.  Unless I get help it will
take a while.
