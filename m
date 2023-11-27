Return-Path: <linux-fsdevel+bounces-3935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B953B7FA1CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9BF1C20E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AF30FB3;
	Mon, 27 Nov 2023 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BB30ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 05:59:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D264167373; Mon, 27 Nov 2023 14:59:00 +0100 (CET)
Date: Mon, 27 Nov 2023 14:59:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: massage wait event mechanism
Message-ID: <20231127135900.GA24437@lst.de>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org> <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you explain why you're "massaging" things here?


