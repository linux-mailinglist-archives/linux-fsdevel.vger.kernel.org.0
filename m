Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5E19BA82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgDBCwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 22:52:41 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36329 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbgDBCwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:52:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id A44AD679;
        Wed,  1 Apr 2020 22:52:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Apr 2020 22:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        h7ECITCKfNZMx8k2mxEusSlerH4FqS6pM+JOAcsVU9w=; b=HncnaXzxp07w5tFl
        gnU6d6fR74L+X606QoPnWwoQm93HnfTUw+g9r7uWRImUy98GPXTCe85aiBPJjZTt
        Jo9/KHn4chsLHC9ss30kDAhPMKypg2XzX68wgh3jsQfjnLTXnIRNN1/vCqLn2IwW
        BrguiyXF0bRIIm/4yw1UB48Br98QFdV2QWgWnxCGu7n8+Bt9FDmlMnTDVPFtKP9/
        ynx14PW63H/QBL8fM9KCWE8fxdJg9QeYPNG+mekemc/rjvNZ/scu8c23T1jlQQi/
        oWbJ9Cf6sNrMd9ltpSoNjqg719NYSDPyLTtxUa/LDx1q39B5UCOJ9DyUvuWNpV3h
        w0qlPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=h7ECITCKfNZMx8k2mxEusSlerH4FqS6pM+JOAcsVU
        9w=; b=UUnDipPDjurA/G0QzCXe5RkWhjy/3uCnNKWYhiBiQPgtfgAAhHl/X+r3y
        ub/LgNfdLHMvPMLmlSBJZHlljt3XOwdzgs8BO6SlEXb5b4LZKaJeU+RR/Hif6xLO
        yPF1kMtYhCV1IoKsgH3aQsYIPOuyCPOWt6D0FzJK1BMhvlyhlZq9PdweEqX1Zg+d
        kYizbF9G+sA63dinVYakCr5RVUV5Wr7Y85/zO2dpL0Qt3XxQ71UY3rqEI16H9dPH
        QpykNrJeFn4UN4lEP3urw2o3sDQAIVr3PEvf80tPPn5Ov/ST9drkcKvOJh6O924F
        UPEhe8y+3qpIBnqXKb5sFsdWf2EmQ==
X-ME-Sender: <xms:dlOFXk4j4_Xlu6PGqEKa9G4_TMKZ-u0bB90ZGQsfPW5KdCDBuH_26g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    duieeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:dlOFXth3MGe_1TkPMUIN0VgLVQcCBqxunXyFLhK5PtSCaLO4mFuRxA>
    <xmx:dlOFXhES2NQH1Xrh22TlD-njWhvXE9-aUb4iazHyFbR2ABvH6b91Dw>
    <xmx:dlOFXjS1c7m4056NTjYshnTKr12dvnf5aW_NKfh5-adQ9cWqlDbvkg>
    <xmx:d1OFXjo9ND_gp9-PsHbEN4GnxYJrKk4Np-Ks6SnPrP2ViIfEQejePxvPzsw>
Received: from mickey.themaw.net (unknown [118.209.166.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id F37B9306CD58;
        Wed,  1 Apr 2020 22:52:31 -0400 (EDT)
Message-ID: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Date:   Thu, 02 Apr 2020 10:52:27 +0800
In-Reply-To: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
         <1445647.1585576702@warthog.procyon.org.uk>
         <2418286.1585691572@warthog.procyon.org.uk>
         <20200401144109.GA29945@gardel-login>
         <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
         <2590640.1585757211@warthog.procyon.org.uk>
         <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-04-01 at 18:40 +0200, Miklos Szeredi wrote:
> On Wed, Apr 1, 2020 at 6:07 PM David Howells <dhowells@redhat.com>
> wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > I've still not heard a convincing argument in favor of a syscall.
> > 
> > From your own results, scanning 10000 mounts through mountfs and
> > reading just
> > two values from each is an order of magnitude slower without the
> > effect of the
> > dentry/inode caches.  It gets faster on the second run because the
> > mountfs
> > dentries and inodes are cached - but at a cost of >205MiB of
> > RAM.  And it's
> > *still* slower than fsinfo().
> 
> Already told you that we can just delete the dentry on dput_final, so
> the memory argument is immaterial.
> 
> And the speed argument also, because there's no use case where that
> would make a difference.  You keep bringing up the notification queue
> overrun when watching a subtree, but that's going to be painful with
> fsinfo(2) as well.   If that's a relevant use case (not saying it's
> true), might as well add a /mnt/MNT_ID/subtree_info (trivial again)
> that contains all information for the subtree.  Have fun implementing
> that with fsinfo(2).

Forgive me for not trawling through your patch to work this out
but how does a poll on a path get what's needed to get mount info.

Or, more specifically, how does one get what's needed to go directly
to the place to get mount info. when something in the tree under the
polled path changes (mount/umount). IIUC poll alone won't do subtree
change monitoring?

Don't get me wrong, neither the proc nor the fsinfo implementations
deal with the notification storms that cause much of the problem we
see now.

IMHO that's a separate and very difficult problem in itself that
can't even be considered until getting the information efficiently
is resolved.

Ian

