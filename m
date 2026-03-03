Return-Path: <linux-fsdevel+bounces-79255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK6ONJ39pmkKcAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:26:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A11F28C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79D51308461D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F693C2769;
	Tue,  3 Mar 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpOi9oZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6D37CD5F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551079; cv=pass; b=VW2hbv540lwkySxl1tHB83Kxsuf+FMIKyhhc+/Pwf9D16oOEw06jNgLIXjrBDt5zeDzs4uTxgODjvfWNcTXOLL8Skwqtvpd87Ns1WjLUT/x9vv9HuqvhEl77STslm2SFlf1FI1sg0VwKA0Zsx/dAGTslupPjvSnGbK+GYfH0uBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551079; c=relaxed/simple;
	bh=V7cDnV3OCczJwJVI7X5srk8jXN+LiBl/4vqZfymxiLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4gWe25SQXGeH4NLTTuWZIof+sr+7N4duX8AHTdJhfJyAgWc48fqAUu3z0mov5nQvDAEmoSHPV7vhRqwWXB6A0O6OdolpeBDVIL5Q8PAm7oASNpVFlTGqU2NCrfBUOBrDc61GP26jvpXN8OAhiVPMm6wYoYhkSu5P63hV1QV4uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpOi9oZ1; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b936331787bso936352866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 07:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772551077; cv=none;
        d=google.com; s=arc-20240605;
        b=BWFXgL3R//bpC/mU8JpPspyKR0sHk0sWlSZH7UvoNiDw7QlRoOIhfT6AxhIiJYaVGl
         ox97GEzmWjHVMvjsfYIQYlq0ZUlcRHxpCQ9kmgrfQKOhLZa4esi9PHT3UZPEyLHeoy2p
         qWc/P2MCMV9VcqUjC5NceqSK2Jo8Xrug3Od6X/jzul4QzAvStjvS/BXykbxjApJjoNWW
         Nqv+272bix5XgxXVsAZhDuyd74EfjW1gYadixX0j2oqC8cEK8Nsy7tl0Bub3Ly98QV77
         CB5w3EtRXfq8Bwv7yCamlZcyYDwDt+koppFMxMiRAXFi21tbZhXzN1ToO8lwvdKZJvq0
         lH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V7cDnV3OCczJwJVI7X5srk8jXN+LiBl/4vqZfymxiLI=;
        fh=WeSv6vDMrA+Hv50PE5hbnXp8j/0KI93kpc58cwsTPGE=;
        b=SqGwtKgCIU5wqjeXPlKkI9hyNkXw5it+IQ18xRygqOhHL3kzG13Mrnzcf/B5veHOfX
         Na7ZeyPQy6ikmqCikt31bgA3C4Q9HRPYTkHXvgr4OXqhiRVPTdqagfcQqPOud6KrdOmC
         xgkY2qOo5WnTLrpusefXdPOHmIJU5q/4JcmyNh1jdHVYAJZLK/Lq+/0ABzGrMNZIiQWS
         lw2Va0kYRDT983K/NFwhqXneiX0Eaob+Y5AgBp7pY47RYI4XGFQP5JcKhpdVxX6dGVc4
         f+wdoLbzA/cbi8IpPlcAO3DF8ZTJrJt7jL+f4m4Mvtlx0UY+G0rKntMdlZpTFbmsozCb
         1Ipg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772551077; x=1773155877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7cDnV3OCczJwJVI7X5srk8jXN+LiBl/4vqZfymxiLI=;
        b=fpOi9oZ1P4sll+IvKQOVtYa5RnMmj3esSGjqENZWJN2zBtOGcRH33Snaeg2YLkfo0u
         XvPwdrnDhn5C/ow2NGomXAKYLKNM4SU9oqif48VbHNTv8cAvIKzOYJjtBbA2B8y/aWXy
         PRP72P8uCXvub8XA2BVLQl+MhgVJI8idEHt5wzyY8Du7WDaNbytcMWv+c8m1fCx2Izpn
         CaV3NtuOHhHxUzEc64A5a/tWAd+fPDraTbYWXj5I5v/3vc7qPfv4ZyEHKa1a5GK3rJgq
         rfR9MUL+TonKYUe9yBsueWkxyOL8iPzEuQFQp7ZRWPljaXv1RVJr533HfTcYqATWIDBB
         HMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551077; x=1773155877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7cDnV3OCczJwJVI7X5srk8jXN+LiBl/4vqZfymxiLI=;
        b=A6tYZRlKKxjprOYgehrocfOAQW6CVj+WKsxmaFt/ocGgl5RPh6zcl2phz7y+XTKH7b
         sKj3jPDQtNmA15EpWoLQtineq71GzlpZq83fz3c5vxGXYJZcxUTRGFQ6NW/+DrHHhJYn
         NpJYTE8IqApv2sDxg28vuefhTFde5LC4Ir4z8pJkiiOG16k4NX61FOrX3rN4qWrHq6zl
         U8LqPri3xgtmUmpIf6wdJVJvco0YakS5Kthj74L9jpsAFyhFFfh9TJK0R+MPqf2ZSrKW
         ZYiOWweig4LUxeLTTSxeIU+4hyKXam+k1wbMmYKDtVYQc0A/n+rnjjKED8YvRd/xYPQH
         2ODg==
X-Forwarded-Encrypted: i=1; AJvYcCXGwrppb9LvBtDjQdHEfToGaYglZxfFYeZ6zxwvxt8t2eY6AYaYUZhrnsL2Pphvs/wc3G3m/iihfv1+PMow@vger.kernel.org
X-Gm-Message-State: AOJu0YztlHM/93CT/Lw/73+XDjNhU2NJSa3yBI9oOTwMf9k+sx1ks8sY
	JDf9JduS/h4/z8eL+1dc45hTU+JpL7v9ltwrXcZgBFk9nCU7Lyzz4Z587NMzNon1vs4p9P7nli3
	VgGF9mk+nlFGcDhI364WRvsu524xfNAs=
X-Gm-Gg: ATEYQzymsG02jK1bHZdou9ksfRxJYqgBb+wciDz2ikdhFN+kxa7K3dCtKrvh+JRkN5H
	yMkHiGStC0YuizWndw8lhYXaIrqgGB1U2OtuI8NyWdndyaLDKCMDhirDz31MVcnxDIqBDamG++a
	jjuSivTSoWOlSuxRnKdCh8wrvsefFB7rTmCCnIe9CLDDSYOjw7fQevnCp7y65kKvueTQfD/mOw9
	VMqW9VWT9KNizu9p69uks3Cf3AX/+FTjCe+WbbCoYQxPdX2q4YkCzvjkURBTKjaCgEJV8SkIM8p
	IH9vElUsUz7IBCJftwuTBSoXQiQXN2uYw/B70htQXQ==
X-Received: by 2002:a17:906:fe09:b0:b93:6bfe:4f2 with SMTP id
 a640c23a62f3a-b937639ba4dmr887545266b.17.1772551076242; Tue, 03 Mar 2026
 07:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
 <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
 <aab3haz7W4ZqTT-3@infradead.org> <CAOQ4uxhZHnSDJbLwvymJqkqKe5XhQG_W-HSNi7MnhChvuyK4vA@mail.gmail.com>
 <aab5JKLZWR-sR1cy@infradead.org>
In-Reply-To: <aab5JKLZWR-sR1cy@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 16:17:45 +0100
X-Gm-Features: AaiRm50Yb5OgQx9or-QYLNOY3Xx7oDVyJr9eVOz9gyp4q8CVx6KqlXVqq-T53EE
Message-ID: <CAOQ4uxgFwLvOaVGdXBsPhOvfDBVk8wxHuMbCOL33K74FUuHfGA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D4A11F28C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79255-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:07=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Mar 03, 2026 at 04:05:09PM +0100, Amir Goldstein wrote:
> > It may sound like that, but in reality, it is quite hard to differentia=
te
> > in pseduo fs code between creations that are auto initialized
> > at mount time and creations that are user triggerred.
> >
> > Only the user triggerred ones should be notified and also we only
> > have a handful of pseduo fs who opted in so far, so I think in this cas=
e
> > staying with opt in is the right way, but open to hear what folks think=
.
>
> Then maybe encode that in the name with _user and _kernel postfix, and
> also document it very well?
>

Sure but _user vs. _kernel is maybe not the best terminology
it is alreayd the case that dentries could be created from _user API
via vfs syscalls.

The code changed by this patch is specifically code that creates
entries not via vfs syscalls, so vfs code refers to these changes
and _kernel changes.

However, they are trigerred by user writing something to some file etc.

Calling the helper by what it does keeps things simple -
if author wants a notification, author should use this helper.

I honestly don't know why this fs opted for notifications
and other fs did not - I assume it's just based on actual real
world use cases, so I'd rather not change those decisions
with this mechanical cleanup task or with an "alluring" helper name.

Thanks,
Amir.

