Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3065AB19
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jan 2023 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAATGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Jan 2023 14:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAATGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:06:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2573D8A;
        Sun,  1 Jan 2023 11:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E8BAB80918;
        Sun,  1 Jan 2023 19:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BBCC433EF;
        Sun,  1 Jan 2023 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672599968;
        bh=v/48WLw5b9kHI2kBsC/V9/Y84M/neLQ2uytuy7oB0VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAQlHQcAO2ymuKtvY8X2iXDJhTb4aTx6YfvnhiN4t078LjJS2ZMy70d35wI75fOD/
         3N39Oz/uxWUEskqh+cuzeKsIedWy4zDW9Btd6OsQ98jeVgHEM4Jf5rFj2EQDOcHlR7
         130NwIOTnc9dMTuSiuuqv7CxR2bly7G6Bl3w5rgYpqbo84jgs0z7janVUjVFrrFP86
         s9wW+DobPPZ1/GLdUQ7+gCBgBoO6qLHEaezhfTYVn6sJHRZPmolXsq/KGkeq/rr8z5
         Om5U3ZpV0WWV6S8nf0X96KPEMoEHpEn2+i60dvjZ9PKLDds7ZjHkuSwsfOaWhccxu9
         SmcOY0oAdxN8A==
Received: by pali.im (Postfix)
        id DD34C884; Sun,  1 Jan 2023 20:06:05 +0100 (CET)
Date:   Sun, 1 Jan 2023 20:06:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC PATCH v2 03/18] ntfs: Undeprecate iocharset= mount option
Message-ID: <20230101190605.s7jyf3umgubwrk3i@pali>
References: <20221226142150.13324-1-pali@kernel.org>
 <20221226142150.13324-4-pali@kernel.org>
 <CAC=eVgS7weRq7S16MpTyx9eZm=2s+OZhm6Ko75Z6bmjsHH-7Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=eVgS7weRq7S16MpTyx9eZm=2s+OZhm6Ko75Z6bmjsHH-7Yw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 01 January 2023 21:02:46 Kari Argillander wrote:
> 26.12.2022 klo 16.22 Pali Rohár (pali@kernel.org) wrote:
> >
> > Other fs drivers are using iocharset= mount option for specifying charset.
> > So mark iocharset= mount option as preferred and deprecate nls= mount
> > option.
> 
> snip.
> 
> > diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> 
> snip.
> 
> > @@ -218,10 +213,10 @@ static bool parse_options(ntfs_volume *vol, char *opt)
> >                 } else if (!strcmp(p, "utf8")) {
> >                         bool val = false;
> >                         ntfs_warning(vol->sb, "Option utf8 is no longer "
> > -                                  "supported, using option nls=utf8. Please "
> > -                                  "use option nls=utf8 in the future and "
> > -                                  "make sure utf8 is compiled either as a "
> > -                                  "module or into the kernel.");
> > +                                  "supported, using option iocharset=utf8. "
> > +                                  "Please use option iocharset=utf8 in the "
> > +                                  "future and make sure utf8 is compiled "
> > +                                  "either as a module or into the kernel.");
> 
> We do not have to make sure utf8 is compiled anymore as it "always is" right?

Yes, right, we have always utf8 support compiled-in.
Second part of that warning message should be dropped.

> >                         if (!v || !*v)
> >                                 val = true;
> >                         else if (!simple_getbool(v, &val))
