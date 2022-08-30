Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E45A5D5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 09:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiH3HvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 03:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiH3Hu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:50:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9007A00CA;
        Tue, 30 Aug 2022 00:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DB2AB81629;
        Tue, 30 Aug 2022 07:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70961C433D7;
        Tue, 30 Aug 2022 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845855;
        bh=V9S3aBs4N0TJEeCInTFam7IGstEqe66vGG4c6Q5jZdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NubS6Lw7jV0SrKzMDts1xRLPUlPLPQSJonlyl579ZTXzN9Dl4b76xlLOWgkZ2IyVs
         bFnfTlyzs5LFFzcvko9BT4KGcApFqg/FtQsF41GCqGYJ2wK93jNxrWlRrwF9vxy4EM
         rkpmwtmzYTx5WFwzZHl7z7XHpg1TJpr9crdxHZ9MTWRRtp3HiI6PdYpZ7vl1mEG9a+
         pLaZuVGEjQWbJz0xpAS4wqG/I04dAVZWKOcQrnOVLPl9FkYzq9jfBQ3CRxrNgVORGa
         78KejWa6N5LJ21+MhNUhur2VfQVM1KvBCK/SGDQJPACjIui0lEmrVN0ORPBlrPehUh
         BT0RnvhIhKaEg==
Date:   Tue, 30 Aug 2022 09:50:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] Documentation: filesystems: correct possessive "its"
Message-ID: <20220830075050.eizxl7emdrmyij6w@wittgenstein>
References: <20220829235429.17902-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829235429.17902-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:54:29PM -0700, Randy Dunlap wrote:
> Change occurrences of "it's" that are possessive to "its"
> so that they don't read as "it is".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-xfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> ---

Thank you!
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
