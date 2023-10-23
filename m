Return-Path: <linux-fsdevel+bounces-919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881167D368D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945A0B20DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB718E1D;
	Mon, 23 Oct 2023 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyMQeDBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220A3D74
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:29:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CAC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698064179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cBxf1qI5igiqhGhDt0xhNhbgmhg+KZq+ppOsw3vwmII=;
	b=GyMQeDBlIJ+jYyO0GXXNZnUcllpbfkcS5PSY3FnqxbBRR3nOK3P7WVRnVlUZ6xCNreAsZT
	IKwg5QrVJtXvLJrt3gCPiukSpUlY4lLhqJvqvDbhdZrDcjJ8fcjj/nfQb8Mt1cXONVOqo6
	77G9GRoAdZn7Gwntc7s6awPfNtIPtOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-EtkhPxHrPpyNYyMmCr0zDA-1; Mon, 23 Oct 2023 08:29:38 -0400
X-MC-Unique: EtkhPxHrPpyNYyMmCr0zDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso23032185e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064177; x=1698668977;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBxf1qI5igiqhGhDt0xhNhbgmhg+KZq+ppOsw3vwmII=;
        b=tcDc8CMh4PpacC/xndgZh3AnfRGGHauKNGfN6x6WWEhct1E0v4foo3oXAysFad/z8r
         k2svZJp9vN7nAX4AUpLtLKzGyqSZjwOT3L9n7213i8JVzRc+Kb3hl0Bo0B1HGeg8KqIE
         8FZ1YrHhLhqWSHKosIfAam2yY3dVlzf08sq2qGWaeqf5BAjBpTIWsuK60sPrjg0UsZo3
         5gIqjk9dmLbx1+gFqarHkdpnkvmBHye6ALNSx4qjiA3hifvla852feEQMTee4GL6hzDa
         jiVSzIH4rTzBTGtF3vg1OTraSPJe0OLOTFoZsU1VOrmL8zhfGCqPrwn8ROYfkZ/sQEb/
         ivMA==
X-Gm-Message-State: AOJu0YyybZU5aWkg6fT9Cjpfhq9sSHneUZ5yuc+Up8gtr7EgCAVsug23
	sBj10XL65/BUAlHwNuUW7VliN5GCS9RtsvJZicLF7HUta9UU7mLiOIEichSeHFInPeDQ4s6PvOh
	GSlsyKMkKZ3+ljHF3a+2m3lmvhw==
X-Received: by 2002:a5d:6310:0:b0:32d:a236:b6f4 with SMTP id i16-20020a5d6310000000b0032da236b6f4mr7728012wru.50.1698064177151;
        Mon, 23 Oct 2023 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAN61TO6/tA7YXUSTeeDmVKJzjhIss60g2T2VU+PT0lvyM6Wnzdz0UO+ThSDlGf0HpARDmNA==
X-Received: by 2002:a5d:6310:0:b0:32d:a236:b6f4 with SMTP id i16-20020a5d6310000000b0032da236b6f4mr7727973wru.50.1698064176684;
        Mon, 23 Oct 2023 05:29:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:1900:b6ea:5b9:62c0:34e? (p200300cbc7381900b6ea05b962c0034e.dip0.t-ipconnect.de. [2003:cb:c738:1900:b6ea:5b9:62c0:34e])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d518c000000b0031f82743e25sm7659046wrv.67.2023.10.23.05.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 05:29:36 -0700 (PDT)
Message-ID: <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
Date: Mon, 23 Oct 2023 14:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
 rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
 jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
 kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231009064230.2952396-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Focusing on validate_remap_areas():

> +
> +static int validate_remap_areas(struct vm_area_struct *src_vma,
> +				struct vm_area_struct *dst_vma)
> +{
> +	/* Only allow remapping if both have the same access and protection */
> +	if ((src_vma->vm_flags & VM_ACCESS_FLAGS) != (dst_vma->vm_flags & VM_ACCESS_FLAGS) ||
> +	    pgprot_val(src_vma->vm_page_prot) != pgprot_val(dst_vma->vm_page_prot))
> +		return -EINVAL;

Makes sense. I do wonder about pkey and friends and if we even have to 
so anything special.

> +
> +	/* Only allow remapping if both are mlocked or both aren't */
> +	if ((src_vma->vm_flags & VM_LOCKED) != (dst_vma->vm_flags & VM_LOCKED))
> +		return -EINVAL;
> +
> +	if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_WRITE))
> +		return -EINVAL;

Why does one of both need VM_WRITE? If one really needs it, then the 
destination (where we're moving stuff to).

> +
> +	/*
> +	 * Be strict and only allow remap_pages if either the src or
> +	 * dst range is registered in the userfaultfd to prevent
> +	 * userland errors going unnoticed. As far as the VM
> +	 * consistency is concerned, it would be perfectly safe to
> +	 * remove this check, but there's no useful usage for
> +	 * remap_pages ouside of userfaultfd registered ranges. This
> +	 * is after all why it is an ioctl belonging to the
> +	 * userfaultfd and not a syscall.

I think the last sentence is the important bit and the comment can 
likely be reduced.

> +	 *
> +	 * Allow both vmas to be registered in the userfaultfd, just
> +	 * in case somebody finds a way to make such a case useful.
> +	 * Normally only one of the two vmas would be registered in
> +	 * the userfaultfd.

Should we just check the destination? That makes most sense to me, 
because with uffd we are resolving uffd-events. And just like 
copy/zeropage we want to resolve a page fault ("userfault") of a 
non-present page on the destination.


> +	 */
> +	if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> +	    !src_vma->vm_userfaultfd_ctx.ctx)
> +		return -EINVAL;



> +
> +	/*
> +	 * FIXME: only allow remapping across anonymous vmas,
> +	 * tmpfs should be added.
> +	 */
> +	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> +		return -EINVAL;

Why a FIXME here? Just drop the comment completely or replace it with 
"We only allow to remap anonymous folios accross anonymous VMAs".

> +
> +	/*
> +	 * Ensure the dst_vma has a anon_vma or this page
> +	 * would get a NULL anon_vma when moved in the
> +	 * dst_vma.
> +	 */
> +	if (unlikely(anon_vma_prepare(dst_vma)))
> +		return -ENOMEM;

Makes sense.

> +
> +	return 0;
> +}


-- 
Cheers,

David / dhildenb


