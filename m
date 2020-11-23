Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A112C0F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbgKWPy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 10:54:28 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57243 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732217AbgKWPsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:48:24 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D00855803A4;
        Mon, 23 Nov 2020 10:47:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Nov 2020 10:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=YCozEjPGEAusuu5kWcPoz4VuSgu
        BS8YGOeXbic2f3Rk=; b=pvyJJQ7dtuKuZyz5d3i/Y2P3BtpwgiXvwkMU5BeT/T2
        WF7NIU3puTeGziHc3V8c4P08DDWx0C/mg8YCh+U9Sca9z/JBHq4wxcxz+bm/x/Js
        ill0yaXVsNoxFGfzUBheTBFxcrVd8m1grxm7s7iqfhMx/pqXZTmktPvPSGUH1K+i
        VvxsyMeiQnZ801Wg/2mHiLsPZGF/gI01gimS5m/ZBxf0fuByrLF38kRtIG8KpJoC
        GjM0bMurgM8uw9HPIxfjJfQMxd6piCxFrXhJwKKVnPi4S2MGSK9vrSe50wmN6ozJ
        wPMGgnj6yqYl5/R8VxfTmCS+UTwBxYo6D54TxCJcS8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YCozEj
        PGEAusuu5kWcPoz4VuSguBS8YGOeXbic2f3Rk=; b=WeTek+Xz2c2hE5akKms3c+
        JeQuMni5IamwAYJBT/m7URxRjdbl3G1N+579hB8TJU7hVr8i4qroe26PJ3If/+wN
        Qy/X8fRJQXhvKWoGWjNKkJOYeaW/AZ0EpTpZIyp6yvUY5A3Rrv+LpcWilbxoFfyJ
        OP2LRptG+oKP0efDk+2PvtUyoy9XYB07mY8m0aI7DiEIgovl7mAXAN3Bf0YNAFRl
        jxkRqX5pKm7uJ55WMJLJWPae4lZpqOCzd0ZA9zA5cLRvER2UcwplWM5qIoZCOWR5
        wc6xoAs15KiJGximzPI2SWI4DgpHPxy+EhzRGjAX7GrlMgOFuCnOTi8X3+CgTwPw
        ==
X-ME-Sender: <xms:kNm7X-6VybmnIE7HxBF78RbqSph39ZGAjm52Jziqp6YhvS6SutsV3g>
    <xme:kNm7X37G5hrBHr_ofSXlbfBd7NIArMQy5vyzjbdcfCZMiQhtsghJXDiLqbJDjXPbG
    4pkUDJOybMd7fnmfxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepuddvkedruddtjedrvdeguddrudejgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:kNm7X9cPIAKRhCP04Kj8q43f_nFo2EYWIGVCCaxjvTW9N8SJ8w8jVQ>
    <xmx:kNm7X7JU-QaZeelrk4qvOdP93F1LE0ucN_vNnd5Copq4DsgabUHEbQ>
    <xmx:kNm7XyLAnKZzuImxS6me0molLz2ayvhe0zjr3tUiP9xn0aaEnjdKTw>
    <xmx:ktm7X-pza5kZuwtkUTGD6q3OiEh8E1SHpU53XCgKODHJj5cEjL4fZA>
Received: from cisco (unknown [128.107.241.174])
        by mail.messagingengine.com (Postfix) with ESMTPA id C041D3064ABE;
        Mon, 23 Nov 2020 10:47:21 -0500 (EST)
Date:   Mon, 23 Nov 2020 10:47:19 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 07/39] mount: attach mappings to mounts
Message-ID: <20201123154719.GD4025434@cisco>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-8-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115103718.298186-8-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 11:36:46AM +0100, Christian Brauner wrote:
> +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> +{
> +	return mnt->mnt_user_ns;
> +}

I think you might want a READ_ONCE() here. Right now it seems ok, since the
mnt_user_ns can't change, but if we ever allow it to change (and I see you have
a idmapped_mounts_wip_v2_allow_to_change_idmapping branch on your public tree
:D), the pattern of,

        user_ns = mnt_user_ns(path->mnt);
        if (mnt_idmapped(path->mnt)) {
                uid = kuid_from_mnt(user_ns, uid);
                gid = kgid_from_mnt(user_ns, gid);
        }

could race.

Tycho
