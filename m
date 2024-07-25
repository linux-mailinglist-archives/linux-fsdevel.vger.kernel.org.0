Return-Path: <linux-fsdevel+bounces-24219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F093D93BAEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E21F222CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129B12B7F;
	Thu, 25 Jul 2024 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LlEZs79l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74BC8F6;
	Thu, 25 Jul 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875395; cv=none; b=enTchq2GnULmZCKQsUxLISwU8crpNO5a8t4DxQpt1VN7ffOzMSun9GRuPjVfYlRcp2quyeA8/dhtMnkpCB/oHAZBfoDPhJZo6J+DvgyByvlUj3C6MjH/SFnX6pfWDe8v7m9vZUmSKnPsQ3MWKsO2XzfwM8YcLuTeOwD0TB1bOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875395; c=relaxed/simple;
	bh=C3lF1Y8TvBKK/VGrwOVKMI+9r5JlTGZ8dke+MxCozHA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=foHWLyp6DiJSPgPeLihSeH2wKZaEo9uXA9rr5IxT2C5QPaZ1QrXoQU0ZFxDm7zbe6kajFhEIPIP9bJCY4cLDJylFNYBVSr4arQfHtexoBf3cQE46qaVVMH9PKAHZdfUVuVVYpWcEJtBJouSpASHuV3ytzdFaO3PZiJh6Z6+EH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LlEZs79l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DDDC32781;
	Thu, 25 Jul 2024 02:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721875395;
	bh=C3lF1Y8TvBKK/VGrwOVKMI+9r5JlTGZ8dke+MxCozHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlEZs79lFTmxlyTYv/o7xpAaH0TNPvmL1sI9bg6NTdD/jZ65/dzTna+JoSMRfwvkb
	 817UYdQ3pEmDiP++OkV1dzVYBR8GqMe8lPojIAHbygEHj1fRb5AzX2dqzFYy9pbSMc
	 HGp0GceUO2/7KkC77myot+5PoY0wvFtotTUtR6cw=
Date: Wed, 24 Jul 2024 19:43:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de,
 ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
Message-Id: <20240724194313.01cfc493b253cbe1626ec563@linux-foundation.org>
In-Reply-To: <CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
	<20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
	<CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 22:30:49 -0400 Julian Sun <sunjunchao2870@gmail.com> wrote:

> I noticed that you have already merged this patch into the
> mm-nonmm-unstable branch.

Yup.  If a patch looks desirable (and reasonably close to ready) I'll
grab it to give it some exposure and testing while it's under
development, To help things along and to hopefully arrive at a batter
end result.

> If I want to continue refining this script,
> should I send a new v2 version or make modifications based on the
> current version?

Either is OK - whatever makes most sense for the reviewers.  Reissuing
a large patch series for a single line change is counterproductive ;)


