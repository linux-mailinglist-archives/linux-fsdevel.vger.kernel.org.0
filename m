Return-Path: <linux-fsdevel+bounces-3942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5147FA39F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0991C20EBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826730355;
	Mon, 27 Nov 2023 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBD99
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 06:54:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2E2467373; Mon, 27 Nov 2023 15:54:04 +0100 (CET)
Date: Mon, 27 Nov 2023 15:54:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: massage wait event mechanism
Message-ID: <20231127145404.GA29127@lst.de>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org> <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org> <20231127135900.GA24437@lst.de> <20231127-hievt-gespuckt-3db6f8bffb5c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-hievt-gespuckt-3db6f8bffb5c@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 03:52:56PM +0100, Christian Brauner wrote:
> On Mon, Nov 27, 2023 at 02:59:00PM +0100, Christoph Hellwig wrote:
> > Can you explain why you're "massaging" things here?
> 
> Ah, I didn't update my commit message before sending out:
> 
> "We're currently using two separate helpers wait_born() and wait_dead()
> when we can just all do it in a single helper super_load_flags(). We're
> also acquiring the lock before we check whether this superblock is even
> a viable candidate. If it's already dying we don't even need to bother
> with the lock."
> 
> Is that alright?

Sounds good, but now I need to go back and cross-reference it with
what actuall is in the patch :)

