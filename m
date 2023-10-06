Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1D7BBFCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjJFTrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:47:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157D83;
        Fri,  6 Oct 2023 12:47:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2F9C433C8;
        Fri,  6 Oct 2023 19:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696621654;
        bh=g5PzMd1bqmBKkTiRTS3JMWcR/gyi4weAfC1z7SeKX90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ms6lBEG8CnayjUUdGJdGJGABn0ix5jQRkywxXY4KYxj0PwUaBIqkLKgnDvRQ98IQq
         nOZuwQT3Sv3fD/S5+wtN3X0NHQa433V8O3ELnWPqu3pDyKlKFIAuy+WVy4fOwLpn5M
         xtOxtNbtmj6De8ScR3mP6q2JSA+qXUlXRVsR89INEFHm0VN8QFquEa+ngI4DT4vM8c
         0wvpHLIc3XGcT0c/9HzZLEWrzPgXrWokHPk5RhZB6vui8jSawoHDSbii0FruRiv4Lu
         wzpOCGgp6hk0OH9+zuKWEM8Y45BIuJJeG3ptwSg//fvCwVZT4NQdTrR8vsdx3ARhTe
         B5TjiJ/bVmrrw==
Date:   Fri, 6 Oct 2023 21:47:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <20231006-essen-abdrehen-72ef45311a33@brauner>
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
 <20231006-bahnfahren-anpflanzen-9e871ee3353e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231006-bahnfahren-anpflanzen-9e871ee3353e@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:38:30AM +0200, Christian Brauner wrote:
> On Fri, Oct 06, 2023 at 01:04:19AM +0100, Mark Brown wrote:
> > For the past few days (I was away last week...) the fd-003-kthread.c
> > test from the proc kselftests has been failing on arm64, this is an
> > nfsroot system if that makes any odds.  The test output itself is:
> 
> I'm out this week but will look at this right when I'm back.

Fixed in-tree. Was a pretty dump s// bug on my side. Sorry about the
noise. Should be gone tomorrow. Thanks for the report.
