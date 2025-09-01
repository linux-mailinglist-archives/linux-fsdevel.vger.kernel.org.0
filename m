Return-Path: <linux-fsdevel+bounces-59903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE63B3EDA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E6D1B200D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16A324B25;
	Mon,  1 Sep 2025 18:11:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A6324B06
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750262; cv=none; b=KI92zjxuakvISlUoFCy3TFCrGTFjmoQa5Cui3RZ4ohyDKpZqYqg3RiddW8Aun1/Achmpza3rd96GW98j4iiGOBQzskjQ4gPfh00V74tCiRCxAmQlraRW3bpaA97KnN5KQZ8E42beelAWXBA3FkVcyoCVFOTRjUg3iezdhtt7SGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750262; c=relaxed/simple;
	bh=4HLv4bz2KV2gDTadScFI5S25hrhMr8s9VC3XJRfuwq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CROUTYHuTL1KTT7pXPuvRillqnHUQqA+9tmTlBU4twoqtTkf8v9+sMZRzf3JbzNw8tXQ9uZDES+hVx+E/npkWiqDBLWYzIiycCKTSt/CM4ND4y4gESvYHIJ9kgCY7B3eZkd0qhgN3xVLwID6s03Wmo2jY9lOEwOyX7W2QALeNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F172D211BA;
	Mon,  1 Sep 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E15D7136ED;
	Mon,  1 Sep 2025 18:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xcd5NrLhtWjtEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Sep 2025 18:10:58 +0000
Date: Mon, 1 Sep 2025 20:10:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: cache max and min order inside btrfs_fs_info
Message-ID: <20250901181057.GD5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756703958.git.wqu@suse.com>
 <d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F172D211BA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Sep 01, 2025 at 02:54:04PM +0930, Qu Wenruo wrote:
> Inside btrfs_fs_info we cache several bits shift like sectorsize_bits.
> 
> Apply this to max and min folio orders so that every time mapping order
> needs to be applied we can skip the calculation.
> 
> Furthermore all those sectorsize/nodesize shifts, along with the new
> min/max folio orders have a very limited value range by their natures.
> 
> E.g. blocksize bits can be at most ilog2(64K) which is 16, and for 4K
> page size and 64K block size (bs > ps) the minimal folio order is only
> 4.
> Neither those number can even exceed U8_MAX, thus there is no need to
> use u32 for those bits.
> 
> Use u8 for those members to save memory.

The reason for u32 is that it generates a bit better assembly code, we
don't have to save each byte in fs_info so please keep it u32.

