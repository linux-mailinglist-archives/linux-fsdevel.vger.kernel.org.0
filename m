Return-Path: <linux-fsdevel+bounces-76121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF8cOlV7gWmOGgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 05:36:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045FD46FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 05:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F38305B0AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB73248176;
	Tue,  3 Feb 2026 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YUCJCIX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916521146C;
	Tue,  3 Feb 2026 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770093373; cv=none; b=hSohTlFmQGKePS/GeOYV+c/j24v1Fu4gFFBcnb7Rh9GieWtIDnz7aT7bDb4BdL4ERnWHBYGLmlzB8ZLVR5nAUcPy9eME69WnHE+/N1Vm2SW4HToQ8/EMI+PACSxEiE63jTXy9kKL7NNAq+NRdr1js77Tl1kL07xiXZE9n72hOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770093373; c=relaxed/simple;
	bh=yiJG4EjQQZFqFqXjwnZEimHyL2LjmICFdrgXgZ/8RBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC1ukd76/SODWLlPjbPXGJPIgK2qeM2CYaPNi4emdsEnTv1MuOj4eNfkkQuBKYuDl0PUoxaQ5ohnTuW4qYFZ+NlpLWAxmDX7TBMMpUYA2WcRs1EGEsHNwzadKhvEqBvG3Z8xO5sxriCDUQOPYodEYwPs71ojTd/VxT8khZxvJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YUCJCIX+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cC/gnzDITw0jWfBHsul9GIfuHlfa//WvbBRB1wNvZ5Q=; b=YUCJCIX+DTdnAE0wv7j6Ws5Khe
	YmqEPS/ipChFih31va2p3dHy2gmk91PEwFAjpzDW1Oun67ig5vFq/L5nfHFcH1gzlhN0+yktbjnKB
	aEhZkPf9lusgpSEgIVx/knmL535K4Eu/pu5pTjshJSrN5C/KqG0ccApKp9NgxBUVC740Ljdxe8ayU
	pJcrab1b5/d9QJeAO0Bj89aKjUYx8JG14Kj10qglfneTjC7wpcJfWUedpU2E4stlOM+OOB1hW20Ri
	ZWNTr5i7kQNnaPp1FODcggTCAfmq7fbA8qQEzOZiiP994IWq6dTuot2TAMviS0O1gXwzVbzOVNEbH
	OwwYjHSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vn8Aw-0000000Eprp-0XUO;
	Tue, 03 Feb 2026 04:38:06 +0000
Date: Tue, 3 Feb 2026 04:38:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"shardulsb08@gmail.com" <shardulsb08@gmail.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com" <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Message-ID: <20260203043806.GF3183987@ZenIV>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76121-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,vivo.com,vger.kernel.org,mpiricsoftware.com,suse.cz,kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5045FD46FF
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:53:57PM +0000, Viacheslav Dubeyko wrote:
> >  out_unload_nls:
> > -	unload_nls(sbi->nls);
	^^^^^^^^^^^^^^^^^^^^
> >  	unload_nls(nls);
> > -	kfree(sbi);

> The patch [1] fixes the issue and it in HFS/HFS+ tree already.

AFAICS, [1] lacks this removal of unload_nls() on failure exit.
IOW, the variant in your tree does unload_nls(sbi->nls) twice...

