Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5147543168
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiFHNdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiFHNc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:32:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943D104C81
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:32:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A98C121A37;
        Wed,  8 Jun 2022 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654695176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnLOhhDPu4tb7fF9sVfBNFpAzk9p0jbQIUSDv/qtZC4=;
        b=GbcfsLq9Dw55ThRSMsNeQrXOF4ngsoPQP2/QpzMbu48LrflWuU5hNfB8nKInunvzhr1430
        sPFR8CcLdnkg6ykf+XLh5sEPwkfena00dq8l3fZ7DuSWWgMHz9Xmyp70YSuFeQO4ZXRmSI
        OUEvRTISJ1fj+jEx3lsBKW7MsrevX44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654695176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnLOhhDPu4tb7fF9sVfBNFpAzk9p0jbQIUSDv/qtZC4=;
        b=WABdONHwiLhpjxTJcCzjc/cFPexXbEZGBDrVZIPQiF6yfen18AsoEECHCL1rzA7g5ybOfm
        bG1gfA0G43UOFQBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9DABE2C141;
        Wed,  8 Jun 2022 13:32:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 391E4A06E2; Wed,  8 Jun 2022 15:32:56 +0200 (CEST)
Date:   Wed, 8 Jun 2022 15:32:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gal Rosen <gal.rosen@cybereason.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Failed on reading from FANOTIFY file descriptor
Message-ID: <20220608133256.2d7tsy3wtipny64l@quack3.lan>
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
 <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
 <CAOQ4uxjH9o_XwowdyjyCYswpfvwRSq9wUAkYvg_XoKULvx23-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjH9o_XwowdyjyCYswpfvwRSq9wUAkYvg_XoKULvx23-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 15:01:17, Amir Goldstein wrote:
> On Wed, Jun 8, 2022 at 2:01 PM Gal Rosen <gal.rosen@cybereason.com> wrote:
> > Regarding the EPERM, how do we continue to investigate it ?
> 
> Besides adding prints to the kernel I don't know.
> Basically, there is a file that is being opened by some process
> that your listener process has no permissions to open, so
> check with the people responsible to the SELinux policy what that could be.

If it is SELinux denying the open, you should be able to set SELinux to
logging mode so that you can see opens that are getting denied and why (I
don't know SELinux so I cannot really give you details how to do it). But
it is not necessarily SELinux that's causing the EPERM errors. It may be
that you are watching e.g. some special filesystem like /proc/ and the open
gets denied there...

If you can reproduce the problem, you can enable some kernel tracing to get
more information about the situation. Sadly it is not easy to get to the
filename for which we are reporting the EPERM error so you'll need to use
something like Systemtap (or eBPF) to get the information (about arguments
and return value) from dentry_open() calls.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
