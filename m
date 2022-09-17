Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D35BB7E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIQKv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQKv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD47326CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 03:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4853B6135E
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 10:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA24C433D6;
        Sat, 17 Sep 2022 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663411886;
        bh=9GoiCN0J8BWIFcJy4HO+2J77733KaSM1tpBc2+8hcXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A88UDHASs2c4KXPOnujJHWqpUVPTqFlCeHKr8K7cIqd3G0RrdHw8bTH6umM7oBJzH
         v0M+QOF/Gn94U3OARsc57P65Iwi6vIe986lD9LXsVkuxQ9syLjHX/tdeCGl1XWvLDK
         W9CEhGigX4Je074J/D9UxxtPB8iMnmaAEYFcdw7kdZVHqB+Ba5Xvav1VyiWRMtONAp
         Za29yFdoGijhuf75H1/so4SP4XcWJ/6gIX+2Y6mtaLBc8FwIRb9gA+JBJv1SLHqo+w
         PBvEbf6raho+sgtW/dG1lMPsaiHEdoqmnOlWU3kNnNqrbrCopgYyzGW7T+NxDip6Cv
         1DR7su+yOA4Ag==
From:   Christian Brauner <brauner@kernel.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] acl: fix the comments of posix_acl_xattr_set
Date:   Sat, 17 Sep 2022 12:50:12 +0200
Message-Id: <166341168207.1118458.18034194976354545438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915014830.1671-1-wangdeming@inspur.com>
References: <20220915014830.1671-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>

On Wed, 14 Sep 2022 21:48:30 -0400, Deming Wang wrote:
> remove the double world of 'in'.
> 
> 

Thanks for the patch. This is on top of the acl changes in my tree and I
applied the patch there, thanks!

[1/1] acl: fix the comments of posix_acl_xattr_set
      commit: 0978c7c41fe2a3735f8776dc27cf1641bd916773

Best regards,
-- 
Christian Brauner (Microsoft) <brauner@kernel.org>
