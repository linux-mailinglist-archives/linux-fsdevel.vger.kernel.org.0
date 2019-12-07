Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29BD1159F6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLGAAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 19:00:40 -0500
Received: from freki.datenkhaos.de ([81.7.17.101]:60256 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfLGAAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:00:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id CB1941E3A93B;
        Sat,  7 Dec 2019 01:00:37 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2hNPWD7c247u; Sat,  7 Dec 2019 01:00:35 +0100 (CET)
Received: from latitude (x4db74696.dyn.telefonica.de [77.183.70.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Sat,  7 Dec 2019 01:00:35 +0100 (CET)
Date:   Sat, 7 Dec 2019 01:00:30 +0100
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
Message-ID: <20191207000015.GA1757@latitude>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude>
 <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019 Dez 06, Linus Torvalds wrote:
> On Fri, Dec 6, 2019 at 1:47 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > This change breaks firefox on my system. I've noticed that some pages
> > doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> > start loading and than stop. Looks like firefox is waiting for some
> > dynamic loading content. I've bisected to this commit, but can't revert
> > because of conflicts.
> 
> Can you check the current git tree, and see if we've fixed it for you.
> There are several fixes there, one being the (currently) topmost
> commit 76f6777c9cc0 ("pipe: Fix iteration end check in
> fuse_dev_splice_write()").
> 
> I _just_ pushed out that one, so check that you get it - it sometimes
> takes a couple of minutes for the public-facing git servers to mirror
> out. I doubt that's the one that would fix firefox, but still..
> 
>                Linus

Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.
Reliable testcase is facebook, where timeline isn't updated with firefox.

-- 
Regards,
  Johannes Hirte

