Return-Path: <linux-fsdevel+bounces-78332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPNTCoUvnmk/UAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 00:08:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB43E18E11B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 00:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C120300765F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65D352C29;
	Tue, 24 Feb 2026 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjaI4wnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CD32AAA8
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974515; cv=pass; b=a6dXilmx4uYcEy1/flJ5V/jF9T1czAUQaSKy2Y1nSQcT43Bts+cbOMdSPe50jHQAlEQ59nkPwN8ts9NgZ0s6kfPXvjBB/yjbFYc8haRf+OkhTGiHHheGgEazG8TahhzPBd9XhhC5G5Oeg0GPTteXHZefFUbY3aPZ3DlIDa34qlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974515; c=relaxed/simple;
	bh=28oWEEZoiQk0c8pFXW4FAksDMsn5TOYNsg+K52E7d0I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3dbdqBX2atgYAMgoAVmnosufbK+AzBGlwI70cC776RbDa2XoFIqt0X8xyB2eTwxHfWN4IH8OuxpQ5IfeSPu/OpCoBMqvuKTFrMofIdjD34Y/tQSSuAwJXVQ1OTbjlKXFIp0nzaB0n6kDXB0iST4eSy5KUH7yPLIh/hfNp1Hju0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjaI4wnc; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94abd52b274so1585413241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 15:08:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771974512; cv=none;
        d=google.com; s=arc-20240605;
        b=RWBTjyrK3ua53tbdEJd0gnNt97VANzaZM7yv9sHK4258Vs6+svViUx6dw+0Rhf00nv
         +82HiBiP3sdsZxl5x7AXWzK5b72Y17jvmlDBYp/SyZj1vg8ti/BisErt7IT7j+Ky1A1N
         ZVpXMxmxAaSfv9FJR/YsIWnH69qxe99j02IaYnV3LpCzy5/JdtYKkut26vUBxXCh7FUf
         1LOsNyeOJ4xT+w4W8YUVogjeDCVWTfkmQx409WygvzrHduPU4ZNKfPWuihPDKI4G0CL3
         xX8LNuAflYTMO1BaCFQNBMprtRA7QiNVzkuuFUsFajzp8TlP7f/98/Njc80l+WKxFiiF
         sOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Xux2sJMsRceAq4Wg5BBVEZwRPNSVyPqjLyJ8Turb9tM=;
        fh=Gxjj9CEjj35CpSngkubu2OWtrgxCf+sIhlmm7Mn17Ck=;
        b=Pkep6EmZfi779eClzYNk8QBg/w+Zmj1v+zPn47/l/DDWhCbHkC+Ghq6ucliWgJsXe3
         ezO5p1l0oH4kt56m9XCe0BM7V5eL1Z0dt2/Qcn3Qs+BP+3mb7Or/B+Etfbnpbp6ujHvy
         ib5jw6gx17AphASvpR7RGZcVCeTVWdc93SQaI7fIf9ai5Khnh0If6bYg6iJSUdbPzjQK
         vmknpO1SEUzwhTWcPdnsQOsAGouvFBNZjtP04WNX9uKCJb/VNPLGbgxbqx5Mnrhu7aHL
         5uNZHPjKxyMkZi72kd0ISXfvNr89sIw1V8BMg+SDs0FD33ekmPVsxR7ub6pEOaZe9Kv/
         CuQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771974512; x=1772579312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xux2sJMsRceAq4Wg5BBVEZwRPNSVyPqjLyJ8Turb9tM=;
        b=qjaI4wncSBISX6RMiyYjW6b7vhKOb7K3rRqhHpgcw3cBMa34/9D2b2LhVwiUzcW1NM
         LM+e+JbVTdBdYV7oed9NR0e/npN6N4IN20/kvexzf1JHzwICpOSVhckPKqMtuf8nRj/i
         umt4eOPj1p+CJFBwhmI2biJxADyS2yKAfVaMY5Ckdvqv4iJlcnSFDr/k7BkuWU7XvKnD
         6xjMcoGQj9BlCV/x0mN7J7wtQmwhDvaesWdeyhqEl2FlQVUrn2KCKkbNeZCq6Lf311Kc
         GsyMNFVKNifRzFGjtjZernenD9waEcL8F8qVWnsijoga03aHMcDjwbFWIHzgURP4uHv0
         DsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771974512; x=1772579312;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xux2sJMsRceAq4Wg5BBVEZwRPNSVyPqjLyJ8Turb9tM=;
        b=NIRgoBNl7MnsbprCt8sndq7SX2LtWOlxSkgwL24ohZWnYmqcIr4ysgg8co+VfVFfWH
         19e/TPtuP5aHiw0L0zkL7yXDkfHXxX8i3gAwk9pMamkkxMWkd/y9RBGxI0/1HTyNPSuM
         FX4vVwiogA2cDuB40k2Oet0r7OxuOxR9iqLcdlWpICcyGkdA1xRyKkL1cpAAM25PuRLs
         8+hj79OnCZ9ijVrWJDhtNj1yOQovpN/5xokxw5Zg+hN6cVVN2cLutrISgF/yTPbgRSoi
         BRMr80K4gafgO6tGS0ohp84I5S6xk3amGO75uKHrjtWzC6RREDf+j4b7GVGzmWGzSmo4
         odXg==
X-Forwarded-Encrypted: i=1; AJvYcCWUnfdryKa+6FEKyYUICd8Nq8ZSrN1rYaFDWFRfs5H2b5eWxjemZ+I1dfes1u7IYwjkBuzC1wWlxw7bs9V2@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSvm+ZZd7DStViSzAja74lMmNmtvpxTX+OeWJ3GsK25vSuCG/
	GFeED2+vV23K3w7ZoL2qc5MP+Y6xD8q6WLy9P6mT3DXA9pvpatBoY9rQzGvL9tIsSo55Zz5iHjS
	znO40ZbygLXB/SY29r+djNRhWUndhnUu0pH54ZNC8
X-Gm-Gg: ATEYQzxwOl+16tpfcbfV2xmjZBvxSxq4A2KSNWQO+3OvC20tyUeMqGDaUGcKQURRkei
	7kGpkQ2XboOBwkwZgjfItRNm1U3gscc5/IdrtKrjkPshsc9Hp50E005oMz3V8YCw7deFX5ItMvT
	LhCSeygxFikSs37qmNzuvKjOMMela9EmgN2rWmqoyr57kZQ95ZaPBGNtLp1bHZzIFFj+aoDPYp1
	Gy4vvDr3WcA8phfV5l0b7iBO7+U8jD3eFj9YxAz7OK/zb6gYcSoSo6taxDKtHeJ8+Fq9IFiFizh
	n0UuVBl1exTMiuQ3HA8jU4wr/XJiBc9pu9qT4OUdcA==
X-Received: by 2002:a05:6102:3591:b0:5f1:c4d3:5b37 with SMTP id
 ada2fe7eead31-5feb2f08b48mr5246678137.16.1771974511231; Tue, 24 Feb 2026
 15:08:31 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 15:08:30 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 15:08:30 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9ef9a0bd-4cff-4518-b7fb-e65c9b761a5a@kernel.org>
References: <cover.1771826352.git.ackerleytng@google.com> <a97045a9-8866-40fe-aa15-d319cafa6f2c@kernel.org>
 <CAEvNRgFF0+g9pmp1yitX48ebK=fDpYKSOQDmRfOjzSHxM5UpeQ@mail.gmail.com> <9ef9a0bd-4cff-4518-b7fb-e65c9b761a5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 15:08:30 -0800
X-Gm-Features: AaiRm50613GkBCc5TY4oG7cVnbM-cLi0tM-0c-2O0j598MHU_6zRLimq98-hNZ8
Message-ID: <CAEvNRgESctVm9CcEyK36hY8Ta=DEDOS1oW5w0qRDoNfdd=470g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/10] guest_memfd: Track amount of memory
 allocated on inode
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org, 
	seanjc@google.com, shivankg@amd.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, vannapurve@google.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78332-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB43E18E11B
X-Rspamd-Action: no action

"David Hildenbrand (Arm)" <david@kernel.org> writes:

>
> [...snip...]
>
>>> Could we maybe have a
>>> different callback (when the mapping is still guaranteed to be around)
>>> from where we could update i_blocks on the freeing path?
>>
>> Do you mean that we should add a new callback to struct
>> address_space_operations?
>
> If that avoids having to implement truncation completely ourselves, that might be one
> option we could discuss, yes.
>
> Something like:
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7c753148af88..94f8bb81f017 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -764,6 +764,7 @@ cache in your filesystem.  The following members are defined:
>                 sector_t (*bmap)(struct address_space *, sector_t);
>                 void (*invalidate_folio) (struct folio *, size_t start, size_t len);
>                 bool (*release_folio)(struct folio *, gfp_t);
> +               void (*remove_folio)(struct folio *folio);
>                 void (*free_folio)(struct folio *);
>                 ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>                 int (*migrate_folio)(struct mapping *, struct folio *dst,
> @@ -922,6 +923,11 @@ cache in your filesystem.  The following members are defined:
>         its release_folio will need to ensure this.  Possibly it can
>         clear the uptodate flag if it cannot free private data yet.
>
> +``remove_folio``
> +       remove_folio is called just before the folio is removed from the
> +       page cache in order to allow the cleanup of properties (e.g.,
> +       accounting) that needs the address_space mapping.
> +
>  ``free_folio``
>         free_folio is called once the folio is no longer visible in the
>         page cache in order to allow the cleanup of any private data.
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25e..f7f6930977a1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -422,6 +422,7 @@ struct address_space_operations {
>         sector_t (*bmap)(struct address_space *, sector_t);
>         void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
>         bool (*release_folio)(struct folio *, gfp_t);
> +       void (*remove_folio)(struct folio *folio);
>         void (*free_folio)(struct folio *folio);
>         ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>         /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4ada..5a810eaacab2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -250,8 +250,14 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>  void filemap_remove_folio(struct folio *folio)
>  {
>         struct address_space *mapping = folio->mapping;
> +       void (*remove_folio)(struct folio *);
>
>         BUG_ON(!folio_test_locked(folio));
> +
> +       remove_folio = mapping->a_ops->remove_folio;
> +       if (unlikely(remove_folio))
> +               remove_folio(folio);
> +
>         spin_lock(&mapping->host->i_lock);
>         xa_lock_irq(&mapping->i_pages);
>         __filemap_remove_folio(folio, NULL);
>

Thanks for this suggestion, I'll try this out and send another revision.

>
> Ideally we'd perform it under the lock just after clearing folio->mapping, but I guess that
> might be more controversial.
>
> For accounting you need the above might be good enough, but I am not sure for how many
> other use cases there might be.
>
> --
> Cheers,
>
> David

