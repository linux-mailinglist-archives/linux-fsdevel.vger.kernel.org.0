Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CD507098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbiDSOfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353444AbiDSOfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:35:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B381DA7C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 07:33:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FAC92129B;
        Tue, 19 Apr 2022 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650378781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95gmZ+IeFKkHL6H6bLyyQ0iXUlQOXJcr5vuMwdX6V/k=;
        b=FsrRwiNc+k5cWAfyYoEdMauTcmBwqj9SoK+AH/ePfZIcHJH+O6f82WzCaiiTlxrLikQLSS
        1dtENYsV9WraDAEpKtBxSnJejq3r+IieWvnsCcaV1kXa7h0akG90i2EnYTszGtyH5Ir2i2
        scCv1B/I9QAQGZR6uteQdJc3jCzTHGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650378781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95gmZ+IeFKkHL6H6bLyyQ0iXUlQOXJcr5vuMwdX6V/k=;
        b=XOHNYfqSyTmMiJHoAMXdkZ5XzjE3fXroSt0pzgO23+nfMUFgmDsXhwLXJWKT78kryTKoAC
        sJ/S6uYd2gofPADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59296132E7;
        Tue, 19 Apr 2022 14:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uy5HFB3IXmI3IwAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 19 Apr 2022 14:33:01 +0000
Date:   Tue, 19 Apr 2022 16:32:55 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error
 paths
Message-ID: <20220419163255.03e210eb@suse.de>
In-Reply-To: <20220404181318.21c0740a@suse.de>
References: <20220328145746.8146-1-ddiss@suse.de>
        <20220404181318.21c0740a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping...

On Mon, 4 Apr 2022 18:13:18 +0200, David Disseldorp wrote:

> Hi David,
> 
> Any feedback on this? It's a pretty obvious fix IMO.
> 
> On Mon, 28 Mar 2022 16:57:46 +0200, David Disseldorp wrote:
> 
> > From code inspection, the watch_queue_set_size() allocation error paths
> > return the ret value set via the prior pipe_resize_ring() call, which
> > will always be zero.
> > 
> > Fixes: c73be61cede58 ("pipe: Add general notification queue support")
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  kernel/watch_queue.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> > index 3990e4df3d7b0..a128dedec9db2 100644
> > --- a/kernel/watch_queue.c
> > +++ b/kernel/watch_queue.c
> > @@ -248,6 +248,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
> >  	if (ret < 0)
> >  		goto error;
> >  
> > +	ret = -ENOMEM;
> >  	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
> >  	if (!pages)
> >  		goto error;  
> 

