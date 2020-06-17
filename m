Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1893A1FC78D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQHht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:37:49 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54675 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgFQHhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:37:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 3BF69561;
        Wed, 17 Jun 2020 03:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=deSknUuePkPVUMFanOBKM4EFKl
        G91i09uI4kkHritao=; b=E4QNVxCgWqec3OWDCZ9LyfGcARtXufmujhExPOCQ1X
        4TwUZzboMsThL2lFiJ3RTUAk+qH7JYGrG9nZ9dRQQ3t10Jhyd2OEwfbPuD0ffDo6
        ND9Xway+VIYgwoPG96I7ZZjqTWR2qEp1o7fJbJnbwfNLASPpB6wzz2L0XRJ5jpBu
        glCJ5pXInT0S4yHE9ewBGG5eshStUaeNjkZQT9w9lP9lk/hX84lVbLxknf/umrak
        hRqDPpYig7A3R2TaPqtcR88Wh9R1n5/ypT3xND/lvgd3BXi6n4Ol3HVzc8P0rWDW
        hT4JkdjDSV2HF0bT7EtqIHmFHva17g8Z0nWhz10AYkPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=deSknU
        uePkPVUMFanOBKM4EFKlG91i09uI4kkHritao=; b=GC5+45usB1GFyP495DypVm
        TXCHOx7SjND3pATQyVritfQd8+LdLFOzoALMeXGcDmxpBX84kDq2XtFiKN2fyu36
        vQlvzC+cuMKjW1GajWcUmQFc2nau1rTn9H/gO546mu26Ad6/LfOmDEVdASQuvDQf
        7EumYzN0VS0Iypg61aFb1zO/rVGrdHIA5Pc3EmnZmFCam8lTnOVg+yucWKtLvjsP
        jeYn3HBv6/iD4xRkCTcNPCoTdvNM7CXeRU7h2jfny5Ko7TjCziX9yXq6b2faaR6i
        4ug/x598aQ9V3TXpJJi54Irz6cX3RILwMkCrfIXy400xfmOps3rHFT5RiFL658aQ
        ==
X-ME-Sender: <xms:SsjpXoQwWzrK2GSRiN3Lo6PpJky8F_h_I-arERFqxWfxx95Y44MHOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkfgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepue
    eikeevgeekveetueffgefhveetieeigefghfejkefgteevheeguddufeethfdunecukfhp
    peehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:SsjpXlxcEECerBnzmPG_WMrELBAxSjJCFLnEMPUZrGXN2BdEZcnuGg>
    <xmx:SsjpXl1TIt4dN7q3NmMmC3-qxqwXP0AOz8z9OYklLrLE1zafhqQc5g>
    <xmx:SsjpXsB4IjApovAxcWwouecsIb1DzykimXySKNf5GHEHoNbsCAbU7w>
    <xmx:SsjpXvaNTJz0D43ZviNmIzGP3Dp4DVhD_AFnXlQWdvA9Xw2uYbVe5A>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6536D3280063;
        Wed, 17 Jun 2020 03:37:46 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 3FCD1A0314;
        Wed, 17 Jun 2020 15:37:43 +0800 (AWST)
Subject: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 15:37:43 +0800
Message-ID: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For very large IBM Power mainframe systems with hundreds of CPUs and TBs
of RAM booting can take a very long time.

Initial reports showed that booting a configuration of several hundred
CPUs and 64TB of RAM would take more than 30 minutes and require kernel
parameters of udev.children-max=1024 systemd.default_timeout_start_sec=3600
to prevent dropping into emergency mode.

Gathering information about what's happening during the boot is a bit
challenging but two main issues appeared to be: a large number of path
lookups for non-existent files, and very high lock contention in the VFS
during path walks particularly in the dentry allocation code path.

The underlying cause of this was thought to be the sheer number of sysfs
memory objects, 100,000+ for a 64TB memory configuration as the hardware
divides the memory into 256MB logical blocks. This is believed to be due
to either IBM Power hardware design or a requirement of the mainframe
software used to create logical partitions (LPARs, that are used to
install an operating system to provide services), since these can be made
up of a wide range of resources, CPU, Memory, disks, etc.

It's unclear yet whether the creation of syfs nodes for these memory
devices can be postponed or spread out over a larger amount of time.
That's because the high overhead looks to be due to notifications received
by udev which invokes a systemd program for them and attempts by systemd
folks to improve this have not focused on changing the handling of these
notifications, possibly because of difficulties with doing so. This
remains an avenue of investigation.

Kernel traces show there are many path walks with a fairly large portion
of those for non-existent paths. However, looking at the systemd code
invoked by the udev action it appears there's only one additional lookup
for each invocation so the large number of negative lookups is most likely
due to the large number of notifications rather than a fault with the
systemd program.

The series here tries to reduce the locking needed during path walks
based on the assumption that there are many path walks with a fairly
large portion of those for non-existent paths, as described above.

That was done by adding kernfs negative dentry caching (non-existent
paths) to avoid continual alloc/free cycle of dentries and a read/write
semaphore introduced to increase kernfs concurrency during path walks.

With these changes we still need kernel parameters of udev.children-max=2048
and systemd.default_timeout_start_sec=300 for the fastest boot times of
under 5 minutes.

There may be opportunities for further improvements but the series here
has seen a fair amount of testing and thinking about what else these could
be. Discussing it with Rick Lindsay, I suspect improvements will get more
difficult to implement for somewhat less improvement so I think what we
have here is a good start for now.

Changes since v1:
- fix locking in .permission() and .getattr() by re-factoring the attribute
  handling code.
---

Ian Kent (6):
      kernfs: switch kernfs to use an rwsem
      kernfs: move revalidate to be near lookup
      kernfs: improve kernfs path resolution
      kernfs: use revision to identify directory node changes
      kernfs: refactor attr locking
      kernfs: make attr_mutex a local kernfs node lock


 fs/kernfs/dir.c             |  284 ++++++++++++++++++++++++++++---------------
 fs/kernfs/file.c            |    4 -
 fs/kernfs/inode.c           |   58 +++++----
 fs/kernfs/kernfs-internal.h |   29 ++++
 fs/kernfs/mount.c           |   12 +-
 fs/kernfs/symlink.c         |    4 -
 include/linux/kernfs.h      |    7 +
 7 files changed, 259 insertions(+), 139 deletions(-)

--
Ian

