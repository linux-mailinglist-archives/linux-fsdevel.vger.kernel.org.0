Return-Path: <linux-fsdevel+bounces-78931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKqyHKKtpWmpDgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:32:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A51DBE4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43560304179C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D640B6E4;
	Mon,  2 Mar 2026 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RTnXYSBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3D283FE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465425; cv=pass; b=JTy6aqWPyF4rEV7rmX9c4U0OA9uXdcOMuE4BmK0YXze0v+F8YU9owOKMVgKsGPOGVW6NceRtrDMlsxVrKgNyhSZwFyM2P+XFjb8zASEafemsqPyijos7r2dE340evNkgDRQzUEzwTuHyZGuDlneG2q+LDQ6JYifCsLyEY1J6ROo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465425; c=relaxed/simple;
	bh=mms126za9iLHNwrF72eB+7varQYLykUK/b/Sq06P2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9t2cDyvpcHnU7BBFJiecO5xP1tbzmw4vst1Vefr9GyqZ4jhdIpVBWP+KPQRL+D8Pn4Xj9xRGBZt2n/qog2R/Bz4vEsmo7z21ZEK6fYF9K7yehMbq/c2lJsj9lanXYsMVTSSEBiV0zbcbuZQIdNOFygx8LS55D2sJnam1afFMys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RTnXYSBh; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899d6b7b073so39189376d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 07:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772465422; cv=none;
        d=google.com; s=arc-20240605;
        b=j16gQseMZQ1Os1Y1KnIoilfgXM4lLEsDxExEQxZJxIwhwlyzhXVX+1KUeEzroqzTtL
         YfOnS0iC4MsYYLHW6IJJnGuoWNlhcf+tguUcJXsj7R2VowNTGcnkeKwYhzxVf75tp58+
         fKaWFqQwJTenFAKRLsxWEZ1mSnfEQGD4dE9Ejuvb01bw/a53MfxiQpMeh7Any1e085xM
         H14S7qn1x/lfKOUWuh0TGW1QyeBhXK2/SVAT5p3hE2FbICU198YRAqbWSnH9rJKLztQ3
         xp8Rpq3maaCtACPjDANAfDIhffrGRiBpIsfG4v5ZwmxhF1xNS4nQeV6OJvEkH3v95VOq
         j5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g4xSZKFapO2O9A9ZxJoFZiNBm6w1mF43104yNFAWcMs=;
        fh=H3hpzC+llMBGDJvgG1B0oJQ4qBPO/7EhX3DRDDb/Mck=;
        b=J7v6y/oG7m//7YLhtoT1smMrBuZjLlZUr7MngF1SD3USWMmGQoMsslV5yRjEWOxVP8
         fylDSdLr76cXDAA2sRYY0qF9i2G7FTN7W9i6UP524jJ/fRGtD0GG+Hj/hw53h92n7O6I
         dzFAW1EKOYNuCFlbyUa748ShAQn3Bw+WlOZuithWkCgSzvIlzGmJpUkoCKjxQMLg5Iya
         +m6WmDhdfGbWPHjzDkIu4VIvnWwDQjLUAkPYFYMJH8Wikjy+XxIM5qiIqqW/+U1Vyekg
         V7nt73fTrXUGS0JiFrEWBlfk47s923K84sgiUCFDinHUJ9TCOsvjpwSjWb9pSxuT4AfP
         4L5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772465422; x=1773070222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4xSZKFapO2O9A9ZxJoFZiNBm6w1mF43104yNFAWcMs=;
        b=RTnXYSBhUIQlRLRFkdhpTSX47VKi6koN6XWNeR5vSniU3FzVIM3Ugoa5Y6r78bE07/
         yWTP+DVof9Cv2kBHAPB/c6DcutHMYVTRmw0CtPag2fxCR0+oK37NV+FpMH+9ON4MLfzk
         R92muZkP8hO7VBWosvGK51x1rT4yohQn14beU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465422; x=1773070222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4xSZKFapO2O9A9ZxJoFZiNBm6w1mF43104yNFAWcMs=;
        b=ONo1OEobO77O6Xf8i5xHvevzLLm4riZSTZP21x8lH5ZDgneyUuju3uhRdsomSlOJwH
         qR+XcTy+StCgRjADXgd8Qz2B9WpsM8KPyLIm4wbTbMk5S5b1l3vAjEV+7WBQnRFalCz/
         KDSFTYv3Jl8tsGs9Kd6u55RXgPqUDNdO+7J/nnhUNWUIrb5NLLw8EInElnFRCzuNCzqD
         1Ss07SQXZoykVsLqQCdnwBE2pVN/pPEr+F0Dy0NMS0g7OfsRu4BR3YSd7/yo2lPg1Dd2
         l/w7YEEtGqJLOAqz3IYFinoZQn9c1+ioy7trvogiwcllzPVInWGCisvXfYa3FBu7Dyeg
         BvIg==
X-Forwarded-Encrypted: i=1; AJvYcCUq3SSl4NNByeUFZkbi6HJ7Vc9WlmysvCMEeA0+wEGVM8VJwhlPIeL+KIocyXcWB9PpYEpsUdSB6zyXE6mE@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyDaTbBl3t2nim3q8bYxDEiL3x7Siz79SGcxUVOgVd8fYtTdh
	YB5MVU1251WeKWiXBLVDNVLYmr33zvfp1LA2I7eb+WUorB/ZRoX5nl+wDAGyNYwF6rZrZkiQqL8
	tc+YBKD8H0JD8XgTHmkGWTydm5b2Szjs9dulm+UwV9Q==
X-Gm-Gg: ATEYQzzq0CxhIMtakmPAvehTM0l+wP5Apt/J+blZ4yM1OjcHZzcyYPXx3Ze4JGOtPDQ
	tSQ6I2jQDf9QTaFh0e/Cl2dt0KyIO4IJ9bH3YGd2PIpWrI2synxyTUBeHnZmX3Fo9tHmNv1w0/G
	I7QM0W4BjYP/xCRMeMHYt9J0c42P5UL93WtD6VZaztgeqNMmRsriDxfH7LyCXOZXK0zQSWlbQsP
	BS55KLdv1nW9xuaMDdQq1m8E1tReCjkKuBIb2A4lRaJwIl+l4H3dyfbkM6iXFQhUe+EPEmfP7el
	FopLc4yU8g==
X-Received: by 2002:ac8:5891:0:b0:4f4:d29a:40e7 with SMTP id
 d75a77b69052e-507528f9969mr151028611cf.74.1772465420823; Mon, 02 Mar 2026
 07:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69917e0d.050a0220.340abe.02e2.GAE@google.com> <20260216144830.48804-1-luis@igalia.com>
In-Reply-To: <20260216144830.48804-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 16:30:09 +0100
X-Gm-Features: AaiRm53VfBAx1rFzZyDHGbxzcM1ZDZcp_CPrhlwQVAbzRu9pqZbcKRVmKooWwi0
Message-ID: <CAJfpeguHmoPz=T0LD4JTpa=Kc8ah3oZrQmD8XOnzfA8bDiSeig@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix uninit-value in fuse_dentry_revalidate()
To: Luis Henriques <luis@igalia.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E13A51DBE4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78931-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,fdebb2dc960aa56c600a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 at 15:48, Luis Henriques <luis@igalia.com> wrote:
>
> fuse_dentry_revalidate() may be called with a dentry that didn't had
> ->d_time initialised.  The issue was found with KMSAN, where lookup_open()
> calls __d_alloc(), followed by d_revalidate(), as shown below:
>
> =====================================================
> BUG: KMSAN: uninit-value in fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
>  fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
>  d_revalidate fs/namei.c:1030 [inline]
>  lookup_open fs/namei.c:4405 [inline]
>  open_last_lookups fs/namei.c:4583 [inline]
>  path_openat+0x1614/0x64c0 fs/namei.c:4827
>  do_file_open+0x2aa/0x680 fs/namei.c:4859
> [...]
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4466 [inline]
>  slab_alloc_node mm/slub.c:4788 [inline]
>  kmem_cache_alloc_lru_noprof+0x382/0x1280 mm/slub.c:4807
>  __d_alloc+0x55/0xa00 fs/dcache.c:1740
>  d_alloc_parallel+0x99/0x2740 fs/dcache.c:2604
>  lookup_open fs/namei.c:4398 [inline]
>  open_last_lookups fs/namei.c:4583 [inline]
>  path_openat+0x135f/0x64c0 fs/namei.c:4827
>  do_file_open+0x2aa/0x680 fs/namei.c:4859
> [...]
> =====================================================
>
> Reported-by: syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69917e0d.050a0220.340abe.02e2.GAE@google.com
> Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
> Signed-off-by: Luis Henriques <luis@igalia.com>

Applied, thanks.

Miklos

