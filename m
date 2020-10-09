Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E73288DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbgJIQMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:12:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E358C0613D2;
        Fri,  9 Oct 2020 09:12:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so9651845ilh.3;
        Fri, 09 Oct 2020 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Uy1qbqyA70FigIO+ekukYLC701Um0d879m8IXckivCI=;
        b=Z820tWIzrRG4Z8kIA/LiyxyQL+WZYPl8fmfj0Op2gYzuviQ9HKPhATBfmFt/hKKrCa
         xxz+VHskQvalwSrmAq4Ll1Y4y93JgWafsfqnxct3xkOT5L3KXsdj6VXHq2R3qBkS+kjH
         vIE8OA8DKn9ib8YH5NkLWjYwAXLCuaJaWejCgPkDdjqYPZOf9oMvz7kET7v/Bctygw/l
         zWacU/LKUVWpO2y5zHhEtiCYC/ymOKUiD59KbM4I7NzHc1wYs1kR2UJstPHAYetSemro
         OVkNpC163ifjkbRQ0gzyB09WyeksxJk7uV9CXV1GWlinOsAzsvIE8C6ze0VTUObxSJJx
         d97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Uy1qbqyA70FigIO+ekukYLC701Um0d879m8IXckivCI=;
        b=qM3tj5RAzcMasvC4dYRNDTnBKIL7rXFXxtOygWNJPTRH4+MeKt6FVR4y99niAbjgEP
         TvEF3SGY6RmzGK6sWWsx2lVLK2hkwmLlKrN831yvsPLbNJ1pPrw/HBn3T9yv2Y7xRoWg
         KER6jh8y2dEJMBFafZ0oZDsL4ISBqPXMx1jkCUkWKaaXRGB7gSxAfOtx4hbd0B/1ICmv
         6yKGuJVfN06KGGJf0ng3wYwD2bU9eXMf2gqLmKQQfWm8qPZ885hK7tS8IWgJCa16tsfI
         XkpLeCCVzbE15XhcFP8O59fOcDuophSo+dHalQVEdzbbgoA53NRYNwh+xn2KrqBt5HXP
         GQBg==
X-Gm-Message-State: AOAM531VUSPduBRBkYPsetq9cP6xhNAEOKNRt8FxdI8iD5mQfzDqYOrV
        l1mMuz8p4XuUuZuHEchIiALH0vdFJDMWlFTuDNY=
X-Google-Smtp-Source: ABdhPJypH5VLKyelw9J3fzz4SZ1xNrfBUtDUtsKRZ4P6JIdIa8r0CmGAc4j0X1fz52yDn3ZMp85GktEoXIK+EtcT9fU=
X-Received: by 2002:a92:6a0a:: with SMTP id f10mr10873466ilc.186.1602259969720;
 Fri, 09 Oct 2020 09:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
 <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
 <CA+icZUU+UwKY8jQg9MfbojimepWahFSRU6DUt=468AfAf7uCSA@mail.gmail.com>
 <20201009154509.GK235506@mit.edu> <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
In-Reply-To: <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 18:12:38 +0200
Message-ID: <CA+icZUWsF1nm5nFGjy1Bk8pBCG-+GNDTbzJG7+XHrqddMobxUA@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 6:04 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks Sedat for pointing that out and also sending out the fixes.
> Ted, should I send out another version of fast commits out with
> Sedat's fixes?
>

v10 :-)?

As far as I can see this has not landed in Linux-next and Stephen is
not doing new releases at the weekend.

Anyway, it is good you are at it.

Thanks.

- Sedat -

>
>
> On Fri, Oct 9, 2020 at 8:45 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Oct 09, 2020 at 04:31:51PM +0200, Sedat Dilek wrote:
> > > > This fixes it...
> >
> > Sedat,
> >
> > Thanks for the report and the proposed fixes!
> >
> >                                         - Ted
