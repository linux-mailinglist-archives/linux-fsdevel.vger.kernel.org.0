Return-Path: <linux-fsdevel+bounces-79370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INW8EZg2qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:41:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BB220090F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 212FA303418C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35333389106;
	Wed,  4 Mar 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz9Q10ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9134CFC6;
	Wed,  4 Mar 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631639; cv=none; b=Dbw3cV5yiaDjefIwnpNOuBqsIV8i1KLvj0gOZTWHITPi+1cl+dzfQTW33uoQrBL7BmUsGxvOhratv1AuM0ZqLuQkeySFejBK+D0Wn1dajVePJWcZCza0W6cl0JL6Y+LFImvoCVWFxAoa48aWGO1Uezu2ihGvoJN33DtzSetiBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631639; c=relaxed/simple;
	bh=saBpvESaGj5QiqSpFfWOGnf8j0MOslSLXlBi7/U5dHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp3mRDJdDLDCNTVhJ0FOjMiCWglOrv7r7q6WGWoCwr1Vi+3PLNwaZkHlSYTKqubVts9Eh51plsNMQoq39q+P3gy4xuC4jh/kty6bmcyjuvqbDWTVmBO3iGdSKKFzQubLdsA5fS9ezwGuTZBIqTjO8bbkVCKfHjghub0Bws6gZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz9Q10ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17945C19423;
	Wed,  4 Mar 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772631639;
	bh=saBpvESaGj5QiqSpFfWOGnf8j0MOslSLXlBi7/U5dHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz9Q10cesxvicAfZAxJWsJipenbgc+L+GNBCNpgox/ApeDmUPPNe8bReiHFtdKJCo
	 YDJrcx41hrcP49safkalWHRbQyMbDCsHrAYtLJLIZsdZrE0bJ6Utugirq3RpNrvbZO
	 FHWGLQu8SALp+v14qeuSUvgpocfy3rK1dggz0b3mdpAENAGW19TwVxKlHXFttwaBBN
	 9doonxpzjRixTTqINhTaW9bdDXsZKwniR6coFVIkE9yZoYJn9u4qPvJs7mZhBc07jy
	 mvSFumdnatCpc4H+iN0pw8E1ysCu1zZ7LDRKoVLOgExDFMBxxcINf3rkkQfAzvtlq7
	 VguxGnHd/toJA==
Date: Wed, 4 Mar 2026 14:40:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 31/32] kvm: Use private inode list instead of
 i_private_list
Message-ID: <20260304-mahnung-ableisten-50d5c4e71013@brauner>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-63-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303103406.4355-63-jack@suse.cz>
X-Rspamd-Queue-Id: 43BB220090F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79370-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:34:20AM +0100, Jan Kara wrote:
> Instead of using mapping->i_private_list use a list in private part of
> the inode.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  virt/kvm/guest_memfd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 017d84a7adf3..6d36a7827870 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -30,6 +30,7 @@ struct gmem_file {
>  struct gmem_inode {
>  	struct shared_policy policy;
>  	struct inode vfs_inode;
> +	struct list_head gem_file_list;

I think that needs to be gMem_file_list not, gem_file_list.

