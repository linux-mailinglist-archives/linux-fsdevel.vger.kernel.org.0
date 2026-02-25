Return-Path: <linux-fsdevel+bounces-78346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO+sB4OmnmmrWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:36:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5B1938B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB72B309596D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45419E97B;
	Wed, 25 Feb 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWgpGrog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC362877CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004687; cv=pass; b=M11DzYLT5kBFFnGSiwCRaLNP9gMM+KYsL9QsCPbZTwze3DyvwnbAVJ7+Ny80vKTQEqo8yXsLCgwR+GgkQYnV1fuqjBBcC465sHvFZdQb9nRNypZiAjEyvcb9/wbeDeqVxRsXyKwkO5wM7UWJpA8HjepG2WO1Negzo6Hwk3B4icw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004687; c=relaxed/simple;
	bh=iGYGT1zAvQhLDodw/8tlbySDHlXg49Ntp6LeHdpPLsE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCwOt+7zPoj8OGXRYmndbbYKOQyC7qWOe7m9FkwajJ6IL18plld1sAewlESpe8IwIE5MEuhBbw+Cf0xCKB55FKtvy2fjpNshwOu6v2t9bcCxXNegn9zv4hh5G1R/TOG7D1LAkZtv2cIEJs0fjXoYoJ+jW9BUGz+inq2SVKZA+bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWgpGrog; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so517560241.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004685; cv=none;
        d=google.com; s=arc-20240605;
        b=NPquEFZwD7biUobUH0mE96oeWP+nWuky7jObzi7qUCEfjF73NYA3Po+YxuPGeSfCqd
         ZAAUfAhxTMRwygO1ZS1ev9edGxLYhg21QiCv6dzK+kECfcHSJNL6s6Rw1sUya6x+yBfc
         qVR3wcClGhzZgwFTvnWHrwH2gtQmExAKjSeTOvpGW3sDjeRmrvtT5EGbiJi8yMDVPId5
         7j39v7Wwb/O1F1f11d2W37LePioT+Z3j0OB4lpUgpTbrDHI9bcB0QeULJO2/TDFH/4SN
         pRht4QaP8Y1Be9GHoMlE1IPRujzmTYW/+3XkAjpYDh6qEYHnwOP1gisb7wrbF7mHyntF
         lCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XX8b+rtVnqMMtNp/ESqgVDIfe5eqIi9YcNK6m86bxSc=;
        fh=LzEIRXZ59cCCZpiiLSfRqEU5q7UgWmbOoXw5yoM+/Bs=;
        b=GvrEdzzKO36TvNkM5kil0Mo5S3Z8u/Gl9eAn02bq/A2H3o5pDhls5IGGWk6w9d41K/
         F7Z2lVZGWD5lc0vq7kKWSFZpCX+77B1xNfRupUPUAU+if3XEYJ0FgfRVxJmnPC/C0NjS
         34eoljXzprNNFZkfTC7J4sAiMQwvsQeukIF2pmmt4NL51zlNr5JbAJHhFQdcjh5VG2xG
         atslMID+nAlZAle7zTZFa4sQRwsIOrMZDoLRvQ9Ux1bkB53Uqh02dSg86WoVJRzm5DWP
         u8jWeP6XyFfZzvie3Pk+OPrlSC5IvQBIZIuKkNH6DOAUgDJoXm1elRuBQ+7QbzZxR51M
         at5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004685; x=1772609485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XX8b+rtVnqMMtNp/ESqgVDIfe5eqIi9YcNK6m86bxSc=;
        b=bWgpGrog6nsW6EOEHynnZAPGvkBcMVg/s1vfSpuzTZLe7e6t4gBUDAZXvOPcNuoT4S
         pnzbstWM4T9iS1znGoiSjyIWvaDbKYN6o/o71Es5cgPT9w/4NB07oc6aITDq8PiOly4F
         xok/UzWtqKvu4yXXY5lZ21DFx1gn5ouSN5c+mmA0GjPF7rDP6w2UD0Xsq70es5uw7quI
         UQLR1wMKm2YWMNw/euHnkLXp0S93RtVNzISXX9HRBvcewdSLvPd+vkMQsjLDO4JrxF4L
         t2XvIzRh00K4MwpOdL4+M+23Z7HHsUKzVeggTvCwSIHQqe9424kPa8W5KMBq5qWfogcF
         7VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004685; x=1772609485;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX8b+rtVnqMMtNp/ESqgVDIfe5eqIi9YcNK6m86bxSc=;
        b=aiOTMQR92t34RA3PQ/bS5eOU8N1AAaZEQ4iFs8JTfl8TC9qqkHBKpJbNXoZ4l1P5N8
         sFYiVjf5czxoBWKPS+lTRea9idmWRmE5k0MIfxuIkMk1h0sgrajtAqNvBSJpPZwaZo+N
         MxBo7uMX6b94uaOxhF+ftT58uUfxMsTDaE+lUQiYZYuAPl40LseKzigHYGabBRUODDEy
         /52o0daAhsRZLParh3Te76FvF16ncRyCXtU6tFrocDShQzYlGK6Z3h0pL2rahkiOZVFl
         k62AZOGXwQSPT10Uq/IU7IqCKLolrrm5iAfRuHWvVfUzRouJyOil3cGmnwTFVvIJhNWP
         NDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNelO6gKUTcnKud+DU7u8i/DjjI+ihKGi4ru5yTIRqGZF8frM8GTCZroSdbj9iMYk/6nsyymKMWT5xOQ4y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kgX4r9y/0hz7q1DvjNICi4MFPdOmffkLylaAh7A/OkWzSe3n
	oPsTBFCfh92DDJZCR/DHvgeQk/PJdijV3TNqiK3mNqykmzKRveHU87P8aG2oMY5txYu+6ujcYX6
	I4+Ce8yBg1h/frOycRkz4GB8YBNWtcxdDWG7rTu3L
X-Gm-Gg: ATEYQzzCDhmsoMlBA4y5YE9jWBQrpHbsr4d+vwL5PTZ+6V856MZBdRPS2IWDg3gSZMf
	Ldd4zE9U7pEZXg+mQk9a2XA5D2hOGjyP+aa52od9o453UWPLOnTLHIsAPvKYnI5w6HJwfgtDjjV
	IV02cGfj8X2i8GXSs0UoI7aVz949gQKYeOxcdKuFby7F5YJ6hj7WxuBCNmH4ZNhlvxuYAAAplvH
	28uwYBGIKJZLEYpaNUvpr0COatabz5CCweT4I9po/v626l6QUDuLJ6JbZ/9miPcmIKRmqgpkIf4
	Ka53iCZ9hNw6cDCECVqvHsQu0sq3UlbRtoyld6UeG/epbiTY1TDc4Dn89pJZUWeLS0J8yQ==
X-Received: by 2002:a05:6102:3e84:b0:5dd:89af:459b with SMTP id
 ada2fe7eead31-5ff05d62336mr520728137.7.1772004684941; Tue, 24 Feb 2026
 23:31:24 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 23:31:24 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 23:31:23 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgESctVm9CcEyK36hY8Ta=DEDOS1oW5w0qRDoNfdd=470g@mail.gmail.com>
References: <cover.1771826352.git.ackerleytng@google.com> <a97045a9-8866-40fe-aa15-d319cafa6f2c@kernel.org>
 <CAEvNRgFF0+g9pmp1yitX48ebK=fDpYKSOQDmRfOjzSHxM5UpeQ@mail.gmail.com>
 <9ef9a0bd-4cff-4518-b7fb-e65c9b761a5a@kernel.org> <CAEvNRgESctVm9CcEyK36hY8Ta=DEDOS1oW5w0qRDoNfdd=470g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 23:31:23 -0800
X-Gm-Features: AaiRm51zoZaexsL8AgLT-NSu-LX5kDXX-7Kv8iZiX_RuOJxbA-22InSuIouRjL8
Message-ID: <CAEvNRgFyRsqhv7CuuDARHTFSanzOHaudM6JMBLwxDwsrjTNCGQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78346-lists,linux-fsdevel=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 87F5B1938B5
X-Rspamd-Action: no action

Ackerley Tng <ackerleytng@google.com> writes:

> "David Hildenbrand (Arm)" <david@kernel.org> writes:
>
>>
>> [...snip...]
>>
>>>> Could we maybe have a
>>>> different callback (when the mapping is still guaranteed to be around)
>>>> from where we could update i_blocks on the freeing path?
>>>
>>> Do you mean that we should add a new callback to struct
>>> address_space_operations?
>>
>> If that avoids having to implement truncation completely ourselves, that might be one
>> option we could discuss, yes.
>>
>> Something like:
>>
>> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
>> index 7c753148af88..94f8bb81f017 100644
>> --- a/Documentation/filesystems/vfs.rst
>> +++ b/Documentation/filesystems/vfs.rst
>> @@ -764,6 +764,7 @@ cache in your filesystem.  The following members are defined:
>>                 sector_t (*bmap)(struct address_space *, sector_t);
>>                 void (*invalidate_folio) (struct folio *, size_t start, size_t len);
>>                 bool (*release_folio)(struct folio *, gfp_t);
>> +               void (*remove_folio)(struct folio *folio);
>>                 void (*free_folio)(struct folio *);
>>                 ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>>                 int (*migrate_folio)(struct mapping *, struct folio *dst,
>> @@ -922,6 +923,11 @@ cache in your filesystem.  The following members are defined:
>>         its release_folio will need to ensure this.  Possibly it can
>>         clear the uptodate flag if it cannot free private data yet.
>>
>> +``remove_folio``
>> +       remove_folio is called just before the folio is removed from the
>> +       page cache in order to allow the cleanup of properties (e.g.,
>> +       accounting) that needs the address_space mapping.
>> +
>>  ``free_folio``
>>         free_folio is called once the folio is no longer visible in the
>>         page cache in order to allow the cleanup of any private data.
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 8b3dd145b25e..f7f6930977a1 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -422,6 +422,7 @@ struct address_space_operations {
>>         sector_t (*bmap)(struct address_space *, sector_t);
>>         void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
>>         bool (*release_folio)(struct folio *, gfp_t);
>> +       void (*remove_folio)(struct folio *folio);
>>         void (*free_folio)(struct folio *folio);
>>         ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>>         /*
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 6cd7974d4ada..5a810eaacab2 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -250,8 +250,14 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>>  void filemap_remove_folio(struct folio *folio)
>>  {
>>         struct address_space *mapping = folio->mapping;
>> +       void (*remove_folio)(struct folio *);
>>
>>         BUG_ON(!folio_test_locked(folio));
>> +
>> +       remove_folio = mapping->a_ops->remove_folio;
>> +       if (unlikely(remove_folio))
>> +               remove_folio(folio);
>> +
>>         spin_lock(&mapping->host->i_lock);
>>         xa_lock_irq(&mapping->i_pages);
>>         __filemap_remove_folio(folio, NULL);
>>
>
> Thanks for this suggestion, I'll try this out and send another revision.
>
>>
>> Ideally we'd perform it under the lock just after clearing folio->mapping, but I guess that
>> might be more controversial.
>>

I'm not sure which lock you were referring to, I hope it's not the
inode's i_lock? Why is calling the callback under lock frowned upon?

I found .remove_folio also had to be called from
delete_from_page_cache_batch() for it to work. Then I saw that both of
those functions already use filemap_unaccount_folio(), and after all,
like you said, guest_memfd will be using this callback for accounting,
so in RFC v2 [1] I used .unaccount_folio instead, and it is called under
the inode's i_lock from filemap_unaccount_folio().

[1] https://lore.kernel.org/all/20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com/T/

>> For accounting you need the above might be good enough, but I am not sure for how many
>> other use cases there might be.
>>
>> --
>> Cheers,
>>
>> David

