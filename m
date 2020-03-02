Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABD6175AF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCBMze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:55:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgCBMze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:55:34 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8kbc-0005MT-1m; Mon, 02 Mar 2020 12:55:32 +0000
Date:   Mon, 2 Mar 2020 13:55:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302125531.7z2viveb3zxhqkuj@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <8736arnel9.fsf@oldenburg2.str.redhat.com>
 <20200302121959.it3iophjavbhtoyp@wittgenstein>
 <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
 <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:42:50PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > One difference to openat() is that openat2() doesn't silently ignore
> > unknown flags. But I'm not sure that would matter for iplementing
> > openat() via openat2() since there are no flags that openat() knows about
> > that openat2() doesn't know about afaict. So the only risks would be
> > programs that accidently have a bit set that isn't used yet.
> 
> Will there be any new flags for openat in the future?  If not, we can
> just use a constant mask in an openat2-based implementation of openat.

From past experiences with other syscalls I would expect that any new
features would only be available through openat2().
The way I see it in general is that a revised version of a syscall
basically deprecates the old syscall _wrt to new features_, i.e. new
features will only be available through the revised version unless there
are very strong reasons to also allow it in the old version (security
bug or whatever).
(But I don't want to be presumptuous here and pretend I can make any
definiteve statement. Ultimately it's up to the community, I guess. :))

Christian
