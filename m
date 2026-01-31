Return-Path: <linux-fsdevel+bounces-75985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IJSFVtkfWmtRwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 03:09:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E17C03A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 03:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7ADB30158A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818632936C;
	Sat, 31 Jan 2026 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdY9sAoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995A32C933
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825355; cv=pass; b=WeeEcyvPKnLhkDD2NZ+nnbHt5cf68yGLhqoSF3QplIoanLwT17noBNTNvYC1OKrVncUA4fyip5nANhG2Fyc5XXC7cWEvl6rKDnECNFFAIt/wUUhTYCdLxxanIJHurDzHPj0u2tN3KXyCt37mnFsGT7veUMMjVql2YaW4g1oYc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825355; c=relaxed/simple;
	bh=q1+m69AC8OyppS+g1qL0airmm2fN+rGF7m5h75RejBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+BNFxKREAIksMawfrwwigPe+MVvdOInoTicJAwuGW86jXZQ1QyidN13r5mmyils9jrHsUyhaCbX9qNABf58+KzH3101FfdRSQEem61aeiGVKjeyphl1HgqVzC47NLL3sp3bqsCA2yGWYvz7WCWJ15ppfPsTbVk9lrQ36Y719m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdY9sAoL; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b884ad1026cso433892666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 18:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769825352; cv=none;
        d=google.com; s=arc-20240605;
        b=aZYiSDE/98LlYiVxZ5qwhoGpB3supieSTYt6RdpZkQyLHLzad4p7LS0fLGnCtoyIb0
         E3QOGLitMjg0/bW5c/4ySRCxZzLuGeBalhDjutLYrbzxkHbHB0DiYo25y92v8ygP3+3n
         Dx70pRqt+kMyWYe+ZkE/d96bZ+HangkYPc4rL2yyBcDUkNvI5TDZNUd6j6hfXCN5+lWs
         FWNcUeucS1Q/fugRYll8xA+FtrMSlxdv61hcQBePax7q/itChIcThGvaHcBBv7yXVfW/
         kEQZvthh82HDj2VBfpE0Nf6NM0c9Cx7vTvKp7mPySU9teXH58H5bng90n1cc1zuhPXBZ
         vzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        fh=ZcUn1gWuFkzqp8PSI/bx7+oVk/Tt8Rf0zIIJ081BNe8=;
        b=OSJEI/WQE48ZuEG3PPLSJu4kidTnOjqG6ExS+09KPfpamk19/kpUlGxVE1Enb6Rk7C
         s6tGjGA8wBmiNGOM7gyMSpddoQcMzrakf2q/z/wedOn33P70Vg2pWgN7JV4pdUL3ZpwI
         QY2DGmWRWjvbc4AQYBbsYgzgKN695kZ+R7WVbGFZ/t6CUqmRiG8yRCXcLB3yAA/1/dHG
         BPryNO/a/EFYHLeY0fz9lAbAf8kzRpac118uwjKcPCLnGhB8RMpOUCeNu7vve3KsM3Mq
         GTInXG5MsxKMBtFpmn/2Qqo8JZqFRncwS/h8qPWeKuVjoXlYS8lkz0ScF0quFqVnMa6S
         XF4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769825352; x=1770430152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=mdY9sAoLvV09pJjCxND5Iu74NfN+XMMgrupYs9by8DK5G2zZFOokwzfRRZKmBD1gRY
         AjgQpgB5EjSE4J0xzK51/PodGanFU83GL26fHQqfL9/acxZXA7eQC4icggJ3OPvsx39F
         rYB9x3Oswo696/SSnggh0yy/9Iw7SYfPVlLnKssfKPM5puJqBDEgC8TBKfmP2p9p8y9J
         mT2bVhCFO3fDAmUxql8ri6GZjywb818fU2vt3kLT6LeM+Nf8WkTqwYY0efhXBrLT+AY4
         ERI/xwg6zoS67zkSfCmJiRPlXMmkdYhH8jWl+xYzOwFG7Hx6lv8E8XyifBvgTABOhkOv
         aGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825352; x=1770430152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=HK0rLkhTk21lnZv005gQrotDwVVSt+RB981lMyc+1hZMAyfHaDLC1Rh17AufpGZtMa
         bNjO9dWMWbDKAXMLVt5V+p2Osk5VIiZoQHalgfAbxFpBMWIU2zRoRt+Z9W01yEoBzG8X
         KtGKToqdR0jBH7DnmXKuxyAcbckTtYbZTU10dGzEiOBF9jj0gMS9hf3Uiwgvg2jrZb6h
         HCFySivX3oVJwW9dn2Cdi5Rf01uPgyexRfkxv2sg+h7dxgT08TI9EJPJLDmiroLGu1BF
         p56YtY3LAQNgnkNEdlNXllN0nz8oH5R/ZlRysYJtljNDunBCc3BtMD9WMZTR9BJDgX56
         eIEw==
X-Forwarded-Encrypted: i=1; AJvYcCWAgWZEiHjPFezjqweWFxIgfgjajOan38fRDl07uiqwkSL3RoIywq99LUQdjw3c3IMW//V7pql5x5JRhVco@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAh11mVW1fyEqlVzPBes5E+LplErbWYVUy2oWEx4ow48gCPzL
	XV+4Z8/PEGZ1DjkgAXK6n+IO9+XXOVVmR4wPpXs87+lFQOPNO6PqVoSXBz5cU3P9erohQPIoodz
	pB2xLcouxqX/7L+fDHI4WxD0vdTgPYtmPNn/f4w3N
X-Gm-Gg: AZuq6aKpdv8N8JGbl4XYxpYXsiA2t+VkCjhVv0zVblOvsc5za5IvVd/LtBv8Gm85RLL
	xyZ1pikOZBcx3nRwfp0ZFy9LYZyDnanMtwXsY0mDGgrR4Np/JCVxeSRSRsvpZoj8TrFevvAy1hJ
	86sQ0X4DvVXS0P4LP2kbnPFzt2wZPEfkCof5MZIR8k93BM6Lx4tgKMFqWIUGyTwxkqZobRO6A5T
	8Z3j/aRZKDg9jdfYo3+Z7pLvQUYFZDQ9KlvjD1r4zc37I0V2tSiWj9jWX5M0dk53Ptsmsa5YY+3
	sAs=
X-Received: by 2002:a17:906:f5a8:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8dff5d84a1mr304116566b.28.1769825351931; Fri, 30 Jan 2026
 18:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV>
In-Reply-To: <20260131011831.GZ3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 18:09:00 -0800
X-Gm-Features: AZwV_QgpcNm32QTyYTJNZ2e8MpZD_azq4tiS_evKebHi_xWHPJAAyFUDpR04HdE
Message-ID: <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75985-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B5E17C03A6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 5:16=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
>
> > > How lovely...  Could you slap
> > >         WARN_ON(ret =3D=3D -EAGAIN);
> > > right before that
> > >         if (ret < 0)
> > >                 return ret;
> >
> > Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs wi=
th
> > this addition.
>
> What the hell?  Other than that mutex_lock(), the only change in there
> is the order of store to file->private_data and call of ffs_data_opened()=
;
> that struct file pointer is not visible to anyone at that point...

Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
is quite straightforward. Not familiar with this code path so just
speculating, but is there any interaction with previous patches (e.g.
refcounting)?

> Wait, it also brings ffs_data_reset() on that transition under ffs->mutex=
...
> For a quick check: does
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-=
wsamuel2
> git switch --detach FETCH_HEAD
> demonstrate the same breakage?

Had to adjust forward declaration of ffs_data_reset() to build, but
unfortunately same breakage.

