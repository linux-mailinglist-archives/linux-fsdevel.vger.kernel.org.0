Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6A6C9D0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjC0IAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 04:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjC0IAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE20F4685
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 01:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827E160FE3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 08:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46478C433EF;
        Mon, 27 Mar 2023 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679904008;
        bh=uFY69oHQbQUzDGw86QdQ180TfEErZH0YMPUJ07jxJFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRcIc4ctCcAZ7ynVjGR+chP8P1YkCb5VfA6SuIq5+HhunxSx519jS2al14O2J4/Ta
         3hFzkahiLAVPV5wXJUruqnPVCKCevCR7gJ+ozxWlaZKeZnnThpTAQqWGLD6MxyGamG
         gH2bv119c1CuWGCTmW6a33JM7yqNZhHlLpgrHu/CquB36EFVUOT09bTcWcoEKi8x4e
         RJgM7kJVYEPgU7qUOjNd/QkszFicuc0PuE+oQJxCMJSSbErBoCoZLZpm3oAT+ZT4j0
         YejUnocp4mBoGEvnMeFY+epxupYGqQp7EYlGcnyOJe/HAWERG9QGYQ4nRXD+luT8sd
         w5x2REE0s5Nhg==
Date:   Mon, 27 Mar 2023 10:00:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     sforshee@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v2 1/1] selftests mount: Fix mount_setattr_test builds
 failed
Message-ID: <20230327080004.7iqrbp3ja2osrq5z@wittgenstein>
References: <ZByVac3GsD7RFuaj@do-x1extreme>
 <20230324021415.17416-1-tuananhlfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324021415.17416-1-tuananhlfc@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:14:15AM +0700, Anh Tuan Phan wrote:
> When compiling selftests with target mount_setattr I encountered some errors with the below messages:
> mount_setattr_test.c: In function ‘mount_setattr_thread’:
> mount_setattr_test.c:343:16: error: variable ‘attr’ has initializer but incomplete type
>   343 |         struct mount_attr attr = {
>       |                ^~~~~~~~~~
> 
> These errors might be because of linux/mount.h is not included. This patch resolves that issue.
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---

I think Seth already acked this. This can go via the selftest tree,
Acked-by: Christian Brauner <brauner@kernel.org>
