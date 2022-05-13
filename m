Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589A7526006
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbiEMKPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379321AbiEMKPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 06:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB14DFC3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 03:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3305762230
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 10:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B836C34100;
        Fri, 13 May 2022 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652436948;
        bh=3wvTu4N5NdDOJlLO7heyqhDicVebhuucNR+L2G+44f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3+9TMdXgblR/0IS7e66rrkjgoANMLUQ5CAtGhUdIQjRO7DVwJjf3iq90exubM3hc
         Bb39HET0Kw5dRCGAXolkiUFMuF5e0Yw/IPVj9PGjrFBYnffPGnDDkpRhSKysbn+djC
         zlhGXuKhTLmEFR6aACPUr9rfospikD9Iq/lG/+P2Ldp8cyXISVraPY3iwnTUhEDdaQ
         iNh4NIbsrGj51xbN+jM4ZGEHrg0XlAfFPm626aXZBswhlrQU3+c835kATpDmtlpBWs
         Z5Bx0ScCiwi2Wy7PA6hgh9skeEh9j/mh8z7GWgAfgMs78Z0BOUScQhANOcgyTg2vAN
         TtiXcJCaJ8xHw==
Date:   Fri, 13 May 2022 12:15:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCH] get rid of the remnants of 'batched' fget/fput stuff
Message-ID: <20220513101544.qqkt4pvj5gmz4wsf@wittgenstein>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
 <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 11:26:39PM +0000, Al Viro wrote:
> Hadn't been used since 62906e89e63b "io_uring: remove file batch-get
> optimisation", should've been killed back then...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
