Return-Path: <linux-fsdevel+bounces-20505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCE8D45E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708971F235AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ADC1C2A3;
	Thu, 30 May 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8s/NHsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9457F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053399; cv=none; b=NEB1SVhDC8uM59tpsQvQHrvQq7t1v5fKHFGolnzEG6JFdzVOJjuJgrh6xpXArtQYy5nIZ2yBKDBoZJ58u6eTZaw8w9330ZlQ5mFst9fnKmYrjPWBbX8DXUJVNIlvZo0aek0/Op/FCGYnElFniMHQy0PWOCegk2hvH1Jc4+rf4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053399; c=relaxed/simple;
	bh=3K/uOcD3XMeAB8wrQpNaP5yAkQCdIWgkX1zSa+6noBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXrbLcBfgQUkHfmN1RVY7FcIQCfYHAdXuOoiFkuL/PUxyj42qbc89st0uinQVRTWj45Z4F3XAjkrHyWDAXMyKMSpIBk0fn0IyncH6yi05eB+VziKVdJAhodbM1IqdwxOwfU+6rSPu6rZpt2I+icFm1pMG1FSUtlB3dEzNoSGEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8s/NHsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C54EC2BBFC;
	Thu, 30 May 2024 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717053399;
	bh=3K/uOcD3XMeAB8wrQpNaP5yAkQCdIWgkX1zSa+6noBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8s/NHsOpvON1O9pYJk/+nGAWf7JZRoNjMOCJqRvLM4xrega5PPNL1GSyIcXA4vX5
	 Y+kl5CmpIuPGjunaoH/tRBbr+jxkhEtdkBjS0zF/Kd04veveerWWdLNwdQg7VJ2Jhd
	 NuwCtMcNpzcIoKZP/JqjGMAE8hKJYOZ/Up7eM961XHHB2MdbOzV3QTyr/aDiH2tQtH
	 unXOz/fMzNoS39cGMJEebNcFoX/GNzohMLLkGZKp1iRi35J8hXLa/QA8Bh5Is+aLPN
	 CCzTr4B5w2Z/QE2KruV8yRKpMZzJF9LdvTcYnyp8binTW+9BISxERT8PUwhJ2nJXMY
	 FDzKf5l2hd8Eg==
Date: Thu, 30 May 2024 09:16:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thiago Macieira <thiago.macieira@intel.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: statmount: requesting more information: statfs, devname, label
Message-ID: <20240530-hygiene-einkalkulieren-c190143e41d9@brauner>
References: <11382958.Mp67QZiUf9@tjmaciei-mobl5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11382958.Mp67QZiUf9@tjmaciei-mobl5>

On Wed, May 29, 2024 at 03:36:39PM -0300, Thiago Macieira wrote:
> Hello Miklos & others
> 
> Thank you for the listmount() & statmount() API. I found it very easy to use 
> and definitely easier than parsing of /proc/self/mountinfo. I am missing three 
> pieces of information from statmount(), two of which I can get from elsewhere 
> but the third is a showstopper.
> 
> The showstopper is the lack of mnt_devname anywhere in the output. It is 
> present in mountinfo and even in the older /etc/mtab and I couldn't find a way 
> to convert back from the device's major/minor to a string form. Scanning /dev 
> will not work because the process in question may not have a populated /dev 
> and even if it does, it would be wasteful to scan /dev for all devices. 
> Moreover, given symlinks for device-mapper, /dev/dm-1 isn't as descriptive as 
> /dev/mapper/system-root or /dev/system/root.
> 
> Is there a chance of getting this in a new version of the kernel?
> 
> Of the two others, we can get via other system calls, but would be nice if 
> statmount() also provided it.
> 
> First, the information provided by statfs(), which is the workaround. It's 
> easy to call statfs() with the returned mount point path, though that causes a 
> minor race.
> 
> The second is the filesystem label. The workaround for this is opening the 
> mount point and issuing ioctl(FS_IOC_GETFSLABEL), but that again introduces a 
> minor race and also requires that the ability to open() the path in question. 
> The second fallback to that is to scan /dev/disks/by-label, which is populated 
> by udev/udisks/systemd.

I think that mnt_devname makes sense!
I don't like the other additions because they further blur the
distinction between mount and filesystem information.

