Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA06A33A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBZTdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBZTdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:33:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FF6E87
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 11:33:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so8025542pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3rRDs2lIx7wKb02F3SdqpHY3GUhiuvybUOWg1tlwMI=;
        b=hYxUj/jwmRn0NMrBbqN7sklYwDndvjf7JcERPmwIN31tvJXpKZwkbUCOSovMhRQA8L
         cgob2760zBB/dy+hBtMHK76PpeGS+bLFW24Tufs2AV9JNBAs8NHvsF9C2txjffy6WMs8
         r+LGMTGx0+pTDvknHF6jc0G9RcBtIqU2qQ0UXV+cEZygrfsaele2zETbpjjqauet4eyx
         MXT13MPv0pYDx6LAU4xfDkfqVag3n8c4YHd6gE+7ydJxqOBNvh8IOQWre4kekrk3LjZ2
         GrnYEdp41I5jTMeEm2yqD+2yTcxncIbTN+ZEQvhu92yD9Ya71D2h3LOkhtNfWighdAt7
         oeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3rRDs2lIx7wKb02F3SdqpHY3GUhiuvybUOWg1tlwMI=;
        b=iGyv0fb4IEsEkNBM2pTgAnnm4ce0x623PodUlwQd9dvvW342D0WPf74tFcRiJJQl+S
         2rbtp5Gh4QZ/axyWwaJkK/NLtH+ZisRNQTt7q4/VS3bAjo2gUg4ZAT1R0hUBUDJF7Re+
         zMBmEveb5wU2xUb1HHIsKxqu+jnT6zcS9GSqZnI5mDY0NffzUzaulOw1ZybFxxAzxz1n
         2Qh06wgXoGc3IJPYViX6ueF7TjredNM0MVShPc1vuqMIlFWW9qR6yfOu7w9rr3NcLgnQ
         LsPuYLTUMkfmpqLW37jxP6zlExjDGy2irjaIDarndTrZLFw416pzPaeVUas6KKkQU6Ia
         jjsA==
X-Gm-Message-State: AO0yUKXHG1TQ6ATLpkP3VU+YUD8eEKCKSeeyK7TtXwvtf82KWTx4KkO6
        ToT75JWHJq2Q8HN41GG0BWWkajKxwEEIWpldmk702Q==
X-Google-Smtp-Source: AK7set/KIkktj+QU9jFlQGMilLa0+bzuQhk2W5nRcoDIZ3zfoDo2QrOA/X8kP/fCb/4dPU5BTSutR4JbuY4l23X2ylE=
X-Received: by 2002:a17:90a:b394:b0:237:c367:edda with SMTP id
 e20-20020a17090ab39400b00237c367eddamr1649580pjr.5.1677440013968; Sun, 26 Feb
 2023 11:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20230226034256.771769-1-sashal@kernel.org> <20230226034256.771769-12-sashal@kernel.org>
 <Y/rbGxq8oAEsW28j@sol.localdomain> <Y/rufenGRpoJVXZr@sol.localdomain> <Y/ux9JLHQKDOzWHJ@sol.localdomain>
In-Reply-To: <Y/ux9JLHQKDOzWHJ@sol.localdomain>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sun, 26 Feb 2023 14:33:22 -0500
Message-ID: <CA+pv=HONnqX-mv9aieRAqbVnzUL70=cVE+H5ZwW855nVuRph1w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 12/21] fs/super.c: stop calling
 fscrypt_destroy_keyring() from __put_super()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 26, 2023 at 2:24=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Sat, Feb 25, 2023 at 09:30:37PM -0800, Eric Biggers wrote:
> > On Sat, Feb 25, 2023 at 08:07:55PM -0800, Eric Biggers wrote:
> > > On Sat, Feb 25, 2023 at 10:42:47PM -0500, Sasha Levin wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > [ Upstream commit ec64036e68634231f5891faa2b7a81cdc5dcd001 ]
> > > >
> > > > Now that the key associated with the "test_dummy_operation" mount o=
ption
> > > > is added on-demand when it's needed, rather than immediately when t=
he
> > > > filesystem is mounted, fscrypt_destroy_keyring() no longer needs to=
 be
> > > > called from __put_super() to avoid a memory leak on mount failure.
> > > >
> > > > Remove this call, which was causing confusion because it appeared t=
o be
> > > > a sleep-in-atomic bug (though it wasn't, for a somewhat-subtle reas=
on).
> > > >
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > Link: https://lore.kernel.org/r/20230208062107.199831-5-ebiggers@ke=
rnel.org
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >
> > > Why is this being backported?
> > >
> > > - Eric
> >
> > BTW, can you please permanently exclude all commits authored by me from=
 AUTOSEL
> > so that I don't have to repeatedly complain about every commit individu=
ally?
> > Especially when these mails often come on weekends and holidays.
> >
> > I know how to use Cc stable, and how to ask explicitly for a stable bac=
kport if
> > I find out after the fact that one is needed.  (And other real people c=
an always
> > ask too... not counting AUTOSEL, even though you are sending the AUTOSE=
L emails,
> > since clearly they go through no or very little human review.)
> >
> > Of course, it's not just me that AUTOSEL isn't working for.  So, you'll=
 still
> > continue backporting random commits that I have to spend hours bisectin=
g, e.g.
> > https://lore.kernel.org/stable/20220921155332.234913-7-sashal@kernel.or=
g.
> >
> > But at least I won't have to deal with this garbage for my own commits.
> >
> > Now, I'm not sure I'll get a response to this --- I received no respons=
e to my
> > last AUTOSEL question at
> > https://lore.kernel.org/stable/Y1DTFiP12ws04eOM@sol.localdomain.  So to
> > hopefully entice you to actually do something, I'm also letting you kno=
w that I
> > won't be reviewing any AUTOSEL mails for my commits anymore.
> >
>
> The really annoying thing is that someone even replied to your AUTOSEL em=
ail for
> that broken patch and told you it is broken
> (https://lore.kernel.org/stable/d91aaff1-470f-cfdf-41cf-031eea9d6aca@mail=
box.org),
> and ***you ignored it and applied the patch anyway***.
>
> Why are you even sending these emails if you are ignoring feedback anyway=
?
>
> How do I even get you to not apply a patch?  Is it even possible?
>
> I guess I might as well just add an email filter that auto-deletes all AU=
TOSEL
> emails, as apparently there's no point in responding anyway?

I test this branch for Greg but don't pay attention to these emails
Sasha sends out (because there's just waaaaay too many of them to look
through unless they get a reply; I find them quite annoying
otherwise.) But if these commits automatically get applied to stable
trees, even with objections from the committers, then I personally
question the methodology for having AUTOSEL in the first place.
Commits should be tested and backported with explicit purpose by their
developers, IMO.

-- Slade
