Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5E4E8A53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Mar 2022 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiC0VzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0VzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:55:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99ADF56;
        Sun, 27 Mar 2022 14:53:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so21722268lfg.7;
        Sun, 27 Mar 2022 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcwNLYwZ7bURxu0mYhytH28IsqhfVn5VBmqlzKk76+8=;
        b=P7XdIdmYBEWFU29sRDP7d1LdSpACUDNEpkq9lBuHu5LhDbPvK2pLtYw7F1QUQZEEKA
         iMa4YyPd8mqLAF0flgAyIcmnCiSauc1hSH4aHRMGzRpHXx0LcCJG+ud+WRpHlHWAawD7
         jQOpkVHx7JzT6pU2Ajowets6kIwJM8RMeB1ABlCSB+a0XvFdZ7ZoGN/CWthyTrqeEniY
         3ww4pXLSGinod9jBnsU8EBZWW1pl1T5FmASyeTBi2Q1OHhJeYqlArFdTKa5c0dIhCT9V
         EY2AMd/FPk+m/e9SC4DZe3PgJabqbN8hPBQPs11jMVZyF/2rkiOfHNZ3VIivHaOLif/7
         k0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcwNLYwZ7bURxu0mYhytH28IsqhfVn5VBmqlzKk76+8=;
        b=Qc9zo2W+IDEF7RBdAfojG3y7ikNPe95SjMf+Xk6WvzVbZhBro71ZZn4l2JJfSW+4GL
         7AhU/GCRlQ0MU6EIanP5cjtjRCj+kG9GVVjKPP7FJI6XWfdVVWas11dwNfOk2qjISrG+
         +MrcSZ/eh+rrVfEpX3ypwsoeFw2iXWfIAu5ZLZILWFtW991CobzkOI3RdUSFsdZL070w
         udh/VOeo5SIKqUYYLvAMf+Y3TIIW2vZ6yxwG1H+ZvYwMOpNUgcrkffvKYDJwcrCxH3y8
         HaNv0rg8cRehqalC++qNLWB4EaAiydAdHN9E3vdHu9An0DOCJtehwwH3sy+6ODkoM0f5
         s8/A==
X-Gm-Message-State: AOAM533n/TN7O8Nu2lMJX/vJbbfv1Vtdq412RebujzEDWYwyk7O2c338
        M3R0GFC6kKcVy2/faQ9/QLQ=
X-Google-Smtp-Source: ABdhPJyUKyyb7X/m65283V6CaZwgKgBxH/00XKnBPRchgG1cHaTi4AmUAnea1HiSH2yLcrL5l13tfw==
X-Received: by 2002:a05:6512:38a9:b0:443:3b0a:9cec with SMTP id o9-20020a05651238a900b004433b0a9cecmr16753688lft.12.1648418012611;
        Sun, 27 Mar 2022 14:53:32 -0700 (PDT)
Received: from fedor-zhuzhzhalka67.localnet (109-252-148-208.dynamic.spd-mgts.ru. [109.252.148.208])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e7a01000000b0024ac272d727sm757559ljc.79.2022.03.27.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 14:53:31 -0700 (PDT)
From:   aissur0002@gmail.com
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Date:   Mon, 28 Mar 2022 00:54:57 +0300
Message-ID: <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
In-Reply-To: <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
References: <20220326114009.1690-1-aissur0002@gmail.com> <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com> <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart14592308.tv2OnDr8pf"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart14592308.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I am sorry, that was my first attempt to contribute to the kernel and
I messed up a little bit with the patch tag: it is actually a single, 
standalone patch and there has been nothing posted previously.

Moreover, I should have provided you with the context of discovering 
the bug: a Syzkaller bug reproducer and CrashReport are attached to 
the mail.

In few words, an error occurs while executing close_range() call with
CLOSE_RANGE_UNSHARE flag: in __close_range() the value of
max_unshare_fds (later used as max_fds in dup_fd() and copy_fd_bitmaps())
can be an arbitrary number.

  if (max_fd >= last_fd(files_fdtable(cur_fds)))
    max_unshare_fds = fd;

and not be a multiple of BITS_PER_LONG or BITS_PER_BYTE. In case of
Syzkaller reproducer this value equals 69 - three standard file descriptors, 
66 pipe descriptors and 1 for /dev/ptmx; nr value used in alloc_fdtable()
is 128 (that' okay). But here is the weird place which causes the leak
described in the patch. KASAN detected that leak and possibly the
location of the leak is in copy_fd_bitmaps(): I experimented with
possible solutions and if add_byte logic is implemented, then KASAN does 
not find any leaks. Of course, the problem can be somewhere else and I 
don't notice it.

On Sat, Mar 26, 2022 at 3:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Certainly NR_OPEN_DEFAULT, sane_fdtable_size() and max_fds should
> always be a multiple of BITS_PER_LONG.

I totally agree with you but in the reproducer case the max_fds
value does not follow these rules.

I think there is probably something wrong in dup_fd() when getting
open_files value and passing it to copy_fd_bitmaps().


--nextPart14592308.tv2OnDr8pf
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-csrc; charset="utf-8"; name="repro.c"

// https://None.appspot.com/bug?id=691717b7bf277fca0588ce460186987a805e5def
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

#define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"

static void setup_leak()
{
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  sleep(5);
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  if (!write_file(KMEMLEAK_FILE, "clear"))
    exit(1);
}

static void check_leaks(void)
{
  int fd = open(KMEMLEAK_FILE, O_RDWR);
  if (fd == -1)
    exit(1);
  uint64_t start = current_time_ms();
  if (write(fd, "scan", 4) != 4)
    exit(1);
  sleep(1);
  while (current_time_ms() - start < 4 * 1000)
    sleep(1);
  if (write(fd, "scan", 4) != 4)
    exit(1);
  static char buf[128 << 10];
  ssize_t n = read(fd, buf, sizeof(buf) - 1);
  if (n < 0)
    exit(1);
  int nleaks = 0;
  if (n != 0) {
    sleep(1);
    if (write(fd, "scan", 4) != 4)
      exit(1);
    if (lseek(fd, 0, SEEK_SET) < 0)
      exit(1);
    n = read(fd, buf, sizeof(buf) - 1);
    if (n < 0)
      exit(1);
    buf[n] = 0;
    char* pos = buf;
    char* end = buf + n;
    while (pos < end) {
      char* next = strstr(pos + 1, "unreferenced object");
      if (!next)
        next = end;
      char prev = *next;
      *next = 0;
      fprintf(stderr, "BUG: memory leak\n%s\n", pos);
      *next = prev;
      pos = next;
      nleaks++;
    }
  }
  if (write(fd, "clear", 5) != 5)
    exit(1);
  close(fd);
  if (nleaks)
    exit(1);
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void)
{
  int i, call, thread;
  for (call = 0; call < 4; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
    check_leaks();
  }
}

#ifndef __NR_close_range
#define __NR_close_range 436
#endif

uint64_t r[1] = {0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    syscall(__NR_pipe, 0x200000c0ul);
    {
      int i;
      for (i = 0; i < 32; i++) {
        syscall(__NR_pipe, 0x200000c0ul);
      }
    }
    break;
  case 1:
    memcpy((void*)0x20000140, "/dev/ptmx\000", 10);
    res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20000140ul, 1ul, 0ul);
    if (res != -1)
      r[0] = res;
    break;
  case 2:
    syscall(__NR_ioctl, -1, 0xc020f509, 0ul);
    break;
  case 3:
    syscall(__NR_close_range, r[0], -1, 2ul);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  setup_leak();
  loop();
  return 0;
}


--nextPart14592308.tv2OnDr8pf
Content-Disposition: attachment; filename="CrashLog.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="CrashLog.txt"

Warning: Permanently added '[localhost]:61462' (ED25519) to the list of known hosts.
syzkaller login: [  122.778438] audit: type=1400 audit(1644766535.275:6): avc:  denied  { execmem } for  pid=269 comm="syz-executor771" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:system_r:kernel_t:s0 tclass=process permissive=1
executing program
executing program
[  144.039046] kmemleak: 24 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[  152.581891] kmemleak: 27 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
BUG: memory leak
unreferenced object 0xffff888114246200 (size 168):
  comm "syz-executor771", pid 269, jiffies 4294800484 (age 19.246s)
  hex dump (first 32 bytes):
    05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008d05afee>] prepare_creds+0x25/0x5e0
    [<00000000dc1ed5dc>] copy_creds+0x72/0x580
    [<000000006f959e2f>] copy_process+0xee4/0x66c0
    [<00000000bd3ea815>] kernel_clone+0xe7/0xa20
    [<00000000ebcdd13c>] __do_sys_clone+0xc8/0x110
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b1a6d40 (size 32):
  comm "syz-executor771", pid 269, jiffies 4294800484 (age 19.246s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000a1a7c9d2>] security_prepare_creds+0x10a/0x180
    [<000000004a0fcc72>] prepare_creds+0x458/0x5e0
    [<00000000dc1ed5dc>] copy_creds+0x72/0x580
    [<000000006f959e2f>] copy_process+0xee4/0x66c0
    [<00000000bd3ea815>] kernel_clone+0xe7/0xa20
    [<00000000ebcdd13c>] __do_sys_clone+0xc8/0x110
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888008312718 (size 984):
  comm "syz-executor771", pid 271, jiffies 4294800488 (age 19.242s)
  hex dump (first 32 bytes):
    80 11 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000fe9451d1>] alloc_inode+0x169/0x230
    [<000000000feec68a>] new_inode_pseudo+0x14/0xe0
    [<0000000086d833dc>] create_pipe_files+0x4d/0x890
    [<00000000dd797bae>] do_pipe2+0x96/0x1b0
    [<00000000f55f306a>] __x64_sys_pipe+0x2f/0x40
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888106a17ac8 (size 120):
  comm "syz-executor771", pid 271, jiffies 4294800488 (age 19.242s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    18 27 31 08 80 88 ff ff e0 7a a1 06 81 88 ff ff  .'1......z......
  backtrace:
    [<000000001d4cf14c>] security_inode_alloc+0x34/0x160
    [<000000004aa5c9b3>] inode_init_always+0x507/0xc10
    [<00000000efd3fd5f>] alloc_inode+0x84/0x230
    [<000000000feec68a>] new_inode_pseudo+0x14/0xe0
    [<0000000086d833dc>] create_pipe_files+0x4d/0x890
    [<00000000dd797bae>] do_pipe2+0x96/0x1b0
    [<00000000f55f306a>] __x64_sys_pipe+0x2f/0x40
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810697e400 (size 512):
  comm "syz-executor771", pid 271, jiffies 4294800488 (age 19.242s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<0000000019157336>] alloc_pipe_info+0x105/0x580
    [<00000000f7c3e5f1>] create_pipe_files+0x8d/0x890
    [<00000000dd797bae>] do_pipe2+0x96/0x1b0
    [<00000000f55f306a>] __x64_sys_pipe+0x2f/0x40
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881055c4800 (size 1024):
  comm "syz-executor771", pid 271, jiffies 4294800488 (age 19.242s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fddbfdd0>] alloc_pipe_info+0x1e0/0x580
    [<00000000f7c3e5f1>] create_pipe_files+0x8d/0x890
    [<00000000dd797bae>] do_pipe2+0x96/0x1b0
    [<00000000f55f306a>] __x64_sys_pipe+0x2f/0x40
    [<00000000bf0d741e>] do_syscall_64+0x33/0x40
    [<000000008651067b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


VM DIAGNOSIS:
18:36:05  Registers:
info registers vcpu 0
RAX=ffffffff83c4e670 RBX=ffffffff84c34280 RCX=ffffffff83c36748 RDX=0000000000000000
RSI=0000000000000000 RDI=ffffffff83c4ea1f RBP=fffffbfff0986850 RSP=ffffffff84c07e40
R8 =0000000000000001 R9 =ffff88811ae3c06b R10=ffffed10235c780d R11=0000000000000001
R12=0000000000000000 R13=ffffffff85453b48 R14=0000000000000000 R15=dffffc0000000000
RIP=ffffffff83c4e67e RFL=00000206 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 0000000000000000 ffffffff 00000000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00000000
FS =0000 0000000000000000 ffffffff 00000000
GS =0000 ffff88811ae00000 ffffffff 00000000
LDT=0000 0000000000000000 000fffff 00000000
TR =0040 fffffe0000003000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe0000001000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00005649d7ed412c CR3=00000001074dc000 CR4=00350ef0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
YMM00=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM01=0000000000000000 0000000000000000 7465677261742e79 636e656772656d65
YMM02=0000000000000000 0000000000000000 ffffff0f0e0d0c0b 0a09080706050403
YMM03=0000000000000000 0000000000000000 0000000000000021 0065636900656369
YMM04=0000000000000000 0000000000000000 2e2e2e2e2e2e2e2e 2e2e2e2e2e2e2e2e
YMM05=0000000000000000 0000000000000000 00005649d7eef0f0 0000000000000000
YMM06=0000000000000000 0000000000000000 0000000000000021 0000000000000000
YMM07=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM08=0000000000000000 0000000000000000 732f6563696c732e 6d65747379732f3a
YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=0000000000000000 0000000000000000 425b5a024a5b4e4b 5f5a024b424a5b5c
YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000
info registers vcpu 1
RAX=0000000000000000 RBX=0000000000000001 RCX=ffffffff8145e7e9 RDX=ffff88810bcb8000
RSI=ffffffff8145e7f2 RDI=0000000000000005 RBP=ffff88810030ad80 RSP=ffff88810bd27cd8
R8 =0000000000000000 R9 =ffff88810030ad83 R10=0000000000000000 R11=0000000000000001
R12=1ffff110217a4fa5 R13=ffff88810bd27ed0 R14=dffffc0000000000 R15=0000000000000001
RIP=ffffffff813fa790 RFL=00000046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 000fffff 00000000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 000fffff 00000000
FS =0000 00000000006fc3c0 000fffff 00000000
GS =0000 ffff88811ae80000 000fffff 00000000
LDT=0000 0000000000000000 00000000 00000000
TR =0040 fffffe000004a000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe0000048000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00000000004f72c0 CR3=00000001057c6000 CR4=00350ee0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
YMM00=0000000000000000 0000000000000000 2525252525252525 2525252525252525
YMM01=0000000000000000 0000000000000000 00000000000000ff ffffffffffffff00
YMM02=0000000000000000 0000000000000000 00000000000000ff ffffffffffffff00
YMM03=0000000000000000 0000000000000000 207365696666696a 202c313732206469
YMM04=0000000000000000 0000000000000000 6a626f206465636e 6572656665726e75
YMM05=0000000000000000 0000000000000000 32303120657a6973 2820303038346335
YMM06=0000000000000000 0000000000000000 6970202c22313737 726f747563657865
YMM07=0000000000000000 0000000000000000 3120656761282038 3834303038343932
YMM08=0000000000000000 0000000000000000 73662f7379732f00 000000000000000a
YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=0000000000000000 0000000000000000 5e415a5a165e450b 030f1c081906311c
YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000
info registers vcpu 2
RAX=ffffffff83c4e670 RBX=ffff8881009799c0 RCX=ffffffff83c36748 RDX=0000000000000000
RSI=0000000000000000 RDI=ffffffff83c4ea1f RBP=ffffed102012f338 RSP=ffff88810098fe78
R8 =0000000000000001 R9 =ffff88811af3c06b R10=ffffed10235e780d R11=0000000000000001
R12=0000000000000002 R13=ffffffff85453b48 R14=0000000000000000 R15=dffffc0000000000
RIP=ffffffff83c4e67e RFL=00000202 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 0000000000000000 ffffffff 00000000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00000000
FS =0000 0000000000000000 ffffffff 00000000
GS =0000 ffff88811af00000 ffffffff 00000000
LDT=0000 0000000000000000 00000000 00000000
TR =0040 fffffe0000091000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe000008f000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00007f3699c8dd50 CR3=00000001095a2000 CR4=00350ee0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
YMM00=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM01=0000000000000000 0000000000000000 f58e76c330976d97 c4490268c130e4bb
YMM02=0000000000000000 0000000000000000 5627cf12a5e52d08 00000000000ae9e8
YMM03=0000000000000000 0000000000000000 80f09f19808d26a3 00000000000aec28
YMM04=0000000000000000 0000000000000000 07959290bdff0429 000000000012cf90
YMM05=0000000000000000 0000000000000000 d3fdd5f48436fbd7 00000000000aea90
YMM06=0000000000000000 0000000000000000 8e7c8dff50f68680 00000000000ae948
YMM07=0000000000000000 0000000000000000 a1fcdcf819d7e1e5 00000000000ae728
YMM08=0000000000000000 0000000000000000 44495f474f4c5359 530069253d595449
YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=0000000000000000 0000000000000000 0750515151515168 5b0707241100226b
YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000
info registers vcpu 3
RAX=ffffffff83c4e670 RBX=ffff88810097b380 RCX=ffffffff83c36748 RDX=0000000000000000
RSI=0000000000000000 RDI=ffffffff83c4ea1f RBP=ffffed102012f670 RSP=ffff88810099fe78
R8 =0000000000000001 R9 =ffff88811afbc06b R10=ffffed10235f780d R11=0000000000000001
R12=0000000000000003 R13=ffffffff85453b48 R14=0000000000000000 R15=dffffc0000000000
RIP=ffffffff83c4e67e RFL=00000202 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 0000000000000000 ffffffff 00c00000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00c00000
FS =0000 0000000000000000 ffffffff 00c00000
GS =0000 ffff88811af80000 ffffffff 00c00000
LDT=0000 0000000000000000 00000000 00000000
TR =0040 fffffe00000d8000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe00000d6000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00005578bf028dd8 CR3=00000001150b8000 CR4=00350ee0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
YMM00=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM01=0000000000000000 0000000000000000 206465636e657265 6665726e750a6b61
YMM02=0000000000000000 0000000000000000 20657a6973282030 3032363432343131
YMM03=0000000000000000 0000000000000000 202c22313737726f 7475636578652d7a
YMM04=0000000000000000 0000000000000000 2e2e2e2e20203030 2030302030302030
YMM05=0000000000000000 0000000000000000 2030302030302030 3020303020303020
YMM06=0000000000000000 0000000000000000 6220323320747372 69662820706d7564
YMM07=0000000000000000 0000000000000000 6567612820343834 3030383439323420
YMM08=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000


--nextPart14592308.tv2OnDr8pf--



