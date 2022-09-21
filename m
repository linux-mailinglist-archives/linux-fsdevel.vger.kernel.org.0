Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F055BF973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIUIhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiIUIgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062D83067
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3E362904
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34ACC433C1;
        Wed, 21 Sep 2022 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663749395;
        bh=enQ85Q2Lwk7Bmci4Z46JTfjhEHHz8L+knwmKJOtmbJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aw4a7xDycbqxft7BnYYNEIQgWxmVr/gQVvUl5b5944NIvni64Bp2FtxT/sZ5w9gq3
         IDRrJVkCtBmCVc+tPeZu53ebOMt7qgF47H9AzBZQ3vo2mFMZrEe/dtTbf+y0UEFQNC
         bOJaeiJ6hFF2Lt15tuUmXhosnzzwZk9rgmZr0NZ4Hb2LmjUzPamUNl3urKkFQ9m4nK
         uwCmSAiDVXkPbFwz+PEx4PyNoeg17+gERuG0Dxt3svpl8JuPgTyMqf1LtTDTlbnnnI
         PaEKQchTWojWE84D739IYOfRNLQjN8Pm2XfjLzi83PyVVatO0wttr5ItUa5FzXOuuP
         4IdEYXK62CSAw==
Date:   Wed, 21 Sep 2022 10:36:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 6/9] vfs: make vfs_tmpfile() static
Message-ID: <20220921083630.klnxzxvzdvmotpct@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-7-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-7-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:29PM +0200, Miklos Szeredi wrote:
> No callers outside of fs/namei.c anymore.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
