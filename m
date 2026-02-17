Return-Path: <linux-fsdevel+bounces-77474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCSnBXH9lGkUJwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:44:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7636A151FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197A5302414E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDD32A3F0;
	Tue, 17 Feb 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UORtinSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF9301000
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371878; cv=pass; b=mFTojzm7mnW4GQ4NMQRHy/6nNQQNjSzL0wDc91d/zaS4w+zT+bSEGpldS65P95sNQ9nJ4uqe/6V6J0IvSNJXjUlf37znkufdJmS//V4uK4NDXKbE+vFCLo3lf7lBa+aTmASQSadNoU9jNucduVJIM+OVRhFuNYgUZW1epI/h1tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371878; c=relaxed/simple;
	bh=yu44H6f4Wg8nTmqw8HkaH9X9sjJ3UAnPx9nIhLqwckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EetAJJZROn0KqRmt9k5o1Ym6hM70ruL6vO3Byqv1yT2ieB6MBf7ZQPqHnJOhyupCMnFY9azfVdpoRNFaPf728RbitL51sPCvcrgEMrlsBf7gg/ZwseMVNWwDea10zt4Cy+MUzhogkoXI1LyT0MKdb73wBGEeJBXiTy0Nwy+pTEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UORtinSr; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65821afe680so2507a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771371875; cv=none;
        d=google.com; s=arc-20240605;
        b=OYlph5RBXW5eN6dYN4J42zIJ+NEWltwz0ez1oI4CqnMctGkC/Ce2uqfHegZAXLEXxi
         +ghxhYJI21HnI5jtAJ2kZ3nO1HmeDCHFQKIv+FCETuA+HSH1LCyI5di39narmeN5l1x/
         2EHV7KGRz+C+8WEz1RnHZq7w9Yb5UutDRLbYIqV7H4RxKiZ7LvsqTXInkvLBOjamKn1X
         vllA9V26GZgBNcsBnZeGQeWO2los6lhwFboVSIj34weR0UYwrXAg3Zt7hA6xje7cF5Ys
         lXrMFxGYaRVfs1XPeabt2bKGp2Iwm8sHa9Y7FRc2p9JQXipw2VNCRvG/fYwameaJCujj
         uKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Keyrv1+8+Oviw0HNdiJHvIaxLUb4tUL/CR13rrYMGfU=;
        fh=ZvBfSoDtGvj+L4BI+VbT0MRusaY2LlU2A+uOgkZig2s=;
        b=WMebouIOctUXkbuYKS/BXZ9tdrQjarxmMH7evfo5ezyXTKC/rzasVwdGvsiQCBCSnP
         enP3XQ1r8auBOPc6r5BgywgI/WLSXfLSA7kKpXLvKfxnYovwD+dZBcmWN5ghZt1a0Sjf
         hoff6cfq+TakAU4y3mhvCUnMMFSpOj/I2y3gR7ldwom7fOmD1i9It8OVGVWxWLFap6ai
         0pake4eQ3DKN3K205EMI8PXxLDr+xgXxNACFuaTgu0V9C1oaurvVTasPH/nTUFHboeUP
         kaRQbAU2SQra00I8bPTzRdiXestbNFc5cKAMjot+HL3bevu2FdN+JThD9RiWhKHnwPQM
         3l9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771371875; x=1771976675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Keyrv1+8+Oviw0HNdiJHvIaxLUb4tUL/CR13rrYMGfU=;
        b=UORtinSrOL95Und90vwnlfEM3gNlbqygRovi/HuGSeuaVfHWbmfK+mwNhyz5XBO9D+
         fJV/N74GC//M0fVnalIiBz+M80xIwFZb2rwrIhvzXsBj+mnCB7iCJJL/9B62TuF9IMr6
         82Ehn9NL4JZdMBZF8H16i/UUSHaw5Ar2RZWOkUVnQxPPw+tKLovsXCh+YsDMV8SfsU4l
         SIrf8cv5KRl40c8MK00F1k/VuJ/jq03Vcnre8KWLO3QMvz8k7SdpFriFPBUwcRep/bl8
         MymLnTTU1Vm1+NOSvsvnXzTlbIGEpNyLld/5Ha6Yi8Owh/wo1Gz//Vevb/G9LWICp+V9
         IY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371875; x=1771976675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Keyrv1+8+Oviw0HNdiJHvIaxLUb4tUL/CR13rrYMGfU=;
        b=j7DY9DIQ/GRb+GC2MxdxhbSIDXB06QhpOoZcbxFJdYA2dE2qH+qaymetc4lVV88KXj
         4wm+bDV2OtovGtE9uwrjwtHsLaSJ2iOI3kmBxZ0pBIFVOkaYYIfanXTcDkg2s5TofZDa
         eLpzbGBlDp+UYMmmdUyOYuT8PhegmP5BI2RsGYqCnNPj1/2IJyY6dZTJ3WS5LZEtNMA/
         77AgnVNGZOQW6GrMn3NmXRn6AXyw2LKA12cqEdh0MDltZbzZqj1lEspucj03XSEnNA3f
         x1nMCEhJQLzlZbp9n3z4v0RjcfUrapN8V0DzXx+NpF61jmLuSoq9hhQpaqJdFEU7JCMH
         M+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp5hdGISI94MgzDBJC7/ncL3UyFPSNxoKcSnM5/vthiYJNe2PPhiS5XP2Cktgo0q2qQQogF+hyEjuSGF4v@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrnciQ+CEMUJ6ih92zOlgNycMe6fpBDzlxmtKBNV9Le2F+tbt
	BckwOqW+XSEgaCRsWHqzRl79mNH7kph+5M9A73mNwCL6qWVTp3LtiGyO0HkLdaB9ZrMtVDnNlar
	GsmDDzjNHQntgWg0YhhunCtsB6KTXTT6P/axxMA5i
X-Gm-Gg: AZuq6aK+zbb/KnMwCz5n9SGdM3sDnoSXFCtfYpL+i+rDGpaw7s0fg3wj6a53nVczFcK
	J+uCeLiKJVJIjwXcXge8KRADBnuyb9GOzM5fTt8UZ9KFeEkBgP3Fb6xOVZDKnVMQJFF0D5Lz+EC
	cmduRQcN45OX6yNlrY4G+EpeKLf2M3LFzga3KRYNgxsPZfuwwA4N79NSq04O3Hk4M3nSKweBZiy
	laWT2MNsupLlz19NqKdmk4dlD8r06ooGvLo6Z4HTFS/1jti5JVLOpGm5BoIERT0oagkTGCcUtHc
	f2CHGnEdSXBt2piAvqZjTBLPnUtWWr2UcF+N
X-Received: by 2002:aa7:dc08:0:b0:65c:63db:cefc with SMTP id
 4fb4d7f45d1cf-65c771922b3mr670a12.9.1771371875016; Tue, 17 Feb 2026 15:44:35
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org> <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
In-Reply-To: <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 18 Feb 2026 00:43:59 +0100
X-Gm-Features: AaiRm52vIirx07zOcYwtfGrEiCWvmmtVyx9IQItPwkZ3kGy-LCPQic0DCUR3tc4
Message-ID: <CAG48ez0RcW2uChBsQOxrQ7ngvJbE_8mDfcXRb5=FCdkQJwKd+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77474-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7636A151FF7
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:36=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> lifetime to the pidfd returned from clone3(). When the last reference to
> the struct file created by clone3() is closed the kernel sends SIGKILL
> to the child. A pidfd obtained via pidfd_open() for the same process
> does not keep the child alive and does not trigger autokill - only the
> specific struct file from clone3() has this property.
>
> This is useful for container runtimes, service managers, and sandboxed
> subprocess execution - any scenario where the child must die if the
> parent crashes or abandons the pidfd.

Idle thought, feel free to ignore:
In those scenarios, I guess what you'd ideally want would be a way to
kill the entire process hierarchy, not just the one process that was
spawned? Unless the process is anyway PID 1 of its own pid namespace.
But that would probably be more invasive and kind of an orthogonal
feature...

[...]
> +static int pidfs_file_release(struct inode *inode, struct file *file)
> +{
> +       struct pid *pid =3D inode->i_private;
> +       struct task_struct *task;
> +
> +       guard(rcu)();
> +       task =3D pid_task(pid, PIDTYPE_TGID);
> +       if (task && READ_ONCE(task->signal->autokill_pidfd) =3D=3D file)

Can you maybe also clear out the task->signal->autokill_pidfd pointer
here? It should be fine in practice either way, but theoretically,
with the current code, this equality check could wrongly match if the
actual autokill file has been released and a new pidfd file has been
reallocated at the same address... Of course, at worst that would kill
a task that has already been killed, so it wouldn't be particularly
bad, but still it's ugly.

> +               do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_TG=
ID);
> +
> +       return 0;
> +}
[...]
> @@ -2470,8 +2479,11 @@ __latent_entropy struct task_struct *copy_process(
>         syscall_tracepoint_update(p);
>         write_unlock_irq(&tasklist_lock);
>
> -       if (pidfile)
> +       if (pidfile) {
> +               if (clone_flags & CLONE_PIDFD_AUTOKILL)
> +                       p->signal->autokill_pidfd =3D pidfile;

WRITE_ONCE() to match the READ_ONCE() in pidfs_file_release()?

>                 fd_install(pidfd, pidfile);
> +       }
>
>         proc_fork_connector(p);
>         sched_post_fork(p);

