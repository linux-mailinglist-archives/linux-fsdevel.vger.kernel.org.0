Return-Path: <linux-fsdevel+bounces-76865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEB4Bopxi2mgUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:57:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C321B11E2C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B34403015883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A631ED8B;
	Tue, 10 Feb 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aSsdi1p0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BD318ECD
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746242; cv=pass; b=E45eHT/rZnsXkQHhptm7acEVW6q7FpMZ3OmTVy+dvIMzHJET1/DefAz27/g/LFOzjUTyx9HqalaHqpHocSH30fKazQXDLbx4Xbk3L4+HcYoQXdH2JOxMFXDdm1wxmTFO9bkULM10UimNszN3EUzaPMIvKQrynNPQsYhK0NVh9Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746242; c=relaxed/simple;
	bh=GWrFpYjIUc/xj7N0wd3tBFD8akKoS2HrmAT5yE7jq5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2NFVxO16qfFwaXxqy3taMvzd2ZVh75r6PHE7lHvcuYLDvLbhUeSrobKFRuaVT5iR/LuTi0CBWkE9uCV5KLfDjcYYyqtwWCjpfDaZXXsbZRGa/eBInV5V1seBquMlfSGFomziklX5vnZm/7I1EAMNynG/JpsPG07le/ecSl2Ef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aSsdi1p0; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658cb91a6c4so981796a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:57:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770746239; cv=none;
        d=google.com; s=arc-20240605;
        b=WLDKwdi4cb2qPRxTe+yA41XY1ahA15Vqh81GIqrwmMtBQRVeRTPjMQcXbtNGxn8LC7
         l5KyntgKg/Uql/LSUWDPUelqetDAgI7NuFFIzGgxhzE4B5wsic+SE1lYRr5ZkGqRTKAX
         79xA7fSu3omhkW12CCdDnBfwv6AAI1zkfBcOeC5CJkpLwxZo4VQV3ICcFT+lqKtahW5l
         b1EKsC6YeDWHq9dOdBDl3DqBbcK45U/UXrkqSBd4HwNkMiV7dhQ5ocPEjdHb6qK4izy3
         a6maEjCMX9xN4ySPUxdQwTjN/7Mh3rbiuen/ukJZpNpavEF86IIGMfO8ojnC/om9uN2Z
         TQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+nXNw/knapKCOCvKXk/sxttCrc1XoB9SJeujCBS22Zg=;
        fh=nqzW2sbZiBmS0Rh/lUIWmVnXGSzgHa3dKkQOxQJfYSA=;
        b=Twu/4B1QN7oKQphjyYBFK5hQgUaZ6Ei7P8KCIPJVOdSkSRwFFvh7ucR0Z9IXOrzLPv
         eK3i0KzPwpJZ2lWqHfMkMpBspXZCEdJ7uzDy8cxhTtNZC3AbugXwvdGF5OuPZdyMBZMe
         xDOrA9Kl252pS9bh5RSmnmzJ9tOpcaQDwO/M3ez1C+7YsctvVLgTmMPtKy0/sjmc3Blz
         1IQuA5GUV2lT/zhirx0dvQUUcdeFzu92HEXyl1cEducnDmcbqpayfRxiIGVXoz2TWc25
         1b0m65JXGfhGlMwMP5TzOZD9+lq+KaBklQ7VIXOx/NlruLCXdqw/fsDgMzLRQcAzsXPS
         KJDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770746239; x=1771351039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nXNw/knapKCOCvKXk/sxttCrc1XoB9SJeujCBS22Zg=;
        b=aSsdi1p0Ha2F5eENwkNpXC1eH41Ep3s0s30PUKiUr6QXPHWz8au9yrYCcVMWrt62Mj
         xc28knHOt9wvQY8YVEerWln4eqJTp0/YN5ATaEQvUKlKTBY+fEcue+HAqbWWO3Xh9iVI
         mIEjXGMGcSe/F8Q/YuWY+rr28Fx4OKYmk/1zTtbqtPYDeO+twl/nge5eAqxEAezPXx7Q
         +N7v0H3cESmIQ/RDiWeSuUls2uvklQIpUZHBPtmlPir1Z2KLB6PNT7vFHMSZWZz5OoT2
         6YR9fO0+gVfvtXpuJuQC/4URLZ61eDH1bSctV2c9QiK9pN+PQAVI9N3z4ggCkKFesDas
         vyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770746239; x=1771351039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+nXNw/knapKCOCvKXk/sxttCrc1XoB9SJeujCBS22Zg=;
        b=Br23/e7ma9hAqIzVfHN9ID5T+6izfDUctqO2XGG30gQtL2i3zqG5LsCctAg/BSeLLm
         U3qE/kkpXohlXsHDujPES0bYqNr6SguN/QxScXZkOEG6rgpl+SqxSTtdQBzPNO8+urXL
         NEIucCXKyvUm/cCN0K8h5XbP+BtzrBkT4SsTY2LwPvcuMdBW8yLOBo7EEve+5vSikNCq
         OwM6BSEn6XjhN+cbqdkYaGpSfgPvQ1uxtssIGjB1WjIKCvF9oSoZRpFzASAHKz1W4q3h
         nkaGmQ2vy3n4VirPgDMhi7SPrlti6XCfN2E3Oyv1xGZIlDFCAmKvldaggNzsdXwPVAHl
         D/gw==
X-Forwarded-Encrypted: i=1; AJvYcCV80+h7hiXHu6AsT/42M9DULIN6kkh+Z6OOw4q76Y/5Z1hdxltZP4A6USpv8vME2aGg9BVl/GauSAIpj0va@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbKmNqmLddPJxZwhr2bdsVowIrnt91+a567liZp2oBsLIJl7S
	DkG3C6EungJgCJ1u84NRNRPForDzxZIgYnHB3xF6Ce39v9BjWIOe6PqYeCK0OyZKc35r6nAp3xk
	qhZ6XF2tEdOfbXv/tLC2MKB5phNdWZAoT2brw7VZNzg==
X-Gm-Gg: AZuq6aIF4KhGrAFSFyvXMgSHu/GQt773YKjaxipb5g2GHC7yMaTB2w1WtoBJSgdYBOS
	uzgqh5fu2rO/cUJfrk+TUrGre7MY2Oca4EfM67B3Ato7ymaL3QOWDype3o78EU+isJ6CfFdR4K6
	Ed7R3lnp1iRWcDhrDikRnQfR5Cqf0sDwsIHfCWzzGVu7Mq5N9NoAYZ9Jx6BO/7gQC2uFb5CLwLx
	BLBRnXwwvHr6Ojjb5sWsclhxj17jZ5ZwQWrGvj7lYYRT5Yl5/iV28kTkGLpJ76b2KbVRTE1lUwQ
	J9SteH0j
X-Received: by 2002:a05:6402:1465:b0:658:1392:84a9 with SMTP id
 4fb4d7f45d1cf-65a0f3987c8mr885820a12.5.1770746239535; Tue, 10 Feb 2026
 09:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-7-joannelkoong@gmail.com> <8826110e-cb5c-4923-99cd-b9f21f536d32@kernel.dk>
In-Reply-To: <8826110e-cb5c-4923-99cd-b9f21f536d32@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 10 Feb 2026 09:57:08 -0800
X-Gm-Features: AZwV_QgslXwEFKldAeimaqaA_t6syzgt7pXhnv3lDqCXqFqd0HdgXnYkW1EMbvI
Message-ID: <CADUfDZoiHYKrfb=NxLH=K99ALuDoABCnrOFC4_mZgqvT6qQPXw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] io_uring/kbuf: add buffer ring pinning/unpinning
To: Jens Axboe <axboe@kernel.dk>
Cc: Joanne Koong <joannelkoong@gmail.com>, io-uring@vger.kernel.org, krisman@suse.de, 
	bernd@bsbernd.com, hch@infradead.org, asml.silence@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76865-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.de,bsbernd.com,infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C321B11E2C6
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 5:07=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/9/26 5:28 PM, Joanne Koong wrote:
> > +int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group=
,
> > +                       unsigned issue_flags, struct io_buffer_list **b=
l)
> > +{
> > +     struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +     struct io_buffer_list *buffer_list;
> > +     int ret =3D -EINVAL;
>
> Probably use the usual struct io_buffer_list *bl here and either use an
> ERR_PTR return, or rename the passed on **bl to **blret or something.
>
> > +int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_gro=
up,
> > +                    unsigned issue_flags)
> > +{
> > +     struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +     struct io_buffer_list *bl;
> > +     int ret =3D -EINVAL;
> > +
> > +     io_ring_submit_lock(ctx, issue_flags);
> > +
> > +     bl =3D io_buffer_get_list(ctx, buf_group);
> > +     if (bl && (bl->flags & IOBL_BUF_RING) && (bl->flags & IOBL_PINNED=
)) {
>
> Usually done as:
>
>         if ((bl->flags & (IOBL_BUF_RING|IOBL_PINNED)) =3D=3D (IOBL_BUF_RI=
NG|IOBL_PINNED))

FWIW, modern compilers will perform this optimization automatically.
They'll even optimize it further to !(~bl->flags &
(IOBL_BUF_RING|IOBL_PINNED)): https://godbolt.org/z/xGoP4TfhP

Best,
Caleb

>
> and maybe then just have an earlier
>
>         if (!bl)
>                 goto err;
>
> > +             bl->flags &=3D ~IOBL_PINNED;
> > +             ret =3D 0;
> > +     }
> err:
> > +     io_ring_submit_unlock(ctx, issue_flags);
> > +     return ret;
> > +}
>
> to avoid making it way too long. For io_uring, it's fine to exceed 80
> chars where it makes sense.
>
> --
> Jens Axboe

