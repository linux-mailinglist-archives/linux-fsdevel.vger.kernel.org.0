Return-Path: <linux-fsdevel+bounces-75587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHeWLmiKeGn5qwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 10:50:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA29211D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B5631259FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB261335549;
	Tue, 27 Jan 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bb+ojoNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2F332EA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507068; cv=pass; b=QGr8UL4yCahevxsodyTRSFOBXfzMBgGviGcjnhnTUwv7ZfrfRlKoygkcRk0s2oCB1iN1tJKNxSkUkY7fWw7XNZ2RVX+eqzRwRI+DF6DxxMNIFeepFco71pAsA6zb97Zs5rOKEyVNcn54XwsSCC8NhI0DIidcXvj6/OUD14gVrGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507068; c=relaxed/simple;
	bh=MMk/WTOuwflmOPLTViGDWddx7/81wzMT9bhbYS0tj10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HikbalHZcDXB8Ips9zOavScsvX92KLnij57Rk/mNrB8xaIiY4o6xkJQH4e9D30NnKgiYeVXluHUyGfVaw/38dH7RM2EXMHF1uXF+ZEvZJPzqGWXauhnM2rdD3Dn/qt0wd9b1Q6mXYiPIoTblXQKkOd4YZRSQed3Fj+EnAxoQGGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bb+ojoNI; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so52919371cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 01:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769507065; cv=none;
        d=google.com; s=arc-20240605;
        b=IMqFB20TnmRhK5B/rTKIgZ8CsI9DyVzMhT+OGyVJ7fcQlzlePXtt0x22w79WTqKigQ
         O0NdYy8Yljoe44/jNoAkBw/y+mFe1HgVKp39ZkhB6RMcJvdd1DodRXJBMku77FfuIdp2
         Yh6pxbGoucKsKZrUR6dvVkSi1cecY60pRSTwUPaafsxvwOrVUjrLTHfXLTYEiRuyEEmS
         p4qLEdyNBdFd/ATy66RXqDgygEyQCl1zyzj1IYihI7SPj1YksAku7xx0P0IErrCY2An5
         pN4IoOwSm8qzO0R+D/hZIQHvv9d7wQteGbRWRslDhIrrywXvM4U8RN3xpr9T+K62/8SA
         131Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gZstn0DrPa2PjWg/PVtM0+TGagjIKYzoX+tj562NXaY=;
        fh=CQZ0U6NVBmpqTGEX0Bf8cNGyt20hb+Ad43/RHWpC9xo=;
        b=Sh5UAs8+kH2ptb9A06NK2RJxepuD0DpzQfrlKdR1MgFvDRKk/udaskQUqaKphdyr6d
         UVAEUBx9GWI68xZ/yvQIzqfpDfiEVhtLKQ+SMQRERcDvQ31rSqHS9hRSzC82QR6Ql+gy
         X3N96DCvYCcFRDyXc5DQvvq+qRa4EdE/nXo8Js44I6oX6RmXIItqgX4lbzvB5iArDUsF
         +STDOQabzLJAqYdbmxcCW5RpnCtg2R39NwDy+rjfqvGt3raFlywIsoThZtdr2bRUExLl
         yQQviwFDZfcCwny5723YSD6U21Uht8k7C+K/JKYNuIrRzc702dtZZlsyb68biUz87e9z
         EqQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1769507065; x=1770111865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZstn0DrPa2PjWg/PVtM0+TGagjIKYzoX+tj562NXaY=;
        b=bb+ojoNI66ot0EYONhTosjJLTkGbeTzlubSYx/2Ki36B9o3X0xuGH9jJ0JmyqP1JP2
         seZth2fUKwQsulvWFFw1I4IPzAFVq8w85BdbmLjJmEKDngMvm/HDvUWmftkohAKbjGjy
         DO4QgeiZ35sRG67B8RCxEh7vNutdKUuyoVJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507065; x=1770111865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZstn0DrPa2PjWg/PVtM0+TGagjIKYzoX+tj562NXaY=;
        b=DcNXDSaixfliEY5EU+udwLAAaxu0u86BDuukuCNuWohThEyIGD+pBE6xLOIgft6Ngn
         Ckp1JCuUQ4459pgTA9WsQ1254TzD5SXaC48/Aks374s5ioEdwdjWTOLz5re9CMCcsZW0
         MM0iJ/q1rQn7uy3nJkumP9q7flBEwz0+U5Q4/Nkk7mkXHtJDp1sjKpLDMIe6GgPSvoc1
         HGr901CoJxXJBo3+iPmfVUNC03O0iUv4NkzOURvrRM7+6ZGIWf9Xwikqp8QIM//7yicv
         BQUZphk2wp7An66NYTvClQeyi2KsI19U3r13oeoKEnSY0MvhCY0NQvN609u8tLqXhTTI
         cZHQ==
X-Gm-Message-State: AOJu0YzRKwtTTtpiPOp+pfS7oFRMuwaENYatiCIpczXLH0J5fPGmwnY6
	9Kcy+9zc6BHu07uqbuAeij/YbgcMipvaFkzPBgky29jpFSflTidukBG0l+RcSQlWa54wHVtgBlP
	l/luF0vGTcIj7aVQ59yzRtOe/nabXiHH3CJSq3F7qS7GQl+QHyyyFHsM=
X-Gm-Gg: AZuq6aK5I3R8QCgGJidc5/3h+YfvPiFi3rcCSGtEnc1DL3VEjCr9iWHLRjmuNCpUMtN
	txfPrjpGr34KJnWdrzsmajFL3JBiYcu13MBuGgi1odMALjJcdMvD62zZ2SD3svANKSsTu57Db4W
	VoVjnKOEg7UNe+frHvGqqcf3hEVEM3laoINq2yECg2SYClgc9KremJRgD1oCc6V4aI04vA3H9yk
	1Yc/z9YrOXkJnKuE6Me8qX94Xl4t/lAhhSFyGhC5NimiI6ZBY2BYpOzPYbvQxnr4CQ64vc=
X-Received: by 2002:ac8:7d04:0:b0:4ec:eecf:66e4 with SMTP id
 d75a77b69052e-5032f7647a1mr11669831cf.7.1769507064908; Tue, 27 Jan 2026
 01:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
In-Reply-To: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Jan 2026 10:44:13 +0100
X-Gm-Features: AZwV_QiIaTpCKuroTdG-5rXcI3cqbqhF0uQADcEeNMc1dr7EsfAEhUq6HyWW-wU
Message-ID: <CAJfpegtmBUSYVkx7_dB1p4XQsd2b156B_vCr=BNx-0yySHOhOg@mail.gmail.com>
Subject: Re: [QUESTION] fuse: why invalidate all page cache in truncate()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-75587-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: C9DA29211D
X-Rspamd-Action: no action

On Sun, 4 Jan 2026 at 07:51, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi all,
>
> We have recently encountered a case where aria2c adopts the following
> IO pattern when downloading files(We enabled writeback_cache option):
>
> It allocates file space via fallocate. If fallocate is not supported,
> it will circularly write 256KB of zero-filled data to the file until it reaches
> an enough size, and then truncate the file to the desired size. Subsequently,
> it fills non-zero data into the file through random writes.
>
> This causes aria2c to run extremely slowly, which does not meet our
> expectations,
> because we have enabled writeback_cache, random writes should not be this slow.
> After investigation, I found that a readpage operation is performed in every
> write_begin callback. This is quite odd, as the file was just fully filled with
> zeros via write operations; the file's page cache should all be uptodate,
> so there is no need for a readpage. Upon further analysis, I discovered that the
> root cause is that truncate has invalidated all the page cache.
>
> I would like to know why the invalidation is performed. After checking the code
> commit history, I found that this has been the implementation since FUSE added
> support for the writeback cache mode.

This in fact goes back to the very first version committed into Linus' tree:

$ git show d8a5ba45457e4 | grep -C 3 invalidate_inode_pages
+void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
+{
+       if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size)
+               invalidate_inode_pages(inode->i_mapping);

This pattern was copied into setattr and, since it was harmless, left
there for two centuries.

And because it was there for so long there's a minute chance that some
fuse filesystem is relying on this behavior, so I'm a bit reluctant to
change it.

And fixing this does not in fact fix the underlying issue.  Manually
preallocating disk space by writing zero blocks has the size effect of
priming the page cache as well, which makes the random writes faster.
Doing the same with fallocate() does not have this side effect and
would leave the fuse filesystem with the bad performance.

Thanks,
Miklos

