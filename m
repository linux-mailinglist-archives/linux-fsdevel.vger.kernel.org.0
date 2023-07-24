Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563EA75EB09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 07:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGXFwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 01:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXFwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:52:36 -0400
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8112D;
        Sun, 23 Jul 2023 22:52:31 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690177935tjo28npk
Received: from winn-pc ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 24 Jul 2023 13:52:13 +0800 (CST)
X-QQ-SSF: 01400000000000F0I000000A0000000
X-QQ-FEAT: 6/K5pWSRdGoA92tgojH97Ase+aAEO8iyNdq7hcZ1PM+BaH8EALhPKTnHAjbzp
        agQqZJdutlydQJxkGwYkxKrY7wQE3H29Azez6cg7iBhDeczT1dcPxHXe47d/QgY+R/pt7dp
        2X4sUFM2L7QCp4kojcwDGXyjm6+Cu67vwtqkQxzJghE2asNuPkl3kp9Kf6oDaEU+G7Lyl0R
        wQ5JWbP+B4VN7vgUpp0yYcTG8sjXUI9vcWQ1qhvt/4zORfiR0uJCBL59mgD8MiYeRTleza9
        BdG3pXz3Mv+vbyw23mechWODd03p4e4mNm172o5XRo6mXkv6QJjSlpclS6EyZnAv8uMkyLR
        eFQ53FGSj8FJdMUSVYb6jgEfP+lP7tpCSejRn8DIV+6GSRu9UfP2n2LxJ7ivTq19mip0WKb
        FwvMFZOqEs0=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16691690126345812283
Date:   Mon, 24 Jul 2023 13:52:13 +0800
From:   Winston Wen <wentao@uniontech.com>
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs/nls: make load_nls() take a const parameter
Message-ID: <D82D5126DA51606D+20230724135213.0b47a9c6@winn-pc>
In-Reply-To: <ebe13d43277d359ae5ce16008930ad13.pc@manguebit.com>
References: <20230720063414.2546451-1-wentao@uniontech.com>
        <ebe13d43277d359ae5ce16008930ad13.pc@manguebit.com>
Organization: Uniontech
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Jul 2023 14:36:54 -0300
Paulo Alcantara <pc@manguebit.com> wrote:

> Winston Wen <wentao@uniontech.com> writes:
> 
> > load_nls() take a char * parameter, use it to find nls module in
> > list or construct the module name to load it.
> >
> > This change make load_nls() take a const parameter, so we don't
> > need do some cast like this:
> >
> >         ses->local_nls = load_nls((char *)ctx->local_nls->charset);
> >
> > Also remove the cast in cifs code.
> >
> > Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Winston Wen <wentao@uniontech.com>
> > ---
> >  fs/nls/nls_base.c       | 4 ++--
> >  fs/smb/client/connect.c | 2 +-
> >  include/linux/nls.h     | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)  
> 
> Changes look good, however you should probably get rid of the cifs.ko
> changes in this patch and for the cifs.ko one, you could resend
> without the casts.
> 

Make sense. I've resent the patch, thanks!

-- 
Thanks,
Winston

