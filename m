Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB361AF65D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDSDPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 23:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgDSDPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 23:15:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C220C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Ro2rspiQo7EV3W3fQVMmRQMKQdcfHJHRFO7Bup+rX0=; b=Tp7MkvjJ1ppKlUVnOKwx7ogHK4
        VDmP9bKh2TdCfmlqKQqn3Z9L4Ow1wiWUtEF4mDPfI7T5jlINxkcnA9003v9VnPswOzWy4p08ttx5s
        JphinknXweY6BNqkXcego+O8KE7izQ0BkMWmH5WPGXra0/0Gq6TttCCfxE0vOCHqB3oWqlCtXrRO4
        f7XfyT//eo29bqkp1huE0SFZRGUI7Z38diiFNOzlmgKJmblzOOHLCsAK3ON10uBK4ATQSq8DHfKp0
        M1+qsDKZJh9gnsRDgJdtlib6zE4/kYXJGDQZAJE86KI1OEnKsi+S4eQSm4fjZBJw28MU5mdrdAmiJ
        jQQKzoLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQ0R0-000872-AW; Sun, 19 Apr 2020 03:15:54 +0000
Date:   Sat, 18 Apr 2020 20:15:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 1/2] exfat: properly set s_time_gran
Message-ID: <20200419031554.GU5820@bombadil.infradead.org>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <5535c58b-aac1-274e-a0bb-6333b33365d1@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5535c58b-aac1-274e-a0bb-6333b33365d1@sandeen.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:09:11PM -0500, Eric Sandeen wrote:
> -	sb->s_time_gran = 1;
> +	sb->s_time_gran = 10000000;

10 * NSEC_PER_MSEC?
