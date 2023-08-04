Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0757709C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 22:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHDUfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHDUfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:35:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3A4C2F
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 13:35:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 374KYOoW025102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 16:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691181272; bh=i+Cv8ZO3I5bUEr/K4+xoZ/gjA4JFPErOdbDf0LaFzCo=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=LhpVy8vBk/XSt8GuwK8JeXWAhbhaGHwiCvogm7byiRopRon8u+Fy2XpuWbDJ/DJqp
         1MMHjMZrvP/bsYQt+4oPnfh3oX7+RXyu/JpuSynvYo8OM1HCFI//PZ6OtV7t48eW1k
         NczmO7BbNuqBpq+Z1Q/3jmfHsAXJRjU74h7ISZ3IYJA5kgGBxhqB59mAzguEkGCU4Q
         Bwd2anIeqw6Ugk0Z9GGvE76JN2snxvF4uJsmny2lVz8LKkRpZ1vWGxJrBJy7Lvy0+7
         VCsPzXGzk5tcsNFAq0U09qFE0XG9yw9L2KHuZ/yc1old2bUvgfhBiWegJLllkThH6J
         DmzoegwwJSRQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D311615C04F1; Fri,  4 Aug 2023 16:34:23 -0400 (EDT)
Date:   Fri, 4 Aug 2023 16:34:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more
 robust
Message-ID: <20230804203423.GC903325@mit.edu>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:24PM +0200, Christoph Hellwig wrote:
> Check for sb->s_type which is the right place to look at the file system
> type, not the holder, which is just an implementation detail in the VFS
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>
