Return-Path: <linux-fsdevel+bounces-78465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPrIKHMmoGk6fwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:54:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B710E1A4A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5065F305764A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF646314A9D;
	Thu, 26 Feb 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fll9pnSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF703164BA
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103148; cv=pass; b=B80mUep9tr+gX6ckMM/YkeT5rnBwmyQH8ioKm+/PmBoBFtbEJX8IhlihHFr/ERprOGuJxNeQ2+CIZXf1nD9mLlooL30Mbjd1omg+fKfQyUOmupmdP1cWfIeIq1KsIrG+NId1lKZWT+m/AUlSLI3C4hUSIWNe6owpdIC29hJv5OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103148; c=relaxed/simple;
	bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR95brhm1rWaXHs/j+QP9rS1+ccbHNyxzwGYrHoPQ4Pjq60cDT7LXqWXHtWE+TJxI5NAtJmYdPgOuuUrNqdapD0E+eaRF/cZ3Mrp7+KndDfvKtuwEaV7tV0Z3/qEYTnyFQOQ+DLGYcj3lkhYw+FndRVWgRnbdmdmz5hW40vNeSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fll9pnSd; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8845cb580bso84102466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772103145; cv=none;
        d=google.com; s=arc-20240605;
        b=V4yD5eL8BQvCNSDZx4HSl/OlBYYiKLjekPQSMEEECEsgOyMVAcpjPOLqXUufkgFZPi
         XBZnPdVIxRPsjKzZJJUFC3S3bXZ7+LqjdI5+WRhL68QvmQ+q2ED53WQt8vPqFp1u9nwQ
         gIJ9dQxN01J6WTqyqLI42d2BfPTl6qTQLE/V9tqC+y9VERzG8vhmegs0YYe5NxCGnqjH
         zq8RhG3eMvaWOdIX/wHXs38zUCqE0us2bUSmEpEciJp+XaZsLvuVi2dTYOIxtqDhkquc
         EaDKWdWE8mfaOWYE0LLzrnpPJeT4jATqW8Fg6fKlEJZng6XKVw3SqDs8sHV2eeP+nfDl
         Qokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        fh=BeExvloZasssyWg0Vp+G4YXlntjOitKAN63sYYWj17s=;
        b=MYC+dlWvy+RM4iLIEwzZbZ4TfzM0wcZscmP1kgPSQ8vu6pAP4XLEHxe59Og69O9LbB
         nq7qMOS3xNSDTPbbZDFQrHvGADwuP5/jJUBwiw/fgejQSSKFTH76oVqbR0rg4jlKaZXi
         PLtqkOyypElC/z2aWek7qggG0DbfZg1F7qEqHmkjIkXrp+lXM9WHlJ6Hijs2JZiV9K7r
         XTFBMz38cWvJBU1dC146d6NLwPy3C0IpHUKuy3+zJ2/Lxz0wtugNJ4h54hbD6aprE1u3
         QQ6wEzOTMt5Mj2vUdC5h21wNWxdQXg4vekM7GtSxqTdsQx/ncfVJ2mkh6JU2ierGKzsc
         6iQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772103145; x=1772707945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        b=Fll9pnSdW79y2MULk5uZqAheMngCKZAnc7zl1fIdNWSqPpKTDGcdawonFDOqo+YvCN
         sC5uA/o9NUMxnS1I5NFTHiL1c8G75bNBTOQ1lttRy4w0FxEtFUKbuumn76kvkdAv0EBq
         gsrEpNHGitIF2warmK5JNO51wWGGApnWGOAIOOlu4SwEtd1TpbZL9O4eDXnYnyNDtwXS
         OWP+VmY1WjUyljyhCy8qnvMDMU64gDln+j+CvDHDxupf3EoSbsaWeUmg9lw9Buql9PDw
         +j0wBlEWlx3b62kAaiE2cApLdLKAPEyC41fA15ZfUdeq9+MZXxGbyl9qKarQNm+AWVwp
         0clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772103145; x=1772707945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        b=f+YQEasz/GRpq2WnU0Pmf4aK3TBcM/F9ztPYjkF9EEpQaUFR4ugrDqSbzWv8pJNKN9
         jCLhLpja1kGUf5yOBIYoCq59yOlhzin8ZJ5hZWffqK+yrt9m3NDiVAcA74q2KQkhm8H2
         Ov0L1ZL6l35UBgL/BAqZVx1UuUSU+Tvbsz7O8tQZ1bxgkVac4jImWWZFMWwWjaS3v12D
         vRdJgS+geFyMCSfcrB7L8Qz9QOAhxUu1Zl66Z57DmuRKbNd/MIJxZqH7U8/SIKYi8zlN
         7rhl3gE3QWpO7RK6uHw7EPazRl7XAIkfc9hx/LEilGhoQymiD7uGf8XSp41H2VOdJUAp
         UTww==
X-Forwarded-Encrypted: i=1; AJvYcCXYpCsuqtIsC8MdLqfF3yf4+ZvgSqovQEZL74ehwefzpm5uys1cMlMzNicLN9jn3T+lHq3HR4oqzxYTZPE8@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9N37QNou0xP14JDPOF/UhxzGxCDIKPJyMyrpmF7lFEqBnl6c
	cQBbrQwyN2vk1V20SQEcrF+NUxFsU0j7mBmnnG9zMtJPw/EA+CU3HYVzo/Uy0OWxOIRKOft/IXc
	KK94xmWXeOrMcSwpK2ZQK5k4Ny3vatjA=
X-Gm-Gg: ATEYQzzsOaMTkAJLqcOZvgvL4Pt5ZyzvATaCgOQlQBSKi23R4FhmJIMLoKNnY6vaKvZ
	1lcJDkN1iPkevRnrHrA01hFbairfwvDSsSf4gw2O3FS6fYdndRjJb9CX/bb5xSBWW77gDyOw5ZT
	rdQc/PvHtuMUmK3fTaTCzJchJO1acQnF5lYB30NBj+r+jsDS9gSzCytsmUG6M55iRWNBAliMpQo
	koDPJWWd5MsaKIkJnmmFaFBo6YzCeA2t87b6+tynpO6Ndkd7OrQ6mm7bKgcYL/oIT3O4gxu6ie0
	Ghz05yFjsXwD0BAFBRt8ROekGFnDmFL6gh3FeSR932dcv5uZ6bPA
X-Received: by 2002:a17:907:6d23:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b93516f96e2mr222252966b.30.1772103145106; Thu, 26 Feb 2026
 02:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224163908.44060-1-cel@kernel.org> <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
In-Reply-To: <20260226-alimente-kunst-fb9eae636deb@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Feb 2026 11:52:14 +0100
X-Gm-Features: AaiRm53mcTQaleH3x734v1P1hXc7pPYlX4ZMwyjoEVpA_Orzt5TlXYhMMZxDzbQ
Message-ID: <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.com>, NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78465-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B710E1A4A89
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Feb 24, 2026 at 11:39:06AM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Kernel subsystems occasionally need notification when a filesystem
> > is unmounted. Until now, the only mechanism available is the fs_pin
> > infrastructure, which has limited adoption (only BSD process
> > accounting uses it) and VFS maintainers consider it deprecated.
> >
> > Add an SRCU notifier chain that fires during mount teardown,
> > following the pattern established by lease_notifier_chain in
> > fs/locks.c. The notifier fires after processing stuck children but
> > before fsnotify_vfsmount_delete(), at which point SB_ACTIVE is
> > still set and the superblock remains fully accessible.

Did you see commit 74bd284537b34 ("fsnotify: Shutdown fsnotify
before destroying sb's dcache")?

Does it make the fsnotify_sb_delete() hook an appropriate place
for this cleanup?

We could send an FS_UNMOUNT event on sb, the same way as we send
it on inode in fsnotify_unmount_inodes().

>
> What I don't understand is why you need this per-mount especially
> because you say above "when a filesystem is mounted. Could you explain
> this in some more details, please?
>

The confusing thing is that FS_UNMOUNT/IN_UNMOUNT are sent
for inotify when the sb is destroyed, not when the mount is unmounted.

If we wanted we could also send FS_UNMOUNT in fsnotify_vfsmount_delete(),
but that would be too confusing.

I think the only reason that we did not add fanotify support for FAN_UNMOUN=
T
is this name confusion, but there could be other reasons which I don't
remember.

> Also this should take namespaces into account somehow, right? As Al
> correctly observed anything that does CLONE_NEWNS and inherits your
> mountable will generate notifications. Like, if systemd spawns services,
> if a container runtime start, if someone uses unshare you'll get
> absolutely flooded with events. I'm pretty sure that is not what you
> want and that is defo not what the VFS should do...
>
> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
> another idea and I hope that Jan and Amir can tell me that this is
> doable...
>
> Can we extend fsnotify so that it's possible for a filesystem to
> register "internal watches" on relevant objects such as mounts and
> superblocks and get notified and execute blocking stuff if needed.
>

You mean like nfsd_file_fsnotify_group? ;)

> Then we don't have to add another set of custom notification mechanisms
> but have it available in a single subsystem and uniformely available.
>

I don't see a problem with nfsd registering for FS_UNMOUNT
event on sb (once we add it).

As a matter of fact, I think that nfsd can already add an inode
mark on the export root path for FS_UNMOUNT event.

Thanks,
Amir.

