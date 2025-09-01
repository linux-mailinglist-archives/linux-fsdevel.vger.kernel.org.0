Return-Path: <linux-fsdevel+bounces-59829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217EB3E423
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F8189F89D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92EA33470D;
	Mon,  1 Sep 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQpP1hz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7514AD20;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732249; cv=none; b=Yuy93KLU6m1bKKs+uUBXgQHjWGJzHWXsY76s2KIZ/Cixbl5fyZsYiHPX+X9ZaAxeMJBZKcVcIwd46EHhaIn/djH3b8S9vHZDyGWkXyXVIEZIy/E1O0FEWhsMBwrkXyJCVt0ElTkelC1M9EgfyGXaDrV+7CflwP5Ni5rOS446ZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732249; c=relaxed/simple;
	bh=l+zEh4GN06CwujvuIj3y3Fd32BGM/P2y+zLD4+u7l7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gVhAQq/Iba4I5xoh+vMPvbkydDCxDX/hwivFMODG8j6Cpp8hqTpKTQA00Nb805uM2JVtkUvE8QaBO4xfnNP+AlfxzN1qkMq/Ib2iqCQwnS8ct+sx7yxtjcl+rJ6PzQzPE3/CjWWcZDPSzJcoSJdsBoebuMvORdiH/hJ1SiLqLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQpP1hz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4A7C4CEF7;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732249;
	bh=l+zEh4GN06CwujvuIj3y3Fd32BGM/P2y+zLD4+u7l7M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KQpP1hz3p7pySlQA+S80YSRFmx1/RZzMbVqgwb6DJ7FII9WAZ2aC0Vkb2bY2IPIgo
	 5RCwWfOsqj6oH3/pX4lIDCuOOnNj9pXtQBn1tnrmIQEH+XVh9Y1PJP+hS509fIk0oM
	 7NnEVi31nSQ/8MpxGe34E6NqS5meKjX8tV7J4kEDUQj4qbBrjxI9QxaHniIUyy3yEY
	 gtjmo/KHVVgmCi45l9Q6BNFzV43IAWtjbRH902bx28dItj0RpqcveeXYME8ipfRIBt
	 uCZQnUdWBrjyoriL6ICoig8e7WsKXoloqJHchCd36LnqZQtWt5aeK+UBbdVHOc8NTG
	 YbdnooPnpDcUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481CCA1002;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Subject: [PATCH v2 0/4] nios2: Add architecture support for clone3
Date: Mon, 01 Sep 2025 15:09:49 +0200
Message-Id: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2btWgC/3WNzQqDMBCEX0Vy7pZkrT/05HsUD5quuqCJZEUq4
 rs3Sq89fsPMN7sSCkyinsmuAq0s7F0EvCXKDo3rCfgdWaHGTJemBMdeEHiaR5rILWBH7yiFosM
 MLeoy162K4zlQx59L/KojDyyLD9v1s5oz/SnR/FOuBjSYtsWHNkVa5E0lfBYEyFHot7v1k6qP4
 /gCMZ8FFcUAAAA=
X-Change-ID: 20250818-nios2-implement-clone3-7f252c20860b
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732247; l=6552;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=l+zEh4GN06CwujvuIj3y3Fd32BGM/P2y+zLD4+u7l7M=;
 b=GDpCexNrElu2yO/MxuDkpG+xctyQVH7o61ewBoPT3J8lEgMWXNxMsXtjVUaPsmeHSieQm4/hP
 49FpVyBe5rsBihPxAhRaNZH/1KUoHHYEsSlrwUEFI8iutPmfJs+jkNi
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

This series adds support for the clone3 system call to the nios2
architecture. This addresses the build-time warning "warning: clone3()
entry point is missing, please fix" introduced in 505d66d1abfb9
("clone3: drop __ARCH_WANT_SYS_CLONE3 macro"). The implementation passes
the relevant clone3 tests of kselftest when applied on top of
next-20250815:

	./run_kselftest.sh
	TAP version 13
	1..4
	# selftests: clone3: clone3
	ok 1 selftests: clone3: clone3
	# selftests: clone3: clone3_clear_sighand
	ok 2 selftests: clone3: clone3_clear_sighand
	# selftests: clone3: clone3_set_tid
	ok 3 selftests: clone3: clone3_set_tid
	# selftests: clone3: clone3_cap_checkpoint_restore
	ok 4 selftests: clone3: clone3_cap_checkpoint_restore

The series also includes a small patch to kernel/fork.c that ensures
that clone_flags are passed correctly on architectures where unsigned
long is insufficient to store the u64 clone_flags. It is marked as a fix
for stable backporting.

As requested, in v2, this series now further tries to correct this type
error throughout the whole code base. Thus, it now touches a larger
number of subsystems and all architectures.

Therefore, another test was performed for ARCH=x86_64 (as a
representative for 64-bit architectures). Here, the series builds cleanly
without warnings on defconfig with CONFIG_SECURITY_APPARMOR=y and
CONFIG_SECURITY_TOMOYO=y (to compile-check the LSM-related changes).
The build further successfully passes testing/selftests/clone3 (with the
patch from 20241105062948.1037011-1-zhouyuhang1010@163.com to prepare
clone3_cap_checkpoint_restore for compatibility with the newer libcap
version on my system).

Is there any option to further preflight check this patch series via
lkp/KernelCI/etc. for a broader test across architectures, or is this
degree of testing sufficient to eventually get the series merged?

N.B.: The series is not checkpatch clean right now:
 - include/linux/cred.h, include/linux/mnt_namespace.h:
   function definition arguments without identifier name
 - include/trace/events/task.h:
   space prohibited after that open parenthesis

I did not fix these warnings to keep my changes minimal and reviewable,
as the issues persist throughout the files and they were not introduced
by me; I only followed the existing code style and just replaced the
types. If desired, I'd be happy to make the changes in a potential v3,
though.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
Changes in v2:
- Introduce "Fixes:" and "Cc: stable@vger.kernel.org" where necessary
- Factor out "Fixes:" when adapting the datatype of clone_flags for
  easier backports
- Fix additional instances where `unsigned long` clone_flags is used
- Reword commit message to make it clearer that any 32-bit arch is
  affected by this bug
- Link to v1: https://lore.kernel.org/r/20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com

---
Simon Schuster (4):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)
      copy_process: pass clone_flags as u64 across calltree
      arch: copy_thread: pass clone_flags as u64
      nios2: implement architecture-specific portion of sys_clone3

 arch/alpha/kernel/process.c       |  2 +-
 arch/arc/kernel/process.c         |  2 +-
 arch/arm/kernel/process.c         |  2 +-
 arch/arm64/kernel/process.c       |  2 +-
 arch/csky/kernel/process.c        |  2 +-
 arch/hexagon/kernel/process.c     |  2 +-
 arch/loongarch/kernel/process.c   |  2 +-
 arch/m68k/kernel/process.c        |  2 +-
 arch/microblaze/kernel/process.c  |  2 +-
 arch/mips/kernel/process.c        |  2 +-
 arch/nios2/include/asm/syscalls.h |  1 +
 arch/nios2/include/asm/unistd.h   |  2 --
 arch/nios2/kernel/entry.S         |  6 ++++++
 arch/nios2/kernel/process.c       |  2 +-
 arch/nios2/kernel/syscall_table.c |  1 +
 arch/openrisc/kernel/process.c    |  2 +-
 arch/parisc/kernel/process.c      |  2 +-
 arch/powerpc/kernel/process.c     |  2 +-
 arch/riscv/kernel/process.c       |  2 +-
 arch/s390/kernel/process.c        |  2 +-
 arch/sh/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/process_32.c    |  2 +-
 arch/sparc/kernel/process_64.c    |  2 +-
 arch/um/kernel/process.c          |  2 +-
 arch/x86/include/asm/fpu/sched.h  |  2 +-
 arch/x86/include/asm/shstk.h      |  4 ++--
 arch/x86/kernel/fpu/core.c        |  2 +-
 arch/x86/kernel/process.c         |  2 +-
 arch/x86/kernel/shstk.c           |  2 +-
 arch/xtensa/kernel/process.c      |  2 +-
 block/blk-ioc.c                   |  2 +-
 fs/namespace.c                    |  2 +-
 include/linux/cgroup.h            |  4 ++--
 include/linux/cred.h              |  2 +-
 include/linux/iocontext.h         |  6 +++---
 include/linux/ipc_namespace.h     |  4 ++--
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/mnt_namespace.h     |  2 +-
 include/linux/nsproxy.h           |  2 +-
 include/linux/pid_namespace.h     |  4 ++--
 include/linux/rseq.h              |  4 ++--
 include/linux/sched/task.h        |  2 +-
 include/linux/security.h          |  4 ++--
 include/linux/sem.h               |  4 ++--
 include/linux/time_namespace.h    |  4 ++--
 include/linux/uprobes.h           |  4 ++--
 include/linux/user_events.h       |  4 ++--
 include/linux/utsname.h           |  4 ++--
 include/net/net_namespace.h       |  4 ++--
 include/trace/events/task.h       |  6 +++---
 ipc/namespace.c                   |  2 +-
 ipc/sem.c                         |  2 +-
 kernel/cgroup/namespace.c         |  2 +-
 kernel/cred.c                     |  2 +-
 kernel/events/uprobes.c           |  2 +-
 kernel/fork.c                     | 10 +++++-----
 kernel/nsproxy.c                  |  4 ++--
 kernel/pid_namespace.c            |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/fair.c               |  2 +-
 kernel/sched/sched.h              |  4 ++--
 kernel/time/namespace.c           |  2 +-
 kernel/utsname.c                  |  2 +-
 net/core/net_namespace.c          |  2 +-
 security/apparmor/lsm.c           |  2 +-
 security/security.c               |  2 +-
 security/selinux/hooks.c          |  2 +-
 security/tomoyo/tomoyo.c          |  2 +-
 68 files changed, 95 insertions(+), 89 deletions(-)
---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250818-nios2-implement-clone3-7f252c20860b

Best regards,
-- 
Simon Schuster <schuster.simon@siemens-energy.com>



