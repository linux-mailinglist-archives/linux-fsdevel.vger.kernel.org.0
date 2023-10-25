Return-Path: <linux-fsdevel+bounces-1186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D057D6EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A279E1F22E79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10092AB23;
	Wed, 25 Oct 2023 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AB28E27
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:28:12 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6F136
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77B9A67373; Wed, 25 Oct 2023 16:28:09 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:28:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: derive f_fsid from bdev->bd_dev
Message-ID: <20231025142809.GB19481@lst.de>
References: <20231024121457.3014063-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024121457.3014063-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Christian, can you pick it up in the vfs tree?

