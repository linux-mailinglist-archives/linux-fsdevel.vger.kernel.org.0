Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E90C2CCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 07:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfJAFHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 01:07:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:16783 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfJAFHG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:07:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 22:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; 
   d="scan'208";a="190474561"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2019 22:06:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iFANE-000IpB-8f; Tue, 01 Oct 2019 13:06:56 +0800
Date:   Tue, 1 Oct 2019 13:06:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     kbuild-all@01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linuxppc-dev@lists.ozlabs.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Drysdale <drysdale@google.com>,
        Christian Brauner <christian@brauner.io>,
        libc-alpha@sourceware.org, linux-parisc@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-api@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v13 7/9] open: openat2(2) syscall
Message-ID: <201910011326.iTYOtJYo%lkp@intel.com>
References: <20190930183316.10190-8-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930183316.10190-8-cyphar@cyphar.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aleksa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc1 next-20191001]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Aleksa-Sarai/namei-openat2-2-path-resolution-restrictions/20191001-025628
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-37-gd466a02-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/open.c:757:13: sparse: sparse: restricted fmode_t degrades to integer
   fs/open.c:983:18: sparse: sparse: restricted fmode_t degrades to integer
>> fs/open.c:1011:36: sparse: sparse: invalid assignment: |=
>> fs/open.c:1011:36: sparse:    left side has type int
>> fs/open.c:1011:36: sparse:    right side has type restricted fmode_t
   fs/open.c:1013:36: sparse: sparse: invalid assignment: |=
   fs/open.c:1013:36: sparse:    left side has type int
   fs/open.c:1013:36: sparse:    right side has type restricted fmode_t
>> fs/open.c:1029:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted fmode_t [usertype] opath_mask @@    got pe] opath_mask @@
>> fs/open.c:1029:24: sparse:    expected restricted fmode_t [usertype] opath_mask
>> fs/open.c:1029:24: sparse:    got int opath_mask
>> fs/open.c:1011:36: sparse: sparse: invalid assignment: |=
>> fs/open.c:1011:36: sparse:    left side has type int
>> fs/open.c:1011:36: sparse:    right side has type restricted fmode_t
   fs/open.c:1013:36: sparse: sparse: invalid assignment: |=
   fs/open.c:1013:36: sparse:    left side has type int
   fs/open.c:1013:36: sparse:    right side has type restricted fmode_t
>> fs/open.c:1029:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted fmode_t [usertype] opath_mask @@    got pe] opath_mask @@
>> fs/open.c:1029:24: sparse:    expected restricted fmode_t [usertype] opath_mask
>> fs/open.c:1029:24: sparse:    got int opath_mask
>> fs/open.c:1011:36: sparse: sparse: invalid assignment: |=
>> fs/open.c:1011:36: sparse:    left side has type int
>> fs/open.c:1011:36: sparse:    right side has type restricted fmode_t
   fs/open.c:1013:36: sparse: sparse: invalid assignment: |=
   fs/open.c:1013:36: sparse:    left side has type int
   fs/open.c:1013:36: sparse:    right side has type restricted fmode_t
>> fs/open.c:1029:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted fmode_t [usertype] opath_mask @@    got pe] opath_mask @@
>> fs/open.c:1029:24: sparse:    expected restricted fmode_t [usertype] opath_mask
>> fs/open.c:1029:24: sparse:    got int opath_mask
   fs/open.c:1173:15: sparse: sparse: undefined identifier 'copy_struct_from_user'

vim +1011 fs/open.c

   957	
   958	static inline int build_open_flags(const struct open_how *how,
   959					   struct open_flags *op)
   960	{
   961		int flags = how->flags;
   962		int lookup_flags = 0;
   963		int opath_mask = 0;
   964		int acc_mode = ACC_MODE(flags);
   965	
   966		/*
   967		 * Older syscalls still clear these bits before calling
   968		 * build_open_flags(), but openat2(2) checks all its arguments.
   969		 */
   970		if (flags & ~VALID_OPEN_FLAGS)
   971			return -EINVAL;
   972		if (how->resolve & ~VALID_RESOLVE_FLAGS)
   973			return -EINVAL;
   974		if (!(how->flags & (O_PATH | O_CREAT | __O_TMPFILE)) && how->mode != 0)
   975			return -EINVAL;
   976	
   977		if (flags & (O_CREAT | __O_TMPFILE))
   978			op->mode = (how->mode & S_IALLUGO) | S_IFREG;
   979		else
   980			op->mode = 0;
   981	
   982		/* Must never be set by userspace */
 > 983		flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
   984	
   985		/*
   986		 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
   987		 * check for O_DSYNC if the need any syncing at all we enforce it's
   988		 * always set instead of having to deal with possibly weird behaviour
   989		 * for malicious applications setting only __O_SYNC.
   990		 */
   991		if (flags & __O_SYNC)
   992			flags |= O_DSYNC;
   993	
   994		if (flags & __O_TMPFILE) {
   995			if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
   996				return -EINVAL;
   997			if (!(acc_mode & MAY_WRITE))
   998				return -EINVAL;
   999		} else if (flags & O_PATH) {
  1000			/*
  1001			 * If we have O_PATH in the open flag. Then we
  1002			 * cannot have anything other than the below set of flags
  1003			 */
  1004			flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
  1005			acc_mode = 0;
  1006	
  1007			/* Allow userspace to restrict the re-opening of O_PATH fds. */
  1008			if (how->upgrade_mask & ~VALID_UPGRADE_FLAGS)
  1009				return -EINVAL;
  1010			if (!(how->upgrade_mask & UPGRADE_NOREAD))
> 1011				opath_mask |= FMODE_PATH_READ;
  1012			if (!(how->upgrade_mask & UPGRADE_NOWRITE))
  1013				opath_mask |= FMODE_PATH_WRITE;
  1014		}
  1015	
  1016		op->open_flag = flags;
  1017	
  1018		/* O_TRUNC implies we need access checks for write permissions */
  1019		if (flags & O_TRUNC)
  1020			acc_mode |= MAY_WRITE;
  1021	
  1022		/* Allow the LSM permission hook to distinguish append
  1023		   access from general write access. */
  1024		if (flags & O_APPEND)
  1025			acc_mode |= MAY_APPEND;
  1026	
  1027		op->acc_mode = acc_mode;
  1028		op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> 1029		op->opath_mask = opath_mask;
  1030	
  1031		if (flags & O_CREAT) {
  1032			op->intent |= LOOKUP_CREATE;
  1033			if (flags & O_EXCL)
  1034				op->intent |= LOOKUP_EXCL;
  1035		}
  1036	
  1037		if (flags & O_DIRECTORY)
  1038			lookup_flags |= LOOKUP_DIRECTORY;
  1039		if (!(flags & O_NOFOLLOW))
  1040			lookup_flags |= LOOKUP_FOLLOW;
  1041		if (flags & O_EMPTYPATH)
  1042			lookup_flags |= LOOKUP_EMPTY;
  1043	
  1044		if (how->resolve & RESOLVE_NO_XDEV)
  1045			lookup_flags |= LOOKUP_NO_XDEV;
  1046		if (how->resolve & RESOLVE_NO_MAGICLINKS)
  1047			lookup_flags |= LOOKUP_NO_MAGICLINKS;
  1048		if (how->resolve & RESOLVE_NO_SYMLINKS)
  1049			lookup_flags |= LOOKUP_NO_SYMLINKS;
  1050		if (how->resolve & RESOLVE_BENEATH)
  1051			lookup_flags |= LOOKUP_BENEATH;
  1052		if (how->resolve & RESOLVE_IN_ROOT)
  1053			lookup_flags |= LOOKUP_IN_ROOT;
  1054	
  1055		op->lookup_flags = lookup_flags;
  1056		return 0;
  1057	}
  1058	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
