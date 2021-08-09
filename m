Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F93E4E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhHIUno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhHIUno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:43:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040CC0613D3;
        Mon,  9 Aug 2021 13:43:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n6so12275994ljp.9;
        Mon, 09 Aug 2021 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yUAKaSGW5DdJ2RQz+ROMjXDXwUd8MZUwEP7Sv67Rnfk=;
        b=jh1XmlgBHk4jrsPf4DmxJqM7pfrZrb8mFMTTROvMv7UPd9y4citm0IW9YSZRJLWznV
         OjEdXF16tyIN0ETuDIWCMPyL1YaCZzppNNSddWmpaxz33hK0tKLOGxZsCw9SvptX4eSJ
         1SeJB5uZbLDT3IeCj73sMQs0ibVjz5HeYMon+l4+5ByC2VE6KSjfkVGBZrlVw3CMYk5C
         MMe4u6T9QfcmG4Ay/vl2FAzJtQpGYPkxCc35j5H+FLOe/ydJQZJ5SCtAWRkdwA/kBZsZ
         u69OGl2BgZ/6mo4cIHpuCinTYdyUrYKmtNv9C5FulPf5LSJzMr/+8MZuJzjXgOro2Qg9
         QVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yUAKaSGW5DdJ2RQz+ROMjXDXwUd8MZUwEP7Sv67Rnfk=;
        b=FAvmgSfUDQFmVjoOQonyk+VvkVO/e5+WShltR1MAmYwgnMFXtaIwKGkXmjOS3oQFyo
         yI3eOpI1MwymxHOEJ989W84p5ymrB8hi/lFQRwzUYjf67IXLtkHsS/AiduW6iuZ9Y37h
         7xiM5RezfuZWW2w+waVtGvHqReJEP/7/A+K9BjV0wLXwB3RkNKD5F8k5dVr6sVp+D0p3
         W8jRtl1WJOeVzbQWCXZFeLFV2BJveqNwV3m9syjXDmSZPIF/nf/Tuq2MWwPrJOMJe/4T
         WB+P2GimiN0mOpXpV4snSTcqkkFwTrqtBUITqPe9j6z4Qt76HkK/VETXQIZ+ioIOuGrQ
         GqkA==
X-Gm-Message-State: AOAM533z75lG4MLanE52HH3ixjlMsGFRJf4c6up6840c7n8u1Pk4xzsE
        +NOu40SuifooCIEp+e3H8FkqD75w+FaY6kNrwRs=
X-Google-Smtp-Source: ABdhPJy8ej9SUjeGIWuogdO/3shhi/7En+oCEa5tTqZf2hp+d/UjsUbfLSRI2keSqvFXPLnxjriUbvils/jCtnY/FYQ=
X-Received: by 2002:a2e:b1d3:: with SMTP id e19mr10504370lja.6.1628541800135;
 Mon, 09 Aug 2021 13:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210808162453.1653-1-pali@kernel.org> <20210808162453.1653-12-pali@kernel.org>
 <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com> <YRFnz6kn1UbSCN/S@casper.infradead.org>
 <20210809174741.4wont2drya3rvpsr@pali>
In-Reply-To: <20210809174741.4wont2drya3rvpsr@pali>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 9 Aug 2021 15:43:09 -0500
Message-ID: <CAH2r5ms2wK4P9=J4q7OJ4fLhi=e981TY1+Ue7yawyQiCzS9ThQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when
 hsb->nls_io is set
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For cifs.ko, I don't mind running our automated regression tests on
this patch when the patch (or patches) is ready, but was thinking
about an earlier discussion a few months about parth conversion in
cifs.ko prompted by Al Viro, and whether additional changes should be
made to move the character conversion later as well (e.g. for
characters in the reserved range such as '\' to 0xF026, and'':' to
0xF022  and '>' to 0xF024 and '?' to 0xF025 etc) for the 10 special
characters which have to get remapped into the UCS-2 reserved
character range.

On Mon, Aug 9, 2021 at 12:49 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 09 August 2021 18:37:19 Matthew Wilcox wrote:
> > On Mon, Aug 09, 2021 at 10:31:55AM -0700, Viacheslav Dubeyko wrote:
> > > > On Aug 8, 2021, at 9:24 AM, Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > > >
> > > > It does not make any sense to set hsb->nls_io (NLS iocharset used b=
etween
> > > > VFS and hfs driver) when hsb->nls_disk (NLS codepage used between h=
fs
> > > > driver and disk) is not set.
> > > >
> > > > Reverse engineering driver code shown what is doing in this special=
 case:
> > > >
> > > >    When codepage was not defined but iocharset was then
> > > >    hfs driver copied 8bit character from disk directly to
> > > >    16bit unicode wchar_t type. Which means it did conversion
> > > >    from Latin1 (ISO-8859-1) to Unicode because first 256
> > > >    Unicode code points matches 8bit ISO-8859-1 codepage table.
> > > >    So when iocharset was specified and codepage not, then
> > > >    codepage used implicit value "iso8859-1".
> > > >
> > > > So when hsb->nls_disk is not set and hsb->nls_io is then explicitly=
 set
> > > > hsb->nls_disk to "iso8859-1".
> > > >
> > > > Such setup is obviously incompatible with Mac OS systems as they do=
 not
> > > > support iso8859-1 encoding for hfs. So print warning into dmesg abo=
ut this
> > > > fact.
> > > >
> > > > After this change hsb->nls_disk is always set, so remove code paths=
 for
> > > > case when hsb->nls_disk was not set as they are not needed anymore.
> > >
> > >
> > > Sounds reasonable. But it will be great to know that the change has b=
een tested reasonably well.
> >
> > I don't think it's reasonable to ask Pali to test every single filesyst=
em.
> > That's something the maintainer should do, as you're more likely to hav=
e
> > the infrastructure already set up to do testing of your filesystem and
> > be aware of fun corner cases and use cases than someone who's working
> > across all filesystems.
>
> This patch series is currently in RFC form, as stated in cover letter
> mostly untested. So they are not in form for merging or detailed
> reviewing. I just would like to know if this is the right direction with
> filesystems and if I should continue with this my effort or not.
> And I thought that sending RFC "incomplete" patches is better way than
> just describing what to do and how...



--=20
Thanks,

Steve
