Return-Path: <linux-fsdevel+bounces-77806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eImUHvqWmGlaJwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:16:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23C169A80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6838A3079672
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DE32ABF1;
	Fri, 20 Feb 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7lquW24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738E322A1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607771; cv=pass; b=IlrPZ/5gubRuYBjLCzERNftfmN9L/gzwsKbKLsS/FwMcY/HQFPQCbUSQOhQngdqofAGsjf9cQbCKQmZMNeXNcln1Q29503NfYOjGRlp6D+joflYngffVgwuWqZjiF4mG6se1N4wbAMqS2+wfPySgElStm3EXx4junRkg3s+Wi3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607771; c=relaxed/simple;
	bh=qUpADLv3fW4c6VKkfzK/U52QH49WpAV8Od6WUnTJ06g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF6Wob3DHtggsmnB1WruKAgF7cUiUPS/Ohrl5EMrozGSx/6BRbbX7fYvT5t7aBI2tS//k/uy7FfQrqjR5WLNJhShzPZWjhNK9XntKUUvLQ3tzvCEj6/948bTIkXR26cmQMMionp6T11fs6q/POg6nf+xWz6vbP8QujzkZ46mGVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7lquW24; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so3389557a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771607769; cv=none;
        d=google.com; s=arc-20240605;
        b=VvpCNg/Ff50m0sXlGV3RgGxfrwkPudtKSPug84NCBgqv2eJ+T//6VtT3RQBRdKtGE4
         jiHrZ8fz62MmRVEWEsXGj/8HbhTiOxrS4g82vrCj72jy3P/qKYmvRKJEOakuSQt7NbRV
         JWJwvrwQyKP4N/8C0FOEdE+JWm+d4NCiGu4ON9YY834tgiihhPczluDxHKHKde5Mdjcg
         5SzmqBCqmckST8IS2LrkNtTQ0ZAO7At/k7F/7q0EGEzswboX+ZlIFcvfMtYOQk2fAEhl
         zZ60FefYmWccG6DycnNNDvNicEpGIDCnsHRCpzViRf6MqsUZ9Hd0l7QxbrKvnLYALBED
         gYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        fh=r6vw1uwUurd96GRCF2QgVZNh7CZo91vPrxiTdCNPYQ0=;
        b=jLOcfpESUnS2OwXg+x9EMtc3te5EQ32WX6nzSMGoUuOYSUTCOlIMzOq5JICZ1PDyUl
         XegBpQj4OiL71cc8GxnRa2hzCpw+ITsdzHoFmrwp79+6eLLDj8Y2GvIacOFVRVNPg0jd
         5C9d3KRHnku+eMEX2/SAOXoui2JyCqO95Sa+APneq7iC9vFYzY42Zwa2iYz4AJ0Zolso
         Ry2SrkVf/Ys98P2te5dm5g09Qcr6fzHRfDE02I/OuU9VQFUk/qWIgcKBp6I/nIQpmu6T
         uwDrGODCulxxFf85TnfD7+mzdE67bZgxMEAqiDRx5GBrV7q5os+LFd01BoOFy4unYpCT
         FBjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771607769; x=1772212569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        b=T7lquW24vMSRjgoEygIGRyE08/+q4o+RUfMXAZBhrE/0bR2snow2U7+jW02AKYKsl3
         0YinK1VhhMdJbjruFy0rRj7VFT1eAKRxExNJgq+w/96MK3FpoSSbHoiwo568oGgUFcV/
         BadXZPqH8QETK/iUAk+5JN3M8UF9i2vEDzFR1Lh/p/SNlEEaxzxLlhOKAd5iMABhg67Y
         g/Ad2mlze4BV1iucz8EwJBH6ee0Zlnk+ZY8V/3L7z0QnrI3Se4T5q+ukxFzE+g1cD60d
         vQVR09MX8uP3WurKjZkhRDQEA3klgP4YGhWfAa8WAIkHgux/rUjyFrQD1qx6bzq5Ytka
         qlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607769; x=1772212569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        b=s481gYMPSNEcRN+FR06GX82ep8cOs22wTKpIIDaZhExObALUjtVbHU/H+pNtnru3lt
         Obo6R38Hv2FCnCbO5hzzWuccFwXz8B6/j/LhzQek2dJVpUaTOv4kxjfWKT8cApZbqbMO
         CAj3pj31EWC7I1XfZEkqV9nQWCGHrwN9+CrpOEtReXPMG98L2och6DzCXC6OTNZ09dh6
         6yy4YBMgEEs6bvV0wf6yR8Tz85up+pEvzi9AM7EXGfMZQKfswV1z1jaMY/8y3t54yn6T
         WiRXDoVfjkD/WyFfuCwams1rbo/hf1q8J49+GnqOuEvYlAgU8nu+mpE7/HXWEyBvHbcw
         UDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVPJK5Vc1hM36chgCyA3/dawLPdzthXNtPFY5zP0bxLu1JI5d+dKdcGt0AOOnfVBS7qGGfHm8Al1LCZ/Gap@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5WAfkc9id/kmLcdED8tQcDvvpNzPt+xQOBil4qcquRGbjMQa
	nTYYmf6y6WfycjTWsr7vISAnuza13rAHJLGgTbCao5UVzudyms2FEVozDJRHTZWel44BFWY7ZzZ
	eW7gNzXcQ+g8vYLXOx5yl2BnDdLSveDU=
X-Gm-Gg: AZuq6aLCZpg21yQA86Vy4+jpytf7t1m5ngyrza/C4wtxSKk42IMJbB8L4pDNQq2RUgm
	3QnM9XWU5t3PDbFM71UQLZGNc171WSM1TW2epqCrzJMYsN+0mZNR6XXBfjKXczivtnHrd3DYvTg
	foAW1ntxd7ngOzcNZWOVaH3hjDXl2Vh8Fs4QsnJmfUD+vH2rbG98QKNomxhD5dsTEgeKdtzmgpA
	/6zg9rWD3v9T7m+AEUeb3zw9lvGje3JZMd3C8SZMotA2E9pJLzwWJPaSf0xxfDyOm1H9lMdmsnI
	tVGYtOKGWI3lh8C/wYknuJ+YlLS+vKHNmbBy+EJRoA==
X-Received: by 2002:a05:6402:50d2:b0:64b:58c0:a393 with SMTP id
 4fb4d7f45d1cf-65ea4f07f63mr241574a12.30.1771607768401; Fri, 20 Feb 2026
 09:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
In-Reply-To: <aZh-orwoaeAh52Bf@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 19:15:56 +0200
X-Gm-Features: AaiRm51-NxZivWP9n79oFDzWvBAa9d7rBDJz7DAiXkp5nty2l6CfzMRpgIoYHak
Message-ID: <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
To: Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77806-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,memory.events:url]
X-Rspamd-Queue-Id: 1D23C169A80
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 4:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 19, 2026 at 09:54:47PM -0800, T.J. Mercier wrote:
> > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > inotify watches for IN_MODIFY, but unlike with regular filesystems, the=
y
> > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > removed. This means inotify watches persist after file deletion until
> > the process exits and the inotify file descriptor is cleaned up, or
> > until inotify_rm_watch is called manually.
> >
> > This creates a problem for processes monitoring cgroups. For example, a
> > service monitoring memory.events for memory.high breaches needs to know
> > when a cgroup is removed to clean up its state. Where it's known that a
> > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > service must resort to inefficient workarounds such as:
> >   1) Periodically scanning procfs to detect process death (wastes CPU
> >      and is susceptible to PID reuse).
> >   2) Holding a pidfd for every monitored cgroup (can exhaust file
> >      descriptors).
> >
> > This patch enables IN_DELETE_SELF and IN_IGNORED events for kernfs file=
s
> > and directories by clearing inode i_nlink values during removal. This
> > allows VFS to make the necessary fsnotify calls so that userspace
> > receives the inotify events.
> >
> > As a result, applications can rely on a single existing watch on a file
> > of interest (e.g. memory.events) to receive notifications for both
> > modifications and the eventual removal of the file, as well as automati=
c
> > watch descriptor cleanup, simplifying userspace logic and improving
> > efficiency.
> >
> > There is gap in this implementation for certain file removals due their
> > unique nature in kernfs. Directory removals that trigger file removals
> > occur through vfs_rmdir, which shrinks the dcache and emits fsnotify
> > events after the rmdir operation; there is no issue here. However kernf=
s
> > writes to particular files (e.g. cgroup.subtree_control) can also cause
> > file removal, but vfs_write does not attempt to emit fsnotify events
> > after the write operation, even if i_nlink counts are 0. As a usecase
> > for monitoring this category of file removals is not known, they are
> > left without having IN_DELETE or IN_DELETE_SELF events generated.
>
> Adding a comment with the above content would probably be useful. It also
> might be worthwhile to note that fanotify recursive monitoring wouldn't w=
ork
> reliably as cgroups can go away while inodes are not attached.

Sigh.. it's a shame to grow more weird semantics.

But I take this back to the POV of "remote" vs. "local" vfs notifications.
the IN_DELETE_SELF events added by this change are actually
"local" vfs notifications.

If we would want to support monitoring cgroups fs super block
for all added/removed cgroups with fanotify, we would be able
to implement this as "remote" notifications and in this case, adding
explicit fsnotify() calls could make sense.

Thanks,
Amir.

