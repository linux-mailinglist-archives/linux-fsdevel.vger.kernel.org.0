Return-Path: <linux-fsdevel+bounces-75802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCzXJw16emkC7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:05:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40357A8ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E806303265A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647737754A;
	Wed, 28 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de4DuHaT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLp11ugg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DB374181
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634291; cv=pass; b=Twi8lJYMYm/S9nfZYVJyE1CqPsJKPvh4DDZPo00xgniiDhpC3dPLcapR4zGqYaEpPMe1xABv51SzyqjBzC1lG6Mf7EYRH9BJqfVFcBpMRzMg8jXs0Nl5+whzsq1RcYm2fRjHRwu+9asRKO4VhUaeom3laf3xroiDRwIy0OrsSus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634291; c=relaxed/simple;
	bh=1tw8rxb1GuOoCN0wlxjcsAj+qs9gRZdD4TNyCtxunzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QckWdGG+5eAWNgddK3RNkPeA3eQKpwNW+c1Lz7hzHVjDlraoYilY37+6rIF7DCfFKl3MH+k59L2WqSsUZ8k1P4XhdomxwWMmnW2sveSQ1C89BtSzTFNp499+PPGw3UkfLEKVItxUHqFRhHFp8O6zQ/wYqQJtJMmaGKvEbUg/Cc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de4DuHaT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLp11ugg; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769634289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
	b=de4DuHaTc0OKGeVRxjCHscwYtJwUWZiOx61GI74KigWbTWvfMlwytJ1rSNLbtXVwOEh95N
	S1wN4PQiRMHffINWRVoP7jGS52tSmuhltlcRb06QnPM4LPBJDqZOa5gD9Y5DdAeQ26fhzA
	gZabT0Cc00/9+f1dfyCgy/v7K8ienGA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-8oJ90a6FODOArPsJUdOdDQ-1; Wed, 28 Jan 2026 16:04:48 -0500
X-MC-Unique: 8oJ90a6FODOArPsJUdOdDQ-1
X-Mimecast-MFC-AGG-ID: 8oJ90a6FODOArPsJUdOdDQ_1769634287
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50355952ac2so9550421cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634287; cv=none;
        d=google.com; s=arc-20240605;
        b=fYxrqU65Tp5m3pwqFdITJ83SqdDhfVRzYdBkogokEWYMeEQQu5zm2ZpN4BgAAughho
         4tZDyEOklskeVna4UY0g7iInhwJwjd9/OKMafpZNXbGUP1aHClDcNv3wCulhnt7EVHiH
         zKmaJWZcI8nlzB/5HD9FoNUCyYkZQn02LgWSAKYZg+99GRcOEjAjKBxrAjSJ2c+q0p23
         00ymqOXav8KtR/2A3bBEETb8c696lc4kfk+7RKQBASNcdTj0lHHCyRGWLL28HDGwzRPW
         A/bI5H4wW2VwBuMfj0x2WGlm99XG+kDJMFOp3glhiNQ4nUTjw7HfJ3CLUn3xBlMRd+X6
         iPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        fh=xmFIHURcgrPexAUjSCHCGbEiMf6zFKbN7pZcawLwQrY=;
        b=LFC42Xt+o+rmrVaFDXMUAQyjlJUgCTf+fP/D44ljMshGuCHLVpv2IarPG+1VcNEWAn
         nowTSCR9+okUAj98KPqtdBQeN7jkNh0CpSvNYgZ+bfQnQzVS5n2PwO9O6sxxv9w1KbQQ
         LbqhvPlYzPcQ0OTjEBuNAwkhEXnjHqEVEevhpx3revzjF0xe4E3M+wmjncQHetQB/wtZ
         1OkxAzjPBWrKrkYTnBwutWUtVu/czivVWNT5NTiMtPoNzRx36cGoyqfyr4iWc8VYbeDy
         BaTjFFsYF+vXwjaxsI+Au8WqJ2rjMUM0a+3XnNIX2nSbk0cXdNgEdA/ZFs4ltPUELk7Y
         IDtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769634287; x=1770239087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        b=LLp11uggIgkapT/dBlvre4HZI1xUSfEV/rd1cN12ytm1icK4HUOmYRnEXs3gNT9sQO
         mdHZhdojTcDpK2O3LljwZQmku/Yh9ktk6G/Uu/HTSiQAmZ8M7eQYBpsVr13epHLAL2a6
         bNbqRCetre4Nz5rFxQevwSwPC4z30JPt4I2jbtWpHJVTcN2y5Ki1WHXHgOgk8zmqJUKa
         AwY+GrsXiW4PKnA90gU2cB6xDcNiM7mBtp8v2Yq3ulKPeJIfHWBh3MPzRuyVqJn23DvG
         8Dpu7Cqg4MexrZcgVMxa0/Wab/ioPSL7w4l6sSizH1ED9o+uv6P30+QXDePnOf1Zgptr
         tXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634287; x=1770239087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        b=AxXotVqAg7oL/DknN/k0ne13riIO+T0QvEoZsk0zRsXsbtjkvy5LHp6sf2H1gSFtqc
         uVuAX5OFgrJSalTBpdrUGzdbI1TDvjr96c5DFuE4CC9V3yCmPL1v7ZVGh2ZuJmglh8IP
         ZXUv9fI5Qvaqt2oQ8SrrWsNpI4riLti5VFs3MaMsDV5/GHW3Gu432zR11dTU6EdtNtK9
         Cbvk2llRSAzDtNEx2+GUXzzBJN2I59XvSKZuFzpWLROk2wQToqvxARJShDKDy0eXRqx/
         2rOdgsf5WrfilcRfE13DhdPSNAv2kO5B2qKt6qlF7innrHLYdv9utlluhwwDaULlJc7x
         9ffQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx9oucpr6VjxDvD4gi+AfkFyaZ6WhathBlEse0ealah3T+pGi133WfHCvTfseqwn6plntIz/vkHOKOMN66@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Oxfzp2UQLXV9Xaclpzmav+6xsrXgoGHYPGAfM8Rg7z6+TUhl
	XQTFo61awW5ANIRZwOoFICKclCZPLq4oxdMFwNYrofTFJZWi3n3HtjLFZXWz8eoQECkei1DVjDB
	AlgR9ynK/W7bbMlxlmFtfqvUGRCmCsfFGbbsKJsw0Rz76mXsujT2iVvcy0vp6ATOhCU3cx6ugrB
	ic/Nc+tfqF36rOZA6VzpVru9DfnJrnG6/lJzkZE5qC8A==
X-Gm-Gg: AZuq6aIaOdnvKhiiiEg8TkZD/7XS5aQLW6u6ZvCSmvNSAWoB6sIrVJZih/TWVTIx6uv
	AgjBp/l/lU8Xnipp/cscBzVJdIe6YRq/iE8os96t6j98WX3ir/3DdMc5QsGqFaF6Iyk9s+vnYbq
	jDWHIAadq4AHz0fU2k6cj3KgxMQbMpbgiN2K9xRbY6Arv6XZVaJfL91u8sNpRKwg+vk+JMngEfL
	pHLpGIhsYIM1TCgCpJID/jc2A==
X-Received: by 2002:a05:622a:118e:b0:4f1:af84:f1f8 with SMTP id d75a77b69052e-503612676e4mr11419601cf.12.1769634286903;
        Wed, 28 Jan 2026 13:04:46 -0800 (PST)
X-Received: by 2002:a05:622a:118e:b0:4f1:af84:f1f8 with SMTP id
 d75a77b69052e-503612676e4mr11419171cf.12.1769634286428; Wed, 28 Jan 2026
 13:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
 <CAOi1vP-CAYAKykctYWAQNab7tU93nQQwnobBn3pJw+ZqUJCh7A@mail.gmail.com> <764e96d344ad558ff0b8620b29a427641d52d85b.camel@redhat.com>
In-Reply-To: <764e96d344ad558ff0b8620b29a427641d52d85b.camel@redhat.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 16:04:20 -0500
X-Gm-Features: AZwV_QiLtV6QPz1gjrKz6Ps6NoTyd4P6i05_Yuzl6K9jM28Y4tZcYnfU3Bx6AQ0
Message-ID: <CA+2bHPZMdGPi=g=oXFS38444D1sn_pyg3BZ41_HkZssPET6D-w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[gmail.com,dubeyko.com,vger.kernel.org,redhat.com,ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75802-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pdonnell@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url]
X-Rspamd-Queue-Id: 40357A8ED9
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 3:22=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Wed, 2026-01-28 at 19:37 +0100, Ilya Dryomov wrote:
> > I'd expect that the manual steps quoted in commit 22c73d52a6d0 ("ceph:
> > fix multifs mds auth caps issue") as well the automated tests added in
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_ceph_=
ceph_pull_64550&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_=
RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3D-RKqmT80mqztmazmh-jahx70DEvPkJZRpkLlPXPBvbDd=
utZZKxyg6BDU5Z04AOF7&s=3DflpYs6_1sBk-MBf0SCwdyOABcYR-h7pBadLy1SLyaho&e=3D  =
would be run, at the very least.
> >
> > On top of that I'd recommend devising some ad-hoc test cases for
> > CEPH_NAMESPACE_WILDCARD and mds_namespace mount option handling as that
> > has been a recurrent source of problems throughout all postings.
> >
> > "./check -g quick" barely scratches the surface on any of this...
> >
> >
>
> So, it sounds that we have not enough Ceph dedicated test-cases in xfstes=
ts.

I don't think Ilya necessarily cares where the tests so long as that
(a) they exist; and (b), they are run regularly. Perhaps these tests
should go in the cpeh.git QA suite?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


