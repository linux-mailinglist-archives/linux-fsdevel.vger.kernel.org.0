Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A77460AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGCQXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCQXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:23:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D575E42
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 09:23:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24E7E1FF43;
        Mon,  3 Jul 2023 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688401402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICX4NFV0fZZgU9rMjpu9uYjA33TUw0217SIG9/HAQj4=;
        b=eq4HhQno/4+PVK6Vb14DE0blArTx6woyf2dQxqPMYTURgYc9RVW5s1SSKoexnSUgRXPjBb
        ikhFdPviyRHqV3zjj5/HCjUFVI/heHpJujo/zGZc3f9OWlL/wBQy1HrNcXNCrMeVbSNST8
        VDr+MIZ42u4FfdjOw0Zm4Gdaxtc5ahA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688401402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICX4NFV0fZZgU9rMjpu9uYjA33TUw0217SIG9/HAQj4=;
        b=emr92NkwDHVCWYzgCeupyPqZypjcTowptgQOrbNingsJcZu2l7bTah245oiPQcDF9jON8j
        VhQ2NvDRMB58EcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11B8313276;
        Mon,  3 Jul 2023 16:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZHpHBPr1omTNfAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Jul 2023 16:23:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 78AC1A0722; Mon,  3 Jul 2023 18:23:21 +0200 (CEST)
Date:   Mon, 3 Jul 2023 18:23:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/2] fs: rename follow-up fixes
Message-ID: <20230703162321.qqte5msavuijnu4l@quack3>
References: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian!

On Mon 03-07-23 16:49:10, Christian Brauner wrote:
> Two minor fixes for the rename work for this cycle. First one is based
> on a static analysis report from earlier today. The second one is based
> on manual review.

Thanks! In fact I've sent you a very same patch as patch 1 just a while ago
[1] and your patch 2 already back in June [2]. But feel free to use your
fixups, they look good to me so also feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

[1] https://lore.kernel.org/all/20230703144306.32639-1-jack@suse.cz
[2] https://lore.kernel.org/all/20230606095625.zowqbpfi7hktfbwh@quack3

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
