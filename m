Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BF769F12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGaROm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjGaROV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:14:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D53582;
        Mon, 31 Jul 2023 10:11:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 701FC22066;
        Mon, 31 Jul 2023 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690823492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp+ckBJwyAyY4Fsa3aNTz7y5pST0vHXGNpS2gQCzvK0=;
        b=TBH8FHQ9+cQhCaTybTDlxJ0wL8GYcJD4e1npIBuajVrwoDgmcMrdNfTc7solttzgrt+Q44
        VEYeJnqZkQg2n8iul6L9e0Q5fJnhd7szaASqWhkqNQYEBaKt+qIR5cL3wAa5RzjChfXCW8
        FlyudrvM+7RUZa6WTY996MavRdYlDBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690823492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp+ckBJwyAyY4Fsa3aNTz7y5pST0vHXGNpS2gQCzvK0=;
        b=5wTDfvHo3p1nob4EnKoRn4bnZwvAKMwR7OqRDGtsgc5k2XFTD2CxgUFClRiAfVfoNXlrON
        wNlYUWhB78D50ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F926133F7;
        Mon, 31 Jul 2023 17:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hl5NF0Trx2QKKAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 17:11:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E7B8CA075D; Mon, 31 Jul 2023 19:11:31 +0200 (CEST)
Date:   Mon, 31 Jul 2023 19:11:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Piotr Siminski <piotr.siminski@globallogic.com>,
        Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change reiserfs status to obsolete
Message-ID: <20230731171131.qpaoz7i3cto5wxyv@quack3>
References: <20230720115445.15583-1-piotr.siminski@globallogic.com>
 <CAKXUXMzL4i0jT0xPFsV4ZG6L82yDCYLtKoUL7t=21ZDZ4OMY7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMzL4i0jT0xPFsV4ZG6L82yDCYLtKoUL7t=21ZDZ4OMY7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-07-23 13:57:18, Lukas Bulwahn wrote:
> Piotr, thanks for the clean up in the MAINTAINERS file.
> 
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Jan, could you pick this patch?

Yes, picked up now. Thanks!

								Honza

> 
> Lukas
> 
> 
> On Thu, Jul 20, 2023 at 1:54 PM Piotr Siminski
> <piotr.siminski@globallogic.com> wrote:
> >
> > Reiserfs file system is no longer supported and is going to be removed
> > in 2025 as stated in commit eb103a51640e ("reiserfs: Deprecate reiserfs").
> >
> > Signed-off-by: Piotr Siminski <piotr.siminski@globallogic.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a5c16bb92fe2..c340c6fc7923 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18064,7 +18064,7 @@ F:      include/linux/regmap.h
> >
> >  REISERFS FILE SYSTEM
> >  L:     reiserfs-devel@vger.kernel.org
> > -S:     Supported
> > +S:     Obsolete
> >  F:     fs/reiserfs/
> >
> >  REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
> > --
> > 2.34.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
