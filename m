Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C76D708C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 01:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjDDXWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjDDXWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 19:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8D40FB;
        Tue,  4 Apr 2023 16:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80510639CD;
        Tue,  4 Apr 2023 23:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD23C433D2;
        Tue,  4 Apr 2023 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680650535;
        bh=wmW6nn1dW0G7ZUK1nyoM03KcQYEFzLGdk68Km/BFqaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZj10jKRNecy8t8ufVTHZDF49qF6T32i58y3DEOIeipYODmpuNnsQ8Hzia4pi4LqH
         EE4sPsq93OOt1W3Hp5LhcSaKzWV3TVOzbejyLrSA2rc131GqbSgWb7jdyV1bgwsdW8
         2LMFo2UqiNnl8qsLV5eghGCe62GCRgrz1woC6uvYdx7dcNNrNOdbQNmEvqJj5688gZ
         hbnUNWYxq0r0Ci/4A8EPpqh4TgYzHIAq6HkkgeGEC9G82mP+E8k4y/36+dPM3sHY0g
         Qn5FjtYqObCRpIZuZQSEWIo1a4yk8azE0bLTEpuOKnXKGcjmuNM+Vfvvhw+axyzOPN
         8DRyUk06RKN2A==
Date:   Tue, 4 Apr 2023 16:22:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        brauner@kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Message-ID: <20230404232215.GC109960@frogsfrogsfrogs>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
 <20230404221653.GC1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404221653.GC1893@sol.localdomain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 03:16:53PM -0700, Eric Biggers wrote:
> Hi Zorro,
> 
> On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> > +FSVERITY
> > +L:	fsverity@lists.linux.dev
> > +S:	Supported
> > +F:	common/verity
> > +
> > +FSCRYPT
> > +L:      linux-fscrypt@vger.kernel.org
> > +S:	Supported
> > +F:	common/encrypt
> 
> Most of the encrypt and verity tests are in tests/generic/ and are in the
> 'encrypt' or 'verity' test groups.
> 
> These file patterns only pick up the common files, not the actual tests.
> 
> Have you considered adding a way to specify maintainers for a test group?
> Something like:
> 
>     G:      encrypt
> 
> and
> 
>     G:      verity

Yes, good suggestion.

--D

> - Eric
