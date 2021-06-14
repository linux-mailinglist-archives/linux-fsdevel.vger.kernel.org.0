Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE03A5D63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhFNHJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 03:09:24 -0400
Received: from verein.lst.de ([213.95.11.211]:43019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhFNHJT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:09:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A4CA67373; Mon, 14 Jun 2021 09:07:13 +0200 (CEST)
Date:   Mon, 14 Jun 2021 09:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <20210614070712.GA29881@lst.de>
References: <20210608161327.1537919-1-hch@lst.de> <202106081033.F59D7A4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106081033.F59D7A4@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:34:29AM -0700, Kees Cook wrote:
> NAK, please answer my concerns about your patches instead:
> https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

No.  This code pokes into block layer internals with all kinds of issues
and without any signoff from the relevant parties.  We just can't keep it
around.
