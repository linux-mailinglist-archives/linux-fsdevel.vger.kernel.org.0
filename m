Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC77361E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjFTDCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 23:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjFTDCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:02:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19660173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 20:01:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35K30bDT005043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 23:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687230043; bh=3n8GAvW8QrSdojYTtSqja8VtHL/WSJb5DJjbA1RhY/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aUyd5I4x+bUQbJVVDNU1LP7CcS8iqNF2nVC4QkPqnPVd93PxKQYTmFUwe120hvjHD
         LB6h2MDwE6KWqQS/tavsoozxBdF8t89kTVyqKzLZ0KJ/kqat81JoV6Y1o6VTQzb/FS
         YJXhYJkq5smhu/5yG/JJ4PeZ0JGmO7k5uDa6cy5qIEg4W8UqrEmsLlJPkKP0dgCagA
         wHaY9uUBazQtotST8InhIsVYklyPBIb8xy7TIBYcp69ooaFdxTYfNZ2lj0z0bv/I1r
         xXTMQf/RSUjW0XIxhx6COquVPobNMxJpZ4pACwe8uQyfu9P2W+Q1CpcRGw0kUCP2FT
         +SSM25sLqEa4A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2173B15C0266; Mon, 19 Jun 2023 23:00:37 -0400 (EDT)
Date:   Mon, 19 Jun 2023 23:00:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        adilger.kernel@dilger.ca, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, beanhuo@micron.com
Subject: Re: [PATCH v2 2/5] ext4: No need to check return value of
 block_commit_write()
Message-ID: <20230620030037.GF286961@mit.edu>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
 <20230619211827.707054-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619211827.707054-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:18:24PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Remove unnecessary check on the return value of block_commit_write(),
> because it always returns 0.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Theodore Ts'o <tytso@mit.edu>
