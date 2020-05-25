Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D81E067E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 07:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEYFrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 01:47:05 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40733 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgEYFrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 01:47:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0F872C1B;
        Mon, 25 May 2020 01:47:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 May 2020 01:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=CIllm1RQGKDnnYq/cuRGvlgqk6
        bL4rxpvo2PzoGHqJg=; b=N1B8sTInp3grE6pWC/nOMrPTzmVfN2WCZy1EciTqgK
        XFXjj/TpYwHNkQ0UZnTGsRvwRoAYj10wPIgHtLC822w/EojuddJUjZwBtI79evr4
        5Bc2bB9z7c4pCPJuq2R6WNpglHYTSWj7HKbPbz4MLwT37DUUVToYMXEDuO0suWjB
        ijlinE6A4Zl2DN6KU84GAVbZ6GOq3/P/unXeUMa5DE911ZMv2Z2Fffio0sHpT7/D
        3ezRMTu6T/faL0LWSoDtDDjBAHXpgl7vskD15e9ouYcqOBNaE9SJ3uA/IN6TkR6e
        l5h6rzb7Rs1bSkPY27nooYXz817eXRnce7jDOz4mgmdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CIllm1
        RQGKDnnYq/cuRGvlgqk6bL4rxpvo2PzoGHqJg=; b=KMbQ2B5kP4ccBw3FVtCaBu
        mBe7ZpfGxQWA/T7q9Z2MdB621Ta90lhFKO4y7M710fZAq6P8x2LppNhM1zLvZUUi
        AR4SIvfsEnvGjnNjntZCzClL5XkvOdx3igrB1rLXcyotw1Fqa0nBwBD9LxGcA4LJ
        yUc++fJQKDpIBcrCQ4dRDZd5BAeSBbOzkbCswWjs6A4hXd6W4mugNPq5grukMdeV
        SBA3xtAD4QzSIGECgIu268nMGad6tx3kHj5ih8kYvENqgLpKX1GNCViHiSZnVLZx
        GacnJx7W50rqj9uLcPIy0Tj7CdNsUcAp9LzeHYPz9Ra4BIQsbEDLtFzAQUYyO3sw
        ==
X-ME-Sender: <xms:1lvLXt68Hdg0jygQTe662_s_m0f4pXUJfj0zFdpMERVCROhpTGGUzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffhvfffkfgfgggtgfesthejredttderjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtge
    eghfevffeutdeviefgkefhhfeijeffgfeujeejueehgeetueffgfeifeegveenucfkphep
    uddukedrvddtkedrudejkedrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:1lvLXq769qTWUDaFNpMZ8liDVSPNLZuxAATRZ9dV1JF25-gFg9bZUw>
    <xmx:1lvLXkdoKRbWWiFkpIG9kb9KjVCKjnXzCLrL7s1mrThkjpg1eFuYQw>
    <xmx:1lvLXmKcqJuhxEvGis3s2wIDS7BlQyrtcb11hXmbnyI7KgS811NvcA>
    <xmx:11vLXvj_XGn5OYAmqAXLMgp94WYk3PrfjhyCd-8Rxdi0k2qRQ4fhjw>
Received: from mickey.localdomain (unknown [118.208.178.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C5413066549;
        Mon, 25 May 2020 01:47:02 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.localdomain (Postfix) with ESMTP id 90BB3A01C8;
        Mon, 25 May 2020 13:46:59 +0800 (AWST)
Subject: [PATCH 0/4] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 May 2020 13:46:59 +0800
Message-ID: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For very large systems with hundreds of CPUs and TBs of RAM booting can
take a very long time.

Initial reports showed that booting a configuration of several hundred
CPUs and 64TB of RAM would take more than 30 minutes and require kernel
parameters of udev.children-max=1024 systemd.default_timeout_start_sec=3600
to prevent dropping into emergency mode.

Gathering information about what's happening during the boot is a bit
challenging. But two main issues appeared to be, a large number of path
lookups for non-existent files, and high lock contention in the VFS during
path walks particularly in the dentry allocation code path.

The underlying cause of this was believed to be the sheer number of sysfs
memory objects, 100,000+ for a 64TB memory configuration.

This patch series tries to reduce the locking needed during path walks
based on the assumption that there are many path walks with a fairly
large portion of those for non-existent paths.

This was done by adding kernfs negative dentry caching (non-existent
paths) to avoid continual alloc/free cycle of dentries and a read/write
semaphore introduced to increase kernfs concurrency during path walks.

With these changes the kernel parameters of udev.children-max=2048 and
systemd.default_timeout_start_sec=300 for are still needed to get the
fastest boot times and result in boot time of under 5 minutes.

There may be opportunities for further improvements but the series here
has seen a fair amount of testing. And thinking about what else could be
done, and discussing it with Rick Lindsay, I suspect improvements will
get more difficult to implement for somewhat less improvement so I think
what we have here is a good start for now.

I think what's needed now is patch review, and if we can get through
that, send them via linux-next for broader exposure and hopefully have
them merged into mainline.
---

Ian Kent (4):
      kernfs: switch kernfs to use an rwsem
      kernfs: move revalidate to be near lookup
      kernfs: improve kernfs path resolution
      kernfs: use revision to identify directory node changes


 fs/kernfs/dir.c             |  283 ++++++++++++++++++++++++++++---------------
 fs/kernfs/file.c            |    4 -
 fs/kernfs/inode.c           |   16 +-
 fs/kernfs/kernfs-internal.h |   29 ++++
 fs/kernfs/mount.c           |   12 +-
 fs/kernfs/symlink.c         |    4 -
 include/linux/kernfs.h      |    5 +
 7 files changed, 232 insertions(+), 121 deletions(-)

--
Ian

