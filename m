Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21A4DBDD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 05:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiCQEsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 00:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCQEsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 00:48:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA123FF3D;
        Wed, 16 Mar 2022 21:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55566CE2291;
        Thu, 17 Mar 2022 04:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57642C340EC;
        Thu, 17 Mar 2022 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647491412;
        bh=fQR762EgHvmtUjd5Xf1yyujMoy2QGlMi4ZKksAHOw3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xmOT/b6/dfVr2ZNXFiS5EIAMnIEqW5Zefy+HeVvbzwI1KaP/cDoGmfLoSuWV13Nbx
         KTNzujlQ52KL/li6ZgVln+aYKBl1MWKbzZC2OwSYYRTVqCrc3QwKkS46A9WD2xV7hX
         5JEAVTEObQV6YocO7uHffNMA6qE4WjR1kwo45zkU=
Date:   Wed, 16 Mar 2022 21:30:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair,
 RCU)
Message-Id: <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
In-Reply-To: <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
        <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Mar 2022 21:21:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 3/16/22 17:43, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-03-16-17-42 has been uploaded to
> > 
> >    https://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > https://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
> 
> 
> UML for x86_64, defconfig:
> 
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>                  from ../include/linux/compiler.h:248,
>                  from ../include/linux/kernel.h:20,
>                  from ../include/linux/cpumask.h:10,
>                  from ../include/linux/energy_model.h:4,
>                  from ../kernel/sched/fair.c:23:
> ../include/linux/psi.h: In function ‘cgroup_move_task’:
> ../include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type ‘struct css_set’
>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>                                     ^~~~

Works For Me.  I tried `make x86_64_defconfig' and `make i386_defconfig' too.

Can you please share that .config, or debug a bit?
