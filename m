Return-Path: <linux-fsdevel+bounces-60605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EFB49EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA616FAA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645592441B8;
	Tue,  9 Sep 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NUjTCapi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtivojY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA515A848
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384059; cv=none; b=ActjY7A2c89gocjtL/3e+0wwsY0J+4HpaBNc6wHdaOb3s8KoxpJsjRJV8cpilphcGuFuQhoSr63cWOd41Oad/IE2RXsFLwLjY52bZLPtwrhd+5HoI3RF/6tZwQxMr2G3XqMncLAqxsbJo8sb03hm48XuTmOlJwMPXnbRBZYsBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384059; c=relaxed/simple;
	bh=8Yj3MSxN5r+5IKivOrj4wyVTZYHUMH1VgP+a5JfsV/A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MMOG6VvmNZrAciJjzB9FR2TduJu32T8YMbxmc/URNoaLtif+Nx2hgRuokjmfGGXTKFrzUbRdR4uWx6wPwsV1DakcEqVan+c8/pqWw+jQiu7K5+rstjZxiZDYPCP8m3vHHjVBA00SsrYEjBAx+WaWVPLdUf13TlYhL6fzzrDb3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NUjTCapi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtivojY7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A96C7A01B8;
	Mon,  8 Sep 2025 22:14:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 22:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757384056;
	 x=1757470456; bh=Jmi1kH3b4X7BwW9kRqKKWRKIpVBBIYW1wWx/dJlmmoM=; b=
	NUjTCapi9Q8sKK02M9eiYjz6C3ykfD1jT0dQRgdXVaAPImLikeCs33jX6qky/X0m
	xZ8kC3UIfRcBRebcS0rRWg01zaVldLhnMwiOtSgtDuL9B374rUOaugWYQwWcvofm
	is2d5HjNTsG7KgFJPbLRsO0vFs4rCgL3kpj0QyANfFvvAB3OS2DHVwxkURd45pOa
	zeK0Z9Tc8rgEFxrWscj3/l/OBTDYZteCYcAEX+gMpm+sgC5B9Gl4A3VChfFy44EI
	0UaPtYbry0k0RfrK5u3lrxfJt6NFYXsf6TC0AnKBUOQ+0FvFQFxOoLDw8ZrSD5ts
	Gbo59mxTwiHlrkLPz7MGzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757384056; x=
	1757470456; bh=Jmi1kH3b4X7BwW9kRqKKWRKIpVBBIYW1wWx/dJlmmoM=; b=J
	tivojY7NAY1cEYxnOQxL7Xes3AdfcxUv+hEqVH0VTIwO/KP5ZQu8oCubSkXeCzWo
	QgJYcXXODqq/bRr0ul5twxNgAR/nX0ZErH6+b5YQ2uNLnU7v+Yh4fXs7lp9VZRdy
	NWTp+AXhz41WuSJtJm0urL1XTR2VM//p86x/Os9I5sua6ewn3C7KS5tgXSW9Ym9u
	jSLmhcG/fMwX6nT+7+j1TBMloJXh/zz1rg7jHSbfufqB47Vvd3EoLGIaGVzUL3Vg
	7WIodblBD/0PMv1TU1Fu6BP2XkkX2PDdyuN2/P615AT4aDfoDQjTTw4cvsDTVfqt
	uMGkQxt1r62blerxapOnQ==
X-ME-Sender: <xms:d42_aLx0-8_2MDs6WB9dZQPHgwSXkKCYra9gIlosrZ1Nynm_AdqBZg>
    <xme:d42_aKoSSizF_7_o6Dnx-DFv3CWIWBZqtqGZLeInvl7R09YV0sbAa_uRNSMOZ652k
    wuNMOX5KJQ9GA>
X-ME-Received: <xmr:d42_aK6y1AenpqpDxncxD3mQGJR4OmhAdlJldmESv2ealtoQcBG27S1FGzmRDbbvLcsV2CNglrWOIqcW4zSKT-TMX-19aT5kb4tgzMtWIZ8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtkeertddttdejnecuhfhrohhmpedfpfgvihhluehr
    ohifnhdfuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueeigeduhffffeduhedthfdvjefggfehteeltdejlefgfeeigfehheethfehveehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:d42_aBdExPWBqHmQG4rvJC-tdEwQGYteecpvE1wa-eF8og_ThcNRmg>
    <xmx:d42_aP4VoT-Kh06DyUQSI10Gx37E5_wy4IqgV3CZeOG_bxZf7A0FHw>
    <xmx:d42_aItlNaMh6i8UZxynexe6Gq5JwVjgUyY9C9rIXoq5TVjG6kI_Uw>
    <xmx:d42_aPh9aO-KBpbV55CHn0fkWMmwb5ZW85hZA8NYm0zhsJY40N5PuQ>
    <xmx:eI2_aEvI1CJpbHgMHvqkyCQwomtEFJB2u0hSeTr8D-l2jEz2hTX1VsJa>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 22:14:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
In-reply-to:
 <CAOQ4uxh8E9G=JH3S-SMFe9RHFTy7J3jHg-Kw5-pApJF1UmOV-Q@mail.gmail.com>
References:
 <>, <CAOQ4uxh8E9G=JH3S-SMFe9RHFTy7J3jHg-Kw5-pApJF1UmOV-Q@mail.gmail.com>
Date: Tue, 09 Sep 2025 12:14:07 +1000
Message-id: <175738404705.2850467.10284746345651886394@noble.neil.brown.name>

On Mon, 08 Sep 2025, Amir Goldstein wrote:
> On Mon, Sep 8, 2025 at 4:07 AM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Sat, 06 Sep 2025, Amir Goldstein wrote:
> > > On Sat, Sep 6, 2025 at 7:00 AM NeilBrown <neilb@ownmail.net> wrote:
> > > >
> > > > From: NeilBrown <neil@brown.name>
> > > >
> > > > ovl wants a lookup which won't block on a fatal signal.
> > > > It currently uses down_write_killable() and then repeated
> > > > calls to lookup_one()
> > > >
> > > > The lock may not be needed if the name is already in the dcache and it
> > > > aid proposed future changes if the locking is kept internal to namei.c
> > > >
> > > > So this patch adds lookup_one_positive_killable() which is like
> > > > lookup_one_positive() but will abort in the face of a fatal signal.
> > > > overlayfs is changed to use this.
> > > >
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > >
> > > I think the commit should mention that this changes from
> > > inode_lock_killable() to inode_lock_shared_killable() on the
> > > underlying dir inode which is a good thing for this scope.
> > >
> > > BTW I was reading the git history that led to down_write_killable()
> > > in this code and I had noticed that commit 3e32715496707
> > > ("vfs: get rid of old '->iterate' directory operation") has made
> > > the ovl directory iteration non-killable when promoting the read
> > > lock on the ovl directory to write lock.
> >
> > hmmmm....
> >
> > So the reason that this uses a killable lock is simply because it used
> > to happen under readdir and readdir uses a killable lock.  Is that
> > right?
> 
> I think the semantics were copied from readdir of that moment yes.
> 
> >
> > So there is no particularly reason that "killable" is important here?
> 
> I can think of some reasons -
> Maybe overlayfs (ever user mounted overlayfs) has just one process
> accessing it but underlying lower layer is remote fs with many processes
> accessing it so chances of lower layer dir lock being held by another thread
> are much higher than chances of overlayfs dir lock being held.
> 
> > So I could simply change it to use lookup_one_positive() and you
> > wouldn't mind?
> >
> 
> I do mind and prefer that you keep this killable as you patch does.
> The more important reason to keep this killable IMO is that we can and
> should make overlayfs readdir shared lock one day.

Fair enough - I will persist with my current patch.  I just wanted to be
sure it was wanted.

> 
> > I'd actually like to make all directory/dentry locking killable - I
> > don't think there is any downside.  But I don't want to try pushing that
> > until my current exercise is finished.
> >
> 
> The path to making overlayfs readdir shared and killable is
> to move the synchronization of ovl readdir cache and
> OVL_I(inode)->version from the implicit vfs inode_lock() to
> explicit ovl_inode_lock().
> 
> The mechanical change is easy.
> My concern is from hidden assumptions in the code that
> I am not aware of, ones which are not annotated with
> inode_is_locked() like ovl_inode_version_get() and
> ovl_dir_version_inc() are.
> 
> And the fact that noone has yet to complain about overlayfs readdir
> scalability makes this conversion non urgent.
> 
> If you have other reasons to want to make ovl readdir killable
> or shared, we can look into that.

readdir locking is not on my radar.  We need to keep it to ensure
exclusion with rmdir (as we need a counter of current readdir threads
and there is nowhere else suitable to store a counter even if I wanted
to).

And readdir is already non-exclusive and would not benefit from
asynchrony (as far as I can see), so there is no need to change it.

I might find improvements to ovl readdir locking interesting, but not at
all a priority.

Thanks,
NeilBrown

