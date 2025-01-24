Return-Path: <linux-fsdevel+bounces-40029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE5A1B246
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2662A3AB095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72A1D47BD;
	Fri, 24 Jan 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="icMT7CvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6111D7E57
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709258; cv=none; b=faf1IWF6Hk5XXfc6ppsldwZgRQcdNxy3q+39oVQf7tayRFOH8rHvhe+fKtxGo1hqfOsrWqKD+GtjK2RATP3ZvIkFJBumixQ56cAMzToj3n7Y8UDHA8uJ9NWjrPBhf25GpWgBy79NoRcFqugn67L2YwpiP391w2rh52/KVwZJwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709258; c=relaxed/simple;
	bh=r7y9kvHFrJSdDEshIygkowJG8CJkzlY5IB33RVcATLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWCgPVSg+GHQ0ip0C51Bzjw45AwRWoHZ5spDS1eAHNqFKutRt3SxrBn1hYjj+BAmbvfftpOgIptrSOW4g3fbW18267oQDkZ3jXpaY0TpIOVQjPzCebx6Q3LHbRvcmU+D28JOKyC32Lq/OLjwmF5zALBXO0rX/eaDlyIjC2vf0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=icMT7CvG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ePVAqKPWX+uZMmYzgNGEMJp/gOOdVvd8y5OvN0MxCQY=; b=icMT7CvGMoNjOordRUvpQy9YGj
	TDrJBfwYBi4AJHE+ct19jJbq5ucvU1dQppy8DD3pfMNkKg4obN0oqeJ5KdKB/VQhXaHqpQaEoG+Yn
	k8q+ibF8btzrXxK1PtOW84AijQuo37ol+FaoT6YnyfHo/C3gDzMXbRA5yTlGhKiyi9HgHWsIRQheN
	JQ9nOrP+Abim2NxS0IiQK1U2eFfm3tOxDrvNqVbQEbY+NVJeZE3R8ADiHRU7snK/WYr3pq8fHVzvc
	OypZwC5F+NI2iR1qPVtyHUP6T3Gd9BpGycmPb428M5VNqyPuKoJpA1tFcJ0/EUoQzVPL8dg9DBBs6
	XhOjInZg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tbFYR-001h3j-WC; Fri, 24 Jan 2025 10:00:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Dan Carpenter
 <dan.carpenter@linaro.org>,  Joanne Koong <joannelkoong@gmail.com>,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
	(Bernd Schubert's message of "Thu, 23 Jan 2025 17:55:29 +0100")
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
Date: Fri, 24 Jan 2025 08:59:53 +0000
Message-ID: <8734h8poxi.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

On Thu, Jan 23 2025, Bernd Schubert wrote:

> This is a list of fixes that came up from review of Luis
> and smatch run from Dan.
> I didn't put in commit id in the "Fixes:" line, as it is
> fuse-io-uring is in linux next only and might get rebases
> with new IDs.

Thank you for this, Bernd.  And sorry for the extra work -- I should have
sent these patches myself instead of simply sending review comments. :-(

Anyway, they all look good, and probably they should simply be squashed
into the respective patches they are fixing.  If they are kept separately,
feel free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>

Cheers,
--=20
Lu=C3=ADs

> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> Bernd Schubert (5):
>       fuse: Fix copy_from_user error return code in fuse_uring_commit
>       fuse: Remove an err=3D assignment and move a comment
>       fuse: prevent disabling io-uring on active connections
>       fuse: Remove unneeded include in fuse_dev_i.h
>       fuse: Fix the struct fuse_args->in_args array size
>
>  fs/fuse/dev_uring.c  | 23 ++++++++++++-----------
>  fs/fuse/fuse_dev_i.h |  1 -
>  fs/fuse/fuse_i.h     |  2 +-
>  3 files changed, 13 insertions(+), 13 deletions(-)
> ---
> base-commit: a5ca7ba2e604b5d4eb54e1e2746851fdd5d9e98f
> change-id: 20250123-fuse-uring-for-6-14-incremental-to-v10-b6b916b77720
>
> Best regards,
> --=20
> Bernd Schubert <bschubert@ddn.com>
>

