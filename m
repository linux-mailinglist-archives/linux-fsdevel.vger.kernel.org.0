Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CC01F7DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLTtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:49:14 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB613C03E96F;
        Fri, 12 Jun 2020 12:49:13 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjpfh-007nEs-Ie; Fri, 12 Jun 2020 19:49:01 +0000
Date:   Fri, 12 Jun 2020 20:49:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
Message-ID: <20200612194901.GD23230@ZenIV.linux.org.uk>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
 <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
 <20200612184701.GI8681@bombadil.infradead.org>
 <95eacd3e-9e29-6abf-9095-e8f6be057046@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eacd3e-9e29-6abf-9095-e8f6be057046@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:00:14PM +0200, Markus Elfring wrote:
> >> I suggest to take another look at published software development activities.
> >
> > Do you collateral evolution in the twenty?
> 
> Evolutions and software refactorings are just happening.
> Can we continue to clarify the concrete programming items
> also for a more constructive review of this patch variant?

The really shocking part is that apparently this thing is _not_ a bot -
according to the people who'd been unfortunate enough to meet it, it's
hosted by wetware and behaviour is the same face-to-face...

I'm still not convinced that it's not a sociology student collecting
PhD material, though - something around strong programme crowd,
with their religious avoidance of learning the subject matter, lest
it taints their "research"...
