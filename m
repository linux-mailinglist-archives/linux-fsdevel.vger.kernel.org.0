Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52E242DF1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhJNQ1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 12:27:25 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49382 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232429AbhJNQ1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:27:21 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id BA8AB82189;
        Thu, 14 Oct 2021 19:25:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634228707;
        bh=s1WF9iRBOqToM0ZVB4vrYm5q31mqCpBrO4ted2GwVOY=;
        h=Date:To:CC:From:Subject;
        b=R7St9veIt+ZpKBKLsZRQkuoKGa3/rJ0Q67egIHlpHak0LdTyuU7v1wnKV0BXgvq10
         YAjBBHUcYErbin4cSQqI0dFuODkBHb5nLI3JSSRKXaU2hWas3aKvu/hosj5W3vIG/z
         F46yOXfQZA0QSE3AI7wg3EjpaTkPzwVAdUpwomq4=
Received: from [192.168.211.42] (192.168.211.42) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 14 Oct 2021 19:25:07 +0300
Message-ID: <795fb170-9696-bf0f-632c-c8e84ee98a31@paragon-software.com>
Date:   Thu, 14 Oct 2021 19:25:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3 changes for 5.15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.42]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing ntfs3 code for 5.15.

New features:
new api for mounting (was requested in [1]).

Fixed:
- some memory leaks and panic;
- fixed xfstests (tested on x86_64)
generic/016 generic/021 generic/022 generic/041 generic/274 generic/423;
- some typos, wrong returned error codes, dead code, etc.

Most of the code was in linux-next branch since September, but
there are some patches, that were in linux-next branch only
for a couple of days. There is no regression in tests.

There is merge conflict in linux-next [2].

After this release we plan to move from github.com to kernel.org
(github can remain as ro mirror).

Regards,

Konstantin

[1]: https://lore.kernel.org/lkml/20210810090234.GA23732@lst.de/
[2]: https://lore.kernel.org/lkml/20211006101533.3556de51@canb.auug.org.au/

----------------------------------------------------------------

The following changes since commit 2e3a51b59ea26544303e168de8a0479915f09aa3:

  fs/ntfs3: Change how module init/info messages are displayed (Sun Aug 29 17:42:39 2021 +0300)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_5.15

for you to fetch changes up to 8607954cf255329d1c6dfc073ff1508b7585573c:

  fs/ntfs3: Check for NULL pointers in ni_try_remove_attr_list (Mon Oct 11 19:43:29 2021 +0300)

----------------------------------------------------------------
Konstantin Komarov (25)
    fs/ntfs3: Check for NULL pointers in ni_try_remove_attr_list
    fs/ntfs3: Refactor ntfs_read_mft
    fs/ntfs3: Refactor ni_parse_reparse
    fs/ntfs3: Refactor ntfs_create_inode
    fs/ntfs3: Refactor ntfs_readlink_hlp
    fs/ntfs3: Rework ntfs_utf16_to_nls
    fs/ntfs3: Fix memory leak if fill_super failed
    fs/ntfs3: Keep prealloc for all types of files
    fs/ntfs3: Remove unnecessary functions
    fs/ntfs3: Forbid FALLOC_FL_PUNCH_HOLE for normal files
    fs/ntfs3: Refactoring of ntfs_set_ea
    fs/ntfs3: Remove locked argument in ntfs_set_ea
    fs/ntfs3: Use available posix_acl_release instead of ntfs_posix_acl_release
    fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
    fs/ntfs3: Refactoring of ntfs_init_from_boot
    fs/ntfs3: Reject mount if boot's cluster size < media sector size
    fs/ntfs3: Refactoring lock in ntfs_init_acl
    fs/ntfs3: Change posix_acl_equiv_mode to posix_acl_update_mode
    fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
    fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
    fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode
    fs/ntfs3: Fix logical error in ntfs_create_inode
    fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update
    fs/ntfs3: Change max hardlinks limit to 4000
    fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext

Kari Argillander (41)
    fs/ntfs3: Remove deprecated mount options nls
    Doc/fs/ntfs3: Fix rst format and make it cleaner
    fs/ntfs3: Initiliaze sb blocksize only in one place + refactor
    fs/ntfs3: Initialize pointer before use place in fill_super
    fs/ntfs3: Remove tmp pointer upcase in fill_super
    fs/ntfs3: Remove tmp pointer bd_inode in fill_super
    fs/ntfs3: Remove tmp var is_ro in ntfs_fill_super
    fs/ntfs3: Use sb instead of sbi->sb in fill_super
    fs/ntfs3: Remove unnecessary variable loading in fill_super
    fs/ntfs3: Return straight without goto in fill_super
    fs/ntfs3: Remove impossible fault condition in fill_super
    fs/ntfs3: Change EINVAL to ENOMEM when d_make_root fails
    fs/ntfs3: Fix wrong error message $Logfile -> $UpCase
    fs/ntfs3: Use min/max macros instated of ternary operators
    fs/ntfs3: Use clamp/max macros instead of comparisons
    fs/ntfs3: Remove always false condition check
    fs/ntfs3: Fix ntfs_look_for_free_space() does only report -ENOSPC
    fs/ntfs3: Remove tabs before spaces from comment
    fs/ntfs3: Remove braces from single statment block
    fs/ntfs3: Place Comparisons constant right side of the test
    fs/ntfs3: Remove '+' before constant in ni_insert_resident()
    fs/ntfs3: Always use binary search with entry search
    fs/ntfs3: Make binary search to search smaller chunks in beginning
    fs/ntfs3: Limit binary search table size
    fs/ntfs3: Remove unneeded header files from c files
    fs/ntfs3: Change right headers to lznt.c
    fs/ntfs3: Change right headers to upcase.c
    fs/ntfs3: Change right headers to bitfunc.c
    fs/ntfs3: Add missing header and guards to lib/ headers
    fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
    fs/ntfs3: Add missing header files to ntfs.h
    fs/ntfs3. Add forward declarations for structs to debug.h
    fs/ntfs3: Show uid/gid always in show_options()
    fs/ntfs3: Rename mount option no_acs_rules > (no)acsrules
    fs/ntfs3: Add iocharset= mount option as alias for nls=
    fs/ntfs3: Make mount option nohidden more universal
    fs/ntfs3: Init spi more in init_fs_context than fill_super
    fs/ntfs3: Use new api for mounting
    fs/ntfs3: Convert mount options to pointer in sbi
    fs/ntfs3: Remove unnecesarry remount flag handling
    fs/ntfs3: Remove unnecesarry mount option noatime

Christophe JAILLET (2)
    fs/ntfs3: Remove a useless shadowing variable
    fs/ntfs3: Remove a useless test in 'indx_find()'

Colin Ian King (2)
    fs/ntfs3: Fix a memory leak on object opts
    fs/ntfs3: Remove redundant initialization of variable err

 Documentation/filesystems/ntfs3.rst | 141 +++++++++++++++++++++++++++------------------------
 fs/ntfs3/attrib.c                   |  20 ++------
 fs/ntfs3/attrlist.c                 |   9 ++--
 fs/ntfs3/bitfunc.c                  |  10 +---
 fs/ntfs3/bitmap.c                   |  14 +++---
 fs/ntfs3/debug.h                    |   3 ++
 fs/ntfs3/dir.c                      |  30 +++++------
 fs/ntfs3/file.c                     |  12 +++--
 fs/ntfs3/frecord.c                  |  55 ++++++++++++++------
 fs/ntfs3/fslog.c                    |  12 ++---
 fs/ntfs3/fsntfs.c                   |  77 ++++++++++++++--------------
 fs/ntfs3/index.c                    | 160 +++++++++++++++++-----------------------------------------
 fs/ntfs3/inode.c                    | 159 +++++++++++++++++++++++++++++-----------------------------
 fs/ntfs3/lib/decompress_common.h    |   5 ++
 fs/ntfs3/lib/lib.h                  |   6 +++
 fs/ntfs3/lznt.c                     |  12 ++---
 fs/ntfs3/namei.c                    |  24 ---------
 fs/ntfs3/ntfs.h                     |  20 +++++---
 fs/ntfs3/ntfs_fs.h                  |  67 +++++++++++++++++--------
 fs/ntfs3/record.c                   |   3 --
 fs/ntfs3/run.c                      |   2 -
 fs/ntfs3/super.c                    | 651 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------------------------------
 fs/ntfs3/upcase.c                   |   8 +--
 fs/ntfs3/xattr.c                    | 249 +++++++++++++++++++++++-------------------------------------------------------------------
 24 files changed, 787 insertions(+), 962 deletions(-)
