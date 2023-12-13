Return-Path: <linux-fsdevel+bounces-5976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDF8118EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436BE2824F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F133CD1;
	Wed, 13 Dec 2023 16:15:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874221BF;
	Wed, 13 Dec 2023 08:15:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12F9868B05; Wed, 13 Dec 2023 17:15:50 +0100 (CET)
Date: Wed, 13 Dec 2023 17:15:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] fs: move fscrypt keyring destruction to after
 ->put_super
Message-ID: <20231213161548.GA11294@lst.de>
References: <20231213040018.73803-1-ebiggers@kernel.org> <20231213040018.73803-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213040018.73803-4-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

