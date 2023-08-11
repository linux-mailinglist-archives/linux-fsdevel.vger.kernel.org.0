Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60C778899
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjHKHxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHKHxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA29C;
        Fri, 11 Aug 2023 00:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB82639F9;
        Fri, 11 Aug 2023 07:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C28C433C7;
        Fri, 11 Aug 2023 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691740385;
        bh=MTJarVIvr4WRNyvhoo/0slfSO8LXGQpypLwKg1eCCi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwgZR5Msj1ZoEutKFBoQXBW3LUkSiSp1+DQCPtl4T8nK48K4RGZm6Cc/mki4Y3LdE
         E7VpqAUuGNiXzgfE/LTKuDAGif0xRBzm3TQjB48epzHgRdFCXUNxydcvbsjReG5IiR
         fcyourzsDlHE1wBopf24Oyz2D809MES8azf4VD4ykNjQotIULMsiz+Sg6Mp4pX22jD
         NDoLfOhEYeKJvhlgTEw8b36rUvb+bH3PzhGL4kP+lYCuqs/5RDQ2ECh2qTGdFwaMnU
         XvZjzSVX6Ds2LFLeDd0x2LqymqgJQqfHfcX2j5NHrsN7g2KPGJw+fvu5SvoskO24r4
         +CtLwT9VlMpbw==
Date:   Fri, 11 Aug 2023 09:52:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811-wandmalerei-denkpause-e9670c291635@brauner>
References: <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
 <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
 <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
 <20230811052922.h74x6m5xinil6kxa@moria.home.lan>
 <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So may I suggest that even if the immediate issue ends up being sorted
> out, just from a robustness standpoint the "consider EBUSY a hard
> error" seems to be a mistake.

Especially from umount. The point I was trying to make in the other
thread is that this needs fixing in the subsystem that's causing
_unnecessary_ spurious EBUSY errors and Jens has been at his right
away. What we don't want is for successful umount to be equated with
that an immediate mount can never return EBUSY again. I think that's not
a guarantee that umount should give and with mount namespaces in the mix
you can get your filesystem pinned implicitly somewhere behind your back
without you ever noticing it as just one very obvious example.

> 
> Transient failures are pretty much expected

Yes, I agree.
