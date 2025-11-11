Return-Path: <linux-fsdevel+bounces-67920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A67C4D9DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7164F95B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3734F466;
	Tue, 11 Nov 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeqMDAvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716002882B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862966; cv=none; b=jyvLa3tarRMu/dI9+qjdYpeJ39xnFt8Csrm50kMPuiXSR0aPUprUPVi06IevOPrNy1E1rMUwTUFKyKtun54cz4NNlfhj3eB6unQmlbqEWa3pzKi+Jz80G9SoBzaH1mKn/mBOcVj5Jqyg01XdSyz5nXPay8zg8hivNdmZ4yp7eNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862966; c=relaxed/simple;
	bh=yfaPo/0eZ+ud3DCGWGSUVzKnElMxszGVg4+nj662poA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGtgq925/6TqlyzLJhXw0pMT2p/afg3AYg2iw1ZVAzuIm3NCnfEUoxN/kkt7I6TB/yYY3i9DVzbb0vt+qQSzpcz7JefrQihvynQbBaB3XqPaki+SVTGMeLq5ZHZdF2oT+lBS5in4NZATkDNNfqvMkep3N/MhcSEWtyovDamQ4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeqMDAvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A5DC4CEFB;
	Tue, 11 Nov 2025 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762862966;
	bh=yfaPo/0eZ+ud3DCGWGSUVzKnElMxszGVg4+nj662poA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeqMDAvUti/Ndb4ZKQpmuomc5xLLiHvGESSfc8vzNvpy3pXjV66fjHYFsLDPP6GyN
	 5vXAHv+UO2PO0gXEusp9wG18x/rOZfYtrPQAEW0lLzfMs6QGczWKh+K94TGPJHoTu6
	 ub/mEFPLJ78gaj5IKWeqkOrX5kn+1iT+mLMXZHVLG3jhGO6Qm3a0nu5kjhqLJ0tGzh
	 XfRCxxOqBMLRU/Zgw+I7o9RdP1dYoHwhv0pno2YwDRQQbEPfK9JAUh6PpvRvL6yGyY
	 6LIHxPtMcOvEqUHZHmo6GKmfeA/aQmw+PZjqfA8ZdLEjlM4G1PLWpeobCTRnq3rB4M
	 gGhhjKIGFwDQw==
Date: Tue, 11 Nov 2025 13:09:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: hch@infradead.org, djwong@kernel.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/8] iomap: buffered io changes
Message-ID: <20251111-unkontrollierbar-zugelangt-1dbd13f5d305@brauner>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:11PM -0800, Joanne Koong wrote:
> 
> v2: https://lore.kernel.org/linux-fsdevel/20251021164353.3854086-1-joannelkoong@gmail.com/
> v2 -> v3:
> * Fix race when writing back all bytes of a folio (patch 3)
> * Rename from bytes_pending to bytes_submitted (patch 3)
> * Add more comments about logic (patch 3)
> * Change bytes_submitted from unsigned to size_t (patch 3) (Matthew)
> 
> v1: https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-1-joannelkoong@gmail.com/
> v1 -> v2:
> * Incorporate Christoph's feedback (drop non-block-aligned writes patch, fix
>   bitmap scanning function comments, use more concise variable name, etc)
> * For loff_t patch, fix up .writeback_range() callback for zonefs, gfs2, and
>   block 

Joanne, I think we're ready to take this upstream. Could you do me a
favor and rebase this on top of vfs-6.19.iomap and resend?

