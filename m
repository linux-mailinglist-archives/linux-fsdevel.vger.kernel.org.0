Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A751E6AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446278AbiEGLo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGLo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 07:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543A62CB;
        Sat,  7 May 2022 04:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D841BB80CF3;
        Sat,  7 May 2022 11:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E2EC385A9;
        Sat,  7 May 2022 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651923636;
        bh=Kstf+5Om1UpV7wYBMz+qFHCkqVdczsiGFaKAy2n9be0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=qPJ/MbbS8diXXRz5VxTvh87oHXjFAjBAulaeK91lyE592xP7KsymNJ8uJy5Zo5WNl
         y1w8uTwX1QVUWuHH1EKOB7qa7jJnBz00u6bBTBuy6rTN2hNIz1+yMlDG9biI2VzTxN
         f0mNkyoe0FF9fmlABVlzjmq7SX8v5/+4RsOaDdyV7o6Dp1EhETAeacc4/A9ayQ14vJ
         jMfW/Sf+x1YQm6hAHgXU4oHIlBVL1CG0PwD5mmizO2V03NwHsrqEBSKDp8utc5rimW
         NVOAlqigzplRtNrmtoihp913bvAyV9EfpEJVWQG51xppqDd7AUywji8Len+QIR2kDy
         r8oIkf33b6fyQ==
Date:   Sat, 7 May 2022 13:40:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220507114032.za7ejzgh2bspz6kv@wittgenstein>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6275DAB9.5030700@fujitsu.com>
 <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 04:52:09PM +0800, Zorro Lang wrote:
> On Sat, May 07, 2022 at 01:33:33AM +0000, xuyang2018.jy@fujitsu.com wrote:
> > Hi Zorro
> > 
> > Since  Christian doesn't send  a new patchset(for rename idmap-mount)
> > based on lastest xfstests, should I send a v4 patch for the following
> > patches today?
> > "idmapped-mounts: Reset errno to zero after detect fs_allow_idmap"
> > " idmapped-mounts: Add mknodat operation in setgid test"
> > "idmapped-mounts: Add open with O_TMPFILE operation in setgid test"
> > 
> > So you can merge these three patches if you plan to announce a new
> > xfstests version in this weekend.
> > 
> > What do you think about it?
> 
> Sure, you can send V4 of patch 1/5 ～ 3/5 (base on latest for-next branch
> please), as they have been reviewed and tested. Christian's patch (about
> refactor idmapped testing) might need more review, he just sent it out to
> get some review points I think (cc Christian).

LSFMM happened last week so with travel and conference there simply was
no time to rebase. It should be ready for merging once rebased.

> 
> If you'd like to catch up the release of this weekend, please send your
> v4 patch ASAP. Due to I need time to do regression test before pushing.
> It'll wait for next week if too late.

Rebasing the patchset is _massively_ painful which is why in the cover
letter to it I requested that patches which is why I requested
that currently pending patchsets that touch the same code please be
applied on top of it. (I'm happy to apply them manually on top of my
branch.)

In any case, I'll have a rebased version ready on Monday (If there's no
urgent issues I have to address somewhere else that I missed during
travel.)

Christian
