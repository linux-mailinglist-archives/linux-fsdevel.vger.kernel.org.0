Return-Path: <linux-fsdevel+bounces-76378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADaFEhxhhGng2gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:21:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1EF08F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A34F30159DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E538E5F7;
	Thu,  5 Feb 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trivon.pl header.i=@trivon.pl header.b="eCPV2OQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.trivon.pl (mail.trivon.pl [162.19.75.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6136F42F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.75.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282116; cv=none; b=DMzZ60/MO5TIMPn+KB6CViflNxw1XdZ+FR+STmhC46l1SVMbkPvtPiabBgqlbOG9WWjfkF/M6iux1+W7Ninj4NKm4dHgFrvaxhqpwGNzZ5T/86rD2wxBG2zIAH/DrD2w18sRtpDqlrnoP9CtxV3nl+8ia+HgVmwPEKwDzFOETKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282116; c=relaxed/simple;
	bh=q6E6cDv1uM5zkCneIiADerBHy5PHXWo3+b/ZdQb9LnY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=nGmQfuPP9lUlb/Ix5BZf6NuoKS78sFeagABGKZAvpuu5ifuM6uFXSEuzvbLYgeqvRsqua6DY4RP/ilqpvR3hUePN26McKNXwXWe9dEv2uwFVbwSZlnov68KfU3tyTp//cb5/CoNC3aedn8vOR4wmc86iF6nifz2Xh3IZ0xmfJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trivon.pl; spf=pass smtp.mailfrom=trivon.pl; dkim=pass (2048-bit key) header.d=trivon.pl header.i=@trivon.pl header.b=eCPV2OQ0; arc=none smtp.client-ip=162.19.75.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trivon.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trivon.pl
Received: by mail.trivon.pl (Postfix, from userid 1002)
	id 5A4004C413; Thu,  5 Feb 2026 10:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trivon.pl; s=mail;
	t=1770282079; bh=q6E6cDv1uM5zkCneIiADerBHy5PHXWo3+b/ZdQb9LnY=;
	h=Date:From:To:Subject:From;
	b=eCPV2OQ0gcDKMQKdaos1bshN+iPhphmPcvuoFJN9g/fL2hYCLcFqJuX8K0XUABjyK
	 eOC7LkN1wGGDivPyVURtyiHtgmsgEgNNG/BIuMkmZyEqm/JR3bQoGHh3rNzmpLmgTk
	 /k+NwF8nvDOPEhQMFZjG+UqOv8PyPY5yuTcfmnp8ODv9sdptTTBjioUVqhlPH86wFB
	 sgTo8se/cgNBk9glb2FqMmLC8flNRiOyTRmVBKfamo7/H61d036/IkZEb5f1dYrZWi
	 qRyXlDIq9CG1meKJ8h/D5laq/mNa8nvwEZAIAg+teHWJ2BJD7m6Rbl1Hgi3NR578cx
	 w22p/w3pql/oA==
Received: by mail.trivon.pl for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:00:08 GMT
Message-ID: <20260205084500-0.1.dk.36amr.0.qledchdu14@trivon.pl>
Date: Thu,  5 Feb 2026 09:00:08 GMT
From: "Damian Sumera" <damian.sumera@trivon.pl>
To: <linux-fsdevel@vger.kernel.org>
Subject: Restrukturyzacja
X-Mailer: mail.trivon.pl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [11.85 / 15.00];
	FUZZY_DENIED(12.00)[1:3b6a963e3d:1.00:bin];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DMARC_POLICY_ALLOW(0.00)[trivon.pl,reject];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76378-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[trivon.pl:s=mail];
	DKIM_TRACE(0.00)[trivon.pl:+];
	RCPT_COUNT_ONE(0.00)[1];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damian.sumera@trivon.pl,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E4A1EF08F5
X-Rspamd-Action: add header
X-Spam: Yes

Szanowni Pa=C5=84stwo,

jestem radc=C4=85 prawnym i prowadz=C4=99 kancelari=C4=99, kt=C3=B3ra spe=
cjalizuje si=C4=99 we wspieraniu przedsi=C4=99biorc=C3=B3w.

Jako lokalny ekspert oferuj=C4=99 efektywne dzia=C5=82ania umo=C5=BCliwia=
j=C4=85ce wstrzymanie post=C4=99powa=C5=84 egzekucyjnych, uporz=C4=85dkow=
anie zad=C5=82u=C5=BCenia, ochron=C4=99 maj=C4=85tku przedsi=C4=99biorstw=
a oraz popraw=C4=99 jego sytuacji finansowej.

Czy mog=C4=99 zaprezentowa=C4=87 mo=C5=BCliwo=C5=9Bci wsp=C3=B3=C5=82prac=
y?


Pozdrawiam
Damian Sumera

