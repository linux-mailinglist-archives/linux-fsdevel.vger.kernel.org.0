Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E326138134
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgAKLqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 06:46:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728995AbgAKLqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 06:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578743195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fdx4NcN3xhtntnZ3acrQXZY4Bli4JloUVf7CEj1l+kY=;
        b=Vfj741sWscH4Xy4ojnRFyFnE/HSgKxO01f/DX/a9TsFjkWrWHnuF1BUO3b/Y3/YXLHCC0z
        1SYRU+jPcngMRwWMgocIxo64QSXrnbED3CFW/HZXvzM9YIUguHz1aOsX1yHmiuFLFspjKR
        lAqaTqXnWvfl4FKK3qYLCfOCmEbAPNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-G5mt9uRCMqm1dU4JhvfTFg-1; Sat, 11 Jan 2020 06:46:33 -0500
X-MC-Unique: G5mt9uRCMqm1dU4JhvfTFg-1
Received: by mail-wr1-f70.google.com with SMTP id h30so2264352wrh.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jan 2020 03:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fdx4NcN3xhtntnZ3acrQXZY4Bli4JloUVf7CEj1l+kY=;
        b=lDd4kNpsjYXga+jK4pgcWH705W2qhLaEL6n0PTlODmOh+8wECUdhUk15+LgERiZXxy
         aNU+ZbZayuwZ6CVHXru10TM1GyoVVA+lP4s/hhhChR6eTxUR0yPhQVCScfbTS6jhcq1h
         JdIGt/1elsx50gfNaYMW5e1eXoTE91Bk4xrRcSeUxZfpm6X7RMaQtn/Rv51LZBvobxdq
         DuaCz9aeFqYQwxz2kPaRjzKXwYspO8Dfv2g+tAFwqp855rthydP5p81qFXgV5ktCFH2V
         X+/z+5JKb3gbs4usv48r/AQ+63c+rd89vUvlIJJQzMEl1NeliqydN15lIK0Yu8aqJNpx
         Zg0w==
X-Gm-Message-State: APjAAAXBtojz1olgQj9Hddjw27b4Bfbuq87TikkB8Yw9nk8ZMhpsMOp2
        Y7CsgU/TQ6fvdzI/89XvxSqDqXh7fhBEHuRlK1m9pSpH557UymRvxG11R11LihU1lMQcc8R72Ek
        IqaurBMhjH88eKTxbtJVP5ivrAQ==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr8529046wrj.349.1578743192445;
        Sat, 11 Jan 2020 03:46:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTavNyb95wOERjfvhKznINzwLE+FRNxJOHctAj0I5MIhm+o4S9+CrbbWlsyVBt2epM9D8t+g==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr8529011wrj.349.1578743192066;
        Sat, 11 Jan 2020 03:46:32 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id u1sm6045561wmc.5.2020.01.11.03.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 03:46:31 -0800 (PST)
Subject: Re: [PATCH v19 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20191212140914.21908-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ae314c55-905a-fce0-21aa-81c13279c004@redhat.com>
Date:   Sat, 11 Jan 2020 12:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191212140914.21908-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

On 12-12-2019 15:09, Hans de Goede wrote:
> Hello Everyone,
> 
> Here is the 19th version of my cleaned-up / refactored version of the
> VirtualBox shared-folder VFS driver.
> 
> This version addresses all remarks from Al Viro's review of v18.
> 
> I believe that this is ready for upstream merging now, if this needs
> more work please let me know.
> 
> Changes in v19:
> - Misc. small code tweaks suggested by Al Viro (no functional changes)
> - Do not increment dir_context->pos when dir_emit has returned false.
> - Add a WARN_ON check for trying to access beyond the end of a
>    vboxsf directory buffer, this uses WARN_ON as this means the host has
>    given us corrupt data
> - Catch the user passing the "nls" opt more then once

Ping? Can I please either get some feedback on this patch, or can we get
this merged / queued up for 5.6 please ?

Regards,

Hans




> ---
> 
> Full changelog:
> 
> Changes in v19:
> - Misc. small code tweaks suggested by Al Viro (no functional changes)
> - Do not increment dir_context->pos when dir_emit has returned false.
> - Add a WARN_ON check for trying to access beyond the end of a
>    vboxsf directory buffer, this uses WARN_ON as this means the host has
>    given us corrupt data
> - Catch the user passing the "nls" opt more then once
> 
> Changes in v18:
> - Move back to fs/vboxsf for direct submission to Linus
> - Squash in a few small fixes done during vboxsf's brief stint in staging
> - Add handling of short copies to vboxsf_write_end
> - Add a comment about our simple_write_begin usage (Suggested by David Howell)
> 
> Changes in v17:
> - Submit upstream through drivers/staging as this is not getting any
>    traction on the fsdevel list
> - Add TODO file
> - vboxsf_free_inode uses sbi->idr, call rcu_barrier from put_super to make
>    sure all delayed rcu free inodes are flushed
> 
> Changes in v16:
> - Make vboxsf_parse_monolithic() static, reported-by: kbuild test robot
> 
> Changes in v15:
> - Rebase on top of 5.4-rc1
> 
> Changes in v14
> - Add a commment explaining possible read cache strategies and which one
>    has been chosen
> - Change pagecache-invalidation on open (inode_revalidate) to use
>    invalidate_inode_pages2() so that mmap-ed pages are dropped from
>    the cache too
> - Add a comment to vboxsf_file_release explaining why the
>    filemap_write_and_wait() call is done there
> - Some minor code tweaks
> 
> Changes in v13
> - Add SPDX tag to Makefile, use foo-y := to set objectfile list
> - Drop kerneldoc headers stating the obvious from vfs callbacks,
>    to avoid them going stale
> - Replace sf_ prefix of functions and data-types with vboxsf_
> - Use more normal naming scheme for sbi and private inode data:
>      struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);
>      struct vboxsf_inode *sf_i = VBOXSF_I(inode);
> - Refactor directory reading code
> - Use goto based unwinding instead of nested if-s in a number of places
> - Consolidate dir unlink and rmdir inode_operations into a single function
> - Use the page-cache for regular reads/writes too
> - Directly set super_operations.free_inode to what used to be our
>    vboxsf_i_callback, instead of setting super_operations.destroy_inode
>    to a function which just does: call_rcu(&inode->i_rcu, vboxsf_i_callback);
> - Use spinlock_irqsafe for ino_idr_lock
>    vboxsf_free_inode may be called from a RCU callback, and thus from
>    softirq context, so we need to use spinlock_irqsafe vboxsf_new_inode.
>    On alloc_inode failure vboxsf_free_inode may be called from process
>    context, so it too needs to use spinlock_irqsafe.
> 
> Changes in v12:
> - Move make_kuid / make_kgid calls to option parsing time and add
>    uid_valid / gid_valid checks.
> - In init_fs_context call current_uid_gid() to init uid and gid
> - Validate dmode, fmode, dmask and fmask options during option parsing
> - Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
> - Some small coding-style tweaks
> 
> Changes in v11:
> - Convert to the new Documentation/filesystems/mount_api.txt mount API
> - Fixed all the function kerneldoc comments to have things in the proper order
> - Change type of d_type variable passed as type to dir_emit from int to
>    unsigned int
> - Replaced the fake-ino overflow test with the one suggested by David Howells
> - Fixed various coding style issues
> 
> Changes in v10:
> -Code-style fixes and remove some unneeded checks as suggested by Al Viro
> -Stop handle reuse between sf_create_aux and sf_reg_open, the code for this
>   was racy and the re-use meant the O_APPEND was not passed to the host for
>   newly created files with O_APPEND set
> -Use idr to generate unique inode number, modelled after the kernfs code
> -Only read and write the contents of the passed in offset pointer once in
>   sf_reg_write
> -Keep a list of refcounted open handles in the inode, so that writepage can
>   get a writeable handle this way. This replaces the old very racy code which
>   was just storing a pointer to the last opened struct file inside the inode.
>   This is modelled after how the cifs and fuse code do this
> 
> Changes in v9:
> -Change license from GPL-2.0 or CDDL-1.0 to MIT, following upstream's
>   license change from: https://www.virtualbox.org/changeset/72627/vbox
>   I've gotten permission by email from VirtualBox upstream to retro-actively
>   apply the license-change to my "fork" of the vboxsf code
> -Fix not being able to mount any shared-folders when built with gcc9
> -Adjust for recent vboxguest changes
> -Fix potential buffer overrun in vboxsf_nlscpy
> -Fix build errors in some configs, caught by buildbot
> -Fix 3 sparse warnings
> -Some changes from upstream VirtualBox svn:
>   -Use 0x786f4256 /* 'VBox' little endian */ as super-magic matching upstream
>   -Implement AT_STATX_SYNC_TYPE support
>   -Properly return -EPERM when symlink creation is not supported
> 
> Changes in v8:
> -Fix broken error-handling / oops when the vboxsf_map_folder() call fails
> -Fix umount using umount.nfs to umount vboxsf mounts
> -Prefixed the modules init and exit function names with vboxsf_
> -Delay connecting to the vbox hypervisor until the first mount, this fixes
>   vboxsf not working when it is builtin (in which case it may be initialized
>   before the vboxguest driver has bound to the guest communication PCI device)
> -Fix sf_write_end return value, return the number of bytes written or 0 on error:
>   https://github.com/jwrdegoede/vboxsf/issues/2
> -Use an ida id in the name passed to super_setup_bdi_name so that the same
>   shared-folder can be mounted twice without causing a
>   "sysfs: cannot create duplicate filename" error
>   https://github.com/jwrdegoede/vboxsf/issues/3
> 
> Changes in v7:
> -Do not propagate sgid / suid bits between guest-host, note hosts with
>   VirtualBox version 5.2.6 or newer will filter these out regardless of what
>   we do
> -Better error messages when we cannot connect to the VirtualBox guest PCI
>   device, which may e.g. happen when trying to use vboxsf outside a vbox vm
> 
> Changes in v6:
> -Address: https://www.virtualbox.org/ticket/819 which really is multiple bugs:
>   1) Fix MAP_SHARED not being supported
>   2) Fix changes done through regular read/write on the guest side not being
>      seen by guest apps using mmap() access
>   3) Fix any changes done on the host side not being seen by guest apps using
>      mmap() access
> 
> Changes in v5:
> -Honor CONFIG_NLS_DEFAULT (reported-by michael.thayer@oracle.com)
> 
> Changes in v4:
> -Drop "name=..." mount option, instead use the dev_name argument to the
>   mount syscall, to keep compatibility with existing fstab entries
> -Fix "nls=%" match_table_t entry to "nls=%s"
> 
> Changes in v3:
> -Use text only mount options, instead of a custom data struct
> -Stop caching full path in inode data, if parents gets renamed it will change
> -Fixed negative dentries handling
> -Dropped the force_reread flag for dirs, not sure what it was actually for
>   but it is no good, doing a re-read on unlink of a file will lead to
>   another file being skipped if the caller has already iterated over the
>   entry for the unlinked file.
> -Use file_inode(), file_dentry() and d_inode() helpers
> -Prefix any non object-private symbols with vboxsf_ so as to not pollute
>   the global namespace when builtin
> -Add MAINTAINERS entry
> -Misc. cleanups
> 
> Changes in v2:
> -Removed various unused wrapper functions
> -Don't use i_private, instead defined alloc_inode and destroy_inode
>   methods and use container_of.
> -Drop obsolete comment referencing people to
>   http://www.atnf.csiro.au/people/rgooch/linux/vfs.txt
> -move the single symlink op of from lnkops.c to file.c
> -Use SPDX license headers
> -Replace SHFLROOT / SHFLHANDLE defines with normal types
> -Removed unnecessary S_ISREG checks
> -Got rid of bounce_buffer in regops, instead add a "user" flag to
>   vboxsf_read / vboxsf_write, re-using the existing __user address support
>   in the vboxguest module
> -Make vboxsf_wrappers return regular linux errno values
> -Use i_size_write to update size on writing
> -Convert doxygen style comments to kerneldoc style comments
> 

