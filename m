Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32973264B43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgIJR3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:29:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:45363 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgIJRYJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:24:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08AHFhOX006110;
        Thu, 10 Sep 2020 12:15:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 08AHFgui006109;
        Thu, 10 Sep 2020 12:15:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 10 Sep 2020 12:15:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Christophe Leroy'" <christophe.leroy@csgroup.eu>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: remove the last set_fs() in common code, and remove it for x86 and powerpc v3
Message-ID: <20200910171542.GL28786@gate.crashing.org>
References: <20200903142803.GM1236603@ZenIV.linux.org.uk> <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com> <20200909184001.GB28786@gate.crashing.org> <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com> <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com> <186a62fc-042c-d6ab-e7dc-e61b18945498@csgroup.eu> <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com> <5050b43687c84515a49b345174a98822@AcuMS.aculab.com> <20200910152030.GJ28786@gate.crashing.org> <18fdbaeacba349a0a8bf7568f709e991@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18fdbaeacba349a0a8bf7568f709e991@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:31:53PM +0000, David Laight wrote:
> > > 	asm volatile ("" : "+r" (eax));
> > > 	// So here eax must contain the value set by the "xxxxx" instructions.
> > 
> > No, the register eax will contain the value of the eax variable.  In the
> > asm; it might well be there before or after the asm as well, but none of
> > that is guaranteed.
> 
> Perhaps not 'guaranteed', but very unlikely to be wrong.
> It doesn't give gcc much scope for not generating the desired code.

Wanna bet?  :-)

Correct is correct.  Anything else is not.


Segher
