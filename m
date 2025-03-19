Return-Path: <linux-fsdevel+bounces-44430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21778A687D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 10:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437423A7CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711425332F;
	Wed, 19 Mar 2025 09:23:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F952AEED;
	Wed, 19 Mar 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376204; cv=none; b=b05GsBxY4CY2tDl3XOatOLpMA3Q5mGywIqpI9RN4lDvi0y0f3iscrQmvYeIRq0GYMvLClwYORrgVImqRVJhhHOkQ6APa4JHXpVI0EXQhcqj4OC+pe+RAw4IsFYtwllNGzQrPe6G4Ft86FyK/EZAYgUd2iCx7r7cQTZECbzi+8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376204; c=relaxed/simple;
	bh=jdwMEPKg5Mauf8XWIj+5yGzsVvk1ePLQelg7BiM9IY8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KdUn/kDHYSbk3EJ5lRhdmIRSO9INfzm6hnKyEcQ4rQFfRGON6zIKcjLrN2ltzWIVyJxn8PgPveEcMdE69rBe6wMbARBPjJ0e3O1hlLg/8uJqeZgleZLZO3BoxGS0T2o6wI3DyZR5BXBpJDM3GKAeYqi/oVCgIEO3MfD+75qTo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tupdr-00GAC2-VM;
	Wed, 19 Mar 2025 09:23:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6 RFC v2] tidy up various VFS lookup functions
In-reply-to: <20250319-vierbeinig-aufruf-ea327bc39320@brauner>
References: <20250319031545.2999807-1-neil@brown.name>,
 <20250319-vierbeinig-aufruf-ea327bc39320@brauner>
Date: Wed, 19 Mar 2025 20:23:15 +1100
Message-id: <174237619566.9342.15960110068289657792@noble.neil.brown.name>

On Wed, 19 Mar 2025, Christian Brauner wrote:
> On Wed, Mar 19, 2025 at 02:01:31PM +1100, NeilBrown wrote:
> > This a revised version of a previous posting.  I have dropped the change
> > to some lookup functions to pass a vfsmount.  I have also dropped the
> 
> Thank you for compromising! I appreciate it.
> 
> > I haven't included changes to afs because there are patches in vfs.all
> > which make a lot of changes to lookup in afs.  I think (if they are seen
> > as a good idea) these patches should aim to land after the afs patches
> > and any further fixup in afs can happen then.
> 
> If you're fine with this then I suggest we delay this to v6.16. So I've
> moved this to the vfs-6.16.async.dir branch which won't show up in -next
> before the v6.15 merge window has concluded. I'm pushing this out now.
> 

I'm completely find with that - thanks.

NeilBrown

