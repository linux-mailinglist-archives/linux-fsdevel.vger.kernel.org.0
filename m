Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4C752645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjGMPLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGMPLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:11:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69825C1;
        Thu, 13 Jul 2023 08:11:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2276322158;
        Thu, 13 Jul 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689261071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCLBmF2e2dRCNx7+d13fHc8+rkei0zsayK8x+eKdnGc=;
        b=qomcWisImhIgTGE3b4ZUEPF9NcyOW0hyDzZnyCPVzVgRuINKpG8MQbpCS13E9V1HBOrMO/
        iAyUdkn6A+IJpPb5QvbPi4sRRNNjhjdXjokIMH8S4MUYkByXeu7CRlgjWvkVWDawXd8vHp
        8AT5b9KhPS/AKO4mxgcaNhfFavUADcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689261071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCLBmF2e2dRCNx7+d13fHc8+rkei0zsayK8x+eKdnGc=;
        b=2D2YEL/BjKdkgcqnhmm74ZlNQAyBcVXYYRhOK4PSceT9B8FBt6yWbDy3bm5gYdZm5fpfJG
        MnQHKcIOISrEZ3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AC70133D6;
        Thu, 13 Jul 2023 15:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FtJUAg8UsGQOBwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 15:11:11 +0000
Date:   Thu, 13 Jul 2023 17:12:15 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ltp@lists.linux.it, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>, oe-lkp@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [LTP] [linus:master] [iomap]  219580eea1: ltp.writev07.fail
Message-ID: <ZLAUT_19ST-47Wed@yuki>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307132107.2ce4ea2f-oliver.sang@intel.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
The test description:

 Verify writev() behaviour with partially valid iovec list.
 Kernel <4.8 used to shorten write up to first bad invalid
 iovec. Starting with 4.8, a writev with short data (under
 page size) is likely to get shorten to 0 bytes and return
 EFAULT.

 This test doesn't make assumptions how much will write get
 shortened. It only tests that file content/offset after
 syscall corresponds to return value of writev().

 See: [RFC] writev() semantics with invalid iovec in the middle
      https://marc.info/?l=linux-kernel&m=147388891614289&w=2

-- 
Cyril Hrubis
chrubis@suse.cz
