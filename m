Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316D3587135
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 21:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiHATNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiHATMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:12:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C652195;
        Mon,  1 Aug 2022 12:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB10C381BE;
        Mon,  1 Aug 2022 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659380992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4oLNTc1f4SoEjvnJmrI7rhxjXfQjoPsRzIGDJ8N42I=;
        b=WWlRsefxC8EoEBBeA7PlCAJ6gOke/rInhbjnFKnLhcjhixSl8r3i0JaXVyxrx8XlBWsXW1
        by4wnSdfrSZk0ID6RkDL9393g70NrrLtYBXtPvnbaBWVevU4p9FXgJn6QjAdUSXcpGFGbF
        WqJ097yRS9ky+5BrXMLYrsbuiPq2B2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659380992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4oLNTc1f4SoEjvnJmrI7rhxjXfQjoPsRzIGDJ8N42I=;
        b=HRzf0YIc7uWFVPHVWmMUx+47g9xMMnYrVEpq/GAWGS0h2t+i16ZKRzTI4BLof4It4ezi2W
        JnZ8qVW55q2g2vBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0848313AAE;
        Mon,  1 Aug 2022 19:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F8GnLv8k6GKNSgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 01 Aug 2022 19:09:51 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Subject: [RFC PATCH 3/3] smbfs: update doc references
Date:   Mon,  1 Aug 2022 16:09:33 -0300
Message-Id: <20220801190933.27197-4-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801190933.27197-1-ematsumiya@suse.de>
References: <20220801190933.27197-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update documentation that referenced "cifs" (the module) to use "SMBFS"
or "smbfs".

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 Documentation/admin-guide/index.rst           |   2 +-
 .../admin-guide/{cifs => smbfs}/authors.rst   |   0
 .../admin-guide/{cifs => smbfs}/changes.rst   |   4 +-
 .../admin-guide/{cifs => smbfs}/index.rst     |   0
 .../{cifs => smbfs}/introduction.rst          |   0
 .../admin-guide/{cifs => smbfs}/todo.rst      |  12 +-
 .../admin-guide/{cifs => smbfs}/usage.rst     | 168 +++++++++---------
 .../{cifs => smbfs}/winucase_convert.pl       |   0
 Documentation/filesystems/index.rst           |   2 +-
 .../filesystems/{cifs => smbfs}/cifsroot.rst  |  14 +-
 .../filesystems/{cifs => smbfs}/index.rst     |   0
 .../filesystems/{cifs => smbfs}/ksmbd.rst     |   2 +-
 Documentation/networking/dns_resolver.rst     |   2 +-
 .../translations/zh_CN/admin-guide/index.rst  |   2 +-
 .../translations/zh_TW/admin-guide/index.rst  |   2 +-
 15 files changed, 104 insertions(+), 106 deletions(-)
 rename Documentation/admin-guide/{cifs => smbfs}/authors.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/changes.rst (73%)
 rename Documentation/admin-guide/{cifs => smbfs}/index.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/introduction.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/todo.rst (95%)
 rename Documentation/admin-guide/{cifs => smbfs}/usage.rst (87%)
 rename Documentation/admin-guide/{cifs => smbfs}/winucase_convert.pl (100%)
 rename Documentation/filesystems/{cifs => smbfs}/cifsroot.rst (85%)
 rename Documentation/filesystems/{cifs => smbfs}/index.rst (100%)
 rename Documentation/filesystems/{cifs => smbfs}/ksmbd.rst (99%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5bfafcbb9562..c9cbc5d48f40 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -74,7 +74,7 @@ configure specific aspects of kernel behavior to your liking.
    btmrvl
    cgroup-v1/index
    cgroup-v2
-   cifs/index
+   smbfs/index
    clearing-warn-once
    cpu-load
    cputopology
diff --git a/Documentation/admin-guide/cifs/authors.rst b/Documentation/admin-guide/smbfs/authors.rst
similarity index 100%
rename from Documentation/admin-guide/cifs/authors.rst
rename to Documentation/admin-guide/smbfs/authors.rst
diff --git a/Documentation/admin-guide/cifs/changes.rst b/Documentation/admin-guide/smbfs/changes.rst
similarity index 73%
rename from Documentation/admin-guide/cifs/changes.rst
rename to Documentation/admin-guide/smbfs/changes.rst
index 3147bbae9c43..bbb4c082b991 100644
--- a/Documentation/admin-guide/cifs/changes.rst
+++ b/Documentation/admin-guide/smbfs/changes.rst
@@ -4,6 +4,6 @@ Changes
 
 See https://wiki.samba.org/index.php/LinuxCIFSKernel for summary
 information about fixes/improvements to CIFS/SMB2/SMB3 support (changes
-to cifs.ko module) by kernel version (and cifs internal module version).
-This may be easier to read than parsing the output of "git log fs/cifs"
+to smbfs.ko module) by kernel version (and smbfs internal module version).
+This may be easier to read than parsing the output of "git log fs/smbfs"
 by release.
diff --git a/Documentation/admin-guide/cifs/index.rst b/Documentation/admin-guide/smbfs/index.rst
similarity index 100%
rename from Documentation/admin-guide/cifs/index.rst
rename to Documentation/admin-guide/smbfs/index.rst
diff --git a/Documentation/admin-guide/cifs/introduction.rst b/Documentation/admin-guide/smbfs/introduction.rst
similarity index 100%
rename from Documentation/admin-guide/cifs/introduction.rst
rename to Documentation/admin-guide/smbfs/introduction.rst
diff --git a/Documentation/admin-guide/cifs/todo.rst b/Documentation/admin-guide/smbfs/todo.rst
similarity index 95%
rename from Documentation/admin-guide/cifs/todo.rst
rename to Documentation/admin-guide/smbfs/todo.rst
index 2646ed2e2d3e..7926a2e09042 100644
--- a/Documentation/admin-guide/cifs/todo.rst
+++ b/Documentation/admin-guide/smbfs/todo.rst
@@ -42,8 +42,8 @@ f) Finish inotify support so kde and gnome file list windows
    will autorefresh (partially complete by Asser). Needs minor kernel
    vfs change to support removing D_NOTIFY on a file.
 
-g) Add GUI tool to configure /proc/fs/cifs settings and for display of
-   the CIFS statistics (started)
+g) Add GUI tool to configure /proc/fs/smbfs settings and for display of
+   the SMBFS statistics (started)
 
 h) implement support for security and trusted categories of xattrs
    (requires minor protocol extension) to enable better support for SELINUX
@@ -56,7 +56,7 @@ j) Create UID mapping facility so server UIDs can be mapped on a per
    exists. Also better integration with winbind for resolving SID owners
 
 k) Add tools to take advantage of more smb3 specific ioctls and features
-   (passthrough ioctl/fsctl is now implemented in cifs.ko to allow
+   (passthrough ioctl/fsctl is now implemented in smbfs.ko to allow
    sending various SMB3 fsctls and query info and set info calls
    directly from user space) Add tools to make setting various non-POSIX
    metadata attributes easier from tools (e.g. extending what was done
@@ -67,7 +67,7 @@ l) encrypted file support (currently the attribute showing the file is
    supported).
 
 m) improved stats gathering tools (perhaps integration with nfsometer?)
-   to extend and make easier to use what is currently in /proc/fs/cifs/Stats
+   to extend and make easier to use what is currently in /proc/fs/smbfs/Stats
 
 n) Add support for claims based ACLs ("DAC")
 
@@ -81,14 +81,14 @@ q) Allow mount.cifs to be more verbose in reporting errors with dialect
    or unsupported feature errors. This would now be easier due to the
    implementation of the new mount API.
 
-r) updating cifs documentation, and user guide.
+r) updating smbfs documentation, and user guide.
 
 s) Addressing bugs found by running a broader set of xfstests in standard
    file system xfstest suite.
 
 t) split cifs and smb3 support into separate modules so legacy (and less
    secure) CIFS dialect can be disabled in environments that don't need it
-   and simplify the code.
+   and simplify the code. (work in progress)
 
 v) Additional testing of POSIX Extensions for SMB3.1.1
 
diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/smbfs/usage.rst
similarity index 87%
rename from Documentation/admin-guide/cifs/usage.rst
rename to Documentation/admin-guide/smbfs/usage.rst
index 3766bf8a1c20..ec9950d168d9 100644
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/smbfs/usage.rst
@@ -5,7 +5,7 @@ Usage
 This module supports the SMB3 family of advanced network protocols (as well
 as older dialects, originally called "CIFS" or SMB1).
 
-The CIFS VFS module for Linux supports many advanced network filesystem
+The SMBFS VFS module for Linux supports many advanced network filesystem
 features such as hierarchical DFS like namespace, hardlinks, locking and more.
 It was designed to comply with the SNIA CIFS Technical Reference (which
 supersedes the 1992 X/Open SMB Standard) as well as to perform best practice
@@ -35,7 +35,7 @@ For Linux:
    and change directory into the top of the kernel directory tree
    (e.g. /usr/src/linux-2.5.73)
 2) make menuconfig (or make xconfig)
-3) select cifs from within the network filesystem choices
+3) select SMBFS from within the network filesystem choices (CONFIG_SMBFS)
 4) save and exit
 5) make
 
@@ -43,11 +43,11 @@ For Linux:
 Installation instructions
 =========================
 
-If you have built the CIFS vfs as module (successfully) simply
+If you have built the SMBFS client as module (successfully) simply
 type ``make modules_install`` (or if you prefer, manually copy the file to
-the modules directory e.g. /lib/modules/2.4.10-4GB/kernel/fs/cifs/cifs.ko).
+the modules directory e.g. /lib/modules/$(uname -r)/kernel/fs/smbfs/smbfs.ko).
 
-If you have built the CIFS vfs into the kernel itself, follow the instructions
+If you have built the SMBFS client into the kernel itself, follow the instructions
 for your distribution on how to install a new kernel (usually you
 would simply type ``make install``).
 
@@ -62,14 +62,14 @@ Linux clients is useful in mapping Uids and Gids consistently across the
 domain to the proper network user.  The mount.cifs mount helper can be
 found at cifs-utils.git on git.samba.org
 
-If cifs is built as a module, then the size and number of network buffers
+If smbfs is built as a module, then the size and number of network buffers
 and maximum number of simultaneous requests to one server can be configured.
 Changing these from their defaults is not recommended. By executing modinfo::
 
-	modinfo kernel/fs/cifs/cifs.ko
+	modinfo kernel/fs/smbfs/smbfs.ko
 
-on kernel/fs/cifs/cifs.ko the list of configuration changes that can be made
-at module initialization time (by running insmod cifs.ko) can be seen.
+on kernel/fs/smbfs/smbfs.ko the list of configuration changes that can be made
+at module initialization time (by running insmod smbfs.ko) can be seen.
 
 Recommendations
 ===============
@@ -85,11 +85,11 @@ improved POSIX behavior (NB: can use vers=3.0 to force only SMB3, never 2.1):
 
    ``mfsymlinks`` and either ``cifsacl`` or ``modefromsid`` (usually with ``idsfromsid``)
 
-Allowing User Mounts
+Allowing user mounts
 ====================
 
 To permit users to mount and unmount over directories they own is possible
-with the cifs vfs.  A way to enable such mounting is to mark the mount.cifs
+with SMBFS.  A way to enable such mounting is to mark the mount.cifs
 utility as suid (e.g. ``chmod +s /sbin/mount.cifs``). To enable users to
 umount shares they mount requires
 
@@ -112,19 +112,19 @@ mount.cifs with the following flag: CIFS_ALLOW_USR_SUID
 There is a corresponding manual page for cifs mounting in the Samba 3.0 and
 later source tree in docs/manpages/mount.cifs.8
 
-Allowing User Unmounts
+Allowing user unmounts
 ======================
 
 To permit users to unmount directories that they have user mounted (see above),
 the utility umount.cifs may be used.  It may be invoked directly, or if
 umount.cifs is placed in /sbin, umount can invoke the cifs umount helper
-(at least for most versions of the umount utility) for umount of cifs
+(at least for most versions of the umount utility) for umount of SMBFS
 mounts, unless umount is invoked with -i (which will avoid invoking a umount
 helper). As with mount.cifs, to enable user unmounts umount.cifs must be marked
 as suid (e.g. ``chmod +s /sbin/umount.cifs``) or equivalent (some distributions
 allow adding entries to a file to the /etc/permissions file to achieve the
 equivalent suid effect).  For this utility to succeed the target path
-must be a cifs mount, and the uid of the current user must match the uid
+must be a SMBFS mount, and the uid of the current user must match the uid
 of the user who mounted the resource.
 
 Also note that the customary way of allowing user mounts and unmounts is
@@ -133,7 +133,7 @@ to the file /etc/fstab for each //server/share you wish to mount, but
 this can become unwieldy when potential mount targets include many
 or  unpredictable UNC names.
 
-Samba Considerations
+Samba considerations
 ====================
 
 Most current servers support SMB2.1 and SMB3 which are more secure,
@@ -141,7 +141,7 @@ but there are useful protocol extensions for the older less secure CIFS
 dialect, so to get the maximum benefit if mounting using the older dialect
 (CIFS/SMB1), we recommend using a server that supports the SNIA CIFS
 Unix Extensions standard (e.g. almost any  version of Samba ie version
-2.2.5 or later) but the CIFS vfs works fine with a wide variety of CIFS servers.
+2.2.5 or later) but SMBFS works fine with a wide variety of CIFS servers.
 Note that uid, gid and file permissions will display default values if you do
 not have a server that supports the Unix extensions for CIFS (such as Samba
 2.2.5 or later).  To enable the Unix CIFS Extensions in the Samba server, add
@@ -158,16 +158,16 @@ Linux::
 	ea support = yes
 
 Note that server ea support is required for supporting xattrs from the Linux
-cifs client, and that EA support is present in later versions of Samba (e.g.
+SMBFS client, and that EA support is present in later versions of Samba (e.g.
 3.0.6 and later (also EA support works in all versions of Windows, at least to
 shares on NTFS filesystems).  Extended Attribute (xattr) support is an optional
 feature of most Linux filesystems which may require enabling via
 make menuconfig. Client support for extended attributes (user xattr) can be
 disabled on a per-mount basis by specifying ``nouser_xattr`` on mount.
 
-The CIFS client can get and set POSIX ACLs (getfacl, setfacl) to Samba servers
+The SMBFS client can get and set POSIX ACLs (getfacl, setfacl) to Samba servers
 version 3.10 and later.  Setting POSIX ACLs requires enabling both XATTR and
-then POSIX support in the CIFS configuration options when building the cifs
+then POSIX support in the SMBFS configuration options when building the smbfs
 module.  POSIX ACL support can be disabled on a per mount basic by specifying
 ``noacl`` on mount.
 
@@ -179,10 +179,10 @@ enabled on the server and client, subsequent setattr calls (e.g. chmod) can
 fix the mode.  Note that creating special devices (mknod) remotely
 may require specifying a mkdev function to Samba if you are not using
 Samba 3.0.6 or later.  For more information on these see the manual pages
-(``man smb.conf``) on the Samba server system.  Note that the cifs vfs,
-unlike the smbfs vfs, does not read the smb.conf on the client system
+(``man smb.conf``) on the Samba server system.  Note that the SMBFS module,
+unlike the Samba userspace client, does not read the smb.conf on the client system
 (the few optional settings are passed in on mount via -o parameters instead).
-Note that Samba 2.2.7 or later includes a fix that allows the CIFS VFS to delete
+Note that Samba 2.2.7 or later includes a fix that allows the SMBFS client to delete
 open files (required for strict POSIX compliance).  Windows Servers already
 supported this feature. Samba server does not allow symlinks that refer to files
 outside of the share, so in Samba versions prior to 3.0.6, most symlinks to
@@ -195,33 +195,33 @@ such symlinks safely by converting unsafe symlinks (ie symlinks to server
 files that are outside of the share) to a samba specific format on the server
 that is ignored by local server applications and non-cifs clients and that will
 not be traversed by the Samba server).  This is opaque to the Linux client
-application using the cifs vfs. Absolute symlinks will work to Samba 3.0.5 or
+application using the SMBFS module. Absolute symlinks will work to Samba 3.0.5 or
 later, but only for remote clients using the CIFS Unix extensions, and will
 be invisible to Windows clients and typically will not affect local
 applications running on the same server as Samba.
 
-Use instructions
+Usage instructions
 ================
 
-Once the CIFS VFS support is built into the kernel or installed as a module
-(cifs.ko), you can use mount syntax like the following to access Samba or
+Once SMBFS support is built into the kernel or installed as a module
+(smbfs.ko), you can use mount syntax like the following to access Samba or
 Mac or Windows servers::
 
   mount -t cifs //9.53.216.11/e$ /mnt -o username=myname,password=mypassword
 
 Before -o the option -v may be specified to make the mount.cifs
 mount helper display the mount steps more verbosely.
-After -o the following commonly used cifs vfs specific options
+After -o the following commonly used SMBFS specific options
 are supported::
 
   username=<username>
   password=<password>
   domain=<domain name>
 
-Other cifs mount options are described below.  Use of TCP names (in addition to
+Other smbfs mount options are described below.  Use of TCP names (in addition to
 ip addresses) is available if the mount helper (mount.cifs) is installed. If
 you do not trust the server to which are mounted, or if you do not have
-cifs signing enabled (and the physical network is insecure), consider use
+signing enabled (and the physical network is insecure), consider use
 of the standard mount options ``noexec`` and ``nosuid`` to reduce the risk of
 running an altered binary on your local system (downloaded from a hostile server
 or altered by a hostile router).
@@ -265,19 +265,19 @@ the Server's registry.  Samba starting with version 3.10 will allow such
 filenames (ie those which contain valid Linux characters, which normally
 would be forbidden for Windows/CIFS semantics) as long as the server is
 configured for Unix Extensions (and the client has not disabled
-/proc/fs/cifs/LinuxExtensionsEnabled). In addition the mount option
+/proc/fs/smbfs/LinuxExtensionsEnabled). In addition the mount option
 ``mapposix`` can be used on CIFS (vers=1.0) to force the mapping of
 illegal Windows/NTFS/SMB characters to a remap range (this mount parameter
 is the default for SMB3). This remap (``mapposix``) range is also
 compatible with Mac (and "Services for Mac" on some older Windows).
 
-CIFS VFS Mount Options
+SMBFS mount options
 ======================
 A partial list of the supported mount options follows:
 
   username
 		The user name to use when trying to establish
-		the CIFS session.
+		the SMB session.
   password
 		The user password.  If the mount helper is
 		installed, the user will be prompted for password
@@ -289,7 +289,7 @@ A partial list of the supported mount options follows:
 		mount.
   domain
 		Set the SMB/CIFS workgroup name prepended to the
-		username during CIFS session establishment
+		username during session establishment
   forceuid
 		Set the default uid for inodes to the uid
 		passed in on mount. For mounts to servers
@@ -327,7 +327,7 @@ A partial list of the supported mount options follows:
 		(similar to above but for the group owner, gid, instead of uid)
   uid
 		Set the default uid for inodes, and indicate to the
-		cifs kernel driver which local user mounted. If the server
+		smbfs module which local user mounted. If the server
 		supports the unix extensions the default uid is
 		not used to fill in the owner fields of inodes (files)
 		unless the ``forceuid`` parameter is specified.
@@ -346,7 +346,7 @@ A partial list of the supported mount options follows:
 		caching is not suitable for all workloads for e.g. read-once
 		type workloads. So, you need to consider carefully your
 		workload/scenario before using this option. Currently, local
-		disk caching is functional for CIFS files opened as read-only.
+		disk caching is functional for SMBFS files opened as read-only.
   dir_mode
 		If CIFS Unix extensions are not supported by the server
 		this overrides the default mode for directory inodes.
@@ -366,21 +366,21 @@ A partial list of the supported mount options follows:
 		can not use rsize larger than CIFSMaxBufSize. CIFSMaxBufSize
 		defaults to 16K and may be changed (from 8K to the maximum
 		kmalloc size allowed by your kernel) at module install time
-		for cifs.ko. Setting CIFSMaxBufSize to a very large value
-		will cause cifs to use more memory and may reduce performance
+		for smbfs.ko. Setting CIFSMaxBufSize to a very large value
+		will cause smbfs to use more memory and may reduce performance
 		in some cases.  To use rsize greater than 127K (the original
-		cifs protocol maximum) also requires that the server support
+		protocol maximum) also requires that the server support
 		a new Unix Capability flag (for very large read) which some
 		newer servers (e.g. Samba 3.0.26 or later) do. rsize can be
 		set from a minimum of 2048 to a maximum of 130048 (127K or
 		CIFSMaxBufSize, whichever is smaller)
   wsize
 		default write size (default 57344)
-		maximum wsize currently allowed by CIFS is 57344 (fourteen
+		maximum wsize currently allowed by SMBFS is 57344 (fourteen
 		4096 byte pages)
   actimeo=n
 		attribute cache timeout in seconds (default 1 second).
-		After this timeout, the cifs client requests fresh attribute
+		After this timeout, the smbfs client requests fresh attribute
 		information from the server. This option allows to tune the
 		attribute cache timeout to suit the workload needs. Shorter
 		timeouts mean better the cache coherency, but increased number
@@ -409,8 +409,7 @@ A partial list of the supported mount options follows:
 
 		this might be useful when comma is contained within username
 		or password or domain. This option is less important
-		when the cifs mount helper cifs.mount (version 1.1 or later)
-		is used.
+		when the mount helper cifs.mount (version 1.1 or later) is used.
   nosuid
 		Do not allow remote executables with the suid bit
 		program to be executed.  This is only meaningful for mounts
@@ -431,11 +430,10 @@ A partial list of the supported mount options follows:
 		be executed (default for mounts when executed as root,
 		nosuid is default for user mounts).
   credentials
-		Although ignored by the cifs kernel component, it is used by
-		the mount helper, mount.cifs. When mount.cifs is installed it
-		opens and reads the credential file specified in order
-		to obtain the userid and password arguments which are passed to
-		the cifs vfs.
+		Although ignored by the SMBFS module, it is used by the mount
+                helper mount.cifs. When mount.cifs is installed it opens and
+                reads the credential file specified in order to obtain the
+                userid and password arguments which are passed to the SMBFS module.
   guest
 		Although ignored by the kernel component, the mount.cifs
 		mount helper will not prompt the user for a password
@@ -472,8 +470,8 @@ A partial list of the supported mount options follows:
 		shared higher level directory).  Note that some older
 		(e.g. pre-Windows 2000) do not support returning UniqueIDs
 		or the CIFS Unix Extensions equivalent and for those
-		this mount option will have no effect.  Exporting cifs mounts
-		under nfsd requires this mount option on the cifs mount.
+		this mount option will have no effect.  Exporting SMBFS mounts
+		under nfsd requires this mount option.
 		This is now the default if server supports the
 		required network operation.
   noserverino
@@ -546,7 +544,7 @@ A partial list of the supported mount options follows:
 			*?<>|:
 
 		to the remap range (above 0xF000), which also
-		allows the CIFS client to recognize files created with
+		allows the SMBFS client to recognize files created with
 		such characters by Windows's POSIX emulation. This can
 		also be useful when mounting to most versions of Samba
 		(which also forbids creating and opening files
@@ -588,22 +586,22 @@ A partial list of the supported mount options follows:
 		(presumably rare) applications, originally coded for
 		DOS/Windows, which require Windows style mandatory byte range
 		locking, they may be able to take advantage of this option,
-		forcing the cifs client to only send mandatory locks
-		even if the cifs server would support posix advisory locks.
+		forcing the SMBFS client to only send mandatory locks
+		even if the SMB server would support posix advisory locks.
 		``forcemand`` is accepted as a shorter form of this mount
 		option.
   nostrictsync
 		If this mount option is set, when an application does an
-		fsync call then the cifs client does not send an SMB Flush
+		fsync call then the SMBFS client does not send an SMB Flush
 		to the server (to force the server to write all dirty data
-		for this file immediately to disk), although cifs still sends
+		for this file immediately to disk), although SMBFS still sends
 		all dirty (cached) file data to the server and waits for the
 		server to respond to the write.  Since SMB Flush can be
 		very slow, and some servers may be reliable enough (to risk
 		delaying slightly flushing the data to disk on the server),
 		turning on this option may be useful to improve performance for
 		applications that fsync too much, at a small risk of server
-		crash.  If this mount option is not set, by default cifs will
+		crash.  If this mount option is not set, by default SMBFS will
 		send an SMB flush request (and wait for a response) on every
 		fsync call.
   nodfs
@@ -651,15 +649,15 @@ A partial list of the supported mount options follows:
   locallease
 		This option is rarely needed. Fcntl F_SETLEASE is
 		used by some applications such as Samba and NFSv4 server to
-		check to see whether a file is cacheable.  CIFS has no way
+		check to see whether a file is cacheable.  SMBFS has no way
 		to explicitly request a lease, but can check whether a file
 		is cacheable (oplocked).  Unfortunately, even if a file
-		is not oplocked, it could still be cacheable (ie cifs client
+		is not oplocked, it could still be cacheable (ie SMBFS client
 		could grant fcntl leases if no other local processes are using
 		the file) for cases for example such as when the server does not
 		support oplocks and the user is sure that the only updates to
 		the file will be from this client. Specifying this mount option
-		will allow the cifs client to check for leases (only) locally
+		will allow the SMBFS client to check for leases (only) locally
 		for files which are not oplocked instead of denying leases
 		in that case. (EXPERIMENTAL)
   sec
@@ -675,7 +673,7 @@ A partial list of the supported mount options follows:
 				Use NTLM password hashing (default)
 			ntlmi
 				Use NTLM password hashing with signing (if
-				/proc/fs/cifs/PacketSigningEnabled on or if
+				/proc/fs/smbfs/PacketSigningEnabled on or if
 				server requires signing also can be the default)
 			ntlmv2
 				Use NTLMv2 password hashing
@@ -700,17 +698,17 @@ including:
 	-?      display simple usage information
 =============== ===============================================================
 
-With most 2.6 kernel versions of modutils, the version of the cifs kernel
+With most kernel versions of modutils, the version of the SMBFS kernel
 module can be displayed via modinfo.
 
-Misc /proc/fs/cifs Flags and Debug Info
+Misc /proc/fs/smbfs Flags and debug info
 =======================================
 
 Informational pseudo-files:
 
 ======================= =======================================================
-DebugData		Displays information about active CIFS sessions and
-			shares, features enabled as well as the cifs.ko
+DebugData		Displays information about active SMBFS sessions and
+			shares, features enabled as well as the smbfs.ko
 			version.
 Stats			Lists summary resource usage information as well as per
 			share statistics.
@@ -737,7 +735,7 @@ SecurityFlags		Flags which control security negotiation and
 			options to be enabled.  Enabling plaintext
 			authentication currently requires also enabling
 			lanman authentication in the security flags
-			because the cifs module only supports sending
+			because the smbfs module only supports sending
 			laintext passwords using the older lanman dialect
 			form of the session setup SMB.  (e.g. for authentication
 			using plain text passwords, set the SecurityFlags
@@ -762,20 +760,20 @@ cifsFYI			If set to non-zero value, additional debug information
 			contains three flags controlling different classes of
 			debugging entries.  The maximum value it can be set
 			to is 7 which enables all debugging points (default 0).
-			Some debugging statements are not compiled into the
-			cifs kernel unless CONFIG_CIFS_DEBUG2 is enabled in the
+			Some debugging statements are not compiled into SMBFS
+                        module, unless CONFIG_SMBFS_DEBUG2 is enabled in the
 			kernel configuration. cifsFYI may be set to one or
 			nore of the following flags (7 sets them all)::
 
 			  +-----------------------------------------------+------+
-			  | log cifs informational messages		  | 0x01 |
+			  | log smbfs informational messages		  | 0x01 |
 			  +-----------------------------------------------+------+
-			  | log return codes from cifs entry points	  | 0x02 |
+			  | log return codes from smbfs entry points	  | 0x02 |
 			  +-----------------------------------------------+------+
 			  | log slow responses				  | 0x04 |
 			  | (ie which take longer than 1 second)	  |      |
 			  |                                               |      |
-			  | CONFIG_CIFS_STATS2 must be enabled in .config |      |
+			  | CONFIG_SMBFS_STATS2 must be enabled in .config|      |
 			  +-----------------------------------------------+------+
 
 traceSMB		If set to one, debug information is logged to the
@@ -785,8 +783,8 @@ LookupCacheEnable	If set to one, inode information is kept cached
 			for one second improving performance of lookups
 			(default 1)
 LinuxExtensionsEnabled	If set to one then the client will attempt to
-			use the CIFS "UNIX" extensions which are optional
-			protocol enhancements that allow CIFS servers
+			use the CIFS Unix extensions which are optional
+			protocol enhancements that allow SMB servers
 			to return accurate UID/GID information as well
 			as support symbolic links. If you use servers
 			such as Samba that support the CIFS Unix
@@ -799,34 +797,34 @@ dfscache		List the content of the DFS cache.
 ======================= =======================================================
 
 These experimental features and tracing can be enabled by changing flags in
-/proc/fs/cifs (after the cifs module has been installed or built into the
-kernel, e.g.  insmod cifs).  To enable a feature set it to 1 e.g.  to enable
-tracing to the kernel message log type::
+/proc/fs/smbfs (after the smbfs module has been installed or built into the
+kernel).  To enable a feature set it to 1 e.g.  To enable tracing to the
+kernel message log type::
 
-	echo 7 > /proc/fs/cifs/cifsFYI
+	echo 7 > /proc/fs/smbfs/cifsFYI
 
 cifsFYI functions as a bit mask. Setting it to 1 enables additional kernel
 logging of various informational messages.  2 enables logging of non-zero
 SMB return codes while 4 enables logging of requests that take longer
 than one second to complete (except for byte range lock requests).
-Setting it to 4 requires CONFIG_CIFS_STATS2 to be set in kernel configuration
+Setting it to 4 requires CONFIG_SMBFS_STATS2 to be set in kernel configuration
 (.config). Setting it to seven enables all three.  Finally, tracing
 the start of smb requests and responses can be enabled via::
 
-	echo 1 > /proc/fs/cifs/traceSMB
+	echo 1 > /proc/fs/smbfs/traceSMB
 
-Per share (per client mount) statistics are available in /proc/fs/cifs/Stats.
-Additional information is available if CONFIG_CIFS_STATS2 is enabled in the
+Per share (per client mount) statistics are available in /proc/fs/smbfs/Stats.
+Additional information is available if CONFIG_SMBFS_STATS2 is enabled in the
 kernel configuration (.config).  The statistics returned include counters which
 represent the number of attempted and failed (ie non-zero return code from the
 server) SMB3 (or cifs) requests grouped by request type (read, write, close etc.).
 Also recorded is the total bytes read and bytes written to the server for
 that share.  Note that due to client caching effects this can be less than the
 number of bytes read and written by the application running on the client.
-Statistics can be reset to zero by ``echo 0 > /proc/fs/cifs/Stats`` which may be
+Statistics can be reset to zero by ``echo 0 > /proc/fs/smbfs/Stats`` which may be
 useful if comparing performance of two different scenarios.
 
-Also note that ``cat /proc/fs/cifs/DebugData`` will display information about
+Also note that ``cat /proc/fs/smbfs/DebugData`` will display information about
 the active sessions and the shares that are mounted.
 
 Enabling Kerberos (extended security) works but requires version 1.2 or later
@@ -846,23 +844,23 @@ be configured in the file /etc/request-key.conf.  Samba, Windows servers and
 many NAS appliances support DFS as a way of constructing a global name
 space to ease network configuration and improve reliability.
 
-To use cifs Kerberos and DFS support, the Linux keyutils package should be
+To use SMBFS Kerberos and DFS support, the Linux keyutils package should be
 installed and something like the following lines should be added to the
 /etc/request-key.conf file::
 
   create cifs.spnego * * /usr/local/sbin/cifs.upcall %k
   create dns_resolver * * /usr/local/sbin/cifs.upcall %k
 
-CIFS kernel module parameters
+SMBFS kernel module parameters
 =============================
 These module parameters can be specified or modified either during the time of
 module loading or during the runtime by using the interface::
 
-	/proc/module/cifs/parameters/<param>
+	/proc/module/smbfs/parameters/<param>
 
 i.e.::
 
-    echo "value" > /sys/module/cifs/parameters/<param>
+    echo "value" > /sys/module/smbfs/parameters/<param>
 
 ================= ==========================================================
 1. enable_oplocks Enable or disable oplocks. Oplocks are enabled by default.
diff --git a/Documentation/admin-guide/cifs/winucase_convert.pl b/Documentation/admin-guide/smbfs/winucase_convert.pl
similarity index 100%
rename from Documentation/admin-guide/cifs/winucase_convert.pl
rename to Documentation/admin-guide/smbfs/winucase_convert.pl
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index bee63d42e5ec..751d8b17d289 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -72,7 +72,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
-   cifs/index
+   smbfs/index
    ceph
    coda
    configfs
diff --git a/Documentation/filesystems/cifs/cifsroot.rst b/Documentation/filesystems/smbfs/cifsroot.rst
similarity index 85%
rename from Documentation/filesystems/cifs/cifsroot.rst
rename to Documentation/filesystems/smbfs/cifsroot.rst
index 4930bb443134..caa9b78cccf8 100644
--- a/Documentation/filesystems/cifs/cifsroot.rst
+++ b/Documentation/filesystems/smbfs/cifsroot.rst
@@ -1,15 +1,15 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ===========================================
-Mounting root file system via SMB (cifs.ko)
+Mounting root file system via SMB (smbfs.ko)
 ===========================================
 
 Written 2019 by Paulo Alcantara <palcantara@suse.de>
 
 Written 2019 by Aurelien Aptel <aaptel@suse.com>
 
-The CONFIG_CIFS_ROOT option enables experimental root file system
-support over the SMB protocol via cifs.ko.
+The CONFIG_SMBFS_ROOT option enables experimental root file system
+support over the SMB protocol via smbfs.ko.
 
 It introduces a new kernel command-line option called 'cifsroot='
 which will tell the kernel to mount the root file system over the
@@ -19,7 +19,7 @@ In order to mount, the network stack will also need to be set up by
 using 'ip=' config option. For more details, see
 Documentation/admin-guide/nfs/nfsroot.rst.
 
-A CIFS root mount currently requires the use of SMB1+UNIX Extensions
+A SMBFS root mount currently requires the use of SMB1+UNIX Extensions
 which is only supported by the Samba server. SMB1 is the older
 deprecated version of the protocol but it has been extended to support
 POSIX features (See [1]). The equivalent extensions for the newer
@@ -27,7 +27,7 @@ recommended version of the protocol (SMB3) have not been fully
 implemented yet which means SMB3 doesn't support some required POSIX
 file system objects (e.g. block devices, pipes, sockets).
 
-As a result, a CIFS root will default to SMB1 for now but the version
+As a result, a SMBFS root will default to SMB1 for now but the version
 to use can nonetheless be changed via the 'vers=' mount option.  This
 default will change once the SMB3 POSIX extensions are fully
 implemented.
@@ -59,7 +59,7 @@ the root file system via SMB protocol.
 Enables the kernel to mount the root file system via SMB that are
 located in the <server-ip> and <share> specified in this option.
 
-The default mount options are set in fs/cifs/cifsroot.c.
+The default mount options are set in fs/smbfs/cifsroot.c.
 
 server-ip
 	IPv4 address of the server.
@@ -94,7 +94,7 @@ Restart smb service::
 
     # systemctl restart smb
 
-Test it under QEMU on a kernel built with CONFIG_CIFS_ROOT and
+Test it under QEMU on a kernel built with CONFIG_SMBFS_ROOT and
 CONFIG_IP_PNP options enabled::
 
     # qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
diff --git a/Documentation/filesystems/cifs/index.rst b/Documentation/filesystems/smbfs/index.rst
similarity index 100%
rename from Documentation/filesystems/cifs/index.rst
rename to Documentation/filesystems/smbfs/index.rst
diff --git a/Documentation/filesystems/cifs/ksmbd.rst b/Documentation/filesystems/smbfs/ksmbd.rst
similarity index 99%
rename from Documentation/filesystems/cifs/ksmbd.rst
rename to Documentation/filesystems/smbfs/ksmbd.rst
index 1af600db2e70..061471a3a4b2 100644
--- a/Documentation/filesystems/cifs/ksmbd.rst
+++ b/Documentation/filesystems/smbfs/ksmbd.rst
@@ -137,7 +137,7 @@ How to run
 5. Start ksmbd user space daemon
 	# ksmbd.mountd
 
-6. Access share from Windows or Linux using CIFS
+6. Access share from Windows or Linux using SMBFS
 
 Shutdown KSMBD
 ==============
diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index add4d59a99a5..9e51a74246e7 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -31,7 +31,7 @@ It does not yet support the following AFS features:
 
  (*) Dns query support for AFSDB resource record.
 
-This code is extracted from the CIFS filesystem.
+This code is extracted from the SMBFS filesystem.
 
 
 Compilation
diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index be535ffaf4b0..9f45069efaf1 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -85,7 +85,7 @@ Todolist:
 *   btmrvl
 *   cgroup-v1/index
 *   cgroup-v2
-*   cifs/index
+*   smbfs/index
 *   dell_rbu
 *   device-mapper/index
 *   edid
diff --git a/Documentation/translations/zh_TW/admin-guide/index.rst b/Documentation/translations/zh_TW/admin-guide/index.rst
index 293c20245783..f0c90426ba12 100644
--- a/Documentation/translations/zh_TW/admin-guide/index.rst
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -82,7 +82,7 @@ Todolist:
    btmrvl
    cgroup-v1/index
    cgroup-v2
-   cifs/index
+   smbfs/index
    cputopology
    dell_rbu
    device-mapper/index
-- 
2.35.3

