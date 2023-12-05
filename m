Return-Path: <linux-fsdevel+bounces-4895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2838805F81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EC31F21664
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B656D1D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqq465d1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C76AB97;
	Tue,  5 Dec 2023 20:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D63C433C8;
	Tue,  5 Dec 2023 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701806560;
	bh=7JJfswsBG5z/8ktKM2xOnVOfyruUDCBnorSgSrS+dbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqq465d1hXYm0umJ6va9SgiHkdfvtYNrl12mHe40ZHH+Jcx1tBiW12WRuhpK76x2a
	 rsr7+YvvsENgCOLM9Du8uyR72+Y9eerUAL4EPn7brs9lViyPddlItjwR+Aijsu77oI
	 XNYvygGn4S1FnnQV98Qh6P/pCKPWqByIbEe8gb3R2d5jqS+4ESfXutU33T7ahf5mQi
	 YR/ECo+SEWhbkK73or0Ic2vpyNRBkyGejm8iP8nA3vq/j+AhtjF4eY4ijkZbMkUXrQ
	 W/SsmJ24NdB8hoRyj0rTOame42pfjopdp6iHl+sJqwFKvbxa5tCveec5eKQYLWpqkl
	 cdA7+0kYIC2qQ==
Date: Tue, 5 Dec 2023 12:02:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/46] btrfs: add fscrypt support
Message-ID: <20231205200238.GA1093@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <20231205014917.GB1168@sol.localdomain>
 <20231205141655.GC2751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205141655.GC2751@twin.jikos.cz>

On Tue, Dec 05, 2023 at 03:16:55PM +0100, David Sterba wrote:
> 
> we have the development git tree on github and not on kernel.org.

Then the MAINTAINERS entry for btrfs needs to be updated, as it points to
kernel.org.  I already had to update it for you guys the last time it changed
(https://git.kernel.org/linus/eb91db63a90d8f8e).  Not sure why you guys can't
keep it up to date.

BTW, https://github.com/btrfs/linux exists but it's the wrong one too, which
makes it extra confusing.

- Eric

