Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915806D86E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjDETak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjDETaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E85251
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712D863D59
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 19:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D3C433D2;
        Wed,  5 Apr 2023 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680723037;
        bh=FOb4mP5HMd4dql42lhDLMpQpdMg1Qi0NyF0Er/AxZ78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjaGVtf3sWjKCxzdqfkGcU/EKchcly7kFvVoQCO26NGs6ei2v4JxOXToTRfGZnb7V
         mTQMGEOJsPpkny06xEXQC+UR6FNaB86h6mPRMroE4DJN9kyaHV0adpDKaA1HUNuTT1
         9tGoz8AzhQOMwzFux4whPplTq06AQKoV72Yk21Mz3MZnPIeiG2o/Z8DKZZJvz+SDX0
         arySsCH0xOzopXtLgxOdovfuxTgQL43zHMt0/qukeqR3AHjZ85wYpF6aqwSETixemi
         R8uUmYafZAPz0HmM5asmX36ZdpYskaUXFasUAzx2aPYN2Q7Tt9wQQTeJegba5xzJzo
         3JddoZTLHKs5Q==
Date:   Wed, 5 Apr 2023 14:30:36 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pnode: pass mountpoint directly
Message-ID: <ZC3MXAqKMyh007rV@do-x1extreme>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
 <20230202-fs-move-mount-replace-v2-2-f53cd31d6392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v2-2-f53cd31d6392@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:13:07PM +0200, Christian Brauner wrote:
> Currently, we use a global variable to stash the destination
> mountpoint. All global variables are changed in propagate_one(). The
> mountpoint variable is one of the few which doesn't change after
> initialization. Instead, just pass the destination mountpoint directly
> making it easy to verify directly in propagate_mnt() that the
> destination mountpoint never changes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

This doesn't seem to have anything to do with the rest of the series,
but it does make the code a little easier to follow.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
