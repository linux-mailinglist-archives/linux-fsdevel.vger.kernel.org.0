Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682965A228A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiHZIDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiHZIDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52DD3ECB
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 01:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03926B82F0D
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 08:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E4FC433C1;
        Fri, 26 Aug 2022 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661501014;
        bh=9RsOaxUnAERaGTL9j21WPiwVy7XiBnqsBqgkhVSXzNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsbbOxhMRy0MzdWKa3WhnwBlxItSxy3oYnyOVOKeEiMvfx99UFERNHoV+XniW5RtX
         dIgJTsYbOOL5cjm39GVL6e/KMebGFV1oC7zSW4/UA1a+Huw8rOrO5YK0p7KvXqcw+Q
         BsV+kykr+mq6jUTnbmQOksknHFbVbTOm4J/KKCP2HdkOfcomg4PiBg/MJM8Js5C33m
         KuSIwLYuA2qUTWRq9ggfa/FNq+jd5cDQJB6eVyf0p5GHTaAYiP2za0WjgTrkvt86FG
         h0fZ6mTE8it2Jfena0kyjcmvc1kH9HMjEMqmmIZ2sOlJg/pfu00L56+fvMMwSqwutz
         TxHSwNMONO11Q==
Date:   Fri, 26 Aug 2022 10:03:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES] file_inode() and ->f_mapping cleanups
Message-ID: <20220826080329.t7bfiwy2ocrpenu5@wittgenstein>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 09:12:36PM +0100, Al Viro wrote:
> 	Another whack-a-mole pile - open-coding file_inode()
> and file->f_mapping.  All of them are independent from each
> other; this stuff sits in vfs.git #work.file_inode, but
> if maintainers of an affected subsystems would prefer to have
> some of that in their trees - just say so.
> 

Oh sweet, I wondered whether I should bother with a series like that a
few weeks ago...

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
