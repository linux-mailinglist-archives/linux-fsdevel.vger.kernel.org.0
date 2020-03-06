Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC117C1D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCFPal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 10:30:41 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36438 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFPal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:30:41 -0500
Received: by mail-il1-f196.google.com with SMTP id b17so2399320iln.3;
        Fri, 06 Mar 2020 07:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaUvvlUUv9vAigVAnuJ2Dl3vfVEvB3Ndkue79uzAzJs=;
        b=J6AvZ7QtBCSBaZVjgr1qzZNBaDxjmmwwvtrGr2f8BspXkp1CfeVJLJ0ALiA2tpfpIL
         Dt+eMXbKcmgmlBm7c6dy8mZJ939UUU4k7YtGYNVhxHMxJVv2wsAQxRlqZIJaVBXTEjD4
         cnU0hS2ybpJY3WR1Z1Mn1M0pgX95zbS7y0A84C+q01pzTNKPu1eoXGVKZc53cxZkg1dA
         TKlZSUHkDNVKjksHKSaHwlXMcG4zXG64h20QFrHrl2K68PPvKTS10EDZTL46fAZV9NE5
         a7naCRe+2J0VKofVE1gqRM+tvO7D+zRuwW+4cdfkBCvxiD2mrPbE5zPtKA3BraZpfn8h
         jAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaUvvlUUv9vAigVAnuJ2Dl3vfVEvB3Ndkue79uzAzJs=;
        b=ksgdW9UMkdK3xztjDMGFuyqt8bdmJ4eA6CgADN6HrGPo2DbAQPAbYmR1AOdOK+hTHB
         OYpePTSeS7QvJ9qtceARVT6gO2R5ervmA1IDIFWNBwNI8OzdfC3Slg0RZPrfmhWLjw3t
         y0fhOkeLe1ibS87CZyzKQsX3dHAjwIbD+CWKDvDkIo2uth51g/CqaSvSxuLkMyuwvi4S
         xjFQTV9icTddBGrdRXV1oGpGxxzD3nu8QHIj3THV6GHW7fBNAPNmsXmse3jlzV5QFf5g
         94/rLy+dgrDKP6y06lMwGTvYtpJkpy2r6QkylqVFcs7nUvPabHnquCCmidIViIIvCxmw
         xBfA==
X-Gm-Message-State: ANhLgQ07JhnsVGiFTRDf2vDLNCWhL9+igN8FWfqLMwWsE9R1VS9PXXJR
        tkfcBf62UKzIQmlLVu50INmElfCb9u9KWRpRrEL92w==
X-Google-Smtp-Source: ADFU+vu4KOzq3lSXEUVGr2ih0QhccA2P1sa4V5JsgJfhOk4JJl0/m84ZBrWnh+8HjLsfNQkEeeJ3lU/dThrteAO7iAQ=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr3838288ili.72.1583508638771;
 Fri, 06 Mar 2020 07:30:38 -0800 (PST)
MIME-Version: 1.0
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 Mar 2020 17:30:27 +0200
Message-ID: <CAOQ4uxjJ794BRJZeGKPMBmL7WbUVh1SHWXe9XaSfzq5d46hd0w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSFMMBPF TOPIC] Killing LSFMMBPF
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:35 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Hello,
>
> This has been a topic that I've been thinking about a lot recently, mostly
> because of the giant amount of work that has been organizing LSFMMBPF.  I was
> going to wait until afterwards to bring it up, hoping that maybe it was just me
> being done with the whole process and that time would give me a different
> perspective, but recent discussions has made it clear I'm not the only one.
>
> LSFMMBPF is not useful to me personally, and not an optimal use of the
> communities time.  The things that we want to get out of LSFMMBPF are (generally)
>
> 1) Reach consensus on any multi-subsystem contentious changes that have come up
> over the past year.
>
> 2) Inform our fellow developers of new things that we are working on that we
> would like help with, or need to think about for the upcoming year.
>
> 3) "Hallway track".  We are after all a community, and I for one like spending
> time with developers that I don't get to interact with on a daily basis.
>
> 4) Provide a way to help integrate new developers into the community with face
> time.  It is far easier to work with people once you can put a face to a name,
> and this is especially valuable for new developers.
>

5) There is another unspoken benefit that people wanted to get from LSF/MM (*)
and you mentioned it below that is to get the high level VFS/MM maintainer
in the room.

I think that was not always the case with Plumbers (not sure?), but if LF is
going the make sure that Plumbers stays co-located with the maintainers
summit and we "nominate" Plumbers as the official replacement for LSF/MM,
then this will probably sort itself out.

(*) I've intentionally left out BPF, because I think it always has a miniconf
of its own in Plumbers anyway.

> These are all really good goals, and why we love the idea of LSFMMBPF.  But
> having attended these things every year for the last 13 years, it has become
> less and less of these things, at least from my perspective.  A few problems (as
> I see them) are
>
> 1) The invitation process.  We've tried many different things, and I think we
> generally do a good job here, but the fact is if I don't know somebody I'm not
> going to give them a very high rating, making it difficult to actually bring in
> new people.
>
> 2) There are so many of us.  Especially with the addition of the BPF crowd we
> are now larger than ever.  This makes problem #1 even more apparent, even if I
> weighted some of the new people higher who's slot should they take instead?  I
> have 0 problems finding 20 people in the FS community who should absolutely be
> in the room.  But now I'm trying to squeeze in 1-5 extra people.  Propagate that
> across all the tracks and now we're at an extra 20ish people.
>
> 3) Half the people I want to talk to aren't even in the room.  This may be a
> uniquely file system track problem, but most of my work is in btrfs, and I want
> to talk to my fellow btrfs developers.  But again, we're trying to invite an
> entire community, so many of them simply don't request invitations, or just
> don't get invited.
>
> 3) Sponsorships.  This is still the best way to get to all of the core
> developers, so we're getting more and more sponsors in order to buy their slots
> to get access to people.  This is working as intended, and I'm not putting down
> our awesome sponsors, but this again adds to the amount of people that are
> showing up at what is supposed to be a working conference.
>
> 4) Presentations.  90% of the conference is 1-2 people standing at the front of
> the room, talking to a room of 20-100 people, with only a few people in the
> audience who cares.  We do our best to curate the presentations so we're not
> wasting peoples time, but in the end I don't care what David Howells is doing
> with mount, I trust him to do the right thing and he really just needs to trap
> Viro in a room to work it out, he doesn't need all of us.
>
> 5) Actually planning this thing.  I have been on the PC for at least the last 5
> years, and this year I'm running the whole thing.  We specifically laid out
> plans to rotate in new blood so this sort of thing stopped happening, and this
> year we've done a good job of that.  However it is a giant amount of work for
> anybody involved, especially for the whole conference chair.  Add in something
> like COVID-19 to the mix and now I just want to burn the whole thing to the
> ground.  Planning this thing is not free, it does require work and effort.
>
> So what do I propose?  I propose we kill LSFMMBPF.
>
> Many people have suggested this elsewhere, but I think we really need to
> seriously consider it.  Most of us all go to the Linux Plumbers conference.  We

Some of us have had to choose whether to go to LSF/MM or to Plumbers in a
given year. I know that merging them will make it easier for me.

Thanks,
Amir.
