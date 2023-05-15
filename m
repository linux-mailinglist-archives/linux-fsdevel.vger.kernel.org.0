Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47926702686
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjEOH6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjEOH6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FA1725;
        Mon, 15 May 2023 00:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF8E56121E;
        Mon, 15 May 2023 07:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6066C4339B;
        Mon, 15 May 2023 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684137371;
        bh=aGgV8Fk04aAxsyOUuSaRSanh/M61ws8l+egjAA63JEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRbT+LD3eZeE3bb78D4ENbrLYyruc0VB05g6A3XVz/A8f42NG+eVmTro+cDPHRCmI
         ifOG/soIJAQb98B5pcli3153TufH3D/Ep8nz9fXmne5d2wyF5hx2jvUvsWPLNlxBNM
         jMMr97NRdNH8TYS3oKZITNgnFLRVMJapZmmziJKAYDjXKUtJSN28Ky5sLhO5eLiRHj
         L5XM+MZgmEhr6M31rsEEt9BUTRAyqCWOheVHuiCCRXDrJd0pjtoIudxlfrmLIF2uND
         s/oTKbORppXfrlgQxfOCeAGkHjZXzOho3/cg2G6+jTgxOIrRp+r161JWrKV6S2JYz6
         XytN95rtafznw==
Date:   Mon, 15 May 2023 09:56:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v4 6/9] fs: use new capable_any functionality
Message-ID: <20230515-disqualifikation-ununterbrochen-c0f15f4efdd1@brauner>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-6-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-6-cgzones@googlemail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 04:25:29PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
