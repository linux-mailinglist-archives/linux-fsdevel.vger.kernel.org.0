Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854193118AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBFCnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBFCiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:25 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559BC08ECB7;
        Fri,  5 Feb 2021 14:49:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id v193so3773465oie.8;
        Fri, 05 Feb 2021 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojF9+RHOmAuEE2HU5gcyNLd/Z5tAjeBRPHoUC6HrwLk=;
        b=pxi2+PLhskq0A6d7mF2s7rrouvzdsM7TSvqes8XQR/F3NXfqa0wWJUe1Nk4E62fGTN
         4RJCTUzsOFzBU4hX65dVsID04WW9kaGGTFK9qXUhYdywSDV/OBVI+rDk0jTGCyPBDS3z
         df4dtFhAuuOcjxlQ1VwmF6nZ1DTthI1O0XqETBs3Ol3UvqiONXm7brZMf1BE0mTiPKiJ
         hNcLuUtc5Hfxay5T13zHan0MwnlCHvQKH4NQ0rew167memQe0wC82ETHyQYyfxmwijEA
         SPDwzEI9NckT9eK3sAiohPDBx7xozjfugZIxfR3J0e02SFozyqCYrwfJLI2ux6ul14tJ
         Q8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojF9+RHOmAuEE2HU5gcyNLd/Z5tAjeBRPHoUC6HrwLk=;
        b=SMy8IvyF4Cw2Cy4k2MsO3lPpHzW08RmVy+fR8ryXIxNNtEzb8R9+szpSqU45CQrH3T
         IKieJbAxsWbpnAVweXPMPu2kdymCEh5scidjAsaLyScDNutEbOMOvfgRu+MQgbtswhvn
         hZtZqB70BN3u5iUIp+ifKJ35Ji8QEJ2x9d3dL9az6lZ7Zh2Wqo4V698kGTaRIpLoY8xp
         ov9i47lscTiDRp77/yOBRrhB5lPmiMIBit/G1zPjXRH22lw39kgBgyvAku9SsR6zRo+h
         KvekiwGPcDOdrDyTTb+x+30NE7CmGpGAVDpENmvMQAA9wK/HF4/6MV3fORwYb1AxbPob
         A1hg==
X-Gm-Message-State: AOAM531+0M0gv9cvTvIEtzmpRGmcwYbY7GxCeRSg3gWe9itOMXAsRR+w
        kz9DPM/Ci1EC/pG1N8vsNtaZtrGQ8JtwF5QZQbY=
X-Google-Smtp-Source: ABdhPJxWGEoiaHg3LtbwhHldZO/Ccy2pzpAfPaypv8pJs2XmNwJy81zoTYFXK5bxo+oMzZNLAk21ecWpYJiwpen9YDI=
X-Received: by 2002:aca:e108:: with SMTP id y8mr2216690oig.114.1612565353201;
 Fri, 05 Feb 2021 14:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20210205045217.552927-1-enbyamy@gmail.com> <20210205131910.GJ1993@twin.jikos.cz>
 <CAE1WUT4az3ZZ8OU2AS2xxi9h1TbW958ivNXr53jinqHK5vuzMg@mail.gmail.com> <CAFLxGvz0ZnTs1B7v3R+Zefd5BhE9ximFpgKL8zRmGfOdBrsVfw@mail.gmail.com>
In-Reply-To: <CAFLxGvz0ZnTs1B7v3R+Zefd5BhE9ximFpgKL8zRmGfOdBrsVfw@mail.gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Fri, 5 Feb 2021 14:49:02 -0800
Message-ID: <CAE1WUT6Hq=phyjW1Wv01nvG1fWOAZVEsNyrtKC6Tu37ABnU=dA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fs/efs: Follow kernel style guide
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     dsterba@suse.cz, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:37 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 11:26 PM Amy Parker <enbyamy@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 5:1 AM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Thu, Feb 04, 2021 at 08:52:14PM -0800, Amy Parker wrote:
> > > > As the EFS driver is old and non-maintained,
> > >
> > > Is anybody using EFS on current kernels? There's not much point updating
> > > it to current coding style, deleting fs/efs is probably the best option.
> > >
> >
> > Wouldn't be surprised if there's a few systems out there that haven't
> > migrated at all.
>
> Before ripping it from the kernel source you could do a FUSE port of EFS.
> That way old filesystems can still get used on Linux.

A FUSE port of EFS would be a great idea. Know anyone that would be
interested in working on it? I might try picking it up if no one else
wants it, we'll see.
