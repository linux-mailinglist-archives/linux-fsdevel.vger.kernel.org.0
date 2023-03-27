Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C436CA173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjC0Ka3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjC0KaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C874EE0;
        Mon, 27 Mar 2023 03:29:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t4so2955088wra.7;
        Mon, 27 Mar 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5zyRX9jTviyo1Dx9t8vLJcjdc0SG5rNaycuMWcJlLg=;
        b=UDHgz4cxab5feIORZX3F25qv9WENcYmtDJe25twFo2VvaNW89qKQUa0/gNyZlYu3XM
         wV68K/A5OUC4xlVHItqZxkbOeUI7xT/yZDeeDzo/xe90GQS7c1X64c7RZ1b9Xgku0jPp
         MoivC2YMeLf2d5FXk+VDJm02TtW4qnALGLKR7zx01ylRw+/JmAX4PMgMcfihkGipcCly
         ayoOekvK8UoR/ojNRgs55i5amIeiQvkZIJaVxkzlBKKsrNNJLqvKfOOhmDK7MdeZm/Az
         EaGyyeCQE2/YILNoiXau9ABS9FjR64BCIMxZ2qGpGKyemRhdjQJC5iG0syecmMwTtnSC
         Y0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5zyRX9jTviyo1Dx9t8vLJcjdc0SG5rNaycuMWcJlLg=;
        b=f+uhoU5oUKmeU5O/yNZKMZ7GUrTBF7fUIiM1BZ16q70zvkCTiu0TnfvoYJSmnV6MYh
         YhZ1ZqWYAiTSP+h7xWNuZv6CzqYR8XPODiYzx0tPHPzSLqV1O3LOSGQIzs2MMCF46VT1
         4SUyAwuur1iCDZkM+VKwTONS3FlEa3BetfEPb5OpUjAaQ/nvLabi+xd2A/vGlUURamL9
         y5HyuMEfl1cpAJMEboFWyyw79QuzXKsiUKsdvjvt8NUgqBlSGROCShLBvnXu1H84yE2N
         lvc3+pEoiGhoWQAKGhxnJ9g9JkHlobge4nDjDwpcqnBjtunoDMaiMSNfqLamTj1x/CEA
         APGA==
X-Gm-Message-State: AAQBX9fuSQoQ5jFU3adUgfg9aaeFbtQFLYnQsOiEQrb12mhzQDZSWmAo
        4LJZDXqAuNTfehr/IjPGOLD3DAmWETk=
X-Google-Smtp-Source: AKy350ZPjl/08pezQeruZG0b4q+mmoNTCySzvL2wRtYYALVnhJvifq1HSCyZVcpESuK3WKv6ol373A==
X-Received: by 2002:a05:6000:1048:b0:2ce:d84d:388f with SMTP id c8-20020a056000104800b002ced84d388fmr8798224wrx.40.1679912997962;
        Mon, 27 Mar 2023 03:29:57 -0700 (PDT)
Received: from suse.localnet (host-87-19-99-235.retail.telecomitalia.it. [87.19.99.235])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b002cfed482e9asm24784655wro.61.2023.03.27.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:29:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Mon, 27 Mar 2023 12:29:56 +0200
Message-ID: <3307436.0oRPG1VZx4@suse>
In-Reply-To: <20230320124725.pe4jqdsp4o47kmdp@quack3>
References: <Y/gugbqq858QXJBY@ZenIV> <4214717.mogB4TqSGs@suse>
 <20230320124725.pe4jqdsp4o47kmdp@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On luned=EC 20 marzo 2023 13:47:25 CEST Jan Kara wrote:
> On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> > On gioved=EC 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> > > On gioved=EC 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > > On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:

[snip]

> > > > > > I think I've pushed a demo patchset to vfs.git at some point ba=
ck=20
in
> > > > > > January... Yep - see #work.ext2 in there; completely untested,
> > > > > > though.

Al,

I reviewed and tested your patchset (please see below).

I think that you probably also missed Jan's last message about how you pref=
er=20
they to be treated.

Jan asked you whether you will submit these patches or he should just pull=
=20
your branch into his tree.

Please look below for my tags and Jan's question.

> > > > >=20
> > > > > The following commits from the VFS tree, #work.ext2 look good to =
me.
> > > > >=20
> > > > > f5b399373756 ("ext2: use offset_in_page() instead of open-coding =
it=20
as
> > > > > subtraction")
> > > > > c7248e221fb5 ("ext2_get_page(): saner type")
> > > > > 470e54a09898 ("ext2_put_page(): accept any pointer within the pag=
e")
> > > > > 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with
> > >=20
> > > page_addr")
> > >=20
> > > > > 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need
> > >=20
> > > page_addr
> > >=20
> > > > > anymore")
> > > > >=20
> > > > > Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > >=20
> > > > Thanks!
> > > >=20

[snip]
=20
> > OK, I could finally run my tests to completion and had no crashes at al=
l.=20
I
> > ran "./check -g quick" on one "test" + three "scratch" loop devices
> > formatted
> > with "mkfs.ext2 -c". I ran three times _with_ and then three times=20
_without_
> > Al's following patches cloned from his vfs tree, #work.ext2 branch:
> >=20
> > f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as
> > subtraction")
> > c7248e221fb5 ("ext2_get_page(): saner type")
> > 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
> > 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with=20
page_addr")
> > 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need
> >=20
> > All the six tests were no longer killed by the Kernel :-)
> >=20
> > I got 144 failures on 597 tests, regardless of the above listed patches.
> >=20
> > My final conclusion is that these patches don't introduce regressions. =
I=20
see
> > several tests that produce memory leaks but, I want to stress it again,=
=20
the
> > failing tests are always the same with and without the patches.
> >=20
> > therefore, I think that now I can safely add my tag to all five patches
> > listed above...
> >=20
> > Tested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Thanks for the effort! Al, will you submit these patches or should I just
> pull your branch into my tree?
>=20
> 							=09
Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks,

=46abio



