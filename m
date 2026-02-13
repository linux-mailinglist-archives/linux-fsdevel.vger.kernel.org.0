Return-Path: <linux-fsdevel+bounces-77171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLiTM+x2j2lERAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:09:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382B51391AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 816DC30601B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655E261393;
	Fri, 13 Feb 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lilsQ2My"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAE26FA77
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009766; cv=pass; b=ixpJeqxKyXXVRnVqIRMK4o0VtSWLXBq3NRQULdaqbopa9lq2GpBJ+Xz0qRoDKL7DoEcVoAMN26tRwDNqWex48EnDHayWe4EwXA5i3yM46i0buFsjIEnfzqbcoKTxHG5WQTrtka9zpQnseEdOtzQ1W+89EBgAj/nPgzAaGEo8MCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009766; c=relaxed/simple;
	bh=zVUNVZEhtz1zAKIlPkoMOnIshcjJh+u7Cbs5oPUruaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6ntcB2VOgeSAXSJ9NgV5vx+e9brconn2FGw3DavWZ1/fWdOdmLul0shan5KhxyCsQVhlGTI7TJGbRGkXJcGHwGWyYwpIdRlpfLi+OUx49VkliOAC+hvy/9bEC1vgt5Zxd+WBPQzwtAml+ZKxIlIDeTcDABI65AqjG01YusIZlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lilsQ2My; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a297c14bso12359471cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771009764; cv=none;
        d=google.com; s=arc-20240605;
        b=bl5Wc71KocEj3QHnrFPwMgLBGrlEGJpPQ1gZaw2Gk6nJXBwMIg0elwS5JzH3U+kRf1
         ss2QAemeyxIIWF1Xvoe/BUrXu6GM3g3obJoPbEml5TEKN7b5HX7fn5TLGI7baj8KkqJM
         sLvhdSdQFNPk1IHqJgMN9rTdP3ErrIwO0tatVTRsEZ3B0F02shOkwsy0XdN85b6XDLCS
         fFZ6n9IwwfiHlKBZqvHQM7GEOCSIEKWbQEahNhpnsPF1UMH6Oy1twohNPo2wnzsxRZJa
         lwa2B8JgxygcwtxthA79nGY8FYWc6979Hlqu9lbvqeSKiO8uCUtXd9PHYd2DpC2A/QSA
         FuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QS2M3KAztoqucCJzQWm9xa6Cgpv3hSDX6ecO7H+gY2A=;
        fh=X+VQUIH/2fasBTHQa5F8DW7/kZXcoXxnWPZso8sog7s=;
        b=AU1D58d2K4DotEmnL28UYhLgHKoLA8vC4ej+jKJXS/eijoBHvIiA+//UYThToSvbCQ
         oAdg2FUH7hurIfEwaAQENCvWELgnlSkry6KgWf3bV59MwHG1uQ2qtMYKFuxwGnAdUvtw
         CIQBpsXZs2PSliD9Rq7hVDhrieyjMBtMtSXaUaXTEjGTMjqqZyaMsfCYNJc2iEUP+3VZ
         7qfrZRjiTYd140/ZgQiRBlgp5Tsmf97/W7qCeiQAgikQuGPvqpwGTkeC07wwpeoaIOfN
         lVTJtRgFjMdaHJeorwUiz48E7ktqcD6hWj199g2bNZbZN+2g8/PtUVW15i9V7ztBfT35
         7U/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771009764; x=1771614564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS2M3KAztoqucCJzQWm9xa6Cgpv3hSDX6ecO7H+gY2A=;
        b=lilsQ2MyM9/7oY0+o5sVAmZBe2ElcafoByPB8a3StlTPlNUhSYb7HhBTqTS9WqxUZO
         ku1rHLbZ4+waL2MCz4Ytxnba1AuaVPbkeT9djWK529eZU5d07s62PWY8SQTHZ5qbUTZr
         s1RBOpOspzMO79YD1tFHiKZkYRv1hec1zsYlLaP4MBxIdiMS5RShnpkYpzkgvwe3tER+
         t9/XNqNdcJVoLUUBS6e82XZLklLPJkAQFDF2sGrd77O74B7FuJqXKHqE/EKlUiLu1W8O
         NKe6YZmMyohdpQ8SiI4WU0SbKinKJO7Dlda7JvZTTqz17MvbhL3cpcSn26zrN1ePkYpc
         hJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009764; x=1771614564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QS2M3KAztoqucCJzQWm9xa6Cgpv3hSDX6ecO7H+gY2A=;
        b=p9Tzb6vLFXyEG/HH7UmnLkM69ywa6t2g/3rmd8Px83icyaQgJWbtFZwkbCzw831xgG
         spCZfQVj0zVbHp6YrOpo8zZJwpogYjcOq2QDZFUxc4WqrEJBAE2r8svlBCek584MfWS3
         faiOkp6EJjvPaaKIsaXrqnpzzJ31OO328l79VWN9PyoeDfttpp9NtaVsSX7hD60RbTbu
         UiLUO2MJOaIxITuqylc14rmk0EdAjlUjNyVB/GxtHatgr64OnbPFe5ygkH6YMVHSl6F6
         3z658lx9f0+ocrXmSAqw6CfN0jjEBTUeJOt7EgFhQv+67AAt4PBgprDBbAz9Wp7c8awM
         3W/g==
X-Forwarded-Encrypted: i=1; AJvYcCX5PpPajqNaMY7+eYyt8fUVf+f0L8eYFsfEnMug1OhtYhcbaZenKSqfHNPP688BTEMyO3jB70Xmo0DJwqqp@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH2zDVFP7mZONrJ+QJCWcuzOky54kgFhlTDnxH09V6hXgGaHD
	OIqQgKsUeNN+6iyNTXNEigSB+s3Y2uMZfFsyBkebq3nZQLCfbGeG30+I0+kwcbMu7utqhgqBB7e
	Bs+EFMOwThSUlImGMzcbBqunMgosIt3w=
X-Gm-Gg: AZuq6aJbv23UQZYeSNj+KT4wG0WGFePJxPJvo0gf8XMf7RAjvXQDtY+V9AWHteCOd80
	o3AG5T+y9h4EN/mPDpV7Hgq3HXVTaGXw55zAbNKxT6rWSjs36g4x3DscKJ5u+GrJ2DZ6ejRfNa8
	nEIUyrD2CVBQwpD3OrcWsa/0C8rsiNEXsCssxBg4oW1u0tIR1xB4pGA3tt9Vu16FBKIGhZKiKN5
	f7Mbc0LZxfKtFRWUuzklF69puJC+0BgXazmhcq9GU0N2H7uIZTMM1B2FNcpUJLCgC08zt8jgFzj
	Qag/mQ==
X-Received: by 2002:ac8:5ac9:0:b0:4ed:a6b0:5c39 with SMTP id
 d75a77b69052e-506a836443fmr38528111cf.63.1771009763940; Fri, 13 Feb 2026
 11:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com> <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com> <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org> <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
 <aY7ScyJOp4zqKJO7@infradead.org> <7c241b57-95d4-4d58-8cd3-369751f17df1@gmail.com>
In-Reply-To: <7c241b57-95d4-4d58-8cd3-369751f17df1@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Feb 2026 11:09:13 -0800
X-Gm-Features: AZwV_Qh3vzmcZHHFrk5tmRY-L42DG_4kEaGwxKU2xKfVbjOIkj69uMfOnC1kUFU
Message-ID: <CAJnrk1b2BHwBzz+AS7x0WuJSpf98x1xGhf1ys2rm4Ffb0_5TOA@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, io-uring@vger.kernel.org, 
	csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77171-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 382B51391AD
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:31=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/13/26 07:27, Christoph Hellwig wrote:
> > On Thu, Feb 12, 2026 at 09:29:31AM -0800, Joanne Koong wrote:
> >>>> I'm arguing exactly against this.  For my use case I need a setup
> >>>> where the kernel controls the allocation fully and guarantees user
> >>>> processes can only read the memory but never write to it.  I'd love
> >>
> >> By "control the allocation fully" do you mean for your use case, the
> >> allocation/setup isn't triggered by userspace but is initiated by the
> >> kernel (eg user never explicitly registers any kbuf ring, the kernel
> >> just uses the kbuf ring data structure internally and users can read
> >> the buffer contents)? If userspace initiates the setup of the kbuf
> >> ring, going through IORING_REGISTER_MEM_REGION would be semantically
> >> the same, except the buffer allocation by the kernel now happens
> >> before the ring is created and then later populated into the ring.
> >> userspace would still need to make an mmap call to the region and the
> >> kernel could enforce that as read-only. But if userspace doesn't
> >> initiate the setup, then going through IORING_REGISTER_MEM_REGION gets
> >> uglier.
> >
> > The idea is that the application tells the kernel that it wants to use
> > a fixed buffer pool for reads.  Right now the application does this
> > using io_uring_register_buffers().  The problem with that is that
> > io_uring_register_buffers ends up just doing a pin of the memory,
> > but the application or, in case of shared memory, someone else could
> > still modify the memory.  If the underlying file system or storage
> > device needs verify checksums, or worse rebuild data from parity
> > (or uncompress), it needs to ensure that the memory it is operating
> > on can't be modified by someone else.
> >
> > So I've been thinking of a version of io_uring_register_buffers where
> > the buffers are not provided by the application, but instead by the
> > kernel and mapped into the application address space read-only for
> > a while, and I thought I could implement this on top of your series,
> > but I have to admit I haven't really looked into the details all
> > that much.
>
> There is nothing about registered buffers in this series. And even
> if you try to reuse buffer allocation out of it, it'll come with
> a circular buffer you'll have no need for. And I'm pretty much

I think the circular buffer will be useful for Christoph's use case in
the same way it'll be useful for fuse's. The read payload could be
differently sized across requests, so it's a lot of wasted space to
have to allocate a buffer large enough to support the max-size request
per entry in the io_ring. With using a circular buffer, buffers have a
way to be shared across entries, which means we can significantly
reduce how much memory needs to be allocated.

Thanks,
Joanne

> arguing about separating those for io_uring.
>
> --
> Pavel Begunkov
>

