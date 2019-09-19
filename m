Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEACB7FAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbfISRHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:07:16 -0400
Received: from verein.lst.de ([213.95.11.211]:42808 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390733AbfISRHQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:07:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3C0968BE1; Thu, 19 Sep 2019 19:07:11 +0200 (CEST)
Date:   Thu, 19 Sep 2019 19:07:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
Message-ID: <20190919170711.GA9065@lst.de>
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com> <20190919034502.GJ2229799@magnolia> <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:03:30AM -0700, Linus Torvalds wrote:
> It's just that we've survived three decades without that list_pop(),
> and I don't want to make our header files even bigger and more complex
> unless we actually have multiple real users.

I personally surived with it, but really hated writing the open coded
list_for_each_entry + list_del or while list_first_entry_or_null +
┐ist_del when I could have a nice primitive for it.  I finally decided
to just add that helper..
