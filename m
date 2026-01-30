Return-Path: <linux-fsdevel+bounces-75964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEORKu8YfWkhQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:47:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 543ECBE854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C610A301AD2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787043502AE;
	Fri, 30 Jan 2026 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW7zuZXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E62E6CA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806055; cv=pass; b=M+5dGBRM77AMrMGt6dVuF1BLPNlD74NPjRUOfbYk2hhtiWyzsR1qIlubvnf/7L+x+Q3eY4wRpHbtcglQWUpsNvM6C0rJCRF3d3y9vu+1uRGJfWN+bfD11HTVYeypHmqxbN1tCttX4Xu6RJpJDd8jen8tN5KH3GK+fqsg7unFQZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806055; c=relaxed/simple;
	bh=Sq7qKh7EMk48dHWt/Qluz1/8qTKafxCHaQEna2Tz7fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/f20cBZhCQsNKnS5QGKU9RvyqLjVXXaEAZTprAXCb15ZEdifYp66Yrw/9a8TcLBgFItrSgmrf4UvmKvwgiIDn/zE+RCvl8LV4VqpakpjKID14/5+wP4ZR/o7POPCas19nq4pj1tFLPl0FgdpXMtRgeuKCH9bMf4yKMtjTeII+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW7zuZXa; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1527698a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 12:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769806053; cv=none;
        d=google.com; s=arc-20240605;
        b=VoycEY7IMTFCKe45w56mWqYwPP0G8pkAOz4hVuVvQPpluTpVrxSnrUf3uEDT3+JVZD
         aE6f8JOCcKUek3MjEt4Tg4r3v03gQzt+m1tI7/3WWz7JJE5iDrgkFs+uaU+RJWQ0Vh+z
         eHeLF2zwef2Wr2IWP5LlWdp/NQu+owjC2nC4uByJ9MGR88TWpr7c+9ew9JiseUgnWHyn
         guob1NJpSyhQpk6qw3RMxhbGzbc61FtRq0w8XfVn6LfdGwx0qJlEY5OfZNGmRm6bGkGE
         OaXM0RIF/5T7fkhFQse3Es9wQLltRYuWmfJCboG4bx53s5hnVXdySxs58Ptf7XwU06wd
         6B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        fh=XwPM9Yo8kKMkxI1sLsl/yYamSd4Fyu0rPNIN1yYacV0=;
        b=UJM2kyql62pWDb+qc/Duol8QlMH+yMzBKuzZDj8Lbs9IVo4FPAusVZMXsark58ioR4
         BibCthAdvb7W0clCLiGi+lrQp5xGKQU6AcKI7+C7hp//csh6w1vI1JXq/Q0lnzJ99Lj6
         FZg1++5KEpf+/4ohXs38xMiQZqhOkyYaGIJgZB5j9Y2rucmdCiyP/mroHgZNhn7pjQQF
         64/5jVmhFFGmPl+vubslW5YZOOxtlaO0R/6p53d8BoM8AFgNpKWOVABc6w9NWBacVUoe
         IztIOjPrb47wPNF982+jhmjA8uBQV+DnXLgsX3NlahoSTVWtR0PBKfhzHiQAJIVqpVjG
         NScg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806053; x=1770410853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        b=ZW7zuZXaerMAKqlEwyiV49VfHQTqzaI4wFv/cI4f+O8/EYZc+YrvBtb1LAYNXDunz3
         /7Sm1YDyZk5mCZjF2Q058tHA+YSzIFg9LEFAnT6B1f4LHp5M3yOmgrr6VVmKACLljD1l
         vP/1zoAnC/Wamazdcul1S7VJfwUn9A7nWfRTWRSQj/nPXQj54Py/uxttN14vBWFpQswf
         ZFh7wyF2vRRCK1E/EIyJ3IMkgfUKG0oKDrDl85i5TGU58wwaO8sCmeXjS6iSHjIwItxb
         Www0gKW+NDFTbaA1+aM+ff9jwC/oblmxo7hPhMSWN8llhS+xZBpdDaXu7J9jJMaIJRMs
         rs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806053; x=1770410853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        b=oJqrWa3g140hnUrMBB+0gN6NaZZfzzRTpV9hTV/Sh8KN9pfhJ6lynqBBlyXMt1zMUB
         L2MGe3TqBcKyodT97RQzGOZlXa7ynjIKsowWkQEV2D1b0VdYZj+Qlth/L25FSWLTYBoO
         Z93n1g31LpS4iB7/9GlQf5CU/OR3eypenallUkskE8Z2IzO9UUz1SxoqCcTjQXmTgAK9
         nmmwXdZMRsREALJXRkPJXwqEFPYYPX2gNtpWpw3uMkiuwVTC0KasOsu87fMqGbAwsqtV
         wv6Jxh70y4JNLTN5jQVPIqmhhSIcedmu2t01SjCb5JGVGKBm2wWxHD1Xav1nhdY45/ss
         6u2A==
X-Forwarded-Encrypted: i=1; AJvYcCXRHBObTQcY6FBMcxJQIP1yacpAPDNzRg6PtwCrrwEfUdp6q2gK8vwLR4QBC3++M5YsMT2uBRu9pSSNba7l@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqljrNKZcXNPdp+FWI9Sbk61vMrbSOJ56qs8Kd3qsHseKM9rG
	fJeCn149o1g+o2s8TCJhEu/RfCWythjlA0t/3E7gx8OcAIDY6bR4I1UUmpPlTsXwYoS82lAqYbo
	C6Pl5zEu2oztzHllxNyZFRm8Wiml79NA=
X-Gm-Gg: AZuq6aKKhMj+Ezq94DXY86NRfS1EVskagihPp13oCVTibmnSpsbLpag1YgGJgZmetma
	7wuoglP+ORH9yFxm2wRJgLBBnnklccYWCw4neGf4AOxYK0EClB2TDpzjMOtGkEKMbQtMJ1acH1Z
	ZbYGxi4ZLS7Cud0XZI7sbw5oZa4UWOZGCQlWlUL+3DL8db8SZKJhhH6DejYI4/o7cWt2BSSUl6i
	EAgBtG7WL4F/lvqUb0k1rxQjYORXagKYcmt4uNw7Uxi/enKg/PiztHq4MfZ5LUptgMmCpLDMWF4
	G6PTqiIeVyk=
X-Received: by 2002:a17:90b:37c6:b0:349:3fe8:e7df with SMTP id
 98e67ed59e1d1-3543b38bdbfmr3697730a91.22.1769806052962; Fri, 30 Jan 2026
 12:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <202601301121.zr5U6ixA-lkp@intel.com>
 <CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com> <20260130124242.dbb7946b3592ffddac7c316a@linux-foundation.org>
In-Reply-To: <20260130124242.dbb7946b3592ffddac7c316a@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:47:20 -0800
X-Gm-Features: AZwV_Qg6qiEP4IMJhs-KyomvrbnJXpik5IjgslLpgoiiekMmR439uSsS3HxxEv8
Message-ID: <CAEf4BzatC6zi2vm=acg7949nBKpb6m+L4ubvLKn6JmRwy8o2Bg@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75964-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 543ECBE854
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:42=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 30 Jan 2026 12:11:31 -0800 Andrii Nakryiko <andrii.nakryiko@gmail=
.com> wrote:
>
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> Warning: lib/buildid.c:348 This comment starts with '/**', but isn=
't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
> > >     * Parse build ID of ELF file
> >
> > So AI tells me to be a proper kernel-doc comment this should have been:
> >
> > * build_id_parse_file() - Parse build ID of ELF file
> >
> > Andrew, should I send v3 or you can just patch it up in-place? Thanks!
>
> No probs.
>
> The preceding two functions are trying to be kerneldoc but failed.  How
> about this?
>
>

yep, LGTM, thanks!

> --- a/lib/buildid.c~procfs-avoid-fetching-build-id-while-holding-vma-lock=
-fix
> +++ a/lib/buildid.c
> @@ -315,8 +315,8 @@ out:
>         return ret;
>  }
>
> -/*
> - * Parse build ID of ELF file mapped to vma
> +/**
> + * build_id_parse_nofault() - Parse build ID of ELF file mapped to vma
>   * @vma:      vma object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> @@ -334,8 +334,8 @@ int build_id_parse_nofault(struct vm_are
>         return __build_id_parse(vma->vm_file, build_id, size, false /* !m=
ay_fault */);
>  }
>
> -/*
> - * Parse build ID of ELF file mapped to VMA
> +/**
> + * build_id_parse() - Parse build ID of ELF file mapped to VMA
>   * @vma:      vma object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> @@ -354,7 +354,7 @@ int build_id_parse(struct vm_area_struct
>  }
>
>  /**
> - * Parse build ID of ELF file
> + * build_id_parse_file() - Parse build ID of ELF file
>   * @file:      file object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> _
>

