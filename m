Return-Path: <linux-fsdevel+bounces-76963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6oB1K7jGlgsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:24:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE78126932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F6230131F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852421B9F6;
	Wed, 11 Feb 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9IQqnIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7994207A09
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830669; cv=pass; b=pbn91hbUTB1DZpfQC4PII5gHIudqX07rt1tQCWMqR6B74fmCFyYHFoedA54XaC8K8dyeF/RhcPxhVwEhJfWqLuzoshCNUlbEDdHBszJVooYGFYXb0VxXo0hVxJa4D1j8e/HyvT6ykOGxlgQ53I60fPHHQvfDOiRj8XP4Kb2JFUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830669; c=relaxed/simple;
	bh=HNT7r1+w4vEgE3lTcdmxLKz/yt4Vcq1i3k7B3LnDcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaZL9dvWr3hvCX/42+BFpa7f4oLxiGW8n5yQKWeZumacX8aGXFLywCqY8bByGnLD78da7P1iDo1GAnjK03ID9RXN67OKmUfTh/Q4XxmAocLSpXrB7et52ReJb0oxDQiw9EyXoWp6K9Ni6maocEprNDuA+cHrb57w/7W8plyFfVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9IQqnIJ; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so6022035a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 09:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770830668; cv=none;
        d=google.com; s=arc-20240605;
        b=g6Fy+XNPbnVqJA9/xU18lBIXv0IWeLrNKLQynlmOvxclNolT4gKgQWs3y6Z1tWPUAc
         SES52yXRc0aCBgJY1rDjkph6Bo5BQz4gllFUNHCiyoIWaObjGnXTvMj55yTkPTNznbk3
         O0OZvRB/g8S0IoM6fbmcFf+BQE2XlDM4Pmp5Lpxp2ghKnXkrgmhCMqZVslmvozgAekie
         nxCAqrAFcTkJljcEPjv69fn8ZWtWvHE0Ag1Tm3HLH7mNdHBoO0mW9tVnpfXuwJKHVw0M
         qXsYWQkK7o1QXkwbfQQDLNiiDkHVAVXYNHcMq9d9rSLVcPYjhwnihGeEFc0BCg1WUqYu
         APLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        fh=/nn9EjeKeQtfKBMPMhBv/LBCvbx1YoL3ueKuB7tWIK4=;
        b=XNoIvYOQBFHqYOwMwLXoK62d+9IHrmjooA3Ff2gPPwG480I58RKH9kvwp9YBM2JVBH
         pjTBDqejGtNtbacbA/tDtK4dQjnKTpifPwNV8L9WnfNP7ME4gZH5h03pdev5v3MewSx6
         2fUL+K0S6ZKm7XfhwSDv5zg3roxN47CUlKeubRhuq4PL/DW/9UomCKUwxd89y6lYXkEs
         OgLimexoJEoflUMy4iic0XTWgvLTVZ6wZGZZJUCw3vFWNbNppVZZv0B4RmNVyrt7gjd6
         imfQt0RpeX8b6x1Axl5Ku1OwkwanwPC+nrRoqaGjA2TuRjK0p9q4J6MWOfQ7KTFPLfhB
         NO1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770830668; x=1771435468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        b=P9IQqnIJPdXrixT3QE92yW9wRn70N4h+ikEurPKnhUBZfDTlimJNBz2YPYQakS8WQO
         kzlQT1dT4/yxcjmDG+4C6rp2oOABImv17FQmWWWqjG7+dUkvLJoAG9RCrG6zypGSOJJY
         JOBMppUX52Bbyy0BLRA/qHXPiMr7k0vvr6BZo+cg7JhE7jIjjCAJntaR9KS+9PUd+qWd
         VT0AO5cRcBWIkM+9NmD1kQDO8qga3Qtf6fzZB89XtA/JA7SOfxzKz41uaJzmafGree13
         rDRq+87vyYDqhMrpF2NfeRLdJR2LnHtUnCq89YrA/8k8JE6azsB1ol3O51q/SgBn8Uaa
         7Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770830668; x=1771435468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkJlBAcI1hbVLg//alG/mLpM3uEJ/fWZ3GRfLmdUlOQ=;
        b=q3RM7BnvSHaaKCf9ftkCbUVKNIcXwKNWuFSziGtppfkthA7tItuNXl77w7Csrh5OWG
         UQnGvpe/BIYwsRMFC51Lk9Qaeq8XeE6l7GwGNMfjY9Udczo6n6AnNNf5tEFYN+xfvjmq
         /CUBck9pZIP0ihJi5wvYbL9Cgea+0381yD/w9du6pSb0lXX5/Rez49LaQDPkzAAMJ58m
         UWG4BOvoBSYfWZdbJ0/yPiUZz0cK83ywxwOW1U+1EcGyGKceCqPz5gPjUbiVrNHgdRCq
         JalVv1f8ZlJwBRQluZ0O3uAHd0h/PGnvg64m9POrVKver0iGpcuQ/6s8CvYJuTHoWKsW
         PSFw==
X-Forwarded-Encrypted: i=1; AJvYcCXC8nuQsRkSF/OLL0u/fekN51FMrgQiPd4otKBwrWy/krlgxENnSIO+BkEUczfDu6TmIT8fGdk2eBuy8dd/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8WVKJjYpoKKW3DMgreR2SQWyUsCpGKhxYBpnZ/Gko2YKjS6q
	Zn7Xf3jT37J1GY+yu+6nwvGex3teInIKL+pQG+iTFxforoTRRYxTnR9+tALV8R4sOMFUMVUGTUe
	1qz5N3AAKfvRmRssEMt73dgqZZuBHRdw=
X-Gm-Gg: AZuq6aIDCl4MJyhHWAt5UaZ6Xb+Gibu/77fYNkY++fcaDgRI4zBatTZsun3GXVrpe39
	zzQdjs12D0BTdPUi6Lfu7n5AaVKvC0CG10X0bzkTSUhiP095WPwg7DVCt6Mt4jnr+eCne/MEFqF
	ZSOGFOdHcPBa5jmi+z9nqhA7gVtWh2LJeWdo+GVY/4bVV+GAPNjzZYIWRChaTS06+Ep4XiYD8nP
	NYULVdKj+qC+M/z62AJwkUdh7IeccquVXTbcdAG8foquyaX0LCCpkKiCZXKoG5mq/glz5hdgyZe
	Jgyh0JZaZytzK9Qzo8c6OJhgPdLH7PEO5g==
X-Received: by 2002:a17:90b:2d8c:b0:354:a05d:9dc2 with SMTP id
 98e67ed59e1d1-3568f300d31mr166515a91.9.1770830668125; Wed, 11 Feb 2026
 09:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <87qzqsa1br.ffs@tglx>
 <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
 <87ikc49unc.ffs@tglx> <20260211115825.MLF4L4Jq@linutronix.de>
In-Reply-To: <20260211115825.MLF4L4Jq@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 09:24:15 -0800
X-Gm-Features: AZwV_QgFyUjXcS1gGGgxoc2k8MO_QzouXEXMD7Ys2j6dTV10vd1FV26Sc5dH1cA
Message-ID: <CAEf4BzZ__PYqiYEBxJQhAaV8fyNYSmDB5rKDGsvmpXG-Vu4eMQ@mail.gmail.com>
Subject: Re: [PATCH] procfs: Prevent double mmput() in do_procmap_query()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76963-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a,237b5b985b78c1da9600];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 6CE78126932
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 3:58=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-10 22:05:27 [+0100], Thomas Gleixner wrote:
> > A recent fix moved the build ID evaluation past the mmput() of the succ=
ess
> > path but kept the error goto unchanged, which ends up in doing another
> > quert_vma_teardown() and another mmput().
> >
> > Change the goto so it jumps past the mmput() and only puts the file and
> > the buffer.
> >
> > Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA=
 lock")
> > Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > Closes: https://lore.kernel.org/698aaf3c.050a0220.3b3015.0088.GAE@googl=
e.com/T/#u
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>

We raced with Thomas sending the same fix, I see that my patch was
staged by Andrew already in [0], just FYI

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patches/procfs-fix-possible-double-mmput-in-do_procmap_query.patch

> Sebastian

