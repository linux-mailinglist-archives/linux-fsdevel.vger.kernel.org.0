Return-Path: <linux-fsdevel+bounces-1314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E781C7D8EE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CBF1C20EC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BD8F57;
	Fri, 27 Oct 2023 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F28F41
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:42:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9821F1A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:42:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A00468AFE; Fri, 27 Oct 2023 08:42:24 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] ext4: simplify device handling
Message-ID: <20231027064223.GC9530@lst.de>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org> <20231024-vfs-super-rework-v1-3-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-3-37a8aa697148@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

