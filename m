Return-Path: <linux-fsdevel+bounces-76372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCKZHSxQhGkE2gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 09:09:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC2EFBBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4982D3008D7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE613557EA;
	Thu,  5 Feb 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRlTEw5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529F22CBD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278951; cv=pass; b=T3OqM6m+NQ1aklg9sf3ATYZnFHX8YWzLc0pHfOlx0hPY6hIXqKdnwYcGUP4nDrt+epK3+6THctWCdr2XWwyv4N2dfYcEg5Dm2Zcc3+eRJSMJ6VLPCJGsmNZ5zWZnpMnMEy5KqyTE8LknsJOq9Rjh8Ls5Rjl8ebmfgVIK3gBE1Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278951; c=relaxed/simple;
	bh=hBmat73KykWi3rUFrWV37WrEFKH+2WJVHisJIIzvubM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G256yozIBcOCjvZE2kQ3U4EAqB/2cuQqlFb/WJsmAMmNdTaN3PlVGy7LzIvGxB1IoW2d94ehwESBTiEy4up3wCP6cnG3L7cOSO2itigC7R5znQKJ4Bgf983GpHaPvlYzQJybEUBBMCcLWykfjNeaj9hufsrPVBFXTUfVU8ZtGHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRlTEw5V; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359108fd24so421093f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 00:09:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770278949; cv=none;
        d=google.com; s=arc-20240605;
        b=dKJffb4JTNQVPrfUZXo7YvBrLz6ZyxXyzMSv3V3qb8mvyLzO6nXYHVOfk35yBpwRAn
         43i5qTsEKC19P9BSd3KHKdRV6rZQl6cQobLXDhzFhSZTHA6O/w509qpdl3/683TdFZbA
         e/9Tn8FAnsaFKcdP/Wuyl9kz8o44EXHUncCTuFV+6uVk5cxuSuFcjpvRhndNy2f2JEX6
         VPJ/rljrgpGDLaT6fjol0pd/rGkHUSPk3CDWhEvxz1AZSYzoaavPuJ7zgPcYlvp+7CPa
         RL1RAp4YvDLSo36+Y2gkd5FHSX9oOZctOiFuq9u6RUhxLBpu9rsz4jYCToeOHJhpo/wT
         Vv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBmat73KykWi3rUFrWV37WrEFKH+2WJVHisJIIzvubM=;
        fh=DA4JMNT1N5y0L0BYTTH+yxrLPihMt9BBEPjkUA8pviA=;
        b=A5kd2OUaI4MA2DMmgirKdTOVL6S009yKrUwKu1ouXIMCREmwfhtx3DZp7T5mOZaLg+
         1r4eQyzIlznyNQuGGJ2Hbeane7YvsTRopVOijswtXT/OVkdyy+2N2ikxKBstuUCc55/3
         eBCyN23YS6t6QjK60uyELrXRQ+b3inUOzScDG9dxB70RGvn96KY50TgR33+U0edrlro2
         lRMrq5lRlzVG38ubU8b9ckpVFJowpJfHHmamZ5H8sbsQuSkfjyNSOZe0Yphjhvodbk+R
         uLiw/2NvDkq30t9rmJYK2rI3mxYxWbZIkkKXj47lL/DKFye/G9T4IxxN8FMJ7juPc8+f
         Bqmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770278949; x=1770883749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBmat73KykWi3rUFrWV37WrEFKH+2WJVHisJIIzvubM=;
        b=yRlTEw5V6EuXdo0GBsyY4Xct2TRcJQ1KyJfifm+rbyZce6/YZhFUdqghxVgNk1UxDW
         OIYE9sjZqWkBX/2QimMHBsO86fCuhFPsQQ3i7tM5aqeaBwIwJ/fw2+rTMNC2wwBlp9UE
         KM+kMqfFbvDJRTbN7Ggm87kn09tzgEwSd8QZILO136GZtSKs9EbYY5yoE/c3KBjzvjik
         kEwsCk9ajhqcO5YSXj+qjEv4ku5IYNN4URVXshg1ezxJG+oa0J0aB4oKDXf+WD/WK851
         Hd3w4uYYCI1iRyXNx+Vx1wEnJrNVSF2j+bm7X8chTFEn1der6/QM4R/s1G1Vg+x9XmG3
         lA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278949; x=1770883749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBmat73KykWi3rUFrWV37WrEFKH+2WJVHisJIIzvubM=;
        b=ryFxtklzVJFLmM75Up+Ao4MUcNduj5PBv1YM7A/cKc2EZv0/dasdSEQMDXmMQWFpcv
         PHmRXWP96zay5xDtPs9W+mjCKwpUgy/9azvkJAZ5ibm+5/C3sl6PhW+7GFwunBGXVBcY
         FBkaGGfcP5gsq2VU7KiO1bS02X6FPN1Salbb6cit9W5GFwiHdwbWajZ0VvD3Jh901HHd
         c/Cbc3h1GnKr/BnWQbeIRtyOEyI05sA39JU3ulNCCa5Ha/KLNhr0mqDg99qcfpR3kO2Z
         SMlJohH9YPvJqJhnp0X3f1TL++QoucM6I61h/gQhBPcn/+W3VuwKY96VkY9UoI3956IH
         Kw6g==
X-Gm-Message-State: AOJu0YyMpCStktH3cYi9gedAQQFaKHE0CwuNIg5O0IJPUrsaFHPRsd1M
	uBSS65OoE/I50Szz4qEy4RoI7KcoL64A4CCq1lgU95dj9NGjHcKQB2hbGbqhvqTs3CfAoCjsu8A
	h4pMnLnhyP+d2DeHkrBJ6mtty269JkYSxuMjsi3Et
X-Gm-Gg: AZuq6aLZZ8yIqKGJgUkObi/PfqVAVgXkkfmNnJXkEHJb5vwfjv7vfQKQcetRsEZ0OD9
	UJrqBwXDcQ04leoeeFf06/Fqu3MDftxWfjc5F3RP4zTJlaiidZNESG6WMI/XFQx0Q3MZEjSA1cl
	zpOR9BnUOvGaiqM3x6KFjGFnHdHa+UQJvHzf078vLpB9ZgUibB4SQrB1jOl7CTWqWrZIKmcgMRO
	asbSaCL5ILiMXhRXE+dKIrLJgAcOD35p4sJmSy9Jo0/acRtBYihpk34+oaBzS6TC73Svlu6jb+K
	DggiuYoTiALcEySNyD+WjyOXdw==
X-Received: by 2002:a05:6000:1841:b0:432:5b81:48b with SMTP id
 ffacd0b85a97d-43618061687mr8164372f8f.61.1770278949014; Thu, 05 Feb 2026
 00:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205074342.GR3183987@ZenIV>
In-Reply-To: <20260205074342.GR3183987@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Feb 2026 09:08:57 +0100
X-Gm-Features: AZwV_Qh91WtWdIaWjzIrU4O3F5gJlW9ZG1Jt1gSdCGW-PGk6CWeffUdS-CTcRBw
Message-ID: <CAH5fLghf6SzKfGsX5QhJ5rLG+QsGes5EcjadKScD9ex4cq940A@mail.gmail.com>
Subject: Re: [PATCH][RFC] rust_binderfs: fix a dentry leak (regression from
 tree-in-dcache conversion)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76372-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c09:e001:a7::12fc:5321:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0BC2EFBBD
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 8:41=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> [just realized that this one had been sitting in #fixes without being
> posted - sorry]
>
> Parallel to binderfs patches - 02da8d2c0965 "binderfs_binder_ctl_create()=
:
> kill a bogus check" and the bit of b89aa544821d "convert binderfs" that
> got lost when making 4433d8e25d73 "convert rust_binderfs"; the former is
> a cleanup, the latter is about marking /binder-control persistent, so tha=
t
> it would be taken out on umount.
>
> Fixes: 4433d8e25d73 ("convert rust_binderfs")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Alice Ryhl <aliceryhl@google.com>

