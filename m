Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5DD7AA008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjIUU3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIUU3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:29:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8880F94;
        Thu, 21 Sep 2023 10:36:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A17C2BCFE;
        Thu, 21 Sep 2023 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287623;
        bh=q2nhZdZLMhYsgMyxe8nWUqtPJJSWYahI8Lr6GNIBT08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z87N/f3S15x2plk1l4lRfyhavKz2IPlPrEe0n53pLdrguqLTt3q2ferBn0MvbaZyL
         XgKc5FJxx+MHtO94ZxeAA9Y08GTz79Yj6Pmv5JE9LTlvanUgBGJ60UUxWqwET016kT
         cxXCVfpydzG+QAWdmq6za+YvIY3m7wH+hJDxkaZL38SyoDzAXntAz0DaCciH7hsPB7
         iCWLxfqcDRVYtbDhpFg5u9KjLgchQbB7Vh7RiNt7153NUGKo6c9lIIjei3XhHnC7IX
         p6cgV1bDik2OqtQ+JBf3OJxfIMPvtXVEfvqpL7Gkv7s427bp8RAEP5BGyp9GfiBrra
         tkdAWS7vhQyyA==
Date:   Thu, 21 Sep 2023 11:13:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Message-ID: <20230921-altpapier-knien-1dd29cd78a2f@brauner>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:03:26PM +0800, Ian Kent wrote:
> There was a patch from David Howells to convert autofs to use the mount
> api but it was never merged.
> 
> I have taken David's patch and refactored it to make the change easier
> to review in the hope of having it merged.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
> 
> Ian Kent (8):
>       autofs: refactor autofs_prepare_pipe()
>       autofs: add autofs_parse_fd()
>       autofs - refactor super block info init
>       autofs: reformat 0pt enum declaration
>       autofs: refactor parse_options()
>       autofs: validate protocol version
>       autofs: convert autofs to use the new mount api
>       autofs: fix protocol sub version setting
> 

Yeah sure, but I only see 4 patches on the list? Is my setup broken or
did you accidently forget to send some patches?
