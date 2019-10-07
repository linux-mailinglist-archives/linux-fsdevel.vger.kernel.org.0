Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99342CDA01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJGAvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 20:51:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56513 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfJGAvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:51:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A352E20DC2;
        Sun,  6 Oct 2019 20:51:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 06 Oct 2019 20:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=AUCWi7dg8CtTdu5/plLNnp01CE
        E4wJlXKJek4yB9CPI=; b=3HG4LrcTHN9Rt/xJv6OQOYG4uykAeci7ZaesvYVqtA
        98SCnmKSFkIbvAvi5v8alch9hVABsNEtXKfagZipFoAX0JZr9F9sSKbGmv8DXSI1
        IQB47gas/pvfledWYBMybbOYsgz6Ndvqu7RhnC+AUnFvKhSqSCw4TM9xwW/Y+y1Q
        jFngz5AnMcvweIye+bF9HukBtI5ItKLd0npPgcvt6YJZm3ajXmT/JfNpcBfTYkSF
        nE20fjgqeIoe8rvLZfzypeeAbPiIJGV6xNa4g76JCLMm9489sUQUtbkVPwyiUuD6
        jW2Wp5tvWmeOWEVUsTXEku1IEBjTT1nmKfmqrpCBE6Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AUCWi7
        dg8CtTdu5/plLNnp01CEE4wJlXKJek4yB9CPI=; b=B1vpEkXfw6jp1jIhBihmsn
        me06S9umVe0fiZYflrjG6CUdp3dzeZTS3DSaRbELikITq/w9eK7F0OcND0osxXmq
        Le+7ICBdK+ZdevvU/o3/HvjyaB/xRxTgp6ge5Px03SqZh/O1Sv/doZXTFekc0Gbn
        oUCl6TNpGgnYvVxsm84pQ7Hse1bqFCdEe+av6uPODpAIhzqnglgQzDxntJrVnpZQ
        G50+JJIOM0LQI8M9uBFFL8OZpXREktXPNPUzbl21lDWmFSzXf2R/mm6oBdwYMGS2
        Jqdm1timoX5QWzEoKg7XI99uo0jvXqnuckC+mTlS4iFVG6Gszzmm33zxkd6ePYHA
        ==
X-ME-Sender: <xms:-YuaXRdrZJ1Zb5cJZxFTeHSMQmwChPDyGgeeJFqpxhKmmZ3RqDyaFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfggggfesthejredttd
    erjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvght
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduudekrddvtdelrdduke
    efrdejudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhn
    vghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-ouaXTc4UYhOy_DMBme8dTXijB5zTjTrQ84A7iGsGqDONF9P9NMfdQ>
    <xmx:-ouaXVhGdUmzTaS08x2SX7Ck7y3vRKRxDxjCYXa8CBFQiG3vg186wA>
    <xmx:-ouaXfQMQdw9KnQctQja8oMpj3k0yzpEcIo89gpjEgoDRbwOuNcNHw>
    <xmx:-ouaXco0bU1zHip3hDK6BK7KcXBrX7YqjNVAfyCt-891n-M1X4aoFw>
Received: from mickey.themaw.net (unknown [118.209.183.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66832D6005B;
        Sun,  6 Oct 2019 20:51:04 -0400 (EDT)
Message-ID: <199d4dd82398c5a2cc915525024a122ed73a6637.camel@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.6 release
From:   Ian Kent <raven@themaw.net>
To:     autofs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 08:51:00 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

It's time for a release, autofs-5.1.6.

This is an important release because it marks the beginning of
work to be done torward resolving the very long standing problem
of using very large direct mount maps in autofs, along with the
needed mitigatigation of the effects of those large mount tables
in user space.

The first thing that needs to be done is for autofs to get back
to what is was before the symlinking of the mount table to the
proc file system. From experience having a large number of (largely
not useful) autofs mount entries showing up in the mount table
makes system administation frustrating and is quite annoying.

To do this I'm using the same approach used in other SysV autofs
implementations of providing an autofs pseudo mount option "ignore"
that can be used by user space as a hint to ignore these mount
entries.

This will require fairly straight forward changes to glibc and
libmount at least. The glibc change has been accepted and I plan
on submitting a change for libmount when I get a chance.

A configuration option, use_ignore_mount_option, has been added
to autofs that is initially disabled to allow people to enable it
when they are confident that there won't be unexpected problems.

The side effects of very large mount tables in user space is
somewhat difficult to mitigate.

First, to acheive this autofs needs to not use the system mount
table for expiration "at all". Not using the mount table for expires
has proven very difficult to do and initial attempts resulted in
changes that didn't fit in well at all.

The changes to clean up the mount table listing amounted to making
autofs use it's own genmntent(3) implementation (borrowed from glibc)
but quite a bit of that change was re-factoring toward eliminating
the need to use the mount table during expires. I had trouble getting
that to work, let alone stable, but the approach will fit in well
with the current design so it's progress.

Then there's the affect of very large mount tables on other user
space applications.

For example, under rapid mount activity we see several user space
process, systemd, udisk2, et. al., growing to consume all available
CPU and a couple of others performing poorly simply because the
mount table is large.

I had planned on using the fsinfo() system call being proposed by
David Howells for initial mount handing improvements in libmount,
and later David's related kernel notifications proposal for further
libmount mount table handling improvements but those propsals have
seen some challenges being accepted so we will have to wait and see
how things go before working out how to acheive this rather difficult
goal.

So there's a long way to go but progress is bieng made!

Additionally there are a number of bug fixes and other minor
improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.6.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.6.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.6.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

07/10/2019 autofs-5.1.6
- support strictexpire mount option.
- fix hesiod string check in master_parse().
- add NULL check for get_addr_string() return.
- use malloc(3) in spawn.c.
- add mount_verbose configuration option.
- optionally log mount requestor process info.
- log mount call arguments if mount_verbose is set.
- Fix NFS mount from IPv6 addresses.
- make expire remaining log level debug.
- allow period following macro in selector value.
- fix macro expansion in selector values.
- fix typing errors.
- Explain /etc/auto.master.d usage.
- plus map includes are only allowed in file sources.
- Update README.
- fix additional typing errors.
- update autofs(8) offset map entry update description.
- increase group buffer size geometrically.
- also use strictexpire for offsets.
- remove unused function has_fstab_option().
- remove unused function reverse_mnt_list().
- remove a couple of old debug messages.
- fix amd entry memory leak.
- fix unlink_mount_tree() not umounting mounts.
- use ignore option for offset mounts as well.
- add config option for "ignore" mount option
- use bit flags for autofs mount types in mnt_list.
- use mp instead of path in mnt_list entries.
- always use PROC_MOUNTS to make mount lists.
- add glibc getmntent_r().
- use local getmntent_r in table_is_mounted().
- refactor unlink_active_mounts() in direct.c.
- don't use tree_is_mounted() for mounted checks.
- use single unlink_umount_tree() for both direct and indirect mounts.
- move unlink_mount_tree() to lib/mounts.c.
- use local_getmntent_r() for unlink_mount_tree().
- use local getmntent_r() in get_mnt_list().
- use local getmntent_r() in tree_make_mnt_list().
- fix missing initialization of autofs_point flags.

Ian

