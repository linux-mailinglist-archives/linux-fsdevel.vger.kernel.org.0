Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A02750C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjGLPeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjGLPeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EC1BF7;
        Wed, 12 Jul 2023 08:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9547161864;
        Wed, 12 Jul 2023 15:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECC1C433C8;
        Wed, 12 Jul 2023 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176055;
        bh=6oEiutwftI2H8nspsyS0yrH2Djeg/+ZfO4scNbLQ3IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gei2LgMyiqJghONsgzoyfDl4HtLi7rUmCOYicVWqiUHEaEoIiRNLo5rScwVM6oNR9
         2h8u7j8jt+GphzC/0Pu74OBHptH4nHlKAHNUq46M6yTPdyLsKD1r+eo7VO4mI4cJT0
         VPwrSE/aFLC1T0TFbSyjhXvxtAZnQ/J8DvXi9kR5gRdmDbra1JqrsWCcKvioxRUwyH
         SPnhWMlKXN8v0V8bZIBtJqB3WRiWqA3xzeMlJ9mMzhBTm0j9dBOv+NPrRUhq+JvzsT
         u6JtBNSRxwnkGZoIMgjE5/NUPY2AMFBE8dpYpQ8S7THTMWLzBvdgMWuVOy0g9l8btU
         mjzbtW+BaSE/A==
Date:   Wed, 12 Jul 2023 17:34:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: [PATCH 01/79] fs: add ctime accessors infrastructure
Message-ID: <20230712-ehevertrag-betonen-ebf69808de1b@brauner>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144507.55591-2-jlayton@kernel.org>
 <03e153ce-328b-f279-2a40-4074bea2bc8f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03e153ce-328b-f279-2a40-4074bea2bc8f@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:31:55AM -0700, Randy Dunlap wrote:
> Hi Jeff,
> 
> On arch/um/, (subarch i386 or x86_64), hostfs build fails with:
> 
> ../fs/hostfs/hostfs_kern.c:520:36: error: incompatible type for arg
> ument 2 of 'inode_set_ctime_to_ts'
> ../include/linux/fs.h:1499:73: note: expected 'struct timespec64' b
> ut argument is of type 'const struct hostfs_timespec *'

Thanks for notifying us! We fixed this earlier today. The vfs.ctime
branch has been updated with the fix folded into the hostfs patch.
