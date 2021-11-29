Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE30462486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhK2WUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhK2WSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:18:08 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAFC052933;
        Mon, 29 Nov 2021 11:12:29 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m5so18516666ilh.11;
        Mon, 29 Nov 2021 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4a7oBUxp83d4F7/GXAe9SjMLAHoJcQKmu6hyXTlCwds=;
        b=a4LrfTUVENBGyIlKt1CrHgX8udUHuoaGeZsZu5z3AdXh8gWn1zJwoemtgQ6731Z86V
         n1xxEz4rDEqXvojdf2Tsv7JnDexj9WQYvKXX+xsckI8xY0HAdT94/GM0xoqCz1CNiX6C
         zihDbv3VtjSVX3EqXRTfDaccWhZujitGZz4BeapUMje9yLqHITthqJPbfx4TF0pdSBum
         ZOGm+7V7Q1GK45ijP33f7klQyO8TtN16hYZPAQuc9K0EPqP2sSsiUXVh1si2jHIIYoWx
         15ltGlZ9XRhOA0Mu0JvI3WXGAuctF+dnSzFNKg2GJ59miUnXTn1DlIvK7TvsNf8SI1+U
         LS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a7oBUxp83d4F7/GXAe9SjMLAHoJcQKmu6hyXTlCwds=;
        b=0Yi72pUu+y3WTNljyCo3+v3ho5pRf2X9JmQuYC3IrwixlQOAKBUpHlAhdg6jg8n+od
         PZuziD/ZE756GT4Fqqh/mXKONvuuouXl2uvLm84EmShok2d4PoSToMtG2HQAC0zu9Q3j
         i70U2WMOGzU78ShLYVCiPXJnwVEP6uSRvcCJxIcwm0oeIejtJtVkPF6Hmqo9w4x3KIoX
         1kbKaHsiavM6fNJCuLBz9PJf3NndoNyhfldKwW30TSizO2FNElE2XX2yOd14q6mMpdfg
         N+9OlWA6UcdQzqjfuoJE0J5/lAsQcm+Jq6yhtoyWraq5MP1YZmdpBTNfJTIJklirZKxA
         U1cw==
X-Gm-Message-State: AOAM5319VvF9IuepcJoZ4Odh8KnwSbuAbbUnVPsLESK3u+bnHgwRqK9w
        wEh5367/7sL7WFkjUKdyrW8htoXD9vSlVhsrB//+LD0u
X-Google-Smtp-Source: ABdhPJwGjkUK27Bmivk+PeedOlQhOHceK/+iW2ainthRulbC4BrWnAb5YItstXAk0fKNuwyJD0npw2/QgN/xcYYm/sw=
X-Received: by 2002:a05:6e02:1ba8:: with SMTP id n8mr48485335ili.254.1638213149275;
 Mon, 29 Nov 2021 11:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20211119071738.1348957-1-amir73il@gmail.com> <20211126152841.GK13004@quack2.suse.cz>
In-Reply-To: <20211126152841.GK13004@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 29 Nov 2021 21:12:17 +0200
Message-ID: <CAOQ4uxhRv=2q3K89QG3T=Xne4PLUpN_sh8R=+PZETUa9GEJt-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Extend fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 26, 2021 at 5:28 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Fri 19-11-21 09:17:29, Amir Goldstein wrote:
> > This is the 2nd version of FAN_REPORT_TARGET_FID patches [1].
> >
> > In the first version, extra info records about new and old parent+name
> > were added to FAN_MOVED_FROM event.  This version uses a new event
> > FAN_RENAME instead, to report those extra info records.
> > The new FAN_RENAME event was designed as a replacement for the
> > "inotify way" of joining the MOVED_FROM/MOVED_TO events using a cookie.
> >
> > FAN_RENAME event differs from MOVED_FROM/MOVED_TO events in several ways:
> > 1) The information about old/new names is provided in a single event
> > 2) When added to the ignored mask of a directory, FAN_RENAME is not
> >    reported for renames to and from that directory
> >
> > The group flag FAN_REPORT_TARGET_FID adds an extra info record of
> > the child fid to all the dirent events, including FAN_REANME.
> > It is independent of the FAN_RENAME changes and implemented in the
> > first patch, so it can be picked regardless of the FAN_RENAME patches.
> >
> > Patches [2] and LTP test [3] are available on my github.
> > A man page draft will be provided later on.
>
> I've read through the series and I had just two small comments. I was also
> slightly wondering whether instead of feeding the two directories for
> FS_RENAME into OBJ_TYPE_PARENT and OBJ_TYPE_INODE we should not create
> another iter_info type OBJ_TYPE_INODE2 as using OBJ_TYPE_PARENT is somewhat
> error prone (you have to get the ordering of conditions right so that you
> catch FS_RENAME e.g. before some code decides event should be discarded
> because it is parent event without child watching). But I have not fully
> decided whether the result is going to be worth it so I'm just mentioning
> it as a possible future cleanup.

I managed to use ITER_TYPE_INODE2 pretty easily after a cleanup that
splits OBJ_TYPE enum from ITER_TYPE enum.

Thanks,
Amir.
