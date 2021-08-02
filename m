Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98CD3DE207
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhHBV6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHBV6q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 733E060187;
        Mon,  2 Aug 2021 21:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627941516;
        bh=ye825ek9Rk2e9Kpzz3357+dFQOwXo4tWlZEWNqkhf4s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=AFRt+vw9zLztnxMO0okmOkfiiXMyjvw9WQE0xxNvclPk6MQedy3Hou4oHA8AovSlu
         vQNr1B7Qh2/mR3LDhG74zoCnqH7Uaacugp1hUdJunrlZq1iB7FJG9D5TGmgtdmcCX+
         EtiZ+u7kq4qnYaOMcWyd9WXPNWem11sTSZt+mkvkQ+gPJo5JOO9UxitggNR5TMSZXP
         zP/SyfnnO0HaAUS7xO9X8sc5eAiOk3uwxpCcq3W2OxPHPOfZy7g5SMCRJC4Bkyfip3
         S4peeD/VqSeKQztPX5E3fK1bZwBwc1MnRsTssYs3z0sebPbJ19AlG87JSN78j8PC7Y
         M4ZSqN1iRX/5A==
Date:   Mon, 2 Aug 2021 14:58:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9] iomap: Support file tail packing
Message-ID: <20210802215836.GB3601405@magnolia>
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
 <CAHc6FU5x3XOTyu8vooReSZ-hacfTdo3cu7wFJRcQrfTH8NkVeg@mail.gmail.com>
 <YQfh7V0lvLNx0QlR@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQfh7V0lvLNx0QlR@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 08:15:41PM +0800, Gao Xiang wrote:
> Hi Andreas,
> 
> On Sun, Aug 01, 2021 at 02:03:33PM +0200, Andreas Gruenbacher wrote:
> > On Tue, Jul 27, 2021 at 5:00 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> ...
> 
> > > +static int iomap_write_begin_inline(struct inode *inode,
> > > +               struct page *page, struct iomap *srcmap)
> > > +{
> > > +       /* needs more work for the tailpacking case, disable for now */
> > 
> > Nit: the comma should be a semicolon or period here.
> 
> Sorry for some delay (busy in other things...)
> 
> Yeah, that's fine to me, in English contexts it'd be better like that
> (there is some punctuation rule difference between languages.)
> 
> 
> Hi Darrick,
> Should I resend v10 for this punctuation change or could you kindly
> help revise this?
> 
> (btw, would you mind set up a for-next iomap branch so I could rebase
>  other EROFS patches on iomap for-next, thank you very much!)

Er... I'll send a group email shortly.  Assembling the branch hasn't
been as straightforward as it usually is...

--D

> Thanks,
> Gao Xiang
