Return-Path: <linux-fsdevel+bounces-78745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCoPM8G9oWmswAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:52:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C10F1BA540
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B4A305A20C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8A441039;
	Fri, 27 Feb 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q1PYOprM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF443CECD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207216; cv=pass; b=PL+7KUCF8ABH3ASvsRLKTEZ4DXK4ieVFn9jSmqfGH3tdIS/CX23qhNTqCkyNye6VhhHCjgsUqTnv5kOEbHxbz/gSU3sOhyQKQKlpRhsc+JomsS0tzF/QQGsPCosyGrLofZl8siqOdctCitIGOWyctyKfqbBQ2NaCNNaGooBEKt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207216; c=relaxed/simple;
	bh=6+5DSULyz792EK+5+nj7jw2ScEHKkf8SkkIBs6e5vP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOp0cKjDbDFIJhQEeyEsvY2Uq4S1ss1V2NbMVRsoR+TP6EGgWWDrLMOA6zhKh1ko3OUJPwdKLFt3bv8jYaJwlqIQZz4mZU4QORdGlwaEQ3NUlEFwrAKiVV+YiSjV15Q7bf65kXjhNFNv5ooD5kfhc1TWn/ej8WerYRqVrmxSrIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q1PYOprM; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-507373bffd9so19718201cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207214; cv=none;
        d=google.com; s=arc-20240605;
        b=AlJzwJTRfH6Ntx7UWc0TevfX5qk7cbb4W4tT18GHwEDKL5zg2LG1sEazg+dk6G+sw4
         ROo/MDpT5STjyVGnmNqzg7+PARUUyJ28TSPNVTfrLwPRb7Tm5CaQkAD7ik0wtMsH76hG
         jePHULWvNNFvDpVmR228QN8u2Rh868Tpre2jHosKF1QinMmvxY/vo9S1FhwScAIB7+VS
         hheiwJYxN9G13HNH7f6lL2JjB9K24pBrBlIXBFEZiF4KgDLy3hZMMA4IPo+rfO/Cb//l
         YH/H3NTsBbypa/GAWaaPzGHsidyaFDKWvhP7XJdeFd3r9rEWlJAB8aWgnYmSRZqaJs7e
         O8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UHaZ3Ypl4JEUTaRmpXsD3YMs2ThijRhzchLXVoSizRQ=;
        fh=mZK0BlchrVS/lSBSIpqibslsw6zP4rgF5PSPrADUfuk=;
        b=eQYk87j1I/ALtRXjNsAPBDNPZmV7OrnDrtSwKK6KenhuGCa4EJS7eim0iFrvao/38u
         xFQvsaA+1C1vCaiorSRIVGKm+J1mO3e7bo9tU5B/hDK9xitkzEJmJ1AwrdhEw4e2QN/J
         OQFmqHLodBme3ypj0uV7R5szFVcnqvhmW8hmqsTTpy5IRk2tSzUmeXno411tnxcg443/
         At03dThMOMvAC2CBdhGJCJidGOdZNENq8E0u+Q2+Oef787B7WV67b/Au/UemKwUv5sGF
         Vq2UdNXiOFpAPKRM/Mai2sutO0YwqpG6Qaa68INyMzRHiY0cy94IkJsjl1hBavrP6DxH
         vE6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772207214; x=1772812014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHaZ3Ypl4JEUTaRmpXsD3YMs2ThijRhzchLXVoSizRQ=;
        b=Q1PYOprMu0VfrbK3BiV/OCP1YLqN5ndalEApdgTHG31ajrIdWEHnbmxTN+t7KVhtCv
         9/i96/EKg52X9vqfYmcHIvBkWB4CVrkxkZ6j/pzf8PrQ1TOcSj35r1YMypuFsGGWv8lv
         BXQ6Ll/wzpRA6M9sJw2DornAMNbJq2vPgurv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207214; x=1772812014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHaZ3Ypl4JEUTaRmpXsD3YMs2ThijRhzchLXVoSizRQ=;
        b=vjrO0TgaQpEF1fNy/S1lTIoUpij8CBFnUZZwxOeA/UkIZFw0YxOZoig1PlUPbw3Kco
         b0z02k4ux5MurIKQ20e1GgkvGz0diOwPSgKNTHLELPEgsoCuxNTM9YELKksWY6qWSNYH
         jy4Mb/iZKIvWu4ZL6bJWWawoEm8uwWOZng4XPx/YR9xzBL/wX2GIpcLsTC5eJ44OLiqt
         8cE/RajyjqnnrQQJ/f1A6PdzR0IiHd6tCTa9DNvNlWzfORbXHPGDDp2jKL8lDQDjz7E7
         STXETJJXJkAMT+vYn7jnB+7camU4OJx0UrX2QggnG2zsQXKfVmelxJvv1e4+PiyFrMtC
         J5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28Bat8u9tssi9bDWdUVkaEap1v+WqYz8AXYWFEDLdz7/ccmTNjV0NgUeKR2sNjFuUd9pBChDLZSjDmSgW@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4zcIqdcifsIf6Ka1Ls+ZxjM7a3chY3VsdsMmNtvGq674OySm
	SLSmhLQ82omStJIG8wcritnGrwQqbZwDfoeaOo8V/bExJnEGrDuDBl/53n49L/FWiqAS/sOpmj+
	P9JxKxxHNpfA2nlF1WchWqQ8obLbWem4SDFwxo84m1w==
X-Gm-Gg: ATEYQzxNX0Cllsk38RmcLNOCjtfzagVxdUCyHUl77KGGKBw+vPCUao8zDHmvgc2PT03
	lECTQL4bhIammaOgSYU7grh0JXaHr7UiXxB8neRBdpiw3A4TBLGxqpl5KC4kWXPiQwgJD33U4yX
	MR91K6RUteldi5/uH5KvfGrhS9GDPId/eWTDV/lgn47Cuu06pFaYXsRI6XirLRzw5P5ua4U0i02
	6FEYPNVAkGfrY0Fu6rUWFm6LdJ/8ThIX2sg4x8nrcvqj7Nup8rXDw8RHUQpOU2MGB+nhZycuoEw
	xWLBYA==
X-Received: by 2002:a05:622a:1915:b0:4ff:b1eb:2d03 with SMTP id
 d75a77b69052e-50752a0bf21mr35764871cf.72.1772207214207; Fri, 27 Feb 2026
 07:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-2-luis@igalia.com>
In-Reply-To: <20260225112439.27276-2-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:46:43 +0100
X-Gm-Features: AaiRm50co4zOphVthtYp8J16l9GFGAlkcQluhDFOUWzhxxeLnZ6cKbv3gvi9VJg
Message-ID: <CAJfpeguuLfaqG_JBapk9weWbkht=uuvzMfAPhXNmynxb4S6g2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/8] fuse: simplify fuse_lookup_name() interface
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
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
	TAGGED_FROM(0.00)[bounces-78745-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 4C10F1BA540
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 12:25, Luis Henriques <luis@igalia.com> wrote:

> @@ -570,30 +571,34 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
>         attr_version = fuse_get_attr_version(fm->fc);
>         evict_ctr = fuse_get_evict_ctr(fm->fc);
>
> -       fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
> +       fuse_lookup_init(fm->fc, &args, nodeid, name, &outarg);
>         err = fuse_simple_request(fm, &args);
>         /* Zero nodeid is same as -ENOENT, but with valid timeout */
> -       if (err || !outarg->nodeid)
> +       if (err || !outarg.nodeid)
>                 goto out_put_forget;

And now the timeout is skipped for the !outarg.nodeid  case...

Thanks,
Miklos

