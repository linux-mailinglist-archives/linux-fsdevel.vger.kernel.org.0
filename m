Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687912CA3C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbgLAN05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:26:57 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43731 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgLAN04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:26:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0FAC65804FE;
        Tue,  1 Dec 2020 08:26:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 08:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1ZjibMafBhi5wreHWpqyE5n4OJZ
        RTh26ucXByqksgjc=; b=YGvdN742MswMjFFMm/nVhATPfG25MN3g8NDEhq46bSv
        7LXrAhU6GGnySSKTS+nutqhRkW96v0W05mNjCzdA1iunVOLgtCO7ajC6Mz8LB3u2
        5lnL64w4bFnzTvhjZEdQ4cbHNiB1RBznGNAlnAnNqk3UyQlEM6ETUJWnfZLt5Qg+
        T/eqHabfIeLU2JN+i3IjB4v4i6qzmkRLIZJbVTesFO9VwftF9+xJogYimU2W93rY
        /mndsKNjwtvuxWa4etSPsEAJd7vhdUaPBcy0Xh25FF7lbp/ZE9fA/h1S+KTmYHYb
        AwgwS4zJ5xYzQnVHOZdCVJPhST7hEIk4wyUW9UR4oEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1ZjibM
        afBhi5wreHWpqyE5n4OJZRTh26ucXByqksgjc=; b=ralXkkm/Ttr5dNKX1KdXyE
        NyUpN8X1tWhN5hv6cKVaH3Fh1yAQkTWbxIXHlmQimcia77Ck3NJxEywB4C6llwlq
        KYr79SBCuyD3+CGe/lOFvqLppWQ/qJLY5+X1C4uM1eGZq4pMt1/y5ELRl+sg6z7q
        1SB0jehI669qSfkTJaF2PMR6wQ2TKyRTJaaPp1sgXdRFPFsIqXvSkFXhWs2p8GNK
        IT5R/AjjNb3Ul8X1o8PA97XTaEOyjBBdnYY5ZY02uHCVFCRHlSsoULBB2U/fD90Y
        xHH17x2yc0diRyv8G/4f3qfU6HvrFm51qA3YXcZRMIo1abiGeBraPBZEs2GUOSdQ
        ==
X-ME-Sender: <xms:b0TGX1QtZp99ufXf40j1YmqeWuwPzFStbU854K9q9zsAwrIVZa4AAA>
    <xme:b0TGX-zgoJRocphuNxw6tUPjgEV3pJeQrXPD6ApV6X_omYXz6uCwX8BKkyK8N-SJv
    _qzX9W7ns057PEY9uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepuddvkedruddtjedrvdeguddrudektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:b0TGX60khMu7LzGd7Yn3aL7UjilWQHaWM61HxQVYHDyS-_xY28R6Zg>
    <xmx:b0TGX9B3lnqfdWmGNRFc_HxXwZfb28_nQ1Vf02IqXYseMVIQ6jvF8w>
    <xmx:b0TGX-inuXGa4Vvr-SNyGJpIv-GfZKcep4apN-VsGGzfbu_D1MfZQg>
    <xmx:ckTGX3AJxVIy7LI81lMLNHF1N1bnSjcw78XxLmR0kT7zBUg_ll9Ypg>
Received: from cisco (unknown [128.107.241.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F6533280065;
        Tue,  1 Dec 2020 08:25:59 -0500 (EST)
Date:   Tue, 1 Dec 2020 08:25:56 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        Christoph Hellwig <hch@infradead.org>,
        Alban Crequy <alban@kinvolk.io>, linux-ext4@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        fstests@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 07/38] mount: attach mappings to mounts
Message-ID: <20201201132556.GD103125@cisco>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
 <20201128213527.2669807-8-christian.brauner@ubuntu.com>
 <20201201105025.GF27730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201105025.GF27730@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:50:25AM +0100, Christoph Hellwig wrote:
> The READ_ONCE still looks suspect as it generally needs to be paired
> with a WRITE_ONCE.  The rest looks sane to me.

Yeah, the comment from the other location is,

/* Pairs with smp_load_acquire() in mnt_user_ns(). */

So I think it's just a typo that needs to be fixed.

Tycho
