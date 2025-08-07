Return-Path: <linux-fsdevel+bounces-57014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6CB1DD80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10A3585574
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81102737EC;
	Thu,  7 Aug 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1nySGEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77311D5ABF;
	Thu,  7 Aug 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594844; cv=none; b=DQjgNMpHlCCgCfzMYJHvzSLjVtR8TwRyF+hut8DnB/IAuSwtv7oJccpngpFF1S9bs/EMXsAqmaWwRp7NPc6eJF7ALz14+Kb2z4wte8IYRriwIBC37CQ+4WmjtKnOZsQRMw4ou3SCq6Bcfnt9byx93If+hg/JY2NBCMml8g2rbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594844; c=relaxed/simple;
	bh=wCFSFT72dIzQeHwlxlnMmBtPHTWWki4gQCHVC4GFAJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqlxBHAtwefILBP+T5lEHI7M3ECE3joBP2oow4EOdUStIWdlpvgU/cMQOBBq1nL7yr6mlA+2ncXnFbJ5MjSpkwMMDQUzW4SIU+VS5UCzbJpDbfRlSRoK5yZxwdp1/N3+GVolgmj9ZZM9afqUK1LsNVjMSHv1FPDjI4vsYT1RTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1nySGEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E60AC4CEEB;
	Thu,  7 Aug 2025 19:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754594843;
	bh=wCFSFT72dIzQeHwlxlnMmBtPHTWWki4gQCHVC4GFAJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1nySGEi4MO5UksaWsjCoJXVz2pifMiDXHvup625JKkluyFXqkRqtE7lcSpIb243s
	 jV7zIyJ3/Rl9A6YGDLrddX4qGWRTdwehnXHSyKSXObU3xrODLd+BGQTfwUqVh2tJha
	 xDp3sCgPGoqUjXuFZ3Hoh2B4qGGTeWZHr72nsYsM=
Date: Thu, 7 Aug 2025 15:27:22 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <20250807-intelligent-amorphous-cuscus-1caae0@lemur>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
 <zax5dst65kektsdjgvktpfxmwppzczzl7t2etciywpkl2ywmib@u57e6fkrddcw>
 <2025-08-07.1754576582-puny-spade-blotchy-axiom-winking-overtone-AerGh5@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754576582-puny-spade-blotchy-axiom-winking-overtone-AerGh5@cyphar.com>

On Fri, Aug 08, 2025 at 12:26:48AM +1000, Aleksa Sarai wrote:
> Konstantin, would you be interested in a patch to add --range-diff to
> the trailing bits of cover letters? I would guess that b4 already has
> all of the necessary metadata to reference the right commits.
> 
> It seems like a fairly neat way of providing some more metadata about
> changes between patchsets, for folks that care about that information.

It's already there, just add ${range_diff} to your cover letter template.

Cheers,
-K

