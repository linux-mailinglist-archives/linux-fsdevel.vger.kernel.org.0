Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD377371E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHHCvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 22:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHHCvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:51:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C9170B;
        Mon,  7 Aug 2023 19:50:56 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-584034c706dso55058107b3.1;
        Mon, 07 Aug 2023 19:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691463055; x=1692067855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To5RXdgTZuuS1AHvSrlZPoAVtMBfYbQuZKe1V5PCHGU=;
        b=hk+jDZrl3g+o4sMGmZCabtN/5AnLtuwYSMj/gPgSP5jEYRltMDEp8gR1KR3PAoQdbl
         1mPD04e7QwuBYp8dQtUhan7IrsHCz9nRfLpKT2kV9/mlU+mh7iLzNzoUSrFPVWwipOD6
         q1TBPuDV4nRSRSBp4V/lOBEhKgMReru3RolSHSEN0f12SXGiqxPgWA4lemQjUrXgfP0b
         9eSMaS0Lrlh3Hp5R6eNkjFGOMxplIuqi6pgCBrEZ/rsfKVThX0JpHq6AykEIQJrm9ZkH
         +wvjvoi0OZeiAqnoiw+ZytKa3+4s6OOqLNTXelwoIk85Wm8mUEBMLgOG45iVyn8pij86
         aDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691463055; x=1692067855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To5RXdgTZuuS1AHvSrlZPoAVtMBfYbQuZKe1V5PCHGU=;
        b=bELrtQzxC4At6Lwiy4SJBZJAu4PeUCb52wVuJBJ5aXRwOzA85NN9dBfk09U3yIdPpI
         g3oHd5bJ4kmgF4c2vF/lj+RCOD2bsPrVdJqSPFAkObA4jeb9hfHlsVbIDSrvwHvK0n+p
         GBaeaUAjU9DgR0VNBwOS7JxWAq/9Lk8pnqDGmSbitOI7rQYQ9DkwbGuJXFmmDsmR/3Tx
         yr/qaAwK72bLkef8wKlt+j5nm1OI0O+nSktPlQONUhNrZMfzCemAxNlofyM/hO6KzsR9
         hiUIrIWnoUMhH0vmOjlrpRK8XIxCAW7a4FuP0kvr3spU0pXYD7wqv0Yd/fwYZOep9QAc
         ZsTA==
X-Gm-Message-State: AOJu0Yxkk0AfNa5PhQSeKsN8IE267GMMAsfpWGstFOoq5S0tj2NRQZrm
        LcCp+8WOOkE4BwQOcJGzKJoYCFxWXyzhYXMBiD8=
X-Google-Smtp-Source: AGHT+IHSbsxoEBIVRycBoxXUeft0G8ZFjbq4hkHa5qDquFTqGRH0j9u4YIDSq+t+KyYatv1w3tPVNwgPVd1vEaLOCH8=
X-Received: by 2002:a0d:cac5:0:b0:577:d44:a163 with SMTP id
 m188-20020a0dcac5000000b005770d44a163mr11720738ywd.6.1691463055272; Mon, 07
 Aug 2023 19:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org> <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com> <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
In-Reply-To: <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
From:   Chris Maness <christopher.maness@gmail.com>
Date:   Mon, 7 Aug 2023 19:50:44 -0700
Message-ID: <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iurii Zaikin <yzaikin@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jan Karcher <jaka@linux.ibm.com>,
        Joel Granados <joel.granados@gmail.com>,
        Joel Granados <j.granados@samsung.com>,
        Joerg Reuter <jreuter@yaina.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Simon Horman <horms@verge.net.au>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Xin Long <lucien.xin@gmail.com>,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        josh@joshtriplett.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        willy@infradead.org
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

I tried running the current mainline kernel (current Arch Linux) with
simple single MUX socket (ax0) using LinFBB.  I was a happy camper as
it seemed to work fine at first, then the system just slowed to a
crawl.  I am wondering if any of these patches are addressing this
behavior.  No kernel panic like before, but not what I was hoping for.
I have also tried sixpack, and that explodes instantly the last time I
have checked.   That goes all the way back to the v4 kernels.  v2 is
fine there.

73 de Chris KQ6UP

On Mon, Aug 7, 2023 at 4:43=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> > When are these likely to hit the mainline release code?
>
> linux-next tomorrow. The first 7 patches are scheduled for mainline
> as they were merged + tested without any hiccups. These last few patches
> I'll wait and see. If nothing blows up on linux-next perhaps I'll
> include them to Linux for mainline during the next merge window.
>
>   Luis



--=20
Thanks,
Chris Maness
