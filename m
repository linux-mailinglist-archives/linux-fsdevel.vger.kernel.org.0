Return-Path: <linux-fsdevel+bounces-75197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNreCr7TcmnKpgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:49:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B5C6F581
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 744493001A51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7731AA9B;
	Fri, 23 Jan 2026 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNURtNni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E22F49FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132947; cv=pass; b=tKy1CaPpSzRM3Nb0oj1jYWB0bRVshKySbZputaD4Ep9/NzaCtM9Y/imhx1+NFKu4XPsR5pLJljvA3QIOEesjkW2e1s7++MBMF3nwpHIIRZbbppiBhndYReMKxe49Ukl0R+YxcK2btoa3gbH+vXIvPRb5BqpMqa5ixwBJyK4vAgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132947; c=relaxed/simple;
	bh=f/4Kt9vXsDuXQvwc7cmIX8TtjlSm8w27VOfVoYuX9Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikKeVZ5CuKOP6kc8aEmbs1VldbJMru8GW3kj+gRlPw5mlT9ydH9AT4U7mY2BjAbYvI2SbqgHYde1DNaseogBhME9OgT9NgB3MikDSJjy7vamxT6FOUdlzzAe9P1vxaZG0H+bQxrx3z6Pz1ntbXhowpc/cTS3tn2IdRPY4Rfkazw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNURtNni; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6467b7c3853so1391906d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 17:48:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769132929; cv=none;
        d=google.com; s=arc-20240605;
        b=PT7FU90P1xVFyGhV548HmcdkrcseVtPYBZPJbS0649/AoK5E7PqsyZNg7vv1RTzkjt
         lfAnL85eKO8CXTqe9UivMGEryPLWop7ulSWk/KXc2f/Glb/5S8fP91PDT2c2BSfnKIJp
         P7ombr7jhVHj3ropdVeqqlC4hRnsrtprOFmnFrqAZG1LZA/x0k1BFoQfoDDGKyrw+mV6
         s5HakceLZMTTd7yJzfSbFotyvDI6FhZT/WLV8rlLEAHIeewSDKsmQfdba7Tm/OBOiSrU
         MIo6UAK6saWf2kcHjtV/nFrxJCRtYe7Kjyld5AwlvGaRSwE4CI7MYLm1GmBSsQWNtPzI
         RokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DQQ5ZL3zCCSA+zCgwQGQyuDo1QcwoXFfRJPiqlbbSw=;
        fh=zbU5Kyr4Uzc9yxBeCUN/UeR0huGhuv8fDHiIAIF5hHg=;
        b=daf8+Z/eWZDZZIUShIgyU4bg9ONRoeQ5HnrIIe1iGKNS19y2c/uQJ52eTj1r2l7ZEp
         pXhCygVQ5V0yY8Wa/Qaz7iQVrJmYVcyAdxsVyLExRLm0cZoEJKPgmiTBTSMiwlaqzfbK
         TUcxPWnQxam6EOhxytq607iZnkHsL4hr9mZHUzTXvrVNjERt3WWj2n5LjJECiAsGfeai
         N/ju7YX3+2q9UHwhZxBhQzDMi2fE+wXoqIGuIg04mi+z813kGb9tKhPIAj/8esey8Ms/
         Mu4dRPsLHzbzLGisow/vBg4IE2rMsPfh6BHYFtQP52YEE7dCKtNmRhdm1Tp69tqc/yKA
         hXeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769132929; x=1769737729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DQQ5ZL3zCCSA+zCgwQGQyuDo1QcwoXFfRJPiqlbbSw=;
        b=hNURtNni4jY+VqwgkWhPaxSjGrBEXCGH25HfUcuK3cN+tqmsx6Xi1r3uMMIXTXsAmn
         V0i3PqmrwJ5b7mpukb8EwyWlnBjVN3AkG/4A7swpHhzzosRGxximjqINeJwb6ZHsaQY6
         MH4Y9zCha6w4RSyWWREGh8Huh+CrE+Evsv5dkVBa6ArKxf7Ft/1N4WlRaVT6SlzvKj/e
         pQ9yFwmFd2lm5PYKIPDRCatj4iaUg460QgHuMJPKtlUTLdS6cC42H2uo9W31uOYlJQS0
         sHbHczokiaZtGu4hUdwyhtpQvVZj17BZRTA0sDayv/WzWMGUX5uOdPZ5c45Afd7PC9qm
         6CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769132929; x=1769737729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DQQ5ZL3zCCSA+zCgwQGQyuDo1QcwoXFfRJPiqlbbSw=;
        b=id4GJQgnBcJuderK7KPetnwd5krJ6Q99xCyt3fGm1lpNYo13qurSH20VSGpJ6mEEz6
         dwoHaaioTboK2TaY0QLwMkYVQhnkdrCQ/VqK1PaKiIPf/QwA8GQz60TFlIjTjRxG3z+N
         2gb4KgzNaOyAkCFJ1+6ot1Zos/NRgCqGf6vYp+IbgetulnvcMcBIr+/WVOmusH0gVDsu
         y9q3slihevwahksLqcyqAEsR1kXCq2yxlib6KmA3Tt63s9hBNXv/nyvLIlrIiL9knGSp
         3nUpOVCKN9bXcTEBslg/OSCce/D1UrsBvCdFZFRo6yel4tpQfpLd4ut2l36LQcmy6E3u
         i1fg==
X-Forwarded-Encrypted: i=1; AJvYcCV7mZIB3VpBX1ggHBzsVG5ulio32L62Jg5ukguSx8oq1mp/z11o0/LfmUwVLke0Wm7z5bDhoGxkoLZtFY85@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDTLtyaj78aCLd8JvxSIio+znz5wyhv99TNzZBNwIjEiN7o+8
	3LIisWPdnJcOJ85uw4UseLfpRkjzHK3rBCGTrJxB5v8ReN9LebTnwekgVf2RU55hS3z/WDWLkch
	bqMsT+DqwrEGRpzndSJz8JoO65SYnMI0=
X-Gm-Gg: AZuq6aLaDUyKwE/RXiOxux6Y2dO1xh4dHn9u/fWhgk87GU0LRe2vZe8MzotMW6OTJwu
	Dk/qWHZ8GNFDYiiwo7x1fi32eWEV/yCRvnHNq1W9z7ctPvSj13RVA9pirDAK1McN+KUoRaVDwJL
	abHiKp3otvQt7yZixx3NoaivqyMlry2BnSHmJ8MT8EBZUBvEXFAoufeErSh5JaMI/QgLILAYn8m
	WlYv4lMtOiUNBuYPHzHQnkrLb/ZlU0d8dIQEXER8LypOftJ7r1lAMlgrnF+a18s5SX5NiyNrAeK
	SZp+SJQhZ5IrE21NlRbncGqdDuQc8llJObg/OMAzNOwq1pAeP3fFBOiVO+g=
X-Received: by 2002:a05:690e:11c6:b0:648:ff21:93b5 with SMTP id
 956f58d0204a3-6495bf17992mr1261774d50.24.1769132929438; Thu, 22 Jan 2026
 17:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120051114.1281285-1-kartikey406@gmail.com>
 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com> <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
In-Reply-To: <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 23 Jan 2026 07:18:37 +0530
X-Gm-Features: AZwV_QiPcLgIzor1IJIdunZ9vcG1QYxyMiurHR4YQsYBs0H_DraCNg-FVGbGrpo
Message-ID: <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75197-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58B5C6F581
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:41=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> I would like to see this explanation for concrete particular example. We =
have
> this as thread record in Catalog tree [1,2]:
>
> struct hfsplus_unistr {
>         __be16 length;
>         hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
> } __packed;
>
> struct hfsplus_cat_thread {
>         __be16 type;
>         s16 reserved;
>         hfsplus_cnid parentID;
>         struct hfsplus_unistr nodeName;
> } __packed;
>
> So, If hfs_brec_read() reads the hfsplus_cat_thread, the it reads the who=
le
> hfsplus_unistr object that contains as string as length. Even if filesyst=
em
> image is corrupted, then, anyway, we have some hfsplus_unistr blob in the=
 b-tree
> node. If you talk about "hfs_brec_read() may read partial or invalid data=
", then
> what do you mean here? Do you mean that length is incorrect or string con=
tains
> "garbage". My misunderstanding here if hfs_brec_read() reads the
> hfsplus_cat_thread from the node, then it reads the whole hfsplus_unistr =
blob.
> Then, how can we "read partial or invalid data"? I don't quite follow wha=
t is
> wrong here.
>
> My worry is that by this initialization we can hide but not fix the real =
issue.
> So, I would like to see the complete picture here.
>
> Thanks,
> Slava.
>

Hi Slava,

Thank you for pushing me to investigate deeper. I added debug printk to
hfs_brec_read() and tested with syzbot. Here's the concrete evidence:

HFSPLUS_BREC_READ: rec_len=3D520, fd->entrylength=3D26
HFSPLUS_BREC_READ: WARNING - entrylength (26) < rec_len (520) - PARTIAL REA=
D!
HFSPLUS_BREC_READ: Successfully read 26 bytes (expected 520)

So the exact scenario is:
1. hfsplus_find_cat() calls hfs_brec_read(&tmp, 520)
2. The corrupted b-tree node has fd->entrylength =3D 26 bytes
3. hfs_brec_read() checks: if (26 > 520) - FALSE, continues
4. Reads only 26 bytes into tmp
5. Returns 0 (success!)
6. Bytes 0-25 are filled, bytes 26-519 remain uninitialized
7. tmp.thread.nodeName contains uninitialized data
8. KMSAN detects this when hfsplus_strcasecmp() uses it

You were absolutely right to question this. The real issues are:
a) hfs_brec_read() doesn't validate minimum expected size
b) hfsplus_find_cat() doesn't validate the read was complete

However, initializing tmp is still necessary as defensive programming - eve=
n
with better validation, we shouldn't have uninitialized kernel stack data i=
n
filesystem structures.

Would you prefer:
1. Current patch (initialize tmp) + separate patch to add validation?
2. Combined patch with both initialization and validation?

I can prepare whichever you think is better.

Thanks for your guidance in understanding this properly!

Deepanshu

