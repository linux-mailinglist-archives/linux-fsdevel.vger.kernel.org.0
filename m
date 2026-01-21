Return-Path: <linux-fsdevel+bounces-74778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCbJGVFjcGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:25:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BB517C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0B9342C232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32B3D34B3;
	Wed, 21 Jan 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPHqndwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32D3C196E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973105; cv=pass; b=EF3TPK872ear+EbtDZJVo42ll7Wmpfj4Gx8r+Q71moq/fHPj1EFBbuwraiknFit8pUweC+6KEb8OrIzbMqk1t2F7y1eWQwaCdnviH/SqF1M20NtUDT7BUeuSR5mSdWfvKKKtg3zY2M9b8c67MNW/eudrfdeaGqY7ByiJ1dVLd8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973105; c=relaxed/simple;
	bh=ztpiAiT5hx5HzLWY0Qch6o0CJmKzw+5HIeJUSWc4XIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7w5wCEYsNWczWdfAMu/w/9upLq2nCdgRnNSWEQViarC0DGHiiQb1B3qzN8GLiyYfYLq+S4lRymRZa0OgGqi//XXF1GgE+BxtjcLBJnF9ctsXgqpUta3Q2BVCpCjPgNoyJ5VFpQUyrZ8tz0HA7cBQDOmEbjP2JFkyw3yz1SvYlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPHqndwg; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b5d8551so204921cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768973102; cv=none;
        d=google.com; s=arc-20240605;
        b=bI19gvCH8ikYnUyZAdm/qoqdPgs90lHxabxTFG3sssf+xjb05kzedPe48B20xMMVWk
         rNLdARetNd5oXrLdnL4ytr40H1cM5gXIRI5ceqiAoelA0z9a7UDcNV2k2iYaK4oZWere
         wKDEMj2+c8HA2IiGDD5hOj4QtUo8iZk6OZLjM1Tt82npQ3YE+8hhwsKpxD20D0U/ShCe
         4FD5Zpi2qimK1D1FHSHt3XaMV19WfCWu9T0owLa7VG4U0oDDDuvgGQVnsNwqjTc/6JZo
         0aqWOYsggRHTB6hNPwqoCvxzGlghG1Mdui4pQzt9e/AmI0+2YiE5YGzspeCS10jlD/75
         +ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YJHw0lGeqaxxhmKwhAVb/kT+sCLOXmrYZ/McZsFTgWQ=;
        fh=UnPCnrjztR044oQVOv84Ivmhi2X6kOQNbNKJexRVNiI=;
        b=YcHGQe9kEGdu0e5fEqejNt1mAXgrg3uw9Or/YtOSdld1lmimE4s4ffVmdMo8MK98xO
         3cmGGDST9dOhB6T4V2V9qePodPrGOGWALaYxyIRCgh0e0lak4PhXm7e3tf1kKUsqPWb6
         0q9/vc0KsbsJmb9Af8hkpCFO4i02ph4ph/L2GaeLEHTAduA7ZrBUHRm6/cf/+jXunG4n
         H0hlZhIh7kVeQ3LgH1eMlnBU/s5OhN6niIGWucWjVv6+22ZqkzKRqzbj9aCGieeCHmDq
         FZSWWXFI2idkaE9YH1N6vNzbB7+de2hXYphAQXBXbGOLUI0frozj/356c07KESmizxpn
         PppQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768973102; x=1769577902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJHw0lGeqaxxhmKwhAVb/kT+sCLOXmrYZ/McZsFTgWQ=;
        b=VPHqndwg7Q5FE1h9nZ6MBrA6N5lXU63YNfx03JvbBHiUdYfwD1CvaEPsuqMvn0Chlj
         cysekxvgbtpv0hfFa9XL7NRG6nBOgdobAF35VP3RcI1a6jhZb2h4T4Lk3/ljfzOagLWT
         LMY1ed19QnWCcrap0QM9fWy9R/CruKj1dSjXGTFjLyIefQ0k6evWam57ogcv8Ok/XDB1
         k1UXar1IL2iPSysswE63idiwLKfYHnbfD5STZD4uYxF1iG4dWGvYAzkqCCz/2D38FPiu
         fKUpXSm5z/GQXvkHAZ3Njizak9pk3QvfftO64pC9RsabOk/DaqFdJ21QLL1iy2KCwGCm
         CeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973102; x=1769577902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJHw0lGeqaxxhmKwhAVb/kT+sCLOXmrYZ/McZsFTgWQ=;
        b=CB0XFvFB19oySTDPl4dtEbVA0MDBvT0QYBv1uOnbmhYjhSxJWbn37ntoWO/hvHol4h
         n3vlwg+JqErSFeDdxLnvpV2WHFmRRzLkY64M2vY8MxQowYRq182bjegCvGcN7dsT4s4a
         3wnNVhu7CvFgElnVoMHt/5uznxLsab9n+cfNvtVgFuJAyfXscilN+qmm5r+0oKUrHOKf
         Hdh+wSEd0uPkE/vzucqqKLpCGYvYT2qS8JEkx9OKhaly/tGV3tJf8lXMwFwJ6mdydto7
         WMcydfs7FpMzaQWxN/iC6MLqLJG0778X6wESY7/pNGwTiDdj+3spJ8DNQAyUz4SO1fc1
         jz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNGzte+RnLXNZMEUXsohSQDamC3vzI3UbmaBo/uY6qPuJ5+4V0I8OGk+KjHB8QgYZ64q0kUS0uJVjaDwSl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cMNzmhG1XnleprcY+cfGNX+Glhiwi4fo/6jK/3kAsJX73yQD
	r0NS+A1zxn28sQujeXcDUrHgpO8UIRTJjuOQi6MHI0OcB9F/oVzlmzzks0oDfjE8/dAcg30CpDY
	3xesG1ZSWeyFizF60n8Mlk0giNOCQMUkFCYuLOeKO
X-Gm-Gg: AZuq6aJdmlMQrnqdJMr8QPF1HJShlshLNRAtmHJprqjvk0VLFO6rigJvXlI6/pwzJbQ
	vafOHRRxSK229AYbktjttMXfGpa8muHjSCdGvKZ1Sl5F3i5gjtu/v7b30L5BiJFeQdu1HK6dASq
	SZ+VD9lLOWYOUfR7gu7h8XxSmCjHesttl56OL432IEy4f+yGRRfo/d37UqmFMtQgAuWG8SQgiLG
	NvFDl5a3aeEcCXt6DDp13nZfwRIETGMUolqIgUR+lGsNkmQzwhBjY+LRQtX3j1rupu7fMk=
X-Received: by 2002:a05:622a:1aa8:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-502e0c6fcbdmr7688251cf.10.1768973102108; Tue, 20 Jan 2026
 21:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108050748.520792-1-avagin@google.com> <20260108050748.520792-3-avagin@google.com>
 <wfl47fj3l4xhffrwuqfn5pgtrrn3s64lxxodnz5forx7d4x443@spsi3sx33lnf>
 <CAEWA0a4s+Uhm405CnvNsE61ed5_xJ8PUZqL74zfeZnivw1BChA@mail.gmail.com> <sp5yxpqi62ymfhjysggmuvxxcwsxtz5kthu64h6kr2poymesbd@3tjqlq7z372p>
In-Reply-To: <sp5yxpqi62ymfhjysggmuvxxcwsxtz5kthu64h6kr2poymesbd@3tjqlq7z372p>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 20 Jan 2026 21:24:51 -0800
X-Gm-Features: AZwV_QikbJBczuSV0EDJopiu-yF-8IYj7bbdLuSPwFB_-oOLC1uGOeZinh1Bn0E
Message-ID: <CAEWA0a5yShzk-AHvHKCXb3RM_KEY0aKHkvuRcref-46_1pWoqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] exec: inherit HWCAPs from the parent process
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Cyrill Gorcunov <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74778-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kvack.org,lists.linux.dev,linux-foundation.org,huawei.com,xmission.com,oracle.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 112BB517C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 14, 2026 at 1:25=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Jan 12, 2026 at 02:18:18PM -0800, Andrei Vagin <avagin@google.com=
> wrote:
> > It is true for all existing arch-es. I can't imagine why we would want =
to
> > define ELF_HWCAP{n+1} without having ELF_HWCAP{n}. If you think we need
> > to handle this case, I can address it in the next version.
> >
> > It is just a small optimization to stop iterating after handling all
> > entries. The code will work correctly even when HWCAP n+1 exists but n
> > doesn't.
>
> Indeed (I accidentally ignored the AT_VECTOR_SIZE condition), it turns
> out no big deal then.
> I like that it's not needlessly searched (and copied altogether).
>
> > The inherit_hwcap function is only called if MMF_USER_HWCAP is set (aux=
v was
> > modified via prctl). However, even if mm->saved_auxv hasn't been
> > modified, it still contains valid values.
>
> Hm, bprm_mm_init/mm_alloc/mm_init would tranfser the flag from
> current, I'm still unclear whether it is necessary here. (It should make
> no harm though.)

It is just another optimization. Without this flag, we would need to
parse mm->saved_auxv even when it hasn't been changed.

>
> saved_auxv validity seems OK then.
>
> One more thing came up to my mind -- synchronization between prctl'ing
> and exec'ing threads (I see de_thread() is relatively late after
> bprm__mm_init()).


Currently, it is a user responsibility to synchronize these calls.
The comment in prctl_set_mm_map states:
  Note this update of @saved_auxv is lockless thus
  if someone reads this member in procfs while we're
  updating -- it may get partly updated results. It's
  known and acceptable trade off: we leave it as is to
  not introduce additional locks here making the kernel
  more complex.

Without synchronization between threads calling prctl() and execve(), a
new process could be executed with inconsistent HWCAPs. However, this
would not trigger any issues within the kernel. If we decide to
synchronize access to saved_auxv, we can use mm->arg_lock for that
purpose.

Thanks,
Andrei

