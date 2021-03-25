Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFA34958F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhCYPcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhCYPb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:31:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F15C06174A;
        Thu, 25 Mar 2021 08:31:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso1438218wmi.0;
        Thu, 25 Mar 2021 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTR5VPwJmizPoTcmDricTHVhvHimEQP2h0sRVD3qCds=;
        b=hHhdfYAvkFahY1fFiKam1uU24IgKTFvYD1i7rFmF6RobBjMT/RddgVwwtaMyQv4wN3
         83I11YLEIFakrIDLEHG5s/lbca1/cXNbKJKAzqwhfdKYOwgobmC+AKFb0N9gzJPfZ9ea
         5yfUgpYy2EyEwCVWCjFhx9+WTW2mSAP8iqNzVyHMlBF93Vy5SmwE0M+n7helAUtBLVsU
         RaNn+dR5AHFAtEnx8X6762RPYCaiTifZurl1HYm/z0P0kpcvH7zRctGaZ5mfxEu/Czv8
         lEzzD/D5hzOeQBNtwsZdsJNf8LQ62Hn2vGfKXHE1wqggQZI7DbOkXH9jifMsy0l8PcT/
         0YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTR5VPwJmizPoTcmDricTHVhvHimEQP2h0sRVD3qCds=;
        b=nwz9HNUfc02grqNXA+vQ8QS/0dChZU6Tx3oeQZ2vMF9zLG0xt9vUuZ5f6uGEwajvhV
         41tNvYtOhx8LmB03SbrX8zjqepxOJFseRYByi4j4Avqa3y0u82DXzpIYoF/QC7KqMPpo
         U3QgL0DwkHKzqX2/0PbeC9odfjml8RQIYrbbEkKPGgTHOXSLVgn1NecDVr3RNG5Qa0/8
         MkLZ4HYMgiz5KcqiF9hNHttGVXFTN/hEVUJ5DoIEfrbVIU5LUXgEFq3vy0Xv2x2gyluG
         076yUFlhMB0ph03viKGfjD0D2WeHpNRMIOfC54AqUyxVQGtmkyiBDqg695SUWczD0WpX
         60zQ==
X-Gm-Message-State: AOAM533ACl12HpL0Tf+k7SJgBL6yKFcGIKD/KRIugoHcMNMAaewavPnm
        aqLZgpwp5Lh8lL4zudP69zlghpyOddaOhal3eJo=
X-Google-Smtp-Source: ABdhPJwm0ZpuWrzdry+mVU2VoaGTJ3AnVIHBrC4zMKC25ZR04pYBDJWZ+nsA2suJlshEpuCxfctdVl+/hPgWNqiDYYg=
X-Received: by 2002:a1c:7905:: with SMTP id l5mr8815994wme.181.1616686284590;
 Thu, 25 Mar 2021 08:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
 <20210324143230.y36hga35xvpdb3ct@wittgenstein> <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
 <20210324162838.spy7qotef3kxm3l4@wittgenstein> <CAOQ4uxjcCEtuqyawNo7kCkb3213=vrstMupZt-KnGyanqKv=9Q@mail.gmail.com>
 <20210325111203.5o6ovkqgigxc3ihk@wittgenstein>
In-Reply-To: <20210325111203.5o6ovkqgigxc3ihk@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Mar 2021 17:31:13 +0200
Message-ID: <CAOQ4uxhdJWWRZSa0FfEiryQoBJYcGSADGoE7UZF8W=5-tcX9xg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I get that there are other use-cases that make subtree watches very
> interesting but I don't think the container use-case is a particularly
> pressing one.
>

That's what I thought.

Containers are usually "contained" by a mount and possibly by userns,
so it makes more sense and it would be more efficient to filter by those
contexts.

> > I don't like it so much myself, but I have not had any better idea how to
> > achieve that goal so far.
>
> The limitations of FAN_MARK_MOUNT as I now understand them are indeed
> unpleasant. If we could get FAN_MARK_MOUNT with the same event support
> as FAN_MARK_INODE that would be great.
> I think the delegation model that makes sense to me is to allow
> FAN_MARK_MOUNT when the caller is ns_capable(mnt->mnt_userns) and of
> course ns_capable() in the userns they called fanotify_init() in. That
> feels ok and supportable.

I present to you a demo [1][2] of FAN_MARK_MOUNT on idmapped mount that:

1. Can subscribe and receive FAN_LINK (new) events
2. Is capable of open_by_handle() if fid is under mount root

FAN_LINK (temp name) is an event that I wanted to add anyway [3] and
AFAIK it's the only event that you really need in order to detect when a dir
was created for the use case of injecting a bind mount into a container.

The kernel branch [1] intentionally excludes the controversial patch that
added support for userns filtered sb marks.

Therefore, trying to run the demo script as is on an idmapped mount
inside userns will auto-detect UID 0, try to setup an sb mark and fail.

Instead, the demo script should be run as follows to combine a
mount mark and recursive inode marks:

./test_demo.sh <idmapped-mount-path> 1

For example:
~# ./test_demo.sh /vdf 1
+ WD=/vdf
+ ID=1
...
+ inotifywatch --fanotify --recursive -w -e link --timeout -2 /vdf
Establishing watches...
...
+ mkdir -p a/dir0 a/dir1 a/dir2/subdir2
+ touch a/dir2/file2
...
[fid=ad91a2b8.81a99d43.3000081;name='dir2'] /vdf/a/dir2
[fid=ad91a2b8.81a99d43.8a;name='.'] /vdf/a/dir2/.
[fid=ad91a2b8.81a99d43.10000a6;name='.'] /vdf/a/dir2/subdir2/.
[fid=ad91a2b8.81a99d43.8a;name='file2'] /vdf/a/dir2/file2
...
total  modify  ..................................  create  link
delete  filename
1      0       0       0       0       0        0       1       0
0       /vdf/a/dir2
1      0       0       0       0       0        0       0       1
0       /vdf/a/dir2/.
1      0       0       0       0       0        0       0       1
0       /vdf/a/dir2/subdir2/.
1      0       0       0       0       0        0       0       1
0       /vdf/a/dir2/file2

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_link
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_link
[3] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/
