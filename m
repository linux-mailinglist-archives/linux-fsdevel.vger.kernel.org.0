Return-Path: <linux-fsdevel+bounces-49021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34826AB791D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56671B678C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB42224231;
	Wed, 14 May 2025 22:39:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02296282E1;
	Wed, 14 May 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262340; cv=none; b=dExEM7SG8HLmxbAl/DFp9m8guETpzlvHOaeBhg8RhE6jS1zs4VA7cX7Avnxd5/473FhNiA3p8Y1d/ZGaMP6iwomn3b1HqYpdBo16zIzRvdfB3uFpMr30U6aTzmyJQv6TRd+ctFjLHLIRa0h5RSVCXd1C8NWiKwa8veR2IMWhS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262340; c=relaxed/simple;
	bh=GwNy22QIi4AIPIrZbza8M5BhHX1dV22QtfubBHjbg9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXkBo08GnprV/htTKGog+wATGZmrAZ73qpprUj18mG9WsKr7zwXwwneY46+agrDtSglykMCjhPr4TT5xuY4fUjwmuk7egUcPV/npb+HfLQ8wpuiUtaT9PiDmG1ALxczeZ2lP3PcH+ztOR5LFUauQJhNOY1rzhyUueSo+XAASyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e78e38934baso348281276.1;
        Wed, 14 May 2025 15:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262337; x=1747867137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY192BQ1DoJfE7kUSLdC/AuSynN/qFzUH1ibnUPL48Q=;
        b=OpGG2wgcSqTfAc3/f4MRkYUbd6fukFBZzPD2zGZLxQzhCvcUBcDggyvBQghQ0IaNVu
         6kgdYDVkBgnEsea5b4qO5Z1I8Rm+ZVmsp2Ljz7snaGw24rXl5Y2ONZjyAMXYc2clqFRn
         g/Qbm1z7DmU/UftporcsIlIelfaEEm6XQqso6Pr3M6pzqwnyqhI2XwwshXKImuy4JnWu
         G8CzY1FTj55W764uw7jGle57U1AbVS6bqnu7flxhMI7kH0nfSNpGedzofY9yaEw73TE3
         ZRRa4ku2rUwxqe9yZX3GIEFg9e6QgzS95F3uuxrNiidJq0ciQDRQ7h5Nwd2r491X4m5v
         VRcA==
X-Forwarded-Encrypted: i=1; AJvYcCUvCv/USXpg0H6RRlNQtkr/H29jbw42gn6i/uM5pDBXqJXRJGfCg2Wps4cmbBM4P5V2CqFZ3UB1P0aInBPhTqBc0r25hqfT@vger.kernel.org, AJvYcCVami5nGuuftm7x98NNhE/1LcN74q2UNXIVz2fH7kfP+Xmg7VAxEm/Fvi9TiY/Xpqpqe6AfSUJL@vger.kernel.org, AJvYcCXPHoXtoEi2eX3Qj9mSfxSbHepamti5AnSuzU3tjuwKKLj+/GjiMoOq34yv/RnXFlLKEvSSNKYF8gRVGCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWJigprrG2DZhwbdOTPvp4Pd1toEYuhSpa7VxWrHeeiaiwfTq
	JzP2e2+8MXz65z4DEiNUTFd4NFQWkkddstTHI14nuz9eOu14nudkf9XhRw==
X-Gm-Gg: ASbGncvtL0zi3h0et8jOfExOPN2dfHAjVSxPLkrfEs8mCv5G76h+OJ/I5MxGvGtAfZG
	Qmg/awchYskS+Bm/FRMJLgh3vFAJaWNorsP15gKe8Hwil5IcZniHAD4KElnll5B2FH4npd9N18S
	ihbhT0fg/ly8Ir137eXqzYgFEwkENJEgkZhYtBqT6Kzcb4nsOUdZzI3BAVDeXTaYF5iSpqg2mLk
	LAVsJdMvgPppf/WV7VQg5jPeaIxMs1+9DZkxISEh2PNhW2E6/Y//ctJkGA/9jIk7/l1EnWbe0dp
	DyxjKzickV9EQEwc+Iet7mOeqD37JCsRHl0dI6mC3W0VDp3VueLPU0HPkzmG49E/KUbkuVzmM/X
	GkLNn4jGliXAa
X-Google-Smtp-Source: AGHT+IFbv6XyPTHYJvsI0HonHvPYW5M+30Ov7KdMTgzHAHntOI5Xffm3eNODBG/eXtm0xp9chosuyA==
X-Received: by 2002:a05:6902:1503:b0:e73:294c:2286 with SMTP id 3f1490d57ef6-e7b3d50493emr7216143276.26.1747262336666;
        Wed, 14 May 2025 15:38:56 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd651b45sm3407614276.43.2025.05.14.15.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 15:38:56 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70a32708b4eso2203087b3.3;
        Wed, 14 May 2025 15:38:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwJc9gevHWkunAlFl+EMMQZBdyDGVGsNx3hpdEplIVv/4G0sXKsQUHgrSHWjuW9rtN0DSz2NZ2MS6/UoI=@vger.kernel.org, AJvYcCWDTLpbzetDzfOL3GkM4MrOoGADV+HLzqx8t7s71flOR7rbOnFuZNbvdCTNhzUfAIGp0Ye65AKQECbxAyM8mCtrfAUWmEdx@vger.kernel.org, AJvYcCWXjH8VkBLEOy0YSYVFpqFrvjfl+pT0+onA2MQNgEVXqf5aJO1nktLN+DUNF7sFJqCixsHKd0RA@vger.kernel.org
X-Received: by 2002:a05:690c:45c7:b0:709:176d:2b5 with SMTP id
 00721157ae682-70c7f10c045mr80175517b3.2.1747262335951; Wed, 14 May 2025
 15:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
From: Luca Boccassi <bluca@debian.org>
Date: Wed, 14 May 2025 23:38:45 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQJ3h3ho2Q2L07AOuUaOr05HNm1aMoSyLTS_OD+w9BSPQ@mail.gmail.com>
X-Gm-Features: AX0GCFsXsryormWEGIKna5LSH2nDHEStseOJ8IxwSboMNNs10SR9BhIWxhQsWVc
Message-ID: <CAMw=ZnQJ3h3ho2Q2L07AOuUaOr05HNm1aMoSyLTS_OD+w9BSPQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 23:04, Christian Brauner <brauner@kernel.org> wrote:
>
> Coredumping currently supports two modes:
>
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
>
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
>
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
>
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
>
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
>
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
>
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
>
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
>
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
>
> - A new usermode helper has to be spawned for each crashing process.
>
> This series adds a new mode:
>
> (3) Dumping into an abstract AF_UNIX socket.
>
> Userspace can set /proc/sys/kernel/core_pattern to:
>
>         @/path/to/coredump.socket
>
> The "@" at the beginning indicates to the kernel that an AF_UNIX
> coredump socket will be used to process coredumps.
>
> The coredump socket must be located in the initial mount namespace.
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket.
>
> - The coredump server should use SO_PEERPIDFD to get a stable handle on
>   the connected crashing task. The retrieved pidfd will provide a stable
>   reference even if the crashing task gets SIGKILLed while generating
>   the coredump.
>
> - When a coredump connection is initiated use the socket cookie as the
>   coredump cookie and store it in the pidfd. The receiver can now easily
>   authenticate that the connection is coming from the kernel.
>
>   Unless the coredump server expects to handle connection from
>   non-crashing task it can validate that the connection has been made from
>   a crashing task:
>
>      fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
>      getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);
>
>      struct pidfd_info info = {
>              info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>      };
>
>      ioctl(pidfd, PIDFD_GET_INFO, &info);
>      /* Refuse connections that aren't from a crashing task. */
>      if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
>              close(fd_coredump);
>
>      /*
>       * Make sure that the coredump cookie matches the connection cookie.
>       * If they don't it's not the coredump connection from the kernel.
>       * We'll get another connection request in a bit.
>       */
>      getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
>      if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
>              close(fd_coredump);
>
>   The kernel guarantees that by the time the connection is made the
>   coredump info is available.
>
> - By setting core_pipe_limit non-zero userspace can guarantee that the
>   crashing task cannot be reaped behind it's back and thus process all
>   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
>   detect whether /proc/<pid> still refers to the same process.
>
>   The core_pipe_limit isn't used to rate-limit connections to the
>   socket. This can simply be done via AF_UNIX socket directly.
>
> - The pidfd for the crashing task will contain information how the task
>   coredumps. The PIDFD_GET_INFO ioctl gained a new flag
>   PIDFD_INFO_COREDUMP which can be used to retreive the coredump
>   information.
>
>   If the coredump gets a new coredump client connection the kernel
>   guarantees that PIDFD_INFO_COREDUMP information is available.
>   Currently the following information is provided in the new
>   @coredump_mask extension to struct pidfd_info:
>
>   * PIDFD_COREDUMPED is raised if the task did actually coredump.
>   * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
>     undumpable).
>   * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
>     doesn't need special care by the coredump server.
>   * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
>     treated as sensitive and the coredump server should restrict access
>     to the generated coredump to sufficiently privileged users.
>
> - The coredump server should mark itself as non-dumpable.
>
> - A container coredump server in a separate network namespace can simply
>   bind to another well-know address and systemd-coredump fowards
>   coredumps to the container.
>
> - Coredumps could in the future also be handled via per-user/session
>   coredump servers that run only with that users privileges.
>
>   The coredump server listens on the coredump socket and accepts a
>   new coredump connection. It then retrieves SO_PEERPIDFD for the
>   client, inspects uid/gid and hands the accepted client to the users
>   own coredump handler which runs with the users privileges only
>   (It must of coure pay close attention to not forward crashing suid
>   binaries.).
>
> The new coredump socket will allow userspace to not have to rely on
> usermode helpers for processing coredumps and provides a safer way to
> handle them instead of relying on super privileged coredumping helpers.
>
> This will also be significantly more lightweight since no fork()+exec()
> for the usermodehelper is required for each crashing process. The
> coredump server in userspace can just keep a worker pool.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v7:
> - Use regular AF_UNIX sockets instead of abstract AF_UNIX sockets. This
>   fixes the permission problems as userspace can ensure that the socket
>   path cannot be rebound by arbitrary unprivileged userspace via regular
>   path permissions.
>
>   This means:
>   - We don't require privilege checks on a reserved abstract AF_UNIX
>     namespace
>   - We don't require a fixed address for the coredump socket.
>   - We don't need to use abstract unix sockets at all.
>   - We don't need  special socket cookie magic in the
>     /proc/sys/kernel/core_pattern handler.
>   - We are able to set /proc/sys/kernel/core_pattern statically without
>     having any socket bound.
>
>   That's all complaints addressed.
>
>   Simply massage unix_find_bsd() to be able to handle this and always
>   lookup the coredump socket in the initial mount namespace with
>   appropriate credentials. The same thing we do for looking up other
>   parts in the kernel like this. Only the lookup happens this way.
>   Actual connection credentials are obviously from the coredumping task.
> - Link to v6: https://lore.kernel.org/20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org
>
> Changes in v6:
> - Use the socket cookie to verify the coredump server.
> - Link to v5: https://lore.kernel.org/20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org
>
> Changes in v5:
> - Don't use a prefix just the specific address.
> - Link to v4: https://lore.kernel.org/20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org
>
> Changes in v4:
> - Expose the coredump socket cookie through the pidfd. This allows the
>   coredump server to easily recognize coredump socket connections.
> - Link to v3: https://lore.kernel.org/20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org
>
> Changes in v3:
> - Use an abstract unix socket.
> - Add documentation.
> - Add selftests.
> - Link to v2: https://lore.kernel.org/20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org
>
> Changes in v2:
> - Expose dumpability via PIDFD_GET_INFO.
> - Place COREDUMP_SOCK handling under CONFIG_UNIX.
> - Link to v1: https://lore.kernel.org/20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org
>
> ---
> Christian Brauner (9):
>       coredump: massage format_corname()
>       coredump: massage do_coredump()
>       coredump: reflow dump helpers a little
>       coredump: add coredump socket
>       pidfs, coredump: add PIDFD_INFO_COREDUMP
>       coredump: show supported coredump modes
>       coredump: validate socket name as it is written
>       selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
>       selftests/coredump: add tests for AF_UNIX coredumps
>
>  fs/coredump.c                                     | 392 +++++++++++++----
>  fs/pidfs.c                                        |  79 ++++
>  include/linux/net.h                               |   1 +
>  include/linux/pidfs.h                             |  10 +
>  include/uapi/linux/pidfd.h                        |  22 +
>  net/unix/af_unix.c                                |  60 ++-
>  tools/testing/selftests/coredump/stackdump_test.c | 514 +++++++++++++++++++++-
>  tools/testing/selftests/pidfd/pidfd.h             |  23 +
>  8 files changed, 996 insertions(+), 105 deletions(-)
> ---
> base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
> change-id: 20250429-work-coredump-socket-87cc0f17729c

Looks great to me and we can for sure use this in systemd-coredump,
thanks, for the series:

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>

