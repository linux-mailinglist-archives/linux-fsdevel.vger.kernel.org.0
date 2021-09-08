Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D463A40342F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbhIHGUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 02:20:20 -0400
Received: from verein.lst.de ([213.95.11.211]:38065 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236202AbhIHGUT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:20:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D17367373; Wed,  8 Sep 2021 08:19:10 +0200 (CEST)
Date:   Wed, 8 Sep 2021 08:19:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple to
 utf8_load
Message-ID: <20210908061909.GA28651@lst.de>
References: <20210818140651.17181-1-hch@lst.de> <20210818140651.17181-6-hch@lst.de> <87h7exfj31.fsf@collabora.com> <87a6kpfiyv.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6kpfiyv.fsf@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 06:16:24PM -0400, Gabriel Krisman Bertazi wrote:
> > ext4_msg("... %u.%u.%u\n", (encoding_info->version>>12) & 0xff,
> > 	 (encoding_info->version>>8) & 0xff), encoding_info->version & 0xff))

I'd rather not open code these shifts and add helpers for them.

> > The rest of the series looks good and I can pick it up for 5.15, unless
> > someone has anything else to say?  It has lived on the list for a while
> > now.
> >
> 
> Ugh, pressed reply too quickly.  Sorry for the multiple email reply.
> 
> In the summary line: tripple -> triple.

Let me resend with the above change.
