Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA36EE1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjDYMh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjDYMh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6E212B;
        Tue, 25 Apr 2023 05:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC9C1616BD;
        Tue, 25 Apr 2023 12:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03EEC433EF;
        Tue, 25 Apr 2023 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682426276;
        bh=LeyjP+oas7FQvvYfXiR2Q1XMkCVwl+g1VccTFcIY5hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieynPTg5OekckKGpT731LZFnFrwGZAJEAviW2eFQCZCcLJ3yEEGGDHh+oG4fN5wvH
         mDGtIfoCmxJjJVOqEk90TlQctMClQi7ZVLDvFUUDuv3VlkfJGuQtr3ixkthDMLNbAh
         OB7BYXcMwwjlBsYEWm6uhlAJHv7DRBkpG2kCFlw9SDn/yb7N+er1zsDSgEVPi54b3w
         559fETfCFvnUU0mE/yZtbfaHz+reXdD2jW+6BHeZgFGxjCKornuMo8i3Yc7XPBAubF
         zriGlPFuew+uhIl63SZ1AWN3/zp9XPlhlMWC6Ic6CMxtPGihX2i8Og9lBQpm9OMJfE
         7Rfexf7tXu43w==
Date:   Tue, 25 Apr 2023 14:37:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
Message-ID: <20230425-imagination-festmachen-184307771bde@brauner>
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
 <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com>
 <874jp5lzb2.fsf@meer.lwn.net>
 <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:01:23PM -0700, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:56 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > The paywall goes away on Thursday, so this is a short-lived problem.
> 
> Sounds good, thanks.

Yeah, I didn't use the non-subscriber link on purpose because I know
that Jon's doing it the right way and just opening up all articles after
a short while. 
