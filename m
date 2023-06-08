Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18B728974
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 22:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFHUbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFHUbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:31:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC600185;
        Thu,  8 Jun 2023 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=siVNSKPmBOwH/fXD/ElDGtFbxy6tl/Ym2P0FuQH0e2k=; b=OXT5113Qb+PgJyNc9Kb6B8Tioh
        f88wGA8UmgKBCDUy06z1dijm5kOphY22NXkMzzAuFZUn8zTgr5pNUmsCD2UbzB3wcNS/u91sfV5WD
        SqWLoGPtwlWmj8lAlCAwDW6M33Qf45ojNBnUPnROikBFZ8UgnInIo3HPsBAfrDmMqJ79UygxQ7cty
        bPChMcf8nbRJPZciVNJGAP/pai5xHdiU5TNe8hrEseCWixcCcUNgqlPpa0AMJ629D4KPobrjal0Uv
        ABuQ3xP19bLHANzzIpjNsfgNy9Mj6OWU8Tf7KusMxNNWIQphz7PjlqkvYyj9by7gkJih4UuclDfcy
        SFjBEczg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7MHW-00AYbl-0q;
        Thu, 08 Jun 2023 20:30:54 +0000
Date:   Thu, 8 Jun 2023 13:30:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hch@infradead.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jikos@kernel.org, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZII6fho7ULpY+Eav@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <20230606171956.GG72267@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606171956.GG72267@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:19:56AM -0700, Darrick J. Wong wrote:
> Luis hasn't responded to my question, so I stopped.

Sorry for the delay, by all means alternatives are hugely
welcomed. I just worked on it as it was back logged work and
not a high priority thing for me, so I try to get to it when I
can. Having someone with more immediate needs give it a stab
is hugely appreciated!

  Luis
