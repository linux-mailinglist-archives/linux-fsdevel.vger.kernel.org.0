Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780DE48B51F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbiAKSFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 13:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiAKSEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:04:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED221C06173F;
        Tue, 11 Jan 2022 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zwqdfzt0DvYRTdP2ErkEoVOuQqsqbbhd1smOWlFrSmE=; b=mBINxuzg8tFsgoOPBV7fvEZrfI
        MQoCJugSueIJpN0/jjrJnV7lDRcRvKOQdpxazSM8qkJeS0xWXFVWxAm+iB+naf3JdeTo5exWOykdB
        bIi1ZlitMZmdTrRspVsUs0vslyODqJheHKmJQ32IkdbhZ49f7TwMEJrMNKKkDyIq+Ih0R9vD/i3am
        SLMRG5E04j3iLRMB33nfBj4p4m9+sdlOS4/VCpFJtyFWUOoBIynNhJwgjl4pZtunPkiMYV0zacchL
        Rk+zOB+2U8D9cEO7JNJlgViv7IdYs3Hn5x5PEnNBOjQVOWH1rILH+PLVlL2kZjjhSybPRW1qovhMn
        nqke/l6A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7LVi-00HE20-NH; Tue, 11 Jan 2022 18:04:42 +0000
Date:   Tue, 11 Jan 2022 10:04:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Fix duplicate path separator in printed entries
Message-ID: <Yd3Gur0daNb4JL77@bombadil.infradead.org>
References: <e3054d605dc56f83971e4b6d2f5fa63a978720ad.1641551872.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3054d605dc56f83971e4b6d2f5fa63a978720ad.1641551872.git.geert+renesas@glider.be>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:38:44AM +0100, Geert Uytterhoeven wrote:
> sysctl_print_dir() always terminates the printed path name with a slash,
> so printing a slash before the file part causes a duplicate like in
> 
>     sysctl duplicate entry: /kernel//perf_user_access
> 
> Fix this by dropping the extra slash.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
