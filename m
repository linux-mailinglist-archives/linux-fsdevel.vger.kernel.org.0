Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58123B071
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgHCWs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 18:48:56 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46331 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgHCWs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:48:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id AF6BF5804EF;
        Mon,  3 Aug 2020 18:48:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Aug 2020 18:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        THOZEHX1IYOljNZcOu9rJ4ttNxpkzNp6II0FV+RfVmU=; b=SKPIS2AE91bKyzja
        nWa9F0jtD3a/JAMrvcDqIfxp+e6niqvABjEHLRU7LmtA/6J1VAZ7tdHwGZY++yE/
        QFcWt2dDEy+zsZNL50+x2WqbtVG+7SUiEdoMOt2pdlSlZWbuhR4vbe0J0h6SGoC6
        IJ/QZ7meZXMuPE0lNdwC6Q5s65bpfrerHpCaJjBJIbFj6jZeLp/Klp7fh5U2sFU1
        uM+ejc+J9wfvcpNMRSHOrE5JAdLPST9zjJh7ftlayVjlZfLvDOLp1SXGdReMvS8l
        JUmQ+D/I7q2raLv3C+kGeU3pqolvgeeEIZZUBVEFDRxfDFPLFi4RE673BgnrAdvE
        xuZHdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=THOZEHX1IYOljNZcOu9rJ4ttNxpkzNp6II0FV+RfV
        mU=; b=VdpfVhwuGSr+wvjIqM9NIoa+Rhg0GQ3xapsMGUZuiKG231yP3lUq7/alB
        G5GOoa53n4nJO29GX/NZo9HKbevyMae2cYeqRchH52f/k+MhaP4US/e8uNRdOJF2
        N9pxlxJUzHz0qwAziRmVdTCIAd8GvkmoKBXc6yblCQnOWFe1mxDLTdd6OQDlXS/h
        X7wDtor6pDbQN6bI6ArQP2LF2Bus4XBFFd2d5y5jDJnEqxzVL26avgpTgEflDs+n
        e3yq/2gWR4sqmSTk4naJsa2PzsgCKu0Ekg5QrKS5F1kIQh6htPwdBiPDY3pWWnaN
        MsDVQeia9eYcMpDRHQgBq78Ih3N3A==
X-ME-Sender: <xms:VZQoXw2a42WGwSue6AdNL6HwonUsnXw1CwXtRNbwj9JMmRF_1HKvkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnheple
    egtdelledtffetjeduteefgfeiheehkeffheeuhfekgeekueelheffheeigeejnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppeduudekrd
    dvtdekrdegjedrudeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:VZQoX7FhQnBjq5oCrSpZkjKbXwQRF_EuXb40YIVfvAyxmcjktbKVgg>
    <xmx:VZQoX472lPSIQDekhd503JWCWACpKo1E_S8tP8bo1UO0__QRoutdKQ>
    <xmx:VZQoX536u6x3smkO9YZs1V3SgPwApPI2t4H5YM0-fnglTroZ2iaukQ>
    <xmx:VpQoXy26O5xri8ckaQtxVw6APJOGfOSeVISXel41P24qXsmKL1Yccw>
Received: from mickey.themaw.net (unknown [118.208.47.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id A93D9328005D;
        Mon,  3 Aug 2020 18:48:49 -0400 (EDT)
Message-ID: <8eb2e52f1cbdbb8bcf5c5205a53bdc9aaa11a071.camel@themaw.net>
Subject: Re: [GIT PULL] Mount notifications
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, kzak@redhat.com, jlayton@redhat.com,
        mszeredi@redhat.com, nicolas.dichtel@6wind.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 06:48:45 +0800
In-Reply-To: <1842689.1596468469@warthog.procyon.org.uk>
References: <1842689.1596468469@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 16:27 +0100, David Howells wrote:
> Hi Linus,
> 
> Here's a set of patches to add notifications for mount topology
> events,
> such as mounting, unmounting, mount expiry, mount reconfiguration.
> 
> The first patch in the series adds a hard limit on the number of
> watches
> that any particular user can add.  The RLIMIT_NOFILE value for the
> process
> adding a watch is used as the limit.  Even if you don't take the rest
> of
> the series, can you at least take this one?
> 
> An LSM hook is included for an LSM to rule on whether or not a mount
> watch
> may be set on a particular path.
> 
> This series is intended to be taken in conjunction with the fsinfo
> series
> which I'll post a pull request for shortly and which is dependent on
> it.
> 
> Karel Zak[*] has created preliminary patches that add support to
> libmount
> and Ian Kent has started working on making systemd use them.
> 
> [*] https://github.com/karelzak/util-linux/commits/topic/fsinfo
> 
> Note that there have been some last minute changes to the patchset:
> you
> wanted something adding and Miklós wanted some bits taking
> out/changing.
> I've placed a tag, fsinfo-core-20200724 on the aggregate of these two
> patchsets that can be compared to fsinfo-core-20200803.
> 
> To summarise the changes: I added the limiter that you wanted;
> removed an
> unused symbol; made the mount ID fields in the notificaion 64-bit
> (the
> fsinfo patchset has a change to convey the mount uniquifier instead
> of the
> mount ID); removed the event counters from the mount notification and
> moved
> the event counters into the fsinfo patchset.

I've pushed my systemd changes to a github repo.
I haven't yet updated it with the changes above but will get to it.

They can be found at:
https://github.com/raven-au/systemd.git branch notifications-devel

> 
> 
> ====
> WHY?
> ====
> 
> Why do we want mount notifications?  Whilst /proc/mounts can be
> polled, it
> only tells you that something changed in your namespace.  To find
> out, you
> have to trawl /proc/mounts or similar to work out what changed in the
> mount
> object attributes and mount topology.  I'm told that the proc file
> holding
> the namespace_sem is a point of contention, especially as the process
> of
> generating the text descriptions of the mounts/superblocks can be
> quite
> involved.
> 
> The notification generated here directly indicates the mounts
> involved in
> any particular event and gives an idea of what the change was.
> 
> This is combined with a new fsinfo() system call that allows, amongst
> other
> things, the ability to retrieve in one go an { id, change_counter }
> tuple
> from all the children of a specified mount, allowing buffer overruns
> to be
> dealt with quickly.
> 
> This is of use to systemd to improve efficiency:
> 
> 	
> https://lore.kernel.org/linux-fsdevel/20200227151421.3u74ijhqt6ekbiss@ws.net.home/
> 
> And it's not just Red Hat that's potentially interested in this:
> 
> 	
> https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf6@6wind.com/
> 
> 
> David
> ---
> The following changes since commit
> ba47d845d715a010f7b51f6f89bae32845e6acb7:
> 
>   Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git 
> tags/mount-notifications-20200803
> 
> for you to fetch changes up to
> 841a0dfa511364fa9a8d67512e0643669f1f03e3:
> 
>   watch_queue: sample: Display mount tree change notifications (2020-
> 08-03 12:15:38 +0100)
> 
> ----------------------------------------------------------------
> Mount notifications
> 
> ----------------------------------------------------------------
> David Howells (5):
>       watch_queue: Limit the number of watches a user can hold
>       watch_queue: Make watch_sizeof() check record size
>       watch_queue: Add security hooks to rule on setting mount
> watches
>       watch_queue: Implement mount topology and attribute change
> notifications
>       watch_queue: sample: Display mount tree change notifications
> 
>  Documentation/watch_queue.rst               |  12 +-
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/arm64/include/asm/unistd.h             |   2 +-
>  arch/arm64/include/asm/unistd32.h           |   2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  fs/Kconfig                                  |   9 ++
>  fs/Makefile                                 |   1 +
>  fs/mount.h                                  |  18 +++
>  fs/mount_notify.c                           | 222
> ++++++++++++++++++++++++++++
>  fs/namespace.c                              |  22 +++
>  include/linux/dcache.h                      |   1 +
>  include/linux/lsm_hook_defs.h               |   3 +
>  include/linux/lsm_hooks.h                   |   6 +
>  include/linux/sched/user.h                  |   3 +
>  include/linux/security.h                    |   8 +
>  include/linux/syscalls.h                    |   2 +
>  include/linux/watch_queue.h                 |   7 +-
>  include/uapi/asm-generic/unistd.h           |   4 +-
>  include/uapi/linux/watch_queue.h            |  31 +++-
>  kernel/sys_ni.c                             |   3 +
>  kernel/watch_queue.c                        |   8 +
>  samples/watch_queue/watch_test.c            |  41 ++++-
>  security/security.c                         |   7 +
>  37 files changed, 422 insertions(+), 6 deletions(-)
>  create mode 100644 fs/mount_notify.c
> 

