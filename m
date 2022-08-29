Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E685A4760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiH2Klh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 06:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH2Klg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:41:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430C5E543
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 03:41:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA1D1F461;
        Mon, 29 Aug 2022 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661769693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FUtt9ZHJcfvLL2U8OugtDLTRa+8tTNiw/VmEggc0fE=;
        b=FZpvGRjejLS3xlzLsfI5XEngKQjShFIkWWfrizppK+1nc260IR7GgTKNwA2j+mgiNxJnkk
        OVujeXAXlFvlgP+tgsptZABMOT4SnNS7SZpotgEnxU/v+giMJoV6XiYcjHkO/bZBkwrPXn
        B5Y5k6dIMsv0PzaRXuaKDQ6g5HD8mVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661769693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FUtt9ZHJcfvLL2U8OugtDLTRa+8tTNiw/VmEggc0fE=;
        b=EYVizWn+4kwcn9Y+oL1RtI5SHKoDukIf6QsEuDbtfhuSF8K7gaH5aG351+xokpIiSA8Caq
        dGFVrA0p7nikuzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6795A133A6;
        Mon, 29 Aug 2022 10:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q8IAFt2XDGNRSgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 29 Aug 2022 10:41:33 +0000
Date:   Mon, 29 Aug 2022 12:43:31 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Automated-testing] [PATCH 0/6] Track minimal size per filesystem
Message-ID: <YwyYUzvlxfIGpTwo@yuki>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> This patchset require to be on the top of:
> 
> [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
> https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

I'm not that sure if we want to run tests for xfs filesystem that is
smaller than minimal size used in production. I bet that we will cover
different codepaths that eventually end up being used in production
that way.

-- 
Cyril Hrubis
chrubis@suse.cz
