Return-Path: <linux-fsdevel+bounces-78892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBc2Fz2MpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:10:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBF1D9834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26F9C3006167
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7C3CC9FC;
	Mon,  2 Mar 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JKZVwZw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F393B3C0D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457015; cv=pass; b=hKP1jgsylNr+uGCe6jJk/CPupW72dNvG9z0nFjAl7eo7zxzJJYla+jUE+y2y31Z9VNBLcpMwf5DzpGBVNS6FHVMVvDErKkkZWx0XyttsI+yPTbLqEv3hXu7TR3KGQd1mvUhMbgpmrDdaDzCiob3MqNrWQUgaCb0mYf/npx7SeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457015; c=relaxed/simple;
	bh=Ksz8OwQoJjwiki5w9Te5otX/+tgrm32ehBP+y00qL38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Wtl47/HTZ3joNsgB8mfr55G+8cQaClCmTHAGP+aVDoHOQdM2NgQCVQfTbjaUMVOxaVFjvSZmKfGiMdae9muFm4ffJe9k8anBa7tU968MOxFFS1ZCq8cykurzOxOWDUm4V5r5xdKhVTI1kyovo8REPDzv97ncH7D8BnltC/oOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JKZVwZw/; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-503347dea84so50929621cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 05:10:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772457012; cv=none;
        d=google.com; s=arc-20240605;
        b=DIc4eIHHdbC4H3CqNasSQYWyaBunjsFv51WiMsgrmendItxegRENVrUmWh8wBY4Xxc
         9IpAx34fyN6RAav9M5PoJLZfKQlDmZiynDATHAH4lGlGZiSx5w/rIrElxLB51fSS95r7
         1FP+ZPxxlMy8HRngH9/6KS2ZXc4Yg8sIYU+YOhapGIuxeK02uuTghlsZ4KEkhJDUXlpU
         Ejt7tkVKrQNNxaYzqkBCD7lZDyguiaW9tBjK8c/rRmfn+vsSFbgyu77yW+R4UFmUkHS9
         NNVri8znSEmaFzx5qPS1tz8J7YaO++ycrhsQm4/TXXIBZftTvI/S4o1VTcyncyXhi8fj
         n+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yCykOgsZd5+39Ruq/TC9BPanTCyxkc5loRrEIysX2iA=;
        fh=ulp5+SAB8BflR3ZmWXhNYJyx0dUOvcLxAcxtaRDoto8=;
        b=D3j3HzOVpMds0AdN0ixhV/eV45hB8fjueJ0MoVlR2kiUSbiGkHnDiCMhiB4qbNjf/A
         6FQ/MZxQfzRYoz+yYCg1CeWxqTwDAY049jtlJeSan8AxmPrhQK0WXNXmyMB3YwO4Fh+G
         ypQyLSqGn6rXZO4DqccXg75gCkDYrvdX7nPUahV4WXO2t+c9SZeN3uySyArbEX3M5LGU
         jlgg0Uq0hb62XyYYZcwv4kyQzuZlodrXKVakNDVdXWyjC1U7gfdZoCaDav1EkPKHHVbo
         I1ot45XrJZIwiosNOk8EAvkgHp9GFwsCNsCdc/JgIHbm5e/QEP2KqFwSKT9TngnXCaO2
         IdsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772457012; x=1773061812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yCykOgsZd5+39Ruq/TC9BPanTCyxkc5loRrEIysX2iA=;
        b=JKZVwZw/oaycI4RDtlWmkoIraHxgx6xHp+jDgFGqxlTvK1zs4TJNnpIPJWEH6+URlk
         sQz0cf4++43czKupZHZ/UFt+Kwvyg+iy8Xb0fW1xrbaw5AKT1LxBMRHJs0PLXRxDD0Z9
         uYIwoRdjW7w9OlaySanYHi/rLFBxpoY/fjAK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457012; x=1773061812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCykOgsZd5+39Ruq/TC9BPanTCyxkc5loRrEIysX2iA=;
        b=BCSbYZZs+p0vb72cgqvKeeFHRi/5Hvvov6pARGkZZfBx1d/6No5l+9n7QQwbSCV1gD
         +ap815A2htPU5r20DAeTsnVQyfA5ciplCHwOl4SEW6z1/ZaU7vY/csD51LHo9RU42LEM
         3ho2iI7RAvM7NrqjdmtXkLqBgNT+mJdrq0AYudBekTbJzafb4DPVy2kfl/LkWd+rsrfP
         OdzWT6PZnqhCh7UfujUSnvVwS+26hvnFq4QYCvYPvNJmeyJvFlZfBgv9WDVSB7Qa6JUe
         s4UiUqlPFp0EnXPHg4h8lhvJYz14lOiZtJrIKtU62W2Me7Ae4/hNLBLWTi6OOgB1kkGm
         gZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCX73TYAyBzskxPxlXlp2LBWxg5aQtBS1dcEDtI7cJDrqsz9DuLxxDxC0lISyD6CjC96dtZcCKwEX45OuHKe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8MpXp/fRZL0mpbOZ+I9b+Me8VqT95I6Kzhv54YEuG/8LwOJy
	qu+n3I+F84ExXiBwfnY8DaBad1WWSZJ2S/Nf/jmJzQat6EmxrW4HdpCtBhsfD2rdHU80qt2t5zs
	HGS3XaBmZnV3oHH4bcczQIsUuRkYCIS0FAHn+eLeUeg==
X-Gm-Gg: ATEYQzzAnC+ti7lcPNqVvTckUvmEXoxAU/ZA6cZ+9VJa8iEFvFZNaZozphQGw0BhyFO
	351QivtA69dq+81Q6vtYASN9T9CDZBFlGRjazlMbiqhXQg4zY/w8dTCldaMn6V3CpxwEXTENi4D
	KP/8Bsu5FtAnkbvRKvWyIJ7rgLd/qA8QY0hte1WxrmII90oYqihreEyxYqQ4jT0B7Ed8KBn9lUw
	pgyraH7LMM8ZIIEWc6PYDZWf0PutC1xeeHIJoxTD+1TM3Lp7EL1n31yiJmXhpJl2C14xHlT+pkI
	fTgMif1BvQ==
X-Received: by 2002:a05:622a:4d2:b0:503:42a4:96fb with SMTP id
 d75a77b69052e-507528d6928mr170189501cf.65.1772457011655; Mon, 02 Mar 2026
 05:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
In-Reply-To: <20260120224449.1847176-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 14:10:00 +0100
X-Gm-Features: AaiRm51JDUWRF-Hpjrk-95Lhnfwkfxd17Ra5kmf02jAYPY90Lu2jZUIscLdIW9w
Message-ID: <CAJfpegvg8R7tiERDa3D=k_jxKGMU5B8i8GBd4SJSqqYC8=hn=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fuse: clean up offset and page count calculations
To: Joanne Koong <joannelkoong@gmail.com>
Cc: jefflexu@linux.alibaba.com, luochunsheng@ustc.edu, djwong@kernel.org, 
	horst@birthelmer.de, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78892-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: F0CBF1D9834
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 at 23:51, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patchset aims to simplify the folio parsing logic in fuse_notify_store()
> and fuse_retrieve() and use standard kernel helper macros for common
> calculations:
>  * offset_in_folio() for large folio offset calculations
>  * DIV_ROUND_UP() for page count calculations
>  * offset_in_page() for page offset calculations
>
> The 1st patch (outarg offset and size validation) is needed for the 2nd patch
> (simplify logic in fuse_notify_store()/fuse_retrieve()) in order to use
> "loff_t pos" for file position tracking.
>
> No functional changes intended.
>
> This patchset is on top of Jingbo's patch in [1].

Applied, thanks.

Miklos

