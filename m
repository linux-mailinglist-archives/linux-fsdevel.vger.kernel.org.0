Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F53729C09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjFINzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjFINy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:54:57 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39D210D;
        Fri,  9 Jun 2023 06:54:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-43b87490a27so633222137.0;
        Fri, 09 Jun 2023 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318895; x=1688910895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iaXsJZKTVimBK8Gqm68l/aGxQSDzJU2cwFj4IhyqEI=;
        b=pC31OjhLWE/+38a0RFggsez3i/tfi4qpIAUEx4TTFiE5hpAryCpDZeKv3qq1T+Vy6U
         PyMZPMlf72VlnA3iC/4rM+E+mDKrIW6tT5/SWghpb9sDM1bDT8OXytgt5LhfnYiAB66k
         xcUTL+JSKVLiMrQ/8FPiLeVosB77lZistOquKK6JWLBCcr7Pm7a+ihyjImHg3vIzKWIG
         9dnpmibzJ4jn+M1E/mlgqnxk6Z8vsXoWm61j2zf/dbwjPpLcNvnOg37WxZB5DbNikKrx
         jyQUYUj7jMy1+6z0GUM0AgFJQjdL7G1WLw3a7oI4nmPKqFPcltP2q5K08YN34wMbK9i0
         RL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318895; x=1688910895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iaXsJZKTVimBK8Gqm68l/aGxQSDzJU2cwFj4IhyqEI=;
        b=NB0gIhhuFISpv/HIMdu4B627zk3mBzoP/JV9vfknh5KWTrpcp5taptLEmUVX6cOY7T
         OsIrZJkx98kEcqYSDKv9hVyHH+OmRM8ZOxFAExBdWIbbEPa2tQHceESiP1o+2Z3OSMi9
         mPawqfqQBpoLvMZPNnwgdKKCqE0BAc6eK8XIp9DOphC9DkTID3bTj9HRVtg7Fk5VBTcb
         yQV45l42dGa0OhmYqniMeja6T6voexcjCamRjqDv8t/xWXjenovwgkyDjudN5ShyH1WE
         NOT7G65S6V/SBlTqNBZQVOB1scR7Qmg/VoGgOwgV+eq2yxXZmDM7rn1aI+FxZHAL2uuU
         XDPw==
X-Gm-Message-State: AC+VfDwKpIjcr/iwOgWrqP7e9GlCxSDZ9MiUobu3qb7WXpU5tNY2s19h
        GTXDkWPGiTFcqownHKBaJHH8IbHfanR2e0BdNYc=
X-Google-Smtp-Source: ACHHUZ6FZNeKOMyzdwOLxHzf3JTsa8uNM1s6JZFBCdQ+PQXl1Eh8gSzWUl15Q4hnYvbjIiaRjeG8aKKVlro6+HXrU4I=
X-Received: by 2002:a05:6102:34f9:b0:43b:458f:b078 with SMTP id
 bi25-20020a05610234f900b0043b458fb078mr1076690vsb.30.1686318894837; Fri, 09
 Jun 2023 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <4c21885d-828f-98ef-a030-58335716b990@I-love.SAKURA.ne.jp>
In-Reply-To: <4c21885d-828f-98ef-a030-58335716b990@I-love.SAKURA.ne.jp>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 16:54:43 +0300
Message-ID: <CAOQ4uxiAzPUhjDowDiAYaDJ6wH8q6WiWan6_TXxB7GzqaCPR5w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Fri, Jun 9, 2023 at 4:16=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/06/09 16:32, Amir Goldstein wrote:
> > The audit and tomoyo use of file_fake_path() is not tested
> > (CC maintainers), but they both look like user displayed paths,
> > so I assumed they's want to preserve the existing behavior
> > (i.e. displaying the fake overlayfs path).
>
> Since I'm not using overlayfs, I don't know the difference between
> real path and fake path. Would you explain using command line example?
>
>   mkdir what_path1
>   mkdir what_path2
>   mkdir what_path3
>   mount -t overlayfs ...what_paths_come_here?...

For example:
mount -t overlayfs overlay /mnt/ovl \
          -o lowerdir=3Dwhat_path1:what_path2:what_path3

>
> what the pathname returned by wrapping with file_fake_path() is, and
> what the pathname returned by not wrapping with file_fake_path() is?
>

It depends. if you have an audit rule on /mnt/ovl the path is
always the /mnt/ovl/... path (fake_path as well).

If you have an audit rule on what_path1 the fake path is /mnt/ovl/...
and the real path is /... (the relative path from what_path1).
In both cases, the filename itself will be correct.
If the rule prints something like %pD2 then it does not really
matter which path you use.

Thanks,
Amir.
