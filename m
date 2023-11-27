Return-Path: <linux-fsdevel+bounces-3941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A07FA399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58332B2126A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73330355;
	Mon, 27 Nov 2023 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUu6Kmnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957401A710
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 14:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14065C433C7;
	Mon, 27 Nov 2023 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701096820;
	bh=kW6rzGi+OzY5Z1h3DAz0hU6alhhfrOMgYbX7LBgwyao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUu6Kmnl+O9eSg17rXgxZ9MSqQiXQ+2ze2lWbJrysaMprhPE9GA0KqHAjdnS3jlIW
	 +Z666Miwa6P7IvkxRks6XUxabBCXyTTUJmbwhjqDo4dFXdBGTIBLYmKSofq959/eMK
	 px5K6YZiHO2Giyc36IljRJJy4kE7UXFI36v7wjDm3PRgFPWAuwo3LMn/D8TeCmYwSQ
	 RnidMeQFD8tJCkwwgQA2WSaJJZ6xwKGmjh0m60mxg4vqWPVHJJDNXQZW90xKSlYtRH
	 Uc5AvJGWd0H5r6fk6mTI0pEs1cwEWCI4xkwX1FNv4glwL/P6Sr91eb0vVu+HWC1qoX
	 BB3ppJ1vn1MVg==
Date: Mon, 27 Nov 2023 15:53:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] super: don't bother with WARN_ON_ONCE()
Message-ID: <20231127-leibgericht-rampen-ce0a28e1c6ba@brauner>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
 <20231127-vfs-super-massage-wait-v1-2-9ab277bfd01a@kernel.org>
 <20231127135945.GB24437@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127135945.GB24437@lst.de>

On Mon, Nov 27, 2023 at 02:59:45PM +0100, Christoph Hellwig wrote:
> This looks ok, but I still find these locking helper so horrible to
> follow..

What do you still find objectionable?

