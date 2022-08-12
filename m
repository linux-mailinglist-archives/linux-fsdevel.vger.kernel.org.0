Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190CB591123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiHLNEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiHLNEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D424BC2;
        Fri, 12 Aug 2022 06:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D7C617B9;
        Fri, 12 Aug 2022 13:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC6C433C1;
        Fri, 12 Aug 2022 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660309453;
        bh=SEokYlJ0aFgXVwHHXHtcZoOqA2yfO9cP5I2rK8lihmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=da+xV4fBFPIoFp/XvrgmacF7a7DGItXp57bg0w56Jv6FzlsbJbiP1focU+c7MZcBh
         YPsx2ACaGPGV6N6o3nCR8UdDkzW7jx4m85nyCKC27oy58hHu6IC45WU6YuX9pk587i
         4cn1MnZB0gBJX0SKl4PEYCn2WcvWU8rk/Av982urHbm6c767KQHjIg18R2AjE00fZX
         wjvx4Bjv5aT1IHJHcGI0arS/TG1Ye16Jzg8I+femWst/W90+aOrkOCph7hHYYGzj/A
         jbeJ9qxsd25ObDsquXtrRL9aA3bAprWiCw7v47VTtuHMZJ89+YPNjWJRVS0YJ2QswY
         Q10wTSNWdhUcw==
Date:   Fri, 12 Aug 2022 15:04:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH v3 1/3] ext4: don't increase iversion counter for
 ea_inodes
Message-ID: <20220812130408.wb44zntp3jx7zpve@wittgenstein>
References: <20220812123727.46397-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-1-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:37:25PM +0200, Lukas Czerner wrote:
> ea_inodes are using i_version for storing part of the reference count so
> we really need to leave it alone.
> 
> The problem can be reproduced by xfstest ext4/026 when iversion is
> enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> inodes in ext4_mark_iloc_dirty().
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
