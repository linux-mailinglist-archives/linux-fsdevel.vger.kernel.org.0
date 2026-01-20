Return-Path: <linux-fsdevel+bounces-74612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNt5Llp+cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:20:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBF52BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9517B5CAB77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFEA3BFE40;
	Tue, 20 Jan 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UarTPr01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5733C1983
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906542; cv=pass; b=jetsbYZswRqdh4zvnUV/wk1oHicMSud1IvUBXYef2EEm9LqQ7nW987pg0P7tGy2gLaUgPPXA3xIpC/mvov7fxIzb4kjAeC+BiWg4sefCg5X6Gy9gMRDlVA5R9xnHXwVb1o6bR1VfXH5ovhcVgFZlhtRsPOaF3Vk9Nxa1ZMrPmhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906542; c=relaxed/simple;
	bh=fIzQM+I1dKrQeWlW8RXDEsaXmZzlz/hUkp2KF5rWyuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiEY/R60EufWAY64wx3Kp7nZq1KEar/gF+Ie97veOR8aP/k17/wOFfz/iabC6+q/QmXRQaGVRmHB3eHAGoOqpMcZOiqdsxYn6DP1GZR8PEvlij61T0zV46jbKvSXrAx7FRRSsvLujs/gIqoOgvfjJdMSeK8yuSlzIG7E2LUkQWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UarTPr01; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5013c912f9fso61226111cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 02:55:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768906538; cv=none;
        d=google.com; s=arc-20240605;
        b=YGa1EaJgN3QPlhY2l/R/5WYstrKavHKb1t9Z4Rv0UpWTPY0CINRObf127uKUnXQi3p
         ITpHAkvBfxXlNY5ERiEvEgNdgQrGjXzmQ0CPk8FJkwzXAb+ZsFBZCbzuC+F3jG9MUVl9
         qp+0Muq1hRHY6J604Scoy6bMxFK5D2J3EbJ9grv2uD1QuK4/1+zxN1Y2hz8BlsK6HGDX
         ZnO4pl/m5beZt+/StQ4kqq2uLGo/y9n3Au5aiSL+s3qpp100GApONrwwcoiD57pupItf
         kzFvsI65mkHJH8z1YwLa8bbmmoVtvvxrsQD43E7s0rRPNz7YAfANJR5gClzT3TWqHsHl
         NxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        fh=gVYV0+m1EjV4QNtvmg6wbiIABNg9xbcMUGusN2Lzk7E=;
        b=Xdw2dAPXcj7GjS6NJRtobR7qbEbugt4R5TScnI2dp4wDOV2TRSvPamhfcMfKiH1sCB
         1jvscAy2yVZKFSTfFZfk684KZMRWr1oWT2t9jyr8SPFvii3jWrWIi1L4NRHjB1x3dOoo
         MAHLxoUbooHm93K2oZcJjtBJyRPwXTHk4ik/9HwK3C70DgDfj9kBch8qlIHER6rKK7VB
         NSsHySSTN5WdihfaujWNDjsNTZcKCjiPPtH4fFqeZkt1dcTTuAtI3gLOJA9KH+3KvaRl
         cGlDg8tb1Z6nFtke+C1+Jw95RPOH11d6wiZiCEeseI15THfPXfcuTOH2x9OnAE98BKi0
         b+bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768906538; x=1769511338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        b=UarTPr015F7dRJLJacZZzl2NOK/uiKmtbKv2oceQ84MND3/ducGjUdBlaRQ98tpe8l
         iuWAxTZguNmQtI2E46ndHWUOmlqapQTRDAKQpzRsRC2qJqYZqEE63hOzLNwSX1lv5UJM
         uDEWvpK4Ov/L93nsSMEPmC0p+NZNnZ2Jtl50s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906538; x=1769511338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        b=USObM0eZAlWE1JsalNc3xXcjkLK1rBHt53ZL7U6hdDglFoyJpvdM1i3cejq7iRI95z
         nkvncaofA+v6nTYHBd2abliuU5qXqynW3aE7Pda2708A/Ad0uo1hqi6vy7kcB5S6EGVc
         giPSnT3eBCI1h9+A0KcfCkM0wOdNemKFFvE+K1L4XycH6UWzagAUS35JLOVeDBOHEviu
         uOM/Zw5R34sO+rNX8FoL26Hle6d3kYj3i95fEPgbnYeqWeeRNEPHaytg0ocHeAZ8WTed
         lWOTnYdg/7yFQ/Md5VsahbixKn2mk97EiFJwSoPC1vILUqfhwvs5ZF7D2kn29jbiPLVl
         9FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBSUq8ozXKkKY1B5qPGOqK4lZp1pHHn7kThxZ3J/xiRdt2w/DSYN7ckMYrsfJ7Dn4mpd+ue/zTvLh+/bD6@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCslmInUrygq9fVUurb1KmNZlXr8g2uha1ydfRDrEXlKfyXRt
	8g3N7v8eWun6UrQt5KYpW9T+xZlfhvZ1Pzm3qbJlkP8XnkOz3ADjrHuM/Hs/BGFPLvBn1iAOcWF
	A/G0A0mjkI9VNyJCocsqIzgKCDoU00qwP8ILc7rVWIA==
X-Gm-Gg: AY/fxX4yrab2RrCRm5MsGZKa9s9pdJgLeSofmHyc5cvoUF2ijZ6cSstOEt4WWSNbkgJ
	/LD1vkcj+uRQojvpn0CUz+RnCz8hZ8AnCKtSFd4P5357NasNXZvfPLPxxsEMJbNbBcUtJMVt2TK
	W43iHoSp96LssTBdrbMW01Wt0HE7798B6h3uFzbsjz6TwGm1k9MobqU+c/CJ2fniWqYY54raJBm
	83V9Xm6335cB2kAYAC9J21HXoWcSnkX8KlII3qVAAEHOaF1yOG2PwV47fHxZ8d4KLyG9H1t0uxe
	5dXQLXbH
X-Received: by 2002:a05:622a:f:b0:4f0:23b6:c285 with SMTP id
 d75a77b69052e-502a1f231b4mr161536681cf.41.1768906538583; Tue, 20 Jan 2026
 02:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768573690.git.bcodding@hammerspace.com>
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Jan 2026 11:55:26 +0100
X-Gm-Features: AZwV_QjAOHMTbnCyc1vnuEuGvNZiJz2bkDzfLZ1b6HoSesVSYIgHm3F1kdUgfiM
Message-ID: <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74612-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[szeredi.hu,quarantine];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 63DBF52BCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 16 Jan 2026 at 15:36, Benjamin Coddington
<bcodding@hammerspace.com> wrote:

>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>  fs/nfsd/export.c                      |  5 +-

Would this make sense as a generic utility (i.e. in fs/exportfs/)?

The ultimate use case for me would be unprivileged open_by_handle_at(2).

Thanks,
Miklos

