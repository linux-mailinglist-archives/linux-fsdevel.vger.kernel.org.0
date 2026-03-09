Return-Path: <linux-fsdevel+bounces-79804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EcxOcLsrmkWKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:52:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595223C1D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C95330721B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E23D6660;
	Mon,  9 Mar 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNnQ2Xp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B035FF50
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071255; cv=pass; b=rdOBwbFESR9yJxLsz/YEeJz0X3w3kIZpz0tfKs0n2Z5BrdLDWPgsKSlpTXJ+nkXAP7a+4vHjtzIg82FcS8ZMFW9kXVZyTJedEEDAh6jSjUelJsNHsZ8ZL/IUY0Yg0RFw25jblVDTJGisgyijc8RHukU8vboQvvm8ry4RnayWVAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071255; c=relaxed/simple;
	bh=AWcg7Gn+oiGEab7vbKYeZk8hrDdXKLO5xS5NVoz4S5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtGSiPjOOWjTGqGXfEQrSGAOEFKFnKzacD/OB4epMJ/kTDHfqmHJiB7KWLgJykSGCn/Kg38SdmiA82mRQLoaeMMP1u4QV8J2u6t2stCwxQo0Q1Z1mlVIgP+q10zZ7zHKYROlmWZ6mmaVw3ZOWGjQgS6YpbKzokjC5/+cvV7rwN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNnQ2Xp8; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9423d62cbbso447165566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 08:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071252; cv=none;
        d=google.com; s=arc-20240605;
        b=HAI2X/btpczVbn/GYUk28asMwYHysbCP2QSNgNs/3UqsBpXpWeP6yHe3hMthzMxT3X
         OBZlSnGPFV/d4k31zalh7j3y+NsaZz9wGzdJu1lxvjxpjaL5mn14osvAta5AVTGUpKOP
         NekHjgl6xJUTXlr2PUGw3L80QJFO6+bDAwg0VCqvaUYuzcKIUGfUuiD2RmfeytcDcqEO
         q3leul+d75LHnXtjYkS1MgjUSz3vD2sX08jzIh1hJpHj08vvaT9goCkng6RoHIb9EHa0
         eybgg1I9CvIpLM6lQO5IIiUmYLO5BLji3b5VyHlZ1pVildw3fQMtQXh1fzdZo9Cu+LYg
         Nw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AWcg7Gn+oiGEab7vbKYeZk8hrDdXKLO5xS5NVoz4S5w=;
        fh=/XnXfljYhnWBGw5kFERNibIA2LnFyKGlyzp0ps7nXoA=;
        b=Zk3g5A0RK82RU99xJDsNEwIJ8TJX5jrnKp+40AjymqtGVAe2bvi9mqxUDZskyOe6EX
         hlSIijEKL3sFMvgd2A7+cdmDkgJNkAdb0cW2l4FRlU8mLxlE+dKWqigMwQ9JEV5ZjW+Q
         /PnwV++h3q99+m17u55fnliYpixA0upKS+MLPSAx+yDkM3j8cw02g8KdBcsZftVLLkYP
         iogfyScjv24V780hGZmxGYkX42ZA1xpc4BN70vulJzVuDNUGeP1ex1d7JArrUZs9cfr3
         H66zJldBlVFYwOkcqynDVrvdaUyZmsd3cAuJov4+aHDPW1TRrzIkNdAELG0C4iacczkV
         tqXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773071252; x=1773676052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWcg7Gn+oiGEab7vbKYeZk8hrDdXKLO5xS5NVoz4S5w=;
        b=RNnQ2Xp8GueIX5te5SkrKfVqYLRFM3b22gecNba0ZJgKoSk/lDyFWrF/uPNsF1TYog
         Wd4G/IlxI02eqwcl7Ty3nRnJblwSel2rTipqOoqBKKMux9Ar/RBmpnQP5AniZXtC2C/c
         8ExFBBWPLzzTFh/5bIp0htCGZASlCoCGXd0hZOqsVbf5sPHCSzpLgp/Dw56ez3+Iz28Y
         hAfRIBvPVBnGj4XOIR+/8xZPY1pQSvdLeKZnL6yVZW0k0AKrkFngjgRUj/8bX4mBsNT6
         ZxXep0gVCdfH005Lby3au4FBTn2QPXx2oX4Qi5b/OP85EOyRtTAIfahcC3n7xrR6xiRd
         0oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071252; x=1773676052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AWcg7Gn+oiGEab7vbKYeZk8hrDdXKLO5xS5NVoz4S5w=;
        b=rIoPKWDvRtVLKdzG9pgD8Jh5rCAk5VAZOKqjIHtb5+1EGmxdaY21LucGlRftPqcDHu
         I+a1JwRHogrSgZ7HU9W4XroHG+nHuu3qhsBejO0e7BQi7jLSrDyRT92kBxVm2m7aafcj
         NQZw88xVqdvA4frF1g78xmfhBDOgYx3vigyLY+LU634TbVHR9q43ESaojCCcSbX5DkYh
         /aloTmwxYTgBZRdDxe5QIX6SjIj9kcYMd+cYEPdSsaHCn6ueIiDBIu0g3CfX/b1y9CoC
         P/pA8965cYuWxW06EREeg45y9BkUNapkc2wGAQ6LVhZi4796kaAjWJ86Bu5i7ITr8QAd
         A6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVvEJw7oZTtEhlwETu10KtkUF3gr6PyG1KozsqgwPxDAuBYLm0QFW6ivB0AqBH/CL1ElOZ4coYewMEjBqDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKCclSKToxnXoVz4UtsUL8oDhL2nnoceBp9pLNbMB3jmcRthN
	nVcDAx4AutEJS9TgoIT9nxTEm3ODJPdW2oJACtfoKUt13Bjc/RVtVBjtcT1E0NnmHHGYQ83BbiJ
	9ku95+EcqLgwqmYsbqFQ4yWP0pYvqfJ8=
X-Gm-Gg: ATEYQzwvZNwrgHEf8riDExKB/sVXWzHRmM17VjQGwY22zrFCCws45bDQK+Tuq/ab62v
	x/AjFxFH8mGQuEicI1HH7DAyjfSC3S47o3EDYfNURh6a3i6WwiqfwpGP3ccRJ1EQFdy2QkLZoc9
	c+gb1JIwjBKcBxiW8/PwPJ7fmE5EKehr0bA1N0bLvPmdhxy0JUbElidTDvgGcpMTKUmOk/Hup9r
	SKfhWkyAtdlIDutjOxTy0j68v8Jf1Xvnm58gF9yea+fNUtTBye4e6O9Gc3C7GlCTq594jHFEU9o
	YDADPpybKtEz8UDYYdkPT4GFZbRimuvB68Wn9p8A
X-Received: by 2002:a17:906:f596:b0:b96:f4f6:2a02 with SMTP id
 a640c23a62f3a-b9711a76a7emr2591966b.25.1773071251580; Mon, 09 Mar 2026
 08:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307110550.373762-1-amir73il@gmail.com> <20260309-einrad-mitarbeit-18397e65afd3@brauner>
In-Reply-To: <20260309-einrad-mitarbeit-18397e65afd3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Mar 2026 16:47:20 +0100
X-Gm-Features: AaiRm512di5dV0MRlvDLCP-8jOD5p0b3zQc8c8g7_80hs-DiIj3ENIt06ur3Pzo
Message-ID: <CAOQ4uxgmttSum2a2gKBkpdzg4110rpaH4mayy=9+QzWjFRNB6w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] fanotify namespace monitoring
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Tejun Heo <tj@kernel.org>, 
	"T . J . Mercier" <tjmercier@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4595223C1D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79804-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:33=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sat, Mar 07, 2026 at 12:05:45PM +0100, Amir Goldstein wrote:
> > Jan,
> >
> > Similar to mount notifications and listmount(), this is the complementa=
ry
> > part of listns().
> >
> > The discussion about FAN_DELETE_SELF events for kernfs [1] for cgroup
> > tree monitoring got me thinking that this sort of monitoring should not=
 be
> > tied to vfs inodes.
> >
> > Monitoring the cgroups tree has some semantic nuances, but I am told by
> > Christian, that similar requirement exists for monitoring namepsace tre=
e,
> > where the semantics w.r.t userns are more clear.
> >
> > I prepared this RFC to see if it meets the requirements of userspace
> > and think if that works, the solution could be extended to monitoring
> > cgroup trees.
> >
> > IMO monitoring namespace trees and monitoring filesystem objects do not
> > need to be mixed in the same fanotify group, so I wanted to try using
> > the high 32bits for event flags rather than wasting more event flags
> > in low 32bit. I remember that I wanted to so that for mount monitoring
> > events, but did not insist, so too bad.
> >
> > However, the code for using the high 32bit in uapi is quite ugly and
> > hackish ATM, so I kept it as a separate patch, that we can either throw
> > away or improve later.
> >
> > Christian/Lennart,
> >
> > I had considered if doing "recursive watches" to get all events from
> > descendant namepsaces is worth while and decided with myself that it wa=
s
> > not.
> >
> > Please let me know if this UAPI meets your requirements.
>
> I think this looks great overall and is very useful as it allows to
> monitor namespace events outside of bpf lsms. I agree with the
> non-recursive design. You could generalize this approach by deriving the
> watch from the namespace file descriptor? Then you can get notifications
> for all types of namespaces.

Not sure what you mean?
Which type of notifications?
This RFC generates notifications for all types of namespaces created/delete=
d
under the watched userns.

Which notifications did you intend to watch for other types of ns?
DELETE_SELF?

That would be easy to add.
Would just need to move the n_fsnotify_marks/mask to struct ns_common
(also from mnt_namespace).

>
> If we ever want recursive watches, then we just need to add a separate
> flag. This is only applicable to userns and pidns anyway.

Yes, if we wanted to.

>
> I want to put another - crazier idea - in your head: Since pidfds are
> file descriptors and now have the ability to persist information past
> pidfd closure via struct pid->attr it is possible to allow fanotify
> watches on pidfds.
>
> I think that this opens up a crazy amount of possibilities that will be
> tremendously useful - also would mean fsnotify outside of fs/ proper.
> Just thinking on the spot: if you allow marking a pidfd it's super easy
> to plumb exec notifications via fanotify on top of it. It's also easy to
> monitor _all_ namespace events for a specific process via pidfds.

Anything's possible, but we need to make sure it's worth it.
Aren't there already enough ways to monitor a process via ptrace/landlock?

>
> This obviously needs some thinking wrt security etc but I just want to
> put the thought out there that the integration of pidfds and fanotify is
> possible.

I was thinking more about watching the entire pidfs space, but sure.

Thanks,
Amir.

