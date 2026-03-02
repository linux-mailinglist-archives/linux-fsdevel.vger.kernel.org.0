Return-Path: <linux-fsdevel+bounces-78886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDqOJchupWlXAgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 12:04:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D851D7281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5BE4302737B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB535F5F5;
	Mon,  2 Mar 2026 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cQvzcz19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1611A9F90
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449430; cv=pass; b=GTEJwSln+eBZvPi1Ti/pbBT2EMEzZlFzvARawE6MxRDZNOelsZzXKmLDv8Z+6jnEI9jsJOSN1zrU2gMbNl+I38PfRImoM2j2pz0QXUpNMyYqGXtx5ntjIuYITXr3H9L+kn58YG5hUS5ZLwebUSOCaC/he+6YE2wKPtNVEWdB9LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449430; c=relaxed/simple;
	bh=4PJ2wYvd74kLBVfHAFodpvqAa/Ji/RksEvHmYbzzVGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4HtQ29SW2A0zAXv37tKEqB0PiYvwm4jjTn5aoNTR71PPSMbjTxyVlUiQhIBX9vkYHtuRhwKtmBv7XUpyQLt5x/3kJcuDh5dEA5hbd/ogcqVYdBwH2lq/IlPkm5BaOenbOxJPuLwUsKr4VWlvuk608aoA0e/zIq75z/hkjqgvto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cQvzcz19; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c9f6b78ca4so582331885a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 03:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772449427; cv=none;
        d=google.com; s=arc-20240605;
        b=BwyRiHPlwyNaatePecCo5HY5yxH2SRmmkE/hpCEEcxe2o59xsa80PRZMYVkEUwGqr7
         aE8JEO1sZLfEYmeVbTrmsPk1BzZ9rwwBXJPCLbD3kiYjyvsl4wmfTQq/ltP67mlJDw3R
         B3bqhP4/XmAy6jsWN7ERDmYhngpMHijfI7s1sHNvrWJ3jPhB71ie4XkSMADUCrp/kS9i
         g3JQF2NDrwLv5z1S2uxg3eiRv0hWEecvYR33YDpDSgjdHWGw76ndGXVIKXK0bqxZ3ebt
         MAMUmtNi9gLWTOc3ice8DNcls71N4IpjB+jiwUbQQSeHl4W7RlG1LM66j0VGxCgMQide
         YCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=haq4kSfrMicqMD2w29m4D323S5kRpC4xfsmcuVYeIWA=;
        fh=IUM9EisTrSMcCikS1OdG2jBa58OAVI/C4cB2CqbjBV8=;
        b=e0eOKQQqHqYjo5otpMWwxXRCq7/SDKAxLN9pXHJOcz5dqw8xWkFQopQo0QuVKmlW/g
         MuncxrcqxT8r/FNoJxQGctK4asf2gwHgDEksUFg++s+Tyw5W9NUsTkdnmQ745c3ramIR
         xxI4Wpqo0CSCIwVaBZhKj728fHWCRyhFTrK3YRgT1fQ8ivDOqYy2j+kdngoz60kpMJ4Z
         Bc9WKTAtwBO/AcQUd+/lUarhMq08U8zufdspUcdoToA6T4hyoiT/YYAVY66E4A5eQ7xv
         yjGnbFluTCoHF4CDFrIBIODVyFtuQwQAuO1v7u2t1x0jk8K4EVpby9HcvYadGEDdqNHZ
         FS2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772449427; x=1773054227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=haq4kSfrMicqMD2w29m4D323S5kRpC4xfsmcuVYeIWA=;
        b=cQvzcz19lt09fT+MST+TL2VXUfc3411Ie1nqjGtk3UxdoBb0eOEhWVznvcrYDVy2ky
         OJCDYwxsgAlseSFbFCpaUpPvv5F3YQa6nLZN3bzENXzs2SmbxqyUP7LOoKCeIzQK9l0O
         dmSR3h7SKBT7T6ZhwBZJs4rdnFeN6Ak7y4qa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449427; x=1773054227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haq4kSfrMicqMD2w29m4D323S5kRpC4xfsmcuVYeIWA=;
        b=eAEKGgYmUxpYV+MUViNUI2L1aAlVjNgzu2/vnakEbWl5rhQSwngTGDmCIuSgRu0rLL
         MgD6c3jkv2WnzbqKo2MVosFizheQMnYMYbPkK2FyaKAsAZaNJkBr2AFi0mf2l0jyXHEq
         i6eklYfE1thbQbr/8pg/athenKAILdtyEAbdzEoRtUHfKn5s81c5HAHnEymtCWuzYXwS
         CxPt0non5M9X7klR5h+h0g7kjDc+fg97SRYQKN3p1zewsoLDPeHxt3eb0xaXmk0fBYDf
         iabwWN67qIKcCaNUQ7Q6dGdWAtoXoc3/rrxx9KSzjG8BZnM5B4oV83GAxVyTN9fymJKS
         WhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN0KVAeWO8un2LVAyPkIr3XIUHCPYTAlm2ciAFg9XnNsCq0D3S9DKaiKQMt6sKAaU40zut+Z51I1MUZKCF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WfuX1ezIOwgfSmx/+ECr+5wD7GRuCFxNMULROsscRkK7UGFi
	YqsYms+yG27EJxURE+8LahUujbZOYoV40M3PZFfCjtK9JYiX4WFLJPKiGzNC97Gpx3TFY5wiUm6
	8MS0tUTpVwfJwjzewv/tl+H0EFrsw9xmVA70ienNGtw==
X-Gm-Gg: ATEYQzw12oG+9+X9hYhoQCFMAElBFFJjyRvD02efVodx4U7EwDHXaAt2q5Fp32Ao4zN
	6HyX+KXLgOU4IkXwLiw14BO0b+33RLmz41AUj08fj3K/RqY6htqZlPgmoWQlskgxp5QE/nDVETf
	mDmPMzfZ57CCfTfGuCqAyxc4LqPJ7Uf3gTDuCkkQponFpl4oD1z0Zn5XfW6f7FCYA7hJA0u5kj3
	MferYkL2ttW1uIVBYguCfSVjOJbIYKA6amNI4mClDjIlw8yYdY+ev9DuRQgWQzYk46DrONJEmqi
	mFd+15kv4Q==
X-Received: by 2002:a05:622a:148b:b0:4f1:ac12:b01b with SMTP id
 d75a77b69052e-5075284a74dmr167728731cf.38.1772449426878; Mon, 02 Mar 2026
 03:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com> <aaVcSK1x7qTr1dlc@fedora.fritz.box>
In-Reply-To: <aaVcSK1x7qTr1dlc@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 12:03:35 +0100
X-Gm-Features: AaiRm52lRvJ3k9NnPWPQ-exlbBDgLA4Ks_5jG-9P8oYPmteNtBwgBYyylu4glRo
Message-ID: <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>
Subject: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78886-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 01D851D7281
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 10:56, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> > On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> > > +
> > > +       unsigned int max_count;
> > > +       unsigned int count;
> > > +};
> > > +/*
> > > + * This is a hint to the fuse server that all requests are complete and it can
> > > + * use automatic decoding and sequential processing from libfuse.
> > > + */
> > > +#define FUSE_COMPOUND_SEPARABLE (1 << 0)
> >
> > We really need per sub-request flags, not per-compound flags.
> >
> > I.e:
> >
> > FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> > success (nodeid, filehandle)
> > FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> >
>
> Couldn't we just save boolean flags in the fuse_args?
> Something like 'bool is_sub_entry:1' and so on?

Sure, that's fine.

> If we have the automatic separation and call of requests in the kernel
> when the fuse server returns ENOSYS, I don't see the point in adding this
> to libfuse as well, since there will never be the case,  that kernel
> doesn't support compounds but libfuse does.
> It's either the fuse server handles the whole compound, or the kernel does.

No, I think the library is in a good position to handle compounds,
because that can reduce the complexity in the server while keeping
most of the performance benefits.

> My point is, we don't need to send that information anywhere.

We need to send that information in any case.  It needs to be part of
the matching done by the server to "recognize" a certain compound,
because the same sequence of operations could have different meaning
if the dependencies are different.

Thanks,
Miklos

