Return-Path: <linux-fsdevel+bounces-79357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCEuDbcxqGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:20:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B52004F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC80E307E0B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B62ED84C;
	Wed,  4 Mar 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EltZ96KH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33C1A683E;
	Wed,  4 Mar 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630260; cv=none; b=eYeuY58xiuq8zcSt3HzSdGMTDlhV8yAyIFbuQ4/l5MQd5Cf/JVwJE/sAPc1ij8PNQgfIsQQiYSijv6vTrcONKK47k4j8z/wVPqioy12IHCMBBs9KagZFB/JZn0uH0O1xUs3/tDWG24UizL2VlL5Qi7G99t5gSvYlT7dSbpbcjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630260; c=relaxed/simple;
	bh=1DQ0xxsyCnqRUFYicdXYhqHVlFBQL2aUvktm9rayPgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTxl+mPWfkDmBoyQcJo7MzER0vCVyOHaZMAn9+1XPsS2vcjgVHsSblyxrPnoEfer+16F4pGgv3/ozh8EM/fIUsUBrHXzZ5s5MC6MGjOzgXJZj8EtJotFnaBqqKUQlQLJ28V2DQHNM0I0xnubiVjinnjhi+Bi2SejK6fvMFVoVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EltZ96KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC31C19423;
	Wed,  4 Mar 2026 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630260;
	bh=1DQ0xxsyCnqRUFYicdXYhqHVlFBQL2aUvktm9rayPgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EltZ96KH8Sg1iLsEcSojjfcFwNSgaI8Kp3Imxh2FhAmPZUwjsgSxWRJ9M76Fs5bE5
	 0jKKaQ5sMgiW3YRkEV1fDnPXvxgTij9tt4KwNtHNvnY+JhbjD6t0tHEs6z3xkkiQiY
	 Gj0S7D5oXkkUpT/j0sRnlV9hhFagAcX+NQqtjxYR6nva3/1vK/eMa/p9Gwiu5Cp6k0
	 V75jzav0eh5g4KY2RxDiCmjY5nunU2vGiHk+up3tAebgDJwNj0KEZovljTOj6ZXWTr
	 Bnqki+S63IPNRfMMZIEehBC8d0rz+pbdUZGq8zGXeskLR0wzqlbLW2YT8vdPgBJNyI
	 tpoZhPWqilb8g==
Date: Wed, 4 Mar 2026 14:17:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>, 
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
Message-ID: <20260304-lagebericht-narrte-a85cfc96fffd@brauner>
References: <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>
 <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>
 <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
 <d65b010cec3df6d999becf8afb3186d2a101a369.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d65b010cec3df6d999becf8afb3186d2a101a369.camel@kernel.org>
X-Rspamd-Queue-Id: 8E9B52004F9
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
	TAGGED_FROM(0.00)[bounces-79357-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,brown.name,gmail.com,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:53:17PM -0500, Jeff Layton wrote:
> On Mon, 2026-03-02 at 18:37 +0100, Jan Kara wrote:
> > On Mon 02-03-26 12:10:52, Jeff Layton wrote:
> > > On Mon, 2026-03-02 at 16:26 +0100, Jan Kara wrote:
> > > > On Mon 02-03-26 08:57:28, Chuck Lever wrote:
> > > > > On 3/1/26 11:09 PM, NeilBrown wrote:
> > > > > > On Mon, 02 Mar 2026, Chuck Lever wrote:
> > > > > > > On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > > > > > > > On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> > > > > > > > > Perhaps that description nails down too much implementation detail,
> > > > > > > > > and it might be stale. A broader description is this user story:
> > > > > > > > > 
> > > > > > > > > "As a system administrator, I'd like to be able to unexport an NFSD
> > > > > > > > 
> > > > > > > > Doesn't "unexporting" involve communicating to nfsd?
> > > > > > > > Meaning calling to svc_export_put() to path_put() the
> > > > > > > > share root path?
> > > > > > > > 
> > > > > > > > > share that is being accessed by NFSv4 clients, and then unmount it,
> > > > > > > > > reliably (for example, via automation). Currently the umount step
> > > > > > > > > hangs if there are still outstanding delegations granted to the NFSv4
> > > > > > > > > clients."
> > > > > > > > 
> > > > > > > > Can't svc_export_put() be the trigger for nfsd to release all resources
> > > > > > > > associated with this share?
> > > > > > > 
> > > > > > > Currently unexport does not revoke NFSv4 state. So, that would
> > > > > > > be a user-visible behavior change. I suggested that approach a
> > > > > > > few months ago to linux-nfs@ and there was push-back.
> > > > > > > 
> > > > > > 
> > > > > > Could we add a "-F" or similar flag to "exportfs -u" which implements the
> > > > > > desired semantic?  i.e.  asking nfsd to release all locks and close all
> > > > > > state on the filesystem.
> > > > > 
> > > > > That meets my needs, but should be passed by the linux-nfs@ review
> > > > > committee.
> > > > > 
> > > > > -F could probably just use the existing "unlock filesystem" API
> > > > > after it does the unexport.
> > > > 
> > > > If this option flies, then I guess it is the most sensible variant. If it
> > > > doesn't work for some reason, then something like ->umount_begin sb
> > > > callback could be twisted (may possibly need some extension) to provide
> > > > the needed notification? At least in my naive understanding it was created
> > > > for usecases like this...
> > > > 
> > > > 								Honza
> > > 
> > > umount_begin is a superblock op that only occurs when MNT_FORCE is set.
> > > In this case though, we really want something that calls back into
> > > nfsd, rather than to the fs being unmounted.
> > 
> > I see OK.
> > 
> > > You could just wire up a bunch of umount_begin() operations but that
> > > seems rather nasty. Maybe you could add some sort of callback that nfsd
> > > could register that runs just before umount_begin does?
> > 
> > Thinking about this more - Chuck was also writing about the problem of
> > needing to shutdown the state only when this is the last unmount of a
> > superblock but until we grab namespace_lock(), that's impossible to tell in
> > a race-free manner? And how about lazy unmounts? There it would seem to be
> > extra hard to determine when NFS needs to drop it's delegations since you
> > need to figure out whether all file references are NFS internal only? It
> > all seems like a notification from VFS isn't the right place to solve this
> > issue...
> > 
> 
> The issue is that traditionally, "exportfs -u" is what unexports the
> filesystem and at that point you can (usually) unmount it. We'd ideally
> like to have a solution that doesn't create extra steps or change this,
> since there is already a lot of automation and muscle memory around
> these commands.
> 
> This method mostly works with v3, since there is no long term state
> (technically lockd can hold some, but that's only for file locking).
> With v4 that changed and nfsd holds files open for much longer.
> 
> We can't drop all the state when fs is unexported, as it's not uncommon
> for it to be reexported soon afterward, and we can't force a grace
> period at that point to allow reclaim.
> 
> Unmounting seems like the natural place for this. At the point where
> you're unmounting, there can be no more state and the admin's intent is
> clear. Tearing down nfsd state at that point seems pretty safe.
> 
> If we can't add some sort of hook to the umount path, then I'll
> understand, but it would be a nice to have for this use-case.

At first glance, umount seems like a natural place for a lot of things.

The locking and the guarantees that we have traditionally given to
userspace make it a very convoluted codepath and I'm very hesitant to
add more complexity in this part of the code.

Now I suggested the fsnotify mechanism because it's already there and if
it is _reasonably_ easy to provide the notification that nfs needs to
clean up whatever it needs to clean up than this is probably fine. What
I absolutely don't want is to have another custom notification
mechanism in the VFS layer.

But if we can solve this in userspace then it is absolutely the
preferred variant and what we should do.

