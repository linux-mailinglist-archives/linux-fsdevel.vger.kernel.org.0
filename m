Return-Path: <linux-fsdevel+bounces-66751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF03C2B7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 748024F7A98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D830217F;
	Mon,  3 Nov 2025 11:41:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5F2FFDC9;
	Mon,  3 Nov 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170098; cv=none; b=iKwi8x/EDQI4lkl0S3Ey+YT4FwC9qN0gSJFsFlVGnybkrWxsH0oeZs8t9PloWrq2oZL2hy65qUqrFlUM0jFwR1n2+JEkza8+94IMO0lVN2SzcRfu7tvFVKQcDLfOzOOAi0vKPdV44Twt64jssZnYEsxsNZzeeixRW/U08gGKk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170098; c=relaxed/simple;
	bh=sv39PJrTpgPPUHEbkg7UcF3j1vJO+ue4AKHAHtsEyP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRXQiG2H8Z/s7jwAERbMyFVn9HyXoJVNckROcJBEHZUhK1K1e2MA6y9EKPEYXLQ5pzR9uBbup0hOrjXHGwWuP7NBvrJqKUd0b0S6Lh+xy5JWtNLDax3o4WzaJ98L56pBPFTQJi+6rABqEGxR+CC9e6Zj5RPvHVqVVrmA6l0wX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07FDD227A87; Mon,  3 Nov 2025 12:41:31 +0100 (CET)
Date: Mon, 3 Nov 2025 12:41:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-ID: <20251103114130.GA14852@lst.de>
References: <20251031203430.3886957-1-csander@purestorage.com> <20251031203430.3886957-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031203430.3886957-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good for the block/nvme bits:

Reviewed-by: Christoph Hellwig <hch@lst.de>


