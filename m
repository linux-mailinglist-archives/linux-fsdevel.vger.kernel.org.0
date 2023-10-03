Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CC7B6ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjJCNs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJCNs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:48:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CDAF;
        Tue,  3 Oct 2023 06:48:25 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d865854ef96so971475276.2;
        Tue, 03 Oct 2023 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696340904; x=1696945704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTL7t9w9ALMJLgtOyBmqJM7HLzstsLdcFcnthxBVdFE=;
        b=bAn4CxUMUbprdEghgaA5GBeV1+ZB2iIKMnzCAQk7bVsMwX81jpFS2oz7AiFWk7G2ny
         GDS5LQZHlep0e5zUNOSfTyjpZpAfMV7G+Zl7SFmTu+dVkuFT3IQMKvfeA0wPZmFBwH5/
         IpMwxucq5janyNIcCeCp8JZ2sbJBk555X/ie8Mr3uhVYyF1P0veIOzjRQsh0Wc/9cZaF
         eIuUa7mh9EamzQs1jYWMIzDJ6ngq1dSnbVZg2SCVUzEwyrv3u7x7FgymUyaQnCfVSCwm
         pruO22s1DZ4gZODfw27LLHuBHmcmyU2FZhm6seXjzm4YFZNm1Yy76I4L6oumaqxWGcRW
         OdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340904; x=1696945704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTL7t9w9ALMJLgtOyBmqJM7HLzstsLdcFcnthxBVdFE=;
        b=SBjwnzv8g8AN2OBP5EeQ/E4pEhG9qRxfpuwA4H+oyMVwr85gGlhVCniDQNhon4FM3o
         +B5rRXIqsw9GJWji5wRxcFd0+0PIO4t/1wSnq4CEnJ5T+IGpBP1dYRQ6UBVi4Qr7pIcR
         RgnhOqYgg5mE9GroYgwPTFLEo294MHLhtx65ckWdcrIvPcnH7MaUqHs99/5mk1Rul6kI
         AY+JSSpcW5TLyIcp6oeDBoaKrj+fiKRcMZgPgiawYs5EOAVpVN9NUOeMtWHv/YIZgTUT
         1sZX2040+OAIF4Y+hxZP8U/Uz4cFjJh3bfv1wvNwnoRpcZPx1Dnep6S7OYFjRpwxwI5W
         jxnQ==
X-Gm-Message-State: AOJu0YysWh+ZnGqNJbUeNvpgBUw1AgzGGS1Ijn4zgCu290GzNtWkiJet
        jLl6I9WsOgdQb5ea6kddR+oicO1L/dKbEJroA0U=
X-Google-Smtp-Source: AGHT+IH4ma5RxQp4wl/uNIM1+Hq/uOfBTpO86gPXHq6xU0DsT1rEl0VRIRrNH1HflEn5hqN/SG5ufMing2WZBeL9Eqc=
X-Received: by 2002:a5b:a:0:b0:d85:af36:4b6f with SMTP id a10-20020a5b000a000000b00d85af364b6fmr12897775ybp.21.1696340904293;
 Tue, 03 Oct 2023 06:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-6-wedsonaf@gmail.com>
 <20231002112858.GK13697@twin.jikos.cz> <20231002113752.GL13697@twin.jikos.cz>
In-Reply-To: <20231002113752.GL13697@twin.jikos.cz>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 3 Oct 2023 10:48:14 -0300
Message-ID: <CANeycqpE1R=6f_9GZKTx+D4LBdkc496wcXrHOTHAKcdkssMi9Q@mail.gmail.com>
Subject: Re: [PATCH 05/29] btrfs: move btrfs_xattr_handlers to .rodata
To:     dsterba@suse.cz
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Oct 2023 at 08:44, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Oct 02, 2023 at 01:28:58PM +0200, David Sterba wrote:
> > On Sat, Sep 30, 2023 at 02:00:09AM -0300, Wedson Almeida Filho wrote:
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > >
> > > This makes it harder for accidental or malicious changes to
> > > btrfs_xattr_handlers at runtime.
> > >
> > > Cc: Chris Mason <clm@fb.com>
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: David Sterba <dsterba@suse.com>
> > > Cc: linux-btrfs@vger.kernel.org
> > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With slightly updated changelog added to misc-next, thanks.
>
> Removed again. I did not notice first that this is part of a larger
> series, please also CC the [PATCH 0/N] patch.

Sorry for the confusion, I will CC you there too.

> There's a warning:
>
> fs/btrfs/super.c: In function =E2=80=98btrfs_fill_super=E2=80=99:
> fs/btrfs/super.c:1107:21: warning: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>  1107 |         sb->s_xattr =3D btrfs_xattr_handlers;
>       |                     ^
>
> but the patch changing the type is present in the series.
>
> Please update the changelog of btrfs patch with:
>
>     Add const specifier also to the pointed array members of
>     btrfs_xattr_handlers.  This moves the whole structure to the .rodata
>     section which makes it harder for accidental or malicious changes to
>     btrfs_xattr_handlers at runtime.

Will do. Thanks!

> or use it for others patches too.
