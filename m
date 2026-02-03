Return-Path: <linux-fsdevel+bounces-76213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKvdKCwmgmnPPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:45:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F7DC2DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBDD3028B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6223D3321;
	Tue,  3 Feb 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="JRxvx7iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65973242B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137129; cv=pass; b=Mux/AziBNLtdXreTqRSpur15t4s8hLbMQg+OnuvhYiYK4e+kCAkt/0hioUDfVlkG9PigojilXxF1h9/vCMw0iLg32D6/liA5C1O+DvQ8dx8eCBiQT5JlqrUDxxHyPYZE6ZVCivJzXJ2wkPHGXOqx76dDqvi1/Bbyr0GIeLStSXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137129; c=relaxed/simple;
	bh=bO8dhNUjJ4X670TfqZgQ2YUgd1dsCj0kbvqJU6a2u1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp0xuLkpOnQp8q9QGkIGyV0WUjBpuR2t3/BSC0WC9yJFN2gPUKQhuGDcSP1fwhsYtMreTWXYaXE+qJVpLs8zPlKeRSUEByG/PXj0R6WAg/w1VO5kMxsf5fBtP4BRMQoup4mSgBHHr49SMhohj7RIxxXNKVr5ZTzUctTLE7Vpjwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=JRxvx7iu; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59de8155501so5866612e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 08:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770137126; cv=none;
        d=google.com; s=arc-20240605;
        b=a7ybq/Vp2dmKmuxLudmNOp91zp4ZT8raXDF74mYYDtkxAxo9RXFsLgH9Vr0DRjZgLv
         2JmXygho13LnIwPC0ZyjKUjmMMdJHi3TZjwFIHkwYeFcsIqxetNZomiVCzID7v88jrxH
         xvfgDQHo+n6e2tndqMmPTyRva3zgTctCx1mvfqSNubbpSURcN7Y1iQarRp+yAUD5i1vu
         5+sI2CRhtgptFIOcN07nduzm0N3JlYnIFnouSKj0ztuRurlUk8sdCK0TcbGgv2ktFthv
         aA3t/XepyipfoLkCXepRZeLLnhvkGqwfqg7b4r00Ns9jETtFlyNtHZvooVPqb4uerm3r
         J09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        fh=oti58R7cvrF/R+50rdIJ5Vs66LAe3pr2Xq0as48pFGQ=;
        b=MgbcgY3PbsNm1DfT2ep3miLZmk8p+XfX8a4W3hGkirMlLzbzsG6uxbx3rPFCJ4KnU0
         Go+o/oh8391ZGg+VMwL851+rUk7nO+oSeg0SsJG/s7O1N1XZHXNIIHMjV63qPnemFHrO
         m8ohKnWHNCTR3QQ8aICmDVRhFFmX8YR5gim43xzjd/NYIu/hPwdE5psgncPUHyJZoE3+
         Iy6PWmcNVc/KKp7OdXkgD0kPw5cNh/Q5K9eNAOmOuIE55K4g8pAzE10279Qm+1WLwUP8
         TzLsQK7n9gL9s/LJrMLsUrt5b/A+Dz2xX/dxHRmNvFpEMeXumYd/xh0K2Yy3rphnXRmu
         toOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770137126; x=1770741926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        b=JRxvx7iudoAYOhNvTeURknB/2jI7vfKyrHcTGNjdEgRZor6HoBLtEe+lVvTKXla07V
         TodE4/SQSSizO0it8nsKjnpktroWxPQYCOfoth2WCZzR+EYrDO0WyFSwBB+TiD2VjENn
         vNNufCWcuZp+yiZJ/m8OGWr8vcJ6R40re6yRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137126; x=1770741926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        b=PCE5stKOvt0+kgwILog6pEb50q6TfRy23gPDK4591Up8stHQNttPAghafakwbEonsf
         bWy6KWyGa/46ZrIg4EY1cj+K7vZbhNZHKdXolCRqb5gHzlZi3Zh9h3FOFPeHhCjh+HZn
         CwLx7JN1RL0i819s1bz9ujR4mxv6mH1L/LlNjXW3FTHcoil/Ki55N7He9oqqVaZEjjhy
         HqFkLKc63Klk988c9KvyJiqG8LiN5f1fCtY5aVaLAWyQaJMsMdV66GGI6yb3x7PPGgw3
         Y33a7I0EXOE+/RKlcKvPN2MDwb8RZfJbCWGMFpjDIdnyR3gqcXRNuS6hhqbbCkh9Lmys
         Dymg==
X-Forwarded-Encrypted: i=1; AJvYcCVplGev+8hDvVzjuI+ccmiESDTxoqmBlAoDvhPZRYEUmAPXv7Akd17UPz0B2APM5E0YmF3TvNlMvSI1RplQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iYa3IbRi0D0JjikNAsmRpH/TIcxT0UehVVMlWKjWKfaUvYzi
	Ba0d38Ncfqo9iuXHviSm8OBvzfWE65DRdiAZH/7IKTjDQOdhtdNVo5OHnxSsHc7Vx9uK6BzOjQA
	BGrjdxvdWMGsdk0TpwyQFLVR4H1rzk8puqhY+WFzNew==
X-Gm-Gg: AZuq6aKDYfl6s/NbYBRxaq1Xt/6nJCEW79wqHdgCLBUR17a8jysyEfQRY2O/glUnRxQ
	hQQHlik0N8osvE25/Niq9rhPAkwTfCqNURlO7+bikVsJU/wvrm6otHfrTq26gTx6Mvz/xu/icYi
	bnK5f9oS0iEAIMNhPvjH2PBe80XCRIMbSpaQfcHkMmgSN6HHsYK055PfyuEdKlVKrImvP/XguBw
	7PTf+XvfbR4Jt20dztH6YTkisiK0q31rHqlOzXQ3HMQBssc2Xe1vvgY+qYHCXvDMIYMpA==
X-Received: by 2002:a05:6512:4012:b0:59e:2020:7e53 with SMTP id
 2adb3069b0e04-59e20207f54mr4877220e87.11.1770137125969; Tue, 03 Feb 2026
 08:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
 <CAJqdLrphO1GnAZ2=n8wQAP7B+ZwFnD0wSLY7sAjacZTpLZrqBg@mail.gmail.com>
 <6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org> <20260203-genehm-senden-f0375c2ca2b6@brauner>
In-Reply-To: <20260203-genehm-senden-f0375c2ca2b6@brauner>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Feb 2026 17:45:13 +0100
X-Gm-Features: AZwV_QhbCo7XE4Hglp7OWCWOuSnYjjdtA-Lepc4tiiQWFh3d9Uj7O2E0mh_yXBU
Message-ID: <CAJqdLrp-LMVNng0F2xx1C0BtYvcidokZm6_tdssE+Z57v+tpqA@mail.gmail.com>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-76213-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+]
X-Rspamd-Queue-Id: 479F7DC2DB
X-Rspamd-Action: no action

Am Di., 3. Feb. 2026 um 17:41 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> On Tue, Feb 03, 2026 at 11:21:25AM -0500, Jeff Layton wrote:
> > On Tue, 2026-02-03 at 17:11 +0100, Alexander Mikhalitsyn wrote:
> > > Am Do., 29. Jan. 2026 um 22:48 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
> > > >
> > > > Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> > > > without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> > > > container that doesn't have FS_USERNS_MOUNT set.
> > > >
> > >
> > > Hi Jeff,
> > >
> > > > This broke NFS mounts in our containerized environment. We have a daemon
> > > > somewhat like systemd-mountfsd running in the init_ns. A process does a
> > > > fsopen() inside the container and passes it to the daemon via unix
> > > > socket.
> > > >
> > > > The daemon then vets that the request is for an allowed NFS server and
> > > > performs the mount. This now fails because the fc->user_ns is set to the
> > > > value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> > > > want to add FS_USERNS_MOUNT to NFS since that would allow the container
> > > > to mount any NFS server (even malicious ones).
> > > >
> > > > Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.
> > >
> > > Great idea, very similar to what we have with BPFFS/BPF Tokens.
> > >
> > > Taking into account this patch, shouldn't we drop FS_USERNS_MOUNT and
> > > replace it with
> > > FS_USERNS_DELEGATABLE for bpffs too?
> > >
> > > I mean something like:
> > >
> > > ======================
> > > $ git diff
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..d8dfdc846bd0 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block
> > > *sb, struct fs_context *fc)
> > >         struct inode *inode;
> > >         int ret;
> > >
> > > -       /* Mounting an instance of BPF FS requires privileges */
> > > -       if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > > -               return -EPERM;
> > > -
> > >         ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> > >         if (ret)
> > >                 return ret;
> > > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> > >         .init_fs_context = bpf_init_fs_context,
> > >         .parameters     = bpf_fs_parameters,
> > >         .kill_sb        = bpf_kill_super,
> > > -       .fs_flags       = FS_USERNS_MOUNT,
> > > +       .fs_flags       = FS_USERNS_DELEGATABLE,
> > >  };
> > >
> > >  static int __init bpf_init(void)
> > > ======================
> > >
> > > Because it feels like we were basically implementing this FS_USERNS_DELEGATABLE
> > > flag implicitly for BPFFS before. I can submit a patch for BPFFS later
> > > after testing.
>
> Can you send that to the list, please?

Sure, I'll do that a bit later! I'm still in Brussels ;-)

> Thanks!

