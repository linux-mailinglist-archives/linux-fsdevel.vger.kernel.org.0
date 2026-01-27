Return-Path: <linux-fsdevel+bounces-75620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNFtF9bWeGmUtgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:16:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698B967EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2213230EDE07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949E3587C2;
	Tue, 27 Jan 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ1uuKOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B80355057
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525888; cv=pass; b=X2cTQvs5EClv4zwnEbaEpVZyTtqkZ+Ikh/dZtJnfyuYuqkP9J16eO1G5/B28STPMAJQUVPmH5mZISCAnRAyoNyYn9V+zLimR2VRW7ODgaHrndYQMkX8+N6aFZc7rv6fBWkjxx2e7fjE8otz4iDkOp0Yb175Wk2sdrQswTLjWcvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525888; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjdRpv0m9QLI7xCkgkM1IWPcvomhMOdP6b3eazr1zQacFPSySpkT9eJ6r/98jK5KMPSuNrkvsYdJVNt3D8mIYpgWN2J1OuyrXWvsA56mo7cN5OstW+ccqB/5KlU77fySwqK5Kjauf/gJQC5rbqS3k1jM7sYf7fL98vZxXmAYSWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ1uuKOL; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so9842464a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525885; cv=none;
        d=google.com; s=arc-20240605;
        b=j2YfaMlwjSSkc1kDMHOP+uEjRAzvGabIea+VdEfphJtEPM3NqEQXoLLjFnNHEBMn0+
         1t934bbchLn7KAldjz+IzA/OHUVu41Yel0wC6jAKes1VAX9KIgcjuilkDSwyjwQ66epi
         lgn39fUS5XeSORV3G3NGQN7vyDta1eHtuf6IizFbJJb4EBGg+QjghtSH4rEVitxJFZkJ
         9VnU1lYPhqD8o9DufKjKOjWiIjIA2GUwi7Qv5zr4ZozgozW4b4Fbx4zhX6xUUhMJg6NI
         MXUMICXD2NfA1vLANw5AIgHMsyZno9N48i9DCojzvjnWPTKh4tS7S+bPach9oLIIPT86
         5qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=ZxFacZw0nClr642YJ8eOLFiiu6nBgM7GnKKDp3KFL0I=;
        b=Aj7f0Y97Pt6x/GHdx+NLNj4kxEqcuQAWotfzMZHfdzV/ozmcGnIbZ0KAy+6hvFVrBi
         3Fa0CN5lG75Fzlw2m8VLcX/C3fMkbLaAUF0T6ce0cQreeitT1ATVTDKBjrhIu8ZS0/6O
         gd4KPEwxcbUPR7WLjP/SbvXAAAjoV4UzDtiFeM9wJMgd8X2/HWi5iTNkS4iS9ZJMSjm5
         XHnuQzASeipJEdrWChzntIRBXwdHmO9AaJyh+rN6QSYODDgp0ZfMn4XAOdTgn7N15J1u
         qmlRV+KzMSTGvWutPax6tZdeRaxEIqIYvpQ4htC3up02g8ZU+fIcuU6Pig3hEE0GaLMK
         ziKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525885; x=1770130685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=HZ1uuKOLTv3GJ3SCTXzF2cAvg/yqb+tw2b02AlJm0yuQ/Nxqt0IoBLYbwtMkgWqyxG
         AJcyeCGAIi1aMZr/hPZzrvvVMcnN0+Lz1NJyvOlrLKvCIeYS1tE2yHf2oYDY1r5TsdW8
         GgYLJNo9lCxnXs+1jB+2eyaxsV+MrvvtkgRSL0EYS0Mm57/GJOtzWgmTlZvH2k7w5Yxs
         Cw5hOtl7RGyKlL0sQgluLIohVz6KSD2kaU2dFqT4nk1PCUdjhulLjfWqZbNSAuBU2sKN
         el4TNYmrq567bSYkZgRfj0eHb6EKvh67J72XO92eJR8VUXdSqTBWOiLwGZ4xMhC3Drgv
         zRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525885; x=1770130685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=HRpaA7TmazRI1JhiOU8+Nrf8i9HU38bh3Gp8EqYtPL+GksZCSSMTtLvAzHCCmg93L3
         llrXXxppYOoLlxzibOgUOtFlmuHt0h4mUNNmTbN2n/XLD8WMb3CgC5j8VPTc9kslJfZA
         jX1zvtkdMI7W+yuMFRjd6mfSn1e3pSCj+zJJNJ14dd4T0Xodt2NTbtxEd1w2aPLP2PNB
         72E6SDizawNtbpQSLKhFlCfThlIt0YWMehWr6PM3vBA2EaZV5xVpXiMkH22nFUXA/JqP
         rDEpzx9qNlqb4WUqvNqlzhkOCljgcHtgmKGfUa7PecGbj5M526xOQdCiva5oXiMb1LXE
         nriA==
X-Forwarded-Encrypted: i=1; AJvYcCWAWijg09ECguUAesT7tdnnO5RESA6K+XAOkOM9u1ecI8Sl68HO9XyLBfWu+jUPZ9bhiUDqK0SYqaTbBLYM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QAIQSG5qWqSFy2VGb1msEl6pKnu4aCLRBxiG+EEYTggSIJSA
	RzDFOuLQyuZHgpBX2v5ZGHau4ld9XLfLi5UhYwy9XLKk4KkgVvYjjjNPqRwL2lbXDKZ3+fZK7/h
	JWgI2SA4MWBeFvvj1XzHTL7kDS94VJg==
X-Gm-Gg: AZuq6aIbLlswU+mg6n7cQQMc52kOl1jtz6WNZRCMAinSn/j77AWuH93SXjQ9lav91Sa
	ldDQvOC92R2v+LNv8gSRssSnVRquYPTi/HqCce2x6twZ/wMRNbof/9Dgy1CAdK141taHb98QR9b
	Gi7vHXMaQX0KtWY8JxDsD8JwLiJsWkk4B7xXNYDq22kcUhN7qI0k5o/cTNxhiMZyZpHCwYRUnUw
	5qrChghnRRG4Il3Im3isml/4MOxben/rAFN3qdQ7I+2SESbGjwxA/ny+7tO6YZL8Xk43FSoFR5c
	XEIkb0+Rr3WhSyV1pWciBDh1ekQh4bpnviT1aYJqRv/Gr3Vpw7/3z0l/nA==
X-Received: by 2002:a05:6402:3990:b0:658:1b1b:15a2 with SMTP id
 4fb4d7f45d1cf-658a6015a38mr1102233a12.7.1769525885403; Tue, 27 Jan 2026
 06:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-8-hch@lst.de>
In-Reply-To: <20260121064339.206019-8-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:27:27 +0530
X-Gm-Features: AZwV_QiLLibbUg0iWqpfZ42-4rmvFtl9Ak5eBKgkKHdzZSGOKr8Fr4xqlZcQZ0A
Message-ID: <CACzX3AuFkVucGMbP=YQTB9AH8J2iBzzhPW98JSizDNChzV2HuA@mail.gmail.com>
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to bio_iov_iter_bounce
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75620-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 0698B967EA
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

