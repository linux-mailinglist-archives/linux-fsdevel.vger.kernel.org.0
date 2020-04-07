Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF061A04D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 04:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDGCWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 22:22:12 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57377 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgDGCWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:22:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 57676580173;
        Mon,  6 Apr 2020 22:22:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 06 Apr 2020 22:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        5dNVhfLMUt+8tcPKdoTMiF0YG1bsTSZmcEY4vAPNwSw=; b=G3zhLNwlhoBqP+G8
        UwCj3dmUonEhJlRFoodWDaFNEmgD9adZCBapxgao+DkeRvbWrXzbqtMEVxS8Cp/E
        gutJlnL6EnWW1p4aIa3fZdh2g+xnc37bL1E84WbLSxzhjk/H/6f5jr4npugiY9+Y
        K7JwwhNbXlbHTaZxJpvS4E5yqcszvJopzGkMPwJz226VvRyhSJU7WZcvztVEc2mZ
        2JA5GusojluT39DjK6IKolVXt+WBvYnO6Gh5j2rbMlvlZvd43g4dh5EdpTezuTzk
        Z9OmNCVY0y+JfFnDxdJDhxvV9Sk/sA0erQeSDB/kgN+tt71kDNtPEzkyftNkc8WW
        HU6F4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=5dNVhfLMUt+8tcPKdoTMiF0YG1bsTSZmcEY4vAPNw
        Sw=; b=FhI8OYVHzCqgMW0J30jdJEPY0mYut7dTMQfe8HXJmRXf6/zT64lyLyN8D
        p3mnV4asB3a9CeT4cWYW/7fVUBXHgtr5p8DeVuIr0LSva7IsDqLCmT1spKnQwE50
        oSHD+FWCeTDZEAmbDxGPmgHEpiVst4ZYlAUktjBKEXHId7SfxDvKFvZlAgXrsa+4
        nfNYMQYPyuh0rCh2Vyb+QrLN/leCd7cvO83gIy9GLm3kMuNr6nvgTg3f2JP5U0Rn
        4KFgXjJFhetpSpLngEnxUvQa0cg0zBO7pwdzXmAnPTfo1OKm/95BSTA6dZLmRxGE
        Ic+jkAI51Q9mi+t27bkuZjfHdvJ0g==
X-ME-Sender: <xms:0OOLXg-5Trx9ScuOkRCbMRfDLLn4w7ens3PjsAlQBGZiKqDfAOW8iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dukeelrddujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:0OOLXlAPHjEhxtWgp2onM4JAAhHsk9-0cz2JjwCKpFSm6RceGwfvUA>
    <xmx:0OOLXnoHRCNWOoRNWB4BpRxdgScqZFVdoVuRV8cmgTodDogT3EIGBQ>
    <xmx:0OOLXtmJaxyNlf8D_0Lzot5BsjxN6JKZNO5hKUpXhwXP-tJpi3IlYw>
    <xmx:0uOLXkak-p80leqRgUWIZI_lIcC6FFuDYNpQ6izmPEFZDBvpCAILDw>
Received: from mickey.themaw.net (unknown [118.208.189.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DA7D306D4B9;
        Mon,  6 Apr 2020 22:22:02 -0400 (EDT)
Message-ID: <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Lennart Poettering <mzxreary@0pointer.de>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Date:   Tue, 07 Apr 2020 10:21:59 +0800
In-Reply-To: <20200406172917.GA37692@gardel-login>
References: <20200402143623.GB31529@gardel-login>
         <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
         <20200402152831.GA31612@gardel-login>
         <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
         <20200402155020.GA31715@gardel-login>
         <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
         <20200403110842.GA34663@gardel-login>
         <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
         <20200403150143.GA34800@gardel-login>
         <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
         <20200406172917.GA37692@gardel-login>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-04-06 at 19:29 +0200, Lennart Poettering wrote:
> On Mo, 06.04.20 11:22, Miklos Szeredi (miklos@szeredi.hu) wrote:
> 
> > > Nah. What I wrote above is drastically simplified. It's IRL more
> > > complex. Specific services need to be killed between certain
> > > mounts
> > > are unmounted, since they are a backend for another mount. NFS,
> > > or
> > > FUSE or stuff like that usually has some processes backing them
> > > around, and we need to stop the mounts they provide before these
> > > services, and then the mounts these services reside on after
> > > that, and
> > > so on. It's a complex dependency tree of stuff that needs to be
> > > done
> > > in order, so that we can deal with arbitrarily nested mounts,
> > > storage
> > > subsystems, and backing services.
> > 
> > That still doesn't explain why you need to keep track of all mounts
> > in
> > the system.
> > 
> > If you are aware of the dependency, then you need to keep track of
> > that particular mount. If not, then why?
> 
> it works the other way round in systemd: something happens, i.e. a
> device pops up or a mount is established and systemd figures our if
> there's something to do. i.e. whether services shall be pulled in or
> so.
> 
> It's that way for a reason: there are plenty services that want to
> instantiated once for each object of a certain kind to pop up (this
> happens very often for devices, but could also happen for any other
> kind of "unit" systemd manages, and one of those kinds are mount
> units). For those we don't know the unit to pull in yet (because it's
> not going to be a well-named singleton, but an instance incorporating
> some identifier from the source unit) when the unit that pops up does
> so, thus we can only wait for the the latter to determine what to
> pull
> in.
> 
> > What I'm starting to see is that there's a fundamental conflict
> > between how systemd people want to deal with new mounts and how
> > some
> > other people want to use mounts (i.e. tens of thousands of mounts
> > in
> > an automount map).
> 
> Well, I am not sure what automount has to do with anything. You can
> have 10K mounts with or without automount, it's orthogonal to that.
> In
> fact, I assumed the point of automount was to pretend there are 10K
> mounts but not actually have them most of the time, no?

Yes, but automount, when using a large direct mount map will, be the
source of lots of mounts which of an autofs file system.

> 
> I mean, whether there's room to optimize D-Bus IPC or not is entirely
> orthogonal to anything discussed here regarding fsinfo(). Don't make
> this about systemd sending messages over D-Bus, that's a very
> different story, and a non-issue if you ask me:

Quite probably, yes, that's something you can care about if it really
is an issue but isn't something I care about myself either.

> 
> Right now, when you have n mounts, and any mount changes, or one is
> added or removed then we have to parse the whole mount table again,
> asynchronously, processing all n entries again, every frickin
> time. This means the work to process n mounts popping up at boot is
> O(n²). That sucks, it should be obvious to anyone. Now if we get that
> fixed, by some mount API that can send us minimal notifications about
> what happened and where, then this becomes O(n), which is totally OK.

But this is clearly a problem and is what I do care about and the
infrastructure being proposed here can be used to achieve this.

Unfortunately, and I was mistaken about what systemd does, I don't
see a simple way of improving this. This is because it appears that
systemd, having had to scan the entire mount table every time has,
necessarily, lead to code that can't easily accommodate the ability
to directly get the info immediately for a single mount.

So to improve this I think quite a few changes will be needed in
systemd and libmount. I'm not quite sure how to get that started.
After all it needs to be done how Karel would like to see it done
in libmount and how systemd folks would like to see it done in
systemd which is very probably not how I would approach it myself.

> 
> You keep talking about filtering, which will just lower the "n" a bit
> in particular cases to some value "m" maybe (with m < n), it does not
> address the fact that O(m²) is still a big problem.
> 
> hence, filtering is great, no problem, add it if you want it. I
> personally don't care about filtering though, and I doubt we'd use it
> in systemd, I just care about the O(n²) issue.
> 
> If you ask me if D-Bus can handle 10K messages sent over the bus
> during boot, then yes, it totally can handle that. Can systemd nicely
> process O(n²) mounts internally though equally well? No, obviously
> not,
> if n grows too large. Anyone computer scientist should understand
> that..
> 
> Anyway, I have the suspicion this discussion has stopped being
> useful. I think you are trying to fix problems that userspce actually
> doesn't have. I can just tell you what we understand the problems
> are,
> but if you are out trying to fix other percieved ones, then great,
> but
> I mostly lost interest.

Yes, filtering sounds like we've wandered off topic, ;)

Ian

