Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA2638DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGIPst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 11:48:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIPst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+SqRiX7dUQs2pjbdLNxkSvo5c+sYbuHqLzt+2iHVymw=; b=X0dXNaHO5xVa5gXR+XNOgRO+/
        mm0iPB3e+bjQdJuAUv0hWybDRpjMBrpAwKK492/V4sMCeOu4fMQruNKRn65uSQS+jkmZJsQu//4kd
        i3tDBLfEPUeCQQHvkQENkF+IXjj8CvQjw2clBSB0MXYYg6KRRUIn2T6A2mn/kuu2tMio02tQ6VvS4
        phihrF88G+0fgyUm6xhaiUhxYF09uPTymaEfVu1RmRhKOZo9Uus32yWg90QzDLWvfO6z7i82NTzOq
        9oBQR4dcQF5B5mb4sIWpmHkbmGFFSY+0kEYD3S+d0QmsSDmV9+MYdBUe9ZV4hszI2toHglLy8LcwN
        OqZt+NyEw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hksM6-00031j-Ut; Tue, 09 Jul 2019 15:48:34 +0000
Date:   Tue, 9 Jul 2019 08:48:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com
Cc:     Sasha Levin <sashal@kernel.org>
Subject: exfat filesystem
Message-ID: <20190709154834.GJ32320@bombadil.infradead.org>
References: <21080.1562632662@turing-police>
 <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
 <20190709153039.GA3200@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709153039.GA3200@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 11:30:39AM -0400, Theodore Ts'o wrote:
> On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
> > How does
> > https://www.zdnet.com/article/microsoft-open-sources-its-entire-patent-portfolio/
> > change your personal opinion?
> 
> According to SFC's legal analysis, Microsoft joining the OIN doesn't
> mean that the eXFAT patents are covered, unless *Microsoft*
> contributes the code to the Linux usptream kernel.  That's because the
> OIN is governed by the Linux System Definition, and until MS
> contributes code which covered by the exFAT patents, it doesn't count.
> 
> For more details:
> 
> https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/
> 
> (This is not legal advice, and I am not a lawyer.)

Interesting analysis.  It seems to me that the correct forms would be
observed if someone suitably senior at Microsoft accepted the work from
Valdis and submitted it with their sign-off.  KY, how about it?
