Return-Path: <linux-fsdevel+bounces-79797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKiLNUPmrmmsJwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:24:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234D23B97B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 280E630C8E60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDAB3D904D;
	Mon,  9 Mar 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMhH6Ja4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016527A477
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069338; cv=pass; b=tND3rDP78RTzG5rh3AmN3buEvIqXpqKXzyfgwzH6O8dWbkEFyivOeGM84gdg+BZMr7lBjxOxLjYIdDAPlyBy6jX+59QwCxIOYarw6FQGcVc0rQeei16Bkts42CoyETe1S9RFDUiSVxZflAVqRIwDDlQojYis26K4xuSPG0AH2rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069338; c=relaxed/simple;
	bh=2PuDcjpRS1NJ7GvRQc4ZzBsYf94LTzMCFi/bUqxcDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmrY/inDVktChOtt+zwPkHYSwEi20r264lxUUSp9BnMn6WKbjXinJjCJz8WbyahKNjgodoKFR27Hwz8bp9JJEByJ+/r0X3vrZAsd6ilEOdPyjNh4rUBlEmPrtUzn8vOOMfY3KAuveyTnMZtF84pwmcGAJylsZt6N9tk/M39BARA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMhH6Ja4; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so15888a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 08:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069335; cv=none;
        d=google.com; s=arc-20240605;
        b=fL3FkshNw1mPECDR+b4sr9Vd0UTAFzH4KfOjsRA6qDY1h7MCaG9vhb9bLgISl4nu9n
         Xdth1s2u5V57nvb2b0RSIvcjyh39gKf+iuQ/3xUq4otWilBvCtHRE/mU2YENQmEscShf
         IUos3wxBXSqFz/tQpQnQxZY7VqZ+ku36HdokKbF3y/MzWstJBnRXXypqFbkCOhV0Ds82
         i1goL1mHQv49n0NDiD2pkapol5WUTotdsXhcLNSY++S9ZQNw58dgs40Gwy43RSgh0mLr
         iYZyOLPsCub2kaeK4zZFqZFdJj0XnVpg1gFQp1cpVb9sFuj9XTig5o2YH7OQIWUluh/Z
         sT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2PuDcjpRS1NJ7GvRQc4ZzBsYf94LTzMCFi/bUqxcDOY=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=PvlCNYOc/+/DBBPQKtsyCvH0P1mKLkT6FUO4dV3W5VZG1H78B/ubeyeMNN8TbAh1W7
         TKfu9ccuvpqkSIwJbx+6m8dxQ7OLrHUfMZA3UA6V709JoR1COWMjwa4Jket4eNYtyZd5
         9n9X0vWbEuE2yCN3Kax+FYViEfre4gkZRmlotKo2LmGuTMb2gYQ5AuDM7V/DMksglTl5
         WNIeLe7o6Vfld2D+Ta0Zgcyu5NaNVPq0crZJlJ47h/KpwUW63ffUjcNATmcRzVJcxfRP
         wv4msfwG2TSjh2V+0bgrKZIkEfJTTSTnhjX6QfTw/PHLJEAn8MqXAGwtz2qbUTamRzMf
         U7Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773069335; x=1773674135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PuDcjpRS1NJ7GvRQc4ZzBsYf94LTzMCFi/bUqxcDOY=;
        b=WMhH6Ja46G9t/h5IZ6gFCGcDbDF50ExoeYQ4J2PDrSMccJE4a8yItSlCvng/sK1WCH
         5vQ3jx+CvnLbVlVt4NEO6ZxwuxJncTKBTYK5dYoY+h9L9dulvW+KEklcPsXnStnsc2fS
         5213RA/hF7i5dFvW225z7DPJt4F97yoAfJCarhzYkupOV/M1m6djvxcLjhUya6+VMtUs
         /2utQ/r9YDMYKZDT+WTnUagmDOhbA257nNvJn/9ef9A6KkMi2CuDrlrG7hI7nkBc14So
         r8aVXjbepHo4iarJeEOsmETgwUOu7/Doo/oyOXfT1WjjXyQQPas8UvRV2FjVkLWGJlL+
         ETtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069335; x=1773674135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2PuDcjpRS1NJ7GvRQc4ZzBsYf94LTzMCFi/bUqxcDOY=;
        b=cPJObDMz0Y4RThdnvv12AnSWD1HEHE+66KJLymv1VJaZACQfZ0h+kJJZpHDg3PAy5q
         g9WLZkl8pI88ayZ/r6vMRX2jdZI1pFcjkhnYZTl4HQTDpNMvuSI9og+dB5OJ2RN2sfxM
         3LNjRsqla05SsF2Ro0XfySlE9VKTuqRo6PMCt+IBQmbIbnEyJlAdWinKkBT+IwAX7Slr
         aPsioD9nCO666EfFWeAN3WWEu/eDZaQECpBIcH1CwVflgRsw6O13SOkgJQk9iPpylQeK
         87BJI0Z/YjNZ1SjByIJ3nZUeKPmqR/Tb7Uhsk9GEAKvObWYwlR5ECPWHsGQ715Lft3NX
         j/aA==
X-Gm-Message-State: AOJu0YzcoigmxwqMD3HPgCi5C50qU0KfFCj/FUdNlQhdXjjwyLKqzn7b
	L/6go15421/Hm8C++oJLRkXBWkpl9rPKqDnBl3pJCf9A3uGvenEgU93B1XkzOOTVesizS+Hzz6w
	RDAN4FP0xplGdry7f7epJakf0pBi/JxSjHENWohV6
X-Gm-Gg: ATEYQzzgnd5ODPNcWwQdK3hWl1UyzfRGmEpbkTTOLrdlPYnibBgR5bzXnoeVmtCzXgD
	5hRvSfd0uBgMNdQG+k15VGTtfABe2ESKabUWACwYWAsuecyTmYdNdJyzCvLMAIjR9cLPbtQDJOQ
	WafuEleU9Usk7Uhgjd6eSvK+zRf9m8E6GAELBZ7h7qfrobXxuuU/K/c7ZMhXJ+U/7VD11p+YrtO
	xVybq5Wp5Zd1msXhpywzIj95zc/OIGHN7KXuxwJ06myKx6Xnz1Um0/Gi7DHFS+Mdx5MYYYWgcqW
	Esdc/uJ3tE0ZSCzLPTThgJel8thG5mZ91gFCtA==
X-Received: by 2002:a05:6402:518e:b0:65f:76c8:b92f with SMTP id
 4fb4d7f45d1cf-661e54e38d4mr74398a12.0.1773069334944; Mon, 09 Mar 2026
 08:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org> <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Mar 2026 16:14:57 +0100
X-Gm-Features: AaiRm52h_81Vv2l0VNWbgaJc4p8gEQFQsnjF5MgeE7H0End-yVZmP6UYLahCTWM
Message-ID: <CAG48ez1Zsau1zjm0CnKO3sMMRHExcucemFW4o=rdurz2y6cV2w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 15/23] fs: add real_fs to track task's actual fs_struct
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5234D23B97B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79797-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:31=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Add a real_fs field to task_struct that always mirrors the fs field.
> This lays the groundwork for distinguishing between a task's permanent
> fs_struct and one that is temporarily overridden via scoped_with_init_fs(=
).
>
> When a kthread temporarily overrides current->fs for path lookup, we
> need to know the original fs_struct for operations like exit_fs() and
> unshare_fs_struct() that must operate on the real, permanent fs.

Note that there are remote accesses to ->fs from procfs, including
(idk if there are more, I didn't look closely):

 - mounts_open_common
 - get_task_root
 - proc_cwd_link

These expect that task_lock() keeps the task_struct::fs pointer
stable, and I don't see anything that prevents them operating on
kthreads.

You should probably ensure that remote accesses to task_struct::fs all
use task_struct::real_fs, just like how there are no remote accesses
to task_struct::cred - that makes logical sense since when userspace
queries a task's file system root/cwd/mounts, what the task is
currently doing probably shouldn't affect the result.

Then you could also change the locking rules such that task_struct::fs
has no locking while task_lock() protects modifications of, and remote
access to, task_struct::real_fs.

