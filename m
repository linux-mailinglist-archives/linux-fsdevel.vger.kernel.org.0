Return-Path: <linux-fsdevel+bounces-46982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503CFA9716B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39377A521A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263028FFE8;
	Tue, 22 Apr 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWaxg8Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942154673;
	Tue, 22 Apr 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336611; cv=none; b=UA3AJXRoxGky24ra7KLK2n6akJxzp7mbmeLOuPyob2B7qg/kVyCVwfy/t07cHrGR68Ksm5GJViYdF0w2aNGFc0s15i8yrC6gQ5WgPMpLk6d1V3jV2DcE0gboux0hPIMSMyl/rmy3pS2okCtx0mtsH9XjMkHiIG2sedMVSfAmI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336611; c=relaxed/simple;
	bh=r/B6J2mgkDa8SrCHLnMoTjcw/Sjl9UjHWq1AQia5Whk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3DeFAdN1iRsDGSZ2M80Lf9LkxEvNdNY/QUScL8AVYQmjeej6hQ23TKmEvlLVfFkVSOqgHg5QG9wQA8SEE2ICdW74uZVqtXn/0QtBpXucBJikTP65XAB6khbUJwlmuGowChCbknVWJDZHTlnW10s+8UkLel9cBRdgFSZ+FDc9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWaxg8Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF93C4CEE9;
	Tue, 22 Apr 2025 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336610;
	bh=r/B6J2mgkDa8SrCHLnMoTjcw/Sjl9UjHWq1AQia5Whk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWaxg8DycJ7wZfAiyHZ3+VV+gKLolRB2aj85WbYo9skIgxfTv4A6fWbVGMDkTc/dT
	 3j5Bsj0jgvizejE5KexMlONHTZxC4ST8vqNYrDmV1Ly1i1ZjnlREH2R31sEJC7Qpzl
	 /MTdp4k9vGinuO9qOuzOpNKqdYTv5gjSO1U78DJmKtXqAFf0b+KEXp56vLIRkMEKnw
	 0vrN9Npm8TxBaFRQd6nKdEGxdDbduKA35otzMK3SGARDDFL8dGoApcYSgSi+nPTZFV
	 RAkPC6F+X26y+srhktu3gN5Ao1BIqMmFpXQaYSi9vgH2uMsFBq+k2lFGshHyjPgWt3
	 Xbtgo3QvJ8qkQ==
Date: Tue, 22 Apr 2025 17:43:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in choose_mountpoint_rcu /
 umount_tree
Message-ID: <20250422-spurlos-energetisch-f7899b955c83@brauner>
References: <6807876f.050a0220.8500a.000f.GAE@google.com>
 <20250422-flogen-firmieren-105a92fbd796@brauner>
 <CANpmjNPbVDaw8hzYRRe2_uZ45Dkc-rwqg9oUhoiMo2zg6D0XKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPbVDaw8hzYRRe2_uZ45Dkc-rwqg9oUhoiMo2zg6D0XKw@mail.gmail.com>

On Tue, Apr 22, 2025 at 04:42:52PM +0200, Marco Elver wrote:
> On Tue, 22 Apr 2025 at 15:43, 'Christian Brauner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Tue, Apr 22, 2025 at 05:11:27AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    a33b5a08cbbd Merge tag 'sched_ext-for-6.15-rc3-fixes' of g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1058f26f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=85dd0f8b81b9d41f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=81fdaf0f522d5c5e41fb
> > > compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/718e6f7bde0a/disk-a33b5a08.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/20f5e402fb15/vmlinux-a33b5a08.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/2dd06e277fc7/bzImage-a33b5a08.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in choose_mountpoint_rcu / umount_tree
> >
> > Benign, as this would be detected by the changed sequence count of
> > @mount_lock. I hope we won't end up with endless reports about:w
> > anything that we protect with a seqlock. That'll be very annoying.
> 
> Seqlocks are generally supported, but have caused headaches in the
> past, esp. if the reader-side seqlock critical section does not follow
> the typical do-seqbegin-while-retry pattern, or the critical section
> is too large. If I read this right, the
> 
>   struct dentry *mountpoint = m->mnt_mountpoint;
> 
> is before the seqlock-reader beginning with "*seqp =
> read_seqcount_begin(&mountpoint->d_seq);" ?

choose_mountpoint_rcu() is always called within a context where the
seqcount of the mount_lock is taken before it is called. IOW, there's
the secount stored in a dentry like mountpoint->d_seq and then there's
the seqcount of the mount_lock itself. For one callsite in
choose_mountpoint() it's obvious:

                unsigned seq, mseq = read_seqbegin(&mount_lock);

                found = choose_mountpoint_rcu(m, root, path, &seq);
		if (unlikely(!found)) {
                        if (!read_seqretry(&mount_lock, mseq))
                                break;

but for follow_dotdot_rcu()

                if (!choose_mountpoint_rcu(real_mount(nd->path.mnt),
                                           &nd->root, &path, &seq))
                if (read_seqretry(&mount_lock, nd->m_seq))
                        return ERR_PTR(-ECHILD);

nd->m_seq is setup in path_init() or in __legitimize_path() or
__legitimize_mnt(). IOW, it can be a rather complex callchain.

