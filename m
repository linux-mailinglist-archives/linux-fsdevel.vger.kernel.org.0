Return-Path: <linux-fsdevel+bounces-62225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B0B896AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109A7520381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF113112A3;
	Fri, 19 Sep 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAfF/VaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167031C862F;
	Fri, 19 Sep 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284387; cv=none; b=lZTMdSNduXZZJqnP08DBzbgzNSU3YL8to8RirOLV98zuAfTKJ5GRKVbuC7DMwwXq2sjEdMGAo/xY03e0tNY2EY3i958zdjChqHZR/jMLP4GHQFJsJ9eQbKsrbMrXm8kxR5xRYyMqxIYgbBenfV/CVxscO1/bnIZIK8EJXdUlkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284387; c=relaxed/simple;
	bh=tYmBGEwPJSwXIyoVjGOWTLy8eAt7mXQHCx5978tooBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiELqB35CjewvC90uWfQminJYVJ1uc21GaBgiCoMUGtphnzbdNxbTg3msPEHGcTLzu0koTuPCrsSVH00zQvww78dIrYBqvetMeISCX1m01g5PwaYWpR4aRcR9mV9o2XROF+EWugP7ZmurhbpW16aLn80N90cXAgdgzBHVKLI598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAfF/VaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E26C4CEF0;
	Fri, 19 Sep 2025 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284386;
	bh=tYmBGEwPJSwXIyoVjGOWTLy8eAt7mXQHCx5978tooBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAfF/VaV9k2+0G3zC6iEf+mvMoX8OOowfZhUYE7NtQOA3wR6hsFdVeN24/bjTERPV
	 NWmStu1E0Rbe26YykEfKPZelDvsZb1Po0z5tHjBoXA5Qtr93TLOwwLnu4OqIHuyG+b
	 uXc60q+Fr8a+uWPGeMzqkZChdvprKuAX4xYjAXmcs8TppW5j/62RvkNpfHMS3JyuIn
	 KRTszs+mKwcPBcag3ypM7rERbkmHMHQb7+2sY2fmV0SSYEm1YChwd1Cw6w4b4FMWQu
	 wpMrX2XLxcnN5cPc3IeL7IySixe5wxF+J3teBhg/XTCDN5AfwYV+NSCHQTN2EiP3iD
	 9TtAzT0XmKlwQ==
Date: Fri, 19 Sep 2025 14:19:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
Message-ID: <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>

On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> This is generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

Given how late in the cycle it is I'm going to push this into the v6.19
merge window. You don't need to resend. We might get by with applying
and rebasing given that it's fairly mechanincal overall. Objections
Mateusz?

