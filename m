Return-Path: <linux-fsdevel+bounces-51781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43920ADB448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B41627F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76BF1FDE31;
	Mon, 16 Jun 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaZBU+9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061D1FE474
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085115; cv=none; b=KpwXoDzFjbFPRXTGEbltvAbDqUlmpK6QD6m0xJnWlOF6GEdTY6CvEO2c7OF15wTUDBHLhayEQU1/AeT6bc+Ww99FimIPWwXLRQ5vMxSuXmn2/uaebEml+ZaJeXXc3dABwt9JtbbANhWn6L8UZfJvjLIBrGLbrk59EJfSH/LSzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085115; c=relaxed/simple;
	bh=fkmddWPbUK/89w0iAEpoyltEBW2zptNIryMoATQ7JQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBli/nbOV9r8aVnR+AjyCIU6ayo2h0nWK22w3pTTPu7m2tKPOfAflk8IHtFS9+URU/fB0DMQPPiK3+jCDEBIbQAYyO583Iq5IaSIEwVrmagLwyzimIWevKdfVi8M7Pa3SM+5hFWOnzD6fsRB0hgJ8yAh772v3DoXVfvhFjWVfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaZBU+9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CCEC4CEEA;
	Mon, 16 Jun 2025 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750085114;
	bh=fkmddWPbUK/89w0iAEpoyltEBW2zptNIryMoATQ7JQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaZBU+9Lyqu94HeDMYEvYGhAkwMsePKfV7GcRpCsL8mVIQSK88vZh2i2vF2j85QqO
	 vQyfbXHq/IQUSaglNXELGGniyqeZNQnPX7NS1ONdouD6vMFQpKUH32dtrn/RkJl/mQ
	 5rI3lz5n8g32KCqrk1VwJc5l/oklNkYtJkHEPYs9WMxWiAwGY9FqpVD1W5OLwHvWk0
	 E9Zt+agHVwJhwCn+xHRymBQtvg8RT2TnvtgkaUPjlB1M5O5ud30h+rdQDDj8Jyp3f3
	 QGbiB3rlyf22/UnHVh1ShAuSOIBe9xwRb45UJehG5EjHBbxPpiAqw78tgfcmyw98CJ
	 vz6EDXeynMQ7A==
Date: Mon, 16 Jun 2025 16:45:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 7/8] kill binderfs_remove_file()
Message-ID: <20250616-verrechnen-praktikum-c8e4e6725ade@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-7-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:29AM +0100, Al Viro wrote:
> don't try to open-code simple_recursive_removal(), especially when
> you miss things like d_invalidate()...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

