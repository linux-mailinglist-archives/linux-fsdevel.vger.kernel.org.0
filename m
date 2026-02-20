Return-Path: <linux-fsdevel+bounces-77754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB2+DFOkl2mf3wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:01:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7496163C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406B83047094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95C330320;
	Fri, 20 Feb 2026 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R88Y0q8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059132BF44
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545618; cv=pass; b=FATE0rVLUnslAYdFlEw1D8hg2pdla0QkaqgsBp6I3cFQbu8ZZkd3BhEJigOb/jr3Ks1WUW97K58pOK81b75a9IW13rUZSfEB84ej21fsJUvs7xMLZAr0QPyi1PNPprO7cegK895mVeZtlcGe4CkJ98kUln/xnQ79Xec4M+fcQZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545618; c=relaxed/simple;
	bh=d21yEhqfzh8zMrqUE1edOExxeM5FU/XoUziSunkEo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uymFEm95fecQEjyiafntF+R9fRQe04eqy/wRX0fI53rObjsvfDd/OeGK1pU7B9d61m6yMhhXvbPwXh8fmXDtVgtobztnB3kSWrs1A8FrxoAycbeKzOs63t2XhRn8sEPh/znHWYNoC7Q2EAq6xWa3sQBbTjY++h5FXrayEKx/wz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R88Y0q8z; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e5998f90dso535830a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 16:00:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771545616; cv=none;
        d=google.com; s=arc-20240605;
        b=gP3kusyxssySwOoUL37LbaCx1ewIPl6ts8twpf2tDquVrGLFH8goZGx+Wjd4SR7unb
         M9rMuPmHZndu2COsGExxxZjW4RlzCYdGibblYhDl9Sy4CgAKtusvUrxMaN3hZKDKltqE
         uA6+k5MqPyONcebtfHxLkc3RIFc1brorH7kzOffNNBTlHTKNFgKRFNeDL4qJwnvBeEFy
         4jS45HZm2IVTjjDz5rkUXwWhMdAjayupajGdxANAMOLIcY1EoNeePbEHCcEA/KU0+mJW
         n4YPX9WT6NGQAzQ0FS7XBwIcIagIBu9xj2MQeuqZBe+8np+PN222tF9C3POgo4q9IKQd
         3zpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        fh=lPppoQBPYuieCMvmC6KlnDh/yxbH28FuQWfXW68/HkM=;
        b=HO/CMY3rEMIZ8ZOlrMI3ytjc6Uhs7bAgVvSCuXufvFRCabJL1XX7jS3YQ252d378A4
         lAe4H/aYuzk9p4HHQ0GevCUpJyaqfUq5L94CBbCvAa06vdme/PqZrMBW9sieUyrdpA7/
         r//9ByfU4nZICdVnWnSDSFEvjQOmvKiDs0AUBNL+iNExL1TKe+0l2aTmMvjNy2rOp+LG
         Zg0kjJJNRQx/zcFa/AdiHWPyRJ+UFAuXnJ+yD/DzL7z5A5DRsKxaFVrcujBcxOmYp3uP
         YeBk4FRjCT52UsxwEj0Nxh7Qnn5MHAQOjeYpzRTkJ8s8B8LxuL9qZ6KzkCYoWa7a3y+n
         edEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771545616; x=1772150416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        b=R88Y0q8z0dHcUQAjhtFOXxB0v/Ng+vorKWHgapGefvZBQgIj80kHHJYEmz/Hu8cj5g
         1FkoZxpF3jwLYVz+/VSa1BVR9U5lSfdUF/yFHRAKfo7AkW/L7KE44y7q6dM01iq7WuXx
         x03Fa8zC8rsZLVBFG0l1WDwScTLw4vEVAcfZAIi1HvWuXiKXCGNZb4gMqwuOJrbi0BGY
         UuE/iV553N4Ph3As94swqTEcdGTKLNmwnD6S0//kuBCoWkjRSnZETJKEgc2/hDFVnpRF
         3XMjdq013lH7ZuTpXRbuiXHRj3pyOSrgmLLJT0x9pPSK0f/Fgb7qrppNT7++zXnWboeP
         896A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771545616; x=1772150416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        b=YvitRcv26DfJCGjFwkhDrmsoM8BnGKwtkZcqkS82aOKWrbj5grY6VyHPB/zYWVFMiu
         YBuMFOlU9eHM+FE9yWWebv68HZD4+EEXm4AJ1JRRArgR5yvbcCoLVlTPLV6vkYkAUBjd
         TKKDs8IvEINorQRjLk91KbvqYeYcPD9b1IlSQB8lTQ0ZQgReMOOQpAv48aimWUm6Z9cv
         MMsfwtv9mb8sHUaz1BbctTUOii0GDCNv4ZFwr7Xcmo8t3cNZrPfLybVd1O6BFOIpgXgw
         vsZ3XxTkQHI2d4d2vKky09NI3NA6SgtG5c1bJFkM8EuikBAIwQSW0/jby3WDWUsIlMyR
         Cp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8SFhUuYMNmT/b6lNKrcKLo0/VkxyOvAfF5CHlrM7+PHZf32g1AL8PoWfl++/ioFOtFJtykhGKGGBjUquO@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYQPw3yvZyJ3n6wg6UV/uGYRI50gHp5F5L55rBT16Kif4ydks
	15j/OZkypY56fEeKXhhdpeYob98K4licvIttPY4NvfPPTR9EIN59AwJVhipOHWx9AfEfaFxcEb3
	5NWZolF2Q8m/uesEACrVn0UrN3nffis4dq2fq9sQF
X-Gm-Gg: AZuq6aKJQkDdxSZ3YF6h2dLGG5VR2lAQtle4X/1b0tJkPLZG+ww6GGrycjrGdqaAwW/
	Kfw29xBqN8vL32mie63xagqPLr+VHUNuaXDleghhlWAHVy20dzHgSNrayk0INDrLL8X1aEhW88V
	a11MIU8RwBENHSZWeBSOFpJQxfai8sdNhiJSI0ZCcTmmXJ648LhlIhDzZoQpWJUN0nW5cANzLKm
	NIzrjyhPkW0gG0QbKWGBUd5vnQJ+y5R/sVEHQ7IAWxDLn0KWDF7Iomgkrhq8AGvvseTDMGr/Fu0
	ZQeWV3I=
X-Received: by 2002:a17:90a:d890:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-3588916c4d3mr5800139a91.27.1771545616313; Thu, 19 Feb 2026
 16:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com> <20260205-binder-tristate-v1-2-dfc947c35d35@google.com>
In-Reply-To: <20260205-binder-tristate-v1-2-dfc947c35d35@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 19:00:05 -0500
X-Gm-Features: AaiRm506Y2kfbsAw5yuSy39Cc7BbQ8GnxyExl_UwkT36VTmOrXmenuVrilx1Qck
Message-ID: <CAHC9VhQP3jz-RbdZczp=FVHphu55ddojEmjkh+U5m02AdPiDJw@mail.gmail.com>
Subject: Re: [PATCH 2/5] security: export binder symbols
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77754-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D7496163C2D
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 5:51=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> To enable building Binder as a module, export these symbols.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  security/security.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

