Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39E2365202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhDTGCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDTGCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:02:14 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E653C061763
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 23:01:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b17so31129830ilh.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7YXpF4aYlp+QUIFRCPukOls5xdzH4G/Nk5pyAS2RW8=;
        b=C5ag49bQFgxpMOI4eGfn6jDyNvi3Xa4n1EU8qnPNCOXJb9GFAF+QofQ3AW4Y075N49
         YWS4mPJf7xiQRVTEyS8cryEfhstHfOxzk9xFNoEEJ293Xuu9UbgJvD1l4+9OhZZcWmz7
         jLDG7RyfmZ3et7ssI7XdQ6txW8WimesCGrwJyHIBs2DmMhRDkfOqwC8ZQewfy69g6lBL
         l3IOjYL05zKF7SFuw+kGckMVdgIKrvrlGCnoxdHDzMqroXpdA8aAF0x2a8P+hs5C/1WR
         zgUG0qLBwvJMW41jz+jOOrvV+KWhTGPPbeoFfrhZbj2V3ie0aBbTg6tpUM1JTqDK7Gex
         plOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7YXpF4aYlp+QUIFRCPukOls5xdzH4G/Nk5pyAS2RW8=;
        b=q7qdzm1je67KzvOg32YMqAKK9axnQNW6FVBFdvbd0ttMLClCC2W9WACv2yQnET1xSM
         +Ct2F9MtfdF6g0h4TxAT7O9j7vyyI8xlD0X0EZtz7v8Ur8hpp70z23HI9NqWnxQxorKY
         cY1zL4lMoJhyHInY4nJZMBsYevrX+j4xeNvyBDi04E42zNyxLNw76dcQAebUsp1TY+Ar
         QvNJb2B82qyMyGZWjU/qE4c3ViBAR3oni8fazj1sCPnwdZB3pNsUBDtAvkn9Ur6lS0LF
         DrEiqSPiDg/drDmZWCdAj07mzGsmwgZb0nLxrECYnhiKGrtIFaB35svrLfU/+jqk82N9
         7Wzg==
X-Gm-Message-State: AOAM530qzL6g4JIDDpnfYdLnzd8446sJJ8+cMCy02Vt0d3Z7y9o28H/d
        Pt1SraGSVhGF+0oYMirrLYu264nRMLEDQA+MPrE=
X-Google-Smtp-Source: ABdhPJz2PengLvDoHuIv9zqPAPFaVnTG094nw2mjuxDvjp6Jp2Ga8Vz2K8UA9WbVOc0QKmWe4+T5iYemN0rbrzow5/s=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr11087589ilm.72.1618898480669;
 Mon, 19 Apr 2021 23:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz> <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
In-Reply-To: <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Apr 2021 09:01:09 +0300
Message-ID: <CAOQ4uxi-BG9-XLmQ0uLp0vb_woF=M0EUasLDJG-zHd66PFuKGw@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> One thing, whatever you end up passing to vfs_create() please make sure
> to retrieve mnt_userns once so permission checking and object creation
> line-up:
>
> int vfs_create(struct vfsmount *mnt, struct inode *dir,
>                struct dentry *dentry, umode_t mode, bool want_excl)
> {
>         struct user_namespace *mnt_userns;
>
>         mnt_userns = mnt_user_ns(mnt);
>
>         int error = may_create(mnt_userns, dir, dentry);
>         if (error)
>                 return error;
>
>         if (!dir->i_op->create)
>                 return -EACCES; /* shouldn't it be ENOSYS? */
>         mode &= S_IALLUGO;
>         mode |= S_IFREG;
>         error = security_inode_create(dir, dentry, mode);
>         if (error)
>                 return error;
>         error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
>         if (!error)
>                 fsnotify_create(mnt, dir, dentry);
>         return error;
> }
>

Christian,

What is the concern here?
Can mnt_user_ns() change under us?
I am asking because Al doesn't like both mnt_userns AND path to
be passed to do_tuncate() => notify_change()
So I will need to retrieve mnt_userns again inside notify_change()
after it had been used for security checks in do_open().
Would that be acceptable to you?

Thanks,
Amir.
