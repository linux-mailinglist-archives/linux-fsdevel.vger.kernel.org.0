Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5665AC69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 00:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjAAXDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Jan 2023 18:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAXDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Jan 2023 18:03:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276BE2180;
        Sun,  1 Jan 2023 15:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCC3B80B50;
        Sun,  1 Jan 2023 23:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FFDC433EF;
        Sun,  1 Jan 2023 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672614176;
        bh=+APP+2lLo3YrbHdKAcC0k1slJXQMh+w4XYkOq5/C1X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWMwgUweTkeHMK8dctc9B+xEl3YOh4W7RtjJJmB2WK61ive8fBmz5b4hbLBCoOsyR
         abr0bR9SPGNsvphP3wElRI0rYsIwU25VzSXtdsli5N0hDzLYDH9zPAaqfaFvpSI9Nf
         RLPtSOc3eaYgaLnxh2fSquwoubmmrs8Z684b5M7pLCc9t4fiapsbDzmCyEyy9oLBNY
         9Iv2gIVaH3dQa7g9X1MCHWyPRSB9uGHKmHhcrJVLwm8fCXUN9BUZ3AMDVCLjv1omXg
         eeIJ7gpPcuQ1FNvrmoooKY34E4GWir7PEegHAoU1vmzhfDONozwujueB1qE/+uXGdu
         wwDn88iFMnbFw==
Received: by pali.im (Postfix)
        id 5B302884; Mon,  2 Jan 2023 00:02:53 +0100 (CET)
Date:   Mon, 2 Jan 2023 00:02:53 +0100
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
Message-ID: <20230101230253.qhhku7d42kyrbkst@pali>
References: <20221226142150.13324-1-pali@kernel.org>
 <20221226142150.13324-4-pali@kernel.org>
 <CAC=eVgS7weRq7S16MpTyx9eZm=2s+OZhm6Ko75Z6bmjsHH-7Yw@mail.gmail.com>
 <20230101190605.s7jyf3umgubwrk3i@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230101190605.s7jyf3umgubwrk3i@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 01 January 2023 20:06:05 Pali Rohár wrote:
> On Sunday 01 January 2023 21:02:46 Kari Argillander wrote:
> > 26.12.2022 klo 16.22 Pali Rohár (pali@kernel.org) wrote:
> > >
> > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > So mark iocharset= mount option as preferred and deprecate nls= mount
> > > option.
> > 
> > snip.
> > 
> > > diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> > 
> > snip.
> > 
> > > @@ -218,10 +213,10 @@ static bool parse_options(ntfs_volume *vol, char *opt)
> > >                 } else if (!strcmp(p, "utf8")) {
> > >                         bool val = false;
> > >                         ntfs_warning(vol->sb, "Option utf8 is no longer "
> > > -                                  "supported, using option nls=utf8. Please "
> > > -                                  "use option nls=utf8 in the future and "
> > > -                                  "make sure utf8 is compiled either as a "
> > > -                                  "module or into the kernel.");
> > > +                                  "supported, using option iocharset=utf8. "
> > > +                                  "Please use option iocharset=utf8 in the "
> > > +                                  "future and make sure utf8 is compiled "
> > > +                                  "either as a module or into the kernel.");
> > 
> > We do not have to make sure utf8 is compiled anymore as it "always is" right?
> 
> Yes, right, we have always utf8 support compiled-in.
> Second part of that warning message should be dropped.

Ok, this is truth after patch 15/18. So info about compiled module
should be dropped in patch 15/18, not in this one.

> > >                         if (!v || !*v)
> > >                                 val = true;
> > >                         else if (!simple_getbool(v, &val))
