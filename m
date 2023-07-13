Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E501751963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjGMHKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGMHKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304C119;
        Thu, 13 Jul 2023 00:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8821261A32;
        Thu, 13 Jul 2023 07:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A40C433C7;
        Thu, 13 Jul 2023 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689232222;
        bh=CwwZLbf50/yKNG71WtMT6hp+RFL2iUj7PqM9mTItudE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQTuaLSZAsq+RbpeLBSscKS5PyW9f99Krhj2zlzaibKk8ohn35QslzJeBIYF/Jk/5
         dPUEYOEluL+f/OPo+xKud4VElR8FQgWa6740UlODGXqR+qBXJLyxnsR/7rtkZ085D6
         S53BSpBMZ9l0q4HN0JHT8xUVSx/NUiu+PFeCLts3dfyxzuJzCp2oRlyj/bYEX1qhF+
         0X6w6lwHb1Sv05xl865lRbuZ68ad9dXtL3fmG/zI+yB1CgJezwqFXaj25kxNdKhDu3
         Nc5vqFO2ynAOTDxTaUK9QQcp1SpTb0yBZQdNZ6s7zeHooxMkuJxnpztnXkB5bb1EGn
         KirHbVnBNlz0A==
Date:   Thu, 13 Jul 2023 00:10:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christopher James Halse Rogers <raof@ubuntu.com>
Subject: Re: [PATCH 10/20] lib: Export errname
Message-ID: <20230713071020.GC2199@sol.localdomain>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-11-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-11-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:11:05PM -0400, Kent Overstreet wrote:
> errname() returns the name of an errcode; this functionality is
> otherwise only available for error pointers via %pE - bcachefs uses this
> for better error messages.

Interesting that this exists!  It seems you meant %pe, not %pE, though.

- Eric
