Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D217BB35C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjJFIil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:38:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81479E;
        Fri,  6 Oct 2023 01:38:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6864C433C8;
        Fri,  6 Oct 2023 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696581516;
        bh=RWTOYqmVcaMS2b2LmuQZdjBsJoKFUC/1MmZBuSR2auk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xe+tCz1/50XNuOLE/hYfW2GdX1G1EtvT3tGVF0Wyt9NswSkCvjFlLQNiKl7RzBYD0
         k7tMQzQLrIpd9bUXGtskZDpFzxpr1gepYZ5ozm9t6iIy/UplfFCqoeEjahHbmQB53Z
         +AHDdbmZLb9WMJkzBe0XCvHP5dfvJWSU3TzIhGkOQpXb+CIvd4uMvYwxX0fw/mXRGm
         sRBUFzshYh42bcXC+a9MWraG+xdhtEXZzmTY9NmfV9v34zgtaRHxPyLvJTl/YjURoA
         BeSCy8WkRl4tRL4i7q7JtnEDoNMbru+BMMOlMN+hGOFGVzecgClh/wNA/bg5yo/7wc
         y1vydCks3948g==
Date:   Fri, 6 Oct 2023 10:38:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <20231006-bahnfahren-anpflanzen-9e871ee3353e@brauner>
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:04:19AM +0100, Mark Brown wrote:
> For the past few days (I was away last week...) the fd-003-kthread.c
> test from the proc kselftests has been failing on arm64, this is an
> nfsroot system if that makes any odds.  The test output itself is:

I'm out this week but will look at this right when I'm back.
