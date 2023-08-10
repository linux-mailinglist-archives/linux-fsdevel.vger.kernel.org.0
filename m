Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396B777794F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHJNNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJNNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307310DE;
        Thu, 10 Aug 2023 06:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4905264FE5;
        Thu, 10 Aug 2023 13:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46813C433C8;
        Thu, 10 Aug 2023 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691673198;
        bh=UQ8KLDmLKq3JPqkamfwQYRJyrWS7X65b14wSBXChIzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOIJIlGk1TMaRRcjQ9i19f1iyKmF/73h6GMpcsTdddrjZezBu/JmMYTy3Bt3xCjeV
         azEho5WMUGiNWRhEykARBWqih3mQTY905jGEVpwei3TccEqIftPvK5BjPVR7abMcF8
         e85rbIc04/2VZwP7l2JoB4DEcmMLePrFtZVgoc+HNG8rKg6pCzzkp9iKyRFHmZTGIl
         fJkWaYrIarqa5/xhYs9rg+jPCj559NRu4YiqHvJoiPnaohmSZxUpRPKmZ0FYyBTykh
         4vDr7pdRkIWUL7iERUJo2WQjC4vum0SUUA4qvFdpqn2W/ZLUEa98/r7ar9HRh3CQXT
         PmTEYmpN18pjQ==
Date:   Thu, 10 Aug 2023 15:13:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fat: revise the FAT patches for mgtime series
Message-ID: <20230810-zieht-vorerst-e29e0ada149c@brauner>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:12:03AM -0400, Jeff Layton wrote:
> This is a respin of just the FAT patches for the multigrain ctime
> series. It's based on top of Christian's vfs.ctime branch, with this
> patch reverted:
> 
>     89b39bea91c4 fat: make fat_update_time get its own timestamp
> 
> Christian, let me know if you'd rather I resend the whole series.

Nono, that's fine as is. Thanks for taking care of all the fixups!
