Return-Path: <linux-fsdevel+bounces-77856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAHTHk3ZmWkkXAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:11:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E416D3E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AAA2301BED6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF72E03E3;
	Sat, 21 Feb 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUq9u3+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9962DFA31
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771690304; cv=pass; b=YRb4Z9MUPNDulYmXvQ/ONU84M5RQtQ6/vnU/vv4FIid4BPFIBFpqd60o9vcbSrYC6hMjEiHbbdcZ49I0lnPJ2XJDZ6Lu+1GU0zpMAFR+KGKslSSkapylL8rTMTbECNLhMMdcALpMEbKU/XbsHDInSHjQrzyMc3GEn/UcPhYAdeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771690304; c=relaxed/simple;
	bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZnyV5yIgknD2u55Bac8LZuUTlBgoNvxjyUrHmQS/ku60rMdJhYJ5Awc1964no0StlEEzrjiGix7TiGAR/Hj84muTCvpkv1FgL8Lkqmh8AvUf+wjv8pRIsEx7ockhequfpohO0L+qMj8w8o5cAaqrOLO7fikyrtjoDvyulhl8vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUq9u3+l; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f7a30515aso352548966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 08:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771690301; cv=none;
        d=google.com; s=arc-20240605;
        b=YrLogvNLzcD8jZGpRdGIMdG1PmnUSPPgOLrQEv1BYjFebQNsrRXAS7J/gN44cVojBH
         1n/wAr6HFM5XIaF5KQMuwlcjh1h/5nq+VXbT9ZF+swHsqdIq3A1aiHjgo33DoSX+1Sb9
         Av+Ag72YgMQ8BRkN15lNnP3/PFmzZeuRzoRGvx/9O8+0awGBB6Q7O7338/Tvf7j/gllM
         KZZsgLT0yQZRGs3IVACdC4T8XE/fsY5P1LTmhMTe+LpEIipcc1Xxb1kOUY5bOtt4CJOv
         eNCIE7hZyVOap2GBPXJ6URF8mcc03Gco4O6o8FfgIMGAw2gEt4cbmMMI69CeWYZ0sI9l
         Nd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        fh=aDskcAz/W9Kfowqx40FuRgOvpWefkdRZel22RlMExi4=;
        b=h2OZuOSD8ySQa/uknHv6wUhCRMSrWyMdCUVFPPldxMl+Hi/P6/U+oxpVqvgEczhnoN
         F64wr/HYKO1Is2Y/FRNBfoYCdjMB7Tocx1uLx2HNDWpbuEwNwOvmE0G8Je+DMnBTV1bT
         O6ByGqzm3gEDV6litNAckj56/xcmkBnEVvT60c3uP+L3J6tLF1EXq63UQHDSru+LVhme
         e52IYTiRa31tG1VHGzzurNhLbRs/9O0OZTNcqpaod+yyPp5nHz0hFP55J8qdNuBrolg8
         q4uVqDa6aRNDejJJj4jzBwoXJmj693qungNqhVltlVXKA8nNLeCHfqfFGthqLUN4+FYi
         0SXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771690301; x=1772295101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        b=mUq9u3+llNJriYI2iwd1k/lQn3+8PEXC+MxxmLdX0Vc+O7L2bRz6K6Vg2tqRQK0zTP
         xSIO3mrf4GBmMe+1tX76JdAyziIp1yvfGsfTbbnP11I6HREYNrbrtWeF6ZmurwzUFMla
         RKnzD6D8LboyPVC5h6EJE+QZOI/yOpXWZDJQKCPyO1YFzqJ7Uu10iwSSQgKdtS1UmA/9
         wj5g4w7bzma9fUx1ocFMwjUouGaUi4gN4uskGBC0e9Wt0uA1bSYORgn8Y6iJuOJJ7vAL
         unam2Y5dvjZUsDfOIbju6Br2uv4rOQvBrTBqQ5nCLsuIUoS8zK9fKuv6N7zJYah6ag6/
         7+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771690301; x=1772295101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        b=g3OOO4Qle+lEVCa2EAq2p10K8Epse5iEp/YGCuTz7iQEqKGvQusvShODJFHQm6wolU
         /q4ga1xpTTU2E1A8SQBjB2SBQZimHK1jT4a19LiORbRanybwMwwny42x6DIzMk56Mygm
         JLiyq+Va0MZFozAqM5lXdylcO/I2WMxwmXeJN//FxndTef3I9u8kYyRLmsUMQXyiCzB1
         wlSf9aP0mYGCu/lFOtloub2XW6/VKBCbf4yxdJJXpu2wwdGQfzmR0YaQI0SG3mHZb5W1
         /A8QnEVS9qI8oXv+GVew54c0XAQACAUT4dc7OzrIbsNML9DHIYvaA2XXZarkJNas4TVT
         HAig==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7lOLuzk/jNoox2RKTTlncPx0axByxAfcqiFlBHFwMrbonPNPucx2nzGHD0HleO4rNllQPPN7s318Nu3i@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQzsGzVTt6hADC/qHkMuqv7iTC1EQlccAfBDCtj26YRZDW1Fy
	frx6aju1S6xkSdEcUWQy2iDzv/NY7K+MiTYIBcJEawAKxuJz1FkFm4/zbpWX+RhV8fEMci4DZIR
	4Q1/ufYdrntrpZlYM1H9qx9RhhW/FoHw=
X-Gm-Gg: AZuq6aL3okDkHNXfenwtb4Jf9N9nec8EirSTGVjBPafoKJn+ui2If+m3N2tntelwP/6
	LK3cr62luq5ADTP8/sxfY9H207WF2l/Ne6C4BTUM/wJ8JV7FQUQCntBC2xSV5WfW7UmRVAs3+/a
	elTyHwMZAo7mQwKhgFwXirKbem+DlupQH5H7QY6ucADStrqcaxVbqOaJazId4HLWQ0+3t19kb79
	B/ZVThUfUSHDdCg5RMS/j8XWKBpcRhfYIXdnnCfx52i5Ewylmr6VYuwHmscnOmB8jKiYnT0sDSd
	meWYby8E67yfwWvZhk16lKpiwqqSeRloWRkPLNzT
X-Received: by 2002:a17:906:474a:b0:b87:7938:7b77 with SMTP id
 a640c23a62f3a-b9081b4adbfmr135784766b.30.1771690300450; Sat, 21 Feb 2026
 08:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org> <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org> <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
 <aZju-GFHf8Eez-07@slm.duckdns.org>
In-Reply-To: <aZju-GFHf8Eez-07@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 21 Feb 2026 18:11:28 +0200
X-Gm-Features: AaiRm50siD9H0RcvpiyV5fyHjGmjcm9TLE2lBYwftlepNHL-uvxe1pX7UaXUvqc
Message-ID: <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77856-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 344E416D3E1
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:32=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Amir.
>
> On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > > Yeah, that can be useful. For cgroupfs, there would probably need to =
be a
> > > way to scope it so that it can be used on delegation boundaries too (=
which
> > > we can require to coincide with cgroup NS boundaries).
> >
> > I have no idea what the above means.
> > I could ask Gemini or you and I prefer the latter ;)
>
> Ah, you chose wrong. :)
>
> > What are delegation boundaries and NFS boundaries in this context?
>
> cgroup delegation is giving control of a subtree to someone else:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/Docume=
ntation/admin-guide/cgroup-v2.rst#n537
>
> There's an old way of doing it by changing perms on some files and new wa=
y
> using cgroup namespace.
>
> > > Would it be possible to make FAN_MNT_ATTACH work for that?
> >
> > FAN_MNT_ATTACH is an event generated on a mntns object.
> > If "cgroup NS boundaries" is referring to a mntns object and if
> > this object is available in the context of cgroup create/destroy
> > then it should be possible.
>
> Great, yes, cgroup namespace way should work then.
>
> > But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> > to report on cgroup create? Probably not?
>
> Sorry, I thought that was per-mount recursive file event monitoring.
> FAN_MARK_MOUNT looks like the right thing if we want to allow monitoring
> cgroup creations / destructions in a subtree without recursively watching
> each cgroup.

The problem sounds very similar to subtree monitoring for mkdir/rmdir on
a filesystem, which is a problem that we have not yet solved.

The problem with FAN_MARK_MOUNT is that it does not support the
events CREATE/DELETE, because those events are currently
monitored in context where the mount is not available and anyway
what users want to get notified on a deleted file/dir in a subtree
regardless of the mount through which the create/delete was done.

Since commit 58f5fbeb367ff ("fanotify: support watching filesystems
and mounts inside userns") and fnaotify groups can be associated
with a userns.

I was thinking that we can have a model where events are delivered
to a listener based on whether or not the uid/gid of the object are
mappable to the userns of the group.

In a filesystem, this criteria cannot guarantee the subtree isolation.
I imagine that for delegated cgroups this criteria could match what
you need, but I am basing this on pure speculation.

Thanks,
Amir.

