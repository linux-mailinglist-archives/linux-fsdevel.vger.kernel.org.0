Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60452EB3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348792AbiETLyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbiETLyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065A15D31E
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30F961DEA
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F8C34117;
        Fri, 20 May 2022 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047652;
        bh=H17ZN5lvDE5Gss4N6GKL85QrQRXCH06scDEOC1Pzm3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1TnRNmZpGuhn1sw2CDthgU4iEOnPUcw3yrIpKYpSTOSom7Ye3ajEtCXIOeYy+tJ1
         aM19hEoVdpUyJM7+zEnKR+9KJE0cm2FR97VMLXi1sh+AMqHNC8ejqi19Nh4RcX7H92
         OZAeTnq9aSZq2j7KcXNc0UjBUzs26pLz2f/vElPPp9IszfZZxBu9dGP8w6B8HwLDaz
         2iu//xTzAVDbREXUz4kGTsnrrfCtMuKsQmuZUUFPEx+DPUE6VE2s6NQfO3VCPm0hs8
         Yi4/Zgmls6BgcNZNWauxw0n4GQc5ldSOtRQhiE0ctsi2sae8Tkej7s7qJ2nlN+ZHSw
         MN5/sO5dGV2Vw==
Date:   Fri, 20 May 2022 13:54:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] move mount-related externs from fs.h to mount.h
Message-ID: <20220520115407.sq63rvsmaza3usac@wittgenstein>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
 <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
 <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
 <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk>
 <YocJzhlCzthlvS1I@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocJzhlCzthlvS1I@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:23:58AM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
