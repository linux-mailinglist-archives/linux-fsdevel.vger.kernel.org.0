Return-Path: <linux-fsdevel+bounces-48725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B2AB33A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C3C16410E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F845264F9A;
	Mon, 12 May 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC6gogpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61975263F2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042242; cv=none; b=EwZPU5lKQCheedMbpH51VfOz2DB/3f7cRTyqrg2Jxjce5VLQuIOadYbmql4a+0SJGnDpo2QTitGSlK79IccFK5Shp8kVEeWJX3PlpFNGGVz4cY4VeWsi2PROO0KmAFcRAQ+0HoGJQV2qT5NMHjoeGI63WNbRNKTHnB8FGTrtdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042242; c=relaxed/simple;
	bh=XaShIbtWkLLv2LuL/7d83ZGoji07mUURlIx8jfhhdpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpA9xC8iAexmLHlatXfIEbD5dKB88WZ2Waj83UkqfmrH7hKaH7WB/MonZ+3nIu3wt9Vbcq9QLA20Xp4Giq/teSvB371FSh76LCusSM/HbcEvrSDZH1Mdatt/9GWzvYN83zJAunWfvYYG+Uiju5IU/72Bpd3yAqYqD8rOAi9LUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC6gogpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A14C4CEE7;
	Mon, 12 May 2025 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042242;
	bh=XaShIbtWkLLv2LuL/7d83ZGoji07mUURlIx8jfhhdpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kC6gogpLizqVafvpJy16uK3HnvhB62rcxj3JSkfTu1B8dFVUCuMbhe4U4lwyVYA7d
	 0Tdl0zAnFckKASmAoV6EypVsEHivoi4s3f5zqZsyjzDBX8UcPxpq0TGcYD+V8qK45R
	 HTM7WKfudUlHgsa8u54p4/u+t9RzdaFi01yimVxg5W060hNikSW2NhMjM4QHYGHYiR
	 mG1Yn4K/4q2JtRExsmY3sTzC7O2j/Rf+1ZsceSEHZ/IhvpOP/ph6sXeLdxZ2F2/oJ8
	 L7ht8ZCSA3TD60d/4mG8ZjrvWPp3MVrJY3kQJ0QaTxVvSNx3TX7/+9HwKLRKScPcCq
	 FeoYVUKMlY3ZQ==
Date: Mon, 12 May 2025 11:30:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] selftests/mount_settattr: remove duplicate
 syscall definitions
Message-ID: <20250512-kumpan-stadien-5f7862c81a7f@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-5-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:36PM +0200, Amir Goldstein wrote:
> Which are already defined in wrappers.h.
> 
> For now, the syscall defintions of mount_settattr() itself
> remain in the test, which is the only test to use them.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

