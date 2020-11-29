Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADA2C7A80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgK2SQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 13:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2SQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:16:17 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D39C0613D2;
        Sun, 29 Nov 2020 10:15:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E8E62128098B;
        Sun, 29 Nov 2020 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606673733;
        bh=KQfMF1A2OIPPAOwzmMPIGnkshCqrekjHxY7nCeJhFhQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=N6BgciTrlrM/EIZ+6zPwCOWWFEj3JSAEbIY3sehF2hTbXB2/aBJhqnMZkYI23mTjv
         VpZKx8cegIzteHmno+VPPspd4uDPnpEPODiNq8L9uOzDhMn2zOLqAy0BWuACHottKY
         PzqsDFGhye6i05zSr5ujFPw8kTQfrhDbSMLwBubc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Valpx4ImvwB; Sun, 29 Nov 2020 10:15:33 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 60BC7128098A;
        Sun, 29 Nov 2020 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606673733;
        bh=KQfMF1A2OIPPAOwzmMPIGnkshCqrekjHxY7nCeJhFhQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=N6BgciTrlrM/EIZ+6zPwCOWWFEj3JSAEbIY3sehF2hTbXB2/aBJhqnMZkYI23mTjv
         VpZKx8cegIzteHmno+VPPspd4uDPnpEPODiNq8L9uOzDhMn2zOLqAy0BWuACHottKY
         PzqsDFGhye6i05zSr5ujFPw8kTQfrhDbSMLwBubc=
Message-ID: <ec43cf0faa4bfeaa4495b4e1f1c61e617d468591.camel@HansenPartnership.com>
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Tom Rix <trix@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Nov 2020 10:15:32 -0800
In-Reply-To: <d65cd737-61a5-4b31-7f25-e72f0a7f4ec2@infradead.org>
References: <20201127190707.2844580-1-trix@redhat.com>
         <20201127195323.GZ4327@casper.infradead.org>
         <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
         <d65cd737-61a5-4b31-7f25-e72f0a7f4ec2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-11-29 at 09:52 -0800, Randy Dunlap wrote:
> On 11/29/20 9:47 AM, Tom Rix wrote:
> > On 11/27/20 11:53 AM, Matthew Wilcox wrote:
> > > On Fri, Nov 27, 2020 at 11:07:07AM -0800, trix@redhat.com wrote:
> > > > +++ b/fs/fcntl.c
> > > > @@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd,
> > > > unsigned int, cmd,
> > > >  	(dst)->l_whence = (src)->l_whence;	\
> > > >  	(dst)->l_start = (src)->l_start;	\
> > > >  	(dst)->l_len = (src)->l_len;		\
> > > > -	(dst)->l_pid = (src)->l_pid;
> > > > +	(dst)->l_pid = (src)->l_pid
> > > This should be wrapped in a do { } while (0).
> > > 
> > > Look, this warning is clearly great at finding smelly code, but
> > > the
> > > fixes being generated to shut up the warning are low quality.
> > > 
> > Multiline macros not following the do {} while (0) pattern are
> > likely a larger problem.
> > 
> > I'll take a look.
> 
> Could it become a static inline function instead?
> or that might expand its scope too much?

I think nowadays we should always use static inlines for argument
checking unless we're capturing debug information like __FILE__ or
__LINE__ or something that a static inline can't.  Even in the latter
case the pattern should probably be single line #define that captures
the information and passes it to a static inline.

There was a time when we had problems with compiler expansion of static
inlines, so we shouldn't go back and churn the code base to change it
because there's thousands of these and possibly some old compiler used
for an obscure architecture that still needs the define.

James


