Return-Path: <linux-fsdevel+bounces-77016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KPUJ+6/jWkZ6gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:56:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261012D345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0300C30CD729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D634FF59;
	Thu, 12 Feb 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MYVCmMM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADB34F473
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897364; cv=pass; b=mEpqkM+o/MmhXgp3xP7iiZxm/xKDjW5vuKkz2ePV+5NoHm0baTigy//cXUOrc/2if/zr28GfwHqwW2g/CFgoHjAnToaByuAgWC+MyrF4h9AFFbDyLmHq3wrwcTcD1hzQLYmAl6q0kk/QgPv+J2J7+spI8QRocBe1EAtfwdozhK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897364; c=relaxed/simple;
	bh=U2iifO9hYhyqiaMPmNzT3jmZNDUohFVgz61Ju6wg1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO+rcJij2Wb4xP1DnO68EVAnHBdCfFYGLsqjVx3IISnqYjlxOQ8+nJX5QlQEI1VKqFU5GGLlmrao3xvWLIZ4yv9nITGKlQpOjJ+iXqbJOyvboMH75P9Tqk8LDaFOZky+N4t6MAUyfloskeMql9md1Vrj+eU2UnXNhRevN8C6wGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MYVCmMM7; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-505d872f90fso69671261cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 03:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770897362; cv=none;
        d=google.com; s=arc-20240605;
        b=HKUwqYvo8TTHoRw6MWnG0Y5z0rG4aIavYIVAqsYIcOom0NTNXA3Ur0CkF+sFN0NzlF
         FM4LS5M8o+65xXLTGUen3WQXkUukAabJGt/7JM86jQDHV53v/LKbewZXBTUH81H6u4hb
         nzYgl1opRA6E4aDf0pwe+bux92dJWfebYLPQRXVd5VW1VVeHDxqqfZ8sNr0Tel/a7nEq
         DuqI625lPNfokKYL/PsKybzWTrJNK/dRHSN4hxTqViB2/tF2kigz1JbTzBB8C9gBd9tg
         g2Gg6cTuk58L0TalApi19LyAT3+vH9ol3UHasqTkE/BeVgOxQaHTMYJo5xsn6DY7g3GD
         PEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OA+r4VOg9Q7Fo+2osF0pJxpximeudUDTjZAGhZ1/GT4=;
        fh=rWi1Wov8Ko+gp7akNdkas/6A0Nka4KfwYMTb3EJo7to=;
        b=O1Xn4bh2kXTCbVFnFFvDFI4XTj8Wqi0d4umdeBeyU+vUfHZgfpw2l1ILkn9+JMQlGK
         Q6MrBNUkzGgki6Z5Muc2eTSttm9vVbSCB6w/otzYcHiE3NwdZ0nwiMqUs04RSRNPsWmk
         NqUX/3xh+8QRcjrGhTJVCwXlxX9hvgrTi/dA2Zto/qTx6LDNVw/iVAY7G/kcXpDhg9md
         L6k9wBqH6qRP9KVlePe6kjWYYMHMe4AMCp2DHLehGU5q3TnI8X6FL6PL1v4FlpqoDjXY
         OmxtQUV+X3DdI1SeMxAKXXR9yCPZi1ijsw2z0xmcG3f+rKznlzKwJT2GDntccF9Vhk4M
         Wmwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770897362; x=1771502162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OA+r4VOg9Q7Fo+2osF0pJxpximeudUDTjZAGhZ1/GT4=;
        b=MYVCmMM7Qgl3/GLbyHM8O6vyWNq6AIFXTwLQ7ow0vpuoCKJ63d9OHro+zo1n/3vdmi
         6DGPIusf7FQI8Ol7smywd78qREI+LUFfYV22kiza8RPgZxMxR1yUZRITCOHqLTO4c8e2
         hlKaIWjUSdQJh2bLK1TW0J1RidWsDPmAAa2TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770897362; x=1771502162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA+r4VOg9Q7Fo+2osF0pJxpximeudUDTjZAGhZ1/GT4=;
        b=SbM1fyxTrNgpdimAhep7kj9aTauXt9YiQ6BPNbdkqXHfMo2Kv5HcAhyfubdmSkv6u2
         T92GiSZm79nxY/77xGRCU/89l17K1nmRXYGOxao9viCKkX8jMC1ZS9TYwEqZFGFh6MQy
         s4iwxw6q821x8dWmt7BMjI0GQd+7JO40vvHr+OBaKz5DGBPIxS0QwkafySR/NDu9WZ8K
         WCP/8tKT4cJjaZtdj3d9euHVDSZ7qE9x5vVYfio8Zu/fS7ccd1S5AnntUH6dEVk+6Y5N
         WX1hLrbCq0b5IJFhruC4eECLTtSXjJbvtcDENnCFMFF7+ucSwbRSwBFbthJTVHUw7+FL
         02hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyLGch0ixcbmzuw7aVi+bkAI9l1ojaMqN6g5TF1yh1gxQjZUcO/RMECzqBoc/paluJf5XryuAXC875uPh@vger.kernel.org
X-Gm-Message-State: AOJu0YwHj/sRj2ETYYSk1TlIAZXm9GSeQAMoK90x3q4Y64Uuk2N2x5EF
	+QhoyOT0kdsBgn1gX/LMeUEOXd8t0v3stVrRROGY0OsJjccG4Xs07idt9Q7poZ1W5p5239bDz5h
	fknfyZzONTbgLa3I5KzddZDdWMvCXkiX2zGDMzcYp2Q==
X-Gm-Gg: AZuq6aLAXrvg52qjKUHNWSt//PpktMV5AE8pR3ElpVoaPLD6qRuqtecY7xBAZTY/Etv
	AyhqjpyOhVLkQXZgUqDjben57WDFDUHsdnCe7TuOLUFfNyup6oWXGp+ka4qQASD0uSeAqbqCVrE
	LCG6QuUFQYSBhvfxDk2Hofrh77c453bYbtJOEV4GpWpNMk7tC3HsdPhEzirDxJNgM/3YvkJENd9
	UxZ0vRTHH8+9rznUEhCbpV+E1UVSNlxXXH8QdGQcmDDg4OIsiTcpCcCElNuyE9ezeHL1e6Oq8XG
	7nbDBA==
X-Received: by 2002:a05:622a:1496:b0:4f1:dfc8:50b with SMTP id
 d75a77b69052e-50691f558a1mr37633891cf.76.1770897362087; Thu, 12 Feb 2026
 03:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com> <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com> <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
In-Reply-To: <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 12:55:51 +0100
X-Gm-Features: AZwV_QhgAwcbKLATVwWVzlW7px6ukms7WfQ9UnnY-_XjWRUHjtz2qLqmXSjoLv4
Message-ID: <CAJfpegs4LPx5priJCagpP1hS6q9=+YxG_2HGiMrv9m03G1jNpQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77016-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 0261012D345
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 at 11:43, Bernd Schubert <bernd@bsbernd.com> wrote:

> I think you mean FUSE_CREATE?

Yes.

> Which is create+getattr, but always
> preceded by FUSE_LOOKUP is always sent first?

Maybe LOOKUP is always sent because otherwise FMODE_CREATED may not be
(even approximately) correct.  Even if LOOKUP is sent, the file might
have been created remotely and hence FMODE_CREATED be incorrect.  The
only way to fix this is to return this flag from CREATE.

>  Horst is currently working
> on full atomic open based on compounds, i.e. a totally new patch set to
> the earlier versions. With that LOOKUP

I'm saying that LOOKUP is just unnecessary.  Maybe I'm missing
something, though.

Thanks,
Miklos

