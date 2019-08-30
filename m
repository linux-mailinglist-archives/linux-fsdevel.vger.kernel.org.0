Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB9A3A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3PkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 11:40:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3PkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zsf6yGneFmydWkIl4Pued0hWa2tOF2q92siXl0GbIF4=; b=dY2DOX5o6SuQSeaVMMSXswOxlg
        Bg20uuzw3AAskQHpp+Dg0jhVrc9oB99k0q5hNaQ8/MaQpze8cUvHNPpKd+YTe2fgB+nYk6G8+/oD3
        v86ukmMaMhu69u63D8AQhmNTjwNajd1RK5kyFmBFCFX1yuQB+SuvOgvScHENHmv0geNqVllcvVsIe
        /AkYs5wx45cNWQAWcVTWgSpuPM2miHnfM7EmV7tSTespZ1rhZTvpI9BEtr8zc7pV1IkCrrGrcWvdd
        2bKj6VsWaRq6U2Ep89j/zpz+uC0P6V1rt9dlNxtv3unuZyYM1ygOyf5XeMZ4oPZVfwKaumr610tKx
        Sl1FrmZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3j0Q-0002CE-M2; Fri, 30 Aug 2019 15:40:06 +0000
Date:   Fri, 30 Aug 2019 08:40:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830154006.GB30863@infradead.org>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829205631.uhz6jdboneej3j3c@pali>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:56:31PM +0200, Pali Rohár wrote:
> In my opinion, proper way should be to implement exFAT support into
> existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
> new (now staging) fat implementation.
> 
> In linux kernel we really do not need two different implementation of
> VFAT32.

Not only not useful, but having another one is actively harmful, as
people might actually accidentally used it for classic fat.

But what I'm really annoyed at is this whole culture of just dumping
some crap into staging and hoping it'll sort itself out.  Which it
won't.  We'll need a dedidcated developer spending some time on it
and just get it into shape, and having it in staging does not help
with that at all - it will get various random cleanup that could
be trivially scripted, but that is rarely the main issue with any
codebase.
