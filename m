Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF87B1C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjI1MX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjI1MX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:23:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D5193;
        Thu, 28 Sep 2023 05:23:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC5EC433C8;
        Thu, 28 Sep 2023 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695903834;
        bh=92GqEjcHHhcC9aZp0W6/CZRTL9qlQhm0KTV043dHYEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XTDkH57PssUlUSv0Jvyc9SagCGzcvMhOd4sBi8/QI9pAZAkZL9pATSA8bz+eSBJqG
         Uq8Nt392fjdttgOX2VLl8WesPHwtMj+6fto7C7j0lma6SMc6RTT/1Piq4K0c4F2cjL
         t70KI5J5u5sIvmT0HnKLOfoXJupZadpM+v3CcxJoTrJ+w88it+lFS4KqVZyRxyOpOk
         Gxcvklo4ZteTiJT6phKWH1fT+sWg3BDdkE0XjX8hPtQwNlvx1mMN/TXgWlTwkhY8+H
         2JDFfoGaxBK1qmcln+umq9NCP+faplkR088tMcQHWTcN5N8pSgqwaYG9LouGPqudWg
         phcVgA2T5s2dQ==
Message-ID: <e8d37c74110251f59ecb78ce64834ac46234d2df.camel@kernel.org>
Subject: Re: [PATCH 11/87] drivers/tty: convert to new inode {a,m}time
 accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Thu, 28 Sep 2023 08:23:52 -0400
In-Reply-To: <2023092858-paparazzi-budding-6c35@gregkh>
References: <20230928110300.32891-1-jlayton@kernel.org>
         <20230928110413.33032-1-jlayton@kernel.org>
         <20230928110413.33032-10-jlayton@kernel.org>
         <2023092858-paparazzi-budding-6c35@gregkh>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-09-28 at 14:13 +0200, Greg KH wrote:
> On Thu, Sep 28, 2023 at 07:02:20AM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> As much difficulty muti-subsystem patches are, we do need a changelog
> entry please.  Maybe some maintainers are nicer, but I can't ack a patch
> without any text here at all, sorry.
>=20
Ahh yes -- my bad. I'll add a boilerplate commit log for all of the
"convert to new inode {a,m}time accessors" patches.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
