Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB52152C77B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiERX01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiERX0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5262A193208;
        Wed, 18 May 2022 16:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18FAEB81FB7;
        Wed, 18 May 2022 23:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF081C385A9;
        Wed, 18 May 2022 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652916381;
        bh=YHM8LSfblKaa5O5EHww5P6PRrqaJ9qR7G+aTMMBzYQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnNkqbj6Zp9W4+SnOmzywMhiaCUd8jEpW/Zk3ZCrqtAKGzdhEe8eQbdgURwXyRHGj
         WHbfavehGD+A9yiGLLfp34T2qy2Katj+UsbFBOjJDc7Uh272FNYIPrR9xn9kOrkSxX
         jdcWOSxvtRhtvyWBNZKMAEvugUamEsvKrAtHoZN2itwA/yXSSLlqi/sJVo4OoAifaB
         gFtz/aNL7WWpoXY+bSzhqXHe/nObtSJckGvp/iIYHnJvul571WcRzfq4vYjmrFvSQd
         q4p/nTl855zkgmH97UkVtEiiiXOXm5ufArADG5y9kwx5wubrh+qZy4GcfVH81mQMKj
         FbF3GcbwnX9og==
Date:   Wed, 18 May 2022 23:26:20 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <YoWAnDR/XOwegQNZ@gmail.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518171131.3525293-1-kbusch@fb.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 10:11:28AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Including the fs list this time.
> 
> I am still working on a better interface to report the dio alignment to
> an application. The most recent suggestion of using statx is proving to
> be less straight forward than I thought, but I don't want to hold this
> series up for that.
> 

Note that I already implemented the statx support and sent it out for review:
https://lore.kernel.org/linux-fsdevel/20220211061158.227688-1-ebiggers@kernel.org/T/#u
However, the patch series only received one comment.  I can send it out again if
people have become interested in it again...

- Eric
