Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FB38D2D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 03:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEVB4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 21:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEVB4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 21:56:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC22C061574;
        Fri, 21 May 2021 18:55:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q3so2187595lfu.2;
        Fri, 21 May 2021 18:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdurcGEOucf//6v8WZDrND5Btr+OoE20Dx7RAg26R/Q=;
        b=SDHksy9GYC+zzvtIW5ltzNIsf4t75rwEu2l0K0gCunQYPje61KNysdIfszZiP7qw3z
         YJPZaFRBOkSMZI8gAXACv3hmr53Z5Jw3eIaw4jBH6hgGb4g7+3uBBXJ7zKQTaALOjPhd
         zq0lqhrPz1Yg1SLjKycoa+KMr5bfSbEUMhG2qM+lkfiTIP6ookj6aIokyXmsPXcnqIpX
         bnBgPqHrR/vo1xDuqBn8akBZa1X9IyrsyQJ6uxjby4PTONlS7ABlCTRYA7OH3j1pXOce
         N3YKSYaLCil2Vc7G/80PCtodF16xh0FxYjQDauYIKJHS0LmBK2a4+NjLptHDZxMH3ppi
         UujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdurcGEOucf//6v8WZDrND5Btr+OoE20Dx7RAg26R/Q=;
        b=BHUN8ARuCPgphVSspX7FaSTrzn5nfeRQ878xypp04591UMuDQ96JQtC2j4hYfesv4C
         XirA/8qYJWRBcdTsqe9o53QfXUDG2WCkh9fKDsyQolbriAyAYhxmEXLp1ZJoBmgHDEWv
         N2u4tNpkjyZh/F/m+/UAwRsIbsoP+pCLzmY9NA8M1fSbUeOIN1OoON4FatE7Q3uIonM3
         IALYQ1MRFY1Fii3HBbK3pj3iR8coFntw3xH4H7vBVtnj8DHH6XM5/22TK8Np/tZT5tUl
         1b4/prDCBcVow5FmlDBpUfLi5kPSHJ6KrHpn0lCKuJm4Ut2jVZk3FpgKaHTVRaxqPlU2
         iIog==
X-Gm-Message-State: AOAM532+rLoB0cnXAv61oC1NTGSgDm8lBJJS65s+vQ1/zb9u7MgzwsZF
        KtGRY/pDnoxkXuy01Slr2FWmEI0qW5zMCfKFtz0=
X-Google-Smtp-Source: ABdhPJySYAvwoLmYSB2uIId2T5uWrb7ixHFAWgKWgorxAyqPGV6GOVIOIxK5QDKFx5oetmaKz6Ya79BYT6oJwPx3MCw=
X-Received: by 2002:a19:c397:: with SMTP id t145mr4026943lff.307.1621648515404;
 Fri, 21 May 2021 18:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210521063549epcas1p204e171a2ba5a06d1b50e490f5e742b25@epcas1p2.samsung.com>
 <20210521062637.31347-1-namjae.jeon@samsung.com>
In-Reply-To: <20210521062637.31347-1-namjae.jeon@samsung.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 21 May 2021 20:55:04 -0500
Message-ID: <CAH2r5mu9Zct-h_+R2AT9BqjAH0NYzhboUmamHW8s9TgC_6YTFA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] cifsd: introduce new SMB3 kernel server
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        COMMON INTERNET FILE SYSTEM SERVER 
        <linux-cifsd-devel@lists.sourceforge.net>,
        senozhatsky@chromium.org, Hyeoncheol Lee <hyc.lee@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aurelien.aptel@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I just reran the regression test suite from Linux client again against
current ksmbd.  It passed all.

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/38

On Fri, May 21, 2021 at 1:35 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> This is the patch series for cifsd(ksmbd) kernel server.
>
> What is cifsd(ksmbd) ?
> ======================
>
> The SMB family of protocols is the most widely deployed
> network filesystem protocol, the default on Windows and Macs (and even
> on many phones and tablets), with clients and servers on all major
> operating systems, but lacked a kernel server for Linux. For many
> cases the current userspace server choices were suboptimal
> either due to memory footprint, performance or difficulty integrating
> well with advanced Linux features.
>
> ksmbd is a new kernel module which implements the server-side of the SMB3 protocol.
> The target is to provide optimized performance, GPLv2 SMB server, better
> lease handling (distributed caching). The bigger goal is to add new
> features more rapidly (e.g. RDMA aka "smbdirect", and recent encryption
> and signing improvements to the protocol) which are easier to develop
> on a smaller, more tightly optimized kernel server than for example
> in Samba.  The Samba project is much broader in scope (tools, security services,
> LDAP, Active Directory Domain Controller, and a cross platform file server
> for a wider variety of purposes) but the user space file server portion
> of Samba has proved hard to optimize for some Linux workloads, including
> for smaller devices. This is not meant to replace Samba, but rather be
> an extension to allow better optimizing for Linux, and will continue to
> integrate well with Samba user space tools and libraries where appropriate.
> Working with the Samba team we have already made sure that the configuration
> files and xattrs are in a compatible format between the kernel and
> user space server.
>
>
> Architecture
> ============
>
>                |--- ...
>        --------|--- ksmbd/3 - Client 3
>        |-------|--- ksmbd/2 - Client 2
>        |       |         ____________________________________________________
>        |       |        |- Client 1                                          |
> <--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos      |
>        |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3, SMB3.0.2, |
>        |       |      | |                SMB3.1.1                            |
>        |       |      | |____________________________________________________|
>        |       |      |
>        |       |      |--- VFS --- Local Filesystem
>        |       |
> KERNEL |--- ksmbd/0(forker kthread)
> ---------------||---------------------------------------------------------------
> USER           ||
>                || communication using NETLINK
>                ||  ______________________________________________
>                || |                                              |
>         ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, samr, lsarpc)   |
>                ^  |  <<= configure shares setting, user accounts |
>                |  |______________________________________________|
>                |
>                |------ smb.conf(config file)
>                |
>                |------ ksmbdpwd.db(user account/password file)
>                             ^
>   ksmbd.adduser ------------|
>
> The subset of performance related operations(open/read/write/close etc.) belong
> in kernelspace(ksmbd) and the other subset which belong to operations(DCE/RPC,
> user account/share database) which are not really related with performance are
> handled in userspace(ksmbd.mountd).
>
> When the ksmbd.mountd is started, It starts up a forker thread at initialization
> time and opens a dedicated port 445 for listening to SMB requests. Whenever new
> clients make request, Forker thread will accept the client connection and fork
> a new thread for dedicated communication channel between the client and
> the server.
>
>
> ksmbd feature status
> ====================
>
> ============================== =================================================
> Feature name                   Status
> ============================== =================================================
> Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
>                                (intentionally excludes security vulnerable SMB1 dialect).
> Auto Negotiation               Supported.
> Compound Request               Supported.
> Oplock Cache Mechanism         Supported.
> SMB2 leases(v1 lease)          Supported.
> Directory leases(v2 lease)     Planned for future.
> Multi-credits                  Supported.
> NTLM/NTLMv2                    Supported.
> HMAC-SHA256 Signing            Supported.
> Secure negotiate               Supported.
> Signing Update                 Supported.
> Pre-authentication integrity   Supported.
> SMB3 encryption(CCM, GCM)      Supported. (CCM and GCM128 supported, GCM256 in progress)
> SMB direct(RDMA)               Partially Supported. SMB3 Multi-channel is required
>                                to connect to Windows client.
> SMB3 Multi-channel             In Progress.
> SMB3.1.1 POSIX extension       Supported.
> ACLs                           Partially Supported. only DACLs available, SACLs
>                                (auditing) is planned for the future. For
>                                ownership (SIDs) ksmbd generates random subauth
>                                values(then store it to disk) and use uid/gid
>                                get from inode as RID for local domain SID.
>                                The current acl implementation is limited to
>                                standalone server, not a domain member.
>                                Integration with Samba tools is being worked on to
>                                allow future support for running as a domain member.
> Kerberos                       Supported.
> Durable handle v1,v2           Planned for future.
> Persistent handle              Planned for future.
> SMB2 notify                    Planned for future.
> Sparse file support            Supported.
> DCE/RPC support                Partially Supported. a few calls(NetShareEnumAll,
>                                NetServerGetInfo, SAMR, LSARPC) that are needed
>                                for file server handled via netlink interface from
>                                ksmbd.mountd. Additional integration with Samba
>                                tools and libraries via upcall is being investigated
>                                to allow support for additional DCE/RPC management
>                                calls (and future support for Witness protocol e.g.)
> ksmbd/nfsd interoperability    Planned for future. The features that ksmbd
>                                support are Leases, Notify, ACLs and Share modes.
> ============================== =================================================
>
> All features required as file server are currently implemented in ksmbd.
> In particular, the implementation of SMB Direct(RDMA) is only currently
> possible with ksmbd (among Linux servers)
>
>
> Stability
> =========
>
> It has been proved to be stable. A significant amount of xfstests pass and
> are run regularly from Linux to Linux:
>
>   http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/36
>
> In addition regression tests using the broadest SMB3 functional test suite
> (Samba's "smbtorture") are run on every checkin.
> It has already been used by many other open source toolkits and commercial companies
> that need NAS functionality. Their issues have been fixed and contributions are
> applied into ksmbd. Ksmbd has been well tested and verified in the field and market.
>
>
> Mailing list and repositories
> =============================
>  - linux-cifsd-devel@lists.sourceforge.net
>  - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
>  - https://github.com/cifsd-team/cifsd (out-of-tree)
>  - https://github.com/cifsd-team/ksmbd-tools
>
>
> How to run ksmbd
> ================
>
>    a. Download ksmbd-tools and compile them.
>         - https://github.com/cifsd-team/ksmbd-tools
>
>    b. Create user/password for SMB share.
>
>         # mkdir /etc/ksmbd/
>         # ksmbd.adduser -a <Enter USERNAME for SMB share access>
>
>    c. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
>         - Refer smb.conf.example and Documentation/configuration.txt
>           in ksmbd-tools
>
>    d. Insert ksmbd.ko module
>
>         # insmod ksmbd.ko
>
>    e. Start ksmbd user space daemon
>         # ksmbd.mountd
>
>    f. Access share from Windows or Linux using SMB
>        e.g. "mount -t cifs //server/share /mnt ..."
>
>
> v3:
>  - fix boolreturn.cocci warnings. (kernel test robot)
>  - fix xfstests generic/504 test failure.
>  - do not use 0 or 0xFFFFFFFF for TreeID. (Marios Makassikis)
>  - add support for FSCTL_DUPLICATE_EXTENTS_TO_FILE.
>  - fix build error without CONFIG_OID_REGISTRY. (Wei Yongjun)
>  - fix invalid memory access in smb2_write(). (Coverity Scan)
>  - add support for AES256 encryption.
>  - fix potential null-ptr-deref in destroy_previous_session(). (Marios Makassikis).
>  - update out_buf_len in smb2_populate_readdir_entry(). (Marios Makassikis)
>  - handle ksmbd_session_rpc_open() failure in create_smb2_pipe(). (Marios Makassikis)
>  - call smb2_set_err_rsp() in smb2_read/smb2_write error path. (Marios Makassikis)
>  - add ksmbd/nfsd interoperability to feature table. (Amir Goldstein)
>  - fix regression in smb2_get_info. (Sebastian Gottschall)
>  - remove is_attributes_write_allowed() wrapper. (Marios Makassikis)
>  - update access check in set_file_allocation_info/set_end_of_file_info. (Marios Makassikis)
>
> v2:
>  - fix an error code in smb2_read(). (Dan Carpenter)
>  - fix error handling in ksmbd_server_init() (Dan Carpenter)
>  - remove redundant assignment to variable err. (Colin Ian King)
>  - remove unneeded macros.
>  - fix wrong use of rw semaphore in __session_create().
>  - use kmalloc() for small allocations.
>  - add the check to work file lock and rename behaviors like Windows
>    unless POSIX extensions are negotiated.
>  - clean-up codes using chechpatch.pl --strict.
>  - merge time_wrappers.h into smb_common.h.
>  - fix wrong prototype in comment (kernel test robot).
>  - fix implicit declaration of function 'groups_alloc' (kernel test robot).
>  - fix implicit declaration of function 'locks_alloc_lock' (kernel test robot).
>  - remove smack inherit leftovers.
>  - remove calling d_path in error paths.
>  - handle unhashed dentry in ksmbd_vfs_mkdir.
>  - use file_inode() instead of d_inode().
>  - remove useless error handling in ksmbd_vfs_read.
>  - use xarray instead of linked list for tree connect list.
>  - remove stale prototype and variables.
>  - fix memory leak when loop ends (coverity-bot, Muhammad Usama Anjum).
>  - use kfree to free memory allocated by kmalloc or kzalloc (Muhammad Usama Anjum).
>  - fix memdup.cocci warnings (kernel test robot)
>  - remove wrappers of kvmalloc/kvfree.
>  - change the reference to configuration.txt (Mauro Carvalho Chehab).
>  - prevent a integer overflow in wm_alloc().
>  - select SG_POOL for SMB_SERVER_SMBDIRECT. (Zhang Xiaoxu).
>  - remove unused including <linux/version.h> (Tian Tao).
>  - declare ida statically.
>  - add the check if parent is stable by unexpected rename.
>  - get parent dentry from child in ksmbd_vfs_remove_file().
>  - re-implement ksmbd_vfs_kern_path.
>  - fix reference count decrement of unclaimed file in __ksmbd_lookup_fd.
>  - remove smb2_put_name(). (Marios Makassikis).
>  - remove unused smberr.h, nterr.c and netmisc.c.
>  - fix potential null-ptr-deref in smb2_open() (Marios Makassikis).
>  - use d_inode().
>  - remove the dead code of unimplemented durable handle.
>  - use the generic one in lib/asn1_decoder.c
>
> v1:
>  - fix a handful of spelling mistakes (Colin Ian King)
>  - fix a precedence bug in parse_dacl() (Dan Carpenter)
>  - fix a IS_ERR() vs NULL bug (Dan Carpenter)
>  - fix a use after free on error path  (Dan Carpenter)
>  - update cifsd.rst Documentation
>  - remove unneeded FIXME comments
>  - fix static checker warnings (Dan Carpenter)
>  - fix WARNING: unmet direct dependencies detected for CRYPTO_ARC4 (Randy Dunlap)
>  - uniquify extract_sharename() (Stephen Rothwell)
>  - fix WARNING: document isn't included in any toctree (Stephen Rothwell)
>  - fix WARNING: Title overline too short (Stephen Rothwell)
>  - fix warning: variable 'total_ace_size' and 'posix_ccontext'set but not used (kernel test rotbot)
>  - fix incorrect function comments (kernel test robot)
>
> Namjae Jeon (10):
>   cifsd: add document
>   cifsd: add server handler
>   cifsd: add trasport layers
>   cifsd: add authentication
>   cifsd: add smb3 engine part 1
>   cifsd: add smb3 engine part 2
>   cifsd: add oplock/lease cache mechanism
>   cifsd: add file operations
>   cifsd: add Kconfig and Makefile
>   MAINTAINERS: add cifsd kernel server
>
>  Documentation/filesystems/cifs/cifsd.rst |  164 +
>  Documentation/filesystems/cifs/index.rst |   10 +
>  Documentation/filesystems/index.rst      |    2 +-
>  MAINTAINERS                              |   12 +-
>  fs/Kconfig                               |    1 +
>  fs/Makefile                              |    1 +
>  fs/cifsd/Kconfig                         |   68 +
>  fs/cifsd/Makefile                        |   17 +
>  fs/cifsd/asn1.c                          |  352 +
>  fs/cifsd/asn1.h                          |   29 +
>  fs/cifsd/auth.c                          | 1344 ++++
>  fs/cifsd/auth.h                          |   90 +
>  fs/cifsd/buffer_pool.c                   |  264 +
>  fs/cifsd/buffer_pool.h                   |   20 +
>  fs/cifsd/connection.c                    |  411 ++
>  fs/cifsd/connection.h                    |  208 +
>  fs/cifsd/crypto_ctx.c                    |  286 +
>  fs/cifsd/crypto_ctx.h                    |   77 +
>  fs/cifsd/glob.h                          |   64 +
>  fs/cifsd/ksmbd_server.h                  |  283 +
>  fs/cifsd/ksmbd_work.c                    |   93 +
>  fs/cifsd/ksmbd_work.h                    |  110 +
>  fs/cifsd/mgmt/ksmbd_ida.c                |   46 +
>  fs/cifsd/mgmt/ksmbd_ida.h                |   34 +
>  fs/cifsd/mgmt/share_config.c             |  239 +
>  fs/cifsd/mgmt/share_config.h             |   81 +
>  fs/cifsd/mgmt/tree_connect.c             |  122 +
>  fs/cifsd/mgmt/tree_connect.h             |   56 +
>  fs/cifsd/mgmt/user_config.c              |   70 +
>  fs/cifsd/mgmt/user_config.h              |   66 +
>  fs/cifsd/mgmt/user_session.c             |  328 +
>  fs/cifsd/mgmt/user_session.h             |  103 +
>  fs/cifsd/misc.c                          |  340 +
>  fs/cifsd/misc.h                          |   44 +
>  fs/cifsd/ndr.c                           |  347 +
>  fs/cifsd/ndr.h                           |   21 +
>  fs/cifsd/nterr.h                         |  545 ++
>  fs/cifsd/ntlmssp.h                       |  169 +
>  fs/cifsd/oplock.c                        | 1667 +++++
>  fs/cifsd/oplock.h                        |  133 +
>  fs/cifsd/server.c                        |  631 ++
>  fs/cifsd/server.h                        |   60 +
>  fs/cifsd/smb2misc.c                      |  435 ++
>  fs/cifsd/smb2ops.c                       |  300 +
>  fs/cifsd/smb2pdu.c                       | 8151 ++++++++++++++++++++++
>  fs/cifsd/smb2pdu.h                       | 1664 +++++
>  fs/cifsd/smb_common.c                    |  652 ++
>  fs/cifsd/smb_common.h                    |  544 ++
>  fs/cifsd/smbacl.c                        | 1317 ++++
>  fs/cifsd/smbacl.h                        |  201 +
>  fs/cifsd/smbfsctl.h                      |   91 +
>  fs/cifsd/smbstatus.h                     | 1822 +++++
>  fs/cifsd/spnego_negtokeninit.asn1        |   43 +
>  fs/cifsd/spnego_negtokentarg.asn1        |   19 +
>  fs/cifsd/transport_ipc.c                 |  881 +++
>  fs/cifsd/transport_ipc.h                 |   54 +
>  fs/cifsd/transport_rdma.c                | 2034 ++++++
>  fs/cifsd/transport_rdma.h                |   61 +
>  fs/cifsd/transport_tcp.c                 |  618 ++
>  fs/cifsd/transport_tcp.h                 |   13 +
>  fs/cifsd/unicode.c                       |  383 +
>  fs/cifsd/unicode.h                       |  356 +
>  fs/cifsd/uniupr.h                        |  268 +
>  fs/cifsd/vfs.c                           | 1995 ++++++
>  fs/cifsd/vfs.h                           |  274 +
>  fs/cifsd/vfs_cache.c                     |  683 ++
>  fs/cifsd/vfs_cache.h                     |  185 +
>  67 files changed, 32050 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/filesystems/cifs/cifsd.rst
>  create mode 100644 Documentation/filesystems/cifs/index.rst
>  create mode 100644 fs/cifsd/Kconfig
>  create mode 100644 fs/cifsd/Makefile
>  create mode 100644 fs/cifsd/asn1.c
>  create mode 100644 fs/cifsd/asn1.h
>  create mode 100644 fs/cifsd/auth.c
>  create mode 100644 fs/cifsd/auth.h
>  create mode 100644 fs/cifsd/buffer_pool.c
>  create mode 100644 fs/cifsd/buffer_pool.h
>  create mode 100644 fs/cifsd/connection.c
>  create mode 100644 fs/cifsd/connection.h
>  create mode 100644 fs/cifsd/crypto_ctx.c
>  create mode 100644 fs/cifsd/crypto_ctx.h
>  create mode 100644 fs/cifsd/glob.h
>  create mode 100644 fs/cifsd/ksmbd_server.h
>  create mode 100644 fs/cifsd/ksmbd_work.c
>  create mode 100644 fs/cifsd/ksmbd_work.h
>  create mode 100644 fs/cifsd/mgmt/ksmbd_ida.c
>  create mode 100644 fs/cifsd/mgmt/ksmbd_ida.h
>  create mode 100644 fs/cifsd/mgmt/share_config.c
>  create mode 100644 fs/cifsd/mgmt/share_config.h
>  create mode 100644 fs/cifsd/mgmt/tree_connect.c
>  create mode 100644 fs/cifsd/mgmt/tree_connect.h
>  create mode 100644 fs/cifsd/mgmt/user_config.c
>  create mode 100644 fs/cifsd/mgmt/user_config.h
>  create mode 100644 fs/cifsd/mgmt/user_session.c
>  create mode 100644 fs/cifsd/mgmt/user_session.h
>  create mode 100644 fs/cifsd/misc.c
>  create mode 100644 fs/cifsd/misc.h
>  create mode 100644 fs/cifsd/ndr.c
>  create mode 100644 fs/cifsd/ndr.h
>  create mode 100644 fs/cifsd/nterr.h
>  create mode 100644 fs/cifsd/ntlmssp.h
>  create mode 100644 fs/cifsd/oplock.c
>  create mode 100644 fs/cifsd/oplock.h
>  create mode 100644 fs/cifsd/server.c
>  create mode 100644 fs/cifsd/server.h
>  create mode 100644 fs/cifsd/smb2misc.c
>  create mode 100644 fs/cifsd/smb2ops.c
>  create mode 100644 fs/cifsd/smb2pdu.c
>  create mode 100644 fs/cifsd/smb2pdu.h
>  create mode 100644 fs/cifsd/smb_common.c
>  create mode 100644 fs/cifsd/smb_common.h
>  create mode 100644 fs/cifsd/smbacl.c
>  create mode 100644 fs/cifsd/smbacl.h
>  create mode 100644 fs/cifsd/smbfsctl.h
>  create mode 100644 fs/cifsd/smbstatus.h
>  create mode 100644 fs/cifsd/spnego_negtokeninit.asn1
>  create mode 100644 fs/cifsd/spnego_negtokentarg.asn1
>  create mode 100644 fs/cifsd/transport_ipc.c
>  create mode 100644 fs/cifsd/transport_ipc.h
>  create mode 100644 fs/cifsd/transport_rdma.c
>  create mode 100644 fs/cifsd/transport_rdma.h
>  create mode 100644 fs/cifsd/transport_tcp.c
>  create mode 100644 fs/cifsd/transport_tcp.h
>  create mode 100644 fs/cifsd/unicode.c
>  create mode 100644 fs/cifsd/unicode.h
>  create mode 100644 fs/cifsd/uniupr.h
>  create mode 100644 fs/cifsd/vfs.c
>  create mode 100644 fs/cifsd/vfs.h
>  create mode 100644 fs/cifsd/vfs_cache.c
>  create mode 100644 fs/cifsd/vfs_cache.h
>
> --
> 2.17.1
>


-- 
Thanks,

Steve
