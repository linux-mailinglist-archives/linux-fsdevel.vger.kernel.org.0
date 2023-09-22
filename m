Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1A7AB20F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIVMYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIVMYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:24:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A92892;
        Fri, 22 Sep 2023 05:24:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D53C433C8;
        Fri, 22 Sep 2023 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695385452;
        bh=YPAEdZzjb8G4WlnH9OO9cM+AcMrYTXXzDRZ1r7Q1wO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKy4Tt5s8dKEOkXXzhptTXmXkbawh6yaKlKiwm0RaeCK4X9JbTJy/5VxBVRU4mnE8
         +JM+YWjJTHEb2ix0YOxmuM3xJQfwp+oTsgRe4JzlZgm9x5PwiSAm0FN1SybBbLsJ3P
         zBrqb2WeftVldaTXHyNuoySnfKQiDBn1NNlV1serj3RmkCpTWfsNnnNsCTaBoec4n3
         SaC+vcngCPbfYbP8R5Fo25NAsQiI4Feg8g3dG5uF6xFGdSYsl0wM7jpIaCnWq6puhV
         nodvsk/5RsL0HRSSkJgPaGoZjqNrwXCOH0Y5e57sflcMekDS+2p02Vj2o8d4KsRJ1C
         nAEMl0fSCtqBA==
Date:   Fri, 22 Sep 2023 14:24:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230922-heirat-gullydeckel-a4d95078ae25@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We have many, many inodes though, and 12 bytes per adds up!
> 
> I'm on board with the idea, but...that's likely to be as big a patch
> series as the ctime overhaul was. In fact, it'll touch a lot of the same

Hm, I really think that isn't an issue. Let the series be big. Half of
the meaningful fs patches explode anyway as soon as you change any
i_op/f_op anyway. If it meaningfully cleans up something then it's worth
it.

Hm, we really need automated testing on vfs.git soon so we can run
xfstests for all major filesystems automatically instead of me having to
kick this off manually every time.
