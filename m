Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768985BCFAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiISOxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiISOxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8CBC1E
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16BB6148D
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 14:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C10C433C1;
        Mon, 19 Sep 2022 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663599201;
        bh=Zbff+tGPWRuDSq/JK9namftCuYNIO6JO3LGntIfNfjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HF/1SBxHCWi/LDQMuyP4uGaW6Trxl46EKF+Iu1DpGQ0p1/TOCwFnLr2iKuYhZ4x43
         FAqa+Jajua0x7f7ZMfM9wrIJ3ktKTS8pB4JmzF9PLLreUKhVbxsXcN4m3NpJmxHA6m
         N1Sct4e08Sj40BKs/sXUojI5cdi1C1fUEYrmnXlJzet4lI0RA7TN5LJY11SDybb12P
         rJwARLddRBkCi6jl4jB5WtZ6AFrLzX6hcc11OqAR5s+P2CFVqYMTMRYvH/mx4j+0Mw
         cmFkl20SSHeLLeoX6KGpmaayoVmT/yDo5VxHEp8Vzqdvipr9RrJogWkOCXZfkYyQI8
         GkNN3gtwv4WTw==
Date:   Mon, 19 Sep 2022 16:53:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
Message-ID: <20220919145316.k34qg3b5yivbjuzt@wittgenstein>
References: <20220909093019.936863-1-brauner@kernel.org>
 <87czc4rhng.fsf@mail.parknet.co.jp>
 <20220909102656.pqlipjit2zlp4vdx@wittgenstein>
 <878rmsralz.fsf@mail.parknet.co.jp>
 <20220919080717.mgn2noszguledsfn@wittgenstein>
 <87h713haiv.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h713haiv.fsf@mail.parknet.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 08:24:40PM +0900, OGAWA Hirofumi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Fri, Sep 09, 2022 at 09:33:12PM +0900, OGAWA Hirofumi wrote:
> >> Christian Brauner <brauner@kernel.org> writes:
> >> 
> >> Ah, I was expecting almost all convert patches goes at once via you or
> >> vfs git.  However, if you want this goes via me, please let me know.
> >
> > The patch is standalone which is why it would be great if you could just
> > take it. :)
> 
> Ok, Please queuing this patch, akpm.

Oh, I thought you had your own tree that's why I asked.
Then nm, and I'll just pick it up.
