Return-Path: <linux-fsdevel+bounces-12707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08558862969
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB2282390
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A1DDAE;
	Sun, 25 Feb 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W89162Uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697CDDA1;
	Sun, 25 Feb 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843022; cv=none; b=WWs0WCT0wYVPxckmbRXnu0GF92xfaYZpNd1qUCSfghbMMz0lCLHuCaRTJ/YCvhJa1UHAA+IFtPrBXXT82Tw39leMlSzDXID9Itel+lFmtr6/khh9sRI5OLNZIZa5sBWBrV3PBB6215QMFVnyA7+CT11yQmZx5nvJVAXeiWyUhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843022; c=relaxed/simple;
	bh=psIxjbB2eHg/0lZMfYZ5mFCMKddHlA4ICHNEKYJYGD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzQEXYsufwelLfJp+dRShpq4RngQ8yZrymtiCG8Y7X2aVAdAakStDnGAieC5Ns8n/fg3O3h1kbzKwItL/pDiNCGqOaQvxVGfhbRw2eNpZim0qFSF/bOu/ZIG93maicwcc14+SwMOOKoCnp/bDI68mwOFjVBirKUYAwIGZB5YRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W89162Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDEAC433C7;
	Sun, 25 Feb 2024 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708843022;
	bh=psIxjbB2eHg/0lZMfYZ5mFCMKddHlA4ICHNEKYJYGD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W89162UcIRK6wLLVq/CMBHDcVBA0EkelKIVlvLAWSR0s7f0iWPFnqvaQTofQosjS8
	 1wK023loHZw6fKZh3Q20szJtaQZNXtYwxjaiQFeJff/QBpqBv8ScciTjkVK+8+/Pr9
	 0df9Uozz/GzJ3jYSmK4Juj4oNRxqUpjH193oRmXRDAi3MUjFq/iZJGVngOJBTCIWpO
	 qB1o50iHi5n+3S29xljS1R61UwevNA2iWlQkAJm7f5iZP+G1P91PVbHyDyuH26k9UV
	 ZHvsi4svrj8CKw6XbHMuTlsWG6EUVieZCqTiV7z0sRHjFWrdKdukzT+gppC9Mx/grK
	 c73kmmd13BMlQ==
Date: Sun, 25 Feb 2024 01:38:15 -0500
From: Al Viro <viro@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 1/1] rosebush: Add new data structure
Message-ID: <ZdrgV8GUE92HMojn@duke.home>
References: <20240222203726.1101861-1-willy@infradead.org>
 <20240222203726.1101861-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222203726.1101861-2-willy@infradead.org>

On Thu, Feb 22, 2024 at 08:37:24PM +0000, Matthew Wilcox (Oracle) wrote:
> Rosebush is a resizing hash table.  See
> Docuemntation/core-api/rosebush.rst for details.

Interesting...  A few obvious questions wrt dcache:
	* how do the locks that stuff nest wrt ->d_lock?  Inside?
	* same for rename_lock (on rename dentries change names/parents/hash
values).
	* we would be really forced to maintain DCACHE_UNHASHED in ->d_flags;
it's not impossible to do, but will take care (protection of ->d_flags has
several dark corners).
	* the cost of d_drop() goes up.  Might or might not get painful.
	* if the bucket locks nest inside ->d_lock, we'd better look out
for the latter getting held for longer.  Might get unpleasant.

