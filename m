Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9D59E649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiHWPnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbiHWPmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:42:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C7EE1C;
        Tue, 23 Aug 2022 04:39:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 324BC336BA;
        Tue, 23 Aug 2022 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661254700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5U0gw3AtIl2Nq1G66dQgq5N3st5lWOBhdWxLO2VlGE=;
        b=ammxSTYUkCQ6Lu+GqUnnZHT8EpBMtIsT8PA1UnmlPL8dUH9A4bdRtTR4IEpcF0e0rMCEJc
        Vhy/BEKQFv6oKQaF/R+zchvlg6RoLjwuFvj9yZd3h/HK2bz+4p+qfP7fnJBZVo6kilPSMF
        m0Ja3K2+SsAW+hPlqSuEjXjUFI6BOoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661254700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5U0gw3AtIl2Nq1G66dQgq5N3st5lWOBhdWxLO2VlGE=;
        b=K9Ngnq2pAX6810jWu8OsMysSuPXoUMzaNMB0Ba/tGCgdVPJMrbOTnkJBE2jpToacYEf8pd
        cHBWZKBczM/X5mDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C5F13AB7;
        Tue, 23 Aug 2022 11:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cKPANCi8BGP8LwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Aug 2022 11:38:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
In-reply-to: <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
References: <20220822133309.86005-1-jlayton@kernel.org>,
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>,
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>,
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>,
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>,
 <20220822233231.GJ3600936@dread.disaster.area>,
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
Date:   Tue, 23 Aug 2022 21:38:07 +1000
Message-id: <166125468756.23264.2859374883806269821@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Aug 2022, Jeff Layton wrote:
> So, we can refer to that and simply say:
> 
> "If the function updates the mtime or ctime on the inode, then the
> i_version should be incremented. If only the atime is being updated,
> then the i_version should not be incremented. The exception to this rule
> is explicit atime updates via utimes() or similar mechanism, which
> should result in the i_version being incremented."

Is that exception needed?  utimes() updates ctime.

https://man7.org/linux/man-pages/man2/utimes.2.html

doesn't say that, but

https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html

does, as does the code.

NeilBrown
