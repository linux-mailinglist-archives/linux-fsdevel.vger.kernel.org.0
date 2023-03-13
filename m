Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38926B75D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 12:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCMLUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCMLUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892946082;
        Mon, 13 Mar 2023 04:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 938EF60C78;
        Mon, 13 Mar 2023 11:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F0BC433D2;
        Mon, 13 Mar 2023 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706413;
        bh=ISe5UVZfG0kk7GI8PLSL2i+qiFvy8AcPIus/O+t/3OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTozJycmwfU0NrgRVFw0XTG2UAdZmPJAlAeLL4lMCMnKEIWRByxCrUzxKKMMLc2Yl
         lcG5YOzkBKX0lOxW1Egdlnw3euXEyV2cSZBteox5J9JGwd6lCITjRt0UhXYUc4wDLP
         otkj8R+uA7zKywNGTTsu5jnAG3PEwwHFoO1wWIjKTiBc1+BBSXm61mUwXczCZascUJ
         oKTs17bd9xLqqFldyOYVsvg9uvfVpktxsEAyqN2IyTddIE0hn1/Ya1qIKQANSAeVff
         V4DCQ8CEiuihLvqnYk4W87POoap/ADfBT4zhyz4Jgkb2rs1yqzr6jcwEHXE+vu98BL
         0dg/iHwI4uIcg==
Date:   Mon, 13 Mar 2023 12:20:06 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     pvorel@suse.cz, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, keescook@chromium.org, Jason@zx2c4.com,
        ebiederm@xmission.com, yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utsname: simplify one-level sysctl registration for
 uts_kern_table
Message-ID: <20230313112006.m5vmtzbepo6lcoj5@wittgenstein>
References: <20230310231656.3955051-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310231656.3955051-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:16:56PM -0800, Luis Chamberlain wrote:
> There is no need to declare an extra tables to just create directory,
> this can be easily be done with a prefix path with register_sysctl().
> 
> Simplify this registration.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
