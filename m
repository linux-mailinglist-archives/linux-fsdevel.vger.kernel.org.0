Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545545BF961
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIUIf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIUIfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BC5A2F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDFD62F7A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB8C433C1;
        Wed, 21 Sep 2022 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663749353;
        bh=LN1AQTBcjqspbirPN0uMYs897wGVdPhRavtCyIRGSSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umakqSBqQIYdbkkM7rQY2Ohec3cyQvNPrmu+/D25XJj8kAkDGqqrEUU+fmWIZXtlg
         LCwDMamDxic+r1XUQt4MQUlB+7ir2okSQXlHSCYHKYE1JLp18y4T24AfES28JFgAvI
         bULjDx3R8uBjIjzt894td3JTCbO/JKyDJ1k8OQnNXzf7c5eR0Ggx54ZDc+3YV1z9VU
         XbO8FgUV2pVob+06jg7bNTq4fSvHMoWWA+Iij5V3cOKBq4HK6ouJtG/L/OGGMwxEeK
         5UY60KHOCCjoHxJbd9TfPEw5lP1Ptt+tGexoHjrhA7etRogD70Dy4I/vLQd7+ATo0g
         FS+o67Bb7jOnQ==
Date:   Wed, 21 Sep 2022 10:35:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 5/9] ovl: use tmpfile_open() helper
Message-ID: <20220921083548.ztd6rkctzcvhqhyt@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-6-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-6-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:28PM +0200, Miklos Szeredi wrote:
> If tmpfile is used for copy up, then use this helper to create the tmpfile
> and open it at the same time.  This will later allow filesystems such as
> fuse to do this operation atomically.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
