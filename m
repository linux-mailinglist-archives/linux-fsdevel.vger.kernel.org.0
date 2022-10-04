Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD25F49EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 21:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJDTx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDTx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:53:57 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72C86B156;
        Tue,  4 Oct 2022 12:53:53 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k6so15806920vsc.8;
        Tue, 04 Oct 2022 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xkszvkhII4xDvrxq+/QSArRSuSw7PRfJuBnEaKt781Y=;
        b=RRbidPjdTfWfCfqlcBkFh3ZheGyIy0inBbR+XwnPPm3rEkG/L6+eDuGjBQkjgi5Weq
         ElZkgAzwUFEcg8DTEuZBcCta0D/fesg/rm/Ebqo2jdsbLlvazTQlqMcRU1hOf4jDYycU
         qr5z+z61cjUqAIJFDeqOFiGKdTONKIR3qtYOgAgHY3r0GFVUmDlgY1u9xUq+DZUZTX9Y
         4e3UyzPMd89zhA3uKtY6I8Bh8P7rRaF5gG0pRSxfBMcg5IbE0cYuDmUbuU772LcqXlC7
         8eaUe79dlaPiqY2WRBuKIw5jI3ihLdJnRTZieZ8/PbOqsDepzedVeQK6EQV0+38hbiiK
         1TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xkszvkhII4xDvrxq+/QSArRSuSw7PRfJuBnEaKt781Y=;
        b=iOec4ASiV2Dx/1ej2h4lxZ7tQEJSCq/z8/3G50jhFTgfMGKVH8wfWhPZuf7/F8sBYj
         WNuXgI8Qih7AUPYUwR4ShyEa2QF129J3QeqAOThIIC8WjBG+oUTbxySrW3hZiDDa4wwS
         4fsJkNWZLwLnqRwJnbXA54mvhceER9meFBXNbZJnQS5GCM3UQ6YlsQR6TirVeCdLRqnZ
         MvqQQR950dfGYiLdmipofsbhEUN2SOBrVpgb+TtXaw71z2nRXw36zUnzn+0avkzCxEy5
         Ccq+QIYKGns0/o/OKaEJLuZlnjN/pS/7FaU0X3O30TwCXxOMQXSPljlKSqmlr8L3md1v
         8NyA==
X-Gm-Message-State: ACrzQf29V09jFRPOQXOFYkw0930kPAwGSH0fBsMtf1RcQfxSKlk5J5aa
        9asiNTnjOpxGM1DdwPUhqcE9syb0a2TSps2UKaWuHfna
X-Google-Smtp-Source: AMsMyM5ryhcP5pfIqc3FnqJrgtKMD/iEU0XEHMXf1YVWjqD2uGz/z+gUNMBK6EPKlCtI70+7726pbTNC9P0g8Wt30BU=
X-Received: by 2002:a05:6102:215a:b0:39a:c2c6:cc5d with SMTP id
 h26-20020a056102215a00b0039ac2c6cc5dmr11212375vsg.61.1664913232751; Tue, 04
 Oct 2022 12:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
In-Reply-To: <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 4 Oct 2022 14:53:41 -0500
Message-ID: <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 5:06 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > This adds a new ->get_acl() inode operations which takes a dentry
> > > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > > to get posix acls.
...
> > > So what's the difference and why do we need both?  If one can retrive
> > > the acl without dentry, then why do we need the one with the dentry?
> >
> > The ->get_inode_acl() method is called during generic_permission() and
> > inode_permission() both of which are called from various filesystems in
> > their ->permission inode operations. There's no dentry available during
> > the permission inode operation and there are filesystems like 9p and
> > cifs that need a dentry.
>
> This doesn't answer the question about why we need two for overlayfs
> and what's the difference between them.
> >
> > > If a filesystem cannot implement a get_acl() without a dentry, then
> > > what will happen to caller's that don't have a dentry?
> >
> > This happens today for cifs where posix acls can be created and read but
> > they cannot be used for permission checking where no inode is available.
> > New filesystems shouldn't have this issue.

Can you give an example of this?   How can you read an ACL without an
inode or open file struct?  ACL wouldn't fit in a dentry right?  By
the way there is an option that we can use on open to return the
"maximal access" that that user/group has for the file (a 32 bit mask
showing whether the effective user has read, write, append, read
attributes, write acl etc. permissions).  Would this be helpful for
you to have us do when you revalidate dentries?

> That's weird, how does it make sense to set acl on a filesystem that
> cannot use it for permission checking?   Maybe the permission checking
> is done by the server?
>
> Steve?

It doesn't do much good to check if user1 on client1 can access the
file on server if any user on client2 can access the file - unless the
server is checking ACLs, so the server checks are the more important
ones.

The permission checking on the client doesn't really matter in many
scenarios (the security checks that matter are usually only on the
server).    The ACLs are stored on the server and evaluated by the
server so duplicating ACL evaluation on BOTH client and server only
helps in cases where the server doesn't know who the local Linux user
is (e.g. single user mounts - where all local users use the same
authenticated session).  It is common e.g. to mount with "noperm"
mount option - in which case the client checks are turned off (since
the server ones are the checks that matter the most).

Note that the SMB3 protocol (and also NFSv4.1/4.2) support a richer
ACL model on the server that is more secure (or at least more
granular) in some scenarios than the simpler POSIX ACL model.

Are there examples of how this would work for the richacl examples
(e.g. NFSv4.1/4.2 or cifs.ko or NTFS or ...)?


-- 
Thanks,

Steve
