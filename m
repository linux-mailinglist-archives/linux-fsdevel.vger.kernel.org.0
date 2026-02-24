Return-Path: <linux-fsdevel+bounces-78229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPqYAoZtnWkkQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:21:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B11184752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74573102152
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C936B040;
	Tue, 24 Feb 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYFcGsYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC536A01A;
	Tue, 24 Feb 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924511; cv=none; b=fF1qjP6yiGMAAcfcm+hxxgZtf+nHUQ3bBb4pDGLOJIMhEJu3DHjxDsT244Yi55CY2xsLZVeEwvuCFeRodpK3Ci2U2Aa4uGD599ClXZJg8kuA1NR/TGn5kIC8PP1JrGcS+pQxDMK+EUUjBY0O7FPJdDaO6gA80gblf+66HZ8G4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924511; c=relaxed/simple;
	bh=O0t2735+nj7D5NyA0z9OPkEBEorfBUQqoJi+WyGdkcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZolaohG6asXfqayfIfT+7MWBEmAAXA7VPwlzIN/gZFTmfHsJL237NvRSXyem6R5mzcc1X1QAWMIzPCxvQ4Ct2ZoodzTSLhEeH0aPxefNu0usx6SHZL7i6yeUhNm/RmPz+/NcRTLjioee/26wC9jlc6iRkO++YkObxj502W+b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYFcGsYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41633C116D0;
	Tue, 24 Feb 2026 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771924510;
	bh=O0t2735+nj7D5NyA0z9OPkEBEorfBUQqoJi+WyGdkcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYFcGsYYC+XqQGQtq+Utn4VokQFbY74c1oH/uwKWt8UP151hP/3lLXmUEY4XcQkGX
	 K8KQIdLBhPSVNjygDjAjoQpPRRWiNY1KCA01wYEMpoBst1OLueveUTwYF+Hwlt+l/9
	 0Dcad2VPTsSDaMcuLtw9cSdMJ64a0AxPfs5dDlogZEQ9T1l2KTmOq+BkzLBZoyJ127
	 Yn3Kp3t65R95Nv5daslOeSIyVza37pve7RlhZBhGIvIxDKwnXtbux4fDGXQt5zpR/j
	 XY++eleAbGTcZ6cVZVu/l9fwOBOveORquOn07MC17Go7xBo0aTqn5yYSpUf0K8ty1h
	 WNn3EENZT5gcQ==
Date: Tue, 24 Feb 2026 10:15:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Shyam Prasad N <nspmangalore@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
Message-ID: <20260224-ablegen-leben-bfa66d855048@brauner>
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
 <20260224051729.GB1762976@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224051729.GB1762976@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78229-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75B11184752
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:17:29AM +0000, Al Viro wrote:
> On Tue, Feb 17, 2026 at 10:15:58AM +0530, Shyam Prasad N wrote:
> > Filesystems today use sget/sget_fc at the time of mount to share
> > superblocks when possible to reuse resources. Often the reuse of
> > superblocks is a function of the mount options supplied. At the time
> > of umount, VFS handles the cleaning up of the superblock and only
> > notifies the filesystem when the last of those references is dropped.
> > 
> > Some mount options could change during remount, and remount is
> > associated with a mount point and not the superblock it uses. Ideally,
> > during remount, the mount API needs to provide the filesystem an
> > option to call sget to get a new superblock (that can also be shared)
> > and do a put_super on the old superblock.
> > 
> > I do realize that there are challenges here about how to transparently
> > failover resources (files, inodes, dentries etc) to the new
> > superblock.
> 
> That's putting it way too mildly.  A _lot_ of places rely upon the following:
> 	* any struct inode instance belongs to the same superblock through the
> entire lifetime.  ->i_sb is assign-once and can be accessed as such.
> 	* any struct dentry instance belongs to the same superblock through
> the entire lifetime; ->d_sb is assign-once and can be accessed as such.  If it's
> postive, the corresponding inode will belong to the same superblock.
> 	* any struct mount instance is associated with the same superblock
> through the entire lifetime; ->mnt_sb is assign-once and can be accessed as such.
> 	* any opened file is associated with the same dentry and mount through
> the entire lifetime; mount and dentry are from the same superblock.
> 
> Exclusion that would required to cope with the possibility of the above
> being violated would cost far too much, and that's without going into the
> amount of analysis needed to make sure that things wouldn't break.

I'm very very skeptical about all of this and would really do everything
we can do avoid this...

