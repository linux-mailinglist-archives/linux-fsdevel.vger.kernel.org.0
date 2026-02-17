Return-Path: <linux-fsdevel+bounces-77423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OagL5zslGnUIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:33:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29D15181E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3E5303A8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97830B538;
	Tue, 17 Feb 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+do5k0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E70284890
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367561; cv=pass; b=uv0SJUre8cLH6UlQREaPpFnNbYWC6kMYwJNF+GOXgTwzwakiw/Pbe63M9nhncE9+W7gk3iwBShdhDpAPCI4NpGwkq5bZHEviZqa5vuAjrZaNvOBPqosGoy//ksp1K3gLAUYX12LewAYIF8agXUN5h3towEq0gEbEuwczGn6GbcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367561; c=relaxed/simple;
	bh=tyLWulTPYAWC5On0WxerMjv6uLHBMLdwWxyRIQpmlzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyD5IHZVf4vohbBZpEbkuWAUvlSDSm3GMf5eOmPcLlt/UDCOPN9S8lN0lwk3szk4fc0n0gpnW5kXYXMVWhgE6ZkvSr8c379IhMc72tZyXYj3lh7nk6Wx9KuoW56+LGHAQZt8ABZAn0VQDQ9mNRAG+1CrJZe5W1BVS1ziFVjyHMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+do5k0X; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371d2f661so10825e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 14:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771367558; cv=none;
        d=google.com; s=arc-20240605;
        b=CRe8YU2ZYkpgUZ6xEXM9ZW9BQqLf94YFSN4THq1/EIsI74x+55am2hiIp0zxSBltor
         R9WzI6Qi6wXx1Ic3lIR/DpXIDV43fyRAG4IgauHTKV2oUa0Qvpi75PLNJydJEXPZxd/C
         swv+kgWznPYDVXuGyESyuA86IKC79Hc3tyPr/ZTwEsuXVfd0D8RhRnyOKqBxLUvqcRAn
         8vFs8IlsyXftPqkHZMa61Vqy2NMgZ3eE+hsUjlJTxiQUA6v5ArOZEow/ANDvnoYlZy7K
         ytko4TwuOpgLPHSBCqVcx3tB0BGPaVxH9eqKE8h+6gEX0bClOXcBJdqPu92Wp+RA++XW
         lG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        fh=PV1grBprm/JAMVNLJqARZmQ8n+vDQLas68Sedamj678=;
        b=ZZ2oHcNxVLq+oocbMBbSy6c/MOVpMiI31kXBNzJD9Iqa6iPL/uPdAWyqTlIrK3erf0
         gFI4ptoUqg8UvgY+Qao6ac7S3li3CxwsBZvAB+AsiDnTUMqVrpp2Pir66CBXFEhwOHc4
         bFcVTmaL6fbfTfSwyHB/d9Erdhlm2O2QF/XCgGicXpFACCRSmJ52/BKtvvOgKRg+umsE
         17hc/3V9jQ97MNENMvkIhJ8MIIo6ubafeHx4wy2P1xh6LTSiX/vT66rMWUXMappHtYJY
         BkvgRKkPpsu5HRbBXtyJsZFeGCQ4hVNGPqjDkUJCbEcZ3ulJpcL0W3e/9Nb9w0LRrmRD
         cufA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771367558; x=1771972358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        b=i+do5k0XpRqCjjw1YMR2fsJ72cb81KZvB0at+scJIo+8o3CDQnDs9Dd/BL+jfGCgmy
         0aJKF2FMV1f6LLX0j+sVbZeavMfElsFHtiTfLv1d3byrJqfcYrma3nS1pZ0RRYGWP60H
         lMFFKw+od1tRL+1OdxVNlaUF5YOJh6vsRp3ynOB91Bh+ErNLOI+dlortxRBWJS9GGHZS
         ineU/V/isnJNJhAo+v/DJz8N4LqQF25b2KegsvCgiHNleWYH50t7ojSTSsLCZClutvPS
         yg3WRoytF9xUcAFZOg0eyLv7Ke7bMPaV9hl4fBBjbwNLucORTlJtjyorV2hxgxe7V7b5
         1gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771367558; x=1771972358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        b=KAZzwRZRdk2fAcpZ6E32aOydI2xCzr8cEeCSLjYqkAR1OauLsyE9KoqVkdQdC3xDC/
         k/bD3oSrByDOxFWx4if+NEk3H3m4PzxY+C7SVgc2TTE8DtwLGeYVMU0fL7vCNmgU93w2
         6NGKUruTQSNUBKo5zm389yBtGD9bro6u7Q4mD70QAkMZ9pU4eelcNn587dtuVGdkr9ks
         bciD9zO0lnFQV9+67f54aqekOuKzhEpKMI5ZbEX5/W+0qxrdaq3GGIMYdi9ryTdcRWW+
         4gJvK7cSehrS34LpLwFcgqDGzZp32F4XGDDh+sxGW4Il+p1PbiJ2LfB+iioNq2RY3htj
         74sw==
X-Forwarded-Encrypted: i=1; AJvYcCUrcG1br02jqALW98KMjlAi5oDrMTpM7MycUPczNWDNzqHAWjH9uPVjmSsYLkIsOHFccWNH/QWEyR8Kfqpq@vger.kernel.org
X-Gm-Message-State: AOJu0YypSHd463uw3ywjUm9Cn2iAVUtEOHRL7C7adB+ICSxkyjTMobsM
	VlM/CJ6tDSV1dhMzDeVZPHGwklva/d25BmuqlFdsPKPe9mVCaZKgc5/U9Kw19hxONM2s+QbuDlO
	hDinUpk0HDko36VVptfOhEoFvTmmQut66hUVPK/kd
X-Gm-Gg: AZuq6aKiaGDBJgfZewWad/vUH6WCsS71UJIfoHfyYzqnHzlt5qQtu82+0PG+ipzBwsV
	JY4qD/KWq6SbdF8zk74S1ruTGv+IKPAs5b8gCiG6Y/2qt2bNJQA5wivDo5ktfcg373MGKVaZjac
	a6bX2vfMa0kBC+q4pL9Nviiu3iHE4qyOD2u241qIa5Fs6klsCySYlz34tJ8RD2gmzUs+d2mMSSE
	D644cy8x1ic1ZSUFL7pQYpw9HchOshXsPisDNQgisHdvedZZHb25/g1aV+JgFrkeonZFZf29HbW
	FBU9dq+9zXfarnp99lTAEjw+F7isQFz0xZvD+tILLfSbr4avgoJuzFmDD6aAQ5ODyyuVBA==
X-Received: by 2002:a05:600c:8b61:b0:477:86fd:fb1b with SMTP id
 5b1f17b1804b1-48398c19fdamr325e9.11.1771367557747; Tue, 17 Feb 2026 14:32:37
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-3-tjmercier@google.com>
 <aZRAkalnJCxSp7ne@amir-ThinkPad-T480> <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
 <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 14:32:25 -0800
X-Gm-Features: AaiRm52ioB3yC-2XCNzG1OujfUKMHheOLnjYrqdZdEBKlcd4a_WIoA6uKbp4XL4
Message-ID: <CABdmKX1ztzJ6B13uzdDtN-uVWbdWuYJ6PMvjGoAfu40MMHCpaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77423-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A29D15181E
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 1:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Tue, Feb 17, 2026 at 2:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> > > > Currently some kernfs files (e.g. cgroup.events, memory.events) sup=
port
> > > > inotify watches for IN_MODIFY, but unlike with regular filesystems,=
 they
> > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > removed.
> > > >
> > > > This creates a problem for processes monitoring cgroups. For exampl=
e, a
> > > > service monitoring memory.events for memory.high breaches needs to =
know
> > > > when a cgroup is removed to clean up its state. Where it's known th=
at a
> > > > cgroup is removed when all processes die, without IN_DELETE_SELF th=
e
> > > > service must resort to inefficient workarounds such as:
> > > > 1.  Periodically scanning procfs to detect process death (wastes CP=
U and
> > > >     is susceptible to PID reuse).
> > > > 2.  Placing an additional IN_DELETE watch on the parent directory
> > > >     (wastes resources managing double the watches).
> > > > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> > > >     descriptors).
> > > >
> > > > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED eve=
nts.
> > > > This allows applications to rely on a single existing watch on the =
file
> > > > of interest (e.g. memory.events) to receive notifications for both
> > > > modifications and the eventual removal of the file, as well as auto=
matic
> > > > watch descriptor cleanup, simplifying userspace logic and improving
> > > > resource efficiency.
> > >
> > > This looks very useful,
> > > But,
> > > How will the application know that ti can rely on IN_DELETE_SELF
> > > from cgroups if this is not an opt-in feature?
> > >
> > > Essentially, this is similar to the discussions on adding "remote"
> > > fs notification support (e.g. for smb) and in those discussions
> > > I insist that "remote" notification should be opt-in (which is
> > > easy to do with an fanotify init flag) and I claim that mixing
> > > "remote" events with "local" events on the same group is undesired.
> >
> > I think this situation is a bit different because this isn't adding
> > new features to fsnotify. This is filling a gap that you'd expect to
> > work if you only read the cgroups or inotify documentation without
> > realizing that kernfs is simply wired up differently for notification
> > support than most other filesystems, and only partially supports the
> > existing notification events. It's opt-in in the sense that an
> > application registers for IN_DELETE_SELF, but other than a runtime
> > test like what I added in the selftests I'm not sure if there's a good
> > way to detect the kernel will actually send the event. Practically
> > speaking though, if merged upstream I will backport these patches to
> > all the kernels we use so a runtime check shouldn't be necessary for
> > our applications.
> >
>
> That's besides the point.
> An application does not know if it running on a kernel with the backporte=
d
> patch or not, so an application needs to either rely on getting the event
> or it has to poll. How will the application know if it needs to poll or n=
ot?

Either by testing for the behavior at runtime like I mentioned, or by
depending on certification testing for the platform the application is
running on which would verify that the selftests I added pass. We do
the former to check for the presence of other features like swappiness
support with memory.reclaim, and also the latter for all devices.

> > > However, IN_IGNORED is created when an inotify watch is removed
> > > and IN_DELETE_SELF is called when a vfs inode is destroyed.
> > > When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
> > > has to be a vfs inode with inotify mark attached, so why are those
> > > events not created already? What am I missing?
> >
> > The difference is vfs isn't involved when kernfs files are unlinked.
>
> No, but the vfs is involved when the last reference on the kernfs inode
> is dropped.
>
> > When a cgroup removal occurs, we get to kernfs_remove via kernfs'
> > inode_operations without calling vfs_unlink. (You can't rm cgroup
> > files directly.)
> >
>
> Yes and if there was a vfs inode for this kernfs object, the vfs inode ne=
eds to
> be dropped.

It should be, but it isn't right now.

> > > Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
> > > while watching the parent? Because this is not how the API works.
> >
> > No, only on the file being watched. The parent should only get
> > IN_DELETE, but I read your feedback below and I'm fine with removing
> > that part and just sending the DELETE_SELF and IN_IGNORED events.
> >
>
> So if the file was being watched, some application needed to call
> inotify_add_watch() with the user path to the cgroupfs inode
> and inotify watch keeps a live reference to this vfs inode.
>
> When the cgroup is being destroyed something needs to drop
> this vfs inode and call __destroy_inode() -> fsnotify_inode_delete()
> which should remove the inotify watch and result in IN_IGNORED.

Nothing like this exists before this patch.

> IN_DELETE_SELF is a different story, because the inode does not
> have zero i_nlink.
>
> I did not try to follow the code path of cgroupfs destroy when an
> inotify watch on a cgroup file exists, but this is what I expect.
> Please explain - what am I missing?

Yes that's the problem here. The inode isn't dropped unless the watch
is removed, and the watch isn't removed because kernfs doesn't go
through vfs to notify about file removal. There is nothing to trigger
dropping the watch and the associated inode reference except this
patch calling into fsnotify_inoderemove which both sends
IN_DELETE_SELF and calls __fsnotify_inode_delete for the IN_IGNORED
and inode cleanup.

Without this, the watch and inode persist after file deletion until
the process exits and file descriptors are cleaned up, or until
inotify_rm_watch gets called manually.

> > > I think it should be possible to set a super block fanotify watch
> > > on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
> > > do not allow this right now, I did not check - just wanted to give
> > > you another direction to follow.
> > >
> > > >
> > > > Implementation details:
> > > > The kernfs notification worker is updated to handle file deletion.
> > > > fsnotify handles sending MODIFY events to both a watched file and i=
ts
> > > > parent, but it does not handle sending a DELETE event to the parent=
 and
> > > > a DELETE_SELF event to the watched file in a single call. Therefore=
,
> > > > separate fsnotify calls are made: one for the parent (DELETE) and o=
ne
> > > > for the child (DELETE_SELF), while retaining the optimized single c=
all
> > >
> > > IN_DELETE_SELF and IN_IGNORED are special and I don't really mind add=
ing
> > > them to kernfs seeing that they are very useful, but adding IN_DELETE
> > > without adding IN_CREATE, that is very arbitrary and I don't like it =
as
> > > much.
> >
> > That's fair, and the IN_DELETE isn't actually needed for my use case,
> > but I figured I would add the parent notification for file deletions
> > since it is already there for MODIFY events, and I was modifying that
> > area of the code anyway. I'll remove the parent notification for
> > DELETE and just send DELETE_SELF and IGNORED with
> > fsnotify_inoderemove() in V3.
>
> I do not object to adding explicit IN_DELETE_SELF, especially
> because that would be usable also in fanotify, but I'd like to
> understand what's the story with IN_IGNORED.
>
> Thanks,
> Amir.
>

