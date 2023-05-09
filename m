Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940D6FD084
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjEIVHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIVHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:07:08 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6292718
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 14:07:06 -0700 (PDT)
Date:   Tue, 9 May 2023 17:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683666424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1y0QpMsZMAEwx8dq7POmGR+kG/ze1jj01STyobpnGk=;
        b=DhOnJ/BH3PlfrCPrFMYULSNQ6MMbhlOSia1X86WqrIueQb8WHWDwKtwqdmDkhRFJpJ+Mip
        trNyEoKRmEYw8RdRHQFLogHz8cnVPaGaKA0w/xH4dIcbHZxEY8Sx58DUgzDwyn5raVyMNH
        BqhfM9smyellG290jCHd/wYihK1LSmg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 32/32] MAINTAINERS: Add entry for bcachefs
Message-ID: <ZFq19bA8MgDx/pzn@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-33-kent.overstreet@linux.dev>
 <08fed8bc-0a15-2d13-81d3-2a81408457ae@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08fed8bc-0a15-2d13-81d3-2a81408457ae@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 02:04:00PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/9/23 09:56, Kent Overstreet wrote:
> > bcachefs is a new copy-on-write filesystem; add a MAINTAINERS entry for
> > it.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dbf3c33c31..0ac2b432f0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3509,6 +3509,13 @@ W:	http://bcache.evilpiepirate.org
> >  C:	irc://irc.oftc.net/bcache
> >  F:	drivers/md/bcache/
> >  
> > +BCACHEFS:
> 
> No colon at the end of the line.

Thanks, updated.
