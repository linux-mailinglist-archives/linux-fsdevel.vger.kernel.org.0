Return-Path: <linux-fsdevel+bounces-79240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJYcJynxpmk/agAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:33:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C81F1874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37876315260B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1F426EC9;
	Tue,  3 Mar 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQyYdUjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A059372EE2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548088; cv=pass; b=jGjsBX53fXS3nI33jNislNnxgm+NHl0taCOWbNo4/6wy06dHp2GCRTAcsUQ8pNcsvjEvcOVOes8HKDUsitolEQbfv2TUH61NAIZmFq0AodNEWI1XDAE8HOTl6kkL0xzvOYnn1TokjuK7M3C8KXAyK9/c4SCZ1aArFNVZKCycdDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548088; c=relaxed/simple;
	bh=qOdUJuVi1m7ZhJj3GOzZ12rW1y19M/G1m+dBYN2uy5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ0hy33x9KIMCgHOuCJJV0i5mvgnSyEuR621ljcY1r71xtZQFYOv3UCCiIQ7WbejKR9Cq2WPIOs7FSucqGodi9btQoHWmjv18fdeppUXn97yhWR1UnY+HrDzNUt+45ab3F0141YZs6zkfzGc7+Wt8xdC1QCuYsO/KGkZrw7qqOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQyYdUjS; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8fa449e618so822102566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 06:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772548085; cv=none;
        d=google.com; s=arc-20240605;
        b=DoRyiYxuhxDKXzNJVFeUU2nMo7ri+120BXdaWz78mrnZZNkcx6O0kg1UEl0VCuGmc7
         87YVp6AiJjqUb8vSgy2iN8hoXyBSLB5Z5Chc7tbjxabMgY1TU8YbTrNrSLCb7OtK1Z1f
         EotP0eqK55TYSs7jrEcPca00cgpfHQPxCxycQkCqe6011iWBaoHms6LquUbLrpSLKVuI
         5GiEr/43Ehs+C3lLLQvnfSSJo1h9yMbGuI9/pIty7dAX+j10G0QJ6OjED39CoTlPnSH3
         T/ik7/NCvapSz3WkQGmv51Ss6jAY51b8qu7c7657kFX9UAs82xtBLFj7bO5765/TvIjg
         J0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=esp1UcxTOWDHIY9Li2rUvASCUzf5NNQ0S/tQeT7QTjY=;
        fh=EXNN6yvW4W1omSi68CIc3OwjClo5QRZQmuEq5hPRVGc=;
        b=k8UoQKG9LFTSt9recNAYW83rmEMf41LNbiNBipDeRAZp+LbgVz08XTbF01OlvmGsHw
         Ewm8wAtV/JG9Wi2q4ycoxmu7eLmQoHqGkc5I5gdXaHAWfCA+P4VvDw8mfC9hnLlA1O+L
         WLGdyaYFjvxViex6PYX5oShZJuIc94V+O+5DtBT/tx4jY5yf1LjCihT1XC3Va40hhbcQ
         0NxypF7rz5V4It/sCaGQ1mlp3/laVo1GKdwVfpknKvR0IOlStc6YH0eiPDA81Zklt+Ss
         MlfpD7CryZgxXY10NmtOCiM8cK3NkGVdBd0gD4sOt2SpBJkGxwpgKvIjmubC6h/HwHjk
         brug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772548085; x=1773152885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esp1UcxTOWDHIY9Li2rUvASCUzf5NNQ0S/tQeT7QTjY=;
        b=ZQyYdUjS8i+neRiYPmlq9CFYbWZvzYvEDUXwu/kFdQnfFKVCJqN831Jfle7A3UjDHQ
         Wyy61oGXS4gTjqZJWEZN4x9wK4Vz5VMkNHnsP8ROUlLQqi17AMvALNx5EVFuxC6TR1i6
         zNDJc3Zx4z5Ed33A3QhBC8mqv/F79OTzDHd6AShQC4O/Euh/ZP1Qljw3GtaaEy+3Y/bv
         tcg76SlNGmUXjtwWZRWXsmMmbkRzxH8lFv0Tk5Ay5RGA4HyYH6nvwMsQ5CPuXIe8etYJ
         gVYSOt0Xhcc4um1myQxq0sKjyp8KGMJe0wKrR3RA/PH+/c1tNttMU7Iy74lA9aVCvI0M
         Cvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548085; x=1773152885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esp1UcxTOWDHIY9Li2rUvASCUzf5NNQ0S/tQeT7QTjY=;
        b=twNvWR6KKGDdnsmnI7nShRkdcr9YRkAEt3IbSSv2MgAaGLXtE4UQmvwXT4fc7rDF3M
         /yUmCeCbvJcjh2367IEnq8szK90x63G/PsxqkOIc9/P7yt1FuKK/gxHRrVwbgnEm2KLI
         xbB+C1HcUbJ4d0R9SSLM6FjgGbO9/zQbH6XRj5kZzVXQc8DIhUem5dmjH/5T6cYj7SPC
         WhNU/gpVL48n4ePvHA3h17x9OmyTa94WcI4WrQni4r9LrAUHDcvaLN5fMGJ/ZDKP/qIo
         SIgy4162E6tMHS1gguwiPL7vAUIXqFocreQ53leh0CEpVjWS6HxT5H9/vrqS3N7euDca
         ttDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDkbSui0Gv43lAVziisNUXlW77aUBXr8Lr3l7zLOuMEPAVRaW5JkE4nnQvh8/pEOgZuYDzM/Og7x589UtJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Tbp4qwPM/b1ydmnHyXBHdK8B91I3T7LtZSg82IbAjHbBO2BO
	rJ4q7N0ITkiF2h6vhbsmyi2MAdF1yUFESFvtBzTYjNPAFA+L9SgGt+rehnrVZmFH/bNPV8ZlPx1
	dAz0oOv474dYTEFFe3IYHyoNBcn+WQfw=
X-Gm-Gg: ATEYQzwpkrGmquM6brBCZUm924ruG806SCHyF/ZYH429q6tX9Yvl6WuuSLHYS6wb6Pz
	/4hRRAVibJM7D68U+ujwXUEzaRdyXldBqtt2fqn46yC1FLxTkYzBXh+H3+A57dE7wsIPTbns7dV
	Z+m4jb9ypCIcQAXhJAzbcfVEZi6/7WYeQP0cPjvsyfZGb5pKkwtm+YTODk4bEY1JCpnudEW2dDX
	HdqYyGKhqc/stdJy8vAZOkscWBw4oL586ZFJgVFGIlJWc9izK+WKx01IWq2/RFEVLdzzRVm75+v
	onhcCbq5kJM7gAMRLBE055ximL8AMQmQcaKps1Vrmyr0YOSaqL4g
X-Received: by 2002:a17:906:5957:b0:b8e:92e:d316 with SMTP id
 a640c23a62f3a-b93765684e6mr694232166b.56.1772548084865; Tue, 03 Mar 2026
 06:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org> <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org> <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
 <aZju-GFHf8Eez-07@slm.duckdns.org> <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
 <aZx_8_rJNPF2EYgn@slm.duckdns.org> <20260224-hetzen-zeitnah-a3e1e08367cc@brauner>
In-Reply-To: <20260224-hetzen-zeitnah-a3e1e08367cc@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 15:27:52 +0100
X-Gm-Features: AaiRm52i2NAug7aj4ITPTwYuE6XkZvKlA8xrZKtvkZavq_ZPH4PZm8-pNbBhwCc
Message-ID: <CAOQ4uxhSL3ZRzNjM6AM_poxeTsYgWb5_f3tO6_4ketg8sFSOBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
To: Christian Brauner <brauner@kernel.org>, jack@suse.cz, Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f255a4064c1f8291"
X-Rspamd-Queue-Id: 3E5C81F1874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79240-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

--000000000000f255a4064c1f8291
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:03=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Feb 23, 2026 at 06:27:31AM -1000, Tejun Heo wrote:
> > (cc'ing Christian Brauner)
> >
> > On Sat, Feb 21, 2026 at 06:11:28PM +0200, Amir Goldstein wrote:
> > > On Sat, Feb 21, 2026 at 12:32=E2=80=AFAM Tejun Heo <tj@kernel.org> wr=
ote:
> > > >
> > > > Hello, Amir.
> > > >
> > > > On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > > > > > Yeah, that can be useful. For cgroupfs, there would probably ne=
ed to be a
> > > > > > way to scope it so that it can be used on delegation boundaries=
 too (which
> > > > > > we can require to coincide with cgroup NS boundaries).
> > > > >
> > > > > I have no idea what the above means.
> > > > > I could ask Gemini or you and I prefer the latter ;)
> > > >
> > > > Ah, you chose wrong. :)
> > > >
> > > > > What are delegation boundaries and NFS boundaries in this context=
?
> > > >
> > > > cgroup delegation is giving control of a subtree to someone else:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/=
Documentation/admin-guide/cgroup-v2.rst#n537
> > > >
> > > > There's an old way of doing it by changing perms on some files and =
new way
> > > > using cgroup namespace.
> > > >
> > > > > > Would it be possible to make FAN_MNT_ATTACH work for that?
> > > > >
> > > > > FAN_MNT_ATTACH is an event generated on a mntns object.
> > > > > If "cgroup NS boundaries" is referring to a mntns object and if
> > > > > this object is available in the context of cgroup create/destroy
> > > > > then it should be possible.
> > > >
> > > > Great, yes, cgroup namespace way should work then.
> > > >
> > > > > But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> > > > > to report on cgroup create? Probably not?
> > > >
> > > > Sorry, I thought that was per-mount recursive file event monitoring=
.
> > > > FAN_MARK_MOUNT looks like the right thing if we want to allow monit=
oring
> > > > cgroup creations / destructions in a subtree without recursively wa=
tching
> > > > each cgroup.
> > >
> > > The problem sounds very similar to subtree monitoring for mkdir/rmdir=
 on
> > > a filesystem, which is a problem that we have not yet solved.
> > >
> > > The problem with FAN_MARK_MOUNT is that it does not support the
> > > events CREATE/DELETE, because those events are currently
> >
> > Ah, bummer.
> >
> > > monitored in context where the mount is not available and anyway
> > > what users want to get notified on a deleted file/dir in a subtree
> > > regardless of the mount through which the create/delete was done.
> > >
> > > Since commit 58f5fbeb367ff ("fanotify: support watching filesystems
> > > and mounts inside userns") and fnaotify groups can be associated
> > > with a userns.
> > >
> > > I was thinking that we can have a model where events are delivered
> > > to a listener based on whether or not the uid/gid of the object are
> > > mappable to the userns of the group.
> >
> > Given how different NSes can be used independently of each other, it'd
> > probably be cleaner if it doesn't have to depend on another NS.
> >
> > > In a filesystem, this criteria cannot guarantee the subtree isolation=
.
> > > I imagine that for delegated cgroups this criteria could match what
> > > you need, but I am basing this on pure speculation.
> >
> > There's a lot of flexibility in the mechanism, so it's difficult to tel=
l.
> > e.g. There's nothing preventing somebody from creating two separate sub=
trees
> > delegated to the same user.
>
> Delegation is based on inode ownership I'm not sure how well this will
> fit into the fanotify model. Maybe the group logic for userns that
> fanotify added works. I'm not super sure.
>
> > Christian was mentioning allowing separate super for different cgroup m=
ounts
> > in another thread. cc'ing him for context.
>
> If cgroupfs changes to tmpfs semantics where each mount gives you a new
> superblock then it's possible to give each container its own superblock.
> That in turn would make it possible to place fanotify watches on the
> superblock itself. I think you'd roughly need something like the
> following permission model:
>

It's hard for me to estimate the effort of changing to multi sb model,
but judging by the length of the email I trimmed below, it does not
sound trivial...

How do you guys feel about something like this patch which associates
an owner userns to every cgroup?

I have this POC branch from a long time ago [1] to filter all events
on sb by in_userns() criteria.  The semantics for real filesystems
were a bit difficult, but perhaps this model can work well for these
pseudo singleton fs.

I am trying to work on a model that could be useful for both cgroupfs
and nsfs:

If user is capable in userns, user will be able to set an sb
watch for all events (say DELETE_SELF) on the sb, for objects
whose owner_userns is in_userns() of the fanotify listener.

This will enable watching for torn down cgroups and namepsaces
which are visible to said user via delegated cgroups mount
or via listns().

I would like to allow calling fsnotify_obj_remove() hook with
encoded object fid (e.g. nsfs_file_handle) instead of the vfs inode,
so that cgroupfs/nsfs could report dying objects without needing
to associate a vfs inode with them.

WDYT? Is this an interesting direction to persure?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=3Dfc=
MgLaa9ODkiu9h718MkwQ@mail.gmail.com/

--000000000000f255a4064c1f8291
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cgroup-track-owner_userns-per-cgroup.patch"
Content-Disposition: attachment; 
	filename="0001-cgroup-track-owner_userns-per-cgroup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mmao8jni0>
X-Attachment-Id: f_mmao8jni0

RnJvbSA0YjNhNTZiOGNhNTQ4MzU0MjE0MzI5NzI5OTk3YTc4YzcyYTAxNmQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDMgTWFyIDIwMjYgMTQ6MDQ6MjIgKzAxMDAKU3ViamVjdDogW1BBVENIXSBjZ3Jv
dXA6IHRyYWNrIG93bmVyX3VzZXJucyBwZXIgY2dyb3VwCgpBZGQgb3duZXJfdXNlcm5zIGZpZWxk
IHRvIHN0cnVjdCBjZ3JvdXAgdG8gcmVjb3JkIHdoaWNoIHVzZXIgbmFtZXNwYWNlCm93bnMgYSBn
aXZlbiBjZ3JvdXAuCgpGb3IgaGllcmFyY2h5IHJvb3RzLCB0aGUgb3duZXIgaXMgYWx3YXlzIGlu
aXRfdXNlcl9ucy4KRm9yIGNncm91cHMgY3JlYXRlZCB2aWEgbWtkaXIgKGNncm91cF9jcmVhdGUo
KSksIHBvc3NpYmx5IGluc2lkZSBhCmRlbGVnYXRlZCBjZ3JvdXAgbmFtZXNwYWNlLCB0aGUgb3du
ZXIgaXMgdGhlIHVzZXIgbmFtZXNwYWNlIG9mIHRoZQpjcmVhdGluZyB0YXNrJ3MgY2dyb3VwIG5h
bWVzcGFjZS4KClRoaXMgZmllbGQgaXMgYSBwcmVyZXF1aXNpdGUgZm9yIGRlbGl2ZXJpbmcgdXNl
cm5zLXNjb3BlZCBmc25vdGlmeQpldmVudHMgKGUuZy4gRkFOX0RFTEVURV9TRUxGIHZpYSBGQU5f
RklMRVNZU1RFTV9NQVJLKSB3aGVuIGEgY2dyb3VwIGlzCmRlc3Ryb3llZCwgYWxsb3dpbmcgYSBz
dWZmaWNpZW50bHkgcHJpdmlsZWdlZCBhZG1pbiBpbnNpZGUgYSBkZWxlZ2F0ZWQKY2dyb3VwIG5h
bWVzcGFjZSB0byB3YXRjaCBmb3IgY2dyb3VwIHRlYXJkb3duIHdpdGhvdXQgcmVxdWlyaW5nIGFj
Y2Vzcwp0byB0aGUgZnVsbCBzeXN0ZW0gdmlldy4KClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9jZ3JvdXAtZGVmcy5o
IHwgOCArKysrKysrKwoga2VybmVsL2Nncm91cC9jZ3JvdXAuYyAgICAgIHwgNiArKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvY2dyb3VwLWRlZnMuaCBiL2luY2x1ZGUvbGludXgvY2dyb3VwLWRlZnMuaAppbmRleCBiYjky
ZjVjMTY5Y2EyLi40ZWUzNDQ3OTJhMWQ1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Nncm91
cC1kZWZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9jZ3JvdXAtZGVmcy5oCkBAIC0zMyw2ICszMyw3
IEBAIHN0cnVjdCBrZXJuZnNfb3BzOwogc3RydWN0IGtlcm5mc19vcGVuX2ZpbGU7CiBzdHJ1Y3Qg
c2VxX2ZpbGU7CiBzdHJ1Y3QgcG9sbF90YWJsZV9zdHJ1Y3Q7CitzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2U7CiAKICNkZWZpbmUgTUFYX0NHUk9VUF9UWVBFX05BTUVMRU4gMzIKICNkZWZpbmUgTUFYX0NH
Uk9VUF9ST09UX05BTUVMRU4gNjQKQEAgLTU1MSw2ICs1NTIsMTMgQEAgc3RydWN0IGNncm91cCB7
CiAKIAlzdHJ1Y3QgY2dyb3VwX3Jvb3QgKnJvb3Q7CiAKKwkvKgorCSAqIFRoZSB1c2VyIG5hbWVz
cGFjZSB0aGF0IG93bnMgdGhpcyBjZ3JvdXA6IHRoZSBjcmVhdGluZyB0YXNrJ3MKKwkgKiBjZ3Jv
dXBfbnMtPnVzZXJfbnMgZm9yIGNoaWxkIGNncm91cHMsIG9yIGluaXRfdXNlcl9ucyBmb3IKKwkg
KiBoaWVyYXJjaHkgcm9vdHMuICBEZXRlcm1pbmVzIHRoZSBzY29wZSBvZiBmaWxlc3lzdGVtIHdh
dGNoZXMuCisJICovCisJc3RydWN0IHVzZXJfbmFtZXNwYWNlICpvd25lcl91c2VybnM7CisKIAkv
KgogCSAqIExpc3Qgb2YgY2dycF9jc2V0X2xpbmtzIHBvaW50aW5nIGF0IGNzc19zZXRzIHdpdGgg
dGFza3MgaW4gdGhpcwogCSAqIGNncm91cC4gIFByb3RlY3RlZCBieSBjc3Nfc2V0X2xvY2suCmRp
ZmYgLS1naXQgYS9rZXJuZWwvY2dyb3VwL2Nncm91cC5jIGIva2VybmVsL2Nncm91cC9jZ3JvdXAu
YwppbmRleCBjMjJjZGE3NzY2ZDg0Li5lMGJlYWY1Y2M4YzQ5IDEwMDY0NAotLS0gYS9rZXJuZWwv
Y2dyb3VwL2Nncm91cC5jCisrKyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMKQEAgLTEzODEsNiAr
MTM4MSw3IEBAIHN0YXRpYyB2b2lkIGNncm91cF9leGl0X3Jvb3RfaWQoc3RydWN0IGNncm91cF9y
b290ICpyb290KQogCiB2b2lkIGNncm91cF9mcmVlX3Jvb3Qoc3RydWN0IGNncm91cF9yb290ICpy
b290KQogeworCXB1dF91c2VyX25zKHJvb3QtPmNncnAub3duZXJfdXNlcm5zKTsKIAlrZnJlZV9y
Y3Uocm9vdCwgcmN1KTsKIH0KIApAQCAtMjE5NSw2ICsyMTk2LDcgQEAgaW50IGNncm91cF9zZXR1
cF9yb290KHN0cnVjdCBjZ3JvdXBfcm9vdCAqcm9vdCwgdTMyIHNzX21hc2spCiAJcm9vdF9jZ3Jw
LT5rbiA9IGtlcm5mc19yb290X3RvX25vZGUocm9vdC0+a2Zfcm9vdCk7CiAJV0FSTl9PTl9PTkNF
KGNncm91cF9pbm8ocm9vdF9jZ3JwKSAhPSAxKTsKIAlyb290X2NncnAtPmFuY2VzdG9yc1swXSA9
IHJvb3RfY2dycDsKKwlyb290X2NncnAtPm93bmVyX3VzZXJucyA9IGdldF91c2VyX25zKCZpbml0
X3VzZXJfbnMpOwogCiAJcmV0ID0gY3NzX3BvcHVsYXRlX2Rpcigmcm9vdF9jZ3JwLT5zZWxmKTsK
IAlpZiAocmV0KQpAQCAtNTYwNyw2ICs1NjA5LDcgQEAgc3RhdGljIHZvaWQgY3NzX2ZyZWVfcndv
cmtfZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJY2dyb3VwX3B1dChjZ3JvdXBfcGFy
ZW50KGNncnApKTsKIAkJCWtlcm5mc19wdXQoY2dycC0+a24pOwogCQkJcHNpX2Nncm91cF9mcmVl
KGNncnApOworCQkJcHV0X3VzZXJfbnMoY2dycC0+b3duZXJfdXNlcm5zKTsKIAkJCWtmcmVlKGNn
cnApOwogCQl9IGVsc2UgewogCQkJLyoKQEAgLTU4NDgsNiArNTg1MSw4IEBAIHN0YXRpYyBzdHJ1
Y3QgY2dyb3VwICpjZ3JvdXBfY3JlYXRlKHN0cnVjdCBjZ3JvdXAgKnBhcmVudCwgY29uc3QgY2hh
ciAqbmFtZSwKIAlpZiAoIWNncnApCiAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwogCisJY2dy
cC0+b3duZXJfdXNlcm5zID0gZ2V0X3VzZXJfbnMoY3VycmVudC0+bnNwcm94eS0+Y2dyb3VwX25z
LT51c2VyX25zKTsKKwogCXJldCA9IHBlcmNwdV9yZWZfaW5pdCgmY2dycC0+c2VsZi5yZWZjbnQs
IGNzc19yZWxlYXNlLCAwLCBHRlBfS0VSTkVMKTsKIAlpZiAocmV0KQogCQlnb3RvIG91dF9mcmVl
X2NncnA7CkBAIC01OTU2LDYgKzU5NjEsNyBAQCBzdGF0aWMgc3RydWN0IGNncm91cCAqY2dyb3Vw
X2NyZWF0ZShzdHJ1Y3QgY2dyb3VwICpwYXJlbnQsIGNvbnN0IGNoYXIgKm5hbWUsCiBvdXRfY2Fu
Y2VsX3JlZjoKIAlwZXJjcHVfcmVmX2V4aXQoJmNncnAtPnNlbGYucmVmY250KTsKIG91dF9mcmVl
X2NncnA6CisJcHV0X3VzZXJfbnMoY2dycC0+b3duZXJfdXNlcm5zKTsKIAlrZnJlZShjZ3JwKTsK
IAlyZXR1cm4gRVJSX1BUUihyZXQpOwogfQotLSAKMi41My4wCgo=
--000000000000f255a4064c1f8291--

