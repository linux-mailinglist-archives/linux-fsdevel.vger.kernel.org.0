Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19DF52BDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiEROo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiEROo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 10:44:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D71D4A34;
        Wed, 18 May 2022 07:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 177EBB820EA;
        Wed, 18 May 2022 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A20C385A9;
        Wed, 18 May 2022 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652885094;
        bh=sLZDBfRImQRmLZ+nI1Q+0xE86Tid3u1WRmhso6KIs04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDVphIpl9/QBp0ieNsVrXN9pM0JBXP1+a6fSIa9IwYiK1Ue9nFlFhrp4aYR/MZGx5
         TN+XaMT+fkSOa7UEkWRsAZpnUVek0git3Bx9usHdDRfZ4+mi6vajkKc/MupbS0rGBX
         pnOvucmaRLfYukQuIxS6zIBbdjKisKhZx/g476y3sd8FnBajmZFkyu6X1W9vW+6lJh
         WB7M7M8woupFPRjtK8mOPQ5Jlq5a5WfmY+SyU4ewKJ5CYlcxU5VLYz1vCxk4rLEjV/
         R3eYhf8+QiewXAZQ9Biwc/GLQONfp05Sl1kDkkMcSjgae1EQZOq8IVxPWwmfiZ3SVH
         AHGzbZUe3x0HQ==
Date:   Wed, 18 May 2022 16:44:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] sparse: fix incorrect fmode_t casts
Message-ID: <20220518144449.2oa464wnx4p6ovom@wittgenstein>
References: <YoNDA0SOFjyoFlJS@infradead.org>
 <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 01:49:07PM +0300, Vasily Averin wrote:
> Fixes sparce warnings:
> fs/notify/fanotify/fanotify_user.c:267:63: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
> fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
> fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
> fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
