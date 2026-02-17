Return-Path: <linux-fsdevel+bounces-77403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL8ZEcHclGnPIQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:25:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE5150BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D63EC3012BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B42F6571;
	Tue, 17 Feb 2026 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f49CF+u7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AB271450
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363516; cv=pass; b=cPKSVeX27exZqJrg9Po2ws27xuIM2mJDeCvrJoWAvPeyKwotI1+u5ADIYUPuFqJbCtfUbq95EpfAnuFfsRD5qNucaLAYo+TjB65ikeDETfqjhew23PozAP9tG2ZF7LFQCXgN4URlLm6NvDE1/2sv3Orj17CMxWQMAn3Y0kEWVXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363516; c=relaxed/simple;
	bh=fbhIDMncw2o3OGAnMUfavkAE0+3CvTo4wLCTth3BWak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIZ/PO7+uMVU2Vxap8U8U/IuwtV+U3leWO1KJH70/K5OXkQHeDCWDmcXbgpt3vy1H7naVaKXkEnZm/Xmn8MDy0SQ/rk85SM7w9AeyXs5qr1vY3k7yuhaPhpya/T3mxpAs+tpTQ0t30yQ/gt28VyTh37C7oQoG9P3rXgi8g//0Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f49CF+u7; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so7728186a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 13:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771363513; cv=none;
        d=google.com; s=arc-20240605;
        b=XBsNrkzYpsZHlIZTLIT5dGHWhV1LftLBlilaLyd+Ig2tTa5q/W4i/+VOsmBmjAPMsw
         Mj3gxBGSJ/8Flw6v0jPlPTTRMIrD/bu/kboYkoZaQYxB02U8l2JF3qI9DeXLdqbUm2Fo
         rxa5Ln76f2sTnZmlyvU17sIS0Vk66iOrB25201gDxVCtdSxIRTxbQA6E44qt9XWBMwQG
         5Pya0Nmy46RtxSUSQt0q2MNumnuL4NuRUzEYeBs5SRlXJZ+gZajLMSOu4iDeb8EZf0WK
         k2M0UGEPYh+4KmRAqZ5kfX2OaMwXLp9FJbEOAEUp1yUVsl7Gbb1DpL7k6oO24PAKPrQp
         PEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        fh=fbFMhGAtOcWB498gu/Nu91nY0WY+iLLmUeP+USKGFzM=;
        b=BimzbCHLEURxGR+viWiOUHU1loGPHhc7BHLnIbJ0MzWm8y9536Tu23+rlSqDpnGGEx
         BoLU2kd/spL5SRq32I6EMYYGkPzUL0/JHXt1OBT5YbQ14r/EbJa05c8NdsDBvij977pA
         q0T2xem84bRerlk65B/UPf230S9L/bNDW5sMkFxyFAofHkKn4gBc1euQvXTRn0sPSICs
         yGcjLbN+dIcXEZdvStgE9Tr1I5B4De9JhLMqmnvpYAK5T5XEsa5Bk8CAvqYz9onSm5j5
         XMk7dNEMo1JtLgagCZu/eFiiV3EYLcvg5gYjQ2FLoME2hOcC5ONjR4iWFpWEIH1bxp7W
         +c8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771363513; x=1771968313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        b=f49CF+u7bli/lg89u2KWVg0LvTfCJMOkprhcrZD2dZZq9Zr5cUtDiQAjRKx4wItrwa
         ftbEI/4kDdDR9QAx8zPtuRTLzCiAX2Ue0UobiIfLOp1bBLWopmjUfYc1kNYw7w3Q4dH8
         Gpo8ABTt/oHx1wNWjE8e3i+1LxKPV6Tpy9F24as0Cvz+TTTAxQXDhZTEpXSPDo2iG7a9
         KhDLhwDYaIDuy8Elb4lDBB1mcX+B9/6cHS/bXjsMEmGk/crL+2fYp67PYvXZ7jdcnDRb
         zv4PY3UIhfmhi8QTjlFgSMR44NmcFOAN/3K+lprpGqbx6KjMQbxRnf14W2Eu9D3hn7f+
         S9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771363513; x=1771968313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        b=WNXmAhUWYABVoDpMkiuveBqGAEovYuTmPhL7NUHwscxOAp7il2tPXz6BqfX90fFE6g
         9db4z29PnlNJ/xvDDG489JhCy2BHes0x5Ubb3pSaw1EVBYBeHKfPePOAPbDw3dh+f1qv
         SpisXkgI8ORJ25hTlJqLd0Dx6iwgn3ExKevvFf5KyjkU2rS/S30eu0pqX80NekkOs46d
         eC3IJg1TyscLOx4ToWDIwuHov8VKX3X09sWNvKXCqNos8GVnCTpkFYXlHlAMp25n18Mf
         Zh2MJrvwmouG98yPHLyTeMdpug7p+n7bAuvqUVM9ywWr5WadADmkRTqbkekkh6uW9zJi
         ocVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGrMItrijsGTF9EhjodQRnQ68Y+eW8R8qceLwtlZdQ2OIBtbJeYc0/fQFvuQ/IEhdyVyftd+yXtsF26ZOn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CEHz5h4Xvq7LTdT7vnlFfCD15cIU8fpEpmcSorBqkoeeMQ0z
	IiwLSqFUq8dnvvUz30did6GAh8UwbUtCWE20qAygF1K1UlkKIkohvDMqsctwBhOOqWNzlmn701p
	v1qvW6n28yrhBBVZUzl37VLmziNJCz+I=
X-Gm-Gg: AZuq6aKWkQUK4zk/w7BXlf36rTJjnU4nrfF+Qe5IBKPbyaPoUl8BCdlASFc7Dsbcscu
	FrCUyVRGaswc0noDCJ5xyW/bT2RbXdt0unNhsM6CNJy4Dj3IlVHrddEHtrlbnD42H/ykao6HaJt
	dYprjnSNo0U9HNY7emTqy5k1gF68sA4i5rq3HLb0CSrO2MkJhO/98p5/XIeNrPw5Ov1ViaarOZT
	PpoQif9Anjvv74fqkKp/pecS+xYrNX7Tvad4hPV9rbxouC9JocYBg7Iti0UAxnbqV2GLNXWf9bV
	/6Icw5/PJ/AN3fo0sjY=
X-Received: by 2002:a05:6402:1470:b0:65c:63f0:a92 with SMTP id
 4fb4d7f45d1cf-65c63f00e8bmr1535827a12.23.1771363513152; Tue, 17 Feb 2026
 13:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-3-tjmercier@google.com>
 <aZRAkalnJCxSp7ne@amir-ThinkPad-T480> <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
In-Reply-To: <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Feb 2026 22:25:01 +0100
X-Gm-Features: AaiRm51TQrPoY4M1hB7zomqcMjNss-PCU-arAe40VL9qb1hRq1aV4JYHGiHMROc
Message-ID: <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77403-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: A3AE5150BE0
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, Feb 17, 2026 at 2:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> > > Currently some kernfs files (e.g. cgroup.events, memory.events) suppo=
rt
> > > inotify watches for IN_MODIFY, but unlike with regular filesystems, t=
hey
> > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > removed.
> > >
> > > This creates a problem for processes monitoring cgroups. For example,=
 a
> > > service monitoring memory.events for memory.high breaches needs to kn=
ow
> > > when a cgroup is removed to clean up its state. Where it's known that=
 a
> > > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > > service must resort to inefficient workarounds such as:
> > > 1.  Periodically scanning procfs to detect process death (wastes CPU =
and
> > >     is susceptible to PID reuse).
> > > 2.  Placing an additional IN_DELETE watch on the parent directory
> > >     (wastes resources managing double the watches).
> > > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> > >     descriptors).
> > >
> > > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED event=
s.
> > > This allows applications to rely on a single existing watch on the fi=
le
> > > of interest (e.g. memory.events) to receive notifications for both
> > > modifications and the eventual removal of the file, as well as automa=
tic
> > > watch descriptor cleanup, simplifying userspace logic and improving
> > > resource efficiency.
> >
> > This looks very useful,
> > But,
> > How will the application know that ti can rely on IN_DELETE_SELF
> > from cgroups if this is not an opt-in feature?
> >
> > Essentially, this is similar to the discussions on adding "remote"
> > fs notification support (e.g. for smb) and in those discussions
> > I insist that "remote" notification should be opt-in (which is
> > easy to do with an fanotify init flag) and I claim that mixing
> > "remote" events with "local" events on the same group is undesired.
>
> I think this situation is a bit different because this isn't adding
> new features to fsnotify. This is filling a gap that you'd expect to
> work if you only read the cgroups or inotify documentation without
> realizing that kernfs is simply wired up differently for notification
> support than most other filesystems, and only partially supports the
> existing notification events. It's opt-in in the sense that an
> application registers for IN_DELETE_SELF, but other than a runtime
> test like what I added in the selftests I'm not sure if there's a good
> way to detect the kernel will actually send the event. Practically
> speaking though, if merged upstream I will backport these patches to
> all the kernels we use so a runtime check shouldn't be necessary for
> our applications.
>

That's besides the point.
An application does not know if it running on a kernel with the backported
patch or not, so an application needs to either rely on getting the event
or it has to poll. How will the application know if it needs to poll or not=
?

> > However, IN_IGNORED is created when an inotify watch is removed
> > and IN_DELETE_SELF is called when a vfs inode is destroyed.
> > When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
> > has to be a vfs inode with inotify mark attached, so why are those
> > events not created already? What am I missing?
>
> The difference is vfs isn't involved when kernfs files are unlinked.

No, but the vfs is involved when the last reference on the kernfs inode
is dropped.

> When a cgroup removal occurs, we get to kernfs_remove via kernfs'
> inode_operations without calling vfs_unlink. (You can't rm cgroup
> files directly.)
>

Yes and if there was a vfs inode for this kernfs object, the vfs inode need=
s to
be dropped.

> > Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
> > while watching the parent? Because this is not how the API works.
>
> No, only on the file being watched. The parent should only get
> IN_DELETE, but I read your feedback below and I'm fine with removing
> that part and just sending the DELETE_SELF and IN_IGNORED events.
>

So if the file was being watched, some application needed to call
inotify_add_watch() with the user path to the cgroupfs inode
and inotify watch keeps a live reference to this vfs inode.

When the cgroup is being destroyed something needs to drop
this vfs inode and call __destroy_inode() -> fsnotify_inode_delete()
which should remove the inotify watch and result in IN_IGNORED.
IN_DELETE_SELF is a different story, because the inode does not
have zero i_nlink.

I did not try to follow the code path of cgroupfs destroy when an
inotify watch on a cgroup file exists, but this is what I expect.
Please explain - what am I missing?

> > I think it should be possible to set a super block fanotify watch
> > on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
> > do not allow this right now, I did not check - just wanted to give
> > you another direction to follow.
> >
> > >
> > > Implementation details:
> > > The kernfs notification worker is updated to handle file deletion.
> > > fsnotify handles sending MODIFY events to both a watched file and its
> > > parent, but it does not handle sending a DELETE event to the parent a=
nd
> > > a DELETE_SELF event to the watched file in a single call. Therefore,
> > > separate fsnotify calls are made: one for the parent (DELETE) and one
> > > for the child (DELETE_SELF), while retaining the optimized single cal=
l
> >
> > IN_DELETE_SELF and IN_IGNORED are special and I don't really mind addin=
g
> > them to kernfs seeing that they are very useful, but adding IN_DELETE
> > without adding IN_CREATE, that is very arbitrary and I don't like it as
> > much.
>
> That's fair, and the IN_DELETE isn't actually needed for my use case,
> but I figured I would add the parent notification for file deletions
> since it is already there for MODIFY events, and I was modifying that
> area of the code anyway. I'll remove the parent notification for
> DELETE and just send DELETE_SELF and IGNORED with
> fsnotify_inoderemove() in V3.

I do not object to adding explicit IN_DELETE_SELF, especially
because that would be usable also in fanotify, but I'd like to
understand what's the story with IN_IGNORED.

Thanks,
Amir.

