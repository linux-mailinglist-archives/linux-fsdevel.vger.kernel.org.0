Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190CC7B7415
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 00:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJCW0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJCW0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:26:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8EFAB
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 15:26:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a22eaafd72so18232287b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696371990; x=1696976790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ezmrX03/lx2b3wgyBKph28UWpTDQ/b9recBcS7DQI=;
        b=G+b5779MpqRobRsSke/A28Ctz1M3VA5W813AVH7yhZ3ERrCZcJrImS8b5m8ed5/Fkt
         lTRZu93ok7yX9Z+Ns8Am5goBW3QSI+j466+IUH2zg1fT0cYU9YAhPSU2qPG0rniR+tgU
         XhUK1ZQmqMUBAcZNQIKeCG0HFQkX96ncSKQ4AsH7VYJZpzlWZfCR4UoCzV9Ax8xQIbd8
         Bh9HvI49GGhtulwh45EvYr++sEWH/uBmaLvgx938ggrpTPcXofshppYs4fjzX1So9LwQ
         +wmf97Ji2886zoNqv/nFoLAaBJd+MgQumy41hx4QuS/dglr7PXYz/JefHahoGUugsD0z
         Z6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371990; x=1696976790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ezmrX03/lx2b3wgyBKph28UWpTDQ/b9recBcS7DQI=;
        b=LpcZGuuoeV2NzL72vUNsffbCaZ/EF183h0IXX2Kn86ivAimxPprQNhZimtYvAclU1t
         iV76w4zejNKyh/dcFAwmGbBrIUuOq1KNCpE10p8Cp52avm2RCMphOauCxQnoEWvUuwLX
         yOqNdM/TXa6dZYviRCso10BeBaKn3hC9z3/h7dtrkPHopqM9lmAija2FyzqPRx97gY0t
         O/J0iNo1B2UbGx8UGn8X2kRaupIYeAgN/88w1uz6FctE4Er41Dv24uuKPGVk3p82rYx8
         RiVSQgRtNbFpyPW8VHzBEFKSkPZM/fujxTY83gLXIjg5ja9Euo9jZ5MHRv87azStNlAT
         xN9g==
X-Gm-Message-State: AOJu0Yw1SLYHQsjFWgo+/DUKGVhegxbzCwxY+pmBwD/d28veyEL5wsso
        oXtjYTVeyO4gdTm53LbPeK3GOAtEIrR4yDdpwtkrww==
X-Google-Smtp-Source: AGHT+IF0xmlVD08wVXp1gfdjZoxUeDjnszKhqUw2F/pnugOO1Cxpl/juxTDOh8Z6Eaai/DseLkxNvD3iKRk8HMP31oI=
X-Received: by 2002:a0d:cbd7:0:b0:59b:fb30:9862 with SMTP id
 n206-20020a0dcbd7000000b0059bfb309862mr1004133ywd.3.1696371990056; Tue, 03
 Oct 2023 15:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZRXHK3hbdjfQvCCp@x1n> <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n> <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com> <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n> <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com> <ZRyFnurIgVFVD8hd@x1n>
In-Reply-To: <ZRyFnurIgVFVD8hd@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 15:26:16 -0700
Message-ID: <CAJuCfpFggFpPxJjx9uGe05x0fTNONgoUf=QzkpCHLx43Tbryjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 3, 2023 at 2:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 03, 2023 at 11:08:07PM +0200, David Hildenbrand wrote:
> > Sorry I have to ask: has this ever been discussed on the list? I don't =
see
> > any pointers. If not, then probably the number of people that know abou=
t the
> > history can be counted with my two hands and that shouldn't be the basi=
s for
> > making decisions.
>
> For example:
>
> https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@re=
dhat.com/

There was another submission in 2019:
https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colorado.ed=
u/

Though both times it did not generate much discussion. I don't have a
strong preference though MOVE sounds more generic to me TBH (it
specifies the operation rather than REMAP which hints on how that
operation is carried out). But again, I'm fine either way.
As for UFFDIO_MOVE_ZERO_COPY_ONLY vs UFFDIO_MOVE_MODE_ALLOW_COPY, I
find it weird that the default (the most efficient/desired) mode of
operation needs a flag. I would prefer to have no flag initially and
add UFFDIO_MOVE_MODE_ALLOW_COPY or whatever name is more appropriate
when/if we ever need it. Makes sense?

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
