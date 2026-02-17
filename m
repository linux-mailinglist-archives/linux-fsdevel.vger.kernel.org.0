Return-Path: <linux-fsdevel+bounces-77349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN7LK64zlGlAAgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:23:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C814A589
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 097D1300D777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FC27B33B;
	Tue, 17 Feb 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOfJ0AGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608F304968
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320230; cv=pass; b=JbpE9BxDczCmzS1pngpQL4KCm5AyDaPEoHlLUNuIM4c+ADec7mk7aHUh9bREcCPJKqjWXmf1TU08IYrxKhow5i27GojBE6g1zjDKsLpwndycRpBSQAocolBcDxG718VSUfQhpnp9e6END5Re2M1tHQOT5L48kn4Nv+9rAXupVYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320230; c=relaxed/simple;
	bh=y1CU8SyBn1xLiMljauNRp4/xP/fPOy3c++Qg9ZktGhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDmVaAka+lz5CN8zwzTWwlOz2JR8VUizNZ00YuBhUESP+jz5JafAFBsWCG3FieFu9HBIWPmap3DVUssuhBUlqMU9qdLIf3xEbtwWa8k22D5wQmYfO7maKYEbKMDXhkB00o8Xoaqv1hqYeLXII3dJrqYlqSDtNqS/wEot9S7s7Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOfJ0AGa; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f8f2106f1so531725866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 01:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320228; cv=none;
        d=google.com; s=arc-20240605;
        b=cEUrSTYC47nfdVfFg0FEvEUu0/S2myz0tz086+b1TXrqWF53xSMion7f1UmEPpKcy1
         Pha05EPsHtxFqDI4k2ZhURVhbowbr+nsccURGyReyyyHnP1r2z9yvoIx6W+dXSZT5HS6
         v2ezkbO3Jeh5l7tESneIROw3RekXuwY6+bMpahEiSjyhZpfL9MgbFHHUrDdAFgQCJrgx
         56t5Pb8xu8nbuhR4EbmsrbF18tEtnaiMgPqjZmxyE/UGn0d33qRlRle7kVDtZQTQjp1O
         81iJkJFK8Pmb+IPsRXe038Ix3FO+dBSD3V/3ymO9IvrLn6EZ6LnKFnRZk99FdXp3rYyC
         n8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1CU8SyBn1xLiMljauNRp4/xP/fPOy3c++Qg9ZktGhw=;
        fh=HlF05MvBuXf27UXljevwd9YNUiJ418UJRJpMqhXVKEo=;
        b=BvXq4h9g4t1ORVeBFga0f5OOGahG1Hud7epiFCSE9NvdCWwsodoeTFr2PmBEmMi2cS
         ujlCq/GjR0epksUmf9PXiTy3O/psrth4N3o7obz8b4sGnCTfhYEwbMdNXYXZ21IsbCJY
         qx7ddhfxqRx5WzWwKvqN/zBTjdEX4ITw5+OGRagFR9ZdzESyvYCwmUiMAjU3KcdXZmjp
         h5e7B7EFSUWzJwHOqTgWoUjHs+5YwyjmcIPQ0hWeMWBJ6XjMUWnGFg/giImfMOaBA6Zp
         1DxGTASIOm1eQQuOKzYCxvoYhMdjLfOPsrxYW+scZjPLyyxu6pleNG55JKoEndymwkSU
         iQJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320228; x=1771925028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1CU8SyBn1xLiMljauNRp4/xP/fPOy3c++Qg9ZktGhw=;
        b=EOfJ0AGafuVMabGtPoDxKXxiRNWnhtn3s4gpiKaIVmuoOe4xT01UmOl1gco0cNuXOF
         L/mZShoZZdmR4fyDrq11mxQAS5s/Myqj08iN5Fzfn+WUpgAgLvdcpeTKNpUmXMA6SvrH
         E9U/8uZ59vwuJlkfASwrjYIx642dJ9LJ64n6Q3pNUiotqQIfdizi6b/DCd15Go4aVMYV
         cBrZ2+SB14YLFK0UbFy3BAJrnMfB806lA9CTwJXpfQdHPD+z1mh4GHr/E20SQYw9fCcG
         6rcbV/Y+xsyaV4M2d1oalr0mjgrbWxYdU0JGxxrWrQ0EJ/6LQB41svRJd1Eg564t+XRH
         WalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320228; x=1771925028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1CU8SyBn1xLiMljauNRp4/xP/fPOy3c++Qg9ZktGhw=;
        b=Juzj0VHD/E1m0D5NkoA3BbSyiUZsIDjFXPe66dlP3NBpUqjh2ITDf/Cpc0ntDa7fFo
         oKQtHCT4GggIfDI2DpjVoGJAz/+Qofb6kcfRI5/WwxEPAj/Dox+zHq/ee6Q5iIkJVlUm
         X/gAXCQVSKf8EYE8MQntQPIta1jPdO9t/tmojDiAfsSqKlfj8f2mnmzDDsxXWR9hWWBJ
         jkQoP0ZjeIlQ95qS7M8KBZa83dpaerXCx3SnwzxQZM7AAfaU0ZrLRcKuuHS2z2zrXAJL
         LJsLZhp4cLn3z0mmXkJFYyeeZ0A9+G21UTYmV+WCqCJtMVHqQvf6N+PFT1pd1S96wLnV
         CMzw==
X-Forwarded-Encrypted: i=1; AJvYcCX50c+KmtgB4xo1vertX8wA/FmB1pd83b1RiQud1cKIpDxKLK/JqBffaCxqe/TAOPiMhGnEBdqcVnUPT8Aw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33E72svg5p4MNrIzLl2qXYlx3zn271r3RinOTIoowD8+S9aFY
	0b0dYeDNLgO6qXp8CA6hbTM8v++/QALkMeGKPpA2Pc55gqPqiUxTOcKz6O8q3Xx9v9is7PJ1ieQ
	45OjF+JxQRUoF3kAsV+KllDW3oT1NtB4=
X-Gm-Gg: AZuq6aLsX4iwb0nHYSr/bH2BAa0huwfttsTANBjHwvUMmX+3eYmCVrjGPn8YqiwRJ7x
	pIlDlwPGB7qcaUkUa+2dqkIExVEgIJIuT5i6bCJf9yzAL2HWEiIS39cZa3mgbi3E0jB/KKR0Bgm
	U6LjHYJ/mkybYxFJTEiDnWHTdMZU0+o7alkQoK3GabdxI5e5MRBCh6hVab5bmZbKKuA/Nl/yxka
	GET5dTaRDNdtLJRljLbPYGJ/vJZt+nsNd06ND0Gkf7/FBPXovIFerRrbseWKsCSUyEo2g727Uno
	zXQyfqOE
X-Received: by 2002:a17:907:e101:b0:b8f:e438:75ba with SMTP id
 a640c23a62f3a-b8fe4388da9mr248776166b.29.1771320227576; Tue, 17 Feb 2026
 01:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev> <20260217055103.GA6174@lst.de>
In-Reply-To: <20260217055103.GA6174@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Feb 2026 10:23:36 +0100
X-Gm-Features: AaiRm52xz8EBc9OEZec10DoizsQ3eTTptMfYZb6-P8BJzMypru0h1TRDSfoM_ik
Message-ID: <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Andres Freund <andres@anarazel.de>, djwong@kernel.org, john.g.garry@oracle.com, 
	willy@infradead.org, ritesh.list@gmail.com, jack@suse.cz, 
	ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, 
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, 
	p.raghav@samsung.com, vi.shah@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77349-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,gmail.com,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E9C814A589
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 8:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> I think a better session would be how we can help postgres to move
> off buffered I/O instead of adding more special cases for them.

Respectfully, I disagree that DIO is the only possible solution.
Direct I/O is a legit solution for databases and so is buffered I/O
each with their own caveats.

Specifically, when two subsystems (kernel vfs and db) each require a huge
amount of cache memory for best performance, setting them up to play nicely
together to utilize system memory in an optimal way is a huge pain.

Thanks,
Amir.

