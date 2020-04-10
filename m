Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDB1A43E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 10:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDJIpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 04:45:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:14776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJIpn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:45:43 -0400
IronPort-SDR: ifaDejv74zCecJ/v3/ZKKV6DC+qofHZfRPCxvHO+PImGHqnQGBqAj+ohJVODZe3zy/dTvRCiwo
 AhIXAxIRiZSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 01:45:42 -0700
IronPort-SDR: mCu+vmSHuwan7HxyoaLutMEhVSMqZMSE7w844rGzbB8LsYOruMQ3aBxh7XIKSCi9TLHJ6x5tXe
 nWEH5QQ8pgIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; 
   d="scan'208";a="297756977"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Apr 2020 01:45:37 -0700
Subject: Re: [selftests/landlock] d9d464ccf6:
 kernel-selftests.landlock.test_base.fail
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        lkp@lists.01.org
References: <20200410022739.GK8179@shao2-debian>
 <65904ee7-602a-c10b-b85c-1a39023506a6@digikod.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <e79bd4aa-fcb9-7e4b-db2d-bcc7af26f6ba@intel.com>
Date:   Fri, 10 Apr 2020 16:45:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <65904ee7-602a-c10b-b85c-1a39023506a6@digikod.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for this inconvenience, we only enabled the configs for 
kernel-selftests in mainline,
we'll consider to add new required configurations dynamically to avoid 
false positive.

Best Regards,
Rong Chen

On 4/10/20 4:15 PM, Mickaël Salaün wrote:
> Why isn't this bot enabling the required kernel configuration (i.e.
> CONFIG_SECURITY_LANDLOCK, specified in
> tools/testing/selftests/landlock/config)?
>
> On 10/04/2020 04:27, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: d9d464ccf68e19bf7d303022d873141b5e1f7219 ("[PATCH v15 08/10] selftests/landlock: Add initial tests")
>> url: https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM/20200327-073729
>> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
>>
>> in testcase: kernel-selftests
>> with following parameters:
>>
>> 	group: kselftests-01
>> 	ucode: 0xd6
>>
>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>
>>
>> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> 2020-04-09 08:20:02 make run_tests -C landlock
>> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock'
>> make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
>> make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219'
>>    INSTALL ./usr/include
>> make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219'
>> gcc -Wall -O2 -I../../../../usr/include    test_base.c /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest.h ../../../../usr/include/linux/landlock.h ../kselftest_harness.h common.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock/test_base
>> gcc -Wall -O2 -I../../../../usr/include    test_ptrace.c /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest.h ../../../../usr/include/linux/landlock.h ../kselftest_harness.h common.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock/test_ptrace
>> gcc -Wall -O2 -I../../../../usr/include    test_fs.c /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/kselftest.h ../../../../usr/include/linux/landlock.h ../kselftest_harness.h common.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock/test_fs
>> gcc -Os -static -o /usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock/true true.c
>> TAP version 13
>> 1..3
>> # selftests: landlock: test_base
>> # common.h:37:ruleset_rw.fdinfo:Expected 0 (0) <= self->ruleset_fd (18446744073709551615)
>> # ruleset_rw.fdinfo: Test terminated by assertion
>> # test_base.c:64:global.features:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.features: Test terminated by assertion
>> # test_base.c:89:global.empty_attr_ruleset:Expected errno (38) == EINVAL (22)
>> # global.empty_attr_ruleset: Test terminated by assertion
>> # test_base.c:99:global.empty_attr_path_beneath:Expected errno (38) == EINVAL (22)
>> # global.empty_attr_path_beneath: Test terminated by assertion
>> # test_base.c:109:global.empty_attr_enforce:Expected errno (38) == EINVAL (22)
>> # global.empty_attr_enforce: Test terminated by assertion
>> # [==========] Running 5 tests from 2 test cases.
>> # [ RUN      ] ruleset_rw.fdinfo
>> # [     FAIL ] ruleset_rw.fdinfo
>> # [ RUN      ] global.features
>> # [     FAIL ] global.features
>> # [ RUN      ] global.empty_attr_ruleset
>> # [     FAIL ] global.empty_attr_ruleset
>> # [ RUN      ] global.empty_attr_path_beneath
>> # [     FAIL ] global.empty_attr_path_beneath
>> # [ RUN      ] global.empty_attr_enforce
>> # [     FAIL ] global.empty_attr_enforce
>> # [==========] 0 / 5 tests passed.
>> # [  FAILED  ]
>> not ok 1 selftests: landlock: test_base # exit=1
>> # selftests: landlock: test_ptrace
>> # test_ptrace.c:36:global.allow_with_one_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # test_ptrace.c:148:global.allow_with_one_domain:Expected 1 (1) == read(pipe_child[0], &buf_parent, 1) (0)
>> # test_ptrace.c:149:global.allow_with_one_domain:Failed to read() sync #2 from child
>> # global.allow_with_one_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.deny_with_parent_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # test_ptrace.c:99:global.deny_with_parent_domain:Expected 1 (1) == read(pipe_parent[0], &buf_child, 1) (0)
>> # test_ptrace.c:100:global.deny_with_parent_domain:Failed to read() sync #1 from parent
>> # global.deny_with_parent_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.deny_with_sibling_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # test_ptrace.c:36:global.deny_with_sibling_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.deny_with_sibling_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.allow_sibling_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.allow_sibling_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.allow_with_nested_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.allow_with_nested_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.deny_with_nested_and_parent_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.deny_with_nested_and_parent_domain: Test terminated by assertion
>> # test_ptrace.c:36:global.deny_with_forked_domain:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # global.deny_with_forked_domain: Test terminated by assertion
>> # [==========] Running 8 tests from 2 test cases.
>> # [ RUN      ] global.allow_without_domain
>> # [       OK ] global.allow_without_domain
>> # [ RUN      ] global.allow_with_one_domain
>> # [     FAIL ] global.allow_with_one_domain
>> # [ RUN      ] global.deny_with_parent_domain
>> # [     FAIL ] global.deny_with_parent_domain
>> # [ RUN      ] global.deny_with_sibling_domain
>> # [     FAIL ] global.deny_with_sibling_domain
>> # [ RUN      ] global.allow_sibling_domain
>> # [     FAIL ] global.allow_sibling_domain
>> # [ RUN      ] global.allow_with_nested_domain
>> # [     FAIL ] global.allow_with_nested_domain
>> # [ RUN      ] global.deny_with_nested_and_parent_domain
>> # [     FAIL ] global.deny_with_nested_and_parent_domain
>> # [ RUN      ] global.deny_with_forked_domain
>> # [     FAIL ] global.deny_with_forked_domain
>> # [==========] 1 / 8 tests passed.
>> # [  FAILED  ]
>> not ok 2 selftests: landlock: test_ptrace # exit=1
>> # selftests: landlock: test_fs
>> # common.h:37:ruleset_rw.inval:Expected 0 (0) <= self->ruleset_fd (18446744073709551615)
>> # ruleset_rw.inval: Test terminated by assertion
>> # common.h:37:ruleset_rw.nsfs:Expected 0 (0) <= self->ruleset_fd (18446744073709551615)
>> # ruleset_rw.nsfs: Test terminated by assertion
>> # test_fs.c:342:layout1.whitelist:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.whitelist: Test terminated by assertion
>> # test_fs.c:342:layout1.unhandled_access:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.unhandled_access: Test terminated by assertion
>> # test_fs.c:342:layout1.ruleset_overlap:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.ruleset_overlap: Test terminated by assertion
>> # test_fs.c:342:layout1.inherit_superset:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.inherit_superset: Test terminated by assertion
>> # test_fs.c:342:layout1.rule_on_mountpoint:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rule_on_mountpoint: Test terminated by assertion
>> # test_fs.c:342:layout1.rule_over_mountpoint:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rule_over_mountpoint: Test terminated by assertion
>> # test_fs.c:342:layout1.rule_over_root:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rule_over_root: Test terminated by assertion
>> # test_fs.c:720:layout1.rule_inside_mount_ns:Expected -1 (18446744073709551615) != syscall(SYS_pivot_root, dir_s3d2, dir_s3d3) (18446744073709551615)
>> # test_fs.c:722:layout1.rule_inside_mount_ns:Failed to pivot_root into "tmp/s3d1/s3d2": Invalid argument
>> #
>> # layout1.rule_inside_mount_ns: Test terminated by assertion
>> # test_fs.c:342:layout1.mount_and_pivot:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.mount_and_pivot: Test terminated by assertion
>> # test_fs.c:342:layout1.relative_open:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.relative_open: Test terminated by assertion
>> # test_fs.c:342:layout1.relative_chdir:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.relative_chdir: Test terminated by assertion
>> # test_fs.c:342:layout1.relative_chroot_only:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.relative_chroot_only: Test terminated by assertion
>> # test_fs.c:342:layout1.relative_chroot_chdir:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.relative_chroot_chdir: Test terminated by assertion
>> # test_fs.c:342:layout1.chroot:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.chroot: Test terminated by assertion
>> # test_fs.c:342:layout1.execute:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.execute: Test terminated by assertion
>> # test_fs.c:342:layout1.link_to:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.link_to: Test terminated by assertion
>> # test_fs.c:342:layout1.rename_from:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rename_from: Test terminated by assertion
>> # test_fs.c:342:layout1.rename_to:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rename_to: Test terminated by assertion
>> # test_fs.c:342:layout1.rmdir:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.rmdir: Test terminated by assertion
>> # test_fs.c:342:layout1.unlink:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.unlink: Test terminated by assertion
>> # test_fs.c:342:layout1.make_char:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_char: Test terminated by assertion
>> # test_fs.c:342:layout1.make_block:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_block: Test terminated by assertion
>> # test_fs.c:342:layout1.make_reg:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_reg: Test terminated by assertion
>> # test_fs.c:342:layout1.make_sock:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_sock: Test terminated by assertion
>> # test_fs.c:342:layout1.make_fifo:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_fifo: Test terminated by assertion
>> # test_fs.c:342:layout1.make_sym:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_sym: Test terminated by assertion
>> # test_fs.c:342:layout1.make_dir:Expected 0 (0) == landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES, sizeof(attr_features), &attr_features) (18446744073709551615)
>> # layout1.make_dir: Test terminated by assertion
>> # [==========] Running 31 tests from 3 test cases.
>> # [ RUN      ] layout1.no_restriction
>> # [       OK ] layout1.no_restriction
>> # [ RUN      ] ruleset_rw.inval
>> # [     FAIL ] ruleset_rw.inval
>> # [ RUN      ] ruleset_rw.nsfs
>> # [     FAIL ] ruleset_rw.nsfs
>> # [ RUN      ] layout1.whitelist
>> # [     FAIL ] layout1.whitelist
>> # [ RUN      ] layout1.unhandled_access
>> # [     FAIL ] layout1.unhandled_access
>> # [ RUN      ] layout1.ruleset_overlap
>> # [     FAIL ] layout1.ruleset_overlap
>> # [ RUN      ] layout1.inherit_superset
>> # [     FAIL ] layout1.inherit_superset
>> # [ RUN      ] layout1.rule_on_mountpoint
>> # [     FAIL ] layout1.rule_on_mountpoint
>> # [ RUN      ] layout1.rule_over_mountpoint
>> # [     FAIL ] layout1.rule_over_mountpoint
>> # [ RUN      ] layout1.rule_over_root
>> # [     FAIL ] layout1.rule_over_root
>> # [ RUN      ] layout1.rule_inside_mount_ns
>> # [     FAIL ] layout1.rule_inside_mount_ns
>> # [ RUN      ] layout1.mount_and_pivot
>> # [     FAIL ] layout1.mount_and_pivot
>> # [ RUN      ] layout1.relative_open
>> # [     FAIL ] layout1.relative_open
>> # [ RUN      ] layout1.relative_chdir
>> # [     FAIL ] layout1.relative_chdir
>> # [ RUN      ] layout1.relative_chroot_only
>> # [     FAIL ] layout1.relative_chroot_only
>> # [ RUN      ] layout1.relative_chroot_chdir
>> # [     FAIL ] layout1.relative_chroot_chdir
>> # [ RUN      ] layout1.chroot
>> # [     FAIL ] layout1.chroot
>> # [ RUN      ] layout1.execute
>> # [     FAIL ] layout1.execute
>> # [ RUN      ] layout1.link_to
>> # [     FAIL ] layout1.link_to
>> # [ RUN      ] layout1.rename_from
>> # [     FAIL ] layout1.rename_from
>> # [ RUN      ] layout1.rename_to
>> # [     FAIL ] layout1.rename_to
>> # [ RUN      ] layout1.rmdir
>> # [     FAIL ] layout1.rmdir
>> # [ RUN      ] layout1.unlink
>> # [     FAIL ] layout1.unlink
>> # [ RUN      ] layout1.make_char
>> # [     FAIL ] layout1.make_char
>> # [ RUN      ] layout1.make_block
>> # [     FAIL ] layout1.make_block
>> # [ RUN      ] layout1.make_reg
>> # [     FAIL ] layout1.make_reg
>> # [ RUN      ] layout1.make_sock
>> # [     FAIL ] layout1.make_sock
>> # [ RUN      ] layout1.make_fifo
>> # [     FAIL ] layout1.make_fifo
>> # [ RUN      ] layout1.make_sym
>> # [     FAIL ] layout1.make_sym
>> # [ RUN      ] layout1.make_dir
>> # [     FAIL ] layout1.make_dir
>> # [ RUN      ] global.cleanup
>> # [       OK ] global.cleanup
>> # [==========] 2 / 31 tests passed.
>> # [  FAILED  ]
>> not ok 3 selftests: landlock: test_fs # exit=1
>> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d9d464ccf68e19bf7d303022d873141b5e1f7219/tools/testing/selftests/landlock'
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
>>
>>
>>
>> Thanks,
>> Rong Chen
>>

