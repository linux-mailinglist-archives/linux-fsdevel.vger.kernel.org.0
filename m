Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4D6F4AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEBUI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjEBUI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:08:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3610FF
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 13:08:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3ef34c49cb9so253481cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058135; x=1685650135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsVlYuM+w4tiPKeGtCSCfOA/d5m0f/ZZNN1MY6C8F5E=;
        b=i75FHADaN2unE/4wOfGnJbs8FSyB8a2SLNq/AETm31pR2Vncht9bitB2iZZ8atdXz6
         grpP8pOFCdW+mdyhL8V9RuVA19F/4PNNscRqH22oxAPT0yyqXbm/Fyb3O3e7WKVK7tin
         20NM7jnrrHJBHRjj8YCJLVSlXiVO5CSUIieIIanx+rupDJ5QZo1S7fPuD99qEJf4p8K5
         ZsZlwVfkVfR+hgulPw2QJJihbqrDfU4o6mqD9d7TYWea3e0tmplodJ34xv5+ZJ6/RLMX
         yEyAZ3B6rvSJUl/G3dqbdVJpjQTq7p8i4KwTwwPXpB4tqPdIbVHZv7LHMdTF/KhM3Srg
         fl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058135; x=1685650135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsVlYuM+w4tiPKeGtCSCfOA/d5m0f/ZZNN1MY6C8F5E=;
        b=bUUy+L6CmpzvT8qT2XpC17BPSDrKRl0kxfmXKtfxpXYZGpJZOsu4m2GJbTC8h4u4Lg
         /7M3lzfPVWSFseK7W6qibJiDNaXoW6v4KTLOzZoJSP/g/48P0CHnQUvtFJKYF2o9i3qr
         qIkUiyKUHmLqMf5QX5/RBPAzOzYdx4eBelzjSFOWVsYaTGwQvOeU5gWajPquvhBusFj6
         mPwUNE+Mjatb6OTDbYx6ME3F0BD+LM/QCF6NXbNhXY8h8nUt53FGGgMGnKl36IMID39A
         JJ4ZGDBYxjikNG39HvQjYxwZ+bkYm1LSNIMG+jgAX5f/VpKcgu3meJEyLKTVXsnFRCwy
         b71w==
X-Gm-Message-State: AC+VfDxoY2ZJXBT3OJigdKA0VH1FT3MuPPr/BV8IaaywKSfgqWMCuCKo
        xXZd5WJ9W4CasmLLdKOdm5sOa8u0qiM6RxInSoD7pw==
X-Google-Smtp-Source: ACHHUZ5grFAS90cTAPGW1LskGZwnO8x5RMue1+9CegJ51tT16Af3B+0eiBIHetHv9xfQ1NwYqeXq25I6jNSRJwRxQX8=
X-Received: by 2002:a05:622a:1a07:b0:3db:1c01:9d95 with SMTP id
 f7-20020a05622a1a0700b003db1c019d95mr97281qtb.4.1683058135234; Tue, 02 May
 2023 13:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c6dc0305f75b4d74@google.com> <ZE4L+x5SjT3+elhh@mit.edu>
In-Reply-To: <ZE4L+x5SjT3+elhh@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 2 May 2023 22:08:44 +0200
Message-ID: <CANp29Y4cg6HB0dw_4mO05ibiAv2GkdnMksQozSGiBrwan9JvYA@mail.gmail.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Sun, Apr 30, 2023 at 8:34=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> #syz set subsystem: fs
>
> This somehow got tagged with the ext4 label, and not the fs label.
> (And this is not the first one I've noticed).  I'm beginning to
> suspect there may have been some syzbot database hiccup?  Anyway,
> fixing...

FWIW one of this bug's crashes was attributed to ext4 [1] and syzbot's
logic in this case was to prefer a more specific subsystem (ext4) to a
more generic one (fs), even if it's not mentioned in the majority of
crashes.

[1] https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D171abfaac80000

--=20
Aleksandr
>
>                                                 - Ted
>
> --
