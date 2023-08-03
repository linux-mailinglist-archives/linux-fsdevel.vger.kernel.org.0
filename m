Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2F76E53B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 12:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjHCKIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjHCKIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:08:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC5E273B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 03:08:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C68591F855;
        Thu,  3 Aug 2023 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691057289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZv1CFhlVkDjcisS6Z25jCpvGP8j/a0zKj62yVq7I1U=;
        b=Ex6dchSJ+R6aZLcJSW77imfqDHvNZhFN+EM9xT4Hz3M/AqPwsnV9Fkvs6O25oUh5aOcZEN
        eF/p4IjZvq1V4L756vu2pIT8ic8JXsk9MqZy/Ur9oZHhaO2Ra4qo4vBMb9f5BydDToRGrL
        /Eg0KbCZ4DWe1ZJqHrWxja03yifkd6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691057289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZv1CFhlVkDjcisS6Z25jCpvGP8j/a0zKj62yVq7I1U=;
        b=D4rW+2QUA2hiKmA8hxdNbljb2s7J8NCuXA0nvDz1jCoalCDz6xVIWYpKB/pwVVD8f7kflp
        htAQ786vXX61LJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA3071333C;
        Thu,  3 Aug 2023 10:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nXFjLYl8y2SRCQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 10:08:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57B10A076B; Thu,  3 Aug 2023 12:08:09 +0200 (CEST)
Date:   Thu, 3 Aug 2023 12:08:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: mark dquot_load_quota_sb static
Message-ID: <20230803100809.nonw5brvmmsjttd5@quack3>
References: <20230802115439.2145212-1-hch@lst.de>
 <20230802172301.bnrk4up3457bdqdi@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802172301.bnrk4up3457bdqdi@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 19:23:01, Jan Kara wrote:
> On Wed 02-08-23 13:54:38, Christoph Hellwig wrote:
> > dquot_load_quota_sb is only used in dquot.c, so mark it static.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for the cleanups! I've merged both into my tree.

Actually, the new tmpfs quota support uses dquot_load_quota_sb() call as
linux-next testing revealed so I've removed the first patch from my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
