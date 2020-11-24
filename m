Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC032C28B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgKXNuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:50:46 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39255 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388478AbgKXNp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:57 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BF80658088F;
        Tue, 24 Nov 2020 08:45:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 08:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ICi3xGmyU3rUTgE9Z8EkpSjYA46
        p82e0AHaf1vgqc2E=; b=cKsAEMFFYuOAZzrmzVuS6fDaUdnOlWfJzkxXkSJO9Qe
        4cPiabvCXG6yJevVlNt4UrBnhnM0oAjUCKFFTuiIP7KHkNqf6wAkJ1AGkr4y8R8F
        rshUTX7y/HGl4fDGx++8ZJ8B6vtl63FtXbpf/OVRf2eLIrr6d5Xgprn9bsV5H/hc
        9HhzXpI0HlbN51t3O3r9ZYlv9IOtYlExB/SMGqvdTunWU6XcwAgzBGlIQe2rSTW7
        X7ovYra3a1oSR47nZWVdudMNKQtPD32D8Y836jecithq2pdamn29HzkVmL8scqJb
        ewbh/XND3Cf49DNyIIsIt5so+/Xp0AT9ETHPbNNIZNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ICi3xG
        myU3rUTgE9Z8EkpSjYA46p82e0AHaf1vgqc2E=; b=rE0LoylzT/qyJu2DBs+yai
        0QTR0Lw04fwyDVaPS1SIlsrWZ3D8qygcvuLQ0lTlybxYdeskf/8F8p5IvV4QcJng
        q/1hU9484JxUfjHiQ7wTCfZZpvGcpjBBPrP/v1/XjQCkCieLN7ky9TWOnLfN42M3
        G74z61K75HbJqkrtvsc7O10emOLD9pKCmH2ZE0v63EaN1bs2NKDLdx5vv+4F4sXe
        qruYWcanFZ9LoRjo+8qZuQVKRGIdXmo0kzVF6DfbkMvZUdiH/ITNmdMY9WNO18iC
        HP+d5mUkfTPR/M4TP6ZK/VXAm/rZAl2sCZQ4h2xqevt37qG1w1zz1h8qTKXk6WNg
        ==
X-ME-Sender: <xms:aA69X0Br1YILh_lXkRpx6LvvNOyNIehv8gRzNfgaKgTD0Ir56Adu9g>
    <xme:aA69X2hGMBre_4tf5voL5KWoXk5miZboMJ_r4hRSR0iPmcgRrOeNHNz02iRiH6CaH
    FR43LExlh7_tn0p4Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepuddvkedruddtjedrvdeguddrudeivdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:aA69X3nCD5UHn1DWni0QLB36nA7OKZhoPm3JyIpKOfV1C4IJ25HRZw>
    <xmx:aA69X6zv3RpXS_6aagJ9CwWeSqjxwh94E5ITSOnTET0v3RYeZzlCAA>
    <xmx:aA69X5RYpyxLz0joaGNnnGZ-97JJOnWWSeQhgTIfS8NjKJCfehMkgQ>
    <xmx:bQ69X5wpFI1gmfBKssSD-Pp-ZlRMS83wma-FmpyGoCDeYlEyJzhB7A>
Received: from cisco (unknown [128.107.241.162])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D0B13064AB4;
        Tue, 24 Nov 2020 08:45:06 -0500 (EST)
Date:   Tue, 24 Nov 2020 08:44:59 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        Christoph Hellwig <hch@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 07/39] mount: attach mappings to mounts
Message-ID: <20201124134459.GB52954@cisco>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-8-christian.brauner@ubuntu.com>
 <20201123154719.GD4025434@cisco>
 <20201123162428.GA24807@cisco>
 <20201124123035.hbv4sstyoucht7xp@wittgenstein>
 <20201124133740.GA52954@cisco>
 <20201124134035.2l36avuaqp6gxyum@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124134035.2l36avuaqp6gxyum@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:40:35PM +0100, Christian Brauner wrote:
> On Tue, Nov 24, 2020 at 08:37:40AM -0500, Tycho Andersen wrote:
> > On Tue, Nov 24, 2020 at 01:30:35PM +0100, Christian Brauner wrote:
> > > On Mon, Nov 23, 2020 at 11:24:28AM -0500, Tycho Andersen wrote:
> > > > On Mon, Nov 23, 2020 at 10:47:19AM -0500, Tycho Andersen wrote:
> > > > > On Sun, Nov 15, 2020 at 11:36:46AM +0100, Christian Brauner wrote:
> > > > > > +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> > > > > > +{
> > > > > > +	return mnt->mnt_user_ns;
> > > > > > +}
> > > > > 
> > > > > I think you might want a READ_ONCE() here. Right now it seems ok, since the
> > > > > mnt_user_ns can't change, but if we ever allow it to change (and I see you have
> > > > > a idmapped_mounts_wip_v2_allow_to_change_idmapping branch on your public tree
> > > > > :D), the pattern of,
> > > > > 
> > > > >         user_ns = mnt_user_ns(path->mnt);
> > > > >         if (mnt_idmapped(path->mnt)) {
> > > > >                 uid = kuid_from_mnt(user_ns, uid);
> > > > >                 gid = kgid_from_mnt(user_ns, gid);
> > > > >         }
> > > > > 
> > > > > could race.
> > > > 
> > > > Actually, isn't a race possible now?
> > > > 
> > > > kuid_from_mnt(mnt_user_ns(path->mnt) /* &init_user_ns */);
> > > > WRITE_ONCE(mnt->mnt.mnt_user_ns, user_ns);
> > > > WRITE_ONCE(m->mnt.mnt_flags, flags);
> > > > kgid_from_mnt(mnt_user_ns(path->mnt) /* the right user ns */);
> > > > 
> > > > So maybe it should be:
> > > > 
> > > >          if (mnt_idmapped(path->mnt)) {
> > > >                  barrier();
> > > >                  user_ns = mnt_user_ns(path->mnt);
> > > >                  uid = kuid_from_mnt(user_ns, uid);
> > > >                  gid = kgid_from_mnt(user_ns, gid);
> > > >          }
> > > > 
> > > > since there's no data dependency between mnt_idmapped() and
> > > > mnt_user_ns()?
> > > 
> > > I think I had something to handle this case in another branch of mine.
> > > The READ_ONCE() you mentioned in another patch I had originally dropped
> > > because I wasn't sure whether it works on pointers but after talking to
> > > Jann and David it seems that it handles pointers fine.
> > > Let me take a look and fix it in the next version. I just finished
> > > porting the test suite to xfstests as Christoph requested and I'm
> > > looking at this now.
> > 
> > Another way would be to just have mnt_idmapped() test
> > mnt_user_ns() != &init_user_ns instead of the flags; then I think you
> > get the data dependency and thus correct ordering for free.
> 
> I indeed dropped mnt_idmapped() which is unnecessary. :)

It still might be a nice helper to prevent people from checking the
flags and forgetting that there's a memory ordering issue, though.

> I think we should still use smp_store_release() in mnt_user_ns() paired
> with smp_load_acquire() in do_idmap_mount() thought.

Sounds reasonable.

Tycho
