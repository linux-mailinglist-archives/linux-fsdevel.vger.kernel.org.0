Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7929869D9E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 04:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjBUD4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 22:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBUDz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:55:58 -0500
Received: from a11-6.smtp-out.amazonses.com (a11-6.smtp-out.amazonses.com [54.240.11.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF520543;
        Mon, 20 Feb 2023 19:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gwkuid74newif2lbp44dedrl2t4vmmbs; d=benbenng.net; t=1676951754;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=wWuGziIX9fQkIFd9rl78n1jnQkCVXJxJDq0c7atPrmc=;
        b=Jp4qtkqwuU5YZyleeZXBwsc2YmCFdZ65s1Dv+2ES2+GphHVSjXFRwz2NRXkuM4ki
        aq5w6vfVCh4mucVjSfP26biBteYHlA7aWSy7XrPSJmD5a7WxGW44ESBtZKRbi96q9UP
        CvJUGJgC1kV9/JwAJ9DSC1RwLxcam72xj6YZKsHZv47o2mSRX036PnUI0FOuaNAITci
        A0GXEAnMqiCN52lcWivpcIELTFf4ciTx/fXpvusnkmv7dMUnMZ81KxFuwnVzi8EDXJE
        vYf97mazFnuyo0o8CSPssJJLW8loKVcGJmoWQzV4E4+iwlwSW4AaV+SAvo7zYge7IGP
        KGWUmjAo8A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1676951754;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=wWuGziIX9fQkIFd9rl78n1jnQkCVXJxJDq0c7atPrmc=;
        b=b/Ce05Zyqwn8gBihrcqH1JmyjNcYPJnm0NDrEXbZTqG+uxXjFkS58q0QFwYtO7zo
        WjXFVs+tGu/V/9QIR7ZYO8MRd/py5EGWS2r/9bfqxrcxkym0DR0ZVqQpSdQZ/zpsYcW
        u2EUdBqChhVr1OXnBe59f4y5CyYO5+WaLWHfDddQ=
Subject: [PATCH] Update documentation of vfs_tmpfile
From:   =?UTF-8?Q?Hok_Chun_NG_=28Ben=29?= <me@benbenng.net>
To:     =?UTF-8?Q?viro=40zeniv=2Elinux=2Eorg=2Euk?= 
        <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Hok_Chun_NG_=28Ben=29?= <me@benbenng.net>,
        =?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= 
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?linux-kernel=40vger=2Ekerne?= =?UTF-8?Q?l=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?skhan=40linuxfoundation=2Eorg?= 
        <skhan@linuxfoundation.org>
Date:   Tue, 21 Feb 2023 03:55:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20230221035528.10529-1-me@benbenng.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZRahkSbYuKExlQEa1ZMKqo2I0mw==
Thread-Topic: [PATCH] Update documentation of vfs_tmpfile
X-Original-Mailer: git-send-email 2.34.1
X-Wm-Sent-Timestamp: 1676951753
Message-ID: <01000186721d17f8-ab0c64f0-a6ae-4e43-99a3-a44e6dba95b6-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.02.21-54.240.11.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On function vfs_tmpfile, documentation is updated according to function s=
ignature update.=0D=0A=0D=0ADescription for 'dentry' and 'open_flag' remo=
ved.=0D=0ADescription for 'parentpath' and 'file' added.=0D=0A=0D=0ASigne=
d-off-by: Ben Hok-Chun NG <me@benbenng.net>=0D=0A---=0D=0A fs/namei.c | 4=
 ++--=0D=0A 1 file changed, 2 insertions(+), 2 deletions(-)=0D=0A=0D=0Adi=
ff --git a/fs/namei.c b/fs/namei.c=0D=0Aindex 309ae6fc8c99..21261163d6d3 =
100644=0D=0A--- a/fs/namei.c=0D=0A+++ b/fs/namei.c=0D=0A@@ -3571,9 +3571,=
9 @@ static int do_open(struct nameidata *nd,=0D=0A /**=0D=0A  * vfs_tmpf=
ile - create tmpfile=0D=0A  * @mnt_userns:=09user namespace of the mount =
the inode was found from=0D=0A- * @dentry:=09pointer to dentry of the bas=
e directory=0D=0A+ * @parentpath: path to the base directory=0D=0A+ * @fi=
le:  =09pointer to the file struct of the new tmpfile=0D=0A  * @mode:=09m=
ode of the new tmpfile=0D=0A- * @open_flag:=09flags=0D=0A  *=0D=0A  * Cre=
ate a temporary file.=0D=0A  *=0D=0A--=20=0D=0A2.34.1=0D=0A=0D=0A
