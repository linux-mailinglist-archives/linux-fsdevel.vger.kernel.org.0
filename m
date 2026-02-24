Return-Path: <linux-fsdevel+bounces-78310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEzOCZkFnmmhTAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 21:10:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7440F18C48A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B5D306147B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D83370F3;
	Tue, 24 Feb 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJcaled3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374E334C3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963781; cv=pass; b=PTsQPlxloJOyUr+Q12CRvzzG+/hVQdT/VFbL7MuhvO7J6Dhd8d2WT+fX0X0i89dSKyAyRzy2N/zC85TpyCh636lsCJJdI8tvFi4jJLFfHfRBOdMzyWuLDI0jdcMm++NSd3m5eVhnoo6unDCypwNbSvb2OZQuJyVh4NcoO1mUdpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963781; c=relaxed/simple;
	bh=2Cg/DXUaQemdS7si661sB6VqKVJNE0PpNQT4QAW402w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3YPXy7sB35cpNXvss1BqOQhilN4/mZlOJRW5x7KQJ/taNlkzu96GiQe/ZQH06+sgEm8Fra1QUGsgcdooagC+mC/j1yQ9S53MjBTqTyvtszbpuYmIfBkCjuo9GxWHGkJSV/5LZ+kncjR6SZi8DhYyDQunT0xwE/xaj08a8wO/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJcaled3; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a1627a09so35698351cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 12:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963779; cv=none;
        d=google.com; s=arc-20240605;
        b=kfDsw5qcmaLcRu4SNLFdQp776oja3K2K/NikpR4cLgqgPyP33u4fksih/oUghZ1TN/
         tniWkj61qie6v71Lbl3lgFo5iVvVjRqx1jFIp6nO9Ohn8SjuBk7OAOgJK89MQPqh6MLY
         UHHJG2n1WM5HPZX+v9DczWe9+c7FDPy8/3CrUBSnhcqeXHYHr/VnMBXVwjkWiw9K/iRq
         61+lrQuNyh46y4pDk14k/bQ+szDqVeqH5eDMrcQ9XBkhFFaD/z70YTDiPe7SICTv9hUt
         HFB5l+zci9NQnYpKQ3sox/Uwtr+UUqfzopDNsBYAeyrHLUOSNJ3crY8itNe3u1LvLJYx
         XqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        fh=zYQup678cPmRqyiBykbnxfbiGdFXsMPr4vyo18XvMI4=;
        b=Jcm6FPOqWuqO7RqMoOJ0v4ykmccRNLtirI3pyuCUZjPqQKvMSCbyDIyTtsI+OrZhth
         LD71NIUTX3Xn7orynUbzXQxvJsagbOGZBaG/0oG4Chg/rZAd5QFa/XzR7N8RY0TyFuEw
         adKJiHKr4vlOV9ADbzHUAujdY4WO34jz9bhNTsrty10opB/l6DQvB8DYrDxaAmz4B8Fq
         8gCC09TJOH2ZyFzcXNAar+djGwYarVi8MQ6QLauXApdBGNzlO7UlkgZfFGyOyK1ZhPcN
         AhkXLyvVcsN8F410Wm0iq3Va/tzYG1dbvFe95XC2mz98arcZgVftni6vHP7GTZUvUFds
         xVoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963779; x=1772568579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=WJcaled3m4rBPyjQcD4YEGhqpMqXciFvxDGDqawJnXTo3PBfC4cw1nBi4+ors4LGz9
         aG0KN5kh9om+TTrTXXFwzDQMGjKIKgBItoEpOQ6c+VxTiS1pBfDZl79MTOYsVBuhEqub
         +Eoz1MvlXYTJFjP7a/rGvujL+ch/6wd/+kZ1YjUPlN7aySKajKYlkZScS28tEZifgG0v
         3cH1dwFvEYjQyn+jHiXRO6DgsQCjIFKWMvyhlDvY4iuXinDF374LYfwTQHctFEHLJ0jw
         RK2SmLpLnmRONJ7JyQYfpmPJuKbaLBpLNzphejagMtsuv4pf+Q7j3u3vwFhpHW7E2E0l
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963779; x=1772568579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=MxO+BNfyujHJXmaX6CAJczQO60NL/XjcaY29Y916tB3Bb+9YbxH1vP36NyhTOevAWd
         VM6ip6NGTCz/PhX02fQrmq5pahTgNF8N6IJ/23Iwd98zaN3VBZvvrjVQkJYeNwQ0iBq4
         xws9qQIasBM8NOd9AyuFHhjMrdbPQhkmAyCZGsE03nQ4KCBm8VfxEL2y58wZNj/TTGGW
         r/Kb65o9OXAaaMFsl4VxGn4rg06E4OwSXPp+PTyCGMvHKt+f0hwfNyKBIo07ywemqbuQ
         qiiMlI40qiGIND2b1dD7eMTBbPFt0Fp+xDK5o75rgZZ6qx0siTPQOAmj7S4M8AUU1EkW
         PiQA==
X-Forwarded-Encrypted: i=1; AJvYcCV22oUwxk/U9q1cQA+I18AO7Nb+AJ0WFTpA0iWwmnAdTvEBQYIAwizk79OPFIrBsYe7Qz/f1KSf+1ZRHmeD@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQuOorP+Q4jL5WK6gRioGTg+JAGU+ZdiQEhqqNnhtkMSuhYAA
	Ut66Z/TQtbkiMCovR5JmUKmj6fy2oJbk2XXiYKO0CguIZY/e/tIPLk9JE4F5RUDlzSNekT1oEc+
	B+TDpzqCokxf3ngj5gVfZFD00KWGzerU=
X-Gm-Gg: AZuq6aIIal0MJjae6vLwS9etiP1R6np03bqPjYAHyqvtgKI02fi7IoVS1+RchaC4qA1
	eUBqjwSNnrKVR4Uqk//ptT+3BXnYLp/ZKX8YwqWpAatNKx250EJBrYp0/k0/WSzPlIkx08iQJ4k
	RQ+GQj2oEPfa/pUrBhDQM7mGsgHbY3EC1X9vKiIIf9BX4eYE2OQ3KRfNgX2ZD3bw5ULfU795RiW
	M9/7osELvn15EwspyW/Svh3fvj813iWVSmOcUPz5RnvL+YWFBSn9Er43ZTYSEj1RXOqpWzpB7gH
	0gd6sg==
X-Received: by 2002:ac8:5a05:0:b0:503:2d06:8e15 with SMTP id
 d75a77b69052e-5070bbd5fbbmr189408691cf.21.1771963778577; Tue, 24 Feb 2026
 12:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:09:27 -0800
X-Gm-Features: AaiRm51mgRlWbkXb6u9q8vdEfIKt7UeLJ2adO4XjFSbDCtDEImXRc2B_2FbsvY4
Message-ID: <CAJnrk1bEm=pe2M367CsbQNYyUEdXCVzAyboqqHnSCxx7fxZKZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stable@vger.kernel.org, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-78310-lists,linux-fsdevel=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7440F18C48A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Makes sense to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/control.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 140bd5730d9984..073c2d8e4dfc7c 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct =
file *file,
>                                               const char __user *buf,
>                                               size_t count, loff_t *ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         ssize_t ret;
>
>         ret =3D fuse_conn_limit_write(file, buf, count, ppos, &val,
> @@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(s=
truct file *file,
>                                                     const char __user *bu=
f,
>                                                     size_t count, loff_t =
*ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         struct fuse_conn *fc;
>         ssize_t ret;
>
>

