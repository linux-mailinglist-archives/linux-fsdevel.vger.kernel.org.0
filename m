Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643D2BC5CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKVN2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:28:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:63233 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgKVN2P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:28:15 -0500
IronPort-SDR: quH2NyluFvnWgrjGhZZTLYVpMC3QUTMyAFTCcpVd36lCdDi9NJXSzLeXIsWJtuvcInd7787pVk
 c1ILbEVxTaxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="171744691"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="xz'?yaml'?scan'208";a="171744691"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 05:27:50 -0800
IronPort-SDR: fR0Y459SANBSceyrnpH/R/V8VNt9Tf6gv75Ko48Ev22ZpJPsAgCRVWicPpIZDRSg7Fy3HJt/Lw
 w+yHQOOyPT1A==
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="xz'?yaml'?scan'208";a="546092440"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 05:27:45 -0800
Date:   Sun, 22 Nov 2020 21:42:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, 0day robot <lkp@intel.com>,
        lkp@lists.01.org
Subject: [selftests]  4d9c16a494: kernel-selftests.core.make_fail
Message-ID: <20201122134204.GF2390@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20201118104746.873084-3-gscrivan@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 4d9c16a4949b8b027efc8d4214a4c8b11379cb28 ("[PATCH v3 2/2] selftests=
: core: add tests for CLOSE_RANGE_CLOEXEC")
url: https://github.com/0day-ci/linux/commits/Giuseppe-Scrivano/fs-close_ra=
nge-add-flag-CLOSE_RANGE_CLOEXEC/20201118-185135
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162=
bc32c880a791c6c0668ce0745cf7958f576

in testcase: kernel-selftests
version: kernel-selftests-x86_64-b5a583fb-1_20201015
with following parameters:

	group: group-01
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz with 3=
2G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28
2020-11-20 16:58:42 ln -sf /usr/bin/clang
2020-11-20 16:58:42 ln -sf /usr/bin/llc
2020-11-20 16:58:42 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2020-11-20 16:58:42 make run_tests -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/capabili=
ties'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8=
b11379cb28/tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c=
8b11379cb28/tools/testing/selftests/capabilities/validate_cap
TAP version 13
1..1
# selftests: capabilities: test_execve
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# TAP version 13
# 1..12
# # [RUN]	+++ Tests with uid =3D=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Root =3D> ep
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Root +i =3D> eip
# ok 6 Passed
# # [RUN]	UID 0 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Root +ia, suidroot =3D> eipa
# ok 8 Passed
# # [RUN]	Root +ia, suidnonroot =3D> ip
# ok 9 Passed
# # [RUN]	Root +ia, sgidroot =3D> eipa
# ok 10 Passed
# ok 11 Passed
# # [RUN]	Root +ia, sgidnonroot =3D> eip
# ok 12 Passed
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
# TAP version 13
# 1..9
# # [RUN]	+++ Tests with uid !=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Non-root =3D> no caps
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Non-root +i =3D> i
# ok 6 Passed
# # [RUN]	UID 1 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Non-root +ia, sgidnonroot =3D> i
# ok 8 Passed
# ok 9 Passed
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
ok 1 selftests: capabilities: test_execve
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/capabilit=
ies'
LKP SKIP cgroup
2020-11-20 16:58:42 make run_tests -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/clone3'
gcc -g -I../../../../usr/include/    clone3.c -lcap -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/too=
ls/testing/selftests/clone3/clone3
gcc -g -I../../../../usr/include/    clone3_clear_sighand.c -lcap -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8=
b11379cb28/tools/testing/selftests/clone3/clone3_clear_sighand
gcc -g -I../../../../usr/include/    clone3_set_tid.c -lcap -o /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379=
cb28/tools/testing/selftests/clone3/clone3_set_tid
gcc -g -I../../../../usr/include/    clone3_cap_checkpoint_restore.c -lcap =
-o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/clone3/clone3_cap_checkpoint_re=
store
TAP version 13
1..4
# selftests: clone3: clone3
# TAP version 13
# 1..17
# # clone3() syscall supported
# # [1354] Trying clone3() with flags 0 (size 0)
# # I am the parent (1354). My child's pid is 1355
# # [1354] clone3() with flags says: 0 expected 0
# ok 1 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 0)
# # I am the parent (1354). My child's pid is 1356
# # [1354] clone3() with flags says: 0 expected 0
# ok 2 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 64)
# # I am the parent (1354). My child's pid is 1357
# # [1354] clone3() with flags says: 0 expected 0
# ok 3 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 56)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 4 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 96)
# # I am the parent (1354). My child's pid is 1358
# # [1354] clone3() with flags says: 0 expected 0
# ok 5 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 6 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 7 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 8 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 9 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 96)
# # I am the parent (1354). My child's pid is 1359
# # [1354] clone3() with flags says: 0 expected 0
# ok 10 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 11 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0 (size 176)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 12 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0 (size 4104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 13 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0x20000000 (size 64)
# # I am the parent (1354). My child's pid is 1360
# # [1354] clone3() with flags says: 0 expected 0
# ok 14 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 56)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 15 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0x20000000 (size 96)
# # I am the parent (1354). My child's pid is 1361
# # [1354] clone3() with flags says: 0 expected 0
# ok 16 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 4104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 17 [1354] Result (-7) matches expectation (-7)
# # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: clone3: clone3
# selftests: clone3: clone3_clear_sighand
# TAP version 13
# 1..1
# # clone3() syscall supported
# ok 1 Cleared signal handlers for child process
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: clone3: clone3_clear_sighand
# selftests: clone3: clone3_set_tid
# TAP version 13
# 1..29
# # clone3() syscall supported
# # /proc/sys/kernel/pid_max 32768
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 1 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 2 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 3 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 4 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 5 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 6 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 7 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 8 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 9 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 10 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 11 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 12 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 13 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 14 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# # File exists - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
# ok 15 [1386] Result (-17) matches expectation (-17)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1386). My child's pid is 1387
# # [1386] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 16 [1386] Result (0) matches expectation (0)
# # [1386] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 17 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1386] Result (-22) matches expectation (-22)
# # Child has PID 1388
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x0
# # I am the child, my PID is 1388 (expected 1388)
# # I am the parent (1386). My child's pid is 1388
# # [1386] clone3() with CLONE_SET_TID 1388 says :0 - expected 0
# ok 19 [1386] Result (0) matches expectation (0)
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 20 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1386). My child's pid is 1388
# # [1386] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 21 [1386] Result (0) matches expectation (0)
# # unshare PID namespace
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 22 [1386] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 43 says :-22 - expected -22
# ok 23 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # I am the child, my PID is 43 (expected 43)
# # I am the parent (1). My child's pid is 43
# # [1] clone3() with CLONE_SET_TID 43 says :0 - expected 0
# ok 24 [1] Result (0) matches expectation (0)
# # Child in PID namespace has PID 1
# # [1] Trying clone3() with CLONE_SET_TID to 2 and 0x0
# # I am the child, my PID is 2 (expected 2)
# # I am the parent (1). My child's pid is 2
# # [1] clone3() with CLONE_SET_TID 2 says :0 - expected 0
# ok 25 [1] Result (0) matches expectation (0)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 26 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 27 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # [1] Child is ready and waiting
# # I am the parent (1). My child's pid is 42
# # [1] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 28 [1] Result (0) matches expectation (0)
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 22 [1386] Result (-22) matches expectation (-22)
# # [1386] Child is ready and waiting
# ok 29 PIDs in all namespaces as expected (1388,42,1)
# # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: clone3: clone3_set_tid
# selftests: clone3: clone3_cap_checkpoint_restore
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.clone3_cap_checkpoint_restore ...
# # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child=
 has PID 1404
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1403]=
 Trying clone3() with CLONE_SET_TID to 1404
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operat=
ion not permitted - Failed to create new process
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1403]=
 clone3() with CLONE_SET_TID 1404 says:-1
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1403]=
 Trying clone3() with CLONE_SET_TID to 1404
# # clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am t=
he parent (1403). My child's pid is 1404
# # clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am t=
he child, my PID is 1404 (expected 1404)
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1403]=
 clone3() with CLONE_SET_TID 1404 says:0
# #            OK  global.clone3_cap_checkpoint_restore
# ok 1 global.clone3_cap_checkpoint_restore
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: clone3: clone3_cap_checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/clone3'
2020-11-20 16:58:43 make run_tests -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core'
gcc -g -I../../../../usr/include/    close_range_test.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb2=
8/tools/testing/selftests/core/close_range_test
close_range_test.c: In function =E2=80=98close_range_unshare=E2=80=99:
close_range_test.c:122:19: warning: passing argument 1 of =E2=80=98sys_clon=
e3=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-types]
  pid =3D sys_clone3(&args, sizeof(args));
                   ^~~~~
In file included from close_range_test.c:17:
=2E./clone3/clone3_selftests.h:49:46: note: expected =E2=80=98struct __clon=
e_args *=E2=80=99 but argument is of type =E2=80=98struct clone_args *=E2=
=80=99
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
                         ~~~~~~~~~~~~~~~~~~~~~^~~~
close_range_test.c: In function =E2=80=98close_range_unshare_capped=E2=80=
=99:
close_range_test.c:211:19: warning: passing argument 1 of =E2=80=98sys_clon=
e3=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-types]
  pid =3D sys_clone3(&args, sizeof(args));
                   ^~~~~
In file included from close_range_test.c:17:
=2E./clone3/clone3_selftests.h:49:46: note: expected =E2=80=98struct __clon=
e_args *=E2=80=99 but argument is of type =E2=80=98struct clone_args *=E2=
=80=99
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
                         ~~~~~~~~~~~~~~~~~~~~~^~~~
close_range_test.c: In function =E2=80=98close_range_cloexec=E2=80=99:
close_range_test.c:244:5: warning: implicit declaration of function =E2=80=
=98XFAIL=E2=80=99 [-Wimplicit-function-declaration]
     XFAIL(return, "Skipping test since /dev/null does not exist");
     ^~~~~
close_range_test.c:244:11: error: expected expression before =E2=80=98retur=
n=E2=80=99
     XFAIL(return, "Skipping test since /dev/null does not exist");
           ^~~~~~
close_range_test.c:253:10: error: expected expression before =E2=80=98retur=
n=E2=80=99
    XFAIL(return, "close_range() syscall not supported");
          ^~~~~~
close_range_test.c:255:10: error: expected expression before =E2=80=98retur=
n=E2=80=99
    XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
          ^~~~~~
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core/clo=
se_range_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core'
2020-11-20 16:58:43 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/cpu-hotp=
lug'
TAP version 13
1..1
# selftests: cpu-hotplug: cpu-on-off-test.sh
# pid 1480's current affinity mask: ff
# pid 1480's new affinity mask: 1
# CPU online/offline summary:
# present_cpus =3D 0-7 present_max =3D 7
# 	 Cpus in online state: 0-7
# 	 Cpus in offline state: 0
# Limited scope test: one hotplug cpu
# 	 (leaves cpu in the original state):
# 	 online to offline to online: cpu 7
ok 1 selftests: cpu-hotplug: cpu-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/cpu-hotpl=
ug'
dmabuf-heaps test: not in Makefile
2020-11-20 16:58:44 make TARGETS=3Ddmabuf-heaps
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabu=
f-heaps'
gcc -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include    dmabuf=
-heap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b=
8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-heaps/dmabuf-he=
ap
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf=
-heaps'
2020-11-20 16:59:14 make run_tests -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-h=
eaps'
TAP version 13
1..1
# selftests: dmabuf-heaps: dmabuf-heap
# No /dev/dma_heap directory?
not ok 1 selftests: dmabuf-heaps: dmabuf-heap # exit=3D255
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-he=
aps'
LKP SKIP efivarfs | no /sys/firmware/efi
2020-11-20 16:59:14 touch ./exec/pipe
2020-11-20 16:59:15 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec'
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    execveat.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/too=
ls/testing/selftests/exec/execveat
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000 -pie lo=
ad_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4=
949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_address_=
4096
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x200000 -pie =
load_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16=
a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_addres=
s_2097152
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000000 -pie=
 load_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_addre=
ss_16777216
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    recursion-depth.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379c=
b28/tools/testing/selftests/exec/recursion-depth
cd /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/exec && ln -s -f execveat execv=
eat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/exec/execveat /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/=
tools/testing/selftests/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16=
a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/subdir
TAP version 13
1..7
# selftests: exec: execveat
# /bin/sh: 0: Can't open /dev/fd/8/usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/=
exec/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyy
# Check success of execveat(5, '../execveat', 0)... [OK]
# Check success of execveat(7, 'execveat', 0)... [OK]
# Check success of execveat(9, 'execveat', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execv=
eat', 0)... [OK]
# Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
# Check success of execveat(11, '', 4096)... [OK]
# Check success of execveat(20, '', 4096)... [OK]
# Check success of execveat(12, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(18, '', 4096)... [OK]
# Check failure of execveat(11, '', 0) with ENOENT... [OK]
# Check failure of execveat(11, '(null)', 4096) with EFAULT... [OK]
# Check success of execveat(7, 'execveat.symlink', 0)... [OK]
# Check success of execveat(9, 'execveat.symlink', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.syml=
ink', 0)... [OK]
# Check success of execveat(13, '', 4096)... [OK]
# Check success of execveat(13, '', 4352)... [OK]
# Check failure of execveat(7, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(9, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests=
/exec/execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(7, 'pipe', 0) with EACCES... [OK]
# Check success of execveat(5, '../script', 0)... [OK]
# Check success of execveat(7, 'script', 0)... [OK]
# Check success of execveat(9, 'script', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scr=
ipt', 0)... [OK]
# Check success of execveat(16, '', 4096)... [OK]
# Check success of execveat(16, '', 4352)... [OK]
# Check failure of execveat(21, '', 4096) with ENOENT... [OK]
# Check failure of execveat(10, 'script', 0) with ENOENT... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check success of execveat(6, 'script', 0)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check failure of execveat(6, 'script', 0) with ENOENT... [OK]
# Check failure of execveat(7, 'execveat', 65535) with EINVAL... [OK]
# Check failure of execveat(7, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(9, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(7, '', 4096) with EACCES... [OK]
# Check failure of execveat(7, 'Makefile', 0) with EACCES... [OK]
# Check failure of execveat(14, '', 4096) with EACCES... [OK]
# Check failure of execveat(15, '', 4096) with EACCES... [OK]
# Check failure of execveat(99, '', 4096) with EBADF... [OK]
# Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
# Check failure of execveat(11, 'execveat', 0) with ENOTDIR... [OK]
# Invoke copy of 'execveat' via filename of length 4094:
# Check success of execveat(22, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
# Invoke copy of 'script' via filename of length 4094:
# Check success of execveat(23, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
ok 1 selftests: exec: execveat
# selftests: exec: load_address_4096
# PASS
ok 2 selftests: exec: load_address_4096
# selftests: exec: load_address_2097152
# PASS
ok 3 selftests: exec: load_address_2097152
# selftests: exec: load_address_16777216
# PASS
ok 4 selftests: exec: load_address_16777216
# selftests: exec: recursion-depth
ok 5 selftests: exec: recursion-depth
# selftests: exec: binfmt_script
# TAP version 1.3
# 1..27
# ok 1 - binfmt_script too-big (correctly failed bad exec)
# ok 2 - binfmt_script exact (correctly failed bad exec)
# ok 3 - binfmt_script exact-space (correctly failed bad exec)
# ok 4 - binfmt_script whitespace-too-big (correctly failed bad exec)
# ok 5 - binfmt_script truncated (correctly failed bad exec)
# ok 6 - binfmt_script empty (correctly failed bad exec)
# ok 7 - binfmt_script spaces (correctly failed bad exec)
# ok 8 - binfmt_script newline-prefix (correctly failed bad exec)
# ok 9 - binfmt_script test.pl (successful good exec)
# ok 10 - binfmt_script one-under (successful good exec)
# ok 11 - binfmt_script two-under (successful good exec)
# ok 12 - binfmt_script exact-trunc-whitespace (successful good exec)
# ok 13 - binfmt_script exact-trunc-arg (successful good exec)
# ok 14 - binfmt_script one-under-full-arg (successful good exec)
# ok 15 - binfmt_script one-under-no-nl (successful good exec)
# ok 16 - binfmt_script half-under-no-nl (successful good exec)
# ok 17 - binfmt_script one-under-trunc-arg (successful good exec)
# ok 18 - binfmt_script one-under-leading (successful good exec)
# ok 19 - binfmt_script one-under-leading-trunc-arg (successful good exec)
# ok 20 - binfmt_script two-under-no-nl (successful good exec)
# ok 21 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 22 - binfmt_script two-under-leading (successful good exec)
# ok 23 - binfmt_script two-under-leading-trunc-arg (successful good exec)
# ok 24 - binfmt_script two-under-no-nl (successful good exec)
# ok 25 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 26 - binfmt_script two-under-leading (successful good exec)
# ok 27 - binfmt_script two-under-lead-trunc-arg (successful good exec)
ok 6 selftests: exec: binfmt_script
# selftests: exec: non-regular
# Warning: file non-regular is missing!
not ok 7 selftests: exec: non-regular
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec'
LKP SKIP filesystems
2020-11-20 16:59:16 make run_tests -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu'
gcc     test_fpu.c -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu/test=
_fpu
TAP version 13
1..2
# selftests: fpu: test_fpu
# [SKIP]	can't access /sys/kernel/debug/selftest_helpers/test_fpu: No such =
file or directory
ok 1 selftests: fpu: test_fpu
# selftests: fpu: run_test_fpu.sh
# ./run_test_fpu.sh: You must have the following enabled in your kernel:
# CONFIG_TEST_FPU=3Dm
ok 2 selftests: fpu: run_test_fpu.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu'
2020-11-20 16:59:16 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove kprobe events	[PASS]
# [11] Generic dynamic event - add/remove synthetic events	[PASS]
# [12] Generic dynamic event - selective clear (compatibility)	[PASS]
# [13] Generic dynamic event - generic clear event	[PASS]
# [14] event tracing - enable/disable with event level files	[PASS]
# [15] event tracing - restricts events based on pid notrace filtering	[PAS=
S]
# [16] event tracing - restricts events based on pid	[PASS]
# [17] event tracing - enable/disable with subsystem level files	[PASS]
# [18] event tracing - enable/disable with top level files	[PASS]
# [19] Test trace_printk from module	[PASS]
# [20] ftrace - function graph filters with stack tracer	[PASS]
# [21] ftrace - function graph filters	[PASS]
# [22] ftrace - function glob filters	[PASS]
# [23] ftrace - function pid notrace filters	[PASS]
# [24] ftrace - function pid filters	[PASS]
# [25] ftrace - stacktrace filter command	[PASS]
# [26] ftrace - function trace with cpumask	[PASS]
# [27] ftrace - test for function event triggers	[PASS]
# [28] ftrace - function trace on module	[PASS]
# [29] ftrace - function profiling	[PASS]
# [30] ftrace - function profiler with function tracing	[PASS]
# [31] ftrace - test reading of set_ftrace_filter	[PASS]
# [32] ftrace - Max stack tracer	[PASS]
# [33] ftrace - test for function traceon/off triggers	[PASS]
# [34] ftrace - test tracing error log support	[PASS]
# [35] Test creation and deletion of trace instances while setting an event=
	[PASS]
# [36] Test creation and deletion of trace instances	[PASS]
# [37] Kprobe dynamic event - adding and removing	[PASS]
# [38] Kprobe dynamic event - busy event check	[PASS]
# [39] Kprobe dynamic event with arguments	[PASS]
# [40] Kprobe event with comm arguments	[PASS]
# [41] Kprobe event string type argument	[PASS]
# [42] Kprobe event symbol argument	[PASS]
# [43] Kprobe event argument syntax	[PASS]
# [44] Kprobes event arguments with types	[PASS]
# [45] Kprobe event user-memory access	[PASS]
# [46] Kprobe event auto/manual naming	[PASS]
# [47] Kprobe dynamic event with function tracer	[PASS]
# [48] Kprobe dynamic event - probing module	[PASS]
# [49] Create/delete multiprobe on kprobe event	[PASS]
# [50] Kprobe event parser error log check	[PASS]
# [51] Kretprobe dynamic event with arguments	[PASS]
# [52] Kretprobe dynamic event with maxactive	[PASS]
# [53] Kretprobe %return suffix test	[PASS]
# [54] Register/unregister many kprobe events	[PASS]
# [55] Kprobe events - probe points	[PASS]
# [56] Kprobe dynamic event - adding and removing	[PASS]
# [57] Uprobe event parser error log check	[PASS]
# [58] test for the preemptirqsoff tracer	[PASS]
# [59] Meta-selftest: Checkbashisms	[UNRESOLVED]
# [60] Test wakeup tracer	[PASS]
# [61] Test wakeup RT tracer	[PASS]
# [62] event trigger - test inter-event histogram trigger expected fail act=
ions	[XFAIL]
# [63] event trigger - test field variable support	[PASS]
# [64] event trigger - test inter-event combined histogram trigger	[PASS]
# [65] event trigger - test multiple actions on hist trigger	[PASS]
# [66] event trigger - test inter-event histogram trigger onchange action	[=
PASS]
# [67] event trigger - test inter-event histogram trigger onmatch action	[P=
ASS]
# [68] event trigger - test inter-event histogram trigger onmatch-onmax act=
ion	[PASS]
# [69] event trigger - test inter-event histogram trigger onmax action	[PAS=
S]
# [70] event trigger - test inter-event histogram trigger snapshot action	[=
PASS]
# [71] event trigger - test synthetic event create remove	[PASS]
# [72] event trigger - test inter-event histogram trigger trace action with=
 dynamic string param	[PASS]
# [73] event trigger - test synthetic_events syntax parser	[PASS]
# [74] event trigger - test synthetic_events syntax parser errors	[PASS]
# [75] event trigger - test inter-event histogram trigger trace action	[PAS=
S]
# [76] event trigger - test event enable/disable trigger	[PASS]
# [77] event trigger - test trigger filter	[PASS]
# [78] event trigger - test histogram modifiers	[PASS]
# [79] event trigger - test histogram parser errors	[PASS]
# [80] event trigger - test histogram trigger	[PASS]
# [81] event trigger - test multiple histogram triggers	[PASS]
# [82] event trigger - test snapshot-trigger	[PASS]
# [83] event trigger - test stacktrace-trigger	[PASS]
# [84] trace_marker trigger - test histogram trigger	[PASS]
# [85] trace_marker trigger - test snapshot trigger	[PASS]
# [86] trace_marker trigger - test histogram with synthetic event against k=
ernel event	[PASS]
# [87] trace_marker trigger - test histogram with synthetic event	[PASS]
# [88] event trigger - test traceon/off trigger	[PASS]
# [89] (instance)  Basic test for tracers	[PASS]
# [90] (instance)  Basic trace clock test	[PASS]
# [91] (instance)  Change the ringbuffer size	[PASS]
# [92] (instance)  Snapshot and tracing setting	[PASS]
# [93] (instance)  trace_pipe and trace_marker	[PASS]
# [94] (instance)  event tracing - enable/disable with event level files	[P=
ASS]
# [95] (instance)  event tracing - restricts events based on pid notrace fi=
ltering	[PASS]
# [96] (instance)  event tracing - restricts events based on pid	[PASS]
# [97] (instance)  event tracing - enable/disable with subsystem level file=
s	[PASS]
# [98] (instance)  ftrace - function pid notrace filters	[PASS]
# [99] (instance)  ftrace - function pid filters	[PASS]
# [100] (instance)  ftrace - stacktrace filter command	[PASS]
# [101] (instance)  ftrace - test for function event triggers	[PASS]
# [102] (instance)  ftrace - test for function traceon/off triggers	[PASS]
# [103] (instance)  event trigger - test event enable/disable trigger	[PASS]
# [104] (instance)  event trigger - test trigger filter	[PASS]
# [105] (instance)  event trigger - test histogram modifiers	[PASS]
# [106] (instance)  event trigger - test histogram trigger	[PASS]
# [107] (instance)  event trigger - test multiple histogram triggers	[PASS]
# [108] (instance)  trace_marker trigger - test histogram trigger	[PASS]
# [109] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
#=20
#=20
# # of passed:  107
# # of failed:  0
# # of unresolved:  1
# # of untested:  0
# # of unsupported:  0
# # of xfailed:  1
# # of undefined(test bug):  0
ok 1 selftests: ftrace: ftracetest
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ftrace'
2020-11-20 17:04:29 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex=
/functional'
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b=
027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_timeout.c ../include/futextest.h ../include/atomic.h ../include/logging.h=
 -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functiona=
l/futex_wait_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_wouldblock.c ../include/futextest.h ../include/atomic.h ../include/loggin=
g.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d=
9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functi=
onal/futex_wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi.c ../include/futextest.h ../include/atomic.h ../include/logging.h -=
lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a=
4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functional/=
futex_requeue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi_signal_restart.c ../include/futextest.h ../include/atomic.h ../incl=
ude/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fu=
tex/functional/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi_mismatched_ops.c ../include/futextest.h ../include/atomic.h ../incl=
ude/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fu=
tex/functional/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_uninitialized_heap.c ../include/futextest.h ../include/atomic.h ../includ=
e/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fute=
x/functional/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_private_mapped_file.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fut=
ex/functional/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/=
functional'
TAP version 13
1..1
# selftests: futex: run.sh
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
# ok 1 futex-requeue-pi-mismatched-ops
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# # 	Arguments: <none>
# ok 1 futex-requeue-pi-signal-restart
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_timeout: Block on a futex and wait for timeout
# # 	Arguments: timeout=3D100000ns
# ok 1 futex-wait-timeout
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
# ok 1 futex-wait-wouldblock
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_uninitialized_heap: Test the uninitialized futex value in FU=
TEX_WAIT
# ok 1 futex-wait-uninitialized-heap
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_wait_private_mapped_file: Test the futex value of private file ma=
ppings in FUTEX_WAIT
# ok 1 futex-wait-private-mapped-file
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: futex: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex'
2020-11-20 17:04:42 make -C ../../../tools/gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
mkdir -p include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027=
efc8d4214a4c8b11379cb28/tools/gpio/../../include/uapi/linux/gpio.h include/=
linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-utils
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-utils.o
  LD       gpio-utils-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       lsgpio.o
  LD       lsgpio-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-hamm=
er
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-hammer.o
  LD       gpio-hammer-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-even=
t-mon
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-event-mon.o
  LD       gpio-event-mon-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-event-mon
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-watch
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-watch.o
  LD       gpio-watch-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-watch
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
2020-11-20 17:04:43 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ -I/usr/include/lib=
mount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a=
4c8b11379cb28/tools/gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
TAP version 13
1..1
# selftests: gpio: gpio-mockup.sh
# 1.  Test dynamic allocation of gpio successful means insert gpiochip and
#     manipulate gpio pin successful
# GPIO gpio-mockup test with ranges: <-1,32>:=20
# -1,32     =20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....successful
# GPIO gpio-mockup test with ranges: <-1,32,-1,32>:=20
# -1,32,-1,32=20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....line<0>..=
=2E..line<31>.....line<6>.....successful
# GPIO gpio-mockup test with ranges: <-1,32,-1,32,-1,32>:=20
# -1,32,-1,32,-1,32=20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....line<0>..=
=2E..line<31>.....line<6>.....line<0>.....line<31>.....line<9>.....successf=
ul
# 3.  Error test: successful means insert gpiochip failed
# 3.1 Test number of gpio overflow
# GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
# -1,32,-1,1024=20
# gpio<gpio-mockup> test failed
# Test gpiochip gpio-mockup: GPIO test PASS
ok 1 selftests: gpio: gpio-mockup.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2020-11-20 17:04:45 make TARGETS=3Dia64
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
2020-11-20 17:04:46 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
TAP version 13
1..1
# selftests: ia64: aliasing-test
# PASS: /dev/mem 0x0-0xa0000 is readable
# PASS: /dev/mem 0xa0000-0xc0000 is mappable
# PASS: /dev/mem 0xc0000-0x100000 is readable
# PASS: /dev/mem 0x0-0x100000 is mappable
# PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 65534 bytes
# PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/03/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/03/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/03/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/03/00.0 0x0-0x100000 not mappable
ok 1 selftests: ia64: aliasing-test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
2020-11-20 17:04:47 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/intel_ps=
tate'
gcc  -Wall -D_GNU_SOURCE    msr.c -lm -o /usr/src/perf_selftests-x86_64-rhe=
l-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/sel=
ftests/intel_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c -lm -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/s=
elftests/intel_pstate/aperf
TAP version 13
1..1
# selftests: intel_pstate: run.sh
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# The marketing frequency of the cpu is 2600 MHz
# The maximum frequency of the cpu is  MHz
# The minimum frequency of the cpu is  MHz
# Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1 selftests: intel_pstate: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/intel_pst=
ate'
2020-11-20 17:04:48 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4=
214a4c8b11379cb28/tools/testing/selftests/ipc/msgque
TAP version 13
1..1
# selftests: ipc: msgque
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ipc: msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ipc'
LKP SKIP ir.ir_loopback_rcmm
2020-11-20 17:04:48 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ir'
gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28=
/tools/testing/selftests/ir/ir_loopback
TAP version 13
1..1
# selftests: ir: ir_loopback.sh
# Sending IR on rc1 and receiving IR on rc1.
# Testing protocol rc-5 for decoder rc-5 (1/18)...
# Testing scancode:1c41
# Testing scancode:220
# Testing scancode:3c
# Testing scancode:1903
# Testing scancode:a75
# Testing scancode:e51
# Testing scancode:a7a
# Testing scancode:162d
# Testing scancode:e1b
# Testing scancode:1d59
# OK
# Testing protocol rc-5x-20 for decoder rc-5 (2/18)...
# Testing scancode:11220a
# Testing scancode:e650a
# Testing scancode:193d29
# Testing scancode:156724
# Testing scancode:20c2f
# Testing scancode:c4103
# Testing scancode:94f26
# Testing scancode:1e1d01
# Testing scancode:121129
# Testing scancode:b3d1f
# OK
# Testing protocol rc-5-sz for decoder rc-5-sz (3/18)...
# Testing scancode:2654
# Testing scancode:22d
# Testing scancode:464
# Testing scancode:2ce8
# Testing scancode:278e
# Testing scancode:2011
# Testing scancode:2a33
# Testing scancode:29a3
# Testing scancode:9a7
# Testing scancode:25b9
# OK
# Testing protocol jvc for decoder jvc (4/18)...
# Testing scancode:3c16
# Testing scancode:6669
# Testing scancode:d859
# Testing scancode:dc52
# Testing scancode:3f6c
# Testing scancode:634e
# Testing scancode:6aa3
# Testing scancode:4a66
# Testing scancode:19fc
# Testing scancode:d8bf
# OK
# Testing protocol sony-12 for decoder sony (5/18)...
# Testing scancode:15003f
# Testing scancode:190046
# Testing scancode:b0049
# Testing scancode:e0029
# Testing scancode:f002a
# Testing scancode:d0078
# Testing scancode:1b002c
# Testing scancode:180010
# Testing scancode:b0079
# Testing scancode:d0055
# OK
# Testing protocol sony-15 for decoder sony (6/18)...
# Testing scancode:40030
# Testing scancode:a5004d
# Testing scancode:490002
# Testing scancode:720014
# Testing scancode:2f0036
# Testing scancode:9f0010
# Testing scancode:2d0026
# Testing scancode:b80069
# Testing scancode:f10033
# Testing scancode:44004d
# OK
# Testing protocol sony-20 for decoder sony (7/18)...
# Testing scancode:d7b22
# Testing scancode:dc84a
# Testing scancode:192536
# Testing scancode:8537b
# Testing scancode:12a41c
# Testing scancode:e6422
# Testing scancode:bb74a
# Testing scancode:f0f40
# Testing scancode:caf08
# Testing scancode:13d146
# OK
# Testing protocol nec for decoder nec (8/18)...
# Testing scancode:e7ff
# Testing scancode:3748
# Testing scancode:8d8c
# Testing scancode:2648
# Testing scancode:fcf1
# Testing scancode:3136
# Testing scancode:7140
# Testing scancode:841d
# Testing scancode:2447
# Testing scancode:59ba
# OK
# Testing protocol nec-x for decoder nec (9/18)...
# Testing scancode:3a1cf3
# Testing scancode:dad4f7
# Testing scancode:15f887
# Testing scancode:83c7f5
# Testing scancode:4d1a0b
# Testing scancode:45143d
# Testing scancode:232a86
# Testing scancode:7b0f31
# Testing scancode:fd1a26
# Testing scancode:14b6b9
# OK
# Testing protocol nec-32 for decoder nec (10/18)...
# Testing scancode:6bfcdff
# Testing scancode:2e0a95c8
# Testing scancode:1ba27f03
# Testing scancode:2e18f335
# Testing scancode:53b2e9c4
# Testing scancode:46d523a0
# Testing scancode:7a8757d8
# Testing scancode:6e5ea10e
# Testing scancode:4f8432e0
# Testing scancode:12d406e0
# OK
# Testing protocol sanyo for decoder sanyo (11/18)...
# Testing scancode:127254
# Testing scancode:101adf
# Testing scancode:163e28
# Testing scancode:1fffe0
# Testing scancode:74127
# Testing scancode:73b19
# Testing scancode:1d3116
# Testing scancode:bb267
# Testing scancode:13bf37
# Testing scancode:13555d
# OK
# Testing protocol rc-6-0 for decoder rc-6 (12/18)...
# Testing scancode:c21
# Testing scancode:dc2a
# Testing scancode:2a54
# Testing scancode:4a9
# Testing scancode:a41f
# Testing scancode:4460
# Testing scancode:18e6
# Testing scancode:cea5
# Testing scancode:5391
# Testing scancode:330d
# OK
# Testing protocol rc-6-6a-20 for decoder rc-6 (13/18)...
# Testing scancode:9855f
# Testing scancode:62190
# Testing scancode:ec8d5
# Testing scancode:c0462
# Testing scancode:f14c6
# Testing scancode:1b299
# Testing scancode:12802
# Testing scancode:66c9e
# Testing scancode:53a7
# Testing scancode:55ae2
# OK
# Testing protocol rc-6-6a-24 for decoder rc-6 (14/18)...
# Testing scancode:4a737e
# Testing scancode:c2c5fb
# Testing scancode:b575c1
# Testing scancode:b1a7
# Testing scancode:a2c5db
# Testing scancode:dcb6e8
# Testing scancode:e7ecc0
# Testing scancode:3ff6f2
# Testing scancode:a86950
# Testing scancode:1babf7
# OK
# Testing protocol rc-6-6a-32 for decoder rc-6 (15/18)...
# Testing scancode:42b34c4f
# Testing scancode:1ce47571
# Testing scancode:43898821
# Testing scancode:6f0176a4
# Testing scancode:1b367a1a
# Testing scancode:357b2c41
# Testing scancode:79cbb04
# Testing scancode:fcd9301
# Testing scancode:538ffae6
# Testing scancode:6ab30e95
# OK
# Testing protocol rc-6-mce for decoder rc-6 (16/18)...
# Testing scancode:800f460e
# Testing scancode:800f0045
# Testing scancode:800f3026
# Testing scancode:800f0ee3
# Testing scancode:800f04a8
# Testing scancode:800f44ec
# Testing scancode:800f417d
# Testing scancode:800f2caa
# Testing scancode:800f318a
# Testing scancode:800f1524
# OK
# Testing protocol sharp for decoder sharp (17/18)...
# Testing scancode:78d
# Testing scancode:508
# Testing scancode:1b20
# Testing scancode:1d4e
# Testing scancode:16af
# Testing scancode:fb
# Testing scancode:1437
# Testing scancode:370
# Testing scancode:17ed
# Testing scancode:1d87
# OK
# Testing protocol imon for decoder imon (18/18)...
# Testing scancode:3b3d6f67
# Testing scancode:7e5b643d
# Testing scancode:336b12f8
# Testing scancode:7ec6f789
# Testing scancode:6d5cdae1
# Testing scancode:4ea18d13
# Testing scancode:344223ca
# Testing scancode:74f995e5
# Testing scancode:5e6f2014
# Testing scancode:7d21eb0
# OK
# # Planned tests !=3D run tests (0 !=3D 180)
# # Totals: pass:180 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ir: ir_loopback.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ir'
2020-11-20 17:04:58 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/te=
sting/selftests/kcmp/kcmp_test
TAP version 13
1..1
# selftests: kcmp: kcmp_test
# pid1:  20876 pid2:  20877 FD:  2 FILES:  2 VM:  1 FS:  1 SIGHAND:  1 IO: =
 0 SYSVSEM:  0 INV: -1
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: kcmp: kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kcmp'
2020-11-20 17:04:58 make run_tests -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kexec'
TAP version 13
1..2
# selftests: kexec: test_kexec_load.sh
# [INFO] kexec_load is enabled
# [INFO] IMA enabled
# [INFO] IMA architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 1 selftests: kexec: test_kexec_load.sh # SKIP
# selftests: kexec: test_kexec_file_load.sh
# [INFO] kexec_file_load is enabled
# [INFO] IMA enabled
# [INFO] architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 2 selftests: kexec: test_kexec_file_load.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kexec'
kmod test: not in Makefile
2020-11-20 17:04:58 make TARGETS=3Dkmod
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
2020-11-20 17:05:00 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
TAP version 13
1..1
# selftests: kmod: kmod.sh
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #0
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #1
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #2
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:01 UTC 2020
# Running test: kmod_test_0002 - run #0
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:01 UTC 2020
# Running test: kmod_test_0002 - run #1
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:02 UTC 2020
# Running test: kmod_test_0002 - run #2
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:02 UTC 2020
# Running test: kmod_test_0003 - run #0
# kmod_test_0003: OK! - loading kmod test
# kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:03 UTC 2020
# Running test: kmod_test_0004 - run #0
# kmod_test_0004: OK! - loading kmod test
# kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:03 UTC 2020
# Running test: kmod_test_0005 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:04 UTC 2020
# Running test: kmod_test_0005 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:04 UTC 2020
# Running test: kmod_test_0005 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #5
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:06 UTC 2020
# Running test: kmod_test_0005 - run #6
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:06 UTC 2020
# Running test: kmod_test_0005 - run #7
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:07 UTC 2020
# Running test: kmod_test_0005 - run #8
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:07 UTC 2020
# Running test: kmod_test_0005 - run #9
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:08 UTC 2020
# Running test: kmod_test_0006 - run #0
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:09 UTC 2020
# Running test: kmod_test_0006 - run #1
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:10 UTC 2020
# Running test: kmod_test_0006 - run #2
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:12 UTC 2020
# Running test: kmod_test_0006 - run #3
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:14 UTC 2020
# Running test: kmod_test_0006 - run #4
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:15 UTC 2020
# Running test: kmod_test_0006 - run #5
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:17 UTC 2020
# Running test: kmod_test_0006 - run #6
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:19 UTC 2020
# Running test: kmod_test_0006 - run #7
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:20 UTC 2020
# Running test: kmod_test_0006 - run #8
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:22 UTC 2020
# Running test: kmod_test_0006 - run #9
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:23 UTC 2020
# Running test: kmod_test_0007 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:25 UTC 2020
# Running test: kmod_test_0007 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:27 UTC 2020
# Running test: kmod_test_0007 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:29 UTC 2020
# Running test: kmod_test_0007 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:32 UTC 2020
# Running test: kmod_test_0007 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #0
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #1
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #2
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #3
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #4
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #5
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #6
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #7
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #8
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #9
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #10
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #11
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #12
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #13
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #14
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #15
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #16
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #17
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #18
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #19
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #20
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #21
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #22
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #23
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #24
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #25
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #26
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #27
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #28
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #29
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #30
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #31
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #32
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #33
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #34
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #35
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #36
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #37
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #38
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #39
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #40
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #41
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #42
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #43
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #44
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #45
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #46
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #47
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #48
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #49
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #50
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #51
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #52
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #53
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #54
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #55
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #56
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #57
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #58
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #59
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #60
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #61
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #62
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #63
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #64
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #65
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #66
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #67
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #68
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #69
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #70
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #71
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #72
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #73
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #74
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #75
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #76
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #77
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #78
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #79
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #80
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #81
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #82
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #83
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #84
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #85
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #86
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #87
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #88
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #89
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #90
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #91
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #92
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #93
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #94
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #95
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #96
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #97
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #98
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #99
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #100
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #101
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #102
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #103
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #104
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #105
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #106
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #107
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #108
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #109
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #110
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #111
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #112
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #113
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #114
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #115
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #116
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #117
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #118
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #119
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #120
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #121
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #122
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #123
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #124
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #125
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #126
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #127
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #128
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #129
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #130
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #131
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #132
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #133
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #134
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #135
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #136
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #137
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #138
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #139
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #140
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #141
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #142
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #143
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #144
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #145
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #146
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #147
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #148
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:08 UTC 2020
# Running test: kmod_test_0008 - run #149
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:08 UTC 2020
# Running test: kmod_test_0009 - run #0
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:09 UTC 2020
# Running test: kmod_test_0009 - run #1
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:10 UTC 2020
# Running test: kmod_test_0009 - run #2
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:11 UTC 2020
# Running test: kmod_test_0009 - run #3
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:12 UTC 2020
# Running test: kmod_test_0009 - run #4
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:13 UTC 2020
# Running test: kmod_test_0009 - run #5
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:14 UTC 2020
# Running test: kmod_test_0009 - run #6
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:15 UTC 2020
# Running test: kmod_test_0009 - run #7
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:16 UTC 2020
# Running test: kmod_test_0009 - run #8
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:17 UTC 2020
# Running test: kmod_test_0009 - run #9
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:18 UTC 2020
# Running test: kmod_test_0009 - run #10
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:19 UTC 2020
# Running test: kmod_test_0009 - run #11
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:19 UTC 2020
# Running test: kmod_test_0009 - run #12
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:21 UTC 2020
# Running test: kmod_test_0009 - run #13
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:21 UTC 2020
# Running test: kmod_test_0009 - run #14
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:22 UTC 2020
# Running test: kmod_test_0009 - run #15
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:23 UTC 2020
# Running test: kmod_test_0009 - run #16
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:24 UTC 2020
# Running test: kmod_test_0009 - run #17
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:25 UTC 2020
# Running test: kmod_test_0009 - run #18
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:26 UTC 2020
# Running test: kmod_test_0009 - run #19
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:27 UTC 2020
# Running test: kmod_test_0009 - run #20
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:28 UTC 2020
# Running test: kmod_test_0009 - run #21
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:29 UTC 2020
# Running test: kmod_test_0009 - run #22
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:30 UTC 2020
# Running test: kmod_test_0009 - run #23
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:31 UTC 2020
# Running test: kmod_test_0009 - run #24
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:32 UTC 2020
# Running test: kmod_test_0009 - run #25
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:33 UTC 2020
# Running test: kmod_test_0009 - run #26
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:34 UTC 2020
# Running test: kmod_test_0009 - run #27
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:35 UTC 2020
# Running test: kmod_test_0009 - run #28
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:36 UTC 2020
# Running test: kmod_test_0009 - run #29
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:37 UTC 2020
# Running test: kmod_test_0009 - run #30
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:38 UTC 2020
# Running test: kmod_test_0009 - run #31
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:39 UTC 2020
# Running test: kmod_test_0009 - run #32
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:40 UTC 2020
# Running test: kmod_test_0009 - run #33
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:41 UTC 2020
# Running test: kmod_test_0009 - run #34
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:42 UTC 2020
# Running test: kmod_test_0009 - run #35
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:43 UTC 2020
# Running test: kmod_test_0009 - run #36
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:44 UTC 2020
# Running test: kmod_test_0009 - run #37
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:45 UTC 2020
# Running test: kmod_test_0009 - run #38
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:46 UTC 2020
# Running test: kmod_test_0009 - run #39
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:47 UTC 2020
# Running test: kmod_test_0009 - run #40
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:48 UTC 2020
# Running test: kmod_test_0009 - run #41
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:49 UTC 2020
# Running test: kmod_test_0009 - run #42
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:50 UTC 2020
# Running test: kmod_test_0009 - run #43
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:51 UTC 2020
# Running test: kmod_test_0009 - run #44
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:52 UTC 2020
# Running test: kmod_test_0009 - run #45
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:53 UTC 2020
# Running test: kmod_test_0009 - run #46
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:54 UTC 2020
# Running test: kmod_test_0009 - run #47
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:55 UTC 2020
# Running test: kmod_test_0009 - run #48
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:56 UTC 2020
# Running test: kmod_test_0009 - run #49
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0010 - run #0
# kmod_test_0010: OK! - loading kmod test
# kmod_test_0010: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0011 - run #0
# kmod_test_0011: OK! - loading kmod test
# kmod_test_0011: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0012 - run #0
# kmod_check_visibility: OK!
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0013 - run #0
# kmod_check_visibility: OK!
# Test completed
ok 1 selftests: kmod: kmod.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
2020-11-20 17:06:57 make run_tests -C lkdtm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm'
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/PANIC=
=2Esh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/BUG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WARNI=
NG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WARNI=
NG_MESSAGE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXCEP=
TION.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/LOOP.=
sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXHAU=
ST_STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_STACK_STRONG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_LIST_ADD.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_LIST_DEL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
_GUARD_PAGE_LEADING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
_GUARD_PAGE_TRAILING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/UNSET=
_SMEP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/DOUBL=
E_FAULT.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_PAC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/UNALI=
GNED_LOAD_STORE_WRITE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/OVERW=
RITE_ALLOCATION.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/READ_=
AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_BUDDY_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/READ_=
BUDDY_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_DOUBLE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_CROSS.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_PAGE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SOFTL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/HARDL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SPINL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/HUNG_=
TASK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
DATA.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
KMALLOC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
VMALLOC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
RODATA.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
USERSPACE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
NULL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ACCES=
S_USERSPACE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ACCES=
S_NULL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_RO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_RO_AFTER_INIT.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_KERN.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_NOT_ZERO_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_NOT_ZERO_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_AND_TEST_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_SUB_AND_TEST_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_NOT_ZERO_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_NOT_ZERO_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_AND_TEST_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_SUB_AND_TEST_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_TIMING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ATOMI=
C_TIMING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_SIZE_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_SIZE_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_WHITELIST_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_WHITELIST_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_FRAME_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_FRAME_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_BEYOND.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_KERNEL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
LEAK_ERASING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CFI_F=
ORWARD_PROTO.sh
TAP version 13
1..70
# selftests: lkdtm: PANIC.sh
# Skipping PANIC: crashes entire system
ok 1 selftests: lkdtm: PANIC.sh # SKIP
# selftests: lkdtm: BUG.sh
# [  540.206708] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/READ_AFTER_FREE.sh
#=20
# [  540.235516] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/WRITE_BUDDY_AFTER_FREE.sh
#=20
# BUG: missing 'kernel BUG at': [FAIL]
not ok 2 selftests: lkdtm: BUG.sh # exit=3D1
# selftests: lkdtm: WARNING.sh
# [  540.372541] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/SOFTLOCKUP.sh
#=20
# [  540.400297] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/HARDLOCKUP.sh
#=20
# [  540.428044] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/SPINLOCKUP.sh
#=20
# WARNING: missing 'WARNING:': [FAIL]
not ok 3 selftests: lkdtm: WARNING.sh # exit=3D1
# selftests: lkdtm: WARNING_MESSAGE.sh
# [  540.589467] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/EXEC_RODATA.sh
#=20
# [  540.617884] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/EXEC_USERSPACE.sh
#=20
# WARNING_MESSAGE: missing 'message trigger': [FAIL]
not ok 4 selftests: lkdtm: WARNING_MESSAGE.sh # exit=3D1
# selftests: lkdtm: EXCEPTION.sh
# [  540.780710] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/WRITE_KERN.sh
#=20
# [  540.808967] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_INC_OVERFLOW.sh
#=20
# EXCEPTION: missing 'call trace:': [FAIL]
not ok 5 selftests: lkdtm: EXCEPTION.sh # exit=3D1
# selftests: lkdtm: LOOP.sh
# Skipping LOOP: Hangs the system
ok 6 selftests: lkdtm: LOOP.sh # SKIP
# selftests: lkdtm: EXHAUST_STACK.sh
# Skipping EXHAUST_STACK: Corrupts memory on failure
ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
# selftests: lkdtm: CORRUPT_STACK.sh
# Skipping CORRUPT_STACK: Crashes entire system on success
ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
# selftests: lkdtm: CORRUPT_STACK_STRONG.sh
# Skipping CORRUPT_STACK_STRONG: Crashes entire system on success
ok 9 selftests: lkdtm: CORRUPT_STACK_STRONG.sh # SKIP
# selftests: lkdtm: CORRUPT_LIST_ADD.sh
# [  541.150054] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_ADD_SATURATED.sh
#=20
# [  541.179427] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_INC_NOT_ZERO_SATURATED.sh
#=20
# [  541.209534] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
#=20
# CORRUPT_LIST_ADD: missing 'list_add corruption': [FAIL]
not ok 10 selftests: lkdtm: CORRUPT_LIST_ADD.sh # exit=3D1
# selftests: lkdtm: CORRUPT_LIST_DEL.sh
# [  541.353328] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# [  541.382517] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_HEAP_SIZE_FROM.sh
#=20
# CORRUPT_LIST_DEL: missing 'list_del corruption': [FAIL]
not ok 11 selftests: lkdtm: CORRUPT_LIST_DEL.sh # exit=3D1
# selftests: lkdtm: STACK_GUARD_PAGE_LEADING.sh
# [  541.555081] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_KERNEL.sh
#=20
# [  541.583545] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/STACKLEAK_ERASING.sh
#=20
# STACK_GUARD_PAGE_LEADING: missing 'call trace:': [FAIL]
not ok 12 selftests: lkdtm: STACK_GUARD_PAGE_LEADING.sh # exit=3D1
# selftests: lkdtm: STACK_GUARD_PAGE_TRAILING.sh
# [  541.732224] # [  540.235516] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/WRITE_BUDDY_AFTER_FREE.sh
#=20
# [  541.758091] #=20
#=20
# [  541.765561] # BUG: missing 'kernel BUG at': [FAIL]
#=20
# [  541.776378] not ok 2 selftests: lkdtm: BUG.sh # exit=3D1
#=20
# [  541.787170] # selftests: lkdtm: WARNING.sh
#=20
# STACK_GUARD_PAGE_TRAILING: missing 'call trace:': [FAIL]
not ok 13 selftests: lkdtm: STACK_GUARD_PAGE_TRAILING.sh # exit=3D1
# selftests: lkdtm: UNSET_SMEP.sh
# [  541.917623] # selftests: lkdtm: WARNING_MESSAGE.sh
#=20
# [  541.931736] # [  540.589467] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/EXEC_RODATA.sh
#=20
# [  541.955342] #=20
#=20
# [  541.965850] # [  540.617884] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/EXEC_USERSPACE.sh
#=20
# UNSET_SMEP: missing 'CR4 bits went missing': [FAIL]
not ok 14 selftests: lkdtm: UNSET_SMEP.sh # exit=3D1
# selftests: lkdtm: DOUBLE_FAULT.sh
# Skipped: test 'DOUBLE_FAULT' missing in /sys/kernel/debug/provoke-crash/D=
IRECT!
ok 15 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
# selftests: lkdtm: CORRUPT_PAC.sh
# [  542.145050] # selftests: lkdtm: EXHAUST_STACK.sh
#=20
# [  542.155626] # Skipping EXHAUST_STACK: Corrupts memory on failure
#=20
# [  542.167478] ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
#=20
# [  542.178407] # selftests: lkdtm: CORRUPT_STACK.sh
#=20
# [  542.188817] # Skipping CORRUPT_STACK: Crashes entire system on success
#=20
# [  542.200938] ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
#=20
# CORRUPT_PAC: missing 'call trace:': [FAIL]
not ok 16 selftests: lkdtm: CORRUPT_PAC.sh # exit=3D1
# selftests: lkdtm: UNALIGNED_LOAD_STORE_WRITE.sh
# [  542.369231] #=20
#=20
# [  542.376631] # CORRUPT_LIST_ADD: missing 'list_add corruption': [FAIL]
#=20
# [  542.389013] not ok 10 selftests: lkdtm: CORRUPT_LIST_ADD.sh # exit=3D1
#=20
# [  542.400875] # selftests: lkdtm: CORRUPT_LIST_DEL.sh
#=20
# [  542.414951] # [  541.353328] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# UNALIGNED_LOAD_STORE_WRITE: missing 'call trace:': [FAIL]
not ok 17 selftests: lkdtm: UNALIGNED_LOAD_STORE_WRITE.sh # exit=3D1
# selftests: lkdtm: OVERWRITE_ALLOCATION.sh
# Skipping OVERWRITE_ALLOCATION: Corrupts memory on failure
ok 18 selftests: lkdtm: OVERWRITE_ALLOCATION.sh # SKIP
# selftests: lkdtm: WRITE_AFTER_FREE.sh
# Skipping WRITE_AFTER_FREE: Corrupts memory on failure
ok 19 selftests: lkdtm: WRITE_AFTER_FREE.sh # SKIP
# selftests: lkdtm: READ_AFTER_FREE.sh
# [  542.662391] #=20
#=20
# [  542.669706] # [  541.765561] # BUG: missing 'kernel BUG at': [FAIL]
#=20
# [  542.680573] #=20
#=20
# [  542.687877] # [  541.776378] not ok 2 selftests: lkdtm: BUG.sh # exit=
=3D1
#=20
# [  542.699148] #=20
#=20
# [  542.705991] # [  541.787170] # selftests: lkdtm: WARNING.sh
#=20
# [  542.715853] #=20
#=20
# [  542.722695] # STACK_GUARD_PAGE_TRAILING: missing 'call trace:': [FAIL]
#=20
# READ_AFTER_FREE: saw 'call trace:': ok
ok 20 selftests: lkdtm: READ_AFTER_FREE.sh
# selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh
# Skipping WRITE_BUDDY_AFTER_FREE: Corrupts memory on failure
ok 21 selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh # SKIP
# selftests: lkdtm: READ_BUDDY_AFTER_FREE.sh
# [  542.900122] ok 15 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
#=20
# [  542.910606] # selftests: lkdtm: CORRUPT_PAC.sh
#=20
# [  542.920201] # [  542.145050] # selftests: lkdtm: EXHAUST_STACK.sh
#=20
# [  542.930609] #=20
#=20
# [  542.937789] # [  542.155626] # Skipping EXHAUST_STACK: Corrupts memory=
 on failure
#=20
# [  542.949641] #=20
#=20
# [  542.957945] # [  542.167478] ok 7 selftests: lkdtm: EXHAUST_STACK.sh #=
 SKIP
#=20
# [  542.970464] #=20
#=20
# READ_BUDDY_AFTER_FREE: missing 'call trace:': [FAIL]
not ok 22 selftests: lkdtm: READ_BUDDY_AFTER_FREE.sh # exit=3D1
# selftests: lkdtm: SLAB_FREE_DOUBLE.sh
# [  543.105513] #=20
#=20
# [  543.112162] # [  542.400875] # selftests: lkdtm: CORRUPT_LIST_DEL.sh
#=20
# [  543.122654] #=20
#=20
# [  543.133225] # [  542.414951] # [  541.353328] install -m 0744 run.sh /=
usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d421=
4a4c8b11379cb28/tools/testing/selftests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# [  543.158109] #=20
#=20
# [  543.164581] # UNALIGNED_LOAD_STORE_WRITE: missing 'call trace:': [FAIL]
#=20
# SLAB_FREE_DOUBLE: saw 'call trace:': ok
ok 23 selftests: lkdtm: SLAB_FREE_DOUBLE.sh
# selftests: lkdtm: SLAB_FREE_CROSS.sh
# [  543.286915] #=20
#=20
# [  543.292709] # [  542.680573] #=20
#=20
# [  543.299745] #=20
#=20
# [  543.306892] # [  542.687877] # [  541.776378] not ok 2 selftests: lkdt=
m: BUG.sh # exit=3D1
#=20
# [  543.319329] #=20
#=20
# [  543.325151] # [  542.699148] #=20
#=20
# [  543.332033] #=20
#=20
# [  543.338874] # [  542.705991] # [  541.787170] # selftests: lkdtm: WARN=
ING.sh
#=20
# [  543.350001] #=20
#=20
# SLAB_FREE_CROSS: missing 'call trace:': [FAIL]
not ok 24 selftests: lkdtm: SLAB_FREE_CROSS.sh # exit=3D1
# selftests: lkdtm: SLAB_FREE_PAGE.sh
# [  543.482028] # [  542.920201] # [  542.145050] # selftests: lkdtm: EXHA=
UST_STACK.sh
#=20
# [  543.492851] #=20
#=20
# [  543.497958] # [  542.930609] #=20
#=20
# [  543.504162] #=20
#=20
# [  543.510720] # [  542.937789] # [  542.155626] # Skipping EXHAUST_STACK=
: Corrupts memory on failure
#=20
# [  543.523473] #=20
#=20
# [  543.528692] # [  542.949641] #=20
#=20
# [  543.535151] #=20
#=20
# [  543.541920] # [  542.957945] # [  542.167478] ok 7 selftests: lkdtm: E=
XHAUST_STACK.sh # SKIP
#=20
# SLAB_FREE_PAGE: missing 'call trace:': [FAIL]
not ok 25 selftests: lkdtm: SLAB_FREE_PAGE.sh # exit=3D1
# selftests: lkdtm: SOFTLOCKUP.sh
# Skipping SOFTLOCKUP: Hangs the system
ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
# selftests: lkdtm: HARDLOCKUP.sh
# Skipping HARDLOCKUP: Hangs the system
ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
# selftests: lkdtm: SPINLOCKUP.sh
# Skipping SPINLOCKUP: Hangs the system
ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
# selftests: lkdtm: HUNG_TASK.sh
# Skipping HUNG_TASK: Hangs the system
ok 29 selftests: lkdtm: HUNG_TASK.sh # SKIP
# selftests: lkdtm: EXEC_DATA.sh
# [  543.873836] not ok 24 selftests: lkdtm: SLAB_FREE_CROSS.sh # exit=3D1
#=20
# [  543.884589] # selftests: lkdtm: SLAB_FREE_PAGE.sh
#=20
# [  543.894518] # [  543.482028] # [  542.920201] # [  542.145050] # selft=
ests: lkdtm: EXHAUST_STACK.sh
#=20
# [  543.907399] #=20
#=20
# [  543.912961] # [  543.492851] #=20
#=20
# [  543.919434] #=20
#=20
# [  543.925286] # [  543.497958] # [  542.930609] #=20
#=20
# [  543.933415] #=20
#=20
# EXEC_DATA: missing 'call trace:': [FAIL]
not ok 30 selftests: lkdtm: EXEC_DATA.sh # exit=3D1
# selftests: lkdtm: EXEC_STACK.sh
# [  544.066345] ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
#=20
# [  544.076136] # selftests: lkdtm: HARDLOCKUP.sh
#=20
# [  544.085103] # Skipping HARDLOCKUP: Hangs the system
#=20
# [  544.094916] ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
#=20
# [  544.104337] # selftests: lkdtm: SPINLOCKUP.sh
#=20
# [  544.112711] # Skipping SPINLOCKUP: Hangs the system
#=20
# [  544.122131] ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
#=20
# EXEC_STACK: missing 'call trace:': [FAIL]
not ok 31 selftests: lkdtm: EXEC_STACK.sh # exit=3D1
# selftests: lkdtm: EXEC_KMALLOC.sh
# [  544.256879] #=20
#=20
# [  544.263361] # [  543.925286] # [  543.497958] # [  542.930609] #=20
#=20
# [  544.273447] #=20
#=20
# [  544.279137] # [  543.933415] #=20
#=20
# [  544.285915] #=20
#=20
# [  544.292073] # EXEC_DATA: missing 'call trace:': [FAIL]
#=20
# [  544.302024] not ok 30 selftests: lkdtm: EXEC_DATA.sh # exit=3D1
#=20
# [  544.312433] # selftests: lkdtm: EXEC_STACK.sh
#=20
# [  544.321977] # [  544.066345] ok 26 selftests: lkdtm: SOFTLOCKUP.sh # S=
KIP
#=20
# EXEC_KMALLOC: saw 'call trace:': ok
ok 32 selftests: lkdtm: EXEC_KMALLOC.sh
# selftests: lkdtm: EXEC_VMALLOC.sh
# [  544.453238] # selftests: lkdtm: EXEC_KMALLOC.sh
#=20
# [  544.461933] # [  544.256879] #=20
#=20
# [  544.468489] #=20
#=20
# [  544.475247] # [  544.263361] # [  543.925286] # [  543.497958] # [  54=
2.930609] #=20
#=20
# [  544.486645] #=20
#=20
# [  544.492232] # [  544.273447] #=20
#=20
# [  544.498928] #=20
#=20
# [  544.504645] # [  544.279137] # [  543.933415] #=20
#=20
# [  544.513088] #=20
#=20
# EXEC_VMALLOC: missing 'call trace:': [FAIL]
not ok 33 selftests: lkdtm: EXEC_VMALLOC.sh # exit=3D1
# selftests: lkdtm: EXEC_RODATA.sh
# [  544.647062] #=20
#=20
# [  544.652673] # [  544.468489] #=20
#=20
# [  544.659285] #=20
#=20
# [  544.666271] # [  544.475247] # [  544.263361] # [  543.925286] # [  54=
3.497958] # [  542.930609] #=20
#=20
# [  544.679353] #=20
#=20
# [  544.684834] # [  544.486645] #=20
#=20
# [  544.691346] #=20
#=20
# [  544.697182] # [  544.492232] # [  544.273447] #=20
#=20
# [  544.705384] #=20
#=20
# [  544.710821] # [  544.498928] #=20
#=20
# EXEC_RODATA: missing 'call trace:': [FAIL]
not ok 34 selftests: lkdtm: EXEC_RODATA.sh # exit=3D1
# selftests: lkdtm: EXEC_USERSPACE.sh
# [  544.842094] #=20
#=20
# [  544.847731] # [  544.684834] # [  544.486645] #=20
#=20
# [  544.855743] #=20
#=20
# [  544.860982] # [  544.691346] #=20
#=20
# [  544.867158] #=20
#=20
# [  544.873175] # [  544.697182] # [  544.492232] # [  544.273447] #=20
#=20
# [  544.882664] #=20
#=20
# [  544.888034] # [  544.705384] #=20
#=20
# [  544.894259] #=20
#=20
# [  544.899603] # [  544.710821] # [  544.498928] #=20
#=20
# [  544.907188] #=20
#=20
# EXEC_USERSPACE: missing 'call trace:': [FAIL]
not ok 35 selftests: lkdtm: EXEC_USERSPACE.sh # exit=3D1
# selftests: lkdtm: EXEC_NULL.sh
# [  545.039239] #=20
#=20
# [  545.044304] # [  544.894259] #=20
#=20
# [  545.050535] #=20
#=20
# [  545.056580] # [  544.899603] # [  544.710821] # [  544.498928] #=20
#=20
# [  545.065713] #=20
#=20
# [  545.070629] # [  544.907188] #=20
#=20
# [  545.076672] #=20
#=20
# [  545.082338] # EXEC_USERSPACE: missing 'call trace:': [FAIL]
#=20
# [  545.092495] not ok 35 selftests: lkdtm: EXEC_USERSPACE.sh # exit=3D1
#=20
# EXEC_NULL: saw 'call trace:': ok
ok 36 selftests: lkdtm: EXEC_NULL.sh
# selftests: lkdtm: ACCESS_USERSPACE.sh
# [  545.226085] #=20
#=20
# [  545.231466] # EXEC_NULL: saw 'call trace:': ok
#=20
# [  545.240088] ok 36 selftests: lkdtm: EXEC_NULL.sh
#=20
# [  545.248889] # selftests: lkdtm: ACCESS_USERSPACE.sh
#=20
# ACCESS_USERSPACE: saw 'call trace:': ok
ok 37 selftests: lkdtm: ACCESS_USERSPACE.sh
# selftests: lkdtm: ACCESS_NULL.sh
# ACCESS_NULL: missing 'call trace:': [FAIL]
not ok 38 selftests: lkdtm: ACCESS_NULL.sh # exit=3D1
# selftests: lkdtm: WRITE_RO.sh
# WRITE_RO: missing 'call trace:': [FAIL]
not ok 39 selftests: lkdtm: WRITE_RO.sh # exit=3D1
# selftests: lkdtm: WRITE_RO_AFTER_INIT.sh
# WRITE_RO_AFTER_INIT: missing 'call trace:': [FAIL]
not ok 40 selftests: lkdtm: WRITE_RO_AFTER_INIT.sh # exit=3D1
# selftests: lkdtm: WRITE_KERN.sh
# WRITE_KERN: missing 'call trace:': [FAIL]
not ok 41 selftests: lkdtm: WRITE_KERN.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_OVERFLOW.sh
# REFCOUNT_INC_OVERFLOW: missing 'call trace:': [FAIL]
not ok 42 selftests: lkdtm: REFCOUNT_INC_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_OVERFLOW.sh
# REFCOUNT_ADD_OVERFLOW: missing 'call trace:': [FAIL]
not ok 43 selftests: lkdtm: REFCOUNT_ADD_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
# REFCOUNT_INC_NOT_ZERO_OVERFLOW: missing 'call trace:': [FAIL]
not ok 44 selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
# REFCOUNT_ADD_NOT_ZERO_OVERFLOW: missing 'call trace:': [FAIL]
not ok 45 selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_ZERO.sh
# REFCOUNT_DEC_ZERO: missing 'call trace:': [FAIL]
not ok 46 selftests: lkdtm: REFCOUNT_DEC_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_NEGATIVE.sh
# REFCOUNT_DEC_NEGATIVE: missing 'Negative detected: saturated': [FAIL]
not ok 47 selftests: lkdtm: REFCOUNT_DEC_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
# REFCOUNT_DEC_AND_TEST_NEGATIVE: missing 'Negative detected: saturated': [=
FAIL]
not ok 48 selftests: lkdtm: REFCOUNT_DEC_AND_TEST_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
# REFCOUNT_SUB_AND_TEST_NEGATIVE: missing 'Negative detected: saturated': [=
FAIL]
not ok 49 selftests: lkdtm: REFCOUNT_SUB_AND_TEST_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_ZERO.sh
# REFCOUNT_INC_ZERO: missing 'call trace:': [FAIL]
not ok 50 selftests: lkdtm: REFCOUNT_INC_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_ZERO.sh
# REFCOUNT_ADD_ZERO: missing 'call trace:': [FAIL]
not ok 51 selftests: lkdtm: REFCOUNT_ADD_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_SATURATED.sh
# REFCOUNT_INC_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 52 selftests: lkdtm: REFCOUNT_INC_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_SATURATED.sh
# REFCOUNT_DEC_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 53 selftests: lkdtm: REFCOUNT_DEC_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_SATURATED.sh
# REFCOUNT_ADD_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 54 selftests: lkdtm: REFCOUNT_ADD_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_SATURATED.sh
# REFCOUNT_INC_NOT_ZERO_SATURATED: missing 'call trace:': [FAIL]
not ok 55 selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
# REFCOUNT_ADD_NOT_ZERO_SATURATED: missing 'call trace:': [FAIL]
not ok 56 selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_AND_TEST_SATURATED.sh
# REFCOUNT_DEC_AND_TEST_SATURATED: missing 'Saturation detected: still satu=
rated': [FAIL]
not ok 57 selftests: lkdtm: REFCOUNT_DEC_AND_TEST_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_SUB_AND_TEST_SATURATED.sh
# REFCOUNT_SUB_AND_TEST_SATURATED: missing 'Saturation detected: still satu=
rated': [FAIL]
not ok 58 selftests: lkdtm: REFCOUNT_SUB_AND_TEST_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_TIMING.sh
# Skipping REFCOUNT_TIMING: timing only
ok 59 selftests: lkdtm: REFCOUNT_TIMING.sh # SKIP
# selftests: lkdtm: ATOMIC_TIMING.sh
# Skipping ATOMIC_TIMING: timing only
ok 60 selftests: lkdtm: ATOMIC_TIMING.sh # SKIP
# selftests: lkdtm: USERCOPY_HEAP_SIZE_TO.sh
# USERCOPY_HEAP_SIZE_TO: missing 'call trace:': [FAIL]
not ok 61 selftests: lkdtm: USERCOPY_HEAP_SIZE_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_SIZE_FROM.sh
# USERCOPY_HEAP_SIZE_FROM: missing 'call trace:': [FAIL]
not ok 62 selftests: lkdtm: USERCOPY_HEAP_SIZE_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_WHITELIST_TO.sh
# USERCOPY_HEAP_WHITELIST_TO: missing 'call trace:': [FAIL]
not ok 63 selftests: lkdtm: USERCOPY_HEAP_WHITELIST_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_WHITELIST_FROM.sh
# USERCOPY_HEAP_WHITELIST_FROM: missing 'call trace:': [FAIL]
not ok 64 selftests: lkdtm: USERCOPY_HEAP_WHITELIST_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_FRAME_TO.sh
# USERCOPY_STACK_FRAME_TO: missing 'call trace:': [FAIL]
not ok 65 selftests: lkdtm: USERCOPY_STACK_FRAME_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_FRAME_FROM.sh
# USERCOPY_STACK_FRAME_FROM: missing 'call trace:': [FAIL]
not ok 66 selftests: lkdtm: USERCOPY_STACK_FRAME_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_BEYOND.sh
# USERCOPY_STACK_BEYOND: missing 'call trace:': [FAIL]
not ok 67 selftests: lkdtm: USERCOPY_STACK_BEYOND.sh # exit=3D1
# selftests: lkdtm: USERCOPY_KERNEL.sh
# USERCOPY_KERNEL: missing 'call trace:': [FAIL]
not ok 68 selftests: lkdtm: USERCOPY_KERNEL.sh # exit=3D1
# selftests: lkdtm: STACKLEAK_ERASING.sh
# STACKLEAK_ERASING: missing 'OK: the rest of the thread stack is properly =
erased': [FAIL]
not ok 69 selftests: lkdtm: STACKLEAK_ERASING.sh # exit=3D1
# selftests: lkdtm: CFI_FORWARD_PROTO.sh
# CFI_FORWARD_PROTO: missing 'call trace:': [FAIL]
not ok 70 selftests: lkdtm: CFI_FORWARD_PROTO.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm'
locking test: not in Makefile
2020-11-20 17:07:09 make TARGETS=3Dlocking
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locki=
ng'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lockin=
g'
2020-11-20 17:07:10 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locking'
TAP version 13
1..1
# selftests: locking: ww_mutex.sh
# locking/ww_mutex: [FAIL]
not ok 1 selftests: locking: ww_mutex.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locking'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Oliver Sang


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc4-00002-g4d9c16a4949b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_HSO=m
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_TTPCI_EEPROM=m
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-7.6-kselftests'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-nuc2/kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-nuc2'
	export tbox_group='lkp-skl-nuc2'
	export submit_id='5fb7f03bbfa2891021943942'
	export job_file='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4d9c16a4949b8b027efc8d4214a4c8b11379cb28-20201121-4129-vnq02z-2.yaml'
	export id='3843f6692a542f0102cdeca1f8343ac4251dda99'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY629600JP480F-part1'
	export brand='Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz'
	export commit='4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
	export netconsole_port=6675
	export ucode='0xe2'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_BTRFS_FS=m
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_DRM_DEBUG_SELFTEST=m ~ ">= v4.18-rc1"
CONFIG_EFIVAR_FS=y
CONFIG_EMBEDDED=y
CONFIG_EXPERT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_MOCKUP ~ ">= v4.9-rc1"
CONFIG_HIST_TRIGGERS=y ~ ">= v4.7-rc1"
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y ~ ">= v5.0-rc1"
CONFIG_IRQSOFF_TRACER=y
CONFIG_IR_IMON_DECODER=m ~ ">= v4.17-rc1"
CONFIG_IR_SHARP_DECODER=m
CONFIG_KALLSYMS_ALL=y
CONFIG_KPROBES=y
CONFIG_LIRC=y
CONFIG_LKDTM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PREEMPT=y
CONFIG_PREEMPTIRQ_DELAY_TEST=m ~ ">= v5.6-rc1"
CONFIG_PREEMPT_TRACER=y
CONFIG_SAMPLES=y
CONFIG_SAMPLE_FTRACE_DIRECT=m ~ ">= v5.5-rc1"
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SCHED_TRACER=y
CONFIG_SECURITYFS=y
CONFIG_STACK_TRACER=y
CONFIG_TEST_BITMAP
CONFIG_TEST_KMOD=m ~ ">= v4.13-rc1"
CONFIG_TEST_LKM=m
CONFIG_TEST_PRINTF
CONFIG_TEST_STRSCPY=m ~ ">= v5.2-rc1"
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TUN=m
CONFIG_WW_MUTEX_SELFTEST=m ~ ">= v4.11-rc1"
CONFIG_XFS_FS=m'
	export enqueue_time='2020-11-21 00:35:07 +0800'
	export _id='5fb7f046bfa2891021943943'
	export _rt='/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='18f412752047fb0c6874178efc98ae45a42bb79b'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-review/Giuseppe-Scrivano/fs-close_range-add-flag-CLOSE_RANGE_CLOEXEC/20201118-185135'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/3'
	export scheduler_version='/lkp/lkp/.src-20201120-230606'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4d9c16a4949b8b027efc8d4214a4c8b11379cb28-20201121-4129-vnq02z-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6-kselftests
branch=linux-review/Giuseppe-Scrivano/fs-close_range-add-flag-CLOSE_RANGE_CLOEXEC/20201118-185135
commit=4d9c16a4949b8b027efc8d4214a4c8b11379cb28
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/vmlinuz-5.10.0-rc4-00002-g4d9c16a4949b
kvm-intel.unrestricted_guest=0
max_uptime=3600
RESULT_ROOT=/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b5a583fb-1_20201015.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/linux-selftests.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.9.0-14757-g1c84550f47f3'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/vmlinuz-5.10.0-rc4-00002-g4d9c16a4949b'
	export dequeue_time='2020-11-21 00:57:21 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4d9c16a4949b8b027efc8d4214a4c8b11379cb28-20201121-4129-vnq02z-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-01' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--w3uUfsyyY1Pqa/ej
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28
2020-11-20 16:58:42 ln -sf /usr/bin/clang
2020-11-20 16:58:42 ln -sf /usr/bin/llc
2020-11-20 16:58:42 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2020-11-20 16:58:42 make run_tests -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/capabili=
ties'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8=
b11379cb28/tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c=
8b11379cb28/tools/testing/selftests/capabilities/validate_cap
TAP version 13
1..1
# selftests: capabilities: test_execve
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# TAP version 13
# 1..12
# # [RUN]	+++ Tests with uid =3D=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Root =3D> ep
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Root +i =3D> eip
# ok 6 Passed
# # [RUN]	UID 0 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Root +ia, suidroot =3D> eipa
# ok 8 Passed
# # [RUN]	Root +ia, suidnonroot =3D> ip
# ok 9 Passed
# # [RUN]	Root +ia, sgidroot =3D> eipa
# ok 10 Passed
# ok 11 Passed
# # [RUN]	Root +ia, sgidnonroot =3D> eip
# ok 12 Passed
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
# TAP version 13
# 1..9
# # [RUN]	+++ Tests with uid !=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Non-root =3D> no caps
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Non-root +i =3D> i
# ok 6 Passed
# # [RUN]	UID 1 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Non-root +ia, sgidnonroot =3D> i
# ok 8 Passed
# ok 9 Passed
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
ok 1 selftests: capabilities: test_execve
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/capabilit=
ies'
LKP SKIP cgroup
2020-11-20 16:58:42 make run_tests -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/clone3'
gcc -g -I../../../../usr/include/    clone3.c -lcap -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/too=
ls/testing/selftests/clone3/clone3
gcc -g -I../../../../usr/include/    clone3_clear_sighand.c -lcap -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8=
b11379cb28/tools/testing/selftests/clone3/clone3_clear_sighand
gcc -g -I../../../../usr/include/    clone3_set_tid.c -lcap -o /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379=
cb28/tools/testing/selftests/clone3/clone3_set_tid
gcc -g -I../../../../usr/include/    clone3_cap_checkpoint_restore.c -lcap =
-o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/clone3/clone3_cap_checkpoint_re=
store
TAP version 13
1..4
# selftests: clone3: clone3
# TAP version 13
# 1..17
# # clone3() syscall supported
# # [1354] Trying clone3() with flags 0 (size 0)
# # I am the parent (1354). My child's pid is 1355
# # [1354] clone3() with flags says: 0 expected 0
# ok 1 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 0)
# # I am the parent (1354). My child's pid is 1356
# # [1354] clone3() with flags says: 0 expected 0
# ok 2 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 64)
# # I am the parent (1354). My child's pid is 1357
# # [1354] clone3() with flags says: 0 expected 0
# ok 3 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 56)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 4 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 96)
# # I am the parent (1354). My child's pid is 1358
# # [1354] clone3() with flags says: 0 expected 0
# ok 5 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 6 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 7 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 8 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 9 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0 (size 96)
# # I am the parent (1354). My child's pid is 1359
# # [1354] clone3() with flags says: 0 expected 0
# ok 10 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0 (size 104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 11 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0 (size 176)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 12 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0 (size 4104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 13 [1354] Result (-7) matches expectation (-7)
# # [1354] Trying clone3() with flags 0x20000000 (size 64)
# # I am the parent (1354). My child's pid is 1360
# # [1354] clone3() with flags says: 0 expected 0
# ok 14 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 56)
# # Invalid argument - Failed to create new process
# # [1354] clone3() with flags says: -22 expected -22
# ok 15 [1354] Result (-22) matches expectation (-22)
# # [1354] Trying clone3() with flags 0x20000000 (size 96)
# # I am the parent (1354). My child's pid is 1361
# # [1354] clone3() with flags says: 0 expected 0
# ok 16 [1354] Result (0) matches expectation (0)
# # [1354] Trying clone3() with flags 0x20000000 (size 4104)
# # Argument list too long - Failed to create new process
# # [1354] clone3() with flags says: -7 expected -7
# ok 17 [1354] Result (-7) matches expectation (-7)
# # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: clone3: clone3
# selftests: clone3: clone3_clear_sighand
# TAP version 13
# 1..1
# # clone3() syscall supported
# ok 1 Cleared signal handlers for child process
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: clone3: clone3_clear_sighand
# selftests: clone3: clone3_set_tid
# TAP version 13
# 1..29
# # clone3() syscall supported
# # /proc/sys/kernel/pid_max 32768
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 1 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 2 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 3 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 4 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 5 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 6 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 7 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 8 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 9 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 10 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 11 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 12 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 13 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 14 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# # File exists - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
# ok 15 [1386] Result (-17) matches expectation (-17)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1386). My child's pid is 1387
# # [1386] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 16 [1386] Result (0) matches expectation (0)
# # [1386] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 17 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1386] Result (-22) matches expectation (-22)
# # Child has PID 1388
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x0
# # I am the child, my PID is 1388 (expected 1388)
# # I am the parent (1386). My child's pid is 1388
# # [1386] clone3() with CLONE_SET_TID 1388 says :0 - expected 0
# ok 19 [1386] Result (0) matches expectation (0)
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 20 [1386] Result (-22) matches expectation (-22)
# # [1386] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1386). My child's pid is 1388
# # [1386] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 21 [1386] Result (0) matches expectation (0)
# # unshare PID namespace
# # [1386] Trying clone3() with CLONE_SET_TID to 1388 and 0x0
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 22 [1386] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 43 says :-22 - expected -22
# ok 23 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # I am the child, my PID is 43 (expected 43)
# # I am the parent (1). My child's pid is 43
# # [1] clone3() with CLONE_SET_TID 43 says :0 - expected 0
# ok 24 [1] Result (0) matches expectation (0)
# # Child in PID namespace has PID 1
# # [1] Trying clone3() with CLONE_SET_TID to 2 and 0x0
# # I am the child, my PID is 2 (expected 2)
# # I am the parent (1). My child's pid is 2
# # [1] clone3() with CLONE_SET_TID 2 says :0 - expected 0
# ok 25 [1] Result (0) matches expectation (0)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 26 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 27 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # [1] Child is ready and waiting
# # I am the parent (1). My child's pid is 42
# # [1] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 28 [1] Result (0) matches expectation (0)
# # Invalid argument - Failed to create new process
# # [1386] clone3() with CLONE_SET_TID 1388 says :-22 - expected -22
# ok 22 [1386] Result (-22) matches expectation (-22)
# # [1386] Child is ready and waiting
# ok 29 PIDs in all namespaces as expected (1388,42,1)
# # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: clone3: clone3_set_tid
# selftests: clone3: clone3_cap_checkpoint_restore
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.clone3_cap_checkpoint_restore ...
# # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child=
 has PID 1404
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1403]=
 Trying clone3() with CLONE_SET_TID to 1404
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operat=
ion not permitted - Failed to create new process
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1403]=
 clone3() with CLONE_SET_TID 1404 says:-1
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1403]=
 Trying clone3() with CLONE_SET_TID to 1404
# # clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am t=
he parent (1403). My child's pid is 1404
# # clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am t=
he child, my PID is 1404 (expected 1404)
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1403]=
 clone3() with CLONE_SET_TID 1404 says:0
# #            OK  global.clone3_cap_checkpoint_restore
# ok 1 global.clone3_cap_checkpoint_restore
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: clone3: clone3_cap_checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/clone3'
2020-11-20 16:58:43 make run_tests -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core'
gcc -g -I../../../../usr/include/    close_range_test.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb2=
8/tools/testing/selftests/core/close_range_test
close_range_test.c: In function =E2=80=98close_range_unshare=E2=80=99:
close_range_test.c:122:19: warning: passing argument 1 of =E2=80=98sys_clon=
e3=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-types]
  pid =3D sys_clone3(&args, sizeof(args));
                   ^~~~~
In file included from close_range_test.c:17:
=2E./clone3/clone3_selftests.h:49:46: note: expected =E2=80=98struct __clon=
e_args *=E2=80=99 but argument is of type =E2=80=98struct clone_args *=E2=
=80=99
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
                         ~~~~~~~~~~~~~~~~~~~~~^~~~
close_range_test.c: In function =E2=80=98close_range_unshare_capped=E2=80=
=99:
close_range_test.c:211:19: warning: passing argument 1 of =E2=80=98sys_clon=
e3=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-types]
  pid =3D sys_clone3(&args, sizeof(args));
                   ^~~~~
In file included from close_range_test.c:17:
=2E./clone3/clone3_selftests.h:49:46: note: expected =E2=80=98struct __clon=
e_args *=E2=80=99 but argument is of type =E2=80=98struct clone_args *=E2=
=80=99
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
                         ~~~~~~~~~~~~~~~~~~~~~^~~~
close_range_test.c: In function =E2=80=98close_range_cloexec=E2=80=99:
close_range_test.c:244:5: warning: implicit declaration of function =E2=80=
=98XFAIL=E2=80=99 [-Wimplicit-function-declaration]
     XFAIL(return, "Skipping test since /dev/null does not exist");
     ^~~~~
close_range_test.c:244:11: error: expected expression before =E2=80=98retur=
n=E2=80=99
     XFAIL(return, "Skipping test since /dev/null does not exist");
           ^~~~~~
close_range_test.c:253:10: error: expected expression before =E2=80=98retur=
n=E2=80=99
    XFAIL(return, "close_range() syscall not supported");
          ^~~~~~
close_range_test.c:255:10: error: expected expression before =E2=80=98retur=
n=E2=80=99
    XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
          ^~~~~~
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core/clo=
se_range_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/core'
2020-11-20 16:58:43 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/cpu-hotp=
lug'
TAP version 13
1..1
# selftests: cpu-hotplug: cpu-on-off-test.sh
# pid 1480's current affinity mask: ff
# pid 1480's new affinity mask: 1
# CPU online/offline summary:
# present_cpus =3D 0-7 present_max =3D 7
# 	 Cpus in online state: 0-7
# 	 Cpus in offline state: 0
# Limited scope test: one hotplug cpu
# 	 (leaves cpu in the original state):
# 	 online to offline to online: cpu 7
ok 1 selftests: cpu-hotplug: cpu-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/cpu-hotpl=
ug'
dmabuf-heaps test: not in Makefile
2020-11-20 16:58:44 make TARGETS=3Ddmabuf-heaps
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabu=
f-heaps'
gcc -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include    dmabuf=
-heap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b=
8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-heaps/dmabuf-he=
ap
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf=
-heaps'
2020-11-20 16:59:14 make run_tests -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-h=
eaps'
TAP version 13
1..1
# selftests: dmabuf-heaps: dmabuf-heap
# No /dev/dma_heap directory?
not ok 1 selftests: dmabuf-heaps: dmabuf-heap # exit=3D255
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/dmabuf-he=
aps'
LKP SKIP efivarfs | no /sys/firmware/efi
2020-11-20 16:59:14 touch ./exec/pipe
2020-11-20 16:59:15 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec'
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    execveat.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/too=
ls/testing/selftests/exec/execveat
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000 -pie lo=
ad_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4=
949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_address_=
4096
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x200000 -pie =
load_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16=
a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_addres=
s_2097152
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000000 -pie=
 load_address.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/load_addre=
ss_16777216
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    recursion-depth.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379c=
b28/tools/testing/selftests/exec/recursion-depth
cd /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/exec && ln -s -f execveat execv=
eat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8=
d4214a4c8b11379cb28/tools/testing/selftests/exec/execveat /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/=
tools/testing/selftests/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16=
a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b0=
27efc8d4214a4c8b11379cb28/tools/testing/selftests/exec/subdir
TAP version 13
1..7
# selftests: exec: execveat
# /bin/sh: 0: Can't open /dev/fd/8/usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/=
exec/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyy
# Check success of execveat(5, '../execveat', 0)... [OK]
# Check success of execveat(7, 'execveat', 0)... [OK]
# Check success of execveat(9, 'execveat', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execv=
eat', 0)... [OK]
# Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
# Check success of execveat(11, '', 4096)... [OK]
# Check success of execveat(20, '', 4096)... [OK]
# Check success of execveat(12, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(18, '', 4096)... [OK]
# Check failure of execveat(11, '', 0) with ENOENT... [OK]
# Check failure of execveat(11, '(null)', 4096) with EFAULT... [OK]
# Check success of execveat(7, 'execveat.symlink', 0)... [OK]
# Check success of execveat(9, 'execveat.symlink', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.syml=
ink', 0)... [OK]
# Check success of execveat(13, '', 4096)... [OK]
# Check success of execveat(13, '', 4352)... [OK]
# Check failure of execveat(7, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(9, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests=
/exec/execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(7, 'pipe', 0) with EACCES... [OK]
# Check success of execveat(5, '../script', 0)... [OK]
# Check success of execveat(7, 'script', 0)... [OK]
# Check success of execveat(9, 'script', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scr=
ipt', 0)... [OK]
# Check success of execveat(16, '', 4096)... [OK]
# Check success of execveat(16, '', 4352)... [OK]
# Check failure of execveat(21, '', 4096) with ENOENT... [OK]
# Check failure of execveat(10, 'script', 0) with ENOENT... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check success of execveat(6, 'script', 0)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check failure of execveat(6, 'script', 0) with ENOENT... [OK]
# Check failure of execveat(7, 'execveat', 65535) with EINVAL... [OK]
# Check failure of execveat(7, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(9, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(7, '', 4096) with EACCES... [OK]
# Check failure of execveat(7, 'Makefile', 0) with EACCES... [OK]
# Check failure of execveat(14, '', 4096) with EACCES... [OK]
# Check failure of execveat(15, '', 4096) with EACCES... [OK]
# Check failure of execveat(99, '', 4096) with EBADF... [OK]
# Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
# Check failure of execveat(11, 'execveat', 0) with ENOTDIR... [OK]
# Invoke copy of 'execveat' via filename of length 4094:
# Check success of execveat(22, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
# Invoke copy of 'script' via filename of length 4094:
# Check success of execveat(23, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
ok 1 selftests: exec: execveat
# selftests: exec: load_address_4096
# PASS
ok 2 selftests: exec: load_address_4096
# selftests: exec: load_address_2097152
# PASS
ok 3 selftests: exec: load_address_2097152
# selftests: exec: load_address_16777216
# PASS
ok 4 selftests: exec: load_address_16777216
# selftests: exec: recursion-depth
ok 5 selftests: exec: recursion-depth
# selftests: exec: binfmt_script
# TAP version 1.3
# 1..27
# ok 1 - binfmt_script too-big (correctly failed bad exec)
# ok 2 - binfmt_script exact (correctly failed bad exec)
# ok 3 - binfmt_script exact-space (correctly failed bad exec)
# ok 4 - binfmt_script whitespace-too-big (correctly failed bad exec)
# ok 5 - binfmt_script truncated (correctly failed bad exec)
# ok 6 - binfmt_script empty (correctly failed bad exec)
# ok 7 - binfmt_script spaces (correctly failed bad exec)
# ok 8 - binfmt_script newline-prefix (correctly failed bad exec)
# ok 9 - binfmt_script test.pl (successful good exec)
# ok 10 - binfmt_script one-under (successful good exec)
# ok 11 - binfmt_script two-under (successful good exec)
# ok 12 - binfmt_script exact-trunc-whitespace (successful good exec)
# ok 13 - binfmt_script exact-trunc-arg (successful good exec)
# ok 14 - binfmt_script one-under-full-arg (successful good exec)
# ok 15 - binfmt_script one-under-no-nl (successful good exec)
# ok 16 - binfmt_script half-under-no-nl (successful good exec)
# ok 17 - binfmt_script one-under-trunc-arg (successful good exec)
# ok 18 - binfmt_script one-under-leading (successful good exec)
# ok 19 - binfmt_script one-under-leading-trunc-arg (successful good exec)
# ok 20 - binfmt_script two-under-no-nl (successful good exec)
# ok 21 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 22 - binfmt_script two-under-leading (successful good exec)
# ok 23 - binfmt_script two-under-leading-trunc-arg (successful good exec)
# ok 24 - binfmt_script two-under-no-nl (successful good exec)
# ok 25 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 26 - binfmt_script two-under-leading (successful good exec)
# ok 27 - binfmt_script two-under-lead-trunc-arg (successful good exec)
ok 6 selftests: exec: binfmt_script
# selftests: exec: non-regular
# Warning: file non-regular is missing!
not ok 7 selftests: exec: non-regular
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/exec'
LKP SKIP filesystems
2020-11-20 16:59:16 make run_tests -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu'
gcc     test_fpu.c -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu/test=
_fpu
TAP version 13
1..2
# selftests: fpu: test_fpu
# [SKIP]	can't access /sys/kernel/debug/selftest_helpers/test_fpu: No such =
file or directory
ok 1 selftests: fpu: test_fpu
# selftests: fpu: run_test_fpu.sh
# ./run_test_fpu.sh: You must have the following enabled in your kernel:
# CONFIG_TEST_FPU=3Dm
ok 2 selftests: fpu: run_test_fpu.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fpu'
2020-11-20 16:59:16 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove kprobe events	[PASS]
# [11] Generic dynamic event - add/remove synthetic events	[PASS]
# [12] Generic dynamic event - selective clear (compatibility)	[PASS]
# [13] Generic dynamic event - generic clear event	[PASS]
# [14] event tracing - enable/disable with event level files	[PASS]
# [15] event tracing - restricts events based on pid notrace filtering	[PAS=
S]
# [16] event tracing - restricts events based on pid	[PASS]
# [17] event tracing - enable/disable with subsystem level files	[PASS]
# [18] event tracing - enable/disable with top level files	[PASS]
# [19] Test trace_printk from module	[PASS]
# [20] ftrace - function graph filters with stack tracer	[PASS]
# [21] ftrace - function graph filters	[PASS]
# [22] ftrace - function glob filters	[PASS]
# [23] ftrace - function pid notrace filters	[PASS]
# [24] ftrace - function pid filters	[PASS]
# [25] ftrace - stacktrace filter command	[PASS]
# [26] ftrace - function trace with cpumask	[PASS]
# [27] ftrace - test for function event triggers	[PASS]
# [28] ftrace - function trace on module	[PASS]
# [29] ftrace - function profiling	[PASS]
# [30] ftrace - function profiler with function tracing	[PASS]
# [31] ftrace - test reading of set_ftrace_filter	[PASS]
# [32] ftrace - Max stack tracer	[PASS]
# [33] ftrace - test for function traceon/off triggers	[PASS]
# [34] ftrace - test tracing error log support	[PASS]
# [35] Test creation and deletion of trace instances while setting an event=
	[PASS]
# [36] Test creation and deletion of trace instances	[PASS]
# [37] Kprobe dynamic event - adding and removing	[PASS]
# [38] Kprobe dynamic event - busy event check	[PASS]
# [39] Kprobe dynamic event with arguments	[PASS]
# [40] Kprobe event with comm arguments	[PASS]
# [41] Kprobe event string type argument	[PASS]
# [42] Kprobe event symbol argument	[PASS]
# [43] Kprobe event argument syntax	[PASS]
# [44] Kprobes event arguments with types	[PASS]
# [45] Kprobe event user-memory access	[PASS]
# [46] Kprobe event auto/manual naming	[PASS]
# [47] Kprobe dynamic event with function tracer	[PASS]
# [48] Kprobe dynamic event - probing module	[PASS]
# [49] Create/delete multiprobe on kprobe event	[PASS]
# [50] Kprobe event parser error log check	[PASS]
# [51] Kretprobe dynamic event with arguments	[PASS]
# [52] Kretprobe dynamic event with maxactive	[PASS]
# [53] Kretprobe %return suffix test	[PASS]
# [54] Register/unregister many kprobe events	[PASS]
# [55] Kprobe events - probe points	[PASS]
# [56] Kprobe dynamic event - adding and removing	[PASS]
# [57] Uprobe event parser error log check	[PASS]
# [58] test for the preemptirqsoff tracer	[PASS]
# [59] Meta-selftest: Checkbashisms	[UNRESOLVED]
# [60] Test wakeup tracer	[PASS]
# [61] Test wakeup RT tracer	[PASS]
# [62] event trigger - test inter-event histogram trigger expected fail act=
ions	[XFAIL]
# [63] event trigger - test field variable support	[PASS]
# [64] event trigger - test inter-event combined histogram trigger	[PASS]
# [65] event trigger - test multiple actions on hist trigger	[PASS]
# [66] event trigger - test inter-event histogram trigger onchange action	[=
PASS]
# [67] event trigger - test inter-event histogram trigger onmatch action	[P=
ASS]
# [68] event trigger - test inter-event histogram trigger onmatch-onmax act=
ion	[PASS]
# [69] event trigger - test inter-event histogram trigger onmax action	[PAS=
S]
# [70] event trigger - test inter-event histogram trigger snapshot action	[=
PASS]
# [71] event trigger - test synthetic event create remove	[PASS]
# [72] event trigger - test inter-event histogram trigger trace action with=
 dynamic string param	[PASS]
# [73] event trigger - test synthetic_events syntax parser	[PASS]
# [74] event trigger - test synthetic_events syntax parser errors	[PASS]
# [75] event trigger - test inter-event histogram trigger trace action	[PAS=
S]
# [76] event trigger - test event enable/disable trigger	[PASS]
# [77] event trigger - test trigger filter	[PASS]
# [78] event trigger - test histogram modifiers	[PASS]
# [79] event trigger - test histogram parser errors	[PASS]
# [80] event trigger - test histogram trigger	[PASS]
# [81] event trigger - test multiple histogram triggers	[PASS]
# [82] event trigger - test snapshot-trigger	[PASS]
# [83] event trigger - test stacktrace-trigger	[PASS]
# [84] trace_marker trigger - test histogram trigger	[PASS]
# [85] trace_marker trigger - test snapshot trigger	[PASS]
# [86] trace_marker trigger - test histogram with synthetic event against k=
ernel event	[PASS]
# [87] trace_marker trigger - test histogram with synthetic event	[PASS]
# [88] event trigger - test traceon/off trigger	[PASS]
# [89] (instance)  Basic test for tracers	[PASS]
# [90] (instance)  Basic trace clock test	[PASS]
# [91] (instance)  Change the ringbuffer size	[PASS]
# [92] (instance)  Snapshot and tracing setting	[PASS]
# [93] (instance)  trace_pipe and trace_marker	[PASS]
# [94] (instance)  event tracing - enable/disable with event level files	[P=
ASS]
# [95] (instance)  event tracing - restricts events based on pid notrace fi=
ltering	[PASS]
# [96] (instance)  event tracing - restricts events based on pid	[PASS]
# [97] (instance)  event tracing - enable/disable with subsystem level file=
s	[PASS]
# [98] (instance)  ftrace - function pid notrace filters	[PASS]
# [99] (instance)  ftrace - function pid filters	[PASS]
# [100] (instance)  ftrace - stacktrace filter command	[PASS]
# [101] (instance)  ftrace - test for function event triggers	[PASS]
# [102] (instance)  ftrace - test for function traceon/off triggers	[PASS]
# [103] (instance)  event trigger - test event enable/disable trigger	[PASS]
# [104] (instance)  event trigger - test trigger filter	[PASS]
# [105] (instance)  event trigger - test histogram modifiers	[PASS]
# [106] (instance)  event trigger - test histogram trigger	[PASS]
# [107] (instance)  event trigger - test multiple histogram triggers	[PASS]
# [108] (instance)  trace_marker trigger - test histogram trigger	[PASS]
# [109] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
#=20
#=20
# # of passed:  107
# # of failed:  0
# # of unresolved:  1
# # of untested:  0
# # of unsupported:  0
# # of xfailed:  1
# # of undefined(test bug):  0
ok 1 selftests: ftrace: ftracetest
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ftrace'
2020-11-20 17:04:29 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex=
/functional'
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b=
027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_timeout.c ../include/futextest.h ../include/atomic.h ../include/logging.h=
 -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c1=
6a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functiona=
l/futex_wait_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_wouldblock.c ../include/futextest.h ../include/atomic.h ../include/loggin=
g.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d=
9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functi=
onal/futex_wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi.c ../include/futextest.h ../include/atomic.h ../include/logging.h -=
lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a=
4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/functional/=
futex_requeue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi_signal_restart.c ../include/futextest.h ../include/atomic.h ../incl=
ude/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fu=
tex/functional/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_req=
ueue_pi_mismatched_ops.c ../include/futextest.h ../include/atomic.h ../incl=
ude/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fu=
tex/functional/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_uninitialized_heap.c ../include/futextest.h ../include/atomic.h ../includ=
e/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fute=
x/functional/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../    futex_wai=
t_private_mapped_file.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h -lpthread -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/fut=
ex/functional/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex/=
functional'
TAP version 13
1..1
# selftests: futex: run.sh
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
# ok 1 futex-requeue-pi-mismatched-ops
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# # 	Arguments: <none>
# ok 1 futex-requeue-pi-signal-restart
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_timeout: Block on a futex and wait for timeout
# # 	Arguments: timeout=3D100000ns
# ok 1 futex-wait-timeout
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
# ok 1 futex-wait-wouldblock
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_uninitialized_heap: Test the uninitialized futex value in FU=
TEX_WAIT
# ok 1 futex-wait-uninitialized-heap
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_wait_private_mapped_file: Test the futex value of private file ma=
ppings in FUTEX_WAIT
# ok 1 futex-wait-private-mapped-file
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: futex: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/futex'
2020-11-20 17:04:42 make -C ../../../tools/gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
mkdir -p include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027=
efc8d4214a4c8b11379cb28/tools/gpio/../../include/uapi/linux/gpio.h include/=
linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-utils
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-utils.o
  LD       gpio-utils-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       lsgpio.o
  LD       lsgpio-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-hamm=
er
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-hammer.o
  LD       gpio-hammer-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-even=
t-mon
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-event-mon.o
  LD       gpio-event-mon-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-event-mon
make -f /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b02=
7efc8d4214a4c8b11379cb28/tools/build/Makefile.build dir=3D. obj=3Dgpio-watch
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  CC       gpio-watch.o
  LD       gpio-watch-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
  LINK     gpio-watch
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/gpio'
2020-11-20 17:04:43 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ -I/usr/include/lib=
mount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a=
4c8b11379cb28/tools/gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
TAP version 13
1..1
# selftests: gpio: gpio-mockup.sh
# 1.  Test dynamic allocation of gpio successful means insert gpiochip and
#     manipulate gpio pin successful
# GPIO gpio-mockup test with ranges: <-1,32>:=20
# -1,32     =20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....successful
# GPIO gpio-mockup test with ranges: <-1,32,-1,32>:=20
# -1,32,-1,32=20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....line<0>..=
=2E..line<31>.....line<6>.....successful
# GPIO gpio-mockup test with ranges: <-1,32,-1,32,-1,32>:=20
# -1,32,-1,32,-1,32=20
# Test gpiochip gpio-mockup: line<0>.....line<31>.....line<7>.....line<0>..=
=2E..line<31>.....line<6>.....line<0>.....line<31>.....line<9>.....successf=
ul
# 3.  Error test: successful means insert gpiochip failed
# 3.1 Test number of gpio overflow
# GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
# -1,32,-1,1024=20
# gpio<gpio-mockup> test failed
# Test gpiochip gpio-mockup: GPIO test PASS
ok 1 selftests: gpio: gpio-mockup.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2020-11-20 17:04:45 make TARGETS=3Dia64
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
2020-11-20 17:04:46 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
TAP version 13
1..1
# selftests: ia64: aliasing-test
# PASS: /dev/mem 0x0-0xa0000 is readable
# PASS: /dev/mem 0xa0000-0xc0000 is mappable
# PASS: /dev/mem 0xc0000-0x100000 is readable
# PASS: /dev/mem 0x0-0x100000 is mappable
# PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 65534 bytes
# PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/03/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/03/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/03/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.1 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/03/00.0 0x0-0x100000 not mappable
ok 1 selftests: ia64: aliasing-test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ia64'
2020-11-20 17:04:47 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/intel_ps=
tate'
gcc  -Wall -D_GNU_SOURCE    msr.c -lm -o /usr/src/perf_selftests-x86_64-rhe=
l-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/sel=
ftests/intel_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c -lm -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/s=
elftests/intel_pstate/aperf
TAP version 13
1..1
# selftests: intel_pstate: run.sh
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# The marketing frequency of the cpu is 2600 MHz
# The maximum frequency of the cpu is  MHz
# The minimum frequency of the cpu is  MHz
# Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1 selftests: intel_pstate: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/intel_pst=
ate'
2020-11-20 17:04:48 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4=
214a4c8b11379cb28/tools/testing/selftests/ipc/msgque
TAP version 13
1..1
# selftests: ipc: msgque
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ipc: msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ipc'
LKP SKIP ir.ir_loopback_rcmm
2020-11-20 17:04:48 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ir'
gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28=
/tools/testing/selftests/ir/ir_loopback
TAP version 13
1..1
# selftests: ir: ir_loopback.sh
# Sending IR on rc1 and receiving IR on rc1.
# Testing protocol rc-5 for decoder rc-5 (1/18)...
# Testing scancode:1c41
# Testing scancode:220
# Testing scancode:3c
# Testing scancode:1903
# Testing scancode:a75
# Testing scancode:e51
# Testing scancode:a7a
# Testing scancode:162d
# Testing scancode:e1b
# Testing scancode:1d59
# OK
# Testing protocol rc-5x-20 for decoder rc-5 (2/18)...
# Testing scancode:11220a
# Testing scancode:e650a
# Testing scancode:193d29
# Testing scancode:156724
# Testing scancode:20c2f
# Testing scancode:c4103
# Testing scancode:94f26
# Testing scancode:1e1d01
# Testing scancode:121129
# Testing scancode:b3d1f
# OK
# Testing protocol rc-5-sz for decoder rc-5-sz (3/18)...
# Testing scancode:2654
# Testing scancode:22d
# Testing scancode:464
# Testing scancode:2ce8
# Testing scancode:278e
# Testing scancode:2011
# Testing scancode:2a33
# Testing scancode:29a3
# Testing scancode:9a7
# Testing scancode:25b9
# OK
# Testing protocol jvc for decoder jvc (4/18)...
# Testing scancode:3c16
# Testing scancode:6669
# Testing scancode:d859
# Testing scancode:dc52
# Testing scancode:3f6c
# Testing scancode:634e
# Testing scancode:6aa3
# Testing scancode:4a66
# Testing scancode:19fc
# Testing scancode:d8bf
# OK
# Testing protocol sony-12 for decoder sony (5/18)...
# Testing scancode:15003f
# Testing scancode:190046
# Testing scancode:b0049
# Testing scancode:e0029
# Testing scancode:f002a
# Testing scancode:d0078
# Testing scancode:1b002c
# Testing scancode:180010
# Testing scancode:b0079
# Testing scancode:d0055
# OK
# Testing protocol sony-15 for decoder sony (6/18)...
# Testing scancode:40030
# Testing scancode:a5004d
# Testing scancode:490002
# Testing scancode:720014
# Testing scancode:2f0036
# Testing scancode:9f0010
# Testing scancode:2d0026
# Testing scancode:b80069
# Testing scancode:f10033
# Testing scancode:44004d
# OK
# Testing protocol sony-20 for decoder sony (7/18)...
# Testing scancode:d7b22
# Testing scancode:dc84a
# Testing scancode:192536
# Testing scancode:8537b
# Testing scancode:12a41c
# Testing scancode:e6422
# Testing scancode:bb74a
# Testing scancode:f0f40
# Testing scancode:caf08
# Testing scancode:13d146
# OK
# Testing protocol nec for decoder nec (8/18)...
# Testing scancode:e7ff
# Testing scancode:3748
# Testing scancode:8d8c
# Testing scancode:2648
# Testing scancode:fcf1
# Testing scancode:3136
# Testing scancode:7140
# Testing scancode:841d
# Testing scancode:2447
# Testing scancode:59ba
# OK
# Testing protocol nec-x for decoder nec (9/18)...
# Testing scancode:3a1cf3
# Testing scancode:dad4f7
# Testing scancode:15f887
# Testing scancode:83c7f5
# Testing scancode:4d1a0b
# Testing scancode:45143d
# Testing scancode:232a86
# Testing scancode:7b0f31
# Testing scancode:fd1a26
# Testing scancode:14b6b9
# OK
# Testing protocol nec-32 for decoder nec (10/18)...
# Testing scancode:6bfcdff
# Testing scancode:2e0a95c8
# Testing scancode:1ba27f03
# Testing scancode:2e18f335
# Testing scancode:53b2e9c4
# Testing scancode:46d523a0
# Testing scancode:7a8757d8
# Testing scancode:6e5ea10e
# Testing scancode:4f8432e0
# Testing scancode:12d406e0
# OK
# Testing protocol sanyo for decoder sanyo (11/18)...
# Testing scancode:127254
# Testing scancode:101adf
# Testing scancode:163e28
# Testing scancode:1fffe0
# Testing scancode:74127
# Testing scancode:73b19
# Testing scancode:1d3116
# Testing scancode:bb267
# Testing scancode:13bf37
# Testing scancode:13555d
# OK
# Testing protocol rc-6-0 for decoder rc-6 (12/18)...
# Testing scancode:c21
# Testing scancode:dc2a
# Testing scancode:2a54
# Testing scancode:4a9
# Testing scancode:a41f
# Testing scancode:4460
# Testing scancode:18e6
# Testing scancode:cea5
# Testing scancode:5391
# Testing scancode:330d
# OK
# Testing protocol rc-6-6a-20 for decoder rc-6 (13/18)...
# Testing scancode:9855f
# Testing scancode:62190
# Testing scancode:ec8d5
# Testing scancode:c0462
# Testing scancode:f14c6
# Testing scancode:1b299
# Testing scancode:12802
# Testing scancode:66c9e
# Testing scancode:53a7
# Testing scancode:55ae2
# OK
# Testing protocol rc-6-6a-24 for decoder rc-6 (14/18)...
# Testing scancode:4a737e
# Testing scancode:c2c5fb
# Testing scancode:b575c1
# Testing scancode:b1a7
# Testing scancode:a2c5db
# Testing scancode:dcb6e8
# Testing scancode:e7ecc0
# Testing scancode:3ff6f2
# Testing scancode:a86950
# Testing scancode:1babf7
# OK
# Testing protocol rc-6-6a-32 for decoder rc-6 (15/18)...
# Testing scancode:42b34c4f
# Testing scancode:1ce47571
# Testing scancode:43898821
# Testing scancode:6f0176a4
# Testing scancode:1b367a1a
# Testing scancode:357b2c41
# Testing scancode:79cbb04
# Testing scancode:fcd9301
# Testing scancode:538ffae6
# Testing scancode:6ab30e95
# OK
# Testing protocol rc-6-mce for decoder rc-6 (16/18)...
# Testing scancode:800f460e
# Testing scancode:800f0045
# Testing scancode:800f3026
# Testing scancode:800f0ee3
# Testing scancode:800f04a8
# Testing scancode:800f44ec
# Testing scancode:800f417d
# Testing scancode:800f2caa
# Testing scancode:800f318a
# Testing scancode:800f1524
# OK
# Testing protocol sharp for decoder sharp (17/18)...
# Testing scancode:78d
# Testing scancode:508
# Testing scancode:1b20
# Testing scancode:1d4e
# Testing scancode:16af
# Testing scancode:fb
# Testing scancode:1437
# Testing scancode:370
# Testing scancode:17ed
# Testing scancode:1d87
# OK
# Testing protocol imon for decoder imon (18/18)...
# Testing scancode:3b3d6f67
# Testing scancode:7e5b643d
# Testing scancode:336b12f8
# Testing scancode:7ec6f789
# Testing scancode:6d5cdae1
# Testing scancode:4ea18d13
# Testing scancode:344223ca
# Testing scancode:74f995e5
# Testing scancode:5e6f2014
# Testing scancode:7d21eb0
# OK
# # Planned tests !=3D run tests (0 !=3D 180)
# # Totals: pass:180 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ir: ir_loopback.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/ir'
2020-11-20 17:04:58 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/te=
sting/selftests/kcmp/kcmp_test
TAP version 13
1..1
# selftests: kcmp: kcmp_test
# pid1:  20876 pid2:  20877 FD:  2 FILES:  2 VM:  1 FS:  1 SIGHAND:  1 IO: =
 0 SYSVSEM:  0 INV: -1
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: kcmp: kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kcmp'
2020-11-20 17:04:58 make run_tests -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kexec'
TAP version 13
1..2
# selftests: kexec: test_kexec_load.sh
# [INFO] kexec_load is enabled
# [INFO] IMA enabled
# [INFO] IMA architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 1 selftests: kexec: test_kexec_load.sh # SKIP
# selftests: kexec: test_kexec_file_load.sh
# [INFO] kexec_file_load is enabled
# [INFO] IMA enabled
# [INFO] architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 2 selftests: kexec: test_kexec_file_load.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kexec'
kmod test: not in Makefile
2020-11-20 17:04:58 make TARGETS=3Dkmod
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
2020-11-20 17:05:00 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
TAP version 13
1..1
# selftests: kmod: kmod.sh
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #0
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #1
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:00 UTC 2020
# Running test: kmod_test_0001 - run #2
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:01 UTC 2020
# Running test: kmod_test_0002 - run #0
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:01 UTC 2020
# Running test: kmod_test_0002 - run #1
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:02 UTC 2020
# Running test: kmod_test_0002 - run #2
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Nov 20 17:05:02 UTC 2020
# Running test: kmod_test_0003 - run #0
# kmod_test_0003: OK! - loading kmod test
# kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:03 UTC 2020
# Running test: kmod_test_0004 - run #0
# kmod_test_0004: OK! - loading kmod test
# kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:03 UTC 2020
# Running test: kmod_test_0005 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:04 UTC 2020
# Running test: kmod_test_0005 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:04 UTC 2020
# Running test: kmod_test_0005 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:05 UTC 2020
# Running test: kmod_test_0005 - run #5
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:06 UTC 2020
# Running test: kmod_test_0005 - run #6
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:06 UTC 2020
# Running test: kmod_test_0005 - run #7
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:07 UTC 2020
# Running test: kmod_test_0005 - run #8
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:07 UTC 2020
# Running test: kmod_test_0005 - run #9
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:08 UTC 2020
# Running test: kmod_test_0006 - run #0
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:09 UTC 2020
# Running test: kmod_test_0006 - run #1
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:10 UTC 2020
# Running test: kmod_test_0006 - run #2
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:12 UTC 2020
# Running test: kmod_test_0006 - run #3
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:14 UTC 2020
# Running test: kmod_test_0006 - run #4
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:15 UTC 2020
# Running test: kmod_test_0006 - run #5
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:17 UTC 2020
# Running test: kmod_test_0006 - run #6
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:19 UTC 2020
# Running test: kmod_test_0006 - run #7
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:20 UTC 2020
# Running test: kmod_test_0006 - run #8
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:22 UTC 2020
# Running test: kmod_test_0006 - run #9
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:23 UTC 2020
# Running test: kmod_test_0007 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:25 UTC 2020
# Running test: kmod_test_0007 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:27 UTC 2020
# Running test: kmod_test_0007 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:29 UTC 2020
# Running test: kmod_test_0007 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:32 UTC 2020
# Running test: kmod_test_0007 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #0
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #1
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:35 UTC 2020
# Running test: kmod_test_0008 - run #2
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #3
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #4
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #5
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #6
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:36 UTC 2020
# Running test: kmod_test_0008 - run #7
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #8
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #9
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #10
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:37 UTC 2020
# Running test: kmod_test_0008 - run #11
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #12
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #13
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #14
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #15
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:38 UTC 2020
# Running test: kmod_test_0008 - run #16
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #17
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #18
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #19
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:39 UTC 2020
# Running test: kmod_test_0008 - run #20
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #21
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #22
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #23
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #24
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:40 UTC 2020
# Running test: kmod_test_0008 - run #25
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #26
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #27
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #28
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:41 UTC 2020
# Running test: kmod_test_0008 - run #29
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #30
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #31
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #32
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #33
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:42 UTC 2020
# Running test: kmod_test_0008 - run #34
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #35
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #36
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #37
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #38
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:43 UTC 2020
# Running test: kmod_test_0008 - run #39
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #40
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #41
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #42
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:44 UTC 2020
# Running test: kmod_test_0008 - run #43
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #44
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #45
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #46
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #47
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:45 UTC 2020
# Running test: kmod_test_0008 - run #48
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #49
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #50
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #51
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:46 UTC 2020
# Running test: kmod_test_0008 - run #52
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #53
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #54
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #55
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #56
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:47 UTC 2020
# Running test: kmod_test_0008 - run #57
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #58
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #59
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #60
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:48 UTC 2020
# Running test: kmod_test_0008 - run #61
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #62
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #63
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #64
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #65
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:49 UTC 2020
# Running test: kmod_test_0008 - run #66
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #67
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #68
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #69
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:50 UTC 2020
# Running test: kmod_test_0008 - run #70
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #71
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #72
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #73
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #74
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:51 UTC 2020
# Running test: kmod_test_0008 - run #75
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #76
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #77
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #78
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:52 UTC 2020
# Running test: kmod_test_0008 - run #79
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #80
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #81
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #82
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #83
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:53 UTC 2020
# Running test: kmod_test_0008 - run #84
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #85
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #86
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #87
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #88
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:54 UTC 2020
# Running test: kmod_test_0008 - run #89
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #90
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #91
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #92
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:55 UTC 2020
# Running test: kmod_test_0008 - run #93
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #94
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #95
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #96
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #97
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:56 UTC 2020
# Running test: kmod_test_0008 - run #98
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #99
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #100
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #101
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:57 UTC 2020
# Running test: kmod_test_0008 - run #102
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #103
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #104
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #105
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #106
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:58 UTC 2020
# Running test: kmod_test_0008 - run #107
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #108
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #109
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #110
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:05:59 UTC 2020
# Running test: kmod_test_0008 - run #111
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #112
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #113
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #114
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #115
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:00 UTC 2020
# Running test: kmod_test_0008 - run #116
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #117
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #118
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #119
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:01 UTC 2020
# Running test: kmod_test_0008 - run #120
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #121
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #122
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #123
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #124
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:02 UTC 2020
# Running test: kmod_test_0008 - run #125
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #126
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #127
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #128
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #129
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:03 UTC 2020
# Running test: kmod_test_0008 - run #130
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #131
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #132
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #133
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:04 UTC 2020
# Running test: kmod_test_0008 - run #134
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #135
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #136
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #137
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #138
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:05 UTC 2020
# Running test: kmod_test_0008 - run #139
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #140
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #141
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #142
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:06 UTC 2020
# Running test: kmod_test_0008 - run #143
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #144
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #145
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #146
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #147
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:07 UTC 2020
# Running test: kmod_test_0008 - run #148
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:08 UTC 2020
# Running test: kmod_test_0008 - run #149
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:08 UTC 2020
# Running test: kmod_test_0009 - run #0
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:09 UTC 2020
# Running test: kmod_test_0009 - run #1
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:10 UTC 2020
# Running test: kmod_test_0009 - run #2
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:11 UTC 2020
# Running test: kmod_test_0009 - run #3
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:12 UTC 2020
# Running test: kmod_test_0009 - run #4
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:13 UTC 2020
# Running test: kmod_test_0009 - run #5
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:14 UTC 2020
# Running test: kmod_test_0009 - run #6
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:15 UTC 2020
# Running test: kmod_test_0009 - run #7
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:16 UTC 2020
# Running test: kmod_test_0009 - run #8
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:17 UTC 2020
# Running test: kmod_test_0009 - run #9
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:18 UTC 2020
# Running test: kmod_test_0009 - run #10
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:19 UTC 2020
# Running test: kmod_test_0009 - run #11
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:19 UTC 2020
# Running test: kmod_test_0009 - run #12
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:21 UTC 2020
# Running test: kmod_test_0009 - run #13
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:21 UTC 2020
# Running test: kmod_test_0009 - run #14
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:22 UTC 2020
# Running test: kmod_test_0009 - run #15
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:23 UTC 2020
# Running test: kmod_test_0009 - run #16
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:24 UTC 2020
# Running test: kmod_test_0009 - run #17
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:25 UTC 2020
# Running test: kmod_test_0009 - run #18
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:26 UTC 2020
# Running test: kmod_test_0009 - run #19
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:27 UTC 2020
# Running test: kmod_test_0009 - run #20
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:28 UTC 2020
# Running test: kmod_test_0009 - run #21
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:29 UTC 2020
# Running test: kmod_test_0009 - run #22
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:30 UTC 2020
# Running test: kmod_test_0009 - run #23
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:31 UTC 2020
# Running test: kmod_test_0009 - run #24
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:32 UTC 2020
# Running test: kmod_test_0009 - run #25
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:33 UTC 2020
# Running test: kmod_test_0009 - run #26
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:34 UTC 2020
# Running test: kmod_test_0009 - run #27
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:35 UTC 2020
# Running test: kmod_test_0009 - run #28
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:36 UTC 2020
# Running test: kmod_test_0009 - run #29
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:37 UTC 2020
# Running test: kmod_test_0009 - run #30
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:38 UTC 2020
# Running test: kmod_test_0009 - run #31
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:39 UTC 2020
# Running test: kmod_test_0009 - run #32
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:40 UTC 2020
# Running test: kmod_test_0009 - run #33
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:41 UTC 2020
# Running test: kmod_test_0009 - run #34
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:42 UTC 2020
# Running test: kmod_test_0009 - run #35
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:43 UTC 2020
# Running test: kmod_test_0009 - run #36
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:44 UTC 2020
# Running test: kmod_test_0009 - run #37
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:45 UTC 2020
# Running test: kmod_test_0009 - run #38
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:46 UTC 2020
# Running test: kmod_test_0009 - run #39
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:47 UTC 2020
# Running test: kmod_test_0009 - run #40
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:48 UTC 2020
# Running test: kmod_test_0009 - run #41
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:49 UTC 2020
# Running test: kmod_test_0009 - run #42
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:50 UTC 2020
# Running test: kmod_test_0009 - run #43
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:51 UTC 2020
# Running test: kmod_test_0009 - run #44
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:52 UTC 2020
# Running test: kmod_test_0009 - run #45
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:53 UTC 2020
# Running test: kmod_test_0009 - run #46
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:54 UTC 2020
# Running test: kmod_test_0009 - run #47
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:55 UTC 2020
# Running test: kmod_test_0009 - run #48
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:56 UTC 2020
# Running test: kmod_test_0009 - run #49
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0010 - run #0
# kmod_test_0010: OK! - loading kmod test
# kmod_test_0010: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0011 - run #0
# kmod_test_0011: OK! - loading kmod test
# kmod_test_0011: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0012 - run #0
# kmod_check_visibility: OK!
# Fri Nov 20 17:06:57 UTC 2020
# Running test: kmod_test_0013 - run #0
# kmod_check_visibility: OK!
# Test completed
ok 1 selftests: kmod: kmod.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/kmod'
2020-11-20 17:06:57 make run_tests -C lkdtm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm'
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/PANIC=
=2Esh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/BUG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WARNI=
NG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WARNI=
NG_MESSAGE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXCEP=
TION.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/LOOP.=
sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXHAU=
ST_STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_STACK_STRONG.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_LIST_ADD.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_LIST_DEL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
_GUARD_PAGE_LEADING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
_GUARD_PAGE_TRAILING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/UNSET=
_SMEP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/DOUBL=
E_FAULT.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CORRU=
PT_PAC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/UNALI=
GNED_LOAD_STORE_WRITE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/OVERW=
RITE_ALLOCATION.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/READ_=
AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_BUDDY_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/READ_=
BUDDY_AFTER_FREE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_DOUBLE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_CROSS.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SLAB_=
FREE_PAGE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SOFTL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/HARDL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/SPINL=
OCKUP.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/HUNG_=
TASK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
DATA.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
STACK.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
KMALLOC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
VMALLOC.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
RODATA.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
USERSPACE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/EXEC_=
NULL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ACCES=
S_USERSPACE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ACCES=
S_NULL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_RO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_RO_AFTER_INIT.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/WRITE=
_KERN.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_NOT_ZERO_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_NOT_ZERO_OVERFLOW.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_AND_TEST_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_SUB_AND_TEST_NEGATIVE.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_ZERO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_INC_NOT_ZERO_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_ADD_NOT_ZERO_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_DEC_AND_TEST_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_SUB_AND_TEST_SATURATED.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/REFCO=
UNT_TIMING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/ATOMI=
C_TIMING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_SIZE_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_SIZE_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_WHITELIST_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_HEAP_WHITELIST_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_FRAME_TO.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_FRAME_FROM.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_STACK_BEYOND.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/USERC=
OPY_KERNEL.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/STACK=
LEAK_ERASING.sh
install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4=
d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm/CFI_F=
ORWARD_PROTO.sh
TAP version 13
1..70
# selftests: lkdtm: PANIC.sh
# Skipping PANIC: crashes entire system
ok 1 selftests: lkdtm: PANIC.sh # SKIP
# selftests: lkdtm: BUG.sh
# [  540.206708] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/READ_AFTER_FREE.sh
#=20
# [  540.235516] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/WRITE_BUDDY_AFTER_FREE.sh
#=20
# BUG: missing 'kernel BUG at': [FAIL]
not ok 2 selftests: lkdtm: BUG.sh # exit=3D1
# selftests: lkdtm: WARNING.sh
# [  540.372541] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/SOFTLOCKUP.sh
#=20
# [  540.400297] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/HARDLOCKUP.sh
#=20
# [  540.428044] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/SPINLOCKUP.sh
#=20
# WARNING: missing 'WARNING:': [FAIL]
not ok 3 selftests: lkdtm: WARNING.sh # exit=3D1
# selftests: lkdtm: WARNING_MESSAGE.sh
# [  540.589467] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/EXEC_RODATA.sh
#=20
# [  540.617884] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/EXEC_USERSPACE.sh
#=20
# WARNING_MESSAGE: missing 'message trigger': [FAIL]
not ok 4 selftests: lkdtm: WARNING_MESSAGE.sh # exit=3D1
# selftests: lkdtm: EXCEPTION.sh
# [  540.780710] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/WRITE_KERN.sh
#=20
# [  540.808967] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_INC_OVERFLOW.sh
#=20
# EXCEPTION: missing 'call trace:': [FAIL]
not ok 5 selftests: lkdtm: EXCEPTION.sh # exit=3D1
# selftests: lkdtm: LOOP.sh
# Skipping LOOP: Hangs the system
ok 6 selftests: lkdtm: LOOP.sh # SKIP
# selftests: lkdtm: EXHAUST_STACK.sh
# Skipping EXHAUST_STACK: Corrupts memory on failure
ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
# selftests: lkdtm: CORRUPT_STACK.sh
# Skipping CORRUPT_STACK: Crashes entire system on success
ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
# selftests: lkdtm: CORRUPT_STACK_STRONG.sh
# Skipping CORRUPT_STACK_STRONG: Crashes entire system on success
ok 9 selftests: lkdtm: CORRUPT_STACK_STRONG.sh # SKIP
# selftests: lkdtm: CORRUPT_LIST_ADD.sh
# [  541.150054] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_ADD_SATURATED.sh
#=20
# [  541.179427] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_INC_NOT_ZERO_SATURATED.sh
#=20
# [  541.209534] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
#=20
# CORRUPT_LIST_ADD: missing 'list_add corruption': [FAIL]
not ok 10 selftests: lkdtm: CORRUPT_LIST_ADD.sh # exit=3D1
# selftests: lkdtm: CORRUPT_LIST_DEL.sh
# [  541.353328] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# [  541.382517] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_HEAP_SIZE_FROM.sh
#=20
# CORRUPT_LIST_DEL: missing 'list_del corruption': [FAIL]
not ok 11 selftests: lkdtm: CORRUPT_LIST_DEL.sh # exit=3D1
# selftests: lkdtm: STACK_GUARD_PAGE_LEADING.sh
# [  541.555081] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/USERCOPY_KERNEL.sh
#=20
# [  541.583545] install -m 0744 run.sh /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/self=
tests/lkdtm/STACKLEAK_ERASING.sh
#=20
# STACK_GUARD_PAGE_LEADING: missing 'call trace:': [FAIL]
not ok 12 selftests: lkdtm: STACK_GUARD_PAGE_LEADING.sh # exit=3D1
# selftests: lkdtm: STACK_GUARD_PAGE_TRAILING.sh
# [  541.732224] # [  540.235516] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/WRITE_BUDDY_AFTER_FREE.sh
#=20
# [  541.758091] #=20
#=20
# [  541.765561] # BUG: missing 'kernel BUG at': [FAIL]
#=20
# [  541.776378] not ok 2 selftests: lkdtm: BUG.sh # exit=3D1
#=20
# [  541.787170] # selftests: lkdtm: WARNING.sh
#=20
# STACK_GUARD_PAGE_TRAILING: missing 'call trace:': [FAIL]
not ok 13 selftests: lkdtm: STACK_GUARD_PAGE_TRAILING.sh # exit=3D1
# selftests: lkdtm: UNSET_SMEP.sh
# [  541.917623] # selftests: lkdtm: WARNING_MESSAGE.sh
#=20
# [  541.931736] # [  540.589467] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/EXEC_RODATA.sh
#=20
# [  541.955342] #=20
#=20
# [  541.965850] # [  540.617884] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/EXEC_USERSPACE.sh
#=20
# UNSET_SMEP: missing 'CR4 bits went missing': [FAIL]
not ok 14 selftests: lkdtm: UNSET_SMEP.sh # exit=3D1
# selftests: lkdtm: DOUBLE_FAULT.sh
# Skipped: test 'DOUBLE_FAULT' missing in /sys/kernel/debug/provoke-crash/D=
IRECT!
ok 15 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
# selftests: lkdtm: CORRUPT_PAC.sh
# [  542.145050] # selftests: lkdtm: EXHAUST_STACK.sh
#=20
# [  542.155626] # Skipping EXHAUST_STACK: Corrupts memory on failure
#=20
# [  542.167478] ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
#=20
# [  542.178407] # selftests: lkdtm: CORRUPT_STACK.sh
#=20
# [  542.188817] # Skipping CORRUPT_STACK: Crashes entire system on success
#=20
# [  542.200938] ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
#=20
# CORRUPT_PAC: missing 'call trace:': [FAIL]
not ok 16 selftests: lkdtm: CORRUPT_PAC.sh # exit=3D1
# selftests: lkdtm: UNALIGNED_LOAD_STORE_WRITE.sh
# [  542.369231] #=20
#=20
# [  542.376631] # CORRUPT_LIST_ADD: missing 'list_add corruption': [FAIL]
#=20
# [  542.389013] not ok 10 selftests: lkdtm: CORRUPT_LIST_ADD.sh # exit=3D1
#=20
# [  542.400875] # selftests: lkdtm: CORRUPT_LIST_DEL.sh
#=20
# [  542.414951] # [  541.353328] install -m 0744 run.sh /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/t=
ools/testing/selftests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# UNALIGNED_LOAD_STORE_WRITE: missing 'call trace:': [FAIL]
not ok 17 selftests: lkdtm: UNALIGNED_LOAD_STORE_WRITE.sh # exit=3D1
# selftests: lkdtm: OVERWRITE_ALLOCATION.sh
# Skipping OVERWRITE_ALLOCATION: Corrupts memory on failure
ok 18 selftests: lkdtm: OVERWRITE_ALLOCATION.sh # SKIP
# selftests: lkdtm: WRITE_AFTER_FREE.sh
# Skipping WRITE_AFTER_FREE: Corrupts memory on failure
ok 19 selftests: lkdtm: WRITE_AFTER_FREE.sh # SKIP
# selftests: lkdtm: READ_AFTER_FREE.sh
# [  542.662391] #=20
#=20
# [  542.669706] # [  541.765561] # BUG: missing 'kernel BUG at': [FAIL]
#=20
# [  542.680573] #=20
#=20
# [  542.687877] # [  541.776378] not ok 2 selftests: lkdtm: BUG.sh # exit=
=3D1
#=20
# [  542.699148] #=20
#=20
# [  542.705991] # [  541.787170] # selftests: lkdtm: WARNING.sh
#=20
# [  542.715853] #=20
#=20
# [  542.722695] # STACK_GUARD_PAGE_TRAILING: missing 'call trace:': [FAIL]
#=20
# READ_AFTER_FREE: saw 'call trace:': ok
ok 20 selftests: lkdtm: READ_AFTER_FREE.sh
# selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh
# Skipping WRITE_BUDDY_AFTER_FREE: Corrupts memory on failure
ok 21 selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh # SKIP
# selftests: lkdtm: READ_BUDDY_AFTER_FREE.sh
# [  542.900122] ok 15 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
#=20
# [  542.910606] # selftests: lkdtm: CORRUPT_PAC.sh
#=20
# [  542.920201] # [  542.145050] # selftests: lkdtm: EXHAUST_STACK.sh
#=20
# [  542.930609] #=20
#=20
# [  542.937789] # [  542.155626] # Skipping EXHAUST_STACK: Corrupts memory=
 on failure
#=20
# [  542.949641] #=20
#=20
# [  542.957945] # [  542.167478] ok 7 selftests: lkdtm: EXHAUST_STACK.sh #=
 SKIP
#=20
# [  542.970464] #=20
#=20
# READ_BUDDY_AFTER_FREE: missing 'call trace:': [FAIL]
not ok 22 selftests: lkdtm: READ_BUDDY_AFTER_FREE.sh # exit=3D1
# selftests: lkdtm: SLAB_FREE_DOUBLE.sh
# [  543.105513] #=20
#=20
# [  543.112162] # [  542.400875] # selftests: lkdtm: CORRUPT_LIST_DEL.sh
#=20
# [  543.122654] #=20
#=20
# [  543.133225] # [  542.414951] # [  541.353328] install -m 0744 run.sh /=
usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4d9c16a4949b8b027efc8d421=
4a4c8b11379cb28/tools/testing/selftests/lkdtm/USERCOPY_HEAP_SIZE_TO.sh
#=20
# [  543.158109] #=20
#=20
# [  543.164581] # UNALIGNED_LOAD_STORE_WRITE: missing 'call trace:': [FAIL]
#=20
# SLAB_FREE_DOUBLE: saw 'call trace:': ok
ok 23 selftests: lkdtm: SLAB_FREE_DOUBLE.sh
# selftests: lkdtm: SLAB_FREE_CROSS.sh
# [  543.286915] #=20
#=20
# [  543.292709] # [  542.680573] #=20
#=20
# [  543.299745] #=20
#=20
# [  543.306892] # [  542.687877] # [  541.776378] not ok 2 selftests: lkdt=
m: BUG.sh # exit=3D1
#=20
# [  543.319329] #=20
#=20
# [  543.325151] # [  542.699148] #=20
#=20
# [  543.332033] #=20
#=20
# [  543.338874] # [  542.705991] # [  541.787170] # selftests: lkdtm: WARN=
ING.sh
#=20
# [  543.350001] #=20
#=20
# SLAB_FREE_CROSS: missing 'call trace:': [FAIL]
not ok 24 selftests: lkdtm: SLAB_FREE_CROSS.sh # exit=3D1
# selftests: lkdtm: SLAB_FREE_PAGE.sh
# [  543.482028] # [  542.920201] # [  542.145050] # selftests: lkdtm: EXHA=
UST_STACK.sh
#=20
# [  543.492851] #=20
#=20
# [  543.497958] # [  542.930609] #=20
#=20
# [  543.504162] #=20
#=20
# [  543.510720] # [  542.937789] # [  542.155626] # Skipping EXHAUST_STACK=
: Corrupts memory on failure
#=20
# [  543.523473] #=20
#=20
# [  543.528692] # [  542.949641] #=20
#=20
# [  543.535151] #=20
#=20
# [  543.541920] # [  542.957945] # [  542.167478] ok 7 selftests: lkdtm: E=
XHAUST_STACK.sh # SKIP
#=20
# SLAB_FREE_PAGE: missing 'call trace:': [FAIL]
not ok 25 selftests: lkdtm: SLAB_FREE_PAGE.sh # exit=3D1
# selftests: lkdtm: SOFTLOCKUP.sh
# Skipping SOFTLOCKUP: Hangs the system
ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
# selftests: lkdtm: HARDLOCKUP.sh
# Skipping HARDLOCKUP: Hangs the system
ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
# selftests: lkdtm: SPINLOCKUP.sh
# Skipping SPINLOCKUP: Hangs the system
ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
# selftests: lkdtm: HUNG_TASK.sh
# Skipping HUNG_TASK: Hangs the system
ok 29 selftests: lkdtm: HUNG_TASK.sh # SKIP
# selftests: lkdtm: EXEC_DATA.sh
# [  543.873836] not ok 24 selftests: lkdtm: SLAB_FREE_CROSS.sh # exit=3D1
#=20
# [  543.884589] # selftests: lkdtm: SLAB_FREE_PAGE.sh
#=20
# [  543.894518] # [  543.482028] # [  542.920201] # [  542.145050] # selft=
ests: lkdtm: EXHAUST_STACK.sh
#=20
# [  543.907399] #=20
#=20
# [  543.912961] # [  543.492851] #=20
#=20
# [  543.919434] #=20
#=20
# [  543.925286] # [  543.497958] # [  542.930609] #=20
#=20
# [  543.933415] #=20
#=20
# EXEC_DATA: missing 'call trace:': [FAIL]
not ok 30 selftests: lkdtm: EXEC_DATA.sh # exit=3D1
# selftests: lkdtm: EXEC_STACK.sh
# [  544.066345] ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
#=20
# [  544.076136] # selftests: lkdtm: HARDLOCKUP.sh
#=20
# [  544.085103] # Skipping HARDLOCKUP: Hangs the system
#=20
# [  544.094916] ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
#=20
# [  544.104337] # selftests: lkdtm: SPINLOCKUP.sh
#=20
# [  544.112711] # Skipping SPINLOCKUP: Hangs the system
#=20
# [  544.122131] ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
#=20
# EXEC_STACK: missing 'call trace:': [FAIL]
not ok 31 selftests: lkdtm: EXEC_STACK.sh # exit=3D1
# selftests: lkdtm: EXEC_KMALLOC.sh
# [  544.256879] #=20
#=20
# [  544.263361] # [  543.925286] # [  543.497958] # [  542.930609] #=20
#=20
# [  544.273447] #=20
#=20
# [  544.279137] # [  543.933415] #=20
#=20
# [  544.285915] #=20
#=20
# [  544.292073] # EXEC_DATA: missing 'call trace:': [FAIL]
#=20
# [  544.302024] not ok 30 selftests: lkdtm: EXEC_DATA.sh # exit=3D1
#=20
# [  544.312433] # selftests: lkdtm: EXEC_STACK.sh
#=20
# [  544.321977] # [  544.066345] ok 26 selftests: lkdtm: SOFTLOCKUP.sh # S=
KIP
#=20
# EXEC_KMALLOC: saw 'call trace:': ok
ok 32 selftests: lkdtm: EXEC_KMALLOC.sh
# selftests: lkdtm: EXEC_VMALLOC.sh
# [  544.453238] # selftests: lkdtm: EXEC_KMALLOC.sh
#=20
# [  544.461933] # [  544.256879] #=20
#=20
# [  544.468489] #=20
#=20
# [  544.475247] # [  544.263361] # [  543.925286] # [  543.497958] # [  54=
2.930609] #=20
#=20
# [  544.486645] #=20
#=20
# [  544.492232] # [  544.273447] #=20
#=20
# [  544.498928] #=20
#=20
# [  544.504645] # [  544.279137] # [  543.933415] #=20
#=20
# [  544.513088] #=20
#=20
# EXEC_VMALLOC: missing 'call trace:': [FAIL]
not ok 33 selftests: lkdtm: EXEC_VMALLOC.sh # exit=3D1
# selftests: lkdtm: EXEC_RODATA.sh
# [  544.647062] #=20
#=20
# [  544.652673] # [  544.468489] #=20
#=20
# [  544.659285] #=20
#=20
# [  544.666271] # [  544.475247] # [  544.263361] # [  543.925286] # [  54=
3.497958] # [  542.930609] #=20
#=20
# [  544.679353] #=20
#=20
# [  544.684834] # [  544.486645] #=20
#=20
# [  544.691346] #=20
#=20
# [  544.697182] # [  544.492232] # [  544.273447] #=20
#=20
# [  544.705384] #=20
#=20
# [  544.710821] # [  544.498928] #=20
#=20
# EXEC_RODATA: missing 'call trace:': [FAIL]
not ok 34 selftests: lkdtm: EXEC_RODATA.sh # exit=3D1
# selftests: lkdtm: EXEC_USERSPACE.sh
# [  544.842094] #=20
#=20
# [  544.847731] # [  544.684834] # [  544.486645] #=20
#=20
# [  544.855743] #=20
#=20
# [  544.860982] # [  544.691346] #=20
#=20
# [  544.867158] #=20
#=20
# [  544.873175] # [  544.697182] # [  544.492232] # [  544.273447] #=20
#=20
# [  544.882664] #=20
#=20
# [  544.888034] # [  544.705384] #=20
#=20
# [  544.894259] #=20
#=20
# [  544.899603] # [  544.710821] # [  544.498928] #=20
#=20
# [  544.907188] #=20
#=20
# EXEC_USERSPACE: missing 'call trace:': [FAIL]
not ok 35 selftests: lkdtm: EXEC_USERSPACE.sh # exit=3D1
# selftests: lkdtm: EXEC_NULL.sh
# [  545.039239] #=20
#=20
# [  545.044304] # [  544.894259] #=20
#=20
# [  545.050535] #=20
#=20
# [  545.056580] # [  544.899603] # [  544.710821] # [  544.498928] #=20
#=20
# [  545.065713] #=20
#=20
# [  545.070629] # [  544.907188] #=20
#=20
# [  545.076672] #=20
#=20
# [  545.082338] # EXEC_USERSPACE: missing 'call trace:': [FAIL]
#=20
# [  545.092495] not ok 35 selftests: lkdtm: EXEC_USERSPACE.sh # exit=3D1
#=20
# EXEC_NULL: saw 'call trace:': ok
ok 36 selftests: lkdtm: EXEC_NULL.sh
# selftests: lkdtm: ACCESS_USERSPACE.sh
# [  545.226085] #=20
#=20
# [  545.231466] # EXEC_NULL: saw 'call trace:': ok
#=20
# [  545.240088] ok 36 selftests: lkdtm: EXEC_NULL.sh
#=20
# [  545.248889] # selftests: lkdtm: ACCESS_USERSPACE.sh
#=20
# ACCESS_USERSPACE: saw 'call trace:': ok
ok 37 selftests: lkdtm: ACCESS_USERSPACE.sh
# selftests: lkdtm: ACCESS_NULL.sh
# ACCESS_NULL: missing 'call trace:': [FAIL]
not ok 38 selftests: lkdtm: ACCESS_NULL.sh # exit=3D1
# selftests: lkdtm: WRITE_RO.sh
# WRITE_RO: missing 'call trace:': [FAIL]
not ok 39 selftests: lkdtm: WRITE_RO.sh # exit=3D1
# selftests: lkdtm: WRITE_RO_AFTER_INIT.sh
# WRITE_RO_AFTER_INIT: missing 'call trace:': [FAIL]
not ok 40 selftests: lkdtm: WRITE_RO_AFTER_INIT.sh # exit=3D1
# selftests: lkdtm: WRITE_KERN.sh
# WRITE_KERN: missing 'call trace:': [FAIL]
not ok 41 selftests: lkdtm: WRITE_KERN.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_OVERFLOW.sh
# REFCOUNT_INC_OVERFLOW: missing 'call trace:': [FAIL]
not ok 42 selftests: lkdtm: REFCOUNT_INC_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_OVERFLOW.sh
# REFCOUNT_ADD_OVERFLOW: missing 'call trace:': [FAIL]
not ok 43 selftests: lkdtm: REFCOUNT_ADD_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
# REFCOUNT_INC_NOT_ZERO_OVERFLOW: missing 'call trace:': [FAIL]
not ok 44 selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
# REFCOUNT_ADD_NOT_ZERO_OVERFLOW: missing 'call trace:': [FAIL]
not ok 45 selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_ZERO.sh
# REFCOUNT_DEC_ZERO: missing 'call trace:': [FAIL]
not ok 46 selftests: lkdtm: REFCOUNT_DEC_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_NEGATIVE.sh
# REFCOUNT_DEC_NEGATIVE: missing 'Negative detected: saturated': [FAIL]
not ok 47 selftests: lkdtm: REFCOUNT_DEC_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
# REFCOUNT_DEC_AND_TEST_NEGATIVE: missing 'Negative detected: saturated': [=
FAIL]
not ok 48 selftests: lkdtm: REFCOUNT_DEC_AND_TEST_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
# REFCOUNT_SUB_AND_TEST_NEGATIVE: missing 'Negative detected: saturated': [=
FAIL]
not ok 49 selftests: lkdtm: REFCOUNT_SUB_AND_TEST_NEGATIVE.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_ZERO.sh
# REFCOUNT_INC_ZERO: missing 'call trace:': [FAIL]
not ok 50 selftests: lkdtm: REFCOUNT_INC_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_ZERO.sh
# REFCOUNT_ADD_ZERO: missing 'call trace:': [FAIL]
not ok 51 selftests: lkdtm: REFCOUNT_ADD_ZERO.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_SATURATED.sh
# REFCOUNT_INC_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 52 selftests: lkdtm: REFCOUNT_INC_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_SATURATED.sh
# REFCOUNT_DEC_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 53 selftests: lkdtm: REFCOUNT_DEC_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_SATURATED.sh
# REFCOUNT_ADD_SATURATED: missing 'Saturation detected: still saturated': [=
FAIL]
not ok 54 selftests: lkdtm: REFCOUNT_ADD_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_SATURATED.sh
# REFCOUNT_INC_NOT_ZERO_SATURATED: missing 'call trace:': [FAIL]
not ok 55 selftests: lkdtm: REFCOUNT_INC_NOT_ZERO_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
# REFCOUNT_ADD_NOT_ZERO_SATURATED: missing 'call trace:': [FAIL]
not ok 56 selftests: lkdtm: REFCOUNT_ADD_NOT_ZERO_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_DEC_AND_TEST_SATURATED.sh
# REFCOUNT_DEC_AND_TEST_SATURATED: missing 'Saturation detected: still satu=
rated': [FAIL]
not ok 57 selftests: lkdtm: REFCOUNT_DEC_AND_TEST_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_SUB_AND_TEST_SATURATED.sh
# REFCOUNT_SUB_AND_TEST_SATURATED: missing 'Saturation detected: still satu=
rated': [FAIL]
not ok 58 selftests: lkdtm: REFCOUNT_SUB_AND_TEST_SATURATED.sh # exit=3D1
# selftests: lkdtm: REFCOUNT_TIMING.sh
# Skipping REFCOUNT_TIMING: timing only
ok 59 selftests: lkdtm: REFCOUNT_TIMING.sh # SKIP
# selftests: lkdtm: ATOMIC_TIMING.sh
# Skipping ATOMIC_TIMING: timing only
ok 60 selftests: lkdtm: ATOMIC_TIMING.sh # SKIP
# selftests: lkdtm: USERCOPY_HEAP_SIZE_TO.sh
# USERCOPY_HEAP_SIZE_TO: missing 'call trace:': [FAIL]
not ok 61 selftests: lkdtm: USERCOPY_HEAP_SIZE_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_SIZE_FROM.sh
# USERCOPY_HEAP_SIZE_FROM: missing 'call trace:': [FAIL]
not ok 62 selftests: lkdtm: USERCOPY_HEAP_SIZE_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_WHITELIST_TO.sh
# USERCOPY_HEAP_WHITELIST_TO: missing 'call trace:': [FAIL]
not ok 63 selftests: lkdtm: USERCOPY_HEAP_WHITELIST_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_HEAP_WHITELIST_FROM.sh
# USERCOPY_HEAP_WHITELIST_FROM: missing 'call trace:': [FAIL]
not ok 64 selftests: lkdtm: USERCOPY_HEAP_WHITELIST_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_FRAME_TO.sh
# USERCOPY_STACK_FRAME_TO: missing 'call trace:': [FAIL]
not ok 65 selftests: lkdtm: USERCOPY_STACK_FRAME_TO.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_FRAME_FROM.sh
# USERCOPY_STACK_FRAME_FROM: missing 'call trace:': [FAIL]
not ok 66 selftests: lkdtm: USERCOPY_STACK_FRAME_FROM.sh # exit=3D1
# selftests: lkdtm: USERCOPY_STACK_BEYOND.sh
# USERCOPY_STACK_BEYOND: missing 'call trace:': [FAIL]
not ok 67 selftests: lkdtm: USERCOPY_STACK_BEYOND.sh # exit=3D1
# selftests: lkdtm: USERCOPY_KERNEL.sh
# USERCOPY_KERNEL: missing 'call trace:': [FAIL]
not ok 68 selftests: lkdtm: USERCOPY_KERNEL.sh # exit=3D1
# selftests: lkdtm: STACKLEAK_ERASING.sh
# STACKLEAK_ERASING: missing 'OK: the rest of the thread stack is properly =
erased': [FAIL]
not ok 69 selftests: lkdtm: STACKLEAK_ERASING.sh # exit=3D1
# selftests: lkdtm: CFI_FORWARD_PROTO.sh
# CFI_FORWARD_PROTO: missing 'call trace:': [FAIL]
not ok 70 selftests: lkdtm: CFI_FORWARD_PROTO.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lkdtm'
locking test: not in Makefile
2020-11-20 17:07:09 make TARGETS=3Dlocking
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locki=
ng'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/lockin=
g'
2020-11-20 17:07:10 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locking'
TAP version 13
1..1
# selftests: locking: ww_mutex.sh
# locking/ww_mutex: [FAIL]
not ok 1 selftests: locking: ww_mutex.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-4d9c16a4949b8b027efc8d4214a4c8b11379cb28/tools/testing/selftests/locking'

--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-7.6-kselftests
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: group-01
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-nuc2/kernel-selftests.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-nuc2
tbox_group: lkp-skl-nuc2
submit_id: 5fb7d0d2bfa2890c49c7e026
job_file: "/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4d9c16a4949b8b027efc8d4214a4c8b11379cb28-20201120-3145-1o5app0-0.yaml"
id: 3f4c9e1e5597bc574202d2255e1ccc6d92bf0589
queuer_version: "/lkp-src"

#! hosts/lkp-skl-nuc2
model: Skylake
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY629600JP480F-part1"
brand: Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: 4d9c16a4949b8b027efc8d4214a4c8b11379cb28

#! include/testbox/lkp-skl-nuc2
netconsole_port: 6675
ucode: '0xe2'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI

#! include/kernel-selftests
need_kernel_headers: true
need_kernel_selftests: true
need_kconfig:
- CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
- CONFIG_BTRFS_FS=m
- CONFIG_CHECKPOINT_RESTORE=y
- CONFIG_DRM_DEBUG_SELFTEST=m ~ ">= v4.18-rc1"
- CONFIG_EFIVAR_FS=y
- CONFIG_EMBEDDED=y
- CONFIG_EXPERT=y
- CONFIG_FTRACE=y
- CONFIG_FUNCTION_PROFILER=y
- CONFIG_GPIOLIB=y
- CONFIG_GPIO_MOCKUP ~ ">= v4.9-rc1"
- CONFIG_HIST_TRIGGERS=y ~ ">= v4.7-rc1"
- CONFIG_IMA_APPRAISE=y
- CONFIG_IMA_ARCH_POLICY=y ~ ">= v5.0-rc1"
- CONFIG_IRQSOFF_TRACER=y
- CONFIG_IR_IMON_DECODER=m ~ ">= v4.17-rc1"
- CONFIG_IR_SHARP_DECODER=m
- CONFIG_KALLSYMS_ALL=y
- CONFIG_KPROBES=y
- CONFIG_LIRC=y
- CONFIG_LKDTM=y
- CONFIG_MODULES=y
- CONFIG_MODULE_UNLOAD=y
- CONFIG_NOTIFIER_ERROR_INJECTION=y
- CONFIG_PREEMPT=y
- CONFIG_PREEMPTIRQ_DELAY_TEST=m ~ ">= v5.6-rc1"
- CONFIG_PREEMPT_TRACER=y
- CONFIG_SAMPLES=y
- CONFIG_SAMPLE_FTRACE_DIRECT=m ~ ">= v5.5-rc1"
- CONFIG_SAMPLE_TRACE_PRINTK=m
- CONFIG_SCHED_TRACER=y
- CONFIG_SECURITYFS=y
- CONFIG_STACK_TRACER=y
- CONFIG_TEST_BITMAP
- CONFIG_TEST_KMOD=m ~ ">= v4.13-rc1"
- CONFIG_TEST_LKM=m
- CONFIG_TEST_PRINTF
- CONFIG_TEST_STRSCPY=m ~ ">= v5.2-rc1"
- CONFIG_TRACER_SNAPSHOT=y
- CONFIG_TUN=m
- CONFIG_WW_MUTEX_SELFTEST=m ~ ">= v4.11-rc1"
- CONFIG_XFS_FS=m
enqueue_time: 2020-11-20 22:21:06.921372239 +08:00
_id: 5fb7d0d2bfa2890c49c7e026
_rt: "/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 18f412752047fb0c6874178efc98ae45a42bb79b
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: linux-devel/devel-hourly-2020111920
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/0"
scheduler_version: "/lkp/lkp/.src-20201120-103248"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4d9c16a4949b8b027efc8d4214a4c8b11379cb28-20201120-3145-1o5app0-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6-kselftests
- branch=linux-devel/devel-hourly-2020111920
- commit=4d9c16a4949b8b027efc8d4214a4c8b11379cb28
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/vmlinuz-5.10.0-rc4-00002-g4d9c16a4949b
- kvm-intel.unrestricted_guest=0
- max_uptime=3600
- RESULT_ROOT=/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b5a583fb-1_20201015.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/linux-selftests.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201119-155552/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc1-00019-gf78f63da916e
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4d9c16a4949b8b027efc8d4214a4c8b11379cb28/vmlinuz-5.10.0-rc4-00002-g4d9c16a4949b"
dequeue_time: 2020-11-20 22:54:01.850587122 +08:00

#! /lkp/lkp/.src-20201120-103248/include/site/inn
job_state: finished
loadavg: 9.73 5.93 2.57 1/222 2011
start_time: '1605884154'
end_time: '1605884666'
version: "/lkp/lkp/.src-20201120-103340:7892b977-dirty:6825b0140"

--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "ln" "-sf" "/usr/bin/clang"
 "ln" "-sf" "/usr/bin/llc"
 "sed" "-i" "s/default_timeout=45/default_timeout=300/" "kselftest/runner.sh"
 "make" "run_tests" "-C" "capabilities"
 "make" "run_tests" "-C" "clone3"
 "make" "run_tests" "-C" "core"
 "make" "run_tests" "-C" "cpu-hotplug"
 "make" "TARGETS=dmabuf-heaps"
 "make" "run_tests" "-C" "dmabuf-heaps"
 "touch" "./exec/pipe"
 "make" "run_tests" "-C" "exec"
 "make" "run_tests" "-C" "fpu"
 "make" "run_tests" "-C" "ftrace"
 "make" "run_tests" "-C" "futex"
 "make" "-C" "../../../tools/gpio"
 "make" "run_tests" "-C" "gpio"
 "make" "TARGETS=ia64"
 "make" "run_tests" "-C" "ia64"
 "make" "run_tests" "-C" "intel_pstate"
 "make" "run_tests" "-C" "ipc"
 "make" "run_tests" "-C" "ir"
 "make" "run_tests" "-C" "kcmp"
 "make" "run_tests" "-C" "kexec"
 "make" "TARGETS=kmod"
 "make" "run_tests" "-C" "kmod"
 "make" "run_tests" "-C" "lkdtm"
 "make" "TARGETS=locking"
 "make" "run_tests" "-C" "locking"

--w3uUfsyyY1Pqa/ej--
