Return-Path: <linux-fsdevel+bounces-76057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBe+D5bPgGlBBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:23:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB6CEE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29B03002FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09C37D130;
	Mon,  2 Feb 2026 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7B5tOuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29D37D11C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048891; cv=pass; b=NpOfemCi2L+zX9maIXrLoYLVfys+vlIKDbKxCsbpOcuOWcJojYbvqqfC85afqstLBcQROyuJeya6/a4PUDHiuLa1SzQ1m84CqTmSvrC44NXbZjlqsr/6v1rX3pO48a7PuajN3k6HBfe5vNOxWA7MZclvwsxMlHkDs/RSLhZMigI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048891; c=relaxed/simple;
	bh=BHmy71N6ruX8WA/uOambMiTdpdd5muqzkwSC3gL2WVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKLZM4WxpVOL21MY2DC5QBV/MAH18YvWPwkO7QLcez93byaR8IlEfiEGzwW4ooT5yByWQjp8Y9+AbTu3xw15+2psXFcgodu7Hwhd051gaAj35Ws1eTbVVizMgtKKzU0LDz9sdMQd2BvuDOSBtc5/jnzsSe0Q3rEnhW1J9vlcYyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7B5tOuw; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso6265719a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 08:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770048888; cv=none;
        d=google.com; s=arc-20240605;
        b=NMFbRrCmyBHuOApZnCF4ma8m1IKUlixhVc1M1j0zcfw6WJvoJ+dRyba18M86aW9On+
         s3YDxpvf/zGRutYgkAAb8f97PvgpQjdqx2iFclX6ax0wRAwScfWzws2ui49cXCiQ6RRZ
         smzDpAcvS4rG+EI7b3CCT3jGmvS7e21pb0pyUR7RFt6DWlOdJkvYtWAtB2Oj0A/8XbCI
         LqXNecBHuy/V7txDZEo8kCNK5CWSMvN6JWwwtG/rsYwh0ouzwrKVPwtCnT/s8/N/nt8R
         G3bG3AwIcxg7JY70RqSmn5cB7KnQ0mZyv6cl9jEkbhFcFrT65Ex2VjHQE7V58O20XAfR
         Fa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WL2YL2ov8cFEmqK9tEDSnpzHt+UOiyNEnQaOQnZCrtI=;
        fh=zrdOx4MPITjd3L8aZ5WDT3mcTZG5XEP4uSg82H6dR8M=;
        b=EEJbtGwFvAkD1BmMIkl8KIgbRoSpAPcN3ks1z7WcCnwywhL3wXcNEN0vmxp6Ekh8el
         QQABX9qqitR5wKh+rqLxq9wCIMeb/TAadGXK1HvA9/JAnixA2f+ApPK4l+oJo+uBtB5z
         UBF6ngvLGc7tZCemz2I4ldoa/nJoyEKyByYpLtv9TSJ3qBAh7p+OTgCuPY5CapDP5238
         eMS4c96mgxoRBHWUZGiyHDnTyNPVh9ppKwHvJ1vEYGuhoRWEjTyhWEoyGcP40dvPR/UY
         ZPeJNiiTvdCYSP7aRXajKPnm1hYPlV+j0T2Ih01/FAKIQtTEZ1k4JrUOm9PXbcI+otsw
         sU/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770048888; x=1770653688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL2YL2ov8cFEmqK9tEDSnpzHt+UOiyNEnQaOQnZCrtI=;
        b=e7B5tOuwktysoE3ZFOb8gT3W38aC/eNS7pWQD2ebfxxVr7ysTl0HtQNrcQWUZ70cbQ
         xoGk2GDPzoCwsXGl/adnY+JQkTsMv167S7K4J8B8I9reJtlOI/35em6sfLRF9CO68POe
         /2Sw9omHpNUCI30+gDNB04Ij522kqJk+3ys0uCni2Kcu1K0G519dxbprRVQSV9IVeLGc
         F804QO4aQ0SLg1I0wIHfxBuQdKf1AbRuChzc7/G40kIRAol3NJHnID9LwvPnVwWk1cws
         +xwaNXOfTEP+7jkNpMme/LBUn3DTdR5j9sSxUBCFKzMmDbWmVy9ooJJgeHT+X2Q028xR
         0JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770048888; x=1770653688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WL2YL2ov8cFEmqK9tEDSnpzHt+UOiyNEnQaOQnZCrtI=;
        b=ZHmRwiivEaiM5+NqSYRgVLXlecX7NdcnuaMrFQFKTuiiogwUT3CHctvMyAlTO+bhpx
         hdvuXPy8uiA4mvnWi7x+ELPCC4lIgg5ealV3n7GFoXMuo1j4M/8AT9/A+pq9OkNKYJYU
         8/FTImHff3Q/0t1lbkwAUGvi4avO1EZwI5sTju09MjolAxWsxt8RNxRcRT5iPXP3z/fy
         9fwXzQ+ZB8vYsElpfkSfnc0kdsrpd/PfVYI1Tj1h+hN2z/66ZJNuNu/LjZwVqzjZIqdL
         KiRCAS3C4y2YVkz0vEGlO8wqJeqAD7uK96u8MOvM22e+030uPiI7C/F3oLcD8tAQdJQy
         9BiA==
X-Gm-Message-State: AOJu0YwfKVhQL8MKkWFq/TKNpCsxk2WjncumxXDAHTrY8/C9D5ZJkNyY
	z+5mktefCqy3D2nOodxuSCcZ8FLljN0SPCGLrdPtwmOat0KOtr1GgFJ9WSQnDl5fSo6Wrp/a1i0
	cnPR7reTQLbXoJhTxM0AE8yQQ8g6wv1E=
X-Gm-Gg: AZuq6aI4qGi2zK/R3YnNi/s5znr42fA6nHjGIu912ogjUfK3r0qZUKyTOxQm/1n/gZ2
	z386U28lZcQ12RoAOstsaP8VBye42LyZb3DORbuobjJQcq3Kyk/QhflcBuvYUi3xD3SXr4QqOhP
	4Bi7QnafffLPJV/TamDjresTRaihjpZD3zNCWF/RND8t4fCb3tjYYAcDWbAxofysHsBN8eT3HRG
	JHNpsgdUu9FixaJpyJY9+8FC1mOi7HEfuuIohQbpp2Jm97NaB4sTujSIC+uGueg/w7f2p0Pctlt
	TW4qn6Vhw4bQPGHBP/PrVhfo1jXaww==
X-Received: by 2002:a05:6402:27c8:b0:658:31f9:9ab8 with SMTP id
 4fb4d7f45d1cf-658de544ea5mr8162213a12.6.1770048888258; Mon, 02 Feb 2026
 08:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
In-Reply-To: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Feb 2026 17:14:37 +0100
X-Gm-Features: AZwV_QjFbt1O6hxWnVNxYL15GhS3dl7l6fX_tmy2Sc_b2ToZx99dbUSWE2wuU-M
Message-ID: <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76057-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 90AB6CEE7C
X-Rspamd-Action: no action

[Fixed lsf-pc address typo]

On Mon, Feb 2, 2026 at 2:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> I propose a session where various topics of interest could be
> discussed including but not limited to the below list
>
> New features being proposed at various stages of readiness:
>
>  - fuse4fs: exporting the iomap interface to userspace
>
>  - famfs: export distributed memory
>
>  - zero copy for fuse-io-uring
>
>  - large folios
>
>  - file handles on the userspace API
>
>  - compound requests
>
>  - BPF scripts
>
> How do these fit into the existing codebase?
>
> Cleaner separation of layers:
>
>  - transport layer: /dev/fuse, io-uring, viriofs
>
>  - filesystem layer: local fs, distributed fs
>
> Introduce new version of cleaned up API?
>
>  - remove async INIT
>
>  - no fixed ROOT_ID
>
>  - consolidate caching rules
>
>  - who's responsible for updating which metadata?
>
>  - remove legacy and problematic flags
>
>  - get rid of splice on /dev/fuse for new API version?
>
> Unresolved issues:
>
>  - locked / writeback folios vs. reclaim / page migration
>
>  - strictlimiting vs. large folios

All important topics which I am sure will be discussed on a FUSE BoF.

I think that at least one question of interest to the wider fs audience is

Can any of the above improvements be used to help phase out some
of the old under maintained fs and reduce the burden on vfs maintainers?

Thanks,
Amir.

