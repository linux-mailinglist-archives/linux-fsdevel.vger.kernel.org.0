Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593E5A4C10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH2MjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiH2Mio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:38:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CD8605D
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:22:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9554421ACA;
        Mon, 29 Aug 2022 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661775758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YExzfCoaQN/oTWD6ESVhdwgwQ+OKBaUq8QvyYtel9o=;
        b=v+9kyiQBvqC44Th6nDkLBXUQxFLzyo/0NenaPJqfulD4X8wEApWBZ1s1HrHZqzITr4LCL1
        zW3aAWXLuItrnilNAseH06h47FthpSnNMEKvZzkQyrdBlvE7SNgNhoWvaX3EVi4RMI3Mxj
        Udavy7/UD7b5d108qNXftfu+1odEK18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661775758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YExzfCoaQN/oTWD6ESVhdwgwQ+OKBaUq8QvyYtel9o=;
        b=DTpH5WsFvHgcJybuIFUtgPsWeQZHoY/25EHu1sODJJEa8m9Y99ELkP7rd4wyjsuhNa0R1M
        oFpZn61F4hLCEuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C22133A6;
        Mon, 29 Aug 2022 12:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LeTBD46vDGMdMwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 29 Aug 2022 12:22:38 +0000
Date:   Mon, 29 Aug 2022 14:24:36 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Automated-testing] [PATCH 2/6] API: tst_device: Track minimal
 size per filesystem
Message-ID: <YwywBFhVtfO6gc0u@yuki>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-3-pvorel@suse.cz>
 <YwybzIVhMaCqYR/S@yuki>
 <YwyjDLcGzhDiWXkD@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwyjDLcGzhDiWXkD@pevik>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> > I do not think that we should harcode this here. I would be for a more
> > dynamic approach, i.e. add a function into the tst_supported_fs_types.c
> > that loops over supported filesystems and chooses max over the minimal
> > values for all supported filesystems. That way if we run on embedded
> > targets the device size will be 16MB as long as btrfs-progs is not
> > installed. Also that way we can easily define minimal size for xfs 300MB
> > and things will work for embedded as long as xfs-progs are not
> > installed.
> Correct. So the value for .all_filesystems should be maximum of supported
> filesystems. The only think I don't like about it that it takes some time to
> check everything (mkfs.* available ... etc), but we can't avoid it.
> 
> Is it worth to cache this value (make it static in the function) so that it's not
> searched more than once?

Actually all we would need is a flag that would just return the pointer
to the fs_types array from the tst_get_supported_fs_types() on second
and subsequent calls.

-- 
Cyril Hrubis
chrubis@suse.cz
