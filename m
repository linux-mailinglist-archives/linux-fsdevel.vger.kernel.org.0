Return-Path: <linux-fsdevel+bounces-14240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2604879CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65068283A4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522681428F7;
	Tue, 12 Mar 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBrEKxdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14F79DD4;
	Tue, 12 Mar 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274171; cv=none; b=C1rp2JbO8vrW92tA+DUjXmRpl/ZMN7i3QxRJu8snfUGLWc4PnKbllb08siL5xVObyivYFZIV/5p3rr6TiCsc2jo9vKjhoonOmZbOGp9M0tWT4xkM5nFE4l9QkFgkJNeEgCX6D2yU5+eqIEJfxyDi7VuYfe9Ht0wB2YCVny/mqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274171; c=relaxed/simple;
	bh=fnmJanWp2oa/xEknXmT/+OEy8PvTJ3NXt4ewM1ynXU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCSq9rXqfRkQKXiO2r5Idx7CzVchX6Cr2ZIC3fGSnG1GVlguEQcXMxA4GoxzE5hqHEbCHT2hvcTD4cqdK79rLeUm0Z0z2gcsUjqxD93rmrThtrTaf+GWjLJWO3d0zKiZ7OL5TG7EeZ3lOcL2MNQxMse41ovWPxVpj0BdJV8CdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBrEKxdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C80C433F1;
	Tue, 12 Mar 2024 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710274171;
	bh=fnmJanWp2oa/xEknXmT/+OEy8PvTJ3NXt4ewM1ynXU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBrEKxdRbebzz4AxlkWR16ApfcT+l/gUYwWL0feNMBYER49UhxKgVBpaS861l3ceY
	 T7CsqR5TB7JVYQXdBhbFm5tHbmvKvn7i8z9YQvJszP8P8CSw3XGBqrVvywa9P1a0hU
	 /fAoynQqt23Su3uG4gOQ0UGbfnuCyIt6GwRagYktt9wQ5sFD7DdK9m5SY3sJdNicuj
	 J12ztf0uKJzH5apkbxaaz8GT59gvVflKqxDSuYXty0nzHJqPey8taAG3Ca0ndetly5
	 8cAGPeLrbAdO+OtOY+LrRGkwFJs2N6zA5z7Huq1Ga95/GRwmT15QQYT1dK6N+9ctyv
	 9/6RBQxD8m5eA==
Date: Tue, 12 Mar 2024 21:09:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs pidfd
Message-ID: <20240312-pflug-sandalen-0675311c1ec5@brauner>
References: <20240308-vfs-pidfd-b106369f5406@brauner>
 <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
 <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>

On Tue, Mar 12, 2024 at 09:23:55AM -0700, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
> >
> > No, the size of struct pid was the main reason but I don't think it
> > matters. A side-effect was that we could easily enforce 64bit inode
> > numbers. But realistically it's trivial enough to workaround. Here's a
> > patch for what I think is pretty simple appended. Does that work?
> 
> This looks eminently sane to me. Not that I actually _tested_it, but
> since my testing would have compared it to my current setup (64-bit
> and CONFIG_FS_PID=y) any testing would have been pointless because
> that case didn't change.
> 
> Looking at the patch, I do wonder how much we even care about 64-bit
> inodes. I'd like to point out how 'path_from_stashed()' only takes a
> 'unsigned long ino' anyway, and I don't think anything really cares
> about either the high bits *or* the uniqueness of that inode number..
> 
> And similarly, i_ino isn't actually *used* for anything but naming to
> user space.

It's used to compare pidfs and someone actually already sent a pull
request for this to another project iirc. So it'd be good to keep that
property.

But if your point is that we don't care about this for 32bit then I do
agree. We could do away with the checks completely and just accept the
truncation for 32bit. If that's your point feel free to just remove the
32bit handling in the patch and apply it. Let me know. Maybe I
misunderstood.

> 
> So I'm not at all sure the whole 64-bit checks are worth it. Am I
> missing something else?

