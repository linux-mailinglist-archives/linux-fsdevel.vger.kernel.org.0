Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4C2515D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgHYJ7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHYJ7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:59:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F32C061574;
        Tue, 25 Aug 2020 02:59:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so6463888pgh.6;
        Tue, 25 Aug 2020 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuOdQNvCjYwjeeuaYczsQ/P924POkklEK/vv0xfrg3U=;
        b=lXb6ckPFahNycu6CtGG1p9wquWKSFOre6VDxCxEGjOmxt0n9nr2KiBW3wWI7qWPGZj
         HrZ0IWgEVNx2jG0UtMovukKewnDnCLODATnCvmHNo1UFo5pLmwI35gu8YCqzzCeFRrkd
         RnvjbGZdUvvOhE/zQbF3m4aZ+dDPSGyFF1/KASb36w7dSKOg7/AS4flOG+6nlMpfl8UL
         h6vTcE0qSgOIFpfXSX5y2OXr2hvvTvykuKQ5Jsam6atKnfmiKkJEq7OUqMOCheuCzL6k
         pxOTQikUUA/13oyToSNIB2/CGtB+wChbW7iaK7seCaBsDTOWOIBjCgDkc2cgOsjFxdbQ
         3MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuOdQNvCjYwjeeuaYczsQ/P924POkklEK/vv0xfrg3U=;
        b=MgyHj9pbwLKjcp7lswhVTagNE9k29K4dzKgbhZUbezWxUE32peWij3ZT17Ha4Nr2dt
         HiYoWuWVUbE4rfJhrKiq2UOJ0N1d851QPBZYZqx3HlV3NTwsX1IVjDtEi5Jhr+/AWqNj
         HsNvVKpDiIDR13b56KIpKhCn9y33S8XTTtCfPiVqLqXKLtYOOQOWx+t+n6Vw9zmHon9r
         v4meDN4CmzQvJq1T/Er7C53Nt9wwaaAVMQqTUfGCVESzxQyepmpecdBiI0vSX7J0etcK
         4d0yPtMS5ClgM1N+30i9rxSPSrDYyIsshCzqEPinpdT+TcJAWezgnLkwKKnND1/Pj6dj
         4Amg==
X-Gm-Message-State: AOAM531r+5nli8SqvQ6sxKDaV+NHCV3R+q5Vwj8fMBFIUM3FlE1lKwRB
        4pbQh7+GJwKD+jNP2VhqCf8=
X-Google-Smtp-Source: ABdhPJzbut3aC8gHdJTxkZ42OLIA3m5jiNHvtlvcEkiWLF5SYUkaFovRawIucnrULxoml+nrQ8IQKA==
X-Received: by 2002:a65:5c4c:: with SMTP id v12mr5866579pgr.95.1598349561945;
        Tue, 25 Aug 2020 02:59:21 -0700 (PDT)
Received: from eug-lubuntu (27-32-121-201.static.tpgi.com.au. [27.32.121.201])
        by smtp.gmail.com with ESMTPSA id t10sm12426204pgp.15.2020.08.25.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:59:21 -0700 (PDT)
Date:   Tue, 25 Aug 2020 19:59:09 +1000
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200825195909.1d1dcd72@eug-lubuntu>
In-Reply-To: <20200810154132.GA4171851@kroah.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
        <20200810150453.GB3962761@kroah.com>
        <20200811012700.2c349082@eug-lubuntu>
        <20200810154132.GA4171851@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 10 Aug 2020 17:41:32 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 11, 2020 at 01:27:00AM +1000, Eugene Lubarsky wrote:
> > On Mon, 10 Aug 2020 17:04:53 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote: =20
> And have you benchmarked any of this?  Try working with the common
> tools that want this information and see if it actually is noticeable
> (hint, I have been doing that with the readfile work and it's
> surprising what the results are in places...)

Apologies for the delay. Here are some benchmarks with atop.

Patch to atop at: https://github.com/eug48/atop/commits/proc-all
Patch to add /proc/all/schedstat & cpuset below.
atop not collecting threads & cmdline as /proc/all/ doesn't support it.
10,000 processes, kernel 5.8, nested KVM, 2 cores of i7-6700HQ @ 2.60GHz

# USE_PROC_ALL=3D0 ./atop -w test 1 &
# pidstat -p $(pidof atop) 1

01:33:05   %usr %system  %guest   %wait    %CPU   CPU  Command
01:33:06  33.66   33.66    0.00    0.99   67.33     1  atop
01:33:07  33.00   32.00    0.00    2.00   65.00     0  atop
01:33:08  34.00   31.00    0.00    1.00   65.00     0  atop
...
Average:  33.15   32.79    0.00    1.09   65.94     -  atop


# USE_PROC_ALL=3D1 ./atop -w test 1 &
# pidstat -p $(pidof atop) 1

01:33:33   %usr %system  %guest   %wait    %CPU   CPU  Command
01:33:34  28.00   14.00    0.00    1.00   42.00     1  atop
01:33:35  28.00   14.00    0.00    0.00   42.00     1  atop
01:33:36  26.00   13.00    0.00    0.00   39.00     1  atop
...
Average:  27.08   12.86    0.00    0.35   39.94     -  atop

So CPU usage goes down from ~65% to ~40%.

Data collection times in milliseconds are:

# xsv cat columns proc.csv procall.csv \
> | xsv stats \
> | xsv select field,min,max,mean,stddev \
> | xsv table
field           min  max  mean     stddev
/proc time      558  625  586.59   18.29
/proc/all time  231  262  243.56   8.02

Much performance optimisation can still be done, e.g. the modified atop
uses fgets which is reading 1KB at a time, and seq_file seems to only
return 4KB pages. task_diag should be much faster still.

I'd imagine this sort of thing would be useful for daemons monitoring
large numbers of processes. I don't run such systems myself; my initial
motivation was frustration with the Kubernetes kubelet having ~2-4% CPU
usage even with a couple of containers. Basic profiling suggests syscalls
have a lot to do with it - it's actually reading loads of tiny cgroup files
and enumerating many directories every 10 seconds, but /proc has similar
issues and seemed easier to start with.

Anyway, I've read that io_uring could also help here in the near future,
which would be really cool especially if there was a way to enumerate
directories and read many files regex-style in a single operation,
e.g. /proc/[0-9].*/(stat|statm|io)

> > Currently I'm trying to re-use the existing code in fs/proc that
> > controls which PIDs are visible, but may well be missing
> > something.. =20
>=20
> Try it out and see if it works correctly.  And pid namespaces are not
> the only thing these days from what I call :)
>=20
I've tried `unshare --fork --pid --mount-proc cat /proc/all/stat`
which seems to behave correctly. ptrace flags are handled by the
existing code.


Best Wishes,
Eugene


=46rom 2ffc2e388f7ce4e3f182c2442823e5f13bae03dd Mon Sep 17 00:00:00 2001
From: Eugene Lubarsky <elubarsky.linux@gmail.com>
Date: Tue, 25 Aug 2020 12:36:41 +1000
Subject: [RFC PATCH] fs/proc: /proc/all: add schedstat and cpuset

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0bba4b3a985e..44d73f1ade4a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3944,6 +3944,36 @@ static int proc_all_io(struct seq_file *m, void *v)
 }
 #endif
=20
+#ifdef CONFIG_PROC_PID_CPUSET
+static int proc_all_cpuset(struct seq_file *m, void *v)
+{
+	struct all_iter *iter =3D (struct all_iter *) v;
+	struct pid_namespace *ns =3D iter->ns;
+	struct task_struct *task =3D iter->tgid_iter.task;
+	struct pid *pid =3D task->thread_pid;
+
+	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
+	seq_puts(m, " ");
+
+	return proc_cpuset_show(m, ns, pid, task);
+}
+#endif
+
+#ifdef CONFIG_SCHED_INFO
+static int proc_all_schedstat(struct seq_file *m, void *v)
+{
+	struct all_iter *iter =3D (struct all_iter *) v;
+	struct pid_namespace *ns =3D iter->ns;
+	struct task_struct *task =3D iter->tgid_iter.task;
+	struct pid *pid =3D task->thread_pid;
+
+	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
+	seq_puts(m, " ");
+
+	return proc_pid_schedstat(m, ns, pid, task);
+}
+#endif
+
 static int proc_all_statx(struct seq_file *m, void *v)
 {
 	struct all_iter *iter =3D (struct all_iter *) v;
@@ -3990,6 +4020,12 @@ PROC_ALL_OPS(status);
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	PROC_ALL_OPS(io);
 #endif
+#ifdef CONFIG_SCHED_INFO
+	PROC_ALL_OPS(schedstat);
+#endif
+#ifdef CONFIG_PROC_PID_CPUSET
+	PROC_ALL_OPS(cpuset);
+#endif
=20
 #define PROC_ALL_CREATE(NAME) \
 	do { \
@@ -4011,4 +4047,10 @@ void __init proc_all_init(void)
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	PROC_ALL_CREATE(io);
 #endif
+#ifdef CONFIG_SCHED_INFO
+	PROC_ALL_CREATE(schedstat);
+#endif
+#ifdef CONFIG_PROC_PID_CPUSET
+	PROC_ALL_CREATE(cpuset);
+#endif
 }
--=20
2.25.1

