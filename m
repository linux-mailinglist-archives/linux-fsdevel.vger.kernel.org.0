Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1836391E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGIQPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:15:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48810 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfGIQPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:15:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F3128EE24C;
        Tue,  9 Jul 2019 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562688943;
        bh=JfZMiQaimhE8tVjgh946XQAbwaDQ14EcoZOpefa0Lbw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D2jpmbvBni9SZpVSSd/xGo0DsC7Cwg2SKxoZuYQD/MxjLZwZFhwULDO2SEDCwW6KM
         Lw4i0/CW3PPwIXjLRp2wfOBxwKqRJ/OedEuqfy243/9naKpkb5uLNVELx4Gm5vYSbo
         D+aPk57XzEQfTZOEycwSamnxCEM5Mjx89jP91j4E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GDlUqWcQ81zh; Tue,  9 Jul 2019 09:15:42 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 431918EE15F;
        Tue,  9 Jul 2019 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562688942;
        bh=JfZMiQaimhE8tVjgh946XQAbwaDQ14EcoZOpefa0Lbw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xv/lRfCrzwwiTloyTSScopIfEE7eEPQbnqE02Yrzg1vgbqu65vAhM1mt85FCgCXP0
         5dx/nf7TZvFI0470536UhfLg6n/6WZDjr2c40GL8MYwAwO53TgLzQD9bKovgz4p33m
         2dBM7fZSaRzPz9We0OFM8/EXxo4yQudtQ3mIh5sg=
Message-ID: <1562688939.3362.47.camel@HansenPartnership.com>
Subject: Re: exfat filesystem
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com
Cc:     Sasha Levin <sashal@kernel.org>
Date:   Tue, 09 Jul 2019 09:15:39 -0700
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
References: <21080.1562632662@turing-police>
         <20190709045020.GB23646@mit.edu>
         <20190709112136.GI32320@bombadil.infradead.org>
         <20190709153039.GA3200@mit.edu>
         <20190709154834.GJ32320@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-07-09 at 08:48 -0700, Matthew Wilcox wrote:
> On Tue, Jul 09, 2019 at 11:30:39AM -0400, Theodore Ts'o wrote:
> > On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
> > > How does
> > > https://www.zdnet.com/article/microsoft-open-sources-its-entire-p
> > > atent-portfolio/
> > > change your personal opinion?
> > 
> > According to SFC's legal analysis, Microsoft joining the OIN
> > doesn't mean that the eXFAT patents are covered, unless *Microsoft*
> > contributes the code to the Linux usptream kernel.  That's because
> > the OIN is governed by the Linux System Definition, and until MS
> > contributes code which covered by the exFAT patents, it doesn't
> > count.
> > 
> > For more details:
> > 
> > https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/
> > 
> > (This is not legal advice, and I am not a lawyer.)
> 
> Interesting analysis.  It seems to me that the correct forms would be
> observed if someone suitably senior at Microsoft accepted the work
> from Valdis and submitted it with their sign-off.  KY, how about it?

KY, if you need local help to convince anyone, I can do that ... I've
been deeply involved in patent issues with open source from the
community angle for a while and I'm used to talking to corporate
counsels.  Personally I think we could catch Microsoft in the implied
licence to the FAT patent simply by putting exfat in the kernel and
waiting for them to distribute it but I think it would benefit
Microsoft much more from a community perspective to make an open
donation of the FAT patents to Linux in much the same way they've
already done for UEFI.  If my analysis of the distribution situation is
correct, it would be making a virtue of a necessity anyway which is
always a useful business case argument.

James

