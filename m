Return-Path: <linux-fsdevel+bounces-2363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F07E5181
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988C51C20D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08712D531;
	Wed,  8 Nov 2023 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vq1wJTuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC730D50E;
	Wed,  8 Nov 2023 07:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487A0192;
	Tue,  7 Nov 2023 23:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=10TtkC84MgEdXTa5RjVFmz/gjcO6SfZ5euwYQwRNU1s=; b=vq1wJTuK5vr73Sf/RaJCpO1R4T
	XcEn6bdluCjXCcBloeV62C1ZVmKVQfNaY/+DqC0hJvWnRbBb0bd2RWe+2d0jhHOkni6M/B7mgcdZG
	785+laa0HTOQhKDVQwQuCgmTEcGnEUg5aksUs5Ede06bgnH2H3BK/xowCYwVpEM4eDo9Di/ATJklP
	rAlGOmUaPv6BZWV91IWHmpovyqgpKUCH90wexNxuk4OGQUdyQsZAhdujh/kd5CBI7K8okDnoSgpH9
	5SDJEnrLHj0J3ZMTOKml4LYo5CiIldPMZv5VSrGHuPhuss1PmBCpouI2TfCE3wg2ViXXDHIXRnJBp
	S9bpjTlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dSn-003DrF-0Q;
	Wed, 08 Nov 2023 07:59:01 +0000
Date: Tue, 7 Nov 2023 23:59:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 01/18] fs: indicate request originates from old mount api
Message-ID: <ZUs/xULV9F8j+o39@infradead.org>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <75912547b45b70df4f5b7d19e2de8d5fda5c8167.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75912547b45b70df4f5b7d19e2de8d5fda5c8167.1699308010.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 06, 2023 at 05:08:09PM -0500, Josef Bacik wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> We already communicate to filesystems when a remount request comes from
> the old mount api as some filesystems choose to implement different
> behavior in the new mount api than the old mount api to e.g., take the
> chance to fix significant api bugs. Allow the same for regular mount
> requests.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

FYI, I'd be almost tempted to add a Fixes here - setting this flag
only for remounts in the old patch is almost asking for trouble..

