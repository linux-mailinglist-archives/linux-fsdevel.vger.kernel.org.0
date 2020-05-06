Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9701C68F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEFGbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 02:31:38 -0400
Received: from verein.lst.de ([213.95.11.211]:39193 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgEFGbi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 02:31:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22E0A68C4E; Wed,  6 May 2020 08:31:35 +0200 (CEST)
Date:   Wed, 6 May 2020 08:31:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs calls from the coredump code v6
Message-ID: <20200506063134.GA11391@lst.de>
References: <20200505101256.3121270-1-hch@lst.de> <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com> <877dxqgm7x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dxqgm7x.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 03:28:50PM -0500, Eric W. Biederman wrote:
> We probably can.   After introducing a kernel_compat_siginfo that is
> the size that userspace actually would need.
> 
> It isn't something I want to mess with until this code gets merged, as I
> think the set_fs cleanups are more important.
> 
> 
> Christoph made some good points about how ugly the #ifdefs are in
> the generic copy_siginfo_to_user32 implementation.

Take a look at the series you are replying to, the magic x86 ifdefs are
entirely gone from the common code :)
