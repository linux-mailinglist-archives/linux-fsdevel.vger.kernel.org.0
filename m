Return-Path: <linux-fsdevel+bounces-76189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK61MFXygWlAMwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:04:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DDD9957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D5B03019309
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B662F34F484;
	Tue,  3 Feb 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKO0xns6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E234EEF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123729; cv=none; b=mrDZtHQURpeclUTJRO9SHeZhqmM2P5PUMIxBIJcutNXGUaPmDGUBacLSlQKxJ5Jc5JOVEesLjRfwg5OJew1t0WIIyQQnvWYWp8AXsQa5jSo+XrOGJLeCbPzCkjweQbgoQjeIRtpWsESzJ8j+pYhApICmoegBhTuJZYNdwCvHVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123729; c=relaxed/simple;
	bh=x7CBvSFaDttK0z+9Lff5CEWjn9qvxzprABOSzrPJWhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnueAryEcSUOWFJUIeKFKcZFoNoDnx+WxUR4VspJW9bVUOfkYtX1A8R+qApngXKSuxhtwLqaH3f4XEaEOTsuZySp75vYacY0+jXZ/+tF+MVrqymck5drTCsEO7RKqkiv8Ks+q6ZqrxmbgFerBzqQLsr4SQXNUR3NYwfHm4rxCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKO0xns6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF7C2BCB5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123728;
	bh=x7CBvSFaDttK0z+9Lff5CEWjn9qvxzprABOSzrPJWhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CKO0xns6OCiMyG1zQlwSifGKXPZKNJ/uNvS3WAQ1sHhIyJmsculYS2+V6+/3jdjF5
	 RW9b8nJ00jklK/60xGjUcfPoOuw2NJ5+El73Kc3Aod6aCoNCt71ZsOFScrBPjUlSBX
	 7kL5op6S3088+zSmlzjTdneiFRpHJsigVRVzsh/d1S6isS23zrAbkgBD9XDrGAtc1J
	 hQ/KPtVoBfKH789w4X889uLxBXT93A4j5stpNg6WkXx+9StAUMGxjAIH/9V/4/nqYI
	 /yL7Ntap/SIQvt416LjGrhCccLYu/lhVi5ZZsRdwgIggihw1ySDYHoZGAqJgOgehAR
	 TDe+bvrPHjVeg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so7698205a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTljVS3vxmqQCRVr/7go6rZLpNhnRlRQI39GIUC82gTd3Xe5DMbUlWiADnTTkxifLfukjiRu+Khe21/8uF@vger.kernel.org
X-Gm-Message-State: AOJu0YynGbBb9fxrf9D2JhtBsGAxxnIw9grDYaKVK1/8Nt55KtLOHqvX
	Ql1c967hO3qJMgYgEVC4qRt5b6uQKsZog923642Hp/7QyUi47R/TQ2IfBog/syIVKkw5/yVUuc9
	oUC+8AdY/CngKejn0JQfwaxGDOK0jszE=
X-Received: by 2002:a05:6402:2711:b0:658:b3ed:64e9 with SMTP id
 4fb4d7f45d1cf-658de5ad6c9mr9678694a12.33.1770123727184; Tue, 03 Feb 2026
 05:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-3-linkinjeon@kernel.org>
 <20260203054426.GA16426@lst.de>
In-Reply-To: <20260203054426.GA16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 22:01:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-3c=4MLsdwuCnit6NKX49QzfShwwitj54M5MnMj=EWgQ@mail.gmail.com>
X-Gm-Features: AZwV_QhItzYFSF8vb3hW9frWgY13ZALD7TPUqf9QqkvCKcU2XEkIlWbmEZUBVZA
Message-ID: <CAKYAXd-3c=4MLsdwuCnit6NKX49QzfShwwitj54M5MnMj=EWgQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/16] Documentation: filesystems: update NTFS driver documentation
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76189-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 214DDD9957
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 2:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Feb 03, 2026 at 07:01:48AM +0900, Namjae Jeon wrote:
> > Update the NTFS driver documentation (Documentation/filesystems/ntfs.rs=
t)
> > to reflect the current implementation state after switching to iomap an=
d
> > folio instead buffer-head.
> >
> > Changes include:
>
> "Changes include" doesn't really add much value, and feels like AI
> slop.
>
> I'd rewrite the message as:
>
> Update the NTFS driver documentation to reflect the update implementation=
.
> Remove outdated sections (web site, old features list, known bugs,
> volume/stripe sets with MD/DM driver, limitations of old driver), add a
> concise overview of current driver features and long-term maintenance
> focus, add a utilities support section pointing to ntfsprogs-plus project
> and update mount options list with current supported options.
Okay, I will use this in the next version.
>
> I'd probably also move this last in the series.
Okay.
>
> > +nls=3Dname             Deprecated option.  Still supported but please =
use
> > +                        iocharset=3Dname in the future.
>
> A lot of these mount options sections starts the first line with tab
> indentation and then continue with spaces only.  Please stick to one
> of them.
Okay, I will update it in the next version.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks for your review!

