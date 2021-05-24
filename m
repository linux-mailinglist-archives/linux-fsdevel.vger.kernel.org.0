Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB84538DF8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 05:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhEXDIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 23:08:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50387 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231833AbhEXDIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 23:08:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id E17D058036E;
        Sun, 23 May 2021 23:06:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 May 2021 23:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        PK1RHw7stc9h+bEFnJlkiXycIdaNiJrK8YUalaIR2VQ=; b=nnPTdkl2MXb7i9zB
        dPKgBHSx7XI+zq4XncBC51PSE8IMPMHXtbO3Uht+Yjt5E19oTsPvQYohM+H2bJiz
        yQTOLCcuiicsNNtEQc6xchys4gibv8NXBYwyaswUlKrK68Jbdgkw4I8RtHyCbri2
        E8YRbhbY2HOWPvlf4y08C6Zes1hcADhxn1rDK/ReyKekQ3JO06WCpcSacLcXKkFn
        hBtoE1Z+Pucd8AUeNf5htsbNECV/AgvJunMUeMFRDlNhF26SOuOxl7nGL3Dlx6tl
        pVNQWmXGnN9CGAv0JR/eGT8BzR3yn6Bj2i/F1gTQAxgkCbKBicRAF0BjJCSPoeAU
        xa0nGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PK1RHw7stc9h+bEFnJlkiXycIdaNiJrK8YUalaIR2
        VQ=; b=jxIDeufuVBPvcmTdNXNCycd/Iz1mcLajYJ19X6hYJYp7QeuZ5YbWknwbi
        XbBNxId4Reag9yU/WLzXVadg5S7X7NNLwbY7kKL9mzjCWyFjH6vSZiT3PY+7WZjz
        NhJlkOMGuSTFxgI1N/VOacObNkAP4KqePj7LoJ/YQuu41trms2eW7t9XowJpsbwT
        4EFu/91xN/y41b7NWctgB1TxfQ+slxfh13Aq8yJB2xzoxW2s3vrXfRW9I26Fb1xn
        ma29FkeU48jAf5GC/mCb6fcfQhaXOfcXhn0OmQQCsJMKLDzbn1UZ5crb0U5wz1y8
        6+FBQiJqL+1k196mMJvmBEB0SftOQ==
X-ME-Sender: <xms:SRirYJY40etF-rombMVQsr4ZMrEigRvUIkN_QEIAliTBc20hahyMxg>
    <xme:SRirYAb4Kedw4oc2E5aBqrAVjEafCRY0XzosVaMMeK_Xsbfd7Pz3nx2kka08yuzkF
    ZGzV5fTL5Ud>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekudejffegveeufeeigeekvdeggeegkeeuvedtiefffffgvdekgedvgffhveelvdenucff
    ohhmrghinheptgholhhlrggsohhrrgdrtghomhdplhifnhdrnhgvthenucfkphepuddtie
    drieelrddvheehrdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:SRirYL9WnPI-ODhSpsD_VAjLe44XzIF3dG1jN2YnotjgvCEZhVRayw>
    <xmx:SRirYHr1d6FdDNp86tz67j5L2-WaRgPRFZUUe-M8Fg0L0agrdjDMuQ>
    <xmx:SRirYErlWtshje17N2VS9dFASP09Cb8-AkE2psMhIN4xRkjH1u0AJg>
    <xmx:SRirYMKPuZr5DkSAWM5hP2-drTAhsA89ENSrd5XZ5xlaHJ0NNMhD5Q>
Received: from mickey.long.domain.name.themaw.net (106-69-255-44.dyn.iinet.net.au [106.69.255.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun, 23 May 2021 23:06:45 -0400 (EDT)
Message-ID: <cc89bd8edb24a9a5d8e632937010480111294484.camel@themaw.net>
Subject: Re: [PATCH 00/11] File system wide monitoring
From:   Ian Kent <raven@themaw.net>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, amir73il@gmail.com
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Date:   Mon, 24 May 2021 11:06:40 +0800
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-20 at 22:41 -0400, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> This series follow up on my previous proposal [1] to support file
> system
> wide monitoring.  As suggested by Amir, this proposal drops the ring
> buffer in favor of a single slot associated with each mark.  This
> simplifies a bit the implementation, as you can see in the code.

I get the need for simplification but I'm wondering where this
will end up.

I also know kernel space to user space error communication has
been a concern for quite a while now.

And, from that, there are a couple of things that occur to me.

One is that the standard errno is often not sufficient to give
sufficiently accurate error reports.

It seems to me that, in the long run, there needs to be a way
for sub-systems to register errors that they will use to report
events (with associated text description) so they can be more
informative. That's probably not as simple as it sounds due to
things like error number clashes, etc. OTOH that mechanism could
be used to avoid using text strings in notifications provided
provided there was a matching user space library, thereby reducing
the size of the event report.

Another aspect, also related to the limitations of error reporting
in general, is the way the information could be used. Again, not a
simple thing to do or grok, but would probably require some way of
grouping errors that are related in a stack like manner for user
space inference engines to analyse. Yes, this is very much out of
scope but is a big picture long term usefulness type of notion.

And I don't know how error storms occurring as a side effect of
some fairly serious problem could be handled ... 

So not really related to the current implementation but a comment
to try and get peoples thoughts about where this is heading in
the long run.

Ian
> 
> As a reminder, This proposal is limited to an interface for
> administrators to monitor the health of a file system, instead of a
> generic inteface for file errors.  Therefore, this doesn't solve the
> problem of writeback errors or the need to watch a specific subtree.
> 
> In comparison to the previous RFC, this implementation also drops the
> per-fs data and location, and leave those as future extensions.
> 
> * Implementation
> 
> The feature is implemented on top of fanotify, as a new type of
> fanotify
> mark, FAN_ERROR, which a file system monitoring tool can register to
> receive error notifications.  When an error occurs a new notification
> is
> generated, in addition followed by this info field:
> 
>  - FS generic data: A file system agnostic structure that has a
> generic
>  error code and identifies the filesystem.  Basically, it let's
>  userspace know something happened on a monitored filesystem.  Since
>  only the first error is recorded since the last read, this also
>  includes a counter of errors that happened since the last read.
> 
> * Testing
> 
> This was tested by watching notifications flowing from an
> intentionally
> corrupted filesystem in different places.  In addition, other events
> were watched in an attempt to detect regressions.
> 
> Is there a specific testsuite for fanotify I should be running?
> 
> * Patches
> 
> This patchset is divided as follows: Patch 1 through 5 are
> refactoring
> to fsnotify/fanotify in preparation for FS_ERROR/FAN_ERROR; patch 6
> and
> 7 implement the FS_ERROR API for filesystems to report error; patch 8
> add support for FAN_ERROR in fanotify; Patch 9 is an example
> implementation for ext4; patch 10 and 11 provide a sample userspace
> code
> and documentation.
> 
> I also pushed the full series to:
> 
>   https://gitlab.collabora.com/krisman/linux -b fanotify-
> notifications-single-slot
> 
> [1] https://lwn.net/Articles/854545/
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: jack@suse.com
> To: amir73il@gmail.com
> Cc: dhowells@redhat.com
> Cc: khazhy@google.com
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-ext4@vger.kernel.org
> 
> Gabriel Krisman Bertazi (11):
>   fanotify: Fold event size calculation to its own function
>   fanotify: Split fsid check from other fid mode checks
>   fanotify: Simplify directory sanity check in DFID_NAME mode
>   fanotify: Expose fanotify_mark
>   inotify: Don't force FS_IN_IGNORED
>   fsnotify: Support FS_ERROR event type
>   fsnotify: Introduce helpers to send error_events
>   fanotify: Introduce FAN_ERROR event
>   ext4: Send notifications on error
>   samples: Add fs error monitoring example
>   Documentation: Document the FAN_ERROR event
> 
>  .../admin-guide/filesystem-monitoring.rst     |  52 +++++
>  Documentation/admin-guide/index.rst           |   1 +
>  fs/ext4/super.c                               |   8 +
>  fs/notify/fanotify/fanotify.c                 |  80 ++++++-
>  fs/notify/fanotify/fanotify.h                 |  38 +++-
>  fs/notify/fanotify/fanotify_user.c            | 213 ++++++++++++++--
> --
>  fs/notify/inotify/inotify_user.c              |   6 +-
>  include/linux/fanotify.h                      |   6 +-
>  include/linux/fsnotify.h                      |  13 ++
>  include/linux/fsnotify_backend.h              |  15 +-
>  include/uapi/linux/fanotify.h                 |  10 +
>  samples/Kconfig                               |   8 +
>  samples/Makefile                              |   1 +
>  samples/fanotify/Makefile                     |   3 +
>  samples/fanotify/fs-monitor.c                 |  91 ++++++++
>  15 files changed, 485 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/admin-guide/filesystem-
> monitoring.rst
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
> 


