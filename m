Return-Path: <linux-fsdevel+bounces-77844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7FoAJkY4mWkcRwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 05:44:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3C16C1DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 05:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB2630421DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 04:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476762BDC04;
	Sat, 21 Feb 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw+KnoFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0E450FE
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649085; cv=pass; b=tMOsdujdek6o59nm5RF1i9Be2MK8sSWl7RN/iI0yL881jH/QXv7B0KbcWtF28iL+kLcDzxrR6Nuk7+dNA1Yd8LtMBQ/d/UbnKF7EJPx3XfmZ7NXcwGR1FjZ2U07IJAD7FCuKvP/WTVJ9tVL/21vElui8xb2O8ubczuh5rvj2TE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649085; c=relaxed/simple;
	bh=qM/i6jWvjwRHfOwUD6tZLPQ0ErPTKUqiJw7JfZwp5y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxWsW4gATnkLfYO1TsfdgXB7iDNP3d2lE3LENDRC9pxOm19qzWxYcteX87763LjWQFdlvoQHtLIkWre59P5ehBAF3wfFSVRa0fgwo8pb2F68rWvPKbuIoZKNxQ+zbqiapJyUotr9xr9fYOl7osqqEN5m85iFG25bKisRqqu07Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw+KnoFe; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649b5f5570fso3354941d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 20:44:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771649084; cv=none;
        d=google.com; s=arc-20240605;
        b=CM7Ho2bEWhL28wJFlfeFSMzSmhnJpAKZgXypn4cOBp6TxgURSTHpUdSjv+XlH2inTZ
         4Omj6Rr+lOABr96GgNxIJn5XObkQrS0n6a2JrQFdbjPal7aPLqZeA6kLpX8MaM5oy2kX
         051EDEvHVbWKkMJWtOamLncMOsE4ZYyoFe+Tb1ssQA2csbBXsWqutmOLwyATKJizLo06
         pvFSBa5etPa4kZERs8opcPN/DC8KVyiw4ipWFwWGLTsM+atJ8hzGjB+ULAhuiCqch6Y6
         U90faJ0VzNFwUl9C/jr54nu1SjYVajYraeSXWIZWfJzVESFe+0eeTlAXqJmxsrJJ2WI4
         NbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dG9NDTQiVvssw8CdFikENAcrItQEkS5E74QLjjrTea8=;
        fh=nZlYZRTRPNI62ms/r3jYRilbphWi1WJt1WZ5NHyGYd0=;
        b=fsdnWfOxG3kBtdL78P0v8abg2e83YFyVed5LaIar6JYkc79R65NMRVZSBxv29BC/Ys
         PXvno9U8DEy9D3Sux83aV2L9B5jnv8aQDyPfWw0YYYnqaD9IIaglH7ViOO9HeBNDVNzh
         hqES4piaeO/al4yQ+hZ7ZftvlwY4BOG2B91zmurkGY6e+IFur/0fP2X8W/aSqDDOtuaL
         O0hwI2b2bMFLe94V2NHenbTW6w1D8BMIRPm9T4NnWot2UicYGNerqL1vHlkVA+/UJhwf
         SU3MMiyFl9wiKp+Yyq3bttFXCjg5B3XE1Vr/eRAXIhW1nkh4XjzyGdPeNPQAB4Pixohs
         o9nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771649084; x=1772253884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG9NDTQiVvssw8CdFikENAcrItQEkS5E74QLjjrTea8=;
        b=jw+KnoFesc1ZqYSUj+BjH2iQyR3MIsWYkwvT9ozKayzcP0Shiku+7BnfQB8RmD/bSd
         6G8yioXBtokFF/8UplzeLjRdc5WiZd23kUM6rVhdLHVgjwi8U22WuA/OJGGk/Bt4spaV
         uGR/0q5SMoKbLtfS5CXQY1QuwPR7MtlmN+CQgL2gOq0zJdPEE4pfeSQbuUpnA9FPfRU+
         Oo5LIT1Nh/FxVXcX2b6Luyi6bGcaMsWsqAAqmvGcnbGEvSgaRWF2nIaiMFxerxtgSabY
         f9yQ7Bbd2NltaFAQoO8FSnyKhXbRn6ygaK3IEbSdECOkzCoJdD3dws0XRctsbL3VgHqX
         Zrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771649084; x=1772253884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dG9NDTQiVvssw8CdFikENAcrItQEkS5E74QLjjrTea8=;
        b=PY7KJuDCUyeCgMUYW6jrHbeAymuRCjF7eRnFavNwxljHVgqDMi4ybrkIXOrDTbFtZq
         oUCb+MMmW3LclPORYwi6LhxCXBWpNNR6eF3CpDtSCVVIsElUNFbgxW+qKaT4PYUsu5iY
         idJABCDYkmLDqCPhl/hH8oYQUprmnDzo++bX9hKq2wOjb95ydfm6E1d3jAfWRZzHInNK
         kyNRJZrXNwtchI5QVAud5uukCMJrN7h7Ee3CCyzgmXS/xLZMoIlq2Cl0xHJsiVvS3bIa
         yd5zLdEPO2677C5/qu36KITx+5amVbngsfe2UEaIVZ5fwZozhRdLK03ge9/38Sg3TSx5
         w/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRw445Bt1Me1AKOqazcyG0URp6nY/ARhtDNJukmkIXOx+EC0RLnXtMgqTr4wMiMDxe0ZWUITpFgQunfBpL@vger.kernel.org
X-Gm-Message-State: AOJu0YyaT5EkYyu5p76+H1jrdZ7zj0uZ1TtDu6DFQe42HvuV5gHvvKzT
	3p5tPoIGKESVn0RvgEDVvftm0bCEe7N278J+Z1hr3qx1nJooXQC9PQbrHrJCUW/jWfjbUGgR5EP
	Y/mw2R3MnPUuXHfxgHljusGPEfn48ctI=
X-Gm-Gg: AZuq6aJ+ktOII42EoU+/0u3mbCxz8fTuI6g/xlwMfc/X+OHL+DSWT+VB82rHBpSqvdQ
	zq73xsAUDB5BcaRMLxkyj3v2vT1xx1JqUUWJlYciKpyagvyS4s/HWPsI4NkS2blBgPnfPqERMu0
	sY2rUCFlicqX+Rs3byjLmK1eeaHcrSnYntI5NOgz29PCcEaPrgFcDZUFOY0KRAHBkS6L7tzGdgM
	tUY0/xi09OhE4zqslvua+HCaFue+5mppieRYaNUcDapm7ObMJbf8oZ6Qnc5M8aRJ//DVpPV9/dr
	7iUxUSHPkzpK/IPFsHC/AD4Li/ueKVIsMVjxPWKMPZPp9NqOXX7U1CeIGKKgL3PPn3zW8C49
X-Received: by 2002:a05:690e:11ca:b0:64a:e404:7442 with SMTP id
 956f58d0204a3-64c63fe5df4mr6416798d50.6.1771649083669; Fri, 20 Feb 2026
 20:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214002100.436125-1-kartikey406@gmail.com>
 <d28f5840ba4ae273fcb0220f2e68d1101bd79d4b.camel@ibm.com> <f842540484864b0af27c22461e93abbc0e5041d8.camel@ibm.com>
In-Reply-To: <f842540484864b0af27c22461e93abbc0e5041d8.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 21 Feb 2026 10:14:32 +0530
X-Gm-Features: AaiRm51ob-AmaLubvHUbZmpglqm0nQ01jcK3veRgCk0a3m5zaj1u1FtumE6SPQ0
Message-ID: <CADhLXY7nz4K_faLpmBLjs4UXVuoS5-OYodDJpp=QD56kU2Kcig@mail.gmail.com>
Subject: Re: [PATCH v4] hfsplus: fix uninit-value by validating catalog record size
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77844-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E4A3C16C1DB
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 4:46=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
>
> I did run xfstests for the patch. The patch hasn't introduced any new iss=
ues.
> Everything looks good.
>

Hi Slava,

Thank you for the review and testing! I'm glad the patch passes xfstests.

I'll send v5 with the minimum size check as suggested by Charalampos.

Regarding your suggestions for future work:

1. **HFS fix**: I'd be happy to investigate and fix the same issue in fs/hf=
s/.
   I'll check if the bug exists there and send a patch.

2. **Generalizing b-tree functionality**: This sounds like an
interesting project!
   Let me study the fs/hfs and fs/hfsplus b-tree code to understand the
   similarities and come back with some thoughts on how to approach this.

Thanks,
Deepanshu

