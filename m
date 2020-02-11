Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178B115866E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBKAK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:10:56 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35883 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbgBKAK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:10:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 30ABA664;
        Mon, 10 Feb 2020 19:04:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Feb 2020 19:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+YWviiEypY4/uSM7a/KOZGTlyXo
        Sv+afDb7oMnLU4Ew=; b=MZYF0oN+qiSGhEtb1doYqf263EKGpRuUZQ6vmRnGSJY
        +LnaukjCb+JPyKVzeqBqFDSL4Ze5UGigIJe7GkEbPVF2PAJ1hZin2Zb2aAKaRbgY
        uIicwBeblBGJF5GHf7YaN26mwCMCUqEBILPaVW2eyHPWgAjt+uau49tEwjs2kDAw
        +klTO0G95XTkcryioGbN/U7iLAbPXrIrue/LznK9A+tMk2EK8ah3FNxw3cZI2ETv
        4azPneN9A6F1V2fhG3/DCFcz/vrmFVXlwQs4TEylPEK7Q64Y874i+Sy9BIrHkRCT
        jhsnV+Zw4r7QcrnR8OzT6YlTHHP8eb6b9eqS/KsfLqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+YWvii
        EypY4/uSM7a/KOZGTlyXoSv+afDb7oMnLU4Ew=; b=LMi7uQsdhZcpFyxYXa4hPx
        Xx8GnZwxIZO+lTki/ZSVbZRlCb72kNRLIAiH1THDEGfjH92d2pge0rPnb798ffFu
        oWo0psgjieDdbX9n+6IRUzeyJlkcTbMuqPVjt+jtlQFqji2MXH6ygvWMNPpZCTE5
        c9nJUk5AbFqraHXBwhqv+wQNoo5VgpuABbDvS5amB7uvNdJKEFRoxzQucSxRSM0T
        phP7LWBr3SmqcT1VrPWdy2gvMXmJa9m/zwgdn6b8Ls8zKXhwIUZsLvjdtfJPl6o2
        IQW3bwLJMREK8FNUyQ71ExKzfPnss9f5Bfqr0k6FSTdts53PaO+StUn1ezJkRU7Q
        ==
X-ME-Sender: <xms:du9BXrjrEmO6EdnJ_pc7WI-NfG5m8OGt-ycdBihJj8Ja4VmZPwMncQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghsse
    grnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:du9BXsSimq3cbHRr3nc7ziO8uEVPm-gCoNUp0Sc3HNWbBnhCGcXD7w>
    <xmx:du9BXmFSbp83JHg_MPLSAqletsvqFPURC73kAGM22v6nxALTg7iZcA>
    <xmx:du9BXslCZx5yOxfoh1xo5J6slwBt3PXipUO1qeaFCyK4aloLpYHYaQ>
    <xmx:d-9BXrMAhFwi34YIb3KXjcE38Y_2CmGLQ_gAFji5DgsVihsWlPpNJRDrZu0>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A45830606FB;
        Mon, 10 Feb 2020 19:04:06 -0500 (EST)
Date:   Mon, 10 Feb 2020 16:04:05 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200211000405.5fohxgpt554gmnhu@alap3.anarazel.de>
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

(sorry if somebody got this twice)

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
