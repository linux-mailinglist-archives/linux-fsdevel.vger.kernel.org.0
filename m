Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B336A93F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCCJZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 04:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCCJZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:25:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AEF12F2E;
        Fri,  3 Mar 2023 01:24:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D1DE222F6;
        Fri,  3 Mar 2023 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677835498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eY1FPIDMWZ9RZfKpAogp/OZie35cGqB2tJa0I5ybEhc=;
        b=HTkXY3iaNdrTmaBXDmq319l0iAJ+bPEikjkX/I1jZBaszuSKdtFEYZ0E2BOpIUecZCEV5h
        BaPYMaKv49Fk5kVKZztMJIWCZnxg9EeeGgvrP1XgImTRo283NjVxR3WVKwcjyw5PVm861K
        dEPjtNsK+WLo65b5RE1LzmraNWiPvyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677835498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eY1FPIDMWZ9RZfKpAogp/OZie35cGqB2tJa0I5ybEhc=;
        b=4lfK/Fq4fml8W0N8rXTktEJ+074gXAQkHh1YWc03XMqWjLA4ToMPi1raFaG12kDPoOihzv
        5eC+GQIiWVk5GdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 590021329E;
        Fri,  3 Mar 2023 09:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tyG0Feq8AWQXagAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 03 Mar 2023 09:24:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 917E2A06E5; Fri,  3 Mar 2023 10:24:57 +0100 (CET)
Date:   Fri, 3 Mar 2023 10:24:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230303092457.knxeiofnv6vxbazw@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <13214812.uLZWGnKmhe@suse>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
 <Y/9duET0Mt5hPu2L@ZenIV>
 <20230302095931.jwyrlgtxcke7iwuu@quack3>
 <ZAD4bNDEIZf/VAnh@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAD4bNDEIZf/VAnh@ZenIV>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-03-23 19:26:36, Al Viro wrote:
> On Thu, Mar 02, 2023 at 10:59:31AM +0100, Jan Kara wrote:
> > OK, I think your changes to ext2_rename() in PATCH 1 leak a reference and
> > mapping of old_page
> 
> In which case?  ext2_delete_entry() failing?
> 
> -       ext2_delete_entry(old_de, old_page, old_page_addr);
> +       err = ext2_delete_entry(old_de, old_page, old_page_addr);
> +       if (err)
> +               goto out_dir;
> 
> and on out_dir: we have
> out_dir:
>         if (dir_de)
>                 ext2_put_page(dir_page, dir_page_addr);
> out_old:
>         ext2_put_page(old_page, old_page_addr);
> out:
>         return err;
> 
> How is the old_page leaked here?

Ah, sorry, I got confused by the diff. Now that I'm looking into the full
source, it's all fine. Sorry for the noise.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
