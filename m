Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B37764F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHIQ0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHIQ0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:26:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2410F3;
        Wed,  9 Aug 2023 09:26:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EBE56732D; Wed,  9 Aug 2023 18:26:30 +0200 (CEST)
Date:   Wed, 9 Aug 2023 18:26:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/13] xfs: free the mount in ->kill_sb
Message-ID: <20230809162629.GA2582@lst.de>
References: <20230808161600.1099516-1-hch@lst.de> <20230808161600.1099516-4-hch@lst.de> <20230809-besang-chaoten-642fff8a141a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-besang-chaoten-642fff8a141a@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:38:13AM +0200, Christian Brauner wrote:
> For filesystems on the new mount api it's always nice if the rules
> can simply be made:
> 
> * prior to sget_fc() succeeding fc->s_fs_info and freed in fs_context_operations->free()
> * after    sget_fc() succeeding fc->s_fs_info transfered to sb->s_fs_info and freed in fs_type->kill_sb()

Yes.  I've been wanting to write this down somewhere, but I can't really
think of a good place.
