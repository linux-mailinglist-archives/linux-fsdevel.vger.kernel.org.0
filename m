Return-Path: <linux-fsdevel+bounces-78748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HjzMo7CoWkVwQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:13:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C11BA9DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21604304D27F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50B21772A;
	Fri, 27 Feb 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LfmMR7yW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183083EDAB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208356; cv=pass; b=JmfhoN0l4XIghVUIN29fF1huuGIV03tYemCpc8MS8VHD4HRQHxo6KhqdMfIXipJwBgVQzBqdBfNyLWIGb7E5oCk0CTSdljHWcaRnfP7Wudxd2bYywQbARzyes/W7Lhb7NaOxErgBS3hRKfIublw8UmLQUO12DkHmR+2hjKqPvG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208356; c=relaxed/simple;
	bh=XWRFmApZo3EeyDOBlJmpjRgegzMqTxAsMi4wp2Eo1BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvFF6/v4uNiUhGLa2CuJ9BRFaCA7qfxE9+s6c+vII+n5RsX1/8ccsWdv96bZswDC4vrWOK1rXVNDBVOFz4mZ6JsEqQ/jVIK2Vt3EVabE/YjrjsybUsSnKsX+A8BF2YR7HBO6ei9pw6L9JqKQsRP5kg3y3vpJ/AUYZoRhFARZH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LfmMR7yW; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a3400f30so19245941cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208354; cv=none;
        d=google.com; s=arc-20240605;
        b=cZgKDlg6MyoIjRzqsyNy4aIjpszCu0gURQxFC5AG6sxqV4Zcxt1eDMmMoMRFprPyxP
         nYpCATrqxGFBiE87qAnmhnUqy6dfhAkZlEle7BGkHLFc+uYo6anE3eAs5XXm+mMFakn8
         2bRuNQWsZQlxuronzA4cIQoUJndP+OfAV7zIvznQ2eCzCzymk5eBmSWPF8KH+x3/DmdL
         1a2rxsK7q7GdTIuY1CoiYTUPvv+oiHnUvhfRy3WRgUpABDjQ8T3Six1RvXV6MnzCCFZP
         /xOpor0HajQeeFH93z/QEu3ztRNHYUpeUfOwF5bskGriXFiDgPgXhLkOG9VcwwAFhLnK
         h9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        fh=s6PS/gP7UxAggMjIBuvaBtki/NXY+NxcyHNNye7jl0g=;
        b=FdWiNKoysbSXNFDceWwmSZz/tUrBAD1Nwiq0zPRkRo6obARTkZi7C9xDkNC4VCgmpM
         eGBgHbdw8pQW6laaYUW+2JFIJkIzenMJAShoSC2As0OxPZ1uqKqWNX/FEybpRPWaka0k
         WEh/oXvROtld8Gdpe+9/PPE702dDtuU2Ec1XOwiMbpAWw/w8GjTC/sBq5NI8AGKnieGT
         hSu0VCDIW3KVDY2ltDEUrMn6y0n0kkeLOhUCQw4P9lNAGmET7jIEK7gGpRHMMPEBZJvA
         fyYSNZDllFnGQtbBiy6brUAwL/PEf6CNqIBl/wN0JJx07fh8LRea8xckKTxRjjvwEup3
         yYLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772208354; x=1772813154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=LfmMR7yWSQDmoRuq8VMySSMb8MeEheV9tG0G8OqPmk/6sqF0avT6fPmX07OP7d6QPp
         R8LeZJN6zJ+aybdL6KzvIV4eRn/fXKAorfRYAC9Hg46GD7soHmbbqrWu9iCrPrF64Jjf
         /83il98BCG8P0YvthzYNAGxMDWz2f7wI/2dgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208354; x=1772813154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=r+ClaO6mNMX81QrkybvQ407JoERkEKdnMe/vVHDsJ1rfikttGthiRSRLNiHxXBqFMj
         0kKRXlty7PPpECVPiKslPZGwTGxTqj2dl6BRPohHp2nf2452CQR5Z/OuUfe/cCBZ4HIL
         vC5amO1/HDD5IjwLBn9VHobtfSyB613lZ8zfNpnbmWRXtow0w5jqVVT/QC8IgGw0gkBN
         tj7gIueS/IP9BeTPNNBYstfoc5D9fuw+CM0lQEWErpA+suGKzv/VFTuQZ10zCsFMCjtt
         4J3vKzx4GSB9Dss4EhlbIUP8kw5HrtV3RmU5a0CkWAY76oSj5uXSMyiruR9D8Bu0f5FN
         sGxA==
X-Forwarded-Encrypted: i=1; AJvYcCU0rWNyEBMaOAA7JazhXtWr4oVkLQwV3zTJs6bRnY5h5ywKhgs+EMiQP6TOy/NUCjwTvupgX6qRxvVhHR0Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+F0TQTFXqvua56DQoMs/EWBVJULOgld+htpl0qQR3DZO8O8f
	tHfgZHMasNfxJVyAevm5hj+dBr2O6rnGfU9a1/Iq4Phn1gaj4q8ooxnC49uDUC7LNX3x1zHKWzB
	EbnaIkpWV5sGxZTlXFWfWnWPBYmC4CpBFewtsqlMMHQ==
X-Gm-Gg: ATEYQzz0ow/EV/Gn6biFbTcKLki0bJZO6cs12q5ZJ7xxKm5ZhP2kDOuFestvHiHSZpy
	gcelG0VViD0JnD/Dxh+7MAuHXw+CTCo97L1QvgbdOX39xZdIubefu7uSokO0RoLQ1Wqt2SR2ezC
	/xn5oIVAP5TYPIjBUqpZyFpc6Pr6/uaw68zhw3GzWbaliCHfvNF+/iWaSH8a85+t0Ni5h0Qx8EK
	LjFMbJET+wo65Pz0Z5wd80blQUd7N23q7G6QPDS0gMP1xeiOSSRxtOj72bRGecItdX/u+OWAEM2
	MqmoGw==
X-Received: by 2002:a05:622a:15c6:b0:506:a574:a98 with SMTP id
 d75a77b69052e-5075240cb43mr43969551cf.25.1772208352680; Fri, 27 Feb 2026
 08:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 17:05:41 +0100
X-Gm-Features: AaiRm522nNR8quw6-QPApM41f6VxVhfe4lhaNvG1qaOhqP6WFi_K60TlVjnXPqk
Message-ID: <CAJfpegubENC3LxtG8MbO4OxUgD_Pd1GR9pw6Xcob_JiG+2cOFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78748-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D37C11BA9DC
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 at 00:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

