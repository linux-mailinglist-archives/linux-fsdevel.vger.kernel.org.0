Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE942E6C49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgL1Wzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgL1Uto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:49:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16820C0613D6;
        Mon, 28 Dec 2020 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FrB/y6cXrm8/7RnJKAfFvaXuj1DLc5dHGGTX7neRwVU=; b=gFRd1vbjeHG/rlpqny3Motu1NL
        dAQ5+ksACy9pQ9fxS9/gOv9iZZhXTgnHdpPWvEGfQ1Y+3x9lZjpwXld05hgqFGflQl2pDIsRwE/Uo
        d7V1nkzxeBxZWeOMm4+ZmvIHYMEqGkhtnCDyYuhrZ+RuBkQKyq6KeT3V+VgGjRWbhq3Ox9ODXQbxE
        MIPBOu5iQ0cUcDx99sqjJbrPGa0w0SYXvRsrgeQRrJvhAOfyqRRj9VY1n28BKInZFCaPHgP1Obec7
        Uu1BHbKoBE/+nnfA5FptkL2BhDuj/rZS8z+Es3nsVykKSg6zI+v4OZx1x03jyA3Q7Y3fIhSny75N9
        H+3VNwgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzRV-0001z3-L5; Mon, 28 Dec 2020 20:48:40 +0000
Date:   Mon, 28 Dec 2020 20:48:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201228204837.GA28221@casper.infradead.org>
References: <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org>
 <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
 <20201228155618.GA6211@casper.infradead.org>
 <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
 <CAOQ4uxhFz=Uervz6sMuz=RcFUWAxyLEhBrWnjQ+U0Jj_AaU59w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhFz=Uervz6sMuz=RcFUWAxyLEhBrWnjQ+U0Jj_AaU59w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:37:37PM +0200, Amir Goldstein wrote:
> Having said that, I never objected to the SEEN flag split.

I STRONGLY object to the SEEN flag split.  I think it is completely
unnecessary and nobody's shown me a use-case that changes my mind.
