Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0094FF0CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiDMHwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiDMHwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5527B01;
        Wed, 13 Apr 2022 00:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E62D6151A;
        Wed, 13 Apr 2022 07:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCC5C385A3;
        Wed, 13 Apr 2022 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649836229;
        bh=8PuRWPM3k6EFqa/VNwnlJZbzhDY/SqmuN6o4S7IdG8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkHFmQIClLLm9iAi7UZibUT+g60m10zQWx39cSeQg8x5G4o2OYCBeo+4u2uiKpJCC
         PmIi2RXPc364a+XX8BkPwizC08r+dnnWXfqPxGLZzhFBjyPmkzDNkevxJ0WD4GxtAe
         awUzhi0z9NqcGNXr4hiu92rjUQRe2eQ8uqPmO+vscTcgJjRRsHmOZ7lOxibn4O3VjG
         2cZbBWhr2ECg+mJP4YeW9e6++SHZ1BzltfxUasF+k9hrMj4LX/ZoKXXsV6P1f9MngK
         GkOmJijRuyqU2cgMtlCG5WcVnNIC2ujJKixQjE79ha4ZkQWZEjiRjOH8UI4jbMxWMy
         ggVPQaUTVBTGw==
Date:   Wed, 13 Apr 2022 09:50:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220413075025.fm6ehpl44metfiz5@wittgenstein>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:33:42PM +0800, Yang Xu wrote:
> If we run case on old kernel that doesn't support mount_setattr and
> then fail on our own function before call is_setgid/is_setuid function
> to reset errno, run_test will print "Function not implement" error.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
