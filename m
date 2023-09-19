Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA77A5DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjISJ0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjISJ0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C050118
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 02:26:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9160C433C9;
        Tue, 19 Sep 2023 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695115567;
        bh=nz4TBn+KOSXkhwessJyKoMnd2ytVu6xOsocn2gFeyVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8p/o6YKWKT0ILgA+Uwy/noDgO21b09XkhAcDgm6TDWKVuTg5i6yjt2cnZX9GQeQ3
         FlNb/yNOpOsnVyNqjD0MFw9Mq2QLWrSMfFXI99EfJEw7LIOaV3FJLNJ+Wb/tV+VaMN
         Bv0/8dZRRn39EHhoONw9Twt4chIt6xTGpst+SbhcUOJIrhLdw+vBld0aHO4FgUG/8j
         7Xl7J0E5/DmFoOOCSaVAkq2fv+2eOPWQHrCEBBSBoWFmqapjZdY4g3aZlXRe0gVGuQ
         JID6NTlm4Vsgoy6GKAl3dIruCHVLaB4zApEaCh0fT+9cCpG7rZVQxmkOxLiJQUFWKW
         mlsx2lc4RmXqw==
Date:   Tue, 19 Sep 2023 11:26:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Subject: Re: inotify maintenance status
Message-ID: <20230919-nachverfolgen-entlocken-9c245744ff1e@brauner>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com>
 <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3>
 <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Christian has also mentioned [1] the IN_UNMOUNT use case for
> waiting for sb shutdown several times and I will not be surprised
> to see systemd starting to use inotify for that use case before too long...

I think that having a version of IN_UMOUNT for fanotify would be great.
I've said so a couple of times indeed. It is a really good feature to
monitor superblock deactivation.
