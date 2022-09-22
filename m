Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7510B5E6711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiIVP3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiIVP3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5678CF8FB7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B78B8387B
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FEAC433C1;
        Thu, 22 Sep 2022 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860547;
        bh=UFOfoHizj2KwJ0ggp24W4hRWgBOvLtoMv50c3mzI3/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOfDMYLJHUVw6ND/Bg2yEEljxlToxAcrZT16GSuvBRK1KtzMCRjWbXbFvfvR4w5Lr
         +cb5o8LBFb5MEgzy4r2KG84ImY9Mzrx2HUbbazBin18p4+kHHukeYmiSULJCMMAlC/
         ZnVbIirSjh50sPqZkrKRqXTYRDWfeOMIDyapfngt5G9PJ4r1K0fO3l/HHfgftdUQra
         ZU9OMdV73kd2NoANxv08J26ovDcbMpDVGEbiMCS4LybnB5Lf4gp20zP+QQeoadNB6p
         G+CtaHBqBgzj4E4ds2wDE5/CXG1eSmc9/maZiBlNJVLIQlb6wlXM8rnLLqnRlu9+/G
         mBoFNGBWawcjw==
Date:   Thu, 22 Sep 2022 17:29:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 10/10] fuse: implement ->tmpfile()
Message-ID: <20220922152903.m57umxkr2hejd7lm@wittgenstein>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-11-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-11-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:42AM +0200, Miklos Szeredi wrote:
> This is basically equivalent to the FUSE_CREATE operation which creates and
> opens a regular file.
> 
> Add a new FUSE_TMPFILE operation, otherwise just reuse the protocol and the
> code for FUSE_CREATE.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Seems good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
