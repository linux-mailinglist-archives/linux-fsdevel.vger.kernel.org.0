Return-Path: <linux-fsdevel+bounces-75347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGumB52bdGnH7wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 11:14:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A997D320
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477C1301829D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC45280A58;
	Sat, 24 Jan 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYKPH+/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1799235045
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769249673; cv=pass; b=Wvk1XFkI5T9/H3f28wXAmYQjzaM2wfX8Oci8D106jVycytPP5iiTkR3nB38phSrO/02TAXw1ixezjOUq2B9J8vFVRlQxtu2/IPPKUXngbGqXmrd5MJGtcLGw5w+GTFaY79ra2Q1VGI8JYi7+GgnyODxW8mhAwWPIvqcvBmlqlks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769249673; c=relaxed/simple;
	bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnZiNeqwlJgbvIjXl1svdKxs8BybJkWX2m8te5MSZfqd0gX71n1QLhWsSiASNYYI6AWMjh9O7kUBqF9EkLnfAm+J844k8UBsNjTu4F0zuwcialE/kKGCtyfKltR/SOkzfb69ETaQ+TrxQAHHe/L22GEOdTrYHPaaVhbugz5DoXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYKPH+/w; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794279c3b00so29672497b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 02:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769249670; cv=none;
        d=google.com; s=arc-20240605;
        b=hwC2AqaTidJfH4/MM7Z70rq3T2YTuk+4QA0zxVC+taiAiz5b2KR823rX66oHdpg/w6
         n91jzwB9CSRUrNNGSROHSr2JaCvdIZggFF4I8ZqFQ/W/gNMlaUZgYW80qpl140KmgTrp
         3nMLOnRmdpUQhS9fvZrkGySk63tbfCI/Uo5BenyfmT/2/oOtxh/QRtgooSV53LJp0xhy
         FU+iOskTq6zUewDYNnvk+mjIm2FjpQlLtaFumz/jTw7hqU5poknFdGZowOQJTJ99tKwN
         uZGksTUu7xbpqO7sqySM0cFHwyUGSRlijYwu6XH/dcosaECNkY7dhSarCOBFrWNEQHel
         5UGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        fh=e1+C+eljmwsJktH4Iee+7wiMkCYk8MY9ArGzlSPl4kk=;
        b=a6CATRDuTuw6UsjIElR6zx1L61cjhKHx98TvvbELFD8S4tpfgmd6eFtV0vSrg5eHyJ
         6hlYkvz3zrJkEzJXYZORpwDkpcgIY5LyDuO908gRJx2tJcIavLPlyuDz7Zs+JD8kED6u
         WOqmBMzsLW5z2gRu59uY8ImaVOOiR0u22kpwaUE6M2Wm0LhA0F+b+N5B1qzjl9EWRcKN
         4tTHfj7xwrYlYbuj8uiKcbPR0Ly/fdDdpKkzVN48rNVKVR8+ea5aFPXBUFdKe1baKI4i
         kIbMep//gL2WehCk7QzQ3gMznE0i5HPgj41vQyEJwEM8eLir97m2PzDtospLtb4VWpka
         My3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769249670; x=1769854470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=EYKPH+/wt5Eddu1G8cutJCykY64wRsqS81cGNPuweZHYzmMt3HGx5LAEVmTLb/FYeM
         dYrJFBz2dnknohxDH2VbhCx4XTlD5Arfp8NeUV8TiDn5lNE0MB8qslWf0JVJ3jRzCdBZ
         MPU9YE1SUPcVvr/LyhzsfVJFVdYTX/aSWP+HHIE4pLRpn1YmBLaVoF2RTwXvURZyqBGk
         efG2VKqIRU/wLhEqRDjMVIai61v9RuDYTqC7REDNPzCQeeJFjfBWh5QuWn417dtyu1ct
         vC77iCxMpwZcgxhBIKy5uBHQko/VZ//urF+UA9hb1csVkBI2REguxoZ9/M1WP0hwnViB
         3aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769249670; x=1769854470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=KJ5acDn3PzO/3OrVOvkxfSgb2d2q5NV3EkxCDvnuvB238y0HG5FgXVmEopJSC2CARB
         +pVgKlLSE2lmf3Ylcry4Hn1/Y1ley57DpnZ3/PtQAvLJ99Qbh1GAPUEOM99u3hOPMy54
         lfRVYj2ghIzEF+qXOO4dGCCqzRTFzoY35IM/OQjs5VpZvsjqNuzdKo5SX0kmD7piSJ/x
         kyMgo6jlq008jI+3nVfkce32loj6ye0C0GX/2e6dZKZ2C/xphr31m33Jhcs3BklfCdxk
         21O2k50uFGwMO+7I3T7oWpfDsyqMy6Dwx4WYZvY2lzlP4gn8Be8+9Km/RdQgdCZmSdDV
         RsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWny2fNgdhaB1FtfpP793DXoj1RlvQrwIrfKsYfOAcm8kuHqyE8vOY9+HM/YnpTcLZSPNQ9XWioiMn3jEvh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+smAm54Tw/yrLjugVxHfU2KIUGFWeuSgLSUlAfmPLh4CiAEaa
	DE2vL1nXIPiMSFjn/IJDSGhuhaaYooDKr2NgE7DRtuWJoXlcWzt1lBmY24f3cw5iri8cfUhBs4u
	FAmJQEKSew33M5cJQ/a4ogR2ziQ1MbkM=
X-Gm-Gg: AZuq6aJASoaZ+i9tTCiI1EcuWidUrfXPyiGZwF7dNuW9I6Pp8kKBtEJpjY9mRKbWjmm
	wEaXz8zXlkMTUX2ReSYxKYJjalKcr37SEBw996lMlOL4Zrnw7G+gfxq9VSlITS2Gt2hKOKQny+w
	lOdEUmQY3uIHfbugIimiWlagFsuRQ9KEOdFDLTDRSKtSudK25sI7sAu3yrMh6qIUoOCY8wt3VBd
	MQmPQLMzRKh2T1+fPnjAH09bHzq7a6OajOGbQS4zu6Mks/nqmcBTHKRR/IKACNHEX1E/SI=
X-Received: by 2002:a53:ac82:0:b0:649:3970:fa88 with SMTP id
 956f58d0204a3-6495bece06cmr4745338d50.37.1769249670198; Sat, 24 Jan 2026
 02:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com> <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
 <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com> <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
In-Reply-To: <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 24 Jan 2026 13:13:53 +0300
X-Gm-Features: AZwV_QgI2djWv53heJq45UjjcmWS5t43scQ8_DAQPG3PfhZnXr_aF6xvpALbmMM
Message-ID: <CAPnZJGA7jbQAAV09Lr+NKNwRvKmegZFC=LzOZybWG7skF4rpQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jeff Layton <jlayton@kernel.org>, amir73il@gmail.com, 
	cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75347-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[amacapital.net,kernel.org,gmail.com,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,landley.net,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4A997D320
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> The current patchset makes nullfs unconditional. As each mount

Oops, I missed that "fs: use nullfs unconditionally as the real
rootfs" is present in vfs.all.

--=20
Askar Safin

