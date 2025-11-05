Return-Path: <linux-fsdevel+bounces-67114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E1C358B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7084A1883B64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516A3126CD;
	Wed,  5 Nov 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRMglurA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFA30216F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343870; cv=none; b=G+mhbn4w9S+x2f+TbAfLM3RbqHYMdUZ+QYYxsR2kKvgkNBZIQiRoYVNRPTOpiGuiE6iacXdBeEgtPT0biKO2EtdSNSc3v1UgjxUBkbqdOw+M0z73rwe2jZoAukxoa6zYE3w/MaQdeGJPMbiYdpmPXz4wFFu4I8ISSO0PGi87ZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343870; c=relaxed/simple;
	bh=sRblGwvg7mUFCHltZzeY8PBpcw/V2XcepPGBhZ9j7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b93q02W9TnfZPv6+7bg87OGm+KPH/HDQDUjDq/tGQbjEmOju51aDozZ86fHBnCLpfm/lT0grKY11jG2hvUhmRo6YAoI9c9Eds3MlJqqW+Nklgf5BB7Z1DotxCDFvSeCN4J8s1dHShT4dQxggOi2UguM2nVGNd/ONulzNHDpSQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRMglurA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFF5C4CEF8;
	Wed,  5 Nov 2025 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343869;
	bh=sRblGwvg7mUFCHltZzeY8PBpcw/V2XcepPGBhZ9j7ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRMglurAQIRxmbfkYfAnV5aC7JGiFFKG4S+JMFuDQeSTH0DuL6S7Sy0aogwmvCXD1
	 Dp6eu65sr3PEZnFlcBJLvZAyvcFl2aOm0WjefQKwAmkGpHHt8RN3vQvF05KOspzOWS
	 KvwZ0EC0AKlI9Ies0vVCwZrBE3sE2FvdmPa8yplQ2du9ZMzX6yKKQHdx0iPtbZjVPz
	 GNG5TJvPG0nPe7nHde8j8tKilSS9LHcF5L8j4NVAN9Lb0iQK3VFEf9Oe9i0JEkVngJ
	 XXQ+rOFzXlOOcOft8J9C+aM+e6sl9uzUHF2EUD+s5vjnar+L4EX1+g3wb8byxB00Kc
	 FJWRSF3NS/19g==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/1] vfs-6.19.iomap commit 51311f045375 fixup
Date: Wed,  5 Nov 2025 12:57:41 +0100
Message-ID: <20251105-errungenschaft-karitativ-04c91a5418e4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031211309.1774819-1-joannelkoong@gmail.com>
References: <20251031211309.1774819-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=brauner@kernel.org; h=from:subject:message-id; bh=sRblGwvg7mUFCHltZzeY8PBpcw/V2XcepPGBhZ9j7ZA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyW++cqCrS/OvLbsdTjzYtspwwV+W5uwzH7SUP7fZof 9NJM9t1raOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi290Z/vsYbT94t9Ms4rJU 3Iw9sh0lN6w3XdVNmyp672fwpy37Ga4z/OGJmq32Z1rIzl/X9jEzvAx1lmo/+fJ7d6qB39tXEbq sdxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 14:13:08 -0700, Joanne Koong wrote:
> This fixes the race that was reported by Brian in [1]. This fix was locally
> verified by running the repro (running generic/051 in a loop on an xfs
> filesystem with 1k block size).
> 
> Thanks,
> Joanne
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: fix race when reading in all bytes of a folio
      (no commit info)

