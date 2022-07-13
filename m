Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B3572C35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 06:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGMEPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 00:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMEPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:15:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11625A851D
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 21:15:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bp15so7469250ejb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mR6ve7jNYBBEabfglRDxTAXQ9ivd99sGg14WaUcXb50=;
        b=hhbwjs19sFKxiC3MiE6IyuW8dbxbqAkAalzc4jUel4GHpRclUJwxyapuGsnji3fOkm
         jkw+kG3P7SYMvr3FhK53pEpM1WaDVkQz7NO2XQk9V4f632kNuPnEZx5lm6InnNrXr+il
         XO0dGVV4UuEze6c0FC7xP4vJ7LUt8YQEzHEA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mR6ve7jNYBBEabfglRDxTAXQ9ivd99sGg14WaUcXb50=;
        b=oMgSCIO+ScH9OopuiuE9OhvEU0ib0zxvoy7qLO8flHLvHFLmzkIVmm/ky30PJuUEAx
         l+cey3D12KsuvdKA6kvDzfm3UFyN6uLukdX0XYS0ReJX9tyl9bvIpGF35sUeDbGvkY2Q
         t+1PM609beCd3gjkykmbatfTD/dTWnM+x7WAQZDlE1g50QfsSBisvd8IBNFcJUgGnaCy
         iWs9MB7YqD3cEkDC5VdP3KquWg4Ek3OMsUjctWwrA2S7Vqw1XJlJPmQWI2pCndsgXusg
         FoOWddqi7yFqSY91F4RgwjoLD/f99T4b5W8H145RghK+cjiynCtSLoM4oJAFvdh/UhRy
         1Uyw==
X-Gm-Message-State: AJIora9VWzdWmxw+WqfIvft2MycWSj84d9Q1Uh+CpJxx3blCB4mOfm+F
        U8Lhg2JMtBT5KBxzBgF9sXI3fADjRB5+A1OjUUM=
X-Google-Smtp-Source: AGRyM1sDoey6fy30WmRFV9fzAGdk/uFWve1scJ27qy4TAYgqK30N2pURqxjp77PQYoTgBin8IPMOFg==
X-Received: by 2002:a17:907:2c54:b0:72b:64bd:cbf7 with SMTP id hf20-20020a1709072c5400b0072b64bdcbf7mr1452230ejc.116.1657685716310;
        Tue, 12 Jul 2022 21:15:16 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id l20-20020aa7d954000000b0042617ba638esm7054025eds.24.2022.07.12.21.15.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 21:15:14 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id h17so13810210wrx.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 21:15:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr1110292wrb.442.1657685714024; Tue, 12
 Jul 2022 21:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
In-Reply-To: <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 21:14:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEqAE3Fgx=1hoKEkTVhpm9YiLeROYGaQieRXagJLu8XA@mail.gmail.com>
Message-ID: <CAHk-=wgEqAE3Fgx=1hoKEkTVhpm9YiLeROYGaQieRXagJLu8XA@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 7:58 PM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Well, if you're supposed to be able to dedupe read-only files, then
> the whole "check for writing" is just bogus to begin with.

Hmm. Maybe that's too strong. The "if you can write to it, you can
always dedup it" does make sense, and then couple that with "other
situations are also ok".

And if you were to want to dedup things like symlinks (do people?) you
need to be able to handle FMODE_PATH cases that aren't FMODE_WRITE.

And at that point, the "inode owner" check starts making sense.

Except the code doesn't allow symlinks anyway right now, so that's
kind of theoretical.

But then you really do need to check for IS_IMMUTABLE there too and
that it's a valid file type, and not just hope that it's checked for
elsewhere. And those checks shouldn't pass just because of
CAP_SYS_ADMIN, so that check seems to be in the wrong place too.

So maybe it mostly works (apart from how clearly the destination
offset alignment check is somehow missing or done too late or
whatever), but it all seems very random, with checks spread out and
not with any consistency or logic.

As an example of this randomness, for the dedup source file, we have
three different error returns for checking whether it's ok in
vfs_dedupe_file_range(*):

        if (S_ISDIR(src->i_mode))
                return -EISDIR;

        if (!S_ISREG(src->i_mode))
                return -EINVAL;

        if (!file->f_op->remap_file_range)
                return -EOPNOTSUPP;

but then for the destination check the code does

        ret = -EISDIR;
        if (S_ISDIR(file_inode(dst_file)->i_mode))
                goto out_drop_write;

        ret = -EINVAL;
        if (!dst_file->f_op->remap_file_range)
                goto out_drop_write;

and again - maybe this works, and it's just that the error return is
inconsistent for source-vs-target, but it just reinforces that whole
"this is all completely ad-hoc and doesn't really make much sense".

            Linus
