Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029C69B890
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 08:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBRHw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 02:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBRHwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:52:25 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A344FC98
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 23:52:25 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7EF81C01D; Sat, 18 Feb 2023 08:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706765; bh=fROapFjKhE+vxFkAOe21o2IY0fvbpMlTcgsaDuyTXTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQoazwGaf00xHDeJJ2w63lcvhrJJY/GnP2k1wl5qGZ+CSqUjOQIjA2HXVugwImUrd
         3J7maTAVQYZWvLDmmCdpco9BJvVWsx530+tPvl7zx7FHpD9lpQB3NpynmTvYOkoG9J
         6t8DKQyPKmEEjFGLeDB++RsSOGXd8DU8es4KV5AulKC6MCEUVnjNEI/rkHzPzE/YuY
         DLcXqJJPMcrKR5P3Sylvar1KH0VRU5sUDdHtC5mRRvEQ5+s4+7B/TQQ/cZpwcAggWg
         2J38CLRYTJ09x8LfeG+TyRFPUeXhawjGExtfgySez6fAjxvAWcK2FjP3JcVp4omUnS
         PFh8LqboctC8w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1D974C009;
        Sat, 18 Feb 2023 08:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706764; bh=fROapFjKhE+vxFkAOe21o2IY0fvbpMlTcgsaDuyTXTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kp2dJ0cTkLZeU2PanQyiK8g376dUUACCdnM5CEq2GVZStTBzbs12bxBBIyQYxH9pf
         jKEp4pcbcg+hmm0nImA4D+Ns3LbOUwOsQ7Ix5UJ2/cnDwZe0G4qHnNgQ6/PC/8E3oo
         OvW5QoaWRvmop0E9icHVWRasO6Lky4lSqwKWE7ttxunpqyhgCu62l8bQeNFs6T8Mvy
         dQnVNraigTIVS1cyq2pOwG34j+1cEbvnDjOEqNlZRug1+MhsdpLHV7YK7L2vFvX6pK
         59zbSGunPmAy55LVpD9JDZL//7vlGCaO+/qoAJwEat9eG9tvK/pm+xncR2ngBwOCTI
         0LNndMn9B0pzQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b6aa872e;
        Sat, 18 Feb 2023 07:52:15 +0000 (UTC)
Date:   Sat, 18 Feb 2023 16:52:00 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 05/11] fs/9p: allow disable of xattr support on mount
Message-ID: <Y/CDoEvgmLNbhZw7@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-6-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-6-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:17AM +0000:
> xattr creates a lot of additional messages for 9p in
> the current implementation.  This allows users to
> conditionalize xattr support on 9p mount if they
> are on a connection with bad latency.  Using this
> flag is also useful when debugging other aspects
> of 9p as it reduces the noise in the trace files.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

--
Dominique
