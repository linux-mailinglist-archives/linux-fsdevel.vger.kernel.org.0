Return-Path: <linux-fsdevel+bounces-77824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HUhIeXHmGngMAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:45:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9A16AB97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67D33300DA5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24854253340;
	Fri, 20 Feb 2026 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2WaxQ8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D022D7DEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620314; cv=pass; b=dN/SaVZ927W431VbkW3pg+GQkTk0zEqVYAIrA8EOx4H1wqomSxn3Bh5Tm7hHmaR+VZCL9pbmuvlPEGEPSUg36hlTW4qvYcv+huh/NMV84RjBgoXE443cu75c5tMCn/PadjZ1zpcFYCVJkpjs9Lq9dnOMnm+ZWdjuH+1SvM73q8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620314; c=relaxed/simple;
	bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMP1Dt6FsxVcQ8PmNiOTBu1sK14913rhqMPGhCN446P7C8mtM5Q6p+kkVpFBG+MXP+XckrL6ZONIJhDd30NXQoNzpPbmsb9QgTTc1InbHLJ6iVMsHnscpoHRDQvJ3IyTdKne4/7qD4j8aOUdjbJ1iTRuiF6ly/XiVQm4WBYkkRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2WaxQ8P; arc=pass smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-94abd52b274so723525241.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 12:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771620312; cv=none;
        d=google.com; s=arc-20240605;
        b=LGmdTJw6cTgtB4YBfXbpsYt8quqUgzNnih7LQmipAUhAANJvPUM6qBQ1wSHyAlo4HH
         BxBvrdx//d56e0vLhJ1hX0GBCE1WkWRJkuwbk/B60Ny7+CUyMM99PjR49YvLxPt9ED0z
         GeCoAv8t4EXvCG3bfk9irc85R4GxJT9onIYpBOrGQdeZ1pu306iZvp4EsZuLFy7mQl6G
         xNsGWB0Co+Te50tcZsqDXKCXG5xub9NtnJr8dYlgI6eCsj2PIrxAbvKoavnCLyjEdWKP
         layaBjE3Qtqcl9oWlFMvSnl6k+isN4HZpZFNCS8yMDYe8cotmfq2XVGSRPwT0bKyANo8
         949w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        fh=3k7Y9w9q7yiRyLQH7afyu6swg9YdtXwWqUOQurlN2IY=;
        b=Tq1YzFGMH2xE93Pqenc7yjtKQQzGEhVkEulz5mSjqTOJJqCOcMZ9FifvlY/kMmM7Vh
         KjMasoWsS/Xr53gPTZ9d9CXhLKol7jAGVLYbOKcPUb1B56aF+re/WTeYflIFS/RRx+La
         PF0O037q/l0st+ehZ7rhENrF6eHPYlgr6BPdgBpgTq+4ouaZzeVf8A3+F7b6KsfSd6yE
         CqZ7RckVFkFPmj5elnp2e1BSfdMxP1Q4/XyxLO0z12bJHQw+OHI+5h24mspOQe4OaPXL
         wL+XYAhjyrd35EGhSJbhld5356XRAIK1zbhD0g5TwfWi4zj+fpJibcYqL87lRkoMv/GX
         mTHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771620312; x=1772225112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        b=c2WaxQ8P4khqGusVN5wYxJZUaqdbb6iWAUT4GxA0PEMLqYPqsaJBdpZO3xwiK6OZyg
         IPYnLt1+l+B41ezCs+nv9poBwkKG1j7mA9MyOFh2HJCbWwaK+0UIRxZC91Zd2s4xGk7+
         V6BNxUKZboRQYwtZpWy543r14/eEG9RK+UN1ocqHrmF3FcpSlSWnZ3GazFuPp26WL/m1
         wOkMM9AHtIwA1bptRa6fBN0r3qENqYUFj5X6tLWaoTKpg33MQUyMlcjUbf1U/BLq2+ph
         K94P0tKb1waoxg5f0MFWGjVT/d53ih0Y70yQfbUhaz4b6lsxwaMzlWOTrphWmAtjnedH
         KyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771620312; x=1772225112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        b=Pfx/EWrpXDPicu3EFjGf2BeBwm2RTPGCgTiwACbUiK69baKwuydtNiVzrIMUW9Knh3
         jjoVWTDe/4kZB3om0ZER/suF8GzEYH9QDmQ54NOBR1HzyqX6khxDnKY1A+zVfyzLzcNR
         wcbepTcqGMcwHXw9JVfDWZrwWrXLez0gCsoQYi1vpfsrxeYt9HAGHkBlfBbseK0Waiff
         Mi0yaO7I6U+FRy9ReObJFPPAaeufSS/gF/xFJWzDLPI5iNGVOA2w65qtQM2zHX2wgRFa
         aUhFPMT4LJ1k6o4zC1WCut/xwWGLNY0rv93IaWzVQwDC/d2uj2zAA2E0pUr0cUHzUVW3
         lR4g==
X-Gm-Message-State: AOJu0YxRRRrGCJn3VyaCLLQFuDFH32xDH/fxW3DdCbKKWeSlWT7cqsOG
	Tp1Nh5guXRzPSSKD4NZKI4fi71bPl0OJVBj+NhvVJ3hIPYfc+Eimiyx8e1U7KoD7zjWExzif0yl
	e2x4PzxEZlchGy7Le6rBoBTbqjZJibPM=
X-Gm-Gg: AZuq6aKfPsSbKNfxhSWDMKgwNE2DpCelUbXCFGQ4QfF4H9QqMvK7O7Fd55vQDzMgksS
	x4GmCP6Mln7C3mU5lObrDlf0srQP7KcLGgWKX8b/CuD7CvVwu1p3T/0vtXVwqnQhcapWsYgvFRs
	4As4ylvVjlGcAlejL+5+3XcwuIoPAb3ABARE9gI6DxiEqikihkshZygGMfFrSiRrQVPVivwTE4d
	dR7Q8UYVUSXuMtt6MPam9+jOXJ4MSphL7zqMkMozEne+K7u3erPel6Jh7FTfZ8yXJenbn279iB6
	4o1rtdjIBbfZ6b/mJA==
X-Received: by 2002:a05:6102:b16:b0:5f5:514f:4e59 with SMTP id
 ada2fe7eead31-5feb30a72d0mr465363137.27.1771620312379; Fri, 20 Feb 2026
 12:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
 <20260209-spanplatten-zerrt-73851db30f18@brauner> <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
 <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
In-Reply-To: <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Fri, 20 Feb 2026 15:45:00 -0500
X-Gm-Features: AaiRm52hM82IevVg7Vmo62C2F5Yss-2733FdxbX2tudFZkW41cTm1-3xKTkFeQI
Message-ID: <CAKrb_fFEvf5VzY_-zcc800wjVGOFbiGrpzC7S6Ghy9qhYJrZ1w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77824-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieldurningwork@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 46D9A16AB97
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 7:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Feb 11, 2026 at 02:43:21PM -0500, Daniel Durning wrote:
> > On Mon, Feb 9, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.co=
m wrote:
> > > > From: Daniel Durning <danieldurning.work@gmail.com>
> > > >
> > > > Added a permission check to pidfd_info(). Originally, process info
> > > > could be retrieved with a pidfd even if proc was mounted with hidep=
id
> > > > enabled, allowing pidfds to be used to bypass those protections. We
> > > > now call ptrace_may_access() to perform some DAC checking as well
> > > > as call the appropriate LSM hook.
> > > >
> > > > The downside to this approach is that there are now more restrictio=
ns
> > > > on accessing this info from a pidfd than when just using proc (with=
out
> > > > hidepid). I am open to suggestions if anyone can think of a better =
way
> > > > to handle this.
> > >
> > > This isn't really workable since this would regress userspace quite a
> > > bit. I think we need a different approach. I've given it some thought
> > > and everything's kinda ugly but this might work.
> > >
> > > In struct pid_namespace record whether anyone ever mounted a procfs
> > > with hidepid turned on for this pidns. In pidfd_info() we check wheth=
er
> > > hidepid was ever turned on. If it wasn't we're done and can just retu=
rn
> > > the info. This will be the common case. If hidepid was ever turned on
> > > use kern_path("/proc") to lookup procfs. If not found check
> > > ptrace_may_access() to decide whether to return the info or not. If
> > > /proc is found check it's hidepid settings and make a decision based =
on
> > > that.
> > >
> > > You can probably reorder this to call ptrace_may_access() first and t=
hen
> > > do the procfs lookup dance. Thoughts?
> >
> > Thanks for the feedback. I think your solution makes sense.
> >
> > Unfortunately, it seems like systemd mounts procfs with hidepid enabled=
 on
> > boot for services with the ProtectProc option enabled. This means that
> > procfs will always have been mounted with hidepid in the init pid names=
pace.
> > Do you think it would be viable to record whether or not procfs was mou=
nted
> > with hidepid enabled in the mount namespace instead?
>
> I guess we can see what it looks like.

Having looked into this some more I am not sure if the mount
namespace is viable either since a single proc instance could be in
multiple mount namespaces. In addition the mount namespace
does not seem to be easily accessible in the function where proc
mount options are applied. I also considered adding an option
similar to hidepid to pidfs, but since pidfs is not userspace-mounted
I do not think that is possible without some significant changes.

Doing a proc lookup with kern_path() does work, but it does not seem
practical in terms of performance unless we had some other way to
skip it in the common case.

Curious if anyone else has any ideas or suggestions on how this
could be implemented.

