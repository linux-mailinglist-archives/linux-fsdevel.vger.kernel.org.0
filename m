Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7144402FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbhIGUtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbhIGUtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:49:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBCC061575;
        Tue,  7 Sep 2021 13:47:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 6so107555oiy.8;
        Tue, 07 Sep 2021 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UopwoFn7rqfh5UL49/4APVM7g8LLvGNu8u3opnFNc2M=;
        b=d9GH4MSSomWd+TKdZBGJoBuJk9sGkSDpXWx6iBm+Bz6kOHnqz1OO8gIpo+FBeJItw2
         zrBk832kEv8OerXc0q77211wGWbsGk9W2wYVXVH5L5o2PJGl58H+dSFa2a81xtPvC/8l
         JRMI/DUMXpN3SxfBpv0uZisT9VS2pySj3GyzG26O3avpYH3AP4EKmR7stPM8qlJoXTzp
         N+a41OLUOsf+4wFrrFBLUJdeY9XD0TQ49FIa3SV7vLokHDUMldiGPdkZQKKRFKTAOK8F
         2ABEywcaEKKfEIsq0fZruRbgPk0cdMZAm0DhzetPPck+o1yCTTrUPlgtsBEuc+TUvbGi
         qBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UopwoFn7rqfh5UL49/4APVM7g8LLvGNu8u3opnFNc2M=;
        b=WocvnVBFPTY3i9ZfOk/KoYupPsghrxz6sz4lPx9C42qjYSPeGpl7ZTJwRz0iGs5e2Z
         gA9Cfg85AkKfG9+SfB/2pgUOV5IyeYXQzVJ0w17CdTmk34srbgOaj7VUG77GenAgSz8C
         vWRkpt5PKcH7Ocggl920tDEVaMxWpgIrRp/RJa9TvP2W0yXuD5zUoYsO/DEBb0Wx/kCr
         FVPmkPfA5H3WieuoHB+3pheLnYtBAkqo90b/ymqNRvH8MbqpKs1yqQ5T2MUrYM7CU8C5
         vBXT/TVsco7Y0qS8ISeov2I/rFskAC8Sb7FrmCTxs66xJhVCSUDKK07UuHSiNTkczAhI
         d2Kg==
X-Gm-Message-State: AOAM530o3oN82lCckCpTxgybhYkdm4cpNcvCgQjtiMckEmNOXndOI1+7
        rRWGEUdwBnYMO7MBcIPoqNLwSfwfAFvEBaIbZa39JbEUSM4L7w==
X-Google-Smtp-Source: ABdhPJwgnAxOzHlN5kUGiujwfo4/KLkFbgPPlSslacq4qvxiaXwPBsJux4afJod6S7AxtahsF30JNkQIckD99eekPM8=
X-Received: by 2002:a05:6808:209a:: with SMTP id s26mr20818oiw.98.1631047678287;
 Tue, 07 Sep 2021 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox> <69c8ab24-9443-59ad-d48d-7765b29f28f9@paragon-software.com>
 <CAHp75Vd==Dm1s=WK9p2q3iEBSHxN-1spHmmtZ21eRNoqyJ5v=Q@mail.gmail.com>
In-Reply-To: <CAHp75Vd==Dm1s=WK9p2q3iEBSHxN-1spHmmtZ21eRNoqyJ5v=Q@mail.gmail.com>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Tue, 7 Sep 2021 23:47:47 +0300
Message-ID: <CAC=eVgTwDsE+i3jG+iwZJhFDBXzCyPprRnGk5tjUKXP+Ltrw4w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, September 7, 2021, Andy Shevchenko
(andy.shevchenko@gmail.com) wrote:
> On Tuesday, September 7, 2021, Konstantin Komarov <almaz.alexandrovich@paragon-software.com> wrote:
>> On 07.09.2021 10:36, Kari Argillander wrote:
>> > On Sun, Aug 29, 2021 at 12:56:05PM +0300, Kari Argillander wrote:
>> >> See V2 if you want:
>> >> lore.kernel.org/ntfs3/20210819002633.689831-1-kari.argillander@gmail.com
>> >>
>> >> NLS change is now blocked when remounting. Christoph also suggest that
>> >> we block all other mount options, but I have tested a couple and they
>> >> seem to work. I wish that we do not block any other than NLS because
>> >> in theory they should work. Also Konstantin can comment about this.
>> >>
>> >> I have not include reviewed/acked to patch "Use new api for mounting"
>> >> because it change so much. I have also included three new patch to this
>> >> series:
>> >>      - Convert mount options to pointer in sbi
>> >>              So that we do not need to initiliaze whole spi in
>> >>              remount.
>> >>      - Init spi more in init_fs_context than fill_super
>> >>              This is just refactoring. (Series does not depend on this)
>> >>      - Show uid/gid always in show_options()
>> >>              Christian Brauner kinda ask this. (Series does not depend
>> >>              on this)
>> >>
>> >> Series is ones again tested with kvm-xfstests. Every commit is build
>> >> tested.
>> >
>> > I will send v4 within couple of days. It will address issues what Pali
>> > says in patch 8/9. Everything else should be same at least for now. Is
>> > everything else looking ok?
>> >
>>
>> Yes, everything else seems good.
>> We tested patches locally - no regression was
>
> The formal answer in such case should also contain the Tested-by tag. I would suggest you to read the Submitting Patches document (available in the Linux kernel source tree).

He is a maintainer so he can add tags when he picks this up. This is not
really relevant here. Yes it should be good to include that but I have already
sended v4 which he has not tested. So I really cannot put this tag for him.
So at the end he really should not even put it here.

Also usually the maintainers will always make their own tests and usually
they will not even bother with a tested-by tag. Or do you say to me that I
should go read Submitting Patches document as I'm the one who submit
this?

  Argillander

>> >>
>> >> v3:
>> >>      - Add patch "Convert mount options to pointer in sbi"
>> >>      - Add patch "Init spi more in init_fs_context than fill_super"
>> >>      - Add patch "Show uid/gid always in show_options"
>> >>      - Patch "Use new api for mounting" has make over
>> >>      - NLS loading is not anymore possible when remounting
>> >>      - show_options() iocharset printing is fixed
>> >>      - Delete comment that testing should be done with other
>> >>        mount options.
>> >>      - Add reviewed/acked-tags to 1,2,6,8
>> >>      - Rewrite this cover
>> >> v2:
>> >>      - Rewrite this cover leter
>> >>      - Reorder noatime to first patch
>> >>      - NLS loading with string
>> >>      - Delete default_options function
>> >>      - Remove remount flags
>> >>      - Rename no_acl_rules mount option
>> >>      - Making code cleaner
>> >>      - Add comment that mount options should be tested
>> >>
>> >> Kari Argillander (9):
>> >>   fs/ntfs3: Remove unnecesarry mount option noatime
>> >>   fs/ntfs3: Remove unnecesarry remount flag handling
>> >>   fs/ntfs3: Convert mount options to pointer in sbi
>> >>   fs/ntfs3: Use new api for mounting
>> >>   fs/ntfs3: Init spi more in init_fs_context than fill_super
>> >>   fs/ntfs3: Make mount option nohidden more universal
>> >>   fs/ntfs3: Add iocharset= mount option as alias for nls=
>> >>   fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
>> >>   fs/ntfs3: Show uid/gid always in show_options()
>> >>
>> >>  Documentation/filesystems/ntfs3.rst |  10 +-
>> >>  fs/ntfs3/attrib.c                   |   2 +-
>> >>  fs/ntfs3/dir.c                      |   8 +-
>> >>  fs/ntfs3/file.c                     |   4 +-
>> >>  fs/ntfs3/inode.c                    |  12 +-
>> >>  fs/ntfs3/ntfs_fs.h                  |  26 +-
>> >>  fs/ntfs3/super.c                    | 486 +++++++++++++++-------------
>> >>  fs/ntfs3/xattr.c                    |   2 +-
>> >>  8 files changed, 284 insertions(+), 266 deletions(-)
>> >>
>> >> --
>> >> 2.25.1
>> >>
>> >>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
