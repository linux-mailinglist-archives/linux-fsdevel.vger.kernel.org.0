Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75720729CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbjFIO2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIO2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:28:30 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F935AA;
        Fri,  9 Jun 2023 07:28:19 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78a065548e3so731737241.0;
        Fri, 09 Jun 2023 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686320898; x=1688912898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKhqW/e89nWJE6YE0Fov4sww+VnuVJucQaNK7z3tnaQ=;
        b=UUP2ReqFaHEiQAYvlSE4ZHukjOPNuYB49N07Jfh8384aT4zaSijBvn36uCCnrJ5e0Y
         291gm0695me7/17J7w1Xp2fA8IuqyNbzfFhEYyjoPWYaqQdWCVwEJ2RtcJGy+qSpbDz6
         ACujd/0BQwUO0A7PYoLELBwF+9ZYOhAY+SFb3CDghLX20wzi7BC6maT4nTfJdD1oqKTh
         lUG5sJLnMo99QCsK5NyGVRAZfgV7yCSkGnmC3sppTulm0jmq2XEDxNqMuVEenuXsNLXF
         ahcY6Yy1x8IbZgXqmRIHMVec8OlaURAJxAP9RTcacpqd1yRqmnd9GJ70boaQPCnNWVDb
         CFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320898; x=1688912898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKhqW/e89nWJE6YE0Fov4sww+VnuVJucQaNK7z3tnaQ=;
        b=VJUsABMIkyo4lQMBtS6JKAy1tBqA3LKYp1sgcL8s6fXnMzRiz5qmzkZa5HDuYgLiSC
         V1EqnaWxrNVhmDfKnmgCjo2j6PZIi3vGJeeUtgAnSTFhBljt69deUDG5kTUKPYobF4uu
         TTbNcDU42Dw5EQzfmtdAT9jDcf+zlL8uw6Cw4vyy1tiC/LhgfymewgaKB5P+rsSr6+26
         Z48f08OzdiCdSod5GGtk0cpcx7++TUV04E3/nNfwvWQ7o+g4ugiwmMq623LgJrvzQbGe
         xUwzR0KcVQpQ8fYs2yoSDJ+tnUP4O7Nzwr+22hbIhg0j+vQ4tVKhcFjmH6YV3Vs0Do+e
         7h3Q==
X-Gm-Message-State: AC+VfDyi2q/tJQNr/SpGLmBBV5eBIAjn5av+6yRvZRsSQUbll4URNGgC
        thhesX0f5kPmJ7tbdKk4uMLrWsawgIZqviw8j1s=
X-Google-Smtp-Source: ACHHUZ7epdv62nx4NmKdYFQ5PCKOunKvegDAjrO7IT+qzmksaS1cDHh+5+TDIzf6DUu1anibFX5Sdm1ulAvmOEpI/jw=
X-Received: by 2002:a05:6102:303a:b0:434:3cf1:96e with SMTP id
 v26-20020a056102303a00b004343cf1096emr1244507vsa.1.1686320898503; Fri, 09 Jun
 2023 07:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
In-Reply-To: <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 17:28:07 +0300
Message-ID: <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 4:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Miklos,
> >
> > This is the solution that we discussed for removing FMODE_NONOTIFY
> > from overlayfs real files.
> >
> > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > I am still testing the ovl-fsnotify interaction, so we can defer
> > that step to later.
> >
> > I wanted to post this series earlier to give more time for fsdevel
> > feedback and if these patches get your blessing and the blessing of
> > vfs maintainers, it is probably better that they will go through the
> > vfs tree.
> >
> > I've tested that overlay "fake" path are still shown in /proc/self/maps
> > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> >
> > The audit and tomoyo use of file_fake_path() is not tested
> > (CC maintainers), but they both look like user displayed paths,
> > so I assumed they's want to preserve the existing behavior
> > (i.e. displaying the fake overlayfs path).
>
> I did an audit of all ->vm_file  and found a couple of missing ones:

Wait, but why only ->vm_file?
We were under the assumption the fake path is only needed
for mapped files, but the list below suggests that it matters
to other file operations as well...

>
> dump_common_audit_data
> ima_file_mprotect
> common_file_perm (I don't understand the code enough to know whether
> it needs fake dentry or not)
> aa_file_perm
> __file_path_perm
> print_bad_pte
> file_path
> seq_print_user_ip
> __mnt_want_write_file
> __mnt_drop_write_file
> file_dentry_name
>
> Didn't go into drivers/ and didn't follow indirect calls (e.g.
> f_op->fsysnc).  I also may have missed something along the way, but my
> guess is that I did catch most cases.

Wow. So much for 3-4 special cases...

Confused by some of the above.

Why would we want __mnt_want_write_file on the fake path?
We'd already taken __mnt_want_write on overlay and with
real file we need __mnt_want_write on the real path.

For IMA/LSMs, I'd imagine that like fanotify, they would rather get
the real path where the real policy is stored.
If some log files end with relative path instead of full fake path
it's probably not the worst outcome.

Thoughts?

Thanks,
Amir.
