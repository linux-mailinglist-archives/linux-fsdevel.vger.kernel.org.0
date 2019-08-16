Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDA901F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHPMt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 08:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHPMt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OZ9pK5t5TgRovBnzn4CAWECGo1/kyneV4i6IDqGeq2Q=; b=QdWv+8nm2FgbI7CiZMJlJVx27
        JeUwmmPNzfZ41y9s5PVvX8rHKn3iYEcSpN+h4AwND7XfisCtl6CCyxotyept+rdxg3cIpO/y1+DZd
        lQ9cmzbvDKHrAa+v0QZlK0sIUfU5rrby8NZyFnXnFM4/rIGnYMXA7SJNBTHAMi/ewW94zBKQunxGb
        cv3wggzpSIVP2NCjHZbRWSmAkcCB9TDguD//UEWo2PbKYQpNbMc9sSf81cQfx2opl8ypYyUnli8HY
        H4VDllNWHx2HBVXr7/cm5ZWwy8BvPCCil4SZWh/Slpr1vXUfmQtFUR/RG17h6ijlHN95zapYFnB57
        bHclvnkGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hybfa-0001uB-Ka; Fri, 16 Aug 2019 12:49:26 +0000
Date:   Fri, 16 Aug 2019 05:49:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13] fs: Add VirtualBox guest shared folder (vboxsf)
 support
Message-ID: <20190816124926.GA6223@infradead.org>
References: <20190815131253.237921-1-hdegoede@redhat.com>
 <20190815131253.237921-2-hdegoede@redhat.com>
 <20190816075654.GA15363@infradead.org>
 <412a10a9-a681-4c7a-9175-e7509b3fea87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412a10a9-a681-4c7a-9175-e7509b3fea87@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:01:13AM +0200, Hans de Goede wrote:
> TL;DR: I believe that the current approach which is 3. from above is
> good enough and I like that it is very KISS. We can always switch to
> 1. or 2. (or add 1. and 2. and make it configurable) later if this shows
> to be necessary.
> 
> Can you please let me know if option 3. / the KISS method is ok with you,
> or if you would prefer me to add code to do 1. or 2?

I'm not sure I actually care.  Reading through the code just made me
realizie that no sane person should use this.  Obviously there are
plenty of insane people, otherwise virtualbox wouldn't be around anymore
anyway, and they apparently lived with much worse bugs before.

What I do care about is that someone actually thought about these
issues, which you very much did (probably unlike the original authors).
Maybe explaining these choice in code comments in addition to the email
would help, though.
