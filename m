Return-Path: <linux-fsdevel+bounces-76955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG4uOLqqjGlasAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:13:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16B126042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C3230226A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABC33B6EA;
	Wed, 11 Feb 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mOxp+HXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667E3195EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826416; cv=pass; b=KkvBxH39k11Y9C82Rydj2b/piWn3NU0IakCguoVjpMPQfQUq5/LTAWLOL7N7qvV7vx4vVRHMTuJw3x/YoWo1vefEf8IuuorpmqsNLxYe4J+prcj8cEbzdCyP4oCyMKE6DeMpdtqoXKawCAqm0HJkCiomNY+ObtV9fLE/4WTf3Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826416; c=relaxed/simple;
	bh=4YRJEpkYk10MrpePs+EsJU6z2LMbaXxicS0ens+e2vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw0zW5KuStc+mViivWHHooRahaEjiPqlpqHq9ZQQoOzYnp0KtVKKKtNdRU2RlDBSh9sJuUEMni1DwHFvyuu9CKj9LrefNJWlIldlP9u4S1cRUjUtdCORWdNJIy7yTgtDfIN8XJUryTIFR5xYAcDzb7rcS5Zb6vn++lOLDWQq79Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mOxp+HXH; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a7638f42so732345785a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 08:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770826413; cv=none;
        d=google.com; s=arc-20240605;
        b=ke8R/6PAgY+sKpYG9XgfQMNwKN+fL2PCSSctEhnkaVzEWBcXMe0dcz0X8el6Z8zmnv
         9Bc2EA1r/rwM6RMWFXWRgJ11Wr7v+hAvyAGnTfKySuxqk+q0ymXX6Bw4uR7VBACy/UBd
         sVABZpwm22peszChvFQuOec7jDUCiTzqVHua2AN5iuD68qOXGOxivqc9+2OIhbALPn6r
         R+QL/Je4LvlnQUeUFrgEHyKKFdBNSLGxsImnJCRuu+LwsPpdb2qpIxE4yf07hGbUfRq1
         PUhHqQ3iqq9BwnKCBmLUP7zArIzC+u3SfWI6yLSuZlVNDhj6MXSS0TrXV9RdQTptavCb
         SEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ru1rfjW6DkSjDzXjD/NUFvCPvSD431Ss6XEZlOD/etc=;
        fh=Lfsp8zxslQqV3ERgAXRKRXbz/wI5BqE0dNwwjO03eGw=;
        b=BpErvEDz6PQgiIKOWl2GO1YCo+cZvvhLIA2yevAhBlNUK4UT2rf/wqMfx98u3i2PRS
         RgqNMPVSEHyCMV/x3GKcSgRH9WrDedm8qUrUFTQQmjhc/q5PhvxKX8Pur4+RGGM5YLgn
         OnsvO+5h6Vrqe2Waqx2fQKgpRaGMEcZyxCWXjQYrSh/AmSUeufnziFcTsA7r41cikRYz
         uPYqj0U7z3DlWPDNhxj/ia7OrPDF1DqvRosM2QHYlnVsTd5yY+O6s7gIsM2+w3W1k5n0
         jnP6yBmJ2O53sZvuHRIYkbVkpNB3pHWd3h7zHPc4+nTIGnZjpc9eakrzEQ0lePkNQX/W
         qYfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770826413; x=1771431213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru1rfjW6DkSjDzXjD/NUFvCPvSD431Ss6XEZlOD/etc=;
        b=mOxp+HXHr42kJUbhELLBwmseBeNfPnh15LvOcQygHYVAbRlCqhO8I+cqc29MPZMnh3
         oNLoGUi7vwvCgw2G0W9a86vSzl2YulItR11bJv8zkJhHrr9KP1EPfsXueUzTCBHj69YO
         pfv2fx1dUmZLJo8HRX+9Ah5iKUZGvcyMVb1fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770826413; x=1771431213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru1rfjW6DkSjDzXjD/NUFvCPvSD431Ss6XEZlOD/etc=;
        b=IOPwJYhK6popkJ0g+Z6INKG0lG7MKx8fqiV2QkfhNbTMyCLzO2MId6IFOMGgnIWwrN
         EqrDLVtRJ16o3EQivINkiSkcjMiKUH261x/mNpLPnlVz9BDkEGf9jA9amsr/m9mmy/AU
         Cvz4POpyOqViGmuvDb9pC0jZ5xvlInGOjLJf9++5+UtqEIIkaw8UQZuqUAj4MKVLfXOH
         fnDhJqJmk7TFcNZQV1/2igtiqJOveINehYjLht7PZx+a3Eh55uTjKXAzfLUymQ54Jh/l
         dyOysytGkurFUm2Ure+VGfXJkr+AMMMLFm6R1b6TYpQueuRhkaOgsaf0QhMZAjrEWVaj
         MeHA==
X-Forwarded-Encrypted: i=1; AJvYcCWME06E5KwxeSHDf7EakDUcLeprH/uFSB2V8sG1iGNaX1LxEHOaqSyRakiV3WPZkV6G/Bsl5ZBHFC5yo4Hp@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5yoZnWfJwccRa+LzWbdCsFQehIJag9aDMgsFMOu12HEEz9iR
	FMT51w55c2JXJW9cNZZ8LzIVLYUvfy4RPWYD97iIu44nh/7R+Pf6JdOxAc/qeY6nicwsMRKEeax
	MZUwdn3iphfsRea5oC8nuL+VRDVSrd7D5MiEGdcyW1A==
X-Gm-Gg: AZuq6aJ/eF9FMk7lkvi3vEMcF1YZGy13KjVQpagUcLUUmzawN58DrPbjmLQAvFPp0Hh
	cczcz3Oj3TacPDVW+bG+UyNrSoOJQrluRnogGEZg9P/solrmVQxEPYpOrpKI8XS71mn5TU1WtAp
	Y8W485KIID3T33JFG2SZV6KW/zEdRztZvlPuA7oo0DWBLnvhFDjFWgadpFwfG1ASZCSexPa2N36
	u3shhGeGqBE8QwrMKUzwiDjKtmJwUZyowIxnQxRMvpQe+7AwAe7QG6KNNTOWwJfn19MN0w3Qfsg
	N2iVjw==
X-Received: by 2002:a05:622a:1981:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-5068128d805mr46297981cf.80.1770826413319; Wed, 11 Feb 2026
 08:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com> <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
In-Reply-To: <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Feb 2026 17:13:21 +0100
X-Gm-Features: AZwV_QgESJTX87Auw0wEyRmYr42QEETuuwDnaEo1bn-7_xIPu66b7HBVBONSakM
Message-ID: <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76955-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.com:email]
X-Rspamd-Queue-Id: 4B16B126042
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 at 09:46, Horst Birthelmer <horst@birthelmer.com> wrote:

> +static char *fuse_compound_build_one_op(struct fuse_conn *fc,
> +                                        struct fuse_args *op_args,
> +                                        char *buffer_pos)
> +{
> +       struct fuse_in_header *hdr;
> +       size_t needed_size = sizeof(struct fuse_in_header);
> +       int j;
> +
> +       for (j = 0; j < op_args->in_numargs; j++)
> +               needed_size += op_args->in_args[j].size;
> +
> +       hdr = (struct fuse_in_header *)buffer_pos;
> +       memset(hdr, 0, sizeof(*hdr));
> +       hdr->len = needed_size;
> +       hdr->opcode = op_args->opcode;
> +       hdr->nodeid = op_args->nodeid;

hdr->unique is notably missing.

I don't know.  Maybe just fill it with the index?

> +       hdr->uid = from_kuid(fc->user_ns, current_fsuid());
> +       hdr->gid = from_kgid(fc->user_ns, current_fsgid());

uid/gid are not needed except for creation ops, and those need idmap
to calculate the correct values.  I don't think we want to keep legacy
behavior of always setting these.

> +       hdr->pid = pid_nr_ns(task_pid(current), fc->pid_ns);

This will be the same as the value in the compound header, so it's
redundant.  That might not be bad, but I feel that we're better off
setting this to zero and letting the userspace server fetch the pid
value from the compound header if that's needed.

> +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */

Don't see a good reason to declare this in the API.   More sensible
would be to negotiate a max_request_size during INIT.

> +
> +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> +#define FUSE_COMPOUND_ATOMIC (1<<1)

What is the meaning of these flags?

> +
> +/*
> + * Compound request header
> + *
> + * This header is followed by the fuse requests
> + */
> +struct fuse_compound_in {
> +       uint32_t        count;                  /* Number of operations */

This is redundant, as the sum of the sub-request lengths is equal to
the compound request length, hence calculating the number of ops is
trivial.

> +       uint32_t        flags;                  /* Compound flags */
> +
> +       /* Total size of all results.
> +        * This is needed for preallocating the whole result for all
> +        * commands in this compound.
> +        */
> +       uint32_t        result_size;

I don't understand why this is needed.  Preallocation by the userspace
server?  Why is this different from a simple request?

> +       uint64_t        reserved;
> +};
> +
> +/*
> + * Compound response header
> + *
> + * This header is followed by complete fuse responses
> + */
> +struct fuse_compound_out {
> +       uint32_t        count;     /* Number of results */

Again, redundant.

Thanks,
Miklos

