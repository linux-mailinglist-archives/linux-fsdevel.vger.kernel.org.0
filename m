Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D114D15871D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBKA4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:56:32 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57383 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbgBKA4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:56:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 7842D616;
        Mon, 10 Feb 2020 19:56:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Feb 2020 19:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=BRKC1Q2crlqSmyJltbGVPx60D4o
        E6HR1IKWysJB/xmk=; b=V3Z2D62h2p2geUkz1ivzOU/STOqjNIPDn0Nt4X8KrWs
        4cRhPbM20kAxyZv9un1daHYw7TZcAFobebmYpWwbsPrlSx65MTLayVDjc2ftUdUG
        QlggkEtUJfgvdz/dqgwl5KtAaTe3u+Fq3h2f6V6H2uGpvkNDs22Ws3QFNy2lNheY
        FPImjQhi1NTxyzo2eLpHf92QARyUyj3UislevoqCP6YE6O6wjT9KeTWuiV7DYBiX
        qRLDp7xScsr6zc/BsX9YVZsQFx33Jqb/yqGXKTFePJDE31NHzbGhw3DfdeES7djf
        LokYUWl9dq/Wh7LCYGbpKc84fyZtueqRlZN28wL7LFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BRKC1Q
        2crlqSmyJltbGVPx60D4oE6HR1IKWysJB/xmk=; b=Htshbs9ypNG6jEppMXTnn8
        cFsnUxgiqPDZLIKLOH9WeXUfT/cTKOkm+AuDs9XiCgCCQs6Nl7U9Ee2C1YXlxPDi
        Tla4D8TMbNoq1qMQOtVkL2ld45vD//jVug62+vNcuPkri0rr8voQrImeXh3OkOAa
        q+bKUXbREfMMcx+voJkooztPI8hVFOyRshBkvEaBxgSnh/D3i8i8KQavbrstjdFz
        XVpmeh5y+R5AxP+ECB7oX7Tfq3WmP/W+h1WP3m6KRUOUo9WvLdG4Z+7WxL/ON6Lr
        GrXPKA43zlm+x56y0LWVCf/n03I89pg6FJmqca+oFg5yZIsC6t0KkzT9COS59taw
        ==
X-ME-Sender: <xms:vPtBXtyM2ztfKtemdxr7di2FeyiO9JOs3htTwSwNHghvmtIhZwcc8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghsse
    grnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:vPtBXkDqDa_oJdxnD02XP-QYN1Ilt1u5O2NAOpBQ5LLs3ReOgDO7KQ>
    <xmx:vPtBXgJKwvzzk7kOkz32scZWplNg74F2fWtyqKFCro9Lx1Gl7E8DUA>
    <xmx:vPtBXkN8kIb0XEZTbwinLnIgrFzIOEf9tuxSbfDNeY_qTHXCN_aI-g>
    <xmx:vftBXmRMXBgZM7LgwQFLrSWk-w66oJWQUE8irDhrWy7-U2xTHvoIvPHm41A>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB4F03060840;
        Mon, 10 Feb 2020 19:56:27 -0500 (EST)
Date:   Mon, 10 Feb 2020 16:56:26 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications
 [ver #3]
Message-ID: <20200211005626.7yqjf5rbs3vbwagd@alap3.anarazel.de>
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
 <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I only just now noticed this work after Dave Chinner pointed towards the
feature in the email leading to
https://lore.kernel.org/linux-fsdevel/20200211000405.5fohxgpt554gmnhu@alap3.anarazel.de/

On 2020-01-15 12:10:32 -0800, Linus Torvalds wrote:
> So I no longer hate the implementation, but I do want to see the
> actual user space users come out of the woodwork and try this out for
> their use cases.

Postgres has been looking for something roughly like this, fwiw (or
well, been forced to).

While it's better than it used to be (due to b4678df184b3), we still
have problems to reliably detect buffered IO errors, especially when
done across multiple processes.  We can't easily keep an fd open that
predates all writes to a file until, and ensure that fsyncs will happen
only on that fd. The primary reasons for that are
1) every connection (& some internal jobs) is a process, and neither do
want to to fsyncing each touched file in short-lived connections, nor is
it desirable to have to add the complication of having to transfer fds
between processes just to reliably get an error in fsync().
2) we have to cope with having more files open than allowed, so we have
a layer that limits the number of OS level FDs open at the same time. We
don't want to fsync whenever we have to juggle open fds though, as
that'd be too costly.

So it'd good to have a way to *reliably* know when writeback io failed,
so we can abort a checkpoint if necessary, and instead perform journal
replay.


For our purposes we'd probably want errors on the fs/superblock level,
rather than block devices. It's not always easy to map between blockdevs
and relevant filesystems, there are errors above the block layer, and we
definitely don'tt want to crash & restart a database just because
somebody pulled an USB storage device that didn't have any of the
database's data on it.

An earlier version of this patchset had some support for that, albeit
perhaps not fully implemented (no errors raised, afaict?):
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=notifications&id=338eec77a0cb29a7d2ae9350066c1990408ae58e

Is the plan to pick this up again once the basic feature is in?


A few notes from the email referenced above (that actually seem to belong
into this thread more than the other:

1) From the angle of reliably needing to detect writeback errors, I find it
somewhat concerning that an LSM may end up entirely filtering away error
notifications, without a consumer being able to detect that:

+void __post_watch_notification(struct watch_list *wlist,
+			       struct watch_notification *n,
+			       const struct cred *cred,
+			       u64 id)
+{
...
+		if (security_post_notification(watch->cred, cred, n) < 0)
+			continue;

It's an unpleasant thought that an overly restrictive [-ly configured]
LSM could lead to silently swallowing data integrity errors.

2) It'd be good if there were documentation, aimed at userland consumers
of this, explaining what the delivery guarantees are. To be useful for
us, it needs to be guaranteed that consuming all notifications ensures
that there are no pending notifications queued up somewhere (so we can
do fsync(data); fsync(journal); check_for_errors();
durable_rename(checkpoint_state.tmp, checkpoint_state);).

3) What will the permission model for accessing the notifications be?
It seems currently anyone, even within a container/namespace or
something, will see blockdev errors from everywhere?  The earlier
superblock support (I'm not sure I like that name btw, hard to
understand for us userspace folks), seems to have required exec
permission, but nothing else.

Greetings,

Andres Freund
