Return-Path: <linux-fsdevel+bounces-52581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA92EAE461D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC8188AAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C52130E58;
	Mon, 23 Jun 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U5ZqaRt2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVexpCh/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U5ZqaRt2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVexpCh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1A76C61
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688003; cv=none; b=OLTuZhHj+KV78rhIyLMnPcTdy9SGUnKJthbtAT4XPS9XeUz0dKpEeYQVPAesLG3AOMUWIQ+kKhdAbT0a5b5Sq7et5qbG8fEfEo5OUUbQ3//+TsM+lOmaE+Wh+pqKmvzaA6ODlnKskbz21pCpBG8mqKnS+qlPUolLnNf9bzVjFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688003; c=relaxed/simple;
	bh=rA/0aYT079YZbJ1g0W4vBCo1CQuRC+BBMH0T2NmEhz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk0T5h1TxYhx90GxWvVJqcqSr1sTNuv+E6q+yX7DNSAZM+Ik34TJ1dFeeUHUu3xZzLxhGQGyUN3RkzqafYiOXE2qP8ACSZP9ieoz2+NT7QUP0fVE7ByuWY7QPLwV6jb0zQtwyVzIIJUQFhcGMJ6iL32WjPKidVyYZ7gAhWWxnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U5ZqaRt2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVexpCh/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U5ZqaRt2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVexpCh/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 347F021179;
	Mon, 23 Jun 2025 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lADc/8kE752BhxoOtNBA4BLJ16fQqPkxmPRbOD7u0sc=;
	b=U5ZqaRt2aDokyJJ2YZQahJs3bQHTkXIYqXhfdR5mGYhHt9JYMNOgWZEmgXRRHRfpToNDwf
	sHTQFpQdxMQK9flAUSvFHm20CCoM7fIoX9CeTCI7y8p3GkwtMmFgUB+Cel/XOFicoCM7BF
	AZoZeOVGzecueNsF0oN050bwdGzH7LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lADc/8kE752BhxoOtNBA4BLJ16fQqPkxmPRbOD7u0sc=;
	b=rVexpCh/kQH0BW5jRIKacs1JBvPI1Ca52kZ9vhQAMqd41mhS3pga2UIlU6BTt52bFVA7Ej
	IxHI/9H+wxf74RBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lADc/8kE752BhxoOtNBA4BLJ16fQqPkxmPRbOD7u0sc=;
	b=U5ZqaRt2aDokyJJ2YZQahJs3bQHTkXIYqXhfdR5mGYhHt9JYMNOgWZEmgXRRHRfpToNDwf
	sHTQFpQdxMQK9flAUSvFHm20CCoM7fIoX9CeTCI7y8p3GkwtMmFgUB+Cel/XOFicoCM7BF
	AZoZeOVGzecueNsF0oN050bwdGzH7LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lADc/8kE752BhxoOtNBA4BLJ16fQqPkxmPRbOD7u0sc=;
	b=rVexpCh/kQH0BW5jRIKacs1JBvPI1Ca52kZ9vhQAMqd41mhS3pga2UIlU6BTt52bFVA7Ej
	IxHI/9H+wxf74RBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F91313485;
	Mon, 23 Jun 2025 14:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f0d3AwBhWWhxYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 23 Jun 2025 14:13:20 +0000
Message-ID: <39f95eb9-c494-4967-8d4d-9768200637f4@suse.cz>
Date: Mon, 23 Jun 2025 16:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>, David Hildenbrand <david@redhat.com>,
 akpm@linux-foundation.org, brauner@kernel.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk
Cc: seanjc@google.com, willy@infradead.org, pbonzini@redhat.com,
 tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
 <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
 <3114d54f-ed7c-4c68-9d32-53ce04175556@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <3114d54f-ed7c-4c68-9d32-53ce04175556@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,infradead.org,redhat.com,suse.cz,googlemail.com,intel.com,amazon.co.uk,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Level: 

On 6/23/25 16:08, Shivank Garg wrote:
> 
> 
> On 6/23/2025 7:21 PM, David Hildenbrand wrote:
>> On 20.06.25 09:03, Shivank Garg wrote:
>>> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
>>> anonymous inodes with proper security context. This replaces the current
>>> pattern of calling alloc_anon_inode() followed by
>>> inode_init_security_anon() for creating security context manually.
>>>
>>> This change also fixes a security regression in secretmem where the
>>> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
>>> LSM/SELinux checks to be bypassed for secretmem file descriptors.
>>>
>>> As guest_memfd currently resides in the KVM module, we need to export this
>>> symbol for use outside the core kernel. In the future, guest_memfd might be
>>> moved to core-mm, at which point the symbols no longer would have to be
>>> exported. When/if that happens is still unclear.
>>>
>>> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> 
>> 
>> In general, LGTM, but I think the actual fix should be separated from exporting it for guest_memfd purposes?
>> 
>> Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does not exist yet ...
>> 
> I agree. I did not think about backporting conflicts when sending the patch.
> 
> Christian, I can send it as 2 separate patches to make it easier?

The proper way is to send the fix without the export, and then add the
export only when adding its user.

> Thanks,
> Shivank


