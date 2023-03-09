Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2336B2369
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjCILud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCILuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4A4E7ED2;
        Thu,  9 Mar 2023 03:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E3C661B24;
        Thu,  9 Mar 2023 11:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE8C433EF;
        Thu,  9 Mar 2023 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678362617;
        bh=/WZMnXXvFvWgEiClRENR/krm9fheBqDzubyeL7/cJxM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ph5Tc5gzvSdj9y50QqzJYCO8UsBDQThgchpxldN2b+P9F3G2J9B9Vm1AJOtmUBCa6
         JoKOAWikTEQmYm6XdO/yJhYFRZ6h69C7rtnCOUEV80fayicqC9fWIVwR115LrioyOb
         T521IXUbKTipGdp4VPZccj+ACtQcB0V4jITKqBPeLP49yckNtZFu8dKV84MfyR0Cz4
         I5ChNWh0VHa8EIaRV0LJK5dsSZdFdkpt8Bg+bUCC/i6ABa3uP3eSxUre7S25A24gYm
         Bv/ueyHlYrNbuWTRA6kcL38nr4m0m7qb6EmouUTXZO4jS0rRj9wymmr0xDS7lvLasC
         5UXCXrZ7dTHMg==
Message-ID: <fd7e0f354da923ebb0cbe2c41188708e4d6c992a.camel@kernel.org>
Subject: Re: [PATCH] fs/locks: Remove redundant assignment to cmd
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Date:   Thu, 09 Mar 2023 06:50:15 -0500
In-Reply-To: <167835349787.767856.6018396733410513369.b4-ty@kernel.org>
References: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
         <167835349787.767856.6018396733410513369.b4-ty@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-09 at 10:25 +0100, Christian Brauner wrote:
> From: Christian Brauner (Microsoft) <brauner@kernel.org>
>=20
>=20
> On Wed, 08 Mar 2023 15:13:16 +0800, Jiapeng Chong wrote:
> > Variable 'cmd' set but not used.
> >=20
> > fs/locks.c:2428:3: warning: Value stored to 'cmd' is never read.
> >=20
> >=20
>=20
> Seems unused for quite a while. I've picked this up since there's a few o=
ther
> trivial fixes I have pending. But I'm happy to drop this if you prefer th=
is
> goes via the lock tree, Jeff.
>=20
> [1/1] fs/locks: Remove redundant assignment to cmd
>       commit: dc592190a5543c559010e09e8130a1af3f9068d3

Thanks Christian,

I had already picked it into the locks-next branch (though I didn't get
a chance to reply and mention that), but I'll drop it and plan to let
you carry it.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
