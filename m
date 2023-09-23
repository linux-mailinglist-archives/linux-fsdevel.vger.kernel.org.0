Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6B7ABE28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 09:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIWHAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 03:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIWHAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:00:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDD199;
        Sat, 23 Sep 2023 00:00:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-774105e8c81so176108885a.3;
        Sat, 23 Sep 2023 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695452402; x=1696057202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcnYbvS5MK6GuTtXypuDsEXHQd3nYjUtnq+MVVoDLKA=;
        b=GJNAHCnb6x2Um5FVft6CRxSZusS0gEHiA1ktiho+VkWGLMVXPNA3PhDDLoUAH9nSnz
         DUR5xj9vLRPIGVji/grhQycf8HjdpShDrag28c5BaZkGQX8Cd3tUG8V7p2BgYPdE50ty
         zMNa/nRdoNr1uq5dxQ60jxWMBxkAWbCwhzo0PW1weYqGz5G1QXvqx5oKW7rV8lbPivds
         Ka6+VY1gCX6tsXZfOECpOy/vKTAWhJi2YCNYUXfPXvE06JTgQcgFKdm/oquBZt3qPzYq
         VnWKQpe31lDoltTwfUe2zvYWMjNf8fUGU63PO8e1ArPzSTJMjoMyYF7Jv5lAsbWDm40o
         55Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695452402; x=1696057202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcnYbvS5MK6GuTtXypuDsEXHQd3nYjUtnq+MVVoDLKA=;
        b=nN2oAeVTULLabF1e8628FJU/1pH6s7qSAE1nkvCAwmykwj05Z5bCWRECuGHQZMVd7n
         ri0vzpJ5eLdnWjG3+DD4z3dDxc5UJp4Vf+HudLa9mob+GpX/gSRth9qV9v6IKlY2vv4R
         Kiz/67mgRhbljQdWrV3tqSOvHTwlCH95xyKNC2PFxNgW1uvilYsGBTlnIIq2SZT0ee5J
         BYS/FZXhi12BY7HQPhVzyQZn25vgTffSbWGZKl9Zj+fmYf/yGkXgqmSFj0oLzFtiOvak
         50yV9w0jPuJGCPGPdbauxLvWd83wpF3RmAY9ulGyMFAOfVKj1wsO1UM/MIhmLt/LA0tE
         k0Jg==
X-Gm-Message-State: AOJu0Yw82/3LTVXinVlOrfJ0bFW+/3th6SgVwJsnQ1Ok4x0aAxTb+aym
        fGtg9LfaBhM3uTBqQ/UJ8hhNPsYp3DtZ7n32rLw=
X-Google-Smtp-Source: AGHT+IFMxTVXVKT+nznCbj1bmQxWY2DbB+LZ7TuCR7qcNktIseQwd/89E9HbXm65hYtHy2dHcCCUdURKinwtHDaGpS8=
X-Received: by 2002:a05:620a:4487:b0:774:165a:6990 with SMTP id
 x7-20020a05620a448700b00774165a6990mr1758934qkp.20.1695452402627; Sat, 23 Sep
 2023 00:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230920222231.686275-1-dhowells@redhat.com> <591a70bf016b4317add2d936696abc0f@AcuMS.aculab.com>
 <1173637.1695384067@warthog.procyon.org.uk>
In-Reply-To: <1173637.1695384067@warthog.procyon.org.uk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 23 Sep 2023 08:59:25 +0200
Message-ID: <CAF=yD-L3aXM17=hsJBoauWJ6Dqq16ykcnv8sg-Fn_Td_FsOafA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] iov_iter: Convert the iterator macros into
 inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 2:01=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> David Laight <David.Laight@ACULAB.COM> wrote:
>
> > >  (8) Move the copy-and-csum code to net/ where it can be in proximity=
 with
> > >      the code that uses it.  This eliminates the code if CONFIG_NET=
=3Dn and
> > >      allows for the slim possibility of it being inlined.
> > >
> > >  (9) Fold memcpy_and_csum() in to its two users.
> > >
> > > (10) Move csum_and_copy_from_iter_full() out of line and merge in
> > >      csum_and_copy_from_iter() since the former is the only caller of=
 the
> > >      latter.
> >
> > I thought that the real idea behind these was to do the checksum
> > at the same time as the copy to avoid loading the data into the L1
> > data-cache twice - especially for long buffers.
> > I wonder how often there are multiple iov[] that actually make
> > it better than just check summing the linear buffer?
>
> It also reduces the overhead for finding the data to checksum in the case=
 the
> packet gets split since we're doing the checksumming as we copy - but wit=
h a
> linear buffer, that's negligible.
>
> > I had a feeling that check summing of udp data was done during
> > copy_to/from_user, but the code can't be the copy-and-csum here
> > for that because it is missing support form odd-length buffers.
>
> Is there a bug there?
>
> > Intel x86 desktop chips can easily checksum at 8 bytes/clock
> > (But probably not with the current code!).
> > (I've got ~12 bytes/clock using adox and adcx but that loop
> > is entirely horrid and it would need run-time patching.
> > Especially since I think some AMD cpu execute them very slowly.)
> >
> > OTOH 'rep movs[bq]' copy will copy 16 bytes/clock (32 if the
> > destination is 32 byte aligned - it pretty much won't be).
> >
> > So you'd need a csum-and-copy loop that did 16 bytes every
> > three clocks to get the same throughput for long buffers.
> > In principle splitting the 'adc memory' into two instructions
> > is the same number of u-ops - but I'm sure I've tried to do
> > that and failed and the extra memory write can happen in
> > parallel with everything else.
> > So I don't think you'll get 16 bytes in two clocks - but you
> > might get it is three.
> >
> > OTOH for a cpu where memcpy is code loop summing the data in
> > the copy loop is likely to be a gain.
> >
> > But I suspect doing the checksum and copy at the same time
> > got 'all to complicated' to actually implement fully.
> > With most modern ethernet chips checksumming receive pacakets
> > does it really get used enough for the additional complexity?
>
> You may be right.  That's more a question for the networking folks than f=
or
> me.  It's entirely possible that the checksumming code is just not used o=
n
> modern systems these days.
>
> Maybe Willem can comment since he's the UDP maintainer?

Perhaps these days it is more relevant to embedded systems than high
end servers.
