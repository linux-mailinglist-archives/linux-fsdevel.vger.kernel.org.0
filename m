Return-Path: <linux-fsdevel+bounces-79464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKSIKg5AqWkJ3gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:34:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0620D7FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C197A3019813
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B783451BA;
	Thu,  5 Mar 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7V3yU2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EC329E7E;
	Thu,  5 Mar 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699659; cv=none; b=uFIDqCMWrevHvWuUXPZzG3Jua9Oa5n9k6tEBHZKRP1BnMO7znuZa4U7vvoekmQ3E7GRQgoZic+xdR4kPoUbjc3pWMF0boWrOJfV37YuIpVrXJZ8IX+cFlPSa24Dk5TQCZixRvCr+G/Djv/Zmd6I2SvKp2JVCBLw/2LdRYI55Kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699659; c=relaxed/simple;
	bh=aXVf4Nv4QScBtWvKkqs3eOvy34SUC4+ikSaX8IqM6+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeW2ep6FgMvMFF3jVqpgF27ysGO1RJjVc1LkqjXXT0oNVbskASgkcj9WMLWWdRHgXIgefm5lTVEWNpU3l1CL57AKYPOGj2PivgtO9n0tcg5T/PlXQf87PAcn2XhySJqEZkK4NVOivfNCLK7mXrMYDDXGRBVNJbABpfRMd40zPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7V3yU2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE7C19423;
	Thu,  5 Mar 2026 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699658;
	bh=aXVf4Nv4QScBtWvKkqs3eOvy34SUC4+ikSaX8IqM6+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7V3yU2vazHOFtUm0iyl3hCrivetCgJL2ec7zfEBrWWOYRp7YLprJLH8Fc6CL/uTi
	 Uvp5XaG1iTUJWe/E9Efady/+i3ZoBzJEBeG0YFYoQbXRNXjTlR5hDF42y4XZMjIZMc
	 B6TRIuxEYHENdYYavDGo+D9EqnCkQJSUBSRosZrp1fgpVHMhPw9+DyYcttpof8JlJt
	 FGIxA1MadO2b5cTBtMXt85Ab3jVnV15yGN+Tn+v0DK+DaZ6gYxPWYjabmXDSqKCKlW
	 N+aJ9J7v0rYLOkat3ra3BYy5yu7NjhhFHzBxab6ln1JaYuXInf0Q6ageBaiigqkpo7
	 GyTnK3RlBtGRQ==
Date: Thu, 5 Mar 2026 09:34:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org
Subject: Re: Possible newline injection into fdinfo
Message-ID: <20260305-gespeichert-athletisch-a25f907e6d2a@brauner>
References: <08f230b4-8c01-45b8-9956-7cfb9f82eeff@gmail.com>
 <20260304-wertigkeit-rockkonzert-ac7270334804@brauner>
 <bc3c1712-a747-42f5-b175-43757fb83ac9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc3c1712-a747-42f5-b175-43757fb83ac9@gmail.com>
X-Rspamd-Queue-Id: 3FA0620D7FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79464-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 01:57:31PM -0500, Demi Marie Obenour wrote:
> On 3/4/26 08:03, Christian Brauner wrote:
> > On Wed, Mar 04, 2026 at 01:53:42AM -0500, Demi Marie Obenour wrote:
> >> I noticed potentially missing input sanitization in dma_buf_set_name(),
> >> which is reachable from DMA_BUF_SET_NAME.  This allows inserting a name
> >> containing a newline, which is then used to construct the contents of
> >> /proc/PID/task/TID/fdinfo/FD.  This could confuse userspace programs
> >> that access this data, possibly tricking them into thinking a file
> >> descriptor is of a different type than it actually is.
> >>
> >> Other code might have similar bugs.  For instance, there is code that
> >> uses a sysfs path, a driver name, or a device name from /dev.  It is
> >> possible to sanitize the first, and the second and third should come
> >> from trusted sources within the kernel itself.  The last area where
> >> I found a potential problem is BPF.  I don't know if this can happen.
> >>
> >> I think this should be fixed by either sanitizing data on write
> >> (by limiting the allowed characters in dma_buf_set_name()), on read
> >> (by using one of the formats that escapes special characters), or both.
> >>
> >> Is there a better way to identify that a file descriptor is of
> >> a particular type, such as an eventfd?  fdinfo is subject to
> > 
> > The problem is that most of the anonymous inodes share a single
> > anonymous inode so any uapi that returns information based inode->i_op
> > is not going to be usable.
> > 
> >> bugs of this type, which might happen again.  readlink() reports
> >> "anon_inode:[eventfd]" and S_IFMT reports a mode of 0, but but my
> > 
> > That is definitely uapi by now. We've tried to change S_IFMT and it
> > breaks lsfd and other tools so we can't reasonably change it. In fact,
> > pidfds pretend to be anon_inode even though they're not simply because
> > some tools parse that out.
> 
> Does Linux guarantee that anything that is not an anonymous inode
> will have (st_mode & S_IFMT) != 0?

Ignoring bugs or disk corruption anonymous inodes should be the only
inode type that has a zero type. Everything else should have a non-zero
type and the I made the VFS splat in may_open():

          switch (inode->i_mode & S_IFMT) {
          case S_IFLNK:
                  return -ELOOP;
          case S_IFDIR:
                  if (acc_mode & MAY_WRITE)
                          return -EISDIR;
                  if (acc_mode & MAY_EXEC)
                          return -EACCES;
                  break;
          case S_IFBLK:
          case S_IFCHR:
                  if (!may_open_dev(path))
                          return -EACCES;
                  fallthrough;
          case S_IFIFO:
          case S_IFSOCK:
                  if (acc_mode & MAY_EXEC)
                          return -EACCES;
                  flag &= ~O_TRUNC;
                  break;
          case S_IFREG:
                  if ((acc_mode & MAY_EXEC) && path_noexec(path))
                          return -EACCES;
                  break;
          default:
                  VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
          }

> Maybe it is time for a prctl that disables this legacy behavior?

I've switched anonymous inodes internally to S_IFREG a while ago in [1]
and then masked it off for userspace. Even just the internal conversion
caused various subsystems like io_uring to lose it which is why we
reverted it in [2].

So any next attempt needs to ensure that there are no internal and no
external regressions. And no prctl()s please. It's a strong contender
for Linux' main landfill next to procfs.

Ideally we'd just look at lsfd and lsof and move them away from any type
assertions. I have asked them to do that for pidfds a while ago and they
have merged a patch to that effect.

[1]: cfd86ef7e8e7 ("anon_inode: use a proper mode internally")
[2]: 1e7ab6f67824 ("anon_inode: rework assertions")

