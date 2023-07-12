Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30289750594
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGLLI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGLLIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:08:25 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23910CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 04:08:24 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso4408088a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689160102; x=1691752102;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDNnBc3lLqO6r4zL4cQQ5OBw67Z3uK+KKd83ffOJd8U=;
        b=2X53g87r+bb2zYaRabLBinWs6Z5l8niWuxxi4b6Vty9E2ROJzysdRrdFejMUliRAoR
         C4UohT4iUdqCVzHW62rlvEaKmOAZe0tOC0u7bth3J+1bqI3dAjebb7FM1GRmGr7mZDZt
         55JbL1QvfBv5QhIP3UoJ9NhLwraf8OiNAj0y97BnXJaNSZjp5PGXAHLyOyqT1vY1430C
         Q5y8ycwDgXvAMp7+EBmfwk4wTEuNokZEplkP3pt2SU0b4pw9Z7kbtwnjsjzcIkVI4YTO
         fbBMvkQgEMnaVI3ZwGb3UWS5dVHam6jeQVfqM6MxZft06ahsStgGetwNfzJ3FysWHyBX
         IShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689160102; x=1691752102;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDNnBc3lLqO6r4zL4cQQ5OBw67Z3uK+KKd83ffOJd8U=;
        b=cOx4X7dxQKo6H7AA2X8iRNAAZX0EGtdtNt0AgjNaENI7WXKIzvOsp4Bur3N3EPNydk
         fLueBteQ+6dsKrj45OXWk3c7erv6dMvmnqI3vDYEUrqWN8oo+lD1vuU88/T9bkH9d9yZ
         XDp6l5KQRPKS8HPCi4iwyli7Y5NdfePFrDxk8DgJ0YnNarntNUn4s4tv3d/aIdw0n/ZJ
         uo/yqyMpc951mvXjgK04ixOrKdWIj+lChQjN/DIps/h2PAZaLE7FajL0909o5xVo1CLX
         DpTN/Q/5Bu+wIQghT2l1CUrc0y+KgKbkzMSiUY4avYx4uUOoxCvuKHGqCqXe8fk8fQ+K
         Isrg==
X-Gm-Message-State: ABy/qLaKyH9+owwQrjObZtgpMLjBLHnfWIzDJfgfkWkMeRTCc5Ve/LiN
        2XOsvC7Sdbgo7VFYjkpbromi5jjwNO4=
X-Google-Smtp-Source: APBJJlH4VbANyPQcU6n33csmCCzc137x8+X7gLF7T9qhmSfY5I6rWl7Bo2W/Qxfc9lU2urUdvxvlobCD02M=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:73e8:365a:7352:a14])
 (user=gnoack job=sendgmr) by 2002:a50:cd0f:0:b0:51b:e4c5:547c with SMTP id
 z15-20020a50cd0f000000b0051be4c5547cmr93487edi.4.1689160102428; Wed, 12 Jul
 2023 04:08:22 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:08:20 +0200
In-Reply-To: <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
Message-Id: <ZK6JhyiC0Z0vwu0u@google.com>
Mime-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org> <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
Subject: Re: [RFC 0/4] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sat, Jun 17, 2023 at 11:47:55AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > We should also think about batch operations on FD (see the
> > > close_range syscall), for instance to deny all IOCTLs on inherited
> > > or received FDs.
> >=20
> > Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
> > rights for an entire range of FDs?
> >=20
> > I have to admit, I'm not familiar with the real-life use cases of
> > close_range().  In most programs I work with, it's difficult to reason
> > about their ordering once the program has really started to run. So I
> > imagine that close_range() is mostly used to "sanitize" the open file
> > descriptors at the start of main(), and you have a similar use case in
> > mind for this one as well?
> >=20
> > If it's just about closing the range from 0 to 2, I'm not sure it's
> > worth adding a custom syscall. :)
>=20
> The advantage of this kind of range is to efficiently manage all potentia=
l
> FDs, and the main use case is to close (or change, see the flags) everyth=
ing
> *except" 0-2 (i.e. 3-~0), and then avoid a lot of (potentially useless)
> syscalls.
>=20
> The Landlock interface doesn't need to be a syscall. We could just add a =
new
> rule type which could take a FD range and restrict them when calling
> landlock_restrict_self(). Something like this:
> struct landlock_fd_attr {
>     __u64 allowed_access;
>     __u32 first;
>     __u32 last;
> }

FYI, regarding the idea of dropping rights on already-opened files:
I'm starting to have doubts about how feasible this is in practice.

The "obvious" approach is to just remove the access rights from the securit=
y
blob flags on the struct file.

But these opened "struct file"s might be shared with other processes alread=
y,
and mutating them in place would have undesired side effects on other proce=
sses.

For example, if brltty uses ioctls on the terminal and then one of the prog=
rams
running in that terminal drops ioctl rights on that open file, it would aff=
ect
brltty as well, because both the Landlocked program and brltty use the same
struct file.

It could be technically stored next to the file descriptor list, where the
close-on-exec flag is also stored, but that seems more cumbersome than I ha=
d
hoped.  I don't have a good approach for that idea yet, so I'll drop it for=
 now.

Ideas are welcome. :)

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
