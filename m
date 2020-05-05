Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5478C1C6220
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgEEUfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEUfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE76C061A0F;
        Tue,  5 May 2020 13:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jW4H8-001jDE-Ib; Tue, 05 May 2020 20:34:46 +0000
Date:   Tue, 5 May 2020 21:34:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove set_fs calls from the coredump code v6
Message-ID: <20200505203446.GZ23230@ZenIV.linux.org.uk>
References: <20200505101256.3121270-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 12:12:49PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series gets rid of playing with the address limit in the exec and
> coredump code.  Most of this was fairly trivial, the biggest changes are
> those to the spufs coredump code.
> 
> Changes since v5:
>  - fix uaccess under spinlock in spufs (Jeremy)
>  - remove use of access_ok in spufs
> 
> Changes since v4:
>  - change some goto names as suggested by Linus
> 
> Changes since v3:
>  - fix x86 compilation with x32 in the new version of the signal code
>  - split the exec patches into a new series
> 
> Changes since v2:
>  - don't cleanup the compat siginfo calling conventions, use the patch
>    variant from Eric with slight coding style fixes instead.
> 
> Changes since v1:
>  - properly spell NUL
>  - properly handle the compat siginfo case in ELF coredumps

Looks good.  Want me to put it into vfs.git?  #work.set_fs-exec, perhaps?
