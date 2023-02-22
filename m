Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29BD69EC40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 02:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBVBPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 20:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:15:29 -0500
Received: from a8-40.smtp-out.amazonses.com (a8-40.smtp-out.amazonses.com [54.240.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05391286B;
        Tue, 21 Feb 2023 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gwkuid74newif2lbp44dedrl2t4vmmbs; d=benbenng.net; t=1677028526;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=2N33sN5thCynWPE60DlqxpC0OgmsekXy7CxhUOX758Q=;
        b=KrtWE4+8DY7dxlQ8l1g3gKRR90/NVDRUy/tedzlIPh0To01wwLAXwOPwNzHopwyM
        wjmt4RhXyrQJBe+YWGPlwDq0AntUj6sode8wK6GeP8Ko27kEi9qz9AJkVuoPaeBgFFQ
        eKFYLsp9Y1NDAUAc3ZoWyIQyVoTqbUsHEC0+CeuKfQsDzmeWeP/JvXnNmbB9BWxrKG2
        L3M1GrQLCCHr6onEcgpbkIaoMsX84tLo7mo52pWSQSuOjB/gqy2UyJcS9EyCWkojZCZ
        jnYEKk0Q8Lk1GwSbDUW2CRDlGVxeShsbjdngtA4u9Sx+HxVjIFx0hCKFtGTb7QBo9Bz
        BUolyqynTw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1677028526;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=2N33sN5thCynWPE60DlqxpC0OgmsekXy7CxhUOX758Q=;
        b=WgHNyHlFnt3oYCWjQcxQzLRty5Yzem10DVQxA8zAf+d1ityy5qSnnLS/3GBsEcwn
        2t1mRkpShjUAISYVSGqB8kMFk9xN+BSTV59U5ex4WKBbkieTmWeBtK3xgQ8mVy9EUkr
        GDKZTTXTvLNbzZxMm+tucFlxLeo3jwT+LK7dQ82E=
Subject: Re: [PATCH] Update documentation of vfs_tmpfile
From:   =?UTF-8?Q?Hok_Chun_NG_=28Ben=29?= <me@benbenng.net>
To:     =?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>
Cc:     =?UTF-8?Q?viro=40zeniv=2Elinux=2Eorg=2Euk?= 
        <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= 
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?linux-kernel=40vger=2Ekerne?= =?UTF-8?Q?l=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?skhan=40linuxfoundation=2Eorg?= 
        <skhan@linuxfoundation.org>
Date:   Wed, 22 Feb 2023 01:15:26 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y/TFdmhvrLu1h8Kl@debian.me>
References: <20230221035528.10529-1-me@benbenng.net> 
 <01000186721d17f8-ab0c64f0-a6ae-4e43-99a3-a44e6dba95b6-000000@email.amazonses.com> 
 <Y/TFdmhvrLu1h8Kl@debian.me> 
 <346A4D50-E68E-4D03-B06B-4949F5640197@benbenng.net>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AQHZRahkSbYuKExlQEa1ZMKqo2I0mwATxyTgACyv+PQ=
Thread-Topic: [PATCH] Update documentation of vfs_tmpfile
X-Original-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Wm-Sent-Timestamp: 1677028525
Message-ID: <0100018676b0882f-5895463a-0af2-4fae-9e0b-8d4676347b1f-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.02.22-54.240.8.40
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bagas,=0D=0A=0D=0A> On Feb 21, 2023, at 8:21 AM, Bagas Sanjaya <bagasd=
otme@gmail.com> wrote:=0D=0A>=20=0D=0A> On Tue, Feb 21, 2023 at 03:55:54A=
M +0000, Hok Chun NG (Ben) wrote:=0D=0A>> On function vfs_tmpfile, docume=
ntation is updated according to function signature update.=0D=0A>>=20=0D=0A=
>> Description for 'dentry' and 'open_flag' removed.=0D=0A>> Description =
for 'parentpath' and 'file' added.=0D=0A>=20=0D=0A> What commit did vfs_t=
mpfile() change its signature=3F=0D=0A=0D=0AChanges of the function signa=
ture is from 9751b338656f05a0ce918befd5118fcd970c71c6=0D=0Avfs: move open=
 right after ->tmpfile() by Miklos Szeredi mszeredi@redhat.com=0D=0A=0D=0A=
>=20=0D=0A> For the patch description, I'd like to write "Commit <commit>=
 changes=0D=0A> function signature for vfs_tmpfile(). Catch the function =
documentation=0D=0A> up with the change."=0D=0A=0D=0AI agree. Thank you f=
or the suggestion.=0D=0A=0D=0A>=20=0D=0A> Thanks.=0D=0A>=20=0D=0A> --=20=0D=
=0A> An old man doll... just what I always wanted! - Clara=0D=0A=0D=0ABes=
t,=0D=0ABen
