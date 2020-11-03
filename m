Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA12A4F76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKCS5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCS5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:57:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74924C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+wvoqRDMgu8fq2BWfy57g2MPEYGrDdC1F0382iIgXUI=; b=tcP94RV3yIjKF+mCelGnHDneg1
        oRoucPfVhDVYRCQVoFDQ96KoSza6GKXvJ+Avq6hIa6Hit25RdBvr3aDlgZj2pUbVoyXaHlvDaLLMG
        dpyeb2br53g0UvrI/GLnW0KSH/CP1avFR08EOUDuMF/t887cJlqYb+guiJIidhZ71Z0pbnzFjUJ+7
        LsEEsw3VZCLSB9AYdC6lVEdVqq1gJ1EmYe2NzoE92vSd1OBR2PINgshlcjPoB3R9Ge1MsrWSJzmYJ
        SVHqkW3fLMX+4kQA5a2486tA0T6ivkJxStQkZ6ZrfAf33ID3A6ceklg326hg409iVzo0BPdNDjttN
        qmMwieWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka1Ub-0005l1-OT; Tue, 03 Nov 2020 18:57:18 +0000
Date:   Tue, 3 Nov 2020 18:57:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Subject: Re: befs: TODO needs updating
Message-ID: <20201103185717.GE27442@casper.infradead.org>
References: <CAE1WUT6Q2-fC5Zo-dmjt9FJEt6ADmy1rijYX41aBmWwtO6Dp6Q@mail.gmail.com>
 <20201103153005.GB27442@casper.infradead.org>
 <CAE1WUT43_MT3p0B5S6sE9hcXQENGidDvQiWk31OKZH39jE8U7g@mail.gmail.com>
 <CAE1WUT7OChDF8iGnZ5kdXPeBbesFmHpu8Cqw3h3EeNY1otWT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT7OChDF8iGnZ5kdXPeBbesFmHpu8Cqw3h3EeNY1otWT0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:20:33AM -0800, Amy Parker wrote:
> Luis's email appears to be broken right now. The mailer daemon
> indicated an error on its end:
> 
> > <luis@other.computer> (expanded from <luisbg@kernel.org>): unable to look up
> >     host other.computer: Name or service not known
> 
> Is this occurring for you as well?

Yes; I've found someone who has a current address for Luis and suggested
that they update their address on kernel.org.
