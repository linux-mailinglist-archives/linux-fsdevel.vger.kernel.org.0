Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8575A521B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH2Qtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2Qti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:49:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290AD82D1D
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 09:49:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5DEDE22CDE;
        Mon, 29 Aug 2022 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661791775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYwO8SwjpbMVZ9mwLjTHeGuAcz9+TU4Tt2mxEUbJSbY=;
        b=RHmD+dEmWJK85SgBwo1amJ5McXR4j33kcRD0V3LTVdM4dNI02wvOESZkLSpyCgkBQLJMnJ
        zHVoMsIrJiK7OzYBdIvNYhiiprVixI7ya/YTKVuNoyGzQXjw57T21XP5XjpRP73D8QIhUx
        YsbUEPZ2wpX0NXKlnFwVHL7nqhdp/Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661791775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYwO8SwjpbMVZ9mwLjTHeGuAcz9+TU4Tt2mxEUbJSbY=;
        b=3EvCTpuWbFUpZKpbM3+6zI69wFU1VMXoqdV89PkWZg/l9/AokVVv5Gv9asOGDQt5EmfBU4
        omVw9mSawnTOPHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D914133A6;
        Mon, 29 Aug 2022 16:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c5LQAR/uDGNuKQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 16:49:35 +0000
Date:   Mon, 29 Aug 2022 18:49:33 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        "automated-testing@lists.yoctoproject.org" 
        <automated-testing@lists.yoctoproject.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/6] tst_fs_type: Add nsfs, vfat, squashfs to
 tst_fs_type_name()
Message-ID: <YwzuHaRJC+gUPd63@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
 <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
 <Ywzl266wQ89KonEW@pevik>
 <BYAPR13MB250348CBA4E0B0333C5CF54AFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB250348CBA4E0B0333C5CF54AFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>
> > Hi Tim,

> > > Minor nit, but the subject line has nsfs when I think it means ntfs.
> > >  -- Tim
> > Thanks, will be fixed in v2.

> > How about XFS using 300 MB vs 16 MB but using different code paths?
> > How big deal it'd be if we require 300 MB in case testing on kernel with XFS
> > enabled and xfsprogs installed?

> > https://lore.kernel.org/ltp/YwyYUzvlxfIGpTwo@yuki/
> > https://lore.kernel.org/ltp/YwyljsgYIK3AvUr+@pevik/

> I'm not personally aware of any uses of XFS in embedded projects, let alone
> ones with a filesystem size of less than 300 MB.  So I think it would be OK.
> Such a test might hit some lightly used codepaths, so it might have more likelihood
> to reveal a bug in XFS.  But if literally no one is using XFS in this configuration,
> I'm not sure how valuable the testing would be.

> That said, my knowledge of the embedded ecosystem is not comprehensive.
> I just posted a question about this on the celinux-dev and Linux-embedded
> mailing lists.  I let you know if I hear of anyone using an XFS filesystem less
> than 300 MB in size in their embedded Linux project or device.
>  -- Tim

Thanks a lot, Tim!

Kind regards,
Petr
