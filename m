Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64C3049BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhAZFXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:33 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39973 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbhAYJeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:34:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BB2ED5C00AF;
        Mon, 25 Jan 2021 03:53:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Jan 2021 03:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=OvcGrXJr8CgyvbCgEiJD6J/PhQ
        tiSlcW56hw0BG2LIw=; b=sameHGJt201rxm27ByntSSWuzJF/8KwXSVEZ0xBijh
        CIgzrzYvP2vWBqvXpJjY1Eixed+kpTETw5Tp3BE4v2kfdZA7HpaPTFViArhUpTYd
        cACSm8/dGHc/uYp/w0WIG8cBJfTJgCbEJfshH/yuIpkM2pIrFD1LeA+3JIgGIPfn
        l2UTTWyaKCuuppKwYp+I2p8yTHfuL8RidVq6GMJ+PcJRa5hJZI9AWVW0wlEbs6tj
        eYiE3buc2k75F8eZ+1q3sRnGTMWiQvCBM8/V1WoRgLe6TCtsZ4XH8jTdw7neUqP4
        9re+L3e2/JlXMyLLtzfyNlieiL7vfyA4v9uNNPcVvKtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OvcGrX
        Jr8CgyvbCgEiJD6J/PhQtiSlcW56hw0BG2LIw=; b=BKgUI2t+EvkTKq6n0T3wOP
        4cvEQ68cl8ZIk3FOGriGpJ4reYEwOMNB4nYCldYIDwipXgQB8exprF+1Q0SgMR3T
        dQAU6NJVrvcO12IrPYmrcLzd3w6xoy0JF4Khu14I58EZigGSN3ggKgqjVq83orUL
        KQNRHZlCrk6j0kcBnaS/V37if4tZBubKOk1GVQ3+74mLs7advPkOMrD43NV3L8w6
        4hWeOMrSPL4MjmKF3wkJbuR8JZONMyonuanB+KuiWqMeQJQj+uS8/REMPapOaE44
        NNr2aQZZlgkMyudcDZZXX4aaxplyQ6ZFVfJ0EPzob0tte1fv1MYCd4uNwtp9KTaQ
        ==
X-ME-Sender: <xms:GocOYDEvfkLODUzFAgSZt-RY6TsbyNNa45XIf8UUMIbuRbDhqBAovg>
    <xme:GocOYAU6QvXicGt7xwhAl4tmNVMuIM9lJY5R3vO5cv8FVTYjutR3EncyCNMx-5z2P
    bFS1icRmORX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggfgsehtjeertd
    dtreejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgv
    theqnecuggftrfgrthhtvghrnheptdeuheffueekkeduvddtffefhfevkefgheetveelvd
    eileegkeeiveektdfgleeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphep
    uddtiedrieelrddvvdejrddvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:GocOYFKKT7fjXFRxu6bBWTKNqgnVxyLa3Dxe1OpPuTnoXh7mRF4B5w>
    <xmx:GocOYBH9nmdvvjM44mKxTPDfaTWnJyTDiBn6c5J_rT1rmynMj7ZY3g>
    <xmx:GocOYJXK_jvo4ayJsbQdm3qRrz1OQo6sPi5wQi2SDqiQ1U0W5OgkjQ>
    <xmx:GocOYIDID62LCG1b8GgGfpv163TGIFUPGaTg9LdISum_Rr2PfHfjww>
Received: from mickey.themaw.net (106-69-227-234.dyn.iinet.net.au [106.69.227.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1575624005C;
        Mon, 25 Jan 2021 03:53:44 -0500 (EST)
Message-ID: <0a41e6b0c7717eea2d43445cce6174608329f1c2.camel@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.7 release
From:   Ian Kent <raven@themaw.net>
To:     autofs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 16:53:40 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

It's time for a release, autofs-5.1.7.

As with autofs-5.1.6 work to resolve difficulties using very large
large direct mount maps has continued but there have been some
difficulties.

Trying to get back to the situation that existed before symlinking
of the mount table can't be done in libmount because of the way in
which some packages (in particular systemd) use libmount for reading
the mount table.

The approach of using an autofs pseudo mount option "ignore" has been
done in glibc and an autofs configuration option to enable the use of
the option has been added, so it can be used by enabling the setting
in the autofs configuration.

But this approach can't be used for libmount mount table accesses
because systemd needs to see the entire mount table at shutdown so a
user controlled setting isn't the right way to do it.

However, autofs expire is now completely independent of the system
mount table and expire operations for very large direct mount maps are
independent of the size of the direct map itself. This is now dependent
only on the number of active mounts at expire.

The problem of mount activity affecting other system applications still
exists, basically because kernel mount table access is by whole file
and applications that monitor changes to the file need to re-read the
entire file on every change notification to process changes.

Consequently starting autofs with a very large direct mount map will
still cause significant resource usage for a number or process such as
systemd, udisksd and others. Also busy sites with a lot of automount
activity can cause similar problems but there has to be quite a lot of
activity for it to be a problem.

There is a fair bit of improvement to the autofs sss interface module.

This was done because of improvements that were made in sss to improve
the error communication between autofs and sss and it quickly became
clear that there was potential to significantly improve the autofs
module.

For a start autofs wasn't fully utilizing the existing returns which
was fixed.

Also the ability to identify a backend host is not available was added.
And this meant that the autofs module needed quite a bit of change to
take advantage of this new sss functionality.

One consequence of this is that there can be somewhat longer delays if
a backend host is down, including for the interactive key lookup case.

But waiting on these accesses was considered acceptable because the
sss caching is very effective so that this case should be encountered
only very rarely.

Note that if sss does not include these improvements autofs should
continue to behave as it previously did because the ability for autofs
to detect the presencce of the enhacements is part of the sss change.

There are also quite a number of bug fixes and other minor
improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.7.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.7.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.7.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

25/01/2021 autofs-5.1.7
- make bind mounts propagation slave by default.
- update ldap READMEs and schema definitions.
- fix program map multi-mount lookup after mount fail.
- fix browse dir not re-created on symlink expire.
- fix a regression with map instance lookup.
- correct fsf address.
- samples: fix Makefile targets' directory dependencies
- remove intr hosts map mount option.
- fix trailing dollar sun entry expansion.
- initialize struct addrinfo for getaddrinfo() calls.
- fix quoted string length calc in expandsunent().
- fix autofs mount options construction.
- mount_nfs.c fix local rdma share not mounting.
- configure.in: Remove unneeded second call to PKG_PROG_PKG_CONFIG.
- configure.in: Do not append parentheses to PKG_PROG_PKG_CONFIG.
- Use PKG_CHECK_MODULES to detect the libxml2 library.
- fix ldap sasl reconnect problem.
- samples/ldap.schema fix.
- fix configure force shutdown check.
- fix crash in sun_mount().
- fix lookup_nss_read_master() nsswicth check return.
- fix typo in open_sss_lib().
- fix sss_master_map_wait timing.
- add sss ECONREFUSED return handling.
- use mapname in sss context for setautomntent().
- add support for new sss autofs proto version call.
- fix retries check in setautomntent_wait().
- refactor sss setautomntent().
- improve sss setautomntent() error handling.
- refactor sss getautomntent().
- improve sss getautomntent() error handling.
- sss introduce calculate_retry_count() function.
- move readall into struct master.
- sss introduce a flag to indicate map being read.
- update sss timeout documentation.
- refactor sss getautomntbyname().
- improve sss getautomntbyname() error handling.
- use a valid timeout in lookup_prune_one_cache().
- dont prune offset map entries.
- simplify sss source stale check.
- include linux/nfs.h directly in rpc_subs.h.
- fix typo in daemon/automount.c.
- fix direct mount unlink_mount_tree() path.
- fix unlink mounts umount order.
- fix incorrect logical compare in unlink_mount_tree().
- use bit flag for force unlink mounts.
- improve force unlink option description.
- remove command fifo on autofs mount fail.
- add force unlink mounts and exit option.
- cleanup stale logpri fifo pipes on unlink and exit.
- fix incorrect systemctl command syntax in autofs(8).
- update list.h.
- add hashtable implementation.
- change mountpoint to mp in struct ext_mount.
- make external mounts independent of amd_entry.
- make external mounts use simpler hashtable.
- add a hash index to mnt_list.
- use mnt_list for submounts.
- use mnt_list for amdmounts.
- make umount_autofs() static.
- remove force parameter from umount_all().
- fix remount expire.
- fix stale offset directories disable mount.
- use struct mnt_list to track mounted mounts.
- use struct mnt_list mounted list for expire.
- remove unused function tree_get_mnt_list().
- only add expre alarm for active mounts.
- move submount check into conditional_alarm_add().
- move lib/master.c to daemon/master.c.
- use master_list_empty() for list empty check.
- add helper to construct mount point path.
- check defaults_read_config() return.
- move AUTOFS_LIB to end of build rule lines.
- make autofs.a a shared library.
- make lookup_file.c nss map read status return handling consistent.
- fix empty mounts list return from unlink_mount_tree().

Ian

