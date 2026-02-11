Return-Path: <linux-fsdevel+bounces-76916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDfTJMTWi2lCbwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:09:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F26451206D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA55B305595B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A32749D2;
	Wed, 11 Feb 2026 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxLTGCL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0C26F29B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770772141; cv=pass; b=kkmp6OLNOoNGuGgoloXWJ/EPPEQML4Na4sJsXzt/ccm0f7BlsMFkGFK+8P3fn8GDtysCj+NYgDSozCkgxlIzwS3it8FpwaPfGnlALbe2IQsEHaFepXDDUAZLJQ2wyjW1YX4TIMYVcHc2/RjWJGbSIcCPuL4QKhZtQ6zzpw3hSSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770772141; c=relaxed/simple;
	bh=JTYCRIanJVRblljMsDP3V/7so2HteH9dP3EwV9dr+Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ5VrUJ3uN6v19dd1JtjJDeEIUT8AClObncCKJoRposNovcJneIHNjbXZVJPQUT35593kWx4oRGcVyL76CoylXBLEDZXriIzmTOLJSWHC2v8vubHMlnTMVEdkbUVyjDeDSMJjwGWjQTgadSh7aoQ4urLCK+oGrxijADae46t/jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxLTGCL/; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so135381cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 17:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770772138; cv=none;
        d=google.com; s=arc-20240605;
        b=ODCqMH/gkbtEzPOOpGARsBRd1nydsu5QjbLS44zW+ymtvYNQXVYsoGNWskub7vcEdd
         W3kNMJyi9bTsjsRXNufhSj+4vdjoWnE8mGtpJoaVepI9M54I+WbpFe6mwhgzDA9p5OiB
         dF1osoH0MGZ0Bux0M4bCok/xpuw2RJkA53bpSw6xk84VxagvduEqYe+W20ZarJbo+EWz
         xThcWHXbua+1bpgg1mc/xPnVeP6L+wBAkXI2q3oawLC2QgA//TC81Ee+fv0v2Xi9vTbV
         3Abr2Rb9WoyiGgt4KR/CrdFbxgdxW8+1l0kAB5o24P8g3Pns6Af5wu9TQW01XrullhYR
         4PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5wIzv3gxAepMuK2aN8/ovNvhOsuPkbIqgztuEoLqQM=;
        fh=DpRpBcVOMaVKfCkXIhRP1V4CbOAx/TZDPdA/hiVR+1E=;
        b=NeYNoHKbYDHrnR2GbRBEi0Yv8CNoLOklMGKfo9/c87woeaAGIpNPmkNq6ZQ1yIqUN4
         BK48vmgsar8fs1dFQxOJjpxtKrVn4Q1JrBjAwiEEW6nwWUkUZt2hEa2p8u4yOWr7bLjK
         rVrhNSurQw/717WEKNHsu8ru8I6EhEGXFF9ftUFr8KouJQhF1nKhWEsVnB6Af/8dFRPf
         4xxx+yJtSwR3WvYhh9NCfFC/TaoYRXvTkcB1m/tOP0lV7zeeGSn+xOlcxX6XMg9ofbAX
         0tkJ6O28OqkUUEIFg2iAvLLY/IN0BvFovS6ISBGsfCtHBI/6IPQ4yQRHWDiagv5RWXUV
         RtDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770772138; x=1771376938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5wIzv3gxAepMuK2aN8/ovNvhOsuPkbIqgztuEoLqQM=;
        b=TxLTGCL/vl89C1iBngaUVe2yaRSyU9GEPZ4VAOTDhQlgfXxWnQitFkKH3VdWuHw1i6
         dE40LGCp7TJiWqfbD19JlHsv89nitmiZ7b8BCTU8y5/FWbogFIwFediE5awqURE39bWp
         U0mPWSU0WD7ZxqHRrsUzZRydAsCZQTVS8H+4Pq6DEkq3xb0uVjWcCjBkqa3QGhiXotC8
         y2RoWB4LCzYWCmyvwbI060yzBSDBK7dvOjQ90F+Q1wWZ8WFfzx/DNpAiSYp/WoljhaUX
         0niOZ45Kgvz2L9VQZL7pkkmD9PP5P36yOyflor9hc40H1eskjJE/LSVQR5YASnk8Jvuu
         pAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770772138; x=1771376938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5wIzv3gxAepMuK2aN8/ovNvhOsuPkbIqgztuEoLqQM=;
        b=eGgwr97oCaVTMGnTZ0thvA7q8fFmSEv6A54nQ5dwbu/g7zONc9f3eeLWamxnirfujO
         mWrL5F9IXNgNGwhiWsAPtVFa8ZWAn8lenKVQMF2U00lUOTprZaE/8kcO9meXmAgbuo1d
         PoBAAzzp7RulKtaAzecfD3y0koaUUk9mt8JF5SVK96fJuixE8kyC/FUEHcz76GhtGBrk
         AxP8Cd4XRFcA9rBCu5E+6pndwfIM8DMqxoci9q0AgManEo8cWzCv1zyS/8aBxMkVRJix
         S3YGT6EIJ+r+CfQAZivITkoxBnyrzjvKbb6tnBkX81J2mmKijRaer85r00+zcC53Wost
         oneQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjxasUm/w8Az/Fgxon/3Xr0RbKGMF6YSB2A7qUIjmaXP1dc0frofOMBMqkC1C/785CYW6S2BdRx2NstwNd@vger.kernel.org
X-Gm-Message-State: AOJu0YwufC9QAhXqmOiOcbVaWjj6QTkk/6qse/4HdxS8f9a8+FM28+wd
	gPab53l/T7JZ7A3aijbL3SVufS5KOS1mKOAevOIcyuQagTkgMk1c9cGg41kkcZ1RRBBpURqnNyu
	+aKZ97sMAWdS5L8dZft9LMZ+DifSMXwGjdf8zBoN2X8uhu+KCN1gFiIpt3vA=
X-Gm-Gg: AZuq6aLOgo2O5umv927gGFo3Gz8Tt9PvTc6i7lVgEhcUdFpn2PL4MGBeDWKw6SDjINr
	Zix6kBvh2JpHSucfmICarHlhC++6HUCHfaqOTL2MhBNWgEPrWJlkSv1l9N28bNHK/h2Y05WkGHb
	wDClnPS90sqn0Q6dGgNEoGcP12o64DWLULqPbT4D9O+Pd18PUilcXRTfrNwQCAm86+2iNQfePYw
	2OcwzG9H4bu1PeD4LWG33G6FuPfJkoabuYmsv+2LK7s0TlPD7w3qt8MjNwGwe0/qK3ueFPGxYmW
	i+lsJC8=
X-Received: by 2002:a05:622a:118d:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-506827666e1mr3331941cf.13.1770772137161; Tue, 10 Feb 2026
 17:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com> <20260209190605.1564597-4-avagin@google.com>
 <CAJqdLrqFJm5s4qgczWUi50muoMbUm7tbDZ4vTp=3ktEDYoi7wA@mail.gmail.com>
In-Reply-To: <CAJqdLrqFJm5s4qgczWUi50muoMbUm7tbDZ4vTp=3ktEDYoi7wA@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 10 Feb 2026 17:08:46 -0800
X-Gm-Features: AZwV_QjzYmM-WZIpZJo7jxpdR0avYlD7_PH6H5p6BAaV9nV0wPBlcHA2v8Of8Jw
Message-ID: <CAEWA0a6x+RfcBpOrcJuWaFcZCPAbBV2uDWHfQbaCMv8vBHeZEg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76916-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mihalicyn.com:email]
X-Rspamd-Queue-Id: F26451206D7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:36=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>

....

> >  static const struct file_operations proc_auxv_operations =3D {
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0091315643de..c0a3dd94df22 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1104,8 +1104,13 @@ static struct mm_struct *mm_init(struct mm_struc=
t *mm, struct task_struct *p,
> >                 __mm_flags_overwrite_word(mm, mmf_init_legacy_flags(fla=
gs));
> >                 mm->def_flags =3D current->mm->def_flags & VM_INIT_DEF_=
MASK;
> >
> > -               if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> > +               if (mm_flags_test(MMF_USER_HWCAP, current->mm)) {
> > +                       spin_lock(&current->mm->arg_lock);
> >                         mm_flags_set(MMF_USER_HWCAP, mm);
> > +                       memcpy(mm->saved_auxv, current->mm->saved_auxv,
> > +                              sizeof(mm->saved_auxv));
>
> nit: I was looking for this memcpy(mm->saved_auxv,
> current->mm->saved_auxv, sizeof(mm->saved_auxv)) while reviewing
> a previous patch. Shouldn't it be there?
>

No, it should not. dup_mm copies the contents of the old mm to the new one
immediately after allocation, but it does so without holding any locks.

Thanks,
Andrei

