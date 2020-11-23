Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9862C106B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgKWQbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 11:31:34 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48269 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730953AbgKWQZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:25:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 74EC3580370;
        Mon, 23 Nov 2020 11:24:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Nov 2020 11:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dCNTwpbrygdlSzzc2FSEUktQs4G
        /tw8OZWUghu6D3ME=; b=mvdckROrTihded/w+9kbPJNVEi2oJxpsRMBdE13AueF
        cwuXhp7Z5s5KniXQa1DndY9EPlaQ/d+ogqLn9NGqNE2FE+kWQsD3euvCwsXoTBpP
        USZ80C2yJENk16vx6Z8MC7CQCKCEdRubyZ6tEy+777bHg7UrRf0xedXg983fDZ/6
        MaLCVcqHB+IWEeO+Qsyz0Uh0vGjKXLrSrtxFjX9oZ/xGJyvd19EoeHXG6WRgD+0A
        G7sHoeCQWvU2b5C3FOsujWiwg+cNqTPduzJqxAmcFfjCLx1tki5qvQlMV+zgsqZQ
        LGY2MNjuc7pqYwmKhNfumxsz7ybtxtyNBy4d4QHxUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dCNTwp
        brygdlSzzc2FSEUktQs4G/tw8OZWUghu6D3ME=; b=ApOjkzVhfFeqlzdsO7tG0b
        x2bQvq7ntcNEhFM0AFLCrw3ZO/EH2RGTygVpMrJ3dAP6MlKHkmTa+uP0MyrFtomH
        5LAjlgtNQN09OTRea7p7pYONwGQAiVwp9Ax0WCv7exAeYjgFHgcAeCCe86kOOEBw
        TxHIO8klW2S3Akyz3KykNiHdz1QbGkoVKP3HuUC5FxziM2P5ni1OV5BfU8lV8saq
        2exDpozvp/Vgs0QTp5yJ7jm0oWt1ATsc/kFQ/EA/1DeayhNK2QO/GADZBALtBfgQ
        pLJfM2SFh/XPPgSNRfFT5zUu4QQ+7nTbkavi+lKMIQZrLlCIK7q6VOh5Ds2FvUrw
        ==
X-ME-Sender: <xms:ROK7XwG4HmiTg6r-VtpaxQ8BUu5C7WtH7yBcDEY0pBc-xjHzCsqNmA>
    <xme:ROK7X5VaR7V6uDdE9dSztt7S7p_Nppv_Cqmy0ebDwP52dvBRPHRpx0s9-CG7CcIa_
    Gy7KnQpIy3MT8M_XjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepuddvkedruddtjedrvdeguddrudejgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:ROK7X6LHf_mNExSBh-HxxcJKsQe01xb9FDOEOXarK8KYqYlrbdHcCA>
    <xmx:ROK7XyH4_tINpnuCxhWINI4B9cIUYfNZv_XFfRLd4ZrRCLzGrQy2sw>
    <xmx:ROK7X2UQLYJyie5vQRGBHgE4Xffguht8EUxvPlpHJ4ctfCLhIShHNg>
    <xmx:R-K7Xw33IJLVlu-7Jj36Cl8q_gbpZ3FG0VNLOTRskavmAPFl1i_qcA>
Received: from cisco (unknown [128.107.241.174])
        by mail.messagingengine.com (Postfix) with ESMTPA id 652D83280060;
        Mon, 23 Nov 2020 11:24:30 -0500 (EST)
Date:   Mon, 23 Nov 2020 11:24:28 -0500
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
Message-ID: <20201123162428.GA24807@cisco>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-8-christian.brauner@ubuntu.com>
 <20201123154719.GD4025434@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123154719.GD4025434@cisco>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:47:19AM -0500, Tycho Andersen wrote:
> On Sun, Nov 15, 2020 at 11:36:46AM +0100, Christian Brauner wrote:
> > +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> > +{
> > +	return mnt->mnt_user_ns;
> > +}
> 
> I think you might want a READ_ONCE() here. Right now it seems ok, since the
> mnt_user_ns can't change, but if we ever allow it to change (and I see you have
> a idmapped_mounts_wip_v2_allow_to_change_idmapping branch on your public tree
> :D), the pattern of,
> 
>         user_ns = mnt_user_ns(path->mnt);
>         if (mnt_idmapped(path->mnt)) {
>                 uid = kuid_from_mnt(user_ns, uid);
>                 gid = kgid_from_mnt(user_ns, gid);
>         }
> 
> could race.

Actually, isn't a race possible now?

kuid_from_mnt(mnt_user_ns(path->mnt) /* &init_user_ns */);
WRITE_ONCE(mnt->mnt.mnt_user_ns, user_ns);
WRITE_ONCE(m->mnt.mnt_flags, flags);
kgid_from_mnt(mnt_user_ns(path->mnt) /* the right user ns */);

So maybe it should be:

         if (mnt_idmapped(path->mnt)) {
                 barrier();
                 user_ns = mnt_user_ns(path->mnt);
                 uid = kuid_from_mnt(user_ns, uid);
                 gid = kgid_from_mnt(user_ns, gid);
         }

since there's no data dependency between mnt_idmapped() and
mnt_user_ns()?

Tycho
