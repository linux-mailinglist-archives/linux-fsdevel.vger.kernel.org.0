Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CE70E3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjEWRfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjEWRfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:35:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E99E45
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:35:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fd3a658eeso449059366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684863308; x=1687455308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgE8ji/h7CMcJNn0UAt7kbxemzWw21WFjqqu1Nqn77o=;
        b=GutU+KcyGMb2D06V+jB7u+SCRjrSspJBRGcOOoyy7O26Mo/G2io52jtkfTz9SfF9D9
         R5lf5J5I3396iPaFSXXY084eo6e+klgFjaQqoPOl2KiwS+s4WVxxA6eFSRJ5WGCoXEZp
         fh3KnORTunD0r1hDbk2gAf3/alBBc151WUR4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863308; x=1687455308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgE8ji/h7CMcJNn0UAt7kbxemzWw21WFjqqu1Nqn77o=;
        b=TK/8yFhqZL/FLatURGVLhPnCspAEf4z0b24sBNHckqLAudXMpZvcCw6fLQBDe30DJl
         wlA25GSNIUS9T9LkImlDBerBfNkn3+d5DT9r/DkuPdl6udN6W23Q1IXY9Sb6VGNCR9kc
         8GAWMe63mdAevfgaFgQSeFnm7cWJccQlRI8/s81GhaKFaUwkTenqKcbGhubcDLk9F4sK
         /giJRhwDk1+9ZhuYNLl/teMVvHkjNPAZVqmDGIIwl4ug/rbv/t4IwcrDLZDCe/VZB8Jd
         vzJz7NUkxHJDmZIlTwEsIrWJpC6GT16I4OF2DgqKHe3xut+amMNuF3hrv16kBzynKi6X
         SJkA==
X-Gm-Message-State: AC+VfDwJZOIbVFd5uECwoW2tpWsavVsdvQiPOZJfTVgypw4pfs8QHHkw
        lZEM4nkjIcpnf1j/pzFW2YT4zvZTVxyte9woJgN5m9Mf
X-Google-Smtp-Source: ACHHUZ7o9cJYKwBwnKGIozxs4vsuB9GzH8KWG5d3UCgl0FQv/kEENLPTw1TKck/TFZzcINj+3yLtxA==
X-Received: by 2002:a17:907:7d91:b0:960:c5fe:a36a with SMTP id oz17-20020a1709077d9100b00960c5fea36amr15280113ejc.61.1684863308121;
        Tue, 23 May 2023 10:35:08 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906bc5200b009600ce4fb53sm4653614ejv.37.2023.05.23.10.35.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:35:07 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f683e8855so763468066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:35:05 -0700 (PDT)
X-Received: by 2002:a17:907:9443:b0:94f:3b07:a708 with SMTP id
 dl3-20020a170907944300b0094f3b07a708mr15767293ejc.29.1684863304990; Tue, 23
 May 2023 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
 <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com> <CAH2r5msZ_8q1b4FHKGZVm_gbiMWuYyaF=_Mz1-gsfJPS0ryRsg@mail.gmail.com>
In-Reply-To: <CAH2r5msZ_8q1b4FHKGZVm_gbiMWuYyaF=_Mz1-gsfJPS0ryRsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 May 2023 10:34:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYTAK4PSK23bDm_urZ49Q=5m=ScYcmK27ZJNKSBPdbgA@mail.gmail.com>
Message-ID: <CAHk-=wjYTAK4PSK23bDm_urZ49Q=5m=ScYcmK27ZJNKSBPdbgA@mail.gmail.com>
Subject: Re: patches to move ksmbd and cifs under new subdirectory
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 11:39=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> My reason for adding CONFIG_SMB_CLIENT, enabling CONFIG_SMB_CLIENT
> when CONFIG_CIFS was enabled, I was trying to make the Makefile more clea=
r
> (without changing any behavior):

That sounds ok, but I think it should be done separately from the
move. Keep the move as a pure move/rename, not "new things".

Also, when you actually do this cleanup, I think you really should just do

  config SMB
        tristate

  config SMB_CLIENT
        tristate

to declare them, but *not* have that

        default y if CIFS=3Dy || SMB_SERVER=3Dy
        default m if CIFS=3Dm || SMB_SERVER=3Dm

kind of noise anywhere. Not for SMBFS, not for SMB_CLIENT.

Just do

        select SMBFS
        select SMB_CLIENT

in the current CIFS Kconfig entry. And then SMB_SERVER can likewise do

        select SMBFS

and I think it will all automatically do what those much more complex
"default" expressions currently do.

But again - I think this kind of "clean things up" should be entirely
separate from the pure code movement. Don't do new functionality when
moving things, just do the minimal required infrastructure changes to
make things work with the movement.

              Linus
