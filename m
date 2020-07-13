Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8387B21DB1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGMQDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMQDB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:03:01 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67B62067D;
        Mon, 13 Jul 2020 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594656181;
        bh=S8LYfbg9w62y15vyoHyNOnOdB9WFrZOfPUZ2C+CRenY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/bmiRv67olNRdWbrO3EXhsymZpW1D3h2MC7+pWaoI/HOUUfpbei52wNMlbpFtwG/
         t1JcXoKkEqNoqIGOCDz6EADFwZM98HQ0hCpH33MJToU91XCOhxUxYUtJOFu20LMNds
         1G0Tpu2YOU5PhY95eexSAFgxVXe23+2ihMqo7BaY=
Date:   Mon, 13 Jul 2020 09:02:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: define inode flags using bit numbers
Message-ID: <20200713160259.GB1696@sol.localdomain>
References: <20200713030952.192348-1-ebiggers@kernel.org>
 <20200713115947.GX12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713115947.GX12769@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:59:47PM +0100, Matthew Wilcox wrote:
> On Sun, Jul 12, 2020 at 08:09:52PM -0700, Eric Biggers wrote:
> > Define the VFS inode flags using bit numbers instead of hardcoding
> > powers of 2, which has become unwieldy now that we're up to 65536.
> 
> If you're going to change these, why not use the BIT() macro?
> 

Either way would be fine with me, but I've seen people complain about BIT()
before and say they prefer just (1 << n).

- Eric
