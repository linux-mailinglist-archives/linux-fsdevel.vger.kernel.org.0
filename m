Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B685374E7FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGKHbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGKHbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:31:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB41AC;
        Tue, 11 Jul 2023 00:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F541612E8;
        Tue, 11 Jul 2023 07:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049DCC433C8;
        Tue, 11 Jul 2023 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689060660;
        bh=Epo0oSrhCxGbIyCV6Ohw7wkAgyAAKLVxS3mXZXb+g0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0ft5/lQDhvcHqyIZdIbqQBr3alz3CZHPn9Wh6YjSCE1yHDTLwElSX1fWYtHo+f0m
         ZyB/C+yBC4E6mPuixAHdz6TOZWjeUsUQmXE/Pk4WQXM99Bb77xavinFi+jB4x/ijji
         LW530qN4uOxPGy3k9kb1Mssua96AKFRxWj+CPaU+HQ0Vyjh7kp5katL1I0tlvVAgbB
         0C2R3FssGhQU8HKn/1enCJoHvUFVCMvd2V8RKvmglj3kxEWGfFChDIGRfUqjkal9H5
         9Vc2j/HMRiP4EvSk4EcxVPzYR2QdfPT07eQfJvsy8DTnxLpjNhinhlOESy72OYED4B
         WtyXqEC9LXZGQ==
Date:   Tue, 11 Jul 2023 09:30:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [biweekly bcachefs cabal]
Message-ID: <20230711-glotz-unmotiviert-83ba8323579c@brauner>
References: <20230710164123.za3fdhb5lozwwq6y@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230710164123.za3fdhb5lozwwq6y@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:41:23PM -0400, Kent Overstreet wrote:
> Cabal meeting is tomorrow at 1 pm eastern.
> 
> We'll be talking about upstreaming, gathering input and deciding what
> still needs to be worked on - shoot me an email if you'd like an invite.

I can't make it tomorrow but I'll attend the next one.
