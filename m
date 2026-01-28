Return-Path: <linux-fsdevel+bounces-75698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRrC2OpeWl/yQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 07:14:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781A9D5FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 07:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F77830115A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEB336ECD;
	Wed, 28 Jan 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zbl1bQn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F52D94A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580892; cv=pass; b=URkRNF6JRB/SBu7qfWry5D94t4LGFeQwor+LvpeM4If1/EDleRumuPVgixygppF0BWuLV50t7/w+Zp3K2koV6hJvT8vWiUWWRyeWyBp4CcvZvGIXTM5FEgjvwpSck6zQ6lIQtEIqdQRz+L0EV2qBXKlpdegTQGD34tW5C1M2a48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580892; c=relaxed/simple;
	bh=FNljWqWQt9qOCbIGPzq9ziKcW75YO4zn9RCnX/Z50n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdzGUgN24gkHe38Py76wkGxbt1Kzd2xy5MTcsV6kySsRkEBOOY0sopy9rMKo8lLB2WKtxQ1cDMBTjYKfhyGKZh1VdZO6nQadNEE9f11uKBH2JdJDBRqXxxRUQSuad0gtQwkiz+0KwbDUR5pvRF2Me85i68HE5IxIFtCUHNXTIG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zbl1bQn8; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so3663136a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 22:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769580890; cv=none;
        d=google.com; s=arc-20240605;
        b=GDwn0tcc3xJiYxmJQVrUGMjAHBmx0e9Jsb3hHQRGSkRdLT8WtCSJoaZKTAzFhJx4lJ
         K5CjcXGDD7Z1fdOsGt2dor3b8dBnoKcHhaRNm9k5YebH409LdoRg58jynUl+VS/sgwax
         4H69OkIdS4EWqxqAcVqNeleAh2N2m9i2mWOYkdEbfIDPSdP6DdLU11Pz+Ibx40DayPfT
         Q0dnQZ/BWUFkR1bYdTeKarfFtJFfSlwweij4P5kYMLcSG/QND3TC5UO5wZXqX5lJZB6S
         H4dUqdcxSmR50xkVQUvaMX8kg0Ffe6V+pRF3XnXxAkca92xL8iGGhEYdOsVeNIMedl8I
         sUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=83TsjpurtD8OBIUEHarXgB49R5wZ/IDo2qjIBUDI8U4=;
        fh=w9f/pANwTsVNDBLB/mcgx3U+flsdhnCYXP60aPqA/5U=;
        b=e4unXjA5bDNsSnm0fm5RMTPJId46W5raluut8XaxgHXpIPxci25VzHLqqxKDCFiq+K
         CcOaBG2TNfeHNU9vE3tQKVZakCt4Btpv9ik04kUu0+JXUo/j7KILQz6+GMo7+Tx9/31V
         dpAWRBvEcGdiEEBI+iq4dOfVt7taau3o1q0v4L2S8hC/pbCde+DonzWqH1GbbMtFxlvf
         9PRBL26f22e1MINYJ2jBM5aW4pyI0wihxSqXMuiJRdO2hIUtZuUaJiQP9ltO1r2sE1Xn
         lgqMrhM0ROpXQWpXHDiivqKPUF2AgdrbZbDzY49HVbFqosoS/6L+DgoxtXQkYkp0vTCW
         NsJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769580890; x=1770185690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83TsjpurtD8OBIUEHarXgB49R5wZ/IDo2qjIBUDI8U4=;
        b=Zbl1bQn8//RUIoOQd9gGoB/rTBWwBtYI5hy1TPoMtLUd5zvf7ssPGKH+5XEquIl6g0
         3RECZHG/v7kfjHtoVTQDZVtpFN6DEKrUapo7I3SSbCQiVA53K/QU45dhBCsJQhuE3NS4
         zc9NWuvcGXMNMFBVSkY7lQehMAJZgNc5/bYuO06Tz3Y+HOMgHYAs5TH7Jk2uJJExORMc
         apper1NYBYZwZ2NtnMqqmepp38nFuIL4/A6djUyDAxp01RMctE2WBXuxCu3HzXSB9sGA
         6NL1WTwLm+qSi21jY68dPhSYALrK63mgq1Cu4xCAn8t7Ptwn+U8YYQVcuhnA3oKmP2Bn
         D5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769580890; x=1770185690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83TsjpurtD8OBIUEHarXgB49R5wZ/IDo2qjIBUDI8U4=;
        b=ZHOZrct8f5FlRRMeT3KNuHiE8UchxKlmL9elZOXVpn306dJVKqorTfKXlmCfqIy7XA
         F57Id/25aB4tHuEtwVMFngIvRKEB1yGAum4t893gnveb0pLDnChCLS9fXyEjOGUJmZtU
         YxORTd0zXeeQBw40xwLeJA0rxmNKbdNRzPzOL8uz4gVThverRkvgX7urf3mfqt3bw3xT
         RcCErgYibv9wIO3q/Vipgh3kCo7fGLtb+ApN4JbbcSabx5TwbpZjQJD7tylDKFipbeFN
         7e6sCsKV0DixiKWleLufrDPCQheTJ2se1P1xAUT2PQeYPFpcgaODsSFtWrLNh7x/mDG9
         HoRw==
X-Gm-Message-State: AOJu0YwLxcC6Hh+fWX/cFVKCrmOeKyr3c+j9a2joZdgAeaTIOb7zIC+8
	uoJNEicqsPrR8fdMy80D7B6nnQvdqJUYupX8DaQrlTjm2ZhLNhV9xUwDivrFOrejDDr9cs7mj8T
	IKjCMyRT1z0j02ZaoYNazHe2T8siAiMX4jJXV1lwikA==
X-Gm-Gg: AZuq6aKmI1p9ROhOq+O0Q+J5Q7sHS49uYuZ2HTB5qEEjnYZHmH/469r14y000fwc6WV
	6hucT5R3lXJPBg2VWXGYKLmY8mM6Y+imuOlkgZKBza2mp6ox+1qqiVadt5ixgWj5FDqMtzhPJ34
	RpYY1N3qrNZcsNOFnwy9h9TybXNd7E20VPE2pQ6gMvIjhmFhuDKdOzY8r73Owc8tR8y3tat4dC1
	YiQQeRn4L16SKm6H+0TbF7FcnXAOKWxCM7cCq7H/D89GyOyrGaQRwn+MJwxXQHWhsaupkyNZOTJ
	14MIkGW7jOpQ
X-Received: by 2002:a17:90b:2882:b0:353:38b3:dccf with SMTP id
 98e67ed59e1d1-353fed5caf5mr4163725a91.23.1769580890360; Tue, 27 Jan 2026
 22:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
 <CAJfpegtmBUSYVkx7_dB1p4XQsd2b156B_vCr=BNx-0yySHOhOg@mail.gmail.com>
In-Reply-To: <CAJfpegtmBUSYVkx7_dB1p4XQsd2b156B_vCr=BNx-0yySHOhOg@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 28 Jan 2026 14:14:39 +0800
X-Gm-Features: AZwV_Qh77OGou_HWDvfesHWRrmsfGaFVqyJ4nvUJodlO2qOjs-NzNx4B4H20nwQ
Message-ID: <CAP4dvsc0BXH+gBL6F9CjCWSw2bD3k8S0CGN2Ym-fZniZH61bag@mail.gmail.com>
Subject: Re: [External] Re: [QUESTION] fuse: why invalidate all page cache in truncate()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-75698-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,mail.gmail.com:mid,szeredi.hu:email]
X-Rspamd-Queue-Id: 8781A9D5FD
X-Rspamd-Action: no action

Hi Miklos,

On Tue, Jan 27, 2026 at 5:44=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 4 Jan 2026 at 07:51, Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > Hi all,
> >
> > We have recently encountered a case where aria2c adopts the following
> > IO pattern when downloading files(We enabled writeback_cache option):
> >
> > It allocates file space via fallocate. If fallocate is not supported,
> > it will circularly write 256KB of zero-filled data to the file until it=
 reaches
> > an enough size, and then truncate the file to the desired size. Subsequ=
ently,
> > it fills non-zero data into the file through random writes.
> >
> > This causes aria2c to run extremely slowly, which does not meet our
> > expectations,
> > because we have enabled writeback_cache, random writes should not be th=
is slow.
> > After investigation, I found that a readpage operation is performed in =
every
> > write_begin callback. This is quite odd, as the file was just fully fil=
led with
> > zeros via write operations; the file's page cache should all be uptodat=
e,
> > so there is no need for a readpage. Upon further analysis, I discovered=
 that the
> > root cause is that truncate has invalidated all the page cache.
> >
> > I would like to know why the invalidation is performed. After checking =
the code
> > commit history, I found that this has been the implementation since FUS=
E added
> > support for the writeback cache mode.
>
> This in fact goes back to the very first version committed into Linus' tr=
ee:
>
> $ git show d8a5ba45457e4 | grep -C 3 invalidate_inode_pages
> +void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
> +{
> +       if (S_ISREG(inode->i_mode) && i_size_read(inode) !=3D attr->size)
> +               invalidate_inode_pages(inode->i_mapping);
>
> This pattern was copied into setattr and, since it was harmless, left
> there for two centuries.

Thanks for sharing your memories.

>
> And because it was there for so long there's a minute chance that some
> fuse filesystem is relying on this behavior, so I'm a bit reluctant to
> change it.
>
> And fixing this does not in fact fix the underlying issue.  Manually
> preallocating disk space by writing zero blocks has the size effect of
> priming the page cache as well, which makes the random writes faster.
> Doing the same with fallocate() does not have this side effect and
> would leave the fuse filesystem with the bad performance.

Yep, I agree. I'm just wondering if we can or should optimize for this
specific case.

Thanks,
Tianci

