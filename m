Return-Path: <linux-fsdevel+bounces-12513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C8860212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA94A1C25995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BE14B817;
	Thu, 22 Feb 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj4RWKg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7126523D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628616; cv=none; b=kmIqnKvT705zjEoJkCEfrlAWuMAVSlAvGcWVmMAkcDamoPt9m86NiEBewHal3jz7G/3adwuOQzqsOcMdgmZYgpNQsXHKnoVm9QYS2dbXShI3C68bjtQqlWgS80B2Xdzz9ZteccOILDPgq2etXWv0qBNrdmdny4qlML37707kNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628616; c=relaxed/simple;
	bh=6dCKFUCaPK3s9NlKR5EvQHYB2Jb2Ua3pARQMtG7h8OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHCHfy8njA3ppsO6kS48k6qAzbwFunv0chVr0jKWbo5d26B3dII4nL4BNkKJpi00vfmJsL5HhlUX3MlyjlEvIm9p/0y316hkFlynyYt9mGjLCcSFkJ+iotsP6SxzytqMDDglboQ5qZ1LqeqCO3mF+2Uw9leNpubEUQq9LjMIw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj4RWKg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A65C433F1;
	Thu, 22 Feb 2024 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708628616;
	bh=6dCKFUCaPK3s9NlKR5EvQHYB2Jb2Ua3pARQMtG7h8OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj4RWKg3Fd3r5dvtDlOmeS7z2k5xGkBAY95eDdvX1yA6O1LtsmRcmdJMfz/yYiWOw
	 +IxZVXKqq93ZErw6y4aaIDv75hFBAiahgo8ArIT/EzRgpvNMi30qC1rbYNhuXW0BpN
	 mc1+M5qzfXOwgyq+LtMDHhvnwc7Bo74AS0mSMxZuEAxZfeTc3ZexyS0d2x1PTk635F
	 gQeATt/gGYJOGzTBwf+1Ecrr6u+CwJ+xGcGhXk/QZBFIrrGboYN9PRhoT+YduLr+Y+
	 cei8DLqOsPizyknVOQoYJK2inwhy3ajqRSxrhqeAdGSXXi3pzIn8388sgvsHg/bEFX
	 QgU8fAfurxhKA==
Date: Thu, 22 Feb 2024 12:03:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Seth Forshee <sforshee@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240222190334.GA412503@dev-arch.thelio-3990X>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>

Hi Christian,

On Tue, Feb 13, 2024 at 05:45:47PM +0100, Christian Brauner wrote:
> This moves pidfds from the anonymous inode infrastructure to a tiny
> pseudo filesystem. This has been on my todo for quite a while as it will
> unblock further work that we weren't able to do simply because of the
> very justified limitations of anonymous inodes. Moving pidfds to a tiny
> pseudo filesystem allows:
> 
> * statx() on pidfds becomes useful for the first time.
> * pidfds can be compared simply via statx() and then comparing inode
>   numbers.
> * pidfds have unique inode numbers for the system lifetime.
> * struct pid is now stashed in inode->i_private instead of
>   file->private_data. This means it is now possible to introduce
>   concepts that operate on a process once all file descriptors have been
>   closed. A concrete example is kill-on-last-close.
> * file->private_data is freed up for per-file options for pidfds.
> * Each struct pid will refer to a different inode but the same struct
>   pid will refer to the same inode if it's opened multiple times. In
>   contrast to now where each struct pid refers to the same inode. Even
>   if we were to move to anon_inode_create_getfile() which creates new
>   inodes we'd still be associating the same struct pid with multiple
>   different inodes.
> * Pidfds now go through the regular dentry_open() path which means that
>   all security hooks are called unblocking proper LSM management for
>   pidfds. In addition fsnotify hooks are called and allow for listening
>   to open events on pidfds.
> 
> The tiny pseudo filesystem is not visible anywhere in userspace exactly
> like e.g., pipefs and sockfs. There's no lookup, there's no complex
> inode operations, nothing. Dentries and inodes are always deleted when
> the last pidfd is closed.
> 
> The code is entirely optional and fairly small. If it's not selected we
> fallback to anonymous inodes. Heavily inspired by nsfs which uses a
> similar stashing mechanism just for namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Apologies if this has already been reported or fixed but I did not see
anything on the mailing list.

On next-20240221 and next-20240222, with CONFIG_FS_PID=y, some of my
services such as abrtd, dbus, and polkit fail to start on my Fedora
machines, which causes further isssues like failing to start network
interfaces with NetworkManager. I can easily reproduce this in a Fedora
39 QEMU virtual machine, which has:

  # systemctl --version
  systemd 254 (254.9-1.fc39)
  +PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT
   default-hierarchy=unified

Unfortunately, there does not really appear to be much information to
provide off bat but I am more than happy to try and gather whatever
information would be helpful if you are not able to reproduce locally.

  # uname -r
  6.8.0-rc1-00017-ga1a466d5af6c

  # zgrep CONFIG_FS_PID /proc/config.gz
  CONFIG_FS_PID=y

  # systemctl status polkit.service
  × polkit.service - Authorization Manager
       Loaded: loaded (/usr/lib/systemd/system/polkit.service; static)
      Drop-In: /usr/lib/systemd/system/service.d
               └─10-timeout-abort.conf
       Active: failed (Result: timeout) since Thu 2024-02-22 11:35:52 MST; 11min ago
         Docs: man:polkit(8)
      Process: 844 ExecStart=/usr/lib/polkit-1/polkitd --no-debug (code=killed, signal=TERM)
     Main PID: 844 (code=killed, signal=TERM)
          CPU: 116ms

  Feb 22 11:34:22 qemu systemd[1]: Starting polkit.service - Authorization Manager...
  Feb 22 11:34:22 qemu polkitd[844]: Started polkitd version 123
  Feb 22 11:34:22 qemu polkitd[844]: Loading rules from directory /etc/polkit-1/rules.d
  Feb 22 11:34:22 qemu polkitd[844]: Loading rules from directory /usr/share/polkit-1/rules.d
  Feb 22 11:34:22 qemu polkitd[844]: Finished loading, compiling and executing 5 rules
  Feb 22 11:34:22 qemu polkitd[844]: Acquired the name org.freedesktop.PolicyKit1 on the system bus
  Feb 22 11:35:52 qemu systemd[1]: polkit.service: start operation timed out. Terminating.
  Feb 22 11:35:52 qemu systemd[1]: polkit.service: Failed with result 'timeout'.
  Feb 22 11:35:52 qemu systemd[1]: Failed to start polkit.service - Authorization Manager.

vs.

  # uname -r
  6.8.0-rc1-00016-gd68c1231c030

  # systemctl status polkit.service
  ● polkit.service - Authorization Manager
       Loaded: loaded (/usr/lib/systemd/system/polkit.service; static)
      Drop-In: /usr/lib/systemd/system/service.d
               └─10-timeout-abort.conf
       Active: active (running) since Thu 2024-02-22 11:30:38 MST; 21s ago
         Docs: man:polkit(8)
     Main PID: 843 (polkitd)
        Tasks: 4 (limit: 19010)
       Memory: 5.0M
          CPU: 169ms
       CGroup: /system.slice/polkit.service
               └─843 /usr/lib/polkit-1/polkitd --no-debug

  Feb 22 11:30:38 qemu systemd[1]: Starting polkit.service - Authorization Manager...
  Feb 22 11:30:38 qemu polkitd[843]: Started polkitd version 123
  Feb 22 11:30:38 qemu polkitd[843]: Loading rules from directory /etc/polkit-1/rules.d
  Feb 22 11:30:38 qemu polkitd[843]: Loading rules from directory /usr/share/polkit-1/rules.d
  Feb 22 11:30:38 qemu polkitd[843]: Finished loading, compiling and executing 5 rules
  Feb 22 11:30:38 qemu polkitd[843]: Acquired the name org.freedesktop.PolicyKit1 on the system bus
  Feb 22 11:30:38 qemu systemd[1]: Started polkit.service - Authorization Manager.

or

  # uname -r
  6.8.0-rc1-00017-ga1a466d5af6c

  # zgrep CONFIG_FS_PID /proc/config.gz
  # CONFIG_FS_PID is not set

  # systemctl status polkit.service
  ● polkit.service - Authorization Manager
       Loaded: loaded (/usr/lib/systemd/system/polkit.service; static)
      Drop-In: /usr/lib/systemd/system/service.d
               └─10-timeout-abort.conf
       Active: active (running) since Thu 2024-02-22 11:52:41 MST; 5min ago
         Docs: man:polkit(8)
     Main PID: 845 (polkitd)
        Tasks: 4 (limit: 19010)
       Memory: 5.0M
          CPU: 177ms
       CGroup: /system.slice/polkit.service
               └─845 /usr/lib/polkit-1/polkitd --no-debug

  Feb 22 11:52:41 qemu systemd[1]: Starting polkit.service - Authorization Manager...
  Feb 22 11:52:41 qemu polkitd[845]: Started polkitd version 123
  Feb 22 11:52:41 qemu polkitd[845]: Loading rules from directory /etc/polkit-1/rules.d
  Feb 22 11:52:41 qemu polkitd[845]: Loading rules from directory /usr/share/polkit-1/rules.d
  Feb 22 11:52:41 qemu polkitd[845]: Finished loading, compiling and executing 5 rules
  Feb 22 11:52:41 qemu polkitd[845]: Acquired the name org.freedesktop.PolicyKit1 on the system bus
  Feb 22 11:52:41 qemu systemd[1]: Started polkit.service - Authorization Manager.

I looked your most recent push of vfs.pidfd but I did not see anything
that would have appeared to fix this, so I did not test it.

Cheers,
Nathan

