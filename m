Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9852EB14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiETLoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiETLoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51948D029D
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E103661DDB
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9CCC385A9;
        Fri, 20 May 2022 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047058;
        bh=mEShUh3LbNtdl+3sSMKSDFyYayglrDNBlkU44FudZ5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pf0GBYF3koG47B2w/H6h6S2TN/7QtRdOJ+uDuSe38cKQWbeqGGqaVvPTn3FpxW1hs
         0jUe3JN4u4InEOca9jpPibOdqoot+ncoODXXw2ap2S624Atok/RSdK9on6vQkRShdt
         53nZcSpH3MhMJk0rQecVb8IQ2/EHI/ItP10yXukifhG50Q56X2dZOvzxjM7NljyQyT
         pFNlMkJbwI3cCf38JRmSctxAiPNI1/Ok5I35nAtVAiXlVd5ybW8OM+gpPmaDWQu3qV
         xnXWR7NVlbo/ZuQ662h9Kgh+KN6Qb26rxbL/WUcigrHic6hkJ5NvqDPiufsuOfmqBh
         RUdk03RrNXvOQ==
Date:   Fri, 20 May 2022 13:44:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uninline may_mount() and don't opencode it in
 fspick(2)/fsopen(2)
Message-ID: <20220520114409.msh67ggnwu2hxpxa@wittgenstein>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:20:06AM +0000, Al Viro wrote:
> It's done once per (mount-related) syscall and there's no point
> whatsoever making it inline.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
