Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688252EB15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbiETLpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiETLpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2148D029D
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D62261DE2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1788EC385A9;
        Fri, 20 May 2022 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047106;
        bh=ua0oW44aH/opPIQxyU3LXpN/IlGk7wnP2CE17zQ6ypg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKNXpl3+r3SLNvDPOz5lAdl0wJI2CeghWL4Z+QVsJxnLBeOTymb3Cw+Tae6AFOtMR
         PuXa07B87fe/yCArLX+paHZXMEOlJ7BgKBWJxn7OnQSG2oZ14CRtX+FtkkUt+1wZop
         I2IL7L+WtuIzRvRYwWEepU2G9Qt7h2tmzgpvLHrm307y540WhEW57GzSB5piEp+h7u
         Bc+PQuKwN+kX2o32mjmlIfegE389UW/wARBkWGHZDZrmEJARvGGRVXOyxzWnf2T2wp
         CqpQEN5lq7aN6Ob62fa36N8uQKXuvUVRx94CCiv/B9qWOyqIS3RVKG1RI0BUeQ5nxz
         +t8CqN8oxxJ6g==
Date:   Fri, 20 May 2022 13:45:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] linux/mount.h: trim includes
Message-ID: <20220520114501.itvmhggm5arcplfh@wittgenstein>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
 <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:20:45AM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
