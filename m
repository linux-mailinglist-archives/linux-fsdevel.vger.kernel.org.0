Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F413A5818
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhFML6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 07:58:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:48587 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhFML6k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:58:40 -0400
Received: by nautica.notk.org (Postfix, from userid 108)
        id 78D1CC01C; Sun, 13 Jun 2021 13:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623585397; bh=F3BhzyU8+ZAUVp/ArSoFhHPVCMPYqmG5jjoHGqzU654=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsHcteU+yTXCmagMp/ZvaR7MOtzeoY42MPWlWePrHFwMvVxzj+NBguPOX3j5IRl0v
         PvpIbNVbC0qb2P0ISXKZ8vLiepehmhB/q9m14RHid7zqvMPTVtMS0yAN1q2k5xFJNx
         Mo37imLm7D0oxfmI16wxi1S4hdd06ixKzstZoUW1yZuNvX8FFQ6EWCMJVMGaV9I5wV
         wBrW/OMwDFpOjGJPaIUj61SeyFJ7PgQprTrD1JW/gP9MeiqJ/0csXBSItWU044vB0C
         VF61k/p0qiIL4E7GRXDcvwPIoBo254UWXyaVqduzeag4rbZ5I/aZsnhfkkyTA6K62o
         KnvPCWRqvxQFQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A1F46C01E;
        Sun, 13 Jun 2021 13:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623585396; bh=F3BhzyU8+ZAUVp/ArSoFhHPVCMPYqmG5jjoHGqzU654=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS20xlzkSeVSvCIjVgE/luNDX2wo7pgI9R105WOsr5EC+9UCz5uzqxuT0u+mkfQyf
         UCasP35f8tv9p2dQQDHpzA18y8soqL1LGJxQ77DYVFtrvDlmNqj1sfKAer55nKuCV7
         VV/7eeZA2ZIT6Failx+p3OItQycI26GEBWf4HJ5rekyNaS3iGlIlfSwSg4X/LXRuMk
         QzQQe4nuyf/TWhdI75gmZZuGSbgDsufQXtDHQORL7IX3XPZ4B+OwO1mkFSJLsapxpl
         7tNrBah4+fP4ZBdPDWKlj1LRnswpTxGoLuTnfPiltmWZYTkfKAIBWH2GSbY7TNWzUX
         6EHSJWw7gfzKg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ca0fbf5c;
        Sun, 13 Jun 2021 11:56:26 +0000 (UTC)
Date:   Sun, 13 Jun 2021 20:56:11 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <YMXyW0KXc3HqdUAj@codewreck.org>
References: <20210608153524.GB504497@redhat.com>
 <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
 <20210609154543.GA579806@redhat.com>
 <YMHKZhfT0CUgeLno@stefanha-x1.localdomain>
 <YMHOXn2cpGh1T9vz@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMHOXn2cpGh1T9vz@codewreck.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet wrote on Thu, Jun 10, 2021 at 05:33:34PM +0900:
> Stefan Hajnoczi wrote on Thu, Jun 10, 2021 at 09:16:38AM +0100:
> > virtio-9p should be simple. I'm not sure how much additional setup the
> > other 9p transports require. TCP and RDMA seem doable if there are
> > kernel parameters to configure things before the root file system is
> > mounted.
> 
> For TCP, we can probably piggyback on what nfs does for this, see the
> ip= parameter in Documentation/admin-guide/nfs/nfsroot.rst -- it lives
> in net/ipv4/ipconfig.c so should just work out of the box

Hm, just tried and it doesn't quite work for some reason -- in this
stack trace:
 kthread_should_stop+0x71/0xb0
 wait_woken+0x182/0x1c0
 __inet_stream_connect+0x48a/0xc00
 inet_stream_connect+0x53/0xa0
 p9_fd_create_tcp+0x2d6/0x420
 p9_client_create+0x7bc/0x11d0
 v9fs_session_init+0x1cd/0x1220
 v9fs_mount+0x8c/0x870
 legacy_get_tree+0xef/0x1d0
 vfs_get_tree+0x83/0x240
 path_mount+0xda3/0x1800
 init_mount+0x98/0xdd
 do_mount_root+0xe0/0x255
 mount_root+0x47/0xd7
 prepare_namespace+0x136/0x165
 kernel_init+0xd/0x123
 ret_from_fork+0x22/0x30

current->set_child_tid is null, causing a null deref when checking
&to_kthread(current)->flags

It does work with nfsroot though so even if this doesn't look 9p
specific I guess I'll need to debug that eventually, but this can
be done later... I'm guessing they don't use the same connect() function
as 9p's is ipv4-specific (ugh) and that needs fixing eventually anyway.

For reference this is relevant part of kernel command line I used for
tcp:
root=fstag:x.y.z.t rootflags=trans=tcp,aname=rootfs rootfstype=9p ip=dhcp

(and ip=dhcp requires CONFIG_IP_PNP_DHCP=y)



Virtio does work quite well though and that's good enough for me -- I
was going to suggest also documenting increasing the msize (setting
e.g. rootflags=msize=262144) but we really ought to increase the
default, that came up recently and since no patch was sent I kind of
forgot... Will do that now.



@Vivek - I personally don't really care much, but would tend to prefer
your v2 (without fstag:) from a user perspective the later is definitely
better but I don't really like the static nobdev_filesystems array --
I'd bite the bullet and use FS_REQUIRES_DEV (and move this part of the
code just a bit below after the root_wait check just in case it matters,
but at that point if something would mount with /dev/root but not with
the raw root=argument then they probably do require a device!)

It could also be gated by a config option like e.g. CONFIG_ROOT_NFS and
others all are to make sure it doesn't impact anyone who doesn't want to
be impacted - I'm sure some people want to make sure their device
doesn't boot off a weird root if someone manages to change kernel params
so would want a way of disabling the option...


Well, if you keep the array, please add 9p to the list and resend as a
proper patch so I can reply with tested-by/reviewed-by tags on something
more final.


Also, matter-of-factedly, how is this going to be picked up?
Is the plan to send it directly to Linus as part of the next virtiofs
PR? Going through Al Viro?


Thanks,
-- 
Dominique
