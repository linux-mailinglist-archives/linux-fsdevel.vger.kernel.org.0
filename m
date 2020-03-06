Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70117C053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFOfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 09:35:46 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:35512 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFOfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:35:46 -0500
Received: by mail-qv1-f42.google.com with SMTP id u10so1013355qvi.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gPp/JOqSfFor2drm+SXytCIq/9gBWBTnvgG0JC6dgNM=;
        b=R6D2fwgYCDJTLwCQ+Pv/dbaRa7A1QbxEYJ0FaGXrlUmQ0jE3K8WZZQ2+tGjrrmujzN
         SSy0cbS/K5s9EbOvpYY+tuPSmNKsFKDYdL8jbgzxQBRWZBn3RRdpJ3kk4tvVlY6DOULE
         nSB8pwI3jeTb7Phe1gUrVCG07Og1a7xsaUh9QuBhysVmGyRIMS96HDDBGSZCzj+mvEbo
         qmh4WOhUeYUk5TMdC65+a7f5f8E+cbZOz5jaqlYJlZNJ71vMRGi5htZWUPvn0Zsm91Yx
         MjFCxBtQ8deY5Y+57kwuvxdhumqCEff45QD4a7zc9VKE2UShFJXV1+ADY/u8mzaRYGKd
         8UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gPp/JOqSfFor2drm+SXytCIq/9gBWBTnvgG0JC6dgNM=;
        b=dMpRB680GmQHuvtmWCevzPfEuE5hRjdqC7bZhchiKYSP2O3DXR4Y/h3F+bLgi+G0vG
         bLgZLSpt3FpcqtGrL05jGWUh6T+kqgzIYrDKktJRp4ra7BC4kNeoz7TBApOskQ/WRTAY
         M/k96/ja9Tu1t5eBJIQ625t1TFdF4XmFxE+fWGa9YoFJAlT/HCHGh1fomd4dnqMvxc+l
         vHtms5esq8e3hBFJAchdSLMqokRzHCKWz+oRTRDc9fwezoWkaMibUSvGt1DL9VmoY5UC
         lgAzH7EeZxd14SClmgvZsidQtt3wsvmiFpOYtjP+e7bMD2KDRwV6Vu1Y4sTTg3wu6w59
         Ja+A==
X-Gm-Message-State: ANhLgQ0p5BBBeolEAWrMaN3qkWrwQeCbBCWJSuQs0IpmywcxZezpzPLG
        6Xrx516m4cRRM8K0r92HGJ/quA==
X-Google-Smtp-Source: ADFU+vuiL+duZGFstvBs9+qO3GxDUlu6yzHhQvnhTM1IVcevwWXdla3BuQCPBcBBX3IASwIQ5PjI6A==
X-Received: by 2002:ad4:41cf:: with SMTP id a15mr3142478qvq.125.1583505343378;
        Fri, 06 Mar 2020 06:35:43 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i1sm12426803qtg.31.2020.03.06.06.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:35:42 -0800 (PST)
To:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
From:   Josef Bacik <josef@toxicpanda.com>
Subject: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Date:   Fri, 6 Mar 2020 09:35:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This has been a topic that I've been thinking about a lot recently, mostly 
because of the giant amount of work that has been organizing LSFMMBPF.  I was 
going to wait until afterwards to bring it up, hoping that maybe it was just me 
being done with the whole process and that time would give me a different 
perspective, but recent discussions has made it clear I'm not the only one.

LSFMMBPF is not useful to me personally, and not an optimal use of the 
communities time.  The things that we want to get out of LSFMMBPF are (generally)

1) Reach consensus on any multi-subsystem contentious changes that have come up 
over the past year.

2) Inform our fellow developers of new things that we are working on that we 
would like help with, or need to think about for the upcoming year.

3) "Hallway track".  We are after all a community, and I for one like spending 
time with developers that I don't get to interact with on a daily basis.

4) Provide a way to help integrate new developers into the community with face 
time.  It is far easier to work with people once you can put a face to a name, 
and this is especially valuable for new developers.

These are all really good goals, and why we love the idea of LSFMMBPF.  But 
having attended these things every year for the last 13 years, it has become 
less and less of these things, at least from my perspective.  A few problems (as 
I see them) are

1) The invitation process.  We've tried many different things, and I think we 
generally do a good job here, but the fact is if I don't know somebody I'm not 
going to give them a very high rating, making it difficult to actually bring in 
new people.

2) There are so many of us.  Especially with the addition of the BPF crowd we 
are now larger than ever.  This makes problem #1 even more apparent, even if I 
weighted some of the new people higher who's slot should they take instead?  I 
have 0 problems finding 20 people in the FS community who should absolutely be 
in the room.  But now I'm trying to squeeze in 1-5 extra people.  Propagate that 
across all the tracks and now we're at an extra 20ish people.

3) Half the people I want to talk to aren't even in the room.  This may be a 
uniquely file system track problem, but most of my work is in btrfs, and I want 
to talk to my fellow btrfs developers.  But again, we're trying to invite an 
entire community, so many of them simply don't request invitations, or just 
don't get invited.

3) Sponsorships.  This is still the best way to get to all of the core 
developers, so we're getting more and more sponsors in order to buy their slots 
to get access to people.  This is working as intended, and I'm not putting down 
our awesome sponsors, but this again adds to the amount of people that are 
showing up at what is supposed to be a working conference.

4) Presentations.  90% of the conference is 1-2 people standing at the front of 
the room, talking to a room of 20-100 people, with only a few people in the 
audience who cares.  We do our best to curate the presentations so we're not 
wasting peoples time, but in the end I don't care what David Howells is doing 
with mount, I trust him to do the right thing and he really just needs to trap 
Viro in a room to work it out, he doesn't need all of us.

5) Actually planning this thing.  I have been on the PC for at least the last 5 
years, and this year I'm running the whole thing.  We specifically laid out 
plans to rotate in new blood so this sort of thing stopped happening, and this 
year we've done a good job of that.  However it is a giant amount of work for 
anybody involved, especially for the whole conference chair.  Add in something 
like COVID-19 to the mix and now I just want to burn the whole thing to the 
ground.  Planning this thing is not free, it does require work and effort.

So what do I propose?  I propose we kill LSFMMBPF.

Many people have suggested this elsewhere, but I think we really need to 
seriously consider it.  Most of us all go to the Linux Plumbers conference.  We 
could accomplish our main goals with Plumbers without having to deal with all of 
the above problems.

1) The invitation process.  This goes away.  The people/companies that want to 
discuss things with the rest of us can all get to plumbers the normal way.  We 
get new blood that we may miss through the invitation process because they can 
simply register for Plumbers on their own.

2) Presentations.  We can have track miniconfs where we still curate talks, but 
there could be much less of them and we could just use the time to do what 
LSFMMBPF was meant to do, put us all in a room so we can hack on things together.

3) BOFs.  Now all of the xfs/btrfs/ext4 guys can show up, because again they 
don't have to worry about some invitation process, and now real meetings can 
happen between people that really want to talk to each other face to face.

4) Planning becomes much simpler.  I've organized miniconf's at plumbers before, 
it is far simpler than LSFMMBPF.  You only have to worry about one thing, is 
this presentation useful.  I no longer have to worry about am I inviting the 
right people, do we have enough money to cover the space.  Is there enough space 
for everybody?  Etc.

I think this is worth a discussion at the very least.  Maybe killing LSFMMBPF is 
too drastic, maybe there are some other ideas that would address the same 
problems.  I'd love to hear the whole communities thoughts on this, because 
after all this is supposed to be a community event, and we should all be heard. 
Thanks,

