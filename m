Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241845A513A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiH2QO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiH2QOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:14:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AD97D7B
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 09:14:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA658229D7;
        Mon, 29 Aug 2022 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661789661;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJNi49m3aoK7ZxSdO38U6MBi7YL988pHZltt045fT0U=;
        b=coCBFDCP5RlN/CTGep9hrZtm74VtYyA/a3KIiI43Gy0/6d9T7v1mbadVBPNrWuqs6WMzZT
        WMHl2wt5vU0M4eusAQplgbp1ihKNXDkrfcPHgEV4t6G+wInmEyuVaRnKUgCog7/OYYoY0b
        YEU/5vTiOnG5bdaj3f3MC+izFct5Y5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661789661;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJNi49m3aoK7ZxSdO38U6MBi7YL988pHZltt045fT0U=;
        b=9pcWjNlgiuZyVZ3Xr2qZPl5lSK4yDmI34lPm90aNBNoJ9RvTBKiYAevnGaC3WVSdQAGslK
        Bwn0fft2Qy+SG6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DFCA1352A;
        Mon, 29 Aug 2022 16:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qmjjEt3lDGODGgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 16:14:21 +0000
Date:   Mon, 29 Aug 2022 18:14:19 +0200
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
Message-ID: <Ywzl266wQ89KonEW@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
 <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tim,

> Minor nit, but the subject line has nsfs when I think it means ntfs.
>  -- Tim
Thanks, will be fixed in v2.

How about XFS using 300 MB vs 16 MB but using different code paths?
How big deal it'd be if we require 300 MB in case testing on kernel with XFS
enabled and xfsprogs installed?

https://lore.kernel.org/ltp/YwyYUzvlxfIGpTwo@yuki/
https://lore.kernel.org/ltp/YwyljsgYIK3AvUr+@pevik/

Kind regards,
Petr
