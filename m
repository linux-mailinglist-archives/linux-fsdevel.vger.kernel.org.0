Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213185EB075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIZSs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIZSsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD288DDB
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 11:48:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g130so9318918oia.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=diSLexVku7NIpkpDyMmHjZ9yydShayfTBoCbTnyuXUM=;
        b=k6Sr4B2HRalEteZEFi0pNViRzzYpDHksAyega8gizfu12lYPvE2WDzYixar2fNZyvh
         EeUqs8FLdXVGyR/YKvK8WwU9lYR0aN+voejsgDOH3EWXyLDZ/+ewTa/nnHpzb7wx4jfI
         a/SmEiOzCV3J27C8T+ShSXDCBUx8UJs143paDyfk1zCaqeRdzWLbRrl7uNm053LyW8I7
         0zWwwBbBpVd24cfruBNMMifrbkM/wKcUNfV0oqswrNZwF5kLjgTU5FO1qcoVtGdfwkmc
         5AIKajukRV3ln20EG7VZySV7bvFkipmuE4gBG7/vbMJwialras2jakPQgohHxDScfQdx
         +xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=diSLexVku7NIpkpDyMmHjZ9yydShayfTBoCbTnyuXUM=;
        b=bGh43KXVv9/XUOeG9+mPaU1pGJe+5zq8O0icYwCwrUmSZ9uou5KCCWn84ixlEpdiGu
         ytwltiRkF3lscy7EwEvMEIEw+iRuPBkEjC9x2PBfnuXnks6w1FoVfMtG2xCjGBPRhpMw
         hgKg4oBZZldXpv9eo6lj7RPkbzhIuykiFE4RiVaP2MryCF4ezfTcxvitr+7Ubo3nQMu6
         LEJKnic6ejt/Rz50VCohZDL2A5MuutxBn/GYLUC//IB6fbTVuLacOjfPznYDTHl/qWnQ
         FWjV1Ish9q57I2yf9QswhTgKmkh2DXya+z0UIkgjO4PTvQ08IiFKn3fO9HTMdbWaBByV
         qnQA==
X-Gm-Message-State: ACrzQf1m7EjNi1LR6LwKX2KPR7/oq3wLEVMfTfodC7wuuk1nsDu/e3Wf
        vQT7Yf2Y8m7qZy7PWjxgAlGlbQln2s945LyY/5yY
X-Google-Smtp-Source: AMsMyM6M5GJLyJ/NXWh7Ux5KhWW46gpUyre3gGEHrNjBBbLSSQJZzpm8KL8Dmt84aK0Zal5N6S2alsyCY0taWfyvlvg=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr76641oic.172.1664218131786; Mon, 26 Sep
 2022 11:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de> <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
 <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
 <20220923143540.howryhuygxi2hsj3@wittgenstein> <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
 <20220926090513.hn3ylkakb5wf2rrx@wittgenstein>
In-Reply-To: <20220926090513.hn3ylkakb5wf2rrx@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 14:48:40 -0400
Message-ID: <CAHC9VhR6+aDG3j-xepxaK5RqphnisVGxUndcKUMuMLgbtoPW2Q@mail.gmail.com>
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 5:05 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Sep 23, 2022 at 01:35:08PM -0400, Paul Moore wrote:
> > On Fri, Sep 23, 2022 at 10:35 AM Christian Brauner <brauner@kernel.org> wrote:
> > > On Fri, Sep 23, 2022 at 10:26:35AM -0400, Paul Moore wrote:
> > > > On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > > > > > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > > > > > properly review the changes, but one thing immediately jumped out at
> > > > > > > me when looking at this: why is the LSM hook
> > > > > > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > > > > > inode?  We don't have a lot of them, but there are
> > > > > > > `security_dentry_*()` LSM hooks in the existing kernel code.
> > > > > >
> > > > > > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > > > > > related to an inode operation or dentry operation, not about that
> > > > > > the first argument is?
> > > > >
> > > > > Indeed. For example ...
> > > >
> > > > If the goal is for this LSM hook to operate on an inode and not a
> > > > dentry, let's pass it an inode instead.  This should help prevent
> > >
> > > I would be ok with that but EVM requires a dentry being passed and as
> > > evm is called from security_inode_set_acl() exactly like it is from
> > > security_inode_setxattr() and similar the hook has to take a dentry.
> >
> > If a dentry is truly needed by EVM (a quick look indicates that it may
> > just be for the VFS getxattr API, but I haven't traced the full code
> > path), then I'm having a hard time reconciling that this isn't a
> > dentry operation.  Yes, I get that the ACLs belong to the inode and
> > not the dentry, but then why do we need the dentry?  It seems like the
> > interfaces are broken slightly, or at least a little odd ... <shrug>
>
> There's multiple reasons for the generic xattr api to take a dentry. For
> example, there are quite a few filesystems that require dentry access
> during (specific or all) xattr operations. So ideally, we'd just want to
> pass the dentry I'd say ...

Independent of the naming issue discussed above, I want to make it
clear that in general I believe that the dentry is more useful to the
LSMs if for no other reason that it is pretty trivial to go from a
dentry to an inode, whereas the opposite is not true.  Of course there
are cases where the dentry is not always available, or the
connectivity between the dentry and the inode is not yet present.  In
those cases we would obviously need to pass the inode, or both the
inode and the dentry, which gets me to my next point and my motivation
behind bringing all this up once we started down the rathole ...

My main concern is making sure that the LSM hooks are declared in such
a way that they are fairly resistant to misuse; not that I expect any
malice, but I do believe accidental misuse of the hooks is legitimate
concern.  With respect to the various VFS related hooks, one of the
things that has always caught my attention in this respect has been
hooks which pass both a dentry and a inode for the same file.  Of
course there are cases where this will always be necessary, but I hate
to see bad interfaces continued forward simply because "that's the way
we've always done it".

In this particular patch the hook prototype is reasonably well defined
as far as I'm concerned, with no worries of both a dentry and an
inode, so that's good.  I still don't really like the name disconnect
between the function name and the parameter list (inode vs dentry),
but que sera sera; my appetite for argument here is rapidly waning.

-- 
paul-moore.com
