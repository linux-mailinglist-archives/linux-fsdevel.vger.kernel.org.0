Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF43ECCE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 05:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhHPDBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhHPDA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:00:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19442C061764;
        Sun, 15 Aug 2021 20:00:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k5so3768468lfu.4;
        Sun, 15 Aug 2021 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVxo0TU1/PZKTtidRHbhDfJ247pdNPz8xHTGf3pxWZE=;
        b=ihucGqvPgXI3Q6uE/m5kq1YEuqWcpsa4C1ezuf1fv7ZJUx5qyF0/GwWMt3KgSMuXhU
         rZpcxtJHUGm7BAuZTrRIGunaQJn7TY5bkbxi6QREE2J5vcnzUMcOHyN3XcTFvDJ3Kf96
         JLvB2DCuRyDPZkqmGTAFe4kEMzLGV+jX4bvYNpAkZj/k73gSj6bl6PYz7hSy+7SQKYYc
         Uge1NzbSQQS1Zmtz9C+K9/uaELSMIJJnQZhXSYsI1WScMfG1y34mVeBWo6LMS+0FKjbn
         CQjgnVt9ixuseMQSWx8M5q1f/JEt8tl3Wr4rqkfpQgsfE3QJSIizuP0cJTthUqEIgog7
         uUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVxo0TU1/PZKTtidRHbhDfJ247pdNPz8xHTGf3pxWZE=;
        b=hglecNAWkssXVEG0hHq53WtQudBJ+mSTGfwGZ9HlRNVNdvdCYmTfkCgzm05v1IfUDf
         lNahQALXerc8bP3JIz32ByJT/An2XjXmGJTcfPSjiXoVOCJxNuW86T9rRIVWQuYdOFHR
         e5vR+JYC/npah1MZDGWVXAl/yrYuODmHsjwnp+giJj/gx6EQ+61QwNyZr66Vmkiuq1Kb
         qaVCfKPac0CLy0XRYn6iGe0709urmnwSsNxAgyrmEPb+nuLyMd16VZ3JcIp+3rQUjHdW
         Zwn/KC68Rpdaq097jiZLVE6Lv8uyiRZw4Ez0uSMO2JrUW75n8LmvYgQxUEruFdmVMyTg
         ct7A==
X-Gm-Message-State: AOAM530YMMX/h25B6lpmaM6pjgOmxIKwErF3Y+tHjjbmB3aFRDS6Jmn7
        GHTVtxpwOXifwmi+awNmFKs=
X-Google-Smtp-Source: ABdhPJySVRynnB0BISUVxbKKXS6GOaAOFU/7gx4atEEA98LMe/FDhrLKjMYzXxvyFWhbQo3ydspnfQ==
X-Received: by 2002:a05:6512:33c7:: with SMTP id d7mr7655994lfg.545.1629082823521;
        Sun, 15 Aug 2021 20:00:23 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id h6sm890880lfu.230.2021.08.15.20.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 20:00:23 -0700 (PDT)
Date:   Mon, 16 Aug 2021 06:00:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: Re: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
Message-ID: <20210816030021.dgd6xrsjcuajkaq7@kari-VirtualBox>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
 <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
 <a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 04:11:10PM +0000, Konstantin Komarov wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Sent: Friday, July 30, 2021 8:24 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Leonidas P. Papadakos <papadakospan@gmail.com>; zajec5@gmail.com; Darrick J. Wong <djwong@kernel.org>; Greg Kroah-
> > Hartman <gregkh@linuxfoundation.org>; Hans de Goede <hdegoede@redhat.com>; linux-fsdevel <linux-fsdevel@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Al Viro <viro@zeniv.linux.org.uk>; Matthew Wilcox <willy@infradead.org>
> > Subject: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
> > 
> > On Fri, Jul 30, 2021 at 8:55 AM Konstantin Komarov
> > <almaz.alexandrovich@paragon-software.com> wrote:
> > >
> > > We've just sent the 27th patch series which fixes to the buildability against
> > > current linux-next. And we'll need several days to prepare a proper pull request
> > > before sending it to you.
> > 
> > Well, I won't pull until the next merge window opens anyway (about a
> > month away). But it would be good to have your tree in linux-next for
> > at least a couple of weeks before that happens.
> > 
> > Added Stephen to the participants list as a heads-up for him - letting
> > him know where to fetch the git tree from will allow that to happen if
> > you haven't done so already.
> > 
> 
> Thanks for this clarification, Linus!
> Stephen, please find the tree here:
> https://github.com/Paragon-Software-Group/linux-ntfs3.git
> It is the fork from 5.14-rc5 tag with ntfs3 patches applied.
> Also, the latest changes
> - fix some generic/XYZ xfstests, which were discussed
> with Theodore, Darrick and others
> - updates the MAINTAINERS with mailing list (also added to CC here) and scm tree link.

Can you please send this also as normal patch series to mailing lists so
we can comment there.

One thing a like to ask you to do before that is add reviewed-by tag
and signed-off-by tag as stated here
https://lore.kernel.org/linux-fsdevel/20210810054637.aap4zuiiparfl2gq@kari-VirtualBox/
and
https://lore.kernel.org/linux-fsdevel/20210810074740.mkjcow2inyjaakch@kari-VirtualBox/

> Please let me know if additional changes requred to get fetched into linux-next.
> 
> > The one other thing I do want when there's big new pieces like this
> > being added is to ask you to make sure that everything is signed-off
> > properly, and that there is no internal confusion about the GPLv2
> > inside Paragon, and that any legal people etc are all aware of this
> > all and are on board. The last thing we want to see is some "oops, we
> > didn't mean to do this" brouhaha six months later.
> > 
> > I doubt that's an issue, considering how public this all has been, but
> > I just wanted to mention it just to be very obvious about it.
> > 
> >                   Linus
> Indeed, there is no internal confusion about the GPLv2 and we mean to make this contribution.
> 
> Best regards,
> Konstantin.
