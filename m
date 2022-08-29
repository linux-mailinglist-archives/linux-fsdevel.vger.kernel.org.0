Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44C5A4AD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiH2L7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiH2L7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:59:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FC85F83
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 04:43:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFE5321ABE;
        Mon, 29 Aug 2022 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661773344;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIOJ6VITqESi71ylt5rK0ydo0n8ut25kkfVKjXjiTa8=;
        b=jRQIIYfaIT5S/A3zz+/mJkm5SPLkyHWRFDwYug7nfyACosWJ5MVRaZz5OdLmxlJ5XMIktp
        wtntOc9rYEMzwJO+hu8ifDGMhb+2hQ+9SEGJJnM6XcPIpQYHCTlgzG0eLyJI4ELXH5w6Bw
        tacLDZzc94eEZQETFuAhVBa86G5GfVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661773344;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIOJ6VITqESi71ylt5rK0ydo0n8ut25kkfVKjXjiTa8=;
        b=NX1sPMKtyzJxysKGhaUJZLvh5M1zD+2i1v2Y/EVS87+SSwoUIkC5Jgy2NbrPaIkZ9CS2xE
        9uKADKCiZ8TIk9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C43D1352A;
        Mon, 29 Aug 2022 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rv7oHCCmDGO8IQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:42:24 +0000
Date:   Mon, 29 Aug 2022 13:42:22 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Automated-testing] [PATCH 4/6] tst_device: Use getopts
Message-ID: <YwymHvpxf/rP1kFT@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-5-pvorel@suse.cz>
 <YwydHBRWBX2NlqMR@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwydHBRWBX2NlqMR@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cyril,

> Hi!
> > size and filesystems are passed by -s and -f flags.
> > That will help to pass used filesystem.

> This part should be in the next commit description.

> > When it, add also -h.

> "When at it, ..."


> Otherwise it looks good.

Thanks for catching these!
I'll fix them in v2.

Kind regards,
Petr
