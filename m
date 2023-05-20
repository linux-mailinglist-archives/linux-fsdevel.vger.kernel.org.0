Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688F70AAED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjETUbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjETUbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 16:31:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49959FA
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 13:31:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34KKTnXh032322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 16:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684614596; bh=1h/e+2hm6DeCsGYVAMP6/xEixaSRaLI3wM1T7nyiDSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=c4aXHWtesHJvc1Y/IoNuJgl2d6nRMfZyTKgMWeVzXeks/rA3eV6DJXQjHa5lVtyO3
         7NyDuu4d0P2HhEigP7/aBLpCV7ww9BIBMpuLbsV9If0AbdFLokfjtphJykMOZa4/8B
         tatHhK7B69KeHjieDBBQa7MvBjFQK3Tphvv0bojDwxIKxjALWGGJWF7CgKRyVWH+dT
         cEH3LHv0qCm81FhLRqpbysBHNBcU9KF1W6bDqUDIQ9y+evDPvPZzz8WRRkjEWRBPgG
         HvcnsbWGM+qbr/UwnmaO5am8I6ZM96YbAncrWPxbJOMdpBXxFCKhqOmlDg6TDeZYIq
         yamHcc76/mvjA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C0B9915C02EE; Sat, 20 May 2023 16:29:49 -0400 (EDT)
Date:   Sat, 20 May 2023 16:29:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v4 8/9] ext4: convert to multigrain timestamps
Message-ID: <20230520202949.GA203758@mit.edu>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-9-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518114742.128950-9-jlayton@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Theodore Ts'o <tytso@mit.edu>
