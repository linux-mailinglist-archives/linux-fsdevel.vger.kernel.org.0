Return-Path: <linux-fsdevel+bounces-5178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2080905C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959081F211BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A74F5E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F83122;
	Thu,  7 Dec 2023 09:46:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F056227A87; Thu,  7 Dec 2023 18:46:33 +0100 (CET)
Date: Thu, 7 Dec 2023 18:46:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 05/17] fs: Restore kiocb.ki_hint
Message-ID: <20231207174633.GE31184@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013322.175290-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 29, 2023 at 05:33:10PM -0800, Bart Van Assche wrote:
> Restore support for passing file and/or inode write hints to the code
> that processes struct kiocb. This patch reverts commit 41d36a9f3e53
> ("fs: remove kiocb.ki_hint").

Same comment as for the previous one.

