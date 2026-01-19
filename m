Return-Path: <linux-fsdevel+bounces-74522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED5D3B6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DDF30D2F28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B03904E3;
	Mon, 19 Jan 2026 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="ZLCChveB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018F38FF18
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849532; cv=pass; b=G5HPC+ne5NyiVOibBwweAWKVzwalKs2h+Q+6npycE05s8qg2gAHxi/KvK3gO3HAi2x0Cf9ZVX8pPVzZh15dPkpUn0QRnJlfJ3p6sDD8YRshC4pgXCDSAobA2oRJfJii+/9q7ugVJtYaHFWbluqkS9jWkFBfoWl9Ki8vsOoG4tLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849532; c=relaxed/simple;
	bh=/ce3dudxc2POARZLcfse5sBstVqNXvQFSe7cYp3NGco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuGH9EJO1SD74ACQuekBl94GW+y5iNzCAuEDxzffPmbuQMzaN7hYdiUfShSn+oKLFTflPKM8nl6Qlw4TMrPHUVBbtoVyWmCiKdj8LReyd1h9UkXm+3JJulfa/J95nOzYTfii3rmVLAF73zzB7CvBTfir4jq9ioGA/2Ith6r+fe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=ZLCChveB; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-383153e06d1so37845501fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 11:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768849526; cv=none;
        d=google.com; s=arc-20240605;
        b=AwDph3ePYBXllq7IpoIj/WFaJg6oka8gdqFgnu0LDv5LTahAbE++QsrMg3IG0m5PJ2
         JzGph/kkoBxfPLZXpohsoLW4ns8F/Axa1myBcjjAa/x3fWy7RPVveco8i32fW6VlNLZY
         7P2MpFCGH15nZuWlG3fOSlxLt/KcwOLVklZ24bJWSFSBXHBi7yg2gLrB62qKLeiFvbij
         u0s6q0sLRPjVwzitIt1hUVHU0SUSXGGBSsnpk9/56jidxnWXqNypKr8wfJoGGeMJsQKs
         MiU2M2mMjCEwIrqyKaWlPkgWf6CWBHBnyaWVzF2WhM7rWYkvbtaHahSxuNYtRTE7Ssjo
         Hsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        fh=ZEluavXvj6F1Ea2VdjH4CUId4u7L7UAXzG7FRJJGJb4=;
        b=Q7oMo85kFvPn4jWtXRB6tL+1l9pHelXRHiJUtNoSvCVZfxOWetX6Hp+bZkt8KmEu5n
         LEoxvOxU9Az/BX2c8guS66ieC1Tp4hXZb1ig4SmRu+10QLaIhWXRYS0fXG+LN3VSno/k
         W4UYvqPsf7qRnw1j8VNAoPmDWbIfYOJH/RU2beUqnZcsLRb09rI8H0Yn+Q53JxjrP/n3
         2sRfkskADpF8dK7lVy4vHSUkhVIFgFqf57vwvkQVLyr+ukiQ3OWonDjIY3WmfyK84wry
         fEZfRqLtepYteM0O6HVGIUgKjgp0hAkCsW5gc5zC7uwre1je4luqUjLR6CV2nPk19f0f
         XIug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1768849526; x=1769454326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=ZLCChveBpdWvmIIICTa6S/fc053UxqrmmgURpdZW4LIFa5kVxRtc9VCz7L9Hft9W42
         /XusbZMRQfSJ/+Zk3bm2qmindiU2KL9Vu5aPbKqode4lTBaRrDFuAlRnhroW+TlWqM1A
         w0/KsiQaEic9f+uvYLWwMN5rvaUDBEobMpjIQW6qfZGoxDEoDwJ76XMH5t4z2OLugh+p
         SMRz4F+sLSz51Mzt3h7BXK9cogEQyp9VwwFBdyUg9DnL1o7/Z5SUs+zwlghLOEv/Mhkb
         BqP7H7D4lAyKvP1aCfgWXICvg+iUaCT1iswB08UEggCCUa0XLsvLiMMjs5T/RH6SL7hC
         jsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849526; x=1769454326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=ah8/Zmm3jRv8DFTI/2fhEgtfviDCG6p7dOvWjWisT/xqUqL5pRv/F2TBLKuRUqwsG/
         lrwD/WwZCseNgFgk8+W0xhiJIHW6fF447KfqXE64KKYxEgaATkX30HTK+mB60WARzoOX
         m38TwHP2o/zmi2Rp6PPEhwcBTtu74FpXcLgfuwykpKbSP5C4GuHLZvRTEUFqBTbfpB6F
         u1jjMTIYmULCkhXbqmLd1HTCD+itrXD72Y5TER8+GKSzgOcwlkLCbdYHO4Dp6eA+QU7h
         1e+b0jlOWYfY0VGvUlLIY+TyvzcR26UZQrPXOS0CFBs2t5Ft7BpnJ+h9emVPawpHotWZ
         k2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrnJUZkh9eI6sc3RwQEwehlvMArtUs3WJjv5Y3Ga1sKhGutHpPnMbpdPI0fgsn0W6SIH5TIFLkY6NiKis2@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOXYaJj5lgZWLk6hXkTocWF0ekC6Gw1sOVtl4eNY0LNxfvuOh
	9glzNdDqIVnCxCHdM4kv9sLQlNJNHMiqMDXoyngzovI2DDw0wD4jxMZ4JTU9R9669ThhxoWBMce
	zcO0Le4ot8yFQZqjVoSDNXVEotLqNeaDTVTo6srlz
X-Gm-Gg: AY/fxX5tMZQ98w6dwsHyV0U/1hw1BL1g+OiY+5MltaVAN5XuYJoa25HgX/q0H9+pz4i
	4hBkrOqhtyKGYbSI7MsKE5AoCEW2t3QXJQ0BNobhyDjMwceay45VvjmyuWr+TvY8Q3E0srLh85d
	0C62RGH5DAaWuz0hyOXHsFpCR71jIt3cLTdhFi4Qxeb21vfUotS1JhwoNG646a/jykrmPxLz64p
	13tj8faOfHJ9V4bRqSMgc2EkMw2XvRny17mtl2ro0+G94p5JaTFjwEmocNsD6rh6f4y
X-Received: by 2002:a05:6512:3c95:b0:599:289c:67b with SMTP id
 2adb3069b0e04-59baeeadbc3mr4115534e87.21.1768849526113; Mon, 19 Jan 2026
 11:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org> <20260119171101.3215697-1-safinaskar@gmail.com>
In-Reply-To: <20260119171101.3215697-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 19 Jan 2026 11:05:14 -0800
X-Gm-Features: AZwV_Qi9RyaiB91QL-WyEcAJf4X_KdMWwLXZLw6yqaw5pxCOP4suRdhto2Jp-kE
Message-ID: <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Lennart Poettering <mzxreary@0pointer.de>, 
	David Howells <dhowells@redhat.com>, Zhang Yunkai <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, emily@redcoat.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:56=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Christian Brauner <brauner@kernel.org>:
> > Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> > OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> > returning a file descriptor referring to that mount tree
> > OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> > to a new mount namespace. In that new mount namespace the copied mount
> > tree has been mounted on top of a copy of the real rootfs.
>
> I want to point at security benefits of this.
>
> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
> I like them, and I think they should get wider exposure. ]]
>
> If this patchset ([1]) and [2] both land (they are both in "next" now and
> likely will be submitted to mainline soon) and "nullfs_rootfs" is passed =
on
> command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPA=
CE) will
> usually contain exactly 2 mounts: nullfs and whatever was passed to
> open_tree(OPEN_TREE_NAMESPACE).
>
> This means that even if attacker somehow is able to unmount its root and
> get access to underlying mounts, then the only underlying thing they will
> get is nullfs.
>
> Also this means that other mounts are not only hidden in new namespace, t=
hey
> are fully absent. This prevents attacks discussed here: [3], [4].
>
> Also this means that (assuming we have both [1] and [2] and "nullfs_rootf=
s"
> is passed), there is no anymore hidden writable mount shared by all conta=
iners,
> potentially available to attackers. This is concern raised in [5]:
>
> > You want rootfs to be a NULLFS instead of ramfs. You don't seem to want=
 it to
> > actually _be_ a filesystem. Even with your "fix", containers could comm=
unicate
> > with each _other_ through it if it becomes accessible. If a container c=
an get
> > access to an empty initramfs and write into it, it can ask/answer the q=
uestion
> > "Are there any other containers on this machine running stux24" and the=
n coordinate.

I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
path that gives it sensible behavior should be conditional like this.
Either make it *always* mount on top of nullfs (regardless of boot
options) or find some way to have it actually be the root.  I assume
the latter is challenging for some reason.

--Andy

