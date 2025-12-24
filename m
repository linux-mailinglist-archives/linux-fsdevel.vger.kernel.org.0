Return-Path: <linux-fsdevel+bounces-72054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C47CDC444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAF4B300B697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4296F30C360;
	Wed, 24 Dec 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8eAH/Ci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FD16DEB0;
	Wed, 24 Dec 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580450; cv=none; b=D54fSofokwcSyLIrS6A5CgSZ3o2l8koRPolqn+KfEkB2Y+oZjkPbQM3TKtKeFN/Gbd3s8Et0TY2LiNFL1RakKYpdHx33bfbYjYUH6On15bmIP63VzmdkgnKqKucm1SznG+vqDmHn/pirT5AosG8OG1+yWapOmU3JIPl9orxW/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580450; c=relaxed/simple;
	bh=1OXx6GURbUrynPeV1ZLcDBZHPyQaZwfErFyLzTyabfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK9IWNpH5kk0CCpkYocdD0qiI1hNVu2U7j+WWeJkuImkg4IgOCuOPDgabZM0HiUtw0CRlWFylE+sb9ATu3sx2w6xZmk3P3jH8JwW+uLGwhK66BouGGjyTFdLZHj2iAAUftH33ogQ91LUVfDkhvUjWz4111GE4X3q04LlAmKuH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8eAH/Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987EBC4CEFB;
	Wed, 24 Dec 2025 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580450;
	bh=1OXx6GURbUrynPeV1ZLcDBZHPyQaZwfErFyLzTyabfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8eAH/CilZ7HrYDRWS9DXLZcv6BtvndF8cjIAbIoNn571Ft6wQV8WbuM7lt1s9bUi
	 9K7AK6KpmVy+p0Bhp0gpe4d1RhtOG2Ef0s5L9dG0gqhDkhyQBrnmXZq3uxjK4x24iR
	 nvX0MxrBmKupiTVy/1dZ/8phGc/u4BKDJ4K09ewbjf9SveKNDYMPH0hSE4p2L0c6pV
	 7RofYRwxFpz+GOvpmhJoPbZhYYbwqV6QN57aqOuq6vrFOz/JQU2Jq1EKrqz/rdnF2s
	 +fVZAOH8Jw+yYkPlg9PYrbLm+978Ztlyp/rLPIcQDEu4c7gGUjBnsm4f+6Pw4TVBk9
	 2XgVuViSdksAA==
Date: Wed, 24 Dec 2025 13:47:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
Message-ID: <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>

On Wed, Dec 17, 2025 at 06:04:29PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add the ability to send uevents whenever a filesystem mounts, unmounts,
> or goes down.  This will enable XFS to start daemons whenever a
> filesystem is first mounted.
> 
> Regrettably, we can't wire this directly into get_tree_bdev_flags or
> generic_shutdown_super because not all filesystems set up a kobject
> representation in sysfs, and the VFS has no idea if a filesystem
> actually does that.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

I have issues with uevents as a mechanism for this. Uevents are tied to
network namespaces and they are not really namespaced appropriately. Any
filesystem that hooks into this mechanism will spew uevents into the
initial network namespace unconditionally. Any container mountable
filesystem that wants to use this interface will spam the host with
this event though the even is completely useless without appropriate
meta information about the relevant mount namespaces and further
parameters. This is a design dead end going forward imho. So please
let's not do this.

Instead ties this to fanotify which is the right interface for this.
My suggestion would be to tie this to mount namespaces as that's the
appropriate object. Fanotify already supports listening for general
mount/umount events on mount namespaces. So extend it to send filesystem
creation/destruction events so that a caller may listen on the initial
mount namespace - where xfs fses can be mounted - you could even make it
filterable per filesystem type right away.

