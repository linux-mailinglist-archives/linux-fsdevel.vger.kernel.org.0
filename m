Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBC305CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313591AbhAZWiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbhAZUXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:23:43 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F9C061574;
        Tue, 26 Jan 2021 12:23:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n42so17525796ota.12;
        Tue, 26 Jan 2021 12:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sHBqGg7Zd3ZBa+/Y7qm8JDSQDKowoxEDhktZKpfDVQ=;
        b=KXkx5d4sUxYTOvTF7gRRbxw6TEVZKzwoeFBBK196bvyMZF6pXhkZJdSpYACAEPyxmj
         lOZN2dN7p0wDndRogQn7Pd/iANbqMzsLBvhJ4Kk0EJ6SETv7jqp086n+f9T3OMtpZdoA
         0mBxUKf4Lgddj5VSxdTmKVBY0eCSsGPLCLQur4FxOss08zRpUHwlU+hTpYxjv7l34dF3
         w5YGCd3xdUUMao6VeF/77/VIB2F6BBE16R93DZ89disPYcyzdae4N7NFL5+AAPCbW7gO
         8sA0O7pRIcRgWhqRSW/FCddtvVTvaC6CvjkYh2SXDfSDHXL+5FmJ9K4fvtUmUHjYMfHI
         VHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sHBqGg7Zd3ZBa+/Y7qm8JDSQDKowoxEDhktZKpfDVQ=;
        b=oI9fPjh8MZE/YB8qD4MpR/W5FrkB0CN5yn2227dACqilHfsq0CuGyvnZAtezK4gXna
         G4OnEOmHJbN7XSa3Rp3sBADicqfBocy681Z0cWX6gKj5PVGfBx68CKDnDMqe/PrUrEo0
         kuuMhXaVdd43IRRL1Lt40MBCNnHJUpGm0/44t5b7DpF8jOXmMWa2EhyWC8mBUmGSX+1x
         uHndX+3B2HlerVMSImgkBirbjhctwr0nQ0idPDjEAA1tY6yS6PWuo1udQT0Cr0Zrh+6k
         tQD9hm6HupK1vGjcC7w8vhXsTed6954gniHBaDforUX3lfunPjdvTUvhvpSjQGET7cBO
         MIdg==
X-Gm-Message-State: AOAM5336mmzrS+Ip5Y7pEpsIWZHZwJrHpLoMLp8lsF4Q+hL8Hd0d13NR
        IkLM/16r/U8GkC4SInvTkVX+VGWyZfDGbbZLpXNWcY8a6Eg=
X-Google-Smtp-Source: ABdhPJydJKwYgmzSRDhy0oro307T8H3VsrUeyubaJ7SnbCg8rmXVAf+p/W3wSMTP/4Kl09XSM0cOPtcphypPBNDeVGY=
X-Received: by 2002:a9d:1421:: with SMTP id h30mr5365576oth.45.1611692581570;
 Tue, 26 Jan 2021 12:23:01 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <20210126191716.GN308988@casper.infradead.org>
In-Reply-To: <20210126191716.GN308988@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 12:22:50 -0800
Message-ID: <CAE1WUT61OwLSSRCvEe3FLjAASre42iOe=UfPX4uDbDrQ11PAYg@mail.gmail.com>
Subject: Re: Getting a new fs in the kernel
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:18 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 26, 2021 at 08:23:03AM -0800, Amy Parker wrote:
> > Kernel development newcomer here. I've begun creating a concept for a
> > new filesystem, and ideally once it's completed, rich, and stable I'd
> > try to get it into the kernel.
> >
> > What would be the process for this? I'd assume a patch sequence, but
> > they'd all be dependent on each other, and sending in tons of
> > dependent patches doesn't sound like a great idea. I've seen requests
> > for pulls, but since I'm new here I don't really know what to do.
>
> Hi Amy,
>
> Writing a new filesystem is fun!  Everyone should do it.
>
> Releasing a filesystem is gut-churning.  You're committing to a filesystem
> format that has to be supported for ~ever.

I'm bored and need something to dedicate myself to as a long-term commitment.

>
> Supporting a new filesystem is a weighty responsibility.  People are
> depending on you to store their data reliably.  And they demand boring
> and annoying features like xattrs, acls, support for time after 2038.



>
> We have quite a lot of actively developed filesystems for users to choose
> from already -- ext4, btrfs, xfs are the main three.  So you're going
> to face a challenge persuading people to switch.
>

Yeah, understandable.

> Finally, each filesystem represents a (small) maintainance burden to
> people who need to make changes that cross all filesystems.  So it'd
> be nice to have a good justification for why we should include that
> cost.

Alright, I'll keep that in mind.

>
> Depending exactly what your concept is, it might make more sense to
> make it part of an existing filesystem.  Or develop it separately
> and have an existing filesystem integrate it.

That's what other people have suggested as well, so I'll start
considering trying to add any features I come up with into other
filesystems as well.

>
> Anyway, I've been at this for twenty years, so maybe I'm just grouchy
> about new filesystems.  By all means work on it and see if it makes
> sense, but there's a fairly low probability that it gets merged.

Alright. Thanks for the advice!

Best regards,
Amy Parker
(she/her/hers)
