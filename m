Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA117CB71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCGDOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 22:14:49 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:37876 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGDOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:14:48 -0500
Received: by mail-yw1-f48.google.com with SMTP id i1so39350ywf.4;
        Fri, 06 Mar 2020 19:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZEHHT6lAR6svoMasB13SgNuVP0MyXR1N2GanpY6GnE=;
        b=JWZbawBN+AvkFClWdbF9gaYKLkGD+MiEj3bA/grN4IT7mezq5F8r8qyrWuvH6DJyAd
         k1NpQCsqIzkRn9yPsH7Yt8jY6O+71AS5vYRqRTcjD9ZuSjjUa0Dq6pQ2H8laXyATOUn4
         HDg3yOA6C1H/+qoRlczbbGnt8ThWPfmV7uou6jiw5aHaPE6PoI/3We+RpiizN1/ESjcL
         r7hk4JX7OuGRu/yyiT8TsP3RACXbcBqTVhtszcj3LwEqlv5s0eyvNg9YlT8/gwkCK+g6
         UX4A8E+EWrVbzDefMxHkx4JoOPQgmLWDNTMe/zVW6gO+T7/z4pQ43Od8UewolW59znzh
         8SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZEHHT6lAR6svoMasB13SgNuVP0MyXR1N2GanpY6GnE=;
        b=BNi/rN9ER2qDm+OaS7WiJgvRklTBDya5H/vIsEXFuDkDricUby8+Xfr57pjdYwggoV
         Y3Pjvi4ov41834qmZ0HMx/YTvWT/DA0gimA+YM89tIluDsB8SPOuGb3Gq/RsvYBndcXQ
         OM8BlMHtmI9itzZArvBCzyKgSoVPqH/iKU14IOfw20/DaAPMnPUKyapqtxIrNnUA52aR
         s0p0ZvMzN3TyflEA3NqjOzWLwPIiZEpHmfa2RaDtkpARGddBY81goHze1RCzdsiJ1pIU
         ROj9n1r5/B8dZ/9aGLhwHCFmLm1UJeG5p9nhtYwFfF34Zxtl7OG3+kRkqGXnCgQbrb/F
         vrDw==
X-Gm-Message-State: ANhLgQ146Nf20Tlal6AhQrE1UCmKOWfRKppLRA11HyGnpDdmupYmgP2m
        p25oRVgVBXZ+He7fde1SnB5EHJbREEsMppgzDIgrnYNh
X-Google-Smtp-Source: ADFU+vv1lbhShZquHVK69ApmFg8EyJmgI9xs6Kpib/27Oz8EplISUurSto5A/rirLzgeUMlkWQzIJWqDS4ECqgOsgQA=
X-Received: by 2002:a25:e805:: with SMTP id k5mr7218096ybd.14.1583550886710;
 Fri, 06 Mar 2020 19:14:46 -0800 (PST)
MIME-Version: 1.0
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 6 Mar 2020 21:14:35 -0600
Message-ID: <CAH2r5ms6epOL0sXRfNNTM_J=K-dnGYNS_wK1rgw1VBqipM6kxQ@mail.gmail.com>
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't forget about Vault - there were some very useful hallway
discussions at Vault this year as well ... even if a bit smaller than
it should be ...

On Fri, Mar 6, 2020 at 8:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
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
> could accomplish our main goals with Plumbers without having to deal with all of
> the above problems.
>
> 1) The invitation process.  This goes away.  The people/companies that want to
> discuss things with the rest of us can all get to plumbers the normal way.  We
> get new blood that we may miss through the invitation process because they can
> simply register for Plumbers on their own.
>
> 2) Presentations.  We can have track miniconfs where we still curate talks, but
> there could be much less of them and we could just use the time to do what
> LSFMMBPF was meant to do, put us all in a room so we can hack on things together.
>
> 3) BOFs.  Now all of the xfs/btrfs/ext4 guys can show up, because again they
> don't have to worry about some invitation process, and now real meetings can
> happen between people that really want to talk to each other face to face.
>
> 4) Planning becomes much simpler.  I've organized miniconf's at plumbers before,
> it is far simpler than LSFMMBPF.  You only have to worry about one thing, is
> this presentation useful.  I no longer have to worry about am I inviting the
> right people, do we have enough money to cover the space.  Is there enough space
> for everybody?  Etc.
>
> I think this is worth a discussion at the very least.  Maybe killing LSFMMBPF is
> too drastic, maybe there are some other ideas that would address the same
> problems.  I'd love to hear the whole communities thoughts on this, because
> after all this is supposed to be a community event, and we should all be heard.
> Thanks,
>


-- 
Thanks,

Steve
