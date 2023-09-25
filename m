Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE17AD4C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjIYJoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIYJoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:44:01 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86E9C
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:43:54 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44ee3a547adso2320591137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695635034; x=1696239834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNQh3gPWZLNGBWs6Syw4BOUBLWuSAVzqnOqg+zAodOI=;
        b=A9ZVcAVpH5rz9pp6406koySYfjMKWHFE6asGQwN9L8srdykUbnZpElCZg0twjp0jV1
         3DLoMDftb2E6ElejAZwlj5QBMbBpry1eYBAzvdFfYFXlDVeXomf2YNlkl3gYa865Wwtn
         i9//mv5Qec5jnOr+bUToWj3JZ0uIaQH+cvhngMSua4TlKnk0GIm0Da6lNkREzgi1c+N/
         qel7lPGTlFuqFPCrvaEJSlAgtlVFHgRy5bn1jgfWgLpph+8groUj33WkbrPs/qvQv7rJ
         RnBIBNS9gaBZVOU2w8FPgx7pWGr0EVFgsraw8a0lr07Pphg3vfd6Pa2NuQshJjmwjDxL
         0Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695635034; x=1696239834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNQh3gPWZLNGBWs6Syw4BOUBLWuSAVzqnOqg+zAodOI=;
        b=RWn5uGTtHPp1QE/I3tkO5WIsveJ9dx/zTC0pYGdCUJ1Tz8TodnQm55EJncaBbk2yYa
         qfXksEwt8D91kxfeUc5E7E/sVkvZQcF/kAOM6i1s6ri3dhMC4GVKQkKE41jRcoqhWdMs
         KaL4y/Wg5IHY+E21cqmpXYoF1y7ci6ppEROwNrpGJlK8f96T8iYNmrAW1GgRq4jK8zkn
         bWPfCxzMDdugXoekhjCh7hEjaeI3YjkXZj2mTwSTyWgG5oYUz7qgiVX7DhyRZvxcS0G7
         Ua+jQjr3iVpVRpyNXahQKE3UOm8Nt85pRaEGbO5sUF7rJwFwL12piuIzGXIrN2HEY/bx
         05Ow==
X-Gm-Message-State: AOJu0YwUNHeXsmFGmUFZDzYkmQZVPqetTyse4ek9xQpR2eblv83pOe9z
        bGJZ+/Dr4648qRlh6siz1ZhSMxcS1qykRYfq2IM=
X-Google-Smtp-Source: AGHT+IH0jb03GIUmHtK1EkjiqCNYXZEkwUjbBbZYOnt4nVO3r6Y1rHWqSBAU6t3SQmyfZy6Q9UnpfVPqiMGbFW8zN7k=
X-Received: by 2002:a67:f108:0:b0:44f:c528:6255 with SMTP id
 n8-20020a67f108000000b0044fc5286255mr3609591vsk.16.1695635033900; Mon, 25 Sep
 2023 02:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org> <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org> <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
In-Reply-To: <ZREr3M32aIPfdem7@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Sep 2023 12:43:42 +0300
Message-ID: <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        brauner@kernel.org, Cyril Hrubis <chrubis@suse.cz>,
        mszeredi@redhat.com, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:42=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Sep 24, 2023 at 11:35:48PM -0500, Reuben Hawkins wrote:
> > The v2 patch does NOT return ESPIPE on a socket.  It succeeds.
> >
> > readahead01.c:54: TINFO: test_invalid_fd pipe
> > readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected
> > EINVAL: ESPIPE (29)
> > readahead01.c:60: TINFO: test_invalid_fd socket
> > readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
> > <-------here
>
> Thanks!  I am of the view that this is wrong (although probably
> harmless).  I suspect what happens is that we take the
> 'bdi =3D=3D &noop_backing_dev_info' condition in generic_fadvise()
> (since I don't see anywhere in net/ setting f_op->fadvise) and so
> return 0 without doing any work.
>
> The correct solution is probably your v2, combined with:
>
>         inode =3D file_inode(file);
> -       if (S_ISFIFO(inode->i_mode))
> +       if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
>                 return -ESPIPE;
>
> in generic_fadvise(), but that then changes the return value from
> posix_fadvise(), as I outlined in my previous email.  And I'm OK with
> that, because I think it's what POSIX intended.  Amir may well disagree
> ;-)

I really have no problem with that change to posix_fadvise().
I only meant to say that we are not going to ask Reuben to talk to
the standard committee, but that's obvious ;-)
A patch to man-pages, that I would recommend as a follow up.

FWIW, I checked and there is currently no test for
posix_fadvise() on socket in LTP AFAIK.
Maybe Cyril will follow your suggestion and this will add test
coverage for socket in posix_fadvise().

Reuben,

The actionable item, if all agree with Matthew's proposal, is
not to change the v2 patch to readahead(), but to send a new
patch for generic_fadvise().

When you send the patch to Christian, you should specify
the dependency - it needs to be applied before the readahead
patch.

If the readahead patch was not already in the vfs tree, you
would have needed to send a patch series with a cover letter,
where you would leave the Reviewed-by on the unchanged
[2/2] readahead patch.

Sending a patch series is a good thing to practice, but it is
not strictly needed in this case, so I'll leave it up to you to decide.

Thanks,
Amir.
