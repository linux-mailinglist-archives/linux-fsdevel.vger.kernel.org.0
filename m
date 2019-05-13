Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4598F1AED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 04:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEMCWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 22:22:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 22:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ovf8DxL66KOTW+e+mFqo250OtpU+burSC7yTnGdUx9E=; b=AbePClkk+AJWmJvb0upl911ZC
        MEyXdrYDiT8LmhcbY19c6hKyXF9FPg4jigBtQEH9NxvQ8VsHvdvRIjLLDLoMgU/GMNmLtHMJ/+hPM
        VjYmiqUISNNxVbGZme1Fz3ovXuG6U9U47MWS9yl2id5/4IQhSe3ALoeGqltBSB7+r1r4Jo9TmzlyB
        7OG51iHF4G/9hrdfdeNilfzs/X/w/cqEFFH9nlFd1O10w3KQOD1vSa5ml9WdvA67xyU+uvcemv1Sx
        VHUHFB31aA7RVVpBA8uF9ftE+xr4yn6pkUm/91Mu80Ansjx3qkg5fQNihB1rJi1FaGLoAUiAp/y6b
        +T4VYOwUg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ0be-0007bW-Fv; Mon, 13 May 2019 02:22:22 +0000
Date:   Sun, 12 May 2019 19:22:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shawn Landden <slandden@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: COW in XArray
Message-ID: <20190513022222.GA3721@bombadil.infradead.org>
References: <CA+49okpy=FUsZpc-WcBG9tMUwzgP7MYNuPPKN22BR=dq3HQ9tA@mail.gmail.com>
 <CA+49okq7+G7wRgr4N8QLMf-6pvqvYumMQzX6qrvp-qQQsRsGHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+49okq7+G7wRgr4N8QLMf-6pvqvYumMQzX6qrvp-qQQsRsGHQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 12, 2019 at 09:56:47AM -0500, Shawn Landden wrote:
> I am trying to implement epochs for pids. For this I need to allow
> radix tree operations to be specified COW (deletion does not need to
> change). Radix
> trees look like they are under alot of work by you, so how can I best
> get this feature, and have some code I can work with to write my
> feature?

Hi Shawn,

I'd love to help, but I don't quite understand what you want.

Here's the conversion of the PID allocator from the IDR to the XArray:

http://git.infradead.org/users/willy/linux-dax.git/commitdiff/223ad3ae5dfffdfc5642b1ce54df2c7836b57ef1

What semantics do you want to change?
