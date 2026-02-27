Return-Path: <linux-fsdevel+bounces-78746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFk2L8m/oWnPwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:01:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 749031BA75A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC2553025176
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1281441047;
	Fri, 27 Feb 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n6KXh4pA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4207329375
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207859; cv=pass; b=nBflPyxcbx6ACBddidNgNvEcEDKx2GgQzg9zMtCMhqKx3yCrY983q29PfYBL8hQId3f3HTczTWegfmqwmRwlBUoqg1mhgafba5nRPwVp3uGgNRiL+6yhSr2w/lAr12T37397ChMFEKoZRLISMtHwD4LfJ3m+m5beJa0W+2t0nkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207859; c=relaxed/simple;
	bh=L97p80t5IAeZU4ruYO8XApMUoBputr2MD3wE6IYs+NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqKwN04KK7ltwyoQ/PBkj8VXsZTpDs+IiPyPc77UEKCIrvta8ySqZFICyU+P3Wh0r7HKO9niVmpGBAZ5QNEBeuueOU5zuEQSlhDN03mN1oGGaFa57Jwx8BNvK8kunHUZ2lVhnBo+H0DJaZ9U9Jj7Y87G3/VDM14Q3cPsNL1gWxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=n6KXh4pA; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a297c14bso20496031cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207853; cv=none;
        d=google.com; s=arc-20240605;
        b=EeEFgXtYvcSKSWJC6CStny0/waNzvUsZsmxijOq6ZuE5miwlCREVZ4XE0DmSMDtWHJ
         kg1/II8tkMsDX4Trh9oSkHy699HkhQ31SWTElXHfxazHn7VoQTHYjjLl2SXNyzomMsoQ
         jdCOYRiW/I3l/bYx7Acitds412Ae80yxV4p0hJAgIC5BNQoSaRi8sMx92cm4oYjNDmii
         hgZZIF88Dd1snZBhxCXm8ZWF3Dcp0NTOe8TSW0B2L4KR+H9jcD9NCm/Kq+g5d2yL2J2P
         9YtF1PJILcEJfo8x113BXW7lYo0vwWzEFrpMP0OENt5kKY+Jbvv4iI9oRdv6srPLdCi3
         FMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L97p80t5IAeZU4ruYO8XApMUoBputr2MD3wE6IYs+NQ=;
        fh=XHz61Q48J1V2+kkGOtO9l9HJTBRPMok+c82vmjgyfUw=;
        b=U1BeF7m4N2h/SicoJSITWcMeuCw7BGJx/DWKGJa+CGwMXp8AnP6thwBQWwuFBINMz8
         iQ5p4W4f1ySA1nWZSQWCFldsHtae6R7douCXam65gp1F+kuhHQtBl7KicuddfspD8qU5
         NQ2ErY7TgW3Z6L2FSdGPWLCkML0988nkfy41gGl841vFS/7PoWVBBRtigfBOl3j2WgBM
         LTLPWyQBFFDFqd10YXJfTz+tojwpIpPCiTdUxMeO3/qNX4AsVFtwI+V02b/MWsLVm42a
         0Zzt9ixnb0M/ZQ+u6u7r+RDuAbyiFczprOrArJBLI33wfjrLgsqZ/blN4GSWrJJ36sWT
         BOqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772207853; x=1772812653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L97p80t5IAeZU4ruYO8XApMUoBputr2MD3wE6IYs+NQ=;
        b=n6KXh4pAFoHui2WfvSQeveGRgkYHcPdC+sKIBD/epXFnKkHcsLsT8J+Wo3WSputUDy
         Pz90foJZxN6PukAp3AHzqhav3DsLfCyV+wV/UGs+snYYqvHZ8CJ3zftyd0QO+u4CUax9
         kuI8rZeRhf5vSaPjNHD+RjHVYvzYTDn9iL8us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207853; x=1772812653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L97p80t5IAeZU4ruYO8XApMUoBputr2MD3wE6IYs+NQ=;
        b=JhAQHUjeZQlMJRlUjmWhyt9gFJBBREUex2u1g66XD4cEpqQh5kWH8hRCdAnaNMoYKR
         wk4qekrdsMCgdGaPY7M8FRBa1638ofY6wVwXl+57P4Xo4KWLmb5qnkJvQr355GDfDQPQ
         84wH0hzz4COfpihEfsWeGXwJKKaYjjGA8lOPL7KYOj954drpJ9rOH3OaEq3srhiBqz7A
         51q6XFUWch+4xaIjuX5FqpOM8bWvZflcQ9VjVI6HNmy62ftZBP2EGv8uVtgcJ46BDSq8
         7Wc3j+bY5MMhbU2AM1e9OjMSU8/yUHvZYl7ibttJhigBGr3anTXt4LqQvM1N07fCfj3P
         wCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUaOz3xhmM/PNRXhKRZnzgJW9XCx4d83SFmuaJtlXJ7vOh0XujeyV7h148KpW0MOlM3lfA9Cn27mwtUlIrF@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvBSqrL+3KIlC48zu6e+P0mP7i9RZFF4MuzIfQ0PMW+L30oNb
	kz1Ha1mK7OPM5z0Aad7rMJrdIaORA5AweA3XluY0YX8Q+Q4pEFzK4kgVzvMAyL87cR3GMtdOonm
	XHyeW+fOlatbTO/KZctQsXhFF7LeUgDRbPoKmnrgM7eeXrM86/+CP
X-Gm-Gg: ATEYQzyAaFKupGudrH7/tlxDlteGrj3hZVcLzCHGAdfsl4NM+YJZCY2CqEfziBMI4bg
	+lpLDpg8JV8izJEN55csiW+fbf/MIbxjD5ZOHjVF/4NnhA9wa5Tdu7je/0l4reBGHi1BeVGRNl8
	tCJHVMYWdCVxp7eSl00MvyGgQdq310hqzkzsi61UgVD+T5QgztfkqmH1Nv/tkVeezhnaZv40CUz
	7wSvT9yE4/LqKLQo0rxXDBBmYL7xVi7TUXAtyVOInVuPqWXJzwtvNhWL3qSHfRFsPezRlqnmTAn
	gKf81g==
X-Received: by 2002:ac8:5991:0:b0:501:44a7:ad50 with SMTP id
 d75a77b69052e-507528d2800mr37740021cf.26.1772207853510; Fri, 27 Feb 2026
 07:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-5-luis@igalia.com>
In-Reply-To: <20260225112439.27276-5-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:57:22 +0100
X-Gm-Features: AaiRm53RDxglcgv3PmK_pxRbsYWqOZijpY0yOd_TwHr7RrEFJGtfLTVr4DTetXI
Message-ID: <CAJfpegsm+D+Bkhgdyec=DXjk2pfaTNp+cok3oktiB3-7KJ_ZKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/8] fuse: drop unnecessary argument from fuse_lookup_init()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78746-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[szeredi.hu:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[luis.igalia.com:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 749031BA75A
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 12:25, Luis Henriques <luis@igalia.com> wrote:
>
> Remove the fuse_conn argument from function fuse_lookup_init() as it isn't
> used since commit 21f621741a77 ("fuse: fix LOOKUP vs INIT compat handling").
>
> Signed-off-by: Luis Henriques <luis@igalia.com>

Applied, thanks.

Miklos

