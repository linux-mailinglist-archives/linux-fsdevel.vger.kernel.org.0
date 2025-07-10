Return-Path: <linux-fsdevel+bounces-54451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EE1AFFCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306893A5B45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539928CF4A;
	Thu, 10 Jul 2025 08:50:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B05221FC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137448; cv=none; b=cn3hiaPoiGMWkrwIh6gn0yQ5XE6gx8c/VNJrkNaw3/VI1qz4QloOH1BgWgRZaYsvVGCNjvk+Q0GW/XFW9GJOM2NVocZIRUs0frd9mhEf4u8LycZupAUynP92Wi/qK0ncvgeC4LU8HpM8+zpmTums2EF861GRGI86Y68LHt4gdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137448; c=relaxed/simple;
	bh=gtoFN/m9CZ99MDGHxuvIfNNcpaq5x6Z+BwUXU9uypRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opktrdk+DaQwqmM5nJ9OPfNdLxsOAZkZDIUdul3WT9GkfugGKgdG2+9dwRD/meTrmGlmwLCQNKJuV5aDlpiXq0q9UvACpq/45+ZlYzvwsUMy5szZlsx95XO5VwniwYjf7GVUzFB+87jzCQCVqI//75H6+fU8Sde++/aqOWNZc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A374521170;
	Thu, 10 Jul 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91404136CB;
	Thu, 10 Jul 2025 08:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rgLKIeV+b2h4PwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 10 Jul 2025 08:50:45 +0000
Date: Thu, 10 Jul 2025 10:51:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	Christian Brauner <brauner@kernel.org>, lkp@intel.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>, oe-lkp@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [fs]  9eb22f7fed: ltp.uevent01.fail
Message-ID: <aG9_CG6Gy1DzXO0m@yuki.lan>
References: <202507100657.c1353cf9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507100657.c1353cf9-lkp@intel.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A374521170
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Hi!
I suppose this is the same problem as:

https://lists.linux.it/pipermail/ltp/2025-July/044243.html

and the kernel fix is being discussed in:

https://lists.linux.it/pipermail/ltp/2025-July/044278.html

-- 
Cyril Hrubis
chrubis@suse.cz

