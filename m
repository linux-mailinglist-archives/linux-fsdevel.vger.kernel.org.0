Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C65F574F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJEPQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJEPQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:16:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7CF75CC1;
        Wed,  5 Oct 2022 08:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B962FB81E06;
        Wed,  5 Oct 2022 15:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76B9C433C1;
        Wed,  5 Oct 2022 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982975;
        bh=RO5hzm37ip/Lb0pciYJHFUk4L7rNnlJL5WQBU9DaNGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+UZFzumkybAZpLn8lEDo/54R//BPb4JqGC9/RmGEyIiaUIfUCfzcyeJUjN09GFje
         lRS+mV0/Y+fPn30JWdqN3sD0hz/W+unEkaaGM8/AB7fuRgdhpOkv9izlp2Fs/d55Fz
         9MuMnguLkS+Z2rjy9hx+Iq8Ac5ehFVXJUcS+V9FoHr6KhqCRj/9KsKVsJIu9fUBs9h
         wR3en7KBMbrIXAL7s6zBJ1FerWCbTvWD4apdJpjhMOavXAPF8YgraGnEOqx3W7b6ey
         Xa0vnQKUn4DrkKnPkQXCEK+lPwiTOhSx0/s2Zo8opKY1R1PlmPONRZn3olmiandzVr
         AOI1tATKsf1kw==
Date:   Wed, 5 Oct 2022 17:16:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
Message-ID: <20221005151611.gqnlynmylx2j3z7y@wittgenstein>
References: <20221003123040.900827-1-amir73il@gmail.com>
 <20221003123040.900827-3-amir73il@gmail.com>
 <CAJfpeguiGqdSZVwsx_MrLd2MLvLMAkz58NjCMHZehpWZCK5fFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguiGqdSZVwsx_MrLd2MLvLMAkz58NjCMHZehpWZCK5fFw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:40:10PM +0200, Miklos Szeredi wrote:
> On Mon, 3 Oct 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Underlying fs doesn't remove privs because fallocate is called with
> > privileged mounter credentials.
> >
> > This fixes some failure in fstests generic/683..687.
> >
> > Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Christian, please feel free to take these if you already have a bunch
> of related patches.

Thank you, Miklos! Will do. I resend the series with the vfs related
change. If you have an opinion on it I'd appreciate it.A

Thanks!
Christian
