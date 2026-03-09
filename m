Return-Path: <linux-fsdevel+bounces-79738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BAFM0xormmADwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 07:27:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC82342C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 07:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA1A300B744
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39795359A62;
	Mon,  9 Mar 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8Jcy+Yd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA526CE32
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037641; cv=pass; b=dMHINPZScZ18yXmslhCee2HwgRsz0kaAiYISKMk+pofhKgT8HEhemAVW+rYdlsryhrPDt/YP7PIECu9trZ7aR28iNBeGRJBOtzZDk0+2n23J6w28et8Jlyjp4O5p7bjYUWM4riVY6XfpeIkIb+x645IuQ75qNZcuvoiBn4TA3w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037641; c=relaxed/simple;
	bh=tWJ/fX3Ckxq4WEzhukQr0K7T+NWwaaBTCqm8O0qx06M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko9Vw8Q93fRkwULIqITi52f5xGSZmWy2BagCJuUC+RftKoUJWieuaT3DNGB6Z4Uyr+EY3QlNOtrr5VEyobHpx2EnR0J2TCuyU0WCMhoEI/29+F54Npz8/hANRatl/IfR8XZgBd388zvtYZcKaAib7VRgjhu9CmkRAKhCz6NYgMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8Jcy+Yd; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5673804da95so4579105e0c.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 23:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773037640; cv=none;
        d=google.com; s=arc-20240605;
        b=Um23RvnetK5jmCai0ijhmfePBm1m0Z9FVnunRNwQDi6iue/MM1z1cnXSvADhI0LBX3
         zB0m/KSdAiSbAP+65ZvD1q/jRjXvq+BzzeeJbRfm1V1E/o3jXhLYOs9Y3o9RwQBO8rYp
         +29MKrpwNEEpha9zH4YV/stnbXX6I1a5OeRyD/wBLvy2lS/540yIXqHUVDkzCQsXQIRg
         QH95BURGAItHKiWZV2yXkFDvta32dkLLA9HGlnYjSpzzt2XqQJnViDpyrth9FAEuUEmy
         9ae3EOLcYDrMt8NmikIiRXNmiK2vG1trdJKhg/xRVkbLwJ0Is8CXFuiaLq0Ret5KNW1c
         /M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        fh=b2J9376jroSIsvaiKTvMLdn+9QVtORNlbyfbcQaKdTg=;
        b=O38IB301AHlFhcRhKc4BwdiCWi9eh4Em1RLRS/5r6G4tcHW7Uraxx3pMoRCVkkwUOd
         jBMWgNQIPqU5ZqKbqSpMj8y9pn+Mv06mOnT5My7JG8OnaGuwcQwpRUeUL9402fUW02uD
         NpPwoGrMl9Q+tOnHs2yp+kPiD2uuHkadla4txqgynqPsCNQQe3MF5lN13sgNMdvmEWBo
         PNv9DuxtNRtpiLQpmc0ijNfLEhyjem/Fb6lvJ4pPysEIBEhzX4hsGVfBeBD4oTDLWZtf
         CVlEHgU3QwHRCCQPCe7xBTHxgk090C8ewPdukLMKloT/3zaV+y6wWbNeW6IZKgo0CSbT
         7xJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773037640; x=1773642440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        b=d8Jcy+YdwSn+4Bbzc949cTnKTJFNiTdBMrU9a4ksr2mMY/dSAVrFWujH2eREgE7HHI
         uVlN4RjK77glzLTTrzMknFKwxjviGQo08iAbkuLjUuJ07ULvIfXIHORKAFtF+OQIvrY+
         u9JUXSrZuReCndfTA6dKntBG+VknhlLggx7xKo2fzURXUlAxy0f/PDrrmSWYiMqmZG8E
         aarh7r/xJFTfe9ZbRqJR6K5RghwtOmcgSN56byucRgNIx/Rtr/Yyf30B3Cd77ghJFjpk
         fT+tBrQeo05qqg8iGbMdokPo27v9XKif4T0H72tQpZvDzMSANKe8b/DbQer+sNAC8oZg
         zxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037640; x=1773642440;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        b=bj+Kpf7lBd1I2wwsdHN8cv4TlKCSQxMFqKvnXB3BKbqUHSqd1qLvC664brVogEJo7A
         +dzgklhQPJjgQTVBGOekMrCRg1R8eAguM8Sjwsb8TF9ExIgddKtisitX/TWYcUBFt2Mo
         h1XH6mCtRx3MRuLaxZkhd+aJrdcHX3sf+MU1qiRHAMOAchxwPtv9z5SOXgaVa4a4nlBb
         vH5yAyuCrqg53drr1+yDjSjCeB1PrMHh8Rta3o7fZx9/mbYDzSL9wlWBGDgP6QgRvcYJ
         1A+uAm/Ms5Z4s0ghryVlEXjWozerjq6uo2nH54842KnLWNUxK6LqI8z4Z0fzCGLbmUMB
         sV4w==
X-Forwarded-Encrypted: i=1; AJvYcCULT18bb4ht9aElxkmRWdM+gngtTO45zmt96ZFuMh3HK1gHtpzBtp1MQwIyq65gk6S+IOaVKlx7oclbZGQP@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHJmmPlMFoWRw0ABVhrq8GqSR8yRY0xpfKS8u9Nx+lNWG4s90
	RluXWi5bsMbbjsBHXjetS+rEWKjvJmUYu/3u5QrGdzn1+K+cjBuWTzJhIMn66yg08aapKCrqFDQ
	1M6U8/YK9pPTiTGbyds6P56lEn5hO9xfm1RsXNBuu
X-Gm-Gg: ATEYQzxLOanBVAun98muiC90V9IWauc8P9Rznx7HbP3oy/+atOl75jWro9ATYrBg6Ky
	XFKeCpgiHbKEl+2jxEOOjK2UykroKYxidjV6X3ziJeySYDXWEaLDExRXcmJ8S4RaMTbCIXqlOqv
	kxl35X4a2yoUU0K97KbNTSKIhcDIgfeq/ppGyJZkujxOmN1hUuZiu9EYVFYdy5iPlLn1K8SCMH4
	mJIdNYia4mrNiHrF9GwdjdR3LgkKz+elYlQcyOUUEh7xHcchevjZLoGQagrbE0f+5b/2EECDTx/
	iwoH4feBxFvNZDUmgotDHgx31uosehOW40bwcypi/II9gmTYAsSoHvAvpaJee7OYcfy/gw==
X-Received: by 2002:a05:6102:c01:b0:5db:f920:fa9a with SMTP id
 ada2fe7eead31-5ffe63cdb3fmr2925679137.41.1773037638925; Sun, 08 Mar 2026
 23:27:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:27:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:27:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aaWlxFh-bqUYXgUo@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com> <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
 <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com> <aaWlxFh-bqUYXgUo@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 8 Mar 2026 23:27:18 -0700
X-Gm-Features: AaiRm52XcCdEx1v_REqqEWCzJAbxKWYQSWfQ7emIhDTUFVwrkCx8Utez8oZPcxo
Message-ID: <CAEvNRgEzb6Ux+iVFT=F6jc_R8V=LTYCigHp+yaHFkdrX82-yvQ@mail.gmail.com>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
To: John Groves <John@groves.net>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 76BC82342C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-79738-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

John Groves <John@groves.net> writes:

>
> [...snip...]
>
>>
>> I'm implementing something similar for guest_memfd and was going to
>> reuse __split_folio_to_order(). Would you consider using the
>> __split_folio_to_order() function?
>>
>> I see that dax_folio_reset_order() needs to set f->share to 0 though,
>> which is a union with index, and __split_folio_to_order() sets non-0
>> indices.
>>
>> Also, __split_folio_to_order() doesn't handle f->pgmap (or f->lru).
>>
>> Could these two steps be added to a separate loop after
>> __split_folio_to_order()?
>>
>> Does dax_folio_reset_order() need to handle any of the folio flags that
>> __split_folio_to_order() handles?
>
> Sorry to reply slowly; this took some thought.
>

No worries, thanks for your consideration!

> I'm nervous about sharing folio initialization code between the page cache
> and dax. Might this be something we could unify after the fact - if it
> passes muster?
>
> Unifying paths like this could be regression-prone (page cache changes
> breaking dax or vice versa) unless it's really well conceived...
>

guest_memfd's (future) usage of __split_folio_to_order() is probably
closer in spirit to the original usage of __split_folio_to_order() that
dax's, feel free go ahead :)

For guest_memfd, I do want to use __split_folio_to_order() since I do
want to make sure that any updates to page flags are taken into account
for guest_memfd as well.

>>
>> >  static inline unsigned long dax_folio_put(struct folio *folio)
>> >  {
>> >  	unsigned long ref;
>> > @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>> >  	if (ref)
>> >  		return ref;
>> >
>> > -	folio->mapping = NULL;
>> > -	order = folio_order(folio);
>> > -	if (!order)
>> > -		return 0;
>> > -	folio_reset_order(folio);
>> > +	order = dax_folio_reset_order(folio);
>> >
>> > +	/* Debug check: verify refcounts are zero for all sub-folios */
>> >  	for (i = 0; i < (1UL << order); i++) {
>> > -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>> >  		struct page *page = folio_page(folio, i);
>> > -		struct folio *new_folio = (struct folio *)page;
>> >
>> > -		ClearPageHead(page);
>> > -		clear_compound_head(page);
>> > -
>> > -		new_folio->mapping = NULL;
>> > -		/*
>> > -		 * Reset pgmap which was over-written by
>> > -		 * prep_compound_page().
>> > -		 */
>>
>> Actually, where's the call to prep_compound_page()? Was that in
>> dax_folio_init()? Is this comment still valid and does pgmap have to be
>> reset?
>
> Yep, in dax_folio_init()...
>

On another look, prep_compound_tail() in prep_compound_page() is the
one that overwrites folio->pgmap, by writing to page->compound_head,
which aliases with pgmap.

No issues here. I was just comparing the before/after of this
refactoring and saw that the comment was dropped, which led me to look
more at this part.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> Thanks,
> John
>
> [snip]

