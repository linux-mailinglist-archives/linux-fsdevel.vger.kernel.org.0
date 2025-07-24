Return-Path: <linux-fsdevel+bounces-55925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054AB10206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B64C587634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8C26280A;
	Thu, 24 Jul 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK272aHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EA17332C;
	Thu, 24 Jul 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342618; cv=none; b=d35uTo+i8HKz9cS5cD7E+gA2hIaN4aO3MNKBQNRZuHRajB5yFtk1pW6j04LFtB+pRp+FabsX0u2ssW5zEpLt3seSngQn7oKqOA4/mIPsftbUH2HQ6Lr0TgLkpCX6nFVEREBysAl+UR4drrf1PsGkoAP2+hmf0ly9BWbJvLv9cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342618; c=relaxed/simple;
	bh=dq2wYeFbup/Atv1LJ+3Zw/bjLNGdBX7WO7m+Y3TIzTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMXHMRHzlLDcqMe7Jhb0XckEVZTocaJVXf1hHWpZncguIw7RNn9/tOx3IAO6x7L+FCLIcWlzu6DULRl7SoH73PfIu5w1Gj+dCZHSJIqUeknaMw6S7ylbtPW47z7aZm7+opsZ7HE82zrZrK0xbvRm4nwmzmGBliJcT2+Ll/2kIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK272aHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896FCC4CEED;
	Thu, 24 Jul 2025 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753342618;
	bh=dq2wYeFbup/Atv1LJ+3Zw/bjLNGdBX7WO7m+Y3TIzTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK272aHum1BQTgeoO/4ep8Ovu0EQcs7iLG7dsLmg6h3bTCHBySVs01iu6gZZnUBX/
	 ordhsihR43gYvWmaWrgmbgOs27WUmdf7Tm1sPYUixUNpDjoIQOTrHYNDWDM9gcRJSU
	 6F0psalSLxl0jNVHDPlXFmYAs4IstZop8z579wNbaU7aozc6kWG8cBtHeRvcbHM7q2
	 OtR+hOwdNxwcukaAVF/6y4vGXd1CB2iG5akQIPUrBAmC/2t6cwDlfseJt/AVi/l4h6
	 eoRvivlWSsalT7Q9jSZa4fqX2X8E4VzEtn0EdZ0t4qwycUlHqdln6AuMfF44pY5/XO
	 MeyFoVLRlFLAA==
Date: Thu, 24 Jul 2025 09:36:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] procfs: make reference pidns more user-visible
Message-ID: <20250724-bekunden-einplanen-160f57e944e9@brauner>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>

On Wed, Jul 23, 2025 at 09:18:50AM +1000, Aleksa Sarai wrote:
> Ever since the introduction of pid namespaces, procfs has had very
> implicit behaviour surrounding them (the pidns used by a procfs mount is
> auto-selected based on the mounting process's active pidns, and the
> pidns itself is basically hidden once the mount has been constructed).
> 
> /* pidns mount option for procfs */

I like it. I think this will be very useful!
Fwiw, I think sysfs could probably use the same treatment.
It should probably gain a pidns & netns mount option and the ioctls to
get those out of sysfs so you know where that sysfs belongs. Thoughts?

