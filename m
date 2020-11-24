Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C024D2C287F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgKXNmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:42:55 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39477 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387699AbgKXNi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:38:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 03CF5580256;
        Tue, 24 Nov 2020 08:37:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=uv9+67CM32DtT2uoIG78LMUWQ3F
        HveZ09a8+wzAIcWA=; b=U/eyAQRLfVtaavmRhsvScBWLPCTFD0bLl9KkSzkoKyS
        gt5U01e3oaGk/jyy4pFMZ+8ulVBYbhJ8c0He8zilnyxyhkiV0WyFr8llB8DTiWhH
        CDKLtOuXaE67sqCSund2C9w/kOkpoWWv6hUE4hL0OjEgQKAKdCTBviAY/louk6Zb
        N/p6amzuGCcdXyIQk8RsAV+8n2tpAqL7B/aM6y69xAzIOHA9psGEEboJuMCHeAE+
        jVHJwS7X+LCzPXoVa9C5QCzm6ipPQqv387BswVul6TH/6zrMqRVKw6pJGGGydknF
        i1x5wVjity2yfp1j5RaYEuCaa0K36QjODnlRiW/j6KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uv9+67
        CM32DtT2uoIG78LMUWQ3FHveZ09a8+wzAIcWA=; b=LR5KZzQogEx5iAx+dyRx8m
        u5g0sIQeoqpxT0fTAYAc75OENu09NNEM13reHtwurFeIiHJ22QQd8OxFKGcNAzZQ
        ABzWnoaouJveA7adqKYcx/vKlnGaprrJznYk78r9qijnjJx/R6dnismRi2oEf2pp
        Drb2oeFws50oL5Zm6xg+cvf3sBBYivD9fC+E4WreC3TzyFGn4all4cC0hscvkr67
        /3MByqSnDYjaHMTLkvtV+F8lIHSnJTLkZ+0EFPhcAuIQuDuGPnQhAOIbyiH5t7u3
        Y9ibRHo/V84c70JWJLcryClLgpvZEUFj2V1Z2/5deS1r0aYQFgby0kF2SlUq8FJw
        ==
X-ME-Sender: <xms:pwy9X5M_ACo94HsBXsgyImOEMRQQoFdFcq3EtlqTaaxCCd4BFzqDEQ>
    <xme:pwy9X78_s3hE_ElDASGb77BlytsqcsGg0zcssDlDU4Ql_Rt9XrsR3cNACtn39HvvT
    UHmjDHy5ArSpL-fn54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepgeejrddvtddurdeghedrvddtvdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:pwy9X4QWDM2nHwbiJORO4fga02ADLx16tq-gRl9xj2Y-LPG1Ku8VHg>
    <xmx:pwy9X1ua86jK84g-oXIqHQMRutsT-qo273xGyCA0Y2oiXCI5FYQYBg>
    <xmx:pwy9Xxc_jj4nBsFlFglvzIkTQjBqKui0TagunPBlh3tKCIFjbAhe1w>
    <xmx:qwy9X__qsMIWsaR5_7GrnO7gNxT5VH0YIx4udN-wMcwRrXSRAhsoqA>
Received: from cisco (unknown [47.201.45.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id D78B7328005E;
        Tue, 24 Nov 2020 08:37:41 -0500 (EST)
Date:   Tue, 24 Nov 2020 08:37:40 -0500
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
Message-ID: <20201124133740.GA52954@cisco>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-8-christian.brauner@ubuntu.com>
 <20201123154719.GD4025434@cisco>
 <20201123162428.GA24807@cisco>
 <20201124123035.hbv4sstyoucht7xp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124123035.hbv4sstyoucht7xp@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:30:35PM +0100, Christian Brauner wrote:
> On Mon, Nov 23, 2020 at 11:24:28AM -0500, Tycho Andersen wrote:
> > On Mon, Nov 23, 2020 at 10:47:19AM -0500, Tycho Andersen wrote:
> > > On Sun, Nov 15, 2020 at 11:36:46AM +0100, Christian Brauner wrote:
> > > > +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> > > > +{
> > > > +	return mnt->mnt_user_ns;
> > > > +}
> > > 
> > > I think you might want a READ_ONCE() here. Right now it seems ok, since the
> > > mnt_user_ns can't change, but if we ever allow it to change (and I see you have
> > > a idmapped_mounts_wip_v2_allow_to_change_idmapping branch on your public tree
> > > :D), the pattern of,
> > > 
> > >         user_ns = mnt_user_ns(path->mnt);
> > >         if (mnt_idmapped(path->mnt)) {
> > >                 uid = kuid_from_mnt(user_ns, uid);
> > >                 gid = kgid_from_mnt(user_ns, gid);
> > >         }
> > > 
> > > could race.
> > 
> > Actually, isn't a race possible now?
> > 
> > kuid_from_mnt(mnt_user_ns(path->mnt) /* &init_user_ns */);
> > WRITE_ONCE(mnt->mnt.mnt_user_ns, user_ns);
> > WRITE_ONCE(m->mnt.mnt_flags, flags);
> > kgid_from_mnt(mnt_user_ns(path->mnt) /* the right user ns */);
> > 
> > So maybe it should be:
> > 
> >          if (mnt_idmapped(path->mnt)) {
> >                  barrier();
> >                  user_ns = mnt_user_ns(path->mnt);
> >                  uid = kuid_from_mnt(user_ns, uid);
> >                  gid = kgid_from_mnt(user_ns, gid);
> >          }
> > 
> > since there's no data dependency between mnt_idmapped() and
> > mnt_user_ns()?
> 
> I think I had something to handle this case in another branch of mine.
> The READ_ONCE() you mentioned in another patch I had originally dropped
> because I wasn't sure whether it works on pointers but after talking to
> Jann and David it seems that it handles pointers fine.
> Let me take a look and fix it in the next version. I just finished
> porting the test suite to xfstests as Christoph requested and I'm
> looking at this now.

Another way would be to just have mnt_idmapped() test
mnt_user_ns() != &init_user_ns instead of the flags; then I think you
get the data dependency and thus correct ordering for free.

Tycho
