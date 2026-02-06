Return-Path: <linux-fsdevel+bounces-76587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKGWJlkDhmmyJAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:06:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10BFF70C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5970F302A2FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA482777EA;
	Fri,  6 Feb 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h21RnEhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B592737F9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390208; cv=pass; b=At5QnT2EmZ1rIOSmw4cGt0zt9ncQQUJRJm4Cj9v1HQwHK55XWXcgrnNbCqVcLZX7/W/l8B+lTJdSEPaZxgHWytZwwqAWk1E1rOt8web6Qyffqldh4jMyeqtqA0grCC4NdfDK9O70yv7iVzSXMnCXIxgx5pn+GydbhZnOFrf45AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390208; c=relaxed/simple;
	bh=2r86Fx4ramj4tYJizidhOVEFXq0HJLOP0RBDUmIE1UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n38mBhvBuNK30osTeCp6nEdBGg3pZguczl7Fl0zkPqm9NhBAIO1y/aCd+BGhUNv4iG498397duk/76rW5YGGs74FJHEW7NmlZq806TyONVRtNNG74vx679K/qur6Cd6QelpGnbP69mLMFN79WT9PgS40zQ1+GrZhloZXTdWiMWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h21RnEhN; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so3701059a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 07:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390206; cv=none;
        d=google.com; s=arc-20240605;
        b=bvkYdlBFBTwZsld+pBzbB9wvV2CvNyMc+0FDJyD1hEmURb19xTpZBB6595srvL8gre
         tD9aTCtJDJ4seMNAvovyiM6iGhVPrO2BNCk27bCyqrKx/S6RgURhaUBKDlN3g2gF4jpd
         HTHT4FUNrNv+JPB3/wbmzVZEZAriLSEr5WT+R241ABL5iQ9BS/8flzoOvdL32TCzFu8e
         JMVNSdXxIEMpPyzabjb58rjhcxUwqKxsYi/PPx/yuPhK5NFW8kSfMnK64RrVZ7PZ39rd
         2h17s5kNwSC8PJAX2SSE6na58USoH7VcjmGQGNMKG20zTCB0Unv1msqUZR1DP9Puo/zV
         Yw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        fh=pjkvv2yoS/JuWFJel9Ju/ihO+fhsKX6bwf9HPa0jV9Q=;
        b=joywTKjBag+dImgGuQk364qiPbX1P/yP9Ml2GHcGXnG8vQ6u/OoEigHK6JKeGG8o/0
         +1JkYIyLFmfLGuwT9HBQwnOCFeVDwQPkGV3DxbEccud4/VLyoo3xLeaRdEW6Nffnsc2G
         OVmmLENN7653llYXIYsWhYjOFUi+FrJnCXRPWXgEMPFr9Z4lqztdt01ilP3nHG2sGwuE
         jCgiqARU1AkRk70gNw5atjxvqCtxUSSKhqtFuU105GcanHKiO+TzqLbV2hh3Cjj6mtIo
         H7z6FfXTzX9YUeKHgDN1aAUE33Uyq+FUMaqxtCXCpW4AaDXYHKBCu7IZnfW7Yi8LjEiC
         9IEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390206; x=1770995006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=h21RnEhNnb9U9nu7M9xtGxoq26lZ7RtZ5y8tnf++MzxNIeR/zoxGlSz2+uQVuNC9PZ
         yHSw66h35LTh51liKBCVsnULW4SPHEuf3U3wTeDKQ52JocVwVDTH/70Dh7mmfY/61EKi
         obOtto54jhMqGxzf20TJdO7GQMozHonKh+1T6BstjMVN2L6xeZt3DpF/An/Jz17SRps4
         QVoXKTvxdLczce/F7XPYXkx4J52KeOvNUOcWW4JH0wDPPqiEOL8vVaajHSrUH0z8PxHZ
         wM4ocik+fMaMfkWZttzhB2VxtImFzKbgvs0BU2fr408oAXoUxpQ6YQQbx52KCmkVdQK2
         DCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390206; x=1770995006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=EuEJmCNSiRJwCjqGwBq0c/p36gO4Dx04VSA12dhMMU0nAOOnrGYgOdgD45Twq8GBVK
         jz0H5Li9V7PbpaqTGLNQCr2DDUBiuET+Vje2KXliijuCCKwLEfFihAtDkQjGDk9C2PqU
         dF1pUTVWDTQGphat6Ha51WaFuFU+T7y522+WhV3LErxIuvaaE62ygtPv9pqNZEv/b7Zr
         cM31Cd+clURYBeBkDMTyLcYqBnqWB3Fw6fzNWjeU1CwtzPQq9wZKDYXg0eBVZtw9YNOP
         St9dqPvHkzh8BABsF4Ldhdv6vwv9yI/fFrFGJpTCvvPFEwyQQ3aQ/nW0EkPtlVqS55wB
         XYPA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfBBXZU34m7gh4ZlvCbkqPIxOod7QDwsiM1NN0SjUyfIkKNhwryW2JRHJ5t4gARQDT3DXJ3bmO1mB7ZjO@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyJNUfCCWnt8h9Sp4xsA3khtAPDP7BBnBwWRTOBHMUaS/WLkG
	eyB8bd26QONymqArcnKzZqWVVuSj/kqryUl62NSdHYwbTzAER0RGswegMlI+wUH8oNU1pR+s6Kx
	VEWFpdIsCfOswmx6n/UL8NioT5/Dc2A==
X-Gm-Gg: AZuq6aKnTbvrDf+ae6heYlhSW9wV0armhJ3ua+hBrUAeFsNtnHluZu3uSfm4phmjJek
	0C4v/lSZJT1OzccTTlkY5g+kDih0FSCfnJPYRHaS703VVKbms85om/5r7ShSBND/ONcTCNIjlYV
	6lIHwSTRfOpj2bnGKVMwIkDPqol/O1w1wAwSWvaj1owFf2Y1KI+lD+K3Pw4t/V7a+cJSLVKVPOC
	n1dhOCRWtcAuUqyqw0TmAmHWm1Qv1rBL7fQ0iptnc4loX1jJIMeSf3Mn1K3G/k4ob0HozcHyWWb
	grJHJ1j3mRxy3faXI1ageBbFtuXIVETZADm3psZZFkMQHyOdXQM7ViL7AA==
X-Received: by 2002:a05:6402:3583:b0:659:4383:c491 with SMTP id
 4fb4d7f45d1cf-65984193946mr1569160a12.33.1770390205748; Fri, 06 Feb 2026
 07:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:32:47 +0530
X-Gm-Features: AZwV_QgZhDOY8h13FRDtMZqnV6_xaqir1VOWq2MTchb4BXyrN5R68VQhosU9bGY
Message-ID: <CACzX3Av_g5g=ssfSjHzkosEj7DMU=+xY5fpdU-zYGYc0cUWPSA@mail.gmail.com>
Subject: Re: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-76587-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA10BFF70C
X-Rspamd-Action: no action

> +void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
> +                       struct dma_token *token,
> +                       loff_t off, size_t count)
> +{
> +       WARN_ON(direction & ~(READ | WRITE));
> +       *i = (struct iov_iter){
> +               .iter_type = ITER_DMA_TOKEN,
> +               .data_source = direction,
> +               .dma_token = token,
> +               .iov_offset = 0,

nit: iov_offset is getting below too. can get rid of this one.
> +               .count = count,
> +               .iov_offset = off,
> +       };

