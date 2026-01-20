Return-Path: <linux-fsdevel+bounces-74721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMq9F+j6b2mUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:00:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FBC4CA5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1FAFA81F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779093A4F5C;
	Tue, 20 Jan 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQBsm7jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87A3A4ADB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939616; cv=pass; b=WANhHgj76rHM3VrT0/fIgKNM4iMMscAGWVYR/iULxBfdXAjaqEaXgH4ovgvnpDXS5lMetG1oBvQOBuXBxmzS1t1gQGHtM72vtBbdXm+Wxc+TEnhgqUnO4kZbSYM3VRVIucFlwVINMMluHIGTK65t5P7EZphkEPcWrrqPh57p0eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939616; c=relaxed/simple;
	bh=G9aihNwrvNA4dQ40bsH+AYxLUdUqqpmQJ1SLHyqHFMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnmPYOTcr/n1rMpjk8e39xJhoKbBuuSTck9/GbLL2P6BnsDVrY5Sezm/i9pUksW7KJzUnE89JCoVv5BNU4Lxo7GytT10FlEPi46bvcSz+NEfPvpNZKhgphvLfOyCFF8kGtqJpJVjzCMkXDae/xe7qS1vUcj79FNgiz1iqWjXOQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQBsm7jm; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5029901389dso36954781cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768939614; cv=none;
        d=google.com; s=arc-20240605;
        b=KGr2x857ynnnG1xm8KbqnTUjVd+HZH8aWZpPt+l+DTBragtsnaOM2HuUN61pZ7j9FR
         LSIYB9C68HmSemyqDXUYRR3O5qAs+HwH8WVoNnmtrLS1cKEexeH4ROGbMdy7sDD7aRH5
         HFk/Z5+luOlJsiNjfwUnVkf3DZsekD1slxIGNmcJEgjVXHtz6/iXUE93XhjnCVQR3OXH
         7z6BXQCi9sYHFrCcNsfQOuq8+azK8Vt1CC/mvslu1qd3rb2pgleLUSxOJ4tbC730INcK
         PNnwC7k5B7HmhJRqKuKlMb5D0I1juwzFVDe3N8ACEpCv3lcAaQoGqkFIzJzUxlhhMx7D
         ho7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIis6rixrLS1/WZJcCtAdCubRHSy9aU1Q9xCJDIWF74=;
        fh=DDGDXVDWoHtJ9up4TTpEcBFg9FnbVHZn4FOQ2wxnV58=;
        b=YQ8dPgSllBhFnjAR6aaAZ8awkwbc2xtMckAHTDwM7jRtSOibMz96p1GNYlnLT0fPN+
         yBFL89iiEbhHTAdUBFIx6UxyExhoSEXavStZGQo1DyeJT/GSdo0wJBRaGpe5e/W3eTs9
         CTkfEzuHJ3fe5scynGecQyR/Q4d9PQQAwbI+K+UtCq7L8Xfb/H3uPLUk73EdWq4yw+/7
         NALs7/Av6xeDxDpl92Re4OstR32PK4qEppQ46U8t6MBDTebvLaGpycycVjDSjSPcrfHv
         JzQcM198aQRnRii+KHFf7gY/DwSjjfZIqtWljYmlR7+0KpQbv7JO1S6TFX0Y5CyXMTDG
         7meA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939614; x=1769544414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIis6rixrLS1/WZJcCtAdCubRHSy9aU1Q9xCJDIWF74=;
        b=lQBsm7jml4Eno67kZG//joYi95Jd1xjtHGECoQhAZ+EuDN/1nPfHi4+JYN93Cs8xL8
         MuCNspKUWKBUtIvc/dNpy882SLsr3q/rg4GTAZyFehFerL6kZhZUuAAcX/upcq7hxMj7
         SxdAXJgV3/sXtHK4ZPvf8Ma2bfB5kHUcdN17tmRcsCjM/9GVnwckh7AK/ibCe2HCCJQj
         +C5mX1N+yyCTKN9bOzFYvy8gCPJgsyzvwUJ1EKqMZDRMpEFwkLAb/htPQzk/eHTPN7Gu
         QoJ/VTGfYrywexfR4JsDs3hMqkqBd0wt6VfgyWGDOaX0llD6NrEibpb+jH5Sfn3iC44Y
         oFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939614; x=1769544414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gIis6rixrLS1/WZJcCtAdCubRHSy9aU1Q9xCJDIWF74=;
        b=t8sOuRMTeoAAdRc1+nd2WJlYncWH2wtma5bU87ggUqUEdb9GL7QudLptam9gxq27kF
         5zd4axqeV7aQ3BgvO9lVyIltzfoPQ80fkq3dd3qKSeI3r7mq4b1Rggcl9or41tEHbZBG
         ebsFUdKeqoT56hvcIlAQ6qe5sLn1HGWATxG/iIHOmB30g96bqsGv5TLhDAUN3XlW0/D7
         o0rWy9qfM1qyyY4INpfk6uoAfuTTeReXDdUpu3DAafFcWahMq28Zixb6apCt/KpCQJB+
         LZsWMwVS2LZBd6d/xiN4NJreAUbDIPSIKsB2N4NPWdbO796OodoQA+qWA5yPtKBwYP5b
         s+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5vAWRgLl5bAaRmksqodV3CZ7Sj4IY6m+UnA8jDUN1q24rXnhT8Go2hZf/siSizR7QBZyhqa+qiiSvBumE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw96nvQLGWl+Q0yH06Xr+X7Ne5QMo1OBgqumutCewuaDZV6s/h
	WGJbcvABVldbNUwiQ+O2miFMCHARHPvTS3WitXpk9zDjCY1Ssqc0sS6K5XUcGhq6u1bVxAPQp1d
	4am99BmfJlCZgcyXHwp/jhCXgv4XUKqA=
X-Gm-Gg: AY/fxX553DR3YW0RPSU740UcNYd4qhKe4aJi7/pNMTQUDbCeobVM6Np59EnTxgYQhiC
	Jg868CicoYqpMJdmCGw9rcJry084jYITynKRq2PNf/+hrPWxMkUW7D3GJ9IOKRAOJYQl965XvlA
	Fgc42ASAe7LCpHDKX5oNy3YDfTD2iv854zf/yFkoNQvaBWYd2kmb0yO5/FAISdx9TwjmffSeWkp
	WdmHJQGjDsQk2IKaoRCLGsQzMwCZB1qQjspwvTKlYz5bneKZX8Y21/wbxw8GjM6FFPHDA==
X-Received: by 2002:a05:622a:1ba3:b0:501:452c:b6ae with SMTP id
 d75a77b69052e-502d857fe96mr38757521cf.57.1768939614068; Tue, 20 Jan 2026
 12:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com> <aWs-4Dzih8bYVeLI@fedora>
In-Reply-To: <aWs-4Dzih8bYVeLI@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 12:06:43 -0800
X-Gm-Features: AZwV_QiHnShwufEOKcoFWyn3ICFQB__mVrESBKa4-7V9EGcn-Ed464cREWAe8b0
Message-ID: <CAJnrk1b97y+yAN2vzc2w5sESvmdpNQF-gMBSCqoW6LT62K3kcA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] fuse: clean up offset and page count calculations
To: Horst Birthelmer <horst@birthelmer.de>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74721-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D1FBC4CA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 11:51=E2=80=AFPM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Fri, Jan 16, 2026 at 03:56:03PM -0800, Joanne Koong wrote:
> > This patchset aims to improve code clarity by using standard kernel hel=
per
> > macros for common calculations:
> >  * DIV_ROUND_UP() for page count calculations
> >  * offset_in_folio() for large folio offset calculations
> >  * offset_in_page() for page offset calculations
> >
> > These helpers improve readability and consistency with patterns used
> > elsewhere in the kernel. No functional changes intended.
> >
> > This patchset is on top of Jingbo's patch in [1].
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jeffle=
xu@linux.alibaba.com/
> >
> > Joanne Koong (3):
> >   fuse: use DIV_ROUND_UP() for page count calculations
> >   fuse: use offset_in_folio() for large folio offset calculations
> >   fuse: use offset_in_page() for page offset calculations
> >
> >  fs/fuse/dev.c     | 14 +++++++-------
> >  fs/fuse/file.c    |  2 +-
> >  fs/fuse/readdir.c |  8 ++++----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > --
> > 2.47.3
> >
>
> Looks good to me.
>
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>

Thanks for taking the time to look at this, Horst!

