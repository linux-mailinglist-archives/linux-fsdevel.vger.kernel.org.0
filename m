Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675170B744
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjEVIEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjEVIEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 04:04:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85AF9B;
        Mon, 22 May 2023 01:04:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5112cae8d82so4771765a12.2;
        Mon, 22 May 2023 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684742668; x=1687334668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVoPGktCVxZ7I7pWV/dKHM8hG/ValAUm7IgNP+5cCl4=;
        b=Ayj/fJoXlly24dKezTqDQda1QVp3kPflNFTRBGCApXT/NioCd/3louFRldPosbteKZ
         5CZ+p0DnY3Mpn90GYb24yx8uN8WjrU8DgMNS2d8nXY/T4XBYfayfc0l5SEjXi/YAAbET
         TUBgwJNGIR1ZWeA4DUSYdEZwAk/etx7S3EwPZoPiMBBkkz7XC6UCcZy/pfbQbWyKzQDs
         Z2zSPI9vZmIPJX1/AzwoWZFXXTNxv7PupxQQvB2CmTU5QZGwM3Hnk8xwkLUldgNGjnfY
         F8oduJM0iKugUviWrcCVjQG4benTUgpgvVGdONha3oCAbuEsxRakCCBm8njghgliOQr2
         7u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684742668; x=1687334668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVoPGktCVxZ7I7pWV/dKHM8hG/ValAUm7IgNP+5cCl4=;
        b=UOU9c1GHFGhJZ0IyfKj0zEKxzo9rMTTFy1qXfhJsLWnPNIcQGUHgjT7srerAqPwMdu
         AEj+qEB8SEDGm2Vh8U80k9cubmKLgEwp4LiYpJnDqUorBAA8oziBBBmX0eG1KYERmQsH
         YtP2umjutuHNp0PkmMj11GZYLI69wqxseDaAh67FwkB4lZnxmSPSuXQieTW36z4l2KAB
         mdrY3rmfemyHkMCN2luYEzeDlZgL06TDbLoPncDVYKctxEmX+wce1PwIVIqUkFxMfDzu
         ynMn07MY5dC2DjLts39sB/DQOXQX/OMTgkPI9+9ypc8eutosPl2yfr9Z58kCoqqYLzB2
         N2cw==
X-Gm-Message-State: AC+VfDwk+NpoObSLVs1lys8pHSjTTnMz0hI9dwIC51D9MQ/dzniJstIZ
        q0RpHwV0gY/KKkGbY0ljge3Qms5/6bStd6wsV6M=
X-Google-Smtp-Source: ACHHUZ6P4eYcbViBSBokKd/QDJANfsxUT4RcwcSupXg4VvwJqh0qFjOIrWXJdZ2TuBOkguzAdcs0BF+1TDVQ1+50S2k=
X-Received: by 2002:a05:6402:12cd:b0:510:ed22:db43 with SMTP id
 k13-20020a05640212cd00b00510ed22db43mr8357858edx.24.1684742668169; Mon, 22
 May 2023 01:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
 <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com>
 <CAH2r5muxwEMA9JpE6ijSbZEByxRmtNSiwcXMbOz+Ojo8_APJUQ@mail.gmail.com>
 <CAHk-=wjeuUNo6o6k4y3nQD2mmT5T04ack7i_UOAetmga-4_SbQ@mail.gmail.com> <CAH2r5muRG45L3bNsNV1LJ_komzbp-js11sn+EfQ6Ys6b=X683Q@mail.gmail.com>
In-Reply-To: <CAH2r5muRG45L3bNsNV1LJ_komzbp-js11sn+EfQ6Ys6b=X683Q@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Mon, 22 May 2023 18:04:15 +1000
Message-ID: <CAN05THRhO_SUs46=x5p6FZFNUAr-fsOWpzb9pM25eC9YcmXsAA@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Sounds like a good plan.

On Mon, 22 May 2023 at 14:39, Steve French via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> On Sun, May 21, 2023 at 2:21=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, May 21, 2023 at 12:03=E2=80=AFPM Steve French <smfrench@gmail.c=
om> wrote:
> > >
> > > I would be happy to do the move (to fs/smb) of the directories and
> > > update the config soon (seems reasonably low risk) - let me know if y=
ou
> > > want me to send it this week or wait till 6.5-rc
> >
> > So I think the "do it now or wait until the 6.5 merge window" is
> > entirely up to you.
> >
> > We've often intentionally done big renames during the "quiet time"
> > after the merge window is oven, just because doing them during the
> > merge window can be somewhat painful with unnecessary conflicts.
> >
> > I would *not* want to do it during the last week of the release, just
> > in case there are small details that need to be fixed up, but doing it
> > now during the rc3/rc4 kind of timeframe is not only fairly quiet, but
> > also gives us time to find any surprises.
> >
> > So in that sense, doing it now is likely one of the better times, and
> > a pure rename should not be risky from a code standpoint.
> >
> > At the same time, doing it during the merge window isn't *wrong*
> > either.  Despite the somewhat painful merge with folio changes, I
> > don't think fs/cifs/ or fs/ksmbd/ normally have a lot of conflicts,
> > and git does handle rename conflicts fairly well unless there's just
> > lots of complexity.
> >
> > So it's really fine either way. The normal kind of "big changes"
> > should obviously always be merge window things, but pure renames
> > really are different and are often done outside of the merge window
> > (the same way I intentionally did the MAINTAINERS re-ordering just
> > *after* the merge window)
> >
> > But we don't do renames often enough to have any kind of strict rules
> > about things like this.
> >
> > So I think "whenever is most convenient for you" is the thing to aim
> > for here. This is *not* a "only during merge window" kind of thing.
> >
> >                  Linus
>
> Here are two patches:
> 1)  Move CIFS/SMB3 related client and server files (cifs.ko and ksmbd.ko
> and helper modules) to new fs/smb subdirectory (fs/smbfs was not used
> to avoid confusion with the directory of the same name removed in 2.6.27
> release and we also avoid using CONFIG_SMB_FS for the same reason)
>
>    fs/cifs --> fs/smb/client
>    fs/ksmbd --> fs/smb/server
>    fs/smbfs_common --> fs/smb/common
>
> 2) With the fs/cifs directory moved to fs/smb/client, correct mentions
> of this in Documentation and comments.
>
> Follow on patch can change Documentation/filesystems/cifs -->
> Documentation/filesystems/smb (since it contains both server
> and client documentation)
>
>
> --
> Thanks,
>
> Steve
