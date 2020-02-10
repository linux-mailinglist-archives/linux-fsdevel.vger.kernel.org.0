Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC4158669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBKAF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:05:57 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:53661 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgBKAF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:05:56 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 19:05:56 EST
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id CF971655;
        Mon, 10 Feb 2020 19:00:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Feb 2020 19:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cInhNZqekz77iMo+ZrzOQbvCpsV
        +e2osqSVQXvKS/Hk=; b=N5YWNdSazEHoHEq9YLj9vbjMgg3uuHRb0d8MsD0hzMj
        m31HIu7STZrvs9e6UUCq9F+BpmIlE5wOhBt9HHZZs2NfH2Oplxxo31ALZP05SDIL
        7kxe32LYcgXP19n6xrOC+eMiMD/I2LEYkfhlvQkBx5WxI++ysjosrkXTb2rkUs2W
        t2GA8z+qdVh5C2nmI9GZX+mn7WsxGTTf/dvZw+Lq9kl2DIyrknMlFK9kahWYl3Oz
        NNzMhVLUDzEePX6+dT8T155BuK6nPrEBEzDnF7fu94S4JMB8ysbj1IJAGiS23LYp
        8ndonfVFG6DkLqjcZpTV/vsdrObMu+I0a2Q+mDCgSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cInhNZ
        qekz77iMo+ZrzOQbvCpsV+e2osqSVQXvKS/Hk=; b=i/YSo3Z05NRETuHYCugxtE
        TsfQvLW3t4hdv/mANwj2Vtghh8XRZsscmEEYbPjGpi94X3RvOkbtuD5KQ9dDl51D
        r6Podyx4MRZXips0+NxS8TF2wA7ZQ8Rf2sAN9PJlcRKwbLtKTdmpA1SOK0SBBl9Q
        fb+ZOR1Gy2qx+R3TqnZ3XuFo2HOo4OoqTtmBqT9ZnJ1ApfVl7aNGAoi13/DbtP3+
        s1uIyZPPZSBCrUVrOo2T8akq1NE1Cq+Bplu+7nAjkpZQ9iFCGNQsk9ymYqWntVBA
        3e4Ni/AdxOnG4bASsupoflwmV/nUXK//SYp7jfFbRc7WFtXuvMTaQjsU2l3PpkVA
        ==
X-ME-Sender: <xms:f-5BXkMXSpOODIQl2W1_0K6DAke2HBH7Zct3S0rtnd0kSVsgXuvF7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fthfevqddqhfhrohhmqdetuggurhhsqdfpohfuvghnuggvrhculdeftddmnecujfgurhep
    fffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgvshcuhfhrvg
    hunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqedpucffrghvihguucfjohif
    vghllhhsuceoughhohifvghllhhssehrvgguhhgrthdrtghomheqnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnh
    grrhgriigvlhdruggv
X-ME-Proxy: <xmx:f-5BXpkN5kNaOyvoDHP9OGOYA9CXtpAlHkUjyuZXNBuvvFrWuMzwsQ>
    <xmx:f-5BXq7P8RTKfK6Q_Q7qjo4kY09jfbgLkaOTcieLthmWr5iR8mBvgg>
    <xmx:f-5BXi4ifQQdmmYydXqhZRrFnk-2I40Ps3IsGc0N7w008nVPWnyAeg>
    <xmx:gO5BXpYIU68N8AiEv9An3LL5qTPVUjsD-YtjKOWeZ-u6H3YCH9z9ZB6fVcM>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5DF383060717;
        Mon, 10 Feb 2020 18:59:59 -0500 (EST)
Date:   Mon, 10 Feb 2020 15:59:57 -0800
From:   Andres Freund <andres@anarazel.de>,
        David Howells <dhowells@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200210235957.zwtozoml3bcbrerl@alap3.anarazel.de>
References: <20200207170423.377931-1-jlayton@kernel.org>
 <20200207205243.GP20628@dread.disaster.area>
 <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
 <20200210214657.GA10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210214657.GA10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

David added you, because there's discussion about your notify work
below.

On 2020-02-11 08:46:57 +1100, Dave Chinner wrote:
> On Fri, Feb 07, 2020 at 01:20:12PM -0800, Andres Freund wrote:
> > Hi,
> > 
> > On 2020-02-08 07:52:43 +1100, Dave Chinner wrote:
> > > On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> > > > You're probably wondering -- Where are v1 and v2 sets?
> > 
> > > > The basic idea is to track writeback errors at the superblock level,
> > > > so that we can quickly and easily check whether something bad happened
> > > > without having to fsync each file individually. syncfs is then changed
> > > > to reliably report writeback errors, and a new ioctl is added to allow
> > > > userland to get at the current errseq_t value w/o having to sync out
> > > > anything.
> > > 
> > > So what, exactly, can userspace do with this error? It has no idea
> > > at all what file the writeback failure occurred on or even
> > > what files syncfs() even acted on so there's no obvious error
> > > recovery that it could perform on reception of such an error.
> > 
> > Depends on the application.  For e.g. postgres it'd to be to reset
> > in-memory contents and perform WAL replay from the last checkpoint.
> 
> What happens if a user runs 'sync -f /path/to/postgres/data' instead
> of postgres? All the writeback errors are consumed at that point by
> reporting them to the process that ran syncfs()...

We'd have to keep an fd open from *before* we start durable operations,
which has a sampled errseq_t from before we rely on seeing errors.


> > Due to various reasons* it's very hard for us (without major performance
> > and/or reliability impact) to fully guarantee that by the time we fsync
> > specific files we do so on an old enough fd to guarantee that we'd see
> > the an error triggered by background writeback.  But keeping track of
> > all potential filesystems data resides on (with one fd open permanently
> > for each) and then syncfs()ing them at checkpoint time is quite doable.
> 
> Oh, you have to keep an fd permanently open to every superblock that
> application holds data on so that errors detected by other users of
> that filesystem are also reported to the application?

Right

Currently it's much worse (you probably now?):

Without error reporting capabilities in syncfs or such you have to keep
an fd open to *every* single inode you want to reliably get errors
for. Fds have an errseq_t to keep track of which errors have been seen
by that fd, so if you have one open from *before* an error is triggered,
you can be sure to detect that. But if the fd is not guaranteed to be
old enough you can hit two cases:

1) Some other application actually sees an error, address_space->wb_err
   is marked ERRSEQ_SEEN. Any new fd will not see a report the problem
   anymore.
2) The inode with the error gets evicted (memory pressure on a database
   server isn't rare) while there is no fd open. Nobody might see the
   error.

If there were a reliable (i.e. it may not wrap around or such) error
counter available *somewhere*, we could just keep track of that, instead
of actually needing an "old" open fd in the right process.


> This seems like a fairly important requirement for applications to
> ensure this error reporting is "reliable" and that certainly wasn't
> apparent from the patches or their description.  i.e. the API has an
> explicit userspace application behaviour requirement for reliable
> functioning, and that was not documented.  "we suck at APIs" and all
> that..

Yup.


> It also seems to me as useful only to applications that have a
> "rollback and replay" error recovery mechanism. If the application
> doesn't have the ability to go back in time to before the
> "unfindable" writeback error occurred, then this error is largely
> useless to those applications because they can't do anything with
> it, and so....

That's a pretty common thing these days for applications that actually
care about data to some degree. Either they immediately f[data]sync
after writing, or they use some form of storage that has journalling
capabilities. Which e.g. sqlite provides for the myriad of cases that
don't want a separate server.

And even if they can't recover from the error, there's a huge difference
between not noticing that shit has hit the fan and happily continuing to
accept further data , and telling the user that something has gone wrong
with data integrity without details.


> .... most applications will still require users to scrape their
> logs to find out what error actually occurred. IOWs, we haven't
> really changed the status quo with this new mechanism.

I think there's a huge practical difference between having to do so in
case there was an actual error (on the relevant FSs), and having to do
so continually.


> FWIW, explicit userspace error notifications for data loss events is
> one of the features that David Howell's generic filesystem
> notification mechanism is intended to provide.  Hence I'm not sure
> that there's a huge amount of value in providing a partial solution
> that only certain applications can use when there's a fully generic
> mechanism for error notification just around the corner.

Interesting. I largely missed that work, unfortunately. It's hard to
keep up with all kernel things, while also maintaining / developing an
RDBMS :/

I assume the last state that includes the superblock layer stuff is at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
whereas there's a newer
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-core
not including that. There do seem to be some significant changes between
the two.

As far as I can tell the superblock based stuff does *not* actually
report any errors yet (contrast to READONLY, EDQUOT). Is the plan here
to include writeback errors as well? Or just filesystem metadata/journal
IO?

I don't think that block layer notifications would be sufficient for an
individual userspace application's data integrity purposes? For one,
it'd need to map devices to relevant filesystems afaictl. And there's
also errors above the block layer.


Based on skimming the commits in those two trees, I'm not quite sure I
understand what the permission model will be for accessing the
notifications will be? Seems anyone, even within a container or
something, will see blockdev errors from everywhere?  The earlier
superblock support (I'm not sure I like that name btw, hard to
understand for us userspace folks), seems to have required exec
permission, but nothing else.

For it to be usable for integrity purposes delivery has to be reliable
and there needs to be a clear ordering, in the sense that reading
notification needs to return all errors that occured timewise before the
last pending notification has been read. Looks like that's largely the
case, although I'm a bit scared after seeing:

+void __post_watch_notification(struct watch_list *wlist,
+			       struct watch_notification *n,
+			       const struct cred *cred,
+			       u64 id)
+
+		if (security_post_notification(watch->cred, cred, n) < 0)
+			continue;
+

if an LSM module just decides to hide notifications that relied upon for
integrity, we'll be in trouble.


> > I'm not sure it makes sense to
> > expose the errseq_t bits straight though - seems like it'd
> > enshrine them in userspace ABI too much?
> 
> Even a little is way too much. Userspace ABI needs to be completely
> independent of the kernel internal structures and implementation.
> This is basic "we suck at APIs 101" stuff...

Well, if it were just a counter of errors that gets stuck at some well
defined max, it seems like it'd be ok. But I agree that it'd not be the
best possible interface, and that the notify API seems like it could
turn into that.

Greetings,

Andres Freund
