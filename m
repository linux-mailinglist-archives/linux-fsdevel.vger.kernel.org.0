Return-Path: <linux-fsdevel+bounces-75027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBCSOrEacmnrbwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:40:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152E66C08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0CD970A69D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8B3D1CB3;
	Thu, 22 Jan 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVqBAs+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD68F5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082752; cv=none; b=pqc1f8Omf2oGo3OWrxW3KDo2MFvSri6MYc2RRFyP/LjWykjlmD7uqJ7R2Fa54+j20DVtlN2nLfPqPVc1n42O1mQV+h8LTxYpCK7ELEJPYjisXB1ILB77HGKzAUVz/FbpawVTdx1twatHoTIVPF5vvh3k44bCe3VBUQ1UWFzS1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082752; c=relaxed/simple;
	bh=A3+65WGd3SDnNWMv6VHdibqkbe1ftUgRg+zBFFu20FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+bcC0VbmSKt1+lbpsjBjJPIRhCa2hKtvC3eVKr4QVecmADl99tjCmvciwiR38ktVH2gk9pmuk07+/Km/A6stllzD1Q2KtiPSNuLX6/ePs4feeqLJp2SnaAzj49guLbjyOQI+plyUpQQsrml9v6tpHbp9I/r5v/gLMnH2zwk06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVqBAs+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88FC116D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769082752;
	bh=A3+65WGd3SDnNWMv6VHdibqkbe1ftUgRg+zBFFu20FA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nVqBAs+c5doLFizLJbS8B9w5a5U+btEB0mSiRgry5GE++3xqZBb5jV0oBAW+t61Bn
	 psc7pvcjd+IX05sZsYagZoYMkULqBGM0U8MDx9MGoToWZAAjomKXgKcMnd5y4Gjet9
	 k1bYeGLrwjBsOehhLIaxeI7zdvwtO9zZy/h9ob/JEssr6tyPATR2oLW32C1aK+lGH2
	 NKMSpZOw1G7fl4gGR7GmF8gWoKXhOed1WIEt8SrrUXeNtL0PALelX8/1YOhNv5LTYl
	 5axCcT4tJ7u9lpebwvfJqQq943sttyZ/iSGU2l5GOxoT6Rx3M11AafEyLgWUsoiV28
	 Ud0oWRK1Gs32g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b884d5c787bso26450766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 03:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQn5NrtNOHGP9dYsP7KF8eQH4BQNq4rOpSfEheF0FKXwYSl+0/wdBLCA4aNyw1aQbsFXQzjFlAkd813NtA@vger.kernel.org
X-Gm-Message-State: AOJu0YzUG6N4WKuPcquHac0RyTpWfVIG23SE3NB1mNU3WHiv3UtExQSv
	N/u2X0p/6VSHtDoL4LIUDnrluZJv2Mer++1xvXNlgx8UWY+dw/cBnBOB9SoT0qHjmFc4Zx32CaR
	Vcben8phwB+6ja4VZgYU9a8MqhYZRDko=
X-Received: by 2002:a17:907:7288:b0:b87:794f:254f with SMTP id
 a640c23a62f3a-b8796aee903mr1891789566b.33.1769082750731; Thu, 22 Jan 2026
 03:52:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122000451.160907-1-william.hansen.baird@gmail.com>
In-Reply-To: <20260122000451.160907-1-william.hansen.baird@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 20:52:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8XaWCfAZ2pri2uJcn+EtpY4-mEYJ28dc7ywHTWmvbJHg@mail.gmail.com>
X-Gm-Features: AZwV_QicWA7wG_puZlyA2sXZA63Y2MTrIX4DZDCpr_5BTkuYmtbUqroR-f0sCmQ
Message-ID: <CAKYAXd8XaWCfAZ2pri2uJcn+EtpY4-mEYJ28dc7ywHTWmvbJHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] exfat: remove unnecessary else after return statement
To: William Hansen-Baird <william.hansen.baird@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75027-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9152E66C08
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 9:05=E2=80=AFAM William Hansen-Baird
<william.hansen.baird@gmail.com> wrote:
>
> Else-branch is unnecessary after return statement in if-branch.
> Remove to enhance readability and reduce indentation.
>
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Applied it to #dev.
Thanks!

