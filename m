Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374A45AB69D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiIBQeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIBQeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:34:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE601E3423;
        Fri,  2 Sep 2022 09:34:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w2so3479971edc.0;
        Fri, 02 Sep 2022 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=O449YcYH9q7gH2mEno9n2yuVujMbIs6p2uSiFJh8cBA=;
        b=I/0/Y8UpKxG7/PflS2defFFih4V+2+5MYyJjUnUaEi7ktxFmKRbyEEw4/M1jzkcdgj
         bfIYPnTHE+rin85If6TnRetsHOMiGt+aCOR73ICmRBV1FKGCmAxmuCNPlRRb6GTMkv+S
         qgOcVdSTNCLqF8w+PyqndpEed8g7Ak1SfmeJh7bv+qN+2Uia+/cu4r7/TffD6qqzPCwh
         SDL7cItq5zGywBSoLKJBCP2L94ho2uGYmpHYntSMV4ck22Wx0ZH6A0giEwnpBhRcNRFI
         zN51zhacMrw3KeWNhR00otvCMP7gTS/d7ihDuzQdHYcAJXYjWZSH0xB9HHe5RutcitZk
         edHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=O449YcYH9q7gH2mEno9n2yuVujMbIs6p2uSiFJh8cBA=;
        b=2s+mIfS+YKMrShnfcKscslVBvjxOP0lLhJRL40TgvULONzhmm4o6+8Rtqz3nZzRUb1
         hO0se00Jq5Hk+G5rSZjSvIZ3cU+RlNx6pwfvr5G6NRXtM+eJCe+y3RJEYTbDElwax2Mv
         eBmg5Vu9IXLAxrYihc6Jt39DMMnwlLFGja1qBZEMkS7/h3S5NZ4UhG5DVuT8gVLbz5GC
         6dq43XwVjuXJtksoUEklWA6Y9/g19Otglat4YJVurPK5XxT0DSCapNanyubAx3Z3Dxvg
         oPG+KFI35xa9eqrcmikKX2DktUvCFFE9iuh/swQ3yoAjjp45otrEvpVmj4FCEk8Rwhfa
         ybvg==
X-Gm-Message-State: ACgBeo1wm6wiE2cytPFpLcVgYX3zplegmVzUywm5jORF7Pi+dZOmc6D9
        9mF6ZA0RA+b/IyCinAqinHWk0duneyk=
X-Google-Smtp-Source: AA6agR7HoetLg0XJNSpGggTo/ASU4vtsmY65pB9Rmn54FZQdKh0s2ceRYpB0FdspkTf8Duuo1hbrJQ==
X-Received: by 2002:aa7:c3c2:0:b0:447:7d68:7187 with SMTP id l2-20020aa7c3c2000000b004477d687187mr33072826edr.400.1662136462094;
        Fri, 02 Sep 2022 09:34:22 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090778c800b00741b368a448sm1437943ejc.203.2022.09.02.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:34:21 -0700 (PDT)
Date:   Fri, 2 Sep 2022 18:34:19 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v5 0/4] landlock: truncate support
Message-ID: <YxIwi9uss1CbKWia@nuc>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
 <YxGVgfcXwEa+5ZYn@nuc>
 <YxGfxo87drkAjWGf@nuc>
 <68c65a52-4fa1-d2fb-f571-878f9f4658ba@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c65a52-4fa1-d2fb-f571-878f9f4658ba@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:40:57AM +0200, Mickaël Salaün wrote:
> On 02/09/2022 08:16, Günther Noack wrote:
> > On Fri, Sep 02, 2022 at 07:32:49AM +0200, Günther Noack wrote:
> > > On Thu, Sep 01, 2022 at 07:10:38PM +0200, Mickaël Salaün wrote:
> > > > Hmm, I think there is an issue with this series. Landlock only enforces
> > > > restrictions at open time or when dealing with user-supplied file paths
> > > > (relative or absolute).
> > >
> > > Argh, ok. That sounds like a desirable property, although it would
> > > mean reworking the patch set.
> > >
> > > > The use of the path_truncate hook in this series
> > > > doesn't distinguish between file descriptor from before the current sandbox
> > > > or from after being sandboxed. For instance, if a file descriptor is
> > > > received through a unix socket, it is assumed that this is legitimate and no
> > > > Landlock restriction apply on it, which is not the case with this series
> > > > anymore. It is the same for files opened before the process sandbox itself.
> > > >
> > > > To be able to follow the current semantic, I think we should control the
> > > > truncate access at open time (or when dealing with a user-supplied path) but
> > > > not on any file descriptor as it is currently done.
> > >
> > > OK - so let me try to make a constructive proposal. We have previously
> > > identified a few operations where a truncation happens, and I would
> > > propose that the following Landlock rights should be needed for these:
> > >
> > > * truncate() (operating on char *path): Require LL_ACCESS_FS_TRUNCATE
> > > * ftruncate() (operating on fd): No Landlock rights required
> > > * open() for reading with O_TRUNC: Require LL_ACCESS_FS_TRUNCATE
> > > * open() for writing with O_TRUNC: Require LL_ACCESS_FS_WRITE_FILE
> >
> > Thinking about it again, another alternative would be to require
> > TRUNCATE as well when opening a file for writing - it would be
> > logical, because the resulting FD can be truncated. It would also
> > require people to provide the truncate right in order to open files
> > for writing, but this may be the logical thing to do.
>
> Another alternative would be to keep the current semantic but ignore file
> descriptors from not-sandboxed processes. This could be possible by
> following the current file->f_mode logic but using the Landlock's
> file->f_security instead to store if the file descriptor was opened in a
> context allowing it to be truncated: file opened outside of a landlocked
> process, or in a sandbox allowing LANDLOCK_ACCESS_FS_TRUNCATE on the related
> path.

I'm not convinced that it'll be worth distinguishing between a FD
opened for writing and a FD opened for writing+truncation. And whether
the FD is open for writing is already tracked by default and
ftruncate() checks that.

I'm having a hard time constructing a scenario where write() should be
permitted on an FD but ftruncate() should be forbidden. It seems that
write() is the more dangerous operation of the two, with more
potential to modify a file to one's liking, whereas the modifications
possible through TRUNCATE are relatively benign?

The opposite scenario (where ftruncate() is permitted and write() is
forbidden) simply can't exist because an FD must already be writable
in order to use ftruncate(). (see man page)

Additionally, if we recall previous discussions on the truncate patch
sets, there is the very commonly used creat() syscall (a.k.a. open()
with O_CREAT|O_WRONLY|O_TRUNC), which anyway requires the Landlock
truncate right in many cases. So I still think you can't actually use
LANDLOCK_ACCESS_FS_FILE_WRITE without also providing the
LANDLOCK_ACCESS_FS_TRUNCATE right?

In conclusion, I'd be in favor of not tracking the truncate right
separately as a property of an open file descriptor. Does that
rationale sound reasonable?

--
