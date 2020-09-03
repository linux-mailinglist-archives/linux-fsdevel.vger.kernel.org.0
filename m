Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10DA25C29A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgICOaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:30:15 -0400
Received: from verein.lst.de ([213.95.11.211]:38062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgICOaM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:30:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A8FCA67357; Thu,  3 Sep 2020 16:30:04 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:30:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Message-ID: <20200903143003.GA17260@lst.de>
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142803.GM1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:28:03PM +0100, Al Viro wrote:
> On Thu, Sep 03, 2020 at 04:22:28PM +0200, Christoph Hellwig wrote:
> 
> > Besides x86 and powerpc I plan to eventually convert all other
> > architectures, although this will be a slow process, starting with the
> > easier ones once the infrastructure is merged.  The process to convert
> > architectures is roughtly:
> > 
> >  (1) ensure there is no set_fs(KERNEL_DS) left in arch specific code
> >  (2) implement __get_kernel_nofault and __put_kernel_nofault
> >  (3) remove the arch specific address limitation functionality
> 
> The one to really watch out for is sparc; I have something in that
> direction, will resurrect as soon as I'm done with eventpoll analysis...
> 
> I can live with this series; do you want that in vfs.git#for-next?

Either that or a separate tree is fine with me.  It would be good to
eventually have a non-rebased stable tree so that other arch trees
can work from it, though.
