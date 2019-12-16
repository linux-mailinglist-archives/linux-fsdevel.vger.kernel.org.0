Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36E1209C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfLPPeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 10:34:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36093 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfLPPeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:34:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so5409053edp.3;
        Mon, 16 Dec 2019 07:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TzfAR8SDzD///NGN9DuEi/f++yR3mLqHbY7tEnQ3hyE=;
        b=dXKFvYdYbZt8kGC/wa9JG2wseqQ4IYUQowSDont/vk68zNdtIxs4Jr+if5/kgq6S1Q
         sePxB1PZ6npdQL5UH+gNMYL8fID/NutrNwMwQh8DnSUB1MLv45g0JZM8GbTj7IA3rj02
         omY1FYBDNREPNFgHSV88lhLqHxDMZLC3xgDFNDljgENogzjdDOxU1950omIwR3nbca6X
         I6j6vjLqxn5/kN4Nj+KYjqX44lKMJ1UAtZlFfChdRu4Ze1VXkl68PXNHrLrvDrFJiS7m
         yhcwP9YlL2cH7Jra2oXINdHzeWCpC5/43D07U/Wm83+A+AlsWOadscsmU5FPTEOqe12W
         szaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TzfAR8SDzD///NGN9DuEi/f++yR3mLqHbY7tEnQ3hyE=;
        b=ZjzcWxEf12hvAQfzx5vEOYugiXEskGy5uPzi2yQhHmqyLdiPUvJ5EFsO4miH5yNmBU
         f6hckjcP8/mPNYGe2X2Esy63Gtc/koQqCQC1y3aO/TJoKv1HQWlXpw+HDk4X0wIq5XDE
         DnpAjxQOZ1hBhUmI1sWYNw+FzlcySlQaY4G10AOK243ZaMvQhevzBeLO9KKOuY8wQ1QH
         2ADIqSiGBtvw5X5YcmknltnTGaGU6myMZG+ku77T5o0AUYLtGCtkSPRf6ib2mm4HevXB
         XE53v1zupYOiKSyOYi1pqW3o5mZohHheR+W7cIdyIbFP643LlKmggbYQYkfkbn1z+f/y
         fmsQ==
X-Gm-Message-State: APjAAAVkFjW2G9vBBkB8HXxDeKGL6CTjEwWoSwUiDfWL9oVEYYnIkhps
        niAzablIvdhI6/hTp05amXyv3If2DNoqj1G5S5Q=
X-Google-Smtp-Source: APXvYqyN+l+hHsnCGP5fKaCWp5Vgf3bVx45JFoAKup3tUOEM5z6gT6b71Rh56KjCe0FiBgXj27oC+gNt/6SyWXIzNbM=
X-Received: by 2002:a17:906:3793:: with SMTP id n19mr9532162ejc.85.1576510484528;
 Mon, 16 Dec 2019 07:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20191107140304.8426-1-laurent@vivier.eu> <20191107140304.8426-2-laurent@vivier.eu>
 <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu> <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
 <1576267177.4060.4.camel@HansenPartnership.com> <3205e74b-71f1-14f4-b784-d878b3ef697f@vivier.eu>
 <CAKgNAkiaKJZMA0pzvwDa75CxfULTL1LmOZDzhW0Y5TmL7nBGZw@mail.gmail.com> <dbd19cb9-9172-d89d-f796-05a23213ca69@vivier.eu>
In-Reply-To: <dbd19cb9-9172-d89d-f796-05a23213ca69@vivier.eu>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 16 Dec 2019 16:34:32 +0100
Message-ID: <CAKgNAkjgnV2-Q1RRtdkF98ggUaQPm3z1ndyX_AtwKEmjw0Ne6A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Henning Schild <henning.schild@siemens.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>, Jann Horn <jannh@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Laurent,

On Mon, 16 Dec 2019 at 10:13, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 14/12/2019 =C3=A0 13:32, Michael Kerrisk (man-pages) a =C3=A9crit :
> > Hello Laurent,
> >
> > On Sat, 14 Dec 2019 at 12:35, Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> Le 13/12/2019 =C3=A0 20:59, James Bottomley a =C3=A9crit :
> >>> On Fri, 2019-12-13 at 18:51 +0100, Henning Schild wrote:
> >>>> Hi all,
> >>>>
> >>>> that is a very useful contribution, which will hopefully be
> >>>> considered.
> >>>
> >>> I'm technically the maintainer on the you touched it last you own it
> >>> basis, so if Christian's concerns get addressed I'll shepherd it
> >>> upstream.
> >>
> >> Thank you.
> >>
> >> I update this in the next days and re-send the patch.
> >
> > Would you also be so kind as to craft a patch for the
> > user_namespaces(7) manual page describing the changes (sent to me,
> > linux-man@vger.kernel.org, and the other parties already in CC)?
> >
> > If you do not have the time to familiarize yourself with groff/man
> > markup, a patch that uses plain text is fine; I can handle the
> > formatting.
>
> I will send a patch for the user_namespaces(7) manual.

Thanks! Could you send that in parallel with (each of) the patch
iterations please (rather than after the feature has been merged).

Thanks,

Michael

--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
