Return-Path: <linux-fsdevel+bounces-77302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO6WOgA3k2mV2gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:25:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 652FA145831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3AC03065ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0F32549E;
	Mon, 16 Feb 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j2WGFLG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D42325730
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255347; cv=pass; b=ouxVG909tkwD+Xk5Kubalm7BBO3D8Gmh4BTiM05dSK7esZSLHkYINOapNHZZbOxOO1cmcA6qunXU/l8tDXhCI/95JO5V8LCFPwF9HMkdzMtf+sd9MAwy/xb8e3gbgYey69j5C47jkmy70h3ojIccpn0QiohfAjJbQuJia3XoQg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255347; c=relaxed/simple;
	bh=o2smEr5y02wSvFNEy64K9o/gkobu097EYUb5ArGQcZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTGUy8I8S1c08I466jeN/MWX3ijrrSawFlwr7ePGSatStx9HPE/Y0/qy8jNfbkqlmNJNbmDx6XCaMKYstrro1jDCW19x/zuQpKXLoT5e8gvyu1AOSmswiEDm21Pu3GasF8KRFoo0BwC6zJfSf1OpARbY77Q9d/NRp1Yd0KTXYuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=j2WGFLG3; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896fcfc591eso33020466d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255345; cv=none;
        d=google.com; s=arc-20240605;
        b=hrM3RLYFrzbgA/bJq1z0qium5kx6GCOtno6CejQKZ+Tt0DqvIAGbmLHCiGY7FikWh5
         cS+dYgNiLb0XQL8y67zNXGrfmSmHm56FOwcVrLy25zYHz9vAipjtIspg4b4uL0XMhmVM
         BjPhoM41/dHonRgQ1rnZ/JV/XzUHr5NQnrf3LYg4RU8Sj/8RMfZ7eyDXNymY68tHCESV
         sSztb9TyBTENgFeheX/67uI87OacxZWTWFLS5mepr4cODzQIOzFm20jvYk7UfiXnRoK4
         HAa/7H5KUFG0TqoX7pJaTqvod5yCqnIUUliBtr1IKEhltsJeb1uTszJrZEmV2DaxzUu5
         p/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FMTaKREqipi/bI/EMydiCxxRR8YjeKY19XLIBcEIO/Y=;
        fh=xmFsogd0OOoNeDPiM+ut+g+wv5mG42hSpRyoFxf7p/E=;
        b=HeVYEczO+5PvLkcG2VvbI35KecBE7ZEp01dfGY38UzyTj5L1Hf4LQd3wiVtl/eBr0C
         G80p2UqLjHYdOBgGt0rWjVofzv3XzQ5Nud5L7OrPpa9bj+BMq5OLDRgpa6uPGX/hzc+q
         TEn6wf1rwBCylGP5zkBjX625qJ4GGuNpARs8HKjFhKoVkZN60CQm/QaAZv87g5lWYUNs
         6U85hFc85w7NELaGpOg3upTpFs1mrvfIJNkE5dX63e6FLpvkZHoSTzgl4Gh4JWmIjkg4
         cfS+kJ2pmxbBsfkoAOpFy1NVkaIrHIgIMPXp08rXX79WcfjidFPQ69B/xLqAAohTNuNS
         7ayw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771255345; x=1771860145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMTaKREqipi/bI/EMydiCxxRR8YjeKY19XLIBcEIO/Y=;
        b=j2WGFLG3Gus8/ahnk/bkSiLCLBga0aC/3KVwiFL8yEkqp9yYecCKrDOTkM+NvQmI2B
         AGAksXXMX3ua4iz5ACIxfAU93yRaxUYhgeEB6pKtHgZqM+ASl4f6EU18pmlv3nuFPtB8
         ck/3fBvFMJIWJ0lLyMOyJDYHkRsfEMRcCONy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255345; x=1771860145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMTaKREqipi/bI/EMydiCxxRR8YjeKY19XLIBcEIO/Y=;
        b=QNqhDOrloID3iyi92OHvc/kwAlg09pY67fhB6CvD9EEXhFCDcNTgW2D8XMdhjDpoSS
         vH3Ajx4bjgZaTQlFWgkInyWOi1iPBmIG5uzxNRn0EVQSpF2TlHlq7xXAnwPddvaybFDD
         fUnC6r1lli/HwKyW2yRmccI3TukAzCcyhsf8pX9vymapIELMzNsyaQPU9WFnzSXsMd05
         ziULpgvQwuKrT2JrB0AvpiCzz02wxQxD/wM++8GCm8cWzFsCO5iWz7AhGEA4RJvaKT2S
         FPDJKaRzgLjqtVoMToGEraW5qxPh0IPbw/Vl5n+IynUNHF3KA6+7fqKnDY26GJ6LP38b
         nriw==
X-Forwarded-Encrypted: i=1; AJvYcCXxbmdf1822GWvp6rGIOAEJhei20MYCIDpfM6BA7tk7zMlx35CoaY6EmifLWvffbvzKKEGzPoU6wo4N3Zie@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZoG9kaM2Y1ynX3kl4tHfWyTsQ5vrdf+9KWOqDNv0d9AgjNPg
	BC6Zyx2vlr2ZZ28KDPIMqgBilv7eOMyG2m2d1Xc0EktvCx0llviWeUc+9n75lYUFZClolZCZSpX
	K0VWCI1xv56u5MRd5NcLfp5KRQ6dF3RCSafIuTmDIMAzbQc2rHuCl
X-Gm-Gg: AZuq6aKhWZHlMc7qFwNmhSyyGnjnUcmucgkikIU4EGKkbmSg/eHhEFs/FqOdSZ4P4rN
	vWEmIQL3KuZTra3K4ptzZ9tEz1//bBPx5ozNzN4ARJCEXltQ/rkS6nPsGseDLF/8M0zfQ00f359
	rBFp5acbFPDw3xoCUZg5xfCs4ZSse0u6iUy2qrbG6Tr+y6JCrUooiInBioF6HCAoplx+8HOfXYP
	mD6NVGF1TPCHwHeud5lVVTzZhFft8rSPiHxhPvjiTYkOk446ZnHFoWfy/WWvC0oEbGCvPSvHcUr
	SM8QTKc=
X-Received: by 2002:a05:6214:212d:b0:894:7144:7572 with SMTP id
 6a1803df08f44-897349856f6mr180083886d6.64.1771255344704; Mon, 16 Feb 2026
 07:22:24 -0800 (PST)
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
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com> <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
 <aZC0WdZKA7ohRuHN@fedora> <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
In-Reply-To: <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Feb 2026 16:22:13 +0100
X-Gm-Features: AaiRm51H2UO3ROxeWnKiTtKGXn1eMQNMSKWDfENsfNxDQ4pC4IpdP9rzSi6wOuU
Message-ID: <CAJfpeguOWLd-WvYMU3oTYPTq_3ZXfdUEX6eD0+M6FNZYc-qw1Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77302-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bsbernd.com,birthelmer.com,ddn.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,birthelmer.de:email]
X-Rspamd-Queue-Id: 652FA145831
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 at 12:43, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sat, 14 Feb 2026 at 18:51, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> > Which part would process those interdependencies?

Another interesting question is which entity is responsible for
undoing a partial success?

E.g. if in a compound mknod succeeds while statx fails, then the
creation needs to be undone.   Since this sort of partial failure
should be rare, my feeling is that this should be done by the kernel
to avoid adding complexity to all layers.

This could be a problem in a distributed fs, where the ephemeral
object might cause side effects.  So in these cases the server needs
to deal with partial failures for maximum correctness.

Thanks,
Miklos

