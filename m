Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E317A8C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCEPXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 10:23:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgCEPXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:23:46 -0500
Received: from b2b-5-147-251-51.unitymedia.biz ([5.147.251.51] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j9sLc-0006Xj-1j; Thu, 05 Mar 2020 15:23:40 +0000
Date:   Thu, 5 Mar 2020 16:23:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200305152339.3uitms2pua5wzzed@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <8736arnel9.fsf@oldenburg2.str.redhat.com>
 <20200302121959.it3iophjavbhtoyp@wittgenstein>
 <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
 <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
 <20200305141154.e246swv62rnctite@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305141154.e246swv62rnctite@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 01:11:54AM +1100, Aleksa Sarai wrote:
> On 2020-03-02, Florian Weimer <fweimer@redhat.com> wrote:
> > * Christian Brauner:
> > > One difference to openat() is that openat2() doesn't silently ignore
> > > unknown flags. But I'm not sure that would matter for iplementing
> > > openat() via openat2() since there are no flags that openat() knows about
> > > that openat2() doesn't know about afaict. So the only risks would be
> > > programs that accidently have a bit set that isn't used yet.
> > 
> > Will there be any new flags for openat in the future?  If not, we can
> > just use a constant mask in an openat2-based implementation of openat.
> 
> There is one being proposed at the moment as part of the compressed
> read/write work[1].

That work predates openat2() having been merged so there's an argument
to be made that it should be on top of openat2() imho. But that assumes
people agree with
https://lore.kernel.org/linux-fsdevel/3607683.1583419401@warthog.procyon.org.uk/T/#m58c1b6c2697e72e7b42bdbea248178ed31b7d787
and I haven't heard anything in either direction...

Christian
