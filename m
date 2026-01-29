Return-Path: <linux-fsdevel+bounces-75829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACdlN+6wemk79QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:59:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F15AA6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22EB30215B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C63081BE;
	Thu, 29 Jan 2026 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgiTQEnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61B2FE582
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648352; cv=pass; b=MK1QHZJ9scHBlEDaYvwL5SvbdseXhViTxP44xiSRKk9MFJ8XQW914YNdsCFoRvTbAUeC50OBWPOcbRd9r33Qwik1M9PpZ43+AXCJHh8lfSmnCc3j0XHp1CrUKIIdzUnE56jTOTwlA7mHsW/KSLq+6/A6ICVUE2nY8ctL674ZFMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648352; c=relaxed/simple;
	bh=+L+EqsxFGbq9nKKnaprPm9Ir3tOy0vr3+xqa2zLh1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi0/QvzcPDJxyoO7qcyEMmqTC3AfGE37qsQmYQ5Z8xC/rp1gFoeb9IKOH/KLa3H2u0tuugMUVddRKss8SZuqJ+P3r0IyjV6eHuuK2L2Vq0dJp0DHhw4qkTybff2nRb9bOT+4qRZ0UZwkHmRBb2Q8X4H3m2QcpyJnzXt0MvuTFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgiTQEnp; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so764774a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648348; cv=none;
        d=google.com; s=arc-20240605;
        b=HcnfpyOZLHN0NLEl4y6m4pqEwu6oku1zmlF3aswwtZKxou0uWMaNrEQzF4nqcSWf06
         dByFVm1QpK9vuxNQ/aVl0oE2uwibt1PhFZmqou8LWNX4G3AVWSFJKRGn/kMD0mOS3TLm
         ib+JOFfJlgURmnO9e3fRPktlgYyeaj28tnBJts+4jwSKpPuqa1uUQAesbqVFw4gGrZ1e
         3vOTxRj6qDEHLgXyxMRwZBCW2rZeNfX6qmx39fH1ADuIXq2mMbtFHFbdR5bFv/6ihhra
         3kDZDbnomIL2J78/TRbj/e+/Q0A8YzjOCswRlAvv8YH5x+vbU3cj5xoaz5GNO/XXYyPs
         y96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        fh=jZ39xj7JR6RzqKJv4Ia/HyjnNIYzf0jIPwx2cXfEykE=;
        b=f+xBFkUuynOd7zTFYWjQBPd2IxFwE2kl9i5cUCYCuxn8xIVR8/LUHYYKIpDnrKomUU
         gOED62oiSZe9EwhXqccw7rVKKz/vxa464bKURQ7FdQUHvyvH5csXoW7PQaCn0NXxONjp
         /xGXD+aKzattRU/EVK8xDFbll6n02znaynKLhhh5AcQmcw9ysYsKlVlcQNX/TD1Cj85P
         Svxs21TjKS8RRNUCXKVHkAFzmgGfu2ZyEQDSKtq80TxodLpSK69jXDReeFKNdVGJzRvn
         TYSNfgeQe2rS5heDGG1gg1/4gHfz8ki6y3v0wAcpQzcXRE+LHCwBxPu0IjfV8ORbiuyF
         6JLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648348; x=1770253148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=kgiTQEnpKJp/pjWzH8UIBoZE2prYNeOdPAmDcSgp2w5aKDPBJN5uF6sIQ17O5EEcaN
         ACyLVBvVNlwDDlteA0YIqufuqAY74ZjqMbYJ4tJU9NEEZn94CcJXo/9Epjd/HQczmXSw
         oQ68UlJ+ysPe1pwWStyhBRWb1KgBhwrl8ect/5mMeMeC2LbIGU2krUo3qleFHZZcB5UL
         oZIcbiABabn8ZJ0AByRhAkYpLWueJfg6OQRWhq9Hw7bnfLKCMVArAe1ksTnsKICVRJSs
         d5Dacf8qFkgg7Xd+y+e6WdzSOZLhxyO4qtDTDvpFsyFA0L760P9y01OOVPtjLx3ifnCU
         1Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648348; x=1770253148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=ViZpilhwP9bXuElB3CRwWsVmQCl+vjyKYikC7T9kLLorWJDVE0ApMq8a4WEBZls8Dw
         D7M69Ja/wLZAFWdE/ICGcPpmZzqefsX+RLCWrxqnqSWbB9k43SSlLhVtjvAZHc5Z8i/t
         8RZLiiDvrXkuxeWewEjhVX+GH7+sI9THPArZVZGsfspIvJE+v35uz0UAW8RerWI3Qjaq
         x+5F07+73P2VqcbMYCOFgrgcS0c793ZgiXekyb3l8fBD+rNF0Bul4+/eHokiFyyNDsLG
         Fa0IEfMZ5H+DebXW43zrtdqmo94Vm5xBVQgmZSy697Z8L73tyrkthHrKsS9CVYcvOkN3
         g8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV9/SFbSj4D53D1hNlXjsw3NpNvhIHVqJ+cKIy+ovcYwVfXTJT3dR3y9W18RFSe1+CXkT7wV+neZMvnR+wk@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQR3bXUxjTKc4HyUhlC/hSBBI31qrNrasNjbUCfndSmY723Nm
	b7MflgJ7PEz0wB0hT7wQaoFOwlSZY6V9m6U/2G+KSHJbA0uxU1nEBUeSx2qt4mfRZ+XDLxW2jyN
	zGPmFa9xMnPDuUdCp0CpahXwj5MZueWSNV8+rh5Nb
X-Gm-Gg: AZuq6aLfzDvo8VCiHBQF0penvt++jA0bf9LUdexF7hgJ3zG+EJd/QCgGrcfLCsmCYHY
	d/gZJohsZrPeDx5Fpbebc747NLql3oZFqY6v6gRbKj6mkKwppNwJqnyO+Y/Rf8X0g6cWeps8AUX
	MImjBRaOI3K4TJhRrkx5fTepXwmd6j8NNVtE1ifVVFS96YOVGJaQDB5i7B/BBQ5vNYQ1c2RmVT/
	NEzsFQUgrST6ynjb6vgvg2sWCSZQwULoZSVOPvqvVGChxd0Ckp5VU+rz1itfVLVKxaSDzfzrD2J
	63mxca0f6UJzYySYdX6ULXhhW+5lzw==
X-Received: by 2002:a17:906:f585:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b8dab3cf66amr455166566b.63.1769648348337; Wed, 28 Jan 2026
 16:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
In-Reply-To: <20260128045954.GS3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 28 Jan 2026 16:58:57 -0800
X-Gm-Features: AZwV_Qg5mDXEWLmzjtDFHSng8MB2HQLUBKHQ6Wr860X_lRTmL3Z_ZmvOjLnN07o
Message-ID: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75829-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 61F15AA6F0
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:58=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> demonstrate that behaviour?

Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
simplest working recipe at the moment is with 6ca67378d0e7,
c7747fafaba0, and e5bf5ee26663 reverted.

