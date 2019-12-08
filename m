Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E402116341
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 18:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLHR4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 12:56:13 -0500
Received: from freki.datenkhaos.de ([81.7.17.101]:39002 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLHR4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:56:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 096E11E4F289;
        Sun,  8 Dec 2019 18:56:10 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fETea11isuRw; Sun,  8 Dec 2019 18:56:07 +0100 (CET)
Received: from latitude (x590cb2df.dyn.telefonica.de [89.12.178.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Sun,  8 Dec 2019 18:56:07 +0100 (CET)
Date:   Sun, 8 Dec 2019 18:56:02 +0100
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
Message-ID: <20191208175602.GA1844@latitude>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude>
 <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
 <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019 Dez 06, Linus Torvalds wrote:
> On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.
> 
> Ok, we'll continue looking.
> 
> That said, your version string is strange.
> 
> Commit 347f56fb3890 should be  "v5.4.0-13174-g347f56fb3890", the fact
> that you have "11505" confuses me.
> 
> The hash is what matters, but I wonder what is going on that you have
> the commit count in that version string so wrong.
> 
>                    Linus

Yes, something got messed up here. After last pull, git describe says:

drm-next-2019-12-06-11662-g9455d25f4e3b

whereas with a fresh cloned repo I get:

v5.4-13331-g9455d25f4e3b

I assume the later is right. With this version the bug seems to be
fixed, regardless of the commit count. Tested with different websites
and firefox works as expected again.


-- 
Regards,
  Johannes Hirte

