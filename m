Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C8453E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 03:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhKQCV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:21:58 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:36777
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232596AbhKQCV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637115538; bh=LBCU/Wrng7m0g5Np3uQ3TMPlgTx2v6ooyRRAvU2g4mc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=n9y7wt1UEynNBEwN2WJI7Ttbj5hN2gObT54jgM3m8xDYMXGF+aKhuN14mtyjju5F6Oa8Vw3qpOj4rOdMBe4C4qBYC+1cSE1W2C3iNZNifO0Mog+cB8WfCgWjQBmnytYJAieldNvJ8MDp6TAUdOTDHhGEQ83yIWpkjIUH9tl8RRURkMk2afCOTvPmUY+ENPFptIAlyxrEG6PQ/KTI4ibpSF3h0hnuizZs8/N4rYEpmVGjTT4u4pbcoAqwnqGlAIiueFD0aRY218RlW/vj/QoP+eDJaOf3aiGY+DCxqUUcYOiDM098jq/JR8lCWzuGgeU9nsJt6EoiuKbZRYkBG8kTlg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637115538; bh=+osq1U5N8+WLLdjfpq9IvXR7KdNo/B62D19ppqU6H9s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AT7EAA0r2oZJh3KKRYQkWCCuy62lk+llrJh8Of1RtbvX1ceftkrRD6LQnLbfQPuKoXSl2vX0HU3sGYaR4ZiblfWAyRXtTOoVL3qAaQQ9fFLXTK0ylHzkTRJNKxcQP0SkRUd8nuwz5JvMF4YxT9LDTbnMhPS8gyeWhAOiSr4H8FkikkKV1TDSrBpd2Vhf/4EV8170WxMNYrZUM8Cjtl4JBACNNZOnKDK1FxWG/8BQSMkMXCGlUySg7qpQ5wqEfWkp/ZRqNIKON8XWhw1o/GzIHtVf2YI1aZG01gCPRrOQ1ueEnoobFsw1IWLa4iP7VQqSV1qCgO+rMtMS12MqhMqIAQ==
X-YMail-OSG: 514IMmgVM1nq1_johHH4f9TN5a_uzkZa1TNcnjjLOrh.ZVfXIFVjzBDtEOt1.F1
 4VA5GGFALP_DASzF.LR9TmXVWGLk7GpwPsj0ZzTx9mbZN9OYkl4Nsy_78Px4rpvgbyVItuNPWT4r
 FcXIEJ3h8PhhlylrETonxJ8gaWLMRLr.laydI_kfSMAvPFz0HOo591svBb1VuZqA.75h6BT7v1TD
 CYEK61WH10HtebVexKqhagWPbuPjiRf5goAMYqi5H5qv6iljGQQw_KcltPV0ILMMRvV2ZZU.qaiJ
 gtyelnnSipByLlJcBQdGHvrzjBve5X1c5x7zKwqMPhIRrCvTE1UrCNhgOXuCtkXOu3qO.IOMOn7m
 M9koWeSnyEZBoxN.6aTjh087jRc8v52CLbkH8c.5yiwx3muW31Lr7pDiiFD9qM4TIb.Lze4CVR5b
 yiA3wVkKYqJnLDelmUjpiQNTg.4nYQB9e2Vyuwtly0wxdHI09XHIbxf5KaIqVzLyFj2WV9lCDKif
 1alcfcb41EdOJA5ysBuhVvVptpHnXemSPi4JSz7.Gz0ySG.c9ZnrE5T.zUbGIREq0hCumF0BGYDZ
 TZOX2oCa6ILyD8Rse7e.9HVKxy1I1bwnsbuiFqXZK9P4hzgSpREnXgY4YEuOobmZ5.fpaXgjPRf_
 WGB4t_Xh2r6DOgXekLlukuEcAZ.RaTaZ7YQfdolUrHFO_5AXOYv49qpOHGX0XKl42ebeF5ieHTxJ
 JuPAvByJfBlVGRfqFGTttntc3g1w.ErouRg.3_Dt7A9UFJW4urnH2Cx5jWxCkFEoOJo01ewwSTxQ
 bTGCODBINW8FCU5YD.GqThE6myol1sZnnTcZw_teDKwM7Xz57LkOxbSsfmY8w.476Q6DfUJSJ9kT
 .vJqPKAIBb9Jeg3QIZJYh6X2XKUH2D1FEXyNPUgGLLFTl.xQAnevBnDWJDo4bZOrrzeaEK7roLF1
 z4Mq7FYtM.LlM.a4PIHxYC_ugATec1oMIo7m8ROmPC96qJux0RY1jxi9f29UINpKngXdjzDaIudg
 RFwfahsTytlRWAOa8_aaxrjEViVDgUhX4UyKEweZSP25kkbgw7pYz.Cw6QEMSzmj5hdBBCjMTa0c
 6pt6g_fBmmJkqtxmbHvXHSFJvNzUIqE5FYnWzlFww2uFxoszokPgEn3Pg9qNuNGVL3EUBjQyXsdv
 HNxPwANj5J6TvyLYeggg8kwv4TLMlKWf60Ve94tlJXkEN8nymstl5o8DPETPbwO2o3Plr7YFJm7x
 G24R.7TJeq0S8uaDsIAYEbbs4vV1EQq1VPM4.qBk8ChmZV18YlSKIbbqcyVuqDqYpdVwwN9yjxpb
 LBs5RS3rwzA7wdZpF7FQCnfguIavhSGORrKLKnwzPQ2wWtKMsVUXoKQuzYwHt.yVzJNC9XiwhBzu
 g.Zri29hcUDLaTW.GKSClUX5PKzqWjtfTNi5czbHD3xNsNfA2CT0sJXhbsTOBkYUN.oRDUiaCpgF
 h2VCFy6j0kbs3wHvfqBiWx8gqvIPXzXPQo_ZZT3niFriVxlQa_H00.yaoJ.xFL2m23Ma.lpwTbm7
 SgC6oNPQTahqTrTTVaEx7tI_EXy73xY8t3OJ._A50qEgJSykbUKdrjHsWsesvIupuOQK4_OFKUN8
 He6kMUrQwqhTFLdj1WpyCVHvYEQdTmKRFHG7auAzZvl6bn4hKxna8rhqE6J6c.fb5mxMgvM0DKR_
 US7XpyKFzSM3yz9as1Rnaey59feedVZUoNOWoik0iyTC33YR7aSor6IYeLBzhlMacqjAPttwyg4V
 tDwCif6o6w.n5ULtvUG7_DgzLClA1V55aO_7jeOdWCHsxM3eiFqkOdq52eLDT4.Hmft5_YodrgWQ
 .EfqcvIK3Arfjl6jv09RYLYnY6DranVbUwOnC9GLB7vXLYirGmIX1hMMyypWrt8VRcxTRS0doQvr
 3tLqvk2.ezGYy4JBZvjRdwBZFN7uyR26caUhQZ2TT_KoS6ifuBeIiboYUpvBb9Up4P4726VF.pAC
 q7t6BWLRw1p7LNE1m1BqpGx7DK3g7AHVkXq0iDlBDaufsmdqtWRJ4HTDSW.D2Tc3ZCJB9BnM5dIw
 VD97p3pBjQ7IE0DkboMJWpJ.jFUsWA91SMvHAuHmIDk.Z_4.J7mefR3CaW9ys5WzrznE5mmk6yb5
 O1aWcPkfCF.WCLvjNw531oxZsuJOqBv3tcfgrm6R2aOdurJXC3HiSgFSNpacM8QtwGTmlwEK9u1q
 Cw14LbRnSszNbdBvSzH2R9Gu.l3WWZzB47vk9jSwV.27P
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 17 Nov 2021 02:18:58 +0000
Received: by kubenode522.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4e09b8843f28c89cb8b5731a4dace074;
          Wed, 17 Nov 2021 02:18:57 +0000 (UTC)
Message-ID: <a64aa4af-67b1-536c-9bd0-7b34e6cc1abe@schaufler-ca.com>
Date:   Tue, 16 Nov 2021 18:18:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr
 fix
Content-Language: en-US
To:     David Anderson <dvander@google.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        selinux@vger.kernel.org, paulmoore@microsoft.com,
        Luca.Boccassi@microsoft.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211117015806.2192263-1-dvander@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211117015806.2192263-1-dvander@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/2021 5:58 PM, David Anderson wrote:
> Mark Salyzyn (3):
>    Add flags option to get xattr method paired to __vfs_getxattr
>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>    overlayfs: override_creds=off option bypass creator_cred
>
> Mark Salyzyn + John Stultz (1):
>    overlayfs: inode_owner_or_capable called during execv
>
> The first three patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
>
> The fourth adds the feature depends on these other fixes.
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.

This isn't very clear. Are you saying that the security attributes
of the upper, lower, and work directories are determined by the
attributes of the process that mounted the filesystem? What is an
"incoming access"? I'm sure that means something if you're steeped
in the lore of overlayfs, but it isn't obvious to me.

> If the principles of least privilege are applied for sepolicy, the
> mounter's credentials might not overlap the credentials of the caller's
> when accessing the overlayfs filesystem.

I'm sorry, but I've tried pretty hard, and can't puzzle that one out.

>    For example, a file that a
> lower DAC privileged caller can execute, is MAC denied to the
> generally higher DAC privileged mounter, to prevent an attack vector.

DAC privileges are not hierarchical. This doesn't make any sense.

> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.

I think I might have figured that one out, but in order to do so
I have to make way too many assumptions about the earlier paragraph.
Could you please try to explain what you're doing with more context?

>    The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Signed-off-by: David Anderson <dvander@google.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: selinux@vger.kernel.org
> Cc: paulmoore@microsoft.com
> Cc: Luca.Boccassi@microsoft.com
>
> ---
>
> v19
> - rebase.
>
> v18
> - rebase + fix minor cut and paste error for inode argument in __vfs_getxattr
>
> v17
> - correct some zero-day build failures.
> - fix up documentation
>
> v16
> - rebase and merge of two patches.
> - add adjustment to deal with execv when overrides is off.
>
> v15
> - Revert back to v4 with fixes from on the way from v5-v14. The single
>    structure argument passing to address the complaints about too many
>    arguments was rejected by the community.
> - Drop the udner discussion fix for an additional CAP_DAC_READ_SEARCH
>    check. Can address that independently.
> - ToDo: upstream test frame for thes security fixes (currently testing
>    is all in Android).
>
> v14:
> - Rejoin, rebase and a few adjustments.
>
> v13:
> - Pull out first patch and try to get it in alone feedback, some
>    Acks, and then <crickets> because people forgot why we were doing i.
>
> v12:
> - Restore squished out patch 2 and 3 in the series,
>    then change algorithm to add flags argument.
>    Per-thread flag is a large security surface.
>
> v11:
> - Squish out v10 introduced patch 2 and 3 in the series,
>    then and use per-thread flag instead for nesting.
> - Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
> - Add sb argument to ovl_revert_creds to match future work.
>
> v10:
> - Return NULL on CAP_DAC_READ_SEARCH
> - Add __get xattr method to solve sepolicy logging issue
> - Drop unnecessary sys_admin sepolicy checking for administrative
>    driver internal xattr functions.
>
> v6:
> - Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
> - Do better with the documentation, drop rationalizations.
> - pr_warn message adjusted to report consequences.
>
> v5:
> - beefed up the caveats in the Documentation
> - Is dependent on
>    "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
>    "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
> - Added prwarn when override_creds=off
>
> v4:
> - spelling and grammar errors in text
>
> v3:
> - Change name from caller_credentials / creator_credentials to the
>    boolean override_creds.
> - Changed from creator to mounter credentials.
> - Updated and fortified the documentation.
> - Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS
>
> v2:
> - Forward port changed attr to stat, resulting in a build error.
> - altered commit message.
>
> David Anderson (4):
>    Add flags option to get xattr method paired to __vfs_getxattr
>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>    overlayfs: override_creds=off option bypass creator_cred
>    overlayfs: inode_owner_or_capable called during execv
>
>   Documentation/filesystems/locking.rst   |  2 +-
>   Documentation/filesystems/overlayfs.rst | 26 ++++++++++++++-
>   fs/9p/acl.c                             |  3 +-
>   fs/9p/xattr.c                           |  3 +-
>   fs/afs/xattr.c                          | 10 +++---
>   fs/attr.c                               |  2 +-
>   fs/btrfs/xattr.c                        |  3 +-
>   fs/ceph/xattr.c                         |  3 +-
>   fs/cifs/xattr.c                         |  2 +-
>   fs/ecryptfs/inode.c                     |  6 ++--
>   fs/ecryptfs/mmap.c                      |  5 +--
>   fs/erofs/xattr.c                        |  3 +-
>   fs/ext2/xattr_security.c                |  2 +-
>   fs/ext2/xattr_trusted.c                 |  2 +-
>   fs/ext2/xattr_user.c                    |  2 +-
>   fs/ext4/xattr_hurd.c                    |  2 +-
>   fs/ext4/xattr_security.c                |  2 +-
>   fs/ext4/xattr_trusted.c                 |  2 +-
>   fs/ext4/xattr_user.c                    |  2 +-
>   fs/f2fs/xattr.c                         |  4 +--
>   fs/fuse/xattr.c                         |  4 +--
>   fs/gfs2/xattr.c                         |  3 +-
>   fs/hfs/attr.c                           |  2 +-
>   fs/hfsplus/xattr.c                      |  3 +-
>   fs/hfsplus/xattr_security.c             |  3 +-
>   fs/hfsplus/xattr_trusted.c              |  3 +-
>   fs/hfsplus/xattr_user.c                 |  3 +-
>   fs/inode.c                              |  7 +++--
>   fs/internal.h                           |  3 +-
>   fs/jffs2/security.c                     |  3 +-
>   fs/jffs2/xattr_trusted.c                |  3 +-
>   fs/jffs2/xattr_user.c                   |  3 +-
>   fs/jfs/xattr.c                          |  5 +--
>   fs/kernfs/inode.c                       |  3 +-
>   fs/nfs/nfs4proc.c                       |  9 ++++--
>   fs/ntfs3/xattr.c                        |  2 +-
>   fs/ocfs2/xattr.c                        |  9 ++++--
>   fs/open.c                               |  2 +-
>   fs/orangefs/xattr.c                     |  3 +-
>   fs/overlayfs/copy_up.c                  |  2 +-
>   fs/overlayfs/dir.c                      | 17 +++++-----
>   fs/overlayfs/file.c                     | 25 ++++++++-------
>   fs/overlayfs/inode.c                    | 29 ++++++++---------
>   fs/overlayfs/namei.c                    |  6 ++--
>   fs/overlayfs/overlayfs.h                |  7 +++--
>   fs/overlayfs/ovl_entry.h                |  1 +
>   fs/overlayfs/readdir.c                  |  8 ++---
>   fs/overlayfs/super.c                    | 34 ++++++++++++++++----
>   fs/overlayfs/util.c                     | 13 ++++++--
>   fs/posix_acl.c                          |  2 +-
>   fs/reiserfs/xattr_security.c            |  3 +-
>   fs/reiserfs/xattr_trusted.c             |  3 +-
>   fs/reiserfs/xattr_user.c                |  3 +-
>   fs/squashfs/xattr.c                     |  2 +-
>   fs/ubifs/xattr.c                        |  3 +-
>   fs/xattr.c                              | 42 +++++++++++++------------
>   fs/xfs/xfs_xattr.c                      |  3 +-
>   include/linux/lsm_hook_defs.h           |  3 +-
>   include/linux/security.h                |  6 ++--
>   include/linux/xattr.h                   |  6 ++--
>   include/uapi/linux/xattr.h              |  7 +++--
>   mm/shmem.c                              |  3 +-
>   net/socket.c                            |  3 +-
>   security/commoncap.c                    | 11 ++++---
>   security/integrity/evm/evm_main.c       | 13 +++++---
>   security/security.c                     |  5 +--
>   security/selinux/hooks.c                | 19 ++++++-----
>   security/smack/smack_lsm.c              | 18 ++++++-----
>   68 files changed, 289 insertions(+), 167 deletions(-)
>
