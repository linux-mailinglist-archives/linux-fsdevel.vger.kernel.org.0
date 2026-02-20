Return-Path: <linux-fsdevel+bounces-77788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G2iHHA8mGkQDgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:50:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CACDF167061
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B2843014883
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFB33DEFA;
	Fri, 20 Feb 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw5VX7pE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF533F36E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584613; cv=pass; b=atxl3Q87TJTf+38VjFZxU7WOSZGwOf3g6/d/u00YM2f50wQcztAwZUvk3SmIQPPLbvWxf9lijP1+UXAvUapterJWsGjQ10wesHpqWjLzjIBBSYM0pyS1dUHll7HjdMcyou+XY1UnTUlYKb8hqtco6/NzIRd1UbxuyLnK7sqJZHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584613; c=relaxed/simple;
	bh=oIngJ6S5SUKbvESTbw5vt2bQmTdKhr5N3+wDe58Yw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWEcQhxWZDmUURa7DAR1AtVQTOo5Mq60QtuLX+3q264G/mGJZHMt++cd2tjbadBx2MXpCFMR8ukoK8TNigcOXjgVTdRFDXolegjt1VoGeMOjuFxhz+q4V6/Wj8/qpyRPhjnzVWCJZ0+DZB872/lbit1GLZHHVnMqYQJD0jB3Ekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw5VX7pE; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43626796202so1760812f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 02:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584609; cv=none;
        d=google.com; s=arc-20240605;
        b=f4ukev3I+MVLUbN5WOnkVTC/52X/wYx8b7mlidNrtPdGknpzgDbJHEn8C3QfnSC9oD
         1b1LKDF3tyDTdnJcIiJM/GUXDC6D3sEP8gLsvhtNXmU+uxBP91f7/ENqsSCPUb0ywDC6
         XmdqbmMbpwU4lNBrB14ObRPr33hmlfp5cUzbV/YLvcWgbkFqdC4NFkiRvAcYgv0W1SLH
         FhqLLPAYt6F520mARoTllF32j0G7Menm2LIIXIr/53hg+bEr1ydkPM9cU5ifJxjB1AIn
         71YSrISQEFeWb992o6kvJBa1QV9Qq3QuHAx4kAju7nYNmsRtvZizTwcv+mBVvw2axbVd
         umkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        fh=uSwXSrd2U1pUNwfLl5LCMh4t/sekaxNk9Pfp2lb61IU=;
        b=i8b48H0TdYcphDW/AbkJkHoMXFqTcnJUVHHFliHjgZWLtBB7FEQ+xTVHX7FRxVH1ml
         QFt+qu1v5kE1RmM8DUP3XLRNa/WopVNNxzZSOQAVeLbrbHt+TpykiDnWetOGGmW62ahV
         AP3SsRtQINVZpa2J/do6MEiXcogvKUU9/+vwfuR9Dl2GLkmFPszwGFBJCiT3MG807GA7
         OLR0fdiCqdEfsUHCY2Yriz9EI9rU56AVCoKEqe1/OR6G9wOvgoz14APBDe4OTKmGCb9t
         U/2O3JhBdeQiX2RvAeRlOTgseQxmMftnae2U3Yi0ivkP7gR75AIPdgkrRjSlXSetkcNq
         ZWZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584609; x=1772189409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=Yw5VX7pEPoJ07tsHwpMawPnFDCOeML1UTczylvi6vDnvLR2lMcFPsCceidZjis8UxC
         BAbrl2E0tEmKWqk3oaoX5lwhugK2JWB7w2OJjWdMIYyrSGW3s8aCs4pFQz/dpxKIZVRg
         qC8n/ReAEQaZIeA2dPtE9fVtrdFbXy58czdpdEtci+SOzMAOzH2OUtDP1LaZmnM5RwAl
         YPS9Oo1UKkDV3eAQTRtxZdcDd5PAvPderl0TMky21ELTvS7wkRWfXHix76fSeudRPiLX
         LbBZU0bVjHAII2I2QnxUONMUCt4kjJZgl8CPHpCzGP9ky3278yHP3U7DBx0/bXSVTPB1
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584609; x=1772189409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=daj6sW4LI2CRwu2Ik6EHy0JuctYuYjgDYZcnlWhsad615We7M5wCuf5FXGG3gUV65Y
         opFWDp1z0bD3vfhBkhHPNOANVwtUYVjBiKlShXgDAgpeiRMDwh9i0uiwR3I5NC0cwgnW
         bA1VjucIKfZL2Dx/UjzhcqjZ9/GYgpnp+nn1rohbyxVDMO6ampibVdXc4MASBQXdlOee
         BVjK2LepHlMEvYWh6uOjtEdg//Neo76fYyge3ORo8coxmAkF2ZhesI05HPPCzaSvpEA4
         im/6n1UUIkRpqrrtp04iOCDgbAZrrXQxpoIq+9vM2XPjg78ARlqv3EwDWw/WEbCi41Zj
         +rxg==
X-Forwarded-Encrypted: i=1; AJvYcCUFN9dQgPlgu1SpEe0/q4Q9gyWX/Bg9AjEPBzBW0Y/dJRnBUs7tz7IuL306SeFAkJuQGOVSeumG70dsBxvj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdt5rgk4ZuqNuygjdRqUrKKwG5hxor4bjEAMRV3p+gpq+DrMpe
	4PeNTfwtvXJIR0ymDRZjHe/c1BIz6WCgOQRyr6TDgbd6327geBOpOUdONUjrITjEwIZ+sABErwF
	A7RnisdvdKKq8q2fzAUXugVx8yjFXHnhTd7hRS3/B
X-Gm-Gg: AZuq6aKfTmae8d7m0DzN3+joOPPLoHbYE3i/ujee0eMnBvRTh3zIu8UcweWjwqkN86U
	eN9v4hd5EgJX2hlFjFzRkTJ1HnCbILi0QzddiiGyIjIvB0ddQv/BlJxZGoJ9tcA9ynHioCcaW+5
	8ryLqhBQoUmwnrebZEYKYXswphyQEVExGGubhEIZSwIxcksKg767PAlmr4fIobiYeP3m6Gb6oLd
	rWQhKMbO2SoKF7NmS0KxvcMYSPosWx2VAUZImVfsu7ZKVW3Xp0QnwIo7v55bfxxJn+I6y2b0LoD
	luJW5PvBzL2mkscQYZZXfIQIwN9u/8xdeWNmSA==
X-Received: by 2002:a05:6000:2409:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-43958e00ce5mr15101201f8f.18.1771584608836; Fri, 20 Feb 2026
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:57 +0100
X-Gm-Features: AaiRm525n9TXR47KvplRQPUHuuUwgU5iN4_ng3kUHWK8LN9TrQcHulfhA1IhjZ4
Message-ID: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77788-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org,pm.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pm.me:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CACDF167061
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 61caddfd89619..efe16a7fdfa5d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// # Examples
>      ///
>      /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>      ///

Either keep the imports visible or delete this empty line. And either
way, it doesn't really fit in this commit.

>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///
>
> --
> 2.51.2
>
>

