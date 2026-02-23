Return-Path: <linux-fsdevel+bounces-78000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN3yGsO/nGlSKAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:59:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55917D4C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA57830713FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D1378818;
	Mon, 23 Feb 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+1GIg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660B377554
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880375; cv=pass; b=pe17vG7PNFLQsLCIjZr2GWnytHYnsgvz7zZNbX8Do68KLaeprp48wu7OzAkT+W9xi9jDUyXRWcmPe3VLSca711MN5QtcpIVDu/tRz8BicYIxajw1C5i6cul5hMfECeySEJJYyz63VvfzaQm2sDVEJVBZrjCwS9jmde4P4I0MR5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880375; c=relaxed/simple;
	bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4hhF/3RfhdNWQyAN9EzFyIDyf5UgSCy4/VyMHxIwFmIvH2Y2xRoz3jaiDGDCKAnUDLWzvE1ZDPA8HRGedSF7Rlv+CaewQes216KNu3RmdXn5mkUGz6sWyjTn6zTXrTMGrBeINppsJ8aYbpUt7cz2AVEDdLjISnoy8P+VIg2HH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV+1GIg6; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64aedd812baso4446580d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 12:59:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771880373; cv=none;
        d=google.com; s=arc-20240605;
        b=Uh/igBQ6E4iDoNxtGmXWHm+hwhXcZcdbncaf1KCqMuMpcFFtBBVMvyMrzOBMLqrTBF
         0geP724o9u5MCEqbrbJx7FnA50wq8qCmwoVhe6yy+4uup12R9d0fAOCjEWjRUoVfOShV
         uOd+jt0f1vPxz0PlwHGnufmzSVTl8UusBnCbZTJzYML4f/6fy/2ngSrWNwxs8ekB5OfW
         XGRPmrLPc1bLgrBav8Zi7UoxrVpqiq7DLK8DHWGv5JOGc2uGcAC7NOOLklTDE7gEO239
         saGho0xol9FSrMNK0H1e2CbxRsB2Dk/bAOcV8cUv/sOOuUXbIXEUap/wvRpl4DSCzcCR
         lPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        fh=tq3QcxRhP6nIoMrDwp0CCKeUDMYQR8LB1C7SNVZvsC4=;
        b=QS5AZu4PLfuvhbd16yEbwk/b6lsKfdINt7Uns8rMWaamBN3O+bCDVyhdor16X7AgUW
         JA4fs13A59xfnq4CO/rljpXVgOx/ICjcUC5Z3SgEUfIKimQ11F5mDcEjUqbGrQ95wwa+
         UDMmmw89sRi4xOCIR1jGwoGiTuWY6b/OF1kwcZ6/2oj6J0IsCX0C1+FZNdYtaXlEqGBt
         X934fWeEMMFF0NV8bow1MrwrzBWxFGzqV4v925i3glhuvtxmnLzE/d8f1v83wkszxCLa
         YOJkECrNPWJnCb65VNqp7C5CmvBGscJGFrEmOqohYJISjuaB/ObGIOo+8T+CY0dGF6aW
         +I5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771880373; x=1772485173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        b=eV+1GIg6+1Ij6dfRAkcvpGR/q8GlRjkqQCIlV+t1NLWRdwYCLtLMNWZecHBdU91rFh
         w/iD6Gfhxx7S3i8FVR6Z2rWoctuQVejqEYLaSbEdMcWr4Hy8N78bLgttQlrTwneVi+EL
         dwHq1GNVqnsk+cOcbRlbpbY3Rm5LouK9CxnIkF4f/1F+orR93pNmz7wh9uDscIxyNIHV
         yAc+34cNpXTa7UlpTfxBGHiuAXn34ZbbV+NS1WuwXItiSzeDY8gSg5wU7db0gTGrIXYD
         U11fCL+vdnRqQHTZXkz2jsI+TwoWcvzg3ZHapdMrMxjL0xwbJ61gDPS5FArIUhAzQQeJ
         G3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771880373; x=1772485173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        b=Pjut8dX3Z1wowc5B8l93fr9W/ML7WyHPbryfnMfsoLiF8Q5nBa9wyZhInH0K37JKmc
         kMArBM0tb3UzWnNuI19iQwWk7cUdExYiW8j+O+eWptvqMFc+LEA28KectyZhNqBusdJt
         Ye69nXQCoaDk3U2CjbNOvInhKUxLsF8W9rnSs/KPQM6sO8Jw3V0ypdWHfdtP2bw2eVox
         vWKC5l9ZL1mH8bOCSsE550hCjUtkJrL2Lv6/ivLNW10f5TML89c+km8QGgwGSabe/ni0
         RyUuXzSQoUwyKRTkkJayyG2xxpfEWzECSqciwHOvHnSYsy1JXvym/7xHUUuDrohjSLIi
         0qWA==
X-Gm-Message-State: AOJu0YzN9O9E0EqNJ2jZ+KSy2ngbRUoC4uH6OJf76liLs5ByINxocIgV
	N7NqDITA78w9nJf+msItiZx2CSPHV902ePp/nFH1hvbuqaZA/C4JBld6Dw8yGs0w4Rk6BOdfckl
	Jk5ANOkxa61ff3qY1YUB/KsQIJosq5fs=
X-Gm-Gg: ATEYQzwLR1/1KOKicKlMWVnRmNKbrBWVQvW4w1Duq9G2SP0EamcYfnDJZTPiYbEbgW8
	YJNcO6VWktfiJg7rfqq7skDiuH/slvu9QpFetr5g3eIx4c7lg5WGu4VhbFqbYWycCJSt8LiEz7o
	+HAHDlu30Ew9Ulb4tPYSHHoY+HBZW/Jy59gTcnkT3E8mrQiu+VqntG+nLonED/eEvrv1etVI9HV
	GBNT5PwbjMK6zEft/KBXC7DcrhfwLDn6RWITKedz7t7i7YrQVICT+Ls6XBLuCkpQOGyBEoSLsiJ
	aG1jUR4=
X-Received: by 2002:a05:690e:d47:b0:64a:e799:1d84 with SMTP id
 956f58d0204a3-64c78e3ed37mr10186762d50.49.1771880373230; Mon, 23 Feb 2026
 12:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com> <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
In-Reply-To: <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 23 Feb 2026 23:58:57 +0300
X-Gm-Features: AaiRm52qRcNRr0w0juOjbrF6MNkTC6Cm6dik1IbLPWbMt5sbBgSggwUmnjLgJPQ
Message-ID: <CAPnZJGAw9o8BetWs_wO2B6YD7mYuOopP0CwD=KCfOJXw2QU4Gg@mail.gmail.com>
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Rob Landley <rob@landley.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78000-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,landley.net:url,landley.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BF55917D4C9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:17=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
> FYI I've been using (and occasionally posting) variants of
> https://landley.net/bin/mkroot/0.8.13/linux-patches/0003-Wire-up-CONFIG_D=
EVTMPFS_MOUNT-to-initramfs.patch
> since 2017.

drivers/base/Kconfig says on CONFIG_DEVTMPFS_MOUNT:
> This option does not affect initramfs based booting

So CONFIG_DEVTMPFS_MOUNT works as documented.

(But I am not against your CONFIG_DEVTMPFS_MOUNT approach
if it helps you fix your problem.)

--
Askar Safin

