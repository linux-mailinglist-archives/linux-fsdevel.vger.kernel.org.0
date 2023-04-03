Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238346D4E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDCQiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjDCQiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:38:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC0211F;
        Mon,  3 Apr 2023 09:38:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AEB52005D;
        Mon,  3 Apr 2023 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680539883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEGVxRoTlvsbChMAl/BmJtvvAj64ROqXGRxjWLSXbMo=;
        b=b6JLhFkLfttRnnkrLFIWfKPpJeJ2lkyiUsV++0L8JhkDFiWWTNt7wy2SuYGcDK0Vb7MSmr
        Etm0AVkiSYdK3iPECgaKsSPqN8q1yr+cOci6MLt5vc54zeyanMExM2bNAdZwB0J5gBUhlt
        kYlgZ07f/DmRtB/aJQdahJAW700mpYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680539883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEGVxRoTlvsbChMAl/BmJtvvAj64ROqXGRxjWLSXbMo=;
        b=XWAS7uZ786xY5AKiIUQ1iFESMgSs0AgSiGn0tB6EKllxmBYa6lfqVAbDkCjna3MojdFMOb
        8iF6gkuth3gKmJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A3CC13416;
        Mon,  3 Apr 2023 16:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j9InDusAK2QQZAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Apr 2023 16:38:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9EFAFA0732; Mon,  3 Apr 2023 18:38:02 +0200 (CEST)
Date:   Mon, 3 Apr 2023 18:38:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <20230403163802.jvwnxg4wsa3n5fpg@quack3>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
 <20230403161043.tecfvgmhacs4j3qp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403161043.tecfvgmhacs4j3qp@quack3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 18:10:43, Jan Kara wrote:
> On Thu 23-03-23 10:32:59, Jiapeng Chong wrote:
> > Variable 'err' set but not used.
> > 
> > fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> I don't think the patch is quite correct (Christian, please drop it if I'm
> correct). See below:

Ah, sorry. I had too old kernel accidentally checked out. The patch is fine
with current upstream. Sorry for the noise!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
